Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD169334C3D
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 13:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791034894; cv=none; b=kHxUrSkZKjR3qCZxwEbTgE/kenWpExWrhufC5G3JpBCdqxXrre+QV9HSeab/kwPZF0+LUDKTDYPX0kDcCRO32yt/Cmx76eA6qn+WJlHNxx4RKbjN8yJ2GE9YM+5eLQE0dsK+KYrW2Z2OSzmPHLVRkhh0pwOtrqoavkNNfmTssNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791034894; c=relaxed/simple;
	bh=vabNxdbhwRTumPYqKYZp7l536IzRPdgtCbK5Cj0Rj0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UpkTZSJ1TDidhWwcy9wWP42nt1p8JyNCPRyayYATbybL71IZ2Y13ELh4aaeIu+QH4fofHD8FcfmlEA6w8v1A/1MCbLF1fY07D9rr7vWmMNzUyHqDTcyoY8kKLVtpZZk8l2zTKVCGFCM9YbH1yY6KcK2+1RzmOnxUNQ4nEn226AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=Z4ubbfE8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tNWNvS4o; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="Z4ubbfE8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tNWNvS4o"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A115D1400037
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 09:41:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sat, 03 Oct 2026 09:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1791034890; x=
	1791121290; bh=SH+A9GZV9HqWvJUx7WqrT7qK5p8pPXdAjlDViY6drig=; b=Z
	4ubbfE8t8wglPmVdcfEyzUJTjhU2mBeLG5wlR3TTTZjbGmBiSHrLPt9Uj6Cd4Lr4
	Q5g27SgPYhv67H7DAWcpjNRSb2bAoZZM9IuZJ0tX+S1y7zb7lXX34CBKJQ4PXLHt
	ORR9MMiCPFNChLRRKfrq5gsEU/jGcen7Dif0XXrQKtnlAYFWyJth216Ij4YJ1DRy
	yIsIptHlAgMQ2/eewGAKbT8ZNQfc/4sGLMBXr6UjoqfWEmzIwpz/0E2+aoC/AF3k
	cJt3gT1ig1M3WF7MTwhGTkRMzzZpPnnaLUIDJ7uyVPlQ4sXzJ9xzy9SnlEuU5q5r
	u3CjmjQ60coYX3NZALdfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1791034890; x=1791121290; bh=S
	H+A9GZV9HqWvJUx7WqrT7qK5p8pPXdAjlDViY6drig=; b=tNWNvS4ohNpsQ5shI
	aeZNKnXgB9XDVaZ94wAs68veH74+vFbGinZ2e56CL9JCSrydXyTv4sThDvpZPLaq
	tQ0YSpeF8QnwhfxcpJBBvBDE/cOqJPTQBtPyJMPMiDJVTt0Dwa1WcIsSS6dI/htB
	04UrqmgPJaZGF5Jr9wHpLywVR2omIZ7evPbL66ha/1r7yUfggDnG5drxUauoHP4A
	BmWnX/Qs7FeLeBUN8/AXznddI2qb64qTosUwljO9iHwmil6Ln4aEUHSUJnCtevzO
	OE9W2J53hZO0i9EOtXOgefUvF3QwKIbyaGnsTodWFNdwYXxoOiv/sVTdE90lLzjD
	UNy6Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=5ouma.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791034890; d=5ouma.me;
	mf=PGdpdEA1b3VtYS5tZT4=; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:qUNqfqi94CNpy4sMl+SMMdZ8Ljh0zPYZHZWsvCrlpKzm+tf
	9LIdgDm09o0ITg0hktE/ggJHrgFAMw5EoJofRTVXfJVfNav0JeznyuVEJNLb8sXp
	mmXgkA2dCuEuzGFckL2lVJhSIYQJrkcnYAUsjR9U83o6XCNb5KCq3bEN+iXO/rof
	xMKEzLhAT7QIKXI0Sx6MSAD/OIIdLo+Qt+/xGxTJnl6o2x4q1m0Ixv1SKakOAdFu
	fSIR5xr/SjvrH7/iU+DvYMPUMzi3Kbonok0mfi8P/ubMj+9K7pgPMoxSjmJQVTGh
	JtSEfuEwjzQN0Q0u6AjIYNfk4d+Kpk39qtj06nw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=11;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:DJrrsbzez/+HcH6NrrNLdZiDoSfvuxb+u3skeKZEWzU=:vabNxdbhwRTumPYqKYZp7l536IzRPdgtCbK5Cj0Rj0c=;
