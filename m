From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cloning speed comparison
Date: Sat, 13 Aug 2005 05:10:25 +0200
Message-ID: <20050813031025.GE20812@pasky.ji.cz>
References: <20050813015402.GC20812@pasky.ji.cz> <Pine.LNX.4.58.0508121908180.3295@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 05:12:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3mQB-0003mx-7j
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 05:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbVHMDKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 23:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbVHMDKa
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 23:10:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:4868 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S1750858AbVHMDK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 23:10:29 -0400
Received: (qmail 22790 invoked by uid 2001); 13 Aug 2005 03:10:25 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508121908180.3295@g5.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 13, 2005 at 04:12:26AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Sat, 13 Aug 2005, Petr Baudis wrote:
> > 
> >   Anyway, clone-pack is a clear winner for networks (but someone should
> > re-check that, especially compared to rsync, wrt. server-side file
> > caching); really cool fast, but not very practical for anonymous access.
> 
> git-daemon is for the anonymous access case, either started from inetd 
> (or any other external "listen to port, exec service" thing), or with the 
> built-in listening stuff.
> 
> It uses exactly the same protocol and logic as the regular ssh clone-pack 
> thing, except it doesn't authenticate the remote end: it only checks that 
> the local end is accepting anonymous pulls by checking whether there is a 
> "git-daemon-export-ok" file in the git directory.
> 
> In my tests, the git daemon was noticeably faster than ssh, if only 
> because the authentication actually tends to be a big part of the overhead 
> in small pulls.

Oh. Sounds nice, are there plans to run this on kernel.org too? (So far,
90% of my GIT network activity happens with kernel.org; the rest is with
my notebook, and I want to keep that ssh.)

BTW, is the pack protocol flexible enough to be extended to support
pushing? That would be great as well. You might suggest just using ssh,
but that (i) requires you to be root on the machine to add new users
(ii) consequently adds administrative burden (iii) isn't easy to set up
so that the user has no shell access, shall you want to restrict that.

> [ Hey. There's a deer outside my window eating our roses again. Cute ]

Oh, it must be nice in Oregon. I can't imagine anything like that to
happen in Czechia unless you live at a solitude or in some lonely tiny
village.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
