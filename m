From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v2 00/22] i18n and test updates
Date: Mon, 23 May 2016 19:27:19 +0000
Message-ID: <1464031661-18988-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 21:29:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4vXN-0001S3-GA
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 21:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbcEWT3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 15:29:09 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:47237 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751429AbcEWT3H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 15:29:07 -0400
Received: (qmail 23589 invoked from network); 23 May 2016 19:29:04 -0000
Received: (qmail 29113 invoked from network); 23 May 2016 19:29:04 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 23 May 2016 19:28:59 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295354>

Marks several messages for translation and updates tests to pass under
GETTEXT_POISON. Some tests were updated to fit previous i18n marks, others
were updated to fit marks made by these patches. Patches that only touch
test file refer to marks done in commits previous to these ones.

This re-roll takes into consideration the comments for v1 at
http://thread.gmane.org/gmane.comp.version-control.git/294946

Interdiff of v1 to v2 is included below.

Vasco Almeida (22):
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

 Makefile                             |   5 +-
 advice.c                             |  21 ++-
 builtin/pull.c                       |   2 +-
 builtin/remote.c                     |   6 +-
 git-bisect.sh                        |   5 +-
 git-merge-octopus.sh                 |  24 ++-
 git-rebase--interactive.sh           | 287 +++++++++++++++++++++--------------
 git-rebase.sh                        |   4 +-
 git-sh-i18n.sh                       |   4 +
 git-sh-setup.sh                      |  56 +++++--
 sequencer.c                          |  13 +-
 setup.c                              |  16 +-
 t/lib-rebase.sh                      |   1 +
 t/t0008-ignores.sh                   |   4 +-
 t/t1011-read-tree-sparse-checkout.sh |   2 +-
 t/t1300-repo-config.sh               |   8 +-
 t/t1307-config-blob.sh               |   2 +-
 t/t1308-config-set.sh                |   4 +-
 t/t1400-update-ref.sh                |   2 +-
 t/t1506-rev-parse-diagnosis.sh       |   2 +-
 t/t2010-checkout-ambiguous.sh        |   2 +-
 t/t2018-checkout-branch.sh           |   2 +-
 t/t3200-branch.sh                    |   6 +-
 t/t3201-branch-contains.sh           |   2 +-
 t/t3320-notes-merge-worktrees.sh     |   2 +-
 t/t3400-rebase.sh                    |   4 +-
 t/t3404-rebase-interactive.sh        |  18 +--
 t/t4153-am-resume-override-opts.sh   |   2 +-
 t/t4208-log-magic-pathspec.sh        |   4 +-
 t/t5505-remote.sh                    |   2 +-
 t/t5510-fetch.sh                     |   2 +-
 t/t5520-pull.sh                      |   2 +-
 t/t5523-push-upstream.sh             |  12 +-
 t/t5536-fetch-conflicts.sh           |   4 +-
 t/t6030-bisect-porcelain.sh          |   4 +-
 t/t6301-for-each-ref-errors.sh       |  10 +-
 t/t7063-status-untracked-cache.sh    |   2 +-
 t/t7102-reset.sh                     |   4 +-
 t/t7400-submodule-basic.sh           |   2 +-
 t/t7403-submodule-sync.sh            |   4 +-
 t/t7406-submodule-update.sh          |  10 +-
 t/t7508-status.sh                    |   4 +-
 t/t7607-merge-overwrite.sh           |   2 +-
 t/t9003-help-autocorrect.sh          |   4 +-
 transport.c                          |  20 +--
 45 files changed, 352 insertions(+), 246 deletions(-)

