Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA699379991
	for <git@vger.kernel.org>; Sun, 12 Apr 2026 11:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775994711; cv=none; b=JqMg0GDEQ6aOEcat/UadOc7vaIddkI3DHaVo40pisMppQW/lPy2neNx4KxbIShstBy3v0kBiOeK4tPh0dlWRaj2EwpwrTIGqkdWuxsg3NJWW8cbA8kLwyy2fj404vPT5BHygESOgWrknuaxitGa3Eo3C7Zsswph/rcWkK+7Z/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775994711; c=relaxed/simple;
	bh=BhbBMlHe2weVPQhjLVck9zpJsbjGkl2KYvB1ip6Kxb0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ksNc1hn9L2rZzrjrkggaOeAfD5925+jzCv1Qqp/0vmmP6RZSY32wVod1Lm7gfKVhfKuRjyLgP924k6nu6Hk/El0zhrBqVCnvciPqfwJmRxYB4pX3fvf4XCpioPeMalvvvCAFOtMyKTI/H870QVs3objn8ywXIrf1kmSPlkqlLFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0smmgp1; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0smmgp1"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4211817eec.0
        for <git@vger.kernel.org>; Sun, 12 Apr 2026 04:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775994708; x=1776599508; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij+z/COhdj/tGRH/945uWYZ7SWfYyfPgzOr9ewVDN6Q=;
        b=R0smmgp1CXvR32cJM9vsg/htG2K4s966AE7gHUBrn1WYh6jH2iZiAo1czKfQQTywK0
         NhnGrpLuAng+dY074Sm1Abo98OTh0GhPjQIowuOY40aF5qt1envO1bqGIbp4ttlkSe4q
         A80h+DzD6+fsdpgMTNQvBC2ZhttO71x4MQ0/uzMbBDXmbZtU2uqXaKY1vq4HEFPgbq7d
         QGVYzEpsN6l3dfCmxI1EJoEWGlJ1rtJa3XBzqEbu2MFKQw0iFgnmF42N/UBz5RKJZyW0
         VTIhPg3oUYmzsUgYmUUMJ1k09khy+jikBvjTjQ+zColbdQdTE93JkUeihwybUk2ic/ZI
         HgrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775994708; x=1776599508;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ij+z/COhdj/tGRH/945uWYZ7SWfYyfPgzOr9ewVDN6Q=;
        b=AL6gwKsVhiKkTDZ1Yj7ttrx58j0XHSi1JU0tVQCbTR6ccuThJwtoQBHo8zhkdEB+YD
         APdwlkQonlBLU5TBMxLvBPO4fJ79z8kjDb8lB795wev0Ga8ssmS95tlOusPgF6tc6ivE
         TbuLy7dZbjjifEEzIRGjBmMmJPU4PsOhml4aeXbtrM5t48HrCaNPHlrj5mUGCbZLY3d1
         p3mIIQvxR27xmgeiPd1U2X0RDmQwVZXY0Q58lyic/ixZ/Gl7yUParArz8WcWEK2XUhr2
         PEagiLHsJZilphqajeElsbWoIu0YzZVgk8Blg/9jA504w6rcq8yxdJKRJft2buXBxJrO
         YClg==
X-Gm-Message-State: AOJu0YwYticqyJ/0xaGIToLxpuMMt+UFH6H47732VUGpewBufPBhFcaK
	GtgdwqZjHDGPorwpcv/R+HeyIF01Ten4XI5nvpz8X4Y0xUmecXqZhJbFqpkvgA==
X-Gm-Gg: AeBDietGcvVtJkICfAepfEHT/alo750NoVX8sL07akvE7nPRgesw2h3l45Q3b2U4rz5
	UeWFZc6TvWWEErGoZxTev9spjS6TtJIHwjJ6aaI0uHOaek7qQvwygDxPQcHGlJkP36KnvekeHXz
	gjAAUQRHoBhFLM4wCAjL5LIBey/r6xJcYuGQlc8seziQhl94pzD7J48svJ3SkzfK4yju9+ZotTi
	jo79urk5b/5pclhOpsf12fUx7e6+22K9qQJ2Tb2MOzLbmGnWY+cUsDkSWXgGhdDJtfItiZHZm75
	Kx7XdokFs5LsfxHOE8OJ9n1YJEvyOCuH3ZuMR1dUaBv761Bf8fqOKwt6oBeL/LRPTDoGtnF9TFc
	wHdAgopvs3CqpEgiG4rPTAU1H4IfWg85BrPJ48umWW6ohlZ05SwzUsm9S5VX4+wsFfNOaWjx0OL
	C2Qis4LycNTamgTDNfsAK9TA3/spLw
