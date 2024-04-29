Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF06839FD
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420038; cv=none; b=I0aqVNXFlCzZ6b3NiwvKR2n1WMk5KP9tTamy/6uOLG2su4l7S6zryZDgjffvvgQbCjZaxN70GjIvIq7e5d/k7mHRiEOIOaz7yozABMR3I0tkq2Qx1HrCzYEZUHGb9SOPpVMsZFZmxDodlvgdhwok2qqKfBhtlAEKIHRNYmfXFWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420038; c=relaxed/simple;
	bh=XZZmVdSdyt+/pRGmYGOI2uoaUEr4YQras96+1xCPaLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwOSkjjQpVCJ+A10KI/9Ol8a7FRVbfvfL3ra2wXWcQr1ABy9altMDjAWMnSvTWcpIOIOKeAkzcFx/0DCCcLYjJybR5j7MEk518Igplfe0sP+Wb/TLueOqh7ineXgVO20kmreNidBR8Qx+jPeUJSjnY3Oyb7xk/vt9tm4nq5wr00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqNO65u9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqNO65u9"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-343c2f5b50fso3206303f8f.2
        for <git@vger.kernel.org>; Mon, 29 Apr 2024 12:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714420035; x=1715024835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uVS3rhrgAvQrzgrq0UGM2MBZIK6sJQqTH20LIRRpeYI=;
        b=IqNO65u9px88lRzsSOZ1SIBS0fw3rXAiRmkIqh0DwQBHc1nKhPkTGNspcOLRauIQk+
         sL8fzIS0APBW1ocAIvdzlAeoDE8rff7ig4nh5dMxg05jpJ5gl+GDqnFYMkLKqXBtqxca
         /8dNIh4nXSXNjLzIPOsuVR+yepeBUSsgeK2rwwVHJ0ERzrGt4nza9nr0HzjyG7nVhZll
         O3StTBzOu1g6uuOUu+faP8kv4ZAhmFwnrZ4R6iRUTf6rBxttdSxL1cOYM/t0Cf5Hq5uf
         S5XczaoBt2nKscaPGeAjIjZ0TVt3PADIFwjf8E+vrAGE/nCk6KYrMXSYTbhziQt27F3X
         6m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420035; x=1715024835;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVS3rhrgAvQrzgrq0UGM2MBZIK6sJQqTH20LIRRpeYI=;
        b=rTH48PbYpvGQcFq+c0VsMe3S5OZqcOMM4s49eJpLhCYrZxhoZxczm7HEqccImgpPTR
         0fTsdozEfTvFNn844aRGJIihjQrgaCVr7eYo2doM7ocj2b7iTSMhPpgHTW7OCfoYvAsT
         5fYRwxSDOq66IaVggAm8q3E57O0y9nDEg5LkijMb8PU/0Bx3buSlukhA8R3YoopcFLUP
         CSZjMYKDvy3SY5d1qg5Jt8HGtv4fcTxTP3vw25d/0vZGaaDi8t/7t0Sci139A5EP15Qv
         c1H0MfQvuj3yTVcZtdQ+UUWmvq9KemoXW81yIpGMC37WRaq9y6hIUMUT7GV253mtfnux
         ++lg==
X-Forwarded-Encrypted: i=1; AJvYcCWkETg9FjGTBaK1pD03GlYajbxFi9h3+ER6fTkmG+ZQbHbOSnngp22FSck8DrOWU4/1oMkrxmidVBgk/sAnoSu35ACD
X-Gm-Message-State: AOJu0YyaHiyNQ1I2VuBJRTrgICW5hVixupyQQmQkFhDyJIulKKvef3LM
	1FGo9k4Rxl9aSb4ZfJL3qmH3cn7HJW3zdjsebAg57BYNAllUfgxD
X-Google-Smtp-Source: AGHT+IHVupJ5arj6g2EybAxBWjiq5Q45VDBqj4waMXyD7CjnFQVvpteqqbnhWyhIohUz5sCKP9bAPw==
X-Received: by 2002:a5d:550c:0:b0:34c:a5bc:17a3 with SMTP id b12-20020a5d550c000000b0034ca5bc17a3mr5069369wrv.16.1714420034911;
        Mon, 29 Apr 2024 12:47:14 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:64f:8e01:7cd2:1ad2:b4af:7cb4? ([2a0a:ef40:64f:8e01:7cd2:1ad2:b4af:7cb4])
        by smtp.gmail.com with ESMTPSA id b8-20020adfe308000000b003436a3cae6dsm30287903wrj.98.2024.04.29.12.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 12:47:14 -0700 (PDT)
Message-ID: <b43e51d0-2814-4800-b8d5-cea5f79ce318@gmail.com>
Date: Mon, 29 Apr 2024 20:47:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] refs: fix segfault in `is_pseudoref()` when ref
 cannot be resolved
To: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
References: <cover.1714398019.git.ps@pks.im>
 <88822afe950318c0312de5541a411942a163b139.1714398019.git.ps@pks.im>
 <CAOLa=ZTCCgtQiQbm_GU--1+Yq-qYJANzTvRmvVrqNmzchkVevw@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAOLa=ZTCCgtQiQbm_GU--1+Yq-qYJANzTvRmvVrqNmzchkVevw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Karthik

On 29/04/2024 19:57, Karthik Nayak wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>>> via the uninitialized value when calling `is_null_oid()`, which causes
>>> us to segfault.
>>>
>>> It is somewhat questionable in the first place that we declare a ref to
>>> be a pseudorefe depending on whether it resolves to an object ID or not.
>>
>> If I remember rightly Karthik added that check to avoid the files
>> backend calling a file with a name that matched the pseudoref syntax a
>> pseudoref when it wasn't actually a pseudoref.
> 
> Not sure I follow. I think it was strictly done to ensure we don't
> consider symrefs as pseudorefs [1].

Junio suggested using refs_read_ref_unsafe() to ensure we don't consider 
symrefs as pseudorefs but your patch was already reading the ref to 
ensure it was not some random file whose name matches the pseudoref syntax.

Best Wishes

Phillip
