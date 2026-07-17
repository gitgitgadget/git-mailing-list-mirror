Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A73473FD14D
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299937; cv=none; b=D2GZWwjLnNsQaU1aLFX3AXcwcwpF6HUsQf3d0PgyzhLYte7ghG+48XMgqJb+fnKsQ+/DMCgJaqzxsq0unBB23DUg3KyfPNgwlLCu7FA4zRaFLgffUfRBfSHOEMHlzl3gFBi0eO9glkow1FHVX0vDs4674GnOG1c07/WRdZRku00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299937; c=relaxed/simple;
	bh=khrzXUWol4Tcf9CG7E7VIqSUD9e/q26p8qiBdOZQc+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kO0EnFA/ttcGy60iANfKpX4i+u+0a5WBxUEJQx2kbzeF+hfD78nV9CnM9I9sOO7BNvNUeeRzZTZwy9dWdhWktZKGuaotMHO3QBy5crgH+mMBpi8aZowEyOvTBXSt8rqdZcpMqAv47fmPIxHLHnsnYcAli4gbVMyFmLU1r6n+xj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=RXh5jmf9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ouRJUa14; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="RXh5jmf9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ouRJUa14"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 72324140002B;
	Fri, 17 Jul 2026 10:52:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 17 Jul 2026 10:52:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1784299927; x=
	1784386327; bh=/16UIFo20dolemWf8lOWEEe+q+5CZ7aUjQknvGRX+TI=; b=R
	Xh5jmf9lMrIWT/tMRqmDyJHy2h5b+Uabi/c2h/IIXrVwx5XVuU/xwVoCxUv8RDY6
	4N4+tRmFP/6VL25WGfAyMbkjAsgKaH8Ap8l3eGuvpdfnIGlQNcD7A2VVdAIjX9V+
	ZPHG7WZmI1/QNdaMgVgJP14Dpo7GkQC+kp0wH6bK0zXCf49TgBQ41SdcRLmaJEy+
	WQ/4cWoqrlHBXZ3LFGh0OnU6gkRJeXqih2s4HAyFzB/Vm5Ehv+zBCyoK+cCnSte4
	KgFTYn8EUE8BtvqzdqfgEjHzDEN/FHBAFUAKVnZFrkEduALdpWd0ekvVs77cbEW+
	tK0Glp/JL5aLDNwjkZ6ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1784299927; x=1784386327; bh=/
	16UIFo20dolemWf8lOWEEe+q+5CZ7aUjQknvGRX+TI=; b=ouRJUa14BJJc8qmg5
	jb5g7RXMA3PZxXMZQEaCsWZBF6pf1wpxUEcl/cyYgdqcy2qtJ9C8CCOTSQZ4qInW
	0ps3e9UIQsSgtF7s18lgQieQjcOKDuYXYTlgen8gYVqYki97sotgIyO7GZdbvDIi
	HLSbohg6POqGmhkiDMWXybPmxY5gP63b0F2mXgrVYEExDCC9Wx2uI7msxZ38zB+m
	aB4T7uDo5rrP40ElMOUEM4/RWGf6aWZot+dS/sAh24KIRdXpHNO4/rDLL8jlDgAb
	fmkS+EovbXfl95fugMPNguldKW8XcWjQTpm4KwX1hQkVrrTrzCVqsV+aBd0DTISM
	xMGUQ==
X-ME-Sender: <xms:l0Faar-CVXBOwhjRGZG9zRcLiv7jFlDy9z-5qCs40R8O57oAdwKjTw>
    <xme:l0FaausFIzVQ7OjO7HQPVjBUZN21t44asLDFabeycddKz3csouZ90dyPTcxPLyS2t
    y4EtKAJKHWOaOi49z0sObGnFCTCCOFCgAN7kYSYHon4RjeBqeftdHo>
