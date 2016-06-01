From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v3 00/39] i18n and test updates
Date: Wed,  1 Jun 2016 16:40:50 +0000
Message-ID: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 18:43:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b89Ek-0004Ip-Ak
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 18:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161473AbcFAQmq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 12:42:46 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47137 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932803AbcFAQmk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 12:42:40 -0400
Received: (qmail 18912 invoked from network); 1 Jun 2016 16:42:32 -0000
Received: (qmail 688 invoked from network); 1 Jun 2016 16:42:32 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 1 Jun 2016 16:42:27 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296106>

Marks several messages for translation and updates tests to pass under
GETTEXT_POISON. Some tests were updated to fit previous i18n marks, others
were updated to fit marks made by these patches. Patches that only touch
test file refer to marks done in commits previous to these ones.

This re-roll fixes issues comment on the previous discussion and adds
patches to mark more strings for translation.

Previous discussion:
http://thread.gmane.org/gmane.comp.version-control.git/295354

Interdiff v2 v3 included bellow.


Vasco Almeida (39):
  i18n: builtin/remote.c: fix mark for translation
  i18n: advice: mark string about detached head for translation
  i18n: advice: internationalize message for conflicts
  i18n: transport: mark strings for translation
  i18n: sequencer: mark entire sentences for translation
  i18n: sequencer: mark string for translation
  i18n: merge-octopus: mark messages for translation
  merge-octupus: use die shell function from git-sh-setup.sh
  i18n: rebase: fix marked string to use eval_gettext variant
  i18n: rebase: mark placeholder for translation
  i18n: bisect: simplify error message for i18n
  t6030: update to use test_i18ncmp
  i18n: git-sh-setup.sh: mark strings for translation
  i18n: rebase-interactive: mark strings for translation
  i18n: rebase-interactive: mark here-doc strings for translation
  i18n: rebase-interactive: mark comments of squash for translation
  i18n: setup: mark strings for translation
  tests: use test_i18n* functions to suppress false positives
  tests: unpack-trees: update to use test_i18n* functions
  t9003: become resilient to GETTEXT_POISON
  t4153: fix negated test_i18ngrep call
  t5523: use test_i18ngrep for negation
  i18n: bisect: mark strings for translation
  i18n: bisect: enable l10n of bisect terms in messages
  i18n: transport-helper.c: change N_() call to _()
  i18n: notes: mark strings for translation
  i18n: notes: mark options for translation
  i18n: config: unfold error messages marked for translation
  i18n: merge: mark messages for translation
  i18n: merge: change command option help to lowercase
  i18n: sequencer: add period to error message
  i18n: standardise messages
  i18n: remote: mark URL fallback text for translation
  i18n: remote: allow translations to reorder message
  i18n: init-db: join message pieces
  i18n: submodule: join strings marked for translation
  i18n: submodule: escape shell variables inside eval_gettext
  i18n: unmark die messages for translation
  i18n: branch: mark comment when editing branch description for
    translation

 Makefile                              |   5 +-
 advice.c                              |  23 ++-
 bisect.c                              |  83 ++++++----
 builtin/apply.c                       |   6 +-
 builtin/branch.c                      |   6 +-
 builtin/checkout.c                    |   6 +-
 builtin/init-db.c                     |  17 +-
 builtin/merge.c                       |  12 +-
 builtin/notes.c                       |  24 +--
 builtin/pull.c                        |   2 +-
 builtin/remote.c                      |  19 ++-
 builtin/repack.c                      |   2 +-
 cache.h                               |   9 +-
 config.c                              | 102 ++++++++++--
 git-bisect.sh                         |   7 +-
 git-merge-octopus.sh                  |  24 ++-
 git-rebase--interactive.sh            | 290 ++++++++++++++++++++--------------
 git-rebase.sh                         |   4 +-
 git-sh-i18n.sh                        |  18 +++
 git-sh-setup.sh                       |  62 ++++++--
 git-submodule.sh                      |  22 +--
 sequencer.c                           |  15 +-
 setup.c                               |  16 +-
 submodule-config.c                    |   2 +-
 t/lib-rebase.sh                       |   1 +
 t/t0008-ignores.sh                    |   4 +-
 t/t1011-read-tree-sparse-checkout.sh  |   2 +-
 t/t1300-repo-config.sh                |   8 +-
 t/t1307-config-blob.sh                |   5 +-
 t/t1308-config-set.sh                 |   4 +-
 t/t1400-update-ref.sh                 |   2 +-
 t/t1506-rev-parse-diagnosis.sh        |   2 +-
 t/t2010-checkout-ambiguous.sh         |   2 +-
 t/t2018-checkout-branch.sh            |   2 +-
 t/t3200-branch.sh                     |   6 +-
 t/t3201-branch-contains.sh            |   2 +-
 t/t3310-notes-merge-manual-resolve.sh |   8 +-
 t/t3320-notes-merge-worktrees.sh      |   4 +-
 t/t3400-rebase.sh                     |   4 +-
 t/t3404-rebase-interactive.sh         |  18 +--
 t/t4153-am-resume-override-opts.sh    |   2 +-
 t/t4208-log-magic-pathspec.sh         |   4 +-
 t/t5505-remote.sh                     |   2 +-
 t/t5510-fetch.sh                      |   2 +-
 t/t5520-pull.sh                       |   2 +-
 t/t5523-push-upstream.sh              |  12 +-
 t/t5536-fetch-conflicts.sh            |   4 +-
 t/t6030-bisect-porcelain.sh           |  26 +--
 t/t6301-for-each-ref-errors.sh        |  10 +-
 t/t7063-status-untracked-cache.sh     |   2 +-
 t/t7102-reset.sh                      |   4 +-
 t/t7201-co.sh                         |   2 +-
 t/t7400-submodule-basic.sh            |   2 +-
 t/t7403-submodule-sync.sh             |   4 +-
 t/t7406-submodule-update.sh           |  10 +-
 t/t7508-status.sh                     |   4 +-
 t/t7607-merge-overwrite.sh            |   2 +-
 t/t9003-help-autocorrect.sh           |   4 +-
 transport-helper.c                    |   2 +-
 transport.c                           |  20 +--
 wt-status.c                           |   4 +-
 61 files changed, 596 insertions(+), 378 deletions(-)

