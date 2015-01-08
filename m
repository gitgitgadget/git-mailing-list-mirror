From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] standardize usage info string format
Date: Wed,  7 Jan 2015 23:28:21 -0700
Message-ID: <1420698501-15393-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
	Matthieu.Moy@imag.fr, krh@redhat.com, vmiklos@frugalware.org,
	madcoder@debian.org, barra_cuda@katamail.com, dpotapov@gmail.com,
	git@adamspiers.org, sunshine@sunshineco.com, mhagger@alum.mit.edu,
	jrnieder@gmail.com, barkalow@iabervon.org, stefanbeller@gmail.com,
	shawn.bohrer@gmail.com, felipe.contreras@gmail.com,
	rhansen@bbn.com, pasky@ucw.cz, s-beyer@gmx.net,
	c.shoemaker@cox.net, grnch@gmx.net, jbowes@dangerouslyinc.com,
	l.s.r@web.de, philipoakley@iee.org, michal.kiedrowicz@gmail.com,
	cmn@elego.de, artagnon@gmail.com, rctay89@gmail.com,
	stefan.naewe@gmail.com, pbonzini@redhat.com, aspotashev@gmail.com,
	johan@herland.net, luksan@gmail.com, bebarino@gmail.com,
	Johannes.Schindelin@gmx.de, kevin@bracey.fi, jasampler@gmail.com,
	brad.king@kitware.com, git@drmicha.warpmail.net, peff@peff.net,
	chriscool@tuxfamily.org, a
X-From: git-owner@vger.kernel.org Thu Jan 08 07:29:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y96aG-0006AG-Fa
	for gcvg-git-2@plane.gmane.org; Thu, 08 Jan 2015 07:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752047AbbAHG2f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2015 01:28:35 -0500
Received: from mail-qc0-f175.google.com ([209.85.216.175]:58266 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbAHG2d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2015 01:28:33 -0500
Received: by mail-qc0-f175.google.com with SMTP id p6so623553qcv.6
        for <git@vger.kernel.org>; Wed, 07 Jan 2015 22:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=EDWcksahBI0Gj0hJ1BsYf0/VY1S4vi5hBqL6XqDEWX8=;
        b=dVnpkFkmZW/NOw3oN+ySFlxWT4Fm7FVX4sHPPnfdH+k6DOl55p3z3QKLUpHhjf1xhB
         lZGmNAegeGRYJT3iOnyykynxHAqfdtYsQX6ivc4kbfWJHxueNJ+EmvEZMi87GI1LhEvZ
         p2Ve2pt0NhIyHTou2Tfg7H0aTRdE/5ruBQ3R7clRqQ0KYAhRGNWqZMXUfHCRj61alhXo
         82hNfMiVDVtU8yL2q8zD3JCB8Ap68IY/AjWT0FluA05DU9Soww+fqtCy9VB4cx0Y4CDg
         BxCoPa0bjQtpqxnYgz3dvzh9cvQYByDxBsy9S195Qpl+5kyT92JCaW4iV61bjwPB5BXY
         Ih0w==
X-Received: by 10.140.37.115 with SMTP id q106mr11628960qgq.38.1420698512046;
        Wed, 07 Jan 2015 22:28:32 -0800 (PST)
Received: from alex-wolverine.lan (c-98-202-141-117.hsd1.ut.comcast.net. [98.202.141.117])
        by mx.google.com with ESMTPSA id y2sm3303663qaj.3.2015.01.07.22.28.27
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Jan 2015 22:28:31 -0800 (PST)
X-Mailer: git-send-email 2.2.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262184>

This patch puts the usage info strings that were not already in docopt-
like format into docopt-like format, which will be a litle easier for
end users and a lot easier for translators. Changes include:

- Placing angle brackets around fill-in-the-blank parameters
- Putting dashes in multiword parameter names
- Adding spaces to [-f|--foobar] to make [-f | --foobar]
- Replacing <foobar>* with [<foobar>...]

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 advice.c                   |  2 +-
 archive.c                  |  4 ++--
 builtin/add.c              |  2 +-
 builtin/apply.c            |  2 +-
 builtin/blame.c            |  4 ++--
 builtin/branch.c           |  8 ++++----
 builtin/cat-file.c         |  4 ++--
 builtin/check-attr.c       |  4 ++--
 builtin/check-ignore.c     |  4 ++--
 builtin/check-mailmap.c    |  2 +-
 builtin/check-ref-format.c |  2 +-
 builtin/checkout-index.c   |  2 +-
 builtin/checkout.c         |  8 ++++----
 builtin/clone.c            |  2 +-
 builtin/column.c           |  2 +-
 builtin/commit.c           |  4 ++--
 builtin/config.c           |  2 +-
 builtin/describe.c         |  4 ++--
 builtin/diff-files.c       |  2 +-
 builtin/diff-index.c       |  2 +-
 builtin/diff-tree.c        |  2 +-
 builtin/fetch-pack.c       |  2 +-
 builtin/fmt-merge-msg.c    |  2 +-
 builtin/for-each-ref.c     |  2 +-
 builtin/fsck.c             |  2 +-
 builtin/gc.c               |  2 +-
 builtin/grep.c             |  2 +-
 builtin/hash-object.c      |  2 +-
 builtin/help.c             |  2 +-
 builtin/init-db.c          |  2 +-
 builtin/log.c              |  6 +++---
 builtin/ls-files.c         |  2 +-
 builtin/ls-remote.c        |  2 +-
 builtin/mailinfo.c         |  2 +-
 builtin/merge-base.c       |  4 ++--
 builtin/merge-file.c       |  4 ++--
 builtin/merge-index.c      |  2 +-
 builtin/merge.c            |  4 ++--
 builtin/mv.c               |  2 +-
 builtin/name-rev.c         |  6 +++---
 builtin/notes.c            | 24 ++++++++++++------------
 builtin/pack-redundant.c   |  2 +-
 builtin/pack-refs.c        |  2 +-
 builtin/prune-packed.c     |  2 +-
 builtin/remote.c           |  4 ++--
 builtin/repack.c           |  2 +-
 builtin/rerere.c           |  2 +-
 builtin/rev-parse.c        |  6 +++---
 builtin/revert.c           |  4 ++--
 builtin/rm.c               |  2 +-
 builtin/shortlog.c         |  2 +-
 builtin/show-branch.c      |  4 ++--
 builtin/show-ref.c         |  2 +-
 builtin/symbolic-ref.c     |  4 ++--
 builtin/tag.c              |  4 ++--
 builtin/update-index.c     |  2 +-
 builtin/update-ref.c       |  6 +++---
 builtin/verify-commit.c    |  2 +-
 builtin/verify-pack.c      |  2 +-
 builtin/verify-tag.c       |  2 +-
 credential-store.c         |  2 +-
 git-bisect.sh              |  2 +-
 git.c                      |  2 +-
 63 files changed, 103 insertions(+), 103 deletions(-)

diff --git a/advice.c b/advice.c
index 3b8bf3c..575bec2 100644
--- a/advice.c
+++ b/advice.c
@@ -105,7 +105,7 @@ void detach_advice(const char *new_name)
 	"state without impacting any branches by performing another checkout.\n\n"
 	"If you want to create a new branch to retain commits you create, you may\n"
 	"do so (now or later) by using -b with the checkout command again. Example:\n\n"
-	"  git checkout -b new_branch_name\n\n";
+	"  git checkout -b <new-branch-name>\n\n";
 
 	fprintf(stderr, fmt, new_name);
 }
