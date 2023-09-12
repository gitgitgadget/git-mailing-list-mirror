Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3730CA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 10:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234268AbjILKms (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 06:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjILKmq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 06:42:46 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6254DB3
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 03:42:42 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 862E6202E9;
        Tue, 12 Sep 2023 06:42:37 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qg0qr-8f3-00; Tue, 12 Sep 2023 12:42:37 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] t3404-rebase-interactive.sh: fix typos in title of a rewording test
Date:   Tue, 12 Sep 2023 12:42:36 +0200
Message-ID: <20230912104237.271616-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.42.0.419.g70bf8a5751
In-Reply-To: <45ee4ad1-f7a3-43d8-99ef-329efc9fcdba@gmail.com>
References: <45ee4ad1-f7a3-43d8-99ef-329efc9fcdba@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test was introduced by commit 0c164ae7a ("rebase -i: add another
reword test", 2021-08-20). I didn't quite get what it was meant to do,
so here's an explanation from Phillip:

The purpose of the test is to ensure that

  (i) There are no uncommited changes when the editor runs. I.e., we
      commit without running the editor and then reword by amending
      that commit. This ensures that we have the same user experience
      whether or not the commit was fast-forwarded [1].

 (ii) That the todo list is re-read after the commit has been reworded.
      This is to allow the user to update the todo list while the rebase
      is paused for editing the commit message.

[1] https://lore.kernel.org/git/20190812175046.GM20404@szeder.dev/

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>

---
v2:
- actually, it's kinda a new patch now

Cc: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: Junio C Hamano <gitster@pobox.com>
---
 t/t3404-rebase-interactive.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 96a56aafbe..bf94eb28b9 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -758,7 +758,7 @@ test_expect_success 'reword' '
 	git show HEAD~2 | grep "C changed"
 '
 
-test_expect_success 'no uncommited changes when rewording the todo list is reloaded' '
+test_expect_success 'no uncommitted changes when rewording and the todo list is reloaded' '
 	git checkout E &&
 	test_when_finished "git checkout @{-1}" &&
 	(
-- 
2.42.0.419.g70bf8a5751

