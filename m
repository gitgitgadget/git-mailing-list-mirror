Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D571ACEDE
	for <git@vger.kernel.org>; Tue, 12 May 2026 15:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778598438; cv=none; b=Ll70lMjGIjt/qxHUTjcjnz2eAFElTRHFZgO5VPxZAIW9uelykyNtOxzwCqLrNSiq/NwAcVFSuhql1fZ0VxohjSIGHSTaNoOqTOw1cxYT2a9lcTksKtjbhKThM3zqNEg1BojDhNebM3nvHqxTeVnSu1Q7gf5Ggn4Bbj20TYrzAAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778598438; c=relaxed/simple;
	bh=JMzeLrYjkjsH9gUxDIlDo5HcOQs8xFZoCS5RiMbsfa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwMYwMcydkeoUhSxxNDNtcJ4ZsJv3H47wN/aWthSfNUqHP0+TlBTwDKopvyQCu5tG89eY5sVGYOwsFSKVihJAEzikN+tN2MlH87RIN9cDljZ2z91pd2rirIMV5IvAB5hiDgOmRYdL98hhJsd78wbuMbbyWb0lIAMswAoq24Sb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nwfIY/q1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwfIY/q1"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bce57c132b2so389071566b.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778598436; x=1779203236; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PekKlSbgnmin1lA4jReeYc8tYcCchfjfb7V5ytsA7DY=;
        b=nwfIY/q1K72QRccdUGASLcF0Eo8eb/2EjJbDvY0kKS9FNiHo5gwFkLg7zTw+6CNojA
         0mIolTo91y8dgI47k8GEiyxRip0x219YyCSzh3BqjS6P8+vyoM6OefKKgK2clNl4KbER
         oaJ9uANM2tCVdq7SYXod+CZGJerj07cuMITDBahvpEQ6FzhrDwQp2oeS5mBXDTZ1Rboq
         PN6MYbdv5RXXu5vr6RyNBRkT75+8nqzNodh4DuN2ZFiAUixHnF2pFGXiSkzO76j2az0b
         P2NqPmeCJBB16ToF867/OPAQyxlyhSXJsHQG6Ua39GrrHsg6k1RwxryCuDCpKjrnGkqL
         W/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778598436; x=1779203236;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PekKlSbgnmin1lA4jReeYc8tYcCchfjfb7V5ytsA7DY=;
        b=kJdJV28lpKCNOaM8sc7blI2Gcymt8liBYTc6aURcCMv4TCb6ficNhoweVwVsXR/wK5
         ZD+3Se3cwPoQIPiZ0EXMlHmV8szAuAgpMw4xJ8wZXRyBgALB1+BFRgEKKw+zOMhjYTin
         5PPP1BLJr5EBffxbJyY/t95dx0oyRwBHWdn08OzLq+xW9lUJEzBkH6dkenOCt48ZQrbs
         aWpkWFYMGPginMIZ76o648Jd9clCsm1JKkuLByOnkKz5EgV4t6ptv0hJ1QnATS/gaVZ0
         OjDNYxtpGTRR3DRfB8jhQofj0mW8isCIncErhe00xaU6+It48id2LG9wgkEW2/tAmlXZ
         xEfA==
X-Gm-Message-State: AOJu0YyKFHInwIpNGbXQ5JIKiM7PsO0J0ODMTIh4mH2wcCsAupuePP56
	rkx8HleaFYoQNHkEU7sE97FFhWypNbazE499FwBfl+8/R57rnMqE2lXeJ5SVzA==
X-Gm-Gg: Acq92OF+UkGVaHl9xaAxQ1iwrt3zAqOm5PA2cLH0TTNHxcpBdkRa0ZQPVrBJ8krAq1+
	6+5pSDm7OVZXt8ANKomuFPGdetA5n3qj/zPEqC1T1pnI2quD6hpN9wCR3kATO2WTu10IvE9WMdS
	TNuH57Hm1SL8wPe4aq8/hSOT+TOPaqxEvIO5JV1mf/bCNUAk7oNSwxNb9KvE26unaH6xyfknXNt
	9ASyX9q18/HNHyarpl3SvDyxxl/4uFPL8uJGwp3VtAjCUElCMqDSFgApzTizhYp5urXAIslygkO
	LYPE7iiLKaC06aFSC5AXQBRHn497pbqlgGrZdJCLmW8m/mmzNzSdRZqMb0JRRJqclxePKEXc3oM
	pYCZVUTSuI03UszWjCHCmsqXH29krmxt6bCzbIHYRi7b/ass0bWWmZtc4o31NfdvWWgYg24NoGV
	+OsJH3lsUIUSqmvjEDgqCc2lLlFupwUmSieSCO6ERcs32AQwvNRSWFESEo9buIuKuo2z5pZ/jQj
	GdjvA==
