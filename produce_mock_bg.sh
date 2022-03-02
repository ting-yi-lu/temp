#!/bin/bash

#PURPOSE: produce mock Wobs for different xhi, different mmin (detection limit). 

#============ parameter setup ============ 
#nmockdataset=50 #generate 50 mock data files (for each xhi)

xhilist=(0.02 0.06 0.13 0.19 0.25 0.31 0.37 0.42 0.47 0.52 0.57 0.60 0.64 0.68 0.71 0.74 0.77 0.80 0.82 0.84 0.86 0.87 0.89 0.90 0.92 0.93 0.94 0.95) # The xHI for mock data (this is the same xhi list as the BrightGals sim) 
mmin=28.5 # the magnitude limit for mock data
echo "xhilist="${xhilist[@]} #print xHI list
#=========================================

cd ~/erda_mount/GitHub/LyaInference/scripts/ # cd to the directory of prepare_data.py

for xhi in  ${xhilist[@]}; do  
    echo "xHI=${xhi},Mmin=${mmin}" # print the xHI and mmin setup for the mock data I am generating 
    for i in {1..50} # create 50 mock data files
    do
        if [ ${i} -lt 10 ] # if i<10, add a 0 before i (1->01, 2->02, etc.)
        then
            cmd="python prepare_data.py --xHI ${xhi} --Ndraw=68 --brightgals --pWtype M18[med] --mmin=${mmin} --suffix testbg_xHI${xhi}_Mmin${mmin}_0${i} --dir_run /home/csr396_ku_dk/erda_mount/GitHub/LyaInference/file_out/mock_bg/"     # the command I want to run
        else
            cmd="python prepare_data.py --xHI ${xhi} --Ndraw=68 --brightgals --pWtype M18[med] --mmin=${mmin} --suffix testbg_xHI${xhi}_Mmin${mmin}_${i} --dir_run /home/csr396_ku_dk/erda_mount/GitHub/LyaInference/file_out/mock_bg/"
        fi 
        echo "running: "${cmd} # print the command I am running 
        eval $cmd # run the command 
    done
done