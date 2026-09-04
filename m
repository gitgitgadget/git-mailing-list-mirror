Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3E73CFF6C
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 07:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507882; cv=none; b=pPalu/uumvhnnruQLf2UmElXZe3KiODsZcFBr05QihhfqWBCEuVb/OW+UGuHFYHxkcnp+FdOtisnaSeR4R+3HpQ9lOmhrxhVn04x2M/8UzEuc7WhA1P0k4hzb7BKACwEtI4+KHEtKdiDCU+Bo4aZmW/ThyiRzaB4uLR9UX9uatM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507882; c=relaxed/simple;
	bh=bDxZF8aQtcS4+fXfcNXRSPW/hD+jVYiUrorwGcU5rk4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=tjNeRkqUritk0oWEFRo52/Tj3yilBgvjUaGiEzizLlTFw0mwynTKQfdsrMfXh/cu6TiZWTuPLRFNDFPdCpaR/QmtxGN5CiaTKk4Afa95k891uefm1RtLxSw52cDU1gwf3b4JhZKbYzpr+dWT+q++KArIyLMZe8FtMtnaBExEq60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMBaLBER; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMBaLBER"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-92e57a753f9so82496985a.2
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 00:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788507878; x=1789112678; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=UpZXQVOmMo1caD9O1LBP7lwmoV6yqrlzWHnWAJOQJ7I=;
        b=UMBaLBERrjjG+gh4F7eGy6LIlVVSoPksDPi+Pmu5VfgS+EiHm7Ye9USpdAtqkIooT+
         giaGDxaiOeMi9o1wkT4N8JvW8m0GUNLDbdKhghKUZTAxusHmNR1yHf/pMUN9VKCr6D8w
         ZGcF+kkU+m7lbpT3pijGVdn2LYUwIf1OsvvmYnGu6iNHcTQlJKuE+jtAvhqbDBxXc6Vs
         RqiOSwX+ye6Z1BzTgPHe1QAI8eTZzmOYeLf0TcQ+zWNl/7/RyKyC1v1MNJBQFywWvP1/
         Z9sG/U8bWA6QG7fj5vyBdomU0NmD7DpwK5o7G9N8fBuOrz1Ek+YdfJNTD/wH+ohWI/IX
         bk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507878; x=1789112678;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UpZXQVOmMo1caD9O1LBP7lwmoV6yqrlzWHnWAJOQJ7I=;
        b=QF2eEq43SgvpEN+R/1L45hIPvGV2nmmbciLlHa5idJKmxhqL3RfpHvdTOri4obVBi3
         QpBHRVXRQqe9362H9iIOLxDyc+09XaeMPQ3f2mmtugf0w7Wb5W+qn6grRszcwNRdIp9N
         G8FdXuTCVypGj2NRl5Iv2KcFq0Dmb6kfdFijwDZpBGvyMJc/ehPoJgmX19ZtiR3Ohnjn
         7jykClnnac1RXGzhx3x4FDIq3MErBjWmijgyf7fl4W3HLuWDiwVMoNRMwFQX9Mu5OHtk
         MULZ2quLHigEqosFB+ayj/QVEeqLhhJZG3gw1Bd6BTeCyCVIHvtLn0BdGJH/UV5XOtNx
         DG6w==
X-Gm-Message-State: AFuF++n2TCkuPhgueVKTB4+WF1h5SFFxCI3QDIeKBBrXHYvfUvvH+D+v
	tBNCgudg36J0KkzFRI0/Xtnzbe0q/+cDNpBVHpwrdZXgXJr0nLJ4mLiwSDQOZQ==
X-Gm-Gg: AYBFou0gFaqIome09mQU6mJJePAzC5PfDzDBJFzhXiQ3lP/Ij1boyY3dhatu1bLaku/
	emUnUfKVI0mwQveuES03LPKwCNNQdslf+MeDTn/Acbne8V5Xpj0gawdzjs0doxbGMPCGgxXHvi3
	lh01UTDwZJ3+rbDCgQ5JyEAKP47aqjEZ+7mQlP5eudzsJHuslPlzFF2PJR4FTKYe4G6K2yW+edK
	+ZLsKan9ALVUQQYeXTy7aUbZMMqWEHFkhUpgFk1arVRTC1dWW8oxdx9WnYZdWSX6YN3fyXkFbVP
	6V1Gbhgtb9v+NTKqY5mAHiYf7Qc6PEq9YfZuIDsjodSta2tPnyLXKqjF/MNtU3t8Qxlua5zvkcc
	jDC3Z5m7jpJoZP0iEbqAgHPpITcPyGNR8Hi+SiUvGop+2n1KnfNtzM87oDvhfSAeYF+EUupcKWS
	4jsClRxY8+ZhqNm69ynXVQQDDfO3J5cVEEe5uUQeGNh9iBlJbtaxKETX6Efy/ORTSG
X-Received: by 2002:a05:620a:25d4:b0:939:6df9:1996 with SMTP id af79cd13be357-9398077453bmr381134085a.50.1788507877925;
        Fri, 04 Sep 2026 00:44:37 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.246.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fb303b8sm167622885a.20.2026.09.04.00.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:44:37 -0700 (PDT)
