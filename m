Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B9328FFFB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760504244; cv=none; b=eLE9ZeqtWxUjQfQCgOnPeRjY6nwf6DzHtG3OLUugEEgtL6wtNykWipeoSkCqACwFYXhZpX21Mn1czVW9uzamGUw4niHRRQ8xBecM+nLnm3kTf+KuOw5/A5aOonzG6e3yQMwDdL+pPK+xeL2NlQLlwad66ppBpigWn5thGSsbFKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760504244; c=relaxed/simple;
	bh=fjQjd1t6NcsDS/Ks2Jg2jFQRRRLno4/d3VITPj4taLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHgUFK2R23yJQEAEfcQyeTRDKYPJE5ZECr1Xp65oJl9BqC35i39fxkvEykg6fGjzmbzE3ymdsEi+FDiPodUGkuyzfjdfllr1lbYp1/SbNPHGwGtykvw5lTWbcs18fX2eabwEuWQBCPBCmOYzyjtEhEzVOF5cb+Zp6L5wMqXB+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DLboEk0K; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DLboEk0K"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7811fa91774so5287556b3a.0
        for <git@vger.kernel.org>; Tue, 14 Oct 2025 21:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760504242; x=1761109042; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5NTqHBFAJSFRb5k83Hjm/07A7Z1Hryuyyo/Igyt4mQg=;
        b=DLboEk0KiciqJ6mu2mixisgj9LAz8daj81Ydaf96BR3rpzzStEvv2qFOlww8S/zTVk
         D46Riz0cWmHMiYyqw3No2XN/NZIGn0nuPu6vQIJk9iwpvlCIpbY8LW9hmcJyNqqSshOZ
         AJ9H9HPXWjglVdFTPRPCveMrueM9IpobCD2lBGRT9DkRpM5xEfYsNHvr9hE2w91DLYUJ
         f2hAP2o/7UebnyPLo5Olz+glx+AQbI9ia0f41KTO/FuNPJ7JwmSTLOcHitndQ2/mK9d+
         ubmT5nYRh2sO+iAI5BJBsUMdsy7jB3FJ76kjRooxPVeCn/8yWuqaWzl59chPr62icBKD
         m0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760504242; x=1761109042;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5NTqHBFAJSFRb5k83Hjm/07A7Z1Hryuyyo/Igyt4mQg=;
        b=C7HV6aEkNUBnD6xjYgFsBbRB9+dObzNtpDr9yaOinxqKGNBrHzBE7a0gzh3WS7SYug
         IzQDERR5r+84ds7Y6K0sutFa4BJtVLoNZ7Wziva4k6GnBHHOem/t/BNJYkDiYbkA/4gw
         8Mdh5NO7SV1MvELnfTOagnWvXxZMiK2IGEBMV8Lta4Orj55ZlkhFYf8penu3l/CPkU0P
         OnLDJfgU92pj5Ty1Mb+iXe5adrEVgwXoM6IfDM/IajjnsnvFb7qoQ9k76fpM0PgYTLIX
         8DbQz/72TEA+eFs8aqerixdS6A89bQFOcgpnR2JT/9Zpu/FiWywdAv392l2VBdTdYbFo
         0zLg==
X-Gm-Message-State: AOJu0YybHl5Kx0TJpRjr/2x9Xh6x08lfaZuuai4HDVEe6WepLU+7ITZS
	keUvmPOup+Ku0wd+6Ew9DvfWvkTipnXl4k2eG/xu/+I6c5gAMKAlk6WJ
X-Gm-Gg: ASbGncttc7YhU8XOLOOJA7DZ65AahTPg4I0Yp++wGtYqsmNNkVq5mR9rJV4syWQ/eV7
	AwBeTOEQFDO3URPTlzFz2/3NeTx0fGGf4muoBPy0fdoCFXaQZg9xX6SUbxNVPb7nMdQNQsgeTG/
	QmtAB+7w0J/X0Ixbs5fPYRNy32b8ImYI8MkwFQDp3WOfY4cvRrB+hlLgxS71AGqbKFYULTHH8+0
	82NbUS4OE2i4uyYqoEbwrd1PEl1/FyHgIK+RDH48CYwUW2t/Gk4jTTmZA1B4OiZm7DivFePjaXb
	4uYWxahNJsXxALqzykxbNGL+6ydeg/uq5b4D64bZfs0Vv57gfpuxExsdGmmNPg0BzjETeUdvSJI
	g2Aj1BSWC4S6ona2hPpDTWt8szkGr1JlqV75dqXeBPiq1WS3HcI6ED2xzEj9L1qZPxunK8Cm139
	jChr5AlU3sJhxmfMH5/VzP+Vc9FQh7wcXsLJMmQ9gjFAJLmFcktOemgPwn3dKS3iarWYBHpXYKd
	nvAMMUeG3MFbkTBjZZbfg1HljrHdDy/5g==
