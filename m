Received: from mta206-ab1.mtasv.net (mta206-ab1.mtasv.net [50.31.205.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5FF31B10B
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.31.205.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791155537; cv=none; b=MskuTUoxfVDfAYVckB0AMsIQiIvZvD5InzzmgPPJ06hTrTJf5CX5UuT7ch7A8Q13XW/i8ZxQ8LR2FhjLRWWQenjTcuIWt4NaHMkGu5kbHteJGcB8gRKif7/IJuqCww7gRZLYU7/0K3yrBDglH7HTMM+AtHGv+4BSUJ8IC/ic3hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791155537; c=relaxed/simple;
	bh=Bwc7PUY/2AE7vcWti6eJiLh/hp84JGhfRU9chYbwkMU=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePNDnF3Deg0nSqd11r5s6KwqK+wXpJ/lM3Vj/GuLYIV6RHwfIyRfXjrcA2keA0FtmzZYELhOgj2w18BxBWGANxIF9EngDmE9hGeOc2+5xtJTFOlS/53VlGMiJEDHOOvrombDguX3YwvUXkiTS7mVuOvQzTSJpzn5pkkUpCNpfgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=OgfGNZMU; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=F5R1Sd6+; arc=none smtp.client-ip=50.31.205.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="OgfGNZMU";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="F5R1Sd6+"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=RZizRlBjsosTKXYaMEc5bSv5FftSdp8ceJjjfU+QkVo=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1791155347; x=1791760147;
	b=OgfGNZMU29SZPd531el/2GP06FScWENOXmks/Wz/16vQVvB9YL/dk1TNfU523zmtCptTVY4CH
	+JIwMr1xJhnQVRq1tfNIxZ5Gq92iYsJgl9KGR9FvuJnZhl9OeRE5zY9eaDmvWw4dRq/RtBaGVC6
	e7yjes4s1JOw1xd0SSD517LSBckUJBBXGkN/KKaJ1FKdHqonTlvIhQkYheIHc1J4ebcw/4AL5rN
	yPjSe+PGZPTmXUtuGQDeGE0hnOx9CPrDuv1s4jtXxD/9lxnsFITn/n4jKONy6RO1DhaYXA1v24G
	gnIkg4uYb3nbmgNF+SfywvjEZytQG93CWndAsOu1QVaA==;
Received: from ip-172-26-33-111.us-east-2.compute.internal (172.26.33.111)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.241.151) 
  with ESMTP id 99fb3b60c04811f1834c02fff115ec99 for <git@vger.kernel.org>;
  Sun, 4 Oct 2026 23:09:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1791155347; x=1791328147;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=RZizRlBjsosTKXYaMEc5bSv5FftSdp8ceJjjfU+QkVo=;
	b=F5R1Sd6+Jgk+QO3Ugt1KlLWj/sphw2AhMhhrSXo0pPVZb9H3baL5YuRcsNmGAKINU/xT/8s75v9
	3ND3+BiIYJiKigVbmlAqqHZdyvYix8vp2AshTeKiBFaTYISpfFtiHuHQdvnlqemAFEpC9tzbib3sh
	luesn7Vxb2Nsmgjpc1A=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Sun, 04 Oct 2026 23:09:07 +0000
Subject: [PATCH v3 1/2] worktree: add post-worktree lifecycle hook
Message-Id: <2c1c1f06-05e7-4d8c-bd29-c2a9708b443d@mtasv.net>
Reply-To: domen@cachix.org
To: git@vger.kernel.org
Cc: gitster@pobox.com, cdwhite3@pm.me, phillip.wood123@gmail.com,
 sunshine@sunshineco.com, ps@pks.im, avarab@gmail.com, test35965@gmail.com,
 kristofferhaugsbakk@fastmail.com, maciej.ciemborowicz@gmail.com,
 Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>, Claude Fable 5
	<noreply@anthropic.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791152172.git.domen@cachix.org>
References: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net> <cover.1791152172.git.domen@cachix.org>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 2c1c1f06-05e7-4d8c-bd29-c2a9708b443d
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.XGLkwKK1JaDpLEHrICcoow.8SMLElgy66O3QhkgJQ8JpSM_9TB-RxR3vtBnpoKuWUqcNRXiO8KuGZGz_rHwhzAhbXIbum6PXbQ-OB2NM6hbthcfvS3Dsn_eWet_TY6GVYUdcm_vrqTKSbwP7ouqZ-___-IarrKhiCO1FKccmoqwUpyayxgtg0SVEqygBCPU7FrvYH96izv1B7FZp8fB3edF
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: mta206-ab1
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tools that manage per-worktree development environments need to observe
worktrees created, moved, or removed by other programs. Wrapping the
worktree command only helps when every caller uses the wrapper, and
post-checkout does not run for add --no-checkout or --orphan. There is
no notification for moving or removing a worktree.

Add one post-worktree hook for these operations. Pass the event name,
worktree identifier, old absolute path, and new absolute path as four
arguments, using an empty string for a path that does not apply. An
explicit event name lets one handler manage the whole lifecycle without
using argument count to distinguish operations, as the earlier series
with three separate hooks did.

Run the hook in the invoking repository with its normal environment,
rather than changing to the affected worktree. Passing both paths lets
handlers target the new worktree when needed and keeps the execution
context consistent when a worktree has been removed.

Run the add event after post-checkout even when that hook fails, because
the worktree remains present. A failing lifecycle hook affects the
command's exit status without undoing the completed operation. Preserve
post-checkout's failure status if both hooks fail.

Document the interface and cover ordinary, bare, and linked callers,
no-checkout and orphan worktrees, relative paths, paths with spaces,
configured hooks, and hook failures.

Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
---
 Documentation/config/hook.adoc |   1 +
 Documentation/githooks.adoc    |  43 +++++++++++
 builtin/worktree.c             |  56 ++++++++++----
 t/t2400-worktree-add.sh        | 132 +++++++++++++++++++++++++++++++++
 t/t2403-worktree-move.sh       | 113 ++++++++++++++++++++++++++++
 5 files changed, 329 insertions(+), 16 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.ado=
c
index 083dc60a13..501bb006f5 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -94,6 +94,7 @@ hook.jobs::
 	Receive a commit message file and may rewrite it in place.
 `pre-commit`;;
 `post-checkout`;;
+`post-worktree`;;
 `push-to-checkout`;;
 `post-commit`;;
 	Access the working tree, index, or repository state.
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 145642bf05..3e25f769c5 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -215,6 +215,49 @@ This hook can be used to perform repository validity c=
hecks, auto-display
 differences from the previous HEAD if different, or set working dir metada=
ta
 properties.
=20
+post-worktree
+~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-worktree[1] after a working tree is
+added, moved, or removed. It takes four parameters: the event (`add`, `mov=
e`,
+or `remove`), the worktree identifier (the name of its administrative
+directory in `$GIT_COMMON_DIR/worktrees/`), the old absolute path, and the
+new absolute path.
+
+The parameters for each event are:
+
+    post-worktree add    <id> ""         <new-path>
+    post-worktree move   <id> <old-path> <new-path>
+    post-worktree remove <id> <old-path> ""
+
+The empty strings are passed as arguments, so all events have exactly
+four parameters.
+
+The hook runs in the repository where the command was invoked, following
+the working directory and environment rules described above. It does not
+change to the added or moved working tree. To run Git commands there,
+clear the repository environment variables and use the new path, for
+example:
+
+------------
+(unset $(git rev-parse --local-env-vars); git -C "$4" status)
+------------
+
+The `add` event runs after the new working tree has been set up, including
+with `--no-checkout` and `--orphan`. It runs after `post-checkout`, even
+if that hook fails. The `move` event runs after the working tree and its
+administrative files have been moved. The `remove` event runs after the
+working tree has been deleted or its administrative entry removed.
+
+The hook cannot undo the worktree operation. A non-zero exit status is
+reflected in the command's exit status, but leaves the completed operation
+in place. If `post-checkout` fails during `git worktree add`, its exit
+status takes precedence over that of `post-worktree`.
+
+This hook can be used to set up, relocate, or tear down per-worktree
+development environments, or to maintain registrations with external
+tools. Hook scripts should ignore events they do not handle.
+
 post-merge
 ~~~~~~~~~~
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 77ecd0f71f..0f2748080c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -168,6 +168,15 @@ static void delete_worktrees_dir_if_empty(void)
 	free(path);
 }
