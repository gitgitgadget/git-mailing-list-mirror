Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3E4176ADB
	for <git@vger.kernel.org>; Tue, 24 Dec 2024 11:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735041183; cv=none; b=HgNEeF0NKvLTT0GuH1YJRWModliqCvGQ0Y7QA8OMgCw8JTd9Z/LIPonkMLnvy7IAvAxwSzEvoVHwdElLeK8JYMF3HP0TrTIYxf0tjX87QU0muQpDHFvbcw9mYuSBu3EmJn9VFt1GxmHoth1syT+nHgWKPGwbNQF+WlAUU+jqHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735041183; c=relaxed/simple;
	bh=7KVTir0iKANqdc6Wnu/yLZHMe5DiKklMf5pPtdUUFlo=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Y9GQsGjwhNnrJH0XsWFAweQXT64OCau8wvpgnOHggUo/2Citlai6sPhet2sPnnxYhG6HrriZW7r5cP5fwa1WYn9XvM7xFR+qDXJYpjg9rfbdP7ebB/MUvGf3v+HlBmce4ViGyyldkUajZzn7BxtALKcEjJaLHzfvE52tii3MfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ozk8X8Rx; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ozk8X8Rx"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862b40a6e0so2882745f8f.0
        for <git@vger.kernel.org>; Tue, 24 Dec 2024 03:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735041179; x=1735645979; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LwFxdo3y42ie/ZS68TQ6UJSmo0Cetz3+t7wZkro1muo=;
        b=Ozk8X8Rx9T33HMOrui6LZ8prvtf8WxB3LVlAxK/7wRkI/ZWWHKHtm+x8Gm5LDEvWc/
         AOI6tIT708WkDP0fYrJ7lkPbu7wm2OjsrIFTZOcMj0UO9LcrB3U7bKStBdjE35RyD1Bt
         o22O2PkCNH6csS8z2CeXg8lezMjmG/F46/bDkIzulMUxDUE2LzOCKr9iWI5Fk8G0w8IS
         ONM9AWSLoeMKAib5sSiEl1KnO4GQJvbrTPmWz67sms+2LclBjSrFft2jo9wsod5AZbUq
         RjsT0CXidswX9iqSG1772b1VvtT6scveZWYDlB2rfsVEc+SwHyl+BlvKUdvggqKurzTa
         L4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735041179; x=1735645979;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LwFxdo3y42ie/ZS68TQ6UJSmo0Cetz3+t7wZkro1muo=;
        b=atz4vpMv+t75ILeieOrHN4cyPVx5KMMCqJVQm0Eihd/Ur6Ww1MNe8hufulytPCx2XV
         Bwbb9eyIMgpwraoxwvxoebge40JRaA6W99v6qylynfCXE3cYKuybHDHasGBXJekYUJBt
         c8JPj09Npq4OwzxPbjCnPxCzqILNgDjADaNpCIWCYACnDfT2CgwFDJQ7wHCdCQUYW1mu
         zgdLD3PmUA1sMdp5W4LawjfU2HEdyweM/3kOHmS3i4jucHzx31+bpNRFNCwVTFpOsyCf
         Fgbq4tKNDSo+4Q1jDvIo1U+KcV+pq1SDVNa21DWsNRf9Z1WlO3qirtTNdKcyL0uJszyt
         f4uw==
X-Gm-Message-State: AOJu0YwLGIlWeEmZIomZ/Gr0psQA4Q04m+6zy11S3RFodp3y/7i+DW64
	CAPFO0/4P4jXygZHxKU5oc4cYvIU1f8PqXNmFjQeWp/CjIqpWTMsbATpAQ==
X-Gm-Gg: ASbGnct/Q+cS9ad7KOTsPZILB0Q3GrbTFUWkpm34U37IHzaWXoeUoQ0d92S3LMCiRG4
	IV6bj2fKfQxenqK2o2cfM72INOZ99sB9Uovxffemm2mplitvzA5eTTdeHL93vB+tvBHdWx856Ek
	GEnkZu8CLlM+foLvEFIFUQ5VJ0mDc70Bgp1WA29aJcleGHTW4V8mhWjFTk0F5BBnRckMgFrcEAb
	/3K+69QY4L/6TgWY6Wl3iNL+bUbkPlkn59P7vXZso6nXcORbPZz6U23/g==