diff --git a/archive.c b/archive.c
index 9e30246..96057ed 100644
--- a/archive.c
+++ b/archive.c
@@ -8,9 +8,9 @@
 #include "dir.h"
 
 static char const * const archive_usage[] = {
-	N_("git archive [options] <tree-ish> [<path>...]"),
+	N_("git archive [<options>] <tree-ish> [<path>...]"),
 	N_("git archive --list"),
-	N_("git archive --remote <repo> [--exec <cmd>] [options] <tree-ish> [<path>...]"),
+	N_("git archive --remote <repo> [--exec <cmd>] [<options>] <tree-ish> [<path>...]"),
 	N_("git archive --remote <repo> [--exec <cmd>] --list"),
 	NULL
 };
diff --git a/builtin/add.c b/builtin/add.c
index 1074e32..3390933 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -19,7 +19,7 @@
 #include "argv-array.h"
 
 static const char * const builtin_add_usage[] = {
-	N_("git add [options] [--] <pathspec>..."),
+	N_("git add [<options>] [--] <pathspec>..."),
 	NULL
 };
 static int patch_interactive, add_interactive, edit_interactive;
diff --git a/builtin/apply.c b/builtin/apply.c
index 0aad912..7cd9a3b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -55,7 +55,7 @@ static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned int p_context = UINT_MAX;
 static const char * const apply_usage[] = {
-	N_("git apply [options] [<patch>...]"),
+	N_("git apply [<options>] [<patch>...]"),
 	NULL
 };
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 303e217..f0fac65 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -27,12 +27,12 @@
 #include "line-range.h"
 #include "line-log.h"
 
-static char blame_usage[] = N_("git blame [options] [rev-opts] [rev] [--] file");
+static char blame_usage[] = N_("git blame [<options>] [<rev-opts>] [<rev>] [--] file");
 
 static const char *blame_opt_usage[] = {
 	blame_usage,
 	"",
-	N_("[rev-opts] are documented in git-rev-list(1)"),
+	N_("<rev-opts> are documented in git-rev-list(1)"),
 	NULL
 };
 
