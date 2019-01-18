Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1551F1F453
	for <e@80x24.org>; Fri, 18 Jan 2019 15:09:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbfARPJ2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 10:09:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43868 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbfARPJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 10:09:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so11346179eds.10
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 07:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yrJPdEdi6W38ctW75TQeUk4t5HU9FnnOCPf3eM5gtgI=;
        b=FYdLvofNJrtn/E15jSmsb5qbaMYzizplzhIde3EKF+lORK0NxfkYyizixderG2dg9w
         6l9j+gT2cbk6rF5iYtVGMUXzXKilv8bNF6LoHHnWsy8sToW7LnuIUg8TuVAIezsaNjHl
         UkXsWBzZlzKE9wL8K0X/pu3SzHknILpajDsgjmL9UMBG7PFNSwkt+jysNr+/Xo5CivW0
         +DgQLDF0DA7jyFakZhn1zyRh76iRBbDB2kN54p+FMo4VyjN650tqKjCBOcaMaELBm69b
         1QG5IK2/kTwpWAdm9jgQtxasBI0Q1yJiXlrzcSxqBihOwfPK+MEIRegbnUKORCU/ULNy
         hBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yrJPdEdi6W38ctW75TQeUk4t5HU9FnnOCPf3eM5gtgI=;
        b=O39OulthhDNUkkq3em1fVnIZJF1Z35iw8gNDCZaGdWYgFOqNyWcc92wrBqS/blG97Y
         2vmSIeZJyOk2+CX3EAzx45RBdc9f4w5fGZ1Zcp0dJw+RRVbjeAciZC6jHt+d5RQotDSy
         Gs0lynWnnhY/0egSZz3+Ltnp72BkLmFO0RaMBw7EMSUFlw4I/7bvZVsHAGRiIFfMI3IZ
         jyoX/Pd6/Sc2QoKroo3+SnG56Qi2wv1v5nJnyQIXrlpHsg+iauWO3imOu+4jWziWEVA8
         W8ysiaF0c+1CgcJBNnDnBeTgx8yAe703YF8IaK7QZWlX54bkEZDZAtQnJNbb0coBzyQ6
         GOvw==
X-Gm-Message-State: AJcUukcoNo8qaj9Btu5TXkhGxR1Tgx7MP35QNH+CRqhdMJxuJemPrWjf
        UwC9OAM7yLCrKx4OIpFhTnBUsbr2
X-Google-Smtp-Source: ALg8bN6TBJpy/Y78mg6Z6kIC4f5Mlg9eDgGTxD8hZG4axMNbmbi7Y5QfSFbWzYGY/LxdMN33wUo3Nw==
X-Received: by 2002:aa7:db0e:: with SMTP id t14mr16309690eds.292.1547824165471;
        Fri, 18 Jan 2019 07:09:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q16sm6794828eds.60.2019.01.18.07.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 07:09:24 -0800 (PST)
Date:   Fri, 18 Jan 2019 07:09:24 -0800 (PST)
X-Google-Original-Date: Fri, 18 Jan 2019 15:09:19 GMT
Message-Id: <e886ae3de50cdc200b50781aaa4746535d3a8589.1547824162.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.24.v2.git.gitgitgadget@gmail.com>
References: <pull.24.git.gitgitgadget@gmail.com>
        <pull.24.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/4] rebase: move `reset_head()` into a better spot
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Over the next commits, we want to make use of it in `run_am()` (i.e.
running the `--am` backend directly, without detouring to Unix shell
script code) which in turn will be called from `run_specific_rebase()`.

So let's move it before that latter function.

This commit is best viewed using --color-moved.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase.c | 238 +++++++++++++++++++++++------------------------
 1 file changed, 119 insertions(+), 119 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 00de70365e..efa90ca894 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -333,6 +333,125 @@ static void add_var(struct strbuf *buf, const char *name, const char *value)
 	}
 }
 
