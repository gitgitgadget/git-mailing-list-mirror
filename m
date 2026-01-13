Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E2838A29F
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298107; cv=none; b=Iqb9aXZD4gRB7xHE932k7k7P0J6CqUrneo4CVOBOLy0Zv9R5JGxoan6IiVR2mkDFkAeBQq8Eov+XQ3cdwBKJU5qe00B+Vf7PKP5s4chIUEAFyfpKvFrSs8Z6qlXVNn4dgRm/z9QnCaw4BL5EsXXCFTaVrfVCL1Dq9HIWGB5F8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298107; c=relaxed/simple;
	bh=OjZSqsvb5siiTPnDNq+znwNWHT67PiEA1E3nO5a+BfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KF4zP6v/6T4t/3J+h230CSYGw6fBZSy9qbdsjuu0jGkWTf0nkJMDi7JB1JGvuftdVbHCZFwf+m1NdXJX+OMyMYcHOj602PRa7/CP0g68QA+yaw8t8YhVI1Q/Etl6q6fiNNkr/5vs8zsT7nmp0QM8EFbTkFzm1OJy1ErNStXX79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A6QVgRW3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S64J+YRZ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A6QVgRW3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S64J+YRZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31F491400170;
	Tue, 13 Jan 2026 04:55:01 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 13 Jan 2026 04:55:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768298101;
	 x=1768384501; bh=TkS4F6m3/7JncwO8oWEqcDfv/UMOjn3kONzMYd6xWbU=; b=
	A6QVgRW3NTu/uG05eqYTbUm1vXbxTqzFhTTvY0WQW76XgymruyiIeC0YUbxPQB7V
	meBI2MrtOsu1hOWrkPqt2Ysmv5wceNj2riAAeNC1m8oqPNfoiByBf9mRuzBGzXzO
	GQYyLva+3gQR07vLRcfEtZ1B1yPpnKeqPZfmWYBqgLs88inZY5gO8r1lxqVzwe72
	Z2snAA4+RXJ6os1+ysimSk6d+mF6UCownWLmSCmRY1zSjEcqt+D2+wTil3VByUHs
	AlsrSr6ont9Il8Z8F45kY3ZbRYAxaDT3sCRscuvll9qQgzBBr7YsBKbyuLpUmpDp
	LNlICkRHgMAEoZNZfDTj1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768298101; x=
	1768384501; bh=TkS4F6m3/7JncwO8oWEqcDfv/UMOjn3kONzMYd6xWbU=; b=S
	64J+YRZ2DQpClc02HqmMBW9/w8B6qNInM5x7FcFI+EkjKpYiLmvJPMux/XN4RcWJ
	IAWfttEaZhT9Z3EfUkTLjs4dhjod6PYDwuWcVhnWPRYRaoC6cQ8mXMLDDHJRJMCV
	hsc4ComEG3nOgT0d/u3UBDdz0mVKNkzHCptaPFd/ZxcXt3Sp8F7ECYWFq9dIB0Qb
	NTtHjZx4mRrnkINRcUG3dmo3bD/Wpf+3bmOXSPnip0Uuefh9uB4xBzsPDzKDjy0y
	OEpUcL73SC4MrTrjuKgWbCx50td7Dt7z+2Fyepjk88A/pnuAXboEJ+k7FFciWsG8
	OzBWgUV8laW7lvaECNYLg==
X-ME-Sender: <xms:dRZmaWnO14xgSFCN1f1YFfjxq2zErEEpvGlk_s10bB4w-zMBAFGpJw>
    <xme:dRZmaZqjUu9BqUgJuRMAXIeOAfFCqZW-VS3w8cV5kXxTchWTDFcNPT68wJutGi1Qd
    jujOjstscHayw6_YUzJy7DpgY8zroJVhWE1lyBQaeXvYY0hfrZqAA>
