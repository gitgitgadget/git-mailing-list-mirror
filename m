Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BB32E624
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 14:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZksaWMfn"
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD487187
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:46 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-4083dbc43cfso49647145e9.3
        for <git@vger.kernel.org>; Wed, 15 Nov 2023 06:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700058824; x=1700663624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WVGpAJo1q1H7vOsk0AACdMeeqgQHYfcUSQjVhufBvCM=;
        b=ZksaWMfn79v7fAtcOdcDdsr4qm45WsMKInZdHzgnr4ycqiQ9RotMSS197uroXWjyRW
         esfiO8p2gyVfD+G9Rr7pblU6sZbpe6CvRRKkKj2Vd5JPvzbWQQ6B35SlGvJQnovcWUp0
         QKuJrWr4/bVaXS/+QjB8r2NaBX47rVwbe9er3m8nyvDm0f0rRdsX7VZW9/QpZq0Q7Kmu
         sGlKQqf0oKMYvBfyLs5O17nQKShGm9cGec9SzqPUzNSyS+tCIzN2kRBdNJGlObnmxgfj
         gH5nRbJQqCLBa1FZCQY2z9p41XWqMPzh+8jpP8+XkJ8KmcXknGFN4OL4nuEx+utqG0HT
         haKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700058824; x=1700663624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WVGpAJo1q1H7vOsk0AACdMeeqgQHYfcUSQjVhufBvCM=;
        b=jhFCcScDvuNNHyZbugJlKKy8CKPoSijelbHjGK2sZnoBr5AIhH98z8daF7/dTtnpQ8
         i5MOXCKobYnvsg5ZsntCFrHv0P1aNWQtXd4gIrPFXnhp6b7nMVcBPzLVApnHcCvYKifv
         3iz4c0yXAYfE/sUu63d1U65ifUj8gKURTDmAHp+TFaVySzML+Kn9k6WTVsT57gxd6vBs
         ig/2muhUdOINl4riFmUyObL2lkgn8y/4/3J+M3qOpNkXZHqv3MaDuHBOvUCXmYEVYEPy
         YMGiAQnHm98O+TXLb5HF3zmlQQ6KQ2bgwoPBhUVw/2SLlyDvsT+P36EzXU2ld40XOVDJ
         y5Gg==
X-Gm-Message-State: AOJu0YwZvjJ34c4+2IjFqeQ6KJzLv0ngoT3qdxVpYzlCMuiHqlcAji9b
	eaCc5GYe3HDFmiQWI5pOvwZyx63RPDs=
X-Google-Smtp-Source: AGHT+IHw2e+E8BM7bFIh/jwBzJOb9yqWCwTk9QgxE8Oyf9RHAit6lif5bRb9UJvt1qW5pIHi/lo5sA==
X-Received: by 2002:a05:600c:3b94:b0:408:5a1c:9de7 with SMTP id n20-20020a05600c3b9400b004085a1c9de7mr11472212wms.7.1700058823759;
        Wed, 15 Nov 2023 06:33:43 -0800 (PST)
Received: from localhost.localdomain ([2001:861:3f04:7ca0:a40b:e654:dd4c:2f5f])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b004060f0a0fd5sm15207643wmo.13.2023.11.15.06.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 06:33:42 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	John Cai <johncai86@gmail.com>,
	Derrick Stolee <stolee@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Toon Claes <toon@iotcl.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Linus Arver <linusa@google.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 00/14] Introduce new `git replay` command
Date: Wed, 15 Nov 2023 15:33:13 +0100
Message-ID: <20231115143327.2441397-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.43.0.rc1.15.g29556bcc86
In-Reply-To: <20231102135151.843758-1-christian.couder@gmail.com>
References: <20231102135151.843758-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

# Intro

`git replay` has initially been developed entirely by Elijah Newren
mostly last year (2022) at:

https://github.com/newren/git/commits/replay

