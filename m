Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31C1FCFF4
	for <git@vger.kernel.org>; Fri, 14 Feb 2025 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739574154; cv=none; b=k1n2Ql1v1vQfm9sISfJe0YuxPqWAtml8f5k4vTRhFlRrl5VEU9CvDVasRj7Z5VPDx7XEIjxraavCbzJ82VfsdblIaH1ME/MEpLkNe7pLcXO+a1XN9T+SVHmtu5Lzo3kqVjeg8QqYwqbmUzEsdqQFbZSDzmSGJtbc5k2r6Zf43ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739574154; c=relaxed/simple;
	bh=J3wC5ZXGdblCld5rDLoTStJYamB3Hs4zbaGx/iv7R/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuGNR/HSXBVKtBesPvvCMDaxqvoJHwsuvulbgzVyB31R8AO/w3u1flTUEWKIe4quY6udnZkavF+icbq3tD2LF1zM9nWRLPo9RYdv+THU1LMP4DSL6Jt511dtWdMeOgzSpdpiQeflYe0iIZAcSvM2glvrqbSN1TG0gat/48h0Rm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm/CGzHh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm/CGzHh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220c8f38febso48497215ad.2
        for <git@vger.kernel.org>; Fri, 14 Feb 2025 15:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739574152; x=1740178952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8TGV13f6sFXc6mps+LdzE6uvrjJNOO8zye/UIvmsWs=;
        b=Lm/CGzHhYfi7QWnNghcGa/tIyIYRvkV9owLNWBclwGX/1X0jXWdJARYZ2AnurQc/Op
         oHDjEoxPlmHPS2J6Z+90mqh15Muv5T8kPRCVEOe1lpwvjuX0Vt71PcNLys2+7L4ho9kk
         Ena0EgFMXwKp9ygRjFgeqJhYLcPDNWUdMPikk6HpHgjUmGDS7y3y32/PP8nqG+1E0Ci6
         6IMixwx76gVfQRo8G31tz4G3KZVjjWiqvh6Y1q7T/vmp+oh2G5xNIlHneSunfZHPfeun
         rrhQ/ZqOJ9bH1LcX74dMycMpgUQ+9FIJPoVpU9awk5jCabid81uv/WY26r4iNJLyz94U
         6QHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739574152; x=1740178952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8TGV13f6sFXc6mps+LdzE6uvrjJNOO8zye/UIvmsWs=;
        b=QUEGDdCB1FmW8ILoTSvMiLVe0Oe+lhL5wWxDU/HUapF/Fo+0wZ4lOM9LrrxNzrPwpi
         RVINW0r788L6lbkeW4No8kkDOPozCEAwjph6kcHR/DIOV2MxHIrAUpl/87BZ9QlTbuli
         X1OPYkTrAqYy9+/K4NJJAQIajY45jeYKXmuYnwRZNOmKq2FFhAy5UDjwofGe5wlsIRWD
         EsMx2ev6KxuMPsZv7nwbvZWqxu66cyx70gZZkhgFmxN4of1+ZD+v/WCDAGhoUediDcGO
         d1+WxNuelgwGntO5L/M5CdIvBKLw4Z3EU3bsmmDHDu2l/vSkhOD22XqIDn0JzHWLNeHO
         52+w==
X-Gm-Message-State: AOJu0YyqpUq/SCX0fM5DSHWAnQjvX/o7vTtWNkjOwN0EB0ZcLrbYIjmP
	aptfa4gq4mxxet971cczKWCO17arFBE4YhlUWNMRAWEDNmfTs/MLCRkN976g
X-Gm-Gg: ASbGncupZcZmL8JQBOztlhPZvbgEpayiiBMo2xsp3wIHh45GpChwFrnfLeM6Pg3CRay
	Pj4riNOPbRKgaQvMyqimlYE2Ik6F6KLTf/yhha/26YIctsbPuAgCs3d9nyaDO9HmTWXslZz4Ei7
	hlI2R69Hx+tBgrdnYNAkX6S01wz/vYCdoR22PcZLH/9abrpnD6cm5j/6NezkgdZ8ONXPcH1sKml
	FtZIXJa/hANoNhG6e4aoYvETegSjfLykZBL7UXqBKK0tqgzN/W/ulIAkoWHRAPka4sjXxeNM7yL
	xmhDqSKvhhaSjmXBKuKqIy08BNJuAYxL2YKRsdlU
X-Google-Smtp-Source: AGHT+IF2ofo/7gxSTf+EKQmrcMtvhIWTrhLKZtJ/srd9tfcMk9J/syP3CLHDGzqPNRtdVdgTfmFw9A==
X-Received: by 2002:a17:902:ef49:b0:212:63c0:d9e7 with SMTP id d9443c01a7336-22103c5f3bamr18042965ad.0.1739574152472;
        Fri, 14 Feb 2025 15:02:32 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22105174c73sm1495245ad.216.2025.02.14.15.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 15:02:32 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org
Cc: chriscool@tuxfamily.org,
	christian.couder@gmail.com,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH 5/7] builtin/ls-files: stop using `the_repository`
Date: Sat, 15 Feb 2025 04:27:21 +0530
Message-ID: <20250214230210.1460111-6-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
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
call will give the options help and exit, without having to consult much
of the configuration file.

Let's pass `repository` argument to `expand_objectsize()`,
`show_ru_info()` functions to remove their dependency on the global
`the_repository` variable.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/ls-files.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

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
-- 
2.48.1

