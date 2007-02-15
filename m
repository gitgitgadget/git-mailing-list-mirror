From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 17:49:02 -0500
Message-ID: <20070215224902.GB27992@spearce.org>
References: <17876.51013.561979.431717@lisa.zopyra.com> <Pine.LNX.4.64.0702151557410.1757@xanadu.home> <17876.52962.662946.582507@lisa.zopyra.com> <17876.53654.426022.454712@lisa.zopyra.com> <20070215214352.GA2980@coredump.intra.peff.net> <17876.54845.708466.669437@lisa.zopyra.com> <20070215215816.GA3757@coredump.intra.peff.net> <17876.55542.236594.121347@lisa.zopyra.com> <20070215220918.GB27526@spearce.org> <17876.57692.818802.89118@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 23:49:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHpPd-0007UL-4l
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 23:49:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161620AbXBOWtJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 17:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161624AbXBOWtJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 17:49:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34859 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161620AbXBOWtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 17:49:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHpPL-0002lq-Fp; Thu, 15 Feb 2007 17:48:55 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D2D3920FBAE; Thu, 15 Feb 2007 17:49:02 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17876.57692.818802.89118@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39863>

Bill Lear <rael@zopyra.com> wrote:
> On Thursday, February 15, 2007 at 17:09:18 (-0500) Shawn O. Pearce writes:
> >...
> >Lets say you patch git-clone to create these branches under
> >refs/heads, and also under refs/remotes/origin.  Now someone else
> >modifies one of those branches, and you do a git-fetch to get the
> >latest.  The tracking branch under refs/remotes/origin would update,
> >but not the one in refs/heads.  Which means "jumping right in" may
> >actually cost you a lot more time, because you are now starting on
> >something that is several days old.
> 
> Granted, but this would be the same as creating the branch by hand,
> then going rock-climbing over the weekend, while my colleagues toiled,
> and coming back on Monday to find 15 checkins on that branch, right?

Yes.  Although if you pull something like that, your colleagues
may also be muttering things about you near the water cooler...
So Git may be the least of your problems.  ;-)
 
> At which point I could .... rebase?  Do a pull?

Rebase or pull, either would work.  Rebase would clutter the
history less (no merge) but also tosses some history (no merge).
Its a tossup.

All I was trying to say was this may be more likely to happen,
as you will clone, work in that repository for a couple of weeks,
then get told to look at the `frotz` branch, as it has all the cool
stuff you were looking for.  You peek at refs/heads/frotz, and
it has some cool stuff, but its 2 weeks out of date.  Unless you
remember to pull `origin/frotz` to `frotz` first, you might spend
a while looking at stale code.

-- 
Shawn.
