Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAE4311968
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 18:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474602; cv=none; b=owC4xDWt1bZVdXok5WwVUjKmr1zyqCfOsjmv2M38p7WtRUqvULgn38NWPL+c7M7cmFzZuQ9FpNF68pKM9HZ/U4Ngm0/ngf+TpE93QVbGlPFwIyVG5IAlLRA8zCjmJsbpNAj/8gsnyU/dIZSyJbghw8B1GLkCF/VVtBjKeLH4ZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474602; c=relaxed/simple;
	bh=oATRXdMnZQbk56VLuGFp3yqY3p2CBKY19Jj2UXyS9jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnkTUUAcokG34pV+S2Kxcq6kcbXVChasePA26O8w9c7Mc7Vtoa4XDBHpHNvbv8+6Fmd6UVPgyU4eOEXjG6Q88RF6z3rixRBZDGIgu321wQSkBc7LGaq1c3f2zrloULztj31JaNs97GN+VeXJLOY97UXuJGNplZs5dEbekQlFYUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtpHevqw; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtpHevqw"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ae50a33ff8so9722185ad.3
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 10:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772474601; x=1773079401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDw0uXWTdhdXPY/VLpgjETo3RvClLNelJGQAl71X0UI=;
        b=QtpHevqw1GnB/3K1NbpvtH5mNSaotzfiQZxalaKXvr6KzKbqDfWt77RotVAQLp8NVF
         P8y5VZdg4i4kKjxJbw7c0Hh/Rtstkj8T2aEa8WkaBG8bHTjPBwZYj8z869tDSNzzXqMc
         2up/2xrt3kWnHbf6/erVRkaXzN8GsGGFOlMHI2Szl4oBmDYHoK4B4uPX6pbXTho//M18
         U6inF9sPg7Y+pVQ9XLDzBdLUgp03vo17evrokRV0piHrdaFsGwBsJiBwTe4f3KXF4bmy
         I0iBraR0NDoJz5uf66JUo2qDfm6GANN5CZrCkzlsGBsrq4OZzzl22MgU7sjkK8v9I91V
         SWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772474601; x=1773079401;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDw0uXWTdhdXPY/VLpgjETo3RvClLNelJGQAl71X0UI=;
        b=jKr5hDq5LBRN9rhPsIOpWC6KJOYYd7hygnay5CSPx1cCy8c4Fpguepb10ewyVrLDDw
         KADxHj+KaOjpA7ExtITFH6AD9najP3QskmVSn7JJJkNoCa93aIGk6yLrpoMj57f4vn9D
         8fjTETSt/zdA1Df8T9eZ3Io8MtpAoDtJI4S++NNfhJkxW2mxxzoKeY9JcQBnFaLDfCy/
         MqVHyGmI5boo2ksrZqBTY9cA9vQvLsnY8ai4YGTd8Na3TaZnKRgMxxwiEhP9/C2i394a
         Cu/AT6rk3TInle1fEtZNQQ/kt42As4rFRyaatnbfm6KuyMRvcLVIUViKSSlAbUoSf1yO
         FULw==
X-Forwarded-Encrypted: i=1; AJvYcCVtmqEZjcYm4uH4T2XMNGv6NsgziarT8OH9sYyERRUOh1TjoA6lZ6P7QNekD1LTaXjwogw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItAvkvbIPvwzsIYsTjcaiSqP/8yckfQLHxDKfWdEp5hmD5wNr
	RBprkW7q9aDEB2kV+0eyED48tAcx3SscesBk6fo4BzWR/GPG83BE3Mw/
