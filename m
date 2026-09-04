Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53EF3B841C
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788537089; cv=none; b=ubaaQ1DjsLiJAOD0RuvH+nRoR981HDMNJM30aou2V6O8I8gyBGBBaP8P7dqRyy6IgvS4LmLPrr78MvYdWKuyBBdRzdAHAyaaeQcJn9sBLt5V/RW/dTtxKwDrgI0L8UsB6nF9f352VMFnmCmLuCxna1DNFOzaaUoqQFmXnIykpKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788537089; c=relaxed/simple;
	bh=U1Tvq7Cn3z6lrob9Y4K7kb+Cczidg/a1iEhALebEX6o=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hXpkSwv1MMQE76KipxeoOLeHHbXyjq2fghipLkwVBFGldUq9sYhHCpx77HB4ijGx287w5k20e/PiOL0D7uYTvL+mtlxqJhbvsjuwvA9dGW8NzYJ0IwMofA21CKIrAVDS+3+x7MJOBnfu6SduIEW7H8A7nN/ivhCZIHwbbnliWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1LxWgC7; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1LxWgC7"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b132a5009eso987697eaf.1
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788537085; x=1789141885; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=roiitv9D/0vLPmlHlLyEFG/H2X0ZWSnbEyblzKE0QrY=;
        b=l1LxWgC7pqwLYZBQ0v+cnNHYgk//vlVtiR80mjmyA2vaIMp5s6kMrEUl/vh29IZlyO
         /CbfQUuSbUnf3ryONxxhE3iJW2h9vIS+HvDdOFTdkq6lCFACBYUu7elBwzBbec48P+O2
         ndkyDURYAuJrvqMBmGqr/KMvRPuYVNURx4lX8z4r92Xe8ZTi05ibyKGW/nztHCFXMmnd
         55DzkW7hpe2iYlK/+jP0EQ/vTINduumS4BZDYOtkWUrayafSt/5f3Zg7lMlLZaqE0r5r
         6nM/TgteTj/HkOX2G0VK1oJ8S+QHuqSQM1B6OXl8kFmoJly75U+Zzhxay5jiyr5RL1fD
         mA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788537085; x=1789141885;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=roiitv9D/0vLPmlHlLyEFG/H2X0ZWSnbEyblzKE0QrY=;
        b=sSqXb+KeXsusUE1YP/INGeJemkTiz6qaex3vxhAXZClWhujzPZkUtj41uL7hxu10P6
         BGZieXJEdq/Rfdn5UIToiG59xcOSvLS94obVjsSWQEQr/o74526rGDPqQZC3o0yCPtA3
         XGJTpzDSjan1/v4ZldST5uCisrEt9OMnQrropwv3BgC73DlHlvKUwGlt1j1D8hbSsrka
         D9ukBAZvwMc7IbfVvwntCuxAYEfi3ljlp2ooXiEqOJz5j8DSr7J80JH9IGce7FR53crt
         6g+YAvkrTWQDh92j+tbMz8gbUjrVnvxvCQ7Q/F9LfKES6y828jd0lieTCocSufY12O5s
         c9Nw==
X-Gm-Message-State: AFuF++kF2GTamWOrj1kOtLyvYtzWQ8YMYW+WXkDwy+MCCEHR5cotOmXF
	RwdNyzRZ8K7nouk57BS3KFOWsYN79a8vQN7mngMNJ4F6DIqGLRx/YXr0NqDPsQ==
X-Gm-Gg: AYBFou1kHcMWwAmnUfMtX+WXJadJK3ZgK68zV1mZgA3DuBWyW6U16MPfLsIFUOCjNHo
	pNcmP5BrZHYcTAgrahU92+kEExLwA95SyQALUiYco9xxpkKBQF9F8G5B34augWTeNY+o9aDL2rN
	OFeC2bKygACQ7Pp4yrDqdD2ScwzuiJKsGLlxbAFpgB9glS2vXLcnxJ/wBeF64b90Y8w/5seM7ut
	fLK5/THcYBRNiJ8s3EJskf/FfqafxCtRXWDtd5lJzVK4rbaWkf5zNjH0sUPi+VxVO4/qOgO9UiE
	Xz9jQUlOOSHjBDhE3Khug0MeTHeGYas54AMDkI94dc7CLpiB4rfiCdFDlhu13aXxbQv9trROzO8
	9rgWguh5mwriQoUsBoqNz4nlTuEZb5rqcMLSq5dPxf1vtoTgDVmXxmZdaSHMngmPc0z4AlDrWOF
	+Ocdfj9q0KtuWYlGtIVStJzUpYggw1x337TX3VH2OaG1p2XCJyTopb19t8/sZXFEKx
