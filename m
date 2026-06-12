Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84EE34CFDA
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 18:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781289029; cv=none; b=HsOYJUu9d2uUuyAywWZz+Bvwg4odWIFenFYy8+0nzSDrbAuf7KtBm9upAkLrTm1/DEX6/ULJQwAgEKAWasxGeq1tRqaXSSFmFAtQhxq2wIzBM7s2GyilmUiOBy9WF+WaCZiMgZLbDzTB1UX4rK0bZyDTGPLmitY5IxJb2RujgsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781289029; c=relaxed/simple;
	bh=TjG9fGnsOs1ovkLUIFQn2Psam4uxpH563BO48d69phA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vv0ozEtGNHtipJxY98sy5XKwqUhqxiY3iS3uOHpocHEN0PVlnyR9nwgg8rVIbFHUyZJAuvr0/+RDhG2968Zc/zNklwrLeivdFUxKmGj98rLAIwManGbeZjTyZyUxbdbMSIhL2L/ES6REuybDaxvTBsh7pjpY8taVBDhz+pYPqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dniZxE6S; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dniZxE6S"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f626a65so675061b3a.2
        for <git@vger.kernel.org>; Fri, 12 Jun 2026 11:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781289027; x=1781893827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htzmQEkjSM0FFlZEOOvQaC8mdqHEyD4SJ/CSguRJNJA=;
        b=dniZxE6St4wYKZeo0F/4mCcOG5oW3P4t9rHw32G6mHaX14pGGEPS3IASkOjlI1wKRo
         a06GD5flblGBF7Nc0B92d270HoJh/O0nB898MDN/MjdlqLg/ObefGy0Vb2MAxk5Y6DkN
         ZqEfOVyi69WwTEritmxrCXQa/QiY4SAeMAPkYNk6cv9wOh0g03cUDU03D0QpiEr9GvWt
         QRvMLzcpkfTScfovGDivKdnxnaOyg+lUhimfN+DhEIFCi7O15PQ1Zuu/4rc4hYuFlH+K
         hfDno5iJWuI950JW+U6swgQlfMSOhRifVZKFp6LZIxNT+7WYtkVyONYqe0Ojhj8IDbX7
         P6lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781289027; x=1781893827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htzmQEkjSM0FFlZEOOvQaC8mdqHEyD4SJ/CSguRJNJA=;
        b=jdmm9MTHyTnRwk46zJRLcuigvlb09UJn8vUfqLS7MmASIV98B9y3GCaFMZPiqJ6TvY
         sjgk5660Xqoi0vC2fzsbrAWKH4FtmpxCGwQEPBLpFz3H3+COqPWtf3gOer1Ys0/9wmYt
         CRS8GB7TL8dPmVpAD4LQw/zKlwxEr+cQ7xf+nkrb9ZI/b0CUPwmumeiD8x+cq1BmkR/k
         TMrPDxceXaFmVrMextQ5ZzprRpIAdGaShcRtPPb6MXhTYP8Q9C2LtNFOzgWErCWycWGN
         DugVwfzfwv29eUX3yNfcQRaMQy9juuElcLEYltGCgS8J6yqO4SeZWd7Oi2gdZEhNG9WP
         9ydA==
X-Forwarded-Encrypted: i=1; AFNElJ/A6OX7nRiLHGvIKDkIe2qWM/3STXrgOv2WQswjI3RY1V/15RgNXUt/A8OdvbDWdZ3oYEg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6p9ppbkiBJfkeCyb2TkM1XXgRMZdlo9BnVMl8ZpdGxD8m2lGs
	zf9d+iwEU4NbgedZ1ez/0jzP8NqDo39JNHBPu2crrHqq8Eq2QILz8glD
