Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537D22C356
	for <git@vger.kernel.org>; Fri, 16 May 2025 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747425867; cv=none; b=WyI5hILHeaJSXUkDLiuXNXnAcUvcfBAF4u3MuGB+gcf2Xt7htJ97f/8LQ6DyvTFk6juvea520BZecHAaukTBM3L95HA/wXM7MajTkg/ZWsLKRjsfB88S2QnppxoMdtygWE/MQZdlZNrTIEUQUz/lXfL1lYgbqH/tOtE9MbvyWvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747425867; c=relaxed/simple;
	bh=m1tqQnkW+ZNN+C3aO+BMt9Lhi1qy34xkzM0bjdeQwSo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NqPz7sFbf00Q0NOI5CPudzKIUzInKc8UPLdVFZVsyXjMPjBJiYno1ocFdk75FskU2kZ7ik03hgy1ifDeBhy5NzBkfwH8rwg8H+58TXWCGSAug7i3AKpkY/ihUzKjCbpMBYmMNW1kWmlyk672iegWWB1dqEuD5piirKhIcvgzJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJe/PBcg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJe/PBcg"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cf848528aso20340435e9.2
        for <git@vger.kernel.org>; Fri, 16 May 2025 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747425863; x=1748030663; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSppn+kbedhNwd8Uch9ncp9NG0M7AvhqbYcTfHJ+k88=;
        b=GJe/PBcgxCCTNIKMKf2sXQj0av0Ks/J6ZY1LGRdy6E+9wJnPdZAp89O/2WCMnEF7UF
         lg0iTbmsQS3FWQ9BvemWYvIkdq66tyIYxINZfHM+n1aKnTBL6FlAUAsfS3XXLydVZIvk
         aBHd9pwFXAUmOEmzTHkTMO91MsGiSDYz4WxIMgcDVaWuosuYgYvkN+VYVX+VY4F1vdEY
         0WRzMGwWxSeT9bWie4TmkhfFWec6bvJBzsGwkXEgNZ782YXwRBv7DOU8Bsc/c0WLrbgU
         g5UkAdRDU3TwglC+Fy1ILUNRIOa8lioEC4ZbDJlTTr9V6ru+EugkfQ8TR81i8p7cscQf
         ASoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747425863; x=1748030663;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSppn+kbedhNwd8Uch9ncp9NG0M7AvhqbYcTfHJ+k88=;
        b=F9fviViGsEEQNJJzeglndPedvmAiauK3gF3/lDiNikpTJXP4p8qaGckAQbbcAjDCn2
         JyUOebzfivUDUMyKdZ27D/i2LSklQDLeM8+0wq2KpmY6eHu8dXYK2n4Z8g9ymwC4+4z+
         9RldgR8e11VW9DBcuS4GoWiQW562/eiTuoXn2uq+xx2zeeevzNMRioqIVO9J9FtcObXk
         G6QzHEA/1a8XGD6bDI6WF+0SU9V7MfAG2Z0p1Cf21BDtfqe7RS+LsjgrX8DfpGE3COSF
         4jhbAXnJ9w++I8CdU9Axhb3Q8pr+qVrvz0D6w713CnnXM5aibBAl1R/ufU9UWyi0PWEY
         +58w==
X-Gm-Message-State: AOJu0YxpmqrjwVv+0HTyqT7DsM2cxizEWxJJBG7TcfhgJ12iRyfSc7PU
	FUB03AQfmxRtbMAZ3/xsewWNpbCnLyZEnjer8t151bIUG7WjzmjTYs7lnthwug==
X-Gm-Gg: ASbGnct/LpBklbUeOq7iMVXKkcw02YJn+AsuwyZyEn5WkKpkx4DahJaFh0cQxsNjnJI
	dqxpbE7f1OQh1QJ2X+d1bJ3UKIPbvVb0wyHTCNg3n4F2/EVMWasqtmz60hA1gFOIsMy/nlQB3dn
	fTiBJbD1RMfFkRlWi8tRKGaaYmHMpS+S41eqOw9wMOgydotgtcE6II2w36W/tcSyD80QHDXQNlm
	uOgX5hyO9bPvZvVN4KKKSRqoTSD7f9Bok2sQGXCfB8bAw9EcUPATSedrWFbpGgbx68k0RlgSrM/
	RoXa6kPq6M1LOrxcUNuoZ4o2m2lRdAcUN7Ep9UBZi2akgu9JoEuWn81DeXvZv5s=
X-Google-Smtp-Source: AGHT+IEbbwHUV2j9y65xjUZVBocB8DINEbzijISYAhgo60Wdj3Vm6YG1emR7ShJ+cEjj9xb1yOioyA==
X-Received: by 2002:a05:600c:524d:b0:43d:49eb:9675 with SMTP id 5b1f17b1804b1-442fd6607dfmr39629525e9.22.1747425862568;
        Fri, 16 May 2025 13:04:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca4d2ddsm3799142f8f.7.2025.05.16.13.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 13:04:21 -0700 (PDT)
Message-Id: <7c40d3c921610576dc7947bc4c517055717dd94e.1747425858.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
References: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
	<pull.1920.v4.git.1747425858.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 20:04:18 +0000
