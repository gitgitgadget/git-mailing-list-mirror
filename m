Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4000233CA
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 14:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594624; cv=none; b=aRMBSCii++wheGSxN/8bmYWhHLsjHdbrx0mg4g0PY/vCKDS2KQC6bs6WkN8CXYwGE+msrLdHWzm4c6A8cfksHu5Jy4l0b7wfnvZg0W5Fn2F9X+sASU9gH+uJyPIcuZxYTmIXV/Yc1oPnyT8kedhGQXFPshfeBWOB1sSxSaBmeHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594624; c=relaxed/simple;
	bh=h21HOTnBQ2yedUoW7PYTorXb0ydLiDb53IoaY8jJses=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=M5QAoIUiP99aoz6baWRb87eFSEZV+V7GBQeYNCbnVWrXLwcZXF/IPzn+QAAH+89Ib1+nM58mE48tAsF/hG7ma7UJvLl6t/XLV75M2cXAaWGpDjviGzsTFfd0G86NlCgYU3ZDnYiN8mtyebkriWa51kyObh9FsO0vlRIrzDi1EkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XXHCOI6B; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXHCOI6B"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-436281c8a38so32040275e9.3
        for <git@vger.kernel.org>; Mon, 03 Feb 2025 06:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738594621; x=1739199421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4oX4OxMayrikiG8h4HhvCs5KBBDN9+JzmDbNaT9zfJk=;
        b=XXHCOI6BgAsmpZDU2DGP6SmXWFM7qVWjZw/5M+brgdFx5BIdsmoXEd4ooBZQdRpJyz
         6/VUpgI0y8X37/i16bmr7fpcS3Q+bNNh4R9+xbCqMuK+TO0WI81dwyXNLqm1OEBEDZQo
         2HUK2s8WxD1ctYCUf1pdH5DMoJX8FGdoPowjk4uUw9scka8Oraw64jmsAO4iC3zqSdTH
         Bc7uylk98q9K/X9kFLjWbqXhFnvFyxd7G+IsQCmaEe+H2upOpsPh30+3bMcYAiotmPiW
         0+SOFLuTlIJUJMlAOZoVFqXpgLhJzWx4CJml/5/U8ED2jS9fFAnvWhH/+c6WBEw2+QnE
         T9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738594621; x=1739199421;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4oX4OxMayrikiG8h4HhvCs5KBBDN9+JzmDbNaT9zfJk=;
        b=lja9I2IaRIARmSCdnMIeDsqeZc8jSQeMnOBuDzA0XBff9KlX630xzsiyi12mOFPGzq
         aoUHhDO3p321T1+41BGBv66jHy+yUhFF02f/KPIWxz7QKyksKqvUQrpvOeoYvR0CE88K
         vDKV3C/J1fDcl3jAW+BEMu4ibLXOF8xx1AsF3L7+Wd3KbfHaHVyF9E4tQZtT3gImGySE
         Ls2oCYCFbJphwGxLhfRws3e8qjo+sEaADvRdHDxmfd+ey9L1KnUTbP7/ZE4r9ifwOO+5
         DX8OPp7UT7O3APHhEzQkM3U8hno6OMVS50wzOdFSa+bomW/rWcBgkU/XjsHaabugy/eh
         UlxA==
X-Forwarded-Encrypted: i=1; AJvYcCXwpNee6egkPSJkggArYoddhOFtt8vCbqj3l0ACEzLbmaSdOMKlpbCb8gsfcp6JVF/7ulo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU4PEaUvpVIu+ttuNCxTuqWKAOZLk6RJOg/CX9dq4VuS7qJEpw
	tIXFge6Cn5unBWhXD2vocJKkDrrqLzqrm5TAmwyq3X/g3V0kp5eAVG9pYg==
X-Gm-Gg: ASbGnctx3F+RJseNT3W0rQi8Dev22tnPycivjVsW1Ht1JmjQSiqfWQQ2XbfE9nz9epG
	wC4zOIemFJAYr9hZCs9dFBxrtTu6O7dN7FGhCv1u505XDNv3BfnpNsWsmsChKIN4xJSk0v0JYph
	/gimACHmreGWzCyvnKm4R1dKWNs+RIYNSVICwu+tiCgqsgSeTKzsx4Y4PbJLdk/bIspu1FNaEBp
	lEIjerI+CLTIi+TymPFFfH52H50GFkv/rAIoHgW59WeyYd82T0jvfrGmmIEpyeRheQQ1Czym66E
	0dKmx9VQNfNU99WCdhn++G309KV3pGstNifCcK9IAJezQnJMSMRDIQYVAFJbsyJ0CSxrLA==
