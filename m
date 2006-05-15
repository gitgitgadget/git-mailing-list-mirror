From: Shawn Pearce <spearce@spearce.org>
Subject: Re: The git newbie experience
Date: Mon, 15 May 2006 01:27:28 -0400
Message-ID: <20060515052728.GA28068@spearce.org>
References: <446778B8.7080201@inoi.fi> <7vfyjcntro.fsf@assigned-by-dhcp.cox.net> <44680C54.8040206@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 07:28:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfVcV-0006Zx-3i
	for gcvg-git@gmane.org; Mon, 15 May 2006 07:27:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWEOF1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 01:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWEOF1h
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 01:27:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:1411 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932114AbWEOF1g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 01:27:36 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FfVcB-0001Lg-Dv; Mon, 15 May 2006 01:27:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 37914212667; Mon, 15 May 2006 01:27:29 -0400 (EDT)
To: Tommi Virtanen <tv@inoi.fi>
Content-Disposition: inline
In-Reply-To: <44680C54.8040206@inoi.fi>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20018>

Tommi Virtanen <tv@inoi.fi> wrote:
> Junio C Hamano wrote:
[snip]
> > - Jack stashes away what he has been working on and cleans up
> >   his mess.
> > 
> >   git diff >P.diff
> >   git checkout HEAD A B C
> ...
> > - Jack then reapplies what he stashed away with "git apply P.diff"
> >   and keeps working.
> > 
> > Maybe "git stash" command that does "git diff --full-index" with
> > some frills, and "git unstash" command which does an equivalent
> > of "git am -3" would help this workflow (bare "git apply" does
> > not do the three-way merge like am does).
> 
> Oh, I'd love to have a quick stash, that's what we actually ended up
> doing a lot. Although I'd rather see a real implementation use a branch
> and not just a diff file, but.. yes please.
> 
> Although, "git stash" and "git unstash" are yet another command to add
> to the newbie set, and I just complained about the size of the set ;)

This is perhaps one area where SVN's user interface is actually nice.
SVN's equiv. of stash is making a copy of your working directory into
the repository; something that is rather simple to do for the user.

What about "git commit -b foo -a" to commit the current working
directory to branch 'foo'?

Then restoring is a pull of foo ("git pull . foo"), but that
intermediate commit is now part of the repository history.  And "git
commit -a" doesn't automatically add extra/other files to the
repository and it probably should in the case of a "stash".

-- 
Shawn.
