Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFA82BEC27
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299929; cv=none; b=tvsq0rsjIigDiORml4LoiARfg9dyPTiV9Nd+LMMyijw2Z/c1QNwuFbeuQ68TJTQETeeL8uml7Kn9XiqqCmiRxhEZJ8cB+X9JVNhiLgiIfZRnrx7cTWJT2EAhmvV0l6IyqrTuQ5rA16/MGpd1ypFKRluLzRL8bfrDgNQiQcdz5FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299929; c=relaxed/simple;
	bh=6iiBQx65Qh2vfYRI5VdSXQDMa8P+wXarHJDGX3T+v/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o1lYwd9lra6kJ8hRucBzkA//xpvzNSdFpdv9byF7vMwIp3pBGkELqlHVuD8Ibx9AyQiy4kNngWJCVUWIvhTQTQaeGKFTGo+vew48VFAc73lCLm9n3/7QJGsj/dhM9m4hPBdeUTUQzYr5A0WxqfWma0U+uA85SdMZ3k7T01fEfu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=ThG4vUH8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g36qA9zI; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="ThG4vUH8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g36qA9zI"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 3735FEC009A;
	Fri, 17 Jul 2026 10:51:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 17 Jul 2026 10:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784299918; x=
	1784386318; bh=cY2aj47I+pzGk4A4bmFAnZPM3dbEmAXSQLU45EjJqpo=; b=T
	hG4vUH8gpypB2Nn+IVWFmvrfXXO8BkVBw6MnuMwr6escV0aHzso0eIkqz8ySxs5f
	gTsdF0ra8rdr2tZcP7AIEXDkYLF5QqPzMQPWYrV6i9In705p9GZYJtcmpMAsQ7a7
	uhOE/px/r5poeQ6zPoSRmT6+t1+k244+rzxnz8pH/EX2jnVmAVWBu2KtZF47YTD5
	3ZvUXgRL3mrv2lo8I43ghocr3Z7F8xKHVI00XrdIAal8RtMx4f19zUsgMMXNQZLh
	1US8wGaxoE9HGeUotvdAeqLes48oXmnKLTJEB/zR3TjdD2UXD+TVqZWE1OFYHqji
	ROVJnx3oGJvd+sCSFuK+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784299918; x=1784386318; bh=c
	Y2aj47I+pzGk4A4bmFAnZPM3dbEmAXSQLU45EjJqpo=; b=g36qA9zIyDX1K8A5O
	dbVY0Qn+vzEwOJ3M6wrZo+JR+lRB0H+iZC5yk1ZqXgFQCbd5eS/vTSPNgbk2VjPD
	PjX+MSO6Yr4rWYsmCGHqdH62mNgjqfMJAGiSnm83Mq8yKXiUQHbkZiabq+dec4L6
	d+UXaepfbAPyNrPFE1DKO1m6Od3f2kpQccdLzTQ6oOUrAfMwMgUA1xN7nSTN7i3O
	vZpHWyg1jON3F48RcIqYS9+ztRT/+s9sbjzEz2VxLuSvkTDrD1oEbv41ngQfpFlC
	R7DhGkBCHe0iEQl/yrZiI0ZVCVdOkch6GaqMV3KhG4MqCWTzFAW+2UAKXh3U7bAY
	U14Zg==
X-ME-Sender: <xms:jUFaagzAk5qmtWnd1CRcydKlND46Mz7DWv5uofbsgPhzxPjgG17dVg>
    <xme:jUFaarRNsmXJ_S5oc7-K33TDr4OflJ9QZh0PFl5gCeIgAviXunEickr61JIgeL_P5
    Q065ZT1xyEHHr1jdPYNUcj0lefqXKwyBL_XznlT-G_3HZaypyCWLP8>
X-ME-Received: <xmr:jUFaanXblKbUBeF9zgQVqe8KzVOb6O_CqKJ2DysA57Cb6EVl-0--UgU8GZzfRUh9LhUH68goIonMFdgziXnETwd5t6JKEhEWNK6mJvalnWGV8w>
X-ME-Proxy-Cause: dmFkZTFXwRJnN4HMmSR0qTiqBzDRjJN4UzwrlTglnd7CENBM7aL35EyvDDU7ZQAM+1UOaU
    XNPjb97jtV30uHWib6ZXpy5xl04MoCAA6pynRgZs6AxdPIzg26nAmqWbmmIHcTC+BmRAu2
    rXORLwcjkLQpzqjTB6Vmqjn9sHWthc+rn2BpXnZdnnJA8ZPMwmo0rwv4dKn0yRpFoOef3x
    5U9NnrUblgEIrdNNN209Fd20JJtEAMySLPabkNtR4xauwFkMcxnNzc4gYqf1nW92LxNBRn
    3q2KoXkseCU4QCXXUqDeufTcRq+zvmOLaRxn6SyAIdtrP9H6R30NMshMqeNMyb2HX/vjLF
    dZAv7+OU27H/yKqLG4YO1ZD4M7ChaIqQ19usm+a6di7MRko9VScVygo8Z0/+HM+SivfZ8z
    wdQ0hx/tjUkLCEsLVDI3NUBVmeK2ZOeaKhXc9mqC4Ioh4oAZlM7B6o8of7LnnQCOQiZZ2e
    cTuzPCi+U9g2txZ9hap0at7pUqR7qmXUBj7OXPz0xDO2ZTLs4x2yGv1lPpW1YwfLOW8YJY
    hC+UIeXgnEllckqCpvj1pIqEBqhKnpMQaBUXk0pMaaaQ3tq6AtBB8FCXG8epoOLXoqTBS0
    eb7QzF1roTGP1O8dAkUSu5sDK9m+awWcQY235zIrmKMyWGQlviob4kvHX8Kg
