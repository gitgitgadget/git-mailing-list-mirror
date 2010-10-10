From: Akira Kitada <akitada@gmail.com>
Subject: Git 1.7.3.1 cannot be built on FreeBSD 4 with gcc 2.95
Date: Sun, 10 Oct 2010 11:52:45 +0900
Message-ID: <AANLkTi=z1vqpimP_5kS_AxcVypM5Dx75p--XG8E3uSx=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 04:56:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4m5H-00046n-9r
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 04:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760503Ab0JJCxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 22:53:08 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:35535 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757370Ab0JJCxH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 22:53:07 -0400
Received: by vws2 with SMTP id 2so318400vws.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 19:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=sj+28Lcks6Z0QveUmeId4p25oi2g0XVuMJxSDi4vfXQ=;
        b=XkAoZFvCc+sEVJ2h1Vrr6AhAG6HqwQwpYKUW6WuTo0AAwtWOAGLW5R7BEzATHyypJn
         XQ1no6momyX4KxauSbnil21ouNosbWf+mVYYaze6qWoPJov09VwB/ng8FmjZ4TkJVzsT
         wXUPf/JF2YIoHMT/jFIIxBZdMCpcnTvjq7hzY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=V9RY87mTAf4dZhE8AGIw3s4Z/jmK6hryopIf0ZZLizKys+xjbX/asl42rO0TvUZR5M
         HDJmEmTNRLNhpUkn7mHsebnYdCQtkQ2DcEDaz6/jBd+VJ6UyCkwILPSAl8FXednnEiY8
         YeiQh8qv/JD6dG2+pW9KZnMNWTgISH9jADIjg=
Received: by 10.220.185.205 with SMTP id cp13mr1352950vcb.197.1286679185985;
 Sat, 09 Oct 2010 19:53:05 -0700 (PDT)
Received: by 10.220.191.73 with HTTP; Sat, 9 Oct 2010 19:52:45 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158639>

Hello,

I'm hitting the following errors during Git 1.7.3.1 build on FreeBSD 4.
I didn't see this problem when I built 1.7.0.1 so I should be
introduced in the recent versions.
Is there any reports regarding this?

Thank you

$ ./configure && gmake -j 1 V=1
...
rm -f git-add--interactive git-add--interactive+ && \
	INSTLIBDIR=`MAKEFLAGS= gmake -C perl -s --no-print-directory instlibdir` && \
	sed -e '1{' \
	    -e '	s|#!.*perl|#!/usr/bin/perl|' \
	    -e '	h' \
	    -e '	s=.*=use lib (split(/:/, $ENV{GITPERLLIB} || "'"$INSTLIBDIR"'"));=' \
	    -e '	H' \
	    -e '	x' \
	    -e '}' \
	    -e 's/@@GIT_VERSION@@/1.7.3.1/g' \
	    git-add--interactive.perl >git-add--interactive+ && \
	chmod +x git-add--interactive+ && \
	mv git-add--interactive+ git-add--interactive
'INSTALLSITEMAN3DIR' is not a known MakeMaker parameter name.
'INSTALL_BASE' is not a known MakeMaker parameter name.
Writing perl.mak for Git
'INSTALLSITEMAN3DIR' is not a known MakeMaker parameter name.
'INSTALL_BASE' is not a known MakeMaker parameter name.
Writing perl.mak for Git
gmake[2]: *** [perl.mak] Error 1
gmake[1]: *** [instlibdir] Error 2
gmake: *** [git-add--interactive] Error 2
