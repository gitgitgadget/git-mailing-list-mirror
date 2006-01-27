From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Two newbie question: "dead" branches and merging after cherry-pick.
Date: Fri, 27 Jan 2006 20:47:30 +0100
Message-ID: <20060127194730.GB6169@steel.home>
References: <20060127173619.GA26199@pern.dea.icai.upcomillas.es>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 27 20:48:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F2ZZX-0006oE-HI
	for gcvg-git@gmane.org; Fri, 27 Jan 2006 20:47:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbWA0Trs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jan 2006 14:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWA0Trs
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jan 2006 14:47:48 -0500
Received: from devrace.com ([198.63.210.113]:59404 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S932489AbWA0Trr (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Jan 2006 14:47:47 -0500
Received: from tigra.home (p54A075C5.dip.t-dialin.net [84.160.117.197])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id k0RJlVeR088734;
	Fri, 27 Jan 2006 13:47:32 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1F2ZZC-0005qD-00; Fri, 27 Jan 2006 20:47:30 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1F2ZZC-00057R-0a; Fri, 27 Jan 2006 20:47:30 +0100
To: Romano Giannetti <romano@dea.icai.upcomillas.es>
Content-Disposition: inline
In-Reply-To: <20060127173619.GA26199@pern.dea.icai.upcomillas.es>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.0 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL autolearn=no version=3.0.2
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15186>

Romano Giannetti, Fri, Jan 27, 2006 18:36:19 +0100:
> - I use to work on a topic branch to make test, try solutions for
> bugs, etc. Say I am done with the branch "test-bill-idea". I decide
> it's a dead branch, so that I do not want to see it in day-by-day
> work (git branch, basically), but I do not want to loose it. If I
> delete the branch I will loose all its commit at the next prune,
> correct? There is a way to maintain it as a dead or hidden branch,
> shown for example just by gitk --all? If I tag the tip of the
> branch, and then delete .git/refs/head/test-bill-idea, will the
> "dead branch commits" be preserved by next prune(s)? 

Yes, it will.

You can actually move the reference file anywhere under .git/refs/,
and "git prune" will never touch it and gitk will show it different
color (looks grey to me). The tags are shown yellow, which can be
associated with "dead for some time" already.

> - Easier: suppose I cheery-picked "abababab" from branch "testing"
> to master branch. What will happen if later I decide to merge
> all "testing" to master branch? I will have a merge conflict (trying
> to apply two times the same fix) or not? 

Yes, you probably will have to deal with a conflict (it can match the
branch to be merged exactly, which is hardly a conflict).