I took over this year to polish and upstream it as GitLab is
interested in replacing libgit2, and for that purpose needs a command
to do server side (so without using a worktree) rebases, cherry-picks
and reverts.

I reduced the number of commits and features in this patch series,
compared to what Elijah already developed. Especially I stopped short
of replaying merge commits and replaying interactively. These and
other features might be upstreamed in the future after this patch
series has graduated.

The focus in this series is to make it a good plumbing command that
can already be used server side and that replaces the "fast-rebase"
test-tool command. So things to make it easier to use on the command
line, and more advanced features (like replaying merges) are left out.

It looks like GitHub has actually already been using version 3 of this
patch series in production with good results. See:

https://github.blog/2023-07-27-scaling-merge-ort-across-github/
https://lore.kernel.org/git/304f2a49-5e05-7655-9f87-2011606df5db@gmx.de/

# Content of this cover letter

The "Quick Overview" and "Reasons for diverging from cherry-pick &
rebase" sections just below are describing the purpose of the new
command in the big scheme of things. They are taken from Elijah's
design notes
(https://github.com/newren/git/blob/replay/replay-design-notes.txt)
and describe what we want this command to become and the reasons for
that, not what the command is after only this patch series. Also these
design notes were written at least one year ago, so parts of those 2
sections are not true anymore. I have added Phillip Wood's or Felipe
Contreras' notes (thanks to them) where that's the case, but some now
flawed parts may have missed.

After these two sections, starting with the "Important limitations"
section, you will find sections describing what is actually in this
patch series.

More interesting material is available in Elijah's design notes like
an "Intro via examples"
(https://github.com/newren/git/blob/replay/replay-design-notes.txt#L37-L132),
a discussion about "Preserving topology, replaying merges"
(https://github.com/newren/git/blob/replay/replay-design-notes.txt#L264-L341)
and a "Current status" section describing Elijah's work
(https://github.com/newren/git/blob/replay/replay-design-notes.txt#L344-L392)
before I started working on upstreaming it.

I have not included this material here though, as the documentation
added by this patch series for the `git replay` command already
includes an "EXAMPLES" section, and other sections of Elijah's design
notes might not be interesting for now. Also this cover letter is
already pretty long.  But reviewers can refer to the links above if
they think it can help.

# Quick Overview (from Elijah's design notes)

`git replay`, at a basic level, can perhaps be thought of as a
"default-to-dry-run rebase" -- meaning no updates to the working tree,
or to the index, or to any references.  However, it differs from
rebase in that it:

  * Works for branches that aren't checked out

  * Works in a bare repository

  * Can replay multiple branches simultaneously (with or without common
    history in the range being replayed)

  * Preserves relative topology by default (merges are replayed too in
    Elijah's original work, not in this series)

  * Focuses on performance

  * Has several altered defaults as a result of the above

I sometimes think of `git replay` as "fast-replay", a patch-based
analogue to the snapshot-based fast-export & fast-import tools.

# Reasons for diverging from cherry-pick & rebase (from Elijah's
  design notes)

There are multiple reasons to diverge from the defaults in cherry-pick and
rebase.

* Server side needs

  * Both cherry-pick and rebase, via the sequencer, are heavily tied
    to updating the working tree, index, some refs, and a lot of
    control files with every commit replayed, and invoke a mess of
    hooks[1] that might be hard to avoid for backward compatibility
    reasons (at least, that's been brought up a few times on the
    list).

  * cherry-pick and rebase both fork various subprocesses
    unnecessarily, but somewhat intrinsically in part to ensure the
    same hooks are called that old scripted implementations would have
    called.

    Note: since 356ee4659bb (sequencer: try to commit without forking
    'git commit', 2017-11-24) cherry-pick and rebase do not fork
    subprocesses other than hooks for the cases covered by this patch
    series (i.e. they do not fork "git commit" for simple picks).

  * "Dry run" behavior, where there are no updates to worktree, index,
    or even refs might be important.

  * Should not assume users only want to operate on HEAD (see next
    section)

* Decapitate HEAD-centric assumptions

  * cherry-pick forces commits to be played on top of HEAD;
    inflexible.

  * rebase assumes the range of commits to be replayed is
    upstream..HEAD by default, though it allows one to replay
    upstream..otherbranch -- but it still forcibly and needlessly
    checks out 'otherbranch' before starting to replay things.

    Note: since 767a9c417eb (rebase -i: stop checking out the tip of
    the branch to rebase, 2020-01-24) it's not true that rebase
    forcibly and needlessly checks out 'otherbranch'.

  * Assuming HEAD is involved severely limits replaying multiple
    (possibly divergent) branches.

    Note: since 89fc0b53fdb (rebase: update refs from 'update-ref'
    commands, 2022-07-19) the sequencer can update multiple
    branches. The issue with divergent branch is with command line
    arguments and the todo list generation rather than the
    capabilities of the sequencer.

  * Once you stop assuming HEAD has a certain meaning, there's not
    much reason to have two separate commands anymore (except for the
    funny extra not-necessarily-compatible options both have gained
    over time).

  * (Micro issue: Assuming HEAD is involved also makes it harder for
    new users to learn what rebase means and does; it makes command
    lines hard to parse.  Not sure I want to harp on this too much, as
    I have a suspicion I might be creating a tool for experts with
    complicated use cases, but it's a minor quibble.)

* Performance

  * jj is slaughtering us on rebase speed[2].  I would like us to become
    competitive.  (I dropped a few comments in the link at [2] about why
    git is currently so bad.)

  * From [3], there was a simple 4-patch series in linux.git that took
    53 seconds to rebase.  Switching to ort dropped it to 16 seconds.
    While that sounds great, only 11 *milliseconds* were needed to do
    the actual merges.  That means almost *all* the time (>99%) was
    overhead!  Big offenders:

    * --reapply-cherry-picks should be the default

    * can_fast_forward() should be ripped out, and perhaps other extraneous
      revision walks

      Note: d42c9ffa0f (rebase: factor out branch_base calculation,
      2022-10-17) might already deal with that (according to Felipe
      Contreras).

    * avoid updating working tree, index, refs, reflogs, and control
      structures except when needed (e.g. hitting a conflict, or operation
      finished)

  * Other performance ideas (mostly for future work, not in this
    series)

    * single-file control structures instead of directory of files
      (when doing interactive things which is in Elijah's original
      work, but not in this series)

    * avoid forking subprocesses unless explicitly requested (e.g.
      --exec, --strategy, --run-hooks).  For example, definitely do not
      invoke `git commit` or `git merge`.

    * Sanitize hooks:

      * dispense with all per-commit hooks for sure (pre-commit,
        post-commit, post-checkout).

      * pre-rebase also seems to assume exactly 1 ref is written, and
        invoking it repeatedly would be stupid.  Plus, it's specific
        to "rebase".  So...ignore?  (Stolee's --ref-update option for
        rebase probably broke the pre-rebase assumptions already...)

      * post-rewrite hook might make sense, but fast-import got
        exempted, and I think of replay like a patch-based analogue
        to the snapshot-based fast-import.

    * When not running server side, resolve conflicts in a sparse-cone
      sparse-index worktree to reduce number of files written to a
      working tree.  (See below as well.)

    * [High risk of possible premature optimization] Avoid large
      numbers of newly created loose objects, when replaying large
      numbers of commits.  Two possibilities: (1) Consider using
      tmp-objdir and pack objects from the tmp-objdir at end of
      exercise, (2) Lift code from git-fast-import to immediately
      stuff new objects into a pack?

* Multiple branches and non-checked out branches

  * The ability to operate on non-checked out branches also implies
    that we should generally be able to replay when in a dirty working
    tree (exception being when we expect to update HEAD and any of the
    dirty files is one that needs to be updated by the replay).

  * Also, if we are operating locally on a non-checked out branch and
    hit a conflict, we should have a way to resolve the conflict
    without messing with the user's work on their current
    branch. (This is not is this patch series though.)

    * Idea: new worktree with sparse cone + sparse index checkout,
      containing only files in the root directory, and whatever is
      necessary to get the conflicts

    * Companion to above idea: control structures should be written to
      $GIT_COMMON_DIR/replay-${worktree}, so users can have multiple
      replay sessions, and so we know which worktrees are associated
      with which replay operations.

  - [1] https://lore.kernel.org/git/pull.749.v3.git.git.1586044818132.gitgitgadget@gmail.com/
  - [2] https://github.com/martinvonz/jj/discussions/49
  - [3] https://lore.kernel.org/git/CABPp-BE48=97k_3tnNqXPjSEfA163F8hoE+HY0Zvz1SWB2B8EA@mail.gmail.com/

# Important limitations

* The code exits with code 1 if there are any conflict. No
  resumability. No nice output. No interactivity. No special exit code
  depending on the reason.

* When a commit becomes empty as it is replayed, it is still replayed
  as an empty commit, instead of being dropped.

* No replaying merges, nor root commits. Only regular commits.

* Signed commits are not properly handled. It's not clear what to do
  to such commits when replaying on the server side.

* Notes associated with replayed commits are not updated nor
  duplicated. (Thanks to Phillip Wood for noticing.)

# Commit overview

* 1/14 t6429: remove switching aspects of fast-rebase

    Preparatory commit to make it easier to later replace the
    fast-rebase test-tool by `git replay` without breaking existing
    tests.

* 2/14 replay: introduce new builtin

    This creates a minimal `git replay` command by moving the code
    from the `fast-rebase` test helper from `t/helper/` into
    `builtin/` and doing some renames and a few other needed changes.
    Since v6, there are only a few doc improvements as suggested by
    Dscho.

* - 3/14 replay: start using parse_options API
  - 4/14 replay: die() instead of failing assert()
  - 5/14 replay: introduce pick_regular_commit()
  - 6/14 replay: change rev walking options
  - 7/14 replay: add an important FIXME comment about gpg signing
  - 8/14 replay: remove progress and info output
  - 9/14 replay: remove HEAD related sanity check

    These slowly change the command to make it behave more like
    regular commands and to start cleaning up its output. In patch
    6/14 (replay: change rev walking options) there are some changes
    compared to v6 as suggested by Elijah and Dscho. We are now
    setting the rev walking bits we want before the call to
    setup_revisions(). And then after that call we check if these bits
    have been changed, and if that's the case we warn that we are
    going to override those changes and we override the bits.

* 10/14 replay: make it a minimal server side command

    After the cleaning up in previous commits, it's now time to
    radically change the way it works by stopping it to do ref
    updates, to update the index and worktree, to consider HEAD as
    special. Instead just make it output commands that should be
    passed to `git update-ref --stdin`.

* 11/14 replay: use standard revision ranges

    Start adding new interesting features and also documentation and
    tests, as the interface of the command is cristalizing into its
    final form. Since v6 "Takes a range of commits" has been replaced
    with "Takes ranges of commits" to reflect the fact that it can
    accept more than one <revision-range>.

* - 12/14 replay: add --advance or 'cherry-pick' mode
  - 13/14 replay: add --contained to rebase contained branches

    Add new options and features to the command.

* 14/14 replay: stop assuming replayed branches do not diverge

    This adds another interesting feature, as well as related
    documentation and tests.

# Notes about `fast-rebase`, tests and documentation

The `fast-rebase` test-tool helper was developed by Elijah to
experiment with a rebasing tool that would be developed from scratch
based on his merge-ort work, could be used to test that merge-ort
work, and would not have the speed and interface limitations of `git
rebase` or `git cherry-pick`.

This `fast-rebase` helper was used before this series in:

t6429-merge-sequence-rename-caching.sh

So when `git replay` is created from `fast-rebase` in patch 2/14, the
t6429 test script is also converted to use `git replay`. This ensures
that `git replay` doesn't break too badly during the first 10 patches
in this patch series.

Tests and documentation are introduced specifically for `git replay`
as soon as patch 2/14, but they are not much improved since around
11/14 as it doesn't make much sense to document and test behavior that
we know is going to change soon.

# Possibly controversial issues 

* bare or not bare: this series works towards a plumbing command with
  the end goal of it being usable and used first on bare repos,
  contrary to existing commands like `git rebase` and `git
  cherry-pick`. The tests check that the command works on both bare
  and non-bare repo though.

* exit status: a successful, non-conflicted replay exits with code
  0. When the replay has conflicts, the exit status is 1. If the
  replay is not able to complete (or start) due to some kind of error,
  the exit status is something other than 0 or 1. There are a few
  tests checking that. It has been suggested in an internal review
  that conflicts might want to get a more specific error code as an
  error code of 1 might be quite easy to return by accident. It
  doesn't seem to me from their docs (which might want to be improved,
  I didn't look at the code) that other commands like `git merge` and
  `git rebase` exit with a special error code in case of conflict.

* make worktree and index changes optional: commit 10/14 stops
  updating the index and worktree, but it might be better especially
  for cli users to make that optional. The issue is that this would
  make the command more complex while we are developing a number of
  important features so that the command can be used on bare repos. It
  seems that this should rather be done in an iterative improvement
  after the important features have landed.

* --advance and --contained: these two advanced options might not
  belong to this first series and could perhaps be added in a followup
  series in separate commits. On the other hand the code for
  --contained seems involved with the code of --advance and it's nice
  to see soon that git replay can indeed do cherry-picking and rebase
  many refs at once, and this way fullfil these parts of its promise.

* replaying diverging branches: 14/14 the last patch in the series,
  which allow replaying diverging branches, can be seen as a
  fundamental fix or alternatively as adding an interesting
  feature. So it's debatable if it should be in its own patch along
  with its own tests as in this series, or if it should be merged into
  a previous patch and which one.

* only 2 patches: this patch series can be seen from a high level
  point of view as 1) introducing the new `git replay` command, and 2)
  using `git replay` to replace, and get rid of, the fast-rebase
  test-tool command. The fact that not much of the original
  fast-rebase code and interface is left would agree with that point
  of view. On the other hand, fast-rebase can also be seen as a first
  iteration towards `git replay`. So it can also make sense to see how
  `git replay` evolved from it.

# Changes between v6 and v7

Thanks to Dscho, Linus Arver and Dragan Simic for their suggestions on
the previous version! The few changes compared to v6 are:

* The patch series was rebased onto master at dadef801b3 (Git
  2.43-rc1, 2023-11-08). This is to make it stand on a possibly more
  stable base.

* In patch 2/14 (replay: introduce new builtin), there are a few doc
  improvements as suggested by Dscho, as we now talk about the
  <oldbase> and <branch> arguments in the description.

* In patch 6/14 (replay: change rev walking options), as suggested by
  Elijah and Dscho, we are now setting the rev walking bits we want
  before the call to setup_revisions(). And then after that call we
  check if these bits have been changed, and if that's the case we
  warn that we are going to override those changes and we override the
  bits.

* In patch 11/14 (replay: use standard revision ranges), "Takes a
  range of commits" has been replaced with "Takes ranges of commits"
  to reflect the fact that it can accept more than one
  <revision-range>.

CI tests seem to pass according to:

https://github.com/chriscool/git/actions/runs/6878406898

(Except the "sparse" test, but failure doesn't seem to be related. And
sorry I stopped waiting for the MacOS and ASAN tests to finish after
23 minutes.)

# Range-diff between v6 and v7

(Sorry it looks like patch 6/14 in v7 is considered to be completely
different from what it was in v6, so the range-diff is not showing
differences between them.)

 1:  fac0a9dff4 =  1:  cddcd967b2 t6429: remove switching aspects of fast-rebase
 2:  bec2eb8928 !  2:  c8476fb093 replay: introduce new builtin
    @@ Documentation/git-replay.txt (new)
     +DESCRIPTION
     +-----------
     +
    -+Takes a range of commits and replays them onto a new location.
    ++Takes a range of commits, specified by <oldbase> and <branch>, and
    ++replays them onto a new location (see `--onto` option below).
     +
     +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
     +
 3:  b0cdfdc0c3 =  3:  43322abd1e replay: start using parse_options API
 4:  c3403f0b9d =  4:  6524c7f045 replay: die() instead of failing assert()
 5:  4188eeac30 =  5:  05d0efa3cb replay: introduce pick_regular_commit()
 6:  b7b4d9001e <  -:  ---------- replay: change rev walking options
 -:  ---------- >  6:  c7a5aad3d6 replay: change rev walking options
 7:  c57577a9b8 =  7:  01f35f924b replay: add an important FIXME comment about gpg signing
 8:  e78be50f3d =  8:  1498b24bad replay: remove progress and info output
 9:  e4c79b676f =  9:  6786fc147b replay: remove HEAD related sanity check
10:  8d89f1b733 ! 10:  9a24dbb530 replay: make it a minimal server side command
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/git-replay.txt ##
    -@@ Documentation/git-replay.txt: SYNOPSIS
    - DESCRIPTION
    +@@ Documentation/git-replay.txt: DESCRIPTION
      -----------
      
    --Takes a range of commits and replays them onto a new location.
    -+Takes a range of commits and replays them onto a new location. Leaves
    -+the working tree and the index untouched, and updates no
    -+references. The output of this command is meant to be used as input to
    + Takes a range of commits, specified by <oldbase> and <branch>, and
    +-replays them onto a new location (see `--onto` option below).
    ++replays them onto a new location (see `--onto` option below). Leaves
    ++the working tree and the index untouched, and updates no references.
    ++The output of this command is meant to be used as input to
     +`git update-ref --stdin`, which would update the relevant branches.
      
      THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct merge_result result;
     -  struct strbuf reflog_msg = STRBUF_INIT;
        struct strbuf branch_name = STRBUF_INIT;
    -   int i, ret = 0;
    +   int ret = 0;
      
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
        onto = peel_committish(onto_name);
11:  3d433a1322 ! 11:  ad6ca2fbef replay: use standard revision ranges
    @@ Documentation/git-replay.txt: git-replay - EXPERIMENTAL: Replay commits on a new
      
      DESCRIPTION
      -----------
    -@@ Documentation/git-replay.txt: DESCRIPTION
    - Takes a range of commits and replays them onto a new location. Leaves
    - the working tree and the index untouched, and updates no
    - references. The output of this command is meant to be used as input to
    + 
    +-Takes a range of commits, specified by <oldbase> and <branch>, and
    +-replays them onto a new location (see `--onto` option below). Leaves
    ++Takes ranges of commits and replays them onto a new location. Leaves
    + the working tree and the index untouched, and updates no references.
    + The output of this command is meant to be used as input to
     -`git update-ref --stdin`, which would update the relevant branches.
     +`git update-ref --stdin`, which would update the relevant branches
     +(see the OUTPUT section below).
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct merge_options merge_opt;
        struct merge_result result;
     -  struct strbuf branch_name = STRBUF_INIT;
    -   int i, ret = 0;
    +   int ret = 0;
      
        const char * const replay_usage[] = {
     -          N_("git replay --onto <newbase> <oldbase> <branch> # EXPERIMENTAL"),
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
     -  strvec_pushl(&rev_walk_args, "", argv[2], "--not", argv[1], NULL);
     -
        /*
    -    * TODO: For now, let's warn when we see an option that we are
    -    * going to override after setup_revisions() below. In the
    +    * Set desired values for rev walking options here. If they
    +    * are changed by some user specified option in setup_revisions()
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    -                   warning(_("option '%s' will be overridden"), argv[i]);
    -   }
    +   revs.topo_order = 1;
    +   revs.simplify_history = 0;
      
     -  if (setup_revisions(rev_walk_args.nr, rev_walk_args.v, &revs, NULL) > 1) {
     -          ret = error(_("unhandled options"));
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        }
      
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    -   revs.topo_order = 1;
    -   revs.simplify_history = 0;
    +           revs.simplify_history = 0;
    +   }
      
     -  strvec_clear(&rev_walk_args);
     -
12:  cca8105382 ! 12:  081864ed5f replay: add --advance or 'cherry-pick' mode
    @@ builtin/replay.c: static struct commit *pick_regular_commit(struct commit *pickm
        struct merge_options merge_opt;
        struct merge_result result;
     +  struct strset *update_refs = NULL;
    -   int i, ret = 0;
    +   int ret = 0;
      
        const char * const replay_usage[] = {
     -          N_("git replay --onto <newbase> <revision-range>... # EXPERIMENTAL"),
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
      
        /*
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    -   revs.topo_order = 1;
    -   revs.simplify_history = 0;
    +           revs.simplify_history = 0;
    +   }
      
     +  determine_replay_mode(&revs.cmdline, onto_name, &advance_name,
     +                        &onto, &update_refs);
13:  92287a2cc8 ! 13:  19c4016c7c replay: add --contained to rebase contained branches
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct rev_info revs;
        struct commit *last_commit = NULL;
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)
    -   int i, ret = 0;
    +   int ret = 0;
      
        const char * const replay_usage[] = {
     -          N_("git replay (--onto <newbase> | --advance <branch>) <revision-range>... # EXPERIMENTAL"),
14:  529a7fda40 ! 14:  29556bcc86 replay: stop assuming replayed branches do not diverge
    @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix
        struct merge_result result;
        struct strset *update_refs = NULL;
     +  kh_oid_map_t *replayed_commits;
    -   int i, ret = 0;
    +   int ret = 0;
      
        const char * const replay_usage[] = {
     @@ builtin/replay.c: int cmd_replay(int argc, const char **argv, const char *prefix)


Elijah Newren (14):
  t6429: remove switching aspects of fast-rebase
  replay: introduce new builtin
  replay: start using parse_options API
  replay: die() instead of failing assert()
  replay: introduce pick_regular_commit()
  replay: change rev walking options
  replay: add an important FIXME comment about gpg signing
  replay: remove progress and info output
  replay: remove HEAD related sanity check
  replay: make it a minimal server side command
  replay: use standard revision ranges
  replay: add --advance or 'cherry-pick' mode
  replay: add --contained to rebase contained branches
  replay: stop assuming replayed branches do not diverge

 .gitignore                               |   1 +
 Documentation/git-replay.txt             | 127 +++++++
 Makefile                                 |   2 +-
 builtin.h                                |   1 +
 builtin/replay.c                         | 445 +++++++++++++++++++++++
 command-list.txt                         |   1 +
 git.c                                    |   1 +
 t/helper/test-fast-rebase.c              | 241 ------------
 t/helper/test-tool.c                     |   1 -
 t/helper/test-tool.h                     |   1 -
 t/t3650-replay-basics.sh                 | 198 ++++++++++
 t/t6429-merge-sequence-rename-caching.sh |  45 ++-
 12 files changed, 800 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/git-replay.txt
 create mode 100644 builtin/replay.c
 delete mode 100644 t/helper/test-fast-rebase.c
 create mode 100755 t/t3650-replay-basics.sh


base-commit: dadef801b365989099a9929e995589e455c51fed
prerequisite-patch-id: 6df236178013b77ca82d22653c1ab78477e081ce
-- 
2.43.0.rc1.15.g29556bcc86

