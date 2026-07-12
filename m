Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA6F39B96A
	for <git@vger.kernel.org>; Sun, 12 Jul 2026 10:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783853073; cv=none; b=iDOSZLPlhcwvT+WPTI9HS186N2djmK9hhz61QdZBW5zf/2AmVYKEfb8BFTLCIaCSs4vZjarF4c42l5bFdhwcCh35RSO+TQMHQXz5pQDeBQvzeLFEkMXBwoXFOLfMlpnSEOC0x+QDG+8c47fjdNsfiFu7FfiuTtGS6nrPoVl+70Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783853073; c=relaxed/simple;
	bh=ob9SgAeaqpfIRI3riVnAnwWg31kZjkjoD0fp6GOB5X0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OgxUsJl0dXpN3Ui9AvuZodqsULFdbefg2lp43nbbyQ8QLs9QXUA9kpULW/FmSBvV9rNfm0Bq4vQF90pPl7gGIyYIVxNAafLazeUpmLboNlfITAo4nyEefYM0t2C1/IEvzwDeZhQYIPyVLF4p3BZefapgM24K3ogCDEMpt9GTVp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=ggEQRhoY; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=QIfCVY2M; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="ggEQRhoY";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="QIfCVY2M"
DKIM-Signature: a=rsa-sha256; b=ggEQRhoYijIfBrSO101K5Hviwr3obpjy3eV8nZ90nnM0sSNSR8Bw9xp5w5t/hIV3toTp9LKy35HySOhuHaYhM+E+mVexZfJ4oqZdPcwfIifBcYUBIgmMqnP2a0ZRcBk/7flfiSdqn4/7RNEU/gtAyLki8vIEsdH6fShn85H2g66FbVWzoZ2jZEaZP90RILkgbtC8HrvruwYMaOP66dTumSQMVn1czxIGaPBSyhhMHeYeTYu4sIQcpmpACw6I557+/vsvpwSgPRit24m6wmASqPWrGxlZMZOaY5tLcgVY07YQHJDazPmYOPsZOMtraMIp2MNXBFVhO6TtW9nmyCMctQ==; s=purelymail1; d=malon.dev; v=1; bh=ob9SgAeaqpfIRI3riVnAnwWg31kZjkjoD0fp6GOB5X0=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=QIfCVY2MzwWBP2NFzhULiNqlWEBZmZqSNpZJAId3yYFjD5x5mPOBWhl10MwCDKAtfmJf/OtC9gXtK2VrLzCSHzLltBEpDgSVfS8hoFTFgk+2BnlbLyQp/METm207/YGtY7r4SCX2OGrG4Dx37hiCAIVtpt339cZbJu7FC/vdiXZgpPb+9T0wNB0qCXdWN44LyV+26RWPiGAJ1//h1CgHp/i5m1oAD+tpOek957NVpAQnJn6Bj7ROSjaicMJDw4C9W4INnn18HKDYnrwlzKVMkkoClHRFXEaNEtYMAC/uN/JKw3GTgT71Ea5ltWVJzGPCiUP5z0xmmpflO56elrkeCA==; s=purelymail1; d=purelymail.com; v=1; bh=ob9SgAeaqpfIRI3riVnAnwWg31kZjkjoD0fp6GOB5X0=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 154379431;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 12 Jul 2026 10:44:28 +0000 (UTC)
Message-ID: <1c8ca470-1607-499b-9d78-e2c0a7a7f4b0@malon.dev>
Date: Sun, 12 Jul 2026 18:44:23 +0800
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
 <95f46463-a6e7-4b35-8ff4-ac89cadd6437@malon.dev>
 <DJWHIWVJ52UW.24D8DAKBNDMLB@gmail.com>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <DJWHIWVJ52UW.24D8DAKBNDMLB@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey Pablo,

