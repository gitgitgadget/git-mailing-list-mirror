Received: from mta200a-ord.mtasv.net (mta200a-ord.mtasv.net [104.245.209.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA714499A4
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783640355; cv=none; b=LkWov6kFZAqfVQqN+wFWh3/nK+QKsoRcc+q8HXe48/l9903ypNYZeShsAf0p4pk+8yBMsukluq0PZdv3Cr4qNXEI5HpzhZx6WJn6yfFE53Q+jsUCbNshoMA5aAMkEDcq+NOTrnKI3TebMe+37q+q95KrjyHv+VCk3VrEv42oD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783640355; c=relaxed/simple;
	bh=oD34PQnz3bfpr1kM2h4SSRWWY2dQda9hSZx9FNeEkjA=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5foEOUcdJlbmxMTM/6ARgjvL1AohG/gq2yWNhHnMfjUu6uvhXeWK1rIVaneVISW75Rdx0rGewaXqsNiwVPx/1fU3uoCEiOAYJDLVGeQRwXYwuj/ZL5TG7MQYdHzQFQrGw/poZnCv2FQaUjnl4DARGiXD73I7nLJI5yZ0PF6JbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=ZzBZAao/; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=hrUWntmP; arc=none smtp.client-ip=104.245.209.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="ZzBZAao/";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="hrUWntmP"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=pRAQk5TrrStIp7aCYfMLI0Mywu+LONlqqUlunSesj/E=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1783640170; x=1784244970;
	b=ZzBZAao/yUBZu6GDkJdIHYu17Fqx5xA/rNpjr9+FJ3Ar9rM/nsGSfwd2hG1fa9OZ9qrEmTdrc
	OfAJRWETPdQvZWJMZqPoVIxo3uHlCg5EWBmBiimx2XfEwjATfbQ4EFBFOfhG2zFOPyuJ6dekRbK
	NVJI2VivfedhtxFOeIThdISJXUQh+X9JMVQxPdgoWzHP/iT5JGMst2TKwATsOGaslRjWRkGlgFc
	gDsI3EfyhN4vQnYvCksLUQB48Bbdi31/KneWUqpkqBuV1jKRKaglqNV17h0A/O5hPgmNzBqFQS+
	wT7WGsGsqbtLX80LfS7NZCLGIAUrewc84f861lsWpHGA==;
Received: from ip-172-26-33-70.us-east-2.compute.internal (172.26.33.70)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.243.64) 
  with ESMTP id f75dcd0f7bee11f1bf74023b8cb8aba3 for <git@vger.kernel.org>;
  Thu, 9 Jul 2026 23:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1783640170; x=1783812970;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=pRAQk5TrrStIp7aCYfMLI0Mywu+LONlqqUlunSesj/E=;
	b=hrUWntmP/nzrNLS5+Zscsohhw4ds8NU7WXzMjboVsaNBSIi2qJJSAwiVTXaifT7MQcWgPHxW5Tl
	Vvd6RvGHOykPv9dSZinK6+TA1RZmZVdkkyINaCd9qMQHoDQ0BVkYrKrjirwDVfG7ieyJh0TlYi8Zo
	LT4ltVVqV46j0iBvgDU=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Thu, 09 Jul 2026 23:36:10 +0000
Subject: [PATCH v1 2/3] worktree: add post-worktree-remove hook
Message-Id: <746fccc3-8700-4413-96a6-d98da7cf678a@mtasv.net>
Reply-To: domen@cachix.org
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, Patrick Steinhardt <ps@pks.im>,
 =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
 Caleb White <cdwhite3@pm.me>, Junio C Hamano <gitster@pobox.com>,
 Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>, Claude Fable 5
	<noreply@anthropic.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709233542.628628-1-domen@cachix.org>
References: <20260709233542.628628-1-domen@cachix.org>
Feedback-ID: s19907644-_:s19907644:a442084:postmark
X-Complaints-To: abuse@postmarkapp.com
X-Job: 442084_19907644
X-PM-Message-Id: 746fccc3-8700-4413-96a6-d98da7cf678a
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.8CQYBpMR7xfYfIJt4ckIpQ.PgIK1kWZnls00GCJ3290XXIGdHBlpqDe_rUynI58VCjRWO-fN1RusuUiQE6IPU_a7xoUEVZC4vw4lrUyEG-3vdx5-Utv2hoqptRgjg5IHpm63XUUFQCLUbuxfRmC_yZjLpdDoBoAlP0TyqlrDeaxJmGR6WAMO24R7v1smSHArOgi7mYcZxonTZNfrE7M9T6-
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-200
X-PM-MTA-Pool: transactional-3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

External tooling has no way to learn that a working tree is gone:
"git worktree remove" deletes both the working tree and its
administrative directory without running any hook.

Introduce a post-worktree-remove hook that runs after "git worktree
remove" has deleted a working tree. It is given the former absolute
path of the working tree and its identifier as arguments. The hook
also runs when only the administrative entry is deleted because the
working tree directory itself had already disappeared, since the
worktree is deregistered either way.

Because the working tree no longer exists at that point, no special
working directory or environment is set up; the hook runs wherever
the command ran, like other post-command hooks.

The hook runs once deletion is underway even if parts of it fail,
since there is no going back at that point, but it does not run when
the removal is refused (locked or dirty working tree, failed
validation). It cannot affect the outcome of the command other than
its exit status being reflected in the exit status of "git worktree
remove".

Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>
---
 Documentation/githooks.adoc | 18 +++++++++++++++
 builtin/worktree.c          | 10 +++++++++
 t/t2403-worktree-move.sh    | 44 +++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 2778f73f30..22b3263ff7 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -235,6 +235,24 @@ runs after the `post-checkout` hook, and is skipped if=
 that hook fails.
 This hook can be used to set up per-worktree development environments
 or to register the new working tree with external tools.
=20
+post-worktree-remove
+~~~~~~~~~~~~~~~~~~~~
+
+This hook is invoked by linkgit:git-worktree[1] after a working tree
+has been deleted by `git worktree remove`. The hook is given two
+parameters: the absolute path of the removed working tree and its
+identifier (the name of its former administrative directory in
+`$GIT_DIR/worktrees/`).
+
+The working tree no longer exists when the hook runs.
+
+This hook cannot affect the outcome of `git worktree remove`, other
+than that the hook's exit status becomes the exit status of the
+command.
+
+This hook can be used to tear down per-worktree development
+environments or to unregister the working tree from external tools.
+
 post-merge
 ~~~~~~~~~~
=20
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7b9d337234..01b62ed2fc 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -168,6 +168,14 @@ static void delete_worktrees_dir_if_empty(void)
 	free(path);
 }
