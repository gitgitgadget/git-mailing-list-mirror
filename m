Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFD420248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfBXKLd (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:33 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39367 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728275AbfBXKL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id p27so5215982edc.6
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Igewf11QOd+QNZo/sYWCCtEvepayAFbcyohytZV7QRE=;
        b=nXhPUg7eazozZwqHuKmbI9oTmrCrrD936nelYk6d+T8IzvnIbgfn9rn1N29qreRxcV
         olg96D+nM1ZX51Sv4fl0Cmlh87BXjwoqpKeUvaHsWbEHOKOL2Kgxt8shDmJ+SDF5+ZPy
         skDqba7X07gCRgwYlGHieS61js7xi6TMe/UgeLnP+0DyK4Cj/dbEIGyHxbAIk8FNxeYi
         7iU4bxWsqUNAenUKk1xAsJwrvI8oum2o5KcpQHqBGy9pCd9cCXKZ35snWuh0QiK+Day3
         nPb9s9eJoJvc8zZ5nud9MDlB+yRdXULJ4MvfpzR37wtcljXxh+x5ViUfoxC+kVctAh7V
         TApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Igewf11QOd+QNZo/sYWCCtEvepayAFbcyohytZV7QRE=;
        b=BF4CHupRE4xZ7dEDQpj89fTfAR5SqvqlHrpm88vyM1jP6tcADPyXKAVhTDMA53ITfG
         MtNodlp9ki61dojUWQY+EmfKDvudCoBIBTCy4ACF5IqWBR4pM8Bn7zod4NUFeOv8Y3q/
         MtJG68NGp158E7pLahkCMS3VNO5xXXEnVqALcmX3aeQXacwYkMqfV+08m3QcwYNtMfsx
         JxNQaWTmSCH+epLsMNKaah+2S7TLFn7xo291s2a4pZ/vylcOr7z/87ZCVC4vdEcGtGjV
         sKYyzjqnAEl/q902MjXGjCX8szoufEXhJDQMtYJ3O1g88kjvh3xWatSXgAUwgIJFoK1S
         wmdA==
X-Gm-Message-State: AHQUAuaQZhyXM7r5MCFrUX0eIHKdK8eAQEeNKoutX6MOXS207A6BX1bK
        J6+gqQusuW1BCgeVb0zjpzHsUQVO
X-Google-Smtp-Source: AHgI3IYtI9bMPHB3JyE4jrXo81vBd4RETWQI5cIGPVaTLqQpJTYUAe4bV8QLtrKbGt8tMlZssOfK7g==
X-Received: by 2002:a50:86ce:: with SMTP id 14mr10440805edu.33.1551003083485;
        Sun, 24 Feb 2019 02:11:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s24sm357127edd.23.2019.02.24.02.11.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:23 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:23 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:58 GMT
Message-Id: <7acd865946935378b75c65330a54e0c889f108b2.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 10/26] bisect--helper: `bisect_next` and `bisect_auto_next`
 shell function in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Reimplement the `bisect_next()` and the `bisect_auto_next()` shell function
