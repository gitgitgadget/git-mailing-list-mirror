Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CEB26AE5
	for <git@vger.kernel.org>; Thu, 27 Aug 2026 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787792539; cv=none; b=p23fh7y7U3+8sfb45O0AeaEO0ijUy3MBpMMSdoGL8wcSFb6Kj2lQKeXL0LMlxTEPtZpF5og9FUtv2bKvUAON/UodcB2KzuKoB64vJ1IfyD/oy0LXqaMBTPcVDywTffjpB3BTWXlB4aEA7PsCb79K7JEcn8dCGamxTPjiZ25jzsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787792539; c=relaxed/simple;
	bh=IXcWTqGeP9t7d1gvUw9SJjCe9qfcwrFbBVn4coXLvTc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GOyjDFOFlonrs+pEnN6YcmWYJM2mZcjjCXeGW4/Boaa5V3m5CFmIGlpn715k6lBShP4+18JYahZIzwaLkdKQkNHw99xpSyt9mc9kH1MVpmTXxFSjWUMZkOKeMsjTTN5zY60VaaoUJK1j3XeiB1MOVGPPSbxNnNBiD9rrTPwpAPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCHTx8fO; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCHTx8fO"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-455ee8f529dso799360fac.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2026 18:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787792536; x=1788397336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sEt+cQrgP/Du7eCW6F0Io/JHkUzcqH2+lnBwsENK1U8=;
        b=eCHTx8fO5iX7Y+LE9sPTYBamqPc0QbExrdVwITvMi6UViRy89gGUggkv/o901A8/hZ
         dHJTJ8yJQPzNSk2KCk81hs+JbqaM10X7PCzl5ek5D4xJFUfWDcPt/h4XV7pgAewEBlcB
         L22mP5MX7oGfL9lTqbdqqJJE5O+8vgb5GLFR6qnlvlgq7Ysy89xyfLRjd8Nga2rrgok7
         +nV57guF6pL1yDFU3kRLrd8ngFZmQcRZeTLC0hywBKMjGz6SDaveznpLtD2H0j+bq/DV
         Tsaxi/Md1BwMhq808iyyRHRCt8XPJi17Onc1ktcLV++bQ4vx2rWvCg4NNfKIQlW50P7a
         nuZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787792536; x=1788397336;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sEt+cQrgP/Du7eCW6F0Io/JHkUzcqH2+lnBwsENK1U8=;
        b=JuFRP4512O1uxG3u43SZncmULv2RuedPYDe+Za7PZl0kOp0ofgjN0XpyvN7wthhIbd
         s/1VU7gwz/klVaEoZ5lB/X9eMheM4lb46uYELth9Rtc4U1tOnvuni4OWh8YJJYJL40uB
         UmHIP6Yis0Lgv2L7wl4UCeEqpvhT+cdZQEK3ccFr27L0SKATBDr62dQ3NZY2yYmq6Alq
         PuXvv9u3K8lS1LevnoQ9IThYSovrrGE5hjuwWaDDAkpuNMv8nRxu+olmW58RmKx3LwaG
         Tqrxn3x0npku/SprKmyU1Eb75DN8ipLuf9bslN9q2lsmgr1g2XTIYKSKA+64/PFG/BVm
         8oCg==
X-Gm-Message-State: AFuF++mpxp8UudtCy8TjqPd2td3IkGddlwWgeseN9eoP7Ex34/nXVzGp
	fXgVPAITfopJVEWoOhZ/CFF0OfXdknrFwYpq/OD0jTdvpzItr+BtkQSilLJ9EA==
X-Gm-Gg: AR+sD13rLGkKbT7EqXAeJjUPxf8lcx85p3Q+vRH0XoMHVmiyM68bsajZAp8eGR7/PF0
	IS6SekjCxvHK0ARw5VtTV5i1H3uLEja7mKKhb1yFzkK2VkthpHYY7QbET/lhnbM9hwrPpKA/Cvi
	kKwh7tRzaSvkOiaZ8MzKVL72Rcv9CqAnBK1z+atA6nnk6eqvJmHSZPjxCqyKmpk0ITQVw2RnUTr
	Vz+6JqIAxg4q79vYonMhasgugdxc4Z3L/SmxRRx92Bsuu/UAvK7m1yeDhXay7Ap4T9gdId5hlnG
	QVm5VlDw6ETq/skeEdYFa6LI+ZN7vlmwXe+YDLlfgccr09K8jEwJLu9EN98dzUuiuYNB51G/Faa
	IYtpF/JgrW8+Y8CJLRqOMxq7z0iXGDyFFWjdzWp/4vWvUjlkPH9WXKHoE8UjQnes2bnVoRWcKXL
	g1LcBiSeDKXTYM7Te+dHWCqUuB0L4kx2k7oF53zfaeS2GnjKGNbj19ut25WRtxywo=
X-Received: by 2002:a05:6870:6b97:b0:463:3935:9c30 with SMTP id 586e51a60fabf-4659b7c918amr13016309fac.18.1787792536156;
        Wed, 26 Aug 2026 18:02:16 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.133.98])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-46738dd7c30sm467946fac.10.2026.08.26.18.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 18:02:15 -0700 (PDT)
