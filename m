From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH 1/4] Replace deprecated OPT_BOOLEAN by OPT_BOOL
Date: Mon, 29 Jul 2013 21:49:55 +0200
Message-ID: <1375127398-31904-2-git-send-email-stefanbeller@googlemail.com>
References: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 29 21:49:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3tSA-00015L-4C
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 21:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754177Ab3G2Ttw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 15:49:52 -0400
Received: from mail-wg0-f47.google.com ([74.125.82.47]:51976 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3G2Ttt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 15:49:49 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so5201679wgh.26
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 12:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=g9Le7isGnOBlukmyqEUPHQvAYjzmKrz7Qc114QGONgM=;
        b=rqHo45/wnmkJiq/8okzdhIlBxcSeujExKno14RH7JFHWZE0JmnNvx3ZWheFFtxe0Hp
         P4YKNoPdGoDbADkPye+oSnqx1LcUKspnhroB3SMUQ/oLvoLufmG9Hhh/q8FlUFwJoS6Z
         D4WeEXudUbdXknWnTJFIrVAO0hnjgcvpd9o/3RoIYqPtS+TjwjqRHPrdI47snqZx5Izn
         3YaOLLtVQcTJWDfEwtjN8w+aGf4g4nJ8FkD+Gxtr1GIHXI0Aa+3n7VBbLFi/gBWEwkez
         5PamDVHeEDIRnLKk2RnhJ5uxjl6NSvXV8l/uXOzXXPFSnAOVQI4GUKkY9QI8gPxipuiL
         wtiw==
X-Received: by 10.194.103.73 with SMTP id fu9mr43925852wjb.70.1375127388244;
        Mon, 29 Jul 2013 12:49:48 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id o10sm24786952wiz.5.2013.07.29.12.49.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 12:49:47 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc0.1.g8f6a3e5
In-Reply-To: <1375127398-31904-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231324>

This task emerged from b04ba2bb4.
All occurrences of the respective variables have been reviewed and none
of them relied on the counting up mechanism, but all of them were
using the variable as a true boolean.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 builtin/check-attr.c |  8 ++++----
 builtin/checkout.c   | 10 +++++-----
 builtin/clone.c      | 16 ++++++++--------
 builtin/fsck.c       | 16 ++++++++--------
 builtin/grep.c       | 36 ++++++++++++++++++------------------
 builtin/log.c        | 12 ++++++------
 builtin/ls-tree.c    |  6 +++---
 builtin/merge-file.c |  2 +-
 builtin/merge.c      | 12 ++++++------
 builtin/mv.c         |  2 +-
 builtin/name-rev.c   | 12 ++++++------
 builtin/notes.c      |  4 ++--
 builtin/replace.c    |  6 +++---
 builtin/reset.c      |  2 +-
 builtin/rev-parse.c  |  4 ++--
 15 files changed, 74 insertions(+), 74 deletions(-)

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
diff --git a/builtin/grep.c b/builtin/grep.c
index d3b3b1d..03c2e93 100644
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
 		OPT_BOOLEAN('c', "count", &opt.count,
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
diff --git a/builtin/log.c b/builtin/log.c
index 05e374d..9b6c910 100644
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
@@ -1210,8 +1210,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
-		OPT_BOOLEAN(0, "quiet", &quiet,
-			    N_("don't print the patch filenames")),
+		OPT_BOOL(0, "quiet", &quiet,
+			 N_("don't print the patch filenames")),
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
-- 
1.8.4.rc0.1.g8f6a3e5
