Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6241D5CC6
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773573557; cv=none; b=UurgECFSNZfdrZ/Zn7VpuQG9BbetgKAEEBgafQJ/6Ep2oEO/ey/cxEAusdt8GhFqMF8KAfEmYIyIm/YXjLxoagAQVbUFOjHqj2Oe6qlyQaRQjQrKafs3qFT9ofNl4FXBLiUJYpUTvR0xJDtBReXykSi94GEdrmq67AiMXtaqEEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773573557; c=relaxed/simple;
	bh=3pwwIwK7KwFWwCM/PN4/4IjOV9q2OOfXLFqkwqDlI2s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=IaoU4eGmvU+scxcIlJFJmwsK9zOVBBMbbyOWd5Z3N5wObVY2FHUlzK23BNqxAIrQo4LqvRCGuDrx+/4aia6PceOV3N9n8RMfjQGmDLHJI+bbMroqGQLenFU4BYG+StIg0Ley4KLcIXFdl39+hwRZQzl9WP9pmwS3ASS5fYLhEQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiKRQe9M; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiKRQe9M"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2c0bcd8f194so441445eec.1
        for <git@vger.kernel.org>; Sun, 15 Mar 2026 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773573555; x=1774178355; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfrcaOcAPAuxlqMX56ZJ4gIup8pT6bOgld5jWlpLg2M=;
        b=kiKRQe9MwJInKQLU/tyvScb6b6I0d2Eq4GC0GMU5OKUeCDgAr2cZ/tXDE+drmEFqmC
         VgdtYtJ+0q+K9Zc3VWRMKYHs2yhxwIrcSD4VQtUgU4aYaKkS/LFDXxAb88nud96rqtM7
         l4EUmRQCBr/LhWI5XyAlm+qy4H5MRAK76Zte6LYwY7HLf5lexgHDObniQNIXOAGDuQKh
         uDq+QZjO7vfvqX1dBVw0h0ooQQCyI71FVusG6YbCQJwKEmpJz9vRe2pQMYgWr7jCsLLH
         RtDdJc6VUNL6V5EesfT5T1SBRvJ2M/2+JnGkdiW8HPtCABJW8MDdGUjAJjteY56Wzm8q
         LGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773573555; x=1774178355;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pfrcaOcAPAuxlqMX56ZJ4gIup8pT6bOgld5jWlpLg2M=;
        b=NqJy8WEjKRFUIhGUujdvjnFkniWIMpjiuOEMIYQnQY3t2buyLZzXjemylsPmjyYx62
         ofAopQARZxGMmPAB5TgqKE8eqLrLKHCfjm93ckdxWHOB+tmEcf6dQ9RA8RATY2sDUx7E
         K0WmwyRV7F7EX3M5xHehHlYcI8GFAD9UIprADh2XAjh8dRww8Mko8YEYYvchNDgok6N6
         eGi4lmBH+IAedXsVYpHvNFzpEbJFbbePPMw2eOSiilpl3kymeMzo8+3iA0RA1PBbgfds
         4BlJuRmm3af4eGRKanZ+hLem7b4tgNlc6rRz7FKM5pBMpGCjlkikwa6Qc7fLha9ytKze
         k2gg==
X-Gm-Message-State: AOJu0YwtcxejWDwWcr6C8MVliw8Lp2PolYq+6fma0BSnBGyOdbQPnGFX
	JCBHJbElssP/2sJLcc21fj0rbenzlSMEmr8HfVJMfVlSlrzbQCeVdW8E7Lxz8w==
X-Gm-Gg: ATEYQzw0I2f5H3tRw6HmkYTwYGlxo7+YyM/JfCTPVwY5HZLSzvz9jhSydQbsKP6aebw
	AXjI4J7fdFiEPaLr2YkHthB1NhnL0gx4tH/WT1Wse35yCwKGvxX2vngCV1Fv9zaVLulHnqWYZui
	O+h0mPSyV1YCLGvy2nTPRWqtC1gp/78SGF4EnuFhIi45TYdkrO3jnzmW99wg9UmaOituCK/rAsy
	EZFrH8OOxZYORF0oY84vG9v3K9nG6Vh4iBsOp54rNqsy0IbkfywJLprFvKHXqRzjGay78DS22iy
	lmGM9TQxwWcaj5ZviwSDMA+VEkMBenIen5nJMz2hPfztx+h8x/PCVCfOFyHPVo5Jsrs4EgwBCHP
	q1Yl9I4wzuIj9apWXiaizk8sJXmxEVr0BLLzz0yCGJZibPMu4FuESfRc0humPGbpoUY40/0gc6L
	FFB6NAXsAaEGO9iFNZaa672HzUX/Q=
