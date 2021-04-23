Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1978FC43462
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F310861075
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 19:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243843AbhDWTnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 15:43:25 -0400
Received: from mav.lukeshu.com ([104.207.138.63]:35186 "EHLO mav.lukeshu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243832AbhDWTnY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 15:43:24 -0400
Received: from lukeshu-dw-thinkpad (unknown [IPv6:2601:281:8200:26:4e34:88ff:fe48:5521])
        by mav.lukeshu.com (Postfix) with ESMTPSA id 7DA6C80590;
        Fri, 23 Apr 2021 15:42:47 -0400 (EDT)
From:   Luke Shumaker <lukeshu@lukeshu.com>
To:     git@vger.kernel.org
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: [PATCH 07/30] subtree: t7900: delete some dead code
Date:   Fri, 23 Apr 2021 13:42:07 -0600
Message-Id: <20210423194230.1388945-8-lukeshu@lukeshu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210423194230.1388945-1-lukeshu@lukeshu.com>
References: <20210423194230.1388945-1-lukeshu@lukeshu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Luke Shumaker <lukeshu@datawire.io>

Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
---
 contrib/subtree/t/t7900-subtree.sh | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
index ae96c8cff5..96acd4f8be 100755
--- a/contrib/subtree/t/t7900-subtree.sh
+++ b/contrib/subtree/t/t7900-subtree.sh
@@ -10,7 +10,6 @@ and split subcommands of git subtree.
 '
 
 TEST_DIRECTORY=$(pwd)/../../../t
-export TEST_DIRECTORY
 . "$TEST_DIRECTORY"/test-lib.sh
 
 # Use our own wrapper around test-lib.sh's test_create_repo, in order
@@ -23,15 +22,6 @@ subtree_test_create_repo () {
 	git -C "$1" config log.date relative
 }
 
-create () {
-	echo "$1" >"$1" &&
-	git add "$1"
-}
-
-undo () {
-	git reset --hard HEAD~
-}
-
 # Make sure no patch changes more than one file.
 # The original set of commits changed only one file each.
 # A multi-file change would imply that we pruned commits
@@ -400,7 +390,7 @@ test_expect_success 'check hash of split' '
 		(
 			cd ./"sub proj" &&
 			subdir_hash=$(git rev-parse HEAD) &&
-			test ''"$new_hash"'' = "$subdir_hash"
+			test "$new_hash" = "$subdir_hash"
 		)
 	)
 '
-- 
2.31.1

