Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 425151F404
	for <e@80x24.org>; Sun, 16 Sep 2018 06:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeIPLxw (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Sep 2018 07:53:52 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43398 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbeIPLxw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Sep 2018 07:53:52 -0400
Received: by mail-lf1-f67.google.com with SMTP id x24-v6so907614lfe.10
        for <git@vger.kernel.org>; Sat, 15 Sep 2018 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ay3XXP1y9Z7VIQ4cvB/1pq+R5wD4AAHCa12GrnFeJlA=;
        b=r3v9fzqcjk9rIlr3+OO5yPKv6whm5BER+o8UxclAQfW+qikiS8uPFQCMCZTjaUHeKB
         ramuFPkB6xw1UPtMiY9ArXsrnP5KEoi44eeig+qiZ/WppEsgbclehU7hDZ4GqFH0dzHY
         fDxn0yGfjuL0hR+JOxduQKREYAASPqYCN6JAAe9COmDzfh1ngKffhuSE03iB6h/WqNrX
         zxgAhjC2ucjviUEfkZa7Jdvtp/XVMLW1nnbI1EtwavdBNbagyt4KlX+FAXa2JvJq0GsR
         zA+JDO+A1Ol1PR4gwwR4q8d720QcvnmrGzFGREPnFigleC8w38uJQzyLN9ntfAdoCr6c
         9uDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ay3XXP1y9Z7VIQ4cvB/1pq+R5wD4AAHCa12GrnFeJlA=;
        b=dsI47t4XNxWoOQ6ovefFLjKr79zfHormpQN4Sqs7lDImSXgJT3lWi0DC8C1gCSDFqs
         DTYd/pMRrT/bumeNbv//Z4hR52MoPrNtWm1vdQCkFx92pivpAST8kKVhCkxwJjq/9XJ9
         86v+SSxbw0S98b0rJgqy/vol+hWDiokNaflj+D6RRb58uBFm7ANuLbyBijcMm6b3EWtm
         SAIGIVdy8fsRyoJIiDY4wGWgljXcHlU0o873fuZDivg3ssXlFfI6v0fiFRmI0sOt6vtm
         A4bRjnWlsJUWrLHgNSSubLz4QGdG0dqQry7Du75rpI+xfZ3wqVOYuXjQG4oHvAFIzP90
         PiIw==
X-Gm-Message-State: APzg51A+sktZWZeFrzwARKeHIUGanAJ9togz+DWPhw1OHK9EPI6irrHH
        csxKomi/Il12wmwhrYmltn0gEOQ2
X-Google-Smtp-Source: ANB0VdZSKAeBVYLzrsfdQGMzc8gx/ZulKJ6hyAfVIolWOEBzElDONndp7rolte4Dy2ezNUQxeYG7Gg==
X-Received: by 2002:a19:c70a:: with SMTP id x10-v6mr13137700lff.148.1537079518632;
        Sat, 15 Sep 2018 23:31:58 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id l1-v6sm2108922lji.41.2018.09.15.23.31.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Sep 2018 23:31:58 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        jacob.keller@gmail.com,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/1] commit: do not clobber the index
Date:   Sun, 16 Sep 2018 08:31:46 +0200
Message-Id: <20180916063146.9850-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180916063146.9850-1-pclouds@gmail.com>
References: <20180820154120.19297-1-pclouds@gmail.com>
 <20180916063146.9850-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git commit" can be used in two different workflows:

 - the user never bothers with "git add" and uses "git commit" for
   both adding content to the index and committing it

 - the user uses "git add" to carefully prepare what they want to
   commit, and "git commit" creates a new commit out of the current
   index. In this case "git commit" does not modify the index at all.

The user could switch between the two workflows of course, and
mistakes can happen that lead to content loss. Imagine the user has
prepared the index with 'git add -p' (second workflow), which makes
the index content different from both HEAD and worktree. If they
accidentally do "git commit -a" (first workflow) after that, all the
preparation is gone because "git commit" clobbers the index.