X-ME-Sender: <xms:CgbBajLe9XqOAkqK029UzT3hlWvpaZ97lyo7btWXKiZZuc__E8p2Sw>
    <xme:CgbBauJHl9UEzGfQQ7CLmdBPjaIRgBI2aX67Rjl5yBBBkgAe0Mfc0gUETeFSNOf_a
    QAwfyWXwAdau2iC_T31O0leZHKZ_dAqMqdo77Gcw_Fycxf8d9M1oRSR>
X-ME-Received: <xmr:CgbBagu1QIrdXGCLcvCjpLEh0QV-47A8n3gbbbKyP1V-kr4HlYta_rLdVl2Cl3MPia1qXwx_eJ22wqL9FGMy_3IkMRlICj6RPKfbJMWFD0M>
X-ME-Proxy-Cause: dmFkZTEOeC8kwRILiVjK/UYpCStXnnHQi/ufv/zo99gpz4aRFhpDLFRmf357u/EPpi4E91
    y2yoUIsgZ1j7/X3EppQ8948OxgwANuoJTHHdIj6Q89MciqLQV6a5EbcHM7sM1DNje9XBmT
    aEjUe25Bv17nuZEiIrli0J9OYhezIAb6fJrkNK8jwmlvDhdESEAlFc+/9npuWEkfdsZ3GO
    p0xnTc3VzHSkdQ2HPHji95s/JxRYR6ynPBk0M4JdPfpPQ+nacVBpw7XvxIjjbBJc0M6Aem
    dW2XOqCsZlkWe48ZVMM4R7fEnmEPyZvHc/Y/gGvj5JItfh1PtChTtfInHF2cwPBRXiK6B6
    vuTECgPNRNVvIfyqesmd/A53ElbQOQzwUI793154Aujgh8qcRiBfWYHI54btbTqLtBG4X3
    9X23LSzMXqhrWQa9M7Y4yH1JuKGQiX/EWNe9jztGfULZSTiQg3NVn66oOp96Ex1L5y2zJl
    JTmt0Z2hSiXv2RcW1z8uwHIKxflgHADzAYJ3RPMZqsLPMiDiFStTL9P50JMLUBWu30eAF6
    bYYbag4mGt5nhUGogX26ZuDR8MQcdk81wBkiZmeLW2bpQReHQEjKjGH8bViejQ2z0J8hGm
    ZX6y5uxPxygaeCkLvPmpzVFeO1WqYOGPARyFN+H5dAZ8w36WzLYIxoesAkVQ
X-ME-Proxy: <xmx:CgbBarQFeUlgRcNhSn4BuLvD7CI9RV2Y1N8fRnBI0meX5cTxU3F9DQ>
    <xmx:CgbBamNb2ApmPtGOvOxkB4TUReoK7k8WO-uY6FvdjgJcydqabrHelQ>
    <xmx:CgbBagYpFGgFucZyg1Z03g2zwPLTF2EQx3LPFb1vUHajoLpgHNEcyw>
    <xmx:CgbBagzv4_pET1zwQUeTSXLNeFzdNACaID-71lWhv6JcVJ5gnou8bw>
    <xmx:CgbBavWKzJ--1CugK6JiCnLICIJ8ainCFY9ZB3XANMN9hwDjub2QVXeQ>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Oct 2026 09:41:28 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v5 2/2] history: sign rewritten commits
Date: Sat,  3 Oct 2026 22:40:58 +0900
Message-ID: <20261003134058.23494-3-git@5ouma.me>
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

Add --gpg-sign/--no-gpg-sign support to git history and honor
commit.gpgSign when creating replacement commits. Thread the selected
signing key through direct rewrites and replayed descendants while
preserving the original author identity.

Load history configuration before parsing command-line options so
command-line signing options override commit.gpgSign.

Cover configuration, command-line precedence, explicit keys, split
commits, and replayed descendants with GPG-gated tests.

