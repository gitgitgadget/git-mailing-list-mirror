Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F843CB2F6
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784536029; cv=none; b=iLs6nAlJtrRZx7iNajXVm27g5EZDZSeKPwV9vfDpEm1cG8GFKgZpsV1DNwkrhfgoqzURm/5lRFk3KJA4qeP1t2XZqPQRrchJeISGtK3aRIzZzW6lCkaZ/iYo4Ot0JBAcvJt2LJuboR/aauS7QCv4mhSxPu0Kmiti6h/Rj3f0FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784536029; c=relaxed/simple;
	bh=dqsi3Mbp8kqXNbsY/7O32Tl0nAqAN3ZlmzfUiqASxkQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uiKMzBE0TTrw1G+WQ2+XjikVHTHL+ewBgxAoa/TG3gg24dMNqOgCHK/5dKoxn3+IYgLAYvSkGCupt1mZFBwI93oMtC598kXy5n65FlNTeUkLAInw8RiiqttQZYw61JqlG8kuXY1F2SUSRjcNlYccF89cPrNw2JMaVaoYs98NwXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO0H+9T3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO0H+9T3"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51c1372f84dso62595051cf.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2026 01:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784536027; x=1785140827; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4P7Mq3oZrX89gN1u0fszkJilY00B/7uTTPMX92EGjNc=;
        b=TO0H+9T3jjSkEfpVnJ2NDbJGuUKKV2e/IIG3DnD/otO94ALyh9a0VEG+SP6Eid3m2N
         Os2ykiOnFAUuM5P+evENDf41ICqi4vf3N4fHLB0igzm7bDsUqfC4s2L+TZhT7ModV43w
         w6oYwA8RYD+BXGfSRN9fD5zPYQdfBJ4K68Ct2P/d3DZMb+DJ+Z71H4yUBMirrUa0yScR
         yD3tUife5NCajEKLdigfZf6fWmlo30tDqjl8EYSrbXEyWx3CIgbQvyW2WUPJL+mSpSY8
         CoygB03VqibudWAVdWCZ8jYqWjBsrqnRUI+ybB+IdiijhGs1UPKfqJvyIUy+KHKY7EDV
         3AbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784536027; x=1785140827;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4P7Mq3oZrX89gN1u0fszkJilY00B/7uTTPMX92EGjNc=;
        b=b67FvlA+aET7g7XvR2160MrHNnkbuZ5cR8mxii8gdHCphyRZpmI6hI4T3DVLp2wHMf
         fKLU5JovVxgxkzanyhIfieSWKRh/OPEN7moi4eaB+5CMWblnukMgdJxPU6TSwc/g3Hdc
         Yg8fZ8P0hXAc/X2pb1BuE9Q32q/eoK6ep9JkXqAmRMV/jnht6AmBOin6+0qo+BwIWAwN
         BVWOxCLQ14ip0iKBM0BgN6fPxJpXeIG9JTjix1SCy6qS2toqAaSjhvbdkQHdUbad2oXH
         U0r5K9L/n9XY1pUG4Ce8uM+BRmbzq78QIoU4TNwZahMRB2koBTda2pYTNg6arGauTuzN
         0EDg==
X-Gm-Message-State: AOJu0YyUBKgNkcIACpVlICjCiRrrFgit7nIwskUZX6WpUfyfJddNYMJ4
	i7mynI/VPFNj2MUixSR050alTCmK4mcUGGM3eFE0sgy7B+RXTiocBF8UA+FsrQ==
