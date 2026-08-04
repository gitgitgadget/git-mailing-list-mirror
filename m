Received: from mta246b-ord.mtasv.net (mta246b-ord.mtasv.net [104.245.209.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62DD15665C
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 18:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.245.209.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785867434; cv=none; b=NyOQ0a9TRoXwHC2Kv+l+Ky8YxmidHwVaQGz9VhuNTzHU5SUd6FF/cXwWYvg11iOYu5cpGkq3h7OK3T83wLaYIxoVdlTNkIxy2iZ8TDKtZ1OgvAtQW2X/8OpoVYhpuQXJJr3OdBHs2KS7DJAYPKcOxrU/0skwCl710FvKJrr4iNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785867434; c=relaxed/simple;
	bh=uwqHBVkMcQJvoJbnZv3ooNabgx62hrnKfnjayGPkgCI=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StvSHBt8KFPh2HECsqLZ/DMETTtTfZp1c2zsSuUAcCFlxMoAkbXmCDH9J0BTqsxgzTWD39rwcoE0ygHKnsFT8fPu19pqFfnK0UmETZvyFRnd5gEteTKA+cd/Q+9pal4vXrwjJ6DRVXi8wqfWtJg7wzxGeOdIVBnNJg+GmY808fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=Jw5tDkSW; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=hs2c8abN; arc=none smtp.client-ip=104.245.209.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="Jw5tDkSW";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="hs2c8abN"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=rJxQvFmQ/N+lKZhpU7C7ryDxy8zCXy7F4HqMHcuSbVo=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1785867242; x=1786472042;
	b=Jw5tDkSWPF/NYsWEwu3aZX+YZudain3tttl2g0TDpl2yOExv+33g9czpI9GMlb257nECMN01V
	FgSsWAFLSiLnUBVQ6PseROkehc5BGEmVMLw4MY4qvBka/n+WV0yDWfHqrODJ03Aye3QQq+O8uSk
	WpGspaYiviv8alq9KIyhepEckIiFU1Uzn8zrk3kD2bFSGV3Z7GLYGVTiNasoepMBgZZ50536Leg
	9woCFZqo8xz3ZszRFKVDEUZWZ2z/Qn5vpUIr/qj8ajeGf/PKguqm9TjTjQ7/y2HweLcSnWsKpW+
	Jy2yibIAdTYTP7YvDn0pZ5DTgNwCaWY4TcxOXwNtMPQw==;
Received: from ip-172-26-13-251.us-east-2.compute.internal (172.26.13.251)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.242.83) 
  with ESMTP id 459cb2c1903011f19f1302c9fa07781d for <git@vger.kernel.org>;
  Tue, 4 Aug 2026 18:14:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1785867242; x=1786040042;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=rJxQvFmQ/N+lKZhpU7C7ryDxy8zCXy7F4HqMHcuSbVo=;
	b=hs2c8abNS0RIFVHsYLtHEtFRDPd46SB7tu+Fw7ba71NPXN1syRGhO4a0lJtk2koWwvsOhlCWg5U
	Z+YkA+q10y0pWzMq6sYOtUPwwZL/ve2P2d+SHFMOryXvzqb5EnfgtiyYnHSPCW8RBSIl5YE4Gi6BG
	7Tb0bB6A0DHAiOWKKgM=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Tue, 04 Aug 2026 18:14:02 +0000
Subject: [PATCH v2 2/4] worktree: add post-worktree-remove hook
Message-Id: <b9a1cf0c-1cf3-4c36-bf98-1923f9559b61@mtasv.net>
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
X-PM-Message-Id: b9a1cf0c-1cf3-4c36-bf98-1923f9559b61
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.Pcb0gQNNk62Ughg4APhMIA.ExM7Xo1LUsy3fScQxq6pGnyBiF1PrWk_ogCiD9y4UTT077RShG8HAxe4iSvLSMxfVWQlT7JSDdMHyjO5k_d2Q0btuxOVn_NgAWvEdGwZl1SSLDIrt6oWyAdhlOcmKdl0bBUswKGH72uVaOu2s_K_Pxpzm2PSmKA96qsfuB6hmgIof3VITmcxJXe0DSBEaiD0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-virtual-MTA: ord-104-245-209-246
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
 Documentation/config/hook.adoc |  1 +
 Documentation/githooks.adoc    | 18 ++++++++++++++
 builtin/worktree.c             | 10 ++++++++
 t/t2403-worktree-move.sh       | 44 ++++++++++++++++++++++++++++++++++
 4 files changed, 73 insertions(+)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.ado=
c
index 81afb4a919..e013bc1e40 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -95,6 +95,7 @@ hook.jobs::
 `pre-commit`;;
 `post-checkout`;;
 `post-worktree-add`;;
+`post-worktree-remove`;;
 `push-to-checkout`;;
 `post-commit`;;
 	Access the working tree, index, or repository state.
diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 5a2955ee2f..9573b8c1f5 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -233,6 +233,24 @@ runs after the `post-checkout` hook, even if that hook=
 fails.
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
index cc3299bca9..dc456fcac7 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -177,6 +177,14 @@ static int run_post_worktree_add_hook(const char *path=
)
 	return run_hooks_opt(the_repository, "post-worktree-add", &hook_opt);
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
@@ -1444,6 +1452,8 @@ static int remove_worktree(int ac, const char **av, c=
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
