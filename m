From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 20:39:04 +0200
Message-ID: <20050728183904.GA24948@pasky.ji.cz>
References: <Pine.LNX.4.58.0507281931180.30371@wgmdd8.biozentrum.uni-wuerzburg.de> <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728161815.GC17952@pasky.ji.cz> <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 20:46:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyDNP-000703-J0
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 20:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVG1Smr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 14:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261526AbVG1SkP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 14:40:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57873 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261465AbVG1SjL (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 14:39:11 -0400
Received: (qmail 28872 invoked by uid 2001); 28 Jul 2005 18:39:05 -0000
To: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <7v1x5ic1pe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 06:52:45PM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> 
> > AFAIK the plan is to centralize all the kernel repositories to a single
> > one. For that, developers would generally push into branches with name
> > different that "master".
> 
> I did not know about that plan, but that is interesting and now
> I understand why you think it is important to be able for more
> than one person to push into a single repository.

For that particular thing, this is only part of the motivation. The much
bigger part of the motivation are projects which don't have a central
maintainer but where group of people needs to be equal in access to a
central repository. That's actually vast majority of larger projects, I
think.

> How will the namespace of N-hundred branches in that repository
> be managed?  To avoid collisions, wouldn't there be some
> coordination, and there will be branch names there that
> everybody agrees that they are owned by you?

You could name your branches e.g. "davej/agpgart", "davej/cpufreq", etc.
But those proposals of central repository were certainly quite
preliminary, and perhaps I overstated saying "the plan is".

> At that point, wouldn't it be easier for _you_ (as one kernel
> developer who owns such globally unique branch names) to name
> your branch you intend to push there the same way in your
> working repository as well?

And if you are cloning locally or whatever, you have to mention the
branch name explicitly.

One of the Cogito design bits is that branch name is something local to
the repository. When you are adding a branch, the local name you assign
it is your private thing repository-wise, and doesn't have to have any
correlation to other repositories you might interact width.

As I already argued, this helps when you are importing someone else's
master as your branch called whatever (obviously not master), and if you
have to deal with two remote branches with the same name (such a
conflict is bound to happen and bound to be vulnerable to be a huge
hassle). That also applies to pushing, you might be pushing to multiple
repositories - say you are working on some cool kernel stuff for SuSE,
so you might want to push to kernel.org _and_ into the deep bowels of
some SuSE kernel infrastructure (whatever - I'm not familiar with those
things yet if you are now drooling to get some insight about how this is
working in SuSE].

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
