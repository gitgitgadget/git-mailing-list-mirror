Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794465192;
	b=AWCcwmAE/kC9iiEa5MeR/gVzJuaarttX+kgI+oUkJpSTMsd88xQd+Gkh2nMFkPPpEBg0
	 Tx/t0Zk3gGRzMdBNyfAZdCEDXmbT2Jsl3pbxMuf5/I9toASR1Tfl8G85ppowreoo+U8Ny
	 by+EwuNt3QJCgHOhq7VkwmiM9X9wKAg7N+fl4XtSAJ2s4Yb+luleGvern/hyRQ7JApkdJ
	 vubStbqfJZluK+qHD+l1kQtjYobnTa86Xf5AidMbp6Nt72zX1yjqAxIJ79SulQR6liIOk
	 u5G3VBqvH+UT7nrmsEmFbKrCKiDNiZcP7cKqb2FcBwSuL9BwtwxbfDxh1OQYI9tB+Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794465192;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=Qtoj606j6rFnpVRO77nTGjkI7nzW/pv8LuPgpe1eaZ0=;
	b=zDs98hioHKyB2VafHclY5SchFwRFyVe6YH5BMq2aPDRu73CIQDpCCHA4D9XXEbp6Kwpg
	 UPKAr7Ynn+ODerpfUOaw38sd61Gm0NGGXpI9qkkgb64uFMKZplDcd9kk8j4oQIkWXCRVk
	 sr2bhFdC1JNyBNiAYj/o+BfdWxWnsezGGn/UYuKk61O2k8N0ebeBod+2i8DTjvUr2Ji42
	 NYUFgoGztgJpsQ240n0YxtJQyoAh2mfyB8vP8BrE18IZWOZ4yeQowsib7Tmf5xBUvhFYP
	 x2WJd4a4ZOyo7kT63aRY3VXsY4oEHK5b27MlA8zFkpKWj7i6lVT7qV3XHCjLzqkNfPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k39L8EJ4;
	arc=none smtp.remote-ip=209.85.161.54
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4D606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 06:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66E4D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k39L8EJ4
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6d68de53053so2552460eaf.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2026 22:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794465191; x=1795069991; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qtoj606j6rFnpVRO77nTGjkI7nzW/pv8LuPgpe1eaZ0=;
        b=k39L8EJ4cWh0OgQSJSD0/ChnW3ZVibbb0u/TisMwh6xTSSJSz9P2lHWfBP5T0VjDfL
         yR7pVWxpxbaCHAyO4sAfUYPzc8kHHNGZKyIP4qrNBhOeFzE8DelyCh4ogH5kTaPvYfiv
         GdUerU0LiGM4aTcU4eP2A/ZtI5K7PVgORvMPORHmjAACfB0o61ZgsGOvZSTIFkHfK/2o
         rmvQPGoEu5qfItyRithshzf3uE6gsK733iLIctCRCxYdlCwXIqGMb1CsVfPynMBFMNQs
         tsRFSBsrmz3OCZM2TGL3PC3ZuVqyWq2as1h0yhpaTmKTocN2VcwCzcBV5+ZYeg6nhB7I
         A9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794465191; x=1795069991;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Qtoj606j6rFnpVRO77nTGjkI7nzW/pv8LuPgpe1eaZ0=;
        b=k6r/J0wvL0TOp2YvdxgvQoSTPlkWZCtS/Cld3kxKfXVYAQix6aAkgi882+ARwoJbsU
         OoELZeUros6a8ecsO77w0Q2kElxgUsVwc5M3+draWmO4GE4+1BCVb1ZsSMxnJktDBTF0
         +s5OAsenpY8EiuDRBudvU707luD5sYMofUk3gSSEFBjScyX5oDiyB/MPp7qYcyZcS913
         XT6UJijhqeuWM9H7SZemxW5/AhCDMHlBc26jOJHlAbkK5bzM14B099sM214UBRpatk8z
         l/PdxCxLkiAmLXlfBNCFu2zIM1lfWSL3aYE8ApmFk7rvZQw+PcXpqeFxcecOFtRgsFCt
         H2xA==
X-Gm-Message-State: APuU4Z+SsG29+jQCtIhDTixXz+lJoDZ+ULGeAesDGWlos4Bf/fYmtizR
	UOwwyFmGaTyoHJj5mdCE+69Ksl6nWHRWAFK9YVMQ0MxBWlWuG/A8m3ncwEnbfA==
X-Gm-Gg: AYBFou1scQ4PWOukpM0E8w72B0L5OeTMQbLq2e+3IpA5wTIToH2/cXploeSCEH8x8RC
	14olTQiSbZiA7IM0bA3hG8rkTLHVOCp+4lbDSoRxSQG8CNq4poVWVpOcW9bPDPxJ8RPRRv9mKAy
	KRPZhccT0T3O26VqH3KAQcpdV9/QsE7AuB/Q2Jr4apUMKEYLJ63QCMuDYQh3WwfgAnXJnkyHAeO
	vCV5GKrKpazUl/uca36ksYBm2NI8G74HxULM2cOIumhpKoC0bCHXiPDhFvWuwbjk4ByekH4DSmL
	R/RsemEFpvs1b7kK+jX1+hUAHBWtMq5iI8h4ahUW3RMnijCe+jKFBz4Ph3dVOw4ydtGJwknRkQj
	Vx2dmJzhbdrdIJKGsKRckrPvSeJ/itpR/B5YHVdSW+b5+F96LPuNvjhVdM6+FDtMlj85waQsRMi
	fm8nAf/p3Amh4iCUcXhhtEvmRYjox7cth2RHMy4yx8ny4l7W9odUtagQOGBddnFbbzbJBlAhuUp
	VfB15nk0r0AI9c6B55FuFwS26NxVADgTJNMafBfm8fdY0ClfZc4K902bWo0mX0VxHL7bnmBpdS9
	PL/wBFjUFqUBJKybe3GH5BnSFDebnpIxBg==
