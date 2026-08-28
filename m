Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B033E0C44
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903100; cv=none; b=lb/Xvw8zY2bEKYClhyy6p4sr2fTaFItDoapeo+Z/OcYrK/Hx5KcW5m0ansWY7feiN/KV23nnJDTv79cuVxFhZNUiDVyHOWSzT7XxeM9BcklXoGVr0Ma8a1MVjNLyzg8OPc9+jaN2+TNZHBKV1Qj/vBe6lYFjFb7vBKgs5ZcFcjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903100; c=relaxed/simple;
	bh=Hz+rZwmHKrZIXHo/5uZF9K4o/CnswiiU9u7HHzyEPlQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j8EByf2mwcXueb41lX0JfrNPUvVQK7UuEgjsIjGqt6RinNY2LsDlpKNvFzcU6D5dvVbwXC/w3Ld4komxC6OunafzlFe0Thi9zePy+24Yo54sX8esbWDC3+9yrdmjcYFAAGA3OZrroDQNDT7SPuGmlBzmuM7gqkwmYLNbwV+YapI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeAXlf4x; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeAXlf4x"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-462df62f872so2098317fac.0
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903098; x=1788507898; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ype+/+1j4gUoaYAWLyk8qZXmb+nRqloLZXJYEt0aN0U=;
        b=CeAXlf4x7qVH7EhFi9XzAESKIMbHO4nzgE5DdTVAIuYBJSpvJK0ii5Kk4kEEahklDm
         PKfLKMcU3IVaqSKCRhZJx5GO2hMyfOOHTYEnOqz56x1Uqq8dBhegGHuLjgrbCSxZp0W8
         1BHIlST+6w06YYwuvy7S/v3PTWCayutz0QTJW+laUdfxRGBHf/tOhESamuCWu/TogYzM
         IFnflra4tl3HzkQqa6jlIO9HBE/rnvsD+RjXmydoI7YN1W4ldJJAdDIDLcHfhtIwweYx
         6XRgGAVYJ4kLi5TcFXGmp86jtsdIBNoIpUd+lm5ODpzHPufet/fxcMr0ESTFaF3SRp35
         TxrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903098; x=1788507898;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ype+/+1j4gUoaYAWLyk8qZXmb+nRqloLZXJYEt0aN0U=;
        b=PM1hb0jZcALORr/5V2nZrX4IA62vL4s/IpvYfAks3LjodPXgULRDCqDssbuSJXYCKD
         74ZcIG/Ggp6iELf9ELRmmPc+KqECLms2lktI5s4QhMVT11b08wrw3hvaMkGA2E4wsh4Y
         pTG2va7N4U+VQl2UBzxv60CWTNuBJXFN+wTttdIpFXf94y4dz36ZQfBK0l/5XY+Bb7Mj
         xwePZPx5HNfX3jkSEUKomTDPuDoGRkKtA+XgUhcJwaTjVfyhuq3y5+SzoGR60YXbWUg/
         Zfb9D1jhjEdVcE7rQ3nh9XW6/fZo7nEyoYfUL9GFT+7hDfr+CmWciiPHUOQrLYmgRPiD
         8/Gg==
X-Gm-Message-State: AFuF++mWfR5SV+IkUSyTnCYQBx4s1bGdPjbxpJcuq4Dv3R4q6eSyn7r7
	/X2FZOH1XE1JtbN1OqcvAgIIp4oztdzT0ndihVYhrRqWunO/x6vsVFT00W2NcZQL
X-Gm-Gg: AR+sD13cbiFN5Z8h0fxV7Ny0oJ+oCXw1ZKi8SjzMlzUdGDsgWiK+7M+nN9hgcEc0uUg
	D272KEZDSe0b0qYC21xARWyjjqt4ng8E5DMfRXj5rg6vsPC4wNPvCq5J9S/p4My6+Dm/U9mP7vN
	By3ePsVk8bauYfR7hxDwvez6m8ohadh6o87ogIEzYlX8Yn10kINqNHY2UlZhPmdszJSJBsb9Wxl
	+ZEE9P3NfK6ObVvwexTAe4eah0aALU1LvKGHlGoxL5PhE6aMIwjwcSTsfDbv69beehMsyssF60m
	WOdnd2Sauj14+3zG7VSiFmlHtRTaJwkVd9jTQVjCzFp4GErcwv7n28lh+AylFI95+ljNTSE7in9
	myc9NqCf7ZoPRIkhYaGdQDCOZxZHQ0lVS5UeOxYuvh6dFb+jBubEj6cUCeeGWwuHjaHIKRuf/PO
	ZsXYbsvXu+7E5s87DnwowzEouR1sY6/I+EQC3ZoBGYPcALj0KqcDAwFQ92hK9Arw==
X-Received: by 2002:a05:6870:8a2a:b0:44c:5514:80ae with SMTP id 586e51a60fabf-4682d70e8camr4104427fac.3.1787903097624;
        Fri, 28 Aug 2026 00:44:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.78.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a54598ddsm821032fac.15.2026.08.28.00.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:44:57 -0700 (PDT)