Prevent this by checking the staged content when runnning "commit -a"
or "commit <path>". If the staged content is different from both HEAD
and the worktree version, abort the commit. The user can still
override this by giving "--clobber-index" option.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/git-commit.txt     |  11 +++-
 builtin/commit.c                 | 105 ++++++++++++++++++++++++++++---
 cache.h                          |   1 +
 read-cache.c                     |  11 ++++
 t/t2201-add-update-typechange.sh |   2 +-
 t/t4015-diff-whitespace.sh       |   2 +-
 t/t7102-reset.sh                 |   2 +-
 t/t7500-commit.sh                |   2 +-
 t/t7502-commit.sh                |   4 +-
 t/t9350-fast-export.sh           |   2 +-
 10 files changed, 126 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index f970a43422..2d128527ec 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -31,8 +31,9 @@ The content to be added can be specified in several ways:
 
 3. by listing files as arguments to the 'commit' command
    (without --interactive or --patch switch), in which
-   case the commit will ignore changes staged in the index, and instead
-   record the current content of the listed files (which must already
+   case the commit will ignore changes staged in the index if
+   --clobber-index is specified, and instead record the current
+   content of the listed files (which must already
    be known to Git);
 
 4. by using the -a switch with the 'commit' command to automatically
@@ -274,6 +275,12 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	already been staged. If used together with `--allow-empty`
 	paths are also not required, and an empty commit will be created.
 
+--clobber-index::
+	By default 'git commit' will not update the index if
+	non-conflicted staged content of a path is different from both
+	HEAD and the working tree. This option skips this check and
+	makes 'git commit' ignore content changes in the index.
+
 -u[<mode>]::
 --untracked-files[=<mode>]::
 	Show untracked files.
diff --git a/builtin/commit.c b/builtin/commit.c
index 0d9828e29e..a179b8a9e7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -101,6 +101,7 @@ static int all, also, interactive, patch_interactive, only, amend, signoff;
 static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
+static int clobber_index;
 static int no_post_rewrite, allow_empty_message;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit;
@@ -263,11 +264,78 @@ static int list_paths(struct string_list *list, const char *with_tree,
 	return ret;
 }
 
-static void add_remove_files(struct string_list *list)
+static void mark_staged_paths_cb(struct diff_queue_struct *q,
+				 struct diff_options *options,
+				 void *data)
+{
+	struct index_state *istate = data;
+	int i;
+
+	for (i = 0; i < q->nr; i++) {
+		struct diff_filepair *p;
+		int pos;
+
+		p = q->queue[i];
+
+		switch (p->status) {
+		case DIFF_STATUS_ADDED:
+			break;
+
+		case DIFF_STATUS_MODIFIED:
+			/*
+			 * _MODIFIED could be either because of content or
+			 * mode change. Ignore mode change.
+			 */
+			if (oidcmp(&p->one->oid, &p->two->oid))
+				break;
+			continue;
+
+		default:
+			continue;
+		}
+
+		pos = index_name_pos(istate, p->two->path,
+				     strlen(p->two->path));
+		if (pos < 0)
+			BUG("entry '%s' => '%s' status '%c' not found in the index",
+			    p->one->path ? p->one->path : "(empty)",
+			    p->two->path ? p->two->path : "(empty)",
+			    p->status);
+		istate->cache[pos]->ce_flags |= CE_MATCHED;
+	}
+}
+
+static void mark_staged_paths(struct index_state *istate,
+			      const char *prefix,
+			      struct pathspec *pathspec)
+{
+	struct rev_info rev;
+	struct setup_revision_opt opt;
+	int i;
+
+	init_revisions(&rev, NULL);
+	memset(&opt, 0, sizeof(opt));
+	opt.def = "HEAD";
+	setup_revisions(0, NULL, &rev, &opt);
+
+	rev.diffopt.ita_invisible_in_index = 1;
+	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
+	rev.diffopt.format_callback = mark_staged_paths_cb;
+	rev.diffopt.format_callback_data = istate;
+	copy_pathspec(&rev.prune_data, pathspec);
+
+	for (i = 0; i < istate->cache_nr; i++)
+		istate->cache[i]->ce_flags &= ~CE_MATCHED;
+
+	run_diff_index(&rev, 1);
+}
+
+static void add_remove_files(struct string_list *list, int flags)
 {
 	int i;
 	for (i = 0; i < list->nr; i++) {
 		struct stat st;
+		int pos;
 		struct string_list_item *p = &(list->items[i]);
 
 		/* p->util is skip-worktree */
@@ -275,10 +343,18 @@ static void add_remove_files(struct string_list *list)
 			continue;
 
 		if (!lstat(p->string, &st)) {
-			if (add_to_cache(p->string, &st, 0))
+			if (add_to_cache(p->string, &st, flags))
 				die(_("updating files failed"));
-		} else
-			remove_file_from_cache(p->string);
+			continue;
+		}
+
+		if (flags & ADD_CACHE_KEEP_CE_MATCHED &&
+		    (pos = index_name_pos(&the_index, p->string,
+					  strlen(p->string))) >= 0 &&
+		    the_index.cache[pos]->ce_flags & CE_MATCHED)
+			die(_("clobbering '%s' is not allowed"),
+			    p->string);
+		remove_file_from_cache(p->string);
 	}
 }
 