X-ME-Received: <xmr:dRZmaQA-dUuLN_tgIrBNCAlKA789nDwl3gFvhkWeos0VsILRsTvlYXI0hNs_Jz9mRwiJ1AUkZCK3l75MKR_VLo3gYxi1fBX35BbHxZ8enQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrd
    hfrhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthho
    pehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknh
    hosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dRZmaUGjTdFH9OqkwyYE-Ln4fSK1gee3sn9LX_tlkofPXT_NTmZb9g>
    <xmx:dRZmaS1_MQOyOYFs7RW35ciHhZOdAw_YFMDuvTfpevlXoSGkxvzwyw>
    <xmx:dRZmadNl0EJcW95qWCqKr8wo_soVi_7gTELlq9RMH_T-3raDwUK-Lg>
    <xmx:dRZmaab6U1CYF5Tuqz2T-bJ-v-s-5ccHrj9YTL1TA3gip7VUK2pFOw>
    <xmx:dRZmaRl1eF77gxqT5adP3bCSsEFolgU4iW9Sy3aBtGCIe78MBt2sI5O8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 04:54:59 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 54498da0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 09:54:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Jan 2026 10:54:39 +0100
Subject: [PATCH v11 8/8] builtin/history: implement "reword" subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im>
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
In-Reply-To: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
X-Mailer: b4 0.14.3

Implement a new "reword" subcommand for git-history(1). This subcommand
is similar to the user performing an interactive rebase with a single
commit changed to use the "reword" instruction.

The "reword" subcommand is built on top of the replay subsystem
instead of the sequencer. This leads to some major differences compared
to git-rebase(1):

  - We do not check out the commit that is to be reworded and instead
    perform the operation in-memory. This has the obvious benefit of
    being significantly faster compared to git-rebase(1), but even more
    importantly it allows the user to rewrite history even if there are
    local changes in the working tree or in the index.

  - We do not execute any hooks, even though we leave some room for
    changing this in the future.

  - By default, all local branches that contain the commit will be
    rewritten. This especially helps with workflows that use stacked
    branches.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc |  20 +-
 builtin/history.c              | 415 ++++++++++++++++++++++++++++++++++++++++-
 t/meson.build                  |   1 +
 t/t3450-history.sh             |   6 +-
 t/t3451-history-reword.sh      | 391 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 823 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index 68c35f36b9..154e262b76 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history [<options>]
+git history reword <commit> [--ref-action=(branches|head|print)]
 
 DESCRIPTION
 -----------
@@ -50,7 +50,23 @@ first-class conflicts.
 COMMANDS
 --------
 
-No commands are supported yet.
+The following commands are available to rewrite history in different ways:
+
+`reword <commit>`::
+	Rewrite the commit message of the specified commit. All the other
+	details of this commit remain unchanged. This command will spawn an
+	editor with the current message of that commit.
+
+OPTIONS
+-------
+
+`--ref-action=(branches|head|print)`::
+	Control which references will be updated by the command, if any. With
+	`branches`, all local branches that point to commits which are
+	descendants of the original commit will be rewritten. With `head`, only
+	the current `HEAD` reference will be rewritten. With `print`, all
+	updates as they would be performed with `branches` are printed in a
+	format that can be consumed by linkgit:git-update-ref[1].
 
 GIT
 ---
diff --git a/builtin/history.c b/builtin/history.c
index f6fe32610b..8dcb9a6046 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -1,22 +1,427 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
 #include "builtin.h"
+#include "commit.h"
+#include "commit-reach.h"
+#include "config.h"
+#include "editor.h"
+#include "environment.h"
 #include "gettext.h"
+#include "hex.h"
 #include "parse-options.h"
