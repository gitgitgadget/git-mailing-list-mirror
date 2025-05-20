Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE7724EAA3
	for <git@vger.kernel.org>; Tue, 20 May 2025 15:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747753647; cv=none; b=t3Y2YTt8BiaG0VHNXeDrFX6BFrVp5LmaYrJIcc1uPgiAsy/i/qQW2DBaIIXoVwatjLSIthcVU/Ib0lmBLFYlp1MziZYgYJgDTjGFRufJXCwIEc9k4OPPtmO13HIVftq65SpHfFiseu413vKRpsZeefNDeeDZ1817n8t7Wew+RJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747753647; c=relaxed/simple;
	bh=CFYbsE5nsJSX1u3+cri8j8b2thvvXFKV5mD3tyyqbhk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fWAURFMKKtvvL+QToukE1ALEJ5wNBezn0XNJT1+A02K29+YgGmWaV6o5KL3xKzc3JsGZVQVaIrr/GdunPNP0VlmbSOjZ46/X+fc5vDt8H7x5OdrM/fpyc4NOMLdl4G3S+K1yaB2UMciK1c2J14U5TPJuFznS/0Qs+A18tGxD4r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hxka2HMF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hxka2HMF"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-445b11306abso18135465e9.3
        for <git@vger.kernel.org>; Tue, 20 May 2025 08:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747753644; x=1748358444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HSvwQUDQsRDyC5fPPz8rjoUdWdbOTiomF7LeEIj4uVE=;
        b=Hxka2HMFBHS8zJSHulq2AebiYu2Pq+r9eEtZQ3HLnSwSmVbt6rtdW/5l6x7tFaieki
         wXLTxUv0OvQJDw7Tp/rssUPOjsSu/FSJIqKqJE73ZixvLK1hh1w3YSf+sDHrIBPPSJ3E
         yR+0HjaePtmfC6vOBTaVQPPGzdooyg+N0sWXemkZWP6chJ6QZLodyaWtlxq7WG1E6/+B
         ynEZ1wQIe9D3sGJtVZ4aIjMyFCUiedZhyIGsJajpnokXbZRJTS/a/F/hcNIiuEkA4pTS
         lTi6679Bts+c9HgGKH9cvg6flc3nmY5uOuqY4/BDc9DS5i2xAovfj+roaMeH0SoPQWEp
         5H/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747753644; x=1748358444;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HSvwQUDQsRDyC5fPPz8rjoUdWdbOTiomF7LeEIj4uVE=;
        b=HUGRMGCXOqEEPhPbziyfs+NHfeLeEGfOyWKZk6Lcdj3+uxpGnupaJr+kB38kvX1/oN
         OfS7rqIf1E9xGZ8D+/uCqkMl3Lie9428dtS8ZeLLXMMvdZm7KfFlVephXXj2//m8OWo/
         kEaxucWC/cOTiVVCYTDZba4RID7O6Gk/kXRb0Cz4+4ZXHl/TLs+EE2p13D6sdDxVmEpd
         om6g5nhxBTdfOqWvWe0IIrVNG4XWHpv0Q9hsEuYlubjfLgMqh6FdirMFydJpZSRP0Z5h
         zqDsYrtjo6B7FWrn3hTM4cXnWHxBJqOSUtTS8NUO9atONJRd3hoVABZYbAtvd9N4JaFk
         6LNA==
X-Forwarded-Encrypted: i=1; AJvYcCW2bfE5rNG0IGSOLgP2eD/KXCH2R9E5MMEb9RrO9jM6ecUmxjlc3nnR+hHPzdEwzrdF3cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4JD6j5/NHqbgx1x0jG6u1Y7lg4oZ1eXNh2iI2dKnAAlxO/sm3
	DYDrMgMv3iRvWlqe56tCNuG76CdedRRN3r6ZK+xlfWnGEvpWoXkHSITro/GZQQ==
