Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FC037F334
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 05:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787721685; cv=none; b=VTeewlnlpM+Z0dLsaclfylGEMebC6nYOCocG+5kobCM3ZAqp4pdlovcIZCVGHOeDe9es5FryPK2WOMeBg7LHFn/LMVbLBEAZVQrWttGv/JJvyCVtQjbWRDMA+ly/Bht1IAQqyqFuF4txVg+FZE33z/NMTRg5BTpyHUNhAiC0d0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787721685; c=relaxed/simple;
	bh=kG4fNcVw/yBpSOJ4yFyfDYeoaEgq7NN1vwNjon6aO1g=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Ci+mTm9DrA2jqFtQ5EPFbZomx8sBD0T+4UBhrYcep623uMqZY6tKk47XcGuhbBtE4tF0KJ88mH1068jX+ciFTLLUtQXAa7hfuRAnnHHdb73VfnLYVZ4Z/tGbuTCc9Dk6s300f0m/8duxGcUsBH5DEGEmz9klE+tEx5vos5aQDnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EgDV76e1; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EgDV76e1"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-93695893ac1so36466885a.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2026 22:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787721683; x=1788326483; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ODmpXAQsPMlzFrlGw5cyqr4doGYVXWwS8TmjNLUnj/Q=;
        b=EgDV76e1W2VCXZdv7ZcL/3M7BUfOzhrMxMccmtpe/F3laBoMVCMTPvIadxwLBgKoIm
         FrMov5E2UI2yii+2yYbsofmhh/Z92g3q+JJVOu7j1r9mQN65KJgNyrhxqz+N/bb6vwC1
         7pJWJUkThe5Jk3VIDTaJqjlHZo9tpogjJKlaBniU+rmhsP85iK+oE33OioZBwo0J7+eC
         l9LPkywUNFggD1VXb2UwznQbF1/3f116iXdxlKNNeLx0B6dMxxiv8kMqyoPALc/RsRqR
         vjOpIVSbMKXD/pUETVEhB9Wo01Mcww8wz+Zki0ekhwtUuq1FeiDhSruH8d7sAmTioKO4
         IppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787721683; x=1788326483;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ODmpXAQsPMlzFrlGw5cyqr4doGYVXWwS8TmjNLUnj/Q=;
        b=lROZl73qAS5d521ZNwR3xygWCPVUUocPPhIdbobkcgJeAoFGicfvjt/a5M1cu1oosi
         P9uG68YSIT9Pn9b/D4I/TM/mxewAzdZVcq7dPYGlPgghtvHs87lSRCb08+A0ygl2CrVj
         PyrJWOLN2mwCWr+f2POIyRv4fD5P6A236cNQFjxEhjIh1LdAFOBalomteCz4fhp9yZ2X
         7h+uPZXxOHVX6av86R0L1Ut8+0SqbOiLnCF1QAPO9sMQ9y2y1RR0tGLI5iF7bHB7IMEN
         rlvnlW5ItCz3gLvWOXESyDArDICXJq48xMzOAVFAKeYxou6t6h6xxCShd5cItIlggPFv
         FIHg==
X-Gm-Message-State: AFuF++lQYSQE6X3WXQFhTnPScvIam6xmOTBX7jjyoeEhDMZA5fyOXAoR
	1lBmT6+Mil1l8roTPkGIR64U5siBLG2/RBXv4Kkh5pZbL9yZQ+Ez50R9fF5B7Q==
X-Gm-Gg: AR+sD10ywLuwfr6WRapzYJ5Ldd+jvCjeLQjnlTmPsh43/SvmV+aOP23X4NS79ph9vTB
	8jICeVvvaBRYtHalxAm8//BrUITRFf1MncmE8woObXsHThi/eFbLWrELCKdGowgQflfo9AaSz4b
	qIJIO//idNpzZ9X2EGfvQtsmDmlplKjO4no9Bb/4r3txAPuaf/vIihMBJ7j7tFHEp6r9pfKa+Cb
	pY0mD2Z11y/fWaU7/wUu5GtH6zFZ/6XYT6wzJbfGO1/IfJkMvv3gIR2hcHPlekoaNztwu+Lahpj
	R1xsqAyprK62YfOqL9/+URQ1z4GvCQHA58dkzFQ4z9vZ1NX/7zOx3bxEvUxiUm81DWNUtddIAL6
	6RWM9hniIEpswE0pYwShP4AsqsBfBWkWGuPQZha8AenAacxl8lf3T88h1yhWBDL2BBfWqmtJDzr
	jhoqv3z9Qn0gY1MQtWG0ucaKx55g0t3KA3vS7a3oJDxBAyJsotU78NtPOHh2Myaqo=
