Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31571C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 18:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbiGSSeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 14:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbiGSSeD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 14:34:03 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A905D0FC
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:58 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b26so22901731wrc.2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 11:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d2alAGjm6XY/IG1pZg1O0bdr//qmjzwUkJAmNJViH8A=;
        b=RAOBX6AsouTTGGupTG9mWB5y/0vL3kcFKb39jozbeoVWJKFXFRzhojNaKR2MEvCiaQ
         1RFpeD4a2RnE5i1KjcV5lJi4TvH7eI77H5gpw56vX09tCE0W+cFp3U0l55D2/V3bamUY
         bUO6pg/H3dBuNWwQjFCW0LQ16N0e8Kz6HWlDY0XWDLOsr9xYzJssaClfnLhEkee/sT0/
         d0lawQgrDbcoX6g4ac9NezkDMoW150rQuuNYbldOcHAlBS3XgcX+v2riMyc+w7uJROF0
         uPllIzXN8JWuK8TSvC6fw2anHDyvYhM7oq5wvHmXdhTawUMF7Hm2Wlc32rApFKYAYkLx
         V+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d2alAGjm6XY/IG1pZg1O0bdr//qmjzwUkJAmNJViH8A=;
        b=PnPG9Afbp2X/2MZFQ5Bm3RuCWMn1f9hU05qxBbyQk42zmD9mj65zDdNeCTUy1BSA85
         7Vr41Z3CUqjkPI8UagL/cR2Ed2fbY8D3ULy287uIRSb2eZahgz4tlP7jx8sn426BBvur
         /KtrWCWgTkaxYI+NjDBmzZwUWAEcWJFQ7tQ7CaaWxPWiCiaOAXuEWsaX4G0BF1hfvWOn
         5h7velPjDe6De5ZN/ydDV/SVr5439SXLgrcmVHsadIkFyHp9oZb9itBHbm2IoujW701u
         pfE9TxdD8xmi/AoFiKatZWbT41d/h+ipIQ+g3Rs53le+titzPf6vC5nwP+HPrTg5DcmC
         s6VA==
X-Gm-Message-State: AJIora/FyFck/2htwyjFOdkT4pX20rmyVXUgB5oi7mmiDhXMUx0vPLl9
        spjapG3bSmmBuZ1VjHQK1wTM+yRiuIs=
X-Google-Smtp-Source: AGRyM1vdX3Z6wi3WXCcuQJZ2kNYDdGpXcwhXPoYDdD9MpB793FHAnhottB2FuQPWIZOPXByIJuyxxA==
X-Received: by 2002:a5d:4689:0:b0:21e:477c:bb9e with SMTP id u9-20020a5d4689000000b0021e477cbb9emr633840wrq.517.1658255636278;
        Tue, 19 Jul 2022 11:33:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16-20020adff1d0000000b0021d65675583sm13940720wro.52.2022.07.19.11.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 11:33:55 -0700 (PDT)
Message-Id: <7efb55e4f1429bd8a3673171d4ddf05470e7b21a.1658255624.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
        <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 19 Jul 2022 18:33:39 +0000
Subject: [PATCH v5 07/12] rebase: add --update-refs option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
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

Add a new --update-refs option to 'git rebase -i' that adds 'update-ref
<ref>' steps to the todo file whenever a commit that is being rebased is
decorated with that <ref>. At the very end, the rebase process updates
all of the listed refs to the values stored during the rebase operation.

Be sure to iterate after any squashing or fixups are placed. Update the
branch only after those squashes and fixups are complete. This allows a
--fixup commit at the tip of the feature to apply correctly to the sub
branch, even if it is fixing up the most-recent commit in that part.

This change update the documentation and builtin to accept the
--update-refs option as well as updating the todo file with the
'update-ref' commands. Tests are added to ensure that these todo
commands are added in the correct locations.

This change does _not_ include the actual behavior of tracking the
updated refs and writing the new ref values at the end of the rebase
process. That is deferred to a later change.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-rebase.txt  |   7 +++
 builtin/rebase.c              |   5 ++
 sequencer.c                   | 107 ++++++++++++++++++++++++++++++++++
 sequencer.h                   |   1 +
 t/t2407-worktree-heads.sh     |  22 +++++++
 t/t3404-rebase-interactive.sh |  74 +++++++++++++++++++++++
 6 files changed, 216 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 262fb01aec0..dfd847d6615 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -609,6 +609,12 @@ provided. Otherwise an explicit `--no-reschedule-failed-exec` at the
 start would be overridden by the presence of
 `rebase.rescheduleFailedExec=true` configuration.
 
+--update-refs::
+--no-update-refs::
+	Automatically force-update any branches that point to commits that
+	are being rebased. Any branches that are checked out in a worktree
+	are not updated in this way.
+
 INCOMPATIBLE OPTIONS
 --------------------
 
@@ -632,6 +638,7 @@ are incompatible with the following options:
  * --empty=
  * --reapply-cherry-picks
  * --edit-todo
+ * --update-refs
  * --root when used in combination with --onto
 
 In addition, the following pairs of options are incompatible:
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7ab50cda2ad..fd64897132a 100644
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
+			 N_("update branches that point to commits "
+			    "that are being rebased")),
 		{ OPTION_STRING, 'S', "gpg-sign", &gpg_sign, N_("key-id"),
 			N_("GPG-sign commits"),
 			PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
diff --git a/sequencer.c b/sequencer.c
index 0dc9c05c5bb..a4ee2799d6f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -35,6 +35,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "branch.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -5638,10 +5639,113 @@ static int skip_unnecessary_picks(struct repository *r,
 	return 0;
 }
 