diff --git a/builtin/branch.c b/builtin/branch.c
index dc6f0b2..d340321 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -21,10 +21,10 @@
 #include "wt-status.h"
 
 static const char * const builtin_branch_usage[] = {
-	N_("git branch [options] [-r | -a] [--merged | --no-merged]"),
-	N_("git branch [options] [-l] [-f] <branchname> [<start-point>]"),
-	N_("git branch [options] [-r] (-d | -D) <branchname>..."),
-	N_("git branch [options] (-m | -M) [<oldbranch>] <newbranch>"),
+	N_("git branch [<options>] [-r | -a] [--merged | --no-merged]"),
+	N_("git branch [<options>] [-l] [-f] <branchname> [<start-point>]"),
+	N_("git branch [<options>] [-r] (-d | -D) <branchname>..."),
+	N_("git branch [<options>] (-m | -M) [<oldbranch>] <newbranch>"),
 	NULL
 };
 
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index f8d8129..c2e4e53 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -329,8 +329,8 @@ static int batch_objects(struct batch_options *opt)
 }
 
 static const char * const cat_file_usage[] = {
-	N_("git cat-file (-t|-s|-e|-p|<type>|--textconv) <object>"),
-	N_("git cat-file (--batch|--batch-check) < <list_of_objects>"),
+	N_("git cat-file (-t | -s | -e | -p | <type> | --textconv) <object>"),
+	N_("git cat-file (--batch | --batch-check) < <list-of-objects>"),
 	NULL
 };
 
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 5600ec3..21d2bed 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -8,8 +8,8 @@ static int all_attrs;
 static int cached_attrs;
 static int stdin_paths;
 static const char * const check_attr_usage[] = {
-N_("git check-attr [-a | --all | attr...] [--] pathname..."),
-N_("git check-attr --stdin [-z] [-a | --all | attr...] < <list-of-paths>"),
+N_("git check-attr [-a | --all | <attr>...] [--] <pathname>..."),
+N_("git check-attr --stdin [-z] [-a | --all | <attr>...] < <list-of-paths>"),
 NULL
 };
 
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 594463a..dc8d97c 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -7,8 +7,8 @@
 
 static int quiet, verbose, stdin_paths, show_non_matching, no_index;
 static const char * const check_ignore_usage[] = {
-"git check-ignore [options] pathname...",
-"git check-ignore [options] --stdin < <list-of-paths>",
+"git check-ignore [<options>] <pathname>...",
+"git check-ignore [<options>] --stdin < <list-of-paths>",
 NULL
 };
 
diff --git a/builtin/check-mailmap.c b/builtin/check-mailmap.c
index 8f4d809..eaaea54 100644
--- a/builtin/check-mailmap.c
+++ b/builtin/check-mailmap.c
@@ -5,7 +5,7 @@
 
 static int use_stdin;
 static const char * const check_mailmap_usage[] = {
-N_("git check-mailmap [options] <contact>..."),
+N_("git check-mailmap [<options>] <contact>..."),
 NULL
 };
 
diff --git a/builtin/check-ref-format.c b/builtin/check-ref-format.c
index 28a7320..fd915d5 100644
--- a/builtin/check-ref-format.c
+++ b/builtin/check-ref-format.c
@@ -8,7 +8,7 @@
 #include "strbuf.h"
 
 static const char builtin_check_ref_format_usage[] =
-"git check-ref-format [--normalize] [options] <refname>\n"
+"git check-ref-format [--normalize] [<options>] <refname>\n"
 "   or: git check-ref-format --branch <branchname-shorthand>";
 
 /*
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 383dccf..6930aad 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -123,7 +123,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 }
 
 static const char * const builtin_checkout_index_usage[] = {
-	N_("git checkout-index [options] [--] [<file>...]"),
+	N_("git checkout-index [<options>] [--] [<file>...]"),
 	NULL
 };
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 52d6cbb..3e141fc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -22,8 +22,8 @@
 #include "argv-array.h"
 
 static const char * const checkout_usage[] = {
-	N_("git checkout [options] <branch>"),
-	N_("git checkout [options] [<branch>] -- <file>..."),
+	N_("git checkout [<options>] <branch>"),
+	N_("git checkout [<options>] [<branch>] -- <file>..."),
 	NULL,
 };
 
@@ -746,7 +746,7 @@ static void suggest_reattach(struct commit *commit, struct rev_info *revs)
 			_(
 			"If you want to keep them by creating a new branch, "
 			"this may be a good time\nto do so with:\n\n"
-			" git branch new_branch_name %s\n\n"),
+			" git branch <new-branch-name> %s\n\n"),
 			find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
 }
 
@@ -1127,7 +1127,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
-				N_("second guess 'git checkout no-such-branch'")),
+				N_("second guess 'git checkout <no-such-branch>'")),
 		OPT_END(),
 	};
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 316c75d..9572467 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -34,7 +34,7 @@
  *
  */
 static const char * const builtin_clone_usage[] = {
-	N_("git clone [options] [--] <repo> [<dir>]"),
+	N_("git clone [<options>] [--] <repo> [<dir>]"),
 	NULL
 };
 