---- 8< ----
diff --git a/advice.c b/advice.c
index 4612165..b84ae49 100644
--- a/advice.c
+++ b/advice.c
@@ -119,8 +119,8 @@ void NORETURN die_conclude_merge(void)
 
 void detach_advice(const char *new_name)
 {
-	const char fmt[] =
-	N_("Note: checking out '%s'.\n\n"
+	const char *fmt =
+	_("Note: checking out '%s'.\n\n"
 	"You are in 'detached HEAD' state. You can look around, make experimental\n"
 	"changes and commit them, and you can discard any commits you make in this\n"
 	"state without impacting any branches by performing another checkout.\n\n"
diff --git a/bisect.c b/bisect.c
index 6d93edb..293d7ec 100644
--- a/bisect.c
+++ b/bisect.c
@@ -23,6 +23,15 @@ static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *term_bad;
 static const char *term_good;
 
+enum term { BAD, GOOD, OLD, NEW };
+static const char *term_names[] = {
+/* TRANSLATORS: in bisect.c source code file, the following terms are
+   used to describe a "bad commit", "good commit", "new revision", etc.
+   Please, if you can, check the source when you are not sure if a %s
+   would be replaced by one of the following terms. */
+	N_("bad"), N_("good"), N_("old"), N_("new"),  NULL
+};
+
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
 
@@ -438,12 +447,12 @@ static void read_bisect_paths(struct argv_array *array)
 	FILE *fp = fopen(filename, "r");
 
 	if (!fp)
-		die_errno("Could not open file '%s'", filename);
+		die_errno(_("Could not open file '%s'"), filename);
 
 	while (strbuf_getline_lf(&str, fp) != EOF) {
 		strbuf_trim(&str);
 		if (sq_dequote_to_argv_array(str.buf, array))
-			die("Badly quoted content in file '%s': %s",
+			die(_("Badly quoted content in file '%s': %s"),
 			    filename, str.buf);
 	}
 
@@ -649,7 +658,7 @@ static void exit_if_skipped_commits(struct commit_list *tried,
 	print_commit_list(tried, "%s\n", "%s\n");
 	if (bad)
 		printf("%s\n", oid_to_hex(bad));
-	printf("We cannot bisect more!\n");
+	printf(_("We cannot bisect more!\n"));
 	exit(2);
 }
 
@@ -702,7 +711,7 @@ static struct commit *get_commit_reference(const unsigned char *sha1)
 {
 	struct commit *r = lookup_commit_reference(sha1);
 	if (!r)
-		die("Not a valid commit name %s", sha1_to_hex(sha1));
+		die(_("Not a valid commit name %s"), sha1_to_hex(sha1));
 	return r;
 }
 
@@ -725,29 +734,29 @@ static void handle_bad_merge_base(void)
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
-		if (!strcmp(term_bad, "bad") && !strcmp(term_good, "good")) {
-			fprintf(stderr, "The merge base %s is bad.\n"
+		if (!strcmp(term_bad, term_names[BAD]) && !strcmp(term_good, term_names[GOOD])) {
+			fprintf(stderr, _("The merge base %s is bad.\n"
 				"This means the bug has been fixed "
-				"between %s and [%s].\n",
+				"between %s and [%s].\n"),
 				bad_hex, bad_hex, good_hex);
-		} else if (!strcmp(term_bad, "new") && !strcmp(term_good, "old")) {
-			fprintf(stderr, "The merge base %s is new.\n"
+		} else if (!strcmp(term_bad, term_names[NEW]) && !strcmp(term_good, term_names[OLD])) {
+			fprintf(stderr, _("The merge base %s is new.\n"
 				"The property has changed "
-				"between %s and [%s].\n",
+				"between %s and [%s].\n"),
 				bad_hex, bad_hex, good_hex);
 		} else {
-			fprintf(stderr, "The merge base %s is %s.\n"
+			fprintf(stderr, _("The merge base %s is %s.\n"
 				"This means the first '%s' commit is "
-				"between %s and [%s].\n",
-				bad_hex, term_bad, term_good, bad_hex, good_hex);
+				"between %s and [%s].\n"),
+				bad_hex, _(term_bad), _(term_good), bad_hex, good_hex);
 		}
 		exit(3);
 	}
 
-	fprintf(stderr, "Some %s revs are not ancestor of the %s rev.\n"
+	fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
-		"Maybe you mistook %s and %s revs?\n",
-		term_good, term_bad, term_good, term_bad);
+		"Maybe you mistook %s and %s revs?\n"),
+		_(term_good), _(term_bad), _(term_good), _(term_bad));
 	exit(1);
 }
 
@@ -757,12 +766,12 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 	char *bad_hex = sha1_to_hex(current_bad_oid->hash);
 	char *good_hex = join_sha1_array_hex(&good_revs, ' ');
 
-	warning("the merge base between %s and [%s] "
+	warning(_("the merge base between %s and [%s] "
 		"must be skipped.\n"
 		"So we cannot be sure the first %s commit is "
 		"between %s and %s.\n"
-		"We continue anyway.",
-		bad_hex, good_hex, term_bad, mb_hex, bad_hex);
+		"We continue anyway."),
+		bad_hex, good_hex, _(term_bad), mb_hex, bad_hex);
 	free(good_hex);
 }
 
@@ -792,7 +801,7 @@ static void check_merge_bases(int no_checkout)
 		} else if (0 <= sha1_array_lookup(&skipped_revs, mb)) {
 			handle_skipped_merge_base(mb);
 		} else {
-			printf("Bisecting: a merge base must be tested\n");
+			printf(_("Bisecting: a merge base must be tested\n"));
 			exit(bisect_checkout(mb, no_checkout));
 		}
 	}
@@ -843,7 +852,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die("a %s revision is needed", term_bad);
+		die(_("a %s revision is needed"), _(term_bad));
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -860,7 +869,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
 	if (fd < 0)