+#include "refs.h"
+#include "replay.h"
+#include "revision.h"
+#include "sequencer.h"
+#include "strvec.h"
+#include "tree.h"
+#include "wt-status.h"
+
+#define GIT_HISTORY_REWORD_USAGE \
+	N_("git history reword <commit> [--ref-action=(branches|head|print)]")
+
+static void change_data_free(void *util, const char *str UNUSED)
+{
+	struct wt_status_change_data *d = util;
+	free(d->rename_source);
+	free(d);
+}
+
+static int fill_commit_message(struct repository *repo,
+			       const struct object_id *old_tree,
+			       const struct object_id *new_tree,
+			       const char *default_message,
+			       const char *action,
+			       struct strbuf *out)
+{
+	const char *path = git_path_commit_editmsg();
+	const char *hint =
+		_("Please enter the commit message for the %s changes."
+		  " Lines starting\nwith '%s' will be ignored, and an"
+		  " empty message aborts the commit.\n");
+	struct wt_status s;
+
+	strbuf_addstr(out, default_message);
+	strbuf_addch(out, '\n');
+	strbuf_commented_addf(out, comment_line_str, hint, action, comment_line_str);
+	write_file_buf(path, out->buf, out->len);
+
+	wt_status_prepare(repo, &s);
+	FREE_AND_NULL(s.branch);
+	s.ahead_behind_flags = AHEAD_BEHIND_QUICK;
+	s.commit_template = 1;
+	s.colopts = 0;
+	s.display_comment_prefix = 1;
+	s.hints = 0;
+	s.use_color = 0;
+	s.whence = FROM_COMMIT;
+	s.committable = 1;
+
+	s.fp = fopen(git_path_commit_editmsg(), "a");
+	if (!s.fp)
+		return error_errno(_("could not open '%s'"), git_path_commit_editmsg());
+
+	wt_status_collect_changes_trees(&s, old_tree, new_tree);
+	wt_status_print(&s);
+	wt_status_collect_free_buffers(&s);
+	string_list_clear_func(&s.change, change_data_free);
+
+	strbuf_reset(out);
+	if (launch_editor(path, out, NULL)) {
+		fprintf(stderr, _("Aborting commit as launching the editor failed.\n"));
+		return -1;
+	}
+	strbuf_stripspace(out, comment_line_str);
+
+	cleanup_message(out, COMMIT_MSG_CLEANUP_ALL, 0);
+
+	if (!out->len) {
+		fprintf(stderr, _("Aborting commit due to empty commit message.\n"));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int commit_tree_with_edited_message(struct repository *repo,
+					   const char *action,
+					   struct commit *original,
+					   struct commit **out)
+{
+	const char *exclude_gpgsig[] = {
+		/* We reencode the message, so the encoding needs to be stripped. */
+		"encoding",
+		/* We need to strip signatures as those will become invalid. */
+		"gpgsig",
+		"gpgsig-sha256",
+		NULL,
+	};
+	const char *original_message, *original_body, *ptr;
+	struct commit_extra_header *original_extra_headers = NULL;
+	struct strbuf commit_message = STRBUF_INIT;
+	struct object_id rewritten_commit_oid;
+	struct object_id original_tree_oid;
+	struct object_id parent_tree_oid;
+	char *original_author = NULL;
+	struct commit *parent;
+	size_t len;
+	int ret;
+
+	original_tree_oid = repo_get_commit_tree(repo, original)->object.oid;
+
+	parent = original->parents ? original->parents->item : NULL;
+	if (parent) {
+		if (repo_parse_commit(repo, parent)) {
+			ret = error(_("unable to parse parent commit %s"),
+				    oid_to_hex(&parent->object.oid));
+			goto out;
+		}
+
+		parent_tree_oid = repo_get_commit_tree(repo, parent)->object.oid;
+	} else {
+		oidcpy(&parent_tree_oid, repo->hash_algo->empty_tree);
+	}
+
+	/* We retain authorship of the original commit. */
+	original_message = repo_logmsg_reencode(repo, original, NULL, NULL);
+	ptr = find_commit_header(original_message, "author", &len);
+	if (ptr)
+		original_author = xmemdupz(ptr, len);
+	find_commit_subject(original_message, &original_body);
+
+	ret = fill_commit_message(repo, &parent_tree_oid, &original_tree_oid,
+				  original_body, action, &commit_message);
+	if (ret < 0)
+		goto out;
+
+	original_extra_headers = read_commit_extra_headers(original, exclude_gpgsig);
+
+	ret = commit_tree_extended(commit_message.buf, commit_message.len, &original_tree_oid,
+				   original->parents, &rewritten_commit_oid, original_author,
+				   NULL, NULL, original_extra_headers);
+	if (ret < 0)
+		goto out;
+
+	*out = lookup_commit_or_die(&rewritten_commit_oid, "rewritten commit");
+
+out:
+	free_commit_extra_headers(original_extra_headers);
+	strbuf_release(&commit_message);
+	free(original_author);
+	return ret;
+}
+
+enum ref_action {
+	REF_ACTION_DEFAULT,
+	REF_ACTION_BRANCHES,
+	REF_ACTION_HEAD,
+	REF_ACTION_PRINT,
+};
+
+static int parse_ref_action(const struct option *opt, const char *value, int unset)
+{
+	enum ref_action *action = opt->value;
+
+	BUG_ON_OPT_NEG_NOARG(unset, value);
+	if (!strcmp(value, "branches")) {
+		*action = REF_ACTION_BRANCHES;
+	} else if (!strcmp(value, "head")) {
+		*action = REF_ACTION_HEAD;
+	} else if (!strcmp(value, "print")) {
+		*action = REF_ACTION_PRINT;
+	} else {
+		return error(_("%s expects one of 'branches', 'head' or 'print'"),
+			     opt->long_name);
+	}
+
+	return 0;
+}
+
+static int handle_reference_updates(enum ref_action action,
+				    struct repository *repo,
+				    struct commit *original,
+				    struct commit *rewritten,
+				    const char *reflog_msg)
+{
+	const struct name_decoration *decoration;
+	struct replay_revisions_options opts = { 0 };
+	struct replay_result result = { 0 };
+	struct ref_transaction *transaction = NULL;
+	struct strvec args = STRVEC_INIT;
+	struct strbuf err = STRBUF_INIT;
+	struct commit *head = NULL;
+	struct rev_info revs;
+	char hex[GIT_MAX_HEXSZ + 1];
+	bool detached_head;
+	int head_flags = 0;
+	int ret;
+
+	refs_read_ref_full(get_main_ref_store(repo), "HEAD",
+			   RESOLVE_REF_NO_RECURSE, NULL, &head_flags);
+	detached_head = !(head_flags & REF_ISSYMREF);
+
+	repo_init_revisions(repo, &revs, NULL);
+	strvec_push(&args, "ignored");
+	strvec_push(&args, "--reverse");
+	strvec_push(&args, "--topo-order");
+	strvec_push(&args, "--full-history");
+
+	/* We only want to see commits that are descendants of the old commit. */
+	strvec_pushf(&args, "--ancestry-path=%s",
+		     oid_to_hex(&original->object.oid));
+
+	/*
+	 * Ancestry path may also show ancestors of the old commit, but we
+	 * don't want to see those, either.
+	 */
+	strvec_pushf(&args, "^%s", oid_to_hex(&original->object.oid));
+
+	/*
+	 * When we're asked to update HEAD we need to verify that the commit
+	 * that we want to rewrite is actually an ancestor of it and, if so,
+	 * update it. Otherwise we'll update (or print) all descendant
+	 * branches.
+	 */
+	if (action == REF_ACTION_HEAD) {
+		struct commit_list *from_list = NULL;
+
+		head = lookup_commit_reference_by_name("HEAD");
+		if (!head) {
+			ret = error(_("cannot look up HEAD"));
+			goto out;
+		}
+
+		commit_list_insert(original, &from_list);
+		ret = repo_is_descendant_of(repo, head, from_list);
+		free_commit_list(from_list);
+
+		if (ret < 0) {
+			ret = error(_("cannot determine descendance"));
+			goto out;
+		} else if (!ret) {
+			ret = error(_("rewritten commit must be an ancestor "
+				      "of HEAD when using --ref-action=head"));
+			goto out;
+		}
+
+		strvec_push(&args, "HEAD");
+	} else {
+		strvec_push(&args, "--branches");
+		strvec_push(&args, "HEAD");
+	}
+
+	setup_revisions_from_strvec(&args, &revs, NULL);
+	if (args.nr != 1)
+		BUG("revisions were set up with invalid argument");
+
+	opts.onto = oid_to_hex_r(hex, &rewritten->object.oid);
+
+	ret = replay_revisions(&revs, &opts, &result);
+	if (ret)
+		goto out;
+
+	switch (action) {
+	case REF_ACTION_BRANCHES:
+	case REF_ACTION_HEAD:
+		transaction = ref_store_transaction_begin(get_main_ref_store(repo), 0, &err);
+		if (!transaction) {
+			ret = error(_("failed to begin ref transaction: %s"), err.buf);
+			goto out;
+		}
+
+		for (size_t i = 0; i < result.updates_nr; i++) {
+			ret = ref_transaction_update(transaction,
+						     result.updates[i].refname,
+						     &result.updates[i].new_oid,
+						     &result.updates[i].old_oid,
+						     NULL, NULL, 0, reflog_msg, &err);
+			if (ret) {
+				ret = error(_("failed to update ref '%s': %s"),
+					    result.updates[i].refname, err.buf);
+				goto out;
+			}
+		}
+
+		/*
+		 * `replay_revisions()` only updates references that are
+		 * ancestors of `rewritten`, so we need to manually
+		 * handle updating references that point to `original`.
+		 */
+		for (decoration = get_name_decoration(&original->object);
+		     decoration;
+		     decoration = decoration->next)
+		{
+			if (decoration->type != DECORATION_REF_LOCAL &&
+			    decoration->type != DECORATION_REF_HEAD)
+				continue;
+
+			if (action == REF_ACTION_HEAD &&
+			    decoration->type != DECORATION_REF_HEAD)
+				continue;
+
+			/*
+			 * We only need to update HEAD separately in case it's
+			 * detached. If it's not we'd already update the branch
+			 * it is pointing to.
+			 */
+			if (action == REF_ACTION_BRANCHES &&
+			    decoration->type == DECORATION_REF_HEAD &&
+			    !detached_head)
+				continue;
+
+			ret = ref_transaction_update(transaction,
+						     decoration->name,
+						     &rewritten->object.oid,
+						     &original->object.oid,
+						     NULL, NULL, 0, reflog_msg, &err);
+			if (ret) {
+				ret = error(_("failed to update ref '%s': %s"),
+					    decoration->name, err.buf);
+				goto out;
+			}
+		}
+
+		if (ref_transaction_commit(transaction, &err)) {
+			ret = error(_("failed to commit ref transaction: %s"), err.buf);
+			goto out;
+		}
+
+		break;
+	case REF_ACTION_PRINT:
+		for (size_t i = 0; i < result.updates_nr; i++)
+			printf("update %s %s %s\n",
+			       result.updates[i].refname,
+			       oid_to_hex(&result.updates[i].new_oid),
+			       oid_to_hex(&result.updates[i].old_oid));
+		break;
+	default:
+		BUG("unsupported ref action %d", action);
+	}
+
+	ret = 0;
+
+out:
+	ref_transaction_free(transaction);
+	replay_result_release(&result);
+	release_revisions(&revs);
+	strbuf_release(&err);
+	strvec_clear(&args);
+	return ret;
+}
+
+static int cmd_history_reword(int argc,
+			      const char **argv,
+			      const char *prefix,
+			      struct repository *repo)
+{
+	const char * const usage[] = {
+		GIT_HISTORY_REWORD_USAGE,
+		NULL,
+	};
+	enum ref_action action = REF_ACTION_DEFAULT;
+	struct option options[] = {
+		OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
+			       N_("control ref update behavior (branches|head|print)"),
+			       PARSE_OPT_NONEG, parse_ref_action),
+		OPT_END(),
+	};
+	struct strbuf reflog_msg = STRBUF_INIT;
+	struct commit *original, *rewritten;
+	int ret;
+
+	argc = parse_options(argc, argv, prefix, options, usage, 0);
+	if (argc != 1) {
+		ret = error(_("command expects a single revision"));
+		goto out;
+	}
+	repo_config(repo, git_default_config, NULL);
+
+	if (action == REF_ACTION_DEFAULT)
+		action = REF_ACTION_BRANCHES;
+
+	original = lookup_commit_reference_by_name(argv[0]);
+	if (!original) {
+		ret = error(_("commit cannot be found: %s"), argv[0]);
+		goto out;
+	}
+
+	ret = commit_tree_with_edited_message(repo, "reworded", original, &rewritten);
+	if (ret < 0) {
+		ret = error(_("failed writing reworded commit"));
+		goto out;
+	}
+
+	strbuf_addf(&reflog_msg, "reword: updating %s", argv[0]);
+
+	ret = handle_reference_updates(action, repo, original, rewritten,
+				       reflog_msg.buf);
+	if (ret < 0) {
+		ret = error(_("failed replaying descendants"));
+		goto out;
+	}
+
+	ret = 0;
+
+out:
+	strbuf_release(&reflog_msg);
+	return ret;
+}
 
 int cmd_history(int argc,
 		const char **argv,
 		const char *prefix,
-		struct repository *repo UNUSED)
+		struct repository *repo)
 {
 	const char * const usage[] = {
-		N_("git history [<options>]"),
+		GIT_HISTORY_REWORD_USAGE,
 		NULL,
 	};
+	parse_opt_subcommand_fn *fn = NULL;
 	struct option options[] = {
+		OPT_SUBCOMMAND("reword", &fn, cmd_history_reword),
 		OPT_END(),
 	};
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
-	if (argc)
-		usagef("unrecognized argument: %s", argv[0]);
-	return 0;
+	return fn(argc, argv, prefix, repo);
 }
