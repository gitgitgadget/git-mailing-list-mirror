Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E162041C72
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 18:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741717439; cv=none; b=C06JUmXu8z8hER1UyazQGWepRbxgKG9QTHjlp32sToCghMkeR1MooAoBMhaBRx5ys9IKVT3b8l+W9ateIDXX6TmnJSTTpTLyzTC9jnis1o286E2W0Y+WVN+6zYiG94jTJkWGVNc5QuTdZaGOxl1yTBKI7FCE8dzY4GBRaYC5HGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741717439; c=relaxed/simple;
	bh=mYQzjiY+Ha0QZVty7UQ3xP4K48/HUuNvrQ/B5Z4gJXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YxjkshjFLA+hzzKT9pXdXCg0n/Rt6mSaGMEnS3jfvWZjkX4JyDHawujuRpIFDFI4uTIOmWaEomsLhnW1fAcxBwBY6GSVjjSki44jJ+z7/qGOtVH7L0K3sHdYXd5Oh/GbNwiFL8Ek1Fv0CyyiWlVbQdvVoSrekpLXXNkTlbdpSfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzOJrO3c; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzOJrO3c"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-223a7065ff8so16755905ad.0
        for <git@vger.kernel.org>; Tue, 11 Mar 2025 11:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741717437; x=1742322237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DqfE0lci8sGuJuNvCB5gzwHOSPrDBfMtCuum/A/rlq8=;
        b=TzOJrO3cC1AZoTJ8CjXc+O7MV+WXkyWRA0FK/N2xBZIkPERYEfS0dx8QuitKiNR4fZ
         fp5u2BNN/7AwEmvayVy6ICtsFaojCSgi0YU3jlO5aUlxPkXaKiGAwvNQQB9ueGShJJXQ
         8cqyYXrZoF8IjB+ayrJaIsZzRmSXD2fZyN6L3PNbRXn/EDKB085infTTeSvEtdRvcDc3
         McYw9Ml1JETDYNSyLIQ4Zm+g2pHyQV1X7AsQWwRP3vE0s4N6GjGO0b2dvXPxeR/A+K3+
         OSNy2eH7fnZZqddEWvSZKsYP8/KuwvqjPRehoY5pnQPe42g1VV7D37OfQh+iRPf7A8VF
         c/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741717437; x=1742322237;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DqfE0lci8sGuJuNvCB5gzwHOSPrDBfMtCuum/A/rlq8=;
        b=Z0S9pExzg2R6NQJLpmBX68S2PqQBNyZPcp2HMRcb4ZTBvTmggh2NDFNyxhCMSKjBb/
         I8MbkPUfgqpRPN4lCr7G5RkswH6LbhQEQLjNi/eyEVtwhTLf6yLZhjZqJ+K1cmkf/Hw2
         sV2+UDHlf6wQZW3aBPmpYUxmlXMNUMD4mvJabLECcKvbzr3UxydYIYYCW6tmEtRgrP6X
         MtSIxFTVUH3eBxFffzbWwKxV5Fio0CXOJ48zNAiwOMgMVnaIdtqWT5FYitBVr6unCmfE
         EqTcTCoSYYFYq4ejYkMGkRvd/4G4yV84b2iHV/x3+cT37Wy6SYVhWBFfNG0TTQAKMYLN
         WrIQ==
X-Gm-Message-State: AOJu0YzqcYpsd7tbMcj4fkb0XeGuUiKcgOyy4a5FweK5JCz3xkHPbTXy
	b6Ga3Q33Yu0xPJalGS43yUyB1G8gldhLjBnmvlLt+/4zNx1yphrA
X-Gm-Gg: ASbGncvJmcsgG6A5s/rAItZUXZGw9RcR7R6xbysxZVZyTHSK8wBK+7u6Y6bMKlB3UKt
	wY2OAH6mOKbbmPSklAoI4kN2Qll0GGiLc2LqgHjxh768nJEQN+ia4vs5v4tW5A+ONK/ZLAusleM
	zoR8DoMUuQhWz5hyE8SEXbfvW3hRCyfisxKPlniAZtQAKFXdnBPa+et5ALnvlmHDfVGjw+UJGNS
	bTT/KCb02GwYWULmDOS1K0rHc4tmDO6n3ciUOlmB8goCsnu6kLP1CaY5ty1J027x0tuHHvJSfOu
	DOxNEmzCA7maX7xfQg8DWtosUCY7tZWQ++kfw+nH/GBfcIKOLm4=
X-Google-Smtp-Source: AGHT+IH+HMdMzs2sSwIUo46i6/EfaIQPFnQPjt1HHfEFFrNIwe5CI2bw6di13HxaiJTy8T2J+IaHEg==
X-Received: by 2002:a05:6a00:b4d:b0:730:8a0a:9f09 with SMTP id d2e1a72fcca58-736aaaaca0fmr28651091b3a.18.1741717436923;
        Tue, 11 Mar 2025 11:23:56 -0700 (PDT)
Received: from [10.61.143.243] ([103.21.124.55])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7369dfd387csm10630625b3a.171.2025.03.11.11.23.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 11:23:56 -0700 (PDT)
Message-ID: <ab2af3ec-f4cf-4337-82ce-7c4ade244568@gmail.com>
Date: Tue, 11 Mar 2025 23:53:53 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Defining timestamp_t as intmax_t instead of uintmax_t
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
References: <629c3c21-ab11-42c1-8cb1-34698e736db6@gmail.com>
 <xmqqv7sf32a6.fsf@gitster.g>
Content-Language: en-US
From: Arnav Bhate <bhatearnav@gmail.com>
In-Reply-To: <xmqqv7sf32a6.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Junio C Hamano <gitster@pobox.com> writes:
> Arnav Bhate <bhatearnav@gmail.com> writes:
> 
>> timestamp_t is a data type defined in git-compat-util.h as uintmax_t since
>> 28f4aee3fb (use uintmax_t for timestamps, 2017-04-26). It was introduced with
>> dddbad728c (timestamp_t: a new data type for timestamps, 2017-04-26) to replace
>> use of both time_t and unsigned long for time-related uses.
> 
> I do not think the object format and the existing object parsers are
> prepared to handle timestamp before the epoch.

Looks like I bit off more than I could chew. Maybe this could be a medium-sized
project in itself.

> You may want to go back to the list archive for discussions around
> the choice of the type back then, which should have enough
> information to go by.
> 
> https://lore.kernel.org/git/20170228200145.ymbqmxwrbbrwagks@sigill.intra.peff.net/
> 
> might be a good starting point.
> 
> https://lore.kernel.org/git/?q=f:peff@+d:20170201..20170430+timestamp_t
> 
> gives 6 entry points to a single large thread that may be worth
> following before tackling this topic further.
> 
> Thanks.

I'll go through it.

-- 
Regards,
Arnav Bhate
(He/Him)