X-Received: by 2002:a05:7300:7b90:b0:2ba:a60a:15ef with SMTP id 5a478bee46e88-2bea54500e2mr3913813eec.1.1773573554728;
        Sun, 15 Mar 2026 04:19:14 -0700 (PDT)
Received: from [127.0.0.1] ([172.215.216.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3eec52sm11577557eec.14.2026.03.15.04.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 04:19:14 -0700 (PDT)
Message-Id: <pull.2234.v5.git.git.1773573553.gitgitgadget@gmail.com>
In-Reply-To: <pull.2234.v4.git.git.1773482375668.gitgitgadget@gmail.com>
References: <pull.2234.v4.git.git.1773482375668.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 15 Mar 2026 11:19:09 +0000
Subject: [PATCH v5 0/4] checkout: 'autostash' for branch switching
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

cc: Phillip Wood phillip.wood123@gmail.com

Harald Nordgren (4):
  stash: add --ours-label, --theirs-label, --base-label for apply
  sequencer: allow create_autostash to run silently
  sequencer: teach autostash apply to take optional conflict marker
    labels
  checkout: -m (--merge) uses autostash when switching branches

 Documentation/git-checkout.adoc |  58 +++++-----
 Documentation/git-stash.adoc    |  11 +-
 Documentation/git-switch.adoc   |  27 ++---
 builtin/checkout.c              | 180 ++++++++++++++++++--------------
 builtin/stash.c                 |  32 ++++--
 sequencer.c                     |  67 +++++++++---
 sequencer.h                     |   4 +
 t/t3420-rebase-autostash.sh     |  24 +++--
 t/t3903-stash.sh                |  18 ++++
 t/t7201-co.sh                   | 160 ++++++++++++++++++++++++++++
 t/t7600-merge.sh                |   2 +-
 xdiff-interface.c               |  12 +++
 xdiff-interface.h               |   1 +
 13 files changed, 447 insertions(+), 149 deletions(-)


base-commit: dc6ecd5354dca88d51b6d6562777fc8fc10d77e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2234%2FHaraldNordgren%2Fcheckout_autostash-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2234/HaraldNordgren/checkout_autostash-v5
Pull-Request: https://github.com/git/git/pull/2234

Range-diff vs v4:

 -:  ---------- > 1:  00d8920498 stash: add --ours-label, --theirs-label, --base-label for apply
 -:  ---------- > 2:  5d176f1700 sequencer: allow create_autostash to run silently
 -:  ---------- > 3:  3d6829438a sequencer: teach autostash apply to take optional conflict marker labels
 1:  5d49c0031a ! 4:  7f3735d40e checkout: -m (--merge) uses autostash when switching branches
     @@ Documentation/git-checkout.adoc: working tree, by copying them from elsewhere, e
      +	afterwards.  If the local changes do not overlap with the
      +	differences between branches, the switch proceeds without
      +	stashing.  If reapplying the stash results in conflicts, the
     -+	entry is saved to the stash list so you can use `git stash
     -+	pop` to recover and `git stash drop` when done.
     ++	entry is saved to the stash list.  Resolve the conflicts
     ++	and run `git stash drop` when done, or clear the working
     ++	tree (e.g. with `git reset --hard`) before running `git stash
     ++	pop` later to re-apply your changes.
       +
       When checking out paths from the index, this option lets you recreate
       the conflicted merge in the specified paths.  This option cannot be
     @@ Documentation/git-checkout.adoc: $ git checkout mytopic
       
      -You can give the `-m` flag to the command, which would try a
      -three-way merge:
     -+You can give the `-m` flag to the command, which would save the local
     -+changes in a stash entry and reset the working tree to allow switching:
     ++You can give the `-m` flag to the command, which would carry your local
     ++changes to the new branch:
       
       ------------
       $ git checkout -m mytopic
      -Auto-merging frotz
     -+Applied autostash.
     ++Switched to branch 'mytopic'
       ------------
       
      -After this three-way merge, the local modifications are _not_
     @@ Documentation/git-switch.adoc: variable.
      +	local changes do not overlap with the differences between
      +	branches, the switch proceeds without stashing.  If
      +	reapplying the stash results in conflicts, the entry is
     -+	saved to the stash list so you can use `git stash pop` to
     -+	recover and `git stash drop` when done.
     ++	saved to the stash list.  Resolve the conflicts and run
     ++	`git stash drop` when done, or clear the working tree
     ++	(e.g. with `git reset --hard`) before running `git stash pop`
     ++	later to re-apply your changes.
       
       `--conflict=<style>`::
       	The same as `--merge` option above, but changes the way the
     @@ Documentation/git-switch.adoc: $ git switch mytopic
       
      -You can give the `-m` flag to the command, which would try a three-way
      -merge:
     -+You can give the `-m` flag to the command, which would save the local
     -+changes in a stash entry and reset the working tree to allow switching:
     ++You can give the `-m` flag to the command, which would carry your local
     ++changes to the new branch:
       
       ------------
       $ git switch -m mytopic
      -Auto-merging frotz
     -+Created autostash: 7a9afa3
     -+Applied autostash.
     ++Switched to branch 'mytopic'
       ------------
       
      -After this three-way merge, the local modifications are _not_
     @@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *op
       	}
       
       	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
     -@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
     - 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
     - 		die(_("unable to write new index file"));
     - 
     --	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
     --		show_local_changes(&new_branch_info->commit->object, &opts->diff_options);
     --
     - 	return 0;
     - }
     - 
      @@ builtin/checkout.c: static void orphaned_commit_warning(struct commit *old_commit, struct commit *ne
       	release_revisions(&revs);
       }
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
       	struct object_id rev;
       	int flag, writeout_error = 0;
       	int do_merge = 1;
     ++	int created_autostash = 0;
      +	struct strbuf old_commit_shortname = STRBUF_INIT;
      +	const char *stash_label_ancestor = NULL;
       
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +		if (repo_read_index(the_repository) < 0)
      +			die(_("index file corrupt"));
      +		if (checkout_would_clobber_changes(&old_branch_info,
     -+						   new_branch_info))
     ++						   new_branch_info)) {
      +			create_autostash_ref_silent(the_repository,
      +						   "CHECKOUT_AUTOSTASH");
     ++			created_autostash = 1;
     ++		}
      +	}
      +
       	if (do_merge) {
     @@ builtin/checkout.c: static int switch_branches(const struct checkout_opts *opts,
      +	if (repo_read_index(the_repository) < 0)
      +		die(_("index file corrupt"));
      +
     -+	if (!opts->discard_changes && !opts->quiet && new_branch_info->commit)
     ++	if (created_autostash && !opts->discard_changes && !opts->quiet &&
     ++	    new_branch_info->commit)
      +		show_local_changes(&new_branch_info->commit->object,
      +				   &opts->diff_options);
      +
     @@ builtin/stash.c: static int apply_stash(int argc, const char **argv, const char
       	return ret;
      
       ## sequencer.c ##
     -@@ sequencer.c: static enum todo_command peek_command(struct todo_list *todo_list, int offset)
     - 
     - static void create_autostash_internal(struct repository *r,
     - 				      const char *path,
     --				      const char *refname)
     -+				      const char *refname,
     -+				      int silent)
     - {
     - 	struct strbuf buf = STRBUF_INIT;
     - 	struct lock_file lock_file = LOCK_INIT;
     -@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     - 					&oid, null_oid(the_hash_algo), 0, UPDATE_REFS_DIE_ON_ERR);
     - 		}
     - 
     --		printf(_("Created autostash: %s\n"), buf.buf);
     -+		if (!silent)
     -+			fprintf(stderr, _("Created autostash: %s\n"), buf.buf);
     - 		if (reset_head(r, &ropts) < 0)
     - 			die(_("could not reset --hard"));
     - 		discard_index(r->index);
     -@@ sequencer.c: static void create_autostash_internal(struct repository *r,
     - 
     - void create_autostash(struct repository *r, const char *path)
     - {
     --	create_autostash_internal(r, path, NULL);
     -+	create_autostash_internal(r, path, NULL, 0);
     - }
     - 
     - void create_autostash_ref(struct repository *r, const char *refname)
     - {
     --	create_autostash_internal(r, NULL, refname);
     -+	create_autostash_internal(r, NULL, refname, 0);
     - }
     - 
     --static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     -+void create_autostash_ref_silent(struct repository *r, const char *refname)
     -+{
     -+	create_autostash_internal(r, NULL, refname, 1);
     -+}
     -+
     -+static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
     -+				    const char *label1, const char *label2,
     -+				    const char *label_ancestor)
     - {
     - 	struct child_process child = CHILD_PROCESS_INIT;
     - 	int ret = 0;
     -@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     - 		child.no_stderr = 1;
     - 		strvec_push(&child.args, "stash");
     - 		strvec_push(&child.args, "apply");
     -+		if (label1)
     -+			strvec_pushf(&child.args, "--ours-label=%s", label1);
     -+		if (label2)
     -+			strvec_pushf(&child.args, "--theirs-label=%s", label2);
     -+		if (label_ancestor)
     -+			strvec_pushf(&child.args, "--base-label=%s", label_ancestor);
     - 		strvec_push(&child.args, stash_oid);
     - 		ret = run_command(&child);
     - 	}
     -@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply)
     +@@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int attempt_apply,
       		strvec_push(&store.args, stash_oid);
       		if (run_command(&store))
       			ret = error(_("cannot store %s"), stash_oid);
     @@ sequencer.c: static int apply_save_autostash_oid(const char *stash_oid, int atte
       	}
       
       	return ret;
     -@@ sequencer.c: static int apply_save_autostash(const char *path, int attempt_apply)
     - 	}
     - 	strbuf_trim(&stash_oid);
     - 
     --	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply);
     -+	ret = apply_save_autostash_oid(stash_oid.buf, attempt_apply,
     -+				      NULL, NULL, NULL);
     - 
     - 	unlink(path);
     - 	strbuf_release(&stash_oid);
     -@@ sequencer.c: int apply_autostash(const char *path)
     - 
     - int apply_autostash_oid(const char *stash_oid)
     - {
     --	return apply_save_autostash_oid(stash_oid, 1);
     -+	return apply_save_autostash_oid(stash_oid, 1, NULL, NULL, NULL);
     - }
     - 
     - static int apply_save_autostash_ref(struct repository *r, const char *refname,
     --				    int attempt_apply)
     -+				    int attempt_apply,
     -+				    const char *label1, const char *label2,
     -+				    const char *label_ancestor)
     - {
     - 	struct object_id stash_oid;
     - 	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
     -@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     - 		return error(_("autostash reference is a symref"));
     - 
     - 	oid_to_hex_r(stash_oid_hex, &stash_oid);
     --	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply);
     -+	ret = apply_save_autostash_oid(stash_oid_hex, attempt_apply,
     -+				       label1, label2, label_ancestor);
     - 
     - 	refs_delete_ref(get_main_ref_store(r), "", refname,
     - 			&stash_oid, REF_NO_DEREF);
     -@@ sequencer.c: static int apply_save_autostash_ref(struct repository *r, const char *refname,
     - 
     - int save_autostash_ref(struct repository *r, const char *refname)
     - {
     --	return apply_save_autostash_ref(r, refname, 0);
     -+	return apply_save_autostash_ref(r, refname, 0, NULL, NULL, NULL);
     - }
     - 
     - int apply_autostash_ref(struct repository *r, const char *refname)
     - {
     --	return apply_save_autostash_ref(r, refname, 1);
     -+	return apply_save_autostash_ref(r, refname, 1, NULL, NULL, NULL);
     -+}
     -+
     -+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     -+				    const char *label1, const char *label2,
     -+				    const char *label_ancestor)
     -+{
     -+	return apply_save_autostash_ref(r, refname, 1,
     -+					label1, label2, label_ancestor);
     - }
     - 
     - static int checkout_onto(struct repository *r, struct replay_opts *opts,
     -
     - ## sequencer.h ##
     -@@ sequencer.h: void commit_post_rewrite(struct repository *r,
     - 
     - void create_autostash(struct repository *r, const char *path);
     - void create_autostash_ref(struct repository *r, const char *refname);
     -+void create_autostash_ref_silent(struct repository *r, const char *refname);
     - int save_autostash(const char *path);
     - int save_autostash_ref(struct repository *r, const char *refname);
     - int apply_autostash(const char *path);
     - int apply_autostash_oid(const char *stash_oid);
     - int apply_autostash_ref(struct repository *r, const char *refname);
     -+int apply_autostash_ref_with_labels(struct repository *r, const char *refname,
     -+				    const char *label1, const char *label2,
     -+				    const char *label_ancestor);
     - 
     - #define SUMMARY_INITIAL_COMMIT   (1 << 0)
     - #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
      
       ## t/t3420-rebase-autostash.sh ##
      @@ t/t3420-rebase-autostash.sh: create_expected_failure_apply () {
     @@ t/t7201-co.sh: test_expect_success 'checkout --merge --conflict=diff3 <branch>'
       	git reset --hard &&
      
       ## t/t7600-merge.sh ##
     -@@ t/t7600-merge.sh: test_expect_success 'merge --squash --autostash conflict does not attempt to app
     - 	>unrelated &&
     - 	git add unrelated &&
     - 	test_must_fail git merge --squash c7 --autostash >out 2>err &&
     --	! grep "Applying autostash resulted in conflicts." err &&
     -+	! grep "resulted in conflicts" err &&
     - 	grep "When finished, apply stashed changes with \`git stash pop\`" out
     - '
     - 
      @@ t/t7600-merge.sh: test_expect_success 'merge with conflicted --autostash changes' '
       	git diff >expect &&
       	test_when_finished "test_might_fail git stash drop" &&
       	git merge --autostash c3 2>err &&
      -	test_grep "Applying autostash resulted in conflicts." err &&
     -+	test_grep "resulted in conflicts" err &&
     ++	test_grep "your local changes resulted in conflicts" err &&
       	git show HEAD:file >merge-result &&
       	test_cmp result.1-9 merge-result &&
       	git stash show -p >actual &&

-- 
gitgitgadget