Message-Id: <pull.2214.v2.git.1788507876543.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 07:44:36 +0000
Subject: [PATCH v2] rerere: keep a background gc from killing a rebase
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
    Thomas Bachem <mail@thomasbachem.com>,
    Thomas Bachem <mail@thomasbachem.com>

From: Thomas Bachem <mail@thomasbachem.com>

Since 2.54 unscheduled maintenance uses the "geometric" strategy, so
the "git maintenance run --auto --detach" behind every "git commit"
runs "git rerere gc" in the background whenever rr-cache has an entry.
That includes the "git commit" the sequencer runs for a resolved pick
on "git rebase --continue".

rerere_gc() takes MERGE_RR.lock through setup_rerere(), which uses
LOCK_DIE_ON_ERROR, and so does the sequencer's repo_rerere() at the
next conflict a few milliseconds later. Whichever comes second dies.
When it is the rebase, it dies in do_pick_commit() with the index
written but before make_patch() writes rebase-merge/{message,patch,
stopped-sha}, and every later "git rebase --continue" refuses with
"you have staged changes in your working tree". When it is the "git
commit" of a later continue, that one dies in its post-commit
repo_rerere() after the commit was made. Before 2.54 the same
collision needed an auto gc to actually run, since gc runs
"rerere gc" at its end.

A rebase with two conflicts in a row shows it. The filler makes the
pick slower than the ~5 ms the background task needs to take the
lock, and the stale entries give the gc something to prune, which
keeps the lock held for about half a second. It hit 6 of 6 runs here
on 2.55.0, and a test suite driving rebases on toy repositories with
a single rr-cache entry hit it in both runs that were traced:

    git init -q -b main r && cd r
    git config rerere.enabled true
    git config maintenance.auto false
    mkdir pad && seq 20000 | (cd pad && split -l 1 -a 5)
    echo base >f && git add -A && git commit -qm base
    git checkout -q -b topic
    echo b >f && git commit -qam B
    echo c >f && git commit -qam C
    git checkout -q main
    echo a >f && git commit -qam A
    git repack -adq
    git ls-files -s pad | head -n 5000 |
        awk '{print ".git/rr-cache/" $2}' | xargs mkdir -p
    for d in .git/rr-cache/*/; do echo x >$d/preimage; done
    touch -t 202001010000 .git/rr-cache/*/preimage
    git config --unset maintenance.auto
    git checkout -q topic
    git rebase main
    echo ab >f && git add f
    GIT_EDITOR=true git rebase --continue

The continue dies with "Unable to create '.git/MERGE_RR.lock': File
exists" while the gc spawned by its own commit holds the lock, and
after resolving C every further continue refuses. Maintenance stays
off during the setup so that no repack is pending: a repack due at
that commit runs ahead of rerere-gc in the task list and would spend
the window.

The gc needs the lock: it removes every rr-cache directory it finds
empty, and a rerere that has just created its directory but not yet
written the preimage looks exactly like that. So keep the lock and
stop dying over it. A caller that finds the lock held now waits for
rerere.lockTimeout milliseconds, with the semantics of
core.packedRefsTimeout and the same default of 1000, and then warns
and goes on without rerere: a merge, a commit or a pick loses one
recording or replay, which is nothing next to a rebase that cannot
continue. The gc itself never waits, since it has nothing to lose
from a skipped run, and "git rerere", "git rerere forget" and "git
rerere clear" keep dying, since they exist for nothing but the state
behind the lock. The clearing "git am" and "git rebase" do on --abort
and --skip goes on without it: the cleanup that follows removes
MERGE_RR anyway, and the unresolved entries it would have dropped are
left for the gc. A stale MERGE_RR.lock, which used to stop every
merge, now costs each command a second and a warning until it is
removed.

That rebase now stops at C the normal way, with its preimage recorded
once the prune is over, and continues once C is resolved. The tests
cover the gc under a held lock, directly and through the maintenance
task, a merge that waits a lock out within rerere.lockTimeout, a
merge, a commit and a rebase that go on without rerere once it is
up, "git rebase --abort" doing the same, and the three explicit
commands failing.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
    rerere: keep a background gc from killing a rebase
    
    Changes since v1:
    
     * Once rerere.lockTimeout is up, setup_rerere() warns and returns -1
       instead of dying, so a merge, commit or pick goes on without rerere
       (Phillip). Only "git rerere", "git rerere forget" and "git rerere
       clear" keep dying, through a RERERE_LOCK_OR_DIE flag. rerere_clear()
       takes flags for that, since "am" and "rebase" call it too and go on.
     * RERERE_SKIP_LOCKED is now RERERE_NOWAIT: skipping is what everyone
       does, not waiting is what sets the gc apart. The wait and its default
       stay (Patrick).
     * The warning stays hand-rolled rather than LOCK_REPORT_ON_ERROR
       (Patrick): the lockfile message tells the user to terminate other git
       processes and try again, which a command that goes on without rerere
       should not say. It names the lock file, says that rerere is skipped,
       and carries the errno, so the reason still shows.
     * The repro uses 5000 stale entries named after blobs, so the gc has
       something to prune and the run still triggers a gc that only prunes
       what is due, as with Patrick's heuristic series. The prune holds the
       lock for about half a second here, within the default timeout, so the
       fixed rebase records the second conflict rather than skip it.
     * Tests: the timeout=0 test now checks that the merge goes on, and new
       ones cover a commit and a rebase going on under a held lock, "git
       rebase --abort", and the three explicit commands. test_grep
       throughout.
     * Commit message: the fix gets the discussion, the repro one paragraph
       and its script (Phillip). What waits, what goes on and what keeps
       dying is spelled out, and the script has one continue, not two.
    
    Still based on maint, where the bug ships (2.54.0 and 2.55.0). Merged up
    it conflicts with d43f701d32 (lockfile: add
    repo_hold_lock_file_for_update{,_timeout}{,_mode}(), 2026-07-14) in
    setup_rerere(), where the resolution takes the repo-scoped helper. With
    that, t4200 and t7900 pass on top of Patrick's series and with the
    sequencer series that keeps auto maintenance out of a rebase, sent
    separately.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2214

