Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717329;
	b=5hX2qHrK0c7YNRhmFI/DcVNa4FRpxhU+18rThJsYs5BZEWLnYqohsO6mUALxSollcGaT
	 /Kfy4b6Ff6GX74cMwuGxVjfQ7QUBH6ERoXAvUhWJbpFyuSk+tvcQR90jbJSWa8jMa8wIP
	 c+tf4jjyAyPQNoLPD1nTlB3X0AJh9tHnttV7XjTrgJkAORGUPIDHZhxVzlJDlTHpRcUJm
	 frUhVZ12o6Dygi20EB+m3K5pJvBzbSMVkPSR8ci+wbIl6C0CmiAs522pNZLYOwTx5c0b1
	 nzE34zPX3oNRAohAajyCoyD4/an+EcgWel7nKZUW+8m+tJxwOy7Pwyazlw+5fmoVBfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=lYjhJYIjW/DV4WlcFPIWg8fDepXxqujzUmgqbDmXY84=;
	b=wJiDO3RMH2yI5gZRrFt75EshQqSTqFueB8Or5wAiski3l1Fib5yKv6Sg3XvXPhPREt9U
	 U0llrqphGBIMkUmZhncyZIurzuwYsqRWRmgPFy3oG82YcofYqx2siaFpx8w4mviUtIcPV
	 7gpMKwAUEq6CzVtMDlGq38IQ1iXs0+WS4MKfwf+YFUAODOpE0qTa+inbmYrk2y6CGLQsi
	 xbgAm47AwfCOcg20o1vVuK5xZC9Zs7PaeET3PvGvlvJrXJi5KAKMaa9mnrgspBwT5lqZR
	 yrDY2LN9QtQtcm82LZlmF+JCitruK+S37B3u29HjXPP2mxnQAErYO815b3vLXkwKoeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jxsdH/wc";
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EAF606A323
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 04:35:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10EAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jxsdH/wc
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e9e53d011eso24404975ad.1
        for <git@vger.kernel.org>; Sat, 14 Nov 2026 20:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794717328; x=1795322128; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lYjhJYIjW/DV4WlcFPIWg8fDepXxqujzUmgqbDmXY84=;
        b=jxsdH/wcHlBnpOmZX2ziUOdMQIpZ5FA7w/EtoYpuxS8kKpaFw4bVIPc0TMFUoXg2id
         PBbz/RxFk+X5S1yvuZK4w5moWq014/psznQmXCK2TNhuT/DXq7EvtFRf6uqK9uYSEF5C
         jpI6iQaUjrHuJ4glu2CVTTYI1biDpRi2nRxkm9gYsq9PnYyQYMKYtW5Iee3ntf9Ju39J
         kdzGfrspJpKK/mdk8kSufEHgf2twqvYxTsEqHzc4u0uTyZ1mRIyu5PjdAm9RsV97J3GG
         uxjtenow1Ckun3nF87b6W+sw0pHCmbxW6w+qlswkp/y3sP8AUvY3ofNWG8udGCdOCEEW
         KNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794717328; x=1795322128;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lYjhJYIjW/DV4WlcFPIWg8fDepXxqujzUmgqbDmXY84=;
        b=v3N3LW7IEPuJI+HgvQR8QRXqNsC6Lk/GawAhU/w43qscURmMfg8U1VHk9upACMgtoV
         AxdqHicYnLVaVD08a3pP2iRVzArYOLXPtCg+mnqqvCiijMgwUjKXAhxQej/i/mqj9bnS
         Z409G/NfcxnfZqlxtc1dDljs2oLezcRbEU42zFc1OsFqMlgcIqCXmQyQrdg3Lr/pwoEb
         /lAhrWGxsir4ybqZUF1+ti/2y+B5HfBqU9JtEbJi6FihdkAF1NAYhy5QFrqhyzsNQ7nr
         4fGy3W64fbJQsaKbCZyWbJXuajtyZVeDYYQ3G2NM42puWq5WnisSbcfzbf+BF3bUZlef
         Odqg==
X-Gm-Message-State: APuU4Z+t5b1ge5sG0w7J5gAHHa0SKQ2CznFDAM/ftAc9Ejmsn6AB3Inb
	bVDX9G0eAEZA7iXfdj2uz7qS4VFDC2+H77r6vCXiGe0j42616E+FSrzffUFtPw==
X-Gm-Gg: AYBFou3ODObYqe16QmaZG6mw1rf8z/3XZ/E6y7CXmDl+CjEyZdNCgLvOYrz4xHBBrPW
	S5nfuTcpWZCIq2VrGiIu+atyJj7mBldhjRrZUhR2LXYjg5yZEIBgMHTEhvzu9qdDzvi3Wd7wEvG
	tNByDWQM8UmIf33iRDrt3GRcvs+Q5wvQ/muXg0/M6/H0wXCR0PHq3ebaOBKZd3ufoWnJ2A6YrD2
	EZqYjCGnPUNHAYKOYuIZ/Tn1BBpCjlioumZA8C2Ku0vLXjB6mJwqx2bQgE2ocXYbYn4nstEqDvs
	6Rb/PKltltXw/6nV2eXyre6MFiQ5xmuhKo854tAwMgYfSVzRBGPCogvuzs6umCFjWpYCBu6HuIl
	sVSVRzXCvh6R3GCw948P18ga/FdEj7uSpXicocJPYRI8Rs6WlYVkkpGarITu6l5WgwSIbHr6D0t
	flpcLtx9hcX1cNwJ0NMZupS2pN6IXN5pyDf7jBhpbor+9Ntq4xzGJGF61ch6ofKwGJlz0UK5LO/
	gU8faQQYL5wbPMSvT5VbadXMzD2ZxO4uL1clTo5QEoq32SxEBw0kNTrspqGhCZkAk3zGxNvsXre
	9bUhzeN+7UskB3rYAblewj7i1CUGLw8c
