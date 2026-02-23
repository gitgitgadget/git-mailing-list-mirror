Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB219343208
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 03:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771818072; cv=none; b=DjqgcaaSSUGdTkTfAaTqe2IyAEVicSe6cHbHj1T7BxKiAPsZQOKLL5/0P0GJBWm5stplAbj7Pat2B8qfz+JEcrct11PDzbXPko62AOrCXgKHhlpdyhEgD6U4nm14kkFmW0dd3o8h8fKBmtFtWI5uZ4rbW78r6ZEXayot2E4aBh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771818072; c=relaxed/simple;
	bh=Iux959/8KrRHTJGhwi5M4bBwheYgrCXDZz2e5t6RxQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Io5G1ur5DXnsIIvgUU6NoL3IrsyEV5UMhEOz77ttApFw/ngSu99bWcWRKPZ+9Z9bwpAieNGgWmF0nDW1cXML5QgbLY2SqxBMANt9eMH7UNI0EEppkPECgykk1jjoouKCAfLOWfR/pH9pql/RGvp2vWK/vv+Aen8LFJ1K2aNayD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=es1L6pw+; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="es1L6pw+"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cb3a8494c5so373290185a.2
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 19:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771818070; x=1772422870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l1Yhc9cZViv4BTjuVfbqSEdaVun4ywLsiwicy8A/+Fc=;
        b=es1L6pw+Sdr1dbxpDwoc5G2rqJqiGkfuhMR7cnAsiPb85HLRa/Pf8PdMmOZPFlm6aY
         5GQMAu1SmD6S+ZGuLpS1ZLRKuMWoODyilvkAOiVuMDyoEGNIgd5gh5084WaLpjKKb85W
         NiBH1lpEsfbUaVaOh+Qb0DnhVhgbxGsCN0VlnFTZWuVe03vjqzpFWJwCq2nPGmPLW04A
         KmfqRRYfI3+vtGXpOW1qAVPwtCX/RyZyNvmEKkNe77KMdvPmFyAgcTlqHxz9CkNIpD+a
         DcJSJXPyigF/X+ThVHE9UNaD0XqRX9QpeRjd+wgoTo09l3DDtzzQU8h2XwanRYUre4kh
         Fkuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771818070; x=1772422870;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1Yhc9cZViv4BTjuVfbqSEdaVun4ywLsiwicy8A/+Fc=;
        b=IB/F8gXArdFYHLoXN/jeus9n30c769KrMVXL4iMKkR765v5y65h9elBC0fb6+B0+WA
         rF+Babr3Hm0yHYtXUYgwR379ZRwJ4v+hv+GljEeiN9KSWjudJS/gtG4rFCceQ9/RAK5R
         +Agx1tsLxFYu25t1ryoYzFH5w/+h0jxKxxG/TRC0QUZ0HfBD1UAPY1T1ardR7j1En1If
         o4W3Z4gs/2x/hYrKeGEDbylRCaydjO5fOQX61q3C4jktzNbvDDoHRFsLUVMEi5WjVOji
         VM+ywgbU35qVxMzmn4KW3AF1BMQWA3WE3/7lTKGvMyR9mUgoT+4gmMp6/6N1EIwoSaeb
         WAaw==
X-Gm-Message-State: AOJu0YxNHfjc1AEe2VovrrJh+cJahzUuwGLNcx7m03DqX6tefV3di8MI
	aeKzIfCKR6d5+iV44ozNmo1YcfKP2Dnq25KNz5JUOTG/02t8wapNwy2s
X-Gm-Gg: AZuq6aLrAMKAjqTmcjYMa+cN/5MCGKXaKO+pCfea13PNnjsKIL0NZPqkLmj1cX7CCMo
	VEockf+pATpw7lqRKeJdPxPM8Xu4xry0uUqbC+F6LdY8vQyWw2/7UcwDx7EQj2GFYu86Bt/jX+X
	I3sGgnnN1AjU1wNp7Y4twsUOTbTkusd56X+Ot+1gHeQUFmWjUMpXvJGDY4SZroF5kwnvTQwAz16
	1cFf+Hjjiop4/Gf5NmtuoSLXM48kLPRnEbffhHLvgKPlkQ6npfyhRPQ6GYzlCqXTeHFsZp6/rkN
	f9C2bPvlkWFMbAX8MTGx2Ut2xAIHZHO4M710udefk98hlvuM59UHavHZKY6PyWFV6uWp/whtBbm
	9+u9wT5L6KIp75tAAdlH/moFfLK/uYQ0cJlVOx4HnMmaC8uvVfOcemNFhbWPzBB/6egNsRkJySQ
	HUetGpGN9Ky94/7hc7ikSLIpqQEGFHbvFNxcgSsuJZ+qz+bSRcx+fImv3E3wiyX+89HaTS+lq/x
	ypDBxNGd9UK9X5WvrGsZdcBpuCJ0Bh/b7NyyQyy8qdpMFJE
X-Received: by 2002:a05:620a:4016:b0:8b1:728f:952e with SMTP id af79cd13be357-8cb8ca135b5mr912959985a.31.1771818069831;
        Sun, 22 Feb 2026 19:41:09 -0800 (PST)
Received: from ?IPV6:2605:a601:a6b4:9c00:55d0:428:5136:da98? ([2605:a601:a6b4:9c00:55d0:428:5136:da98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8997e242fadsm58219246d6.34.2026.02.22.19.41.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 19:41:09 -0800 (PST)
Message-ID: <94ee4b78-48f9-4e2c-aee5-ced1dc9a12fd@gmail.com>
Date: Sun, 22 Feb 2026 22:41:08 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] config: format int64s gently
To: Patrick Steinhardt <ps@pks.im>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Phillip Wood <phillip.wood123@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>
References: <pull.2044.git.1770698579.gitgitgadget@gmail.com>
 <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
 <2bca4d231686e33ea9d4d85b10fcffd60a63ad46.1771026918.git.gitgitgadget@gmail.com>
 <aZQvP21anXXZWcMh@pks.im>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <aZQvP21anXXZWcMh@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/26 4:05 AM, Patrick Steinhardt wrote:
> On Fri, Feb 13, 2026 at 11:55:09PM +0000, Derrick Stolee via GitGitGadget wrote:
>> diff --git a/builtin/config.c b/builtin/config.c
>> index 4c4c791883..d259a91d53 100644
>> --- a/builtin/config.c
>> +++ b/builtin/config.c
>> @@ -237,6 +237,25 @@ struct strbuf_list {
>>   	int alloc;
>>   };
>>   
>> +static int format_config_int64(struct strbuf *buf,
>> +			       const char *key_,
>> +			       const char *value_,
> 
> Why do we have the trailing underscores here?

This is all to match the existing names from format_config(). This may help to
recognize moved lines by keeping the variable names the same. Definitely not
my preference to use this name format, but I thought it fitting to avoid a
rename of all variables.

Thanks,
-Stolee

