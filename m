From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/6] packed deltas with offset to base instead of sha1
Date: Thu, 21 Sep 2006 12:02:27 -0400
Message-ID: <20060921160227.GC3934@spearce.org>
References: <Pine.LNX.4.64.0609202350450.2627@xanadu.home> <7v4pv1eqgl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 18:05:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQR0d-0003Zc-Mr
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 18:02:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWIUQCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 12:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWIUQCk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 12:02:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53148 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751299AbWIUQCj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 12:02:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQR0J-0001SA-Ut; Thu, 21 Sep 2006 12:02:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BAC1A20FB16; Thu, 21 Sep 2006 12:02:27 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4pv1eqgl.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27481>

Junio C Hamano <junkio@cox.net> wrote:
> Nicolas Pitre <nico@cam.org> writes:
> 
> > The following patches are the result of my work to allow deltas to have
> > their base specified as an offset within a pack instead of a 20 byte 
> > sha1.
> >
> > This turned to be somewhat more involved than I originally expected. 
> > Given the relative pack reduction resulting from that, I might have 
> > decided against doing this if I had known beforehand how much work was 
> > needed.
> >
> > But since it is done now I think it is worth merging nevertheless.  Some 
> > parts are still pure code cleanups anyway.
> >
> > Overall the larger projects are likely to benefit more as they have a 
> > larger proportion of deltas.  On the historic Linux archive the pack 
> > reduction is about 5%.
> 
> Nice, although I suspect this would make it a bit more involved
> to merge a few outstanding stuff.

If you are talking about my mmap window code merge in Nico's
work first.  Nico posted before me and did so with a working
implementation that looks good (at first glance anyway, I didn't
study it in detail).  I have yet to finish merging my mmap code
onto your verify delta before reuse (106d710b) commits.  I've just
been too busy with classes and research work to get around to it.

However I have looked at the merge and I more or less need to
rewrite a good chunk of it just to get it onto 106d7; rewriting it
onto Nico's work here is probably going to be about the same amount
of effort.  I'd prefer to rewrite it only once, given how limited
my time has suddenly become.

-- 
Shawn.
