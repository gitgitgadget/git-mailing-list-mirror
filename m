From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: [PATCH v4 00/38] i18n and test updates
Date: Tue,  7 Jun 2016 11:51:59 +0000
Message-ID: <1465300357-7557-1-git-send-email-vascomalmeida@sapo.pt>
Cc: Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 07 13:56:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAFcE-0000Uj-Np
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 13:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754417AbcFGLxc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 07:53:32 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:60783 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753394AbcFGLx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 07:53:29 -0400
Received: (qmail 26483 invoked from network); 7 Jun 2016 11:53:26 -0000
Received: (qmail 8066 invoked from network); 7 Jun 2016 11:53:26 -0000
Received: from unknown (HELO localhost.localdomain) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 7 Jun 2016 11:53:24 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Mailer: git-send-email 2.7.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296664>

Marks several messages for translation and updates tests to pass under
GETTEXT_POISON. Some tests were updated to fit previous i18n marks, others
were updated to fit marks made by these patches. Patches that only touch
test file refer to marks done in commits previous to these ones.

Depends on commit fe17fc0 ("t2300: run git-sh-setup in an environment that
better mimics the real life", 2016-06-01) in 'next' branch to pass that
test.

Drop "[PATCH v3 24/39] i18n: bisect: enable l10n of bisect terms in" from
previous re-roll.

Previous discussion:
http://thread.gmane.org/gmane.comp.version-control.git/296106

Interdiff v3 v4 included bellow.

Vasco Almeida (38):
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
 bisect.c                              |  56 ++++---
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
 config.c                              | 101 ++++++++++--
 git-bisect.sh                         |   8 +-
 git-merge-octopus.sh                  |  23 ++-
 git-rebase--interactive.sh            | 290 ++++++++++++++++++++--------------
 git-rebase.sh                         |   5 +-
 git-sh-i18n.sh                        |  18 +++
 git-sh-setup.sh                       |  63 ++++++--
 git-stash.sh                          |   1 -
 git-submodule.sh                      |  23 +--
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
 62 files changed, 576 insertions(+), 374 deletions(-)

---- >8 ----
diff --git a/bisect.c b/bisect.c
index 293d7ec..a8713a8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -23,15 +23,6 @@ static const char *argv_show_branch[] = {"show-branch", NULL, NULL};
 static const char *term_bad;
 static const char *term_good;
 
-enum term { BAD, GOOD, OLD, NEW };
-static const char *term_names[] = {
-/* TRANSLATORS: in bisect.c source code file, the following terms are
-   used to describe a "bad commit", "good commit", "new revision", etc.
-   Please, if you can, check the source when you are not sure if a %s
-   would be replaced by one of the following terms. */
-	N_("bad"), N_("good"), N_("old"), N_("new"),  NULL
-};
-
 /* Remember to update object flag allocation in object.h */
 #define COUNTED		(1u<<16)
 
@@ -734,12 +725,12 @@ static void handle_bad_merge_base(void)
 	if (is_expected_rev(current_bad_oid)) {
 		char *bad_hex = oid_to_hex(current_bad_oid);
 		char *good_hex = join_sha1_array_hex(&good_revs, ' ');
-		if (!strcmp(term_bad, term_names[BAD]) && !strcmp(term_good, term_names[GOOD])) {
+		if (!strcmp(term_bad, "bad") && !strcmp(term_good, "good")) {
 			fprintf(stderr, _("The merge base %s is bad.\n"
 				"This means the bug has been fixed "
 				"between %s and [%s].\n"),
 				bad_hex, bad_hex, good_hex);
-		} else if (!strcmp(term_bad, term_names[NEW]) && !strcmp(term_good, term_names[OLD])) {
+		} else if (!strcmp(term_bad, "new") && !strcmp(term_good, "old")) {
 			fprintf(stderr, _("The merge base %s is new.\n"
 				"The property has changed "
 				"between %s and [%s].\n"),
@@ -748,7 +739,7 @@ static void handle_bad_merge_base(void)
 			fprintf(stderr, _("The merge base %s is %s.\n"
 				"This means the first '%s' commit is "
 				"between %s and [%s].\n"),
-				bad_hex, _(term_bad), _(term_good), bad_hex, good_hex);
+				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
 		exit(3);
 	}
@@ -756,7 +747,7 @@ static void handle_bad_merge_base(void)
 	fprintf(stderr, _("Some %s revs are not ancestor of the %s rev.\n"
 		"git bisect cannot work properly in this case.\n"
 		"Maybe you mistook %s and %s revs?\n"),
-		_(term_good), _(term_bad), _(term_good), _(term_bad));
+		term_good, term_bad, term_good, term_bad);
 	exit(1);
 }
 
@@ -771,7 +762,7 @@ static void handle_skipped_merge_base(const unsigned char *mb)
 		"So we cannot be sure the first %s commit is "
 		"between %s and %s.\n"
 		"We continue anyway."),
-		bad_hex, good_hex, _(term_bad), mb_hex, bad_hex);
+		bad_hex, good_hex, term_bad, mb_hex, bad_hex);
 	free(good_hex);
 }
 
