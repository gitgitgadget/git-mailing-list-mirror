Received: from mta203-ab1.mtasv.net (mta203-ab1.mtasv.net [50.31.205.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C933C5526
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.31.205.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867434; cv=none; b=daXABilc1Zp3APxCYFoC1FkBUtDtVaNCt0FGTZjb0SUuFo3Qa7Ygp5AOaPFcRzN/TjD+Qm+7y2OR5ip0iRzkd8a/uy4ug+SxmGQrvvKWaMW66HLrQvvXKvEeYqYWiJI8DvGwQS70i8rNnl0gr0ugUdgfQqWKCtZ4QfWnGHAXgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867434; c=relaxed/simple;
	bh=NC3CCKkAmDr11QujbqzEFwUmozHwdRbjkE8pRPpZFWI=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/cFP9jXnkf6TcDWZWYFdOgh9PoMfFS+/yNIQBmu10wJnemNNJKdKl9fubgJCBvIizAliHiU+yoWHkeCvoIUK6eqPN0ipaAQtKLqueSpLZkJbBj9eNsu3gc65G7iUtQtZWfKIzxpYkhyzecbiab3DOm4L6GWL90BAD1s9z04wmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=glnzBKBT; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=OgkExDxX; arc=none smtp.client-ip=50.31.205.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="glnzBKBT";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="OgkExDxX"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=GQwri9jgj/dKJ1DtTnDEisnwXi6m/7vTRN4UqO+kaY4=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1785867244; x=1786472044;
	b=glnzBKBTWPFt9Ho4dcCbgnL1/GO1YNMMATxIh+o6pkAndL1mRB87/TBH1R21bQOxzvulhiALz
	sARHZz03hDB+rzR4EoVqQlPhBYvokxMhojWyJ7ouTOH/JN+K2biYSUslVr16jjK2en9WxxrXBKn
	tFOrrrPOqCnCnlG3txshRRqDLigQpnhmKvJSXeaNSCpwtB+VO1Rtxb76gpavMe6XSq912UBipSR
	akfSKpIwRWu4nM2N+1N7yvwvJN5zUBOLCvrUzS0QRH6s8PE64sA5SEweZeT9+qCgA/+Q8O/6/nW
	D3YAC48Bk60wF8xeKmONLQCXs1OoEVQelMSmd2Ux8EoA==;
Received: from ip-172-26-13-144.us-east-2.compute.internal (172.26.13.144)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.242.240) 
  with ESMTP id 46c05207903011f1bf3b0262fedbb1f9 for <git@vger.kernel.org>;
  Tue, 4 Aug 2026 18:14:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1785867244; x=1786040044;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=GQwri9jgj/dKJ1DtTnDEisnwXi6m/7vTRN4UqO+kaY4=;
	b=OgkExDxXATp3i8UglTQ6ZCUOY3x/6/4r5VW2v74i974d1xXO4NYQAVzlVRCYuVM5Tr8sV4zva/H
	IQDMIw8Tx3wJ4hnohtIPHMSOrXl++Rs7X2h4Y3Iitr0/zv0663Yw1erp/sXw1mzm3da5amVEPp+ls
	sM+lC79IuoE7OULJWgs=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Tue, 04 Aug 2026 18:14:04 +0000
Subject: [PATCH v2 4/4] worktree: add post-worktree-move hook
Message-Id: <625cef65-0197-4da3-81e0-de786f34a1cb@mtasv.net>
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
X-PM-Message-Id: 625cef65-0197-4da3-81e0-de786f34a1cb
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.r-jNq0FAuWCmuR6uTFa2Mw.JSYBrznRMQa9FR4JT_TA71YHvMlTsF6SFy5BXiMqXMWYVxbSz-LdQ9mQsGoDkqmjciJX6xf4uuTu_1M5sLOxbGu_XjUouXoY-XQjin6z3IbEqVCnnJAi47MpYeGpDjll77EgxQmonTv5C8EktpswV9sCS132WgZaJPuqODtzBq2K-1JS1s8ADOzC5r_Ch61l
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: mta203-ab1
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Tools that record worktree paths can keep their state up to date when a
worktree is added or removed, but the mapping becomes stale when the
worktree is moved. Services or other per-worktree state tied to the old
path may also need to be relocated.

Introduce a post-worktree-move hook that runs after the working tree and
its administrative files have been moved. The hook runs inside the new
working tree with GIT_DIR and GIT_WORK_TREE cleared and receives the old
absolute path as its sole argument. The new path and worktree identifier
can be queried by running git from the hook's working directory.

This signature also lets one configured command handle all three
worktree lifecycle hooks by argument count: post-worktree-add takes no
arguments, post-worktree-move takes one, and post-worktree-remove takes
two.

A failing hook does not undo the completed move, but its exit status
becomes the exit status of "git worktree move".

Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
---
 Documentation/config/hook.adoc |  1 +
 Documentation/githooks.adoc    | 17 +++++++++++++++++
 builtin/worktree.c             | 19 +++++++++++++++++--
 t/t2403-worktree-move.sh       | 29 +++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.ado=
c
index e013bc1e40..32511b56fd 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -95,6 +95,7 @@ hook.jobs::
 `pre-commit`;;
 `post-checkout`;;
 `post-worktree-add`;;
+`post-worktree-move`;;
 `post-worktree-remove`;;
 `push-to-checkout`;;
 `post-commit`;;
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index fdf697b12f..0392454756 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -233,6 +233,23 @@ runs after the `post-checkout` hook, even if that hook=
 fails.
 This hook can be used to set up per-worktree development environments
 or to register the new working tree with external tools.
=20
+post-worktree-move
+~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-worktree[1] after `git worktree move`
+has moved a working tree and updated its administrative files. It is given
+one parameter: the absolute path of the working tree before it was moved.
+
+The hook's current working directory is the new working tree, so its new
+absolute path and identifier can be queried by running `git`.
+
+This hook cannot affect the outcome of `git worktree move`, other than
+that the hook's exit status becomes the exit status of the command. A
+failing hook does not undo the move.
+
+This hook can be used to update per-worktree development environments or
+registrations with external tools after their working tree has moved.
+
 post-worktree-remove
 ~~~~~~~~~~~~~~~~~~~~
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index e0c37039ac..55df3c6a8f 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -185,6 +185,17 @@ static int run_post_worktree_remove_hook(const char *p=
ath, const char *id)
 	return run_hooks_opt(the_repository, "post-worktree-remove", &hook_opt);
 }
