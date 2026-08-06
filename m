Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6115420E89
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 08:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006159; cv=none; b=LSmgLNJYHRIGGFmsQ9f4mZhPe1XGCBsABubeyOFW4v1XDcKMNDBzBpScfSwu+HG0EyimpjTiBjzrgH2wmgMBnsCxtjWHKTsALEHpHnn5+ZqAMBKA9mc1m8iSkaFJeb+uUnuu+ee+ZKJQ+Da7+38y59vpXcfZ476Ry4/GWlMOrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006159; c=relaxed/simple;
	bh=Ioj1aZzhBdupi5Juz/LTrTiGbRN/XfZD6Ir+LUvZ4h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyvCcaJYshjARYxTm3K79tRlkHGJ0gJOkGf4ZTY8c53pWbW1sQz0bHUPL8jcEKDPvuzJWxTggnmnIPJ4KTM+R7q7T79CnFXij2bLn7DCgzO+ZVR3Cz700ysy4RIuqoT2TdY0ZWxL25QWEsQoLXXYJsYu+Xx+gkYBBXMUarFDbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=C1DzNABE; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=VPDse4Kz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="C1DzNABE";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="VPDse4Kz"
DKIM-Signature: a=rsa-sha256; b=C1DzNABEn61hcUQVwFmitiUsXLU8sBCwiOkIB6sTpiNWmtZzu6432rberzLoj+zWU/cvz/KZmJiIXtDDsp9DvQ7u8+I0RFlH95jkonJ5FS/iTFYAF3S/nYRXz2MNunT9oFPTL4hCzMc9EMytRKtXFfv36xJaohCcnJMcUY+2fqacx1DAgaR3R135TmBeJ1KAfNTnN2RPQYuLsqm9HoQIdPHWhUhEjS+CZPwBp/XN00omTiyJMHA/mE9OEcNPNzNpaqg4y92JfyXZ2dJZmYjeGaZOGtFHnnvWouI87s0fmtP7jeZDQ28iL2KoeZsACc0w2wuKssTCugeCx3BCinavlA==; s=purelymail2; d=malon.dev; v=1; bh=Ioj1aZzhBdupi5Juz/LTrTiGbRN/XfZD6Ir+LUvZ4h4=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=VPDse4KzqEjsf5Ix66eEzst0cWcnKqFp6/qbuWxTfDeFYVICgsMKOx7ZD443aVO2v6bXq1Y8EFKPNfyuGjP7SnYhQIzO1gJRaGj8Zf7yuayhk5s2eEY84LA+V6bZp4qXrk2Ig3tJZ5WswfjpPLB4Lb4cLdR2io9hw5pHIhI6V1W+AdkiRxhbgHGB6WNYdxjwW1HhJooHL53QeelBBr6WFczuhBbrafslpG6tgn/TQj50j+9UY3SEykkg3I9Ect8p5Rf9sba0HoKn4o4c3Z/KHjdPHC9uk2HEOcrYny8ONWg0oFgzjZjVyGEsZZiBANXwoSiRyIdwIPK6HSKb2+71Yg==; s=purelymail2; d=purelymail.com; v=1; bh=Ioj1aZzhBdupi5Juz/LTrTiGbRN/XfZD6Ir+LUvZ4h4=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 451536638;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 06 Aug 2026 08:49:14 +0000 (UTC)
Message-ID: <c39c51d7-07bf-42f7-8b26-47dd9ef0e5b3@malon.dev>
Date: Thu, 6 Aug 2026 16:49:07 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] environment: clarify repository config getter
 documentation
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260805115342.3939931-1-cat@malon.dev>
 <20260805115342.3939931-3-cat@malon.dev> <xmqqtsp8nt7i.fsf@gitster.g>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <xmqqtsp8nt7i.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/6/26 05:38, Junio C Hamano wrote:
> Tian Yuchen <cat@malon.dev> writes:
> 
>> Update the comment above repository config getters to describe their
>> common behavior.
>>
>> The getters handle repositories that are not fully initialized by
>> returning the corresponding default values.
>>
>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
>> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
>> Signed-off-by: Tian Yuchen <cat@malon.dev>
>> ---
>>   environment.h | 11 +++--------
>>   1 file changed, 3 insertions(+), 8 deletions(-)
>>
>> diff --git a/environment.h b/environment.h
>> index e7ec5b0437..30678257b5 100644
>> --- a/environment.h
>> +++ b/environment.h
>> @@ -175,18 +175,13 @@ int git_default_core_config(const char *var, const char *value,
>>   			    const struct config_context *ctx, void *cb);
>>   
>>   /*
>> - * Getters for the `protect_hfs` and `protect_ntfs` fields of `struct repo_config_values`.
>> - * They check `repo->initialized` to prevent calling `repo_config_values()`
>> - * before the repository setup is fully complete or in non-git environments.
>> + * Getters for configuration variables in `struct repo_config_values`.
>> + * These functions handle uninitialized repositories or non-git
>> + * environments by returning appropriate default values.
>>    */
>>   int repo_protect_hfs(struct repository *repo);
>>   int repo_protect_ntfs(struct repository *repo);
>>   
>> -/*
> 
> Two puzzlements.
> 
>   * Is the above comment block meant to apply to repo_ignore_case()
>     in addition to repo_protect_ntfs() and repo_protect_hfs()?  If
>     so, the blank line before repo_ignore_case() is a bit misleading.
> 

Not really, they are meant to apply to all getters below. I will remove 
the blank lines.

>   * The phrase "uninitialized repositories or non-Git environments"
>     strongly hints that I can pass NULL to indicate that we are
>     running in a non-Git environment.  However, the change in
>     [PATCH 1/3] we just saw means I would get a segfault if I did so,
>     does it not?
> 

This is a mistake. I meant "these getters can handle repositories, even 
when they are not fully initailzed" but not "these getters can handle 
whatever we pass in". So I will change it in the next reroll.

>> - * Getter for the `ignore_case` field of `struct repo_config_values`.
>> - * It checks `repo->initialized` to prevent calling repo_config_values()`
>> - * before the repository setup is fully complete or in non-git environments.
>> - */
>>   int repo_ignore_case(struct repository *repo);
>>   
>>   int repo_trust_executable_bit(struct repository *repo);

Thanks! yuchen

