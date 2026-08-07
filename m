Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DB33E355
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786116159; cv=none; b=rE/HMhU0aVYVa4A35VpSSVu+59XIOSw6iL05P8Rd+QBaLUYUhutbT4ZzP6cpuiecMtURGZF5qajaGP+PAJGLWs1G7f93Qk1w8qzC3OzQGl9xFcYgy6QRmzsXd2+v3ZIRY5lYY2ycghM/WQfkoOVkGHwQHXWu16x3q6F00mfp64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786116159; c=relaxed/simple;
	bh=Snj7wIriCt3cCAeQ6ucLGNAeZ51XyxQ6IzHmscKryrU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vlmm6x/4OmLCF4Gk1/O9XA1gNIF7CTTkuU9BeoLCf+oW6ewfx0zAtncsTaXKSAGyWIJjpZ2akh1mHALeHpXSt1QAl/XaDV71s/VxhpOfs9yMPhNB1HdpiG3Q3fdQTpM8R0XrfXV3vuTnVlD3ChwZDDYPFi79UmnkvNJrttp3FQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sDMh4Lvt; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDMh4Lvt"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso22965565e9.1
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786116155; x=1786720955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dNQfp+X9Bz3Wk9nwKwoXYKS7Vc7h7cHwmj8GPzTETfo=;
        b=sDMh4LvtaSOkH1CXvDiU43iZTatTdgqnwQC+8Kgg7GSslBFCK3aUAgsG1KoHAl9qh5
         1X8Pe6D+iOWHlqauYIH+JXsnJIHoDtEmclFg5ZPU9ykjlPHpPQBbDD0nYnazci/tviyC
         R5JCFAoCQx10S6xWn4zOWV6wzM9cJPKPqUYvMZS+LfZmvx8kwsN5IUhekjS6PRTMoPZV
         B8i4L6tFouWSukZvRQFyocYODXkAjjNYMvoN/Zt1qouLt9AjG34KYGwHFYl4MGgVRsnc
         TDZE91dNJJHgsZ6OkNTzicoXRZM8txos38ln1KxajhZ8MbT7Ri9SqhrSlsLmAU7+kdG6
         LIOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786116155; x=1786720955;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dNQfp+X9Bz3Wk9nwKwoXYKS7Vc7h7cHwmj8GPzTETfo=;
        b=AVu5ZY8GeKU45Mprigb7UPJgFbmzl6lD/JDSZs0ZXChzwStQ+TFIcevPa5gNlPjxY8
         8Zk2ZYGYoU/wj6gvqlLh0w3glE27lbVib61w+49acr6yOmULMzrGEZ3tsDonqrnbBjuM
         g7bsnPL3cZSWLqp0LTVB3EYwed+guD+6KwkCKmNZf01NWQsz7fP3S3/kf//zE1epzyRQ
         6qXm+t5e5UxPO4jyrOKRn7iNLeKh/iViqhzsvIdeonoXuECDZyzOBCSnh5i7PKrH3xbL
         DFDc26+cZ22mgcujqjzuZuC+zsvDvwNtpJJxWu1fABW/d9y0+KHzoUgbNj6hOsX+F8uY
         4BOg==
X-Forwarded-Encrypted: i=1; AHgh+RoW3Kx6uoegy44APw1ZnY1TlEQMBPglslEeyr/rDdvTNBV4z2KbwuaQRz/1ZZXpQJPy5/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxWOA4z1ICcWIEM4xD13xKpYgSJ+7oK1xvpeI7+TIRluhCNkax
	ecPdNW2cNG3GihUfBKMhk0nQfPi9viOnN6997Tdjc53lpzF1FWnPcPUPQIbyfA==
