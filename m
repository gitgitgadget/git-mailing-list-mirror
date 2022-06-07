Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C6DC433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 02:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387533AbiFHCq4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 22:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383619AbiFHCiT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 22:38:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC0F1EEBBA
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:42:58 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h5so25745110wrb.0
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xQtPiRemFUH34jQg/iGfDV4TUzbqgs2eXYzQ8sn60ro=;
        b=mnX7L8pzp8BuviM7Lkn48l8zGSy4w8dIvP26Ngk0miIusyfkMuYdDKC4RqTCmp58+q
         qMf2SoDJx4ptVhO1v6Xmw6IPXztcZNR3bJun7306GQhXZm3maoNxI8ZYqH3HB/2bYtt7
         el+edaaB5G9z9JKw8xafyRkClZT1pK8X9/2UMIzlCeRfLWrZwNcQdqP6W5VWLgZpNSN0
         uPFzjNzuKvnJssaZg/AdSlunak4cOVUhQ6qV1t7IeLwwVjzRyuX0y8KYlb2/04FuRU4W
         XjY5kNgjazSASc/JRzJvIP5xvcvOhliKJkFxl5QKxltYwCbzW2WerQBu1Vse8Cs4aQzy
         /WWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xQtPiRemFUH34jQg/iGfDV4TUzbqgs2eXYzQ8sn60ro=;
        b=uDCt/QFs969hUBu3lnLL33/P0rj5s/8voCobJ+HgLjvcZ9us+xTfQJHKSWlWj8x1v/
         j/bajZImIUh9QxU6xrykyrojekFZXf7VbR+QB6a980sOxe7Yqh3KI0XK+DDCmC1CaXDF
         pkrQCmAhRW6dwBbi9PRVCAvkHTAEeVIAf7HotqULVq3RkL5b/wK2aJ7wp426YfaA4V2F
         MYE39oc0k/NAwJM31mtrRhyfmNEAamtXUaaVvb7tM+TxYF8SO0YNuhvpJSpBLz5twcjE
         Z76DKDZoTwLq2kJys0xDHYQ2Ee2ChVAXJTCuBAbhlw8BWtajBnpktTEbnTd2GKTSYvVm
         StYg==
X-Gm-Message-State: AOAM530qY6W1MFrYUfIKEs/+BHLMKCpO4NDlzDq5Wr9h12G/KxkBoWXr
        o7XUSSEAOnAeDPSMvj0A3N1FbWcWJp47yqiL
X-Google-Smtp-Source: ABdhPJw8tys9v27z5piuh/96ZKeoxLQj59QmORyc5YsSLLNxGnW94gbMhCrfy0ouwy0Y8bnaYSUCcA==
X-Received: by 2002:a5d:5581:0:b0:20f:fc51:7754 with SMTP id i1-20020a5d5581000000b0020ffc517754mr29317918wrv.413.1654634577008;
        Tue, 07 Jun 2022 13:42:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n13-20020a5d400d000000b0020ff7246934sm18932052wrp.95.2022.06.07.13.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:42:56 -0700 (PDT)
Message-Id: <0a4c110127b7628d3bc5b04534a4ea67fe46ef80.1654634569.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:42:47 +0000
Subject: [PATCH v2 5/7] rebase: add --update-refs option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When working on a large feature, it can be helpful to break that feature
into multiple smaller parts that become reviewed in sequence. During
development or during review, a change to one part of the feature could
affect multiple of these parts. An interactive rebase can help adjust
the multi-part "story" of the branch.

However, if there are branches tracking the different parts of the
feature, then rebasing the entire list of commits can create commits not
reachable from those "sub branches". It can take a manual step to update
those branches.

