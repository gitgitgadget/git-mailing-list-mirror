Received: from mta206-ab1.mtasv.net (mta206-ab1.mtasv.net [50.31.205.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397D4424D76
	for <git@vger.kernel.org>; Sun,  4 Oct 2026 23:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.31.205.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791155545; cv=none; b=m7NEYzV4dtLPmR9dEbVKTNsad7ISLgbxdlongkgqZTKZos+gO+Eh/j1jDE1jtO4duUNRGNLBo5RQMwx52Qu//Tr1BN+xkKfOJl6ysmlC0IKi64w9A2TQGucrp05S3R+BjufbTSuSqnv6TPll3eakxWTvQ65jiGgPnfy7k5EOHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791155545; c=relaxed/simple;
	bh=uBkkYguhjyLH1UmK7ePFB2Cd+YknCMOALRQ7yUuzhOc=;
	h=From:Date:Subject:Message-Id:To:Cc:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HgcrTYxtYOILOod8cGKTRdAPnyXTEbVZDFxVROiartobvf2b+GX9k47b8hLLi/ZWnrYQGkBS2Ce/Nxe5BhNBVXSo98wq8wGpVjw/Vf8Ox3JjQfqA+H03y6FC6wSXWCaOvieFROut6btQpOAEJpdhAdT4FnbzXx0+X37nN68gt8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org; dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b=Vf/HRIb9; dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b=kc9/rpqk; arc=none smtp.client-ip=50.31.205.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cachix.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm-bounces.cachix.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.mtasv.net header.i=@pm.mtasv.net header.b="Vf/HRIb9";
	dkim=pass (1024-bit key) header.d=cachix.org header.i=domen@cachix.org header.b="kc9/rpqk"
X-KumoRef: eyJfQF8iOiJcXF8vIiwicmVjaXBpZW50IjoiZ2l0QHZnZXIua2VybmVsLm9yZyJ9
DKIM-Signature: v=1; a=rsa-sha256; d=pm.mtasv.net; s=pm20250806; c=relaxed/relaxed;
	bh=R+5uo005PKJltGRcFScSv4Qg1ntnLsUKPBga4YdTbE0=;
	h=from:to:subject:date:mime-version:content-type:sender:cc:date:message-id;
	t=1791155348; x=1791760148;
	b=Vf/HRIb9QdSu6fI001IzAwf8TtmVgvCxQjwWFZBBle1lqINkHxg99WSBsCOgK3HIl7p1XHaPs
	xI3kXOpVOSdAoylYQzaEmxNZ3ynIk4d5yaLmvg9cQGJqOSkZpz/1+wRTKE9nthFaKwlVDTLTCRs
	E1Hg8Eqd111D2PHbKZs39LijnGqAxJz5tG+4+J6e+VOPR/OIf0UuaiCvKAH1Nr9eIbF6nJYKaj+
	4FEZH1ZaJzztO1qNFfQRndZjjYaUld6udKS3wmEiDgkn+KEjMPK9bRvJzYvW1s90KfAwjPljT1x
	vQQeEQFDRS+kByw0O5tT060vvFaDoBJhEANAjRfOhQlQ==;
Received: from ip-172-26-33-56.us-east-2.compute.internal (172.26.33.56)
  by production-pmta-useast2.internal.postmarkapp.com (KumoMTA 10.97.242.126) 
  with ESMTP id 9a7c6f56c04811f1b76d02ffd1c746df for <git@vger.kernel.org>;
  Sun, 4 Oct 2026 23:09:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; d=cachix.org; s=20250802170654pm;
	c=relaxed/relaxed; i=domen@cachix.org; t=1791155348; x=1791328148;
	h=date:date:from:from:message-id:reply-to:reply-to:sender:subject:subject:to:
	to:cc:in-reply-to:references:feedback-id:mime-version:content-type:
	content-transfer-encoding;
	bh=R+5uo005PKJltGRcFScSv4Qg1ntnLsUKPBga4YdTbE0=;
	b=kc9/rpqkHpsQ3hz2cSjAEAD6JNOJ5NzFQ+eDg/7kKyPtAiIQXEBJtR+3MhMWdIHQnyrDEz/GbMX
	wMmFDR4CGnXsBsEwRQbwjuV/uvV/MUBo8IsBUPYAvmHFI4IEx9rSYvI1c8oZGvwNXL6rZRejUrGAq
	qa+hk/ozXNEaizOrDZY=
From: Domen =?utf-8?b?S2/FvmFy?= <domen@cachix.org>
Date: Sun, 04 Oct 2026 23:09:08 +0000
Subject: [PATCH v3 2/2] worktree: notify post-worktree hook when pruning
Message-Id: <f7ead9bc-fe6e-49c1-bb7d-6efd14eb6766@mtasv.net>
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
X-PM-Message-Id: f7ead9bc-fe6e-49c1-bb7d-6efd14eb6766
X-PM-RCPT: |bTF8NDQyMDg0fDE5OTA3NjQ0fGdpdEB2Z2VyLmtlcm5lbC5vcmc=|
X-PM-Message-Options: v1;1.fZbNrKIc78yXI0tNJiFriA.5-WEV2nMBYEioVf_dfZdSnS4hCq9tI7bNgqorNpVuSCt30yoIOFaEwMq6nmuZ520Om0zXYEhwQjT0w_sium0vFNlRksGMeJi5x6vlc-T8FffjOTtPKT307e6plRB6I-WgHfu2eWhuhn8hONAvQ5yWN5BZyAqhVo7hDW4VQwM2nsSQPm_JjcZ83gRioaUShwa
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

A worktree can disappear without git worktree remove, for example when
its directory is deleted manually. Tools maintaining per-worktree state
need to observe its later deregistration by git worktree prune as well.
Git knows which entries it prunes, including duplicates, whereas a
wrapper comparing worktree listings can race concurrent operations and
has limited information about damaged entries.

Emit a post-worktree remove event for each pruned administrative entry,
with its identifier and former absolute path. Return the recorded .git
path from should_prune_worktree() even when it points to a missing
location, so the hook can receive the former worktree path. If the path
cannot be determined, pass an empty string instead.

Do not invoke the hook during a dry run. Reflect hook failures in the
command's exit status while continuing to process the remaining entries.
Document pruning and test missing paths, duplicate entries, relative
paths, dry runs, and failures that must not suppress other notifications.

Co-authored-by: Claude Fable 5 <noreply@anthropic.com>
Signed-off-by: Domen Ko=C5=BEar <domen@cachix.org>
---
 Documentation/githooks.adoc |   7 ++-
 builtin/worktree.c          |  49 ++++++++++++-----
 t/t2401-worktree-prune.sh   | 102 ++++++++++++++++++++++++++++++++++++
 worktree.c                  |   1 -
 worktree.h                  |   6 +--
 5 files changed, 146 insertions(+), 19 deletions(-)

diff --git a/Documentation/githooks.adoc b/Documentation/githooks.adoc
index 3e25f769c5..a625e95eff 100644
--- a/Documentation/githooks.adoc
+++ b/Documentation/githooks.adoc
@@ -219,7 +219,8 @@ post-worktree
 ~~~~~~~~~~~~~
=20
 This hook is invoked by linkgit:git-worktree[1] after a working tree is
-added, moved, or removed. It takes four parameters: the event (`add`, `mov=
e`,
+added, moved, or removed, and once for each entry removed by
+`git worktree prune`. It takes four parameters: the event (`add`, `move`,
 or `remove`), the worktree identifier (the name of its administrative
 directory in `$GIT_COMMON_DIR/worktrees/`), the old absolute path, and the
 new absolute path.
@@ -231,7 +232,9 @@ The parameters for each event are:
     post-worktree remove <id> <old-path> ""
=20
 The empty strings are passed as arguments, so all events have exactly
-four parameters.
+four parameters. For entries pruned by `git worktree prune`, the old path
+may also be empty if it cannot be determined from the administrative
+files. No hook is run for `git worktree prune --dry-run`.
=20
 The hook runs in the repository where the command was invoked, following
 the working directory and environment rules described above. It does not
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 0f2748080c..d2319a1991 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -177,12 +177,27 @@ static int run_post_worktree_hook(const char *event, =
const char *id,
 	return run_hooks_opt(the_repository, "post-worktree", &hook_opt);
 }
=20
-static void prune_worktree(const char *id, const char *reason)
+static int prune_worktree(const char *id, const char *dotgit,
+			  const char *reason)
 {
+	struct strbuf path =3D STRBUF_INIT;
+	int ret;
+
 	if (show_only || verbose)
 		fprintf_ln(stderr, _("Removing %s/%s: %s"), "worktrees", id, reason);
-	if (!show_only)
-		delete_git_dir(id);
+	if (show_only)
+		return 0;
+
+	delete_git_dir(id);
+
+	/* path stays empty when the worktree path cannot be determined */
+	if (dotgit) {
+		strbuf_addstr(&path, dotgit);
+		strbuf_strip_suffix(&path, "/.git");
+	}
+	ret =3D run_post_worktree_hook("remove", id, path.buf, "");
+	strbuf_release(&path);
+	return ret;
 }
=20
 static int prune_cmp(const void *a, const void *b)
@@ -207,18 +222,22 @@ static int prune_cmp(const void *a, const void *b)
 	return strcmp(x->util, y->util);
 }
=20
-static void prune_dups(struct string_list *l)
+static int prune_dups(struct string_list *l)
 {
 	int i;
+	int ret =3D 0;
=20
 	QSORT(l->items, l->nr, prune_cmp);
 	for (i =3D 1; i < l->nr; i++) {
 		if (!fspathcmp(l->items[i].string, l->items[i - 1].string))
-			prune_worktree(l->items[i].util, "duplicate entry");
+			ret |=3D prune_worktree(l->items[i].util,
+					      l->items[i].string,
+					      "duplicate entry");
 	}
+	return ret;
 }
=20
-static void prune_worktrees(void)
+static int prune_worktrees(void)
 {
 	struct strbuf reason =3D STRBUF_INIT;
 	struct strbuf main_path =3D STRBUF_INIT;
@@ -226,19 +245,23 @@ static void prune_worktrees(void)
 	char *path;
 	DIR *dir;
 	struct dirent *d;
+	int ret =3D 0;
=20
 	path =3D repo_git_path(the_repository, "worktrees");
 	dir =3D opendir(path);
 	free(path);
 	if (!dir)
-		return;
+		return 0;
 	while ((d =3D readdir_skip_dot_and_dotdot(dir)) !=3D NULL) {
 		char *path;
 		strbuf_reset(&reason);
-		if (should_prune_worktree(the_repository, d->d_name, &reason, &path, exp=
ire))
-			prune_worktree(d->d_name, reason.buf);
-		else if (path)
+		if (should_prune_worktree(the_repository, d->d_name,
+					  &reason, &path, expire)) {
+			ret |=3D prune_worktree(d->d_name, path, reason.buf);
+			free(path);
+		} else if (path) {
 			string_list_append_nodup(&kept, path)->util =3D xstrdup(d->d_name);
+		}
 	}
 	closedir(dir);
=20
@@ -246,12 +269,13 @@ static void prune_worktrees(void)
 	/* massage main worktree absolute path to match 'gitdir' content */
 	strbuf_strip_suffix(&main_path, "/.");
 	string_list_append_nodup(&kept, strbuf_detach(&main_path, NULL));
-	prune_dups(&kept);
+	ret |=3D prune_dups(&kept);
 	string_list_clear(&kept, 1);
=20
 	if (!show_only)
 		delete_worktrees_dir_if_empty();
 	strbuf_release(&reason);
+	return ret;
 }
=20
 static int prune(int ac, const char **av, const char *prefix,
@@ -270,8 +294,7 @@ static int prune(int ac, const char **av, const char *p=
refix,
 			   0);
 	if (ac)
 		usage_with_options(git_worktree_prune_usage, options);
-	prune_worktrees();
-	return 0;
+	return prune_worktrees();
 }
=20
 static char *junk_work_tree;
diff --git a/t/t2401-worktree-prune.sh b/t/t2401-worktree-prune.sh
index f8f28c76ee..c863575b2f 100755
--- a/t/t2401-worktree-prune.sh
+++ b/t/t2401-worktree-prune.sh
@@ -119,6 +119,108 @@ test_expect_success 'prune duplicate (main/linked)' '
 	test_path_is_missing .git/worktrees/wt
 '
=20
+test_expect_success 'prune invokes post-worktree remove event' '
+	test_hook post-worktree <<-\EOF &&
+	test "$#" =3D 4 || exit 1
+	test "$1" =3D remove || exit 0
+	printf "[%s][%s][%s][%s]\n" "$@" >hook.actual
+	EOF
+	git worktree add --detach flushed &&
+	rm -rf flushed &&
+	git worktree prune &&
+	printf "[remove][flushed][%s][]\n" "$(pwd)/flushed" >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'prune invokes post-worktree once per worktree' '
+	test_hook post-worktree <<-\EOF &&
+	test "$#" =3D 4 || exit 1
+	test "$1" =3D remove || exit 0
+	printf "[%s][%s][%s][%s]\n" "$@" >>hook.actual
+	EOF
+	git worktree add --detach first &&
+	git worktree add --detach second &&
+	rm -rf first second hook.actual &&
+	git worktree prune &&
+	{
+		printf "[remove][first][%s][]\n" "$(pwd)/first" &&
+		printf "[remove][second][%s][]\n" "$(pwd)/second"
+	} >hook.expect &&
+	sort hook.actual >hook.sorted &&
+	test_cmp hook.expect hook.sorted
+'
+
+test_expect_success 'prune --dry-run does not invoke post-worktree hook' '
+	git worktree add --detach dry &&
+	rm -rf dry &&
+	test_when_finished "git worktree prune" &&
+	test_hook post-worktree <<-\EOF &&
+	>hook.ran
+	EOF
+	git worktree prune --dry-run &&
+	test_path_is_missing hook.ran
+'
+
+test_expect_success 'pruned entry with unknown path gives empty hook argum=
ent' '
+	test_hook post-worktree <<-\EOF &&
+	test "$#" =3D 4 &&
+	printf "[%s][%s][%s][%s]\n" "$@" >hook.actual
+	EOF
+	mkdir -p .git/worktrees/broken &&
+	: >.git/worktrees/broken/gitdir &&
+	git worktree prune &&
+	echo "[remove][broken][][]" >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'failing post-worktree hook does not skip other pruned=
 entries' '
+	test_hook post-worktree <<-\EOF &&
+	test "$1" =3D remove || exit 0
+	echo "$2" >>hook.actual
+	exit 1
+	EOF
+	git worktree add --detach doomed &&
+	git worktree add --detach doomed2 &&
+	rm -rf doomed doomed2 hook.actual &&
+	test_must_fail git worktree prune &&
+	test_path_is_missing .git/worktrees/doomed &&
+	test_path_is_missing .git/worktrees/doomed2 &&
+	test_write_lines doomed doomed2 >hook.expect &&
+	sort hook.actual >hook.sorted &&
+	test_cmp hook.expect hook.sorted
+'
+
+test_expect_success 'prune duplicate invokes post-worktree remove event' '
+	test_when_finished rm -fr .git/worktrees w1 w2 &&
+	test_hook post-worktree <<-\EOF &&
+	test "$1" =3D remove || exit 0
+	printf "[%s][%s][%s][%s]\n" "$@" >>hook.actual
+	EOF
+	rm -f hook.actual &&
+	git worktree add --detach w1 &&
+	git worktree add --detach w2 &&
+	sed "s/w2/w1/" .git/worktrees/w2/gitdir >.git/worktrees/w2/gitdir.new &&
+	mv .git/worktrees/w2/gitdir.new .git/worktrees/w2/gitdir &&
+	git worktree prune &&
+	printf "[remove][w2][%s][]\n" "$(pwd)/w1" >hook.expect &&
+	test_cmp hook.expect hook.actual
+'
+
+test_expect_success 'post-worktree remove gets absolute path with relative=
 worktrees' '
+	test_when_finished "rm -rf relhook" &&
+	git init relhook &&
+	test_commit -C relhook base &&
+	test_hook -C relhook post-worktree <<-\EOF &&
+	test "$1" =3D remove || exit 0
+	printf "[%s][%s][%s][%s]\n" "$@" >hook.actual
+	EOF
+	git -C relhook worktree add --relative-paths --detach wt &&
+	rm -rf relhook/wt &&
+	git -C relhook worktree prune &&
+	printf "[remove][wt][%s][]\n" "$(pwd)/relhook/wt" >hook.expect &&
+	test_cmp hook.expect relhook/hook.actual
+'
+
 test_expect_success 'not prune proper worktrees inside linked worktree wit=
h relative paths' '
 	test_when_finished rm -rf repo wt_ext &&
 	git init repo &&
diff --git a/worktree.c b/worktree.c
index 8cb8637b18..f6abad62a7 100644
--- a/worktree.c
+++ b/worktree.c
@@ -1016,7 +1016,6 @@ int should_prune_worktree(struct repository *repo,
 		if (stat(file.buf, &st) || st.st_mtime <=3D expire) {
 			strbuf_addstr(reason, _("gitdir file points to non-existent location"))=
;
 			rc =3D 1;
-			goto done;
 		}
 	}
 	*wtpath =3D strbuf_detach(&dotgit, NULL);
diff --git a/worktree.h b/worktree.h
index fbb2757f5b..30699b2998 100644
--- a/worktree.h
+++ b/worktree.h
@@ -106,9 +106,9 @@ const char *worktree_prune_reason(struct worktree *wt, =
timestamp_t expire);
=20
 /*
  * Return true if worktree entry should be pruned, along with the reason f=
or
- * pruning. Otherwise, return false and the worktree's path in `wtpath`, o=
r
- * NULL if it cannot be determined. Caller is responsible for freeing
- * returned path.
+ * pruning. Otherwise, return false. In both cases the path of the
+ * worktree's `.git` file is returned in `wtpath`, or NULL if it cannot
+ * be determined. Caller is responsible for freeing returned path.
  *
  * `expire` defines a grace period to prune the worktree when its path
  * does not exist.
--=20
2.54.0
