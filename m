Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3303AC4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiKHWol (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiKHWob (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:44:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97A6209A9
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:44:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id h9so23257884wrt.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jtq3iPEAnMV1G7hru853ch69TOxtztyX7mt4g8SPMWI=;
        b=U8WEFKkYJMKYQUZBLQAA711nB2T+sLqYdBuGPKvm1d/racSVcWop30zJS55OeVQJB6
         7XPqYdAG6nGLsBdSAJu8elMlEFDnqWvBVKAPvDJCDln+7iGeXzfg5SxzfqpM6eKGyu5o
         YcjA42rG/OjIsdSQf1kX0xJks0tcZK/7jCoCP9gGAYzCxU8oxfs7FP2+1FSazuPw2o+4
         B1tJ7WgeVhAMAuhEVZE8soBnrqq0+qk+B63bPq+dvAVlBPiFhDIPpE+TFoOOu8od2qU1
         A+Vs6SMNw8dYoBHiMdAGHRYRnE3NVXhLDD4BpX+XvByML8y8qqjCzW8itF4FizZ/ZrVB
         POCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jtq3iPEAnMV1G7hru853ch69TOxtztyX7mt4g8SPMWI=;
        b=fQ5n3NCi0oidwQcWJLcIeyn97C3DLPWlvaGAMzrbiqkSHnHX76pdmKASI6EFZt3e2P
         B2izAgi/IerGbHW4DVLiMgWjD9AvPgT9uy1U669Msl2CdGMMXEZUzrsVVmCDVi5oAvHA
         Khm8ym+hDubkapT+jNUqfqSyFh6ukP9itzJp5Sv2r7rR+bXrf/wjM4tgW1fDvyDPe/W3
         fMDDt7md4XV47zQ6cGbd01f4gvbUzQDb8qfuL6OBssbVCXEuLolvjl6SHumXvEGzihXw
         gr0p9GfgZ53q+Xkxd5Uwvrj/LPwySk2ZnykBIihoY3PhoGmbm1RVuFZHiwzocEBP8WuT
         O26Q==
X-Gm-Message-State: ACrzQf0twT3G9jfPyKZ1FCQCSXB54y6d0WN4PPQizexxnkhsEDC17Iud
        0ccSmz2Yb2LK4O/s1+plCkVQeY5SZ5c=
X-Google-Smtp-Source: AMsMyM5ZiTXC0EkQziEAhrwTtVwCal91EHSlqvjijfziVXQR4FZA321WvkXGOyDhmfEAWipwJze89A==
X-Received: by 2002:adf:f0c9:0:b0:236:26a2:34e3 with SMTP id x9-20020adff0c9000000b0023626a234e3mr35765640wro.541.1667947469076;
        Tue, 08 Nov 2022 14:44:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b003b49ab8ff53sm13759305wmq.8.2022.11.08.14.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:44:28 -0800 (PST)
Message-Id: <908fe764670af2572a6171c163abf36f4ed8e41a.1667947465.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
References: <pull.1411.git.1667947465.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Nov 2022 22:44:23 +0000
Subject: [PATCH 3/5] reset: use 'skip_cache_tree_update' option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, phillip.wood123@gmail.com,
        derrickstolee@github.com, jonathantanmy@google.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
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

