Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11EAB2C21DF
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790947652; cv=none; b=DBK83yBcFxdxo1/yhlSCIQN02UH8850kOZjw85L1IZNRV+Zd8eaP4h4gHEgUeSRJ1ce52NEr2u+pGDIt4cA/HxWNAUXkMKesztctFc+xPY0F4PiVmIgLiZRrbAOMERXse6zMmsHP8LrzdU/d4EXA2A1ZJO3l7H9ZeeMs7Fguw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790947652; c=relaxed/simple;
	bh=AbtnDGibZIfetu7RaYHPNp8byWoBFI5KQ27SjxpSQW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MtmFxs9M91hdijJ09xPIJdsBns/ZUpVvQT2kPlbIQqu6ivFMLgcXH2wSz9iVv8YWgwj0AnapaFLIModB7S6Axcpb22/+LBfkNlikrYS+agPKjTqxRsoLaGByW7flTDUAN5fv/9ogKWKCFVkzIhDTZFm3K43AKdN/5h28znJbJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=jELyo0ao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HK5E0KeZ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="jELyo0ao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HK5E0KeZ"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 30D1314000AF
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 09:27:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 02 Oct 2026 09:27:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1790947649; x=
	1791034049; bh=N/fwE+hlxXLJ7KFo+DKFxCWBQstnqu255CL7eOkSU7c=; b=j
	ELyo0aocs+UtUAhIbnUTHPeOKBmvZQL7K+I1MA8JvkJLHjJ6pGp9HI3qtjeXx4VD
	6D9LHulMHFTVbbgGg4whq1kD98vUFL1cltGF6IJVF3UGQn9KfWCb2FLdK6ZvZoVF
	xvMrBU+eQsGl5ryCDT4d8bWhOBunJL6PlX5s7obBOFtImoCZmi9TmxK1W9z7Ovjc
	wOszr1mL92gHsSSrZX4IcgbuA2nf1GcnUXukICWfEEdF6JCz+s2Zt2L+Jx0BYSHp
	AUPQHIdEx1gpYnP1b/ds1q5Z8ED093TQZ6P71OwAKZIlPRgXqFCWoxbgTT/jrDGK
	UO+hYPwbR2Rb6mrLldo/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790947649; x=1791034049; bh=N
	/fwE+hlxXLJ7KFo+DKFxCWBQstnqu255CL7eOkSU7c=; b=HK5E0KeZiLtF1cIxP
	OztjSDLyTfi28OVLu7FRfie5J8p+LLsxT4r+E7hbR6ykkb3ecMB3BFxOtN2Mcq95
	g6TpVyLVgUDX4rkncih42nJD2KJFmKqLpLajlPr/kbKxbc28gSckov3Zu3QJMEbq
	IYLUSDHU7hraVFQdP0LXS6oREzceGZeIFbRLKTw9ayFNEwJOzB45Yy/kMta52GnR
	Tj2rR4w32IiV2vQxforNubDBqsvYQkwMIF/GFimP3eqYUnJohIsbarxP5mr54LJT
	o84HeXsUbgnariOJNZZpscdcF6dI09rTeyZWCOPPoxNhpYEI7ygQ6IXGVJ1QUggM
	lx1+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=5ouma.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790947649; d=5ouma.me;
	mf=PGdpdEA1b3VtYS5tZT4=; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eTQU+/XqZzzozaI1tJ8l6QlF4IJX6jTYTq/5P2eYveqTOJv
	I8i8JXzwOkXVUFFPMhFd2YikltqEQMguVfm2VMK+tLasgvmsIMEbk/DqIdd4cfUL
	kPSJmNt9yy5JIkhCvMfkYE3/xLexUV+JzImOH7slB4/Gwxw/Dtz5xpQ3pSqHy8FD
	czZq06JtPotiIjgthF6XQkZx1Rw7uwuniVQBgI1wceP78aNJNT62HXeB63Tgt6De
	LywAP+qoR1/sffo8No4RXEKZh+LffyXoaHWD+YcjpXoMviMT8Vi/1v9WcVaTkxCL
	vXKdFWBX+INv66dgHEfCbPvKecrmfltapEunPfQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:8tYaF58NLGjOldMG2KK0INw0MitYHSPINPUqATqBf7c=:AbtnDGibZIfetu7RaYHPNp8byWoBFI5KQ27SjxpSQW0=;
