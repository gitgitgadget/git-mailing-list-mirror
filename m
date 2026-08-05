Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB946AA6B
	for <git@vger.kernel.org>; Wed,  5 Aug 2026 12:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785933286; cv=none; b=dhATCUTpsuv8RghUBAuPfKqvFivp9OR834v+jd91xsiOICuI7+fZ4fY1bW4lAcJga6qGrm4gRslrCTJW7cxgvw+GUIP390CeG/qlFpukSg37jfYAnZLba0EIzjifpqxcH2oP62yX5HYX+B6M6ciRlYGVe0Znlbk4HQEYLDfzXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785933286; c=relaxed/simple;
	bh=cEo/h//352r8Rt3kKHG3qdRJ6peX64eqQAzHaICV2Ls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CCUf4Px/YmpcjHfBwOI1RnmG1Tosa/69KI+lw5vRyuphRNCIMjTEE7lkcxFdwvFz6mRwHBQJN4i97lPQZZ0jPWx2pTVtypyMykU1Ki9/vacIcH2y+5UI525UBNOhOXRmwM7i+cQmoK4t7qt9axu73UQavyYKXEuZXCAUU5eCUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=JsP8u1lD; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=ScgozPRD; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="JsP8u1lD";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="ScgozPRD"
DKIM-Signature: a=rsa-sha256; b=JsP8u1lD9aj4G9SBsATe5VXRYdAnWhCcGmW2bMLpP0Gyt0lCvbIy84IdR9sFU/8j6AL9NCudu0yY9wgB+2+DXjfR6+4SZIev9d6ASoR2ouF+1F4IiF8HHiyjOzA7x5MayEsYsitAiCK0K3jbx3Oadk5i4/079Ymlsk+pTdCwXvaB4Fh72c/TY/LuKgNvwcqWfmzqv4rXlSQbQCtupOQt8kAolg3XPhBnkoL5iv0l8QaA5CcFkg6blLi1wObKODNZ9BGO0v1Q8YO2jowiM6cXLhdfAVRBP1edf9ULNilRL4Hm30Egr1HsJDCywVr2Kz5KIVJgFETdSxHvZhBbjYNimw==; s=purelymail1; d=malon.dev; v=1; bh=cEo/h//352r8Rt3kKHG3qdRJ6peX64eqQAzHaICV2Ls=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=ScgozPRDdjAsenxlDe4oJI1vTnqIvNJ+7rNR+0pgMLYajpiWG+HBAxGqFTi9VyflOpxNlToUdt0w0LJzJ0LmtlwK4NDu2byJPR+B8zQTSSiHl074KjPij0VelGCos23vqfRnY9ngeH3NL8CQZfsHPljxIst8IDzO6cIV5UiIoI4v+o6q7KaufPymd81pgdLRRV9LUm1iCiPZoH2Ghr61+Hy93jDuYKjz6h/dmJOyWZexB2sveXq6ULdRjOK0W91AIzS+QK1GcOUvN7AIxT+3rVZjz0yS8EDv/weLZ9+keDyClIBB89TTNYWwLagmHgcVCR6vT6yaoQxqfNimjIoFSg==; s=purelymail1; d=purelymail.com; v=1; bh=cEo/h//352r8Rt3kKHG3qdRJ6peX64eqQAzHaICV2Ls=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1304091343;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Wed, 05 Aug 2026 12:34:40 +0000 (UTC)
Message-ID: <48c183b4-3752-4f4a-adb7-0819a956cfc1@malon.dev>
Date: Wed, 5 Aug 2026 20:34:30 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] repository: move fetch_if_missing into struct
 repository
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, five231003@gmail.com, hariom18599@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260715011850.3181131-1-cat@malon.dev>
 <20260716072954.582235-1-cat@malon.dev> <anGhtfPaGK7v3NNR@pks.im>
 <xmqqwlu5vla1.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqwlu5vla1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/5/26 01:38, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