Range-diff vs v1:

 1:  ecd9e5b4ec ! 1:  bbb2338572 rerere: keep a background gc from killing a rebase
     @@ Commit message
      
          A rebase with two conflicts in a row shows it. The filler makes the
          pick slower than the ~5 ms the background task needs to take the
     -    lock, and keeps the lock held for about 0.4 s. It hit 6 of 6 runs
     -    here on 2.55.0, and a test suite driving rebases on toy repositories
     -    with a single rr-cache entry hit it in both runs that were traced:
     +    lock, and the stale entries give the gc something to prune, which
     +    keeps the lock held for about half a second. It hit 6 of 6 runs here
     +    on 2.55.0, and a test suite driving rebases on toy repositories with
     +    a single rr-cache entry hit it in both runs that were traced:
      
              git init -q -b main r && cd r
              git config rerere.enabled true
     @@ Commit message
              git checkout -q main
              echo a >f && git commit -qam A
              git repack -adq
     -        seq 20000 | awk '{printf ".git/rr-cache/%040x\n", $1}' \
     -            | xargs mkdir -p
     +        git ls-files -s pad | head -n 5000 |
     +            awk '{print ".git/rr-cache/" $2}' | xargs mkdir -p
              for d in .git/rr-cache/*/; do echo x >$d/preimage; done
     +        touch -t 202001010000 .git/rr-cache/*/preimage
              git config --unset maintenance.auto
              git checkout -q topic
              git rebase main
              echo ab >f && git add f
              GIT_EDITOR=true git rebase --continue
      
     -    The second continue dies with "Unable to create '.git/MERGE_RR.lock':
     -    File exists" while the gc spawned by its own commit holds the lock,
     -    and after resolving C every further continue refuses. Maintenance
     -    stays off during the setup so that no repack is pending: a repack due
     -    at that commit runs ahead of rerere-gc in the task list and would
     -    spend the window.
     +    The continue dies with "Unable to create '.git/MERGE_RR.lock': File
     +    exists" while the gc spawned by its own commit holds the lock, and
     +    after resolving C every further continue refuses. Maintenance stays
     +    off during the setup so that no repack is pending: a repack due at
     +    that commit runs ahead of rerere-gc in the task list and would spend
     +    the window.
      
          The gc needs the lock: it removes every rr-cache directory it finds
          empty, and a rerere that has just created its directory but not yet
     -    written the preimage looks exactly like that. So keep the lock and fix
     -    both orders. When the gc finds the lock busy, let it warn and do
     -    nothing this time, the way "maintenance run" treats its own lock, so a
     -    manual "git rerere gc" sees the warning and the maintenance task and
     -    "git gc" see a clean exit. When the gc holds the lock, let every other
     -    caller wait it out instead of dying at once, for rerere.lockTimeout
     -    milliseconds with the semantics of core.packedRefsTimeout: 1000 by
     -    default, 0 for the old behaviour, -1 for an unbounded wait. Walking a
     -    20000-entry rr-cache takes about 0.4 s here.
     -
     -    That rebase now completes. The tests cover the gc under a held lock,
     -    directly and through the maintenance task, a merge that waits a lock
     -    out within a five second rerere.lockTimeout, and one that fails at
     -    once with a timeout of 0.
     +    written the preimage looks exactly like that. So keep the lock and
     +    stop dying over it. A caller that finds the lock held now waits for
     +    rerere.lockTimeout milliseconds, with the semantics of
     +    core.packedRefsTimeout and the same default of 1000, and then warns
     +    and goes on without rerere: a merge, a commit or a pick loses one
     +    recording or replay, which is nothing next to a rebase that cannot
     +    continue. The gc itself never waits, since it has nothing to lose
     +    from a skipped run, and "git rerere", "git rerere forget" and "git
     +    rerere clear" keep dying, since they exist for nothing but the state
     +    behind the lock. The clearing "git am" and "git rebase" do on --abort
     +    and --skip goes on without it: the cleanup that follows removes
     +    MERGE_RR anyway, and the unresolved entries it would have dropped are
     +    left for the gc. A stale MERGE_RR.lock, which used to stop every
     +    merge, now costs each command a second and a warning until it is
     +    removed.
     +
     +    That rebase now stops at C the normal way, with its preimage recorded
     +    once the prune is over, and continues once C is resolved. The tests
     +    cover the gc under a held lock, directly and through the maintenance
     +    task, a merge that waits a lock out within rerere.lockTimeout, a
     +    merge, a commit and a rebase that go on without rerere once it is
     +    up, "git rebase --abort" doing the same, and the three explicit
     +    commands failing.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ Documentation/config/rerere.adoc: rerere.enabled::
      +rerere.lockTimeout::
      +	The length of time, in milliseconds, to retry when trying to
      +	take the rerere lock while another process holds it, typically
     -+	a background `git rerere gc`.  Value 0 means not to retry at
     -+	all; -1 means to try indefinitely.  Default is 1000 (i.e.,
     -+	retry for 1 second).  `git rerere gc` itself does not wait and
     -+	skips its run instead.
     ++	a background `git rerere gc`.  When the time is up, the command
     ++	warns and goes on without rerere.  Value 0 means not to retry
     ++	at all; -1 means to try indefinitely.  Default is 1000 (i.e.,
     ++	retry for 1 second).  `git rerere gc` does not retry, and
     ++	`git rerere`, `git rerere forget` and `git rerere clear` fail
     ++	instead of going on.
      
       ## Documentation/git-rerere.adoc ##
      @@ Documentation/git-rerere.adoc: occurred a long time ago.  By default, unresolved conflicts older
     @@ Documentation/git-rerere.adoc: occurred a long time ago.  By default, unresolved
       
       DISCUSSION
      
     + ## builtin/am.c ##
     +@@ builtin/am.c: static int clean_index(const struct object_id *head, const struct object_id *rem
     + static void am_rerere_clear(void)
     + {
     + 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
     +-	rerere_clear(the_repository, &merge_rr);
     ++	rerere_clear(the_repository, &merge_rr, 0);
     + 	string_list_clear(&merge_rr, 1);
     + }
     + 
     +
     + ## builtin/rebase.c ##
     +@@ builtin/rebase.c: static int run_sequencer_rebase(struct rebase_options *opts)
     + 	case ACTION_SKIP: {
     + 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
     + 
     +-		rerere_clear(the_repository, &merge_rr);
     ++		rerere_clear(the_repository, &merge_rr, 0);
     + 	}
     + 		/* fallthrough */
     + 	case ACTION_CONTINUE: {
     +@@ builtin/rebase.c: int cmd_rebase(int argc,
     + 	case ACTION_SKIP: {
     + 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
     + 
     +-		rerere_clear(the_repository, &merge_rr);
     ++		rerere_clear(the_repository, &merge_rr, 0);
     + 		string_list_clear(&merge_rr, 1);
     + 		ropts.flags = RESET_HEAD_HARD;
     + 		if (reset_head(the_repository, &ropts) < 0)
     +@@ builtin/rebase.c: int cmd_rebase(int argc,
     + 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
     + 		struct strbuf head_msg = STRBUF_INIT;
     + 
     +-		rerere_clear(the_repository, &merge_rr);
     ++		rerere_clear(the_repository, &merge_rr, 0);
     + 		string_list_clear(&merge_rr, 1);
     + 
     + 		if (read_basic_state(&options))
     +
     + ## builtin/rerere.c ##
     +@@ builtin/rerere.c: int cmd_rerere(int argc,
     + 		flags = RERERE_NOAUTOUPDATE;
     + 
     + 	if (argc < 1)
     +-		return repo_rerere(the_repository, flags);
     ++		return repo_rerere(the_repository, flags | RERERE_LOCK_OR_DIE);
     + 
     + 	if (!strcmp(argv[0], "forget")) {
     + 		struct pathspec pathspec;
     +@@ builtin/rerere.c: int cmd_rerere(int argc,
     + 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
     + 			       prefix, argv + 1);
     + 
     +-		ret = rerere_forget(the_repository, &pathspec);
     ++		ret = rerere_forget(the_repository, &pathspec,
     ++				    RERERE_LOCK_OR_DIE);
     + 
     + 		clear_pathspec(&pathspec);
     + 		return ret;
     + 	}
     + 
     + 	if (!strcmp(argv[0], "clear")) {
     +-		rerere_clear(the_repository, &merge_rr);
     ++		rerere_clear(the_repository, &merge_rr, RERERE_LOCK_OR_DIE);
     + 	} else if (!strcmp(argv[0], "gc"))
     + 		rerere_gc(the_repository, &merge_rr);
     + 	else if (!strcmp(argv[0], "status")) {
     +
       ## rerere.c ##
      @@ rerere.c: static int rerere_enabled = -1;
       
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
      +	if (flags & RERERE_READONLY) {
       		fd = 0;
      -	else
     -+	} else if (flags & RERERE_SKIP_LOCKED) {
     - 		fd = hold_lock_file_for_update(&write_lock,
     +-		fd = hold_lock_file_for_update(&write_lock,
      -					       git_path_merge_rr(r),
      -					       LOCK_DIE_ON_ERROR);
     -+					       git_path_merge_rr(r), 0);
     -+		if (fd < 0) {
     -+			warning_errno(_("unable to lock '%s', skipping"),
     -+				      git_path_merge_rr(r));
     -+			return -1;
     -+		}
      +	} else {
     ++		int lock_flags = 0;
     ++		long timeout_ms = rerere_lock_timeout_ms;
     ++
     ++		if (flags & RERERE_LOCK_OR_DIE)
     ++			lock_flags = LOCK_DIE_ON_ERROR;
     ++		if (flags & RERERE_NOWAIT)
     ++			timeout_ms = 0;
      +		/*
      +		 * A background "rerere gc" holds the lock for as long as it
     -+		 * takes to walk rr-cache, so wait it out rather than die.
     ++		 * takes to prune rr-cache, so wait it out rather than fail
     ++		 * at once.  The gc itself has nothing to lose from a skipped
     ++		 * run and never waits.
      +		 */
      +		fd = hold_lock_file_for_update_timeout(&write_lock,
      +						       git_path_merge_rr(r),
     -+						       LOCK_DIE_ON_ERROR,
     -+						       rerere_lock_timeout_ms);
     ++						       lock_flags, timeout_ms);
     ++		if (fd < 0) {
     ++			warning_errno(_("skipping rerere, unable to create '%s.lock'"),
     ++				      git_path_merge_rr(r));
     ++			return -1;
     ++		}
      +	}
       	read_rr(r, merge_rr);
       	return fd;
       }
     +@@ rerere.c: fail_exit:
     + 	return -1;
     + }
     + 
     +-int rerere_forget(struct repository *r, struct pathspec *pathspec)
     ++int rerere_forget(struct repository *r, struct pathspec *pathspec, int flags)
     + {
     + 	int i, fd, ret;
     + 	struct string_list conflict = STRING_LIST_INIT_DUP;
     +@@ rerere.c: int rerere_forget(struct repository *r, struct pathspec *pathspec)
     + 	if (repo_read_index(r) < 0)
     + 		return error(_("index file corrupt"));
     + 
     +-	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE);
     ++	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE | flags);
     + 	if (fd < 0)
     + 		return 0;
     + 
      @@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
       	timestamp_t cutoff_resolve = now - 60 * 86400;
       	struct strbuf buf = STRBUF_INIT;
       
      -	if (setup_rerere(r, rr, 0) < 0)
     -+	if (setup_rerere(r, rr, RERERE_SKIP_LOCKED) < 0)
     ++	if (setup_rerere(r, rr, RERERE_NOWAIT) < 0)
       		return;
       
       	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
     +@@ rerere.c: void rerere_gc(struct repository *r, struct string_list *rr)
     +  *
     +  * NEEDSWORK: shouldn't we be calling this from "reset --hard"?
     +  */
     +-void rerere_clear(struct repository *r, struct string_list *merge_rr)
     ++void rerere_clear(struct repository *r, struct string_list *merge_rr, int flags)
     + {
     + 	int i;
     + 
     +-	if (setup_rerere(r, merge_rr, 0) < 0)
     ++	if (setup_rerere(r, merge_rr, flags) < 0)
     + 		return;
     + 
     + 	for (i = 0; i < merge_rr->nr; i++) {
      
       ## rerere.h ##
      @@ rerere.h: struct repository;
       #define RERERE_AUTOUPDATE   01
       #define RERERE_NOAUTOUPDATE 02
       #define RERERE_READONLY     04
     -+#define RERERE_SKIP_LOCKED  010
     ++/* Do not wait for the lock when another process holds it */
     ++#define RERERE_NOWAIT       010
     ++/* Die on a lock that cannot be taken instead of going on without rerere */
     ++#define RERERE_LOCK_OR_DIE  020
       
       /*
        * Marks paths that have been hand-resolved and added to the
     +@@ rerere.h: int repo_rerere(struct repository *, int);
     +  */
     + const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
     + 			const char *file);
     +-int rerere_forget(struct repository *, struct pathspec *);
     ++int rerere_forget(struct repository *, struct pathspec *, int);
     + int rerere_remaining(struct repository *, struct string_list *);
     +-void rerere_clear(struct repository *, struct string_list *);
     ++void rerere_clear(struct repository *, struct string_list *, int);
     + void rerere_gc(struct repository *, struct string_list *);
     + 
     + #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
      
       ## t/t4200-rerere.sh ##
      @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	git rerere gc 2>err &&
     -+	test_grep "MERGE_RR" err &&
     ++	test_grep "MERGE_RR.lock" err &&
      +	test_path_is_file $rr2/preimage &&
      +
      +	rm .git/MERGE_RR.lock &&
     @@ t/t4200-rerere.sh: test_expect_success 'old records rest in peace' '
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	{
     -+		(sleep 1 && rm -f .git/MERGE_RR.lock) &
     ++		( sleep 1 && rm -f .git/MERGE_RR.lock ) &
      +	} &&
      +	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
      +	wait &&
     -+	test_grep ! "Unable to create" err &&
     -+	grep "^=======\$" $rr/preimage
     ++	test_grep ! "MERGE_RR" err &&
     ++	test_grep "^=======\$" $rr/preimage
      +'
      +
     -+test_expect_success 'rerere.lockTimeout=0 fails at once on a held lock' '
     ++test_expect_success 'merge goes on without rerere once rerere.lockTimeout is up' '
      +	git reset --hard &&
      +	rm -rf $rr &&
      +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
      +	>.git/MERGE_RR.lock &&
      +	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
     ++	test_grep "skipping rerere" err &&
     ++	test_grep "^=======\$" a1 &&
     ++	test_path_is_missing $rr/preimage
     ++'
     ++
     ++test_expect_success 'commit goes on without rerere once rerere.lockTimeout is up' '
     ++	git reset --hard &&
     ++	rm -rf $rr &&
     ++	git checkout -b lock-held-commit third &&
     ++	test_when_finished "git checkout third && git branch -D lock-held-commit" &&
     ++	test_must_fail git merge first &&
     ++	test_path_is_file $rr/preimage &&
     ++	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     ++	>.git/MERGE_RR.lock &&
     ++	echo resolved >a1 &&
     ++	git add a1 &&
     ++	git -c rerere.lockTimeout=0 commit -qm resolved 2>err &&
     ++	test_grep "skipping rerere" err &&
     ++	test_path_is_missing $rr/postimage
     ++'
     ++
     ++test_expect_success 'rerere, forget and clear fail on a lock they cannot take' '
     ++	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     ++	>.git/MERGE_RR.lock &&
     ++	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
     ++	test_grep "Unable to create" err &&
     ++	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
      +	test_grep "Unable to create" err &&
     ++	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
     ++	test_grep "Unable to create" err
     ++'
     ++
     ++test_expect_success 'rebase goes on without rerere once rerere.lockTimeout is up' '
     ++	git reset --hard &&
     ++	rm -rf $rr &&
     ++	git checkout -b lock-held third &&
     ++	test_when_finished "git checkout third && git branch -D lock-held" &&
     ++	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     ++	>.git/MERGE_RR.lock &&
     ++	test_must_fail git -c rerere.lockTimeout=0 rebase first 2>err &&
     ++	test_grep "skipping rerere" err &&
     ++	test_path_is_file .git/rebase-merge/stopped-sha &&
     ++	echo resolved >a1 &&
     ++	git add a1 &&
     ++	git -c rerere.lockTimeout=0 rebase --continue &&
     ++	test_path_is_missing .git/rebase-merge &&
      +	test_path_is_missing $rr/preimage
      +'
     ++
     ++test_expect_success 'rebase --abort goes on without rerere on a held lock' '
     ++	git checkout -b lock-held-abort third &&
     ++	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
     ++	test_must_fail git rebase first &&
     ++	test_when_finished "rm -f .git/MERGE_RR.lock" &&
     ++	>.git/MERGE_RR.lock &&
     ++	git -c rerere.lockTimeout=0 rebase --abort 2>err &&
     ++	test_grep "skipping rerere" err &&
     ++	test_path_is_missing .git/rebase-merge
     ++'
      +
       rerere_gc_custom_expiry_test () {
       	five_days="$1" right_now="$2"


 Documentation/config/rerere.adoc | 10 ++++
 Documentation/git-rerere.adoc    |  4 +-
 builtin/am.c                     |  2 +-
 builtin/rebase.c                 |  6 +-
 builtin/rerere.c                 |  7 ++-
 rerere.c                         | 42 ++++++++++----
 rerere.h                         |  8 ++-
 t/t4200-rerere.sh                | 96 ++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           |  8 +++
 9 files changed, 163 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..b67323fc46 100644
--- a/Documentation/config/rerere.adoc
+++ b/Documentation/config/rerere.adoc
@@ -10,3 +10,13 @@ rerere.enabled::
 	enabled if there is an `rr-cache` directory under the
 	`$GIT_DIR`, e.g. if "rerere" was previously used in the
 	repository.
+
+rerere.lockTimeout::
+	The length of time, in milliseconds, to retry when trying to
+	take the rerere lock while another process holds it, typically
+	a background `git rerere gc`.  When the time is up, the command
+	warns and goes on without rerere.  Value 0 means not to retry
+	at all; -1 means to try indefinitely.  Default is 1000 (i.e.,
+	retry for 1 second).  `git rerere gc` does not retry, and
+	`git rerere`, `git rerere forget` and `git rerere clear` fail
+	instead of going on.
diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
index 4e6ab9a27c..05935b0603 100644
--- a/Documentation/git-rerere.adoc
+++ b/Documentation/git-rerere.adoc
@@ -70,7 +70,9 @@ occurred a long time ago.  By default, unresolved conflicts older
 than 15 days and resolved conflicts older than 60
 days are pruned.  These defaults are controlled via the
 `gc.rerereUnresolved` and `gc.rerereResolved` configuration
-variables respectively.
+variables respectively.  If another process holds the lock on the
+recorded resolutions, for example a merge or rebase that is recording
+a conflict, `gc` does nothing and reports so.
 
 
 DISCUSSION
diff --git a/builtin/am.c b/builtin/am.c
index e9623b8307..32f11161b4 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -2112,7 +2112,7 @@ static int clean_index(const struct object_id *head, const struct object_id *rem
 static void am_rerere_clear(void)
 {
 	struct string_list merge_rr = STRING_LIST_INIT_DUP;
-	rerere_clear(the_repository, &merge_rr);
+	rerere_clear(the_repository, &merge_rr, 0);
 	string_list_clear(&merge_rr, 1);
 }
 
diff --git a/builtin/rebase.c b/builtin/rebase.c
index fa4f5d9306..363d177472 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -367,7 +367,7 @@ static int run_sequencer_rebase(struct rebase_options *opts)
 	case ACTION_SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-		rerere_clear(the_repository, &merge_rr);
+		rerere_clear(the_repository, &merge_rr, 0);
 	}
 		/* fallthrough */
 	case ACTION_CONTINUE: {
@@ -1382,7 +1382,7 @@ int cmd_rebase(int argc,
 	case ACTION_SKIP: {
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 
-		rerere_clear(the_repository, &merge_rr);
+		rerere_clear(the_repository, &merge_rr, 0);
 		string_list_clear(&merge_rr, 1);
 		ropts.flags = RESET_HEAD_HARD;
 		if (reset_head(the_repository, &ropts) < 0)
@@ -1396,7 +1396,7 @@ int cmd_rebase(int argc,
 		struct string_list merge_rr = STRING_LIST_INIT_DUP;
 		struct strbuf head_msg = STRBUF_INIT;
 
-		rerere_clear(the_repository, &merge_rr);
+		rerere_clear(the_repository, &merge_rr, 0);
 		string_list_clear(&merge_rr, 1);
 
 		if (read_basic_state(&options))
diff --git a/builtin/rerere.c b/builtin/rerere.c
index a056cb791b..70a4bd1683 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -74,7 +74,7 @@ int cmd_rerere(int argc,
 		flags = RERERE_NOAUTOUPDATE;
 
 	if (argc < 1)
-		return repo_rerere(the_repository, flags);
+		return repo_rerere(the_repository, flags | RERERE_LOCK_OR_DIE);
 
 	if (!strcmp(argv[0], "forget")) {
 		struct pathspec pathspec;
@@ -85,14 +85,15 @@ int cmd_rerere(int argc,
 		parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD,
 			       prefix, argv + 1);
 
-		ret = rerere_forget(the_repository, &pathspec);
+		ret = rerere_forget(the_repository, &pathspec,
+				    RERERE_LOCK_OR_DIE);
 
 		clear_pathspec(&pathspec);
 		return ret;
 	}
 
 	if (!strcmp(argv[0], "clear")) {
-		rerere_clear(the_repository, &merge_rr);
+		rerere_clear(the_repository, &merge_rr, RERERE_LOCK_OR_DIE);
 	} else if (!strcmp(argv[0], "gc"))
 		rerere_gc(the_repository, &merge_rr);
 	else if (!strcmp(argv[0], "status")) {
diff --git a/rerere.c b/rerere.c
index 8232542585..4e2ececc09 100644
--- a/rerere.c
+++ b/rerere.c
@@ -32,6 +32,7 @@ static int rerere_enabled = -1;
 
 /* automatically update cleanly resolved paths to the index */
 static int rerere_autoupdate;
+static int rerere_lock_timeout_ms = 1000;
 
 #define RR_HAS_POSTIMAGE 1
 #define RR_HAS_PREIMAGE 2
@@ -876,6 +877,8 @@ static void git_rerere_config(void)
 {
 	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
 	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
+	repo_config_get_int(the_repository, "rerere.locktimeout",
+			    &rerere_lock_timeout_ms);
 	repo_config(the_repository, git_default_config, NULL);
 }
 
@@ -908,12 +911,31 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	if (flags & RERERE_READONLY)
+	if (flags & RERERE_READONLY) {
 		fd = 0;
-	else
-		fd = hold_lock_file_for_update(&write_lock,
-					       git_path_merge_rr(r),
-					       LOCK_DIE_ON_ERROR);
+	} else {
+		int lock_flags = 0;
+		long timeout_ms = rerere_lock_timeout_ms;
+
+		if (flags & RERERE_LOCK_OR_DIE)
+			lock_flags = LOCK_DIE_ON_ERROR;
+		if (flags & RERERE_NOWAIT)
+			timeout_ms = 0;
+		/*
+		 * A background "rerere gc" holds the lock for as long as it
+		 * takes to prune rr-cache, so wait it out rather than fail
+		 * at once.  The gc itself has nothing to lose from a skipped
+		 * run and never waits.
+		 */
+		fd = hold_lock_file_for_update_timeout(&write_lock,
+						       git_path_merge_rr(r),
+						       lock_flags, timeout_ms);
+		if (fd < 0) {
+			warning_errno(_("skipping rerere, unable to create '%s.lock'"),
+				      git_path_merge_rr(r));
+			return -1;
+		}
+	}
 	read_rr(r, merge_rr);
 	return fd;
 }
@@ -1124,7 +1146,7 @@ fail_exit:
 	return -1;
 }
 
-int rerere_forget(struct repository *r, struct pathspec *pathspec)
+int rerere_forget(struct repository *r, struct pathspec *pathspec, int flags)
 {
 	int i, fd, ret;
 	struct string_list conflict = STRING_LIST_INIT_DUP;
@@ -1133,7 +1155,7 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
-	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE);
+	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE | flags);
 	if (fd < 0)
 		return 0;
 
@@ -1237,7 +1259,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t cutoff_resolve = now - 60 * 86400;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, 0) < 0)
+	if (setup_rerere(r, rr, RERERE_NOWAIT) < 0)
 		return;
 
 	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
@@ -1289,11 +1311,11 @@ void rerere_gc(struct repository *r, struct string_list *rr)
  *
  * NEEDSWORK: shouldn't we be calling this from "reset --hard"?
  */
-void rerere_clear(struct repository *r, struct string_list *merge_rr)
+void rerere_clear(struct repository *r, struct string_list *merge_rr, int flags)
 {
 	int i;
 
-	if (setup_rerere(r, merge_rr, 0) < 0)
+	if (setup_rerere(r, merge_rr, flags) < 0)
 		return;
 
 	for (i = 0; i < merge_rr->nr; i++) {
diff --git a/rerere.h b/rerere.h
index d4b5f7c932..3a9f58acd9 100644
--- a/rerere.h
+++ b/rerere.h
@@ -10,6 +10,10 @@ struct repository;
 #define RERERE_AUTOUPDATE   01
 #define RERERE_NOAUTOUPDATE 02
 #define RERERE_READONLY     04
+/* Do not wait for the lock when another process holds it */
+#define RERERE_NOWAIT       010
+/* Die on a lock that cannot be taken instead of going on without rerere */
+#define RERERE_LOCK_OR_DIE  020
 
 /*
  * Marks paths that have been hand-resolved and added to the
@@ -34,9 +38,9 @@ int repo_rerere(struct repository *, int);
  */
 const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
 			const char *file);
-int rerere_forget(struct repository *, struct pathspec *);
+int rerere_forget(struct repository *, struct pathspec *, int);
 int rerere_remaining(struct repository *, struct string_list *);
-void rerere_clear(struct repository *, struct string_list *);
+void rerere_clear(struct repository *, struct string_list *, int);
 void rerere_gc(struct repository *, struct string_list *);
 
 #define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 1717f407c8..243b3ebed3 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -242,6 +242,102 @@ test_expect_success 'old records rest in peace' '
 	test_path_is_missing $rr2/preimage
 '
 
+test_expect_success 'gc does nothing while MERGE_RR is locked' '
+	mkdir -p $rr2 &&
+	echo Hello >$rr2/preimage &&
+	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
+
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	git rerere gc 2>err &&
+	test_grep "MERGE_RR.lock" err &&
+	test_path_is_file $rr2/preimage &&
+
+	rm .git/MERGE_RR.lock &&
+	git rerere gc &&
+	test_path_is_missing $rr2/preimage
+'
+
+test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	{
+		( sleep 1 && rm -f .git/MERGE_RR.lock ) &
+	} &&
+	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
+	wait &&
+	test_grep ! "MERGE_RR" err &&
+	test_grep "^=======\$" $rr/preimage
+'
+
+test_expect_success 'merge goes on without rerere once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
+	test_grep "skipping rerere" err &&
+	test_grep "^=======\$" a1 &&
+	test_path_is_missing $rr/preimage
+'
+
+test_expect_success 'commit goes on without rerere once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	git checkout -b lock-held-commit third &&
+	test_when_finished "git checkout third && git branch -D lock-held-commit" &&
+	test_must_fail git merge first &&
+	test_path_is_file $rr/preimage &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	echo resolved >a1 &&
+	git add a1 &&
+	git -c rerere.lockTimeout=0 commit -qm resolved 2>err &&
+	test_grep "skipping rerere" err &&
+	test_path_is_missing $rr/postimage
+'
+
+test_expect_success 'rerere, forget and clear fail on a lock they cannot take' '
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere forget a1 2>err &&
+	test_grep "Unable to create" err &&
+	test_must_fail git -c rerere.lockTimeout=0 rerere clear 2>err &&
+	test_grep "Unable to create" err
+'
+
+test_expect_success 'rebase goes on without rerere once rerere.lockTimeout is up' '
+	git reset --hard &&
+	rm -rf $rr &&
+	git checkout -b lock-held third &&
+	test_when_finished "git checkout third && git branch -D lock-held" &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	test_must_fail git -c rerere.lockTimeout=0 rebase first 2>err &&
+	test_grep "skipping rerere" err &&
+	test_path_is_file .git/rebase-merge/stopped-sha &&
+	echo resolved >a1 &&
+	git add a1 &&
+	git -c rerere.lockTimeout=0 rebase --continue &&
+	test_path_is_missing .git/rebase-merge &&
+	test_path_is_missing $rr/preimage
+'
+
+test_expect_success 'rebase --abort goes on without rerere on a held lock' '
+	git checkout -b lock-held-abort third &&
+	test_when_finished "git checkout third && git branch -D lock-held-abort" &&
+	test_must_fail git rebase first &&
+	test_when_finished "rm -f .git/MERGE_RR.lock" &&
+	>.git/MERGE_RR.lock &&
+	git -c rerere.lockTimeout=0 rebase --abort 2>err &&
+	test_grep "skipping rerere" err &&
+	test_path_is_missing .git/rebase-merge
+'
+
 rerere_gc_custom_expiry_test () {
 	five_days="$1" right_now="$2"
 	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index d7f82e1bec..a55ca2e829 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -885,6 +885,14 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
 '
 
+test_expect_success 'rerere-gc task succeeds while MERGE_RR is locked' '
+	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
+	mkdir .git/rr-cache &&
+	: >.git/rr-cache/entry &&
+	>.git/MERGE_RR.lock &&
+	test_expect_rerere_gc git maintenance run --task=rerere-gc
+'
+
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
 	test_grep "cannot be used together" err

base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc
-- 
gitgitgadget
