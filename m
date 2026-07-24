Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8D93A1E67
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784921390; cv=none; b=YTsNJkZtNOy1oYNaNmKAi90HPek/2xieIfIdsGFLE6Awdj9s1DOxf0YX5H0QhOUmYCw/l+RQx386t0y12ZQPenExq8xFhsjJk+jUZMTJITfcRlXbmKcjoaS/fS/oX1uXfS102n2gHNJ0a22tzJ5axsBG9E0mrRx4odw4JAAGt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784921390; c=relaxed/simple;
	bh=4q9pjboy9jScK1my5XhpDzX11J1+OHSVlBdf24ZSzDs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=VgZJotlKht/yYZ/ekOxrfbXxDqR62TCCH/VnBlZKF4wwXSpkbvtj66APdPVIUBPu9hNobh7EwEyk2GdsPGQ5RNEgq5xHjXY5POW1dzrPnEHUZaEqBzzHpHO06UMyKo84sZcZpAS/7stZt+2kofWlDbTyr/AlmK891eH4QamQmXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7NVy0AI; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7NVy0AI"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38f0f132f56so659354a91.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 12:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784921385; x=1785526185; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NND2ZAWSGBlGRys7jRUsdKZimRZ4EvPaiV+gin1wtns=;
        b=R7NVy0AI54Z2GHLhzZnoCspad+77N4+EqJSTF7lrjCoYCZqaHc9xJIytF1wmhjfLmK
         KEVizFCUviVuTmnwyZoPQGH+AikSKKsI65sptqEHdhw/7GRjbe4qkDIBZvTyGs8ply2E
         bF8MSelt+Gl0NnTin/8OJ6UyD9dj+YT4xtU7HLv3K5BlQ0hLjKahChNNnD1GijJHcV5R
         MqRj9c0Kh+ziyH4yVEYcdMlvs8mCpzI4b7I5N6LXkjejgK832bgryA5+U94vrXIRkRXi
         22Nudnj/MKcjQblLQSVRmTepUs8RTeP8nFpjbYUVISHyH4EcVdl5IX4rNSGj16Z0kjMv
         A3Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784921385; x=1785526185;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NND2ZAWSGBlGRys7jRUsdKZimRZ4EvPaiV+gin1wtns=;
        b=YBu3ExQL6i7a8GVvnUu/CcEQQutpbUiXiUoyIt1RUJQicrYBzXzWDnjw15fAqeoQZ0
         6aJzymFRwr3TDa7dwgDaHzLT7pirPGo2XoqUqI/ty/rlJmIWGLsT6uUHk5RHYzrGrwOB
         Vv5dTXEbfOJwt4G7Mcg5o7y2A+ppG2Obe06r++TAVpjMNHNtBtc+RrmUYkJ0oVnBXn3r
         a7xPy5luNxR76T7dBvqG8rlGfM+BSErkDZOFmGPcOlZduumPt9C6ysD3Yl8HuNPg2XNv
         56tbEJfaSAqqlFNc/NfpSwDqGYJw/angzJ29+O5pwBljC5DLfuKu1GgkVvitNVryu3Gl
         85jw==
X-Gm-Message-State: AOJu0Yzlv2Em9v609Fhh5naMks+c+X13E2qsYk1NMowyU484Fbny6SHm
	G2Q/URPo5d7z7uX+WOd09bYfuBNxVJMEZD+3gHFnWfLfZe5ig+iz1hT0zSvCRDuU
X-Gm-Gg: AR+sD11PSMBS+zYM80Xhxt4QO02O7/+JHVPuPCfQGIrtgddBp7ZZx//3Jw69esMIMZJ
	fm/Q7iKInxfEAGrrbyJ7rmhl3dKR/uZ9oPQyM7bBBHAGbgtovRhPEpYSJtPp45SxACpR1FEhpGl
	wfj/bbcFas5T3LGfALuB6YGudIKt1JsOTmj1gwDjSg1gAYxJ6NhjrU2I9mkogFwexAmIlhR1nxN
	+AKyTpenjfOHWEqbsmAQXOlZr4SLzBrcdpOtTM0mSjj77kC05iU5CxE/BNOhHi/DYiXpnUrghex
	5Hmc6NpWnMqddvIZCTBUqtOwaFspLi6FgtbhWPgTSGPmEMQBlRC/FFkIJCsJrsWnKaMiJp9Z681
	nTreEV0lIQEQUUY1C93pd+h/nPiwEp5I+yXzALNgLanoUykmcwQt0saueLeBU57rMDKjG54TUJV
	qg4Z8lcA==
X-Received: by 2002:a17:90b:2551:b0:38e:4f31:8412 with SMTP id 98e67ed59e1d1-38f1eea7240mr1633374a91.11.1784921384957;
        Fri, 24 Jul 2026 12:29:44 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.211.27])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130158c0sm28567683c88.6.2026.07.24.12.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:29:44 -0700 (PDT)
Message-Id: <6f27770b9f12562bf3412d1d5748ccbad06fa9a6.1784921375.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
References: <pull.2285.v21.git.git.1784889377.gitgitgadget@gmail.com>
	<pull.2285.v22.git.git.1784921375.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jul 2026 19:29:34 +0000
