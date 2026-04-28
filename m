Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8327E049
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777401559; cv=none; b=KTdw9CaGNReXmhs6qfm1mRQhpQvFhZkGb5+08WU9HMPWe9n2ziAAqybnLFKGAELGL10SujL6I1+uV66UvqrM291ob+PS1bvkRAwlMOW6lAwqrAwTsPyO7WrNi885cQQP1NupHCClv+GibVz0iKv6XL3nj70s6F2Jj3sVCkPp/wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777401559; c=relaxed/simple;
	bh=8jwbAcWn/ZuTHaAEw5sPvcFfvJdAL7FSIF9Dn7V9XiA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YWj0AgAuAXvIt2Tmgkak3mcBnvguvxxFPSQJjx0XtOspP8RskUnplblzdv96wtCWnRIQSGdhtR4lE+0K6UYO8kUdlTkPZG2hMOVgLQZn4/qsHVNEXLQmmy7dqgbucOaEK2U3mtWzkaZhJ4i/1AlHxue9/rs+clcAMNvJYKxl+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWq6Y4Th; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWq6Y4Th"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2d96243c91fso19192307eec.1
        for <git@vger.kernel.org>; Tue, 28 Apr 2026 11:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777401557; x=1778006357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cserJiDL2TKP3uD8UcTk06b617gCx4AP+vLcsse1QpQ=;
        b=YWq6Y4ThWeZHxt3XFwl9vUGER9iKManz5l2TBoXDbsspHji0OXpF9EKtuN/tL1OxKR
         Bx/GJZWp6dJHrUu8otzLtsbW2xmzDAeJNfqgsFD2q8vsrlLify4G32ohCLGdVTFjwN1b
         fSEOriJ76fbhOv61rGgqQ9mIABUS/PzXsiIcIvlq64WwCiGJqebLF5L4U3QQ3SftBEr/
         6njBTGDymxeYzJvfFWhjlROx6KRKlSPhCJ9qls7zTsl6/ieg6HECuWLyn58OfRiufdRJ
         lxjiPQ25BnE6ZPdBmJN7AOwdLkvPEUj8skPH1Xn64zhQ49ShrANEIsPe1h6jwUrNXa46
         x9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777401557; x=1778006357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cserJiDL2TKP3uD8UcTk06b617gCx4AP+vLcsse1QpQ=;
        b=n7ScAzUqCsb9Y4wQ9uYNjok+fOHv8wpGhtvjQUGWuIa0E8Q4GiesaUlnCn6rkIgaxv
         vGZZNp5m2HY8vdRw+5DW86nSW9GsdM+qIF/3728vNdrDcRQEQbYuMOeyuJqvYLK0ISGv
         q16vt3iA5XMgjOVIT9gpBAzCfWE0FPB1XVfV/LdIlDY0sOK/Qmvuzq7uSJBzlPQ80TSb
         PWVozfR409AjqB/MHkAS/jJLIbj6BzdlcSK2y/SyTdEnETPhW6rr38HIPCyg9u0IHFz8
         2vmiKoBipKHfyCCWP7RSV6tzZnehKMhnD90gSYLbi4axwbP21/U9GvTCyOFf5ZMwcbG+
         FW7g==
X-Gm-Message-State: AOJu0Yy3tyzM9GMXyPelNeyi1svPS+xfQhaGapQjpABifaHzag40EbN1
	YZ/us7SJAI4COHPsupbnRneQ/V91YmWvEoGLVixgpzKR+b0hX2SLt/YPBQuQ+g==
X-Gm-Gg: AeBDievPU+6rAITCLk6FRTAfQp3PcNpy9lk1fUAdPWv2bppYTcquFAoUGiK4vmQqrDb
	+SXm3PwKMynn2FhwpEYoHPcjuVrnd3zl6/rKuV9r08d0TtWzIKLRYXGAAFyFY91GPV/en9XihZO
	2CQMVIHyDJAwrUuCKbUKJYSLyuMzu1yDP/jxiuncVzYEskyia6ITw8flY2vz3jFjfFAdBjuPYSu
	GAq4eY2pxn0IX3cIK9wh5CHK2Vv34sKGxbAb421gvGotryvHJ9+WBSgOrN3srqiYS3jqC6FnkmD
	oVFFsPbFs1MW0Rky+EGjoHmk3VpaltKTG5cnlumrMAA9VFMwRdJHJdaq6Ewb28V8+HJROPu6atS
	VQsqIA0WF2P+JND6K7yIjjpImbFK1Tu5UQxqTJnbjTyFfUYMsm/YRYX4fvFTQ6d5mBtwBmJSA+d
	n/Lr761D1MQyqZoA8VDGsSuxFGbFOhJbgSOwuD41yvwq3xeDM=
X-Received: by 2002:a05:693c:3007:b0:2be:2953:fd74 with SMTP id 5a478bee46e88-2ed0a11fd59mr2294062eec.14.1777401556739;
        Tue, 28 Apr 2026 11:39:16 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.83.199])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed0a0ce761sm2886787eec.15.2026.04.28.11.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 11:39:15 -0700 (PDT)
Message-Id: <aba8e6a9dc7e1620a46888685bb081f878cc6932.1777401552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
References: <pull.2234.v15.git.git.1777065012.gitgitgadget@gmail.com>
	<pull.2234.v16.git.git.1777401552.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 28 Apr 2026 18:39:08 +0000
Subject: [PATCH v16 1/5] stash: add --label-ours, --label-theirs, --label-base
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