X-Google-Smtp-Source: AGHT+IGTNtZ6UXakt3MqOjg97lTlcZNnVRDCn3MTXOIoMlRInlA0byTdijmlUIZ7DXBrgrYNnR4b5w==
X-Received: by 2002:a05:6000:4715:b0:385:e2c4:1f8d with SMTP id ffacd0b85a97d-38a221f0f40mr14617107f8f.19.1735041179197;
        Tue, 24 Dec 2024 03:52:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8474b6sm13970603f8f.51.2024.12.24.03.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Dec 2024 03:52:58 -0800 (PST)
Message-Id: <pull.1843.git.1735041177817.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 24 Dec 2024 11:52:57 +0000
Subject: [PATCH] gc: add `--expire-to` option
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
    ZheNing Hu <adlternative@gmail.com>,
    ZheNing Hu <adlternative@gmail.com>

From: ZheNing Hu <adlternative@gmail.com>

This commit extends the functionality of `git gc`
by adding a new option, `--expire-to=<dir>`. Previously,
this feature was implemented in `git repack` (see 91badeb),
allowing users to specify a directory where unreachable and
expired cruft packs are stored during garbage collection.
However, users had to run `git repack --cruft --expire-to=<dir>`
followed by `git prune` to achieve similar results within `git gc`.

By introducing `--expire-to=<dir>` directly into `git gc`,
we simplify the process for users who wish to manage their
repository's cleanup more efficiently. This change involves
passing the `--expire-to=<dir>` parameter through to `git repack`,
making it easier for users to set up a backup location for cruft
packs that will be pruned.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    gc: add --expire-to option
    
    I want to perform a "safe" garbage collection for the Git repository on
    the server, which avoids data corruption issues caused by concurrent
    pushes during git GC. To achieve this, I currently need to use git
    repack --cruft --expire-to=<dir> and git prune in combination. However,
    it would be simpler if we could directly use --expire-to=<dir> with the
    git-gc command.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1843%2Fadlternative%2Fzh%2Fgc-expire-to-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1843/adlternative/zh/gc-expire-to-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1843

 Documentation/git-gc.txt | 6 ++++++
 builtin/gc.c             | 6 +++++-
 t/t6500-gc.sh            | 6 ++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 370e22faaeb..b4c0cf02972 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -69,6 +69,12 @@ be performed as well.
 	the `--max-cruft-size` option of linkgit:git-repack[1] for
 	more.
 
+--expire-to=<dir>::
+	When packing unreachable objects into a cruft pack, write a cruft
+	pack containing pruned objects (if any) to the directory `<dir>`.
+	See the `--expire-to` option of linkgit:git-repack[1] for
+	more.
+
 --prune=<date>::
 	Prune loose objects older than date (default is 2 weeks ago,
 	overridable by the config variable `gc.pruneExpire`).
diff --git a/builtin/gc.c b/builtin/gc.c
index d52735354c9..77904694c9f 100644
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
@@ -441,6 +442,8 @@ static void add_repack_all_option(struct gc_config *cfg,
 		if (cfg->max_cruft_size)
 			strvec_pushf(&repack, "--max-cruft-size=%lu",
 				     cfg->max_cruft_size);
+		if (cfg->repack_expire_to)
+			strvec_pushf(&repack, "--expire-to=%s", cfg->repack_expire_to);
 	} else {
 		strvec_push(&repack, "-A");
 		if (cfg->prune_expire)
@@ -675,7 +678,6 @@ struct repository *repo UNUSED)
 	const char *prune_expire_sentinel = "sentinel";
 	const char *prune_expire_arg = prune_expire_sentinel;
 	int ret;
-
 	struct option builtin_gc_options[] = {
 		OPT__QUIET(&quiet, N_("suppress progress reporting")),
 		{ OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"),
@@ -694,6 +696,8 @@ struct repository *repo UNUSED)
 			   PARSE_OPT_NOCOMPLETE),
 		OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
 			 N_("repack all other packs except the largest pack")),
+		OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir"),
+			   N_("pack prefix to store a pack containing pruned objects")),
 		OPT_END()
 	};
 
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index ee074b99b70..d4b0653a9b7 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -339,6 +339,12 @@ test_expect_success 'gc.maxCruftSize sets appropriate repack options' '
 	test_subcommand $cruft_max_size_opts --max-cruft-size=3145728 <trace2.txt
 '
 
+test_expect_success '--expire-to sets appropriate repack options' '
+	mkdir expired &&
+	GIT_TRACE2_EVENT=$(pwd)/trace2.txt git -C cruft--max-size gc --cruft --expire-to=./expired/pack &&
+	test_subcommand $cruft_max_size_opts --expire-to=./expired/pack <trace2.txt
+'
+
 run_and_wait_for_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the

base-commit: 92999a42db1c5f43f330e4f2bca4026b5b81576f
-- 
gitgitgadget
