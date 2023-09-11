Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F98CA0EC1
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbjIKVdq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237254AbjIKMVR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 08:21:17 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E587CEB
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 05:21:12 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id B5B812420E;
        Mon, 11 Sep 2023 08:21:08 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qffue-ppA-00; Mon, 11 Sep 2023 14:21:08 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] t3404-rebase-interactive.sh: fix name of a rewording test
Date:   Mon, 11 Sep 2023 14:21:08 +0200
Message-ID: <20230911122108.199207-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The given test name made no sense to me at all; it seems to be a
concatenation of two unrelated things. This was introduced by
commit 0c164ae7a ("rebase -i: add another reword test", 20-08-20).

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
actually, i don't understand what the test even does. shouldn't it, to
match the description, actually dirty the tree and verify that the
operation fails?

Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 96a56aafbe..31ee5bc1f6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -758,7 +758,7 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
-test_expect_success 'no uncommited changes when rewording the todo list is reloaded' '
+test_expect_success 'no uncommitted changes when rewording' '
 	git checkout E &&
 	test_when_finished "git checkout @{-1}" &&
 	(
-- 
2.42.0.419.g70bf8a5751

