Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8143337E5FD
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312866; cv=none; b=r6l05G9xYKRQnJlqWQeXMIgojGxASa2FYizC9lTsEmCzxbG0GHe9xtk74YynDkecMbQZNH7pidz85IpfP9xD62Cxpiu6A1RelR76pMYQCv+Zy8xEDk6N+wMNF84PRNqmVl731Ar4GZzcC7T7DbNaQKBB+dwXzAOzfnn/K4z7QTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312866; c=relaxed/simple;
	bh=5vni9RUVjyVhCO/7IMRXlI4saH5ANDnbYUpc2LQflws=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=HM8XIHb4NaHh40NzWrjO0S1eLK4aLESwopqK6lzx1gfWdBH1vGvMq/1icUWBp2VCE1wNvlRgpZe8QVptI6KpBXFDgcgLzI7qI7xc3rDjcXfi40avvE2KsTDin359ih60BmNti7mDTFeSWuaxPuDrmSV6Wrc1leNQJzL5vBkTsHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OuiTZ5s5; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OuiTZ5s5"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-51bfb91795eso77846261cf.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 11:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784312861; x=1784917661; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4elTaRPzQ40pJQmfyDhD1BgQyrDu2XFpYrF551Td70E=;
        b=OuiTZ5s58wQFOe9pePFx+aC6GMnDX2UMcOpDxIsNBmXBYgEOht+PKvP/kEufsqlOb3
         7sBHmswtY48wUs0R20tz/k9lINoKwKxi/+jgZ9aEZF0rzeaC+PYGb0SaiFe22MWNGk8a
         dkaCdvhXI0tFADKAorCH06hN75CYjddxFb/M9L/VaQvDfCSBQILSi3xjjSu2rqaXhvq9
         5ONmUZi49m2zF5vs0uaxI0Pq0j3idlRNAOVa0BvjcS9NWFXZ5kdZQy/gy4MKRi1tnh5t
         Hd4+QfbhPzJ1yyppCRgFh4N5rAOq9k1tS8gkjx5QVcvVwsFJkj+xdg5p0lwTQfX91CUg
         5GiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784312861; x=1784917661;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4elTaRPzQ40pJQmfyDhD1BgQyrDu2XFpYrF551Td70E=;
        b=dMk8jukxNeQSSmqEmYmNMozrAlYsnS/IU9WvPvkgmDtNdvjxwfTwnQYljG/INX8jCD
         zrKVXlngavEs0wSP0cSm6I7ses0lZXkYsCyBT4GOCmuTZKi6KcIvkWotFQqNfyyBbeBD
         zf0xjl1hgpy3cmBKVIBazaZbjZ+m2um/HVrBFOeIlwCvIWlb1XvoV6rNLok6b5z7lHh1
         WqlOFu3FsTaZJqID8raCbHVWdL9/AKTtgcrteo5ArlunfH4O0D9rzedk+PjCqESeAXxp
         HVZwls4G88dqZ/XdD59KZ137dxL9G290KHXnhK4FLqi1Ep7IzNjFgh5oYDRKr+LB/dyw
         6r3A==
X-Gm-Message-State: AOJu0YybIO1rYHw3BjxrLczWS/H54DWnv9mVV6u7nf89FvoqSGds/2qo
	QQnD5lD5aA5g0nB0GQDiMjWQjTUwNRGaLtNaiAIywc5lOtCzGLKOAnA90QjyHucs
X-Gm-Gg: AfdE7clVn1YZGBEHh0I98kVnPwCioDXkaw0qqXnTDFjLiRVmyaLDqrT9k0rbrHicwjK
	lPgqzn53FwDwNWvWUJ3LPUYprJ9CR8u58oPFStnVFVv+ARZlOoIRAKuiX18vtmx+xOazp2GxnHw
	W2RPN9xunEZ7RTCrWeNZ1PbiDscgBcmiv0vfnr+XhBiIlsH/SScc/+0SvoiEB53U/SoyLdqlbJM
	wwSGWd1vGL13lgogbKsVdxPoOjZti3HP8GCAoW4bOSX/qwtdGK4A96cIp9HcmcfMtKqztTIeeG2
	5Sv+ecHFHBghPk8A/dmjoU49aklkUIZrNulSY7tyG115tkA0bLWMbvh3LMeqvKKrZt4TVaBFSqX
	HgUy6fkOSQukMFvNFishmLHXKeMNnRzxYiNQ0eZbbEhhDaCBSLYnaZJBUSZ95Y9LYH58JPrE3Ic
	6uQh1TcA==