X-Received: by 2002:a05:620a:a2cc:20b0:936:cd1a:41c5 with SMTP id af79cd13be357-9377fe3307dmr282113985a.0.1787721682914;
        Tue, 25 Aug 2026 22:21:22 -0700 (PDT)
Received: from [127.0.0.1] ([20.161.45.116])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9377e30a2e9sm135911185a.2.2026.08.25.22.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 22:21:22 -0700 (PDT)
Message-Id: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Aug 2026 05:21:21 +0000
Subject: [PATCH] commit: refuse to amend during conflict resolution
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
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Running `git commit --amend` during conflict resolution is an ugly
foot-gun.  For many years, we have rejected amending during conflict
resolution in the middle of
  - a merge
  - a cherry-pick
However, this was never extended to other operations that can also
produce conflicts:
  - an `am` operation
  - a revert
  - a rebase

Extend it to handle these other cases now.

Extending to `am`, revert, and the apply backend of rebase are fairly
straightforward.  However, with the merge backend of rebase we have to
be more careful, since it powers interactive rebases and
  - the interactive machinery internally uses `git commit --amend` for
    `squash` and `reword` directives
  - users are expected to `git commit --amend` after hitting an `edit`
    or `break` directive
So, we need to be careful with rebase to only reject amending when doing
conflict resolution.

A few files under the rebase-merge/ directory provide us the necessary
information:

  - stopped-sha is written only when the rebase stops and hands control
    back to the user, so its presence marks a genuine stop -- as opposed
    to the sequencer's own internal `git commit --amend` while applying
    a squash, fixup, or reword, during which no stopped-sha exists.

  - amend is written only when the rebase stops with HEAD already
    pointing at the commit the user is meant to amend: a clean `edit`,
    or a fast-forward `reword`.  Its absence at a stop therefore means
    the commit did not apply, so HEAD is the previously-applied commit
    rather than the one being rebased -- exactly the case we refuse.

So for the merge backend we die when stopped-sha exists and amend does
not.  This covers a plain conflicted pick as well as a conflicted `edit`
(both leave HEAD on the previously-applied commit), while still allowing
a clean `edit` or `reword` stop and a `break` stop (no stopped-sha).
stopped-sha is unlinked at the start of the resume loop, so a resumed
squash's internal amend is unaffected.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
    commit: refuse to amend during conflict resolution

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2389%2Fnewren%2Frefuse-amend-during-conflicts-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2389/newren/refuse-amend-during-conflicts-v1
Pull-Request: https://github.com/git/git/pull/2389

 builtin/commit.c                | 41 ++++++++++++++++
 t/t3404-rebase-interactive.sh   | 87 +++++++++++++++++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 11 +++++
 t/t4151-am-abort.sh             | 11 +++++
 4 files changed, 150 insertions(+)

diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..a9fd04366e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -30,6 +30,7 @@
 #include "path.h"
 #include "preload-index.h"
 #include "read-cache.h"
+#include "refs.h"
 #include "repository.h"
 #include "string-list.h"
 #include "rerere.h"
@@ -1336,6 +1337,46 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		else if (whence == FROM_REBASE_PICK)
 			die(_("You are in the middle of a rebase -- cannot amend."));
 	}
