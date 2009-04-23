From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: dangling commits and blobs: is this normal?
Date: Thu, 23 Apr 2009 10:56:13 -0700
Message-ID: <20090423175612.GV23604@spearce.org>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home> <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221548310.6741@xanadu.home> <20090422200502.GA14304@coredump.intra.peff.net> <064C9132-2E72-4665-A44D-A2F4194DAC2B@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 19:57:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx3BE-0003GI-LG
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 19:57:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753301AbZDWR4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 13:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753005AbZDWR4O
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 13:56:14 -0400
Received: from george.spearce.org ([209.20.77.23]:33537 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752812AbZDWR4O (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 13:56:14 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 6268138211; Thu, 23 Apr 2009 17:56:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <064C9132-2E72-4665-A44D-A2F4194DAC2B@adacore.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117351>

Geert Bosch <bosch@adacore.com> wrote:
> significant
> speedups, especially during large imports that currently require  
> frequent
> repacking of the entire repository.

Large imports should be using fast-import, and then issue a single
massive `git repack -f --window=250 --depth=50` or some such repack
command after the entire import is complete.

If your favorite import tool (*cough* git-svn *cough*) can't use
fast-import, and you are importing a large enough repository that
this matters to you, use another importer that can use fast-import.

-- 
Shawn.