X-Received: by 2002:a05:622a:514a:b0:51c:7f8:2a9e with SMTP id d75a77b69052e-5213e884da1mr38832481cf.61.1784312860470;
        Fri, 17 Jul 2026 11:27:40 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.156.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f015794sm17715321cf.18.2026.07.17.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:27:39 -0700 (PDT)
Message-Id: <5b3704fbd4129e6bf742fe9b38998d5c952c6f21.1784312854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
	<pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Jul 2026 18:27:34 +0000
Subject: [PATCH v2 3/3] bisect: add --auto-reset to leave when done
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a bisection finishes, "git bisect" reports the first bad commit
but leaves the session active until "git bisect reset" is run by hand.

Add an "--auto-reset[=<where>]" option, accepted by both "git bisect
start" and "git bisect run", that resets as soon as the first bad commit
is found. The "original" value returns to the commit checked out before
"git bisect start", while "found" leaves the first bad commit checked
out; omitting the value defaults to "original".

Persist the selected target in a BISECT_AUTO_RESET state file and perform
the reset quietly. Reject this option together with "--no-checkout",
since that mode must not check out either target.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 Documentation/git-bisect.adoc |  14 ++++-
 bisect.c                      |   2 +
 builtin/bisect.c              | 100 ++++++++++++++++++++++++++++++-
 t/t6030-bisect-porcelain.sh   | 107 ++++++++++++++++++++++++++++++++++
 4 files changed, 219 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bisect.adoc b/Documentation/git-bisect.adoc
index d2115b2990..afae508463 100644
--- a/Documentation/git-bisect.adoc
+++ b/Documentation/git-bisect.adoc
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [synopsis]
 git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
