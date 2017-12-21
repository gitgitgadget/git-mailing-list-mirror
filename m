Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-0.9 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E43A31F85D
	for <e@80x24.org>; Wed, 11 Jul 2018 12:38:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387577AbeGKMmX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jul 2018 08:42:23 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39817 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbeGKMmW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jul 2018 08:42:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id n2-v6so2882302pgq.6
        for <git@vger.kernel.org>; Wed, 11 Jul 2018 05:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=7BlySfNLIOrxLtoclzFYzmKhrUBWb79ZheTWI8qZkRA=;
        b=hjtVkzD31Mo2raRzjTBb3Rt/zdF5yBsERELsLDoXPmyl3HeOqf9ghfX0vZTbNFFbZc
         O9hA+rsTReVlzNCS3wnO6cd0dEuUoXXHQZ3IHrUFvfTHR31H8VHmIi7Cb6CzoIDo0hK8
         icvlaXysGzdWCduCf684iEo05ses8XrjZLGc9pbWVnnuSzm4cs5Us9Dbs5dxQ3foiDM3
         pQsnMYlUFMTrDLUaD64lAofBaKOQsG6XIADBH0G1sxFVzUL/pQGG4e9B1P4cvu1n3HkQ
         ndiAZkdzb63IgkA9GkrAt6ehbe/X5C6TU+MHnzs76aRLUeO/1wAioY9XN58UOjP7pNxB
         y/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=7BlySfNLIOrxLtoclzFYzmKhrUBWb79ZheTWI8qZkRA=;
        b=VBNvrqdCOzx416eHzLqTIJZxb8EPyd2GdrCscf2DUFsed6eLQ8re62r5Gw0KTYVbtM
         UAPuYpqLr0sCNE/yMO6/CEHp0as5N1thEqPtZfEQV7/+/h0ZtsL6PC6el5bhZrzqNj+L
         izm0UjJwPUHJ/74tuN/oWxp2ZfxW407QGFRPuzfdIwHij9ff1JMUNEpnUlWMa3EFVDkM
         297e/DHcfVwTv9nE/ai/kODj77+N+mNMXNNRxZ55an4d7wIOJ95dhi7ff6IpHK0U5iam
         qM21M+ojvPW/gM6+x04vJre+kZKzO0omCSPQVNO6fTL73I69GrnMdo3n+lWGYUSg5nJY
         snXg==
X-Gm-Message-State: APt69E10VQdwgjMUSzq0xPBnX4oUwj/0QG6GL8PYTeouqYMsdL5ZKwvv
        pWYHMzb4WEUcNv2L/YjUs4+C2g==
X-Google-Smtp-Source: AAOMgpdWxZe232UeSxo/h0PxzLYQk7L2G4YQhSaS7nJkxzdKOJwag/6XS+XtZCbMa+PmfJ0cc3JRJA==
X-Received: by 2002:a62:198e:: with SMTP id 136-v6mr8462603pfz.103.1531312694347;
        Wed, 11 Jul 2018 05:38:14 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id s8-v6sm41415783pfi.154.2018.07.11.05.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 05:38:13 -0700 (PDT)
Message-Id: <03d0907ec61f0ea53b59659c84b8a6662e9e7607.1531312689.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.8.git.gitgitgadget@gmail.com>
References: <pull.8.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Dec 2017 15:52:45 +0100
Subject: [PATCH 2/3] rebase --rebase-merges: add support for octopus merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Previously, we introduced the `merge` command for use in todo lists,
to allow to recreate and modify branch topology.

For ease of implementation, and to make review easier, the initial
implementation only supported merge commits with exactly two parents.

This patch adds support for octopus merges, making use of the
just-introduced `-F <file>` option for the `git merge` command: to keep
things simple, we spawn a new Git command instead of trying to call a
library function, also opening an easier door to enhance `rebase
--rebase-merges` to optionally use a merge strategy different from
`recursive` for regular merges: this feature would use the same code
path as octopus merges and simply spawn a `git merge`.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c              | 168 +++++++++++++++++++++++++++++----------
 t/t3430-rebase-merges.sh |  34 ++++++++
 2 files changed, 159 insertions(+), 43 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 5354d4d51..bcc43699c 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2841,6 +2841,26 @@ static int do_reset(const char *name, int len, struct replay_opts *opts)
 	return ret;
 }
 
+static struct commit *lookup_label(const char *label, int len,
+				   struct strbuf *buf)
+{
+	struct commit *commit;
+
+	strbuf_reset(buf);
+	strbuf_addf(buf, "refs/rewritten/%.*s", len, label);
+	commit = lookup_commit_reference_by_name(buf->buf);
+	if (!commit) {
+		/* fall back to non-rewritten ref or commit */
+		strbuf_splice(buf, 0, strlen("refs/rewritten/"), "", 0);
+		commit = lookup_commit_reference_by_name(buf->buf);
+	}
+
+	if (!commit)
+		error(_("could not resolve '%s'"), buf->buf);
+
+	return commit;
+}
+
 static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		    int flags, struct replay_opts *opts)
 {
@@ -2849,8 +2869,9 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct strbuf ref_name = STRBUF_INIT;
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *bases, *j, *reversed = NULL;
+	struct commit_list *to_merge = NULL, **tail = &to_merge;
 	struct merge_options o;
-	int merge_arg_len, oneline_offset, can_fast_forward, ret;
+	int merge_arg_len, oneline_offset, can_fast_forward, ret, k;
 	static struct lock_file lock;
 	const char *p;
 
@@ -2865,26 +2886,34 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		goto leave_merge;
 	}
 
