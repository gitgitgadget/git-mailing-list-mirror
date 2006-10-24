From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Pushing vs. alternates
Date: Tue, 24 Oct 2006 01:46:11 -0400
Message-ID: <20061024054611.GB9724@spearce.org>
References: <20061024035335.GW20017@pasky.or.cz> <7vmz7muvqu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 24 07:46:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GcF7P-0001nL-Jw
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 07:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWJXFqT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Oct 2006 01:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWJXFqT
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Oct 2006 01:46:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44249 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932299AbWJXFqS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Oct 2006 01:46:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GcF76-0007Wy-U0; Tue, 24 Oct 2006 01:46:13 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ED26521269E; Tue, 24 Oct 2006 01:46:11 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz7muvqu.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29926>

Junio C Hamano <junkio@cox.net> wrote:
> Petr Baudis <pasky@ucw.cz> writes:
> 
> >   I don't have time to code that myself right now, so I'm just tossing
> > an idea around - pushing to a directory with alternates set up should
> > avoid sending objects that are already in the alternate object database.
> 
> That is probably only relevant for the first time, since
> subsequent pushes have refs from its own repository that tracks
> the tips of branches that was pushed for the last time.
> 
> And first time usage when you are initializing the repository
> with alternates, you have direct access to that repository
> (that's how you can set up alternates), you can as easily do the
> initial fetch/clone as well at that time.
> 
> So it might be a nice addition but I suspect it would not matter
> much in practice.

What would be useful in practice is not unpacking the first pack
pushed to the an empty repository, or better yet just dealing with
converting thin packs to standalone packs rather than unpacking
to loose objects when the number of objects in the incoming pack
exceeds some configured threshold.

Which Linus and Nico already took stabs at doing but haven't finished...

-- 
Shawn.
