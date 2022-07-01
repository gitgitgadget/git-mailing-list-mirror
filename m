Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99526C433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 13:43:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiGANns (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 09:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGANnr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 09:43:47 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901AC17580
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 06:43:44 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e28so3367313wra.0
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PuzMaWFi9oiufDYL4qZ0O7sfUgHXV3AXE83oT4uCc+U=;
        b=p2eOxaP5BUjAgYOclvz5ckTVZWcHjR2BB6AyttyiKncld5ak8XI4+LsiLBVbdwRxCm
         fGW7OD5OceEL1lwey+D/JgCygobsd4OsDkmyLy4d23sbgVniFwqSfAyP1SkApJMjWrkd
         0BQysINvqYb2WE1EKFeQzh+F2zX/o+cpiQt16wMLEyFGQLDQ03XYsRrgNkRsjALgxa/8
         Y4isTV/q1835r9u4HZUJ2BXEs4qNqWVgsEvIEXwSLGkikSsCr1qciWVrNSHjuek+DHyw
         ssO6AMMFoWU/NVaQ7yHvBEvIL5jUunXN29enevG3r2Ud0LDKVAHzYoWJ98ycK6JXBgqc
         aUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PuzMaWFi9oiufDYL4qZ0O7sfUgHXV3AXE83oT4uCc+U=;
        b=bNOKKE9A2QznLVES7v0WFxEcYZ1IlB5Y7DexIMfe8wo4eCtLCukPTGENGFRoza8jaS
         riSrYRbT5pbbRv+xQLWmkzLhkaDLiq0Q5ONNCsbqX4eywgi/fRKD9mAGLDbP6Itj0d3e
         H/9fxKexm/GWhDJDYtegvEKXh0F1MIkKASNKG0T1PJ52fU6Z8EAKSJ0ldZA5zudn5FEM
         XqtkOYM4GIjxHuBMZf5mZ7n1jfDxb9XQxA9upWnojfxCKnDkQXlIgh/JlW0vX+j6nMoy
         H6cKDQRHDiZGO3tr9R+aFQoe7opocIP/lqp+eFX6o3OAtiCaFpNVOTG3d61MzUBEEkoN
         1Cew==
X-Gm-Message-State: AJIora8N0gMJ/kG8Fv1SVLFLcGDpoFmCdS2NP5O51TQpV/Jez9DEvjuh
        9FQcjCUeoIR9QsKm+skTG+khHnAkMHo=
X-Google-Smtp-Source: AGRyM1sTXGu6TxYyoNbHBPfOqPYohvUbofkk7BZp5mnkf5Pq3b/eRtBoUZphEBFxNOM/1d3DB71XKA==
X-Received: by 2002:a05:6000:15c6:b0:21b:cd27:6490 with SMTP id y6-20020a05600015c600b0021bcd276490mr13527185wry.667.1656683022821;
        Fri, 01 Jul 2022 06:43:42 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm6437520wms.14.2022.07.01.06.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 06:43:42 -0700 (PDT)
Message-ID: <799939ac-e54d-b156-efe1-5f2d7edf2312@gmail.com>
Date:   Fri, 1 Jul 2022 14:43:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/8] rebase: update branches in multi-part topic
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 28/06/2022 14:25, Derrick Stolee via GitGitGadget wrote:
> (Update: This is now based on ds/branch-checked-out.)
> 
> This is a feature I've wanted for quite a while. When working on the sparse
> index topic, I created a long RFC that actually broke into three topics for
> full review upstream. These topics were sequential, so any feedback on an
> earlier one required updates to the later ones. I would work on the full
> feature and use interactive rebase to update the full list of commits.
> However, I would need to update the branches pointing to those sub-topics.
> 
> This series adds a new --update-refs option to 'git rebase' (along with a
> rebase.updateRefs config option) that adds 'update-ref' commands into the
> TODO list. This is powered by the commit decoration machinery.
> 
> As an example, here is my in-progress bundle URI RFC split into subtopics as
> they appear during the TODO list of a git rebase -i --update-refs:
> 
> pick 2d966282ff3 docs: document bundle URI standard
> pick 31396e9171a remote-curl: add 'get' capability
> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
> pick 6adaf842684 fetch: add --bundle-uri option
> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
> update-ref refs/heads/bundle-redo/fetch

I like the direction this is moving, my only concern with this version 
is how we handle the user adding and removing update-ref commands when 
the user edits the todo list.

Best Wishes

Phillip

