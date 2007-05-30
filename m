From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Git wrapper: add --redirect-stderr option
Date: Tue, 29 May 2007 23:38:30 -0400
Message-ID: <20070530033830.GO7044@spearce.org>
References: <Pine.LNX.4.64.0705291305540.4648@racer.site> <465C2516.7040607@trolltech.com> <Pine.LNX.4.64.0705291446170.4648@racer.site> <465C3502.BE134BC9@eudaptics.com> <fcaeb9bf0705290828j3703cfa9g11f2f7afb17a8c91@mail.gmail.com> <465C4B0E.C34795B@eudaptics.com> <465CDE61.40103@xs4all.nl> <Pine.LNX.4.64.0705300337510.4011@racer.site> <20070530025705.GN7044@spearce.org> <Pine.LNX.4.64.0705300407170.4011@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Johannes Sixt <J.Sixt@eudaptics.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Marius Storm-Olsen <marius@trolltech.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 30 05:38:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtF1K-0004Rx-I7
	for gcvg-git@gmane.org; Wed, 30 May 2007 05:38:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751249AbXE3Dii (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 23:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbXE3Dii
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 23:38:38 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43203 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249AbXE3Dih (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 23:38:37 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtF0u-0006H3-TD; Tue, 29 May 2007 23:38:20 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 10F6220FBAE; Tue, 29 May 2007 23:38:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705300407170.4011@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48731>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> With this option, stderr is redirected to stdout. The short option is '-2'.
> 
> Alternatively, you can say '--redirect-stderr=<filename>' to redirect
> stderr to a file.

Yes, that works nicely.  ;-)

Now here's my other problem: How does git-gui know the underlying
git will accept --redirect-stderr?  Or that it supports any other
recent features we've developed?

Sure I can check the version, but until I know what version of Git
its shipping in I cannot put the check into git-gui.

I was thinking about adding a "git-supported-features" plumbing
command that prints back feature code strings, much as our
network protocol supplies back the few feature codes it supports
("multi-ack", "sideband", etc.).  E.g.:

  $ git supported-features
  redirect-stderr
  ...

That way higher level Porcelain can poll the plumbing to see what
is available, and what isn't.

-- 
Shawn.