Message-Id: <pull.2389.v2.git.git.1787792534.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 27 Aug 2026 01:02:11 +0000
Subject: [PATCH v2 0/3] commit: refuse to amend during conflict resolution
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
    Elijah Newren <newren@gmail.com>

Both git commit --amend and a partial commit (git commit <paths>) are
foot-guns while the user is in the middle of an operation that resolves
conflicts on top of HEAD: recording a conflict resolution is about capturing
the state of the whole tree as a new commit, not about rewriting HEAD or
committing a subset of paths.

Historically we only rejected these during a merge or a cherry-pick or when
resolving an empty pick during a rebase. The same hazard exists for am,
revert, and rebase conflict stops, none of which were covered. This series
extends the refusal to all of them.

The three patches:

 1. reword the two pre-existing "empty commit" rebase messages, which were
    misleadingly generic
 2. refuse git commit --amend during these additional operations
 3. refuse partial commits during the same operations.

Elijah Newren (3):
  commit: reword the empty-commit rebase errors
  commit: refuse to amend during conflict resolution
  commit: refuse partial commits during conflict resolution

 builtin/commit.c                |  51 +++++++++----
 sequencer.c                     |  65 +++++++++++++++++
 sequencer.h                     |  24 ++++++
 t/t3404-rebase-interactive.sh   | 125 +++++++++++++++++++++++++++++++-
 t/t3507-cherry-pick-conflict.sh |  22 ++++++
 t/t4151-am-abort.sh             |  22 ++++++
 6 files changed, 293 insertions(+), 16 deletions(-)


base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2389%2Fnewren%2Frefuse-amend-during-conflicts-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2389/newren/refuse-amend-during-conflicts-v2
Pull-Request: https://github.com/git/git/pull/2389

