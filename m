Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B205D3E717A
	for <git@vger.kernel.org>; Mon, 14 Sep 2026 08:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789373066; cv=none; b=DR9j2Jw9AY50B6Svx3rIqFQ9wKSU6BfWVrw4R/I33dyYCyD/xbvtZKqFNnzNu4knSFB1rD/FNS7/B+SsFWKWzHjeNafVeIaf66JtSqMVFsBXhYTyEzSG5gKhYGdpwmJtYAYabK8uhsTdIO33Ezp79s8oaj4DSk+Cm36bNhEUUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789373066; c=relaxed/simple;
	bh=UcVc89EHVzLzo9aDj7o1be4auEgPvJObARwIrDuQu9s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NU9fMYErl44qEK8aExCeiV2gDD8qcMR5GdUMLqWuqkyv+JM1EERd4TdbUCpshahA7aQRGy7X9Iu4kMReWV3A4d2NWvo8JxAsHLMbwX3xSzKxr5XIAq8O9mi8KK59vr7sSg0PokXCgltX04LLkHtvAygMfkYUV44B6H8le79z3UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFhgVSYb; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFhgVSYb"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-90ceab90152so28949236d6.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2026 01:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789373062; x=1789977862; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oW++XO4ThUxWmcdRCLyZqNOw0Ctp0/nQV9ptqiudnhc=;
        b=NFhgVSYbpM0cwtC9XvNgcKJ41ZKH3CNKyw62orAXCMJvjZM/CRKq84tu49H9dHvN3G
         3RIKEq3ng5S2m84RiR6Y1hBOQIvJM26E8BGdQhgH7AZ1fu5Vv6tzhtt629JHpVqwkHNm
         n137VuIg5XmdvoYyNokXoKHYwmZe3uUzyZFV9napm09C4KhXaMG57ZorIUarEDl7zLel
         QNH4cBAdh7+ggE/C8KFWXOpH9pTy+f7eFX4QQ6wWiXYCvYxU2AwCGEHWdwh0IQNZCdKR
         rcgStWd57YqiDX6Wf6KCzo1PnyTlkDtdJaPd3igzb7WHusKyRwbQeWpGoPkUfSB3s/Ot
         vmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789373062; x=1789977862;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oW++XO4ThUxWmcdRCLyZqNOw0Ctp0/nQV9ptqiudnhc=;
        b=nNnqA79tv1yoGKX1zgVfMIe87oBNUSqnLLmbjNLcvUmDmgNySqMqY6HDVTinv5hNbV
         RpleY2sw4m7m5cjra0kXEJ/TeKx6nGhrJ/+IMTeYBD/v1YwUn8Vfk2QiuNhb4+taa8gj
         JQnY3VbLPQdbwBl96wiBdbvPhX3fp5JGPRPARzmeQet3OKS0zfoW1i3KOusSQ1TwTu4D
         S56Gjx2WrU+YHtM4hFBmEnpNeNfDk0O/UdlCzV821k+iav61nzZEtxbLPh32XBxkEXvV
         XLbz0ClIfPz6KM3iZIKLPUSxOoGWOD831UZ2eWi4Ib/5D0OLIzhckgyHVS+LiQjtwx+p
         R7qA==
X-Gm-Message-State: AFuF++mgjp9jChoaJrpNmC7TcSljv9BoslXu924OKjKgESGnEvo9rcIe
	WR1xESQv251hvtxkp/Av+m4Jux0p+/WOWLAOu3GjF5JikTNX2hLH6jWyxDX19g==
X-Gm-Gg: AYBFou0Khyt1kLzmhaY2g5bh7V5ULacVkR+nQiX9oEW4zMzFsLSKHSXo8rQffJXqwp2
	zCEL4+kp1S4j88W1gCAclRF8+4+zyzsPY5VYG5BzaXgC3ifizy2b+BkmC7bXffA6eDueIi3nzYP
	WQGwNzBXgkrouJxWau4M4suRjRXA2xJX1OXWY/QwpG76s8tY5WO7LVlqImofDmogcNbEgnlK9TR
	Kb62TlX/tXJv9nexOB8IeQUIsaXkPso6uujYmrTieucGoqGiB+4lFww58yB/wJEHppkBtLM5kL7
	/WBfs0ejAJmkFcUlwCHh1pSeQpTo2JdEpIJ7vM/RXmWnijCJ2kdvVYNfGq6+7d25w26r7oZVMeK
	Zr0gK2ByqSHXh+2yrufzRWvku2RpNeLlrTjjtGKCSZ3+PxOA5KgluAzMe0RjdyuXkapqxspZo8K
	lSsLx4LKiuIFq6oeqFrvrm9IALqSkKTpOmKgid27ijBZCEGjzncXUBYyb8rR6DSFgIIqU6Ct3sq
	IY=
