Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EC2379989
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 01:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787792543; cv=none; b=gq9gBq0gWNSGihxTlRGNmBcPKvIqFZRBMeSodfhOIfrc5TyWfid5F4se6QXeESNM601Rxi4VXvcSBInPsjnuP7+Gxb0QcxWOyBIGEZTdIM/KpMq5EMnaTkWVkwz4zElrb4fIoXDgD9NSdjhanFrdsJ4xPM01emELLObCi1pxbzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787792543; c=relaxed/simple;
	bh=IFzZ0vYFVVEP8AOF+YluD4IW7JfvCWIc+9HO06Rxiew=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=KIex20hoesqKpv/HQLVJuR0IpzEjX2bgBeo5dob/lCrz9/cxic2jfyvClYuGGRrFiHOZOkYjKuHQctznZv2qRWCGN2XHnnZ/zbM46KiulcDo7W/MQR4dzKfPY7GPRZjCnXx4bGmrDX1BvoAVlskFakeVdpv0TGOkIHDs5LqY0CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=El3WSy+9; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="El3WSy+9"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-448b89f700fso1693928fac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 18:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787792540; x=1788397340; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e11gwbyJVSSdT4692WPSQSZ/Tjv12vkBlsw3w+V3qzQ=;
        b=El3WSy+9cYVTaVePo9bWNyvKgLyql6e3USZfrNJ5s+s4THKWbNro7phVXe4293P2Wf
         Tlhn6VZO+loC4x4uxesY362BLbTFxI7n52lE52fQCO55k5Uj4uWH9gZrhntjsnDWpIrS
         TTyMpjMzeH0ItAL8EFDN+NvZZ2lN3ifAaN8NVoPq8VkyPMX1Om8S829UU2VLfGLhTCoa
         iGrX0/7KOxYpxoB/MTnrriOxuyPl2bL/p9QKCJW1jA1s7cB9kO/iRC+pwZgPW4t8SWnS
         Ih98VxcZ1njVUE0QK3GM/e8QHcEBRmb2kccyW/ZcAhdzXLZ1rN06KYVh/ciuet+jbiJM
         92XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787792540; x=1788397340;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e11gwbyJVSSdT4692WPSQSZ/Tjv12vkBlsw3w+V3qzQ=;
        b=cwF6qNn27NqBI8CJnzhJFFazQ2RHRufGvHKRpzQ8pC1QJzx1Ca9V1ShRqjY/ZX1I4L
         W/uOd+/uOTnGpdwNIV4pE3qmP1+g6oOPNIOM6rPXFNWAq7IpKTaQguxvROkXEemwSJO1
         l2k/Ezl0uRDJULOdjUgSDcX8BsJ9pESK9hCyDlj0BP0Ckjs23mzMCZ4rXscSK62QObbZ
         l6F3OpqfCBikWTA8au2xnQa8bHPWc9+r4JUjQKWbg3gvfuWDsTByfuNyU3LqIeSldnJT
         QI3+ViBsBbCL9SvrFMSr0Xhj+gGCPdqtXplbqA3HbHHgCwvbxaxjTcEu1ZeXkrso+dQk
         sp2w==
X-Gm-Message-State: AFuF++kGp3cF27GbYyP1GjRuQ6SN52M0wMskm1F3g1J3FqBy9IoaqGIL
	NbqCAYBAKc1YGXk/hTXy7oUvG/3RIT5aQN2jV6Rt1K/bSa+aeE3FUEo6OE+ikw==
