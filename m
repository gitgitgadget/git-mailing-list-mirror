Received: from mta201a-ord.mtasv.net (mta201a-ord.mtasv.net [104.245.209.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6425380FEA
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867435; cv=none; b=SJoibnIMuSaGjfoLu/kNKT/J3a8/tnZicPvigyvEYdGp9ydFVwTYspGbiqzg85dpJU19qJ+q92tZXQSPNQBBQSU8fLM/pAGxGz//A7O1puDmtTZfD5puwQJVzvzyaNDRnG+7LU5JGhJYK0/40sFp0B38/rYDnH7RwfsfSKrDTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867435; c=relaxed/simple;
	bh=g6BGoN9eBIjHDbbiedHpWHQBYKcDU0awDOV/S0i/ILs=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sRxdu4bwhcDi4nYhTRtoy9f2elkqNQiQmsexAzuFKxbNWp/guv+P70nsmutPO8l9fJzg4l9jpG/sEOQw1LtHdOcE1lbt2x1YUaduUtsRD3q+K2rxHhSzRfETp8njsh0FUVSScEmYbLD+7KgcT9methw5PHFqPbwjkJ6ly08kOSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=c+b/tA8N; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=Ab6SNYt+; arc=none smtp.client-ip=104.245.209.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="c+b/tA8N";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="Ab6SNYt+"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=4OcpjqX82gV4aPofIRpzd4YemdkoxYonicw4bJuXjL8=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1785867240; x=1786472040;
	b=c+b/tA8Nc8CnjLCavuYmRo8UY/U96jtppCHa1nvoj2jTGzyv2FzYvl3TGQy2y2R7odNjPNCIC
	jKVTad/0iXhhGYokIN0Y4dlt2QbM97+G++Ycsewslz1lxV+pJXuxioCRIzxK+dmlgWtfN+/gnD1
	VtmP1J1FE4NsoQzI+PiT62+IA+d18u9yl8yvepH/YRPI/D4tTeQxXL0AXxsezwzdWx0o/itujBx
	9NoO+xKJ/rCW7YrUsDD0qxYWue4Wu7MdqUQ0HxxtgCZoowq6vamOPTdfM3E5Qw5Ih+/q8IvgcIb
	Ih+m8Q3BYjuZwTU46Af1ho0MAW7snUZTnigXFNldtU8Q==;
Received: from ip-172-26-23-40.us-east-2.compute.internal (172.26.23.40)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.241.11) 
  with ESMTP id 4482ca09903011f19905021c3a1e5f81 for <git@vger.kernel.org>;
  Tue, 4 Aug 2026 18:14:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1785867240; x=1786040040;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=4OcpjqX82gV4aPofIRpzd4YemdkoxYonicw4bJuXjL8=;
	b=Ab6SNYt+hq0KGgHsabkBwi5tTN7yYCqfXfJHeUfyd24zF53waKKAL9Wu6Y+7taBgPNnjO6md+FJ
	0QZ9iDzEjFH/vpDFsvTkrS3Nm35N+osKHAek2vY36QVV12+8c/0WD1ZM9CXV+7lcMvqrxwjdlkwa4
	28dPaE3qU8X/TvtMCyE=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Tue, 04 Aug 2026 18:14:00 +0000
Subject: [PATCH v2 0/4] worktree: add lifecycle hooks
Message-Id: <371a01cf-2765-4cf5-b1fd-414d1b55a325@mtasv.net>
Reply-To: domen@cachix.org
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine
	<sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
 Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>,
 Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net>
References: <7c8b4673-37ac-45fa-ad8c-a1dc09afe5fe@mtasv.net>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 371a01cf-2765-4cf5-b1fd-414d1b55a325
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.4JqwwWA6fJBWVU7XfhssgA.57BRY58rJoaQQpa7soNRJ80YYjnlSDq1wBk9hENL_k5UNHieq3EYoSwQ1uT6ayuUXvDgqaE4fhbB_NnLtcN7qdFKDgKV6UhwUF_gU8ObKgCDqDj6ejDa1ZMGgn5YhN5uzskZ-XR90YvyYujc6to1JgRfxClxFqO254Q0XaGyM_wjZBStXT92a6qHht4IkKGL
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-201
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi everyone,

First, apologies that my earlier reply reached the list as a separate
message rather than as part of this thread. This is my first patch series
submitted by email, and I am still getting the threading details right. I
have made sure this reroll is plain text and correctly threaded.

I maintain devenv, a developer environment manager, and lately the
workflow we see most is people letting AI coding agents loose on a
repository, one linked worktree per task, created and discarded at a
pace no human would type. Each of those worktrees expects a working
environment: processes, sockets, and stateful services such as a
database seeded from a dump.

Today there is no reliable trigger to set that up when a worktree
appears: post-checkout does not fire for --no-checkout or --orphan
and cannot be told apart from a plain checkout. Nothing fires when a
worktree is moved or removed, so external registrations become stale
and databases and services can pile up after "git worktree remove" or
a manual rm followed by "git worktree prune". Wrapping the worktree
commands only helps when every tool, human or agent, uses the wrapper.

Patch 1 adds a post-worktree-add hook that fires after the working
tree is fully set up. Patch 2 adds post-worktree-remove for "git
worktree remove". Patch 3 extends the remove hook to "git worktree
prune" so that manually deleted worktrees are also observed. Patch 4
adds post-worktree-move so tools can update their path mapping.

Changes since v1:

 * Run post-worktree-add after post-checkout even if post-checkout
   fails, because the populated worktree remains present.

 * Make post-worktree-add take no arguments. Its working directory is
   the new worktree, so its path and identifier can be queried with
   git. This also lets a configured command shared across the hooks
   distinguish add, move, and remove by their argument counts.

 * Add post-worktree-move. It runs in the new location and receives
   the old absolute path as its sole argument.

 * Document the new hooks among those that always run serially.

Thanks to Phillip Wood for the review that prompted these changes.

Thanks,
Domen

Domen Ko=C5=BEar (4):
  worktree: add post-worktree-add hook
  worktree: add post-worktree-remove hook
  worktree: run post-worktree-remove hook when pruning
  worktree: add post-worktree-move hook

 Documentation/config/hook.adoc |   3 +
 Documentation/githooks.adoc    |  56 +++++++++++++++
 builtin/worktree.c             | 123 +++++++++++++++++++++++++--------
 t/t2400-worktree-add.sh        | 111 +++++++++++++++++++++++++++++
 t/t2401-worktree-prune.sh      |  88 +++++++++++++++++++++++
 t/t2403-worktree-move.sh       |  73 +++++++++++++++++++
 worktree.c                     |   1 -
 worktree.h                     |   6 +-
 8 files changed, 428 insertions(+), 33 deletions(-)

Range-diff against v1:
1:  98f06e55c8 ! 1:  73e36c179e worktree: add post-worktree-add hook
    @@ Commit message
         Introduce a post-worktree-add hook that runs after the working tre=
e
         has been fully set up, including with --no-checkout and --orphan. =
The
         hook runs inside the new working tree with GIT_DIR and GIT_WORK_TR=
EE
    -    cleared, mirroring the existing post-checkout invocation, and is g=
iven
    -    the absolute path of the new working tree and its identifier as
    -    arguments. Anything else, such as the checked-out branch, can be
    -    queried by running git from the hook's working directory.
    +    cleared, mirroring the existing post-checkout invocation, and take=
s no
    +    arguments. Details such as the absolute path, worktree identifier,=
 and
    +    checked-out branch can be queried by running git from the hook's w=
orking
    +    directory. Taking no arguments also lets a configured command shar=
ed
    +    with post-worktree-remove distinguish the events by argument count=
.
    =20
         Like post-checkout, the hook cannot affect the outcome of the comm=
and:
         a failing hook does not delete the already-created working tree, b=
ut
         its exit status becomes the exit status of "git worktree add". The
    -    hook runs after post-checkout and is skipped if that hook fails.
    +    hook runs after post-checkout, even when post-checkout fails, beca=
use
    +    the worktree has still been populated and remains present.
    =20
         Documenting the new hook in githooks(5) also registers its name in=
 the
         generated hook-list.h, so "git hook run" and hook.*.event recogniz=
e it
    @@ Commit message
         Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
         Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
    =20
    + ## Documentation/config/hook.adoc ##
    +@@ Documentation/config/hook.adoc: hook.jobs::
    + 	Receive a commit message file and may rewrite it in place.
    + `pre-commit`;;
    + `post-checkout`;;
    ++`post-worktree-add`;;
    + `push-to-checkout`;;
    + `post-commit`;;
    + 	Access the working tree, index, or repository state.
    +
      ## Documentation/githooks.adoc ##
     @@ Documentation/githooks.adoc: This hook can be used to perform repos=
itory validity checks, auto-display
      differences from the previous HEAD if different, or set working dir m=
etadata
    @@ Documentation/githooks.adoc: This hook can be used to perform reposi=
tory validit
     +~~~~~~~~~~~~~~~~~
     +
     +This hook is invoked by linkgit:git-worktree[1] after `git worktree a=
dd`
    -+has created and set up a new working tree. The hook is given two
    -+parameters: the absolute path of the new working tree and its identif=
ier
    -+(the name of its administrative directory in `$GIT_DIR/worktrees/`).
    ++has created and set up a new working tree. It takes no parameters.
     +
    -+The hook runs inside the new working tree, so further details, such a=
s
    -+the checked-out branch, can be queried by running `git` from the hook=
's
    -+current directory. Unlike the `post-checkout` hook, it is also run wh=
en
    -+`--no-checkout` or `--orphan` is used.
    ++The hook's current working directory is the new working tree, so furt=
her
    ++details, such as its absolute path, identifier, and checked-out branc=
h,
    ++can be queried by running `git`. Unlike the `post-checkout` hook, it =
is
    ++also run when `--no-checkout` or `--orphan` is used.
     +
     +This hook cannot affect the outcome of `git worktree add`, other than
     +that the hook's exit status becomes the exit status of the command. I=
t
    -+runs after the `post-checkout` hook, and is skipped if that hook fail=
s.
    ++runs after the `post-checkout` hook, even if that hook fails.
     +
     +This hook can be used to set up per-worktree development environments
     +or to register the new working tree with external tools.
    @@ Documentation/githooks.adoc: This hook can be used to perform reposi=
tory validit
     =20
    =20
      ## builtin/worktree.c ##
    +@@ builtin/worktree.c: static void delete_worktrees_dir_if_empty(void)
    + 	free(path);
    + }
    +=20
    ++static int run_post_worktree_add_hook(const char *path)
    ++{
    ++	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
    ++
    ++	strvec_pushl(&hook_opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
    ++	hook_opt.dir =3D path;
    ++	return run_hooks_opt(the_repository, "post-worktree-add", &hook_opt)=
;
    ++}
    ++
    + static void prune_worktree(const char *id, const char *reason)
    + {
    + 	if (show_only || verbose)
     @@ builtin/worktree.c: static int add_worktree(const char *path, const=
 char *refname,
      	}
     =20
    @@ builtin/worktree.c: static int add_worktree(const char *path, const =
char *refnam
     +	 * is_junk is cleared, but do return appropriate code when a hook
     +	 * fails.
      	 */
    - 	if (!ret && opts->checkout && !opts->orphan) {
    - 		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
    -@@ builtin/worktree.c: static int add_worktree(const char *path, const=
 char *refname,
    - 		ret =3D run_hooks_opt(the_repository, "post-checkout", &opt);
    - 	}
    -=20
    +-	if (!ret && opts->checkout && !opts->orphan) {
    +-		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
    +-
    +-		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
    +-		strvec_pushl(&opt.args,
    +-			     oid_to_hex(null_oid(the_hash_algo)),
    +-			     oid_to_hex(&commit->object.oid),
    +-			     "1",
    +-			     NULL);
    +-		opt.dir =3D path;
    +-
    +-		ret =3D run_hooks_opt(the_repository, "post-checkout", &opt);
     +	if (!ret) {
    -+		struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
    ++		int hook_ret;
    ++
    ++		if (opts->checkout && !opts->orphan) {
    ++			struct run_hooks_opt opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
     +
    -+		strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
    -+		strvec_pushl(&opt.args, wt->path, wt->id, NULL);
    -+		opt.dir =3D path;
    ++			strvec_pushl(&opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
    ++			strvec_pushl(&opt.args,
    ++				     oid_to_hex(null_oid(the_hash_algo)),
    ++				     oid_to_hex(&commit->object.oid),
    ++				     "1",
    ++				     NULL);
    ++			opt.dir =3D path;
     +
    -+		ret =3D run_hooks_opt(the_repository, "post-worktree-add", &opt);
    -+	}
    ++			ret =3D run_hooks_opt(the_repository, "post-checkout", &opt);
    ++		}
     +
    ++		hook_ret =3D run_post_worktree_add_hook(wt->path);
    ++		if (!ret)
    ++			ret =3D hook_ret;
    + 	}
    +=20
      	strvec_clear(&child_env);
    - 	strbuf_release(&sb);
    - 	strbuf_release(&symref);
    =20
      ## t/t2400-worktree-add.sh ##
     @@ t/t2400-worktree-add.sh: test_expect_success '"add" in bare repo in=
vokes post-checkout hook' '
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" in bare repo inv=
okes post-ch
     +	test_when_finished "rm -rf .git/hooks" &&
     +	mkdir .git/hooks &&
     +	test_hook -C "$2" post-worktree-add <<-\EOF &&
    -+	{
    -+		echo $*
    -+		git rev-parse --git-dir --show-toplevel
    -+	} >hook.actual
    ++	test "$#" =3D 0 &&
    ++	git rev-parse --git-dir --show-toplevel >hook.actual
     +	EOF
     +	{
    -+		echo $(pwd)/$1 $1 &&
     +		echo $(pwd)/${2:-.git}/worktrees/$1 &&
     +		echo $(pwd)/$1
     +	} >hook.expect
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" in bare repo inv=
okes post-ch
     +	test_cmp hooks.expect wobble/hooks.actual
     +'
     +
    -+test_expect_success 'failing post-checkout hook suppresses post-workt=
ree-add hook' '
    ++test_expect_success 'failing post-checkout hook does not suppress pos=
t-worktree-add hook' '
     +	test_when_finished "rm -rf .git/hooks" &&
     +	mkdir .git/hooks &&
     +	test_hook post-checkout <<-\EOF &&
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" in bare repo inv=
okes post-ch
     +	>post-worktree-add.ran
     +	EOF
     +	test_must_fail git worktree add wozzle &&
    -+	test_path_is_missing wozzle/post-worktree-add.ran
    ++	test_path_is_file wozzle/post-worktree-add.ran
     +'
     +
     +test_expect_success 'failing post-worktree-add hook leaves worktree i=
n place' '
    @@ t/t2400-worktree-add.sh: test_expect_success '"add" in bare repo inv=
okes post-ch
     +	test_path_is_missing hook.ran
     +'
     +
    -+test_expect_success 'post-worktree-add hook gets absolute path with r=
elative worktrees' '
    ++test_expect_success 'post-worktree-add hook can derive path with rela=
tive worktrees' '
     +	test_when_finished "rm -rf relhook" &&
     +	git init relhook &&
     +	test_commit -C relhook base &&
     +	test_hook -C relhook post-worktree-add <<-\EOF &&
    -+	echo $* >hook.actual
    ++	test "$#" =3D 0 &&
    ++	git rev-parse --show-toplevel >hook.actual
     +	EOF
     +	git -C relhook worktree add --relative-paths --detach wt &&
    -+	echo $(pwd)/relhook/wt wt >hook.expect &&
    ++	echo $(pwd)/relhook/wt >hook.expect &&
     +	test_cmp hook.expect relhook/wt/hook.actual
     +'
     +
2:  7e109ece23 ! 2:  3de87064c0 worktree: add post-worktree-remove hook
    @@ Commit message
         Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
         Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
    =20
    + ## Documentation/config/hook.adoc ##
    +@@ Documentation/config/hook.adoc: hook.jobs::
    + `pre-commit`;;
    + `post-checkout`;;
    + `post-worktree-add`;;
    ++`post-worktree-remove`;;
    + `push-to-checkout`;;
    + `post-commit`;;
    + 	Access the working tree, index, or repository state.
    +
      ## Documentation/githooks.adoc ##
    -@@ Documentation/githooks.adoc: runs after the `post-checkout` hook, a=
nd is skipped if that hook fails.
    +@@ Documentation/githooks.adoc: runs after the `post-checkout` hook, e=
ven if that hook fails.
      This hook can be used to set up per-worktree development environments
      or to register the new working tree with external tools.
     =20
    @@ Documentation/githooks.adoc: runs after the `post-checkout` hook, an=
d is skipped
     =20
    =20
      ## builtin/worktree.c ##
    -@@ builtin/worktree.c: static void delete_worktrees_dir_if_empty(void)
    - 	free(path);
    +@@ builtin/worktree.c: static int run_post_worktree_add_hook(const cha=
r *path)
    + 	return run_hooks_opt(the_repository, "post-worktree-add", &hook_opt)=
;
      }
     =20
     +static int run_post_worktree_remove_hook(const char *path, const char=
 *id)
3:  143da548e4 =3D 3:  7989a1d6a2 worktree: run post-worktree-remove hook w=
hen pruning
-:  ---------- > 4:  95ab61e377 worktree: add post-worktree-move hook
--=20
2.54.0