X-Received: by 2002:a17:907:7ba3:b0:bc1:7da0:21 with SMTP id a640c23a62f3a-bd23cefe472mr229514666b.23.1778598435406;
        Tue, 12 May 2026 08:07:15 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7? ([2a0a:ef40:17d3:2101:5ed:447d:e5d1:52d7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120ec0asm32594867f8f.17.2026.05.12.08.07.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2026 08:07:14 -0700 (PDT)
Message-ID: <d236de15-f03e-4bac-9eb1-c14e50a271f5@gmail.com>
Date: Tue, 12 May 2026 16:07:12 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] config: add "worktree" and "worktree/i" includeIf
 conditions
To: Patrick Steinhardt <ps@pks.im>, me@black-desk.cn
Cc: git@vger.kernel.org,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Junio C Hamano <gitster@pobox.com>
References: <20260403-includeif-worktree-v3-0-109ce5782b03@black-desk.cn>
 <20260403-includeif-worktree-v3-2-109ce5782b03@black-desk.cn>
 <agLTO0amktCWMsiE@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <agLTO0amktCWMsiE@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/05/2026 08:14, Patrick Steinhardt wrote:
> On Fri, Apr 03, 2026 at 03:02:29PM +0800, Chen Linxuan via B4 Relay wrote:
>> From: Chen Linxuan <me@black-desk.cn>
>>
>> The includeIf mechanism already supports matching on the .git
>> directory path (gitdir) and the currently checked out branch
>> (onbranch).  But in multi-worktree setups the .git directory of a
>> linked worktree points into the main repository's .git/worktrees/
>> area, which makes gitdir patterns cumbersome when one wants to
>> include config based on the working tree's checkout path instead.
>>
>> Introduce two new condition keywords:
>>
>>    - worktree:<pattern> matches the realpath of the current worktree's
>>      working directory (i.e. repo_get_work_tree()) against a glob
>>      pattern.  This is the path returned by git rev-parse
>>      --show-toplevel.
>>
>>    - worktree/i:<pattern> is the case-insensitive variant.
> 
> Seems sensible.

We already support per-worktree config settings via 
extensions.worktreeConfig, so it would be helpful to explain why it is 
more convenient to set the config based on the worktree's path, rather 
than just running "git config --worktree" inside the worktree. Do you 
have multiple repositories with worktrees checked out under a common 
prefix that you want to share the same config setting?

Thanks

Phillip

>> The implementation reuses the include_by_path() helper introduced in
>> the previous commit, passing the worktree path in place of the
>> gitdir.  The condition never matches in bare repositories (where
>> there is no worktree) or during early config reading (where no
>> repository is available).
> 
> Right. This is because `repo_get_work_tree()` would return a NULL
> pointer in these cases, and `include_by_path()` exits early in that
> case.
> 
>> diff --git a/Documentation/config.adoc b/Documentation/config.adoc
>> index 62eebe7c5450..a4f3ec905098 100644
>> --- a/Documentation/config.adoc
>> +++ b/Documentation/config.adoc
>> @@ -146,6 +146,48 @@ refer to linkgit:gitignore[5] for details. For convenience:
>>   	This is the same as `gitdir` except that matching is done
>>   	case-insensitively (e.g. on case-insensitive file systems)
>>   
>> +`worktree`::
>> +	The data that follows the keyword `worktree` and a colon is used as a
>> +	glob pattern. If the working directory of the current worktree matches
>> +	the pattern, the include condition is met.
>> ++
>> +The worktree location is the path where files are checked out (as returned
>> +by `git rev-parse --show-toplevel`). This is different from `gitdir`, which
>> +matches the `.git` directory path. In a linked worktree, the worktree path
>> +is the directory where that worktree's files are located, not the main
>> +repository's `.git` directory.
>> ++
>> +The pattern can contain standard globbing wildcards and two additional
>> +ones, `**/` and `/**`, that can match multiple path components. Please
>> +refer to linkgit:gitignore[5] for details. For convenience:
>> +
>> + * If the pattern starts with `~/`, `~` will be substituted with the
>> +   content of the environment variable `HOME`.
>> +
>> + * If the pattern starts with `./`, it is replaced with the directory
>> +   containing the current config file.
>> +
>> + * If the pattern does not start with either `~/`, `./` or `/`, `**/`
>> +   will be automatically prepended. For example, the pattern `foo/bar`
>> +   becomes `**/foo/bar` and would match `/any/path/to/foo/bar`.
>> +
>> + * If the pattern ends with `/`, `**` will be automatically added. For
>> +   example, the pattern `foo/` becomes `foo/**`. In other words, it
>> +   matches "foo" and everything inside, recursively.
> 
> This whole listing here is the exact same as we have for the `gitdir`
> condition. Can we maybe deduplicate these into a common section?
> 
>> diff --git a/config.c b/config.c
>> index 7d5dae0e8450..6d0c2d0725e4 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -400,6 +400,12 @@ static int include_condition_is_true(const struct key_value_info *kvi,
>>   		return include_by_path(kvi, opts->git_dir, cond, cond_len, 0);
>>   	else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
>>   		return include_by_path(kvi, opts->git_dir, cond, cond_len, 1);
>> +	else if (skip_prefix_mem(cond, cond_len, "worktree:", &cond, &cond_len))
>> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
>> +				       cond, cond_len, 0);
>> +	else if (skip_prefix_mem(cond, cond_len, "worktree/i:", &cond, &cond_len))
>> +		return include_by_path(kvi, inc->repo ? repo_get_work_tree(inc->repo) : NULL,
>> +				       cond, cond_len, 1);
>>   	else if (skip_prefix_mem(cond, cond_len, "onbranch:", &cond, &cond_len))
>>   		return include_by_branch(inc, cond, cond_len);
>>   	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
> 
> I feel like this is something that we might eventually want to convert
> to be table-driven. But I think that doesn't have to happen as part of
> this patch series.
> 
>> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
>> index 6e51f892f320..8a5ba4b884d3 100755
>> --- a/t/t1305-config-include.sh
>> +++ b/t/t1305-config-include.sh
> 
> Just because it was explicitly mentioned: we might also want to have a
> test that verifies this works with early-config parsing. We already have
> a similar test for "gitdir:" in "conditional include, early config
> reading".
> 
> And should we also have a "nongit" branch where we verify outside a
> repository?
> 
> Other than that this series looks good to me, thanks!
> 
> Patrick
> 

