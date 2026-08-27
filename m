Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C21433783AD
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 01:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787792541; cv=none; b=PfKa7VYynB49CCygWcfvdt4UCGe39Z1h8rPMKtEjqYA7C6AN0h3ucklA8w1CVtYjvltJWwkvBe7XTEta8UOJ5wt2Fwn2N8LYIp8uHzmD8zGvkR4PyIWevM08sB36z3Fh3puh4Asc7P7aSvYHZ4uL3Vyje7XKjouhgZageKaduHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787792541; c=relaxed/simple;
	bh=UOWunN4JaFfdqPo3bE1FuSKYywKgfAriLfcWm392uhI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=OGNuizPAxZ5Hta7l+J83KARhNk+eUWaX5x736V7ZUtcmkjqw3RZmaEJny2xoZsvXFaZkkVpGFwNCi+sK5XyT6jvNbv2JZcwLyGb2xHIpEQR1ulawy3WvNdRu7BXrVDFMGFjZV5P/FrSgwFVGJCPFPxRX3O/KfXgn1LT7vBmDFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmJMIHcq; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmJMIHcq"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4472500e25fso886954fac.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 18:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787792538; x=1788397338; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=N0ZzcZJg5GtH4SGbijf/xjXLkX/+vby28gTKP0tMQpo=;
        b=cmJMIHcqHIji7ToaGaZwz1Zishdk0x1Wa6NFMNwwKwKg0BNje+yN/J5jR4dpTWl4+T
         8rgnpdBlZj0KsdCAfbQO8/IB/I+CoHN7puro18EEvROuLsoQTzJ6LmcvBac9TiiBExr5
         eN7DNxNham37NpJ5y9KvmeQmGPwuiHhRoNiiPXKn/AtXDw1875Pfg06KVs6G6SMLtin3
         ZiQlFvPwLAjwskPyt4RcisduaqVC9q6m1mXf8kV0doNcEm3FNAg7yXJibH6Uo8C9zv7m
         /Bid7bFteAt4IVVCfVeH9f5RGDJKQQWqgZ2EEjz38PaZGx1un2ZDs3UYPltxoF1MNchM
         9y+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787792538; x=1788397338;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N0ZzcZJg5GtH4SGbijf/xjXLkX/+vby28gTKP0tMQpo=;
        b=W1luzMAIrERga2ysgTqefbdNYW+w/pZkbCT0yOQvL5/idh8eLPO8fd9hQO6JCy8FsC
         YrRlzNyVYb2wa6dKlHUA7bRHaSKWXs2XawpFDSJx9HTEBvzaBmfQeukzd0goOqKX8Li7
         bN1X3tRDAOGzN9MaMybI1bm1mFSYWvnh5kbmjDFmXBZRg/3vK0QTqwaJtv+LnetGP6IC
         KhrxNlVdqE+6TbTdNix/E92EB+/5HWccWClHETdrS44DhSubVmKZJ4I7FKvD9KeIx/R2
         /iZ9cAFOZbkxL5SP/qzOALeXcYAeYzjF9ds1YBxBdsl2X4fhm561ZoSiJSHFcZTE2dUB
         yi9w==
X-Gm-Message-State: AFuF++mvoeERC7nJPWvibFNUZZJpSssT1ZwQrSbOYzTrJ8RIyPPbYCLO
	u+PjHxnB236eZ2QVCkWjuxAtviOQeq6gGvuvVANc8aYSObmEpZEIkrYjF78+MA==
X-Gm-Gg: AR+sD10gQOxmHmQhVGiuIYVqi3RCuG140v4qaLhP/GTuUDn4D8eJ8aPWIZQwDINU2Cw
	qKoJONrRUP5i9b0hdQZe/1KrZ21RGpEaHCUh0LcWvwYMxe+tiPNFDnjwAyAIyf5uUjTJKnJSYRv
	8VtUlDX1stsMNXaf60rbRNIR9nMBwCSm7+lAYz3BQJM2ankLqtXPQk2fwzcrOJIHEoo63tTVs9J
	i5K4LVxz6qqjrobXU5LzhCTY6V4Me4dx9E5uDZCz9vCuMhktp5LdBqGOufonQxnDHcK9a/Uhk9H
	yNYiVV7ivrOY6tDFMhcSV0LHj7qEZvfBHFp7B3bFcvqoEdzsurGn0TghYXdusvx50WwhbRpg7rw
	QL+JeNGXG23xY2H72BDYLLjf72gsVcW66DdSkhdCJS/FKO4dOGtZoyA4Ak48vFAy2Avhiu1IBqZ
	YS0Sn575bifdGkd7tNcRg+I7pE08uC9MYI5yrfHNU6RSYB/eEgsryhGcJnGM33PpCt
X-Received: by 2002:a05:6871:2b17:b0:447:24bf:ec47 with SMTP id 586e51a60fabf-4659a8eb5c8mr11534341fac.10.1787792538354;
        Wed, 26 Aug 2026 18:02:18 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.98])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-467366b640esm516979fac.8.2026.08.26.18.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:02:17 -0700 (PDT)
Message-Id: <4a1461e52767227d9475de13cf250484f8ecd271.1787792534.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
	<pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 01:02:13 +0000
Subject: [PATCH v2 2/3] commit: refuse to amend during conflict resolution
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
 sequencer.c                     | 65 ++++++++++++++++++++++++
 sequencer.h                     | 23 +++++++++
 t/t3404-rebase-interactive.sh   | 87 +++++++++++++++++++++++++++++++++
 t/t3507-cherry-pick-conflict.sh | 11 +++++
 t/t4151-am-abort.sh             | 11 +++++
 6 files changed, 218 insertions(+), 6 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 0d908d72bb..4a6054aae0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1326,15 +1326,30 @@ static int parse_and_validate_options(int argc, const char *argv[],
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
-		else if (whence == FROM_REBASE_PICK)
+		case ONGOING_REBASE_EMPTY:
 			die(_("You are resolving a commit that became empty -- cannot amend."));
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
index 65afd100d9..bd4a724410 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -6966,6 +6966,71 @@ int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
 	return 0;
 }
 
+enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
+						   enum commit_whence whence)
+{
+	char *path;
+	int found;
+
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
+	case FROM_REBASE_PICK:
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
+	path = repo_git_path(r, "rebase-apply/applying");
+	found = file_exists(path);
+	free(path);
+	if (found)
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
+	path = repo_git_path(r, "rebase-apply");
+	found = file_exists(path);
+	free(path);
+	if (!found) {
+		char *stopped_sha = repo_git_path(r, "rebase-merge/stopped-sha");
+		char *amend_marker = repo_git_path(r, "rebase-merge/amend");
+
+		found = file_exists(stopped_sha) && !file_exists(amend_marker);
+		free(stopped_sha);
+		free(amend_marker);
+	}
+	if (found)
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
index 1e78dbfd90..7cf06e5f9a 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1884,6 +1884,93 @@ test_expect_success 'correct error message for commit --amend after empty pick'
 	test_grep "resolving a commit that became empty -- cannot amend." err
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

