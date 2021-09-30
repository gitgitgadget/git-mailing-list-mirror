Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70119C433FE
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B0361A53
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 14:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351966AbhI3Ow5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 10:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351935AbhI3Owt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 10:52:49 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB1CC06176C
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t8so10591913wri.1
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 07:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=w79fXmbOvGKw0WLlbAEiKlsjPfzf+UKHarCUeckfFeI=;
        b=H6tQ5CUgF7XW3aM9Inw+RcOYdeTKEEjMlvBmOWNuSIgwe08pEDzGFU9Iha90I6i3mn
         0++yvbny3wtnaoIc4rEuxiW9K1xPPMXIjoE5FVe1Mcf73UMJf93l0Rd20OokIPk6d18J
         asaxxTSj3QX+6PHvgQ0EipvY9/00d8HCJMvmu0g5BgLtI69DjlsQbC0r0HUe0p84ZFQb
         tnd2GhJMZynvSfbDG/8/05kdzTemFPF/jPuIYZBv/4ckYgODfYYjO0MACjaVDe8n7Yl9
         cpuYS2jubCOBfn8MrNNSH0QR+jwGHMIEJS7v+EbTgS8WfynSPg5iLTefa/6h4KGKFKan
         1blQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=w79fXmbOvGKw0WLlbAEiKlsjPfzf+UKHarCUeckfFeI=;
        b=m41TDRBLQkYClMpe5TLmO0CFdsYW2w/Byq+ceAvADJod95MuBnkccN2NbR+N99h/8g
         AxPmjSq4q1a+BBIdUY7Ag6BhyuV9zX3kH9VBK+5uovWoj/x3YbPUJp5pJTH4ox6ugc8K
         gxW9C+OtULQsfDJg/N8Qcrzw0A4YPMBFqFCL9XC+rUjxTvA1/C8jY2EzZbz2yzgg5hut
         j7vseAuKMJfUWemvgoGO/UdkKwRUaKHoZcaPfhg5xUuuCDo/BZ/GqVEqq6wz6s2Acplp
         ilYQRLgaUVixmxRtj/PFlqFADye+Z0OxOYgrLpJ6RjnIuQiG7T25PJvedq36gyETeEOg
         m5Yw==
X-Gm-Message-State: AOAM530ivY5HzmSb8ZsLGdB0/xTl9Q2Iv5V+D1QiRxZ5nGO+RsqGRopt
        glGnrc+OamxofatyJYBx+Zwve4OxGyg=
X-Google-Smtp-Source: ABdhPJw3gh4DA562UPyqbhJEWo4elbD2ljk2TFQZGaHCLvxAIvIiIzcKciiQlKKd13H+qjU6NfjSMA==
X-Received: by 2002:adf:b304:: with SMTP id j4mr6864854wrd.160.1633013465331;
        Thu, 30 Sep 2021 07:51:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b130sm5525123wmd.44.2021.09.30.07.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 07:51:05 -0700 (PDT)
Message-Id: <2d63a250637d62f8966b8b78b4f57b7c6784c967.1633013461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Sep 2021 14:50:58 +0000
Subject: [PATCH 4/7] reset: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

`reset --soft` does not modify the index, so no compatibility changes are
needed for it to function without expanding the index. For all other reset
modes (`--mixed`, `--hard`, `--keep`, `--merge`), the full index is
explicitly expanded with `ensure_full_index` to maintain current behavior.

Additionally, the `read_cache()` check verifying an uncorrupted index is
moved after argument parsing and preparing the repo settings. The index is
not used by the preceding argument handling, but `read_cache()` does need to
be run after enabling sparse index for the command and before resetting.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 10 +++++++---
 cache-tree.c    |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index 8ffcd713720..92b9a3815c7 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -205,6 +205,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.flags.override_submodule_config = 1;
 	opt.repo = the_repository;
 
+	ensure_full_index(&the_index);
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
 	diffcore_std(&opt);
@@ -282,9 +283,6 @@ static void parse_args(struct pathspec *pathspec,
 	}
 	*rev_ret = rev;
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
-
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
@@ -430,6 +428,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 	if (intent_to_add && reset_type != MIXED)
 		die(_("-N can only be used with --mixed"));
 
+	prepare_repo_settings(the_repository);
+	the_repository->settings.command_requires_full_index = 0;
+
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
 	/* Soft reset does not touch the index file nor the working tree
 	 * at all, but requires them in a good order.  Other resets reset
 	 * the index file to the tree object we are switching to. */
diff --git a/cache-tree.c b/cache-tree.c
index 90919f9e345..9be19c85b66 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -776,6 +776,7 @@ void prime_cache_tree(struct repository *r,
 	cache_tree_free(&istate->cache_tree);
 	istate->cache_tree = cache_tree();
 
+	ensure_full_index(istate);
 	prime_cache_tree_rec(r, istate->cache_tree, tree);
 	istate->cache_changed |= CACHE_TREE_CHANGED;
 	trace2_region_leave("cache-tree", "prime_cache_tree", the_repository);
-- 
gitgitgadget

