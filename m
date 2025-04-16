Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3706CC8FE
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744817456; cv=none; b=CGi4ldvb2FsU1db6c14FqOp8xaSpBClQWXKnuUmaD7zzHWdeHQy6q9hlIjRr9YlAzypRRaAXg9rAFFP+051EcDWpmxK8WKWD8s23z9zExlFO/7/f/2EqzSf6904P/tVBg3hM+/4ZADln0F6nD5C+4WQ7OwQqJBvuJRbQaPH6Eac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744817456; c=relaxed/simple;
	bh=VbotuLxvPLMhsZ74HaVhP9NPl+2g0ogIZ8465mPetns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP0suf3Eu1jpDQQrS+UJCWlsWP7n3pxz2bRqyQuehan0v+KksoYintvDf0Xz4rMQx1JcLY+o9diERVGQfmMCzFCf88jQqKN+WI2AdVzdol9BtySAdZZ3W4q0EWzNqsN7qAILteCfcTYc73cw+wzMdYQ7AnHcxXsFBrG/RyjIWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4MFvEzs; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4MFvEzs"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7040ac93c29so71592437b3.3
        for <git@vger.kernel.org>; Wed, 16 Apr 2025 08:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744817453; x=1745422253; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1DgY1u7m5cHuRTRIJQF3rP8IowcGxcJ0xIt9RKMN6U=;
        b=k4MFvEzsNqKUhWhqZHzRcXTcK3bVcPYlcfULA6C9IWa6I82DWIlRuYH8+Lc1CBRg3f
         eQ39gSC6B7Gcd0QdKZkE9QazsUpX0SeLmfRbyHMZR7g/pgW3Rcy6YakNU5Q3LAkmoh2X
         ZkjYD9EAtquLte37MpI3EXVAX9qbPNNcgNdg4O1rzyofRBl+TjV60/Gkkfby1OgD/3X7
         vetc6w3skE524g1PsNb3tpafm0UvqHGkLonX0ZpQykme/bF+3epwRwaW18n8UmCg5/HN
         Yc19rdUarcJ5dMeEDvDYus9jqAflxJyHgMvKfokuZvIovmA6GITrOCK2PoJvRmFnfLu2
         6dEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744817453; x=1745422253;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h1DgY1u7m5cHuRTRIJQF3rP8IowcGxcJ0xIt9RKMN6U=;
        b=pzF4/ykoq+0FtXgGpmu8VaO9bNBS7HeZ0XGyAT2bLl9lbDjUVU6TeUGz+z2OEB5b8w
         7QDgytWf9q0WQyi2u4TNW53aNccODsdrr4CphFRUUaWHHfccG5m6rx01vYdRz7Y4R8M/
         66phWMVOpxBNfLxh7/FqObPJmwN5mXFWM53k3l79vfNXtsTggZdnLH+UuT/vxdoID6ON
         H4EosbMeG/ws2Ua0jE9nDKF1NX1dfy2nmdK+dwwNe3/kHV4OLgixsfXiofIBEtHsjjwr
         w0W+S39KTk+udMVvJTTeItrKorH64uYf1s20VKIEHwFaH4xSQjDX5e54EEfd8pdB60j8
         RXYw==
X-Forwarded-Encrypted: i=1; AJvYcCX2ry8c+Boq4BO9kVoiSkpc7/i5bbyd+GuVs+3e54u2d+GjHhOYdV0nMqDf0fa62VOLPrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7WiGPJRWF4Jd5+R6NNGTNO2ep+vFrqsC9TO86FZdNwb3VMXkc
	twoFyK0gt2tKaIyfmV/mn2/t0haGyD90/HFoPckYUAHHNGywNMtz
X-Gm-Gg: ASbGncs4A1EIgeuDaWKOu+tQJ9/KQm/6R5W0LDC9rPLV8FLarket2XQtGjB6hOheR3Z
	xUcZo6B4/0bMWng2UaWsm1n38rZZ9+eqlBsLGVDh5J99VWVAiEutdEbp7Dof5fSSTws5qKLcQ7c
	JsFgq4aYYyH+uTfFBeukfSw5hGyDq2aaxiECx0fPFEwzuRdT2sVPuAzg6bY/sJmK3l3TPw51Jyk
	3mbXpWK9P6jbNWslX3WhXOlTAAS9xsyt6X0eaVsqSQ4X2rgrSSao4MOnn9xVa+G/w1T206zSFUz
	MOm6FPf5WP4r0qk8TimgtZecgIZap0oxyBg1p1LW2zloiL25SDaE/HqpWz6jqkQwkoHUYn4PPwe
	tmzJRNwIwXbVrU6A9
X-Google-Smtp-Source: AGHT+IHf7gKv0u2pFGPPYqfc8XaviIwUF0PHd6+4FfDCs7dp6iO4Y6NXCSbPTNc2yCzSr1QAD/nWhg==
X-Received: by 2002:a05:690c:6184:b0:6ff:1fac:c502 with SMTP id 00721157ae682-706b325e86cmr33047727b3.6.1744817452982;
        Wed, 16 Apr 2025 08:30:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:d4aa:a26e:52c5:371a? ([2600:1700:60ba:9810:d4aa:a26e:52c5:371a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-706abaa589esm5143107b3.95.2025.04.16.08.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 08:30:52 -0700 (PDT)
Message-ID: <baa62f25-faa4-418f-8100-0a75cb803267@gmail.com>
Date: Wed, 16 Apr 2025 11:30:51 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] git: add --no-hooks global option
To: Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
Cc: phillip.wood@dunelm.org.uk,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, james@jamesliu.io,
 "brian m. carlson" <sandals@crustytoothpaste.net>
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
 <2c7994bc-2be0-43a5-9627-0d530746b3ab@gmail.com>
 <cb3d080b-51a3-4096-9650-34ec4ed68f1d@gmail.com>
 <a5632198-9e04-4302-a3c9-1cbf0f0cad65@gmail.com> <xmqqh62oi3k7.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh62oi3k7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/16/2025 10:28 AM, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>>> I don't read a strong reason in your message that this is a _bad_
>>> idea either. As in, there's nothing that hints that this will cause
>>> significant harm to users other than providing a new footgun (and we
>>> have plenty of those for folks willing to look, including the
>>> _existence_ of hooks).
>>
>> It is certainly not a terrible idea given that it is possible to
>> disable hooks already but I'm not clear what the motivation is. I
>> don't find the example of a skipping a pre-commit hook persuasive as
>> we already provide a convenient way for users to skip that
>> hook. Elsewhere in this thread you mention the "pre-command" and
>> "post-command" hooks but they are not part of git - if a fork is
>> running its own hooks and that is causing problems for users I'm not
>> sure we want to change the upstream project to address that. If there
>> was a clearer motivation it would be easier to understand the benefits
>> of this change.
> 
> Thanks for pushing back.  The default for any new changes is not to
> apply unless there is a compelling reason why it is a good idea,
> saying that this is not a bad thing does not serve as an effective
> justification.
> 
> If we want to give scripters a more stable foundation to build on,
> the answer should not be to pile more and more "no hooks, no
> configurations, just a vanilla mode of operation" options to
> end-user facing porcelain commands, but to clean up the internal
> implementation of such porcelain commands to refactor into stable
> plumbing commands that scripters can rely on.

Thank you for a decisive answer. I'll move forward with a v2 that
is a doc-only change, documenting the /dev/null value as a supported
mechanism for disabling hooks.

Thanks,
-Stolee

