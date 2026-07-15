Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABDD360EC3
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128580; cv=none; b=IULlanbNQ0u/KQjlpjzYFMaKJRw1b/DllMLMnYZba+AksIZz6acyqg+FL/uO8/zLIPB5XIEiYnw3i1FIua0cQWJvgI8+P7WQbB2kL4FWyODeW0I+5bC8H8i0QYAcPB1UflyXNMWoHnWjfViDRSknC9IrSkusUWCQfTnUGRLvkXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128580; c=relaxed/simple;
	bh=nK+u9V2EuIixtjWt590XHd4fSBQwI+ac7+8e3MoZQ1U=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ekb9XlLINd0Kd0VscI9H+9V2dBRghZoFHQpFOlNYpGSN94+IMQYAibz4TuPI1ZEk0nwKXJfYPNA6GHa+KlefzzM5OQ1VbsHCPKqrpyR6gXIzvYedeHgzRYc5Ge8EavZV2Ej1Tg3FweknKwbj4kBEi4+uqSQvXeAnvFg5s7XIXvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTNAVjhz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTNAVjhz"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efbafa1bacso46574096d6.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784128576; x=1784733376; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KgAT/vgqBz71SU6abPfYNuHZBzZYFUfDoALA8QyvAYw=;
        b=BTNAVjhzaapnzfE1VTbiBcEcZlMGRya6MGD0+du1G4vqrq+8YR/VOdgjjH1djhwU/B
         q6YwZTz+Zzm63c3/5p3b2xB02svfTjpbvIwH+kbewit8u0tCJ+tREz2e+9VByYCZ2HEe
         C/zWg4xMlawA80tj48Zno4pIoKZuE0bPNqiIHxmDFZ7pvY66uuTvoQACGonDE+cSbyDZ
         23jeQ9bZkhtwNVcY9fnN1mcYBRS1TCgFsZEIjTT5OlZ7UYrwNO8Dym38K8KTqdHL4Wnl
         BDOWZFM0/jbFc35Lt6GJSVC96y2mVqj66+Uk7/IAKJMTc/3XQrYhFSk+skngIZnFV5pd
         jZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784128576; x=1784733376;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KgAT/vgqBz71SU6abPfYNuHZBzZYFUfDoALA8QyvAYw=;
        b=apWuTzUhgHv7bpYc98QgSh1ifKROoTKbyeGQm1wf+rdx0kxXhRc1mQo2zatIJKuJp2
         zaderkbjmbP1OsgfzzwVE/fzuKo9FN3izjHoUU1FFHyAkqxC98EcJGCu/CP25BCEUpxZ
         WuGIdWpZSbNXA5RLGx6R/sxCsi/VLzt2YZ8co75Hc1cutSUAU9qRBfmeoyiEi0LkGzbo
         N1PjpKi32v416oLMk5WU0LG4mf7pzGcxVpPdE7DlkGoQFmFC3iwZBJU55kA+EYDNn+Lf
         5T3GbbhrlxOOkChhc+EtwlBi+Px7poukZ85gKyAC9rTuUng9AA3U3HnAmd33AtWXtgc2
         0pUg==
X-Gm-Message-State: AOJu0YwazUbz5zg8KVnzVaRuFH0T7i1DnYPTtaLV1MCmkLaza3KC2Abv
	nkokAleSV4YFgB+V4aIJDWezeF6691jMlhD1SlldmtaLsQYYpm3Y9onYPpcc/oD+
