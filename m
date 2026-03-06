Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF2D3B8934
	for <git@vger.kernel.org>; Fri,  6 Mar 2026 18:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772820143; cv=none; b=Jk2j17RyLIqq0lCWZvLSFurwwLKkUIBgutUn5rr1jlGUdwjpJkdn4Urn/K71T209gq85xs1eqlvIYewsvc9IEf61adpb1D/rfX9SLAubqsExmPmZ+eQH2YXEtoraOpt+8806nV+ZEm+UE8FkViEe6Fia5fTKiPOZB/vJ/+mOyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772820143; c=relaxed/simple;
	bh=quuVgXTVzdNsXyCh4vPFuslxwbmiUa7+q8LiWW4gDqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V7US1RZHIEy2OGajpN5EFPh2XbboVrmPWvPnUGVEfT8PC7CyRwii+FLRqyw6qzh4dDF+GpPH8GijWGDUeQaSM4+STBnUWz5xoetX7C8+95jjT1v2DWTs7KHc4dwWBSwq6AgUgPO7cjWMWQlyRQHbjjehS+rbtd3MupCUMb2QUY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnSni/3G; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnSni/3G"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ae3bd422d2so1663075ad.2
        for <git@vger.kernel.org>; Fri, 06 Mar 2026 10:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772820142; x=1773424942; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F7/uEWW4dz5LEYNopqBtFNp0nZOvaYac3O501QStSOc=;
        b=jnSni/3G2Bxx16bubIqNVt77zeTItnD8zBafzNE+xhZvGAXqcZ94MXCo7mdT4SfiCU
         Y7qtEnrlyFrQAIHA6Pf89UNUh5XD+V+HhYuJTA0Mfbu61LPGtDOiviDgn/JR8xTHM6Jm
         VjjOz2zIMDKhskOb2to/n56LcYfSbqjvv4fm5V9dNZNKTo2DgVoflmDfEmUqjWSQpQdQ
         WvPiX5JmsCKiTsVCgdo9MhnwpXzrXqTq+52orFLBR9hhPd9qq2jGwUq6IBJMhDZH1nLT
         KBasj7waMXTwjF2Urc1QX52gTFKDvNm8wJoA2oS89qtfmSNamnqz5CqLIOuSKsLkVWt8
         kvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772820142; x=1773424942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F7/uEWW4dz5LEYNopqBtFNp0nZOvaYac3O501QStSOc=;
        b=B/Tprnl2hVyj0BtgYHF15Dyi0DDpDykEyfRrJdKcUn4us0ZTfuc8/sWV+JAzdPskUQ
         GSvBc7U1awsxAjRpi1vlKmLiNLYRUmxqbMo3j9hdP9dJ0YbTEUm0z5Mu41vM1UmjVcIC
         XWDsT9C4BRfs4swwhgpNk7INJRXUV7ILPbPfG5Ay1U3yVAjtEq5u4tVawTgEXKML2CvU
         1wGPkbebZWDfoYfc+MarQphlp5FB8jvx2ycdHTXEx/qeNsOa0Gu4gtwyBhBGHGxzMqN2
         ryUDYLLQ9oZTbUgxcb00syou4RBQWDBO3dNF4PYR4J/sBap4xtU8o9kVjFSTO8UxdH7F
         sGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUohlUY2eDxw8eYDVGs4vETyQ/oRgtwnoX7iRPPiJTLIDVUN4R4u4OIH2akhgxZw4vIUGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3TAlSWaVjFUPA9xOdrSjP59dc07kPB/30aeBcf/P6qrTIvdJe
	xnlMy+hS3T+NyvcZEyyV3zvpexzaLnqM793Y4MfNbNoWll9w+LOW0aBsxzBDBQ==
