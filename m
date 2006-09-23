From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Sat, 23 Sep 2006 00:00:35 -0400
Message-ID: <20060923040035.GB18105@spearce.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060923034407.GF8259@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	catalin.marinas@gmail.com, Linus Torvalds <torvalds@osdl.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 06:01:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQyhF-00081z-DF
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 06:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWIWEAq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 00:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWIWEAp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 00:00:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:24220 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750786AbWIWEAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 00:00:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQygw-0006pw-JB; Sat, 23 Sep 2006 00:00:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4C45320FB16; Sat, 23 Sep 2006 00:00:36 -0400 (EDT)
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060923034407.GF8259@pasky.or.cz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27558>

Petr Baudis <pasky@suse.cz> wrote:
> Yes, I agree that this really is a problem, but that's a fundamental
> limitation. At least for StGIT-maintained floating branches the latest
> bleeding edge StGIT could fix that. (Except that the problem outlined by
> Linus is present here as well, first prune will wipe your older patch
> versions and your patch log will be useless - Catalin? Can we store the
> older patch versions references in something like
> .git/refs/patches-old/?) And except that it does that only for you -
> there should be a way to conveniently mirror (clone+pull) the patch
> stack setup.

Why not change reflog to store the last n values or the last n days
(obtained from .git/config file) as refs under refs/prior-heads ?

I can see the same concept of ref history being useful even for
core git-rebase and doing it this way would also give it to StGIT
without Catalin needing to change code.

But it doesn't help git bisect.


Of course a looooong time ago when I first implemented reflog support
this was suggested but not implemented at the time due to the high
cost per ref.  Now that we have Linus' packed refs available this
may not be nearly as much of a problem.

-- 
Shawn.
