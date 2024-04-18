Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8562E161935
	for <git@vger.kernel.org>; Thu, 18 Apr 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453098; cv=none; b=NAguJRjt3RXRzuk6o8xn0Gdt94E2QPXh5SktRS16iwp5HWN4RoZ1WimrZoctl9hQJ87F8Cjr5zp5gWNvUYZv+D2eqK/Zb3PUUfyCOIwsMuhoSrS9quFHnJqlY5qgOi4CfxGVwn7jQZW2UvnFNvEtuwvSeAL7D7SC1rLKZ3R015w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453098; c=relaxed/simple;
	bh=nre3naf6hHFNwV4Vmmu5+MVzjXfAAFdDAwBRggVUxvQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=qhdnY3pSvv6Cvj/mpBRQt7U/hD3iHVKkiBqbYnJUsLDnzNSnHMeD6DqYQFaN9/TEB3Gzt/S297jpvabPh9t6hO1Q6uhYLEl0HIVYAT212svzwV6g1dySUyM+cnSYVHc/g1g7zXNZx5EuQHjyMg/C3XxU1Ml/XSygXvnvpizenOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSkz7Y5T; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSkz7Y5T"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-418a02562b3so7911965e9.3
        for <git@vger.kernel.org>; Thu, 18 Apr 2024 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713453095; x=1714057895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/3jmbp2nUuiN07y6XZkNM07jj8q57x2im521FOcOBRw=;
        b=hSkz7Y5TEA01nfF/gTs+wwzBHmezHuTO6UEaeIm9OVecpZDn0tb7MXPo8ZYi5NYJq+
         T3cIJRyoFJ0rRubKEh9XEWqfDvisPe+W7LuBc0SfVBt/lSw8HJq8lrtyW+juz0nMKqzK
         5S1ZlHIKbdyo0G6tS0L4U1nvNvb7Cs+Kw0GweaJBqQ0QCKpuEtQB5eGJ+p+dbLCrqEtR
         7YabPKWiMqgH2tX2NtusOu9RiFnYR/l0xnuCFOPlwSpu1kagf5O0I1kgZfhRNFTSBAQQ
         dRInQL1fuARiDHmPFmWiqg+6fFBfmc0EY4FY/Lg8nPg6+i10jRsRn3dqLp0+qyIFpmD6
         HkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713453095; x=1714057895;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/3jmbp2nUuiN07y6XZkNM07jj8q57x2im521FOcOBRw=;
        b=TXfMQXS/swVT0J1A1l+BJgcWLyVvGArSMWvDu+K2gzcfA/wc1AMe1OjEVbhlDBOcuK
         WCXOTr0UODegZqRkZpMz5PbyDTG+LamZ99ygUPkp4VgrwIIQemLxVHp7wG7PlehUw7X6
         7mFrYcRSjs8pAYl3yKfGEZZoOOsZ7mOI3bRlWXhlzAy/3HMyJP1RCS/8Zsf4IiLkX7CJ
         ZRb5iA+ZP82kQm1PqgQBFeCJTQPEFS/jayjbdbfdTYYLxN+QnDpkCwsuN/B0hEC62hq+
         +PFmGxFNRngkf3O4HGVCUrBj5lZZotk3ff59VjC7QPe0tSo+6P9P3N43sNhwMsN66mm5
         gCBA==
X-Forwarded-Encrypted: i=1; AJvYcCWBFxG+i8qwQ+S0ItKPZurSQUWNHUHH3HiFuBwnTsnxGExk6ytA7saXsbbWr1QupVE4oJbiYpbsyDoYbzRKvs2tZ9Ru
X-Gm-Message-State: AOJu0YwIhyAkCc6mNx0ThuU6LuZ2OU1ijmkbNpATr/ifa4Lxs4WsnfWR
	7lmsTwatgJIw8JsguPmnlAcTi4ONTBWJSpSHpIQCNHmveEJgK49I
X-Google-Smtp-Source: AGHT+IGBMKITbUwEU7KQQBW+VTsx7LW3NP1SkMcJTyUHtkQGg6ug2xXbckfSDYWJVDdYInZdLDltOA==
X-Received: by 2002:a05:600c:190f:b0:418:2729:35e5 with SMTP id j15-20020a05600c190f00b00418272935e5mr2153013wmq.34.1713453094409;
        Thu, 18 Apr 2024 08:11:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id i9-20020a05600c354900b00418ee62b507sm1767531wmq.35.2024.04.18.08.11.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 08:11:34 -0700 (PDT)
Message-ID: <52102ebc-ae57-4000-9990-7def910ba254@gmail.com>
Date: Thu, 18 Apr 2024 16:11:33 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add-patch: response to invalid option
To: Junio C Hamano <gitster@pobox.com>
Cc: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>,
 phillip.wood@dunelm.org.uk, Git List <git@vger.kernel.org>,
 Patrick Steinhardt <ps@pks.im>
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <15f9252c-212f-43eb-84f3-6046fb2fab38@gmail.com>
 <20685fa0-815f-4cdf-95e0-7206588552b5@gmail.com>
 <1d0e98cb-78a4-40d0-9bfe-390a3a30aad8@gmail.com> <xmqqh6g0av28.fsf@gitster.g>
Content-Language: en-US
In-Reply-To: <xmqqh6g0av28.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/04/2024 16:05, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
> 
>> I tend to associate "option" with a command-line argument, not
>> interactive input to a program.
> 
> "git add --help" is a bit mixed.  The choices offered by "git add
> -i" are called "subcommand" (see "INTERACTIVE MODE" section), but
> the choices you give to the prompt "patch" subcommand gives you are
> presented with "You can select one of the following options and type
> return".  So "option" is not too wrong, even though it is a word
> used in other contexts as well.  I am OK with "option", but if I
> were adding this new error message, I probably would have said
> "unknown command".

I think "unknown command" is a good suggestion, I take your point about 
"unknown key" not being so clear for users who do not use single-key input.

Best Wishes

Phillip

> In any case, whether you said option, command, or key , it is so
> obvious from the context that we could even say "error: 'W' not
> known, use '?' for help" without any noun there, so it would not
> matter too much which noun you pick.
> 
> I'd still avoid "key", though, because to those who do not do
> single-key input, myself included, it does not match their user
> experience, and it is even more so if they forgot or do not even
> know that they could choose to use single-key input.
> 
>> The test you are proposing only tests the last of these changes. We
>> should be aiming to write tests that (a) verify all of the changes
>> introduced by a commit (b) are likely to detect regressions to those
>> changes (c) are reasonably efficient, for example if it is possible to
>> test more than one key with a single "add -p" process we should do
>> so. As this is an interactive program I have a strong preference for
>> testing what the user sees printed to their screen, not just what
>> happens to come out on stderr.
> 
> I do agree with these three points, but I do not have a strong
> opinion on the new test that was added by the patch when judging
> with them used as a yardstick.
> 
> Thanks.