X-Received: by 2002:a05:622a:38c:b0:530:f0c8:de23 with SMTP id d75a77b69052e-5310d026146mr18375881cf.29.1789373062448;
        Mon, 14 Sep 2026 01:04:22 -0700 (PDT)
Received: from [127.0.0.1] ([48.211.210.118])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530fb282506sm36641271cf.26.2026.09.14.01.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 01:04:21 -0700 (PDT)
Message-Id: <pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 14 Sep 2026 08:04:19 +0000
Subject: [PATCH v4 0/2] rerere: wait for MERGE_RR.lock, and go on at a conflict
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

This is now two patches, as Patrick asked: the wait first, the skip on top,
so that the second can be discussed on its own.

Patch 1 makes every writer wait rerere.lockTimeout for MERGE_RR.lock before
it fails as it does today, and lets "git rerere gc" skip its run instead of
waiting. That alone keeps a rebase alive through the gc that a commit's auto
maintenance starts: the gc gives way whenever it comes second, and the one
second default is longer than pruning a few thousand entries takes.

Patch 2 is what I proposed in my 6 September reply to Junio: a command that
stops at a conflict warns and goes on when the lock is still held after the
wait, and the warning tells the user to run "git rerere" before resolving.
Everything else keeps failing: the recordings after a resolution, the user's
own rerere commands, and the clears that am and rebase run.

Changes since v3:

 * Based on master instead of maint. On master setup_rerere() already uses
   the repository-scoped lock helpers, so the series merges cleanly into
   next and seen, including ps/tune-rerere-gc (which makes the gc rarer, not
   the race) and tb/rerere-lock-grace (which only stops the commands a
   rebase spawns from starting the gc).

 * The first log message says that the race is as old as the lock and that
   the 2.54 maintenance default only made it easy to hit (Patrick).

 * Only the six callers that stop at a conflict go on without rerere: the
   sequencer's pick and merge, "git merge", the 3-way fallback of "git am",
   "git stash" and "git apply --3way". "git commit" and "git am --continue"
   fail after the wait, as in 2.55 (Junio). Merge, rebase, am, stash and
   apply each have a test for this.

 * The config entry describes the outcome per command and no longer says
   "retry" (Junio).

 * The "rerere clear" that am and rebase run for --skip and --abort waits
   and then fails like every other caller, so a held lock cannot leave a
   stale MERGE_RR entry behind. The signatures of rerere_clear() and
   rerere_forget() are back to what upstream has.

 * A new test runs "git rerere" at the stop after a skipped recording and
   checks that the preimage, and after the resolution the postimage, get
   recorded.

Thomas Bachem (2):
  rerere: wait for MERGE_RR.lock, and let the gc skip it
  rerere: go on at a conflict when the lock stays busy

 Documentation/config/rerere.adoc |  13 +++
 Documentation/git-rerere.adoc    |   4 +-
 apply.c                          |   2 +-
 builtin/am.c                     |   3 +-
 builtin/merge.c                  |   2 +-
 builtin/stash.c                  |   2 +-
 rerere.c                         |  49 +++++++--
 rerere.h                         |   4 +
 sequencer.c                      |   4 +-
 t/t4200-rerere.sh                | 168 +++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           |   8 ++
 11 files changed, 246 insertions(+), 13 deletions(-)


base-commit: 47ce80527c56f462cb97db4ca8125342204d3783
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2214

