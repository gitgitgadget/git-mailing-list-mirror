Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C7D23C8A0
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 06:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785567215; cv=none; b=JHNkKb4+F7NvOfUahmfpUALUkKS5+uq9L9nUcx/LIASmdLDtkv6aYc11lgI48kWwLEcffmA088oOGmWFXWE1mlMAPVNRj7fM2zzs01Ms9lxyzirk8TGn0Wwu7G4oqPAdNudMQiONhL7lmNQvifsQHyOdupP0SH8kbSQ/llJ5Zeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785567215; c=relaxed/simple;
	bh=CvJ+qDDA/ZKGiFM23PfL9jRtmGG6ElZo6Ho1yEsBkgs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=utxXat95LK0n1qGCQvKOspoZrudyGm8LdUm8eZ1nDovx6ZpMU8quIBCT8jFgn7W79xRFUi2oqdbCTDZNcRnq3H1zlbQ10Qw6T2B0dDnqyZLQWDaa9aHCDrrsXb8qYywMn3c+Ua8YTgJkEVffwC3jge7MaZ/fmqKdyAlYG5kwEQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cXbfrtfj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXbfrtfj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf27856f9cso17994485ad.2
        for <git@vger.kernel.org>; Fri, 31 Jul 2026 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785567212; x=1786172012; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T/joFhmKkyxUKFRQuw9G5gLkknQNjaA3X0e9LYGTIbg=;
        b=cXbfrtfjM68eCtkWgDXN3FICAUoxyFhOWaYaRPovR703j+KNGNFxBg1zfs/kx7yg7V
         vFufPK7IlOgXmDAcqQiUt9NQXJhB1Jup3fbE44qJaToL7hPNr3NGW2ojGkMFW3U817NS
         hqHi+plJ6QKcYLE0uQWDFVtzzLHyrcEA4GlQ2ZJ27/7olwSoZyaFBwsTLXMVjaemeYOW
         vvm6hJ6upMAf29aa6Ldpyf3V6eMOVxN9LPx54VU2UAEvLLwsrdxzQjCJTUYnEpW5hADg
         5BXOn73M5ZuPVD3bZ6b0WmvPVgottZcZRxGrc7rwNQLpWPzFM0ogZf4Cavgj33TbP53Z
         c5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785567212; x=1786172012;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T/joFhmKkyxUKFRQuw9G5gLkknQNjaA3X0e9LYGTIbg=;
        b=s4HrLhxpbWm5cKDHKm9Z37aCvTe4UAy9wAzZEfz9hQhYFZ14TrrxsfTyG+XhXiOYOu
         W2UudpF7U8zeLP6nwi/um6c2be80fsNkmbIvBvXwLcFXPyCOZz5/9YCNBlszIPcWatwt
         CO4p60HShVcPJDroxAiziD1O7htWBTwILDvusW1d+CSppzw8IMKEMnB3yGb1eqC6h2+q
         E3BaI7sVF7MGZeH0fOVgACiGjCfMCpbJKjDvSEoRPpayzRv+Wi6cA4HDWTDBgB0t77ms
         5XX5ag4MXqDUkKNS3XkYs35IKZMfUV1O6rwtVMM472aAq0Gnvl1N3P5i79x1MbvG8PVI
         V4cA==
X-Gm-Message-State: AOJu0YzEVdy895xNhSImX2qi+TCD/Mf3TmMcfT8SLNNpCbt4TV0npNC5
	cJfyqz6q0gTkNRvAiFC8teG9dnZ4AmP9Vsqnm2RKf8o91zdGzkecIoUjdB3Fbw==
X-Gm-Gg: AR+sD10L2xXQANoqLbX0B8iESopPt9ygB/HUISvcEFdUNezMTYzgJ+NAHkzJht5Mjf9
	2o+3q95rmn6RrGf8I9aMlHW6gh0DnDo7/PWCJte03L5FqQLC8Ji0CuIyvkHccnfWEWLIbRavMUc
	o5OhDTky3SRsTDYKwql4MsiIAx4dn61XUNiO3sSKUHuVL67awLhuo0z4X/FQS42Dp97wuOTcnBr
	K6kqw3/1Be+BFe3ALqgg1U7HoNUBWH0yLyTLA9/bW3JxolLX1xYWyNyS5Jn9BKQUhmeLEqg3Fw5
	w48HQRHt+Wgn4f3rxfDBkhfwavmwJvjk4ZMcNLUgGJJVdzisOOVv5/ur4uoIPqW2lmKA8q/eqhN
	gLqbdUOv9VzVTDy/KlhFln+hsn9Naw8v0AmaH+trWXHpypt4LWWbhwUkNXlQT3anWyAzDbJa9Te
	V8qybrDBIgVZX9X5ymoOhKlO1PeolbWIaIbM9scTgTaDeucDqNWJqhndX5BNPi4So=
X-Received: by 2002:a17:903:184e:b0:2d0:401c:2ebb with SMTP id d9443c01a7336-2d0521e93a3mr26144795ad.4.1785567211700;
        Fri, 31 Jul 2026 23:53:31 -0700 (PDT)
