Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDEE3BD640
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774869520; cv=none; b=cUQrUGyBRHqrXnpBmHXyE7k2jG107Lbau+OHtfu9c9ISGbkd5IDM4O4rmSCx2TyX1bJY4aert7JVqWE+LcyLU1Xy14rgDoXibI12XNv7yJZx2apak7qkupLFtmEtEACSL372+s6vlZ6kYQrxCFJdquZWbYvmBZ7Trf9tu0EaS30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774869520; c=relaxed/simple;
	bh=w5aRvgObB+ULQgVfudsb2QOolLUSfVP9Izy4W/nDZ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW5NOoMRRpu0tF26AXptoHNSNzfuYTb7CheNkoygce56lMlAtjiGUfzgbk9lfaqnGypbMeflL0ueJEKCm5Lb0apv1wrnJ5jwzZu8K0cByfcLEfJuPmxKREJEcZXTvjaPlMRxAbQwPq1qhYgTaFrzfHpo3mphfX4Hh9c+mSK6UYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YjD3Euja; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjD3Euja"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43cf5d14d6eso1301374f8f.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 04:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774869517; x=1775474317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IqpG5l67hkvCW7tJbNzJ+wzNhas6HyNE4EU274MyN9M=;
        b=YjD3EujaHdUnWwJ666lUm7KGvN/ebszA4xd19FlaDEkK6aegDXQlqWscrUZRf/Qhww
         QTdG3HC1ELRsyPir2yb3uxBywDvOz676eTg8Vff7bzHq6kgJAaDtaluLX1Ao6pZiaj6v
         k0WrJkLnXybFERkC0gbTl7W79cJYpymQeKFvjP6ysvdLJsw7bltADhvj4hoV8+9j2e/j
         kRahvt+fvGcj73PXaZSfj8uzFkfhvvZS03pD9yzyeWKR4b0gtjqXep66qxm+GMq0jUVB
         R1PcEmg2q2HHnMtbsV322EXcyQpkvBRJ8eVZBeCMVLIq9O8OuAMDE7OE0rFfVZJL7USi
         xgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774869517; x=1775474317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IqpG5l67hkvCW7tJbNzJ+wzNhas6HyNE4EU274MyN9M=;
        b=EbYEUIytgmYpWUP5HsKodMl4QczhydAOBYP9IkOniZ6+ud0Q0vLx938d8Y+sj9vLZj
         iN9U27ruRGgtVy6LH6p/bC2iYDQ9oofVq3sOi5Aa4khKSxYNruDCXMyyacvzccncLS9B
         cIoURWelzxK8fiRWTThoa1ydPGsqPEUqP/xuMaR1g/nH9kSj1tkgEAQ4L9cCWr2d60Do
         +Te/Ce/7+xW+N9UvIEtL9zTfKm3WVkjQTQ+JZyPev5Mf7xGzJD8RULQRKHSPsI/jWxTG
         fuQlfMgTu0BG/B8qSkMiGDOJCBYJZOyL9uDiStNumEZ/iGp68mzDJJmG5KK1pw+1eOOF
         9Saw==
X-Gm-Message-State: AOJu0YxhkYSMuBazXoIzPNMAqKH9BQyOSnfsB4CkJwyJHuC+M7PlPvP5
	s20cFx/pq/ownmB3IIBh7/tibqHJOHLxlukc0s7iS6PpUPWxyIJ8o/E0BhBEKHINUVo=
X-Gm-Gg: ATEYQzxnrfXLdsvZxdH9AJ2INCNsvIV7oscf7xg2zbcl2b9S1kRRttntUTUaitmuv1L
	nUJND7gmAMTuR1V71t5SbYEyPq9VUlCvahgSY6oQsz8ifQpdoTo0X3n0KxsQD/ys+LTBTgNTZXl
	p1PJfjA8X+TRUWxTEQ4eEyQ3pRFzYBksDkUh/Q6SsUq220Zj1WIP7XI7IWxyAZtbipyl+1U3rGl
	gZQsds102KlqDXPdco/s+0xtKmR+2iQ6PRlQzBaCiFAFLtNs7+09DkUKC4rf6bj7r1P1vSJTx2Q
	UkI3vOABIMC+hncVlnyodixsfuUIDU5LNIaRsFFP+y+3ijnrpMznzkqEgXSjmTge3zNhmkjcesy
	25F/mSC/gYrYeunSxgrav4TujU1PcXj1uVtX51pqcAvMxNi8SXqmj4uACCFBI4sYx+wzWXDhnhF
	5hmge2C/GYD1Jt90tru1wKokj4JNVR4M807bDKz5fF54BguzbT7piyjxK5x0OVyOVzAcr06sjTX
	hAmWjQNjdew3KYHiaq1Zf/HudUEyfEPXxQap4GDDBrZoXQKFtX29ca/eM4=
X-Received: by 2002:a5d:5402:0:b0:43c:ef4f:79cd with SMTP id ffacd0b85a97d-43cef4f7b47mr10725965f8f.48.1774869517205;
        Mon, 30 Mar 2026 04:18:37 -0700 (PDT)