-		warning_errno("could not create file '%s'",
+		warning_errno(_("could not create file '%s'"),
 			      filename);
 	else
 		close(fd);
@@ -906,11 +915,11 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 
 	if (!fp) {
 		if (errno == ENOENT) {
-			*read_bad = "bad";
-			*read_good = "good";
+			*read_bad = term_names[BAD];
+			*read_good = term_names[GOOD];
 			return;
 		} else {
-			die_errno("could not read file '%s'", filename);
+			die_errno(_("could not read file '%s'"), filename);
 		}
 	} else {
 		strbuf_getline_lf(&str, fp);
@@ -936,10 +945,11 @@ int bisect_next_all(const char *prefix, int no_checkout)
 	struct commit_list *tried;
 	int reaches = 0, all = 0, nr, steps;
 	const unsigned char *bisect_rev;
+	char steps_msg[32];
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
-		die("reading bisect refs failed");
+		die(_("reading bisect refs failed"));
 
 	check_good_are_ancestors_of_bad(prefix, no_checkout);
 
@@ -959,16 +969,16 @@ int bisect_next_all(const char *prefix, int no_checkout)
 		 */
 		exit_if_skipped_commits(tried, NULL);
 
-		printf("%s was both %s and %s\n",
+		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
-		       term_good,
-		       term_bad);
+		       _(term_good),
+		       _(term_bad));
 		exit(1);
 	}
 
 	if (!all) {
-		fprintf(stderr, "No testable commit found.\n"
-			"Maybe you started with bad path parameters?\n");
+		fprintf(stderr, _("No testable commit found.\n"
+			"Maybe you started with bad path parameters?\n"));
 		exit(4);
 	}
 
@@ -985,9 +995,14 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 	nr = all - reaches - 1;
 	steps = estimate_bisect_steps(all);
-	printf("Bisecting: %d revision%s left to test after this "
-	       "(roughly %d step%s)\n", nr, (nr == 1 ? "" : "s"),
-	       steps, (steps == 1 ? "" : "s"));
+	xsnprintf(steps_msg, sizeof(steps_msg),
+		  Q_("(roughly %d step)", "(roughly %d steps)", steps),
+		  steps);
+	/* TRANSLATORS: the last %s will be replaced with
+	   "(roughly %d steps)" translation */
+	printf(Q_("Bisecting: %d revision left to test after this %s\n",
+		  "Bisecting: %d revisions left to test after this %s\n",
+		  nr), nr, steps_msg);
 
 	return bisect_checkout(bisect_rev, no_checkout);
 }
