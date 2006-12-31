From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 0/11] Misc. pull/merge/am improvements
Date: Sat, 30 Dec 2006 20:21:15 -0500
Message-ID: <20061231012115.GA5082@spearce.org>
References: <20061228073441.GB17304@spearce.org> <7vmz58whnx.fsf@assigned-by-dhcp.cox.net> <20061228084245.GA18150@spearce.org> <7vtzzguvrp.fsf@assigned-by-dhcp.cox.net> <20061229045327.GD12072@spearce.org> <7vmz57p6tn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 02:21:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0pOD-0005ZF-W6
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 02:21:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWLaBVU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Dec 2006 20:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932572AbWLaBVU
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Dec 2006 20:21:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37673 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566AbWLaBVT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Dec 2006 20:21:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0pNq-0006Oi-HN; Sat, 30 Dec 2006 20:21:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 968DE20FB65; Sat, 30 Dec 2006 20:21:15 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vmz57p6tn.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35641>

Junio C Hamano <junkio@cox.net> wrote:
> > Junio C Hamano <junkio@cox.net> wrote:
> >> While I was looking at the problem, I noticed something a bit
> >> easier to reproduce and should be lot easier to diagnose.  At
> >> http://userweb.kernel.org/~junio/broken.tar, I have a tarball of
> >> git.git repository.
> >
> 
> I think there is a thinko in the OFS_DELTA arm of that switch
> statement.  You are resetting buf to (in-pack-offset + used), so
> you should fetch the variably encoded length starting from buf[0].

Yes.  Your patch looks correct; that's a really bad thinko on
my part.  Thanks for tracking it down, and fixing it.

-- 
Shawn.
