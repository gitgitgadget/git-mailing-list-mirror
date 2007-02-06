From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-fast-import
Date: Tue, 6 Feb 2007 16:15:47 -0500
Message-ID: <20070206211547.GB5820@spearce.org>
References: <20070206023111.GB9222@spearce.org> <Pine.LNX.4.64.0702052248070.19212@xanadu.home> <20070206054808.GA10508@spearce.org> <Pine.LNX.4.64.0702060829310.8424@woody.linux-foundation.org> <20070206165630.GB4949@spearce.org> <Pine.LNX.4.64.0702060913220.8424@woody.linux-foundation.org> <Pine.LNX.4.64.0702061329090.19212@xanadu.home> <20070206200924.GA5352@spearce.org> <Pine.LNX.4.64.0702061559160.13009@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Feb 06 22:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEXgG-0006XX-PC
	for gcvg-git@gmane.org; Tue, 06 Feb 2007 22:16:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965506AbXBFVQH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 16:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965499AbXBFVQG
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 16:16:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52796 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965490AbXBFVQE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 16:16:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HEXfA-0000MJ-Fb; Tue, 06 Feb 2007 16:15:40 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C118420FBAE; Tue,  6 Feb 2007 16:15:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702061559160.13009@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38874>

Nicolas Pitre <nico@cam.org> wrote:
> I think you should call it something else than rfc2822.  Because 
> parse_date() accepts much more than just rfc2822.  What about "cooked"?

It does accept a lot more than that, but straying away from rfc2822
gets into the grey areas of parse_date().  E.g. it matches crap such
as 'yyyy-mm-dd' or 'yyyy-dd-mm'.  But that is completely ambiguous!

I don't really want to advertise that it is accepting non-RFC 2822
input here.  I was thinking of doing an `iso` (yyyy-mm-dd hh:mm:ss)
format, which may just defer into parse_date(), but again encourage
the frontend to *only* feed that ISO style format.

-- 
Shawn.
