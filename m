Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F8520248
	for <e@80x24.org>; Fri, 12 Apr 2019 23:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfDLXsa (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 19:48:30 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:37733 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726850AbfDLXsa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 19:48:30 -0400
Received: by mail-pg1-f180.google.com with SMTP id e6so5905445pgc.4
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=hPuLxP0Tk6s7S6mUatLQmxZyRV6GCnbLzyTac95Kt2k=;
        b=tbfR9bxNw0CXWWXpJkAERJoGoqT2Tmx1p8sWE9EK12adeJd4MGNpMgR/MsxXTvXc6h
         RrTHh3pmBmSeLITIEWXvyfn38iJ8O9Qan9WK0DWxCpDR4ArAnJMnFs0B2Vm3v/4ZdmDu
         2EgIHRSGstjNm/0+9Z8D8OWiNSLVqF1XUhpGGRUfjn1ZopmGRmEFkMeELC6nFGO8/Bh5
         euvYZA/QeOyUJUm9kBWmcpNmKHQOUzaHhlIGnntigI5srCGdt8zbtbO9q0nP+SGu/qKx
         h9htuDp/l9JonMhX7+JH49vnW2X+Vm80Vh3olyoJrHprgwKmFFpTERZdZwEBSP3kSuv3
         I7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hPuLxP0Tk6s7S6mUatLQmxZyRV6GCnbLzyTac95Kt2k=;
        b=TS1dYrw6b1aD2JQPEIHnZLZ8V9r7UeGrhyobAMbkvoKkQhiEC4kVSRIGIQ6gD76X7s
         4NYIVFdWXGwIUn2U93U/eTJHKKE9vUHQKKmJkkiuVPOmENg3d5HUYqsb3b6NmcH/jxgX
         05Ygs7J1OhEwXgfXRvGEIJEnWV9QGHrBCL2J+XeBFown/mNqkoKzlkw7FFK9Eq/Yuah2
         ZPYVhibvie7/D7RG201lG5DFYIxuIMMXoWW5yJbvzLE6zv37//0mYPoojipdCVbrmwAG
         5GLaw6dCI1VHWEWkUEqmX4GKsHkkzaQZEayITJ1kZp0y4Qe3V4kC0tOfPSFcUfwEo2mx
         LQuQ==
X-Gm-Message-State: APjAAAVIbtARCeiBPD9ZxTGi7W6D0aQLoJO2Qq7qzjXkiSfKAyo0JFu3
        ny8ePO5s1xFy+PZTWyOn1FkJ5qLx
X-Google-Smtp-Source: APXvYqzNC+xh5C0KGtIvagiVOgbAjP9q2Mc/BUM+SdKwzZcYV/UYGcYFkgjd3PjnzPAOsv5R85RflQ==
X-Received: by 2002:a63:ff26:: with SMTP id k38mr56115574pgi.123.1555112904024;
        Fri, 12 Apr 2019 16:48:24 -0700 (PDT)
Received: from dev-l ([149.28.200.39])
        by smtp.gmail.com with ESMTPSA id 19sm48232616pga.88.2019.04.12.16.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Apr 2019 16:48:22 -0700 (PDT)
Date:   Fri, 12 Apr 2019 16:48:21 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [RFC PATCH] *.h: remove extern from function declarations
Message-ID: <3e3b9d6c8e54b326809b95adabd3be39d2d0770f.1555111963.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There has been a push to remove extern from function declarations.
Finish the job by removing all instances of "extern" for function
declarations in headers.

This was done by running the following on my system:

	$ git ls-files '*.h' | xargs sed -i'' -e 's/^\(\s*\)extern \(.*(\)/\1\2/'

Then, leftover instances of extern were found by running

	$ git grep -w extern '*.h'

and manually checking the output. No other instances were found.

Not the most elegant way to do it but it gets the job done.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---

Junio mentioned that there was a push to drop extern from function
declarations in headers[1]. I decided to do a mass refactoring so we
could get rid of everything at once, although I'm not sure if that's
welcome. But I'll send the patch anyway since I already wrote it.

I merged my change with "pu" and these are the files that it conflicts
with:

	builtin.h
	cache.h
	config.h
	dir.h
	http.h
	packfile.h
	promisor-remote.h
	protocol.h
	tree-walk.h

Resolution is pretty easy, though:

	$ git merge -Xours --no-commit <THIS-BRANCH>
	$ git ls-files '*.h' | xargs sed -i'' -e 's/^\(\s*\)extern \(.*(\)/\1\2/'
	$ git commit -a

[1]: https://public-inbox.org/git/CAJoAoZnGAS5DOJoU_y+1t20kyxsDodFpQmwRd2_XZD9S2=pRLQ@mail.gmail.com/T/#mecda86088a2e98fb847e02981df9e54b151135ee

---
 advice.h                    |   2 +-
 archive.h                   |  14 +-
 bisect.h                    |  12 +-
 blame.h                     |   2 +-
 branch.h                    |  12 +-
 builtin.h                   | 252 +++++++++++++-------------
 bulk-checkin.h              |   6 +-
 cache.h                     | 344 ++++++++++++++++++------------------
 checkout.h                  |   2 +-
 column.h                    |  12 +-
 commit.h                    |  72 ++++----
 compat/mingw.h              |   6 +-
 compat/nedmalloc/malloc.c.h |   6 +-
 compat/obstack.h            |  10 +-
 compat/poll/poll.h          |   2 +-
 compat/regex/regex.h        |  28 +--
 compat/win32/pthread.h      |   6 +-
 config.h                    | 184 +++++++++----------
 connect.h                   |  20 +--
 csum-file.h                 |  20 +--
 decorate.h                  |   4 +-
 delta.h                     |   6 +-
 dir.h                       |  70 ++++----
 exec-cmd.h                  |  16 +-
 fmt-merge-msg.h             |   2 +-
 fsmonitor.h                 |  14 +-
 gettext.h                   |   8 +-
 git-compat-util.h           | 132 +++++++-------
 grep.h                      |  22 +--
 hashmap.h                   |  30 ++--
 help.h                      |  30 ++--
 http.h                      |  52 +++---
 khash.h                     |  14 +-
 kwset.h                     |  10 +-
 line-log.h                  |  16 +-
 lockfile.h                  |  10 +-
 ls-refs.h                   |   2 +-
 mailinfo.h                  |   6 +-
 merge-blobs.h               |   2 +-
 object-store.h              |  16 +-
 object.h                    |  12 +-
 oidmap.h                    |  10 +-
 pack.h                      |  24 +--
 packfile.h                  |  76 ++++----
 path.h                      |  32 ++--
 pkt-line.h                  |   6 +-
 prio-queue.h                |  10 +-
 protocol.h                  |   6 +-
 quote.h                     |  32 ++--
 reachable.h                 |   4 +-
 reflog-walk.h               |  16 +-
 refs.h                      |   2 +-
 remote.h                    |  12 +-
 replace-object.h            |   2 +-
 resolve-undo.h              |  14 +-
 run-command.h               |   8 +-
 serve.h                     |   4 +-
 sha1-lookup.h               |   2 +-
 streaming.h                 |   8 +-
 string-list.h               |   2 +-
 sub-process.h               |   2 +-
 submodule-config.h          |  20 +--
 tag.h                       |  14 +-
 tempfile.h                  |  26 +--
 trace.h                     |  34 ++--
 transport.h                 |   4 +-
 tree-walk.h                 |   4 +-
 upload-pack.h               |   4 +-
 url.h                       |  16 +-
 urlmatch.h                  |   4 +-
 utf8.h                      |   2 +-
 varint.h                    |   4 +-
 vcs-svn/sliding_window.h    |   2 +-
 vcs-svn/svndiff.h           |   2 +-
 worktree.h                  |  22 +--
 xdiff-interface.h           |  10 +-
 76 files changed, 963 insertions(+), 963 deletions(-)

diff --git a/advice.h b/advice.h
index f875f8cd8d..4a2052eecf 100644
--- a/advice.h
+++ b/advice.h
@@ -31,7 +31,7 @@ int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
 void advise(const char *advice, ...);
 int error_resolve_conflict(const char *me);
-extern void NORETURN die_resolve_conflict(const char *me);
+void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
 void detach_advice(const char *new_name);
 
diff --git a/archive.h b/archive.h
index 21ac010699..5afc11d0f8 100644
--- a/archive.h
+++ b/archive.h
@@ -23,7 +23,7 @@ struct archiver_args {
 
 /* main api */
 
-extern int write_archive(int argc, const char **argv, const char *prefix,
+int write_archive(int argc, const char **argv, const char *prefix,
 			 struct repository *repo,
 			 const char *name_hint, int remote);
 
@@ -39,19 +39,19 @@ struct archiver {
 	unsigned flags;
 	void *data;
 };
-extern void register_archiver(struct archiver *);
+void register_archiver(struct archiver *);
 
-extern void init_tar_archiver(void);
-extern void init_zip_archiver(void);
-extern void init_archivers(void);
+void init_tar_archiver(void);
+void init_zip_archiver(void);
+void init_archivers(void);
 
 typedef int (*write_archive_entry_fn_t)(struct archiver_args *args,
 					const struct object_id *oid,
 					const char *path, size_t pathlen,
 					unsigned int mode);
 
-extern int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
-extern void *object_file_to_archive(const struct archiver_args *args,
+int write_archive_entries(struct archiver_args *args, write_archive_entry_fn_t write_entry);
+void *object_file_to_archive(const struct archiver_args *args,
 				    const char *path, const struct object_id *oid,
 				    unsigned int mode, enum object_type *type,
 				    unsigned long *sizep);
diff --git a/bisect.h b/bisect.h
index 821d16e4dd..81ac43baa7 100644
--- a/bisect.h
+++ b/bisect.h
@@ -11,10 +11,10 @@ struct repository;
  * Otherwise, it will be either all non-SAMETREE commits or the single
  * best commit, as chosen by `find_all`.
  */
-extern void find_bisection(struct commit_list **list, int *reaches, int *all,
+void find_bisection(struct commit_list **list, int *reaches, int *all,
 			   int find_all);
 
-extern struct commit_list *filter_skipped(struct commit_list *list,
+struct commit_list *filter_skipped(struct commit_list *list,
 					  struct commit_list **tried,
 					  int show_all,
 					  int *count,
@@ -31,14 +31,14 @@ struct rev_list_info {
 	const char *header_prefix;
 };
 
-extern int bisect_next_all(struct repository *r,
+int bisect_next_all(struct repository *r,
 			   const char *prefix,
 			   int no_checkout);
 
-extern int estimate_bisect_steps(int all);
+int estimate_bisect_steps(int all);
 
-extern void read_bisect_terms(const char **bad, const char **good);
+void read_bisect_terms(const char **bad, const char **good);
 
-extern int bisect_clean_state(void);
+int bisect_clean_state(void);
 
 #endif
diff --git a/blame.h b/blame.h
index be3a895043..d6c4cc63f5 100644
--- a/blame.h
+++ b/blame.h
@@ -177,6 +177,6 @@ struct blame_entry *blame_entry_prepend(struct blame_entry *head,
 					long start, long end,
 					struct blame_origin *o);
 
-extern struct blame_origin *get_blame_suspects(struct commit *commit);
+struct blame_origin *get_blame_suspects(struct commit *commit);
 
 #endif /* BLAME_H */
diff --git a/branch.h b/branch.h
index 29c1afa4d0..f1f74d21e4 100644
--- a/branch.h
+++ b/branch.h
@@ -50,7 +50,7 @@ void create_branch(struct repository *r,
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-extern int validate_branchname(const char *name, struct strbuf *ref);
+int validate_branchname(const char *name, struct strbuf *ref);
 
 /*
  * Check if a branch 'name' can be created as a new branch; die otherwise.
@@ -58,7 +58,7 @@ extern int validate_branchname(const char *name, struct strbuf *ref);
  * Return 1 if the named branch already exists; return 0 otherwise.
  * Fill ref with the full refname for the branch.
  */
-extern int validate_new_branchname(const char *name, struct strbuf *ref, int force);
+int validate_new_branchname(const char *name, struct strbuf *ref, int force);
 
 /*
  * Remove information about the state of working on the current
@@ -72,26 +72,26 @@ void remove_branch_state(struct repository *r);
  * Returns 0 on success.
  */
 #define BRANCH_CONFIG_VERBOSE 01
-extern int install_branch_config(int flag, const char *local, const char *origin, const char *remote);
+int install_branch_config(int flag, const char *local, const char *origin, const char *remote);
 
 /*
  * Read branch description
  */
-extern int read_branch_desc(struct strbuf *, const char *branch_name);
+int read_branch_desc(struct strbuf *, const char *branch_name);
 
 /*
  * Check if a branch is checked out in the main worktree or any linked
  * worktree and die (with a message describing its checkout location) if
  * it is.
  */
-extern void die_if_checked_out(const char *branch, int ignore_current_worktree);
+void die_if_checked_out(const char *branch, int ignore_current_worktree);
 
 /*
  * Update all per-worktree HEADs pointing at the old ref to point the new ref.
  * This will be used when renaming a branch. Returns 0 if successful, non-zero
  * otherwise.
  */
-extern int replace_each_worktree_head_symref(const char *oldref, const char *newref,
+int replace_each_worktree_head_symref(const char *oldref, const char *newref,
 					     const char *logmsg);
 
 #endif
diff --git a/builtin.h b/builtin.h
index 6538932e99..7627483f2f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -102,7 +102,7 @@ extern const char git_more_info_string[];
 #define PRUNE_PACKED_DRY_RUN 01
 #define PRUNE_PACKED_VERBOSE 02
 
-extern void prune_packed_objects(int);
+void prune_packed_objects(int);
 
 struct fmt_merge_msg_opts {
 	unsigned add_title:1,
@@ -110,7 +110,7 @@ struct fmt_merge_msg_opts {
 	int shortlog_len;
 };
 
-extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
+int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 			 struct fmt_merge_msg_opts *);
 
 /**
@@ -123,131 +123,131 @@ extern int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
  * You should most likely use a default of 0 or 1. "Punt" (-1) could be useful
  * to be able to fall back to some historical compatibility name.
  */
-extern void setup_auto_pager(const char *cmd, int def);
+void setup_auto_pager(const char *cmd, int def);
 
-extern int is_builtin(const char *s);
+int is_builtin(const char *s);
 
-extern int cmd_add(int argc, const char **argv, const char *prefix);
-extern int cmd_am(int argc, const char **argv, const char *prefix);
-extern int cmd_annotate(int argc, const char **argv, const char *prefix);
-extern int cmd_apply(int argc, const char **argv, const char *prefix);
-extern int cmd_archive(int argc, const char **argv, const char *prefix);
-extern int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
-extern int cmd_blame(int argc, const char **argv, const char *prefix);
-extern int cmd_branch(int argc, const char **argv, const char *prefix);
-extern int cmd_bundle(int argc, const char **argv, const char *prefix);
-extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
-extern int cmd_checkout(int argc, const char **argv, const char *prefix);
-extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
-extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
-extern int cmd_check_ignore(int argc, const char **argv, const char *prefix);
-extern int cmd_check_mailmap(int argc, const char **argv, const char *prefix);
-extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
-extern int cmd_cherry(int argc, const char **argv, const char *prefix);
-extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
-extern int cmd_clone(int argc, const char **argv, const char *prefix);
-extern int cmd_clean(int argc, const char **argv, const char *prefix);
-extern int cmd_column(int argc, const char **argv, const char *prefix);
-extern int cmd_commit(int argc, const char **argv, const char *prefix);
-extern int cmd_commit_graph(int argc, const char **argv, const char *prefix);
-extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
-extern int cmd_config(int argc, const char **argv, const char *prefix);
-extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
-extern int cmd_credential(int argc, const char **argv, const char *prefix);
-extern int cmd_describe(int argc, const char **argv, const char *prefix);
-extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
-extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
-extern int cmd_diff(int argc, const char **argv, const char *prefix);
-extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
-extern int cmd_difftool(int argc, const char **argv, const char *prefix);
-extern int cmd_fast_export(int argc, const char **argv, const char *prefix);
-extern int cmd_fetch(int argc, const char **argv, const char *prefix);
-extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
-extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
-extern int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
-extern int cmd_format_patch(int argc, const char **argv, const char *prefix);
-extern int cmd_fsck(int argc, const char **argv, const char *prefix);
-extern int cmd_gc(int argc, const char **argv, const char *prefix);
-extern int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
-extern int cmd_grep(int argc, const char **argv, const char *prefix);
-extern int cmd_hash_object(int argc, const char **argv, const char *prefix);
-extern int cmd_help(int argc, const char **argv, const char *prefix);
-extern int cmd_index_pack(int argc, const char **argv, const char *prefix);
-extern int cmd_init_db(int argc, const char **argv, const char *prefix);
-extern int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
-extern int cmd_log(int argc, const char **argv, const char *prefix);
-extern int cmd_log_reflog(int argc, const char **argv, const char *prefix);
-extern int cmd_ls_files(int argc, const char **argv, const char *prefix);
-extern int cmd_ls_tree(int argc, const char **argv, const char *prefix);
-extern int cmd_ls_remote(int argc, const char **argv, const char *prefix);
-extern int cmd_mailinfo(int argc, const char **argv, const char *prefix);
-extern int cmd_mailsplit(int argc, const char **argv, const char *prefix);
-extern int cmd_merge(int argc, const char **argv, const char *prefix);
-extern int cmd_merge_base(int argc, const char **argv, const char *prefix);
-extern int cmd_merge_index(int argc, const char **argv, const char *prefix);
-extern int cmd_merge_ours(int argc, const char **argv, const char *prefix);
-extern int cmd_merge_file(int argc, const char **argv, const char *prefix);
-extern int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
-extern int cmd_merge_tree(int argc, const char **argv, const char *prefix);
-extern int cmd_mktag(int argc, const char **argv, const char *prefix);
-extern int cmd_mktree(int argc, const char **argv, const char *prefix);
-extern int cmd_multi_pack_index(int argc, const char **argv, const char *prefix);
-extern int cmd_mv(int argc, const char **argv, const char *prefix);
-extern int cmd_name_rev(int argc, const char **argv, const char *prefix);
-extern int cmd_notes(int argc, const char **argv, const char *prefix);
-extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
-extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
-extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
-extern int cmd_prune(int argc, const char **argv, const char *prefix);
-extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
-extern int cmd_pull(int argc, const char **argv, const char *prefix);
-extern int cmd_push(int argc, const char **argv, const char *prefix);
-extern int cmd_range_diff(int argc, const char **argv, const char *prefix);
-extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
-extern int cmd_rebase(int argc, const char **argv, const char *prefix);
-extern int cmd_rebase__interactive(int argc, const char **argv, const char *prefix);
-extern int cmd_receive_pack(int argc, const char **argv, const char *prefix);
-extern int cmd_reflog(int argc, const char **argv, const char *prefix);
-extern int cmd_remote(int argc, const char **argv, const char *prefix);
-extern int cmd_remote_ext(int argc, const char **argv, const char *prefix);
-extern int cmd_remote_fd(int argc, const char **argv, const char *prefix);
-extern int cmd_repack(int argc, const char **argv, const char *prefix);
-extern int cmd_rerere(int argc, const char **argv, const char *prefix);
-extern int cmd_reset(int argc, const char **argv, const char *prefix);
-extern int cmd_rev_list(int argc, const char **argv, const char *prefix);
-extern int cmd_rev_parse(int argc, const char **argv, const char *prefix);
-extern int cmd_revert(int argc, const char **argv, const char *prefix);
-extern int cmd_rm(int argc, const char **argv, const char *prefix);
-extern int cmd_send_pack(int argc, const char **argv, const char *prefix);
-extern int cmd_serve(int argc, const char **argv, const char *prefix);
-extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
-extern int cmd_show(int argc, const char **argv, const char *prefix);
-extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
-extern int cmd_show_index(int argc, const char **argv, const char *prefix);
-extern int cmd_status(int argc, const char **argv, const char *prefix);
-extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
-extern int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
-extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
-extern int cmd_tag(int argc, const char **argv, const char *prefix);
-extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
-extern int cmd_unpack_file(int argc, const char **argv, const char *prefix);
-extern int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
-extern int cmd_update_index(int argc, const char **argv, const char *prefix);
-extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
-extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
-extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
-extern int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
-extern int cmd_upload_pack(int argc, const char **argv, const char *prefix);
-extern int cmd_var(int argc, const char **argv, const char *prefix);
-extern int cmd_verify_commit(int argc, const char **argv, const char *prefix);
-extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
-extern int cmd_version(int argc, const char **argv, const char *prefix);
-extern int cmd_whatchanged(int argc, const char **argv, const char *prefix);
-extern int cmd_worktree(int argc, const char **argv, const char *prefix);
-extern int cmd_write_tree(int argc, const char **argv, const char *prefix);
-extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
-extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
-extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
-extern int cmd_replace(int argc, const char **argv, const char *prefix);
+int cmd_add(int argc, const char **argv, const char *prefix);
+int cmd_am(int argc, const char **argv, const char *prefix);
+int cmd_annotate(int argc, const char **argv, const char *prefix);
+int cmd_apply(int argc, const char **argv, const char *prefix);
+int cmd_archive(int argc, const char **argv, const char *prefix);
+int cmd_bisect__helper(int argc, const char **argv, const char *prefix);
+int cmd_blame(int argc, const char **argv, const char *prefix);
+int cmd_branch(int argc, const char **argv, const char *prefix);
+int cmd_bundle(int argc, const char **argv, const char *prefix);
+int cmd_cat_file(int argc, const char **argv, const char *prefix);
+int cmd_checkout(int argc, const char **argv, const char *prefix);
+int cmd_checkout_index(int argc, const char **argv, const char *prefix);
+int cmd_check_attr(int argc, const char **argv, const char *prefix);
+int cmd_check_ignore(int argc, const char **argv, const char *prefix);
+int cmd_check_mailmap(int argc, const char **argv, const char *prefix);
+int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
+int cmd_cherry(int argc, const char **argv, const char *prefix);
+int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
+int cmd_clone(int argc, const char **argv, const char *prefix);
+int cmd_clean(int argc, const char **argv, const char *prefix);
+int cmd_column(int argc, const char **argv, const char *prefix);
+int cmd_commit(int argc, const char **argv, const char *prefix);
+int cmd_commit_graph(int argc, const char **argv, const char *prefix);
+int cmd_commit_tree(int argc, const char **argv, const char *prefix);
+int cmd_config(int argc, const char **argv, const char *prefix);
+int cmd_count_objects(int argc, const char **argv, const char *prefix);
+int cmd_credential(int argc, const char **argv, const char *prefix);
+int cmd_describe(int argc, const char **argv, const char *prefix);
+int cmd_diff_files(int argc, const char **argv, const char *prefix);
+int cmd_diff_index(int argc, const char **argv, const char *prefix);
+int cmd_diff(int argc, const char **argv, const char *prefix);
+int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+int cmd_difftool(int argc, const char **argv, const char *prefix);
+int cmd_fast_export(int argc, const char **argv, const char *prefix);
+int cmd_fetch(int argc, const char **argv, const char *prefix);
+int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
+int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
+int cmd_for_each_ref(int argc, const char **argv, const char *prefix);
+int cmd_format_patch(int argc, const char **argv, const char *prefix);
+int cmd_fsck(int argc, const char **argv, const char *prefix);
+int cmd_gc(int argc, const char **argv, const char *prefix);
+int cmd_get_tar_commit_id(int argc, const char **argv, const char *prefix);
+int cmd_grep(int argc, const char **argv, const char *prefix);
+int cmd_hash_object(int argc, const char **argv, const char *prefix);
+int cmd_help(int argc, const char **argv, const char *prefix);
+int cmd_index_pack(int argc, const char **argv, const char *prefix);
+int cmd_init_db(int argc, const char **argv, const char *prefix);
+int cmd_interpret_trailers(int argc, const char **argv, const char *prefix);
+int cmd_log(int argc, const char **argv, const char *prefix);
+int cmd_log_reflog(int argc, const char **argv, const char *prefix);
+int cmd_ls_files(int argc, const char **argv, const char *prefix);
+int cmd_ls_tree(int argc, const char **argv, const char *prefix);
+int cmd_ls_remote(int argc, const char **argv, const char *prefix);
+int cmd_mailinfo(int argc, const char **argv, const char *prefix);
+int cmd_mailsplit(int argc, const char **argv, const char *prefix);
+int cmd_merge(int argc, const char **argv, const char *prefix);
+int cmd_merge_base(int argc, const char **argv, const char *prefix);
+int cmd_merge_index(int argc, const char **argv, const char *prefix);
+int cmd_merge_ours(int argc, const char **argv, const char *prefix);
+int cmd_merge_file(int argc, const char **argv, const char *prefix);
+int cmd_merge_recursive(int argc, const char **argv, const char *prefix);
+int cmd_merge_tree(int argc, const char **argv, const char *prefix);
+int cmd_mktag(int argc, const char **argv, const char *prefix);
+int cmd_mktree(int argc, const char **argv, const char *prefix);
+int cmd_multi_pack_index(int argc, const char **argv, const char *prefix);
+int cmd_mv(int argc, const char **argv, const char *prefix);
+int cmd_name_rev(int argc, const char **argv, const char *prefix);
+int cmd_notes(int argc, const char **argv, const char *prefix);
+int cmd_pack_objects(int argc, const char **argv, const char *prefix);
+int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
+int cmd_patch_id(int argc, const char **argv, const char *prefix);
+int cmd_prune(int argc, const char **argv, const char *prefix);
+int cmd_prune_packed(int argc, const char **argv, const char *prefix);
+int cmd_pull(int argc, const char **argv, const char *prefix);
+int cmd_push(int argc, const char **argv, const char *prefix);
+int cmd_range_diff(int argc, const char **argv, const char *prefix);
+int cmd_read_tree(int argc, const char **argv, const char *prefix);
+int cmd_rebase(int argc, const char **argv, const char *prefix);
+int cmd_rebase__interactive(int argc, const char **argv, const char *prefix);
+int cmd_receive_pack(int argc, const char **argv, const char *prefix);
+int cmd_reflog(int argc, const char **argv, const char *prefix);
+int cmd_remote(int argc, const char **argv, const char *prefix);
+int cmd_remote_ext(int argc, const char **argv, const char *prefix);
+int cmd_remote_fd(int argc, const char **argv, const char *prefix);
+int cmd_repack(int argc, const char **argv, const char *prefix);
+int cmd_rerere(int argc, const char **argv, const char *prefix);
+int cmd_reset(int argc, const char **argv, const char *prefix);
+int cmd_rev_list(int argc, const char **argv, const char *prefix);
+int cmd_rev_parse(int argc, const char **argv, const char *prefix);
+int cmd_revert(int argc, const char **argv, const char *prefix);
+int cmd_rm(int argc, const char **argv, const char *prefix);
+int cmd_send_pack(int argc, const char **argv, const char *prefix);
+int cmd_serve(int argc, const char **argv, const char *prefix);
+int cmd_shortlog(int argc, const char **argv, const char *prefix);
+int cmd_show(int argc, const char **argv, const char *prefix);
+int cmd_show_branch(int argc, const char **argv, const char *prefix);
+int cmd_show_index(int argc, const char **argv, const char *prefix);
+int cmd_status(int argc, const char **argv, const char *prefix);
+int cmd_stripspace(int argc, const char **argv, const char *prefix);
+int cmd_submodule__helper(int argc, const char **argv, const char *prefix);
+int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
+int cmd_tag(int argc, const char **argv, const char *prefix);
+int cmd_tar_tree(int argc, const char **argv, const char *prefix);
+int cmd_unpack_file(int argc, const char **argv, const char *prefix);
+int cmd_unpack_objects(int argc, const char **argv, const char *prefix);
+int cmd_update_index(int argc, const char **argv, const char *prefix);
+int cmd_update_ref(int argc, const char **argv, const char *prefix);
+int cmd_update_server_info(int argc, const char **argv, const char *prefix);
+int cmd_upload_archive(int argc, const char **argv, const char *prefix);
+int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
+int cmd_upload_pack(int argc, const char **argv, const char *prefix);
+int cmd_var(int argc, const char **argv, const char *prefix);
+int cmd_verify_commit(int argc, const char **argv, const char *prefix);
+int cmd_verify_tag(int argc, const char **argv, const char *prefix);
+int cmd_version(int argc, const char **argv, const char *prefix);
+int cmd_whatchanged(int argc, const char **argv, const char *prefix);
+int cmd_worktree(int argc, const char **argv, const char *prefix);
+int cmd_write_tree(int argc, const char **argv, const char *prefix);
+int cmd_verify_pack(int argc, const char **argv, const char *prefix);
+int cmd_show_ref(int argc, const char **argv, const char *prefix);
+int cmd_pack_refs(int argc, const char **argv, const char *prefix);
+int cmd_replace(int argc, const char **argv, const char *prefix);
 
 #endif
diff --git a/bulk-checkin.h b/bulk-checkin.h
index f438f93811..bf830e780d 100644
--- a/bulk-checkin.h
+++ b/bulk-checkin.h
@@ -6,11 +6,11 @@
 
 #include "cache.h"
 
-extern int index_bulk_checkin(struct object_id *oid,
+int index_bulk_checkin(struct object_id *oid,
 			      int fd, size_t size, enum object_type type,
 			      const char *path, unsigned flags);
 
-extern void plug_bulk_checkin(void);
-extern void unplug_bulk_checkin(void);
+void plug_bulk_checkin(void);
+void unplug_bulk_checkin(void);
 
 #endif
diff --git a/cache.h b/cache.h
index ac92421f3a..1f42d5ecb1 100644
--- a/cache.h
+++ b/cache.h
@@ -350,10 +350,10 @@ struct index_state {
 };
 
 /* Name hashing */
-extern int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
-extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
-extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
-extern void free_name_hash(struct index_state *istate);
+int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
+void add_name_hash(struct index_state *istate, struct cache_entry *ce);
+void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
+void free_name_hash(struct index_state *istate);
 
 
 /* Cache entry creation and cleanup */
@@ -543,7 +543,7 @@ static inline enum object_type object_type(unsigned int mode)
  */
 extern const char * const local_repo_env[];
 
-extern void setup_git_env(const char *git_dir);
+void setup_git_env(const char *git_dir);
 
 /*
  * Returns true iff we have a configured git repository (either via
@@ -552,29 +552,29 @@ extern void setup_git_env(const char *git_dir);
 int have_git_dir(void);
 
 extern int is_bare_repository_cfg;
-extern int is_bare_repository(void);
-extern int is_inside_git_dir(void);
+int is_bare_repository(void);
+int is_inside_git_dir(void);
 extern char *git_work_tree_cfg;
-extern int is_inside_work_tree(void);
-extern const char *get_git_dir(void);
-extern const char *get_git_common_dir(void);
-extern char *get_object_directory(void);
-extern char *get_index_file(void);
-extern char *get_graft_file(struct repository *r);
-extern void set_git_dir(const char *path);
-extern int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
-extern int get_common_dir(struct strbuf *sb, const char *gitdir);
-extern const char *get_git_namespace(void);
-extern const char *strip_namespace(const char *namespaced_ref);
-extern const char *get_super_prefix(void);
-extern const char *get_git_work_tree(void);
+int is_inside_work_tree(void);
+const char *get_git_dir(void);
+const char *get_git_common_dir(void);
+char *get_object_directory(void);
+char *get_index_file(void);
+char *get_graft_file(struct repository *r);
+void set_git_dir(const char *path);
+int get_common_dir_noenv(struct strbuf *sb, const char *gitdir);
+int get_common_dir(struct strbuf *sb, const char *gitdir);
+const char *get_git_namespace(void);
+const char *strip_namespace(const char *namespaced_ref);
+const char *get_super_prefix(void);
+const char *get_git_work_tree(void);
 
 /*
  * Return true if the given path is a git directory; note that this _just_
  * looks at the directory itself. If you want to know whether "foo/.git"
  * is a repository, you must feed that path, not just "foo".
  */
-extern int is_git_directory(const char *path);
+int is_git_directory(const char *path);
 
 /*
  * Return 1 if the given path is the root of a git repository or
@@ -586,7 +586,7 @@ extern int is_git_directory(const char *path);
  * as we usually consider sub-repos precious, and would prefer to err on the
  * side of not disrupting or deleting them.
  */
-extern int is_nonbare_repository_dir(struct strbuf *path);
+int is_nonbare_repository_dir(struct strbuf *path);
 
 #define READ_GITFILE_ERR_STAT_FAILED 1
 #define READ_GITFILE_ERR_NOT_A_FILE 2
@@ -596,17 +596,17 @@ extern int is_nonbare_repository_dir(struct strbuf *path);
 #define READ_GITFILE_ERR_NO_PATH 6
 #define READ_GITFILE_ERR_NOT_A_REPO 7
 #define READ_GITFILE_ERR_TOO_LARGE 8
-extern void read_gitfile_error_die(int error_code, const char *path, const char *dir);
-extern const char *read_gitfile_gently(const char *path, int *return_error_code);
+void read_gitfile_error_die(int error_code, const char *path, const char *dir);
+const char *read_gitfile_gently(const char *path, int *return_error_code);
 #define read_gitfile(path) read_gitfile_gently((path), NULL)
-extern const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
+const char *resolve_gitdir_gently(const char *suspect, int *return_error_code);
 #define resolve_gitdir(path) resolve_gitdir_gently((path), NULL)
 
-extern void set_git_work_tree(const char *tree);
+void set_git_work_tree(const char *tree);
 
 #define ALTERNATE_DB_ENVIRONMENT "GIT_ALTERNATE_OBJECT_DIRECTORIES"
 
-extern void setup_work_tree(void);
+void setup_work_tree(void);
 /*
  * Find the commondir and gitdir of the repository that contains the current
  * working directory, without changing the working directory or other global
@@ -615,12 +615,12 @@ extern void setup_work_tree(void);
  * both have the same result appended to the buffer.  The return value is
  * either 0 upon success and non-zero if no repository was found.
  */
-extern int discover_git_directory(struct strbuf *commondir,
+int discover_git_directory(struct strbuf *commondir,
 				  struct strbuf *gitdir);
-extern const char *setup_git_directory_gently(int *);
-extern const char *setup_git_directory(void);
-extern char *prefix_path(const char *prefix, int len, const char *path);
-extern char *prefix_path_gently(const char *prefix, int len, int *remaining, const char *path);
+const char *setup_git_directory_gently(int *);
+const char *setup_git_directory(void);
+char *prefix_path(const char *prefix, int len, const char *path);
+char *prefix_path_gently(const char *prefix, int len, int *remaining, const char *path);
 
 /*
  * Concatenate "prefix" (if len is non-zero) and "path", with no
@@ -632,23 +632,23 @@ extern char *prefix_path_gently(const char *prefix, int len, int *remaining, con
  * The return value is always a newly allocated string (even if the
  * prefix was empty).
  */
-extern char *prefix_filename(const char *prefix, const char *path);
+char *prefix_filename(const char *prefix, const char *path);
 
-extern int check_filename(const char *prefix, const char *name);
-extern void verify_filename(const char *prefix,
+int check_filename(const char *prefix, const char *name);
+void verify_filename(const char *prefix,
 			    const char *name,
 			    int diagnose_misspelt_rev);
-extern void verify_non_filename(const char *prefix, const char *name);
-extern int path_inside_repo(const char *prefix, const char *path);
+void verify_non_filename(const char *prefix, const char *name);
+int path_inside_repo(const char *prefix, const char *path);
 
 #define INIT_DB_QUIET 0x0001
 #define INIT_DB_EXIST_OK 0x0002
 
-extern int init_db(const char *git_dir, const char *real_git_dir,
+int init_db(const char *git_dir, const char *real_git_dir,
 		   const char *template_dir, unsigned int flags);
 
-extern void sanitize_stdfds(void);
-extern int daemonize(void);
+void sanitize_stdfds(void);
+int daemonize(void);
 
 #define alloc_nr(x) (((x)+16)*3/2)
 
@@ -672,14 +672,14 @@ extern int daemonize(void);
 
 /* Initialize and use the cache information */
 struct lock_file;
-extern void preload_index(struct index_state *index,
+void preload_index(struct index_state *index,
 			  const struct pathspec *pathspec,
 			  unsigned int refresh_flags);
-extern int do_read_index(struct index_state *istate, const char *path,
+int do_read_index(struct index_state *istate, const char *path,
 			 int must_exist); /* for testting only! */
-extern int read_index_from(struct index_state *, const char *path,
+int read_index_from(struct index_state *, const char *path,
 			   const char *gitdir);
-extern int is_index_unborn(struct index_state *);
+int is_index_unborn(struct index_state *);
 
 /* For use with `write_locked_index()`. */
 #define COMMIT_LOCK		(1 << 0)
@@ -704,11 +704,11 @@ extern int is_index_unborn(struct index_state *);
  * If `SKIP_IF_UNCHANGED` is given and the index is unchanged, nothing
  * is written (and the lock is rolled back if `COMMIT_LOCK` is given).
  */
-extern int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
+int write_locked_index(struct index_state *, struct lock_file *lock, unsigned flags);
 
-extern int discard_index(struct index_state *);
-extern void move_index_extensions(struct index_state *dst, struct index_state *src);
-extern int unmerged_index(const struct index_state *);
+int discard_index(struct index_state *);
+void move_index_extensions(struct index_state *dst, struct index_state *src);
+int unmerged_index(const struct index_state *);
 
 /**
  * Returns 1 if istate differs from tree, 0 otherwise.  If tree is NULL,
@@ -717,15 +717,15 @@ extern int unmerged_index(const struct index_state *);
  * provided, the space-separated list of files that differ will be appended
  * to it.
  */
-extern int repo_index_has_changes(struct repository *repo,
+int repo_index_has_changes(struct repository *repo,
 				  struct tree *tree,
 				  struct strbuf *sb);
 
-extern int verify_path(const char *path, unsigned mode);
-extern int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
-extern int index_dir_exists(struct index_state *istate, const char *name, int namelen);
-extern void adjust_dirname_case(struct index_state *istate, char *name);
-extern struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
+int verify_path(const char *path, unsigned mode);
+int strcmp_offset(const char *s1, const char *s2, size_t *first_change);
+int index_dir_exists(struct index_state *istate, const char *name, int namelen);
+void adjust_dirname_case(struct index_state *istate, char *name);
+struct cache_entry *index_file_exists(struct index_state *istate, const char *name, int namelen, int igncase);
 
 /*
  * Searches for an entry defined by name and namelen in the given index.
@@ -744,7 +744,7 @@ extern struct cache_entry *index_file_exists(struct index_state *istate, const c
  * index_name_pos(&index, "f", 1) -> -3
  * index_name_pos(&index, "g", 1) -> -5
  */
-extern int index_name_pos(const struct index_state *, const char *name, int namelen);
+int index_name_pos(const struct index_state *, const char *name, int namelen);
 
 #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
@@ -753,14 +753,14 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
 #define ADD_CACHE_RENORMALIZE 64        /* Pass along HASH_RENORMALIZE */
-extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
-extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
+int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
+void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 
 /* Remove entry, return true if there are more entries to go. */
-extern int remove_index_entry_at(struct index_state *, int pos);
+int remove_index_entry_at(struct index_state *, int pos);
 
-extern void remove_marked_cache_entries(struct index_state *istate, int invalidate);
-extern int remove_file_from_index(struct index_state *, const char *path);
+void remove_marked_cache_entries(struct index_state *istate, int invalidate);
+int remove_file_from_index(struct index_state *, const char *path);
 #define ADD_CACHE_VERBOSE 1
 #define ADD_CACHE_PRETEND 2
 #define ADD_CACHE_IGNORE_ERRORS	4
@@ -775,14 +775,14 @@ extern int remove_file_from_index(struct index_state *, const char *path);
  * the latter will do necessary lstat(2) internally before
  * calling the former.
  */
-extern int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
-extern int add_file_to_index(struct index_state *, const char *path, int flags);
+int add_to_index(struct index_state *, const char *path, struct stat *, int flags);
+int add_file_to_index(struct index_state *, const char *path, int flags);
 
-extern int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
-extern int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
-extern void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
-extern int index_name_is_other(const struct index_state *, const char *, int);
-extern void *read_blob_data_from_index(const struct index_state *, const char *, unsigned long *);
+int chmod_index_entry(struct index_state *, struct cache_entry *ce, char flip);
+int ce_same_name(const struct cache_entry *a, const struct cache_entry *b);
+void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
+int index_name_is_other(const struct index_state *, const char *, int);
+void *read_blob_data_from_index(const struct index_state *, const char *, unsigned long *);
 
 /* do stat comparison even if CE_VALID is true */
 #define CE_MATCH_IGNORE_VALID		01
@@ -796,22 +796,22 @@ extern void *read_blob_data_from_index(const struct index_state *, const char *,
 #define CE_MATCH_REFRESH		0x10
 /* don't refresh_fsmonitor state or do stat comparison even if CE_FSMONITOR_VALID is true */
 #define CE_MATCH_IGNORE_FSMONITOR 0X20
-extern int is_racy_timestamp(const struct index_state *istate,
+int is_racy_timestamp(const struct index_state *istate,
 			     const struct cache_entry *ce);
-extern int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
-extern int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
+int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
+int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
 #define HASH_WRITE_OBJECT 1
 #define HASH_FORMAT_CHECK 2
 #define HASH_RENORMALIZE  4
-extern int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
-extern int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
+int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
+int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
 /*
  * Record to sd the data from st that we use to check whether a file
  * might have changed.
  */
-extern void fill_stat_data(struct stat_data *sd, struct stat *st);
+void fill_stat_data(struct stat_data *sd, struct stat *st);
 
 /*
  * Return 0 if st is consistent with a file not having been changed
@@ -819,11 +819,11 @@ extern void fill_stat_data(struct stat_data *sd, struct stat *st);
  * combination of MTIME_CHANGED, CTIME_CHANGED, OWNER_CHANGED,
  * INODE_CHANGED, and DATA_CHANGED.
  */
-extern int match_stat_data(const struct stat_data *sd, struct stat *st);
-extern int match_stat_data_racy(const struct index_state *istate,
+int match_stat_data(const struct stat_data *sd, struct stat *st);
+int match_stat_data_racy(const struct index_state *istate,
 				const struct stat_data *sd, struct stat *st);
 
-extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
+void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 
 #define REFRESH_REALLY		0x0001	/* ignore_valid */
 #define REFRESH_UNMERGED	0x0002	/* allow unmerged */
@@ -832,10 +832,10 @@ extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
 #define REFRESH_IGNORE_SUBMODULES	0x0010	/* ignore submodules */
 #define REFRESH_IN_PORCELAIN	0x0020	/* user friendly output, not "needs update" */
 #define REFRESH_PROGRESS	0x0040  /* show progress bar if stderr is tty */
-extern int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
-extern struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
+int refresh_index(struct index_state *, unsigned int flags, const struct pathspec *pathspec, char *seen, const char *header_msg);
+struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
 
-extern void set_alternate_index_output(const char *);
+void set_alternate_index_output(const char *);
 
 extern int verify_index_checksum;
 extern int verify_ce_order;
@@ -1020,7 +1020,7 @@ int verify_repository_format(const struct repository_format *format,
  * set_git_dir() before calling this, and use it only for "are we in a valid
  * repo?".
  */
-extern void check_repository_format(void);
+void check_repository_format(void);
 
 #define MTIME_CHANGED	0x0001
 #define CTIME_CHANGED	0x0002
@@ -1045,8 +1045,8 @@ extern void check_repository_format(void);
  * Note that while this version avoids the static buffer, it is not fully
  * reentrant, as it calls into other non-reentrant git code.
  */
-extern const char *find_unique_abbrev(const struct object_id *oid, int len);
-extern int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len);
+const char *find_unique_abbrev(const struct object_id *oid, int len);
+int find_unique_abbrev_r(char *hex, const struct object_id *oid, int len);
 
 extern const unsigned char null_sha1[GIT_MAX_RAWSZ];
 extern const struct object_id null_oid;
@@ -1242,7 +1242,7 @@ typedef int create_file_fn(const char *path, void *cb);
 int raceproof_create_file(const char *path, create_file_fn fn, void *cb);
 
 int mkdir_in_gitdir(const char *path);
-extern char *expand_user_path(const char *path, int real_home);
+char *expand_user_path(const char *path, int real_home);
 const char *enter_repo(const char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
@@ -1286,26 +1286,26 @@ int looks_like_command_line_option(const char *str);
  * "$XDG_CONFIG_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
  * "$HOME/.config/git/$filename". Return NULL upon error.
  */
-extern char *xdg_config_home(const char *filename);
+char *xdg_config_home(const char *filename);
 
 /**
  * Return a newly allocated string with the evaluation of
  * "$XDG_CACHE_HOME/git/$filename" if $XDG_CACHE_HOME is non-empty, otherwise
  * "$HOME/.cache/git/$filename". Return NULL upon error.
  */
-extern char *xdg_cache_home(const char *filename);
+char *xdg_cache_home(const char *filename);
 
-extern int git_open_cloexec(const char *name, int flags);
+int git_open_cloexec(const char *name, int flags);
 #define git_open(name) git_open_cloexec(name, O_RDONLY)
-extern int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
-extern int parse_loose_header(const char *hdr, unsigned long *sizep);
+int unpack_loose_header(git_zstream *stream, unsigned char *map, unsigned long mapsize, void *buffer, unsigned long bufsiz);
+int parse_loose_header(const char *hdr, unsigned long *sizep);
 
-extern int check_object_signature(const struct object_id *oid, void *buf, unsigned long size, const char *type);
+int check_object_signature(const struct object_id *oid, void *buf, unsigned long size, const char *type);
 
-extern int finalize_object_file(const char *tmpfile, const char *filename);
+int finalize_object_file(const char *tmpfile, const char *filename);
 
 /* Helper to check and "touch" a file */
-extern int check_and_freshen_file(const char *fn, int freshen);
+int check_and_freshen_file(const char *fn, int freshen);
 
 extern const signed char hexval_table[256];
 static inline unsigned int hexval(unsigned char c)
@@ -1378,21 +1378,21 @@ enum get_oid_result {
 		       */
 };
 
-extern int get_oid(const char *str, struct object_id *oid);
-extern int get_oid_commit(const char *str, struct object_id *oid);
-extern int get_oid_committish(const char *str, struct object_id *oid);
-extern int get_oid_tree(const char *str, struct object_id *oid);
-extern int get_oid_treeish(const char *str, struct object_id *oid);
-extern int get_oid_blob(const char *str, struct object_id *oid);
-extern void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
-extern enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
+int get_oid(const char *str, struct object_id *oid);
+int get_oid_commit(const char *str, struct object_id *oid);
+int get_oid_committish(const char *str, struct object_id *oid);
+int get_oid_tree(const char *str, struct object_id *oid);
+int get_oid_treeish(const char *str, struct object_id *oid);
+int get_oid_blob(const char *str, struct object_id *oid);
+void maybe_die_on_misspelt_object_name(const char *name, const char *prefix);
+enum get_oid_result get_oid_with_context(struct repository *repo, const char *str,
 				unsigned flags, struct object_id *oid,
 				struct object_context *oc);
 
 typedef int each_abbrev_fn(const struct object_id *oid, void *);
-extern int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
+int for_each_abbrev(const char *prefix, each_abbrev_fn, void *);
 
-extern int set_disambiguate_hint_config(const char *var, const char *value);
+int set_disambiguate_hint_config(const char *var, const char *value);
 
 /*
  * Try to read a SHA1 in hexadecimal format from the 40 characters
@@ -1401,15 +1401,15 @@ extern int set_disambiguate_hint_config(const char *var, const char *value);
  * input, so it is safe to pass this function an arbitrary
  * null-terminated string.
  */
-extern int get_sha1_hex(const char *hex, unsigned char *sha1);
-extern int get_oid_hex(const char *hex, struct object_id *sha1);
+int get_sha1_hex(const char *hex, unsigned char *sha1);
+int get_oid_hex(const char *hex, struct object_id *sha1);
 
 /*
  * Read `len` pairs of hexadecimal digits from `hex` and write the
  * values to `binary` as `len` bytes. Return 0 on success, or -1 if
  * the input does not consist of hex digits).
  */
-extern int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
+int hex_to_bytes(unsigned char *binary, const char *hex, size_t len);
 
 /*
  * Convert a binary hash to its hex equivalent. The `_r` variant is reentrant,
@@ -1437,7 +1437,7 @@ char *oid_to_hex(const struct object_id *oid);						/* same static buffer */
  * other invalid character.  end is only updated on success; otherwise, it is
  * unmodified.
  */
-extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
+int parse_oid_hex(const char *hex, struct object_id *oid, const char **end);
 
 /*
  * This reads short-hand syntax that not only evaluates to a commit
@@ -1468,23 +1468,23 @@ extern int parse_oid_hex(const char *hex, struct object_id *oid, const char **en
 #define INTERPRET_BRANCH_LOCAL (1<<0)
 #define INTERPRET_BRANCH_REMOTE (1<<1)
 #define INTERPRET_BRANCH_HEAD (1<<2)
-extern int interpret_branch_name(const char *str, int len, struct strbuf *,
+int interpret_branch_name(const char *str, int len, struct strbuf *,
 				 unsigned allowed);
-extern int get_oid_mb(const char *str, struct object_id *oid);
+int get_oid_mb(const char *str, struct object_id *oid);
 
-extern int validate_headref(const char *ref);
+int validate_headref(const char *ref);
 
-extern int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
-extern int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
-extern int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
-extern int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
+int base_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
+int df_name_compare(const char *name1, int len1, int mode1, const char *name2, int len2, int mode2);
+int name_compare(const char *name1, size_t len1, const char *name2, size_t len2);
+int cache_name_stage_compare(const char *name1, int len1, int stage1, const char *name2, int len2, int stage2);
 
-extern void *read_object_with_reference(const struct object_id *oid,
+void *read_object_with_reference(const struct object_id *oid,
 					const char *required_type,
 					unsigned long *size,
 					struct object_id *oid_ret);
 
-extern struct object *peel_to_type(const char *name, int namelen,
+struct object *peel_to_type(const char *name, int namelen,
 				   struct object *o, enum object_type);
 
 enum date_mode_type {
@@ -1539,20 +1539,20 @@ enum want_ident {
 	WANT_COMMITTER_IDENT
 };
 
-extern const char *git_author_info(int);
-extern const char *git_committer_info(int);
-extern const char *fmt_ident(const char *name, const char *email,
+const char *git_author_info(int);
+const char *git_committer_info(int);
+const char *fmt_ident(const char *name, const char *email,
 		enum want_ident whose_ident,
 		const char *date_str, int);
-extern const char *fmt_name(enum want_ident);
-extern const char *ident_default_name(void);
-extern const char *ident_default_email(void);
-extern const char *git_editor(void);
-extern const char *git_sequence_editor(void);
-extern const char *git_pager(int stdout_is_tty);
-extern int is_terminal_dumb(void);
-extern int git_ident_config(const char *, const char *, void *);
-extern void reset_ident_date(void);
+const char *fmt_name(enum want_ident);
+const char *ident_default_name(void);
+const char *ident_default_email(void);
+const char *git_editor(void);
+const char *git_sequence_editor(void);
+const char *git_pager(int stdout_is_tty);
+int is_terminal_dumb(void);
+int git_ident_config(const char *, const char *, void *);
+void reset_ident_date(void);
 
 struct ident_split {
 	const char *name_begin;
@@ -1568,7 +1568,7 @@ struct ident_split {
  * Signals an success with 0, but time part of the result may be NULL
  * if the input lacks timestamp and zone
  */
-extern int split_ident_line(struct ident_split *, const char *, int);
+int split_ident_line(struct ident_split *, const char *, int);
 
 /*
  * Like show_date, but pull the timestamp and tz parameters from
@@ -1585,7 +1585,7 @@ const char *show_ident_date(const struct ident_split *id,
  * Because there are two fields, we must choose one as the primary key; we
  * currently arbitrarily pick the email.
  */
-extern int ident_cmp(const struct ident_split *, const struct ident_split *);
+int ident_cmp(const struct ident_split *, const struct ident_split *);
 
 struct checkout {
 	struct index_state *istate;
@@ -1601,14 +1601,14 @@ struct checkout {
 #define CHECKOUT_INIT { NULL, "" }
 
 #define TEMPORARY_FILENAME_LENGTH 25
-extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath, int *nr_checkouts);
-extern void enable_delayed_checkout(struct checkout *state);
-extern int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
+int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath, int *nr_checkouts);
+void enable_delayed_checkout(struct checkout *state);
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
 /*
  * Unlink the last component and schedule the leading directories for
  * removal, such that empty directories get removed.
  */
-extern void unlink_entry(const struct cache_entry *ce);
+void unlink_entry(const struct cache_entry *ce);
 
 struct cache_def {
 	struct strbuf path;
@@ -1622,12 +1622,12 @@ static inline void cache_def_clear(struct cache_def *cache)
 	strbuf_release(&cache->path);
 }
 
-extern int has_symlink_leading_path(const char *name, int len);
-extern int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
-extern int check_leading_path(const char *name, int len);
-extern int has_dirs_only_path(const char *name, int len, int prefix_len);
-extern void schedule_dir_for_removal(const char *name, int len);
-extern void remove_scheduled_dirs(void);
+int has_symlink_leading_path(const char *name, int len);
+int threaded_has_symlink_leading_path(struct cache_def *, const char *, int);
+int check_leading_path(const char *name, int len);
+int has_dirs_only_path(const char *name, int len, int prefix_len);
+void schedule_dir_for_removal(const char *name, int len);
+void remove_scheduled_dirs(void);
 
 struct pack_window {
 	struct pack_window *next;
@@ -1649,14 +1649,14 @@ struct pack_entry {
  * usual "XXXXXX" trailer, and the resulting filename is written into the
  * "template" buffer. Returns the open descriptor.
  */
-extern int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
+int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
 
 /*
  * Create a pack .keep file named "name" (which should generally be the output
  * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
  * error.
  */
-extern int odb_pack_keep(const char *name);
+int odb_pack_keep(const char *name);
 
 /*
  * Set this to 0 to prevent oid_object_info_extended() from fetching missing
@@ -1667,10 +1667,10 @@ extern int odb_pack_keep(const char *name);
 extern int fetch_if_missing;
 
 /* Dumb servers support */
-extern int update_server_info(int);
+int update_server_info(int);
 
-extern const char *get_log_output_encoding(void);
-extern const char *get_commit_output_encoding(void);
+const char *get_log_output_encoding(void);
+const char *get_commit_output_encoding(void);
 
 /*
  * This is a hack for test programs like test-dump-untracked-cache to
@@ -1679,8 +1679,8 @@ extern const char *get_commit_output_encoding(void);
  */
 extern int ignore_untracked_cache_config;
 
-extern int committer_ident_sufficiently_given(void);
-extern int author_ident_sufficiently_given(void);
+int committer_ident_sufficiently_given(void);
+int author_ident_sufficiently_given(void);
 
 extern const char *git_commit_encoding;
 extern const char *git_log_output_encoding;
@@ -1688,22 +1688,22 @@ extern const char *git_mailmap_file;
 extern const char *git_mailmap_blob;
 
 /* IO helper functions */
-extern void maybe_flush_or_die(FILE *, const char *);
+void maybe_flush_or_die(FILE *, const char *);
 __attribute__((format (printf, 2, 3)))
-extern void fprintf_or_die(FILE *, const char *fmt, ...);
+void fprintf_or_die(FILE *, const char *fmt, ...);
 
 #define COPY_READ_ERROR (-2)
 #define COPY_WRITE_ERROR (-3)
-extern int copy_fd(int ifd, int ofd);
-extern int copy_file(const char *dst, const char *src, int mode);
-extern int copy_file_with_time(const char *dst, const char *src, int mode);
+int copy_fd(int ifd, int ofd);
+int copy_file(const char *dst, const char *src, int mode);
+int copy_file_with_time(const char *dst, const char *src, int mode);
 
-extern void write_or_die(int fd, const void *buf, size_t count);
-extern void fsync_or_die(int fd, const char *);
+void write_or_die(int fd, const void *buf, size_t count);
+void fsync_or_die(int fd, const char *);
 
-extern ssize_t read_in_full(int fd, void *buf, size_t count);
-extern ssize_t write_in_full(int fd, const void *buf, size_t count);
-extern ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
+ssize_t read_in_full(int fd, void *buf, size_t count);
+ssize_t write_in_full(int fd, const void *buf, size_t count);
+ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
 
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
@@ -1714,7 +1714,7 @@ static inline ssize_t write_str_in_full(int fd, const char *str)
  * Open (and truncate) the file at path, write the contents of buf to it,
  * and close it. Dies if any errors are encountered.
  */
-extern void write_file_buf(const char *path, const char *buf, size_t len);
+void write_file_buf(const char *path, const char *buf, size_t len);
 
 /**
  * Like write_file_buf(), but format the contents into a buffer first.
@@ -1724,16 +1724,16 @@ extern void write_file_buf(const char *path, const char *buf, size_t len);
  *   write_file(path, "counter: %d", ctr);
  */
 __attribute__((format (printf, 2, 3)))
-extern void write_file(const char *path, const char *fmt, ...);
+void write_file(const char *path, const char *fmt, ...);
 
 /* pager.c */
-extern void setup_pager(void);
-extern int pager_in_use(void);
+void setup_pager(void);
+int pager_in_use(void);
 extern int pager_use_color;
-extern int term_columns(void);
-extern int decimal_width(uintmax_t);
-extern int check_pager_config(const char *cmd);
-extern void prepare_pager_args(struct child_process *, const char *pager);
+int term_columns(void);
+int decimal_width(uintmax_t);
+int check_pager_config(const char *cmd);
+void prepare_pager_args(struct child_process *, const char *pager);
 
 extern const char *editor_program;
 extern const char *askpass_program;
@@ -1777,13 +1777,13 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
 /* All WS_* -- when extended, adapt diff.c emit_symbol */
 #define WS_RULE_MASK           07777
 extern unsigned whitespace_rule_cfg;
-extern unsigned whitespace_rule(struct index_state *, const char *);
-extern unsigned parse_whitespace_rule(const char *);
-extern unsigned ws_check(const char *line, int len, unsigned ws_rule);
-extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
-extern char *whitespace_error_string(unsigned ws);
-extern void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
-extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
+unsigned whitespace_rule(struct index_state *, const char *);
+unsigned parse_whitespace_rule(const char *);
+unsigned ws_check(const char *line, int len, unsigned ws_rule);
+void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
+char *whitespace_error_string(unsigned ws);
+void ws_fix_copy(struct strbuf *, const char *, int, unsigned, int *);
+int ws_blank_line(const char *line, int len, unsigned ws_rule);
 #define ws_tab_width(rule)     ((rule) & WS_TAB_WIDTH_MASK)
 
 /* ls-files */
@@ -1853,9 +1853,9 @@ void safe_create_dir(const char *dir, int share);
  * Should we print an ellipsis after an abbreviated SHA-1 value
  * when doing diff-raw output or indicating a detached HEAD?
  */
-extern int print_sha1_ellipsis(void);
+int print_sha1_ellipsis(void);
 
 /* Return 1 if the file is empty or does not exists, 0 otherwise. */
-extern int is_empty_or_missing_file(const char *filename);
+int is_empty_or_missing_file(const char *filename);
 
 #endif /* CACHE_H */
diff --git a/checkout.h b/checkout.h
index 6b2073310c..a6f5180436 100644
--- a/checkout.h
+++ b/checkout.h
@@ -8,7 +8,7 @@
  * tracking branch.  Return the name of the remote if such a branch
  * exists, NULL otherwise.
  */
-extern const char *unique_tracking_name(const char *name,
+const char *unique_tracking_name(const char *name,
 					struct object_id *oid,
 					int *dwim_remotes_matched);
 
diff --git a/column.h b/column.h
index 2567a5cf4d..72cf539667 100644
--- a/column.h
+++ b/column.h
@@ -27,20 +27,20 @@ struct column_options {
 };
 
 struct option;
-extern int parseopt_column_callback(const struct option *, const char *, int);
-extern int git_column_config(const char *var, const char *value,
+int parseopt_column_callback(const struct option *, const char *, int);
+int git_column_config(const char *var, const char *value,
 			     const char *command, unsigned int *colopts);
-extern int finalize_colopts(unsigned int *colopts, int stdout_is_tty);
+int finalize_colopts(unsigned int *colopts, int stdout_is_tty);
 static inline int column_active(unsigned int colopts)
 {
 	return (colopts & COL_ENABLE_MASK) == COL_ENABLED;
 }
 
 struct string_list;
-extern void print_columns(const struct string_list *list, unsigned int colopts,
+void print_columns(const struct string_list *list, unsigned int colopts,
 			  const struct column_options *opts);
 
-extern int run_column_filter(int colopts, const struct column_options *);
-extern int stop_column_filter(void);
+int run_column_filter(int colopts, const struct column_options *);
+int stop_column_filter(void);
 
 #endif
diff --git a/commit.h b/commit.h
index 42728c2906..40744e1bed 100644
--- a/commit.h
+++ b/commit.h
@@ -177,8 +177,8 @@ void free_commit_list(struct commit_list *list);
 
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
-extern int has_non_ascii(const char *text);
-extern const char *logmsg_reencode(const struct commit *commit,
+int has_non_ascii(const char *text);
+const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
 const char *repo_logmsg_reencode(struct repository *r,
@@ -189,7 +189,7 @@ const char *repo_logmsg_reencode(struct repository *r,
 #define logmsg_reencode(c, enc, out) repo_logmsg_reencode(the_repository, c, enc, out)
 #endif
 
-extern const char *skip_blank_lines(const char *msg);
+const char *skip_blank_lines(const char *msg);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
@@ -240,22 +240,22 @@ struct commit *get_fork_point(const char *refname, struct commit *commit);
 
 struct oid_array;
 struct ref;
-extern int register_shallow(struct repository *r, const struct object_id *oid);
-extern int unregister_shallow(const struct object_id *oid);
-extern int for_each_commit_graft(each_commit_graft_fn, void *);
-extern int is_repository_shallow(struct repository *r);
-extern struct commit_list *get_shallow_commits(struct object_array *heads,
+int register_shallow(struct repository *r, const struct object_id *oid);
+int unregister_shallow(const struct object_id *oid);
+int for_each_commit_graft(each_commit_graft_fn, void *);
+int is_repository_shallow(struct repository *r);
+struct commit_list *get_shallow_commits(struct object_array *heads,
 		int depth, int shallow_flag, int not_shallow_flag);
-extern struct commit_list *get_shallow_commits_by_rev_list(
+struct commit_list *get_shallow_commits_by_rev_list(
 		int ac, const char **av, int shallow_flag, int not_shallow_flag);
-extern void set_alternate_shallow_file(struct repository *r, const char *path, int override);
-extern int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
+void set_alternate_shallow_file(struct repository *r, const char *path, int override);
+int write_shallow_commits(struct strbuf *out, int use_pack_protocol,
 				 const struct oid_array *extra);
-extern void setup_alternate_shallow(struct lock_file *shallow_lock,
+void setup_alternate_shallow(struct lock_file *shallow_lock,
 				    const char **alternate_shallow_file,
 				    const struct oid_array *extra);
-extern const char *setup_temporary_shallow(const struct oid_array *extra);
-extern void advertise_shallow_grafts(int);
+const char *setup_temporary_shallow(const struct oid_array *extra);
+void advertise_shallow_grafts(int);
 
 struct shallow_info {
 	struct oid_array *shallow;
@@ -272,20 +272,20 @@ struct shallow_info {
 	int nr_commits;
 };
 
-extern void prepare_shallow_info(struct shallow_info *, struct oid_array *);
-extern void clear_shallow_info(struct shallow_info *);
-extern void remove_nonexistent_theirs_shallow(struct shallow_info *);
-extern void assign_shallow_commits_to_refs(struct shallow_info *info,
+void prepare_shallow_info(struct shallow_info *, struct oid_array *);
+void clear_shallow_info(struct shallow_info *);
+void remove_nonexistent_theirs_shallow(struct shallow_info *);
+void assign_shallow_commits_to_refs(struct shallow_info *info,
 					   uint32_t **used,
 					   int *ref_status);
-extern int delayed_reachability_test(struct shallow_info *si, int c);
+int delayed_reachability_test(struct shallow_info *si, int c);
 #define PRUNE_SHOW_ONLY 1
 #define PRUNE_QUICK 2
-extern void prune_shallow(unsigned options);
+void prune_shallow(unsigned options);
 extern struct trace_key trace_shallow;
 
-extern int interactive_add(int argc, const char **argv, const char *prefix, int patch);
-extern int run_add_interactive(const char *revision, const char *patch_mode,
+int interactive_add(int argc, const char **argv, const char *prefix, int patch);
+int run_add_interactive(const char *revision, const char *patch_mode,
 			       const struct pathspec *pathspec);
 
 struct commit_extra_header {
@@ -295,24 +295,24 @@ struct commit_extra_header {
 	size_t len;
 };
 
-extern void append_merge_tag_headers(struct commit_list *parents,
+void append_merge_tag_headers(struct commit_list *parents,
 				     struct commit_extra_header ***tail);
 
-extern int commit_tree(const char *msg, size_t msg_len,
+int commit_tree(const char *msg, size_t msg_len,
 		       const struct object_id *tree,
 		       struct commit_list *parents, struct object_id *ret,
 		       const char *author, const char *sign_commit);
 
-extern int commit_tree_extended(const char *msg, size_t msg_len,
+int commit_tree_extended(const char *msg, size_t msg_len,
 				const struct object_id *tree,
 				struct commit_list *parents,
 				struct object_id *ret, const char *author,
 				const char *sign_commit,
 				struct commit_extra_header *);
 
-extern struct commit_extra_header *read_commit_extra_headers(struct commit *, const char **);
+struct commit_extra_header *read_commit_extra_headers(struct commit *, const char **);
 
-extern void free_commit_extra_headers(struct commit_extra_header *extra);
+void free_commit_extra_headers(struct commit_extra_header *extra);
 
 /*
  * Search the commit object contents given by "msg" for the header "key".
@@ -322,23 +322,23 @@ extern void free_commit_extra_headers(struct commit_extra_header *extra);
  * Note that some headers (like mergetag) may be multi-line. It is the caller's
  * responsibility to parse further in this case!
  */
-extern const char *find_commit_header(const char *msg, const char *key,
+const char *find_commit_header(const char *msg, const char *key,
 				      size_t *out_len);
 
 /* Find the end of the log message, the right place for a new trailer. */
-extern size_t ignore_non_trailer(const char *buf, size_t len);
+size_t ignore_non_trailer(const char *buf, size_t len);
 
 typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 				 void *cb_data);
 
-extern int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
+int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
 
 struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
 	char name[FLEX_ARRAY];
 };
-extern struct merge_remote_desc *merge_remote_util(struct commit *);
-extern void set_merge_remote_desc(struct commit *commit,
+struct merge_remote_desc *merge_remote_util(struct commit *);
+void set_merge_remote_desc(struct commit *commit,
 				  const char *name, struct object *obj);
 
 /*
@@ -348,9 +348,9 @@ extern void set_merge_remote_desc(struct commit *commit,
  */
 struct commit *get_merge_parent(const char *name);
 
-extern int parse_signed_commit(const struct commit *commit,
+int parse_signed_commit(const struct commit *commit,
 			       struct strbuf *message, struct strbuf *signature);
-extern int remove_signature(struct strbuf *buf);
+int remove_signature(struct strbuf *buf);
 
 /*
  * Check the signature of the given commit. The result of the check is stored
@@ -359,7 +359,7 @@ extern int remove_signature(struct strbuf *buf);
  * at all.  This may allocate memory for sig->gpg_output, sig->gpg_status,
  * sig->signer and sig->key.
  */
-extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
+int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
 /* record author-date for each commit object */
 struct author_date_slab;
@@ -379,6 +379,6 @@ int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused)
 int compare_commits_by_gen_then_commit_date(const void *a_, const void *b_, void *unused);
 
 LAST_ARG_MUST_BE_NULL
-extern int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
+int run_commit_hook(int editor_is_used, const char *index_file, const char *name, ...);
 
 #endif /* COMMIT_H */
diff --git a/compat/mingw.h b/compat/mingw.h
index 4d73f8aa9d..51938eac12 100644
--- a/compat/mingw.h
+++ b/compat/mingw.h
@@ -11,7 +11,7 @@ typedef _sigset_t sigset_t;
 #undef _POSIX_THREAD_SAFE_FUNCTIONS
 #endif
 
-extern int mingw_core_config(const char *var, const char *value, void *cb);
+int mingw_core_config(const char *var, const char *value, void *cb);
 #define platform_core_config mingw_core_config
 
 /*
@@ -449,7 +449,7 @@ static inline void convert_slashes(char *path)
 			*path = '/';
 }
 #define PATH_SEP ';'
-extern char *mingw_query_user_email(void);
+char *mingw_query_user_email(void);
 #define query_user_email mingw_query_user_email
 #if !defined(__MINGW64_VERSION_MAJOR) && (!defined(_MSC_VER) || _MSC_VER < 1800)
 #define PRIuMAX "I64u"
@@ -586,4 +586,4 @@ static int mingw_main(c,v)
 /*
  * Used by Pthread API implementation for Windows
  */
-extern int err_win_to_posix(DWORD winerr);
+int err_win_to_posix(DWORD winerr);
diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
index b833ff9225..797bd8b98e 100644
--- a/compat/nedmalloc/malloc.c.h
+++ b/compat/nedmalloc/malloc.c.h
@@ -1327,7 +1327,7 @@ int mspace_mallopt(int, int);
 #include <unistd.h>     /* for sbrk, sysconf */
 #else /* LACKS_UNISTD_H */
 #if !defined(__FreeBSD__) && !defined(__OpenBSD__) && !defined(__NetBSD__)
-extern void*     sbrk(ptrdiff_t);
+void*     sbrk(ptrdiff_t);
 #endif /* FreeBSD etc */
 #endif /* LACKS_UNISTD_H */
 
@@ -1444,7 +1444,7 @@ unsigned char _BitScanReverse(unsigned long *index, unsigned long mask);
 #    define malloc_getpagesize sysconf(_SC_PAGE_SIZE)
 #  else
 #    if defined(BSD) || defined(DGUX) || defined(HAVE_GETPAGESIZE)
-       extern size_t getpagesize();
+       size_t getpagesize();
 #      define malloc_getpagesize getpagesize()
 #    else
 #      ifdef WIN32 /* use supplied emulation of getpagesize */
@@ -1899,7 +1899,7 @@ static MLOCK_T malloc_global_mutex = PTHREAD_MUTEX_INITIALIZER;
 /* skipped internal declaration from pthread.h */
 #ifdef linux
 #ifndef PTHREAD_MUTEX_RECURSIVE
-extern int pthread_mutexattr_setkind_np __P ((pthread_mutexattr_t *__attr,
+int pthread_mutexattr_setkind_np __P ((pthread_mutexattr_t *__attr,
 					   int __kind));
 #define PTHREAD_MUTEX_RECURSIVE PTHREAD_MUTEX_RECURSIVE_NP
 #define pthread_mutexattr_settype(x,y) pthread_mutexattr_setkind_np(x,y)
diff --git a/compat/obstack.h b/compat/obstack.h
index ced94d0118..1ff8f3fc1e 100644
--- a/compat/obstack.h
+++ b/compat/obstack.h
@@ -182,13 +182,13 @@ struct obstack		/* control current object in current chunk */
 
 /* Declare the external functions we use; they are in obstack.c.  */
 
-extern void _obstack_newchunk (struct obstack *, int);
-extern int _obstack_begin (struct obstack *, int, int,
+void _obstack_newchunk (struct obstack *, int);
+int _obstack_begin (struct obstack *, int, int,
 			    void *(*) (long), void (*) (void *));
-extern int _obstack_begin_1 (struct obstack *, int, int,
+int _obstack_begin_1 (struct obstack *, int, int,
 			     void *(*) (void *, long),
 			     void (*) (void *, void *), void *);
-extern int _obstack_memory_used (struct obstack *);
+int _obstack_memory_used (struct obstack *);
 
 void obstack_free (struct obstack *, void *);
 
@@ -197,7 +197,7 @@ void obstack_free (struct obstack *, void *);
    more memory.  This can be set to a user defined function which
    should either abort gracefully or use longjump - but shouldn't
    return.  The default action is to print a message and abort.  */
-extern void (*obstack_alloc_failed_handler) (void);
+void (*obstack_alloc_failed_handler) (void);
 
 /* Pointer to beginning of object being allocated or to be allocated next.
    Note that this might not be the final address of the object
diff --git a/compat/poll/poll.h b/compat/poll/poll.h
index 1e1597360f..0a6d4967f0 100644
--- a/compat/poll/poll.h
+++ b/compat/poll/poll.h
@@ -57,7 +57,7 @@ struct pollfd
 
 typedef unsigned long nfds_t;
 
-extern int poll (struct pollfd *pfd, nfds_t nfd, int timeout);
+int poll (struct pollfd *pfd, nfds_t nfd, int timeout);
 
 /* Define INFTIM only if doing so conforms to POSIX.  */
 #if !defined (_POSIX_C_SOURCE) && !defined (_XOPEN_SOURCE)
diff --git a/compat/regex/regex.h b/compat/regex/regex.h
index 4d81358a83..16b0b4def3 100644
--- a/compat/regex/regex.h
+++ b/compat/regex/regex.h
@@ -465,19 +465,19 @@ typedef struct
 #ifdef __USE_GNU
 /* Sets the current default syntax to SYNTAX, and return the old syntax.
    You can also simply assign to the `re_syntax_options' variable.  */
-extern reg_syntax_t re_set_syntax (reg_syntax_t __syntax);
+reg_syntax_t re_set_syntax (reg_syntax_t __syntax);
 
 /* Compile the regular expression PATTERN, with length LENGTH
    and syntax given by the global `re_syntax_options', into the buffer
    BUFFER.  Return NULL if successful, and an error string if not.  */
-extern const char *re_compile_pattern (const char *__pattern, size_t __length,
+const char *re_compile_pattern (const char *__pattern, size_t __length,
 				       struct re_pattern_buffer *__buffer);
 
 
 /* Compile a fastmap for the compiled pattern in BUFFER; used to
    accelerate searches.  Return 0 if successful and -2 if was an
    internal error.  */
-extern int re_compile_fastmap (struct re_pattern_buffer *__buffer);
+int re_compile_fastmap (struct re_pattern_buffer *__buffer);
 
 
 /* Search in the string STRING (with length LENGTH) for the pattern
@@ -485,14 +485,14 @@ extern int re_compile_fastmap (struct re_pattern_buffer *__buffer);
    characters.  Return the starting position of the match, -1 for no
    match, or -2 for an internal error.  Also return register
    information in REGS (if REGS and BUFFER->no_sub are nonzero).  */
-extern int re_search (struct re_pattern_buffer *__buffer, const char *__cstring,
+int re_search (struct re_pattern_buffer *__buffer, const char *__cstring,
 		      int __length, int __start, int __range,
 		      struct re_registers *__regs);
 
 
 /* Like `re_search', but search in the concatenation of STRING1 and
    STRING2.  Also, stop searching at index START + STOP.  */
-extern int re_search_2 (struct re_pattern_buffer *__buffer,
+int re_search_2 (struct re_pattern_buffer *__buffer,
 			const char *__string1, int __length1,
 			const char *__string2, int __length2, int __start,
 			int __range, struct re_registers *__regs, int __stop);
@@ -500,12 +500,12 @@ extern int re_search_2 (struct re_pattern_buffer *__buffer,
 
 /* Like `re_search', but return how many characters in STRING the regexp
    in BUFFER matched, starting at position START.  */
-extern int re_match (struct re_pattern_buffer *__buffer, const char *__cstring,
+int re_match (struct re_pattern_buffer *__buffer, const char *__cstring,
 		     int __length, int __start, struct re_registers *__regs);
 
 
 /* Relates to `re_match' as `re_search_2' relates to `re_search'.  */
-extern int re_match_2 (struct re_pattern_buffer *__buffer,
+int re_match_2 (struct re_pattern_buffer *__buffer,
 		       const char *__string1, int __length1,
 		       const char *__string2, int __length2, int __start,
 		       struct re_registers *__regs, int __stop);
@@ -523,7 +523,7 @@ extern int re_match_2 (struct re_pattern_buffer *__buffer,
    Unless this function is called, the first search or match using
    PATTERN_BUFFER will allocate its own register data, without
    freeing the old data.  */
-extern void re_set_registers (struct re_pattern_buffer *__buffer,
+void re_set_registers (struct re_pattern_buffer *__buffer,
 			      struct re_registers *__regs,
 			      unsigned int __num_regs,
 			      regoff_t *__starts, regoff_t *__ends);
@@ -532,8 +532,8 @@ extern void re_set_registers (struct re_pattern_buffer *__buffer,
 #if defined _REGEX_RE_COMP || (defined _LIBC && defined __USE_BSD)
 # ifndef _CRAY
 /* 4.2 bsd compatibility.  */
-extern char *re_comp (const char *);
-extern int re_exec (const char *);
+char *re_comp (const char *);
+int re_exec (const char *);
 # endif
 #endif
 
@@ -559,19 +559,19 @@ extern int re_exec (const char *);
 #endif
 
 /* POSIX compatibility.  */
-extern int regcomp (regex_t *__restrict __preg,
+int regcomp (regex_t *__restrict __preg,
 		    const char *__restrict __pattern,
 		    int __cflags);
 
-extern int regexec (const regex_t *__restrict __preg,
+int regexec (const regex_t *__restrict __preg,
 		    const char *__restrict __cstring, size_t __nmatch,
 		    regmatch_t __pmatch[__restrict_arr],
 		    int __eflags);
 
-extern size_t regerror (int __errcode, const regex_t *__restrict __preg,
+size_t regerror (int __errcode, const regex_t *__restrict __preg,
 			char *__restrict __errbuf, size_t __errbuf_size);
 
-extern void regfree (regex_t *__preg);
+void regfree (regex_t *__preg);
 
 
 #ifdef __cplusplus
diff --git a/compat/win32/pthread.h b/compat/win32/pthread.h
index c6cb8dd219..f1cfe73de9 100644
--- a/compat/win32/pthread.h
+++ b/compat/win32/pthread.h
@@ -50,7 +50,7 @@ typedef struct {
 	DWORD tid;
 } pthread_t;
 
-extern int pthread_create(pthread_t *thread, const void *unused,
+int pthread_create(pthread_t *thread, const void *unused,
 			  void *(*start_routine)(void*), void *arg);
 
 /*
@@ -59,10 +59,10 @@ extern int pthread_create(pthread_t *thread, const void *unused,
  */
 #define pthread_join(a, b) win32_pthread_join(&(a), (b))
 
-extern int win32_pthread_join(pthread_t *thread, void **value_ptr);
+int win32_pthread_join(pthread_t *thread, void **value_ptr);
 
 #define pthread_equal(t1, t2) ((t1).tid == (t2).tid)
-extern pthread_t pthread_self(void);
+pthread_t pthread_self(void);
 
 static inline void NORETURN pthread_exit(void *ret)
 {
diff --git a/config.h b/config.h
index ee5d3fa7b4..1482b9b7fa 100644
--- a/config.h
+++ b/config.h
@@ -68,62 +68,62 @@ struct config_options {
 };
 
 typedef int (*config_fn_t)(const char *, const char *, void *);
-extern int git_default_config(const char *, const char *, void *);
-extern int git_config_from_file(config_fn_t fn, const char *, void *);
-extern int git_config_from_file_with_options(config_fn_t fn, const char *,
+int git_default_config(const char *, const char *, void *);
+int git_config_from_file(config_fn_t fn, const char *, void *);
+int git_config_from_file_with_options(config_fn_t fn, const char *,
 					     void *,
 					     const struct config_options *);
-extern int git_config_from_mem(config_fn_t fn,
+int git_config_from_mem(config_fn_t fn,
 			       const enum config_origin_type,
 			       const char *name,
 			       const char *buf, size_t len,
 			       void *data, const struct config_options *opts);
-extern int git_config_from_blob_oid(config_fn_t fn, const char *name,
+int git_config_from_blob_oid(config_fn_t fn, const char *name,
 				    const struct object_id *oid, void *data);
-extern void git_config_push_parameter(const char *text);
-extern int git_config_from_parameters(config_fn_t fn, void *data);
-extern void read_early_config(config_fn_t cb, void *data);
-extern void git_config(config_fn_t fn, void *);
-extern int config_with_options(config_fn_t fn, void *,
+void git_config_push_parameter(const char *text);
+int git_config_from_parameters(config_fn_t fn, void *data);
+void read_early_config(config_fn_t cb, void *data);
+void git_config(config_fn_t fn, void *);
+int config_with_options(config_fn_t fn, void *,
 			       struct git_config_source *config_source,
 			       const struct config_options *opts);
-extern int git_parse_ssize_t(const char *, ssize_t *);
-extern int git_parse_ulong(const char *, unsigned long *);
-extern int git_parse_maybe_bool(const char *);
-extern int git_config_int(const char *, const char *);
-extern int64_t git_config_int64(const char *, const char *);
-extern unsigned long git_config_ulong(const char *, const char *);
-extern ssize_t git_config_ssize_t(const char *, const char *);
-extern int git_config_bool_or_int(const char *, const char *, int *);
-extern int git_config_bool(const char *, const char *);
-extern int git_config_string(const char **, const char *, const char *);
-extern int git_config_pathname(const char **, const char *, const char *);
-extern int git_config_expiry_date(timestamp_t *, const char *, const char *);
-extern int git_config_color(char *, const char *, const char *);
-extern int git_config_set_in_file_gently(const char *, const char *, const char *);
-extern void git_config_set_in_file(const char *, const char *, const char *);
-extern int git_config_set_gently(const char *, const char *);
-extern void git_config_set(const char *, const char *);
-extern int git_config_parse_key(const char *, char **, int *);
-extern int git_config_key_is_valid(const char *key);
-extern int git_config_set_multivar_gently(const char *, const char *, const char *, int);
-extern void git_config_set_multivar(const char *, const char *, const char *, int);
-extern int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
-extern void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
-extern int git_config_rename_section(const char *, const char *);
-extern int git_config_rename_section_in_file(const char *, const char *, const char *);
-extern int git_config_copy_section(const char *, const char *);
-extern int git_config_copy_section_in_file(const char *, const char *, const char *);
-extern const char *git_etc_gitconfig(void);
-extern int git_env_bool(const char *, int);
-extern unsigned long git_env_ulong(const char *, unsigned long);
-extern int git_config_system(void);
-extern int config_error_nonbool(const char *);
+int git_parse_ssize_t(const char *, ssize_t *);
+int git_parse_ulong(const char *, unsigned long *);
+int git_parse_maybe_bool(const char *);
+int git_config_int(const char *, const char *);
+int64_t git_config_int64(const char *, const char *);
+unsigned long git_config_ulong(const char *, const char *);
+ssize_t git_config_ssize_t(const char *, const char *);
+int git_config_bool_or_int(const char *, const char *, int *);
+int git_config_bool(const char *, const char *);
+int git_config_string(const char **, const char *, const char *);
+int git_config_pathname(const char **, const char *, const char *);
+int git_config_expiry_date(timestamp_t *, const char *, const char *);
+int git_config_color(char *, const char *, const char *);
+int git_config_set_in_file_gently(const char *, const char *, const char *);
+void git_config_set_in_file(const char *, const char *, const char *);
+int git_config_set_gently(const char *, const char *);
+void git_config_set(const char *, const char *);
+int git_config_parse_key(const char *, char **, int *);
+int git_config_key_is_valid(const char *key);
+int git_config_set_multivar_gently(const char *, const char *, const char *, int);
+void git_config_set_multivar(const char *, const char *, const char *, int);
+int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
+void git_config_set_multivar_in_file(const char *, const char *, const char *, const char *, int);
+int git_config_rename_section(const char *, const char *);
+int git_config_rename_section_in_file(const char *, const char *, const char *);
+int git_config_copy_section(const char *, const char *);
+int git_config_copy_section_in_file(const char *, const char *, const char *);
+const char *git_etc_gitconfig(void);
+int git_env_bool(const char *, int);
+unsigned long git_env_ulong(const char *, unsigned long);
+int git_config_system(void);
+int config_error_nonbool(const char *);
 #if defined(__GNUC__)
 #define config_error_nonbool(s) (config_error_nonbool(s), const_error())
 #endif
 
-extern int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
+int git_config_parse_parameter(const char *, config_fn_t fn, void *data);
 
 enum config_scope {
 	CONFIG_SCOPE_UNKNOWN = 0,
@@ -133,9 +133,9 @@ enum config_scope {
 	CONFIG_SCOPE_CMDLINE,
 };
 
-extern enum config_scope current_config_scope(void);
-extern const char *current_config_origin_type(void);
-extern const char *current_config_name(void);
+enum config_scope current_config_scope(void);
+const char *current_config_origin_type(void);
+const char *current_config_name(void);
 
 struct config_include_data {
 	int depth;
@@ -144,7 +144,7 @@ struct config_include_data {
 	const struct config_options *opts;
 };
 #define CONFIG_INCLUDE_INIT { 0 }
-extern int git_config_include(const char *name, const char *value, void *data);
+int git_config_include(const char *name, const char *value, void *data);
 
 /*
  * Match and parse a config key of the form:
@@ -159,7 +159,7 @@ extern int git_config_include(const char *name, const char *value, void *data);
  * If the subsection pointer-to-pointer passed in is NULL, returns 0 only if
  * there is no subsection at all.
  */
-extern int parse_config_key(const char *var,
+int parse_config_key(const char *var,
 			    const char *section,
 			    const char **subsection, int *subsection_len,
 			    const char **key);
@@ -192,71 +192,71 @@ struct config_set {
 	struct configset_list list;
 };
 
-extern void git_configset_init(struct config_set *cs);
-extern int git_configset_add_file(struct config_set *cs, const char *filename);
-extern const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
-extern void git_configset_clear(struct config_set *cs);
+void git_configset_init(struct config_set *cs);
+int git_configset_add_file(struct config_set *cs, const char *filename);
+const struct string_list *git_configset_get_value_multi(struct config_set *cs, const char *key);
+void git_configset_clear(struct config_set *cs);
 
 /*
  * These functions return 1 if not found, and 0 if found, leaving the found
  * value in the 'dest' pointer.
  */
-extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
-extern int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
-extern int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
-extern int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
-extern int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
-extern int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
-extern int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
-extern int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
-extern int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
+int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
+int git_configset_get_string_const(struct config_set *cs, const char *key, const char **dest);
+int git_configset_get_string(struct config_set *cs, const char *key, char **dest);
+int git_configset_get_int(struct config_set *cs, const char *key, int *dest);
+int git_configset_get_ulong(struct config_set *cs, const char *key, unsigned long *dest);
+int git_configset_get_bool(struct config_set *cs, const char *key, int *dest);
+int git_configset_get_bool_or_int(struct config_set *cs, const char *key, int *is_bool, int *dest);
+int git_configset_get_maybe_bool(struct config_set *cs, const char *key, int *dest);
+int git_configset_get_pathname(struct config_set *cs, const char *key, const char **dest);
 
 /* Functions for reading a repository's config */
 struct repository;
-extern void repo_config(struct repository *repo, config_fn_t fn, void *data);
-extern int repo_config_get_value(struct repository *repo,
+void repo_config(struct repository *repo, config_fn_t fn, void *data);
+int repo_config_get_value(struct repository *repo,
 				 const char *key, const char **value);
-extern const struct string_list *repo_config_get_value_multi(struct repository *repo,
+const struct string_list *repo_config_get_value_multi(struct repository *repo,
 							     const char *key);
-extern int repo_config_get_string_const(struct repository *repo,
+int repo_config_get_string_const(struct repository *repo,
 					const char *key, const char **dest);
-extern int repo_config_get_string(struct repository *repo,
+int repo_config_get_string(struct repository *repo,
 				  const char *key, char **dest);
-extern int repo_config_get_int(struct repository *repo,
+int repo_config_get_int(struct repository *repo,
 			       const char *key, int *dest);
-extern int repo_config_get_ulong(struct repository *repo,
+int repo_config_get_ulong(struct repository *repo,
 				 const char *key, unsigned long *dest);
-extern int repo_config_get_bool(struct repository *repo,
+int repo_config_get_bool(struct repository *repo,
 				const char *key, int *dest);
-extern int repo_config_get_bool_or_int(struct repository *repo,
+int repo_config_get_bool_or_int(struct repository *repo,
 				       const char *key, int *is_bool, int *dest);
-extern int repo_config_get_maybe_bool(struct repository *repo,
+int repo_config_get_maybe_bool(struct repository *repo,
 				      const char *key, int *dest);
-extern int repo_config_get_pathname(struct repository *repo,
+int repo_config_get_pathname(struct repository *repo,
 				    const char *key, const char **dest);
 
-extern int git_config_get_value(const char *key, const char **value);
-extern const struct string_list *git_config_get_value_multi(const char *key);
-extern void git_config_clear(void);
-extern int git_config_get_string_const(const char *key, const char **dest);
-extern int git_config_get_string(const char *key, char **dest);
-extern int git_config_get_int(const char *key, int *dest);
-extern int git_config_get_ulong(const char *key, unsigned long *dest);
-extern int git_config_get_bool(const char *key, int *dest);
-extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
-extern int git_config_get_maybe_bool(const char *key, int *dest);
-extern int git_config_get_pathname(const char *key, const char **dest);
-extern int git_config_get_index_threads(int *dest);
-extern int git_config_get_untracked_cache(void);
-extern int git_config_get_split_index(void);
-extern int git_config_get_max_percent_split_change(void);
-extern int git_config_get_fsmonitor(void);
+int git_config_get_value(const char *key, const char **value);
+const struct string_list *git_config_get_value_multi(const char *key);
+void git_config_clear(void);
+int git_config_get_string_const(const char *key, const char **dest);
+int git_config_get_string(const char *key, char **dest);
+int git_config_get_int(const char *key, int *dest);
+int git_config_get_ulong(const char *key, unsigned long *dest);
+int git_config_get_bool(const char *key, int *dest);
+int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
+int git_config_get_maybe_bool(const char *key, int *dest);
+int git_config_get_pathname(const char *key, const char **dest);
+int git_config_get_index_threads(int *dest);
+int git_config_get_untracked_cache(void);
+int git_config_get_split_index(void);
+int git_config_get_max_percent_split_change(void);
+int git_config_get_fsmonitor(void);
 
 /* This dies if the configured or default date is in the future */
-extern int git_config_get_expiry(const char *key, const char **output);
+int git_config_get_expiry(const char *key, const char **output);
 
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
-extern int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
+int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
 
 struct key_value_info {
 	const char *filename;
@@ -265,8 +265,8 @@ struct key_value_info {
 	enum config_scope scope;
 };
 
-extern NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
-extern NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
+NORETURN void git_die_config(const char *key, const char *err, ...) __attribute__((format(printf, 2, 3)));
+NORETURN void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
 #define LOOKUP_CONFIG(mapping, var) \
 	lookup_config(mapping, ARRAY_SIZE(mapping), var)
diff --git a/connect.h b/connect.h
index 32aff60979..61a005603a 100644
--- a/connect.h
+++ b/connect.h
@@ -7,19 +7,19 @@
 #define CONNECT_DIAG_URL      (1u << 1)
 #define CONNECT_IPV4          (1u << 2)
 #define CONNECT_IPV6          (1u << 3)
-extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
-extern int finish_connect(struct child_process *conn);
-extern int git_connection_is_socket(struct child_process *conn);
-extern int server_supports(const char *feature);
-extern int parse_feature_request(const char *features, const char *feature);
-extern const char *server_feature_value(const char *feature, int *len_ret);
-extern int url_is_local_not_ssh(const char *url);
+struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
+int finish_connect(struct child_process *conn);
+int git_connection_is_socket(struct child_process *conn);
+int server_supports(const char *feature);
+int parse_feature_request(const char *features, const char *feature);
+const char *server_feature_value(const char *feature, int *len_ret);
+int url_is_local_not_ssh(const char *url);
 
 struct packet_reader;
-extern enum protocol_version discover_version(struct packet_reader *reader);
+enum protocol_version discover_version(struct packet_reader *reader);
 
-extern int server_supports_v2(const char *c, int die_on_error);
-extern int server_supports_feature(const char *c, const char *feature,
+int server_supports_v2(const char *c, int die_on_error);
+int server_supports_feature(const char *c, const char *feature,
 				   int die_on_error);
 
 #endif
diff --git a/csum-file.h b/csum-file.h
index 3bf7184736..a98b1eee53 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -25,22 +25,22 @@ struct hashfile_checkpoint {
 	git_hash_ctx ctx;
 };
 
-extern void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
-extern int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
+void hashfile_checkpoint(struct hashfile *, struct hashfile_checkpoint *);
+int hashfile_truncate(struct hashfile *, struct hashfile_checkpoint *);
 
 /* finalize_hashfile flags */
 #define CSUM_CLOSE		1
 #define CSUM_FSYNC		2
 #define CSUM_HASH_IN_STREAM	4
 
-extern struct hashfile *hashfd(int fd, const char *name);
-extern struct hashfile *hashfd_check(const char *name);
-extern struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
-extern int finalize_hashfile(struct hashfile *, unsigned char *, unsigned int);
-extern void hashwrite(struct hashfile *, const void *, unsigned int);
-extern void hashflush(struct hashfile *f);
-extern void crc32_begin(struct hashfile *);
-extern uint32_t crc32_end(struct hashfile *);
+struct hashfile *hashfd(int fd, const char *name);
+struct hashfile *hashfd_check(const char *name);
+struct hashfile *hashfd_throughput(int fd, const char *name, struct progress *tp);
+int finalize_hashfile(struct hashfile *, unsigned char *, unsigned int);
+void hashwrite(struct hashfile *, const void *, unsigned int);
+void hashflush(struct hashfile *f);
+void crc32_begin(struct hashfile *);
+uint32_t crc32_end(struct hashfile *);
 
 static inline void hashwrite_u8(struct hashfile *f, uint8_t data)
 {
diff --git a/decorate.h b/decorate.h
index 9014c1e996..ee43dee1f0 100644
--- a/decorate.h
+++ b/decorate.h
@@ -50,12 +50,12 @@ struct decoration {
  * NULL), returning the previously associated pointer. If there is no previous
  * association, this function returns NULL.
  */
-extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
+void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
 
 /*
  * Return the pointer associated to the given object. If there is no
  * association, this function returns NULL.
  */
-extern void *lookup_decoration(struct decoration *n, const struct object *obj);
+void *lookup_decoration(struct decoration *n, const struct object *obj);
 
 #endif
diff --git a/delta.h b/delta.h
index 9b67531dfa..592bd9c27e 100644
--- a/delta.h
+++ b/delta.h
@@ -21,14 +21,14 @@ create_delta_index(const void *buf, unsigned long bufsize);
  *
  * Given pointer must be what create_delta_index() returned, or NULL.
  */
-extern void free_delta_index(struct delta_index *index);
+void free_delta_index(struct delta_index *index);
 
 /*
  * sizeof_delta_index: returns memory usage of delta index
  *
  * Given pointer must be what create_delta_index() returned, or NULL.
  */
-extern unsigned long sizeof_delta_index(struct delta_index *index);
+unsigned long sizeof_delta_index(struct delta_index *index);
 
 /*
  * create_delta: create a delta from given index for the given buffer
@@ -75,7 +75,7 @@ diff_delta(const void *src_buf, unsigned long src_bufsize,
  * *trg_bufsize is updated with its size.  On failure a NULL pointer is
  * returned.  The returned buffer must be freed by the caller.
  */
-extern void *patch_delta(const void *src_buf, unsigned long src_size,
+void *patch_delta(const void *src_buf, unsigned long src_size,
 			 const void *delta_buf, unsigned long delta_size,
 			 unsigned long *dst_size);
 
diff --git a/dir.h b/dir.h
index e3ec26143d..4c227cc3dc 100644
--- a/dir.h
+++ b/dir.h
@@ -202,7 +202,7 @@ struct dir_struct {
 };
 
 /*Count the number of slashes for string s*/
-extern int count_slashes(const char *s);
+int count_slashes(const char *s);
 
 /*
  * The ordering of these constants is significant, with
@@ -213,24 +213,24 @@ extern int count_slashes(const char *s);
 #define MATCHED_RECURSIVELY 1
 #define MATCHED_FNMATCH 2
 #define MATCHED_EXACTLY 3
-extern int simple_length(const char *match);
-extern int no_wildcard(const char *string);
-extern char *common_prefix(const struct pathspec *pathspec);
-extern int match_pathspec(const struct index_state *istate,
+int simple_length(const char *match);
+int no_wildcard(const char *string);
+char *common_prefix(const struct pathspec *pathspec);
+int match_pathspec(const struct index_state *istate,
 			  const struct pathspec *pathspec,
 			  const char *name, int namelen,
 			  int prefix, char *seen, int is_dir);
-extern int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
-extern int within_depth(const char *name, int namelen, int depth, int max_depth);
+int report_path_error(const char *ps_matched, const struct pathspec *pathspec, const char *prefix);
+int within_depth(const char *name, int namelen, int depth, int max_depth);
 
-extern int fill_directory(struct dir_struct *dir,
+int fill_directory(struct dir_struct *dir,
 			  struct index_state *istate,
 			  const struct pathspec *pathspec);
-extern int read_directory(struct dir_struct *, struct index_state *istate,
+int read_directory(struct dir_struct *, struct index_state *istate,
 			  const char *path, int len,
 			  const struct pathspec *pathspec);
 
-extern int is_excluded_from_list(const char *pathname, int pathlen,
+int is_excluded_from_list(const char *pathname, int pathlen,
 				 const char *basename, int *dtype,
 				 struct exclude_list *el,
 				 struct index_state *istate);
@@ -242,37 +242,37 @@ struct dir_entry *dir_add_ignored(struct dir_struct *dir,
  * these implement the matching logic for dir.c:excluded_from_list and
  * attr.c:path_matches()
  */
-extern int match_basename(const char *, int,
+int match_basename(const char *, int,
 			  const char *, int, int, unsigned);
-extern int match_pathname(const char *, int,
+int match_pathname(const char *, int,
 			  const char *, int,
 			  const char *, int, int, unsigned);
 
-extern struct exclude *last_exclude_matching(struct dir_struct *dir,
+struct exclude *last_exclude_matching(struct dir_struct *dir,
 					     struct index_state *istate,
 					     const char *name, int *dtype);
 
-extern int is_excluded(struct dir_struct *dir,
+int is_excluded(struct dir_struct *dir,
 		       struct index_state *istate,
 		       const char *name, int *dtype);
 
-extern struct exclude_list *add_exclude_list(struct dir_struct *dir,
+struct exclude_list *add_exclude_list(struct dir_struct *dir,
 					     int group_type, const char *src);
-extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
+int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
 					  struct exclude_list *el, struct  index_state *istate);
-extern void add_excludes_from_file(struct dir_struct *, const char *fname);
-extern int add_excludes_from_blob_to_list(struct object_id *oid,
+void add_excludes_from_file(struct dir_struct *, const char *fname);
+int add_excludes_from_blob_to_list(struct object_id *oid,
 					  const char *base, int baselen,
 					  struct exclude_list *el);
-extern void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
-extern void add_exclude(const char *string, const char *base,
+void parse_exclude_pattern(const char **string, int *patternlen, unsigned *flags, int *nowildcardlen);
+void add_exclude(const char *string, const char *base,
 			int baselen, struct exclude_list *el, int srcpos);
-extern void clear_exclude_list(struct exclude_list *el);
-extern void clear_directory(struct dir_struct *dir);
-extern int file_exists(const char *);
+void clear_exclude_list(struct exclude_list *el);
+void clear_directory(struct dir_struct *dir);
+int file_exists(const char *);
 
-extern int is_inside_dir(const char *dir);
-extern int dir_inside_of(const char *subdir, const char *dir);
+int is_inside_dir(const char *dir);
+int dir_inside_of(const char *subdir, const char *dir);
 
 static inline int is_dot_or_dotdot(const char *name)
 {
@@ -281,9 +281,9 @@ static inline int is_dot_or_dotdot(const char *name)
 		 (name[1] == '.' && name[2] == '\0')));
 }
 
-extern int is_empty_dir(const char *dir);
+int is_empty_dir(const char *dir);
 
-extern void setup_standard_excludes(struct dir_struct *dir);
+void setup_standard_excludes(struct dir_struct *dir);
 
 
 /* Constants for remove_dir_recursively: */
@@ -311,23 +311,23 @@ extern void setup_standard_excludes(struct dir_struct *dir);
  * This function uses path as temporary scratch space, but restores it
  * before returning.
  */
-extern int remove_dir_recursively(struct strbuf *path, int flag);
+int remove_dir_recursively(struct strbuf *path, int flag);
 
 /* tries to remove the path with empty directories along it, ignores ENOENT */
-extern int remove_path(const char *path);
+int remove_path(const char *path);
 
-extern int fspathcmp(const char *a, const char *b);
-extern int fspathncmp(const char *a, const char *b, size_t count);
+int fspathcmp(const char *a, const char *b);
+int fspathncmp(const char *a, const char *b, size_t count);
 
 /*
  * The prefix part of pattern must not contains wildcards.
  */
 struct pathspec_item;
-extern int git_fnmatch(const struct pathspec_item *item,
+int git_fnmatch(const struct pathspec_item *item,
 		       const char *pattern, const char *string,
 		       int prefix);
 
-extern int submodule_path_match(const struct index_state *istate,
+int submodule_path_match(const struct index_state *istate,
 				const struct pathspec *ps,
 				const char *submodule_name,
 				char *seen);
@@ -372,10 +372,10 @@ void remove_untracked_cache(struct index_state *istate);
  * When `recurse_into_nested` is set, recurse into any nested submodules,
  * connecting them as well.
  */
-extern void connect_work_tree_and_git_dir(const char *work_tree,
+void connect_work_tree_and_git_dir(const char *work_tree,
 					  const char *git_dir,
 					  int recurse_into_nested);
-extern void relocate_gitdir(const char *path,
+void relocate_gitdir(const char *path,
 			    const char *old_git_dir,
 			    const char *new_git_dir);
 #endif
diff --git a/exec-cmd.h b/exec-cmd.h
index 2522453cda..8cd1df28d3 100644
--- a/exec-cmd.h
+++ b/exec-cmd.h
@@ -3,14 +3,14 @@
 
 struct argv_array;
 
-extern void git_set_exec_path(const char *exec_path);
-extern void git_resolve_executable_dir(const char *path);
-extern const char *git_exec_path(void);
-extern void setup_path(void);
-extern const char **prepare_git_cmd(struct argv_array *out, const char **argv);
-extern int execv_git_cmd(const char **argv); /* NULL terminated */
+void git_set_exec_path(const char *exec_path);
+void git_resolve_executable_dir(const char *path);
+const char *git_exec_path(void);
+void setup_path(void);
+const char **prepare_git_cmd(struct argv_array *out, const char **argv);
+int execv_git_cmd(const char **argv); /* NULL terminated */
 LAST_ARG_MUST_BE_NULL
-extern int execl_git_cmd(const char *cmd, ...);
-extern char *system_path(const char *path);
+int execl_git_cmd(const char *cmd, ...);
+char *system_path(const char *path);
 
 #endif /* GIT_EXEC_CMD_H */
diff --git a/fmt-merge-msg.h b/fmt-merge-msg.h
index b28d3a6113..01e3aa88c5 100644
--- a/fmt-merge-msg.h
+++ b/fmt-merge-msg.h
@@ -2,6 +2,6 @@
 #define FMT_MERGE_MSG_H
 
 extern int merge_log_config;
-extern int fmt_merge_msg_config(const char *key, const char *value, void *cb);
+int fmt_merge_msg_config(const char *key, const char *value, void *cb);
 
 #endif /* FMT_MERGE_MSG_H */
diff --git a/fsmonitor.h b/fsmonitor.h
index 01017c43aa..8489fa3244 100644
--- a/fsmonitor.h
+++ b/fsmonitor.h
@@ -10,31 +10,31 @@ extern struct trace_key trace_fsmonitor;
  * Read the fsmonitor index extension and (if configured) restore the
  * CE_FSMONITOR_VALID state.
  */
-extern int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz);
+int read_fsmonitor_extension(struct index_state *istate, const void *data, unsigned long sz);
 
 /*
  * Fill the fsmonitor_dirty ewah bits with their state from the index,
  * before it is split during writing.
  */
-extern void fill_fsmonitor_bitmap(struct index_state *istate);
+void fill_fsmonitor_bitmap(struct index_state *istate);
 
 /*
  * Write the CE_FSMONITOR_VALID state into the fsmonitor index
  * extension.  Reads from the fsmonitor_dirty ewah in the index.
  */
-extern void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate);
+void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate);
 
 /*
  * Add/remove the fsmonitor index extension
  */
-extern void add_fsmonitor(struct index_state *istate);
-extern void remove_fsmonitor(struct index_state *istate);
+void add_fsmonitor(struct index_state *istate);
+void remove_fsmonitor(struct index_state *istate);
 
 /*
  * Add/remove the fsmonitor index extension as necessary based on the current
  * core.fsmonitor setting.
  */
-extern void tweak_fsmonitor(struct index_state *istate);
+void tweak_fsmonitor(struct index_state *istate);
 
 /*
  * Run the configured fsmonitor integration script and clear the
@@ -42,7 +42,7 @@ extern void tweak_fsmonitor(struct index_state *istate);
  * any corresponding untracked cache directory structures. Optimized to only
  * run the first time it is called.
  */
-extern void refresh_fsmonitor(struct index_state *istate);
+void refresh_fsmonitor(struct index_state *istate);
 
 /*
  * Set the given cache entries CE_FSMONITOR_VALID bit. This should be
diff --git a/gettext.h b/gettext.h
index 71255e503e..bee52eb113 100644
--- a/gettext.h
+++ b/gettext.h
@@ -28,11 +28,11 @@
 
 #define FORMAT_PRESERVING(n) __attribute__((format_arg(n)))
 
-extern int use_gettext_poison(void);
+int use_gettext_poison(void);
 
 #ifndef NO_GETTEXT
-extern void git_setup_gettext(void);
-extern int gettext_width(const char *s);
+void git_setup_gettext(void);
+int gettext_width(const char *s);
 #else
 static inline void git_setup_gettext(void)
 {
@@ -87,6 +87,6 @@ const char *Q_(const char *msgid, const char *plu, unsigned long n)
 #endif
 
 const char *get_preferred_languages(void);
-extern int is_utf8_locale(void);
+int is_utf8_locale(void);
 
 #endif
diff --git a/git-compat-util.h b/git-compat-util.h
index 31b47932bd..fbfc53df4b 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -249,7 +249,7 @@ typedef unsigned long uintptr_t;
 
 #ifdef MKDIR_WO_TRAILING_SLASH
 #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
-extern int compat_mkdir_wo_trailing_slash(const char*, mode_t);
+int compat_mkdir_wo_trailing_slash(const char*, mode_t);
 #endif
 
 #ifdef NO_STRUCT_ITIMERVAL
@@ -267,9 +267,9 @@ struct itimerval {
 #include <libgen.h>
 #else
 #define basename gitbasename
-extern char *gitbasename(char *);
+char *gitbasename(char *);
 #define dirname gitdirname
-extern char *gitdirname(char *);
+char *gitdirname(char *);
 #endif
 
 #ifndef NO_ICONV
@@ -446,15 +446,15 @@ static inline char *git_find_last_dir_sep(const char *path)
 struct strbuf;
 
 /* General helper functions */
-extern void vreportf(const char *prefix, const char *err, va_list params);
-extern NORETURN void usage(const char *err);
-extern NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
-extern void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void vreportf(const char *prefix, const char *err, va_list params);
+NORETURN void usage(const char *err);
+NORETURN void usagef(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die(const char *err, ...) __attribute__((format (printf, 1, 2)));
+NORETURN void die_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
+int error_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning(const char *err, ...) __attribute__((format (printf, 1, 2)));
+void warning_errno(const char *err, ...) __attribute__((format (printf, 1, 2)));
 
 #ifndef NO_OPENSSL
 #ifdef APPLE_COMMON_CRYPTO
@@ -482,15 +482,15 @@ static inline int const_error(void)
 #define error_errno(...) (error_errno(__VA_ARGS__), const_error())
 #endif
 
-extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
-extern void set_error_routine(void (*routine)(const char *err, va_list params));
-extern void (*get_error_routine(void))(const char *err, va_list params);
-extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
-extern void (*get_warn_routine(void))(const char *warn, va_list params);
-extern void set_die_is_recursing_routine(int (*routine)(void));
+void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
+void set_error_routine(void (*routine)(const char *err, va_list params));
+void (*get_error_routine(void))(const char *err, va_list params);
+void set_warn_routine(void (*routine)(const char *warn, va_list params));
+void (*get_warn_routine(void))(const char *warn, va_list params);
+void set_die_is_recursing_routine(int (*routine)(void));
 
-extern int starts_with(const char *str, const char *prefix);
-extern int istarts_with(const char *str, const char *prefix);
+int starts_with(const char *str, const char *prefix);
+int istarts_with(const char *str, const char *prefix);
 
 /*
  * If the string "str" begins with the string found in "prefix", return 1.
@@ -613,8 +613,8 @@ static inline int ends_with(const char *str, const char *suffix)
 
 #define mmap git_mmap
 #define munmap git_munmap
-extern void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
-extern int git_munmap(void *start, size_t length);
+void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+int git_munmap(void *start, size_t length);
 
 #else /* NO_MMAP || USE_WIN32_MMAP */
 
@@ -668,17 +668,17 @@ extern int git_munmap(void *start, size_t length);
 #undef stat
 #endif
 #define stat(path, buf) git_stat(path, buf)
-extern int git_stat(const char *, struct stat *);
+int git_stat(const char *, struct stat *);
 #ifdef fstat
 #undef fstat
 #endif
 #define fstat(fd, buf) git_fstat(fd, buf)
-extern int git_fstat(int, struct stat *);
+int git_fstat(int, struct stat *);
 #ifdef lstat
 #undef lstat
 #endif
 #define lstat(path, buf) git_lstat(path, buf)
-extern int git_lstat(const char *, struct stat *);
+int git_lstat(const char *, struct stat *);
 #endif
 
 #define DEFAULT_PACKED_GIT_LIMIT \
@@ -686,50 +686,50 @@ extern int git_lstat(const char *, struct stat *);
 
 #ifdef NO_PREAD
 #define pread git_pread
-extern ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
+ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
 /*
  * Forward decl that will remind us if its twin in cache.h changes.
  * This function is used in compat/pread.c.  But we can't include
  * cache.h there.
  */
-extern ssize_t read_in_full(int fd, void *buf, size_t count);
+ssize_t read_in_full(int fd, void *buf, size_t count);
 
 #ifdef NO_SETENV
 #define setenv gitsetenv
-extern int gitsetenv(const char *, const char *, int);
+int gitsetenv(const char *, const char *, int);
 #endif
 
 #ifdef NO_MKDTEMP
 #define mkdtemp gitmkdtemp
-extern char *gitmkdtemp(char *);
+char *gitmkdtemp(char *);
 #endif
 
 #ifdef NO_UNSETENV
 #define unsetenv gitunsetenv
-extern void gitunsetenv(const char *);
+void gitunsetenv(const char *);
 #endif
 
 #ifdef NO_STRCASESTR
 #define strcasestr gitstrcasestr
-extern char *gitstrcasestr(const char *haystack, const char *needle);
+char *gitstrcasestr(const char *haystack, const char *needle);
 #endif
 
 #ifdef NO_STRLCPY
 #define strlcpy gitstrlcpy
-extern size_t gitstrlcpy(char *, const char *, size_t);
+size_t gitstrlcpy(char *, const char *, size_t);
 #endif
 
 #ifdef NO_STRTOUMAX
 #define strtoumax gitstrtoumax
-extern uintmax_t gitstrtoumax(const char *, char **, int);
+uintmax_t gitstrtoumax(const char *, char **, int);
 #define strtoimax gitstrtoimax
-extern intmax_t gitstrtoimax(const char *, char **, int);
+intmax_t gitstrtoimax(const char *, char **, int);
 #endif
 
 #ifdef NO_HSTRERROR
 #define hstrerror githstrerror
-extern const char *githstrerror(int herror);
+const char *githstrerror(int herror);
 #endif
 
 #ifdef NO_MEMMEM
@@ -761,7 +761,7 @@ char *gitstrdup(const char *s);
 #  endif
 #  define fopen(a,b) git_fopen(a,b)
 # endif
-extern FILE *git_fopen(const char*, const char*);
+FILE *git_fopen(const char*, const char*);
 #endif
 
 #ifdef SNPRINTF_RETURNS_BOGUS
@@ -769,13 +769,13 @@ extern FILE *git_fopen(const char*, const char*);
 #undef snprintf
 #endif
 #define snprintf git_snprintf
-extern int git_snprintf(char *str, size_t maxsize,
+int git_snprintf(char *str, size_t maxsize,
 			const char *format, ...);
 #ifdef vsnprintf
 #undef vsnprintf
 #endif
 #define vsnprintf git_vsnprintf
-extern int git_vsnprintf(char *str, size_t maxsize,
+int git_vsnprintf(char *str, size_t maxsize,
 			 const char *format, va_list ap);
 #endif
 
@@ -805,11 +805,11 @@ const char *inet_ntop(int af, const void *src, char *dst, size_t size);
 
 #ifdef NO_PTHREADS
 #define atexit git_atexit
-extern int git_atexit(void (*handler)(void));
+int git_atexit(void (*handler)(void));
 #endif
 
 typedef void (*try_to_free_t)(size_t);
-extern try_to_free_t set_try_to_free_routine(try_to_free_t);
+try_to_free_t set_try_to_free_routine(try_to_free_t);
 
 static inline size_t st_add(size_t a, size_t b)
 {
@@ -845,28 +845,28 @@ static inline size_t st_sub(size_t a, size_t b)
 # define xalloca(size)      (xmalloc(size))
 # define xalloca_free(p)    (free(p))
 #endif
-extern char *xstrdup(const char *str);
-extern void *xmalloc(size_t size);
-extern void *xmallocz(size_t size);
-extern void *xmallocz_gently(size_t size);
-extern void *xmemdupz(const void *data, size_t len);
-extern char *xstrndup(const char *str, size_t len);
-extern void *xrealloc(void *ptr, size_t size);
-extern void *xcalloc(size_t nmemb, size_t size);
-extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
-extern void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
-extern int xopen(const char *path, int flags, ...);
-extern ssize_t xread(int fd, void *buf, size_t len);
-extern ssize_t xwrite(int fd, const void *buf, size_t len);
-extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
-extern int xdup(int fd);
-extern FILE *xfopen(const char *path, const char *mode);
-extern FILE *xfdopen(int fd, const char *mode);
-extern int xmkstemp(char *temp_filename);
-extern int xmkstemp_mode(char *temp_filename, int mode);
-extern char *xgetcwd(void);
-extern FILE *fopen_for_writing(const char *path);
-extern FILE *fopen_or_warn(const char *path, const char *mode);
+char *xstrdup(const char *str);
+void *xmalloc(size_t size);
+void *xmallocz(size_t size);
+void *xmallocz_gently(size_t size);
+void *xmemdupz(const void *data, size_t len);
+char *xstrndup(const char *str, size_t len);
+void *xrealloc(void *ptr, size_t size);
+void *xcalloc(size_t nmemb, size_t size);
+void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
+int xopen(const char *path, int flags, ...);
+ssize_t xread(int fd, void *buf, size_t len);
+ssize_t xwrite(int fd, const void *buf, size_t len);
+ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
+int xdup(int fd);
+FILE *xfopen(const char *path, const char *mode);
+FILE *xfdopen(int fd, const char *mode);
+int xmkstemp(char *temp_filename);
+int xmkstemp_mode(char *temp_filename, int mode);
+char *xgetcwd(void);
+FILE *fopen_for_writing(const char *path);
+FILE *fopen_or_warn(const char *path, const char *mode);
 
 /*
  * FREE_AND_NULL(ptr) is like free(ptr) followed by ptr = NULL. Note
@@ -966,13 +966,13 @@ static inline size_t xsize_t(off_t len)
 }
 
 __attribute__((format (printf, 3, 4)))
-extern int xsnprintf(char *dst, size_t max, const char *fmt, ...);
+int xsnprintf(char *dst, size_t max, const char *fmt, ...);
 
 #ifndef HOST_NAME_MAX
 #define HOST_NAME_MAX 256
 #endif
 
-extern int xgethostname(char *buf, size_t len);
+int xgethostname(char *buf, size_t len);
 
 /* in ctype.c, for kwset users */
 extern const unsigned char tolower_trans_tbl[256];
@@ -1257,7 +1257,7 @@ static inline int is_missing_file_error(int errno_)
 	return (errno_ == ENOENT || errno_ == ENOTDIR);
 }
 
-extern int cmd_main(int, const char **);
+int cmd_main(int, const char **);
 
 /*
  * Intercept all calls to exit() and route them to trace2 to
@@ -1280,7 +1280,7 @@ int trace2_cmd_exit_fl(const char *file, int line, int code);
  * an annotation, and does nothing in non-leak-checking builds.
  */
 #ifdef SUPPRESS_ANNOTATED_LEAKS
-extern void unleak_memory(const void *ptr, size_t len);
+void unleak_memory(const void *ptr, size_t len);
 #define UNLEAK(var) unleak_memory(&(var), sizeof(var))
 #else
 #define UNLEAK(var) do {} while (0)
diff --git a/grep.h b/grep.h
index fb04893721..1875880f37 100644
--- a/grep.h
+++ b/grep.h
@@ -186,17 +186,17 @@ struct grep_opt {
 	void *output_priv;
 };
 
-extern void init_grep_defaults(struct repository *);
-extern int grep_config(const char *var, const char *value, void *);
-extern void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
+void init_grep_defaults(struct repository *);
+int grep_config(const char *var, const char *value, void *);
+void grep_init(struct grep_opt *, struct repository *repo, const char *prefix);
 void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
-extern void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
-extern void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
-extern void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const char *);
-extern void compile_grep_patterns(struct grep_opt *opt);
-extern void free_grep_patterns(struct grep_opt *opt);
-extern int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size);
+void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
+void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
+void append_header_grep_pattern(struct grep_opt *, enum grep_header_field, const char *);
+void compile_grep_patterns(struct grep_opt *opt);
+void free_grep_patterns(struct grep_opt *opt);
+int grep_buffer(struct grep_opt *opt, char *buf, unsigned long size);
 
 struct grep_source {
 	char *name;
@@ -226,8 +226,8 @@ void grep_source_load_driver(struct grep_source *gs,
 
 int grep_source(struct grep_opt *opt, struct grep_source *gs);
 
-extern struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
-extern int grep_threads_ok(const struct grep_opt *opt);
+struct grep_opt *grep_opt_dup(const struct grep_opt *opt);
+int grep_threads_ok(const struct grep_opt *opt);
 
 /*
  * Mutex used around access to the attributes machinery if
diff --git a/hashmap.h b/hashmap.h
index d375d9cce7..f95593b6cf 100644
--- a/hashmap.h
+++ b/hashmap.h
@@ -104,11 +104,11 @@
  * `memihash_cont` is a variant of `memihash` that allows a computation to be
  * continued with another chunk of data.
  */
-extern unsigned int strhash(const char *buf);
-extern unsigned int strihash(const char *buf);
-extern unsigned int memhash(const void *buf, size_t len);
-extern unsigned int memihash(const void *buf, size_t len);
-extern unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
+unsigned int strhash(const char *buf);
+unsigned int strihash(const char *buf);
+unsigned int memhash(const void *buf, size_t len);
+unsigned int memihash(const void *buf, size_t len);
+unsigned int memihash_cont(unsigned int hash_seed, const void *buf, size_t len);
 
 /*
  * Converts a cryptographic hash (e.g. SHA-1) into an int-sized hash code
@@ -216,7 +216,7 @@ struct hashmap {
  * parameter may be used to preallocate a sufficiently large table and thus
  * prevent expensive resizing. If 0, the table is dynamically resized.
  */
-extern void hashmap_init(struct hashmap *map,
+void hashmap_init(struct hashmap *map,
 			 hashmap_cmp_fn equals_function,
 			 const void *equals_function_data,
 			 size_t initial_size);
@@ -227,7 +227,7 @@ extern void hashmap_init(struct hashmap *map,
  * If `free_entries` is true, each hashmap_entry in the map is freed as well
  * using stdlibs free().
  */
-extern void hashmap_free(struct hashmap *map, int free_entries);
+void hashmap_free(struct hashmap *map, int free_entries);
 
 /* hashmap_entry functions */
 
@@ -284,7 +284,7 @@ static inline unsigned int hashmap_get_size(struct hashmap *map)
  * If an entry with matching hash code is found, `key` and `keydata` are passed
  * to `hashmap_cmp_fn` to decide whether the entry matches the key.
  */
-extern void *hashmap_get(const struct hashmap *map, const void *key,
+void *hashmap_get(const struct hashmap *map, const void *key,
 			 const void *keydata);
 
 /*
@@ -316,7 +316,7 @@ static inline void *hashmap_get_from_hash(const struct hashmap *map,
  * `entry` is the hashmap_entry to start the search from, obtained via a previous
  * call to `hashmap_get` or `hashmap_get_next`.
  */
-extern void *hashmap_get_next(const struct hashmap *map, const void *entry);
+void *hashmap_get_next(const struct hashmap *map, const void *entry);
 
 /*
  * Adds a hashmap entry. This allows to add duplicate entries (i.e.
@@ -325,7 +325,7 @@ extern void *hashmap_get_next(const struct hashmap *map, const void *entry);
  * `map` is the hashmap structure.
  * `entry` is the entry to add.
  */
-extern void hashmap_add(struct hashmap *map, void *entry);
+void hashmap_add(struct hashmap *map, void *entry);
 
 /*
  * Adds or replaces a hashmap entry. If the hashmap contains duplicate
@@ -335,7 +335,7 @@ extern void hashmap_add(struct hashmap *map, void *entry);
  * `entry` is the entry to add or replace.
  * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
  */
-extern void *hashmap_put(struct hashmap *map, void *entry);
+void *hashmap_put(struct hashmap *map, void *entry);
 
 /*
  * Removes a hashmap entry matching the specified key. If the hashmap contains
@@ -344,7 +344,7 @@ extern void *hashmap_put(struct hashmap *map, void *entry);
  *
  * Argument explanation is the same as in `hashmap_get`.
  */
-extern void *hashmap_remove(struct hashmap *map, const void *key,
+void *hashmap_remove(struct hashmap *map, const void *key,
 		const void *keydata);
 
 /*
@@ -365,10 +365,10 @@ struct hashmap_iter {
 };
 
 /* Initializes a `hashmap_iter` structure. */
-extern void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
+void hashmap_iter_init(struct hashmap *map, struct hashmap_iter *iter);
 
 /* Returns the next hashmap_entry, or NULL if there are no more entries. */
-extern void *hashmap_iter_next(struct hashmap_iter *iter);
+void *hashmap_iter_next(struct hashmap_iter *iter);
 
 /* Initializes the iterator and returns the first entry, if any. */
 static inline void *hashmap_iter_first(struct hashmap *map,
@@ -429,7 +429,7 @@ static inline void hashmap_enable_item_counting(struct hashmap *map)
  *
  * Uses a hashmap to store the pool of interned strings.
  */
-extern const void *memintern(const void *data, size_t len);
+const void *memintern(const void *data, size_t len);
 static inline const char *strintern(const char *string)
 {
 	return memintern(string, strlen(string));
diff --git a/help.h b/help.h
index a141e209ae..ca004a7a7d 100644
--- a/help.h
+++ b/help.h
@@ -19,31 +19,31 @@ static inline void mput_char(char c, unsigned int num)
 		putchar(c);
 }
 
-extern void list_common_cmds_help(void);
-extern void list_all_cmds_help(void);
-extern void list_common_guides_help(void);
-extern void list_config_help(int for_human);
+void list_common_cmds_help(void);
+void list_all_cmds_help(void);
+void list_common_guides_help(void);
+void list_config_help(int for_human);
 
-extern void list_all_main_cmds(struct string_list *list);
-extern void list_all_other_cmds(struct string_list *list);
-extern void list_cmds_by_category(struct string_list *list,
+void list_all_main_cmds(struct string_list *list);
+void list_all_other_cmds(struct string_list *list);
+void list_cmds_by_category(struct string_list *list,
 				  const char *category);
-extern void list_cmds_by_config(struct string_list *list);
-extern const char *help_unknown_cmd(const char *cmd);
-extern void load_command_list(const char *prefix,
+void list_cmds_by_config(struct string_list *list);
+const char *help_unknown_cmd(const char *cmd);
+void load_command_list(const char *prefix,
 			      struct cmdnames *main_cmds,
 			      struct cmdnames *other_cmds);
-extern void add_cmdname(struct cmdnames *cmds, const char *name, int len);
+void add_cmdname(struct cmdnames *cmds, const char *name, int len);
 /* Here we require that excludes is a sorted list. */
-extern void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
-extern int is_in_cmdlist(struct cmdnames *cmds, const char *name);
-extern void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
+void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes);
+int is_in_cmdlist(struct cmdnames *cmds, const char *name);
+void list_commands(unsigned int colopts, struct cmdnames *main_cmds, struct cmdnames *other_cmds);
 
 /*
  * call this to die(), when it is suspected that the user mistyped a
  * ref to the command, to give suggested "correct" refs.
  */
-extern void help_unknown_ref(const char *ref, const char *cmd, const char *error);
+void help_unknown_ref(const char *ref, const char *cmd, const char *error);
 
 static inline void list_config_item(struct string_list *list,
 				    const char *prefix,
diff --git a/http.h b/http.h
index 4eb4e808e5..f9e3be5b92 100644
--- a/http.h
+++ b/http.h
@@ -75,18 +75,18 @@ struct buffer {
 };
 
 /* Curl request read/write callbacks */
-extern size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-extern size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
-extern size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+size_t fwrite_buffer(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
+size_t fwrite_null(char *ptr, size_t eltsize, size_t nmemb, void *strbuf);
 #ifndef NO_CURL_IOCTL
-extern curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
+curlioerr ioctl_buffer(CURL *handle, int cmd, void *clientp);
 #endif
 
 /* Slot lifecycle functions */
-extern struct active_request_slot *get_active_slot(void);
-extern int start_active_slot(struct active_request_slot *slot);
-extern void run_active_slot(struct active_request_slot *slot);
-extern void finish_all_active_slots(void);
+struct active_request_slot *get_active_slot(void);
+int start_active_slot(struct active_request_slot *slot);
+void run_active_slot(struct active_request_slot *slot);
+void finish_all_active_slots(void);
 
 /*
  * This will run one slot to completion in a blocking manner, similar to how
@@ -98,15 +98,15 @@ int run_one_slot(struct active_request_slot *slot,
 		 struct slot_results *results);
 
 #ifdef USE_CURL_MULTI
-extern void fill_active_slots(void);
-extern void add_fill_function(void *data, int (*fill)(void *));
-extern void step_active_slots(void);
+void fill_active_slots(void);
+void add_fill_function(void *data, int (*fill)(void *));
+void step_active_slots(void);
 #endif
 
-extern void http_init(struct remote *remote, const char *url,
+void http_init(struct remote *remote, const char *url,
 		      int proactive_auth);
-extern void http_cleanup(void);
-extern struct curl_slist *http_copy_default_headers(void);
+void http_cleanup(void);
+struct curl_slist *http_copy_default_headers(void);
 
 extern long int git_curl_ipresolve;
 extern int active_requests;
@@ -137,10 +137,10 @@ static inline int missing__target(int code, int result)
 #define missing_target(a) missing__target((a)->http_code, (a)->curl_result)
 
 /* Helpers for modifying and creating URLs */
-extern void append_remote_object_url(struct strbuf *buf, const char *url,
+void append_remote_object_url(struct strbuf *buf, const char *url,
 				     const char *hex,
 				     int only_two_digit_prefix);
-extern char *get_remote_object_url(const char *url, const char *hex,
+char *get_remote_object_url(const char *url, const char *hex,
 				   int only_two_digit_prefix);
 
 /* Options for http_get_*() */
@@ -195,10 +195,10 @@ struct http_get_options {
  */
 int http_get_strbuf(const char *url, struct strbuf *result, struct http_get_options *options);
 
-extern int http_fetch_ref(const char *base, struct ref *ref);
+int http_fetch_ref(const char *base, struct ref *ref);
 
 /* Helpers for fetching packs */
-extern int http_get_info_packs(const char *base_url,
+int http_get_info_packs(const char *base_url,
 	struct packed_git **packs_head);
 
 struct http_pack_request {
@@ -210,10 +210,10 @@ struct http_pack_request {
 	struct active_request_slot *slot;
 };
 
-extern struct http_pack_request *new_http_pack_request(
+struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url);
-extern int finish_http_pack_request(struct http_pack_request *preq);
-extern void release_http_pack_request(struct http_pack_request *preq);
+int finish_http_pack_request(struct http_pack_request *preq);
+void release_http_pack_request(struct http_pack_request *preq);
 
 /* Helpers for fetching object */
 struct http_object_request {
@@ -232,12 +232,12 @@ struct http_object_request {
 	struct active_request_slot *slot;
 };
 
-extern struct http_object_request *new_http_object_request(
+struct http_object_request *new_http_object_request(
 	const char *base_url, const struct object_id *oid);
-extern void process_http_object_request(struct http_object_request *freq);
-extern int finish_http_object_request(struct http_object_request *freq);
-extern void abort_http_object_request(struct http_object_request *freq);
-extern void release_http_object_request(struct http_object_request *freq);
+void process_http_object_request(struct http_object_request *freq);
+int finish_http_object_request(struct http_object_request *freq);
+void abort_http_object_request(struct http_object_request *freq);
+void release_http_object_request(struct http_object_request *freq);
 
 /* setup routine for curl_easy_setopt CURLOPT_DEBUGFUNCTION */
 void setup_curl_trace(CURL *handle);
diff --git a/khash.h b/khash.h
index 532109c87f..3d25667a82 100644
--- a/khash.h
+++ b/khash.h
@@ -70,13 +70,13 @@ static const double __ac_HASH_UPPER = 0.77;
 	} kh_##name##_t;
 
 #define __KHASH_PROTOTYPES(name, khkey_t, khval_t)	 					\
-	extern kh_##name##_t *kh_init_##name(void);							\
-	extern void kh_destroy_##name(kh_##name##_t *h);					\
-	extern void kh_clear_##name(kh_##name##_t *h);						\
-	extern khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); 	\
-	extern int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
-	extern khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
-	extern void kh_del_##name(kh_##name##_t *h, khint_t x);
+	kh_##name##_t *kh_init_##name(void);							\
+	void kh_destroy_##name(kh_##name##_t *h);					\
+	void kh_clear_##name(kh_##name##_t *h);						\
+	khint_t kh_get_##name(const kh_##name##_t *h, khkey_t key); 	\
+	int kh_resize_##name(kh_##name##_t *h, khint_t new_n_buckets); \
+	khint_t kh_put_##name(kh_##name##_t *h, khkey_t key, int *ret); \
+	void kh_del_##name(kh_##name##_t *h, khint_t x);
 
 #define __KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_func, __hash_equal) \
 	SCOPE kh_##name##_t *kh_init_##name(void) {							\
diff --git a/kwset.h b/kwset.h
index 583f6268ef..df99a92178 100644
--- a/kwset.h
+++ b/kwset.h
@@ -37,16 +37,16 @@ typedef struct kwset_t* kwset_t;
    if enough memory cannot be obtained.  The argument if non-NULL
    specifies a table of character translations to be applied to all
    pattern and search text. */
-extern kwset_t kwsalloc(unsigned char const *);
+kwset_t kwsalloc(unsigned char const *);
 
 /* Incrementally extend the keyword set to include the given string.
    Return NULL for success, or an error message.  Remember an index
    number for each keyword included in the set. */
-extern const char *kwsincr(kwset_t, char const *, size_t);
+const char *kwsincr(kwset_t, char const *, size_t);
 
 /* When the keyword set has been completely built, prepare it for
    use.  Return NULL for success, or an error message. */
-extern const char *kwsprep(kwset_t);
+const char *kwsprep(kwset_t);
 
 /* Search through the given buffer for a member of the keyword set.
    Return a pointer to the leftmost longest match found, or NULL if
@@ -54,8 +54,8 @@ extern const char *kwsprep(kwset_t);
    the matching substring in the integer it points to.  Similarly,
    if foundindex is non-NULL, store the index of the particular
    keyword found therein. */
-extern size_t kwsexec(kwset_t, char const *, size_t, struct kwsmatch *);
+size_t kwsexec(kwset_t, char const *, size_t, struct kwsmatch *);
 
 /* Deallocate the given keyword set and all its associated storage. */
-extern void kwsfree(kwset_t);
+void kwsfree(kwset_t);
 
diff --git a/line-log.h b/line-log.h
index e2a5ee7c6d..8ee7a2bd4a 100644
--- a/line-log.h
+++ b/line-log.h
@@ -25,17 +25,17 @@ struct diff_ranges {
 	struct range_set target;
 };
 
-extern void range_set_init(struct range_set *, size_t prealloc);
-extern void range_set_release(struct range_set *);
+void range_set_init(struct range_set *, size_t prealloc);
+void range_set_release(struct range_set *);
 /* Range includes start; excludes end */
-extern void range_set_append_unsafe(struct range_set *, long start, long end);
+void range_set_append_unsafe(struct range_set *, long start, long end);
 /* New range must begin at or after end of last added range */
-extern void range_set_append(struct range_set *, long start, long end);
+void range_set_append(struct range_set *, long start, long end);
 /*
  * In-place pass of sorting and merging the ranges in the range set,
  * to sort and make the ranges disjoint.
  */
-extern void sort_and_merge_range_set(struct range_set *);
+void sort_and_merge_range_set(struct range_set *);
 
 /* Linked list of interesting files and their associated ranges.  The
  * list must be kept sorted by path.
@@ -54,10 +54,10 @@ struct line_log_data {
 	struct diff_ranges diff;
 };
 
-extern void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args);
+void line_log_init(struct rev_info *rev, const char *prefix, struct string_list *args);
 
-extern int line_log_filter(struct rev_info *rev);
+int line_log_filter(struct rev_info *rev);
 
-extern int line_log_print(struct rev_info *rev, struct commit *commit);
+int line_log_print(struct rev_info *rev, struct commit *commit);
 
 #endif /* LINE_LOG_H */
diff --git a/lockfile.h b/lockfile.h
index 35403ccc0d..c81983a925 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -159,7 +159,7 @@ struct lock_file {
  * timeout_ms is -1, retry indefinitely. The flags argument and error
  * handling are described above.
  */
-extern int hold_lock_file_for_update_timeout(
+int hold_lock_file_for_update_timeout(
 		struct lock_file *lk, const char *path,
 		int flags, long timeout_ms);
 
@@ -188,7 +188,7 @@ static inline int is_lock_file_locked(struct lock_file *lk)
  * of `hold_lock_file_for_update()` to lock `path`. `err` should be the
  * `errno` set by the failing call.
  */
-extern void unable_to_lock_message(const char *path, int err,
+void unable_to_lock_message(const char *path, int err,
 				   struct strbuf *buf);
 
 /*
@@ -197,7 +197,7 @@ extern void unable_to_lock_message(const char *path, int err,
  * `errno` set by the failing
  * call.
  */
-extern NORETURN void unable_to_lock_die(const char *path, int err);
+NORETURN void unable_to_lock_die(const char *path, int err);
 
 /*
  * Associate a stdio stream with the lockfile (which must still be
@@ -234,7 +234,7 @@ static inline FILE *get_lock_file_fp(struct lock_file *lk)
  * Return the path of the file that is locked by the specified
  * lock_file object. The caller must free the memory.
  */
-extern char *get_locked_file_path(struct lock_file *lk);
+char *get_locked_file_path(struct lock_file *lk);
 
 /*
  * If the lockfile is still open, close it (and the file pointer if it
@@ -282,7 +282,7 @@ static inline int reopen_lock_file(struct lock_file *lk)
  * call `commit_lock_file()` for a `lock_file` object that is not
  * currently locked.
  */
-extern int commit_lock_file(struct lock_file *lk);
+int commit_lock_file(struct lock_file *lk);
 
 /*
  * Like `commit_lock_file()`, but rename the lockfile to the provided
diff --git a/ls-refs.h b/ls-refs.h
index b62877e8da..702d47ad70 100644
--- a/ls-refs.h
+++ b/ls-refs.h
@@ -4,7 +4,7 @@
 struct repository;
 struct argv_array;
 struct packet_reader;
-extern int ls_refs(struct repository *r, struct argv_array *keys,
+int ls_refs(struct repository *r, struct argv_array *keys,
 		   struct packet_reader *request);
 
 #endif /* LS_REFS_H */
diff --git a/mailinfo.h b/mailinfo.h
index 6830e1e625..79b1d6774e 100644
--- a/mailinfo.h
+++ b/mailinfo.h
@@ -39,8 +39,8 @@ struct mailinfo {
 	int input_error;
 };
 
-extern void setup_mailinfo(struct mailinfo *);
-extern int mailinfo(struct mailinfo *, const char *msg, const char *patch);
-extern void clear_mailinfo(struct mailinfo *);
+void setup_mailinfo(struct mailinfo *);
+int mailinfo(struct mailinfo *, const char *msg, const char *patch);
+void clear_mailinfo(struct mailinfo *);
 
 #endif /* MAILINFO_H */
diff --git a/merge-blobs.h b/merge-blobs.h
index cc31038b80..863a7e0807 100644
--- a/merge-blobs.h
+++ b/merge-blobs.h
@@ -4,7 +4,7 @@
 struct blob;
 struct index_state;
 
-extern void *merge_blobs(struct index_state *, const char *,
+void *merge_blobs(struct index_state *, const char *,
 			 struct blob *, struct blob *,
 			 struct blob *, unsigned long *);
 
diff --git a/object-store.h b/object-store.h
index 14fc935bd1..9700d1aca7 100644
--- a/object-store.h
+++ b/object-store.h
@@ -162,7 +162,7 @@ const char *loose_object_path(struct repository *r, struct strbuf *buf,
 void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);
 
-extern void *read_object_file_extended(struct repository *r,
+void *read_object_file_extended(struct repository *r,
 				       const struct object_id *oid,
 				       enum object_type *type,
 				       unsigned long *size, int lookup_replace);
@@ -180,20 +180,20 @@ static inline void *repo_read_object_file(struct repository *r,
 /* Read and unpack an object file into memory, write memory to an object file */
 int oid_object_info(struct repository *r, const struct object_id *, unsigned long *);
 
-extern int hash_object_file(const void *buf, unsigned long len,
+int hash_object_file(const void *buf, unsigned long len,
 			    const char *type, struct object_id *oid);
 
-extern int write_object_file(const void *buf, unsigned long len,
+int write_object_file(const void *buf, unsigned long len,
 			     const char *type, struct object_id *oid);
 
-extern int hash_object_file_literally(const void *buf, unsigned long len,
+int hash_object_file_literally(const void *buf, unsigned long len,
 				      const char *type, struct object_id *oid,
 				      unsigned flags);
 
-extern int pretend_object_file(void *, unsigned long, enum object_type,
+int pretend_object_file(void *, unsigned long, enum object_type,
 			       struct object_id *oid);
 
-extern int force_object_loose(const struct object_id *oid, time_t mtime);
+int force_object_loose(const struct object_id *oid, time_t mtime);
 
 /*
  * Open the loose object at path, check its hash, and return the contents,
@@ -227,9 +227,9 @@ int repo_has_object_file_with_flags(struct repository *r,
  * with the specified name.  This function does not respect replace
  * references.
  */
-extern int has_loose_object_nonlocal(const struct object_id *);
+int has_loose_object_nonlocal(const struct object_id *);
 
-extern void assert_oid_type(const struct object_id *oid, enum object_type expect);
+void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 struct object_info {
 	/* Request */
diff --git a/object.h b/object.h
index 796792cb32..4526979ccf 100644
--- a/object.h
+++ b/object.h
@@ -90,19 +90,19 @@ struct object {
 	struct object_id oid;
 };
 
-extern const char *type_name(unsigned int type);
-extern int type_from_string_gently(const char *str, ssize_t, int gentle);
+const char *type_name(unsigned int type);
+int type_from_string_gently(const char *str, ssize_t, int gentle);
 #define type_from_string(str) type_from_string_gently(str, -1, 0)
 
 /*
  * Return the current number of buckets in the object hashmap.
  */
-extern unsigned int get_max_object_index(void);
+unsigned int get_max_object_index(void);
 
 /*
  * Return the object from the specified bucket in the object hashmap.
  */
-extern struct object *get_indexed_object(unsigned int);
+struct object *get_indexed_object(unsigned int);
 
 /*
  * This can be used to see if we have heard of the object before, but
@@ -118,7 +118,7 @@ extern struct object *get_indexed_object(unsigned int);
  */
 struct object *lookup_object(struct repository *r, const unsigned char *sha1);
 
-extern void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
+void *create_object(struct repository *r, const unsigned char *sha1, void *obj);
 
 void *object_as_type(struct repository *r, struct object *obj, enum object_type type, int quiet);
 
@@ -189,6 +189,6 @@ void clear_object_flags(unsigned flags);
 /*
  * Clear the specified object flags from all in-core commit objects.
  */
-extern void clear_commit_marks_all(unsigned int flags);
+void clear_commit_marks_all(unsigned int flags);
 
 #endif /* OBJECT_H */
diff --git a/oidmap.h b/oidmap.h
index 72430b611e..91b2ed0f51 100644
--- a/oidmap.h
+++ b/oidmap.h
@@ -33,7 +33,7 @@ struct oidmap {
  * parameter may be used to preallocate a sufficiently large table and thus
  * prevent expensive resizing. If 0, the table is dynamically resized.
  */
-extern void oidmap_init(struct oidmap *map, size_t initial_size);
+void oidmap_init(struct oidmap *map, size_t initial_size);
 
 /*
  * Frees an oidmap structure and allocated memory.
@@ -41,12 +41,12 @@ extern void oidmap_init(struct oidmap *map, size_t initial_size);
  * If `free_entries` is true, each oidmap_entry in the map is freed as well
  * using stdlibs free().
  */
-extern void oidmap_free(struct oidmap *map, int free_entries);
+void oidmap_free(struct oidmap *map, int free_entries);
 
 /*
  * Returns the oidmap entry for the specified oid, or NULL if not found.
  */
-extern void *oidmap_get(const struct oidmap *map,
+void *oidmap_get(const struct oidmap *map,
 			const struct object_id *key);
 
 /*
@@ -57,14 +57,14 @@ extern void *oidmap_get(const struct oidmap *map,
  *
  * Returns the replaced entry, or NULL if not found (i.e. the entry was added).
  */
-extern void *oidmap_put(struct oidmap *map, void *entry);
+void *oidmap_put(struct oidmap *map, void *entry);
 
 /*
  * Removes an oidmap entry matching the specified oid.
  *
  * Returns the removed entry, or NULL if not found.
  */
-extern void *oidmap_remove(struct oidmap *map, const struct object_id *key);
+void *oidmap_remove(struct oidmap *map, const struct object_id *key);
 
 
 struct oidmap_iter {
diff --git a/pack.h b/pack.h
index da99fdd1d2..de941858c5 100644
--- a/pack.h
+++ b/pack.h
@@ -55,7 +55,7 @@ struct pack_idx_option {
 	uint32_t *anomaly;
 };
 
-extern void reset_pack_idx_option(struct pack_idx_option *);
+void reset_pack_idx_option(struct pack_idx_option *);
 
 /*
  * Packed object index header
@@ -79,28 +79,28 @@ struct progress;
 /* Note, the data argument could be NULL if object type is blob */
 typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned long, void*, int*);
 
-extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
-extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
-extern int verify_pack_index(struct packed_git *);
-extern int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
-extern off_t write_pack_header(struct hashfile *f, uint32_t);
-extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
-extern char *index_pack_lockfile(int fd);
+const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
+int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
+int verify_pack_index(struct packed_git *);
+int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
+off_t write_pack_header(struct hashfile *f, uint32_t);
+void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
+char *index_pack_lockfile(int fd);
 
 /*
  * The "hdr" output buffer should be at least this big, which will handle sizes
  * up to 2^67.
  */
 #define MAX_PACK_OBJECT_HEADER 10
-extern int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
+int encode_in_pack_object_header(unsigned char *hdr, int hdr_len,
 					enum object_type, uintmax_t);
 
 #define PH_ERROR_EOF		(-1)
 #define PH_ERROR_PACK_SIGNATURE	(-2)
 #define PH_ERROR_PROTOCOL	(-3)
-extern int read_pack_header(int fd, struct pack_header *);
+int read_pack_header(int fd, struct pack_header *);
 
-extern struct hashfile *create_tmp_packfile(char **pack_tmp_name);
-extern void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
+struct hashfile *create_tmp_packfile(char **pack_tmp_name);
+void finish_tmp_packfile(struct strbuf *name_buffer, const char *pack_tmp_name, struct pack_idx_entry **written_list, uint32_t nr_written, struct pack_idx_option *pack_idx_opts, unsigned char sha1[]);
 
 #endif
diff --git a/packfile.h b/packfile.h
index d70c6d9afb..dab50405e0 100644
--- a/packfile.h
+++ b/packfile.h
@@ -15,23 +15,23 @@ struct object_info;
  *
  * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
  */
-extern char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
+char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
 
 /*
  * Return the name of the (local) packfile with the specified sha1 in
  * its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-extern char *sha1_pack_name(const unsigned char *sha1);
+char *sha1_pack_name(const unsigned char *sha1);
 
 /*
  * Return the name of the (local) pack index file with the specified
  * sha1 in its name.  The return value is a pointer to memory that is
  * overwritten each time this function is called.
  */
-extern char *sha1_pack_index_name(const unsigned char *sha1);
+char *sha1_pack_index_name(const unsigned char *sha1);
 
-extern struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
+struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
 
 typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
 				      const char *file_pach, void *data);
@@ -43,10 +43,10 @@ void for_each_file_in_pack_dir(const char *objdir,
 #define PACKDIR_FILE_PACK 1
 #define PACKDIR_FILE_IDX 2
 #define PACKDIR_FILE_GARBAGE 4
-extern void (*report_garbage)(unsigned seen_bits, const char *path);
+void (*report_garbage)(unsigned seen_bits, const char *path);
 
-extern void reprepare_packed_git(struct repository *r);
-extern void install_packed_git(struct repository *r, struct packed_git *pack);
+void reprepare_packed_git(struct repository *r);
+void install_packed_git(struct repository *r, struct packed_git *pack);
 
 struct packed_git *get_packed_git(struct repository *r);
 struct list_head *get_packed_git_mru(struct repository *r);
@@ -59,32 +59,32 @@ struct packed_git *get_all_packs(struct repository *r);
  */
 unsigned long approximate_object_count(void);
 
-extern struct packed_git *find_sha1_pack(const unsigned char *sha1,
+struct packed_git *find_sha1_pack(const unsigned char *sha1,
 					 struct packed_git *packs);
 
-extern void pack_report(void);
+void pack_report(void);
 
 /*
  * mmap the index file for the specified packfile (if it is not
  * already mmapped).  Return 0 on success.
  */
-extern int open_pack_index(struct packed_git *);
+int open_pack_index(struct packed_git *);
 
 /*
  * munmap the index file for the specified packfile (if it is
  * currently mmapped).
  */
-extern void close_pack_index(struct packed_git *);
+void close_pack_index(struct packed_git *);
 
-extern uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
+uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
 
-extern unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
-extern void close_pack_windows(struct packed_git *);
-extern void close_pack(struct packed_git *);
-extern void close_all_packs(struct raw_object_store *o);
-extern void unuse_pack(struct pack_window **);
-extern void clear_delta_base_cache(void);
-extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
+unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
+void close_pack_windows(struct packed_git *);
+void close_pack(struct packed_git *);
+void close_all_packs(struct raw_object_store *o);
+void unuse_pack(struct pack_window **);
+void clear_delta_base_cache(void);
+struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
 
 /*
  * Make sure that a pointer access into an mmap'd index file is within bounds,
@@ -94,7 +94,7 @@ extern struct packed_git *add_packed_git(const char *path, size_t path_len, int
  * (like the 64-bit extended offset table), as we compare the size to the
  * fixed-length parts when we open the file.
  */
-extern void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
+void check_pack_index_ptr(const struct packed_git *p, const void *ptr);
 
 /*
  * Perform binary search on a pack-index for a given oid. Packfile is expected to
@@ -110,59 +110,59 @@ int bsearch_pack(const struct object_id *oid, const struct packed_git *p, uint32
  * at the SHA-1 within the mmapped index.  Return NULL if there is an
  * error.
  */
-extern const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
+const unsigned char *nth_packed_object_sha1(struct packed_git *, uint32_t n);
 /*
  * Like nth_packed_object_sha1, but write the data into the object specified by
  * the the first argument.  Returns the first argument on success, and NULL on
  * error.
  */
-extern const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
+const struct object_id *nth_packed_object_oid(struct object_id *, struct packed_git *, uint32_t n);
 
 /*
  * Return the offset of the nth object within the specified packfile.
  * The index must already be opened.
  */
-extern off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
+off_t nth_packed_object_offset(const struct packed_git *, uint32_t n);
 
 /*
  * If the object named sha1 is present in the specified packfile,
  * return its offset within the packfile; otherwise, return 0.
  */
-extern off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
+off_t find_pack_entry_one(const unsigned char *sha1, struct packed_git *);
 
-extern int is_pack_valid(struct packed_git *);
-extern void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
-extern unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
-extern unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
-extern int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
+int is_pack_valid(struct packed_git *);
+void *unpack_entry(struct repository *r, struct packed_git *, off_t, enum object_type *, unsigned long *);
+unsigned long unpack_object_header_buffer(const unsigned char *buf, unsigned long len, enum object_type *type, unsigned long *sizep);
+unsigned long get_size_from_delta(struct packed_git *, struct pack_window **, off_t);
+int unpack_object_header(struct packed_git *, struct pack_window **, off_t *, unsigned long *);
 
-extern void release_pack_memory(size_t);
+void release_pack_memory(size_t);
 
 /* global flag to enable extra checks when accessing packed objects */
 extern int do_check_packed_object_crc;
 
-extern int packed_object_info(struct repository *r,
+int packed_object_info(struct repository *r,
 			      struct packed_git *pack,
 			      off_t offset, struct object_info *);
 
-extern void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
-extern const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
+void mark_bad_packed_object(struct packed_git *p, const unsigned char *sha1);
+const struct packed_git *has_packed_and_bad(struct repository *r, const unsigned char *sha1);
 
 /*
  * Iff a pack file in the given repository contains the object named by sha1,
  * return true and store its location to e.
  */
-extern int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
+int find_pack_entry(struct repository *r, const struct object_id *oid, struct pack_entry *e);
 
-extern int has_object_pack(const struct object_id *oid);
+int has_object_pack(const struct object_id *oid);
 
-extern int has_pack_index(const unsigned char *sha1);
+int has_pack_index(const unsigned char *sha1);
 
 /*
  * Return 1 if an object in a promisor packfile is or refers to the given
  * object, 0 otherwise.
  */
-extern int is_promisor_object(const struct object_id *oid);
+int is_promisor_object(const struct object_id *oid);
 
 /*
  * Expose a function for fuzz testing.
@@ -174,7 +174,7 @@ extern int is_promisor_object(const struct object_id *oid);
  * have a convenient entry-point for fuzz testing. For real uses, you should
  * probably use open_pack_index() or parse_pack_index() instead.
  */
-extern int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
+int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
 		    size_t idx_size, struct packed_git *p);
 
 #endif
diff --git a/path.h b/path.h
index 651e6157fc..0efbd4fb0d 100644
--- a/path.h
+++ b/path.h
@@ -13,19 +13,19 @@ struct strbuf;
 /*
  * Return a statically allocated path.
  */
-extern const char *mkpath(const char *fmt, ...)
+const char *mkpath(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
  * Return a path.
  */
-extern char *mkpathdup(const char *fmt, ...)
+char *mkpathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
  * Construct a path and place the result in the provided buffer `buf`.
  */
-extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
+char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
 /*
@@ -37,7 +37,7 @@ extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
  * Constructs a path into the common git directory of repository `repo` and
  * append it in the provided buffer `sb`.
  */
-extern void strbuf_git_common_path(struct strbuf *sb,
+void strbuf_git_common_path(struct strbuf *sb,
 				   const struct repository *repo,
 				   const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
@@ -46,7 +46,7 @@ extern void strbuf_git_common_path(struct strbuf *sb,
  * Return a statically allocated path into the main repository's
  * (the_repository) common git directory.
  */
-extern const char *git_common_path(const char *fmt, ...)
+const char *git_common_path(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 
@@ -66,7 +66,7 @@ extern const char *git_common_path(const char *fmt, ...)
 /*
  * Return a path into the git directory of repository `repo`.
  */
-extern char *repo_git_path(const struct repository *repo,
+char *repo_git_path(const struct repository *repo,
 			   const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
@@ -74,7 +74,7 @@ extern char *repo_git_path(const struct repository *repo,
  * Construct a path into the git directory of repository `repo` and append it
  * to the provided buffer `sb`.
  */
-extern void strbuf_repo_git_path(struct strbuf *sb,
+void strbuf_repo_git_path(struct strbuf *sb,
 				 const struct repository *repo,
 				 const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
@@ -83,13 +83,13 @@ extern void strbuf_repo_git_path(struct strbuf *sb,
  * Return a statically allocated path into the main repository's
  * (the_repository) git directory.
  */
-extern const char *git_path(const char *fmt, ...)
+const char *git_path(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
  * Return a path into the main repository's (the_repository) git directory.
  */
-extern char *git_pathdup(const char *fmt, ...)
+char *git_pathdup(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
 
 /*
@@ -97,14 +97,14 @@ extern char *git_pathdup(const char *fmt, ...)
  * and place it in the provided buffer `buf`, the contents of the buffer will
  * be overridden.
  */
-extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
+char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
 /*
  * Construct a path into the main repository's (the_repository) git directory
  * and append it to the provided buffer `sb`.
  */
-extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
+void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
 /*
@@ -112,7 +112,7 @@ extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
  *
  * If the repository doesn't have a worktree NULL is returned.
  */
-extern char *repo_worktree_path(const struct repository *repo,
+char *repo_worktree_path(const struct repository *repo,
 				const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
@@ -122,7 +122,7 @@ extern char *repo_worktree_path(const struct repository *repo,
  *
  * If the repository doesn't have a worktree nothing will be appended to `sb`.
  */
-extern void strbuf_repo_worktree_path(struct strbuf *sb,
+void strbuf_repo_worktree_path(struct strbuf *sb,
 				      const struct repository *repo,
 				      const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
@@ -131,7 +131,7 @@ extern void strbuf_repo_worktree_path(struct strbuf *sb,
  * Return a path into a submodule's git directory located at `path`.  `path`
  * must only reference a submodule of the main repository (the_repository).
  */
-extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
+char *git_pathdup_submodule(const char *path, const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
 /*
@@ -139,11 +139,11 @@ extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
  * append it to the provided buffer `sb`.  `path` must only reference a
  * submodule of the main repository (the_repository).
  */
-extern int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
+int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
-extern void report_linked_checkout_garbage(void);
+void report_linked_checkout_garbage(void);
 
 /*
  * You can define a static memoized git path like:
diff --git a/pkt-line.h b/pkt-line.h
index c36cb788ed..1ebeaff236 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -172,7 +172,7 @@ struct packet_reader {
  * Initialize a 'struct packet_reader' object which is an
  * abstraction around the 'packet_read_with_status()' function.
  */
-extern void packet_reader_init(struct packet_reader *reader, int fd,
+void packet_reader_init(struct packet_reader *reader, int fd,
 			       char *src_buffer, size_t src_len,
 			       int options);
 
@@ -186,7 +186,7 @@ extern void packet_reader_init(struct packet_reader *reader, int fd,
  *		       'line' is set to point at the read line
  * PACKET_READ_FLUSH: 'pktlen' is set to '0' and 'line' is set to NULL
  */
-extern enum packet_read_status packet_reader_read(struct packet_reader *reader);
+enum packet_read_status packet_reader_read(struct packet_reader *reader);
 
 /*
  * Peek the next packet line without consuming it and return the status.
@@ -196,7 +196,7 @@ extern enum packet_read_status packet_reader_read(struct packet_reader *reader);
  * Peeking multiple times without calling 'packet_reader_read()' will return
  * the same result.
  */
-extern enum packet_read_status packet_reader_peek(struct packet_reader *reader);
+enum packet_read_status packet_reader_peek(struct packet_reader *reader);
 
 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
diff --git a/prio-queue.h b/prio-queue.h
index 682e51867a..4f9a37e6be 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -37,24 +37,24 @@ struct prio_queue {
 /*
  * Add the "thing" to the queue.
  */
-extern void prio_queue_put(struct prio_queue *, void *thing);
+void prio_queue_put(struct prio_queue *, void *thing);
 
 /*
  * Extract the "thing" that compares the smallest out of the queue,
  * or NULL.  If compare function is NULL, the queue acts as a LIFO
  * stack.
  */
-extern void *prio_queue_get(struct prio_queue *);
+void *prio_queue_get(struct prio_queue *);
 
 /*
  * Gain access to the "thing" that would be returned by
  * prio_queue_get, but do not remove it from the queue.
  */
-extern void *prio_queue_peek(struct prio_queue *);
+void *prio_queue_peek(struct prio_queue *);
 
-extern void clear_prio_queue(struct prio_queue *);
+void clear_prio_queue(struct prio_queue *);
 
 /* Reverse the LIFO elements */
-extern void prio_queue_reverse(struct prio_queue *);
+void prio_queue_reverse(struct prio_queue *);
 
 #endif /* PRIO_QUEUE_H */
diff --git a/protocol.h b/protocol.h
index 2ad35e433c..cef1a4a01c 100644
--- a/protocol.h
+++ b/protocol.h
@@ -14,7 +14,7 @@ enum protocol_version {
  * 'protocol.version' config.  If unconfigured, a value of 'protocol_v0' is
  * returned.
  */
-extern enum protocol_version get_protocol_version_config(void);
+enum protocol_version get_protocol_version_config(void);
 
 /*
  * Used by a server to determine which protocol version should be used based on
@@ -23,12 +23,12 @@ extern enum protocol_version get_protocol_version_config(void);
  * request a particular protocol version, a default of 'protocol_v0' will be
  * used.
  */
-extern enum protocol_version determine_protocol_version_server(void);
+enum protocol_version determine_protocol_version_server(void);
 
 /*
  * Used by a client to determine which protocol version the server is speaking
  * based on the server's initial response.
  */
-extern enum protocol_version determine_protocol_version_client(const char *server_response);
+enum protocol_version determine_protocol_version_client(const char *server_response);
 
 #endif /* PROTOCOL_H */
diff --git a/quote.h b/quote.h
index ea992dcc91..86c0d944b5 100644
--- a/quote.h
+++ b/quote.h
@@ -29,9 +29,9 @@ struct strbuf;
  * sq_quotef() quotes the entire formatted string as a single result.
  */
 
-extern void sq_quote_buf(struct strbuf *, const char *src);
-extern void sq_quote_argv(struct strbuf *, const char **argv);
-extern void sq_quotef(struct strbuf *, const char *fmt, ...);
+void sq_quote_buf(struct strbuf *, const char *src);
+void sq_quote_argv(struct strbuf *, const char **argv);
+void sq_quotef(struct strbuf *, const char *fmt, ...);
 
 /*
  * These match their non-pretty variants, except that they avoid
@@ -45,14 +45,14 @@ void sq_quote_argv_pretty(struct strbuf *, const char **argv);
  * NULL if the input does not look like what sq_quote would have
  * produced.
  */
-extern char *sq_dequote(char *);
+char *sq_dequote(char *);
 
 /*
  * Same as the above, but can be used to unwrap many arguments in the
  * same string separated by space. Like sq_quote, it works in place,
  * modifying arg and appending pointers into it to argv.
  */
-extern int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
+int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
 
 /*
  * Same as above, but store the unquoted strings in an argv_array. We will
@@ -60,24 +60,24 @@ extern int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc
  * will duplicate and take ownership of the strings.
  */
 struct argv_array;
-extern int sq_dequote_to_argv_array(char *arg, struct argv_array *);
+int sq_dequote_to_argv_array(char *arg, struct argv_array *);
 
-extern int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
-extern size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
-extern void quote_two_c_style(struct strbuf *, const char *, const char *, int);
+int unquote_c_style(struct strbuf *, const char *quoted, const char **endp);
+size_t quote_c_style(const char *name, struct strbuf *, FILE *, int no_dq);
+void quote_two_c_style(struct strbuf *, const char *, const char *, int);
 
-extern void write_name_quoted(const char *name, FILE *, int terminator);
-extern void write_name_quoted_relative(const char *name, const char *prefix,
+void write_name_quoted(const char *name, FILE *, int terminator);
+void write_name_quoted_relative(const char *name, const char *prefix,
 		FILE *fp, int terminator);
 
 /* quote path as relative to the given prefix */
-extern char *quote_path_relative(const char *in, const char *prefix,
+char *quote_path_relative(const char *in, const char *prefix,
 			  struct strbuf *out);
 
 /* quoting as a string literal for other languages */
-extern void perl_quote_buf(struct strbuf *sb, const char *src);
-extern void python_quote_buf(struct strbuf *sb, const char *src);
-extern void tcl_quote_buf(struct strbuf *sb, const char *src);
-extern void basic_regex_quote_buf(struct strbuf *sb, const char *src);
+void perl_quote_buf(struct strbuf *sb, const char *src);
+void python_quote_buf(struct strbuf *sb, const char *src);
+void tcl_quote_buf(struct strbuf *sb, const char *src);
+void basic_regex_quote_buf(struct strbuf *sb, const char *src);
 
 #endif
diff --git a/reachable.h b/reachable.h
index 18b0f9f2f0..aef2b877a5 100644
--- a/reachable.h
+++ b/reachable.h
@@ -4,9 +4,9 @@
 struct progress;
 struct rev_info;
 
-extern int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
+int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
 						  timestamp_t timestamp);
-extern void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
+void mark_reachable_objects(struct rev_info *revs, int mark_reflog,
 				   timestamp_t mark_recent, struct progress *);
 
 #endif
diff --git a/reflog-walk.h b/reflog-walk.h
index cb3e73755d..c83597d1db 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -6,21 +6,21 @@
 struct commit;
 struct reflog_walk_info;
 
-extern void init_reflog_walk(struct reflog_walk_info **info);
-extern int add_reflog_for_walk(struct reflog_walk_info *info,
+void init_reflog_walk(struct reflog_walk_info **info);
+int add_reflog_for_walk(struct reflog_walk_info *info,
 		struct commit *commit, const char *name);
-extern void show_reflog_message(struct reflog_walk_info *info, int,
+void show_reflog_message(struct reflog_walk_info *info, int,
 				const struct date_mode *, int force_date);
-extern void get_reflog_message(struct strbuf *sb,
+void get_reflog_message(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info);
-extern const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
-extern timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
-extern void get_reflog_selector(struct strbuf *sb,
+const char *get_reflog_ident(struct reflog_walk_info *reflog_info);
+timestamp_t get_reflog_timestamp(struct reflog_walk_info *reflog_info);
+void get_reflog_selector(struct strbuf *sb,
 		struct reflog_walk_info *reflog_info,
 		const struct date_mode *dmode, int force_date,
 		int shorten);
 
-extern int reflog_walk_empty(struct reflog_walk_info *walk);
+int reflog_walk_empty(struct reflog_walk_info *walk);
 
 struct commit *next_reflog_entry(struct reflog_walk_info *reflog_info);
 
diff --git a/refs.h b/refs.h
index 308fa1f03b..21ca50d210 100644
--- a/refs.h
+++ b/refs.h
@@ -111,7 +111,7 @@ int should_autocreate_reflog(const char *refname);
 
 int is_branch(const char *refname);
 
-extern int refs_init_db(struct strbuf *err);
+int refs_init_db(struct strbuf *err);
 
 /*
  * If refname is a non-symbolic reference that refers to a tag object,
diff --git a/remote.h b/remote.h
index da53ad570b..7b1eed6008 100644
--- a/remote.h
+++ b/remote.h
@@ -119,13 +119,13 @@ struct ref {
 #define REF_HEADS	(1u << 1)
 #define REF_TAGS	(1u << 2)
 
-extern struct ref *find_ref_by_name(const struct ref *list, const char *name);
+struct ref *find_ref_by_name(const struct ref *list, const char *name);
 
 struct ref *alloc_ref(const char *name);
 struct ref *copy_ref(const struct ref *ref);
 struct ref *copy_ref_list(const struct ref *ref);
 void sort_ref_list(struct ref **, int (*cmp)(const void *, const void *));
-extern int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref);
+int count_refspec_match(const char *, struct ref *refs, struct ref **matched_ref);
 int ref_compare_name(const void *, const void *);
 
 int check_ref_type(const struct ref *ref, int flags);
@@ -139,13 +139,13 @@ struct oid_array;
 struct packet_reader;
 struct argv_array;
 struct string_list;
-extern struct ref **get_remote_heads(struct packet_reader *reader,
+struct ref **get_remote_heads(struct packet_reader *reader,
 				     struct ref **list, unsigned int flags,
 				     struct oid_array *extra_have,
 				     struct oid_array *shallow_points);
 
 /* Used for protocol v2 in order to retrieve refs from a remote */
-extern struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
+struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 				    struct ref **list, int for_push,
 				    const struct argv_array *ref_prefixes,
 				    const struct string_list *server_options);
@@ -287,9 +287,9 @@ struct push_cas_option {
 	int alloc;
 };
 
-extern int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
+int parseopt_push_cas_option(const struct option *, const char *arg, int unset);
 
-extern int is_empty_cas(const struct push_cas_option *);
+int is_empty_cas(const struct push_cas_option *);
 void apply_push_cas(struct push_cas_option *, struct remote *, struct ref *);
 
 #endif
diff --git a/replace-object.h b/replace-object.h
index 16528df942..f438421e36 100644
--- a/replace-object.h
+++ b/replace-object.h
@@ -16,7 +16,7 @@ void prepare_replace_object(struct repository *r);
  * This internal function is only declared here for the benefit of
  * lookup_replace_object().  Please do not call it directly.
  */
-extern const struct object_id *do_lookup_replace_object(struct repository *r,
+const struct object_id *do_lookup_replace_object(struct repository *r,
 							const struct object_id *oid);
 
 /*
diff --git a/resolve-undo.h b/resolve-undo.h
index fbe348efac..2b3f0f901e 100644
--- a/resolve-undo.h
+++ b/resolve-undo.h
@@ -8,12 +8,12 @@ struct resolve_undo_info {
 	struct object_id oid[3];
 };
 
-extern void record_resolve_undo(struct index_state *, struct cache_entry *);
-extern void resolve_undo_write(struct strbuf *, struct string_list *);
-extern struct string_list *resolve_undo_read(const char *, unsigned long);
-extern void resolve_undo_clear_index(struct index_state *);
-extern int unmerge_index_entry_at(struct index_state *, int);
-extern void unmerge_index(struct index_state *, const struct pathspec *);
-extern void unmerge_marked_index(struct index_state *);
+void record_resolve_undo(struct index_state *, struct cache_entry *);
+void resolve_undo_write(struct strbuf *, struct string_list *);
+struct string_list *resolve_undo_read(const char *, unsigned long);
+void resolve_undo_clear_index(struct index_state *);
+int unmerge_index_entry_at(struct index_state *, int);
+void unmerge_index(struct index_state *, const struct pathspec *);
+void unmerge_marked_index(struct index_state *);
 
 #endif
diff --git a/run-command.h b/run-command.h
index a6950691c0..f769e03f01 100644
--- a/run-command.h
+++ b/run-command.h
@@ -55,7 +55,7 @@ struct child_process {
 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
 void child_process_init(struct child_process *);
 void child_process_clear(struct child_process *);
-extern int is_executable(const char *name);
+int is_executable(const char *name);
 
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
@@ -67,10 +67,10 @@ int run_command(struct child_process *);
  * or disabled. Note that this points to static storage that will be
  * overwritten by further calls to find_hook and run_hook_*.
  */
-extern const char *find_hook(const char *name);
+const char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
-extern int run_hook_le(const char *const *env, const char *name, ...);
-extern int run_hook_ve(const char *const *env, const char *name, va_list args);
+int run_hook_le(const char *const *env, const char *name, ...);
+int run_hook_ve(const char *const *env, const char *name, va_list args);
 
 #define RUN_COMMAND_NO_STDIN 1
 #define RUN_GIT_CMD	     2	/*If this is to be git sub-command */
diff --git a/serve.h b/serve.h
index fe65ba9f46..48b6f5e479 100644
--- a/serve.h
+++ b/serve.h
@@ -2,7 +2,7 @@
 #define SERVE_H
 
 struct argv_array;
-extern int has_capability(const struct argv_array *keys, const char *capability,
+int has_capability(const struct argv_array *keys, const char *capability,
 			  const char **value);
 
 struct serve_options {
@@ -10,6 +10,6 @@ struct serve_options {
 	unsigned stateless_rpc;
 };
 #define SERVE_OPTIONS_INIT { 0 }
-extern void serve(struct serve_options *options);
+void serve(struct serve_options *options);
 
 #endif /* SERVE_H */
diff --git a/sha1-lookup.h b/sha1-lookup.h
index 7678b23b36..457c9b4964 100644
--- a/sha1-lookup.h
+++ b/sha1-lookup.h
@@ -3,7 +3,7 @@
 
 typedef const unsigned char *sha1_access_fn(size_t index, void *table);
 
-extern int sha1_pos(const unsigned char *sha1,
+int sha1_pos(const unsigned char *sha1,
 		    void *table,
 		    size_t nr,
 		    sha1_access_fn fn);
diff --git a/streaming.h b/streaming.h
index 32f4626771..f465a3cd31 100644
--- a/streaming.h
+++ b/streaming.h
@@ -8,10 +8,10 @@
 /* opaque */
 struct git_istream;
 
-extern struct git_istream *open_istream(const struct object_id *, enum object_type *, unsigned long *, struct stream_filter *);
-extern int close_istream(struct git_istream *);
-extern ssize_t read_istream(struct git_istream *, void *, size_t);
+struct git_istream *open_istream(const struct object_id *, enum object_type *, unsigned long *, struct stream_filter *);
+int close_istream(struct git_istream *);
+ssize_t read_istream(struct git_istream *, void *, size_t);
 
-extern int stream_blob_to_fd(int fd, const struct object_id *, struct stream_filter *, int can_seek);
+int stream_blob_to_fd(int fd, const struct object_id *, struct stream_filter *, int can_seek);
 
 #endif /* STREAMING_H */
diff --git a/string-list.h b/string-list.h
index 18c718c12c..7d9df61ac3 100644
--- a/string-list.h
+++ b/string-list.h
@@ -174,7 +174,7 @@ struct string_list_item *string_list_insert(struct string_list *list, const char
  * Remove the given string from the sorted list.  If the string
  * doesn't exist, the list is not altered.
  */
-extern void string_list_remove(struct string_list *list, const char *string,
+void string_list_remove(struct string_list *list, const char *string,
 			       int free_util);
 
 /**
diff --git a/sub-process.h b/sub-process.h
index 71b18ad5af..1653ae8afe 100644
--- a/sub-process.h
+++ b/sub-process.h
@@ -42,7 +42,7 @@ struct subprocess_capability {
 /* subprocess functions */
 
 /* Function to test two subprocess hashmap entries for equality. */
-extern int cmd2process_cmp(const void *unused_cmp_data,
+int cmd2process_cmp(const void *unused_cmp_data,
 			   const void *e1,
 			   const void *e2,
 			   const void *unused_keydata);
diff --git a/submodule-config.h b/submodule-config.h
index 4dc9b0771c..a88ae7107f 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -30,17 +30,17 @@ struct submodule {
 struct submodule_cache;
 struct repository;
 
-extern void submodule_cache_free(struct submodule_cache *cache);
+void submodule_cache_free(struct submodule_cache *cache);
 
-extern int parse_submodule_fetchjobs(const char *var, const char *value);
-extern int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
+int parse_submodule_fetchjobs(const char *var, const char *value);
+int parse_fetch_recurse_submodules_arg(const char *opt, const char *arg);
 struct option;
-extern int option_fetch_parse_recurse_submodules(const struct option *opt,
+int option_fetch_parse_recurse_submodules(const struct option *opt,
 						 const char *arg, int unset);
-extern int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
-extern int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
-extern void repo_read_gitmodules(struct repository *repo);
-extern void gitmodules_config_oid(const struct object_id *commit_oid);
+int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
+int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
+void repo_read_gitmodules(struct repository *repo);
+void gitmodules_config_oid(const struct object_id *commit_oid);
 const struct submodule *submodule_from_name(struct repository *r,
 					    const struct object_id *commit_or_tree,
 					    const char *name);
@@ -66,7 +66,7 @@ int check_submodule_name(const char *name);
  * New helpers to retrieve arbitrary configuration from the '.gitmodules' file
  * should NOT be added.
  */
-extern void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
-extern void update_clone_config_from_gitmodules(int *max_jobs);
+void fetch_config_from_gitmodules(int *max_children, int *recurse_submodules);
+void update_clone_config_from_gitmodules(int *max_jobs);
 
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/tag.h b/tag.h
index e669c3e497..e57490485e 100644
--- a/tag.h
+++ b/tag.h
@@ -11,13 +11,13 @@ struct tag {
 	char *tag;
 	timestamp_t date;
 };
-extern struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
-extern int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
-extern int parse_tag(struct tag *item);
-extern void release_tag_memory(struct tag *t);
-extern struct object *deref_tag(struct repository *r, struct object *, const char *, int);
-extern struct object *deref_tag_noverify(struct object *);
-extern int gpg_verify_tag(const struct object_id *oid,
+struct tag *lookup_tag(struct repository *r, const struct object_id *oid);
+int parse_tag_buffer(struct repository *r, struct tag *item, const void *data, unsigned long size);
+int parse_tag(struct tag *item);
+void release_tag_memory(struct tag *t);
+struct object *deref_tag(struct repository *r, struct object *, const char *, int);
+struct object *deref_tag_noverify(struct object *);
+int gpg_verify_tag(const struct object_id *oid,
 		const char *name_to_report, unsigned flags);
 
 #endif /* TAG_H */
diff --git a/tempfile.h b/tempfile.h
index 61d8dc4d1b..7b05d5765e 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -89,7 +89,7 @@ struct tempfile {
  * a tempfile (whose "fd" member can be used for writing to it), or
  * NULL on error. It is an error if a file already exists at that path.
  */
-extern struct tempfile *create_tempfile(const char *path);
+struct tempfile *create_tempfile(const char *path);
 
 /*
  * Register an existing file as a tempfile, meaning that it will be
@@ -97,7 +97,7 @@ extern struct tempfile *create_tempfile(const char *path);
  * but it can be worked with like any other closed tempfile (for
  * example, it can be opened using reopen_tempfile()).
  */
-extern struct tempfile *register_tempfile(const char *path);
+struct tempfile *register_tempfile(const char *path);
 
 
 /*
@@ -136,7 +136,7 @@ extern struct tempfile *register_tempfile(const char *path);
  */
 
 /* See "mks_tempfile functions" above. */
-extern struct tempfile *mks_tempfile_sm(const char *filename_template,
+struct tempfile *mks_tempfile_sm(const char *filename_template,
 					int suffixlen, int mode);
 
 /* See "mks_tempfile functions" above. */
@@ -159,7 +159,7 @@ static inline struct tempfile *mks_tempfile(const char *filename_template)
 }
 
 /* See "mks_tempfile functions" above. */
-extern struct tempfile *mks_tempfile_tsm(const char *filename_template,
+struct tempfile *mks_tempfile_tsm(const char *filename_template,
 					 int suffixlen, int mode);
 
 /* See "mks_tempfile functions" above. */
@@ -182,7 +182,7 @@ static inline struct tempfile *mks_tempfile_t(const char *filename_template)
 }
 
 /* See "mks_tempfile functions" above. */
-extern struct tempfile *xmks_tempfile_m(const char *filename_template, int mode);
+struct tempfile *xmks_tempfile_m(const char *filename_template, int mode);
 
 /* See "mks_tempfile functions" above. */
 static inline struct tempfile *xmks_tempfile(const char *filename_template)
@@ -196,7 +196,7 @@ static inline struct tempfile *xmks_tempfile(const char *filename_template)
  * stream is closed automatically when `close_tempfile_gently()` is called or
  * when the file is deleted or renamed.
  */
-extern FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode);
+FILE *fdopen_tempfile(struct tempfile *tempfile, const char *mode);
 
 static inline int is_tempfile_active(struct tempfile *tempfile)
 {
@@ -207,10 +207,10 @@ static inline int is_tempfile_active(struct tempfile *tempfile)
  * Return the path of the lockfile. The return value is a pointer to a
  * field within the lock_file object and should not be freed.
  */
-extern const char *get_tempfile_path(struct tempfile *tempfile);
+const char *get_tempfile_path(struct tempfile *tempfile);
 
-extern int get_tempfile_fd(struct tempfile *tempfile);
-extern FILE *get_tempfile_fp(struct tempfile *tempfile);
+int get_tempfile_fd(struct tempfile *tempfile);
+FILE *get_tempfile_fp(struct tempfile *tempfile);
 
 /*
  * If the temporary file is still open, close it (and the file pointer
@@ -220,7 +220,7 @@ extern FILE *get_tempfile_fp(struct tempfile *tempfile);
  * should eventually be called regardless of whether `close_tempfile_gently()`
  * succeeds.
  */
-extern int close_tempfile_gently(struct tempfile *tempfile);
+int close_tempfile_gently(struct tempfile *tempfile);
 
 /*
  * Re-open a temporary file that has been closed using
@@ -241,7 +241,7 @@ extern int close_tempfile_gently(struct tempfile *tempfile);
  *
  * * `rename_tempfile()` to move the file to its permanent location.
  */
-extern int reopen_tempfile(struct tempfile *tempfile);
+int reopen_tempfile(struct tempfile *tempfile);
 
 /*
  * Close the file descriptor and/or file pointer and remove the
@@ -249,7 +249,7 @@ extern int reopen_tempfile(struct tempfile *tempfile);
  * `delete_tempfile()` for a `tempfile` object that has already been
  * deleted or renamed.
  */
-extern void delete_tempfile(struct tempfile **tempfile_p);
+void delete_tempfile(struct tempfile **tempfile_p);
 
 /*
  * Close the file descriptor and/or file pointer if they are still
@@ -260,6 +260,6 @@ extern void delete_tempfile(struct tempfile **tempfile_p);
  * `rename(2)`. It is a bug to call `rename_tempfile()` for a
  * `tempfile` object that is not currently active.
  */
-extern int rename_tempfile(struct tempfile **tempfile_p, const char *path);
+int rename_tempfile(struct tempfile **tempfile_p, const char *path);
 
 #endif /* TEMPFILE_H */
diff --git a/trace.h b/trace.h
index 171b256d26..4ca2a5a63f 100644
--- a/trace.h
+++ b/trace.h
@@ -17,34 +17,34 @@ extern struct trace_key trace_default_key;
 extern struct trace_key trace_perf_key;
 extern struct trace_key trace_setup_key;
 
-extern void trace_repo_setup(const char *prefix);
-extern int trace_want(struct trace_key *key);
-extern void trace_disable(struct trace_key *key);
-extern uint64_t getnanotime(void);
-extern void trace_command_performance(const char **argv);
-extern void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
+void trace_repo_setup(const char *prefix);
+int trace_want(struct trace_key *key);
+void trace_disable(struct trace_key *key);
+uint64_t getnanotime(void);
+void trace_command_performance(const char **argv);
+void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
 uint64_t trace_performance_enter(void);
 
 #ifndef HAVE_VARIADIC_MACROS
 
 __attribute__((format (printf, 1, 2)))
-extern void trace_printf(const char *format, ...);
+void trace_printf(const char *format, ...);
 
 __attribute__((format (printf, 2, 3)))
-extern void trace_printf_key(struct trace_key *key, const char *format, ...);
+void trace_printf_key(struct trace_key *key, const char *format, ...);
 
 __attribute__((format (printf, 2, 3)))
-extern void trace_argv_printf(const char **argv, const char *format, ...);
+void trace_argv_printf(const char **argv, const char *format, ...);
 
-extern void trace_strbuf(struct trace_key *key, const struct strbuf *data);
+void trace_strbuf(struct trace_key *key, const struct strbuf *data);
 
 /* Prints elapsed time (in nanoseconds) if GIT_TRACE_PERFORMANCE is enabled. */
 __attribute__((format (printf, 2, 3)))
-extern void trace_performance(uint64_t nanos, const char *format, ...);
+void trace_performance(uint64_t nanos, const char *format, ...);
 
 /* Prints elapsed time since 'start' if GIT_TRACE_PERFORMANCE is enabled. */
 __attribute__((format (printf, 2, 3)))
-extern void trace_performance_since(uint64_t start, const char *format, ...);
+void trace_performance_since(uint64_t start, const char *format, ...);
 
 __attribute__((format (printf, 1, 2)))
 void trace_performance_leave(const char *format, ...);
@@ -132,18 +132,18 @@ void trace_performance_leave(const char *format, ...);
 
 /* backend functions, use non-*fl macros instead */
 __attribute__((format (printf, 4, 5)))
-extern void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
+void trace_printf_key_fl(const char *file, int line, struct trace_key *key,
 				const char *format, ...);
 __attribute__((format (printf, 4, 5)))
-extern void trace_argv_printf_fl(const char *file, int line, const char **argv,
+void trace_argv_printf_fl(const char *file, int line, const char **argv,
 				 const char *format, ...);
-extern void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
+void trace_strbuf_fl(const char *file, int line, struct trace_key *key,
 			    const struct strbuf *data);
 __attribute__((format (printf, 4, 5)))
-extern void trace_performance_fl(const char *file, int line,
+void trace_performance_fl(const char *file, int line,
 				 uint64_t nanos, const char *fmt, ...);
 __attribute__((format (printf, 4, 5)))
-extern void trace_performance_leave_fl(const char *file, int line,
+void trace_performance_leave_fl(const char *file, int line,
 				       uint64_t nanos, const char *fmt, ...);
 static inline int trace_pass_fl(struct trace_key *key)
 {
diff --git a/transport.h b/transport.h
index f2ee7c4f49..06e06d3d89 100644
--- a/transport.h
+++ b/transport.h
@@ -134,7 +134,7 @@ struct transport {
 #define TRANSPORT_PUSH_OPTIONS			(1<<14)
 #define TRANSPORT_RECURSE_SUBMODULES_ONLY	(1<<15)
 
-extern int transport_summary_width(const struct ref *refs);
+int transport_summary_width(const struct ref *refs);
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
@@ -263,5 +263,5 @@ void transport_print_push_status(const char *dest, struct ref *refs,
 		  int verbose, int porcelain, unsigned int *reject_reasons);
 
 typedef void alternate_ref_fn(const struct object_id *oid, void *);
-extern void for_each_alternate_ref(alternate_ref_fn, void *);
+void for_each_alternate_ref(alternate_ref_fn, void *);
 #endif
diff --git a/tree-walk.h b/tree-walk.h
index 8225171866..550b8dd9a4 100644
--- a/tree-walk.h
+++ b/tree-walk.h
@@ -67,8 +67,8 @@ struct traverse_info {
 };
 
 int get_tree_entry(const struct object_id *, const char *, struct object_id *, unsigned *);
-extern char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
-extern void setup_traverse_info(struct traverse_info *info, const char *base);
+char *make_traverse_path(char *path, const struct traverse_info *info, const struct name_entry *n);
+void setup_traverse_info(struct traverse_info *info, const char *base);
 
 static inline int traverse_path_len(const struct traverse_info *info, const struct name_entry *n)
 {
diff --git a/upload-pack.h b/upload-pack.h
index cab2178796..bc2ceb211c 100644
--- a/upload-pack.h
+++ b/upload-pack.h
@@ -13,11 +13,11 @@ void upload_pack(struct upload_pack_options *options);
 struct repository;
 struct argv_array;
 struct packet_reader;
-extern int upload_pack_v2(struct repository *r, struct argv_array *keys,
+int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			  struct packet_reader *request);
 
 struct strbuf;
-extern int upload_pack_advertise(struct repository *r,
+int upload_pack_advertise(struct repository *r,
 				 struct strbuf *value);
 
 #endif /* UPLOAD_PACK_H */
diff --git a/url.h b/url.h
index f311c40a46..00b7d58c33 100644
--- a/url.h
+++ b/url.h
@@ -3,14 +3,14 @@
 
 struct strbuf;
 
-extern int is_url(const char *url);
-extern int is_urlschemechar(int first_flag, int ch);
-extern char *url_decode(const char *url);
-extern char *url_decode_mem(const char *url, int len);
-extern char *url_decode_parameter_name(const char **query);
-extern char *url_decode_parameter_value(const char **query);
+int is_url(const char *url);
+int is_urlschemechar(int first_flag, int ch);
+char *url_decode(const char *url);
+char *url_decode_mem(const char *url, int len);
+char *url_decode_parameter_name(const char **query);
+char *url_decode_parameter_value(const char **query);
 
-extern void end_url_with_slash(struct strbuf *buf, const char *url);
-extern void str_end_url_with_slash(const char *url, char **dest);
+void end_url_with_slash(struct strbuf *buf, const char *url);
+void str_end_url_with_slash(const char *url, char **dest);
 
 #endif /* URL_H */
diff --git a/urlmatch.h b/urlmatch.h
index e482148248..eed5f29235 100644
--- a/urlmatch.h
+++ b/urlmatch.h
@@ -33,7 +33,7 @@ struct url_info {
 				 * '?...' and '#...' portion; will always be >= 1 */
 };
 
-extern char *url_normalize(const char *, struct url_info *);
+char *url_normalize(const char *, struct url_info *);
 
 struct urlmatch_item {
 	size_t hostmatch_len;
@@ -52,6 +52,6 @@ struct urlmatch_config {
 	int (*cascade_fn)(const char *var, const char *value, void *cb);
 };
 
-extern int urlmatch_config_entry(const char *var, const char *value, void *cb);
+int urlmatch_config_entry(const char *var, const char *value, void *cb);
 
 #endif /* URL_MATCH_H */
diff --git a/utf8.h b/utf8.h
index 84efbfcb1f..fcd5167baf 100644
--- a/utf8.h
+++ b/utf8.h
@@ -16,7 +16,7 @@ __attribute__((format (printf, 2, 3)))
 int utf8_fprintf(FILE *, const char *, ...);
 
 extern const char utf8_bom[];
-extern int skip_utf8_bom(char **, size_t);
+int skip_utf8_bom(char **, size_t);
 
 void strbuf_add_wrapped_text(struct strbuf *buf,
 		const char *text, int indent, int indent2, int width);
diff --git a/varint.h b/varint.h
index c1c44d9a6b..f78bb0ca52 100644
--- a/varint.h
+++ b/varint.h
@@ -1,7 +1,7 @@
 #ifndef VARINT_H
 #define VARINT_H
 
-extern int encode_varint(uintmax_t, unsigned char *);
-extern uintmax_t decode_varint(const unsigned char **);
+int encode_varint(uintmax_t, unsigned char *);
+uintmax_t decode_varint(const unsigned char **);
 
 #endif /* VARINT_H */
diff --git a/vcs-svn/sliding_window.h b/vcs-svn/sliding_window.h
index 189c32d84c..a7fc0999cb 100644
--- a/vcs-svn/sliding_window.h
+++ b/vcs-svn/sliding_window.h
@@ -13,6 +13,6 @@ struct sliding_view {
 
 #define SLIDING_VIEW_INIT(input, len)	{ (input), 0, 0, (len), STRBUF_INIT }
 
-extern int move_window(struct sliding_view *view, off_t off, size_t width);
+int move_window(struct sliding_view *view, off_t off, size_t width);
 
 #endif
diff --git a/vcs-svn/svndiff.h b/vcs-svn/svndiff.h
index 10a2cbc40e..023799a05c 100644
--- a/vcs-svn/svndiff.h
+++ b/vcs-svn/svndiff.h
@@ -4,7 +4,7 @@
 struct line_buffer;
 struct sliding_view;
 
-extern int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
+int svndiff0_apply(struct line_buffer *delta, off_t delta_len,
 		struct sliding_view *preimage, FILE *postimage);
 
 #endif
diff --git a/worktree.h b/worktree.h
index 9e3b0b7b6f..2d6a1d207a 100644
--- a/worktree.h
+++ b/worktree.h
@@ -30,37 +30,37 @@ struct worktree {
  * The caller is responsible for freeing the memory from the returned
  * worktree(s).
  */
-extern struct worktree **get_worktrees(unsigned flags);
+struct worktree **get_worktrees(unsigned flags);
 
 /*
  * Returns 1 if linked worktrees exist, 0 otherwise.
  */
-extern int submodule_uses_worktrees(const char *path);
+int submodule_uses_worktrees(const char *path);
 
 /*
  * Return git dir of the worktree. Note that the path may be relative.
  * If wt is NULL, git dir of current worktree is returned.
  */
-extern const char *get_worktree_git_dir(const struct worktree *wt);
+const char *get_worktree_git_dir(const struct worktree *wt);
 
 /*
  * Search a worktree that can be unambiguously identified by
  * "arg". "prefix" must not be NULL.
  */
-extern struct worktree *find_worktree(struct worktree **list,
+struct worktree *find_worktree(struct worktree **list,
 				      const char *prefix,
 				      const char *arg);
 
 /*
  * Return true if the given worktree is the main one.
  */
-extern int is_main_worktree(const struct worktree *wt);
+int is_main_worktree(const struct worktree *wt);
 
 /*
  * Return the reason string if the given worktree is locked or NULL
  * otherwise.
  */
-extern const char *worktree_lock_reason(struct worktree *wt);
+const char *worktree_lock_reason(struct worktree *wt);
 
 #define WT_VALIDATE_WORKTREE_MISSING_OK (1 << 0)
 
@@ -68,27 +68,27 @@ extern const char *worktree_lock_reason(struct worktree *wt);
  * Return zero if the worktree is in good condition. Error message is
  * returned if "errmsg" is not NULL.
  */
-extern int validate_worktree(const struct worktree *wt,
+int validate_worktree(const struct worktree *wt,
 			     struct strbuf *errmsg,
 			     unsigned flags);
 
 /*
  * Update worktrees/xxx/gitdir with the new path.
  */
-extern void update_worktree_location(struct worktree *wt,
+void update_worktree_location(struct worktree *wt,
 				     const char *path_);
 
 /*
  * Free up the memory for worktree(s)
  */
-extern void free_worktrees(struct worktree **);
+void free_worktrees(struct worktree **);
 
 /*
  * Check if a per-worktree symref points to a ref in the main worktree
  * or any linked worktree, and return the worktree that holds the ref,
  * or NULL otherwise. The result may be destroyed by the next call.
  */
-extern const struct worktree *find_shared_symref(const char *symref,
+const struct worktree *find_shared_symref(const char *symref,
 						 const char *target);
 
 /*
@@ -104,7 +104,7 @@ int is_worktree_being_bisected(const struct worktree *wt, const char *target);
  * Similar to git_path() but can produce paths for a specified
  * worktree instead of current one
  */
-extern const char *worktree_git_path(const struct worktree *wt,
+const char *worktree_git_path(const struct worktree *wt,
 				     const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
diff --git a/xdiff-interface.h b/xdiff-interface.h
index 2d41fffd4c..a71950a10b 100644
--- a/xdiff-interface.h
+++ b/xdiff-interface.h
@@ -27,9 +27,9 @@ int read_mmfile(mmfile_t *ptr, const char *filename);
 void read_mmblob(mmfile_t *ptr, const struct object_id *oid);
 int buffer_is_binary(const char *ptr, unsigned long size);
 
-extern void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
-extern void xdiff_clear_find_func(xdemitconf_t *xecfg);
-extern int git_xmerge_config(const char *var, const char *value, void *cb);
+void xdiff_set_find_func(xdemitconf_t *xecfg, const char *line, int cflags);
+void xdiff_clear_find_func(xdemitconf_t *xecfg);
+int git_xmerge_config(const char *var, const char *value, void *cb);
 extern int git_xmerge_style;
 
 /*
@@ -46,7 +46,7 @@ void discard_hunk_line(void *priv,
  * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
  * are treated for the comparision.
  */
-extern int xdiff_compare_lines(const char *l1, long s1,
+int xdiff_compare_lines(const char *l1, long s1,
 			       const char *l2, long s2, long flags);
 
 /*
@@ -54,6 +54,6 @@ extern int xdiff_compare_lines(const char *l1, long s1,
  * The `flags` given as XDF_WHITESPACE_FLAGS determine how white spaces
  * are treated for the hash.
  */
-extern unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
+unsigned long xdiff_hash_string(const char *s, size_t len, long flags);
 
 #endif
-- 
2.21.0.921.gb27c68c4e9

