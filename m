From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: 'git checkout -f' versus 'git reset --hard'
Date: Thu, 5 Apr 2007 11:29:25 -0400
Message-ID: <20070405152925.GG5436@spearce.org>
References: <17940.64329.10165.993967@lisa.zopyra.com> <20070405134311.GA18163@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 17:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZTuw-0005Vd-40
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 17:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767059AbXDEP3c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 11:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767058AbXDEP3b
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 11:29:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38642 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767050AbXDEP3a (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 11:29:30 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HZTtp-00049M-M9; Thu, 05 Apr 2007 11:29:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7A42E20FBAE; Thu,  5 Apr 2007 11:29:25 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070405134311.GA18163@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43832>

Jeff King <peff@peff.net> wrote:
> On Thu, Apr 05, 2007 at 08:36:09AM -0500, Bill Lear wrote:
> 
> > After a failed merge, I want to undo things.  I typically use git
> > reset --hard, and it works like a charm.  Others have tried to use git
> > checkout -f, but I have cautioned that git reset --hard is really the
> > way to do it.  Is there a difference here, or are they equivalent?
> 
> Skimming through the code (and looking at the output of sh -x), it looks
> like both just end up executing git-read-tree --reset -u $HEAD.

Sure, but git-reset also whacks MERGE_MSG, rr-cache/MERGE_RR,
SQUASH_MSG, SQUASH_HEAD.  Maybe checkout should do the same.

I guess checkout -f is fine, and does the job, but usually we say
reset --hard.  :-)

-- 
Shawn.
