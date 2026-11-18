Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.109
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795019625;
	b=KM5ARkpBZTpzYtwyOMU3vAXNLo0vQxgxoo++9qwRAtpCzczu46HicORMOq49+WuuwoTf
	 mI9wT6F4rgtYQan/fR7PsgJpAY/vYdrxI/1YDVvw1zlLKMUiqOa4qO/U9gVLeYs1RZA1O
	 IbhE7c90CQ9uvE/23XkorETqliNOZ6jR7VgjC+hK384DBW1JrfvFuQXgBWPjEOLXeXSJT
	 SJaHA/n1kbSUpsJjxBDvzyyVCv6HqCrOzHhJHYotgvi2S7MVBVGPQjleooUjFQPcbku8D
	 FFSV2+xQgwZmtYLYLCaOYvpSrCeIhOKy4Qt1ZRaSMRtrp6AdPpjab3fv1+uDdiJAX8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795019625;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gpXxvfhpHYu0oBocVKXkXWm6uD+QpWQ7VuB51Cv06VA=;
	b=k5pP3CouBSlLcUEsJyHEsHo0Ja5rIW5TS1lNuuEbvjq5jEANpZqWaj2lkwKNSvdDd0ig
	 N33CocslsLYbzdAxW16/08Y6bLxosbA+3/1529JxzgG8l2Z/dPVQ8ZJqsKFFU3AHveiKS
	 TfHas8uh6+TRAT3Qe9Y7ye5G5LhX2Em/+bA3uGIBewL5jDT8KVVT3R9kucFyXJRNj9jbI
	 5iCuCfzh6TlC4nU0kDz4SQHwZZzcmaqlsTeCu59MLeHddUrArfVimoNa2hy8YjH1PNmJ/
	 bK0ApHGyRmBO6cJX93rFkk7OX/CInHKdlJNHqA+qDClb9D1zzfbpsNgAIYIo0zEk0kQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=fisXBtDw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.109
Received: from sender5-pp-e109.zoho.com (sender5-pp-e109.zoho.com [165.173.182.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE4D606A7C6
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DE4D606A7C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=fisXBtDw
ARC-Seal: i=1; a=rsa-sha256; t=1795019610; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KSAQOGqNDJbEBik5dSEE2bGAxnzgnhCqPmgRqvcFoX3OIl053Bnv8yaWhnCM/1KCNjxaolYIwNnHnVKujjvpYhOpF06Z3OfJaijdAwMhmHWnKIEnkm75Gsx8yzYZn2DFdtoOTTyLPbHZHXD/JKw6RLGAhGTp3JELgxWj0fgHCvQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795019610; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gpXxvfhpHYu0oBocVKXkXWm6uD+QpWQ7VuB51Cv06VA=; 
	b=kCMG3toYGVoG5G7AUkGKPqdom0VZOnPDaWmt4Agiw9w6rPghSowuI2Texey51cjhD4YtVPWNEnOwxIoVdFhq0udWMPBdB7yVt0jbb38QQUGLNb4ubVOcjdlv0I52BcH+bq4160mjJV1fEj6KgbftQ0a4KtYK2bbh6sWLgthDgJo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=fisXBtDwqTt4JRIPfmik3aU7yTVfZBmxOnF4suL9YqLn7Iing5kDHdnnEdmxjEDaf9HokhDOSfwCl+m32WXBY7SpTJytpRvuzwttwxFu9SuHTL9gLuTxjuG9K3jKi2X/DYyhUIYzJvIibzH60TbD83qNIwAex/dxB1mwZCNGO/E=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=gpXxvfhpHYu0oBocVKXkXWm6uD+QpWQ7VuB51Cv06VA=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795019608266475.8310774953037;
	Wed, 18 Nov 2026 08:33:28 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 3/3] submodule: accept a linked worktree as the submodule's git dir
Date: Wed, 18 Nov 2026 18:32:49 +0200
Message-ID: <20261118163249.1693361-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
References: <avuJBGlB3pRU3JU0@pampelmuse>
 <20261118163249.1693361-1-adrian.ratiu@collabora.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A submodule's working tree can be a linked worktree of the submodule's
repository, created e.g. with:

  git -C super/sub worktree add ../../wt/sub

Its .git file then points to "super/.git/modules/sub/worktrees/<id>"
instead of "super/.git/modules/sub". t2405 already creates such a
submodule, but it doesn't test a recursive checkout, and its worktree
id happens to match the submodule name.

A recursive checkout (--recurse-submodules or submodule.recurse=true)
has two problems with this setup:

 1. It checks that the git dir ends in the submodule's name. A
    worktree's git dir ends in the worktree id instead, so the check
    fails and the command dies. It only passes by chance, when the id
    is the same as the name.

 2. Even when the check passes, Git then rewrites the .git file to
    point to the git dir it would normally use for the submodule,
    "$GIT_DIR/modules/<name>" of the superproject. That is not the
    repository the worktree belongs to and it usually does not exist,
    so the submodule is left broken. Likewise, when the submodule is
    removed, Git tries to unset core.worktree in that git dir and
    prints an error and a warning.

    This happens on every recursive checkout, not only with --force,
    because unpack_trees() always passes SUBMODULE_MOVE_HEAD_FORCE to
    submodule_move_head().

Fix both: when the git dir is a linked worktree of a valid submodule
git dir, i.e. it is located at "<common-dir>/worktrees/<id>", check
the common dir against the submodule's name and leave the .git file
and core.worktree alone. Reject a git dir that has a commondir file but
is located anywhere else.

Reported-by: Andreas Wendleder <gonsolo@gmail.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 submodule.c                   | 56 ++++++++++++++++++++++++++++++++---
 t/t2405-worktree-submodule.sh | 40 +++++++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh   | 16 ++++++++++
 3 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/submodule.c b/submodule.c
index 64cd8005f7..1bd7fb7e04 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2119,6 +2119,45 @@ static void submodule_reset_index(const char *path, const char *super_prefix)
 		die(_("could not reset submodule index"));
 }
 