Subject: [PATCH v22 6/7] branch: add branch.<name>.deleteMerged opt-out
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Sixt <j6t@kdbg.org>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Setting branch.<name>.deleteMerged=false exempts that branch from
"git branch --delete-merged", which is useful for a topic you want
to keep developing after an early round of it has been merged
upstream. Unless --quiet is given, each skip is reported so the
user knows why their topic was kept.

Explicit deletion with "git branch -d" still uses the normal merge
check and ignores this setting.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/config/branch.adoc |  7 +++++++
 Documentation/git-branch.adoc    |  5 +++--
 builtin/branch.c                 | 14 +++++++++++++
 t/t3200-branch.sh                | 36 ++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
index a4db9fa5c8..d8483acb4f 100644
--- a/Documentation/config/branch.adoc
+++ b/Documentation/config/branch.adoc
@@ -102,3 +102,10 @@ for details).
 	`git branch --edit-description`. Branch description is
 	automatically added to the `format-patch` cover letter or
 	`request-pull` summary.
+
+`branch.<name>.deleteMerged`::
+	If set to `false`, branch _<name>_ is exempt from
+	`git branch --delete-merged`.  Useful for a topic branch you
+	intend to develop further after an initial round has been
+	merged upstream.  Defaults to true.  Explicit deletion via
+	`git branch -d` is unaffected.
diff --git a/Documentation/git-branch.adoc b/Documentation/git-branch.adoc
index 2a96cd7253..2b206e8689 100644
--- a/Documentation/git-branch.adoc
+++ b/Documentation/git-branch.adoc
@@ -216,11 +216,12 @@ A branch is not deleted when:
 +
 --
 * its configured upstream ref no longer exists,
-* it is checked out in any worktree, or
+* it is checked out in any worktree,
 * pushing it by name to the remote configured by
   `branch.<name>.remote` would update its upstream, so it cannot be
   distinguished from a branch that just looks "fully merged" right
-  after a pull.
+  after a pull, or
+* `branch.<name>.deleteMerged` is set to `false`.
 --
 +
 A branch whose work has not yet been merged into its upstream is
diff --git a/builtin/branch.c b/builtin/branch.c
index 78b694034f..dc1d74077b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -786,6 +786,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 	struct ref_array candidates = { 0 };
 	struct strset deletable_branch_names = STRSET_INIT;
 	struct strvec branches_to_delete = STRVEC_INIT;
+	struct strbuf key = STRBUF_INIT;
 	struct hashmap_iter iter;
 	struct strmap_entry *entry;
 	int ret = 0;
@@ -804,6 +805,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 		const char *branch_name;
 		struct branch *branch;
 		const char *upstream_refname;
+		int opt_out;
 
 		if (!skip_prefix(branch_refname, "refs/heads/", &branch_name))
 			BUG("filter returned non-branch ref '%s'", branch_refname);
@@ -821,6 +823,17 @@ static int delete_merged_branches(const struct strvec *upstreams,
 					FILTER_REFS_BRANCHES, DELETE_BRANCH_SKIP_UNMERGED))
 			continue;
 
+		strbuf_reset(&key);
+		strbuf_addf(&key, "branch.%s.deletemerged", branch_name);
+		if (!repo_config_get_bool(the_repository, key.buf, &opt_out) &&
+		    !opt_out) {
+			if (!(flags & DELETE_BRANCH_QUIET))
+				fprintf(stderr,
+					_("Skipping '%s' (branch.%s.deleteMerged is false)\n"),
+					branch_name, branch_name);
+			continue;
+		}
+
 		strset_add(&deletable_branch_names, branch_name);
 	}
 
@@ -836,6 +849,7 @@ static int delete_merged_branches(const struct strvec *upstreams,
 				      DELETE_BRANCH_NO_HEAD_FALLBACK |
 				      flags);
 
+	strbuf_release(&key);
 	strvec_clear(&branches_to_delete);
 	strset_clear(&deletable_branch_names);
 	ref_array_clear(&candidates);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 268203089b..7111306150 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -2076,4 +2076,40 @@ test_expect_success '--delete-merged requires a value' '
 	test_must_fail git -C forked branch --delete-merged 2>err &&
 	test_grep "requires a value" err
 '
+
+test_expect_success '--delete-merged honours branch.<name>.deleteMerged=false' '
+	setup_repo_for_delete_merged &&
+	create_merged_branch deleted &&
+	create_merged_branch kept &&
+	(
+		cd repo &&
+		git config branch.kept.deleteMerged false &&
+		git checkout --detach &&
+
+		git branch --delete-merged origin/next 2>err &&
+
+		test_grep "Skipping .kept." err &&
+		check_branches <<-\EOF
+		kept
+		main
+		EOF
+	)
+'
+
+test_expect_success "branch -d still deletes a deleteMerged=false branch" '
+	setup_repo_for_delete_merged &&
+	create_merged_branch kept &&
+	(
+		cd repo &&
+		git config branch.kept.deleteMerged false &&
+		git checkout --detach &&
+
+		git branch -d kept &&
+
+		check_branches <<-\EOF
+		main
+		EOF
+	)
+'
+
 test_done
-- 
gitgitgadget

