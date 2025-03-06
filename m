Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D573B18BB9C
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741271817; cv=none; b=Gj4OOfgZmefXLp/VIENl0gkDYZcm3NLCYRU0EBPwR5MwT8WeyCZRhoXJiKrDACl8BivT4JnuiIEsNQTnCFaXIrB0MSKdPbJyxEWLOzUiJ7yBznOrgqm59w8aYptDU1oigl+z0IJhkkojHx8alou7zsq4gIS1Jq+vHkuASEgdxrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741271817; c=relaxed/simple;
	bh=uyPEZR42xGEUWWqABH7AINQb5hhX4uxPZN3aXjnIdLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uw0mCQey0ZFjBrvNIM8gmERcPto12725G2IdifFf8aNWGum5vQUwHMZfzG4+7GchdMaRrN9xqy8dW5SuT6snW9lmv5dfTi6gCOxrnvf0sMwJ6WNQXazPcssl3Qa+3wm5QxiOUh46gf9uOx2LvOgj4/SOvOWt8alKqGQpNZ3FEqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aWdtrSH6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aWdtrSH6"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff187f027fso1270134a91.1
        for <git@vger.kernel.org>; Thu, 06 Mar 2025 06:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741271815; x=1741876615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mTtvDBKpgj+WV6qsVkiH+6irNu3ohNrVLzshn7Enuw=;
        b=aWdtrSH6tVuRviFmFzDCrzi7q1Ei7FKmbqBJOs1LFfODICUQLJ1U8z4G4BS9xBKoaL
         lfPvy7DFDEqxeVgM/l38xD8NzA6M/4Utp05TQa3sYb4sraMzMpFmGVxWjiqqe8b8xb1J
         5XVkJDM5g47AGG3Hm1etHyvCVbUWmViAqoQw3RBZMLnnuOW/PcDvmypvOxLwYofSbw0R
         mkX5cfE66+Rlst/AzJKHwnJWRsc8Dgpl2u+GyPS/vc3cw5Z6KNfU6GCpXvqzBZqeHEpI
         J3GMARjPLVn1e+sIgrzYZjilrByAVe8qluk8OVRDNZEIb6LbxJbCYklpTJZNhc2VuY2J
         u/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741271815; x=1741876615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4mTtvDBKpgj+WV6qsVkiH+6irNu3ohNrVLzshn7Enuw=;
        b=mENeMg2J8bQHvGMI/3Z4lfPC0+SvlVZdATU2l62arymghM1rFUlXUS/LqJt7al0uCN
         KMN26fyK79V+YoZbbO01yFFsS+Pk3QsJZlYM1yo/zHTIT+77vNLvCKliwLQYbzfT6/EF
         0WJpChu+FnLsV4lsQNFK4528ozyBWORQMMsQKgATtT7WNYlW5yeFhQaLbaGnS60ZeYSL
         2sKxs8PzHbzsUQSTz8yssHbz48JzJ7qOZL1LrzduJ4ZQVG2MxP1rbvz7SZFI4xD8/BhD
         UwheSxEHomp+QcHS4O7vmNPwx74TdO+vcNa5g8OFDWJMlb3N+ZIiu1ltzcNQqJRcQc9B
         RFsQ==
X-Gm-Message-State: AOJu0YymONeqSgE7QoNQHh9cehZcyNx8rBGUfsi5uDWjrnf9nOVq+OOK
	I2Sp6D0H7F4Rc59eR0Xk/eF7zke63nFyEmUv589OCDvuqmFPJR9QRV332GD3
X-Gm-Gg: ASbGncs9PlNd2y0yM1SdLBBdiTimbx6Pq9K/W0L+1khtP1HrZVDF6KtXq5KG0osow2k
	pdimLL7U+2A1UooPdXEdaeh6/UqesPESjSbYUFiiqCwar4UOA4OWJJD2QgCeBq5yOFh0LZrVQsY
	WF71Tyu3wMyAmrggxFCx7MCWC45Onp1YfhpIHGhoNwPU9su9qQDK8D97/9bQodr0yBoL/AEKGba
	Wq6hsVC561O6R5RB/IwpqjNIE3HI8XMwchsULH+JnbONXgU088lvmia3j8tLR6az3TLd2cSU6qZ
	343/5s2dEe3YFEWRxsCZZGw8jSsTJuztLRpw5SQZUF95RbQcUQMhWzcMhY1ykk0GX0L8OQ==
X-Google-Smtp-Source: AGHT+IG25ViNEIdgmmnC6hwVU8GfR3dBpk+6m1Y0heqsGGHX4s7148gzSWctNkVHeP1amwwLbgvRfw==
X-Received: by 2002:a17:90b:4a91:b0:2fa:3174:e344 with SMTP id 98e67ed59e1d1-2ff617d8290mr5966018a91.14.1741271814917;
        Thu, 06 Mar 2025 06:36:54 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7ff944sm3561184a91.34.2025.03.06.06.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:36:54 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: gitster@pobox.com,
	johncai86@gmail.com,
	me@ttaylorr.com,
	ps@pks.im,
	shejialuo@gmail.com,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 6/8] builtin/ls-files: stop using `the_repository`
Date: Thu,  6 Mar 2025 20:05:50 +0530
Message-ID: <20250306143629.1267358-7-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
References: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
 <20250306143629.1267358-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the_repository global variable in favor of the repository
argument that gets passed in "builtin/ls-files.c".

When `-h` is passed to the command outside a Git repository, the
`run_builtin()` will call the `cmd_ls_files()` function with `repo` set
to NULL and then early in the function, `show_usage_with_options_if_asked()`
call will give the options help and exit.

