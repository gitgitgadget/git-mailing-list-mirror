Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357E3F871C
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783090290; cv=none; b=SXIK8T3zR08gPQftsZIFM/tQrZjPeY+giH0hpLkh0aPmEAXGactMxhqyC0lCtDAkACxbqAbBv7oDPikJ7qmkstjLlusFVLD7f8bISFLCT4DY+zvLrvpA+InYsW4AOXmeNUO4X8MSXcfyOt1UjZ20zbxoGeTjGE1MzHziLURjPPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783090290; c=relaxed/simple;
	bh=/cHbJ8ndZsSXenltzf28lJ/BiPaNe7KxbUuZvXBeZDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bf8AFL1b+OjHBlXj1Gp2Rati1tNTGWsmUzvxB2456cGb0iCFi+6Q/jTkPTHrzjbkZgWMCB/WPvHmti5SB5ywGqWKhqLFnbjawBs7dJlrOSoKH5eCiJeNo4lu3MIhgB9h9r/kPXti/Ed+JnYFAQY7u/2kgbiRhVsmbGmUB6KcJjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=X9Y4awVd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iIh2aZCk; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="X9Y4awVd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iIh2aZCk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AB85CEC00FD;
	Fri,  3 Jul 2026 10:51:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 03 Jul 2026 10:51:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1783090285; x=
	1783176685; bh=4MuoyKP5cWpmKVz1Ul9XNQQtz3zvzYb9qEyw4v1ku3w=; b=X
	9Y4awVd0WbZXCHylyj7epsPM7PU+3Rv61KjDBE2yDCCMcTW+7/S3Cy8S7DitXlTr
	V6FcjZ2OC5ridHkHKZhvCx473hYnf6L/1I6E3lEkP5UW7+2Ttt7csjvscT7cB4F+
	DdG9/7o/yiJbEX29XPfYw24h5b1Lon1U/FlRPxUPfuTUTfVPebtZky5UFNFb48ZI
	gXSDlgzxevB2k96Gh5SFh6HpO7xVCboQF7tM9rcpKCxIgAjivLKzxcjxLkqS/prI
	StIcXzTLVZ5sDW3VXyU4oeoa/XHprrhxz24Qtap0xw/lK0i75cLHBDG2fTjJ1Lug
	8OCjqiYbnwlrlY44N8/Rw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1783090285; x=1783176685; bh=4
	MuoyKP5cWpmKVz1Ul9XNQQtz3zvzYb9qEyw4v1ku3w=; b=iIh2aZCkFyKtO8XCu
	S5iCO3oVYjrynUeeEQeAczlNdU/cIqeE3rnMRXd/3rvmXPlBh8fQ3h4LcHHWuSUI
	keccDmx2IrcZ2LoDMyu1qGtDNb+scGGs3umel67dCvauI7h3r7uxR/YJoma1EXfr
	dbjDfy3stZvvavdTPgfOSEf+azSMwc5pEqROri1qzmGD5sFgJ1zSWH582PgQIZVB
	2L6w48IdBrjy2NpYlxUo4Ea/VD4wjkv0QHWAyifGt+cD/cL5JPP5VnIj6JemWsCr
	zqtF3T0bVNclQ0+eMejkeH3CwNLTjQSy5zlxaLXCvmChl2qBJvKr7ogpqRvmCd2f
	Oihig==
X-ME-Sender: <xms:bcxHapfceQ6UahNaDOyfDKgRoXDmYorWnXsus-81oo8N_40GlVfQHw>
    <xme:bcxHahykMGHbPO-k3ZDKI7r3dAuQnLQyogN447-BuNrpchZQS9mv8oZgdewUrm9bG
    d8m73ayP-cTyZZSUV6j1vW4wj8OrlK5w_2-rqo6E42P-vn0I-5lYHA>
