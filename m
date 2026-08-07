Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A8C22FF22
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088377; cv=none; b=TlLegY+dF5D9YpdRnJJMzhg/9T/RHlnwESV1mMJT8GHj7JJQFKiNlFVwbtDzXAxKe2QmdDCEyQaeZNKZTyTI0by8fIauyf2QIKVtbqjU9LmmpWdKGtJRj32OQOINMxOhrX/pX0ASIs3dvr3hOF/KMj6sOrUXS2Fb7plOsRecKaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088377; c=relaxed/simple;
	bh=rGAHQZ/c2cywR+nFBGIR/sHeHFZV4TDrtFQImxhAm7A=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lRq8HM6+xIUu/MAAwIS2rHdZgXODuF9netCPsSs+mWY6AkeLNsLKks8QfcCzaiwN7u47Zi1u1/jTr26pgCunkR8mTfRiRQp9K3V5phz9Nkr/1uc5Ngbpc/lKHocfN1QdWPo7+Ert3ZqGSxhCMWJpvVbysYfGoBLQ+l5r9PtBo3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADhueiUX; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADhueiUX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ce7d2adef4so46382565ad.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786088374; x=1786693174; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sE1XuIWL1FcjTxa9l6PqP+8A6opnq+YB9rdFIMlxaWY=;
        b=ADhueiUXpiDGTo+uEYer0gsgvhAN307RrwCG1ShY/s8at47xIbYkGzaPcFkLZpIXV1
         BNpmHBG+PUvvQGVG3b/PHWaga1ziJHVtEJM4JVWzlWqQI94I+kXcLPghfoCNsx5JNFHa
         OcVWHQZginMMaSSee9VpVbebfM5i4813wtVP4lMOuCIt1RW1eQVKH4fsymR/sW93v0Hm
         heiIBDD1vxy8n24Vfa4NfVJl6cCbwnzM1JskyA1ddRKcExK1iqWovRDQbRFPDoRfXJlX
         0FmHFIqBVTqgAfEwtvawfRqaKgrgv4W3aH2uGg7COLeDEyqQgs4ZVvSBNnMgKQqIQNW2
         k0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786088374; x=1786693174;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sE1XuIWL1FcjTxa9l6PqP+8A6opnq+YB9rdFIMlxaWY=;
        b=G9sIkbZwJzDjKkrgeRyBWFhNNmY69BdRLfDFHubKY8h3Q3GEL+kJ5dQLnkD8qwr4oi
         Yf6zy+q0gQek69NXpqbSVv1qPh8ZP9a861qHoZv/rDaA9ThdOBLkdulgOZCUThnTo40E
         QT42470wwKaaFm+SJPdLQAA2Ed3JKqlDGw8LEFg4lIS1n0aQ8cOAmPJUB3eJEWWr85Iu
         YaT9CTYtZWS5v15Fhw8oBki2Uz6jkrvQ8ry28fd92fGmGaSHRteePmfVBlpaHiCixv3B
         uirI6Kyr2ZRIMH9xbYTE28saMxVK+M9t+SC1FeGh7FQKM6C/9d/XxVwP4fnnXrlSZlg4
         U7Bw==
X-Gm-Message-State: AOJu0Yy1JCKDBGdfDU97ySxyfbYp1jpsG9joIL9SiGtec47nbxcD81j7
	i6qtR5BDZBVk9xgdp0N9L59sTkz80joe/vrgAdNc/4nrTfAbhPqHw+CwyBtvGA==
X-Gm-Gg: AR+sD11oWN73JGMAGSi4mo+TeBLh1GeQT7p86MWXkAaqLb95T5JerU8vglM72r9dE1x
	5Z03T9WjYZiyXxm4T9TGT+CTL5N+AQu6Qsjk4Z7B1oz3lmxMaOvoKMGXZfvPPjAktuVT8uLBefM
	+/OxC3TFaKlqIxZJH4J5a2ufrxlI1GgBslt0bFZO2Bey1nvTss+bgh63zKHwompj9zUDoilfGMQ
	3bgXPwWBW6XJzgUGTxCaEw9KWop74tvCFESyIBK4XbMdnVpKEZOB8iR7SgR1H+1m6wV2v3VRr92
	uM7XEFcROYmKE9n32gWIjfdytUpcJvNJ29XmHQT6q3bQkh3G9+nmckjnmjDVmaQ1VW1oHY359F+
	kC7kWelPbKvCIyqzzyia1R11vdrCi8yj22gz/lOU7d/0YIQCV3A14Hf6vLwSw0ayKqPdxhItOPQ
	LqiKJet01xb8p6sSswO7ii4/gwfhFQN1cvuybWnJ6fXIdcGoLffd3mXAnfClr9df0=
X-Received: by 2002:a17:903:40c5:b0:2c7:1200:bd7e with SMTP id d9443c01a7336-2d294c48ec2mr25790705ad.18.1786088373539;
        Fri, 07 Aug 2026 00:39:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.163.82.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4ea722sm4765665ad.79.2026.08.07.00.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 00:39:32 -0700 (PDT)
Message-Id: <pull.2337.v13.git.git.1786088371.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Aug 2026 07:39:23 +0000
Subject: [PATCH v13 0/8] history: add squash subcommand to fold a range
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
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

Adds git history squash <revision-range> to fold a range of commits.

Changes in v13:

 * Split the squash implementation into five patches covering parsing, range
   validation, branch protection, commit creation, and message editing.
 * Print the sorted names of local branches that prevent a squash, with
   clearer advice for --update-refs=head.
 * Isolate --no-edit behavior from the final patch that enables default
   editor-based message combining.

Changes in v12:

 * Incorporated fixups from Phillip:
   * Reworks range validation into a single walk that rejects roots and
     multiple tips while preserving every parent when squashing into a
     merge.
   * Resolves fixup!, squash! and amend! targets directly, preserving
     message intent and safely consolidating related markers.
   * Builds the editor template from the exact selected revisions, including
     exclusions, while retaining --no-edit behavior.
   * Protects descendant local branches while leaving tags and
     remote-tracking refs unchanged.

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

