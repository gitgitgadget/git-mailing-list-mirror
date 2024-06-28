Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1D517556
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 01:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719539876; cv=none; b=nbNtryZzk8E2ir7TdAoxGfHTdHxci7QYzYePEBn2G56yyFeR+7nhO52BgCu6HrG7O+pB7BuEBypWAO4sd9KtUnSM/9unoR0TFEaqCvxMqeXnKjd1bkfOfabxn5o8SmVT1TyXbQQ2lLLwF4c0oTBLt1fFTy3qgqG55mOmTJUN4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719539876; c=relaxed/simple;
	bh=g5i8TmfJlfRZet05W9wiWAV02HglLCznlbYY1UK1vhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tPbd38bs6m98Zq9YACjsfLpuLt6yA+eMXBY1RhiEbsec9VI0mXd7hXzjmPbUPGq/ZZucqFWyCxbr17wdqnmOyhHVRWlkREJ8SOPWICnnbNry66elc/ObIcZKeAWyj63aJ03AJvlS2nCOtypiDcy2iqEKeRnz9G+YWkLP/ua1+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxwTLjn5; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxwTLjn5"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-64361817e78so972677b3.1
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 18:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719539874; x=1720144674; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fjnunflsjJB7NhMHL55Oz2QQ7iuFpKv0N9mzNFZziMs=;
        b=cxwTLjn5SV1yRDuzuX254ynjeM7D1PLrcTjatzPdQeCs6Occ+6DKxmoWL74Zbha6MK
         DrECtVMCKWABn/8XFJf2uPSWGVCDzkImgstYeQumDp+lfnNh2jM27W1JHEdsDXcFhXaB
         btDYaYF/mXwsUsy75o1bXXFinleWLwm2SODSgZR93eacL2XYXbdHj9Qc8wQt6yLf+8LR
         jRD+DByjIPvfmsYOWDrRm5MYrkPRZdX5bLKzuuko1zkM7ni6onUmBhq7G6PCCy4U6cWm
         GlseObO9xHTWNueloZvjwNhr7QAuxFTP7Jp5LWe0s+69FfMGAU4dl2Nu/P9di0VmVAc5
         RfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719539874; x=1720144674;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjnunflsjJB7NhMHL55Oz2QQ7iuFpKv0N9mzNFZziMs=;
        b=JO+mq4dAFWJWwBBt1FK4VlJcIKdLb1teh1nXIbtaeBdj0qWAwZymXrdWswNJinPpsD
         T+mU7Sj8WtT0kbFIxgEujLu02PANznqioWKuXbN4YjT/cBxia/pCJF3SXVrNg8FG3ROi
         YbOWlnJKqIR5Fb+Sl4yyQ6dZ/WpVlBjDKJpDt7UaWxViHtzOiqQqscl1AiCIEh74JXXY
         52N+0dyPE/6BRflpve3UJauIBPm+QERbG+4qZx27nl8Ej82+U/FqJfcL4H35ZjqbNLSs
         hLZi3M7fJskNQRPz9UKvjlTz3h7jceIJXmTnb/y8cLi2EIndfucN9JPIVdAKKmsR1hse
         rkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWE0dq7Eenx9HlU6ee8PgN7BEOXBRvDlySOTq0quLWMLGtICgU7ZGNBIWiCVWTdebCtaakg+4qLe4x4rundg2ikFBXk
X-Gm-Message-State: AOJu0YyuhK7PvoDcgj1sx22AZ8EkeFxA5/Ay8EUHTqjm45FjMpVvP8/J
	w/af+KMGHbsUzrktrBxbvA69jxXwWhXpiHpjIY+rE28tFnbXxUTZ
X-Google-Smtp-Source: AGHT+IEcnsrTAeLT/XbLM4vJ5jn5ySNjjntfSdzhwI9wNKqMkuMZtH7gyuzLBLjLekboIel5xVvPrQ==
X-Received: by 2002:a0d:e646:0:b0:64a:fe97:e6f5 with SMTP id 00721157ae682-64afe97f64fmr2293557b3.45.1719539873990;
        Thu, 27 Jun 2024 18:57:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-64a9ba5af89sm1729177b3.85.2024.06.27.18.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jun 2024 18:57:53 -0700 (PDT)
Message-ID: <a1060279-aa30-4e01-8681-a6819bd6bfc8@gmail.com>
Date: Thu, 27 Jun 2024 21:57:52 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] sparse-index: improve
 clear_skip_worktree_from_present_files()
To: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, anh@canva.com
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
 <xmqqv81uqcsi.fsf@gitster.g>
 <CABPp-BFLGrPmUq-rhz7K-G5b__U2jeq8SPdfFDrSa6QkjPMnWg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFLGrPmUq-rhz7K-G5b__U2jeq8SPdfFDrSa6QkjPMnWg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/27/24 8:59 PM, Elijah Newren wrote:
> On Thu, Jun 27, 2024 at 2:46 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> Updates in v2
>>> =============
>>>
>>> Thanks to Elijah for a thorough review, leading to valuable improvements.
>>>
>>>   * I was mistaken that the sparse index was required for this logic to
>>>     happen. This has changed several descriptions across the commit messages.
>>>   * The final lstat() in path_found() was not needed, so is removed in v2.
>>>     This saves even more time and lstat() calls, updating the stats.
>>>   * Elijah created a particularly nasty example for testing, which I include
>>>     in my final patch. He gets a "Helped-by" credit for this.
>>>   * Several comments, variables, and other improvements based on Elijah's
>>>     recommendations.
>>>
>>> Thanks, Stolee
>>
>> Thanks, both.  This round was a pleasant read.
>>
>> Let's mark it for 'next' soonish.
> 
> Yeah, this version looks pretty good.  There was a possible further
> improvement you suggested, but I think that wouldn't need to hold up
> this series.
> 
> However, there is one paragraph from the commit message of 1/5 that
> I'd like to see stricken first (or rewritten).  Once that's done, I
> think this series is ready for next.

I agree about the removal of that paragraph, but also there is a
"largest" to "longest" replacement in a few comments that makes sense
to change.

I can send a v3 with these changes.

Thanks,
-Stolee
