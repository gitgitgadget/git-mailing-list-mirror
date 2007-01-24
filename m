From: SungHyun Nam <goweol@gmail.com>
Subject: GIT+CYGWIN annoying test failure
Date: Wed, 24 Jan 2007 11:18:35 +0900
Message-ID: <45B6C1FB.7060005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 03:19:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9Xj4-00066d-OD
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 03:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965621AbXAXCSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 21:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965622AbXAXCSs
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 21:18:48 -0500
Received: from relaygw1.kornet.net ([61.74.75.196]:44711 "EHLO
	relaygw1.kornet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965621AbXAXCSr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 21:18:47 -0500
Received: from [211.48.62.134] ([211.48.62.134]) 
          by relaygw1.kornet.net ([61.74.75.196]) 
          with ESMTP id 2007012411:18:41:424963.19779.7855024
          Wed, 24 Jan 2007 11:18:41 +0900 (KST) 
Received: from [211.221.139.210] ([211.221.139.210]) 
          by relay7.kornet.net ([211.48.62.134]) 
          with ESMTP id 2007012411:18:39:981862.11741.45747120
          Wed, 24 Jan 2007 11:18:39 +0900 (KST) 
User-Agent: Thunderbird 2.0b1 (Windows/20061223)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.1.2
OpenPGP: id=8509C67F
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37597>

Hello,

First of all, this problem always existed to me. I was lazy to report.
Please check the failure logs and my GIT build script below.
My build script runs 'make test' twice because of this annoying failure.
It does not mean that the first test always failed, but very often.
If it occurs, the first test failed at 't1000-read-tree-m-3way.sh'
always. And in this case, 2nd test always succeeded.

Thanks,

GIT test failure logs
====================================================================

2007-01-15
==============================================================================
GIT_VERSION = 1.5.0.rc1.gf4b6c-dirty

...
* FAIL 57: 5 - must match in !O && A && B && A==B case.
        rm -f .git/index LL &&
             cp .orig-A/LL LL &&
             git-update-index --add LL &&
             echo extra >>LL &&
             git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
             check_result
...
* FAIL 62: 9 - must match and be up-to-date in O && A && !B && O!=A case
        rm -f .git/index MD &&
             cp .orig-A/MD MD &&
             git-update-index --add MD &&
             git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
             check_result
...
* FAIL 65: 10 - must match and be up-to-date in O && A && !B && O==A case
        rm -f .git/index ND &&
             cp .orig-A/ND ND &&
             git-update-index --add ND &&
             git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
             check_result
...
* failed 3 among 83 test(s)
make[1]: *** [t1000-read-tree-m-3way.sh] Error 1
make[1]: Leaving directory `/c/user/namsh/unix/git/t'
make: *** [test] Error 2


2007-01-18
==============================================================================
GIT_VERSION = 1.5.0.rc1.g556b-dirty

...
* FAIL 50: 3 - must match A in !O && A && !B case.
        rm -f .git/index AN &&
             cp .orig-A/AN AN &&
             git-update-index --add AN &&
             git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
             check_result
...
* FAIL 53: 4 - must match and be up-to-date in !O && A && B && A!=B case.
        rm -f .git/index AA &&
             cp .orig-A/AA AA &&
             git-update-index --add AA &&
             git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
             check_result
...
* failed 2 among 83 test(s)
make[1]: *** [t1000-read-tree-m-3way.sh] Error 1
make[1]: Leaving directory `/c/user/namsh/unix/git/t'
make: *** [test] Error 2

2007-01-24
==============================================================================
GIT_VERSION = 1.5.0.rc2.gc9a89-dirty

...
* FAIL 50: 3 - must match A in !O && A && !B case.
        rm -f .git/index AN &&
             cp .orig-A/AN AN &&
             git-update-index --add AN &&
             git-read-tree -m 3fe085e0589de4327971d50e416fc292dd00fbfe
997bbc4a0a51e0574168a4f637739380edebe4d7
76d47d681d7f1d4fa975334a9a0ba8a6eeea2226 &&
             check_result
...
* failed 1 among 83 test(s)
make[1]: *** [t1000-read-tree-m-3way.sh] Error 1
make[1]: Leaving directory `/c/user/namsh/unix/git/t'
make: *** [test] Error 2



GIT build script
====================================================================
	...
	if test ! -r ./configure || test ./configure.ac -nt ./configure
	then
	    printf "Run autoconf..."
	    autoconf
	    echo " DONE!"
	fi
	if test ! -r ./config.mak.autogen \
	    || test ./configure -nt ./config.mak.autogen
	then
	    ./configure --prefix=$prefix
	fi

	# generate personal configuration makefile
	[ -r config.mak ] && rm -f config.mak
	touch config.mak
	[ -r config.mak ] || die "Cannot generate config.mak"
	$E "CFLAGS=$CFLAGS" >> config.mak
	$E "DESTDIR=$DESTDIR" >> config.mak
	# git's configure script could not find the libiconv for CYGWIN.
	$E "NEEDS_LIBICONV=1\nNO_ICONV=" >> config.mak
	$E "NO_PERL_MAKEMAKER=1" >> config.mak # have no PERL MakeMaker
	$E "NO_TRUSTABLE_FILEMODE=" >> config.mak # default filemode = true
	# FAT32 has issues with 'mmap', but I only have NTFS.
	$E "NO_MMAP=" >> config.mak

	if make all doc
	then
	    # I don't use CVS/Subversion. So skip those tests.
	    export GIT_SKIP_TESTS='t91?? t92??'
	    if ! make test
	    then
		${E} "\n*** ${R}Test failed${N} ***\n"

		# I don't know why... Sometimes first 'make test' failed.
		printf "Try again... "
		if ! make test >/dev/null 2>&1
		then
		    die "2nd test failed also."
		fi
		printf "OK!"
	    fi

	    rm -f "$gitLog"
	    if ! make install install-doc > "$gitLog" 2>&1
	    then
		die "Install failed. Check $gitLog"
	    fi
	    rm -f "$gitLog"
	    ...
	fi
