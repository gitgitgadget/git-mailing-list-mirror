Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9CD20305
	for <e@80x24.org>; Wed, 17 Apr 2019 07:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbfDQH6s (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 03:58:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38306 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbfDQH6r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Apr 2019 03:58:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so11622725pgl.5
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 00:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZGC1bhv7KW7lJRp3bxDHo/pvO71K7BmHVazPY8aXL0Y=;
        b=uHqkuM7Pp7Yi4ozCVAq+ueim9OhZXZ/0AaqLePZ1sm3g8sNriC+dH5a3K+Si9VFkjj
         U5brMIO3f+DQMLLGq2QjtiMKNyTJVBYE2MjbBy0Wm9ryjKDtivr458QgpOGeytpig5kc
         CYqgFlsutUaCDRchbQL8uGeyJGve9Hpc54On6mSur2ps2t1bMmMy4svgsRz80Qwfv3QZ
         ELJm/wNL2YwuOq+Va3ObuhYFU7JtMGxyOYbxlSIWzCwSsPCAih43CP0iEmZftVvTag9E
         x6x73oYaOeV2Yt4oD42oAElDdQKMB4m+WFc8XoBGptaZ5WiUfXQCYfYz6lTNMwRwEOiB
         zr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZGC1bhv7KW7lJRp3bxDHo/pvO71K7BmHVazPY8aXL0Y=;
        b=g9XdYbfXaFAvqt3zBMI6+ZLHv2N+WRj98YhTX7DdrEeTMvb9FAFsg5YbMxGFjIvG3M
         QRUs84oIUaznGXludtJooOnwX5FYp40Zwxqw5gSOHvXlEmv6hMGsr+q5aUlAvK/8A/JR
         UN+ARkX2hZurhUQoiQ1j5NAD5NOfYgKnlPvKHBYoeOZdf9UsXEM/1fmzoaIblz5hEfNl
         W+ymHaMNAlyotJvlse0/XR14M+5WJPU2EuzZcy4Yz5449DWj/ufiu3S/dsJng6PgcSKc
         BKAxQwF1GByYsQFfM7cQD5K9H9o3hULt2NEXgm0d3ubpYoWMbWJoOaK9vSkg/VwqKBIu
         /ehw==
X-Gm-Message-State: APjAAAUCoJiVu9j23pJ9BLMNgqHuwb3q7za1mOdxieglMtD/Sxj0+7W5
        KtR1eZ37kb4lFUAS70Iy+zCmshPo
X-Google-Smtp-Source: APXvYqz9Q5aLN9YlEdsSBko2QvXHFF4BvXOnEOgBPni+3JUrzuwq3nRArzxn46+1d2FNmcjfDeD/Bw==
X-Received: by 2002:a63:6842:: with SMTP id d63mr78706307pgc.49.1555487923938;
        Wed, 17 Apr 2019 00:58:43 -0700 (PDT)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id i24sm75321935pfo.85.2019.04.17.00.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Apr 2019 00:58:42 -0700 (PDT)
Date:   Wed, 17 Apr 2019 00:58:41 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 3/4] *.[ch]: manually align parameter lists
Message-ID: <916c34450fb56112744e5e31b805c62ff6eeae13.1555487381.git.liu.denton@gmail.com>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1555487380.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous patches, extern was mechanically removed from function
declarations without care to formatting, causing parameter lists to be
misaligned. Manually format changed sections such that the parameter
lists should be realigned.

Viewing this patch with 'git diff -w' should produce no output.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 archive.h              | 10 +++----
 bisect.h               | 14 +++++-----
 branch.h               |  2 +-
 builtin.h              |  2 +-
 bulk-checkin.h         |  4 +--
 cache.h                | 42 ++++++++++++++--------------
 checkout.h             |  4 +--
 column.h               |  4 +--
 commit.h               | 44 +++++++++++++++---------------
 compat/obstack.h       |  6 ++--
 compat/regex/regex.h   | 38 +++++++++++++-------------
 compat/win32/pthread.h |  2 +-
 config.h               | 44 +++++++++++++++---------------
 connect.h              |  2 +-
 delta.h                |  4 +--
 dir.h                  | 62 +++++++++++++++++++++---------------------
 git-compat-util.h      |  4 +--
 help.h                 |  6 ++--
 http.h                 | 10 +++----
 khash.h                |  6 ++--
 lockfile.h             |  2 +-
 ls-refs.h              |  2 +-
 merge-blobs.h          |  4 +--
 object-store.h         | 16 +++++------
 oidmap.h               |  2 +-
 pack.h                 |  2 +-
 packfile.h             |  8 +++---
 path.h                 | 10 +++----
 pkt-line.h             |  4 +--
 ppc/sha1.c             |  2 +-
 quote.h                |  2 +-
 reachable.h            |  4 +--
 reflog-walk.h          | 12 ++++----
 remote.h               | 12 ++++----
 replace-object.h       |  2 +-
 serve.h                |  2 +-
 sha1-lookup.h          |  6 ++--
 string-list.h          |  2 +-
 sub-process.h          |  6 ++--
 submodule-config.h     |  2 +-
 tag.h                  |  2 +-
 tempfile.h             |  4 +--
 trace.h                | 10 +++----
 upload-pack.h          |  4 +--
 vcs-svn/svndiff.h      |  2 +-
 worktree.h             | 14 +++++-----
 xdiff-interface.h      |  2 +-
 47 files changed, 225 insertions(+), 225 deletions(-)

diff --git a/archive.h b/archive.h
index 5afc11d0f8..a7bdeea2c8 100644
--- a/archive.h
+++ b/archive.h
@@ -24,8 +24,8 @@ struct archiver_args {
 /* main api */
 
 int write_archive(int argc, const char **argv, const char *prefix,
-			 struct repository *repo,
-			 const char *name_hint, int remote);
+		  struct repository *repo,
+		  const char *name_hint, int remote);
 
 const char *archive_format_from_filename(const char *filename);
 
@@ -52,8 +52,8 @@ typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 
 int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
 void *object_file_to_archive(const struct archiver_args *args,
-				    const char *path, const struct object_id *oid,
-				    unsigned int mode, enum object_type *type,
-				    unsigned long *sizep);
+			     const char *path, const struct object_id *oid,
+			     unsigned int mode, enum object_type *type,
+			     unsigned long *sizep);
 
 #endif	/* ARCHIVE_H */
diff --git a/bisect.h b/bisect.h
index 81ac43baa7..4e69a11ea8 100644
--- a/bisect.h
+++ b/bisect.h
@@ -12,13 +12,13 @@ struct repository;
  * best commit, as chosen by `find_all`.
  */
 void find_bisection(struct commit_list **list, int *reaches, int *all,
-			   int find_all);
+		    int find_all);
 
 struct commit_list *filter_skipped(struct commit_list *list,
-					  struct commit_list **tried,
-					  int show_all,
-					  int *count,
-					  int *skipped_first);
+				   struct commit_list **tried,
+				   int show_all,
+				   int *count,
+				   int *skipped_first);
 
 #define BISECT_SHOW_ALL		(1<<0)
 #define REV_LIST_QUIET		(1<<1)