+	if (amend && whence == FROM_COMMIT) {
+		char *applying, *apply_dir, *stopped_sha, *amend_marker;
+		int in_am, conflicted_stop;
+
+		/* Check middle of revert */
+		if (refs_ref_exists(get_main_ref_store(the_repository),
+				    "REVERT_HEAD"))
+			die(_("You are in the middle of a revert -- cannot amend."));
+
+		/* Check middle of `am` */
+		applying = repo_git_path(the_repository,
+					 "rebase-apply/applying");
+		in_am = file_exists(applying);
+
+		free(applying);
+		if (in_am)
+			die(_("You are in the middle of an am session -- cannot amend."));
+
+		/* Check middle of rebase specifically stopped for conflicts */
+		apply_dir = repo_git_path(the_repository,
+					  "rebase-apply");
+		stopped_sha = repo_git_path(the_repository,
+					    "rebase-merge/stopped-sha");
+		amend_marker = repo_git_path(the_repository,
+					     "rebase-merge/amend");
+		/*
+		 * The apply backend only ever stops for conflicts; the
+		 * merge backend writes stopped-sha but omits `amend`,
+		 * which it writes only at a clean edit/reword stop.
+		 */
+		conflicted_stop =
+			file_exists(apply_dir) ||
+			(file_exists(stopped_sha) && !file_exists(amend_marker));
+
+		free(apply_dir);
+		free(stopped_sha);
+		free(amend_marker);
+		if (conflicted_stop)
+			die(_("You are resolving conflicts during a rebase -- cannot amend."));
+	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
 	die_for_incompatible_opt4(!!use_message, "-C",
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index ff11abb2f2..01d4735b3b 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1884,6 +1884,93 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	test_grep "middle of a rebase -- cannot amend." err
 '
 
+test_expect_success 'commit --amend is refused at a rebase conflict stop' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 3" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	test_path_is_file .git/rebase-merge/patch &&
+	test_path_is_missing .git/rebase-merge/amend &&
+	echo resolved >conflict &&
+	git add conflict &&
+	test_must_fail git commit --amend --no-edit 2>err &&
+	test_grep "You are resolving conflicts during a rebase -- cannot amend" err
+'
+
+test_expect_success 'commit --amend is refused when an "edit" pick conflicts' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="1 edit 3" &&
+		export FAKE_LINES &&
+		test_must_fail git rebase -i A
+	) &&
+	test_path_is_file .git/rebase-merge/patch &&
+	test_path_is_missing .git/rebase-merge/amend &&
+	echo resolved >conflict &&
+	git add conflict &&
+	test_must_fail git commit --amend --no-edit 2>err &&
+	test_grep "You are resolving conflicts during a rebase -- cannot amend" err
+'
+
+test_expect_success 'commit --amend is allowed at a rebase edit stop' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach no-conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="edit 1 2 3 4" &&
+		export FAKE_LINES &&
+		git rebase -i A
+	) &&
+	test_path_is_file .git/rebase-merge/amend &&
+	echo tweak >fileJ &&
+	git add fileJ &&
+	git commit --amend --no-edit
+'
+
+test_expect_success 'commit --amend is allowed at a rebase break stop' '
+	test_when_finished "git rebase --abort" &&
+	git checkout --detach no-conflict-branch &&
+	(
+		set_fake_editor &&
+		FAKE_LINES="break 1 2 3 4" &&
+		export FAKE_LINES &&
+		git rebase -i A
+	) &&
+	test_must_fail git rev-parse --verify REBASE_HEAD &&
+	echo tweak >fileJ &&
+	git add fileJ &&
+	git commit --amend --no-edit
+'
+
+test_expect_success 'commit --amend is refused at an apply-backend conflict stop' '
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
+		# the apply backend only ever stops for conflicts, and
+		# leaves HEAD on the previously-applied commit
+		test_path_is_dir .git/rebase-apply &&
+		test_path_is_missing .git/rebase-apply/applying &&
+		echo resolved >file &&
+		git add file &&
+		test_must_fail git commit --amend --no-edit 2>err &&
+		test_grep "You are resolving conflicts during a rebase -- cannot amend" err
+	)
+'
+
 test_expect_success 'todo has correct onto hash' '
 	GIT_SEQUENCE_EDITOR=cat git rebase -i no-conflict-branch~4 no-conflict-branch >actual &&
 	onto=$(git rev-parse --short HEAD~4) &&
diff --git a/t/t3507-cherry-pick-conflict.sh b/t/t3507-cherry-pick-conflict.sh
index 44596cb1e8..42de398f76 100755
--- a/t/t3507-cherry-pick-conflict.sh
+++ b/t/t3507-cherry-pick-conflict.sh
@@ -364,6 +364,17 @@ test_expect_success 'failed revert sets REVERT_HEAD' '
 	test_cmp_rev picked REVERT_HEAD
 '
 
+test_expect_success 'commit --amend of revert fails' '
+	pristine_detach initial &&
+
+	test_must_fail git revert picked &&
+	echo resolved >foo &&
+	git add foo &&
+	test_must_fail git commit --amend 2>err &&
+
+	test_grep "in the middle of a revert -- cannot amend." err
+'
+
 test_expect_success 'successful revert does not set REVERT_HEAD' '
 	pristine_detach base &&
 	git revert base &&
diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 8e1ecf8a68..9313a074b2 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -63,6 +63,17 @@ do
 
 done
 
+test_expect_success 'commit --amend during a failed am fails' '
+	git reset --hard initial &&
+	cp file-2-expect file-2 &&
+	test_must_fail git am 000[1245]-*.patch &&
+	echo resolved >file-1 &&
+	git add file-1 &&
+	test_must_fail git commit --amend 2>err &&
+	test_grep "in the middle of an am session -- cannot amend." err &&
+	git am --abort
+'
+
 test_expect_success 'am -3 --skip removes otherfile-4' '
 	git reset --hard initial &&
 	test_must_fail git am -3 0003-*.patch &&

base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
-- 
gitgitgadget
