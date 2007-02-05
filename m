From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Deprecation/Removal schedule
Date: Mon, 5 Feb 2007 05:25:06 -0500
Message-ID: <20070205102506.GB14234@spearce.org>
References: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net> <eq6tj6$80m$2@sea.gmane.org> <eq6vq5$r7v$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 11:25:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE12M-0002lo-2F
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 11:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbXBEKZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 05:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbXBEKZL
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 05:25:11 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41283 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbXBEKZK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 05:25:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HE121-0002s2-WE; Mon, 05 Feb 2007 05:25:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BCF1B20FBAE; Mon,  5 Feb 2007 05:25:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <eq6vq5$r7v$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38739>

Jakub Narebski <jnareb@gmail.com> wrote:
> An alternative for importers would be to move them into contrib area
> (I think unmaintained but not obsolete programs can be there in contrib).

Sure, but we don't want to promote carrying around unmaintained
programs in core Git.  Its additional code which must still be
tested or fixed when changes get made, like the final removal of
the fsck-objects alias.  Hence, its never really unmaintained...
someone must do the work.

Having a maintainer means there are one or more persons in the
community who are making sure that chunk of code stays current
when changes are made, and bugs are being fixed when identified.
It also implies the code has some use, as it is unreasonable to
expect a maintainer to invest time in something which has no value.

Things that are really central in Git have at least 3 or 4
maintainers who seem to rotate the workload fairly well.  But as
you get closer to the outer (higher) layers it seems to fall on
Junio and a much smaller group.  I'd hate to see Junio spend lots
of time working on things nobody uses.

Importers are especially problematic.  They aren't the most
heavily used programs, as people tend to convert to Git once and
then don't look back.  But they are also one of the first things a
user has experience with as they testdrive Git on a copy of their
own project.  So any importers we ship `out of the box' need to
Just Work Danngit(tm).  Unfortunately they are also get the least
amount of testing.

-- 
Shawn.
