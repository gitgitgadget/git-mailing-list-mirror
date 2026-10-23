Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792739722;
	b=bfMLElRvft24Rc6XIVAXiQ4j7nG7cimryMzSzMAKK6i5QOifDWcdla+afJ29MpcJieUF
	 ShJGkxkCBSJKVqftL6tHDUj4IEU4f/PbscggXuIoxec3UfgvsoXTJwzbn0tGe+5PCOqgq
	 QHEQQ6fX/3ZYLGWVCZ/QFcIc70Gt06dH6OAEqA+lz3dV3Vx/u33FPoqSc0nLK1bHBvzd0
	 U5P6ZwldurH8Cj71uH7A3AKPElEkZWWSjSZr431FNdSevmVTjT6FAQNzG2/qZi5wwbQ0L
	 FFNmiLbu/lvuquZ34q43FtX79xxjaZuLWNU5/c+H8OVOKaqSPomW/CshAFixVjcqgtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792739722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gRqUucWe5ysqlElFk+IgvTutDeyuFWZcAQo3UGv4nwY=;
	b=mOzEFpGvZQPCksGWl2mgqOHqKgFyKS6kFKDIK+AJRJvjEyAPP2N8lp6ZkdM7mSZmxW0l
	 fyIwPguI2/nabXu9Br7djCYEIZOasuNkUfFOwhVvcXf73K/gtAKfHITP1U9FJTkbM27ZD
	 C8RQa+Sn2npPSNk1sJGpCvnJC/rztnWXHEHsh5Bc/LpDx973MFiKtEOxQZg7BN8hASotg
	 tsajDSAvcd0VlXxhvuPa7mGmbTcHKF6XQcqKNvcU/RovyWnfNtkSg35tz6mS9Ys2CxIB2
	 S8TaLyo5r3gXaihPAxoKkWqQAUg+MU9rlJKlm4dRV4bqNVKTMh+x7/u14jhqBTIoxHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=poZ0iBqi;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D545B606A31E
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:15:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D545B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=poZ0iBqi
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac9f49b984so328791a91.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792739721; x=1793344521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gRqUucWe5ysqlElFk+IgvTutDeyuFWZcAQo3UGv4nwY=;
        b=poZ0iBqiUxXZtTtfCyEQbIGWgOYDhVL1fgc8s7jUa9PnY4HoEINCGY33nKdhvGrbYN
         UcRqVQtcylvVLQKIW4Ot39jXX9dLedfcrbB8zmkJUtwQ6znoZuWFVO+5JnZVuDDsuBZh
         +F2KP32KFrJbm0iWtp57Djsi7edor9S/7D+sQLLLSQZ8wU0wFE1w5UqcvMEg6ggvYNHO
         T3CdtiAiM5l0vSZp7fe6oYlf5BTdue4bX038zclEdMbqhk9e4B/Q7O0B35bQcOxWEXGd
         MzEYjbDKR6KLBOsoLI7lkSTi13Yzk0c9PSrBkGp+hDK7Okuvzl2C9dl/SPIWiND9Ik2V
         HnWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792739721; x=1793344521;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gRqUucWe5ysqlElFk+IgvTutDeyuFWZcAQo3UGv4nwY=;
        b=mUH1IupC2+5AAos90aWI51FDE9F4G1/yf4ZO3+ibVrSEOihScrbGwtpu6v9j39B5th
         d5KtxCmS9a1TrabNexXN6DAC5bgmzRpD9+s1CBhtFAeFgGouWWwaUEq+T0CxbBUNE//x
         affSryAkm91OMUB/5nQ63cVQQxPuurar8IJ6pCqXGIsDbqkgxvtjKU7f+cnCU8rESCCG
         PA2yIw+V5zWei6zgeiBHq0qdR0XOexSCLBeLndT9H5dGQCrfAgrC1DWmFENhnpMTcQXE
         B9XJix/s4r9HT3gTdEpHPCCKl6JkStfNCbRZzS5VgckxrHMo7WutpaG/zNaFJIR3RJuF
         xOPg==
X-Gm-Message-State: AFq9FYJLW+qk6o4kPS8rEveXHmy1TiWQGVX6y9qRSN05sHu4sR1FiAa1
	Ut8viW+aNeYEkCc2zJcV6+VDwm1JINtcwe2hbuaBWi1pVMv71abhkXgvoaZWrg==
