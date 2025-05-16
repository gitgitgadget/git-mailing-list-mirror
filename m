Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981181ADC7E
	for <git@vger.kernel.org>; Fri, 16 May 2025 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747407338; cv=none; b=JMRL2eYjTBUB83wu4qSXFS1pSVfDqJBe8YwZuOOYSWnK6fh7g7f+OOaPaWZ10NjDf8C+j8sT+tY1jfptaH5fPSibKpWkClT1ttmD+RrzozDL6zIOitnzCMAhRTx1as45A5KkNwF3YdPWuXMNofpiQj7YBSY3VDc/iJwGMBl5xJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747407338; c=relaxed/simple;
	bh=UWIlnGRc29VFht/MkN8PDEiuvBKKpWhQtwROdI+ynwk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Al/ZZDVs+lp3n6V324Yf6Muy1l5pdeNIxnKGOikBMBrfSxl5GjgHCi0UnRg2S5oooeU7IbEmQkfbe6YMfshSLloa04t9hTlHAKPDwrveMB5yqIVjIF04+C6ft3UtMJfMDiOW5UWzbck4AZNGSDXwqhgbKQqzW0XYRXqzMAa8w6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JASNqLry; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JASNqLry"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so23618505e9.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747407334; x=1748012134; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+72koXptMPUOvugF9nQGr99SCFVCjm+IJsjEboc6+F0=;
        b=JASNqLryBe28p5f/IBs2xZu5D/Dz3JTqctw4NtTrn9u+KOhjv4t4ya5hVjq1GcKf8J
         Axc9rZmtuDSwramGDsJ2ZGnX3djvtrZTLNi1z8dr7UhL/m2q36c4IMMUHxlMg3CtFJoD
         lyoRUw68f/aaA0aochKm65k8IAVbpSkPP2a4OQAq8jrdCN3Sn2BuD2dJjoEJl+eTbBMt
         ivdRCDPCjqMJ3uORiAyV6m9nb9ec222XOqpV5rVnQfBjUweUHvtB76Ng7NgY2gfZND/r
         q9r3lFGk4t15aZWms7TphwkzSSXJfXmr7O5muxFXllXjF1sbpJcpP1fj6exMlh1YbIHa
         Vr+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747407334; x=1748012134;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+72koXptMPUOvugF9nQGr99SCFVCjm+IJsjEboc6+F0=;
        b=THe5NqcXcY+fVRospjNT6+sn4V5KVoDp6z6l3gZmIq9QQYoJURPu7Q/mZbaGfTAci9
         brflvXgZsyz0XMMxvMy0SxwC97LruHTd1UNigF44F4EGVnbhx2urTrXEzHDizbDG6tkH
         5DJKlsRCF5yGZbbx1iRGAuPL+wbLxi7p54Is4PpKO5tvCVCDs1/go5Wfcv4qFm9un/K1
         XXwV/7rIwUuhAxEBzeWq6oFfLopY3aViPLpbippy4loI+BdOxGd47APpSfOs+0+L0QLJ
         lw63yLFI9uquarmTI+RCwcfOgxvTShdSmniT8BifU1eroVIAuLNlmq6dHrgrXwn+u6fD
         blzQ==
X-Gm-Message-State: AOJu0YzZ/Wz9iQNmvyyptt+VGnwK+HzVsTXwY0O/8fh/kvwKKOG4LulU
	19dfIRjR7esqMYvqlAOwUFvyV/pcqcZRjng47+hM81rHDLXDFtwEzu8QuH5jSQ==
X-Gm-Gg: ASbGncvbjAi0XVPYbQEjN2SznnagW7tS2U7EKDeExHsq9ftvJRb6oQyEzfcBh4HmBzH
	zFoIA1m1UpSYo0l0Zz/U0a/o4/rmsoyO39KpQcTsuSpAfrcJgRcng/7ecpOAxflYpgQdgAaA+1a
	/S+PoqkrLDqptpjuYxqtYlH/Ye9/nr+ZkptNGz101BI1nDi42QNWAMfmfOrC4J/XSbCQ36yY/OV
	03HtD/OiMqaQqro+V7tOILbrULop7u7okoWxcv0OcukHgnZN0gg6MxsiwfzKamLp0dEArQ5EmwX
	sfeVbkc8T5v9bjz9E7ar6THTmHm1e5Bwnhk5hwHJOOzow/TPXUwu0FOpGR+2RPw=
X-Google-Smtp-Source: AGHT+IHStKQYJJfPE8SaCScuOTRhYlGI4it8h/x+pBulcSKYlo1bfN4BK92GN64V9hTYknKn9vSr0g==
X-Received: by 2002:a5d:5983:0:b0:3a2:39d:f51d with SMTP id ffacd0b85a97d-3a35c835072mr3646474f8f.23.1747407334136;
        Fri, 16 May 2025 07:55:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd59ab21sm35053745e9.38.2025.05.16.07.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 07:55:33 -0700 (PDT)