X-Gm-Gg: AR+sD113taDj7SOhqlQmYsiA9BgVOHiS5pHK5o9ZYFv+83MbvTN6r+JNsTDff0mwzto
	W0MRutT5Wz+w63S+wRhy0yutJXDY72PI2wI7PhV4aAtn5a65gB8pHqudWdsyjbE4bE+H4YAAFzF
	Cc115Br1ykwCmuZT226G+yuZgrld9nmlnbAC7pZ79YpTIly9+FUtOlr6eoMsgt4XbFM1NRLOmox
	+wfOZ/vZaK+9QycwriscXIlPGezjw2XsGDQBAxG/CKdOIEKdMTOEi6FJt94WRnCzzBJJm9116ME
	sXu4eC/SVsS4r2TTCXISd70zvcaDzaHcKr+w6iA2xp2p7dldw7AhhjOnLAH1v2F43ReuGx5Gp/J
	5zb1WDc6TMkuGLtwpkRI2AExomINxCVHZGJIIhzwFyRHC4eSuLmeZ5tAIz/XmKy0uxu8hZj5Ehf
	bEU26ayFkN0KduCYRT4ZbsQI5Wd7b/McLY4qJaSIfvc/agxFkxBCPGNNEZ4smO1LxHtc9u43i2k
	J12v4SNk7lURJTkv+hG73x+5OTu+gmrxExHI0k4PVbu
