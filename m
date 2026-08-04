Received: from mta203a-ord.mtasv.net (mta203a-ord.mtasv.net [104.245.209.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E906415665C
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867427; cv=none; b=hAHIDJRFE560E1VbT5PvYFPnWwMYtlYx92fuR2R4ErOSW/pnQQXxRx7vqa28n6zA3X7DcfTaz/7z1nRccmQ8R5hLcaEHsYbC9dxgMpT19eVWXeB00rYqAXU93KQbYtzV5SeZlPok7MqxydG3v6IGmj6JyciUogz6k7fkUJLmo08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867427; c=relaxed/simple;
	bh=iNL8Ogz+rqRa4trxQcj4rm2rb2CiXOX8ohKmHZcwLxE=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aISFyLkfSxnI0t8R9Mzz3dQB/abzRu/SjIfReUevcfuBl4QguqPVmC3WQK7PUU0KcIr7HuTVphUKC87sHw/fO+9rdUB8xtcVI44VSIu+s0hdvqCNq475IEwBd3ao4gbchG7ZXZXOS7qLPsLAJWWmikwmlI+9S5Ub3zO10iim1w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=jqzFEyCr; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=flhHzj0z; arc=none smtp.client-ip=104.245.209.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="jqzFEyCr";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="flhHzj0z"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=E+cgNI4Nx29n8BJayY9/9o4CKPQ0sJ1al265+dyiKB0=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1785867241; x=1786472041;
	b=jqzFEyCrU2LbbhqZVBuSnrS/vcQEiJR7KuNkDDujPQ64C8FOH+woVfChw5EHEeWjvb3ppmF+u
	WnZemopzfAQ1UAe6d4lFgAN2dOsmqiaISmGV7AYhsw3bsCDa9klsz7DpWSWbYMcfEfHDBCTYX1A
	C2fB8bw80AsYDX0osA7vl8kyPKSDuRSwKP1rxEa7IyYAbp7jj0XsFqDnwjM8UpuLaELaa6s0FQe
	o4gFL4GfqpEBG5e/AW31rt4nOZnFilNc9B9Wyn172l/LSh9JJxwCClQ58cF0tOMKXdJiyanf1KA
	pUIof7pWX706vBBrR0FAxXp6QpwW2OnMDTFiJP6cKBVQ==;
Received: from ip-172-26-13-18.us-east-2.compute.internal (172.26.13.18)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.240.162) 
  with ESMTP id 45214b5a903011f19af202cc1da1a5e9 for <git@vger.kernel.org>;
  Tue, 4 Aug 2026 18:14:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1785867241; x=1786040041;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=E+cgNI4Nx29n8BJayY9/9o4CKPQ0sJ1al265+dyiKB0=;
	b=flhHzj0zVlJpxh19IFz2qMqnoUqyhL7RjbM9vIhDc5od1YZlHxZ4oaYjtvP3If8UW/NAOXM01cf
	Cb2cFYamnfurOKqxkJOjI88xfhX8SmiILLHIJYEzn4w8q+zD7TyWNLrFLxGXFTbtVpym2r4tdqe9x
	oUnWgrXHLeWjPe1dqUM=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Tue, 04 Aug 2026 18:14:01 +0000
Subject: [PATCH v2 1/4] worktree: add post-worktree-add hook
Message-Id: <9f6bb2ec-afe3-4a1c-ade2-addf73f8681d@mtasv.net>
Reply-To: domen@cachix.org
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine
	<sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
 Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>,
 Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804181358.532970-1-domen@cachix.org>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net> <20260804181358.532970-1-domen@cachix.org>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 9f6bb2ec-afe3-4a1c-ade2-addf73f8681d
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.Y_2LGXqsZUeIlD3_Za-Pzg.W1mfHcVARFtQjZuv4CaEKH6wGGegpOhdz_cDQizNPHqgMEyZDLyxF1i9bHQ1qufoLYboDNahBKDVwm3xTuP1FUfnHaACbbEI44MFXThyLrjVwqbE8r6JqhJigDuxPZUvtJdGm8rp4ywulCNUBCSh0pddE-yiG8oNxTV-YQW3aZcXL5XZ5jgs4XmEq1qB9Q3j
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-203
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tools that manage per-worktree state, such as development environment
managers or IDEs, have no way to react when a new working tree is
created. The only hook that fires during "git worktree add" is
post-checkout, which is skipped when --no-checkout or --orphan is used
and cannot be distinguished from a plain checkout.

Introduce a post-worktree-add hook that runs after the working tree
has been fully set up, including with --no-checkout and --orphan. The
hook runs inside the new working tree with GIT_DIR and GIT_WORK_TREE
cleared, mirroring the existing post-checkout invocation, and takes no
arguments. Details such as the absolute path, worktree identifier, and
checked-out branch can be queried by running git from the hook's working
directory. Taking no arguments also lets a configured command shared
with post-worktree-remove distinguish the events by argument count.

Like post-checkout, the hook cannot affect the outcome of the command:
a failing hook does not delete the already-created working tree, but
its exit status becomes the exit status of "git worktree add". The
hook runs after post-checkout, even when post-checkout fails, because
the worktree has still been populated and remains present.

Documenting the new hook in githooks(5) also registers its name in the
generated hook-list.h, so "git hook run" and hook.*.event recognize it
without further changes.

Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
---
 Documentation/config/hook.adoc |   1 +
 Documentation/githooks.adoc    |  18 ++++++
 builtin/worktree.c             |  46 +++++++++-----
 t/t2400-worktree-add.sh        | 111 +++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+), 14 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.ado=
