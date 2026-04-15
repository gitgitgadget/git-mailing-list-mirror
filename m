Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8573D6690
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 16:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776270266; cv=none; b=FxhgRroXshB08CRWMROZx9VJdYfHCI7yj5RVqsRa6JIPmsrH4wdATcoCChlTXeiGZIckhMLDVxuffmKjZyQ/BvUKChZhX8sxXs45zZoYxMu6kQVC0jR0Z5wAsK/k0BtkAzlDVXN1R5ZpLLaskJZ9vDepJflP/P2VPjUfD/GLOYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776270266; c=relaxed/simple;
	bh=8jwbAcWn/ZuTHaAEw5sPvcFfvJdAL7FSIF9Dn7V9XiA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ubjmZ3LPfMgf1eK8bDp68CtwtfivhQq/QdEPR+TcGKVKIJncZO0Zl1DK68yU041amp/fl03RVWKp53SG9fDeqkMreSFLtSTq1lyT1UmDoOYsO4NcrUq3+tzqNxr/zZrO1ybJtQRBkzBg1zn5VToyAufAzsgiTBaTRkFEjI70AQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdmpLUXh; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdmpLUXh"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbe07d3ec3so3443396a34.0
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 09:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776270262; x=1776875062; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cserJiDL2TKP3uD8UcTk06b617gCx4AP+vLcsse1QpQ=;
        b=sdmpLUXhYU2SmJA4yxhv9cJU9VXufvXiEjl06klX2Qi58dnbr8gkfhg3n8xSRhOOf4
         525rIzu2bD4qdAfxrAdckXj+ORazojNAm+eHI8AmVpoYBA7DRc5wG1Eue3PMyGYOkHXQ
         /KAHDRqCAR3D7/aMragqbbo7zMnhJMOleYIm8gl3aqWozeG5/BoCeyKX2uERpQDLVjSc
         TKEuBKoshEwIdvO8EfYCn1lL9tZuSRBrJJTrbrlNsh/kZhMumqTSf8zu59zUa3dn8lrD
         I4nrB02lp0wp8aW8Ng+tOZPELrUadu+4v4cZz838YL7VBkoXfVHJHFRAswN/zQ86GZRT
         vYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776270262; x=1776875062;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cserJiDL2TKP3uD8UcTk06b617gCx4AP+vLcsse1QpQ=;
        b=g+GhNvD2OrmmTYESrDEn0z7zYVYrSXpiaBc6vwtCNGN3G5f+KRz0arbH1q32lifc4R
         CTFz9ltnmBaf+KPE2EkvzaZ9l8jEQrdPuJcrLeLS3MbAOIUKvSpYcxK51ytRXVfogt8e
         YH63AmFSFVy/0SAcqSrBdveH6vrK8HEfhBzZqBr6a+cbOkyCL/5i/aySNJ0Ll9TJSWqy
         hFcHZVQZWk8RuCTVIJknWIdzycQ55wtXgrvc2OvjqGyltU7bLtQZo009UH03l0UB1gfg
         sUZz8vG7fKQt2l05ce0ub4a5xq3dnMB1T3sk4CGNWxLegZjl9NCJllB+KH6EfF74fLxu
         gAow==
X-Gm-Message-State: AOJu0Yx/cqrS8AT7ycpZyhDyAU3fWlg5qx8OUnpc4MXCM53CPSqzRU+R
	SRtO2faCTptTDbnOFHUF3u3kHHZeV2ZIA4KemZpWjd2hIOgsuDqMBlvxuX/thw==
X-Gm-Gg: AeBDievuOYCtgYPERJIp+pRAJHM6e0kUgz2ewRO0tNwQ19E1KFUvMffJ6lfpI9GxQTJ
	LLqwY2iulZG60MijZ6Q1ubxjQDiSvzLYG4LXVoXBU97oRNtjUyu+8sTEXajSgc5TU40XkUPrz4C
	CC2sLZx8G/Ri1jUxVHGfbagM9PPQg7iNe2pfyLU3wLRBDDwYf4zsiBJrCDbbtIA1IfMKzKoMAZX
	Ok/973yY4crEpDeGKDkqO/oePshlvXMq8Va/UsCaCly8Dv0KmHQw8lCnyuAKsQ3YNYlKz1wVDBu
	X4yu1iR8lU8tAWKoTBFgHkCzhGQCjtudU2vlnujCCVx8NziXdAbjWzBHXYpvkrHlBRs+xOfic6N
	9zR+k4kTfVc2EVkPBZtKe2qQyFF8AYi7xavyvcSuLcDZc6uLI5Z5WS5FaMV7wcOl9jRbZ+hYSCK
	ifqkWP7hzeXq59BcE02IwMoxU/