X-Received: by 2002:a05:600c:1991:b0:493:e451:a9e1 with SMTP id 5b1f17b1804b1-4994e7448d9mr292813235e9.2.1786116155256;
        Fri, 07 Aug 2026 08:22:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d? ([2a0a:ef40:17bb:9901:c6b0:b529:d03b:36d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f9424sm40395785e9.8.2026.08.07.08.22.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 08:22:34 -0700 (PDT)
Message-ID: <98682fa4-55d9-4829-97f1-02e244b35266@gmail.com>
Date: Fri, 7 Aug 2026 16:22:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] rebase: guard non-branch symref targets
To: Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Son Luong Ngoc <sluongng@gmail.com>
References: <pull.2126.v2.git.1780482436865.gitgitgadget@gmail.com>
 <pull.2126.v3.git.1784708107.gitgitgadget@gmail.com>
 <a653f56ea214e74ea71ba31f5378f9cbf8b04dde.1784708107.git.gitgitgadget@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <a653f56ea214e74ea71ba31f5378f9cbf8b04dde.1784708107.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/07/2026 09:15, Son Luong Ngoc via GitGitGadget wrote:
> From: Son Luong Ngoc <sluongng@gmail.com>
> 
> A local branch symbolic ref may point outside refs/heads/. Such an alias
> cannot be skipped like a branch-to-branch alias because its concrete
> target ref is absent from the local branch decoration list.
> 
> However, queuing each alias independently can update the same target ref
> more than once and make the second compare-and-swap fail. A reservation
> from another worktree can also name either an alias or its resolved
> target ref, so checking only one form can miss an in-progress update.
> 
> Fix these cases by checking both the literal alias and its resolved
> target ref against checked-out reservations. Deduplicate updates by
> target ref. Also reserve both forms when loading another worktree's
> update-refs state. This makes different aliases honor the same
> in-progress update.
> 
> This keeps non-branch symrefs supported without allowing duplicate or
> cross-worktree ref updates.

I've left a couple of questions below. If you're short on time I'd 
suggest we just concentrate on getting the first patch merged as that 
fixes the common case of one branch being a symlink to another. We can 
worry about two branches being symlinks to a ref outside "refs/heads/*" 
later if it turns out to be a problem in practice.

> diff --git a/branch.c b/branch.c
> index 243db7d0fc..98a50d8368 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -442,10 +442,25 @@ static void prepare_checked_out_branches(void)
>   						     &update_refs)) {
>   			struct string_list_item *item;
>   			for_each_string_list_item(item, &update_refs) {
> +				char *resolved_ref;
> +				int flags = 0;
> +
>   				old = strmap_put(&current_checked_out_branches,
>   						 item->string,
>   						 xstrdup(wt->path));
>   				free(old);
> +
> +				resolved_ref = refs_resolve_refdup(
> +					get_main_ref_store(the_repository),
> +					item->string, RESOLVE_REF_READING,
> +					NULL, &flags);
> +				if (resolved_ref && (flags & REF_ISSYMREF)) {
> +					old = strmap_put(
> +						&current_checked_out_branches,
> +						resolved_ref, xstrdup(wt->path));
> +					free(old);
> +				}
> +				free(resolved_ref);
>   			}

After the last commit, when we prepare the todo list don't we skip any 
symbolic refs and only record their target? That would mean there 
shouldn't be any symbolic refs to resolve here. I do wonder if the 
earlier part of this function should be storing the symref and its 
target when it walks all the worktree HEADs. If we have a branch 
"refs/heads/feature" and a symref "refs/heads/symlink-to-feature" is it 
possible to have them checkedout in different worktrees because we only 
add HEAD to the list of checked out branches when we walk all the 
worktree HEADs?

>   			string_list_clear(&update_refs, 1);
>   		}
> diff --git a/sequencer.c b/sequencer.c
> index 63aba60a08..040b5bf645 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -6459,6 +6459,7 @@ struct todo_add_branch_context {
>   	size_t items_alloc;
>   	struct strbuf *buf;
>   	struct string_list refs_to_oids;
> +	struct string_list symref_update_targets;
>   };
>   
>   static int add_decorations_to_list(const struct commit *commit,
> @@ -6473,6 +6474,7 @@ static int add_decorations_to_list(const struct commit *commit,
>   	while (decoration) {
>   		struct todo_item *item;
>   		const char *path;
> +		const char *checked_ref;
>   		char *resolved_ref;
>   		int flags = 0;
>   		size_t base_offset = ctx->buf->len;
> @@ -6508,6 +6510,17 @@ static int add_decorations_to_list(const struct commit *commit,
>   		}
>   
>   		path = branch_checked_out(decoration->name);
> +		if (!path && resolved_ref && (flags & REF_ISSYMREF)) {
> +			checked_ref = resolved_ref;
> +			path = branch_checked_out(checked_ref);
> +		}
> +		if (!path && resolved_ref && (flags & REF_ISSYMREF) &&
> +		    string_list_has_string(&ctx->symref_update_targets,
> +					   resolved_ref)) {
> +			free(resolved_ref);
> +			decoration = decoration->next;
> +			continue;
> +		}

So we check the to see if the symref or its target are checked out. 
That's necessary because we might have stored a symref rather than its 
target in current_checked_out_branches above (which I think is probably 
a bug). If two branches are symrefs to the same ref we'll only queue the 
update once which is good.

Thanks

Phillip
>   		ALLOC_GROW(ctx->items,
>   			ctx->items_nr + 1,
> @@ -6523,6 +6536,10 @@ static int add_decorations_to_list(const struct commit *commit,
>   					      decoration->name, path);
>   		} else {
>   			struct string_list_item *sti;
> +
> +			if (resolved_ref && (flags & REF_ISSYMREF))
> +				string_list_insert(&ctx->symref_update_targets,
> +						   resolved_ref);
>   			item->command = TODO_UPDATE_REF;
>   			strbuf_addf(ctx->buf, "%s\n", decoration->name);
>   
> @@ -6554,6 +6571,7 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
>   	struct todo_add_branch_context ctx = {
>   		.buf = &todo_list->buf,
>   		.refs_to_oids = STRING_LIST_INIT_DUP,
> +		.symref_update_targets = STRING_LIST_INIT_DUP,
>   	};
>   
>   	ctx.items_alloc = 2 * todo_list->nr + 1;
> @@ -6579,6 +6597,7 @@ static int todo_list_add_update_ref_commands(struct todo_list *todo_list)
>   	res = write_update_refs_state(&ctx.refs_to_oids);
>   
>   	string_list_clear(&ctx.refs_to_oids, 1);
> +	string_list_clear(&ctx.symref_update_targets, 0);
>   
>   	if (res) {
>   		/* we failed, so clean up the new list. */
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 11afa8be56..110ed8ae63 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -2024,6 +2024,78 @@ test_expect_success '--update-refs updates refs correctly' '
>   	test_cmp expect err.trimmed
>   '
>   
> +test_expect_success '--update-refs checks resolved non-branch symref target' '
> +	test_when_finished "
> +		git worktree remove --force checked-out-target-wt &&
> +		git symbolic-ref -d refs/heads/non-branch-alias &&
> +		git tag -d checked-out-target
> +	" &&
> +	git tag checked-out-target HEAD~1 &&
> +	git symbolic-ref refs/heads/non-branch-alias refs/tags/checked-out-target &&
> +	git worktree add --detach checked-out-target-wt checked-out-target &&
> +	git -C checked-out-target-wt symbolic-ref HEAD refs/tags/checked-out-target &&
> +
> +	GIT_SEQUENCE_EDITOR="cat >todo" git rebase -i --update-refs HEAD~2 &&
> +
> +	test_grep "^# Ref refs/heads/non-branch-alias checked out at" todo &&
> +	test_write_lines refs/tags/checked-out-target >expect &&
> +	git symbolic-ref refs/heads/non-branch-alias >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--update-refs deduplicates non-branch symref targets' '
> +	test_when_finished "
> +		git symbolic-ref -d refs/heads/non-branch-alias-one &&
> +		git symbolic-ref -d refs/heads/non-branch-alias-two &&
> +		git tag -d shared-non-branch-target
> +	" &&
> +	git tag shared-non-branch-target HEAD~1 &&
> +	git symbolic-ref refs/heads/non-branch-alias-one \
> +		refs/tags/shared-non-branch-target &&
> +	git symbolic-ref refs/heads/non-branch-alias-two \
> +		refs/tags/shared-non-branch-target &&
> +
> +	GIT_SEQUENCE_EDITOR=: git rebase -i --force-rebase --update-refs HEAD~2 &&
> +
> +	test_cmp_rev HEAD~1 refs/heads/non-branch-alias-one &&
> +	test_cmp_rev HEAD~1 refs/heads/non-branch-alias-two &&
> +	test_write_lines refs/tags/shared-non-branch-target >expect &&
> +	git symbolic-ref refs/heads/non-branch-alias-one >actual &&
> +	test_cmp expect actual &&
> +	git symbolic-ref refs/heads/non-branch-alias-two >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success '--update-refs honors non-branch symref reservations' '
> +	test_when_finished "
> +		test_might_fail git worktree remove --force reserved-target-wt &&
> +		test_might_fail git symbolic-ref -d \
> +			refs/heads/reserved-non-branch-alias-one &&
> +		test_might_fail git symbolic-ref -d \
> +			refs/heads/reserved-non-branch-alias-two &&
> +		test_might_fail git tag -d reserved-non-branch-target
> +	" &&
> +	git tag reserved-non-branch-target HEAD~1 &&
> +	git symbolic-ref refs/heads/reserved-non-branch-alias-one \
> +		refs/tags/reserved-non-branch-target &&
> +	git symbolic-ref refs/heads/reserved-non-branch-alias-two \
> +		refs/tags/reserved-non-branch-target &&
> +	git worktree add --detach reserved-target-wt HEAD &&
> +	wt_gitdir=$(git -C reserved-target-wt rev-parse --absolute-git-dir) &&
> +	mkdir -p "$wt_gitdir/rebase-merge" &&
> +	old_oid=$(git rev-parse refs/heads/reserved-non-branch-alias-one) &&
> +	test_write_lines refs/heads/reserved-non-branch-alias-one \
> +		"$old_oid" "$old_oid" >"$wt_gitdir/rebase-merge/update-refs" &&
> +
> +	GIT_SEQUENCE_EDITOR="cat >todo" git rebase -i --update-refs HEAD~2 &&
> +
> +	test_grep "^# Ref refs/heads/reserved-non-branch-alias-one checked out at" \
> +		todo &&
> +	test_grep "^# Ref refs/heads/reserved-non-branch-alias-two checked out at" \
> +		todo &&
> +	test_grep ! "^update-ref refs/heads/reserved-non-branch-alias" todo
> +'
> +
>   test_expect_success 'respect user edits to update-ref steps' '
>   	git checkout -B update-refs-break no-conflict-branch &&
>   	git branch -f base HEAD~4 &&