Add a new --update-refs option to 'git rebase -i' that adds 'label
for-update-refs/*' steps to the todo file whenever a commit that is
being rebased is decorated with that <ref>. At the very end, the
'update-refs' step is added to update all of the branches referenced by
the 'label' steps. This allows the user to rebase a long list of commits
in a multi-part feature and keep all of their pointers to those parts.

NOTE: This change only introduce the --update-refs option and implements
the changes to the todo file. It does _not_ yet implement the action
taken by the 'update-refs' todo step, which will be implemented and
tested in a later change.

Use the new for_each_decoration() while iterating over the existing todo
list. Be sure to iterate after any squashing or fixups are placed.
Update the branch only after those squashes and fixups are complete.
This allows a --fixup commit at the tip of the feature to apply
correctly to the sub branch, even if it is fixing up the most-recent
commit in that part.

One potential problem here is that refs decorating commits that are
already marked as "fixup!" or "squash!" will not be included in this
list. Generally, the reordering of the "fixup!" and "squash!" is likely
to change the relative order of these refs, so it is not recommended.
The workflow here is intended to allow these kinds of commits at the tip
of the rebased branch while the other sub branches come along for the
ride without intervention.

Be careful to not attempt updating any branch that is checked out. The
most common example is the branch being rebased is checked out and
decorates the tip commit. If the user is rebasing commits reachable from
a different branch that is checked out in a different worktree, then
they may be surprised to not see that ref update. However, it's probably
best to not optimize for this scenario and do the safest thing that will
result in a successful rebase. A comment is left in the TODO list that
signals that these refs are currently checked out.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-rebase.txt  |   8 +++
 builtin/rebase.c              |   5 ++
 sequencer.c                   | 105 ++++++++++++++++++++++++++++++++++
 sequencer.h                   |   1 +
 t/t3404-rebase-interactive.sh |  72 +++++++++++++++++++++++
 5 files changed, 191 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 262fb01aec0..e7611b4089c 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -609,6 +609,13 @@ provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
 start would be overridden by the presence of
 `rebase.rescheduleFailedExec=true` configuration.
 
+--update-refs::
+--no-update-refs::
+	Automatically force-update any branches that point to commits that
+	are being rebased. Any branches that are checked out in a worktree
+	or point to a `squash! ...` or `fixup! ...` commit are not updated
+	in this way.
+
 INCOMPATIBLE OPTIONS
 --------------------
 
@@ -632,6 +639,7 @@ are incompatible with the following options:
  * --empty=
  * --reapply-cherry-picks
  * --edit-todo
+ * --update-refs
  * --root when used in combination with --onto
 
 In addition, the following pairs of options are incompatible:
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7ab50cda2ad..56d82a52106 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -102,6 +102,7 @@ struct rebase_options {
 	int reschedule_failed_exec;
 	int reapply_cherry_picks;
 	int fork_point;
+	int update_refs;
 };
 
 #define REBASE_OPTIONS_INIT {			  	\
@@ -298,6 +299,7 @@ static int do_interactive_rebase(struct rebase_options *opts, unsigned flags)
 		ret = complete_action(the_repository, &replay, flags,
 			shortrevisions, opts->onto_name, opts->onto,
 			&opts->orig_head, &commands, opts->autosquash,
+			opts->update_refs,
 			&todo_list);
 	}
 
@@ -1124,6 +1126,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "autosquash", &options.autosquash,
 			 N_("move commits that begin with "
 			    "squash!/fixup! under -i")),
+		OPT_BOOL(0, "update-refs", &options.update_refs,
+			 N_("update local refs that point to commits "
+			    "that are being rebased")),
 		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
diff --git a/sequencer.c b/sequencer.c
index 68f7c76e896..94f8d52e041 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,8 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "branch.h"
+#include "log-tree.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -5614,10 +5616,110 @@ static int skip_unnecessary_picks(struct repository *r,
 	return 0;
 }
 
+struct todo_add_branch_context {
+	struct todo_item *items;
+	size_t items_nr;
+	size_t items_alloc;
+	struct strbuf *buf;
+	struct commit *commit;
+};
+
+static int add_branch_for_decoration(const struct name_decoration *d, void *data)
+{
+	struct todo_add_branch_context *ctx = data;
+	size_t base_offset = ctx->buf->len;
+	struct todo_item *item;
+	char *path;
+
+	ALLOC_GROW(ctx->items,
+		   ctx->items_nr + 1,
+		   ctx->items_alloc);
+	item = &ctx->items[ctx->items_nr];
+	memset(item, 0, sizeof(*item));
+
+	/* If the branch is checked out, then leave a comment instead. */
+	if (branch_checked_out(d->name, &path)) {
+		item->command = TODO_COMMENT;
+		strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
+			    d->name, path);
+		free(path);
+	} else {
+		item->command = TODO_LABEL;
+		strbuf_addf(ctx->buf, "for-update-refs/%s\n", d->name);
+	}
+
+	item->offset_in_buf = base_offset;
+	item->arg_offset = base_offset;
+	item->arg_len = ctx->buf->len - base_offset;
+	ctx->items_nr++;
+
+	return 0;
+}
+
+/*
+ * For each 'pick' command, find out if the commit has a decoration in
+ * refs/heads/. If so, then add a 'label for-update-refs/' command.
+ */
+static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
+{
+	int i;
+	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
+	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
+	struct decoration_filter decoration_filter = {
+		.include_ref_pattern = &decorate_refs_include,
+		.exclude_ref_pattern = &decorate_refs_exclude,
+		.exclude_ref_config_pattern = &decorate_refs_exclude_config
+	};
+	struct todo_add_branch_context ctx = {
+		.buf = &todo_list->buf,
+	};
+
+	ctx.items_alloc = 2 * todo_list->nr + 1;
+	ALLOC_ARRAY(ctx.items, ctx.items_alloc);
+
+	string_list_append(&decorate_refs_include, "refs/heads/");
+	load_ref_decorations(&decoration_filter, 0);
+
+	for (i = 0; i < todo_list->nr; ) {
+		struct todo_item *item = &todo_list->items[i];
+
+		/* insert ith item into new list */
+		ALLOC_GROW(ctx.items,
+			   ctx.items_nr + 1,
+			   ctx.items_alloc);
+
+		ctx.items[ctx.items_nr++] = todo_list->items[i++];
+
+		if (item->commit) {
+			ctx.commit = item->commit;
+			for_each_decoration(item->commit,
+					    add_branch_for_decoration,
+					    &ctx);
+		}
+	}
+
+	/* Add the "update-refs" step. */
+	ALLOC_GROW(ctx.items,
+		   ctx.items_nr + 1,
+		   ctx.items_alloc);
+	memset(&ctx.items[ctx.items_nr], 0, sizeof(struct todo_item));
+	ctx.items[ctx.items_nr].command = TODO_UPDATE_REFS;
+	ctx.items_nr++;
+
+	free(todo_list->items);
+	todo_list->items = ctx.items;
+	todo_list->nr = ctx.items_nr;
+	todo_list->alloc = ctx.items_alloc;
+
+	return 0;
+}
+
 int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
