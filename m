Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290602;
	b=mkZ3A9nEXNRYBzrDujfVPaF1CRoAeN8CUdNren60Gy0Jgb8VjMP6hYNcmHY+ATnqKnmI
	 Xm09vEOTak3oPPvv6SxNuRpoOGOz57pbv+hJZd2D41sMcngrhVdgDIsT46M2HS9FAkIsj
	 LIkAuzcHXAYIaD2Hc5kUpLO6LHiA49LfNVRfK8RervYJb7j8sbNEFCofAQSTh/uiXTqsa
	 ecmbe/QxkzJv3GXRR3/EiX/x3Mssxwkyx2PmRZll9sp0AjB1FAO/rDJ2dSvOpaLnACosq
	 VFj8mtBviXmO3KSRcncP4LdLPe7OLY/3DAjdbJBiFONavS8bPQ8nmhUauSdGxrZcE2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290602;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=2wTndCBE7njhbblJXXVAKjk5HQmpc9EqReaYseljJqg=;
	b=hOjQM/SYvQgPg2PPXxoGOfu4Cid6qiW8BnJIWy0tjNbiSBQvGDfVvhafiL/dDjBkHYx5
	 SUqsqBPnX2xh52aK8LcxfmOOGL4cHie+XDJKWi1KX1uQigqjqEHZrmzphJVFZq83B619u
	 XqFCtDCnL4TzUtScwAGZ9M/CwiPiLRZM7005Q/UeABi8okPrb9UOCtI+a7GEAR6aUTtWb
	 iTq8wC8kbtWh0A5K9jtiHw3cDibnFz53F700y4NlBj0ftk37j3/hVJuEAGh5H2KZ7xIFW
	 lYCxZCn6dpb28sqeroKtymNkKgivA7AInGR6NvvREn4nrEDQDYkQyFzMLhSg40zdCmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=maFPkMsN;
	arc=none smtp.remote-ip=209.85.167.169
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6AD606A321
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 06:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B6AD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=maFPkMsN
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-55e02e89f78so487633b6e.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 22:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794290601; x=1794895401; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2wTndCBE7njhbblJXXVAKjk5HQmpc9EqReaYseljJqg=;
        b=maFPkMsNtKYt8PlsURCflUP3G9yQzEUHIewWXk919vConyTA6LcSC+UYUYm/kk6r7w
         Jc7/RhJabDpkDGrTMDl3d4CHMkaeUqJI9AJio+dqENKv54rZlvWTnv1YQImBaMY7sdxD
         fzIS1mDpjLidYBuxnWrEOhAv+kOrK1h64Bc9UuUYdODnB1J7m2VnMiA9eV0XREyegztd
         3n3i06LmWv3+t8qPpP+EqBI/CQgywbFMAuB5oVaIbaUXmZGSW7FzyyQbhfs/3/SNXO1h
         XswyV5Ao9BAzpRN7FqN9QWnO96wExLAQ1ldDCQoyUWzc1S0SRkmmLyCrTsWlFxWWEU5U
         Z5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794290601; x=1794895401;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wTndCBE7njhbblJXXVAKjk5HQmpc9EqReaYseljJqg=;
        b=jfJgyWlG+uwcumjWfBOTATvZGAF4fXeuYre/SZ8yJ89rFHZnZbmJWm+oR4X0+eGvyb
         fKBwEqprZtKx3uSU1+7C/xWm+0rXDdFKJANTkEU3goDqP2ru1ywktT0c6Gt6Uuj3ODi2
         LV6pbcYfD+YtA0OBNqLWcf0wH49+UOW/SifRQzY6D8ZkJuc1jGlqsCToNVm4vKzBSXJQ
         n5yo/gdV3N3YiDIPasWqt/lQb7B3hIOiwhKR4F6jP0zlV1+jFG29z1F+UbxXXl+l+N33
         56k+/Ah2IYF9Uli1g3HTY4iY7Cc6EtfHkDpWSq5zpW0DztbW9DpSp1Y7Cta/T0PxvN+1
         pRnA==
X-Gm-Message-State: APuU4Z+8roq6OYlzupKejEz4cVsiF4dpzxtyHacLV9cnO12xwxDQ6vxK
	UAM8qLIC4gqm2klOVG9nxCoTfqA6p8ptSH1ygopOtIK37rDWagU2y7jWUo8LWUxw
X-Gm-Gg: AYBFou3WhVnHvSghvziuPB7vU+ek0I3DM8lTIXhxvBTyodrjCPbFikNfDIC/1tIdPKR
	mdXh7EP4y6QxxVDTFDWEG8zoVcLixwTzpeBH0yvcGkcxXUT40iTKLeVmxAN25mGLAM5SzvtkhlF
	D6yO2Be0ymKUjfioFY1pL+w6UQo51uCkXxb3/tlVQi3/RlW7m0UpSh+ArAMj0Tnx80Fo3iUlhJf
	ZnVLLh6mDoYTAJply/OLNb9DLeHMfFiMEqwSsN7PSVxWIbUUQUKqxHb62UkiUvTwvLLQAg6/XTG
	lXFPpxooIGSnsaUncbWxbN8nDueTzd6pmJ1USC3AwCxoLCjuwCVQ2RKLxeIC9J9s8GsFWBSQA1Q
	oAsz5HWQF0QHPj4J8rkdgxHMPW0z2tFlAxaGisaSBRX9Ck8OXs9ZeDaV66nfT5bA24fODUdN+Bx
	2bVuQWy6nitGgEWl/htHMalMgbADREv8L+c2Ep73BRv6K9VT8Q/hnAZDKN4EATw2jTaIeuCYO+h
	PiSDJBJZ/uG+So56PUoe5NhA43rRSFncFuUmeKgxCE2+KIek06H99pyc6QGDy5Znd8JuUuzxIrk
	LSD1EKoo0BVlPkcn1TWMtYK1xwYg/Mq4Y9vAh7kcOZTk+58NdbCH