@@ -32,8 +32,8 @@ struct rev_list_info {
 };
 
 int bisect_next_all(struct repository *r,
-			   const char *prefix,
-			   int no_checkout);
+		    const char *prefix,
+		    int no_checkout);
 
 int estimate_bisect_steps(int all);
 
diff --git a/branch.h b/branch.h
index f1f74d21e4..6f38db14e9 100644
--- a/branch.h
+++ b/branch.h
@@ -92,6 +92,6 @@ void die_if_checked_out(const char *branch, int ignore_current_worktree);
  * otherwise.
  */
 int replace_each_worktree_head_symref(const char *oldref, const char *newref,
-					     const char *logmsg);
+				      const char *logmsg);
 
 #endif
diff --git a/builtin.h b/builtin.h
index 7627483f2f..a6d3c58fdd 100644
--- a/builtin.h
+++ b/builtin.h
@@ -111,7 +111,7 @@ struct fmt_merge_msg_opts {
 };
 
 int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
-			 struct fmt_merge_msg_opts *);
+		  struct fmt_merge_msg_opts *);
 
 /**
  * If a built-in has DELAY_PAGER_CONFIG set, the built-in should call this early
diff --git a/bulk-checkin.h b/bulk-checkin.h
index bf830e780d..b26f3dc3b7 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -7,8 +7,8 @@
 #include "cache.h"
 
 int index_bulk_checkin(struct object_id *oid,
-			      int fd, size_t size, enum object_type type,
-			      const char *path, unsigned flags);
+		       int fd, size_t size, enum object_type type,
+		       const char *path, unsigned flags);
 
 void plug_bulk_checkin(void);
 void unplug_bulk_checkin(void);
diff --git a/cache.h b/cache.h
index 1f42d5ecb1..9f15fee85f 100644
--- a/cache.h
+++ b/cache.h
@@ -616,7 +616,7 @@ void setup_work_tree(void);
  * either 0 upon success and non-zero if no repository was found.
  */
 int discover_git_directory(struct strbuf *commondir,
-				  struct strbuf *gitdir);
+			   struct strbuf *gitdir);
 const char *setup_git_directory_gently(int *);
 const char *setup_git_directory(void);
 char *prefix_path(const char *prefix, int len, const char *path);
@@ -636,8 +636,8 @@ char *prefix_filename(const char *prefix, const char *path);
 
 int check_filename(const char *prefix, const char *name);
 void verify_filename(const char *prefix,
-			    const char *name,
-			    int diagnose_misspelt_rev);
+		     const char *name,
+		     int diagnose_misspelt_rev);
 void verify_non_filename(const char *prefix, const char *name);
 int path_inside_repo(const char *prefix, const char *path);
 
@@ -645,7 +645,7 @@ int path_inside_repo(const char *prefix, const char *path);
 #define INIT_DB_EXIST_OK 0x0002
 
 int init_db(const char *git_dir, const char *real_git_dir,
-		   const char *template_dir, unsigned int flags);
+	    const char *template_dir, unsigned int flags);
 
 void sanitize_stdfds(void);
 int daemonize(void);
@@ -673,12 +673,12 @@ int daemonize(void);
 /* Initialize and use the cache information */
 struct lock_file;
 void preload_index(struct index_state *index,
-			  const struct pathspec *pathspec,
-			  unsigned int refresh_flags);
+		   const struct pathspec *pathspec,
+		   unsigned int refresh_flags);
 int do_read_index(struct index_state *istate, const char *path,
-			 int must_exist); /* for testting only! */
+		  int must_exist); /* for testting only! */
 int read_index_from(struct index_state *, const char *path,
-			   const char *gitdir);
+		    const char *gitdir);
 int is_index_unborn(struct index_state *);
 
 /* For use with `write_locked_index()`. */
@@ -718,8 +718,8 @@ int unmerged_index(const struct index_state *);
  * to it.
  */
 int repo_index_has_changes(struct repository *repo,
-				  struct tree *tree,
-				  struct strbuf *sb);
+			   struct tree *tree,
+			   struct strbuf *sb);
 
 int verify_path(const char *path, unsigned mode);
 int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
@@ -797,7 +797,7 @@ void *read_blob_data_from_index(const struct index_state *, const char *, unsign
 /* don't refresh_fsmonitor state or do stat comparison even if CE_FSMONITOR_VALID is true */
 #define CE_MATCH_IGNORE_FSMONITOR 0X20
 int is_racy_timestamp(const struct index_state *istate,
-			     const struct cache_entry *ce);
+		      const struct cache_entry *ce);
 int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
@@ -821,7 +821,7 @@ void fill_stat_data(struct stat_data *sd, struct stat *st);
  */
 int match_stat_data(const struct stat_data *sd, struct stat *st);
 int match_stat_data_racy(const struct index_state *istate,
-				const struct stat_data *sd, struct stat *st);
+			 const struct stat_data *sd, struct stat *st);
 
 void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
@@ -1386,8 +1386,8 @@ int get_oid_treeish(const char *str, struct object_id *oid);
 int get_oid_blob(const char *str, struct object_id *oid);
 void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
 enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
-				unsigned flags, struct object_id *oid,
-				struct object_context *oc);
+					 unsigned flags, struct object_id *oid,
+					 struct object_context *oc);
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
 int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
@@ -1469,7 +1469,7 @@ int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
 #define INTERPRET_BRANCH_REMOTE (1<<1)
 #define INTERPRET_BRANCH_HEAD (1<<2)
 int interpret_branch_name(const char *str, int len, struct strbuf *,
-				 unsigned allowed);
+			  unsigned allowed);
 int get_oid_mb(const char *str, struct object_id *oid);
 
 int validate_headref(const char *ref);
@@ -1480,12 +1480,12 @@ int name_compare(const char *name1, size_t len1, const char *name2, size_t len2)
 int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
 void *read_object_with_reference(const struct object_id *oid,
-					const char *required_type,
-					unsigned long *size,
-					struct object_id *oid_ret);
+				 const char *required_type,
+				 unsigned long *size,
+				 struct object_id *oid_ret);
 
 struct object *peel_to_type(const char *name, int namelen,
-				   struct object *o, enum object_type);
+			    struct object *o, enum object_type);
 
 enum date_mode_type {
 	DATE_NORMAL = 0,
@@ -1542,8 +1542,8 @@ enum want_ident {
 const char *git_author_info(int);
 const char *git_committer_info(int);
 const char *fmt_ident(const char *name, const char *email,
-		enum want_ident whose_ident,
-		const char *date_str, int);
+		      enum want_ident whose_ident,
+		      const char *date_str, int);
 const char *fmt_name(enum want_ident);
 const char *ident_default_name(void);
 const char *ident_default_email(void);
diff --git a/checkout.h b/checkout.h
index a6f5180436..1152133bd7 100644
--- a/checkout.h
+++ b/checkout.h
@@ -9,7 +9,7 @@
  * exists, NULL otherwise.
  */
 const char *unique_tracking_name(const char *name,
-					struct object_id *oid,
-					int *dwim_remotes_matched);
+				 struct object_id *oid,
+				 int *dwim_remotes_matched);
 
 #endif /* CHECKOUT_H */
