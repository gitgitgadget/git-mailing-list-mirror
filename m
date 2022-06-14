Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E002DC433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 15:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbiFNPcE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 11:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236030AbiFNPcD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 11:32:03 -0400
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 14 Jun 2022 08:31:59 PDT
Received: from mailproxy08.manitu.net (mailproxy08.manitu.net [217.11.48.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EAB35A9F
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 08:31:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2001:9e8:6a4a:4a00:84a5:f961:bada:889e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: michael@grubix.eu)
        by mailproxy08.manitu.net (Postfix) with ESMTPSA id 7031A1B200DF;
        Tue, 14 Jun 2022 17:26:43 +0200 (CEST)
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] t3701: two subtests are fixed
Date:   Tue, 14 Jun 2022 17:26:33 +0200
Message-Id: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
X-Mailer: git-send-email 2.37.0.rc0.107.g7a7be657e7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

0527ccb1b5 ("add -i: default to the built-in implementation", 2021-11-30)
switched to the implementation which fixed to subtest. Mark them as
expect_success now.

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
I did check the ML but may have missed a series which contains this. (I
only found one which tries to make the test output clearer in CI.)

 t/t3701-add-interactive.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 94537a6b40..9a06638704 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -538,7 +538,7 @@ test_expect_success 'split hunk "add -p (edit)"' '
 	! grep "^+15" actual
 '
 
-test_expect_failure 'split hunk "add -p (no, yes, edit)"' '
+test_expect_success 'split hunk "add -p (no, yes, edit)"' '
 	test_write_lines 5 10 20 21 30 31 40 50 60 >test &&
 	git reset &&
 	# test sequence is s(plit), n(o), y(es), e(dit)
@@ -562,7 +562,7 @@ test_expect_success 'split hunk with incomplete line at end' '
 	test_must_fail git grep --cached before
 '
 
-test_expect_failure 'edit, adding lines to the first hunk' '
+test_expect_success 'edit, adding lines to the first hunk' '
 	test_write_lines 10 11 20 30 40 50 51 60 >test &&
 	git reset &&
 	tr _ " " >patch <<-EOF &&
-- 
2.37.0.rc0.107.g7a7be657e7