c
index 083dc60a13..81afb4a919 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -94,6 +94,7 @@ hook.jobs::
 	Receive a commit message file and may rewrite it in place.
 `pre-commit`;;
 `post-checkout`;;
+`post-worktree-add`;;
 `push-to-checkout`;;
 `post-commit`;;
 	Access the working tree, index, or repository state.
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index ed045940d1..5a2955ee2f 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -215,6 +215,24 @@ This hook can be used to perform repository validity c=
hecks, auto-display
 differences from the previous HEAD if different, or set working dir metada=
ta
 properties.
=20
+post-worktree-add
+~~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-worktree[1] after `git worktree add`
+has created and set up a new working tree. It takes no parameters.
+
+The hook's current working directory is the new working tree, so further
+details, such as its absolute path, identifier, and checked-out branch,
+can be queried by running `git`. Unlike the `post-checkout` hook, it is
+also run when `--no-checkout` or `--orphan` is used.
+
+This hook cannot affect the outcome of `git worktree add`, other than
+that the hook's exit status becomes the exit status of the command. It
+runs after the `post-checkout` hook, even if that hook fails.
+
+This hook can be used to set up per-worktree development environments
+or to register the new working tree with external tools.
+
 post-merge
 ~~~~~~~~~~
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index d21c43fde3..cc3299bca9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -168,6 +168,15 @@ static void delete_worktrees_dir_if_empty(void)
 	free(path);
 }