Message-Id: <9f80d8a00d3895e2113d4e7259c93cb899c6cf57.1787903085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 07:44:44 +0000
Subject: [PATCH v3 4/5] commit: refuse to amend during conflict resolution
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
 builtin/commit.c                | 27 +++++++---
 sequencer.c                     | 57 +++++++++++++++++++++
 sequencer.h                     | 23 +++++++++
 t/t3404-rebase-interactive.sh   | 87 +++++++++++++++++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 11 +++++
 t/t4151-am-abort.sh             | 11 +++++
 6 files changed, 210 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 774fb8299d..83ea8619d6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1324,15 +1324,30 @@ static int parse_and_validate_options(int argc, const char *argv[],
 		use_editor = 0;
 
 	/* Sanity check options */
-	if (amend && !current_head)
-		die(_("You have nothing to amend."));
-	if (amend && whence != FROM_COMMIT) {
-		if (whence == FROM_MERGE)
+	if (amend) {
+		if (!current_head)
+			die(_("You have nothing to amend."));
+		/*
+		 * Refuse to amend in the middle of any operation that is
+		 * meant to record its result as a new commit on top of HEAD
+		 * rather than by rewriting HEAD.
+		 */
+		switch (sequencer_ongoing_operation(s->repo, whence)) {
+		case ONGOING_NONE:
+			break;
+		case ONGOING_MERGE:
 			die(_("You are in the middle of a merge -- cannot amend."));
-		else if (is_from_cherry_pick(whence))
+		case ONGOING_CHERRY_PICK:
 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
-		else if (is_from_rebase_empty(whence))
+		case ONGOING_REBASE_EMPTY:
 			die(_("The now-empty commit has been dropped -- cannot amend."));
+		case ONGOING_REVERT:
+			die(_("You are in the middle of a revert -- cannot amend."));
+		case ONGOING_AM:
+			die(_("You are in the middle of an am session -- cannot amend."));
+		case ONGOING_REBASE_CONFLICT:
+			die(_("You are resolving conflicts during a rebase -- cannot amend."));
+		}
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
diff --git a/sequencer.c b/sequencer.c
index 0ea730a8dc..d67896fcd1 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -142,6 +142,13 @@ static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
  * command is processed, this file is deleted.
  */
 static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
+/*
+ * The apply ("am") backend keeps its state in the rebase-apply directory;
+ * the "applying" file within it marks a plain `git am` (as opposed to an
+ * apply-based rebase).
+ */
+static GIT_PATH_FUNC(apply_dir, "rebase-apply")
+static GIT_PATH_FUNC(apply_path_applying, "rebase-apply/applying")
 /*
  * When we stop at a given patch via the "edit" command, this file contains
  * the commit object name of the corresponding patch.
@@ -6966,6 +6973,56 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 	return 0;
 }
 
+enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
+						   enum commit_whence whence)
+{
+	/*
+	 * The merge, cherry-pick, and (empty) rebase-pick stops are already
+	 * distinguished by 'whence'.
+	 */
+	switch (whence) {
+	case FROM_MERGE:
+		return ONGOING_MERGE;
+	case FROM_CHERRY_PICK_SINGLE:
+	case FROM_CHERRY_PICK_MULTI:
+		return ONGOING_CHERRY_PICK;
+	case FROM_REBASE_EMPTY:
+		return ONGOING_REBASE_EMPTY;
+	case FROM_COMMIT:
+		break;
+	}
+
+	/*
+	 * 'whence' is FROM_COMMIT, but we may still be in the middle of an
+	 * operation that records its result on top of HEAD; detect those
+	 * from their on-disk state.
+	 */
+
+	/* In the middle of a revert? */
+	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
+		return ONGOING_REVERT;
+
+	/* In the middle of an `am`? */
+	if (file_exists(apply_path_applying()))
+		return ONGOING_AM;
+
+	/*
+	 * In the middle of a rebase that stopped for conflict resolution?
+	 * The apply backend only ever stops for conflicts, so the presence
+	 * of its state directory is enough.  The merge backend writes
+	 * stopped-sha whenever it hands control back to the user, but omits
+	 * `amend` unless it stopped with HEAD already pointing at the commit
+	 * to be amended (a clean edit/reword stop); its absence therefore
+	 * marks a conflicted stop.
+	 */
+	if (file_exists(apply_dir()) ||
+	    (file_exists(rebase_path_stopped_sha()) &&
+	     !file_exists(rebase_path_amend())))
+		return ONGOING_REBASE_CONFLICT;
+
+	return ONGOING_NONE;
+}
+
 int sequencer_get_update_refs_state(const char *wt_dir,
 				    struct string_list *refs)
 {
diff --git a/sequencer.h b/sequencer.h
index 64a9c7fb1b..3a4bd97db1 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -277,6 +277,29 @@ int sequencer_get_last_command(struct repository* r,
 			       enum replay_action *action);
 int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
 
+/*
+ * An in-progress operation that records its result (often a conflict
+ * resolution) as a new commit on top of HEAD, during which amending
+ * HEAD via "git commit --amend" is almost always a mistake.
+ */
+enum ongoing_operation {
+	ONGOING_NONE = 0,
+	ONGOING_MERGE,
+	ONGOING_CHERRY_PICK,
+	ONGOING_REBASE_EMPTY,
+	ONGOING_REVERT,
+	ONGOING_AM,
+	ONGOING_REBASE_CONFLICT
+};
+
+/*
+ * Return which in-progress operation, if any, is underway; see enum
+ * ongoing_operation.  'whence' is the origin already computed for the
+ * pending commit.
+ */
+enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
+						   enum commit_whence whence);
+
 /**
  * Append the set of ref-OID pairs that are currently stored for the 'git
  * rebase --update-refs' feature if such a rebase is currently happening.
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 81f4844950..4e6c3e2f19 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1883,6 +1883,93 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	test_grep "now-empty commit has been dropped -- cannot amend." err
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
-- 
gitgitgadget

