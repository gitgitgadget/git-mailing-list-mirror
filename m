Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8328379
	for <git@vger.kernel.org>; Wed,  3 Jul 2024 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720034291; cv=none; b=ONKOVbRfyrCPBCwCe7MULYFR+R6qByYxC4s/LBNYpo4aWrT9UEuiWNgDYS+TtBLdAZJpNAWj2Pao3uH8/MPOa3idwA/O1D5gs2ZkxMlyq/viA+7DMwc3aA8yivYeMNQ/qbNWZcHeCRCZdlLTCY8q36rbeWLnPGWRIYzEmVNft4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720034291; c=relaxed/simple;
	bh=fUP7mhWKjuqh+p1QrT3Zeae8Px+Ju4K4TVqbTPotGcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ka5nP9k0CglNBd26yfCYYg338fWa330WU/AVTQ2X3KqmQPLgM640IvvHPz2X7nglB3JnQDMxekzIzkCscZ1WQcmwiYNBzc2W7LLVxMGlOZJhJ/YzB6OjHzakKQo5XkN+eLYwjAizOjQlExAkZFsClxthyqIzrV/u/ZhebcBoIY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJPBoAdH; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJPBoAdH"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d639f967b0so2376802b6e.0
        for <git@vger.kernel.org>; Wed, 03 Jul 2024 12:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720034288; x=1720639088; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hX/zw4WWl1QJPoJh8TJqS7YtQgzFdVpYVInKkWFuY8=;
        b=GJPBoAdHJ6ciulDTLXOlNmJCRx0hv531XohRFD8++jnn9oZlRWUzNbmAK9DyHkz/Fi
         wQb5XQeu//JXWIlXKSSpWSKYpEMymoRN52lbouKJaXCpHRkFfosB7gC0tQ4PbxlgBg9z
         gS9KbTy/+q/2Ojk0LtfzuTNDz06AqyBXGHsKpHZnMV+LGHUjyAjdlCrHa0NjNHuyXP7u
         f448GN/wzOmJ7RKbJtEj8zHLCWZNPtftIkzpxJM/1wIe9Qsll2yFkPLjfpG0PdHaoG64
         jJJ6GTN9Gta2xCloVx/lm0NT4kZbmLRwQJNfgwaHq+LkJVcG398oIVwVugKQgg5A96rK
         u8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720034288; x=1720639088;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hX/zw4WWl1QJPoJh8TJqS7YtQgzFdVpYVInKkWFuY8=;
        b=vWn5UOZCCUm56ggikbgvhddN0CV0VeIYwWDZKW7U6f143IMMNuSXXejnhykm0f91VB
         I/Zp4Y1Rv9Y+dRaGTHTuKmLFS4s7cb7YG7ecawJ0ZoTtApb0Cx+/aGa/tLkesqi17/NY
         PfVzHThMjKq7VyooMsUWn+jK/YU5zan+M8bwAtK7Eg/iqcxWNaXTPYaVJzwz6cX6TGaO
         0jTwJwgtslD8Os0vqN4LF/PyI3Mtgk2WvdJgTCF30H4Hy3cas7L1CHsunWPckeqCCIh7
         +TN+h3GGCfbJ0YCwWrk+AB8f2IPRJxbheJ9J2j89xf8svwEuteoO51ckDbCyzY2iuUob
         jCzQ==
X-Gm-Message-State: AOJu0YzPJYl//CVXzweWpgmPxvZL3jkeyQjH/gcVSj5yymrRGHKl6rae
	vzNnuWGBPtbSTHvkWJvgEavyJIZvMtPEkiDTM9wbhZVLpcngD4b0
X-Google-Smtp-Source: AGHT+IFqt52B1sd4Vx1Y4G4//3ocF5cisDokFTpSOlvwWHURbY1Wy+V0bvdIj5VVUvHfIN7S6zX9dQ==
X-Received: by 2002:a05:6808:f07:b0:3d5:1f50:188a with SMTP id 5614622812f47-3d6b31eb9eemr12705168b6e.24.1720034288326;
        Wed, 03 Jul 2024 12:18:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:bdac:f074:23e1:5a96? ([2600:1700:60ba:9810:bdac:f074:23e1:5a96])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3d62fa4164csm2189167b6e.46.2024.07.03.12.18.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 12:18:07 -0700 (PDT)
Message-ID: <068752a3-4140-4b30-803a-1c409afb01e1@gmail.com>
Date: Wed, 3 Jul 2024 15:18:06 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] advice: warn when sparse index expands
To: Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, newren@gmail.com, vdye@github.com
References: <pull.1756.git.1720019679517.gitgitgadget@gmail.com>
 <xmqq8qyicpdd.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq8qyicpdd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/24 2:16 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> Typically, forcing a sparse index to expand to a full index means that
>> Git could not determine the status of a file outside of the
>> sparse-checkout and needed to expand sparse trees into the full list of
>> sparse blobs. This operation can be very slow when the sparse-checkout
>> is much smaller than the full tree at HEAD.
>>
>> When users are in this state, it is common that 'git status' will report
>> the problem. Usually there is a modified or untracked file outside of
>> the sparse-checkout mentioned by the 'git status' output. There are a
>> number of reasons why this is insufficient:
> 
> Nicely written to explain why giving an advice message is a good
> idea to cover this situation.
> 
> Making it possible to squelch comes with no cost (once the code to
> do so is written), so I do not have a huge problem with the use of
> advise_if_enabled(), but I offhand do not know if the users would
> ever want to squelch it.  Is this something that users would choose
> to say "yes, I know what I am doing is making my sparse working tree
> unusuably slow and I've heard how to whip my sparse working tree
> into a better shape already---please do not tell it to me ever
> again; because I need to leave these crufts outside the sparse cone
> anyway, I am willing to accept the unusually slow response,
> overhead, and wasted cycles and power" to?

I currently can't imagine a case where a user would want to disable
this advice, but I defaulted to allowing it. I suppose it is more
difficult to remove that option later, so I should have defaulted
to not having it removable via config.

I can send a v2 without the config option present. (I'll wait a
day or two to see if others have strong opinions.)

Thanks,
-Stolee
