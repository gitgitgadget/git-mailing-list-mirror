Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847353;
	b=Vx9ThNFgqtL9Oxo8bjrI9y0r3tkZM+y+UmmblN7cG6Zg3mhogiQY34qLIs/vzEMWzG45
	 qqERlFOYGPewsmNA31t8ZXBGQQGf6kfPl+zVCh9WtsYFWdSX9HB39ABDcxL2iaZoC+CHc
	 XXzI7S2N39F3TA06RnHmM4QWSh2xrueFRxH0KOLBlp6OaeiyYAzF4jgHyySCM+oN4kVcb
	 CesIgWvfCaPDQqDYhoKvj+mbpWYXAPWhnBVEzchx8XTQldm1mxPLtDacI/AwF2eZsqa9b
	 1HhfJmFBDq2IvnZ1fKEHMRhZaOYtb6/Lj85Ba9aiirG9yJdl/wHV7hEFyPmaiDGMdMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Reply-To:Subject:To:Cc:
	 References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=+0QIYljr//ftsK/+rwPkMN2qc9aswl9YRi4ybc0oX1A=;
	b=EAkvNXOsaMOWcqNX1iaUZmA7MQsD++MNo589M/YZhv+xPtk7N9fPVX8P/e+f2diOt594
	 9LoUZdVHaCSOZc++qfNa8e9WdfprQO48a245fFi5xZsMVdQzx4pcef7RpABw/4MXLIvDX
	 iKYohCBvqu/aL3bYG6gh5qpS7WE6z9xJ8EsM/Wgz1lNWWwWHdirJ+UWrkibmhctY4Jegc
	 kh+Tum0X7uBLSdBZAjyrcjQawCf0cc9FwuV+l8F1+xoBwjLrotzYF1bAL+eiIwE8CVMas
	 C0DxVu7KQlRCkF/qxwnQ3ugJUOyciQK5hadeDo9hq6lApsBNpaFFXJWzlE9+rbMQnvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZOXb5u0;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FA606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 057FA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FZOXb5u0
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4b467581b98so31984425e9.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794847351; x=1795452151; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+0QIYljr//ftsK/+rwPkMN2qc9aswl9YRi4ybc0oX1A=;
        b=FZOXb5u03hNCxodEtBzOiQtfp9EPI1/7wLib5TzxQk6u5k86YtUrqMZH8mf0KxPzs5
         5B/RddjUr38O7bEYtAYq4WHSNVamnH+5CgAOGx4pzeRo2Lb12vOgIrC7CVFpsLFIseWi
         F1x+ySUeOI60CsLru2/SK5QqRMpltpNLPqKXW7w1i/qKheVOPEHVQQzlOsjREBNs1Jyo
         ZHjFvkqV9pmp0sRBf/mvr00Le+pORh1KmghBw7ji37Y8rjI6a3MrLCyXa4IEzRZsj9Jd
         NmmjSs4MltyQ9GwtkVL+4swFqD8HP8OQ5xq/BftYJeODtTOvZCFfhVRDPqxEfAf8xpoD
         LQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847351; x=1795452151;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+0QIYljr//ftsK/+rwPkMN2qc9aswl9YRi4ybc0oX1A=;
        b=JwR2ycW2AZYgzNMSt080Rbib+iw/Upz/m1E1Lp6Pjq3IsTurM2uVtHw1zaEqouuV5N
         GjED3IGlJME6xPe6NqkLC0ljoPU1bDsyQu/IRptiQpSIiRiw7qUCPbxDC+pOVs9PkczX
         1Myi1bIpOArqwgwZmhhQz0Zp0BSDxLRm7Oj483kGhsdLeO/noGN7ukXoSQheX78YL4vr
         cz77EFklMnXqkqCC0TBRsqmvWcw6T8FsKgbXEr/+4pOcXKClFoguxpkj0pPsFlloWxw6
         /Mn0rZ3VEJ6Sy7w6kh/Ljjs15HQO660vjAaeY6nNy3oCy4C2KVBq5dDFq5x+X434axX4
         zfsQ==
X-Forwarded-Encrypted: i=1; AL+hErEhkm5qA4yx0iulodO68osuwkJ9rRRq0jSMuWo2dEbGqGqcrEL2nVQvZtr94hNARpbo+CY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SRW7fKwdzCpW6nLrgBUtQYk7wiLDzwiDfNEQrlDL3MMEN3gp6
	NcjW5F9MkntEryDfXXjfkEhrfe8IJQXX0xAm/jFh0tlnjrEBdSSD/Asd0vEaQw==
