From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Notes on Using Git with Subprojects
Date: Thu, 28 Sep 2006 00:09:31 -0400
Message-ID: <20060928040931.GE22897@spearce.org>
References: <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com> <20060927173335.GC2807@coredump.intra.peff.net> <451B45D6.1010006@gmail.com> <20060928035225.GA22006@coredump.intra.peff.net> <20060928035855.GD22897@spearce.org> <20060928040027.GA22489@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Martin Waitz <tali@admingilde.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 06:09:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSnDS-0000mW-HD
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 06:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031355AbWI1EJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 00:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWI1EJi
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 00:09:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55527 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965279AbWI1EJh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 00:09:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GSnD7-0004By-In; Thu, 28 Sep 2006 00:09:21 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CACC720FB28; Thu, 28 Sep 2006 00:09:31 -0400 (EDT)
To: Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <20060928040027.GA22489@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27984>

Jeff King <peff@peff.net> wrote:
> On Wed, Sep 27, 2006 at 11:58:55PM -0400, Shawn Pearce wrote:
> 
> > If you are fetching a set of commits from a repository you probably
> > should be fetching any tags that point at the commits you've fetched.
> > They tend to be few compared to the commits, they tend to be small,
> > and they tend to be important milestones in the tracked project.
> > 
> > I think that's why the native Git protocol sends tags for any
> > commits that were also sent.  :)
> 
> Oh, that's clever. :)
> 
> Do we do the right thing for non-git transports?

Yes, I think we do.

Only its not quite as clever as the HTTP/FTP commit walker first
needs to get a list of available refs (which includes tag and
tag^{}) and compares each obtained commit to the ^{} entries.
If there's a match it gets the tag.

And rsync being as dumb as it is should be fetching everything. :)

-- 
Shawn.