---- >8 ----
diff --git a/advice.c b/advice.c
index bc531fc..4612165 100644
--- a/advice.c
+++ b/advice.c
@@ -80,17 +80,17 @@ int git_default_advice_config(const char *var, const char *value)
 int error_resolve_conflict(const char *me)
 {
 	if (!strcmp(me, "cherry-pick"))
-		error(_("cherry-pick is not possible because you have unmerged files."));
+		error(_("Cherry-picking is not possible because you have unmerged files."));
 	else if (!strcmp(me, "commit"))
-		error(_("commit is not possible because you have unmerged files."));
+		error(_("Committing is not possible because you have unmerged files."));
 	else if (!strcmp(me, "merge"))
-		error(_("merge is not possible because you have unmerged files."));
+		error(_("Merging is not possible because you have unmerged files."));
 	else if (!strcmp(me, "pull"))
-		error(_("pull is not possible because you have unmerged files."));
+		error(_("Pulling is not possible because you have unmerged files."));
 	else if (!strcmp(me, "revert"))
-		error(_("revert is not possible because you have unmerged files."));
+		error(_("Reverting is not possible because you have unmerged files."));
 	else
-		error(_("%s is not possible because you have unmerged files."),
+		error(_("It is not possible to %s because you have unmerged files."),
 			me);
 
 	if (advice_resolve_conflict)
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b04389b..8e58127 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -128,7 +128,7 @@ mark_action_done () {
 	if test "$last_count" != "$new_count"
 	then
 		last_count=$new_count
-		printf "$(gettext Rebasing) (%d/%d)\r" $new_count $total
+		eval_gettext "Rebasing (\$new_count/\$total)"; printf "\r"
 		test -z "$verbose" || echo
 	fi
 }
@@ -200,15 +200,14 @@ exit_with_patch () {
 	make_patch $1
 	git rev-parse --verify HEAD > "$amend"
 	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-	# TRANSLATORS: after this line is a command to be issued by the user
-	warn "$(gettext "You can amend the commit now, with")"
-	warn
-	warn "	git commit --amend $gpg_sign_opt_quoted"
-	warn
-	# TRANSLATORS: after this line is a command to be issued by the user
-	warn "$(gettext "Once you are satisfied with your changes, run")"
-	warn
-	warn "	git rebase --continue"
+	warn "$(eval_gettext "\
+You can amend the commit now, with
+
+	git commit --amend \$gpg_sign_opt_quoted
+
+Once you are satisfied with your changes, run
+
+	git rebase --continue")"
 	warn
 	exit $2
 }
@@ -657,7 +656,7 @@ you are able to reword the commit.")"
 	x|"exec")
 		read -r command rest < "$todo"
 		mark_action_done
-		printf "$(gettext Executing:) %s\n" "$rest"
+		eval_gettextln "Executing: \$rest"
 		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
 		status=$?
 		# Run in subshell because require_clean_work_tree can die.
@@ -665,14 +664,14 @@ you are able to reword the commit.")"
 		(require_clean_work_tree "rebase" 2>/dev/null) || dirty=t
 		if test "$status" -ne 0
 		then
-			warn "$(gettext "Execution failed:") $rest"
+			warn "$(eval_gettext "Execution failed: \$rest")"
 			test "$dirty" = f ||
 				warn "$(gettext "and made changes to the index and/or the working tree")"
 
-			# TRANSLATORS: after this line is a command to be issued by the user
-			warn "$(gettext "You can fix the problem, and then run")"
-			warn
-			warn "	git rebase --continue"
+			warn "$(gettext "\
+You can fix the problem, and then run
+
+	git rebase --continue")"
 			warn
 			if test $status -eq 127		# command not found
 			then
@@ -685,15 +684,15 @@ you are able to reword the commit.")"
 			warn "$(eval_gettext "\
 Execution succeeded: \$rest
 but left changes to the index and/or the working tree
-Commit or stash your changes, and then run")"
-			warn
-			warn "	git rebase --continue"
+Commit or stash your changes, and then run
+
+	git rebase --continue")"
 			warn
 			exit 1
 		fi
 		;;
 	*)
-		warn "$(gettext "Unknown command:") $command $sha1 $rest"
+		warn "$(eval_gettext "Unknown command: \$command \$sha1 \$rest")"
 		fixtodo="$(gettext "Please fix this using 'git rebase --edit-todo'.")"
 		if git rev-parse --verify -q "$sha1" >/dev/null
 		then