diff --git a/t/meson.build b/t/meson.build
index 73006b095a..c9f92450dc 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -388,6 +388,7 @@ integration_tests = [
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
   't3450-history.sh',
+  't3451-history-reword.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3450-history.sh b/t/t3450-history.sh
index 417c343d43..f513463b92 100755
--- a/t/t3450-history.sh
+++ b/t/t3450-history.sh
@@ -5,13 +5,13 @@ test_description='tests for git-history command'
 . ./test-lib.sh
 
 test_expect_success 'does nothing without any arguments' '
-	git history >out 2>&1 &&
-	test_must_be_empty out
+	test_must_fail git history 2>err &&
+	test_grep "need a subcommand" err
 '
 
 test_expect_success 'raises an error with unknown argument' '
 	test_must_fail git history garbage 2>err &&
-	test_grep "unrecognized argument: garbage" err
+	test_grep "unknown subcommand: .garbage." err
 '
 
 test_done
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
new file mode 100755
index 0000000000..3594421b68
--- /dev/null
+++ b/t/t3451-history-reword.sh
@@ -0,0 +1,391 @@
+#!/bin/sh
+
+test_description='tests for git-history reword subcommand'
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-log-graph.sh"
+
+reword_with_message () {
+	cat >message &&
+	write_script fake-editor.sh <<-\EOF &&
+	cp message "$1"
+	EOF
+	test_set_editor "$(pwd)"/fake-editor.sh &&
+	git history reword "$@" &&
+	rm fake-editor.sh message
+}
+
+expect_graph () {
+	cat >expect &&
+	lib_test_cmp_graph --graph --format=%s "$@"
+}
+
+expect_log () {
+	git log --format="%s" "$@" >actual &&
+	cat >expect &&
+	test_cmp expect actual
+}
+
+test_expect_success 'can reword tip of a branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		reword_with_message HEAD <<-EOF &&
+		third reworded
+		EOF
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		expect_log <<-\EOF &&
+		third reworded
+		second
+		first
+		EOF
+
+		git reflog >reflog &&
+		test_grep "reword: updating HEAD" reflog
+	)
+'
+
+test_expect_success 'can reword commit in the middle' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		git symbolic-ref HEAD >expect &&
+		reword_with_message HEAD~ <<-EOF &&
+		second reworded
+		EOF
+		git symbolic-ref HEAD >actual &&
+		test_cmp expect actual &&
+
+		expect_log <<-\EOF
+		third
+		second reworded
+		first
+		EOF
+	)
+'
+
+test_expect_success 'can reword commit in the middle even on detached head' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third_on_main &&
+		git checkout --detach HEAD^ &&
+		test_commit third_on_head &&
+
+		reword_with_message HEAD~ <<-EOF &&
+		second reworded
+		EOF
+
+		expect_graph HEAD --branches <<-\EOF
+		* third_on_head
+		| * third_on_main
+		|/
+		* second reworded
+		* first
+		EOF
+       )
+'
+
+test_expect_success 'can reword the detached head' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		git checkout --detach HEAD &&
+		test_commit third &&
+
+		reword_with_message HEAD <<-EOF &&
+		third reworded
+		EOF
+
+		expect_log <<-\EOF
+		third reworded
+		second
+		first
+		EOF
+	)
+'
+
+test_expect_success 'can reword root commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+		reword_with_message HEAD~2 <<-EOF &&
+		first reworded
+		EOF
+
+		expect_log <<-\EOF
+		third
+		second
+		first reworded
+		EOF
+	)
+'
+
+test_expect_success 'can reword in a bare repo' '
+	test_when_finished "rm -rf repo repo.git" &&
+	git init repo &&
+	test_commit -C repo first &&
+	git clone --bare repo repo.git &&
+	(
+		cd repo.git &&
+		reword_with_message HEAD <<-EOF &&
+		reworded
+		EOF
+
+		expect_log <<-\EOF
+		reworded
+		EOF
+	)
+'
+
+test_expect_success 'can reword a commit on a different branch' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch theirs &&
+		test_commit ours &&
+		git switch theirs &&
+		test_commit theirs &&
+
+		git rev-parse ours >ours-before &&
+		reword_with_message theirs <<-EOF &&
+		Reworded theirs
+		EOF
+		git rev-parse ours >ours-after &&
+		test_cmp ours-before ours-after &&
+
+		expect_graph --branches <<-\EOF
+		* Reworded theirs
+		| * ours
+		|/
+		* base
+		EOF
+	)
+'
+
+test_expect_success 'can reword a merge commit' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+		git switch - &&
+		git merge theirs &&
+
+		# It is not possible to replay merge commits embedded in the
+		# history (yet).
+		test_must_fail git history reword HEAD~ 2>err &&
+		test_grep "replaying merge commits is not supported yet" err &&
+
+		# But it is possible to reword a merge commit directly.
+		reword_with_message HEAD <<-EOF &&
+		Reworded merge commit
+		EOF
+		expect_graph <<-\EOF
+		*   Reworded merge commit
+		|\
+		| * theirs
+		* | ours
+		|/
+		* base
+		EOF
+	)
+'
+
+test_expect_success '--ref-action=print prints ref updates without modifying repo' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit ours &&
+		git switch branch &&
+		test_commit theirs &&
+
+		git refs list >refs-expect &&
+		reword_with_message --ref-action=print base >updates <<-\EOF &&
+		reworded commit
+		EOF
+		git refs list >refs-actual &&
+		test_cmp refs-expect refs-actual &&
+
+		test_grep "update refs/heads/branch" updates &&
+		test_grep "update refs/heads/main" updates &&
+		git update-ref --stdin <updates &&
+		expect_log --branches <<-\EOF
+		theirs
+		ours
+		reworded commit
+		EOF
+	)
+'
+
+test_expect_success '--ref-action=head updates only HEAD' '
+	test_when_finished "rm -rf repo" &&
+	git init repo --initial-branch=main &&
+	(
+		cd repo &&
+		test_commit base &&
+		git branch branch &&
+		test_commit theirs &&
+		git switch branch &&
+		test_commit ours &&
+
+		# When told to update HEAD, only, the command will refuse to
+		# rewrite commits that are not an ancestor of HEAD.
+		test_must_fail git history reword --ref-action=head theirs 2>err &&
+		test_grep "rewritten commit must be an ancestor of HEAD" err &&
+
+		reword_with_message --ref-action=head base >updates <<-\EOF &&
+		reworded base
+		EOF
+		expect_log HEAD <<-\EOF &&
+		ours
+		reworded base
+		EOF
+		expect_log main <<-\EOF
+		theirs
+		base
+		EOF
+	)
+'
+
+test_expect_success 'editor shows proper status' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		write_script fake-editor.sh <<-\EOF &&
+		cp "$1" . &&
+		printf "\namend a comment\n" >>"$1"
+		EOF
+		test_set_editor "$(pwd)"/fake-editor.sh &&
+		git history reword HEAD &&
+
+		cat >expect <<-EOF &&
+		first
+
+		# Please enter the commit message for the reworded changes. Lines starting
+		# with ${SQ}#${SQ} will be ignored, and an empty message aborts the commit.
+		# Changes to be committed:
+		#	new file:   first.t
+		#
+		EOF
+		test_cmp expect COMMIT_EDITMSG &&
+
+		test_commit_message HEAD <<-\EOF
+		first
+
+		amend a comment
+		EOF
+	)
+'
+
+# For now, git-history(1) does not yet execute any hooks. This is subject to
+# change in the future, and if it does this test here is expected to start
+# failing. In other words, this test is not an endorsement of the current
+# status quo.
+test_expect_success 'hooks are not executed for rewritten commits' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+		test_commit second &&
+		test_commit third &&
+
+		ORIG_PATH="$(pwd)" &&
+		export ORIG_PATH &&
+		for hook in prepare-commit-msg pre-commit post-commit post-rewrite commit-msg
+		do
+			write_script .git/hooks/$hook <<-\EOF || exit 1
+			touch "$ORIG_PATH/hooks.log
+			EOF
+		done &&
+
+		reword_with_message HEAD~ <<-EOF &&
+		second reworded
+		EOF
+
+		cat >expect <<-EOF &&
+		third
+		second reworded
+		first
+		EOF
+		git log --format=%s >actual &&
+		test_cmp expect actual &&
+
+		test_path_is_missing hooks.log
+	)
+'
+
+test_expect_success 'aborts with empty commit message' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit first &&
+
+		! reword_with_message HEAD 2>err </dev/null &&
+		test_grep "Aborting commit due to empty commit message." err
+	)
+'
+
+test_expect_success 'retains changes in the worktree and index' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		touch a b &&
+		git add . &&
+		git commit -m "initial commit" &&
+		echo foo >a &&
+		echo bar >b &&
+		git add b &&
+		reword_with_message HEAD <<-EOF &&
+		message
+		EOF
+		cat >expect <<-\EOF &&
+		 M a
+		M  b
+		?? actual
+		?? expect
+		EOF
+		git status --porcelain >actual &&
+		test_cmp expect actual
+	)
+'
+
+test_done

-- 
2.52.0.590.g1f87b77810.dirty

