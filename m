From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Tue, 5 Sep 2006 23:40:54 -0400
Message-ID: <20060906034054.GB30598@spearce.org>
References: <200609050054.24279.jnareb@gmail.com> <200609050056.52590.jnareb@gmail.com> <7vy7szjjal.fsf@assigned-by-dhcp.cox.net> <edidlp$d3d$1@sea.gmane.org> <20060905030929.GA29865@spearce.org> <7vu03mkiei.fsf@assigned-by-dhcp.cox.net> <20060905062531.GA30496@spearce.org> <7v1wqqkbbv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 06 09:04:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKrSQ-0004LM-4D
	for gcvg-git@gmane.org; Wed, 06 Sep 2006 09:04:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWIFHEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Sep 2006 03:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbWIFHEN
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Sep 2006 03:04:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8890 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751197AbWIFHEM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Sep 2006 03:04:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GKrSD-0002Pd-2T; Wed, 06 Sep 2006 03:04:09 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C43E7212696; Tue,  5 Sep 2006 23:40:54 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wqqkbbv.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26504>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I don't know if I've made this more complex than I really need to
> > but I've permitted multiple windows per pack.  There is just one
> > LRU of all windows across all packs and a maximum amount of address
> > space to use for pack mappings.  Least recently used window gets
> > tossed when we need a different window.  This permits us to keep
> > say a window active on the front of a pack (near the commits) and
> > another different active window closer to the back (near the blobs).
> 
> Sounds good. That is exactly what I was expecting it to be done.

So I have this implemented but its against the 32 bit index.
It passes the full test suite and appears to be working as intended.

I am going to rebase the changes to the 64 bit index in `pu`
and clean up my history.  Its currently one massive commit with
lots of changes that should be broken down into slightly more
digestable chunks.

I'll try to do that tonight and get a patch series out.  My email
is currently proving to be unstable so you may not get the series
until later on Wed.

-- 
Shawn.