X-Gm-Gg: AYBFou3YqnUFkJrHvFB7Om0O/Lwbd8zrH5jTUY411/5wtitfWTXcQFDkpdmB2MpFQlT
	p1IbKDK96PWhaVO1h4uun4fIc2D+JBGHRPgiHfR2qJYD3jHm2A8RLANbZf/YQ0xyXf9Ed3fszzz
	PA2+Z7ZtjpVOZd6fls0QqSc0skxXjSdynO54behvb/gJMvlH/Tfme8ns5zBlmBk15falr8hCjXo
	1Wfcf3bilrQB1BJbh9yy4kBUELMB1P+IJeOwMx03ymyjXfFvl/02D4Hig6Vk2gW256lwkrtxcqK
	e8+1PQvV+SPLcumd6O7dBZvJr8gZ2r4n1xBHkPC1REjgn1v5oz1E7uUIpRfV4MmXj3mD3IfKNuK
	tmrRhPWGdCynp/EMRp3OiYjkG0A+yciK2NrfOOu5ihLfQCg5BuJ/N2VTuyrlti7RKICSrUdzWrA
	m/niYkTN5McW/INCoySCCsGhXxXud32FTBxDWnbLgI0YDB5ZYpTj9J4lSXeSfjehGymX+f+Zd/N
	7vifGDfYVJaByurfr1mr/8gyk29nDXqF/xTdYtBwE+i8wwDMsewf70cFfbEF9nOzRzfUjFN610A
	x9ujlfKfPdczj6up+RJrq0j/GN9paQPqT+B/UmQ97C7guFoCUG0iUX3IUO5KKREjjmEqlAeFBSc
	4+7JF/tSA19/OekRY8KW13FzL7E9F
X-Received: by 2002:a05:600c:544:b0:4ba:2bfc:c8b5 with SMTP id 5b1f17b1804b1-4bb55a662f9mr156875825e9.10.1794847351060;
        Mon, 16 Nov 2026 08:42:31 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783965c8sm745565e9.9.2026.11.16.08.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 08:42:30 -0800 (PST)
Message-ID: <641e821d-ec7a-447c-8311-9cd395d9a5c5@gmail.com>
Date: Mon, 16 Nov 2026 16:42:29 +0000
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 4/5] ref-filter: add %(currentworktree)
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com,
 kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com,
 haraldnordgren@gmail.com
References: <20261102182930.3511-1-me@jaspermayone.com>
 <20261111152811.99986-1-me@jaspermayone.com>
 <20261111152811.99986-5-me@jaspermayone.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <20261111152811.99986-5-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

On 11/11/2026 15:28, Jasper Mayone wrote:
> %(worktreepath) names the worktree that has a branch checked out, or
> is rebasing or bisecting it, but a format cannot tell if that worktree
> is the current one. Comparing %(worktreepath) with a fixed path in
> %(if:equals=...) does not work for every path, because a ")" ends the
> atom.
> 
> Add %(currentworktree), which gives the path of the current worktree
> when that worktree has the branch, and an empty string otherwise.
> branch.c records these branches when it reads the worktrees, in a
> second map next to the one that %(worktreepath) uses, so the lookup is
> one map lookup per ref.

When I suggested %(currentworktree) I was imagining it would be a 
boolean format like %(HEAD) (i.e. it would print '*' if the ref was 
checked out in the current worktree). If we want to print the path 
instead, we should call it %(currentworktreepath) to match 
%(worktreepath). However, I'm not sure there is much value in printing 
the path, as that can be obtained with %(worktreepath).

While writing this email, I've just realized that %(HEAD) effectively 
tells us if we're in the current worktree, so another approach would be 
to extend that to handle branches that are being rebased or bisected, 
rather than adding a new format specifier. I haven't thought about it 
enough to have an opinion on whether that is a good idea.

A couple of thoughts on the implementation

1 - if a branch is checked out in two different worktrees it would be
     helpful if %(currentworktree) and %(worktreepath) agreed on which
     worktree to report. In practice that would mean %(worktreepath)
     always reporting the path of the current worktree if the branch is
     checked out there. With the implementation here, it is possible for
     them to report different worktrees.

2 - why are we using a hashmap to store a single entry? It would be more
     efficient to simply record the refname and path in separate strings
     and use strcmp(refname, current_worktree_branch) to determine
     whether refname is checked out in the current worktree. If we change
     to a boolean format we don't even need to record the worktree path.

