Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35730C43219
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 01:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232356AbiKJB6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 20:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbiKJB5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 20:57:50 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBF02A976
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 17:57:24 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so260732wmb.0
        for <git@vger.kernel.org>; Wed, 09 Nov 2022 17:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtq3iPEAnMV1G7hru853ch69TOxtztyX7mt4g8SPMWI=;
        b=qJMzFY+Ianc8yNMNfnZydV6W155n0L4BjuEg6cbv5XiRkaJ7h+1Df624RiwdPMhEcF
         prIaMgP5N69qYJZcchBzk5Wee2fKDGaQizDP2N64WO4ADrcWCMKwV1tUv12rgiWu6z1c
         jfGgi1iH1nnp8Uifekx3u4JOZMToa7Zk2NumQCBrXe4iGTw6j3mf+nJxKApY043NOU9k
         Fma5XQOAHt8RHpJTxoOgNsjFdAJyGqU06MqNuci5+AqlKXFRy+l5C+q2LPXSpZfnBuzv
         U5+WBs8ZI0v1rlRDxM1ILKb0WSMXvzDXIQh28lQbc8qf4zODbAoiJ+ec5f60emOY5i4H
         Ra4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtq3iPEAnMV1G7hru853ch69TOxtztyX7mt4g8SPMWI=;
        b=p/hrabtPw4y2ATKlPScY+7s8AOpv2EGdOo7E8QBeqytR59zSseXI+qj+BFqnL0bRj/
         cikSiyg41Cj+n27vglABEngDVHcRE9applSh9I5PpIeLgJBDFiL0TAAwCzLOmnZrwUvD
         ma3FPFJG2kpLpATdI/bNyq/SJqErraKAeDVthJ9pjtIdlH7q7Y1mSrzIIEHKvmfSBS5Q
         co30Kn28aXgOYV9zkB2OA7E9ms/t2fJneFt3jbjbNMC1rjX46os6dZZM2n2uHdGfWkA4
         aU0QC0vG9AspZsvlIQbmVg5iilrvLp/OfAnP1Z1tv28ldqn5uPZwrNFpVYjYyw0Q6pYh
         3ojw==
X-Gm-Message-State: ACrzQf0msv/Rtd/OlE4JI/jAk3SfxnMApNFX5rQ+3QzLDOOWIU08tupC
        pEd5UWblH/4hflga7BjR2S5idcwVa7A=
X-Google-Smtp-Source: AMsMyM44ORO3OCPrSou4dRB7tHeHnMHGBUJw26WkvRjpeX7fR8v9aaNe7O6GGYKlMGmnWORrjv6a/A==
X-Received: by 2002:a05:600c:19d1:b0:3c7:b52:3aa4 with SMTP id u17-20020a05600c19d100b003c70b523aa4mr52856990wmq.56.1668045442538;
        Wed, 09 Nov 2022 17:57:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c029a00b003cf5ec79bf9sm3321333wmk.40.2022.11.09.17.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 17:57:22 -0800 (PST)
Message-Id: <4f6039971b87d84b1f44d8da4cd106777cc1c38f.1668045438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
        <pull.1411.v2.git.1668045438.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 10 Nov 2022 01:57:15 +0000
Subject: [PATCH v2 3/5] reset: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Taylor Blau <me@ttaylorr.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Enable the 'skip_cache_tree_update' option in the variants that call
'prime_cache_tree()' after 'unpack_trees()' (specifically, 'git reset
--mixed' and 'git reset --hard'). This avoids redundantly rebuilding the
cache tree in both 'cache_tree_update()' at the end of 'unpack_trees()' and
in 'prime_cache_tree()', resulting in a small (but consistent) performance
improvement. From the newly-added 'p7102-reset.sh' test:

Test                         before            after
--------------------------------------------------------------------
7102.1: reset --hard (...)   2.11(0.40+1.54)   1.97(0.38+1.47) -6.6%

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c       |  2 ++
 t/perf/p7102-reset.sh | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100755 t/perf/p7102-reset.sh

diff --git a/builtin/reset.c b/builtin/reset.c
index fdce6f8c856..ab027774824 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -73,9 +73,11 @@ static int reset_index(const char *ref, const struct object_id *oid, int reset_t
 	case HARD:
 		opts.update = 1;
 		opts.reset = UNPACK_RESET_OVERWRITE_UNTRACKED;
+		opts.skip_cache_tree_update = 1;
 		break;
 	case MIXED:
 		opts.reset = UNPACK_RESET_PROTECT_UNTRACKED;
+		opts.skip_cache_tree_update = 1;
 		/* but opts.update=0, so working tree not updated */
 		break;
 	default:
diff --git a/t/perf/p7102-reset.sh b/t/perf/p7102-reset.sh
new file mode 100755
index 00000000000..9b039e8691f
--- /dev/null
+++ b/t/perf/p7102-reset.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='performance of reset'
+. ./perf-lib.sh
+
+test_perf_default_repo
+test_checkout_worktree
+
+test_perf 'reset --hard with change in tree' '
+	base=$(git rev-parse HEAD) &&
+	test_commit --no-tag A &&
+	new=$(git rev-parse HEAD) &&
+
+	for i in $(test_seq 10)
+	do
+		git reset --hard $new &&
+		git reset --hard $base || return $?
+	done
+'
+
+test_done
-- 
gitgitgadget