X-ME-Sender: <xms:QLG_avPxNc_WZr8UX1aWsk-HlG-yaZrGDzIM62sGORBtvIVub5Z_xw>
    <xme:QLG_ag8Xi9on9ShgWZa_jiqZQSLOYFN9NVNbVIoatbblGWJxsmTTvStUyFv_kVhzY
    _YI9-DbKndQa_PC7tM-qBQs5ZECICgpULz3wer4Ofdx8XNGeUIgv5we>
X-ME-Received: <xmr:QLG_ajRZrrUZ4qrNi8wP58X1S5xzedFm5mRCV3hrMFKcGgY7cEqVc7BV08U37d_qaUidYZAJaBL0oUHSK5OgMuPN3rdIawoDlUdE3zCZUQY>
X-ME-Proxy-Cause: dmFkZTES2ku0SqNb2DiDQqCKzJ1AhFM3ETkz+plOTKaUsCTU5JJBtioiH5rjMiRv5MB5cN
    6PcKOzzuLmD+RTUxITX+OCgg6daTq10FYd6xI2/Z3ClOrDJrnlRruXq4bg/TXcRF1aR/DF
    V2u6ujFRWukqFwwrvQ9y/KFKfemxtEvlVH4m1YuQgYDLMGSAZ0GchrMxUxC/CFs8X6epYm
    aYTQwlTbw3fC41S+K/kkF3S3wlr0PhdltW7YJrHQg8s6MIAmOCMUAnGIjSpBYZ+o806A3P
    UfUODwHscW3EQOv4z14Wj+7MW0rzpYCGey91tDk5q+gkXMZqhWTz61jtuk8Gpo1SOLU3AC
    lbqrOzOyYM28hUkm1H/bb7432kFfkTuvTyei7q0GiOWtqC2FLlkS+8XlYf8OUhkeGM6eM4
    1E4CwUeemyBJvCIxNJvu0i0grzSp6gR5CNZ9lXlJxGB1iYu1bjnb02jXqmUxmWABE5/I8e
    ERvfjian06dpbaDh7JEdZ/5XslTfGCB0lWyGJzWHK5359ccaF7KwaG8kMaYaoi+766Olm9
    61JdtVOPhpc/KFbIU3pI0NFoRj0HsWWej2jwJ7VcdmwMdPQFO+y0LIfLjwf0bPQNb4tEJb
    T0JwgSEu7xKCHwGEsB2MFpQlt9IskMcKQ4Y5rR1As9D7K7AuPgt7tT3kwt1Q
X-ME-Proxy: <xmx:QLG_ainBcCzSihISRfyCy8YpQ3NBzEJZXBE3vDJCZcHfNCZJL5dHIA>
    <xmx:QLG_ajRKmobv8xxyqYENkZIRlW8ykr4jfDtGc8QJwASiddpVuV2QxQ>
    <xmx:QLG_agOe4rxeYm50k2KJJ9vOTBkHLXCkierJsyexDxERKUYG7jv6Rw>
    <xmx:QLG_asUMI9OyBpkFS8oLa5pAoxgBTFvFt-rjCH4o0sHjyyAD3-qOXA>
    <xmx:QbG_ap531GZJP6EbStCzms28KorfeGv8Pz1CdfHYgbXskksbV56bz2y4>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 09:27:27 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v4 0/2] history: sign rewritten commits
