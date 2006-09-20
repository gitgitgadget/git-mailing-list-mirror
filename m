From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 17:21:01 -0400
Message-ID: <20060920212101.GA24415@spearce.org>
References: <20060920080308.673a1e93@localhost.localdomain> <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz> <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de> <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org> <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@suse.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 23:24:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ9Xn-0006rI-Ud
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 23:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWITVVc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 17:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWITVVZ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 17:21:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:18900 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S932113AbWITVVU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 17:21:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GQ9V0-0005Lf-6o; Wed, 20 Sep 2006 17:20:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 13CFC20E48E; Wed, 20 Sep 2006 17:21:01 -0400 (EDT)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0609202304270.19042@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27402>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Another, even more serious problems with rebasing: You can introduce a bug 
> by rebasing. Meaning: git-rebase can succeed, even compilation is fine, 
> but the sum of your patches, and the patches you are rebasing on, is 
> buggy. And there is _no_ way to bisect this, since the "good" version can 
> be gone for good.

True, however one would hope that you tested the commit before you
rebased it and found it to working.  And bisect should point at the
new version of that commit as the break.  And then you can debug
it there.

I've seen this happen very rarely, and usually its an initialization
or calling order type of bug and its usually has more to do with 
other changes in the branch you are rebasing onto that aren't at the
side your patch affects.

Yes its something annoying to track down but certainly easy enough
with bisect, especially if you have relatively fine-grained commits
and a reasonably good test suite.

-- 
Shawn.