+#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
+
+#define RESET_HEAD_DETACH (1<<0)
+#define RESET_HEAD_HARD (1<<1)
+
+static int reset_head(struct object_id *oid, const char *action,
+		      const char *switch_to_branch, unsigned flags,
+		      const char *reflog_orig_head, const char *reflog_head)
+{
+	unsigned detach_head = flags & RESET_HEAD_DETACH;
+	unsigned reset_hard = flags & RESET_HEAD_HARD;
+	struct object_id head_oid;
+	struct tree_desc desc[2] = { { NULL }, { NULL } };
+	struct lock_file lock = LOCK_INIT;
+	struct unpack_trees_options unpack_tree_opts;
+	struct tree *tree;
+	const char *reflog_action;
+	struct strbuf msg = STRBUF_INIT;
+	size_t prefix_len;
+	struct object_id *orig = NULL, oid_orig,
+		*old_orig = NULL, oid_old_orig;
+	int ret = 0, nr = 0;
+
+	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
+		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
+
+	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
+		ret = -1;
+		goto leave_reset_head;
+	}
+
+	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
+		ret = error(_("could not determine HEAD revision"));
+		goto leave_reset_head;
+	}
+
+	if (!oid)
+		oid = &head_oid;
+
+	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
+	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
+	unpack_tree_opts.head_idx = 1;
+	unpack_tree_opts.src_index = the_repository->index;
+	unpack_tree_opts.dst_index = the_repository->index;
+	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
+	unpack_tree_opts.update = 1;
+	unpack_tree_opts.merge = 1;
+	if (!detach_head)
+		unpack_tree_opts.reset = 1;
+
+	if (read_index_unmerged(the_repository->index) < 0) {
+		ret = error(_("could not read index"));
+		goto leave_reset_head;
+	}
+
+	if (!reset_hard && !fill_tree_descriptor(&desc[nr++], &head_oid)) {
+		ret = error(_("failed to find tree of %s"),
+			    oid_to_hex(&head_oid));
+		goto leave_reset_head;
+	}
+
+	if (!fill_tree_descriptor(&desc[nr++], oid)) {
+		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
+		goto leave_reset_head;
+	}
+
+	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
+		ret = -1;
+		goto leave_reset_head;
+	}
+
+	tree = parse_tree_indirect(oid);
+	prime_cache_tree(the_repository, the_repository->index, tree);
+
+	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
+		ret = error(_("could not write index"));
+		goto leave_reset_head;
+	}
+
+	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
+	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
+	prefix_len = msg.len;
+
+	if (!get_oid("ORIG_HEAD", &oid_old_orig))
+		old_orig = &oid_old_orig;
+	if (!get_oid("HEAD", &oid_orig)) {
+		orig = &oid_orig;
+		if (!reflog_orig_head) {
+			strbuf_addstr(&msg, "updating ORIG_HEAD");
+			reflog_orig_head = msg.buf;
+		}
+		update_ref(reflog_orig_head, "ORIG_HEAD", orig, old_orig, 0,
+			   UPDATE_REFS_MSG_ON_ERR);
+	} else if (old_orig)
+		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
+	if (!reflog_head) {
+		strbuf_setlen(&msg, prefix_len);
+		strbuf_addstr(&msg, "updating HEAD");
+		reflog_head = msg.buf;
+	}
+	if (!switch_to_branch)
+		ret = update_ref(reflog_head, "HEAD", oid, orig,
+				 detach_head ? REF_NO_DEREF : 0,
+				 UPDATE_REFS_MSG_ON_ERR);
+	else {
+		ret = create_symref("HEAD", switch_to_branch, msg.buf);
+		if (!ret)
+			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
+					 UPDATE_REFS_MSG_ON_ERR);
+	}
+
+leave_reset_head:
+	strbuf_release(&msg);
+	rollback_lock_file(&lock);
+	while (nr)
+		free((void *)desc[--nr].buffer);
+	return ret;
+}
+
 static const char *resolvemsg =
 N_("Resolve all conflicts manually, mark them as resolved with\n"
 "\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
@@ -526,125 +645,6 @@ static int run_specific_rebase(struct rebase_options *opts)
 	return status ? -1 : 0;
 }
 
