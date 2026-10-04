Received: from mta237b-ord.mtasv.net (mta237b-ord.mtasv.net [104.245.209.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789EC415F2F
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 23:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791155539; cv=none; b=DdtYfn+mx2Z22QgdXudY27g6F4onBWVrzfGz3jx9RXmycOj0dAjTAq/urdsukOTJxwY+gxeGmKSS0QseujGKeX7FM5cZfEn9w/pUrWxNOi6mWGOJFvSSLI2dKkx4HWi/qYJaaPu8iZCiWRoqdA49AtCIvlHuu2L+OlJanfqr0pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791155539; c=relaxed/simple;
	bh=mCRcyA6T9Tq1AWoWq56msUXuCfm2w5UweqSvsWK7pq8=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EaA+E2kyrp2J7sxZUGSTBzVGIcXkg9bhkoe83Ou4C68QW0UoI2+edvYmkZxeExi4JquKB9M8n2o9of1heIvfvpkDGgHr8aFZPPkoMhUjYzt6hghU49dLfzY7gVR08jn+7wugzNDtrCKmZ9K/w66B/EgkFXkBBayAeOzx6KwbBv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=Jt9KOYG3; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=cibXCYPJ; arc=none smtp.client-ip=104.245.209.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="Jt9KOYG3";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="cibXCYPJ"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=4PNJuZ+wDKWIDmCsSl2at8e2kwMp/xi3tzG4mlVW8hs=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1791155347; x=1791760147;
	b=Jt9KOYG3qskqZDstKMTwjXdLisShh+uBmCDA6dlyw4iQ2EtJF4Qxz70pC01tPeB7tcZm3/IoT
	aEsTvYK+adsw9wxjCZrwnmcVo5OT6WxQEvpqkhoI/8ku/qL+o72WLwQMmwIM4o09gyEnMnJcxVh
	4Es/d4Uc3yUt7wWAWpv+S2KPP71DA+CZzB+XrcYeurttheuaY8uPXjrKDddpKiY74t0iLfrjSai
	p/z8ADjLd4QgPb2PlkDEeDTzWuo8Z3QJ6cn87aFzf/o1TczYvBn4vQ6hocPnKfyFpwMR3bZDpPn
	v5QpE9mgHOMVcFRbXwflbh7h13i9eReFyAQ2fFpzAnTQ==;
Received: from ip-172-26-33-105.us-east-2.compute.internal (172.26.33.105)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.242.207) 
  with ESMTP id 999e56c6c04811f1b5fa02ffcb28d5f1 for <git@vger.kernel.org>;
  Sun, 4 Oct 2026 23:09:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1791155347; x=1791328147;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=4PNJuZ+wDKWIDmCsSl2at8e2kwMp/xi3tzG4mlVW8hs=;
	b=cibXCYPJS5SLNJ9p9Rr2nmYKbnLI7JhUk87OJ93AEvVmQAObguC7PGGdhJuPl0TMXlIy/6WYVtK
	3v/Fpe4JD/CsLFi98XmdJZ6HIVc1Ynd+eb0Sv1yvxMj4m4t1JGJ6u19bqEI7T8zFwH/KFENmwMHdG
	blFQv2pq1DauuMCpBqk=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Sun, 04 Oct 2026 23:09:07 +0000
Subject: [PATCH v3 0/2] worktree: add post-worktree lifecycle hook
Message-Id: <d550ede0-6a33-4eea-a6dd-051d110b68e5@mtasv.net>
Reply-To: domen@cachix.org
To: git@vger.kernel.org
Cc: gitster@pobox.com, cdwhite3@pm.me, phillip.wood123@gmail.com,
 sunshine@sunshineco.com, ps@pks.im, avarab@gmail.com, test35965@gmail.com,
 kristofferhaugsbakk@fastmail.com, maciej.ciemborowicz@gmail.com,
 Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
References: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: d550ede0-6a33-4eea-a6dd-051d110b68e5
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.It8KbzoK3hTg2x79irs2NA.sl09p4wZCLEE_GH3Ca6rwHVSJdtYN5tZIuwjZZTVzauEWgmQRVVd_fDb-jPRaI0zeYvDxbUBowXWIHQ9kA8MRd7hYfvcgfl_ZJLVwD6URHC4MTb5vEuUUtToK5rW-uYlIeM4CDkRLC-PPM-iNtx8r_oGNVA_BuKaAQuT1xZXpU9KqgFmM7GrQCu5_QsjOTcx
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-237
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tools that manage per-worktree development environments need to observe
worktrees created, moved, or removed by other programs. Wrapping git
worktree only helps when every caller uses the wrapper. post-checkout
does not run for add --no-checkout or --orphan, and Git has no lifecycle
notification for moving, removing, or pruning worktrees.

The motivating use case is devenv provisioning and cleaning up processes
and services for worktrees created by an IDE or agent. The creator and
environment manager are separate tools. Ownership identifiers can help
coordinate creators, but do not notify the environment manager about
changes made by another tool or directly by the user.

Add one post-worktree hook with four arguments:

    post-worktree add    <id> ""         <new-path>
    post-worktree move   <id> <old-path> <new-path>
    post-worktree remove <id> <old-path> ""

The hook runs in the invoking repository with the usual hook working
directory and environment. Paths are absolute; empty strings are passed
as arguments for paths that do not apply or cannot be determined during
pruning. The worktree identifier is the name of its administrative entry
under the common Git directory.

The add event runs after post-checkout, even if post-checkout fails, and
also covers --no-checkout and --orphan. Prune emits a remove event per
pruned entry, including duplicates, and none for --dry-run. Hook failures
affect the command exit status without undoing completed operations;
pruning continues to notify the remaining entries after a hook failure.

The first commit adds the hook for add, move, and remove. The second adds
pruning notifications. Both include documentation and regression tests.

Changes since v2:

 * Replace the three separate hook names with the single post-worktree
   interface proposed in the mailing-list discussion.
 * Pass an explicit event, identifier, and both paths for every event,
   instead of using argument count to distinguish operations.
 * Keep the execution context in the invoking repository for all events.
 * Cover configured hooks, paths with spaces, linked and bare callers,
   relative paths, failure status precedence, and continued pruning
   notifications after a hook failure.
 * Rebase onto current master and use its repository argument in
   should_prune_worktree().

Earlier discussion:
https://lore.kernel.org/git/7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net/
https://lore.kernel.org/git/8bd3a684-51a0-4a2a-b70d-3981cfe10e9a@mtasv.net/

AI assistance: the commits retain the original Claude coauthor credit.
Codex assisted with consolidating the interface, adapting the tests,
updating documentation and commit messages, and validating this revision.

Validation:

 * Developer build and test lint passed with DEVELOPER=3D1.
 * All nine hook and worktree suites passed in the final full run. A
   focused run after the interface change passed 489 tests, and the
   lifecycle commit also passed independently (381 tests).
 * git diff --check and the repository clang-format check passed.
 * Trial merges into next and seen apply without conflicts.
 * githooks.html and git-config.html render correctly with Asciidoctor;
   only post-worktree is registered in the generated hook list.
 * The final full local run completed: 1,062 test files, 33,881 tests.
   Four tests failed with a 128 KiB stack: t0003-attributes.sh test 55,
   t6120-describe.sh tests 85-86, and t7004-tag.sh test 212. These are
   the same four failures reproduced on unmodified upstream master at
   8103b446517e0c44e67561b9d0ccce56efa60a71 using the same compiler and
   environment. Optional tests without available prerequisites skipped.
 * All enabled platform CI checks passed, including macOS, Windows,
   Linux variants, Meson, address/undefined-behavior sanitizers, and leak
   checks. CI initially caught a Windows shell/native path mismatch in
   two new working-directory assertions. These now use the path-utils
   test helper; all 289 add/move tests also pass locally after the fix.
   https://github.com/git/git/actions/runs/37239319553

PR and platform checks:
https://github.com/git/git/pull/2442

Domen Ko=C5=BEar (2):
  worktree: add post-worktree lifecycle hook
  worktree: notify post-worktree hook when pruning

 Documentation/config/hook.adoc |   1 +
 Documentation/githooks.adoc    |  46 ++++++++++++
 builtin/worktree.c             | 105 ++++++++++++++++++--------
 t/t2400-worktree-add.sh        | 132 +++++++++++++++++++++++++++++++++
 t/t2401-worktree-prune.sh      | 102 +++++++++++++++++++++++++
 t/t2403-worktree-move.sh       | 113 ++++++++++++++++++++++++++++
 worktree.c                     |   1 -
 worktree.h                     |   6 +-
 8 files changed, 473 insertions(+), 33 deletions(-)

Range-diff against v2:
1:  73e36c179e < -:  ---------- worktree: add post-worktree-add hook
2:  3de87064c0 < -:  ---------- worktree: add post-worktree-remove hook
3:  7989a1d6a2 < -:  ---------- worktree: run post-worktree-remove hook whe=
n pruning
-:  ---------- > 1:  c37f12fcba worktree: add post-worktree lifecycle hook
4:  95ab61e377 ! 2:  e5855a1491 worktree: add post-worktree-move hook
    @@ Metadata
     Author: Domen Ko=C5=BEar <domen@cachix.org>
    =20
      ## Commit message ##
    -    worktree: add post-worktree-move hook
    +    worktree: notify post-worktree hook when pruning
    =20
    -    Tools that record worktree paths can keep their state up to date w=
hen a
    -    worktree is added or removed, but the mapping becomes stale when t=
he
    -    worktree is moved. Services or other per-worktree state tied to th=
e old
    -    path may also need to be relocated.
    +    A worktree can disappear without git worktree remove, for example =
when
    +    its directory is deleted manually. Tools maintaining per-worktree =
state
    +    need to observe its later deregistration by git worktree prune as =
well.
    +    Git knows which entries it prunes, including duplicates, whereas a
    +    wrapper comparing worktree listings can race concurrent operations=
 and
    +    has limited information about damaged entries.
    =20
    -    Introduce a post-worktree-move hook that runs after the working tr=
ee and
    -    its administrative files have been moved. The hook runs inside the=
 new
    -    working tree with GIT_DIR and GIT_WORK_TREE cleared and receives t=
he old
    -    absolute path as its sole argument. The new path and worktree iden=
tifier
    -    can be queried by running git from the hook's working directory.
    +    Emit a post-worktree remove event for each pruned administrative e=
ntry,
    +    with its identifier and former absolute path. Return the recorded =
.git
    +    path from should_prune_worktree() even when it points to a missing
    +    location, so the hook can receive the former worktree path. If the=
 path
    +    cannot be determined, pass an empty string instead.
    =20
    -    This signature also lets one configured command handle all three
    -    worktree lifecycle hooks by argument count: post-worktree-add take=
s no
    -    arguments, post-worktree-move takes one, and post-worktree-remove =
takes
    -    two.
    -
    -    A failing hook does not undo the completed move, but its exit stat=
us
    -    becomes the exit status of "git worktree move".
    +    Do not invoke the hook during a dry run. Reflect hook failures in =
the
    +    command's exit status while continuing to process the remaining en=
tries.
    +    Document pruning and test missing paths, duplicate entries, relati=
ve
    +    paths, dry runs, and failures that must not suppress other notific=
ations.
    =20
    +    Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
         Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
    -    Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
    -
    - ## Documentation/config/hook.adoc ##
    -@@ Documentation/config/hook.adoc: hook.jobs::
    - `pre-commit`;;
    - `post-checkout`;;
    - `post-worktree-add`;;
    -+`post-worktree-move`;;
    - `post-worktree-remove`;;
    - `push-to-checkout`;;
    - `post-commit`;;
    =20
      ## Documentation/githooks.adoc ##
    -@@ Documentation/githooks.adoc: runs after the `post-checkout` hook, e=
ven if that hook fails.
    - This hook can be used to set up per-worktree development environments
    - or to register the new working tree with external tools.
    +@@ Documentation/githooks.adoc: post-worktree
    + ~~~~~~~~~~~~~
     =20
    -+post-worktree-move
    -+~~~~~~~~~~~~~~~~~~
    -+
    -+This hook is invoked by linkgit:git-worktree[1] after `git worktree m=
ove`
    -+has moved a working tree and updated its administrative files. It is =
given
    -+one parameter: the absolute path of the working tree before it was mo=
ved.
    -+
    -+The hook's current working directory is the new working tree, so its =
new
    -+absolute path and identifier can be queried by running `git`.
    -+
    -+This hook cannot affect the outcome of `git worktree move`, other tha=
n
    -+that the hook's exit status becomes the exit status of the command. A
    -+failing hook does not undo the move.
    -+
    -+This hook can be used to update per-worktree development environments=
 or
    -+registrations with external tools after their working tree has moved.
    -+
    - post-worktree-remove
    - ~~~~~~~~~~~~~~~~~~~~
    + This hook is invoked by linkgit:git-worktree[1] after a working tree =
is
    +-added, moved, or removed. It takes four parameters: the event (`add`,=
 `move`,
    ++added, moved, or removed, and once for each entry removed by
    ++`git worktree prune`. It takes four parameters: the event (`add`, `mo=
ve`,
    + or `remove`), the worktree identifier (the name of its administrative
    + directory in `$GIT_COMMON_DIR/worktrees/`), the old absolute path, an=
d the
    + new absolute path.
    +@@ Documentation/githooks.adoc: The parameters for each event are:
    +     post-worktree remove <id> <old-path> ""
     =20
    + The empty strings are passed as arguments, so all events have exactly
    +-four parameters.
    ++four parameters. For entries pruned by `git worktree prune`, the old =
path
    ++may also be empty if it cannot be determined from the administrative
    ++files. No hook is run for `git worktree prune --dry-run`.
    +=20
    + The hook runs in the repository where the command was invoked, follow=
ing
    + the working directory and environment rules described above. It does =
not
    =20
      ## builtin/worktree.c ##
    -@@ builtin/worktree.c: static int run_post_worktree_remove_hook(const =
char *path, const char *id)
    - 	return run_hooks_opt(the_repository, "post-worktree-remove", &hook_o=
pt);
    +@@ builtin/worktree.c: static int run_post_worktree_hook(const char *e=
vent, const char *id,
    + 	return run_hooks_opt(the_repository, "post-worktree", &hook_opt);
      }
     =20
    -+static int run_post_worktree_move_hook(const char *old_path,
    -+				       const char *new_path)
    -+{
    -+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
    +-static void prune_worktree(const char *id, const char *reason)
    ++static int prune_worktree(const char *id, const char *dotgit,
    ++			  const char *reason)
    + {
    ++	struct strbuf path =3D STRBUF_INIT;
    ++	int ret;
     +
    -+	strvec_pushl(&hook_opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
    -+	strvec_push(&hook_opt.args, old_path);
    -+	hook_opt.dir =3D new_path;
    -+	return run_hooks_opt(the_repository, "post-worktree-move", &hook_opt=
);
    -+}
    + 	if (show_only || verbose)
    + 		fprintf_ln(stderr, _("Removing %s/%s: %s"), "worktrees", id, reason=
);
    +-	if (!show_only)
    +-		delete_git_dir(id);
    ++	if (show_only)
    ++		return 0;
     +
    - static int prune_worktree(const char *id, const char *dotgit,
    - 			  const char *reason)
    ++	delete_git_dir(id);
    ++
    ++	/* path stays empty when the worktree path cannot be determined */
    ++	if (dotgit) {
    ++		strbuf_addstr(&path, dotgit);
    ++		strbuf_strip_suffix(&path, "/.git");
    ++	}
    ++	ret =3D run_post_worktree_hook("remove", id, path.buf, "");
    ++	strbuf_release(&path);
    ++	return ret;
    + }
    +=20
    + static int prune_cmp(const void *a, const void *b)
    +@@ builtin/worktree.c: static int prune_cmp(const void *a, const void =
*b)
    + 	return strcmp(x->util, y->util);
    + }
    +=20
    +-static void prune_dups(struct string_list *l)
    ++static int prune_dups(struct string_list *l)
      {
    -@@ builtin/worktree.c: static int move_worktree(int ac, const char **a=
v, const char *prefix,
    - 	struct strbuf dst =3D STRBUF_INIT;
    - 	struct strbuf errmsg =3D STRBUF_INIT;
    - 	const char *reason =3D NULL;
    --	char *path;
    -+	char *old_path, *path;
    -+	int ret;
    + 	int i;
    ++	int ret =3D 0;
     =20
    - 	ac =3D parse_options(ac, av, prefix, options, git_worktree_move_usag=
e,
    - 			   0);
    -@@ builtin/worktree.c: static int move_worktree(int ac, const char **a=
v, const char *prefix,
    - 		    errmsg.buf);
    - 	strbuf_release(&errmsg);
    + 	QSORT(l->items, l->nr, prune_cmp);
    + 	for (i =3D 1; i < l->nr; i++) {
    + 		if (!fspathcmp(l->items[i].string, l->items[i - 1].string))
    +-			prune_worktree(l->items[i].util, "duplicate entry");
    ++			ret |=3D prune_worktree(l->items[i].util,
    ++					      l->items[i].string,
    ++					      "duplicate entry");
    + 	}
    ++	return ret;
    + }
     =20
    -+	old_path =3D xstrdup(wt->path);
    - 	if (rename(wt->path, dst.buf) =3D=3D -1)
    - 		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
    +-static void prune_worktrees(void)
    ++static int prune_worktrees(void)
    + {
    + 	struct strbuf reason =3D STRBUF_INIT;
    + 	struct strbuf main_path =3D STRBUF_INIT;
    +@@ builtin/worktree.c: static void prune_worktrees(void)
    + 	char *path;
    + 	DIR *dir;
    + 	struct dirent *d;
    ++	int ret =3D 0;
     =20
    - 	update_worktree_location(wt, dst.buf, use_relative_paths);
    -+	ret =3D run_post_worktree_move_hook(old_path, wt->path);
    + 	path =3D repo_git_path(the_repository, "worktrees");
    + 	dir =3D opendir(path);
    + 	free(path);
    + 	if (!dir)
    +-		return;
    ++		return 0;
    + 	while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL) {
    + 		char *path;
    + 		strbuf_reset(&reason);
    +-		if (should_prune_worktree(the_repository, d->d_name, &reason, &path=
, expire))
    +-			prune_worktree(d->d_name, reason.buf);
    +-		else if (path)
    ++		if (should_prune_worktree(the_repository, d->d_name,
    ++					  &reason, &path, expire)) {
    ++			ret |=3D prune_worktree(d->d_name, path, reason.buf);
    ++			free(path);
    ++		} else if (path) {
    + 			string_list_append_nodup(&kept, path)->util =3D xstrdup(d->d_name)=
;
    ++		}
    + 	}
    + 	closedir(dir);
     =20
    -+	free(old_path);
    - 	strbuf_release(&dst);
    - 	free_worktrees(worktrees);
    --	return 0;
    +@@ builtin/worktree.c: static void prune_worktrees(void)
    + 	/* massage main worktree absolute path to match 'gitdir' content */
    + 	strbuf_strip_suffix(&main_path, "/.");
    + 	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
    +-	prune_dups(&kept);
    ++	ret |=3D prune_dups(&kept);
    + 	string_list_clear(&kept, 1);
    +=20
    + 	if (!show_only)
    + 		delete_worktrees_dir_if_empty();
    + 	strbuf_release(&reason);
     +	return ret;
      }
     =20
    - /*
    + static int prune(int ac, const char **av, const char *prefix,
    +@@ builtin/worktree.c: static int prune(int ac, const char **av, const=
 char *prefix,
    + 			   0);
    + 	if (ac)
    + 		usage_with_options(git_worktree_prune_usage, options);
    +-	prune_worktrees();
    +-	return 0;
    ++	return prune_worktrees();
    + }
    +=20
    + static char *junk_work_tree;
    =20
    - ## t/t2403-worktree-move.sh ##
    -@@ t/t2403-worktree-move.sh: test_expect_success 'move worktree' '
    - 	test_cmp expected2 actual2
    + ## t/t2401-worktree-prune.sh ##
    +@@ t/t2401-worktree-prune.sh: test_expect_success 'prune duplicate (ma=
in/linked)' '
    + 	test_path_is_missing .git/worktrees/wt
      '
     =20
    -+test_expect_success '"move" invokes post-worktree-move hook' '
    -+	test_hook post-worktree-move <<-\EOF &&
    -+	test "$#" =3D 1 &&
    -+	{
    -+		echo "$1" &&
    -+		git rev-parse --git-dir --show-toplevel
    -+	} >hook.actual
    ++test_expect_success 'prune invokes post-worktree remove event' '
    ++	test_hook post-worktree <<-\EOF &&
    ++	test "$#" =3D 4 || exit 1
    ++	test "$1" =3D remove || exit 0
    ++	printf "[%s][%s][%s][%s]\n" "$@" >hook.actual
    ++	EOF
    ++	git worktree add --detach flushed &&
    ++	rm -rf flushed &&
    ++	git worktree prune &&
    ++	printf "[remove][flushed][%s][]\n" "$(pwd)/flushed" >hook.expect &&
    ++	test_cmp hook.expect hook.actual
    ++'
    ++
    ++test_expect_success 'prune invokes post-worktree once per worktree' '
    ++	test_hook post-worktree <<-\EOF &&
    ++	test "$#" =3D 4 || exit 1
    ++	test "$1" =3D remove || exit 0
    ++	printf "[%s][%s][%s][%s]\n" "$@" >>hook.actual
     +	EOF
    -+	git worktree add --detach hook-source &&
    -+	git worktree move hook-source hook-destination &&
    ++	git worktree add --detach first &&
    ++	git worktree add --detach second &&
    ++	rm -rf first second hook.actual &&
    ++	git worktree prune &&
     +	{
    -+		echo "$(pwd)/hook-source" &&
    -+		echo "$(pwd)/.git/worktrees/hook-source" &&
    -+		echo "$(pwd)/hook-destination"
    ++		printf "[remove][first][%s][]\n" "$(pwd)/first" &&
    ++		printf "[remove][second][%s][]\n" "$(pwd)/second"
     +	} >hook.expect &&
    -+	test_cmp hook.expect hook-destination/hook.actual
    ++	sort hook.actual >hook.sorted &&
    ++	test_cmp hook.expect hook.sorted
    ++'
    ++
    ++test_expect_success 'prune --dry-run does not invoke post-worktree ho=
ok' '
    ++	git worktree add --detach dry &&
    ++	rm -rf dry &&
    ++	test_when_finished "git worktree prune" &&
    ++	test_hook post-worktree <<-\EOF &&
    ++	>hook.ran
    ++	EOF
    ++	git worktree prune --dry-run &&
    ++	test_path_is_missing hook.ran
    ++'
    ++
    ++test_expect_success 'pruned entry with unknown path gives empty hook =
argument' '
    ++	test_hook post-worktree <<-\EOF &&
    ++	test "$#" =3D 4 &&
    ++	printf "[%s][%s][%s][%s]\n" "$@" >hook.actual
    ++	EOF
    ++	mkdir -p .git/worktrees/broken &&
    ++	: >.git/worktrees/broken/gitdir &&
    ++	git worktree prune &&
    ++	echo "[remove][broken][][]" >hook.expect &&
    ++	test_cmp hook.expect hook.actual
     +'
     +
    -+test_expect_success 'failing post-worktree-move hook leaves worktree =
moved' '
    -+	test_hook post-worktree-move <<-\EOF &&
    ++test_expect_success 'failing post-worktree hook does not skip other p=
runed entries' '
    ++	test_hook post-worktree <<-\EOF &&
    ++	test "$1" =3D remove || exit 0
    ++	echo "$2" >>hook.actual
     +	exit 1
     +	EOF
    -+	git worktree add --detach hook-failing-source &&
    -+	test_must_fail git worktree move hook-failing-source hook-failing-de=
stination &&
    -+	test_path_is_missing hook-failing-source &&
    -+	git -C hook-failing-destination status --porcelain >actual &&
    -+	test_must_be_empty actual
    ++	git worktree add --detach doomed &&
    ++	git worktree add --detach doomed2 &&
    ++	rm -rf doomed doomed2 hook.actual &&
    ++	test_must_fail git worktree prune &&
    ++	test_path_is_missing .git/worktrees/doomed &&
    ++	test_path_is_missing .git/worktrees/doomed2 &&
    ++	test_write_lines doomed doomed2 >hook.expect &&
    ++	sort hook.actual >hook.sorted &&
    ++	test_cmp hook.expect hook.sorted
     +'
     +
    - test_expect_success 'move main worktree' '
    - 	test_must_fail git worktree move . def
    - '
    ++test_expect_success 'prune duplicate invokes post-worktree remove eve=
nt' '
    ++	test_when_finished rm -fr .git/worktrees w1 w2 &&
    ++	test_hook post-worktree <<-\EOF &&
    ++	test "$1" =3D remove || exit 0
    ++	printf "[%s][%s][%s][%s]\n" "$@" >>hook.actual
    ++	EOF
    ++	rm -f hook.actual &&
    ++	git worktree add --detach w1 &&
    ++	git worktree add --detach w2 &&
    ++	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.ne=
w &&
    ++	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
    ++	git worktree prune &&
    ++	printf "[remove][w2][%s][]\n" "$(pwd)/w1" >hook.expect &&
    ++	test_cmp hook.expect hook.actual
    ++'
    ++
    ++test_expect_success 'post-worktree remove gets absolute path with rel=
ative worktrees' '
    ++	test_when_finished "rm -rf relhook" &&
    ++	git init relhook &&
    ++	test_commit -C relhook base &&
    ++	test_hook -C relhook post-worktree <<-\EOF &&
    ++	test "$1" =3D remove || exit 0
    ++	printf "[%s][%s][%s][%s]\n" "$@" >hook.actual
    ++	EOF
    ++	git -C relhook worktree add --relative-paths --detach wt &&
    ++	rm -rf relhook/wt &&
    ++	git -C relhook worktree prune &&
    ++	printf "[remove][wt][%s][]\n" "$(pwd)/relhook/wt" >hook.expect &&
    ++	test_cmp hook.expect relhook/hook.actual
    ++'
    ++
    + test_expect_success 'not prune proper worktrees inside linked worktre=
e with relative paths' '
    + 	test_when_finished rm -rf repo wt_ext &&
    + 	git init repo &&
    +
    + ## worktree.c ##
    +@@ worktree.c: int should_prune_worktree(struct repository *repo,
    + 		if (stat(file.buf, &st) || st.st_mtime <=3D expire) {
    + 			strbuf_addstr(reason, _("gitdir file points to non-existent locati=
on"));
    + 			rc =3D 1;
    +-			goto done;
    + 		}
    + 	}
    + 	*wtpath =3D strbuf_detach(&dotgit, NULL);
    +
    + ## worktree.h ##
    +@@ worktree.h: const char *worktree_prune_reason(struct worktree *wt, =
timestamp_t expire);
    +=20
    + /*
    +  * Return true if worktree entry should be pruned, along with the rea=
son for
    +- * pruning. Otherwise, return false and the worktree's path in `wtpat=
h`, or
    +- * NULL if it cannot be determined. Caller is responsible for freeing
    +- * returned path.
    ++ * pruning. Otherwise, return false. In both cases the path of the
    ++ * worktree's `.git` file is returned in `wtpath`, or NULL if it cann=
ot
    ++ * be determined. Caller is responsible for freeing returned path.
    +  *
    +  * `expire` defines a grace period to prune the worktree when its pat=
h
    +  * does not exist.
--=20
2.54.0