X-Received: by 2002:a05:7300:e82b:b0:2d2:d7b7:5c61 with SMTP id 5a478bee46e88-2d5881a91femr5602237eec.14.1775994708253;
        Sun, 12 Apr 2026 04:51:48 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.226.129])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55ce46a65sm12490051eec.0.2026.04.12.04.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 04:51:47 -0700 (PDT)
Message-Id: <aa519c50be74b36a188f761d82e11e3ebf84adf9.1775994705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
References: <pull.2234.v9.git.git.1775854874.gitgitgadget@gmail.com>
	<pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 12 Apr 2026 11:51:42 +0000
Subject: [PATCH v10 1/4] stash: add --label-ours, --label-theirs, --label-base
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
 builtin/stash.c              | 32 +++++++++++++++++++++++++-------
 t/t3903-stash.sh             | 29 +++++++++++++++++++++++++++++
 xdiff/xmerge.c               |  6 +++---
 4 files changed, 67 insertions(+), 11 deletions(-)

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
index 0d27b2fb1f..00314e2b13 100644
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
@@ -590,8 +590,11 @@ static void unstage_changes_unless_new(struct object_id *orig_tree)
 		die(_("could not write index"));
 }
 
-static int do_apply_stash(const char *prefix, struct stash_info *info,
-			  int index, int quiet)
+static int do_apply_stash_with_labels(const char *prefix,
+				      struct stash_info *info,
+				      int index, int quiet,
+				      const char *label_ours, const char *label_theirs,
+				      const char *label_base)
 {
 	int clean, ret;
 	int has_index = index;
@@ -643,9 +646,9 @@ static int do_apply_stash(const char *prefix, struct stash_info *info,
 
 	init_ui_merge_options(&o, the_repository);
 
-	o.branch1 = "Updated upstream";
-	o.branch2 = "Stashed changes";
-	o.ancestor = "Stash base";
+	o.branch1 = label_ours ? label_ours : "Updated upstream";
+	o.branch2 = label_theirs ? label_theirs : "Stashed changes";
+	o.ancestor = label_base ? label_base : "Stash base";
 
 	if (oideq(&info->b_tree, &c_tree))
 		o.branch1 = "Version stash was based on";
@@ -717,17 +720,31 @@ restore_untracked:
 	return ret;
 }
 
+static int do_apply_stash(const char *prefix, struct stash_info *info,
+			  int index, int quiet)
+{
+	return do_apply_stash_with_labels(prefix, info, index, quiet,
+					  NULL, NULL, NULL);
+}
+
 static int apply_stash(int argc, const char **argv, const char *prefix,
 		       struct repository *repo UNUSED)
 {
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
 
@@ -737,7 +754,8 @@ static int apply_stash(int argc, const char **argv, const char *prefix,
 	if (get_stash_info(&info, argc, argv))
 		goto cleanup;
 
-	ret = do_apply_stash(prefix, &info, index, quiet);
+	ret = do_apply_stash_with_labels(prefix, &info, index, quiet,
+					 label_ours, label_theirs, label_base);
 cleanup:
 	free_stash_info(&info);
 	return ret;
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 70879941c2..00bcb1f802 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1666,6 +1666,35 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
 	)
 '
 
+test_expect_success 'apply with custom conflict labels' '
+	git init conflict_labels &&
+	(
+		cd conflict_labels &&
+		test_commit base file &&
+		echo stashed >file &&
+		git stash push -m "stashed" &&
+		test_commit upstream file &&
+		test_must_fail git -c merge.conflictStyle=diff3 stash apply --label-ours=UP --label-theirs=STASH &&
+		test_grep "^<<<<<<< UP" file &&
+		test_grep "^||||||| Stash base" file &&
+		test_grep "^>>>>>>> STASH" file
+	)
+'
+
+test_expect_success 'apply with empty conflict labels' '
+	git init empty_labels &&
+	(
+		cd empty_labels &&
+		test_commit base file &&
+		echo stashed >file &&
+		git stash push -m "stashed" &&
+		test_commit upstream file &&
+		test_must_fail git stash apply --label-ours= --label-theirs= &&
+		test_grep "^<<<<<<<$" file &&
+		test_grep "^>>>>>>>$" file
+	)
+'
+
 test_expect_success 'stash create reports a locked index' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
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

