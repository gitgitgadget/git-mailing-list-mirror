From: Junio C Hamano <junkio@cox.net>
Subject: Re: Cannot install git RPM
Date: Wed, 10 Aug 2005 13:13:05 -0700
Message-ID: <7vk6itr1ny.fsf@assigned-by-dhcp.cox.net>
References: <20050810194459.8584D353C12@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, Chris Wright <chrisw@osdl.org>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 10 22:14:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2wwt-00014M-DB
	for gcvg-git@gmane.org; Wed, 10 Aug 2005 22:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030251AbVHJUNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 10 Aug 2005 16:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030239AbVHJUNJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Aug 2005 16:13:09 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:1689 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030251AbVHJUNH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2005 16:13:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050810201307.TTJJ12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 10 Aug 2005 16:13:07 -0400
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20050810194459.8584D353C12@atlas.denx.de> (Wolfgang Denk's
	message of "Wed, 10 Aug 2005 21:44:59 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Wolfgang Denk <wd@denx.de> writes replying to Sam Ravnborg:

> In message <20050810163202.GA11131@mars.ravnborg.org> you wrote:
>>
>> Not knowing perl at all I wonder if some more widespread used packages
>> can replace the above two?
>
> Installation of the required modules from the  CPAN  is  trivial.  It
> should be documented somewhere, though.

I would appreciate a patch for RPM building after 0.99.4, but
the tentative solution for 0.99.4 (and current "master" branch
since last night) is to ship the problematic program as part of
the sources under "contrib" status, but not install nor include
in the resulting binary package.

The dependency list for the RPM built from the tip of "rc"
branch now reads like this (thanks Chris for teaching me how to
get this information).  This will hopefully be the one that
becomes the official 0.99.4.

$ rpm -qp ~/rpms/RPMS/i386/git-core-0.99.4-1.i386.rpm --requires
/bin/sh
/usr/bin/env
/usr/bin/perl
diffutils
libc.so.6
libc.so.6(GLIBC_2.0)
libc.so.6(GLIBC_2.1)
libc.so.6(GLIBC_2.1.3)
libc.so.6(GLIBC_2.2.3)
libc.so.6(GLIBC_2.3)
libcrypto.so.4
libcurl.so.3
libssl.so.4
libz.so.1
mktemp >= 1.5
perl(File::Basename)
perl(File::Path)
perl(File::Spec)
perl(File::Temp)
perl(Getopt::Std)
perl(IO::Pipe)
perl(IO::Socket)
perl(POSIX)
perl(Time::Local)
perl(strict)
perl(warnings)
rcs
rpmlib(CompressedFileNames) <= 3.0.4-1
rpmlib(PayloadFilesHavePrefix) <= 4.0-1
rsync
sh-utils