X-ME-Received: <xmr:bcxHavEVF4D8mMpr7OTJFdJRwAQuPZWWXPfheY72RlOZ_y_k8SYGQRWwK_c-wpvQVG3CDhBjzFOvLpo_LTfKbG6RZGy81eJNODg7QZB8Wrj67g>
X-ME-Proxy-Cause: dmFkZTGz2DuS37PJsYMiXVmONp49pbZqJs6v5lUHXjCo+KA0tabdKnmacA2XYN67gr/Y+F
    IOJnUK8sCEB9mCwa9wPtfv1wGlz0RMQ8vT7mSQMOIWZ94CzOv7WQ6Oaq7M00BoFHRiqvH6
    xexm4W9F3UZMKf+SfovBVbDeZY0pOQoqZ9r+AeG/HZftdBWSuFUc8RtxuV8qEqFv5unhF/
    NsEh/fO1UCQKQr3Y6zJGumjRujblWD6HLLsGuUgOg8maa7x3waPE14KWpkEXvQ0GoYH50Y
    t25IJIm+fCEvP8MZ4o6ZE4wJw74pQ7Xf6zEs5a9nM3y+uNlCM6RfctKTG3aBSE3gdqqzWJ
    ly22AFNmCUQ/BeQW+tB4i/bF6xZZ1LTFzn7rP4DhY1XGUSx7c6LRMYo4yu2TUYc+900vxh
    7tRQul3LS6zqWkxTFtt2vmSZ8B22k97S73XgjsG8TToq2/kR2SbKNcCsBEQoCtGSj59hMS
    v1HH+xasMI3CyiCkeqs6372fkSM42rhY5HCeJNjUk06HgO+JXxfZQB+OuJJjHCvaAhE9NZ
    HJoaJT3Iy3MhOHD+qcrgSy85Fbpv77liKcldtAyHuO0tfTsmYtF5i+FDT8y2cWkxQ7uhV8
    Q70l4B4lqsmkua1n8UBa3S7jaEzEzZzigNTSwMZOopBSAFfXwyZ0aE9ZpzsQ
X-ME-Proxy: <xmx:bcxHalwT-CzqkIQDwc53xO9uNms9xTbzsWA4cmitn8GO7GgvNx5y1w>
    <xmx:bcxHags0a_b-1ayLElevvHs_zSBXwf6j3D1vs5DRoqHByxk8nyjSKw>
    <xmx:bcxHai0edkgOWQzEF8LNjdlakM9ef2iTOmEGqBKJDm9IB1YNGVKC7A>
    <xmx:bcxHar8tEOwD0QOrU5FlCBVinoK7snQCcAJWLkRU2IzG4OhkZpToZw>
    <xmx:bcxHaj3x0HljW5DCtdq_fZwozU0LVC_Nz5PjMIVOvxWQE02lRhfeEmC9>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 10:51:24 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH 1/3] builtin/history: sign rewritten commits
Date: Fri,  3 Jul 2026 23:50:35 +0900
Message-ID: <20260703145037.69832-2-git@5ouma.me>
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

The history commands create replacement commits directly instead of
using the sequencer or the commit porcelain. As a result, rewritten
commits ignore commit.gpgsign and cannot be signed on demand.

Read the usual signing configuration before parsing history options.
Add the commit-style -S/--gpg-sign knob, and pass the selected
signing key through direct rewrites and replayed descendants.

Signed-off-by: Souma <git@5ouma.me>
---
 builtin/history.c | 80 ++++++++++++++++++++++++++++++++++++-----------
 replay.c          | 13 +++++---
 replay.h          |  6 ++++
 3 files changed, 76 insertions(+), 23 deletions(-)

diff --git a/builtin/history.c b/builtin/history.c
index 091465a59e..8d669cf539 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -25,11 +25,11 @@
 #include "wt-status.h"
 
 #define GIT_HISTORY_FIXUP_USAGE \
-	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]")
+	N_("git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
 #define GIT_HISTORY_REWORD_USAGE \
-	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
+	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]")
 #define GIT_HISTORY_SPLIT_USAGE \
-	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]")
+	N_("git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -98,6 +98,30 @@ enum commit_tree_flags {
 	COMMIT_TREE_EDIT_MESSAGE = (1 << 0),
 };
 
