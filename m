Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4813349B0F
	for <git@vger.kernel.org>; Fri, 27 Mar 2026 16:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774629620; cv=none; b=ls6W1UYVd9/sUU7HRe4cVgCAK9sOCkqkkVPIVzpvu2RjsOzIZwKYJdGlPlsqVICpKr4+uFv/gLhh84Ict6ea7TZilsN7wcVuO9MPBUTNHrUcxT6/Rkyo5um6xDIFQu0LKUXrvpTIG+vG0TmmGfURLg3YeKmQppid1Jh+lwYZyJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774629620; c=relaxed/simple;
	bh=4freCb5LDEdLe9ZwLOSL1OTv53cqu1096T7PtKQ9MMU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=b8Jo7sNxlU+VrsYMw6PeoTm8w+8DyKf8yjsr6b7iRrmTv0sHTBRECYx2VADqrdR5hhpfiMtS9ZCyWpxRY5oubWeavhVUjeNaGfBE1IRLCF/Dr0OXhJYUBNTAMAE4LEVz1FmBo3Pe1XFjyomk7gLyqzZ3qmnjGIQJ7wUJbfaeOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h82U72Rr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h82U72Rr"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439d8df7620so1670457f8f.0
        for <git@vger.kernel.org>; Fri, 27 Mar 2026 09:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774629617; x=1775234417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5Blb5k/fMUix80u6crm23KcM+xZXyH9HTFpu5tys/I=;
        b=h82U72RrbKYjgPuspZH5bY503NapsLVWunX9pqOdf7ceYfmAoxDLsUNLnjXzyaAZrX
         64RSj4JgZT9CeeQ4xR2NN1LgJPWqWuVb5Y1FYKqkAik0jkHi4rqr8dCGqnTAeQ3pXFsN
         b03q00D/HTiNYTx6NFc4cRj3YQ/6+qdnpCzmGGx73eV9NpejoLMXHbZ6a5Bi8OLSsjzC
         U9ntXaV5Tw/9Fv0E25wC3K5bTZndB2PoIKSDtOJzfbnd0glsRSOMRQFcrcFVYUICtyxs
         9iasPFC7Tvet+ThSPAPpxNPSpMNV4a5+Sc1xHIYPZh1sNG6flmaEBUYt03HW/z1K76iS
         4bGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774629617; x=1775234417;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5Blb5k/fMUix80u6crm23KcM+xZXyH9HTFpu5tys/I=;
        b=owYbihRP2CRAkkMX7sEB4S9j9ynEovVA7uJZshMVZCY2n4YyqXlTyJ3AHCwyc3srIV
         aNTLmmqkA4HPeciSPa4OZu1ot8YUOW7wcLpHWVedLj5xMrHJgEXOfgKYUq2WTGJyYuWd
         HGTIlr/UbLRUvDVH7obFd3aWWsnKwoF6avPP7w7PFXudaYo5oP4qkoxMQvhetZO7MZ6E
         kFJJVqHfyUPkIbkUeM0ya3/40q7VUm1ABxguiNJnLBtwsUPQt54yh4l8YBb4Nk1zU7mQ
         wCgydDus8e+snXtue9YLAho41yyToXfv8oudXPiYi4OltHJi9pGlsNZFOsxmZwV6oCsN
         iQew==
X-Gm-Message-State: AOJu0YymP+Qdns655qmStfByuAjBqtykOacnWKaUVmgSLcwjT92rn+0n
	ZLubbQiTbwtQRCYShCWigfwYlV+XS1tz08SalgK/D+o2H4vdrQ0NIQuS