X-ME-Received: <xmr:l0FaauC0yMMRp3uXS4fRHRrbHPVLbW20AzGZgfBF8CHbTabxyekXZz-JKzgTPYnnSW4PxUb5P0F4U7Yzu2X59qLhGvwha4Ns0Vy_RTCxu20z_g>
X-ME-Proxy-Cause: dmFkZTGAC8tbw7/N1pepxjObnf3zwtJXI6qC7cnBN/2TTnZAgU5a3SrgpTfMopgmqNMYdL
    ElKqndP2Z1+rwg8ILzYlYPZvDRkRWK3mMSTo7SxYTz6LfXwiUrjoPgc8Z2P+YD/YgTMaIa
    TfCjdrsSxJDfC1j8dq7nvYRCUH/BxQNa3Txqhk9J+xSDgPUmc+/Uzncnh6n4B0ugoGx6Xk
    O0MUNgIo3X3WctxHNTlAoiJCPGosTnOyFWdES/XMRH67s800oP48y9iGZitEHVeiA9sdFH
    Tw9sZq9Rc2Z4YjWX/cmHSAJDc6S/6Hh04wRf+ibbM72IBaRf/bua6YqLnX67UXkuSRuBaG
    epVCjNspP5QpZshwJiVbnRHDzWB+3e1776XNPYbd32pesUYlgXThHkFfV44TNl12W9ytVK
    LdaPmDUzRKAhcyXInry37cJ11lID4b4zZaCzXfK8rIHQozuwYu+YJnPdNTj7RC2ThZ3bJV
    ieQcDYZhdDWrkvaE5LT43IIv6eRj4ZqmSUf0zVeXIJB9dAEIYQiQ9SMX5dtKEKoxT+rjTM
    3+md/pqj8pwWKZ931z6am5zxs5mD7gBzJ90hgSkuSIhu5dTxklab7LljzdFnBEOPzDKSBJ
    knMHsdAMkjjowLygepnHzDqeWUqqDVCuq602Ew7/MS8qerNsxeH1tQ/2Fu5A
X-ME-Proxy: <xmx:l0FaamVRloaqOErvUfdi8cGos5gduxrbjDUJOtDWYjYbOiniqEFZkg>
    <xmx:l0FaasCbfqc3i8cGrtfVpf5nnuSsywRkpOG2xVk9_dVLehS3RfWhGA>
    <xmx:l0Faap8ebXR3f9pQpiIs8TuY_f-RnRek9wge0Jyy610B5v15wRrUzQ>
    <xmx:l0FaajH3d0BjsoDpe2HeioOPD5PQHn_pI2_p8ayUVGnpHT4WgIoJpA>
    <xmx:l0FaakoZgiecK1ejaAgi-xzuYYvsMeWauizYNMWsqiwuZBxcqd1wATjx>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 10:52:03 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v2 2/2] builtin/history: sign rewritten commits
Date: Fri, 17 Jul 2026 14:51:42 +0000
Message-ID: <20260717145142.39478-3-git@5ouma.me>
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
commits ignore `commit.gpgSign` and cannot be signed on demand.

Read the signing configuration before parsing options so that it
establishes the default and later `-S`/`--gpg-sign` or `--no-gpg-sign`
options override it. Pass the selected key through direct rewrites and
the replay machinery.

Sign every newly created commit, including both halves of a split and
replayed descendants. Dropping the tip creates no replacement commit,
so there is nothing to sign. As with `rebase --gpg-sign`, the signature
records the attestation of the current committer to the rewritten
commit while retaining the original author identity; it does not claim
authorship of commits written by somebody else.

Document the behavior and add GPG-gated coverage for configuration,
command-line overrides, last-option-wins precedence, replayed
descendants, split commits, an explicit signing key, and the
no-new-commit drop case.

Signed-off-by: Souma <git@5ouma.me>
---
 Documentation/git-history.adoc | 16 +++++--
 builtin/history.c              | 84 ++++++++++++++++++++++++++--------
 t/t3451-history-reword.sh      | 63 +++++++++++++++++++++++++
 t/t3452-history-split.sh       | 44 ++++++++++++++++++
 t/t3453-history-fixup.sh       | 39 ++++++++++++++++
 t/t3454-history-drop.sh        | 50 ++++++++++++++++++++
 6 files changed, 272 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 28b477cd37..8345cced4c 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,10 +8,10 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]
-git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
-git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
-git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
+git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
+git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
+git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
+git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -125,6 +125,14 @@ OPTIONS
 `--reedit-message`::
 	Open an editor to modify the target commit's message.
 
+`-S[<key-id>]`::
+`--gpg-sign[=<key-id>]`::
+`--no-gpg-sign`::
+	GPG-sign rewritten commits. The _<key-id>_ argument is optional and
+	defaults to the committer identity; if specified, it must be stuck to
+	the option without a space. `--no-gpg-sign` is useful to countermand
+	both `commit.gpgSign` configuration and earlier `--gpg-sign`.
+
 `--empty=(drop|keep|abort)`::
 	Control what happens when a commit becomes empty as a result of the
 	fixup. This can happen in two situations:
