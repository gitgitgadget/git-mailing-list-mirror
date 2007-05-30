From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Test for recent rev-parse $abbrev_sha1 regression
Date: Wed, 30 May 2007 01:58:06 -0400
Message-ID: <20070530055806.GQ7044@spearce.org>
References: <20070530045026.GA12380@spearce.org> <7vlkf6508y.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed May 30 07:58:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtHCL-00075Q-Ex
	for gcvg-git@gmane.org; Wed, 30 May 2007 07:58:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbXE3F6M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 May 2007 01:58:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbXE3F6M
	(ORCPT <rfc822;git-outgoing>); Wed, 30 May 2007 01:58:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45196 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbXE3F6L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2007 01:58:11 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtHCC-0003DG-QZ; Wed, 30 May 2007 01:58:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D64BE20FBAE; Wed, 30 May 2007 01:58:06 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vlkf6508y.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48741>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > My recent patch "Lazily open pack index files on demand" caused a
> > regression in the case of parsing abbreviated SHA-1 object names.
> > Git was unable to translate the abbreviated name into the full name
> > if the object was packed, as the pack .idx files were not opened
> > before being accessed.
> 
> Thanks.  As long as we catch it before it goes to 'master', it
> is not a regression ;-)
 
Good point.  Next time I won't call it a regression.

But to me, anything that hits 'next' that breaks Git this badly is
a regression.  Why?  Because I run my production repositories off
next, that's why.  Of course I do this to exercise next more fully...
to prevent this sort of stuff from getting to master.  ;-)

For what its worth, I'm going through the code again and auditing
our use of the index related variables in packed_git that are now
lazily loaded.  I'm not seeing anything that is critical.  I do
have two minor patches queued up, but they are just to make things
look prettier.  Will send soon.

-- 
Shawn.
