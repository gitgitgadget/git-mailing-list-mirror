Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794251106;
	b=ubyWgg+5Yo0gGLnblSckl3eiCpDbu150aVglJV5qDzQRO6M5bnoaLRQmeXdHHYBwsf1w
	 xAudEYGbu1FgGiftkki4kAgRp5Di6DGNgEjm98pEE1WczvGQir8dZ3KUPw5ssdb7OhS89
	 rmcixNKCI4Hx/OtN/oGRKxXDU07gL3ToB23MPk8DN8mm6Lg6yGL1zEW0NR7DVmrkscmOT
	 nQV99uQAuGwVyEb0sE1RDhsGQPeXiVvcidlB+8LHoqHtWgFAV3fmbT24WsViJB+UFCAVl
	 PM255ANOc0pdpgGRvHwLrxe6onvBF/+emeBOyjl1rRVqEfQptayxDP4crs2PUfWw2Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794251106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=e3yqzy3x+p7n+vWx8L6XajlcBfzaIy26LsvdapSVJ/c=;
	b=ii3VgTWcqj9QyFTXYK/26yMO7/B7QJT0h2qNtKG9q/vw0vcWUEPztF9yGHUaoMHDNq00
	 2yJcvq1ai6n+MVD0LPFKFR2pCStXsWl7mSCjDEkucEzyPHpFIea5px1S6qldPwuZQprJi
	 mizZp8EdhfFbZA0/yI7x2ywwv/a7IUa9NxARQZtmLA3aS7Cz5xYSTjFXwbSEYOoW+oxtL
	 a0UZUmqSOCn8XPPCaLI1u5fIgbqFyB9W/CORggpxnfg+ba0NE9603FfXY/0JJCVPGzFIN
	 +iuYJm2tCCDQtjEXURi9b7HBZ/cHVXZ+tM3uJnPOr70c8JQeTzn2DHnfWLqPXEzotag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNk7LQ6a;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEEE60A5BC3
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 19:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EEEE60A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PNk7LQ6a
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36fb88ea38cso1537192eec.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 11:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794251105; x=1794855905; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e3yqzy3x+p7n+vWx8L6XajlcBfzaIy26LsvdapSVJ/c=;
        b=PNk7LQ6aADnLTkxG3PLPcTYoZg0EG3K/bNti+oedpm0xWOtuwuyucE3R/dfMP5fSeI
         YusTTEDkjEW5v2mFKo1/FUIqz70w0DbEh6ohJSHGhtz40Kh5drC+qf+LVk9dRl/0QdU7
         DC49weEseOM3WPAZgfJnMRfBRKvHMOEiQ3VFbQ0jc9WPbcA/+hvLoB7oQI07zxln7CX9
         WR5lNOSGg5s2tzLxD7bbQQhhK+WgO+rP+Zv9cXMufcQBCrNnqnKidxeD/nkSh5qaQpLr
         bKDM+0Ac77yHNAsC2NxuIPwEK9lOfBfOX78Ow2kud1ylppfz4gKOgWYWyshVMeGwc1gf
         Ju1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794251105; x=1794855905;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e3yqzy3x+p7n+vWx8L6XajlcBfzaIy26LsvdapSVJ/c=;
        b=Y+uAT35ey5zkAHmur1qyDINdTAdX+BzOMJqIajuR9y9/qZl8aktsNOooLK1Jlxq4ku
         g/shDLPSI3vlkHF0i3X34bOp3OebmdC2H0MnBKRu1gZn7DnUjMHaJGf3FsirWbi+2bl0
         ZuwdnhKZ+I5qXkWBOt8yBlVPFXsldhPDKbIZhjktNo6AxnmT5/XYm/KMhCwOVQv5fVum
         ULRdupE31FJPs7LGFbxcAyJ8HVXmHTBRDD1EfyTZyK8PG+Kd+wGonCJqLdP/1sQu1D4g
         BrEIx5ciFZyhP7GsjINA2Z7wdO4M8akIVPpztD3QZQ9815m19EYsOZV6pIvnNYiymW54
         yuAw==
X-Gm-Message-State: APuU4Z+o++SUZtRl30GNiZBWoLLlKN16qcUZtFvTNsUeAjkMj//KwEBq
	K/tDaKxq/e3olNdae6ir+xwxWIn9lBtDLTCXLmLGFx+2aItiPwMedH4JPsLGEw==