diff --git a/builtin/column.c b/builtin/column.c
index 7581852..449413c 100644
--- a/builtin/column.c
+++ b/builtin/column.c
@@ -6,7 +6,7 @@
 #include "column.h"
 
 static const char * const builtin_column_usage[] = {
-	N_("git column [options]"),
+	N_("git column [<options>]"),
 	NULL
 };
 static unsigned int colopts;
diff --git a/builtin/commit.c b/builtin/commit.c
index 7d90c35..6716e11 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -34,12 +34,12 @@
 #include "mailmap.h"
 
 static const char * const builtin_commit_usage[] = {
-	N_("git commit [options] [--] <pathspec>..."),
+	N_("git commit [<options>] [--] <pathspec>..."),
 	NULL
 };
 
 static const char * const builtin_status_usage[] = {
-	N_("git status [options] [--] <pathspec>..."),
+	N_("git status [<options>] [--] <pathspec>..."),
 	NULL
 };
 
diff --git a/builtin/config.c b/builtin/config.c
index 15a7bea..d32c532 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -5,7 +5,7 @@
 #include "urlmatch.h"
 
 static const char *const builtin_config_usage[] = {
-	N_("git config [options]"),
+	N_("git config [<options>]"),
 	NULL
 };
 
diff --git a/builtin/describe.c b/builtin/describe.c
index 9103193..e00a75b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -14,8 +14,8 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
-	N_("git describe [options] <commit-ish>*"),
-	N_("git describe [options] --dirty"),
+	N_("git describe [<options>] [<commit-ish>...]"),
+	N_("git describe [<options>] --dirty"),
 	NULL
 };
 
diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 9200069..1abeba6 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -11,7 +11,7 @@
 #include "submodule.h"
 
 static const char diff_files_usage[] =
-"git diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
+"git diff-files [-q] [-0/-1/2/3 | -c | --cc] [<common-diff-options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-index.c b/builtin/diff-index.c
index ce15b23..d979824 100644
--- a/builtin/diff-index.c
+++ b/builtin/diff-index.c
@@ -7,7 +7,7 @@
 
 static const char diff_cache_usage[] =
 "git diff-index [-m] [--cached] "
-"[<common diff options>] <tree-ish> [<path>...]"
+"[<common-diff-options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_index(int argc, const char **argv, const char *prefix)
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 1c4ad62..12b683d 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -82,7 +82,7 @@ static int diff_tree_stdin(char *line)
 
 static const char diff_tree_usage[] =
 "git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"[<common-diff-options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "  -r            diff recursively\n"
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 1262b40..4a6b340 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -6,7 +6,7 @@
 #include "sha1-array.h"
 
 static const char fetch_pack_usage[] =
-"git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] "
+"git fetch-pack [--all] [--stdin] [--quiet | -q] [--keep | -k] [--thin] "
 "[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
 "[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]";
 
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index af7919e..1d962dc 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -10,7 +10,7 @@
 #include "gpg-interface.h"
 
 static const char * const fmt_merge_msg_usage[] = {
-	N_("git fmt-merge-msg [-m <message>] [--log[=<n>]|--no-log] [--file <file>]"),
+	N_("git fmt-merge-msg [-m <message>] [--log[=<n>] | --no-log] [--file <file>]"),
 	NULL
 };
 
diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index f3ce004..c97368a 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -1054,7 +1054,7 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 }
 
 static char const * const for_each_ref_usage[] = {
-	N_("git for-each-ref [options] [<pattern>]"),
+	N_("git for-each-ref [<options>] [<pattern>]"),
 	NULL
 };
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index a27515a..0c75786 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -600,7 +600,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 }
 
 static char const * const fsck_usage[] = {
-	N_("git fsck [options] [<object>...]"),
+	N_("git fsck [<options>] [<object>...]"),
 	NULL
 };
 
diff --git a/builtin/gc.c b/builtin/gc.c
index 005adbe..5c634af 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -21,7 +21,7 @@
 #define FAILED_RUN "failed to run %s"
 
 static const char * const builtin_gc_usage[] = {
-	N_("git gc [options]"),
+	N_("git gc [<options>]"),
 	NULL
 };
 
