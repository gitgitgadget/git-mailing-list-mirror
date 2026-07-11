Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C3C24A067
	for <git@vger.kernel.org>; Sat, 11 Jul 2026 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783794932; cv=none; b=Wc+9zIUvE2Vpwouf9HTPwrFkLozQJaLPAy6LgcUpVYEL54xF9jvimCIpR1Erc3FAsl1193GcZreMNMrx8CQ9BwKpF+7Pya4kmk7pqyhraImowH6Kk4Ddnex18HHtCY7fKYboguhQ5zO8nPCb9FmVGz8B1rzepoX3ZqB5UiIURMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783794932; c=relaxed/simple;
	bh=CWaMxYYRH1F0mi2AR+hqWsAl0gmQZntugLTOj1xynNo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WPksyFna/2yZBWKUCFzHa/s8Afd1BNBsHG1lK5thFuMNxNNb5J7JJBH7ZJfL8qpQY61skHNZkaGWg9fHd+kvvnWMtuYVvYsBVjv8dKeUEfTyyIvSj/PQn9w1HC9XxAGlVixIAXbXmZkS+Om4ZR8mPFqHy/m1KQfhlU+XN4xHMbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=akaSnvF1; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Y0p+6M3J; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="akaSnvF1";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Y0p+6M3J"
DKIM-Signature: a=rsa-sha256; b=akaSnvF1RPYMUSjjPJ0mrRphXQkyFWnd7pU8SUvutQA9Ljn9+B0nA2ihg1nle4WjlvZoR6G6BWhoc3cdnuTZra3+3iEnQuFqHXxwztxI34d0Wna40rGj25TfMSAKEZ3D85K5/BCDNUJSBhCH6xlj6ZTBrONo3mnz/EeCxXv07vLzSqRsNMxD7hP5yAcq/ieQJ+wWPKkxCNc+f1gyGwJ7PfWiWc1hJWieO8HtJVQ2S+FhE5997zpeX8xtKaJBIA+35Ky7PrQywH0VHlIAbNH+LK5+d37EhQS387xL9YJdy6/S7f7lxWjScdEL+bcBZsY8paWsCmdnX/nVf/65DXbQbA==; s=purelymail1; d=malon.dev; v=1; bh=CWaMxYYRH1F0mi2AR+hqWsAl0gmQZntugLTOj1xynNo=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=Y0p+6M3JpqW1zALwlQm7ffqL9Y6PRAyRX1cAE8trZ/omkO2KyHSYFoWH22TqjZgSNSTspJzANpb2ex9DhWm1nynEfMoJmTHZ94rhoc8ZChOlLkJ3CSwIhccnKJxeAqmVEjOZ95hiweaAuVPgf/j+THFXU8LJ6xs71ySAKKnJ2nJakjXVuvFTNryeZ4ov91uq/rJdD+cecjZ2CX5PtHfwNzkIrwZkglvOkbXPCxsfdjJvKTiH8ehVND2570IpgkiwFgKVdFJD/wvhxJ41zojKcBdDO5twgbCNf4GvsJfxHbaWT1ll3KCmjy4FSoMF+f/fsIj9RHswfsvzIiCCXgg25g==; s=purelymail1; d=purelymail.com; v=1; bh=CWaMxYYRH1F0mi2AR+hqWsAl0gmQZntugLTOj1xynNo=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2039001439;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 11 Jul 2026 18:35:27 +0000 (UTC)
Message-ID: <95f46463-a6e7-4b35-8ff4-ac89cadd6437@malon.dev>
Date: Sun, 12 Jul 2026 02:35:23 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 1/9] repository: introduce repo_config_values_clear()
Content-Language: en-US
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: cirnovskyv@gmail.com, szeder.dev@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260708160300.8852-1-cat@malon.dev>
 <20260709161145.13349-1-cat@malon.dev> <20260709161145.13349-2-cat@malon.dev>
 <DJVWYOJNU0IW.1M107L4ABH54V@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <DJVWYOJNU0IW.1M107L4ABH54V@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hii Pablo,