diff --git a/builtin/apply.c b/builtin/apply.c
index 8e4da2e..205c9f8f3 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3226,7 +3226,7 @@ static int load_patch_target(struct strbuf *buf,
 {
 	if (cached || check_index) {
 		if (read_file_or_gitlink(ce, buf))
-			return error(_("read of %s failed"), name);
+			return error(_("failed to read %s"), name);
 	} else if (name) {
 		if (S_ISGITLINK(expected_mode)) {
 			if (ce)
@@ -3237,7 +3237,7 @@ static int load_patch_target(struct strbuf *buf,
 			return error(_("reading from '%s' beyond a symbolic link"), name);
 		} else {
 			if (read_old_data(st, name, buf))
-				return error(_("read of %s failed"), name);
+				return error(_("failed to read %s"), name);
 		}
 	}
 	return 0;
@@ -3282,7 +3282,7 @@ static int load_preimage(struct image *image,
 			free_fragment_list(patch->fragments);
 			patch->fragments = NULL;
 		} else if (status) {
-			return error(_("read of %s failed"), patch->old_name);
+			return error(_("failed to read %s"), patch->old_name);
 		}
 	}
 
diff --git a/builtin/branch.c b/builtin/branch.c
index 2ecde53..12203fd 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -614,9 +614,9 @@ static int edit_branch_description(const char *branch_name)
 	if (!buf.len || buf.buf[buf.len-1] != '\n')
 		strbuf_addch(&buf, '\n');
 	strbuf_commented_addf(&buf,
-		    "Please edit the description for the branch\n"
-		    "  %s\n"
-		    "Lines starting with '%c' will be stripped.\n",
+		    _("Please edit the description for the branch\n"
+		      "  %s\n"
+		      "Lines starting with '%c' will be stripped.\n"),
 		    branch_name, comment_line_char);
 	if (write_file_gently(git_path(edit_description), "%s", buf.buf)) {
 		strbuf_release(&buf);
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3398c61..05c7b71 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -276,7 +276,7 @@ static int checkout_paths(const struct checkout_opts *opts,
 
 	hold_locked_index(lock_file, 1);
 	if (read_cache_preload(&opts->pathspec) < 0)
-		return error(_("corrupt index file"));
+		return error(_("index file corrupt"));
 
 	if (opts->source_tree)
 		read_tree_some(opts->source_tree, &opts->pathspec);
@@ -470,7 +470,7 @@ static int merge_working_tree(const struct checkout_opts *opts,
 
 	hold_locked_index(lock_file, 1);
 	if (read_cache_preload(NULL) < 0)
-		return error(_("corrupt index file"));
+		return error(_("index file corrupt"));
 
 	resolve_undo_clear();
 	if (opts->force) {
@@ -1138,7 +1138,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
 		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
-		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach the HEAD at named commit")),
+		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
diff --git a/builtin/init-db.c b/builtin/init-db.c
index b2d8d40..3a45f0b 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -397,13 +397,16 @@ int init_db(const char *template_dir, unsigned int flags)
 	if (!(flags & INIT_DB_QUIET)) {
 		int len = strlen(git_dir);
 
-		/* TRANSLATORS: The first '%s' is either "Reinitialized
-		   existing" or "Initialized empty", the second " shared" or
-		   "", and the last '%s%s' is the verbatim directory name. */
-		printf(_("%s%s Git repository in %s%s\n"),
-		       reinit ? _("Reinitialized existing") : _("Initialized empty"),
-		       get_shared_repository() ? _(" shared") : "",
-		       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+		if (reinit)
+			printf(get_shared_repository()
+			       ? _("Reinitialized existing shared Git repository in %s%s\n")
+			       : _("Reinitialized existing Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
+		else
+			printf(get_shared_repository()
+			       ? _("Initialized empty shared Git repository in %s%s\n")
+			       : _("Initialized empty Git repository in %s%s\n"),
+			       git_dir, len && git_dir[len-1] != '/' ? "/" : "");
 	}
 
 	return 0;
diff --git a/builtin/merge.c b/builtin/merge.c
index b555a1b..d82f6c1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -211,7 +211,7 @@ static struct option builtin_merge_options[] = {
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL, FF_ONLY },
 	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_BOOL(0, "verify-signatures", &verify_signatures,
-		N_("Verify that the named commit has a valid GPG signature")),
+		N_("verify that the named commit has a valid GPG signature")),
 	OPT_CALLBACK('s', "strategy", &use_strategies, N_("strategy"),
 		N_("merge strategy to use"), option_parse_strategy),
 	OPT_CALLBACK('X', "strategy-option", &xopts, N_("option=value"),
@@ -1014,7 +1014,7 @@ static int default_edit_option(void)
 	if (e) {
 		int v = git_config_maybe_bool(name, e);
 		if (v < 0)
-			die("Bad value '%s' in environment '%s'", e, name);
+			die(_("Bad value '%s' in environment '%s'"), e, name);
 		return v;
 	}
 
@@ -1115,7 +1115,7 @@ static void handle_fetch_head(struct commit_list **remotes, struct strbuf *merge
 		if (!commit) {
 			if (ptr)
 				*ptr = '\0';
-			die("not something we can merge in %s: %s",
+			die(_("not something we can merge in %s: %s"),
 			    filename, merge_names->buf + pos);
 		}
 		remotes = &commit_list_insert(commit, remotes)->next;
@@ -1149,7 +1149,7 @@ static struct commit_list *collect_parents(struct commit *head_commit,
 			struct commit *commit = get_merge_parent(argv[i]);
 			if (!commit)
 				help_unknown_ref(argv[i], "merge",
-						 "not something we can merge");
+						 _("not something we can merge"));
 			remotes = &commit_list_insert(commit, remotes)->next;
 		}
 		remoteheads = reduce_parents(head_commit, head_subsumed, remoteheads);
@@ -1421,7 +1421,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		 * If head can reach all the merge then we are up to date.
 		 * but first the most common case of merging one remote.
 		 */
-		finish_up_to_date("Already up-to-date.");
+		finish_up_to_date(_("Already up-to-date."));
 		goto done;
 	} else if (fast_forward != FF_NO && !remoteheads->next &&
 			!common->next &&
@@ -1506,7 +1506,7 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			}
 		}
 		if (up_to_date) {
-			finish_up_to_date("Already up-to-date. Yeeah!");
+			finish_up_to_date(_("Already up-to-date. Yeeah!"));
 			goto done;
 		}
 	}
diff --git a/builtin/notes.c b/builtin/notes.c
index c65b59a..0572051 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -749,7 +749,7 @@ static int git_config_get_notes_strategy(const char *key,
 	if (git_config_get_string(key, &value))
 		return 1;
 	if (parse_notes_merge_strategy(value, strategy))
-		git_die_config(key, "unknown notes merge strategy %s", value);
+		git_die_config(key, _("unknown notes merge strategy %s"), value);
 
 	free(value);
 	return 0;
@@ -788,15 +788,15 @@ static int merge(int argc, const char **argv, const char *prefix)
 	if (strategy || do_commit + do_abort == 0)
 		do_merge = 1;
 	if (do_merge + do_commit + do_abort != 1) {
-		error("cannot mix --commit, --abort or -s/--strategy");
+		error(_("cannot mix --commit, --abort or -s/--strategy"));
 		usage_with_options(git_notes_merge_usage, options);
 	}
 
 	if (do_merge && argc != 1) {
-		error("Must specify a notes ref to merge");
+		error(_("Must specify a notes ref to merge"));
 		usage_with_options(git_notes_merge_usage, options);
 	} else if (!do_merge && argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_merge_usage, options);
 	}
 
@@ -817,7 +817,7 @@ static int merge(int argc, const char **argv, const char *prefix)
 
 	if (strategy) {
 		if (parse_notes_merge_strategy(strategy, &o.strategy)) {
-			error("Unknown -s/--strategy: %s", strategy);
+			error(_("Unknown -s/--strategy: %s"), strategy);
 			usage_with_options(git_notes_merge_usage, options);
 		}
 	} else {
@@ -857,11 +857,11 @@ static int merge(int argc, const char **argv, const char *prefix)
 			die(_("A notes merge into %s is already in-progress at %s"),
 			    default_notes_ref(), wt->path);
 		if (create_symref("NOTES_MERGE_REF", default_notes_ref(), NULL))
-			die("Failed to store link to current notes ref (%s)",
+			die(_("Failed to store link to current notes ref (%s)"),
 			    default_notes_ref());
-		printf("Automatic notes merge failed. Fix conflicts in %s and "
-		       "commit the result with 'git notes merge --commit', or "
-		       "abort the merge with 'git notes merge --abort'.\n",
+		printf(_("Automatic notes merge failed. Fix conflicts in %s and "
+			 "commit the result with 'git notes merge --commit', or "
+			 "abort the merge with 'git notes merge --abort'.\n"),
 		       git_path(NOTES_MERGE_WORKTREE));
 	}
 
@@ -934,8 +934,8 @@ static int prune(int argc, const char **argv, const char *prefix)
 	struct notes_tree *t;
 	int show_only = 0, verbose = 0;
 	struct option options[] = {
-		OPT__DRY_RUN(&show_only, "do not remove, show only"),
-		OPT__VERBOSE(&verbose, "report pruned notes"),
+		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
+		OPT__VERBOSE(&verbose, N_("report pruned notes")),
 		OPT_END()
 	};
 
@@ -964,7 +964,7 @@ static int get_ref(int argc, const char **argv, const char *prefix)
 			     git_notes_get_ref_usage, 0);
 
 	if (argc) {
-		error("too many parameters");
+		error(_("too many parameters"));
 		usage_with_options(git_notes_get_ref_usage, options);
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index ae74da6..7f0f78b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -952,7 +952,7 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 	struct show_info *show_info = cb_data;
 	struct branch_info *branch_info = item->util;
 	struct string_list *merge = &branch_info->merge;
-	const char *also;
+	int width = show_info->width + 4;
 	int i;
 
 	if (branch_info->rebase && branch_info->merge.nr > 1) {
@@ -969,13 +969,12 @@ static int show_local_info_item(struct string_list_item *item, void *cb_data)
 		return 0;
 	} else if (show_info->any_rebase) {
 		printf_ln(_(" merges with remote %s"), merge->items[0].string);
-		also = _("    and with remote");
+		width++;
 	} else {
 		printf_ln(_("merges with remote %s"), merge->items[0].string);
-		also = _("   and with remote");
 	}
 	for (i = 1; i < merge->nr; i++)
-		printf("    %-*s %s %s\n", show_info->width, "", also,
+		printf(_("%-*s    and with remote %s\n"), width, "",
 		       merge->items[i].string);
 
 	return 0;
@@ -1158,11 +1157,11 @@ static int show(int argc, const char **argv)
 			   the one in "  Fetch URL: %s" translation */
 			printf_ln(_("  Push  URL: %s"), url[i]);
 		if (!i)
-			printf_ln(_("  Push  URL: %s"), "(no URL)");
+			printf_ln(_("  Push  URL: %s"), _("(no URL)"));
 		if (no_query)
-			printf_ln(_("  HEAD branch: %s"), "(not queried)");
+			printf_ln(_("  HEAD branch: %s"), _("(not queried)"));
 		else if (!states.heads.nr)
-			printf_ln(_("  HEAD branch: %s"), "(unknown)");
+			printf_ln(_("  HEAD branch: %s"), _("(unknown)"));
 		else if (states.heads.nr == 1)
 			printf_ln(_("  HEAD branch: %s"), states.heads.items[0].string);
 		else {
diff --git a/builtin/repack.c b/builtin/repack.c
index 858db38..0108819 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -378,7 +378,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 					  item->string,
 					  exts[ext].name);
 			if (remove_path(fname))
-				warning(_("removing '%s' failed"), fname);
+				warning(_("failed to remove '%s'"), fname);
 			free(fname);
 		}
 	}
diff --git a/cache.h b/cache.h
index 6049f86..4bded9a 100644
--- a/cache.h
+++ b/cache.h
@@ -1559,10 +1559,17 @@ struct git_config_source {
 	const char *blob;
 };
 
+enum git_config_origin_type {
+	CFG_BLOB,
+	CFG_FILE,
+	CFG_STDIN,
+	CFG_SUBMODULE_BLOB
+};
+
 typedef int (*config_fn_t)(const char *, const char *, void *);
 extern int git_default_config(const char *, const char *, void *);
 extern int git_config_from_file(config_fn_t fn, const char *, void *);
-extern int git_config_from_mem(config_fn_t fn, const char *origin_type,
+extern int git_config_from_mem(config_fn_t fn, const enum git_config_origin_type,
 					const char *name, const char *buf, size_t len, void *data);
 extern void git_config_push_parameter(const char *text);
 extern int git_config_from_parameters(config_fn_t fn, void *data);
diff --git a/config.c b/config.c
index f51c56b..b08a418 100644
--- a/config.c
+++ b/config.c
@@ -24,7 +24,7 @@ struct config_source {
 			size_t pos;
 		} buf;
 	} u;
-	const char *origin_type;
+	enum git_config_origin_type origin_type;
 	const char *name;
 	const char *path;
 	int die_on_error;
@@ -417,6 +417,7 @@ static int git_parse_source(config_fn_t fn, void *data)
 	int comment = 0;
 	int baselen = 0;
 	struct strbuf *var = &cf->var;
+	char error_msg[128];
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -471,10 +472,38 @@ static int git_parse_source(config_fn_t fn, void *data)
 		if (get_value(fn, data, var) < 0)
 			break;
 	}
+
+	switch (cf->origin_type) {
+	case CFG_BLOB:
+		xsnprintf(error_msg, sizeof(error_msg),
+			  _("bad config line %d in blob %s"),
+			  cf->linenr, cf->name);
+		break;
+	case CFG_FILE:
+		xsnprintf(error_msg, sizeof(error_msg),
+			  _("bad config line %d in file %s"),
+			  cf->linenr, cf->name);
+		break;
+	case CFG_STDIN:
+		xsnprintf(error_msg, sizeof(error_msg),
+			  _("bad config line %d in standard input"),
+			  cf->linenr);
+		break;
+	case CFG_SUBMODULE_BLOB:
+		xsnprintf(error_msg, sizeof(error_msg),
+			  _("bad config line %d in submodule-blob %s"),
+			  cf->linenr, cf->name);
+		break;
+	default:
+		xsnprintf(error_msg, sizeof(error_msg),
+			  _("bad config line %d in %s"),
+			  cf->linenr, cf->name);
+	}
+
 	if (cf->die_on_error)
-		die(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
+		die(error_msg);
 	else
-		return error(_("bad config line %d in %s %s"), cf->linenr, cf->origin_type, cf->name);
+		return error(error_msg);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -583,16 +612,42 @@ int git_parse_ulong(const char *value, unsigned long *ret)
 NORETURN
 static void die_bad_number(const char *name, const char *value)
 {
-	const char *reason = errno == ERANGE ?
-			     "out of range" :
-			     "invalid unit";
 	if (!value)
 		value = "";
 
-	if (cf && cf->origin_type && cf->name)
-		die(_("bad numeric config value '%s' for '%s' in %s %s: %s"),
-		    value, name, cf->origin_type, cf->name, reason);
-	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
+	if (!(cf && cf->name))
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s': out of range")
+		    : _("bad numeric config value '%s' for '%s': invalid unit"),
+		    value, name);
+
+	switch (cf->origin_type) {
+	case CFG_BLOB:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in blob %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in blob %s: invalid unit"),
+		    value, name, cf->name);
+	case CFG_FILE:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in file %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in file %s: invalid unit"),
+		    value, name, cf->name);
+	case CFG_STDIN:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in standard input: out of range")
+		    : _("bad numeric config value '%s' for '%s' in standard input: invalid unit"),
+		    value, name);
+	case CFG_SUBMODULE_BLOB:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in submodule-blob %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in submodule-blob %s: invalid unit"),
+		    value, name, cf->name);
+	default:
+		die(errno == ERANGE
+		    ? _("bad numeric config value '%s' for '%s' in %s: out of range")
+		    : _("bad numeric config value '%s' for '%s' in %s: invalid unit"),
+		    value, name, cf->name);
+	}
 }
 
 int git_config_int(const char *name, const char *value)
@@ -1069,7 +1124,8 @@ static int do_config_from(struct config_source *top, config_fn_t fn, void *data)
 }
 
 static int do_config_from_file(config_fn_t fn,
-		const char *origin_type, const char *name, const char *path, FILE *f,
+		const enum git_config_origin_type origin_type,
+		const char *name, const char *path, FILE *f,
 		void *data)
 {
 	struct config_source top;
@@ -1088,7 +1144,7 @@ static int do_config_from_file(config_fn_t fn,
 
 static int git_config_from_stdin(config_fn_t fn, void *data)
 {
-	return do_config_from_file(fn, "standard input", "", NULL, stdin, data);
+	return do_config_from_file(fn, CFG_STDIN, "", NULL, stdin, data);
 }
 
 int git_config_from_file(config_fn_t fn, const char *filename, void *data)
@@ -1099,14 +1155,14 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	f = fopen(filename, "r");
 	if (f) {
 		flockfile(f);
-		ret = do_config_from_file(fn, "file", filename, filename, f, data);
+		ret = do_config_from_file(fn, CFG_FILE, filename, filename, f, data);
 		funlockfile(f);
 		fclose(f);
 	}
 	return ret;
 }
 
-int git_config_from_mem(config_fn_t fn, const char *origin_type,
+int git_config_from_mem(config_fn_t fn, const enum git_config_origin_type origin_type,
 			const char *name, const char *buf, size_t len, void *data)
 {
 	struct config_source top;
@@ -1143,7 +1199,7 @@ static int git_config_from_blob_sha1(config_fn_t fn,
 		return error("reference '%s' does not point to a blob", name);
 	}
 
-	ret = git_config_from_mem(fn, "blob", name, buf, size, data);
+	ret = git_config_from_mem(fn, CFG_BLOB, name, buf, size, data);
 	free(buf);
 
 	return ret;
@@ -2442,7 +2498,21 @@ int parse_config_key(const char *var,
 
 const char *current_config_origin_type(void)
 {
-	return cf && cf->origin_type ? cf->origin_type : "command line";
+	if (!cf)
+		return "command line";
+
+	switch (cf->origin_type) {
+	case CFG_BLOB:
+		return "blob";
+	case CFG_FILE:
+		return "file";
+	case CFG_STDIN:
+		return "standard input";
+	case CFG_SUBMODULE_BLOB:
+		return "submodule-blob";
+	default:
+		return "command line";
+	}
 }
 
 const char *current_config_name(void)
diff --git a/git-bisect.sh b/git-bisect.sh
index 737bf05..c9acab6 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -275,7 +275,7 @@ bisect_state() {
 	check_and_set_terms $state
 	case "$#,$state" in
 	0,*)
-		die "$(gettext "Please call 'bisect_state' with at least one argument.")" ;;
+		die "Please call 'bisect_state' with at least one argument." ;;
 	1,"$TERM_BAD"|1,"$TERM_GOOD"|1,skip)
 		bisected_head=$(bisect_head)
 		rev=$(git rev-parse --verify "$bisected_head") ||
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index caf4aa1..a545d92 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -222,11 +222,12 @@ has_action () {
 }
 
 is_empty_commit() {
-	sha1=$1
-	tree=$(git rev-parse -q --verify "$sha1"^{tree} 2>/dev/null ||
-		die "$(eval_gettext "\$sha1: not a commit that can be picked")")
-	ptree=$(git rev-parse -q --verify "$sha1"^^{tree} 2>/dev/null ||
-		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904)
+	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null) || {
+		sha1=$1
+		die "$(eval_gettext "\$sha1: not a commit that can be picked")"
+	}
+	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null) ||
+		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
 	test "$tree" = "$ptree"
 }
 
diff --git a/git-sh-i18n.sh b/git-sh-i18n.sh
index c14c303..1ef1889 100644
--- a/git-sh-i18n.sh
+++ b/git-sh-i18n.sh
@@ -53,6 +53,13 @@ gettext_without_eval_gettext)
 			git sh-i18n--envsubst "$1"
 		)
 	}