X-Gm-Gg: ATEYQzy+PhOx1FJmqkWGvgYKvjHPvF0rM4kW+LGOrEMlhV4upyrZ7Nk/sUrYYjz+JIN
	R2VCwcQBYklvX1sFmmaxq5sJ2hVySOdu0Qso+6CMZ6CKkvPObZDr9H+30PCD4Y/wsxKiL8WjVu1
	J4K2I/p35KPXE3ostp/U0ILTynX9pGzPZHR9TWraDpizC/Rdv5MRHKSB8Z7hLk9N99GBmUGgTFk
	ZsOWkZg+kPrKNBYZT8ecXmoyDaS4l0wXLwzf4G/pI6DCLwvyiZibbV7B7Hx9C+6FWX25DlwibjY
	5fXiHsQZHtzdwRll2rUmySGp7n4fCiCwktHhfc0mpxOOwdeck0cYZnv8tGWmGFRIxGge0D6rBKJ
	F39tH1tSQtke/P/ODi7X7/xl12pR3XFKUa2AyO5DUf/RQdfcaz6HwWyfatNnuMLmSLT/5z72xGC
	b/7GWqvfJEJZwMHsqr/l6y4lWVcCtD2ZEZeIxnmXy5wsK5zqu6g6YJUgafO+Uuu8vFEwuAkEnHS
	OqsCg==
X-Received: by 2002:a05:6000:2c10:b0:439:bcc2:bf0a with SMTP id ffacd0b85a97d-43b9e9f9d91mr5673707f8f.23.1774629616663;
        Fri, 27 Mar 2026 09:40:16 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b91943312sm16945921f8f.12.2026.03.27.09.40.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2026 09:40:16 -0700 (PDT)
Message-ID: <317ed4f7-f88d-4415-bd25-b62b4a076728@gmail.com>
Date: Fri, 27 Mar 2026 16:40:15 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] worktree: remove "the_repository" from
 is_current_worktree()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
References: <cover.1773411586.git.phillip.wood@dunelm.org.uk>
 <cover.1774534617.git.phillip.wood@dunelm.org.uk>
 <5357c0dd53ee123a4ea064412c83983b0be5e400.1774534617.git.phillip.wood@dunelm.org.uk>
 <xmqqy0jer3qu.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqy0jer3qu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2026 15:48, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... it calls get_workree_git_dir() which also depends on
>> "the_repository". This means that even if "wt->path" matches
>> "wt->repo->worktree" is_current_worktree(wt) will return false when
>> "wt->repo" is not "the_repository". Consequently die_if_checked_out()
>> will fail to skip such a worktree when checking if a branch is already
>> checked out and may die errounously. Fix this by using the worktree's
>> repository instance instead of "the_repository" when comparing gitdirs.
> 
> It sounds like the above is something we can write in a test to make
> sure the code with this fix won't regress in the future.  Can we add
> one?

We'd need to create a struct worktree instance with a repository 
instance that is not "the_repository" - I'm not sure we can do that in a 
script.

>> -	wt->is_current = is_current_worktree(wt);
>> +	wt->is_current = true;
>>   	add_head_info(wt);
>>   
>>   	free(gitdir);
> 
> I think I found the semantics of get_worktree_from_repository()
> unclear when we discussed a different patch series, so I may have
> asked the same question already, but what exactly does it mean to
> "get worktree from repository", i.e., this function does?  A
> repository can have one or more worktrees attached to it (that was
> the whole point of introducing the worktree mechanism), so "I have
> this repository, give me the worktree for it" is not a sensible
> request.

A repository can have more that one worktree but a "struct repository" 
instance has "gitdir" and "worktree" members that point to a specific 
worktree within that repository. For example

	repo_get_oid(repo, "HEAD", &oid);

reads "HEAD" from a specific worktree within the repository.

> The function's comment in <worktree.h> talks only at the
> implementation level "construct a worktree struct from repo->gitdir
> and repo->worktree" as if it is so obvious what the resulting
> worktree struct means at a higher layer's point of view, which does
> not help, either.

That comes from me thinking of a struct repository as referring to a 
specific worktree - would calling it 
"get_worktree_from_repository_instance" be clearer?

