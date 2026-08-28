Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E53DEFF3
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903092; cv=none; b=DMXLPmT1ok0TN5wZYxHvm5omEgtqEQjOvfld+lHljDLLFq5acMpzGyKsBIs2wTOxjeFjnErj8aiQmYEO1IO14STwkBH0f9dTO5itb5ICuFUMZzjxfdAzfl4yeJINX7X8mOsLqI0cGfyQOhkI3tPMqURkThEz20yTO2j+RzXBF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903092; c=relaxed/simple;
	bh=xCIcB9ZIk02ckQ2g6Fx0ZgIlacSlaeJjB/8sJqYhiJc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ElrN5wk7NXfnxKkGkdt72rXfb+J5MmdtULh65ce7kUaP0Hh2NdKups2Y9jP9sawxElav7FTUYH9QoW/VeP4Df7qXgkNZ6qHpZDmu4KkHvclbAqdUJmHWlXZR1tadVdcQ0hnYHlh1S3FBDgqUqFsYZwkb1QG6xly86lBMbIKcVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HAZxtBeU; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HAZxtBeU"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4ab47c40e7eso665641b6e.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2026 00:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903089; x=1788507889; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HvLg3099S1BLCm3Rl/izUoj+Skh0ObCeIUCjlX/Wad8=;
        b=HAZxtBeUtQghlCyRUZdN/cj7gQZTLJLwdqxeLLw/Jr8nJGWFTTqnfF2QQGiejw1xQU
         ycO28XSI7niepNqIcSlFM8ZOB7kOCO4KP3IcgNEyyt5bnoRyzc4XLic5DJfg4h7KKF8z
         FTXBiXEMqqvfe9NW0SvlshGltw3Kk9JikizW72TosTpUjkmNGNLyCU0daPc7lpth76/H
         Cgrhlnkr62sXF6VRks3HR8/nQAeDMnV3LHmBHRhMnpup7KIMvMXG1gdz6FaAldumAaF6
         XpQG7wOj6W6yOO/ApsuuN6DqLFP+W1udnxCIod1tl5xtrnU01ZvstgpOtBn8RlhWM4t1
         XqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903089; x=1788507889;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvLg3099S1BLCm3Rl/izUoj+Skh0ObCeIUCjlX/Wad8=;
        b=mWClLnhybW6aKVcM0VfIjBWcsvBe2XCmWibsZVe27sJWX2htH5GDSjUDJ14kvI6ReY
         OSYQ6rYV+ElFrEoROwWtIQPxLluLCAyzmATcvtWqm+Pd3K0nXMZFGIBT7V4ZDUY+O0l/
         hbKGBQKqs/E1xlk9J7ILS2eSbKE/8Oxv7MX674xI94GcVj4JZz8ndIBFMHrQWoLf0ZU3
         BAk/F6/GXAuYDsq+ZpiUZpjvvhotI/i7MJKZhtIq5e4sodQ0nu1jSj5ANcgrN9R/zmq/
         Qzes5+o+VjsSW2WCYF7t+d6ldTiZBBUwKIiUrBxj+KXpq4hGMolRHqNDj0R17jQZFhgC
         5+QA==
X-Gm-Message-State: AFuF++mZSfiKwOwo1AuYT9GAmrSV6/U/UDQy+nXhl3Gfu9oxRUfHiJCD
	vQ60X5tyPOyJxXwczmWVm4NP4uuT6Lt100DyzSx7LV/Eh2HhUm4mBEbF+JIloeF8
X-Gm-Gg: AR+sD10U2hoQcGE2kHAw/z3uPQaJvFDe/0OTXAzP6bf1tuj7mp7RerwoMOB5ALRqPYA
	mIln93V/6kYGSHSuemKjc5ikEa4Dc0GEjbYZ3MHPt433Xg+Bq/Ax0FvnhRv0vyneIpoHd4L2ug/
	DzeDqPikSRAmbYr9116S//Ho/wclU6LTDWa7fRYpXJhI9C5HvQr8oMsFjwHh6mXX+i3l9QH1yXx
	Ff/mrzursgKYc5J5lCmgt8wX45VRST1eZXiZHjjPlsAwUNn1oQ9NFNAEzWke7bquC96o7hESjS7
	4Etpj6tn+Wx4Izm3HJlZRyUNMi6fqaZxz7BGww18ZbEQ2xoukZ0Z8DCM8dbin6IWSR9y3wKsCwa
	BCdI3qNa+S23s5bEoFRaxzL7ymf0Bvw+JdwUTVuitUSfyR7LWIxmXAuXkmwjgxER+YS1Yseag+a
	BgnJTzrk7PG5xiWy8nxIkvSbSyjt1ja2Ug7k7QAD/q1ZZSj+p17E3YotL6VM/1jRRi7eOIzX0kn
	g==
