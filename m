From: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
Subject: [PATCH 3/5] Dangling commas in enum is not portable (resend)
Date: Thu, 11 Mar 2010 16:32:35 +0000
Message-ID: <20100311163235.GC7877@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 11 17:32:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NplJd-0003C8-Kf
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 17:32:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933223Ab0CKQci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 11:32:38 -0500
Received: from mail1.thewrittenword.com ([69.67.212.77]:53235 "EHLO
	mail1.thewrittenword.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933209Ab0CKQcg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 11:32:36 -0500
Received: from mail1.il.thewrittenword.com (emma-internal-gw.il.thewrittenword.com [192.168.13.25])
	by mail1.thewrittenword.com (Postfix) with ESMTP id 5B1975CC5
	for <git@vger.kernel.org>; Thu, 11 Mar 2010 16:51:46 +0000 (UTC)
X-DKIM: Sendmail DKIM Filter v2.4.4 mail1.thewrittenword.com 5B1975CC5
Received: from thor.il.thewrittenword.com (thor.il.thewrittenword.com [10.191.57.1])
	by mail1.il.thewrittenword.com (Postfix) with ESMTP id BECD1D72
	for <git@vger.kernel.org>; Thu, 11 Mar 2010 16:32:35 +0000 (UTC)
Received: by thor.il.thewrittenword.com (Postfix, from userid 1048)
	id B4B13BAB1; Thu, 11 Mar 2010 16:32:35 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at maetel.il.thewrittenword.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141983>

Unfortunately there are a still a lot of vendor compilers that choke
when the last entry in an enum has a dangling comma (irix is one, and
I can get you a list of which of our particular platforms exhibit this
problem).

This patch simply deletes all the commas that are required to be able
to compile those enums on all of our supported architectures.
---
 builtin/apply.c        |    2 +-
 builtin/branch.c       |    6 +++---
 builtin/commit.c       |    4 ++--
 builtin/help.c         |    2 +-
 builtin/mailinfo.c     |    4 ++--
 builtin/receive-pack.c |    2 +-
 cache.h                |   12 ++++++------
 commit.h               |    2 +-
 connect.c              |    2 +-
 ctype.c                |    4 ++--
 diff.h                 |    2 +-
 dir.c                  |    4 ++--
 fast-import.c          |    2 +-
 grep.h                 |    8 ++++----
 http-push.c            |    2 +-
 http-walker.c          |    2 +-
 imap-send.c            |    2 +-
 remote.h               |    2 +-
 rerere.c               |    2 +-
 revision.c             |    2 +-
 wt-status.h            |    2 +-
 21 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 3af4ae0..e50f1ce 100644
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
diff --git a/builtin/branch.c b/builtin/branch.c
index 6cf7e72..ea23a0f 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -36,20 +36,20 @@ static char branch_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_NORMAL,	/* PLAIN */
 	GIT_COLOR_RED,		/* REMOTE */
 	GIT_COLOR_NORMAL,	/* LOCAL */
-	GIT_COLOR_GREEN,	/* CURRENT */
+	GIT_COLOR_GREEN		/* CURRENT */
 };
 enum color_branch {
 	BRANCH_COLOR_RESET = 0,
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
 
diff --git a/builtin/commit.c b/builtin/commit.c
index f4c7344..530d9ce 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -57,7 +57,7 @@ static struct lock_file false_lock; /* used only for partial commits */
 static enum {
 	COMMIT_AS_IS = 1,
 	COMMIT_NORMAL,
-	COMMIT_PARTIAL,
+	COMMIT_PARTIAL
 } commit_style;
 
 static const char *logfile, *force_author;
@@ -77,7 +77,7 @@ static char *untracked_files_arg, *force_date;
 static enum {
 	CLEANUP_SPACE,
 	CLEANUP_NONE,
-	CLEANUP_ALL,
+	CLEANUP_ALL
 } cleanup_mode;
 static char *cleanup_arg;
 
diff --git a/builtin/help.c b/builtin/help.c
index 3182a2b..a9836b0 100644
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
diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index ce2ef6b..b39a8b7 100644
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
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 0559fcc..9225dae 100644
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
diff --git a/cache.h b/cache.h
index 89f6a40..2f7da15 100644
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
@@ -553,7 +553,7 @@ extern int core_apply_sparse_checkout;
 enum safe_crlf {
 	SAFE_CRLF_FALSE = 0,
 	SAFE_CRLF_FAIL = 1,
-	SAFE_CRLF_WARN = 2,
+	SAFE_CRLF_WARN = 2
 };
 
 extern enum safe_crlf safe_crlf;
@@ -564,14 +564,14 @@ enum branch_track {
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
@@ -667,7 +667,7 @@ enum sharedrepo {
 	OLD_PERM_GROUP      = 1,
 	OLD_PERM_EVERYBODY  = 2,
 	PERM_GROUP          = 0660,
-	PERM_EVERYBODY      = 0664,
+	PERM_EVERYBODY      = 0664
 };
 int git_config_perm(const char *var, const char *value);
 int set_shared_perm(const char *path, int mode);
@@ -877,7 +877,7 @@ struct ref {
 		REF_STATUS_REJECT_NODELETE,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
-		REF_STATUS_EXPECTING_REPORT,
+		REF_STATUS_EXPECTING_REPORT
 	} status;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
diff --git a/commit.h b/commit.h
index 3cf5166..25a30ac 100644
--- a/commit.h
+++ b/commit.h
@@ -60,7 +60,7 @@ enum cmit_fmt {
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_USERFORMAT,
 
-	CMIT_FMT_UNSPECIFIED,
+	CMIT_FMT_UNSPECIFIED
 };
 
 struct pretty_print_context
diff --git a/connect.c b/connect.c
index 323a771..dcca1d8 100644
--- a/connect.c
+++ b/connect.c
@@ -131,7 +131,7 @@ int path_match(const char *path, int nr, char **match)
 enum protocol {
 	PROTO_LOCAL = 1,
 	PROTO_SSH,
-	PROTO_GIT,
+	PROTO_GIT
 };
 
 static enum protocol get_protocol(const char *name)
diff --git a/ctype.c b/ctype.c
index 7ee64c7..b694b9c 100644
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
@@ -21,6 +21,6 @@ unsigned char sane_ctype[256] = {
 	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  64.. 79 */
 	A, A, A, A, A, A, A, A, A, A, A, G, G, 0, R, 0,		/*  80.. 95 */
 	0, A, A, A, A, A, A, A, A, A, A, A, A, A, A, A,		/*  96..111 */
-	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, 0, 0,		/* 112..127 */
+	A, A, A, A, A, A, A, A, A, A, A, R, R, 0, 0, 0		/* 112..127 */
 	/* Nothing in the 128.. range */
 };
diff --git a/diff.h b/diff.h
index 2ef3341..b9645fe 100644
--- a/diff.h
+++ b/diff.h
@@ -131,7 +131,7 @@ enum color_diff {
 	DIFF_FILE_NEW = 5,
 	DIFF_COMMIT = 6,
 	DIFF_WHITESPACE = 7,
-	DIFF_FUNCINFO = 8,
+	DIFF_FUNCINFO = 8
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
 #define diff_get_color_opt(o, ix) \
diff --git a/dir.c b/dir.c
index 133c333..5ea7a92 100644
--- a/dir.c
+++ b/dir.c
@@ -465,7 +465,7 @@ static struct dir_entry *dir_add_ignored(struct dir_struct *dir, const char *pat
 enum exist_status {
 	index_nonexistent = 0,
 	index_directory,
-	index_gitdir,
+	index_gitdir
 };
 
 /*
@@ -533,7 +533,7 @@ static enum exist_status directory_exists_in_index(const char *dirname, int len)
 enum directory_treatment {
 	show_directory,
 	ignore_directory,
-	recurse_into_directory,
+	recurse_into_directory
 };
 
 static enum directory_treatment treat_directory(struct dir_struct *dir,
diff --git a/fast-import.c b/fast-import.c
index 309f2c5..faa51a9 100644
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
diff --git a/grep.h b/grep.h
index d35bc29..81f7ae9 100644
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
diff --git a/http-push.c b/http-push.c
index 432b20f..bb9ef04 100644
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
diff --git a/http-walker.c b/http-walker.c
index 700bc13..f3ef0ec 100644
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
diff --git a/imap-send.c b/imap-send.c
index fa70383..d63a10b 100644
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
diff --git a/remote.h b/remote.h
index 6e13643..888d7c1 100644
--- a/remote.h
+++ b/remote.h
@@ -145,7 +145,7 @@ int branch_merge_matches(struct branch *, int n, const char *);
 enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
 	MATCH_REFS_ALL 		= (1 << 0),
-	MATCH_REFS_MIRROR	= (1 << 1),
+	MATCH_REFS_MIRROR	= (1 << 1)
 };
 
 /* Reporting of tracking info */
diff --git a/rerere.c b/rerere.c
index a59f74f..e66bf6b 100644
--- a/rerere.c
+++ b/rerere.c
@@ -153,7 +153,7 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 	git_SHA_CTX ctx;
 	int hunk_no = 0;
 	enum {
-		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL,
+		RR_CONTEXT = 0, RR_SIDE_1, RR_SIDE_2, RR_ORIGINAL
 	} hunk = RR_CONTEXT;
 	struct strbuf one = STRBUF_INIT, two = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
diff --git a/revision.c b/revision.c
index 29721ec..d8a558c 100644
--- a/revision.c
+++ b/revision.c
@@ -1759,7 +1759,7 @@ int prepare_revision_walk(struct rev_info *revs)
 enum rewrite_result {
 	rewrite_one_ok,
 	rewrite_one_noparents,
-	rewrite_one_error,
+	rewrite_one_error
 };
 
 static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp)
diff --git a/wt-status.h b/wt-status.h
index c60f40a..d348258 100644
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
1.7.0.2


-- 
Gary V. Vaughan (gary@thewrittenword.com)