=20
+static int run_post_worktree_remove_hook(const char *path, const char *id)
+{
+	struct run_hooks_opt hook_opt =3D RUN_HOOKS_OPT_INIT_FORCE_SERIAL;
+
+	strvec_pushl(&hook_opt.args, path, id, NULL);
+	return run_hooks_opt(the_repository, "post-worktree-remove", &hook_opt);
+}
+
 static void prune_worktree(const char *id, const char *reason)
 {
 	if (show_only || verbose)
@@ -1437,6 +1445,8 @@ static int remove_worktree(int ac, const char **av, c=
onst char *prefix,
 	ret |=3D delete_git_dir(wt->id);
 	delete_worktrees_dir_if_empty();
=20
+	ret |=3D run_post_worktree_remove_hook(wt->path, wt->id);
+
 	free_worktrees(worktrees);
 	return ret;
 }
diff --git a/t/t2403-worktree-move.sh b/t/t2403-worktree-move.sh
index 0bb33e8b1b..b94f00e426 100755
--- a/t/t2403-worktree-move.sh
+++ b/t/t2403-worktree-move.sh
@@ -246,6 +246,50 @@ test_expect_success 'not remove a repo with initialize=
d submodule' '
 	)
 '
=20
+test_expect_success '"remove" invokes post-worktree-remove hook' '
+	test_hook post-worktree-remove <<-\EOF &&
+	echo $* >hook.actual
+	EOF
+	git worktree add --detach wt-hooked &&
+	git worktree remove wt-hooked &&
+	echo $(pwd)/wt-hooked wt-hooked >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success '"remove" of missing worktree invokes post-worktree-re=
move hook' '
+	test_when_finished "rm -rf wt-moved-away" &&
+	test_hook post-worktree-remove <<-\EOF &&
+	echo $* >hook.actual
+	EOF
+	rm -f hook.actual &&
+	git worktree add --detach wt-elsewhere &&
+	mv wt-elsewhere wt-moved-away &&
+	git worktree remove wt-elsewhere &&
+	echo $(pwd)/wt-elsewhere wt-elsewhere >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'refused "remove" does not invoke post-worktree-remove=
 hook' '
+	git worktree add --detach wt-kept &&
+	test_when_finished "git worktree remove --force --force wt-kept || :" &&
+	test_hook post-worktree-remove <<-\EOF &&
+	>hook.ran
+	EOF
+	git worktree lock wt-kept &&
+	test_must_fail git worktree remove wt-kept &&
+	test_path_is_missing hook.ran
+'
+
+test_expect_success 'failing post-worktree-remove hook fails "remove", wor=
ktree is gone' '
+	test_hook post-worktree-remove <<-\EOF &&
+	exit 1
+	EOF
+	git worktree add --detach wt-doomed &&
+	test_must_fail git worktree remove wt-doomed &&
+	test_path_is_missing wt-doomed &&
+	test_path_is_missing .git/worktrees/wt-doomed
+'
+
 test_expect_success 'move worktree with absolute path to relative path' '
 	test_config worktree.useRelativePaths false &&
 	git worktree add ./absolute &&
--=20
2.54.0