> pick 1e3f6546632 clone: add --bundle-uri option
> pick 9e4a6fe9b68 clone: --bundle-uri cannot be combined with --depth
> update-ref refs/heads/bundle-redo/clone
> 
> pick 5451cb6599c bundle-uri: create bundle_list struct and helpers
> pick 3029c3aca15 bundle-uri: create base key-value pair parsing
> pick a8b2de79ce8 bundle-uri: create "key=value" line parsing
> pick 92625a47673 bundle-uri: unit test "key=value" parsing
> pick a8616af4dc2 bundle-uri: limit recursion depth for bundle lists
> pick 9d6809a8d53 bundle-uri: parse bundle list in config format
> pick 287a732b54c bundle-uri: fetch a list of bundles
> update-ref refs/heads/bundle-redo/list
> 
> pick b09f8226185 protocol v2: add server-side "bundle-uri" skeleton
> pick 520204dcd1c bundle-uri client: add minimal NOOP client
> pick 62e8b457b48 bundle-uri client: add "git ls-remote-bundle-uri"
> pick 00eae925043 bundle-uri: serve URI advertisement from bundle.* config
> pick 4277440a250 bundle-uri client: add boolean transfer.bundleURI setting
> pick caf4599a81d bundle-uri: allow relative URLs in bundle lists
> pick df255000b7e bundle-uri: download bundles from an advertised list
> pick d71beabf199 clone: unbundle the advertised bundles
> pick c9578391976 t5601: basic bundle URI tests
> # Ref refs/heads/bundle-redo/rfc-3 checked out at '/home/stolee/_git/git-bundles'
> 
> update-ref refs/heads/bundle-redo/advertise
> 
> 
> Here is an outline of the series:
> 
>   * Patch 1 updates some tests for branch_checked_out() for the 'apply'
>     backend.
>   * Patch 2 updates branch_checked_out() to parse the
>     rebase-merge/update-refs file to block concurrent ref updates and
>     checkouts on branches selected by --update-refs.
>   * Patch 3 updates the todo list documentation to remove some unnecessary
>     dots in the 'merge' command. This makes it consistent with the 'fixup'
>     command before we document the 'update-ref' command.
>   * Patch 4 updates the definition of todo_command_info to use enum values as
>     array indices.
>   * Patches 5-7 implement the --update-refs logic itself.
>   * Patch 8 adds the rebase.updateRefs config option similar to
>     rebase.autoSquash.
> 
> 
> Updates in v3
> =============
> 
>   * The branch_checked_out() API was extracted to its own topic and is now
>     the ds/branch-checked-out branch. This series is now based on that one.
>   * The for_each_decoration() API was removed, since it became trivial once
>     it did not take a commit directly.
>   * The branch_checked_out() tests did not verify the rebase-apply data (for
>     the apply backend), so that is fixed.
>   * Instead of using the 'label' command and a final 'update-refs' command in
>     the todo list, use a new 'update-ref ' command. This command updates the
>     rebase-merge/update-refs file with the OID of HEAD at these steps. At the
>     very end of the rebase sequence, those refs are updated to the stored OID
>     values (assuming that they were not removed by the user, in which case we
>     notice that the OID is the null OID and we do nothing).
>   * New tests are added.
>   * The todo-list comment documentation has some new formatting updates, but
>     also includes a description of 'update-refs' in this version.
> 
> 
> Updates in v2
> =============
> 
> As recommended by the excellent feedback, I have removed the 'exec' commands
> in favor of the 'label' commands and a new 'update-refs' command at the very
> end. This way, there is only one step that updates all of the refs at the
> end instead of updating refs during the rebase. If a user runs 'git rebase
> --abort' in the middle, then their refs are still where they need to be.
> 
> Based on some of the discussion, it seemed like one way to do this would be
> to have an 'update-ref ' command that would take the place of these 'label'
> commands. However, this would require two things that make it a bit awkward:
> 
>   1. We would need to replicate the storage of those positions during the
>      rebase. 'label' already does this pretty well. I've added the
>      "for-update-refs/" label to help here.
>   2. If we want to close out all of the refs as the rebase is finishing, then
>      that "step" becomes invisible to the user (and a bit more complicated to
>      insert). Thus, the 'update-refs' step performs this action. If the user
>      wants to do things after that step, then they can do so by editing the
>      TODO list.
> 
> Other updates:
> 
>   * The 'keep_decorations' parameter was renamed to 'update_refs'.
>   * I added tests for --rebase-merges=rebase-cousins to show how these labels
>     interact with other labels and merge commands.
>   * I changed the order of the insertion of these update-refs labels to be
>     before the fixups are rearranged. This fixes a bug where the tip commit
>     is a fixup! so its decorations are never inspected (and they would be in
>     the wrong place even if they were). The fixup! commands are properly
>     inserted between a pick and its following label command. Tests
>     demonstrate this is correct.
>   * Numerous style choices are updated based on feedback.
> 
> Thank you for all of the detailed review and ideas in this space. I
> appreciate any more ideas that can make this feature as effective as it can
> be.
> 
> Thanks, -Stolee
> 
> Derrick Stolee (8):
>    t2407: test branches currently using apply backend
>    branch: consider refs under 'update-refs'
>    rebase-interactive: update 'merge' description
>    sequencer: define array with enum values
>    sequencer: add update-ref command
>    rebase: add --update-refs option
>    rebase: update refs from 'update-ref' commands
>    rebase: add rebase.updateRefs config option
> 
>   Documentation/config/rebase.txt |   3 +
>   Documentation/git-rebase.txt    |  11 ++
>   branch.c                        |  13 ++
>   builtin/rebase.c                |  10 ++
>   rebase-interactive.c            |   9 +-
>   sequencer.c                     | 303 ++++++++++++++++++++++++++++++--
>   sequencer.h                     |  11 ++
>   t/t2407-worktree-heads.sh       |  52 +++++-
>   t/t3404-rebase-interactive.sh   | 107 +++++++++++
>   9 files changed, 496 insertions(+), 23 deletions(-)
> 
> 
> base-commit: 9bef0b1e6ec371e786c2fba3edcc06ad040a536c
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1247%2Fderrickstolee%2Frebase-keep-decorations-v3
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1247/derrickstolee/rebase-keep-decorations-v3
> Pull-Request: https://github.com/gitgitgadget/git/pull/1247
> 
> Range-diff vs v2:
> 
>   1:  4f9f3487641 < -:  ----------- log-tree: create for_each_decoration()
>   2:  5f54766e103 < -:  ----------- branch: add branch_checked_out() helper
>   -:  ----------- > 1:  fbaedc7f1f0 t2407: test branches currently using apply backend
>   -:  ----------- > 2:  2bc647b6fcd branch: consider refs under 'update-refs'
>   -:  ----------- > 3:  669f4abd59e rebase-interactive: update 'merge' description
>   3:  9f261c7df2c = 4:  6528a50343f sequencer: define array with enum values
>   4:  842b2186d25 ! 5:  e95ad41d355 sequencer: add update-refs command
>       @@ Metadata
>        Author: Derrick Stolee <derrickstolee@github.com>
>        
>         ## Commit message ##
>       -    sequencer: add update-refs command
>       +    sequencer: add update-ref command
>        
>       -    Add the boilerplat for an "update-refs" command in the sequencer. This
>       -    connects to the current no-op do_update_refs() which will be filled in
>       +    Add the boilerplate for an "update-ref" command in the sequencer. This
>       +    connects to the current no-op do_update_ref() which will be filled in
>            after more connections are created.
>        
>       +    The syntax in the todo list will be "update-ref <ref-name>" to signal
>       +    that we should store the current commit as the value for updating
>       +    <ref-name> at the end of the rebase.
>       +
>            Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>        
>       + ## rebase-interactive.c ##
>       +@@ rebase-interactive.c: void append_todo_help(int command_count,
>       + "        create a merge commit using the original merge commit's\n"
>       + "        message (or the oneline, if no original merge commit was\n"
>       + "        specified); use -c <commit> to reword the commit message\n"
>       ++"u, update-ref <ref> = track a placeholder for the <ref> to be updated\n"
>       ++"                      to this position in the new commits. The <ref> is\n"
>       ++"                      updated at the end of the rebase\n"
>       + "\n"
>       + "These lines can be re-ordered; they are executed from top to bottom.\n");
>       + 	unsigned edit_todo = !(shortrevisions && shortonto);
>       +
>         ## sequencer.c ##
>        @@ sequencer.c: static struct {
>         	[TODO_LABEL] = { 'l', "label" },
>         	[TODO_RESET] = { 't', "reset" },
>         	[TODO_MERGE] = { 'm', "merge" },
>       -+	[TODO_UPDATE_REFS] = { 'u', "update-refs" },
>       ++	[TODO_UPDATE_REF] = { 'u', "update-ref" },
>         	[TODO_NOOP] = { 0,   "noop" },
>         	[TODO_DROP] = { 'd', "drop" },
>         	[TODO_COMMENT] = { 0,   NULL },
>        @@ sequencer.c: static int parse_insn_line(struct repository *r, struct todo_item *item,
>       - 	padding = strspn(bol, " \t");
>       - 	bol += padding;
>       + 			     command_to_string(item->command));
>         
>       --	if (item->command == TODO_NOOP || item->command == TODO_BREAK) {
>       -+	if (item->command == TODO_NOOP ||
>       -+	    item->command == TODO_BREAK ||
>       -+	    item->command == TODO_UPDATE_REFS) {
>       - 		if (bol != eol)
>       - 			return error(_("%s does not accept arguments: '%s'"),
>       - 				     command_to_string(item->command), bol);
>       + 	if (item->command == TODO_EXEC || item->command == TODO_LABEL ||
>       +-	    item->command == TODO_RESET) {
>       ++	    item->command == TODO_RESET || item->command == TODO_UPDATE_REF) {
>       + 		item->commit = NULL;
>       + 		item->arg_offset = bol - buf;
>       + 		item->arg_len = (int)(eol - bol);
>        @@ sequencer.c: leave_merge:
>         	return ret;
>         }
>         
>       -+static int do_update_refs(struct repository *r)
>       ++static int do_update_ref(struct repository *r, const char *ref_name)
>        +{
>        +	return 0;
>        +}
>       @@ sequencer.c: static int pick_commits(struct repository *r,
>         				return error_with_patch(r, item->commit,
>         							arg, item->arg_len,
>         							opts, res, 0);
>       -+		} else if (item->command == TODO_UPDATE_REFS) {
>       -+			if ((res = do_update_refs(r)))
>       ++		} else if (item->command == TODO_UPDATE_REF) {
>       ++			struct strbuf ref = STRBUF_INIT;
>       ++			strbuf_add(&ref, arg, item->arg_len);
>       ++			if ((res = do_update_ref(r, ref.buf)))
>        +				reschedule = 1;
>       ++			strbuf_release(&ref);
>         		} else if (!is_noop(item->command))
>         			return error(_("unknown command %d"), item->command);
>         
>       @@ sequencer.h: enum todo_command {
>         	TODO_LABEL,
>         	TODO_RESET,
>         	TODO_MERGE,
>       -+	TODO_UPDATE_REFS,
>       ++	TODO_UPDATE_REF,
>         	/* commands that do nothing but are counted for reporting progress */
>         	TODO_NOOP,
>         	TODO_DROP,
>   5:  0a4c110127b ! 6:  918b398d6a2 rebase: add --update-refs option
>       @@ Commit message
>            reachable from those "sub branches". It can take a manual step to update
>            those branches.
>        
>       -    Add a new --update-refs option to 'git rebase -i' that adds 'label
>       -    for-update-refs/*' steps to the todo file whenever a commit that is
>       -    being rebased is decorated with that <ref>. At the very end, the
>       -    'update-refs' step is added to update all of the branches referenced by
>       -    the 'label' steps. This allows the user to rebase a long list of commits
>       -    in a multi-part feature and keep all of their pointers to those parts.
>       +    Add a new --update-refs option to 'git rebase -i' that adds 'update-ref
>       +    <ref>' steps to the todo file whenever a commit that is being rebased is
>       +    decorated with that <ref>. At the very end, the rebase process updates
>       +    all of the listed refs to the values stored during the rebase operation.
>        
>       -    NOTE: This change only introduce the --update-refs option and implements
>       -    the changes to the todo file. It does _not_ yet implement the action
>       -    taken by the 'update-refs' todo step, which will be implemented and
>       -    tested in a later change.
>       -
>       -    Use the new for_each_decoration() while iterating over the existing todo
>       -    list. Be sure to iterate after any squashing or fixups are placed.
>       -    Update the branch only after those squashes and fixups are complete.
>       -    This allows a --fixup commit at the tip of the feature to apply
>       -    correctly to the sub branch, even if it is fixing up the most-recent
>       -    commit in that part.
>       +    Be sure to iterate after any squashing or fixups are placed. Update the
>       +    branch only after those squashes and fixups are complete. This allows a
>       +    --fixup commit at the tip of the feature to apply correctly to the sub
>       +    branch, even if it is fixing up the most-recent commit in that part.
>        
>            One potential problem here is that refs decorating commits that are
>            already marked as "fixup!" or "squash!" will not be included in this
>       @@ Commit message
>            of the rebased branch while the other sub branches come along for the
>            ride without intervention.
>        
>       -    Be careful to not attempt updating any branch that is checked out. The
>       -    most common example is the branch being rebased is checked out and
>       -    decorates the tip commit. If the user is rebasing commits reachable from
>       -    a different branch that is checked out in a different worktree, then
>       -    they may be surprised to not see that ref update. However, it's probably
>       -    best to not optimize for this scenario and do the safest thing that will
>       -    result in a successful rebase. A comment is left in the TODO list that
>       -    signals that these refs are currently checked out.
>       +    This change update the documentation and builtin to accept the
>       +    --update-refs option as well as updating the todo file with the
>       +    'update-ref' commands. Tests are added to ensure that these todo
>       +    commands are added in the correct locations.
>       +
>       +    A future change will update the behavior to actually update the refs
>       +    at the end of the rebase sequence.
>        
>            Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>        
>       @@ sequencer.c
>         #include "rebase-interactive.h"
>         #include "reset.h"
>        +#include "branch.h"
>       -+#include "log-tree.h"
>         
>         #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>         
>       @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
>        +	size_t items_alloc;
>        +	struct strbuf *buf;
>        +	struct commit *commit;
>       ++	struct string_list refs_to_oids;
>        +};
>        +
>       -+static int add_branch_for_decoration(const struct name_decoration *d, void *data)
>       ++static int add_decorations_to_list(const struct commit *commit,
>       ++				   struct todo_add_branch_context *ctx)
>        +{
>       -+	struct todo_add_branch_context *ctx = data;
>       -+	size_t base_offset = ctx->buf->len;
>       -+	struct todo_item *item;
>       -+	char *path;
>       ++	const struct name_decoration *decoration = get_name_decoration(&commit->object);
>        +
>       -+	ALLOC_GROW(ctx->items,
>       -+		   ctx->items_nr + 1,
>       -+		   ctx->items_alloc);
>       -+	item = &ctx->items[ctx->items_nr];
>       -+	memset(item, 0, sizeof(*item));
>       ++	while (decoration) {
>       ++		struct todo_item *item;
>       ++		const char *path;
>       ++		size_t base_offset = ctx->buf->len;
>        +
>       -+	/* If the branch is checked out, then leave a comment instead. */
>       -+	if (branch_checked_out(d->name, &path)) {
>       -+		item->command = TODO_COMMENT;
>       -+		strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
>       -+			    d->name, path);
>       -+		free(path);
>       -+	} else {
>       -+		item->command = TODO_LABEL;
>       -+		strbuf_addf(ctx->buf, "for-update-refs/%s\n", d->name);
>       -+	}
>       ++		ALLOC_GROW(ctx->items,
>       ++			ctx->items_nr + 1,
>       ++			ctx->items_alloc);
>       ++		item = &ctx->items[ctx->items_nr];
>       ++		memset(item, 0, sizeof(*item));
>       ++
>       ++		/* If the branch is checked out, then leave a comment instead. */
>       ++		if ((path = branch_checked_out(decoration->name))) {
>       ++			item->command = TODO_COMMENT;
>       ++			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
>       ++				    decoration->name, path);
>       ++		} else {
>       ++			struct string_list_item *sti;
>       ++			item->command = TODO_UPDATE_REF;
>       ++			strbuf_addf(ctx->buf, "%s\n", decoration->name);
>       ++
>       ++			sti = string_list_append(&ctx->refs_to_oids,
>       ++						 decoration->name);
>       ++			sti->util = oiddup(the_hash_algo->null_oid);
>       ++		}
>       ++
>       ++		item->offset_in_buf = base_offset;
>       ++		item->arg_offset = base_offset;
>       ++		item->arg_len = ctx->buf->len - base_offset;
>       ++		ctx->items_nr++;
>        +
>       -+	item->offset_in_buf = base_offset;
>       -+	item->arg_offset = base_offset;
>       -+	item->arg_len = ctx->buf->len - base_offset;
>       -+	ctx->items_nr++;
>       ++		decoration = decoration->next;
>       ++	}
>        +
>        +	return 0;
>        +}
>       @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
>        +	struct decoration_filter decoration_filter = {
>        +		.include_ref_pattern = &decorate_refs_include,
>        +		.exclude_ref_pattern = &decorate_refs_exclude,
>       -+		.exclude_ref_config_pattern = &decorate_refs_exclude_config
>       ++		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
>        +	};
>        +	struct todo_add_branch_context ctx = {
>        +		.buf = &todo_list->buf,
>       ++		.refs_to_oids = STRING_LIST_INIT_DUP,
>        +	};
>        +
>        +	ctx.items_alloc = 2 * todo_list->nr + 1;
>       @@ sequencer.c: static int skip_unnecessary_picks(struct repository *r,
>        +
>        +		if (item->commit) {
>        +			ctx.commit = item->commit;
>       -+			for_each_decoration(item->commit,
>       -+					    add_branch_for_decoration,
>       -+					    &ctx);
>       ++			add_decorations_to_list(item->commit, &ctx);
>        +		}
>        +	}
>        +
>       -+	/* Add the "update-refs" step. */
>       -+	ALLOC_GROW(ctx.items,
>       -+		   ctx.items_nr + 1,
>       -+		   ctx.items_alloc);
>       -+	memset(&ctx.items[ctx.items_nr], 0, sizeof(struct todo_item));
>       -+	ctx.items[ctx.items_nr].command = TODO_UPDATE_REFS;
>       -+	ctx.items_nr++;
>       -+
>       ++	string_list_clear(&ctx.refs_to_oids, 1);
>        +	free(todo_list->items);
>        +	todo_list->items = ctx.items;
>        +	todo_list->nr = ctx.items_nr;
>       @@ sequencer.h: int complete_action(struct repository *r, struct replay_opts *opts,
>         int todo_list_rearrange_squash(struct todo_list *todo_list);
>         
>        
>       + ## t/t2407-worktree-heads.sh ##
>       +@@ t/t2407-worktree-heads.sh: test_expect_success 'refuse to overwrite when in error states' '
>       + 	done
>       + '
>       +
>       ++. "$TEST_DIRECTORY"/lib-rebase.sh
>       ++
>       ++test_expect_success !SANITIZE_LEAK 'refuse to overwrite during rebase with --update-refs' '
>       ++	git commit --fixup HEAD~2 --allow-empty &&
>       ++	(
>       ++		set_cat_todo_editor &&
>       ++		test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
>       ++		! grep "update-refs" todo
>       ++	) &&
>       ++	git branch -f allow-update HEAD~2 &&
>       ++	(
>       ++		set_cat_todo_editor &&
>       ++		test_must_fail git rebase -i --update-refs HEAD~3 >todo &&
>       ++		grep "update-ref refs/heads/allow-update" todo
>       ++	)
>       ++'
>       ++
>       + test_done
>       +
>         ## t/t3404-rebase-interactive.sh ##
>        @@ t/t3404-rebase-interactive.sh: test_expect_success 'ORIG_HEAD is updated correctly' '
>         	test_cmp_rev ORIG_HEAD test-orig-head@{1}
>       @@ t/t3404-rebase-interactive.sh: test_expect_success 'ORIG_HEAD is updated correct
>        +
>        +		cat >expect <<-EOF &&
>        +		pick $(git log -1 --format=%h J) J
>       -+		label for-update-refs/refs/heads/second
>       -+		label for-update-refs/refs/heads/first
>       ++		update-ref refs/heads/second
>       ++		update-ref refs/heads/first
>        +		pick $(git log -1 --format=%h K) K
>        +		pick $(git log -1 --format=%h L) L
>        +		fixup $(git log -1 --format=%h update-refs) fixup! L # empty
>       -+		label for-update-refs/refs/heads/third
>       ++		update-ref refs/heads/third
>        +		pick $(git log -1 --format=%h M) M
>       -+		label for-update-refs/refs/heads/no-conflict-branch
>       -+		label for-update-refs/refs/heads/shared-tip
>       -+		update-refs
>       ++		update-ref refs/heads/no-conflict-branch
>       ++		update-ref refs/heads/shared-tip
>        +		EOF
>        +
>        +		test_must_fail git rebase -i --autosquash --update-refs primary >todo &&
>       @@ t/t3404-rebase-interactive.sh: test_expect_success 'ORIG_HEAD is updated correct
>        +		reset onto
>        +		pick $(git log -1 --format=%h branch2~1) F
>        +		pick $(git log -1 --format=%h branch2) I
>       -+		label for-update-refs/refs/heads/branch2
>       ++		update-ref refs/heads/branch2
>        +		label merge
>        +		reset onto
>        +		pick $(git log -1 --format=%h refs/heads/second) J
>       -+		label for-update-refs/refs/heads/second
>       -+		label for-update-refs/refs/heads/first
>       ++		update-ref refs/heads/second
>       ++		update-ref refs/heads/first
>        +		pick $(git log -1 --format=%h refs/heads/third~1) K
>        +		pick $(git log -1 --format=%h refs/heads/third) L
>        +		fixup $(git log -1 --format=%h update-refs-with-merge) fixup! L # empty
>       -+		label for-update-refs/refs/heads/third
>       ++		update-ref refs/heads/third
>        +		pick $(git log -1 --format=%h HEAD~2) M
>       -+		label for-update-refs/refs/heads/no-conflict-branch
>       ++		update-ref refs/heads/no-conflict-branch
>        +		merge -C $(git log -1 --format=%h HEAD~1) merge # merge
>       -+		label for-update-refs/refs/heads/merge-branch
>       -+		update-refs
>       ++		update-ref refs/heads/merge-branch
>        +		EOF
>        +
>        +		test_must_fail git rebase -i --autosquash \
>   6:  68f8e51b19c ! 7:  72e0481b643 sequencer: implement 'update-refs' command
>       @@ Metadata
>        Author: Derrick Stolee <derrickstolee@github.com>
>        
>         ## Commit message ##
>       -    sequencer: implement 'update-refs' command
>       +    rebase: update refs from 'update-ref' commands
>        
>       -    The previous change allowed 'git rebase --update-refs' to create 'label'
>       -    commands for each branch  among the commits being rewritten and add an
>       -    'update-refs' command at the end of the todo list. Now, teach Git to
>       -    update the refs during that final 'update-refs' command.
>       +    The previous change introduced the 'git rebase --update-refs' option
>       +    which added 'update-ref <ref>' commands to the todo list of an
>       +    interactive rebase.
>        
>       -    We need to create an array of new and old OIDs for each ref by iterating
>       -    over the refs/rewritten/for-update-refs/ namespace. We cannot update the
>       -    refs in-place since this will confuse the refs iterator.
>       +    Teach Git to record the HEAD position when reaching these 'update-ref'
>       +    commands. The ref/OID pair is stored in the
>       +    $GIT_DIR/rebase-merge/update-refs file. A previous change parsed this
>       +    file to avoid having other processes updating the refs in that file
>       +    while the rebase is in progress.
>       +
>       +    Not only do we update the file when the sequencer reaches these
>       +    'update-ref' commands, we then update the refs themselves at the end of
>       +    the rebase sequence. If the rebase is aborted before this final step,
>       +    then the refs are not updated.
>        
>            Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>        
>         ## sequencer.c ##
>       +@@
>       + #include "rebase-interactive.h"
>       + #include "reset.h"
>       + #include "branch.h"
>       ++#include "log-tree.h"
>       +
>       + #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
>       +
>       +@@ sequencer.c: static GIT_PATH_FUNC(rebase_path_squash_onto, "rebase-merge/squash-onto")
>       +  */
>       + static GIT_PATH_FUNC(rebase_path_refs_to_delete, "rebase-merge/refs-to-delete")
>       +
>       ++/*
>       ++ * The update-refs file stores a list of refs that will be updated at the end
>       ++ * of the rebase sequence. The 'update-ref <ref>' commands in the todo file
>       ++ * update the OIDs for the refs in this file, but the refs are not updated
>       ++ * until the end of the rebase sequence.
>       ++ */
>       ++static GIT_PATH_FUNC(rebase_path_update_refs, "rebase-merge/update-refs")
>       ++
>       + /*
>       +  * The following files are written by git-rebase just after parsing the
>       +  * command-line.
>        @@ sequencer.c: leave_merge:
>         	return ret;
>         }
>         
>       --static int do_update_refs(struct repository *r)
>       -+struct update_refs_context {
>       -+	struct ref_store *refs;
>       -+	char **ref_names;
>       -+	struct object_id *old;
>       -+	struct object_id *new;
>       -+	size_t nr;
>       -+	size_t alloc;
>       -+};
>       -+
>       -+static int add_ref_to_context(const char *refname,
>       -+			      const struct object_id *oid,
>       -+			      int flags,
>       -+			      void *data)
>       +-static int do_update_ref(struct repository *r, const char *ref_name)
>       ++static int write_update_refs_state(struct string_list *refs_to_oids)
>       ++{
>       ++	int result = 0;
>       ++	FILE *fp = NULL;
>       ++	struct string_list_item *item;
>       ++	char *path = xstrdup(rebase_path_update_refs());
>       ++
>       ++	if (safe_create_leading_directories(path)) {
>       ++		result = error(_("unable to create leading directories of %s"),
>       ++			       path);
>       ++		goto cleanup;
>       ++	}
>       ++
>       ++	fp = fopen(path, "w");
>       ++	if (!fp) {
>       ++		result = error_errno(_("could not open '%s' for writing"), path);
>       ++		goto cleanup;
>       ++	}
>       ++
>       ++	for_each_string_list_item(item, refs_to_oids)
>       ++		fprintf(fp, "%s\n%s\n", item->string, oid_to_hex(item->util));
>       ++
>       ++cleanup:
>       ++	if (fp)
>       ++		fclose(fp);
>       ++	return result;
>       ++}
>       ++
>       ++static int do_update_ref(struct repository *r, const char *refname)
>         {
>       -+	int f = 0;
>       -+	const char *name;
>       -+	struct update_refs_context *ctx = data;
>       ++	struct string_list_item *item;
>       ++	struct string_list list = STRING_LIST_INIT_DUP;
>       ++	int found = 0;
>       ++
>       ++	sequencer_get_update_refs_state(r->gitdir, &list);
>        +
>       -+	ALLOC_GROW(ctx->ref_names, ctx->nr + 1, ctx->alloc);
>       -+	ALLOC_GROW(ctx->old, ctx->nr + 1, ctx->alloc);
>       -+	ALLOC_GROW(ctx->new, ctx->nr + 1, ctx->alloc);
>       ++	for_each_string_list_item(item, &list) {
>       ++		if (!strcmp(item->string, refname)) {
>       ++			struct object_id oid;
>       ++			free(item->util);
>       ++			found = 1;
>        +
>       -+	if (!skip_prefix(refname, "refs/rewritten/for-update-refs/", &name))
>       -+		return 1;
>       ++			if (!read_ref("HEAD", &oid)) {
>       ++				item->util = oiddup(&oid);
>       ++				break;
>       ++			}
>       ++		}
>       ++	}
>        +
>       -+	ctx->ref_names[ctx->nr] = xstrdup(name);
>       -+	oidcpy(&ctx->new[ctx->nr], oid);
>       -+	if (!refs_resolve_ref_unsafe(ctx->refs, name, 0,
>       -+				     &ctx->old[ctx->nr], &f))
>       -+		return 1;
>       ++	if (!found) {
>       ++		struct object_id oid;
>       ++		item = string_list_append(&list, refname);
>        +
>       -+	ctx->nr++;
>       ++		if (!read_ref("HEAD", &oid))
>       ++			item->util = oiddup(&oid);
>       ++		else
>       ++			item->util = oiddup(the_hash_algo->null_oid);
>       ++	}
>       ++
>       ++	write_update_refs_state(&list);
>       ++	string_list_clear(&list, 1);
>         	return 0;
>         }
>         
>        +static int do_update_refs(struct repository *r)
>        +{
>       -+	int i, res;
>       -+	struct update_refs_context ctx = {
>       -+		.refs = get_main_ref_store(r),
>       -+		.alloc = 16,
>       -+	};
>       -+	ALLOC_ARRAY(ctx.ref_names, ctx.alloc);
>       -+	ALLOC_ARRAY(ctx.old, ctx.alloc);
>       -+	ALLOC_ARRAY(ctx.new, ctx.alloc);
>       -+
>       -+	res = refs_for_each_fullref_in(ctx.refs,
>       -+				       "refs/rewritten/for-update-refs/",
>       -+				       add_ref_to_context,
>       -+				       &ctx);
>       -+
>       -+	for (i = 0; !res && i < ctx.nr; i++)
>       -+		res = refs_update_ref(ctx.refs, "rewritten during rebase",
>       -+				ctx.ref_names[i],
>       -+				&ctx.new[i], &ctx.old[i],
>       ++	int res = 0;
>       ++	struct string_list_item *item;
>       ++	struct string_list refs_to_oids = STRING_LIST_INIT_DUP;
>       ++	struct ref_store *refs = get_main_ref_store(r);
>       ++
>       ++	sequencer_get_update_refs_state(r->gitdir, &refs_to_oids);
>       ++
>       ++	for_each_string_list_item(item, &refs_to_oids) {
>       ++		struct object_id *oid_to = item->util;
>       ++		struct object_id oid_from;
>       ++
>       ++		if (oideq(oid_to, the_hash_algo->null_oid)) {
>       ++			/*
>       ++			 * Ref was not updated. User may have deleted the
>       ++			 * 'update-ref' step.
>       ++			 */
>       ++			continue;
>       ++		}
>       ++
>       ++		if (read_ref(item->string, &oid_from)) {
>       ++			/*
>       ++			 * The ref does not exist. The user probably
>       ++			 * inserted a new 'update-ref' step with a new
>       ++			 * branch name.
>       ++			 */
>       ++			oidcpy(&oid_from, the_hash_algo->null_oid);
>       ++		}
>       ++
>       ++		res |= refs_update_ref(refs, "rewritten during rebase",
>       ++				item->string,
>       ++				oid_to, &oid_from,
>        +				0, UPDATE_REFS_MSG_ON_ERR);
>       ++	}
>        +
>       -+	for (i = 0; i < ctx.nr; i++)
>       -+		free(ctx.ref_names[i]);
>       -+	free(ctx.ref_names);
>       -+	free(ctx.old);
>       -+	free(ctx.new);
>       ++	string_list_clear(&refs_to_oids, 1);
>        +	return res;
>        +}
>        +
>         static int is_final_fixup(struct todo_list *todo_list)
>         {
>         	int i = todo_list->current;
>       +@@ sequencer.c: cleanup_head_ref:
>       + 		strbuf_release(&head_ref);
>       + 	}
>       +
>       ++	do_update_refs(r);
>       ++
>       + 	/*
>       + 	 * Sequence of picks finished successfully; cleanup by
>       + 	 * removing the .git/sequencer directory
>       +@@ sequencer.c: static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
>       + 		}
>       + 	}
>       +
>       ++	write_update_refs_state(&ctx.refs_to_oids);
>       ++
>       + 	string_list_clear(&ctx.refs_to_oids, 1);
>       + 	free(todo_list->items);
>       + 	todo_list->items = ctx.items;
>        
>         ## t/t3404-rebase-interactive.sh ##
>        @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs adds commands with --rebase-merges' '
>       @@ t/t3404-rebase-interactive.sh: test_expect_success '--update-refs adds commands
>        +	git branch -f third HEAD~1 &&
>        +	test_commit extra2 fileX &&
>        +	git commit --amend --fixup=L &&
>       -+	(
>       -+		git rebase -i --autosquash --update-refs primary &&
>       -+
>       -+		compare_two_refs HEAD~3 refs/heads/first &&
>       -+		compare_two_refs HEAD~3 refs/heads/second &&
>       -+		compare_two_refs HEAD~1 refs/heads/third &&
>       -+		compare_two_refs HEAD refs/heads/no-conflict-branch
>       -+	)
>       ++
>       ++	git rebase -i --autosquash --update-refs primary &&
>       ++
>       ++	compare_two_refs HEAD~3 refs/heads/first &&
>       ++	compare_two_refs HEAD~3 refs/heads/second &&
>       ++	compare_two_refs HEAD~1 refs/heads/third &&
>       ++	compare_two_refs HEAD refs/heads/no-conflict-branch
>        +'
>        +
>         # This must be the last test in this file
>   7:  3d7d3f656b4 ! 8:  d2cfdbfc431 rebase: add rebase.updateRefs config option
>       @@ Documentation/git-rebase.txt: start would be overridden by the presence of
>         	or point to a `squash! ...` or `fixup! ...` commit are not updated
>         	in this way.
>        ++
>       -+If the `--update-refs` option is enabled by default using the
>       -+configuration variable `rebase.updateRefs`, this option can be
>       -+used to override and disable this setting.
>       ++If the configuration variable `rebase.updateRefs` is set, then this option
>       ++can be used to override and disable this setting.
>         
>         INCOMPATIBLE OPTIONS
>         --------------------
> 