Thanks

Phillip


> The next commit uses it in "git branch".
> 
> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Jasper Mayone <me@jaspermayone.com>
> ---
>   Documentation/git-for-each-ref.adoc |  7 +++++++
>   branch.c                            | 25 ++++++++++++++++++-------
>   branch.h                            |  7 +++++++
>   ref-filter.c                        | 10 ++++++++++
>   t/t6302-for-each-ref-filter.sh      | 21 +++++++++++++++++++++
>   5 files changed, 63 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-each-ref.adoc
> index 4456b4809a..5e2da92ee2 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -193,6 +193,13 @@ but if used together the last option is selected.
>   	the `NUL` after the path and then for the `LF` that ends each
>   	record.
>   
> +`currentworktree`::
> +	The absolute path to the current worktree, if the ref is checked
> +	out there, in the same sense as for `worktreepath`. Empty string
> +	otherwise, also when the ref is checked out only in other
> +	worktrees. Use it with `%(if)` to treat the current worktree
> +	differently from the others.
> +
>   `ahead-behind:<commit-ish>`::
>   	Two integers, separated by a space, demonstrating the number of
>   	commits ahead and behind, respectively, when comparing the output
> diff --git a/branch.c b/branch.c
> index 87f3ffc35f..4de789b7ae 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -386,6 +386,8 @@ static int initialized_checked_out_branches;
>   static struct strmap current_checked_out_branches = STRMAP_INIT;
>   /* Like current_checked_out_branches, without the "update-ref" branches. */
>   static struct strmap checked_out_worktrees = STRMAP_INIT;
> +/* The subset of checked_out_worktrees that the current worktree has. */
> +static struct strmap current_worktree_branches = STRMAP_INIT;
>   
>   enum branch_checkout_kind {
>   	BRANCH_CHECKOUT_KIND_CHECKOUT,
> @@ -404,11 +406,11 @@ static struct checked_out_branch *checked_out_branches;
>   static size_t checked_out_branches_alloc, checked_out_branches_nr;
>   
>   static void register_checked_out_branch(const char *prefix, const char *name,
> -					const char *path,
> +					const struct worktree *wt,
>   					enum branch_checkout_kind kind)
>   {
>   	char *refname = xstrfmt("%s%s", prefix, name);
> -	char *path_copy = xstrdup(path);
> +	char *path_copy = xstrdup(wt->path);
>   
>   	ALLOC_GROW(checked_out_branches, checked_out_branches_nr + 1,
>   		   checked_out_branches_alloc);
> @@ -418,8 +420,11 @@ static void register_checked_out_branch(const char *prefix, const char *name,
>   	checked_out_branches_nr++;
>   
>   	strmap_put(&current_checked_out_branches, refname, path_copy);
> -	if (kind != BRANCH_CHECKOUT_KIND_UPDATE_REF)
> +	if (kind != BRANCH_CHECKOUT_KIND_UPDATE_REF) {
>   		strmap_put(&checked_out_worktrees, refname, path_copy);
> +		if (wt->is_current)
> +			strmap_put(&current_worktree_branches, refname, path_copy);
> +	}
>   }
>   
>   static void prepare_checked_out_branches(void)
> @@ -443,7 +448,7 @@ static void prepare_checked_out_branches(void)
>   			continue;
>   
>   		if (wt->head_ref) {
> -			register_checked_out_branch("", wt->head_ref, wt->path,
> +			register_checked_out_branch("", wt->head_ref, wt,
>   						    BRANCH_CHECKOUT_KIND_CHECKOUT);
>   		}
>   
> @@ -451,7 +456,7 @@ static void prepare_checked_out_branches(void)
>   		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
>   		    state.branch) {
>   			register_checked_out_branch("refs/heads/", state.branch,
> -						    wt->path,
> +						    wt,
>   						    BRANCH_CHECKOUT_KIND_REBASE);
>   		}
>   		wt_status_state_free_buffers(&state);
> @@ -460,7 +465,7 @@ static void prepare_checked_out_branches(void)
>   		    state.bisecting_from) {
>   			register_checked_out_branch("refs/heads/",
>   						    state.bisecting_from,
> -						    wt->path,
> +						    wt,
>   						    BRANCH_CHECKOUT_KIND_BISECT);
>   		}
>   		wt_status_state_free_buffers(&state);
> @@ -471,7 +476,7 @@ static void prepare_checked_out_branches(void)
>   			struct string_list_item *item;
>   			for_each_string_list_item(item, &update_refs) {
>   				register_checked_out_branch("", item->string,
> -							    wt->path,
> +							    wt,
>   							    BRANCH_CHECKOUT_KIND_UPDATE_REF);
>   			}
>   			string_list_clear(&update_refs, 1);
> @@ -495,6 +500,12 @@ const char *branch_checked_out_worktree(const char *refname)
>   	return strmap_get(&checked_out_worktrees, refname);
>   }
>   
> +const char *branch_checked_out_current_worktree(const char *refname)
> +{
> +	prepare_checked_out_branches();
> +	return strmap_get(&current_worktree_branches, refname);
> +}
> +
>   const char *branch_bisecting(const char *refname)
>   {
>   	prepare_checked_out_branches();
> diff --git a/branch.h b/branch.h
> index 60cb92a3e4..744e1eec1d 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -115,6 +115,13 @@ const char *branch_checked_out(const char *refname);
>    */
>   const char *branch_checked_out_worktree(const char *refname);
>   
> +/*
> + * Like branch_checked_out_worktree(), but only for the current
> + * worktree: return its path if it has the branch 'refname' checked
> + * out, or is rebasing or bisecting it. Otherwise return NULL.
> + */
> +const char *branch_checked_out_current_worktree(const char *refname);
> +
>   /*
>    * If the branch at 'refname' is currently used for bisecting in a
>    * worktree, then return the path to that worktree.
> diff --git a/ref-filter.c b/ref-filter.c
> index b636e56199..498d09da8f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -142,6 +142,7 @@ enum atom_type {
>   	ATOM_HEAD,
>   	ATOM_COLOR,
>   	ATOM_WORKTREEPATH,
> +	ATOM_CURRENTWORKTREE,
>   	ATOM_ALIGN,
>   	ATOM_END,
>   	ATOM_IF,
> @@ -960,6 +961,7 @@ static struct {
>   	[ATOM_HEAD] = { "HEAD", SOURCE_NONE, FIELD_STR, head_atom_parser },
>   	[ATOM_COLOR] = { "color", SOURCE_NONE, FIELD_STR, color_atom_parser },
>   	[ATOM_WORKTREEPATH] = { "worktreepath", SOURCE_NONE },
> +	[ATOM_CURRENTWORKTREE] = { "currentworktree", SOURCE_NONE },
>   	[ATOM_ALIGN] = { "align", SOURCE_NONE, FIELD_STR, align_atom_parser },
>   	[ATOM_END] = { "end", SOURCE_NONE },
>   	[ATOM_IF] = { "if", SOURCE_NONE, FIELD_STR, if_atom_parser },
> @@ -2420,6 +2422,14 @@ static int populate_value(struct ref_array_item *ref, struct strbuf *err)
>   				v->s = xstrdup("");
>   			continue;
>   		}
> +		else if (atom_type == ATOM_CURRENTWORKTREE) {
> +			const char *path = NULL;
> +
> +			if (ref->kind == FILTER_REFS_BRANCHES)
> +				path = branch_checked_out_current_worktree(ref->refname);
> +			v->s = xstrdup(path ? path : "");
> +			continue;
> +		}
>   		else if (atom_type == ATOM_SYMREF)
>   			refname = get_symref(atom, ref);
>   		else if (atom_type == ATOM_UPSTREAM) {
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 317ed6f6cd..32522f1ff3 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -617,6 +617,27 @@ test_expect_success 'worktree atom ignores the HEAD of a bare repository' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'currentworktree atom' '
> +	test_when_finished "git -C current rebase --abort; rm -rf current; git worktree prune; git branch -D current" &&
> +	git worktree add -b current current main &&
> +	git -C current commit --allow-empty -m rebase-me &&
> +	test_must_fail git -C current rebase -f -x false main &&
> +	git for-each-ref --format="%(refname:short) [%(currentworktree)]" \
> +		refs/heads/main refs/heads/current >actual &&
> +	cat >expect <<-EOF &&
> +	current []
> +	main [$(pwd)]
> +	EOF
> +	test_cmp expect actual &&
> +	git -C current for-each-ref --format="%(refname:short) [%(currentworktree)]" \
> +		refs/heads/main refs/heads/current >actual &&
> +	cat >expect <<-EOF &&
> +	current [$(pwd)/current]
> +	main []
> +	EOF
> +	test_cmp expect actual
> +'
> +
>   test_expect_success 'start after with empty value' '
>   	cat >expect <<-\EOF &&
>   	refs/heads/main

