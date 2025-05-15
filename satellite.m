clear all;
clc;
format compact;

%Αρχικοποιηση της Gp

arithmitis = [10];
paronomasths=[1 10 9];

Gp = tf(arithmitis , paronomasths)

i=1;

while i<100
  %Αρχικοποιηση της Gc
    arithmitis2 = [1*i 1*i];
    paronomasths2=[1 0];
    Gc = tf(arithmitis2 , paronomasths2)
    
    Sys = series(Gc,Gp);
    
    %Δημιουργια κλειστού βρόγχουμε feedback
    closed_loop = series(10*i, feedback(Sys, 1, -1))
    
    info = stepinfo(closed_loop);
    
    %Έλεγχος περιορισμών
    if (info.Overshoot < 0.07 && info.RiseTime < 0.9)
        i = 101;
    end
    
    i=i+1;
    
end

fprintf("Overshoot: %.3f %%\n", info.Overshoot);
fprintf("Rise Time: %.3f sec\n", info.RiseTime);
figure
rlocus(Sys);
figure
step(closed_loop);