+
+	eval_ngettext () {
+		ngettext "$1" "$2" "$3" | (
+			export PATH $(git sh-i18n--envsubst --variables "$2");
+			git sh-i18n--envsubst "$2"
+		)
+	}
 	;;
 poison)
 	# Emit garbage so that tests that incorrectly rely on translatable
@@ -80,6 +87,13 @@ poison)
 			git sh-i18n--envsubst "$1"
 		)
 	}
+
+	eval_ngettext () {
+		(test "$3" = 1 && printf "%s" "$1" || printf "%s" "$2") | (
+			export PATH $(git sh-i18n--envsubst --variables "$2");
+			git sh-i18n--envsubst "$2"
+		)
+	}
 	;;
 esac
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 55efa23..61a3d95 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -192,32 +192,35 @@ cd_to_toplevel () {
 }
 
 require_work_tree_exists () {
-	program_name=$0
 	if test "z$(git rev-parse --is-bare-repository)" != zfalse
 	then
+		program_name=$0
 		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
 	fi
 }
 
 require_work_tree () {
-	program_name=$0
-	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
+	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true || {
+		program_name=$0
 		die "$(gettext "fatal: \$program_name cannot be used without a working tree.")"
+	}
 }
 
 require_clean_work_tree () {
-	action=$1
-	hint=$2
 	git rev-parse --verify HEAD >/dev/null || exit 1
 	git update-index -q --ignore-submodules --refresh
 	err=0
 
 	if ! git diff-files --quiet --ignore-submodules
 	then
+		action=$1
 		case "$action" in
 		rebase)
 			gettextln "Cannot rebase: You have unstaged changes." >&2
 			;;