-		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
+		 [--no-checkout] [--first-parent] [--auto-reset[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]
 git bisect (bad|new|<term-new>) [<rev>]
 git bisect (good|old|<term-old>) [<rev>...]
 git bisect terms [--term-(good|old) | --term-(bad|new)]
@@ -20,7 +20,7 @@ git bisect reset [<commit>]
 git bisect (visualize|view)
 git bisect replay <logfile>
 git bisect log
-git bisect run <cmd> [<arg>...]
+git bisect run [--auto-reset[=<where>]] <cmd> [<arg>...]
 git bisect help
 
 DESCRIPTION
@@ -385,6 +385,16 @@ ignored.
 This option is particularly useful in avoiding false positives when a merged
 branch contained broken or non-buildable commits, but the merge itself was OK.
 
+`--auto-reset[=<where>]`::
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
index 94c7028d2a..a34309dd35 100644
--- a/bisect.c
+++ b/bisect.c
@@ -488,6 +488,7 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_auto_reset, "BISECT_AUTO_RESET")
 
 static void read_bisect_paths(struct strvec *array)
 {
@@ -1211,6 +1212,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
+	unlink_or_warn(git_path_bisect_auto_reset());
 	/*
 	 * Cleanup BISECT_START last to support the --no-checkout option
 	 * introduced in the commit 4796e823a.
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 27d30b549e..6e835b7d2a 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -24,11 +24,12 @@ static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
+static GIT_PATH_FUNC(git_path_bisect_auto_reset, "BISECT_AUTO_RESET")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 #define BUILTIN_GIT_BISECT_START_USAGE \
 	N_("git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]\n" \
-	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]")
+	   "                 [--no-checkout] [--first-parent] [--auto-reset[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]")
 #define BUILTIN_GIT_BISECT_BAD_USAGE \
 	N_("git bisect (bad|new|<term-new>) [<rev>]")
 #define BUILTIN_GIT_BISECT_GOOD_USAGE \
@@ -48,7 +49,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 #define BUILTIN_GIT_BISECT_LOG_USAGE \
 	"git bisect log"
 #define BUILTIN_GIT_BISECT_RUN_USAGE \
-	N_("git bisect run <cmd> [<arg>...]")
+	N_("git bisect run [--auto-reset[=<where>]] <cmd> [<arg>...]")
 #define BUILTIN_GIT_BISECT_HELP_USAGE \
 	"git bisect help"
 
@@ -68,6 +69,12 @@ static const char * const git_bisect_usage[] = {
 	NULL
 };
 
+enum auto_reset_mode {
+	AUTO_RESET_NONE,
+	AUTO_RESET_ORIGINAL,
+	AUTO_RESET_FOUND,
+};
+
 struct add_bisect_ref_data {
 	struct rev_info *revs;
 	unsigned int object_flags;
@@ -268,6 +275,59 @@ static int bisect_reset(const char *commit, int quiet)
 	return bisect_clean_state();
 }
 
+static int parse_auto_reset(const char *value, enum auto_reset_mode *mode)
+{
+	if (!strcmp(value, "original"))
+		*mode = AUTO_RESET_ORIGINAL;
+	else if (!strcmp(value, "found"))
+		*mode = AUTO_RESET_FOUND;
+	else
+		return error(_("invalid value for '--auto-reset': '%s'"), value);
+
+	return 0;
+}
+
+static const char *auto_reset_mode_name(enum auto_reset_mode mode)
+{
+	switch (mode) {
+	case AUTO_RESET_ORIGINAL:
+		return "original";
+	case AUTO_RESET_FOUND:
+		return "found";
+	case AUTO_RESET_NONE:
+		BUG("no name for unset auto-reset mode");
+	}
+	BUG("unknown auto-reset mode %d", mode);
+}
+
+static int bisect_auto_reset(struct bisect_terms *terms)
+{
+	struct strbuf value = STRBUF_INIT;
+	enum auto_reset_mode mode;
+	char *commit = NULL;
+	int res;
+
+	if (strbuf_read_file(&value, git_path_bisect_auto_reset(), 0) < 0) {
+		res = error_errno(_("could not read '%s'"),
+				  git_path_bisect_auto_reset());
+		goto cleanup;
+	}
+	strbuf_trim(&value);
+	if (parse_auto_reset(value.buf, &mode)) {
+		res = -1;
+		goto cleanup;
+	}
+
+	if (mode == AUTO_RESET_FOUND)
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
@@ -688,6 +748,8 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 
 	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
 		res = bisect_successful(terms);
+		if (!res && !is_empty_or_missing_file(git_path_bisect_auto_reset()))
+			res = bisect_auto_reset(terms);
 		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
 	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
 		res = bisect_skipped_commits(terms);
@@ -711,6 +773,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
+	enum auto_reset_mode auto_reset = AUTO_RESET_NONE;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
 	int flags, pathspec_pos;
 	enum bisect_error res = BISECT_OK;
@@ -743,6 +806,13 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--first-parent")) {
 			first_parent_only = 1;
+		} else if (!strcmp(arg, "--auto-reset")) {
+			auto_reset = AUTO_RESET_ORIGINAL;
+		} else if (skip_prefix(arg, "--auto-reset=", &arg)) {
+			if (parse_auto_reset(arg, &auto_reset)) {
+				res = BISECT_FAILED;
+				goto finish;
+			}
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -780,6 +850,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			break;
 		}
 	}
+	if (auto_reset != AUTO_RESET_NONE && no_checkout) {
+		res = error(_("'--auto-reset' cannot be used with '--no-checkout'"));
+		goto finish;
+	}
 	pathspec_pos = i;
 
 	/*
@@ -857,6 +931,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	if (first_parent_only)
 		write_file(git_path_bisect_first_parent(), "\n");
 
+	if (auto_reset != AUTO_RESET_NONE)
+		write_file(git_path_bisect_auto_reset(), "%s\n",
+			   auto_reset_mode_name(auto_reset));
+
 	if (no_checkout) {
 		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
@@ -1235,6 +1313,8 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
+	enum auto_reset_mode auto_reset = AUTO_RESET_NONE;
+	const char *auto_reset_arg;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
@@ -1242,6 +1322,22 @@ static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
 
+	if (argc && !strcmp(argv[0], "--auto-reset"))
+		auto_reset = AUTO_RESET_ORIGINAL;
+	else if (argc && skip_prefix(argv[0], "--auto-reset=", &auto_reset_arg)) {
+		if (parse_auto_reset(auto_reset_arg, &auto_reset))
+			return BISECT_FAILED;
+	}
+
+	if (auto_reset != AUTO_RESET_NONE) {
+		if (refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
+			return error(_("'--auto-reset' cannot be used with '--no-checkout'"));
+		write_file(git_path_bisect_auto_reset(), "%s\n",
+			   auto_reset_mode_name(auto_reset));
+		argc--;
+		argv++;
+	}
+
 	if (!argc) {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 081116220a..826e54efea 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -43,6 +43,37 @@ test_bisect_usage () {
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
+bisect_run_auto_reset () {
+	write_script test_script.sh <<-\EOF &&
+	! grep Another hello >/dev/null
+	EOF
+	git bisect start $HASH4 $HASH2 &&
+	git bisect run "$1" ./test_script.sh >my_bisect_log.txt &&
+	test_grep "$HASH3 is the first .bad. commit" my_bisect_log.txt
+}
+
+test_auto_reset_fails () {
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
@@ -453,6 +484,82 @@ test_expect_success '"git bisect run" simple case' '
 	git bisect reset
 '
 
+test_expect_success '"git bisect start --auto-reset" defaults to original' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	git checkout main &&
+	bisect_start_and_finish --auto-reset &&
+	test "$HASH4" = "$(git rev-parse HEAD)" &&
+	test main = "$(git branch --show-current)" &&
+	test_bisect_state_missing BISECT_START &&
+
+	bisect_start_and_finish --auto-reset=original &&
+	test "$HASH4" = "$(git rev-parse HEAD)" &&
+	test main = "$(git branch --show-current)" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect start --auto-reset=found" leaves first bad checked out' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	bisect_start_and_finish --auto-reset=found &&
+	test "$HASH3" = "$(git rev-parse HEAD)" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect run --auto-reset" defaults to original' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	bisect_run_auto_reset --auto-reset &&
+	test "$HASH4" = "$(git rev-parse HEAD)" &&
+	test main = "$(git branch --show-current)" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '"git bisect run --auto-reset=found" leaves first bad checked out' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	bisect_run_auto_reset --auto-reset=found &&
+	test "$HASH3" = "$(git rev-parse HEAD)" &&
+	test_bisect_state_missing BISECT_START
+'
+
+test_expect_success '--auto-reset rejects an unknown reset target' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	test_auto_reset_fails \
+		"invalid value for.*--auto-reset.*unknown" BISECT_START \
+		git bisect start --auto-reset=unknown $HASH4 $HASH2 &&
+
+	git bisect start $HASH4 $HASH2 &&
+	test_auto_reset_fails \
+		"invalid value for.*--auto-reset.*unknown" BISECT_AUTO_RESET \
+		git bisect run --auto-reset=unknown true
+'
+
+test_expect_success '--auto-reset cannot be used with --no-checkout' '
+	test_when_finished "git bisect reset" &&
+	test_auto_reset_fails \
+		"cannot be used with.*--no-checkout" BISECT_START \
+		git bisect start --auto-reset=original --no-checkout $HASH4 $HASH2 &&
+
+	git bisect start --no-checkout $HASH4 $HASH2 &&
+	test_auto_reset_fails \
+		"cannot be used with.*--no-checkout" BISECT_AUTO_RESET \
+		git bisect run --auto-reset=found true
+'
+
+test_expect_success 'without --auto-reset the bisection state is kept' '
+	test_when_finished "git bisect reset" &&
+	git bisect start $HASH4 $HASH2 &&
+	git bisect bad &&
+	test_bisect_state_file BISECT_START
+'
+
+test_expect_success '--auto-reset does not leak into a later bisection' '
+	test_when_finished "git bisect reset; git checkout main" &&
+	bisect_start_and_finish --auto-reset &&
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
