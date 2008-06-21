From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Correct documentation for git-push --mirror
Date: Fri, 20 Jun 2008 23:25:25 -0400
Message-ID: <20080621032525.GA10020@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 21 05:26:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9tk8-0001dk-UD
	for gcvg-git-2@gmane.org; Sat, 21 Jun 2008 05:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754130AbYFUDZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jun 2008 23:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754126AbYFUDZa
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jun 2008 23:25:30 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35715 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754044AbYFUDZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jun 2008 23:25:29 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K9tj0-0005F7-Eu; Fri, 20 Jun 2008 23:25:14 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 423B620FBAE; Fri, 20 Jun 2008 23:25:25 -0400 (EDT)
Content-Disposition: inline
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85690>

This option behaves more like:

  git push $url +refs/*:refs/*

then it does like:

  git push $url +refs/heads/*:refs/heads/* +refs/tags/*:refs/tags/*

so we should document it to be more clear about that.

Suggested-by: Marek Zawirski <marek.zawirski@gmail.com>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-push.txt |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 89e0049..f3d5d88 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -67,7 +67,8 @@ nor in any Push line of the corresponding remotes file---see below).
 
 --mirror::
 	Instead of naming each ref to push, specifies that all
-	refs under `$GIT_DIR/refs/heads/` and `$GIT_DIR/refs/tags/`
+	refs under `$GIT_DIR/refs/` (which includes but is not
+	limited to `refs/heads/`, `refs/remotes/`, and `refs/tags/`)
 	be mirrored to the remote repository.  Newly created local
 	refs will be pushed to the remote end, locally updated refs
 	will be force updated on the remote end, and deleted refs
-- 
1.5.6.153.g07215
