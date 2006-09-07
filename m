From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Cygwin playbook?
Date: Thu, 7 Sep 2006 19:18:10 +1200
Message-ID: <46a038f90609070018k319b748cmae7a9b30da45b3b6@mail.gmail.com>
References: <46a038f90609062159v3858a771t38355ed60867ccfc@mail.gmail.com>
	 <7v7j0g40xh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 09:18:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLE9P-0004RQ-T9
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 09:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWIGHSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 03:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750874AbWIGHSN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 03:18:13 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:49366 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750791AbWIGHSL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 03:18:11 -0400
Received: by nf-out-0910.google.com with SMTP id o25so386102nfa
        for <git@vger.kernel.org>; Thu, 07 Sep 2006 00:18:10 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cGUgziGcB1yGDwnQtiwIVmGhq3l4YmUPaJuyA+dEXa7yxObstEuWsL+YMxOHygeOQZBEMTFWSdLauecjrqnc3vkOJVVqpV/Kg99GgijnuniBJ1ElkINrmEBJBUniJEml9WedpyyJuIj/55aYT0t2hCaxEo/YvWB7DyeqK55jvGg=
Received: by 10.48.242.19 with SMTP id p19mr2148046nfh;
        Thu, 07 Sep 2006 00:18:10 -0700 (PDT)
Received: by 10.49.6.16 with HTTP; Thu, 7 Sep 2006 00:18:10 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v7j0g40xh.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26608>

On 9/7/06, Junio C Hamano <junkio@cox.net> wrote:
> "Martin Langhoff" <martin.langhoff@gmail.com> writes:
>
> > - What cygwin packages are needed?
>
> I am not in front of Windows machine so I need to check later if
> nobody beats me to this, but essentially it is the same as on
> sane Unix systems.  Cygwin folks did a good job providing
> necessary libraries readily available from their Setup.exe.

Sorry to ask this... Are you sure? Vanilla base setup with no extra
packages getting gcc and various -dev packages? Perhaps there is a
'developer' profile during install that gets you a reasonable kit?

About 5 minutes ago I managed to get limited access (non-root, cannot
install packages) to a cygwin env using rdesktop. It did have gcc and
make, but make bombed out with a missing libcurl and openssl header
files. IIRC, diff3/merge isn't in the base install either.

In debian I can look at apt-cache show git-core to get a quick
overview of dependencies but here I'm lost :(

> > - Need to fudge makefile?
>
> No; not even autoconf was needed and it installed out of the box
> for me (w2k).

That's great to know.

> > - How do I install for personal use?
>
> make install would install under whereever you call ~/bin in
> Cygwin environment, and that is how I have mine.

Kewl.

> > - How do I install in /usr/local?
>
> I do not think of a reason why "make prefix=/usr/local" would
> not work but I haven't tried it myself so don't quote me on
> this.

Is cygwin still installable in 2 modes? (Used to be personal and
system-wide or something like that.)

If that's the case, then in a system-wide install you must be root to
write to /usr/local (I'm guessing here) and there's no sudo or su -c
'make prefix=/usr/local install' so you'd have to open an admin
session. Can cygwin shell be invoked under RunAs?

> > - Anything else I should know?
>
> You would probably have great pain if on vfat.  It appears to
> work Ok on NTFS.  It appears to be quite slow, judging from
> the way it runs our standard test suite.

Thanks! So no vfat. In terms of speed, this should be for a
small/medium project. No linux kernel development on Windows just yet
;-)

Thanks! that's a starting point, though I'm intrigued about the
packages required. Are there ways to query what packages you have
installed (a la dpkg -l) and to install a list of packages from
commandline?

Oh, what an ignorant fop I am.

cheers,



martin
