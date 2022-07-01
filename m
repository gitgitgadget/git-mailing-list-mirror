Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780EFC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 09:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233994AbiGAJUH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 05:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232834AbiGAJUG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 05:20:06 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3CF51B2B
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 02:20:04 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id s1so2271528wra.9
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 02:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:reply-to:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=8+lVrXY2Gipj6EUih49Yf6eHsM6Opvrg7NcMDJLaynQ=;
        b=JuPc+VipmQKKQjs/4S4qxs2TawVYGjBllOpS18NqutpFJFx4FERu8J+Q3llZHMkYCK
         Eq63b8i7F5u4GtlhU86DDvw00uNWtoBEaQbV7WrkdPwfhCmCb8Jh+JIsz/hvWHjUNCb2
         8pfGiFSvw6LhE1LrUUTWGLMv6wvSlJ3L+Ozqy7HDNd5cnd5ztP92CLYtib8gAzQIjDUk
         jZQYAu9cZ7mtuhuuu6MMw471WIF33kHeejaGp6RPyU9RdwK2A+2L5dRWCTwUAq7jRRk2
         ajFKql3VZWwuyAOUirzouZlReZxBuRIUOl7UNWU2stXjM/3uSycM4YrE3hrRr58x/Lzz
         IWWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:reply-to:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=8+lVrXY2Gipj6EUih49Yf6eHsM6Opvrg7NcMDJLaynQ=;
        b=g658upyDwtRuYHlM7B+YCyiITU0YI0YpDCsIDF8IGOjaIOZ1te+NTqKAweqmJoVDHr
         qhS2ZtzrwkxGR/lkomHMRjlWVuBkqNOcrDocbrnT4CJN6mUVNoPjiUGoPRlzNb2P9eZn
         xrnLCgKs4Xia9XmxRB94jOUpKkVmU+kjRSjPyHv0MakhqymnOtHMuSwgH/K51gNznoRL
         W/JQViW2E4mqzUsvVp9uhjZhnh+MoHs9gkubGA1llBHG2KKHwEewrd2CQ7fAXWAS21jW
         ND+8zYJnbKjYtGj8Uhn8YWTTKrnmZMSiT8Xor6XwX3AMmE4ilNpQixJAcpGRAiXwkmS+
         HdUA==
X-Gm-Message-State: AJIora+iSF0YvZjiPAHbPYEL4VkVPnLePT0yRzOtYbrR/c5Jx7opynVQ
        ymsV3I+8kfuK8aupJUXrN62ABefpkMI=
X-Google-Smtp-Source: AGRyM1txVCkxog8FUPcYqI/xXp88nWX42dvUAINfFdGf2v7BcXGQ/qIWosaknJOsvUi3kxREdoTr/A==
X-Received: by 2002:a5d:4b84:0:b0:21b:a9a2:e6ce with SMTP id b4-20020a5d4b84000000b0021ba9a2e6cemr12802814wrt.657.1656667203275;
        Fri, 01 Jul 2022 02:20:03 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id k1-20020a5d6281000000b0021b9e360523sm22290649wru.8.2022.07.01.02.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 02:20:02 -0700 (PDT)
Message-ID: <f410f5fd-aee9-0ec1-d5a7-639a4eb8fdb0@gmail.com>
Date:   Fri, 1 Jul 2022 10:20:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 6/8] rebase: add --update-refs option
Reply-To: phillip.wood@dunelm.org.uk
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v2.git.1654634569.gitgitgadget@gmail.com>
 <pull.1247.v3.git.1656422759.gitgitgadget@gmail.com>
 <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <918b398d6a2264a99acadd319f780c796bbafc18.1656422759.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 28/06/2022 14:25, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> When working on a large feature, it can be helpful to break that feature
> into multiple smaller parts that become reviewed in sequence. During
> development or during review, a change to one part of the feature could
> affect multiple of these parts. An interactive rebase can help adjust
> the multi-part "story" of the branch.
> 
> However, if there are branches tracking the different parts of the
> feature, then rebasing the entire list of commits can create commits not
> reachable from those "sub branches". It can take a manual step to update
> those branches.
> 
> Add a new --update-refs option to 'git rebase -i' that adds 'update-ref
> <ref>' steps to the todo file whenever a commit that is being rebased is
> decorated with that <ref>. At the very end, the rebase process updates
> all of the listed refs to the values stored during the rebase operation.
> 
> Be sure to iterate after any squashing or fixups are placed. Update the
> branch only after those squashes and fixups are complete. This allows a
> --fixup commit at the tip of the feature to apply correctly to the sub
> branch, even if it is fixing up the most-recent commit in that part.
> 
> One potential problem here is that refs decorating commits that are
> already marked as "fixup!" or "squash!" will not be included in this
> list. Generally, the reordering of the "fixup!" and "squash!" is likely
> to change the relative order of these refs, so it is not recommended.
> The workflow here is intended to allow these kinds of commits at the tip
> of the rebased branch while the other sub branches come along for the
> ride without intervention.
> 
> This change update the documentation and builtin to accept the
> --update-refs option as well as updating the todo file with the
> 'update-ref' commands. Tests are added to ensure that these todo
> commands are added in the correct locations.
> 
> A future change will update the behavior to actually update the refs
> at the end of the rebase sequence.

This looks quite good to me, my main concern is that we don't check what 
the user did when they edited the todo list which leaves a potentially 
long window when another process could update a branch that is being 
rebased. I've left some comments below, they're mostly me talking to 
myself while reading the code.