-#define GIT_REFLOG_ACTION_ENVIRONMENT "GIT_REFLOG_ACTION"
-
-#define RESET_HEAD_DETACH (1<<0)
-#define RESET_HEAD_HARD (1<<1)
-
-static int reset_head(struct object_id *oid, const char *action,
-		      const char *switch_to_branch, unsigned flags,
-		      const char *reflog_orig_head, const char *reflog_head)
-{
-	unsigned detach_head = flags & RESET_HEAD_DETACH;
-	unsigned reset_hard = flags & RESET_HEAD_HARD;
-	struct object_id head_oid;
-	struct tree_desc desc[2] = { { NULL }, { NULL } };
-	struct lock_file lock = LOCK_INIT;
-	struct unpack_trees_options unpack_tree_opts;
-	struct tree *tree;
-	const char *reflog_action;
-	struct strbuf msg = STRBUF_INIT;
-	size_t prefix_len;
-	struct object_id *orig = NULL, oid_orig,
-		*old_orig = NULL, oid_old_orig;
-	int ret = 0, nr = 0;
-
-	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
-		BUG("Not a fully qualified branch: '%s'", switch_to_branch);
-
-	if (hold_locked_index(&lock, LOCK_REPORT_ON_ERROR) < 0) {
-		ret = -1;
-		goto leave_reset_head;
-	}
-
-	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
-		ret = error(_("could not determine HEAD revision"));
-		goto leave_reset_head;
-	}
-
-	if (!oid)
-		oid = &head_oid;
-
-	memset(&unpack_tree_opts, 0, sizeof(unpack_tree_opts));
-	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
-	unpack_tree_opts.head_idx = 1;
-	unpack_tree_opts.src_index = the_repository->index;
-	unpack_tree_opts.dst_index = the_repository->index;
-	unpack_tree_opts.fn = reset_hard ? oneway_merge : twoway_merge;
-	unpack_tree_opts.update = 1;
-	unpack_tree_opts.merge = 1;
-	if (!detach_head)
-		unpack_tree_opts.reset = 1;
-
-	if (read_index_unmerged(the_repository->index) < 0) {
-		ret = error(_("could not read index"));
-		goto leave_reset_head;
-	}
-
-	if (!reset_hard && !fill_tree_descriptor(&desc[nr++], &head_oid)) {
-		ret = error(_("failed to find tree of %s"),
-			    oid_to_hex(&head_oid));
-		goto leave_reset_head;
-	}
-
-	if (!fill_tree_descriptor(&desc[nr++], oid)) {
-		ret = error(_("failed to find tree of %s"), oid_to_hex(oid));
-		goto leave_reset_head;
-	}
-
-	if (unpack_trees(nr, desc, &unpack_tree_opts)) {
-		ret = -1;
-		goto leave_reset_head;
-	}
-
-	tree = parse_tree_indirect(oid);
-	prime_cache_tree(the_repository, the_repository->index, tree);
-
-	if (write_locked_index(the_repository->index, &lock, COMMIT_LOCK) < 0) {
-		ret = error(_("could not write index"));
-		goto leave_reset_head;
-	}
-
-	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
-	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : "rebase");
-	prefix_len = msg.len;
-
-	if (!get_oid("ORIG_HEAD", &oid_old_orig))
-		old_orig = &oid_old_orig;
-	if (!get_oid("HEAD", &oid_orig)) {
-		orig = &oid_orig;
-		if (!reflog_orig_head) {
-			strbuf_addstr(&msg, "updating ORIG_HEAD");
-			reflog_orig_head = msg.buf;
-		}
-		update_ref(reflog_orig_head, "ORIG_HEAD", orig, old_orig, 0,
-			   UPDATE_REFS_MSG_ON_ERR);
-	} else if (old_orig)
-		delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
-	if (!reflog_head) {
-		strbuf_setlen(&msg, prefix_len);
-		strbuf_addstr(&msg, "updating HEAD");
-		reflog_head = msg.buf;
-	}
-	if (!switch_to_branch)
-		ret = update_ref(reflog_head, "HEAD", oid, orig,
-				 detach_head ? REF_NO_DEREF : 0,
-				 UPDATE_REFS_MSG_ON_ERR);
-	else {
-		ret = create_symref("HEAD", switch_to_branch, msg.buf);
-		if (!ret)
-			ret = update_ref(reflog_head, "HEAD", oid, NULL, 0,
-					 UPDATE_REFS_MSG_ON_ERR);
-	}
-
-leave_reset_head:
-	strbuf_release(&msg);
-	rollback_lock_file(&lock);
-	while (nr)
-		free((void *)desc[--nr].buffer);
-	return ret;
-}
-
 static int rebase_config(const char *var, const char *value, void *data)
 {
 	struct rebase_options *opts = data;
-- 
gitgitgadget

