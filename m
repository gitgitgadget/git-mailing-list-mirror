Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E503C3455
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 09:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159356; cv=none; b=EO0WHL4Ynses72OLfWs1V2fPgDAS8x9mSKCac/W5LTZb0rvZQ23/JDALveXCFcGoRiJsHMtK8fYXeVI6EMq+X8ix3njSVny6ldMoWvLOCH+bzLFrPn5jkt/XafID90uozlfAilm4qM65ES35VraCue3zRKJCzTNXKgiW4SZmEW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159356; c=relaxed/simple;
	bh=1CIw0jbT034+nEvm83tShzbny9S3q1Tz2k0PnLzyD/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvHP+7OhmoZUcFpmCZ3/jA6NiZ4nz/Wijq4tGp3Eh4by0EczfLC18uHcsFhS1g76xOKEF/r3A7P8PnsEFbIxQPjxkXKaRxATR3bmtD+DtXy1QNjiG+S47icLhkn3MLChWWSLkUZ6JQD1Yylgm/cWfcA96m9xL27bAOaw4WwaDec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qa1VfM1p; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qa1VfM1p"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so40526685e9.2
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 02:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776159354; x=1776764154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/6SDeHwrlmdChscfqnbZNDF8c5gpR4Oc/XsBa8VOYWE=;
        b=Qa1VfM1peyCILWVYTUK6HucwdUjF7vFqVo9EbSIGhIyX/YUv/xqH4RpZraQG8ClcOQ
         9cHOlfnT+dUnMnxidw17m7pgKcJqEPIioHOmXHPxt3UdQ5yVDtQv8zsbtSkpCqyCgpUY
         YjXKAFWJd0qLZzdqeAUaDY4dcOXsC4XvReNn1ZYDgwbHgjvWttrywqvcLK1OaXD6FMZP
         LaeILWH+09RXvbQ2BrFF/YVVhs7JPw15TIZc83Vz7fQHGIGoGq0ZS0UTifSvbBMY+I3V
         nhyyhlLF+hR/Ur9C1gJfaeYFvhAwVJXmF4NxpHnBTW/JeeAOg6bQj3HfH0GhGZTej0/A
         qHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159354; x=1776764154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6SDeHwrlmdChscfqnbZNDF8c5gpR4Oc/XsBa8VOYWE=;
        b=nCId7vbcvpULwZH7Hh+QB4U3g+04EhTxOScT49zUACXLs5xUB8MLNFPyIgqDtCi+l9
         KDBG+sJgnWgkHuGyl82u0lSttFLhW5N/RsTycIMgOA7QYLHGFMLGHsgh7iDP6rwQFFQA
         /jSMw58PSxiEe08qX6k/ESU3n2bWZzc56bnrd4lxMqIvVGqN1oExhDSisk6LbOV5EnJ+
         QfAQW1QAOSlD7xwP0SWnsvdHUWMT6S4lMS7mL3DDLROQLIHyRCZYD9m5eW8jCy5wjrs+
         RLZpDOBLsiBZjvLDWcr5mYzVqtq4SoZc9vgtUKrw8mvS2lTi25naOx7/zJAWIqWYqjfR
         SSpA==
X-Forwarded-Encrypted: i=1; AFNElJ9uVDisyVyN+7HHSWc0qQzcD8a7ClP5s8JOhXMUyr/koTzpPd6n9acmrvElyOThNdi7Mb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhaI+JXE9cTfF+AGe36T1XdIgOcEm1S8Lfq2HX8KDg0x3gRYlk
	QDvArZSKG98npX4IMTZz4S8vWgz77lp/CO2OAHk/cPpyulfeVtH+xhes
X-Gm-Gg: AeBDietKpDivT/HmtYrxoJZ/yBOJqGYuxG/CRR6mIw4sTaC7QHyLNqEZug2MaAwHMSa
	pfYugEJaLdD8/8eHMCAmN33NCunqBT6VN+aqT87XWCPYHatszW/2vks7nnCAXpgcnO5yshsTydX
	cLlkur1ujvGGxwIPTN++BOM2UG9hCsj/UvcdrUguceE8hARucVAyzF8sG2B3z+Qs42gNnU5ZPLV
	LNxQejo+cttk6F+9QhLJGOnV/Ch7GPp0h8XmIEGkmHsKs5bxAEp8MJ2jpWeEgBirZFnwRUuGy/z
	a4qUhnb0nloeL9ZN9UD210gv0mld2fC9eMmrpwgVAkdK0/Z9n8PqmSMgpYOSSGxsvJc6PiTdlo1
	VRmC3CPlW/uzctyEHo6ruWaRV45sAFwQh1oDJIPcfY0giATzC+pBX4mgowzwB200PV4dhs7a0Xh
	cNG1PumNGaP2YqnSLm4OJ4vjP3UAjUsYqqdDPUX/y32MCtMEATi0RhS72c25II9ArRliolZ7V7g
	48HK/mDD8W57Q==