+struct todo_add_branch_context {
+	struct todo_item *items;
+	size_t items_nr;
+	size_t items_alloc;
+	struct strbuf *buf;
+	struct commit *commit;
+	struct string_list refs_to_oids;
+};
+
+static int add_decorations_to_list(const struct commit *commit,
+				   struct todo_add_branch_context *ctx)
+{
+	const struct name_decoration *decoration = get_name_decoration(&commit->object);
+
+	while (decoration) {
+		struct todo_item *item;
+		const char *path;
+		size_t base_offset = ctx->buf->len;
+
+		ALLOC_GROW(ctx->items,
+			ctx->items_nr + 1,
+			ctx->items_alloc);
+		item = &ctx->items[ctx->items_nr];
+		memset(item, 0, sizeof(*item));
+
+		/* If the branch is checked out, then leave a comment instead. */
+		if ((path = branch_checked_out(decoration->name))) {
+			item->command = TODO_COMMENT;
+			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
+				    decoration->name, path);
+		} else {
+			struct string_list_item *sti;
+			item->command = TODO_UPDATE_REF;
+			strbuf_addf(ctx->buf, "%s\n", decoration->name);
+
+			sti = string_list_insert(&ctx->refs_to_oids,
+						 decoration->name);
+			sti->util = oiddup(the_hash_algo->null_oid);
+		}
+
+		item->offset_in_buf = base_offset;
+		item->arg_offset = base_offset;
+		item->arg_len = ctx->buf->len - base_offset;
+		ctx->items_nr++;
+
+		decoration = decoration->next;
+	}
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
+		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
+	};
+	struct todo_add_branch_context ctx = {
+		.buf = &todo_list->buf,
+		.refs_to_oids = STRING_LIST_INIT_DUP,
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
+			add_decorations_to_list(item->commit, &ctx);
+		}
+	}
+
+	string_list_clear(&ctx.refs_to_oids, 1);
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
@@ -5660,6 +5764,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
 	}
 
+	if (update_refs && todo_list_add_update_ref_commands(todo_list))
+		return -1;
+
 	if (autosquash && todo_list_rearrange_squash(todo_list))
 		return -1;
 
diff --git a/sequencer.h b/sequencer.h
index 2cf5c1b9a38..e671d7e0743 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -167,6 +167,7 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
 		    const char *shortrevisions, const char *onto_name,
 		    struct commit *onto, const struct object_id *orig_head,
 		    struct string_list *commands, unsigned autosquash,
+		    unsigned update_refs,
 		    struct todo_list *todo_list);
 int todo_list_rearrange_squash(struct todo_list *todo_list);
 
diff --git a/t/t2407-worktree-heads.sh b/t/t2407-worktree-heads.sh
index 97f5c87f8c8..8a03f14df8d 100755
--- a/t/t2407-worktree-heads.sh
+++ b/t/t2407-worktree-heads.sh
@@ -164,4 +164,26 @@ test_expect_success 'refuse to overwrite when in error states' '
 	done
 '
 
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+test_expect_success !SANITIZE_LEAK 'refuse to overwrite during rebase with --update-refs' '
+	git commit --fixup HEAD~2 --allow-empty &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
+		! grep "update-refs" todo
+	) &&
+	git branch -f allow-update HEAD~2 &&
+	(
+		set_cat_todo_editor &&
+		test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
+		grep "update-ref refs/heads/allow-update" todo
+	)
+'
+
+# This must be the last test in this file
+test_expect_success '$EDITOR and friends are unchanged' '
+	test_editor_unchanged
+'
+
 test_done
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index f31afd4a547..75c0b90fae1 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1743,6 +1743,80 @@ test_expect_success 'ORIG_HEAD is updated correctly' '
 	test_cmp_rev ORIG_HEAD test-orig-head@{1}
 '
 
+test_expect_success '--update-refs adds label and update-ref commands' '
+	git checkout -b update-refs no-conflict-branch &&
+	git branch -f base HEAD~4 &&
+	git branch -f first HEAD~3 &&
+	git branch -f second HEAD~3 &&
+	git branch -f third HEAD~1 &&
+	git commit --allow-empty --fixup=third &&
+	git branch -f is-not-reordered &&
+	git commit --allow-empty --fixup=HEAD~4 &&
+	git branch -f shared-tip &&
+	(
+		set_cat_todo_editor &&
+
+		cat >expect <<-EOF &&
+		pick $(git log -1 --format=%h J) J
+		fixup $(git log -1 --format=%h update-refs) fixup! J # empty
+		update-ref refs/heads/second
+		update-ref refs/heads/first
+		pick $(git log -1 --format=%h K) K
+		pick $(git log -1 --format=%h L) L
+		fixup $(git log -1 --format=%h is-not-reordered) fixup! L # empty
+		update-ref refs/heads/third
+		pick $(git log -1 --format=%h M) M
+		update-ref refs/heads/no-conflict-branch
+		update-ref refs/heads/is-not-reordered
+		update-ref refs/heads/shared-tip
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
+		update-ref refs/heads/branch2
+		label merge
+		reset onto
+		pick $(git log -1 --format=%h refs/heads/second) J
+		update-ref refs/heads/second
+		update-ref refs/heads/first
+		pick $(git log -1 --format=%h refs/heads/third~1) K
+		pick $(git log -1 --format=%h refs/heads/third) L
+		fixup $(git log -1 --format=%h update-refs-with-merge) fixup! L # empty
+		update-ref refs/heads/third
+		pick $(git log -1 --format=%h HEAD~2) M
+		update-ref refs/heads/no-conflict-branch
+		merge -C $(git log -1 --format=%h HEAD~1) merge # merge
+		update-ref refs/heads/merge-branch
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

