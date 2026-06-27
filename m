Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E93388E7A
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782569427; cv=none; b=V0q7c3YM/JhxxqW9/wC25Cl6hyCnTX24CcUQE/9LCOZZMv6Stsaknsjs+KV3qLfVG6q/0r3EKwbwML+Tb6UBjkFQgCjoqG2U/nbzMsvejoyZ6nuGlI5x1SR3eQegag1TyBmVieR2AaE217cdSNMa0eXwF4LSbVTl5PjFd93qg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782569427; c=relaxed/simple;
	bh=0C6Hm/Rx6n9WdBAnrv0VtPSqPTvpmyhzlFDmNsy8isE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DM6LiqkYVzbwyvQtsuEn0FHKQTroP+ZdyOPYFpGTt6SvyyklZNAkjsXUEtPTAl6x9eIOZYdMK6+cC116vHhHI+yuFrrDWDYXjMAe4fTLT36TtmquBi7cJtcLmS9IunelVAKu3h0D9QPnzIFmFjUdV8/3zfiTSEUow0NSv9dmCps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=DccFKApS; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=X7A1Tyox; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="DccFKApS";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="X7A1Tyox"
DKIM-Signature: a=rsa-sha256; b=DccFKApSjsHEt5ioBsNs8r2zn30mlSP3FMqfoecQ1f8CKc4k0Fdj6GV+giNl+q1jJi3hQOSVP20rLDrSzW7jbXqXIL1a25FjguXOalkSNRP72WRe6/oxs+LDDBBgM9CIwYZ3FKPgFKd+Q6kH/JtBfxzK2B9GGQ+gAPSCcv8XGKeCNgCEItXtYjhxs3knS0eLKyfiBBSqopmdY8DiZKlRPD9naayGczuAzBsgQWFUCb+0jPtNL8AHGY6ai7wfD4bCWNn+DF3sHxX7HyHDqtmElx4kGNfmWFk0la9CQyCDLtqzXb8D1d9JoVoZPztrQo63msgH+zBNJ/nl9tze63c55g==; s=purelymail2; d=malon.dev; v=1; bh=0C6Hm/Rx6n9WdBAnrv0VtPSqPTvpmyhzlFDmNsy8isE=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=X7A1Tyox55OsASh4gnyJYeJ2KJS66EBi54CbS0eC6Skqqn88xblazUDWCBw6VuryV9+UL2gKUrt8Vm1Vh/GUahxKkFGEBktDkPzejAGEuhSyhzUXDKJUGveR7z/x5Hu6xuAdkmCv6Kg5tGX8p94Yc+pW0pZ5F64gHDE+X62QyRVFgNjeUktZQAUUs3Cu6g8jah5XaM/xz0/tFt5WLu1KAT5iVhkq+bb0ODUluj5EA19X40qZljtEuZyb3vF5s+kuoZRaXhYYYUDkq/mcXj0c/nhegfQWrLRV6WBzn10Up1AhzNn+tHJJVwOO8fC3PHT6lXNaUdLq0CbgHbt4xUY6qg==; s=purelymail2; d=purelymail.com; v=1; bh=0C6Hm/Rx6n9WdBAnrv0VtPSqPTvpmyhzlFDmNsy8isE=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 2007367530;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 27 Jun 2026 14:10:21 +0000 (UTC)
Message-ID: <5abe7da6-5fac-4f4f-8ad9-93811c8c82e5@malon.dev>
Date: Sat, 27 Jun 2026 22:10:16 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] environment: move excludes_file into
 repo_config_values
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, cirnovskyv@gmail.com,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260626075037.532164-1-cat@malon.dev>
 <20260626075037.532164-3-cat@malon.dev> <xmqqjyrl6rpt.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqjyrl6rpt.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/26 03:12, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> Continue the libification effort by moving the 'excludes_file' global
>> variable into 'struct repo_config_values'.
>>
>> Since 'excludes_file' is a dynamically allocated string (char *), it
>> requires proper memory management. Introduce repo_config_values_clear()
>> to safely free the heap memory when repository instance is destroyed.
>>
>> Note:
>>
>>   - 'if (repo != the_repository)' fallback logic is temporarily added
>> in both the getter and the clear function. This prevents calling
>> repo_config_values() on uninitialized submodules, which triggers BUG().
> 
> Would it be possible for the function to be called on the_repository
> before it gets initialized?
> 
>> +void repo_config_values_clear(struct repository *repo)
>> +{
>> +	struct repo_config_values *cfg;
> 
> What I am wondering is if this check
> 
>> +	if (repo != the_repository)
>> +		return;
> 
> wants to be more like
> 
> 	if (!repo->initialized)
> 		return;
> 
> or even
> 
> 	if (!repo->initialized) {
> 		BUG("clearing uninitialised repo config");
> 		return;
> 	}
> 
> Or perhaps not doing anything special there.
> 
> For that matter,
> 
>> +
>> +	cfg = repo_config_values(repo);
>> +	if (!cfg)
>> +		return;
> 
> Wouldn't it be a bug to see NULL returned from the above function?
> Why is it healthy to pretend as if nothing bad happened?
> 
>> +	FREE_AND_NULL(cfg->attributes_file);
>> +	FREE_AND_NULL(cfg->excludes_file);
>> +}
> 
> 
> What do we want to happen when somebody does want to access (not
> _clear(), but repo_config_values() itself) repo_config_values() in
> today's code?  Don't we want to catch such a code as buggy?  Isn't
> it the reason why repository.c:repo_config_values() check these
> conditions and calls BUG() in the first place?  And if that is the
> case, I find that a caller that "works around" by pretending nothing
> bad happened and not calling repo_config_values(), like the above
> code does, highly questionable, as it smells like sweeping problems
> that you designed other parts of the code to detect with BUG() under
> the rug.
> 
> In the longer run, we would want to have separate settings, which
> used to be global variables but now are stored in per repository
> config, available and usable in the context of each repository that
> they are configured within.  If a caller wants to clear per repo
> config for a repository instance by calling this function, this
> function is in no place to tweak the intention of the caller by
> short-circuiting the request and pretending it did what it was asked
> to do.  In other words, the rest of the code not quite prepared to
> deal with these global variables that turned into per repository
> configuration values is *not* a problem this function should
> address.  Let it be noticed by repo_config_values() function to
> catch offending callers for now, and once the codebase becomes ready
> to use one repo_config_values per repository, this function does not
> have to change.

Yes, indeed. I initially thought these were two solutions leading to the 
same goal, but now that you mention it, I think your point is more valid.

First, 'repo_config_values_clear()' shouldn't know whether "only 
'the_repository' is currently supported" (even if this logic is 
necessary, this function is clearly not the optimal place), so we 
shouldn't use 'repo != the_repository' to determine this.

Second, what's wrong with '!cfg' is that what it's supposed to avoid 
deviates from what it tries to avoid. 'repo_config_values(repo)' 
shouldn't validly return NULL at all. I admit this code is nonsensical.

Using 'repo->initialized' to determine this is consistent with our 
previous approach. I'll try it. Thanks for the review!

Regards, yuchen