@@ -852,7 +843,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	int fd;
 
 	if (!current_bad_oid)
-		die(_("a %s revision is needed"), _(term_bad));
+		die(_("a %s revision is needed"), term_bad);
 
 	/* Check if file BISECT_ANCESTORS_OK exists. */
 	if (!stat(filename, &st) && S_ISREG(st.st_mode))
@@ -915,8 +906,8 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 
 	if (!fp) {
 		if (errno == ENOENT) {
-			*read_bad = term_names[BAD];
-			*read_good = term_names[GOOD];
+			*read_bad = "bad";
+			*read_good = "good";
 			return;
 		} else {
 			die_errno(_("could not read file '%s'"), filename);
@@ -971,8 +962,8 @@ int bisect_next_all(const char *prefix, int no_checkout)
 
 		printf(_("%s was both %s and %s\n"),
 		       oid_to_hex(current_bad_oid),
-		       _(term_good),
-		       _(term_bad));
+		       term_good,
+		       term_bad);
 		exit(1);
 	}
 
diff --git a/config.c b/config.c
index b08a418..e86f0aa 100644
--- a/config.c
+++ b/config.c
@@ -417,7 +417,8 @@ static int git_parse_source(config_fn_t fn, void *data)
 	int comment = 0;
 	int baselen = 0;
 	struct strbuf *var = &cf->var;
-	char error_msg[128];
+	int error_return = 0;
+	char *error_msg = NULL;
 
 	/* U+FEFF Byte Order Mark in UTF8 */
 	const char *bomptr = utf8_bom;
@@ -475,35 +476,33 @@ static int git_parse_source(config_fn_t fn, void *data)
 
 	switch (cf->origin_type) {
 	case CFG_BLOB:
-		xsnprintf(error_msg, sizeof(error_msg),
-			  _("bad config line %d in blob %s"),
-			  cf->linenr, cf->name);
+		error_msg = xstrfmt(_("bad config line %d in blob %s"),
+				      cf->linenr, cf->name);
 		break;
 	case CFG_FILE:
-		xsnprintf(error_msg, sizeof(error_msg),
-			  _("bad config line %d in file %s"),
-			  cf->linenr, cf->name);
+		error_msg = xstrfmt(_("bad config line %d in file %s"),
+				      cf->linenr, cf->name);
 		break;
 	case CFG_STDIN:
-		xsnprintf(error_msg, sizeof(error_msg),
-			  _("bad config line %d in standard input"),
-			  cf->linenr);
+		error_msg = xstrfmt(_("bad config line %d in standard input"),
+				      cf->linenr);
 		break;
 	case CFG_SUBMODULE_BLOB:
-		xsnprintf(error_msg, sizeof(error_msg),
-			  _("bad config line %d in submodule-blob %s"),
-			  cf->linenr, cf->name);
+		error_msg = xstrfmt(_("bad config line %d in submodule-blob %s"),
+				       cf->linenr, cf->name);
 		break;
 	default:
-		xsnprintf(error_msg, sizeof(error_msg),
-			  _("bad config line %d in %s"),
-			  cf->linenr, cf->name);
+		error_msg = xstrfmt(_("bad config line %d in %s"),
+				      cf->linenr, cf->name);
 	}
 
 	if (cf->die_on_error)
 		die(error_msg);
 	else