Date: Fri,  2 Oct 2026 22:27:16 +0900
Message-ID: <20261002132718.3830-1-git@5ouma.me>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

History rewriting creates commits through two paths: the history commands
write replacement commits directly, while the replay machinery recreates
descendants above the rewritten range. Neither path currently honors
`commit.gpgSign` or an explicit signing request, so rewriting signed history
can leave the resulting commits unsigned.

Add a signing-key option to the replay API, then have the history commands
pass the selected signer through both paths. Expose the standard
`-S`/`--gpg-sign[=<key-id>]` and `--no-gpg-sign` options for `drop`, `fixup`,
`reword`, `split`, and `squash`. This applies one signing policy to every
commit created by the rewrite, including both commits from `split`, the
commit from `squash`, and replayed descendants.

The behavior follows rebase, cherry-pick, and revert:
`commit.gpgSign` supplies the default, command-line options override it, and
the last command-line option wins. The signature attests the current
committer's rewrite while preserving the original author identity.

Changes since v3:

 - Add signing support to `git history squash`, including its synopsis,
   configuration and command-line behavior, and replayed descendants
 - Add GPG-gated squash tests for configuration, option precedence,
   explicit keys, the squashed commit, and replayed descendants
 - Document the signing options for the squash subcommand
 - Clarify the commit messages based on review feedback, including why
   configuration is loaded before option parsing and that the replay
   infrastructure is consumed by the follow-up history change

Souma (2):
  replay: allow callers to sign commits
  history: sign rewritten commits

 Documentation/git-history.adoc | 18 +++++--
 builtin/history.c              | 96 +++++++++++++++++++++++++---------
 replay.c                       | 13 +++--
 replay.h                       |  6 +++
 t/t3451-history-reword.sh      | 63 ++++++++++++++++++++++
 t/t3452-history-split.sh       | 44 ++++++++++++++++
 t/t3453-history-fixup.sh       | 39 ++++++++++++++
 t/t3454-history-drop.sh        | 50 ++++++++++++++++++
 t/t3455-history-squash.sh      | 61 +++++++++++++++++++++
 9 files changed, 356 insertions(+), 34 deletions(-)

Range-diff against v3:
1:  ca35b0acaa ! 1:  d45cce8e25 replay: allow callers to sign commits
    @@ Commit message
         Add a signing-key option to replay_revisions_options and pass it to
         commit_tree_extended() when creating replayed commits.
     
    +    This provides the replay infrastructure for history commands to sign
    +    replayed descendants.
    +
         Signed-off-by: Souma <git@5ouma.me>
     
      ## replay.c ##