Harald Nordgren (8):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  sequencer: share the squash message marker helpers and flags
  history: add skeleton for squash subcommand
  history: validate squash revision ranges
  history: protect branches when squashing a range
  history: create squashed commits without editing
  history: support editing squashed commit messages

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  59 +-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 720 +++++++++++++++++++++++--
 object.h                         |   1 +
 sequencer.c                      |  70 +--
 sequencer.h                      |  30 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 886 +++++++++++++++++++++++++++++++
 10 files changed, 1702 insertions(+), 71 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 2c78326f810173a4f3aefd8021f1e07575412481
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v13
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v12:

 1:  20e050a0ad = 1:  b175bdca54 history: extract helper for a commit's parent tree
 2:  b99867a0d4 = 2:  965074f9e8 history: give commit_tree_ext a message template
 3:  352db997e9 = 3:  cdbdd766b2 sequencer: share the squash message marker helpers and flags
 -:  ---------- > 4:  f7d953b081 history: add skeleton for squash subcommand
 -:  ---------- > 5:  dbbf66ba02 history: validate squash revision ranges
 -:  ---------- > 6:  e71a8adfbe history: protect branches when squashing a range
 4:  33d3eca6db ! 7:  8b3551d0d4 history: add squash subcommand to fold a range
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    history: add squash subcommand to fold a range
     +    history: create squashed commits without editing
      
     -    Folding a series of commits into one required either an interactive
     -    rebase where each commit after the first was hand-edited to "fixup", or
     -    a "git reset --soft" to the merge base followed by "git commit --amend".
     +    Create one replacement commit from the resolved range when --no-edit is
     +    selected. Preserve the authorship and all parents of the oldest commit,
     +    use the tip tree, and replay descendants through the existing history
     +    rewrite machinery. Record the complete revision expression in the
     +    reflog and retain dry-run and update-refs behavior.
      
     -    Add "git history squash <revision-range>" to do this directly. It folds
     -    every selected commit into one, preserving the authorship and parents of
     -    the oldest commit and taking the tree of the tip, then replays commits
     -    above the range. By default an editor opens with every folded message in
     -    the same template used by "git rebase -i --autosquash". With --no-edit,
     -    the selected message is used without opening an editor.
     -
     -    Resolve fixup!, squash! and amend! subjects directly while walking the
     -    selected commits. A marker is rejected unless its fixed target is also
     -    selected, except that a range made up entirely of related markers can be
     -    consolidated. Without editing, refuse any squash! or amend! whose message
     -    would be discarded.
     -
     -    Read the range like arguments to "git rev-list" and accept multiple
     -    revisions and rev-list options. Restore the walk settings required by the
     -    fold after setup_revisions(), warning when an option changed them. The
     -    range must name a bottom commit, must not reach a root, and must have one
     -    tip. Every parent after the oldest commit must be selected or also be a
     -    parent of the oldest commit. This permits internal merges and preserves
     -    all parents when the oldest commit is itself a merge.
     -
     -    By default, refuse when a local branch descends from the selected commits
     -    but cannot remain a descendant of the result. Tags and remote-tracking
     -    refs are left unchanged. Use --update-refs=head to leave such local
     -    branches unchanged as well.
     +    Resolve fixup!, squash! and amend! subjects while walking the range.
     +    Reject markers whose targets are not selected and refuse any no-edit
     +    fold that would discard a squash! or amend! message. A range made
     +    entirely from related markers can still be consolidated, with the last
     +    applicable amend! body supplying the message.
      
          Inspired-by: Sergey Chernov <serega.morph@gmail.com>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     - ## Documentation/config/advice.adoc ##
     -@@ Documentation/config/advice.adoc: all advice messages.
     - 	forceDeleteBranch::
     - 		Shown when the user tries to delete a not fully merged
     - 		branch without the force option set.
     -+	historyUpdateRefs::
     -+		Shown when `git history squash` refuses because a ref points
     -+		into the range being folded, to tell the user about
     -+		`--update-refs=head`.
     - 	ignoredHook::
     - 		Shown when a hook is ignored because the hook is not
     - 		set as executable.
     -
       ## Documentation/git-history.adoc ##
     -@@ Documentation/git-history.adoc: git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(
     - git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
     - git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
     - git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
     -+git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
     - 
     - DESCRIPTION
     - -----------
      @@ Documentation/git-history.adoc: at once.
       LIMITATIONS
       -----------
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +already on `topic`. Rev-list options may also be given, but any that would
      +change how the range is walked are overridden with a warning.
      ++
     -+An editor opens pre-filled with the messages of all the folded commits so you
     -+can combine them. With `--no-edit`, the oldest commit's message is preserved
     -+instead, except that an `amend!` commit targeting it replaces its message.
     ++With `--no-edit`, the oldest commit's message is preserved, except that an
     ++`amend!` commit targeting it replaces its message.
      ++
      +The selected commits must form a connected graph with a single tip and must
      +not include a root commit. Every parent of a commit after the oldest one must
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +the last `amend!` message is used if there is one; a `squash!` or `amend!` is
      +otherwise refused if folding it would discard its message.
      ++
     -+The editor template mirrors `git rebase -i --autosquash`: each `fixup!`,
     -+`squash!`, or `amend!` is grouped under the commit it targets rather than
     -+shown in commit order. A `fixup!` message is dropped (commented out in full),
     -+a `squash!` keeps its body with only the marker subject commented, and an
     -+`amend!` replaces its target's message, unless a `squash!` folded into that
     -+target first, in which case it keeps its body like a `squash!`.
     -++
      +A local branch descended from a selected commit but not from the range tip
      +cannot be rewritten as a descendant of the result, so with the default
      +`--update-refs=branches` the command refuses. Rerun with `--update-refs=head`
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
       OPTIONS
       -------
       
     -@@ Documentation/git-history.adoc: OPTIONS
     - 	objects will be written into the repository, so applying these printed
     - 	ref updates is generally safe.
     - 
     -+`--edit`::
     -+`--no-edit`::
     -+	For `squash`, open an editor to combine the messages of the folded commits.
     -+	This is the default; use `--no-edit` to keep the selected message without
     -+	opening an editor.
     -+
     - `--reedit-message`::
     - 	Open an editor to modify the target commit's message.
     - 
     -
     - ## advice.c ##
     -@@ advice.c: static struct {
     - 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates" },
     - 	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch" },
     - 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
     -+	[ADVICE_HISTORY_UPDATE_REFS]			= { "historyUpdateRefs" },
     - 	[ADVICE_IGNORED_HOOK]				= { "ignoredHook" },
     - 	[ADVICE_IMPLICIT_IDENTITY]			= { "implicitIdentity" },
     - 	[ADVICE_MERGE_CONFLICT]				= { "mergeConflict" },
     -
     - ## advice.h ##
     -@@ advice.h: enum advice_type {
     - 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
     - 	ADVICE_FORCE_DELETE_BRANCH,
     - 	ADVICE_GRAFT_FILE_DEPRECATED,
     -+	ADVICE_HISTORY_UPDATE_REFS,
     - 	ADVICE_IGNORED_HOOK,
     - 	ADVICE_IMPLICIT_IDENTITY,
     - 	ADVICE_MERGE_CONFLICT,
      
       ## builtin/history.c ##
     -@@
     - #define USE_THE_REPOSITORY_VARIABLE
     - 
     - #include "builtin.h"
     -+#include "advice.h"
     - #include "cache-tree.h"
     - #include "commit.h"
     - #include "commit-reach.h"
     -@@
     - #include "path.h"
     - #include "read-cache.h"
     - #include "refs.h"
     -+#include "ref-filter.h"
     - #include "replay.h"
     - #include "reset.h"
     - #include "revision.h"
     -@@
     - 	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
     - #define GIT_HISTORY_SPLIT_USAGE \
     - 	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
     -+#define GIT_HISTORY_SQUASH_USAGE \
     -+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
     - 
     - static void change_data_free(void *util, const char *str UNUSED)
     - {
      @@ builtin/history.c: out:
     - 	return ret;
     - }
       
     -+/*Remember to update object flag allocation in object.h */
     -+#define SQUASH_SEEN (1u << 11)
     -+#define SQUASH_TIP (1u << 12)
     + #define SQUASH_SEEN (1u << 11)
     + #define SQUASH_TIP (1u << 12)
      +#define SQUASH_AMEND_TARGET (1u << 13)
      +
      +static bool is_autosquash_subject(const char *s)
     @@ builtin/history.c: out:
      +	repo_unuse_commit_buffer(repo, commit, buf);
      +	return ret;
      +}
     -+
     -+static int build_squash_message(struct repository *repo,
     -+				const struct strbuf *todo_buf,
     -+				struct strbuf *out);
     -+
     -+/*
     -+ * Resolve a "<base>..<tip>" revision range into the base commit just outside
     -+ * the range (which becomes the parent of the squashed commit), the oldest
     -+ * commit contained in the range (whose message the squash reuses), and the
     -+ * range tip (whose tree becomes the result). A merge inside the range is fine,
     -+ * but the range must have a single base and must not reach a root commit.
     -+ */
     -+static int resolve_squash_range(struct repository *repo,
     -+				bool update_branches,
     -+				bool edit_message,
     -+				int argc, const char **argv,
     -+				struct commit **oldest_out,
     + 
     + static int setup_squash_revisions(struct repository *repo,
     + 				  int argc, const char **argv,
     +@@ builtin/history.c: static int resolve_squash_range(struct repository *repo,
     + 				bool update_branches,
     + 				int argc, const char **argv,
     + 				struct commit **oldest_out,
     +-				struct commit **tip_out)
      +				struct commit **tip_out,
      +				char **message_out)
     -+{
     -+	struct rev_info revs;
     + {
     + 	struct rev_info revs;
      +	struct subject_data subject_data = SUBJECT_DATA_INIT;
     -+	struct commit *commit, *oldest = NULL, *tip = NULL;
     -+	struct strbuf todo_buf = STRBUF_INIT;
     -+	size_t i;
     -+	int ret, tip_count = 0;
     -+	struct ref_filter filter = REF_FILTER_INIT;
     -+	struct ref_array refs = { 0 };
     -+
     -+	repo_init_revisions(repo, &revs, NULL);
     -+	subject_data.edit_message = edit_message;
     -+	revs.reverse = 1;
     -+	revs.topo_order = 1;
     -+	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
     -+	revs.simplify_history = 0;
     -+	revs.ancestry_path = 1;
     -+	revs.limited = 1;
     -+	revs.ancestry_path_implicit_bottoms = 1;
     -+
     -+	argc = setup_revisions(argc, argv, &revs, NULL);
     -+	if (argc > 1) {
     -+		ret = error(_("unrecognized argument: %s"), argv[1]);
     -+		goto out;
     -+	}
     -+
     -+	if (revs.reverse != 1 || revs.topo_order != 1 ||
     -+	    revs.sort_order != REV_SORT_IN_GRAPH_ORDER ||
     -+	    revs.simplify_history != 0 || revs.boundary == 1 ||
     -+	    revs.ancestry_path != 1 || revs.limited != 1 ||
     -+	    revs.ancestry_path_implicit_bottoms != 1) {
     -+		warning(_("ignoring rev-list options that would change how the "
     -+			  "range is walked"));
     -+		revs.reverse = 1;
     -+		revs.topo_order = 1;
     -+		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
     -+		revs.simplify_history = 0;
     -+		revs.boundary = 0;
     -+		revs.ancestry_path = 1;
     -+		revs.limited = 1;
     -+		revs.ancestry_path_implicit_bottoms = 1;
     -+	}
     -+
     -+	/*
     -+	 * A squash needs a base to reparent onto, so the range has to exclude
     -+	 * something, as in "<base>..<tip>". A revision range with no such
     -+	 * bottom commit cannot be squashed.
     -+	 */
     -+	for (i = 0; i < revs.cmdline.nr; i++)
     -+		if (revs.cmdline.rev[i].flags & BOTTOM)
     -+			break;
     -+	if (i == revs.cmdline.nr) {
     -+		ret = error(_("not a '<base>..<tip>' revision range"));
     -+		goto out;
     -+	}
     -+
     -+	if (prepare_revision_walk(&revs) < 0) {
     -+		ret = error(_("error preparing revisions"));
     -+		goto out;
     -+	}
     -+	while ((commit = get_revision(&revs))) {
     -+		struct commit_list *p;
     -+
     -+		if (edit_message)
     -+			strbuf_addf(&todo_buf, "pick %s\n",
     -+				    oid_to_hex(&commit->object.oid));
     -+
     -+		if (!commit->parents) {
     -+			ret = error(_("cannot squash down to root commit"));
     -+			goto out;
     -+		}
     -+		for (p = commit->parents; oldest && p; p = p->next) {
     -+			struct commit_list *q;
     -+			struct object *o;
     -+			bool seen;
     -+
     -+			if (repo_parse_commit(repo, p->item)) {
     -+				ret = error(_("cannot parse commit"));
     -+				goto out;
     -+			}
     -+			o = &p->item->object;
     -+			seen = o->flags & SQUASH_SEEN;
     -+			/*
     -+			 * Allow parents that match the parents of the
     -+			 * squashed commit.
     -+			 */
     -+			for (q = oldest->parents; !seen && q; q = q->next) {
     -+				if (p->item == q->item) {
     -+					seen = true;
     -+					commit_list_insert(commit, &filter.with_commit);
     -+				}
     -+			}
     -+			if (!seen) {
     -+				ret = error(_("parent %s of commit %s is "
     -+					      "outside the revision range"),
     -+					    repo_find_unique_abbrev(repo, &o->oid,
     -+								    DEFAULT_ABBREV),
     -+					    repo_find_unique_abbrev(repo, &commit->object.oid,
     -+								    DEFAULT_ABBREV));
     -+				goto out;
     -+			}
     -+			if (o->flags & SQUASH_TIP) {
     -+				tip_count--;
     -+				o->flags &= ~SQUASH_TIP;
     -+			}
     -+		}
     -+		if (!oldest) {
     -+			commit_list_insert(commit, &filter.with_commit);
     -+			oldest = commit;
     -+		}
     + 	struct commit *commit, *oldest = NULL, *tip = NULL;
     + 	int ret, tip_count = 0;
     + 	bool walk_started = false;
     +@@ builtin/history.c: static int resolve_squash_range(struct repository *repo,
     + 			commit_list_insert(commit, &filter.with_commit);
     + 			oldest = commit;
     + 		}
      +		if (squash_check_subject(repo, commit, &subject_data)) {
      +			ret = -1;
      +			goto out;
      +		}
     -+		tip = commit;
     -+		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
     -+		tip_count++;
     -+	}
     -+	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP | SQUASH_AMEND_TARGET);
     -+	reset_revision_walk();
     -+	if (!tip_count) {
     -+		ret = error(_("the revision range is empty"));
     -+		goto out;
     -+	} else if (tip_count != 1) {
     -+		  ret = error(_("the revision range contains more than one tip "
     -+				"commit"));
     -+		  goto out;
     -+	  } else if (oldest == tip) {
     -+		ret = error(_("the revision range holds a single commit; "
     -+			      "nothing to squash"));
     -+		goto out;
     -+	} else if (!oldest->parents) {
     -+		BUG("an in-range commit must have a parent");
     -+	}
     -+	commit_list_insert(tip, &filter.no_commit);
     -+	filter.kind = FILTER_REFS_BRANCHES;
     -+	if (update_branches &&
     -+	    filter_refs(&refs, &filter, filter.kind)) {
     -+		ret = error(_("could not filter refs"));
     -+		goto out;
     -+	}
     -+	if (refs.nr) {
     -+		/*
     -+		 * TODO: list the branches and also check HEADS from other worktrees
     -+		 */
     -+		ret = error(_("a branch points to a commit that is being squashed"));
     -+		advise_if_enabled(ADVICE_HISTORY_UPDATE_REFS,
     -+				  _("Use --update-refs=head to rewrite only "
     -+				    "the current branch and leave such refs "
     -+				    "untouched."));
     -+		goto out;
     -+	}
     -+	if (edit_message) {
     -+		strbuf_reset(&subject_data.squash_message);
     -+		ret = build_squash_message(repo, &todo_buf,
     -+					   &subject_data.squash_message);
     -+		if (ret < 0)
     -+			goto out;
     -+	}
     -+	*oldest_out = oldest;
     -+	*tip_out = tip;
     + 		tip = commit;
     + 		tip->object.flags |= SQUASH_SEEN | SQUASH_TIP;
     + 		tip_count++;
     +@@ builtin/history.c: static int resolve_squash_range(struct repository *repo,
     + 
     + 	*oldest_out = oldest;
     + 	*tip_out = tip;
      +	*message_out = strbuf_detach(&subject_data.squash_message, NULL);
     -+	ret = 0;
     -+
     -+out:
     -+	strbuf_release(&todo_buf);
     + 	ret = 0;
     + 
     + out:
     +-	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP);
     ++	clear_object_flags(repo, SQUASH_SEEN | SQUASH_TIP |
     ++			   SQUASH_AMEND_TARGET);
     + 	if (walk_started)
     + 		reset_revision_walk();
      +	subject_data_clear(&subject_data);
     -+	release_revisions(&revs);
     -+	ref_filter_clear(&filter);
     -+	ref_array_clear(&refs);
     -+	return ret;
     -+}
     -+
     -+static bool amend_replaces_target(struct todo_list *todo, int target)
     -+{
     -+	int i;
     -+
     -+	for (i = target + 1; i < todo->nr &&
     -+			     todo->items[i].command != TODO_PICK; i++) {
     -+		if (todo->items[i].command == TODO_SQUASH)
     -+			return false;
     -+		if (todo->items[i].flags & TODO_REPLACE_FIXUP_MSG)
     -+			return true;
     -+	}
     -+	return false;
     -+}
     -+
     -+static int build_squash_message(struct repository *repo,
     -+				const struct strbuf *todo_buf,
     -+				struct strbuf *out)
     -+{
     -+	struct todo_list todo = TODO_LIST_INIT;
     -+	struct replay_opts opts = REPLAY_OPTS_INIT;
     -+	int i, nr_commits, ret;
     -+
     -+	if (todo_list_parse_insn_buffer(repo, &opts, todo_buf->buf, &todo) < 0 ||
     -+	    todo_list_rearrange_squash(&todo) < 0) {
     -+		ret = error(_("could not prepare the squash message"));
     -+		goto out;
     -+	}
     -+
     -+	nr_commits = todo.nr;
     -+	for (i = 0; i < nr_commits; i++) {
     -+		struct todo_item *item = &todo.items[i];
     -+		const char *message, *body;
     -+		size_t commented_len;
     -+		bool skip, squashing;
     -+
     -+		squashing = item->command == TODO_SQUASH ||
     -+			    (item->flags & TODO_REPLACE_FIXUP_MSG);
     -+		if (item->command == TODO_PICK)
     -+			skip = amend_replaces_target(&todo, i);
     -+		else
     -+			skip = !squashing;
     -+
     -+		message = repo_logmsg_reencode(repo, item->commit, NULL, NULL);
     -+		find_commit_subject(message, &body);
     -+
     -+		if (skip)
     -+			commented_len = strlen(body);
     -+		else if (squashing)
     -+			commented_len = squash_subject_comment_len(body, 1);
     -+		else
     -+			commented_len = 0;
     -+
     -+		if (!i)
     -+			add_squash_combination_header(out, nr_commits);
     -+		strbuf_addch(out, '\n');
     -+		add_squash_message_header(out, i + 1, skip);
     -+		strbuf_addstr(out, "\n\n");
     -+		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
     -+		strbuf_addstr(out, body + commented_len);
     -+		strbuf_complete_line(out);
     -+
     -+		repo_unuse_commit_buffer(repo, item->commit, message);
     -+	}
     -+
     -+	ret = 0;
     -+
     -+out:
     -+	todo_list_release(&todo);
     -+	replay_opts_release(&opts);
     -+	return ret;
     -+}
     -+
     -+static int cmd_history_squash(int argc,
     -+			      const char **argv,
     -+			      const char *prefix,
     -+			      struct repository *repo)
     -+{
     -+	const char * const usage[] = {
     -+		GIT_HISTORY_SQUASH_USAGE,
     -+		NULL,
     -+	};
     -+	enum ref_action action = REF_ACTION_DEFAULT;
     -+	int dry_run = 0;
     -+	int edit = 1;
     -+	struct option options[] = {
     -+		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
     -+			       N_("control which refs should be updated"),
     -+			       PARSE_OPT_NONEG, parse_ref_action),
     -+		OPT_BOOL('n', "dry-run", &dry_run,
     -+			 N_("perform a dry-run without updating any refs")),
     -+		OPT_BOOL('e', "edit", &edit,
     -+			 N_("edit the commit message")),
     -+		OPT_END(),
     -+	};
     + 	release_revisions(&revs);
     + 	ref_filter_clear(&filter);
     + 	ref_array_clear(&refs);
     +@@ builtin/history.c: static int cmd_history_squash(int argc,
     + 			 N_("edit the commit message")),
     + 		OPT_END(),
     + 	};
     +-	struct commit *oldest, *tip;
      +	struct strbuf reflog_msg = STRBUF_INIT;
      +	struct commit *oldest, *tip, *rewritten;
      +	const struct object_id *base_tree_oid, *tip_tree_oid;
      +	char *message_template = NULL;
      +	struct rev_info revs = { 0 };
     -+	int ret;
     -+
     -+	argc = parse_options(argc, argv, prefix, options, usage,
     -+			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
     + 	int ret;
     + 
     + 	argc = parse_options(argc, argv, prefix, options, usage,
     + 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
     +-	if (argc < 2)
     +-		return error(_("command expects a revision range"));
      +	if (argc < 2) {
      +		ret = error(_("command expects a revision range"));
      +		goto out;
      +	}
     -+	repo_config(repo, git_default_config, NULL);
     -+
     -+	if (action == REF_ACTION_DEFAULT)
     -+		action = REF_ACTION_BRANCHES;
     + 	repo_config(repo, git_default_config, NULL);
      +
     + 	if (action == REF_ACTION_DEFAULT)
     + 		action = REF_ACTION_BRANCHES;
     + 
      +	strbuf_addstr(&reflog_msg, "squash: updating ");
      +	strbuf_join_argv(&reflog_msg, argc - 1, argv + 1, ' ');
      +
     -+	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
     -+				   edit,
     + 	ret = resolve_squash_range(repo, action == REF_ACTION_BRANCHES,
     +-				   argc, argv, &oldest, &tip);
      +				   argc, argv, &oldest, &tip,
      +				   &message_template);
     -+	if (ret < 0)
     + 	if (ret < 0)
     +-		return ret;
     ++		goto out;
     ++	if (edit) {
     ++		ret = error(_("message editing is not supported yet; use '--no-edit'"));
      +		goto out;
     ++	}
      +
      +	ret = setup_revwalk(repo, action, tip, &revs);
      +	if (ret < 0)
     @@ builtin/history.c: out:
      +
      +	ret = commit_tree_ext(repo, "squash", oldest, message_template,
      +			      oldest->parents, base_tree_oid, tip_tree_oid,
     -+			      &rewritten,
     -+			      edit ? COMMIT_TREE_EDIT_MESSAGE : 0);
     ++			      &rewritten, 0);
      +	if (ret < 0) {
      +		ret = error(_("failed writing squashed commit"));
      +		goto out;
     @@ builtin/history.c: out:
      +		ret = error(_("failed replaying descendants"));
      +		goto out;
      +	}
     -+
     + 
     +-	return error(_("squashing commits is not implemented yet"));
      +	ret = 0;
      +
      +out:
     @@ builtin/history.c: out:
      +	release_revisions(&revs);
      +	free(message_template);
      +	return ret;
     -+}
     -+
     - static int update_worktree(struct repository *repo,
     - 			   const struct commit *old_head,
     - 			   const struct commit *new_head,
     -@@ builtin/history.c: int cmd_history(int argc,
     - 		GIT_HISTORY_FIXUP_USAGE,
     - 		GIT_HISTORY_REWORD_USAGE,
     - 		GIT_HISTORY_SPLIT_USAGE,
     -+		GIT_HISTORY_SQUASH_USAGE,
     - 		NULL,
     - 	};
     - 	parse_opt_subcommand_fn *fn = NULL;
     -@@ builtin/history.c: int cmd_history(int argc,
     - 		OPT_SUBCOMMAND("fixup", &fn, cmd_history_fixup),
     - 		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
     - 		OPT_SUBCOMMAND("split", &fn, cmd_history_split),
     -+		OPT_SUBCOMMAND("squash", &fn, cmd_history_squash),
     - 		OPT_END(),
     - 	};
     + }
       
     + static int update_worktree(struct repository *repo,
      
       ## object.h ##
      @@ object.h: void object_array_init(struct object_array *array);
        * bisect.c:                                        16
        * bundle.c:                                        16
        * http-push.c:                          11-----14
     +- * builtin/history.c:                    1112
      + * builtin/history.c:                    11---13
        * commit-graph.c:                                15
        * commit-reach.c:                                  16-------20
        * builtin/last-modified.c:                         1617
      
     - ## t/meson.build ##
     -@@ t/meson.build: integration_tests = [
     -   't3452-history-split.sh',
     -   't3453-history-fixup.sh',
     -   't3454-history-drop.sh',
     -+  't3455-history-squash.sh',
     -   't3500-cherry.sh',
     -   't3501-revert-cherry-pick.sh',
     -   't3502-cherry-pick-merge.sh',
     -
     - ## t/t3455-history-squash.sh (new) ##
     -@@
     -+#!/bin/sh
     -+
     -+test_description='tests for git-history squash subcommand'
     -+
     -+. ./test-lib.sh
     -+
     + ## t/t3455-history-squash.sh ##
     +@@ t/t3455-history-squash.sh: test_description='tests for git-history squash subcommand'
     + 
     + . ./test-lib.sh
     + 
     +-test_expect_success 'setup linear history' '
      +stage_file () {
      +	printf "%s\n" "$1" >file &&
      +	git add file
     @@ t/t3455-history-squash.sh (new)
      +}
      +
      +test_expect_success 'setup linear history touching two files' '
     -+	test_commit base file a start &&
     + 	test_commit base file a start &&
     +-	test_commit one file b &&
     +-	test_commit two file c &&
     +-	test_commit three file d
      +	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
      +		test_commit one other x &&
      +	GIT_AUTHOR_NAME=Two GIT_AUTHOR_EMAIL=two@example.com \
      +		test_commit two file c &&
      +	GIT_AUTHOR_NAME=Three GIT_AUTHOR_EMAIL=three@example.com \
      +		test_commit three file d
     -+'
     -+
     -+test_expect_success 'errors on missing range argument' '
     -+	test_must_fail git history squash 2>err &&
     -+	test_grep "expects a revision range" err
     -+'
     -+
     -+test_expect_success 'errors on an empty range' '
     -+	test_must_fail git history squash HEAD..HEAD 2>err &&
     -+	test_grep "the revision range is empty" err
     -+'
     -+
     -+test_expect_success 'errors on a single revision that is not a range' '
     -+	test_must_fail git history squash HEAD 2>err &&
     -+	test_grep "not a .*range" err &&
     -+	test_must_fail git history squash HEAD~1 2>err &&
     -+	test_grep "not a .*range" err
     -+'
     -+
     -+test_expect_success 'errors on a range holding a single commit' '
     + '
     + 
     + test_expect_success 'errors on missing range argument' '
     +@@ t/t3455-history-squash.sh: test_expect_success 'errors on a single revision that is not a range' '
     + '
     + 
     + test_expect_success 'errors on a range holding a single commit' '
      +	git reset --hard three &&
      +	head_before=$(git rev-parse HEAD) &&
      +
     -+	test_must_fail git history squash "HEAD^!" 2>err &&
     + 	test_must_fail git history squash "HEAD^!" 2>err &&
     +-	test_grep "single commit; nothing to squash" err
      +	test_grep "single commit; nothing to squash" err &&
      +	test_cmp_rev "$head_before" HEAD
     -+'
     -+
     + '
     + 
     +-test_expect_success 'rejects a root commit' '
      +test_expect_success 'rejects root commit' '
      +	# create a disconnected root commit
     -+	oid=$(git commit-tree -m root three^{tree}) &&
     + 	oid=$(git commit-tree -m root three^{tree}) &&
     +-	test_must_fail git history squash \
     +-		--ancestry-path=start "$oid..three" 2>err &&
     +-	test_grep "cannot squash down to root commit" err
      +	# because we pass --ancestry-path when calling setup_revs() it the
      +	# revision walk will only include commits decended from $oid so
      +	# we need to give it another --ancestry-path commit to actually walk
     @@ t/t3455-history-squash.sh (new)
      +	test_must_fail git history squash --ancestry-path=start $oid..three 2>err &&
      +	echo "error: cannot squash down to root commit" >expect &&
      +	test_cmp expect err
     -+'
     -+
     -+test_expect_success 'rejects multiple tips' '
     -+	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
     + '
     + 
     + test_expect_success 'rejects multiple tips' '
     + 	oid=$(git commit-tree -m tip -p start^0 three^{tree}) &&
     +-	test_must_fail git history squash ^start "$oid" three~1 2>err &&
     +-	test_grep "revision range contains more than one tip" err
      +	test_must_fail git history squash ^start $oid three~1 2>err &&
      +	echo "error: the revision range contains more than one tip commit" >expect &&
      +	test_cmp expect err &&
     @@ t/t3455-history-squash.sh (new)
      +	git history squash --no-edit ^start three~1 three &&
      +	test_cmp_rev HEAD~1 start^0 &&
      +	test_cmp_rev HEAD^{tree} three^{tree}
     -+'
     -+
     + '
     + 
     +-test_expect_success 'rejects a merge parent outside the range' '
     +-	git reset --hard start &&
      +test_expect_success 'accepts multiple revision arguments with an exclusion' '
      +	git reset --hard three &&
      +	git branch -f keep HEAD~2 &&
     @@ t/t3455-history-squash.sh (new)
      +
      +test_expect_success 'squashes a branch the current branch is not on' '
      +	git reset --hard three &&
     -+	main=$(git symbolic-ref --short HEAD) &&
     + 	main=$(git symbolic-ref --short HEAD) &&
     +-	git checkout -b outside-parent &&
     +-	test_commit --no-tag outside-parent outside x &&
      +	head_before=$(git rev-parse HEAD) &&
      +	git checkout -b off-history start &&
      +	test_commit --no-tag off-one off a &&
      +	test_commit --no-tag off-two off b &&
     -+	git checkout "$main" &&
     -+
     + 	git checkout "$main" &&
     +-	test_commit --no-tag outside-main file b &&
     +-	base=$(git rev-parse HEAD) &&
     +-	test_commit --no-tag outside-mid file c &&
     +-	git merge --no-ff -m "merge outside-parent" outside-parent &&
     +-	git branch -D outside-parent &&
     + 
     +-	test_must_fail git history squash "$base.." 2>err &&
     +-	test_grep "parent .* of commit .* is outside the revision range" err
      +	git history squash --no-edit start..off-history &&
      +
      +	check_commit_count start..off-history 1 &&
     @@ t/t3455-history-squash.sh (new)
      +	test_must_fail git history squash --no-edit HEAD~3.. 2>err &&
      +	test_grep "^error: cannot squash .* target is not being squashed" err &&
      +	test_set_editor :
     -+'
     -+
     + '
     + 
     +-test_expect_success 'prints branches that cannot follow the squash' '
      +test_expect_success 'squashing fixups into a merge' '
      +	test_when_finished \
      +		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
     @@ t/t3455-history-squash.sh (new)
      +	sed 1,2d msg | test_commit_message HEAD
      +'
      +
     -+test_expect_success 'edits every message and aborts on an empty result' '
     -+	git reset --hard start &&
     -+	stage_file b &&
     -+	git commit -m "re-one subject" -m "re-one body line" &&
     -+	test_commit --no-tag re-two file c &&
     -+	test_commit re-three file d &&
     -+	head_before=$(git rev-parse HEAD) &&
     -+
     -+	write_script empty-editor <<-\EOF &&
     -+	>"$1"
     -+	EOF
     -+	test_set_editor "$(pwd)/empty-editor" &&
     -+	test_must_fail git history squash start.. 2>err &&
     -+	test_grep "Aborting commit due to empty commit message" err &&
     -+	test_cmp_rev "$head_before" HEAD &&
     -+
     -+	write_script editor <<-\EOF &&
     -+	cat "$1" >edited &&
     -+	echo combined >"$1"
     -+	EOF
     -+	test_set_editor "$(pwd)/editor" &&
     -+	git history squash start.. &&
     -+
     -+	cat >expect <<-EOF &&
     -+	# This is a combination of 3 commits.
     -+	# This is the 1st commit message:
     -+
     -+	re-one subject
     -+
     -+	re-one body line
     -+
     -+	# This is the commit message #2:
     -+
     -+	re-two
     -+
     -+	# This is the commit message #3:
     -+
     -+	re-three
     -+
     -+	# Please enter the commit message for the squash changes. Lines starting
     -+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     -+	# Changes to be committed:
     -+	#	modified:   file
     -+	#
     -+	EOF
     -+	test_cmp expect edited &&
     -+	check_log_subjects -1 <<-\EOF
     -+	combined
     -+	EOF
     -+'
     -+
     -+test_expect_success 'handles fixup!, squash! and amend! like rebase' '
     -+	git reset --hard start &&
     -+	test_commit --no-tag mark-base file b &&
     -+	stage_file c &&
     -+	commit_with_message "fixup! mark-base\n\nfixup body\n" &&
     -+	stage_file d &&
     -+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
     -+	stage_file e &&
     -+	commit_with_message "amend! mark-base\n\namended message\n" &&
     -+
     -+	write_script editor <<-\EOF &&
     -+	cat "$1" >edited
     -+	EOF
     -+	test_set_editor "$(pwd)/editor" &&
     -+	git history squash start.. &&
     -+
     -+	cat >expect <<-EOF &&
     -+	# This is a combination of 4 commits.
     -+	# This is the 1st commit message:
     -+
     -+	mark-base
     -+
     -+	# The commit message #2 will be skipped:
     -+
     -+	# fixup! mark-base
     -+	#
     -+	# fixup body
     -+
     -+	# This is the commit message #3:
     -+
     -+	# squash! mark-base
     -+
     -+	squash remark
     -+
     -+	# This is the commit message #4:
     -+
     -+	# amend! mark-base
     -+
     -+	amended message
     -+
     -+	# Please enter the commit message for the squash changes. Lines starting
     -+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     -+	# Changes to be committed:
     -+	#	modified:   file
     -+	#
     -+	EOF
     -+	test_cmp expect edited &&
     -+	check_log_messages -1 <<-\EOF
     -+	mark-base
     -+
     -+	squash remark
     -+
     -+	amended message
     -+
     -+	EOF
     -+'
     -+
     -+test_expect_success 'groups fixups under their targets in the editor' '
     -+	git reset --hard start &&
     -+	test_commit --no-tag alpha file a1 &&
     -+	test_commit --no-tag beta file b1 &&
     -+	stage_file a2 &&
     -+	commit_with_message "fixup! alpha\n" &&
     -+	stage_file b2 &&
     -+	commit_with_message "fixup! beta\n" &&
     -+
     -+	write_script editor <<-\EOF &&
     -+	cat "$1" >edited
     -+	EOF
     -+	test_set_editor "$(pwd)/editor" &&
     -+	git history squash start.. &&
     -+
     -+	cat >expect <<-EOF &&
     -+	# This is a combination of 4 commits.
     -+	# This is the 1st commit message:
     -+
     -+	alpha
     -+
     -+	# The commit message #2 will be skipped:
     -+
     -+	# fixup! alpha
     -+
     -+	# This is the commit message #3:
     -+
     -+	beta
     -+
     -+	# The commit message #4 will be skipped:
     -+
     -+	# fixup! beta
     -+
     -+	# Please enter the commit message for the squash changes. Lines starting
     -+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     -+	# Changes to be committed:
     -+	#	modified:   file
     -+	#
     -+	EOF
     -+	test_cmp expect edited
     -+'
     -+
     -+test_expect_success 'lets amend! replace its target message in the editor' '
     -+	git reset --hard start &&
     -+	test_commit --no-tag mark-base file b &&
     -+	stage_file c &&
     -+	commit_with_message "amend! mark-base\n\namended message\n" &&
     -+	stage_file d &&
     -+	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
     -+
     -+	write_script editor <<-\EOF &&
     -+	cat "$1" >edited
     -+	EOF
     -+	test_set_editor "$(pwd)/editor" &&
     -+	git history squash start.. &&
     -+
     -+	cat >expect <<-EOF &&
     -+	# This is a combination of 3 commits.
     -+	# The 1st commit message will be skipped:
     -+
     -+	# mark-base
     -+
     -+	# This is the commit message #2:
     -+
     -+	# amend! mark-base
     -+
     -+	amended message
     -+
     -+	# This is the commit message #3:
     -+
     -+	# squash! mark-base
     -+
     -+	squash remark
     -+
     -+	# Please enter the commit message for the squash changes. Lines starting
     -+	# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
     -+	# Changes to be committed:
     -+	#	modified:   file
     -+	#
     -+	EOF
     -+	test_cmp expect edited &&
     -+	check_log_messages -1 <<-\EOF
     -+	amended message
     -+
     -+	squash remark
     -+
     -+	EOF
     -+'
     -+
      +test_expect_success '--update-refs=head only moves HEAD' '
      +	git reset --hard three &&
      +	git branch -f other HEAD &&
     @@ t/t3455-history-squash.sh (new)
      +'
      +
      +test_expect_success 'refuses to fold a range a branch points into' '
     -+	test_when_finished \
     -+		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
     -+		 git branch -D feature" &&
     -+	git checkout -f -b feature start &&
     -+	test_commit C1 &&
     -+	test_commit C2 &&
     -+	git checkout -b topic-1 start &&
     -+	test_commit C3 &&
     -+	test_commit C4 &&
     -+	git checkout C3 &&
     -+	test_commit C5 &&
     -+	git checkout feature &&
     -+	git merge C5 &&
     -+	test_commit C6 &&
     -+	git checkout -b topic-2 C2 &&
     -+	test_commit C7 &&
     -+	git checkout feature &&
     -+
     -+	test_must_fail git history squash start.. 2>err &&
     -+	# TODO: check the branch names when we print them (topic-1 & topic-2)
     -+	test_grep "^error: a branch points to" err &&
     + 	test_when_finished \
     + 		"git switch -f $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME; \
     + 		 git branch -D feature" &&
     +@@ t/t3455-history-squash.sh: test_expect_success 'prints branches that cannot follow the squash' '
     + 	test_grep "^error: the following branches cannot be rewritten" err &&
     + 	test_grep "^  topic-1$" err &&
     + 	test_grep "^  topic-2$" err &&
     +-	test_grep "^hint: .* --update-refs=head" err
      +	test_grep "^hint: .* --update-refs=head" err &&
      +	test_cmp_rev C6 HEAD &&
      +
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp_rev start HEAD^ &&
      +	test_cmp_rev C6^{tree} HEAD^{tree} &&
      +	test_cmp_rev C6 HEAD@{1}
     -+'
     -+
     -+test_expect_success 'advice.historyUpdateRefs silences the hint' '
     -+	git reset --hard three &&
     -+	git branch -f mid HEAD~1 &&
     + '
     + 
     + test_expect_success 'advice.historyUpdateRefs silences the hint' '
     + 	git reset --hard three &&
     + 	git branch -f mid HEAD~1 &&
      +	head_before=$(git rev-parse HEAD) &&
     -+
     -+	test_must_fail git -c advice.historyUpdateRefs=false \
     -+		history squash start.. 2>err &&
     -+	test_grep "^error: a branch points to" err &&
     -+	test_grep ! "hint:" err &&
     + 
     + 	test_must_fail git -c advice.historyUpdateRefs=false \
     + 		history squash start.. 2>err &&
     + 	test_grep "^error: the following branches cannot be rewritten" err &&
     + 	test_grep "^  mid$" err &&
     + 	test_grep ! "hint:" err &&
      +	test_cmp_rev "$head_before" HEAD &&
     -+
     -+	git branch -D mid
     -+'
     -+
     + 
     + 	git branch -D mid
     + '
     + 
      +test_expect_success 'leaves tags and remote-tracking refs unchanged' '
      +	git reset --hard three &&
      +	git tag -f mark HEAD~1 &&
     @@ t/t3455-history-squash.sh (new)
      +	head_before=$(git rev-parse HEAD) &&
      +
      +	test_must_fail git history squash start.. 2>err &&
     -+	# TODO: test for branch nome "at-merge"
     -+	test_grep "a branch points to a commit" err &&
     ++	test_grep "^error: the following branches cannot be rewritten" err &&
     ++	test_grep "^  at-merge$" err &&
      +	test_cmp_rev "$head_before" HEAD &&
      +
      +	git branch -D at-merge
      +'
      +
     -+test_done
     + test_done
 -:  ---------- > 8:  821217ed7c history: support editing squashed commit messages

-- 
gitgitgadget