X-Google-Smtp-Source: AGHT+IHDt2sow45RXilUGK8OhaL2T05/budxCGaN+aiPRJDIS5Luw3ALrEQHKbI6S1njVY8TL3Qzcg==
X-Received: by 2002:a05:6a00:2e96:b0:781:d163:ce41 with SMTP id d2e1a72fcca58-79385ce7bfcmr30049720b3a.11.1760504241549;
        Tue, 14 Oct 2025 21:57:21 -0700 (PDT)
Received: from ?IPV6:2401:4900:4bc5:7e6f:8524:7259:99ff:16ed? ([2401:4900:4bc5:7e6f:8524:7259:99ff:16ed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d09671asm17070420b3a.47.2025.10.14.21.57.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 21:57:20 -0700 (PDT)
Message-ID: <a72a2d7e-06ec-4275-812a-cb1e20902c90@gmail.com>
Date: Wed, 15 Oct 2025 10:27:13 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] replay: make atomic ref updates the default
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20250926230838.35870-1-siddharthasthana31@gmail.com>
 <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <xmqq7bwy1tgy.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq7bwy1tgy.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 14/10/25 01:09, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> **Removed --allow-partial option**
>>
>> After discussion with Elijah and Junio, we couldn't identify a concrete
>> use case for partial failure tolerance. The traditional pipeline with
>> git-update-ref already provides partial update capabilities when needed
>> through its transaction commands. Removing this option simplifies the API
>> and avoids committing to behavior without clear real-world use cases.
> Ack.
>
>> **Changed to --update-refs=<mode> for extensibility**
>>
>> Phillip suggested that separate boolean flags (--output-commands,
>> --allow-partial) were limiting for future expansion. The --update-refs=<mode>
>> design allows future modes without option proliferation:
>>    - --update-refs=yes (default): atomic ref updates
>>    - --update-refs=print: pipeline output
>>    - Future modes can be added as additional values
>>
>> This API pattern prevents the need for multiple incompatible flags and
>> provides a cleaner interface for users.
> Ack.
>
>> **Added replay.defaultAction configuration option**
> If a configuration option is added, please consider and think hard
> if its relationship with the command lineoption can be made obvious.
> I do not think it is obvious to anybody that replay.defaultAction is
> somehow tied to "git replay --update-refs" at all.  Either the
> variable should be renamed to include words like "update" and/or
> "ref" to hint its link to the option, or the option should be
> renamed to use the word "action" to hint its link to the variable.


You are absolutely right - the disconnect between `replay.defaultAction` and
`--update-refs` makes the relationship unclear. I chose `defaultAction` 
thinking
it would be more extensible if we add other behaviors in the future, but 
that
came at the cost of discoverability.

Looking at how other Git commands handle this, I see a few patterns:
- `commit.cleanup` ↔ `--cleanup=<mode>`
- `push.default` ↔ (implicit push behavior)
- `log.decorate` ↔ `--decorate=<mode>`

Given your feedback in the other thread about `--ref-action` potentially 
being
clearer than `--update-refs`, would it make sense to align both?

Option 1: `replay.refAction` ↔ `--ref-action=(update|print)`
Option 2: `replay.updateRefs` ↔ `--update-refs=(yes|print)`

I am leaning toward Option 1 because:
- "ref-action" clearly conveys "what action to take on refs"
- The config name `replay.refAction` directly mirrors the option
- It's more obvious what the relationship is

What do you think? I am happy to go with either approach or a different 
naming
scheme if you have a preference.

Thanks,
Siddharth


>
>> The command-line --update-refs option overrides the config, allowing users
>> to set a preference while maintaining per-invocation control.
> That would follow the standard practice of configuration giving the
> default that can be overriden via the command line option per
> invocation, which would match end-user expectations.  Good.
>
> Thanks.
