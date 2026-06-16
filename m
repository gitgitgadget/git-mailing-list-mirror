Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0481448E0
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 04:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781585523; cv=none; b=jkQeK4XTCLAOvH5OpMaWWPhcBQCLckZrLKTeDa25d9MaFITPMEQmone7xZnCR5gBt0srboQX2y/y6zOoMPRoAtYEj83erOOUsZGuTHHvTISC1nSmYsAwzNZ/uRE3TrN08HfMBdxCcGtxcEMTyLal72Ssf6IMAIEynBmkGQpP96c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781585523; c=relaxed/simple;
	bh=WJ2EsjliZw1oYpI0qHM56iyhZfI8J+9mZpEUSVUQRfs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MsdGCCvtjb2TTiaYJz9afdW2hEmQwwnLoYR1UazSchks8FeEExDEmqV6uOhWMUhucrBalujVoCXcQAV/JeTmPJOuDEYCGg8gmYNlYMg43zG8bYTjCH20ObQUY4/+mc4yy69Xw51GHGAV4fXhE4n1QAQtyl0DCp7tNU9j8lHe9m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P7DGTlj9; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7DGTlj9"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8434840cea8so2463564b3a.3
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 21:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781585521; x=1782190321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQAJ4pkaMxJOFq7R83v91BuYnVkKCRnuiZijPhghrC4=;
        b=P7DGTlj9BQazDahRqqZRPvhsg7xXZV8hNazP+lJStkXtVaoFZnoB58ysA/QLdJrte4
         vkPparIiE+8iAtLL/kUWL43AFeU+gUN1jqN11xV2btjC7xGXKVKACVSs6xetGsN1ugv8
         awBt9ZBtmJbMi/WViglAJeWw3+l3pox0N1VBUd8ec3TMDxlJMhZ36EE3XoI6lLmQXZAn
         S5ch5V6J3XTZGECKAcfhRphQAHuajZgPYLAArCp92HMSKffl739oo1aIg8ElRw1yK5ZJ
         lAVim1lT3tuzcDo+vg+PWCPE35tDjAtX1YhbEXewrFVeNsbS0RkLnWv82mOCwxTW3yJm
         VVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781585521; x=1782190321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tQAJ4pkaMxJOFq7R83v91BuYnVkKCRnuiZijPhghrC4=;
        b=auW1rqtDZRQpnZCFKkpivvAHRSiV3Lzy73A6YsYb2L0iNHoyahRQa8u7VNC2ozed4K
         NpPDmV0gkY3xwe9Pwi1OV2a4TsuT+UqI7NLfxtI/1QHgRCDUH7KwlPmRNXEePPaBszy7
         eF6bVIg9y/7EiTxza2bVIfYNZTjmSbC6wHBebR9hob370y6zbBK/1kRyW/hgK5EoGRXp
         QwKNrukq8TSUc3nveaHCoKdBcAcLNiO6XnJYkkfSI6D0zVvzzWNLEBlmDW4yhtfOqkPf
         s1Bc2Pgg5a9BWSu7xNYuu6XArzzlncZvWW/BVl0lw34DTGVf1/5+P2+vq52OKoxr5RI5
         qsJA==
X-Gm-Message-State: AOJu0Yycm3v+awC4ZSRv4WQmWbXF4pDxuwANB0AUoeSbyU3+zhH2GHxK
	OoATwiEBxafptXZryI+bAckW6P8+J6BNVEfTJhk+lvactCi/DDx8+hT0+qBF6w==
X-Gm-Gg: Acq92OGfPa0deVeZtTiWeINGWzDwZzfWznkanJRNn6X5XACaF1TOasPZiGDe24lW00S
	30yOuB33v4pJRothUdSQLEN29fVpPBfJQ4Tc7HgyVEpQTTzrGGlGuzDOLcUa9Jj3YC5ivcE+XgB
	CIcb6jwjHB+UvLkvb6RtTaBkZ/d8ZyGZFXL5xdkuSIpLtiI/TidYZi3CIR5c0HRRjD4S2J3lSmE
	DBfroSjTgGGf9rSyJo/Uc4wu8RLfSEFAleBfJF3aceYgANCL/dEFXjySQ9+Jd87l9hnhhdHMAAo
	8EGdrhOrt7uTdYY/OTrG8gT+sDBuBKa7pAfuC1X9cWpOJPHdFQvQWeLhfuia2dcSFIWAAt8XKjs
	8NwtXz4+ox9CupLn3w8iDDmBQ6pGpGNeVQ+vfWlHjlZDcA1NaPtlK81AOK2vBpDA0TRgEkkDPES
	ieOaIHKwHwOj/gUUy92m2HN0jBdn9edAOp/T3m47A1D2J/Ufbx98rvYyPReyeSqwk2qlXjfZC77
	KkZoGIiLV8Uuqd4e0eqjd0i+Yj0PMY32vEAP+Xd4d7n