-		return error(error_msg);
+		error_return =  error(error_msg);
+
+	free(error_msg);
+	return error_return;
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
diff --git a/git-bisect.sh b/git-bisect.sh
index c9acab6..ae3cb01 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -33,7 +33,6 @@ Please use "git help bisect" to get the full man page.'
 
 OPTIONS_SPEC=
 . git-sh-setup
-. git-sh-i18n
 
 _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
 _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
diff --git a/git-merge-octopus.sh b/git-merge-octopus.sh
index d79fc84..308eafd 100755
--- a/git-merge-octopus.sh
+++ b/git-merge-octopus.sh
@@ -6,7 +6,6 @@
 #
 
 . git-sh-setup
-. git-sh-i18n
 
 LF='
 '
diff --git a/git-rebase.sh b/git-rebase.sh
index 9ba21ab..04f6e44 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -45,7 +45,6 @@ skip!              skip current patch and continue
 edit-todo!         edit the todo list during an interactive rebase
 "
 . git-sh-setup
-. git-sh-i18n
 set_reflog_action rebase
 require_work_tree_exists
 cd_to_toplevel
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 61a3d95..2eda134 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -2,9 +2,8 @@
 # to set up some variables pointing at the normal git directories and
 # a few helper shell functions.
 
-# Some shell scripts source git-sh-setup (i.e. this scriplet) but
-# don't source git-sh-i18n which is needed here for gettext support.
-. "$(git --exec-path)"/git-sh-i18n
+# Source git-sh-i18n for gettext support.
+. git-sh-i18n
 
 # Having this variable in your environment would break scripts because
 # you would cause "cd" to be taken to unexpected places.  If you
@@ -87,16 +86,16 @@ if test -n "$OPTIONS_SPEC"; then
 else
 	dashless=$(basename -- "$0" | sed -e 's/-/ /')
 	usage() {
-		die "$(gettext usage:) $dashless $USAGE"
+		die "$(eval_gettext "usage: \$dashless \$USAGE")"
 	}
 
 	if [ -z "$LONG_USAGE" ]
 	then
-		LONG_USAGE="$(gettext usage:) $dashless $USAGE"
+		LONG_USAGE="$(eval_gettext "usage: \$dashless \$USAGE")"
 	else
-		LONG_USAGE="$(gettext usage:) $dashless $USAGE
+		LONG_USAGE="$(eval_gettext "usage: \$dashless \$USAGE
 
-$LONG_USAGE"
+$LONG_USAGE")"
 	fi
 
 	case "$1" in
diff --git a/git-stash.sh b/git-stash.sh
index c7509e8..22fb8bc 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -15,7 +15,6 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 START_DIR=$(pwd)
 . git-sh-setup
-. git-sh-i18n
 require_work_tree
 cd_to_toplevel
 
diff --git a/git-submodule.sh b/git-submodule.sh
index f6e0c28..1ff2f3a 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -16,7 +16,6 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
 OPTIONS_SPEC=
 SUBDIRECTORY_OK=Yes
 . git-sh-setup
-. git-sh-i18n
 . git-parse-remote
 require_work_tree
 wt_prefix=$(git rev-parse --show-prefix)
---- >8 ----

-- 
2.7.3
