Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567072;
	b=ikgvLc0NCf/hOdjARmfyvhQb4cESEEY6v5LMzAuW81uFpYh7kjNVLgHhejMTIVVsY9ZD
	 zTHrh54JbbA874y13HHQf3GISPJz9vPZhN1z4Tdja83EWH7vMmu+g3H1aD0aDjypDxT5e
	 O6BnHCNlhRCuZfuzjwv0JcXVc9RMtiNG5jwh8v5ObopDUnjPYS3O4pSuQuyn1ajXFzfsf
	 T9yiAhKafnHCqvwmYtkN6t0V8ev0tFpVnIOzz5KZ/h+bPgbc/3kO/UCvyJADUakadBdJV
	 KK66UHIVmFNrLNao4HZdFAfd3cX9hIsBHwfCVX8bolTEkegfRaNKljQaG+rsrdWcYdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=PUy4flu6ru8aJbafrsR7/Yf16OS9VBSmcL2bYnpnZtA=;
	b=X4icPK+7zL6WawS/QV5HHYEm6s9GZoMWCkEQ9ReRLhwLhqWn53fD308eE2NW/vp7gMRt
	 jZB6U4xxRxOLztXbB4Jv4CrSXOyLSCAPOab36xkBVVn1FVGE4sYBFXuH0agb6NbmQbDvs
	 sO2Q5d7bY0jT/xpUQWoITon97j1EHAqAIsfMBtISPJ2lVWkGz4FfFt+p63WOCUkzVyWEJ
	 fmAqPj0pYyZC5vcZOe31EiQGLkBw836WO8S6B64+cTKlrci8mNq03SxTBjBYKcz+kjt3s
	 KQ/EzUcUgZxF1RNaK1GbhDyWKcL/ar/E06ntHM2Dld8SFMEzUm3diys5iwPq/pYqNog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GWCwHviG;
	arc=none smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AFB606A31C
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60AFB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GWCwHviG
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4c5d8c7f326so166944b6e.1
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792567070; x=1793171870; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PUy4flu6ru8aJbafrsR7/Yf16OS9VBSmcL2bYnpnZtA=;
        b=GWCwHviGQZG9MTJQVC9sBr9sly7T+8X3QSX58a70ESSkuMnrecONrgvVs6IiKyYy5N
         nPP7tv76qCsuohNIm+K8D04ReKQic0FwH3IrzdO9zEmv7VU0fmlQljL8ELscJdksOPi4
         ftdz3upwduT3eXmcpWyiexbF+85lrmKs3Wx/UgHFV8zQ81HNS4RRM+TO2z/5Vv0MJb49
         LM1ocOb7TbupGaZqm9y6qR1MEexhvtc0HxFmN9RzONMNT4wQAr8PKOV7XE+dtPl2pv+G
         IVActYp4q2KXUNycityMNzfupH0GHMI3VhPWCi0szcqxkVgJhnrZyDhUkXvZ3weDr2QA
         7Bmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792567070; x=1793171870;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PUy4flu6ru8aJbafrsR7/Yf16OS9VBSmcL2bYnpnZtA=;
        b=iZeyXlJwBiSYIQgvvA4/aP6uun+6AhM+jw0Az1KTXr1vdnhbjoLMLTxm3NVbJpSHvM
         E/G7O/j54uPOpbfRzDvDKLC/jYfQjU5l7C74aCVZ3bXKfWgFjJ0p/jqjdZDuIlqzvYWK
         9fhf5SWmG28hOdIhvsknKY6idI3ove28B+qXaOGjAGeDqZQNC64rspoBoXgFV6tUg44i
         uzGI5FafmEcSQXoxOhGF39Qa+r2nLMMaaQrlHJr5i22NS4vPdpABFHVubPJeVzL/S/6U
         AzZtO1FTd9l5YYk2zEkXinr9lfFYxcrSmzATKhtevil2nYpDvIPXabdjBPFt7gKDJolk
         eBGw==
X-Gm-Message-State: AFq9FYLI4LWVEPkyhAaQCCSjsDKe/JUirl4TOxtcdnqjOJDf3XnQ3O5Q
	HLhzmf88DgUW7mOWFBIrPWhXOTURodERy15+mhNBjmpScok6v/ypF5NnflxXew==
