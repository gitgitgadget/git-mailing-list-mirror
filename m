From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/3] fast-import: tree allocation cleanups
Date: Mon, 12 Mar 2007 15:16:39 -0400
Message-ID: <20070312191639.GD15887@spearce.org>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192114.GA3875@coredump.intra.peff.net> <20070311032147.GA10781@spearce.org> <20070311155138.GA7110@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:16:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQq0k-0000sD-6V
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752266AbXCLTQn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752344AbXCLTQn
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:16:43 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51689 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266AbXCLTQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:16:42 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQq0W-0008P8-C5; Mon, 12 Mar 2007 15:16:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1B9F620FBAE; Mon, 12 Mar 2007 15:16:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070311155138.GA7110@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42061>

Jeff King <peff@peff.net> wrote:
> On Sat, Mar 10, 2007 at 10:21:47PM -0500, Shawn O. Pearce wrote:
> > > +	name = to_atom(p, n);
> > [...]
> > > -	e->name = to_atom(p, (unsigned short)n);
> > 
> > You missed an unsigned short cast here.
> 
> Actually, I removed it intentionally (though clearly I should have
> documented it). It's casting from an unsigned int to an unsigned short.
> Such a cast is at best pointless (since the compiler performs the exact
> same cast implicitly -- see C99 6.5.2.2, paragraph 7), and at worst
> masks an error (e.g., if the type of n is changed).

Hmm.  You are probably right.  I had put that cast into place before
because (if I recall correctly) I was getting compiler errors.
But today looking at it I'm not, even if I remove the casts.  So uh,
yea... they should probably come out.

-- 
Shawn.
