From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [BUG] git-gui loose object warning every hour
Date: Thu, 19 Jun 2008 20:32:16 -0400
Message-ID: <20080620003216.GR11793@spearce.org>
References: <g3et71$j8k$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Gebetsroither <gebi@sbox.tugraz.at>
X-From: git-owner@vger.kernel.org Fri Jun 20 02:33:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9UZY-00005a-CW
	for gcvg-git-2@gmane.org; Fri, 20 Jun 2008 02:33:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbYFTAcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 20:32:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753221AbYFTAcV
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 20:32:21 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38070 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752914AbYFTAcU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 20:32:20 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K9UXv-00064N-L8; Thu, 19 Jun 2008 20:32:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AB67B20FBAE; Thu, 19 Jun 2008 20:32:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <g3et71$j8k$1@ger.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85580>

Michael Gebetsroither <gebi@sbox.tugraz.at> wrote:
> New git-gui does not honor gc.auto=0 setting for his loose object
> warning.
> 
> The loose object warning from git-gui poped up 3 times in the last 4
> hours (i've gc'ed the repo every time).

This isn't a per-hour warning.  What's happening is there are loose
objects which git-gc has not pruned away.  Try running git-prune in
the repository to decrease the loose object count.

> I've already set gc.auto=0 so i do _NOT_ want git to do anything
> automatically.

Hmm.  Maybe git-gui should look at this flag on startup and if set
simply not perform the loose object count check.

> On every new git release there are new automatism that i've to disable.
> Is there a way to just disable all this automatism in all git tools
> globaly?

No.

-- 
Shawn.