+		    unsigned update_refs,
 		    struct todo_list *todo_list)
 {
 	char shortonto[GIT_MAX_HEXSZ + 1];
@@ -5636,6 +5738,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
 	}
 
+	if (update_refs && todo_list_add_update_ref_commands(todo_list))
+		return -1;
+
 	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index c2b4e148d8f..e268208b315 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -167,6 +167,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
+		    unsigned update_refs,
 		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f31afd4a547..5e99ad7f3b6 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1743,6 +1743,78 @@ test_expect_success 'ORIG_HEAD is updated correctly' '
 	test_cmp_rev ORIG_HEAD test-orig-head@{1}
 '
 
+test_expect_success '--update-refs adds label and update-ref commands' '
+	git checkout -b update-refs no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git commit --allow-empty --fixup=third &&
+	git branch -f shared-tip &&
+	(
+		set_cat_todo_editor &&
+
+		cat >expect <<-EOF &&
+		pick $(git log -1 --format=%h J) J
+		label for-update-refs/refs/heads/second
+		label for-update-refs/refs/heads/first
+		pick $(git log -1 --format=%h K) K
+		pick $(git log -1 --format=%h L) L
+		fixup $(git log -1 --format=%h update-refs) fixup! L # empty
+		label for-update-refs/refs/heads/third
+		pick $(git log -1 --format=%h M) M
+		label for-update-refs/refs/heads/no-conflict-branch
+		label for-update-refs/refs/heads/shared-tip
+		update-refs
+		EOF
+
+		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
+		test_cmp expect todo
+	)
+'
+
+test_expect_success '--update-refs adds commands with --rebase-merges' '
+	git checkout -b update-refs-with-merge no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git merge -m merge branch2 &&
+	git branch -f merge-branch &&
+	git commit --fixup=third --allow-empty &&
+	(
+		set_cat_todo_editor &&
+
+		cat >expect <<-EOF &&
+		label onto
+		reset onto
+		pick $(git log -1 --format=%h branch2~1) F
+		pick $(git log -1 --format=%h branch2) I
+		label for-update-refs/refs/heads/branch2
+		label merge
+		reset onto
+		pick $(git log -1 --format=%h refs/heads/second) J
+		label for-update-refs/refs/heads/second
+		label for-update-refs/refs/heads/first
+		pick $(git log -1 --format=%h refs/heads/third~1) K
+		pick $(git log -1 --format=%h refs/heads/third) L
+		fixup $(git log -1 --format=%h update-refs-with-merge) fixup! L # empty
+		label for-update-refs/refs/heads/third
+		pick $(git log -1 --format=%h HEAD~2) M
+		label for-update-refs/refs/heads/no-conflict-branch
+		merge -C $(git log -1 --format=%h HEAD~1) merge # merge
+		label for-update-refs/refs/heads/merge-branch
+		update-refs
+		EOF
+
+		test_must_fail git rebase -i --autosquash \
+				   --rebase-merges=rebase-cousins \
+				   --update-refs primary >todo &&
+
+		test_cmp expect todo
+	)
+'
+
 # This must be the last test in this file
 test_expect_success '$EDITOR and friends are unchanged' '
 	test_editor_unchanged
-- 
gitgitgadget

