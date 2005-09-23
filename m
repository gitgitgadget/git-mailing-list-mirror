From: Peter TB Brett <peter@peter-b.co.uk>
Subject: git 0.99.7b doesn't build on Cygwin
Date: 23 Sep 2005 14:33:46 +0100
Message-ID: <ud5mznc1x.fsf@peter-b.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Sep 23 15:36:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIngj-0007GS-49
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 15:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750986AbVIWNd7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 09:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbVIWNd7
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 09:33:59 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:48177 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750986AbVIWNd7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 09:33:59 -0400
Received: from aamta10-winn.ispmail.ntl.com ([81.103.221.35])
          by mta09-winn.ispmail.ntl.com with ESMTP
          id <20050923133346.NAQQ9239.mta09-winn.ispmail.ntl.com@aamta10-winn.ispmail.ntl.com>
          for <git@vger.kernel.org>; Fri, 23 Sep 2005 14:33:46 +0100
Received: from VIMES ([82.9.228.97]) by aamta10-winn.ispmail.ntl.com
          with ESMTP
          id <20050923133346.KVKS6183.aamta10-winn.ispmail.ntl.com@VIMES>
          for <git@vger.kernel.org>; Fri, 23 Sep 2005 14:33:46 +0100
To: git@vger.kernel.org
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9191>


Hi folks,

I wanted to use git on a Windows-based project (yes, there are some
out there still), so I fired up my Cygwin xterm, untarred the git
sources and totally failed to succeed in building them:

                              ---- ----

$ make
gcc -o apply.o -c -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' apply.c
gcc -o blob.o -c -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' blob.c
gcc -o commit.o -c -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' commit.c
gcc -o connect.o -c -g -O2 -Wall  '-DSHA1_HEADER=<openssl/sha.h>' connect.c
connect.c: In function `git_tcp_connect':
connect.c:298: error: storage size of 'hints' isn't known
connect.c:322: warning: implicit declaration of function `getaddrinfo'
connect.c:324: warning: implicit declaration of function `gai_strerror'
connect.c:324: warning: format argument is not a pointer (arg 3)
connect.c:326: error: dereferencing pointer to incomplete type
connect.c:327: error: dereferencing pointer to incomplete type
connect.c:327: error: dereferencing pointer to incomplete type
connect.c:327: error: dereferencing pointer to incomplete type
connect.c:330: error: dereferencing pointer to incomplete type
connect.c:330: error: dereferencing pointer to incomplete type
connect.c:338: warning: implicit declaration of function `freeaddrinfo'
connect.c:298: warning: unused variable `hints'
make: *** [connect.o] Error 1

$ gcc --version
gcc (GCC) 3.4.4 (cygming special) (gdc 0.12, using dmd 0.125)
...

                              ---- ----

It looks like the sort of problems I get when I'm missing header
files, but all the headers #included by connect.c are present on my
system, so I'm really not sure what's going on there...

Peter


P.S. Please Cc: me on any replies, I'm not subscribed to the list.


-- 
Quake II build tools:  http://peter-b.co.uk/
Latest QuArK:          http://quark.sourceforge.net/LatestVersion

v2sw6YShw7ln5pr6ck3ma8u7Lw3+2m0l7CFi6e4+8t4Eb8Aen4g6Pa2Xs5MSr5p4
  hackerkey.com
