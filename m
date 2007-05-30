From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Git wrapper: add --redirect-stderr option
Date: Tue, 29 May 2007 23:53:35 -0400
Message-ID: <20070530035335.GP7044@spearce.org>
References: <Pine.LNX.4.64.0705291446170.4648@racer.site> <465C3502.BE134BC9@eudaptics.com> <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com> <465C4B0E.C34795B@eudaptics.com> <465CDE61.40103@xs4all.nl> <Pine.LNX.4.64.0705300337510.4011@racer.site> <20070530025705.GN7044@spearce.org> <Pine.LNX.4.64.0705300407170.4011@racer.site> <20070530033830.GO7044@spearce.org> <Pine.LNX.4.64.0705300444020.4011@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 30 05:53:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtFFt-0006pC-7L
	for gcvg-git@gmane.org; Wed, 30 May 2007 05:53:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXE3Dxn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 23:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbXE3Dxn
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 23:53:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43446 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbXE3Dxn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 23:53:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtFFW-00075q-1p; Tue, 29 May 2007 23:53:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 404F020FBAE; Tue, 29 May 2007 23:53:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705300444020.4011@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48733>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> On Tue, 29 May 2007, Shawn O. Pearce wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > 
> > > With this option, stderr is redirected to stdout. The short option is '-2'.
> > > 
> > > Alternatively, you can say '--redirect-stderr=<filename>' to redirect
> > > stderr to a file.
> > 
> > Yes, that works nicely.  ;-)
> > 
> > Now here's my other problem: How does git-gui know the underlying
> > git will accept --redirect-stderr?  Or that it supports any other
> > recent features we've developed?
> 
> I thought that git-gui is now really closely coupled with core-git.

Not really.  It requires 1.5.0 and later, but after that it should
be OK with any 1.5.x version of Git.  Junio graciously bundles it
with core Git, to help it get a wider audience.  ;-)

However I'd like to let it be smarter about what it expects from the
underling core Git.  I'm sure the other Porcelain authors would also
like to be able to determine if they can rely on something, or not.
At the least we can just tell the user "Your Git old.  Upgrade to new
Git today!".  Yes, bad Engrish included... ;-)
 
> > Sure I can check the version, but until I know what version of Git
> > its shipping in I cannot put the check into git-gui.
> > 
> > I was thinking about adding a "git-supported-features" plumbing
> > command that prints back feature code strings, much as our
> > network protocol supplies back the few feature codes it supports
> > ("multi-ack", "sideband", etc.).
> 
> Problem is: it would be more interesting to have this program in _older_ 
> versions... ;-)

Lack of git-supported-features means only features before it coming
into existance?  ;-)

-- 
Shawn.
