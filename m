Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463F927B33B
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 09:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771320191; cv=none; b=lY/sUUZzorYEHq6f1LPLR7w9+VFAMdaEy8nfNChna3XlmUIscLWPsMhl+/aTlFGXAMIYbExRD1+SZZ+j6e7WBFxtH6ThahxvTBpqEX+Lg1J9kBSx9E1dsyytIx07b44kUSHpUD7zgh3uxxmjfVKRmY1VD2QOjDnpks0jbYWl1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771320191; c=relaxed/simple;
	bh=LTHE/iFvgKrKgIB1jLzbBnylve/xa8LsWxhJE2sjnf8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S1eQBRO7Xo8BxkYvt2uf9NB5ml8uEWBxQ+3G8+MpbsJj/r/X0t+yzQC5DY+cFWPu3TvWsGOeqCyCfHLVSRTUDpeHDH5QfCw9gIftgiHuoPMZxdT2T0GL2DNPT56sDWlujIJehoHj3hAGJesUw8+fG+6yTkPJKCxBEW9IJaGc1Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbWRGG1f; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbWRGG1f"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so39089555e9.2
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 01:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771320188; x=1771924988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qlqgswl4BlHe/UVgkETCSYGFBzXDMxDQy5IcSu5WIUM=;
        b=nbWRGG1fap+09RboyEkOhT+cqIE/lbWGQh68RK6yWJtS0TGaDZ3QHzaGwg5qxCE320
         oQ9pQumMT/2/Zw4dtEcuHp/vjMfEU/HKvjmyzkkZl1ojqLRAc/DspgsxIJSxgQSIUafZ
         FLFKED+2om26mS/V7gChbRbbvUc1Gfg614AaL2OzL8EPbrPf64bO9kCXl+ynrOlMvEqx
         QTU5Svit46OCX7ia/uNHO+T3aIPmYmNfpuBXZ1eiTqb9sqhof4XrJzDrxVNfEUzLPZNW
         FZREX3mNaZS2GPMkDbIOJ4yU7SxP4CLU3iXeUAjcCnCDKWmbS59E12+uCcxy+gBAmSS4
         wCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771320188; x=1771924988;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qlqgswl4BlHe/UVgkETCSYGFBzXDMxDQy5IcSu5WIUM=;
        b=o5SBssXtMDq1ryJ3sJtX8sttNPLEOnRvHAdNoKueUxYVgknIOHmzP7SDuU7wu63jgH
         VbweUlpv3ZtxDy6QmMd08ozuT0ymb/jPymfXuk6wlvmz7lfq1hiU3wlAETG91UBvPF89
         ItVXEu1iPP1ki3TEIEMOXLzQa3c1c0N/Vu+5LbPguIicd61prK8cOC/N8ng4+bxmoLuE
         myW0UwCILoV+mVqwq5p4sXKqJPUyTjQAbXP8gPScxxlh7LOs+ouewPDE/mRfac8eS+Sd
         QtCRiEkyEodAjiECi2AjtFvkMcLgy+JsADYEnV3mshaPh1JFLscXL0BIaByPjqgPt9Kq
         u9vw==
X-Forwarded-Encrypted: i=1; AJvYcCURK2Wl5fAu2c98hoC+ccLTm/SGYekiHm0wlugXWqiCk7XmZ1/GYDLvQ5c5ICPiWKKXiv0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYiP7cDVC4IvMYbz/ASrAsCv3EW4/vzudP6/ylrvC+psHbr9C1
	oAp2YpezTZUAYdeSBENKXHBlH8aWyPe24N2sk1oda86hNknmBGy6NCJ/
X-Gm-Gg: AZuq6aLJ5fhKZO0lIfGbdEWMgQVXOHZUIBNzaq5DBnGRYyccg7qVyy2WQrzxNnI2RG3
	adC5xmYP+xj9iedBCqWrqNKcFqs2gVV8u67jb5pLXvBu628AzRqCzSdsKLM/JKKF7I9yz9iiVW3
	JdqQAjs+IYKhsWYXzZvCp2Cl8pT8N5RjZJ2R//CuoYbvTI+tHJJNs7IEjVAvdZ17yIK2qKFTZxD
	XXZ6ZTe9bTBL3loT8uKJkb0zwHNTqWw0z/en4GsWSWCzaTgrjn8f+U4SL6rTl/Q0WUV22v9u2yd
	GMplpND182sOs4jSV9Y2fx2yaIMOJ9JHdJFixZsAuuUPXz1C24KOgI8NZX7hznry73pQuFyh3gF
	8WRCdJHOBV7Lu7yNEuYXpXmKsNsSfiBhlhEsmmlGG2Cn9GN5sweNybWyZQTtoYZYQmrmMtYBkVX
	UEcSAqrAAvkDyszjoKwVYEBa9g1ZwH6+3BQrv+K3lJblktohJCitWfhJo8KsFw5LEfiSB+7jTI6
	0AF5A==
