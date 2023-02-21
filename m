Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16719C6379F
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 12:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjBUM2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 07:28:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233590AbjBUM21 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 07:28:27 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119DE3B5
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 04:28:25 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id z10so1683523ple.6
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 04:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RGvpnK1n+q61OxGONunrIl9ZOgnWeW5MTXatuDtwoeE=;
        b=HwqQ8NmgoC9S5mubY7Ux0Hy09pjAfPb5aBTncQvZIMkQFBswXwvYdnAeslPl1diHV0
         sSh0kr1Hr39oMraqOIYAKb/cTHE6V8JTI2RDC8DJwLIglm0yg9Ojq/AdsJ5EBS/snNcK
         CO+eXK4neCV0jVMVWo5+avbY+ZLxufdo/mEzlykZ+T5pvhPb3nB9qRqfY5QQTltAHdes
         2pY3EiLQOGH26NcxFDg4nvNPVUG3ECm7050KgPts8tkU9h4Ec6l5dOFK5KU22hms017e
         TswEPaCFKQi8fbK8PBMmT2VoMi2JnEkm/khlhWoqCXkHYoJKa3EM7bBfGzRMW1w4Cjvr
         eQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RGvpnK1n+q61OxGONunrIl9ZOgnWeW5MTXatuDtwoeE=;
        b=SbLwACfa5dP3BpSSEVwHRbWQJLXupqT86kq+J844ddnYlKJvPLlvtyKZRhjBrG05Ly
         bEiuu0OdjRQDK8lNckw6+Dd/8F4hM1CSdST48bVcBPFfFRUv+0fBCpdN44a235CEod14
         WufnAjh1zqwwX/Z+z8Vl7HAs3+MFz7EQ1LW2uNX3j+JLFf10sU211ve8n/zNlV9UOUw4
         mQ4NB/r2FtSW/VisSttayMZ8DypfxDHx31BqS3CrkjNrslbCdXTvtYYue6x3C3tzcdV2
         E8uO1QKdOGlP05I2f3zA3N1ehByhXQk69LRhkwUu8uGxERSucQ02yytIUMygiDQ4nlMV
         Tbyg==
X-Gm-Message-State: AO0yUKWokgF2TRm1GNIPwflqbVAefoSiHm6rX5oJEss9AdFElu+n1iyj
        R5Vh+J6MSPP2FPwtQ8zgb5K2MU1NmFLUVm73
X-Google-Smtp-Source: AK7set+ZVW5HEfxwxYhYO+lHw4arBrpzocSbBURQEB4h6AK4oV0hls/bygX90x+qhzBVLtBaA+4k2Q==
X-Received: by 2002:a17:903:1cb:b0:19a:9897:461 with SMTP id e11-20020a17090301cb00b0019a98970461mr8329597plh.52.1676982504364;
        Tue, 21 Feb 2023 04:28:24 -0800 (PST)
Received: from localhost.localdomain ([103.46.200.150])
        by smtp.gmail.com with ESMTPSA id e8-20020a170902744800b0019a593e45f1sm3628906plt.261.2023.02.21.04.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 04:28:24 -0800 (PST)
From:   ashutosh.pandeyhlr007@gmail.com
To:     git@vger.kernel.org
Cc:     Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
Subject: [PATCH] [GSoC]t7501:modernize the style of test body
Date:   Tue, 21 Feb 2023 17:58:16 +0530
Message-Id: <20230221122816.10236-1-ashutosh.pandeyhlr007@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>

some of the test body followed the old style of test body which isn't
consistent with the new rules which is that multiple commands on one
line should be split across multiple lines this patch accomplishes that
in this test script that is t7501.

Signed-off-by: Ashutosh Pandey <ashutosh.pandeyhlr007@gmail.com>
---
 t/t7501-commit-basic-functionality.sh | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/t/t7501-commit-basic-functionality.sh b/t/t7501-commit-basic-functionality.sh
index fb5417d5e7..c31d6f53f4 100755
--- a/t/t7501-commit-basic-functionality.sh
+++ b/t/t7501-commit-basic-functionality.sh
@@ -33,12 +33,16 @@ test_expect_success 'setup: initial commit' '
 '
 
 test_expect_success '-m and -F do not mix' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD file &&
+	echo >>file && 
+	git add file &&
 	test_must_fail git commit -m foo -m bar -F file
 '
 
 test_expect_success '-m and -C do not mix' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD file &&
+	echo >>file && 
+	git add file &&
 	test_must_fail git commit -C HEAD -m illegal
 '
 
@@ -134,18 +138,24 @@ test_expect_success 'empty commit message' '
 '
 
 test_expect_success 'template "emptyness" check does not kick in with -F' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD file &&
+	echo >>file && 
+	git add file &&
 	git commit -t file -F file
 '
 
 test_expect_success 'template "emptyness" check' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD file && 
+	echo >>file && 
+	git add file &&
 	test_must_fail git commit -t file 2>err &&
 	test_i18ngrep "did not edit" err
 '
 
 test_expect_success 'setup: commit message from file' '
-	git checkout HEAD file && echo >>file && git add file &&
+	git checkout HEAD file && 
+	echo >>file && 
+	git add file &&
 	echo this is the commit message, coming from a file >msg &&
 	git commit -F msg -a
 '

base-commit: d9d677b2d8cc5f70499db04e633ba7a400f64cbf
-- 
2.39.2

