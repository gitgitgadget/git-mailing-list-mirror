From: Shawn Pearce <spearce@spearce.org>
Subject: Re: print errors from git-update-ref
Date: Fri, 28 Jul 2006 02:27:20 -0400
Message-ID: <20060728062720.GC30783@spearce.org>
References: <81b0412b0607180613t603551b8t865b407c40ab8aef@mail.gmail.com> <7vk663h6zi.fsf@assigned-by-dhcp.cox.net> <20060727012856.GB32492@spearce.org> <Pine.LNX.4.63.0607271302150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 28 08:27:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G6Lop-0006RL-8H
	for gcvg-git@gmane.org; Fri, 28 Jul 2006 08:27:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751969AbWG1G12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 28 Jul 2006 02:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWG1G12
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Jul 2006 02:27:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53647 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751969AbWG1G11 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jul 2006 02:27:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G6Lof-0001ya-Qn; Fri, 28 Jul 2006 02:27:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7883920E433; Fri, 28 Jul 2006 02:27:20 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0607271302150.29667@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24368>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
> 
> On Wed, 26 Jul 2006, Shawn Pearce wrote:
> 
> > This change adds a test for trying to create a ref within a directory
> > that is actually currently a file, and adds error printing within
> > the ref locking routine should the resolve operation fail.
> 
> Why not just print an error message when the resolve operation fails, 
> instead of special casing this obscure corner case? It is way shorter, 
> too. The test should stay, though.

Did you read the patch?  If resolve_ref returns NULL then this
change prints an error (from errno) no matter what.  If errno is
ENOTDIR then it tries to figure out what part of the ref path wasn't
a directory (but was attempted to be used as such) and prints an
ENOTDIR error about that path instead of the one actually given
to the ref lock function

So I think I'm doing what you are suggesting...

-- 
Shawn.