+		"rewrite branches")
+			gettextln "Cannot rewrite branches: You have unstaged changes." >&2
+			;;
 		"pull with rebase")
 			gettextln "Cannot pull with rebase: You have unstaged changes." >&2
 			;;
@@ -232,6 +235,7 @@ require_clean_work_tree () {
 	then
 		if test $err = 0
 		then
+			action=$1
 			case "$action" in
 			rebase)
 				gettextln "Cannot rebase: Your index contains uncommitted changes." >&2
@@ -251,7 +255,7 @@ require_clean_work_tree () {
 
 	if test $err = 1
 	then
-		test -n "$hint" && echo "$2" >&2
+		test -n "$2" && echo "$2" >&2
 		exit 1
 	fi
 }
diff --git a/git-submodule.sh b/git-submodule.sh
index 5a4dec0..75a7ebe 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -275,14 +275,15 @@ Use -f if you really want to add it." >&2
 		then
 			if test -z "$force"
 			then
-				echo >&2 "$(eval_gettext "A git directory for '\$sm_name' is found locally with remote(s):")"
+				eval_gettextln >&2 "A git directory for '\$sm_name' is found locally with remote(s):"
 				GIT_DIR=".git/modules/$sm_name" GIT_WORK_TREE=. git remote -v | grep '(fetch)' | sed -e s,^,"  ", -e s,' (fetch)',, >&2
