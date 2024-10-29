Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75581205AC5
	for <git@vger.kernel.org>; Tue, 29 Oct 2024 11:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730202909; cv=none; b=NFN6oJsPuO3TsnjErG6U8JvK3WLD/LzpDhascrMVV8+KhdnL7M+WZD3kCoqeqKVnhrKJIxC6WBAJeoySnoCv3IzY9iVELpRxmpHe9ILigw10QjYclU+093kmV4D//20tAKFu6OQov7/Jz+s2+JibEOE03EqfFuc5wdrkzflRIPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730202909; c=relaxed/simple;
	bh=+0FfP/5X+an1hXLCOPnawq6YgYK2oSbQP7zSSO59HoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+1x0lla7uE/I+S58AxyeovD5mQ07adTa/HE/83B2HKJNPnyvj3XiRci8MqbFQLb2rT28mFHEicFD/RqbYQZSYWJNVWvGZtA5hNQ7JxohyejKzAeuLRLwiNHZx84XhYQoRm8I+2rphrPTasRMUorsQ56Kp3eX+ggsCRIZrHtzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtxndCEm; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtxndCEm"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-210e5369b7dso15377885ad.3
        for <git@vger.kernel.org>; Tue, 29 Oct 2024 04:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730202907; x=1730807707; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqIeyRRTrd3B+bwjIvLlP/VHjACfN2o90EYTIF3xvKM=;
        b=QtxndCEmF/P2BpUmkq8PxQLOztGpCkZB+n6J41VoM8CnoESqgi9GPwRmqA6EI4Xn+3
         Nb/9cixsyq74JVg3fuj+L4s4gjuKo39yRX3sS0lzfg0FLd5FBM/Qu/5mnEIxY5VS84Wm
         MwlXe1nDkRt5T4qtjXkhFUb+vp5uLe5lexPONfUDWB4iW6EFP0mZke745Dk6lPfSsCbk
         f9j6FsHX3AJjVIuZe96GNwfHCFWpSmhhg0KtF7kd8gXf+2C6CxIgZ3Q1bZvck8SmGyu+
         5lQzcW3Oi0Q5Cf4PjrAM3U5E+Nd+fS7/igEVxhu05otC8Ftt4MSuShpA7CzQ4KoBLIsn
         D+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730202907; x=1730807707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fqIeyRRTrd3B+bwjIvLlP/VHjACfN2o90EYTIF3xvKM=;
        b=VOaBRJBsc1DUtORQ0P2zWL0jhG04WWc3v9ILEex1aEAjntdcMOv4rUzN2Rqo8l0aWS
         vmS0HKXZiHbM3QIaJpPcXyERHp1DniHOwQbbi+ciIyWpUe8gYRYWHr+qjrnLW0qU++Le
         /GtC0tSjqF64RPwZDRBc6w+itYOD7th1aimwzO6hEfP0VQMHoslk9qOlLrJLwBG0c/SL
         y/MvCdsozZcXn3Z7ubVvhR1VMxRp2K44o61deHmog2v/AvG3VTx3KTUxjcyq/YSn3biQ
         cR4b+zgB4Fn25e63XLLecSsRX2io9oQrC3AQplPWPTBmLjlw4GKc/abRzxVPoDOdEDnz
         +ctg==
X-Forwarded-Encrypted: i=1; AJvYcCV7mq4P5GwS6e9ndcVizN5+BSN4GMy2fkhjX/rzXiL+RbtjYreqF8ztnAfeZslUnOh8vg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKCWnzHMzflF6JVorMuAyk+xmy1pjyTdFht+KBc4W2ezV83Ri5
	/XR114J8AvRi6Oi5eHP/cdhdL8Dp7Q7SB9LrMe6Rc1bDvldm0uZT
X-Google-Smtp-Source: AGHT+IEOSZ1fViEMPo5i1NFXpIBe7LCEddIygWe8hktiPMhrzfDJOTU5NRt4/9UdIu5YKlmxUmYTHw==
X-Received: by 2002:a17:903:1c5:b0:20b:8e18:a396 with SMTP id d9443c01a7336-210c68abfe8mr118329685ad.9.1730202906689;
        Tue, 29 Oct 2024 04:55:06 -0700 (PDT)