Pass the repository available in the calling context to both
`expand_objectsize()` and `show_ru_info()` to remove their
dependency on the global `the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/ls-files.c        | 32 ++++++++++++++++----------------
 t/t3004-ls-files-basic.sh |  7 +++++++
 2 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a4431429b7..70a377e9c0 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -6,7 +6,6 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 
-#define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "builtin.h"
@@ -245,12 +244,13 @@ static void show_submodule(struct repository *superproject,
 	repo_clear(&subrepo);
 }
 
-static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
+static void expand_objectsize(struct repository *repo, struct strbuf *line,
+			      const struct object_id *oid,
 			      const enum object_type type, unsigned int padded)
 {
 	if (type == OBJ_BLOB) {
 		unsigned long size;
-		if (oid_object_info(the_repository, oid, &size) < 0)
+		if (oid_object_info(repo, oid, &size) < 0)
 			die(_("could not get object info about '%s'"),
 			    oid_to_hex(oid));
 		if (padded)
@@ -283,10 +283,10 @@ static void show_ce_fmt(struct repository *repo, const struct cache_entry *ce,
 		else if (skip_prefix(format, "(objecttype)", &format))
 			strbuf_addstr(&sb, type_name(object_type(ce->ce_mode)));
 		else if (skip_prefix(format, "(objectsize:padded)", &format))
-			expand_objectsize(&sb, &ce->oid,
+			expand_objectsize(repo, &sb, &ce->oid,
 					  object_type(ce->ce_mode), 1);
 		else if (skip_prefix(format, "(objectsize)", &format))
-			expand_objectsize(&sb, &ce->oid,
+			expand_objectsize(repo, &sb, &ce->oid,
 					  object_type(ce->ce_mode), 0);
 		else if (skip_prefix(format, "(stage)", &format))
 			strbuf_addf(&sb, "%d", ce_stage(ce));
@@ -348,7 +348,7 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 	}
 }
 
-static void show_ru_info(struct index_state *istate)
+static void show_ru_info(struct repository *repo, struct index_state *istate)
 {
 	struct string_list_item *item;
 
@@ -370,7 +370,7 @@ static void show_ru_info(struct index_state *istate)
 			if (!ui->mode[i])
 				continue;
 			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
-			       repo_find_unique_abbrev(the_repository, &ui->oid[i], abbrev),
+			       repo_find_unique_abbrev(repo, &ui->oid[i], abbrev),
 			       i + 1);
 			write_name(path);
 		}
@@ -567,7 +567,7 @@ static int option_parse_exclude_standard(const struct option *opt,
 int cmd_ls_files(int argc,
 		 const char **argv,
 		 const char *cmd_prefix,
-		 struct repository *repo UNUSED)
+		 struct repository *repo)
 {
 	int require_work_tree = 0, show_tag = 0, i;
 	char *max_prefix;
@@ -647,15 +647,15 @@ int cmd_ls_files(int argc,
 	show_usage_with_options_if_asked(argc, argv,
 					 ls_files_usage, builtin_ls_files_options);
 
-	prepare_repo_settings(the_repository);
-	the_repository->settings.command_requires_full_index = 0;
+	prepare_repo_settings(repo);
+	repo->settings.command_requires_full_index = 0;
 
 	prefix = cmd_prefix;
 	if (prefix)
 		prefix_len = strlen(prefix);
-	git_config(git_default_config, NULL);
+	repo_config(repo, git_default_config, NULL);
 
-	if (repo_read_index(the_repository) < 0)
+	if (repo_read_index(repo) < 0)
 		die("index file corrupt");
 
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
@@ -724,7 +724,7 @@ int cmd_ls_files(int argc,
 		max_prefix = common_prefix(&pathspec);
 	max_prefix_len = get_common_prefix_len(max_prefix);
 
-	prune_index(the_repository->index, max_prefix, max_prefix_len);
+	prune_index(repo->index, max_prefix, max_prefix_len);
 
 	/* Treat unmatching pathspec elements as errors */
 	if (pathspec.nr && error_unmatch)
@@ -748,13 +748,13 @@ int cmd_ls_files(int argc,
 		 */
 		if (show_stage || show_unmerged)
 			die(_("options '%s' and '%s' cannot be used together"), "ls-files --with-tree", "-s/-u");
-		overlay_tree_on_index(the_repository->index, with_tree, max_prefix);
+		overlay_tree_on_index(repo->index, with_tree, max_prefix);
 	}
 
-	show_files(the_repository, &dir);
+	show_files(repo, &dir);
 
 	if (show_resolve_undo)
-		show_ru_info(the_repository->index);
+		show_ru_info(repo, repo->index);
 
 	if (ps_matched && report_path_error(ps_matched, &pathspec)) {
 		fprintf(stderr, "Did you forget to 'git add'?\n");
diff --git a/t/t3004-ls-files-basic.sh b/t/t3004-ls-files-basic.sh
index a1078f8701..4034a5a59f 100755
--- a/t/t3004-ls-files-basic.sh
+++ b/t/t3004-ls-files-basic.sh
@@ -34,6 +34,13 @@ test_expect_success 'ls-files -h in corrupt repository' '
 	test_grep "[Uu]sage: git ls-files " broken/usage
 '
 
+test_expect_success 'ls-files does not crash with -h' '
+	test_expect_code 129 git ls-files -h >usage &&
+	test_grep "[Uu]sage: git ls-files " usage &&
+	test_expect_code 129 nongit git ls-files -h >usage &&
+	test_grep "[Uu]sage: git ls-files " usage
+'
+
 test_expect_success SYMLINKS 'ls-files with absolute paths to symlinks' '
 	mkdir subs &&
 	ln -s nosuch link &&
-- 
2.48.1