> +struct todo_add_branch_context {
> +	struct todo_item *items;
> +	size_t items_nr;
> +	size_t items_alloc;
> +	struct strbuf *buf;
> +	struct commit *commit;
> +	struct string_list refs_to_oids;
> +};
> +
> +static int add_decorations_to_list(const struct commit *commit,
> +				   struct todo_add_branch_context *ctx)
> +{
> +	const struct name_decoration *decoration = get_name_decoration(&commit->object);
> +
> +	while (decoration) {
> +		struct todo_item *item;
> +		const char *path;
> +		size_t base_offset = ctx->buf->len;
> +
> +		ALLOC_GROW(ctx->items,
> +			ctx->items_nr + 1,
> +			ctx->items_alloc);
> +		item = &ctx->items[ctx->items_nr];
> +		memset(item, 0, sizeof(*item));
> +
> +		/* If the branch is checked out, then leave a comment instead. */
> +		if ((path = branch_checked_out(decoration->name))) {
> +			item->command = TODO_COMMENT;
> +			strbuf_addf(ctx->buf, "# Ref %s checked out at '%s'\n",
> +				    decoration->name, path);
> +		} else {
> +			struct string_list_item *sti;
> +			item->command = TODO_UPDATE_REF;
> +			strbuf_addf(ctx->buf, "%s\n", decoration->name);
> +
> +			sti = string_list_append(&ctx->refs_to_oids,
> +						 decoration->name);
> +			sti->util = oiddup(the_hash_algo->null_oid);

We don't record where the branch is pointing, but we do stop checkout 
from checking out the branch. There is a small race window where another 
process can checkout the branch (or start rebasing a branch with 'git 
rebase <upstream> <branch>') after we've added it to this list but have 
not written it to disk.

> +		}
> +
> +		item->offset_in_buf = base_offset;
> +		item->arg_offset = base_offset;
> +		item->arg_len = ctx->buf->len - base_offset;
> +		ctx->items_nr++;
> +
> +		decoration = decoration->next;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * For each 'pick' command, find out if the commit has a decoration in
> + * refs/heads/. If so, then add a 'label for-update-refs/' command.
> + */
> +static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
> +{
> +	int i;
> +	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
> +	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
> +	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
> +	struct decoration_filter decoration_filter = {
> +		.include_ref_pattern = &decorate_refs_include,
> +		.exclude_ref_pattern = &decorate_refs_exclude,
> +		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
> +	};
> +	struct todo_add_branch_context ctx = {
> +		.buf = &todo_list->buf,
> +		.refs_to_oids = STRING_LIST_INIT_DUP,
> +	};
> +
> +	ctx.items_alloc = 2 * todo_list->nr + 1;

We pre-allocate enough space for each commit to have an update-refs 
command added after it ...

> +	ALLOC_ARRAY(ctx.items, ctx.items_alloc);
> +
> +	string_list_append(&decorate_refs_include, "refs/heads/");
> +	load_ref_decorations(&decoration_filter, 0);
> +
> +	for (i = 0; i < todo_list->nr; ) {
> +		struct todo_item *item = &todo_list->items[i];
> +
> +		/* insert ith item into new list */
> +		ALLOC_GROW(ctx.items,
> +			   ctx.items_nr + 1,
> +			   ctx.items_alloc);

But we are careful to grow the array if that space is not enough.

> +		ctx.items[ctx.items_nr++] = todo_list->items[i++];
> +
> +		if (item->commit) {
> +			ctx.commit = item->commit;
> +			add_decorations_to_list(item->commit, &ctx);
> +		}
> +	}
> +
> +	string_list_clear(&ctx.refs_to_oids, 1);
> +	free(todo_list->items);
> +	todo_list->items = ctx.items;
> +	todo_list->nr = ctx.items_nr;
> +	todo_list->alloc = ctx.items_alloc;
> +
> +	return 0;
> +}
> +
>   int complete_action(struct repository *r, struct replay_opts *opts, unsigned flags,
>   		    const char *shortrevisions, const char *onto_name,
>   		    struct commit *onto, const struct object_id *orig_head,
>   		    struct string_list *commands, unsigned autosquash,
> +		    unsigned update_refs,
>   		    struct todo_list *todo_list)
>   {
>   	char shortonto[GIT_MAX_HEXSZ + 1];
> @@ -5637,6 +5741,9 @@ int complete_action(struct repository *r, struct replay_opts *opts, unsigned fla
>   		item->arg_len = item->arg_offset = item->flags = item->offset_in_buf = 0;
>   	}
>   
> +	if (update_refs && todo_list_add_update_ref_commands(todo_list))
> +		return -1;
> +

We add the update-ref commands before the user edits the todo list but 
do not check if they have added or removed any update-ref commands when 
they edit it. This means we may lock a branch unnecessarily if they 
deleted an update-ref command or fail to lock a branch in a timely 
manner if they add an update-ref command. It will eventually be locked 
when we process the update-ref command during the rebase but that could 
be quite a bit later if there are conflicts.

If we were to add the update-ref commands before the user edited the 
list and then write the update-refs file after it has been edited that 
would avoid some of these problems but leaves a bigger race window when 
two process think they can safely update a branch. That could be 
addressed by checking the other worktrees again once we have written the 
file which we really need to do in order to check the user hasn't added 
an update-ref command for a branch that is already being rebased in 
another worktree.

Best Wishes

Phillip