X-Gm-Gg: AfdE7cluUkBbLmSRc8S15hxlYxJYACA0vbx6RMxl+MlMhD63bpj2NqB4tDltVcsTOW1
	e64L/XCnrmh+EYByEfmlp3hWCvcS4vehQzlsuiu0tnIDVGNQHUAAgTlFp7hkj2PHkSNNAdBfRZw
	E787ukk0wlZEPgySLNQzKEFHq9rIYHOB7woJMdybz//IPXRpuflWRny3juGTd9oOaqp0QCHJCkA
	tEROm78h10YQFEz8b0XRp2pdaIlFZkb9J+NzB+v2Q2I610KruTe9gZHbSmcrEQ2Edimi4Qza0zS
	4bWsEUeRtNrUKD7HfBU3YbS9WQZqIdQ9dIHU7w3/2TVy2QKgT3iG1kuE7LIsyaT2tC7z230iT/5
	uAB5gWrEEMBuDqirxD+yyw6jvWSPaWbqZ2RVD2Q9qUcBL8NyNlRfTSwveAYfpiHZRkMCupMivbL
	mxThUe3mo=
X-Received: by 2002:ac8:5f4f:0:b0:517:c65c:488b with SMTP id d75a77b69052e-52137df1584mr117768311cf.0.1784536025868;
        Mon, 20 Jul 2026 01:27:05 -0700 (PDT)