=20
+static int run_post_worktree_move_hook(const char *old_path,
+				       const char *new_path)
+{
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
+	strvec_pushl(&hook_opt.env, "GIT_DIR", "GIT_WORK_TREE", NULL);
+	strvec_push(&hook_opt.args, old_path);
+	hook_opt.dir =3D new_path;
+	return run_hooks_opt(the_repository, "post-worktree-move", &hook_opt);
+}
+
 static int prune_worktree(const char *id, const char *dotgit,
 			  const char *reason)
 {
@@ -1306,7 +1317,8 @@ static int move_worktree(int ac, const char **av, con=
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
@@ -1349,14 +1361,17 @@ static int move_worktree(int ac, const char **av, c=
onst char *prefix,
 		    errmsg.buf);
 	strbuf_release(&errmsg);
=20
+	old_path =3D xstrdup(wt->path);
 	if (rename(wt->path, dst.buf) =3D=3D -1)
 		die_errno(_("failed to move '%s' to '%s'"), wt->path, dst.buf);
=20
 	update_worktree_location(wt, dst.buf, use_relative_paths);
+	ret =3D run_post_worktree_move_hook(old_path, wt->path);
=20
+	free(old_path);
 	strbuf_release(&dst);
 	free_worktrees(worktrees);
-	return 0;
+	return ret;
 }
=20
 /*
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index b94f00e426..0ffcfe88f7 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -82,6 +82,35 @@ test_expect_success 'move worktree' '
 	test_cmp expected2 actual2
 '
=20
+test_expect_success '"move" invokes post-worktree-move hook' '
+	test_hook post-worktree-move <<-\EOF &&
+	test "$#" =3D 1 &&
+	{
+		echo "$1" &&
+		git rev-parse --git-dir --show-toplevel
+	} >hook.actual
+	EOF
+	git worktree add --detach hook-source &&
+	git worktree move hook-source hook-destination &&
+	{
+		echo "$(pwd)/hook-source" &&
+		echo "$(pwd)/.git/worktrees/hook-source" &&
+		echo "$(pwd)/hook-destination"
+	} >hook.expect &&
+	test_cmp hook.expect hook-destination/hook.actual
+'
+
+test_expect_success 'failing post-worktree-move hook leaves worktree moved=
' '
+	test_hook post-worktree-move <<-\EOF &&
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
 test_expect_success 'move main worktree' '
 	test_must_fail git worktree move . def
 '
--=20
2.54.0
