Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1381D95A2
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704961; cv=none; b=f85I3OW3c0xDvNs3aQmHHFLSuxbriAqZuC7XU+vO1ugWP0lYHl9Ey1ngsh4C7+ZnJ4+FmAJVgi752gH7iIYjCnml7O50RBAP+v5gv+pEUglx3k5BKwIr0QcblakCYr+O+jsRNyDfEm2DULBUrPGCtTbZjcQ2t8+QzGstd1hvK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704961; c=relaxed/simple;
	bh=zxPC5RsohvQ8J8Y2uakfR0mSwzhNMWqX7YVuqbGMymI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DF1lnqjmxy+INdFJ2bJ31UWblwxhZ5ZoLQm9acZnxqI9rAgDjlC3J4Ywy4FX2QgwpalGhIBMuUJXI/6BKomLNAsTsD0RvqoOL+bN7invIjm3jBtV/3Fc2poJoz1lb38Rew0gEWlP6yjYiEUaT40An6SHi+MiStqKPAhirB9QkRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTJje4rk; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTJje4rk"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso18360955e9.0
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 23:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737704957; x=1738309757; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcUmswnW1vloe6/u1tX29odJd9HXnL0fdBMGMtcc96Y=;
        b=LTJje4rkCedEHzT1S0GItfM+IibzRXIvttFi7xLdu4WcBqb7m5bd/zFjvUCqAISxcB
         CPhmAIwbciWBjWb1KiJc0U+nw5BTj0L9ld42lnkIqRPD5e+T61FoD7kpLVrdwYE4qavw
         w9beelnARi1I9fHyxfJa6uDv/lckslm7oP+yGXpvSUcaGwarflRqPZNlj8RBwBvXDPnc
         0+V4de7JFDeafE/YRyKzxZtQRrI+LS9Ku2IOObhdIvHX/C4pgf08rtr02Fjw1mxASBed
         XxG6QzNHgThMNB+puJ1mk51BPcapkTXKFBQAAkNUFLTMVeiBE+LxKhdVnraUdQ96CFPa
         CkJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737704957; x=1738309757;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcUmswnW1vloe6/u1tX29odJd9HXnL0fdBMGMtcc96Y=;
        b=v+XJ5snpZ2dhjv5GezimvTp8+LoVc/AJb7BfyPucNsS8rWtux12fQlCswWCnB/OppV
         14Rt2e3UoKm+4jAKyN4WSZjLD6vxiPX4zwac9Ho8I297TOkTG2ilGzsUM7TEOV31qFY3
         26VvasnCSsIUnZ6n/qfYITfJgzLdbSnBYXZTs9PFu4bS8IN1JYMBw1fWmjv5A+jqVFUN
         zyJ0IP6o2weY3wHEoEqJnLwAmfnV2BXFYjDMuLgzTjNgMP/EwN3DjzvfQAYDfMzVcL8x
         R3cvVs5KC5oYqsCQ7YhOBbwm2FYSIJw7T9/qL6xJhDb/1RmTEyGDtQn7YkkOHeC3P4Hu
         mMrA==
X-Gm-Message-State: AOJu0YwZevzAk11sD8AR/Zyb6FM3Zav33Rn88Tr9G+K3zgPA4yt7WXwK
	ydiyccNZeRPX9s8cKNpbLwEbMYGw7LgihuuIIOpJz5ATToVDpmkhCCoecQ==
X-Gm-Gg: ASbGncs3lPB2dDAdediSf+5guN6/TLiKbAQ6igoCw+N/g6pTLi/dK5KWqEPqQrGT9Eb
	zmPi3RU0UQyTbTvsMqvPH5PP6unQxAHYgGhpzRhYA8Pd8kQRWhkYpJfjIc+JMbsvSb7es7ltiBK
	PtGQ/z1RvSbVEEMyLMFtv02SsVViVC5To+JlOmn4tCoYVrQF459iH1feeSQp5yqpOQtCNAtOih2
	CpO/Xrr54Q3p0MUEEiYa9tmxRghINM+msWlMDvr8vfzzq8iDKWolXmkiSnpJ5BCJzUDWQL/X7qQ
	uIxgNA==
X-Google-Smtp-Source: AGHT+IEF6MrLkICfIkswh1PpDcuB0T4MgQHrF4kmOAPwauuNJPlpBLhSdGV82Zt1hiKUObwNdV57oA==
X-Received: by 2002:a5d:5989:0:b0:385:f6de:6266 with SMTP id ffacd0b85a97d-38bf566f72cmr27107672f8f.24.1737704956880;
        Thu, 23 Jan 2025 23:49:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438bd54c04bsm16645635e9.27.2025.01.23.23.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 23:49:16 -0800 (PST)
Message-Id: <pull.1843.v4.git.1737704954987.gitgitgadget@gmail.com>
In-Reply-To: <pull.1843.v3.git.1736994932003.gitgitgadget@gmail.com>
References: <pull.1843.v3.git.1736994932003.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 24 Jan 2025 07:49:14 +0000
Subject: [PATCH v4] gc: add `--expire-to` option
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
    me@ttaylorr.com,
    peff@peff.net,
    ZheNing Hu <adlternative@gmail.com>,
    ZheNing Hu <adlternative@gmail.com>