X-Received: by 2002:a17:902:d550:b0:2e9:6f2c:71b9 with SMTP id d9443c01a7336-2ee0d6654a8mr68937035ad.1.1794717328285;
        Sat, 14 Nov 2026 20:35:28 -0800 (PST)
Received: from [127.0.0.1] ([4.155.252.116])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ee0f4b0839sm25361455ad.6.2026.11.14.20.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 20:35:27 -0800 (PST)
Message-Id: <pull.2308.v2.git.1794717327255.gitgitgadget@gmail.com>
In-Reply-To: <pull.2308.git.1794465188325.gitgitgadget@gmail.com>
References: <pull.2308.git.1794465188325.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Nov 2026 04:35:27 +0000
Subject: [PATCH v2] archive: pass explicit repository to tar archiver init
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Srujith A Poojary <poojarysrujith@gmail.com>,
    Srujith A Poojary <poojarysrujith@gmail.com>

From: Srujith A Poojary <poojarysrujith@gmail.com>

Refactor init_tar_archiver() and init_archivers() to accept and pass an
explicit struct repository pointer for tar's repository-dependent
configuration, removing USE_THE_REPOSITORY_VARIABLE from archive-tar.c.

Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
---
    archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2308%2Fpoojarysrujith%2Farchive-refactor-clean-v1-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2308/poojarysrujith/archive-refactor-clean-v1-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2308

Range-diff vs v1:

 1:  b733b5d396 ! 1:  6f0d7bf698 archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
     @@ Metadata
      Author: Srujith A Poojary <poojarysrujith@gmail.com>
      
       ## Commit message ##
     -    archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
     +    archive: pass explicit repository to tar archiver init
      
     -    Refactor archive-tar.c, archive-zip.c, archive.c, builtin/archive.c,
     -    builtin/upload-archive.c, and diagnose.c to accept and pass explicit
     -    struct repository pointers instead of relying on global repository state.
     +    Refactor init_tar_archiver() and init_archivers() to accept and pass an
     +    explicit struct repository pointer for tar's repository-dependent
     +    configuration, removing USE_THE_REPOSITORY_VARIABLE from archive-tar.c.
      
          Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
      
     @@ archive-tar.c: void init_tar_archiver(void)
       		/* omit any filters that never had a command configured */
       		if (tar_filters[i]->filter_command)
      
     - ## archive-zip.c ##
     -@@ archive-zip.c: static struct archiver zip_archiver = {
     - 	.flags = ARCHIVER_WANT_COMPRESSION_LEVELS|ARCHIVER_REMOTE,
     - };
     - 
     --void init_zip_archiver(void)
     -+void init_zip_archiver(struct repository *repo)
     - {
     -+	(void)repo;
     - 	register_archiver(&zip_archiver);
     - }
     -
       ## archive.c ##
      @@ archive.c: void register_archiver(struct archiver *ar)
       	archivers[nr_archivers++] = ar;
     @@ archive.c: void register_archiver(struct archiver *ar)
      +void init_archivers(struct repository *repo)
       {
      -	init_tar_archiver();
     --	init_zip_archiver();
      +	init_tar_archiver(repo);
     -+	init_zip_archiver(repo);
     + 	init_zip_archiver();
       }
       
     - static void format_subst(const struct commit *commit,
      
       ## archive.h ##
      @@ archive.h: struct archiver {
     @@ archive.h: struct archiver {
       void register_archiver(struct archiver *);
       
      -void init_tar_archiver(void);
     --void init_zip_archiver(void);
     --void init_archivers(void);
      +void init_tar_archiver(struct repository *repo);
     -+void init_zip_archiver(struct repository *repo);
     + void init_zip_archiver(void);
     +-void init_archivers(void);
      +void init_archivers(struct repository *repo);
       
       typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
     @@ builtin/upload-archive.c: int cmd_upload_archive_writer(int argc,
       
       	/* put received options in sent_argv[] */
       	strvec_push(&sent_argv, "git-upload-archive");
     -
     - ## diagnose.c ##
     -@@ diagnose.c: int create_diagnostics_archive(struct repository *r,
     - 		goto diagnose_cleanup;
     - 	}
     - 
     --	init_zip_archiver();
     -+	init_zip_archiver(r);
     - 	strvec_pushl(&archiver_args, "git-diagnose", "--format=zip", NULL);
     - 
     - 	strbuf_reset(&buf);


 archive-tar.c            | 7 +++----
 archive.c                | 4 ++--
 archive.h                | 4 ++--
 builtin/archive.c        | 2 +-
 builtin/upload-archive.c | 2 +-
 5 files changed, 9 insertions(+), 10 deletions(-)

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
diff --git a/archive.c b/archive.c
index 59790be986..50063c24ab 100644
--- a/archive.c
+++ b/archive.c
@@ -43,9 +43,9 @@ void register_archiver(struct archiver *ar)
 	archivers[nr_archivers++] = ar;
 }
 
-void init_archivers(void)
+void init_archivers(struct repository *repo)
 {
-	init_tar_archiver();
+	init_tar_archiver(repo);
 	init_zip_archiver();
 }
 
diff --git a/archive.h b/archive.h
index bbe65ba0f9..10d76de4c0 100644
--- a/archive.h
+++ b/archive.h
@@ -48,9 +48,9 @@ struct archiver {
 };
 void register_archiver(struct archiver *);
 
-void init_tar_archiver(void);
+void init_tar_archiver(struct repository *repo);
 void init_zip_archiver(void);
-void init_archivers(void);
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

base-commit: 1891de46f79dc444a47db1c87bd0c8c76b5463f2
-- 
gitgitgadget
