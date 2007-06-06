From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH 1/3] Robustify rebase test: check patches are reapplied.
Date: Thu, 07 Jun 2007 00:01:42 +0200
Message-ID: <20070606220142.18635.3961.stgit@gandelf.nowhere.earth>
References: <20070606215922.18635.38379.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 00:01:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hw3Zf-0007yu-ID
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 00:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935149AbXFFWBl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 6 Jun 2007 18:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755655AbXFFWBl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jun 2007 18:01:41 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:60882 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751172AbXFFWBk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jun 2007 18:01:40 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 9C8235A1EB;
	Thu,  7 Jun 2007 00:01:39 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 5B9021F019;
	Thu,  7 Jun 2007 00:01:42 +0200 (CEST)
In-Reply-To: <20070606215922.18635.38379.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49321>


Signed-off-by: Yann Dirson <ydirson@altern.org>

---

 t/t2200-rebase.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index 52462dd..882572c 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -27,7 +27,8 @@ test_expect_success \
 	'Rebase to previous commit' \
 	'
 	stg rebase master~1 &&
-	test `stg id base@stack` = `git rev-parse master~1`
+	test `stg id base@stack` = `git rev-parse master~1` &&
+	test `stg applied | wc -l` = 1
 	'
 
 test_done