Received: from farblopa.localdomain ([84.126.0.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eba4dsm19140821f8f.11.2026.03.30.04.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:18:36 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: me@runxiyu.org,
	gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	chandrapratap3519@gmail.com,
	Pablo Sabater <pabloosabaterr@gmail.com>
Subject: [GSoC PATCH 3/3] receive-pack: use worktree HEAD for updateInstead
Date: Mon, 30 Mar 2026 13:18:22 +0200
Message-ID: <20260330111822.165188-4-pabloosabaterr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330111822.165188-1-pabloosabaterr@gmail.com>
References: <20260223141236.22476-1-me@runxiyu.org>
 <20260330111822.165188-1-pabloosabaterr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a bare repo has linked worktrees, and its HEAD points to an unborn branch,
pushing to a wt branch with updateInstead fails and rejects the push, even if
the wt is clean. This happens because HEAD is checked only for the bare repo
context, instead of the wt.

Remove head_has_history and check for worktree->head_oid which does
have the correct HEAD of the wt.

Update the test added by Runxi's patch to expect success.

Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 builtin/receive-pack.c | 39 +++++++++++++++------------------------
 t/t5516-fetch-push.sh  |  6 +-----
 2 files changed, 16 insertions(+), 29 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d6225df890..2a0fb13250 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1380,32 +1380,16 @@ static int update_shallow_ref(struct command *cmd, struct shallow_info *si)
 	return 0;
 }
 
-/*
- * NEEDSWORK: we should consolidate various implementations of "are we
- * on an unborn branch?" test into one, and make the unified one more
- * robust. !get_sha1() based check used here and elsewhere would not
- * allow us to tell an unborn branch from corrupt ref, for example.
- * For the purpose of fixing "deploy-to-update does not work when
- * pushing into an empty repository" issue, this should suffice for
- * now.
- */
-static int head_has_history(void)
-{
-	struct object_id oid;
-
-	return !repo_get_oid(the_repository, "HEAD", &oid);
-}
-
 static const char *push_to_deploy(unsigned char *sha1,
 				  struct strvec *env,
-				  const char *work_tree)
+				  const struct worktree *worktree)
 {
 	struct child_process child = CHILD_PROCESS_INIT;
 
 	strvec_pushl(&child.args, "update-index", "-q", "--ignore-submodules",
 		     "--refresh", NULL);
 	strvec_pushv(&child.env, env->v);
-	child.dir = work_tree;
+	child.dir = worktree->path;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
 	child.git_cmd = 1;
@@ -1417,7 +1401,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	strvec_pushl(&child.args, "diff-files", "--quiet",
 		     "--ignore-submodules", "--", NULL);
 	strvec_pushv(&child.env, env->v);
-	child.dir = work_tree;
+	child.dir = worktree->path;
 	child.no_stdin = 1;
 	child.stdout_to_stderr = 1;
 	child.git_cmd = 1;
@@ -1427,9 +1411,16 @@ static const char *push_to_deploy(unsigned char *sha1,
 	child_process_init(&child);
 	strvec_pushl(&child.args, "diff-index", "--quiet", "--cached",
 		     "--ignore-submodules",
-		     /* diff-index with either HEAD or an empty tree */
-		     head_has_history() ? "HEAD" : empty_tree_oid_hex(the_repository->hash_algo),
-		     "--", NULL);
+		     /*
+		      * diff-index with either HEAD or an empty tree
+		      *
+		      * NEEDSWORK: is_null_oid() cannot know whether it's an
+		      * unborn HEAD or a corrupt ref. It works for now because
+		      * it's only needed to know if we are comparing HEAD or an
+		      * empty tree.
+		      */
+		     !is_null_oid(&worktree->head_oid) ? "HEAD" :
+		     empty_tree_oid_hex(the_repository->hash_algo), "--", NULL);
 	strvec_pushv(&child.env, env->v);
 	child.no_stdin = 1;
 	child.no_stdout = 1;
@@ -1442,7 +1433,7 @@ static const char *push_to_deploy(unsigned char *sha1,
 	strvec_pushl(&child.args, "read-tree", "-u", "-m", hash_to_hex(sha1),
 		     NULL);
 	strvec_pushv(&child.env, env->v);
-	child.dir = work_tree;
+	child.dir = worktree->path;
 	child.no_stdin = 1;
 	child.no_stdout = 1;
 	child.stdout_to_stderr = 0;
@@ -1490,7 +1481,7 @@ static const char *update_worktree(unsigned char *sha1, const struct worktree *w
 
 	retval = push_to_checkout(sha1, &invoked_hook, &env, worktree->path);
 	if (!invoked_hook)
-		retval = push_to_deploy(sha1, &env, worktree->path);
+		retval = push_to_deploy(sha1, &env, worktree);
 
 	strvec_clear(&env);
 	free(git_dir);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index c40f2790d8..117cfa051f 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -1817,11 +1817,7 @@ test_expect_success 'denyCurrentBranch and bare repository worktrees' '
 	test_must_fail git push --delete bare.git wt
 '
 
-# NEEDSWORK: updateInstead unexpectedly fails when bare HEAD points to unborn
-# branch (or probably any ref that differs from the target worktree) despite
-# the target worktree being clean. This seems to be because receive-pack.c
-# diffs the target worktree index against the bare repository HEAD.
-test_expect_failure 'updateInstead with bare repository worktree and unborn bare HEAD' '
+test_expect_success 'updateInstead with bare repository worktree and unborn bare HEAD' '
 	test_when_finished "rm -fr bare.git cloned" &&
 	git clone --bare . bare.git &&
 	git -C bare.git worktree add wt &&
-- 
2.43.0

