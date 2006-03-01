From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-svn and huge data and modifying the git-svn-HEAD branch directly
Date: Wed, 1 Mar 2006 12:28:16 -0500
Message-ID: <20060301172816.GA4090@spearce.org>
References: <62502.84.163.87.135.1141063190.squirrel@mail.geht-ab-wie-schnitzel.de> <4405C6BE.2000706@op5.se> <Pine.LNX.4.64.0603010821590.22647@g5.osdl.org> <200603011814.43573.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andreas Ericsson <ae@op5.se>,
	Eric Wong <normalperson@yhbt.net>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 18:29:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEV86-0002OR-Of
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 18:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbWCAR2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 12:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751493AbWCAR2l
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 12:28:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:62603 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751402AbWCAR2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 12:28:40 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FEV7h-0003C5-W1; Wed, 01 Mar 2006 12:28:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CFD7420FBBF; Wed,  1 Mar 2006 12:28:16 -0500 (EST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200603011814.43573.Josef.Weidendorfer@gmx.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16994>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> On Wednesday 01 March 2006 17:24, Linus Torvalds wrote:
> > The thing about it being .git/refs/heads/svn/xyzzy is that then you can do
> > 
> > 	git checkout svn/xyzzy
> > 
> > and start modifying it. Which is exactly against the point: the thing is 
> > _not_ a branch and you must _not_ commit to it.
> > 
> > It's much more like a tag: it's a pointer to the last point of an 
> > svn-import.
> 
> Isn't it the same with tracked branches of a remote git repo?
> With this reasoning, all heads that git-clone clones aside from the
> special "master" should not be under .git/refs/heads, but better
> under .git/refs/remotes/<remoteRepoName>/ ?
> 
> <remoteRepoName> is "origin" in the case of git-clone, so .git/remotes/origin
> would contain
>  URL: http://host/repo.git
>  Pull: master:remotes/origin/master
> 
> Then there would not be the need for the confusing special branch "origin"
> after cloning, as namespaces are separate.

This is a really good idea.  It certainly would prevent polluting the
heads namespace.  And its a lot easier to explain to someone than the
mapping in the Pull line usually is.

-- 
Shawn.