diff --git a/setup.c b/setup.c
index c86bf5c..6d0e0c9 100644
--- a/setup.c
+++ b/setup.c
@@ -157,8 +157,8 @@ static void NORETURN die_verify_filename(const char *prefix,
 					 int diagnose_misspelt_rev)
 {
 	if (!diagnose_misspelt_rev)
-		die("%s: no such path in the working tree.\n"
-		    "Use 'git <command> -- <path>...' to specify paths that do not exist locally.",
+		die(_("%s: no such path in the working tree.\n"
+		      "Use 'git <command> -- <path>...' to specify paths that do not exist locally."),
 		    arg);
 	/*
 	 * Saying "'(icase)foo' does not exist in the index" when the
@@ -170,9 +170,9 @@ static void NORETURN die_verify_filename(const char *prefix,
 		maybe_die_on_misspelt_object_name(arg, prefix);
 
 	/* ... or fall back the most general message. */
-	die("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
-	    "Use '--' to separate paths from revisions, like this:\n"
-	    "'git <command> [<revision>...] -- [<file>...]'", arg);
+	die(_("ambiguous argument '%s': unknown revision or path not in the working tree.\n"
+	      "Use '--' to separate paths from revisions, like this:\n"
+	      "'git <command> [<revision>...] -- [<file>...]'"), arg);
 
 }
 
@@ -220,9 +220,9 @@ void verify_non_filename(const char *prefix, const char *arg)
 		return; /* flag */
 	if (!check_filename(prefix, arg))
 		return;
-	die("ambiguous argument '%s': both revision and filename\n"
-	    "Use '--' to separate paths from revisions, like this:\n"
-	    "'git <command> [<revision>...] -- [<file>...]'", arg);
+	die(_("ambiguous argument '%s': both revision and filename\n"
+	      "Use '--' to separate paths from revisions, like this:\n"
+	      "'git <command> [<revision>...] -- [<file>...]'"), arg);
 }
 
 int get_common_dir(struct strbuf *sb, const char *gitdir)
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 86c2ff2..79a0251 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -106,7 +106,7 @@ test_expect_success 'incorrect revision id' '
 	test_must_fail git rev-parse foobar:file.txt 2>error &&
 	grep "Invalid object name '"'"'foobar'"'"'." error &&
 	test_must_fail git rev-parse foobar 2> error &&
-	grep "unknown revision or path not in the working tree." error
+	test_i18ngrep "unknown revision or path not in the working tree." error
 '
 
 test_expect_success 'incorrect file in sha1:path' '
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index d8f23f4..001343e 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -18,7 +18,7 @@ test_expect_success '"git log :/" should not be ambiguous' '
 test_expect_success '"git log :/a" should be ambiguous (applied both rev and worktree)' '
 	: >a &&
 	test_must_fail git log :/a 2>error &&
-	grep ambiguous error
+	test_i18ngrep ambiguous error
 '
 
 test_expect_success '"git log :/a -- " should not be ambiguous' '
@@ -31,7 +31,7 @@ test_expect_success '"git log -- :/a" should not be ambiguous' '
 
 test_expect_success '"git log :" should be ambiguous' '
 	test_must_fail git log : 2>error &&
-	grep ambiguous error
+	test_i18ngrep ambiguous error
 '
 
 test_expect_success 'git log -- :' '
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 61beff6..45e44ca 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -211,7 +211,7 @@ test_expect_success 'fail if the index has unresolved entries' '
 	test -n "$(git ls-files -u)" &&
 	cp file expected &&
 	test_must_fail git pull . second 2>err &&
-	test_i18ngrep "pull is not possible because you have unmerged files" err &&
+	test_i18ngrep "Pulling is not possible because you have unmerged files." err &&
 	test_cmp expected file &&
 	git add file &&
 	test -z "$(git ls-files -u)" &&
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index f6f6c92..b1c7919 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -31,14 +31,10 @@ test_expect_success 'autocorrect showing candidates' '
 	git config help.autocorrect 0 &&
 
 	test_must_fail git lfg 2>actual &&
-	sed -e "1,/^Did you mean this/d" actual |
-	sed -e "/GETTEXT POISON/d" actual |
-	grep lgf &&
+	grep "^	lgf" actual &&
 
 	test_must_fail git distimdist 2>actual &&
-	sed -e "1,/^Did you mean this/d" actual |
-	sed -e "/GETTEXT POISON/d" actual |
-	grep distimdistim
+	grep "^	distimdistim" actual
 '
 
 test_expect_success 'autocorrect running commands' '
---- >8 ----

-- 
2.7.3
