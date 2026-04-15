Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B0366814
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 11:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776251523; cv=none; b=PoUWr8A8uh0nS5R7aiFp7Nf8cUkUbsX7gLwcvEb4gYsScuOQZbYuBgxvwv/kkfZ3ptQjzdSLMDXeRtxe0i6pHIJUm4pTMnFsbhR9mqTjDp4kQlT8hFM9fDM8zbg6fAV+8ZA2+JFibR9O21HpalMvDtmFH4RXHC47y7pB4mO/G3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776251523; c=relaxed/simple;
	bh=s0DS4Yrqns8wS+smvqmyw2docjYITea4QzC9sx3N+ow=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=cYxhPVDgnptj9uWEtpbQeLw2pRr8zF/40zElqriLlJJqWnR6xRyOzxoE5Kry5ayQEiq8+r3pwa9ulaEZmEhz/lsyv0wJ1ib+Ege5aQL4PNPQZJBQGWK0AK3RTln2z96WSHYEgQQo81xiGDo9JTL5bgQrq7Gj30pm5LeLSLLXSKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn2+Dm1e; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn2+Dm1e"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8cbc593a67aso603483085a.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2026 04:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776251520; x=1776856320; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcqkMUSWl92nQ//kuqaB+zele+46c8jSegf/0HDrdQU=;
        b=Bn2+Dm1eU8ic/X6iegCd/UvIs8xDiX6hj84PAKUAQbJ4lLe2UmXHhx+o6ayAzVolRT
         sDYv1GRwM5+4hSHS1cUvmJCgjzUXdoKO5KVlCdAM5gEECu662W2Rn/KRNCJJeYj3OMOe
         61PHzzZLVIkDMX2uMZXIFpjNPM+S5DST/x1BV2LDeB3PA9LVTG7fO/vlvITYyjWE1foq
         d+XgPxVIiQV5iK4SyYLAR2HDTQc1iuni07A7kWXOGKKiOirLsQ2H1I3L2liwOlYZpoYw
         ZAN3qn1ue5ooWcr2gczGJDxIm1rdQw1HWXp8czxzlA8aCMPH2sLwHFTkzjtofIKvqT+5
         pNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776251520; x=1776856320;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wcqkMUSWl92nQ//kuqaB+zele+46c8jSegf/0HDrdQU=;
        b=MJk2elE21h8rEWXi9aljtuiRnhlk266zYilaZ7anHsdM9TpXfuBsYIdGHuoWxNonKM
         PklsCeEczKVKDOGuNNdbwSaTf5s+/riRgu/XydyXanHMfU6Txqs8JAXQhs+8kVYzG9xB
         l+k5b0UXH5CB/M3zwF9/mOuwqmZZq2kNo/nFBJ3zFDMqxLKKqJhAL39WOLHNDA6XQmrT
         3NfldJMusj8DZzvsioHZMPTMLzAuVQkGnt5ePNGwx5lGwKHwOsZCzX1LTc9cb8zL6A6I
         9xBnpaIfM2O206EsoaLVUmcvDHslnLjKL/XKn/IQVP8uyXpV4O7CuDXbxhmGsCZVlhX3
         XMTg==
X-Gm-Message-State: AOJu0YyzorTELzDnMwn5do77g2mYJd/c546Bq6m5w/qH1UE7A6+7oi9q
	w6gLScv0KXNPC9GBHuDvQMNzEoZ26xH7C0Gnp1KUeEqG+0S/Fwe1oNTRFfH8Sg==
X-Gm-Gg: AeBDieuuz6UvdX7dbds5wDTPl76rKgswuIrlHieb69GG/rYSVoNGeI3lEo3xmBiziB0
	64PaL1CqmYRn6OLxhQ/EnBtxI/yIoeW1S4cGtRpeCMPNpbZA/03Vlz2wiuVY8zcJ10aJb0QomS7
	50TVYOt1vRXAeXf6u80FnrYe4GbXPupE10izP5qhqtyXtjjqnsdObsyLtUhjaqy+u4ppE7TgXnG
	/62C5Hjkzm//2+Bdw3sdrV6ErB+Z95ok4FEFCojPkeusnkTvAt3Ai/bxJotoTIBezBMSvSD/jZa
	O0q7m4NJWtfS2GkCed+iVgxdHhfOBmpyXC/Py9hW/r6jUl1DCVhFtsTUVSm1ljDt2NxSyXMcFrE
	wtkQXTG3j6jFFIJBKyb8LIRLMuiMWF8w6vi60tzs56nnFj0y2v1eFuDvkOxyNm/xWg2GHxXMbZM
	9XpOK/4oxmqo3sOuHumGys4ifOcBpgrXlf0ZXdhd8=
X-Received: by 2002:a05:620a:4805:b0:8d7:d559:3d53 with SMTP id af79cd13be357-8ddd059e07cmr2986094285a.66.1776251520163;
        Wed, 15 Apr 2026 04:12:00 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.227.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e4f31f95f9sm102214385a.43.2026.04.15.04.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 04:11:59 -0700 (PDT)
Message-Id: <43bfdf2136f648235773cd3917b6a9de968531bd.1776251517.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
References: <pull.2234.v12.git.git.1776171585.gitgitgadget@gmail.com>
	<pull.2234.v13.git.git.1776251517.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Apr 2026 11:11:53 +0000
Subject: [PATCH v13 1/5] stash: add --label-ours, --label-theirs, --label-base
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
 t/t3903-stash.sh             | 25 +++++++++++++++++++++++++
 xdiff/xmerge.c               |  6 +++---
 4 files changed, 58 insertions(+), 12 deletions(-)

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
index 70879941c2..340854bc0a 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1666,6 +1666,31 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
 	)
 '
 
+test_expect_success 'apply with custom conflict labels' '
+	test_when_finished "git reset --hard && git stash drop" &&
+	git reset --hard &&
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
+	test_when_finished "git reset --hard && git stash drop" &&
+	git reset --hard &&
+	test_commit empty-label-base conflict-file base-content &&
+	echo stashed >conflict-file &&
+	git stash push -m "stashed" &&
+	test_commit empty-label-upstream conflict-file upstream-content &&
+	test_must_fail git stash apply --label-ours= --label-theirs= &&
+	test_grep "^<<<<<<<$" conflict-file &&
+	test_grep "^>>>>>>>$" conflict-file
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

