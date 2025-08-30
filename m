Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D894323BCEE
	for <git@vger.kernel.org>; Sat, 30 Aug 2025 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756561319; cv=none; b=ijGY/WpT7U3MunGXHR67KLynId39B/GszyvDIutQVsjGZBJqf70s47f4XDqmx53IvWA/hCng0JbIfS/JJ3rL84483sLWWUsMW5NzaiAtYJtYX7Se2aGRYkldZ9RPnWZv4905GpdsB7wFqOtWVBkHMjYfdIeHfkRcbiKs/bWF9F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756561319; c=relaxed/simple;
	bh=QVDMu3Ioo1QClqQ2N7PYpIIVULnCaXVSFx/U9ePHMcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X2FyiwHOUVFmalAfNs6WxINKtjPD4uqVwlKRFJWyCBjrJ3okbZCMAKHYBQ6RjgXGKA+n0rDBx1fIc61ppODHiP1Fog8DmfN0kVI99bLTuOJRSO7XFdUG6nnBWqnopcB6TQNr3RpvAX7rWRSTXa0gjbnJCIC6Dj6OjFBACv1ZCf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hM1QvFda; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hM1QvFda"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-70dfe0ff970so23049746d6.1
        for <git@vger.kernel.org>; Sat, 30 Aug 2025 06:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756561317; x=1757166117; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5l6KgvXZcosvRMXIHwBMZhz9gIF/tCayve3+DVOng7g=;
        b=hM1QvFda9uoyE4CXQ36CiaPtcne8ITunC5ct3fmIOTs3rNvFLD2oH35bPpc+rV8h2g
         c+7ZqsTBTmqHU37CxSQ2QuIPAq7jFS3BIB51IACXHVPIp+caqMYpMvKoAK+euE4YKsFJ
         nCmYrsIGNSunTPSKKEVdvisWlNfmb2CvHMja+3WsotTEG3hfJopONgl55D8qDUpeIOzI
         eLZHW5AUi2PJqWJ4E7Wmg+4FocMX6BtNhhNHKgthv1cCWsFM1Xjk9pGSSFCkHMFrTty6
         HzhZhXEaX2knhKiACecILMgq1xODd3A83SJXbU4UeZF6zhHV9wyhuwjf9goOdSpmrP7r
         e1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756561317; x=1757166117;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5l6KgvXZcosvRMXIHwBMZhz9gIF/tCayve3+DVOng7g=;
        b=RjjOjrhIxhxvpME+8P81/MIIr50zaN4t0Rvc7mLfvR6HGUr5ya+MreKH3oNHA575si
         YyNYzMiHzz4a5tZTCZu+DYSEysfO9ejgc1LC29Flsw+7algFuE8r2ghaBVEhCnUASyb8
         /cj8o17uBxwNWhidCagXBBK/DQKoCKZOSB/pthxEs1FdBvldul0jtvDjTUMCqUAz5DHG
         OzJ68Akpq0xSWVzfvoabatZ6r9Twa+/u3TpcQpM0UZNSjrLYjpwjnBJxqUqhjugIqBTO
         xxzS+t2ZGzhveJ4YDgjCj3c/Yf8Tm/3E8jjDWzZdY303vEY6VWykkv5lAQRwmirNU+Iw
         pxgA==
X-Forwarded-Encrypted: i=1; AJvYcCVP6JMKMx1BOZqRnNlKqvZzOKzcjrOxTflnty84yMJPy+hQSL1Sh1GvrvhhpYfshGmnbQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QSWl06ZpQoF7VbR9U2vHxJVFnAETbXifmPiurnP4YbGt6G9G
	ZDskWIRMGNdF5ZwqvRWBmEW+UbY2GOZJcrt3QM7z/3bmfyeqGilPIExkaXOQ2W+o
