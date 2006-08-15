From: David Rientjes <rientjes@google.com>
Subject: [PATCH] remove unnecessary initializations
Date: Tue, 15 Aug 2006 10:23:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.63.0608151023200.26891@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Tue Aug 15 19:24:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD2eJ-0001nD-HI
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 19:24:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030418AbWHORYM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 13:24:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030422AbWHORYM
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 13:24:12 -0400
Received: from smtp-out.google.com ([216.239.45.12]:18133 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1030418AbWHORYK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Aug 2006 13:24:10 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id k7FHNt3w007338
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 10:23:55 -0700
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:date:from:x-x-sender:to:subject:message-id:
	mime-version:content-type;
	b=cijJk3FqpT/QbUVBu2lFq5SLIU2XzXW6rCDPcFjua6+9CEkoJ+xJiemtmKO7lVF89
	nOkpA9TGzaOkN4XLbbzCw==
Received: from localhost (chino.corp.google.com [172.24.88.221])
	by zps75.corp.google.com with ESMTP id k7FHNmiU025426
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 10:23:49 -0700
Received: by localhost (Postfix, from userid 24081)
	id DB0FA87D71; Tue, 15 Aug 2006 10:23:48 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost (Postfix) with ESMTP id D87E687D70
	for <git@vger.kernel.org>; Tue, 15 Aug 2006 10:23:48 -0700 (PDT)
X-X-Sender: rientjes@chino.corp.google.com
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25470>

Removed unnecessary initializations.

		David

Signed-off-by: David Rientjes <rientjes@google.com>
---
 blame.c                 |    6 +++---
 builtin-apply.c         |   26 +++++++++++++-------------
 builtin-fmt-merge-msg.c |    2 +-
 builtin-help.c          |    2 +-
 builtin-ls-files.c      |   27 ++++++++++++++-------------
 builtin-ls-tree.c       |    6 +++---
 builtin-mailinfo.c      |    6 +++---
 builtin-prune.c         |    2 +-
 builtin-push.c          |    8 ++++----
 builtin-read-tree.c     |   24 ++++++++++++------------
 builtin-repo-config.c   |   16 ++++++++--------
 builtin-rev-list.c      |    6 +++---
 builtin-rev-parse.c     |   10 +++++-----
 builtin-show-branch.c   |    6 +++---
 builtin-update-index.c  |    2 +-
 commit.c                |    6 +++---
 connect.c               |    6 +++---
 daemon.c                |   20 ++++++++++----------
 describe.c              |    6 +++---
 diff.c                  |    4 ++--
 environment.c           |   10 +++++-----
 exec_cmd.c              |    2 +-
 fetch-pack.c            |    6 +++---
 fsck-objects.c          |   14 +++++++-------
 git.c                   |    2 +-
 http-fetch.c            |    8 ++++----
 http-push.c             |   16 ++++++++--------
 local-fetch.c           |    8 ++++----
 merge-base.c            |    2 +-
 merge-index.c           |    2 +-
 mktree.c                |    1 -
 name-rev.c              |    2 +-
 pack-objects.c          |   28 ++++++++++++++--------------
 pack-redundant.c        |    4 ++--
 read-cache.c            |   12 ++++++------
 receive-pack.c          |    6 +++---
 send-pack.c             |    8 ++++----
 sha1_file.c             |    2 +-
 ssh-fetch.c             |    8 ++++----
 ssh-upload.c            |    4 ++--
 upload-pack.c           |    8 ++++----
 41 files changed, 172 insertions(+), 172 deletions(-)

diff --git a/blame.c b/blame.c
index 7099b53..220d733 100644
--- a/blame.c
+++ b/blame.c
@@ -56,9 +56,9 @@ struct patch {
 static void get_blob(struct commit *commit);
 
 /* Only used for statistics */
-static int num_get_patch = 0;
-static int num_commits = 0;
-static int patch_time = 0;
+static int num_get_patch;
+static int num_commits;
+static int patch_time;
 
 struct blame_diff_state {
 	struct xdiff_emit_state xm;
diff --git a/builtin-apply.c b/builtin-apply.c
index 2862eb1..69dfdc2 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -28,17 +28,17 @@ static int prefix_length = -1;
 static int newfd = -1;
 
 static int p_value = 1;
-static int allow_binary_replacement = 0;
-static int check_index = 0;
-static int write_index = 0;
-static int cached = 0;
-static int diffstat = 0;
-static int numstat = 0;
-static int summary = 0;
-static int check = 0;
+static int allow_binary_replacement;
+static int check_index;
+static int write_index;
+static int cached;
+static int diffstat;
+static int numstat;
+static int summary;
+static int check;
 static int apply = 1;
-static int no_add = 0;
-static int show_index_info = 0;
+static int no_add;
+static int show_index_info;
 static int line_termination = '\n';
 static unsigned long p_context = -1;
 static const char apply_usage[] =
@@ -50,10 +50,10 @@ static enum whitespace_eol {
 	error_on_whitespace,
 	strip_whitespace,
 } new_whitespace = warn_on_whitespace;
-static int whitespace_error = 0;
+static int whitespace_error;
 static int squelch_whitespace_errors = 5;
-static int applied_after_stripping = 0;
-static const char *patch_input_file = NULL;
+static int applied_after_stripping;
+static const char *patch_input_file;
 
 static void parse_whitespace_option(const char *option)
 {
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index 485ede7..28b5dfd 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -8,7 +8,7 @@ #include "tag.h"
 static const char *fmt_merge_msg_usage =
 	"git-fmt-merge-msg [--summary] [--no-summary] [--file <file>]";
 
-static int merge_summary = 0;
+static int merge_summary;
 
 static int fmt_merge_msg_config(const char *key, const char *value)
 {
diff --git a/builtin-help.c b/builtin-help.c
index 6484cb9..9ecdefd 100644
--- a/builtin-help.c
+++ b/builtin-help.c
@@ -14,7 +14,7 @@ #include "common-cmds.h"
 static int term_columns(void)
 {
 	char *col_string = getenv("COLUMNS");
-	int n_cols = 0;
+	int n_cols;
 
 	if (col_string && (n_cols = atoi(col_string)) > 0)
 		return n_cols;
diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 11386c4..ad8c41e 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -12,21 +12,22 @@ #include "quote.h"
 #include "dir.h"
 #include "builtin.h"
 
-static int abbrev = 0;
-static int show_deleted = 0;
-static int show_cached = 0;
-static int show_others = 0;
-static int show_stage = 0;
-static int show_unmerged = 0;
-static int show_modified = 0;
-static int show_killed = 0;
-static int show_valid_bit = 0;
+static int abbrev;
+static int show_deleted;
+static int show_cached;
+static int show_others;
+static int show_stage;
+static int show_unmerged;
+static int show_modified;
+static int show_killed;
+static int show_valid_bit;
 static int line_terminator = '\n';
 
-static int prefix_len = 0, prefix_offset = 0;
-static const char **pathspec = NULL;
-static int error_unmatch = 0;
-static char *ps_matched = NULL;
+static int prefix_len;
+static int prefix_offset;
+static const char **pathspec;
+static int error_unmatch;
+static char *ps_matched;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 261147f..201defd 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -14,10 +14,10 @@ #define LS_RECURSIVE 1
 #define LS_TREE_ONLY 2
 #define LS_SHOW_TREES 4
 #define LS_NAME_ONLY 8
-static int abbrev = 0;
-static int ls_options = 0;
+static int abbrev;
+static int ls_options;
 static const char **pathspec;
-static int chomp_prefix = 0;
+static int chomp_prefix;
 static const char *ls_tree_prefix;
 
 static const char ls_tree_usage[] =
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 24a4fc6..0c65f93 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -16,8 +16,8 @@ #include "builtin.h"
 
 static FILE *cmitmsg, *patchfile, *fin, *fout;
 
-static int keep_subject = 0;
-static const char *metainfo_charset = NULL;
+static int keep_subject;
+static const char *metainfo_charset;
 static char line[1000];
 static char date[1000];
 static char name[1000];
@@ -31,7 +31,7 @@ static char charset[256];
 
 static char multipart_boundary[1000];
 static int multipart_boundary_len;
-static int patch_lines = 0;
+static int patch_lines;
 
 static char *sanity_check(char *name, char *email)
 {
diff --git a/builtin-prune.c b/builtin-prune.c
index 89ec7f1..fc885ce 100644
--- a/builtin-prune.c
+++ b/builtin-prune.c
@@ -11,7 +11,7 @@ #include "builtin.h"
 #include "cache-tree.h"
 
 static const char prune_usage[] = "git-prune [-n]";
-static int show_only = 0;
+static int show_only;
 static struct rev_info revs;
 
 static int prune_object(char *path, const char *filename, const unsigned char *sha1)
diff --git a/builtin-push.c b/builtin-push.c
index 53bc378..2c23cb2 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,14 +10,14 @@ #define MAX_URI (16)
 
 static const char push_usage[] = "git-push [--all] [--tags] [-f | --force] <repository> [<refspec>...]";
 
-static int all = 0, tags = 0, force = 0, thin = 1;
-static const char *execute = NULL;
+static int all, tags, force, thin = 1;
+static const char *execute;
 
 #define BUF_SIZE (2084)
 static char buffer[BUF_SIZE];
 
-static const char **refspec = NULL;
-static int refspec_nr = 0;
+static const char **refspec;
+static int refspec_nr;
 
 static void add_refspec(const char *ref)
 {
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index f902fee..02d890f 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -15,21 +15,21 @@ #include <sys/time.h>
 #include <signal.h>
 #include "builtin.h"
 
-static int reset = 0;
-static int merge = 0;
-static int update = 0;
-static int index_only = 0;
-static int nontrivial_merge = 0;
-static int trivial_merges_only = 0;
-static int aggressive = 0;
-static int verbose_update = 0;
-static volatile sig_atomic_t progress_update = 0;
-static const char *prefix = NULL;
+static int reset;
+static int merge;
+static int update;
+static int index_only;
+static int nontrivial_merge;
+static int trivial_merges_only;
+static int aggressive;
+static int verbose_update;
+static volatile sig_atomic_t progress_update;
+static const char *prefix;
 
 static int head_idx = -1;
-static int merge_size = 0;
+static int merge_size;
 
-static struct object_list *trees = NULL;
+static struct object_list *trees;
 
 static struct cache_entry df_conflict_entry;
 
diff --git a/builtin-repo-config.c b/builtin-repo-config.c
index c821e22..c416480 100644
--- a/builtin-repo-config.c
+++ b/builtin-repo-config.c
@@ -5,14 +5,14 @@ #include <regex.h>
 static const char git_config_set_usage[] =
 "git-repo-config [ --bool | --int ] [--get | --get-all | --get-regexp | --replace-all | --unset | --unset-all] name [value [value_regex]] | --list";
 
-static char* key = NULL;
-static regex_t* key_regexp = NULL;
-static regex_t* regexp = NULL;
-static int show_keys = 0;
-static int use_key_regexp = 0;
-static int do_all = 0;
-static int do_not_match = 0;
-static int seen = 0;
+static char *key;
+static regex_t *key_regexp;
+static regex_t *regexp;
+static int show_keys;
+static int use_key_regexp;
+static int do_all;
+static int do_not_match;
+static int seen;
 static enum { T_RAW, T_INT, T_BOOL } type = T_RAW;
 
 static int show_all_config(const char *key_, const char *value_)
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 0dee173..bc48a3e 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -39,9 +39,9 @@ static const char rev_list_usage[] =
 
 static struct rev_info revs;
 
-static int bisect_list = 0;
-static int show_timestamp = 0;
-static int hdr_termination = 0;
+static int bisect_list;
+static int show_timestamp;
+static int hdr_termination;
 static const char *header_prefix;
 
 static void show_commit(struct commit *commit)
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index aca4a36..fd3ccc8 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -15,16 +15,16 @@ #define DO_FLAGS	4
 #define DO_NONFLAGS	8
 static int filter = ~0;
 
-static const char *def = NULL;
+static const char *def;
 
 #define NORMAL 0
 #define REVERSED 1
 static int show_type = NORMAL;
-static int symbolic = 0;
-static int abbrev = 0;
-static int output_sq = 0;
+static int symbolic;
+static int abbrev;
+static int output_sq;
 
-static int revs_count = 0;
+static int revs_count;
 
 /*
  * Some arguments are relevant "revision" arguments,
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 2a1b848..95fbf77 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -8,9 +8,9 @@ #include "builtin.h"
 static const char show_branch_usage[] =
 "git-show-branch [--sparse] [--current] [--all] [--heads] [--tags] [--topo-order] [--more=count | --list | --independent | --merge-base ] [--topics] [<refs>...]";
 
-static int default_num = 0;
-static int default_alloc = 0;
-static const char **default_arg = NULL;
+static int default_num;
+static int default_alloc;
+static const char **default_arg;
 
 #define UNINTERESTING	01
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 24dca47..d380f89 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -23,7 +23,7 @@ static int allow_replace;
 static int info_only;
 static int force_remove;
 static int verbose;
-static int mark_valid_only = 0;
+static int mark_valid_only;
 #define MARK_VALID 1
 #define UNMARK_VALID 2
 
diff --git a/commit.c b/commit.c
index 77f0ca1..972d1b7 100644
--- a/commit.c
+++ b/commit.c
@@ -727,10 +727,10 @@ struct commit *pop_commit(struct commit_
 
 int count_parents(struct commit * commit)
 {
-        int count = 0;
+        int count;
         struct commit_list * parents = commit->parents;
-        for (count=0;parents; parents=parents->next,count++)
-          ;
+        for (count = 0; parents; parents = parents->next,count++)
+		;
         return count;
 }
 
diff --git a/connect.c b/connect.c
index a4c02d1..6a86ab7 100644
--- a/connect.c
+++ b/connect.c
@@ -10,7 +10,7 @@ #include <arpa/inet.h>
 #include <netdb.h>
 #include <signal.h>
 
-static char *server_capabilities = NULL;
+static char *server_capabilities;
 
 static int check_ref(const char *name, int len, unsigned int flags)
 {
@@ -493,8 +493,8 @@ static void git_tcp_connect(int fd[2], c
 }
 
 
-static char *git_proxy_command = NULL;
-static const char *rhost_name = NULL;
+static char *git_proxy_command;
+static const char *rhost_name;
 static int rhost_len;
 
 static int git_proxy_command_options(const char *var, const char *value)
diff --git a/daemon.c b/daemon.c
index 810837f..012936f 100644
--- a/daemon.c
+++ b/daemon.c
@@ -22,24 +22,24 @@ static const char daemon_usage[] =
 "           [--reuseaddr] [--detach] [--pid-file=file] [directory...]";
 
 /* List of acceptable pathname prefixes */
-static char **ok_paths = NULL;
-static int strict_paths = 0;
+static char **ok_paths;
+static int strict_paths;
 
 /* If this is set, git-daemon-export-ok is not required */
-static int export_all_trees = 0;
+static int export_all_trees;
 
 /* Take all paths relative to this one if non-NULL */
-static char *base_path = NULL;
+static char *base_path;
 
 /* If defined, ~user notation is allowed and the string is inserted
  * after ~user/.  E.g. a request to git://host/~alice/frotz would
  * go to /home/alice/pub_git/frotz with --user-path=pub_git.
  */
-static const char *user_path = NULL;
+static const char *user_path;
 
 /* Timeout, and initial timeout */
-static unsigned int timeout = 0;
-static unsigned int init_timeout = 0;
+static unsigned int timeout;
+static unsigned int init_timeout;
 
 static void logreport(int priority, const char *err, va_list params)
 {
@@ -333,12 +333,12 @@ #define MAX_CHILDREN 128
 static int max_connections = 25;
 
 /* These are updated by the signal handler */
-static volatile unsigned int children_reaped = 0;
+static volatile unsigned int children_reaped;
 static pid_t dead_child[MAX_CHILDREN];
 
 /* These are updated by the main loop */
-static unsigned int children_spawned = 0;
-static unsigned int children_deleted = 0;
+static unsigned int children_spawned;
+static unsigned int children_deleted;
 
 static struct child {
 	pid_t pid;
diff --git a/describe.c b/describe.c
index 324ca89..a54f4f8 100644
--- a/describe.c
+++ b/describe.c
@@ -8,12 +8,12 @@ #define SEEN (1u << 0)
 static const char describe_usage[] =
 "git-describe [--all] [--tags] [--abbrev=<n>] <committish>*";
 
-static int all = 0;	/* Default to annotated tags only */
-static int tags = 0;	/* But allow any tags if --tags is specified */
+static int all;	/* Default to annotated tags only */
+static int tags;	/* But allow any tags if --tags is specified */
 
 static int abbrev = DEFAULT_ABBREV;
 
-static int names = 0, allocs = 0;
+static int names, allocs;
 static struct commit_name {
 	const struct commit *commit;
 	int prio; /* annotated tag = 2, tag = 1, head = 0 */
diff --git a/diff.c b/diff.c
index b3b1781..9f3ca06 100644
--- a/diff.c
+++ b/diff.c
@@ -13,9 +13,9 @@ #include "xdiff-interface.h"
 
 static int use_size_cache;
 
-static int diff_detect_rename_default = 0;
+static int diff_detect_rename_default;
 static int diff_rename_limit_default = -1;
-static int diff_use_color_default = 0;
+static int diff_use_color_default;
 
 /* "\033[1;38;5;2xx;48;5;2xxm\0" is 23 bytes */
 static char diff_colors[][24] = {
diff --git a/environment.c b/environment.c
index 87162b2..e6bd003 100644
--- a/environment.c
+++ b/environment.c
@@ -13,14 +13,14 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int use_legacy_headers = 1;
 int trust_executable_bit = 1;
-int assume_unchanged = 0;
-int prefer_symlink_refs = 0;
-int log_all_ref_updates = 0;
+int assume_unchanged;
+int prefer_symlink_refs;
+int log_all_ref_updates;
 int warn_ambiguous_refs = 1;
-int repository_format_version = 0;
+int repository_format_version;
 char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = PERM_UMASK;
-const char *apply_default_whitespace = NULL;
+const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
 int pager_in_use;
 int pager_use_color = 1;
diff --git a/exec_cmd.c b/exec_cmd.c
index 62f51fc..e30936d 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -5,7 +5,7 @@ #define MAX_ARGS	32
 
 extern char **environ;
 static const char *builtin_exec_path = GIT_EXEC_PATH;
-static const char *current_exec_path = NULL;
+static const char *current_exec_path;
 
 void git_set_exec_path(const char *exec_path)
 {
diff --git a/fetch-pack.c b/fetch-pack.c
index b7824db..e18c148 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -24,8 +24,8 @@ #define POPPED		(1U << 4)
  */
 #define MAX_IN_VAIN 256
 
-static struct commit_list *rev_list = NULL;
-static int non_common_revs = 0, multi_ack = 0, use_thin_pack = 0, use_sideband;
+static struct commit_list *rev_list;
+static int non_common_revs, multi_ack, use_thin_pack, use_sideband;
 
 static void rev_list_push(struct commit *commit, int mark)
 {
@@ -250,7 +250,7 @@ done:
 	return retval;
 }
 
-static struct commit_list *complete = NULL;
+static struct commit_list *complete;
 
 static int mark_complete(const char *path, const unsigned char *sha1)
 {
diff --git a/fsck-objects.c b/fsck-objects.c
index e167f41..ffc0e8e 100644
--- a/fsck-objects.c
+++ b/fsck-objects.c
@@ -14,12 +14,12 @@ #include "tree-walk.h"
 #define REACHABLE 0x0001
 #define SEEN      0x0002
 
-static int show_root = 0;
-static int show_tags = 0;
-static int show_unreachable = 0;
-static int check_full = 0;
-static int check_strict = 0;
-static int keep_cache_objects = 0;
+static int show_root;
+static int show_tags;
+static int show_unreachable;
+static int check_full;
+static int check_strict;
+static int keep_cache_objects;
 static unsigned char head_sha1[20];
 
 #ifdef NO_D_INO_IN_DIRENT
@@ -401,7 +401,7 @@ static int fsck_dir(int i, char *path)
 	return 0;
 }
 
-static int default_refs = 0;
+static int default_refs;
 
 static int fsck_handle_ref(const char *refname, const unsigned char *sha1)
 {
diff --git a/git.c b/git.c
index 18ba14a..c56cb14 100644
--- a/git.c
+++ b/git.c
@@ -92,7 +92,7 @@ static int handle_options(const char*** 
 }
 
 static const char *alias_command;
-static char *alias_string = NULL;
+static char *alias_string;
 
 static int git_alias_config(const char *var, const char *value)
 {
diff --git a/http-fetch.c b/http-fetch.c
index de5fc44..7f07d2a 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -36,10 +36,10 @@ #endif
 #define PREV_BUF_SIZE 4096
 #define RANGE_HEADER_SIZE 30
 
-static int commits_on_stdin = 0;
+static int commits_on_stdin;
 
 static int got_alternates = -1;
-static int corrupt_object_found = 0;
+static int corrupt_object_found;
 
 static struct curl_slist *no_pragma_header;
 
@@ -52,7 +52,7 @@ struct alt_base
 	struct alt_base *next;
 };
 
-static struct alt_base *alt = NULL;
+static struct alt_base *alt;
 
 enum object_request_state {
 	WAITING,
@@ -114,7 +114,7 @@ struct remote_ls_ctx
 };
 #endif
 
-static struct object_request *object_queue_head = NULL;
+static struct object_request *object_queue_head;
 
 static size_t fwrite_sha1_file(void *ptr, size_t eltsize, size_t nmemb,
 			       void *data)
diff --git a/http-push.c b/http-push.c
index d45733e..72a7b93 100644
--- a/http-push.c
+++ b/http-push.c
@@ -70,18 +70,18 @@ #define PUSHING  (1u<<19)
 /* We allow "recursive" symbolic refs. Only within reason, though */
 #define MAXDEPTH 5
 
-static int pushing = 0;
-static int aborted = 0;
+static int pushing;
+static int aborted;
 static signed char remote_dir_exists[256];
 
 static struct curl_slist *no_pragma_header;
 static struct curl_slist *default_headers;
 
-static int push_verbosely = 0;
-static int push_all = 0;
-static int force_all = 0;
+static int push_verbosely;
+static int push_all;
+static int force_all;
 
-static struct object_list *objects = NULL;
+static struct object_list *objects;
 
 struct repo
 {
@@ -94,7 +94,7 @@ struct repo
 	struct remote_lock *locks;
 };
 
-static struct repo *remote = NULL;
+static struct repo *remote;
 
 enum transfer_state {
 	NEED_FETCH,
@@ -134,7 +134,7 @@ struct transfer_request
 	struct transfer_request *next;
 };
 
-static struct transfer_request *request_queue_head = NULL;
+static struct transfer_request *request_queue_head;
 
 struct xml_ctx
 {
diff --git a/local-fetch.c b/local-fetch.c
index 7d01845..7b6875c 100644
--- a/local-fetch.c
+++ b/local-fetch.c
@@ -5,10 +5,10 @@ #include "cache.h"
 #include "commit.h"
 #include "fetch.h"
 
-static int use_link = 0;
-static int use_symlink = 0;
+static int use_link;
+static int use_symlink;
 static int use_filecopy = 1;
-static int commits_on_stdin = 0;
+static int commits_on_stdin;
 
 static const char *path; /* "Remote" git repository */
 
@@ -16,7 +16,7 @@ void prefetch(unsigned char *sha1)
 {
 }
 
-static struct packed_git *packs = NULL;
+static struct packed_git *packs;
 
 static void setup_index(unsigned char *sha1)
 {
diff --git a/merge-base.c b/merge-base.c
index 59f723f..009caf8 100644
--- a/merge-base.c
+++ b/merge-base.c
@@ -2,7 +2,7 @@ #include <stdlib.h>
 #include "cache.h"
 #include "commit.h"
 
-static int show_all = 0;
+static int show_all;
 
 static int merge_base(struct commit *rev1, struct commit *rev2)
 {
diff --git a/merge-index.c b/merge-index.c
index a9c8cc1..646d090 100644
--- a/merge-index.c
+++ b/merge-index.c
@@ -4,7 +4,7 @@ #include <signal.h>
 
 #include "cache.h"
 
-static const char *pgm = NULL;
+static const char *pgm;
 static const char *arguments[8];
 static int one_shot, quiet;
 static int err;
diff --git a/mktree.c b/mktree.c
index 9a6f0d2..9324138 100644
--- a/mktree.c
+++ b/mktree.c
@@ -49,7 +49,6 @@ static void write_tree(unsigned char *sh
 	int i;
 
 	qsort(entries, used, sizeof(*entries), ent_compare);
-	size = 100;
 	for (size = i = 0; i < used; i++)
 		size += 32 + entries[i]->len;
 	buffer = xmalloc(size);
diff --git a/name-rev.c b/name-rev.c
index f92f14e..40c3ea5 100644
--- a/name-rev.c
+++ b/name-rev.c
@@ -74,7 +74,7 @@ copy_data:
 	}
 }
 
-static int tags_only = 0;
+static int tags_only;
 
 static int name_ref(const char *path, const unsigned char *sha1)
 {
diff --git a/pack-objects.c b/pack-objects.c
index 861c7f0..48dee11 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -52,17 +52,17 @@ struct object_entry {
  */
 
 static unsigned char object_list_sha1[20];
-static int non_empty = 0;
-static int no_reuse_delta = 0;
-static int local = 0;
-static int incremental = 0;
+static int non_empty;
+static int no_reuse_delta;
+static int local;
+static int incremental;
 static struct object_entry **sorted_by_sha, **sorted_by_type;
-static struct object_entry *objects = NULL;
-static int nr_objects = 0, nr_alloc = 0, nr_result = 0;
+static struct object_entry *objects;
+static int nr_objects, nr_alloc, nr_result;
 static const char *base_name;
 static unsigned char pack_file_sha1[20];
 static int progress = 1;
-static volatile sig_atomic_t progress_update = 0;
+static volatile sig_atomic_t progress_update;
 static int window = 10;
 
 /*
@@ -71,8 +71,8 @@ static int window = 10;
  * sorted_by_sha is also possible but this was easier to code and faster.
  * This hashtable is built after all the objects are seen.
  */
-static int *object_ix = NULL;
-static int object_ix_hashsz = 0;
+static int *object_ix;
+static int object_ix_hashsz;
 
 /*
  * Pack index for existing packs give us easy access to the offsets into
@@ -89,15 +89,15 @@ struct pack_revindex {
 	struct packed_git *p;
 	unsigned long *revindex;
 } *pack_revindex = NULL;
-static int pack_revindex_hashsz = 0;
+static int pack_revindex_hashsz;
 
 /*
  * stats
  */
-static int written = 0;
-static int written_delta = 0;
-static int reused = 0;
-static int reused_delta = 0;
+static int written;
+static int written_delta;
+static int reused;
+static int reused_delta;
 
 static int pack_revindex_ix(struct packed_git *p)
 {
diff --git a/pack-redundant.c b/pack-redundant.c
index 41fb960..92a09ed 100644
--- a/pack-redundant.c
+++ b/pack-redundant.c
@@ -13,7 +13,7 @@ #define BLKSIZE 512
 static const char pack_redundant_usage[] =
 "git-pack-redundant [ --verbose ] [ --alt-odb ] < --all | <.pack filename> ...>";
 
-static int load_all_packs = 0, verbose = 0, alt_odb = 0;
+static int load_all_packs, verbose, alt_odb;
 
 struct llist_item {
 	struct llist_item *next;
@@ -37,7 +37,7 @@ struct pll {
 	struct pack_list *pl;
 };
 
-static struct llist_item *free_nodes = NULL;
+static struct llist_item *free_nodes;
 
 static inline void llist_item_put(struct llist_item *item)
 {
diff --git a/read-cache.c b/read-cache.c
index f92cdaa..a120373 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,16 +18,16 @@ #include "cache-tree.h"
 #define CACHE_EXT(s) ( (s[0]<<24)|(s[1]<<16)|(s[2]<<8)|(s[3]) )
 #define CACHE_EXT_TREE 0x54524545	/* "TREE" */
 
-struct cache_entry **active_cache = NULL;
+struct cache_entry **active_cache;
 static time_t index_file_timestamp;
-unsigned int active_nr = 0, active_alloc = 0, active_cache_changed = 0;
+unsigned int active_nr, active_alloc, active_cache_changed;
 
-struct cache_tree *active_cache_tree = NULL;
+struct cache_tree *active_cache_tree;
 
-int cache_errno = 0;
+int cache_errno;
 
-static void *cache_mmap = NULL;
-static size_t cache_mmap_size = 0;
+static void *cache_mmap;
+static size_t cache_mmap_size;
 
 /*
  * This only updates the "non-critical" parts of the directory
diff --git a/receive-pack.c b/receive-pack.c
index 93929b5..81e9190 100644
--- a/receive-pack.c
+++ b/receive-pack.c
@@ -8,10 +8,10 @@ static const char receive_pack_usage[] =
 
 static const char *unpacker[] = { "unpack-objects", NULL };
 
-static int report_status = 0;
+static int report_status;
 
 static char capabilities[] = "report-status";
-static int capabilities_sent = 0;
+static int capabilities_sent;
 
 static int show_ref(const char *path, const unsigned char *sha1)
 {
@@ -40,7 +40,7 @@ struct command {
 	char ref_name[FLEX_ARRAY]; /* more */
 };
 
-static struct command *commands = NULL;
+static struct command *commands;
 
 static int is_all_zeroes(const char *hex)
 {
diff --git a/send-pack.c b/send-pack.c
index 10bc8bc..675819a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -9,10 +9,10 @@ static const char send_pack_usage[] =
 "git-send-pack [--all] [--exec=git-receive-pack] <remote> [<head>...]\n"
 "  --all and explicit <head> specification are mutually exclusive.";
 static const char *exec = "git-receive-pack";
-static int verbose = 0;
-static int send_all = 0;
-static int force_update = 0;
-static int use_thin_pack = 0;
+static int verbose;
+static int send_all;
+static int force_update;
+static int use_thin_pack;
 
 static int is_zero_sha1(const unsigned char *sha1)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 3db956d..eb88547 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -22,7 +22,7 @@ #define O_NOATIME 0
 #endif
 #endif
 
-const unsigned char null_sha1[20] = { 0, };
+const unsigned char null_sha1[20];
 
 static unsigned int sha1_file_open_flag = O_NOATIME;
 
diff --git a/ssh-fetch.c b/ssh-fetch.c
index c7d8fa8..0b89df6 100644
--- a/ssh-fetch.c
+++ b/ssh-fetch.c
@@ -17,7 +17,7 @@ #include "refs.h"
 static int fd_in;
 static int fd_out;
 
-static unsigned char remote_version = 0;
+static unsigned char remote_version;
 static unsigned char local_version = 1;
 
 static ssize_t force_write(int fd, void *buffer, size_t length)
@@ -36,9 +36,9 @@ static ssize_t force_write(int fd, void 
 	return ret;
 }
 
-static int prefetches = 0;
+static int prefetches;
 
-static struct object_list *in_transit = NULL;
+static struct object_list *in_transit;
 static struct object_list **end_of_transit = &in_transit;
 
 void prefetch(unsigned char *sha1)
@@ -59,7 +59,7 @@ void prefetch(unsigned char *sha1)
 }
 
 static char conn_buf[4096];
-static size_t conn_buf_posn = 0;
+static size_t conn_buf_posn;
 
 int fetch(unsigned char *sha1)
 {
diff --git a/ssh-upload.c b/ssh-upload.c
index 2da6661..20b15ea 100644
--- a/ssh-upload.c
+++ b/ssh-upload.c
@@ -15,9 +15,9 @@ #include "refs.h"
 #include <string.h>
 
 static unsigned char local_version = 1;
-static unsigned char remote_version = 0;
+static unsigned char remote_version;
 
-static int verbose = 0;
+static int verbose;
 
 static int serve_object(int fd_in, int fd_out) {
 	ssize_t size;
diff --git a/upload-pack.c b/upload-pack.c
index 07ecdb4..70c1816 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -16,12 +16,12 @@ #define OUR_REF (1U << 1)
 #define WANTED (1U << 2)
 #define MAX_HAS 256
 #define MAX_NEEDS 256
-static int nr_has = 0, nr_needs = 0, multi_ack = 0, nr_our_refs = 0;
-static int use_thin_pack = 0;
+static int nr_has, nr_needs, multi_ack, nr_our_refs;
+static int use_thin_pack;
 static unsigned char has_sha1[MAX_HAS][20];
 static unsigned char needs_sha1[MAX_NEEDS][20];
-static unsigned int timeout = 0;
-static int use_sideband = 0;
+static unsigned int timeout;
+static int use_sideband;
 
 static void reset_timeout(void)
 {
-- 
1.4.2.rc4.g80f85-dirty
