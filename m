From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 01:28:13 -0500
Message-ID: <20070212062813.GE699@spearce.org>
References: <200702111252.28393.bruno@clisp.org> <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de> <200702120041.27419.bruno@clisp.org> <200702120059.17676.robin.rosenberg.lists@dewire.com> <7vmz3kaugq.fsf@assigned-by-dhcp.cox.net> <20070212060641.GC699@spearce.org> <7vmz3jaorx.fsf@assigned-by-dhcp.cox.net> <20070212062224.GD699@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Bruno Haible <bruno@clisp.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 07:28:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGUfp-0006hk-Sc
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 07:28:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933029AbXBLG2X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 01:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933030AbXBLG2X
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 01:28:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35873 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933029AbXBLG2W (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 01:28:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGUff-0004DC-Do; Mon, 12 Feb 2007 01:28:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D0D2920FBAE; Mon, 12 Feb 2007 01:28:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070212062224.GD699@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39377>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Junio C Hamano <junkio@cox.net> wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > > So I ran three trials, v1.5.0-rc4-26-gcc46a74 with and without
> > > NO_MMAP against v1.4.4.4 on a freshly repacked git.git.

I probably should have mentioned, my run (in all cases) was:

	git rev-list HEAD -- Makefile 2>/dev/null

cheap, a file that exists pretty much everywhere, and that triggers
the path limiter in the revision walking code.

BTW, I discovered by accident tonight that this works:

	cp git-rev-list ../git-1444
	../git-1444 rev-list

which is so not something I would have expected.  :-) I honestly
expected the wrapper to puke and say it doesn't know what command
1444 is.

-- 
Shawn.
