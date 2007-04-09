From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: support for large packs and 64-bit offsets
Date: Mon, 9 Apr 2007 15:53:22 -0400
Message-ID: <20070409195322.GB5436@spearce.org>
References: <11760951973172-git-send-email-nico@cam.org> <20070409171925.GS5436@spearce.org> <alpine.LFD.0.98.0704091328130.28181@xanadu.home> <20070409174305.GU5436@spearce.org> <7vtzvpz5tu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Apr 10 01:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hazvg-0001lx-8J
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 21:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbXDITx3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 15:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753490AbXDITx3
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 15:53:29 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44275 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753488AbXDITx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 15:53:28 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HazvQ-0001iy-Mr; Mon, 09 Apr 2007 15:53:16 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EE35B20FBAE; Mon,  9 Apr 2007 15:53:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vtzvpz5tu.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44080>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Nicolas Pitre <nico@cam.org> wrote:
> > ...
> > Here's something we didn't think about, but that occurred to me today
> > when reading this series: If we move the SHA-1 table out of the index
> > and into the packfile (like we are planning) dumb commit-walkers
> > (http-fetch) will have problems.  Right now they download the
> > indexes of every available packfile to determine if they need to
> > download the corresponding packfile to obtain a needed object.
> 
> If we really care about older dumb clients, one option is to
> generate not .idx but .idx2, and have a corresponding .idx only
> to support them.  But at that point, it's probably cleaner to
> have an explicit option to produce .idx file of a particular
> version, and tell people to pack public repositories they expect
> older dumb clients to access with that option to keep things
> backward compatible.

Sure, fine.  But I think you missed my point above - right now if
we move the SHA-1 table out of the .idx file I'm not sure we know
how to support the dumb clients *at all*.  Even if they understand
the latest-and-greatest file formats...

-- 
Shawn.