X-Received: by 2002:a05:6820:7094:10b0:716:cfac:bc32 with SMTP id 006d021491bc7-7191798d728mr1977712eaf.71.1794465191139;
        Wed, 11 Nov 2026 22:33:11 -0800 (PST)
Received: from [127.0.0.1] ([135.233.118.84])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71a7b115cb5sm93135eaf.12.2026.11.11.22.33.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 22:33:09 -0800 (PST)
Message-Id: <pull.2308.git.1794465188325.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 12 Nov 2026 06:33:08 +0000
Subject: [PATCH] archive: remove USE_THE_REPOSITORY_VARIABLE from archival
 modules
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Refactor archive-tar.c, archive-zip.c, archive.c, builtin/archive.c,
builtin/upload-archive.c, and diagnose.c to accept and pass explicit
struct repository pointers instead of relying on global repository state.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2308%2Fpoojarysrujith%2Farchive-refactor-clean-v1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2308/poojarysrujith/archive-refactor-clean-v1-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2308

 archive-tar.c            | 7 +++----
 archive-zip.c            | 3 ++-
 archive.c                | 6 +++---
 archive.h                | 6 +++---
 builtin/archive.c        | 2 +-
 builtin/upload-archive.c | 2 +-
 diagnose.c               | 2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..5243446701 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -2,7 +2,6 @@
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 
 #include "git-compat-util.h"
 #include "config.h"
@@ -337,7 +336,7 @@ static void write_global_extended_header(struct archiver_args *args)
 	if (oid)
 		strbuf_append_ext_header(&ext_header, "comment",
 					 oid_to_hex(oid),
-					 the_hash_algo->hexsz);
+					 args->repo->hash_algo->hexsz);
 	if (args->time > USTAR_MAX_MTIME) {
 		strbuf_append_ext_header_uint(&ext_header, "mtime",
 					      args->time);
@@ -526,7 +525,7 @@ static struct archiver tar_archiver = {
 	.flags = ARCHIVER_REMOTE,
 };
 
-void init_tar_archiver(void)
+void init_tar_archiver(struct repository *repo)
 {
 	int i;
 	register_archiver(&tar_archiver);
@@ -535,7 +534,7 @@ void init_tar_archiver(void)
 	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
-	repo_config(the_repository, git_tar_config, NULL);
+	repo_config(repo, git_tar_config, NULL);
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
 		if (tar_filters[i]->filter_command)
diff --git a/archive-zip.c b/archive-zip.c
index 279c3a2d72..b02fb9be38 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -655,7 +655,8 @@ static struct archiver zip_archiver = {
 	.flags = ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE,
 };
 
-void init_zip_archiver(void)
+void init_zip_archiver(struct repository *repo)
 {
+	(void)repo;
 	register_archiver(&zip_archiver);
 }
diff --git a/archive.c b/archive.c
index 59790be986..e9e2e241c3 100644
--- a/archive.c
+++ b/archive.c
@@ -43,10 +43,10 @@ void register_archiver(struct archiver *ar)
 	archivers[nr_archivers++] = ar;
 }
 
-void init_archivers(void)
+void init_archivers(struct repository *repo)
 {
-	init_tar_archiver();
-	init_zip_archiver();
+	init_tar_archiver(repo);
+	init_zip_archiver(repo);
 }
 
 static void format_subst(const struct commit *commit,
diff --git a/archive.h b/archive.h
index bbe65ba0f9..8ec59b22e9 100644
--- a/archive.h
+++ b/archive.h
@@ -48,9 +48,9 @@ struct archiver {
 };
 void register_archiver(struct archiver *);
 
-void init_tar_archiver(void);
-void init_zip_archiver(void);
-void init_archivers(void);
+void init_tar_archiver(struct repository *repo);
+void init_zip_archiver(struct repository *repo);
+void init_archivers(struct repository *repo);
 
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					const struct object_id *oid,
diff --git a/builtin/archive.c b/builtin/archive.c
index 3c1288a123..2c01d7b6e7 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -97,7 +97,7 @@ int cmd_archive(int argc,
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
-	init_archivers();
+	init_archivers(repo);
 
 	if (output)
 		create_output_file(output);
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 718e74b3ac..3cfc7ffaf3 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -34,7 +34,7 @@ int cmd_upload_archive_writer(int argc,
 	if (!enter_repo(the_repository, argv[1], 0))
 		die("'%s' does not appear to be a git repository", argv[1]);
 
-	init_archivers();
+	init_archivers(the_repository);
 
 	/* put received options in sent_argv[] */
 	strvec_push(&sent_argv, "git-upload-archive");
diff --git a/diagnose.c b/diagnose.c
index 2c1bcfe431..c642dde351 100644
--- a/diagnose.c
+++ b/diagnose.c
@@ -212,7 +212,7 @@ int create_diagnostics_archive(struct repository *r,
 		goto diagnose_cleanup;
 	}
 
-	init_zip_archiver();
+	init_zip_archiver(r);
 	strvec_pushl(&archiver_args, "git-diagnose", "--format=zip", NULL);
 
 	strbuf_reset(&buf);

base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
gitgitgadget
