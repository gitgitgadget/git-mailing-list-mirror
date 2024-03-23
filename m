Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD63963D
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 19:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711221447; cv=none; b=R65R0SoZCAw3IcVnJkSn3OZb2oHxu4C1s62T6+iNfFCqCBwi7AoEvWEYAZOyfGhRxGT+3O1yFzf66d6yKX1HzDVNcdOIuMTC178uDCCxv01HPqJTzMBYsQypmNtIjKEYoVG5pWjXPe58alo3FkgG54Qqu347Zd4zeGPb1CGkr7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711221447; c=relaxed/simple;
	bh=0sSq4o/+VU06SkdwuTRPiB/w6LIHuhlv1Srka4G+1EA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nt9Nyn671+Y7mg9mhKHp+0EYmtI6kRRC/30loq9/MQi8q1yjUTbgTJW7V70EDuRdOa7axEeKs9jBWcfFJArYQl35QmXjtpq6hEQXcunHZuk7Op9/F2LlGlHDP49MYvyK0/0SMBbvetCVfcvuHMklnAwGmjhMcmDEqcgaWzraXp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvSPs5tQ; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvSPs5tQ"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-60a0579a968so33547387b3.3
        for <git@vger.kernel.org>; Sat, 23 Mar 2024 12:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711221445; x=1711826245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W1aCl0GpefSvfJ3yfuq0i+yLPyZbVHVCu4kG7iqXjfg=;
        b=dvSPs5tQhEGytL7/zE2/rmD7Ym0Avwqv/L2jIcJMDptPPL4OCeO65KKHJQk3732NlF
         YIwzz8klx/Huzei+JmTWMO8Ld00HgjdvVWr66hio2WsMb8wYTH7avGtdMROqW4M3xEPz
         pXezyidlh6Zs+nZSbIf5My1uYF+6YcHbs5sd+7amlZUNc0AhUsRhFfSm7m5h7pPJwRkB
         yv6oKAI+iT1hQ5mL3p1ZCs1T3Bk8/H1QfC5OQWfpCa3ctv8ztkVDY8Sl/S3EkGtqiTYr
         fDbImAU62IvWrMuaetyo8HOM7bBJYU51YCZT3B71om59rvoq8PLiHOUB3Xvy1SvT2tj/
         lL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711221445; x=1711826245;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W1aCl0GpefSvfJ3yfuq0i+yLPyZbVHVCu4kG7iqXjfg=;
        b=vnz5OHQgAZN4LxGnn5ImEHOcGMhy7wHcnse13JUUHj4YtFFQmO//usMm2jpuwZdklU
         HoFJt9ZfXUMctSWLUrwK/Z+oiFQT1HJ7tVDXqzGylr6J9zQ4SxP5rjuMUiS5NR/+AgrI
         vLgLibmulqQhuP+Fv/BmVzoctCX7ppQQzfGfQc20TREL++z6drEQg4tGSyWJcx4yvHXI
         Gm3VRkocBl+7U/oJ8Y4m3IYVVz9RKc2j6LXPGoxYUZaSUj5B2RfafeB3GGEvqpjDSA0s
         8nQ2ldlGLr2STQLwKk6+0SUz+112CNCyC2pFNxaCgSBJRwN539VVZXsMYrkdYHcGVE4K
         tefA==
X-Forwarded-Encrypted: i=1; AJvYcCVecFUXXxomSpaHUdToMdjOO2VXQRlv2coka5LjtArDeSdjHXRvSugMYVwBR1cMUbcGlfik7N5Rm0/JGP8MljE3sY/2
X-Gm-Message-State: AOJu0YwNAR0Ji57i1gBXzJ+pyCUqOonC9hGWfmD3TpBLc5J+2Tl5uFcN
	XT/nQbQxMLNt64Ypt7U6zBcV1XEAiwLrKHfPxg71q+ChHRyqV13r
X-Google-Smtp-Source: AGHT+IGlBe9msKhy1oLYaX99AhTYfcu8gfWeVd4yavKd6n6W1+EV0CFcsQzGuZvZGAy7vGaIloUxnw==
X-Received: by 2002:a0d:ea93:0:b0:60a:1b34:6251 with SMTP id t141-20020a0dea93000000b0060a1b346251mr3152236ywe.13.1711221444721;
        Sat, 23 Mar 2024 12:17:24 -0700 (PDT)
Received: from ?IPV6:2605:2a00:9000:dead:eb24:737d:2586:62fd? ([2605:2a00:9000:dead:eb24:737d:2586:62fd])
        by smtp.gmail.com with ESMTPSA id q4-20020a05621419e400b00690d45bb18asm2340785qvc.34.2024.03.23.12.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Mar 2024 12:17:24 -0700 (PDT)
Message-ID: <d8fa6ab2-949b-4d6f-9c8f-e80f2e524fb7@gmail.com>
Date: Sat, 23 Mar 2024 15:17:20 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Git is not recognizing some merge conflicts and just accepting
 incoming master version
Content-Language: en-US, fr
To: Kai <k.vongrambusch@googlemail.com>, Junio C Hamano <gitster@pobox.com>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
References: <CA+XMOBuK1_BNqgQRfCne8dVXKGPt+iQ9wt4iZqz0PgEqZ5UCtg@mail.gmail.com>
 <606fe3fa-a5a0-4d35-a4a0-59521043dde4@kdbg.org>
 <CA+XMOBskofgsmCbcchmPYo9rF9+Cdtdj_m8VzQrLbGhZPm+mrw@mail.gmail.com>
 <ebd073ef-4ba4-44df-919a-2adefb40e3e7@kdbg.org> <xmqqzfuznn7g.fsf@gitster.g>
 <CA+XMOBuYVWwEE-p=3GHBUcnnM_jn0pneW1rbcQU124DjnJYycA@mail.gmail.com>
From: Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; keydata=
 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
In-Reply-To: <CA+XMOBuYVWwEE-p=3GHBUcnnM_jn0pneW1rbcQU124DjnJYycA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-16 05:19, Kai wrote:
> Thanks a lot for the explanations Brian and Hannes. That clarifies it
> a lot. I had not come across such a semantic issue in my limited
> experience with git before, so I was a bit thrown off.
>
> Given this behavior, I still think it would be a great feature for the
> person doing the merge to at least optionally be able to see
> highlighted parts of the code that had any changes between the base
> and the other two branches. Since these parts of the code could
> potentially cause problems much more than lines of code that have not
> been touched by any branch. But I guess that would be more a GUI
> feature than related to git directly, correct? Maybe there is already
> a GUI offering that?

The --diff-merges=combined option (or simply "-c") of git show is 
probably what you're looking for.

There is also a dense-combined (or "--cc") option that skips seemingly 
unrelated hunks, which doesn't mean these hunk aren't problematic, just 
that there's 6+ lines appart.

Regards,

--
Thomas