X-ME-Proxy: <xmx:jUFaataciEkm09WkYtLO0gXi4AHU5yBGY-eVyUl-xgD9idJ_67MrvQ>
    <xmx:jUFaat1AnOL3VNUgE2wc28gLPI47woxjH-5PwDyOgeuzph6nbmIEuA>
    <xmx:jUFaavh5IJ-fVJ6zhF1xuYqYDdI8WNlzTb9vVWxA8UwWZTG-RipkNQ>
    <xmx:jUFaahbS8_bQ_7f3XrnUNlfwJt2iS7SXS4qYGd3YG0H1VrWGmbhRxg>
    <xmx:jkFaal8uVq0udancrSkIwDVo1l2AA2Vh_5Jbl0ugM8s_dSnH-FrYwIwq>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 10:51:54 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v2 0/2] history: support signing rewritten commits
Date: Fri, 17 Jul 2026 14:51:40 +0000
Message-ID: <20260717145142.39478-1-git@5ouma.me>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703145037.69832-1-git@5ouma.me>
References: <20260703145037.69832-1-git@5ouma.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The history commands create commits directly and via the replay
machinery, but currently have no way to honor `commit.gpgSign` or an
explicit signing request. This means users who require signed commits
lose that property when rewriting history.

Teach the replay API to accept a signing key, then expose the standard
`-S`/`--gpg-sign[=<key-id>]` and `--no-gpg-sign` interface across the
`history drop`, `history fixup`, `history reword`, and `history split`
subcommands. The selected policy applies to every new commit, including
both halves of a split and replayed descendants. A drop of the tip
creates no replacement commit and therefore has nothing to sign.

The implementation follows the precedence used by rebase, cherry-pick,
and revert: `commit.gpgSign` supplies the default, command-line options
override it, and the last command-line option wins.

The signature records the attestation of the current committer to the
rewritten commit while retaining the original author identity; it does
not claim authorship of commits written by somebody else.

Changes since v1:

 - Split the replay signing plumbing into a preparatory patch
 - Fold the documentation and tests into the feature patch so each
   commit builds and passes t0450
 - Move `sign_commit` before the output parameter of `commit_tree_ext()` and
   update its callers accordingly
 - Pass `NULL` to `git_default_config()`
 - Document why configuration is read before command-line options
 - Clarify that every rewritten commit is signed, including commits with
   a different author
 - Add signing support and tests for the new `history drop` subcommand
 - Add coverage for selecting an explicit signing key

Souma (2):
  replay: allow callers to sign commits
  builtin/history: sign rewritten commits

 Documentation/git-history.adoc | 16 +++++--
 builtin/history.c              | 84 ++++++++++++++++++++++++++--------
 replay.c                       | 13 ++++--
 replay.h                       |  6 +++
 t/t3451-history-reword.sh      | 63 +++++++++++++++++++++++++
 t/t3452-history-split.sh       | 44 ++++++++++++++++++
 t/t3453-history-fixup.sh       | 39 ++++++++++++++++
 t/t3454-history-drop.sh        | 50 ++++++++++++++++++++
 8 files changed, 286 insertions(+), 29 deletions(-)

