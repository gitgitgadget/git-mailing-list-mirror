Received: from mail-dl2-f33.google.com (mail-dl2-f33.google.com [74.125.229.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8D2E8B64
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939497; cv=none; b=KXpk0oR5o1/A6JVaxChfYZqflV+6KtwEps3MeBnJA3Db9+986fLoI3YiE+jB9nOLpqtjqP6vdkx+l1wu6a7bUsYxalgc9WYla/C/D+cWGb+Zljcswomp57JDZMBWbzibUA5U6HxqnujBKl6Sx2Bim5tfOx0GWHRwN3cxa0/CcBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939497; c=relaxed/simple;
	bh=q+9zsiVWvUXomNC8E3tyhlpw/10KuoNUT8T4CCOfyuk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Om8dCtvhLjMQvnwS4n90Pq6prnCEo6WFw12cETRwFd+1wdknDmkAD/TrmJHjVmvlnuG6FO39n59ZbUkKKjoHZYD5X7mrZmlsgggbkREfFTtoChZxO9kbxUs4jQXRdrKSAkmDX3XnxEe8BUKNhDf6Xf22U0UsRTEQFIlihoVUeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9OxfTIn; arc=none smtp.client-ip=74.125.229.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9OxfTIn"
Received: by mail-dl2-f33.google.com with SMTP id a92af1059eb24-1438e88300cso7963352c88.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 04:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790939494; x=1791544294; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MUTbqDvVqIHErV7djhfbDcz7xAt8oY+yljbzoaD7QAE=;
        b=S9OxfTInWOhSeZp74NcZy/lhAKoLL4z9JRqkZPF42cQ+e+kVBpBzT2o9bt4BuMnzjW
         VLPMfPQECNhFVdb9uex+ALyxSWtH5lya546kFfRtTSowra+B/iPhrhddMq4Ztki4QHYa
         uMQhe2IMcxzgeo9tD99oGkDlX54fMthot2AVQDpoaSTt5OR00k47w0L74/emlZOdjn3E
         PrtttOZuTIAxobPK1wJXknTwd+PAQS6oMdgAf9UEzPMMQvTAFwJ++XfWrCYH21C2arTh
         GXammE3SQM1gpw/JPesWumZbgL2uL9zNnNn7Hy9eZsP4V16bzPc3kH6AEwU1UIRNbh6Q
         JAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790939494; x=1791544294;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MUTbqDvVqIHErV7djhfbDcz7xAt8oY+yljbzoaD7QAE=;
        b=tUn0QFM4dNN0v1GDQ2k8oqIMHJN3h0BOztfKdwdHT3xUw5GiL6r8LXuAkfUYB/YDlY
         uQUEOyk57qfoZFZKKS+8UkNqgpQKgxu6E5SyHZcGNSlBhhnuyGWokz1PNdc/1J7fkCud
         QyidnYlKCYLjfLrpEWumLZyH9R5ST8sZWtUq/Fy4q2JRY4PHTO6SamwFdAn2VaxMr3WU
         Ro/WnRyL98dUELRMBwdvfJy9y24o4UT9im2cOztg/bsyjLulnB8PRO6k4Rq5QbOEOZdp
         caxeXTVD0OGCJYbsUr4vOK09BkjfBTW8+M1wvf9MiHXbZ4QQxNb13WVhR2Oz4+uAYGeS
         UGbQ==
X-Gm-Message-State: AFuF++lZB2+3M7bk8DjRcgLmrQNYXqbZW7wNTwr5ziHeATzxR6kj4Sce
	vI7S5qdN5cOKGnH0mnl1Xm0z5LqWQ5L1RLm48g4+CyRjzVPPc5bfalMNjeDvhg==
X-Gm-Gg: AYBFou2NRUcMkOmAfcEYnYOn5WWNHilpSwfN+6hgKH+bvL7H69ETgKikeiV1Dj/ECi/
	7w41bfhIKccz6NA+QSjNjIGETU3HQXEB7MaTdg1dt/EYTqigkqMh+zFZM1WeZ41ix9ET+s1S1rP
	1QCMGV1xIOeYqhrHcKcW+gPk3olZctG8jK1urFewR0Kul9moMJxgVQm+D4tJ4NNNd6DIpq8BXSi
	tjnuncgrOo3pliN4cHvWzeuOVgcb3XcWo98xW9aGHtDIDWdzblTrBAC/o0oOgjNLEjD8r784/aZ
	k54BWoUgcF6X80vbeL0OYj9kvGE58Ptw3I/W6C7mchwpQb9Q7XgPtHrQIWLHymRmu2kzjWifVki
	LAy4EHE0Xzza8j3b4UqcStSJ/pF0mlWdLjSyCwwY03oHeq1wgJHxJRcy7DMI3e/HzDjXn/Sni1j
	F4YstzyKYMIIXY4ffhRgKu+kQX6dyTl7lqnSCqJXyMovTDx/fIa9We5g0TxCzOGAudeM/c7xs=
X-Received: by 2002:a05:701b:465d:b0:141:5281:8a41 with SMTP id a92af1059eb24-14f5b121b5fmr2077444c88.9.1790939494135;
        Fri, 02 Oct 2026 04:11:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.59.3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14f46ab87bcsm5862366c88.9.2026.10.02.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 04:11:33 -0700 (PDT)
Message-Id: <pull.2214.v6.git.1790939492.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 02 Oct 2026 11:11:29 +0000
Subject: [PATCH v6 0/3] rerere: wait for MERGE_RR.lock, and go on at a conflict
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Junio C Hamano <gitster@pobox.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Thomas Bachem <mail@thomasbachem.com>

A rebase dies at a conflict when a background "git rerere gc" holds
MERGE_RR.lock at that moment. With the first patch, rerere waits for the
lock instead of dying at once. With the second, the "git rerere gc" started
by auto maintenance does nothing while the lock is held. With the third, a
command that stops at a conflict goes on without rerere if the lock is still
held after the wait.

For v6 I took Patrick's suggestions for the second patch. Changes since v5:

 * Patch 2's option is "--skip-locked" instead of "--auto", since there is
   no heuristic behind it (Patrick).

 * The option is hidden and undocumented, like the "--skip-foreground-tasks"
   that maintenance passes to "git gc", and I no longer touch git-rerere(1)
   (Patrick). I kept the last sentence of the rerere.lockTimeout entry and
   named "git maintenance run --auto" and "git gc --auto" in it instead of
   the option.

 * I renamed patch 3's flag from RERERE_SKIP_LOCKED to RERERE_WARN_LOCKED,
   so that it does not look like the flag of "--skip-locked", which is still
   RERERE_NOWAIT.

 * I added a test to patch 3 for the merge that "git rebase -r" re-creates,
   the only call site without one.

 * I corrected and reworded the log messages of patches 2 and 3. Both
   implied that every rerere command takes the lock, but status, diff and
   remaining do not. Patch 2's also said that nobody waits for the gc of
   auto maintenance, but where maintenance does not detach, the command that
   starts it does. From patch 3's I dropped my explanation of why "git
   commit" and "git am --continue" still fail, which does not hold for "git
   commit": it has made its commit by the time it runs rerere. The message
   now gives the plain reason, that the rebase or am can still be continued
   when they fail.

I kept the option rather than have maintenance call rerere_gc() directly.
rerere_gc() dies when it cannot take the lock, so a manual or scheduled "git
maintenance run" would die where it now reports the failed task (Patrick
agreed).

Thomas Bachem (3):
  rerere: wait for MERGE_RR.lock before giving up
  rerere: add "gc --skip-locked" for auto maintenance
  rerere: go on at a conflict when the lock stays busy

 Documentation/config/rerere.adoc |  14 +++
 apply.c                          |   2 +-
 builtin/am.c                     |   3 +-
 builtin/gc.c                     |   4 +-
 builtin/merge.c                  |   2 +-
 builtin/rerere.c                 |  10 +-
 builtin/stash.c                  |   2 +-
 rerere.c                         |  56 +++++++--
 rerere.h                         |   6 +-
 sequencer.c                      |   4 +-
 t/t4200-rerere.sh                | 190 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           |  25 +++-
 12 files changed, 300 insertions(+), 18 deletions(-)


base-commit: 34f06850c16c7f7ac822b1adc71354f11b0f2ca3
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v6
Pull-Request: https://github.com/gitgitgadget/git/pull/2214

Range-diff vs v5:

 1:  3dc3d02f12 = 1:  3dc3d02f12 rerere: wait for MERGE_RR.lock before giving up
 2:  27673137aa ! 2:  2ef141410a rerere: add "gc --auto" that skips a held lock
     @@ Metadata
      Author: Thomas Bachem <mail@thomasbachem.com>
      
       ## Commit message ##
     -    rerere: add "gc --auto" that skips a held lock
     +    rerere: add "gc --skip-locked" for auto maintenance
      
     -    The previous commit made "git rerere gc" wait for MERGE_RR.lock like
     -    every other rerere command before it fails, as it always has. That
     -    suits a user who runs it by hand and wants to know when nothing was
     -    pruned. It does not suit the gc that auto maintenance starts after
     -    a commit: nobody is waiting for that run, and the next commit starts
     -    another one.
     +    Since the previous commit, "git rerere gc" waits for MERGE_RR.lock
     +    like every other command that takes it, and fails only if the wait
     +    times out. That suits a user who runs it by hand and wants to know
     +    when nothing was pruned. But the user did not ask for the gc that auto
     +    maintenance starts after a commit, and the next commit starts another
     +    one.
      
     -    So add "--auto", with which "git rerere gc" quietly does nothing when
     -    the lock is taken, and pass it from "git maintenance run --auto" and
     -    "git gc --auto", as they already do for "git pack-refs --auto". A run
     -    without it, from the command line or a maintenance schedule, keeps
     -    waiting and failing.
     +    So add "--skip-locked", with which "git rerere gc" quietly does
     +    nothing while the lock is held, and pass it from
     +    "git maintenance run --auto" and "git gc --auto". Only these two need
     +    the option, so hide it and leave it undocumented, like the
     +    "--skip-foreground-tasks" that "git maintenance run" passes to
     +    "git gc". A run without it, from the command line or a maintenance
     +    schedule, still waits for the lock and fails if the wait times out.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ Documentation/config/rerere.adoc: rerere.lockTimeout::
       	to wait indefinitely.  Default is 1000 (i.e., wait for 1
       	second).  When the time is up, the command fails as it does
      -	for any other lock it cannot take.
     -+	for any other lock it cannot take.  `git rerere gc --auto`
     -+	does not wait and does nothing while the lock is held.
     -
     - ## Documentation/git-rerere.adoc ##
     -@@ Documentation/git-rerere.adoc: git-rerere - Reuse recorded resolution of conflicted merges
     - SYNOPSIS
     - --------
     - [verse]
     --'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc]
     -+'git rerere' [clear | forget <pathspec>... | diff | status | remaining | gc [--auto]]
     - 
     - DESCRIPTION
     - -----------
     -@@ Documentation/git-rerere.adoc: Print paths with conflicts that have not been autoresolved by rerere.
     - This includes paths whose resolutions cannot be tracked by rerere,
     - such as conflicting submodules.
     - 
     --'gc'::
     -+'gc' [--auto]::
     - 
     - Prune records of conflicted merges that
     - occurred a long time ago.  By default, unresolved conflicts older
     - than 15 days and resolved conflicts older than 60
     - days are pruned.  These defaults are controlled via the
     - `gc.rerereUnresolved` and `gc.rerereResolved` configuration
     --variables respectively.
     -+variables respectively.  With `--auto`, which `git maintenance run
     -+--auto` and `git gc --auto` pass, `gc` does nothing while another
     -+process holds the rerere lock.  Without it, `gc` waits for the lock
     -+as long as `rerere.lockTimeout` allows and then fails.
     - 
     - 
     - DISCUSSION
     ++	for any other lock it cannot take.  A `git rerere gc` run by
     ++	`git maintenance run --auto` or `git gc --auto` does not wait
     ++	and does nothing while the lock is held.
      
       ## builtin/gc.c ##
      @@ builtin/gc.c: out:
     @@ builtin/gc.c: out:
       	rerere_cmd.git_cmd = 1;
       	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
      +	if (opts->auto_flag)
     -+		strvec_push(&rerere_cmd.args, "--auto");
     ++		strvec_push(&rerere_cmd.args, "--skip-locked");
       	return run_command(&rerere_cmd);
       }
       
      
       ## builtin/rerere.c ##
     -@@
     - #include "pathspec.h"
     - 
     - static const char * const rerere_usage[] = {
     --	N_("git rerere [clear | forget <pathspec>... | diff | status | remaining | gc]"),
     -+	N_("git rerere [clear | forget <pathspec>... | diff | status | "
     -+	   "remaining | gc [--auto]]"),
     - 	NULL,
     - };
     - 
      @@ builtin/rerere.c: int cmd_rerere(int argc,
       	       struct repository *repo UNUSED)
       {
       	struct string_list merge_rr = STRING_LIST_INIT_DUP;
      -	int autoupdate = -1, flags = 0;
     -+	int autoupdate = -1, auto_flag = 0, flags = 0;
     ++	int autoupdate = -1, skip_locked = 0, flags = 0;
       
       	struct option options[] = {
       		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
       			N_("register clean resolutions in index"), 1),
     -+		OPT_BOOL(0, "auto", &auto_flag,
     -+			 N_("skip gc while another process holds the lock")),
     ++		OPT_HIDDEN_BOOL(0, "skip-locked", &skip_locked,
     ++			N_("skip gc while another process holds the lock")),
       		OPT_END(),
       	};
       
       	argc = parse_options(argc, argv, prefix, options, rerere_usage, 0);
       
     -+	if (auto_flag && (argc < 1 || strcmp(argv[0], "gc")))
     -+		die(_("the option '%s' requires '%s'"), "--auto", "gc");
     ++	if (skip_locked && (argc < 1 || strcmp(argv[0], "gc")))
     ++		die(_("the option '%s' requires '%s'"), "--skip-locked", "gc");
      +
       	repo_config(the_repository, git_xmerge_config, NULL);
       
     @@ builtin/rerere.c: int cmd_rerere(int argc,
       	} else if (!strcmp(argv[0], "gc"))
      -		rerere_gc(the_repository, &merge_rr);
      +		rerere_gc(the_repository, &merge_rr,
     -+			  auto_flag ? RERERE_NOWAIT : 0);
     ++			  skip_locked ? RERERE_NOWAIT : 0);
       	else if (!strcmp(argv[0], "status")) {
       		if (setup_rerere(the_repository, &merge_rr,
       				 flags | RERERE_READONLY) < 0)
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
       	test_path_is_missing $rr2/preimage
       '
       
     -+test_expect_success 'gc --auto does nothing while MERGE_RR is locked' '
     ++test_expect_success 'gc --skip-locked does nothing while MERGE_RR is locked' '
      +	mkdir -p $rr2 &&
      +	echo Hello >$rr2/preimage &&
      +	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
      +
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
     -+	git rerere gc --auto 2>err &&
     ++	git rerere gc --skip-locked 2>err &&
      +	test_must_be_empty err &&
      +	test_path_is_file $rr2/preimage &&
      +
      +	rm .git/MERGE_RR.lock &&
     -+	git rerere gc --auto &&
     ++	git rerere gc --skip-locked &&
      +	test_path_is_missing $rr2/preimage
      +'
      +
     -+test_expect_success '--auto is only accepted by gc' '
     -+	test_must_fail git rerere --auto clear 2>err &&
     -+	test_grep "option .--auto. requires .gc." err
     ++test_expect_success '--skip-locked is only accepted by gc' '
     ++	test_must_fail git rerere --skip-locked clear 2>err &&
     ++	test_grep "option .--skip-locked. requires .gc." err
      +'
      +
       test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
     @@ t/t7900-maintenance.sh: test_expect_rerere_gc () {
       		shift
       	fi
       
     -+	# an automatic run passes --auto on to "git rerere gc"
     -+	auto=
     ++	# An automatic run passes --skip-locked to "git rerere gc".
     ++	skip_locked=
      +	case " $* " in
      +	*" --auto "*)
     -+		auto=--auto
     ++		skip_locked=--skip-locked
      +		;;
      +	esac
      +
       	rm -f "rerere-gc.txt" &&
       	GIT_TRACE2_EVENT="$(pwd)/rerere-gc.txt" "$@" &&
      -	test_subcommand $negate git rerere gc <rerere-gc.txt
     -+	test_subcommand $negate git rerere gc $auto <rerere-gc.txt
     ++	test_subcommand $negate git rerere gc $skip_locked <rerere-gc.txt
       }
       
       test_expect_success 'rerere-gc task without --auto always collects garbage' '
 3:  3984c7666b ! 3:  cd018289bb rerere: go on at a conflict when the lock stays busy
     @@ Commit message
          When a merge, rebase, cherry-pick, revert, am, stash or apply stops
          at a conflict, it runs rerere right before it returns to the user.
          If MERGE_RR.lock is still held when rerere.lockTimeout runs out, the
     -    command dies there. A rebase loses more than a recording that way.
     -    The sequencer has not yet written the state that "git rebase
     -    --continue" needs, so the rebase cannot go on, and the "git commit
     -    --amend" it suggests instead folds the conflicted pick into the
     -    previous commit.
     +    command dies there. In a rebase, the sequencer has not yet written the
     +    state that "git rebase --continue" needs. A later
     +    "git rebase --continue" fails, and the "git commit --amend" that its
     +    message offers first folds the conflicted pick into the previous
     +    commit.
      
     -    So warn and go on. The conflict is still in place, and the warning
     -    tells the user to run "git rerere" before resolving it, which records
     -    the preimage or replays a known resolution as the command would have.
     -    The hint is under advice.mergeConflict like the other hints printed
     -    at a conflict stop.
     +    So warn and go on without rerere. The conflict is still in place, and
     +    a hint tells the user to run "git rerere" before resolving it. That
     +    records the preimage or replays a known resolution, as the command
     +    would have. The hint is under advice.mergeConflict like other hints
     +    printed at a conflict stop.
      
     -    Callers that run rerere after a resolution, like "git commit" and
     -    "git am --continue", still fail when the wait is up. They move on
     -    right away, and a leftover MERGE_RR entry would make the next rerere
     -    run record whatever the file holds by then. The user's own rerere
     -    commands and the "rerere clear" of --skip and --abort fail as well.
     +    Everything else that waits for the lock is left as it is and still
     +    fails if the wait times out. That includes "git commit" and
     +    "git am --continue", which run rerere after a resolution. When they
     +    fail, the rebase or am can still be continued.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ Documentation/config/rerere.adoc: rerere.lockTimeout::
       	`git rerere gc`.  Value 0 means not to wait at all; -1 means
       	to wait indefinitely.  Default is 1000 (i.e., wait for 1
      -	second).  When the time is up, the command fails as it does
     --	for any other lock it cannot take.  `git rerere gc --auto`
     --	does not wait and does nothing while the lock is held.
     +-	for any other lock it cannot take.  A `git rerere gc` run by
     +-	`git maintenance run --auto` or `git gc --auto` does not wait
     +-	and does nothing while the lock is held.
      +	second).  When the time is up, a command that stops at a
      +	conflict, such as `git merge` or `git rebase`, prints a
      +	warning and goes on without rerere; run `git rerere` before
      +	resolving the conflict to record it after all.  Any other
      +	command fails, as it does for any other lock it cannot take.
     -+	`git rerere gc --auto` does not wait and does nothing while
     -+	the lock is held.
     ++	A `git rerere gc` run by `git maintenance run --auto` or
     ++	`git gc --auto` does not wait and does nothing while the lock
     ++	is held.
      
       ## apply.c ##
      @@ apply.c: static int write_out_results(struct apply_state *state, struct patch *list)
     @@ apply.c: static int write_out_results(struct apply_state *state, struct patch *l
       		 */
       		if (!state->cached)
      -			repo_rerere(state->repo, 0);
     -+			repo_rerere(state->repo, RERERE_SKIP_LOCKED);
     ++			repo_rerere(state->repo, RERERE_WARN_LOCKED);
       	}
       
       	return errs;
     @@ builtin/am.c: static int fall_back_threeway(const struct am_state *state, const
       	if (merge_ort_generic(&o, &our_tree, &their_tree, 1, bases, &result)) {
      -		repo_rerere(the_repository, state->allow_rerere_autoupdate);
      +		repo_rerere(the_repository, state->allow_rerere_autoupdate |
     -+			    RERERE_SKIP_LOCKED);
     ++			    RERERE_WARN_LOCKED);
       		free(their_tree_name);
       		return error(_("Failed to merge in the changes."));
       	}
     @@ builtin/merge.c: static int suggest_conflicts(void)
       	strbuf_release(&msgbuf);
       	fclose(fp);
      -	repo_rerere(the_repository, allow_rerere_auto);
     -+	repo_rerere(the_repository, allow_rerere_auto | RERERE_SKIP_LOCKED);
     ++	repo_rerere(the_repository, allow_rerere_auto | RERERE_WARN_LOCKED);
       	printf(_("Automatic merge failed; "
       			"fix conflicts and then commit the result.\n"));
       	return 1;
     @@ builtin/stash.c: static enum stash_apply_result do_apply_stash(const char *prefi
       
       	if (ret) {
      -		repo_rerere(the_repository, 0);
     -+		repo_rerere(the_repository, RERERE_SKIP_LOCKED);
     ++		repo_rerere(the_repository, RERERE_WARN_LOCKED);
       
       		if (index)
       			fprintf_ln(stderr, _("Index was not unstashed."));
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
      -	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
      -		BUG("RERERE_NOWAIT does not apply with RERERE_READONLY");
      +	if ((flags & RERERE_READONLY) &&
     -+	    (flags & (RERERE_NOWAIT | RERERE_SKIP_LOCKED)))
     ++	    (flags & (RERERE_NOWAIT | RERERE_WARN_LOCKED)))
      +		BUG("RERERE_READONLY takes no lock, so no lock flag applies");
       	if (flags & RERERE_READONLY) {
       		fd = 0;
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
       			lock_flags = 0;
       			timeout_ms = 0;
       		}
     -+		if (flags & RERERE_SKIP_LOCKED)
     ++		if (flags & RERERE_WARN_LOCKED)
      +			lock_flags = 0;
       		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
      -							    git_path_merge_rr(r),
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
      +							    path, lock_flags,
      +							    timeout_ms);
      +		if (fd < 0) {
     -+			if (flags & RERERE_SKIP_LOCKED) {
     ++			if (flags & RERERE_WARN_LOCKED) {
      +				warning_errno(_("skipping rerere, "
      +						"unable to create '%s.lock'"),
      +					      path);
     @@ rerere.h: struct repository;
       /* Take MERGE_RR.lock only if it is free, and return quietly otherwise */
       #define RERERE_NOWAIT       010
      +/* Warn and go on without rerere if MERGE_RR.lock cannot be taken in time */
     -+#define RERERE_SKIP_LOCKED  020
     ++#define RERERE_WARN_LOCKED  020
       
       /*
        * Marks paths that have been hand-resolved and added to the
     @@ sequencer.c: static enum pick_result do_pick_commit(struct repository *r,
       		      short_commit_name(r, commit), msg.subject);
       		print_advice(r, res == 1, opts);
      -		repo_rerere(r, opts->allow_rerere_auto);
     -+		repo_rerere(r, opts->allow_rerere_auto | RERERE_SKIP_LOCKED);
     ++		repo_rerere(r, opts->allow_rerere_auto | RERERE_WARN_LOCKED);
       		goto leave;
       	}
       
     @@ sequencer.c: static int do_merge(struct repository *r,
       	rollback_lock_file(&lock);
       	if (ret)
      -		repo_rerere(r, opts->allow_rerere_auto);
     -+		repo_rerere(r, opts->allow_rerere_auto | RERERE_SKIP_LOCKED);
     ++		repo_rerere(r, opts->allow_rerere_auto | RERERE_WARN_LOCKED);
       	else
       		/*
       		 * In case of problems, we now want to return a positive
     @@ t/t4200-rerere.sh: test_expect_success 'a held lock is waited out within rerere.
      +	test_path_is_missing $rr/preimage
      +'
      +
     ++test_expect_success 'rebase -r goes on without rerere once rerere.lockTimeout is up' '
     ++	git reset --hard &&
     ++	git checkout -b lock-held-merge second &&
     ++	test_when_finished "test_might_fail git rebase --abort &&
     ++		git checkout third && git branch -D lock-held-merge" &&
     ++	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     ++	>.git/MERGE_RR.lock &&
     ++	test_must_fail git -c rerere.lockTimeout=0 rebase -r --force-rebase main 2>err &&
     ++	test_grep "skipping rerere" err &&
     ++	test_cmp_rev REBASE_HEAD second &&
     ++	rm .git/MERGE_RR.lock &&
     ++	git rebase --abort &&
     ++	test_path_is_missing .git/rebase-merge
     ++'
     ++
      +test_expect_success 'commit fails on a lock it cannot take' '
      +	git reset --hard &&
      +	rm -rf $rr &&

-- 
gitgitgadget