in C and add the subcommands to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-next` and `--bisect-auto-start` subcommands is a
temporary measure to port shell function to C so as to use the existing
test suite. As more functions are ported, this subcommand will be
retired and will be called by some other methods.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 bisect.c                 |   6 ++
 builtin/bisect--helper.c | 156 ++++++++++++++++++++++++++++++++++++++-
 git-bisect.sh            |  47 ++----------
 3 files changed, 166 insertions(+), 43 deletions(-)

diff --git a/bisect.c b/bisect.c
index 3d11a8eac7..78ac4de395 100644
--- a/bisect.c
+++ b/bisect.c
@@ -633,6 +633,12 @@ static void bisect_rev_setup(struct rev_info *revs, const char *prefix,
 	struct argv_array rev_argv = ARGV_ARRAY_INIT;
 	int i;
 
+	/*
+	 * Since the code is slowly being converted to C, there might be
+	 * instances where the revisions were initialized before. Thus
+	 * we first need to reset it.
+	 */
+	reset_revision_walk();
 	repo_init_revisions(the_repository, revs, prefix);
 	revs->abbrev = 0;
 	revs->commit_format = CMIT_FMT_UNSPECIFIED;
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ffb5dbe4b3..2f19924471 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -8,6 +8,7 @@
 #include "run-command.h"
 #include "prompt.h"
 #include "quote.h"
+#include "revision.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
@@ -29,6 +30,8 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
 					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
+	N_("git bisect--helper --bisect-next"),
+	N_("git bisect--helper --bisect-auto-next"),
 	NULL
 };
 
@@ -421,6 +424,139 @@ static int bisect_append_log_quoted(const char **argv)
 	return res;
 }
 
+static int register_good_ref(const char *refname,
+			     const struct object_id *oid, int flags,
+			     void *cb_data)
+{
+	struct string_list *good_refs = cb_data;
+	string_list_append(good_refs, oid_to_hex(oid));
+	return 0;
+}
+
+static int bisect_skipped_commits(struct bisect_terms *terms)
+{
+	FILE *fp = NULL;
+	struct rev_info revs;
+	struct argv_array rev_argv = ARGV_ARRAY_INIT;
+	struct string_list good_revs = STRING_LIST_INIT_DUP;
+	struct pretty_print_context pp = {0};
+	struct commit *commit;
+	char *term_good = xstrfmt("%s-*", terms->term_good);
+	int i, res = 0;
+
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp) {
+		res = error_errno(_("could not open '%s' for appending"),
+				     git_path_bisect_log());
+		goto leave_skipped_commits;
+	}
+	if (fprintf(fp, "# only skipped commits left to test\n") < 1) {
+		res = -1;
+		goto leave_skipped_commits;
+	}
+
+	for_each_glob_ref_in(register_good_ref, term_good,
+			     "refs/bisect/", &good_revs);
+
+	argv_array_pushl(&rev_argv, "skipped_commits", "refs/bisect/bad", "--not", NULL);
+	for (i = 0; i < good_revs.nr; i++)
+		argv_array_push(&rev_argv, good_revs.items[i].string);
+
+	/* 
+	 * It is important to reset the flags used by revision walks
+	 * as the previous call to bisect_next_all() in turn
+	 * setups a revision walk.
+	 */
+	reset_revision_walk();
+	init_revisions(&revs, NULL);
+	rev_argv.argc = setup_revisions(rev_argv.argc, rev_argv.argv, &revs, NULL);
+	argv_array_clear(&rev_argv);
+	string_list_clear(&good_revs, 0);
+	if (prepare_revision_walk(&revs)) {
+		res = error(_("revision walk setup failed\n"));
+		goto leave_skipped_commits;
+	}
+	while ((commit = get_revision(&revs)) != NULL) {
+		struct strbuf commit_name = STRBUF_INIT;
+		format_commit_message(commit, "%s",
+				      &commit_name, &pp);
+		fprintf(fp, "# possible first %s commit: [%s] %s\n",
+			terms->term_bad, oid_to_hex(&commit->object.oid),
+			commit_name.buf);
+		strbuf_release(&commit_name);
+	}
+
+leave_skipped_commits:
+	if (fp)
+		fclose(fp);
+	string_list_clear(&good_revs, 0);
+	argv_array_clear(&rev_argv);
+	free(term_good);
+	return res;
+}
+
+static int bisect_successful(struct bisect_terms *terms)
+{
+	FILE *fp = NULL;
+	struct object_id oid;
+	struct commit *commit;
+	struct pretty_print_context pp = {0};
+	struct strbuf commit_name = STRBUF_INIT;
+	char *bad_ref = xstrfmt("refs/bisect/%s",
+				terms->term_bad);
+	int res = 0;
+
+	read_ref(bad_ref, &oid);
+	printf("%s\n", bad_ref);
+	commit = lookup_commit_reference(the_repository, &oid);
+	format_commit_message(commit, "%s", &commit_name, &pp);
+	fp = fopen(git_path_bisect_log(), "a");
+	if (!fp) {
+		res = error_errno(_("could not open '%s' for "
+				       "appending"),
+				     git_path_bisect_log());
+	} else if (fprintf(fp, "# first %s commit: [%s] %s\n",
+			   terms->term_bad, oid_to_hex(&oid),
+			   commit_name.buf) < 1) {
+		res = -1;
+	}
+
+	if (fp)
+		fclose(fp);
+	strbuf_release(&commit_name);
+	free(bad_ref);
+	return res;
+}
+
+static int bisect_next(struct bisect_terms *terms, const char *prefix)
+{
+	int res, no_checkout;
+
+	if (bisect_next_check(terms, terms->term_good))
+		return -1;
+
+	no_checkout = !is_empty_or_missing_file(git_path_bisect_head());
+
+	/* Perform all bisection computation, display and checkout */
+	res = bisect_next_all(prefix, no_checkout);
+
+	if (res == -10) {
+		return bisect_successful(terms);
+	} else if (res == -2) {
+		res = bisect_skipped_commits(terms);
+		return res ? res : -2;
+	}
+	return res;
+}
+
+static int bisect_auto_next(struct bisect_terms *terms, const char *prefix)
+{
+	if (!bisect_next_check(terms, NULL))
+		return bisect_next(terms, prefix);
+
+	return 0;
+}
+
 static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
@@ -622,7 +758,9 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_AND_SET_TERMS,
 		BISECT_NEXT_CHECK,
 		BISECT_TERMS,
-		BISECT_START
+		BISECT_START,
+		BISECT_NEXT,
+		BISECT_AUTO_NEXT,
 	} cmdmode = 0;
 	int no_checkout = 0, res = 0, nolog = 0;
 	struct option options[] = {
@@ -646,6 +784,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("print out the bisect terms"), BISECT_TERMS),
 		OPT_CMDMODE(0, "bisect-start", &cmdmode,
 			 N_("start the bisect session"), BISECT_START),
+		OPT_CMDMODE(0, "bisect-next", &cmdmode,
+			 N_("find the next bisection commit"), BISECT_NEXT),
+		OPT_CMDMODE(0, "bisect-auto-next", &cmdmode,
+			 N_("verify the next bisection state then checkout the next bisection commit"), BISECT_AUTO_NEXT),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_BOOL(0, "no-log", &nolog,
@@ -707,6 +849,18 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		set_terms(&terms, "bad", "good");
 		res = bisect_start(&terms, no_checkout, argv, argc);
 		break;
+	case BISECT_NEXT:
+		if (argc)
+			return error(_("--bisect-next requires 0 arguments"));
+		get_terms(&terms);
+		res = bisect_next(&terms, prefix);
+		break;
+	case BISECT_AUTO_NEXT:
+		if (argc)
+			return error(_("--bisect-auto-next requires 0 arguments"));
+		get_terms(&terms);
+		res = bisect_auto_next(&terms, prefix);
+		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index efee12b8b1..7531b74708 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -87,7 +87,7 @@ bisect_start() {
 	# Check if we can proceed to the next bisect state.
 	#
 	get_terms
-	bisect_auto_next
+	git bisect--helper --bisect-auto-next || exit
 
 	trap '-' 0
 }
@@ -140,45 +140,7 @@ bisect_state() {
 	*)
 		usage ;;
 	esac
-	bisect_auto_next
-}
-
-bisect_auto_next() {
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD && bisect_next || :
-}
-
-bisect_next() {
-	case "$#" in 0) ;; *) usage ;; esac
-	bisect_autostart
-	git bisect--helper --bisect-next-check $TERM_GOOD $TERM_BAD $TERM_GOOD|| exit
-
-	# Perform all bisection computation, display and checkout
-	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
-	res=$?
-
-	# Check if we should exit because bisection is finished
-	if test $res -eq 10
-	then
-		bad_rev=$(git show-ref --hash --verify refs/bisect/$TERM_BAD)
-		bad_commit=$(git show-branch $bad_rev)
-		echo "# first $TERM_BAD commit: $bad_commit" >>"$GIT_DIR/BISECT_LOG"
-		exit 0
-	elif test $res -eq 2
-	then
-		echo "# only skipped commits left to test" >>"$GIT_DIR/BISECT_LOG"
-		good_revs=$(git for-each-ref --format="%(objectname)" "refs/bisect/$TERM_GOOD-*")
-		for skipped in $(git rev-list refs/bisect/$TERM_BAD --not $good_revs)
-		do
-			skipped_commit=$(git show-branch $skipped)
-			echo "# possible first $TERM_BAD commit: $skipped_commit" >>"$GIT_DIR/BISECT_LOG"
-		done
-		exit $res
-	fi
-
-	# Check for an error in the bisection process
-	test $res -ne 0 && exit $res
-
-	return 0
+	git bisect--helper --bisect-auto-next
 }
 
 bisect_visualize() {
@@ -232,7 +194,7 @@ bisect_replay () {
 			die "$(gettext "?? what are you talking about?")" ;;
 		esac
 	done <"$file"
-	bisect_auto_next
+	git bisect--helper --bisect-auto-next
 }
 
 bisect_run () {
@@ -329,7 +291,8 @@ case "$#" in
 		bisect_skip "$@" ;;
 	next)
 		# Not sure we want "next" at the UI level anymore.
-		bisect_next "$@" ;;
+		get_terms
+		git bisect--helper --bisect-next "$@" || exit ;;
 	visualize|view)
 		bisect_visualize "$@" ;;
 	reset)
-- 
gitgitgadget