X-Gm-Gg: AYBFou0idVD9xj9rHov3uEOwR5UoYbBcmG6otF3H5WgSCeYxOnzwlEMROID0Wr8ZyUw
	XD7twtX7HYWsxbcaYUkVtNMGoZfVo63+wk3PFkqIiCyhrCTqNCfPM1nSUh/vp7DIjXdXpKIxSAq
	aKk7Ylcp+eh0tWH7ZT69zHjlf8N9jXSgO70rwBDtjt/AtrJBH5hUZ7OufHSdW17XsbgKxhDEPwD
	CZbT71H4052BAjeh2QLRb44RcuvTmw87ANeJuxoPKFpxGsyISd6XKRSgy5tRL+8BpvS0rZzOO6C
	1y6dDEO6cfRUOfuI7KHZqJowQinswnHrzI/4m+zgd30KThDRISFBrc5SWay4e38V12eGiDnBLKF
	+F00TN2gYC4xp3xwUt7G/hIwM3xSZMKfo3CCNNjwiGS6Bo93k3qVc2RMv0OnNBHbNrI9bnJeaHI
	onm4a5yyrWmtFCqbGEke2z1csL1D4CTME+qv7JWj+g1Fyf9R8YIz1EPuEIEwdXOL9NbtNMkt6S2
	Kyf1QhSQbeaugH5Im4KedHdvjZDl4Yn7K7LvluVh6rPw4BLOTb+7K6zvE+AM3kVecNhBhsYogyO
	y+CH0GFBntIJRajdfUKonXmpuX3lx2Y=
X-Received: by 2002:a05:693c:6390:10b0:371:197b:5ade with SMTP id 5a478bee46e88-375095369b6mr507236eec.11.1794251105149;
        Mon, 09 Nov 2026 11:05:05 -0800 (PST)
Received: from [127.0.0.1] ([40.65.61.38])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3751ff2ab59sm290031eec.6.2026.11.09.11.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:05:04 -0800 (PST)
Message-Id: <eeed27222be51590775352e5a3b7677e21d36a93.1794251100.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 09 Nov 2026 19:05:00 +0000
Subject: [PATCH 2/2] archive: remove USE_THE_REPOSITORY_VARIABLE from archival
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

Refactor archival modules (archive-tar.c, archive-zip.c, archive.c,
builtin/archive.c, builtin/upload-archive.c, and diagnose.c) to accept
and pass explicit struct repository * pointers instead of relying on
global repository state.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
 archive-tar.c            | 8 +++-----
 archive-zip.c            | 3 ++-
 archive.c                | 6 +++---
 archive.h                | 6 +++---
 builtin/archive.c        | 3 ++-
 builtin/upload-archive.c | 2 +-
 diagnose.c               | 2 +-
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index a1c66024d4..9697fb2153 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -2,8 +2,6 @@
  * Copyright (c) 2005, 2006 Rene Scharfe
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "config.h"
 #include "gettext.h"
@@ -337,7 +335,7 @@ static void write_global_extended_header(struct archiver_args *args)
 	if (oid)
 		strbuf_append_ext_header(&ext_header, "comment",
 					 oid_to_hex(oid),
-					 the_hash_algo->hexsz);
+					 args->repo->hash_algo->hexsz);
 	if (args->time > USTAR_MAX_MTIME) {
 		strbuf_append_ext_header_uint(&ext_header, "mtime",
 					      args->time);
@@ -526,7 +524,7 @@ static struct archiver tar_archiver = {
 	.flags = ARCHIVER_REMOTE,
 };
 
-void init_tar_archiver(void)
+void init_tar_archiver(struct repository *repo)
 {
 	int i;
 	register_archiver(&tar_archiver);
@@ -535,7 +533,7 @@ void init_tar_archiver(void)
 	tar_filter_config("tar.tgz.remote", "true", NULL);
 	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
 	tar_filter_config("tar.tar.gz.remote", "true", NULL);
-	repo_config(the_repository, git_tar_config, NULL);
+	repo_config(repo, git_tar_config, NULL);
 	for (i = 0; i < nr_tar_filters; i++) {
 		/* omit any filters that never had a command configured */
 		if (tar_filters[i]->filter_command)
diff --git a/archive-zip.c b/archive-zip.c
index 785689584c..dba2247f6b 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -653,7 +653,8 @@ static struct archiver zip_archiver = {
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
index 3c1288a123..e35b9637ce 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -2,6 +2,7 @@
  * Copyright (c) 2006 Franck Bui-Huu
  * Copyright (c) 2006 Rene Scharfe
  */
+#define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "archive.h"
 #include "gettext.h"
@@ -97,7 +98,7 @@ int cmd_archive(int argc,
 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
 			     PARSE_OPT_KEEP_ALL);
 
-	init_archivers();
+	init_archivers(the_repository);
 
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
-- 
gitgitgadget
