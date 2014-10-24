From: "Lyle Ziegelmiller" <lyle_z@hotmail.com>
Subject: [BUG]
Date: Fri, 24 Oct 2014 08:42:17 -0700
Message-ID: <SNT153-DS18781DF19244300BBD9668F6930@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 24 17:41:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xhgzv-0005K3-UU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 17:41:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbaJXPlr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2014 11:41:47 -0400
Received: from snt004-omc3s9.hotmail.com ([65.55.90.148]:57422 "EHLO
	SNT004-OMC3S9.hotmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751482AbaJXPlq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 11:41:46 -0400
Received: from SNT153-DS18 ([65.55.90.137]) by SNT004-OMC3S9.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.22751);
	 Fri, 24 Oct 2014 08:41:45 -0700
X-TMN: [vi9eCfF757ws7Rl1wnIxRVJoJNkLqKdY]
X-Originating-Email: [lyle_z@hotmail.com]
X-Priority: 3
X-MSMail-Priority: Normal
Importance: Normal
X-Mailer: Microsoft Windows Live Mail 16.4.3528.331
X-MimeOLE: Produced By Microsoft MimeOLE V16.4.3528.331
X-OriginalArrivalTime: 24 Oct 2014 15:41:45.0323 (UTC) FILETIME=[0404CBB0:01CFEFA1]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello

I've been attempting to use Cygwin's Git version 2.1.1 to manage pictures on 
my 32-bit PC and my 64-bit laptop, both running Windows 7. I downloaded the 
correct 32/64-bit version of Cygwin on both machines. In my pictures folder 
on my PC, I created a git repository and did an "git add .", etc., and then 
created a bare repository which I then attempted to clone on my laptop. It 
cloned, but did not include all the pictures. I redid the "git add .", 
commit, and push on my PC, and then redid the pull on my laptop, but it 
still was missing some pictures. Per advice from the internet, I then did a 
"git reset --hard FETCH_HEAD" on my laptop, and that is what caused the 
Segmentation fault (core dumped)4007). I repeated all of my steps, and the 
segmentation fault happened again each time, so I don't think it was a 
fluke.

Here's the git.exe.stackdump output:

Exception: STATUS_ACCESS_VIOLATION at rip=003FD3C8362
rax=0000000000000048 rbx=00000000FFFE0000 rcx=000006F0737BF9C2
rdx=0000000000000007 rsi=0000000000000027 rdi=000006F0D8BB6ED0
r8 =000006F0737BFFFE r9 =0000000000000001 r10=00000006001F0F70
r11=00000006001F0A20 r12=000006F0737C0001 r13=000006F0737BF9C5
r14=0000000000225370 r15=000006F0737B030F
rbp=00000006001F18C8 rsp=0000000000225170
program=C:\cygwin64\bin\git.exe, pid 3100, thread main
cs=0033 ds=002B es=002B fs=0053 gs=002B ss=002B
Stack trace:
Frame Function Args
006001F18C8 003FD3C8362 (00040000000, 00000225370, 00000001BF0, 006001F0A94)
006001F0AA8 003FD3C9E8C (0010049F048, 0041E6FAEC9, 00000225370, 0041E6FAEC9)
00000000000 0010049F35A (00000000020, 00000225384, 000000D0401, 003EC9D3E1B)
00000225510 001004A42FC (001FFFFFFFF, 00000000002, 001800C614E, 00600063121)
00000000001 001004A5929 (001800434AD, 000000E0000, 6F0737C0000, 0041E6FAEC5)
00000225DC4 001004A50C5 (000801283E5, 000000080E0, 000000080E0, 0060019F464)
006002BCB08 001004A519E (00000000000, 00000000000, 6F0737C0010, 00000000000)
006002BCB08 001004A62A3 (001005286A0, 00000225DC8, 00000225D20, 00000225D20)
001005286A0 001004DC00A (00600266690, 00000000000, 00600266690, 00000000000)
001005286A0 001004DC697 (00000225F10, 00000000000, 00300000000, 00300000000)
0060025F320 001004DC7F2 (006000286D8, 000000001FF, 001005AFDF0, 001802BFC80)
0060025F320 001004AA198 (00180175907, 00000000000, 0018016E756, 0006E1C32D0)
0060019F420 001004AA670 (00180076C02, 00200000000, 00000001215, 
F4F5ACCFAEC71FDC)
0060019F420 001004E311E (0000022A520, 0060006D3C0, 00000000000, 0000022A200)
0000022A4C0 00100462FC4 (00000000000, 00000000003, 00000000000, 0000022AB30)
001802E3BF0 001004639BD (001800C0E53, 00000000000, 00000000000, 00000000000)
End of stack trace (more stack frames may be present)