X-Gm-Gg: AYBFou14N2wdyeCRPBWe7MgcpmsSqdIIDVuEonufPqCPWaC/48kXe2qna3nRCfe9LDw
	vudWWtRSQqCSvPbD+Xv9Edsdi6mg8RNVcbRQhlnJb1koBYD5vOyOOrJswSbtj1qviRnbK2cucoI
	9M5DTsnSp/IQeoo/4qtqXBC7XdFK1ypw5LwiZ08XJbI9ojKy3rTv1AN0BBG7qHGmtdKUjxu3Z0D
	08vZH1YxHpQqUcHQ0cSk8Cf95uWhNKJBLHGYYOZbzeCudcJMhDCoOxcH2pwzTBVaad35dSURgoT
	po1b3JKNJmR8qUvyqwmgF8OqAS/l6Czy2T93Swfi7xwf7JrLfXb2zSqn2ptiNeRLVnSqYrH/1N8
	N/VUjP4/FBUhRTQY4wDUQw+ihwA/QadBPorzIuKMv3HGiWF6GoLh4PXdjZXZyi7z1uk6+Cu3SGd
	onh+tcOr9mTL1eSSLR4hDid27i+zqLUwuFyH7fix9BzqZYiFm5LjrLfCMy9cTpblwZgcoQwvnwu
	PI3iK1eF/8EKumhtxWDPT6lEGQYQP1DPiqXkg9D8LC2LNMYlAIjICcEEc+Z
X-Received: by 2002:a05:6808:c3cb:b0:496:34a:d7e3 with SMTP id 5614622812f47-55356fffeacmr731198b6e.17.1792567070048;
        Wed, 21 Oct 2026 00:17:50 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.140.214])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-552b583fd57sm1323669b6e.8.2026.10.21.00.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:17:48 -0700 (PDT)
Message-Id: <042485f0e9cd8cf1765b811ea7334247aec44971.1792567061.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
	<pull.2317.v3.git.git.1792567061.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 07:17:39 +0000
Subject: [PATCH v3 2/4] worktree: reap ephemeral branches created by "worktree
 add"
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Jason Newton <nevion@gmail.com>,
    Jason Newton <nevion@gmail.com>

From: Jason Newton <nevion@gmail.com>

When "git worktree add <path>" is given no branch to check out, it
auto-creates one named after the path. Such a branch exists only to back
the new worktree, yet it outlives it: removing the worktree leaves the
branch behind, so a fleet of throwaway worktrees fills refs/heads/ with
dead branches that have to be cleaned up by hand.

Treat an auto-created branch as owned by the worktree. Record it in the
worktree's administrative directory (worktrees/<id>/owned-branch) at
creation time -- the one moment we can know for certain the branch is
worktree-private, since we are the one that created it. "git worktree
remove" then deletes the owned branch once the worktree is gone and it
is no longer checked out.

Ownership is recorded only when "worktree add" itself creates the branch
via DWIM auto-naming; a branch named explicitly with -b/-B, or one that
already existed, is never owned and never reaped. Deletion is
unconditional (even for unmerged commits) because an ephemeral branch is
disposable by contract: to keep the work, pass --keep-branch, or anchor
the commits with an ordinary branch beforehand -- a normal branch can
point at the same commits, after which reaping the ephemeral ref loses
nothing. "git branch -m" updates the marker so ownership follows a
rename, and the branch stays ephemeral.

The marker is just another per-worktree administrative file, so older
versions of Git simply ignore it (they keep the branch on removal, as
today).

Signed-off-by: Jason Newton <nevion@gmail.com>
---
 Documentation/git-worktree.adoc | 22 ++++++++--
 builtin/branch.c                | 28 +++++++++++++
 builtin/worktree.c              | 74 ++++++++++++++++++++++++++++++++-
 t/t2400-worktree-add.sh         | 55 ++++++++++++++++++++++++
 t/t3200-branch.sh               |  2 +-
 t/t3400-rebase.sh               |  2 +-
 t/t5516-fetch-push.sh           |  2 +-
 7 files changed, 178 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-worktree.adoc b/Documentation/git-worktree.adoc
index 4264ee753a..99e6e55be4 100644
--- a/Documentation/git-worktree.adoc
+++ b/Documentation/git-worktree.adoc
@@ -15,7 +15,7 @@ git worktree list [-v | --porcelain [-z]]
 git worktree lock [--reason <string>] <worktree>
 git worktree move <worktree> <new-path>
 git worktree prune [-n] [-v] [--expire <expire>]
-git worktree remove [-f] <worktree>
+git worktree remove [-f] [--keep-branch] <worktree>
 git worktree repair [<path>...]
 git worktree unlock <worktree>
 
@@ -40,8 +40,11 @@ In its simplest form, `git worktree add <path>` automatically creates a
 new branch whose name is the final component of _<path>_, which is
 convenient if you plan to work on a new topic. For instance, `git
 worktree add ../hotfix` creates new branch `hotfix` and checks it out at
