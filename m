From: Stephan Beyer <s-beyer@gmx.net>
Subject: [PATCH] Make usage strings dash-less
Date: Sun, 13 Jul 2008 15:36:15 +0200
Message-ID: <1215956175-12949-1-git-send-email-s-beyer@gmx.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Stephan Beyer <s-beyer@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 13 15:37:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI1lZ-0005cD-3U
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 15:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYGMNg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 09:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbYGMNg2
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 09:36:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:41255 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753387AbYGMNgY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 09:36:24 -0400
Received: (qmail invoked by alias); 13 Jul 2008 13:36:22 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp038) with SMTP; 13 Jul 2008 15:36:22 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX19U8RBPLbtU3Y3L7TLgu2HhzNIcVXVm850C4ACh72
	2lpg0U3xIKb8As
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KI1kN-0006g9-8l; Sun, 13 Jul 2008 15:36:15 +0200
X-Mailer: git-send-email 1.5.6.2.306.gcc0c
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88312>

When you misuse a git command, you are shown the usage string.
But this is currently shown in the dashed form.  So if you just
copy what you see, it will not work, when the dashed form
is no longer supported.

This patch makes git commands show the dash-less version.

For shell scripts that do not specify OPTIONS_SPEC, git-sh-setup.sh
generates a dash-less usage string now.

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
---

Hi,

the stupid part of the patch is generated using:

	sed -i 's/^\([ \t]*\)"git-/\1"git /g' *.c
	sed -i 's/^git-/git /' git-*sh

There haven't been any false positives,
but I cannot guarantee that alle occurences in *.c and *.sh
have been replaced. ;)

Perl files were changed manually.
There, "$0" stuff was replaced by constant "git foo" strings.

Regards,
  Stephan

 builtin-add.c            |    2 +-
 builtin-apply.c          |    2 +-
 builtin-archive.c        |    2 +-
 builtin-blame.c          |    2 +-
 builtin-branch.c         |    8 ++++----
 builtin-cat-file.c       |    4 ++--
 builtin-check-attr.c     |    2 +-
 builtin-checkout-index.c |    2 +-
 builtin-clean.c          |    2 +-
 builtin-clone.c          |    2 +-
 builtin-commit.c         |    4 ++--
 builtin-config.c         |    2 +-
 builtin-count-objects.c  |    2 +-
 builtin-describe.c       |    2 +-
 builtin-diff-files.c     |    2 +-
 builtin-diff-index.c     |    2 +-
 builtin-diff-tree.c      |    2 +-
 builtin-diff.c           |    2 +-
 builtin-fast-export.c    |    2 +-
 builtin-fetch-pack.c     |    2 +-
 builtin-fetch.c          |    2 +-
 builtin-fmt-merge-msg.c  |    2 +-
 builtin-for-each-ref.c   |    2 +-
 builtin-fsck.c           |    2 +-
 builtin-gc.c             |    2 +-
 builtin-grep.c           |    2 +-
 builtin-init-db.c        |    2 +-
 builtin-log.c            |    2 +-
 builtin-ls-files.c       |    2 +-
 builtin-ls-remote.c      |    2 +-
 builtin-ls-tree.c        |    2 +-
 builtin-mailinfo.c       |    2 +-
 builtin-mailsplit.c      |    2 +-
 builtin-merge-base.c     |    2 +-
 builtin-mv.c             |    2 +-
 builtin-name-rev.c       |    2 +-
 builtin-pack-refs.c      |    2 +-
 builtin-prune-packed.c   |    2 +-
 builtin-prune.c          |    2 +-
 builtin-push.c           |    2 +-
 builtin-reflog.c         |    6 +++---
 builtin-rerere.c         |    2 +-
 builtin-reset.c          |    4 ++--
 builtin-rev-list.c       |    2 +-
 builtin-rev-parse.c      |    2 +-
 builtin-revert.c         |    4 ++--
 builtin-rm.c             |    2 +-
 builtin-send-pack.c      |    2 +-
 builtin-shortlog.c       |    2 +-
 builtin-show-branch.c    |    2 +-
 builtin-symbolic-ref.c   |    2 +-
 builtin-tag.c            |    8 ++++----
 builtin-tar-tree.c       |    2 +-
 builtin-update-index.c   |    2 +-
 builtin-update-ref.c     |    4 ++--
 builtin-upload-archive.c |    6 +++---
 builtin-verify-tag.c     |    2 +-
 builtin-write-tree.c     |    2 +-
 daemon.c                 |    2 +-
 fast-import.c            |    2 +-
 git-am.sh                |    6 +++---
 git-archimport.perl      |    4 ++--
 git-cvsexportcommit.perl |    2 +-
 git-cvsimport.perl       |    2 +-
 git-cvsserver.perl       |    2 +-
 git-instaweb.sh          |    2 +-
 git-merge.sh             |    4 ++--
 git-pull.sh              |    2 +-
 git-quiltimport.sh       |    2 +-
 git-relink.perl          |    2 +-
 git-repack.sh            |    2 +-
 git-send-email.perl      |    2 +-
 git-sh-setup.sh          |    7 ++++---
 git-svn.perl             |    2 +-
 hash-object.c            |    2 +-
 help.c                   |    2 +-
 http-push.c              |    2 +-
 index-pack.c             |    2 +-
 pack-redundant.c         |    2 +-
 update-server-info.c     |    2 +-
 80 files changed, 102 insertions(+), 101 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 9930cf5..bf13aa3 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -16,7 +16,7 @@
 #include "parse-options.h"
 
 static const char * const builtin_add_usage[] = {
-	"git-add [options] [--] <filepattern>...",
+	"git add [options] [--] <filepattern>...",
 	NULL
 };
 static int patch_interactive = 0, add_interactive = 0;
