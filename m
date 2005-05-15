From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Sun, 15 May 2005 13:48:47 +0200
Message-ID: <20050515114847.GD13024@pasky.ji.cz>
References: <Pine.LNX.4.44.0505100546010.2136-100000@bellevue.puremagic.com> <Pine.LNX.4.44.0505141851340.2136-200000@bellevue.puremagic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 13:48:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXHby-0008NL-DU
	for gcvg-git@gmane.org; Sun, 15 May 2005 13:48:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbVEOLsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 07:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbVEOLsw
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 07:48:52 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55471 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262769AbVEOLst (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 May 2005 07:48:49 -0400
Received: (qmail 19677 invoked by uid 2001); 15 May 2005 11:48:47 -0000
To: Brad Roberts <braddr@puremagic.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0505141851340.2136-200000@bellevue.puremagic.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 15, 2005 at 04:04:25AM CEST, I got a letter
where Brad Roberts <braddr@puremagic.com> told me that...
> > I wasn't able to finish redoing these against linus tip, but I got most of
> > it done (patches 1-14 of the original 19):
> >
> >   http://gameboy2.puremagic.com:8090/
> >   rsync://gameboy2.puremagic.com/git/
> >
> > The second, third, and forth to last changes need a careful review,
> > they're direct applications of the original patches which were lightly
> > tested during the first round and nothing other than compile tested in
> > this round.
> >
> > I suspect the remaining parts of the original patch series will go in
> > fairly smoothly.  If no one gets to them before tonight I'll finish
> > it up after work.
> >
> > Later,
> > Brad
> 
> I've completed the re-merge, and moved to tip of git-pb.git rather than
> tip of git.git.  Unfortunatly that merge was also somewhat intrusive and
> my individual diffs along the way are somewhat useless now.  The entire
> history is available about the above locations still.  Attached is the
> full diff vs git-pb @ 902b92e00e491a60d55c4b2bce122903b8347f34.

I've merged some of the minor stuff for now.

> 2) Should the index changing areas be constructing a new index instead of
> shuffling bits within the current index?

When I have a big cache (the only time it matters), I do usually only
relatively small changes to it, so...

> 3) The vocabulary and code is inconsistent between cache and index.

Yes...

> 4) read-cache.c does much more than reading.

and yes. And cache.h is full of crap. Perhaps we could move read-cache.c
to cache.c?


I'd imagine the plan of attack to continue by changing active_cache to
be struct cache, then making it local.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