-path `../hotfix`. To instead work on an existing branch in a new worktree,
-use `git worktree add <path> <branch>`. On the other hand, if you just
+path `../hotfix`. Such an automatically-created branch is _ephemeral_: it
+is owned by the worktree and is deleted again when the worktree is removed
+with `git worktree remove` (see that command and `--keep-branch`). To
+instead work on an existing branch in a new worktree, use
+`git worktree add <path> <branch>`. On the other hand, if you just
 plan to make some experimental changes or do testing without disturbing
 existing development, it is often convenient to create a 'throwaway'
 worktree not associated with any branch. For instance,
@@ -145,6 +148,14 @@ Remove a worktree. Only clean worktrees (no untracked files and no
 modification in tracked files) can be removed. Unclean worktrees or ones
 with submodules can be removed with `--force`. The main worktree cannot be
 removed.
++
+If the worktree owns an _ephemeral_ branch -- one that `git worktree add`
+created itself because no branch was named (the auto-naming case above) --
+that branch is deleted along with the worktree, even if it has unmerged
+commits, since it was created solely to back this worktree. To keep it, use
+`--keep-branch`, or anchor the commits with an ordinary branch
+(`git branch <name>`) beforehand. A branch you named explicitly (`-b`/`-B`)
+or one that existed before the worktree is never deleted.
 
 `repair [<path>...]`::
 
@@ -192,6 +203,11 @@ allows the move to proceed; use `--force` twice if the destination is locked.
 `remove` refuses to remove an unclean worktree unless `--force` is used.
 To remove a locked worktree, specify `--force` twice.
 
+`--keep-branch`::
+	With `remove`, do not delete the worktree's ephemeral (owned) branch;
+	keep it as an ordinary branch. Has no effect on worktrees that do not
+	own a branch.
+
 `-b <new-branch>`::
 `-B <new-branch>`::
 	With `add`, create a new branch named _<new-branch>_ starting at
diff --git a/builtin/branch.c b/builtin/branch.c
index a613148fc7..ca2e25df03 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -607,6 +607,32 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 #define IS_HEAD 1
 #define IS_ORPHAN 2
 
+/*
+ * When a branch that a worktree owns (its ephemeral branch, recorded in
+ * worktrees/<id>/owned-branch) is renamed, update the marker so ownership
+ * follows the new name -- it stays ephemeral.
+ */
+static void rename_owned_branch_markers(struct worktree **worktrees,
+					const char *oldref, const char *newref)
+{
+	for (int i = 0; worktrees[i]; i++) {
+		struct strbuf path = STRBUF_INIT, buf = STRBUF_INIT;
+
+		if (!worktrees[i]->id)
+			continue;	/* the main worktree keeps no marker */
+		repo_common_path_append(the_repository, &path,
+					"worktrees/%s/owned-branch",
+					worktrees[i]->id);
+		if (strbuf_read_file(&buf, path.buf, 64) > 0) {
+			strbuf_trim(&buf);
+			if (!strcmp(buf.buf, oldref))
+				write_file(path.buf, "%s", newref);
+		}
+		strbuf_release(&path);
+		strbuf_release(&buf);
+	}
+}
+
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
 	struct strbuf oldref = STRBUF_INIT, newref = STRBUF_INIT, logmsg = STRBUF_INIT;
@@ -675,6 +701,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	if (!copy && !(oldref_usage & IS_ORPHAN) &&
 	    refs_rename_ref(get_main_ref_store(the_repository), oldref.buf, newref.buf, logmsg.buf))
 		die(_("branch rename failed"));
+	if (!copy && !(oldref_usage & IS_ORPHAN))
+		rename_owned_branch_markers(worktrees, oldref.buf, newref.buf);
 	if (copy && refs_copy_existing_ref(get_main_ref_store(the_repository), oldref.buf, newref.buf, logmsg.buf))
 		die(_("branch copy failed"));
 
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 9d4b51305e..1059429cbb 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -41,7 +41,7 @@
 #define BUILTIN_WORKTREE_PRUNE_USAGE \
 	N_("git worktree prune [-n] [-v] [--expire <expire>]")
 #define BUILTIN_WORKTREE_REMOVE_USAGE \
-	N_("git worktree remove [-f] <worktree>")
+	N_("git worktree remove [-f] [--keep-branch] <worktree>")
 #define BUILTIN_WORKTREE_REPAIR_USAGE \
 	N_("git worktree repair [<path>...]")
 #define BUILTIN_WORKTREE_UNLOCK_USAGE \
