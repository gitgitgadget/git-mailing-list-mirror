Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBD72D8DC8
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765360290; cv=none; b=EWsNpgOH9x+MRC4wZP26AjJnccaVkvlF4g8RE2G3wihwqGD3CwibPkG9P9f0MahrL+/LoUYbbTk33zRVLzklyBh0X2ulg5NVHV/0gEyTAXefk2/fVjEY9kLdMTL9WyFkbtNZOsS68lExyWMV94IxxGWfANhQsy13kDvJe7Kcb1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765360290; c=relaxed/simple;
	bh=kgBlsuJxerP6Gj1NHkLCWUBlFvQEPLG53NJyxo5xcS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pH7qrppBOU6YAjefKC/izsz2v2F31orf+umw514OdZmkH0GARUCkTuw5CZdclyNvaMeedRxVilOTN4Q1ux1RI1FzEsY2gcGhw0Al0ARskUZjQBV33YAU9irtkDvRn1/UdmIf8lxlwXzDq55imVagUX70CyxIebbLxwWkjeEdD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feRIJL5C; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feRIJL5C"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so55953575e9.0
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 01:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765360287; x=1765965087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g+VqZ6EtCXD0EATHUtKufatqmDXl9s4WQ+fMe3FF0zg=;
        b=feRIJL5C94oQXWXVHfA66dTjHiOgOPTHd0Ca9ubAmx9Ut5dc1QMWO2P3095EB/yNuI
         aoVZjQ5zdEORu1j0LShfzzqjUuzOIqD2pFyZKB4HMLgjtWrDaacoEiyPi7m6Lp2Tsmnx
         5mESw8unc1u/oyKfvZXz3m2IdwdhBpJbpOe761mIKnsuINIL+llmUbj83ZYl87p4GY+q
         gb5hfbdUAwYCCka+h4eQbFx9FVDfvowt+sjr5uhii1afgyMS/tdR0lfMGevkSS15NsSi
         yHp2kvqeJXoqaE6bxcMmEenBfAlOOWVT+pL8zotiLsFVpyHsRTrSAoZqTSBx6Je8C1L0
         /Y4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765360287; x=1765965087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+VqZ6EtCXD0EATHUtKufatqmDXl9s4WQ+fMe3FF0zg=;
        b=EljqKEliHhQ4vz1QzmiKhHWF3jUyoxv5CuswYNf7Z0gBRcQX/NKkMIn5s1d0VaresE
         FA42tswgeEcXU7A6IIyI7AWkIzbHbjWMMlSVfwTWKz/q2AzI3TPzAMSwA7jIWZvxI8K1
         ENjI5DMc98DJ1zVbyhoB1lJsBbjhuXRMlk9bQMrBeok2UbcTbxjZpTvD88izrUOHWn+f
         Sxb7LKgIxdsg0yyCay1km4gpEywv21pKojMc8ZcQiH9ICkSeGNnXMa8kyrdW7SGMKcHa
         UCuRX3XZVh4F2GaqaE00dPGo4TsRTxftPWAeC64qRX1f3E4J6Xf2EWYBx4l4kE0gjlJr
         AU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV0odKyFKn/6ES6+/dHPlPmJVu0Dzi5KzfN7lxeHwZCG17BumBEtwHPOaZZfp1kthKRqpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPEatQ27Y4fuabI4kgCttNMZJn468oiQHFFcZ74NeK9Zq52le1
	c80HuLsPkcrnI/QOX1+AuxlgB6Gy7QkkmERqB1hj9jz+8puGd6H7pIQeb2c8fQ==
X-Gm-Gg: ASbGnctfNORRntztqpjNT6BzInZAMd2JEerUIlqJVsUJLpRulF2wyZenQgIjsLJ1BeO
	db7WZLSXDZT+5XJvvDgZJxO5UrBLGcFk8zP4nsCnuHN6vRAkaigW77xNqAraqXZM3yPjZ4mXCUr
	f0ZpPvt1Hp1Unxpv0vc1AEdFuvF1n+lMo9tgYudFslQDWVZSJQPG5l8BxmV3zWlCmYqVrt/2XIR
	HZcY47dXtP6oL3Ol259E/oDfVWIDTaXc9rW+zsePhyrQv7H2psT7Or4qnVsSUNaZ9fo8x0uW9Dt
	XHefPVtNsP9Aic3qCSrB73L9U635hX1cWj2j44ZbUl0rkQqsUJIYuhAcvrW0ragTtFxP/0/qS+k
	3IIdDPSS5BgE0ANvHzXd4QOlwqCxYhbKtzVmOG09BwUrEl+cWIHbj7Mzn70U7ljNe0r71RIr1oH
	XkWyKEVLE+rznh5F/e3mZhUqaORzGl1oQG7K0vxIAkzDV4Zq69OLGuJN9lBDN9lqs=
X-Google-Smtp-Source: AGHT+IFWxZIrqUb0yCcBLvRYuYrolGMwrZjwMLBfq6I+Cb7qB14lzaGuWp5m07QAaJkDtqSF2cPxrg==
X-Received: by 2002:a05:600c:3151:b0:47a:814c:eea1 with SMTP id 5b1f17b1804b1-47a838534b1mr17213635e9.35.1765360287235;
        Wed, 10 Dec 2025 01:51:27 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a7da4885esm35810375e9.20.2025.12.10.01.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Dec 2025 01:51:26 -0800 (PST)
Message-ID: <74a705b5-bafe-4304-86ea-fd3873ae4fb4@gmail.com>
Date: Wed, 10 Dec 2025 09:51:21 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] doc: replay: improvements like "mention no output on
 conflicts"
To: Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Elijah Newren <newren@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>, Toon Claes <toon@iotcl.com>
References: <CV_replay_conflict.101@msgid.xyz> <xmqq1pl6lzt6.fsf@gitster.g>
 <d2a72ba5-ac7c-490f-9f2c-6cf849e65180@app.fastmail.com>
 <7d0201aa-905c-4da2-932d-47666c923875@gmail.com>
 <202f7015-1e7f-493e-bd82-474e5cefdf01@app.fastmail.com>
 <xmqqzf7ri7q7.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqzf7ri7q7.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/2025 22:57, Junio C Hamano wrote:
> "Kristoffer Haugsbakk" <code@khaugsbakk.name> writes:
> 
>> On Mon, Dec 8, 2025, at 17:00, Phillip Wood wrote:
>> ...
>>> Maybe something like
>>>
>>>       Update all branches whose head commits are replayed. Requires
>>>       --onto.
>>
>> Thanks for the suggestion, and nice catch with the `--onto`. Very
>> personally I don’t like involving “head” terminology. Both because of
>> personal biases[1] as well as introducing “head” as a noun in the doc
>> (now it just talks about `refs/heads/`).
> 
> Yeah, I do not recall calling commit at the tip of a branch a "head
> commit".

We do talk about "branch heads" in our documentation and they point 
commits. We also use "tip" when talking about the commit the branch 
points to so maybe something like

     Update all branches whose tip is replayed

though I think it would be clearer if we could say "commit" somewhere as 
that's what we're replaying. I find the concept of "contained branches" 
rather obscure.

Thanks

Phillip

