From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 6/9] Use uint32_t for pack-objects counters.
Date: Wed, 7 Mar 2007 15:37:21 -0500
Message-ID: <20070307203721.GD27922@spearce.org>
References: <20070307014424.GG26482@spearce.org> <7v1wk0g9mp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 07 21:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HP2t8-0002xM-3y
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 21:37:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965636AbXCGUh0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 15:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965641AbXCGUh0
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 15:37:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51026 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965636AbXCGUhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 15:37:25 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HP2st-0005SX-L4; Wed, 07 Mar 2007 15:37:15 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE13020FBAE; Wed,  7 Mar 2007 15:37:21 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7v1wk0g9mp.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41690>

Junio C Hamano <junkio@cox.net> wrote:
> I may not be reading the patch correctly, but doesn't this make
> find_deltas() logic to scan the list backwards?  We sort the
> list by type and size before we enter this, so that we scan from
> bigger to smaller, because we prefer to leave biggest as a base
> and represent smaller ones as deltas (removing deltas do not
> have to record preimage and tend to be much smaller than adding
> deltas).  I suspect this change may affect that optimization.

Its always scanned backwards.  I've read the patch like 8 times
now (and I just reread the part you quoted).  The patch implements
the same backwards scan that has always been there.  Linus put it
backwards for the exact reason you state; bigger objects are near
the end of the array (see type_size_sort).

-- 
Shawn.