X-Gm-Gg: ASbGncu+cZTpA4KocDCJNtXCgsBI9bymiezvIOmQkLtoOziJRtzbqk/pKZvVKdg/J23
	SlLa6Q7j3DYL5eBI2rXIIj+99TbzwejfS/31c9lbg9YxlLxAGQ7vovnsoUxhttQYcsj1w6oY1mp
	LuNV6K5NO8Drz36ybk2HGuYCWcxa3GY+fb5KNRizliisemPYsuEu55U2Nd+c60x/7VmG2O6nup5
	mXqcKPbreUCuLXohucva3rYHSpd/O8wuFKYFjReRgAuY/Rh9HUJ4xn+/qDa2E7pOkIfw5xkqFnN
	L2/Trgyj3oOmdsOihm6CY7Mt9wHScUSZqlL68O4C4h+h2IbN6x1TZ9NmVbwxZ9nlFhvzg5cvFsB
	cY8rB1k9fqpvpXGrxbS6FJHaJdRI=
X-Google-Smtp-Source: AGHT+IF61gTMZMXovigYiEjiil/gU5EU8LVYa6Zq26JGaN5e9Hb+dioi0hOOaNGVSiwQO5h3U3uxMg==
X-Received: by 2002:a05:600c:4e0f:b0:43d:649:4e50 with SMTP id 5b1f17b1804b1-442feff05c2mr158295365e9.13.1747753644122;
        Tue, 20 May 2025 08:07:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a367205338sm13136233f8f.98.2025.05.20.08.07.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 08:07:23 -0700 (PDT)
Message-ID: <028c2c85-5b60-4ede-ad01-5faeb13898c6@gmail.com>
Date: Tue, 20 May 2025 16:07:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] Integrate the sparse index with 'git apply' and 'git
 add -p/-i'
To: Derrick Stolee <stolee@gmail.com>, phillip.wood@dunelm.org.uk,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com
References: <pull.1914.git.1746579320.gitgitgadget@gmail.com>
 <c1f7a9d6-4a44-4c00-bf26-6852819361e9@gmail.com>
 <6736f2fd-a91d-4ffd-b421-6670a0e028d8@gmail.com>
Content-Language: en-US
In-Reply-To: <6736f2fd-a91d-4ffd-b421-6670a0e028d8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16/05/2025 14:28, Derrick Stolee wrote:
> On 5/14/25 11:16 AM, Phillip Wood wrote:
> 
>> This made me wonder about the other commands that take "--patch" like 
>> checkout and reset. Do you know how well they handle the sparse index? 
>> They'll all benefit from the changes to git apply in this series but I 
>> was wondering if they need any further changes.
> By adding these two tests...
> 
>    test_perf_on_all 'test_write_lines y y y | git checkout --patch -'
>    test_perf_on_all 'echo >>a && git add a && test_write_lines y | git 
> reset --patch'
> 
> ...we can demonstrate that the changes to 'git apply' are sufficient
> to get the improvements we seek for 'git checkout --patch':
> 
> Test                                   HEAD~3   HEAD~2
> ---------------------------------------------------------------
> ... git checkout --patch - (full-v3)     1.22   1.22  +0.0%
> ... git checkout --patch - (full-v4)     1.15   1.16  +0.9%
> ... git checkout --patch - (sparse-v3)   1.37   0.11 -92.0%
> ... git checkout --patch - (sparse-v4)   1.37   0.11 -92.0%
> ... git reset --patch (full-v3)          0.82   0.81  -1.2%
> ... git reset --patch (full-v4)          0.76   0.77  +1.3%
> ... git reset --patch (sparse-v3)        1.57   0.91 -42.0%
> ... git reset --patch (sparse-v4)        1.59   0.92 -42.1%
> 
> But 'git reset --patch' appears to not be fast _enough_. It turns
> out that it has the same issue as cmd_add(). I'll add a patch for
> this purpose.

That's great, I don't have anymore comments on v2 of this series.

Thanks

Phillip