I tried debugging it with gdb, but without the symbol table, I don't think 
it will help much:

$ gdb git
GNU gdb (GDB) 7.8
Copyright (C) 2014 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later http://gnu.org/licenses/gpl.html
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law. Type "show copying"
and "show warranty" for details.
This GDB was configured as "x86_64-pc-cygwin".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
http://www.gnu.org/software/gdb/bugs/.
Find the GDB manual and other documentation resources online 
at:http://www.gnu.org/software/gdb/documentation/.
For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from git...(no debugging symbols found)...done.
(gdb) run reset --hard FETCH_HEAD
Starting program: /usr/bin/git reset --hard FETCH_HEAD
[New Thread 3860.0x1870]
[New Thread 3860.0x16e4]
fatal: Unable to create '/cygdrive/c/Users/lylez/pictures/.git/index.lock': 
File exists.
If no other git process is currently running, this probably means a
git process crashed in this repository earlier. Make sure no other git
process is running and remove the file manually to continue.
[Inferior 1 (process 3860) exited with code 0200]

I deleted index.log, and tried again:

(gdb) run reset --hard FETCH_HEAD
Starting program: /usr/bin/git reset --hard FETCH_HEAD
[New Thread 5272.0x894]
[New Thread 5272.0xc38]
[New Thread 5272.0x1ba8]
Checking out files: 36% (5070/14007)
Program received signal SIGSEGV, Segmentation fault.
0x00000003fd3c836a in inflateBackEnd () from /usr/bin/cygz.dll
(gdb) backtrace
#0 0x00000003fd3c836a in inflateBackEnd () from /usr/bin/cygz.dll
#1 0x00000003fd3c9e8c in inflate () from /usr/bin/cygz.dll
#2 0x000000010049f35a in ?? ()
#3 0x00000001004a42fc in ?? ()
#4 0x00000001004a5929 in ?? ()
#5 0x00000001004a50c5 in ?? ()
#6 0x00000001004a519e in ?? ()
#7 0x00000001004a62a3 in ?? ()
#8 0x00000001004dc00a in ?? ()
#9 0x00000001004dc697 in ?? ()
#10 0x00000001004dc7f2 in ?? ()
#11 0x00000001004aa198 in ?? ()
#12 0x00000001004aa670 in ?? ()
#13 0x00000001004e311e in ?? ()
#14 0x0000000100462fc4 in ?? ()
#15 0x00000001004639bd in ?? ()
#16 0x0000000100401a33 in ?? ()
#17 0x0000000100521301 in ?? ()
#18 0x00000001800482e1 in _cygwin_exit_return () from /usr/bin/cygwin1.dll
#19 0x000000018004619b in _cygtls::call2(unsigned int ()(void, void*), 
void*, void*) ()
from /usr/bin/cygwin1.dll
#20 0x00000001800462f4 in _cygtls::call(unsigned int ()(void, void*), void*) 
() from /usr/bin/cygwin1.dll
#21 0x00000001005200b1 in ?? ()
---Type to continue, or q to quit---
#22 0x0000000100401010 in ?? ()
#23 0x0000000077b259ed in KERNEL32!BaseThreadInitThunk () from 
/cygdrive/c/Windows/system32/kernel32.dll
#24 0x0000000077c5c541 in ntdll!RtlUserThreadStart () from 
/cygdrive/c/Windows/SYSTEM32/ntdll.dll
#25 0x0000000000000000 in ?? ()
Backtrace stopped: previous frame inner to this frame (corrupt stack?)
(gdb) frame 0
#0 0x00000003fd3c836a in inflateBackEnd () from /usr/bin/cygz.dll
(gdb)

Also, commits are in some cases taking in excess of 20 minutes, both at home 
with my pictures folder, also at work with a large repository. Surely 
something can be done about this.

thanks


Lyle