> I am asking the above because I find this unconditional assignment
> of "true" utterly confusing.  Is it because "we created a brand new
> worktree structure that by definition is current out of a repository
> structure, so as far as the caller is concerned by definition it is
> what it is currently working on"?

Yes

> Stepping back a bit, how do "is_current_worktree(wt)" and
> "wt->is_current" relate to each other?

"wt->current" is the cached return value of is_current_worktree() (see 
the implementation of get_main_worktree() and get_linked_worktree())

>  Here is what happens in the
> former:
> 
>          static int is_current_worktree(struct worktree *wt)
>          {
>                  char *git_dir = absolute_pathdup(repo_get_git_dir(wt->repo));
>                  char *wt_git_dir = get_worktree_git_dir(wt);
>                  int is_current = !fspathcmp(git_dir, absolute_path(wt_git_dir));
>                  free(wt_git_dir);
>                  free(git_dir);
>                  return is_current;
>          }
> 
> and given the definition of get_worktree_git_dir(), which gives
> either the "common" .git directory for the primary worktree, or the
> worktree specific .git directory for the secondaries, the is_current
> being computed here sounds more like "is wt the primary worktree
> among the ones that are attached to the same repository?"

No, the primary worktree (which the code calls the "main" worktree) is 
orthogonal to the "current" worktree. The main worktree is the one whose 
gitdir is $GIT_COMMON_DIR i.e. the worktree created by "git init". The 
"current" worktree is the one whose gitdir is wt->repo->gitdir and may 
or may not be the "main" worktree.

> But given that there are API functions with "main" in their names,
> like is_main_worktree() and internal function get_main_worktree(),
> what I said apparently is not the intention of whoever built the
> worktree subsystem.  I am still confused... X-<.
> 
>> @@ -229,9 +229,9 @@ char *get_worktree_git_dir(const struct worktree *wt)
>>   	if (!wt)
>>   		return xstrdup(repo_get_git_dir(the_repository));
>>   	else if (!wt->id)
>> -		return xstrdup(repo_get_common_dir(the_repository));
>> +		return xstrdup(repo_get_common_dir(wt->repo));
>>   	else
>> -		return repo_common_path(the_repository, "worktrees/%s", wt->id);
>> +		return repo_common_path(wt->repo, "worktrees/%s", wt->id);
>>   }
>>   
>>   static struct worktree *find_worktree_by_suffix(struct worktree **list,
>> diff --git a/worktree.h b/worktree.h
>> index e450d1a3317..94ae58db973 100644
>> --- a/worktree.h
>> +++ b/worktree.h
>> @@ -16,7 +16,7 @@ struct worktree {
>>   	struct object_id head_oid;
>>   	int is_detached;
>>   	int is_bare;
>> -	int is_current;
>> +	int is_current;		/* does `path` match `repo->worktree` */
> 
> This new comment also talks only at the lowest implementation level.
> What significance does it have to the upper layer that calls into
> the API if `path` matches or does not match `repo->worktree` is
> totally unclear, at least to me.

Does it help to think about how "is_current" is used by functions like 
get_worktree_ref_store()? For the current worktree it can use the 
refstore from wt->repo, if it is not it needs to open the store for that 
worktree.

I feel I'm struggling to explain this clearly - I find this whole 
discussion gets confusing because we have "struct worktree" and also a 
"worktree" member of "struct repository" which means a "struct 
repository" instance is tied to a specific worktree within the 
repository. If "struct repository" only had a "commondir" member and no 
"gitdir" or "worktree" members and we instead used "sturct worktree" to 
refer to a specific worktree within a repository with functions like

	worktree_get_oid(wt, "HEAD", &oid);

instead of

	repo_get_oid(repo, "HEAD", &oid);

it might be clearer but that would be a very big change.

Thanks

Phillip

>>   	int lock_reason_valid; /* private */
>>   	int prune_reason_valid; /* private */
>>   };
> 
> Thanks.

