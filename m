From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] describe match pattern for soft tags too
Date: Tue, 3 Jun 2008 18:42:26 -0400
Message-ID: <20080603224225.GN12896@spearce.org>
References: <alpine.LNX.1.10.0806031957360.3605@pollux> <alpine.DEB.1.00.0806032124040.13507@racer.site.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 04 00:43:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3fDw-0004PP-Ec
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 00:43:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108AbYFCWmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 18:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751725AbYFCWmb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 18:42:31 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:50652 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971AbYFCWmb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 18:42:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K3fCs-0007rv-ER; Tue, 03 Jun 2008 18:42:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2035920FBAE; Tue,  3 Jun 2008 18:42:26 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806032124040.13507@racer.site.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83721>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 3 Jun 2008, Michael Dressel wrote:
> 
> > So far git describe --match <pattern> would apply the <pattern> only
> > to tag objects not to soft tags.
> 
> And I thought that was what --tags was for.

Yes.  However there is a bug in git-describe's implementation;
--match only tested on annotated tags.  The test was buried inside
of the block that handles the annotated case.  Michael's patch pulls
this test outside where it can apply to lightweight tags when --tags
is included on the command line.

-- 
Shawn.