X-Received: by 2002:a05:6820:2912:b0:6b7:46fa:169f with SMTP id 006d021491bc7-6b746fa1b22mr3410260eaf.52.1788537083685;
        Fri, 04 Sep 2026 08:51:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.243.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm11878529c88.4.2026.09.04.08.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:51:23 -0700 (PDT)
Message-Id: <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 04 Sep 2026 15:51:21 +0000
Subject: [PATCH v3] rerere: keep a background gc from killing a rebase
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

A "git rerere gc" holds MERGE_RR.lock for as long as pruning rr-cache
takes, and since 2.54 the auto maintenance after every commit runs
one whenever rr-cache has an entry. The commit a rebase spawns for a
resolved pick starts it too, and the sequencer's repo_rerere() at the
next conflict wants the lock a few milliseconds later. Both take it
with LOCK_DIE_ON_ERROR, so whichever comes second dies. When it is
the rebase, the index is written but the state for "git rebase
--continue" is not, and every later continue refuses with "you have
staged changes".

The gc needs the lock, since a rerere that has just created its
directory looks like the empty ones it prunes. So wait for it
instead, rerere.lockTimeout milliseconds, 1000 by default with the
semantics of core.packedRefsTimeout, then warn and go on without
rerere: a lost recording or replay is nothing next to a rebase that
cannot continue. The gc itself never waits, and "git rerere", "git
rerere forget" and "git rerere clear" wait but then die, since the
state behind the lock is all they are for. The clearing "am" and
"rebase" do on --abort, --skip and --quit goes on without it, and
leaves the entries for the gc.

Assisted-by: Claude Fable 5.1
Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
---
    rerere: keep a background gc from killing a rebase
    
    Changes since v2:
    
     * The description is a quarter of the size and says what the patch does
       and why (Junio, Phillip).
     * setup_rerere() BUG()s on RERERE_NOWAIT combined with
       RERERE_LOCK_OR_DIE, and on RERERE_READONLY combined with either
       (Phillip).
     * The rerere.lockTimeout entry now says that "git rerere", "git rerere
       forget" and "git rerere clear" retry like everything else and only
       fail once the time is up (Phillip).
    
    Patrick's heuristic in ps/tune-rerere-gc narrows the auto trigger from
    "rr-cache has an entry" to "enough entries are stale". A gc that does
    run races the same way, so the fix stands on its own.
    
    Still based on maint, where the bug ships (2.54.0 and 2.55.0). Merged up
    it conflicts with 2e486bfbf7 (use
    repo_hold_lock_file_for_update{,_mode,_timeout}() with custom repos,
    2026-07-14) in setup_rerere(), where the resolution takes the
    repo-scoped helper.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2214

