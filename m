Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A0211713
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761680803; cv=none; b=PsCgMVy3Bn+s5/yQO0xQVsk4wFVtsdKGVKM/d4K55OSZlDOlm5M+w1cSfzv+8ct79xKb/FzceOHv7B9E2YIPg2b2i2ymfZbwyzR+ZqaxlVJIWVJa+RYeP1aw/41UTQ1lW2iFPeRtfGgOeBwFppVcrjX83l4104z1nc3xszeZp70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761680803; c=relaxed/simple;
	bh=3W+Fetb/Y4i+/7+8lpKvh/gdFsnY/hx6jCaMnkq/uxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QP6bJqZ5j3gURebSCsGry1pZf2ZRqrRt9fAYT/SISYygjReXnYHN+aWT52vMT3en7pj9blAE1jNVilQIb4xIMXadEk7RB5ICPZv6+L8HWalClWjlQH1BGp2w4DL2HbDYi5mY8ME8k+zNqxwBYLodu1vZMCLSzBEgTsifOQBYAdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGusXfDe; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGusXfDe"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-33be037cf73so6671187a91.2
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761680801; x=1762285601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfxKEkiC2NQTDrHJbgygWRCIhAF3NejTvsYe9LrzlIM=;
        b=iGusXfDe5naQnMazDVoNP5YergbVqoqAfzZMLSDC4C03d5nz2sh3AZncSDklIQjE5c
         vaROGNA4jUGkvUmxMirv+9zBa9DAYH0pHa8HtMmerpjrThMHFHdvvHCnsZvBk9VknGmr
         CeQlEibgasfT4bdr+MgTPqrZbvTdidYCpDQpZ51uSU2s/4rkY2kC8MD7E0SgVI2xFSTK
         47xwEXZjxEXM1vqsSyRsQTjCDMllZmopToQEFP5r6F0YMMMFFhgUCSctKT/UxAjXUHpn
         WQNKtDoXSO6tZWhwtHST8WXijqk+yqAYKNgVAD7s5etGkfEaUoxRqxDGUPGUqJN2rxOf
         JiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761680801; x=1762285601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LfxKEkiC2NQTDrHJbgygWRCIhAF3NejTvsYe9LrzlIM=;
        b=JpQoQMQOjepoFc9nLyaSARZUPCwVKbeUJCUtjmXJZARhRJ2fK1BuVoAQNy5JU+ChLa
         EPC1G8hC6NBPEUy80kj9OC4zvUF4R80skLs3C0dIaEd/+5N92E6wIhH8WkwoMft9QgKb
         s4jO157zjRgJiuXxGbxSNzLTgNtXFc/fTcTeUTEjr5/kIETxpN6R+MJG+Xocs4MUlXr+
         oFjji46vrX88YKK8hwlCwNVE2UFq/+c4fQz1/XyNoAeuElr3Vo/eJ7k75mxU//X/3co/
         GIjwkEVmeap5uSKlvl2jYLBA3laWlwQzGP2oPxAaCil4XP69ayW3zHN/pu6bto+NWut8
         FUEA==
X-Forwarded-Encrypted: i=1; AJvYcCVxfbOcWt3zlKMrOIUiyZ1GUTsFLP9z3Yf2jGhNB5yM9ByMEJFz9K5cUVgSk8svdnVcqNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ24aBJClK6c38bqe5PQH62qbLJ7K46l+o8uEOaMyYLltVTLeM
	wz/ydz8KSMXlg8nDc9MY1x9wV5WCh4NzRchlYsulJiHOh6WVmB4/eDNB
X-Gm-Gg: ASbGncvNfYeAeXQy1B3ZUciHUVsFWz2ZI0EzyQwBZeCF0LDGxUEnZkDrcXMBQyrtngE
	gT1hx/Ye0+Ki0OygjphakcIorSAj9ASHwSW/vk/yenJcX1Xi6tvxiBR9xruqfcRdYWOa7y7zOhf
	4hss79gig8LB/yzCoBL/HNyyW+gHi9cgZSBLrLP/FpImedZb5u620UWi9+noxcoKpDcZWnPAOVx
	0NM1ZzaJYNrfxSTDk7faUEoA6cZM1LGz1T6qtIft8IXDKVzrIOKHOg390By8x90SGBJs2yGfQoY
	cUOseWWFvZj3rlb7QChOxRh5sk/R/vHAPK9YJvBOOvbQMI3jD/mG488pDR3A+D3fIEQi75M0IAN
	BXjmtvNr8UEju0gCCwUTJObdF7LbQi+utCcV06AwZ4432e03/riIRXCyID526KhBnRtYl2TaMUe
	syeIHJjg6Pza5ckYux6FkqDvJAuhV9b3YFv3q8CGiG9dfc6QJ/ZrnpuS4EbKbZct6WNqbZND6qH
	RvWtKy83Y9fmwz6gx3S9oaCkDgXXN98fnx0afjI9UmI7FLrRMSSc8dv3/ipSH8=
