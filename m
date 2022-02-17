Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD457C433FE
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 06:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiBQGzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 01:55:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235801AbiBQGzH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 01:55:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57CB27F296
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:53 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id az26-20020a05600c601a00b0037c078db59cso3239400wmb.4
        for <git@vger.kernel.org>; Wed, 16 Feb 2022 22:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XS/de9nZ8Iv+oNlhfd/f9n9uf/JZJYBvZ/8IR+hcM2U=;
        b=WLNTc6HC6hFFBtSfxFI0KQTfZeoe3TNJB1XAmlO3qBPx5HiXbLBu9VOOMtdkhcVyZ2
         zwyYfhJTUxgOURt3Si9t7vz776Q6Sajjj9EWD5oGwJ8BVY7n0qBOkCrHB/KkAIUmW2If
         SvJNgvMywm2cqjyuIMHBrDr7iVOtWIABY/rTINbYTQHbzRXnfuq45uCsvk7i8FjvdRVv
         0eEUlztzgqwf6M4/nEXQZOv/Y2QuaN7XoZIbPe2A/Zxng7xJ/MZ76cyT5U9t5o5ut0E6
         jmRV4E138RWsGubHJS897L41xKicJVXVPyHSVaW6wvLJVWlkgpMrJkUBYkzWoo/++O9t
         uPMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XS/de9nZ8Iv+oNlhfd/f9n9uf/JZJYBvZ/8IR+hcM2U=;
        b=X/sJEyF2S9h6FU/TT/a04XZPCMzawtlqRdMhDnE7S3YeHQlS3RxhN94+NUaPiM0xk1
         LBxeviwDAcgM3KpY7V73qd/C/UGmxTSc5IPVrH53TIp3B53wTYJnX8p0aKCuF+M3YWvL
         aDADi1ndioNzLycyaGJjLsrcbPj82Gi0EqJOMt9oEyUHqEqoWgKPz1GLhTtniPQCKZpN
         vC4T/aufvKn2VP+tBXaXTrsJ4+WUHJnvJ0pQxEyqIivMKe/UP1t23fYGC8Ika0x40229
         y6AEdSNj9ENiD1ExRmH9/tBeDeD2WhrSTEe+vIJRAjdAK7bBI0u5zcBBbEy3NLnMTqEt
         3FRA==
X-Gm-Message-State: AOAM530iG7zq31uJt043NBrJgYWjEnmAO0gMdc+WwDYXhRuZBmQkXJDH
        J+TMT2eCxpTsdeaqZ2c6LicqQc6VGKo=
X-Google-Smtp-Source: ABdhPJz0v6zfY/1++GfP24nL1jEKxYtcisyd74iHsI9WfRJ6o3CQetFPnW/oZMs6b0iuOag96dnsWQ==
X-Received: by 2002:a7b:ce12:0:b0:37b:b39d:8d73 with SMTP id m18-20020a7bce12000000b0037bb39d8d73mr4566573wmc.168.1645080892199;
        Wed, 16 Feb 2022 22:54:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z10sm216107wmi.31.2022.02.16.22.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 22:54:51 -0800 (PST)
Message-Id: <5215b7f7179824468da9476891833ff4cdb28404.1645080889.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
References: <pull.1118.v3.git.1644985283.gitgitgadget@gmail.com>
        <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Feb 2022 06:54:45 +0000
Subject: [PATCH v4 1/5] sparse-checkout: correct reapply's handling of options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 4e256731d6 ("sparse-checkout: enable reapply to take
--[no-]{cone,sparse-index}", 2021-12-14) made it so that reapply could
take additional options but added no tests.  Tests would have shown that
the feature doesn't work because the initial values are set AFTER
parsing the command line options instead of before.  Add a test and set
the initial value at the appropriate time.

Reviewed-by: Derrick Stolee <derrickstolee@github.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c          |  6 +++---
 t/t1091-sparse-checkout-builtin.sh | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index a311483a7d2..fcd574f5fc1 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -789,15 +789,15 @@ static int sparse_checkout_reapply(int argc, const char **argv)
 	if (!core_apply_sparse_checkout)
 		die(_("must be in a sparse-checkout to reapply sparsity patterns"));
 
+	reapply_opts.cone_mode = -1;
+	reapply_opts.sparse_index = -1;
+
 	argc = parse_options(argc, argv, NULL,
 			     builtin_sparse_checkout_reapply_options,
 			     builtin_sparse_checkout_reapply_usage, 0);
 
 	repo_read_index(the_repository);
 
-	reapply_opts.cone_mode = -1;
-	reapply_opts.sparse_index = -1;
-
 	if (update_modes(&reapply_opts.cone_mode, &reapply_opts.sparse_index))
 		return 1;
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 3592d124424..ce5e7c19efa 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -495,6 +495,34 @@ test_expect_failure 'sparse-checkout reapply' '
 	git -C tweak sparse-checkout disable
 '
 
+test_expect_success 'reapply can handle config options' '
+	git -C repo sparse-checkout init --cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --no-cone --no-sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout reapply --cone --sparse-index &&
+	git -C repo config --worktree --list >actual &&
+	cat >expect <<-\EOF &&
+	core.sparsecheckout=true
+	core.sparsecheckoutcone=true
+	index.sparse=true
+	EOF
+	test_cmp expect actual &&
+
+	git -C repo sparse-checkout disable
+'
+
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
 	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
-- 
gitgitgadget

