From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct documentation of 'reflog show' to explain it shows HEAD
Date: Sun, 19 Aug 2007 04:18:47 -0400
Message-ID: <20070819081847.GA6166@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 10:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IMg0J-0000sV-1w
	for gcvg-git@gmane.org; Sun, 19 Aug 2007 10:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751465AbXHSISz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Aug 2007 04:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbXHSISz
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Aug 2007 04:18:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33620 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbXHSISw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2007 04:18:52 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IMfzk-0003zW-Aw; Sun, 19 Aug 2007 04:18:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 36A0620FBAE; Sun, 19 Aug 2007 04:18:48 -0400 (EDT)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56124>

By default 'git reflog show' will show the reflog of 'HEAD' and not
the reflog of the current branch.  This is most likely due to the
work done a while ago as part of the detached HEAD series to allow
HEAD to have its own reflog independent of each branch's reflog.

Since 'git reflog show' is really just an obscure alias for 'git
log -g --abbrev-commit --pretty=oneline' it should behave the same
way and its documentation should match.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-reflog.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index 89bc9c5..29b7d9f 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -32,7 +32,8 @@ directly by the end users -- instead, see gitlink:git-gc[1].
 
 The subcommand "show" (which is also the default, in the absense of any
 subcommands) will take all the normal log options, and show the log of
-the current branch. It is basically an alias for 'git log -g --abbrev-commit
+`HEAD`, which will cover all recent actions, including branch switches.
+It is basically an alias for 'git log -g --abbrev-commit
 --pretty=oneline', see gitlink:git-log[1].
 
 
-- 
1.5.3.rc5.19.g0734d