diff --git a/column.h b/column.h
index 72cf539667..448c7440b3 100644
--- a/column.h
+++ b/column.h
@@ -29,7 +29,7 @@ struct column_options {
 struct option;
 int parseopt_column_callback(const struct option *, const char *, int);
 int git_column_config(const char *var, const char *value,
-			     const char *command, unsigned int *colopts);
+		      const char *command, unsigned int *colopts);
 int finalize_colopts(unsigned int *colopts, int stdout_is_tty);
 static inline int column_active(unsigned int colopts)
 {
@@ -38,7 +38,7 @@ static inline int column_active(unsigned int colopts)
 
 struct string_list;
 void print_columns(const struct string_list *list, unsigned int colopts,
-			  const struct column_options *opts);
+		   const struct column_options *opts);
 
 int run_column_filter(int colopts, const struct column_options *);
 int stop_column_filter(void);
diff --git a/commit.h b/commit.h
index 40744e1bed..18f05c64d8 100644
--- a/commit.h
+++ b/commit.h
@@ -179,8 +179,8 @@ struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 int has_non_ascii(const char *text);
 const char *logmsg_reencode(const struct commit *commit,
-				   char **commit_encoding,
-				   const char *output_encoding);
+			    char **commit_encoding,
+			    const char *output_encoding);
 const char *repo_logmsg_reencode(struct repository *r,
 				 const struct commit *commit,
 				 char **commit_encoding,
@@ -245,15 +245,15 @@ int unregister_shallow(const struct object_id *oid);
 int for_each_commit_graft(each_commit_graft_fn, void *);
 int is_repository_shallow(struct repository *r);
 struct commit_list *get_shallow_commits(struct object_array *heads,
-		int depth, int shallow_flag, int not_shallow_flag);
+					int depth, int shallow_flag, int not_shallow_flag);
 struct commit_list *get_shallow_commits_by_rev_list(
 		int ac, const char **av, int shallow_flag, int not_shallow_flag);
 void set_alternate_shallow_file(struct repository *r, const char *path, int override);
 int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
-				 const struct oid_array *extra);
+			  const struct oid_array *extra);
 void setup_alternate_shallow(struct lock_file *shallow_lock,
-				    const char **alternate_shallow_file,
-				    const struct oid_array *extra);
+			     const char **alternate_shallow_file,
+			     const struct oid_array *extra);
 const char *setup_temporary_shallow(const struct oid_array *extra);
 void advertise_shallow_grafts(int);
 
@@ -276,8 +276,8 @@ void prepare_shallow_info(struct shallow_info *, struct oid_array *);
 void clear_shallow_info(struct shallow_info *);
 void remove_nonexistent_theirs_shallow(struct shallow_info *);
 void assign_shallow_commits_to_refs(struct shallow_info *info,
-					   uint32_t **used,
-					   int *ref_status);
+				    uint32_t **used,
+				    int *ref_status);
 int delayed_reachability_test(struct shallow_info *si, int c);
 #define PRUNE_SHOW_ONLY 1
 #define PRUNE_QUICK 2
@@ -286,7 +286,7 @@ extern struct trace_key trace_shallow;
 
 int interactive_add(int argc, const char **argv, const char *prefix, int patch);
 int run_add_interactive(const char *revision, const char *patch_mode,
-			       const struct pathspec *pathspec);
+			const struct pathspec *pathspec);
 
 struct commit_extra_header {
 	struct commit_extra_header *next;
@@ -296,19 +296,19 @@ struct commit_extra_header {
 };
 
 void append_merge_tag_headers(struct commit_list *parents,
-				     struct commit_extra_header ***tail);
+			      struct commit_extra_header ***tail);
 
 int commit_tree(const char *msg, size_t msg_len,
-		       const struct object_id *tree,
-		       struct commit_list *parents, struct object_id *ret,
-		       const char *author, const char *sign_commit);
+		const struct object_id *tree,
+		struct commit_list *parents, struct object_id *ret,
+		const char *author, const char *sign_commit);
 
 int commit_tree_extended(const char *msg, size_t msg_len,
-				const struct object_id *tree,
-				struct commit_list *parents,
-				struct object_id *ret, const char *author,
-				const char *sign_commit,
-				struct commit_extra_header *);
+			 const struct object_id *tree,
+			 struct commit_list *parents,
+			 struct object_id *ret, const char *author,
+			 const char *sign_commit,
+			 struct commit_extra_header *);
 
 struct commit_extra_header *read_commit_extra_headers(struct commit *, const char **);
 
@@ -323,13 +323,13 @@ void free_commit_extra_headers(struct commit_extra_header *extra);
  * responsibility to parse further in this case!
  */
 const char *find_commit_header(const char *msg, const char *key,
-				      size_t *out_len);
+			       size_t *out_len);
 
 /* Find the end of the log message, the right place for a new trailer. */
 size_t ignore_non_trailer(const char *buf, size_t len);
 
 typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
-				 void *cb_data);
+				void *cb_data);
 
 int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
 
