Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C629C433FE
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 17:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiDYRwx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 13:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244080AbiDYRwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 13:52:33 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E763FBD0
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:27 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id u17-20020a05600c211100b0038eaf4cdaaeso5962wml.1
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 10:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qUfWWOqu8WWiZgsDXO1m8WVUNWmmAQIvS1QtdtioVi4=;
        b=MO1j+8IlTwQxd0AQ0JBVQvhOWgBiahxvd4uw0yO0XHtOXasXf/Svrw9laoWKDacB4S
         qISFfMmkk3Dqk79OwNYkpp5hgUJ6aJju3pLCXpCUGmYEwtVbCYGe/DZGki35lc2SZ6mn
         dMxlRBhfxvxDWyi7dxVVHqXoh6toO+4ZFclgGvQ362oCpsGZfkn8WzMlyZ2x2OoKgsK4
         uhDLVqLT1FeMc64agiFNneKZIL7zyJ0SK6L50t3fz9fVmvIAVbkU9Ep4rp5MJgk/FvnF
         pTtB0wMwNE8nMr9nMNQ+4mGtDjlNdPK00xgxpbu9G+WBpDtHaL7vz3jaQqvVNfp6Us8v
         0emg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qUfWWOqu8WWiZgsDXO1m8WVUNWmmAQIvS1QtdtioVi4=;
        b=Dwvt6lolodh/s8Xjkt9pu6Hyd5wpQ5shSj66+j18Usd1fMj1tVN4qW0Y9/Fmq11WW5
         iGQ7EaSAIHv0TtOnZ26DabIogDilMy/auVOQuTGhjd2Jmm1w5Xq9EFqJJ+YakDcy6Y1Q
         mV5JdFUr/fA65QOuOmQpnIzFE5uOVlDSOMDYCIYahC1WUcqsabg3Y9j7z/sqn7KFjWBf
         IGCSmu6HDm+5+7b2HbpnMaHh54scW38RZ7hjN3YH+w8NWy0UQkAlnAgEtkaTHa+Ul6/v
         A068kXPWxt/y/wR4JBYB18oCoCy9c+bfU6ECUBHXNSN/l7MYDzfqZXDSBqgi2b/WNSq3
         tAaQ==
X-Gm-Message-State: AOAM530nZK0kRhEJ2BCZqQRYGA4x/eqzS8H0K6eVm61mvo0ZZJOPIxgv
        V5rm1djBCp0tJ02LqWLchwmxu0UERqs=
X-Google-Smtp-Source: ABdhPJzWXBpPmR8/AIdg8XIyMEOJ+8e0X/oRAwE3voxGZ7KLC8aDP5h4PfYV+QyG2gstHM8D8lzgFg==
X-Received: by 2002:a7b:cf05:0:b0:38e:b707:1c3d with SMTP id l5-20020a7bcf05000000b0038eb7071c3dmr17220853wmg.164.1650908965420;
        Mon, 25 Apr 2022 10:49:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n4-20020a1ca404000000b00392965e41d6sm12245686wme.39.2022.04.25.10.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 10:49:24 -0700 (PDT)
Message-Id: <64edbed0f95623e307371cfc3905786e5b0a02f3.1650908958.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
References: <pull.1171.git.1650908957.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 17:49:14 +0000
Subject: [PATCH 4/7] read-cache: set sparsity when index is new
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, newren@gmail.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

When the index read in 'do_read_index()' does not exist on-disk, mark the
index "sparse" if the executing command does not require a full index and
sparse index is otherwise enabled.

Some commands (such as 'git stash -u') implicitly create a new index (when
the 'GIT_INDEX_FILE' variable points to a non-existent file) and perform
some operation on it. However, when this index is created, it isn't created
with the same sparsity settings as the repo index. As a result, while these
indexes may be sparse during the operation, they are always expanded before
being written to disk. We can avoid that expansion by defaulting the index
to "sparse", in which case it will only be expanded if the full index is
needed.

Note that the function 'set_new_index_sparsity()' is created despite having
only a single caller because additional callers will be added in a
subsequent patch.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 read-cache.c                             | 18 +++++++++++++++++-
 t/t1092-sparse-checkout-compatibility.sh |  2 +-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 4df97e185e9..60355f5ad6a 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2260,6 +2260,20 @@ static unsigned long load_cache_entries_threaded(struct index_state *istate, con
 	return consumed;
 }
 
+static void set_new_index_sparsity(struct index_state *istate)
+{
+	/*
+	 * If the index's repo exists, mark it sparse according to
+	 * repo settings.
+	 */
+	if (istate->repo) {
+		prepare_repo_settings(istate->repo);
+		if (!istate->repo->settings.command_requires_full_index &&
+		    is_sparse_index_allowed(istate, 0))
+			istate->sparse_index = 1;
+	}
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -2281,8 +2295,10 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	istate->timestamp.nsec = 0;
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		if (!must_exist && errno == ENOENT)
+		if (!must_exist && errno == ENOENT) {
+			set_new_index_sparsity(istate);
 			return 0;
+		}
 		die_errno(_("%s: index file open failed"), path);
 	}
 
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index b00c65c7770..a8c1c345ab0 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -1381,7 +1381,7 @@ test_expect_success 'sparse-index is not expanded: stash' '
 	ensure_not_expanded stash drop stash@{0} &&
 
 	echo >>sparse-index/deep/new &&
-	! ensure_not_expanded stash -u &&
+	ensure_not_expanded stash -u &&
 	(
 		WITHOUT_UNTRACKED_TXT=1 &&
 		! ensure_not_expanded stash pop
-- 
gitgitgadget