diff --git a/builtin/grep.c b/builtin/grep.c
index 4063882..9262b73 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -20,7 +20,7 @@
 #include "pathspec.h"
 
 static char const * const grep_usage[] = {
-	N_("git grep [options] [-e] <pattern> [<rev>...] [[--] <path>...]"),
+	N_("git grep [<options>] [-e] <pattern> [<rev>...] [[--] <path>...]"),
 	NULL
 };
 
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 6158363..207b90c 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -79,7 +79,7 @@ static void hash_stdin_paths(const char *type, int no_filters, unsigned flags,
 int cmd_hash_object(int argc, const char **argv, const char *prefix)
 {
 	static const char * const hash_object_usage[] = {
-		N_("git hash-object [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin] [--] <file>..."),
+		N_("git hash-object [-t <type>] [-w] [--path=<file> | --no-filters] [--stdin] [--] <file>..."),
 		N_("git hash-object  --stdin-paths < <list-of-paths>"),
 		NULL
 	};
diff --git a/builtin/help.c b/builtin/help.c
index e78c135..6133fe4 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -49,7 +49,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [--all] [--guides] [--man|--web|--info] [command]"),
+	N_("git help [--all] [--guides] [--man | --web | --info] [<command>]"),
 	NULL
 };
 
diff --git a/builtin/init-db.c b/builtin/init-db.c
index 9966522..6723d39 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -472,7 +472,7 @@ static int shared_callback(const struct option *opt, const char *arg, int unset)
 }
 
 static const char *const init_db_usage[] = {
-	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [directory]"),
+	N_("git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]] [<directory>]"),
 	NULL
 };
 
diff --git a/builtin/log.c b/builtin/log.c
index f2a9f01..d65d96a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -38,8 +38,8 @@ static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
 static const char * const builtin_log_usage[] = {
-	N_("git log [<options>] [<revision range>] [[--] <path>...]\n")
-	N_("   or: git show [options] <object>..."),
+	N_("git log [<options>] [<revision-range>] [[--] <path>...]\n")
+	N_("   or: git show [<options>] <object>..."),
 	NULL
 };
 
@@ -1023,7 +1023,7 @@ static const char *set_outdir(const char *prefix, const char *output_directory)
 }
 
 static const char * const builtin_format_patch_usage[] = {
-	N_("git format-patch [options] [<since> | <revision range>]"),
+	N_("git format-patch [<options>] [<since> | <revision-range>]"),
 	NULL
 };
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 99cee20..914054d 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -398,7 +398,7 @@ int report_path_error(const char *ps_matched,
 }
 
 static const char * const ls_files_usage[] = {
-	N_("git ls-files [options] [<file>...]"),
+	N_("git ls-files [<options>] [<file>...]"),
 	NULL
 };
 
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index b2a4b92..4554dbc 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -5,7 +5,7 @@
 
 static const char ls_remote_usage[] =
 "git ls-remote [--heads] [--tags]  [-u <exec> | --upload-pack <exec>]\n"
