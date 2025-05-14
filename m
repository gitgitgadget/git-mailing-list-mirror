Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5A1EA73
	for <git@vger.kernel.org>; Wed, 14 May 2025 00:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747182296; cv=none; b=F2J4az2yn2/onJeNz0UTBiO/x6PjiOabLdTwzcSq+0nnc00mQq1VwSxEkh2jInp5NeFXL1NM/jZAEA/1i/4O3j3hkNuKKsKTrAOePLBt0ORPNEe7UnzXkxyvPt62Co/PcQPGhoEnGCZou+YnNEbjf55p+0dK4dTnStWbrvY3TNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747182296; c=relaxed/simple;
	bh=BVbecQyt8S5dJe77Z8N351KKITwcLW1FvjZvcb+VLRk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KOdIVcnUySdM6tAQgORKvh4zhH5ZBcov013sKSHMAHT+HTh0TwDHCG1zdQCUheL/WJdM8cFfh8AU64hi2ESv35A2xIS3Lu+90QpQXNv0ny9LL03Jh57qCNltg8JaBvQ6PxyB/ZvGAY9CxeNAABgaTwatYXLfD2MI8KXFsxRrihQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KuDchpjc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KuDchpjc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so2555435e9.1
        for <git@vger.kernel.org>; Tue, 13 May 2025 17:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747182292; x=1747787092; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FjhPhjIA3dtqEDmtIMmYl7V8O0zaQjWrabky5ntdOPE=;
        b=KuDchpjcb9wC9u6eC6hlU00JOpCuhK7dn1qexInCfJowEK18uKn7MMqOUvvsjK0foc
         l17xwCfaVhghvc1k9A5NeRhk8guVRZus6wBOL8bjn9AwIaksthz8fJU/bc/NpDySA0Cb
         DbeStpsX156ICiAQrXlZ7SmH5n1ljgq8fjerqZGhMdje2TWf9VfzYpgxmRGI16vjR7U0
         fVs+qW8qb6ip5LpVLEJgKB0d8YkhxjMWjKeCk3ig8lyUEZE0nUDPuqT09DrFPpt1hrhv
         kYBoQGZNO0047Wku638Eid/7ol53gQDv4ygqAkJzagPDZGeRIE4HoUWO42xoZUwrTdP1
         ZOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747182292; x=1747787092;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FjhPhjIA3dtqEDmtIMmYl7V8O0zaQjWrabky5ntdOPE=;
        b=n6Yl6+FhWUyx0NgU7I+yh6uT02Q+a37n6/PiD/gNccN4mXsrzQAM4sqBHHeNvB8tIK
         WW+EoES7FMpW/XFAvBmD01PPVq+ry/AspoEWcnMvPch7cfZXgVZUi0b3trYPD/i1zyjQ
         qP4Q0c/F4+wpJr/xITzuERkEYW9N7hUrL4KIsV6BK0lRYwhwMHk36y09VTt2v7KUiA6u
         Qyg3cxffjptgConkLT2UKCdt8RsGzbPAQeQj+vSDkPbBeIdWaeAB/6uDiav+DhEXEAkH
         dtasy4df6rhsdzmEQickrqGEBcqDW5YaSjNFaSr2+PZWvV5nN1lB+YWGw3BRz6rko4uA
         HVhg==
X-Gm-Message-State: AOJu0YwT0bEAPdlNTDNON5Gv9b/PxRrHorbTnDoqadtP4aBANYDfHosr
	UOrjVVYEY0DWQrVLlnIDzyh7Jwz8MUfbom80/E+UDfCNK4t+UnwIgOy7iw==
X-Gm-Gg: ASbGncvNQfFaWGb5/C4hRELPBSdM4y/S6A7+yFcxDdu89z/t5Q2H4I63fvyKtdG05YT
	d9TOz7pLeTpr1bN4BjgkAioTa7zwxdHSQN/7H59G9i641/QrecEF30SMABClFMk5iSKglO/6XbK
	tAgEiVS+yGns50tE1jgpsCMEyBYVSN5vdQUJBzhr2TnjwHSmNlnkLrqX95//jF3J0Yo0vy18uGA
	08qd5Cau6/i3B2jtlD6euvwiXs6Qrf9Xwld9VJoGOaU8ezaDDhseFJ+aobkGQzO60272VPJg3Ub
	ZOmsLiMs4XRKuObNXP6SwoIsLx7md4ZMCkhYmsrNeb///0/2aPwPr0RZ6MtaZo4=