X-Received: by 2002:a05:600c:3145:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-48373a74362mr208249105e9.30.1771320188151;
        Tue, 17 Feb 2026 01:23:08 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:68d:f601:6840:9d65:3109:8533? ([2a0a:ef40:68d:f601:6840:9d65:3109:8533])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6c1b4sm31274044f8f.14.2026.02.17.01.23.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 01:23:07 -0800 (PST)
Message-ID: <89c78ce2-1783-416d-9ae5-ef51f6bde58d@gmail.com>
Date: Tue, 17 Feb 2026 09:23:04 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
To: Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>,
 Karthik Nayak <karthik.188@gmail.com>
References: <ebc16a74-0555-4951-8ec6-ff7fce6b6fcc@gmail.com>
 <cover.1771258688.git.phillip.wood@dunelm.org.uk>
 <409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <409871a7d521b76c9eb811d3c49747e04de8defc.1771258688.git.phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16/02/2026 16:18, Phillip Wood wrote:
> 
> +struct worktree *get_worktree_from_repository(struct repository *repo)
> +{
> +	struct worktree *wt = xcalloc(1, sizeof(*wt));
> +	char *gitdir = absolute_pathdup(repo->gitdir);
> +	char *commondir = absolute_pathdup(repo->commondir);
> +
> +	wt->repo = repo;
> +	if (repo->worktree)
> +		wt->path = absolute_pathdup(repo->worktree);
> +	wt->is_bare = !!repo->worktree;
> +	if (fspathcmp(gitdir, commondir))
> +		wt->id = xstrdup(find_last_dir_sep(commondir) + 1);

Oops s/commondir/gitdir/ - I'll wait to see if there are any other 
comments before re-rolling (perhaps with a test that runs git status on 
a rebase in a linked worktree)

Thanks

Phillip

> +	wt->is_current = is_current_worktree(wt);
> +	add_head_info(wt);
> +
> +	free(gitdir);
> +	free(commondir);
> +	return wt;
> +}
> +
>   /*
>   * When in a secondary worktree, and when extensions.worktreeConfig
>   * is true, only $commondir/config and $commondir/worktrees/<id>/
> diff --git a/worktree.h b/worktree.h
> index e4bcccdc0ae..b162bbabd50 100644
> --- a/worktree.h
> +++ b/worktree.h
> @@ -38,7 +38,10 @@ struct worktree **get_worktrees(void);
>    */
>   struct worktree **get_worktrees_without_reading_head(void);
>   
> -/*
> +/* Construct a struct worktree from a struct repository */
> +struct worktree *get_worktree_from_repository(struct repository *repo);
> +
> + /*
>    * Returns 1 if linked worktrees exist, 0 otherwise.
>    */
>   int submodule_uses_worktrees(const char *path);
> diff --git a/wt-status.c b/wt-status.c
> index 95942399f8c..2debda534c1 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1747,6 +1747,9 @@ int wt_status_check_rebase(const struct worktree *wt,
>   {
>   	struct stat st;
>   
> +	if (!wt)
> +		BUG("wt_status_check_rebase() called with NULL worktree");
> +
>   	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
>   		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
>   			state->am_in_progress = 1;
> @@ -1774,6 +1777,9 @@ int wt_status_check_bisect(const struct worktree *wt,
>   {
>   	struct stat st;
>   
> +	if (!wt)
> +		BUG("wt_status_check_bisect() called with NULL worktree");
> +
>   	if (!stat(worktree_git_path(the_repository, wt, "BISECT_LOG"), &st)) {
>   		state->bisect_in_progress = 1;
>   		state->bisecting_from = get_branch(wt, "BISECT_START");
> @@ -1819,18 +1825,19 @@ void wt_status_get_state(struct repository *r,
>   	struct stat st;
>   	struct object_id oid;
>   	enum replay_action action;
> +	struct worktree *wt = get_worktree_from_repository(r);
>   
>   	if (!stat(git_path_merge_head(r), &st)) {
> -		wt_status_check_rebase(NULL, state);
> +		wt_status_check_rebase(wt, state);
>   		state->merge_in_progress = 1;
> -	} else if (wt_status_check_rebase(NULL, state)) {
> +	} else if (wt_status_check_rebase(wt, state)) {
>   		;		/* all set */
>   	} else if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD") &&
>   		   !repo_get_oid(r, "CHERRY_PICK_HEAD", &oid)) {
>   		state->cherry_pick_in_progress = 1;
>   		oidcpy(&state->cherry_pick_head_oid, &oid);
>   	}
> -	wt_status_check_bisect(NULL, state);
> +	wt_status_check_bisect(wt, state);
>   	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") &&
>   	    !repo_get_oid(r, "REVERT_HEAD", &oid)) {
>   		state->revert_in_progress = 1;
> @@ -1848,6 +1855,8 @@ void wt_status_get_state(struct repository *r,
>   	if (get_detached_from)
>   		wt_status_get_detached_from(r, state);
>   	wt_status_check_sparse_checkout(r, state);
> +
> +	free_worktree(wt);
>   }
>   
>   static void wt_longstatus_print_state(struct wt_status *s)