On 7/12/26 17:28, Pablo Sabater wrote:
> On Sat Jul 11, 2026 at 8:35 PM CEST, Tian Yuchen wrote:
>> Hii Pablo,
>>
>> On 7/12/26 01:21, Pablo Sabater wrote:
>>> On Thu Jul 9, 2026 at 6:11 PM CEST, Tian Yuchen wrote:
>>>> As part of the ongoing libification effort, dynamically allocated
>>>> global configuration variables are being moved into
>>>> 'struct repo_config_values'. To prevent memory leaks, we need a
>>>> destructor to free these heap-allocated variables when a repository
>>>> instance is torn down.
>>>>
>>>> Introduce 'repo_config_values_clear()' in environment.c and invoke it
>>>> from 'repo_clear()' in repository.c. As a starting point, update this
>>>> new function to handle the cleanup of 'attributes_file'.
>>>
>>> Makes sense.
>>>
>>>>
>>>> Note:
>>>>
>>>> Submodules are currently not supported by repo_config_values(), which
>>>> explicitly BUG()s out if 'repo != the_repository'. Since repo_clear()
>>>> cleans up all repository instances, we must bypass them to prevent
>>>> crashing.
>>>>
>>>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>>>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>>>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>>>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>>>> ---
>>>>    environment.c | 19 +++++++++++++++++++
>>>>    environment.h |  9 +++++++++
>>>>    repository.c  |  1 +
>>>>    3 files changed, 29 insertions(+)
>>>>
>>>> diff --git a/environment.c b/environment.c
>>>> index ba2c60103f..13677484de 100644
>>>> --- a/environment.c
>>>> +++ b/environment.c
>>>> @@ -726,3 +726,22 @@ void repo_config_values_init(struct repo_config_values *cfg)
>>>>    	cfg->sparse_expect_files_outside_of_patterns = 0;
>>>>    	cfg->warn_on_object_refname_ambiguity = 1;
>>>>    }
>>>> +
>>>> +void repo_config_values_clear(struct repository *repo)
>>>> +{
>>>> +	struct repo_config_values *cfg;
>>>> +
>>>> +	/*
>>>> +	 * NEEDSWORK: Submodules are currently not supported by
>>>> +	 * repo_config_values(), which explicitly BUG()s out if
>>>> +	 * repo != the_repository. Since repo_clear() cleans up all
>>>> +	 * repository instances, we must bypass them here to prevent
>>>> +	 * crashing.
>>>> +	 */
>>>> +	if (repo != the_repository)
>>>> +		return;
>>>> +
>>>> +	cfg = repo_config_values(repo);
>>>> +
>>>> +	FREE_AND_NULL(cfg->attributes_file);
>>>> +}
>>>> diff --git a/environment.h b/environment.h
>>>> index 6f18286955..c4a6a45704 100644
>>>> --- a/environment.h
>>>> +++ b/environment.h
>>>> @@ -135,6 +135,15 @@ int git_default_core_config(const char *var, const char *value,
>>>>
>>>>    void repo_config_values_init(struct repo_config_values *cfg);
>>>>
>>>> +/*
>>>> + * Frees memory allocated for dynamically loaded configuration values
>>>> + * inside `repo_config_values`.
>>>> + *
>>>> + * As dynamically allocated variables are migrated into this struct,
>>>> + * their FREE_AND_NULL() calls should be appended here.
>>>> + */
>>>> +void repo_config_values_clear(struct repository *repo);
>>>
>>> I think that I'm not comfortable having the _init() and the _clear()
>>> functions with different signatures.
>>>
>>> _clear() takes struct repository to dodge a BUG().
>>>
>>> I would like to have both signatures equal, why can't we just do directly:
>>>
>>>     void repo_config_values_clear(struct repo_config_values *cfg)
>>>     {
>>>     	FREE_AND_NULL(cfg->attributes_file);
>>>     }
>>>
>>> and call from repo_clear():
>>>
>>>     repo_config_values_clear(&repo->config_values_private_)
>>>
>>
>> I particularly agree with your point that the signatures of these two
>> functions should be consistent. I missed it tbh...I will change it in
>> the next reroll.
>>
>> However, I think it makes more sense to refactor to pass in 'struct
>> repository', which is consistent with repo-settings.
> 
> Whatever the signature is as long as it's symmetrical, is fine by me. However
> having 'struct repository' on _init() just passes the problem that
> _clear() had.
> 
> Let's look at initialize_repository():
> 
> 	void initialize_repository(struct repository *repo)
> 	{
> 		if (repo->initialized)
> 			BUG("repository initialized already");
> 		repo->initialized = true;
> 	[snip]
> 		repo_config_values_init(&repo->config_values_private_);
> 	[snip]
> 
> if we change the _init() signature to receive 'struct repository', how do
> we access our _private_ field? We cannot call repo_config_values() on
> repo_config_values_init() because initialize_repository() is also called for
> submodules (repo_init() -> initialize_repository()) so we would BUG() out.
> We would have to access the _private_ field directly at _init().
> 
> With _clear() accessing directly the _private_ field we can forget about
> the NEEDSWORK, it works for every repository.
> 
>>
>>> I get that the workaround might be to not access directly to
>>> &repo->config_values_private_ which repo_config_values() returns but for
>>> example initialize_repository() access this _private_ field directly as
>>> well.
>>
>> Now that we have used the _private_ suffix, if we can just define a
>> _clear() to bypass the assertion of repo_config_values(), wouldn't this
>> be self-deception? I'm not saying that the original lines are
>> necessarily correct... but I do think that semantically speaking, it is
>> inappropriate to pass in config_values_private_ to _clear().
> 
> I don't think it would be "self-deception": _init() and _clear() are the
> start and end of this _private_ field's lifecycle so having them receive
> 'struct repo_config_values' directly sounds reasonable to me.
> 
>>
>>> Also at repo_init(), initialize_repository() sets repo->initialized
>>> before anything can fail and call repo_clear() but
>>> repo_config_values_clear() should be able to free attributes_file even
>>> just after a memset() (which happens before initialize_repository()).
>>> But calling repo_config_values has a BUG() in case of
>>> !repo->initialized are we comfortable with this assert?
>>
>> This goes back to the previous topic: Who is responsible for the call to
>> _clear()? Who is responsible for filtering all those invalid usage of
>> repo instances? Faced with a repo instance that was not initialized but
>> was handed over to _clear() in some way, we have two concepts:
>>
>> - It doesn't matter. Since we always handle config_values_private_, it's
>> NULL at this point, so we don't BUG() and continue.
>>
>> - The very existence of such a repo is a mistake. It shouldn't have
>> appeared and shouldn't have been passed on to me. However, since this
>> situation is relatively common at this point, we choose to return
>> instead of BUG()ing it directly to temporarily avoid it. We will
>> gradually tighten the conditions. When the invalid calls are eliminated
>> in the end, such checks will no longer exist.
>>
>> Our consensus should at least be that this 'use of uninitialized repos'
>> is bad, so they are just two different ways to solve unexpected
>> situations. However, in my opinion, the difference between these two
>> concepts lies in whether we are consciously moving the assertion
>> downward. I think the latter line of thinking does this better.
> 
> Sounds reasonable, but I think I would go with the first thought of "It
> doesn't matter...".
> 
> Having _clear() access directly removes the need for tightening the
> conditions, because there would be none. The _clear() works for any repo
> as long as it has gone through a memset().
> 
> I think that the ones that should ensure that we don't have a "bad
> repository" should be the rest of the code and leave _clear() to just
> clear.
> 
>>
>>
>>   >
>>   > Even with the NEEDSWORK it is a silent return, what will happen when
>>   > submodules are supported? If no one remembers to change it we will leak
>>   > the submodules silently.
>>   >
>>
>> I will remember to change it ;)
>>
>> Regards, yuchen
>>
>>>> +
>>>>    /*
>>>>     * TODO: All the below state either explicitly or implicitly relies on
>>>>     * `the_repository`. We should eventually get rid of these and make the
>>>> diff --git a/repository.c b/repository.c
>>>> index 187dd471c4..b31f1b7852 100644
>>>> --- a/repository.c
>>>> +++ b/repository.c
>>>> @@ -388,6 +388,7 @@ void repo_clear(struct repository *repo)
>>>>    	FREE_AND_NULL(repo->parsed_objects);
>>>>
>>>>    	repo_settings_clear(repo);
>>>> +	repo_config_values_clear(repo);
>>>>
>>>>    	if (repo->config) {
>>>>    		git_configset_clear(repo->config);
>>>
>>> Regards,
>>> Pablo
> 
> Regards,
> Pablo

I thought about it again, and okay, I have to admit your approach is 
indeed more reasonable. Maybe it was just my stubbornness stemming from 
staying up late thinking last night. :D

Thanks! yuchen
