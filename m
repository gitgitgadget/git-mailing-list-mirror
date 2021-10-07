Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686C6C433FE
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50C8C61058
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 21:15:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbhJGVRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 17:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbhJGVRj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 17:17:39 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602C7C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 14:15:45 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id r10so23112827wra.12
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+dch2aTLAv85TXXA5lgJ4m8qNH4dps5WqL8q9u/O5kk=;
        b=GiqxvrLcKhOyzq6Zj1xNKHxmueqhGbaKAghBQaunqzSDWpcGFfYe46AgQZhjYo1Fgo
         3Pv5sBWQ1ZgC0Iunc1DXM6N5TC3Mw9x7JDeqrKlZQZjyXMwPV9TeTocIjX+qRYfWJaXI
         Dnw9cjMNgZZS7EbgbQcutGuUGZDFZtXHv6DSZ71NH/hrDpqw/CEpRlYqYM9B6n5rBXet
         GBwzD/AuJV5xLGInpvdJB56qS1hyHeRWAkmZbcbLC3quAqB/imFO4YnZsy7D5vqnKGlQ
         VnO/2fb/fT1Pk76q6Xb9EoDVSKj6iHtYa9kz8qb0x4RSRjTBTMmuTa1AcGgnGCyCO9U/
         H92w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+dch2aTLAv85TXXA5lgJ4m8qNH4dps5WqL8q9u/O5kk=;
        b=L5mRYbi402d4dL/h45YyRopQAt2K0Q5KKIFyzH2F/nYcUqSY8iQyJXsNzgVIv4cQqW
         IjVKkzYIF4HG9jc8JxQ52HZg0VuVfHxJB0b+TKWScysSTjPIK2uWN2kBaFilFCNWHo1A
         tWL5kYO+tzJ4atr2hojA9vY9nnTmg3WyZow+T9Aa4ob4rvqGAVSqwk5O+/5Ybzy/C4L6
         aZk6QMXdy77R+nouMSgIpV1uvS+ZmTg1XiLKcoyQ2zHyf3y38IOj8EQ4unAqJH2Bi4qD
         +dxt2PSiWuxw8pJOLaNPG4KzFAbvSqEyefaWlR+q1wBkk1ICMAXkcxWEHaLBAPf5rXyQ
         IhTA==
X-Gm-Message-State: AOAM533mjyq1DSYKuKiy7Iz+ys5hUkcev6oKXPMvcBwW9H3I5Kqa56zd
        uG/60WvM8ThWjxDP1MWvPYp3wXzs0jI=
X-Google-Smtp-Source: ABdhPJywXTB3D+DTwcxxfnJccBSbnJjlDthoo+AZZEKDTtcaQpk/NNSHlxxkb52ABKTzkFFwoWtBdA==
X-Received: by 2002:a7b:cd0f:: with SMTP id f15mr6978913wmj.173.1633641343996;
        Thu, 07 Oct 2021 14:15:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7sm482799wrh.13.2021.10.07.14.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 14:15:43 -0700 (PDT)
Message-Id: <a2d6212e287136b52b7eb904682523ed246f07e2.1633641339.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
References: <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
        <pull.1048.v3.git.1633641339.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 21:15:35 +0000
Subject: [PATCH v3 5/8] reset: integrate with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, gitster@pobox.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Disable `command_requires_full_index` repo setting and add
`ensure_full_index` guards around code paths that cannot yet use sparse
directory index entries. `reset --soft` does not modify the index, so no
compatibility changes are needed for it to function without expanding the
index. For all other reset modes (`--mixed`, `--hard`, `--keep`, `--merge`),
the full index is expanded to prevent cache tree corruption and invalid
variable accesses.

Additionally, the `read_cache()` check verifying an uncorrupted index is
moved after argument parsing and preparing the repo settings. The index is
not used by the preceding argument handling, but `read_cache()` must be run
*after* enabling sparse index for the command (so that the index is not
expanded unnecessarily) and *before* using the index for reset (so that it
is verified as uncorrupted).

Signed-off-by: Victoria Dye <vdye@github.com>
---
 builtin/reset.c | 10 +++++++---
 cache-tree.c    |  1 +
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/reset.c b/builtin/reset.c
index e441b6601b9..0ac0de7dc97 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -180,6 +180,7 @@ static int read_from_tree(const struct pathspec *pathspec,
 	opt.flags.override_submodule_config = 1;
 	opt.repo = the_repository;
 
+	ensure_full_index(&the_index);
 	if (do_diff_cache(tree_oid, &opt))
 		return 1;
 	diffcore_std(&opt);
@@ -257,9 +258,6 @@ static void parse_args(struct pathspec *pathspec,
 	}
 	*rev_ret = rev;
 
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
-
 	parse_pathspec(pathspec, 0,
 		       PATHSPEC_PREFER_FULL |
 		       (patch_mode ? PATHSPEC_PREFIX_ORIGIN : 0),
@@ -405,6 +403,12 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
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

