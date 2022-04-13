Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E001C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 15:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236546AbiDMPfB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 11:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234705AbiDMPe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 11:34:59 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664ED37ABD
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:32:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso1408272wmz.4
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 08:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ir+pXSsJCHvJEuBZzgumGeZkqjpPI6gnVe8nyyS4CC4=;
        b=at5qdLwO78fquIZ8VOpTF2nS7PqXvkpIYY0pfX7e4s8rcmW97T247sTFEUSla/D49X
         GgmEmsm7VDCoJGwX42mDr+OBg1UGysSkkCbj2+F0KX+2m2SKXUrB5wtVNYGLVK3wkLSY
         Ji21+efP3V50vgye63/dZeqPpXSEe4kSPTfMK9uNGMvVLrPrZ0VXRtTZFeU9paozP3lM
         wwyPnHBkNSsiQfprQGVpYCfiJKV00bjmqG0nYWLJg1zbelHwVBO0Q589tYW1OM8RB0l6
         U8dVWlL0bdLUyNIiCzO2JBGHTwPIboIci3Eg43xT+qDSL25mK8DnhsQon2eSS60XNO7x
         9NRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ir+pXSsJCHvJEuBZzgumGeZkqjpPI6gnVe8nyyS4CC4=;
        b=ch9GCljqyw9fRjlCJuDukoqDABJ2d9ZE9xj0HWk5vn/A00tueVJPKb7j7i/P6ZUQvO
         4SjBtEj1PREVdDVQL6h5b3E6wr1jU+JGhiTLR5MVAlImWdFve1Bs/TkBLtQXXHD8xpfw
         Baaht4DOwdprRPp0bQxMFM02yNE/bZ6HShauZ5vKCkZh9gEzuIKOE6KvdHD0bKSHF9S+
         xsGe6iVbvi68vj+pfipGCsvxa2XLm/qoymhQC6apR87FVp5rCZ9al81r6rGkv/gUb705
         1BRbOlOxU9Jesz3LYBlGY5Xt7Y6BVhID/UvAlupF6C0h23CfCm3YoB34tnzaBznyadPq
         wHvA==
X-Gm-Message-State: AOAM532uJe6JMxoxanoZ3M5IZE1N+E/ynrTo5zMAZNMVENFI+3X4Ns5c
        P2PJsbfbGfUwNfe916Ny27/iPk3f0hI=
X-Google-Smtp-Source: ABdhPJx8BWJuER5Rqq+qebiuw0YaWnTAKbcVpsm3L9l7rbYRaEGIrMyjfA7OrlWFRbSYa49GRFTqNw==
X-Received: by 2002:a05:600c:1e08:b0:38e:c0e4:e500 with SMTP id ay8-20020a05600c1e0800b0038ec0e4e500mr9305237wmb.28.1649863954615;
        Wed, 13 Apr 2022 08:32:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v26-20020a1cf71a000000b0038ea373273bsm2691403wmh.47.2022.04.13.08.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 08:32:34 -0700 (PDT)
Message-Id: <5b18bd1852d673ab5c62a67f873987d74294cd70.1649863951.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
References: <pull.1215.git.1649863951.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Apr 2022 15:32:29 +0000
Subject: [PATCH 1/3] t0033: add tests for safe.directory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

It is difficult to change the ownership on a directory in our test
suite, so insert a new GIT_TEST_ASSUME_DIFFERENT_OWNER environment
variable to trick Git into thinking we are in a differently-owned
directory. This allows us to test that the config is parsed correctly.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 setup.c                   |  3 ++-
 t/t0033-safe-directory.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 1 deletion(-)
 create mode 100755 t/t0033-safe-directory.sh

diff --git a/setup.c b/setup.c
index c8f67bfed52..f54f449008a 100644
--- a/setup.c
+++ b/setup.c
@@ -1119,7 +1119,8 @@ static int ensure_valid_ownership(const char *path)
 {
 	struct safe_directory_data data = { .path = path };
 
-	if (is_path_owned_by_current_user(path))
+	if (is_path_owned_by_current_user(path) &&
+	    !git_env_bool("GIT_TEST_ASSUME_DIFFERENT_OWNER", 0))
 		return 1;
 
 	read_very_early_config(safe_directory_cb, &data);
diff --git a/t/t0033-safe-directory.sh b/t/t0033-safe-directory.sh
new file mode 100755
index 00000000000..9380ff3d017
--- /dev/null
+++ b/t/t0033-safe-directory.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='verify safe.directory checks'
+
+. ./test-lib.sh
+
+GIT_TEST_ASSUME_DIFFERENT_OWNER=1
+export GIT_TEST_ASSUME_DIFFERENT_OWNER
+
+expect_rejected_dir () {
+	test_must_fail git status 2>err &&
+	grep "safe.directory" err
+}
+
+test_expect_success 'safe.directory is not set' '
+	expect_rejected_dir
+'
+
+test_expect_success 'safe.directory does not match' '
+	git config --global safe.directory bogus &&
+	expect_rejected_dir
+'
+
+test_expect_success 'safe.directory matches' '
+	git config --global --add safe.directory "$(pwd)" &&
+	git status
+'
+
+test_expect_success 'safe.directory matches, but is reset' '
+	git config --global --add safe.directory "" &&
+	expect_rejected_dir
+'
+
+test_done
-- 
gitgitgadget