Range-diff against v1:
1:  60f7c13514 ! 1:  3f4dc0b982 builtin/history: sign rewritten commits
    @@ Metadata
     Author: Souma <git@5ouma.me>

      ## Commit message ##
    -    builtin/history: sign rewritten commits
    +    replay: allow callers to sign commits

    -    The history commands create replacement commits directly instead of
    -    using the sequencer or the commit porcelain. As a result, rewritten
    -    commits ignore commit.gpgsign and cannot be signed on demand.
    +    The replay machinery creates commits directly through
    +    `commit_tree_extended()`, but callers cannot currently request
    +    signatures. Commands that replay rewritten history consequently cannot
    +    carry their signing policy through to descendant commits.

    -    Read the usual signing configuration before parsing history options.
    -    Add the commit-style -S/--gpg-sign knob, and pass the selected
    -    signing key through direct rewrites and replayed descendants.
    +    Add `sign_commit` to `replay_revisions_options` and thread it through
    +    commit creation. `NULL` preserves the existing unsigned behavior, an
    +    empty string selects the default signing key, and a non-empty string
    +    selects an explicit key. Existing callers zero-initialize the options
    +    structure, so their behavior is unchanged.

         Signed-off-by: Souma <git@5ouma.me>

    - ## builtin/history.c ##
    -@@
    - #include "wt-status.h"
    -
    - #define GIT_HISTORY_FIXUP_USAGE \
    --	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]")
    -+	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
    - #define GIT_HISTORY_REWORD_USAGE \
    --	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
    -+	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]")
    - #define GIT_HISTORY_SPLIT_USAGE \
    --	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
    -+	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]")
    -
    - static void change_data_free(void *util, const char *str UNUSED)
    - {
    -@@ builtin/history.c: enum commit_tree_flags {
    - 	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
    - };
    -
    -+static int history_config(const char *var, const char *value,
    -+			  const struct config_context *ctx, void *data)
    -+{
    -+	const char **sign_commit = data;
    -+
    -+	if (!strcmp(var, "commit.gpgsign")) {
    -+		*sign_commit = git_config_bool(var, value) ? "" : NULL;
    -+		return 0;
    -+	}
    -+
    -+	return git_default_config(var, value, ctx, data);
    -+}
    -+
    -+#define OPT_HISTORY_GPG_SIGN(v) { \
    -+	.type = OPTION_STRING, \
    -+	.short_name = 'S', \
    -+	.long_name = "gpg-sign", \
    -+	.value = (v), \
    -+	.argh = N_("key-id"), \
    -+	.help = N_("GPG-sign rewritten commits"), \
    -+	.flags = PARSE_OPT_OPTARG, \
    -+	.defval = (intptr_t) "", \
    -+}
    -+
    - static int commit_tree_ext(struct repository *repo,
    - 			   const char *action,
    - 			   struct commit *commit_with_message,
    -@@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
    - 			   const struct object_id *old_tree,
    - 			   const struct object_id *new_tree,
    - 			   struct commit **out,
    -+			   const char *sign_commit,
    - 			   enum commit_tree_flags flags)
    - {
    - 	const char *exclude_gpgsig[] = {
    -@@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
    -
    - 	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree,
    - 				   parents, &rewritten_commit_oid, original_author,
    --				   NULL, NULL, original_extra_headers);
    -+				   NULL, sign_commit, original_extra_headers);
    - 	if (ret < 0)
    - 		goto out;
    -
    -@@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
    - static int commit_tree_with_edited_message(struct repository *repo,
    - 					   const char *action,
    - 					   struct commit *original,
    --					   struct commit **out)
    -+					   struct commit **out,
    -+					   const char *sign_commit)
    - {
    - 	struct object_id parent_tree_oid;
    - 	const struct object_id *tree_oid;
    -@@ builtin/history.c: static int commit_tree_with_edited_message(struct repository *repo,
    - 	}
    -
    - 	return commit_tree_ext(repo, action, original, original->parents,
    --			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
    -+			       &parent_tree_oid, tree_oid, out, sign_commit,
    -+			       COMMIT_TREE_EDIT_MESSAGE);
    - }
    -
    - enum ref_action {
    -@@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
    - 				    struct commit *rewritten,
    - 				    const char *reflog_msg,
    - 				    int dry_run,
    -+				    const char *sign_commit,
    - 				    enum replay_empty_commit_action empty)
    - {
    - 	const struct name_decoration *decoration;
    - 	struct replay_revisions_options opts = {
    - 		.empty = empty,
    -+		.sign_commit = sign_commit,
    - 	};
    - 	struct replay_result result = { 0 };
    - 	struct ref_transaction *transaction = NULL;
    -@@ builtin/history.c: static int cmd_history_fixup(int argc,
    - 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
    - 	enum ref_action action = REF_ACTION_DEFAULT;
    - 	enum commit_tree_flags flags = 0;
    -+	const char *sign_commit = NULL;
    - 	int dry_run = 0;
    - 	struct option options[] = {
    - 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
    -@@ builtin/history.c: static int cmd_history_fixup(int argc,
    - 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
    - 			       N_("how to handle commits that become empty"),
    - 			       PARSE_OPT_NONEG, parse_opt_empty),
    -+		OPT_HISTORY_GPG_SIGN(&sign_commit),
    - 		OPT_END(),
    - 	};
    - 	struct merge_result merge_result = { 0 };
    -@@ builtin/history.c: static int cmd_history_fixup(int argc,
    - 	bool skip_commit = false;
    - 	int ret;
    -
    -+	repo_config(repo, history_config, &sign_commit);
    -+
    - 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    - 	if (argc != 1) {
    - 		ret = error(_("command expects a single revision"));
    - 		goto out;
    - 	}
    --	repo_config(repo, git_default_config, NULL);
    -
    - 	if (action == REF_ACTION_DEFAULT)
    - 		action = REF_ACTION_BRANCHES;
    -@@ builtin/history.c: static int cmd_history_fixup(int argc,
    - 	if (!skip_commit) {
    - 		ret = commit_tree_ext(repo, "fixup", original, original->parents,
    - 				      &original_tree->object.oid, &merge_result.tree->object.oid,
    --				      &rewritten, flags);
    -+				      &rewritten, sign_commit, flags);
    - 		if (ret < 0) {
    - 			ret = error(_("failed writing fixed-up commit"));
    - 			goto out;
    -@@ builtin/history.c: static int cmd_history_fixup(int argc,
    - 	strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
    -
    - 	ret = handle_reference_updates(&revs, action, original, rewritten,
    --				       reflog_msg.buf, dry_run, empty);
    -+				       reflog_msg.buf, dry_run, sign_commit, empty);
    - 	if (ret < 0) {
    - 		ret = error(_("failed replaying descendants"));
    - 		goto out;
    -@@ builtin/history.c: static int cmd_history_reword(int argc,
    - 		NULL,
    - 	};
    - 	enum ref_action action = REF_ACTION_DEFAULT;
    -+	const char *sign_commit = NULL;
    - 	int dry_run = 0;
    - 	struct option options[] = {
    - 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
    -@@ builtin/history.c: static int cmd_history_reword(int argc,
    - 			       PARSE_OPT_NONEG, parse_ref_action),
    - 		OPT_BOOL('n', "dry-run", &dry_run,
    - 			 N_("perform a dry-run without updating any refs")),
    -+		OPT_HISTORY_GPG_SIGN(&sign_commit),
    - 		OPT_END(),
    - 	};
    - 	struct strbuf reflog_msg = STRBUF_INIT;
    -@@ builtin/history.c: static int cmd_history_reword(int argc,
    - 	struct rev_info revs = { 0 };
    - 	int ret;
    -
    -+	repo_config(repo, history_config, &sign_commit);
    -+
    - 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    - 	if (argc != 1) {
    - 		ret = error(_("command expects a single revision"));
    - 		goto out;
    - 	}
    --	repo_config(repo, git_default_config, NULL);
    -
    - 	if (action == REF_ACTION_DEFAULT)
    - 		action = REF_ACTION_BRANCHES;
    -@@ builtin/history.c: static int cmd_history_reword(int argc,
    - 	if (ret)
    - 		goto out;
    -
    --	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
    -+	ret = commit_tree_with_edited_message(repo, "reworded", original,
    -+					      &rewritten, sign_commit);
    - 	if (ret < 0) {
    - 		ret = error(_("failed writing reworded commit"));
    - 		goto out;
    -@@ builtin/history.c: static int cmd_history_reword(int argc,
    - 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
    -
    - 	ret = handle_reference_updates(&revs, action, original, rewritten,
    --				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
    -+				       reflog_msg.buf, dry_run, sign_commit,
    -+				       REPLAY_EMPTY_COMMIT_ABORT);
    - 	if (ret < 0) {
    - 		ret = error(_("failed replaying descendants"));
    - 		goto out;
    -@@ builtin/history.c: static int write_ondisk_index(struct repository *repo,
    - static int split_commit(struct repository *repo,
    - 			struct commit *original,
    - 			struct pathspec *pathspec,
    --			struct commit **out)
    -+			struct commit **out,
    -+			const char *sign_commit)
    - {
    - 	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
    - 	struct strbuf index_file = STRBUF_INIT;
    -@@ builtin/history.c: static int split_commit(struct repository *repo,
    - 	 * that shall be diffed against is the parent of the original commit.
    - 	 */
    - 	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
    --			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
    -+			      &split_tree->object.oid, &first_commit, sign_commit,
    -+			      COMMIT_TREE_EDIT_MESSAGE);
    - 	if (ret < 0) {
    - 		ret = error(_("failed writing first commit"));
    - 		goto out;
    -@@ builtin/history.c: static int split_commit(struct repository *repo,
    - 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
    -
    - 	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
    --			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
    -+			      new_tree_oid, &second_commit, sign_commit,
    -+			      COMMIT_TREE_EDIT_MESSAGE);
    - 	if (ret < 0) {
    - 		ret = error(_("failed writing second commit"));
    - 		goto out;
    -@@ builtin/history.c: static int cmd_history_split(int argc,
    - 		NULL,
    - 	};
    - 	enum ref_action action = REF_ACTION_DEFAULT;
    -+	const char *sign_commit = NULL;
    - 	int dry_run = 0;
    - 	struct option options[] = {
    - 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
    -@@ builtin/history.c: static int cmd_history_split(int argc,
    - 			       PARSE_OPT_NONEG, parse_ref_action),
    - 		OPT_BOOL('n', "dry-run", &dry_run,
    - 			 N_("perform a dry-run without updating any refs")),
    -+		OPT_HISTORY_GPG_SIGN(&sign_commit),
    - 		OPT_END(),
    - 	};
    - 	struct commit *original, *rewritten = NULL;
    -@@ builtin/history.c: static int cmd_history_split(int argc,
    - 	struct rev_info revs = { 0 };
    - 	int ret;
    -
    -+	repo_config(repo, history_config, &sign_commit);
    -+
    - 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    - 	if (argc < 1) {
    - 		ret = error(_("command expects a committish"));
    - 		goto out;
    - 	}
    --	repo_config(repo, git_default_config, NULL);
    -
    - 	if (action == REF_ACTION_DEFAULT)
    - 		action = REF_ACTION_BRANCHES;
    -@@ builtin/history.c: static int cmd_history_split(int argc,
    - 		goto out;
    - 	}
    -
    --	ret = split_commit(repo, original, &pathspec, &rewritten);
    -+	ret = split_commit(repo, original, &pathspec, &rewritten, sign_commit);
    - 	if (ret < 0)
    - 		goto out;
    -
    - 	strbuf_addf(&reflog_msg, "split: updating %s", argv[0]);
    -
    - 	ret = handle_reference_updates(&revs, action, original, rewritten,
    --				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
    -+				       reflog_msg.buf, dry_run, sign_commit,
    -+				       REPLAY_EMPTY_COMMIT_ABORT);
    - 	if (ret < 0) {
    - 		ret = error(_("failed replaying descendants"));
    - 		goto out;
    -
      ## replay.c ##
     @@ replay.c: static struct commit *create_commit(struct repository *repo,
      				    struct tree *tree,
2:  9935928b01 < -:  ---------- doc: document history signing options
3:  c017e90034 ! 2:  0e63c0b66a t345x: cover signed history rewrites
    @@ Metadata
     Author: Souma <git@5ouma.me>

      ## Commit message ##
    -    t345x: cover signed history rewrites
    +    builtin/history: sign rewritten commits

    -    History signing needs regression coverage because these commands bypass the
    -    usual commit machinery and create replacement commits through lower-level
    -    APIs.
    +    The history commands create replacement commits directly instead of
    +    using the sequencer or the commit porcelain. As a result, rewritten
    +    commits ignore `commit.gpgSign` and cannot be signed on demand.

    -    Add GPG-gated tests for config-driven signing, command-line signing,
    -    --no-gpg-sign precedence, and signing of replayed descendants after fixup,
    -    reword, and split.
    +    Read the signing configuration before parsing options so that it
    +    establishes the default and later `-S`/`--gpg-sign` or `--no-gpg-sign`
    +    options override it. Pass the selected key through direct rewrites and
    +    the replay machinery.
    +
    +    Sign every newly created commit, including both halves of a split and
    +    replayed descendants. Dropping the tip creates no replacement commit,
    +    so there is nothing to sign. As with `rebase --gpg-sign`, the signature
    +    records the attestation of the current committer to the rewritten
    +    commit while retaining the original author identity; it does not claim
    +    authorship of commits written by somebody else.
    +
    +    Document the behavior and add GPG-gated coverage for configuration,
    +    command-line overrides, last-option-wins precedence, replayed
    +    descendants, split commits, an explicit signing key, and the
    +    no-new-commit drop case.

         Signed-off-by: Souma <git@5ouma.me>

    + ## Documentation/git-history.adoc ##
    +@@ Documentation/git-history.adoc: git-history - EXPERIMENTAL: Rewrite history
    + SYNOPSIS
    + --------
    + [synopsis]
    +-git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]
    +-git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
    +-git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
    +-git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
    ++git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
    ++git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
    ++git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
    ++git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]
    +
    + DESCRIPTION
    + -----------
    +@@ Documentation/git-history.adoc: OPTIONS
    + `--reedit-message`::
    + 	Open an editor to modify the target commit's message.
    +
    ++`-S[<key-id>]`::
    ++`--gpg-sign[=<key-id>]`::
    ++`--no-gpg-sign`::
    ++	GPG-sign rewritten commits. The _<key-id>_ argument is optional and
    ++	defaults to the committer identity; if specified, it must be stuck to
    ++	the option without a space. `--no-gpg-sign` is useful to countermand
    ++	both `commit.gpgSign` configuration and earlier `--gpg-sign`.
    ++
    + `--empty=(drop|keep|abort)`::
    + 	Control what happens when a commit becomes empty as a result of the
    + 	fixup. This can happen in two situations:
    +
    + ## builtin/history.c ##
    +@@
    + #include "wt-status.h"
    +
    + #define GIT_HISTORY_DROP_USAGE \
    +-	N_("git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]")
    ++	N_("git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
    + #define GIT_HISTORY_FIXUP_USAGE \
    +-	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]")
    ++	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
    + #define GIT_HISTORY_REWORD_USAGE \
    +-	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
    ++	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]")
    + #define GIT_HISTORY_SPLIT_USAGE \
    +-	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
    ++	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]")
    +
    + static void change_data_free(void *util, const char *str UNUSED)
    + {
    +@@ builtin/history.c: enum commit_tree_flags {
    + 	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
    + };
    +
    ++static int history_config(const char *var, const char *value,
    ++			  const struct config_context *ctx, void *data)
    ++{
    ++	const char **sign_commit = data;
    ++
    ++	if (!strcmp(var, "commit.gpgsign")) {
    ++		*sign_commit = git_config_bool(var, value) ? "" : NULL;
    ++		return 0;
    ++	}
    ++
    ++	return git_default_config(var, value, ctx, NULL);
    ++}
    ++
    ++#define OPT_HISTORY_GPG_SIGN(v) {                 \
    ++	.type = OPTION_STRING,                    \
    ++	.short_name = 'S',                        \
    ++	.long_name = "gpg-sign",                  \
    ++	.value = (v),                             \
    ++	.argh = N_("key-id"),                     \
    ++	.help = N_("GPG-sign rewritten commits"), \
    ++	.flags = PARSE_OPT_OPTARG,                \
    ++	.defval = (intptr_t)"",                   \
    ++}
    ++
    + static int commit_tree_ext(struct repository *repo,
    + 			   const char *action,
    + 			   struct commit *commit_with_message,
    + 			   const struct commit_list *parents,
    + 			   const struct object_id *old_tree,
    + 			   const struct object_id *new_tree,
    ++			   const char *sign_commit,
    + 			   struct commit **out,
    + 			   enum commit_tree_flags flags)
    + {
    +@@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
    +
    + 	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree,
    + 				   parents, &rewritten_commit_oid, original_author,
    +-				   NULL, NULL, original_extra_headers);
    ++				   NULL, sign_commit, original_extra_headers);
    + 	if (ret < 0)
    + 		goto out;
    +
    +@@ builtin/history.c: static int commit_tree_ext(struct repository *repo,
    + static int commit_tree_with_edited_message(struct repository *repo,
    + 					   const char *action,
    + 					   struct commit *original,
    ++					   const char *sign_commit,
    + 					   struct commit **out)
    + {
    + 	struct object_id parent_tree_oid;
    +@@ builtin/history.c: static int commit_tree_with_edited_message(struct repository *repo,
    + 	}
    +
    + 	return commit_tree_ext(repo, action, original, original->parents,
    +-			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
    ++			       &parent_tree_oid, tree_oid, sign_commit, out,
    ++			       COMMIT_TREE_EDIT_MESSAGE);
    + }
    +
    + enum ref_action {
    +@@ builtin/history.c: static int compute_pending_ref_updates(struct rev_info *revs,
    + 				       enum ref_action action,
    + 				       struct commit *original,
    + 				       struct commit *rewritten,
    ++				       const char *sign_commit,
    + 				       enum replay_empty_commit_action empty,
    + 				       struct replay_result *result)
    + {
    + 	const struct name_decoration *decoration;
    + 	struct replay_revisions_options opts = {
    + 		.empty = empty,
    ++		.sign_commit = sign_commit,
    + 	};
    + 	char hex[GIT_MAX_HEXSZ + 1];
    + 	bool detached_head;
    +@@ builtin/history.c: static int handle_reference_updates(struct rev_info *revs,
    + 				    struct commit *rewritten,
    + 				    const char *reflog_msg,
    + 				    int dry_run,
    ++				    const char *sign_commit,
    + 				    enum replay_empty_commit_action empty)
    + {
    + 	struct replay_result result = { 0 };
    + 	int ret;
    +
    + 	ret = compute_pending_ref_updates(revs, action, original, rewritten,
    +-					  empty, &result);
    ++					  sign_commit, empty, &result);
    + 	if (ret)
    + 		goto out;
    +
    +@@ builtin/history.c: static int cmd_history_fixup(int argc,
    + 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
    + 	enum ref_action action = REF_ACTION_DEFAULT;
    + 	enum commit_tree_flags flags = 0;
    ++	const char *sign_commit = NULL;
    + 	int dry_run = 0;
    + 	struct option options[] = {
    + 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
    +@@ builtin/history.c: static int cmd_history_fixup(int argc,
    + 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
    + 			       N_("how to handle commits that become empty"),
    + 			       PARSE_OPT_NONEG, parse_opt_empty),
    ++		OPT_HISTORY_GPG_SIGN(&sign_commit),
    + 		OPT_END(),
    + 	};
    + 	struct merge_result merge_result = { 0 };
    +@@ builtin/history.c: static int cmd_history_fixup(int argc,
    + 	bool skip_commit = false;
    + 	int ret;
    +
    ++	repo_config(repo, history_config, &sign_commit);
    + 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    + 	if (argc != 1) {
    + 		ret = error(_("command expects a single revision"));
    + 		goto out;
    + 	}
    +-	repo_config(repo, git_default_config, NULL);
    +
    + 	if (action == REF_ACTION_DEFAULT)
    + 		action = REF_ACTION_BRANCHES;
    +@@ builtin/history.c: static int cmd_history_fixup(int argc,
    + 	if (!skip_commit) {
    + 		ret = commit_tree_ext(repo, "fixup", original, original->parents,
    + 				      &original_tree->object.oid, &merge_result.tree->object.oid,
    +-				      &rewritten, flags);
    ++				      sign_commit, &rewritten, flags);
    + 		if (ret < 0) {
    + 			ret = error(_("failed writing fixed-up commit"));
    + 			goto out;
    +@@ builtin/history.c: static int cmd_history_fixup(int argc,
    + 	strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
    +
    + 	ret = handle_reference_updates(&revs, action, original, rewritten,
    +-				       reflog_msg.buf, dry_run, empty);
    ++				       reflog_msg.buf, dry_run, sign_commit, empty);
    + 	if (ret < 0) {
    + 		ret = error(_("failed replaying descendants"));
    + 		goto out;
    +@@ builtin/history.c: static int cmd_history_reword(int argc,
    + 		NULL,
    + 	};
    + 	enum ref_action action = REF_ACTION_DEFAULT;
    ++	const char *sign_commit = NULL;
    + 	int dry_run = 0;
    + 	struct option options[] = {
    + 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
    +@@ builtin/history.c: static int cmd_history_reword(int argc,
    + 			       PARSE_OPT_NONEG, parse_ref_action),
    + 		OPT_BOOL('n', "dry-run", &dry_run,
    + 			 N_("perform a dry-run without updating any refs")),
    ++		OPT_HISTORY_GPG_SIGN(&sign_commit),
    + 		OPT_END(),
    + 	};
    + 	struct strbuf reflog_msg = STRBUF_INIT;
    +@@ builtin/history.c: static int cmd_history_reword(int argc,
    + 	struct rev_info revs = { 0 };
    + 	int ret;
    +
    ++	repo_config(repo, history_config, &sign_commit);
    + 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    + 	if (argc != 1) {
    + 		ret = error(_("command expects a single revision"));
    + 		goto out;
    + 	}
    +-	repo_config(repo, git_default_config, NULL);
    +
    + 	if (action == REF_ACTION_DEFAULT)
    + 		action = REF_ACTION_BRANCHES;
    +@@ builtin/history.c: static int cmd_history_reword(int argc,
    + 	if (ret)
    + 		goto out;
    +
    +-	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
    ++	ret = commit_tree_with_edited_message(repo, "reworded", original,
    ++					      sign_commit, &rewritten);
    + 	if (ret < 0) {
    + 		ret = error(_("failed writing reworded commit"));
    + 		goto out;
    +@@ builtin/history.c: static int cmd_history_reword(int argc,
    + 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
    +
    + 	ret = handle_reference_updates(&revs, action, original, rewritten,
    +-				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
    ++				       reflog_msg.buf, dry_run, sign_commit,
    ++				       REPLAY_EMPTY_COMMIT_ABORT);
    + 	if (ret < 0) {
    + 		ret = error(_("failed replaying descendants"));
    + 		goto out;
    +@@ builtin/history.c: static int write_ondisk_index(struct repository *repo,
    + static int split_commit(struct repository *repo,
    + 			struct commit *original,
    + 			struct pathspec *pathspec,
    ++			const char *sign_commit,
    + 			struct commit **out)
    + {
    + 	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
    +@@ builtin/history.c: static int split_commit(struct repository *repo,
    + 	 * that shall be diffed against is the parent of the original commit.
    + 	 */
    + 	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
    +-			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
    ++			      &split_tree->object.oid, sign_commit, &first_commit,
    ++			      COMMIT_TREE_EDIT_MESSAGE);
    + 	if (ret < 0) {
    + 		ret = error(_("failed writing first commit"));
    + 		goto out;
    +@@ builtin/history.c: static int split_commit(struct repository *repo,
    + 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
    +
    + 	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
    +-			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
    ++			      new_tree_oid, sign_commit, &second_commit,
    ++			      COMMIT_TREE_EDIT_MESSAGE);
    + 	if (ret < 0) {
    + 		ret = error(_("failed writing second commit"));
    + 		goto out;
    +@@ builtin/history.c: static int cmd_history_split(int argc,
    + 		NULL,
    + 	};
    + 	enum ref_action action = REF_ACTION_DEFAULT;
    ++	const char *sign_commit = NULL;
    + 	int dry_run = 0;
    + 	struct option options[] = {
    + 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
    +@@ builtin/history.c: static int cmd_history_split(int argc,
    + 			       PARSE_OPT_NONEG, parse_ref_action),
    + 		OPT_BOOL('n', "dry-run", &dry_run,
    + 			 N_("perform a dry-run without updating any refs")),
    ++		OPT_HISTORY_GPG_SIGN(&sign_commit),
    + 		OPT_END(),
    + 	};
    + 	struct commit *original, *rewritten = NULL;
    +@@ builtin/history.c: static int cmd_history_split(int argc,
    + 	struct rev_info revs = { 0 };
    + 	int ret;
    +
    ++	repo_config(repo, history_config, &sign_commit);
    + 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    + 	if (argc < 1) {
    + 		ret = error(_("command expects a committish"));
    + 		goto out;
    + 	}
    +-	repo_config(repo, git_default_config, NULL);
    +
    + 	if (action == REF_ACTION_DEFAULT)
    + 		action = REF_ACTION_BRANCHES;
    +@@ builtin/history.c: static int cmd_history_split(int argc,
    + 		goto out;
    + 	}
    +
    +-	ret = split_commit(repo, original, &pathspec, &rewritten);
    ++	ret = split_commit(repo, original, &pathspec, sign_commit, &rewritten);
    + 	if (ret < 0)
    + 		goto out;
    +
    + 	strbuf_addf(&reflog_msg, "split: updating %s", argv[0]);
    +
    + 	ret = handle_reference_updates(&revs, action, original, rewritten,
    +-				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
    ++				       reflog_msg.buf, dry_run, sign_commit,
    ++				       REPLAY_EMPTY_COMMIT_ABORT);
    + 	if (ret < 0) {
    + 		ret = error(_("failed replaying descendants"));
    + 		goto out;
    +@@ builtin/history.c: static int cmd_history_drop(int argc,
    + 	};
    + 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
    + 	enum ref_action action = REF_ACTION_DEFAULT;
    ++	const char *sign_commit = NULL;
    + 	int dry_run = 0;
    + 	struct option options[] = {
    + 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
    +@@ builtin/history.c: static int cmd_history_drop(int argc,
    + 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
    + 			       N_("how to handle descendants that become empty"),
    + 			       PARSE_OPT_NONEG, parse_opt_empty),
    ++		OPT_HISTORY_GPG_SIGN(&sign_commit),
    + 		OPT_END(),
    + 	};
    + 	struct strbuf reflog_msg = STRBUF_INIT;
    +@@ builtin/history.c: static int cmd_history_drop(int argc,
    + 	bool head_moves = false;
    + 	int ret;
    +
    ++	repo_config(repo, history_config, &sign_commit);
    + 	argc = parse_options(argc, argv, prefix, options, usage, 0);
    + 	if (argc != 1) {
    + 		ret = error(_("command expects a single revision"));
    + 		goto out;
    + 	}
    +-	repo_config(repo, git_default_config, NULL);
    +
    + 	if (action == REF_ACTION_DEFAULT)
    + 		action = REF_ACTION_BRANCHES;
    +@@ builtin/history.c: static int cmd_history_drop(int argc,
    + 	rewritten = original->parents->item;
    +
    + 	ret = compute_pending_ref_updates(&revs, action, original, rewritten,
    +-					  empty, &result);
    ++					  sign_commit, empty, &result);
    + 	if (ret) {
    + 		ret = error(_("failed replaying descendants"));
    + 		goto out;
    +
      ## t/t3451-history-reword.sh ##
     @@ t/t3451-history-reword.sh: test_description='tests for git-history reword subcommand'

    @@ t/t3451-history-reword.sh: test_expect_success 'can reword commit in the middle'
     +test_reword_gpg_sign ! true  --no-gpg-sign
     +test_reword_gpg_sign ! true  --gpg-sign --no-gpg-sign
     +test_reword_gpg_sign   false --no-gpg-sign --gpg-sign
    ++
    ++test_expect_success GPG 'reword uses an explicit signing key for rewritten history' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++		test_commit third &&
    ++
    ++		reword_with_message -SB7227189 HEAD~ <<-EOF &&
    ++		second reworded
    ++		EOF
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
     +
      test_expect_success 'can reword commit in the middle even on detached head' '
      	test_when_finished "rm -rf repo" &&
    @@ t/t3453-history-fixup.sh: test_expect_success 'preserves commit message and auth
      test_expect_success 'updates all descendant branches by default' '
      	test_when_finished "rm -rf repo" &&
      	git init repo --initial-branch=main &&
    +
    + ## t/t3454-history-drop.sh ##
    +@@ t/t3454-history-drop.sh: test_description='tests for git-history drop subcommand'
    +
    + . ./test-lib.sh
    + . "$TEST_DIRECTORY/lib-log-graph.sh"
    ++. "$TEST_DIRECTORY/lib-gpg.sh"
    +
    + expect_graph () {
    + 	cat >expect &&
    +@@ t/t3454-history-drop.sh: expect_log () {
    + 	test_cmp expect actual
    + }
    +
    ++test_drop_gpg_sign () {
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
    ++	test_expect_success GPG "drop $* with commit.gpgsign=$conf $will sign replayed descendants" "
    ++		test_when_finished 'rm -rf repo' &&
    ++		git init repo &&
    ++		(
    ++			cd repo &&
    ++			test_commit first &&
    ++			test_commit second &&
    ++			test_commit third &&
    ++
    ++			git config commit.gpgsign $conf &&
    ++			git history drop $* HEAD~ &&
    ++
    ++			$must_fail git verify-commit HEAD
    ++		)
    ++	"
    ++}
    ++
    + test_expect_success 'errors on missing commit argument' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
    +@@ t/t3454-history-drop.sh: test_expect_success 'drops a commit in the middle and replays descendants' '
    + 	)
    + '
    +
    ++test_drop_gpg_sign ! false
    ++test_drop_gpg_sign   true
    ++test_drop_gpg_sign   false --gpg-sign
    ++test_drop_gpg_sign ! true  --no-gpg-sign
    ++test_drop_gpg_sign ! true  --gpg-sign --no-gpg-sign
    ++test_drop_gpg_sign   false --no-gpg-sign --gpg-sign
    ++
    ++test_expect_success GPG 'drop has no commit to sign when dropping the tip' '
    ++	test_when_finished "rm -rf repo" &&
    ++	git init repo &&
    ++	(
    ++		cd repo &&
    ++		test_commit first &&
    ++		test_commit second &&
    ++
    ++		git history drop --gpg-sign HEAD &&
    ++
    ++		test_must_fail git verify-commit HEAD
    ++	)
    ++'
    ++
    + test_expect_success 'drops the HEAD commit' '
    + 	test_when_finished "rm -rf repo" &&
    + 	git init repo &&
--
2.55.0

