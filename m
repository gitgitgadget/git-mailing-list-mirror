From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [3/5] Add http-pull
Date: Sun, 17 Apr 2005 15:24:27 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504171510120.30848-100000@iabervon.org>
References: <20050417190824.GF1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 21:24:11 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFMr-0002bm-JP
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVDQT1B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVDQTYl
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:24:41 -0400
Received: from iabervon.org ([66.92.72.58]:20998 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261428AbVDQTYL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:24:11 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DNFNb-0006FD-00; Sun, 17 Apr 2005 15:24:27 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417190824.GF1461@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sun, Apr 17, 2005 at 08:49:11PM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> 
> I'm not too kind at this. Either make it totally separate commands, or
> make a required switch specifying what to do. Otherwise it implies the
> switches would just modify what it does, but they make it do something
> completely different.

That's a good point. I'll require a -t for now, and add more later.

> -a would be fine too - basically a combination of -c and -t. I'd imagine
> that is what Linus would want to use, e.g.

Well, -c -t would give you the current tree and the whole commit log, but
not old trees. -a would additionally give you old trees.

> > There's some trickiness for the history of commits thing for stopping at
> > the point where you have everything, but also behaving appropriately if
> > you try once, fail partway through, and then try again. It's on my queue
> > of things to think about.
> 
> Can't you just stop the recursion when you hit a commit you already
> have?

The problem is that, if you've fetched the final commit already, and then
the server dies, and you try again later, you already have the last one,
and so you think you've got everything.

At this point, I also want to put off doing much further with recursion
and commits until revision.h and such are sorted out.

	-Daniel
*This .sig left intentionally blank*