@@ -326,6 +402,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	struct string_list partial = STRING_LIST_INIT_DUP;
 	struct pathspec pathspec;
 	int refresh_flags = REFRESH_QUIET;
+	unsigned int add_flags = 0;
 	const char *ret;
 
 	if (is_status)
@@ -372,6 +449,9 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		goto out;
 	}
 
+	if (!clobber_index && !current_head)
+		clobber_index = 1;
+
 	/*
 	 * Non partial, non as-is commit.
 	 *
@@ -385,8 +465,14 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 	 * (B) on failure, rollback the real index.
 	 */
 	if (all || (also && pathspec.nr)) {
+		const char *add_prefix = also ? prefix : NULL;
+
 		hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-		add_files_to_cache(also ? prefix : NULL, &pathspec, 0);
+		if (!clobber_index) {
+			mark_staged_paths(&the_index, add_prefix, &pathspec);
+			add_flags |= ADD_CACHE_KEEP_CE_MATCHED;
+		}
+		add_files_to_cache(add_prefix, &pathspec, add_flags);
 		refresh_cache_or_die(refresh_flags);
 		update_main_cache_tree(WRITE_TREE_SILENT);
 		if (write_locked_index(&the_index, &index_lock, 0))
@@ -455,7 +541,11 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 		die(_("cannot read the index"));
 
 	hold_locked_index(&index_lock, LOCK_DIE_ON_ERROR);
-	add_remove_files(&partial);
+	if (!clobber_index) {
+		mark_staged_paths(&the_index, NULL, &pathspec);
+		add_flags |= ADD_CACHE_KEEP_CE_MATCHED;
+	}
+	add_remove_files(&partial, add_flags);
 	refresh_cache(REFRESH_QUIET);
 	update_main_cache_tree(WRITE_TREE_SILENT);
 	if (write_locked_index(&the_index, &index_lock, 0))
@@ -467,7 +557,7 @@ static const char *prepare_index(int argc, const char **argv, const char *prefix
 				  LOCK_DIE_ON_ERROR);
 
 	create_base_index(current_head);
-	add_remove_files(&partial);
+	add_remove_files(&partial, 0);
 	refresh_cache(REFRESH_QUIET);
 
 	if (write_locked_index(&the_index, &false_lock, 0))
@@ -1477,6 +1567,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('o', "only", &only, N_("commit only specified files")),
 		OPT_BOOL('n', "no-verify", &no_verify, N_("bypass pre-commit and commit-msg hooks")),
 		OPT_BOOL(0, "dry-run", &dry_run, N_("show what would be committed")),
+		OPT_BOOL(0, "clobber-index", &clobber_index, N_("clobber the index")),
 		OPT_SET_INT(0, "short", &status_format, N_("show status concisely"),
 			    STATUS_FORMAT_SHORT),
 		OPT_BOOL(0, "branch", &s.show_branch, N_("show branch information")),
diff --git a/cache.h b/cache.h
index b1fd3d58ab..8718cc636b 100644
--- a/cache.h
+++ b/cache.h
@@ -738,6 +738,7 @@ extern int index_name_pos(const struct index_state *, const char *name, int name
 #define ADD_CACHE_JUST_APPEND 8		/* Append only; tree.c::read_tree() */
 #define ADD_CACHE_NEW_ONLY 16		/* Do not replace existing ones */
 #define ADD_CACHE_KEEP_CACHE_TREE 32	/* Do not invalidate cache-tree */
+#define ADD_CACHE_KEEP_CE_MATCHED 64	/* Do not change CE_MATCHED files */
 extern int add_index_entry(struct index_state *, struct cache_entry *ce, int option);
 extern void rename_index_entry_at(struct index_state *, int pos, const char *new_name);
 
diff --git a/read-cache.c b/read-cache.c
index 7b1354d759..6b912225d5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -757,6 +757,17 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 			discard_cache_entry(ce);
 			return error("unable to index file %s", path);
 		}
+		if (flags & ADD_CACHE_KEEP_CE_MATCHED) {
+			struct cache_entry *ent;
+			int pos = index_name_pos(istate, path, namelen);
+
+			ent = (0 <= pos) ? istate->cache[pos] : NULL;
+			if (ent && ent->ce_flags & CE_MATCHED &&
+			    oidcmp(&ent->oid, &ce->oid)) {
+				discard_cache_entry(ce);
+				return error(_("clobbering '%s' is not allowed"), path);
+			}
+		}
 	} else
 		set_object_name_for_intent_to_add_entry(ce);
 
