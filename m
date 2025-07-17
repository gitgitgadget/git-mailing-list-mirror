Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A77258CE5
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752738633; cv=none; b=L459rG/L6ypIn7/Kl9tqiCxBerHTtprIpJgsjXKdWn6qKgyfjredCiPdv971CiFEWpgVgc4H9K05hdZ2dy+00UzMTyg1ESv5fB8DueTpAINkeOiYgIgLNMt8fux6oYRvUjTHMilcdbZBImSMshMvJ7S4u53IJSpm2DT/o9WZS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752738633; c=relaxed/simple;
	bh=AkUoKfHYB4VJKJCjMPjPekoU7/YGQjiqqtgooaqAoGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YjuDF06edQrG4RtRSlyWEr/JH5gwhdgJDjkNvfWHhe/trR0lhjWU5B8Uw6L1F4vzECD6G2oCozFnevmitu84KbhBFNNtx/v4tHIQeTZIy8JTukDS9u0XlUNuKETBiP0wwat2QazY9JMiA1dl9hxD6X65KyxAysFEwjE+0PJVXQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RyfUJ+xg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyfUJ+xg"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3137c20213cso717357a91.3
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752738631; x=1753343431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6bh9lr+ztevwIUK3PdoO9O6SeQ0v3AUhZ21ELbWFSc=;
        b=RyfUJ+xgF0VnxTTlXV+6f+LmoEch+3IuJqAOhvJf+0MFm+A15euIdw/5pT0N8ErhOb
         LyCIkDPdkQfAA3+EDc+l0u7AfsZ/0CAdtWLzou3D6IUsnG7jKvxyPYltzghrwOKTN+Ts
         laCWPjKHK5OCw+cpE16ZsJTyW802lqGPtvqsTcrXYtx5GdfgCrLGXB+YjcQ422N3ylmn
         6nlaEvx3KHKxu22nbUjC8CRunkCFCfSzL8tNpCMDZiM2Vlu/Efe8RS5fMFtLNhbwxYc7
         8FoLxQekZpdEwnBxrIu3mazDd8Tmm8m7UbrE7Rf4mmZyiBjAGavn4JCP74gfjTZPtzz0
         8ORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752738631; x=1753343431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F6bh9lr+ztevwIUK3PdoO9O6SeQ0v3AUhZ21ELbWFSc=;
        b=CoGLQnfMmM2eWqTGp0nkgnFwViUpBdlOrhvyyAffSdDugIV2tSXHOkfzgi3RSpr5Vk
         vzzL3T7yHlubl3f7kuzluOYK+9sm3alj9AxElM3nn59kAocT7QqiPnd673N2E+HgCF7V
         //VPffuy/ZF1nA+rO1vaZ2ogyDMQqotLOkX40lozR7/uoevLFLd8L336nBpmZ5IrIkWC
         lSXXMzuk/2zwgbYIln0vfY2rlu4FC4I2s7M5yJXn760F9bZMXZ6f6TmSBDSfdHOoZpxY
         D/3d8TWgtXTNlQHfXBYXW83Qro1VzBhoW4/d4toUbeSELMkTslwj8POc30jmH9dhRIKL
         Q8pg==
X-Gm-Message-State: AOJu0Yz+ztregD2M6++hi6fhc0/ROQaxxsuoegAdJaiLmnjGcVw04mRw
	D7z13my2QfvVvYc3495AsxsjPX6+wXZwDJkMfm+RMqoQltELp67vheRdlK2wYw==
X-Gm-Gg: ASbGnctQ/QLRru+qywwUqH1s3xdGxzE7b86A3i4420/M/OP7QhCmO/SLiTq2zOtLpXP
	RGVq7GdDKsKEUreTtV5BNkVtO8pB5HS9sPxgu8MsEu9rMNEQYVVF+yZdglN4G+U1y6gAsn5D6Qo
	C3flqFF10O/mWE1VCKwBSwzSiuBW6LaLCsSzsApPmdhZGdR1AR+LHTMo9waGgMbBfM8bDnffKQB
	qIHhNO0wMpo4kJ1CqBmq6YedNEUYi7wUAs1zHuT7rvGsE1B8TSkKQEiFHidNRDNPOlB4B1spz2N
	bRlS6M2ZZF83XUE0W+WIJYESNQBcE0mzwhwjGvEGgQraolobn0dPvJc2+TzIS18m9vVTwmHlyUB
	ZDNso64xlxlGA5J4/CMc=
X-Google-Smtp-Source: AGHT+IGi8sbfD64zgUX1gOvFmpQPCivSPN6O3vWu1Kfmwy2PnBmT0gTMEW1WVRihnCD0JVthkClUig==
X-Received: by 2002:a17:90b:3b4e:b0:313:f83a:e473 with SMTP id 98e67ed59e1d1-31c9f4124e8mr7945677a91.15.1752738630638;
        Thu, 17 Jul 2025 00:50:30 -0700 (PDT)