X-Gm-Gg: ATEYQzzoznUNee+/Qum8ajYhnz8K3R9PN+sdJqS6321YSqFZL7Hu/kj7dRp47+7RsGq
	lzlM6yRqver+5W1F30YXVKLFGBqvp6oR8lHMSH2Vsjy5bJzaE230PSMve37IVWufIPlOVNZfy8P
	/P92mKdlNo52Mc+uPSnXED9798mpzZ019iaYRU4pOXk2R7oaui60Duc33H/laCzyFqomWDvSxxa
	Pq5JXZyOw2UMnsYH5PurK38uabimT2kdkJpVicKsHmWCaoKlwbwf04KqWZsUlkY/HMk85NnKShH
	rjmi1S/D41hjfGQ+BAfxEKC3jPrJ4e4fQwCuiZFv1NM0IfFxl34BU5eFjoSlazLA0Cba6WDeWr2
	czt/xYrXxi5sfmT2jAAj41/um3AKAGs8nX5S7zNCrrN3jFhEVNFan3MOUPIgbkpMI3agw9qVpBS
	LrcI/irdCnFkHO0jOM/0tKOGmup82BZBD8STS1vr1kgj8K78gbdIyFyIV7FwjW8o6SNE3irUcjB
	f49v7a+wDgp
X-Received: by 2002:a17:902:c94a:b0:2ae:4999:218f with SMTP id d9443c01a7336-2ae824163ffmr26234735ad.2.1772820141475;
        Fri, 06 Mar 2026 10:02:21 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e57afesm26565185ad.6.2026.03.06.10.02.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2026 10:02:21 -0800 (PST)
Message-ID: <24f40e5a-a5fd-49ec-86e7-921b44e4abd9@gmail.com>
Date: Sat, 7 Mar 2026 02:02:18 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Refactor 'trust_executable_bit' to repository-scoped
 setting
To: drona <dronarajgyawali@gmail.com>, git@vger.kernel.org
References: <20260301190017.53539-1-dronarajgyawali@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260301190017.53539-1-dronarajgyawali@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi drona,

On 3/2/26 02:59, drona wrote:

> This patch moves 'trust_executable_bit' into 'struct repo_settings', making
> it a repository-scoped configuration. All references in files have been updated to use
> 'the_repository->settings.trust_executable_bit'.

The original intent of this patch should be sound.

