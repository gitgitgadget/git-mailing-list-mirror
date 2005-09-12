From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: hmm, can't we give the "root" a parent?
Date: Mon, 12 Sep 2005 23:00:06 +0200
Message-ID: <20050912210006.GA32211@vrfy.org>
References: <20050912181101.GA22221@vrfy.org> <Pine.LNX.4.58.0509121123280.3242@g5.osdl.org> <20050912195947.GA28502@vrfy.org> <Pine.LNX.4.58.0509121316030.3266@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 12 23:02:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEvPS-0003pK-En
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 23:00:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVILVAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 17:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVILVAL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 17:00:11 -0400
Received: from soundwarez.org ([217.160.171.123]:26858 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S932239AbVILVAK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 17:00:10 -0400
Received: by soundwarez.org (Postfix, from userid 2702)
	id E5F6D58C0C; Mon, 12 Sep 2005 23:00:06 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509121316030.3266@g5.osdl.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8428>

On Mon, Sep 12, 2005 at 01:21:13PM -0700, Linus Torvalds wrote:
> On Mon, 12 Sep 2005, Kay Sievers wrote:
> >
> > And good to know about that, need to fix the "parent" link in gitweb to
> > respect grafts.
> 
> Note that the simplest way to do this is to try to use "git-rev-list" as 
> much as possible. The "--parents" flag makes the output have the parents 
> (automatically _including_ any grafts) on the line that contains the 
> commit ID.
> 
> That's especially true of any tools that use git-rev-list anyway for other
> reasons. Eg "gitk" could parse the parent stuff this way, and didn't need
> to know about the info/grafts file at all. I suspect the same should be
> true of gitweb.

Everthing that walk from one commit to another, uses git-rev-list, sure.
But in the commit view, and the commitdiff the "parent" link and the parent
that is passed to diff is read from the commit itself.

> (So instead of trying to parse the parent info from the header of the 
> commit, just do "git-rev-list --pretty --parents" and parse that).

I need only one parent:
  git-rev-list --parents --max-count=1 <id>

Hmm, it's one more exec, but I don't need to look at the grafts file or
whatever will make it into git the next time I will look at it. :)

Thanks,
Kay