diff --git a/builtin-apply.c b/builtin-apply.c
index d13313f..e15471b 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -46,7 +46,7 @@ static const char *fake_ancestor;
 static int line_termination = '\n';
 static unsigned long p_context = ULONG_MAX;
 static const char apply_usage[] =
-"git-apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|fix|error|error-all>] <patch>...";
+"git apply [--stat] [--numstat] [--summary] [--check] [--index] [--cached] [--apply] [--no-add] [--index-info] [--allow-binary-replacement] [--reverse] [--reject] [--verbose] [-z] [-pNUM] [-CNUM] [--whitespace=<nowarn|warn|fix|error|error-all>] <patch>...";
 
 static enum ws_error_action {
 	nowarn_ws_error,
diff --git a/builtin-archive.c b/builtin-archive.c
index c2e0c1e..5cca460 100644
--- a/builtin-archive.c
+++ b/builtin-archive.c
@@ -13,7 +13,7 @@
 #include "attr.h"
 
 static const char archive_usage[] = \
-"git-archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
+"git archive --format=<fmt> [--prefix=<prefix>/] [--verbose] [<extra>] <tree-ish> [path...]";
 
 static struct archiver_desc
 {
diff --git a/builtin-blame.c b/builtin-blame.c
index b451f6c..91850a5 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -20,7 +20,7 @@
 #include "mailmap.h"
 
 static char blame_usage[] =
-"git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
+"git blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
 "  -c                  Use the same output mode as git-annotate (Default: off)\n"
 "  -b                  Show blank SHA-1 for boundary commits (Default: off)\n"
 "  -l                  Show long commit SHA1 (Default: off)\n"
diff --git a/builtin-branch.c b/builtin-branch.c
index d279702..5cc3771 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -15,10 +15,10 @@
 #include "branch.h"
 
 static const char * const builtin_branch_usage[] = {
-	"git-branch [options] [-r | -a] [--merged | --no-merged]",
-	"git-branch [options] [-l] [-f] <branchname> [<start-point>]",
-	"git-branch [options] [-r] (-d | -D) <branchname>",
-	"git-branch [options] (-m | -M) [<oldbranch>] <newbranch>",
+	"git branch [options] [-r | -a] [--merged | --no-merged]",
+	"git branch [options] [-l] [-f] <branchname> [<start-point>]",
+	"git branch [options] [-r] (-d | -D) <branchname>",
+	"git branch [options] (-m | -M) [<oldbranch>] <newbranch>",
 	NULL
 };
 
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 880e75a..7441a56 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -202,8 +202,8 @@ static int batch_objects(int print_contents)
 }
 
 static const char * const cat_file_usage[] = {
-	"git-cat-file [-t|-s|-e|-p|<type>] <sha1>",
-	"git-cat-file [--batch|--batch-check] < <list_of_sha1s>",
+	"git cat-file [-t|-s|-e|-p|<type>] <sha1>",
+	"git cat-file [--batch|--batch-check] < <list_of_sha1s>",
 	NULL
 };
 
diff --git a/builtin-check-attr.c b/builtin-check-attr.c
index 6afdfa1..cb783fc 100644
--- a/builtin-check-attr.c
+++ b/builtin-check-attr.c
@@ -4,7 +4,7 @@
 #include "quote.h"
 
 static const char check_attr_usage[] =
-"git-check-attr attr... [--] pathname...";
+"git check-attr attr... [--] pathname...";
 
 int cmd_check_attr(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin-checkout-index.c b/builtin-checkout-index.c
index eb1fc9a..71ebabf 100644
--- a/builtin-checkout-index.c
+++ b/builtin-checkout-index.c
@@ -154,7 +154,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 }
 
 static const char checkout_cache_usage[] =
-"git-checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=[123]|all] [--prefix=<string>] [--temp] [--] <file>...";
+"git checkout-index [-u] [-q] [-a] [-f] [-n] [--stage=[123]|all] [--prefix=<string>] [--temp] [--] <file>...";
 
 static struct lock_file lock_file;
 
diff --git a/builtin-clean.c b/builtin-clean.c
index 80a7ff9..48bf29f 100644
--- a/builtin-clean.c
+++ b/builtin-clean.c
@@ -15,7 +15,7 @@
 static int force = -1; /* unset */
 
 static const char *const builtin_clean_usage[] = {
-	"git-clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
+	"git clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
 	NULL
 };
 
diff --git a/builtin-clone.c b/builtin-clone.c
index ec36209..8112716 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -29,7 +29,7 @@
  *
  */
 static const char * const builtin_clone_usage[] = {
-	"git-clone [options] [--] <repo> [<dir>]",
+	"git clone [options] [--] <repo> [<dir>]",
 	NULL
 };
 
diff --git a/builtin-commit.c b/builtin-commit.c
index 745c11e..41cf5f2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -25,12 +25,12 @@
 #include "unpack-trees.h"
 
 static const char * const builtin_commit_usage[] = {
-	"git-commit [options] [--] <filepattern>...",
+	"git commit [options] [--] <filepattern>...",
 	NULL
 };
 
 static const char * const builtin_status_usage[] = {
-	"git-status [options] [--] <filepattern>...",
+	"git status [options] [--] <filepattern>...",
 	NULL
 };
 
diff --git a/builtin-config.c b/builtin-config.c
index 39f63d7..0cf191a 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -3,7 +3,7 @@
 #include "color.h"
 
 static const char git_config_set_usage[] =
-"git-config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
+"git config [ --global | --system | [ -f | --file ] config-file ] [ --bool | --int | --bool-or-int ] [ -z | --null ] [--get | --get-all | --get-regexp | --replace-all | --add | --unset | --unset-all] name [value [value_regex]] | --rename-section old_name new_name | --remove-section name | --list | --get-color var [default] | --get-colorbool name [stdout-is-tty]";
 
 static char *key;
 static regex_t *key_regexp;
diff --git a/builtin-count-objects.c b/builtin-count-objects.c
index f00306f..91b5487 100644
--- a/builtin-count-objects.c
+++ b/builtin-count-objects.c
@@ -67,7 +67,7 @@ static void count_objects(DIR *d, char *path, int len, int verbose,
 }
 
 static char const * const count_objects_usage[] = {
-	"git-count-objects [-v]",
+	"git count-objects [-v]",
 	NULL
 };
 
diff --git a/builtin-describe.c b/builtin-describe.c
index e515f9c..5dabca9 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -10,7 +10,7 @@
 #define MAX_TAGS	(FLAG_BITS - 1)
 
 static const char * const describe_usage[] = {
-	"git-describe [options] <committish>*",
+	"git describe [options] <committish>*",
 	NULL
 };
 
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 384d871..9bf10bb 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -10,7 +10,7 @@
 #include "builtin.h"
 
 static const char diff_files_usage[] =
-"git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
+"git diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 2f44ebf..17d851b 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -5,7 +5,7 @@
 #include "builtin.h"
 
 static const char diff_cache_usage[] =
-"git-diff-index [-m] [--cached] "
+"git diff-index [-m] [--cached] "
 "[<common diff options>] <tree-ish> [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 9d2a48f..415cb16 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -53,7 +53,7 @@ static int diff_tree_stdin(char *line)
 }
 
 static const char diff_tree_usage[] =
