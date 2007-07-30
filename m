From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: merge time
Date: Mon, 30 Jul 2007 03:49:37 -0400
Message-ID: <20070730074937.GT20052@spearce.org>
References: <241612.78983.qm@web51007.mail.re2.yahoo.com> <alpine.LFD.0.999.0707291914451.3442@woody.linux-foundation.org> <6FE9FFD6-B5D7-4E1D-A4E8-B6D0E9517503@zib.de> <7vbqdumlo1.fsf@assigned-by-dhcp.cox.net> <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew L Foster <mfoster167@yahoo.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 30 09:49:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFQ0i-0003S2-G1
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 09:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754653AbXG3Htq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 03:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754532AbXG3Htq
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 03:49:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:36687 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491AbXG3Htp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 03:49:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFQ0Z-0008UE-MM; Mon, 30 Jul 2007 03:49:39 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ECEBC20FBAE; Mon, 30 Jul 2007 03:49:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <E49A2B0B-DAA3-4A03-925D-D3D113F907F1@zib.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54200>

Steffen Prohaska <prohaska@zib.de> wrote:
> Another option could be to force a commit before the merge, even
> if there are no changes to commit, something like
> 
>     $ git commit --force -m 'MARK'
> 
> [to my knowledge, --force or similar is not yet available]

git-force-commit:

  git config --global alias.force-commit \
  '! git update-ref HEAD $(echo MARK | git commit-tree HEAD -p HEAD)'

But you didn't hear it from me.  ;-)

Yes, I've actually done this once in a while.  But only to create
some temporary throw-away state that I need for some diff operation
or whatnot.  Usually because I make it in one repository, but want
to fetch it into another and fetch likes moving refs to commits
better than refs to trees.  Oh, and I'm usually passing in more
than one -p, and usually not HEAD as the tree.  But whatever.

-- 
Shawn.