diff --git a/builtin/history.c b/builtin/history.c
index d28c1f08bb..97e0d77013 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -27,13 +27,13 @@
 #include "wt-status.h"
 
 #define GIT_HISTORY_DROP_USAGE \
-	N_("git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]")
+	N_("git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]")
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
@@ -105,12 +105,37 @@ enum commit_tree_flags {
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
+	return git_default_config(var, value, ctx, NULL);
+}
+
+#define OPT_HISTORY_GPG_SIGN(v) {                 \
+	.type = OPTION_STRING,                    \
+	.short_name = 'S',                        \
+	.long_name = "gpg-sign",                  \
+	.value = (v),                             \
+	.argh = N_("key-id"),                     \
+	.help = N_("GPG-sign rewritten commits"), \
+	.flags = PARSE_OPT_OPTARG,                \
+	.defval = (intptr_t)"",                   \
+}
+
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
+			   const char *sign_commit,
 			   struct commit **out,
 			   enum commit_tree_flags flags)
 {
@@ -151,7 +176,7 @@ static int commit_tree_ext(struct repository *repo,
 
 	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree,
 				   parents, &rewritten_commit_oid, original_author,
-				   NULL, NULL, original_extra_headers);
+				   NULL, sign_commit, original_extra_headers);
 	if (ret < 0)
 		goto out;
 
