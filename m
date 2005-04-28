From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git fork removal?
Date: Thu, 28 Apr 2005 11:29:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504281115210.30848-100000@iabervon.org>
References: <20050428091039.GI8612@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 17:26:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRAst-0004NA-Th
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 17:25:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVD1P35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 11:29:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbVD1P35
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 11:29:57 -0400
Received: from iabervon.org ([66.92.72.58]:34821 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262155AbVD1P3t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Apr 2005 11:29:49 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DRAxX-0007Tq-00; Thu, 28 Apr 2005 11:29:47 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050428091039.GI8612@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 28 Apr 2005, Petr Baudis wrote:

> Dear diary, on Thu, Apr 28, 2005 at 04:47:24AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
>
> > The thing that I think requires the symlinks is step 2, which requires
> > that there be somewhere I can run git and have it able to see a pair of
> > unrelated local heads and the relevant trees.
> 
> Just do cg-pull barkalow, to get the latest changes from that repository
> (perhaps clone should inherit branches information?).

You can pull from local repositories? I think that having the same concept
for remote repositories and for different lines of local development is
what confuses users.

> But if you want Linus to pull from your tree, you generally want it to
> be clean - that is, you want to manage clean separation (as Pavel Machek
> describes in his document).

I'll be using rpush and he'd have to use http-pull (I don't have rsync
set up); both of these only transfer the reachable objects, so cleanliness
isn't an issue.

> That is another advantage of hardlinking -
> you don't get any unrelated stuff in if you don't explicitly pull it, so
> you can keep your for-linus branch clean. I'd do cg-diff linus:this in
> the barkalow branch instead to keep this property.

But that doesn't work; when I'm preparing the second patch in the series,
I want to compare linus+patch 1 against barkalow, so that I'm looking at
what's left to split. That's why I need to have the unrelated heads, not
just the linus head and my head based on it. If I go back to linus each
time, it's more work making the patches and I don't have an easy way of
telling whether I've included the same part twice or missed a part.

	-Daniel
*This .sig left intentionally blank*