Received: from meet.. ([103.176.11.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e6a68sm2877518a91.19.2025.07.17.00.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 00:50:30 -0700 (PDT)
From: Meet Soni <meetsoni3017@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	shejialuo@gmail.com,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Meet Soni <meetsoni3017@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Victoria Dye <vdye@github.com>
Subject: [GSoC][RFC PATCH v2 1/2] builtin/refs: add list subcommand
Date: Thu, 17 Jul 2025 13:20:08 +0530
Message-Id: <20250717075009.26262-2-meetsoni3017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250717075009.26262-1-meetsoni3017@gmail.com>
References: <20250627074934.1761897-1-meetsoni3017@gmail.com>
 <20250717075009.26262-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Git's reference management is distributed across multiple commands. As
part of an ongoing effort to consolidate and modernize reference
handling, introduce a `list` subcommand under the `git refs` umbrella as
a replacement for `git for-each-ref`.

Implement `cmd_refs_list` as a thin wrapper around `cmd_for_each_ref`
instead of duplicating its logic. Forward all arguments to the existing
function to ensure behavior is identical.

Add documentation for the new command. To keep the documentation DRY and
consistent with `git-for-each-ref(1)`, refactor the shared command
options into a standalone file. Use the AsciiDoc `include::` macro to
embed these options in both man pages.

This prevents duplication in both code and documentation, ensuring that
`refs list` benefits from any future fixes to the underlying
`for-each-ref` machinery and its shared documentation.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: shejialuo <shejialuo@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: Meet Soni <meetsoni3017@gmail.com>
---
 Documentation/git-for-each-ref.adoc  | 80 +---------------------------
 Documentation/git-refs.adoc          | 16 ++++++
 Documentation/refs-list-options.adoc | 80 ++++++++++++++++++++++++++++
 builtin/for-each-ref.c               | 24 +++++++--
 builtin/refs.c                       | 35 ++++++++++++
 5 files changed, 152 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/refs-list-options.adoc

diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
index 5ef89fc0fe..f7bbc1902a 100644
--- a/Documentation/git-for-each-ref.adoc
+++ b/Documentation/git-for-each-ref.adoc
@@ -28,85 +28,7 @@ host language allowing their direct evaluation in that language.
 
 OPTIONS
 -------
-<pattern>...::
-	If one or more patterns are given, only refs are shown that
-	match against at least one pattern, either using fnmatch(3) or
-	literally, in the latter case matching completely or from the
-	beginning up to a slash.
-
---stdin::
-	If `--stdin` is supplied, then the list of patterns is read from
-	standard input instead of from the argument list.
-
---count=<count>::
-	By default the command shows all refs that match
-	`<pattern>`.  This option makes it stop after showing
-	that many refs.
-
---sort=<key>::
-	A field name to sort on.  Prefix `-` to sort in
-	descending order of the value.  When unspecified,
-	`refname` is used.  You may use the --sort=<key> option
-	multiple times, in which case the last key becomes the primary
-	key.
-
---format=<format>::
-	A string that interpolates `%(fieldname)` from a ref being shown and
-	the object it points at. In addition, the string literal `%%`
-	renders as `%` and `%xx` - where `xx` are hex digits - renders as
-	the character with hex code `xx`. For example, `%00` interpolates to
-	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
-+
-When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
-TAB %(refname)`.
-
---color[=<when>]::
-	Respect any colors specified in the `--format` option. The
-	`<when>` field must be one of `always`, `never`, or `auto` (if
-	`<when>` is absent, behave as if `always` was given).
-
---shell::
---perl::
---python::
---tcl::
-	If given, strings that substitute `%(fieldname)`
-	placeholders are quoted as string literals suitable for
-	the specified host language.  This is meant to produce
-	a scriptlet that can directly be `eval`ed.
-
---points-at=<object>::
-	Only list refs which points at the given object.
-
---merged[=<object>]::
-	Only list refs whose tips are reachable from the
-	specified commit (HEAD if not specified).
-
---no-merged[=<object>]::
-	Only list refs whose tips are not reachable from the
-	specified commit (HEAD if not specified).
-
---contains[=<object>]::
-	Only list refs which contain the specified commit (HEAD if not
-	specified).
-
---no-contains[=<object>]::
-	Only list refs which don't contain the specified commit (HEAD
-	if not specified).
-
---ignore-case::
-	Sorting and filtering refs are case insensitive.
-
---omit-empty::
-	Do not print a newline after formatted refs where the format expands
-	to the empty string.
-
---exclude=<pattern>::
-	If one or more patterns are given, only refs which do not match
-	any excluded pattern(s) are shown. Matching is done using the
-	same rules as `<pattern>` above.
-
---include-root-refs::
-	List root refs (HEAD and pseudorefs) apart from regular refs.
+include::refs-list-options.adoc[]
 
 FIELD NAMES
 -----------
diff --git a/Documentation/git-refs.adoc b/Documentation/git-refs.adoc
index 4d6dc994f9..ded90f435b 100644
--- a/Documentation/git-refs.adoc
+++ b/Documentation/git-refs.adoc
@@ -11,6 +11,13 @@ SYNOPSIS
 [synopsis]
 git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
 git refs verify [--strict] [--verbose]
+git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
+	      [(--sort=<key>)...] [--format=<format>]
+	      [--include-root-refs] [ --stdin | <pattern>... ]
+	      [--points-at=<object>]
+	      [--merged[=<object>]] [--no-merged[=<object>]]
+	      [--contains[=<object>]] [--no-contains[=<object>]]
+	      [--exclude=<pattern> ...]
 
 DESCRIPTION
 -----------
@@ -26,6 +33,11 @@ migrate::
 verify::
 	Verify reference database consistency.
 
+list::
+	List references in the repository with support for filtering,
+	formatting, and sorting. This subcommand is an alias for
+	linkgit:git-for-each-ref[1] and offers identical functionality.
+
 OPTIONS
 -------
 
@@ -57,6 +69,10 @@ The following options are specific to 'git refs verify':
 --verbose::
 	When verifying the reference database consistency, be chatty.
 
+The following options are specific to 'git refs list':
+
+include::refs-list-options.adoc[]
+
 KNOWN LIMITATIONS
 -----------------
 
diff --git a/Documentation/refs-list-options.adoc b/Documentation/refs-list-options.adoc
new file mode 100644
index 0000000000..9d6557cdb9
--- /dev/null
+++ b/Documentation/refs-list-options.adoc
@@ -0,0 +1,80 @@
+// Shared options for for-each-ref and refs list
+<pattern>...::
+	If one or more patterns are given, only refs are shown that
+	match against at least one pattern, either using fnmatch(3) or
+	literally, in the latter case matching completely or from the
+	beginning up to a slash.
+
+--stdin::
+	If `--stdin` is supplied, then the list of patterns is read from
+	standard input instead of from the argument list.
+
+--count=<count>::
+	By default the command shows all refs that match
+	`<pattern>`.  This option makes it stop after showing
+	that many refs.
+
+--sort=<key>::
+	A field name to sort on.  Prefix `-` to sort in
+	descending order of the value.  When unspecified,
+	`refname` is used.  You may use the --sort=<key> option
+	multiple times, in which case the last key becomes the primary
+	key.
+
+--format=<format>::
+	A string that interpolates `%(fieldname)` from a ref being shown and
+	the object it points at. In addition, the string literal `%%`
+	renders as `%` and `%xx` - where `xx` are hex digits - renders as
+	the character with hex code `xx`. For example, `%00` interpolates to
+	`\0` (NUL), `%09` to `\t` (TAB), and `%0a` to `\n` (LF).
++
+When unspecified, `<format>` defaults to `%(objectname) SPC %(objecttype)
+TAB %(refname)`.
+
+--color[=<when>]::
+	Respect any colors specified in the `--format` option. The
+	`<when>` field must be one of `always`, `never`, or `auto` (if
+	`<when>` is absent, behave as if `always` was given).
+
+--shell::
+--perl::
+--python::
+--tcl::
+	If given, strings that substitute `%(fieldname)`
+	placeholders are quoted as string literals suitable for
+	the specified host language.  This is meant to produce
+	a scriptlet that can directly be `eval`ed.
+
+--points-at=<object>::
+	Only list refs which points at the given object.
+
+--merged[=<object>]::
+	Only list refs whose tips are reachable from the
+	specified commit (HEAD if not specified).
+
+--no-merged[=<object>]::
+	Only list refs whose tips are not reachable from the
+	specified commit (HEAD if not specified).
+
+--contains[=<object>]::
+	Only list refs which contain the specified commit (HEAD if not
+	specified).
+
+--no-contains[=<object>]::
+	Only list refs which don't contain the specified commit (HEAD
+	if not specified).
+
+--ignore-case::
+	Sorting and filtering refs are case insensitive.
+
+--omit-empty::
+	Do not print a newline after formatted refs where the format expands
+	to the empty string.
+
+--exclude=<pattern>::
+	If one or more patterns are given, only refs which do not match
+	any excluded pattern(s) are shown. Matching is done using the
+	same rules as `<pattern>` above.
+
+--include-root-refs::
+	List root refs (HEAD and pseudorefs) apart from regular refs.
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 3d2207ec77..d7d8279049 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -16,11 +16,27 @@ static char const * const for_each_ref_usage[] = {
 	NULL
 };
 
+#define REFS_LIST_USAGE \
+	N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
+	   "              [(--sort=<key>)...] [--format=<format>]\n" \
+	   "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
+	   "              [--points-at=<object>]\n" \
+	   "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
+	   "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
+	   "              [--exclude=<pattern> ...]")
+
+static char const * const refs_list_usage[] = {
+	REFS_LIST_USAGE,
+	NULL
+};
+
 int cmd_for_each_ref(int argc,
 		     const char **argv,
 		     const char *prefix,
 		     struct repository *repo)
 {
+	int cmd_is_refs_list = !strcmp(argv[0], "refs list");
+	const char *const *opt_usage = cmd_is_refs_list ? refs_list_usage : for_each_ref_usage;
 	struct ref_sorting *sorting;
 	struct string_list sorting_options = STRING_LIST_INIT_DUP;
 	int icase = 0, include_root_refs = 0, from_stdin = 0;
@@ -67,17 +83,17 @@ int cmd_for_each_ref(int argc,
 	/* Set default (refname) sorting */
 	string_list_append(&sorting_options, "refname");
 
-	parse_options(argc, argv, prefix, opts, for_each_ref_usage, 0);
+	parse_options(argc, argv, prefix, opts, opt_usage, 0);
 	if (format.array_opts.max_count < 0) {
 		error("invalid --count argument: `%d'", format.array_opts.max_count);
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(opt_usage, opts);
 	}
 	if (HAS_MULTI_BITS(format.quote_style)) {
 		error("more than one quoting style?");
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(opt_usage, opts);
 	}
 	if (verify_ref_format(&format))
-		usage_with_options(for_each_ref_usage, opts);
+		usage_with_options(opt_usage, opts);
 
 	sorting = ref_sorting_options(&sorting_options);
 	ref_sorting_set_sort_flags_all(sorting, REF_SORTING_ICASE, icase);
diff --git a/builtin/refs.c b/builtin/refs.c
index 998d2a2c1c..41e29d1b5f 100644
--- a/builtin/refs.c
+++ b/builtin/refs.c
@@ -3,6 +3,7 @@
 #include "config.h"
 #include "fsck.h"
 #include "parse-options.h"
+#include "ref-filter.h"
 #include "refs.h"
 #include "strbuf.h"
 #include "worktree.h"
@@ -13,6 +14,15 @@
 #define REFS_VERIFY_USAGE \
 	N_("git refs verify [--strict] [--verbose]")
 
+#define REFS_LIST_USAGE \
+	N_("git refs list [--count=<count>] [--shell|--perl|--python|--tcl]\n" \
+	   "              [(--sort=<key>)...] [--format=<format>]\n" \
+	   "              [--include-root-refs] [ --stdin | <pattern>... ]\n" \
+	   "              [--points-at=<object>]\n" \
+	   "              [--merged[=<object>]] [--no-merged[=<object>]]\n" \
+	   "              [--contains[=<object>]] [--no-contains[=<object>]]\n" \
+	   "              [--exclude=<pattern> ...]")
+
 static int cmd_refs_migrate(int argc, const char **argv, const char *prefix,
 			    struct repository *repo UNUSED)
 {
@@ -101,6 +111,29 @@ static int cmd_refs_verify(int argc, const char **argv, const char *prefix,
 	return ret;
 }
 
+static int cmd_refs_list(int argc, const char **argv, const char *prefix,
+		  struct repository *repo)
+{
+	struct strvec args = STRVEC_INIT;
+	const char **args_copy;
+	int ret;
+
+	strvec_push(&args, "refs list");
+
+	for (int i = 1; i < argc; i++)
+		strvec_push(&args, argv[i]);
+
+	CALLOC_ARRAY(args_copy, args.nr + 1);
+	COPY_ARRAY(args_copy, args.v, args.nr);
+
+	ret = cmd_for_each_ref(args.nr, args_copy, prefix, repo);
+
+	strvec_clear(&args);
+	free(args_copy);
+
+	return ret;
+}
+
 int cmd_refs(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -109,12 +142,14 @@ int cmd_refs(int argc,
 	const char * const refs_usage[] = {
 		REFS_MIGRATE_USAGE,
 		REFS_VERIFY_USAGE,
+		REFS_LIST_USAGE,
 		NULL,
 	};
 	parse_opt_subcommand_fn *fn = NULL;
 	struct option opts[] = {
 		OPT_SUBCOMMAND("migrate", &fn, cmd_refs_migrate),
 		OPT_SUBCOMMAND("verify", &fn, cmd_refs_verify),
+		OPT_SUBCOMMAND("list", &fn, cmd_refs_list),
 		OPT_END(),
 	};
 
-- 
2.34.1