X-Received: by 2002:a05:6820:6001:b0:67e:244a:7dd5 with SMTP id 006d021491bc7-68be86dff33mr7729593eaf.51.1776270262489;
        Wed, 15 Apr 2026 09:24:22 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.21.53])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-426896a07cesm1682833fac.15.2026.04.15.09.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 09:24:21 -0700 (PDT)
Message-Id: <e18c25599add8a4efe994419b8e9101e47a24025.1776270259.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
References: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
	<pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 16:24:15 +0000
Subject: [PATCH v14 1/5] stash: add --label-ours, --label-theirs, --label-base
 for apply
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Jeff King <peff@peff.net>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

Allow callers of "git stash apply" to pass custom labels for conflict
markers instead of the default "Updated upstream" and "Stashed changes".
Document the new options and add a test.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-stash.adoc | 11 ++++++++++-
 builtin/stash.c              | 28 ++++++++++++++++++++--------
 t/t3903-stash.sh             | 24 ++++++++++++++++++++++++
 xdiff/xmerge.c               |  6 +++---
 4 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
index b05c990ecd..50bb89f483 100644
--- a/Documentation/git-stash.adoc
+++ b/Documentation/git-stash.adoc
@@ -12,7 +12,7 @@ git stash list [<log-options>]
 git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
 git stash drop [-q | --quiet] [<stash>]
 git stash pop [--index] [-q | --quiet] [<stash>]
-git stash apply [--index] [-q | --quiet] [<stash>]
+git stash apply [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]
 git stash branch <branchname> [<stash>]
 git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
 	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
@@ -195,6 +195,15 @@ the index's ones. However, this can fail, when you have conflicts
 (which are stored in the index, where you therefore can no longer
 apply the changes as they were originally).
 
+`--label-ours=<label>`::
+`--label-theirs=<label>`::
+`--label-base=<label>`::
+	These options are only valid for the `apply` command.
++
+Use the given labels in conflict markers instead of the default
+"Updated upstream", "Stashed changes", and "Stash base".
+`--label-base` only has an effect with merge.conflictStyle=diff3.
+
 `-k`::
 `--keep-index`::
 `--no-keep-index`::
diff --git a/builtin/stash.c b/builtin/stash.c
index 0d27b2fb1f..32dbc97b47 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -44,7 +44,7 @@
 #define BUILTIN_STASH_POP_USAGE \
 	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
 #define BUILTIN_STASH_APPLY_USAGE \
-	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
+	N_("git stash apply [--index] [-q | --quiet] [--label-ours=<label>] [--label-theirs=<label>] [--label-base=<label>] [<stash>]")
 #define BUILTIN_STASH_BRANCH_USAGE \
 	N_("git stash branch <branchname> [<stash>]")
 #define BUILTIN_STASH_STORE_USAGE \
@@ -591,7 +591,9 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 }
 
 static int do_apply_stash(const char *prefix, struct stash_info *info,
-			  int index, int quiet)
+			  int index, int quiet,
+			  const char *label_ours, const char *label_theirs,
+			  const char *label_base)
 {
 	int clean, ret;
 	int has_index = index;
@@ -643,9 +645,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	init_ui_merge_options(&o, the_repository);
 
-	o.branch1 = "Updated upstream";
-	o.branch2 = "Stashed changes";
-	o.ancestor = "Stash base";
+	o.branch1 = label_ours ? label_ours : "Updated upstream";
+	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
+	o.ancestor = label_base ? label_base : "Stash base";
 
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
@@ -723,11 +725,18 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 	int ret = -1;
 	int quiet = 0;
 	int index = use_index;
+	const char *label_ours = NULL, *label_theirs = NULL, *label_base = NULL;
 	struct stash_info info = STASH_INFO_INIT;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("be quiet, only report errors")),
 		OPT_BOOL(0, "index", &index,
 			 N_("attempt to recreate the index")),
