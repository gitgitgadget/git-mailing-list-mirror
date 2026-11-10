Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329162;
	b=Swf/pOzL3Y5UnOIEdCOYnJyfpXh6yIIegvWm4pNopkszuJFqCoLjoUU25cVVv8aPtFi0
	 8KnmTXaA5rKPqfLhuQabewCaXAl5O1KF4DJbnbLZzTQ+GTfFJVmTfZ4NXMn+S3NWOJtpt
	 e73XVEMlbdTYxuQqS4rVBXUzeAi5PAeRZPSQ7rZlQfXEy4Y5uXnMPZpn7+spwYWC2PXY8
	 6KhQ8bDT0o1i9fv5aqFTPK/+ABMAaN/ABfd86GsvF/Ik3j1HZqVwSEsQVoLTEugiL8GRk
	 RTwI6x8Qh2AsDkQqdX8WDX21NQ39QFdn8+arXV0YgmnDjZq82+HKhcP/nvebfW93ucQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:From:Reply-To:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dA+aK2gtLOB6QdqhQuHkI/1ywL3+ePXLNpcO2AMj1ls=;
	b=dAxa/hO41zTEuXNumhxldH9W2UQyGu7KIyvU617h4d227Eb8RL94FnGKfApEQz6nEUIj
	 OPqHAg59b6eOekFFs5tHM8EZKW68zu2vF0gPpQYoXR+T5xwc3X9tYdyWVPWzjBd+SqiY+
	 SJsSlFoJ6xPkj9U8zZoz+2ETTXCJ41k4jzrl7RQTHsWE884UWjM7oGqX+E7EsAOasEssp
	 nMzpyDbOwD9AFRtpI1Sq507gd1G51Elk3/jvoFauHXvp2/8NLfDfXMuYjf472aYHjwO6n
	 sU6w9vTELmUgTmI87e/vjtMwZOzqHU6RskGMLHFKH6nzbY6OsNwTbCxll7062cmsWrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Srw93Tz6;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061FC60A3812
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 16:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 061FC60A3812
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Srw93Tz6
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so22773225e9.3
        for <git@vger.kernel.org>; Tue, 10 Nov 2026 08:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794329160; x=1794933960; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dA+aK2gtLOB6QdqhQuHkI/1ywL3+ePXLNpcO2AMj1ls=;
        b=Srw93Tz6xbUS2RGTgNrxbd864Swg1AuUQRywtyenj925GskIK8d4yzWx8NhBNFB5Bm
         51Vn5LRhtZ1AuRpJrJsVZj0Z1uHJfN2+40HTWKF70JLA4fIaEfp9/iSkBSFBnn/8yD+r
         LaOOMdqdptTRR8c7hWLQxYzYLI873BR9MlC4Web22UYbCXVksevg2oQND63WibllrjFH
         quuPVseobgMvtRxuKwMvH9r+WC/Q1Z0/SNssLHRKuUbBoHxAWiDpHWsv95exTZ5sz+dH
         G0dUP0zTJ9nF0/7kfGXnQh5mJXoL5XjJya3LgZhvH+4ErqXg30G8xBJ2RiwC/t/YMXRh
         hfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794329160; x=1794933960;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dA+aK2gtLOB6QdqhQuHkI/1ywL3+ePXLNpcO2AMj1ls=;
        b=b20uo2Y01Khq2BP4q86FcfYmchWrreXOoOFjuAQkKXbeMjwEaaU38ZC6dIROO5q4QD
         kl04jzbK9JmoTJLNpcQun+UOGRTDNrSQ4kgZI2/qVB1kZzR5cDntvs0wnBCARlvWmldj
         nNOSFWogTl/XEDLH9T6KAnlvDdyRA5yuRheqEpa8TOxGiFMyo9WBdhmaPg2QV1IP02Qc
         UbIz2H+FbW4zDHtWdL971u3s2yS3B8WXD04AFcXZcSQ9aqopuLyzyezBDSLnY3x+smKm
         jMuhj+zKm+zoNJL0SE2fqIjC1puOaF8ZO69xa7GGVqP+uwUpMpeDG4dsuk/NVfGNpgcB
         n2Ng==