X-Google-Smtp-Source: AGHT+IHJU3QwevQWhZnG1Di8RqHsHu0QpKm3z7N/xFAQPpa8OjdhpiwKpnZ9NVi41PQehUmNEgctaw==
X-Received: by 2002:a05:600c:1c8d:b0:431:3bf9:3ebb with SMTP id 5b1f17b1804b1-438dc3fc478mr174953915e9.24.1738594621085;
        Mon, 03 Feb 2025 06:57:01 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438e244ef41sm160584385e9.32.2025.02.03.06.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2025 06:57:00 -0800 (PST)
Message-ID: <288fbcf3-f6c1-46e4-8124-f4e566abe8af@gmail.com>
Date: Mon, 3 Feb 2025 14:56:57 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/4] t/unit-tests: convert hashmap test to use clar
 test framework
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Seyi Kuforiji <kuforiji98@gmail.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>
References: <20250130091334.39922-1-kuforiji98@gmail.com>
 <20250131221420.38161-1-kuforiji98@gmail.com>
 <20250131221420.38161-2-kuforiji98@gmail.com>
 <6be977a0-4bf9-4568-9b28-cdc988a49b89@gmail.com> <Z6Bwr6hM54nu8nSS@pks.im>
Content-Language: en-US
In-Reply-To: <Z6Bwr6hM54nu8nSS@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 03/02/2025 07:30, Patrick Steinhardt wrote:
> On Sun, Feb 02, 2025 at 11:09:25AM +0000, phillip.wood123@gmail.com wrote:
>> On 31/01/2025 22:14, Seyi Kuforiji wrote:
> 
>> diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c
>> index d54e4553674..16f86c952f7 100644
>> --- a/t/unit-tests/clar/clar.c
>> +++ b/t/unit-tests/clar/clar.c
>> @@ -754,7 +754,12 @@ void clar__assert_equal(
>>                                   p_snprintf(buf, sizeof(buf), "'%s' != '%s' (at byte %d)",
>>                                           s1, s2, pos);
>>                           } else {
>> -                                p_snprintf(buf, sizeof(buf), "'%s' != '%s'", s1, s2);
>> +                                const char *q1 = s1 ? "'" : "";
>> +                                const char *q2 = s2 ? "'" : "";
>> +                                s1 = s1 ? s1 : "NULL";
>> +                                s2 = s2 ? s2 : "NULL";
>> +                                p_snprintf(buf, sizeof(buf), "%s%s%s != %s%s%s",
>> +                                           q1, s1, q1, q2, s2, q2);
>>                           }
>>                   }
>>           }
> 
> Would you mind creating an upstream pull request with these changes? I'm
> happy to review, and then we can update our embedded version of clar.

I've opened a PR at https://github.com/clar-test/clar/pull/114

>>>    	for (size_t i = 0; i < ARRAY_SIZE(query); i++) {
>>>    		entry = get_test_entry(map, query[i][0], ignore_case);
>>> -		if (check(entry != NULL))
>>> -			check_str(get_value(entry), query[i][1]);
>>> -		else
>>> -			test_msg("query key: %s", query[i][0]);
>>
>> It is a shame that we're removing all of the helpful debugging messages
>> from this test. It would be much nicer if we could keep them by using an
>> if statement and cl_failf() as we do in u-ctype.c
> 
> I honestly think that the debug messages don't add much and only add to
> the noise. You shouldn't ever see them, and if you do something is
> broken and you'll likely end up pulling out the debugger anyway. So I'm
> more in the camp of writing unit tests in a concise way rather than the
> needlessly-verbose style we previously had.

If I'm firing up the debugger I'd rather as much detail as I can about 
what went wrong so I can see where to set my breakpoints. Otherwise I 
need to waste time repeating the test to find out exactly what went 
wrong before I can make any progress. My experience with debugging our 
integration tests is that those tests that take care to print helpful 
diagnostic messages when they fail are a lot easier to debug than those 
that don't.

Best Wishes

Phillip

