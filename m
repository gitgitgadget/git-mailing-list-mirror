Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5002A3D349C
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 09:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784538628; cv=none; b=SMYEIDmGm4YxKe+WMNasddV/7gf9BiGhI8T35BxSrcoHeLO4vkidHZ50Sjzw1YN9ncv4GoCUY7McPJYcFdxOBkaErdtX7gwNyp7yDRVhCNOa7ElOYkS2bNOwpFcUbzsxvgQa6dOGsA/4BARieugDjET/gLZL3K+p5ew44afCy9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784538628; c=relaxed/simple;
	bh=7OLlSEx72llHZ/93qmQPtabSAqNqVBnJquQS+SVs/0c=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=BPtHdIVUyTnKQPoFnUWqhsxOlhwJh/ME1rQufp+WYWb0vygEu/qqhQY443qL58txcmWg4ispl5kIwhMHeOcXwstGThLAq8ClPyy5J/vL11bM44OykFeaHkzxv6OIuAoNDlqMXjLCfgHcGcY9nownh2Zaq2l+cLFfGfJdmyxLgmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMhQSAoF; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMhQSAoF"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ff5d1b0f91so65916226d6.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 02:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784538625; x=1785143425; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=E4ZlJE7Ib6KZFO/cc1jzGqVuHX5IlXeSaf+Rw3oFL2Y=;
        b=BMhQSAoF0LSL9wfVJARx7d6s01BdfXZrIskEgOCuG6ktAR1vbVVUq4eyiC9pfS0i5d
         ZSkQmokgzC1q/T9uMh5IuAjU8ho5RjTF8iJ8Jhl0Qy4nWOzrpOOMQtPvA2DYqoMKoXHc
         yLz580ZWUXocoF0Ot3x3nMKW8s3mvK7Dbvh0zuMjcBjc2azUB+5R1uKJ2HjuAHWIRDlI
         5Hy0tO/2xcmYp4zdixKCd4M02mA1GEqKqeboxhh8iwUBkQrAPwF8As2XDmqnosBW9pTG
         nsJZStnQhxf6K2Wfp5TqlX83NWZ839crfn/yUBlpwBkGnSuPJzusWceKU+6nHcB8UbgW
         Csqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784538625; x=1785143425;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E4ZlJE7Ib6KZFO/cc1jzGqVuHX5IlXeSaf+Rw3oFL2Y=;
        b=XxZrKj23qdKL9fbkYkttupTyz8GeiwZdMyi0qBX7aFGzNQvyzB3hqelr5WDbP1jYoT
         A4xMSajCLGQ8HQk1+tD1mqoMKoGJ2bxRpumUeifjFp0PW07dpmFTUQdFQFlTL8vGw7u9
         hjYwxsz1vCs2ibeKgxJh6i7pFa75dt9a2yffSOF0QYlbEBtTBlktmDWsG9/sQ2JeaOLj
         dYazrwTLZXjA102kLYlHiHXjomyJsSMoa0doRBODsa++9ZUswoIVuvimb/ThVAw3XV8K
         14az7+a/oq7L+HS3RRQUCVM60m85vqpmNq5MrfhrcYaX6NxKbARPECQjsOMBZCIDtnwz
         bYyg==
X-Gm-Message-State: AOJu0YyDB2GLMLxRTuSz1auwfSMRMGgTRm4a6wsIbKztl3qpsadwZwkv
	NxaN81rhwJB3mLfxMBBDOhjpMrd2ZxWFllYCIwbDMWpdMKsIxJqWDpdARdf+CQ==
X-Gm-Gg: AfdE7ckYFSZiarJvFDvvDnNl2sz8H1lJjWCyB5TQr6Q8GuTYlhVcduKg/6dsAuNP9yK
	jiSCDop726QSA8G3KG1qXQcV+EcLg2kLfgLxnwWRQz86PxOV+HkeuvFyOtniiPub0eYn9oDWE51
	GWT+2kjx409Fwp8xzyH9G1SJE1nLJrI2iSzALsDxzr0WEphHaBEt/cd0dBi43Lghm6rTlO9/CEC
	rNfjj21/tVgb0PwG1/GVd6m/7SOJjaMfnWJi1yVUpyOsmXrGaMM+qu1NtIiFwxo3VGOHdAbNK35
	zRtER9SjLczSuXnsmilh0ZFNmGdvW7VNBUKI/IqJE9oeR9RT1sCn48aTV0kKCn863nKtVgCuYxK
	9C2p/TXyBz5lK64Zv5vg+DSW3hmw5rKbhCCg0W4Fx4l+MVK4Fg3LJDgsPrBS8Eg9SD1BqT8Eilp
	gYZYV/