X-Forwarded-Encrypted: i=1; AL+hErFz01oeCEORtnHSh+EyikVNCX2Unp5OtCL2FFRUbQEQ5s/ip7gp7ED/IoENum28NDSW0hA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9nE28v2hxhzhvulJ9I0AKh4Gc1EcCkDaiLPl7gVlGW/ZzfTvbg
	00LrJ3XBYCnHwLhhfP2HSIQTDdtbnxCYq5ceZmWEMYVxKZgqNgRooRDV
X-Gm-Gg: AYBFou1WaER0P3To6sZQd4nBLibDd4edG8ihEfIlee8ZhekZkYc0hZ1jEMUe1Gcwnmj
	tHIwbr5nteYnY67drJ3JTUvsp7WNUpaacJ3pv2E2Vdahoh6MHog9kZ80idk3IHDe5hoUubM1jI5
	Fzz6sYpz67KeFaKDf2KoEsGWhb9D7IBctwlfDYId5FxyX9g27dWElGf/Tye2Oft8u7XFtPIIJex
	LSU/yI40eTuFesjZR/WttfaV7Ij8Nz9jL/UmoTJi7ct7hC4uS/5vhRcTLCWNZJ/g+Qak9L13D5i
	sAfndL5TNCGtOJG4PvfaDspM0xp2RGOpXFaRk9MZOar38JABTaw/nVcmoyWqJkG5aKqRdKX1sl8
	ROWUgkL1yE2NKWRRWvW/xScXNl2HV00QxGWSkqqZcKBeuigsVK2WTCpe2Z4lBpkZZ6UBvPJhqJW
	spCE+MvH7vXk36mo4BHgN8Yuj565bZS3YdEVujeOgx0MfTtV8pkf0wAYz4ZF9GeJd0YeW0RgEHb
	zPIeUKffGdySIhKsN5cP6k/4LKDSh2gmCKGaGBgpahGM5ce0tRb6Opf+DSJ9F9ypGfFh9TR5LMj
	doFrw/TI39/jSKg2AJYSU+gHfnhjuvqYsu+JdL3DMLUOTbMxCJ4DX/4vmQtXF89Gj4VfWUkfoga
	XM9CQywGoQwYAmPUWiTJTsDohwubI
X-Received: by 2002:a05:600c:4e41:b0:4b7:6942:39be with SMTP id 5b1f17b1804b1-4ba0234ed60mr54385155e9.24.1794329160157;
        Tue, 10 Nov 2026 08:46:00 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0233f95dsm49540165e9.1.2026.11.10.08.45.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Nov 2026 08:45:59 -0800 (PST)
Message-ID: <b0d8b454-2e7d-49a5-8d3f-030af1c3768b@gmail.com>
Date: Tue, 10 Nov 2026 16:45:58 +0000
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
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 4/4] branch: do not mark the branch the current
 worktree is rebasing
To: Jasper Mayone <me@jaspermayone.com>, git@vger.kernel.org
Cc: gitster@pobox.com, sunshine@sunshineco.com,
 kristofferhaugsbakk@fastmail.com, ben.knoble@gmail.com,
 haraldnordgren@gmail.com
References: <20261030142137.54750-1-me@jaspermayone.com>
 <20261102182930.3511-1-me@jaspermayone.com>
 <20261102182930.3511-5-me@jaspermayone.com>
Content-Language: en-US
In-Reply-To: <20261102182930.3511-5-me@jaspermayone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jasper

