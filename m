From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Fix infinite loop when deleting multiple packed refs.
Date: Tue, 2 Jan 2007 03:47:41 -0500
Message-ID: <20070102084741.GA28898@spearce.org>
References: <b566b20c0701012244l21f85472k83970c0c573ce105@mail.gmail.com> <20070102081709.GA28779@spearce.org> <7vtzz9x1fo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 02 09:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1fJF-0006f0-GA
	for gcvg-git@gmane.org; Tue, 02 Jan 2007 09:47:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932994AbXABIrq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 Jan 2007 03:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932996AbXABIrq
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jan 2007 03:47:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52146 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932994AbXABIrq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jan 2007 03:47:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H1fJ8-0001Z8-JJ; Tue, 02 Jan 2007 03:47:42 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5A1B420FB65; Tue,  2 Jan 2007 03:47:41 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vtzz9x1fo.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35782>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >  Fixed.  ;-)
> >
> >  Junio, this applies to master, but hopefully could also apply to
> >  maint, as the bug also shows up there.
> 
> I see a few instances of single static lock_file variable in our
> code, but all of them seem to be locking the index and only
> once, so they should be safe.
> 
> Thanks.

I just realized that my patch used 'calloc' and not 'xcalloc'.
Would you mind correcting it for me?  ;-)

-- 
Shawn.
