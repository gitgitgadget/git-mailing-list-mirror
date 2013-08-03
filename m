From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCHv3 2/9] Replace deprecated OPT_BOOLEAN by OPT_BOOL
Date: Sat,  3 Aug 2013 13:51:19 +0200
Message-ID: <1375530686-2309-3-git-send-email-stefanbeller@googlemail.com>
References: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com
X-From: git-owner@vger.kernel.org Sat Aug 03 13:52:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V5aNN-0006I5-NO
	for gcvg-git-2@plane.gmane.org; Sat, 03 Aug 2013 13:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752631Ab3HCLvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Aug 2013 07:51:53 -0400
Received: from mail-ee0-f41.google.com ([74.125.83.41]:53695 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521Ab3HCLvH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Aug 2013 07:51:07 -0400
Received: by mail-ee0-f41.google.com with SMTP id d17so757033eek.14
        for <git@vger.kernel.org>; Sat, 03 Aug 2013 04:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=s740N9uPp3+PLkkM49HQy2+mUCov2Zy2HNBysOrz7R8=;
        b=0zjrKd9KXoBZaFb/6utlK0Rf7QXZNZtZNu15NhYNqbdFWz7zVS9Zf5fnAOby1ouUPv
         2v6SnLys2OUM4RYpQRg9PK6uL+Tw3MEDxLp6fuadzCgEOrnceP0pj/pm7rp6Q8f6evCI
         zBLmnLnNI+/il4ARthFJZWNajcHQE6W1fEeOOxOrWA0NdU5c8J/etdbv8aTfGL2zkF/u
         e9Gy6AYZS8mpeP9xkACs23/z4fU4/YdpvP9IewU3xWEAnHv0avytXZcZdS4p+YbCr0qv
         NlLrlZe6VIspo4VS81VzwdIxLsbt+P33nFA/Lnej9jBA9QMARMh9zvF4n9zRMt2Ctkhe
         eGJQ==
X-Received: by 10.14.102.72 with SMTP id c48mr9380376eeg.52.1375530665461;
        Sat, 03 Aug 2013 04:51:05 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id p49sm18909894eeu.2.2013.08.03.04.51.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sat, 03 Aug 2013 04:51:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.16.g7fca822.dirty
In-Reply-To: <1375530686-2309-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231591>

This task emerged from b04ba2bb (parse-options: deprecate OPT_BOOLEAN,
2011-09-27). All occurrences of the respective variables have
been reviewed and none of them relied on the counting up mechanism,
but all of them were using the variable as a true boolean.

This patch does not change semantics of any command intentionally.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/apply.c          | 24 ++++++++++++------------
 builtin/bisect--helper.c |  8 ++++----
 builtin/blame.c          |  8 ++++----
 builtin/branch.c         | 10 +++++-----
 builtin/check-attr.c     |  8 ++++----
 builtin/check-ignore.c   | 12 ++++++------
 builtin/checkout-index.c |  6 +++---
 builtin/checkout.c       | 10 +++++-----
 builtin/clean.c          |  6 +++---
 builtin/clone.c          | 16 ++++++++--------
 builtin/commit.c         | 36 ++++++++++++++++++------------------
 builtin/config.c         |  2 +-
 builtin/describe.c       | 20 ++++++++++----------
 builtin/fast-export.c    | 10 +++++-----
 builtin/fetch.c          | 24 ++++++++++++------------
 builtin/fsck.c           | 16 ++++++++--------
 builtin/gc.c             |  4 ++--
 builtin/grep.c           | 38 +++++++++++++++++++-------------------
 builtin/hash-object.c    |  6 +++---
 builtin/log.c            |  8 ++++----
 builtin/ls-files.c       | 24 ++++++++++++------------
 builtin/ls-tree.c        |  6 +++---
 builtin/merge-base.c     | 10 +++++-----
 builtin/merge-file.c     |  2 +-
 builtin/merge.c          | 12 ++++++------
 builtin/mv.c             |  2 +-
 builtin/name-rev.c       | 12 ++++++------
 builtin/notes.c          |  4 ++--
 builtin/push.c           |  6 +++---
 builtin/remote.c         | 28 ++++++++++++++--------------
 builtin/replace.c        |  6 +++---
 builtin/reset.c          |  2 +-
 builtin/rev-parse.c      |  4 ++--
 builtin/rm.c             |  6 +++---
 builtin/shortlog.c       | 12 ++++++------
 builtin/show-branch.c    | 28 ++++++++++++++--------------
 builtin/show-ref.c       | 10 +++++-----
 builtin/tag.c            |  4 ++--
 builtin/update-ref.c     |  4 ++--
 39 files changed, 227 insertions(+), 227 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 50912c9..ef32e4f 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4363,23 +4363,23 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 'p', NULL, NULL, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, option_parse_p },