@@ -339,7 +339,7 @@ struct merge_remote_desc {
 };
 struct merge_remote_desc *merge_remote_util(struct commit *);
 void set_merge_remote_desc(struct commit *commit,
-				  const char *name, struct object *obj);
+			   const char *name, struct object *obj);
 
 /*
  * Given "name" from the command line to merge, find the commit object
@@ -349,7 +349,7 @@ void set_merge_remote_desc(struct commit *commit,
 struct commit *get_merge_parent(const char *name);
 
 int parse_signed_commit(const struct commit *commit,
-			       struct strbuf *message, struct strbuf *signature);
+			struct strbuf *message, struct strbuf *signature);
 int remove_signature(struct strbuf *buf);
 
 /*
diff --git a/compat/obstack.h b/compat/obstack.h
index 168d1d8b38..8cf882323b 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -184,10 +184,10 @@ struct obstack		/* control current object in current chunk */
 
 void _obstack_newchunk (struct obstack *, int);
 int _obstack_begin (struct obstack *, int, int,
-			    void *(*) (long), void (*) (void *));
+		    void *(*) (long), void (*) (void *));
 int _obstack_begin_1 (struct obstack *, int, int,
-			     void *(*) (void *, long),
-			     void (*) (void *, void *), void *);
+		      void *(*) (void *, long),
+		      void (*) (void *, void *), void *);
 int _obstack_memory_used (struct obstack *);
 
 void obstack_free (struct obstack *, void *);
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 16b0b4def3..e64e79469d 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -471,7 +471,7 @@ reg_syntax_t re_set_syntax (reg_syntax_t __syntax);
    and syntax given by the global `re_syntax_options', into the buffer
    BUFFER.  Return NULL if successful, and an error string if not.  */
 const char *re_compile_pattern (const char *__pattern, size_t __length,
-				       struct re_pattern_buffer *__buffer);
+				struct re_pattern_buffer *__buffer);
 
 
 /* Compile a fastmap for the compiled pattern in BUFFER; used to
@@ -486,29 +486,29 @@ int re_compile_fastmap (struct re_pattern_buffer *__buffer);
    match, or -2 for an internal error.  Also return register
    information in REGS (if REGS and BUFFER->no_sub are nonzero).  */
 int re_search (struct re_pattern_buffer *__buffer, const char *__cstring,
-		      int __length, int __start, int __range,
-		      struct re_registers *__regs);
+	       int __length, int __start, int __range,
+	       struct re_registers *__regs);
 
 
 /* Like `re_search', but search in the concatenation of STRING1 and
    STRING2.  Also, stop searching at index START + STOP.  */
 int re_search_2 (struct re_pattern_buffer *__buffer,
-			const char *__string1, int __length1,
-			const char *__string2, int __length2, int __start,
-			int __range, struct re_registers *__regs, int __stop);
+		 const char *__string1, int __length1,
+		 const char *__string2, int __length2, int __start,
+		 int __range, struct re_registers *__regs, int __stop);
 
 
 /* Like `re_search', but return how many characters in STRING the regexp
    in BUFFER matched, starting at position START.  */
 int re_match (struct re_pattern_buffer *__buffer, const char *__cstring,
-		     int __length, int __start, struct re_registers *__regs);
+	      int __length, int __start, struct re_registers *__regs);
 
 
 /* Relates to `re_match' as `re_search_2' relates to `re_search'.  */
 int re_match_2 (struct re_pattern_buffer *__buffer,
-		       const char *__string1, int __length1,
-		       const char *__string2, int __length2, int __start,
-		       struct re_registers *__regs, int __stop);
+		const char *__string1, int __length1,
+		const char *__string2, int __length2, int __start,
+		struct re_registers *__regs, int __stop);
 
 
 /* Set REGS to hold NUM_REGS registers, storing them in STARTS and
@@ -524,9 +524,9 @@ int re_match_2 (struct re_pattern_buffer *__buffer,
    PATTERN_BUFFER will allocate its own register data, without
    freeing the old data.  */
 void re_set_registers (struct re_pattern_buffer *__buffer,
-			      struct re_registers *__regs,
-			      unsigned int __num_regs,
-			      regoff_t *__starts, regoff_t *__ends);
+		       struct re_registers *__regs,
+		       unsigned int __num_regs,
+		       regoff_t *__starts, regoff_t *__ends);
 #endif	/* Use GNU */
 
 #if defined _REGEX_RE_COMP || (defined _LIBC && defined __USE_BSD)
@@ -560,16 +560,16 @@ int re_exec (const char *);
 
 /* POSIX compatibility.  */
 int regcomp (regex_t *__restrict __preg,
-		    const char *__restrict __pattern,
-		    int __cflags);
+	     const char *__restrict __pattern,
+	     int __cflags);
 
 int regexec (const regex_t *__restrict __preg,
-		    const char *__restrict __cstring, size_t __nmatch,
-		    regmatch_t __pmatch[__restrict_arr],
-		    int __eflags);
+	     const char *__restrict __cstring, size_t __nmatch,
+	     regmatch_t __pmatch[__restrict_arr],
+	     int __eflags);
 
 size_t regerror (int __errcode, const regex_t *__restrict __preg,
-			char *__restrict __errbuf, size_t __errbuf_size);
+		 char *__restrict __errbuf, size_t __errbuf_size);
 
 void regfree (regex_t *__preg);
 
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index f1cfe73de9..737983d00b 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -51,7 +51,7 @@ typedef struct {
 } pthread_t;
 
 int pthread_create(pthread_t *thread, const void *unused,
-			  void *(*start_routine)(void*), void *arg);
+		   void *(*start_routine)(void*), void *arg);
 
 /*
  * To avoid the need of copying a struct, we use small macro wrapper to pass
diff --git a/config.h b/config.h
index 1482b9b7fa..c275fe2284 100644
--- a/config.h
+++ b/config.h
@@ -71,22 +71,22 @@ typedef int (*config_fn_t)(const char *, const char *, void *);
 int git_default_config(const char *, const char *, void *);
 int git_config_from_file(config_fn_t fn, const char *, void *);
 int git_config_from_file_with_options(config_fn_t fn, const char *,
-					     void *,
-					     const struct config_options *);
+				      void *,
+				      const struct config_options *);
 int git_config_from_mem(config_fn_t fn,
-			       const enum config_origin_type,
-			       const char *name,
-			       const char *buf, size_t len,
-			       void *data, const struct config_options *opts);
+			const enum config_origin_type,
+			const char *name,
+			const char *buf, size_t len,
+			void *data, const struct config_options *opts);
 int git_config_from_blob_oid(config_fn_t fn, const char *name,
-				    const struct object_id *oid, void *data);
+			     const struct object_id *oid, void *data);
 void git_config_push_parameter(const char *text);
 int git_config_from_parameters(config_fn_t fn, void *data);
 void read_early_config(config_fn_t cb, void *data);
 void git_config(config_fn_t fn, void *);
 int config_with_options(config_fn_t fn, void *,
-			       struct git_config_source *config_source,
-			       const struct config_options *opts);
+			struct git_config_source *config_source,
+			const struct config_options *opts);
 int git_parse_ssize_t(const char *, ssize_t *);
 int git_parse_ulong(const char *, unsigned long *);
 int git_parse_maybe_bool(const char *);
@@ -160,9 +160,9 @@ int git_config_include(const char *name, const char *value, void *data);
  * there is no subsection at all.
  */
 int parse_config_key(const char *var,
-			    const char *section,
-			    const char **subsection, int *subsection_len,
-			    const char **key);
+		     const char *section,
+		     const char **subsection, int *subsection_len,
+		     const char **key);
 
 struct config_set_element {
 	struct hashmap_entry ent;
@@ -215,25 +215,25 @@ int git_configset_get_pathname(struct config_set *cs, const char *key, const cha
 struct repository;
 void repo_config(struct repository *repo, config_fn_t fn, void *data);
 int repo_config_get_value(struct repository *repo,
-				 const char *key, const char **value);
+			  const char *key, const char **value);
 const struct string_list *repo_config_get_value_multi(struct repository *repo,
-							     const char *key);
+						      const char *key);
 int repo_config_get_string_const(struct repository *repo,
-					const char *key, const char **dest);
+				 const char *key, const char **dest);
 int repo_config_get_string(struct repository *repo,
-				  const char *key, char **dest);
+			   const char *key, char **dest);
 int repo_config_get_int(struct repository *repo,
-			       const char *key, int *dest);
+			const char *key, int *dest);
 int repo_config_get_ulong(struct repository *repo,
-				 const char *key, unsigned long *dest);
+			  const char *key, unsigned long *dest);
 int repo_config_get_bool(struct repository *repo,
-				const char *key, int *dest);
+			 const char *key, int *dest);
 int repo_config_get_bool_or_int(struct repository *repo,
-				       const char *key, int *is_bool, int *dest);
+				const char *key, int *is_bool, int *dest);
 int repo_config_get_maybe_bool(struct repository *repo,
-				      const char *key, int *dest);
+			       const char *key, int *dest);
 int repo_config_get_pathname(struct repository *repo,
-				    const char *key, const char **dest);
+			     const char *key, const char **dest);
 
 int git_config_get_value(const char *key, const char **value);
 const struct string_list *git_config_get_value_multi(const char *key);
