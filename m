From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: committing empty diffs
Date: Mon, 12 Feb 2007 15:03:24 -0500
Message-ID: <20070212200324.GB30440@spearce.org>
References: <68948ca0702121149p4d87ae07jd3aa532a0df79156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 21:03:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGhOe-0004z0-Nx
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964888AbXBLUDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbXBLUDa
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:03:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37644 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964888AbXBLUD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:03:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGhOQ-0001FJ-PV; Mon, 12 Feb 2007 15:03:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5E60F20FBAE; Mon, 12 Feb 2007 15:03:24 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <68948ca0702121149p4d87ae07jd3aa532a0df79156@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39429>

Don Zickus <dzickus@gmail.com> wrote:
> Considering git-commit doesn't allow this (probably for good reason),
> is it technically safe to do the following sequence of events?
> 
> tree=$(git-write-tree)  #basically the same tree HEAD points to
> commit=$(echo $IDEAS | git-commit-tree $tree -p HEAD)
> git-update-ref HEAD $commit HEAD
> 
> I figured all a commit is doing is taking a snapshot of a particular
> tree at a moment in time.  And taking multiple snapshots at that same
> moment and stringing them together (pointed to by HEAD) wouldn't be a
> big deal.
> 
> Am I going to wind up shooting myself in the foot later or will this
> work?  Light testing didn't show any issues.  Thought I would ask the
> experts.  Thanks.

No, it won't break anything.

I do that empty commit myself for a different reason.  I wouldn't
recommend that you do that with public history, and since the file
didn't change in that commit you cannot do `git log -- foo.c` to
see which notes you wrote about foo.c.  But `git log` will still
show you the messages.

-- 
Shawn.
