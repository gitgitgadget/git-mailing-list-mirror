From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Thu, 1 Feb 2007 17:14:39 -0500
Message-ID: <20070201221439.GC19057@spearce.org>
References: <20070201220122.GF17617@mellanox.co.il> <20070201220657.GB19271@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 23:15:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCkDK-000695-47
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 23:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbXBAWOr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 17:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685AbXBAWOr
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 17:14:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48531 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680AbXBAWOq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 17:14:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCkCP-0006W1-4H; Thu, 01 Feb 2007 17:14:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C0B5C20FBAE; Thu,  1 Feb 2007 17:14:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070201220657.GB19271@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38416>

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Fri, Feb 02, 2007 at 12:01:22AM +0200, Michael S. Tsirkin wrote:
> > I'm often annoyed by the fact that when I clone from this repository,
> > I get a copy of all topic branches and origin tracking master
> > by default, when I actually might only want to work on a different
> > topic. And getting all extra branches is annoying on a slow connection.
> 
> Can you quantify "annoying"?
> 
> Not a challenge, I'm just curious--I would've thought that, for most
> projects, even with long-lived topic branches, it wouldn't be that
> expensive to get a second branch once you'd gotten one.

Not true; I work on projects like that and some of the branches
are several MiB of additional objects beyond the other branches.
It can add up very, very fast.

Over slow corporate VPN connections this is definately a problem.
Usually the user only wants one branch *right now*.  Getting another
15 MiB of data for branches which they aren't interested in could
take another 5 minutes.  If they do need those, they could always
fetch the additional branches later, or do it from the office where
the network doesn't suck.

-- 
Shawn.