On 7/12/26 01:21, Pablo Sabater wrote:
> On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
>> As part of the ongoing libification effort, dynamically allocated
>> global configuration variables are being moved into
>> 'struct repo_config_values'. To prevent memory leaks, we need a
>> destructor to free these heap-allocated variables when a repository
>> instance is torn down.
>>
>> Introduce 'repo_config_values_clear()' in environment.c and invoke it
>> from 'repo_clear()' in repository.c. As a starting point, update this
>> new function to handle the cleanup of 'attributes_file'.
> 
> Makes sense.
> 
>>
>> Note:
>>
>> Submodules are currently not supported by repo_config_values(), which
>> explicitly BUG()s out if 'repo != the_repository'. Since repo_clear()
>> cleans up all repository instances, we must bypass them to prevent
>> crashing.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>>   environment.c | 19 +++++++++++++++++++
>>   environment.h |  9 +++++++++
>>   repository.c  |  1 +
>>   3 files changed, 29 insertions(+)
>>
>> diff --git a/environment.c b/environment.c
>> index ba2c60103f..13677484de 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -726,3 +726,22 @@ void repo_config_values_init(struct repo_config_values *cfg)
>>   	cfg->sparse_expect_files_outside_of_patterns = 0;
>>   	cfg->warn_on_object_refname_ambiguity = 1;
>>   }
>> +
>> +void repo_config_values_clear(struct repository *repo)
>> +{
>> +	struct repo_config_values *cfg;
>> +
>> +	/*
>> +	 * NEEDSWORK: Submodules are currently not supported by
>> +	 * repo_config_values(), which explicitly BUG()s out if
>> +	 * repo != the_repository. Since repo_clear() cleans up all
>> +	 * repository instances, we must bypass them here to prevent
>> +	 * crashing.
>> +	 */
>> +	if (repo != the_repository)
>> +		return;
>> +
>> +	cfg = repo_config_values(repo);
>> +
>> +	FREE_AND_NULL(cfg->attributes_file);
>> +}
>> diff --git a/environment.h b/environment.h
>> index 6f18286955..c4a6a45704 100644
>> --- a/environment.h
>> +++ b/environment.h
>> @@ -135,6 +135,15 @@ int git_default_core_config(const char *var, const char *value,
>>
>>   void repo_config_values_init(struct repo_config_values *cfg);
>>
>> +/*
>> + * Frees memory allocated for dynamically loaded configuration values
>> + * inside `repo_config_values`.
>> + *
>> + * As dynamically allocated variables are migrated into this struct,
>> + * their FREE_AND_NULL() calls should be appended here.
>> + */
>> +void repo_config_values_clear(struct repository *repo);
> 
> I think that I'm not comfortable having the _init() and the _clear()
> functions with different signatures.
> 
> _clear() takes struct repository to dodge a BUG().
> 
> I would like to have both signatures equal, why can't we just do directly:
> 
>    void repo_config_values_clear(struct repo_config_values *cfg)
>    {
>    	FREE_AND_NULL(cfg->attributes_file);
>    }
> 
> and call from repo_clear():
> 
>    repo_config_values_clear(&repo->config_values_private_)
> 

I particularly agree with your point that the signatures of these two 
functions should be consistent. I missed it tbh...I will change it in 
the next reroll.

However, I think it makes more sense to refactor to pass in 'struct 
repository', which is consistent with repo-settings.

> I get that the workaround might be to not access directly to
> &repo->config_values_private_ which repo_config_values() returns but for
> example initialize_repository() access this _private_ field directly as
> well.

Now that we have used the _private_ suffix, if we can just define a 
_clear() to bypass the assertion of repo_config_values(), wouldn't this 
be self-deception? I'm not saying that the original lines are 
necessarily correct... but I do think that semantically speaking, it is 
inappropriate to pass in config_values_private_ to _clear().

> Also at repo_init(), initialize_repository() sets repo->initialized
> before anything can fail and call repo_clear() but
> repo_config_values_clear() should be able to free attributes_file even
> just after a memset() (which happens before initialize_repository()).
> But calling repo_config_values has a BUG() in case of
> !repo->initialized are we comfortable with this assert?

This goes back to the previous topic: Who is responsible for the call to 
_clear()? Who is responsible for filtering all those invalid usage of 
repo instances? Faced with a repo instance that was not initialized but 
was handed over to _clear() in some way, we have two concepts:

- It doesn't matter. Since we always handle config_values_private_, it's 
NULL at this point, so we don't BUG() and continue.

- The very existence of such a repo is a mistake. It shouldn't have 
appeared and shouldn't have been passed on to me. However, since this 
situation is relatively common at this point, we choose to return 
instead of BUG()ing it directly to temporarily avoid it. We will 
gradually tighten the conditions. When the invalid calls are eliminated 
in the end, such checks will no longer exist.

Our consensus should at least be that this 'use of uninitialized repos' 
is bad, so they are just two different ways to solve unexpected 
situations. However, in my opinion, the difference between these two 
concepts lies in whether we are consciously moving the assertion 
downward. I think the latter line of thinking does this better.


 >
 > Even with the NEEDSWORK it is a silent return, what will happen when
 > submodules are supported? If no one remembers to change it we will leak
 > the submodules silently.
 >

I will remember to change it ;)

Regards, yuchen

>> +
>>   /*
>>    * TODO: All the below state either explicitly or implicitly relies on
>>    * `the_repository`. We should eventually get rid of these and make the
>> diff --git a/repository.c b/repository.c
>> index 187dd471c4..b31f1b7852 100644
>> --- a/repository.c
>> +++ b/repository.c
>> @@ -388,6 +388,7 @@ void repo_clear(struct repository *repo)
>>   	FREE_AND_NULL(repo->parsed_objects);
>>
>>   	repo_settings_clear(repo);
>> +	repo_config_values_clear(repo);
>>
>>   	if (repo->config) {
>>   		git_configset_clear(repo->config);
> 
> Regards,
> Pablo

