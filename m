Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC0F3612D
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 09:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725442272; cv=none; b=E6D+iqCItn4rpMP4wQAR831gFtl81/sunZySPdbp8jQn+auyihQyUkzkXhSu7GGDwcryI2b3tz7AEebI+h8RdQLDyBoYIpI0+FqVd3fetImcoGsvPGC9JKRtuAxyEsVtYmprjKMKS92SXUANMnHd39AkiHKf4vI6y94M6OIKpxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725442272; c=relaxed/simple;
	bh=tru4x7cUzk4CgKU6GYiEUpzY9/yOTsUFEzyDwZhkVmQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ANFQa2w4bi5HgYip9sGkGwF3zbV1xreBJrQyETXvGm2GIcF7vjBTTQyvZQwsE7viR6dw5XwkCrM7mbz/zsftC1vMyyihLcY1NcMTM6QbMLeGtbwV4t3iIm7e3j3afkNGKjb4RLNbQu6eR3/ybk+eUxvL7qzC3s+Sr585NoyyjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cs+SQ6Na; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cs+SQ6Na"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a86883231b4so774659266b.3
        for <git@vger.kernel.org>; Wed, 04 Sep 2024 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725442269; x=1726047069; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=26H6HC2DDkjprJZdbz24BbJNZxagHBj9UrsrLQ/zmec=;
        b=Cs+SQ6NaD2yzM2nA6U7MsvDeYXXpj7VmQPgP1ean0secxG+eu5CzH1bbcKdTeLH/P9
         V8H8G+ypvmYDd/iludyqm8nROW/HZGIFqCRgNWUVkpqbjwYrIVL5OZIu0qRJRCcTWSlH
         hnCfzi2LnW9/PhMLqGE14RjE/mzXY4YPXV8uFNkLmc04Hf7HfbdHd/6H287b9T0+9TeB
         gpybjjKWYS9Z7W5EkFr9NpHyY/JjuQ29zEzvbVsSvS6LFif2oGGxZIsEgDeXx3nlo+KH
         SoSocL0t5fZu8yXS/K6UjHa4yjpOgZY6Mj2NBR2tMuYJWZf5vgtqCcoWhRLh+qPYzZTB
         rOTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725442269; x=1726047069;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=26H6HC2DDkjprJZdbz24BbJNZxagHBj9UrsrLQ/zmec=;
        b=uDwcwmfxIJyAUjpJGc4BAzOzckJHW+A+hyhWEOhCoRKWPkQoXwNyFyfn7RPsjA6wpi
         T2rbHSjMbkxfvsbdhiQe2qT4FBvMQ/wepJDy+4omUmnn6P8QrzPyvuhPKe/9PadRVzf/
         xiF/gFtJY4w9tTjWSd0EC9WuHylGbIKDe/rGINtqrwE21Ud0eeb9lED94j1ru3X7DXFf
         ja7voqm3PfI7m/RzYHMRGqWUNOXIgMiiXJ0/4RO9cqQ+nCFnQj3FVEfYbjl6HRQXI2eG
         bXqDMH9RcpF7fTwDtT6KGhluCUwnvVQwbgUyF4ErLB+o5jugyJfZVW2xzUiqL7aXq3gP
         xgKQ==
X-Gm-Message-State: AOJu0Yw4BR2e4mYngvS1Kco2fq4McQm/sSUfOZw22XnYCZ7CD0BWYWLP
	sV8Edjw5rQ4yr8Gjnp1rreoXCxkIQh1twvIDj5+6ThIBCg1K06vb
X-Google-Smtp-Source: AGHT+IFqGJk0EM+EUA3rIL/egYx8xya+lgukJK6PD3iXJwSFDQZtCtotMuffGJEjlqV2gWvseL7gMA==
X-Received: by 2002:a17:907:36c5:b0:a86:6968:3b93 with SMTP id a640c23a62f3a-a89d879c32dmr890182266b.33.1725442268412;
        Wed, 04 Sep 2024 02:31:08 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9? ([2a0a:ef40:6d3:8001:7151:e3a9:f71b:e7d9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a89891d71b4sm786191466b.160.2024.09.04.02.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 02:31:08 -0700 (PDT)
Message-ID: <33243592-1342-4a11-a592-63b35b0abe9d@gmail.com>
Date: Wed, 4 Sep 2024 10:31:06 +0100
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
 <3be1d990-9f9c-4963-bce3-742511b79022@gmail.com> <ZtgAJFSXn2M252ZY@pks.im>
Content-Language: en-US
In-Reply-To: <ZtgAJFSXn2M252ZY@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2024 07:37, Patrick Steinhardt wrote:
> On Tue, Sep 03, 2024 at 10:48:01AM +0100, phillip.wood123@gmail.com wrote:
>> On 03/09/2024 08:45, Patrick Steinhardt wrote:
>>> On Wed, Aug 28, 2024 at 02:17:05PM +0100, Phillip Wood wrote:
>>>> On 20/08/2024 15:02, Patrick Steinhardt wrote:
>>>> It might be a good opportunity to show the set-up and tear-down facilities
>>>> in clar as well instead of repeating the initialization in each test.
>>>
>>> I don't think it's a good fit here, as setup and teardown would hit the
>>> system under test. I rather think they should be used in cases where you
>>> e.g. always have to setup a repository for your tests.
>>
>> I'm not sure I follow. I was suggesting we define test_strvec__initialize()
>> to initialize a global strvec which the tests use and is then freed by
>> test_strvec__cleanup() like the tests/adding.c example the clar's README.md.
>> That would allow use to remove the setup and teardown from each test. As I
>> understand it clar's setup/cleanup functionality is usable without setting
>> up a sandbox directory for each test.
> 
> What I'm saying is that `strvec_init()` itself is part of the system
> under test,

Oh, I see - I'd misunderstood what you meant by "system under test"

> so evicting that into a `__initialize()` function doesn't
> quite make sense to me. If there was for example a bug somewhere in the
> strvec code we might bring the global `struct strvec` into a state that
> is completely unusable, and thus all subsequent tests would fail. We
> could of course work around that by always zeroing out the struct, but
> because of that I just don't think it's a good fit.

Isn't the point of strvec_init() to ensure that the `struct strvec` 
passed to it is usable? If it does not do that then having all the tests 
fail is good as it tells us there is a bug. I was hoping that 
__initialize() would be a useful replacement for the

	TEST(setup(test_fn()), "description")

pattern in some of our existing tests. I find hoisting the common 
initialization and cleanup out of each tests makes them easier to review 
as I can review the setup code once and not worry about it when 
reviewing each test. It also avoids a lot of repetition when writing 
tests and keeps the test bodies concise.

> I rather see the usefulness of `__initialize()` in setting up auxiliary
> data structures that are a dependency of the system under test, but
> which are not the system under test itself.

That's certainly a good use for them

Best Wishes

Phillip

>> I'll take a look at v7 in the next few days - I suspect we're getting to the
>> point where it's ready to be merged.
> 
> Thanks!