-"                     [-q|--quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]";
+"                     [-q | --quiet] [--exit-code] [--get-url] [<repository> [<refs>...]]";
 
 /*
  * Is there one among the list of patterns that match the tail part
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index c8a47c1..999a525 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -1031,7 +1031,7 @@ static int git_mailinfo_config(const char *var, const char *value, void *unused)
 }
 
 static const char mailinfo_usage[] =
-	"git mailinfo [-k|-b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] msg patch < mail >info";
+	"git mailinfo [-k | -b] [-m | --message-id] [-u | --encoding=<encoding> | -n] [--scissors | --no-scissors] <msg> <patch> < mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index fdebef6..08a8217 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -26,8 +26,8 @@ static int show_merge_base(struct commit **rev, int rev_nr, int show_all)
 }
 
 static const char * const merge_base_usage[] = {
-	N_("git merge-base [-a|--all] <commit> <commit>..."),
-	N_("git merge-base [-a|--all] --octopus <commit>..."),
+	N_("git merge-base [-a | --all] <commit> <commit>..."),
+	N_("git merge-base [-a | --all] --octopus <commit>..."),
 	N_("git merge-base --independent <commit>..."),
 	N_("git merge-base --is-ancestor <commit> <commit>"),
 	N_("git merge-base --fork-point <ref> [<commit>]"),
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 844f84f..131edc2 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -5,7 +5,7 @@
 #include "parse-options.h"
 
 static const char *const merge_file_usage[] = {
-	N_("git merge-file [options] [-L name1 [-L orig [-L name2]]] file1 orig_file file2"),
+	N_("git merge-file [<options>] [-L <name1> [-L <orig> [-L <name2>]]] <file1> <orig-file> <file2>"),
 	NULL
 };
 
@@ -42,7 +42,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 			    N_("for conflicts, use this marker size")),
 		OPT__QUIET(&quiet, N_("do not warn about conflicts")),
 		OPT_CALLBACK('L', NULL, names, N_("name"),
-			     N_("set labels for file1/orig_file/file2"), &label_cb),
+			     N_("set labels for file1/orig-file/file2"), &label_cb),
 		OPT_END(),
 	};
 
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index b416d92..1a1eafa 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -75,7 +75,7 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
 	signal(SIGCHLD, SIG_DFL);
 
 	if (argc < 3)
-		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] <filename>*)");
+		usage("git merge-index [-o] [-q] <merge-program> (-a | [--] [<filename>...])");
 
 	read_cache();
 
diff --git a/builtin/merge.c b/builtin/merge.c
index 9effed7..5c2921c 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -42,8 +42,8 @@ struct strategy {
 };
 
 static const char * const builtin_merge_usage[] = {
-	N_("git merge [options] [<commit>...]"),
-	N_("git merge [options] <msg> HEAD <commit>"),
+	N_("git merge [<options>] [<commit>...]"),
+	N_("git merge [<options>] <msg> HEAD <commit>"),
 	N_("git merge --abort"),
 	NULL
 };
diff --git a/builtin/mv.c b/builtin/mv.c
index 563d05b..d1d4316 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -12,7 +12,7 @@
 #include "submodule.h"
 
 static const char * const builtin_mv_usage[] = {
-	N_("git mv [options] <source>... <destination>"),
+	N_("git mv [<options>] <source>... <destination>"),
 	NULL
 };
 
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 3c8f319..9736d44 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -252,9 +252,9 @@ static void show_name(const struct object *obj,
 }
 
 static char const * const name_rev_usage[] = {
-	N_("git name-rev [options] <commit>..."),
-	N_("git name-rev [options] --all"),
-	N_("git name-rev [options] --stdin"),
+	N_("git name-rev [<options>] <commit>..."),
+	N_("git name-rev [<options>] --all"),
+	N_("git name-rev [<options>] --stdin"),
 	NULL
 };
 
diff --git a/builtin/notes.c b/builtin/notes.c
index a9f37d0..63f95fc 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -21,18 +21,18 @@
 #include "notes-utils.h"
 
 static const char * const git_notes_usage[] = {
-	N_("git notes [--ref <notes_ref>] [list [<object>]]"),
-	N_("git notes [--ref <notes_ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
-	N_("git notes [--ref <notes_ref>] copy [-f] <from-object> <to-object>"),
-	N_("git notes [--ref <notes_ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
-	N_("git notes [--ref <notes_ref>] edit [--allow-empty] [<object>]"),
-	N_("git notes [--ref <notes_ref>] show [<object>]"),
-	N_("git notes [--ref <notes_ref>] merge [-v | -q] [-s <strategy> ] <notes_ref>"),
+	N_("git notes [--ref <notes-ref>] [list [<object>]]"),
+	N_("git notes [--ref <notes-ref>] add [-f] [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] copy [-f] <from-object> <to-object>"),
+	N_("git notes [--ref <notes-ref>] append [--allow-empty] [-m <msg> | -F <file> | (-c | -C) <object>] [<object>]"),
+	N_("git notes [--ref <notes-ref>] edit [--allow-empty] [<object>]"),
+	N_("git notes [--ref <notes-ref>] show [<object>]"),
+	N_("git notes [--ref <notes-ref>] merge [-v | -q] [-s <strategy>] <notes-ref>"),
 	N_("git notes merge --commit [-v | -q]"),
 	N_("git notes merge --abort [-v | -q]"),
-	N_("git notes [--ref <notes_ref>] remove [<object>...]"),
-	N_("git notes [--ref <notes_ref>] prune [-n | -v]"),
-	N_("git notes [--ref <notes_ref>] get-ref"),
+	N_("git notes [--ref <notes-ref>] remove [<object>...]"),
+	N_("git notes [--ref <notes-ref>] prune [-n | -v]"),
+	N_("git notes [--ref <notes-ref>] get-ref"),
 	NULL
 };
 
@@ -68,7 +68,7 @@ static const char * const git_notes_show_usage[] = {
 };
 
 static const char * const git_notes_merge_usage[] = {
-	N_("git notes merge [<options>] <notes_ref>"),
+	N_("git notes merge [<options>] <notes-ref>"),
 	N_("git notes merge --commit [<options>]"),
 	N_("git notes merge --abort [<options>]"),
 	NULL
@@ -951,7 +951,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	const char *override_notes_ref = NULL;
 	struct option options[] = {
 		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
-			   N_("use notes from <notes_ref>")),
+			   N_("use notes from <notes-ref>")),
 		OPT_END()
 	};
 
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 649c3aa..d0532f6 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -11,7 +11,7 @@
 #define BLKSIZE 512
 
 static const char pack_redundant_usage[] =
-"git pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filename> ...>";
+"git pack-redundant [--verbose] [--alt-odb] (--all | <filename.pack>...)";
 
 static int load_all_packs, verbose, alt_odb;
 
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index b20b1ec..39f9a55 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -3,7 +3,7 @@
 #include "refs.h"
 
 static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [options]"),
+	N_("git pack-refs [<options>]"),
 	NULL
 };
 
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index f24a2c2..7cf900e 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
 
 static const char * const prune_packed_usage[] = {
-	N_("git prune-packed [-n|--dry-run] [-q|--quiet]"),
+	N_("git prune-packed [-n | --dry-run] [-q | --quiet]"),
 	NULL
 };
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 46ecfd9..33ff7e0 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -10,10 +10,10 @@
 
 static const char * const builtin_remote_usage[] = {
 	N_("git remote [-v | --verbose]"),
-	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags|--no-tags] [--mirror=<fetch|push>] <name> <url>"),
+	N_("git remote add [-t <branch>] [-m <master>] [-f] [--tags | --no-tags] [--mirror=<fetch|push>] <name> <url>"),
 	N_("git remote rename <old> <new>"),
 	N_("git remote remove <name>"),
-	N_("git remote set-head <name> (-a | --auto | -d | --delete |<branch>)"),
+	N_("git remote set-head <name> (-a | --auto | -d | --delete | <branch>)"),
 	N_("git remote [-v | --verbose] show [-n] <name>"),
 	N_("git remote prune [-n | --dry-run] <name>"),
 	N_("git remote [-v | --verbose] update [-p | --prune] [(<group> | <remote>)...]"),
diff --git a/builtin/repack.c b/builtin/repack.c
index 3f852f3..28fbc70 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -14,7 +14,7 @@ static int write_bitmaps;
 static char *packdir, *packtmp;
 
 static const char *const git_repack_usage[] = {
-	N_("git repack [options]"),
+	N_("git repack [<options>]"),
 	NULL
 };
 
diff --git a/builtin/rerere.c b/builtin/rerere.c
index 98eb8c5..7afadd2 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -9,7 +9,7 @@
 #include "pathspec.h"
 
 static const char * const rerere_usage[] = {
-	N_("git rerere [clear | forget path... | status | remaining | diff | gc]"),
+	N_("git rerere [clear | forget <path>... | status | remaining | diff | gc]"),
 	NULL,
 };
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 95328b8..3626c61 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -358,7 +358,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 {
 	static int keep_dashdash = 0, stop_at_non_option = 0;
 	static char const * const parseopt_usage[] = {
-		N_("git rev-parse --parseopt [options] -- [<args>...]"),
+		N_("git rev-parse --parseopt [<options>] -- [<args>...]"),
 		NULL
 	};
 	static struct option parseopt_opts[] = {
@@ -496,9 +496,9 @@ static void die_no_single_rev(int quiet)
 }
 
 static const char builtin_rev_parse_usage[] =
-N_("git rev-parse --parseopt [options] -- [<args>...]\n"
+N_("git rev-parse --parseopt [<options>] -- [<args>...]\n"
    "   or: git rev-parse --sq-quote [<arg>...]\n"
-   "   or: git rev-parse [options] [<arg>...]\n"
+   "   or: git rev-parse [<options>] [<arg>...]\n"
    "\n"
    "Run \"git rev-parse --parseopt -h\" for more information on the first usage.");
 
diff --git a/builtin/revert.c b/builtin/revert.c
index f9ed5bd..56a2c36 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -19,13 +19,13 @@
  */
 
 static const char * const revert_usage[] = {
-	N_("git revert [options] <commit-ish>..."),
+	N_("git revert [<options>] <commit-ish>..."),
 	N_("git revert <subcommand>"),
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
-	N_("git cherry-pick [options] <commit-ish>..."),
+	N_("git cherry-pick [<options>] <commit-ish>..."),
 	N_("git cherry-pick <subcommand>"),
 	NULL
 };