Received: from ?IPV6:2409:40c2:805f:eb9e:840e:5586:842:93e5? ([2409:40c2:805f:eb9e:840e:5586:842:93e5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4418esm65061175ad.15.2024.10.29.04.55.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 04:55:06 -0700 (PDT)
Message-ID: <26d1bd3c-4f90-4406-8a1f-2eb085c46bab@gmail.com>
Date: Tue, 29 Oct 2024 17:24:59 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] show-index: fix uninitialized hash function
To: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>
Cc: gitster@pobox.com, git@vger.kernel.org, sandals@crustytoothpaste.net
References: <xmqqzfqi4oc6.fsf_-_@gitster.g>
 <20241026120950.72727-1-abhijeet.nkt@gmail.com> <Zx7WaEn6nvtjhs/B@nand.local>
 <Zx8ijtkn7y6eBQ-n@pks.im>
Content-Language: en-US
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
In-Reply-To: <Zx8ijtkn7y6eBQ-n@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/24 11:05, Patrick Steinhardt wrote:
> On Sun, Oct 27, 2024 at 08:10:16PM -0400, Taylor Blau wrote:
>> On Sat, Oct 26, 2024 at 05:39:50PM +0530, Abhijeet Sonar wrote:
>>> diff --git a/builtin/show-index.c b/builtin/show-index.c
>>> index f164c01bbe..978ae70470 100644
>>> --- a/builtin/show-index.c
>>> +++ b/builtin/show-index.c
>>> @@ -38,6 +38,9 @@ int cmd_show_index(int argc,
>>>  		repo_set_hash_algo(the_repository, hash_algo);
>>>  	}
>>>
>>> +	if (!the_hash_algo)
>>> +		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
> 
> Let's add a todo-comment here. The behaviour with this patch is somewhat
> broken as you cannot inspect indices that use any other object hash than
> SHA256 outside of a repository. This is fine from my point of view and
> nothing that you have to fix here, as you simply fix up the broken
> behaviour. But in the future, we should either:

I will add those comments, thanks.

> 
>   - Add logic to detect the format of the passed-in index and set that
>     up as the hash algorithm

I am very interested in hacking around and trying to implement this.
I read about the index format here:
https://git-scm.com/docs/index-format and (assuming I am looking at the
right thing) it does not seem like index files contain information about
the hash algorithm used in their headers or anywhere else. Are there
other leads I should follow?

> 
>   - If that is impossible, add a command line option to pick the hash
>     algo.
>
Actually there is already an option (--object-format) that allows
changing the hash algo used, it's just that default format is SHA1 when
one is not specified. (or at least will be, after this patch)

>>>  	hashsz = the_hash_algo->rawsz;
>>>
>>>  	if (fread(top_index, 2 * 4, 1, stdin) != 1)
>>> diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
>>> index 3b9dae331a..51fed26cc4 100755
>>> --- a/t/t5300-pack-object.sh
>>> +++ b/t/t5300-pack-object.sh
>>> @@ -523,6 +523,10 @@ test_expect_success 'index-pack --strict <pack> works in non-repo' '
>>>  	test_path_is_file foo.idx
>>>  '
>>>
>>> +test_expect_success SHA1 'show-index works OK outside a repository' '
>>> +	nongit git show-index <foo.idx
>>> +'
> 
> So how does this behave with SHA256? Does it raise an error? Does it
> segfault?
> 
> I think it's okay to fail with SHA256 for now, but I'd like the
> failure behaviour to be cleanish. So I'd prefer to not skip the test
> completely, but adapt our expectations based on the hash algo. Or have
> two separate tests, one for each hash, that explicitly init the repo
> with `git init --ref-format=$hash`, and then exercise the behaviour for
> each of the>

Running show-index outside of a repository with a SHA256 based index
file gives:

$ git show-index <foo.idx
fatal: inconsistent 64b offset index

At the very least, it does not crash.

>>>  test_expect_success !PTHREADS,!FAIL_PREREQS \
>>>  	'index-pack --threads=N or pack.threads=N warns when no pthreads' '
>>>  	test_must_fail git index-pack --threads=2 2>err &&
>>> --
>>> 2.47.0.107.g34b6ce9b30
>>
>> These all look reasonable and as-expected to me. Patrick (CC'd) has been
>> reviewing similar changes elsewhere, so I'd like him to chime in as well
>> on whether or not this looks good to go.
> 
> Ah, thanks. I've missed this topic somehow.
> 
> Patrick

Thanks
