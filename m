From: Brad Roberts <braddr@puremagic.com>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Sun, 15 May 2005 12:06:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.44.0505151204230.2136-100000@bellevue.puremagic.com>
References: <20050515114847.GD13024@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
	<git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun May 15 21:06:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXORf-0000N8-12
	for gcvg-git@gmane.org; Sun, 15 May 2005 21:06:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVEOTGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVEOTGr
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 15:06:47 -0400
Received: from bellevue.puremagic.com ([209.189.198.108]:46261 "EHLO
	bellevue.puremagic.com") by vger.kernel.org with ESMTP
	id S261203AbVEOTGn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 15:06:43 -0400
Received: from bellevue.puremagic.com (localhost [127.0.0.1])
	by bellevue.puremagic.com (8.13.4/8.13.4/Debian-1) with ESMTP id j4FJ6SOS011946
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 15 May 2005 12:06:28 -0700
Received: from localhost (braddr@localhost)
	by bellevue.puremagic.com (8.13.4/8.13.4/Submit) with ESMTP id j4FJ6Sr8011942;
	Sun, 15 May 2005 12:06:28 -0700
X-Authentication-Warning: bellevue.puremagic.com: braddr owned process doing -bs
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050515114847.GD13024@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> Date: Sun, 15 May 2005 13:48:47 +0200
> From: Petr Baudis <pasky@ucw.cz>
> To: Brad Roberts <braddr@puremagic.com>
> Cc: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>,
>      git@vger.kernel.org
> Subject: Re: Darcs-git: a few notes for Git hackers
>
> Dear diary, on Sun, May 15, 2005 at 04:04:25AM CEST, I got a letter
> where Brad Roberts <braddr@puremagic.com> told me that...
> > > I wasn't able to finish redoing these against linus tip, but I got most of
> > > it done (patches 1-14 of the original 19):
> > >
> > >   http://gameboy2.puremagic.com:8090/
> > >   rsync://gameboy2.puremagic.com/git/
> > >
> > > The second, third, and forth to last changes need a careful review,
> > > they're direct applications of the original patches which were lightly
> > > tested during the first round and nothing other than compile tested in
> > > this round.
> > >
> > > I suspect the remaining parts of the original patch series will go in
> > > fairly smoothly.  If no one gets to them before tonight I'll finish
> > > it up after work.
> > >
> > > Later,
> > > Brad
> >
> > I've completed the re-merge, and moved to tip of git-pb.git rather than
> > tip of git.git.  Unfortunatly that merge was also somewhat intrusive and
> > my individual diffs along the way are somewhat useless now.  The entire
> > history is available about the above locations still.  Attached is the
> > full diff vs git-pb @ 902b92e00e491a60d55c4b2bce122903b8347f34.
>
> I've merged some of the minor stuff for now.

Cool, though there appears to have been some objections. :)

> > 2) Should the index changing areas be constructing a new index instead of
> > shuffling bits within the current index?
>
> When I have a big cache (the only time it matters), I do usually only
> relatively small changes to it, so...

The entire index is bit shuffled around even if nothing changed.  At least
today, size and amount changed doesn't matter.

> > 3) The vocabulary and code is inconsistent between cache and index.
>
> Yes...
>
> > 4) read-cache.c does much more than reading.
>
> and yes. And cache.h is full of crap. Perhaps we could move read-cache.c
> to cache.c?

At least parts of it, probably yes.

> I'd imagine the plan of attack to continue by changing active_cache to
> be struct cache, then making it local.

Which is what the rest of that patch does.

Thanks for looking at this.

Later,
Brad

