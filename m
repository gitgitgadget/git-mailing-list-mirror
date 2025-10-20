Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAC2320CDF
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969838; cv=none; b=oftLLoMJBjeAtQWKt3kyqlHlXCAa+KA2uBSuhrKOrhYihoxIROkdH+JAa0eOQ8nJ1eZyOsk8hPngTtPNo1GU7rZq5dWWo/e9AQufcWQpX7+vDeNjymsdsOC4usU2mBhbF1puWkPr3E1GnPBEKa1TW0shUSpwd55KYEJIyOWsVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969838; c=relaxed/simple;
	bh=L+y+exj1Bn8VztlBR3VQZjkpHoOj5u8pJA5U/lvIPYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP55kcaTxgHyMFmOuPohfNt5VamQW8BlQ/7FTjNxqNPwaWdFNsJHCkfM1e1eo2bLdhsENe4n+7MQg2JTobRsnTZKJ3GTyxr69C3EkDPjvl94iG1E0bHsGK4Rgk4vAMIZPKwCJ1/yRLyuvkfMa8/bzFSBGRYguvYfjXdAs+FMT7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxndnZKo; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxndnZKo"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-87c20106cbeso63416156d6.1
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760969835; x=1761574635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZvFdgR75L6zuezDtPlqko99s8ExdW7CGnkRjc3vTwgI=;
        b=dxndnZKooiM/Uj9TpUPHczBZK2pnKJkjUi4VnkG8mQdExw4tef+rJK7EgiVvek+bIA
         HLoOM+n6AWiHEoQMoJEfQjI5giGp7S+QycE5Ys0eorFW26ofnlE6WGYlmq7H4ZhDm5f3
         pimUsuTOdhFtLu2f+2g1DUxfDxBwW3ORoDHEZelEYih0ufl/vvkDtRHoaymZw32HALXt
         A8qJ94CEtJpIFGRCVZqEW5gK3XgiGxTP5MUmH+9nUpb6sN1hRlGjPnLAVuDG+9qojtsq
         fjIFRdR5qAUP0NE2xBEMN+Z1KDQSOhNe/f9g6sr+xsEhRnXIzyrdcwp0/PmiY5etltXm
         7Haw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969835; x=1761574635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZvFdgR75L6zuezDtPlqko99s8ExdW7CGnkRjc3vTwgI=;
        b=C6EKwi7LXhBy0pEn0Y4Js/6oZxKqSGi9UiIJTIoZ5ygvl2ln4+pZcCHAmy/MEkzHmh
         hatj63ri97c6qOC10WIIbRdOoYqTDF+DoIHLx5Y576JScPpEPSzdHWdSu/X0lUWK3rEf
         ErZtevKAjT4xEHgUbXVgQOxO6MGfdPNG1Ph9iPJUZUackbNoVJ/cfjnJJuT33raB/iNK
         Ody4i3G95orr0P561Xeu1CIPFuUplm5NImGlt2T6RQKY+gb6UPoS4Sgw8qMncbIjX/Io
         rjRZwO1L9OPUI4re5RxWh4mj7eXZMHstBi5/AAa0/9T7P6q9/O458NhiDcrBVUJGqs+t
         gsZA==
X-Gm-Message-State: AOJu0Yz8WfWQkXODLG7iv6f0xK4vo0cVkBL6//y6cAiDpAFgfUDv7Gdf
	xMof7/yMeTBcqhVNYKk1uz2a4oDQtNZH9jcmzvvjFzWG8Qs7JbwkPer0k8slOqhB