X-Gm-Gg: AYBFou3OXrC0qDWmXU63QsrIt82wX6cU+H5jKpGu1xEO+L9PVElPqd+IZ8na9xivi/p
	8CMqBEUkoW8fIaIASUudauCwFzIbV7GMIWCY1ua13B8LhPxdlwXz05vSQSvpAJORW0lSo0Swsu+
	QT8jA8J5mO7wLbMpHDS1/QR6vPWZ8m/MfQ7qZsBk+/bhb/amSwey41SLZUxxMRl7gJ/AIbI75me
	UYIbJnjzJGCztswPv1zBM+Qg542CqdXUO0y6uwO4XyPFMMlTcyB51aMtg69lazFw6+QnpgsYiJE
	ulN1hM6CX6JS1bLhXBuKoC6eLPAKv4tvvdiNLL00c5hA57k5MCfv7zonJupXC1pTSFpagSUqM33
	OzUZbMQWH50ba45Wub1XML3+dD4wGZlF+i0XmbM0RQNl/KAddwuUhQ0BZptUwEbZJfo+gdI9UAo
	GJ1FDdl2ESkfKfklSS0RjFuDyk/1QV1eyufqahMe455QAUvJRrjIhqsw2yXf7eMe9BVXyP3pvKJ
	gKFvwuzBHzh21iK3Cw90D2+I7v24IBG4Ct+jtTZAofPnHW12keCJACQRPHNQQeUjZBhLwyMTxb9
	wPka1nEpYvFuFTo9uSlKEMbXwiGDYGYn4fU=
X-Received: by 2002:a17:90b:39b0:b0:3a0:c31d:80c with SMTP id 98e67ed59e1d1-3adce6001e3mr796882a91.9.1792739720919;
        Fri, 23 Oct 2026 00:15:20 -0700 (PDT)
Received: from ?IPV6:2406:7400:12b:64c0:b6fd:f107:8ea8:9e90? ([2406:7400:12b:64c0:b6fd:f107:8ea8:9e90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada47f8ff1sm7755506a91.0.2026.10.23.00.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 00:15:20 -0700 (PDT)
Message-ID: <57e42fb9-b60d-43d5-abef-432ddf8da34d@gmail.com>
Date: Fri, 23 Oct 2026 12:45:16 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] unit-tests: ignore --long-tests
To: Patrick Steinhardt <ps@pks.im>
Cc: Git mailing list <git@vger.kernel.org>
References: <20261022-ks-unit-tests-ignore-long-tests-v1-0-554a590d418b@gmail.com>
 <20261022-ks-unit-tests-ignore-long-tests-v1-2-554a590d418b@gmail.com>
 <atsDvfHx3_EkrI6Z@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <atsDvfHx3_EkrI6Z@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 12:20, Patrick Steinhardt wrote:
>>
>>    $ meson test -v --test-args='-ilx'
>>
>> So, ignore -l / --long-tests in our clar tests.
> 
> TIL, I didn't even know we had this switch to run long tests. That makes
> me wonder whether we should have an "--features-testbed" switch to make
> it easy to run tests same as our CI job that sets all those test
> variables, and then adapt CI to use it. It's always a pain to specify
> all of these environment variables.
> 

That would indeed be a good addition! It may help us easily emulate the 
feature-testbed job locally. I say "easy" hoping it does not need any 
kind of additional niche dependency in order to run locally. It seems so 
on taking a quick look at the the CI script :-)

> That's of course outside of the scope of this patch series, but I've got
> a pending series where I may be able to squeeze this into.
> 

Cool!

>> This does not show up as a problem while running our CI as we enable
>> the expensive prerequiiste via the GIT_TEST_LONG env variable.
> 
> s/prerequiiste/prerequisite/
>

Good catch. Will fix this!
>> diff --git a/t/unit-tests/unit-test.c b/t/unit-tests/unit-test.c
>> index d066c8a4c8..06ffd0f5bb 100644
>> --- a/t/unit-tests/unit-test.c
>> +++ b/t/unit-tests/unit-test.c
>> @@ -28,6 +28,7 @@ int cmd_main(int argc, const char **argv)
>>   		 */
>>   		OPT_NOOP_NOARG('d', "debug"),
>>   		OPT_NOOP_NOARG(0, "github-workflow-markup"),
>> +		OPT_NOOP_NOARG('l', "long-tests"),
>>   		OPT_NOOP_NOARG(0, "no-bin-wrappers"),
>>   		OPT_NOOP_ARG(0, "no-chain-lint"),
>>   		OPT_NOOP_ARG(0, "root"),
> 
> Looks obviously good to me, thanks!
>

Thanks for the prompt review!

-- 
Sivaraam

