Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5162FE59C
	for <git@vger.kernel.org>; Tue,  1 Sep 2026 22:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301492; cv=none; b=Esog0okjBuVMR+NxJT0RcarjTb6Uk2EBVzZBGvvZAzxRF2yAfXmtdMcmg8zTx9QeWPDF8HMDvTKcH8A6dpi78aCVym0/2vQ044nhw5ytDoFAZvKQwb4itVruQu/MBlhA8SDofLgxsVJ+rmVUm7oWwLZfb9ArKQpFLKPGJ4QeCQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301492; c=relaxed/simple;
	bh=vSLcJf/1bQJCvgG1292pgdH1VcB0KpPI1Y00aKjaHxM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bXHRwDSdw73xKFHVl19R8eQVy3O3LNGiIRimBCCnuhTftKQVzYH72n50D9CQp2QsBGj4kWqTrpgCjxDRCs4tKOFT9cpNpvB2RMlnWRMOiU/Dfe4krXIFeNhFSEBYfQnPrMwE1C6Eqn+rNTgHQakUeb7mzRiav9+Sa1FY+RwTD4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdiokLWn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdiokLWn"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39682983a0fso478951a91.3
        for <git@vger.kernel.org>; Tue, 01 Sep 2026 15:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788301490; x=1788906290; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zbHRMyB4uIGQxz3wRIwT+jsG1/MCH00G/l4hgRRI0KE=;
        b=AdiokLWnZtneD/xlRd1wAafFQGwRWG2E+YUdTrlrhvnDTYn9wefCEcR5gqdrG7myC2
         RMIlqHcuaiDteExqfbfRLuZJ7BPN4yFeKDTo5KLHG6rppIngDpgmHfPXFcDqxzVjngMD
         xMGF2g400gxog5brTmINuTok9eILCDx8xTT7tftBX9t5NbFgs6nsInrR0jFbVG8qdHjR
         f8GS29seJXWWslqLSl8gwuRULwHkwq8FGxfBvGgpC1mzK9isQw9097tNPdj+2rvFRX1N
         6sPm3d/B0yz3NBL/u3LZLAlInLM0pK4PiSC8ODuUOf3qxQIy4ecOg/OLPULSech3PDsI
         ebLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788301490; x=1788906290;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zbHRMyB4uIGQxz3wRIwT+jsG1/MCH00G/l4hgRRI0KE=;
        b=sP1iz/B7p1TELzjyFHKIF2KATZ72Tztqv3qEPuS9k9PboNVX80RcbPiUbbUUIscUt+
         lCHTQKoKYOZEME/1feEnZB9f3MjY88B6PqXZRPPuW9VTJcsAwCcTIyuWptjnqeiXftht
         4v23yfumAIFckvCK78L1gnjH+wxMXaZkTFQMHY8Zoel72IQpX0+y14XVQdkDoxZEU5AG
         QaimuU5z7f0OFzmsOpp56TkzmTso+JhM3WLcvWV7xidhjLU6kZt9cVNnRr5cp4iXExcW
         fZlJ/oXBwAzV+GgVsgje5fO5LfiVuUEeAmqk8zgZf8vmaRjHHull4spKq7bXf6F3DYys
         f3Nw==
X-Gm-Message-State: AFuF++l9syB4OowwQIgfDPurJQObXsJwe6SZxIcsGZ3EGH6z+SWIbZTx
	mprLsnapfZgxZPXv0BDPGcV/uOckdQchF/5QzHSPP3Hno2kYkR5hvy+XauLdfML1
X-Gm-Gg: AYBFou2uJfqvJIfEdr0N/P0RfUyC4egXvlTf4G4W3xmHs2cKEUvNXIRNSATog2E0QdZ
	bk+O9OOKcN9Zk2nxyN3vehvvzrw/ROzpcL1Yi7snqHp8ZHoIkLCzR+W7mKdZ4fpT2WjqVTyJB/g
	JmLj4fJ13QmUrReNXU6r2da0+DUsMH2hOxIVAgJD2o5z4UJBnYO9shqPq+FBjRLgG67XeCfA4sk
	/0SgMi4oxbRxeZBjjmkZ/7papIuHEChBsk2BnUWxkGCVDi/kVBTmXzcwyBpHduP4aPkda33fFvu
	XdJFa8SwMD+OOpxlMCVuUEI0t2ROXadYPM3fmb/KxCvCfLepUn5KR9jLg9JO+XVfGy1lzdIDDk3
	wbkEY5zW6QRMH6GJ53H5XOfzKj9SBOhuwQQBfU/CSJlj7ydwQ50c/L/R2oc4RcJeas0QhH86OXl
	QjThVdjso40u5vbSrKpNBgBgp2dyLH1+olJMGcRLH1u7+TIgQjjbE74A8jubYj
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39aee04acdamr230086a91.14.1788301490425;
        Tue, 01 Sep 2026 15:24:50 -0700 (PDT)
