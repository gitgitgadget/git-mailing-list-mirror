Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6375CCA47C
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:27:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiFHA1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839420AbiFHADK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 20:03:10 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 449BE1EEB88
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:42:53 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m39-20020a05600c3b2700b0039c511ebbacso3307226wms.3
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hLB6fqmsCA3Au8H5UhVF+sZqjbBcyX451OeiDZIUoGo=;
        b=bpVS3ZJ9TZeGjGtTmSepUybGxWL6yJJMfhAPfT2aetYG0gWGaHMjyFH8HUbW0i4Ax9
         ZWsH8F9z07Out/qrvddQiLcX0fW6GoDyc3T8K+1rxAnfniBpZJsyB81uV6E5rpHnNN8S
         hC0+O0bTrYFMuoA7rv0Jc3w2kQCBA3I0dS7MiIkbllvmR5MYUuRxpsS52pC4jg9Jf2w/
         uHQEbJNu/s/E6vfi0A0xjFbJ5/Wxpe+DbkUDIX7u95fkzxW1mPf+5nMrOUlyOfxueWez
         P7pAoLfjQP/uvwXO5BSbt5GNFEvyvTEufpA0y1R/NsEorAkC6Wf3Fg/68EFvUTgUQNNy
         vtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hLB6fqmsCA3Au8H5UhVF+sZqjbBcyX451OeiDZIUoGo=;
        b=rGW6LYiTDonWz5d79dCESUClZBuuRq8ncOsBo05Y+EH0AKPwxx8KTbugxYiRhI3ubs
         7L9HNEaWQroHh+AxFLLD3tQmhOn/Vb+dLQboyo48jssJmRzvW3DyNiQoBa6d/jRoGmDs
         9W/IWoYjuIM17RQA9EiYvfmPGTz6sfo9ZPytYnQsGlDhTGned4DjD/Yvkh2pZmnlk5k7
         wvernCMZetoOqh+SonYclubA8iXPeSxZ152t7AKN3mhJ2uW1NBeW0Ierug6Oq6fai2Sr
         w9PvmKgFiJk6VCL49gHOy709C4UvAcEGkDGM42S8LDYTt9LqYucbNbM04TEvdkRyu7OZ
         jyBQ==
X-Gm-Message-State: AOAM533BAmBI/Znu3GdhjZ+NaZKQUaRRTMUOi6uNWPv8pCVn6vdgM+Zv
        zafjGn9g3K5gSzCeBIyeyWok+cBeQIpYbRQt
X-Google-Smtp-Source: ABdhPJyXVMeVTlKgp5nHPLU1+F7qKm3QpZ+IvUrZdiU68U9uzoT1hoptcIWfcbr2W4Dr7i3KG0YcyA==
X-Received: by 2002:a05:600c:3caa:b0:394:8fb8:716 with SMTP id bg42-20020a05600c3caa00b003948fb80716mr59379857wmb.105.1654634571066;
        Tue, 07 Jun 2022 13:42:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d4309000000b002102af52a2csm23724527wrq.9.2022.06.07.13.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:42:50 -0700 (PDT)
Message-Id: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
In-Reply-To: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Jun 2022 20:42:42 +0000
Subject: [PATCH v2 0/7] rebase: update branches in multi-part topic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a feature I've wanted for quite a while. When working on the sparse
index topic, I created a long RFC that actually broke into three topics for
full review upstream. These topics were sequential, so any feedback on an
earlier one required updates to the later ones. I would work on the full
feature and use interactive rebase to update the full list of commits.
However, I would need to update the branches pointing to those sub-topics.

This series adds a new --update-refs option to 'git rebase' (along with a
rebase.updateRefs config option) that adds 'label' and 'update-refs'
commands into the TODO list. This is powered by the commit decoration
machinery.

As an example, here is my in-progress bundle URI RFC split into subtopics as
they appear during the TODO list of a git rebase -i --update-refs:

pick 2d966282ff3 docs: document bundle URI standard
pick 31396e9171a remote-curl: add 'get' capability
pick 54c6ab70f67 bundle-uri: create basic file-copy logic
pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
pick 6adaf842684 fetch: add --bundle-uri option
pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
label for-update-refs/refs/heads/bundle-redo/fetch

pick 1e3f6546632 clone: add --bundle-uri option
pick 9e4a6fe9b68 clone: --bundle-uri cannot be combined with --depth
label for-update-refs/refs/heads/bundle-redo/clone

