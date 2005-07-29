From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Fri, 29 Jul 2005 09:46:14 +0200
Message-ID: <20050729074614.GF24895@pasky.ji.cz>
References: <20050727083910.GG19290@mythryan2.michonline.com> <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net> <20050729065335.GA32263@mythryan2.michonline.com> <20050729073134.GA6507@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Anderson <ryan@michonline.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 09:57:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyPk8-0006Xa-EU
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:57:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVG2H4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbVG2Hqt
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:46:49 -0400
Received: from w241.dkm.cz ([62.24.88.241]:54283 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262496AbVG2HqR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 03:46:17 -0400
Received: (qmail 30832 invoked by uid 2001); 29 Jul 2005 07:46:14 -0000
To: Sam Ravnborg <sam@ravnborg.org>
Content-Disposition: inline
In-Reply-To: <20050729073134.GA6507@mars.ravnborg.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 09:31:34AM CEST, I got a letter
where Sam Ravnborg <sam@ravnborg.org> told me that...
> > > While I do not have strong objections to make the build process
> > > go faster, it is somewhat disturbing that the Makefile pieces
> > > maintained in subdirectories need to name things they touch
> > > using paths that include the subdirectory names.  I do not have
> > > a better alternative to suggest, though...
> 
> If the goal is to speed up the build process the only sane way is to fix
> the dependencies. In kbuild fixdep is used to parse the .c file and it
> locates all references to .h files (recursive) and also detects any
> usage of CONFIG_ symbols.
> This part should be relative straightforward to include in git.

FWIW, I made tiny "build system" (inspired by kconfig) for smaller
projects I work on:

http://pasky.or.cz/~pasky/dev/tunneler/co/Makefile
http://pasky.or.cz/~pasky/dev/tunneler/co/Makefile.lib
http://pasky.or.cz/~pasky/dev/tunneler/co/client/Makefile

Perhaps someone might find that a nice base for further hacking. It
generally appears to work pretty well in practice, although the
automatic dependency tracking might not be perfect.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
