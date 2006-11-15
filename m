X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 17:00:54 -0500
Message-ID: <20061115220054.GA24861@spearce.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <20061114194707.GH7201@pasky.or.cz> <87d57pu4qa.wl%cworth@cworth.org> <7v3b8lv9c9.fsf@assigned-by-dhcp.cox.net> <87wt5wsabs.wl%cworth@cworth.org> <ejfutp$cgc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 22:01:12 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ejfutp$cgc$1@sea.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31511>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSoY-00026U-Bd for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:01:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161787AbWKOWA7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161811AbWKOWA7
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:00:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:6058 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161787AbWKOWA6
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:00:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkSoJ-0005gb-TB; Wed, 15 Nov 2006 17:00:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 B623A20FB0B; Wed, 15 Nov 2006 17:00:54 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Carl Worth wrote:
> >On Tue, 14 Nov 2006 16:31:50 -0800, Junio C Hamano wrote:
> >>
> >> For another example, having a commit command to commit
> >> everything by default is disastrous for people who allow their
> >> workflows to often be interrupted.
> > 
> > Workflow-interruption is an important thing to support, but separating
> > update-index and commit really doesn't address it nearly as much as I
> > would like. The lack of really good workflow-interruption support has
> > been one of my longest-running annoyances with git, (perhaps because I
> > have a problem with trying to do too many things at once). Git can
> > create and change branches fast enough that it really should be able
> > to help me better with this. The only missing piece is being able to
> > stash the dirty stuff on the current branch, to be able to come back
> > to it later. I've talked a bit about what I would like in this area
> > before, and I really just need to code it up.
> 
> There is git-stash/git-unstash floating somewhere in the archive.

I find that a "git commit -a -m parked; git checkout -b ..." works
well to stash my current stuff off.  Then I just amend the commit
when I come back to that branch.


The problem I just ran into today was "git checkout" doesn't double
check the file stat data against the index before switching branches.
If the file is unchanged between the two branches there's no error.
So I switched branches with dirty files that I forgot to park on
the old branch.

-- 