X-Received: by 2002:a05:600c:8b27:b0:488:b1c7:b432 with SMTP id 5b1f17b1804b1-488d6881e82mr216399795e9.24.1776159353551;
        Tue, 14 Apr 2026 02:35:53 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d689110asm122219045e9.35.2026.04.14.02.35.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 02:35:52 -0700 (PDT)
Message-ID: <53f43b85-b274-4352-938b-d40f942bfb2d@gmail.com>
Date: Tue, 14 Apr 2026 10:35:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/8] environment: move "trust_ctime" into `struct
 repo_config_values`
To: Karthik Nayak <karthik.188@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, christian.couder@gmail.com,
 usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com
References: <20260324123750.157143-1-belkid98@gmail.com>
 <20260324123750.157143-2-belkid98@gmail.com>
 <CAOLa=ZTD+qqgyB4Pn4bcOfP+Ks8Zch+AWZkzhrRRbk-eJvS-mg@mail.gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAOLa=ZTD+qqgyB4Pn4bcOfP+Ks8Zch+AWZkzhrRRbk-eJvS-mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/04/2026 09:52, Karthik Nayak wrote:
> Olamide Caleb Bello <belkid98@gmail.com> writes:
> 
>> The `core.trustctime` configuration is currently stored in the global
>> variable `trust_ctime`, which makes it shared across repository
>> instances in a single process.
>>
>> Store it instead in `repo_config_values`, so the value is tied to the
>> repository from which it was read. This preserves existing behavior
>> while avoiding cross-repository state leakage and continues the effort
>> to reduce reliance on global configuration state.
>>
>> Update all references to use repo_config_values().
>>
> 
> Nit: I was hoping you'd also shed light on why this can go into
> `repo_config_values()`. Does it need to be eagerly parsed? If so, why?

If trust_ctime was lazily parsed where it is used we'd end up dying in 
match_stat_data() which would be quite unexpected, make it very hard to 
reason about the code, and hamper the libification efforts. I'd much 
rather we put the onus on patch authors to justify any conversion from 
eager parsing to lazy parsing rather than forcing them to justify 
continuing to parse settings eagerly.

Thanks

Phillip

>> Mentored-by: Christian Couder <christian.couder@gmail.com>
>> Mentored-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
>> Signed-off-by: Olamide Caleb Bello <belkid98@gmail.com>
>> ---
>>   environment.c | 4 ++--
>>   environment.h | 2 +-
>>   statinfo.c    | 6 ++++--
>>   3 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/environment.c b/environment.c
>> index fc3ed8bb1c..0a9067729e 100644
>> --- a/environment.c
>> +++ b/environment.c
>> @@ -42,7 +42,6 @@ static int pack_compression_seen;
>>   static int zlib_compression_seen;
>>
>>   int trust_executable_bit = 1;
>> -int trust_ctime = 1;
>>   int check_stat = 1;
>>   int has_symlinks = 1;
>>   int minimum_abbrev = 4, default_abbrev = -1;
>> @@ -309,7 +308,7 @@ int git_default_core_config(const char *var, const char *value,
>>   		return 0;
>>   	}
>>   	if (!strcmp(var, "core.trustctime")) {
>> -		trust_ctime = git_config_bool(var, value);
>> +		cfg->trust_ctime = git_config_bool(var, value);
>>   		return 0;
>>   	}
>>   	if (!strcmp(var, "core.checkstat")) {
>> @@ -721,4 +720,5 @@ void repo_config_values_init(struct repo_config_values *cfg)
>>   	cfg->attributes_file = NULL;
>>   	cfg->apply_sparse_checkout = 0;
>>   	cfg->branch_track = BRANCH_TRACK_REMOTE;
>> +	cfg->trust_ctime = 1;
>>   }
>> diff --git a/environment.h b/environment.h
>> index 123a71cdc8..64d537686e 100644
>> --- a/environment.h
>> +++ b/environment.h
>> @@ -91,6 +91,7 @@ struct repo_config_values {
>>   	/* section "core" config values */
>>   	char *attributes_file;
>>   	int apply_sparse_checkout;
>> +	int trust_ctime;
>>
> 
> Since we parse it as a bool, perhaps we can make the variable to be of
> type bool?
> 
> [snip]