X-Google-Smtp-Source: AGHT+IEB9VZgOCLR/4W5y4zszKB4D0/sseLUJN+uWV4aPDFbM7UCQuEvJpAz3cE2qYukc/WMbQzoxA==
X-Received: by 2002:a05:600c:1ca0:b0:43d:5264:3cf0 with SMTP id 5b1f17b1804b1-442eb8855bcmr35328715e9.11.1747182291967;
        Tue, 13 May 2025 17:24:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f397926asm6206155e9.36.2025.05.13.17.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 17:24:51 -0700 (PDT)
Message-Id: <f11824317a8050764fe35698039f863dd842b0c2.1747182288.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
References: <pull.1920.v2.git.1747093322.gitgitgadget@gmail.com>
	<pull.1920.v3.git.1747182287.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 May 2025 00:24:47 +0000
Subject: [PATCH v3 2/2] merge-tree: add a new --dry-run flag
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
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Git Forges may be interested in whether two branches can be merged while
not being interested in what the resulting merge tree is nor which files
conflicted.  For such cases, add a new --dry-run flag which
will make use of the new mergeability_only flag added to merge-ort in
the previous commit.  This option allows the merge machinery to, in the
outer layer of the merge:
    * exit early when a conflict is detected
    * avoid writing (most) merged blobs/trees to the object store

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.adoc |  6 +++++
 builtin/merge-tree.c              | 22 ++++++++++++++++++
 t/t4301-merge-tree-write-tree.sh  | 38 +++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+)

diff --git a/Documentation/git-merge-tree.adoc b/Documentation/git-merge-tree.adoc
index cf0578f9b5e8..74716b910192 100644
--- a/Documentation/git-merge-tree.adoc
+++ b/Documentation/git-merge-tree.adoc
@@ -65,6 +65,12 @@ OPTIONS
 	default is to include these messages if there are merge
 	conflicts, and to omit them otherwise.
 
+--dry-run::
+	Disable all output from the program.  Useful when you are only
+	interested in the exit status.  Allows merge-tree to exit
+	early when it finds a conflict, and allows it to avoid writing
+	most objects created by merges.
+
 --allow-unrelated-histories::
 	merge-tree will by default error out if the two branches specified
 	share no common history.  This flag can be given to override that
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 4aafa73c6155..273ec171e988 100644
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
+	int dry_run = 0;
 
 	const char * const merge_tree_usage[] = {
 		N_("git merge-tree [--write-tree] [<options>] <branch1> <branch2>"),
@@ -552,6 +558,10 @@ int cmd_merge_tree(int argc,
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F(0, "dry-run",
+			   &dry_run,
+			   N_("suppress all output; only exit status wanted"),
+			   PARSE_OPT_NONEG),
 		OPT_SET_INT('z', NULL, &line_termination,
 			    N_("separate paths with the NUL character"), '\0'),
 		OPT_BOOL_F(0, "name-only",
@@ -583,6 +593,18 @@ int cmd_merge_tree(int argc,
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
 
+	if (dry_run && o.show_messages == -1)
+		o.show_messages = 0;
+	o.merge_options.mergeability_only = dry_run;
+	die_for_incompatible_opt2(dry_run, "--dry-run",
+				  o.show_messages, "--messages");
+	die_for_incompatible_opt2(dry_run, "--dry-run",
+				  o.name_only, "--name-only");
+	die_for_incompatible_opt2(dry_run, "--dry-run",
+				  o.use_stdin, "--stdin");
+	die_for_incompatible_opt2(dry_run, "--dry-run",
+				  !line_termination, "-z");
+
 	if (xopts.nr && o.mode == MODE_TRIVIAL)
 		die(_("--trivial-merge is incompatible with all other options"));
 	for (size_t x = 0; x < xopts.nr; x++)
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index f9c5883a7f7c..566a2b4ec737 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -54,6 +54,25 @@ test_expect_success setup '
 	git commit -m first-commit
 '
 
+test_expect_success '--dry-run on clean merge' '
+	# Get rid of loose objects to start with
+	git gc &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git count-objects >actual &&
+	test_cmp expect actual &&
+
+	# Ensure merge is successful (exit code of 0)
+	git merge-tree --write-tree --dry-run side1 side3 >output &&
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
 
+test_expect_success  '--dry-run on conflicted merge' '
+	# Get rid of loose objects to start with
+	git gc &&
+	echo "0 objects, 0 kilobytes" >expect &&
+	git count-objects >actual &&
+	test_cmp expect actual &&
+
+	# Ensure merge has conflict
+	test_expect_code 1 git merge-tree --write-tree --dry-run side1 side2 >output &&
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
