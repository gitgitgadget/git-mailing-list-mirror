From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 4/4] Replace fork_with_pipe in bundle with run_command
Date: Mon, 12 Mar 2007 20:56:21 -0400
Message-ID: <20070313005621.GA17243@spearce.org>
References: <20070312183815.GD15996@spearce.org> <7vslcaow13.fsf@assigned-by-dhcp.cox.net> <20070313003646.GA17169@spearce.org> <7v3b4aotd9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 13 01:56:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQvJV-00027Y-O0
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 01:56:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752596AbXCMA41 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 20:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbXCMA41
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 20:56:27 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33392 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752596AbXCMA40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 20:56:26 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQvJE-00039Z-IM; Mon, 12 Mar 2007 20:56:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 464C020FBAE; Mon, 12 Mar 2007 20:56:22 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v3b4aotd9.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42102>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >> "Shawn O. Pearce" <spearce@spearce.org> writes:
> >> >  	return status;
> >> 
> >> As the variable 'status' is not used anymore, I think this should return 0.
> >
> > Indeed.  I replaced that patch with another (same subject) in my
> > latest series.  Because leaving that 'status' variable in caused
> > a failure in the test suite when trying to create a bundle.
> >
> >   fixed:  http://article.gmane.org/gmane.comp.version-control.git/42087
> >   borked: http://article.gmane.org/gmane.comp.version-control.git/42056
> >
> > You quoted the borked one.  Please drop it and apply the fixed one.
> 
> Ok, diffing these two the only differences I see are identical
> to what I locally hand-fixed, so we are Ok it seems.

Yes, the only difference between the two patches was the unused
'status' variable, and returning 0 when we did actually make
the bundle successfully.  ;-)

Sorry for the pain today.  I usually try harder to avoid problems
like this...

-- 
Shawn.