pick 5451cb6599c bundle-uri: create bundle_list struct and helpers
pick 3029c3aca15 bundle-uri: create base key-value pair parsing
pick a8b2de79ce8 bundle-uri: create "key=value" line parsing
pick 92625a47673 bundle-uri: unit test "key=value" parsing
pick a8616af4dc2 bundle-uri: limit recursion depth for bundle lists
pick 9d6809a8d53 bundle-uri: parse bundle list in config format
pick 287a732b54c bundle-uri: fetch a list of bundles
label for-update-refs/refs/heads/bundle-redo/list

pick b09f8226185 protocol v2: add server-side "bundle-uri" skeleton
pick 520204dcd1c bundle-uri client: add minimal NOOP client
pick 62e8b457b48 bundle-uri client: add "git ls-remote-bundle-uri"
pick 00eae925043 bundle-uri: serve URI advertisement from bundle.* config
pick 4277440a250 bundle-uri client: add boolean transfer.bundleURI setting
pick caf4599a81d bundle-uri: allow relative URLs in bundle lists
pick df255000b7e bundle-uri: download bundles from an advertised list
pick d71beabf199 clone: unbundle the advertised bundles
pick c9578391976 t5601: basic bundle URI tests
# Ref refs/heads/bundle-redo/rfc-3 checked out at '/home/stolee/_git/git-bundles'

label for-update-refs/refs/heads/bundle-redo/advertise

update-refs


 * Patches 1-2 are basic refactors that we will need for our implementation.
 * Patch 3 is a cleanup of an array with indexes given by the todo_command
   enum.
 * Patches 4-6 implement the feature incrementally. For instance, we can
   test the edits to the TODO file in patch 5, but we don't actually do
   anything when seeing the 'update-refs' command until patch 6.
 * Patch 7 adds the rebase.updateRefs config option similar to
   rebase.autoSquash.


Updates in v2
=============

As recommended by the excellent feedback, I have removed the 'exec' commands
in favor of the 'label' commands and a new 'update-refs' command at the very
end. This way, there is only one step that updates all of the refs at the
end instead of updating refs during the rebase. If a user runs 'git rebase
--abort' in the middle, then their refs are still where they need to be.

Based on some of the discussion, it seemed like one way to do this would be
to have an 'update-ref ' command that would take the place of these 'label'
commands. However, this would require two things that make it a bit awkward:

 1. We would need to replicate the storage of those positions during the
    rebase. 'label' already does this pretty well. I've added the
    "for-update-refs/" label to help here.
 2. If we want to close out all of the refs as the rebase is finishing, then
    that "step" becomes invisible to the user (and a bit more complicated to
    insert). Thus, the 'update-refs' step performs this action. If the user
    wants to do things after that step, then they can do so by editing the
    TODO list.

Other updates:

 * The 'keep_decorations' parameter was renamed to 'update_refs'.
 * I added tests for --rebase-merges=rebase-cousins to show how these labels
   interact with other labels and merge commands.
 * I changed the order of the insertion of these update-refs labels to be
   before the fixups are rearranged. This fixes a bug where the tip commit
   is a fixup! so its decorations are never inspected (and they would be in
   the wrong place even if they were). The fixup! commands are properly
   inserted between a pick and its following label command. Tests
   demonstrate this is correct.
 * Numerous style choices are updated based on feedback.

Thank you for all of the detailed review and ideas in this space. I
appreciate any more ideas that can make this feature as effective as it can
be.

Thanks, -Stolee

Derrick Stolee (7):
  log-tree: create for_each_decoration()
  branch: add branch_checked_out() helper
  sequencer: define array with enum values
  sequencer: add update-refs command
  rebase: add --update-refs option
  sequencer: implement 'update-refs' command
  rebase: add rebase.updateRefs config option

 Documentation/config/rebase.txt |   3 +
 Documentation/git-rebase.txt    |  12 ++
 branch.c                        |  24 ++--
 branch.h                        |   8 ++
 builtin/rebase.c                |  10 ++
 log-tree.c                      | 111 +++++++++++------
 log-tree.h                      |   4 +
 sequencer.c                     | 206 +++++++++++++++++++++++++++++---
 sequencer.h                     |   2 +
 t/t3404-rebase-interactive.sh   | 110 +++++++++++++++++
 10 files changed, 432 insertions(+), 58 deletions(-)


base-commit: 2668e3608e47494f2f10ef2b6e69f08a84816bcb
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1247%2Fderrickstolee%2Frebase-keep-decorations-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1247/derrickstolee/rebase-keep-decorations-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1247

