From: Gerry Reno <greno@verizon.net>
Subject: git 2.1.0: make fails
Date: Tue, 09 Sep 2014 16:34:02 -0400
Message-ID: <540F643A.60207@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 09 23:34:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRT3k-00029Z-Je
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 23:34:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752400AbaIIVek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 17:34:40 -0400
Received: from vms173023pub.verizon.net ([206.46.173.23]:51485 "EHLO
	vms173023pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbaIIVek (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 17:34:40 -0400
X-Greylist: delayed 3607 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Sep 2014 17:34:39 EDT
Received: from renog13-lin01.localdomain ([unknown] [71.122.175.81])
 by vms173023.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0NBN008UQIGQDO90@vms173023.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 09 Sep 2014 15:34:03 -0500 (CDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625
 Thunderbird/17.0.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256710>

Downloaded the git-2.1.0.tar.gz  tarball.

Cannot build git 2.1.0:

    $ V=1 make prefix=/usr/local all
    ...
    cc -o xdiff/xpatience.o -c -MF xdiff/.depend/xpatience.o.d -MQ xdiff/xpatience.o -MMD -MP  -g -O2 -Wall -I.
    -DHAVE_ALLOCA_H  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY
    -DNO_MKSTEMPS -DSHELL_PATH='"/bin/sh"'  xdiff/xpatience.c
    cc -o xdiff/xhistogram.o -c -MF xdiff/.depend/xhistogram.o.d -MQ xdiff/xhistogram.o -MMD -MP  -g -O2 -Wall -I.
    -DHAVE_ALLOCA_H  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY
    -DNO_MKSTEMPS -DSHELL_PATH='"/bin/sh"'  xdiff/xhistogram.c
    rm -f xdiff/lib.a && ar rcs xdiff/lib.a xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o xdiff/xmerge.o
    xdiff/xpatience.o xdiff/xhistogram.o
    cc  -g -O2 -Wall -I. -DHAVE_ALLOCA_H  -DHAVE_PATHS_H -DHAVE_DEV_TTY -DHAVE_CLOCK_GETTIME
    -DSHA1_HEADER='<openssl/sha.h>'  -DNO_STRLCPY -DNO_MKSTEMPS -DSHELL_PATH='"/bin/sh"' -o git-credential-store  
    credential-store.o libgit.a xdiff/lib.a  -lz  -lcrypto -lpthread -lrt
    collect2: ld returned 1 exit status
    make: *** [git-credential-store] Error 1


    $ ls -l credential.o libgit.a xdiff/lib.a /usr/lib/libz.a /usr/lib/libcrypt.a /usr/lib/libpthread.a /usr/lib/librt.a
    -rw-rw-r-- 1 greno greno   20332 Sep  9 16:21 credential.o
    -rw-rw-r-- 1 greno greno 4658874 Sep  9 16:23 libgit.a
    -rw-r--r-- 1 root  root    24272 Jan  5  2007 /usr/lib/libcrypt.a
    -rw-r--r-- 1 root  root   228586 Jan  5  2007 /usr/lib/libpthread.a
    -rw-r--r-- 1 root  root    52128 Jan  5  2007 /usr/lib/librt.a
    -rwxr-xr-x 1 root  root    92622 Jul 19  2006 /usr/lib/libz.a
    -rw-rw-r-- 1 greno greno  122456 Sep  9 16:23 xdiff/lib.a
