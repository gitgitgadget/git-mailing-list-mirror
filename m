From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: cogito - how do I ???
Date: Sun, 22 May 2005 09:14:35 +0200
Message-ID: <20050522071435.GA10681@mars.ravnborg.org>
References: <20050521214700.GA18676@mars.ravnborg.org> <2765.10.10.10.24.1116713164.squirrel@linux1> <Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 09:11:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZkc3-0001jv-GD
	for gcvg-git@gmane.org; Sun, 22 May 2005 09:11:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVEVHMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 May 2005 03:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbVEVHMQ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 May 2005 03:12:16 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:15670 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261757AbVEVHMK
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2005 03:12:10 -0400
Received: from mars.ravnborg.org (0x50a0757d.hrnxx9.adsl-dhcp.tele.dk [80.160.117.125])
	by pfepa.post.tele.dk (Postfix) with ESMTP id AFA5D47FE6B;
	Sun, 22 May 2005 09:12:09 +0200 (CEST)
Received: by mars.ravnborg.org (Postfix, from userid 1000)
	id 754726AC08F; Sun, 22 May 2005 09:14:35 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

> > > 1) Something similar to "bk changes -R". I use this to see what has
> > > happened upstream - to see if I really want to merge stuff.
> > 
> > Not sure what bk did here, but you can do something like:
> > 
> > cg-pull origin
> > cg-log -c -r origin
> 
> In the raw git interfaces, you'd basically have to do the same thing that
> "git-pull-script" does, except that _instead_ of calling the
> git-resolve-script thing, you'd do
> 
> 	git-rev-tree MERGE_HEAD ^HEAD | git-diff-tree -v -m -s --stdin
That looks ... long.
I can teach my fingers to use: cg-log, but the above is just too much 
to type/remeber do a daily operation.

In bk the usage pattern was to check what was in mainline _before_
fetching and merging. So it seems that with git/cogoto one
has to fetch the chages, inspect them, and then decide to apply or not.

When the fetches changes stay in MERGE_HEAD I assume my work when
committed will be based on top of HEAD - so I do not have to know
if I have fetched some (unmerged) updates.

> to show what is in the downloaded MERGE_HEAD but not in HEAD.
> 
> > > 2) Export of individual patches. "bk export -tpatch -r1.2345"
> > > I have nu public git repository yet so I have to feed changes as
> > > plain patches. Browsing cg-* I did not find the command to do this.
> > 
> > cg-diff -p -r SHA1
> 
> And again, without the porcelain this is:
> 
> 	git-diff-tree -v -p <name>

The key here is the SHA1. I hoped to avoid specifying SHA1's with
cogito, I so often miss one character when doing copy'n'paste.


Thanks all for the replies. Now I feel a bit more confident in this.


	Sam
