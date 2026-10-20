Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512255;
	b=Z2F2c4b7nOndgYbMvr+uFhYcKrWTUmOBpQJrMEqtVEZWLbeXtZepiS4KklBL77mnv1Xj
	 2t/OeWH+/jjMKuEbl5Zt56mMdk5McGTJpffbvazKlchl/Y7NPcxmGQWnlGyhSU0e2YYwe
	 OCo5Ui4hDRPs/Otbxv804uH0YyVVb9jEsHso02wgIRrYKBbqGExxxmdWw8F4GjE2tV76t
	 kEBRnm486IYlfQhfCo/9Ta+CvWCqC+3G9EJy/72vca3y6/PDL063KF/YDV5vRvdX2V0uD
	 YDzxg3YAPTRIHedmIFPOSDTRoZXmg8hCGp+/nMdhX4OWfdG5VY3SOnUYqiHye2xqyKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=MD3kFXqb6ekkuQQQxI/R0THchr/ZUHZhzsI8RB2vfCU=;
	b=rHLxonxXQjHZKSErnwDdVt6uqKbrrFerWo7AFcmYxYTRSFZXpE+csNy8THLn5EG5j82+
	 Y0tOy6HDn0gwdfWju8vxpwRspsVzf+kRULCWP1t/8KwNmuTC5aurEtQySbI3R0uirtlpw
	 Hm+ALVBXiCtrM1ASA13WbYlz40BKWVRSpsOnmnlhwFhrMiNT+BvTJPAmrX0c5DQWcjfW7
	 5+D2vco9jv/jNxPOyxzhxt3PpFqYAJv99P0svtbvzvnCpA8QHU7t7hkJA9VCzBIAs8ZWK
	 hWqW4VD704Imz5+e9ztQuJ0WfXHPnHUK4VvFnAV2ip4K8nbx3GvNbdyU2GqPCqyfxgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hsb4C27T;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C829C606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 16:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C829C606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hsb4C27T
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3282db206d3so6163286eec.0
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 09:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792512254; x=1793117054; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MD3kFXqb6ekkuQQQxI/R0THchr/ZUHZhzsI8RB2vfCU=;
        b=hsb4C27TtSJO1KhbLmN3rMIN4kYoRPUiE5niTHXcx7liS7ow39Br69wpTZ98cYY1M6
         2lBsHFxGD+8lOqbJkAYAWgcD7pidL0AkYblnWZOiSsjZfabAfyzgRQzd6B8QxSC32vbd
         30q/kAEcfMROe9JX28kDhvJIFAZd3uI9X10zo/qsPU0IYhbntY//Hx6xdfn8VWRA5Iut
         GxhEqB6IhMM2QqjuS4ps51v2qsop4sWDRPiRfTnuWYUyDQg/lr7AcQuvbkK5yeNT/qWK
         4A19jXpVUqyyuwSofMhE62fEiUHRJRtEA2a68S9mjm2ZMVi2kBhKVC0uKUJEZtfRRBhP
         ehcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792512254; x=1793117054;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MD3kFXqb6ekkuQQQxI/R0THchr/ZUHZhzsI8RB2vfCU=;
        b=l+53if/wvU8fJn/yP9dKlBkXn/NK6ZIHsluF7+cYyRIR6rhA3g9ypcw1+4azrH2yvq
         yTFamI65vOMcy5IAmmHIhv1U6vidZ/EgnEnLzWdx4Y+XH6u7U+IUmAAFzvtosiIQ1XpO
         +OOs576DCnYeoqNQF4DgY4JSkafDTRkN+OMBJHEwel4B8SxGVro3PEEX1zo5M94w/6xW
         /V0G8oa7419ekh+LNbw8RYXzOJNUMeNAPZ2cAorwuYG5ejcxprcYmM+D0r21zdTlk5i2
         r/mK8gfekcLh0VfjQxslwMktjrBLCBJgqEz3a2GIbgf9R9hQ+TCynnCF9ayPPs8678qQ
         XFnw==
X-Gm-Message-State: AFq9FYIwMfbUa2ZWuWOvYzM5Juy8V58UtNjHnbnbwmatCqGUmsJ6u84N
	hyJYRczWuUwZ4yu3gQ3OWsslXfxjgrzVxKFWnpmubL6unQChYMavfUdJ1Sl3sA==
X-Gm-Gg: AYBFou2EK/NOlIlD156jrzYkjnX0EAnarh+BDGIkz1q76o6s9V4fj/LpKZg4rxhGKhI
	Y9n/B9+bRH+cXboqWi4b2K3TtMJ38g0+CiROPNllI67pi1l/SNzuTXgJ9o/Vh19dePDtuFTmQM9
	MIZ2jYS5zambTaWfVWQu9YBSWV/mro00RnpqaerEbitiId9nNiPag9R2xwEF99tpeJdJ0I67qO5
	EoC3RtXtS4UpsM5TMD+Hztw1eS2W/bnMklU/IPjwo4wuLE52GawnbJS8vPCTetp0bDIaXaLTIdU
	rRScFRtbimFt/FQ3znPEOht6pruUc+sYbX62chZuvu9ZmruCY6BNAk/0SF3KGDN+VKX8VZ5LudO
	n6B+UUrPuatZK9gZ9hZCzpN1Ux8LPUL0FKjt+umOFx/GYRqoSZ7WPUT/2+b04sJneMSzuB4FcKs
	Hea0vC0Vb8hRQnVWj5kch3nGr31PwjDpGUopcqTG5Y1trBDk1FvFS/IJC7jP4uFHcu5CCng3gJ2
	8qCg+v2tA==
X-Received: by 2002:a05:7300:e9c9:20b0:359:6382:5e52 with SMTP id 5a478bee46e88-361a2053878mr17845176eec.17.1792512253448;
        Tue, 20 Oct 2026 09:04:13 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.71.72])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082f7f6e0sm47124192eec.27.2026.10.20.09.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 09:04:12 -0700 (PDT)
Message-Id: <6e2acdc5e2578da4e915fd2ac541a776349fb23e.1792512249.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com>
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
	<pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com>
From: "Jason Newton via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 20 Oct 2026 16:04:09 +0000
Subject: [PATCH v2 2/2] worktree: reap ephemeral branches created by "worktree
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
index 4f62360a78..d083a871eb 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1376,4 +1376,59 @@ test_expect_success REFLINK '--reflink carries untracked files and reconciles ch
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
