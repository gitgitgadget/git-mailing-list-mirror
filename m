From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Dangers of working on a tracking branch
Date: Thu, 15 Feb 2007 17:09:18 -0500
Message-ID: <20070215220918.GB27526@spearce.org>
References: <17876.51013.561979.431717@lisa.zopyra.com> <Pine.LNX.4.64.0702151557410.1757@xanadu.home> <17876.52962.662946.582507@lisa.zopyra.com> <17876.53654.426022.454712@lisa.zopyra.com> <20070215214352.GA2980@coredump.intra.peff.net> <17876.54845.708466.669437@lisa.zopyra.com> <20070215215816.GA3757@coredump.intra.peff.net> <17876.55542.236594.121347@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Feb 15 23:09:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHon9-0004no-0T
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 23:09:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161467AbXBOWJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Feb 2007 17:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161469AbXBOWJY
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Feb 2007 17:09:24 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33365 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161467AbXBOWJX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Feb 2007 17:09:23 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHomu-0006Wu-J5; Thu, 15 Feb 2007 17:09:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 53D4A20FBAE; Thu, 15 Feb 2007 17:09:19 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17876.55542.236594.121347@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39857>

Bill Lear <rael@zopyra.com> wrote:
> On Thursday, February 15, 2007 at 16:58:16 (-0500) Jeff King writes:
> >On Thu, Feb 15, 2007 at 03:53:01PM -0600, Bill Lear wrote:
> >> Sure, it is easy, but it's surprising to (our) users when they
> >> do a clone and can't "jump right in", and have to spend 3 seconds
> >> doing the above...
> >
> >Fair enough. It should be pretty simple to implement; why don't you try
> >working up a patch? :)
> 
> Well, I seriously thought about it, but the git-clone code is pretty
> dense.  It might be educational though, and since I'm the only one
> who wants it ... might be worth a shot.

Careful.

Lets say you patch git-clone to create these branches under
refs/heads, and also under refs/remotes/origin.  Now someone else
modifies one of those branches, and you do a git-fetch to get the
latest.  The tracking branch under refs/remotes/origin would update,
but not the one in refs/heads.  Which means "jumping right in" may
actually cost you a lot more time, because you are now starting on
something that is several days old.

-- 
Shawn.
