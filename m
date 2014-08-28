From: dev <dev@cor0.com>
Subject: make install fails because GNU tar needed
Date: Thu, 28 Aug 2014 10:16:48 -0400 (EDT)
Message-ID: <267282067.24350.1409235408562.JavaMail.vpopmail@webmail2.networksolutionsemail.com>
Reply-To: dev <dev@cor0.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 16:17:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XN0Vg-00080d-8G
	for gcvg-git-2@plane.gmane.org; Thu, 28 Aug 2014 16:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbaH1ORA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2014 10:17:00 -0400
Received: from atl4mhob02.myregisteredsite.com ([209.17.115.40]:52934 "EHLO
	atl4mhob02.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751117AbaH1OQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Aug 2014 10:16:59 -0400
Received: from atl4oxapp02pod2.mgt.hosting.qts.netsol.com ([10.30.77.38])
	by atl4mhob02.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s7SEGmKn009857;
	Thu, 28 Aug 2014 10:16:48 -0400
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v6.20.7-Rev18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256083>



Well I am making progress in that I have what looks like a
successful build.

what fails next on the non-linux world is the next requirement for
GNU tar for some reason :

# gmake CFLAGS="$CFLAGS" LDFLAGS="$LD_OPTIONS" NEEDS_LIBICONV=Yes \
> SHELL_PATH=/usr/local/bin/bash \
> SANE_TOOL_PATH=/usr/local/bin \
> USE_LIBPCRE=1 LIBPCREDIR=/usr/local CURLDIR=/usr/local \
> EXPATDIR=/usr/local NEEDS_LIBINTL_BEFORE_LIBICONV=1 \
> NEEDS_SOCKET=1 NEEDS_RESOLV=1 USE_NSEC=1 \
> PERL_PATH=/usr/local/bin/perl \
> NO_PYTHON=1 DEFAULT_PAGER=/usr/xpg4/bin/more \
> DEFAULT_EDITOR=/usr/local/bin/vim DEFAULT_HELP_FORMAT=man \
> prefix=/usr/local install >
> ../git-2.0.4_SunOS5.10_sparcv9.006.install.log
    * new build flags
"read-cache.c", line 780: warning: statement not reached
"xdiff/xutils.c", line 180: warning: statement not reached
Writing perl.mak for Git
Writing MYMETA.yml and MYMETA.json
/bin/sh: gtar: /bin/shnot found
: gtar: not found
gmake[1]: *** [install] Error 1
gmake: *** [install] Error 2


Well that is maddening.

Is there some magic somewhere to use ordinary POSIX tar ?

Also, what is shnot ?

dev