Range-diff vs v2:

 1:  bbb2338572 ! 1:  5bfda65baa rerere: keep a background gc from killing a rebase
     @@ Metadata
       ## Commit message ##
          rerere: keep a background gc from killing a rebase
      
     -    Since 2.54 unscheduled maintenance uses the "geometric" strategy, so
     -    the "git maintenance run --auto --detach" behind every "git commit"
     -    runs "git rerere gc" in the background whenever rr-cache has an entry.
     -    That includes the "git commit" the sequencer runs for a resolved pick
     -    on "git rebase --continue".
     +    A "git rerere gc" holds MERGE_RR.lock for as long as pruning rr-cache
     +    takes, and since 2.54 the auto maintenance after every commit runs
     +    one whenever rr-cache has an entry. The commit a rebase spawns for a
     +    resolved pick starts it too, and the sequencer's repo_rerere() at the
     +    next conflict wants the lock a few milliseconds later. Both take it
     +    with LOCK_DIE_ON_ERROR, so whichever comes second dies. When it is
     +    the rebase, the index is written but the state for "git rebase
     +    --continue" is not, and every later continue refuses with "you have
     +    staged changes".
      
     -    rerere_gc() takes MERGE_RR.lock through setup_rerere(), which uses
     -    LOCK_DIE_ON_ERROR, and so does the sequencer's repo_rerere() at the
     -    next conflict a few milliseconds later. Whichever comes second dies.
     -    When it is the rebase, it dies in do_pick_commit() with the index
     -    written but before make_patch() writes rebase-merge/{message,patch,
     -    stopped-sha}, and every later "git rebase --continue" refuses with
     -    "you have staged changes in your working tree". When it is the "git
     -    commit" of a later continue, that one dies in its post-commit
     -    repo_rerere() after the commit was made. Before 2.54 the same
     -    collision needed an auto gc to actually run, since gc runs
     -    "rerere gc" at its end.
     -
     -    A rebase with two conflicts in a row shows it. The filler makes the
     -    pick slower than the ~5 ms the background task needs to take the
     -    lock, and the stale entries give the gc something to prune, which
     -    keeps the lock held for about half a second. It hit 6 of 6 runs here
     -    on 2.55.0, and a test suite driving rebases on toy repositories with
     -    a single rr-cache entry hit it in both runs that were traced:
     -
     -        git init -q -b main r && cd r
     -        git config rerere.enabled true
     -        git config maintenance.auto false
     -        mkdir pad && seq 20000 | (cd pad && split -l 1 -a 5)
     -        echo base >f && git add -A && git commit -qm base
     -        git checkout -q -b topic
     -        echo b >f && git commit -qam B
     -        echo c >f && git commit -qam C
     -        git checkout -q main
     -        echo a >f && git commit -qam A
     -        git repack -adq
     -        git ls-files -s pad | head -n 5000 |
     -            awk '{print ".git/rr-cache/" $2}' | xargs mkdir -p
     -        for d in .git/rr-cache/*/; do echo x >$d/preimage; done
     -        touch -t 202001010000 .git/rr-cache/*/preimage
     -        git config --unset maintenance.auto
     -        git checkout -q topic
     -        git rebase main
     -        echo ab >f && git add f
     -        GIT_EDITOR=true git rebase --continue
     -
     -    The continue dies with "Unable to create '.git/MERGE_RR.lock': File
     -    exists" while the gc spawned by its own commit holds the lock, and
     -    after resolving C every further continue refuses. Maintenance stays
     -    off during the setup so that no repack is pending: a repack due at
     -    that commit runs ahead of rerere-gc in the task list and would spend
     -    the window.
     -
     -    The gc needs the lock: it removes every rr-cache directory it finds
     -    empty, and a rerere that has just created its directory but not yet
     -    written the preimage looks exactly like that. So keep the lock and
     -    stop dying over it. A caller that finds the lock held now waits for
     -    rerere.lockTimeout milliseconds, with the semantics of
     -    core.packedRefsTimeout and the same default of 1000, and then warns
     -    and goes on without rerere: a merge, a commit or a pick loses one
     -    recording or replay, which is nothing next to a rebase that cannot
     -    continue. The gc itself never waits, since it has nothing to lose
     -    from a skipped run, and "git rerere", "git rerere forget" and "git
     -    rerere clear" keep dying, since they exist for nothing but the state
     -    behind the lock. The clearing "git am" and "git rebase" do on --abort
     -    and --skip goes on without it: the cleanup that follows removes
     -    MERGE_RR anyway, and the unresolved entries it would have dropped are
     -    left for the gc. A stale MERGE_RR.lock, which used to stop every
     -    merge, now costs each command a second and a warning until it is
     -    removed.
     -
     -    That rebase now stops at C the normal way, with its preimage recorded
     -    once the prune is over, and continues once C is resolved. The tests
     -    cover the gc under a held lock, directly and through the maintenance
     -    task, a merge that waits a lock out within rerere.lockTimeout, a
     -    merge, a commit and a rebase that go on without rerere once it is
     -    up, "git rebase --abort" doing the same, and the three explicit
     -    commands failing.
     +    The gc needs the lock, since a rerere that has just created its
     +    directory looks like the empty ones it prunes. So wait for it
     +    instead, rerere.lockTimeout milliseconds, 1000 by default with the
     +    semantics of core.packedRefsTimeout, then warn and go on without
     +    rerere: a lost recording or replay is nothing next to a rebase that
     +    cannot continue. The gc itself never waits, and "git rerere", "git
     +    rerere forget" and "git rerere clear" wait but then die, since the
     +    state behind the lock is all they are for. The clearing "am" and
     +    "rebase" do on --abort, --skip and --quit goes on without it, and
     +    leaves the entries for the gc.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ Documentation/config/rerere.adoc: rerere.enabled::
      +	a background `git rerere gc`.  When the time is up, the command
      +	warns and goes on without rerere.  Value 0 means not to retry
      +	at all; -1 means to try indefinitely.  Default is 1000 (i.e.,
     -+	retry for 1 second).  `git rerere gc` does not retry, and
     -+	`git rerere`, `git rerere forget` and `git rerere clear` fail
     -+	instead of going on.
     ++	retry for 1 second).  `git rerere gc` does not retry at all.
     ++	`git rerere`, `git rerere forget` and `git rerere clear` retry
     ++	the same way, but fail when the time is up instead of going on.
      
       ## Documentation/git-rerere.adoc ##
      @@ Documentation/git-rerere.adoc: occurred a long time ago.  By default, unresolved conflicts older
     @@ rerere.c: int setup_rerere(struct repository *r, struct string_list *merge_rr, i
       	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
       		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
      -	if (flags & RERERE_READONLY)
     ++	if ((flags & RERERE_NOWAIT) && (flags & RERERE_LOCK_OR_DIE))
     ++		BUG("RERERE_NOWAIT and RERERE_LOCK_OR_DIE are mutually exclusive");
     ++	if ((flags & RERERE_READONLY) &&
     ++	    (flags & (RERERE_NOWAIT | RERERE_LOCK_OR_DIE)))
     ++		BUG("RERERE_READONLY takes no lock, so no lock flag applies");
      +	if (flags & RERERE_READONLY) {
       		fd = 0;
      -	else


 Documentation/config/rerere.adoc | 10 ++++
 Documentation/git-rerere.adoc    |  4 +-
 builtin/am.c                     |  2 +-
 builtin/rebase.c                 |  6 +-
 builtin/rerere.c                 |  7 ++-
 rerere.c                         | 47 ++++++++++++----
 rerere.h                         |  8 ++-
 t/t4200-rerere.sh                | 96 ++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh           |  8 +++
 9 files changed, 168 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
index 3a78b5ebb1..14ef193545 100644
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
+	retry for 1 second).  `git rerere gc` does not retry at all.
+	`git rerere`, `git rerere forget` and `git rerere clear` retry
+	the same way, but fail when the time is up instead of going on.
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
index 8232542585..bae780f584 100644
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
 
@@ -908,12 +911,36 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
 
 	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
 		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
-	if (flags & RERERE_READONLY)
+	if ((flags & RERERE_NOWAIT) && (flags & RERERE_LOCK_OR_DIE))
+		BUG("RERERE_NOWAIT and RERERE_LOCK_OR_DIE are mutually exclusive");
+	if ((flags & RERERE_READONLY) &&
+	    (flags & (RERERE_NOWAIT | RERERE_LOCK_OR_DIE)))
+		BUG("RERERE_READONLY takes no lock, so no lock flag applies");
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
@@ -1124,7 +1151,7 @@ fail_exit:
 	return -1;
 }
 
-int rerere_forget(struct repository *r, struct pathspec *pathspec)
+int rerere_forget(struct repository *r, struct pathspec *pathspec, int flags)
 {
 	int i, fd, ret;
 	struct string_list conflict = STRING_LIST_INIT_DUP;
@@ -1133,7 +1160,7 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 	if (repo_read_index(r) < 0)
 		return error(_("index file corrupt"));
 
-	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE);
+	fd = setup_rerere(r, &merge_rr, RERERE_NOAUTOUPDATE | flags);
 	if (fd < 0)
 		return 0;
 
@@ -1237,7 +1264,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
 	timestamp_t cutoff_resolve = now - 60 * 86400;
 	struct strbuf buf = STRBUF_INIT;
 
-	if (setup_rerere(r, rr, 0) < 0)
+	if (setup_rerere(r, rr, RERERE_NOWAIT) < 0)
 		return;
 
 	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
@@ -1289,11 +1316,11 @@ void rerere_gc(struct repository *r, struct string_list *rr)
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
