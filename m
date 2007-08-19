From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: log -g --reverse horribly insane
Date: Sun, 19 Aug 2007 04:56:24 -0400
Message-ID: <20070819085624.GU27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 19 10:57:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMgam-00004z-GT
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 10:57:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbXHSI4c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 04:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751903AbXHSI4c
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 04:56:32 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34381 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbXHSI4b (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 04:56:31 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IMga8-000149-C7
	for git@vger.kernel.org; Sun, 19 Aug 2007 04:56:26 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7053B20FBAE; Sun, 19 Aug 2007 04:56:24 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56125>

OK, I'm just too tired to find this on my own right now.  I'll try
again later after I get some sleep, but maybe someone with a
different sleeping pattern than me will find and fix this before
I arise...

  git log -g --reverse --pretty=oneline

Does not produce anything useful.  Results are ranging from getting
a single line with upwards of 50 commits on it and a corrupt log
message to lines with no log message and only one commit, even
though the non --reverse output has over 200 results to report.

  git log -g --reverse

Does not show the reflog message headers, but is otherwise fine.
So it shows the history according to the reflog (I think that's
what I saw) but isn't showing the data I asked for with -g.

Results are the same for HEAD's reflog as for any other branch in
my tree.  Basically its nutso.  I think we need to either support
-g --reverse combination properly, or we need to disallow it.
The current behavior is uh, not user friendly.

-- 
Shawn.