+/*
+ * A submodule gitfile may point to a linked worktree of the submodule
+ * repository, i.e. "<common-dir>/worktrees/<id>", whose path does not end
+ * in the submodule name. Validate the common dir in that case, after making
+ * sure that the git dir is where "git worktree add" would have put it, and
+ * die if it is not.
+ *
+ * Returns:
+ *   1 if git_dir is a valid linked worktree.
+ *   0 if it is a valid submodule git dir.
+ *   a negative value otherwise.
+ */
+static int validate_submodule_gitfile_dir(const char *git_dir,
+					  const char *submodule_name)
+{
+	struct strbuf common_dir = STRBUF_INIT;
+	struct strbuf worktree_dir = STRBUF_INIT;
+	int is_worktree, ret;
+
+	is_worktree = get_common_dir_noenv(&common_dir, git_dir);
+	if (is_worktree) {
+		const char *id;
+
+		strbuf_realpath(&worktree_dir, git_dir, 1);
+		if (!skip_prefix(worktree_dir.buf, common_dir.buf, &id) ||
+		    !skip_prefix(id, "/worktrees/", &id) ||
+		    !*id || strchr(id, '/'))
+			die(_("submodule git dir '%s' is not a worktree of '%s'"),
+			    git_dir, common_dir.buf);
+	}
+
+	ret = validate_submodule_git_dir(common_dir.buf, submodule_name);
+	if (!ret)
+		ret = is_worktree;
+	strbuf_release(&common_dir);
+	strbuf_release(&worktree_dir);
+	return ret;
+}
+
 /**
  * Moves a submodule at a given path from a given head to another new head.
  * For edge cases (a submodule coming into existence or removing a submodule)
@@ -2132,6 +2171,7 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const struct submodule *sub;
 	int *error_code_ptr, error_code;
+	int is_worktree = 0;
 
 	if (!is_submodule_active(the_repository, path))
 		return 0;
@@ -2170,8 +2210,9 @@ int submodule_move_head(const char *path, const char *super_prefix,
 				char *git_dir = xstrdup(read_gitfile(dotgit));
 
 				free(dotgit);
-				if (validate_submodule_git_dir(git_dir,
-							       sub->name) < 0) {
+				is_worktree = validate_submodule_gitfile_dir(git_dir,
+									     sub->name);
+				if (is_worktree < 0) {
 					if (!the_repository->repository_format_submodule_path_cfg)
 						advise(_("enabling extensions.submodulePathConfig "
 							 "might fix the following error."));
@@ -2191,7 +2232,13 @@ int submodule_move_head(const char *path, const char *super_prefix,
 			submodule_reset_index(path, super_prefix);
 		}
 
-		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+		/*
+		 * Do not reconnect a linked worktree to the submodule's
+		 * main git dir: that would take over the git dir of another
+		 * working tree.
+		 */
+		if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE) &&
+		    !is_worktree) {
 			struct strbuf gitdir = STRBUF_INIT;
 			submodule_name_to_gitdir(&gitdir, the_repository,
 						 sub->name);
@@ -2256,7 +2303,8 @@ int submodule_move_head(const char *path, const char *super_prefix,
 			if (is_empty_dir(path))
 				rmdir_or_warn(path);
 
-			submodule_unset_core_worktree(sub);
+			if (!is_worktree)
+				submodule_unset_core_worktree(sub);
 		}
 	}
 out:
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index f5c94d490b..fc5cb849de 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -59,6 +59,46 @@ test_expect_success 'submodule is checked out after manually adding submodule wo
 	test_grep "file1 updated" out
 '
 
