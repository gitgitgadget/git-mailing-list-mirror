From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 7/7] user-manual: use detached head when rewriting history
Date: Mon, 16 Apr 2007 00:37:16 -0400
Message-ID: <9347.04806791178$1176698260@news.gmane.org>
References: <11766982362087-git-send-email->
 <11766982361830-git-send-email->
 <1176698236722-git-send-email->
 <11766982363767-git-send-email->
 <11766982363276-git-send-email->
 <11766982362066-git-send-email->
 <11766982362911-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Apr 16 06:37:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdIy3-0008Sb-73
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 06:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754491AbXDPEhY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 00:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754489AbXDPEhX
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 00:37:23 -0400
Received: from mail.fieldses.org ([66.93.2.214]:36504 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754488AbXDPEhS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 00:37:18 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HdIxp-0005Yf-3T; Mon, 16 Apr 2007 00:37:17 -0400
X-Mailer: git-send-email 1.5.1.1.98.gedb4f
In-Reply-To: <11766982362911-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44575>

From: J. Bruce Fields <bfields@citi.umich.edu>

This is slightly simpler if we use a detached head.  And it's probably
good to have another example that uses this feature.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/user-manual.txt |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index c32aaef..5c62516 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -504,6 +504,7 @@ $ cat .git/HEAD
 ref: refs/heads/master
 ------------------------------------------------
 
+[[detached-head]]
 Examining an old version without creating a new branch
 ------------------------------------------------------
 
@@ -2055,22 +2056,22 @@ $ git tag bad mywork~5
 
 (Either gitk or git-log may be useful for finding the commit.)
 
-Then check out a new branch at that commit, edit it, and rebase the rest of
-the series on top of it:
+Then check out that commit, edit it, and rebase the rest of the series
+on top of it (note that we could check out the commit on a temporary
+branch, but instead we're using a <<detached-head,detached head>>):
 
 -------------------------------------------------
-$ git checkout -b TMP bad
+$ git checkout bad
 $ # make changes here and update the index
 $ git commit --amend
-$ git rebase --onto TMP bad mywork
+$ git rebase --onto HEAD bad mywork
 -------------------------------------------------
 
-When you're done, you'll be left with mywork checked out, with the top patches
-on mywork reapplied on top of the modified commit you created in TMP.  You can
+When you're done, you'll be left with mywork checked out, with the top
+patches on mywork reapplied on top of your modified commit.  You can
 then clean up with
 
 -------------------------------------------------
-$ git branch -d TMP
 $ git tag -d bad
 -------------------------------------------------
 
-- 
1.5.1.1.98.gedb4f
