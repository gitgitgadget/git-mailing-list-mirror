From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git-merge: need a tap with the cluestick, please
Date: Thu, 18 Oct 2007 19:35:18 -0400
Message-ID: <20071018233518.GL14735@spearce.org>
References: <ff80tr$hh1$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: walt <wa1ter@myrealbox.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 01:35:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iietq-0008PM-WE
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 01:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757810AbXJRXfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 19:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754134AbXJRXfX
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 19:35:23 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:37441 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267AbXJRXfW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 19:35:22 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IietO-000408-UW; Thu, 18 Oct 2007 19:35:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0356120FBAE; Thu, 18 Oct 2007 19:35:19 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <ff80tr$hh1$1@ger.gmane.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61575>

walt <wa1ter@myrealbox.com> wrote:
> Now when I pull from Linus the merge stops in the middle because of
> conflicts with my .gitignore file <sigh>.  Anything I try now with
> git-merge tells me I can't do that in the middle of a conflicted
> merge.  Yes, I know that now, but what should I do instead?
> 
> I could move my 'obj' out-of-tree but then I wouldn't learn anything.
> This has to be bone-head easy, but not for me :)

How about putting the ignore for your obj dir in your own private
exclude file:

  $ echo /obj >>.git/info/exclude

will cause Git to ignore an "obj" directory if it is found in the
top level of the repository.  And since this file is not actually
tracked as part of the repository it will apply to all branches
in this repository and won't cause merge conflicts when upstream
makes changes to .gitignore.

As for aborting a merge that you have gotten into the middle of
decided you want to get out of, use `git reset --hard`.  That will
throw away all of the unmerged state and put you back to your
pre-merge state.

-- 
Shawn.