diff --git a/builtin/rm.c b/builtin/rm.c
index d8a9c86..3304bff 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -14,7 +14,7 @@
 #include "pathspec.h"
 
 static const char * const builtin_rm_usage[] = {
-	N_("git rm [options] [--] <file>..."),
+	N_("git rm [<options>] [--] <file>..."),
 	NULL
 };
 
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 4b7e536..c0bab6a 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static char const * const shortlog_usage[] = {
-	N_("git shortlog [<options>] [<revision range>] [[--] [<path>...]]"),
+	N_("git shortlog [<options>] [<revision-range>] [[--] [<path>...]]"),
 	NULL
 };
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 270e39c..e9b37dc 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -6,8 +6,8 @@
 #include "parse-options.h"
 
 static const char* show_branch_usage[] = {
-    N_("git show-branch [-a|--all] [-r|--remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
-    N_("git show-branch (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]"),
+    N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order] [--current] [--color[=<when>] | --no-color] [--sparse] [--more=<n> | --list | --independent | --merge-base] [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
+    N_("git show-branch (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]"),
     NULL
 };
 
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 5ba1f30..afb1030 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -7,7 +7,7 @@
 #include "parse-options.h"
 
 static const char * const show_ref_usage[] = {
-	N_("git show-ref [-q|--quiet] [--verify] [--head] [-d|--dereference] [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [pattern*] "),
+	N_("git show-ref [-q | --quiet] [--verify] [--head] [-d | --dereference] [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags] [--heads] [--] [<pattern>...]"),
 	N_("git show-ref --exclude-existing[=pattern] < ref-list"),
 	NULL
 };
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index 29fb3f1..ce0fde7 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -4,8 +4,8 @@
 #include "parse-options.h"
 
 static const char * const git_symbolic_ref_usage[] = {
-	N_("git symbolic-ref [options] name [ref]"),
-	N_("git symbolic-ref -d [-q] name"),
+	N_("git symbolic-ref [<options>] <name> [<ref>]"),
+	N_("git symbolic-ref -d [-q] <name>"),
 	NULL
 };
 
diff --git a/builtin/tag.c b/builtin/tag.c
index e633f4e..6dc85a9 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -19,9 +19,9 @@
 #include "column.h"
 
 static const char * const git_tag_usage[] = {
-	N_("git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]"),
+	N_("git tag [-a | -s | -u <key-id>] [-f] [-m <msg> | -F <file>] <tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
-	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>] "
+	N_("git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]"
 		"\n\t\t[<pattern>...]"),
 	N_("git tag -v <tagname>..."),
 	NULL
diff --git a/builtin/update-index.c b/builtin/update-index.c
index b0e3dc9..5878986 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -400,7 +400,7 @@ static void read_index_info(int line_termination)
 }
 
 static const char * const update_index_usage[] = {
-	N_("git update-index [options] [--] [<file>...]"),
+	N_("git update-index [<options>] [--] [<file>...]"),
 	NULL
 };
 
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 1993529..8694274 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -6,9 +6,9 @@
 #include "argv-array.h"
 
 static const char * const git_update_ref_usage[] = {
-	N_("git update-ref [options] -d <refname> [<oldval>]"),
-	N_("git update-ref [options]    <refname> <newval> [<oldval>]"),
-	N_("git update-ref [options] --stdin [-z]"),
+	N_("git update-ref [<options>] -d <refname> [<oldval>]"),
+	N_("git update-ref [<options>]    <refname> <newval> [<oldval>]"),
+	N_("git update-ref [<options>] --stdin [-z]"),
 	NULL
 };
 
diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index b0f8504..ec0c4e3 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -14,7 +14,7 @@
 #include "gpg-interface.h"
 
 static const char * const verify_commit_usage[] = {
-		N_("git verify-commit [-v|--verbose] <commit>..."),
+		N_("git verify-commit [-v | --verbose] <commit>..."),
 		NULL
 };
 
diff --git a/builtin/verify-pack.c b/builtin/verify-pack.c
index 7747537..c94e156 100644
--- a/builtin/verify-pack.c
+++ b/builtin/verify-pack.c
@@ -51,7 +51,7 @@ static int verify_one_pack(const char *path, unsigned int flags)
 }
 
 static const char * const verify_pack_usage[] = {
-	N_("git verify-pack [-v|--verbose] [-s|--stat-only] <pack>..."),
+	N_("git verify-pack [-v | --verbose] [-s | --stat-only] <pack>..."),
 	NULL
 };
 
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 9cdf332..53c68fc 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -14,7 +14,7 @@
 #include "gpg-interface.h"
 
 static const char * const verify_tag_usage[] = {
-		N_("git verify-tag [-v|--verbose] <tag>..."),
+		N_("git verify-tag [-v | --verbose] <tag>..."),
 		NULL
 };
 