X-Received: by 2002:a05:6a00:12e3:b0:842:72af:b3b7 with SMTP id d2e1a72fcca58-8451551f8fdmr1896884b3a.33.1781585521277;
        Mon, 15 Jun 2026 21:52:01 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b040718sm12122614b3a.51.2026.06.15.21.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 21:52:00 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v5 2/4] rev-parse: use append_formatted_path() for path formatting
Date: Tue, 16 Jun 2026 10:19:51 +0530
Message-ID: <20260616044953.184806-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260616044953.184806-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that path formatting logic lives in a shared helper, keeping a
duplicate implementation in rev-parse is unnecessary and risks the
two diverging over time.

Replace the local format_type and default_type enums and the
hand-rolled formatting logic with a call to append_formatted_path().
Introduce PATH_FORMAT_DEFAULT as the initial value of arg_path_format
so that per-path fallback behavior is resolved in print_path() rather
than leaked into the shared helper.

Mentored-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 builtin/rev-parse.c | 104 ++++++++++----------------------------------
 1 file changed, 24 insertions(+), 80 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 218b5f34d6..1fdcb946a7 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -632,73 +632,17 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
 	clear_ref_exclusions(&ref_excludes);
 }
 
-enum format_type {
-	/* We would like a relative path. */
-	FORMAT_RELATIVE,
-	/* We would like a canonical absolute path. */
-	FORMAT_CANONICAL,
-	/* We would like the default behavior. */
-	FORMAT_DEFAULT,
-};
-
-enum default_type {
-	/* Our default is a relative path. */
-	DEFAULT_RELATIVE,
-	/* Our default is a relative path if there's a shared root. */
-	DEFAULT_RELATIVE_IF_SHARED,
-	/* Our default is a canonical absolute path. */
-	DEFAULT_CANONICAL,
-	/* Our default is not to modify the item. */
-	DEFAULT_UNMODIFIED,
-};
-
-static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
+static void print_path(const char *path, const char *prefix,
+		       enum path_format arg_path_format, enum path_format def_format)
 {
-	char *cwd = NULL;
-	/*
-	 * We don't ever produce a relative path if prefix is NULL, so set the
-	 * prefix to the current directory so that we can produce a relative
-	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
-	 * we want an absolute path unless the two share a common prefix, so don't
-	 * set it in that case, since doing so causes a relative path to always
-	 * be produced if possible.
-	 */
-	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
-		prefix = cwd = xgetcwd();
-	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
-		puts(path);
-	} else if (format == FORMAT_RELATIVE ||
-		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
-		/*
-		 * In order for relative_path to work as expected, we need to
-		 * make sure that both paths are absolute paths.  If we don't,
-		 * we can end up with an unexpected absolute path that the user
-		 * didn't want.
-		 */
-		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
-		if (!is_absolute_path(path)) {
-			strbuf_realpath_forgiving(&realbuf, path,  1);
-			path = realbuf.buf;
-		}
-		if (!is_absolute_path(prefix)) {
-			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
-			prefix = prefixbuf.buf;
-		}
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-		strbuf_release(&realbuf);
-		strbuf_release(&prefixbuf);
-	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
-		struct strbuf buf = STRBUF_INIT;
-		puts(relative_path(path, prefix, &buf));
-		strbuf_release(&buf);
-	} else {
-		struct strbuf buf = STRBUF_INIT;
-		strbuf_realpath_forgiving(&buf, path, 1);
-		puts(buf.buf);
-		strbuf_release(&buf);
-	}
-	free(cwd);
+	struct strbuf sb = STRBUF_INIT;
+	/* If the user didn't explicitly specify a format, fallback to the path-specific default. */
+	enum path_format fmt = (arg_path_format != PATH_FORMAT_DEFAULT) ? arg_path_format : def_format;
+
+	append_formatted_path(&sb, path, prefix, fmt);
+	puts(sb.buf);
+
+	strbuf_release(&sb);
 }
 
 int cmd_rev_parse(int argc,
@@ -717,7 +661,7 @@ int cmd_rev_parse(int argc,
 	const char *name = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	int seen_end_of_options = 0;
-	enum format_type format = FORMAT_DEFAULT;
+	enum path_format arg_path_format = PATH_FORMAT_DEFAULT;
 
 	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
 
@@ -797,8 +741,8 @@ int cmd_rev_parse(int argc,
 					die(_("--git-path requires an argument"));
 				print_path(repo_git_path_replace(the_repository, &buf,
 								 "%s", argv[i + 1]), prefix,
-						format,
-						DEFAULT_RELATIVE_IF_SHARED);
+						arg_path_format,
+						PATH_FORMAT_RELATIVE_IF_SHARED);
 				i++;
 				continue;
 			}
@@ -820,9 +764,9 @@ int cmd_rev_parse(int argc,
 				if (!arg)
 					die(_("--path-format requires an argument"));
 				if (!strcmp(arg, "absolute")) {
-					format = FORMAT_CANONICAL;
+					arg_path_format = PATH_FORMAT_CANONICAL;
 				} else if (!strcmp(arg, "relative")) {
-					format = FORMAT_RELATIVE;
+					arg_path_format = PATH_FORMAT_RELATIVE;
 				} else {
 					die(_("unknown argument to --path-format: %s"), arg);
 				}
@@ -985,7 +929,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = repo_get_work_tree(the_repository);
 				if (work_tree)
-					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(work_tree, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 				else
 					die(_("this operation must be run in a work tree"));
 				continue;
@@ -993,7 +937,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
 				if (get_superproject_working_tree(&superproject))
-					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(superproject.buf, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 				strbuf_release(&superproject);
 				continue;
 			}
@@ -1028,18 +972,18 @@ int cmd_rev_parse(int argc,
 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
 				char *cwd;
 				int len;
-				enum format_type wanted = format;
+				enum path_format wanted = arg_path_format;
 				if (arg[2] == 'g') {	/* --git-dir */
 					if (gitdir) {
-						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
+						print_path(gitdir, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 						continue;
 					}
 					if (!prefix) {
-						print_path(".git", prefix, format, DEFAULT_UNMODIFIED);
+						print_path(".git", prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 						continue;
 					}
 				} else {		/* --absolute-git-dir */
-					wanted = FORMAT_CANONICAL;
+					wanted = PATH_FORMAT_CANONICAL;
 					if (!gitdir && !prefix)
 						gitdir = ".git";
 					if (gitdir) {
@@ -1055,11 +999,11 @@ int cmd_rev_parse(int argc,
 				strbuf_reset(&buf);
 				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] != '/' ? "/" : "");
 				free(cwd);
-				print_path(buf.buf, prefix, wanted, DEFAULT_CANONICAL);
+				print_path(buf.buf, prefix, wanted, PATH_FORMAT_CANONICAL);
 				continue;
 			}
 			if (!strcmp(arg, "--git-common-dir")) {
-				print_path(repo_get_common_dir(the_repository), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
+				print_path(repo_get_common_dir(the_repository), prefix, arg_path_format, PATH_FORMAT_RELATIVE_IF_SHARED);
 				continue;
 			}
 			if (!strcmp(arg, "--is-inside-git-dir")) {
@@ -1089,7 +1033,7 @@ int cmd_rev_parse(int argc,
 				if (the_repository->index->split_index) {
 					const struct object_id *oid = &the_repository->index->split_index->base_oid;
 					const char *path = repo_git_path_replace(the_repository, &buf, "sharedindex.%s", oid_to_hex(oid));
-					print_path(path, prefix, format, DEFAULT_RELATIVE);
+					print_path(path, prefix, arg_path_format, PATH_FORMAT_RELATIVE);
 				}
 				continue;
 			}
-- 
2.54.0