=20
+static int run_post_worktree_hook(const char *event, const char *id,
+				  const char *old_path, const char *new_path)
+{
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
+	strvec_pushl(&hook_opt.args, event, id, old_path, new_path, NULL);
+	return run_hooks_opt(the_repository, "post-worktree", &hook_opt);
+}
+
 static void prune_worktree(const char *id, const char *reason)
 {
 	if (show_only || verbose)
@@ -604,21 +613,30 @@ static int add_worktree(const char *path, const char =
*refname,
 	}
=20
 	/*
-	 * Hook failure does not warrant worktree deletion, so run hook after
-	 * is_junk is cleared, but do return appropriate code when hook fails.
+	 * Hook failures do not warrant worktree deletion, so run hooks after
+	 * is_junk is cleared, but do return appropriate code when a hook
+	 * fails.
 	 */
-	if (!ret && opts->checkout && !opts->orphan) {
-		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
-
-		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
-		strvec_pushl(&opt.args,
-			     oid_to_hex(null_oid(the_hash_algo)),
-			     oid_to_hex(&commit->object.oid),
-			     "1",
-			     NULL);
-		opt.dir =3D path;
-
-		ret =3D run_hooks_opt(the_repository, "post-checkout", &opt);
+	if (!ret) {
+		int hook_ret;
+
+		if (opts->checkout && !opts->orphan) {
+			struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
+			strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+			strvec_pushl(&opt.args,
+				     oid_to_hex(null_oid(the_hash_algo)),
+				     oid_to_hex(&commit->object.oid),
+				     "1",
+				     NULL);
+			opt.dir =3D path;
+
+			ret =3D run_hooks_opt(the_repository, "post-checkout", &opt);
+		}
+
+		hook_ret =3D run_post_worktree_hook("add", wt->id, "", wt->path);
+		if (!ret)
+			ret =3D hook_ret;
 	}
=20
 	strvec_clear(&child_env);
@@ -1305,7 +1323,8 @@ static int move_worktree(int ac, const char **av, con=
st char *prefix,
 	struct strbuf dst =3D STRBUF_INIT;
 	struct strbuf errmsg =3D STRBUF_INIT;
 	const char *reason =3D NULL;
-	char *path;
+	char *old_path, *path;
+	int ret;
=20
 	ac =3D parse_options(ac, av, prefix, options, git_worktree_move_usage,
 			   0);
@@ -1348,14 +1367,17 @@ static int move_worktree(int ac, const char **av, c=
onst char *prefix,
 		    errmsg.buf);
 	strbuf_release(&errmsg);
=20
+	old_path =3D xstrdup(wt->path);
 	if (rename(wt->path, dst.buf) =3D=3D -1)
 		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
=20
 	update_worktree_location(wt, dst.buf, use_relative_paths);
+	ret =3D run_post_worktree_hook("move", wt->id, old_path, wt->path);
=20
+	free(old_path);
 	strbuf_release(&dst);
 	free_worktrees(worktrees);
-	return 0;
+	return ret;
 }
=20
 /*
@@ -1473,6 +1495,8 @@ static int remove_worktree(int ac, const char **av, c=
onst char *prefix,
 	ret |=3D delete_git_dir(wt->id);
 	delete_worktrees_dir_if_empty();
=20
+	ret |=3D run_post_worktree_hook("remove", wt->id, wt->path, "");
+
 	free_worktrees(worktrees);
 	return ret;
 }
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index bdcca97633..65fec976b5 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1172,6 +1172,138 @@ test_expect_success '"add" in bare repo invokes pos=
t-checkout hook' '
 	test_cmp hook.expect goozy/hook.actual
 '
=20
+# Install a post-worktree hook and write the output expected for adding
+# worktree $1. Repo $2 defaults to "."; the caller worktree is $3.
+post_worktree_add_hook () {
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook -C "$2" post-worktree <<-\EOF &&
+	test "$#" =3D 4 &&
+	{
+		printf "%s\n" "$@" &&
+		test-tool path-utils real_path . &&
+		git rev-parse --absolute-git-dir
+	} >hook.actual
+	EOF
+	{
+		test_write_lines add "$1" "" "$(pwd)/$1" &&
+		(cd "${3:-${2:-.}}" && test-tool path-utils real_path .) &&
+		git -C "${3:-${2:-.}}" rev-parse --absolute-git-dir
+	} >hook.expect
+}
+
+test_expect_success '"add" invokes post-worktree hook' '
+	post_worktree_add_hook wanda &&
+	git worktree add wanda &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success '"add" in other worktree invokes post-worktree hook th=
ere' '
+	post_worktree_add_hook wilbur "" wanda &&
+	git -C wanda worktree add ../wilbur &&
+	test_cmp hook.expect wanda/hook.actual
+'
+
+test_expect_success '"add --no-checkout" still invokes post-worktree hook'=
 '
+	post_worktree_add_hook wendy &&
+	git worktree add --no-checkout wendy &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success '"add --orphan" invokes post-worktree hook' '
+	post_worktree_add_hook winnie &&
+	git worktree add --orphan winnie &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success '"add" in bare repo invokes post-worktree hook there' =
'
+	rm -rf bare2 &&
+	git clone --bare . bare2 &&
+	post_worktree_add_hook willow bare2 &&
+	git -C bare2 worktree add --detach ../willow &&
+	test_cmp hook.expect bare2/hook.actual
+'
+
+test_expect_success '"add" runs post-worktree after post-checkout' '
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-checkout <<-\EOF &&
+	echo post-checkout >>"$(git rev-parse --git-common-dir)/hooks.actual"
+	EOF
+	test_hook post-worktree <<-\EOF &&
+	echo post-worktree >>"$(git rev-parse --git-common-dir)/hooks.actual"
+	EOF
+	test_write_lines post-checkout post-worktree >hooks.expect &&
+	git worktree add wobble &&
+	test_cmp hooks.expect .git/hooks.actual
+'
+
+test_expect_success 'failing post-checkout hook does not suppress post-wor=
ktree hook' '
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-checkout <<-\EOF &&
+	exit 2
+	EOF
+	test_hook post-worktree <<-\EOF &&
+	>post-worktree.ran &&
+	exit 3
+	EOF
+	test_expect_code 2 git worktree add wozzle &&
+	test_path_is_file post-worktree.ran
+'
+
+test_expect_success 'failing post-worktree hook leaves worktree in place' =
'
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-worktree <<-\EOF &&
+	exit 1
+	EOF
+	test_expect_code 1 git worktree add wilma &&
+	git worktree list --porcelain >out &&
+	test_grep -F "worktree $(pwd)/wilma" out
+'
+
+test_expect_success 'failed "add" does not invoke post-worktree hook' '
+	test_when_finished "rm -rf .git/hooks occupied" &&
+	mkdir .git/hooks &&
+	test_hook post-worktree <<-\EOF &&
+	>hook.ran
+	EOF
+	mkdir occupied &&
+	: >occupied/blocker &&
+	test_must_fail git worktree add occupied &&
+	test_path_is_missing hook.ran
+'
+
+test_expect_success 'post-worktree add gets absolute path with relative wo=
rktrees' '
+	test_when_finished "rm -rf relhook" &&
+	git init relhook &&
+	test_commit -C relhook base &&
+	test_hook -C relhook post-worktree <<-\EOF &&
+	test "$#" =3D 4 &&
+	printf "%s\n" "$@" >hook.actual
+	EOF
+	git -C relhook worktree add --relative-paths --detach wt &&
+	test_write_lines add wt "" "$(pwd)/relhook/wt" >hook.expect &&
+	test_cmp hook.expect relhook/hook.actual
+'
+
+test_expect_success 'configured post-worktree hook preserves paths with sp=
aces' '
+	test_when_finished "rm -rf confighook" &&
+	git init confighook &&
+	test_commit -C confighook base &&
+	write_script confighook/record-hook <<-\EOF &&
+	test "$#" =3D 4 &&
+	printf "%s\n" "$@" >hook.actual
+	EOF
+	git -C confighook config hook.lifecycle.command ./record-hook &&
+	git -C confighook config hook.lifecycle.event post-worktree &&
+	git -C confighook worktree add --detach "wt with spaces" &&
+	id=3D$(basename "$(git -C "confighook/wt with spaces" rev-parse --absolut=
e-git-dir)") &&
+	test_write_lines add "$id" "" "$(pwd)/confighook/wt with spaces" >hook.ex=
pect &&
+	test_cmp hook.expect confighook/hook.actual
+'
+
 test_expect_success '"add" an existing but missing worktree' '
 	git worktree add --detach pneu &&
 	test_must_fail git worktree add --detach pneu &&
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 69768c1207..11ef81dce8 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -82,6 +82,59 @@ test_expect_success 'move worktree' '
 	test_cmp expected2 actual2
 '
=20
+test_expect_success '"move" invokes post-worktree hook in the calling repo=
sitory' '
+	test_hook post-worktree <<-\EOF &&
+	test "$#" =3D 4 || exit 1
+	test "$1" =3D move || exit 0
+	{
+		printf "%s\n" "$@" &&
+		test-tool path-utils real_path . &&
+		git rev-parse --absolute-git-dir
+	} >hook.actual
+	EOF
+	git worktree add --detach hook-source &&
+	git worktree move hook-source hook-destination &&
+	{
+		test_write_lines move hook-source "$(pwd)/hook-source" "$(pwd)/hook-dest=
ination" &&
+		test-tool path-utils real_path . &&
+		git rev-parse --absolute-git-dir
+	} >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'failing post-worktree move event leaves worktree move=
d' '
+	test_hook post-worktree <<-\EOF &&
+	test "$1" =3D move || exit 0
+	exit 1
+	EOF
+	git worktree add --detach hook-failing-source &&
+	test_must_fail git worktree move hook-failing-source hook-failing-destina=
tion &&
+	test_path_is_missing hook-failing-source &&
+	git -C hook-failing-destination status --porcelain >actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'post-worktree move keeps the ID and passes absolute p=
aths with spaces' '
+	test_when_finished "rm -rf movehook" &&
+	git init movehook &&
+	test_commit -C movehook base &&
+	git -C movehook worktree add --relative-paths --detach "source tree" &&
+	git -C movehook worktree add --detach caller &&
+	id=3D$(basename "$(git -C "movehook/source tree" rev-parse --absolute-git=
-dir)") &&
+	test_hook -C movehook post-worktree <<-\EOF &&
+	test "$#" =3D 4 &&
+	{
+		printf "%s\n" "$@" &&
+		git rev-parse --show-toplevel
+	} >hook.actual
+	EOF
+	git -C movehook/caller worktree move --relative-paths "../source tree" ".=
./destination tree" &&
+	test_write_lines move "$id" "$(pwd)/movehook/source tree" \
+		"$(pwd)/movehook/destination tree" "$(pwd)/movehook/caller" >hook.expect=
 &&
+	test_cmp hook.expect movehook/caller/hook.actual &&
+	test_path_is_dir "movehook/destination tree"
+'
+
 test_expect_success 'move main worktree' '
 	test_must_fail git worktree move . def
 '
@@ -246,6 +299,66 @@ test_expect_success 'not remove a repo with initialize=
d submodule' '
 	)
 '
=20
+test_expect_success '"remove" invokes post-worktree remove event' '
+	test_hook post-worktree <<-\EOF &&
+	test "$#" =3D 4 || exit 1
+	test "$1" =3D remove || exit 0
+	printf "%s\n" "$@" >hook.actual
+	EOF
+	git worktree add --detach wt-hooked &&
+	git worktree remove wt-hooked &&
+	test_write_lines remove wt-hooked "$(pwd)/wt-hooked" "" >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success '"remove" of missing worktree invokes post-worktree ho=
ok' '
+	test_when_finished "rm -rf wt-moved-away" &&
+	test_hook post-worktree <<-\EOF &&
+	test "$1" =3D remove || exit 0
+	printf "%s\n" "$@" >hook.actual
+	EOF
+	rm -f hook.actual &&
+	git worktree add --detach wt-elsewhere &&
+	mv wt-elsewhere wt-moved-away &&
+	git worktree remove wt-elsewhere &&
+	test_write_lines remove wt-elsewhere "$(pwd)/wt-elsewhere" "" >hook.expec=
t &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'refused "remove" does not invoke post-worktree hook' =
'
+	git worktree add --detach wt-kept &&
+	test_when_finished "git worktree remove --force --force wt-kept || :" &&
+	test_hook post-worktree <<-\EOF &&
+	>hook.ran
+	EOF
+	git worktree lock wt-kept &&
+	test_must_fail git worktree remove wt-kept &&
+	test_path_is_missing hook.ran
+'
+
+test_expect_success 'failing post-worktree remove event fails "remove", wo=
rktree is gone' '
+	test_hook post-worktree <<-\EOF &&
+	test "$1" =3D remove || exit 0
+	exit 1
+	EOF
+	git worktree add --detach wt-doomed &&
+	test_must_fail git worktree remove wt-doomed &&
+	test_path_is_missing wt-doomed &&
+	test_path_is_missing .git/worktrees/wt-doomed
+'
+
+test_expect_success 'post-worktree remove preserves paths with spaces' '
+	git worktree add --detach "remove tree" &&
+	id=3D$(basename "$(git -C "remove tree" rev-parse --absolute-git-dir)") &=
&
+	test_hook post-worktree <<-\EOF &&
+	test "$#" =3D 4 &&
+	printf "%s\n" "$@" >hook.actual
+	EOF
+	git worktree remove "remove tree" &&
+	test_write_lines remove "$id" "$(pwd)/remove tree" "" >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
 test_expect_success 'move worktree with absolute path to relative path' '
 	test_config worktree.useRelativePaths false &&
 	git worktree add ./absolute &&
--=20
2.54.0
