Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919841917F1
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682762; cv=none; b=Wn+dyJGtap87L21F71VM8eavidpQZaQTTLCC3hmu+aJg4td1+lEwZfw4BQC0IJwYJZ8wq046oOT4q4Sa/L3HRtsRUk8WzSVJFDoWYNLdy5wDxqiMy0fLv4eUD2Ns8cmNqpBREIEOziXVnRWVghHZt8VCa1Blg2MEGWbS+qd05e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682762; c=relaxed/simple;
	bh=KNqZJd1U0lXlUgkFbfs0UrMHFjut5t5EzYeWCI57LyQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpqOu18LsR45jvnebvOqhLvE+dqb68/Pif7o2e/d53pMbPhLMFu/IT3keV8wls62uIipHLoE2XtJNFd55MoRgAsmwj1qPhbljHbRVahnn9beHaSnIqso052T0g49ZvAv0337/T6nBt0L4QH9yH0TnFFT1MjbQA1EecRVcN2vN+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lspoM2j3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lspoM2j3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2698d47e776so51477245ad.1
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 13:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682760; x=1762287560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zdBTs9qkKPgp0F5RARpou+0gWfm70YF4zdU+cpshv2o=;
        b=lspoM2j3NlXv9DYqCVabX57nSwyU/r7h9KBoNwhz25fEVr6sA6snS5y4X1og4bNYyD
         2iKBhiYzqR3gJx/ghDiNVb1hEuDRXrPaiVXII8Pg8HFhD2EborwGmHsSu9qeQzBJPlNQ
         Zr1haKWOohhSp5tOItzxSXrb7+AG3D++tOho93b1Uu9hs9/Mr5d18AVJ9/hPI16gMCJx
         Fqv9UdYwB4/mIeRj72o46vuU+Q459cKDFqQIM3w0ATOS9RYTD+BBFsE1Jzn0BdThBEkU
         Ybc2ICqy/uRY/4Ch/6sNTXE5FQB2s+0PHdm8XkqeThEODi5aV7UuJMj474IBxka2gkr9
         zjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682760; x=1762287560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdBTs9qkKPgp0F5RARpou+0gWfm70YF4zdU+cpshv2o=;
        b=hceuXcFKgzGpqCzKKd5wHxodXAVI1sPSmYMi6FteUHfEuJWHhRg05QPOcrzi1xtcve
         ziJhB0x8FUdbbV0H5BoW8Zsr9o36+iisE2GLPGLCJhgFhAaBAgbFjTt1e/mXXQoNG6S/
         XFQi6DDScOEptrIJnn07He7blMUdJUUSQxQN8ug8WxsXAKLV5P0ulPVd8pi0BxUmXl8J
         0lc3T5YUUnl3J55NfyPVsCr/RPT/7S0aIRYxv+dhR2hfRP96bDxM00zc3z4m6C3ad4XD
         2vjjYhUKiHYWuRdSj8UKRiahCC8J1mS2qXqUPxmFvDl8TzFXq6vrjVB2zf7vdTLDPM6X
         PBhw==
X-Gm-Message-State: AOJu0Yy89DioOsB4lVwvkKLGDUZxFhVWsKbTfBC8Rtvvfg8VXF3D7iTS
	I6ICHUgVrtUaE4xmC9n7O5QGSKFm49m9kfBeeSBfo7+/pm8vluMT3VobTUniC6ri
X-Gm-Gg: ASbGncunKcQCwv1lNvwVAakYaTBTOMzEUGf2aZksfY/BCmVkUAYGz7U0HBrRqBE5TSv
	3Sf0vKMLkjpTriElOOlc2TAlbn7MZVuzBgJ0CYSp2SfUylwWxOiOsaVSG+jOc5hUBPLKSJx3mn2
	1ecgLaZD39bUJY2NSfzSQtjaMOYDOWZjIq/T3lLlH55Qew7ysJGUgQRrvwXDpPLIbRCCjWxlMDS
	/VrQvygj+vViNCYj/Y8hikx3gl+3S3tAjTBMFWv0QVrJqa/mcIA8dmFBLlxN9w13aMtPsy4dkZh
	+qdEt9VQc/TRp1aUYUYXXEze8hlJvUE1ied/QyklinWim8q5wzZoYbNda2eoO6nviy4wICoaA++
	isYS3JEfoPGdG0HUi913koX6ICXJZdLciDdGS8E7+S4C3uuUU2Lx4G0NtCNRZqQHP5sVOdx2mJz
	sDTQRNkvWe3wiDfvC7PcMHU8AiXk05fco0Ptqh84eiaaIlHzWP/NZgfmsOvi6RKYF9RHfJpVeeM
	p7745+w7vWXD2E8iB0nXRy8JOA0JPqpzwEGEZ4IWbPPCLDZiOK7FXU/Cg==
X-Google-Smtp-Source: AGHT+IEY0rsdJE20JAv8GTNsa6VtxSQBrLRG8naDrGvZj1ESRcUDu7mPT00FQCtSCabpZ8Z9Bs8fig==
X-Received: by 2002:a17:902:ceca:b0:264:a34c:c6d with SMTP id d9443c01a7336-294def2e7aemr4689625ad.37.1761682759644;
        Tue, 28 Oct 2025 13:19:19 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:798a:642a:892e:b13? ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf423esm125049275ad.19.2025.10.28.13.19.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 13:19:19 -0700 (PDT)
Message-ID: <1a4740b8-eb63-4266-b627-d329451b7a4b@gmail.com>
Date: Wed, 29 Oct 2025 01:49:13 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] replay: make atomic ref updates the default
Content-Language: en-GB
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name, rybak.a.v@gmail.com,
 jltobler@gmail.com, toon@iotcl.com, johncai86@gmail.com,
 johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <xmqq7bwlv4jh.fsf@gitster.g>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <xmqq7bwlv4jh.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 24/10/25 00:17, Junio C Hamano wrote:
> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>
>> This is v4 of the git-replay atomic updates series.
>>
>> Based on feedback from v3, this version improves the naming and
>> implementation for clarity and type safety. Thanks to Junio, Christian,
>> Elijah, Phillip, Patrick, and Karthik for the detailed reviews.
>>
>> ## Changes in v4
>>
>> **Renamed --update-refs to --ref-action**
>>
>> Junio pointed out that "--update-refs=print" is semantically awkward.
>> Answering "print" to the question "update refs?" doesn't make sense.
>> The actual question is "what action should we take on the refs?"
>>
>> Changed to --ref-action=(update|print) where both values are verbs that
>> answer "what action?". This makes the interface clearer.
>>
>> **Aligned config name with command-line option**
>>
>> Changed replay.defaultAction to replay.refAction. The config variable
>> now mirrors the option name, making the relationship obvious.
>>
>> **Unified config and command-line values**
> I didn't see anything glaringly wrong in this round, even though I
> picked a couple of small nits in one patch, so we might want a
> hopefully small and final reroll before marking the topic for
> 'next'.


Thanks! I will address all the feedback from you, Christian, and Phillip 
in v5:

- Add trailing comma to enum definition
- Fix error message quoting with single quotes
- Revert the `const char * const` formatting change
- Follow standard Git config pattern (repo_config before parse_options)
- Extract proper helper functions for string-to-enum conversion
- Switch to `test_grep` and `test_config` in tests
- Fix documentation wording issues

Should have v5 ready soon with these fixes.

Thanks,
Siddharth


>
> Is everybody else happy with this iteration otherwise?
>
> Thanks.