Message-Id: <0a2752721d0292c6e2527f7a95c846b280fda2a7.1747407330.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
	<pull.1914.v2.git.1747407330.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 16 May 2025 14:55:28 +0000
Subject: [PATCH v2 2/4] git add: make -p/-i aware of sparse index
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
Cc: gitster@pobox.com,
    newren@gmail.com,
    Phillip Wood <phillip.wood123@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

It is slow to expand a sparse index in-memory due to parsing of trees.
We aim to minimize that performance cost when possible. 'git add -p'
uses 'git apply' child processes to modify the index, but still there
are some expansions that occur.

It turns out that control flows out of cmd_add() in the interactive
cases before the lines that confirm that the builtin is integrated with
the sparse index.

Moving that integration point earlier in cmd_add() allows 'git add -p'
and 'git add -p' to operate without expanding a sparse index to a full
one.

Add test cases that confirm that these interactive add options work with
the sparse index.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 builtin/add.c                            |  7 +--
 t/t1092-sparse-checkout-compatibility.sh | 60 ++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 747511b68bc3..7c292ffdc6c2 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -390,6 +390,10 @@ int cmd_add(int argc,
 
 	argc = parse_options(argc, argv, prefix, builtin_add_options,
 			  builtin_add_usage, PARSE_OPT_KEEP_ARGV0);
+
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
+
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive) {
@@ -426,9 +430,6 @@ int cmd_add(int argc,
 	add_new_files = !take_worktree_changes && !refresh_only && !add_renormalize;
 	require_pathspec = !(take_worktree_changes || (0 < addremove_explicit));
 
-	prepare_repo_settings(repo);
-	repo->settings.command_requires_full_index = 0;
-
 	repo_hold_locked_index(repo, &lock_file, LOCK_DIE_ON_ERROR);
 
 	/*
diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 83353a7dbab4..c419d8b57e84 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -384,6 +384,38 @@ test_expect_success 'add, commit, checkout' '
 	test_all_match git checkout -
 '
 
+test_expect_success 'git add -p' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	# Does not expand when edits are within sparse checkout.
+	run_on_all ../edit-contents deep/a &&
+	run_on_all ../edit-contents deep/deeper1/a &&
+
+	test_write_lines y n >in &&
+	run_on_all git add -p <in &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git reset &&
+
+	test_write_lines u 1 "" q >in &&
+	run_on_all git add -i <in &&
+	test_all_match git status --porcelain=v2 &&
+	test_all_match git reset --hard &&
+
+	run_on_sparse mkdir -p folder1 &&
+	run_on_all ../edit-contents folder1/a &&
+	test_write_lines y n y >in &&
+	run_on_all git add -p <in &&
+	test_sparse_match git status --porcelain=v2 &&
+	test_sparse_match git reset &&
+	test_write_lines u 2 3 "" q >in &&
+	run_on_all git add -i <in &&
+	test_sparse_match git status --porcelain=v2
+'
+
 test_expect_success 'deep changes during checkout' '
 	init_repos &&
 
@@ -2398,6 +2430,34 @@ test_expect_success 'sparse-index is not expanded: git apply' '
 	ensure_expanded apply --cached ../patch-outside
 '
 
+test_expect_success 'sparse-index is not expanded: git add -p' '
+	init_repos &&
+
+	# Does not expand when edits are within sparse checkout.
+	echo "new content" >sparse-index/deep/a &&
+	echo "new content" >sparse-index/deep/deeper1/a &&
+	test_write_lines y n >in &&
+	ensure_not_expanded add -p <in &&
+	git -C sparse-index reset &&
+	ensure_not_expanded add -i <in &&
+
+	# -p does expand when edits are outside sparse checkout.
+	mkdir -p sparse-index/folder1 &&
+	echo "new content" >sparse-index/folder1/a &&
+	test_write_lines y n y >in &&
+	ensure_expanded add -p <in &&
+
+	# Fully reset the index.
+	git -C sparse-index reset --hard &&
+	git -C sparse-index sparse-checkout reapply &&
+
+	# -i does expand when edits are outside sparse checkout.
+	mkdir -p sparse-index/folder1 &&
+	echo "new content" >sparse-index/folder1/a &&
+	test_write_lines u 2 3 "" q >in &&
+	ensure_expanded add -i <in
+'
+
 test_expect_success 'advice.sparseIndexExpanded' '
 	init_repos &&
 
-- 
gitgitgadget

