From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC Patch] Preventing corrupt objects from entering the repository
Date: Thu, 14 Feb 2008 01:16:51 -0500
Message-ID: <20080214061651.GH24004@spearce.org>
References: <20080210175812.GB12162@auto.tuwien.ac.at> <7vmyq8cqfn.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101929310.2732@xanadu.home> <20080211195623.GA21878@auto.tuwien.ac.at> <alpine.LFD.1.00.0802111513360.2732@xanadu.home> <20080211215806.GA24971@auto.tuwien.ac.at> <alpine.LFD.1.00.0802120937330.2732@xanadu.home> <20080213074209.GG24004@spearce.org> <20080213081128.GA27730@auto.tuwien.ac.at> <alpine.LSU.1.00.0802131200410.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Nicolas Pitre <nico@cam.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 14 07:17:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPXPu-0001tV-Ez
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 07:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756256AbYBNGRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 01:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756057AbYBNGRS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 01:17:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57189 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755503AbYBNGRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 01:17:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JPXOw-0003Nh-Oe; Thu, 14 Feb 2008 01:16:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7336A20FBAE; Thu, 14 Feb 2008 01:16:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802131200410.30505@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73848>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 13 Feb 2008, Martin Koegler wrote:
> 
> > This would mean, that we must make git-rev-list and git-pack-objects not 
> > segfault on incorrect links between objects.

My proposal suggested that malformed objects not be allowed
into the repository, so rev-list wouldn't see them in the
first place.
 
> We should do that anyway.  It may error out, but segfaulting is no option.
> 
> So if you have a test case, please make it public so we can fix the 
> breakage.

But Dscho has a really good point here.  rev-list should be failing
with a proper exit code, not SIGSEGV.  :)

-- 
Shawn.