Received: from [127.0.0.1] ([172.174.110.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214d09bb08sm68202031cf.12.2026.07.20.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 01:27:05 -0700 (PDT)
Message-Id: <pull.2337.v10.git.git.1784536024.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
References: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 20 Jul 2026 08:26:59 +0000
Subject: [PATCH v10 0/5] history: add squash subcommand to fold a range
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

Harald Nordgren (5):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  history: add squash subcommand to fold a range
  sequencer: share the squash message marker helpers and flags
  history: re-edit a squash with every message

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  55 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 552 ++++++++++++++++++++--
 sequencer.c                      |  70 +--
 sequencer.h                      |  30 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 770 +++++++++++++++++++++++++++++++
 9 files changed, 1412 insertions(+), 72 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 41365c2a9ba347870b80881c0d67454edd22fd49
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v10
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v10
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v9:

 1:  352c818c29 = 1:  f848103497 history: extract helper for a commit's parent tree
 2:  e06e49095b = 2:  49dadc3410 history: give commit_tree_ext a message template
 3:  ead974c317 ! 3:  6b5b2c93f2 history: add squash subcommand to fold a range
     @@ Documentation/config/advice.adoc: all advice messages.
       		set as executable.
      
       ## Documentation/git-history.adoc ##
     -@@ Documentation/git-history.adoc: SYNOPSIS
     +@@ Documentation/git-history.adoc: git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(
       git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
       git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
       git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      ++
      +A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
      +targets is also in the range, so the fold does not silently absorb a
     -+marker meant for a commit outside it. The body after an `amend!` subject
     -+replaces the oldest commit's message when the marker targets that commit. As
     -+an exception, a range made up entirely of markers for one target is combined
     -+into a single commit, keeping the last `amend!` message if there is one.
     ++marker meant for a commit outside it. As an exception, a range made up entirely
     ++of markers for one target is combined into a single commit, keeping the last
     ++`amend!` message if there is one.
      ++
      +A branch or tag that points at a commit inside the range would be left
      +dangling once those commits are folded away, so with the default
     @@ Documentation/git-history.adoc: OPTIONS
       
       `--reedit-message`::
      -	Open an editor to modify the target commit's message.
     -+	Open an editor to modify the rewritten commit's message. For `squash`
     -+	the editor is pre-filled with the messages of all the folded commits.
     ++	Open an editor to modify the rewritten commit's message.
       
       `--empty=(drop|keep|abort)`::
       	Control what happens when a commit becomes empty as a result of the
     @@ builtin/history.c: out:
      +
      +	if (revs.reverse != 1 || revs.topo_order != 1 ||
      +	    revs.sort_order != REV_SORT_IN_GRAPH_ORDER ||
     -+	    revs.simplify_history != 0) {
     ++	    revs.simplify_history != 0 || revs.boundary != 1) {
      +		warning(_("ignoring rev-list options that would change how the "
      +			  "range is walked"));
      +		revs.reverse = 1;
      +		revs.topo_order = 1;
      +		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
      +		revs.simplify_history = 0;
     ++		revs.boundary = 1;
      +	}
      +
      +	/*
     @@ builtin/history.c: out:
      +		goto out;
      +	}
      +
     -+	strbuf_addf(&reflog_msg, "squash: updating %s", argv[0]);
     ++	strbuf_addstr(&reflog_msg, "squash: updating ");
     ++	strbuf_join_argv(&reflog_msg, argc, argv, ' ');
      +
      +	ret = handle_reference_updates(&revs, action, tip, rewritten,
      +				       reflog_msg.buf, dry_run,
     @@ builtin/history.c: out:
      +	return ret;
      +}
      +
     - int cmd_history(int argc,
     - 		const char **argv,
     - 		const char *prefix,
     + static int update_worktree(struct repository *repo,
     + 			   const struct commit *old_head,
     + 			   const struct commit *new_head,
      @@ builtin/history.c: int cmd_history(int argc,
       		GIT_HISTORY_FIXUP_USAGE,
       		GIT_HISTORY_REWORD_USAGE,
     @@ builtin/history.c: int cmd_history(int argc,
      
       ## t/meson.build ##
      @@ t/meson.build: integration_tests = [
     -   't3451-history-reword.sh',
         't3452-history-split.sh',
         't3453-history-fixup.sh',
     +   't3454-history-drop.sh',
      +  't3455-history-squash.sh',
         't3500-cherry.sh',
         't3501-revert-cherry-pick.sh',
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start..HEAD ^keep &&
      +
     ++	git reflog -1 --format=%gs >actual &&
     ++	echo "squash: updating start..HEAD ^keep" >expect &&
     ++	test_cmp expect actual &&
     ++
      +	check_log_subjects start..HEAD <<-\EOF &&
      +	two
      +	one
 4:  08915cee51 = 4:  41156c9afb sequencer: share the squash message marker helpers and flags
 5:  fb76afe31c ! 5:  cdbc183428 history: re-edit a squash with every message
     @@ Documentation/git-history.adoc: already on `topic`. Rev-list options may also be
       +
       A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
       targets is also in the range, so the fold does not silently absorb a
     -@@ Documentation/git-history.adoc: marker meant for a commit outside it. The body after an `amend!` subject
     - replaces the oldest commit's message when the marker targets that commit. As
     - an exception, a range made up entirely of markers for one target is combined
     - into a single commit, keeping the last `amend!` message if there is one.
     -+The changes from every commit in the range are always folded in. Only the
     -+message text differs.
     +@@ Documentation/git-history.adoc: marker meant for a commit outside it. As an exception, a range made up entirely
     + of markers for one target is combined into a single commit, keeping the last
     + `amend!` message if there is one.
     + +
      +With `--reedit-message` the template mirrors `git rebase -i --autosquash`:
      +each `fixup!`, `squash!`, or `amend!` is grouped under the commit it
      +targets rather than shown in commit order. A `fixup!` message is dropped
     @@ Documentation/git-history.adoc: marker meant for a commit outside it. The body a
      +subject commented, and an `amend!` replaces its target's message, unless
      +a `squash!` folded into that target first, in which case it keeps its
      +body like a `squash!`.
     - +
     +++
       A branch or tag that points at a commit inside the range would be left
       dangling once those commits are folded away, so with the default
     + `--update-refs=branches` the command refuses. Rerun with
     +@@ Documentation/git-history.adoc: OPTIONS
     + 	ref updates is generally safe.
     + 
     + `--reedit-message`::
     +-	Open an editor to modify the rewritten commit's message.
     ++	Open an editor to modify the rewritten commit's message. For `squash`
     ++	the editor is pre-filled with the messages of all the folded commits.
     + 
     + `--empty=(drop|keep|abort)`::
     + 	Control what happens when a commit becomes empty as a result of the
      
       ## builtin/history.c ##
      @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, void *cb_data)

-- 
gitgitgadget