X-Received: by 2002:a05:6214:5886:b0:8ef:3407:3dd1 with SMTP id 6a1803df08f44-907783461b3mr131842186d6.6.1784538624703;
        Mon, 20 Jul 2026 02:10:24 -0700 (PDT)
Received: from [127.0.0.1] ([172.208.23.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778728a50sm86423456d6.47.2026.07.20.02.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 02:10:23 -0700 (PDT)
Message-Id: <542f4b2c8065818b887437add90130d2090fa0f2.1784538619.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
References: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
	<pull.2335.v3.git.git.1784538619.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 09:10:19 +0000
Subject: [PATCH v3 2/2] bisect: add --reset-when-found to leave when done
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a bisection finishes, "git bisect" reports the first bad commit
but leaves the session active until "git bisect reset" is run by hand.

Add a "--reset-when-found[=<where>]" option, accepted by both "git
bisect start" and "git bisect run", that resets as soon as the first
bad commit is found. The "original" value returns to the commit checked
out before "git bisect start", while "found" leaves the first bad commit
checked out; omitting the value defaults to "original".

Persist the selected target in a BISECT_RESET_WHEN_FOUND state file
and perform the reset quietly.

For "git bisect run", defer the reset until after the captured output
is printed and BISECT_RUN is closed. This lets cleanup remove the file
on systems that cannot unlink an open file.

Reject this option together with "--no-checkout", since that mode must
not check out either target.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-bisect.adoc |  14 +++-
 bisect.c                      |   2 +
 builtin/bisect.c              | 134 ++++++++++++++++++++++++++++++----
 t/t6030-bisect-porcelain.sh   | 109 +++++++++++++++++++++++++++
 4 files changed, 243 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index d2115b2990..aabddd42ca 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
+		 [--no-checkout] [--first-parent] [--reset-when-found[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]
 git bisect (bad|new|<term-new>) [<rev>]
 git bisect (good|old|<term-old>) [<rev>...]
 git bisect terms [--term-(good|old) | --term-(bad|new)]
@@ -20,7 +20,7 @@ git bisect reset [<commit>]
 git bisect (visualize|view)
 git bisect replay <logfile>
 git bisect log
-git bisect run <cmd> [<arg>...]
+git bisect run [--reset-when-found[=<where>]] <cmd> [<arg>...]
 git bisect help
 
 DESCRIPTION
@@ -385,6 +385,16 @@ ignored.
 This option is particularly useful in avoiding false positives when a merged
 branch contained broken or non-buildable commits, but the merge itself was OK.
 
+`--reset-when-found[=<where>]`::
+	Once the first bad commit is found, report it and clean up the
+	bisection state. `<where>` may be `original` to return to the commit
+	checked out before `git bisect start`, or `found` to leave the first
+	bad commit checked out. If `<where>` is omitted, it defaults to
+	`original`.
++
+This option may be given to `git bisect start` or to `git bisect run`. It
+cannot be used for a bisection started with `--no-checkout`.
+
 EXAMPLES
 --------
 
diff --git a/bisect.c b/bisect.c
index 94c7028d2a..d426fcd5a9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -488,6 +488,7 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_reset_when_found, "BISECT_RESET_WHEN_FOUND")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1211,6 +1212,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
+	unlink_or_warn(git_path_bisect_reset_when_found());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 0e49ca23ae..de13f22f8a 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -24,11 +24,12 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_reset_when_found, "BISECT_RESET_WHEN_FOUND")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 #define BUILTIN_GIT_BISECT_START_USAGE \
 	N_("git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]\n" \
-	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]")
+	   "                 [--no-checkout] [--first-parent] [--reset-when-found[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]")
 #define BUILTIN_GIT_BISECT_BAD_USAGE \
 	N_("git bisect (bad|new|<term-new>) [<rev>]")
 #define BUILTIN_GIT_BISECT_GOOD_USAGE \