-"git-diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
+"git diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
 "[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
 "  -r            diff recursively\n"
 "  --root        include the initial commit as diff against /dev/null\n"
diff --git a/builtin-diff.c b/builtin-diff.c
index 4c289e7..faaa85a 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -21,7 +21,7 @@ struct blobinfo {
 };
 
 static const char builtin_diff_usage[] =
-"git-diff <options> <rev>{0,2} -- <path>*";
+"git diff <options> <rev>{0,2} -- <path>*";
 
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 75132ba..76f3167 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -18,7 +18,7 @@
 #include "parse-options.h"
 
 static const char *fast_export_usage[] = {
-	"git-fast-export [rev-list-opts]",
+	"git fast-export [rev-list-opts]",
 	NULL
 };
 
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 1ea7040..273239a 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -18,7 +18,7 @@ static struct fetch_pack_args args = {
 };
 
 static const char fetch_pack_usage[] =
-"git-fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
+"git fetch-pack [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] [--no-progress] [-v] [<host>:]<directory> [<refs>...]";
 
 #define COMPLETE	(1U << 0)
 #define COMMON		(1U << 1)
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 97fdc51..61de50a 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -12,7 +12,7 @@
 #include "parse-options.h"
 
 static const char * const builtin_fetch_usage[] = {
-	"git-fetch [options] [<repository> <refspec>...]",
+	"git fetch [options] [<repository> <refspec>...]",
 	NULL
 };
 
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index b892621..b34b01f 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -6,7 +6,7 @@
 #include "tag.h"
 
 static const char *fmt_merge_msg_usage =
-	"git-fmt-merge-msg [--log] [--no-log] [--file <file>]";
+	"git fmt-merge-msg [--log] [--no-log] [--file <file>]";
 
 static int merge_summary;
 
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index fef93d7..76282ad 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -831,7 +831,7 @@ int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 }
 
 static char const * const for_each_ref_usage[] = {
-	"git-for-each-ref [options] [<pattern>]",
+	"git for-each-ref [options] [<pattern>]",
 	NULL
 };
 
diff --git a/builtin-fsck.c b/builtin-fsck.c
index b0f9648..7326dc3 100644
--- a/builtin-fsck.c
+++ b/builtin-fsck.c
@@ -539,7 +539,7 @@ static int fsck_cache_tree(struct cache_tree *it)
 }
 
 static char const * const fsck_usage[] = {
-	"git-fsck [options] [<object>...]",
+	"git fsck [options] [<object>...]",
 	NULL
 };
 