+test_expect_success 'checkout --recurse-submodules accepts a submodule worktree' '
+	git -C main worktree add "$base_path/submodule-worktree" "$rev1_hash_main" &&
+	git -C main/sub worktree add "$base_path/submodule-worktree/sub" "$rev1_hash_sub" &&
+	cat submodule-worktree/sub/.git >expect-gitfile &&
+	# the worktree id must not end in the submodule name
+	test_grep "/worktrees/sub1$" expect-gitfile &&
+	git -C main/sub rev-parse HEAD >expect-head-main &&
+	git -C submodule-worktree checkout --recurse-submodules "$(git -C main rev-parse HEAD)" &&
+	git -C submodule-worktree rev-parse HEAD:sub >expect-head &&
+	git -C submodule-worktree/sub rev-parse HEAD >actual-head &&
+	test_cmp expect-head actual-head &&
+	cat submodule-worktree/sub/.git >actual-gitfile &&
+	test_cmp expect-gitfile actual-gitfile &&
+	git -C main/sub rev-parse HEAD >actual-head-main &&
+	test_cmp expect-head-main actual-head-main
+'
+
+test_expect_success 'checkout --recurse-submodules accepts a submodule worktree with submodulePathConfig' '
+	test_config -C main core.repositoryformatversion 1 &&
+	test_config -C main extensions.submodulePathConfig true &&
+	test_config -C main submodule.sub.gitdir .git/modules/sub &&
+	git -C submodule-worktree checkout --recurse-submodules "$rev1_hash_main" &&
+	git -C submodule-worktree/sub rev-parse --short HEAD >actual-head &&
+	echo "$rev1_hash_sub" >expect-head &&
+	test_cmp expect-head actual-head &&
+	cat submodule-worktree/sub/.git >actual-gitfile &&
+	test_cmp expect-gitfile actual-gitfile &&
+	git -C main/sub rev-parse HEAD >actual-head-main &&
+	test_cmp expect-head-main actual-head-main
+'
+
+test_expect_success 'checkout --recurse-submodules removes a submodule worktree' '
+	git -C main/sub config get core.worktree >expect-main &&
+	git -C submodule-worktree checkout --recurse-submodules first 2>err &&
+	test_grep ! "core.worktree" err &&
+	test_path_is_missing submodule-worktree/sub/.git &&
+	git -C main/sub config get core.worktree >actual-main &&
+	test_cmp expect-main actual-main
+'
+
 test_expect_success 'checkout --recurse-submodules uses $GIT_DIR for submodules in a linked worktree' '
 	git -C main worktree add "$base_path/checkout-recurse" --detach  &&
 	git -C checkout-recurse submodule update --init &&
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index a710c05a5d..26d442c0ad 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -395,6 +395,22 @@ test_expect_success 'checkout --recurse-submodules rejects gitfile not matching
 	test_grep ! "BUG" err
 '
 
+test_expect_success 'checkout --recurse-submodules rejects gitfile pointing to a forged worktree' '
+	git clone nested forged_worktree &&
+	(
+		cd forged_worktree &&
+		git submodule init thing1 &&
+		git submodule update thing1 &&
+		mkdir .git/modules/forged &&
+		cp .git/modules/hippo/HEAD .git/modules/forged/HEAD &&
+		echo "../hippo" >.git/modules/forged/commondir &&
+		echo "gitdir: ../.git/modules/forged" >thing1/.git
+	) &&
+	test_must_fail git -C forged_worktree checkout -f --recurse-submodules HEAD 2>err &&
+	test_grep "is not a worktree of" err &&
+	test_grep ! "extensions.submodulePathConfig" err
+'
+
 test_expect_success SYMLINKS,!WINDOWS,!MINGW 'submodule must not checkout into different directory' '
 	test_when_finished "rm -rf sub repo bad-clone" &&
 
-- 
2.56.1