Subject: [PATCH v4 2/2] merge-tree: add a new --quiet flag
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
Cc: Elijah Newren <newren@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Git Forges may be interested in whether two branches can be merged while
not being interested in what the resulting merge tree is nor which files
conflicted.  For such cases, add a new --quiet flag which
will make use of the new mergeability_only flag added to merge-ort in
the previous commit.  This option allows the merge machinery to, in the
outer layer of the merge:
    * exit early when a conflict is detected
    * avoid writing (most) merged blobs/trees to the object store

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.adoc |  6 +++++
 builtin/merge-tree.c              | 18 +++++++++++++++
 t/t4301-merge-tree-write-tree.sh  | 38 +++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merge-tree.adoc
index cf0578f9b5e8..f824eea61f1e 100644
--- a/Documentation/git-merge-tree.adoc
+++ b/Documentation/git-merge-tree.adoc
@@ -65,6 +65,12 @@ OPTIONS
 	default is to include these messages if there are merge
 	conflicts, and to omit them otherwise.
 
+--quiet::
+	Disable all output from the program.  Useful when you are only
+	interested in the exit status.  Allows merge-tree to exit
+	early when it finds a conflict, and allows it to avoid writing
+	most objects created by merges.
+
 --allow-unrelated-histories::
 	merge-tree will by default error out if the two branches specified
 	share no common history.  This flag can be given to override that
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 4aafa73c6155..7f41665dfd7e 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -490,6 +490,9 @@ static int real_merge(struct merge_tree_options *o,
 	if (result.clean < 0)
 		die(_("failure to merge"));
 
+	if (o->merge_options.mergeability_only)
+		goto cleanup;
+
 	if (show_messages == -1)
 		show_messages = !result.clean;
 
@@ -522,6 +525,8 @@ static int real_merge(struct merge_tree_options *o,
 	}
 	if (o->use_stdin)
 		putchar(line_termination);
+
+cleanup:
 	merge_finalize(&opt, &result);
 	clear_merge_options(&opt);
 	return !result.clean; /* result.clean < 0 handled above */
@@ -538,6 +543,7 @@ int cmd_merge_tree(int argc,
 	int original_argc;
 	const char *merge_base = NULL;
 	int ret;
+	int quiet = 0;
 
 	const char * const merge_tree_usage[] = {
 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
@@ -552,6 +558,10 @@ int cmd_merge_tree(int argc,
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F(0, "quiet",
+			   &quiet,
+			   N_("suppress all output; only exit status wanted"),
+			   PARSE_OPT_NONEG),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("separate paths with the NUL character"), '\0'),
 		OPT_BOOL_F(0, "name-only",
@@ -583,6 +593,14 @@ int cmd_merge_tree(int argc,
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (quiet && o.show_messages == -1)
+		o.show_messages = 0;
+	o.merge_options.mergeability_only = quiet;
+	die_for_incompatible_opt2(quiet, "--quiet", o.show_messages, "--messages");
+	die_for_incompatible_opt2(quiet, "--quiet", o.name_only, "--name-only");
+	die_for_incompatible_opt2(quiet, "--quiet", o.use_stdin, "--stdin");
+	die_for_incompatible_opt2(quiet, "--quiet", !line_termination, "-z");
+
 	if (xopts.nr && o.mode == MODE_TRIVIAL)
 		die(_("--trivial-merge is incompatible with all other options"));
 	for (size_t x = 0; x < xopts.nr; x++)
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index f9c5883a7f7c..6e117ee93c8b 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -54,6 +54,25 @@ test_expect_success setup '
 	git commit -m first-commit
 '
 
+test_expect_success '--quiet on clean merge' '
+	# Get rid of loose objects to start with
+	git gc &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git count-objects >actual &&
+	test_cmp expect actual &&
+
+	# Ensure merge is successful (exit code of 0)
+	git merge-tree --write-tree --quiet side1 side3 >output &&
+
+	# Ensure there is no output
+	test_must_be_empty output &&
+
+	# Ensure no loose objects written (all new objects written would have
+	# been in "outer layer" of the merge)
+	git count-objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Clean merge' '
 	TREE_OID=$(git merge-tree --write-tree side1 side3) &&
 	q_to_tab <<-EOF >expect &&
@@ -72,6 +91,25 @@ test_expect_success 'Failed merge without rename detection' '
 	grep "CONFLICT (modify/delete): numbers deleted" out
 '
 
+test_expect_success  '--quiet on conflicted merge' '
+	# Get rid of loose objects to start with
+	git gc &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git count-objects >actual &&
+	test_cmp expect actual &&
+
+	# Ensure merge has conflict
+	test_expect_code 1 git merge-tree --write-tree --quiet side1 side2 >output &&
+
+	# Ensure there is no output
+	test_must_be_empty output &&
+
+	# Ensure no loose objects written (all new objects written would have
+	# been in "outer layer" of the merge)
+	git count-objects >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'Content merge and a few conflicts' '
 	git checkout side1^0 &&
 	test_must_fail git merge side2 &&
-- 
gitgitgadget
