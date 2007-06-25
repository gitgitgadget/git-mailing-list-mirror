From: Yann Dirson <ydirson@altern.org>
Subject: [StGIT PATCH 6/7] Fix t1200 to catch intermediate errors.
Date: Mon, 25 Jun 2007 23:24:51 +0200
Message-ID: <20070625212451.17189.21928.stgit@gandelf.nowhere.earth>
References: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 23:25:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2w3X-0004qy-CP
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 23:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752473AbXFYVZF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 17:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752342AbXFYVZE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 17:25:04 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:51349 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752447AbXFYVZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 17:25:03 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id CD8AD5A2B5;
	Mon, 25 Jun 2007 23:25:01 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C20C61F150;
	Mon, 25 Jun 2007 23:24:51 +0200 (CEST)
In-Reply-To: <20070625212229.17189.79919.stgit@gandelf.nowhere.earth>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50926>

All command sequences in tests should be linked with && or
similar, to guard against potentially missing a regresssion.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 t/t1200-push-modified.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index 6769667..324b3b0 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -21,9 +21,9 @@ test_create_repo foo
 test_expect_success \
     'Clone tree and setup changes' \
     "stg clone foo bar &&
-     (cd bar && stg new p1 -m p1
+     (cd bar && stg new p1 -m p1 &&
       printf 'a\nc\n' > file && stg add file && stg refresh &&
-      stg new p2 -m p2
+      stg new p2 -m p2 &&
       printf 'a\nb\nc\n' > file && stg refresh
      )
 "