Range-diff vs v1:

 1:  4f9f3487641 = 1:  4f9f3487641 log-tree: create for_each_decoration()
 2:  5f54766e103 = 2:  5f54766e103 branch: add branch_checked_out() helper
 -:  ----------- > 3:  9f261c7df2c sequencer: define array with enum values
 -:  ----------- > 4:  842b2186d25 sequencer: add update-refs command
 3:  23fa6638864 ! 5:  0a4c110127b rebase: add --update-refs option
     @@ Commit message
          reachable from those "sub branches". It can take a manual step to update
          those branches.
      
     -    Add a new --update-refs option to 'git rebase -i' that adds 'git
     -    update-ref' exec steps to the todo file whenever a commit that is being
     -    rebased is decorated with that <ref>. This allows the user to rebase a
     -    long list of commits in a multi-part feature and keep all of their
     -    pointers to those parts.
     +    Add a new --update-refs option to 'git rebase -i' that adds 'label
     +    for-update-refs/*' steps to the todo file whenever a commit that is
     +    being rebased is decorated with that <ref>. At the very end, the
     +    'update-refs' step is added to update all of the branches referenced by
     +    the 'label' steps. This allows the user to rebase a long list of commits
     +    in a multi-part feature and keep all of their pointers to those parts.
     +
     +    NOTE: This change only introduce the --update-refs option and implements
     +    the changes to the todo file. It does _not_ yet implement the action
     +    taken by the 'update-refs' todo step, which will be implemented and
     +    tested in a later change.
      
          Use the new for_each_decoration() while iterating over the existing todo
          list. Be sure to iterate after any squashing or fixups are placed.
     @@ Documentation/git-rebase.txt: provided. Otherwise an explicit `--no-reschedule-f
       INCOMPATIBLE OPTIONS
       --------------------
       
     +@@ Documentation/git-rebase.txt: are incompatible with the following options:
     +  * --empty=
     +  * --reapply-cherry-picks
     +  * --edit-todo
     ++ * --update-refs
     +  * --root when used in combination with --onto
     + 
     + In addition, the following pairs of options are incompatible:
      
       ## builtin/rebase.c ##
      @@ builtin/rebase.c: struct rebase_options {
     @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
       }
       
      +struct todo_add_branch_context {
     -+	struct todo_list new_list;
     ++	struct todo_item *items;
     ++	size_t items_nr;
     ++	size_t items_alloc;
      +	struct strbuf *buf;
      +	struct commit *commit;
      +};
     @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
      +{
      +	struct todo_add_branch_context *ctx = data;
      +	size_t base_offset = ctx->buf->len;
     -+	int i = ctx->new_list.nr;
      +	struct todo_item *item;
      +	char *path;
      +
     -+	ALLOC_GROW(ctx->new_list.items,
     -+		   ctx->new_list.nr + 1,
     -+		   ctx->new_list.alloc);
     -+	item = &ctx->new_list.items[i];
     ++	ALLOC_GROW(ctx->items,
     ++		   ctx->items_nr + 1,
     ++		   ctx->items_alloc);
     ++	item = &ctx->items[ctx->items_nr];
     ++	memset(item, 0, sizeof(*item));
      +
      +	/* If the branch is checked out, then leave a comment instead. */
      +	if (branch_checked_out(d->name, &path)) {
     @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
      +			    d->name, path);
      +		free(path);
      +	} else {
     -+		item->command = TODO_EXEC;
     -+		strbuf_addf(ctx->buf, "git update-ref %s HEAD %s\n",
     -+			    d->name, oid_to_hex(&ctx->commit->object.oid));
     ++		item->command = TODO_LABEL;
     ++		strbuf_addf(ctx->buf, "for-update-refs/%s\n", d->name);
      +	}
      +
     -+	item->commit = NULL;
      +	item->offset_in_buf = base_offset;
      +	item->arg_offset = base_offset;
      +	item->arg_len = ctx->buf->len - base_offset;
     -+	ctx->new_list.nr++;
     ++	ctx->items_nr++;
      +
      +	return 0;
      +}
      +
      +/*
      + * For each 'pick' command, find out if the commit has a decoration in
     -+ * refs/heads/. If so, then add a 'git branch -f' exec command after
     -+ * that 'pick' (plus any following 'squash' or 'fixup' commands).
     ++ * refs/heads/. If so, then add a 'label for-update-refs/' command.
      + */
     -+static int todo_list_add_branch_commands(struct todo_list *todo_list)
     ++static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
      +{
      +	int i;
      +	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
     @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
      +		.exclude_ref_config_pattern = &decorate_refs_exclude_config
      +	};
      +	struct todo_add_branch_context ctx = {
     -+		.new_list = TODO_LIST_INIT,
      +		.buf = &todo_list->buf,
      +	};
      +
     ++	ctx.items_alloc = 2 * todo_list->nr + 1;
     ++	ALLOC_ARRAY(ctx.items, ctx.items_alloc);
     ++
      +	string_list_append(&decorate_refs_include, "refs/heads/");
      +	load_ref_decorations(&decoration_filter, 0);
      +
      +	for (i = 0; i < todo_list->nr; ) {
      +		struct todo_item *item = &todo_list->items[i];
      +
     -+		do {
     -+			/* insert ith item into new list */
     -+			ALLOC_GROW(ctx.new_list.items,
     -+				   ctx.new_list.nr + 1,
     -+				   ctx.new_list.alloc);
     ++		/* insert ith item into new list */
     ++		ALLOC_GROW(ctx.items,
     ++			   ctx.items_nr + 1,
     ++			   ctx.items_alloc);
      +
     -+			memcpy(&ctx.new_list.items[ctx.new_list.nr++],
     -+			       &todo_list->items[i],
     -+			       sizeof(struct todo_item));
     ++		ctx.items[ctx.items_nr++] = todo_list->items[i++];
      +
     -+			i++;
     -+		} while (i < todo_list->nr &&
     -+			 todo_list->items[i].command != TODO_PICK);
     -+
     -+		ctx.commit = item->commit;
     -+		for_each_decoration(item->commit, add_branch_for_decoration, &ctx);
     ++		if (item->commit) {
     ++			ctx.commit = item->commit;
     ++			for_each_decoration(item->commit,
     ++					    add_branch_for_decoration,
     ++					    &ctx);
     ++		}
      +	}
      +
     ++	/* Add the "update-refs" step. */
     ++	ALLOC_GROW(ctx.items,
     ++		   ctx.items_nr + 1,
     ++		   ctx.items_alloc);
     ++	memset(&ctx.items[ctx.items_nr], 0, sizeof(struct todo_item));
     ++	ctx.items[ctx.items_nr].command = TODO_UPDATE_REFS;
     ++	ctx.items_nr++;
     ++
      +	free(todo_list->items);
     -+	todo_list->items = ctx.new_list.items;
     -+	todo_list->nr = ctx.new_list.nr;
     -+	todo_list->alloc = ctx.new_list.alloc;
     ++	todo_list->items = ctx.items;
     ++	todo_list->nr = ctx.items_nr;
     ++	todo_list->alloc = ctx.items_alloc;
      +
      +	return 0;
      +}
     @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
       		    const char *shortrevisions, const char *onto_name,
       		    struct commit *onto, const struct object_id *orig_head,
       		    struct string_list *commands, unsigned autosquash,
     -+		    unsigned keep_decorations,
     ++		    unsigned update_refs,
       		    struct todo_list *todo_list)
       {
       	char shortonto[GIT_MAX_HEXSZ + 1];
      @@ sequencer.c: int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
     - 	if (autosquash && todo_list_rearrange_squash(todo_list))
     - 		return -1;
     + 		item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
     + 	}
       
     -+	if (keep_decorations && todo_list_add_branch_commands(todo_list))
     ++	if (update_refs && todo_list_add_update_ref_commands(todo_list))
      +		return -1;
      +
     - 	if (commands->nr)
     - 		todo_list_add_exec_commands(todo_list, commands);
     + 	if (autosquash && todo_list_rearrange_squash(todo_list))
     + 		return -1;
       
      
       ## sequencer.h ##
     @@ sequencer.h: int complete_action(struct repository *r, struct replay_opts *opts,
       		    const char *shortrevisions, const char *onto_name,
       		    struct commit *onto, const struct object_id *orig_head,
       		    struct string_list *commands, unsigned autosquash,
     -+		    unsigned keep_decorations,
     ++		    unsigned update_refs,
       		    struct todo_list *todo_list);
       int todo_list_rearrange_squash(struct todo_list *todo_list);
       
     @@ t/t3404-rebase-interactive.sh: test_expect_success 'ORIG_HEAD is updated correct
       	test_cmp_rev ORIG_HEAD test-orig-head@{1}
       '
       
     -+test_expect_success '--update-refs adds git branch commands' '
     ++test_expect_success '--update-refs adds label and update-ref commands' '
      +	git checkout -b update-refs no-conflict-branch &&
     -+	test_commit extra fileX &&
     -+	git commit --amend --fixup=L &&
     ++	git branch -f base HEAD~4 &&
     ++	git branch -f first HEAD~3 &&
     ++	git branch -f second HEAD~3 &&
     ++	git branch -f third HEAD~1 &&
     ++	git commit --allow-empty --fixup=third &&
     ++	git branch -f shared-tip &&
      +	(
      +		set_cat_todo_editor &&
     -+		git branch -f base A &&
     -+		git branch -f first J &&
     -+		git branch -f second J &&
     -+		git branch -f third L &&
     -+
     -+		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
      +
      +		cat >expect <<-EOF &&
      +		pick $(git log -1 --format=%h J) J
     -+		exec git update-ref refs/heads/second HEAD $(git rev-parse J)
     -+		exec git update-ref refs/heads/first HEAD $(git rev-parse  J)
     ++		label for-update-refs/refs/heads/second
     ++		label for-update-refs/refs/heads/first
      +		pick $(git log -1 --format=%h K) K
      +		pick $(git log -1 --format=%h L) L
     -+		fixup $(git log -1 --format=%h update-refs) fixup! L
     -+		exec git update-ref refs/heads/third HEAD $(git rev-parse L)
     ++		fixup $(git log -1 --format=%h update-refs) fixup! L # empty
     ++		label for-update-refs/refs/heads/third
      +		pick $(git log -1 --format=%h M) M
     -+		exec git update-ref refs/heads/no-conflict-branch HEAD $(git rev-parse M)
     ++		label for-update-refs/refs/heads/no-conflict-branch
     ++		label for-update-refs/refs/heads/shared-tip
     ++		update-refs
      +		EOF
      +
     ++		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
     ++		test_cmp expect todo
     ++	)
     ++'
     ++
     ++test_expect_success '--update-refs adds commands with --rebase-merges' '
     ++	git checkout -b update-refs-with-merge no-conflict-branch &&
     ++	git branch -f base HEAD~4 &&
     ++	git branch -f first HEAD~3 &&
     ++	git branch -f second HEAD~3 &&
     ++	git branch -f third HEAD~1 &&
     ++	git merge -m merge branch2 &&
     ++	git branch -f merge-branch &&
     ++	git commit --fixup=third --allow-empty &&
     ++	(
     ++		set_cat_todo_editor &&
     ++
     ++		cat >expect <<-EOF &&
     ++		label onto
     ++		reset onto
     ++		pick $(git log -1 --format=%h branch2~1) F
     ++		pick $(git log -1 --format=%h branch2) I
     ++		label for-update-refs/refs/heads/branch2
     ++		label merge
     ++		reset onto
     ++		pick $(git log -1 --format=%h refs/heads/second) J
     ++		label for-update-refs/refs/heads/second
     ++		label for-update-refs/refs/heads/first
     ++		pick $(git log -1 --format=%h refs/heads/third~1) K
     ++		pick $(git log -1 --format=%h refs/heads/third) L
     ++		fixup $(git log -1 --format=%h update-refs-with-merge) fixup! L # empty
     ++		label for-update-refs/refs/heads/third
     ++		pick $(git log -1 --format=%h HEAD~2) M
     ++		label for-update-refs/refs/heads/no-conflict-branch
     ++		merge -C $(git log -1 --format=%h HEAD~1) merge # merge
     ++		label for-update-refs/refs/heads/merge-branch
     ++		update-refs
     ++		EOF
     ++
     ++		test_must_fail git rebase -i --autosquash \
     ++				   --rebase-merges=rebase-cousins \
     ++				   --update-refs primary >todo &&
     ++
      +		test_cmp expect todo
      +	)
      +'
 -:  ----------- > 6:  68f8e51b19c sequencer: implement 'update-refs' command
 4:  b99c5bf34ef ! 7:  3d7d3f656b4 rebase: add rebase.updateRefs config option
     @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
       		return 0;
      
       ## t/t3404-rebase-interactive.sh ##
     -@@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs adds git branch commands' '
     - 		exec git update-ref refs/heads/no-conflict-branch HEAD $(git rev-parse M)
     +@@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs adds label and update-ref commands' '
       		EOF
       
     + 		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
      +		test_cmp expect todo &&
      +
      +		test_must_fail git -c rebase.autosquash=true \
      +				   -c rebase.updaterefs=true \
      +				   rebase -i primary >todo &&
     ++
     + 		test_cmp expect todo
     + 	)
     + '
     +@@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs adds commands with --rebase-merges' '
     + 				   --rebase-merges=rebase-cousins \
     + 				   --update-refs primary >todo &&
     + 
     ++		test_cmp expect todo &&
     ++
     ++		test_must_fail git -c rebase.autosquash=true \
     ++				   -c rebase.updaterefs=true \
     ++				   rebase -i \
     ++				   --rebase-merges=rebase-cousins \
     ++				   primary >todo &&
     ++
       		test_cmp expect todo
       	)
       '

-- 
gitgitgadget