2:  f0a1a88411 ! 2:  8b4766fc0e history: sign rewritten commits
    @@ Commit message
         signing key through direct rewrites and replayed descendants while
         preserving the original author identity.
     
    -    Cover configuration, command-line precedence, explicit keys, split commits,
    -    and replayed descendants with GPG-gated tests.
    +    Load history configuration before parsing command-line options so
    +    command-line signing options override commit.gpgSign.
    +
    +    Cover configuration, command-line precedence, explicit keys, split
    +    commits, and replayed descendants with GPG-gated tests.
     
         Signed-off-by: Souma <git@5ouma.me>
     
    @@ Documentation/git-history.adoc: git-history - EXPERIMENTAL: Rewrite history
     -git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
     -git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
     -git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
    +-git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
     +git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
     +git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
     +git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
     +git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]
    ++git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>
      
      DESCRIPTION
      -----------
    @@ builtin/history.c
      #define GIT_HISTORY_SPLIT_USAGE \
     -	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
     +	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]")
    + #define GIT_HISTORY_SQUASH_USAGE \
    +-	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
    ++	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>")
      
      static void change_data_free(void *util, const char *str UNUSED)
      {
    @@ builtin/history.c: enum commit_tree_flags {
      static int commit_tree_ext(struct repository *repo,
      			   const char *action,
      			   struct commit *commit_with_message,
    +@@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
      			   const struct commit_list *parents,
      			   const struct object_id *old_tree,
      			   const struct object_id *new_tree,
    @@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
      	if (ret < 0)
      		goto out;
      
    -@@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
    +@@ builtin/history.c: static int first_parent_tree_oid(struct repository *repo,
      static int commit_tree_with_edited_message(struct repository *repo,
      					   const char *action,
      					   struct commit *original,
    @@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
      {
      	struct object_id parent_tree_oid;
     @@ builtin/history.c: static int commit_tree_with_edited_message(struct repository *repo,
    - 	}
    + 		return -1;
      
    - 	return commit_tree_ext(repo, action, original, original->parents,
    + 	return commit_tree_ext(repo, action, original, NULL, original->parents,
     -			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
     +			       &parent_tree_oid, tree_oid, sign_commit, out,
     +			       COMMIT_TREE_EDIT_MESSAGE);
    @@ builtin/history.c: static int cmd_history_fixup(int argc,
      		action = REF_ACTION_BRANCHES;
     @@ builtin/history.c: static int cmd_history_fixup(int argc,
      	if (!skip_commit) {
    - 		ret = commit_tree_ext(repo, "fixup", original, original->parents,
    + 		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
      				      &original_tree->object.oid, &merge_result.tree->object.oid,
     -				      &rewritten, flags);
     +				      sign_commit, &rewritten, flags);
    @@ builtin/history.c: static int write_ondisk_index(struct repository *repo,
      {
      	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
     @@ builtin/history.c: static int split_commit(struct repository *repo,
    + 	 * The first commit is constructed from the split-out tree. The base
      	 * that shall be diffed against is the parent of the original commit.
      	 */
    - 	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
    +-	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
     -			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
    -+			      &split_tree->object.oid, sign_commit, &first_commit,
    ++	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents,
    ++			      &parent_tree_oid, &split_tree->object.oid, sign_commit,
    ++			      &first_commit,
     +			      COMMIT_TREE_EDIT_MESSAGE);
      	if (ret < 0) {
      		ret = error(_("failed writing first commit"));
    @@ builtin/history.c: static int split_commit(struct repository *repo,
     @@ builtin/history.c: static int split_commit(struct repository *repo,
      	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
      
    - 	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
    + 	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
     -			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
     +			      new_tree_oid, sign_commit, &second_commit,
     +			      COMMIT_TREE_EDIT_MESSAGE);
    @@ builtin/history.c: static int cmd_history_split(int argc,
      	if (ret < 0) {
      		ret = error(_("failed replaying descendants"));
      		goto out;
    +@@ builtin/history.c: static int cmd_history_squash(int argc,
    + 		NULL,
    + 	};
    + 	enum ref_action action = REF_ACTION_DEFAULT;
    ++	const char *sign_commit = NULL;
    + 	int dry_run = 0;
    + 	int edit = 1;
    + 	struct option options[] = {
    +@@ builtin/history.c: static int cmd_history_squash(int argc,
    + 			 N_("perform a dry-run without updating any refs")),
    + 		OPT_BOOL('e', "edit", &edit,
    + 			 N_("edit the commit message")),
    ++		OPT_HISTORY_GPG_SIGN(&sign_commit),
    + 		OPT_END(),
    + 	};
    + 	struct strbuf reflog_msg = STRBUF_INIT;
    +@@ builtin/history.c: static int cmd_history_squash(int argc,
    + 	struct rev_info revs = { 0 };
    + 	int ret;
    + 
    ++	repo_config(repo, history_config, &sign_commit);
    + 	argc = parse_options(argc, argv, prefix, options, usage,
    + 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
    + 	if (argc < 2) {
    + 		ret = error(_("command expects a revision range"));
    + 		goto out;
    + 	}
    +-	repo_config(repo, git_default_config, NULL);
    + 
    + 	if (action == REF_ACTION_DEFAULT)
    + 		action = REF_ACTION_BRANCHES;
    +@@ builtin/history.c: static int cmd_history_squash(int argc,
    + 
    + 	ret = commit_tree_ext(repo, "squash", oldest, message_template,
    + 			      oldest->parents, base_tree_oid, tip_tree_oid,
    +-			      &rewritten,
    ++			      sign_commit, &rewritten,
    + 			      edit ? COMMIT_TREE_EDIT_MESSAGE : 0);
    + 	if (ret < 0) {
    + 		ret = error(_("failed writing squashed commit"));
    +@@ builtin/history.c: static int cmd_history_squash(int argc,
    + 
    + 	ret = handle_reference_updates(&revs, action, tip, rewritten,
    + 				       reflog_msg.buf, dry_run,
    ++				       sign_commit,
    + 				       REPLAY_EMPTY_COMMIT_ABORT);
    + 	if (ret < 0) {
    + 		ret = error(_("failed replaying descendants"));
     @@ builtin/history.c: static int cmd_history_drop(int argc,
      	};
      	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
    @@ t/t3454-history-drop.sh: test_expect_success 'drops a commit in the middle and r
      test_expect_success 'drops the HEAD commit' '
      	test_when_finished "rm -rf repo" &&
      	git init repo &&
    +
    + ## t/t3455-history-squash.sh ##
    +@@
    + test_description='tests for git-history squash subcommand'
    + 
    + . ./test-lib.sh
    ++. "$TEST_DIRECTORY/lib-gpg.sh"
    + 
    + stage_file () {
    + 	printf "%s\n" "$1" >file &&
    +@@ t/t3455-history-squash.sh: check_commit_author () {
    + 	test_cmp expect actual
    + }
    + 
    ++test_squash_gpg_sign () {
    ++	must_fail= will=will
    ++	if test "x$1" = "x!"
    ++	then
    ++		must_fail=test_must_fail
    ++		will="will not"
    ++		shift
    ++	fi
    ++	conf=$1
    ++	shift
    ++
    ++	test_expect_success GPG "squash $* with commit.gpgsign=$conf $will sign rewritten history" "
    ++		test_when_finished 'rm -rf repo' &&
    ++		git init repo &&
    ++		(
    ++			cd repo &&
    ++			test_commit first &&
    ++			test_commit second &&
    ++			test_commit third &&
    ++			test_commit fourth &&
    ++
    ++			git config commit.gpgsign $conf &&
    ++			git history squash --no-edit $* HEAD~3..HEAD~1 &&
    ++
    ++			$must_fail git verify-commit HEAD~ &&
    ++			$must_fail git verify-commit HEAD
    ++		)
    ++	"
    ++}
    ++
    ++test_squash_gpg_sign ! false
    ++test_squash_gpg_sign   true
    ++test_squash_gpg_sign   false --gpg-sign
    ++test_squash_gpg_sign ! true  --no-gpg-sign
    ++test_squash_gpg_sign ! true  --gpg-sign --no-gpg-sign
    ++test_squash_gpg_sign   false --no-gpg-sign --gpg-sign
    ++
    ++test_expect_success GPG 'squash uses an explicit signing key for rewritten history' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third &&
    ++		test_commit fourth &&
    ++
    ++		git history squash --no-edit -SB7227189 HEAD~3..HEAD~1 &&
    ++
    ++		git verify-commit HEAD~ &&
    ++		git verify-commit HEAD &&
    ++		git log -2 --format=%GK >actual &&
    ++		cat >expect <<-\EOF &&
    ++		65A0EEA02E30CAD7
    ++		65A0EEA02E30CAD7
    ++		EOF
    ++		test_cmp expect actual
    ++	)
    ++'
    ++
    + test_expect_success 'setup linear history touching two files' '
    + 	test_commit base file a start &&
    + 	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
-- 
2.56.0
