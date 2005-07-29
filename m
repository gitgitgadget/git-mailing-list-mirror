From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] extending git-ls-files --exclude.
Date: Fri, 29 Jul 2005 09:36:44 +0200
Message-ID: <20050729073644.GE24895@pasky.ji.cz>
References: <20050721202309.8216.19338.stgit@h164.c77.b0.tor.eicat.ca> <7v3bq71rmb.fsf@assigned-by-dhcp.cox.net> <tnx1x5ryvn2.fsf@arm.com> <20050722192424.GB8556@mars.ravnborg.org> <7vy87yr2xh.fsf@assigned-by-dhcp.cox.net> <20050722205948.GE11916@pasky.ji.cz> <7vd5p73jlu.fsf@assigned-by-dhcp.cox.net> <20050728155210.GA17952@pasky.ji.cz> <7vack6mcd7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Marco Costalba <mcostalba@yahoo.it>
X-From: git-owner@vger.kernel.org Fri Jul 29 09:37:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyPQc-0004ef-62
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 09:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbVG2Hgy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 03:36:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262482AbVG2Hgx
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 03:36:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43019 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262481AbVG2Hgs (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 03:36:48 -0400
Received: (qmail 29673 invoked by uid 2001); 29 Jul 2005 07:36:45 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vack6mcd7.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 29, 2005 at 07:04:36AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
>  * When checking a file to see if it is excluded, we first look
>    at "exclude-from patterns" list, then "per directory
>    patterns" list, and then "command line patterns list", in
>    that order.  The last match wins [*1*].

Hmm. What about just excluding the files according to the order of
parameters on the command line?

Here, the question is whether the GIT Core tools should provide full
flexibility and friendness to custom use, or rather serve as tighter
unifying layer for the porcelains, enforcing certain conventions. That's
up to you to decide, obviously, but perhaps someone will want to use the
exclude mechanisms for something else than the "classic" other files
ignoring stuff, and generally more flexibility might be better. So I'd
argue for codifying those conventions at the level of the porcelain
users and not enforcing them in git-ls-files itself.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
