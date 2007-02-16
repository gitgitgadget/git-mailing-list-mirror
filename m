From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] pretend-sha1: grave bugfix.
Date: Fri, 16 Feb 2007 00:09:43 -0500
Message-ID: <20070216050943.GD28894@spearce.org>
References: <7v3b56dhr1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702160503290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 16 06:09:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHvM0-0005u9-TN
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 06:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423246AbXBPFJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 00:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423247AbXBPFJs
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 00:09:48 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:44588 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423246AbXBPFJs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 00:09:48 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHvLg-0005nY-PR; Fri, 16 Feb 2007 00:09:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ABF0420FBAE; Fri, 16 Feb 2007 00:09:43 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702160503290.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39888>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 15 Feb 2007, Junio C Hamano wrote:
> 
> >  * I wonder how recent merge-recursive with multiple merge bases
> >    (or an empty one) ever worked with this bug.  Am I
> >    hallucinating?
> 
> Probably the fact helped that merge-recursive only pretends 
> zero-sized blobs.

Most definately.  We never look at the pointer to an object's data if
len == 0, which it does in this case of merge-recursive's empty tree.

Aren't we using this for git-blame --contents?  How'd that ever
work for a non-empty file?

-- 
Shawn.
