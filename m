Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F663BB690
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 09:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674404; cv=none; b=HPanw/DMkri2V693lAMWhxdE48LzZD5P0NCykGf3EB9T1HDJsvYi4KWooHpgWRrG55kkoafRATOs2Vu7jokxiZ0/bKkJWDfB55O2YVNt8oXBtD9aIjmpdf9rp6gv99Un0y9P6SgftUSvNlUBFtmQdmFe0abrMGlMTvgiB1t6HQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674404; c=relaxed/simple;
	bh=fE2Cs94tuxYLF+Pbnp2TqmRU2UQ6IjWwORI3JH7buGs=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=bd8rAEJrWR7JEQ92fdrMZ8qKbFFltvbLc2YY4wNP8HiLJ5N2VZrS++B1EAWFlNkL8tDYtF0ftjX9SZKQDAb9IjO0Buhhf7QpE2hofarWfdeFmmrdZlWb+tEAafTURvMUxiYcQT7bhg+6WQdYyP6pmV0/QROJwXyMcdqGDoGR0AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQYXyen7; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQYXyen7"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6a377223171so260571eaf.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2026 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783674400; x=1784279200; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=C+QTJiPGhS1gqZ6a+2jgJ1IVx22wpJUzlojcLzf1qnM=;
        b=qQYXyen7sbgvOOFcY5jmO2nL3D5bno0yXHwy23S5B/O6Kq1VwrBe0C8dxflfZ2s2L7
         M1Md0tNuuNw3mBoQgpSIMNvUSAwhzWUUi+q4XkS7WqXsS14xU4hKPFy5epDNOsysR7Nz
         PwllhZMUO3MngC+lHSvhZFB14kKQUC9c2yDO2rcwFA2QRQs8jmycr17z+GGhVy+2a588
         p20LJ0PUbo7bTOfN6baa80GBO82GQwgG7v3GycIq2ok/cxjm1kYmZ98BdeWLRo5M/fEB
         XboL8DGD5NYgPNdVSSOaVHf64yDxmZnT43Rd2p6osfTYCPNiiz+tdtNbHMTE/2KEkMYQ
         5K1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783674400; x=1784279200;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+QTJiPGhS1gqZ6a+2jgJ1IVx22wpJUzlojcLzf1qnM=;
        b=hJe2cQ3e5hSXuXUm/24sI2PqjN6l8ifcm3PCX/UjIONNuD/FDsCuGzwOCqcgKQUYKJ
         VM8gy0V4mX2NQpHqLZtC8xIXMgTbX6KgevDVG9NqySRuPVUz9Skc4xTeU/lc8MvCooAN
         BRjdOlbSpLoiW5So/X0uedXwij+5sPUIUu6Pcw/2rc5Nuu0wO/EQHmaBKKsX6J8gxfeo
         0ubkLyr3sVEDsQQeQgBMoqHNx8DvDCQPRxao7AnPt6FdIVbR6QjC/ndI084rHQ16h5G/
         exzmwtYeQNCDbn03PoRZBxTSxiDZVOsfs9jHyWQpo9NWHZwW8KcHUCgHF5VNTKozjuHR
         x9zA==
X-Gm-Message-State: AOJu0Yw10nP8a/pQy6YpNKCZeiPxgwRgG41nVh3zVDdK7rmuw/BYIB0P
	EpDG4rSiIIJCG5ptv3lb5MdSZtwyrTCtwprhEqqdiOKkNlr3W7V7BgIzjnAacg==
X-Gm-Gg: AfdE7cn2QDNCUihXh8pck11yNRS5JKouJrfWTyKe9Jem7S2G6ev8+Jay5YeMkKhP/zp
	cVjAbsK8D2wiK4juB3XLK+XzIN1JFwm1QtuXYkVUrYo7HpJWWzEd/NBvubhvabmoSbm06Uby0TV
	8XUaHQSVe8602wpE6qCX9gNmdrTh96J+WFXd8Z8RbIWdQjuefxToy/mfWjvjSlRAmOxyAu5pyU6
	/hXgOScxVUs+OlZXa/EVpcYWaByNhWXHhA3Zil14KUJeS/Aj9ZWiGZr+LrVvQVAHy38kQ+KToOu
	RWVW47iPGOo/aMMV+iWnAH7okfKTZGwUENqfQyIVJAw2iKrJow/K1kqPE+C17IfV3pKhV3UsKW8
	+viX4j5uyWtG84BUVrYHeGhp1/CVnr6jZg4gNppmqN88BoC9e9WcePI9g8ezV5uMpUD8rBS3VMA
	dCepDBsKBdD80VO7Y=