X-Received: by 2002:a05:6808:179f:b0:4f5:4ce8:7e92 with SMTP id 5614622812f47-5683cd6f121mr1514929b6e.48.1794290601246;
        Mon, 09 Nov 2026 22:03:21 -0800 (PST)
Received: from [127.0.0.1] ([20.83.54.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905f39c60sm1289709b6e.14.2026.11.09.22.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 22:03:19 -0800 (PST)
Message-Id: <pull.2305.v2.git.1794290598.gitgitgadget@gmail.com>
In-Reply-To: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
References: <pull.2305.git.1794251100.gitgitgadget@gmail.com>
From: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 06:03:16 +0000
Subject: [PATCH v2 0/2] [Outreachy PATCH] archive: remove USE_THE_REPOSITORY_VARIABLE from archival
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
Cc: Srujith A Poojary <poojarysrujith@gmail.com>

Refactored archive-tar.c, archive-zip.c, archive.c, and supporting files to
use explicit struct repository *repo pointers instead of global repository
variables.

Srujith A Poojary (2):
  submodule: use the submodule repository to abbreviate commits
  archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules

 archive-tar.c                    |  5 ++---
 builtin/archive.c                |  1 +
 submodule.c                      |  5 +++--
 t/t4041-diff-submodule-option.sh | 23 +++++++++++++++++++++++
 4 files changed, 29 insertions(+), 5 deletions(-)


base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2305%2Fpoojarysrujith%2Farchive-libification-refactor-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2305/poojarysrujith/archive-libification-refactor-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2305

Range-diff vs v1:

 1:  01c3cc2573 = 1:  01c3cc2573 submodule: use the submodule repository to abbreviate commits
 2:  eeed27222b ! 2:  3d8d9a9261 archive: remove USE_THE_REPOSITORY_VARIABLE from archival modules
     @@ Commit message
      
       ## archive-tar.c ##
      @@
     -  * Copyright (c) 2005, 2006 Rene Scharfe
        */
       
     --#define USE_THE_REPOSITORY_VARIABLE
     + #define USE_THE_REPOSITORY_VARIABLE
      -
       #include "git-compat-util.h"
       #include "config.h"
     @@ archive-tar.c: static void write_global_extended_header(struct archiver_args *ar
       		strbuf_append_ext_header_uint(&ext_header, "mtime",
       					      args->time);
      @@ archive-tar.c: static struct archiver tar_archiver = {
     - 	.flags = ARCHIVER_REMOTE,
     - };
     - 
     --void init_tar_archiver(void)
     -+void init_tar_archiver(struct repository *repo)
     + void init_tar_archiver(void)
       {
       	int i;
     ++	repo_config(the_repository, git_tar_config, NULL);
       	register_archiver(&tar_archiver);
     -@@ archive-tar.c: void init_tar_archiver(void)
     + 
     + 	tar_filter_config("tar.tgz.command", internal_gzip_command, NULL);
       	tar_filter_config("tar.tgz.remote", "true", NULL);
       	tar_filter_config("tar.tar.gz.command", internal_gzip_command, NULL);
       	tar_filter_config("tar.tar.gz.remote", "true", NULL);
      -	repo_config(the_repository, git_tar_config, NULL);
     -+	repo_config(repo, git_tar_config, NULL);
       	for (i = 0; i < nr_tar_filters; i++) {
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
     - ## archive.c ##
     -@@ archive.c: void register_archiver(struct archiver *ar)
     - 	archivers[nr_archivers++] = ar;
     - }
     - 
     --void init_archivers(void)
     -+void init_archivers(struct repository *repo)
     - {
     --	init_tar_archiver();
     --	init_zip_archiver();
     -+	init_tar_archiver(repo);
     -+	init_zip_archiver(repo);
     - }
     - 
     - static void format_subst(const struct commit *commit,
     -
     - ## archive.h ##
     -@@ archive.h: struct archiver {
     - };
     - void register_archiver(struct archiver *);
     - 
     --void init_tar_archiver(void);
     --void init_zip_archiver(void);
     --void init_archivers(void);
     -+void init_tar_archiver(struct repository *repo);
     -+void init_zip_archiver(struct repository *repo);
     -+void init_archivers(struct repository *repo);
     - 
     - typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
     - 					const struct object_id *oid,
     -
       ## builtin/archive.c ##
      @@
        * Copyright (c) 2006 Franck Bui-Huu
     @@ builtin/archive.c
       #include "builtin.h"
       #include "archive.h"
       #include "gettext.h"
     -@@ builtin/archive.c: int cmd_archive(int argc,
     - 	argc = parse_options(argc, argv, prefix, local_opts, NULL,
     - 			     PARSE_OPT_KEEP_ALL);
     - 
     --	init_archivers();
     -+	init_archivers(the_repository);
     - 
     - 	if (output)
     - 		create_output_file(output);
     -
     - ## builtin/upload-archive.c ##
     -@@ builtin/upload-archive.c: int cmd_upload_archive_writer(int argc,
     - 	if (!enter_repo(the_repository, argv[1], 0))
     - 		die("'%s' does not appear to be a git repository", argv[1]);
     - 
     --	init_archivers();
     -+	init_archivers(the_repository);
     - 
     - 	/* put received options in sent_argv[] */
     - 	strvec_push(&sent_argv, "git-upload-archive");
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

-- 
gitgitgadget