diff --git a/connect.h b/connect.h
index 61a005603a..5f2382e018 100644
--- a/connect.h
+++ b/connect.h
@@ -20,6 +20,6 @@ enum protocol_version discover_version(struct packet_reader *reader);
 
 int server_supports_v2(const char *c, int die_on_error);
 int server_supports_feature(const char *c, const char *feature,
-				   int die_on_error);
+			    int die_on_error);
 
 #endif
diff --git a/delta.h b/delta.h
index 0fc3659633..2df5fe13d9 100644
--- a/delta.h
+++ b/delta.h
@@ -76,8 +76,8 @@ diff_delta(const void *src_buf, unsigned long src_bufsize,
  * returned.  The returned buffer must be freed by the caller.
  */
 void *patch_delta(const void *src_buf, unsigned long src_size,
-			 const void *delta_buf, unsigned long delta_size,
-			 unsigned long *dst_size);
+		  const void *delta_buf, unsigned long delta_size,
+		  unsigned long *dst_size);
 
 /* the smallest possible delta size is 4 bytes */
 #define DELTA_SIZE_MIN	4
diff --git a/dir.h b/dir.h
index 4c227cc3dc..2e6fcba389 100644
--- a/dir.h
+++ b/dir.h
@@ -217,23 +217,23 @@ int simple_length(const char *match);
 int no_wildcard(const char *string);
 char *common_prefix(const struct pathspec *pathspec);
 int match_pathspec(const struct index_state *istate,
-			  const struct pathspec *pathspec,
-			  const char *name, int namelen,
-			  int prefix, char *seen, int is_dir);
+		   const struct pathspec *pathspec,
+		   const char *name, int namelen,
+		   int prefix, char *seen, int is_dir);
 int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
 int within_depth(const char *name, int namelen, int depth, int max_depth);
 
 int fill_directory(struct dir_struct *dir,
-			  struct index_state *istate,
-			  const struct pathspec *pathspec);
+		   struct index_state *istate,
+		   const struct pathspec *pathspec);
 int read_directory(struct dir_struct *, struct index_state *istate,
-			  const char *path, int len,
-			  const struct pathspec *pathspec);
+		   const char *path, int len,
+		   const struct pathspec *pathspec);
 
 int is_excluded_from_list(const char *pathname, int pathlen,
-				 const char *basename, int *dtype,
-				 struct exclude_list *el,
-				 struct index_state *istate);
+			  const char *basename, int *dtype,
+			  struct exclude_list *el,
+			  struct index_state *istate);
 struct dir_entry *dir_add_ignored(struct dir_struct *dir,
 				  struct index_state *istate,
 				  const char *pathname, int len);
@@ -243,30 +243,30 @@ struct dir_entry *dir_add_ignored(struct dir_struct *dir,
  * attr.c:path_matches()
  */
 int match_basename(const char *, int,
-			  const char *, int, int, unsigned);
+		   const char *, int, int, unsigned);
 int match_pathname(const char *, int,
-			  const char *, int,
-			  const char *, int, int, unsigned);
+		   const char *, int,
+		   const char *, int, int, unsigned);
 
 struct exclude *last_exclude_matching(struct dir_struct *dir,
-					     struct index_state *istate,
-					     const char *name, int *dtype);
+				      struct index_state *istate,
+				      const char *name, int *dtype);
 
 int is_excluded(struct dir_struct *dir,
-		       struct index_state *istate,
-		       const char *name, int *dtype);
+		struct index_state *istate,
+		const char *name, int *dtype);
 
 struct exclude_list *add_exclude_list(struct dir_struct *dir,
-					     int group_type, const char *src);
+				      int group_type, const char *src);
 int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
-					  struct exclude_list *el, struct  index_state *istate);
+				   struct exclude_list *el, struct  index_state *istate);
 void add_excludes_from_file(struct dir_struct *, const char *fname);
 int add_excludes_from_blob_to_list(struct object_id *oid,
-					  const char *base, int baselen,
-					  struct exclude_list *el);
+				   const char *base, int baselen,
+				   struct exclude_list *el);
 void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
 void add_exclude(const char *string, const char *base,
-			int baselen, struct exclude_list *el, int srcpos);
+		 int baselen, struct exclude_list *el, int srcpos);
 void clear_exclude_list(struct exclude_list *el);
 void clear_directory(struct dir_struct *dir);
 int file_exists(const char *);
@@ -324,13 +324,13 @@ int fspathncmp(const char *a, const char *b, size_t count);
  */
 struct pathspec_item;
 int git_fnmatch(const struct pathspec_item *item,
-		       const char *pattern, const char *string,
-		       int prefix);
+		const char *pattern, const char *string,
+		int prefix);
 
 int submodule_path_match(const struct index_state *istate,
-				const struct pathspec *ps,
-				const char *submodule_name,
-				char *seen);
+			 const struct pathspec *ps,
+			 const char *submodule_name,
+			 char *seen);
 
 static inline int ce_path_match(const struct index_state *istate,
 				const struct cache_entry *ce,
@@ -373,9 +373,9 @@ void remove_untracked_cache(struct index_state *istate);
  * connecting them as well.
  */
 void connect_work_tree_and_git_dir(const char *work_tree,
-					  const char *git_dir,
-					  int recurse_into_nested);
+				   const char *git_dir,
+				   int recurse_into_nested);
 void relocate_gitdir(const char *path,
-			    const char *old_git_dir,
-			    const char *new_git_dir);
+		     const char *old_git_dir,
+		     const char *new_git_dir);
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index cc2cd27f30..eb3de5372f 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -770,13 +770,13 @@ FILE *git_fopen(const char*, const char*);
 #endif
 #define snprintf git_snprintf
 int git_snprintf(char *str, size_t maxsize,
-			const char *format, ...);
+		 const char *format, ...);
 #ifdef vsnprintf
 #undef vsnprintf
 #endif
 #define vsnprintf git_vsnprintf
 int git_vsnprintf(char *str, size_t maxsize,
-			 const char *format, va_list ap);
+		  const char *format, va_list ap);
 #endif
 
 #ifdef __GLIBC_PREREQ
