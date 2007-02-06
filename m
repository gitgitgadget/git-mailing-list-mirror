From: Han-Wen Nienhuys <hanwen@xs4all.nl>
Subject: Re: MinGW port now supports native git protocol
Date: Tue, 06 Feb 2007 15:42:15 +0100
Message-ID: <45C893C7.6050001@xs4all.nl>
References: <45C6F2F6.ADFE0A13@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 06 15:42:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HERWc-0001mw-Ag
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 15:42:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751519AbXBFOmT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 09:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbXBFOmT
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 09:42:19 -0500
Received: from main.gmane.org ([80.91.229.2]:43148 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbXBFOmS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 09:42:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HERWO-0003Iw-JB
	for git@vger.kernel.org; Tue, 06 Feb 2007 15:42:12 +0100
Received: from muurbloem.xs4all.nl ([213.84.26.127])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 15:42:12 +0100
Received: from hanwen by muurbloem.xs4all.nl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Feb 2007 15:42:12 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: muurbloem.xs4all.nl
User-Agent: Thunderbird 1.5.0.9 (X11/20070130)
In-Reply-To: <45C6F2F6.ADFE0A13@eudaptics.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38843>

Johannes Sixt escreveu:
> Thanks to H. Peter Anvin's tips, the MinGW port now also supports clone,
> fetch, pull via the native git protocol. Visit
> 
> gitweb:     http://repo.or.cz/w/git/mingw.git
> Clone/pull: git://repo.or.cz/git/mingw.git
> A Readme:
> http://repo.or.cz/w/git/mingw.git?a=blob_plain;f=README.MinGW;hb=master
> 
> Please try branch 'master' first, and if this does not compile or does
> not work in some way, try branch 'devel', which contains a few extra
> patches that I need on my system to make it work.


Out of curiosity (and probably: repressed masochism), I decided to
give this a whirl inside my cross-building environment.

Trying to build this yields

building package: mingit
 *** Stage: compile (mingit)
invoking cd /home/lilydev/vc/gub/target/mingw/build/mingit-master-repo.or.cz-git-mingw.git && make -j2 
i686-mingw32-gcc -mwindows -mms-bitfields -o fetch-pack.o -c -g -O2  -DNO_OPENSSL -DNO_D_TYPE_IN_DIRENT -DNO_C99_FORMAT -DNO_IPV6 -Dsockaddr_storage=sockaddr_in -DNO_ICONV -DSHA1_HEADER='"mozilla-sha1/sha1.h"' -DNO_STRCASESTR -DNO_STRLCPY -DNO_SETENV fetch-pack.c
i686-mingw32-gcc -mwindows -mms-bitfields -o blob.o -c -g -O2  -DNO_OPENSSL -DNO_D_TYPE_IN_DIRENT -DNO_C99_FORMAT -DNO_IPV6 -Dsockaddr_storage=sockaddr_in -DNO_ICONV -DSHA1_HEADER='"mozilla-sha1/sha1.h"' -DNO_STRCASESTR -DNO_STRLCPY -DNO_SETENV blob.c
In file included from cache.h:4,
                 from fetch-pack.c:1:
git-compat-util.h:39:21: error: fnmatch.h: No such file or directory
git-compat-util.h:48:19: error: netdb.h: No such file or directory
git-compat-util.h:49:17: error: pwd.h: No such file or directory
git-compat-util.h:52:17: error: grp.h: No such file or directory
git-compat-util.h:105:22: error: sys/mman.h: No such file or directory


(etc)

Are you sure that this builds with Mingw only? I have

binutils            2.16.1
gcc                 4.1.1
regex               2.3.90-1
w32api              3.6
zlib                1.2.2
libtool             1.5.20
mingw-runtime       3.9


where are these headers supposed to come from?

 




-- 
 Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