On 02/11/2026 18:29, Jasper Mayone wrote:
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index a613148fc7..b55a400217 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -418,16 +418,28 @@ static const char *quote_literal_for_format(const char *s)
>   	return buf.buf;
>   }
>   
> -static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
> +/*
> + * With "show_worktree" unset, the format does not mark a branch that is
> + * checked out in a worktree, nor show the path of that worktree. It is

What is "It" here

> + * used for a branch that the current worktree is rebasing or bisecting,
> + * because the "(no branch, ...)" line already names it.

I'm not sure what is being named - do you mean "it already shows the 
branch name"?


In any case there are a lot of code changes here which is surprising for 
what I had hoped would be a simple tweak. If we added a 
'%(currentworktree)' format specifier, which should be relatively easy 
as we can use the hash map of branches to checked out worktrees to look 
up the worktree and check "wt->is_current" then

     %(if)%(worktreepath)%(then)%(if)%(currentworktree)%(then)%(else)+ 
%(else)  %(end)%(end)

labels checked out worktrees with "+ " if they are not the current worktree.

Thanks

Phillip

> + */
> +static char *build_format(struct ref_filter *filter, int maxwidth,
> +			  const char *remote_prefix, int show_worktree)
>   {
>   	struct strbuf fmt = STRBUF_INIT;
>   	struct strbuf local = STRBUF_INIT;
>   	struct strbuf remote = STRBUF_INIT;
>   
> -	strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
> -			branch_get_color(BRANCH_COLOR_CURRENT),
> -			branch_get_color(BRANCH_COLOR_WORKTREE),
> -			branch_get_color(BRANCH_COLOR_LOCAL));
> +	if (show_worktree)
> +		strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)%%(if)%%(worktreepath)%%(then)+ %s%%(else)  %s%%(end)%%(end)",
> +			    branch_get_color(BRANCH_COLOR_CURRENT),
> +			    branch_get_color(BRANCH_COLOR_WORKTREE),
> +			    branch_get_color(BRANCH_COLOR_LOCAL));
> +	else
> +		strbuf_addf(&local, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %s%%(end)",
> +			    branch_get_color(BRANCH_COLOR_CURRENT),
> +			    branch_get_color(BRANCH_COLOR_LOCAL));
>   	strbuf_addf(&remote, "  %s",
>   		    branch_get_color(BRANCH_COLOR_REMOTE));
>   
> @@ -447,8 +459,9 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>   
>   		if (filter->verbose > 1)
>   		{
> -			strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
> -				    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
> +			if (show_worktree)
> +				strbuf_addf(&local, "%%(if:notequals=*)%%(HEAD)%%(then)%%(if)%%(worktreepath)%%(then)(%s%%(worktreepath)%s) %%(end)%%(end)",
> +					    branch_get_color(BRANCH_COLOR_WORKTREE), branch_get_color(BRANCH_COLOR_RESET));
>   			strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
>   				    "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
>   				    branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));
> @@ -477,6 +490,32 @@ static char *build_format(struct ref_filter *filter, int maxwidth, const char *r
>   	return strbuf_detach(&fmt, NULL);
>   }
>   
> +static char *current_worktree_path(void)
> +{
> +	struct worktree **worktrees = get_worktrees(the_repository);
> +	char *path = NULL;
> +
> +	for (size_t i = 0; worktrees[i]; i++) {
> +		if (worktrees[i]->is_current) {
> +			path = xstrdup(worktrees[i]->path);
> +			break;
> +		}
> +	}
> +	free_worktrees(worktrees);
> +	return path;
> +}
> +
> +/*
> + * Is "refname" checked out in the worktree at "here", or is that
> + * worktree rebasing or bisecting it?
> + */
> +static int checked_out_here(const char *refname, const char *here)
> +{
> +	const char *path = branch_checked_out_worktree(refname);
> +
> +	return path && !strcmp(path, here);
> +}
> +
>   static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting,
>   			   struct ref_format *format, struct string_list *output)
>   {
> @@ -485,6 +524,9 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>   	int maxwidth = 0;
>   	const char *remote_prefix = "";
>   	char *to_free = NULL;
> +	struct ref_format here_format = REF_FORMAT_INIT;
> +	char *here_to_free = NULL, *here = NULL;
> +	struct strbuf out = STRBUF_INIT, err = STRBUF_INIT;
>   
>   	/*
>   	 * If we are listing more than just remote branches,
> @@ -501,39 +543,54 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>   	if (filter->verbose)
>   		maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
>   
> -	if (!format->format)
> -		format->format = to_free = build_format(filter, maxwidth, remote_prefix);
> +	if (!format->format) {
> +		format->format = to_free = build_format(filter, maxwidth,
> +							remote_prefix, 1);
> +		here = current_worktree_path();
> +		here_format = *format;
> +		here_format.format = here_to_free = build_format(filter, maxwidth,
> +								 remote_prefix, 0);
> +	}
>   	format->use_color = branch_use_color;
> +	here_format.use_color = branch_use_color;
>   
> -	if (verify_ref_format(format))
> +	if (verify_ref_format(format) ||
> +	    (here && verify_ref_format(&here_format)))
>   		die(_("unable to parse format string"));
>   
>   	filter_ahead_behind(the_repository, &array);
>   	ref_array_sort(sorting, &array);
>   
> -	if (column_active(colopts)) {
> -		struct strbuf out = STRBUF_INIT, err = STRBUF_INIT;
> -
> +	if (column_active(colopts))
>   		assert(!filter->verbose && "--column and --verbose are incompatible");
>   
> -		for (i = 0; i < array.nr; i++) {
> -			strbuf_reset(&err);
> -			strbuf_reset(&out);
> -			if (format_ref_array_item(array.items[i], format, &out, &err))
> -				die("%s", err.buf);
> +	for (i = 0; i < array.nr; i++) {
> +		struct ref_array_item *item = array.items[i];
> +		struct ref_format *f = format;
>   
> +		if (here && checked_out_here(item->refname, here))
> +			f = &here_format;
> +
> +		strbuf_reset(&err);
> +		strbuf_reset(&out);
> +		if (format_ref_array_item(item, f, &out, &err))
> +			die("%s", err.buf);
> +
> +		if (column_active(colopts))
>   			/* format to a string_list to let print_columns() do its job */
>   			string_list_append(output, out.buf);
> +		else if (out.len || !format->array_opts.omit_empty) {
> +			fwrite(out.buf, 1, out.len, stdout);
> +			putchar('\n');
>   		}
> -
> -		strbuf_release(&err);
> -		strbuf_release(&out);
> -	} else {
> -		print_formatted_ref_array(&array, format);
>   	}
>   
> +	strbuf_release(&err);
> +	strbuf_release(&out);
>   	ref_array_clear(&array);
>   	free(to_free);
> +	free(here_to_free);
> +	free(here);
>   }
>   
>   static void print_current_branch_name(void)
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index debfac5f26..5541f1429b 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -456,6 +456,23 @@ test_expect_success 'branch being rebased in a worktree is marked' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'branch being rebased is not marked in its own worktree' '
> +	test_when_finished "git -C rebase_dir rebase --abort; rm -rf rebase_dir; git worktree prune; git branch -D rebasing" &&
> +	git worktree add -b rebasing rebase_dir branch-two &&
> +	(
> +		cd rebase_dir &&
> +		git commit --allow-empty -m rebase-me &&
> +		test_must_fail git rebase -f -x false HEAD~1 &&
> +		git branch --list rebasing >actual &&
> +		echo "  rebasing" >expect &&
> +		test_cmp expect actual &&
> +		git branch -vv --list rebasing >actual &&
> +		test_grep ! "$(pwd)" actual &&
> +		git branch >actual &&
> +		test_grep "^\* (no branch, rebasing rebasing)" actual
> +	)
> +'
> +
>   test_expect_success 'branch being bisected in a worktree is marked' '
>   	test_when_finished "git -C bisect_dir bisect reset; rm -rf bisect_dir; git worktree prune; git branch -D bisecting" &&
>   	git worktree add -b bisecting bisect_dir branch-two &&
> @@ -464,7 +481,10 @@ test_expect_success 'branch being bisected in a worktree is marked' '
>   		git commit --allow-empty -m bisect-one &&
>   		git commit --allow-empty -m bisect-two &&
>   		git bisect start HEAD HEAD~2 &&
> -		test_must_fail git symbolic-ref -q HEAD
> +		test_must_fail git symbolic-ref -q HEAD &&
> +		git branch --list bisecting >actual &&
> +		echo "  bisecting" >expect &&
> +		test_cmp expect actual
>   	) &&
>   	git branch --list bisecting >actual &&
>   	echo "+ bisecting" >expect &&