diff --git a/help.h b/help.h
index ca004a7a7d..b8780fbd0f 100644
--- a/help.h
+++ b/help.h
@@ -27,12 +27,12 @@ void list_config_help(int for_human);
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
 void list_cmds_by_category(struct string_list *list,
-				  const char *category);
+			   const char *category);
 void list_cmds_by_config(struct string_list *list);
 const char *help_unknown_cmd(const char *cmd);
 void load_command_list(const char *prefix,
-			      struct cmdnames *main_cmds,
-			      struct cmdnames *other_cmds);
+		       struct cmdnames *main_cmds,
+		       struct cmdnames *other_cmds);
 void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
 void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
diff --git a/http.h b/http.h
index 32156bf7f1..c197e4ff79 100644
--- a/http.h
+++ b/http.h
@@ -104,7 +104,7 @@ void step_active_slots(void);
 #endif
 
 void http_init(struct remote *remote, const char *url,
-		      int proactive_auth);
+	       int proactive_auth);
 void http_cleanup(void);
 struct curl_slist *http_copy_default_headers(void);
 
@@ -147,10 +147,10 @@ void normalize_curl_result(CURLcode *result, long http_code, char *errorstr,
 
 /* Helpers for modifying and creating URLs */
 void append_remote_object_url(struct strbuf *buf, const char *url,
-				     const char *hex,
-				     int only_two_digit_prefix);
+			      const char *hex,
+			      int only_two_digit_prefix);
 char *get_remote_object_url(const char *url, const char *hex,
-				   int only_two_digit_prefix);
+			    int only_two_digit_prefix);
 
 /* Options for http_get_*() */
 struct http_get_options {
@@ -208,7 +208,7 @@ int http_fetch_ref(const char *base, struct ref *ref);
 
 /* Helpers for fetching packs */
 int http_get_info_packs(const char *base_url,
-	struct packed_git **packs_head);
+			struct packed_git **packs_head);
 
 struct http_pack_request {
 	char *url;
diff --git a/khash.h b/khash.h
index 3d25667a82..642c0e6e0c 100644
--- a/khash.h
+++ b/khash.h
@@ -69,11 +69,11 @@ static const double __ac_HASH_UPPER = 0.77;
 		khval_t *vals; \
 	} kh_##name##_t;
 
-#define __KHASH_PROTOTYPES(name, khkey_t, khval_t)	 					\
-	kh_##name##_t *kh_init_##name(void);							\
+#define __KHASH_PROTOTYPES(name, khkey_t, khval_t)	 			\
+	kh_##name##_t *kh_init_##name(void);						\
 	void kh_destroy_##name(kh_##name##_t *h);					\
 	void kh_clear_##name(kh_##name##_t *h);						\
-	khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); 	\
+	khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); \
 	int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
 	khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
 	void kh_del_##name(kh_##name##_t *h, khint_t x);
diff --git a/lockfile.h b/lockfile.h
index c81983a925..9843053ce8 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -189,7 +189,7 @@ static inline int is_lock_file_locked(struct lock_file *lk)
  * `errno` set by the failing call.
  */
 void unable_to_lock_message(const char *path, int err,
-				   struct strbuf *buf);
+			    struct strbuf *buf);
 
 /*
  * Emit an appropriate error message and `die()` following the failure
diff --git a/ls-refs.h b/ls-refs.h
index 702d47ad70..7e5646f5f6 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -5,6 +5,6 @@ struct repository;
 struct argv_array;
 struct packet_reader;
 int ls_refs(struct repository *r, struct argv_array *keys,
-		   struct packet_reader *request);
+	    struct packet_reader *request);
 
 #endif /* LS_REFS_H */
diff --git a/merge-blobs.h b/merge-blobs.h
index 863a7e0807..13cf9669e5 100644
--- a/merge-blobs.h
+++ b/merge-blobs.h
@@ -5,7 +5,7 @@ struct blob;
 struct index_state;
 
 void *merge_blobs(struct index_state *, const char *,
-			 struct blob *, struct blob *,
-			 struct blob *, unsigned long *);
+		  struct blob *, struct blob *,
+		  struct blob *, unsigned long *);
 
 #endif /* MERGE_BLOBS_H */
diff --git a/object-store.h b/object-store.h
index 9700d1aca7..4a6ca2fd3a 100644
--- a/object-store.h
+++ b/object-store.h
@@ -163,9 +163,9 @@ void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);
 
 void *read_object_file_extended(struct repository *r,
-				       const struct object_id *oid,
-				       enum object_type *type,
-				       unsigned long *size, int lookup_replace);
+				const struct object_id *oid,
+				enum object_type *type,
+				unsigned long *size, int lookup_replace);
 static inline void *repo_read_object_file(struct repository *r,
 					  const struct object_id *oid,
 					  enum object_type *type,
@@ -181,17 +181,17 @@ static inline void *repo_read_object_file(struct repository *r,
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
 int hash_object_file(const void *buf, unsigned long len,
-			    const char *type, struct object_id *oid);
+		     const char *type, struct object_id *oid);
 
 int write_object_file(const void *buf, unsigned long len,
-			     const char *type, struct object_id *oid);
+		      const char *type, struct object_id *oid);
 
 int hash_object_file_literally(const void *buf, unsigned long len,
-				      const char *type, struct object_id *oid,
-				      unsigned flags);
+			       const char *type, struct object_id *oid,
+			       unsigned flags);
 
 int pretend_object_file(void *, unsigned long, enum object_type,
-			       struct object_id *oid);
+			struct object_id *oid);
 
 int force_object_loose(const struct object_id *oid, time_t mtime);
 
diff --git a/oidmap.h b/oidmap.h
index 91b2ed0f51..7a939461ff 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -47,7 +47,7 @@ void oidmap_free(struct oidmap *map, int free_entries);
  * Returns the oidmap entry for the specified oid, or NULL if not found.
  */
 void *oidmap_get(const struct oidmap *map,
-			const struct object_id *key);
+		 const struct object_id *key);
 
 /*
  * Adds or replaces an oidmap entry.
diff --git a/pack.h b/pack.h
index de941858c5..9fc0945ac9 100644
--- a/pack.h
+++ b/pack.h
@@ -93,7 +93,7 @@ char *index_pack_lockfile(int fd);
  */
 #define MAX_PACK_OBJECT_HEADER 10
 int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
-					enum object_type, uintmax_t);
+				 enum object_type, uintmax_t);
 
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
diff --git a/packfile.h b/packfile.h
index 0e051ad5d3..f2d7dd2322 100644
--- a/packfile.h
+++ b/packfile.h
@@ -60,7 +60,7 @@ struct packed_git *get_all_packs(struct repository *r);
 unsigned long approximate_object_count(void);
 
 struct packed_git *find_sha1_pack(const unsigned char *sha1,
-					 struct packed_git *packs);
+				  struct packed_git *packs);
 
 void pack_report(void);
 
