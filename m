Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A4EC25B08
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 02:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiHGC5T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 22:57:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHGC5R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 22:57:17 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270E1E0F0
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 19:57:16 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id l22so7310888wrz.7
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 19:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=KmzkJanP+r7zmAbvFVV+dBLWZoBVdjJr9uFqVzfdDDA=;
        b=XaFyl/xrteKxoik9RBhuHZjLyZsuXMDeyK1t6rOdqNPsZl82O/G8fIo/DSBoq56jUE
         5dWKILWQuBu/9/hieovqQYG82+ZPbTCjvlJjz+1cjcX04J3t74woyGXdEEBo/AfAtRQN
         lRYgKdttPdOb1pO9fYH6PvhTB77qH7mgyK4jdtm8xizrjkkZ1AKGLyPBev49ByFt0g/o
         RFzGAUNpbXm1r5DnWBqh0KIenCVYpEA4zkHu6b/s8aF7gHlejAOnFSWHf18az2mqstJx
         Khp9e+60n7eBToyNu6+MC2FLnbnhI5O+9yODq5Ve9zWu/w2OZSGtLB3N9oyuTQgj4HWt
         sdMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=KmzkJanP+r7zmAbvFVV+dBLWZoBVdjJr9uFqVzfdDDA=;
        b=Ktz0QNRMLWcl4Glo3sivd8xi7CEbG63Rc4gVYOqlLH2xTZnd5vkLse/9vjYT1GhQzX
         f1L3TwmxN7W2Y3eC7Gx+O5l7rRcOZSoSbY9YekxNolu/He6MUOFtxzUksFHrzJp0S3vG
         miwGQ5gQrDszPUiSBQBw/vPeLMDsfEgC8vpCcE8q0BlUd/MsSZ2++urGHPV8zeQZUX8T
         kh6qYp9FDv8UVO+C3ZGvJOnYE/FC/K3ZqhMilv3bLW3RIWSM5kyN+YtTHICps6H979M8
         PzV64vE+ddn2FfYRH5heOK6f34u66i+noIoyL8F0STSgAidIe3nxsMgXxD/+/YJO7MRa
         t78A==
X-Gm-Message-State: ACgBeo2MbaGL6FQTbMQUIm/jofOqknm5bZBwjYDUYX377q+cFThJwO/Q
        fWNPKal12W35U8IzAL6gdbDkjtIUug8=
X-Google-Smtp-Source: AA6agR5ZBZoEq7Qskt1NGAevoMxHWuFGjcLp1AwQSnZ05qFz1iUUHELWXx/sZD17M+l9y94jluJfFg==
X-Received: by 2002:a05:6000:4083:b0:21f:fb6:9293 with SMTP id da3-20020a056000408300b0021f0fb69293mr7762761wrb.303.1659841034341;
        Sat, 06 Aug 2022 19:57:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c4f4600b003a4eea0aa48sm10091087wmq.0.2022.08.06.19.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Aug 2022 19:57:13 -0700 (PDT)
Message-Id: <255318f4dc61daef3e892a4dd5c571463985f340.1659841030.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
        <pull.1312.v2.git.1659841030.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 Aug 2022 02:57:06 +0000
Subject: [PATCH v2 1/4] checkout: fix nested sparse directory diff in sparse
 index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, shaoxuan.yuan02@gmail.com,
        newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Add the 'recursive' diff flag to the local changes reporting done by 'git
checkout' in 'show_local_changes()'. Without the flag enabled, unexpanded
sparse directories will not be recursed into to report the diff of each
file's contents, resulting in the reported local changes including
"modified" sparse directories.

The same issue was found and fixed for 'git status' in 2c521b0e49 (status:
fix nested sparse directory diff in sparse index, 2022-03-01)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/checkout.c                       | 1 +
 t/t1092-sparse-checkout-compatibility.sh | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 29c74f898bf..f9d63d80b92 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -626,6 +626,7 @@ static void show_local_changes(struct object *head,
 	repo_init_revisions(the_repository, &rev, NULL);
 	rev.diffopt.flags = opts->flags;
 	rev.diffopt.output_format |= DIFF_FORMAT_NAME_STATUS;
+	rev.diffopt.flags.recursive = 1;
 	diff_setup_done(&rev.diffopt);
 	add_pending_object(&rev, head, NULL);
 	run_diff_index(&rev, 0);
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 763c6cc6846..99a1425a929 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -372,6 +372,14 @@ test_expect_success 'deep changes during checkout' '
 	test_all_match git checkout base
 '
 
+test_expect_success 'checkout with modified sparse directory' '
+	init_repos &&
+
+	test_all_match git checkout rename-in-to-out -- . &&
+	test_sparse_match git sparse-checkout reapply &&
+	test_all_match git checkout base
+'
+
 test_expect_success 'add outside sparse cone' '
 	init_repos &&
 
-- 
gitgitgadget

