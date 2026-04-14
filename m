Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C29383C92
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776163827; cv=none; b=BbTG86wIyQlXI+ebGagiJbBglX0h55aWsiFsqg6gxfP9dArUQF5/eHjvYBgOzkEp27aHerRg1pBaAp/OmgGR3vONlS0ZYs5sr4rK6N2mehXmcuRvl0ANBi8jRksoZI/6ilKUG0uNNgb+YD+qSAYejIFELXHc2Afl+6a3rViphBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776163827; c=relaxed/simple;
	bh=BhbBMlHe2weVPQhjLVck9zpJsbjGkl2KYvB1ip6Kxb0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D9ZYeewSV5UM0n8EsGQclup9FxFBs/eh6n4brB9tMmcfkvps1c1xMsftFtRjPaurJmayGEFG/oMioTErlb9xvCwsZd/WOp/4fa+dB/d8OME3jGr2CubQ9LsuqNFITE97NWydJCnahi1dSYhg6PsYEOCXGxzt9KnWqnwVhiWXBmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ji1YJM8Y; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji1YJM8Y"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2d17b8fbedaso2185947eec.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 03:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776163823; x=1776768623; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ij+z/COhdj/tGRH/945uWYZ7SWfYyfPgzOr9ewVDN6Q=;
        b=Ji1YJM8Y+eztxMbvz2Oww2V/8vzp9ZR6WORcXA0OKJLSV1MI5H04QTh1xbY5RV11u5
         wd8HK1Y3swGK8vGE9tZSm+jKcll8InW0dFpobTwJcaLXT3q5LVQA1n2Hd3JnhN1OpXKf
         gHtCYzu2GzIntJN/8rRxlDOUuI4FLjX93cjjcJuLys1OC4rqHve/6fm0FGEpwFHK/2J3
         n+sRJgKci8XJctnXTw1Buhmry9SEUt7yFGcCFl8Fab5TsAmGll1nJ0TbH5DJhEoEVyHo
         vjClL4A+/kqEC+SAJeyLCF+Zq3JUhXwz9lVF9/3VFny6iOTBrVFldkF7WFLbZSvv7fsu
         3qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776163823; x=1776768623;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ij+z/COhdj/tGRH/945uWYZ7SWfYyfPgzOr9ewVDN6Q=;
        b=syCd0bUgLyMuljhUvi5OVe4kPOBvzfokROxk7Nl/1VoNtR6U/P1FC4cuDgs2PajDA5
         4RCmFVMIu40MQRJ8jt1u0WrI65IBc33ttCMtjH4VzSgAc2CNHZhxDETIwCWFzzF09TBN
         OfW8PK4ZyHhZYovMOjnNWvM4TU3RHkBWEP13OiSU6wzEHimxV6d3kHrbq8qFzog5HBfp
         t9jlg/W1pmbudwt09D1OjiQVeL8/eHY1c9kN7Td1mDoCPX6eIO4kyTXb3dLhczY46JoG
         tve9M48DaSlRD51CBENxpdh4vAGgTAstAyDIK3mUeALStTH/gnVow7uB5ZGbqO7VEkKt
         YFyQ==
X-Gm-Message-State: AOJu0Yw3Myz/PsD59YRFI2TkLkbxyMHefjZsc7WpTzlZ+pGQLoZm+K9t
	sEUxS+j8QKYfUkXHbxHd5Ir8rnPBhNMZlJ73XH5W8+HUzek1TKwp0XevvRAyqw==
X-Gm-Gg: AeBDieto8lZSctuQAt7l5C2IpPQ8fXA5A0CVabRWecYq3zJeEwArRCSBR1PtWPcM6G9
	+ibtGFIogltmCAyrYcvR2pClqSvCtPiEAQ19ID3dOnUhIagNGuKHotu6bJTbqmeHwD7bX1nXzgN
	/zFj9gktHVtwdkPDzxXOGR2bD17QUbuOSFCjizSbnSm8ZIV+v8ZwVswOYGJEFjpFXeyH0pE4UE/
	P8TG2ukzZYvk1gbEKMkaF9Ez/xsJj8+3q1bERSEx+oL3uNGft6Oh5q9DZ2bCpCksEEBkh3ttxHM
	Te6dLQxGTpGJIrxTxwBnL3VvpG5hi7W2vtpNtiMr/0YXe8WFibc9L0n5L+sgL0s4eqbIn6+3U4e
	al7YNWCLVpdjXk+UWnBz1hcCGJdw3aQkSiD7VBKqHEG0URsT803FX5ODP6btX12CNamK9beX7tw
	MsjMZHh2QdDTuROOBuqD4UgrSwgarE
X-Received: by 2002:a05:7301:6788:b0:2c0:beb1:8507 with SMTP id 5a478bee46e88-2d40aadb93bmr9478480eec.0.1776163823081;
        Tue, 14 Apr 2026 03:50:23 -0700 (PDT)
Received: from [127.0.0.1] ([172.184.219.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d55f5c69d5sm24071790eec.3.2026.04.14.03.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:50:22 -0700 (PDT)
Message-Id: <9ab5431b4773c29097ae9bdd497822477c7ba56a.1776163819.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
References: <pull.2234.v10.git.git.1775994705.gitgitgadget@gmail.com>
	<pull.2234.v11.git.git.1776163819.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 14 Apr 2026 10:50:16 +0000
Subject: [PATCH v11 1/4] stash: add --label-ours, --label-theirs, --label-base
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

