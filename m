From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Gittorent .. avahi ?
Date: Tue, 3 Apr 2007 01:31:45 -0400
Message-ID: <20070403053145.GF15922@spearce.org>
References: <9d916d5b0704011059g31394159kfdd5e01ba81915c2@mail.gmail.com> <46106AD3.6000204@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Srijak Rijal <srijak@gmail.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 07:31:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYbcX-0005j0-To
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 07:31:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752864AbXDCFbv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 01:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752851AbXDCFbu
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 01:31:50 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51682 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbXDCFbt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 01:31:49 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYbcQ-0006lA-L1; Tue, 03 Apr 2007 01:31:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5805F20FBAE; Tue,  3 Apr 2007 01:31:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <46106AD3.6000204@vilain.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43613>

Sam Vilain <sam@vilain.net> wrote:
...
> I think in BitTorrent there is an *over*-emphasis on making the tracker
> load light, because people want to be able to run them on the most
> dirt-cheap hosting account they can find, because they might get shut
> down and don't want a huge outlay.  But with GitTorrent, a large number
> of the tracker providers are going to be software houses, and people
> already running mirroring services - and so the increased load will be
> more than justified by the reduced overall load.
...

Yes, I agree entirely.  Almost anyone who is going to be running a
tracker for GitTorrent would already today be running the anonymous
Git daemon.  These users (ahm... kernel.org) would like to reduce
load on their servers if clients can get the data from elsewhere.
Hosting a tracker is still load, but should be a *much* lower load.

Note that kernel.org's entire load appears to be disk IO (as stated
by hpa on many occasions).  A little bit of extra CPU and network
bandwidth (for tracker maintenance) to cut disk IO in half (due to
less object directory accesses) would probably be major improvement
for them, and would still cut their overall network bandwidth as
clients would get packs from other nodes in the P2P system.

> Anyway, the old warning about scope creep applies to this idea - working
> from the bottom up is a lot better for getting things done than thinking
> big.  Just look at me, I think big all the time and never get anything
> done ;-)  There will be a lot of interesting technologies enabled by
> gittorrent.

I agree.  The biggest risk to any GSoC project is not the student,
or the community, or the technology... but its scope creep.
Of course this is true of *any* project.

Git evolved.  Linux evolved.  Apache evolved.  None of them set
out on day one with a huge list of "must have" features that they
coded from scratch.  Every one of those projects organically grew
as new features were desired and old bugs fixed.[*1*]


[*1*] Yes, I know, Linus did set out when writing both Linux and
      Git to create something that did X... but X was a pretty
      small concept.  Git started as a "track Linus' state thing",
      not as a full SCM.  ;-)

-- 
Shawn.
