Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760F262FE7
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755698861; cv=none; b=DQXpIQ/irdaGtGkvuYb5IGhj7uPYgMEBtR4o40kcSb+JNGXXYSvd7rup4vdBpU8eoJB1HYgzhbUCQn3+eScXQPz5lo7hQ4mItGPHlZeJG6qMs8x1F7KxJzbcqY7G6FXEqe79z51Mth7ATZknuTY00/djPxX37jYKqHN+1eiPamY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755698861; c=relaxed/simple;
	bh=ldJXTsT5XYJHsyGNcu0ONReboaQcHkttSmdayk+R6eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YSCB/c0JaGRceiWo6+hWfII/4EkPLPdKw9tPj1HWEpKr96gYflZ0jgdrCPXtnYhu0a09aYnPil5csdH6pcVxIpnp0omZl8LCulNmJbD5urvWpiojknYRm9KAgowIeSpRVT0gVGpR0th09n3NpLbb3kKWDCXQdOdUzjehw61YlB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LA/hcqfs; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LA/hcqfs"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9e4106460so5157479f8f.2
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755698858; x=1756303658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xHlZuB4zo7zcP5M8MO2fobVsfjEHo/p+mtG4MC0J87U=;
        b=LA/hcqfsz1U8vngx34tihQQH540qtml5GRQmVC+H9xcvY3Bfb92BlGOQbZ6qdrbeKt
         2GL4BBC9eeSiqszENaak44sXsmKxlnhljfEiCG5qvM4MleIbGItptgS5e/b3dbE3a/qq
         43g+srJpCF/3yfqOUEizXhaj21x+2TiXbzRUhBzZtc0Sk4wK7utuGxZA6lKaWO64wS+m
         of9spmMWVvWdCo/7ywcMQ2bJGGJ9IfsATHx41Vc0WIkkn/wONVE9FbSM7oIPH7lDKKPU
         ycGD4YYXngNhOpvpYPh8JXXazS1giUZM8RV5Y8sZZVxCx4UtgvnFAISV7T2ZhiTK9+3n
         ogCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755698858; x=1756303658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xHlZuB4zo7zcP5M8MO2fobVsfjEHo/p+mtG4MC0J87U=;
        b=YdYT2Iz3hkRUz5gC2Gfr9coNbLt03vckboaRt9lNtv7iHjfvkDO1YrKN3llEMqnkzX
         EWNypGbzcCRHH0kSWTXR5biZ81KC5dCJ0hpiJxY1MkLrQhH+tlmh1cgD1DXYnrWgOlpk
         TBU34lRxO5nc4UOVmg19UKWUoytsUl0hMHjewI2TZ/ySEqpFqKvSzsIWYw1abg0omBAN
         04SGYowyoVe7Kh9XKDi44fsomqbljHwnklvWEDzIMzEpN7vemcDaVlV7l+I3mV3+atkf
         XMgE7wJ9sy6+pLqoecnH7hHylsDHVE1DDxMHNIj/f1St3DglBiSLE5NHGQ19rjbVBLLl
         hbkA==
X-Gm-Message-State: AOJu0YxjdCWwrx6tPJpurCXXBonzM2xJjNip5dcmaYZN4PSjHfBiqNKS
	G7TNKO298wst0z6dZ9B6/wrZEM5dP4czo4fAW5APipEJ8zCiBLXY20/3
X-Gm-Gg: ASbGncsaoZLOKit9Kr+LX6IeVb6VLRAX+/3IZdhaHOk5ZCgZZ1yUYvNRgpl0O/4Ig3E
	WbTOBaQSRTHgV+O+5YM5c5z/3FA4IpZWh8bNZPPND2im1jFCQdT5j9te4W9f5BxLutgEerdvcTQ
	A+JwKH81JAvZFYqqX0+zVmjm9OFdb2d7VyB/uCJFJCDXwTckkThCIkdP/25vAli62vxCT1mKcMW
	LM8swFjJHI1mjlanFLSTX2nDyhs1nHEgt+9Gk18QWVWDa4t7Y67BBzf7Uqi0gY8mCzmyIDQq+Du
	eEAJ09VqPfxOT/CJ5PhKm5OkPF+qZ1+MN0mdEeeE5gMu1iQY1yq+oca6wHcHlTJAzYhBtrefucH
	Bt7+1aFC8dO+W+bMGsu+bAcxp/UHJb2QDoMEBkR4S38arWOpCUA==
X-Google-Smtp-Source: AGHT+IFCTiyD9wya+S5BOQguduRxb6WskeD7GZcqy6Y80wCWAkJEYhjCrSff5i+nvbRPFCPl8WNQnA==
X-Received: by 2002:a5d:64e7:0:b0:3b7:87be:d9d8 with SMTP id ffacd0b85a97d-3c32e6fe6f6mr2118561f8f.43.1755698857818;
        Wed, 20 Aug 2025 07:07:37 -0700 (PDT)
Received: from [172.16.62.38] ([82.3.55.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b47c8e98dsm37065375e9.14.2025.08.20.07.07.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 07:07:37 -0700 (PDT)
Message-ID: <363ac6d1-8444-4d48-a66b-51ea139f4e87@gmail.com>
Date: Wed, 20 Aug 2025 15:07:36 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc:clarify which remotes can be used when contributing
To: Junio C Hamano <gitster@pobox.com>,
 Daniele Sassoli via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
References: <pull.2034.git.git.1755630882418.gitgitgadget@gmail.com>
 <xmqqms7vc8mo.fsf@gitster.g>
Content-Language: en-US
From: Daniele Sassoli <danielesassoli@gmail.com>
In-Reply-To: <xmqqms7vc8mo.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19/08/2025 22:19, Junio C Hamano wrote:
> "Daniele Sassoli via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>   https://github.com/gitgitgadget/git and open a PR either with the "New pull
>>   request" button or the convenient "Compare & pull request" button that may
>>   appear with the name of your newly pushed branch.
>> +If you're using https://github.com/git/git as your remote, you will need to
>> +open the pull-request from your fork, selecting `git/git` as base.
>> +
>> +The differences between using `gitgitgadget/git` and `git/git` as your base can
>> +be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
> Looking at the table, there is no advantage to use git/git at all.
>
> Instead of telling them that they can use either (with reduced
> capabilities if you pick one of them instead of the other), wouldn't
> it be easier for the user if this section taught them how to switch
> their fork that they originally created out of git/git to be based

Most of the document, including the "Getting Started" section, points to cloning
from git/git. It's only when it comes to the gitgitgadget section that we
mention gitgitgadget/git.

It's true that there are no advantages of using git/git over gitgitgadget/git,
but I would argue that the disadvantages are quite minor and definitely don't
impact someone at their first contribution?

As we've told the reader so far to use git/git, I don't see why we should tell
him to change his remote for potentially no benefit. If we're saying that
gitgitgadget should be used only on gitgitgadget/git, then we should restructure
the document to point to that from the beginning, no?

PS. please note it's my first time replying on the mailing list directly,
apologies if I did something wrong, like wrong posting style or wrong people in
cc.

> on gitgitgadget/git instead?  Something along the lines of
>
>      ... If you originally forked from https://github.com/git/git/,
>      you can easily correct it by running (you only need to do this
>      once):
>
>      $ git remote set-url origin https://github.com/gitgitgadget/git/
>      $ git fetch --prune origin
>
>      A pull request at https://github.com/gitgitgadget/git/ can be
>      opened once you do so.
>
> but you'd need to validate the procedure, as I didn't try it myself.
>
> Thanks.
