From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Why git-merge-resolve in git-am?
Date: Wed, 27 Dec 2006 21:20:38 -0500
Message-ID: <20061228022038.GE16612@spearce.org>
References: <20061228014525.GC16612@spearce.org> <7vr6uk3h2p.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 03:20:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzksv-0006EI-TE
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 03:20:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbWL1CUn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 21:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964885AbWL1CUn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 21:20:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38468 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964872AbWL1CUm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 21:20:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gzksn-0000eU-Jo; Wed, 27 Dec 2006 21:20:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2EAE520FB65; Wed, 27 Dec 2006 21:20:39 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6uk3h2p.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35510>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Why does git-am use git-merge-resolve while git-rebase -m uses
> > git-merge-recursive?
> 
> The use of merge-resolve by am predates merge-resolve became
> usable by at least six weeks, and longer before merge-resolve
> became really stable for about an extra month after.
> 
> Even after it stabilized merge-recursive was way slower than
> merge-resove until it was rewritten in C for another nine
> months.

Good reasons, but all are strictly historical.  So there's actually
no technical reason we can't use merge-recursive here in git-am.

Basically I'm trying to improve the merge conflict hunks in
`git-am -3`.  merge-recursive now recognizes GITHEAD_* but
merge-one-file doesn't (and can't).  Switching to merge-recursive
and setting GITHEAD_* would get that case fixed in git-rebase
without -m.

-- 
Shawn.
