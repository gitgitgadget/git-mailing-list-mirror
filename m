Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95026C0502E
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiH0Mou (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbiH0Mok (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD931EC8
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso5752195wmc.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=fwrKm+3cHaYRs4PQq7qXa/fxaaT/XzGfHTpmCfdzpRg=;
        b=PFrRSDJBIEB3xbELzVZ9aBMmDI0HcMlFn7KAX4dgywflIoHXryWtHmkM6+jzOXAlnu
         quoXjxTy9IqoAwwHDPnLOtZrMsX+bOOtTeZF42bRcxGsr92swfKJ23Qlj4rm/bgVNuot
         jF6rKlOkayi1LCK3pfSA/Onq8y4gTmY5G/F2l3p0+/LuZ2A3iwJdzqjrXHv8WeFyZ1gE
         fnk3T6WL6zG8VZHitKzq5j/J3gpeXPjGJkvVfXB5svjFrOvqn4RqIouLDB8Jf6vszGF0
         7Nt94fNOdHEbRuGcfzRteTDYp2HeL6oxk/ELDtr47jaasuJo/BcRJw+ZH4igf+K7ff1C
         GMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=fwrKm+3cHaYRs4PQq7qXa/fxaaT/XzGfHTpmCfdzpRg=;
        b=5x0WEWuf/kpDl2zmqK6SP5EJrydpMMNlpqaTK0hN/AX3OAgC92Rw6YG08hLvT/DpdA
         OLr7rLEfSucJaIhab/gJKgVE3IsnFOsPqVCdweR1ufM++AABhF0oFUzz58XaOGuql8Rg
         YnOxYxcBrSDJW7d6MNVMpBUHckVY1gF8TwT/4gcZj5jYZEBGSyazWJQ2fAA0gXIbXOz4
         FaNeRy4WK2kS7eRgBQt+OU37XpIc/QSLTROzYQ74zPP7ut771ncZ2fWsCkJFMO0LLmsu
         /p+LpknoH6HPTaq/59uXHiqUrzY0EWmbL71jYp2wMMVtQxdsky2ZbpmXrWU7dMoFWDvy
         bXxA==
X-Gm-Message-State: ACgBeo1lXFX314X47AOkHIcWJei5e+vSwb7HcvuhrT5FbsMIfSkS7jLU
        wabmLBWTMdBkJPzOz+6jGgF0M8Qe1os=
X-Google-Smtp-Source: AA6agR5RSPT8ySV+M0AzTWQW5pzw9clHSPbRs1KE+rNftZCcbL2eqNnnSE9l74ihZZ3t9g1ccbD+GQ==
X-Received: by 2002:a05:600c:a4c:b0:39c:34d0:fd25 with SMTP id c12-20020a05600c0a4c00b0039c34d0fd25mr2261972wmq.172.1661604276421;
        Sat, 27 Aug 2022 05:44:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c16-20020adffb50000000b00226d473ebd6sm665066wrs.86.2022.08.27.05.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:35 -0700 (PDT)
Message-Id: <5b7a3d58b4f84f72e1ae2196fa67c76b0a6302ad.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:15 +0000
Subject: [PATCH v5 07/16] bisect--helper: migrate to OPT_SUBCOMMAND()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We just introduced a new way to process subcommands, and the
`bisect--helper` learns about it in preparation for replacing the
`git-bisect.sh` script altogether.

Note that a couple of `bisect_*()` functions are not converted into
`cmd_bisect_*()` functions directly, as they have callers other than the
`OPT_SUBCOMMAND()` one (and the original functions did not expect
a subcommand name to be passed as `argv[0]`, unlike the convention for
the `cmd_*()` functions. In those cases, we introduce wrapper functions
`cmd_*()` that also call the original function.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 462 +++++++++++++++++++++++----------------
 git-bisect.sh            |  20 +-
 2 files changed, 288 insertions(+), 194 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 0d7cc20f9c9..d797cd1cef8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -20,18 +20,71 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
-static const char * const git_bisect_helper_usage[] = {
-	N_("git bisect--helper --bisect-reset [<commit>]"),
-	"git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]",
-	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
-					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
-	"git bisect--helper --bisect-next",
-	N_("git bisect--helper --bisect-state (bad|new) [<rev>]"),
-	N_("git bisect--helper --bisect-state (good|old) [<rev>...]"),
-	N_("git bisect--helper --bisect-replay <filename>"),
-	N_("git bisect--helper --bisect-skip [(<rev>|<range>)...]"),
-	"git bisect--helper --bisect-visualize",
-	N_("git bisect--helper --bisect-run <cmd>..."),
+static const char * const bisect_usage[] = {
+	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
+	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]"
+	   "    [<pathspec>...]"),
+	N_("git bisect (bad|new) [<rev>]"),
+	N_("git bisect (good|old) [<rev>...]"),
+	N_("git bisect terms [--term-good | --term-bad]"),
+	N_("git bisect skip [(<rev>|<range>)...]"),
+	N_("git bisect next"),
+	N_("git bisect reset [<commit>]"),
+	N_("git bisect (visualize|view)"),
+	N_("git bisect replay <logfile>"),
+	N_("git bisect log"),
+	N_("git bisect run <cmd>..."),
+	NULL
+};
+
+static const char * const bisect_start_usage[] = {
+	N_("git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
+	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]"
+	   "    [<pathspec>...]"),
+	NULL
+};
+static const char * const bisect_state_usage[] = {
+	N_("git bisect (good|bad) [<rev>...]"),
+	NULL
+};
+
+static const char * const bisect_terms_usage[] = {
+	N_("git bisect terms [--term-good | --term-bad]"),
+	NULL
+};
+
+static const char * const bisect_skip_usage[] = {
+	N_("git bisect skip [(<rev>|<range>)...]"),
+	NULL
+};
+
+static const char * const bisect_next_usage[] = {
+	N_("git bisect next"),
+	NULL
+};
+
+static const char * const bisect_reset_usage[] = {
+	N_("git bisect reset [<commit>]"),
+	NULL
+};
+
+static const char * const bisect_visualize_usage[] = {
+	N_("git bisect visualize"),
+	NULL
+};
+
+static const char * const bisect_replay_usage[] = {
+	N_("git bisect replay <logfile>"),
+	NULL
+};
+
+static const char * const bisect_log_usage[] = {
+	N_("git bisect log"),
+	NULL
+};
+
+static const char * const bisect_run_usage[] = {
+	N_("git bisect run <cmd>..."),
 	NULL
 };
 
@@ -63,7 +116,7 @@ static void set_terms(const char *bad,
 static const char vocab_bad[] = "bad|new";
 static const char vocab_good[] = "good|old";
 
-static int bisect_autostart(void);
+static int bisect_autostart(const char *prefix);
 
 /*
  * Check whether the string `term` belongs to the set of strings
@@ -238,6 +291,21 @@ static int bisect_reset(const char *commit)
 	return bisect_clean_state();
 }
 
+static int cmd_bisect_reset(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	argc = parse_options(argc, argv, prefix, options,
+			     bisect_reset_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc > 1)
+		usage_msg_opt(_("requires either no argument or a commit"),
+			      bisect_reset_usage, options);
+
+	return bisect_reset(argc == 1 ? argv[0] : NULL);
+}
+
 static void log_commit(FILE *fp, char *fmt, const char *state,
 		       struct commit *commit)
 {
@@ -465,26 +533,41 @@ finish:
 	return res;
 }
 
-static int bisect_terms(const char *option)
+static int cmd_bisect_terms(int argc, const char **argv, const char *prefix)
 {
+	int mode = -1;
+	struct option options[] = {
+		OPT_SET_INT(0, "term-good", &mode,
+			    N_("show term for good/old"), 1),
+		OPT_SET_INT(0, "term-old", &mode,
+			    N_("show term for good/old"), 1),
+		OPT_SET_INT(0, "term-bad", &mode,
+			    N_("show term for bad/new"), 0),
+		OPT_SET_INT(0, "term-new", &mode,
+			    N_("show term for bad/new"), 0),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options,
+			     bisect_terms_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc > 1)
+		usage_msg_opt(_("terms: requires 0 or 1 argument"),
+			      bisect_terms_usage, options);
+
 	if (get_terms())
 		return error(_("no terms defined"));
 
-	if (!option) {
+	if (mode < 0) {
 		printf(_("Your current terms are %s for the old state\n"
 			 "and %s for the new state.\n"),
 		       terms.term_good, terms.term_bad);
 		return 0;
 	}
-	if (one_of(option, "--term-good", "--term-old", NULL))
+	if (mode == 1)
 		printf("%s\n", terms.term_good);
-	else if (one_of(option, "--term-bad", "--term-new", NULL))
-		printf("%s\n", terms.term_bad);
 	else
-		return error(_("invalid argument %s for 'git bisect terms'.\n"
-			       "Supported options are: "
-			       "--term-good|--term-old and "
-			       "--term-bad|--term-new."), option);
+		printf("%s\n", terms.term_bad);
 
 	return 0;
 }
@@ -623,7 +706,7 @@ static enum bisect_error bisect_next(const char *prefix)
 {
 	enum bisect_error res;
 
-	if (bisect_autostart())
+	if (bisect_autostart(prefix))
 		return BISECT_FAILED;
 
 	if (bisect_next_check(terms.term_good))
@@ -642,6 +725,24 @@ static enum bisect_error bisect_next(const char *prefix)
 	return res;
 }
 
+static int cmd_bisect_next(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+
+	get_terms();
+	argc = parse_options(argc, argv, prefix, options,
+				bisect_next_usage,
+				PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc > 0)
+		usage_msg_opt(_("requires 0 argument"),
+			      bisect_next_usage, options);
+
+	return bisect_next(prefix);
+}
+
 static enum bisect_error bisect_auto_next(const char *prefix)
 {
 	if (bisect_next_check(NULL)) {
@@ -652,8 +753,9 @@ static enum bisect_error bisect_auto_next(const char *prefix)
 	return bisect_next(prefix);
 }
 
-static enum bisect_error bisect_start(int argc, const char **argv)
+static int cmd_bisect_start(int argc, const char **argv, const char *prefix)
 {
+	struct strvec orig_argv = STRVEC_INIT;
 	int no_checkout = 0;
 	int first_parent_only = 0;
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
@@ -665,66 +767,64 @@ static enum bisect_error bisect_start(int argc, const char **argv)
 	struct strbuf bisect_names = STRBUF_INIT;
 	struct object_id head_oid;
 	struct object_id oid;
-	const char *head;
+	const char *head, *term_good = NULL, *term_bad = NULL;
+	struct option options[] = {
+		OPT_BOOL(0, "no-checkout", &no_checkout,
+			 N_("do not update worktree")),
+		OPT_BOOL(0, "first-parent", &first_parent_only,
+			 N_("follow only first parent of merge commits")),
+		OPT_STRING(0, "term-good", &term_good, N_("term"),
+			   N_("use this term instead of 'good'")),
+		OPT_STRING(0, "term-bad", &term_bad, N_("term"),
+			   N_("use this term instead of 'bad'")),
+		OPT_STRING(0, "term-old", &term_good, N_("term"),
+			   N_("use this term instead of 'good'")),
+		OPT_STRING(0, "term-new", &term_bad, N_("term"),
+			   N_("use this term instead of 'bad'")),
+		OPT_END()
+	};
+
+	set_terms("bad", "good");
 
 	if (is_bare_repository())
 		no_checkout = 1;
 
-	/*
-	 * Check for one bad and then some good revisions
-	 */
-	for (i = 0; i < argc; i++) {
+	strvec_pushv(&orig_argv, argv); /* save the command-line for logging */
+	argc = parse_options(argc, argv, prefix, options, bisect_start_usage,
+			     PARSE_OPT_KEEP_DASHDASH);
+
+	if (term_good) {
+		free(terms.term_good);
+		terms.term_good = xstrdup(term_good);
+		must_write_terms = 1;
+	}
+
+	if (term_bad) {
+		free(terms.term_bad);
+		terms.term_bad = xstrdup(term_bad);
+		must_write_terms = 1;
+	}
+
+	for (i = 0; i < argc; i++)
 		if (!strcmp(argv[i], "--")) {
 			has_double_dash = 1;
 			break;
 		}
-	}
 
-	for (i = 0; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(argv[i], "--")) {
-			break;
-		} else if (!strcmp(arg, "--no-checkout")) {
-			no_checkout = 1;
-		} else if (!strcmp(arg, "--first-parent")) {
-			first_parent_only = 1;
-		} else if (!strcmp(arg, "--term-good") ||
-			 !strcmp(arg, "--term-old")) {
-			i++;
-			if (argc <= i)
-				return error(_("'' is not a valid term"));
-			must_write_terms = 1;
-			free((void *) terms.term_good);
-			terms.term_good = xstrdup(argv[i]);
-		} else if (skip_prefix(arg, "--term-good=", &arg) ||
-			   skip_prefix(arg, "--term-old=", &arg)) {
-			must_write_terms = 1;
-			free((void *) terms.term_good);
-			terms.term_good = xstrdup(arg);
-		} else if (!strcmp(arg, "--term-bad") ||
-			 !strcmp(arg, "--term-new")) {
-			i++;
-			if (argc <= i)
-				return error(_("'' is not a valid term"));
-			must_write_terms = 1;
-			free((void *) terms.term_bad);
-			terms.term_bad = xstrdup(argv[i]);
-		} else if (skip_prefix(arg, "--term-bad=", &arg) ||
-			   skip_prefix(arg, "--term-new=", &arg)) {
-			must_write_terms = 1;
-			free((void *) terms.term_bad);
-			terms.term_bad = xstrdup(arg);
-		} else if (starts_with(arg, "--")) {
-			return error(_("unrecognized option: '%s'"), arg);
-		} else if (!get_oidf(&oid, "%s^{commit}", arg)) {
+	/*
+	 * Check for one bad and then some good revisions
+	 */
+
+	for (i = 0; i < argc && strcmp(argv[i], "--"); i++)
+		if (!get_oidf(&oid, "%s^{commit}", argv[i])) {
 			string_list_append(&revs, oid_to_hex(&oid));
 		} else if (has_double_dash) {
 			die(_("'%s' does not appear to be a valid "
-			      "revision"), arg);
+			      "revision"), argv[i]);
 		} else {
 			break;
 		}
-	}
+
 	pathspec_pos = i;
 
 	/*
@@ -836,11 +936,13 @@ static enum bisect_error bisect_start(int argc, const char **argv)
 		goto finish;
 	}
 
-	res = bisect_append_log_quoted(argv);
+	res = bisect_append_log_quoted(orig_argv.v + 1);
 	if (res)
 		res = BISECT_FAILED;
 
 finish:
+	strvec_clear(&orig_argv);
+
 	string_list_clear(&revs, 0);
 	string_list_clear(&states, 0);
 	strbuf_release(&start_head);
@@ -848,7 +950,7 @@ finish:
 	if (res)
 		return res;
 
-	res = bisect_auto_next(NULL);
+	res = bisect_auto_next(prefix);
 	if (!is_bisect_success(res))
 		bisect_clean_state();
 	return res;
@@ -859,7 +961,7 @@ static inline int file_is_not_empty(const char *path)
 	return !is_empty_or_missing_file(path);
 }
 
-static int bisect_autostart(void)
+static int bisect_autostart(const char *prefix)
 {
 	int res;
 	const char *yesno;
@@ -881,12 +983,13 @@ static int bisect_autostart(void)
 	yesno = git_prompt(_("Do you want me to do it for you "
 			     "[Y/n]? "), PROMPT_ECHO);
 	res = tolower(*yesno) == 'n' ?
-		-1 : bisect_start(0, empty_strvec);
+		-1 : cmd_bisect_start(1, &yesno, prefix);
 
 	return res;
 }
 
-static enum bisect_error bisect_state(int argc, const char **argv)
+static enum bisect_error bisect_state(int argc, const char **argv,
+				      const char *prefix)
 {
 	const char *state;
 	int i, verify_expected = 1;
@@ -894,10 +997,8 @@ static enum bisect_error bisect_state(int argc, const char **argv)
 	struct strbuf buf = STRBUF_INIT;
 	struct oid_array revs = OID_ARRAY_INIT;
 
-	if (!argc)
-		return error(_("Please call `--bisect-state` with at least one argument"));
 
-	if (bisect_autostart())
+	if (bisect_autostart(prefix))
 		return BISECT_FAILED;
 
 	state = argv[0];
@@ -966,11 +1067,41 @@ static enum bisect_error bisect_state(int argc, const char **argv)
 	return bisect_auto_next(NULL);
 }
 
-static enum bisect_error bisect_log(void)
+static int cmd_bisect_state(int argc, const char **argv,
+				const char *prefix)
 {
+	struct option options[] = {
+		OPT_END()
+	};
+
+	set_terms("bad", "good");
+	get_terms();
+
+	argc = parse_options(argc, argv, prefix, options,
+			     bisect_state_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (!argc)
+		usage_msg_opt(_("need at least one argument"),
+			      bisect_state_usage, options);
+
+	return bisect_state(argc, argv, prefix);
+}
+
+static int cmd_bisect_log(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT_END()
+	};
 	int fd, status;
 	const char* filename = git_path_bisect_log();
 
+	argc = parse_options(argc, argv, prefix, options,
+			     bisect_log_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc > 0)
+		usage_msg_opt(_("require 0 argument"), bisect_log_usage,
+			      options);
+
 	if (is_empty_or_missing_file(filename))
 		return error(_("We are not bisecting."));
 
@@ -983,7 +1114,7 @@ static enum bisect_error bisect_log(void)
 	return status ? BISECT_FAILED : BISECT_OK;
 }
 
-static int process_replay_line(struct strbuf *line)
+static int process_replay_line(struct strbuf *line, const char *prefix)
 {
 	const char *p = line->buf + strspn(line->buf, " \t");
 	char *word_end, *rev;
@@ -1004,8 +1135,10 @@ static int process_replay_line(struct strbuf *line)
 	if (!strcmp(p, "start")) {
 		struct strvec argv = STRVEC_INIT;
 		int res;
+
+		strvec_push(&argv, p);
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_start(argv.nr, argv.v);
+		res = cmd_bisect_start(argv.nr, argv.v, prefix);
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1017,8 +1150,11 @@ static int process_replay_line(struct strbuf *line)
 	if (!strcmp(p, "terms")) {
 		struct strvec argv = STRVEC_INIT;
 		int res;
+
+		strvec_push(&argv, p);
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_terms(argv.nr == 1 ? argv.v[0] : NULL);
+		res = cmd_bisect_terms(argv.nr, argv.v, NULL);
+
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1027,12 +1163,25 @@ static int process_replay_line(struct strbuf *line)
 	return -1;
 }
 
-static enum bisect_error bisect_replay(const char *filename)
+static int cmd_bisect_replay(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END()
+	};
+	const char *filename;
 	FILE *fp = NULL;
 	enum bisect_error res = BISECT_OK;
 	struct strbuf line = STRBUF_INIT;
 
+	set_terms("bad", "good");
+	argc = parse_options(argc, argv, prefix, options,
+			     bisect_reset_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc != 1)
+		usage_msg_opt(_("no logfile given"), bisect_replay_usage,
+			      options);
+
+	filename = argv[0];
 	if (is_empty_or_missing_file(filename))
 		return error(_("cannot read file '%s' for replaying"), filename);
 
@@ -1044,7 +1193,7 @@ static enum bisect_error bisect_replay(const char *filename)
 		return BISECT_FAILED;
 
 	while ((strbuf_getline(&line, fp) != EOF) && !res)
-		res = process_replay_line(&line);
+		res = process_replay_line(&line, prefix);
 
 	strbuf_release(&line);
 	fclose(fp);
@@ -1055,12 +1204,20 @@ static enum bisect_error bisect_replay(const char *filename)
 	return bisect_auto_next(NULL);
 }
 
-static enum bisect_error bisect_skip(int argc, const char **argv)
+static int cmd_bisect_skip(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END()
+	};
 	int i;
 	enum bisect_error res;
 	struct strvec argv_state = STRVEC_INIT;
 
+	set_terms("bad", "good");
+	get_terms();
+	argc = parse_options(argc, argv, prefix, options,
+			     bisect_skip_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
+
 	strvec_push(&argv_state, "skip");
 
 	for (i = 0; i < argc; i++) {
@@ -1085,18 +1242,28 @@ static enum bisect_error bisect_skip(int argc, const char **argv)
 			strvec_push(&argv_state, argv[i]);
 		}
 	}
-	res = bisect_state(argv_state.nr, argv_state.v);
+	res = bisect_state(argv_state.nr, argv_state.v, prefix);
 
 	strvec_clear(&argv_state);
 	return res;
 }
 
-static int bisect_visualize(int argc, const char **argv)
+static int cmd_bisect_visualize(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END()
+	};
 	struct strvec args = STRVEC_INIT;
 	int flags = RUN_COMMAND_NO_STDIN, res = 0;
 	struct strbuf sb = STRBUF_INIT;
 
+	set_terms("bad", "good");
+	get_terms();
+	argc = parse_options(argc, argv, prefix, options,
+			     bisect_visualize_usage,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN_OPT);
+
 	if (bisect_next_check(NULL) != 0)
 		return BISECT_FAILED;
 
@@ -1166,8 +1333,11 @@ static int verify_good(const char **quoted_argv)
 	return rc;
 }
 
-static int bisect_run(int argc, const char **argv)
+static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
 {
+	struct option options[] = {
+		OPT_END()
+	};
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
 	struct strvec run_args = STRVEC_INIT;
@@ -1175,15 +1345,18 @@ static int bisect_run(int argc, const char **argv)
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
 
+	get_terms();
+	argc = parse_options(argc, argv, prefix, options,
+			     bisect_run_usage,  PARSE_OPT_STOP_AT_NON_OPTION);
+
 	if (bisect_next_check(NULL))
 		return BISECT_FAILED;
 
 	if (argc)
 		sq_quote_argv(&command, argv);
-	else {
-		error(_("bisect run failed: no command provided."));
-		return BISECT_FAILED;
-	}
+	else
+		usage_msg_opt(_("bisect run failed: no command provided."),
+			      bisect_run_usage, options);
 
 	strvec_push(&run_args, command.buf);
 
@@ -1239,7 +1412,7 @@ static int bisect_run(int argc, const char **argv)
 		saved_stdout = dup(1);
 		dup2(temporary_stdout_fd, 1);
 
-		res = bisect_state(1, &new_state);
+		res = bisect_state(1, &new_state, prefix);
 
 		fflush(stdout);
 		dup2(saved_stdout, 1);
@@ -1272,105 +1445,26 @@ static int bisect_run(int argc, const char **argv)
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	enum {
-		BISECT_RESET = 1,
-		BISECT_TERMS,
-		BISECT_START,
-		BISECT_NEXT,
-		BISECT_STATE,
-		BISECT_LOG,
-		BISECT_REPLAY,
-		BISECT_SKIP,
-		BISECT_VISUALIZE,
-		BISECT_RUN,
-	} cmdmode = 0;
+	parse_opt_subcommand_fn *fn = NULL;
 	int res = 0;
 	struct option options[] = {
-		OPT_CMDMODE(0, "bisect-reset", &cmdmode,
-			 N_("reset the bisection state"), BISECT_RESET),
-		OPT_CMDMODE(0, "bisect-terms", &cmdmode,
-			 N_("print out the bisect terms"), BISECT_TERMS),
-		OPT_CMDMODE(0, "bisect-start", &cmdmode,
-			 N_("start the bisect session"), BISECT_START),
-		OPT_CMDMODE(0, "bisect-next", &cmdmode,
-			 N_("find the next bisection commit"), BISECT_NEXT),
-		OPT_CMDMODE(0, "bisect-state", &cmdmode,
-			 N_("mark the state of ref (or refs)"), BISECT_STATE),
-		OPT_CMDMODE(0, "bisect-log", &cmdmode,
-			 N_("list the bisection steps so far"), BISECT_LOG),
-		OPT_CMDMODE(0, "bisect-replay", &cmdmode,
-			 N_("replay the bisection process from the given file"), BISECT_REPLAY),
-		OPT_CMDMODE(0, "bisect-skip", &cmdmode,
-			 N_("skip some commits for checkout"), BISECT_SKIP),
-		OPT_CMDMODE(0, "bisect-visualize", &cmdmode,
-			 N_("visualize the bisection"), BISECT_VISUALIZE),
-		OPT_CMDMODE(0, "bisect-run", &cmdmode,
-			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
+		OPT_SUBCOMMAND("reset", &fn, cmd_bisect_reset),
+		OPT_SUBCOMMAND("terms", &fn, cmd_bisect_terms),
+		OPT_SUBCOMMAND("start", &fn, cmd_bisect_start),
+		OPT_SUBCOMMAND("next", &fn, cmd_bisect_next),
+		OPT_SUBCOMMAND("state", &fn, cmd_bisect_state),
+		OPT_SUBCOMMAND("log", &fn, cmd_bisect_log),
+		OPT_SUBCOMMAND("replay", &fn, cmd_bisect_replay),
+		OPT_SUBCOMMAND("skip", &fn, cmd_bisect_skip),
+		OPT_SUBCOMMAND("visualize", &fn, cmd_bisect_visualize),
+		OPT_SUBCOMMAND("run", &fn, cmd_bisect_run),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options,
-			     git_bisect_helper_usage,
-			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN_OPT);
-
-	if (!cmdmode)
-		usage_with_options(git_bisect_helper_usage, options);
+			     bisect_usage, 0);
 
-	switch (cmdmode) {
-	case BISECT_RESET:
-		if (argc > 1)
-			return error(_("--bisect-reset requires either no argument or a commit"));
-		res = bisect_reset(argc ? argv[0] : NULL);
-		break;
-	case BISECT_TERMS:
-		if (argc > 1)
-			return error(_("--bisect-terms requires 0 or 1 argument"));
-		res = bisect_terms(argc == 1 ? argv[0] : NULL);
-		break;
-	case BISECT_START:
-		set_terms("bad", "good");
-		res = bisect_start(argc, argv);
-		break;
-	case BISECT_NEXT:
-		if (argc)
-			return error(_("--bisect-next requires 0 arguments"));
-		get_terms();
-		res = bisect_next(prefix);
-		break;
-	case BISECT_STATE:
-		set_terms("bad", "good");
-		get_terms();
-		res = bisect_state(argc, argv);
-		break;
-	case BISECT_LOG:
-		if (argc)
-			return error(_("--bisect-log requires 0 arguments"));
-		res = bisect_log();
-		break;
-	case BISECT_REPLAY:
-		if (argc != 1)
-			return error(_("no logfile given"));
-		set_terms("bad", "good");
-		res = bisect_replay(argv[0]);
-		break;
-	case BISECT_SKIP:
-		set_terms("bad", "good");
-		get_terms();
-		res = bisect_skip(argc, argv);
-		break;
-	case BISECT_VISUALIZE:
-		get_terms();
-		res = bisect_visualize(argc, argv);
-		break;
-	case BISECT_RUN:
-		if (!argc)
-			return error(_("bisect run failed: no command provided."));
-		get_terms();
-		res = bisect_run(argc, argv);
-		break;
-	default:
-		BUG("unknown subcommand %d", cmdmode);
-	}
+	res = fn(argc, argv, prefix);
 	free_terms();
 
 	return is_bisect_success(res) ? 0 : -res;
diff --git a/git-bisect.sh b/git-bisect.sh
index 405cf76f2a3..e19847eba0d 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -58,26 +58,26 @@ case "$#" in
 	help)
 		git bisect -h ;;
 	start)
-		git bisect--helper --bisect-start "$@" ;;
+		git bisect--helper start "$@" ;;
 	bad|good|new|old|"$TERM_BAD"|"$TERM_GOOD")
-		git bisect--helper --bisect-state "$cmd" "$@" ;;
+		git bisect--helper state "$cmd" "$@" ;;
 	skip)
-		git bisect--helper --bisect-skip "$@" || exit;;
+		git bisect--helper skip "$@" || exit;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
-		git bisect--helper --bisect-next "$@" || exit ;;
+		git bisect--helper next "$@" || exit ;;
 	visualize|view)
-		git bisect--helper --bisect-visualize "$@" || exit;;
+		git bisect--helper visualize "$@" || exit;;
 	reset)
-		git bisect--helper --bisect-reset "$@" ;;
+		git bisect--helper reset "$@" ;;
 	replay)
-		git bisect--helper --bisect-replay "$@" || exit;;
+		git bisect--helper replay "$@" || exit;;
 	log)
-		git bisect--helper --bisect-log || exit ;;
+		git bisect--helper log || exit ;;
 	run)
-		git bisect--helper --bisect-run "$@" || exit;;
+		git bisect--helper run "$@" || exit;;
 	terms)
-		git bisect--helper --bisect-terms "$@" || exit;;
+		git bisect--helper terms "$@" || exit;;
 	*)
 		usage ;;
 	esac
-- 
gitgitgadget