X-Gm-Gg: ASbGncsii0jFyvOVjPOqHiBQA9dPj7GbipDnodwShTIT4II9YaEaKNh1eyZvhAhWGBd
	EJOT+IoyST825+3VXfL7xjGkapPliCG68EuZjmPNwQ3r8CRlYBRwU6oULaSyAY5tOL+iv1NaDWw
	L63CK9DmH6eW/85ixejCRvmHoJEiXlB30Mj5Y9kmfN/izXQ20a8ncTVD4rzjtNJMKOIdk28r0T8
	VyFNvD9npZx89nN7IwKH/vLBYhneGXzGX0Of0oewaNCBvYjtxwwNMFC4CT2nKjjzGDhF39KBaga
	mq3av3+ShqCqRj/sv2DESuVGZmWRX0fjL4IJIefovHV2cFfDEoOT0b9l3gFxCLBofdcAGjUMZLy
	bfmurCBgAxCc7KB0a9mOXgJIPPNtppjH/xgvUecUQFOlqosvVAjS7ZtE01GhzpjVqaN9P6pE0NT
	KovNeMRTWPhhV56IBn9VTXRgWiIg==
X-Google-Smtp-Source: AGHT+IG/ReVqA0mrvPttODC6epUIrw3nF0K85JECmOjEuiY2DzNRyUCovDU/YZFLkHsSb+8ufcmXBQ==
X-Received: by 2002:a05:6214:2349:b0:70f:a1b0:2f6e with SMTP id 6a1803df08f44-70fac8fa36dmr20616676d6.53.1756561316496;
        Sat, 30 Aug 2025 06:41:56 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6de:d300:85d0:178d:3525:8f0e? ([2605:a601:a6de:d300:85d0:178d:3525:8f0e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70fb25c6dd6sm5856626d6.1.2025.08.30.06.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Aug 2025 06:41:55 -0700 (PDT)
Message-ID: <7bc3e3ba-872d-4c03-a032-7b6a6251daf8@gmail.com>
Date: Sat, 30 Aug 2025 09:41:55 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] sparse-checkout: add 'clean' command
To: Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, ayu.chandekar@gmail.com
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <xmqqzfbjqbfo.fsf@gitster.g>
 <CABPp-BH=tk3eenHJkbRcD8uLGuakNMT5GkjVt6WfmOO8P+xq7A@mail.gmail.com>
 <xmqq5xe7q8f5.fsf@gitster.g> <xmqqcy8dn8mk.fsf@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqcy8dn8mk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 8/29/25 5:03 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Elijah Newren <newren@gmail.com> writes:
>>
>>> On Thu, Aug 28, 2025 at 4:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>>>>
>>>> This seems to have a few comments that haven't been responded to
>>>> (plus a "This step looks good to me" or two).  Can we get it unstuck
>>>> soonish?  The topic is from mid July and I do not like to hold topics
>>>> in 'seen' for longer than a month without any activity.
>>>
>>> Stolee built this series on top of Ayush's topic to avoid conflicts
>>> for you, and he said
>>> (https://lore.kernel.org/git/c3c0fbef-f395-4972-8352-dd89af6799d5@gmail.com/)
>>> that since you marked this as blocking on Ayush's topic, he didn't
>>> want to update until that topic moved.
>>>
>>> Do you want to instead kick Ayush's topic out and have Stolee rebase
>>> to no longer be on top of Ayush's, and have Ayush rebase anything he
>>> might do on top of Stolee's work?  (See also Ayush's recent update at
>>> https://lore.kernel.org/git/CAE7as+ZpEwiNsDAozoZXqHRLOF3+hT++uo=mzZqEvTPovQN9uw@mail.gmail.com/)
>>
>> It really depends on how unstable the base topic would be, but I
>> know Stolee is better than building his stuff on unusably unstable
>> crap, and that was the reason why I thought that updating this topic
>> on top of the same base would allow us to move forward faster, as it
>> would mean that everything would hopefully be ready _UNLESS_ the
>> change that needs to be made to the base topic is so extensive that
>> the topic on top would also need heavy updates _again_ once an
>> update to the base topic comes.
> 
> (Sorry, but sent before finishing).
> 
> Yes, it may be simpler to kick out a stalled topic and give it a
> fresh restart when it becomes ready.  If Derrick wants to go that
> route, I am totally fine with that.

I'll see how things go this coming week as I page this series
back into my active work. If Ayush resubmits before I get to it,
then I won't be upset.

Thanks,
-Stolee