+static int history_config(const char *var, const char *value,
+			  const struct config_context *ctx, void *data)
+{
+	const char **sign_commit = data;
+
+	if (!strcmp(var, "commit.gpgsign")) {
+		*sign_commit = git_config_bool(var, value) ? "" : NULL;
+		return 0;
+	}
+
+	return git_default_config(var, value, ctx, data);
+}
+
+#define OPT_HISTORY_GPG_SIGN(v) { \
+	.type = OPTION_STRING, \
+	.short_name = 'S', \
+	.long_name = "gpg-sign", \
+	.value = (v), \
+	.argh = N_("key-id"), \
+	.help = N_("GPG-sign rewritten commits"), \
+	.flags = PARSE_OPT_OPTARG, \
+	.defval = (intptr_t) "", \
+}
+
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
@@ -105,6 +129,7 @@ static int commit_tree_ext(struct repository *repo,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
 			   struct commit **out,
+			   const char *sign_commit,
 			   enum commit_tree_flags flags)
 {
 	const char *exclude_gpgsig[] = {
@@ -144,7 +169,7 @@ static int commit_tree_ext(struct repository *repo,
 
 	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree,
 				   parents, &rewritten_commit_oid, original_author,
-				   NULL, NULL, original_extra_headers);
+				   NULL, sign_commit, original_extra_headers);
 	if (ret < 0)
 		goto out;
 
@@ -160,7 +185,8 @@ static int commit_tree_ext(struct repository *repo,
 static int commit_tree_with_edited_message(struct repository *repo,
 					   const char *action,
 					   struct commit *original,
-					   struct commit **out)
+					   struct commit **out,
+					   const char *sign_commit)
 {
 	struct object_id parent_tree_oid;
 	const struct object_id *tree_oid;
@@ -181,7 +207,8 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	}
 
 	return commit_tree_ext(repo, action, original, original->parents,
-			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
+			       &parent_tree_oid, tree_oid, out, sign_commit,
+			       COMMIT_TREE_EDIT_MESSAGE);
 }
 
 enum ref_action {
@@ -339,11 +366,13 @@ static int handle_reference_updates(struct rev_info *revs,
 				    struct commit *rewritten,
 				    const char *reflog_msg,
 				    int dry_run,
+				    const char *sign_commit,
 				    enum replay_empty_commit_action empty)
 {
 	const struct name_decoration *decoration;
 	struct replay_revisions_options opts = {
 		.empty = empty,
+		.sign_commit = sign_commit,
 	};
 	struct replay_result result = { 0 };
 	struct ref_transaction *transaction = NULL;
@@ -491,6 +520,7 @@ static int cmd_history_fixup(int argc,
 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
 	enum ref_action action = REF_ACTION_DEFAULT;
 	enum commit_tree_flags flags = 0;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -504,6 +534,7 @@ static int cmd_history_fixup(int argc,
 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct merge_result merge_result = { 0 };
@@ -515,12 +546,13 @@ static int cmd_history_fixup(int argc,
 	bool skip_commit = false;
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
+
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -645,7 +677,7 @@ static int cmd_history_fixup(int argc,
 	if (!skip_commit) {
 		ret = commit_tree_ext(repo, "fixup", original, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
-				      &rewritten, flags);
+				      &rewritten, sign_commit, flags);
 		if (ret < 0) {
 			ret = error(_("failed writing fixed-up commit"));
 			goto out;
@@ -655,7 +687,7 @@ static int cmd_history_fixup(int argc,
 	strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, empty);
+				       reflog_msg.buf, dry_run, sign_commit, empty);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -680,6 +712,7 @@ static int cmd_history_reword(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -687,6 +720,7 @@ static int cmd_history_reword(int argc,
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -694,12 +728,13 @@ static int cmd_history_reword(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
+
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -714,7 +749,8 @@ static int cmd_history_reword(int argc,
 	if (ret)
 		goto out;
 
-	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
+	ret = commit_tree_with_edited_message(repo, "reworded", original,
+					      &rewritten, sign_commit);
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
 		goto out;
@@ -723,7 +759,8 @@ static int cmd_history_reword(int argc,
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
+				       reflog_msg.buf, dry_run, sign_commit,
+				       REPLAY_EMPTY_COMMIT_ABORT);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -785,7 +822,8 @@ static int write_ondisk_index(struct repository *repo,
 static int split_commit(struct repository *repo,
 			struct commit *original,
 			struct pathspec *pathspec,
-			struct commit **out)
+			struct commit **out,
+			const char *sign_commit)
 {
 	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
 	struct strbuf index_file = STRBUF_INIT;
@@ -862,7 +900,8 @@ static int split_commit(struct repository *repo,
 	 * that shall be diffed against is the parent of the original commit.
 	 */
 	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
-			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
+			      &split_tree->object.oid, &first_commit, sign_commit,
+			      COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
 		goto out;
@@ -879,7 +918,8 @@ static int split_commit(struct repository *repo,
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
 	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
-			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
+			      new_tree_oid, &second_commit, sign_commit,
+			      COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
 		goto out;
@@ -907,6 +947,7 @@ static int cmd_history_split(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -914,6 +955,7 @@ static int cmd_history_split(int argc,
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct commit *original, *rewritten = NULL;
@@ -922,12 +964,13 @@ static int cmd_history_split(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
+
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc < 1) {
 		ret = error(_("command expects a committish"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -953,14 +996,15 @@ static int cmd_history_split(int argc,
 		goto out;
 	}
 
-	ret = split_commit(repo, original, &pathspec, &rewritten);
+	ret = split_commit(repo, original, &pathspec, &rewritten, sign_commit);
 	if (ret < 0)
 		goto out;
 
 	strbuf_addf(&reflog_msg, "split: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
+				       reflog_msg.buf, dry_run, sign_commit,
+				       REPLAY_EMPTY_COMMIT_ABORT);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
diff --git a/replay.c b/replay.c
index da531d5bc6..683c384ef8 100644
--- a/replay.c
+++ b/replay.c
@@ -81,13 +81,13 @@ static struct commit *create_commit(struct repository *repo,
 				    struct tree *tree,
 				    struct commit *based_on,
 				    struct commit *parent,
-				    enum replay_mode mode)
+				    enum replay_mode mode,
+				    const char *sign_commit)
 {
 	struct object_id ret;
 	struct object *obj = NULL;
 	struct commit_list *parents = NULL;
 	char *author = NULL;
-	char *sign_commit = NULL; /* FIXME: cli users might want to sign again */
 	struct commit_extra_header *extra = NULL;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
@@ -270,7 +270,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 					  struct merge_options *merge_opt,
 					  struct merge_result *result,
 					  enum replay_mode mode,
-					  enum replay_empty_commit_action empty)
+					  enum replay_empty_commit_action empty,
+					  const char *sign_commit)
 {
 	struct commit *base, *replayed_base;
 	struct tree *pickme_tree, *base_tree, *replayed_base_tree;
@@ -341,7 +342,8 @@ static struct commit *pick_regular_commit(struct repository *repo,
 		}
 	}
 
-	return create_commit(repo, result->tree, pickme, replayed_base, mode);
+	return create_commit(repo, result->tree, pickme, replayed_base, mode,
+			     sign_commit);
 }
 
 void replay_result_release(struct replay_result *result)
@@ -431,7 +433,8 @@ int replay_revisions(struct rev_info *revs,
 
 		last_commit = pick_regular_commit(revs->repo, commit, replayed_commits,
 						  mode == REPLAY_MODE_REVERT ? last_commit : onto,
-						  &merge_opt, &result, mode, opts->empty);
+						  &merge_opt, &result, mode, opts->empty,
+						  opts->sign_commit);
 		if (!last_commit)
 			break;
 
diff --git a/replay.h b/replay.h
index faf95c7459..c715504d78 100644
--- a/replay.h
+++ b/replay.h
@@ -57,6 +57,12 @@ struct replay_revisions_options {
 	 */
 	int contained;
 
+	/*
+	 * Key used to sign newly-created commits. An empty string requests the
+	 * default configured signing key, and NULL disables signing.
+	 */
+	const char *sign_commit;
+
 	/*
 	 * Controls what to do when a replayed commit becomes empty.
 	 * Defaults to REPLAY_EMPTY_COMMIT_DROP.
-- 
2.55.0