@@ -167,6 +192,7 @@ static int commit_tree_ext(struct repository *repo,
 static int commit_tree_with_edited_message(struct repository *repo,
 					   const char *action,
 					   struct commit *original,
+					   const char *sign_commit,
 					   struct commit **out)
 {
 	struct object_id parent_tree_oid;
@@ -188,7 +214,8 @@ static int commit_tree_with_edited_message(struct repository *repo,
 	}
 
 	return commit_tree_ext(repo, action, original, original->parents,
-			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
+			       &parent_tree_oid, tree_oid, sign_commit, out,
+			       COMMIT_TREE_EDIT_MESSAGE);
 }
 
 enum ref_action {
@@ -344,12 +371,14 @@ static int compute_pending_ref_updates(struct rev_info *revs,
 				       enum ref_action action,
 				       struct commit *original,
 				       struct commit *rewritten,
+				       const char *sign_commit,
 				       enum replay_empty_commit_action empty,
 				       struct replay_result *result)
 {
 	const struct name_decoration *decoration;
 	struct replay_revisions_options opts = {
 		.empty = empty,
+		.sign_commit = sign_commit,
 	};
 	char hex[GIT_MAX_HEXSZ + 1];
 	bool detached_head;
@@ -454,13 +483,14 @@ static int handle_reference_updates(struct rev_info *revs,
 				    struct commit *rewritten,
 				    const char *reflog_msg,
 				    int dry_run,
+				    const char *sign_commit,
 				    enum replay_empty_commit_action empty)
 {
 	struct replay_result result = { 0 };
 	int ret;
 
 	ret = compute_pending_ref_updates(revs, action, original, rewritten,
-					  empty, &result);
+					  sign_commit, empty, &result);
 	if (ret)
 		goto out;
 
@@ -522,6 +552,7 @@ static int cmd_history_fixup(int argc,
 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
 	enum ref_action action = REF_ACTION_DEFAULT;
 	enum commit_tree_flags flags = 0;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -535,6 +566,7 @@ static int cmd_history_fixup(int argc,
 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct merge_result merge_result = { 0 };
@@ -546,12 +578,12 @@ static int cmd_history_fixup(int argc,
 	bool skip_commit = false;
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -676,7 +708,7 @@ static int cmd_history_fixup(int argc,
 	if (!skip_commit) {
 		ret = commit_tree_ext(repo, "fixup", original, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
-				      &rewritten, flags);
+				      sign_commit, &rewritten, flags);
 		if (ret < 0) {
 			ret = error(_("failed writing fixed-up commit"));
 			goto out;
@@ -686,7 +718,7 @@ static int cmd_history_fixup(int argc,
 	strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, empty);
+				       reflog_msg.buf, dry_run, sign_commit, empty);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -711,6 +743,7 @@ static int cmd_history_reword(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -718,6 +751,7 @@ static int cmd_history_reword(int argc,
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -725,12 +759,12 @@ static int cmd_history_reword(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -745,7 +779,8 @@ static int cmd_history_reword(int argc,
 	if (ret)
 		goto out;
 
-	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
+	ret = commit_tree_with_edited_message(repo, "reworded", original,
+					      sign_commit, &rewritten);
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
 		goto out;
@@ -754,7 +789,8 @@ static int cmd_history_reword(int argc,
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
+				       reflog_msg.buf, dry_run, sign_commit,
+				       REPLAY_EMPTY_COMMIT_ABORT);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -816,6 +852,7 @@ static int write_ondisk_index(struct repository *repo,
 static int split_commit(struct repository *repo,
 			struct commit *original,
 			struct pathspec *pathspec,
+			const char *sign_commit,
 			struct commit **out)
 {
 	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
@@ -893,7 +930,8 @@ static int split_commit(struct repository *repo,
 	 * that shall be diffed against is the parent of the original commit.
 	 */
 	ret = commit_tree_ext(repo, "split-out", original, original->parents, &parent_tree_oid,
-			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
+			      &split_tree->object.oid, sign_commit, &first_commit,
+			      COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
 		goto out;
@@ -910,7 +948,8 @@ static int split_commit(struct repository *repo,
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
 	ret = commit_tree_ext(repo, "split-out", original, parents, old_tree_oid,
-			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
+			      new_tree_oid, sign_commit, &second_commit,
+			      COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
 		goto out;
@@ -938,6 +977,7 @@ static int cmd_history_split(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -945,6 +985,7 @@ static int cmd_history_split(int argc,
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct commit *original, *rewritten = NULL;
@@ -953,12 +994,12 @@ static int cmd_history_split(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc < 1) {
 		ret = error(_("command expects a committish"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -984,14 +1025,15 @@ static int cmd_history_split(int argc,
 		goto out;
 	}
 
-	ret = split_commit(repo, original, &pathspec, &rewritten);
+	ret = split_commit(repo, original, &pathspec, sign_commit, &rewritten);
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
@@ -1081,6 +1123,7 @@ static int cmd_history_drop(int argc,
 	};
 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -1091,6 +1134,7 @@ static int cmd_history_drop(int argc,
 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
 			       N_("how to handle descendants that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -1101,12 +1145,12 @@ static int cmd_history_drop(int argc,
 	bool head_moves = false;
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 	if (argc != 1) {
 		ret = error(_("command expects a single revision"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -1134,7 +1178,7 @@ static int cmd_history_drop(int argc,
 	rewritten = original->parents->item;
 
 	ret = compute_pending_ref_updates(&revs, action, original, rewritten,
-					  empty, &result);
+					  sign_commit, empty, &result);
 	if (ret) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index de7b357685..6dbe2143d3 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -4,6 +4,7 @@ test_description='tests for git-history reword subcommand'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 reword_with_message () {
 	cat >message &&
@@ -26,6 +27,37 @@ expect_log () {
 	test_cmp expect actual
 }
 
+test_reword_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "reword $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+
+			git config commit.gpgsign $conf &&
+			reword_with_message $* HEAD~ <<-EOF &&
+			second reworded
+			EOF
+
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'can reword tip of a branch' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -77,6 +109,37 @@ test_expect_success 'can reword commit in the middle' '
 	)
 '
 
+test_reword_gpg_sign ! false
+test_reword_gpg_sign   true
+test_reword_gpg_sign   false --gpg-sign
+test_reword_gpg_sign ! true  --no-gpg-sign
+test_reword_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_reword_gpg_sign   false --no-gpg-sign --gpg-sign
+
+test_expect_success GPG 'reword uses an explicit signing key for rewritten history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		reword_with_message -SB7227189 HEAD~ <<-EOF &&
+		second reworded
+		EOF
+
+		git verify-commit HEAD~ &&
+		git verify-commit HEAD &&
+		git log -2 --format=%GK >actual &&
+		cat >expect <<-\EOF &&
+		65A0EEA02E30CAD7
+		65A0EEA02E30CAD7
+		EOF
+		test_cmp expect actual
+	)
+'
+
 test_expect_success 'can reword commit in the middle even on detached head' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t3452-history-split.sh b/t/t3452-history-split.sh
index 8ed0cebb50..e96f492cc6 100755
--- a/t/t3452-history-split.sh
+++ b/t/t3452-history-split.sh
@@ -4,6 +4,7 @@ test_description='tests for git-history split subcommand'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 # The fake editor takes multiple arguments, each of which represents a commit
 # message. Subsequent invocations of the editor will then yield those messages
@@ -36,6 +37,42 @@ expect_tree_entries () {
 	test_cmp expect actual
 }
 
+test_split_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "split $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit initial &&
+			touch bar foo &&
+			git add . &&
+			git commit -m split-me &&
+			test_commit tip &&
+
+			git config commit.gpgsign $conf &&
+			set_fake_editor 'first' 'second' &&
+			git history split $* HEAD~ <<-EOF &&
+			y
+			n
+			EOF
+
+			$must_fail git verify-commit HEAD~2 &&
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'refuses to work with merge commits' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -141,6 +178,13 @@ test_expect_success 'can split up tip commit' '
 	)
 '
 
+test_split_gpg_sign ! false
+test_split_gpg_sign   true
+test_split_gpg_sign   false --gpg-sign
+test_split_gpg_sign ! true  --no-gpg-sign
+test_split_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_split_gpg_sign   false --no-gpg-sign --gpg-sign
+
 test_expect_success 'can split up root commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
diff --git a/t/t3453-history-fixup.sh b/t/t3453-history-fixup.sh
index 868298e248..cd20a23115 100755
--- a/t/t3453-history-fixup.sh
+++ b/t/t3453-history-fixup.sh
@@ -3,6 +3,7 @@
 test_description='tests for git-history fixup subcommand'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 fixup_with_message () {
 	cat >message &&
@@ -21,6 +22,37 @@ expect_changes () {
 	test_cmp expect actual
 }
 
+test_fixup_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "fixup $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+
+			git config commit.gpgsign $conf &&
+			echo fix >>second.t &&
+			git add second.t &&
+			git history fixup $* HEAD~ &&
+
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'errors on missing commit argument' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -229,6 +261,13 @@ test_expect_success 'preserves commit message and authorship' '
 	)
 '
 
+test_fixup_gpg_sign ! false
+test_fixup_gpg_sign   true
+test_fixup_gpg_sign   false --gpg-sign
+test_fixup_gpg_sign ! true  --no-gpg-sign
+test_fixup_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_fixup_gpg_sign   false --no-gpg-sign --gpg-sign
+
 test_expect_success 'updates all descendant branches by default' '
 	test_when_finished "rm -rf repo" &&
 	git init repo --initial-branch=main &&
diff --git a/t/t3454-history-drop.sh b/t/t3454-history-drop.sh
index 68a86d1e37..5b21078a7e 100755
--- a/t/t3454-history-drop.sh
+++ b/t/t3454-history-drop.sh
@@ -4,6 +4,7 @@ test_description='tests for git-history drop subcommand'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-log-graph.sh"
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 expect_graph () {
 	cat >expect &&
@@ -16,6 +17,34 @@ expect_log () {
 	test_cmp expect actual
 }
 
+test_drop_gpg_sign () {
+	must_fail= will=will
+	if test "x$1" = "x!"
+	then
+		must_fail=test_must_fail
+		will="will not"
+		shift
+	fi
+	conf=$1
+	shift
+
+	test_expect_success GPG "drop $* with commit.gpgsign=$conf $will sign replayed descendants" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+
+			git config commit.gpgsign $conf &&
+			git history drop $* HEAD~ &&
+
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
 test_expect_success 'errors on missing commit argument' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
@@ -88,6 +117,27 @@ test_expect_success 'drops a commit in the middle and replays descendants' '
 	)
 '
 
+test_drop_gpg_sign ! false
+test_drop_gpg_sign   true
+test_drop_gpg_sign   false --gpg-sign
+test_drop_gpg_sign ! true  --no-gpg-sign
+test_drop_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_drop_gpg_sign   false --no-gpg-sign --gpg-sign
+
+test_expect_success GPG 'drop has no commit to sign when dropping the tip' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+
+		git history drop --gpg-sign HEAD &&
+
+		test_must_fail git verify-commit HEAD
+	)
+'
+
 test_expect_success 'drops the HEAD commit' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
-- 
2.55.0