Range-diff vs v3:

 1:  5bfda65baa ! 1:  8a7a74d6aa rerere: keep a background gc from killing a rebase
     @@ Metadata
      Author: Thomas Bachem <mail@thomasbachem.com>
      
       ## Commit message ##
     -    rerere: keep a background gc from killing a rebase
     +    rerere: wait for MERGE_RR.lock, and let the gc skip it
      
     -    A "git rerere gc" holds MERGE_RR.lock for as long as pruning rr-cache
     -    takes, and since 2.54 the auto maintenance after every commit runs
     -    one whenever rr-cache has an entry. The commit a rebase spawns for a
     -    resolved pick starts it too, and the sequencer's repo_rerere() at the
     -    next conflict wants the lock a few milliseconds later. Both take it
     -    with LOCK_DIE_ON_ERROR, so whichever comes second dies. When it is
     -    the rebase, the index is written but the state for "git rebase
     -    --continue" is not, and every later continue refuses with "you have
     -    staged changes".
     +    setup_rerere() takes MERGE_RR.lock with LOCK_DIE_ON_ERROR. When two
     +    processes want the lock at the same time, the second one dies. This
     +    was always the case, but since 452b12c2e0 (builtin/maintenance: use
     +    "geometric" strategy by default, 2026-02-24) it is easy to hit: auto
     +    maintenance now runs "git rerere gc" after every commit whenever
     +    rr-cache contains at least one entry, and the gc holds the lock
     +    while it prunes.
      
     -    The gc needs the lock, since a rerere that has just created its
     -    directory looks like the empty ones it prunes. So wait for it
     -    instead, rerere.lockTimeout milliseconds, 1000 by default with the
     -    semantics of core.packedRefsTimeout, then warn and go on without
     -    rerere: a lost recording or replay is nothing next to a rebase that
     -    cannot continue. The gc itself never waits, and "git rerere", "git
     -    rerere forget" and "git rerere clear" wait but then die, since the
     -    state behind the lock is all they are for. The clearing "am" and
     -    "rebase" do on --abort, --skip and --quit goes on without it, and
     -    leaves the entries for the gc.
     +    A rebase whose next pick conflicts while the gc holds the lock dies
     +    inside repo_rerere(). That runs before the sequencer writes the state
     +    that "git rebase --continue" needs, so every later "git rebase
     +    --continue" fails with "you have staged changes".
     +
     +    Instead of dying right away, wait for the lock for up to
     +    rerere.lockTimeout milliseconds, 1000 by default, and only then fail
     +    as before. The gc itself does not wait: when the lock is held, it
     +    skips this run and leaves the pruning to the next one.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ Documentation/config/rerere.adoc: rerere.enabled::
       	repository.
      +
      +rerere.lockTimeout::
     -+	The length of time, in milliseconds, to retry when trying to
     -+	take the rerere lock while another process holds it, typically
     -+	a background `git rerere gc`.  When the time is up, the command
     -+	warns and goes on without rerere.  Value 0 means not to retry
     -+	at all; -1 means to try indefinitely.  Default is 1000 (i.e.,
     -+	retry for 1 second).  `git rerere gc` does not retry at all.
     -+	`git rerere`, `git rerere forget` and `git rerere clear` retry
     -+	the same way, but fail when the time is up instead of going on.
     ++	The length of time, in milliseconds, to wait for the rerere
     ++	lock when another process holds it, typically a background
     ++	`git rerere gc`.  Value 0 means not to wait at all; -1 means
     ++	to wait indefinitely.  Default is 1000 (i.e., wait for 1
     ++	second).  When the time is up, the command fails as it does
     ++	for any other lock it cannot take.  `git rerere gc` never
     ++	waits and skips its run while the lock is held.
      
       ## Documentation/git-rerere.adoc ##
      @@ Documentation/git-rerere.adoc: occurred a long time ago.  By default, unresolved conflicts older
     @@ Documentation/git-rerere.adoc: occurred a long time ago.  By default, unresolved
       days are pruned.  These defaults are controlled via the
       `gc.rerereUnresolved` and `gc.rerereResolved` configuration
      -variables respectively.
     -+variables respectively.  If another process holds the lock on the
     -+recorded resolutions, for example a merge or rebase that is recording
     -+a conflict, `gc` does nothing and reports so.
     ++variables respectively.  If another process holds the rerere lock,
     ++for example a merge or rebase that is recording a conflict, `gc`
     ++does nothing and says so.
       
       
       DISCUSSION
      
     - ## builtin/am.c ##
     -@@ builtin/am.c: static int clean_index(const struct object_id *head, const struct object_id *rem
     - static void am_rerere_clear(void)
     - {
     - 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
     --	rerere_clear(the_repository, &merge_rr);
     -+	rerere_clear(the_repository, &merge_rr, 0);
     - 	string_list_clear(&merge_rr, 1);
     - }
     - 
     -
     - ## builtin/rebase.c ##
     -@@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts)
     - 	case ACTION_SKIP: {
     - 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
     - 
     --		rerere_clear(the_repository, &merge_rr);
     -+		rerere_clear(the_repository, &merge_rr, 0);
     - 	}
     - 		/* fallthrough */
     - 	case ACTION_CONTINUE: {
     -@@ builtin/rebase.c: int cmd_rebase(int argc,
     - 	case ACTION_SKIP: {
     - 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
     - 
     --		rerere_clear(the_repository, &merge_rr);
     -+		rerere_clear(the_repository, &merge_rr, 0);
     - 		string_list_clear(&merge_rr, 1);
     - 		ropts.flags = RESET_HEAD_HARD;
     - 		if (reset_head(the_repository, &ropts) < 0)
     -@@ builtin/rebase.c: int cmd_rebase(int argc,
     - 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
     - 		struct strbuf head_msg = STRBUF_INIT;
     - 
     --		rerere_clear(the_repository, &merge_rr);
     -+		rerere_clear(the_repository, &merge_rr, 0);
     - 		string_list_clear(&merge_rr, 1);
     - 
     - 		if (read_basic_state(&options))
     -
     - ## builtin/rerere.c ##
     -@@ builtin/rerere.c: int cmd_rerere(int argc,
     - 		flags = RERERE_NOAUTOUPDATE;
     - 
     - 	if (argc < 1)
     --		return repo_rerere(the_repository, flags);
     -+		return repo_rerere(the_repository, flags | RERERE_LOCK_OR_DIE);
     - 
     - 	if (!strcmp(argv[0], "forget")) {
     - 		struct pathspec pathspec;
     -@@ builtin/rerere.c: int cmd_rerere(int argc,
     - 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
     - 			       prefix, argv + 1);
     - 
     --		ret = rerere_forget(the_repository, &pathspec);
     -+		ret = rerere_forget(the_repository, &pathspec,
     -+				    RERERE_LOCK_OR_DIE);
     - 
     - 		clear_pathspec(&pathspec);
     - 		return ret;
     - 	}
     - 
     - 	if (!strcmp(argv[0], "clear")) {
     --		rerere_clear(the_repository, &merge_rr);
     -+		rerere_clear(the_repository, &merge_rr, RERERE_LOCK_OR_DIE);
     - 	} else if (!strcmp(argv[0], "gc"))
     - 		rerere_gc(the_repository, &merge_rr);
     - 	else if (!strcmp(argv[0], "status")) {
     -
       ## rerere.c ##
      @@ rerere.c: static int rerere_enabled = -1;
     - 
       /* automatically update cleanly resolved paths to the index */
       static int rerere_autoupdate;
     -+static int rerere_lock_timeout_ms = 1000;
       
     ++/* how long to wait for MERGE_RR.lock, in milliseconds */
     ++static int rerere_lock_timeout_ms = 1000;
     ++
       #define RR_HAS_POSTIMAGE 1
       #define RR_HAS_PREIMAGE 2
     + struct rerere_dir {
      @@ rerere.c: static void git_rerere_config(void)
       {
       	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
       	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
       		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
      -	if (flags & RERERE_READONLY)
     -+	if ((flags & RERERE_NOWAIT) && (flags & RERERE_LOCK_OR_DIE))
     -+		BUG("RERERE_NOWAIT and RERERE_LOCK_OR_DIE are mutually exclusive");
     -+	if ((flags & RERERE_READONLY) &&
     -+	    (flags & (RERERE_NOWAIT | RERERE_LOCK_OR_DIE)))
     -+		BUG("RERERE_READONLY takes no lock, so no lock flag applies");
     ++	if ((flags & RERERE_READONLY) && (flags & RERERE_NOWAIT))
     ++		BUG("RERERE_READONLY takes no lock, so RERERE_NOWAIT does not apply");
      +	if (flags & RERERE_READONLY) {
       		fd = 0;
      -	else
     --		fd = hold_lock_file_for_update(&write_lock,
     --					       git_path_merge_rr(r),
     --					       LOCK_DIE_ON_ERROR);
     +-		fd = repo_hold_lock_file_for_update(r, &write_lock,
     +-						    git_path_merge_rr(r),
     +-						    LOCK_DIE_ON_ERROR);
      +	} else {
     -+		int lock_flags = 0;
     ++		const char *path = git_path_merge_rr(r);
     ++		int lock_flags = LOCK_DIE_ON_ERROR;
      +		long timeout_ms = rerere_lock_timeout_ms;
      +
     -+		if (flags & RERERE_LOCK_OR_DIE)
     -+			lock_flags = LOCK_DIE_ON_ERROR;
     -+		if (flags & RERERE_NOWAIT)
     -+			timeout_ms = 0;
      +		/*
     -+		 * A background "rerere gc" holds the lock for as long as it
     -+		 * takes to prune rr-cache, so wait it out rather than fail
     -+		 * at once.  The gc itself has nothing to lose from a skipped
     -+		 * run and never waits.
     ++		 * Another process may hold the lock for a while, e.g.
     ++		 * "git rerere gc" while it prunes rr-cache, so wait for
     ++		 * it instead of dying right away.  The gc itself never
     ++		 * waits: skipping one of its runs costs nothing.
      +		 */
     -+		fd = hold_lock_file_for_update_timeout(&write_lock,
     -+						       git_path_merge_rr(r),
     -+						       lock_flags, timeout_ms);
     ++		if (flags & RERERE_NOWAIT) {
     ++			lock_flags = 0;
     ++			timeout_ms = 0;
     ++		}
     ++		fd = repo_hold_lock_file_for_update_timeout(r, &write_lock,
     ++							    path, lock_flags,
     ++							    timeout_ms);
      +		if (fd < 0) {
     -+			warning_errno(_("skipping rerere, unable to create '%s.lock'"),
     -+				      git_path_merge_rr(r));
     ++			warning_errno(_("skipping rerere, "
     ++					"unable to create '%s.lock'"), path);
      +			return -1;
      +		}
      +	}
       	read_rr(r, merge_rr);
       	return fd;
       }
     -@@ rerere.c: fail_exit:
     - 	return -1;
     - }
     - 
     --int rerere_forget(struct repository *r, struct pathspec *pathspec)
     -+int rerere_forget(struct repository *r, struct pathspec *pathspec, int flags)
     - {
     - 	int i, fd, ret;
     - 	struct string_list conflict = STRING_LIST_INIT_DUP;
     -@@ rerere.c: int rerere_forget(struct repository *r, struct pathspec *pathspec)
     - 	if (repo_read_index(r) < 0)
     - 		return error(_("index file corrupt"));
     - 
     --	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE);
     -+	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE | flags);
     - 	if (fd < 0)
     - 		return 0;
     - 
      @@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
       	timestamp_t cutoff_resolve = now - 60 * 86400;
       	struct strbuf buf = STRBUF_INIT;
     @@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
       		return;
       
       	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
     -@@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
     -  *
     -  * NEEDSWORK: shouldn't we be calling this from "reset --hard"?
     -  */
     --void rerere_clear(struct repository *r, struct string_list *merge_rr)
     -+void rerere_clear(struct repository *r, struct string_list *merge_rr, int flags)
     - {
     - 	int i;
     - 
     --	if (setup_rerere(r, merge_rr, 0) < 0)
     -+	if (setup_rerere(r, merge_rr, flags) < 0)
     - 		return;
     - 
     - 	for (i = 0; i < merge_rr->nr; i++) {
      
       ## rerere.h ##
      @@ rerere.h: struct repository;
       #define RERERE_AUTOUPDATE   01
       #define RERERE_NOAUTOUPDATE 02
       #define RERERE_READONLY     04
     -+/* Do not wait for the lock when another process holds it */
     ++/* Never wait for MERGE_RR.lock, and skip the run when it is held */
      +#define RERERE_NOWAIT       010
     -+/* Die on a lock that cannot be taken instead of going on without rerere */
     -+#define RERERE_LOCK_OR_DIE  020
       
       /*
        * Marks paths that have been hand-resolved and added to the
     -@@ rerere.h: int repo_rerere(struct repository *, int);
     -  */
     - const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
     - 			const char *file);
     --int rerere_forget(struct repository *, struct pathspec *);
     -+int rerere_forget(struct repository *, struct pathspec *, int);
     - int rerere_remaining(struct repository *, struct string_list *);
     --void rerere_clear(struct repository *, struct string_list *);
     -+void rerere_clear(struct repository *, struct string_list *, int);
     - void rerere_gc(struct repository *, struct string_list *);
     - 
     - #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
      
       ## t/t4200-rerere.sh ##
      @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	test_grep "^=======\$" $rr/preimage
      +'
      +
     -+test_expect_success 'merge goes on without rerere once rerere.lockTimeout is up' '
     ++test_expect_success 'merge fails once rerere.lockTimeout is up' '
      +	git reset --hard &&
      +	rm -rf $rr &&
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
     -+	test_grep "skipping rerere" err &&
     ++	test_grep "Unable to create" err &&
      +	test_grep "^=======\$" a1 &&
      +	test_path_is_missing $rr/preimage
      +'
      +
     -+test_expect_success 'commit goes on without rerere once rerere.lockTimeout is up' '
     -+	git reset --hard &&
     -+	rm -rf $rr &&
     -+	git checkout -b lock-held-commit third &&
     -+	test_when_finished "git checkout third && git branch -D lock-held-commit" &&
     -+	test_must_fail git merge first &&
     -+	test_path_is_file $rr/preimage &&
     -+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     -+	>.git/MERGE_RR.lock &&
     -+	echo resolved >a1 &&
     -+	git add a1 &&
     -+	git -c rerere.lockTimeout=0 commit -qm resolved 2>err &&
     -+	test_grep "skipping rerere" err &&
     -+	test_path_is_missing $rr/postimage
     -+'
     -+
      +test_expect_success 'rerere, forget and clear fail on a lock they cannot take' '
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	test_grep "Unable to create" err
      +'
      +
     -+test_expect_success 'rebase goes on without rerere once rerere.lockTimeout is up' '
     ++test_expect_success 'rebase --abort fails on a lock it cannot take' '
      +	git reset --hard &&
     -+	rm -rf $rr &&
     -+	git checkout -b lock-held third &&
     -+	test_when_finished "git checkout third && git branch -D lock-held" &&
     -+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     -+	>.git/MERGE_RR.lock &&
     -+	test_must_fail git -c rerere.lockTimeout=0 rebase first 2>err &&
     -+	test_grep "skipping rerere" err &&
     -+	test_path_is_file .git/rebase-merge/stopped-sha &&
     -+	echo resolved >a1 &&
     -+	git add a1 &&
     -+	git -c rerere.lockTimeout=0 rebase --continue &&
     -+	test_path_is_missing .git/rebase-merge &&
     -+	test_path_is_missing $rr/preimage
     -+'
     -+
     -+test_expect_success 'rebase --abort goes on without rerere on a held lock' '
      +	git checkout -b lock-held-abort third &&
      +	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
      +	test_must_fail git rebase first &&
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
     -+	git -c rerere.lockTimeout=0 rebase --abort 2>err &&
     -+	test_grep "skipping rerere" err &&
     ++	test_must_fail git -c rerere.lockTimeout=0 rebase --abort 2>err &&
     ++	test_grep "Unable to create" err &&
     ++	test_path_is_dir .git/rebase-merge &&
     ++	rm .git/MERGE_RR.lock &&
     ++	git rebase --abort &&
      +	test_path_is_missing .git/rebase-merge
      +'
      +
 -:  ---------- > 2:  1cce403113 rerere: go on at a conflict when the lock stays busy

-- 
gitgitgadget