=20
+static int run_post_worktree_add_hook(const char *path)
+{
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
+	strvec_pushl(&hook_opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+	hook_opt.dir =3D path;
+	return run_hooks_opt(the_repository, "post-worktree-add", &hook_opt);
+}
+
 static void prune_worktree(const char *id, const char *reason)
 {
 	if (show_only || verbose)
@@ -605,21 +614,30 @@ static int add_worktree(const char *path, const char =
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
+		hook_ret =3D run_post_worktree_add_hook(wt->path);
+		if (!ret)
+			ret =3D hook_ret;
 	}
=20
 	strvec_clear(&child_env);
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 58b4445cc4..bcdd555ce9 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -1132,6 +1132,117 @@ test_expect_success '"add" in bare repo invokes pos=
t-checkout hook' '
 	test_cmp hook.expect goozy/hook.actual
 '
=20
+# Install a post-worktree-add hook and write the output expected for
+# adding worktree $1; the hook is installed in repo $2 (default ".git").
+post_worktree_add_hook () {
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook -C "$2" post-worktree-add <<-\EOF &&
+	test "$#" =3D 0 &&
+	git rev-parse --git-dir --show-toplevel >hook.actual
+	EOF
+	{
+		echo $(pwd)/${2:-.git}/worktrees/$1 &&
+		echo $(pwd)/$1
+	} >hook.expect
+}
+
+test_expect_success '"add" invokes post-worktree-add hook' '
+	post_worktree_add_hook wanda &&
+	git worktree add wanda &&
+	test_cmp hook.expect wanda/hook.actual
+'
+
+test_expect_success '"add" in other worktree invokes post-worktree-add hoo=
k' '
+	post_worktree_add_hook wilbur &&
+	git -C wanda worktree add ../wilbur &&
+	test_cmp hook.expect wilbur/hook.actual
+'
+
+test_expect_success '"add --no-checkout" still invokes post-worktree-add h=
ook' '
+	post_worktree_add_hook wendy &&
+	git worktree add --no-checkout wendy &&
+	test_cmp hook.expect wendy/hook.actual
+'
+
+test_expect_success '"add --orphan" invokes post-worktree-add hook' '
+	post_worktree_add_hook winnie &&
+	git worktree add --orphan winnie &&
+	test_cmp hook.expect winnie/hook.actual
+'
+
+test_expect_success '"add" in bare repo invokes post-worktree-add hook' '
+	rm -rf bare2 &&
+	git clone --bare . bare2 &&
+	post_worktree_add_hook willow bare2 &&
+	git -C bare2 worktree add --detach ../willow &&
+	test_cmp hook.expect willow/hook.actual
+'
+
+test_expect_success '"add" runs post-worktree-add after post-checkout' '
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-checkout <<-\EOF &&
+	echo post-checkout >>hooks.actual
+	EOF
+	test_hook post-worktree-add <<-\EOF &&
+	echo post-worktree-add >>hooks.actual
+	EOF
+	test_write_lines post-checkout post-worktree-add >hooks.expect &&
+	git worktree add wobble &&
+	test_cmp hooks.expect wobble/hooks.actual
+'
+
+test_expect_success 'failing post-checkout hook does not suppress post-wor=
ktree-add hook' '
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-checkout <<-\EOF &&
+	exit 1
+	EOF
+	test_hook post-worktree-add <<-\EOF &&
+	>post-worktree-add.ran
+	EOF
+	test_must_fail git worktree add wozzle &&
+	test_path_is_file wozzle/post-worktree-add.ran
+'
+
+test_expect_success 'failing post-worktree-add hook leaves worktree in pla=
ce' '
+	test_when_finished "rm -rf .git/hooks" &&
+	mkdir .git/hooks &&
+	test_hook post-worktree-add <<-\EOF &&
+	exit 1
+	EOF
+	test_must_fail git worktree add wilma &&
+	git worktree list --porcelain >out &&
+	grep -F "worktree $(pwd)/wilma" out
+'
+
+test_expect_success 'failed "add" does not invoke post-worktree-add hook' =
'
+	test_when_finished "rm -rf .git/hooks occupied" &&
+	mkdir .git/hooks &&
+	test_hook post-worktree-add <<-\EOF &&
+	>hook.ran
+	EOF
+	mkdir occupied &&
+	: >occupied/blocker &&
+	test_must_fail git worktree add occupied &&
+	test_path_is_missing occupied/hook.ran &&
+	test_path_is_missing hook.ran
+'
+
+test_expect_success 'post-worktree-add hook can derive path with relative =
worktrees' '
+	test_when_finished "rm -rf relhook" &&
+	git init relhook &&
+	test_commit -C relhook base &&
+	test_hook -C relhook post-worktree-add <<-\EOF &&
+	test "$#" =3D 0 &&
+	git rev-parse --show-toplevel >hook.actual
+	EOF
+	git -C relhook worktree add --relative-paths --detach wt &&
+	echo $(pwd)/relhook/wt >hook.expect &&
+	test_cmp hook.expect relhook/wt/hook.actual
+'
+
 test_expect_success '"add" an existing but missing worktree' '
 	git worktree add --detach pneu &&
 	test_must_fail git worktree add --detach pneu &&
--=20
2.54.0
