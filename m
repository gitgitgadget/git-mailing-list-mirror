Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.121
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795448799;
	b=aNmmj79R4NY3erIc0MEUW5cIA2/rYc3Q9T5r/uxBasWdYU8x7AbPZ8blg2aI+Iq3nDop
	 m7fC94WhJclgjUC1A/LA01C0F5vHK+NYcf3R9KW5n4xvkFypXZ7ebGw9YyccMEJc2lWkV
	 reSUbTZDGJRHFe5EbQI/ADuoxhb+V7UExiE8+BjagtR7F6wbuDZXjRHvLdRC+zfyDVs0B
	 J5G7WsxjQe2AXwFMvWy2wr2Gr9a9743rv/UlpFsYRl9D53bGjS+pcRq9VICF4tpqcsZx+
	 9HCHoXJGtFLq8j3HR2hJ+Ic/13JNnYQtZlw3Oyzt47VB6teSFdnsBCFRflhz9/iDeEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448799;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7D6FLz4QIbuoEuz9+QW6mfK8Hgypqqsu7X8ahzqh/FE=;
	b=i4R6+Mayin/zr+dhnJjmS3lfHHl/vJJeYCI4/8WgN74m669nrXYvcMy3KWtbvsv1GY5n
	 1EwDawHAdNAYHfSSOgJoH+MfBspJ8EP9oRNVJ9DjsFG1F4FLYM1pxQ69LQ6wNWogENqwb
	 mvl5FBjX3CX7Odj9UZ5rEyzcAcLgyXNLrVOrRkDMaAlJgn5j14+mGY0/sof/WgyINX/IF
	 HWALiVhkWTzA5cbpDxVCFdOcMdbIWvq6XvMg7Gd1O3qJ9CvdZ6MGbkiK0gTN9lcf+siEb
	 IqoADikpaX09FPzwIlgaX0MRvu7JXSj82ajDMJIs+1lYvdbPPL4SK9WaISOdqBGS3Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=jND1UGrR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.182.121
Received: from sender5-pp-g121.zoho.com (sender5-pp-g121.zoho.com [165.173.182.121])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78D606A31E
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 15:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D78D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=jND1UGrR
ARC-Seal: i=1; a=rsa-sha256; t=1795448765; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WZBl+Y7eR181Sl/AypYqVQ0ZytoEFcb1SqUovAEzeSkmbZQIrfJuJgeu3r0TmjYr44F7slU70gZ2PYUPWQSSfliZ9Y8NvVo+AnbIHj2doAYMDJl1tBG6DFr1zn7tCOs5Kv5xxwA3OF/H6yAu7OMS6VQpT2D1GgFRx57iPfWwMHg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1795448765; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7D6FLz4QIbuoEuz9+QW6mfK8Hgypqqsu7X8ahzqh/FE=; 
	b=AN4UAy7gZxhqnk1nU47RVQVzHABF8kxuoTvvwChQN7JwmUHJVQPqqN1j+Ov6cBTNucqHUKlBi6GmYPQDWW+GOaSvKj33krRrNCHP9ZAiHL4jhgkmfO1skQmerxTMFwnOO4XyrzTqqLuHbykLjUTQX7OGVGC+J6NDDYIPP5YMIpM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: a=rsa-sha256; b=jND1UGrRT5sgEnqQu6a1TWkqCtlIarIs2vAtiDnfLRnPGYkjaaGLsHD7wBLqvE9ajEY21cCJa30dasV6MSSSSxNNpSSyyJpxUjte4+XTows1TOAVeQqV3AuUAMwTOLDbnQxin10fDJJmNoaehnrmHf0ei1AgpmeBkFkALbG0bgk=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=7D6FLz4QIbuoEuz9+QW6mfK8Hgypqqsu7X8ahzqh/FE=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795448765001710.0182944479236;
	Mon, 23 Nov 2026 07:46:05 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>,
	Junio C Hamano <gitster@pobox.com>,
	Andreas Wendleder <gonsolo@gmail.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 5/5] submodule: accept a linked worktree as the submodule's git dir