X-Gm-Gg: Acq92OG912271KIclCLkvRhgmLjgfJ8icVw8IFbZv5LYAX3VENssGfFIpm7uU5Pqlp7
	RyDseWkM2mYgeZdONtnc/qIjHmCrmWRL+LUjBQm79keUJz+O1k2kEuHppSr54W1ZJaTjgmBMjY5
	9pdNa8R03/aXW/bUKnxzDt2QPdDJZxFizBqX6RoWupg9pblTuytTubxXgP4GVZumj5hEdzJTGbc
	ctO0PZoVZDuBuP+hJaKNSE+1vWKYwYlMaaTJhUYc1Ef4RPLiVUR8WkrQgRlaY+mjkS84EWMJMHE
	JP3D/qfBbr/53ia6LozDOpJlSpD/lWNetFwzHi6RBkQi7YdQFPPQSWt1HIZtMlQJHOhCfkuuR/0
	JARKLHS6i7Cc7WxLQ6ACuX6FRbp7B9g99/DkooAJCq6j+zrbVh9c8rPz6yI2UMDTxR8VCnJWcxC
	YmwbYeeZ69Mfc/r4mSzl8DFhdscNxob1pf1C9zC5H6SuInZyCqGFVrFpbU4q/YVyG1XsU0VkKCt
	T6yTckY29X64ao2DOlRqxH5a1WxWMiTFw==
X-Received: by 2002:a05:6a00:84a:b0:842:3ca9:32d5 with SMTP id d2e1a72fcca58-8434cb0ab30mr4434791b3a.5.1781289026899;
        Fri, 12 Jun 2026 11:30:26 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc9fa8sm3341488b3a.32.2026.06.12.11.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 11:30:26 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: jayatheerthkulkarni2005@gmail.com
Cc: a3205153416@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	jltobler@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	kumarayushjha123@gmail.com,
	lucasseikioshiro@gmail.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net
Subject: [GSoC Patch v3 2/4] rev-parse: use append_formatted_path() for path formatting
Date: Fri, 12 Jun 2026 23:58:45 +0530
Message-ID: <20260612182847.562816-3-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
 <20260612182847.562816-1-jayatheerthkulkarni2005@gmail.com>
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
 builtin/rev-parse.c | 103 ++++++++++----------------------------------
 1 file changed, 23 insertions(+), 80 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 218b5f34d6..2dd35361f3 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -632,73 +632,16 @@ static void handle_ref_opt(const char *pattern, const char *prefix)
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
+	enum path_format fmt = (arg_path_format != PATH_FORMAT_DEFAULT) ? arg_path_format : def_format;
+
+	append_formatted_path(&sb, path, prefix, fmt);
+	puts(sb.buf);
+
+	strbuf_release(&sb);
 }
 
 int cmd_rev_parse(int argc,
@@ -717,7 +660,7 @@ int cmd_rev_parse(int argc,
 	const char *name = NULL;
 	struct strbuf buf = STRBUF_INIT;
 	int seen_end_of_options = 0;
-	enum format_type format = FORMAT_DEFAULT;
+	enum path_format arg_path_format = PATH_FORMAT_DEFAULT;
 
 	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
 
@@ -797,8 +740,8 @@ int cmd_rev_parse(int argc,
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
@@ -820,9 +763,9 @@ int cmd_rev_parse(int argc,
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
@@ -985,7 +928,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-toplevel")) {
 				const char *work_tree = repo_get_work_tree(the_repository);
 				if (work_tree)
-					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(work_tree, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 				else
 					die(_("this operation must be run in a work tree"));
 				continue;
@@ -993,7 +936,7 @@ int cmd_rev_parse(int argc,
 			if (!strcmp(arg, "--show-superproject-working-tree")) {
 				struct strbuf superproject = STRBUF_INIT;
 				if (get_superproject_working_tree(&superproject))
-					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
+					print_path(superproject.buf, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
 				strbuf_release(&superproject);
 				continue;
 			}
@@ -1028,18 +971,18 @@ int cmd_rev_parse(int argc,
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
@@ -1055,11 +998,11 @@ int cmd_rev_parse(int argc,
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
@@ -1089,7 +1032,7 @@ int cmd_rev_parse(int argc,
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

