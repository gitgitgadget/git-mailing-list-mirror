From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Errors cloning large repo
Date: Sat, 10 Mar 2007 01:01:44 -0500
Message-ID: <20070310060144.GA3223@spearce.org>
References: <645002.46177.qm@web52608.mail.yahoo.com> <20070310030718.GA2927@spearce.org> <Pine.LNX.4.64.0703092145550.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Tropashko <atropashko@yahoo.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 07:02:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPuea-0005aI-64
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 07:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767843AbXCJGBy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Mar 2007 01:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767845AbXCJGBy
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Mar 2007 01:01:54 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57857 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767843AbXCJGBx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Mar 2007 01:01:53 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HPueM-0007l8-Nq; Sat, 10 Mar 2007 01:01:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B85D120FBAE; Sat, 10 Mar 2007 01:01:44 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703092145550.10832@woody.linux-foundation.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41851>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Fri, 9 Mar 2007, Shawn O. Pearce wrote:
> > 
> > I'm shocked you were able to repack an 8.5 GiB repository.
> 
> Side note - it would be nice to hear just how big the repository *really* 
> is.
> 
> For example, if "du -sh" says 8.5GB, it doesn't necessarily mean that 
> there really is 8.5GB of data there.

Oh, good point.  Thanks for reminding me of reality.

I'm just so used to not looking at repository size unless the
repository has been fully repacked first.  So I somehow just read
this thread has Anton having 8.5 GiB worth of *packed* data (where
filesystem wastage in the tail block is minimal) and not 8.5 GiB
of loose objects.

Its very likely this did fit in just under 4 GiB of packed data,
but as you said, without O_LARGEFILE we can't work with it.
 
> So this really could be a situation where just small tweaks makes it work 
> out for now. We'll need the full 64-bit index eventually for sure, but..

Yes.  ;-)

-- 
Shawn.
