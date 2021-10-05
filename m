Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DBFC4332F
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD59761503
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 13:21:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbhJENW5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Oct 2021 09:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhJENWx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Oct 2021 09:22:53 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16129C061765
        for <git@vger.kernel.org>; Tue,  5 Oct 2021 06:21:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id s15so9131286wrv.11
        for <git@vger.kernel.org>; Tue, 05 Oct 2021 06:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QGx9YF/7G8kGWdo5Kg9eFed6hLSyObhsMNY0mgtnrKk=;
        b=UDfMhIBdLeVY4EHIedpBT270bflypzHA/v6QCNVUwipFnQliXqeYgk0p4yO9Ifol6O
         azGlEgty6fAWGusXM1/sw64UvpM0KbQueBIYIVhRzBMu48sewF7WPsWCYUNRTcK7alrr
         sw9AOiOL9aAvawoPOO9TzKQozfnI3x6NDMGU/GXyVmy1pSkCXg1vAAqoyRziXcmn/Gvw
         FyyHATGG67AqdvJHNRvPc3T4i39SkRatcZqNMcuSJJ2UwDo6M3mn9jT900E2LfPKnE8y
         uw4iU37ZKb84yXhZJGsR3x/m9ud0ycXfEXWV0il8w+bWGP8Rdtaoxt2US/1/QOnpbcwN
         Qlxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QGx9YF/7G8kGWdo5Kg9eFed6hLSyObhsMNY0mgtnrKk=;
        b=BgklmM5jvVGYzqNue6mji03DdqWSF1PC+oJQ/HkXMzJpTmxbxUDuWVBowXhonnE6IK
         DQT2Bdqan59Fpk6swtD+bniROb7AMoRYDqqSl3z3+/tLnRgBF+jpJkr3JBAg0cyMT5Ec
         Q5ugKhTGvVwMnRyfE98+61m/ElH05FR0myTDDzRdPU0a9KOyGJLhqwiYeoh9VC409gY5
         pGksf0B8hKDckBijgcvTeKPPI663rUMFwLEZJLJAMXRZTl2SwMCzTmjHkjtjALxoUCfU
         6ueGbhq7u5AxtOqfFN04dOVKxEIeqGeqn6yAN3YI4CsCHR6uYIQoZlk3cGTv7B2sKxiV
         HrRQ==
X-Gm-Message-State: AOAM532ZR/Ctr9TpHk+H5970Ea/vYomIl8EkehA/BRomXXEJ8I5648eq
        PUgkYJMHoQ2NattntAMyL1VwbCz2CCg=
X-Google-Smtp-Source: ABdhPJzHo0tXVhQkgFoolXRlnOKEaYnUl743ERBp/bnjENV1S8rSmy9bE8ti1I8P8J35Ezbr/1/mJQ==
X-Received: by 2002:adf:b1c7:: with SMTP id r7mr9562772wra.392.1633440060683;
        Tue, 05 Oct 2021 06:21:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm17185547wrs.75.2021.10.05.06.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 06:21:00 -0700 (PDT)
Message-Id: <49813c8d9ed94fd56f30eb204d346eb5a30473ca.1633440057.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
        <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Oct 2021 13:20:54 +0000
Subject: [PATCH v2 4/7] reset: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
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
index 3b75d3b2f20..e1f2a2bb2c4 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -184,6 +184,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.flags.override_submodule_config = 1;
 	opt.repo = the_repository;
 
+	ensure_full_index(&the_index);
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
 	diffcore_std(&opt);
@@ -261,9 +262,6 @@ static void parse_args(struct pathspec *pathspec,
 	}
 	*rev_ret = rev;
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
-
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
@@ -409,6 +407,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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