-	oneline_offset = arg_len;
-	merge_arg_len = strcspn(arg, " \t\n");
-	p = arg + merge_arg_len;
-	p += strspn(p, " \t\n");
-	if (*p == '#' && (!p[1] || isspace(p[1]))) {
-		p += 1 + strspn(p + 1, " \t\n");
-		oneline_offset = p - arg;
-	} else if (p - arg < arg_len)
-		BUG("octopus merges are not supported yet: '%s'", p);
-
-	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
-	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
-	if (!merge_commit) {
-		/* fall back to non-rewritten ref or commit */
-		strbuf_splice(&ref_name, 0, strlen("refs/rewritten/"), "", 0);
-		merge_commit = lookup_commit_reference_by_name(ref_name.buf);
+	/*
+	 * For octopus merges, the arg starts with the list of revisions to be
+	 * merged. The list is optionally followed by '#' and the oneline.
+	 */
+	merge_arg_len = oneline_offset = arg_len;
+	for (p = arg; p - arg < arg_len; p += strspn(p, " \t\n")) {
+		if (!*p)
+			break;
+		if (*p == '#' && (!p[1] || isspace(p[1]))) {
+			p += 1 + strspn(p + 1, " \t\n");
+			oneline_offset = p - arg;
+			break;
+		}
+		k = strcspn(p, " \t\n");
+		if (!k)
+			continue;
+		merge_commit = lookup_label(p, k, &ref_name);
+		if (!merge_commit) {
+			ret = error(_("unable to parse '%.*s'"), k, p);
+			goto leave_merge;
+		}
+		tail = &commit_list_insert(merge_commit, tail)->next;
+		p += k;
+		merge_arg_len = p - arg;
 	}
 
-	if (!merge_commit) {
-		ret = error(_("could not resolve '%s'"), ref_name.buf);
+	if (!to_merge) {
+		ret = error(_("nothing to merge: '%.*s'"), arg_len, arg);
 		goto leave_merge;
 	}
 
@@ -2895,8 +2924,13 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		 * "[new root]", let's simply fast-forward to the merge head.
 		 */
 		rollback_lock_file(&lock);
-		ret = fast_forward_to(&merge_commit->object.oid,
-				       &head_commit->object.oid, 0, opts);
+		if (to_merge->next)
+			ret = error(_("octopus merge cannot be executed on "
+				      "top of a [new root]"));
+		else
+			ret = fast_forward_to(&to_merge->item->object.oid,
+					      &head_commit->object.oid, 0,
+					      opts);
 		goto leave_merge;
 	}
 
@@ -2932,7 +2966,8 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 			p = arg + oneline_offset;
 			len = arg_len - oneline_offset;
 		} else {
-			strbuf_addf(&buf, "Merge branch '%.*s'",
+			strbuf_addf(&buf, "Merge %s '%.*s'",
+				    to_merge->next ? "branches" : "branch",
 				    merge_arg_len, arg);
 			p = buf.buf;
 			len = buf.len;
@@ -2956,28 +2991,76 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 			&head_commit->object.oid);
 
 	/*
-	 * If the merge head is different from the original one, we cannot
+	 * If any merge head is different from the original one, we cannot
 	 * fast-forward.
 	 */
 	if (can_fast_forward) {
-		struct commit_list *second_parent = commit->parents->next;
+		struct commit_list *p = commit->parents->next;
 
-		if (second_parent && !second_parent->next &&
-		    oidcmp(&merge_commit->object.oid,
-			   &second_parent->item->object.oid))
+		for (j = to_merge; j && p; j = j->next, p = p->next)
+			if (oidcmp(&j->item->object.oid,
+				   &p->item->object.oid)) {
+				can_fast_forward = 0;
+				break;
+			}
+		/*
+		 * If the number of merge heads differs from the original merge
+		 * commit, we cannot fast-forward.
+		 */
+		if (j || p)
 			can_fast_forward = 0;
 	}
 
-	if (can_fast_forward && commit->parents->next &&
-	    !commit->parents->next->next &&
-	    !oidcmp(&commit->parents->next->item->object.oid,
-		    &merge_commit->object.oid)) {
+	if (can_fast_forward) {
 		rollback_lock_file(&lock);
 		ret = fast_forward_to(&commit->object.oid,
 				      &head_commit->object.oid, 0, opts);
 		goto leave_merge;
 	}
 
+	if (to_merge->next) {
+		/* Octopus merge */
+		struct child_process cmd = CHILD_PROCESS_INIT;
+
+		if (read_env_script(&cmd.env_array)) {
+			const char *gpg_opt = gpg_sign_opt_quoted(opts);
+
+			ret = error(_(staged_changes_advice), gpg_opt, gpg_opt);
+			goto leave_merge;
+		}
+
+		cmd.git_cmd = 1;
+		argv_array_push(&cmd.args, "merge");
+		argv_array_push(&cmd.args, "-s");
+		argv_array_push(&cmd.args, "octopus");
+		argv_array_push(&cmd.args, "--no-edit");
+		argv_array_push(&cmd.args, "--no-ff");
+		argv_array_push(&cmd.args, "--no-log");
+		argv_array_push(&cmd.args, "--no-stat");
+		argv_array_push(&cmd.args, "-F");
+		argv_array_push(&cmd.args, git_path_merge_msg());
+		if (opts->gpg_sign)
+			argv_array_push(&cmd.args, opts->gpg_sign);
+
+		/* Add the tips to be merged */
+		for (j = to_merge; j; j = j->next)
+			argv_array_push(&cmd.args,
+					oid_to_hex(&j->item->object.oid));
+
+		strbuf_release(&ref_name);
+		unlink(git_path_cherry_pick_head());
+		rollback_lock_file(&lock);
+
+		rollback_lock_file(&lock);
+		ret = run_command(&cmd);
+
+		/* force re-reading of the cache */
+		if (!ret && (discard_cache() < 0 || read_cache() < 0))
+			ret = error(_("could not read index"));
+		goto leave_merge;
+	}
+
+	merge_commit = to_merge->item;
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
@@ -3040,6 +3123,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 leave_merge:
 	strbuf_release(&ref_name);
 	rollback_lock_file(&lock);
+	free_commit_list(to_merge);
 	return ret;
 }
 
@@ -3877,7 +3961,6 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 	 */
 	while ((commit = get_revision(revs))) {
 		struct commit_list *to_merge;
-		int is_octopus;
 		const char *p1, *p2;
 		struct object_id *oid;
 		int is_empty;
@@ -3909,11 +3992,6 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 			continue;
 		}
 
-		is_octopus = to_merge && to_merge->next;
-
-		if (is_octopus)
-			BUG("Octopus merges not yet supported");
-
 		/* Create a label */
 		strbuf_reset(&label);
 		if (skip_prefix(oneline.buf, "Merge ", &p1) &&
@@ -3935,13 +4013,17 @@ static int make_script_with_merges(struct pretty_print_context *pp,
 		strbuf_addf(&buf, "%s -C %s",
 			    cmd_merge, oid_to_hex(&commit->object.oid));
 
-		/* label the tip of merged branch */
-		oid = &to_merge->item->object.oid;
-		strbuf_addch(&buf, ' ');
+		/* label the tips of merged branches */
+		for (; to_merge; to_merge = to_merge->next) {
+			oid = &to_merge->item->object.oid;
+			strbuf_addch(&buf, ' ');
+
+			if (!oidset_contains(&interesting, oid)) {
+				strbuf_addstr(&buf, label_oid(oid, NULL,
+							      &state));
+				continue;
+			}
 
-		if (!oidset_contains(&interesting, oid))
-			strbuf_addstr(&buf, label_oid(oid, NULL, &state));
-		else {
 			tips_tail = &commit_list_insert(to_merge->item,
 							tips_tail)->next;
 
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 78f7c9958..9e6229727 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -329,4 +329,38 @@ test_expect_success 'labels that are object IDs are rewritten' '
 	! grep "^label $third$" .git/ORIGINAL-TODO
 '
 
+test_expect_success 'octopus merges' '
+	git checkout -b three &&
+	test_commit before-octopus &&
+	test_commit three &&
+	git checkout -b two HEAD^ &&
+	test_commit two &&
+	git checkout -b one HEAD^ &&
+	test_commit one &&
+	test_tick &&
+	(GIT_AUTHOR_NAME="Hank" GIT_AUTHOR_EMAIL="hank@sea.world" \
+	 git merge -m "Tüntenfüsch" two three) &&
+
+	: fast forward if possible &&
+	before="$(git rev-parse --verify HEAD)" &&
+	test_tick &&
+	git rebase -i -r HEAD^^ &&
+	test_cmp_rev HEAD $before &&
+
+	test_tick &&
+	git rebase -i --force -r HEAD^^ &&
+	test "Hank" = "$(git show -s --format=%an HEAD)" &&
+	test "$before" != $(git rev-parse HEAD) &&
+	test_cmp_graph HEAD^^.. <<-\EOF
+	*-.   Tüntenfüsch
+	|\ \
+	| | * three
+	| * | two
+	| |/
+	* | one
+	|/
+	o before-octopus
+	EOF
+'
+
 test_done
-- 
gitgitgadget

