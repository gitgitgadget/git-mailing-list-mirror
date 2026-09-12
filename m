Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3D247AF43
	for <git@vger.kernel.org>; Sat, 12 Sep 2026 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789228863; cv=none; b=fX2cxtzfUsTDgjqsxQgG0yOoNpxUjb6kWLltPPrBxoa5BDtKNw+gYo13p7JnAbNO4i4wL6RxPBPrdxeH5S8b52Cp8HBHBRae5ouxOCLwsoopwjxuNuMajv95KODYpD9n5n6cdlCOBWJFjafWP7N4KhZiI4SscZIdNeRVJjUH9VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789228863; c=relaxed/simple;
	bh=SiEhp4zTVFZhGJDvwpMeGlFCVhx9xVGIm/77YfRk5ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tCBF+Z2OLjvwr4wac/Sv1qq4a44VYTRBPGvEqbfFQaCcM272cCFpAWQBCf8RiKy5ECENW412L4TWLgmHC1ocMKC2q9vSvgx2In3ohnQ7c+gaSQ0R1M4Ye21V8vc/RJ/msaMO+UAnne53nRRkqY6QCn+MJOHF//q9D22IT5U3lGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=hQVl526P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kpFh93R6; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="hQVl526P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kpFh93R6"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE07014000D0;
	Sat, 12 Sep 2026 12:01:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 12 Sep 2026 12:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1789228860; x=
	1789315260; bh=nWICjWwmbmwNLwwYdcmvgJVdu3L5iBGPP+moZB13mQk=; b=h
	QVl526PyNCo94GVUpAyoSA+jQV60LxZaWVWQC4OtWHt158fiehf/XXEDpagSNyTd
	HWiR11mBQC8vzruEKlQvr5Zi+fW5cpm3a4MJCjLqroVC2nUTV1EfKdeh99X2iItk
	8FbsJrDG6mKseDsBpfRJ7aIjCXVYrQxLvxGNjRrUFmU+UECT0e773KIAlhzUaLvB
	Y2AhqiO17wItv0D8YaTFT4ISpzowtr7fVXSbD8bKr57OGsFeB0sWdyDWXOo2U4p4
	uB3gYNtMbh7+zMDpZE6vpFjJtwjJHjD9dsyiL7JGrO+ns03cUHj8DmxJ4CfAHQ3i
	WgXdIQAX6NKTs9dLvM/HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1789228860; x=1789315260; bh=n
	WICjWwmbmwNLwwYdcmvgJVdu3L5iBGPP+moZB13mQk=; b=kpFh93R6X0DXjrlhp
	26h9CjFsgj++y6pTEkWgM0XrxGm1YF31O5nhk5EfB+qZBZuzh8ruPkPb+k2KONC7
	d349OKiiawfTtjm09vpugDjXhaSargViJILrNiKsqmCnlbAkPQNC+Zbxgs3p80DD
	qj0S/mIy0Z8xZBUQh2F/gc3g2i8Tup2NC/29f+Q9zbtxxsbUpJMdN7Pz9I64oeC5
	x5T234tvljqqoz5jgPx1w81RTC3PRevB13D7F2AQ8TONNLH0mFDAyRDge6YhjJgj
	CbkueT9nkQ+3eeDaZxNitUcNJzwoRBsHW6E/++56NyLO5ZHlXfi29rVGq7c/1BKs
	c3HnA==
X-ME-Sender: <xms:PHelapAQPxDo8joaqn50T530CgGUVvDGNymm9iB8SnJ8l35rcaikRw>
    <xme:PHelaugtqht6C9H5gxVAB_xkpoYmMR-eUQNMU8-QD9jI1GNV9UG4c3_oJgkeG13v7
    azKwsDmIl_6LsnLm3mNyy0s6IuRw3ckGErGFgqmJ7dYOCMrMWOOFTD6VQ>
X-ME-Received: <xmr:PHelapkJfpznTsDw_UBg6_moBkOcid1YMdBWdoYMrQt3LTPZO5DoCzr5ZIL1HLyGwjbAGPguQmRJSKmLR3J34_ootf_hhnhlofO43gzeLqhSDA>
X-ME-Proxy-Cause: dmFkZTEJzP3TrDj/EJZpEAQrG75aOaV9GM771ArQfABipHARsdFm0SHFh4/m+QKViygr2S
    2TjZ+j5UrVPSzOUMlDBf/nTGDzW6hkJ7V0NG9N5F1zk0/ktg+PZ61GmwJEyiUyrRcg0sr9
    fnxvk8Wu27LW35DrCgblsNn23raH4HZeP34IVmCoi2356wpSg0wYNq8tJoKbClnQeHq6Wu
    8TsU2OM0eNQLEYAa3cri9W8/RGzIS8RAhXrD51i7z97WE1Vv+RjFcUG2GUwGCu2ZYN3Tbj
    J5+pBAiRO8JX3pi7aHyHlbVy8zaNrdmBA2ezMGKVuxKf1mZIpXfKstvXYNtCSd5vVG2nKC
    cPJyV+RXlU4TvLASPZAIPVg71B7s0YHEXo72GIoPvgLwcMNyEwPtOZJN3p7ZfdNSh+KD2N
    kLtFNZUziK4GyESAryoYDl4yGlq/k8jJAZt0CdfvkOi77bsoluAwrMZx8J+PPgS8F6Cka4
    Q/dwvwzfkAe7e6EfwZTLz8mEJ/8zkHxK37kQEgnO+UAcRyHxsCK+axLQMGamP+uLkHmZ83
    BAYobID/o0DVvhkl8O5S3C5xdoNCvSV3kD+NN5uj+aRXnSovgyJp6mP66Py89VCMMS9VTU
    JoztRKdvFkteTyBgXzhK7TuK/Njm+USdH1ToBHv4ougxPbEqxyOcgDgdS9CQ
X-ME-Proxy: <xmx:PHelaiqadT6429z97jlahxsdH8iU11dCXEsNEciUdbuHz2JaNX1h_g>
    <xmx:PHelaqGVjXjeiiFcUnpeqF1M61B_52FHG9vO3Tzz5NPMDAzsiPHwmA>
    <xmx:PHelamypuWXI9Avzp5-3NGjwB57pjPJzLKqHB7JqZOAul6G_2iaXOg>
    <xmx:PHelano-v33bw_t3fV8gTDjKuHiwHE8XFr7ltfUaOsNF58vGfgxUzw>
    <xmx:PHelaoM-xe73ZpvoFiU_Ed8WTCUSLk6YHC-TSN8oygrz_VBnNufJ8hy1>
Feedback-ID: i4b264863:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Sep 2026 12:00:59 -0400 (EDT)
From: Souma <git@5ouma.me>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Souma <git@5ouma.me>
Subject: [PATCH v3 2/2] history: sign rewritten commits
Date: Sun, 13 Sep 2026 01:00:45 +0900
Message-ID: <20260912160045.36064-3-git@5ouma.me>
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

Add --gpg-sign/--no-gpg-sign support to git history and honor
commit.gpgSign when creating replacement commits. Thread the selected
signing key through direct rewrites and replayed descendants while
preserving the original author identity.

Cover configuration, command-line precedence, explicit keys, split commits,
and replayed descendants with GPG-gated tests.

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
index 000155ad9c..07b7c73c89 100644
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

