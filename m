From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Teach git-gui to split hunks
Date: Thu, 13 Dec 2007 02:48:25 -0500
Message-ID: <20071213074825.GX14735@spearce.org>
References: <402731c90712111254q1cb99c6al47538971d93b4592@mail.gmail.com> <31e9dd080712111329j2c8b22ebs38ab727a5fbe85fb@mail.gmail.com> <20071212041002.GN14735@spearce.org> <31e9dd080712112113u44b30c62ja012951fba958c5d@mail.gmail.com> <20071212052329.GR14735@spearce.org> <31e9dd080712120702k36a959cfh3e2a5c5fb076d922@mail.gmail.com> <Pine.LNX.4.64.0712121814260.27959@racer.site> <31e9dd080712121050i45981ed5u845b71f0e73aa8e2@mail.gmail.com> <Pine.LNX.4.64.0712121931050.27959@racer.site> <4760E0CF.1030805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jason Sewall <jasonsewall@gmail.com>, David <davvid@gmail.com>,
	Marco Costalba <mcostalba@gmail.com>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 13 08:48:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2ioQ-0001ar-QG
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 08:48:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759527AbXLMHsc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 02:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759407AbXLMHsc
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 02:48:32 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:46928 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758802AbXLMHsb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 02:48:31 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1J2iny-0007y6-FV; Thu, 13 Dec 2007 02:48:26 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E82F720FBAE; Thu, 13 Dec 2007 02:48:25 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4760E0CF.1030805@viscovery.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68129>

Johannes Sixt <j.sixt@viscovery.net> wrote:
> Johannes Schindelin schrieb:
> > When you select the context menu item "Split Hunk" in the diff area,
> > git-gui will now split the current hunk so that a new hunk starts at
> > the current position.
> > 
> > For this to work, apply has to be called with --unidiff-zero, since
> > the new hunks can start or stop with a "-" or "+" line.
> 
> NACK! --unidiff-zero eats your data.

Yea, don't worry about that, I won't be applying any patch to git-gui
that feeds data to git-apply with --undiff-zero.  Not unless its
completely bullet-proof that the hunk headers will *never* be wrong.

I'd rather always apply with context and let git-apply do its thing
to validate the hunks.  If you can get the hunk headers computed
right you can also get the context computed right, which means
git-apply can actually verify the patch can be applied, thus double
checking the splitter.
 
> Reason: --unidiff-zero can only look at the line numbers. And those are
> wrong because it doesn't account for the shift in line numbers caused by the
> first hunk.

-- 
Shawn.