@@ -48,7 +49,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 #define BUILTIN_GIT_BISECT_LOG_USAGE \
 	"git bisect log"
 #define BUILTIN_GIT_BISECT_RUN_USAGE \
-	N_("git bisect run <cmd> [<arg>...]")
+	N_("git bisect run [--reset-when-found[=<where>]] <cmd> [<arg>...]")
 #define BUILTIN_GIT_BISECT_HELP_USAGE \
 	"git bisect help"
 
@@ -68,6 +69,12 @@ static const char * const git_bisect_usage[] = {
 	NULL
 };
 
+enum reset_when_found_mode {
+	RESET_WHEN_FOUND_NONE,
+	RESET_WHEN_FOUND_TO_ORIGINAL,
+	RESET_WHEN_FOUND_TO_FOUND,
+};
+
 struct add_bisect_ref_data {
 	struct rev_info *revs;
 	unsigned int object_flags;
@@ -272,6 +279,61 @@ static int bisect_reset(const char *commit, int quiet)
 	return bisect_clean_state();
 }
 
+static int parse_reset_when_found(const char *value,
+				  enum reset_when_found_mode *mode)
+{
+	if (!strcmp(value, "original"))
+		*mode = RESET_WHEN_FOUND_TO_ORIGINAL;
+	else if (!strcmp(value, "found"))
+		*mode = RESET_WHEN_FOUND_TO_FOUND;
+	else
+		return error(_("invalid value for '--reset-when-found': '%s'"),
+			     value);
+
+	return 0;
+}
+
+static const char *reset_when_found_mode_name(enum reset_when_found_mode mode)
+{
+	switch (mode) {
+	case RESET_WHEN_FOUND_TO_ORIGINAL:
+		return "original";
+	case RESET_WHEN_FOUND_TO_FOUND:
+		return "found";
+	case RESET_WHEN_FOUND_NONE:
+		BUG("no name for unset reset-when-found mode");
+	}
+	BUG("unknown reset-when-found mode %d", mode);
+}
+
+static int bisect_reset_when_found(struct bisect_terms *terms)
+{
+	struct strbuf value = STRBUF_INIT;
+	enum reset_when_found_mode mode;
+	char *commit = NULL;
+	int res;
+
+	if (strbuf_read_file(&value, git_path_bisect_reset_when_found(), 0) < 0) {
+		res = error_errno(_("could not read '%s'"),
+				  git_path_bisect_reset_when_found());
+		goto cleanup;
+	}
+	strbuf_trim(&value);
+	if (parse_reset_when_found(value.buf, &mode)) {
+		res = -1;
+		goto cleanup;
+	}
+
+	if (mode == RESET_WHEN_FOUND_TO_FOUND)
+		commit = xstrfmt("refs/bisect/%s", terms->term_bad);
+	res = bisect_reset(commit, 1);
+
+cleanup:
+	free(commit);
+	strbuf_release(&value);
+	return res;
+}
+
 static void log_commit(FILE *fp,
 		       const char *fmt, const char *state,
 		       struct commit *commit)
@@ -677,7 +739,8 @@ static int bisect_successful(struct bisect_terms *terms)
 	return res;
 }
 
-static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_next(struct bisect_terms *terms,
+				     const char *prefix, bool defer_reset)
 {
 	enum bisect_error res;
 
@@ -692,6 +755,9 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 
 	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 		res = bisect_successful(terms);
+		if (!res && !defer_reset &&
+		    !is_empty_or_missing_file(git_path_bisect_reset_when_found()))
+			res = bisect_reset_when_found(terms);
 		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
 	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
 		res = bisect_skipped_commits(terms);
@@ -700,14 +766,15 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 	return res;
 }
 
-static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
+					  const char *prefix, bool defer_reset)
 {
 	if (bisect_next_check(terms, NULL)) {
 		bisect_print_status(terms);
 		return BISECT_OK;
 	}
 
-	return bisect_next(terms, prefix);
+	return bisect_next(terms, prefix, defer_reset);
 }
 
 static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
@@ -715,6 +782,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
+	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
 	int flags, pathspec_pos;
 	enum bisect_error res = BISECT_OK;
@@ -747,6 +815,13 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--first-parent")) {
 			first_parent_only = 1;