Signed-off-by: Souma <git@5ouma.me>
---
 Documentation/git-history.adoc | 18 +++++--
 builtin/history.c              | 96 +++++++++++++++++++++++++---------
 t/t3451-history-reword.sh      | 63 ++++++++++++++++++++++
 t/t3452-history-split.sh       | 44 ++++++++++++++++
 t/t3453-history-fixup.sh       | 39 ++++++++++++++
 t/t3454-history-drop.sh        | 50 ++++++++++++++++++
 t/t3455-history-squash.sh      | 61 +++++++++++++++++++++
 t/t9902-completion.sh          |  2 +
 8 files changed, 344 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 2e2e31f521..1fcc30150a 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,11 +8,11 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)]
-git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)]
-git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
-git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--] [<pathspec>...]
-git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>
+git history drop <commit> [--dry-run] [--update-refs=(branches|head)] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
+git history fixup <commit> [--dry-run] [--update-refs=(branches|head)] [--reedit-message] [--empty=(drop|keep|abort)] [--[no-]gpg-sign[=<key-id>]]
+git history reword <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]]
+git history split <commit> [--dry-run] [--update-refs=(branches|head)] [--[no-]gpg-sign[=<key-id>]] [--] [<pathspec>...]
+git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>
 
 DESCRIPTION
 -----------
@@ -180,6 +180,14 @@ OPTIONS
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
index 54cea3523f..43ba76f5a1 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -30,15 +30,15 @@
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
 #define GIT_HISTORY_SQUASH_USAGE \