X-Gm-Gg: ATEYQzyS90bW6eQo/b58p1gCwmXRUNnYiSkatAVpc2hwspEBm9TOPWN8qLYd4eGcazu
	sS2NYj0qSM0Wh6BqyWDrPIaxzdIffPVCXrLMxUO1wu29WJ2DH3x5ibmLfZ1CGMuAGwnus8IP456
	X/Cvn9PXrHI8bRMXJPMjufeIkPb/8Nzn/50JFgatslkMP8H6teCvoixSLY7oMlPfY1NcCLLZvZx
	YMsXKqIBqABqJDf2Mc+d+qYc9NhxkwemU5L4FIUjZf+RdtN04H0UAX1uJNG1ooWnOlclL+89KZi
	0jKlEFC7k6zR6XV/JOAI8QB9Cr/dL0TGhSFOOHX8K76QW/Ol8ooqwffkSLsNZM1Kqrc7++ZTs21
	VUAXXLVevpDWMeoCHMLCY+SHfvuZTTP9Yftq78nTZ+aVpt7G6Xoal6twt3C4XXzHEwcQGFbX27J
	PNYVrz01RFyGAnRS1fgbfd45oYZEz0Ad1eRX8VcKC/8J2qew56oaXAV5jIT4DbFS0Wf4w/Vs30M
	8a6ZwQ=
X-Received: by 2002:a17:903:41cb:b0:2ad:9421:613c with SMTP id d9443c01a7336-2ae2e400d0fmr113306435ad.21.1772474600447;
        Mon, 02 Mar 2026 10:03:20 -0800 (PST)
Received: from ?IPV6:2401:4900:6336:2198:13bf:d9bb:7f7:8dd3? ([2401:4900:6336:2198:13bf:d9bb:7f7:8dd3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739ff1a69sm13152887b3a.34.2026.03.02.10.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 10:03:20 -0800 (PST)
Message-ID: <8bf53293-f2cb-4780-9ece-a77f32f485d7@gmail.com>
Date: Mon, 2 Mar 2026 23:33:13 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Editing GSoC Project Ideas
To: Christian Couder <christian.couder@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
 Git Mailing List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
References: <c67066fb-f857-4738-a3a2-53108c57456a@gmail.com>
 <CAP8UFD2Q7gctwzGOe+rbgdXZSbDbV0dmM-cx4qt_d8nKi88=HA@mail.gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <CAP8UFD2Q7gctwzGOe+rbgdXZSbDbV0dmM-cx4qt_d8nKi88=HA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+Cc Stolee

Hi Phillip,

On 02/03/26 03:48, Christian Couder wrote:
> 
> On Sun, Mar 1, 2026 at 3:26 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> I'd be very grateful if someone with write access could please update
>> the description of "Refactoring in order to reduce Git’s global state"
>> [1] to stop recommending moving settings from `environment.c` into
>> `struct repository_settings`. That struct was originally added to hold
>> config settings that were already lazily parsed. We've had a number of
>> submissions that move eagerly parsed config settings into that struct
>> where an invalid config setting causes git to start dying in unexpected
>> places when the lazy parsing fails.
> 
> Yes, we should definitely update the description. Thanks for telling
> us about this.
>

Indeed. Thank you for the suggestion. We've tried to tweak the 
description accordingly. Kindly check and let us know if it still needs 
any tweaks:

   https://git.github.io/SoC-2026-Ideas/

>> I haven't been following Stolee's work [3] on "git conifg list --type"
>> closely but I think it introduces some functions to parse config
>> settings gently. Those functions might enable us to parse some config
>> settings lazy where the functions using the lazily parsed settings are
>> already set up to return a error. Doing that would require careful
>> analysis and should not be a blanket recommendation.
> 
> I haven't followed Stolee's work either, but I will take a look.
> Thanks for the pointer.
>

I've not yet mentioned stolee's work in the tweak as it is a work in 
progress. I'll leave it for a future enhancement in case it is really 
worth mentioning the same.

> In the meantime, if you have concrete suggestions for change you can
> submit one or more PRs to the https://github.com/git/git.github.io/
> repo.
> 

Just to add to this, any patches via mailing-list are also welcome if 
that's preferred :-)

--
Sivaraam