X-Received: by 2002:a05:6820:290c:b0:6a3:5be4:a803 with SMTP id 006d021491bc7-6a36d974070mr7768459eaf.28.1783674399707;
        Fri, 10 Jul 2026 02:06:39 -0700 (PDT)
Received: from [127.0.0.1] ([52.154.20.197])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-451912444f0sm4287093fac.1.2026.07.10.02.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 02:06:37 -0700 (PDT)
Message-Id: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
References: <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jul 2026 09:06:31 +0000
Subject: [PATCH v8 0/5] history: add squash subcommand to fold a range
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
 Documentation/git-history.adoc   |  54 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 522 +++++++++++++++++++--
 sequencer.c                      |  70 +--
 sequencer.h                      |  30 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 776 +++++++++++++++++++++++++++++++
 9 files changed, 1387 insertions(+), 72 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: f85a7e662054a7b0d9070e432508831afa214b47
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v8
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v7:

 1:  56ed8fadbb = 1:  ba77752282 history: extract helper for a commit's parent tree
 2:  212e9c228f = 2:  50f3572887 history: give commit_tree_ext a message template
 3:  cf3346a1cd ! 3:  2d81a40a05 history: add squash subcommand to fold a range
     @@ Commit message
          every commit in the range into the oldest one, keeping that commit's
          message and authorship and taking the tree of the newest commit, then
          replays the commits above the range on top. The squashed message comes
     -    from the oldest commit, or from an editor with --reedit-message. As that
     -    message is reused, a range whose oldest commit is a fixup!, squash! or
     -    amend! is refused, since the marker's target cannot be in the range.
     +    from the oldest commit, or from an editor with --reedit-message. A
     +    fixup!, squash! or amend! commit is refused unless the commit it targets
     +    is also in the range, so the fold does not silently absorb a marker meant
     +    for a commit outside it. The check runs the range through
     +    todo_list_rearrange_squash(), which leaves such a marker as a plain pick.
     +    Markers whose target is in the range fold in as usual. As an exception, a
     +    range made up entirely of markers for one target is combined anyway,
     +    taking its message from the last amend! if there is one, so a batch of
     +    fixups for the same commit can be collapsed.
      
          The range is read like the arguments to "git rev-list", so several
     -    arguments such as "HEAD~3..HEAD ^topic" are allowed. A merge inside the
     -    range is folded when its other parent is reachable from the base,
     -    otherwise the range has more than one base and is rejected. By default
     -    the command also refuses when a ref points at a commit that the fold
     -    would discard. Use --update-refs=head to rewrite only the current branch
     -    instead.
     +    revisions such as "HEAD~3..HEAD ^topic" may be given, and rev-list
     +    options are accepted too. As "git replay" does, the walk options the fold
     +    relies on are forced after setup_revisions() and a warning is printed if
     +    an option changed them, so the first commit returned is the range's
     +    oldest and its parent is the base regardless of what the user passed
     +    (including after a "--"). A merge inside the range is folded when its
     +    other parent is reachable from the base, otherwise the range has more
     +    than one base and is rejected. By default the command also refuses when a
     +    ref points at a commit that the fold would discard. Use --update-refs=head
     +    to rewrite only the current branch instead.
      
          Inspired-by: Sergey Chernov <serega.morph@gmail.com>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +the commit just below the oldest commit to squash. For example, `git
      +history squash HEAD~3..HEAD` folds the three most recent commits into
      +one, and `git history squash HEAD~5..HEAD~2` squashes an interior range
     -+while leaving the two newest commits in place. _<revision-range>_ is read
     -+like the arguments to linkgit:git-rev-list[1], so several arguments may be
     ++while leaving the two newest commits in place. Several revisions may be
      +given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
     -+already on `topic`.
     ++already on `topic`. Rev-list options may also be given, but any that would
     ++change how the range is walked are overridden with a warning.
      ++
      +The oldest commit's message and authorship are preserved by default,
      +unless you specify `--reedit-message`. A merge commit inside the range is
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +that reaches more than one entry point (for example a side branch that
      +forked before the range and was later merged into it) is rejected.
      ++
     -+Because the oldest commit's message is reused, the range may not begin
     -+with a `fixup!`, `squash!`, or `amend!` commit, whose target is
     -+necessarily outside the range.
     ++A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
     ++targets is also in the range, so the fold does not silently absorb a
     ++marker meant for a commit outside it. As an exception, a range made up
     ++entirely of markers for one target is combined into a single commit,
     ++keeping the last `amend!` message if there is one.
      ++
      +A branch or tag that points at a commit inside the range would be left
      +dangling once those commits are folded away, so with the default
     @@ builtin/history.c: out:
      +	int ret;
      +
      +	repo_init_revisions(repo, &revs, NULL);
     ++	revs.reverse = 1;
     ++	revs.topo_order = 1;
     ++	revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
     ++	revs.simplify_history = 0;
     ++	revs.boundary = 1;
     ++
      +	strvec_push(&args, "ignored");
     -+	strvec_push(&args, "--reverse");
     -+	strvec_push(&args, "--topo-order");
     -+	strvec_push(&args, "--boundary");
      +	strvec_push(&args, "--ancestry-path");
      +	strvec_pushv(&args, argv);
      +	setup_revisions_from_strvec(&args, &revs, NULL);
     @@ builtin/history.c: out:
      +		goto out;
      +	}
      +
     ++	if (revs.reverse != 1 || revs.topo_order != 1 ||
     ++	    revs.sort_order != REV_SORT_IN_GRAPH_ORDER ||
     ++	    revs.simplify_history != 0) {
     ++		warning(_("ignoring rev-list options that would change how the "
     ++			  "range is walked"));
     ++		revs.reverse = 1;
     ++		revs.topo_order = 1;
     ++		revs.sort_order = REV_SORT_IN_GRAPH_ORDER;
     ++		revs.simplify_history = 0;
     ++	}
     ++
      +	/*
      +	 * A squash needs a base to reparent onto, so the range has to exclude
      +	 * something, as in "<base>..<tip>". A revision range with no such
     @@ builtin/history.c: out:
      +		goto out;
      +	}
      +
     ++	/*
     ++	 * Set boundary commits aside for the base check below, and put every
     ++	 * in-range commit but the tip into the interior set. A ref pointing
     ++	 * at an interior commit would dangle once the range is folded away.
     ++	 */
      +	while ((commit = get_revision(&revs))) {
      +		if (commit->object.flags & BOUNDARY) {
      +			commit_list_insert(commit, &boundaries);
     @@ builtin/history.c: out:
      +	if (!oldest) {
      +		ret = error(_("the revision range is empty"));
      +		goto out;
     -+	}
     -+
     -+	if (oldest == tip) {
     ++	} else if (oldest == tip) {
      +		ret = error(_("the revision range holds a single commit; "
      +			      "nothing to squash"));
      +		goto out;
     -+	}
     -+
     -+	if (!oldest->parents)
     ++	} else if (!oldest->parents) {
      +		BUG("an in-range commit must have a parent");
     ++	}
      +	base = oldest->parents->item;
      +
      +	/*
     @@ builtin/history.c: out:
      +	return ret;
      +}
      +
     -+static int reject_fixupish_oldest(struct repository *repo,
     -+				  struct commit *oldest)
     ++static const char *autosquash_target(const char *subject)
     ++{
     ++	const char *rest;
     ++
     ++	while (skip_prefix(subject, "fixup! ", &rest) ||
     ++	       skip_prefix(subject, "squash! ", &rest) ||
     ++	       skip_prefix(subject, "amend! ", &rest))
     ++		subject = rest;
     ++	return subject;
     ++}
     ++
     ++static int reject_dangling_fixups(struct repository *repo,
     ++				  struct commit *base,
     ++				  struct commit *tip,
     ++				  struct commit *oldest,
     ++				  struct commit **msg_source)
      +{
     -+	const char *message, *subject;
     -+	int ret = 0;
     -+
     -+	message = repo_logmsg_reencode(repo, oldest, NULL, NULL);
     -+	find_commit_subject(message, &subject);
     -+	if (starts_with(subject, "fixup! ") ||
     -+	    starts_with(subject, "squash! ") ||
     -+	    starts_with(subject, "amend! "))
     -+		ret = error(_("the range begins with a fixup!, squash! or amend! "
     -+			      "commit whose target is not in the range"));
     -+	repo_unuse_commit_buffer(repo, oldest, message);
     ++	struct todo_list todo = TODO_LIST_INIT;
     ++	struct replay_opts opts = REPLAY_OPTS_INIT;
     ++	struct rev_info revs;
     ++	struct commit *commit, *last_amend = NULL;
     ++	struct strvec args = STRVEC_INIT;
     ++	char *dangling_subject = NULL, *dangling_target = NULL;
     ++	bool mixed_target = false, all_fixups_one_target;
     ++	int i, ret, nr_dangling = 0;
     ++
     ++	*msg_source = oldest;
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
     ++	while ((commit = get_revision(&revs)))
     ++		strbuf_addf(&todo.buf, "pick %s\n",
     ++			    oid_to_hex(&commit->object.oid));
     ++
     ++	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
     ++	    todo_list_rearrange_squash(&todo) < 0) {
     ++		ret = error(_("could not check the range for fixups"));
     ++		goto out;
     ++	}
     ++
     ++	for (i = 0; i < todo.nr; i++) {
     ++		const char *message, *subject_start, *target;
     ++		char *subject;
     ++		size_t sublen;
     ++
     ++		if (todo.items[i].command != TODO_PICK)
     ++			continue;
     ++		message = repo_logmsg_reencode(repo, todo.items[i].commit,
     ++					       NULL, NULL);
     ++		sublen = find_commit_subject(message, &subject_start);
     ++		subject = xmemdupz(subject_start, sublen);
     ++		target = autosquash_target(subject);
     ++		if (target != subject) {
     ++			nr_dangling++;
     ++			if (!dangling_target) {
     ++				dangling_target = xstrdup(target);
     ++				dangling_subject = xstrdup(subject);
     ++			} else if (strcmp(dangling_target, target)) {
     ++				mixed_target = true;
     ++			}
     ++			if (starts_with(subject, "amend! "))
     ++				last_amend = todo.items[i].commit;
     ++		}
     ++		free(subject);
     ++		repo_unuse_commit_buffer(repo, todo.items[i].commit, message);
     ++	}
     ++
     ++	all_fixups_one_target = nr_dangling == todo.nr && !mixed_target;
     ++	if (nr_dangling && !all_fixups_one_target) {
     ++		ret = error(_("cannot squash '%s': its target is not in the "
     ++			      "range"), dangling_subject);
     ++	} else {
     ++		if (last_amend)
     ++			*msg_source = last_amend;
     ++		ret = 0;
     ++	}
     ++
     ++out:
     ++	free(dangling_subject);
     ++	free(dangling_target);
     ++	todo_list_release(&todo);
     ++	replay_opts_release(&opts);
     ++	reset_revision_walk();
     ++	release_revisions(&revs);
     ++	strvec_clear(&args);
      +	return ret;
      +}
      +
     @@ builtin/history.c: out:
      +	};
      +	struct strbuf reflog_msg = STRBUF_INIT;
      +	struct oidset interior = OIDSET_INIT;
     -+	struct commit *base, *oldest, *tip, *rewritten;
     ++	struct commit *base, *oldest, *tip, *rewritten, *msg_source;
      +	const struct object_id *base_tree_oid, *tip_tree_oid;
      +	struct commit_list *parents = NULL;
      +	struct rev_info revs = { 0 };
      +	int ret;
      +
     -+	argc = parse_options(argc, argv, prefix, options, usage, 0);
     ++	argc = parse_options(argc, argv, prefix, options, usage,
     ++			     PARSE_OPT_KEEP_UNKNOWN_OPT);
      +	if (!argc) {
      +		ret = error(_("command expects a revision range"));
      +		goto out;
     @@ builtin/history.c: out:
      +	if (ret < 0)
      +		goto out;
      +
     -+	ret = reject_fixupish_oldest(repo, oldest);
     ++	ret = reject_dangling_fixups(repo, base, tip, oldest, &msg_source);
      +	if (ret < 0)
      +		goto out;
      +
     @@ builtin/history.c: out:
      +	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
      +	commit_list_append(base, &parents);
      +
     -+	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
     ++	ret = commit_tree_ext(repo, "squash", msg_source, NULL, parents,
      +			      base_tree_oid, tip_tree_oid, &rewritten, flags);
      +	if (ret < 0) {
      +		ret = error(_("failed writing squashed commit"));
     @@ t/t3455-history-squash.sh (new)
      +	test_grep "squash: updating" reflog
      +'
      +
     ++test_expect_success 'sanitizes rev-list walk options, before and after --' '
     ++	git reset --hard three &&
     ++	tip_tree=$(git rev-parse HEAD^{tree}) &&
     ++
     ++	git history squash --date-order start.. 2>err &&
     ++	test_grep "ignoring rev-list options" err &&
     ++	test_cmp_rev start HEAD^ &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     ++
     ++	git reset --hard three &&
     ++	git history squash -- --reverse start.. 2>err &&
     ++	test_grep "ignoring rev-list options" err &&
     ++	test_cmp_rev start HEAD^ &&
     ++	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
     ++'
     ++
      +test_expect_success 'squashes an interior range and replays descendants verbatim' '
      +	git reset --hard three &&
      +	final_tree=$(git rev-parse HEAD^{tree}) &&
     @@ t/t3455-history-squash.sh (new)
      +'
      +
      +
     -+test_expect_success 'reuses the message of a fixup! commit in the range' '
     ++test_expect_success 'folds fixups whose target is in the range' '
      +	git reset --hard start &&
     -+	test_commit --no-tag reg1 file b &&
     -+	git commit --allow-empty -m "fixup! reg1" &&
     -+	test_commit reg2 file c &&
     ++	test_commit --no-tag target file b &&
     ++	git commit --allow-empty -m "fixup! target" &&
     ++	git commit --allow-empty -m "fixup! target" &&
     ++	test_commit --no-tag later file c &&
      +
      +	git history squash start.. &&
      +
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
      +	git log --format="%s" -1 >actual &&
     -+	echo reg1 >expect &&
     ++	echo target >expect &&
      +	test_cmp expect actual
      +'
      +
     -+test_expect_success 'refuses a range whose oldest commit is a fixup!' '
     ++test_expect_success 'refuses a below-range fixup! after an in-range commit' '
      +	git reset --hard start &&
     -+	test_commit --no-tag "fixup! something" file b &&
     -+	test_commit --no-tag tail file c &&
     ++	test_commit --no-tag inside file b &&
     ++	test_commit --no-tag "fixup! outside" file c &&
      +	head_before=$(git rev-parse HEAD) &&
      +
      +	test_must_fail git history squash start.. 2>err &&
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp_rev "$head_before" HEAD
      +'
      +
     -+test_expect_success 'does not interpret squash! or amend! markers' '
     ++test_expect_success 'combines a run of fixups for one commit below the range' '
     ++	git reset --hard start &&
     ++	echo b >file && git add file && git commit -m "fixup! base" &&
     ++	echo c >file && git add file && git commit -m "fixup! base" &&
     ++
     ++	git history squash start.. &&
     ++
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	git log --format="%s" -1 >actual &&
     ++	echo "fixup! base" >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'combining below-range fixups keeps the last amend! message' '
     ++	git reset --hard start &&
     ++	echo b >file && git add file && git commit -m "fixup! base" &&
     ++	printf "amend! base\n\namended body\n" >msg &&
     ++	echo c >file && git add file && git commit -qF msg &&
     ++
     ++	git history squash start.. &&
     ++
     ++	git rev-list --count start..HEAD >count &&
     ++	echo 1 >expect &&
     ++	test_cmp expect count &&
     ++	git log --format="%s" -1 >actual &&
     ++	echo "amend! base" >expect &&
     ++	test_cmp expect actual &&
     ++	git log --format="%b" -1 >body &&
     ++	test_grep "amended body" body
     ++'
     ++
     ++test_expect_success 'refuses fixups for two different commits below the range' '
     ++	git reset --hard start &&
     ++	echo b >file && git add file && git commit -m "fixup! aaa" &&
     ++	echo c >file && git add file && git commit -m "fixup! bbb" &&
     ++	head_before=$(git rev-parse HEAD) &&
     ++
     ++	test_must_fail git history squash start.. 2>err &&
     ++	test_grep "target is not in the range" err &&
     ++	test_cmp_rev "$head_before" HEAD
     ++'
     ++
     ++test_expect_success 'keeps the oldest message for in-range squash! and amend!' '
      +	git reset --hard start &&
      +	test_commit --no-tag marker-oldest file b &&
      +	git commit --allow-empty -m "squash! marker-oldest" &&
     @@ t/t3455-history-squash.sh (new)
      +test_expect_success 'advice.historyUpdateRefs silences the hint' '
      +	git reset --hard three &&
      +	git branch -f mid HEAD~1 &&
     ++	head_before=$(git rev-parse HEAD) &&
      +
      +	test_must_fail git -c advice.historyUpdateRefs=false \
      +		history squash start.. 2>err &&
      +	test_grep "points into the squashed range" err &&
      +	test_grep ! "hint:" err &&
     ++	test_cmp_rev "$head_before" HEAD &&
      +
      +	git branch -D mid
      +'
     @@ t/t3455-history-squash.sh (new)
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
      +'
      +
     -+test_expect_success 'refuses to squash a range with more than one base' '
     -+	git reset --hard start &&
     -+	main=$(git symbolic-ref --short HEAD) &&
     -+	git checkout -b forked-before &&
     -+	test_commit forked-side fside x &&
     -+	git checkout "$main" &&
     -+	test_commit forked-base file b &&
     -+	base=$(git rev-parse HEAD) &&
     -+	test_commit forked-main file c &&
     -+	git merge --no-ff -m merge forked-before &&
     -+	merged=$(git rev-parse HEAD) &&
     -+
     -+	test_must_fail git history squash "$base.." 2>err &&
     -+	test_grep "more than one base" err &&
     -+	test_cmp_rev "$merged" HEAD
     -+'
     -+
      +test_expect_success 'folds a range with two interior merges' '
      +	git reset --hard start &&
      +	main=$(git symbolic-ref --short HEAD) &&
 4:  001356db93 ! 4:  0a735117ad sequencer: extract helpers for the squash message markers
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    sequencer: extract helpers for the squash message markers
     +    sequencer: share the squash message marker helpers and flags
      
          When "git rebase -i" squashes commits it builds an editor template with a
          "This is a combination of N commits." banner, a "This is the 1st/Nth
     @@ Commit message
          Pull the three pieces out into add_squash_combination_header(),
          add_squash_message_header() (which takes a flag for the "will be skipped"
          variant) and squash_subject_comment_len(), and use them from
     -    update_squash_messages() and append_squash_message(). A later change
     -    reuses them to give "git history squash --reedit-message" the same
     -    template.
     +    update_squash_messages() and append_squash_message(). Also move the
     +    todo_item_flags enum to the header, so a caller reading the output of
     +    todo_list_rearrange_squash() can tell an amend! (TODO_REPLACE_FIXUP_MSG)
     +    from a plain fixup!. A later change reuses all of this to give "git
     +    history squash --reedit-message" the same template.
      
          No change in behavior.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## sequencer.c ##
     -@@ sequencer.c: static const char skip_first_commit_msg_str[] = N_("The 1st commit message will
     +@@ sequencer.c: static int is_pick_or_similar(enum todo_command command)
     + 	}
     + }
     + 
     +-enum todo_item_flags {
     +-	TODO_EDIT_MERGE_MSG    = (1 << 0),
     +-	TODO_REPLACE_FIXUP_MSG = (1 << 1),
     +-	TODO_EDIT_FIXUP_MSG    = (1 << 2),
     +-};
     +-
     + static const char first_commit_msg_str[] = N_("This is the 1st commit message:");
     + static const char nth_commit_msg_fmt[] = N_("This is the commit message #%d:");
     + static const char skip_first_commit_msg_str[] = N_("The 1st commit message will be skipped:");
       static const char skip_nth_commit_msg_fmt[] = N_("The commit message #%d will be skipped:");
       static const char combined_commit_msg_fmt[] = N_("This is a combination of %d commits.");
       
     @@ sequencer.c: static int update_squash_messages(struct repository *r,
       					   comment_line_str);
      
       ## sequencer.h ##
     +@@ sequencer.h: enum todo_command {
     + 	TODO_COMMENT
     + };
     + 
     ++/* Bits for the "flags" member of struct todo_item */
     ++enum todo_item_flags {
     ++	TODO_EDIT_MERGE_MSG    = (1 << 0),
     ++	TODO_REPLACE_FIXUP_MSG = (1 << 1),
     ++	TODO_EDIT_FIXUP_MSG    = (1 << 2),
     ++};
     ++
     + struct todo_item {
     + 	enum todo_command command;
     + 	struct commit *commit;
      @@ sequencer.h: int todo_list_rearrange_squash(struct todo_list *todo_list);
        */
       void append_signoff(struct strbuf *msgbuf, size_t ignore_footer, unsigned flag);
 5:  615fe4dd3f ! 5:  baf7e6f0a6 history: re-edit a squash with every message
     @@ Commit message
      
          By default "git history squash" reuses the oldest commit's message.
          When --reedit-message is given it only reopened that one message, so the
     -    messages of the folded-in commits were lost.
     +    messages of the other commits in the range were lost.
      
     -    Gather the messages of every commit in the range, oldest first, and build
     -    the same editor template that "git rebase -i" shows for a squash, using
     +    Gather the message of every commit in the range and build the same editor
     +    template that "git rebase -i --autosquash" shows for a squash, reusing
          add_squash_combination_header(), add_squash_message_header() and
     -    squash_subject_comment_len(). Only the message text differs, the changes
     -    are always folded in. Following autosquash, a fixup!'s message is
     -    commented out in full under a "will be skipped" header, while a squash! or
     -    amend! keeps its body with only the marker subject commented.
     +    squash_subject_comment_len(). Feed the range through
     +    todo_list_rearrange_squash() so that each fixup!, squash! or amend! is
     +    grouped under the commit it targets rather than shown in commit order,
     +    exactly as autosquash would arrange them.
     +
     +    Only the message text differs, the changes are always folded in. A fixup!
     +    message is commented out in full under a "will be skipped" header, a
     +    squash! keeps its body with only the marker subject commented, and an
     +    amend! replaces its target's message unless a squash! already folded into
     +    that target, in which case it behaves like a squash!.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-history.adoc ##
     -@@ Documentation/git-history.adoc: like the arguments to linkgit:git-rev-list[1], so several arguments may be
     - given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
     - already on `topic`.
     +@@ Documentation/git-history.adoc: given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
     + already on `topic`. Rev-list options may also be given, but any that would
     + change how the range is walked are overridden with a warning.
       +
      -The oldest commit's message and authorship are preserved by default,
      -unless you specify `--reedit-message`. A merge commit inside the range is
     @@ Documentation/git-history.adoc: like the arguments to linkgit:git-rev-list[1], s
       folded like any other, but the range must have a single base, so a range
       that reaches more than one entry point (for example a side branch that
       forked before the range and was later merged into it) is rejected.
     - +
     - Because the oldest commit's message is reused, the range may not begin
     - with a `fixup!`, `squash!`, or `amend!` commit, whose target is
     --necessarily outside the range.
     -+necessarily outside the range. The changes from every commit in the range
     -+are always folded in. Only the message text differs. With
     -+`--reedit-message` the template mirrors `git rebase -i`: the message of a
     -+`fixup!` elsewhere in the range is commented out in full, while a
     -+`squash!` or `amend!` keeps its message body with only the marker subject
     -+commented, so you can fold the remark into the result.
     +@@ Documentation/git-history.adoc: A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
     + targets is also in the range, so the fold does not silently absorb a
     + marker meant for a commit outside it. As an exception, a range made up
     + entirely of markers for one target is combined into a single commit,
     +-keeping the last `amend!` message if there is one.
     ++keeping the last `amend!` message if there is one. The changes from every
     ++commit in the range are always folded in. Only the message text differs.
     ++With `--reedit-message` the template mirrors `git rebase -i --autosquash`:
     ++each `fixup!`, `squash!`, or `amend!` is grouped under the commit it
     ++targets rather than shown in commit order. A `fixup!` message is dropped
     ++(commented out in full), a `squash!` keeps its body with only the marker
     ++subject commented, and an `amend!` replaces its target's message, unless
     ++a `squash!` folded into that target first, in which case it keeps its
     ++body like a `squash!`.
       +
       A branch or tag that points at a commit inside the range would be left
       dangling once those commits are folded away, so with the default
     @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, voi
       	return 0;
       }
       
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
      +static int build_squash_message(struct repository *repo,
      +				struct commit *base,
      +				struct commit *tip,
      +				struct strbuf *out)
      +{
     -+	struct commit_list *commits = NULL, **tail = &commits, *c;
      +	struct rev_info revs;
      +	struct commit *commit;
      +	struct strvec args = STRVEC_INIT;
     -+	int n = 0, total, ret;
     ++	struct todo_list todo = TODO_LIST_INIT;
     ++	struct replay_opts opts = REPLAY_OPTS_INIT;
     ++	int i, nr_commits, ret;
      +
      +	repo_init_revisions(repo, &revs, NULL);
      +	strvec_push(&args, "ignored");
     @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, voi
      +	}
      +
      +	while ((commit = get_revision(&revs)))
     -+		tail = &commit_list_insert(commit, tail)->next;
     -+	total = commit_list_count(commits);
     ++		strbuf_addf(&todo.buf, "pick %s\n",
     ++			    oid_to_hex(&commit->object.oid));
      +
     -+	for (c = commits; c; c = c->next) {
     ++	if (todo_list_parse_insn_buffer(repo, &opts, todo.buf.buf, &todo) < 0 ||
     ++	    todo_list_rearrange_squash(&todo) < 0) {
     ++		ret = error(_("could not prepare the squash message"));
     ++		goto out;
     ++	}
     ++
     ++	nr_commits = todo.nr;
     ++	for (i = 0; i < nr_commits; i++) {
     ++		struct todo_item *item = &todo.items[i];
      +		const char *message, *body;
      +		size_t commented_len;
     -+		int skip;
     ++		bool skip, squashing;
      +
     -+		message = repo_logmsg_reencode(repo, c->item, NULL, NULL);
     ++		squashing = item->command == TODO_SQUASH ||
     ++			    (item->flags & TODO_REPLACE_FIXUP_MSG);
     ++		if (item->command == TODO_PICK)
     ++			skip = amend_replaces_target(&todo, i);
     ++		else
     ++			skip = !squashing;
     ++
     ++		message = repo_logmsg_reencode(repo, item->commit, NULL, NULL);
      +		find_commit_subject(message, &body);
      +
     -+		skip = starts_with(body, "fixup! ");
     -+		commented_len = skip ? strlen(body) :
     -+			squash_subject_comment_len(body, 1);
     ++		if (skip)
     ++			commented_len = strlen(body);
     ++		else if (squashing)
     ++			commented_len = squash_subject_comment_len(body, 1);
     ++		else
     ++			commented_len = 0;
      +
     -+		if (!n)
     -+			add_squash_combination_header(out, total);
     ++		if (!i)
     ++			add_squash_combination_header(out, nr_commits);
      +		strbuf_addch(out, '\n');
     -+		add_squash_message_header(out, ++n, skip);
     ++		add_squash_message_header(out, i + 1, skip);
      +		strbuf_addstr(out, "\n\n");
      +		strbuf_add_commented_lines(out, body, commented_len, comment_line_str);
      +		strbuf_addstr(out, body + commented_len);
      +		strbuf_complete_line(out);
      +
     -+		repo_unuse_commit_buffer(repo, c->item, message);
     ++		repo_unuse_commit_buffer(repo, item->commit, message);
      +	}
      +
      +	ret = 0;
      +
      +out:
     -+	commit_list_free(commits);
     ++	todo_list_release(&todo);
     ++	replay_opts_release(&opts);
      +	reset_revision_walk();
      +	release_revisions(&revs);
      +	strvec_clear(&args);
     @@ builtin/history.c: static int cmd_history_squash(int argc,
       	struct strbuf reflog_msg = STRBUF_INIT;
      +	struct strbuf message = STRBUF_INIT;
       	struct oidset interior = OIDSET_INIT;
     - 	struct commit *base, *oldest, *tip, *rewritten;
     + 	struct commit *base, *oldest, *tip, *rewritten, *msg_source;
       	const struct object_id *base_tree_oid, *tip_tree_oid;
      @@ builtin/history.c: static int cmd_history_squash(int argc,
       		}
     @@ builtin/history.c: static int cmd_history_squash(int argc,
       	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
       	commit_list_append(base, &parents);
       
     --	ret = commit_tree_ext(repo, "squash", oldest, NULL, parents,
     -+	ret = commit_tree_ext(repo, "squash", oldest,
     +-	ret = commit_tree_ext(repo, "squash", msg_source, NULL, parents,
     ++	ret = commit_tree_ext(repo, "squash", msg_source,
      +			      message.len ? message.buf : NULL, parents,
       			      base_tree_oid, tip_tree_oid, &rewritten, flags);
       	if (ret < 0) {
     @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +	test_grep "amended message" final
      +'
      +
     ++test_expect_success '--reedit-message groups fixups under their targets' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag alpha file a1 &&
     ++	test_commit --no-tag beta file b1 &&
     ++	printf "fixup! alpha\n" >msg &&
     ++	echo a2 >file &&
     ++	git add file &&
     ++	git commit -qF msg &&
     ++	printf "fixup! beta\n" >msg &&
     ++	echo b2 >file &&
     ++	git add file &&
     ++	git commit -qF msg &&
     ++
     ++	write_script editor <<-\EOF &&
     ++	cat "$1" >edited
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
     ++	git history squash --reedit-message start.. &&
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
     ++test_expect_success '--reedit-message lets amend! replace its target message' '
     ++	git reset --hard start &&
     ++	test_commit --no-tag mark-base file b &&
     ++	printf "amend! mark-base\n\namended message\n" >msg &&
     ++	echo c >file &&
     ++	git add file &&
     ++	git commit -qF msg &&
     ++	printf "squash! mark-base\n\nsquash remark\n" >msg &&
     ++	echo d >file &&
     ++	git add file &&
     ++	git commit -qF msg &&
     ++
     ++	write_script editor <<-\EOF &&
     ++	cat "$1" >edited
     ++	EOF
     ++	test_set_editor "$(pwd)/editor" &&
     ++	git history squash --reedit-message start.. &&
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
     ++	git log -1 --format="%B" >final &&
     ++	test_grep ! "mark-base" final &&
     ++	test_grep "amended message" final &&
     ++	test_grep "squash remark" final
     ++'
     ++
      +test_expect_success '--reedit-message aborts on an empty message' '
      +	git reset --hard three &&
      +	head_before=$(git rev-parse HEAD) &&

-- 
gitgitgadget
