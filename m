From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 2/2] Demonstrate issue #8732.
Date: Wed, 14 Mar 2007 22:35:04 +0100
Message-ID: <20070314213504.13492.82355.stgit@gandelf.nowhere.earth>
References: <20070314213020.13492.24840.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 14 22:35:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRb8O-0007OK-U0
	for gcvg-git@gmane.org; Wed, 14 Mar 2007 22:35:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422669AbXCNVfI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 17:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422670AbXCNVfI
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 17:35:08 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:58776 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422669AbXCNVfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 17:35:05 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id B4C2B25C14;
	Wed, 14 Mar 2007 22:35:04 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 6074F1F094;
	Wed, 14 Mar 2007 22:35:04 +0100 (CET)
In-Reply-To: <20070314213020.13492.24840.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42238>




Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/t1003-branch-delete.sh |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/t/t1003-branch-delete.sh b/t/t1003-branch-delete.sh
index 8625cc5..a5c486e 100755
--- a/t/t1003-branch-delete.sh
+++ b/t/t1003-branch-delete.sh
@@ -37,4 +37,17 @@ test_expect_failure \
     'Check the deleted branch is gone' \
     'git rev-parse b~0'
 
+
+test_expect_success \
+    'Create a new stack named "master"' \
+    'stg branch --create master'
+
+test_expect_success \
+    'Delete the "master" branch' \
+    'stg branch --delete master'
+
+test_expect_failure \
+    'Check the deleted "master" branch is gone' \
+    'git rev-parse master~0'
+
 test_done