X-Gm-Gg: AR+sD10IHlUPdU0oGhm9x+/Ty4a6qfy8N2NaTrNUBfra+FvPugSyrs73rPGCoX4bWKH
	oo47ZKpnXVxNeLIzeCGFId/LPcLk/ruQmMXp0HwHjrnu9/exSFZSpPnXFiXH1793BKC1Su4v25d
	yZOhckXsreOz5QiQsX+pB/769LVXggRurwfNJ4b20LtvV3dnrrwhyQemQ/ZADHjXNyEKDx5udoF
	YtLXjC9bo+0VxS3Q7W0BQNNeRLGqEYfWHe6Nmjv4jUcM57SLchQXgDdcmUyYt+Ss6p99tsKQAlK
	ULwrIsTntxvetDLHgq0FKfId5KHK9hHJQBX72rm9lRxliSsPmm6hyeTCjz28GBanv7Io5ikYFQ/
	wa9MXJ+UiHnVnFu8jRsvJEw/y3LfBhohRYZDTMs/0q8sBeuMyDFMejL9RqFD6OHc1Lk1+oRaogp
	balrrYF1vXBWNqZKITDf6pNXpLDD3pNJUpdBdhRuZYxD+36ghlPBbHCY/tEdjkfks=
X-Received: by 2002:a05:6871:a1e2:b0:447:7f2a:baa7 with SMTP id 586e51a60fabf-4659b7c8c32mr11896799fac.16.1787792540335;
        Wed, 26 Aug 2026 18:02:20 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.98])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-467366b6351sm485592fac.7.2026.08.26.18.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:02:19 -0700 (PDT)
Message-Id: <e0be8cdf63446e0535e020abbff2ec209cb518d4.1787792534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 01:02:14 +0000
Subject: [PATCH v2 3/3] commit: refuse partial commits during conflict
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
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Similar to the previous commit, just as `git commit --amend` is a
foot-gun during conflict resolution, so is a partial commit (`git commit
<paths>`).  Recording a conflict resolution is about capturing the state
of the entire tree on top of HEAD, not a subset of paths.  For many
years we have rejected partial commits in the middle of
  - a merge
  - a cherry-pick
  - a rebase that stopped at a pick

but, just like amending, this was never extended to the other
operations that can also leave conflicts to resolve:
  - an `am` operation
  - a revert
  - a rebase that stopped for conflict resolution

Reuse sequencer_ongoing_operation(), introduced for the analogous
`--amend` check, to detect all of these and refuse the partial commit.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/commit.c                | 22 ++++++++++++++-------
 sequencer.h                     |  5 +++--
 t/t3404-rebase-interactive.sh   | 34 +++++++++++++++++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 11 +++++++++++
 t/t4151-am-abort.sh             | 11 +++++++++++
 5 files changed, 74 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 4a6054aae0..9da3f1191b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -515,13 +515,21 @@ static const char *prepare_index(const char **argv, const char *prefix,
 	 */
 	commit_style = COMMIT_PARTIAL;
 
-	if (whence != FROM_COMMIT) {
-		if (whence == FROM_MERGE)
-			die(_("cannot do a partial commit during a merge."));
-		else if (is_from_cherry_pick(whence))
-			die(_("cannot do a partial commit during a cherry-pick."));
-		else if (is_from_rebase(whence))
-			die(_("cannot do a partial commit while resolving a commit that became empty."));
+	switch (sequencer_ongoing_operation(the_repository, whence)) {
+	case ONGOING_NONE:
+		break;
+	case ONGOING_MERGE:
+		die(_("cannot do a partial commit during a merge."));
+	case ONGOING_CHERRY_PICK:
+		die(_("cannot do a partial commit during a cherry-pick."));
+	case ONGOING_REBASE_EMPTY:
+		die(_("cannot do a partial commit while resolving a commit that became empty."));
+	case ONGOING_REVERT:
+		die(_("cannot do a partial commit during a revert."));
+	case ONGOING_AM:
+		die(_("cannot do a partial commit during an am session."));
+	case ONGOING_REBASE_CONFLICT:
+		die(_("cannot do a partial commit while resolving conflicts during a rebase."));
 	}
 
 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
diff --git a/sequencer.h b/sequencer.h
index 3a4bd97db1..634d1ddcb3 100644
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
index 7cf06e5f9a..1314b0fd05 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1971,6 +1971,40 @@ test_expect_success 'commit --amend is refused at an apply-backend conflict stop
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
