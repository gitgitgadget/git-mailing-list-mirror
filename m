From: Petr Baudis <pasky@ucw.cz>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 02:35:26 +0200
Message-ID: <20050418003526.GD1461@pasky.ji.cz>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <1113780698.11910.8.camel@localhost.localdomain> <20050417233936.GV1461@pasky.ji.cz> <1113782805.11910.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 02:32:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNKBD-0001cK-9q
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 02:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVDRAff (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 20:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVDRAff
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 20:35:35 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60570 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261580AbVDRAf1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 20:35:27 -0400
Received: (qmail 2275 invoked by uid 2001); 18 Apr 2005 00:35:26 -0000
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113782805.11910.36.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 02:06:43AM CEST, I got a letter
where David Woodhouse <dwmw2@infradead.org> told me that...
> On Mon, 2005-04-18 at 01:39 +0200, Petr Baudis wrote:
> > Of course an entirely different thing are _trees_ associated with those
> > commits. As long as you stay with a simple three-way merge, you
> > basically never want to look at trees which aren't heads and which you
> > don't specifically request to look at. And the trees and what they carry
> > inside is the main bulk of data.
> 
> If the trees are absent and you're trying to merge, what do you gain
> from having the commit objects?

merge-base

> For the special case of removing history before 2.6.12-rc2 from the
> trees, I certainly think we can do it by leaving out all the commits,
> not just the trees. We can do that easily, but there's no way we can
> _add_ that history retrospectively if we omit it in the first place.

I'm confused by this paragraph, but that might be my English skills
failing somehow.

> For history older than 2.6.12-rc2 I'd suggest that it would be available
> in a different place, and absent from the 'main' working tree that
> everyone uses by default. The only difference we'd see in the working
> tree is that the 2.6.12-rc2 commit -- the oldest commit in that tree --
> would actually have an absentee parent instead of appearing to be an
> import. And all the sha1 hashes of all subsequent commits would be
> different, of course.

Yes, that's what I suggested too.

> To allow pruning of older objects in the general case would be a little
> bit harder than that, because as things stand you'd be re-fetching them
> every time you rsync from elsewhere -- but that wouldn't really be hard
> to fix if we care.

I think http-pull is very promising. :-)

It could be actually much faster than rsync, since you don't need to
build directory listings etc, which actually takes non-trivial amount of
time already with the kernel git repository.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