+		OPT_STRING(0, "label-ours", &label_ours, N_("label"),
+			   N_("label for the upstream side in conflict markers")),
+		OPT_STRING(0, "label-theirs", &label_theirs, N_("label"),
+			   N_("label for the stashed side in conflict markers")),
+		OPT_STRING(0, "label-base", &label_base, N_("label"),
+			   N_("label for the base in diff3 conflict markers")),
 		OPT_END()
 	};
 
@@ -737,7 +746,8 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 	if (get_stash_info(&info, argc, argv))
 		goto cleanup;
 
-	ret = do_apply_stash(prefix, &info, index, quiet);
+	ret = do_apply_stash(prefix, &info, index, quiet,
+			     label_ours, label_theirs, label_base);
 cleanup:
 	free_stash_info(&info);
 	return ret;
@@ -836,7 +846,8 @@ static int pop_stash(int argc, const char **argv, const char *prefix,
 	if (get_stash_info_assert(&info, argc, argv))
 		goto cleanup;
 
-	if ((ret = do_apply_stash(prefix, &info, index, quiet)))
+	if ((ret = do_apply_stash(prefix, &info, index, quiet,
+				  NULL, NULL, NULL)))
 		printf_ln(_("The stash entry is kept in case "
 			    "you need it again."));
 	else
@@ -877,7 +888,8 @@ static int branch_stash(int argc, const char **argv, const char *prefix,
 	strvec_push(&cp.args, oid_to_hex(&info.b_commit));
 	ret = run_command(&cp);
 	if (!ret)
-		ret = do_apply_stash(prefix, &info, 1, 0);
+		ret = do_apply_stash(prefix, &info, 1, 0,
+				     NULL, NULL, NULL);
 	if (!ret && info.is_stash_ref)
 		ret = do_drop_stash(&info, 0);
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..bdaad22e1f 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -56,6 +56,7 @@ setup_stash() {
 	git add other-file &&
 	test_tick &&
 	git commit -m initial &&
+	git tag initial &&
 	echo 2 >file &&
 	git add file &&
 	echo 3 >file &&
@@ -1790,4 +1791,27 @@ test_expect_success 'stash.index=false overridden by --index' '
 	test_cmp expect file
 '
 
+test_expect_success 'apply with custom conflict labels' '
+	git reset --hard initial &&
+	test_commit label-base conflict-file base-content &&
+	echo stashed >conflict-file &&
+	git stash push -m "stashed" &&
+	test_commit label-upstream conflict-file upstream-content &&
+	test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
+	test_grep "^<<<<<<< UP" conflict-file &&
+	test_grep "^||||||| Stash base" conflict-file &&
+	test_grep "^>>>>>>> STASH" conflict-file
+'
+
+test_expect_success 'apply with empty conflict labels' '
+	git reset --hard initial &&
+	test_commit empty-label-base conflict-file base-content &&
+	echo stashed >conflict-file &&
+	git stash push -m "stashed" &&
+	test_commit empty-label-upstream conflict-file upstream-content &&
+	test_must_fail git stash apply --label-ours= --label-theirs= &&
+	test_grep "^<<<<<<<$" conflict-file &&
+	test_grep "^>>>>>>>$" conflict-file
+'
+
 test_done
diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 29dad98c49..659ad4ec97 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -199,9 +199,9 @@ static int fill_conflict_hunk(xdfenv_t *xe1, const char *name1,
 			      int size, int i, int style,
 			      xdmerge_t *m, char *dest, int marker_size)
 {
-	int marker1_size = (name1 ? strlen(name1) + 1 : 0);
-	int marker2_size = (name2 ? strlen(name2) + 1 : 0);
-	int marker3_size = (name3 ? strlen(name3) + 1 : 0);
+	int marker1_size = (name1 && *name1 ? strlen(name1) + 1 : 0);
+	int marker2_size = (name2 && *name2 ? strlen(name2) + 1 : 0);
+	int marker3_size = (name3 && *name3 ? strlen(name3) + 1 : 0);
 	int needs_cr = is_cr_needed(xe1, xe2, m);
 
 	if (marker_size <= 0)
-- 
gitgitgadget

