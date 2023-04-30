Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB92C77B60
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 10:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjD3KAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Apr 2023 06:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjD3KAk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2023 06:00:40 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E654419A5
        for <git@vger.kernel.org>; Sun, 30 Apr 2023 03:00:37 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 038E22008E;
        Sun, 30 Apr 2023 06:00:35 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pt3r8-vcu-00; Sun, 30 Apr 2023 12:00:34 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t/t3501-revert-cherry-pick.sh: clarify scope of the file
Date:   Sun, 30 Apr 2023 12:00:34 +0200
Message-Id: <20230430100034.1889796-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The file started out as a test for picks and reverts with renames, but
has been subsequently populated will all kinds of basic tests, in
accordance with its generic name. Adjust the description to reflect
that.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
Cc: Junio C Hamano <gitster@pobox.com>
---
 t/t3501-revert-cherry-pick.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 2f3e3e2416..e2ef619323 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -1,14 +1,6 @@
 #!/bin/sh
 
-test_description='test cherry-pick and revert with renames
-
-  --
-   + rename2: renames oops to opos
-  +  rename1: renames oops to spoo
-  +  added:   adds extra line to oops
-  ++ initial: has lines in oops
-
-'
+test_description='miscellaneous basic tests for cherry-pick and revert'
 
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
@@ -63,6 +55,14 @@ test_expect_success 'revert --nonsense' '
 	test_i18ngrep "[Uu]sage:" msg
 '
 
+# the following two test cherry-pick and revert with renames
+#
+# --
+#  + rename2: renames oops to opos
+# +  rename1: renames oops to spoo
+# +  added:   adds extra line to oops
+# ++ initial: has lines in oops
+
 test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
-- 
2.40.0.152.g15d061e6df

