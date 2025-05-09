Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135311CF7AF
	for <git@vger.kernel.org>; Fri,  9 May 2025 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746807755; cv=none; b=RZBhvWeZbSc9hka3Yz/pkZqILruUIUAs5bOi7wDTBlI1Izlxs6UaSsCWI5nLocGipzyHBYv1zq58pgdd30ERdOrcmXyc2wGx+9PzWrnsCotu8PZWchFA1ltX53ddQnyBzNqQeC+KSC/mMJ3DISgSWe8iW1Kx5Cfr938h4f9NqX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746807755; c=relaxed/simple;
	bh=nchfm1T1GvwaMRWE+TYEEHjuewitFtDrCoeiPja9Ly8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=BQ5JHxAB4McPT2bXPvx4aPSVm4AFuNuIZE6z5Hbujkk6d6VmRAc598D6kRKZ7gyANBUc5On+l+yj5NTWO9TkqPoCRYZWkF7bzgbOHsmMKaMchA2IxC7dVPHOVvjxNXziAVpDOOD3iOyl45IRg4O+WIHyg+ueSCqrsbnqrW+tI74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hOyctCsY; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOyctCsY"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a0b9625735so1134651f8f.2
        for <git@vger.kernel.org>; Fri, 09 May 2025 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746807750; x=1747412550; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6k5SUTJ+DIpT4BwU1iPHaqPo4CYahKq+43KnvVCckY=;
        b=hOyctCsY7LJAla3lWDL/2HnUskYMsqCb7IalXrjyUUhXmw8F2dvr1/zhyo8CLRB7Z6
         bqR/5eAO2xc+1zD8lf2v2ln40WkVkLj7Tslbk9qAggVifmEZi/cblovOlEOY4YnT9JII
         rwbwXmqfU3V65YLXgIQM4TRHr2jGtYRQ3GSMK/VD0vwsOQU7wtOwQHRWZm5lPJZwKyXX
         3QEFJ2T6wTR0l6zr4lRzvECshkAHkkdrWjrlwD58fFNKPANfSAxL1REGCKymR79YTW3H
         J2s54w4DeG+SOgeXT2aK7mWjFcDgqvBq5ovSjfNbEcMcpyRJykF3LCzOzAUmdi9bqOhw
         1M/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746807750; x=1747412550;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6k5SUTJ+DIpT4BwU1iPHaqPo4CYahKq+43KnvVCckY=;
        b=IuTc+YSpuXAt6zxt59ycaWmSvWNbhLJuk2Xpx7q2dXLMzyIK2QJCU28olEyjp65pPA
         PK+3VdBS4BiQWIdY7u+9GRxx6Ifmn23mn9m9glFcamZ/GKwaZTulyw5ok0BNT72La/xq
         178hlqUkXBwor+sONMZT18XCcLHzXP+H8STTxu21P/fomtQOydQktuMdSSKJndcOPIuL
         GNiRTvkH3uc3qTnekBUEkgA23LB2TO88LlmYnzDq4eZvOGwTa31zI+e3RWIFSdCc1zgx
         oaqwZWcWlnthpu+9Jpe5PUn8WxcMeuaFGzL/xq4g4LcPvNrxMhAtnLwxip53JBg/+VbI
         GpCQ==
X-Gm-Message-State: AOJu0Yw/bZ/gxpRAcmuPIqrgl8Zn0OD8xQpovAXR87x07TX1Ye41cSBu
	hW45ORwVkMozvgbhltEzPfOuHw5GL1ToYp/lGcKnezzr7Y8YjC11fcQ/Xg==
X-Gm-Gg: ASbGncu0ZoJFJ7JpeQ7+CRi69d37aAzqGcmZHbFZiDXA+UEH9ux9Yno/KJboO7OBMgM
	p4LpTQGnHr13P/K8BB9wTFTHYtAV+i5bhwdMoX/mYR+zawthQAxyv076ukxsfzrlMMPiW6jYfG4
	oYd4/SpkNd/tEbndMcN+HtPLz1OGttC8oUVPKQekEgBm6PxQMi68KfoQJ8G9I/cYqAKksl2BTdn
	XboGQanXTjG0Ybc6sutcLgOy3M4jriKcL/OVW6FjErTPtAwzUFjYJPZtM9t6OECzjihZ8QI8na8
	97frTRDYjob80TAhzwGQpO80X/qGfQeZDGjj4mltRu1Pd/dV6Xzg