-				echo >&2 "$(eval_gettext "If you want to reuse this local git directory instead of cloning again from")"
-				echo >&2 "  $realrepo"
-				echo >&2 "$(eval_gettext "use the '--force' option. If the local git directory is not the correct repo")"
-				die "$(eval_gettext "or you are unsure what this means choose another name with the '--name' option.")"
+				die "$(eval_gettextln "\
+If you want to reuse this local git directory instead of cloning again from
+  \$realrepo
+use the '--force' option. If the local git directory is not the correct repo
+or you are unsure what this means choose another name with the '--name' option.")"
 			else
-				echo "$(eval_gettext "Reactivating local git directory for submodule '\$sm_name'.")"
+				eval_gettextln "Reactivating local git directory for submodule '\$sm_name'."
 			fi
 		fi
 		git submodule--helper clone ${GIT_QUIET:+--quiet} --prefix "$wt_prefix" --path "$sm_path" --name "$sm_name" --url "$realrepo" ${reference:+"$reference"} ${depth:+"$depth"} || exit
@@ -467,8 +468,9 @@ cmd_deinit()
 			# Protect submodules containing a .git directory
 			if test -d "$sm_path/.git"
 			then
-				echo >&2 "$(eval_gettext "Submodule work tree '\$displaypath' contains a .git directory")"
-				die "$(eval_gettext "(use 'rm -rf' if you really want to remove it including all of its history)")"
+				die "$(eval_gettext "\
+Submodule work tree '\$displaypath' contains a .git directory
+(use 'rm -rf' if you really want to remove it including all of its history)")"
 			fi
 
 			if test -z "$force"
@@ -646,7 +648,7 @@ cmd_update()
 			remote_name=$(sanitize_submodule_env; cd "$sm_path" && get_default_remote)
 			sha1=$(sanitize_submodule_env; cd "$sm_path" &&
 				git rev-parse --verify "${remote_name}/${branch}") ||
-			die "$(eval_gettext "Unable to find current ${remote_name}/${branch} revision in submodule path '\$sm_path'")"
+			die "$(eval_gettext "Unable to find current \${remote_name}/\${branch} revision in submodule path '\$sm_path'")"
 		fi
 
 		if test "$subsha1" != "$sha1" || test -n "$force"
@@ -670,7 +672,7 @@ cmd_update()
 				# not be reachable from any of the refs
 				is_tip_reachable "$sm_path" "$sha1" ||
 				fetch_in_submodule "$sm_path" "$sha1" ||
-				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain $sha1. Direct fetching of that commit failed.")"
+				die "$(eval_gettext "Fetched in submodule path '\$displaypath', but it did not contain \$sha1. Direct fetching of that commit failed.")"
 			fi
 
 			must_die_on_failure=
