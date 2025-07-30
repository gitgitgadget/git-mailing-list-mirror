Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6212900BF
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753865641; cv=none; b=rQ9UGIMEfrj0LfZN1wHTzakUG4m+LYLIEymax++yBSVhtFBOrJZSDMtnAgXChaIyHusd2OtowuEoy1Ma4B5KaszvbpR/fP3y0GI5H4W1tTTyID4AYgCG8jSvafep1nhvTc3khG9qd3sMgwMSsUrBqJyfWvDTmLsS5wmYPnfoq34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753865641; c=relaxed/simple;
	bh=ZUPqhxEhXxO8AP2pC/+eoQxS2Ly6CPFzYLR+0wtEkWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EmTfDGFgMn0V30zwTKaAAiePcmo+DUdNrcvEakQZ9NnsyhmjXcYFnft0JyL7IsFJ9L63vOIxg5CVbXUsLnIWlETDLkYiLcuW6ZJ9+IVx83bF26ydM/GHFX//qS+VUzIDaMepLcklTrMaDa5ghvDk5bjvczai/H45lMNGktqR4UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVgmHzuV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVgmHzuV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso63502905e9.3
        for <git@vger.kernel.org>; Wed, 30 Jul 2025 01:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753865638; x=1754470438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YxqXJ5i3j7hu91aU98Cum9bsgbdX+3+wsK4l2mXeQhM=;
        b=DVgmHzuVAsVGEAX5rlCDEwWxcSyd9cKaIRzLMDp9GzIJ94Zpc+p0151NW32oStbhX/
         sEnnx/3ibWGPZW33xjXp/Loydv6WsMC8efOMvzsLdIQDyCLgtW28CGjwmjYbTixXJxlB
         TdMu0rX2VqnRnWDCS0YHJqSTP4tCPcGQLS/YDeneSYlxDf1BYiDsNASZt0fQUN8+zcNa
         H0uG4Jjr1I0agpqudUVNUnVoDPmPKOFxu5YxXueI7QCqi1n72i9KmDt4Xze8KnecRdgT
         RuFNebkoQSWxKO/jA5UYgbfLfPtWWuKMoEGIDL2YahEoDBSCuRmRAqajyAOArCoXlNkf
         6lfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753865638; x=1754470438;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxqXJ5i3j7hu91aU98Cum9bsgbdX+3+wsK4l2mXeQhM=;
        b=otQUDIXPGItz0ruox9GzwYDCTifi02X4EriE9jbvR2PRFu1Y21KU2PIUVEkhTUZopB
         dHupnk5BxcRPTCTAz46TNLhEcU8Vzyf51mG2IJ1KOZbKu5qHg5Zgl4yWz5WLuP43hxh1
         zBldBkG/iivZqJaLziWJccPOhus1dzCeEY/25IIF4H1XvH2dy4e3nmcfa8gtcVdzSFtk
         hARHZ4EKw1W3YqDKWEQIRV87iWXOa475KB5U2CZddu+2qvYg5O4lxuH9Mh7Tu3/cvZPc
         Cofy7K3bQZ4wvxOeP0Po0Z9YezENUXuNOpydIf+AYj1D+Lssi7xP5KvcJgZXGDBXx3Ob
         497A==
X-Gm-Message-State: AOJu0Yz2X21gOhRD9OHMRlXHYNoWITITdVak0pZFd463jEGP7dorsw4x
	5pEak+fYgjbkINwZPgyKFAinaZoPYCDy2tVOYOqg0tGSaAZ9LByEkk76
X-Gm-Gg: ASbGncsaiJ/QMe6yCPVOYhJ70Hju2XIwvNXm3HJoYUUX6QVKyf7elXR5ZxRnAudKopy
	brTOxwkJZt42lDGo8tnP1OPFJZcMZy54nQ+Wa3WrQLt9qb9zNEEp/7/3yCaLyns48flZQFiwyhh
	4ih7rYNL5gpL8CaJGO0jMsAW6z30hCxf1c93EIZTyauleKg8JUgQWLNUj01etm11247aCGgvlE0
	2TgNMqgXIkDgQ31OlKGV3LLDpKWGyIg6jsZ2DSJvHQ+655shMOPCP+6lQEz1nL+uKutn9+cROu8
	W7cgu5ZHvzDqbGEIaWZjbP4kSg9kpdxgVyBxGGFZbisiEmxVyI7yA7r+hpeZ2C90cskHITZn3YM
	g8chq7y/EJOqcIAxTkkeXQ+/4u999oG7ygKVbCsz7gzAA0g1vdrH4I81ixkSvNePYdp9wDnlzJ3
	6E
