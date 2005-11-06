From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: git binary directory?
Date: Sun, 06 Nov 2005 00:12:30 -0300
Message-ID: <200511060312.jA63CUcv010887@inti.inf.utfsm.cl>
References: <junkio@cox.net>
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Nov 06 04:16:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EYayt-0008Ei-9b
	for gcvg-git@gmane.org; Sun, 06 Nov 2005 04:14:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932215AbVKFDOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Nov 2005 22:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932222AbVKFDOE
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Nov 2005 22:14:04 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:45185 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S932215AbVKFDOB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Nov 2005 22:14:01 -0500
Received: from inti.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by inti.inf.utfsm.cl (8.13.5/8.13.1) with ESMTP id jA63CUcv010887;
	Sun, 6 Nov 2005 00:12:30 -0300
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: Message from Junio C Hamano <junkio@cox.net> 
   of "Sat, 05 Nov 2005 18:49:24 -0800." <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11189>

Junio C Hamano <junkio@cox.net> wrote:
> Linus Torvalds <torvalds@osdl.org> writes:
> > Now, I happen to think that 2500+ files in /usr/bin is a bit much (ever 
> > try to use the horrid gnome executable finder on it when you want to 
> > convince firefox to use xpdf instead of that broken crap called "evince"? 
> > Takes absolutely ages and is horrible).
> >
> > And git made it about 4% worse all on its own.

[...]

> Since we do not have enough clout to have /usr/bin/git/ and ask
> the users to put that in their PATH like X11 does,

That is going away. No more /usr/X11R6/{bin,lib,man} junk.

>                                                    we need to
> teach some of our commands that use other git commands to
> prepend /usr/lib/git/ (or /usr/libexec/git)

AFAIU, /usr/libexec/git (or /usr/libexec/git-<version>) would be better.
Including the version would make it possible to have the last stable and a
development version coexisting, like gcc does with -V. Or its -B option,
which tells it where to find the executables that do the real work.

>                                             on their PATH while
> they run.  Although many of the Porcelainish commands include
> git-sh-setup, git-sh-setup itself is a prime candidate to be
> kicked out of /usr/bin, which means essentially everything needs
> to have that PATH trick.

> This also is a bit inconvenient for our in-source-tree tests.

Explicitly saying where to find all the stuff with -B would help here.


The only downside is that git-<TAB> won't find them anymore, but I'm sure
the bash-completion people will fix that soon ;-)
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