> Why this is a good candidate:
> - It's a self-contained global variable that only affects file mode logic.
> - Low risk: changes only impact mode calculations and related apply/update
>    operations.
> - Makes Git codebase more maintainable and prepares for future multi-repo
>    support.
> 
> - Manual sanity check with a test repo confirms executable bits behave correctly.
> 
> Signed-off-by: Dorna Raj Gyawali <dronarajgyawali@gmail.com>
> ---
>   apply.c                |  4 ++--
>   builtin/update-index.c |  2 +-
>   diff-lib.c             | 10 +++++-----
>   environment.c          |  3 +--
>   environment.h          |  1 -
>   read-cache.c           | 10 +++++-----
>   read-cache.h           | 11 +++++++----
>   repo-settings.h        |  6 +++++-
>   8 files changed, 26 insertions(+), 21 deletions(-)
> 
> diff --git a/apply.c b/apply.c
> index d044c95d50..2bcb22a4bc 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3838,8 +3838,8 @@ static int check_preimage(struct apply_state *state,
>   		if (*ce && !(*ce)->ce_mode)
>   			BUG("ce_mode == 0 for path '%s'", old_name);
>   
> -		if (trust_executable_bit || !S_ISREG(st->st_mode))
> -			st_mode = ce_mode_from_stat(*ce, st->st_mode);
> +		if (the_repository->settings.trust_executable_bit  || !S_ISREG(st->st_mode))
> +			st_mode = ce_mode_from_stat(the_repository, *ce, st->st_mode);
>   		else if (*ce)
>   			st_mode = (*ce)->ce_mode;
>   		else

You can run git diff --check before committing. There's an extra space 
here.

> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 8a5907767b..7917bd286f 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -293,7 +293,7 @@ static int add_one_path(const struct cache_entry *old, const char *path, int len
>   	ce->ce_flags = create_ce_flags(0);
>   	ce->ce_namelen = len;
>   	fill_stat_cache_info(the_repository->index, ce, st);
> -	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
> +	ce->ce_mode = ce_mode_from_stat(the_repository, old, st->st_mode);
>   
>   	if (index_path(the_repository->index, &ce->oid, path, st,
>   		       info_only ? 0 : INDEX_WRITE_OBJECT)) {
> diff --git a/diff-lib.c b/diff-lib.c
> index ae91027a02..894358c8b0 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -160,7 +160,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>   
>   			changed = check_removed(ce, &st);
>   			if (!changed)
> -				wt_mode = ce_mode_from_stat(ce, st.st_mode);
> +				wt_mode = ce_mode_from_stat(the_repository, ce, st.st_mode);
>   			else {
>   				if (changed < 0) {
>   					perror(ce->name);
> @@ -193,7 +193,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>   					num_compare_stages++;
>   					oidcpy(&dpath->parent[stage - 2].oid,
>   					       &nce->oid);
> -					dpath->parent[stage-2].mode = ce_mode_from_stat(nce, mode);
> +					dpath->parent[stage-2].mode = ce_mode_from_stat(the_repository,nce, mode);
>   					dpath->parent[stage-2].status =
>   						DIFF_STATUS_MODIFIED;
>   				}
> @@ -262,7 +262,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>   				continue;
>   			} else if (revs->diffopt.ita_invisible_in_index &&
>   				   ce_intent_to_add(ce)) {
> -				newmode = ce_mode_from_stat(ce, st.st_mode);
> +				newmode = ce_mode_from_stat(the_repository, ce, st.st_mode);
>   				diff_addremove(&revs->diffopt, '+', newmode,
>   					       null_oid(the_hash_algo), 0, ce->name, 0);
>   				continue;
> @@ -270,7 +270,7 @@ void run_diff_files(struct rev_info *revs, unsigned int option)
>   
>   			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
>   							    ce_option, &dirty_submodule);
> -			newmode = ce_mode_from_stat(ce, st.st_mode);
> +			newmode = ce_mode_from_stat(the_repository, ce, st.st_mode);
>   		}
>   
>   		if (!changed && !dirty_submodule) {
> @@ -338,7 +338,7 @@ static int get_stat_data(const struct cache_entry *ce,
>   		changed = match_stat_with_submodule(diffopt, ce, &st,
>   						    0, dirty_submodule);
>   		if (changed) {
> -			mode = ce_mode_from_stat(ce, st.st_mode);
> +			mode = ce_mode_from_stat(the_repository, ce, st.st_mode);
>   			oid = null_oid(the_hash_algo);
>   		}
>   	}
> diff --git a/environment.c b/environment.c
> index 0026eb2274..861ef084dc 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -41,7 +41,6 @@
>   static int pack_compression_seen;
>   static int zlib_compression_seen;
>   
> -int trust_executable_bit = 1;
>   int trust_ctime = 1;
>   int check_stat = 1;
>   int has_symlinks = 1;

But the_repository itself is a global variable, isn't it?

If you understand what “removing global variables” means, you should 
grasp the direction we're heading:

	passing global variables -> passing context

For example, in

 > @@ -160,7 +160,7 @@ void run_diff_files(struct rev_info *revs, 
unsigned int option)
 >
 >   			changed = check_removed(ce, &st);
 >   			if (!changed)
 > -				wt_mode = ce_mode_from_stat(ce, st.st_mode);
 > +				wt_mode = ce_mode_from_stat(the_repository, ce, st.st_mode);
				perror(ce->name);

A more appropriate of passing value could be something like:

wt_mode = ce_mode_from_stat(revs->repo, ce, st.st_mode)

> @@ -306,7 +305,7 @@ int git_default_core_config(const char *var, const char *value,
>   {
>   	/* This needs a better name */
>   	if (!strcmp(var, "core.filemode")) {
> -		trust_executable_bit = git_config_bool(var, value);
> +		the_repository->settings.trust_executable_bit = git_config_bool(var, value);
>   		return 0;
>   	}
>   	if (!strcmp(var, "core.trustctime")) {

I didn't think it through, but my gut tells me there might be some weird 
variable overwriting issues here.

But more importantly, I feel that the changes here somewhat undermine 
lazy loading behavior. Variables in repo_settings are lazy-loaded, 
meaning you cannot read their values via actions like 
repo->settings.trust_executable_bit because they are not loaded until 
needed. The function prepare_repo_settings(repo) should be called to 
load the values.

However, the change here appears to manually assign a value during the 
global config parsing phase. I believe this is incorrect.

For more information you can look through 
https://lore.kernel.org/all/48821a3848bef25c13038be8377ad73e7c17a924.1771258573.git.belkid98@gmail.com/

Regards,

Yuchen



