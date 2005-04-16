From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: full kernel history, in patchset format
Date: Sat, 16 Apr 2005 20:57:51 +0200
Message-ID: <20050416185751.GJ19099@pasky.ji.cz>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <1113679421.28612.16.camel@tglx.tec.linutronix.de> <Pine.LNX.4.58.0504161135480.7211@ppc970.osdl.org> <1113681021.28612.29.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 20:54:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMsQn-0004jq-P9
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 20:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262731AbVDPS5y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 14:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262732AbVDPS5y
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 14:57:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:20355 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262731AbVDPS5w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 14:57:52 -0400
Received: (qmail 5262 invoked by uid 2001); 16 Apr 2005 18:57:51 -0000
To: Thomas Gleixner <tglx@linutronix.de>
Content-Disposition: inline
In-Reply-To: <1113681021.28612.29.camel@tglx.tec.linutronix.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Apr 16, 2005 at 09:50:21PM CEST, I got a letter
where Thomas Gleixner <tglx@linutronix.de> told me that...
> On Sat, 2005-04-16 at 11:44 -0700, Linus Torvalds wrote:
> 
> > That level of abstraction ("we never look directly at the objects") is 
> > what allows us to change the object structure later. For example, we 
> > already changed the "commit" date thing once, and the tree object has 
> > obviously evolved a bit, and if we ever change the hash, the objects will 
> > change too, but if you always just script them using nice helper tools, 
> > you won't ever need to _care_. And that's how it should be.
> 
> For the export stuff its terrible slow. :(

It seems to me that you must be doing something wrong then. I can't see
anything which would not make ls-tree blindingly fast (except for when
being recursive, see below).

BTW, what do you need ls-tree output for, when doing export _to_ git?

P.S.: It seems that Linus applied a patch to ls-tree which will make it
read_sha1_file() on each item when ls-tree is recursive. Junio, why did
you do it? Is there any possible case when the item would not be marked
as directory but it would be a tree object? I could imagine it bogging
down ls-tree on big tree a lot.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