@@ -144,8 +144,8 @@ void release_pack_memory(size_t);
 extern int do_check_packed_object_crc;
 
 int packed_object_info(struct repository *r,
-			      struct packed_git *pack,
-			      off_t offset, struct object_info *);
+		       struct packed_git *pack,
+		       off_t offset, struct object_info *);
 
 void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
 const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
@@ -177,6 +177,6 @@ int is_promisor_object(const struct object_id *oid);
  * probably use open_pack_index() or parse_pack_index() instead.
  */
 int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
-		    size_t idx_size, struct packed_git *p);
+	     size_t idx_size, struct packed_git *p);
 
 #endif
diff --git a/path.h b/path.h
index 0efbd4fb0d..2ba6ca58c8 100644
--- a/path.h
+++ b/path.h
@@ -38,8 +38,8 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
  * append it in the provided buffer `sb`.
  */
 void strbuf_git_common_path(struct strbuf *sb,
-				   const struct repository *repo,
-				   const char *fmt, ...)
+			    const struct repository *repo,
+			    const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
 /*
@@ -67,7 +67,7 @@ const char *git_common_path(const char *fmt, ...)
  * Return a path into the git directory of repository `repo`.
  */
 char *repo_git_path(const struct repository *repo,
-			   const char *fmt, ...)
+		    const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
 /*
@@ -75,8 +75,8 @@ char *repo_git_path(const struct repository *repo,
  * to the provided buffer `sb`.
  */
 void strbuf_repo_git_path(struct strbuf *sb,
-				 const struct repository *repo,
-				 const char *fmt, ...)
+			  const struct repository *repo,
+			  const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
 /*
diff --git a/pkt-line.h b/pkt-line.h
index 1ebeaff236..5c62015db4 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -173,8 +173,8 @@ struct packet_reader {
  * abstraction around the 'packet_read_with_status()' function.
  */
 void packet_reader_init(struct packet_reader *reader, int fd,
-			       char *src_buffer, size_t src_len,
-			       int options);
+			char *src_buffer, size_t src_len,
+			int options);
 
 /*
  * Perform a packet read and return the status of the read.
diff --git a/ppc/sha1.c b/ppc/sha1.c
index b5d8af4551..1b705cee1f 100644
--- a/ppc/sha1.c
+++ b/ppc/sha1.c
@@ -11,7 +11,7 @@
 #include "sha1.h"
 
 void ppc_sha1_core(uint32_t *hash, const unsigned char *p,
-			  unsigned int nblocks);
+		   unsigned int nblocks);
 
 int ppc_SHA1_Init(ppc_SHA_CTX *c)
 {
diff --git a/quote.h b/quote.h
index 86c0d944b5..fb08dc085c 100644
--- a/quote.h
+++ b/quote.h
@@ -68,7 +68,7 @@ void quote_two_c_style(struct strbuf *, const char *, const char *, int);
 
 void write_name_quoted(const char *name, FILE *, int terminator);
 void write_name_quoted_relative(const char *name, const char *prefix,
-		FILE *fp, int terminator);
+				FILE *fp, int terminator);
 
 /* quote path as relative to the given prefix */
 char *quote_path_relative(const char *in, const char *prefix,
diff --git a/reachable.h b/reachable.h
index aef2b877a5..5df932ad8f 100644
--- a/reachable.h
+++ b/reachable.h
@@ -5,8 +5,8 @@ struct progress;
 struct rev_info;
 
 int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
-						  timestamp_t timestamp);
+					   timestamp_t timestamp);
 void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
-				   timestamp_t mark_recent, struct progress *);
+			    timestamp_t mark_recent, struct progress *);
 
 #endif
diff --git a/reflog-walk.h b/reflog-walk.h
index c83597d1db..f26408f6cc 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -8,17 +8,17 @@ struct reflog_walk_info;
 
 void init_reflog_walk(struct reflog_walk_info **info);
 int add_reflog_for_walk(struct reflog_walk_info *info,
-		struct commit *commit, const char *name);
+			struct commit *commit, const char *name);
 void show_reflog_message(struct reflog_walk_info *info, int,
-				const struct date_mode *, int force_date);
+			 const struct date_mode *, int force_date);
 void get_reflog_message(struct strbuf *sb,
-		struct reflog_walk_info *reflog_info);
+			struct reflog_walk_info *reflog_info);
 const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
 timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
 void get_reflog_selector(struct strbuf *sb,
-		struct reflog_walk_info *reflog_info,
-		const struct date_mode *dmode, int force_date,
-		int shorten);
+			 struct reflog_walk_info *reflog_info,
+			 const struct date_mode *dmode, int force_date,
+			 int shorten);
 
 int reflog_walk_empty(struct reflog_walk_info *walk);
 
diff --git a/remote.h b/remote.h
index 7b1eed6008..62bda7ef03 100644
--- a/remote.h
+++ b/remote.h
@@ -140,15 +140,15 @@ struct packet_reader;
 struct argv_array;
 struct string_list;
 struct ref **get_remote_heads(struct packet_reader *reader,
-				     struct ref **list, unsigned int flags,
-				     struct oid_array *extra_have,
-				     struct oid_array *shallow_points);
+			      struct ref **list, unsigned int flags,
+			      struct oid_array *extra_have,
+			      struct oid_array *shallow_points);
 
 /* Used for protocol v2 in order to retrieve refs from a remote */
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
-				    struct ref **list, int for_push,
-				    const struct argv_array *ref_prefixes,
-				    const struct string_list *server_options);
+			     struct ref **list, int for_push,
+			     const struct argv_array *ref_prefixes,
+			     const struct string_list *server_options);
 
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
diff --git a/replace-object.h b/replace-object.h
index f438421e36..04ed7a85a2 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -17,7 +17,7 @@ void prepare_replace_object(struct repository *r);
  * lookup_replace_object().  Please do not call it directly.
  */
 const struct object_id *do_lookup_replace_object(struct repository *r,
-							const struct object_id *oid);
+						 const struct object_id *oid);
 
 /*
  * If object sha1 should be replaced, return the replacement object's
diff --git a/serve.h b/serve.h
index 48b6f5e479..42ddca7f8b 100644
--- a/serve.h
+++ b/serve.h
@@ -3,7 +3,7 @@
 
 struct argv_array;
 int has_capability(const struct argv_array *keys, const char *capability,
-			  const char **value);
+		   const char **value);
 
 struct serve_options {
 	unsigned advertise_capabilities;
diff --git a/sha1-lookup.h b/sha1-lookup.h
index 457c9b4964..5afcd011c6 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -4,9 +4,9 @@
 typedef const unsigned char *sha1_access_fn(size_t index, void *table);
 
 int sha1_pos(const unsigned char *sha1,
-		    void *table,
-		    size_t nr,
-		    sha1_access_fn fn);
+	     void *table,
+	     size_t nr,
+	     sha1_access_fn fn);
 
 /*
  * Searches for sha1 in table, using the given fanout table to determine the
diff --git a/string-list.h b/string-list.h
index 7d9df61ac3..f964399949 100644
--- a/string-list.h
+++ b/string-list.h
@@ -175,7 +175,7 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
  * doesn't exist, the list is not altered.
  */
 void string_list_remove(struct string_list *list, const char *string,
-			       int free_util);
+			int free_util);
 
 /**
  * Check if the given string is part of a sorted list. If it is part of the list,
diff --git a/sub-process.h b/sub-process.h
index 1653ae8afe..5c182fad98 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -43,9 +43,9 @@ struct subprocess_capability {
 
 /* Function to test two subprocess hashmap entries for equality. */
 int cmd2process_cmp(const void *unused_cmp_data,
-			   const void *e1,
-			   const void *e2,
-			   const void *unused_keydata);
+		    const void *e1,
+		    const void *e2,
+		    const void *unused_keydata);
 
 /*
  * User-supplied function to initialize the sub-process.  This is
diff --git a/submodule-config.h b/submodule-config.h
index a88ae7107f..1b4e2da658 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -36,7 +36,7 @@ int parse_submodule_fetchjobs(const char *var, const char *value);
 int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 struct option;
 int option_fetch_parse_recurse_submodules(const struct option *opt,
-						 const char *arg, int unset);
+					  const char *arg, int unset);
 int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 void repo_read_gitmodules(struct repository *repo);
diff --git a/tag.h b/tag.h
index e57490485e..03265fbfe2 100644
--- a/tag.h
+++ b/tag.h
@@ -18,6 +18,6 @@ void release_tag_memory(struct tag *t);
 struct object *deref_tag(struct repository *r, struct object *, const char *, int);
 struct object *deref_tag_noverify(struct object *);
 int gpg_verify_tag(const struct object_id *oid,
-		const char *name_to_report, unsigned flags);
+		   const char *name_to_report, unsigned flags);
 
 #endif /* TAG_H */