diff --git a/builtin-gc.c b/builtin-gc.c
index f5625bb..fac200e 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -18,7 +18,7 @@
 #define FAILED_RUN "failed to run %s"
 
 static const char * const builtin_gc_usage[] = {
-	"git-gc [options]",
+	"git gc [options]",
 	NULL
 };
 
diff --git a/builtin-grep.c b/builtin-grep.c
index ef29910..0cac395 100644
--- a/builtin-grep.c
+++ b/builtin-grep.c
@@ -495,7 +495,7 @@ static int grep_object(struct grep_opt *opt, const char **paths,
 }
 
 static const char builtin_grep_usage[] =
-"git-grep <option>* <rev>* [-e] <pattern> [<path>...]";
+"git grep <option>* <rev>* [-e] <pattern> [<path>...]";
 
 static const char emsg_invalid_context_len[] =
 "%s: invalid context length argument";
diff --git a/builtin-init-db.c b/builtin-init-db.c
index e23b843..53aff68 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -364,7 +364,7 @@ static int guess_repository_type(const char *git_dir)
 }
 
 static const char init_db_usage[] =
-"git-init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]";
+"git init [-q | --quiet] [--bare] [--template=<template-directory>] [--shared[=<permissions>]]";
 
 /*
  * If you want to, you can share the DB area with any number of branches.
diff --git a/builtin-log.c b/builtin-log.c
index 430d876..cb3b33a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1082,7 +1082,7 @@ static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
 }
 
 static const char cherry_usage[] =
-"git-cherry [-v] <upstream> [<head>] [<limit>]";
+"git cherry [-v] <upstream> [<head>] [<limit>]";
 int cmd_cherry(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 75ba422..e8d568e 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -423,7 +423,7 @@ int report_path_error(const char *ps_matched, const char **pathspec, int prefix_
 }
 
 static const char ls_files_usage[] =
-	"git-ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged|killed|modified])* "
+	"git ls-files [-z] [-t] [-v] (--[cached|deleted|others|stage|unmerged|killed|modified])* "
 	"[ --ignored ] [--exclude=<pattern>] [--exclude-from=<file>] "
 	"[ --exclude-per-directory=<filename> ] [--exclude-standard] "
 	"[--full-name] [--abbrev] [--] [<file>]*";
diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 06ab8da..c21b841 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -4,7 +4,7 @@
 #include "remote.h"
 
 static const char ls_remote_usage[] =
-"git-ls-remote [--upload-pack=<git-upload-pack>] [<host>:]<directory>";
+"git ls-remote [--upload-pack=<git-upload-pack>] [<host>:]<directory>";
 
 /*
  * Is there one among the list of patterns that match the tail part
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index f4a75dd..ac71358 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -23,7 +23,7 @@ static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const char ls_tree_usage[] =
-	"git-ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
+	"git ls-tree [-d] [-r] [-t] [-l] [-z] [--name-only] [--name-status] [--full-name] [--abbrev[=<n>]] <tree-ish> [path...]";
 
 static int show_recursive(const char *base, int baselen, const char *pathname)
 {
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index fa6e8f9..b3d281e 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -960,7 +960,7 @@ static int mailinfo(FILE *in, FILE *out, int ks, const char *encoding,
 }
 
 static const char mailinfo_usage[] =
-	"git-mailinfo [-k] [-u | --encoding=<encoding>] msg patch <mail >info";
+	"git mailinfo [-k] [-u | --encoding=<encoding>] msg patch <mail >info";
 
 int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin-mailsplit.c b/builtin-mailsplit.c
index ae2b4cb..0dc4cd9 100644
--- a/builtin-mailsplit.c
+++ b/builtin-mailsplit.c
@@ -9,7 +9,7 @@
 #include "path-list.h"
 
 static const char git_mailsplit_usage[] =
-"git-mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>...";
+"git mailsplit [-d<prec>] [-f<n>] [-b] -o<directory> <mbox>|<Maildir>...";
 
 static int is_from_line(const char *line, int len)
 {
diff --git a/builtin-merge-base.c b/builtin-merge-base.c
index bcf9395..1cb2925 100644
--- a/builtin-merge-base.c
+++ b/builtin-merge-base.c
@@ -20,7 +20,7 @@ static int show_merge_base(struct commit *rev1, struct commit *rev2, int show_al
 }
 
 static const char merge_base_usage[] =
-"git-merge-base [--all] <commit-id> <commit-id>";
+"git merge-base [--all] <commit-id> <commit-id>";
 
 int cmd_merge_base(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin-mv.c b/builtin-mv.c
index 5530e11..ba9ceda 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -11,7 +11,7 @@
 #include "parse-options.h"
 
 static const char * const builtin_mv_usage[] = {
-	"git-mv [options] <source>... <destination>",
+	"git mv [options] <source>... <destination>",
 	NULL
 };
 
diff --git a/builtin-name-rev.c b/builtin-name-rev.c
index f153da0..85612c4 100644
--- a/builtin-name-rev.c
+++ b/builtin-name-rev.c
@@ -172,7 +172,7 @@ static void show_name(const struct object *obj,
 }
 
 static char const * const name_rev_usage[] = {
-	"git-name-rev [options] ( --all | --stdin | <commit>... )",
+	"git name-rev [options] ( --all | --stdin | <commit>... )",
 	NULL
 };
 
diff --git a/builtin-pack-refs.c b/builtin-pack-refs.c
index ff90aef..34246df 100644
--- a/builtin-pack-refs.c
+++ b/builtin-pack-refs.c
@@ -3,7 +3,7 @@
 #include "pack-refs.h"
 
 static char const * const pack_refs_usage[] = {
-	"git-pack-refs [options]",
+	"git pack-refs [options]",
 	NULL
 };
 
diff --git a/builtin-prune-packed.c b/builtin-prune-packed.c
index 241afbb..10cb8df 100644
--- a/builtin-prune-packed.c
+++ b/builtin-prune-packed.c
@@ -3,7 +3,7 @@
 #include "progress.h"
 
 static const char prune_packed_usage[] =
-"git-prune-packed [-n] [-q]";
+"git prune-packed [-n] [-q]";
 
 #define DRY_RUN 01
 #define VERBOSE 02
diff --git a/builtin-prune.c b/builtin-prune.c
index bd3d2f6..7de4cab 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -7,7 +7,7 @@
 #include "parse-options.h"
 
 static const char * const prune_usage[] = {
-	"git-prune [-n] [--expire <time>] [--] [<head>...]",
+	"git prune [-n] [--expire <time>] [--] [<head>...]",
 	NULL
 };
 static int show_only;
diff --git a/builtin-push.c b/builtin-push.c
index b35aad6..03db28c 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git-push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=all] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index 125d455..0c34e37 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -13,9 +13,9 @@
  */
 
 static const char reflog_expire_usage[] =