X-Gm-Gg: ASbGnct6495G1ipF4s7/fyqDT48P3Qu7oRT/qNCe+8HdibcCXmLIIlErXX4+DSFZYrH
	8VDHW9hhcS/nmSyxJHHA6KoR2ydeK/MFpi8NTdC8d++nm+mtRQA4RzjsEgHxKNnF6IUjuaKcR2J
	xWowYTQoyd60DSE4EaLsXwFDf2s8flupHv/IV0obSVNe+A/l+8clpwhh707vMxxAKyQdnRYulOe
	GxI7UlsWPdD+vk9aknd3m3RkhJNYAr9QW0pNWWBgMGb9fTMPmX0O4FKSqePo2+Z+++eqkHHXHjC
	rK6kJwmk4u4dtIj3W1li+nCXoUSBijaYbVpmaiM/u59BTc1e7qzGnpQc85xsJtp/f+OE/xUqF6k
	WQ4wSAWRze2V63SWfoPmB8KPR8KZUiI40F17Sj4JKPbo302kGliYt23QXCQQoYECHmgOsPdxfmC
	4NAnSU2YO22A0jJtYzrgMTRIvdX4AxtbqIP0EbV9ZGCFyUcAuJxBqZtBJEtYYOLZ0Tu7Y7Agk0D
	8M9laxQvnOtqvq89+rmvzM=
X-Google-Smtp-Source: AGHT+IFZXT7wv7Ge0K+g5zHqW8ZnDitSvWAeCj0adiGuXogoZqoLc0eYmkWdPf/K7qjn1L+/mhL0IQ==
X-Received: by 2002:a05:6214:2021:b0:87c:2c76:62a2 with SMTP id 6a1803df08f44-87c2c766854mr110742016d6.64.1760969835022;
        Mon, 20 Oct 2025 07:17:15 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b1:2f00:3d56:be00:69bd:1efd? ([2605:a601:a6b1:2f00:3d56:be00:69bd:1efd])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d01efa7e0sm52372826d6.36.2025.10.20.07.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:17:14 -0700 (PDT)
Message-ID: <3848ce2c-c2d3-47db-81cb-14e79d3d7f0e@gmail.com>
Date: Mon, 20 Oct 2025 10:17:13 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] sparse-index: point users to new 'clean' action
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
 <460e5e8157fc87a4246c49f53e34495bc33d4432.1757673011.git.gitgitgadget@gmail.com>
 <CABPp-BG_TwQRcCp4iCpcDngb3W7rprnX4FHLs4A884BXQVk_eQ@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BG_TwQRcCp4iCpcDngb3W7rprnX4FHLs4A884BXQVk_eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/7/25 6:53 PM, Elijah Newren wrote:
> On Fri, Sep 12, 2025 at 3:30 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> In my experience, the most-common reason that the sparse index must
>> expand to a full one is because there is some leftover file in a tracked
>> directory that is now outside of the sparse-checkout. The new 'git
>> sparse-checkout clean' command will find and delete these directories,
>> so point users to it when they hit the sparse index expansion advice.
>>
>> Signed-off-by: Derrick Stolee <stolee@gmail.com>
>> ---
>>   sparse-index.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/sparse-index.c b/sparse-index.c
>> index 5634abafaa..5d14795063 100644
>> --- a/sparse-index.c
>> +++ b/sparse-index.c
>> @@ -32,7 +32,8 @@ int give_advice_on_expansion = 1;
>>          "Your working directory likely has contents that are outside of\n"     \
>>          "your sparse-checkout patterns. Use 'git sparse-checkout list' to\n"   \
>>          "see your sparse-checkout definition and compare it to your working\n" \
>> -       "directory contents. Running 'git clean' may assist in this cleanup."
>> +       "directory contents. Running 'git sparse-checkout clean' may assist\n" \
>> +       "in this cleanup."
> 
> Given that you dropped patch 8 and explicitly call out in the
> documentation of `git sparse-checkout clean` that it alone is not
> sufficient to do the cleanup, should this advice be calling out a
> combination of `git sparse-checkout clean` and `git sparse-checkout
> reapply` ?  (Should it also suggest an order for running those two; I
> seem to recall that the order mattered, but can't recall which one
> needs to run first or if it is situation dependent.)

I'll expand this advice in an upcoming patch 8.

Thanks,
-Stolee

