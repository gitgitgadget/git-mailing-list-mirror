Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3A21A0BF2
	for <git@vger.kernel.org>; Tue,  3 Sep 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725356886; cv=none; b=Nf1h7cm5xqep6RtXu09WwpPeCSXj4rPs7wo5kTIe+DSQp38RbOb+g7MzGSC1AC1phaX/Tvyf65oB2RR2follQlmvakxpuVcS+Ns9UWBtJmXXlFtUOAkd45EOwck87H3e/tY3UsWMboo5n/ia4IUum9Ci8u5Xiizi3si0Kh4Uyas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725356886; c=relaxed/simple;
	bh=hJk68djd+blsdCrN5kBgaG6L39I78d5MAdVir43Hv+Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bxDn61nOD1QbSRi6ioNA5dTBBxNVshHKgdYCJTpdeeaFXjH+r3XkGJNj+lW0if5BbmNBqGXfy+Lm54M0GOUjwPzXzIjKAmyXBJjSzRsLiUVOfFY5tZ9aOsl4yLH0bUC/bboJfqo2q+kYC7BdpTDz3Y/8L2nYhWQP5aq/88Rrsig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dWsA7TkL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dWsA7TkL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c241feb80dso5504084a12.0
        for <git@vger.kernel.org>; Tue, 03 Sep 2024 02:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725356883; x=1725961683; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=77g8QVpytjR8UOaSwumnI8AMyxiogbLCWCM57o9eips=;
        b=dWsA7TkLTtUgUVZZOnA9xPc0A1+XUZTZrcMahkBZRwOijNrmXH3aBzLYYs+yhxXNzT
         i/nVvYXUss3W+9hxKGa0TEpcLy2Elz2MIUz1c5J339DeSLtX6/oY3Kw+TbUpaA60xWBK
         09Rsw7qe53EzOEttsCHL/l7tjInszrIXMMYmTXdOaMlP06mcVldGC6vHigL5pOW6jwYl
         RgzJOHyfQFttGYI/NYw8/gv+S6DrOlr5miDDiihX4tncvtqB/C4epX/SYWQynOq3Hvcj
         EToUB28TzB30WvDwCPYbkZWQGoma1w/JQRyXvA5H611gsVOGHDdwAad3wF1mUVZBBwgD
         z7rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725356883; x=1725961683;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77g8QVpytjR8UOaSwumnI8AMyxiogbLCWCM57o9eips=;
        b=YYd08FJj0i/R7FgkvfZG9jKl6Ic+PfH/XsFijWn7+qWY1JOPTe2g83jhDM7TI36O/S
         rBbYczbXMJZHEVmuHlnqVZiak4XaKKzfvtKqhjOd/1DRLl3/6m9Yn7gK0/mbi/x8aObq
         RBy4i5DZC3BvJuQZGRk/XsS9BwiTUcn2vW+Et/PGPt7QyMruW6PXED4bGuacRgvt7LvK
         /P82gOvp6SpYAWhZhfhdBWn2Krvij1q4z/5tKvSKYHIaTRwlBdR8ILfJ4LM5JVxitUGI
         yrId/QvVfuXaSPFfL8myJRCXKZebU3x5jCdLe0mwOjFY1NQCdevCzAknDknI0EBaFJ/7
         AjDw==
X-Gm-Message-State: AOJu0YyaJOIQeO1pu2ig0Yya2SGDplYCkwzSjagp7iKWFOQOIAWt9Lwz
	99hobUBQA9uGn/i++12VuIidqC6c8MuC8+3Jb5ZxQdRLiZI5JSJN
X-Google-Smtp-Source: AGHT+IHvz6TYK/1tquI0orGQMZIQTIf2iPNH+z6OlXKwMJhCQypN45BaWBxOlNyYkYqfZR+5cKepZw==
X-Received: by 2002:a17:907:6d11:b0:a86:9ff9:6768 with SMTP id a640c23a62f3a-a89827a401bmr1741559766b.22.1725356882711;
        Tue, 03 Sep 2024 02:48:02 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d6f16sm659096466b.150.2024.09.03.02.48.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2024 02:48:02 -0700 (PDT)
Message-ID: <3be1d990-9f9c-4963-bce3-742511b79022@gmail.com>
Date: Tue, 3 Sep 2024 10:48:01 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v6 11/13] t/unit-tests: convert strvec tests to use clar
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Junio C Hamano <gitster@pobox.com>, Kyle Lippincott <spectral@google.com>,
 Josh Steadmon <steadmon@google.com>, rsbecker@nexbridge.com,
 Edward Thomson <ethomson@edwardthomson.com>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <cover.1722415748.git.ps@pks.im> <cover.1724159966.git.ps@pks.im>
 <b3b8df048725c25b14860513b7950b158a6990ea.1724159966.git.ps@pks.im>
 <c6f13f6b-7899-4bbd-986a-9bb1649b214f@gmail.com> <Zta-nU4UMyrWgABW@tanuki>
Content-Language: en-US
In-Reply-To: <Zta-nU4UMyrWgABW@tanuki>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 03/09/2024 08:45, Patrick Steinhardt wrote:
> On Wed, Aug 28, 2024 at 02:17:05PM +0100, Phillip Wood wrote:
>> Hi Patrick
>>
>> On 20/08/2024 15:02, Patrick Steinhardt wrote:
>> It might be a good opportunity to show the set-up and tear-down facilities
>> in clar as well instead of repeating the initialization in each test.
> 
> I don't think it's a good fit here, as setup and teardown would hit the
> system under test. I rather think they should be used in cases where you
> e.g. always have to setup a repository for your tests.

I'm not sure I follow. I was suggesting we define 
test_strvec__initialize() to initialize a global strvec which the tests 
use and is then freed by test_strvec__cleanup() like the tests/adding.c 
example the clar's README.md. That would allow use to remove the setup 
and teardown from each test. As I understand it clar's setup/cleanup 
functionality is usable without setting up a sandbox directory for each 
test.

I'll take a look at v7 in the next few days - I suspect we're getting to 
the point where it's ready to be merged.

Best Wishes

Phillip

> Patrick
