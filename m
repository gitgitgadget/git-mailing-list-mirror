Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9428800
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 18:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764958662; cv=pass; b=RvhZosH1aQc4/AyCXk2e/rDq2cUjmCPe+9QcD1D7WDK4kp2xMI9+1dyOUcyLAGhnKDGDr++wY+raBpMWDsHEkkBXWjsUrfY0qyKw14ykvPyI2zrRKbQT4frIt2t6ajWPv6Mx76+Cj5NoUmHKf8p+7iLjk8uACRMs8aQYaZ8HC8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764958662; c=relaxed/simple;
	bh=irhdVOqm4qILNEZkgZblzmyzUqVAFzxy9Dd04AtJ+QM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vtjz0Pz2S5qt1VhF7uxi7zPF79sFPNmf57xqil9LzS87yb0h+0UNoJ6mdvPXsS3/TZJhOCQqJ9O2vjrFqqSlWFN+oEFNu/UNxnPdP7jK84JEP4y2Lq8cMbYEiuABnBxDfpjkFOVfKEBLOy0SASbnsO57bQ7J9DXiN5RcwYX9ZSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=hMGTsi5E; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="hMGTsi5E"
ARC-Seal: i=1; a=rsa-sha256; t=1764958648; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YdcLGuXjBEVMKT/1GOpPlDNY4abxn26HcdsYXPKpJ7lXEiQ2ZvYGKZRhQR8vmIQbOeOjqpE+zEn1XGLGmvz7NfaKijrRrL+Mx0ZfyDLj3+Gnp8rZOuOkWgxJCYaparxV2saftrVr9T2xCMyx9UvVAuoOszntjBcaUsiTZ9QV8vw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1764958648; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=j8qrrQ2OdmS8O0CDv0G+Ss/5FEW3Q9KsMcNQ8+viP40=; 
	b=A5tRDzSDaTZgeH366QmsmLN3spQ7cwXOevwOzK+MUz8sx4jgbtjAlsZ4xrZ06XUCFJkGbtdYKuF5DSjwF7XDo6/4QtY2tzPLJCH7Svd8EZD8jTJaoXj3lQsHBsYrEDVC/ppUibLDvQ1YSLoJfM9KakAI/Myqc3CsDvEyBzGwX7k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1764958648;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=j8qrrQ2OdmS8O0CDv0G+Ss/5FEW3Q9KsMcNQ8+viP40=;
	b=hMGTsi5EqHfzUYoFciPQJiaT/CJ0LXYrWG6X0IeweSAI4jTORJTF9WocKsExxSpB
	9ZkJz6MnLo9qA+tFq3WdwZLaeSq68Q163Z9k+yBcY/GtaHU/DZOA6eji87/5BwpiTF/
	JBf6FXa2FBxLWyDaZrl9FtnxGQm1/YQaXJPJAc/s=
Received: by mx.zohomail.com with SMTPS id 1764958648293225.13745115913127;
	Fri, 5 Dec 2025 10:17:28 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Junio
 C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>, Jonathan
 Nieder <jrnieder@gmail.com>, Josh Steadmon <steadmon@google.com>, Ben
 Knoble <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 3/7] submodule: always validate gitdirs inside
 submodule_name_to_gitdir
In-Reply-To: <aTLNPKlDnsNzyZkC@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-4-adrian.ratiu@collabora.com>
 <aTLNPKlDnsNzyZkC@pks.im>
Date: Fri, 05 Dec 2025 20:17:23 +0200
Message-ID: <87y0ngeqto.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

