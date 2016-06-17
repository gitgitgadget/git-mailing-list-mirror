Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E811FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 20:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbcFQUXq (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 16:23:46 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:35270 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752599AbcFQUXp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 16:23:45 -0400
Received: (qmail 1946 invoked from network); 17 Jun 2016 20:23:43 -0000
Received: (qmail 28726 invoked from network); 17 Jun 2016 20:23:43 -0000
Received: from unknown (HELO linux-omuo.lan) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by ptmail-mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <git@vger.kernel.org>; 17 Jun 2016 20:23:37 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
From:	Vasco Almeida <vascomalmeida@sapo.pt>
To:	git@vger.kernel.org
Cc:	Vasco Almeida <vascomalmeida@sapo.pt>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 00/38] i18n and test updates
Date:	Fri, 17 Jun 2016 20:20:49 +0000
Message-Id: <1466194887-18236-1-git-send-email-vascomalmeida@sapo.pt>
X-Mailer: git-send-email 2.6.6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Marks several messages for translation and updates tests to pass under
GETTEXT_POISON. Some tests were updated to fit previous i18n marks, others
were updated to fit marks made by these patches. Patches that only touch
test file refer to marks done in commits previous to these ones.

"[PATCH v5 34/38] i18n: init-db: join message pieces" now updates Icelandic
translation to pass test t0204-gettext-reencode-sanity.sh.
That failure went unnoticed because my system did not have the Icelandic
locale installed at that time.
I have only tested with UTF-8 but expect to also pass the ISO-8859-1 locale
since the translated strings are the same.

In order to pass the tests, this series depended upon commit fe17fc0
("t2300: run git-sh-setup in an environment that better mimics the real
life", 2016-06-01) which was previously on 'next' branch, but now it has
graduated to 'master'.

Interdiff included below.

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
 po/is.po                              |  46 +++---
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
 63 files changed, 604 insertions(+), 392 deletions(-)

---- >8 ----
diff --git a/po/is.po b/po/is.po
index 8692a8b..b8b34fd 100644
--- a/po/is.po
+++ b/po/is.po
@@ -7,14 +7,15 @@ msgid ""
 msgstr ""
 "Project-Id-Version: Git\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2010-09-20 14:44+0000\n"
-"PO-Revision-Date: 2010-06-05 19:06 +0000\n"
-"Last-Translator: Ævar Arnfjörð Bjarmason <avarab@gmail.com>\n"
+"POT-Creation-Date: 2016-06-17 18:55+0000\n"
+"PO-Revision-Date: 2016-06-17 19:17+0000\n"
+"Last-Translator: Vasco Almeida <vascomalmeida@sapo.pt>\n"
 "Language-Team: Git Mailing List <git@vger.kernel.org>\n"
 "Language: is\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
+"X-Generator: Poedit 1.8.5\n"
 
 #. TRANSLATORS: This is a test. You don't need to translate it.
 #: t/t0200/test.c:5
@@ -72,22 +73,31 @@ msgstr "TILRAUN: Perl tilraunastrengur"
 msgid "TEST: A Perl test variable %s"
 msgstr "TILRAUN: Perl tilraunastrengur með breytunni %s"
 
-#. TRANSLATORS: The first '%s' is either "Reinitialized
-#. existing" or "Initialized empty", the second " shared" or
-#. "", and the last '%s%s' is the verbatim directory name.
-#: builtin/init-db.c:355
+#: builtin/init-db.c:402
 #, c-format
-msgid "%s%s Git repository in %s%s\n"
-msgstr "%s%s Git lind í %s%s\n"
+msgid "Reinitialized existing shared Git repository in %s%s\n"
+msgstr "Endurgerði Git lind í %s%s\n"
 
-#: builtin/init-db.c:356
-msgid "Reinitialized existing"
-msgstr "Endurgerði"
+#: builtin/init-db.c:403
+#, c-format
+msgid "Reinitialized existing Git repository in %s%s\n"
+msgstr "Endurgerði Git lind í %s%s\n"
+
+#: builtin/init-db.c:407
+#, c-format
+msgid "Initialized empty shared Git repository in %s%s\n"
+msgstr "Bjó til tóma sameiginlega Git lind í %s%s\n"
+
+#: builtin/init-db.c:408
+#, c-format
+msgid "Initialized empty Git repository in %s%s\n"
+msgstr "Bjó til tóma Git lind í %s%s\n"
+
+#~ msgid "Reinitialized existing"
+#~ msgstr "Endurgerði"
 
-#: builtin/init-db.c:356
-msgid "Initialized empty"
-msgstr "Bjó til tóma"
+#~ msgid "Initialized empty"
+#~ msgstr "Bjó til tóma"
 
-#: builtin/init-db.c:357
-msgid " shared"
-msgstr " sameiginlega"
+#~ msgid " shared"
+#~ msgstr " sameiginlega"
---- >8 ----

-- 
2.6.6