X-Gm-Gg: AfdE7cnSdsTcqepJs2lC7XX+zZwkYVN0g0+D0CBLZaboDQgIIHD0mPYkYswzTPNLvC8
	ymJDSA7isOi6INu2xcq1ucerC8g/XJbDkf/MPpChEtMm3kLGIWnEqYQWmfWvKz0Na/S0yJdy499
	wXGAFj1y3doKMlUen9RZK1KoVhQpxbBxyIpBRtP7H39AMUQSdD6RyyR0CkL87V1U6h4yXVqG9IQ
	zKFcvqw0XTitx1VodeIAsWrzBoqeAtabp/HmqjQexTxAXonvzsNJp7KgQjjijnnx/MxRtzDK0a0
	A/mA02PJfjQR85f925ZpWrrd025dINA+bVZROgIOIbZ1hvZQraLqKE8vowTxcpFTB+7lTvhEo+X
	5mxAgjqhenJKaLVdBqdLe8es7Y8F7sA8a/JWqmDJ3jJDUXWJHdiyoSR3zZ4Qz7eHpYtOgO5zVQS
	8T6NADfXHLG4D4iQ8=
X-Received: by 2002:a05:6214:4016:b0:8ef:e0d0:9fae with SMTP id 6a1803df08f44-90758ce74famr34507306d6.14.1784128575948;
        Wed, 15 Jul 2026 08:16:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.83.175.145])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd56c4b91sm196565976d6.19.2026.07.15.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 08:16:15 -0700 (PDT)