X-Received: by 2002:a05:6808:1b23:b0:496:b7c:274b with SMTP id 5614622812f47-4b39832dc4cmr4866567b6e.19.1787903089006;
        Fri, 28 Aug 2026 00:44:49 -0700 (PDT)
Received: from [127.0.0.1] ([172.202.78.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b3a12976a4sm692789b6e.0.2026.08.28.00.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:44:47 -0700 (PDT)
Message-Id: <pull.2389.v3.git.git.1787903085.gitgitgadget@gmail.com>
In-Reply-To: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
References: <pull.2389.git.git.1787721681893.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Aug 2026 07:44:40 +0000
Subject: [PATCH v3 0/5] commit: refuse to amend during conflict resolution
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

Changes since v2:

 * Two new preparatory patches:
   * Rename FROM_REBASE_PICK and is_from_rebase() to point out they are
     about empty commits
   * Allow a partial commit when a rebase pick becomes empty
 * Tweaked the error message for attempted amend on now-dropped empty commit
   (suggestions for further improvements welcome)
 * Used the path accessor functions within sequencer.c to simplify the new
   helper function

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

Elijah Newren (5):
  commit: clarify FROM_REBASE_PICK and is_from_rebase() names
  commit: allow a partial commit when a rebase pick becomes empty
  commit: reword the empty-commit rebase amend error
  commit: refuse to amend during conflict resolution
  commit: refuse partial commits during conflict resolution

 builtin/commit.c                |  65 +++++++++++-----
 sequencer.c                     |  59 ++++++++++++++-
 sequencer.h                     |  24 ++++++
 t/t3404-rebase-interactive.sh   | 128 +++++++++++++++++++++++++++++++-
 t/t3507-cherry-pick-conflict.sh |  22 ++++++
 t/t4151-am-abort.sh             |  22 ++++++
 wt-status.h                     |   6 +-
 7 files changed, 299 insertions(+), 27 deletions(-)


base-commit: 2c3adbb2c475981e340c79fdc5e7f4f9b5d9054e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2389%2Fnewren%2Frefuse-amend-during-conflicts-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2389/newren/refuse-amend-during-conflicts-v3
Pull-Request: https://github.com/git/git/pull/2389

Range-diff vs v2:

 -:  ---------- > 1:  7e198a20fa commit: clarify FROM_REBASE_PICK and is_from_rebase() names
 -:  ---------- > 2:  e169303619 commit: allow a partial commit when a rebase pick becomes empty
 1:  65c48ed3cb ! 3:  0850a999da commit: reword the empty-commit rebase errors
     @@ Metadata
      Author: Elijah Newren <newren@gmail.com>
      
       ## Commit message ##
     -    commit: reword the empty-commit rebase errors
     +    commit: reword the empty-commit rebase amend error
      
          When a rebase applies a commit that becomes empty, it stops and asks the
          user to decide whether to keep it or drop it.  HEAD still points at the
     -    previously-applied commit at that point, so either amending or creating
     -    a partial commit is refused, with one of the following messages:
     +    previously-applied commit at that point, so amending is refused, with:
      
              You are in the middle of a rebase -- cannot amend.
     -        cannot do a partial commit during a rebase.
      
     -    Neither message hints that the real problem is a commit that became
     -    empty, and "during a rebase" is overly broad besides -- amending and
     -    partial commits are fine at an `edit` or `break` stop.  Reword both to
     -    describe the actual situation.
     +    That message would suggest that amending is not allowed during an 'edit'
     +    or 'break' stop, which is misleading, plus it lacks the specificity that
     +    might help the user know why their particular case is a problem: the
     +    commit they intended to amend became empty and was dropped, so amending
     +    would affect the wrong commit.  Reword the error accordingly.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## builtin/commit.c ##
     -@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
     - 		else if (is_from_cherry_pick(whence))
     - 			die(_("cannot do a partial commit during a cherry-pick."));
     - 		else if (is_from_rebase(whence))
     --			die(_("cannot do a partial commit during a rebase."));
     -+			die(_("cannot do a partial commit while resolving a commit that became empty."));
     - 	}
     - 
     - 	if (list_paths(&partial, !current_head ? NULL : "HEAD", &pathspec))
      @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *argv[],
       		else if (is_from_cherry_pick(whence))
       			die(_("You are in the middle of a cherry-pick -- cannot amend."));
     - 		else if (whence == FROM_REBASE_PICK)
     + 		else if (is_from_rebase_empty(whence))
      -			die(_("You are in the middle of a rebase -- cannot amend."));
     -+			die(_("You are resolving a commit that became empty -- cannot amend."));
     ++			die(_("The now-empty commit has been dropped -- cannot amend."));
       	}
       	if (fixup_message && squash_message)
       		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
      
       ## t/t3404-rebase-interactive.sh ##
     -@@ t/t3404-rebase-interactive.sh: test_expect_success 'correct error message for partial commit after empty pick'
     - 	) &&
     - 	echo x >file1 &&
     - 	test_must_fail git commit file1 2>err &&
     --	test_grep "cannot do a partial commit during a rebase." err
     -+	test_grep "cannot do a partial commit while resolving a commit that became empty." err
     - '
     - 
     - test_expect_success 'correct error message for commit --amend after empty pick' '
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'correct error message for commit --amend after empty pick'
       	) &&
       	echo x>file1 &&
       	test_must_fail git commit -a --amend 2>err &&
      -	test_grep "middle of a rebase -- cannot amend." err
     -+	test_grep "resolving a commit that became empty -- cannot amend." err
     ++	test_grep "now-empty commit has been dropped -- cannot amend." err
       '
       
       test_expect_success 'todo has correct onto hash' '
 2:  4a1461e527 ! 4:  9f80d8a00d commit: refuse to amend during conflict resolution
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
      -		else if (is_from_cherry_pick(whence))
      +		case ONGOING_CHERRY_PICK:
       			die(_("You are in the middle of a cherry-pick -- cannot amend."));
     --		else if (whence == FROM_REBASE_PICK)
     +-		else if (is_from_rebase_empty(whence))
      +		case ONGOING_REBASE_EMPTY:
     - 			die(_("You are resolving a commit that became empty -- cannot amend."));
     + 			die(_("The now-empty commit has been dropped -- cannot amend."));
      +		case ONGOING_REVERT:
      +			die(_("You are in the middle of a revert -- cannot amend."));
      +		case ONGOING_AM:
     @@ builtin/commit.c: static int parse_and_validate_options(int argc, const char *ar
       		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
      
       ## sequencer.c ##
     +@@ sequencer.c: static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
     +  * command is processed, this file is deleted.
     +  */
     + static GIT_PATH_FUNC(rebase_path_amend, "rebase-merge/amend")
     ++/*
     ++ * The apply ("am") backend keeps its state in the rebase-apply directory;
     ++ * the "applying" file within it marks a plain `git am` (as opposed to an
     ++ * apply-based rebase).
     ++ */
     ++static GIT_PATH_FUNC(apply_dir, "rebase-apply")
     ++static GIT_PATH_FUNC(apply_path_applying, "rebase-apply/applying")
     + /*
     +  * When we stop at a given patch via the "edit" command, this file contains
     +  * the commit object name of the corresponding patch.
      @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_whence *whence)
       	return 0;
       }
     @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
      +enum ongoing_operation sequencer_ongoing_operation(struct repository *r,
      +						   enum commit_whence whence)
      +{
     -+	char *path;
     -+	int found;
     -+
      +	/*
      +	 * The merge, cherry-pick, and (empty) rebase-pick stops are already
      +	 * distinguished by 'whence'.
     @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
      +	case FROM_CHERRY_PICK_SINGLE:
      +	case FROM_CHERRY_PICK_MULTI:
      +		return ONGOING_CHERRY_PICK;
     -+	case FROM_REBASE_PICK:
     ++	case FROM_REBASE_EMPTY:
      +		return ONGOING_REBASE_EMPTY;
      +	case FROM_COMMIT:
      +		break;
     @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
      +		return ONGOING_REVERT;
      +
      +	/* In the middle of an `am`? */
     -+	path = repo_git_path(r, "rebase-apply/applying");
     -+	found = file_exists(path);
     -+	free(path);
     -+	if (found)
     ++	if (file_exists(apply_path_applying()))
      +		return ONGOING_AM;
      +
      +	/*
     @@ sequencer.c: int sequencer_determine_whence(struct repository *r, enum commit_wh
      +	 * to be amended (a clean edit/reword stop); its absence therefore
      +	 * marks a conflicted stop.
      +	 */
     -+	path = repo_git_path(r, "rebase-apply");
     -+	found = file_exists(path);
     -+	free(path);
     -+	if (!found) {
     -+		char *stopped_sha = repo_git_path(r, "rebase-merge/stopped-sha");
     -+		char *amend_marker = repo_git_path(r, "rebase-merge/amend");
     -+
     -+		found = file_exists(stopped_sha) && !file_exists(amend_marker);
     -+		free(stopped_sha);
     -+		free(amend_marker);
     -+	}
     -+	if (found)
     ++	if (file_exists(apply_dir()) ||
     ++	    (file_exists(rebase_path_stopped_sha()) &&
     ++	     !file_exists(rebase_path_amend())))
      +		return ONGOING_REBASE_CONFLICT;
      +
      +	return ONGOING_NONE;
     @@ sequencer.h: int sequencer_get_last_command(struct repository* r,
      
       ## t/t3404-rebase-interactive.sh ##
      @@ t/t3404-rebase-interactive.sh: test_expect_success 'correct error message for commit --amend after empty pick'
     - 	test_grep "resolving a commit that became empty -- cannot amend." err
     + 	test_grep "now-empty commit has been dropped -- cannot amend." err
       '
       
      +test_expect_success 'commit --amend is refused at a rebase conflict stop' '
 3:  e0be8cdf63 ! 5:  050b9e8a52 commit: refuse partial commits during conflict resolution
     @@ Commit message
          Similar to the previous commit, just as `git commit --amend` is a
          foot-gun during conflict resolution, so is a partial commit (`git commit
          <paths>`).  Recording a conflict resolution is about capturing the state
     -    of the entire tree on top of HEAD, not a subset of paths.  For many
     -    years we have rejected partial commits in the middle of
     +    of the entire tree on top of HEAD, not a subset of paths.  For many years
     +    we have rejected partial commits in the middle of
            - a merge
            - a cherry-pick
     -      - a rebase that stopped at a pick
      
     -    but, just like amending, this was never extended to the other
     -    operations that can also leave conflicts to resolve:
     +    but, just like amending, this was never extended to the other operations
     +    that can also leave conflicts to resolve:
            - an `am` operation
            - a revert
            - a rebase that stopped for conflict resolution
      
          Reuse sequencer_ongoing_operation(), introduced for the analogous
     -    `--amend` check, to detect all of these and refuse the partial commit.
     +    `--amend` check, to detect these and refuse the partial commit.  A rebase
     +    that stopped because a pick became empty is not conflict resolution and,
     +    as an earlier patch established, is deliberately left permitted.
      
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
      -			die(_("cannot do a partial commit during a merge."));
      -		else if (is_from_cherry_pick(whence))
      -			die(_("cannot do a partial commit during a cherry-pick."));
     --		else if (is_from_rebase(whence))
     --			die(_("cannot do a partial commit while resolving a commit that became empty."));
      +	switch (sequencer_ongoing_operation(the_repository, whence)) {
      +	case ONGOING_NONE:
      +		break;
     @@ builtin/commit.c: static const char *prepare_index(const char **argv, const char
      +	case ONGOING_CHERRY_PICK:
      +		die(_("cannot do a partial commit during a cherry-pick."));
      +	case ONGOING_REBASE_EMPTY:
     -+		die(_("cannot do a partial commit while resolving a commit that became empty."));
     ++		/*
     ++		 * A pick that became empty is not a conflict, and creating
     ++		 * a new commit (partial or not) poses no problem.
     ++		 */
     ++		break;
      +	case ONGOING_REVERT:
      +		die(_("cannot do a partial commit during a revert."));
      +	case ONGOING_AM:

-- 
gitgitgadget