diff --git a/t/t2201-add-update-typechange.sh b/t/t2201-add-update-typechange.sh
index a4eec0a346..99bf3264bf 100755
--- a/t/t2201-add-update-typechange.sh
+++ b/t/t2201-add-update-typechange.sh
@@ -136,7 +136,7 @@ test_expect_success 'commit -a' '
 		rm -f ".git/index" &&
 		mv ".git/saved-index" ".git/index"
 	fi &&
-	git commit -m "second" -a &&
+	git commit --clobber-index -m "second" -a &&
 	git ls-files -s >actual &&
 	test_cmp expect-final actual &&
 	rm -f .git/index &&
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 35fc8b5c2a..e85789b95a 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -616,7 +616,7 @@ test_expect_success 'check staged with space before tab in indent (diff-index)'
 
 test_expect_success 'check with no whitespace errors (diff-tree)' '
 	echo "foo();" >x &&
-	git commit -m "new commit" x &&
+	git commit --clobber-index -m "new commit" x &&
 	git diff-tree --check HEAD^ HEAD
 '
 
diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
index 97be0d968d..dcb773edf4 100755
--- a/t/t7102-reset.sh
+++ b/t/t7102-reset.sh
@@ -223,7 +223,7 @@ EOF
 test_expect_success \
 	'changing files and redo the last commit should succeed' '
 	echo "3rd line 2nd file" >>secondfile &&
-	git commit -a -C ORIG_HEAD &&
+	git commit --clobber-index -a -C ORIG_HEAD &&
 	head4=$(git rev-parse --verify HEAD) &&
 	check_changes $head4 &&
 	test "$(git rev-parse ORIG_HEAD)" = \
diff --git a/t/t7500-commit.sh b/t/t7500-commit.sh
index 170b4810e0..6864c396d3 100755
--- a/t/t7500-commit.sh
+++ b/t/t7500-commit.sh
@@ -174,7 +174,7 @@ EOF
 
 test_expect_success '--signoff' '
 	echo "yet another content *narf*" >> foo &&
-	echo "zort" | git commit -s -F - foo &&
+	echo "zort" | git commit --clobber-index -s -F - foo &&
 	git cat-file commit HEAD | sed "1,/^\$/d" > output &&
 	test_cmp expect output
 '
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index ca4a740da0..c4f2423ec3 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -93,7 +93,7 @@ test_expect_success 'the basics' '
 	echo update added "commit is" file >"commit is" &&
 	echo also update another >not/forbid &&
 	test_tick &&
-	git commit -a -m "initial with -a" &&
+	git commit --clobber-index -a -m "initial with -a" &&
 
 	git cat-file blob HEAD:"commit is" >current.1 &&
 	git cat-file blob HEAD:not/forbid >current.2 &&
@@ -188,7 +188,7 @@ test_expect_success 'prepare file with comment line and trailing newlines'  '
 test_expect_success 'cleanup commit messages (verbatim option,-t)' '
 
 	echo >>negative &&
-	git commit --cleanup=verbatim --no-status -t expect -a &&
+	git commit --cleanup=verbatim --no-status -t expect -a --clobber-index &&
 	git cat-file -p HEAD |sed -e "1,/^\$/d" >actual &&
 	test_cmp expect actual
 
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 6a392e87bc..c7aeccec96 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -480,7 +480,7 @@ test_expect_success 'avoid uninteresting refs' '
 	git tag v1.0 &&
 	git branch uninteresting &&
 	echo bump > file &&
-	git commit -a -m bump &&
+	git commit --clobber-index -a -m bump &&
 	git fast-export --import-marks=tmp-marks \
 		--export-marks=tmp-marks ^uninteresting ^v1.0 master > actual &&
 	test_cmp expected actual
-- 
2.19.0.rc0.337.ge906d732e7

