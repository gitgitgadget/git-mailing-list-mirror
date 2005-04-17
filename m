From: Petr Baudis <pasky@ucw.cz>
Subject: Re: full kernel history, in patchset format
Date: Mon, 18 Apr 2005 01:39:36 +0200
Message-ID: <20050417233936.GV1461@pasky.ji.cz>
References: <20050416131528.GB19908@elte.hu> <Pine.LNX.4.58.0504160953310.7211@ppc970.osdl.org> <1113780698.11910.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 01:35:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNJIy-0006Ql-5c
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 01:35:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261561AbVDQXjq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 19:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261563AbVDQXjq
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 19:39:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:154 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261561AbVDQXjm (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 19:39:42 -0400
Received: (qmail 29659 invoked by uid 2001); 17 Apr 2005 23:39:36 -0000
To: David Woodhouse <dwmw2@infradead.org>
Content-Disposition: inline
In-Reply-To: <1113780698.11910.8.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 01:31:36AM CEST, I got a letter
where David Woodhouse <dwmw2@infradead.org> told me that...
> Note that any given copy of a tree doesn't _need_ to keep all the
> history back the beginning of time. It's OK if the oldest commit object
> in your tree actually refers back to a parent which doesn't exist
> locally. I can well imagine that some people will want to keep their
> trees pruned to keep only a few weeks of history, while other copies of
> the tree will keep everything.

I think this is bad, bad, bad. If you don't keep around all the
_commits_, you get into all sorts of troubles - when merging, when doing
git log, etc. And the commits themselves are probably actually pretty
small portion of the thing. I didn't do any actual measurement but I
would be pretty surprised if it would be much more than few megabytes of
data for the kernel history.

Of course an entirely different thing are _trees_ associated with those
commits. As long as you stay with a simple three-way merge, you
basically never want to look at trees which aren't heads and which you
don't specifically request to look at. And the trees and what they carry
inside is the main bulk of data.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
