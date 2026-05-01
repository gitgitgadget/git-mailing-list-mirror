Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5CE16CD33
	for <git@vger.kernel.org>; Fri,  1 May 2026 13:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777641558; cv=none; b=JoJdEyT3pschP75c7KoS9BBBiL9tNrIVHyfnE1nSLkitgLRGhHZp2s5LevIYvn0xKtTYYsgD2TpOX00LySuZlSNXIH00IhzUnlFHqd7fbuYiWzrQm8Ng5OPFSkR9wDArvw55lGDYk4VRVs6Nq9JdsH1GO/mjg/JBAsHugvxPQag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777641558; c=relaxed/simple;
	bh=nUERPp2rkPxlVOvl50ktIyrWGZhFKCMtMzKC8E814mA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dW4TkjgwWamf3v8RB27rUqSR5ec1DquyBic2EGlylXG/iR4Ps9k39stACPxp6pEQDiCCYpOGvEvSN/2tXVROQD7ZAkO7mSojd6NmpaNCel385wc1LdbQEuGLPUVZAhpHrTcVXl3WmJDIEWotXj3P8irTbzPCdxtVYCxag0KZOyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdJGBc9O; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdJGBc9O"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50faf8ed9c5so9096651cf.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 06:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777641556; x=1778246356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5+M0BX3xA8aftjk6v41TgQrYCcEsTbjkLE6TNcZ3is4=;
        b=LdJGBc9OGvrMKgcc0ji3E+ZRpAoU8o4Kt66y0ul60TjcTy/aK1Ko8M5nUSZRBUASmF
         40GJcGThp1Flu2I6uW5H1oYUnfjfLY0Fx5kT7dNn1u/EqZEARxrBt+BxSE0RbTzsKJBn
         aAVFD8uZTYm8JNVgXhxoGxCsZEKv8/UoihahOx06xDXSLFwZ+hkP+Z0aHxLpj6p/xsCv
         zYVj1b+I57kSs6sjrHRHoyb/RW2QcG7vwXMS+2y9iY5c9rgMlsKf5vnT4KIjjwRZr89h
         o6nug43mlcYpG86SeguIlbWFyRRRmXOyKOhGke8gE07RvOp8gis5HBUieM0MSjZY4CkU
         Osrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777641556; x=1778246356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5+M0BX3xA8aftjk6v41TgQrYCcEsTbjkLE6TNcZ3is4=;
        b=kMjuiYpCgFXObxdiQMlK0o4nsTsaB2G60yTsfoTrvnAjOT2iGlF5/YZm8Wr1Tmklef
         6UZlb1J3owIrlfOrzqSLPOLFtMTzmFndu+Ct/BdEWHELPfba8MzLENdiil91UANvGRIF
         +Pxi77iD9OfxS8P9xelIqR1RY3pVU1NoSi89bhay0c/2B9r1yg/yXGMQTSIolWxU5Fft
         gSraODd3hYi76ldTtwlO+q/97dC6mmM+SmA0agKInkxtGQdxMtkmA93NfFJOECTBq4y2
         uBKUJ7LMiPFax0LD0ztIJUhFuyg6qeY1L44ZeJu/C2XeNlZBf3KecdwVgynj0hboC2HO
         1fAw==
X-Forwarded-Encrypted: i=1; AFNElJ/SJF/BXi7gt2azsX61X8LOXCV6ytaHPOEYwMYMH1uvskKowtpseHBONnwVBE6dgC4V0jU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywubm5T6CjWActkJuGDwgtrlrGfA5WQqigZifyY1xL5sjHkVePe
	L5fHTTotf1k12hDcdK19LJE1CVVkNQGVA2deFj/vnDqIm7P3MM6jv6ra
X-Gm-Gg: AeBDieuus35bTQeiJ67xKXdvWVrsgNgefsFMA5BdZ33kBH4bpoVMqwIw9CwFjb/c1NJ
	aYA9i71xXrnaRugRU8p1+UX0ZQbWRtQcjyiB2Q2asWWZwSkgAAc2e1COW70/w4pxdXmbBE5RFDY
	HnF+tJRhe5eCZWGqGNEvLmc2zAONQ+bqkokh1VWw2SaOv2ze0Q0nfTC1Jsxugez0tXHQjxj4yMO
	dnIEmlzhokvXgy4v7veaA1w77Bp3w741l8H1INrBi6lOIenYjmt9aMXfM7QMhQJUja0DWATGnoI
	CIeGul+ss9LgnYx8AXcFZuWbmQ5Q9pEaZnvo0hOwMfM+l6VJTn+xLQJYzQ+A8aBw9Z+cd6kt18W
	ASFCJKN8GzRmJYPp42TzrsZVR4CoFAIiP11z47DxR4+coLW77YOUyWA9VCZZe+CSHJv88Cy3sYN
	nfoArjaeXhgJwrvA1Gju23xNDteGkwwznm0oHMQBasgk6e/qLM2cf5m/715aksJ8j56PeXSs3ez
	RpVpR5t
X-Received: by 2002:ac8:5c88:0:b0:50e:5ffd:dec2 with SMTP id d75a77b69052e-5102ab1bf61mr111387421cf.1.1777641555887;
        Fri, 01 May 2026 06:19:15 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-510416dfc75sm13868751cf.3.2026.05.01.06.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 06:19:15 -0700 (PDT)
Message-ID: <ed226571-a095-456b-9d9e-bcc545d7ddfb@gmail.com>
Date: Fri, 1 May 2026 09:19:14 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] t5608: add regression test for >4GB object clone
To: Jeff King <peff@peff.net>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <a3019888d8465e0f77926a91a20db170fef6989d.1777393580.git.gitgitgadget@gmail.com>
 <e1e8837f-7374-4079-ba87-ab95dd156e33@gmail.com>
 <20260501063805.GA2038915@coredump.intra.peff.net>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20260501063805.GA2038915@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/2026 2:38 AM, Jeff King wrote:
> On Wed, Apr 29, 2026 at 09:34:21AM -0400, Derrick Stolee wrote:

>>> +test_expect_success SIZE_T_IS_64BIT 'set up repo with >4GB object' '
>>
>> Your prereq here prevents it from running on 32-bit builds, which is
>> good. However, I wonder if it would be worth also specifying these
>> tests as expensive. It's less likely that these layers will be touched
>> often, so it should be enough to run these on major occasions, such as
>> testing a release candidate.
> 
> I think it is already skipped in most cases, because t5608 requires the
> GIT_TEST_CLONE_2GB environment variable be set. Arguably it should just
> be using EXPENSIVE, too, as I do not think there is much value in having
> individual flags for all of the expensive tests. I think that test just
> predates the modern prereq system entirely.

Thanks for the extra details here! That helps avoid the issues that I
was thinking about, but maybe doubling-down and adding EXPENSIVE is
still worth it. 
>> I suppose this also is a question for Junio and our process for
>> validating releases. Do we have a certain cadence where we run the
>> expensive tests? What has been our threshold for hiding a test case
>> behind the expensive label?
> 
> AFAIK the labeling of expensive things is mostly ad-hoc, and nobody is
> systematically running them. Likewise for the t/perf tests, which are
> super expensive but do (very occasionally) turn up interesting
> regressions.
I used to be more diligent about running the performance tests myself
around release windows. The EXPENSIVE tests would also be good to do
on rc0. I will contemplate how to put this into my routine.

Thanks,
-Stolee