On Fri, 05 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> On Wed, Nov 19, 2025 at 11:10:26PM +0200, Adrian Ratiu wrote:
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 2873b2780e..9914ca0786 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -1780,23 +1776,6 @@ static int clone_submodule(const struct module_clone_data *clone_data,
>>  		free(path);
>>  	}
>>  
>> -	/*
>> -	 * We already performed this check at the beginning of this function,
>> -	 * before cloning the objects. This tries to detect racy behavior e.g.
>> -	 * in parallel clones, where another process could easily have made the
>> -	 * gitdir nested _after_ it was created.
>> -	 *
>> -	 * To prevent further harm coming from this unintentionally-nested
>> -	 * gitdir, let's disable it by deleting the `HEAD` file.
>> -	 */
>> -	if (validate_submodule_git_dir(sm_gitdir, clone_data->name) < 0) {
>> -		char *head = xstrfmt("%s/HEAD", sm_gitdir);
>> -		unlink(head);
>> -		free(head);
>> -		die(_("refusing to create/use '%s' in another submodule's "
>> -		      "git dir"), sm_gitdir);
>> -	}
>> -
>>  	connect_work_tree_and_git_dir(clone_data_path, sm_gitdir, 0);
>>  
>>  	p = repo_submodule_path(the_repository, clone_data_path, "config");
>
> Hm. This one is a bit puzzling to me. This seems to explicitly be a
> check about a TOCTOU-style race, where a concurrent process might have
> created the parent repository after our initial validation of the path.
> We don't call `submodule_name_to_gitdir()` inbetween those two calls
> though, so why is this not a concern anymore with the unified API?

Excellent catch.

It still is a concern and this specific check needs to be added back.

My aim with this patch is to:
1. Avoid redundant validation calls for submodule_name_to_gitdir().
2. Avoid the risk of callers forgetting to validate.
3. Ensure gitdir paths provided by users via configs are always valid,
so I added the validation directly into submodule_name_to_gitdir().

Nothing prevents us from running the validation as many times as we
need and, in this case, it's perfectly justified to run it twice.

I'll add it back in v6.

>> diff --git a/submodule.c b/submodule.c
>> index 35c55155f7..8ef028f26b 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -2153,30 +2153,11 @@ int submodule_move_head(const char *path, const char *super_prefix,
>>  
>>  	if (!(flags & SUBMODULE_MOVE_HEAD_DRY_RUN)) {
>>  		if (old_head) {
>> -			if (!submodule_uses_gitfile(path))
>> -				absorb_git_dir_into_superproject(path,
>> -								 super_prefix);
>> -			else {
>> -				char *dotgit = xstrfmt("%s/.git", path);
>> -				char *git_dir = xstrdup(read_gitfile(dotgit));
>> -
>> -				free(dotgit);
>> -				if (validate_submodule_git_dir(git_dir,
>> -							       sub->name) < 0)
>> -					die(_("refusing to create/use '%s' in "
>> -					      "another submodule's git dir"),
>> -					    git_dir);
>> -				free(git_dir);
>> -			}
>> +			absorb_git_dir_into_superproject(path, super_prefix);
>>  		} else {
>>  			struct strbuf gitdir = STRBUF_INIT;
>>  			submodule_name_to_gitdir(&gitdir, the_repository,
>>  						 sub->name);
>> -			if (validate_submodule_git_dir(gitdir.buf,
>> -						       sub->name) < 0)
>> -				die(_("refusing to create/use '%s' in another "
>> -				      "submodule's git dir"),
>> -				    gitdir.buf);
>>  			connect_work_tree_and_git_dir(path, gitdir.buf, 0);
>>  			strbuf_release(&gitdir);
>
> The second case here makes sense to me, as we do call
> `submodule_name_to_gitdir()`. But in the first branch of the condition
> we retrieve the path directly, so we're not guarded by the validation
> anymore, are we?

The !submodule_uses_gitfile(path) case never validated and relied on the
validation done by absorb_git_dir_into_superproject() which calls both
validate_submodule_path() and submodule_name_to_gitdir() and has
additional checks.

So in essence the validation moved to absorb_git_dir_into_superproject().

If you prefer I can try to refactor absorb_git_dir_into_superproject() a
bit to make it clearer, otherwise I can just add back the validation
here as well... we can validate as many times as we like. :)