diff --git a/tempfile.h b/tempfile.h
index 7b05d5765e..cddda0a33c 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -137,7 +137,7 @@ struct tempfile *register_tempfile(const char *path);
 
 /* See "mks_tempfile functions" above. */
 struct tempfile *mks_tempfile_sm(const char *filename_template,
-					int suffixlen, int mode);
+				 int suffixlen, int mode);
 
 /* See "mks_tempfile functions" above. */
 static inline struct tempfile *mks_tempfile_s(const char *filename_template,
@@ -160,7 +160,7 @@ static inline struct tempfile *mks_tempfile(const char *filename_template)
 
 /* See "mks_tempfile functions" above. */
 struct tempfile *mks_tempfile_tsm(const char *filename_template,
-					 int suffixlen, int mode);
+				  int suffixlen, int mode);
 
 /* See "mks_tempfile functions" above. */
 static inline struct tempfile *mks_tempfile_ts(const char *filename_template,
diff --git a/trace.h b/trace.h
index 4ca2a5a63f..9fa3e7a594 100644
--- a/trace.h
+++ b/trace.h
@@ -133,18 +133,18 @@ void trace_performance_leave(const char *format, ...);
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
 void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
-				const char *format, ...);
+			 const char *format, ...);
 __attribute__((format (printf, 4, 5)))
 void trace_argv_printf_fl(const char *file, int line, const char **argv,
-				 const char *format, ...);
+			  const char *format, ...);
 void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
-			    const struct strbuf *data);
+		     const struct strbuf *data);
 __attribute__((format (printf, 4, 5)))
 void trace_performance_fl(const char *file, int line,
-				 uint64_t nanos, const char *fmt, ...);
+			  uint64_t nanos, const char *fmt, ...);
 __attribute__((format (printf, 4, 5)))
 void trace_performance_leave_fl(const char *file, int line,
-				       uint64_t nanos, const char *fmt, ...);
+				uint64_t nanos, const char *fmt, ...);
 static inline int trace_pass_fl(struct trace_key *key)
 {
 	return key->fd || !key->initialized;
diff --git a/upload-pack.h b/upload-pack.h
index bc2ceb211c..4bafe16a22 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -14,10 +14,10 @@ struct repository;
 struct argv_array;
 struct packet_reader;
 int upload_pack_v2(struct repository *r, struct argv_array *keys,
-			  struct packet_reader *request);
+		   struct packet_reader *request);
 
 struct strbuf;
 int upload_pack_advertise(struct repository *r,
-				 struct strbuf *value);
+			  struct strbuf *value);
 
 #endif /* UPLOAD_PACK_H */
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
index 023799a05c..625d950bb8 100644
--- a/vcs-svn/svndiff.h
+++ b/vcs-svn/svndiff.h
@@ -5,6 +5,6 @@ struct line_buffer;
 struct sliding_view;
 
 int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
-		struct sliding_view *preimage, FILE *postimage);
+		   struct sliding_view *preimage, FILE *postimage);
 
 #endif
diff --git a/worktree.h b/worktree.h
index 2d6a1d207a..caecc7a281 100644
--- a/worktree.h
+++ b/worktree.h
@@ -48,8 +48,8 @@ const char *get_worktree_git_dir(const struct worktree *wt);
  * "arg". "prefix" must not be NULL.
  */
 struct worktree *find_worktree(struct worktree **list,
-				      const char *prefix,
-				      const char *arg);
+			       const char *prefix,
+			       const char *arg);
 
 /*
  * Return true if the given worktree is the main one.
@@ -69,14 +69,14 @@ const char *worktree_lock_reason(struct worktree *wt);
  * returned if "errmsg" is not NULL.
  */
 int validate_worktree(const struct worktree *wt,
-			     struct strbuf *errmsg,
-			     unsigned flags);
+		      struct strbuf *errmsg,
+		      unsigned flags);
 
 /*
  * Update worktrees/xxx/gitdir with the new path.
  */
 void update_worktree_location(struct worktree *wt,
-				     const char *path_);
+			      const char *path_);
 
 /*
  * Free up the memory for worktree(s)
@@ -89,7 +89,7 @@ void free_worktrees(struct worktree **);
  * or NULL otherwise. The result may be destroyed by the next call.
  */
 const struct worktree *find_shared_symref(const char *symref,
-						 const char *target);
+					  const char *target);
 
 /*
  * Similar to head_ref() for all HEADs _except_ one from the current
@@ -105,7 +105,7 @@ int is_worktree_being_bisected(const struct worktree *wt, const char *target);
  * worktree instead of current one
  */
 const char *worktree_git_path(const struct worktree *wt,
-				     const char *fmt, ...)
+			      const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
 /*
diff --git a/xdiff-interface.h b/xdiff-interface.h
index a71950a10b..ede4246bbd 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -47,7 +47,7 @@ void discard_hunk_line(void *priv,
  * are treated for the comparision.
  */
 int xdiff_compare_lines(const char *l1, long s1,
-			       const char *l2, long s2, long flags);
+			const char *l2, long s2, long flags);
 
 /*
  * Returns a hash of the string s of length len.
-- 
2.21.0.832.gd5ec0d3bee