>>> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
>>> index 0793dc595c..74f9694662 100644
>>> --- a/builtin/index-pack.c
>>> +++ b/builtin/index-pack.c
>>> @@ -1898,15 +1898,16 @@ int cmd_index_pack(int argc,
>>>   	int report_end_of_input = 0;
>>>   	int hash_algo = 0;
>>>   
>>> +	show_usage_if_asked(argc, argv, index_pack_usage);
>>> +
>>>   	/*
>>>   	 * index-pack never needs to fetch missing objects except when
>>>   	 * REF_DELTA bases are missing (which are explicitly handled). It only
>>>   	 * accesses the repo to do hash collision checks and to check which
>>>   	 * REF_DELTA bases need to be fetched.
>>>   	 */
>>> -	fetch_if_missing = 0;
>>> -
>>> -	show_usage_if_asked(argc, argv, index_pack_usage);
>>> +	if (repo)
>>> +		the_repository->fetch_if_missing = 0;
>>>   
>>>   	disable_replace_refs();
>>>   
>>
>> This one looks a bit weird -- we check for `repo`, but then set
>> `the_repository->fetch_if_missing`. We can probably just loose the
>> conditional completely, and furthermore we don't need to reorder any
>> code here at all anymore.
> 
> The 4-line comment is about disabling fetch-if-missing, so the code
> movement is not even unnecessary, but it is harmful, I think.  If
> the command can work without repository, incoming "repo" might be
> NULL, and unconditionally doing
> 
> 	repo->fetch_if_missing = 0;
> 
> may cause a crash.  But that is not an excuse to blindly add
> 
> 	if (repo)
> 
> in front of such an assignment.

Yes, this is a mistake. :(

> 
> It gives you a chance to rethink what you are doing.
> 
> If a command can work without a repository, yet it cares about how
> fetch_if_missing bit is set, it hints that it may be a mistake in
> the first place to try associating fetch_if_missing bit with a
> particular struct repository instance, as you must be prepared to
> work with repo==NULL.
> 
> There could be at least three approaches you may have to think about
> at that point.
> 
>   * Perhaps the command may not have to work outside a repository at
>     all.  If so, then it is a bug for the caller to call this
>     function with repo==NULL.  So we should just say
> 
> 	repo->fetch_if_missing = 0;
> 
>     without "if (repo)" check at all here.  After all, the situation
>     we might want to enable fetch_if_missing is where we have a place
>     to fetch into, so by definition, we _should_ have a repository in
>     such a case.
> 

Yep, this approach looks the most reasonable to me. I think I will apply 
this approach and update the commit message.

>   * Perhaps the command may want to work outside a repository but it
>     may be acceptable to operate in a degraded way.  By definition,
>     when we are outside a repository, we have no object store to
>     fetch objects lazily into, so fetch_if_missing MUST BE off.
> 
>     Because Git is primarily about working inside a repository,
>     perhaps it may be acceptable, even when you are outside a
>     repository, to assume that the_repository can be used as a
>     back-up "fake repository" object, and fetch_if_missing and its
>     friends that are necessary to have their meaning to be in that
>     fake repository object.  If that the stance we are going to take,
>     this part should probably say:
> 
> 	(repo ? repo : the_repository)->fetch_if_missing = 0;
> 
>     We need to make sure that everybody who passes the code paths
>     that ever reference fetch_if_missing would pass the_repository
>     down when the command is running outside a repository, though.
> 
>   * Or perhaps there are some settings that really need to be
>     available whether you are in a repository or not.  I think
>     fetch_if_missing is a borderline case, but more generally, things
>     like user.name should conceptually be available even outside a
>     repository, with in-repository configuration files overriding
>     them.  And it may be a mistake to force such settings to be
>     stored in an instance of "struct repository" (or repo_settings
>     that is part of it).  We would need a framework to represent a
>     structure in which a basic setting, which does not belong to any
>     repository (whose members may be the same as those in "struct
>     repo_settings", so I think it is OK to use an instance of that
>     struct to represnt this "basic settings that is global"), exists
>     globally, and it is overriden by per repository setting, which is
>     in "struct repo_settings" embedded in "struct repository".
> 

I'm not sure if I'm right, but I feel that 'fetch_if_missing' 
essentially carries two meanings simultaneously: "Does this repository 
allow lazy fetching?" and "Does this object lookup allow network 
behavior to be triggered?" In other words, suppose we consider 
'fetch_if_missing' to meet the third case, allowing it to exist in an 
ambiguous situation, i.e. it makes sense both within and outside the 
repository...Can we then consider the existence of this variable itself 
to have some semantic ambiguity? If so, do we really need to invent 
another mechanism to accommodate this ambiguity? Or should we 
temporarily apply minimal changes and discuss the ownership issue when 
the time is right (i.e. subsystems ready for 'repo' rather than 
'the_repository' only)? Perhaps this is what you mean by "a borderline 
case".

Furthermore: when we do libification, is the goal to eliminate global 
state, or to "package global state more reasonably"? The third approach 
seems to be the latter one.

> The earlier choices require fewer changes than the later choices,
> but the later choices are more concepturely pure, I think.
> 

All in all, I think your core point is that we shouldn't blindly put all 
global variables in a struct repository. I totally agree with that.

> 

Thanks! yuchen
