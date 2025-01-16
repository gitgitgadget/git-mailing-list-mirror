Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145061862
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 02:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736994937; cv=none; b=ObRKB5f4suV7krEOirj6NLlXwmAg3fW6JJzFthM7LCN6ePmGtiNmnUY4Gf491xwAU9ulEqu/BX2dyIQzXKwUqZSbL5AlI/FMizVgBeuzQhGo5yO8agCOb5jwRqEuHaY7Nab8FaLhQ0YZT29PldIfjUZjbpyXmQIR7LFKJFHJoGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736994937; c=relaxed/simple;
	bh=w00xgbRww2JZ0Zo5RjU1gwD9oQXlXWt2v451qZMFopM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=TDAG828OuTZxS+loUztJbK0wYADSHtVdCDts+9/s/7Wz7OzP5cJIvJsQrZi4rdLKPbRnWbev3Wm758fCUiO32xy28PS+TRvJeoLpOrGPmo6paT7BYy4Vd4lSAYiIsKIFVrwnGULls8Mt54Y2i6ikOnNJZxA5trHkPpddGdjciiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=At5P5qmI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="At5P5qmI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43622267b2eso3416175e9.0
        for <git@vger.kernel.org>; Wed, 15 Jan 2025 18:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736994934; x=1737599734; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0hgRnhRvXZLAvugqo/atPWLYQrrHZoAgCdEMRd1e+MI=;
        b=At5P5qmIijis5D1BWzBDf4nnJrgI7RKYbB20X+g0sBvJV0BY3V/L68KC6Ybcw6Hx+0
         DEAxMuFyWhQdoDmeKtMegDBJvFxx0kh04QDssmHp6K+Oal2pg9Of5zhOq38TKEwiDdJn
         sbZfbn5mpGAFS1IppaCeuzJk/MeTxDI6gk3BoVIMonrartodHpdoZXYHScRKbCpSt7B3
         wYn0TG4I4uppvh6ZDE/Uc+lhHPSGu2oXCf5YriKGQPJlHkxgHVEZCEJGW6f7y4AK0z0V
         DHWSJiS4FG7lYKGyyMEupZcVfbWRUjF2/O10T7mMnl3l8GW33C/DpwY6Tt1Jd/QhxtMp
         stvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736994934; x=1737599734;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hgRnhRvXZLAvugqo/atPWLYQrrHZoAgCdEMRd1e+MI=;
        b=fJJ5ogKFJSZNQg4mA3z3ejZxiRQ0rZ72PWyG6CV7mukCi7rWLqslZqVmu3e/TUCSc1
         5TV9U0HhgsMs+AToQvnD9nVzI6HOyNLSwdr7s4Cfnabtu4DVtJvuszIYdjaRbE9jJPHY
         F4BeXEsH+qR6k0AjstCnWf7kKC0GWPALiuJx4bL2rfaWNV2sIseE6hyG9FkbLIuqKUFE
         qGakrAqnwppvBN/BwCRDideXBbEdUulXyKujaod2AS3FrHLO3vPcDLAftsZvv0eIUqkG
         p3eahgrcrbl5KtHZO8WTUIBw3nf6RqaGhzcRbY0j03tLItRJPDObucoIpIbyT3+KvouA
         hS/w==
X-Gm-Message-State: AOJu0YwhAUw52G4t8jwQEADuh+R3xaGQJd5CiNXCm1eewe1c8FZomZOA
	Z0HQil3K+DB+tvlilOFtElI61uMO6eMfen3dBPafyhuFBnabRDZwcyWqmg==
X-Gm-Gg: ASbGncuagtx7/OcSkvarXdgOS4JpREi7i/1HMTfssebeK+3UvXl/Ipwblk5KYMeIbfc
	1yoY0THUptJe8LnKCjLzUGLKpjjhhMygz/0sM/n0UqnmQlaOLRHyqb3oq+EJ865eq4jCdBF9BwD
	NHY7sQqSS1TP9w60rGhD7h0vIjUTk5i2tMSu/Yc4BWL2Z4NDVT7CZMhPpFbSUjuOUFuRVY1hCKP
	ERBy6o2EoPhJYwf4b9ZjGRtGyTBCZjpTZ1433RD/r6D6sD2xpJTAzxonA==
X-Google-Smtp-Source: AGHT+IFfeCHZlOl1xymguf34a5Ua4cyaDhxdGkmq7Dswrjf2MLN5+2/1nr2KHClDEagwwV2rqrBbuw==
X-Received: by 2002:a05:600c:3b0c:b0:434:f7e3:bfa0 with SMTP id 5b1f17b1804b1-436e26e2593mr241789545e9.21.1736994933441;
        Wed, 15 Jan 2025 18:35:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4c1b2asm18627168f8f.89.2025.01.15.18.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 18:35:32 -0800 (PST)
Message-Id: <pull.1843.v3.git.1736994932003.gitgitgadget@gmail.com>
In-Reply-To: <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
References: <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com>
From: "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 16 Jan 2025 02:35:31 +0000
Subject: [PATCH v3] gc: add `--expire-to` option
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

Note: When git-gc is used with both `--cruft` and `--expire-to`,
it does not pass `-a` to git-repack to delete all unreachable
objects as `git gc --prune=now` originally did. Instead, it
generates a cruft pack in the directory specified by expire-to.

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
    --expire-to v2 -> v3: squash two patch into one patch

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1843%2Fadlternative%2Fzh%2Fgc-expire-to-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1843/adlternative/zh/gc-expire-to-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/1843

Range-diff vs v2:

 1:  14e94bf04e5 ! 1:  0842ec34948 gc: add `--expire-to` option
     @@ Commit message
          making it easier for users to set up a backup location for cruft
          packs that will be pruned.
      
     +    Note: When git-gc is used with both `--cruft` and `--expire-to`,
     +    it does not pass `-a` to git-repack to delete all unreachable
     +    objects as `git gc --prune=now` originally did. Instead, it
     +    generates a cruft pack in the directory specified by expire-to.
     +
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
       ## Documentation/git-gc.txt ##
     @@ builtin/gc.c: struct gc_config {
       	unsigned long big_pack_threshold;
       	unsigned long max_delta_cache_size;
       };
     +@@ builtin/gc.c: static int keep_one_pack(struct string_list_item *item, void *data UNUSED)
     + static void add_repack_all_option(struct gc_config *cfg,
     + 				  struct string_list *keep_pack)
     + {
     +-	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now"))
     ++	if (cfg->prune_expire && !strcmp(cfg->prune_expire, "now")
     ++		&& !(cfg->cruft_packs && cfg->repack_expire_to))
     + 		strvec_push(&repack, "-a");
     + 	else if (cfg->cruft_packs) {
     + 		strvec_push(&repack, "--cruft");
      @@ builtin/gc.c: static void add_repack_all_option(struct gc_config *cfg,
       		if (cfg->max_cruft_size)
       			strvec_pushf(&repack, "--max-cruft-size=%lu",
 2:  579757957d2 < -:  ----------- fix(gc): make --prune=now compatible with --expire-to


 Documentation/git-gc.txt | 6 ++++++
 builtin/gc.c             | 9 +++++++--
 t/t6500-gc.sh            | 6 ++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

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
