From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 1/6] tests: fix broken && chains in t1509-root-worktree
Date: Wed, 29 Jul 2015 17:51:11 +0200
Message-ID: <1438185076-28870-2-git-send-email-ps@pks.im>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
Cc: peff@peff.net, pclouds@gmail.com, gitster@pobox.com,
	Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 29 17:51:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKTdj-0000rQ-Co
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 17:51:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880AbbG2PvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2015 11:51:23 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39052 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752461AbbG2PvW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jul 2015 11:51:22 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id D789420F21
	for <git@vger.kernel.org>; Wed, 29 Jul 2015 11:51:21 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 29 Jul 2015 11:51:21 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:in-reply-to:message-id
	:references:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=+u4L
	Ea1gib75+GSWCuToUahmz8E=; b=jbKZlollpo0r7CQScJqXyRvH0c2NCqjdECDA
	lBiAk5sl6lUZJVtLuCRDY5ft68UsjWsbRYWJjnJ8mm00jlBBcJ8i1eQRIzn4HG/g
	mH80Wf2tmeXeLoqjP/QwIYRBpBIaXKzeMTs2//yp8wSxfXqbzl1gauCJlnDRoK64
	D6UMpho=
X-Sasl-enc: YJi5Gqa8yDishUWS+cLKZL7uhzmN4hdQ9M8YzNzZ5Uvn 1438185081
Received: from localhost (unknown [46.189.27.162])
	by mail.messagingengine.com (Postfix) with ESMTPA id 4DCA768012A;
	Wed, 29 Jul 2015 11:51:21 -0400 (EDT)
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1438185076-28870-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274903>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1509-root-worktree.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t1509-root-worktree.sh b/t/t1509-root-worktree.sh
index b6977d4..0c80129 100755
--- a/t/t1509-root-worktree.sh
+++ b/t/t1509-root-worktree.sh
@@ -125,7 +125,7 @@ fi
 ONE_SHA1=d00491fd7e5bb6fa28c517a0bb32b8b506539d4d
 
 test_expect_success 'setup' '
-	rm -rf /foo
+	rm -rf /foo &&
 	mkdir /foo &&
 	mkdir /foo/bar &&
 	echo 1 > /foo/foome &&
@@ -218,7 +218,7 @@ unset GIT_WORK_TREE
 
 test_expect_success 'go to /' 'cd /'
 test_expect_success 'setup' '
-	rm -rf /.git
+	rm -rf /.git &&
 	echo "Initialized empty Git repository in /.git/" > expected &&
 	git init > result &&
 	test_cmp expected result
@@ -241,8 +241,8 @@ say "auto bare gitdir"
 
 # DESTROYYYYY!!!!!
 test_expect_success 'setup' '
-	rm -rf /refs /objects /info /hooks
-	rm /*
+	rm -rf /refs /objects /info /hooks &&
+	rm /* &&
 	cd / &&
 	echo "Initialized empty Git repository in /" > expected &&
 	git init --bare > result &&
-- 
2.5.0