-		OPT_BOOLEAN(0, "no-add", &no_add,
+		OPT_BOOL(0, "no-add", &no_add,
 			N_("ignore additions made by the patch")),
-		OPT_BOOLEAN(0, "stat", &diffstat,
+		OPT_BOOL(0, "stat", &diffstat,
 			N_("instead of applying the patch, output diffstat for the input")),
 		OPT_NOOP_NOARG(0, "allow-binary-replacement"),
 		OPT_NOOP_NOARG(0, "binary"),
-		OPT_BOOLEAN(0, "numstat", &numstat,
+		OPT_BOOL(0, "numstat", &numstat,
 			N_("show number of added and deleted lines in decimal notation")),
-		OPT_BOOLEAN(0, "summary", &summary,
+		OPT_BOOL(0, "summary", &summary,
 			N_("instead of applying the patch, output a summary for the input")),
-		OPT_BOOLEAN(0, "check", &check,
+		OPT_BOOL(0, "check", &check,
 			N_("instead of applying the patch, see if the patch is applicable")),
-		OPT_BOOLEAN(0, "index", &check_index,
+		OPT_BOOL(0, "index", &check_index,
 			N_("make sure the patch is applicable to the current index")),
-		OPT_BOOLEAN(0, "cached", &cached,
+		OPT_BOOL(0, "cached", &cached,
 			N_("apply a patch without touching the working tree")),
-		OPT_BOOLEAN(0, "apply", &force_apply,
+		OPT_BOOL(0, "apply", &force_apply,
 			N_("also apply the patch (use with --stat/--summary/--check)")),
 		OPT_BOOL('3', "3way", &threeway,
 			 N_( "attempt three-way merge if a patch does not apply")),
@@ -4399,13 +4399,13 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 		{ OPTION_CALLBACK, 0, "ignore-whitespace", NULL, NULL,
 			N_("ignore changes in whitespace when finding context"),
 			PARSE_OPT_NOARG, option_parse_space_change },
-		OPT_BOOLEAN('R', "reverse", &apply_in_reverse,
+		OPT_BOOL('R', "reverse", &apply_in_reverse,
 			N_("apply the patch in reverse")),
-		OPT_BOOLEAN(0, "unidiff-zero", &unidiff_zero,
+		OPT_BOOL(0, "unidiff-zero", &unidiff_zero,
 			N_("don't expect at least one line of context")),
-		OPT_BOOLEAN(0, "reject", &apply_with_reject,
+		OPT_BOOL(0, "reject", &apply_with_reject,
 			N_("leave the rejected hunks in corresponding *.rej files")),
-		OPT_BOOLEAN(0, "allow-overlap", &allow_overlap,
+		OPT_BOOL(0, "allow-overlap", &allow_overlap,
 			N_("allow overlapping hunks")),
 		OPT__VERBOSE(&apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index e3884e3..3324229 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -13,10 +13,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	int next_all = 0;
 	int no_checkout = 0;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "next-all", &next_all,
-			    N_("perform 'git bisect next'")),
-		OPT_BOOLEAN(0, "no-checkout", &no_checkout,
-			    N_("update BISECT_HEAD instead of checking out the current commit")),
+		OPT_BOOL(0, "next-all", &next_all,
+			 N_("perform 'git bisect next'")),
+		OPT_BOOL(0, "no-checkout", &no_checkout,
+			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
 	};
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 079dcd3..f932112 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2273,10 +2273,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	static const char *revs_file = NULL;
 	static const char *contents_from = NULL;
 	static const struct option options[] = {
-		OPT_BOOLEAN(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
-		OPT_BOOLEAN('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
-		OPT_BOOLEAN(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
-		OPT_BOOLEAN(0, "show-stats", &show_stats, N_("Show work cost statistics")),
+		OPT_BOOL(0, "incremental", &incremental, N_("Show blame entries as we find them, incrementally")),
+		OPT_BOOL('b', NULL, &blank_boundary, N_("Show blank SHA-1 for boundary commits (Default: off)")),
+		OPT_BOOL(0, "root", &show_root, N_("Do not treat root commits as boundaries (Default: off)")),
+		OPT_BOOL(0, "show-stats", &show_stats, N_("Show work cost statistics")),
 		OPT_BIT(0, "score-debug", &output_option, N_("Show output score for blame entries"), OUTPUT_SHOW_SCORE),
 		OPT_BIT('f', "show-name", &output_option, N_("Show original filename (Default: auto)"), OUTPUT_SHOW_NAME),
 		OPT_BIT('n', "show-number", &output_option, N_("Show original linenumber (Default: off)"), OUTPUT_SHOW_NUMBER),
diff --git a/builtin/branch.c b/builtin/branch.c
index 0836890..4daed0b 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -797,7 +797,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT( 0, "set-upstream",  &track, N_("change upstream info"),
 			BRANCH_TRACK_OVERRIDE),
 		OPT_STRING('u', "set-upstream-to", &new_upstream, "upstream", "change the upstream info"),
-		OPT_BOOLEAN(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
+		OPT_BOOL(0, "unset-upstream", &unset_upstream, "Unset the upstream info"),
 		OPT__COLOR(&branch_use_color, N_("use colored output")),
 		OPT_SET_INT('r', "remotes",     &kinds, N_("act on remote-tracking branches"),
 			REF_REMOTE_BRANCH),
@@ -822,10 +822,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('D', NULL, &delete, N_("delete branch (even if not merged)"), 2),
 		OPT_BIT('m', "move", &rename, N_("move/rename a branch and its reflog"), 1),
 		OPT_BIT('M', NULL, &rename, N_("move/rename a branch, even if target exists"), 2),
-		OPT_BOOLEAN(0, "list", &list, N_("list branch names")),
-		OPT_BOOLEAN('l', "create-reflog", &reflog, N_("create the branch's reflog")),
-		OPT_BOOLEAN(0, "edit-description", &edit_description,
-			    N_("edit the description for the branch")),
+		OPT_BOOL(0, "list", &list, N_("list branch names")),
+		OPT_BOOL('l', "create-reflog", &reflog, N_("create the branch's reflog")),
+		OPT_BOOL(0, "edit-description", &edit_description,
+			 N_("edit the description for the branch")),
 		OPT__FORCE(&force_create, N_("force creation (when already exists)")),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 075d01d..6e5cd88 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -16,10 +16,10 @@ NULL
 static int null_term_line;
 
 static const struct option check_attr_options[] = {
-	OPT_BOOLEAN('a', "all", &all_attrs, N_("report all attributes set on file")),
-	OPT_BOOLEAN(0,  "cached", &cached_attrs, N_("use .gitattributes only from the index")),
-	OPT_BOOLEAN(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
-	OPT_BOOLEAN('z', NULL, &null_term_line,
+	OPT_BOOL('a', "all", &all_attrs, N_("report all attributes set on file")),
+	OPT_BOOL(0,  "cached", &cached_attrs, N_("use .gitattributes only from the index")),
+	OPT_BOOL(0 , "stdin", &stdin_paths, N_("read file names from stdin")),
+	OPT_BOOL('z', NULL, &null_term_line,
 		N_("input paths are terminated by a null character")),
 	OPT_END()
 };
diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 4a8fc70..c9f0c9b 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -18,12 +18,12 @@ static const struct option check_ignore_options[] = {
 	OPT__QUIET(&quiet, N_("suppress progress reporting")),
 	OPT__VERBOSE(&verbose, N_("be verbose")),
 	OPT_GROUP(""),
-	OPT_BOOLEAN(0, "stdin", &stdin_paths,
-		    N_("read file names from stdin")),
-	OPT_BOOLEAN('z', NULL, &null_term_line,
-		    N_("input paths are terminated by a null character")),
-	OPT_BOOLEAN('n', "non-matching", &show_non_matching,
-		    N_("show non-matching input paths")),
+	OPT_BOOL(0, "stdin", &stdin_paths,
+		 N_("read file names from stdin")),
+	OPT_BOOL('z', NULL, &null_term_line,
+		 N_("input paths are terminated by a null character")),
+	OPT_BOOL('n', "non-matching", &show_non_matching,
+		 N_("show non-matching input paths")),
 	OPT_END()
 };
 
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index b1feda7..aa922ed 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -183,7 +183,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int prefix_length;
 	int force = 0, quiet = 0, not_new = 0;
 	struct option builtin_checkout_index_options[] = {
-		OPT_BOOLEAN('a', "all", &all,
+		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
 		OPT__FORCE(&force, N_("force overwrite of existing files")),
 		OPT__QUIET(&quiet,
@@ -196,9 +196,9 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			N_("paths are separated with NUL character"),
 			PARSE_OPT_NOARG, option_parse_z },
-		OPT_BOOLEAN(0, "stdin", &read_from_stdin,
+		OPT_BOOL(0, "stdin", &read_from_stdin,
 			N_("read list of paths from the standard input")),
-		OPT_BOOLEAN(0, "temp", &to_tempfile,
+		OPT_BOOL(0, "temp", &to_tempfile,
 			N_("write the content to temporary files")),
 		OPT_CALLBACK(0, "prefix", NULL, N_("string"),
 			N_("when creating files, prepend <string>"),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 646a475..8b48f4a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1056,8 +1056,8 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			   N_("create and checkout a new branch")),
 		OPT_STRING('B', NULL, &opts.new_branch_force, N_("branch"),
 			   N_("create/reset and checkout a branch")),
-		OPT_BOOLEAN('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
-		OPT_BOOLEAN(0, "detach", &opts.force_detach, N_("detach the HEAD at named commit")),
+		OPT_BOOL('l', NULL, &opts.new_branch_log, N_("create reflog for new branch")),
+		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach the HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new branch"), N_("new unparented branch")),
@@ -1066,11 +1066,11 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, N_("checkout their version for unmerged files"),
 			    3),
 		OPT__FORCE(&opts.force, N_("force checkout (throw away local modifications)")),
-		OPT_BOOLEAN('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
-		OPT_BOOLEAN(0, "overwrite-ignore", &opts.overwrite_ignore, N_("update ignored files (default)")),
+		OPT_BOOL('m', "merge", &opts.merge, N_("perform a 3-way merge with the new branch")),
+		OPT_BOOL(0, "overwrite-ignore", &opts.overwrite_ignore, N_("update ignored files (default)")),
 		OPT_STRING(0, "conflict", &conflict_style, N_("style"),
 			   N_("conflict style (merge or diff3)")),
-		OPT_BOOLEAN('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
+		OPT_BOOL('p', "patch", &opts.patch_mode, N_("select hunks interactively")),
 		OPT_BOOL(0, "ignore-skip-worktree-bits", &opts.ignore_skipworktree,
 			 N_("do not limit pathspecs to sparse entries only")),
 		OPT_HIDDEN_BOOL(0, "guess", &dwim_new_local_branch,
diff --git a/builtin/clean.c b/builtin/clean.c
index dba8387..df0f61e 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -851,12 +851,12 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		OPT__DRY_RUN(&dry_run, N_("dry run")),
 		OPT__FORCE(&force, N_("force")),
 		OPT_BOOL('i', "interactive", &interactive, N_("interactive cleaning")),
-		OPT_BOOLEAN('d', NULL, &remove_directories,
+		OPT_BOOL('d', NULL, &remove_directories,
 				N_("remove whole directories")),
 		{ OPTION_CALLBACK, 'e', "exclude", &exclude_list, N_("pattern"),
 		  N_("add <pattern> to ignore rules"), PARSE_OPT_NONEG, exclude_cb },
-		OPT_BOOLEAN('x', NULL, &ignored, N_("remove ignored files, too")),
-		OPT_BOOLEAN('X', NULL, &ignored_only,
+		OPT_BOOL('x', NULL, &ignored, N_("remove ignored files, too")),
+		OPT_BOOL('X', NULL, &ignored_only,
 				N_("remove only ignored files")),
 		OPT_END()
 	};
diff --git a/builtin/clone.c b/builtin/clone.c
index e7b0b13..ca3eb68 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -62,22 +62,22 @@ static struct option builtin_clone_options[] = {
 	OPT__VERBOSITY(&option_verbosity),
 	OPT_BOOL(0, "progress", &option_progress,
 		 N_("force progress reporting")),
-	OPT_BOOLEAN('n', "no-checkout", &option_no_checkout,
-		    N_("don't create a checkout")),
+	OPT_BOOL('n', "no-checkout", &option_no_checkout,
+		 N_("don't create a checkout")),
 	OPT_BOOL(0, "bare", &option_bare, N_("create a bare repository")),
 	OPT_HIDDEN_BOOL(0, "naked", &option_bare,
 			N_("create a bare repository")),
-	OPT_BOOLEAN(0, "mirror", &option_mirror,
-		    N_("create a mirror repository (implies bare)")),
+	OPT_BOOL(0, "mirror", &option_mirror,
+		 N_("create a mirror repository (implies bare)")),
 	OPT_BOOL('l', "local", &option_local,
 		N_("to clone from a local repository")),
-	OPT_BOOLEAN(0, "no-hardlinks", &option_no_hardlinks,
+	OPT_BOOL(0, "no-hardlinks", &option_no_hardlinks,
 		    N_("don't use local hardlinks, always copy")),
-	OPT_BOOLEAN('s', "shared", &option_shared,
+	OPT_BOOL('s', "shared", &option_shared,
 		    N_("setup as shared repository")),
-	OPT_BOOLEAN(0, "recursive", &option_recursive,
+	OPT_BOOL(0, "recursive", &option_recursive,
 		    N_("initialize submodules in the clone")),
-	OPT_BOOLEAN(0, "recurse-submodules", &option_recursive,
+	OPT_BOOL(0, "recurse-submodules", &option_recursive,
 		    N_("initialize submodules in the clone")),
 	OPT_STRING(0, "template", &option_template, N_("template-directory"),
 		   N_("directory from which templates will be used")),
diff --git a/builtin/commit.c b/builtin/commit.c
index b64a083..c20426b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1209,14 +1209,14 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "long", &status_format,
 			    N_("show status in long format (default)"),
 			    STATUS_FORMAT_LONG),
-		OPT_BOOLEAN('z', "null", &s.null_termination,
-			    N_("terminate entries with NUL")),
+		OPT_BOOL('z', "null", &s.null_termination,
+			 N_("terminate entries with NUL")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg,
 		  N_("mode"),
 		  N_("show untracked files, optional modes: all, normal, no. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
-		OPT_BOOLEAN(0, "ignored", &show_ignored_in_status,
-			    N_("show ignored files")),
+		OPT_BOOL(0, "ignored", &show_ignored_in_status,
+			 N_("show ignored files")),
 		{ OPTION_STRING, 0, "ignore-submodules", &ignore_submodule_arg, N_("when"),
 		  N_("ignore changes to submodules, optional when: all, dirty, untracked. (Default: all)"),
 		  PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
@@ -1415,24 +1415,24 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_STRING('C', "reuse-message", &use_message, N_("commit"), N_("reuse message from specified commit")),
 		OPT_STRING(0, "fixup", &fixup_message, N_("commit"), N_("use autosquash formatted message to fixup specified commit")),
 		OPT_STRING(0, "squash", &squash_message, N_("commit"), N_("use autosquash formatted message to squash specified commit")),
-		OPT_BOOLEAN(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
-		OPT_BOOLEAN('s', "signoff", &signoff, N_("add Signed-off-by:")),
+		OPT_BOOL(0, "reset-author", &renew_authorship, N_("the commit is authored by me now (used with -C/-c/--amend)")),
+		OPT_BOOL('s', "signoff", &signoff, N_("add Signed-off-by:")),
 		OPT_FILENAME('t', "template", &template_file, N_("use specified template file")),
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
-		OPT_BOOLEAN(0, "status", &include_status, N_("include status in commit message template")),
+		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
 		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		/* end commit message options */
 
 		OPT_GROUP(N_("Commit contents options")),
-		OPT_BOOLEAN('a', "all", &all, N_("commit all changed files")),
-		OPT_BOOLEAN('i', "include", &also, N_("add specified files to index for commit")),
-		OPT_BOOLEAN(0, "interactive", &interactive, N_("interactively add files")),
-		OPT_BOOLEAN('p', "patch", &patch_interactive, N_("interactively add changes")),
-		OPT_BOOLEAN('o', "only", &only, N_("commit only specified files")),
-		OPT_BOOLEAN('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
-		OPT_BOOLEAN(0, "dry-run", &dry_run, N_("show what would be committed")),
+		OPT_BOOL('a', "all", &all, N_("commit all changed files")),
+		OPT_BOOL('i', "include", &also, N_("add specified files to index for commit")),
+		OPT_BOOL(0, "interactive", &interactive, N_("interactively add files")),
+		OPT_BOOL('p', "patch", &patch_interactive, N_("interactively add changes")),
+		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
+		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit hook")),
+		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
 		OPT_BOOL(0, "branch", &s.show_branch, N_("show branch information")),
@@ -1441,10 +1441,10 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_SET_INT(0, "long", &status_format,
 			    N_("show status in long format (default)"),
 			    STATUS_FORMAT_LONG),
-		OPT_BOOLEAN('z', "null", &s.null_termination,
-			    N_("terminate entries with NUL")),
-		OPT_BOOLEAN(0, "amend", &amend, N_("amend previous commit")),
-		OPT_BOOLEAN(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
+		OPT_BOOL('z', "null", &s.null_termination,
+			 N_("terminate entries with NUL")),
+		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
+		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
 
diff --git a/builtin/config.c b/builtin/config.c
index 4010c43..da12fdb 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -75,7 +75,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "bool-or-int", &types, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
 	OPT_BIT(0, "path", &types, N_("value is a path (file or directory name)"), TYPE_PATH),
 	OPT_GROUP(N_("Other")),
-	OPT_BOOLEAN('z', "null", &end_null, N_("terminate values with NUL byte")),
+	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "includes", &respect_includes, N_("respect include directives on lookup")),
 	OPT_END(),
 };
diff --git a/builtin/describe.c b/builtin/describe.c
index 7d73722..c94e5c3 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -406,12 +406,12 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 {
 	int contains = 0;
 	struct option options[] = {
-		OPT_BOOLEAN(0, "contains",   &contains, N_("find the tag that comes after the commit")),
-		OPT_BOOLEAN(0, "debug",      &debug, N_("debug search strategy on stderr")),
-		OPT_BOOLEAN(0, "all",        &all, N_("use any ref")),
-		OPT_BOOLEAN(0, "tags",       &tags, N_("use any tag, even unannotated")),
-		OPT_BOOLEAN(0, "long",       &longformat, N_("always use long format")),
-		OPT_BOOLEAN(0, "first-parent", &first_parent, N_("only follow first parent")),
+		OPT_BOOL(0, "contains",   &contains, N_("find the tag that comes after the commit")),
+		OPT_BOOL(0, "debug",      &debug, N_("debug search strategy on stderr")),
+		OPT_BOOL(0, "all",        &all, N_("use any ref")),
+		OPT_BOOL(0, "tags",       &tags, N_("use any tag, even unannotated")),
+		OPT_BOOL(0, "long",       &longformat, N_("always use long format")),
+		OPT_BOOL(0, "first-parent", &first_parent, N_("only follow first parent")),
 		OPT__ABBREV(&abbrev),
 		OPT_SET_INT(0, "exact-match", &max_candidates,
 			    N_("only output exact matches"), 0),
@@ -419,11 +419,11 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 			    N_("consider <n> most recent tags (default: 10)")),
 		OPT_STRING(0, "match",       &pattern, N_("pattern"),
 			   N_("only consider tags matching <pattern>")),
-		OPT_BOOLEAN(0, "always",     &always,
-			   N_("show abbreviated commit object as fallback")),
+		OPT_BOOL(0, "always",        &always,
+			N_("show abbreviated commit object as fallback")),
 		{OPTION_STRING, 0, "dirty",  &dirty, N_("mark"),
-			   N_("append <mark> on dirty working tree (default: \"-dirty\")"),
-		 PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
+			N_("append <mark> on dirty working tree (default: \"-dirty\")"),
+			PARSE_OPT_OPTARG, NULL, (intptr_t) "-dirty"},
 		OPT_END(),
 	};
 
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index d1d68e9..32b0c3f 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -674,11 +674,11 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     N_("Dump marks to this file")),
 		OPT_STRING(0, "import-marks", &import_filename, N_("file"),
 			     N_("Import marks from this file")),
-		OPT_BOOLEAN(0, "fake-missing-tagger", &fake_missing_tagger,
-			     N_("Fake a tagger when tags lack one")),
-		OPT_BOOLEAN(0, "full-tree", &full_tree,
-			     N_("Output full tree for each commit")),
-		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
+		OPT_BOOL(0, "fake-missing-tagger", &fake_missing_tagger,
+			 N_("Fake a tagger when tags lack one")),
+		OPT_BOOL(0, "full-tree", &full_tree,
+			 N_("Output full tree for each commit")),
+		OPT_BOOL(0, "use-done-feature", &use_done_feature,
 			     N_("Use the done feature to terminate the stream")),
 		OPT_BOOL(0, "no-data", &no_data, N_("Skip output of blob data")),
 		OPT_END()
diff --git a/builtin/fetch.c b/builtin/fetch.c
index d784b2e..99afed0 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -56,28 +56,28 @@ static int option_parse_recurse_submodules(const struct option *opt,
 
 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
-	OPT_BOOLEAN(0, "all", &all,
-		    N_("fetch from all remotes")),
-	OPT_BOOLEAN('a', "append", &append,
-		    N_("append to .git/FETCH_HEAD instead of overwriting")),
+	OPT_BOOL(0, "all", &all,
+		 N_("fetch from all remotes")),
+	OPT_BOOL('a', "append", &append,
+		 N_("append to .git/FETCH_HEAD instead of overwriting")),
 	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
 		   N_("path to upload pack on remote end")),
 	OPT__FORCE(&force, N_("force overwrite of local branch")),
-	OPT_BOOLEAN('m', "multiple", &multiple,
-		    N_("fetch from multiple remotes")),
+	OPT_BOOL('m', "multiple", &multiple,
+		 N_("fetch from multiple remotes")),
 	OPT_SET_INT('t', "tags", &tags,
 		    N_("fetch all tags and associated objects"), TAGS_SET),
 	OPT_SET_INT('n', NULL, &tags,
 		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
-	OPT_BOOLEAN('p', "prune", &prune,
-		    N_("prune remote-tracking branches no longer on remote")),
+	OPT_BOOL('p', "prune", &prune,
+		 N_("prune remote-tracking branches no longer on remote")),
 	{ OPTION_CALLBACK, 0, "recurse-submodules", NULL, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_parse_recurse_submodules },
-	OPT_BOOLEAN(0, "dry-run", &dry_run,
-		    N_("dry run")),
-	OPT_BOOLEAN('k', "keep", &keep, N_("keep downloaded pack")),
-	OPT_BOOLEAN('u', "update-head-ok", &update_head_ok,
+	OPT_BOOL(0, "dry-run", &dry_run,
+		 N_("dry run")),
+	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
+	OPT_BOOL('u', "update-head-ok", &update_head_ok,
 		    N_("allow updating of HEAD ref")),
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 9909b6d..39fa5e8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -611,15 +611,15 @@ static char const * const fsck_usage[] = {
 
 static struct option fsck_opts[] = {
 	OPT__VERBOSE(&verbose, N_("be verbose")),
-	OPT_BOOLEAN(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
+	OPT_BOOL(0, "unreachable", &show_unreachable, N_("show unreachable objects")),
 	OPT_BOOL(0, "dangling", &show_dangling, N_("show dangling objects")),
-	OPT_BOOLEAN(0, "tags", &show_tags, N_("report tags")),
-	OPT_BOOLEAN(0, "root", &show_root, N_("report root nodes")),
-	OPT_BOOLEAN(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
-	OPT_BOOLEAN(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
-	OPT_BOOLEAN(0, "full", &check_full, N_("also consider packs and alternate objects")),
-	OPT_BOOLEAN(0, "strict", &check_strict, N_("enable more strict checking")),
-	OPT_BOOLEAN(0, "lost-found", &write_lost_and_found,
+	OPT_BOOL(0, "tags", &show_tags, N_("report tags")),
+	OPT_BOOL(0, "root", &show_root, N_("report root nodes")),
+	OPT_BOOL(0, "cache", &keep_cache_objects, N_("make index objects head nodes")),
+	OPT_BOOL(0, "reflogs", &include_reflogs, N_("make reflogs head nodes (default)")),
+	OPT_BOOL(0, "full", &check_full, N_("also consider packs and alternate objects")),
+	OPT_BOOL(0, "strict", &check_strict, N_("enable more strict checking")),
+	OPT_BOOL(0, "lost-found", &write_lost_and_found,
 				N_("write dangling objects in .git/lost-found")),
 	OPT_BOOL(0, "progress", &show_progress, N_("show progress")),
 	OPT_END(),
diff --git a/builtin/gc.c b/builtin/gc.c
index 6be6c8d..c4f7390 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -178,8 +178,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 0, "prune", &prune_expire, N_("date"),
 			N_("prune unreferenced objects"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)prune_expire },
-		OPT_BOOLEAN(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
-		OPT_BOOLEAN(0, "auto", &auto_gc, N_("enable auto-gc mode")),
+		OPT_BOOL(0, "aggressive", &aggressive, N_("be more thorough (increased runtime)")),
+		OPT_BOOL(0, "auto", &auto_gc, N_("enable auto-gc mode")),
 		OPT_END()
 	};
 
diff --git a/builtin/grep.c b/builtin/grep.c
index d3b3b1d..7877e77 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -638,20 +638,20 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 
 	struct option options[] = {
-		OPT_BOOLEAN(0, "cached", &cached,
+		OPT_BOOL(0, "cached", &cached,
 			N_("search in index instead of in the work tree")),
 		OPT_NEGBIT(0, "no-index", &use_index,
 			 N_("find in contents not managed by git"), 1),
-		OPT_BOOLEAN(0, "untracked", &untracked,
+		OPT_BOOL(0, "untracked", &untracked,
 			N_("search in both tracked and untracked files")),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
 			    N_("search also in ignored files"), 1),
 		OPT_GROUP(""),
-		OPT_BOOLEAN('v', "invert-match", &opt.invert,
+		OPT_BOOL('v', "invert-match", &opt.invert,
 			N_("show non-matching lines")),
-		OPT_BOOLEAN('i', "ignore-case", &opt.ignore_case,
+		OPT_BOOL('i', "ignore-case", &opt.ignore_case,
 			N_("case insensitive matching")),
-		OPT_BOOLEAN('w', "word-regexp", &opt.word_regexp,
+		OPT_BOOL('w', "word-regexp", &opt.word_regexp,
 			N_("match patterns only at word boundaries")),
 		OPT_SET_INT('a', "text", &opt.binary,
 			N_("process binary files as text"), GREP_BINARY_TEXT),
@@ -675,26 +675,26 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			    N_("use Perl-compatible regular expressions"),
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
-		OPT_BOOLEAN('n', "line-number", &opt.linenum, N_("show line numbers")),
+		OPT_BOOL('n', "line-number", &opt.linenum, N_("show line numbers")),
 		OPT_NEGBIT('h', NULL, &opt.pathname, N_("don't show filenames"), 1),
 		OPT_BIT('H', NULL, &opt.pathname, N_("show filenames"), 1),
 		OPT_NEGBIT(0, "full-name", &opt.relative,
 			N_("show filenames relative to top directory"), 1),
-		OPT_BOOLEAN('l', "files-with-matches", &opt.name_only,
+		OPT_BOOL('l', "files-with-matches", &opt.name_only,
 			N_("show only filenames instead of matching lines")),
-		OPT_BOOLEAN(0, "name-only", &opt.name_only,
+		OPT_BOOL(0, "name-only", &opt.name_only,
 			N_("synonym for --files-with-matches")),
-		OPT_BOOLEAN('L', "files-without-match",
+		OPT_BOOL('L', "files-without-match",
 			&opt.unmatch_name_only,
 			N_("show only the names of files without match")),
-		OPT_BOOLEAN('z', "null", &opt.null_following_name,
+		OPT_BOOL('z', "null", &opt.null_following_name,
 			N_("print NUL after filenames")),
-		OPT_BOOLEAN('c', "count", &opt.count,
+		OPT_BOOL('c', "count", &opt.count,
 			N_("show the number of matches instead of matching lines")),
 		OPT__COLOR(&opt.color, N_("highlight matches")),
-		OPT_BOOLEAN(0, "break", &opt.file_break,
+		OPT_BOOL(0, "break", &opt.file_break,
 			N_("print empty line between matches from different files")),
-		OPT_BOOLEAN(0, "heading", &opt.heading,
+		OPT_BOOL(0, "heading", &opt.heading,
 			N_("show filename only once above matches from same file")),
 		OPT_GROUP(""),
 		OPT_CALLBACK('C', "context", &opt, N_("n"),
@@ -706,9 +706,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("show <n> context lines after matches")),
 		OPT_NUMBER_CALLBACK(&opt, N_("shortcut for -C NUM"),
 			context_callback),
-		OPT_BOOLEAN('p', "show-function", &opt.funcname,
+		OPT_BOOL('p', "show-function", &opt.funcname,
 			N_("show a line with the function name before matches")),
-		OPT_BOOLEAN('W', "function-context", &opt.funcbody,
+		OPT_BOOL('W', "function-context", &opt.funcbody,
 			N_("show the surrounding function")),
 		OPT_GROUP(""),
 		OPT_CALLBACK('f', NULL, &opt, N_("file"),
@@ -718,7 +718,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
 		  N_("combine patterns specified with -e"),
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
-		OPT_BOOLEAN(0, "or", &dummy, ""),
+		OPT_BOOL(0, "or", &dummy, ""),
 		{ OPTION_CALLBACK, 0, "not", &opt, NULL, "",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, not_callback },
 		{ OPTION_CALLBACK, '(', NULL, &opt, NULL, "",
@@ -729,7 +729,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		  close_callback },
 		OPT__QUIET(&opt.status_only,
 			   N_("indicate hit with exit status without output")),
-		OPT_BOOLEAN(0, "all-match", &opt.all_match,
+		OPT_BOOL(0, "all-match", &opt.all_match,
 			N_("show only matches from files that match all patterns")),
 		{ OPTION_SET_INT, 0, "debug", &opt.debug, NULL,
 		  N_("show parse tree for grep expression"),
@@ -738,8 +738,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			N_("pager"), N_("show matching files in the pager"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
-		OPT_BOOLEAN(0, "ext-grep", &external_grep_allowed__ignored,
-			    N_("allow calling of grep(1) (ignored by this build)")),
+		OPT_BOOL(0, "ext-grep", &external_grep_allowed__ignored,
+			 N_("allow calling of grep(1) (ignored by this build)")),
 		{ OPTION_CALLBACK, 0, "help-all", &options, NULL, N_("show usage"),
 		  PARSE_OPT_HIDDEN | PARSE_OPT_NOARG, help_callback },
 		OPT_END()
diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 8d184f1..4aea5bb 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -70,10 +70,10 @@ static const char *vpath;
 
 static const struct option hash_object_options[] = {
 	OPT_STRING('t', NULL, &type, N_("type"), N_("object type")),
-	OPT_BOOLEAN('w', NULL, &write_object, N_("write the object into the object database")),
+	OPT_BOOL('w', NULL, &write_object, N_("write the object into the object database")),
 	OPT_BOOLEAN( 0 , "stdin", &hashstdin, N_("read the object from stdin")),
-	OPT_BOOLEAN( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
-	OPT_BOOLEAN( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
+	OPT_BOOL( 0 , "stdin-paths", &stdin_paths, N_("read file names from stdin")),
+	OPT_BOOL( 0 , "no-filters", &no_filters, N_("store file as is without filters")),
 	OPT_STRING( 0 , "path", &vpath, N_("file"), N_("process file as it were from this path")),
 	OPT_END()
 };
diff --git a/builtin/log.c b/builtin/log.c
index 05e374d..1dafbd0 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1179,10 +1179,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'k', "keep-subject", &rev, NULL,
 			    N_("don't strip/add [PATCH]"),
 			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, keep_callback },
-		OPT_BOOLEAN(0, "no-binary", &no_binary_diff,
-			    N_("don't output binary diffs")),
-		OPT_BOOLEAN(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
-			    N_("don't include a patch matching a commit upstream")),
+		OPT_BOOL(0, "no-binary", &no_binary_diff,
+			 N_("don't output binary diffs")),
+		OPT_BOOL(0, "ignore-if-in-upstream", &ignore_if_in_upstream,
+			 N_("don't include a patch matching a commit upstream")),
 		{ OPTION_SET_INT, 'p', "no-stat", &use_patch_format, NULL,
 		  N_("show patch format instead of default (patch + stat)"),
 		  PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1},
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 5cf3e31..963ccc9 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -461,24 +461,24 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			N_("paths are separated with NUL character"),
 			PARSE_OPT_NOARG, option_parse_z },
-		OPT_BOOLEAN('t', NULL, &show_tag,
+		OPT_BOOL('t', NULL, &show_tag,
 			N_("identify the file status with tags")),
-		OPT_BOOLEAN('v', NULL, &show_valid_bit,
+		OPT_BOOL('v', NULL, &show_valid_bit,
 			N_("use lowercase letters for 'assume unchanged' files")),
-		OPT_BOOLEAN('c', "cached", &show_cached,
+		OPT_BOOL('c', "cached", &show_cached,
 			N_("show cached files in the output (default)")),
-		OPT_BOOLEAN('d', "deleted", &show_deleted,
+		OPT_BOOL('d', "deleted", &show_deleted,
 			N_("show deleted files in the output")),
-		OPT_BOOLEAN('m', "modified", &show_modified,
+		OPT_BOOL('m', "modified", &show_modified,
 			N_("show modified files in the output")),
-		OPT_BOOLEAN('o', "others", &show_others,
+		OPT_BOOL('o', "others", &show_others,
 			N_("show other files in the output")),
 		OPT_BIT('i', "ignored", &dir.flags,
 			N_("show ignored files in the output"),
 			DIR_SHOW_IGNORED),
-		OPT_BOOLEAN('s', "stage", &show_stage,
+		OPT_BOOL('s', "stage", &show_stage,
 			N_("show staged contents' object name in the output")),
-		OPT_BOOLEAN('k', "killed", &show_killed,
+		OPT_BOOL('k', "killed", &show_killed,
 			N_("show files on the filesystem that need to be removed")),
 		OPT_BIT(0, "directory", &dir.flags,
 			N_("show 'other' directories' name only"),
@@ -486,9 +486,9 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_NEGBIT(0, "empty-directory", &dir.flags,
 			N_("don't show empty directories"),
 			DIR_HIDE_EMPTY_DIRECTORIES),
-		OPT_BOOLEAN('u', "unmerged", &show_unmerged,
+		OPT_BOOL('u', "unmerged", &show_unmerged,
 			N_("show unmerged files in the output")),
-		OPT_BOOLEAN(0, "resolve-undo", &show_resolve_undo,
+		OPT_BOOL(0, "resolve-undo", &show_resolve_undo,
 			    N_("show resolve-undo information")),
 		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, N_("pattern"),
 			N_("skip files matching pattern"),
@@ -504,12 +504,12 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		{ OPTION_SET_INT, 0, "full-name", &prefix_len, NULL,
 			N_("make the output relative to the project top directory"),
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG, NULL },
-		OPT_BOOLEAN(0, "error-unmatch", &error_unmatch,
+		OPT_BOOL(0, "error-unmatch", &error_unmatch,
 			N_("if any <file> is not in the index, treat this as an error")),
 		OPT_STRING(0, "with-tree", &with_tree, N_("tree-ish"),
 			N_("pretend that paths removed since <tree-ish> are still present")),
 		OPT__ABBREV(&abbrev),
-		OPT_BOOLEAN(0, "debug", &debug_mode, N_("show debugging data")),
+		OPT_BOOL(0, "debug", &debug_mode, N_("show debugging data")),
 		OPT_END()
 	};
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index fb76e38..de88563 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -138,9 +138,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 			LS_NAME_ONLY),
 		OPT_SET_INT(0, "full-name", &chomp_prefix,
 			    N_("use full path names"), 0),
-		OPT_BOOLEAN(0, "full-tree", &full_tree,
-			    N_("list entire tree; not just current directory "
-			       "(implies --full-name)")),
+		OPT_BOOL(0, "full-tree", &full_tree,
+			 N_("list entire tree; not just current directory "
+			    "(implies --full-name)")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index 0c4cd2f..e88eb93 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -95,11 +95,11 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	int is_ancestor = 0;
 
 	struct option options[] = {
-		OPT_BOOLEAN('a', "all", &show_all, N_("output all common ancestors")),
-		OPT_BOOLEAN(0, "octopus", &octopus, N_("find ancestors for a single n-way merge")),
-		OPT_BOOLEAN(0, "independent", &reduce, N_("list revs not reachable from others")),
-		OPT_BOOLEAN(0, "is-ancestor", &is_ancestor,
-			    N_("is the first one ancestor of the other?")),
+		OPT_BOOL('a', "all", &show_all, N_("output all common ancestors")),
+		OPT_BOOL(0, "octopus", &octopus, N_("find ancestors for a single n-way merge")),
+		OPT_BOOL(0, "independent", &reduce, N_("list revs not reachable from others")),
+		OPT_BOOL(0, "is-ancestor", &is_ancestor,
+			 N_("is the first one ancestor of the other?")),
 		OPT_END()
 	};
 
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index c0570f2..844f84f 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -30,7 +30,7 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	int prefixlen = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('p', "stdout", &to_stdout, N_("send results to standard output")),
+		OPT_BOOL('p', "stdout", &to_stdout, N_("send results to standard output")),
 		OPT_SET_INT(0, "diff3", &xmp.style, N_("use a diff3 based merge"), XDL_MERGE_DIFF3),
 		OPT_SET_INT(0, "ours", &xmp.favor, N_("for conflicts, use our version"),
 			    XDL_MERGE_FAVOR_OURS),
diff --git a/builtin/merge.c b/builtin/merge.c
index 34a6166..a8cf4a2 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -197,15 +197,15 @@ static struct option builtin_merge_options[] = {
 	{ OPTION_CALLBACK, 'n', NULL, NULL, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG, option_parse_n },
-	OPT_BOOLEAN(0, "stat", &show_diffstat,
+	OPT_BOOL(0, "stat", &show_diffstat,
 		N_("show a diffstat at the end of the merge")),
-	OPT_BOOLEAN(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
+	OPT_BOOL(0, "summary", &show_diffstat, N_("(synonym to --stat)")),
 	{ OPTION_INTEGER, 0, "log", &shortlog_len, N_("n"),
 	  N_("add (at most <n>) entries from shortlog to merge commit message"),
 	  PARSE_OPT_OPTARG, NULL, DEFAULT_MERGE_LOG_LEN },
-	OPT_BOOLEAN(0, "squash", &squash,
+	OPT_BOOL(0, "squash", &squash,
 		N_("create a single commit instead of doing a merge")),
-	OPT_BOOLEAN(0, "commit", &option_commit,
+	OPT_BOOL(0, "commit", &option_commit,
 		N_("perform a commit if the merge succeeds (default)")),
 	OPT_BOOL('e', "edit", &option_edit,
 		N_("edit message before committing")),
@@ -224,12 +224,12 @@ static struct option builtin_merge_options[] = {
 		N_("merge commit message (for a non-fast-forward merge)"),
 		option_parse_message),
 	OPT__VERBOSITY(&verbosity),
-	OPT_BOOLEAN(0, "abort", &abort_current_merge,
+	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
 	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
-	OPT_BOOLEAN(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
+	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_END()
 };
 
diff --git a/builtin/mv.c b/builtin/mv.c
index 034fec9..be6fa77 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -62,7 +62,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&verbose, N_("be verbose")),
 		OPT__DRY_RUN(&show_only, N_("dry run")),
 		OPT__FORCE(&force, N_("force move/rename even if target exists")),
-		OPT_BOOLEAN('k', NULL, &ignore_errors, N_("skip move/rename errors")),
+		OPT_BOOL('k', NULL, &ignore_errors, N_("skip move/rename errors")),
 		OPT_END(),
 	};
 	const char **source, **destination, **dest_path;
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 0aaa19e..a908a34 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -310,15 +310,15 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, NULL };
 	struct option opts[] = {
-		OPT_BOOLEAN(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
-		OPT_BOOLEAN(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
+		OPT_BOOL(0, "name-only", &data.name_only, N_("print only names (no SHA-1)")),
+		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
 		OPT_STRING(0, "refs", &data.ref_filter, N_("pattern"),
 				   N_("only use refs matching <pattern>")),
 		OPT_GROUP(""),
-		OPT_BOOLEAN(0, "all", &all, N_("list all commits reachable from all refs")),
-		OPT_BOOLEAN(0, "stdin", &transform_stdin, N_("read from stdin")),
-		OPT_BOOLEAN(0, "undefined", &allow_undefined, N_("allow to print `undefined` names")),
-		OPT_BOOLEAN(0, "always",     &always,
+		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
+		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),
+		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
+		OPT_BOOL(0, "always",     &always,
 			   N_("show abbreviated commit object as fallback")),
 		{
 			/* A Hidden OPT_BOOL */
diff --git a/builtin/notes.c b/builtin/notes.c
index 8f63cb2..d459e23 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -483,7 +483,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 	const char *rewrite_cmd = NULL;
 	struct option options[] = {
 		OPT__FORCE(&force, N_("replace existing notes")),
-		OPT_BOOLEAN(0, "stdin", &from_stdin, N_("read objects from stdin")),
+		OPT_BOOL(0, "stdin", &from_stdin, N_("read objects from stdin")),
 		OPT_STRING(0, "for-rewrite", &rewrite_cmd, N_("command"),
 			   N_("load rewriting config for <command> (implies "
 			      "--stdin)")),
@@ -853,7 +853,7 @@ static int remove_cmd(int argc, const char **argv, const char *prefix)
 		OPT_BIT(0, "ignore-missing", &flag,
 			N_("attempt to remove non-existent note is not an error"),
 			IGNORE_MISSING),
-		OPT_BOOLEAN(0, "stdin", &from_stdin,
+		OPT_BOOL(0, "stdin", &from_stdin,
 			    N_("read object names from the standard input")),
 		OPT_END()
 	};
diff --git a/builtin/push.c b/builtin/push.c
index 6d36c24..bebaf3d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -446,15 +446,15 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "all", &flags, N_("push all refs"), TRANSPORT_PUSH_ALL),
 		OPT_BIT( 0 , "mirror", &flags, N_("mirror all refs"),
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
-		OPT_BOOLEAN( 0, "delete", &deleterefs, N_("delete refs")),
-		OPT_BOOLEAN( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
+		OPT_BOOL( 0, "delete", &deleterefs, N_("delete refs")),
+		OPT_BOOL( 0 , "tags", &tags, N_("push tags (can't be used with --all or --mirror)")),
 		OPT_BIT('n' , "dry-run", &flags, N_("dry run"), TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, N_("machine-readable output"), TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, N_("force updates"), TRANSPORT_PUSH_FORCE),
 		{ OPTION_CALLBACK, 0, "recurse-submodules", &flags, N_("check"),
 			N_("control recursive pushing of submodules"),
 			PARSE_OPT_OPTARG, option_parse_recurse_submodules },
-		OPT_BOOLEAN( 0 , "thin", &thin, N_("use thin pack")),
+		OPT_BOOL( 0 , "thin", &thin, N_("use thin pack")),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", N_("receive pack program")),
 		OPT_BIT('u', "set-upstream", &flags, N_("set upstream for git pull/status"),
diff --git a/builtin/remote.c b/builtin/remote.c
index 5e54d36..eaac3e2 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -160,7 +160,7 @@ static int add(int argc, const char **argv)
 	int i;
 
 	struct option options[] = {
-		OPT_BOOLEAN('f', "fetch", &fetch, N_("fetch the remote branches")),
+		OPT_BOOL('f', "fetch", &fetch, N_("fetch the remote branches")),
 		OPT_SET_INT(0, "tags", &fetch_tags,
 			    N_("import all tags and associated objects when fetching"),
 			    TAGS_SET),
@@ -1088,7 +1088,7 @@ static int show(int argc, const char **argv)
 {
 	int no_query = 0, result = 0, query_flag = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('n', NULL, &no_query, N_("do not query remotes")),
+		OPT_BOOL('n', NULL, &no_query, N_("do not query remotes")),
 		OPT_END()
 	};
 	struct ref_states states;
@@ -1195,10 +1195,10 @@ static int set_head(int argc, const char **argv)
 	char *head_name = NULL;
 
 	struct option options[] = {
-		OPT_BOOLEAN('a', "auto", &opt_a,
-			    N_("set refs/remotes/<name>/HEAD according to remote")),
-		OPT_BOOLEAN('d', "delete", &opt_d,
-			    N_("delete refs/remotes/<name>/HEAD")),
+		OPT_BOOL('a', "auto", &opt_a,
+			 N_("set refs/remotes/<name>/HEAD according to remote")),
+		OPT_BOOL('d', "delete", &opt_d,
+			 N_("delete refs/remotes/<name>/HEAD")),
 		OPT_END()
 	};
 	argc = parse_options(argc, argv, NULL, options, builtin_remote_sethead_usage,
@@ -1317,8 +1317,8 @@ static int update(int argc, const char **argv)
 {
 	int i, prune = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('p', "prune", &prune,
-			    N_("prune remotes after fetching")),
+		OPT_BOOL('p', "prune", &prune,
+			 N_("prune remotes after fetching")),
 		OPT_END()
 	};
 	const char **fetch_argv;
@@ -1404,7 +1404,7 @@ static int set_branches(int argc, const char **argv)
 {
 	int add_mode = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('\0', "add", &add_mode, N_("add branch")),
+		OPT_BOOL('\0', "add", &add_mode, N_("add branch")),
 		OPT_END()
 	};
 
@@ -1432,11 +1432,11 @@ static int set_url(int argc, const char **argv)
 	int urlset_nr;
 	struct strbuf name_buf = STRBUF_INIT;
 	struct option options[] = {
-		OPT_BOOLEAN('\0', "push", &push_mode,
-			    N_("manipulate push URLs")),
-		OPT_BOOLEAN('\0', "add", &add_mode,
-			    N_("add URL")),
-		OPT_BOOLEAN('\0', "delete", &delete_mode,
+		OPT_BOOL('\0', "push", &push_mode,
+			 N_("manipulate push URLs")),
+		OPT_BOOL('\0', "add", &add_mode,
+			 N_("add URL")),
+		OPT_BOOL('\0', "delete", &delete_mode,
 			    N_("delete URLs")),
 		OPT_END()
 	};
diff --git a/builtin/replace.c b/builtin/replace.c
index 59d3115..11b0a55 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -118,9 +118,9 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
 {
 	int list = 0, delete = 0, force = 0;
 	struct option options[] = {
-		OPT_BOOLEAN('l', NULL, &list, N_("list replace refs")),
-		OPT_BOOLEAN('d', NULL, &delete, N_("delete replace refs")),
-		OPT_BOOLEAN('f', NULL, &force, N_("replace the ref if it exists")),
+		OPT_BOOL('l', NULL, &list, N_("list replace refs")),
+		OPT_BOOL('d', NULL, &delete, N_("delete replace refs")),
+		OPT_BOOL('f', NULL, &force, N_("replace the ref if it exists")),
 		OPT_END()
 	};
 
diff --git a/builtin/reset.c b/builtin/reset.c
index afa6e02..0905815 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -258,7 +258,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
 				N_("reset HEAD, index and working tree"), MERGE),
 		OPT_SET_INT(0, "keep", &reset_type,
 				N_("reset HEAD but keep local changes"), KEEP),
-		OPT_BOOLEAN('p', "patch", &patch_mode, N_("select hunks interactively")),
+		OPT_BOOL('p', "patch", &patch_mode, N_("select hunks interactively")),
 		OPT_END()
 	};
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index de894c7..67e8ccf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -346,9 +346,9 @@ static int cmd_parseopt(int argc, const char **argv, const char *prefix)
 		NULL
 	};
 	static struct option parseopt_opts[] = {
-		OPT_BOOLEAN(0, "keep-dashdash", &keep_dashdash,
+		OPT_BOOL(0, "keep-dashdash", &keep_dashdash,
 					N_("keep the `--` passed as an arg")),
-		OPT_BOOLEAN(0, "stop-at-non-option", &stop_at_non_option,
+		OPT_BOOL(0, "stop-at-non-option", &stop_at_non_option,
 					N_("stop parsing after the "
 					   "first non-option argument")),
 		OPT_END(),
diff --git a/builtin/rm.c b/builtin/rm.c
index 18916e0..ce28fa9 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -268,10 +268,10 @@ static int ignore_unmatch = 0;
 static struct option builtin_rm_options[] = {
 	OPT__DRY_RUN(&show_only, N_("dry run")),
 	OPT__QUIET(&quiet, N_("do not list removed files")),
-	OPT_BOOLEAN( 0 , "cached",         &index_only, N_("only remove from the index")),
+	OPT_BOOL( 0 , "cached",         &index_only, N_("only remove from the index")),
 	OPT__FORCE(&force, N_("override the up-to-date check")),
-	OPT_BOOLEAN('r', NULL,             &recursive,  N_("allow recursive removal")),
-	OPT_BOOLEAN( 0 , "ignore-unmatch", &ignore_unmatch,
+	OPT_BOOL('r', NULL,             &recursive,  N_("allow recursive removal")),
+	OPT_BOOL( 0 , "ignore-unmatch", &ignore_unmatch,
 				N_("exit with a zero status even if nothing matched")),
 	OPT_END(),
 };
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1434f8f..ae73d17 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -224,12 +224,12 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	int nongit = !startup_info->have_repository;
 
 	static const struct option options[] = {
-		OPT_BOOLEAN('n', "numbered", &log.sort_by_number,
-			    N_("sort output according to the number of commits per author")),
-		OPT_BOOLEAN('s', "summary", &log.summary,
-			    N_("Suppress commit descriptions, only provides commit count")),
-		OPT_BOOLEAN('e', "email", &log.email,
-			    N_("Show the email address of each author")),
+		OPT_BOOL('n', "numbered", &log.sort_by_number,
+			 N_("sort output according to the number of commits per author")),
+		OPT_BOOL('s', "summary", &log.summary,
+			 N_("Suppress commit descriptions, only provides commit count")),
+		OPT_BOOL('e', "email", &log.email,
+			 N_("Show the email address of each author")),
 		{ OPTION_CALLBACK, 'w', NULL, &log, N_("w[,i1[,i2]]"),
 			N_("Linewrap output"), PARSE_OPT_OPTARG, &parse_wrap_args },
 		OPT_END(),
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 9788eb1..001f29c 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -646,30 +646,30 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 	int dense = 1;
 	const char *reflog_base = NULL;
 	struct option builtin_show_branch_options[] = {
-		OPT_BOOLEAN('a', "all", &all_heads,
-			    N_("show remote-tracking and local branches")),
-		OPT_BOOLEAN('r', "remotes", &all_remotes,
-			    N_("show remote-tracking branches")),
+		OPT_BOOL('a', "all", &all_heads,
+			 N_("show remote-tracking and local branches")),
+		OPT_BOOL('r', "remotes", &all_remotes,
+			 N_("show remote-tracking branches")),
 		OPT__COLOR(&showbranch_use_color,
 			    N_("color '*!+-' corresponding to the branch")),
 		{ OPTION_INTEGER, 0, "more", &extra, N_("n"),
 			    N_("show <n> more commits after the common ancestor"),
 			    PARSE_OPT_OPTARG, NULL, (intptr_t)1 },
 		OPT_SET_INT(0, "list", &extra, N_("synonym to more=-1"), -1),
-		OPT_BOOLEAN(0, "no-name", &no_name, N_("suppress naming strings")),
-		OPT_BOOLEAN(0, "current", &with_current_branch,
-			    N_("include the current branch")),
-		OPT_BOOLEAN(0, "sha1-name", &sha1_name,
-			    N_("name commits with their object names")),
-		OPT_BOOLEAN(0, "merge-base", &merge_base,
-			    N_("show possible merge bases")),
-		OPT_BOOLEAN(0, "independent", &independent,
+		OPT_BOOL(0, "no-name", &no_name, N_("suppress naming strings")),
+		OPT_BOOL(0, "current", &with_current_branch,
+			 N_("include the current branch")),
+		OPT_BOOL(0, "sha1-name", &sha1_name,
+			 N_("name commits with their object names")),
+		OPT_BOOL(0, "merge-base", &merge_base,
+			 N_("show possible merge bases")),
+		OPT_BOOL(0, "independent", &independent,
 			    N_("show refs unreachable from any other ref")),
 		OPT_SET_INT(0, "topo-order", &sort_order,
 			    N_("show commits in topological order"),
 			    REV_SORT_IN_GRAPH_ORDER),
-		OPT_BOOLEAN(0, "topics", &topics,
-			    N_("show only commits not on the first branch")),
+		OPT_BOOL(0, "topics", &topics,
+			 N_("show only commits not on the first branch")),
 		OPT_SET_INT(0, "sparse", &dense,
 			    N_("show merges reachable from only one tip"), 0),
 		OPT_SET_INT(0, "date-order", &sort_order,
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 18680bb..9f3f5e3 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -165,15 +165,15 @@ static int help_callback(const struct option *opt, const char *arg, int unset)
 }
 
 static const struct option show_ref_options[] = {
-	OPT_BOOLEAN(0, "tags", &tags_only, N_("only show tags (can be combined with heads)")),
-	OPT_BOOLEAN(0, "heads", &heads_only, N_("only show heads (can be combined with tags)")),
-	OPT_BOOLEAN(0, "verify", &verify, N_("stricter reference checking, "
+	OPT_BOOL(0, "tags", &tags_only, N_("only show tags (can be combined with heads)")),
+	OPT_BOOL(0, "heads", &heads_only, N_("only show heads (can be combined with tags)")),
+	OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 		    "requires exact ref path")),
 	OPT_HIDDEN_BOOL('h', NULL, &show_head,
 			N_("show the HEAD reference, even if it would be filtered out")),
-	OPT_BOOLEAN(0, "head", &show_head,
+	OPT_BOOL(0, "head", &show_head,
 	  N_("show the HEAD reference, even if it would be filtered out")),
-	OPT_BOOLEAN('d', "dereference", &deref_tags,
+	OPT_BOOL('d', "dereference", &deref_tags,
 		    N_("dereference tags into object IDs")),
 	{ OPTION_CALLBACK, 's', "hash", &abbrev, N_("n"),
 	  N_("only show SHA1 hash using <n> digits"),
diff --git a/builtin/tag.c b/builtin/tag.c
index d8ae5aa..b577af5 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -450,12 +450,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_CMDMODE('v', "verify", &cmdmode, N_("verify tags"), 'v'),
 
 		OPT_GROUP(N_("Tag creation options")),
-		OPT_BOOLEAN('a', "annotate", &annotate,
+		OPT_BOOL('a', "annotate", &annotate,
 					N_("annotated tag, needs a message")),
 		OPT_CALLBACK('m', "message", &msg, N_("message"),
 			     N_("tag message"), parse_msg_arg),
 		OPT_FILENAME('F', "file", &msgfile, N_("read message from file")),
-		OPT_BOOLEAN('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
+		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
 			N_("how to strip spaces and #comments from message")),
 		OPT_STRING('u', "local-user", &keyid, N_("key id"),
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 51d2684..7484d36 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -16,8 +16,8 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
 	int delete = 0, no_deref = 0, flags = 0;
 	struct option options[] = {
 		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
-		OPT_BOOLEAN('d', NULL, &delete, N_("delete the reference")),
-		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
+		OPT_BOOL('d', NULL, &delete, N_("delete the reference")),
+		OPT_BOOL( 0 , "no-deref", &no_deref,
 					N_("update <refname> not the one it points to")),
 		OPT_END(),
 	};
-- 
1.8.4.rc0.16.g7fca822.dirty