Received: from [127.0.0.1] ([134.33.70.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f079c3110sm1128802eec.6.2026.09.01.15.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 15:24:49 -0700 (PDT)
Message-Id: <b93b26ed9ff6fd37a7533885efb90df9982610c6.1788301481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v4.git.git.1788301481.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 01 Sep 2026 22:24:41 +0000
Subject: [PATCH v4 5/5] commit: refuse partial commits during conflict
 resolution
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Similar to the previous commit, just as `git commit --amend` is a
foot-gun during conflict resolution, so is a partial commit (`git commit
<paths>`).  Recording a conflict resolution is about capturing the state
of the entire tree on top of HEAD, not a subset of paths.  For many years
we have rejected partial commits in the middle of
  - a merge
  - a cherry-pick

but, just like amending, this was never extended to the other operations
that can also leave conflicts to resolve:
  - an `am` operation
  - a revert
  - a rebase that stopped for conflict resolution

Reuse sequencer_ongoing_operation(), introduced for the analogous
`--amend` check, to detect these and refuse the partial commit.  A rebase
that stopped because a pick became empty is not conflict resolution and,
as an earlier patch established, is deliberately left permitted.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c                | 24 ++++++++++++++++++-----
 sequencer.h                     |  5 +++--
 t/t3404-rebase-interactive.sh   | 34 +++++++++++++++++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 11 +++++++++++
 t/t4151-am-abort.sh             | 11 +++++++++++
 5 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 284fc7fdc6..4e0fd58f0a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -515,11 +515,25 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 */
 	commit_style = COMMIT_PARTIAL;
 
-	if (whence != FROM_COMMIT) {
-		if (whence == FROM_MERGE)
-			die(_("cannot do a partial commit during a merge."));
-		else if (is_from_cherry_pick(whence))
-			die(_("cannot do a partial commit during a cherry-pick."));
+	switch (sequencer_ongoing_operation(the_repository, whence)) {
+	case ONGOING_NONE:
+		break;
+	case ONGOING_MERGE:
+		die(_("cannot do a partial commit during a merge."));
+	case ONGOING_CHERRY_PICK:
+		die(_("cannot do a partial commit during a cherry-pick."));
+	case ONGOING_REBASE_NOW_EMPTY:
+		/*
+		 * A pick that became empty is not a conflict, and creating
+		 * a new commit (partial or not) poses no problem.
+		 */
+		break;
+	case ONGOING_REVERT:
+		die(_("cannot do a partial commit during a revert."));
+	case ONGOING_AM:
+		die(_("cannot do a partial commit during an am session."));
+	case ONGOING_REBASE_CONFLICT:
+		die(_("cannot do a partial commit while resolving conflicts during a rebase."));
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
diff --git a/sequencer.h b/sequencer.h
index fb4a744208..61ebc2ca40 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -279,8 +279,9 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 
 /*
  * An in-progress operation that records its result (often a conflict
- * resolution) as a new commit on top of HEAD, during which amending
- * HEAD via "git commit --amend" is almost always a mistake.
+ * resolution) as a new commit on top of HEAD.  Some ways of invoking
+ * "git commit" -- amending HEAD, or a partial commit -- are almost
+ * always a mistake during such an operation.
  */
 enum ongoing_operation {
 	ONGOING_NONE = 0,
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 4e6c3e2f19..8c63682b7f 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1970,6 +1970,40 @@ test_expect_success 'commit --amend is refused at an apply-backend conflict stop
 	)
 '
 
+test_expect_success 'partial commit is refused at a rebase conflict stop' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 3" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	echo resolved >conflict &&
+	git add conflict &&
+	test_must_fail git commit conflict 2>err &&
+	test_grep "cannot do a partial commit while resolving conflicts during a rebase." err
+'
+
+test_expect_success 'partial commit is refused at an apply-backend conflict stop' '
+	test_when_finished "rm -rf apply-backend" &&
+	test_create_repo apply-backend &&
+	(
+		cd apply-backend &&
+		test_commit base file &&
+		git branch -M mainline &&
+		test_commit upstream file upstream &&
+		git checkout -b side mainline~1 &&
+		test_commit conflicting file side &&
+		test_commit unrelated other &&
+		test_must_fail git rebase --apply mainline &&
+		echo resolved >file &&
+		git add file &&
+		test_must_fail git commit file 2>err &&
+		test_grep "cannot do a partial commit while resolving conflicts during a rebase." err
+	)
+'
+
 test_expect_success 'todo has correct onto hash' '
 	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
 	onto=$(git rev-parse --short HEAD~4) &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 42de398f76..c3d024c97f 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -375,6 +375,17 @@ test_expect_success 'commit --amend of revert fails' '
 	test_grep "in the middle of a revert -- cannot amend." err
 '
 
+test_expect_success 'partial commit during a revert fails' '
+	pristine_detach initial &&
+
+	test_must_fail git revert picked &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git commit foo 2>err &&
+
+	test_grep "cannot do a partial commit during a revert." err
+'
+
 test_expect_success 'successful revert does not set REVERT_HEAD' '
 	pristine_detach base &&
 	git revert base &&
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 9313a074b2..c80269e015 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -74,6 +74,17 @@ test_expect_success 'commit --amend during a failed am fails' '
 	git am --abort
 '
 
+test_expect_success 'partial commit during a failed am fails' '
+	git reset --hard initial &&
+	cp file-2-expect file-2 &&
+	test_must_fail git am 000[1245]-*.patch &&
+	echo resolved >file-1 &&
+	git add file-1 &&
+	test_must_fail git commit file-1 2>err &&
+	test_grep "cannot do a partial commit during an am session." err &&
+	git am --abort
+'
+
 test_expect_success 'am -3 --skip removes otherfile-4' '
 	git reset --hard initial &&
 	test_must_fail git am -3 0003-*.patch &&
-- 
gitgitgadget
