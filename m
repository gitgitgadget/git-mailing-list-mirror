From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Include a git-push example for creating a remote branch
Date: Thu, 6 Sep 2007 00:44:08 -0400
Message-ID: <20070906044408.GA588@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 06:44:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT9E2-0004Ix-4O
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 06:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbXIFEoN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 00:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751562AbXIFEoN
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 00:44:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39333 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465AbXIFEoM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 00:44:12 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT9Du-00034x-Md; Thu, 06 Sep 2007 00:44:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 382A420FBAE; Thu,  6 Sep 2007 00:44:09 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57814>

Many users get confused when `git push origin master:foo` works
when foo already exists on the remote repository but are confused
when foo doesn't exist as a branch and this form does not create
the branch foo.

This new example highlights the trick of including refs/heads/
in front of the desired branch name to create a branch.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-push.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 0dd9caf..7b8e075 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -117,6 +117,12 @@ git push origin master:satellite/master::
 	the ref that matches `satellite/master` (most likely, it would
 	be `refs/remotes/satellite/master`) in `origin` repository with it.
 
+git push origin master:refs/heads/experimental::
+	Create the branch `experimental` in the `origin` repository
+	by copying the current `master` branch.  This form is usually
+	needed to create a new branch in the remote repository as
+	there is no `experimental` branch to match.
+
 Author
 ------
 Written by Junio C Hamano <junkio@cox.net>, later rewritten in C
-- 
1.5.3.1.840.g0fedbc