Range-diff vs v1:

 -:  ---------- > 1:  65c48ed3cb commit: reword the empty-commit rebase errors
 1:  a3d6b059c6 ! 2:  4a1461e527 commit: refuse to amend during conflict resolution
     @@ Commit message
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/commit.c ##
     -@@
     - #include "path.h"
     - #include "preload-index.h"
     - #include "read-cache.h"
     -+#include "refs.h"
     - #include "repository.h"
     - #include "string-list.h"
     - #include "rerere.h"
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
     - 		else if (whence == FROM_REBASE_PICK)
     - 			die(_("You are in the middle of a rebase -- cannot amend."));
     + 		use_editor = 0;
     + 
     + 	/* Sanity check options */
     +-	if (amend && !current_head)
     +-		die(_("You have nothing to amend."));
     +-	if (amend && whence != FROM_COMMIT) {
     +-		if (whence == FROM_MERGE)
     ++	if (amend) {
     ++		if (!current_head)
     ++			die(_("You have nothing to amend."));
     ++		/*
     ++		 * Refuse to amend in the middle of any operation that is
     ++		 * meant to record its result as a new commit on top of HEAD
     ++		 * rather than by rewriting HEAD.
     ++		 */
     ++		switch (sequencer_ongoing_operation(s->repo, whence)) {
     ++		case ONGOING_NONE:
     ++			break;
     ++		case ONGOING_MERGE:
     + 			die(_("You are in the middle of a merge -- cannot amend."));
     +-		else if (is_from_cherry_pick(whence))
     ++		case ONGOING_CHERRY_PICK:
     + 			die(_("You are in the middle of a cherry-pick -- cannot amend."));
     +-		else if (whence == FROM_REBASE_PICK)
     ++		case ONGOING_REBASE_EMPTY:
     + 			die(_("You are resolving a commit that became empty -- cannot amend."));
     ++		case ONGOING_REVERT:
     ++			die(_("You are in the middle of a revert -- cannot amend."));
     ++		case ONGOING_AM:
     ++			die(_("You are in the middle of an am session -- cannot amend."));
     ++		case ONGOING_REBASE_CONFLICT:
     ++			die(_("You are resolving conflicts during a rebase -- cannot amend."));
     ++		}
       	}
     -+	if (amend && whence == FROM_COMMIT) {
     -+		char *applying, *apply_dir, *stopped_sha, *amend_marker;
     -+		int in_am, conflicted_stop;
     + 	if (fixup_message && squash_message)
     + 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
     +
     + ## sequencer.c ##
     +@@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
     + 	return 0;
     + }
     + 
     ++enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
     ++						   enum commit_whence whence)
     ++{
     ++	char *path;
     ++	int found;
      +
     -+		/* Check middle of revert */
     -+		if (refs_ref_exists(get_main_ref_store(the_repository),
     -+				    "REVERT_HEAD"))
     -+			die(_("You are in the middle of a revert -- cannot amend."));
     ++	/*
     ++	 * The merge, cherry-pick, and (empty) rebase-pick stops are already
     ++	 * distinguished by 'whence'.
     ++	 */
     ++	switch (whence) {
     ++	case FROM_MERGE:
     ++		return ONGOING_MERGE;
     ++	case FROM_CHERRY_PICK_SINGLE:
     ++	case FROM_CHERRY_PICK_MULTI:
     ++		return ONGOING_CHERRY_PICK;
     ++	case FROM_REBASE_PICK:
     ++		return ONGOING_REBASE_EMPTY;
     ++	case FROM_COMMIT:
     ++		break;
     ++	}
      +
     -+		/* Check middle of `am` */
     -+		applying = repo_git_path(the_repository,
     -+					 "rebase-apply/applying");
     -+		in_am = file_exists(applying);
     ++	/*
     ++	 * 'whence' is FROM_COMMIT, but we may still be in the middle of an
     ++	 * operation that records its result on top of HEAD; detect those
     ++	 * from their on-disk state.
     ++	 */
      +
     -+		free(applying);
     -+		if (in_am)
     -+			die(_("You are in the middle of an am session -- cannot amend."));
     ++	/* In the middle of a revert? */
     ++	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD"))
     ++		return ONGOING_REVERT;
      +
     -+		/* Check middle of rebase specifically stopped for conflicts */
     -+		apply_dir = repo_git_path(the_repository,
     -+					  "rebase-apply");
     -+		stopped_sha = repo_git_path(the_repository,
     -+					    "rebase-merge/stopped-sha");
     -+		amend_marker = repo_git_path(the_repository,
     -+					     "rebase-merge/amend");
     -+		/*
     -+		 * The apply backend only ever stops for conflicts; the
     -+		 * merge backend writes stopped-sha but omits `amend`,
     -+		 * which it writes only at a clean edit/reword stop.
     -+		 */
     -+		conflicted_stop =
     -+			file_exists(apply_dir) ||
     -+			(file_exists(stopped_sha) && !file_exists(amend_marker));
     ++	/* In the middle of an `am`? */
     ++	path = repo_git_path(r, "rebase-apply/applying");
     ++	found = file_exists(path);
     ++	free(path);
     ++	if (found)
     ++		return ONGOING_AM;
     ++
     ++	/*
     ++	 * In the middle of a rebase that stopped for conflict resolution?
     ++	 * The apply backend only ever stops for conflicts, so the presence
     ++	 * of its state directory is enough.  The merge backend writes
     ++	 * stopped-sha whenever it hands control back to the user, but omits
     ++	 * `amend` unless it stopped with HEAD already pointing at the commit
     ++	 * to be amended (a clean edit/reword stop); its absence therefore
     ++	 * marks a conflicted stop.
     ++	 */
     ++	path = repo_git_path(r, "rebase-apply");
     ++	found = file_exists(path);
     ++	free(path);
     ++	if (!found) {
     ++		char *stopped_sha = repo_git_path(r, "rebase-merge/stopped-sha");
     ++		char *amend_marker = repo_git_path(r, "rebase-merge/amend");
      +
     -+		free(apply_dir);
     ++		found = file_exists(stopped_sha) && !file_exists(amend_marker);
      +		free(stopped_sha);
      +		free(amend_marker);
     -+		if (conflicted_stop)
     -+			die(_("You are resolving conflicts during a rebase -- cannot amend."));
      +	}
     - 	if (fixup_message && squash_message)
     - 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
     - 	die_for_incompatible_opt4(!!use_message, "-C",
     ++	if (found)
     ++		return ONGOING_REBASE_CONFLICT;
     ++
     ++	return ONGOING_NONE;
     ++}
     ++
     + int sequencer_get_update_refs_state(const char *wt_dir,
     + 				    struct string_list *refs)
     + {
     +
     + ## sequencer.h ##
     +@@ sequencer.h: int sequencer_get_last_command(struct repository* r,
     + 			       enum replay_action *action);
     + int sequencer_determine_whence(struct repository *r, enum commit_whence *whence);
     + 
     ++/*
     ++ * An in-progress operation that records its result (often a conflict
     ++ * resolution) as a new commit on top of HEAD, during which amending
     ++ * HEAD via "git commit --amend" is almost always a mistake.
     ++ */
     ++enum ongoing_operation {
     ++	ONGOING_NONE = 0,
     ++	ONGOING_MERGE,
     ++	ONGOING_CHERRY_PICK,
     ++	ONGOING_REBASE_EMPTY,
     ++	ONGOING_REVERT,
     ++	ONGOING_AM,
     ++	ONGOING_REBASE_CONFLICT
     ++};
     ++
     ++/*
     ++ * Return which in-progress operation, if any, is underway; see enum
     ++ * ongoing_operation.  'whence' is the origin already computed for the
     ++ * pending commit.
     ++ */
     ++enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
     ++						   enum commit_whence whence);
     ++
     + /**
     +  * Append the set of ref-OID pairs that are currently stored for the 'git
     +  * rebase --update-refs' feature if such a rebase is currently happening.
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'correct error message for commit --amend after empty pick'
     - 	test_grep "middle of a rebase -- cannot amend." err
     + 	test_grep "resolving a commit that became empty -- cannot amend." err
       '
       
      +test_expect_success 'commit --amend is refused at a rebase conflict stop' '
 -:  ---------- > 3:  e0be8cdf63 commit: refuse partial commits during conflict resolution

-- 
gitgitgadget
