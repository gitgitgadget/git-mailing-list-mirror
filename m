Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E54B640
	for <git@vger.kernel.org>; Sat, 20 Jun 2026 03:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781925455; cv=none; b=X+VoEYG5NRNgnDOEUsGGKRoDqHUZd7rTlCbWh3gsE7RmFDYQHHPZG0L+j1pTjj8FEfTJ0VHNGOBjqJcXLtTCssWYRMtOOYCN0KuIlfZmYq1Qqt/jdsK4WZh/3Ujli5mk0PdTuW7tBLdzdZploJ5yXbZ3MxxE1BkiRdHVyZ6T0ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781925455; c=relaxed/simple;
	bh=+cIMA+ME++z1isLcARWRu9pFfhdfGOSszUW42EyNN3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M4vKAG3EWTr1nv60ZvKx9JyciCAcmdMo6DhTlEW6OWLghQkbYiyqH9jdmjf/3KBFJ/1Ls/zh15XN0ftGDRQTl8ka3rv0YkUB51Ykiu4ilN/ESnN03MVVB6w3f32N1DLQThvGpZWEne07XKTpXMPzMRa3GW8Z2fgHB6UaBInq8TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QuHIq6ry; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QuHIq6ry"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2c6d3851e09so14104155ad.0
        for <git@vger.kernel.org>; Fri, 19 Jun 2026 20:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781925453; x=1782530253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zasU4gq3sBV/cG9Lb+cXHD1nLGhJa49vf4arNk3IFrs=;
        b=QuHIq6rybsMziLI+sXVMGni+QmHptOg9V5CfhS2iSvSB7AcWH/FcXVKjzENcy9Yjr8
         E41gQ/GGAcMabp/HcPvsOhg7tmjHxoEGJ7YDuiG2YM91AZonsWk3IvdtiBKmC5Din7GJ
         tU50Qef5Dm4ejEcWIaP71sD5lmta/RELWXvSgv/LaWvjiaIDZa+3YgALNWkV6yZ656Vq
         uKnlZTgZDAkFbyPFCRo4ozb/Xa9VeCB3xoUcA2h/fizvy4X1YDUW2o+tvoGcKSguOMGc
         GR9oZ+7u4AnB8rF1bxjzJgu422hf5LD2p0Qwy3FLoPkFqnwCkVgMNwM69uD92NpRQgAh
         Y59A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781925453; x=1782530253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zasU4gq3sBV/cG9Lb+cXHD1nLGhJa49vf4arNk3IFrs=;
        b=jD8fRcvVOm6ol/vP1sXV2ig74hQj5KbS85R9x62Fe5ZqfNTX5bvbfgeXoa9OyGUV1k
         MfX9T79NiMDwLO/PmR3P6ugAwCa+D4fOvZWmVVOCoyDtYMdDxoj25o23ftLvQD3cpG0x
         qS7ZAxmN5vsveB2ww61nqyoXac55T5Z429FtkR6sp2YjsaZYcrzwnFIkcn1H835bEorD
         5N8a4AZ1VD03euM5d19IchH/HxcwSh10eKVKhE2uAXIrh+7ljSXyh42TnsWliUrByQXg
         pkuY1mVggyaq1zkFAu4/fyvOQY3MeP1zJFbHcbN7HCEnvzf194PU4pW+9cI8lFLxB5yC
         XDYg==
X-Gm-Message-State: AOJu0YwzKsKDq6rnH1zog5pO7TQDk3TWkX6nd3Xi7fwBDEF/o4/qYLgo
	v9WsDLL+w8lr8ZDL8qGS74GuUerfLivqvNOxZ93DvrNl0UTBJDDVdsMpoUbqew==
X-Gm-Gg: AfdE7ckVjqdDXDt5/Qc5xWzWhX/6ds/ihF574ULdBlzi7ksSFble0B2NgFDv7OuYp8p
	PkNXpiolzLHvAnpRH3gGbzDLyikR+H44G0zzUjDKxc3IIOMY4UFck/xGJoGRi/fuHhjht29bE/D
	UOeHEJqbJgOgqsnL9az6fsajYZr+CgJ6V1jzmTzKLmiy1lXcXZOsyB6oY/7QzguR4+qihvaJha8
	Tn+0TPFBVdgZkOTOd+uQIHIWS682H2vl7Yl/XWpnt5zlixJwkgRtaVcJhZSEAk44YtTnSMFrXHA
	Z6SzGAKysqbNIErY8p7JbW755oO5lyER1WaaTTuzPfadGmotRpFrUeYN+Ei0QJBw8/sekwBbsjd
	wIdpUKdetonoSgBvmPmrglHQsmnsOU203x88SmMxmx202qIYfrStfljpEQIwk50fCU7/fGSyAU1
	7ByOXAenKa6pVuwXCBxG+mxXzsi3Fu2ewcxC72PstQOSyaxZusatgxqmWj4REi8s4Astji5Zg2K
	HreHMAOfRzD4GpShLQ=