X-Google-Smtp-Source: AGHT+IHNBz2nFtvxJwkYgjrrgimIwBgEvyNjZFpxoqdWU9Ki5ZKqgto8jWY1MrY6Y1cYwiptG4Lf5g==
X-Received: by 2002:a17:90b:3942:b0:339:cece:a99 with SMTP id 98e67ed59e1d1-3403a265016mr264388a91.13.1761680801031;
        Tue, 28 Oct 2025 12:46:41 -0700 (PDT)
Received: from ?IPV6:2409:40e3:177:42ef:798a:642a:892e:b13? ([2409:40e3:177:42ef:798a:642a:892e:b13])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e9571sm12996837a91.9.2025.10.28.12.46.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 12:46:40 -0700 (PDT)
Message-ID: <359f1d65-b5b9-451a-95cc-c62343798c60@gmail.com>
Date: Wed, 29 Oct 2025 01:16:34 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] replay: add replay.refAction config option
Content-Language: en-GB
To: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, phillip.wood@dunelm.org.uk, newren@gmail.com,
 gitster@pobox.com, ps@pks.im, karthik.188@gmail.com, code@khaugsbakk.name,
 rybak.a.v@gmail.com, jltobler@gmail.com, toon@iotcl.com,
 johncai86@gmail.com, johannes.schindelin@gmx.de
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-1-siddharthasthana31@gmail.com>
 <20251022185045.29256-4-siddharthasthana31@gmail.com>
 <a4cd31ad-7086-4d05-ba00-db65ec24b45a@gmail.com>
From: Siddharth Asthana <siddharthasthana31@gmail.com>
In-Reply-To: <a4cd31ad-7086-4d05-ba00-db65ec24b45a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 24/10/25 18:58, Phillip Wood wrote:
> On 22/10/2025 19:50, Siddharth Asthana wrote:
>
> This is looking pretty nice now, I've left some on he tests comments 
> below


Thanks for the test improvements!


>
>> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
>> index 54c86b87d8..307beb667e 100755
>> --- a/t/t3650-replay-basics.sh
>> +++ b/t/t3650-replay-basics.sh
>> @@ -217,4 +217,46 @@ test_expect_success 
>> 'merge.directoryRenames=false' '
>>           --onto rename-onto rename-onto..rename-from
>>   '
>>   +test_expect_success 'replay.refAction config option' '
>> +    # Store original state
>> +    START=$(git rev-parse topic2) &&
>
> Isn't there a tag we can use here from the initial setup?


Good point - I'll use `topic1` instead of `$(git rev-parse topic2)` for
consistency with the existing test patterns.


>
>> +    test_when_finished "git branch -f topic2 $START && git config 
>> --unset replay.refAction" &&
>> +
>> +    # Set config to print
>> +    git config replay.refAction print &&
> I think it would be better to use test_config here rather than having 
> to clear the config manually with test_when_finished() above.


Absolutely, `test_config` is much cleaner and handles the cleanup 
automatically.
I will refactor all the config tests to use this pattern.


>
>> +    git replay --onto main topic1..topic2 >output &&
>> +    test_line_count = 1 output &&
>> +    grep "^update refs/heads/topic2 " output &&
>
> Rather than test_line_count and grep it would be better to use 
> test_cmp here.


Will switch to `test_cmp` where appropriate, and definitely change 
`grep` to
`test_grep` for better error reporting.

Thanks,
Siddharth


>
> The same comments apply to the rest of the tests
>
> Thanks
>
> Phillip
>
>> +
>> +    # Reset and test update mode
>> +    git branch -f topic2 $START &&
>> +    git config replay.refAction update &&
>> +    git replay --onto main topic1..topic2 >output &&
>> +    test_must_be_empty output &&
>> +
>> +    # Verify ref was updated
>> +    git log --format=%s topic2 >actual &&
>> +    test_write_lines E D M L B A >expect &&
>> +    test_cmp expect actual
>> +'
>> +
>> +test_expect_success 'command-line --ref-action overrides config' '
>> +    # Store original state
>> +    START=$(git rev-parse topic2) &&
>> +    test_when_finished "git branch -f topic2 $START && git config 
>> --unset replay.refAction" &&
>> +
>> +    # Set config to update but use --ref-action=print
>> +    git config replay.refAction update &&
>> +    git replay --ref-action=print --onto main topic1..topic2 >output &&
>> +    test_line_count = 1 output &&
>> +    grep "^update refs/heads/topic2 " output
>> +'
>> +
>> +test_expect_success 'invalid replay.refAction value' '
>> +    test_when_finished "git config --unset replay.refAction" &&
>> +    git config replay.refAction invalid &&
>> +    test_must_fail git replay --onto main topic1..topic2 2>error &&
>> +    grep "invalid value for replay.refAction" error
>> +'
>> +
>>   test_done
>
>
