From: Rhys Hardwick <rhys@rhyshardwick.co.uk>
Subject: Git hangs while executing commit-tree
Date: Wed, 20 Apr 2005 22:28:35 +0100
Message-ID: <200504202228.35652.rhys@rhyshardwick.co.uk>
Reply-To: rhys@rhyshardwick.co.uk
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_DmsZCZF6S8Fuj6n"
X-From: git-owner@vger.kernel.org Wed Apr 20 23:25:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMgM-0008Gb-7B
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:24:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVDTV2n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVDTV2n
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:28:43 -0400
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35]:53845 "HELO
	smtp004.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261817AbVDTV2i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 17:28:38 -0400
Received: from unknown (HELO mail.rhyshardwick.co.uk) (rhys?hardwick@81.103.65.153 with plain)
  by smtp004.mail.ukl.yahoo.com with SMTP; 20 Apr 2005 21:28:37 -0000
Received: from [192.168.1.40] (helo=metatron.rhyshardwick.co.uk)
	by mail.rhyshardwick.co.uk with esmtpsa (TLS-1.0:RSA_ARCFOUR_MD5:16)
	(Exim 4.50)
	id 1DOMkO-0006xl-4y
	for git@vger.kernel.org; Wed, 20 Apr 2005 22:28:36 +0100
To: git@vger.kernel.org
User-Agent: KMail/1.7.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Boundary-00=_DmsZCZF6S8Fuj6n
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hey,

The following is a copy of the terminal session in question:

rhys@metatron:~/repo/tmp.repo$ ls
rhys@metatron:~/repo/tmp.repo$ init-db
defaulting to local storage area
rhys@metatron:~/repo/tmp.repo$ ls -l .git
total 4
drwxr-xr-x  258 rhys rhys 4096 2005-04-20 20:52 objects
rhys@metatron:~/repo/tmp.repo$ ls .git/objects/
00  0d  1a  27  34  41  4e  5b  68  75  82  8f  9c  a9  b6  c3  d0  dd  ea  f7
01  0e  1b  28  35  42  4f  5c  69  76  83  90  9d  aa  b7  c4  d1  de  eb  f8
02  0f  1c  29  36  43  50  5d  6a  77  84  91  9e  ab  b8  c5  d2  df  ec  f9
03  10  1d  2a  37  44  51  5e  6b  78  85  92  9f  ac  b9  c6  d3  e0  ed  fa
04  11  1e  2b  38  45  52  5f  6c  79  86  93  a0  ad  ba  c7  d4  e1  ee  fb
05  12  1f  2c  39  46  53  60  6d  7a  87  94  a1  ae  bb  c8  d5  e2  ef  fc
06  13  20  2d  3a  47  54  61  6e  7b  88  95  a2  af  bc  c9  d6  e3  f0  fd
07  14  21  2e  3b  48  55  62  6f  7c  89  96  a3  b0  bd  ca  d7  e4  f1  fe
08  15  22  2f  3c  49  56  63  70  7d  8a  97  a4  b1  be  cb  d8  e5  f2  ff
09  16  23  30  3d  4a  57  64  71  7e  8b  98  a5  b2  bf  cc  d9  e6  f3
0a  17  24  31  3e  4b  58  65  72  7f  8c  99  a6  b3  c0  cd  da  e7  f4
0b  18  25  32  3f  4c  59  66  73  80  8d  9a  a7  b4  c1  ce  db  e8  f5
0c  19  26  33  40  4d  5a  67  74  81  8e  9b  a8  b5  c2  cf  dc  e9  f6
rhys@metatron:~/repo/tmp.repo$ find . -type f
rhys@metatron:~/repo/tmp.repo$ mkdir src
rhys@metatron:~/repo/tmp.repo$ pico src/hello.c
rhys@metatron:~/repo/tmp.repo$ pico Makefile
rhys@metatron:~/repo/tmp.repo$ update-cache -add Makefile src/hello.c
fatal: unknown option -add
rhys@metatron:~/repo/tmp.repo$ update-cache --add Makefile src/hello.c
rhys@metatron:~/repo/tmp.repo$ write-tree
c80156fafbac377ab35beb076090c8320f874f91
rhys@metatron:~/repo/tmp.repo$ commit-tree 
c80156fafbac377ab35beb076090c8320f874f91
Committing initial tree c80156fafbac377ab35beb076090c8320f874f91
 


At this point, the command seems to be just waiting.  I have had it waiting 
for around 2 hours now!  I have tried removing ~/repo/tmp.repo and starting 
over, with exactly the same results.

I was testing git by following the tutorial posted by Tony Luck on this list.  
I updated and built the latest version of git, using git, at around 2000 GMT 
today.  I have attached the Makefile and hello.c if anyone finds them useful.

Thanks for any help,

Rhys

--Boundary-00=_DmsZCZF6S8Fuj6n
Content-Type: text/x-makefile;
  charset="us-ascii";
  name="Makefile"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Makefile"

hello: src/hello.c
	cc -o hello -O src/hello.c


--Boundary-00=_DmsZCZF6S8Fuj6n
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="hello.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="hello.c"

#include <stdio.h>

main()
{
	printf("Hello, world!\n");
}

--Boundary-00=_DmsZCZF6S8Fuj6n--