+		} else if (!strcmp(arg, "--reset-when-found")) {
+			reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
+		} else if (skip_prefix(arg, "--reset-when-found=", &arg)) {
+			if (parse_reset_when_found(arg, &reset_when_found)) {
+				res = BISECT_FAILED;
+				goto finish;
+			}
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -784,6 +859,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			break;
 		}
 	}
+	if (reset_when_found != RESET_WHEN_FOUND_NONE && no_checkout) {
+		res = error(_("'--reset-when-found' cannot be used with '--no-checkout'"));
+		goto finish;
+	}
 	pathspec_pos = i;
 
 	/*
@@ -861,6 +940,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	if (first_parent_only)
 		write_file(git_path_bisect_first_parent(), "\n");
 
+	if (reset_when_found != RESET_WHEN_FOUND_NONE)
+		write_file(git_path_bisect_reset_when_found(), "%s\n",
+			   reset_when_found_mode_name(reset_when_found));
+
 	if (no_checkout) {
 		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
@@ -902,7 +985,7 @@ finish:
 	if (res)
 		return res;
 
-	res = bisect_auto_next(terms, NULL);
+	res = bisect_auto_next(terms, NULL, false);
 	if (!is_bisect_success(res))
 		bisect_clean_state();
 	return res;
@@ -941,7 +1024,7 @@ static int bisect_autostart(struct bisect_terms *terms)
 }
 
 static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
-				      const char **argv)
+				      const char **argv, bool defer_reset)
 {
 	const char *state;
 	int i, verify_expected = 1;
@@ -1018,7 +1101,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
 	}
 
 	oid_array_clear(&revs);
-	return bisect_auto_next(terms, NULL);
+	return bisect_auto_next(terms, NULL, defer_reset);
 }
 
 static enum bisect_error bisect_log(void)
@@ -1107,7 +1190,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (res)
 		return BISECT_FAILED;
 
-	return bisect_auto_next(terms, NULL);
+	return bisect_auto_next(terms, NULL, false);
 }
 
 static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
@@ -1141,7 +1224,7 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
 			strvec_push(&argv_state, argv[i]);
 		}
 	}
-	res = bisect_state(terms, argv_state.nr, argv_state.v);
+	res = bisect_state(terms, argv_state.nr, argv_state.v, false);
 
 	strvec_clear(&argv_state);
 	return res;
@@ -1239,6 +1322,8 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
+	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
+	const char *reset_when_found_arg;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
@@ -1246,6 +1331,23 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
 
+	if (argc && !strcmp(argv[0], "--reset-when-found"))
+		reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
+	else if (argc && skip_prefix(argv[0], "--reset-when-found=",
+				    &reset_when_found_arg)) {
+		if (parse_reset_when_found(reset_when_found_arg, &reset_when_found))
+			return BISECT_FAILED;
+	}
+
+	if (reset_when_found != RESET_WHEN_FOUND_NONE) {
+		if (refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
+			return error(_("'--reset-when-found' cannot be used with '--no-checkout'"));
+		write_file(git_path_bisect_reset_when_found(), "%s\n",
+			   reset_when_found_mode_name(reset_when_found));
+		argc--;
+		argv++;
+	}
+
 	if (!argc) {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
@@ -1304,7 +1406,7 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 		saved_stdout = dup(1);
 		dup2(temporary_stdout_fd, 1);
 
-		res = bisect_state(terms, 1, &new_state);
+		res = bisect_state(terms, 1, &new_state, true);
 
 		fflush(stdout);
 		dup2(saved_stdout, 1);
@@ -1320,7 +1422,11 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 			res = BISECT_OK;
 		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 			printf(_("bisect found first '%s' commit\n"), terms->term_bad);
-			res = BISECT_OK;
+			if (!is_empty_or_missing_file(git_path_bisect_reset_when_found()) &&
+			    bisect_reset_when_found(terms))
+				res = BISECT_FAILED;
+			else
+				res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect %s'"
 				" exited with error code %d"), new_state, res);
@@ -1379,7 +1485,7 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 		return error(_("'%s' requires 0 arguments"),
 			     "git bisect next");
 	get_terms(&terms);
-	res = bisect_next(&terms, prefix);
+	res = bisect_next(&terms, prefix, false);
 	free_terms(&terms);
 	return res;
 }
@@ -1482,7 +1588,7 @@ int cmd_bisect(int argc,
 		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
 			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
 				       options, argv[0]);
-		res = bisect_state(&terms, argc, argv);
+		res = bisect_state(&terms, argc, argv, false);
 		free_terms(&terms);
 	} else {
 		argc--;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 081116220a..7dfb871ab9 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -43,6 +43,38 @@ test_bisect_usage () {
 	test_cmp expect actual
 }
 
+test_bisect_state_file () {
+	test_path_is_file "$(git rev-parse --git-path "$1")"
+}
+
+test_bisect_state_missing () {
+	test_path_is_missing "$(git rev-parse --git-path "$1")"
+}
+
+bisect_start_and_finish () {
+	git bisect start "$1" $HASH4 $HASH2 &&
+	git bisect bad
+}
+
+bisect_run_reset_when_found () {
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello >/dev/null
+	EOF
+	git bisect start $HASH4 $HASH2 &&
+	git bisect run "$1" ./test_script.sh >my_bisect_log.txt &&
+	test_grep "$HASH3 is the first .bad. commit" my_bisect_log.txt &&
+	test_bisect_state_missing BISECT_RUN
+}
+
+test_reset_when_found_fails () {
+	local pattern="$1" &&
+	local state_file="$2" &&
+	shift 2 &&
+	test_must_fail "$@" 2>err &&
+	test_grep -- "$pattern" err &&
+	test_bisect_state_missing "$state_file"
+}
+
 test_expect_success 'bisect usage' "
 	test_bisect_usage 1 git bisect reset extra1 extra2 <<-\EOF &&
 	error: 'git bisect reset' requires either no argument or a commit
@@ -453,6 +485,83 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect reset
 '
 
+test_expect_success '"git bisect start --reset-when-found" defaults to original' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	git checkout main &&
+	bisect_start_and_finish --reset-when-found &&
+	test "$HASH4" = "$(git rev-parse HEAD)" &&
+	test main = "$(git branch --show-current)" &&
+	test_bisect_state_missing BISECT_START &&
+
+	bisect_start_and_finish --reset-when-found=original &&
+	test "$HASH4" = "$(git rev-parse HEAD)" &&
+	test main = "$(git branch --show-current)" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect start --reset-when-found=found" leaves first bad checked out' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	bisect_start_and_finish --reset-when-found=found &&
+	test "$HASH3" = "$(git rev-parse HEAD)" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect run --reset-when-found" defaults to original' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	bisect_run_reset_when_found --reset-when-found &&
+	test "$HASH4" = "$(git rev-parse HEAD)" &&
+	test main = "$(git branch --show-current)" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect run --reset-when-found=found" leaves first bad checked out' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	bisect_run_reset_when_found --reset-when-found=found &&
+	test "$HASH3" = "$(git rev-parse HEAD)" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '--reset-when-found rejects an unknown reset target' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	test_reset_when_found_fails \
+		"invalid value for.*--reset-when-found.*unknown" BISECT_START \
+		git bisect start --reset-when-found=unknown $HASH4 $HASH2 &&
+
+	git bisect start $HASH4 $HASH2 &&
+	test_reset_when_found_fails \
+		"invalid value for.*--reset-when-found.*unknown" \
+		BISECT_RESET_WHEN_FOUND \
+		git bisect run --reset-when-found=unknown true
+'
+
+test_expect_success '--reset-when-found cannot be used with --no-checkout' '
+	test_when_finished "git bisect reset" &&
+	test_reset_when_found_fails \
+		"cannot be used with.*--no-checkout" BISECT_START \
+		git bisect start --reset-when-found=original --no-checkout $HASH4 $HASH2 &&
+
+	git bisect start --no-checkout $HASH4 $HASH2 &&
+	test_reset_when_found_fails \
+		"cannot be used with.*--no-checkout" BISECT_RESET_WHEN_FOUND \
+		git bisect run --reset-when-found=found true
+'
+
+test_expect_success 'without --reset-when-found the bisection state is kept' '
+	test_when_finished "git bisect reset" &&
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_bisect_state_file BISECT_START
+'
+
+test_expect_success '--reset-when-found does not leak into a later bisection' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	bisect_start_and_finish --reset-when-found &&
+
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_bisect_state_file BISECT_START
+'
+
 # We want to automatically find the commit that
 # added "Ciao" into hello.
 test_expect_success '"git bisect run" with more complex "git bisect start"' '
-- 
gitgitgadget
