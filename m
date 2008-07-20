From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: [PATCH] builtin-merge-recursive.c: make merge_recursive() static
Date: Sun, 20 Jul 2008 19:21:27 +0900
Message-ID: <20080720192127.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 12:22:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKW3j-0001kA-PX
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 12:22:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755630AbYGTKVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 06:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755593AbYGTKVc
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 06:21:32 -0400
Received: from karen.lavabit.com ([72.249.41.33]:48308 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755560AbYGTKVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 06:21:32 -0400
Received: from b.earth.lavabit.com (b.earth.lavabit.com [192.168.111.11])
	by karen.lavabit.com (Postfix) with ESMTP id 603C7C88B1;
	Sun, 20 Jul 2008 05:21:23 -0500 (CDT)
Received: from nanako3.lavabit.com (212.62.97.20)
	by lavabit.com with ESMTP id CA4EJNHLX1Q4; Sun, 20 Jul 2008 05:21:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=DiK8v+IymJ6PrlJcLnNLueXBB0mRSwVEKhS4QbeAOL7V8Or+Q+B7QamCJ0XliHGt7AGr+/W0OdhclRl4ewNRtOtNDRWqXr2Gm7zd57KhX10ZERLNpUbcglkK18FxHwyaAGrKZZXSH4VvqZ3DKF1ci81mQze7yhvgHpIHJHrftNQ=;
  h=From:Subject:To:Cc:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89176>

This function is not used by any other file.

Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
---
 builtin-merge-recursive.c |    2 +-
 merge-recursive.h         |    7 -------
 2 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 1ab1945..553aa16 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -1247,7 +1247,7 @@ static struct commit_list *reverse_commit_list(struct commit_list *list)
  * Merge the commits h1 and h2, return the resulting virtual
  * commit object and a flag indicating the cleanness of the merge.
  */
-int merge_recursive(struct commit *h1,
+static int merge_recursive(struct commit *h1,
 		    struct commit *h2,
 		    const char *branch1,
 		    const char *branch2,
diff --git a/merge-recursive.h b/merge-recursive.h
index f37630a..8924371 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -1,13 +1,6 @@
 #ifndef MERGE_RECURSIVE_H
 #define MERGE_RECURSIVE_H
 
-int merge_recursive(struct commit *h1,
-		    struct commit *h2,
-		    const char *branch1,
-		    const char *branch2,
-		    struct commit_list *ancestors,
-		    struct commit **result);
-
 int merge_trees(struct tree *head,
 		struct tree *merge,
 		struct tree *common,
-- 
1.5.6.3

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