From: ZheNing Hu <adlternative@gmail.com>

This commit extends the functionality of `git gc`
by adding a new option, `--expire-to=<dir>`. Previously,
this feature was implemented in 91badeba32 (builtin/repack.c:
implement `--expire-to` for storing pruned objects, 2022-10-24),
which allowing users to specify a directory where unreachable
and expired cruft packs are stored during garbage collection.
However, users had to run `git repack --cruft --expire-to=<dir>`
followed by `git prune` to achieve similar results within `git gc`.

By introducing `--expire-to=<dir>` directly into `git gc`,
we simplify the process for users who wish to manage their
repository's cleanup more efficiently. This change involves
passing the `--expire-to=<dir>` parameter through to `git repack`,
making it easier for users to set up a backup location for cruft
packs that will be pruned.

Due to the original `git gc --prune=now` deleting all unreachable
objects by passing the `-a` parameter to git repack. With the
addition of the `--cruft` and `--expire-to` options, it is necessary
to modify this default behavior: instead of deleting these
unreachable objects, they should be merged into a cruft pack and
collected in a specified directory. Therefore, we do not pass `-a`
to the repack command but instead pass `--cruft`, `--expire-to`,
and `--cruft-expiration=now` to repack.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    gc: add --expire-to option
    
    I want to perform a "safe" garbage collection for the Git repository on
    the server, which avoids data corruption issues caused by concurrent
    pushes during git GC. To achieve this, I currently need to use git
    repack --cruft --expire-to=<dir> and git prune in combination. However,
    it would be simpler if we could directly use --expire-to=<dir> with the
    git-gc command.
    
    v1: add --expire-to option to gc v1 -> v2: fix git gc --prune=now with
    --expire-to v2 -> v3: squash two patch into one patch v3 -> v4: modify
    docs, commit message, and give more tests

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1843%2Fadlternative%2Fzh%2Fgc-expire-to-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1843/adlternative/zh/gc-expire-to-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1843