X-Received: by 2002:a17:903:46cb:b0:2c1:6e2c:a5e2 with SMTP id d9443c01a7336-2c718f65168mr74150195ad.17.1781925453264;
        Fri, 19 Jun 2026 20:17:33 -0700 (PDT)
Received: from jayatheerth ([2409:40f0:f:5924:9ce6:f181:f81b:c57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7436af590sm9581675ad.17.2026.06.19.20.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 20:17:32 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: git@vger.kernel.org
Cc: jltobler@gmail.com,
	lucasseikioshiro@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	kristofferhaugsbakk@fastmail.com,
	K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Subject: [GSoC Patch v6 0/4] teach git repo info to handle path keys
Date: Sat, 20 Jun 2026 08:46:40 +0530
Message-ID: <20260620031644.353772-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This series teaches `git repo info` to handle `path.*`
keys, allowing scripts to reliably discover core
repository paths without resorting to `git rev-parse`.

The patches are structured as follows:

1. path: Extract the localized path-formatting logic
   out of `rev-parse` and expose it globally via
   `path.h` using clear append semantics.

2. rev-parse: Delegate the command's path-printing
   helper to the newly shared path engine, while
   leaving its existing option-parsing untouched.

3. repo: Introduce `path.commondir.absolute` and
   `path.commondir.relative` alongside a robust,
   isolated test helper.

4. repo: Introduce `path.gitdir.absolute` and
   `path.gitdir.relative` using the same standardized
   formatting rules.

Changes since v5:

* Dropped `PATH_FORMAT_DEFAULT` from the shared
  `path_format` enum in path.h. It only existed to let
  rev-parse track "no format was requested", which is a
  rev-parse-specific concern that other callers of
  `append_formatted_path()` shouldn't need to reason
  about (Phillip).

* Reverted `print_path()` in builtin/rev-parse.c to keep
  its original `format_type` and `default_type` local
  enums completely untouched (Phillip).

* As a result, patch 2 is now much smaller: it only
  touches the body of `print_path()`.

Tagging Justin Tobler, Lucas Seiki Oshiro, Junio,
Phillip Wood, brian m. carlson, and Ayush Jha.

Thanks again for the careful review!

K Jayatheerth (4):
  path: introduce append_formatted_path() for shared path formatting
  rev-parse: use append_formatted_path() for path formatting
  repo: add path.commondir with absolute and relative suffix formatting
  repo: add path.gitdir with absolute and relative suffix formatting

 Documentation/git-repo.adoc | 15 ++++++++
 builtin/repo.c              | 50 +++++++++++++++++++++++++
 builtin/rev-parse.c         | 73 +++++++++++++++----------------------
 path.c                      | 69 +++++++++++++++++++++++++++++++++++
 path.h                      | 30 +++++++++++++++
 t/t1900-repo-info.sh        | 58 +++++++++++++++++++++++++++++
 6 files changed, 251 insertions(+), 44 deletions(-)

Range-diff against v5:
1:  31bc2c96e9 ! 1:  bb8bb40030 path: introduce append_formatted_path() for shared path formatting
    @@ path.c: char *xdg_cache_home(const char *filename)
     +			   const char *prefix, enum path_format format)
     +{
     +	switch (format) {
    -+	case PATH_FORMAT_DEFAULT:
     +	case PATH_FORMAT_UNMODIFIED:
     +		strbuf_addstr(dest, path);
     +		break;
    @@ path.h: enum scld_error safe_create_leading_directories_no_share(char *path);
     + * The formatting strategy to apply when writing a path into a buffer.
     + */
     +enum path_format {
    -+	/*
    -+	 * Represents the default formatting behavior. Treated as
    -+	 * PATH_FORMAT_UNMODIFIED by append_formatted_path().
    -+	 */
    -+	PATH_FORMAT_DEFAULT,
    -+
     +	/* Output the path exactly as-is without any modifications. */
     +	PATH_FORMAT_UNMODIFIED,
     +
2:  12af24ffc3 ! 2:  0ab0e4bde3 rev-parse: use append_formatted_path() for path formatting
    @@ Metadata
      ## Commit message ##
         rev-parse: use append_formatted_path() for path formatting
     
    -    Now that path formatting logic lives in a shared helper, keeping a
    -    duplicate implementation in rev-parse is unnecessary and risks the
    -    two diverging over time.
    +    Now that the core path-formatting algorithm lives in
    +    append_formatted_path(), print_path() doesn't need to duplicate it.
     
    -    Replace the local format_type and default_type enums and the
    -    hand-rolled formatting logic with a call to append_formatted_path().
    -    Introduce PATH_FORMAT_DEFAULT as the initial value of arg_path_format
    -    so that per-path fallback behavior is resolved in print_path() rather
    -    than leaked into the shared helper.
    +    Replace the body of print_path() with a small mapping from rev-parse's
    +    existing format_type/default_type pair to the shared path_format enum,
    +    then delegate to append_formatted_path(). The two local enums, and
    +    every call site that uses them throughout cmd_rev_parse(), are left
    +    untouched.
     
         Mentored-by: Justin Tobler <jltobler@gmail.com>
         Mentored-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
         Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
     
      ## builtin/rev-parse.c ##
    -@@ builtin/rev-parse.c: static void handle_ref_opt(const char *pattern, const char *prefix)
    - 	clear_ref_exclusions(&ref_excludes);
    - }
    +@@ builtin/rev-parse.c: enum default_type {
    + 	DEFAULT_UNMODIFIED,
    + };
      
    --enum format_type {
    --	/* We would like a relative path. */
    --	FORMAT_RELATIVE,
    --	/* We would like a canonical absolute path. */
    --	FORMAT_CANONICAL,
    --	/* We would like the default behavior. */
    --	FORMAT_DEFAULT,
    --};
    --
    --enum default_type {
    --	/* Our default is a relative path. */
    --	DEFAULT_RELATIVE,
    --	/* Our default is a relative path if there's a shared root. */
    --	DEFAULT_RELATIVE_IF_SHARED,
    --	/* Our default is a canonical absolute path. */
    --	DEFAULT_CANONICAL,
    --	/* Our default is not to modify the item. */
    --	DEFAULT_UNMODIFIED,
    --};
    --
     -static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
     +static void print_path(const char *path, const char *prefix,
    -+		       enum path_format arg_path_format, enum path_format def_format)
    ++		       enum format_type format, enum default_type def)
      {
     -	char *cwd = NULL;
     -	/*
    @@ builtin/rev-parse.c: static void handle_ref_opt(const char *pattern, const char
     -		if (!is_absolute_path(prefix)) {
     -			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
     -			prefix = prefixbuf.buf;
    --		}
    ++	struct strbuf sb = STRBUF_INIT;
    ++	enum path_format fmt;
    ++
    ++	if (format == FORMAT_RELATIVE) {
    ++		fmt = PATH_FORMAT_RELATIVE;
    ++	} else if (format == FORMAT_CANONICAL) {
    ++		fmt = PATH_FORMAT_CANONICAL;
    ++	} else /* FORMAT_DEFAULT */ {
    ++		switch (def) {
    ++		case DEFAULT_RELATIVE:
    ++			fmt = PATH_FORMAT_RELATIVE;
    ++			break;
    ++		case DEFAULT_RELATIVE_IF_SHARED:
    ++			fmt = PATH_FORMAT_RELATIVE_IF_SHARED;
    ++			break;
    ++		case DEFAULT_CANONICAL:
    ++			fmt = PATH_FORMAT_CANONICAL;
    ++			break;
    ++		case DEFAULT_UNMODIFIED:
    ++		default:
    ++			fmt = PATH_FORMAT_UNMODIFIED;
    ++			break;
    + 		}
     -		puts(relative_path(path, prefix, &buf));
     -		strbuf_release(&buf);
     -		strbuf_release(&realbuf);
    @@ builtin/rev-parse.c: static void handle_ref_opt(const char *pattern, const char
     -		strbuf_realpath_forgiving(&buf, path, 1);
     -		puts(buf.buf);
     -		strbuf_release(&buf);
    --	}
    + 	}
     -	free(cwd);
    -+	struct strbuf sb = STRBUF_INIT;
    -+	/* If the user didn't explicitly specify a format, fallback to the path-specific default. */
    -+	enum path_format fmt = (arg_path_format != PATH_FORMAT_DEFAULT) ? arg_path_format : def_format;
     +
     +	append_formatted_path(&sb, path, prefix, fmt);
     +	puts(sb.buf);
    @@ builtin/rev-parse.c: static void handle_ref_opt(const char *pattern, const char
      }
      
      int cmd_rev_parse(int argc,
    -@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    - 	const char *name = NULL;
    - 	struct strbuf buf = STRBUF_INIT;
    - 	int seen_end_of_options = 0;
    --	enum format_type format = FORMAT_DEFAULT;
    -+	enum path_format arg_path_format = PATH_FORMAT_DEFAULT;
    - 
    - 	show_usage_if_asked(argc, argv, builtin_rev_parse_usage);
    - 
    -@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    - 					die(_("--git-path requires an argument"));
    - 				print_path(repo_git_path_replace(the_repository, &buf,
    - 								 "%s", argv[i + 1]), prefix,
    --						format,
    --						DEFAULT_RELATIVE_IF_SHARED);
    -+						arg_path_format,
    -+						PATH_FORMAT_RELATIVE_IF_SHARED);
    - 				i++;
    - 				continue;
    - 			}
    -@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    - 				if (!arg)
    - 					die(_("--path-format requires an argument"));
    - 				if (!strcmp(arg, "absolute")) {
    --					format = FORMAT_CANONICAL;
    -+					arg_path_format = PATH_FORMAT_CANONICAL;
    - 				} else if (!strcmp(arg, "relative")) {
    --					format = FORMAT_RELATIVE;
    -+					arg_path_format = PATH_FORMAT_RELATIVE;
    - 				} else {
    - 					die(_("unknown argument to --path-format: %s"), arg);
    - 				}
    -@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    - 			if (!strcmp(arg, "--show-toplevel")) {
    - 				const char *work_tree = repo_get_work_tree(the_repository);
    - 				if (work_tree)
    --					print_path(work_tree, prefix, format, DEFAULT_UNMODIFIED);
    -+					print_path(work_tree, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
    - 				else
    - 					die(_("this operation must be run in a work tree"));
    - 				continue;
    -@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    - 			if (!strcmp(arg, "--show-superproject-working-tree")) {
    - 				struct strbuf superproject = STRBUF_INIT;
    - 				if (get_superproject_working_tree(&superproject))
    --					print_path(superproject.buf, prefix, format, DEFAULT_UNMODIFIED);
    -+					print_path(superproject.buf, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
    - 				strbuf_release(&superproject);
    - 				continue;
    - 			}
    -@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    - 				const char *gitdir = getenv(GIT_DIR_ENVIRONMENT);
    - 				char *cwd;
    - 				int len;
    --				enum format_type wanted = format;
    -+				enum path_format wanted = arg_path_format;
    - 				if (arg[2] == 'g') {	/* --git-dir */
    - 					if (gitdir) {
    --						print_path(gitdir, prefix, format, DEFAULT_UNMODIFIED);
    -+						print_path(gitdir, prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
    - 						continue;
    - 					}
    - 					if (!prefix) {
    --						print_path(".git", prefix, format, DEFAULT_UNMODIFIED);
    -+						print_path(".git", prefix, arg_path_format, PATH_FORMAT_UNMODIFIED);
    - 						continue;
    - 					}
    - 				} else {		/* --absolute-git-dir */
    --					wanted = FORMAT_CANONICAL;
    -+					wanted = PATH_FORMAT_CANONICAL;
    - 					if (!gitdir && !prefix)
    - 						gitdir = ".git";
    - 					if (gitdir) {
    -@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    - 				strbuf_reset(&buf);
    - 				strbuf_addf(&buf, "%s%s.git", cwd, len && cwd[len-1] != '/' ? "/" : "");
    - 				free(cwd);
    --				print_path(buf.buf, prefix, wanted, DEFAULT_CANONICAL);
    -+				print_path(buf.buf, prefix, wanted, PATH_FORMAT_CANONICAL);
    - 				continue;
    - 			}
    - 			if (!strcmp(arg, "--git-common-dir")) {
    --				print_path(repo_get_common_dir(the_repository), prefix, format, DEFAULT_RELATIVE_IF_SHARED);
    -+				print_path(repo_get_common_dir(the_repository), prefix, arg_path_format, PATH_FORMAT_RELATIVE_IF_SHARED);
    - 				continue;
    - 			}
    - 			if (!strcmp(arg, "--is-inside-git-dir")) {
    -@@ builtin/rev-parse.c: int cmd_rev_parse(int argc,
    - 				if (the_repository->index->split_index) {
    - 					const struct object_id *oid = &the_repository->index->split_index->base_oid;
    - 					const char *path = repo_git_path_replace(the_repository, &buf, "sharedindex.%s", oid_to_hex(oid));
    --					print_path(path, prefix, format, DEFAULT_RELATIVE);
    -+					print_path(path, prefix, arg_path_format, PATH_FORMAT_RELATIVE);
    - 				}
    - 				continue;
    - 			}
3:  7aecf1e806 = 3:  a50c75a55b repo: add path.commondir with absolute and relative suffix formatting
4:  f30010b76c = 4:  1dd22e5cd4 repo: add path.gitdir with absolute and relative suffix formatting
-- 
2.54.0