diff --git a/credential-store.c b/credential-store.c
index d435514..925d3f4 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -118,7 +118,7 @@ static int lookup_credential(const char *fn, struct credential *c)
 int main(int argc, char **argv)
 {
 	const char * const usage[] = {
-		"git credential-store [options] <action>",
+		"git credential-store [<options>] <action>",
 		NULL
 	};
 	const char *op;
diff --git a/git-bisect.sh b/git-bisect.sh
index 6cda2b5..351cbae 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -127,7 +127,7 @@ bisect_start() {
 		if test "z$mode" != "z--no-checkout"
 		then
 			git checkout "$start_head" -- ||
-			die "$(eval_gettext "Checking out '\$start_head' failed. Try 'git bisect reset <validbranch>'.")"
+			die "$(eval_gettext "Checking out '\$start_head' failed. Try 'git bisect reset <valid-branch>'.")"
 		fi
 	else
 		# Get rev from where we start.
diff --git a/git.c b/git.c
index 82d7a1c..0c029ec 100644
--- a/git.c
+++ b/git.c
@@ -9,7 +9,7 @@
 const char git_usage_string[] =
 	"git [--version] [--help] [-C <path>] [-c name=value]\n"
 	"           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
-	"           [-p|--paginate|--no-pager] [--no-replace-objects] [--bare]\n"
+	"           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
 	"           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
 	"           <command> [<args>]";
 
-- 
2.2.1