@@ -130,8 +130,34 @@ struct add_opts {
 	int relative_paths;
 	int reflink;
 	const char *keep_locked;
+	const char *owned_branch;
 };
 
+/*
+ * An "owned" (ephemeral) branch is one that "git worktree add" created itself
+ * because the user did not name a branch (the DWIM auto-name case). Its
+ * lifetime is bound to the worktree: it is recorded in the worktree's
+ * administrative directory at creation and reaped when the worktree is
+ * removed. A pre-existing branch, or one named explicitly with -b/-B, is never
+ * owned.
+ */
+static char *read_owned_branch(const char *id)
+{
+	struct strbuf path = STRBUF_INIT, buf = STRBUF_INIT;
+	char *ret = NULL;
+
+	repo_common_path_append(the_repository, &path,
+				"worktrees/%s/owned-branch", id);
+	if (strbuf_read_file(&buf, path.buf, 64) > 0) {
+		strbuf_trim(&buf);
+		if (buf.len)
+			ret = strbuf_detach(&buf, NULL);
+	}
+	strbuf_release(&path);
+	strbuf_release(&buf);
+	return ret;
+}
+
 static int show_only;
 static int verbose;
 static int guess_remote;
@@ -771,6 +797,16 @@ static int add_worktree(const char *path, const char *refname,
 	if (the_repository->repository_format_worktree_config)
 		copy_filtered_worktree_config(sb_repo.buf);
 
+	/*
+	 * Record an owned (ephemeral) branch so that "git worktree remove" can
+	 * reap it. Only DWIM-created branches are owned (see read_owned_branch()).
+	 */
+	if (opts->owned_branch) {
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "%s/owned-branch", sb_repo.buf);
+		write_file(sb.buf, "refs/heads/%s", opts->owned_branch);
+	}
+
 	strvec_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	strvec_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
 
@@ -1148,6 +1184,13 @@ static int add(int ac, const char **av, const char *prefix,
 			branch = branch_to_free = s;
 		new_branch = new_branch_to_free;
 
+		/*
+		 * A branch auto-created from the path (the user named no
+		 * branch) is owned by this worktree and reaped on removal.
+		 */
+		if (new_branch_to_free)
+			opts.owned_branch = new_branch_to_free;
+
 		/* DWIM: Infer --orphan when repo has no refs. */
 		opts.orphan = (!s) && dwim_orphan(&opts, !!opt_track, 1);
 	} else if (ac == 2 && new_branch) {
@@ -1651,15 +1694,19 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
 			   struct repository *repo UNUSED)
 {
 	int force = 0;
+	int keep_branch = 0;
 	struct option options[] = {
 		OPT__FORCE(&force,
 			 N_("force removal even if worktree is dirty or locked"),
 			 PARSE_OPT_NOCOMPLETE),
+		OPT_BOOL(0, "keep-branch", &keep_branch,
+			 N_("keep the worktree's owned (ephemeral) branch")),
 		OPT_END()
 	};
 	struct worktree **worktrees, *wt;
 	struct strbuf errmsg = STRBUF_INIT;
 	const char *reason = NULL;
+	char *owned = NULL;
 	int ret = 0;
 
 	ac = parse_options(ac, av, prefix, options, git_worktree_remove_usage, 0);
@@ -1685,6 +1732,10 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
 		    errmsg.buf);
 	strbuf_release(&errmsg);
 
+	/* read the owned-branch marker before the admin dir is deleted */
+	if (!keep_branch)
+		owned = read_owned_branch(wt->id);
+
 	if (file_exists(wt->path)) {
 		if (!force)
 			check_clean_worktree(wt, av[0]);
@@ -1698,6 +1749,27 @@ static int remove_worktree(int ac, const char **av, const char *prefix,
 	ret |= delete_git_dir(wt->id);
 	delete_worktrees_dir_if_empty();
 
+	/*
+	 * Reap the worktree's owned (ephemeral) branch now that the worktree
+	 * is gone and the branch is no longer checked out. This is
+	 * unconditional by design: the branch was created for this worktree
+	 * and is disposable. To keep the work, anchor it with an ordinary
+	 * branch (or pass --keep-branch) before removing the worktree.
+	 */
+	if (owned) {
+		struct ref_store *refs = get_main_ref_store(the_repository);
+		if (refs_ref_exists(refs, owned)) {
+			if (refs_delete_ref(refs, NULL, owned, NULL, 0))
+				ret = error(_("failed to reap branch '%s'"), owned);
+			else {
+				const char *name = owned;
+				skip_prefix(owned, "refs/heads/", &name);
+				fprintf_ln(stderr, _("Removed branch '%s'"), name);
+			}
+		}
+		free(owned);
+	}
+
 	free_worktrees(worktrees);
 	return ret;
 }
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 4aa63c5d3f..14bf455736 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1384,4 +1384,59 @@ test_expect_success REFLINK '--reflink carries untracked files and reconciles ch
 	)
 '
 