Message-Id: <pull.2337.v9.git.git.1784128573.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
References: <pull.2337.v8.git.git.1783674396.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 15 Jul 2026 15:16:08 +0000
Subject: [PATCH v9 0/5] history: add squash subcommand to fold a range
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
 Documentation/git-history.adoc   |  57 ++-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 550 ++++++++++++++++++++--
 sequencer.c                      |  70 +--
 sequencer.h                      |  30 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 766 +++++++++++++++++++++++++++++++
 9 files changed, 1408 insertions(+), 72 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v9
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v8:

 1:  ba77752282 = 1:  352c818c29 history: extract helper for a commit's parent tree
 2:  50f3572887 = 2:  e06e49095b history: give commit_tree_ext a message template
 3:  2d81a40a05 ! 3:  ead974c317 history: add squash subcommand to fold a range
     @@ Commit message
      
          Add "git history squash <revision-range>" to do this directly. It folds
          every commit in the range into the oldest one, keeping that commit's
     -    message and authorship and taking the tree of the newest commit, then
     -    replays the commits above the range on top. The squashed message comes
     -    from the oldest commit, or from an editor with --reedit-message. A
     -    fixup!, squash! or amend! commit is refused unless the commit it targets
     -    is also in the range, so the fold does not silently absorb a marker meant
     -    for a commit outside it. The check runs the range through
     -    todo_list_rearrange_squash(), which leaves such a marker as a plain pick.
     -    Markers whose target is in the range fold in as usual. As an exception, a
     -    range made up entirely of markers for one target is combined anyway,
     -    taking its message from the last amend! if there is one, so a batch of
     -    fixups for the same commit can be collapsed.
     +    authorship and taking the tree of the newest commit, then replays the
     +    commits above the range on top. The squashed message comes from the
     +    oldest commit by default, or from the body of the last amend! commit
     +    targeting it. An editor opens with the selected message when
     +    --reedit-message is given. A fixup!, squash! or amend! commit is refused
     +    unless the commit it targets is also in the range, so the fold does not
     +    silently absorb a marker meant for a commit outside it. The check runs
     +    the range through todo_list_rearrange_squash(), which leaves such a
     +    marker as a plain pick. Markers whose target is in the range fold in as
     +    usual. As an exception, a range made up entirely of markers for one
     +    target is combined anyway, taking its message from the last amend! if
     +    there is one, so a batch of fixups for the same commit can be collapsed.
      
          The range is read like the arguments to "git rev-list", so several
          revisions such as "HEAD~3..HEAD ^topic" may be given, and rev-list
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
       
      +`squash <revision-range>`::
      +	Fold all commits in _<revision-range>_ into the oldest commit of that
     -+	range. The resulting commit keeps the oldest commit's message and
     -+	authorship and takes the tree of the range's newest commit, so the
     -+	whole range collapses into a single commit. Commits above the range
     -+	are replayed on top of the result.
     ++	range. The resulting commit keeps the oldest commit's authorship and
     ++	takes the tree of the range's newest commit, so the whole range
     ++	collapses into a single commit. Commits above the range are replayed
     ++	on top of the result.
      ++
      +The range is given in the usual `<base>..<tip>` form, where _<base>_ is
      +the commit just below the oldest commit to squash. For example, `git
     @@ Documentation/git-history.adoc: linkgit:gitglossary[7].
      +already on `topic`. Rev-list options may also be given, but any that would
      +change how the range is walked are overridden with a warning.
      ++
     -+The oldest commit's message and authorship are preserved by default,
     -+unless you specify `--reedit-message`. A merge commit inside the range is
     -+folded like any other, but the range must have a single base, so a range
     -+that reaches more than one entry point (for example a side branch that
     -+forked before the range and was later merged into it) is rejected.
     ++The oldest commit's message is preserved by default, except that an `amend!`
     ++commit targeting it replaces its message. Specify `--reedit-message` to edit
     ++the resulting message. A merge commit inside the range is folded like any
     ++other, but the range must have a single base, so a range that reaches more
     ++than one entry point (for example a side branch that forked before the range
     ++and was later merged into it) is rejected.
      ++
      +A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
      +targets is also in the range, so the fold does not silently absorb a
     -+marker meant for a commit outside it. As an exception, a range made up
     -+entirely of markers for one target is combined into a single commit,
     -+keeping the last `amend!` message if there is one.
     ++marker meant for a commit outside it. The body after an `amend!` subject
     ++replaces the oldest commit's message when the marker targets that commit. As
     ++an exception, a range made up entirely of markers for one target is combined
     ++into a single commit, keeping the last `amend!` message if there is one.
      ++
      +A branch or tag that points at a commit inside the range would be left
      +dangling once those commits are folded away, so with the default
     @@ builtin/history.c: out:
      +				  struct commit *base,
      +				  struct commit *tip,
      +				  struct commit *oldest,
     -+				  struct commit **msg_source)
     ++				  struct commit **msg_source,
     ++				  struct commit **amend_source)
      +{
      +	struct todo_list todo = TODO_LIST_INIT;
      +	struct replay_opts opts = REPLAY_OPTS_INIT;
     @@ builtin/history.c: out:
      +	struct strvec args = STRVEC_INIT;
      +	char *dangling_subject = NULL, *dangling_target = NULL;
      +	bool mixed_target = false, all_fixups_one_target;
     ++	bool past_oldest_group = false;
      +	int i, ret, nr_dangling = 0;
      +
      +	*msg_source = oldest;
     ++	*amend_source = NULL;
      +
      +	repo_init_revisions(repo, &revs, NULL);
      +	strvec_push(&args, "ignored");
     @@ builtin/history.c: out:
      +		char *subject;
      +		size_t sublen;
      +
     -+		if (todo.items[i].command != TODO_PICK)
     -+			continue;
      +		message = repo_logmsg_reencode(repo, todo.items[i].commit,
      +					       NULL, NULL);
      +		sublen = find_commit_subject(message, &subject_start);
     ++
     ++		if (todo.items[i].command != TODO_PICK) {
     ++			if (!past_oldest_group &&
     ++			    starts_with(subject_start, "amend! "))
     ++				*amend_source = todo.items[i].commit;
     ++			repo_unuse_commit_buffer(repo, todo.items[i].commit, message);
     ++			continue;
     ++		}
     ++		if (i)
     ++			past_oldest_group = true;
     ++
      +		subject = xmemdupz(subject_start, sublen);
      +		target = autosquash_target(subject);
      +		if (target != subject) {
     @@ builtin/history.c: out:
      +		OPT_END(),
      +	};
      +	struct strbuf reflog_msg = STRBUF_INIT;
     ++	struct strbuf message = STRBUF_INIT;
      +	struct oidset interior = OIDSET_INIT;
     -+	struct commit *base, *oldest, *tip, *rewritten, *msg_source;
     ++	struct commit *base, *oldest, *tip, *rewritten, *msg_source,
     ++		*amend_source;
      +	const struct object_id *base_tree_oid, *tip_tree_oid;
     ++	const char *message_template = NULL;
      +	struct commit_list *parents = NULL;
      +	struct rev_info revs = { 0 };
      +	int ret;
     @@ builtin/history.c: out:
      +	if (ret < 0)
      +		goto out;
      +
     -+	ret = reject_dangling_fixups(repo, base, tip, oldest, &msg_source);
     ++	ret = reject_dangling_fixups(repo, base, tip, oldest, &msg_source,
     ++				     &amend_source);
      +	if (ret < 0)
      +		goto out;
     ++	if (amend_source) {
     ++		const char *amend_message, *body;
     ++
     ++		amend_message = repo_logmsg_reencode(repo, amend_source,
     ++						     NULL, NULL);
     ++		find_commit_subject(amend_message, &body);
     ++		body = skip_blank_lines(body + commit_subject_length(body));
     ++		strbuf_addstr(&message, body);
     ++		message_template = message.buf;
     ++		repo_unuse_commit_buffer(repo, amend_source, amend_message);
     ++	}
      +
      +	if (action == REF_ACTION_BRANCHES) {
      +		struct interior_ref_cb cb = { .interior = &interior };
     @@ builtin/history.c: out:
      +	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
      +	commit_list_append(base, &parents);
      +
     -+	ret = commit_tree_ext(repo, "squash", msg_source, NULL, parents,
     ++	ret = commit_tree_ext(repo, "squash", msg_source, message_template,
     ++			      parents,
      +			      base_tree_oid, tip_tree_oid, &rewritten, flags);
      +	if (ret < 0) {
      +		ret = error(_("failed writing squashed commit"));
     @@ builtin/history.c: out:
      +
      +out:
      +	strbuf_release(&reflog_msg);
     ++	strbuf_release(&message);
      +	oidset_clear(&interior);
      +	commit_list_free(parents);
      +	release_revisions(&revs);
     @@ t/t3455-history-squash.sh (new)
      +
      +. ./test-lib.sh
      +
     ++stage_file () {
     ++	printf "%s\n" "$1" >file &&
     ++	git add file
     ++}
     ++
     ++commit_with_message () {
     ++	printf "%b" "$1" >msg &&
     ++	git commit --allow-empty -qF msg
     ++}
     ++
     ++check_commit_count () {
     ++	git rev-list --count "$1" >actual &&
     ++	echo "$2" >expect &&
     ++	test_cmp expect actual
     ++}
     ++
     ++check_log_subjects () {
     ++	git log --format="%s" "$1" >actual &&
     ++	cat >expect &&
     ++	test_cmp expect actual
     ++}
     ++
     ++check_log_messages () {
     ++	git log --format="%B" "$1" >actual &&
     ++	cat >expect &&
     ++	test_cmp expect actual
     ++}
     ++
      +test_expect_success 'setup linear history touching two files' '
      +	test_commit base file a &&
      +	git tag start &&
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start..HEAD ^keep &&
      +
     -+	git log --format="%s" start..HEAD >actual &&
     -+	cat >expect <<-\EOF &&
     ++	check_log_subjects start..HEAD <<-\EOF &&
      +	two
      +	one
      +	EOF
     -+	test_cmp expect actual &&
      +	test_cmp_rev keep HEAD~1 &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
      +
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start..off-history &&
      +
     -+	git rev-list --count start..off-history >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..off-history 1 &&
      +	test_cmp_rev "$head_before" HEAD &&
      +
      +	git branch -D off-history
     @@ t/t3455-history-squash.sh (new)
      +	git history squash start.. &&
      +
      +	test "$predicted" = "$(git rev-parse HEAD)" &&
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..HEAD 1 &&
      +	test_cmp_rev start HEAD^ &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
     -+	git log --format="%s" -1 >subject &&
     -+	echo one >expect &&
     -+	test_cmp expect subject &&
     ++	check_log_subjects -1 <<-\EOF &&
     ++	one
     ++	EOF
      +	git reflog >reflog &&
      +	test_grep "squash: updating" reflog
      +'
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start..@~1 &&
      +
     -+	git log --format="%s" start..HEAD >actual &&
     -+	cat >expect <<-\EOF &&
     ++	check_log_subjects start..HEAD <<-\EOF &&
      +	three
      +	one
      +	EOF
     -+	test_cmp expect actual &&
      +
      +	test_cmp_rev start HEAD~2 &&
      +	test "$final_tree" = "$(git rev-parse HEAD^{tree})"
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash "$root.." &&
      +
     -+	git rev-list --count "$root..HEAD" >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count "$root..HEAD" 1 &&
      +	test_cmp_rev "$root" HEAD^ &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
      +'
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     -+	git log --format="%s" -1 >actual &&
     -+	echo target >expect &&
     -+	test_cmp expect actual
     ++	check_commit_count start..HEAD 1 &&
     ++	check_log_subjects -1 <<-\EOF
     ++	target
     ++	EOF
      +'
      +
      +test_expect_success 'refuses a below-range fixup! after an in-range commit' '
     @@ t/t3455-history-squash.sh (new)
      +
      +test_expect_success 'combines a run of fixups for one commit below the range' '
      +	git reset --hard start &&
     -+	echo b >file && git add file && git commit -m "fixup! base" &&
     -+	echo c >file && git add file && git commit -m "fixup! base" &&
     ++	stage_file b && git commit -m "fixup! base" &&
     ++	stage_file c && git commit -m "fixup! base" &&
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     -+	git log --format="%s" -1 >actual &&
     -+	echo "fixup! base" >expect &&
     -+	test_cmp expect actual
     ++	check_commit_count start..HEAD 1 &&
     ++	check_log_subjects -1 <<-\EOF
     ++	fixup! base
     ++	EOF
      +'
      +
      +test_expect_success 'combining below-range fixups keeps the last amend! message' '
      +	git reset --hard start &&
     -+	echo b >file && git add file && git commit -m "fixup! base" &&
     -+	printf "amend! base\n\namended body\n" >msg &&
     -+	echo c >file && git add file && git commit -qF msg &&
     ++	stage_file b && git commit -m "fixup! base" &&
     ++	stage_file c &&
     ++	commit_with_message "amend! base\n\namended body\n" &&
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     -+	git log --format="%s" -1 >actual &&
     -+	echo "amend! base" >expect &&
     -+	test_cmp expect actual &&
     -+	git log --format="%b" -1 >body &&
     -+	test_grep "amended body" body
     ++	check_commit_count start..HEAD 1 &&
     ++	check_log_messages -1 <<-\EOF
     ++	amend! base
     ++
     ++	amended body
     ++
     ++	EOF
      +'
      +
      +test_expect_success 'refuses fixups for two different commits below the range' '
      +	git reset --hard start &&
     -+	echo b >file && git add file && git commit -m "fixup! aaa" &&
     -+	echo c >file && git add file && git commit -m "fixup! bbb" &&
     ++	stage_file b && git commit -m "fixup! aaa" &&
     ++	stage_file c && git commit -m "fixup! bbb" &&
      +	head_before=$(git rev-parse HEAD) &&
      +
      +	test_must_fail git history squash start.. 2>err &&
     @@ t/t3455-history-squash.sh (new)
      +	test_cmp_rev "$head_before" HEAD
      +'
      +
     -+test_expect_success 'keeps the oldest message for in-range squash! and amend!' '
     ++test_expect_success 'the last amend! for the oldest commit replaces its message' '
      +	git reset --hard start &&
      +	test_commit --no-tag marker-oldest file b &&
      +	git commit --allow-empty -m "squash! marker-oldest" &&
     -+	git commit --allow-empty -m "amend! marker-oldest" &&
     -+	test_commit --no-tag marker-newest file c &&
     ++	commit_with_message "amend! marker-oldest\n\nearlier message\n" &&
     ++	commit_with_message \
     ++		"amend! marker-oldest\n\namended subject\n\namended body\n" &&
     ++	test_commit --no-tag marker-later file c &&
     ++	commit_with_message "amend! marker-later\n\nwrong message\n" &&
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     -+	git log --format="%s" -1 >actual &&
     -+	echo marker-oldest >expect &&
     -+	test_cmp expect actual
     ++	check_commit_count start..HEAD 1 &&
     ++	check_log_messages -1 <<-\EOF
     ++	amended subject
     ++
     ++	amended body
     ++
     ++	EOF
      +'
      +
      +test_expect_success 'preserves authorship of the oldest commit' '
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash --update-refs=head start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..HEAD 1 &&
      +	test_cmp_rev "$other_before" other
      +'
      +
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash --update-refs=head start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..HEAD 1 &&
      +	test_cmp_rev "$mid_before" mid &&
      +
      +	git branch -D mid
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     -+	git log --format="%s" -1 >subject &&
     -+	echo before-side >expect &&
     -+	test_cmp expect subject &&
     ++	check_commit_count start..HEAD 1 &&
     ++	check_log_subjects -1 <<-\EOF &&
     ++	before-side
     ++	EOF
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
      +	test_path_is_file inner
      +'
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..HEAD 1 &&
      +	test_cmp_rev start HEAD^ &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
      +	test_path_is_file side
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..HEAD 1 &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
      +	test_path_is_file side
      +'
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash "$base.." &&
      +
     -+	git rev-list --count "$base..HEAD" >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count "$base..HEAD" 1 &&
      +	test_cmp_rev "$base" HEAD^ &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})"
      +'
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..HEAD 1 &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
      +	test_path_is_file s1 &&
      +	test_path_is_file s2
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..HEAD 1 &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
      +	test_path_is_file outer &&
      +	test_path_is_file inner
     @@ t/t3455-history-squash.sh (new)
      +
      +	git history squash start.. &&
      +
     -+	git rev-list --count start..HEAD >count &&
     -+	echo 1 >expect &&
     -+	test_cmp expect count &&
     ++	check_commit_count start..HEAD 1 &&
      +	test "$tip_tree" = "$(git rev-parse HEAD^{tree})" &&
      +	test_path_is_file o1 &&
      +	test_path_is_file o2
 4:  0a735117ad = 4:  08915cee51 sequencer: share the squash message marker helpers and flags
 5:  baf7e6f0a6 ! 5:  fb76afe31c history: re-edit a squash with every message
     @@ Metadata
       ## Commit message ##
          history: re-edit a squash with every message
      
     -    By default "git history squash" reuses the oldest commit's message.
     -    When --reedit-message is given it only reopened that one message, so the
     +    By default "git history squash" reuses the oldest commit's message, or
     +    the replacement body from an amend! commit targeting it. When
     +    --reedit-message is given it only reopened that selected message, so the
          messages of the other commits in the range were lost.
      
          Gather the message of every commit in the range and build the same editor
     @@ Commit message
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Documentation/git-history.adoc ##
     -@@ Documentation/git-history.adoc: given, for example `HEAD~3..HEAD ^topic` to additionally exclude what is
     - already on `topic`. Rev-list options may also be given, but any that would
     +@@ Documentation/git-history.adoc: already on `topic`. Rev-list options may also be given, but any that would
       change how the range is walked are overridden with a warning.
       +
     --The oldest commit's message and authorship are preserved by default,
     --unless you specify `--reedit-message`. A merge commit inside the range is
     -+The oldest commit's message and authorship are preserved by default. With
     -+`--reedit-message`, an editor opens pre-filled with the messages of all the
     -+folded commits so you can combine them. A merge commit inside the range is
     - folded like any other, but the range must have a single base, so a range
     - that reaches more than one entry point (for example a side branch that
     - forked before the range and was later merged into it) is rejected.
     -@@ Documentation/git-history.adoc: A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
     + The oldest commit's message is preserved by default, except that an `amend!`
     +-commit targeting it replaces its message. Specify `--reedit-message` to edit
     +-the resulting message. A merge commit inside the range is folded like any
     +-other, but the range must have a single base, so a range that reaches more
     +-than one entry point (for example a side branch that forked before the range
     +-and was later merged into it) is rejected.
     ++commit targeting it replaces its message. With `--reedit-message`, an editor
     ++opens pre-filled with the messages of all the folded commits so you can
     ++combine them. A merge commit inside the range is folded like any other, but
     ++the range must have a single base, so a range that reaches more than one entry
     ++point (for example a side branch that forked before the range and was later
     ++merged into it) is rejected.
     + +
     + A `fixup!`, `squash!`, or `amend!` commit is refused unless the commit it
       targets is also in the range, so the fold does not silently absorb a
     - marker meant for a commit outside it. As an exception, a range made up
     - entirely of markers for one target is combined into a single commit,
     --keeping the last `amend!` message if there is one.
     -+keeping the last `amend!` message if there is one. The changes from every
     -+commit in the range are always folded in. Only the message text differs.
     +@@ Documentation/git-history.adoc: marker meant for a commit outside it. The body after an `amend!` subject
     + replaces the oldest commit's message when the marker targets that commit. As
     + an exception, a range made up entirely of markers for one target is combined
     + into a single commit, keeping the last `amend!` message if there is one.
     ++The changes from every commit in the range are always folded in. Only the
     ++message text differs.
      +With `--reedit-message` the template mirrors `git rebase -i --autosquash`:
      +each `fixup!`, `squash!`, or `amend!` is grouped under the commit it
      +targets rather than shown in commit order. A `fixup!` message is dropped
     @@ builtin/history.c: static int find_interior_ref(const struct reference *ref, voi
       static int cmd_history_squash(int argc,
       			      const char **argv,
       			      const char *prefix,
     -@@ builtin/history.c: static int cmd_history_squash(int argc,
     - 		OPT_END(),
     - 	};
     - 	struct strbuf reflog_msg = STRBUF_INIT;
     -+	struct strbuf message = STRBUF_INIT;
     - 	struct oidset interior = OIDSET_INIT;
     - 	struct commit *base, *oldest, *tip, *rewritten, *msg_source;
     - 	const struct object_id *base_tree_oid, *tip_tree_oid;
      @@ builtin/history.c: static int cmd_history_squash(int argc,
       		}
       	}
       
      +	if (flags & COMMIT_TREE_EDIT_MESSAGE) {
     ++		strbuf_reset(&message);
      +		ret = build_squash_message(repo, base, tip, &message);
      +		if (ret < 0)
      +			goto out;
     ++		message_template = message.buf;
      +	}
      +
       	ret = setup_revwalk(repo, action, tip, &revs);
       	if (ret < 0)
       		goto out;
     -@@ builtin/history.c: static int cmd_history_squash(int argc,
     - 	tip_tree_oid = &repo_get_commit_tree(repo, tip)->object.oid;
     - 	commit_list_append(base, &parents);
     - 
     --	ret = commit_tree_ext(repo, "squash", msg_source, NULL, parents,
     -+	ret = commit_tree_ext(repo, "squash", msg_source,
     -+			      message.len ? message.buf : NULL, parents,
     - 			      base_tree_oid, tip_tree_oid, &rewritten, flags);
     - 	if (ret < 0) {
     - 		ret = error(_("failed writing squashed commit"));
     -@@ builtin/history.c: static int cmd_history_squash(int argc,
     - 
     - out:
     - 	strbuf_release(&reflog_msg);
     -+	strbuf_release(&message);
     - 	oidset_clear(&interior);
     - 	commit_list_free(parents);
     - 	release_revisions(&revs);
      
       ## t/t3455-history-squash.sh ##
      @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the oldest commit' '
     @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
       
      +test_expect_success '--reedit-message offers every folded-in message' '
      +	git reset --hard start &&
     -+	echo b >file &&
     -+	git add file &&
     ++	stage_file b &&
      +	git commit -m "re-one subject" -m "re-one body line" &&
      +	test_commit --no-tag re-two file c &&
      +	test_commit re-three file d &&
     @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +	#
      +	EOF
      +	test_cmp expect edited &&
     -+	echo combined >expect &&
     -+	git log --format="%s" -1 >actual &&
     -+	test_cmp expect actual
     ++	check_log_subjects -1 <<-\EOF
     ++	combined
     ++	EOF
      +'
      +
      +test_expect_success '--reedit-message handles fixup!, squash! and amend! like rebase' '
      +	git reset --hard start &&
      +	test_commit --no-tag mark-base file b &&
     -+	printf "fixup! mark-base\n\nfixup body\n" >msg &&
     -+	echo c >file &&
     -+	git add file &&
     -+	git commit -qF msg &&
     -+	printf "squash! mark-base\n\nsquash remark\n" >msg &&
     -+	echo d >file &&
     -+	git add file &&
     -+	git commit -qF msg &&
     -+	printf "amend! mark-base\n\namended message\n" >msg &&
     -+	echo e >file &&
     -+	git add file &&
     -+	git commit -qF msg &&
     ++	stage_file c &&
     ++	commit_with_message "fixup! mark-base\n\nfixup body\n" &&
     ++	stage_file d &&
     ++	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
     ++	stage_file e &&
     ++	commit_with_message "amend! mark-base\n\namended message\n" &&
      +
      +	write_script editor <<-\EOF &&
      +	cat "$1" >edited
     @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +	#
      +	EOF
      +	test_cmp expect edited &&
     -+	git log -1 --format="%B" >final &&
     -+	test_grep ! "fixup body" final &&
     -+	test_grep "squash remark" final &&
     -+	test_grep "amended message" final
     ++	check_log_messages -1 <<-\EOF
     ++	mark-base
     ++
     ++	squash remark
     ++
     ++	amended message
     ++
     ++	EOF
      +'
      +
      +test_expect_success '--reedit-message groups fixups under their targets' '
      +	git reset --hard start &&
      +	test_commit --no-tag alpha file a1 &&
      +	test_commit --no-tag beta file b1 &&
     -+	printf "fixup! alpha\n" >msg &&
     -+	echo a2 >file &&
     -+	git add file &&
     -+	git commit -qF msg &&
     -+	printf "fixup! beta\n" >msg &&
     -+	echo b2 >file &&
     -+	git add file &&
     -+	git commit -qF msg &&
     ++	stage_file a2 &&
     ++	commit_with_message "fixup! alpha\n" &&
     ++	stage_file b2 &&
     ++	commit_with_message "fixup! beta\n" &&
      +
      +	write_script editor <<-\EOF &&
      +	cat "$1" >edited
     @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +test_expect_success '--reedit-message lets amend! replace its target message' '
      +	git reset --hard start &&
      +	test_commit --no-tag mark-base file b &&
     -+	printf "amend! mark-base\n\namended message\n" >msg &&
     -+	echo c >file &&
     -+	git add file &&
     -+	git commit -qF msg &&
     -+	printf "squash! mark-base\n\nsquash remark\n" >msg &&
     -+	echo d >file &&
     -+	git add file &&
     -+	git commit -qF msg &&
     ++	stage_file c &&
     ++	commit_with_message "amend! mark-base\n\namended message\n" &&
     ++	stage_file d &&
     ++	commit_with_message "squash! mark-base\n\nsquash remark\n" &&
      +
      +	write_script editor <<-\EOF &&
      +	cat "$1" >edited
     @@ t/t3455-history-squash.sh: test_expect_success 'preserves authorship of the olde
      +	#
      +	EOF
      +	test_cmp expect edited &&
     -+	git log -1 --format="%B" >final &&
     -+	test_grep ! "mark-base" final &&
     -+	test_grep "amended message" final &&
     -+	test_grep "squash remark" final
     ++	check_log_messages -1 <<-\EOF
     ++	amended message
     ++
     ++	squash remark
     ++
     ++	EOF
      +'
      +
      +test_expect_success '--reedit-message aborts on an empty message' '

-- 
gitgitgadget