Date: Mon, 23 Nov 2026 17:45:00 +0200
Message-ID: <20261123154500.251056-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123154500.251056-1-adrian.ratiu@collabora.com>
References: <20261118163249.1693361-1-adrian.ratiu@collabora.com>
 <20261123154500.251056-1-adrian.ratiu@collabora.com>
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

A submodule can be checked out as a linked worktree of its repository,
created e.g. with:

  git -C super/sub worktree add ../../wt/sub

Its .git file then points to "super/.git/modules/sub/worktrees/<id>"
instead of "super/.git/modules/sub".

t2405 already creates such a submodule, but it doesn't test a recursive
checkout and its worktree id happens to match the submodule name.

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
 submodule.c                   | 52 ++++++++++++++++++++++++++++++-----
 t/t2405-worktree-submodule.sh | 43 +++++++++++++++++++++++++++++
 t/t7450-bad-git-dotfiles.sh   | 16 +++++++++++
 3 files changed, 104 insertions(+), 7 deletions(-)

diff --git a/submodule.c b/submodule.c
index 9eae297c8a..8ed79da14f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -2119,11 +2119,34 @@ static void submodule_reset_index(const char *path, const char *super_prefix)
 		die(_("could not reset submodule index"));
 }
 
-static void setup_submodule_git_dir(const struct submodule *sub,
-				    const char *path, const char *super_prefix,
-				    const char *old_head, unsigned flags)
+/*
+ * A linked worktree's git dir is "<common-dir>/worktrees/<id>", which is
+ * where "git worktree add" puts it. Die if it is anywhere else.
+ */
+static void validate_submodule_worktree_dir(const char *git_dir,
+					    const char *common_dir)
+{
+	struct strbuf worktree_dir = STRBUF_INIT;
+	const char *id;
+
+	strbuf_realpath(&worktree_dir, git_dir, 1);
+	if (!skip_prefix(worktree_dir.buf, common_dir, &id) ||
+	    !skip_prefix(id, "/worktrees/", &id) ||
+	    !*id || strchr(id, '/'))
+		die(_("submodule git dir '%s' is not a worktree of '%s'"),
+		    git_dir, common_dir);
+	strbuf_release(&worktree_dir);
+}
+
+/* Returns 1 if the submodule at "path" is a linked worktree, 0 otherwise. */
+static int setup_submodule_git_dir(const struct submodule *sub,
+				   const char *path, const char *super_prefix,
+				   const char *old_head, unsigned flags)
 {
+	int is_worktree = 0;
+
 	if (old_head) {
+		struct strbuf common_dir = STRBUF_INIT;
 		char *dotgit, *git_dir;
 
 		if (!submodule_uses_gitfile(path))
@@ -2133,8 +2156,14 @@ static void setup_submodule_git_dir(const struct submodule *sub,
 		dotgit = xstrfmt("%s/.git", path);
 		git_dir = xstrdup(read_gitfile(dotgit));
 		free(dotgit);
-		if (validate_submodule_git_dir(git_dir, sub->name) < 0)
+
+		/* A linked worktree is validated through its common dir. */
+		is_worktree = get_common_dir_noenv(&common_dir, git_dir);
+		if (is_worktree)
+			validate_submodule_worktree_dir(git_dir, common_dir.buf);
+		if (validate_submodule_git_dir(common_dir.buf, sub->name) < 0)
 			die_refusing_submodule_git_dir(the_repository, git_dir);
+		strbuf_release(&common_dir);
 		free(git_dir);
 	} else {
 		struct strbuf gitdir = STRBUF_INIT;
@@ -2146,12 +2175,18 @@ static void setup_submodule_git_dir(const struct submodule *sub,
 		submodule_reset_index(path, super_prefix);
 	}
 
-	if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE)) {
+	/*
+	 * Do not reconnect a linked worktree to the submodule's main git
+	 * dir: that would take over the git dir of another working tree.
+	 */
+	if (old_head && (flags & SUBMODULE_MOVE_HEAD_FORCE) && !is_worktree) {
 		struct strbuf gitdir = STRBUF_INIT;
 		submodule_name_to_gitdir(&gitdir, the_repository, sub->name);
 		connect_work_tree_and_git_dir(path, gitdir.buf, 1);
 		strbuf_release(&gitdir);
 	}
+
+	return is_worktree;
 }
 
 /**
@@ -2167,6 +2202,7 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	struct child_process cp = CHILD_PROCESS_INIT;
 	const struct submodule *sub;
 	int *error_code_ptr, error_code;
+	int is_worktree = 0;
 
 	if (!is_submodule_active(the_repository, path))
 		return 0;
@@ -2196,7 +2232,8 @@ int submodule_move_head(const char *path, const char *super_prefix,
 	}
 
 	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN))
-		setup_submodule_git_dir(sub, path, super_prefix, old_head, flags);
+		is_worktree = setup_submodule_git_dir(sub, path, super_prefix,
+						      old_head, flags);
 
 	prepare_submodule_repo_env(&cp.env);
 
@@ -2254,7 +2291,8 @@ int submodule_move_head(const char *path, const char *super_prefix,
 			if (is_empty_dir(path))
 				rmdir_or_warn(path);
 
-			submodule_unset_core_worktree(sub);
+			if (!is_worktree)
+				submodule_unset_core_worktree(sub);
 		}
 	}
 out:
diff --git a/t/t2405-worktree-submodule.sh b/t/t2405-worktree-submodule.sh
index f5c94d490b..f23c8c8abf 100755
--- a/t/t2405-worktree-submodule.sh
+++ b/t/t2405-worktree-submodule.sh
@@ -59,6 +59,49 @@ test_expect_success 'submodule is checked out after manually adding submodule wo
 	test_grep "file1 updated" out
 '
 
+# Helper to verify "sub" is still the same worktree, checked out at HEAD:sub.
+test_submodule_worktree_is_kept () {
+	test_cmp expect-gitfile submodule-worktree/sub/.git &&
+	git -C submodule-worktree rev-parse HEAD:sub >expect-head &&
+	git -C submodule-worktree/sub rev-parse HEAD >actual-head &&
+	test_cmp expect-head actual-head
+}
+
+test_expect_success 'checkout --recurse-submodules accepts a submodule worktree' '
+	git -C main worktree add "$base_path/submodule-worktree" "$rev1_hash_main" &&
+	git -C main/sub worktree add "$base_path/submodule-worktree/sub" "$rev1_hash_sub" &&
+	cat submodule-worktree/sub/.git >expect-gitfile &&
+	# the worktree id must not end in the submodule name
+	test_grep "/worktrees/sub1$" expect-gitfile &&
+	git -C submodule-worktree checkout --recurse-submodules "$(git -C main rev-parse HEAD)" &&
+	test_submodule_worktree_is_kept
+'
+
+test_expect_success 'checkout --recurse-submodules accepts a submodule worktree with submodulePathConfig' '
+	test_config -C main core.repositoryformatversion 1 &&
+	test_config -C main extensions.submodulePathConfig true &&
+	test_config -C main submodule.sub.gitdir .git/modules/sub &&
+	git -C submodule-worktree checkout --recurse-submodules "$rev1_hash_main" &&
+	test_submodule_worktree_is_kept
+'
+
+test_expect_success 'checkout --recurse-submodules accepts a submodule worktree with a nested git dir' '
+	# a nested .git directory makes the checkout absorb it first
+	git clone origin/sub submodule-worktree/sub/inner &&
+	git -C submodule-worktree/sub submodule add ./inner inner &&
+	git -C submodule-worktree checkout -f --recurse-submodules "$(git -C main rev-parse HEAD)" &&
+	test_submodule_worktree_is_kept
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
index 72ef1af661..717631a2ee 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -413,6 +413,22 @@ test_expect_success 'checkout --recurse-submodules rejects gitfile not matching
 	test_cmp expect mismatched_absorbed/thing1/.git
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