-"git-reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
+"git reflog (show|expire) [--verbose] [--dry-run] [--stale-fix] [--expire=<time>] [--expire-unreachable=<time>] [--all] <refs>...";
 static const char reflog_delete_usage[] =
-"git-reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
+"git reflog delete [--verbose] [--dry-run] [--rewrite] [--updateref] <refs>...";
 
 static unsigned long default_reflog_expire;
 static unsigned long default_reflog_expire_unreachable;
@@ -630,7 +630,7 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
  */
 
 static const char reflog_usage[] =
-"git-reflog (expire | ...)";
+"git reflog (expire | ...)";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 839b26e..62ef7cf 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -7,7 +7,7 @@
 #include <time.h>
 
 static const char git_rerere_usage[] =
-"git-rerere [clear | status | diff | gc]";
+"git rerere [clear | status | diff | gc]";
 
 /* these values are days */
 static int cutoff_noresolve = 15;
diff --git a/builtin-reset.c b/builtin-reset.c
index a032169..2e5a886 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -20,8 +20,8 @@
 #include "parse-options.h"
 
 static const char * const git_reset_usage[] = {
-	"git-reset [--mixed | --soft | --hard] [-q] [<commit>]",
-	"git-reset [--mixed] <commit> [--] <paths>...",
+	"git reset [--mixed | --soft | --hard] [-q] [<commit>]",
+	"git reset [--mixed] <commit> [--] <paths>...",
 	NULL
 };
 
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 54b6672..114114b 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -17,7 +17,7 @@
 #define COUNTED		(1u<<16)
 
 static const char rev_list_usage[] =
