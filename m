From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Merging into a current branch
Date: Mon, 30 Jul 2007 01:48:37 -0400
Message-ID: <20070730054837.GS20052@spearce.org>
References: <93c3eada0707292240qe92aa57s5c5152e078693a53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Geoff Russell <geoffrey.russell@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 07:48:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFO7Z-0001qi-1Y
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 07:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbXG3Fsl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 01:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760264AbXG3Fsl
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 01:48:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34065 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757844AbXG3Fsl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 01:48:41 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IFO7S-0004oH-QI; Mon, 30 Jul 2007 01:48:38 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 00D1820FBAE; Mon, 30 Jul 2007 01:48:37 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <93c3eada0707292240qe92aa57s5c5152e078693a53@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54190>

Geoff Russell <geoffrey.russell@gmail.com> wrote:
> Is there any reason why
> 
> git fetch origin branchX:branchX
> 
> fails if I am on branchX?   All I want to do is fast forward it.

Yes.

A fetch will *only* update the branch.  If the branch is your current
branch it won't update the working directory.  This safety check
is to prevent the branch from updating, but the working directory
staying unchanged, and the resulting git-status output looking like
you just undid all of the recent work done on branchX of origin.

Try git-pull instead:

  git pull origin branchX


-- 
Shawn.
