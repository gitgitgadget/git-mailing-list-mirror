Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1231E84E
	for <git@vger.kernel.org>; Fri, 24 Apr 2026 21:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777065018; cv=none; b=BBKZ+YKBQiE/WQaLM3rnXdbT018IMe9oP7UIgeevbxtyIjCW+SQH8SAjnC3qT9rB3/V5lWOFr85oKtenUkoFFe858rWa1JGBtRNLhnXdZLT/EgHwqqE9X4ZOxOj2+8X4m1/70vs4BmrshGC5vL4QhJkZC5uzEKZ1Ik5sZb7VRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777065018; c=relaxed/simple;
	bh=8jwbAcWn/ZuTHaAEw5sPvcFfvJdAL7FSIF9Dn7V9XiA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=m2mdmaSZg6gc5JHQQ/Mens7HmYgTUw4Z75LNB6M1UW78nGKn0IlNeVmBsf5/vdVbClyXT+CyX294bbmqL8pkG+oIK/qoe0D9AVPAybfXuWPF0F/cI9PnROh/2kFeLBG8w7xRqmO6Ael41VM6hRp/jFzeUhvdKOFGhL5zO3X9HPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sEc83L4b; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sEc83L4b"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-2d868d014a5so8190245eec.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2026 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777065016; x=1777669816; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cserJiDL2TKP3uD8UcTk06b617gCx4AP+vLcsse1QpQ=;
        b=sEc83L4bUSJaXPWU5uVs2YD6cZ19xwYX8tOXD3oJoCadn2LLRGqbq+rRbIw00i7sZP
         XoTDf2clm68e29JgH0pLxb9ZEN/j3/7aNLIqCDi4izxBNa79QIL3VGACuUoUrzNwENjh
         BW0QkSOoh28s+N3QlAB8DXI2JPh2SP0F1f0oLWJiy3LE4805+p4IlglvFJdixTJJeRt+
         ysMsLb18uUwJXt9HOTUFzQZW/iy1KOUrhL/aTOslpfAZG/5ABfQNK6vo8EuC2HDNlyqz
         LpTwztDWOTGte5Z51n/sH5KR1xbfK4sId/cv+RMD95EghwyEWeOHVAE4Lef1AoHa0QHQ
         54ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777065016; x=1777669816;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cserJiDL2TKP3uD8UcTk06b617gCx4AP+vLcsse1QpQ=;
        b=nJyV9Q9jb6/l6ip/0XXgtGiDjlmXgzQDjl40TPu9H0Tp/kajagUdRoFNOLJI2/K9/X
         W7jjQyJSWtVj0WEAXf2BbVzrsdRbe8oiY21srbjpJc+yK636vLvCzpLMGDJHFLxojZhW
         4kcJVc8ZRLxJHrdqea8ta4TMAEnszKAyAz+cvmNqB2FClqfMrDbUAAkTkSVyzOtK6DLe
         f82HyWFnJ7TOnVdWPnAaCqFBJNvehOV/B63vAmYO9p+CijZ55hKkQMUH6yyQuQ4Td9tX
         Be12qeK5nNMlhp3vdmCZDcee+w5JD4nVq2SuIpTlyDhCSLA7QHbEILaOo+4Ri5UYY/Mj
         YndA==
X-Gm-Message-State: AOJu0YwuwvcAVdUX/lDsQr9i0NW0+EKbw38+lNJGbL+8znX7tlNTKR79
	oM8zw94TJZnzub9QgxEBBIdeWkSgpnLH4pFAdZYGcY8BGWYDOXTjZIMXzhjiQg==
X-Gm-Gg: AeBDieuDNnDuUu/meQg4l23wsKbuJMpLqoldli5OFMWt+rUTmlLugDAI85WU/GvQ6y/
	Hjly4Nbh6JVlzP8+gYwRazAQ6UuqNeTjYwZSoVVbO1WdZANgSjIeVMI+a03V9qmWkSjWu4JmY8J
	5Bqiu0zZffAtp1NChdan7X3P/9P3jO17TyhcSZL7lLzAKbj3uJNJfRpA/5J8Tfzf0LaTzMGyQoW
	NEgKyywZK4x/dW2UySHrl6JT/OTV5SkoJx94bw2j0hbCzd9M3NS8bxOd0cVsiw+Fugu1Sn43xJs
	E+G6VF6dvUMvEvDcs6aSqwZpI32CTOmIlPZ8+a7niBXfOcCY9cyRuR67hMIEeQtrDducPaDoNeU
	v4eojkeOjcjkEMmJXF7KkkV/SUqVz4HzWJ9jwIQA4RacKOryrhonrmrbMApaMFdj/1dYKq/RysL
	ptb+ClxiG90TqTAS9KruR7gf4uKb9f260DJ5GhlIOEnJwuTHf8mg==
X-Received: by 2002:a05:693c:2b04:b0:2e2:a4ba:84ae with SMTP id 5a478bee46e88-2e479017499mr18426195eec.25.1777065015409;
        Fri, 24 Apr 2026 14:10:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.211.117])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ccce426sm34270949eec.16.2026.04.24.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 14:10:14 -0700 (PDT)
Message-Id: <aba8e6a9dc7e1620a46888685bb081f878cc6932.1777065012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
References: <pull.2234.v14.git.git.1776270259.gitgitgadget@gmail.com>
	<pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Apr 2026 21:10:08 +0000
Subject: [PATCH v15 1/5] stash: add --label-ours, --label-theirs, --label-base
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