-"git-rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
+"git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
 "  limiting output:\n"
 "    --max-count=nr\n"
 "    --max-age=epoch\n"
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a7860ed..aa71f4a 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -268,7 +268,7 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 {
 	static int keep_dashdash = 0;
 	static char const * const parseopt_usage[] = {
-		"git-rev-parse --parseopt [options] -- [<args>...]",
+		"git rev-parse --parseopt [options] -- [<args>...]",
 		NULL
 	};
 	static struct option parseopt_opts[] = {
diff --git a/builtin-revert.c b/builtin-revert.c
index 0270f9b..ebfa3bb 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -24,12 +24,12 @@
  */
 
 static const char * const revert_usage[] = {
-	"git-revert [options] <commit-ish>",
+	"git revert [options] <commit-ish>",
 	NULL
 };
 
 static const char * const cherry_pick_usage[] = {
-	"git-cherry-pick [options] <commit-ish>",
+	"git cherry-pick [options] <commit-ish>",
 	NULL
 };
 
diff --git a/builtin-rm.c b/builtin-rm.c
index 22c9bd1..56454ec 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -11,7 +11,7 @@
 #include "parse-options.h"
 
 static const char * const builtin_rm_usage[] = {
-	"git-rm [options] [--] <file>...",
+	"git rm [options] [--] <file>...",
 	NULL
 };
 
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index a708d0a..7588d22 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -8,7 +8,7 @@
 #include "send-pack.h"
 
 static const char send_pack_usage[] =
-"git-send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
+"git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-receive-pack>] [--verbose] [--thin] [<host>:]<directory> [<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive.";
 
 static struct send_pack_args args = {
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index e6a2865..fcb0da9 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -9,7 +9,7 @@
 #include "shortlog.h"
 
 static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [-e] [-w] [<commit-id>... ]";
+"git shortlog [-n] [-s] [-e] [-w] [<commit-id>... ]";
 
 static int compare_by_number(const void *a1, const void *a2)
 {
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 93047f5..233eed4 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -4,7 +4,7 @@
 #include "builtin.h"
 
 static const char show_branch_usage[] =
-"git-show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n[,b]] <branch>";
+"git show-branch [--sparse] [--current] [--all] [--remotes] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...] | --reflog[=n[,b]] <branch>";
 static const char show_branch_usage_reflog[] =
 "--reflog is incompatible with --all, --remotes, --independent or --merge-base";
 
diff --git a/builtin-symbolic-ref.c b/builtin-symbolic-ref.c
index b49bdb6..bfc78bb 100644
--- a/builtin-symbolic-ref.c
+++ b/builtin-symbolic-ref.c
@@ -4,7 +4,7 @@
 #include "parse-options.h"
 
 static const char * const git_symbolic_ref_usage[] = {
-	"git-symbolic-ref [options] name [ref]",
+	"git symbolic-ref [options] name [ref]",
 	NULL
 };
 
diff --git a/builtin-tag.c b/builtin-tag.c
index 3c97c69..73cb7bf 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -14,10 +14,10 @@
 #include "parse-options.h"
 
 static const char * const git_tag_usage[] = {
-	"git-tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
-	"git-tag -d <tagname>...",
-	"git-tag -l [-n[<num>]] [<pattern>]",
-	"git-tag -v <tagname>...",
+	"git tag [-a|-s|-u <key-id>] [-f] [-m <msg>|-F <file>] <tagname> [<head>]",
+	"git tag -d <tagname>...",
+	"git tag -l [-n[<num>]] [<pattern>]",
+	"git tag -v <tagname>...",
 	NULL
 };
 
diff --git a/builtin-tar-tree.c b/builtin-tar-tree.c
index b04719e..f4bea4a 100644
--- a/builtin-tar-tree.c
+++ b/builtin-tar-tree.c
@@ -8,7 +8,7 @@
 #include "quote.h"
 
 static const char tar_tree_usage[] =
-"git-tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
+"git tar-tree [--remote=<repo>] <tree-ish> [basedir]\n"
 "*** Note that this command is now deprecated; use git-archive instead.";
 
 int cmd_tar_tree(int argc, const char **argv, const char *prefix)
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 9e0d7ab..38eb53c 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -387,7 +387,7 @@ static void read_index_info(int line_termination)
 }
 
 static const char update_index_usage[] =
-"git-update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--refresh] [--really-refresh] [--cacheinfo] [--chmod=(+|-)x] [--assume-unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file>...";
 
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
diff --git a/builtin-update-ref.c b/builtin-update-ref.c
index d90d11d..56a0b1b 100644
--- a/builtin-update-ref.c
+++ b/builtin-update-ref.c
@@ -4,8 +4,8 @@
 #include "parse-options.h"
 
 static const char * const git_update_ref_usage[] = {
-	"git-update-ref [options] -d <refname> [<oldval>]",
-	"git-update-ref [options]    <refname> <newval> [<oldval>]",
+	"git update-ref [options] -d <refname> [<oldval>]",
+	"git update-ref [options]    <refname> <newval> [<oldval>]",
 	NULL
 };
 
diff --git a/builtin-upload-archive.c b/builtin-upload-archive.c
index 371400d..6438133 100644
--- a/builtin-upload-archive.c
+++ b/builtin-upload-archive.c
@@ -8,13 +8,13 @@
 #include "sideband.h"
 
 static const char upload_archive_usage[] =
-	"git-upload-archive <repo>";
+	"git upload-archive <repo>";
 
 static const char deadchild[] =
-"git-upload-archive: archiver died with error";
+"git upload-archive: archiver died with error";
 
 static const char lostchild[] =
-"git-upload-archive: archiver process was lost";
+"git upload-archive: archiver process was lost";
 
 
 static int run_upload_archive(int argc, const char **argv, const char *prefix)
diff --git a/builtin-verify-tag.c b/builtin-verify-tag.c
index 92eaa89..7d837f0 100644
--- a/builtin-verify-tag.c
+++ b/builtin-verify-tag.c
@@ -12,7 +12,7 @@
 #include <signal.h>
 
 static const char builtin_verify_tag_usage[] =
-		"git-verify-tag [-v|--verbose] <tag>...";
+		"git verify-tag [-v|--verbose] <tag>...";
 
 #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
 
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index c218799..52a3c01 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -9,7 +9,7 @@
 #include "cache-tree.h"
 
 static const char write_tree_usage[] =
-"git-write-tree [--missing-ok] [--prefix=<prefix>/]";
+"git write-tree [--missing-ok] [--prefix=<prefix>/]";
 
 int cmd_write_tree(int argc, const char **argv, const char *unused_prefix)
 {
diff --git a/daemon.c b/daemon.c
index ce3a6f5..7df41a6 100644
--- a/daemon.c
+++ b/daemon.c
@@ -18,7 +18,7 @@ static int verbose;
 static int reuseaddr;
 
 static const char daemon_usage[] =
-"git-daemon [--verbose] [--syslog] [--export-all]\n"
+"git daemon [--verbose] [--syslog] [--export-all]\n"
 "           [--timeout=n] [--init-timeout=n] [--strict-paths]\n"
 "           [--base-path=path] [--base-path-relaxed]\n"
 "           [--user-path | --user-path=path]\n"
diff --git a/fast-import.c b/fast-import.c
index e72b286..c4d054e 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2374,7 +2374,7 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 }
 
 static const char fast_import_usage[] =
-"git-fast-import [--date-format=f] [--max-pack-size=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
+"git fast-import [--date-format=f] [--max-pack-size=n] [--depth=n] [--active-branches=n] [--export-marks=marks.file]";
 
 int main(int argc, const char **argv)
 {
diff --git a/git-am.sh b/git-am.sh
index 2c517ed..14578ce 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -5,9 +5,9 @@
 SUBDIRECTORY_OK=Yes
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git-am [options] <mbox>|<Maildir>...
-git-am [options] --resolved
-git-am [options] --skip
+git am [options] <mbox>|<Maildir>...
+git am [options] --resolved
+git am [options] --skip
 --
 d,dotest=       (removed -- do not use)
 i,interactive   run interactively
diff --git a/git-archimport.perl b/git-archimport.perl
index 9a7a906..98f3ede 100755
--- a/git-archimport.perl
+++ b/git-archimport.perl
@@ -9,7 +9,7 @@
 
 =head1 Invocation
 
-    git-archimport [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ]
+    git archimport [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ]
 	[ -D depth] [ -t tempdir ] <archive>/<branch> [ <archive>/<branch> ]
 
 Imports a project from one or more Arch repositories. It will follow branches
@@ -74,7 +74,7 @@ our($opt_h,$opt_f,$opt_v,$opt_T,$opt_t,$opt_D,$opt_a,$opt_o);
 
 sub usage() {
     print STDERR <<END;
-Usage: ${\basename $0}     # fetch/update GIT from Arch
+Usage: git archimport     # fetch/update GIT from Arch
        [ -h ] [ -v ] [ -o ] [ -a ] [ -f ] [ -T ] [ -D depth ] [ -t tempdir ]
        repository/arch-branch [ repository/arch-branch] ...
 END
diff --git a/git-cvsexportcommit.perl b/git-cvsexportcommit.perl
index c6c70e9..6d9f0ef 100755
--- a/git-cvsexportcommit.perl
+++ b/git-cvsexportcommit.perl
@@ -370,7 +370,7 @@ sleep(1);
 
 sub usage {
 	print STDERR <<END;
-Usage: GIT_DIR=/path/to/.git ${\basename $0} [-h] [-p] [-v] [-c] [-f] [-u] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
+Usage: GIT_DIR=/path/to/.git git cvsexportcommit [-h] [-p] [-v] [-c] [-f] [-u] [-w cvsworkdir] [-m msgprefix] [ parent ] commit
 END
 	exit(1);
 }
diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index cacbfc0..e2664ef 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -36,7 +36,7 @@ sub usage(;$) {
 	my $msg = shift;
 	print(STDERR "Error: $msg\n") if $msg;
 	print STDERR <<END;
-Usage: ${\basename $0}     # fetch/update GIT from CVS
+Usage: git cvsimport     # fetch/update GIT from CVS
        [-o branch-for-HEAD] [-h] [-v] [-d CVSROOT] [-A author-conv-file]
        [-p opts-for-cvsps] [-P file] [-C GIT_repository] [-z fuzz] [-i] [-k]
        [-u] [-s subst] [-a] [-m] [-M regex] [-S regex] [-L commitlimit]
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 920bbe1..d2d374a 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -101,7 +101,7 @@ my $work =
 $log->info("--------------- STARTING -----------------");
 
 my $usage =
-    "Usage: git-cvsserver [options] [pserver|server] [<directory> ...]\n".
+    "Usage: git cvsserver [options] [pserver|server] [<directory> ...]\n".
     "    --base-path <path>  : Prepend to requested CVSROOT\n".
     "    --strict-paths      : Don't allow recursing into subdirectories\n".
     "    --export-all        : Don't check for gitcvs.enabled in config\n".
diff --git a/git-instaweb.sh b/git-instaweb.sh
index af0fde5..0843372 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -6,7 +6,7 @@
 PERL='@@PERL@@'
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git-instaweb [options] (--start | --stop | --restart)
+git instaweb [options] (--start | --stop | --restart)
 --
 l,local        only bind on 127.0.0.1
 p,port=        the port to bind to
diff --git a/git-merge.sh b/git-merge.sh
index 8026ccf..e9588ee 100755
--- a/git-merge.sh
+++ b/git-merge.sh
@@ -5,8 +5,8 @@
 
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git-merge [options] <remote>...
-git-merge [options] <msg> HEAD <remote>
+git merge [options] <remote>...
+git merge [options] <msg> HEAD <remote>
 --
 stat                 show a diffstat at the end of the merge
 n                    don't show a diffstat at the end of the merge
diff --git a/git-pull.sh b/git-pull.sh
index 809e537..6afd4e2 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -121,7 +121,7 @@ test true = "$rebase" && {
 		"refs/remotes/$origin/$reflist" 2>/dev/null)"
 }
 orig_head=$(git rev-parse --verify HEAD 2>/dev/null)
-git-fetch --update-head-ok "$@" || exit 1
+git fetch --update-head-ok "$@" || exit 1
 
 curr_head=$(git rev-parse --verify HEAD 2>/dev/null)
 if test "$curr_head" != "$orig_head"
diff --git a/git-quiltimport.sh b/git-quiltimport.sh
index 7cd8f71..e0649cd 100755
--- a/git-quiltimport.sh
+++ b/git-quiltimport.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git-quiltimport [options]
+git quiltimport [options]
 --
 n,dry-run     dry run
 author=       author name and email address for patches without any
diff --git a/git-relink.perl b/git-relink.perl
index 15fb932..937c69a 100755
--- a/git-relink.perl
+++ b/git-relink.perl
@@ -163,7 +163,7 @@ sub link_two_files($$) {
 
 
 sub usage() {
-	print("Usage: $0 [--safe] <dir> [<dir> ...] <master_dir> \n");
+	print("Usage: git relink [--safe] <dir> [<dir> ...] <master_dir> \n");
 	print("All directories should contain a .git/objects/ subdirectory.\n");
 	print("Options\n");
 	print("\t--safe\t" .
diff --git a/git-repack.sh b/git-repack.sh
index 8c3bc13..683960b 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -5,7 +5,7 @@
 
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git-repack [options]
+git repack [options]
 --
 a               pack everything in a single pack
 A               same as -a, and turn unreachable objects loose
diff --git a/git-send-email.perl b/git-send-email.perl
index 6adb669..2e4a44a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -38,7 +38,7 @@ package main;
 
 sub usage {
 	print <<EOT;
-git-send-email [options] <file | directory>...
+git send-email [options] <file | directory>...
 Options:
    --from         Specify the "From:" line of the email to be sent.
 
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 9cceb21..dbdf209 100755
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -32,15 +32,16 @@ if test -n "$OPTIONS_SPEC"; then
 		echo exit $?
 	)"
 else
+	dashless=$(basename "$0" | sed -e 's/-/ /')
 	usage() {
-		die "Usage: $0 $USAGE"
+		die "Usage: $dashless $USAGE"
 	}
 
 	if [ -z "$LONG_USAGE" ]
 	then
-		LONG_USAGE="Usage: $0 $USAGE"
+		LONG_USAGE="Usage: $dashless $USAGE"
 	else
-		LONG_USAGE="Usage: $0 $USAGE
+		LONG_USAGE="Usage: $dashless $USAGE
 
 $LONG_USAGE"
 	fi
diff --git a/git-svn.perl b/git-svn.perl
index a366c89..f6b878a 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -261,7 +261,7 @@ sub usage {
 	my $fd = $exit ? \*STDERR : \*STDOUT;
 	print $fd <<"";
 git-svn - bidirectional operations between a single Subversion tree and git
-Usage: $0 <command> [options] [arguments]\n
+Usage: git svn <command> [options] [arguments]\n
 
 	print $fd "Available commands:\n" unless $cmd;
 
diff --git a/hash-object.c b/hash-object.c
index 48d5223..46c06a9 100644
--- a/hash-object.c
+++ b/hash-object.c
@@ -52,7 +52,7 @@ static void hash_stdin_paths(const char *type, int write_objects)
 }
 
 static const char hash_object_usage[] =
-"git-hash-object [ [-t <type>] [-w] [--stdin] <file>... | --stdin-paths < <list-of-paths> ]";
+"git hash-object [ [-t <type>] [-w] [--stdin] <file>... | --stdin-paths < <list-of-paths> ]";
 
 int main(int argc, char **argv)
 {
diff --git a/help.c b/help.c
index ca9632b..ee15955 100644
--- a/help.c
+++ b/help.c
@@ -40,7 +40,7 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	"git-help [--all] [--man|--web|--info] [command]",
+	"git help [--all] [--man|--web|--info] [command]",
 	NULL
 };
 
diff --git a/http-push.c b/http-push.c
index 2cd068a..6805288 100644
--- a/http-push.c
+++ b/http-push.c
@@ -14,7 +14,7 @@
 #include <expat.h>
 
 static const char http_push_usage[] =
-"git-http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
+"git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
 
 #ifndef XML_STATUS_OK
 enum XML_Status {
diff --git a/index-pack.c b/index-pack.c
index 25db5db..bb2e6a3 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -10,7 +10,7 @@
 #include "fsck.h"
 
 static const char index_pack_usage[] =
-"git-index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
+"git index-pack [-v] [-o <index-file>] [{ ---keep | --keep=<msg> }] [--strict] { <pack-file> | --stdin [--fix-thin] [<pack-file>] }";
 
 struct object_entry
 {
diff --git a/pack-redundant.c b/pack-redundant.c
index f5cd0ac..25b81a4 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -11,7 +11,7 @@
 #define BLKSIZE 512
 
 static const char pack_redundant_usage[] =
-"git-pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filename> ...>";
+"git pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filename> ...>";
 
 static int load_all_packs, verbose, alt_odb;
 
diff --git a/update-server-info.c b/update-server-info.c
index 0b6c383..7e8209e 100644
--- a/update-server-info.c
+++ b/update-server-info.c
@@ -1,7 +1,7 @@
 #include "cache.h"
 
 static const char update_server_info_usage[] =
-"git-update-server-info [--force]";
+"git update-server-info [--force]";
 
 int main(int ac, char **av)
 {
-- 
1.5.6.2.306.gcc0c