+test_expect_success 'ephemeral: DWIM-created branch is owned and reaped on remove' '
+	test_when_finished "git worktree remove -f eph || :; git branch -D eph 2>/dev/null || :" &&
+	git worktree add eph &&
+	echo refs/heads/eph >expect &&
+	test_cmp expect .git/worktrees/eph/owned-branch &&
+	git rev-parse --verify refs/heads/eph &&
+	git worktree remove eph &&
+	test_must_fail git rev-parse --verify --quiet refs/heads/eph
+'
+
+test_expect_success 'ephemeral: -b branch is not owned and is kept on remove' '
+	test_when_finished "git worktree remove -f nb || :; git branch -D named 2>/dev/null || :" &&
+	git worktree add -b named nb &&
+	test_path_is_missing .git/worktrees/nb/owned-branch &&
+	git worktree remove nb &&
+	git rev-parse --verify refs/heads/named
+'
+
+test_expect_success 'ephemeral: pre-existing branch is not owned' '
+	test_when_finished "git worktree remove -f pe || :; git branch -D pre 2>/dev/null || :" &&
+	git branch pre &&
+	git worktree add pe pre &&
+	test_path_is_missing .git/worktrees/pe/owned-branch &&
+	git worktree remove pe &&
+	git rev-parse --verify refs/heads/pre
+'
+
+test_expect_success 'ephemeral: --keep-branch keeps an owned branch' '
+	test_when_finished "git branch -D keepme 2>/dev/null || :" &&
+	git worktree add keepme &&
+	git worktree remove --keep-branch keepme &&
+	git rev-parse --verify refs/heads/keepme
+'
+
+test_expect_success 'ephemeral: branch -m follows the marker and stays ephemeral' '
+	test_when_finished "git worktree remove -f mv || :; git branch -D mv2 2>/dev/null || :" &&
+	git worktree add mv &&
+	git -C mv branch -m mv mv2 &&
+	echo refs/heads/mv2 >expect &&
+	test_cmp expect .git/worktrees/mv/owned-branch &&
+	git worktree remove mv &&
+	test_must_fail git rev-parse --verify --quiet refs/heads/mv2
+'
+
+test_expect_success 'ephemeral: commits survive the reap when anchored by a normal branch' '
+	test_when_finished "git worktree remove -f anc || :; git branch -D anchored 2>/dev/null || :" &&
+	git worktree add anc &&
+	test_commit -C anc agentwork &&
+	tip=$(git -C anc rev-parse HEAD) &&
+	git branch anchored "$tip" &&
+	git worktree remove anc &&
+	test_must_fail git rev-parse --verify --quiet refs/heads/anc &&
+	test "$(git rev-parse anchored)" = "$tip"
+'
+
 test_done
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index cdb6c6a634..67c7c67853 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -190,7 +190,7 @@ test_expect_success 'git branch -M foo bar should fail when bar is checked out'
 
 test_expect_success 'git branch -M foo bar should fail when bar is checked out in worktree' '
 	git branch -f bar &&
-	test_when_finished "git worktree remove wt && git branch -D wt" &&
+	test_when_finished "git worktree remove --keep-branch wt && git branch -D wt" &&
 	git worktree add wt &&
 	test_must_fail git branch -M bar wt
 '
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index accaaba4d4..9c0c80f113 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -471,7 +471,7 @@ test_expect_success 'git rebase --update-ref with core.commentChar and branch on
 	test_when_finished git branch -D base topic2 &&
 	test_when_finished git checkout main &&
 	test_when_finished git branch -D wt-topic &&
-	test_when_finished git worktree remove wt-topic &&
+	test_when_finished git worktree remove --keep-branch wt-topic &&
 	git checkout main &&
 	git checkout -b base &&
 	git checkout -b topic2 &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b982b209bf..6ffeb064fa 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1873,7 +1873,7 @@ test_expect_success 'updateInstead with bare repository worktree and unborn bare
 '
 
 test_expect_success 'refuse fetch to current branch of worktree' '
-	test_when_finished "git worktree remove --force wt && git branch -D wt" &&
+	test_when_finished "git worktree remove --force --keep-branch wt && git branch -D wt" &&
 	git worktree add wt &&
 	test_commit apple &&
 	test_must_fail git fetch . HEAD:wt &&
-- 
gitgitgadget