X-Google-Smtp-Source: AGHT+IHQX6s3AWV8YdUvQZgWlLpfg9AdpO4+VFcMMC5lYez7EDdH0NsghLp3bMCUG3k5cwNOedq3EQ==
X-Received: by 2002:a05:600c:a345:b0:456:2ce8:b341 with SMTP id 5b1f17b1804b1-45892bc48e1mr23847105e9.17.1753865637648;
        Wed, 30 Jul 2025 01:53:57 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589536a712sm17523115e9.6.2025.07.30.01.53.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 01:53:57 -0700 (PDT)
Message-ID: <1f07119e-64b6-453f-ae83-64a5fb486188@gmail.com>
Date: Wed, 30 Jul 2025 09:53:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSOC PATCH 1/2] environment: remove the global variable
 'merge_log_config'
To: Ayush Chandekar <ayu.chandekar@gmail.com>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 shyamthakkar001@gmail.com, Junio C Hamano <gitster@pobox.com>
References: <cover.1753804956.git.ayu.chandekar@gmail.com>
 <c82620a1f54ea6760bff204fd2b5fe5c2df1896c.1753804956.git.ayu.chandekar@gmail.com>
 <23428022-ab13-4a3e-90ed-ff91ef93f051@gmail.com>
 <CAE7as+Y_S=J8D4xrV75w2KJCKzpHamYt4Ug_iGD068i3Kdq5JA@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAE7as+Y_S=J8D4xrV75w2KJCKzpHamYt4Ug_iGD068i3Kdq5JA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Ayush

On 29/07/2025 22:16, Ayush Chandekar wrote:
>  
> On Wed, Jul 30, 2025 at 12:37 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> Hi Ayush
>>
>> On 29/07/2025 17:19, Ayush Chandekar wrote:
>>>
>>> @@ -26,14 +26,7 @@ static struct string_list suppress_dest_patterns = STRING_LIST_INIT_DUP;
>>>    int fmt_merge_msg_config(const char *key, const char *value,
>>>                         const struct config_context *ctx, void *cb)
>>>    {
>>> -     if (!strcmp(key, "merge.log") || !strcmp(key, "merge.summary")) {
>>> -             int is_bool;
>>> -             merge_log_config = git_config_bool_or_int(key, value, ctx->kvi, &is_bool);
>>> -             if (!is_bool && merge_log_config < 0)
>>> -                     return error("%s: negative length %s", key, value);
>>> -             if (is_bool && merge_log_config)
>>> -                     merge_log_config = DEFAULT_MERGE_LOG_LEN;
>>> -     } else if (!strcmp(key, "merge.branchdesc")) {
>>
>> In the old code if both "merge.log" and "merge.summary" are set in the
>> config file the last one wins
>>
>>> +void adjust_shortlog_len(struct repository *r, int *shortlog_len)
>>> +{
>>> +     const char *keys[] = { "merge.log", "merge.summary", NULL};
>>> +
>>> +     if (*shortlog_len >= 0)
>>> +             return;
>>> +
>>> +     for (const char **key = keys; *key; ++key) {
>>> +             int is_bool, value;
>>> +             if (!repo_config_get_bool_or_int(r, *key, &is_bool, &value)) {
>>> +                     if (!is_bool && value < 0) {
>>> +                             error("%s: negative length %d", *key, value);
>>> +                             return;
>>> +                     }
>>> +                     *shortlog_len = (is_bool && value) ? DEFAULT_MERGE_LOG_LEN : value;
>>> +                     return;
>>
>> In the new code "merge.log" is always used in preference to
>> "merge.summary" even if "merge.summary" appears later in the config
>> file. When you have two keys setting the same variable I think the only
>> way to preserve the last one wins behavior is to keep using a callback
>> that updates the value as the config files are parsed.
>>
> 
> Sorry for not mentioning this in the commit message.
> 
> I had looked at the documentation which says:
> 
> Documentation/git-fmt-merge-msg.adoc
> merge.summary::
> Synonym to `merge.log`; this is deprecated and will be removed in
> the future.
> 
> So I thought that I should give precedence to "merge.log" as
> "merge.summary" is deprecated.

If it is deprecated we still need to support it until it is removed 
(maybe we should do that in Git 3.0?). We cannot change the behavior 
just because a setting is deprecated.

Thanks

Phillip

>> Thanks
>>
>> Phillip
>>
> 
> Thanks
> Ayush
> 

