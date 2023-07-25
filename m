Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9440C0015E
	for <git@archiver.kernel.org>; Tue, 25 Jul 2023 06:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjGYGew (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 02:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjGYGeu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 02:34:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF19B19F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 23:34:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4851321C50;
        Tue, 25 Jul 2023 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690266887; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Edx0iL+ybIfH4KMvKZrb1NbmMRCoA7906qCX12M+5Yw=;
        b=mGknpzjpiHNE6PNTXkEEUTQ7tDCLsEBD1AhZRTgObhUigG+uyNAR5TeEIKcSbiklAGCgFg
        zujhlLZqnKc82F4mYttGhHorlrJCY3LDfx3OrIs7Rz5qBY/E7DubwDYi+CFkMYQSQusjP/
        Pjf/f4kQst4L/T6ZnKm51s0vk0J8FnU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690266887;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=Edx0iL+ybIfH4KMvKZrb1NbmMRCoA7906qCX12M+5Yw=;
        b=FKz9I6VevinkXgeDkUXFVtGrPJpH3f6D7YwlBQMtpl6UJoPFAP6b/un3sBbaYxOjV5/Phl
        IP9SFGubxJzZa9AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26CA613487;
        Tue, 25 Jul 2023 06:34:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IyUgCAdtv2QrewAAMHmgww
        (envelope-from <aherrmann@suse.de>); Tue, 25 Jul 2023 06:34:47 +0000
From:   Andreas Herrmann <aherrmann@suse.de>
To:     git@vger.kernel.org
Cc:     Andreas Herrmann <aherrmann@suse.de>
Subject: [PATCH] t4002: fix test #63 (missing whitespace)
Date:   Tue, 25 Jul 2023 08:34:10 +0200
Message-ID: <20230725063516.27242-1-aherrmann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing whitespace between 'test_expect_success' and test case
description for last test. Without this, we get:

t4002-diff-basic.sh: line 412: test_expect_successdiff can read from stdin: command not found

Signed-off-by: Andreas Herrmann <aherrmann@suse.de>
---
 t/t4002-diff-basic.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index d524d4057d..e6b6739426 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -401,9 +401,10 @@ test_expect_success 'diff-tree B A == diff-tree -R A B' '
 test_expect_success 'diff-tree -r B A == diff-tree -r -R A B' '
 	git diff-tree -r $tree_B $tree_A >.test-a &&
 	git diff-tree -r -R $tree_A $tree_B >.test-b &&
-	cmp -s .test-a .test-b'
+	cmp -s .test-a .test-b
+'
 
-test_expect_success'diff can read from stdin' '
+test_expect_success 'diff can read from stdin' '
 	test_must_fail git diff --no-index -- MN - < NN |
 		grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
 	test_must_fail git diff --no-index -- MN NN |
-- 
2.41.0

