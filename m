From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [patch 04/16] Without this patch at least IBM VisualAge C 5.0 (I have 5.0.2) on AIX 5.1 fails to compile git.
Date: Tue, 27 Apr 2010 13:57:12 +0000
Message-ID: <20100427135823.017417000@mlists.thewrittenword.com>
References: <20100427135708.258636000@mlists.thewrittenword.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 27 15:58:57 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6lJR-0002hJ-2q
	for gcvg-git-2@lo.gmane.org; Tue, 27 Apr 2010 15:58:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753491Ab0D0N6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Apr 2010 09:58:25 -0400
Received: from mail1.thewrittenword.com ([69.67.212.77]:61680 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755801Ab0D0N6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Apr 2010 09:58:24 -0400
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 06D755CD7
	for <git@vger.kernel.org>; Tue, 27 Apr 2010 14:19:31 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 06D755CD7
Received: from akari.il.thewrittenword.com (akari.il.thewrittenword.com [10.191.57.57])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id 4A2D2ADA;
	Tue, 27 Apr 2010 13:58:23 +0000 (UTC)
Received: by akari.il.thewrittenword.com (Postfix, from userid 1048)
	id 2C6DA11D4D1; Tue, 27 Apr 2010 13:58:23 +0000 (UTC)
User-Agent: quilt/0.46-1
Content-Disposition: inline; filename=enum-dangling-comma.patch
X-Virus-Scanned: clamav-milter 0.96 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145906>

enum style is inconsistent already, with some enums declared on one
line, some over 3 lines with the enum values all on the middle line,
sometimes with 1 enum value per line... and independently of that the
trailing comma is sometimes present and other times absent, often
mixing with/without trailing comma styles in a single file, and
sometimes in consecutive enum declarations.

Clearly, omitting the comma is the more portable style, and this patch
changes all enum declarations to use the portable omitted dangling
comma style consistently.
---
 attr.h                 |    2 +-
 builtin/apply.c        |    4 ++--
 builtin/branch.c       |    4 ++--
 builtin/commit.c       |    6 +++---
 builtin/help.c         |    2 +-
 builtin/mailinfo.c     |    4 ++--
 builtin/receive-pack.c |    2 +-
 builtin/remote.c       |    2 +-
 cache.h                |   16 ++++++++--------
 commit.h               |    2 +-
 connect.c              |    2 +-
 ctype.c                |    2 +-
 diff.h                 |    2 +-
 dir.c                  |    6 +++---
 fast-import.c          |    2 +-
 grep.h                 |    8 ++++----
 http-push.c            |    2 +-
 http-walker.c          |    2 +-
 imap-send.c            |    2 +-
 merge-recursive.h      |    2 +-
 parse-options.h        |    6 +++---
 pretty.c               |    2 +-
 remote.h               |    2 +-
 rerere.c               |    2 +-
 revision.c             |    2 +-
 wt-status.h            |    2 +-
 26 files changed, 45 insertions(+), 45 deletions(-)

Index: b/attr.h
===================================================================
--- a/attr.h
+++ b/attr.h
@@ -34,7 +34,7 @@ int git_checkattr(const char *path, int,
 enum git_attr_direction {
 	GIT_ATTR_CHECKIN,
 	GIT_ATTR_CHECKOUT,
-	GIT_ATTR_INDEX,
+	GIT_ATTR_INDEX
 };
 void git_attr_set_direction(enum git_attr_direction, struct index_state *);
 
Index: b/builtin/apply.c
===================================================================
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -56,7 +56,7 @@ static enum ws_error_action {
 	nowarn_ws_error,
 	warn_on_ws_error,
 	die_on_ws_error,
-	correct_ws_error,
+	correct_ws_error
 } ws_error_action = warn_on_ws_error;
 static int whitespace_error;
 static int squelch_whitespace_errors = 5;
@@ -64,7 +64,7 @@ static int applied_after_fixing_ws;
 
 static enum ws_ignore {
 	ignore_ws_none,
-	ignore_ws_change,
+	ignore_ws_change
 } ws_ignore_action = ignore_ws_none;
 
 
Index: b/builtin/branch.c
===================================================================
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -43,13 +43,13 @@ enum color_branch {
 	BRANCH_COLOR_PLAIN = 1,
 	BRANCH_COLOR_REMOTE = 2,
 	BRANCH_COLOR_LOCAL = 3,
-	BRANCH_COLOR_CURRENT = 4,
+	BRANCH_COLOR_CURRENT = 4
 };
 
 static enum merge_filter {
 	NO_FILTER = 0,
 	SHOW_NOT_MERGED,
-	SHOW_MERGED,
+	SHOW_MERGED
 } merge_filter;
 static unsigned char merge_filter_ref[20];
 
Index: b/builtin/commit.c
===================================================================
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -57,7 +57,7 @@ static struct lock_file false_lock; /* u
 static enum {
 	COMMIT_AS_IS = 1,
 	COMMIT_NORMAL,
-	COMMIT_PARTIAL,
+	COMMIT_PARTIAL
 } commit_style;
 
 static const char *logfile, *force_author;
@@ -78,7 +78,7 @@ static char *untracked_files_arg, *force
 static enum {
 	CLEANUP_SPACE,
 	CLEANUP_NONE,
-	CLEANUP_ALL,
+	CLEANUP_ALL
 } cleanup_mode;
 static char *cleanup_arg;
 
@@ -90,7 +90,7 @@ static int null_termination;
 static enum {
 	STATUS_FORMAT_LONG,
 	STATUS_FORMAT_SHORT,
-	STATUS_FORMAT_PORCELAIN,
+	STATUS_FORMAT_PORCELAIN
 } status_format = STATUS_FORMAT_LONG;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
Index: b/builtin/help.c
===================================================================
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -26,7 +26,7 @@ enum help_format {
 	HELP_FORMAT_NONE,
 	HELP_FORMAT_MAN,
 	HELP_FORMAT_INFO,
-	HELP_FORMAT_WEB,
+	HELP_FORMAT_WEB
 };
 
 static int show_all = 0;
Index: b/builtin/mailinfo.c
===================================================================
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -17,10 +17,10 @@ static struct strbuf name = STRBUF_INIT;
 static struct strbuf email = STRBUF_INIT;
 
 static enum  {
-	TE_DONTCARE, TE_QP, TE_BASE64,
+	TE_DONTCARE, TE_QP, TE_BASE64
 } transfer_encoding;
 static enum  {
-	TYPE_TEXT, TYPE_OTHER,
+	TYPE_TEXT, TYPE_OTHER
 } message_type;
 
 static struct strbuf charset = STRBUF_INIT;
Index: b/builtin/receive-pack.c
===================================================================
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -16,7 +16,7 @@ enum deny_action {
 	DENY_UNCONFIGURED,
 	DENY_IGNORE,
 	DENY_WARN,
-	DENY_REFUSE,
+	DENY_REFUSE
 };
 
 static int deny_deletes;
Index: b/builtin/remote.c
===================================================================
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -317,7 +317,7 @@ struct push_info {
 		PUSH_STATUS_UPTODATE,
 		PUSH_STATUS_FASTFORWARD,
 		PUSH_STATUS_OUTOFDATE,
-		PUSH_STATUS_NOTQUERIED,
+		PUSH_STATUS_NOTQUERIED
 	} status;
 };
 
Index: b/cache.h
===================================================================
--- a/cache.h
+++ b/cache.h
@@ -361,7 +361,7 @@ enum object_type {
 	OBJ_OFS_DELTA = 6,
 	OBJ_REF_DELTA = 7,
 	OBJ_ANY,
-	OBJ_MAX,
+	OBJ_MAX
 };
 
 static inline enum object_type object_type(unsigned int mode)
@@ -556,7 +556,7 @@ extern int core_apply_sparse_checkout;
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2,
+	SAFE_CRLF_WARN = 2
 };
 
 extern enum safe_crlf safe_crlf;
@@ -567,21 +567,21 @@ enum branch_track {
 	BRANCH_TRACK_REMOTE,
 	BRANCH_TRACK_ALWAYS,
 	BRANCH_TRACK_EXPLICIT,
-	BRANCH_TRACK_OVERRIDE,
+	BRANCH_TRACK_OVERRIDE
 };
 
 enum rebase_setup_type {
 	AUTOREBASE_NEVER = 0,
 	AUTOREBASE_LOCAL,
 	AUTOREBASE_REMOTE,
-	AUTOREBASE_ALWAYS,
+	AUTOREBASE_ALWAYS
 };
 
 enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
 	PUSH_DEFAULT_TRACKING,
-	PUSH_DEFAULT_CURRENT,
+	PUSH_DEFAULT_CURRENT
 };
 
 extern enum branch_track git_branch_track;
@@ -590,7 +590,7 @@ extern enum push_default_type push_defau
 
 enum object_creation_mode {
 	OBJECT_CREATION_USES_HARDLINKS = 0,
-	OBJECT_CREATION_USES_RENAMES = 1,
+	OBJECT_CREATION_USES_RENAMES = 1
 };
 
 extern enum object_creation_mode object_creation_mode;
@@ -670,7 +670,7 @@ enum sharedrepo {
 	OLD_PERM_GROUP      = 1,
 	OLD_PERM_EVERYBODY  = 2,
 	PERM_GROUP          = 0660,
-	PERM_EVERYBODY      = 0664,
+	PERM_EVERYBODY      = 0664
 };
 int git_config_perm(const char *var, const char *value);
 int set_shared_perm(const char *path, int mode);
@@ -880,7 +880,7 @@ struct ref {
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
-		REF_STATUS_EXPECTING_REPORT,
+		REF_STATUS_EXPECTING_REPORT
 	} status;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
Index: b/commit.h
===================================================================
--- a/commit.h
+++ b/commit.h
@@ -60,7 +60,7 @@ enum cmit_fmt {
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_USERFORMAT,
 
-	CMIT_FMT_UNSPECIFIED,
+	CMIT_FMT_UNSPECIFIED
 };
 
 struct pretty_print_context
Index: b/connect.c
===================================================================
--- a/connect.c
+++ b/connect.c
@@ -131,7 +131,7 @@ int path_match(const char *path, int nr,
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
-	PROTO_GIT,
+	PROTO_GIT
 };
 
 static enum protocol get_protocol(const char *name)
Index: b/ctype.c
===================================================================
--- a/ctype.c
+++ b/ctype.c
@@ -10,7 +10,7 @@ enum {
 	A = GIT_ALPHA,
 	D = GIT_DIGIT,
 	G = GIT_GLOB_SPECIAL,	/* *, ?, [, \\ */
-	R = GIT_REGEX_SPECIAL,	/* $, (, ), +, ., ^, {, | */
+	R = GIT_REGEX_SPECIAL	/* $, (, ), +, ., ^, {, | */
 };
 
 unsigned char sane_ctype[256] = {
Index: b/diff.h
===================================================================
--- a/diff.h
+++ b/diff.h
@@ -133,7 +133,7 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8,
+	DIFF_FUNCINFO = 8
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
Index: b/dir.c
===================================================================
--- a/dir.c
+++ b/dir.c
@@ -465,7 +465,7 @@ static struct dir_entry *dir_add_ignored
 enum exist_status {
 	index_nonexistent = 0,
 	index_directory,
-	index_gitdir,
+	index_gitdir
 };
 
 /*
@@ -533,7 +533,7 @@ static enum exist_status directory_exist
 enum directory_treatment {
 	show_directory,
 	ignore_directory,
-	recurse_into_directory,
+	recurse_into_directory
 };
 
 static enum directory_treatment treat_directory(struct dir_struct *dir,
@@ -684,7 +684,7 @@ static int get_dtype(struct dirent *de, 
 enum path_treatment {
 	path_ignored,
 	path_handled,
-	path_recurse,
+	path_recurse
 };
 
 static enum path_treatment treat_one_path(struct dir_struct *dir,
Index: b/fast-import.c
===================================================================
--- a/fast-import.c
+++ b/fast-import.c
@@ -267,7 +267,7 @@ struct hash_list
 typedef enum {
 	WHENSPEC_RAW = 1,
 	WHENSPEC_RFC2822,
-	WHENSPEC_NOW,
+	WHENSPEC_NOW
 } whenspec_type;
 
 struct recent_command
Index: b/grep.h
===================================================================
--- a/grep.h
+++ b/grep.h
@@ -10,17 +10,17 @@ enum grep_pat_token {
 	GREP_OPEN_PAREN,
 	GREP_CLOSE_PAREN,
 	GREP_NOT,
-	GREP_OR,
+	GREP_OR
 };
 
 enum grep_context {
 	GREP_CONTEXT_HEAD,
-	GREP_CONTEXT_BODY,
+	GREP_CONTEXT_BODY
 };
 
 enum grep_header_field {
 	GREP_HEADER_AUTHOR = 0,
-	GREP_HEADER_COMMITTER,
+	GREP_HEADER_COMMITTER
 };
 
 struct grep_pat {
@@ -40,7 +40,7 @@ enum grep_expr_node {
 	GREP_NODE_ATOM,
 	GREP_NODE_NOT,
 	GREP_NODE_AND,
-	GREP_NODE_OR,
+	GREP_NODE_OR
 };
 
 struct grep_expr {
Index: b/http-push.c
===================================================================
--- a/http-push.c
+++ b/http-push.c
@@ -105,7 +105,7 @@ enum transfer_state {
 	RUN_PUT,
 	RUN_MOVE,
 	ABORTED,
-	COMPLETE,
+	COMPLETE
 };
 
 struct transfer_request
Index: b/http-walker.c
===================================================================
--- a/http-walker.c
+++ b/http-walker.c
@@ -15,7 +15,7 @@ enum object_request_state {
 	WAITING,
 	ABORTED,
 	ACTIVE,
-	COMPLETE,
+	COMPLETE
 };
 
 struct object_request
Index: b/imap-send.c
===================================================================
--- a/imap-send.c
+++ b/imap-send.c
@@ -230,7 +230,7 @@ enum CAPABILITY {
 	LITERALPLUS,
 	NAMESPACE,
 	STARTTLS,
-	AUTH_CRAM_MD5,
+	AUTH_CRAM_MD5
 };
 
 static const char *cap_list[] = {
Index: b/merge-recursive.h
===================================================================
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -10,7 +10,7 @@ struct merge_options {
 	enum {
 		MERGE_RECURSIVE_NORMAL = 0,
 		MERGE_RECURSIVE_OURS,
-		MERGE_RECURSIVE_THEIRS,
+		MERGE_RECURSIVE_THEIRS
 	} recursive_variant;
 	const char *subtree_shift;
 	unsigned buffer_output : 1;
Index: b/parse-options.h
===================================================================
--- a/parse-options.h
+++ b/parse-options.h
@@ -25,7 +25,7 @@ enum parse_opt_flags {
 	PARSE_OPT_STOP_AT_NON_OPTION = 2,
 	PARSE_OPT_KEEP_ARGV0 = 4,
 	PARSE_OPT_KEEP_UNKNOWN = 8,
-	PARSE_OPT_NO_INTERNAL_HELP = 16,
+	PARSE_OPT_NO_INTERNAL_HELP = 16
 };
 
 enum parse_opt_option_flags {
@@ -36,7 +36,7 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_NEGHELP = 128,
+	PARSE_OPT_NEGHELP = 128
 };
 
 struct option;
@@ -160,7 +160,7 @@ extern NORETURN void usage_msg_opt(const
 enum {
 	PARSE_OPT_HELP = -1,
 	PARSE_OPT_DONE,
-	PARSE_OPT_UNKNOWN,
+	PARSE_OPT_UNKNOWN
 };
 
 /*
Index: b/pretty.c
===================================================================
--- a/pretty.c
+++ b/pretty.c
@@ -828,7 +828,7 @@ static size_t format_commit_item(struct 
 	enum {
 		NO_MAGIC,
 		ADD_LF_BEFORE_NON_EMPTY,
-		DEL_LF_BEFORE_EMPTY,
+		DEL_LF_BEFORE_EMPTY
 	} magic = NO_MAGIC;
 
 	switch (placeholder[0]) {
Index: b/remote.h
===================================================================
--- a/remote.h
+++ b/remote.h
@@ -145,7 +145,7 @@ int branch_merge_matches(struct branch *
 enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
 	MATCH_REFS_ALL 		= (1 << 0),
-	MATCH_REFS_MIRROR	= (1 << 1),
+	MATCH_REFS_MIRROR	= (1 << 1)
 };
 
 /* Reporting of tracking info */
Index: b/rerere.c
===================================================================
--- a/rerere.c
+++ b/rerere.c
@@ -153,7 +153,7 @@ static int handle_path(unsigned char *sh
 	git_SHA_CTX ctx;
 	int hunk_no = 0;
 	enum {
-		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL,
+		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL
 	} hunk = RR_CONTEXT;
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
Index: b/revision.c
===================================================================
--- a/revision.c
+++ b/revision.c
@@ -1781,7 +1781,7 @@ int prepare_revision_walk(struct rev_inf
 enum rewrite_result {
 	rewrite_one_ok,
 	rewrite_one_noparents,
-	rewrite_one_error,
+	rewrite_one_error
 };
 
 static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
Index: b/wt-status.h
===================================================================
--- a/wt-status.h
+++ b/wt-status.h
@@ -11,7 +11,7 @@ enum color_wt_status {
 	WT_STATUS_CHANGED,
 	WT_STATUS_UNTRACKED,
 	WT_STATUS_NOBRANCH,
-	WT_STATUS_UNMERGED,
+	WT_STATUS_UNMERGED
 };
 
 enum untracked_status_type {

-- 
Gary V. Vaughan (gary@thewrittenword.com)