diff --git a/sequencer.c b/sequencer.c
index 57b3671..e916387 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -190,7 +190,7 @@ static void write_message(struct strbuf *msgbuf, const char *filename)
 		die_errno(_("Could not write to %s"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s"), filename);
+		die(_("Error wrapping up %s."), filename);
 }
 
 static struct tree *empty_tree(void)
diff --git a/submodule-config.c b/submodule-config.c
index debab29..f53f6bd 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -439,7 +439,7 @@ static const struct submodule *config_from(struct submodule_cache *cache,
 	parameter.commit_sha1 = commit_sha1;
 	parameter.gitmodules_sha1 = sha1;
 	parameter.overwrite = 0;
-	git_config_from_mem(parse_config, "submodule-blob", rev.buf,
+	git_config_from_mem(parse_config, CFG_SUBMODULE_BLOB, rev.buf,
 			config, config_size, &parameter);
 	free(config);
 
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index 4079fef..eed31ff 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -61,9 +61,6 @@ test_expect_success 'parse errors in blobs are properly attributed' '
 	git commit -m broken &&
 
 	test_must_fail git config --blob=HEAD:config some.value 2>err &&
-
-	# just grep for our token as the exact error message is likely to
-	# change or be internationalized
 	test_i18ngrep "HEAD:config" err
 '
 
diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
index d557212..6967436 100755
--- a/t/t3310-notes-merge-manual-resolve.sh
+++ b/t/t3310-notes-merge-manual-resolve.sh
@@ -178,7 +178,7 @@ test_expect_success 'merge z into m (== y) with default ("manual") resolver => C
 	git config core.notesRef refs/notes/m &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -381,7 +381,7 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	git config core.notesRef refs/notes/m &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -415,7 +415,7 @@ git rev-parse refs/notes/z > pre_merge_z
 test_expect_success 'redo merge of z into m (== y) with default ("manual") resolver => Conflicting 3-way merge' '
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
@@ -496,7 +496,7 @@ test_expect_success 'redo merge of z into m (== y) with default ("manual") resol
 	git update-ref refs/notes/m refs/notes/y &&
 	test_must_fail git notes merge z >output &&
 	# Output should point to where to resolve conflicts
-	grep -q "\\.git/NOTES_MERGE_WORKTREE" output &&
+	test_i18ngrep "\\.git/NOTES_MERGE_WORKTREE" output &&
 	# Inspect merge conflicts
 	ls .git/NOTES_MERGE_WORKTREE >output_conflicts &&
 	test_cmp expect_conflicts output_conflicts &&
diff --git a/t/t3320-notes-merge-worktrees.sh b/t/t3320-notes-merge-worktrees.sh
index 522157b..6e05115 100755
--- a/t/t3320-notes-merge-worktrees.sh
+++ b/t/t3320-notes-merge-worktrees.sh
@@ -62,7 +62,7 @@ test_expect_success 'merge z into x while mid-merge on y succeeds' '
 		cd worktree2 &&
 		git config core.notesRef refs/notes/x &&
 		test_must_fail git notes merge z 2>&1 >out &&
-		grep "Automatic notes merge failed" out &&
+		test_i18ngrep "Automatic notes merge failed" out &&
 		grep -v "A notes merge into refs/notes/x is already in-progress in" out
 	) &&
 	echo "ref: refs/notes/x" >expect &&
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 7012011..86d1380 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -362,7 +362,7 @@ test_expect_success 'bisect starting with a detached HEAD' '
 test_expect_success 'bisect errors out if bad and good are mistaken' '
 	git bisect reset &&
 	test_must_fail git bisect start $HASH2 $HASH4 2> rev_list_error &&
-	grep "mistook good and bad" rev_list_error &&
+	test_i18ngrep "mistook good and bad" rev_list_error &&
 	git bisect reset
 '
 
@@ -404,7 +404,7 @@ test_expect_success 'side branch creation' '
 
 test_expect_success 'good merge base when good and bad are siblings' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect good > my_bisect_log.txt &&
 	test_must_fail grep "merge base must be tested" my_bisect_log.txt &&
@@ -413,7 +413,7 @@ test_expect_success 'good merge base when good and bad are siblings' '
 '
 test_expect_success 'skipped merge base when good and bad are siblings' '
 	git bisect start "$SIDE_HASH7" "$HASH7" > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	git bisect skip > my_bisect_log.txt 2>&1 &&
 	grep "warning" my_bisect_log.txt &&
@@ -423,11 +423,11 @@ test_expect_success 'skipped merge base when good and bad are siblings' '
 
 test_expect_success 'bad merge base when good and bad are siblings' '
 	git bisect start "$HASH7" HEAD > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep $HASH4 my_bisect_log.txt &&
 	test_must_fail git bisect bad > my_bisect_log.txt 2>&1 &&
-	grep "merge base $HASH4 is bad" my_bisect_log.txt &&
-	grep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt &&
+	test_i18ngrep "merge base $HASH4 is bad" my_bisect_log.txt &&
+	test_i18ngrep "fixed between $HASH4 and \[$SIDE_HASH7\]" my_bisect_log.txt &&
 	git bisect reset
 '
 
@@ -460,9 +460,9 @@ test_expect_success 'many merge bases creation' '
 
 test_expect_success 'good merge bases when good and bad are siblings' '
 	git bisect start "$B_HASH" "$A_HASH" > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
-	grep "merge base must be tested" my_bisect_log2.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log2.txt &&
 	{
 		{
 			grep "$SIDE_HASH5" my_bisect_log.txt &&
@@ -477,14 +477,14 @@ test_expect_success 'good merge bases when good and bad are siblings' '
 
 test_expect_success 'optimized merge base checks' '
 	git bisect start "$HASH7" "$SIDE_HASH7" > my_bisect_log.txt &&
-	grep "merge base must be tested" my_bisect_log.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
 	grep "$HASH4" my_bisect_log.txt &&
 	git bisect good > my_bisect_log2.txt &&
 	test -f ".git/BISECT_ANCESTORS_OK" &&
 	test "$HASH6" = $(git rev-parse --verify HEAD) &&
 	git bisect bad > my_bisect_log3.txt &&
 	git bisect good "$A_HASH" > my_bisect_log4.txt &&
-	grep "merge base must be tested" my_bisect_log4.txt &&
+	test_i18ngrep "merge base must be tested" my_bisect_log4.txt &&
 	test_must_fail test -f ".git/BISECT_ANCESTORS_OK"
 '
 
@@ -562,7 +562,7 @@ test_expect_success 'skipping away from skipped commit' '
 
 test_expect_success 'erroring out when using bad path parameters' '
 	test_must_fail git bisect start $PARA_HASH7 $HASH1 -- foobar 2> error.txt &&
-	grep "bad path parameters" error.txt
+	test_i18ngrep "bad path parameters" error.txt
 '
 
 test_expect_success 'test bisection on bare repo - --no-checkout specified' '
diff --git a/t/t7201-co.sh b/t/t7201-co.sh
index 8859236..d4b217b 100755
--- a/t/t7201-co.sh
+++ b/t/t7201-co.sh
@@ -257,7 +257,7 @@ test_expect_success 'checkout to detach HEAD' '
 	git checkout -f renamer && git clean -f &&
 	git checkout renamer^ 2>messages &&
 	test_i18ngrep "HEAD is now at 7329388" messages &&
-	test_line_count -gt 1 messages &&
+	(test_line_count -gt 1 messages || test -n "$GETTEXT_POISON") &&
 	H=$(git rev-parse --verify HEAD) &&
 	M=$(git show-ref -s --verify refs/heads/master) &&
 	test "z$H" = "z$M" &&
diff --git a/transport-helper.c b/transport-helper.c
index bd666b2..4208743 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1038,7 +1038,7 @@ static struct ref *get_refs_list(struct transport *transport, int for_push)
 				(*tail)->status |= REF_STATUS_UPTODATE;
 				if (read_ref((*tail)->name,
 					     (*tail)->old_oid.hash) < 0)
-					die(N_("Could not read ref %s"),
+					die(_("Could not read ref %s"),
 					    (*tail)->name);
 			}
 		}
diff --git a/wt-status.c b/wt-status.c
index 4f27bd6..5a91279 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -263,7 +263,7 @@ static const char *wt_status_unmerged_status_string(int stagemask)
 	case 7:
 		return _("both modified:");
 	default:
-		die(_("bug: unhandled unmerged status %x"), stagemask);
+		die("bug: unhandled unmerged status %x", stagemask);
 	}
 }
 
@@ -388,7 +388,7 @@ static void wt_status_print_change_data(struct wt_status *s,
 	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	what = wt_status_diff_status_string(status);
 	if (!what)
-		die(_("bug: unhandled diff status %c"), status);
+		die("bug: unhandled diff status %c", status);
 	len = label_width - utf8_strwidth(what);
 	assert(len >= 0);
 	if (status == DIFF_STATUS_COPIED || status == DIFF_STATUS_RENAMED)
---- 8< ----

-- 
2.7.3