Range-diff vs v3:

 1:  0842ec34948 ! 1:  6946ccde275 gc: add `--expire-to` option
     @@ Commit message
      
          This commit extends the functionality of `git gc`
          by adding a new option, `--expire-to=<dir>`. Previously,
     -    this feature was implemented in `git repack` (see 91badeb),
     -    allowing users to specify a directory where unreachable and
     -    expired cruft packs are stored during garbage collection.
     +    this feature was implemented in 91badeba32 (builtin/repack.c:
     +    implement `--expire-to` for storing pruned objects, 2022-10-24),
     +    which allowing users to specify a directory where unreachable
     +    and expired cruft packs are stored during garbage collection.
          However, users had to run `git repack --cruft --expire-to=<dir>`
          followed by `git prune` to achieve similar results within `git gc`.
      
     @@ Commit message
          making it easier for users to set up a backup location for cruft
          packs that will be pruned.
      
     -    Note: When git-gc is used with both `--cruft` and `--expire-to`,
     -    it does not pass `-a` to git-repack to delete all unreachable
     -    objects as `git gc --prune=now` originally did. Instead, it
     -    generates a cruft pack in the directory specified by expire-to.
     +    Due to the original `git gc --prune=now` deleting all unreachable
     +    objects by passing the `-a` parameter to git repack. With the
     +    addition of the `--cruft` and `--expire-to` options, it is necessary
     +    to modify this default behavior: instead of deleting these
     +    unreachable objects, they should be merged into a cruft pack and
     +    collected in a specified directory. Therefore, we do not pass `-a`
     +    to the repack command but instead pass `--cruft`, `--expire-to`,
     +    and `--cruft-expiration=now` to repack.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-gc.txt: be performed as well.
      +--expire-to=<dir>::
      +	When packing unreachable objects into a cruft pack, write a cruft
      +	pack containing pruned objects (if any) to the directory `<dir>`.
     ++	This option only has an effect when used together with `--cruft`.
      +	See the `--expire-to` option of linkgit:git-repack[1] for
     -+	more.
     ++	more information.
      +
       --prune=<date>::
       	Prune loose objects older than date (default is 2 weeks ago,
     @@ t/t6500-gc.sh: test_expect_success 'gc.maxCruftSize sets appropriate repack opti
       	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
       '
       
     -+test_expect_success '--expire-to sets appropriate repack options' '
     ++test_expect_success '--expire-to sets repack --expire-to' '
     ++	rm -rf expired &&
      +	mkdir expired &&
     -+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --expire-to=./expired/pack &&
     -+	test_subcommand $cruft_max_size_opts --expire-to=./expired/pack <trace2.txt
     ++	expire_to="$(pwd)/expired/pack" &&
     ++	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --expire-to="$expire_to" &&
     ++	test_subcommand $cruft_max_size_opts --expire-to="$expire_to" <trace2.txt
     ++'
     ++
     ++test_expect_success '--expire-to with --prune=now sets repack --expire-to' '
     ++	rm -rf expired &&
     ++	mkdir expired &&
     ++	expire_to="$(pwd)/expired/pack" &&
     ++	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --prune=now --expire-to="$expire_to" &&
     ++	test_subcommand git repack -d -l --cruft --cruft-expiration=now --expire-to="$expire_to" <trace2.txt
     ++'
     ++
     ++
     ++test_expect_success '--expire-to with --no-cruft sets repack -A' '
     ++	rm -rf expired &&
     ++	mkdir expired &&
     ++	expire_to="$(pwd)/expired/pack" &&
     ++	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --no-cruft --expire-to="$expire_to" &&
     ++	test_subcommand git repack -d -l -A --unpack-unreachable=2.weeks.ago <trace2.txt
     ++'
     ++
     ++test_expect_success '--expire-to with --no-cruft sets repack -a' '
     ++	rm -rf expired &&
     ++	mkdir expired &&
     ++	expire_to="$(pwd)/expired/pack" &&
     ++	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --no-cruft --prune=now --expire-to="$expire_to" &&
     ++	test_subcommand git repack -d -l -a <trace2.txt
      +'
      +
       run_and_wait_for_gc () {


 Documentation/git-gc.txt |  7 +++++++
 builtin/gc.c             |  9 +++++++--
 t/t6500-gc.sh            | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 370e22faaeb..0eac8e85f08 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -69,6 +69,13 @@ be performed as well.
 	the `--max-cruft-size` option of linkgit:git-repack[1] for
 	more.
 
+--expire-to=<dir>::
+	When packing unreachable objects into a cruft pack, write a cruft
+	pack containing pruned objects (if any) to the directory `<dir>`.
+	This option only has an effect when used together with `--cruft`.
+	See the `--expire-to` option of linkgit:git-repack[1] for
+	more information.
+
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c9..8656e1caff0 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -136,6 +136,7 @@ struct gc_config {
 	char *prune_worktrees_expire;
 	char *repack_filter;
 	char *repack_filter_to;
+	char *repack_expire_to;
 	unsigned long big_pack_threshold;
 	unsigned long max_delta_cache_size;
 };
@@ -432,7 +433,8 @@ static int keep_one_pack(struct string_list_item *item, void *data UNUSED)
 static void add_repack_all_option(struct gc_config *cfg,
 				  struct string_list *keep_pack)
 {
-	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now"))
+	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
+		&& !(cfg->cruft_packs && cfg->repack_expire_to))
 		strvec_push(&repack, "-a");
 	else if (cfg->cruft_packs) {
 		strvec_push(&repack, "--cruft");
@@ -441,6 +443,8 @@ static void add_repack_all_option(struct gc_config *cfg,
 		if (cfg->max_cruft_size)
 			strvec_pushf(&repack, "--max-cruft-size=%lu",
 				     cfg->max_cruft_size);
+		if (cfg->repack_expire_to)
+			strvec_pushf(&repack, "--expire-to=%s", cfg->repack_expire_to);
 	} else {
 		strvec_push(&repack, "-A");
 		if (cfg->prune_expire)
@@ -675,7 +679,6 @@ struct repository *repo UNUSED)
 	const char *prune_expire_sentinel = "sentinel";
 	const char *prune_expire_arg = prune_expire_sentinel;
 	int ret;
-
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
 		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),
@@ -694,6 +697,8 @@ struct repository *repo UNUSED)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
 			 N_("repack all other packs except the largest pack")),
+		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
+			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_END()
 	};
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index ee074b99b70..74f7bd09046 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -339,6 +339,39 @@ test_expect_success 'gc.maxCruftSize sets appropriate repack options' '
 	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
 '
 
+test_expect_success '--expire-to sets repack --expire-to' '
+	rm -rf expired &&
+	mkdir expired &&
+	expire_to="$(pwd)/expired/pack" &&
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --expire-to="$expire_to" &&
+	test_subcommand $cruft_max_size_opts --expire-to="$expire_to" <trace2.txt
+'
+
+test_expect_success '--expire-to with --prune=now sets repack --expire-to' '
+	rm -rf expired &&
+	mkdir expired &&
+	expire_to="$(pwd)/expired/pack" &&
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --prune=now --expire-to="$expire_to" &&
+	test_subcommand git repack -d -l --cruft --cruft-expiration=now --expire-to="$expire_to" <trace2.txt
+'
+
+
+test_expect_success '--expire-to with --no-cruft sets repack -A' '
+	rm -rf expired &&
+	mkdir expired &&
+	expire_to="$(pwd)/expired/pack" &&
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --no-cruft --expire-to="$expire_to" &&
+	test_subcommand git repack -d -l -A --unpack-unreachable=2.weeks.ago <trace2.txt
+'
+
+test_expect_success '--expire-to with --no-cruft sets repack -a' '
+	rm -rf expired &&
+	mkdir expired &&
+	expire_to="$(pwd)/expired/pack" &&
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --no-cruft --prune=now --expire-to="$expire_to" &&
+	test_subcommand git repack -d -l -a <trace2.txt
+'
+
 run_and_wait_for_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
-- 
gitgitgadget
