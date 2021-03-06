
clear all

%Ordet som testas
[test,fs] = audioread('testperson.wav'); 

figure
nfft = 500;
window = hamming(nfft);
spectrogram(test(:,1), window, [], nfft, fs,'xaxis'), view([90 -90])

%Referensord. Tre olika, en fr?n varje projektmedlem. 
[referensord1,fs] = audioread('hej1.wav'); 
[referensord2,fs] = audioread('hej2.wav');
[referensord3,fs] = audioread('hej3.wav');
[referensord4,fs] = audioread('skamt1.wav');
[referensord5,fs] = audioread('skamt2.wav');
[referensord6,fs] = audioread('skamt3.wav');
[referensord7,fs] = audioread('datum1.wav');
[referensord8,fs] = audioread('datum2.wav');
[referensord9,fs] = audioread('datum3.wav');

%Ordlista med referensorden f?r att kunna skriva ut ordet som matchar b?st:
ord = ["hej" , "hej" , "hej" , "skamt" , "skamt" , "skamt" , "datum" , "datum", "datum"];

coeffs = 14; % 1-14. Antalet MFCC-koefficienter som anv?nds. H?r kan det kanske l?na sig att experimentera lite med hur m?nga som tas med.

%Ber?kna MFCC f?r testordet:
testcoeffs = mfcc(test,fs);
testfirstcoeffs = transpose(testcoeffs(:,1:coeffs));

%Ber?kna MFCC f?r referensorden (borde egentligen vara n?gon funktion och loop)

ref1coeffs = mfcc(referensord1,fs);
ref1firstcoeffs = transpose(ref1coeffs(:,1:coeffs));

ref2coeffs = mfcc(referensord2,fs);
ref2firstcoeffs = transpose(ref2coeffs(:,1:coeffs));

ref3coeffs = mfcc(referensord3,fs);
ref3firstcoeffs = transpose(ref3coeffs(:,1:coeffs));

ref4coeffs = mfcc(referensord4,fs);
ref4firstcoeffs = transpose(ref4coeffs(:,1:coeffs));

ref5coeffs = mfcc(referensord5,fs);
ref5firstcoeffs = transpose(ref5coeffs(:,1:coeffs));

ref6coeffs = mfcc(referensord6,fs);
ref6firstcoeffs = transpose(ref6coeffs(:,1:coeffs));

ref7coeffs = mfcc(referensord7,fs);
ref7firstcoeffs = transpose(ref7coeffs(:,1:coeffs));

ref8coeffs = mfcc(referensord8,fs);
ref8firstcoeffs = transpose(ref8coeffs(:,1:coeffs));

ref9coeffs = mfcc(referensord9,fs);
ref9firstcoeffs = transpose(ref9coeffs(:,1:coeffs));

   
%ber?kna avst?nden mellan testord och de olika j?mf?relseorden med hj?lp av Dynamic Time Warping
dist_ref1 = dtw(testfirstcoeffs,ref1firstcoeffs);
dist_ref2 = dtw(testfirstcoeffs,ref2firstcoeffs);
dist_ref3 = dtw(testfirstcoeffs,ref3firstcoeffs);
dist_ref4 = dtw(testfirstcoeffs,ref4firstcoeffs);
dist_ref5 = dtw(testfirstcoeffs,ref5firstcoeffs);
dist_ref6 = dtw(testfirstcoeffs,ref6firstcoeffs);
dist_ref7 = dtw(testfirstcoeffs,ref7firstcoeffs);
dist_ref8 = dtw(testfirstcoeffs,ref8firstcoeffs);
dist_ref9 = dtw(testfirstcoeffs,ref9firstcoeffs);

%ordet med minsta avst?ndet skrivs ut: 
distansvektor = [dist_ref1 dist_ref2 dist_ref3 dist_ref4 dist_ref5 dist_ref6 dist_ref7 dist_ref8 dist_ref9];
[distans,ordnummer] = min([distansvektor]);

ordsagt = ord(ordnummer);

%If satser f?r varje ord 

%Hej
if (ordsagt == "hej")

antal_halsningar = 4;
r = randi(antal_halsningar);
halsning = ['halsning', num2str(r),'.wav'];
[halsning_ljud, fs] = audioread(halsning);

sound(halsning_ljud, fs);

if halsning == ['halsning', num2str(1),'.wav']
    disp("Hej, hur ?r l?get?");

elseif halsning == ['halsning', num2str(2),'.wav']
    disp("Hej, hur m?r du?");
    
elseif halsning == ['halsning', num2str(3),'.wav']
    disp("Tjenare!");
    
elseif halsning == ['halsning', num2str(4),'.wav']
    disp("Hej p? dig!");
         
end 


%Sk?mt
elseif(ordsagt == "skamt")

antal_skamt = 4;
r = randi(antal_skamt);
skamt = ['ordvits', num2str(r),'.wav'];

[skamtljud, fs] = audioread(skamt);

sound(skamtljud, fs);

if skamt == ['ordvits', num2str(1),'.wav']
    disp("Vilket land kan minst?- Kan-nada");

elseif skamt == ['ordvits', num2str(2),'.wav']
    disp("Katt ?t linjal, blev m?tt");
    
elseif skamt == ['ordvits', num2str(3),'.wav']
    disp("Katt ?t sko, fick sparken");
       
elseif skamt == ['ordvits', num2str(4),'.wav']
    disp("Vad blir man om man ?ter en gl?dlampa? - L?s i magen.");
        
end 

%Datum
elseif (ordsagt == "datum")
    
datum = date;
[y,Fs] = audioread('datum.wav');
sound(y,Fs);
X = [' Dagens datum ?r: ', datum,];
disp(X)

end