Received: from [127.0.0.1] ([52.190.138.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b165e99sm14491475ad.83.2026.07.31.23.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 23:53:30 -0700 (PDT)
Message-Id: <pull.2337.v11.git.git.1785567209.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
References: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 01 Aug 2026 06:53:25 +0000
Subject: [PATCH v11 0/4] history: add squash subcommand to fold a range
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Harald Nordgren <haraldnordgren@gmail.com>

Adds git history squash <revision-range> to fold a range of commits.

Changes in v11:

 * Make message editing the default with the autosquash-style template, add
   --no-edit instead of squash-specific --reedit-message.
 * Validate one actual boundary and tip, rejecting root-reaching and
   multi-tip ranges.
 * Protect only interior local branches, leaving tags and remote-tracking
   refs unchanged.
 * Move sequencer preparation before squash and fold the later
   message-editing patch into the feature commit.

Changes in v10:

 * Record the full revision expression in squash reflog.
 * Preserve the boundary-walk invariant when sanitizing rev-list options.
 * Clarify amend! and --reedit-message documentation.

Changes in v9:

 * Use the last amend! targeting the oldest folded commit as the default
   squashed message. Ignore amend! markers targeting later commits while
   selecting that replacement message.
 * Improve tests.

Changes in v8:

 * --reedit-message now builds the same editor template as git rebase -i
   --autosquash: fixup!, squash! and amend! commits are grouped under the
   commit they target instead of shown in commit order, and an amend!
   replaces its target's message.
 * A fixup!, squash! or amend! is refused only when its target is outside
   the range, so several fixups for an in-range commit fold together. A
   range that is entirely markers for one below-range target is combined
   into a single commit, keeping the last amend! message.
 * Merges inside the range are folded when the range has a single base, with
   no dedicated opt-in flag, --ancestry-path ensures only commits descended
   from the base are folded, and a range reaching more than one base is
   rejected.
 * Rev-list options are accepted and sanitized the way git replay does,
   forcing the walk order back with a warning, which also fixes git history
   squash -- --reverse slipping past the previous option check.
 * Kept this as an explicit squash subcommand rather than making
   --reedit-message the default or renaming the command.

Changes in v7:

 * --reedit-message now builds the same editor template git rebase -i shows
   for a squash (a combination of N commits banner with each folded message
   under its own header) and follows autosquash for markers: a fixup!
   message falls out (commented under a will be skipped header), while a
   squash! or amend! keeps its body with only the marker subject commented
   so its remark can be reworded in. Only the message text is affected,
   every commit's changes are always folded in.
 * Reuse git rebase -i's squash-message code: a preparatory sequencer:
   commit extracts the banner, header and marker-comment helpers so both
   rebase and git history squash build the identical template from one
   source.
 * Refuse a range whose oldest commit is a fixup!, squash! or amend!, since
   the marker's target cannot be inside the range.
 * Reorder the squash usage so dashed options come before <revision-range>,
   and spell out HEAD instead of @ in the documentation and examples.
 * Expand the squash commit message and documentation with this overview,
   and scope the merge limitation so it no longer contradicts squash folding
   a single-base interior merge.

Changes in v6:

 * git history squash now accepts multiple revision arguments, read like the
   arguments to git-rev-list, so a compound range such as @~3.. ^topic
   works.
 * The base to reparent onto is now the oldest in-range commit's parent; a
   boundary other than that base means the range has more than one base and
   is rejected. This also fixes the earlier overly-restrictive handling of
   merges and side branches.
 * A single-commit range (e.g. @^!) is rejected with "nothing to squash"
   (this also covers the @^!-style example that previously succeeded
   silently).
 * Commit messages reworded: the squash commit now gives an overview of
   fixup!/squash!/amend! handling, rewording, merge-parent and ref behavior.

Changes in v5:

 * The range walk now uses --ancestry-path, so only commits descended from
   the base are folded; a single revision such as HEAD or HEAD~1 is now
   rejected as "not a <base>..<tip> range" rather than treated as a squash
   down to the root.
 * This adopts the --ancestry-path suggestion; the multi-base rejection is
   unchanged, so a side branch that forked before the base and merged in is
   still refused.
 * Added tests covering more merge topologies: two interior merges, a nested
   merge, an octopus merge, an octopus arm forked before the base, a merge
   among the descendants replayed above the range, and a ref pointing at an
   interior merge commit.

Changes in v4:

 * git history squash now detects when another ref points at a commit inside
   the range being folded and refuses, with an advice.historyUpdateRefs hint
   to use --update-refs=head.
 * A merge inside the range is folded fine as long as the range has a single
   base; a range with merge commit at the tip or base also folds correctly.
   Only a range with more than one base is rejected.

Changes in v3:

 * Moved the feature out of git rebase and into a new git history squash
   <revision-range> subcommand, per the list discussion. git rebase --squash
   is dropped.
 * Takes an arbitrary range (git history squash @~3.., git history squash
   @~5..@~2), folding it into the oldest commit and replaying any
   descendants on top.
 * Implemented as a single tree operation rather than picking each commit,
   so there are no repeated conflict stops (addresses Phillip's efficiency
   point).
 * A merge inside the range is folded fine, only a range with more than one
   base is rejected.
 * --reedit-message seeds the editor with every folded-in message, not just
   the oldest.

Harald Nordgren (4):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  sequencer: share the squash message marker helpers and flags
  history: add squash subcommand to fold a range

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  57 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 578 +++++++++++++++++++++--
 sequencer.c                      |  70 +--
 sequencer.h                      |  30 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 758 +++++++++++++++++++++++++++++++
 9 files changed, 1429 insertions(+), 71 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 13c7afec212fc97ce257d15601659314c6673d6c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v11
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v11
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v10:

 1:  f848103497 = 1:  dd1deb5e5b history: extract helper for a commit's parent tree
 2:  49dadc3410 = 2:  7309f64485 history: give commit_tree_ext a message template
 4:  41156c9afb ! 3:  0762589e22 sequencer: share the squash message marker helpers and flags
     @@ Commit message
          todo_item_flags enum to the header, so a caller reading the output of
          todo_list_rearrange_squash() can tell an amend! (TODO_REPLACE_FIXUP_MSG)
          from a plain fixup!. A later change reuses all of this to give "git
     -    history squash --reedit-message" the same template.
     +    history squash" the same template.
      
          No change in behavior.
      
 3:  6b5b2c93f2 ! 4:  7abda3643c history: add squash subcommand to fold a range
     @@ Commit message
          a "git reset --soft" to the merge base followed by "git commit --amend".
      
          Add "git history squash <revision-range>" to do this directly. It folds
     -    every commit in the range into the oldest one, keeping that commit's
     -    authorship and taking the tree of the newest commit, then replays the
     -    commits above the range on top. The squashed message comes from the
     -    oldest commit by default, or from the body of the last amend! commit
     -    targeting it. An editor opens with the selected message when
     -    --reedit-message is given. A fixup!, squash! or amend! commit is refused
     -    unless the commit it targets is also in the range, so the fold does not
     -    silently absorb a marker meant for a commit outside it. The check runs
     -    the range through todo_list_rearrange_squash(), which leaves such a
     -    marker as a plain pick. Markers whose target is in the range fold in as
     -    usual. As an exception, a range made up entirely of markers for one
     -    target is combined anyway, taking its message from the last amend! if
     -    there is one, so a batch of fixups for the same commit can be collapsed.
     +    every commit in the range into one commit, preserving the authorship of
     +    the oldest commit and taking the tree of the tip, then replays commits
     +    above the range. The editor opens with every folded message in the same
     +    template used by "git rebase -i --autosquash". With --no-edit, the
     +    oldest message is kept, or the last amend! replacement that targets it.
     +
     +    A fixup!, squash! or amend! commit is refused unless its target is also
     +    in the range, so the fold does not silently absorb a marker intended for
     +    another commit. As an exception, a range made up entirely of markers for
     +    one target is combined, allowing a batch of related fixups to be
     +    consolidated.
      
          The range is read like the arguments to "git rev-list", so several
          revisions such as "HEAD~3..HEAD ^topic" may be given, and rev-list
     -    options are accepted too. As "git replay" does, the walk options the fold
     -    relies on are forced after setup_revisions() and a warning is printed if
     -    an option changed them, so the first commit returned is the range's
     -    oldest and its parent is the base regardless of what the user passed
     -    (including after a "--"). A merge inside the range is folded when its
     -    other parent is reachable from the base, otherwise the range has more
     -    than one base and is rejected. By default the command also refuses when a
     -    ref points at a commit that the fold would discard. Use --update-refs=head
     -    to rewrite only the current branch instead.
     +    options are accepted too. Walk-order options needed by the fold are
     +    restored after setup_revisions(), with a warning when an option changed
     +    them. The selected graph must have one actual boundary and one actual
     +    tip and must not reach a root. A merge inside the range is folded when
     +    all selected history reaches the same boundary; otherwise the range has
     +    more than one base and is rejected.
     +
     +    By default the command refuses when a local branch points inside the
     +    range, because that branch cannot be replayed as a descendant of the
     +    result. Tags and remote-tracking refs are left unchanged. Use
     +    --update-refs=head to leave interior branches unchanged as well.
      
          Inspired-by: Sergey Chernov <serega.morph@gmail.com>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
     @@ Documentation/git-history.adoc: git history drop <commit> [--dry-run] [--update-
       git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
       git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
       git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
     -+git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>
     ++git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
       
       DESCRIPTION
       -----------
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +already on `topic`. Rev-list options may also be given, but any that would
      +change how the range is walked are overridden with a warning.
      ++
     -+The oldest commit's message is preserved by default, except that an `amend!`
     -+commit targeting it replaces its message. Specify `--reedit-message` to edit
     -+the resulting message. A merge commit inside the range is folded like any
     -+other, but the range must have a single base, so a range that reaches more
     ++An editor opens pre-filled with the messages of all the folded commits so
     ++you can combine them. With `--no-edit`, the oldest commit's message is
     ++preserved instead, except that an `amend!` commit targeting it replaces its
     ++message. A merge commit inside the range is folded like any other, but the
     ++range must have a single base and a single tip. A range that reaches more
      +than one entry point (for example a side branch that forked before the range
     -+and was later merged into it) is rejected.
     ++and was later merged into it), or that selects two unmerged tips, is rejected.
      ++
      +A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
      +targets is also in the range, so the fold does not silently absorb a
      +marker meant for a commit outside it. As an exception, a range made up entirely
     -+of markers for one target is combined into a single commit, keeping the last
     -+`amend!` message if there is one.
     ++of markers for one target is combined into a single commit. With `--no-edit`,
     ++the last `amend!` message is used if there is one.
      ++
     -+A branch or tag that points at a commit inside the range would be left
     -+dangling once those commits are folded away, so with the default
     -+`--update-refs=branches` the command refuses. Rerun with
     -+`--update-refs=head` to rewrite only the current branch and leave such
     -+refs pointing at the old commits.
     ++The template mirrors `git rebase -i --autosquash`: each `fixup!`, `squash!`,
     ++or `amend!` is grouped under the commit it targets rather than shown in
     ++commit order. A `fixup!` message is dropped (commented out in full), a
     ++`squash!` keeps its body with only the marker subject commented, and an
     ++`amend!` replaces its target's message, unless a `squash!` folded into that
     ++target first, in which case it keeps its body like a `squash!`.
     +++
     ++A local branch that points at a commit inside the range cannot be rewritten
     ++as a descendant of the result, so with the default `--update-refs=branches`
     ++the command refuses. Rerun with `--update-refs=head` to rewrite only the
     ++current branch and leave such branches pointing at the old commits. Tags and
     ++remote-tracking refs are always left unchanged.
      +
       OPTIONS
       -------
       
      @@ Documentation/git-history.adoc: OPTIONS
     + 	objects will be written into the repository, so applying these printed
       	ref updates is generally safe.
       
     ++`--edit`::
     ++`--no-edit`::
     ++	For `squash`, open an editor to combine the messages of the folded commits.
     ++	This is the default; use `--no-edit` to keep the selected message
     ++	without opening an editor.
     ++
       `--reedit-message`::
     --	Open an editor to modify the target commit's message.
     -+	Open an editor to modify the rewritten commit's message.
     + 	Open an editor to modify the target commit's message.
       
     - `--empty=(drop|keep|abort)`::
     - 	Control what happens when a commit becomes empty as a result of the
      
       ## advice.c ##
      @@ advice.c: static struct {
     @@ builtin/history.c
       #define GIT_HISTORY_SPLIT_USAGE \
       	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
      +#define GIT_HISTORY_SQUASH_USAGE \
     -+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--reedit-message] <revision-range>")
     ++	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
       
       static void change_data_free(void *util, const char *str UNUSED)
       {
     @@ builtin/history.c: out:
      +{
      +	struct rev_info revs;
      +	struct commit *commit, *base = NULL, *oldest = NULL, *tip = NULL;
     -+	struct commit_list *boundaries = NULL, *b;
     ++	struct commit_list *boundaries = NULL, *commits = NULL, *iter,
     ++		**commits_tail = &commits;
     ++	struct oidset selected = OIDSET_INIT, has_children = OIDSET_INIT;
      +	struct strvec args = STRVEC_INIT;
     ++	bool reaches_root = false;
      +	size_t i;
      +	int ret;
      +
     @@ builtin/history.c: out:
      +		revs.boundary = 1;
      +	}
      +
     -+	/*
     -+	 * A squash needs a base to reparent onto, so the range has to exclude
     -+	 * something, as in "<base>..<tip>". A revision range with no such
     -+	 * bottom commit cannot be squashed.
     -+	 */
     ++	/* A squash range must name a bottom revision to reparent onto. */
      +	for (i = 0; i < revs.cmdline.nr; i++)
     -+		if (revs.cmdline.rev[i].flags & UNINTERESTING)
     ++		if (revs.cmdline.rev[i].flags & BOTTOM)
      +			break;
      +	if (i == revs.cmdline.nr) {
      +		ret = error(_("not a '<base>..<tip>' revision range"));
     @@ builtin/history.c: out:
      +		goto out;
      +	}
      +
     -+	/*
     -+	 * Set boundary commits aside for the base check below, and put every
     -+	 * in-range commit but the tip into the interior set. A ref pointing
     -+	 * at an interior commit would dangle once the range is folded away.
     -+	 */
     ++	/* Set boundary commits aside for the base check below. */
      +	while ((commit = get_revision(&revs))) {
      +		if (commit->object.flags & BOUNDARY) {
      +			commit_list_insert(commit, &boundaries);
     @@ builtin/history.c: out:
      +		}
      +		if (!oldest)
      +			oldest = commit;
     -+		if (tip)
     -+			oidset_insert(interior_out, &tip->object.oid);
     -+		tip = commit;
     ++		oidset_insert(&selected, &commit->object.oid);
     ++		commits_tail = commit_list_append(commit, commits_tail);
      +	}
      +
      +	if (!oldest) {
      +		ret = error(_("the revision range is empty"));
      +		goto out;
     -+	} else if (oldest == tip) {
     ++	} else if (!commits->next) {
      +		ret = error(_("the revision range holds a single commit; "
      +			      "nothing to squash"));
      +		goto out;
     -+	} else if (!oldest->parents) {
     -+		BUG("an in-range commit must have a parent");
      +	}
     -+	base = oldest->parents->item;
      +
      +	/*
     -+	 * A boundary other than the base is an in-range commit reaching a
     -+	 * commit outside the range, so the range has more than one base.
     ++	 * Find the selected commits that have selected children. The only
     ++	 * remaining commit must be the tip whose tree becomes the result.
      +	 */
     -+	for (b = boundaries; b; b = b->next) {
     -+		if (b->item != base) {
     ++	for (iter = commits; iter; iter = iter->next) {
     ++		struct commit_list *p;
     ++
     ++		if (!iter->item->parents)
     ++			reaches_root = true;
     ++		for (p = iter->item->parents; p; p = p->next)
     ++			if (oidset_contains(&selected, &p->item->object.oid))
     ++				oidset_insert(&has_children,
     ++					      &p->item->object.oid);
     ++	}
     ++	if (reaches_root) {
     ++		ret = error(_("the revision range reaches a root commit; "
     ++			      "cannot squash"));
     ++		goto out;
     ++	}
     ++	for (iter = commits; iter; iter = iter->next) {
     ++		if (oidset_contains(&has_children, &iter->item->object.oid))
     ++			continue;
     ++		if (tip) {
     ++			ret = error(_("the revision range has more than one tip; "
     ++				      "cannot squash"));
     ++			goto out;
     ++		}
     ++		tip = iter->item;
     ++	}
     ++
     ++	/* The range must reach exactly one commit outside it. */
     ++	if (!boundaries) {
     ++		ret = error(_("the revision range has no base; cannot squash"));
     ++		goto out;
     ++	}
     ++	base = boundaries->item;
     ++	for (iter = boundaries; iter; iter = iter->next) {
     ++		if (iter->item != base) {
      +			ret = error(_("the revision range has more than one base; "
      +				      "cannot squash"));
      +			goto out;
      +		}
      +	}
      +
     ++	for (iter = commits; iter; iter = iter->next)
     ++		if (iter->item != tip)
     ++			oidset_insert(interior_out, &iter->item->object.oid);
     ++
      +	*base_out = base;
      +	*oldest_out = oldest;
      +	*tip_out = tip;
     @@ builtin/history.c: out:
      +
      +out:
      +	commit_list_free(boundaries);
     ++	commit_list_free(commits);
     ++	oidset_clear(&selected);
     ++	oidset_clear(&has_children);
      +	reset_revision_walk();
      +	release_revisions(&revs);
      +	strvec_clear(&args);
     @@ builtin/history.c: out:
      +static int reject_dangling_fixups(struct repository *repo,
      +				  struct commit *base,
      +				  struct commit *tip,
     -+				  struct commit *oldest,
     -+				  struct commit **msg_source,
      +				  struct commit **amend_source)
      +{
      +	struct todo_list todo = TODO_LIST_INIT;
     @@ builtin/history.c: out:
      +	bool past_oldest_group = false;
      +	int i, ret, nr_dangling = 0;
      +
     -+	*msg_source = oldest;
      +	*amend_source = NULL;
      +
      +	repo_init_revisions(repo, &revs, NULL);
     @@ builtin/history.c: out:
      +			      "range"), dangling_subject);
      +	} else {
      +		if (last_amend)
     -+			*msg_source = last_amend;
     ++			*amend_source = last_amend;
      +		ret = 0;
      +	}
      +
     @@ builtin/history.c: out:
      +	return 0;
      +}
      +
     ++static bool amend_replaces_target(struct todo_list *todo, int target)
     ++{
     ++	int i;
     ++
     ++	for (i = target + 1; i < todo->nr &&
     ++			     todo->items[i].command != TODO_PICK; i++) {
     ++		if (todo->items[i].command == TODO_SQUASH)
     ++			return false;
     ++		if (todo->items[i].flags & TODO_REPLACE_FIXUP_MSG)
     ++			return true;
     ++	}
     ++	return false;
     ++}
     ++
     ++static int build_squash_message(struct repository *repo,
     ++				struct commit *base,
     ++				struct commit *tip,
     ++				struct strbuf *out)
     ++{
     ++	struct rev_info revs;
     ++	struct commit *commit;
     ++	struct strvec args = STRVEC_INIT;
     ++	struct todo_list todo = TODO_LIST_INIT;
     ++	struct replay_opts opts = REPLAY_OPTS_INIT;
     ++	int i, nr_commits, ret;
     ++
     ++	repo_init_revisions(repo, &revs, NULL);
     ++	strvec_push(&args, "ignored");
     ++	strvec_push(&args, "--reverse");
     ++	strvec_push(&args, "--topo-order");
     ++	strvec_pushf(&args, "%s..%s", oid_to_hex(&base->object.oid),
     ++		     oid_to_hex(&tip->object.oid));
     ++	setup_revisions_from_strvec(&args, &revs, NULL);
     ++
     ++	if (prepare_revision_walk(&revs) < 0) {
     ++		ret = error(_("error preparing revisions"));
     ++		goto out;
     ++	}
     ++
     ++	while ((commit = get_revision(&revs)))
     ++		strbuf_addf(&todo.buf, "pick %s\n",
     ++			    oid_to_hex(&commit->object.oid));
     ++
     ++	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
     ++	    todo_list_rearrange_squash(&todo) < 0) {
     ++		ret = error(_("could not prepare the squash message"));
     ++		goto out;
     ++	}
     ++
     ++	nr_commits = todo.nr;
     ++	for (i = 0; i < nr_commits; i++) {
     ++		struct todo_item *item = &todo.items[i];
     ++		const char *message, *body;
     ++		size_t commented_len;
     ++		bool skip, squashing;
     ++
     ++		squashing = item->command == TODO_SQUASH ||
     ++			    (item->flags & TODO_REPLACE_FIXUP_MSG);
     ++		if (item->command == TODO_PICK)
     ++			skip = amend_replaces_target(&todo, i);
     ++		else
     ++			skip = !squashing;
     ++
     ++		message = repo_logmsg_reencode(repo, item->commit, NULL, NULL);
     ++		find_commit_subject(message, &body);
     ++
     ++		if (skip)
     ++			commented_len = strlen(body);
     ++		else if (squashing)
     ++			commented_len = squash_subject_comment_len(body, 1);
     ++		else
     ++			commented_len = 0;
     ++
     ++		if (!i)
     ++			add_squash_combination_header(out, nr_commits);
     ++		strbuf_addch(out, '\n');
     ++		add_squash_message_header(out, i + 1, skip);
     ++		strbuf_addstr(out, "\n\n");
     ++		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
     ++		strbuf_addstr(out, body + commented_len);
     ++		strbuf_complete_line(out);
     ++
     ++		repo_unuse_commit_buffer(repo, item->commit, message);
     ++	}
     ++
     ++	ret = 0;
     ++
     ++out:
     ++	todo_list_release(&todo);
     ++	replay_opts_release(&opts);
     ++	reset_revision_walk();
     ++	release_revisions(&revs);
     ++	strvec_clear(&args);
     ++	return ret;
     ++}
     ++
      +static int cmd_history_squash(int argc,
      +			      const char **argv,
      +			      const char *prefix,
     @@ builtin/history.c: out:
      +	enum ref_action action = REF_ACTION_DEFAULT;
      +	enum commit_tree_flags flags = 0;
      +	int dry_run = 0;
     ++	int edit = 1;
      +	struct option options[] = {
      +		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
      +			       N_("control which refs should be updated"),
      +			       PARSE_OPT_NONEG, parse_ref_action),
      +		OPT_BOOL('n', "dry-run", &dry_run,
      +			 N_("perform a dry-run without updating any refs")),
     -+		OPT_BIT(0, "reedit-message", &flags,
     -+			N_("open an editor to modify the commit message"),
     -+			COMMIT_TREE_EDIT_MESSAGE),
     ++		OPT_BOOL('e', "edit", &edit,
     ++			 N_("edit the commit message")),
      +		OPT_END(),
      +	};
      +	struct strbuf reflog_msg = STRBUF_INIT;
      +	struct strbuf message = STRBUF_INIT;
      +	struct oidset interior = OIDSET_INIT;
     -+	struct commit *base, *oldest, *tip, *rewritten, *msg_source,
     -+		*amend_source;
     ++	struct commit *base = NULL, *oldest = NULL, *tip = NULL, *rewritten,
     ++		*amend_source = NULL;
      +	const struct object_id *base_tree_oid, *tip_tree_oid;
      +	const char *message_template = NULL;
      +	struct commit_list *parents = NULL;
     @@ builtin/history.c: out:
      +	if (ret < 0)
      +		goto out;
      +
     -+	ret = reject_dangling_fixups(repo, base, tip, oldest, &msg_source,
     -+				     &amend_source);
     ++	ret = reject_dangling_fixups(repo, base, tip, &amend_source);
      +	if (ret < 0)
      +		goto out;
     -+	if (amend_source) {
     ++	if (!edit && amend_source) {
      +		const char *amend_message, *body;
      +
      +		amend_message = repo_logmsg_reencode(repo, amend_source,
     @@ builtin/history.c: out:
      +	if (action == REF_ACTION_BRANCHES) {
      +		struct interior_ref_cb cb = { .interior = &interior };
      +
     -+		refs_for_each_ref(get_main_ref_store(repo),
     -+				  find_interior_ref, &cb);
     ++		refs_for_each_branch_ref(get_main_ref_store(repo),
     ++					 find_interior_ref, &cb);
      +		if (cb.name) {
      +			ret = error(_("'%s' points into the squashed range"),
      +				    cb.name);
     @@ builtin/history.c: out:
      +		}
      +	}
      +
     ++	if (edit) {
     ++		ret = build_squash_message(repo, base, tip, &message);
     ++		if (ret < 0)
     ++			goto out;
     ++		message_template = message.buf;
     ++		flags |= COMMIT_TREE_EDIT_MESSAGE;
     ++	}
     ++
      +	ret = setup_revwalk(repo, action, tip, &revs);
      +	if (ret < 0)
      +		goto out;
     @@ builtin/history.c: out:
      +	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
      +	commit_list_append(base, &parents);
      +
     -+	ret = commit_tree_ext(repo, "squash", msg_source, message_template,
     ++	ret = commit_tree_ext(repo, "squash", oldest, message_template,
      +			      parents,
      +			      base_tree_oid, tip_tree_oid, &rewritten, flags);
      +	if (ret < 0) {
     @@ t/t3455-history-squash.sh (new)
      +test_expect_success 'setup linear history touching two files' '
      +	test_commit base file a &&
      +	git tag start &&
     -+	test_commit --no-tag one other x &&
     ++	GIT_AUTHOR_NAME=Squasher GIT_AUTHOR_EMAIL=squash@example.com \
     ++		test_commit --no-tag one other x &&
      +	test_commit --no-tag two file c &&
      +	test_commit three file d
      +'
     @@ t/t3455-history-squash.sh (new)
      +	git branch -f keep HEAD~2 &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash start..HEAD ^keep &&
     ++	git history squash --no-edit start..HEAD ^keep &&
      +
      +	git reflog -1 --format=%gs >actual &&
      +	echo "squash: updating start..HEAD ^keep" >expect &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D keep
      +'
      +
     ++test_expect_success 'refuses a range with more than one tip' '
     ++	git reset --hard start &&
     ++	main=$(git symbolic-ref --short HEAD) &&
     ++	test_commit --no-tag main-one file b &&
     ++	test_commit --no-tag main-two file c &&
     ++	git checkout -b other-tip start &&
     ++	test_commit --no-tag other-tip other d &&
     ++	git checkout "$main" &&
     ++	main_before=$(git rev-parse HEAD) &&
     ++	other_before=$(git rev-parse other-tip) &&
     ++
     ++	test_must_fail git history squash ^start HEAD other-tip 2>err &&
     ++	test_grep "more than one tip" err &&
     ++	test_cmp_rev "$main_before" HEAD &&
     ++	test_cmp_rev "$other_before" other-tip &&
     ++
     ++	git branch -D other-tip
     ++'
     ++
     ++test_expect_success 'refuses a range that reaches a root commit' '
     ++	git reset --hard three &&
     ++	root=$(printf "unrelated root\n" |
     ++		git commit-tree "$(git rev-parse HEAD^{tree})") &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash --ancestry-path="$root" \
     ++		^start HEAD "$root" 2>err &&
     ++	test_grep "reaches a root commit" err &&
     ++	test_cmp_rev "$head_before" HEAD
     ++'
     ++
      +test_expect_success 'squashes a branch the current branch is not on' '
      +	git reset --hard three &&
      +	main=$(git symbolic-ref --short HEAD) &&
     @@ t/t3455-history-squash.sh (new)
      +	test_commit --no-tag off-two off b &&
      +	git checkout "$main" &&
      +
     -+	git history squash start..off-history &&
     ++	git history squash --no-edit start..off-history &&
      +
      +	check_commit_count start..off-history 1 &&
      +	test_cmp_rev "$head_before" HEAD &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D off-history
      +'
      +
     -+test_expect_success 'squashes a range into a single commit without changing the tree' '
     ++test_expect_success 'squashes a range preserving its tree and oldest authorship' '
      +	git reset --hard three &&
      +	head_before=$(git rev-parse HEAD) &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
     @@ t/t3455-history-squash.sh (new)
      +	check_log_subjects -1 <<-\EOF &&
      +	one
      +	EOF
     ++	git log -1 --format="%an <%ae>" >actual &&
     ++	echo "Squasher <squash@example.com>" >expect &&
     ++	test_cmp expect actual &&
      +	git reflog >reflog &&
      +	test_grep "squash: updating" reflog
      +'
     @@ t/t3455-history-squash.sh (new)
      +	git reset --hard three &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash --date-order start.. 2>err &&
     ++	git history squash --no-edit --date-order start.. 2>err &&
      +	test_grep "ignoring rev-list options" err &&
      +	test_cmp_rev start HEAD^ &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
      +
      +	git reset --hard three &&
     -+	git history squash -- --reverse start.. 2>err &&
     ++	git history squash --no-edit -- --reverse start.. 2>err &&
      +	test_grep "ignoring rev-list options" err &&
      +	test_cmp_rev start HEAD^ &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
     @@ t/t3455-history-squash.sh (new)
      +	git reset --hard three &&
      +	final_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash start..@~1 &&
     ++	git history squash --no-edit start..@~1 &&
      +
      +	check_log_subjects start..HEAD <<-\EOF &&
      +	three
     @@ t/t3455-history-squash.sh (new)
      +	root=$(git rev-list --max-parents=0 HEAD) &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash "$root.." &&
     ++	git history squash --no-edit "$root.." &&
      +
      +	check_commit_count "$root..HEAD" 1 &&
      +	test_cmp_rev "$root" HEAD^ &&
     @@ t/t3455-history-squash.sh (new)
      +	git commit --allow-empty -m "fixup! target" &&
      +	test_commit --no-tag later file c &&
      +
     -+	git history squash start.. &&
     ++	git history squash --no-edit start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
      +	check_log_subjects -1 <<-\EOF
     @@ t/t3455-history-squash.sh (new)
      +	stage_file b && git commit -m "fixup! base" &&
      +	stage_file c && git commit -m "fixup! base" &&
      +
     -+	git history squash start.. &&
     ++	git history squash --no-edit start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
      +	check_log_subjects -1 <<-\EOF
     @@ t/t3455-history-squash.sh (new)
      +	EOF
      +'
      +
     -+test_expect_success 'combining below-range fixups keeps the last amend! message' '
     ++test_expect_success 'combining below-range markers offers every message' '
      +	git reset --hard start &&
      +	stage_file b && git commit -m "fixup! base" &&
      +	stage_file c &&
     @@ t/t3455-history-squash.sh (new)
      +
      +	check_commit_count start..HEAD 1 &&
      +	check_log_messages -1 <<-\EOF
     ++	fixup! base
     ++
      +	amend! base
      +
      +	amended body
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp_rev "$head_before" HEAD
      +'
      +
     -+test_expect_success 'the last amend! for the oldest commit replaces its message' '
     ++test_expect_success 'does not discard squash! or amend! message bodies' '
      +	git reset --hard start &&
      +	test_commit --no-tag marker-oldest file b &&
      +	git commit --allow-empty -m "squash! marker-oldest" &&
     @@ t/t3455-history-squash.sh (new)
      +
      +	check_commit_count start..HEAD 1 &&
      +	check_log_messages -1 <<-\EOF
     ++	marker-oldest
     ++
     ++	earlier message
     ++
      +	amended subject
      +
      +	amended body
      +
     ++	wrong message
     ++
      +	EOF
      +'
      +
     -+test_expect_success 'preserves authorship of the oldest commit' '
     ++test_expect_success '--no-edit keeps the selected message without an editor' '
      +	git reset --hard start &&
     -+	GIT_AUTHOR_NAME=Squasher GIT_AUTHOR_EMAIL=squash@example.com \
     -+		test_commit --no-tag oldest file b &&
     -+	test_commit newest file c &&
     ++	test_commit --no-tag no-edit-target file b &&
     ++	git commit --allow-empty -m "squash! no-edit-target" &&
     ++	commit_with_message "amend! no-edit-target\n\namended subject\n\namended body\n" &&
     ++
     ++	write_script editor <<-\EOF &&
     ++	exit 1
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
     ++	git history squash --no-edit start.. &&
     ++
     ++	check_log_messages -1 <<-\EOF &&
     ++	amended subject
     ++
     ++	amended body
     ++
     ++	EOF
     ++	test_set_editor :
     ++'
     ++
     ++test_expect_success 'edits every message and aborts on an empty result' '
     ++	git reset --hard start &&
     ++	stage_file b &&
     ++	git commit -m "re-one subject" -m "re-one body line" &&
     ++	test_commit --no-tag re-two file c &&
     ++	test_commit re-three file d &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	write_script empty-editor <<-\EOF &&
     ++	>"$1"
     ++	EOF
     ++	test_set_editor "$(pwd)/empty-editor" &&
     ++	test_must_fail git history squash start.. 2>err &&
     ++	test_grep "Aborting commit due to empty commit message" err &&
     ++	test_cmp_rev "$head_before" HEAD &&
      +
     ++	write_script editor <<-\EOF &&
     ++	cat "$1" >edited &&
     ++	echo combined >"$1"
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
      +	git history squash start.. &&
      +
     -+	git log -1 --format="%an <%ae>" >actual &&
     -+	echo "Squasher <squash@example.com>" >expect &&
     -+	test_cmp expect actual
     ++	cat >expect <<-EOF &&
     ++	# This is a combination of 3 commits.
     ++	# This is the 1st commit message:
     ++
     ++	re-one subject
     ++
     ++	re-one body line
     ++
     ++	# This is the commit message #2:
     ++
     ++	re-two
     ++
     ++	# This is the commit message #3:
     ++
     ++	re-three
     ++
     ++	# Please enter the commit message for the squash changes. Lines starting
     ++	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     ++	# Changes to be committed:
     ++	#	modified:   file
     ++	#
     ++	EOF
     ++	test_cmp expect edited &&
     ++	check_log_subjects -1 <<-\EOF
     ++	combined
     ++	EOF
      +'
      +
     -+test_expect_success '--update-refs=head only moves HEAD' '
     -+	git reset --hard three &&
     -+	git branch -f other HEAD &&
     -+	other_before=$(git rev-parse other) &&
     ++test_expect_success 'handles fixup!, squash! and amend! messages like rebase' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag mark-base file b &&
     ++	stage_file c &&
     ++	commit_with_message "fixup! mark-base\n\nfixup body\n" &&
     ++	stage_file d &&
     ++	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
     ++	stage_file e &&
     ++	commit_with_message "amend! mark-base\n\namended message\n" &&
     ++
     ++	write_script editor <<-\EOF &&
     ++	cat "$1" >edited
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
     ++	git history squash start.. &&
      +
     -+	git history squash --update-refs=head start.. &&
     ++	cat >expect <<-EOF &&
     ++	# This is a combination of 4 commits.
     ++	# This is the 1st commit message:
      +
     -+	check_commit_count start..HEAD 1 &&
     -+	test_cmp_rev "$other_before" other
     ++	mark-base
     ++
     ++	# The commit message #2 will be skipped:
     ++
     ++	# fixup! mark-base
     ++	#
     ++	# fixup body
     ++
     ++	# This is the commit message #3:
     ++
     ++	# squash! mark-base
     ++
     ++	squash remark
     ++
     ++	# This is the commit message #4:
     ++
     ++	# amend! mark-base
     ++
     ++	amended message
     ++
     ++	# Please enter the commit message for the squash changes. Lines starting
     ++	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     ++	# Changes to be committed:
     ++	#	modified:   file
     ++	#
     ++	EOF
     ++	test_cmp expect edited &&
     ++	check_log_messages -1 <<-\EOF
     ++	mark-base
     ++
     ++	squash remark
     ++
     ++	amended message
     ++
     ++	EOF
     ++'
     ++
     ++test_expect_success 'groups fixups under their targets in the editor' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag alpha file a1 &&
     ++	test_commit --no-tag beta file b1 &&
     ++	stage_file a2 &&
     ++	commit_with_message "fixup! alpha\n" &&
     ++	stage_file b2 &&
     ++	commit_with_message "fixup! beta\n" &&
     ++
     ++	write_script editor <<-\EOF &&
     ++	cat "$1" >edited
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
     ++	git history squash start.. &&
     ++
     ++	cat >expect <<-EOF &&
     ++	# This is a combination of 4 commits.
     ++	# This is the 1st commit message:
     ++
     ++	alpha
     ++
     ++	# The commit message #2 will be skipped:
     ++
     ++	# fixup! alpha
     ++
     ++	# This is the commit message #3:
     ++
     ++	beta
     ++
     ++	# The commit message #4 will be skipped:
     ++
     ++	# fixup! beta
     ++
     ++	# Please enter the commit message for the squash changes. Lines starting
     ++	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     ++	# Changes to be committed:
     ++	#	modified:   file
     ++	#
     ++	EOF
     ++	test_cmp expect edited
     ++'
     ++
     ++test_expect_success 'lets amend! replace its target message in the editor' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag mark-base file b &&
     ++	stage_file c &&
     ++	commit_with_message "amend! mark-base\n\namended message\n" &&
     ++	stage_file d &&
     ++	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
     ++
     ++	write_script editor <<-\EOF &&
     ++	cat "$1" >edited
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
     ++	git history squash start.. &&
     ++
     ++	cat >expect <<-EOF &&
     ++	# This is a combination of 3 commits.
     ++	# The 1st commit message will be skipped:
     ++
     ++	# mark-base
     ++
     ++	# This is the commit message #2:
     ++
     ++	# amend! mark-base
     ++
     ++	amended message
     ++
     ++	# This is the commit message #3:
     ++
     ++	# squash! mark-base
     ++
     ++	squash remark
     ++
     ++	# Please enter the commit message for the squash changes. Lines starting
     ++	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     ++	# Changes to be committed:
     ++	#	modified:   file
     ++	#
     ++	EOF
     ++	test_cmp expect edited &&
     ++	check_log_messages -1 <<-\EOF
     ++	amended message
     ++
     ++	squash remark
     ++
     ++	EOF
      +'
      +
     -+test_expect_success 'refuses to fold a range a ref points into' '
     ++test_expect_success 'handles branches pointing at the squashed range' '
      +	git reset --hard three &&
     ++	git branch -f other HEAD &&
      +	git branch -f mid HEAD~1 &&
     ++	other_before=$(git rev-parse other) &&
     ++	mid_before=$(git rev-parse mid) &&
      +	head_before=$(git rev-parse HEAD) &&
      +
      +	test_must_fail git history squash start.. 2>err &&
     @@ t/t3455-history-squash.sh (new)
      +	test_grep "hint: .*--update-refs=head" err &&
      +	test_cmp_rev "$head_before" HEAD &&
      +
     -+	git branch -D mid
     -+'
     -+
     -+test_expect_success 'advice.historyUpdateRefs silences the hint' '
     -+	git reset --hard three &&
     -+	git branch -f mid HEAD~1 &&
     -+	head_before=$(git rev-parse HEAD) &&
     -+
      +	test_must_fail git -c advice.historyUpdateRefs=false \
      +		history squash start.. 2>err &&
      +	test_grep "points into the squashed range" err &&
      +	test_grep ! "hint:" err &&
      +	test_cmp_rev "$head_before" HEAD &&
      +
     -+	git branch -D mid
     -+'
     -+
     -+test_expect_success '--update-refs=head folds past a ref pointing into the range' '
     -+	git reset --hard three &&
     -+	git branch -f mid HEAD~1 &&
     -+	mid_before=$(git rev-parse mid) &&
     -+
     -+	git history squash --update-refs=head start.. &&
     ++	git history squash --no-edit --update-refs=head start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
     ++	test_cmp_rev "$other_before" other &&
      +	test_cmp_rev "$mid_before" mid &&
      +
     -+	git branch -D mid
     ++	git branch -D other mid
      +'
      +
     -+test_expect_success 'refuses to fold a range a tag points into' '
     ++test_expect_success 'leaves tags and remote-tracking refs unchanged' '
      +	git reset --hard three &&
      +	git tag -f mark HEAD~1 &&
     -+	head_before=$(git rev-parse HEAD) &&
     ++	git update-ref refs/remotes/origin/mark HEAD~1 &&
     ++	mark_before=$(git rev-parse mark) &&
      +
     -+	test_must_fail git history squash start.. 2>err &&
     -+	test_grep "refs/tags/mark" err &&
     -+	test_grep "points into the squashed range" err &&
     -+	test_cmp_rev "$head_before" HEAD &&
     ++	git history squash --no-edit start.. &&
     ++
     ++	test_cmp_rev "$mark_before" mark &&
     ++	test_cmp_rev "$mark_before" refs/remotes/origin/mark &&
      +
     -+	git tag -d mark
     ++	git tag -d mark &&
     ++	git update-ref -d refs/remotes/origin/mark
      +'
      +
     -+test_expect_success 'squashes a range whose internal merge has a single base' '
     ++test_expect_success 'handles a branch pointing at an internal merge' '
      +	git reset --hard start &&
      +	main=$(git symbolic-ref --short HEAD) &&
      +	test_commit --no-tag before-side file b &&
     @@ t/t3455-history-squash.sh (new)
      +	test_commit --no-tag after-side file c &&
      +	git merge --no-ff -m merge inner-side &&
      +	git branch -D inner-side &&
     ++	git branch at-merge HEAD &&
      +	test_commit --no-tag after-merge file d &&
     ++	head_before=$(git rev-parse HEAD) &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash start.. &&
     ++	test_must_fail git history squash start.. 2>err &&
     ++	test_grep "at-merge" err &&
     ++	test_grep "points into the squashed range" err &&
     ++	test_cmp_rev "$head_before" HEAD &&
     ++	git branch -D at-merge &&
     ++
     ++	git history squash --no-edit start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
      +	check_log_subjects -1 <<-\EOF &&
     @@ t/t3455-history-squash.sh (new)
      +	test_commit --no-tag base-fork-tail file c &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash start.. &&
     ++	git history squash --no-edit start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
      +	test_cmp_rev start HEAD^ &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D tipmerge-side &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash start.. &&
     ++	git history squash --no-edit start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     @@ t/t3455-history-squash.sh (new)
      +	test_commit --no-tag basemerge-two file d &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash "$base.." &&
     ++	git history squash --no-edit "$base.." &&
      +
      +	check_commit_count "$base..HEAD" 1 &&
      +	test_cmp_rev "$base" HEAD^ &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
      +'
      +
     -+test_expect_success 'folds a range with two interior merges' '
     -+	git reset --hard start &&
     -+	main=$(git symbolic-ref --short HEAD) &&
     -+	test_commit --no-tag two-merge-a file a1 &&
     -+	git checkout -b two-merge-s1 &&
     -+	test_commit --no-tag two-merge-s1 s1 x &&
     -+	git checkout "$main" &&
     -+	git merge --no-ff -m "merge s1" two-merge-s1 &&
     -+	test_commit --no-tag two-merge-b file b1 &&
     -+	git checkout -b two-merge-s2 &&
     -+	test_commit --no-tag two-merge-s2 s2 y &&
     -+	git checkout "$main" &&
     -+	git merge --no-ff -m "merge s2" two-merge-s2 &&
     -+	git branch -D two-merge-s1 two-merge-s2 &&
     -+	tip_tree=$(git rev-parse HEAD^{tree}) &&
     -+
     -+	git history squash start.. &&
     -+
     -+	check_commit_count start..HEAD 1 &&
     -+	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     -+	test_path_is_file s1 &&
     -+	test_path_is_file s2
     -+'
     -+
      +test_expect_success 'folds a range with a nested merge' '
      +	git reset --hard start &&
      +	main=$(git symbolic-ref --short HEAD) &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D nested-outer nested-inner &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash start.. &&
     ++	git history squash --no-edit start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D octo-1 octo-2 &&
      +	tip_tree=$(git rev-parse HEAD^{tree}) &&
      +
     -+	git history squash start.. &&
     ++	git history squash --no-edit start.. &&
      +
      +	check_commit_count start..HEAD 1 &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     @@ t/t3455-history-squash.sh (new)
      +	git branch -D desc-above &&
      +	head_before=$(git rev-parse HEAD) &&
      +
     -+	test_must_fail git history squash start..desc-tip 2>err &&
     ++	test_must_fail git history squash --no-edit start..desc-tip 2>err &&
      +	test_grep "merge commits is not supported" err &&
      +	test_cmp_rev "$head_before" HEAD
      +'
      +
     -+test_expect_success 'refuses to fold a range a ref points into at a merge' '
     -+	git reset --hard start &&
     -+	main=$(git symbolic-ref --short HEAD) &&
     -+	test_commit --no-tag refmerge-base file b &&
     -+	git checkout -b refmerge-side &&
     -+	test_commit --no-tag refmerge-side side x &&
     -+	git checkout "$main" &&
     -+	test_commit --no-tag refmerge-main file c &&
     -+	git merge --no-ff -m "interior merge" refmerge-side &&
     -+	git branch -D refmerge-side &&
     -+	git branch at-merge HEAD &&
     -+	test_commit --no-tag refmerge-tail file d &&
     -+	head_before=$(git rev-parse HEAD) &&
     -+
     -+	test_must_fail git history squash start.. 2>err &&
     -+	test_grep "at-merge" err &&
     -+	test_grep "points into the squashed range" err &&
     -+	test_cmp_rev "$head_before" HEAD &&
     -+
     -+	git branch -D at-merge
     -+'
     -+
      +test_done
 5:  cdbc183428 < -:  ---------- history: re-edit a squash with every message

-- 
gitgitgadget