-	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] <revision-range>")
+	N_("git history squash [--dry-run] [--update-refs=(branches|head)] [--[no-]edit] [--[no-]gpg-sign[=<key-id>]] <revision-range>")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -110,6 +110,30 @@ enum commit_tree_flags {
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
+#define OPT_HISTORY_GPG_SIGN(v) { \
+	.type = OPTION_STRING, \
+	.short_name = 'S', \
+	.long_name = "gpg-sign", \
+	.value = (v), \
+	.argh = N_("key-id"), \
+	.help = N_("GPG-sign rewritten commits"), \
+	.flags = PARSE_OPT_OPTARG, \
+	.defval = (intptr_t)"", \
+}
+
 static int commit_tree_ext(struct repository *repo,
 			   const char *action,
 			   struct commit *commit_with_message,
@@ -117,6 +141,7 @@ static int commit_tree_ext(struct repository *repo,
 			   const struct commit_list *parents,
 			   const struct object_id *old_tree,
 			   const struct object_id *new_tree,
+			   const char *sign_commit,
 			   struct commit **out,
 			   enum commit_tree_flags flags)
 {
@@ -160,7 +185,7 @@ static int commit_tree_ext(struct repository *repo,
 
 	ret = commit_tree_extended(commit_message.buf, commit_message.len, new_tree,
 				   parents, &rewritten_commit_oid, original_author,
-				   NULL, NULL, original_extra_headers);
+				   NULL, sign_commit, original_extra_headers);
 	if (ret < 0)
 		goto out;
 
@@ -196,6 +221,7 @@ static int first_parent_tree_oid(struct repository *repo,
 static int commit_tree_with_edited_message(struct repository *repo,
 					   const char *action,
 					   struct commit *original,
+					   const char *sign_commit,
 					   struct commit **out)
 {
 	struct object_id parent_tree_oid;
@@ -207,7 +233,8 @@ static int commit_tree_with_edited_message(struct repository *repo,
 		return -1;
 
 	return commit_tree_ext(repo, action, original, NULL, original->parents,
-			       &parent_tree_oid, tree_oid, out, COMMIT_TREE_EDIT_MESSAGE);
+			       &parent_tree_oid, tree_oid, sign_commit, out,
+			       COMMIT_TREE_EDIT_MESSAGE);
 }
 
 enum ref_action {
@@ -363,12 +390,14 @@ static int compute_pending_ref_updates(struct rev_info *revs,
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
@@ -473,13 +502,14 @@ static int handle_reference_updates(struct rev_info *revs,
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
 
@@ -533,6 +563,7 @@ static int cmd_history_fixup(int argc,
 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
 	enum ref_action action = REF_ACTION_DEFAULT;
 	enum commit_tree_flags flags = 0;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -546,6 +577,7 @@ static int cmd_history_fixup(int argc,
 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
 			       N_("how to handle commits that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct merge_result merge_result = { 0 };
@@ -557,12 +589,12 @@ static int cmd_history_fixup(int argc,
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
@@ -687,7 +719,7 @@ static int cmd_history_fixup(int argc,
 	if (!skip_commit) {
 		ret = commit_tree_ext(repo, "fixup", original, NULL, original->parents,
 				      &original_tree->object.oid, &merge_result.tree->object.oid,
-				      &rewritten, flags);
+				      sign_commit, &rewritten, flags);
 		if (ret < 0) {
 			ret = error(_("failed writing fixed-up commit"));
 			goto out;
@@ -697,7 +729,7 @@ static int cmd_history_fixup(int argc,
 	strbuf_addf(&reflog_msg, "fixup: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, empty);
+				       reflog_msg.buf, dry_run, sign_commit, empty);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -722,6 +754,7 @@ static int cmd_history_reword(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -729,6 +762,7 @@ static int cmd_history_reword(int argc,
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -736,12 +770,12 @@ static int cmd_history_reword(int argc,
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
@@ -756,7 +790,8 @@ static int cmd_history_reword(int argc,
 	if (ret)
 		goto out;
 
-	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
+	ret = commit_tree_with_edited_message(repo, "reworded", original,
+					      sign_commit, &rewritten);
 	if (ret < 0) {
 		ret = error(_("failed writing reworded commit"));
 		goto out;
@@ -765,7 +800,8 @@ static int cmd_history_reword(int argc,
 	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
 
 	ret = handle_reference_updates(&revs, action, original, rewritten,
-				       reflog_msg.buf, dry_run, REPLAY_EMPTY_COMMIT_ABORT);
+				       reflog_msg.buf, dry_run, sign_commit,
+				       REPLAY_EMPTY_COMMIT_ABORT);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
 		goto out;
@@ -831,6 +867,7 @@ static int write_ondisk_index(struct repository *repo,
 static int split_commit(struct repository *repo,
 			struct commit *original,
 			struct pathspec *pathspec,
+			const char *sign_commit,
 			struct commit **out)
 {
 	struct interactive_options interactive_opts = INTERACTIVE_OPTIONS_INIT;
@@ -900,8 +937,10 @@ static int split_commit(struct repository *repo,
 	 * The first commit is constructed from the split-out tree. The base
 	 * that shall be diffed against is the parent of the original commit.
 	 */
-	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents, &parent_tree_oid,
-			      &split_tree->object.oid, &first_commit, COMMIT_TREE_EDIT_MESSAGE);
+	ret = commit_tree_ext(repo, "split-out", original, NULL, original->parents,
+			      &parent_tree_oid, &split_tree->object.oid, sign_commit,
+			      &first_commit,
+			      COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing first commit"));
 		goto out;
@@ -918,7 +957,8 @@ static int split_commit(struct repository *repo,
 	new_tree_oid = &repo_get_commit_tree(repo, original)->object.oid;
 
 	ret = commit_tree_ext(repo, "split-out", original, NULL, parents, old_tree_oid,
-			      new_tree_oid, &second_commit, COMMIT_TREE_EDIT_MESSAGE);
+			      new_tree_oid, sign_commit, &second_commit,
+			      COMMIT_TREE_EDIT_MESSAGE);
 	if (ret < 0) {
 		ret = error(_("failed writing second commit"));
 		goto out;
@@ -946,6 +986,7 @@ static int cmd_history_split(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -953,6 +994,7 @@ static int cmd_history_split(int argc,
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct commit *original, *rewritten = NULL;
@@ -961,12 +1003,12 @@ static int cmd_history_split(int argc,
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
@@ -992,14 +1034,15 @@ static int cmd_history_split(int argc,
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
@@ -1579,6 +1622,7 @@ static int cmd_history_squash(int argc,
 		NULL,
 	};
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	int edit = 1;
 	struct option options[] = {
@@ -1589,6 +1633,7 @@ static int cmd_history_squash(int argc,
 			 N_("perform a dry-run without updating any refs")),
 		OPT_BOOL('e', "edit", &edit,
 			 N_("edit the commit message")),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -1598,13 +1643,13 @@ static int cmd_history_squash(int argc,
 	struct rev_info revs = { 0 };
 	int ret;
 
+	repo_config(repo, history_config, &sign_commit);
 	argc = parse_options(argc, argv, prefix, options, usage,
 			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_KEEP_ARGV0);
 	if (argc < 2) {
 		ret = error(_("command expects a revision range"));
 		goto out;
 	}
-	repo_config(repo, git_default_config, NULL);
 
 	if (action == REF_ACTION_DEFAULT)
 		action = REF_ACTION_BRANCHES;
@@ -1629,7 +1674,7 @@ static int cmd_history_squash(int argc,
 
 	ret = commit_tree_ext(repo, "squash", oldest, message_template,
 			      oldest->parents, base_tree_oid, tip_tree_oid,
-			      &rewritten,
+			      sign_commit, &rewritten,
 			      edit ? COMMIT_TREE_EDIT_MESSAGE : 0);
 	if (ret < 0) {
 		ret = error(_("failed writing squashed commit"));
@@ -1638,6 +1683,7 @@ static int cmd_history_squash(int argc,
 
 	ret = handle_reference_updates(&revs, action, tip, rewritten,
 				       reflog_msg.buf, dry_run,
+				       sign_commit,
 				       REPLAY_EMPTY_COMMIT_ABORT);
 	if (ret < 0) {
 		ret = error(_("failed replaying descendants"));
@@ -1728,6 +1774,7 @@ static int cmd_history_drop(int argc,
 	};
 	enum replay_empty_commit_action empty = REPLAY_EMPTY_COMMIT_DROP;
 	enum ref_action action = REF_ACTION_DEFAULT;
+	const char *sign_commit = NULL;
 	int dry_run = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "update-refs", &action, "(branches|head)",
@@ -1738,6 +1785,7 @@ static int cmd_history_drop(int argc,
 		OPT_CALLBACK_F(0, "empty", &empty, "(drop|keep|abort)",
 			       N_("how to handle descendants that become empty"),
 			       PARSE_OPT_NONEG, parse_opt_empty),
+		OPT_HISTORY_GPG_SIGN(&sign_commit),
 		OPT_END(),
 	};
 	struct strbuf reflog_msg = STRBUF_INIT;
@@ -1748,12 +1796,12 @@ static int cmd_history_drop(int argc,
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
@@ -1781,7 +1829,7 @@ static int cmd_history_drop(int argc,
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
diff --git a/t/t3455-history-squash.sh b/t/t3455-history-squash.sh
index d21e9d9fc4..237afdfa26 100755
--- a/t/t3455-history-squash.sh
+++ b/t/t3455-history-squash.sh
@@ -3,6 +3,7 @@
 test_description='tests for git-history squash subcommand'
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
 
 stage_file () {
 	printf "%s\n" "$1" >file &&
@@ -40,6 +41,66 @@ check_commit_author () {
 	test_cmp expect actual
 }
 
+test_squash_gpg_sign () {
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
+	test_expect_success GPG "squash $* with commit.gpgsign=$conf $will sign rewritten history" "
+		test_when_finished 'rm -rf repo' &&
+		git init repo &&
+		(
+			cd repo &&
+			test_commit first &&
+			test_commit second &&
+			test_commit third &&
+			test_commit fourth &&
+
+			git config commit.gpgsign $conf &&
+			git history squash --no-edit $* HEAD~3..HEAD~1 &&
+
+			$must_fail git verify-commit HEAD~ &&
+			$must_fail git verify-commit HEAD
+		)
+	"
+}
+
+test_squash_gpg_sign ! false
+test_squash_gpg_sign   true
+test_squash_gpg_sign   false --gpg-sign
+test_squash_gpg_sign ! true  --no-gpg-sign
+test_squash_gpg_sign ! true  --gpg-sign --no-gpg-sign
+test_squash_gpg_sign   false --no-gpg-sign --gpg-sign
+
+test_expect_success GPG 'squash uses an explicit signing key for rewritten history' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		test_commit fourth &&
+
+		git history squash --no-edit -SB7227189 HEAD~3..HEAD~1 &&
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
 test_expect_success 'setup linear history touching two files' '
 	test_commit base file a start &&
 	GIT_AUTHOR_NAME=One GIT_AUTHOR_EMAIL=one@example.com \
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 978c42c629..f6de74054a 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -3236,6 +3236,8 @@ test_expect_success 'git history subcommand options' '
 	test_completion "git history split main --" <<-\EOF &&
 	--update-refs=Z
 	--dry-run Z
+	--gpg-sign Z
+	--no-... Z
 	--no-dry-run Z
 	EOF
 	test_completion "git history fixup --upd" "--update-refs=" &&
-- 
2.56.0