X-Google-Smtp-Source: AGHT+IFR2fcfOFY0XSNFJcgzPmQpiJDHKvz0DsQoIuKxFbkQv/2aeAyhXbiW5p4xI2pvH1ufgaK28A==
X-Received: by 2002:a05:6000:420f:b0:3a0:bdeb:c48c with SMTP id ffacd0b85a97d-3a1f64497a8mr3543120f8f.34.1746807750339;
        Fri, 09 May 2025 09:22:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2ce36sm3705952f8f.71.2025.05.09.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 09:22:29 -0700 (PDT)
Message-Id: <90c6912478683d96ef18b521506c703a2467585e.1746807747.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1919.git.1746807747.gitgitgadget@gmail.com>
References: <pull.1919.git.1746807747.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 16:22:27 +0000
Subject: [PATCH 2/2] sequencer: rework reflog message handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

It has been reported that "git rebase --rebase-merges" can create
corrupted reflog entries like

    e9c962f2ea0 HEAD@{8}: <binary>�: Merged in <branch> (pull request #4441)

This is due to a use-after-free bug that happens because
reflog_message() uses a static `struct strbuf` and is not called to
update the current reflog message stored in `ctx->reflog_message` when
creating the merge. This means `ctx->reflog_message` points to a stale
reflog message that has been freed by subsequent call to
reflog_message() by a command such as `reset` that used the return value
directly rather than storing the result in `ctx->reflog_message`.

Fix this by creating the reflog message nearer to where the commit is
created and storing it in a local variable which is passed as an
additional parameter to run_git_commit() rather than storing the message
in `struct replay_ctx`. This makes it harder to forget to call
`reflog_message()` before creating a commit and using a variable with a
narrower scope means that a stale value cannot carried across a from one
iteration of the loop to the next which should prevent any similar
use-after-free bugs in the future.

A existing test is modified to demonstrate that merges are now created
with the correct reflog message.

Reported-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 sequencer.c              | 50 +++++++++++++++++++---------------------
 t/t3430-rebase-merges.sh | 11 ++++++++-
 2 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index bb4667190db1..e23708690900 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -224,11 +224,6 @@ struct replay_ctx {
 	 * current chain.
 	 */
 	struct strbuf current_fixups;
-	/*
-	 * Stores the reflog message that will be used when creating a
-	 * commit. Points to a static buffer and should not be free()'d.
-	 */
-	const char *reflog_message;
 	/*
 	 * The number of completed fixup and squash commands in the
 	 * current chain.
@@ -1124,10 +1119,10 @@ static int run_command_silent_on_success(struct child_process *cmd)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg,
+			  const char *reflog_action,
 			  struct replay_opts *opts,
 			  unsigned int flags)
 {
-	struct replay_ctx *ctx = opts->ctx;
 	struct child_process cmd = CHILD_PROCESS_INIT;
 
 	if ((flags & CLEANUP_MSG) && (flags & VERBATIM_MSG))
@@ -1145,7 +1140,7 @@ static int run_git_commit(const char *defmsg,
 			     gpg_opt, gpg_opt);
 	}
 
-	strvec_pushf(&cmd.env, GIT_REFLOG_ACTION "=%s", ctx->reflog_message);
+	strvec_pushf(&cmd.env, GIT_REFLOG_ACTION "=%s", reflog_action);
 
 	if (opts->committer_date_is_author_date)
 		strvec_pushf(&cmd.env, "GIT_COMMITTER_DATE=%s",
@@ -1529,10 +1524,10 @@ static int parse_head(struct repository *r, struct commit **head)
  */
 static int try_to_commit(struct repository *r,
 			 struct strbuf *msg, const char *author,
+			 const char *reflog_action,
 			 struct replay_opts *opts, unsigned int flags,
 			 struct object_id *oid)
 {
-	struct replay_ctx *ctx = opts->ctx;
 	struct object_id tree;
 	struct commit *current_head = NULL;
 	struct commit_list *parents = NULL;
@@ -1694,7 +1689,7 @@ static int try_to_commit(struct repository *r,
 		goto out;
 	}
 
-	if (update_head_with_reflog(current_head, oid, ctx->reflog_message,
+	if (update_head_with_reflog(current_head, oid, reflog_action,
 				    msg, &err)) {
 		res = error("%s", err.buf);
 		goto out;
@@ -1725,6 +1720,7 @@ static int write_rebase_head(struct object_id *oid)
 
 static int do_commit(struct repository *r,
 		     const char *msg_file, const char *author,
+		     const char *reflog_action,
 		     struct replay_opts *opts, unsigned int flags,
 		     struct object_id *oid)
 {
@@ -1740,7 +1736,7 @@ static int do_commit(struct repository *r,
 					   msg_file);
 
 		res = try_to_commit(r, msg_file ? &sb : NULL,
-				    author, opts, flags, &oid);
+				    author, reflog_action, opts, flags, &oid);
 		strbuf_release(&sb);
 		if (!res) {
 			refs_delete_ref(get_main_ref_store(r), "",
@@ -1756,7 +1752,7 @@ static int do_commit(struct repository *r,
 		if (is_rebase_i(opts) && oid)
 			if (write_rebase_head(oid))
 			    return -1;
-		return run_git_commit(msg_file, opts, flags);
+		return run_git_commit(msg_file, reflog_action, opts, flags);
 	}
 
 	return res;
@@ -2269,13 +2265,19 @@ static int do_pick_commit(struct repository *r,
 	const char *msg_file = should_edit(opts) ? NULL : git_path_merge_msg(r);
 	struct object_id head;
 	struct commit *base, *next, *parent;
-	const char *base_label, *next_label;
+	const char *base_label, *next_label, *reflog_action;
 	char *author = NULL;
 	struct commit_message msg = { NULL, NULL, NULL, NULL };
 	int res, unborn = 0, reword = 0, allow, drop_commit;
 	enum todo_command command = item->command;
 	struct commit *commit = item->commit;
 
+	if (is_rebase_i(opts))
+		reflog_action = reflog_message(
+			opts, command_to_string(item->command), NULL);
+	else
+		reflog_action = sequencer_reflog_action(opts);
+
 	if (opts->no_commit) {
 		/*
 		 * We do not intend to commit immediately.  We just want to
@@ -2527,7 +2529,8 @@ static int do_pick_commit(struct repository *r,
 	} /* else allow == 0 and there's nothing special to do */
 	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
-			res = do_commit(r, msg_file, author, opts, flags,
+			res = do_commit(r, msg_file, author, reflog_action,
+					opts, flags,
 					commit? &commit->object.oid : NULL);
 		else
 			res = error(_("unable to parse commit author"));
@@ -2542,7 +2545,7 @@ fast_forward_edit:
 			 * got here.
 			 */
 			flags = EDIT_MSG | VERIFY_MSG | AMEND_MSG | ALLOW_EMPTY;
-			res = run_git_commit(NULL, opts, flags);
+			res = run_git_commit(NULL, reflog_action, opts, flags);
 			*check_todo = 1;
 		}
 	}
@@ -4089,6 +4092,7 @@ static int do_merge(struct repository *r,
 	int merge_arg_len, oneline_offset, can_fast_forward, ret, k;
 	static struct lock_file lock;
 	const char *p;
+	const char *reflog_action = reflog_message(opts, "merge", NULL);
 
 	if (repo_hold_locked_index(r, &lock, LOCK_REPORT_ON_ERROR) < 0) {
 		ret = -1;
@@ -4360,14 +4364,15 @@ static int do_merge(struct repository *r,
 		 * value (a negative one would indicate that the `merge`
 		 * command needs to be rescheduled).
 		 */
-		ret = !!run_git_commit(git_path_merge_msg(r), opts,
-				       run_commit_flags);
+		ret = !!run_git_commit(git_path_merge_msg(r), reflog_action,
+				       opts, run_commit_flags);
 
 	if (!ret && flags & TODO_EDIT_MERGE_MSG) {
 	fast_forward_edit:
 		*check_todo = 1;
 		run_commit_flags |= AMEND_MSG | EDIT_MSG | VERIFY_MSG;
-		ret = !!run_git_commit(NULL, opts, run_commit_flags);
+		ret = !!run_git_commit(NULL, reflog_action, opts,
+				       run_commit_flags);
 	}
 
 
@@ -4882,13 +4887,9 @@ static int pick_one_commit(struct repository *r,
 			   struct replay_opts *opts,
 			   int *check_todo, int* reschedule)
 {
-	struct replay_ctx *ctx = opts->ctx;
 	int res;
 	struct todo_item *item = todo_list->items + todo_list->current;
 	const char *arg = todo_item_get_arg(todo_list, item);
-	if (is_rebase_i(opts))
-		ctx->reflog_message = reflog_message(
-			opts, command_to_string(item->command), NULL);
 
 	res = do_pick_commit(r, item, opts, is_final_fixup(todo_list),
 			     check_todo);
@@ -4947,7 +4948,6 @@ static int pick_commits(struct repository *r,
 	struct replay_ctx *ctx = opts->ctx;
 	int res = 0, reschedule = 0;
 
-	ctx->reflog_message = sequencer_reflog_action(opts);
 	if (opts->allow_ff)
 		ASSERT(!(opts->signoff || opts->no_commit ||
 			 opts->record_origin || should_edit(opts) ||
@@ -5208,6 +5208,7 @@ static int commit_staged_changes(struct repository *r,
 	unsigned int flags = ALLOW_EMPTY | EDIT_MSG;
 	unsigned int final_fixup = 0, is_clean;
 	struct strbuf rev = STRBUF_INIT;
+	const char *reflog_action = reflog_message(opts, "continue", NULL);
 	int ret;
 
 	if (has_unstaged_changes(r, 1)) {
@@ -5370,7 +5371,7 @@ static int commit_staged_changes(struct repository *r,
 	}
 
 	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
-			   opts, flags)) {
+			   reflog_action, opts, flags)) {
 		ret = error(_("could not commit staged changes."));
 		goto out;
 	}
@@ -5402,7 +5403,6 @@ out:
 
 int sequencer_continue(struct repository *r, struct replay_opts *opts)
 {
-	struct replay_ctx *ctx = opts->ctx;
 	struct todo_list todo_list = TODO_LIST_INIT;
 	int res;
 
@@ -5423,7 +5423,6 @@ int sequencer_continue(struct repository *r, struct replay_opts *opts)
 			unlink(rebase_path_dropped());
 		}
 
-		ctx->reflog_message = reflog_message(opts, "continue", NULL);
 		if (commit_staged_changes(r, opts, &todo_list)) {
 			res = -1;
 			goto release_todo_list;
@@ -5475,7 +5474,6 @@ static int single_pick(struct repository *r,
 			TODO_PICK : TODO_REVERT;
 	item.commit = cmit;
 
-	opts->ctx->reflog_message = sequencer_reflog_action(opts);
 	return do_pick_commit(r, &item, opts, 0, &check_todo);
 }
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index b84d68c4b96b..ff81adab8cf6 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -86,7 +86,7 @@ test_expect_success 'create completely different structure' '
 	test_config sequence.editor \""$PWD"/replace-editor.sh\" &&
 	test_tick &&
 	git rebase -i -r A main &&
-	test_cmp_graph <<-\EOF
+	test_cmp_graph <<-\EOF &&
 	*   Merge the topic branch '\''onebranch'\''
 	|\
 	| * D
@@ -99,6 +99,15 @@ test_expect_success 'create completely different structure' '
 	|/
 	* A
 	EOF
+
+	head="$(git show-ref --verify -s --abbrev HEAD)" &&
+	cat >expect <<-EOF &&
+	$head HEAD@{0}: rebase (finish): returning to refs/heads/main
+	$head HEAD@{1}: rebase (merge): Merge the topic branch ${SQ}onebranch${SQ}
+	EOF
+
+	git reflog -n2 HEAD >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'generate correct todo list' '
-- 
gitgitgadget
