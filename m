Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094EE2114
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 13:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091160; cv=none; b=Ic1LApI1T0/qGiqzA2PVTL8fD/Od5RFmEhKUDR+dPs136YDgr1/jErudlW3A2Tji1864d3zyB46E9zIIIxY1MVaKj1mskPmU+9l/FVeR4gE9dKuTV5BnvVg2CLUK7bENG5GyzxFXeQhKo8/7dRZlzFF9+vuvA+dksvzbNynMetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091160; c=relaxed/simple;
	bh=Fn3x4win5bTX7HB6IoByB0TZ5zGTQhw182ZiAN7rZqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TCMZdJ7mA8qR+vlyL0vss9wzZwKm06rAQQ8kRqvAo1MKb0bfPqw2vXyoyhSVoVI1dUoiBGH5UHuwFybp09thj/kEc5S3EEuolGa5Q+E7bQPn9ext7Y0QoBxbSbOoUYfmzpGZ3R4CfKE/6mQr/AtqAym4XypFgQ991kiCE0GIZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mLQJYhY0; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mLQJYhY0"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so4370142f8f.3
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755091157; x=1755695957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Wd+GDUMmXBAx+1wjYZ/3+Iar2YK6mTjDlPy66WBaRe8=;
        b=mLQJYhY0KwWxMhoc9SW2UlgbsfB1C1pANj0GyVuTAsL+Uqm+dYqeCRkhq32xd/Ptxh
         pfxAd5O88xytr0U8c5Yv/LGOHpHTSBdFc7VStyxA4jNGm0JL5hEvVi2jKAXyKSyZ3q8n
         YnPWoO5E0quqrKhLKTRTFccyoWNgtDfa0nfYjYlC9EKVPFw13O2Vg3X/3WI4HC0SImdZ
         ens6mnmo8WjMmqEvnGd3obxMpyt1iJB/tnOWdFBrJ3JHegDjFVreOYBiOXCS8/YMyr5/
         IjLkQiHUqCCr2Wl7P15xOwh0D9sBlOq6o8t8+LQu7YZbHDSIO2+YcoHJhFbBVLr62X+/
         01TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091157; x=1755695957;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wd+GDUMmXBAx+1wjYZ/3+Iar2YK6mTjDlPy66WBaRe8=;
        b=d20wRWgFw4jKrlGA+iFPaHkNddVZ8+qCpFde9dbAVJbdBJlWEeDtEopVd+Qh+2bQIr
         cawwcHy7V2qxRlHuX9qFkjj7PChqrJ6xTy5QuaghTXojmRAK2bDkiv26uS79hXkffQLC
         ewD1Xukt511mj4n6jZEzZ7feDPyNBDbd2IxLGvOejw8QBmj1slpZvtuSDghw16wvmE0u
         Uhwws+QYYXdDjceARom4DyPyyzcP13YxDrj4xq+B8qfN6KAp3wCXIDDWWGauF+m8ei7O
         Qu2CFtgvKzkVWoltExU3EqP48sNgGICzoBSh9pbSmo/aaN/uzEJC9psE7zcXbnyxXpv5
         SxKg==
X-Forwarded-Encrypted: i=1; AJvYcCWHOUK68zyvfZl4JkHBlrGbkovxEpxiROOtmtwj5lbwg7KVDa9/Pm/if8fY7c96IXCArHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyB1unAepr7SxmMwUTtxt6jbjnRrhDSwxhfeJQGN8k8EHqC0B6
	47qUfabtow6e2gtH8KlOo78i893vzhbM7camm4HSZ+bw5wQT3cukaDQsPIfioA==
X-Gm-Gg: ASbGncv/tOJMZ3+/0wLKamQBTZdmfngnMFj2B5T7PzLabHCh/Ns8gH+ySXm5MvZcrQd
	7JYC3PM9wy9K6PpBdkCGzCb1i9cpLyopfJJXwR2Xd81JDR8grSbUV4HjrIi42KPObcZoCMpN/6t
	HMhJCAaiDtuC9xTkffo6Romg2t6WXZHEeR8nMN0dtwxW4howLWI04NoTCeYodadS4PAahJajQ2+
	ZNBMdHzEciMCASpWptcZU+DcG20v4wluJgXZAGyhUud07bT//Neu0RDKJ8bdySBA2v+yyz8ioN3
	ISrk5PUxdeoa/5tnQYGl5OAS1yJb73creg+Y7ihvWQfdZH+3NaLlhRADB7a2nPqwoQsRPZ7z4Xb
	7F991W0ipICUThRlL8jkLQpbhZ2g4gSNC0tUDEaHXsJ2w9QVOYPctNU1vrIzsqLclPuOxuc5FE4
	UK
X-Google-Smtp-Source: AGHT+IEv5H/EbgJSImusIoPIUO6w+DYrGrTjk5xV2wrvyC2BmjdJ7Vc6wlY/SPTOTlVwdNb+b8lIYA==
X-Received: by 2002:a05:6000:420d:b0:3a6:d92d:9f7c with SMTP id ffacd0b85a97d-3b917d2d47fmr2453391f8f.9.1755091157263;
        Wed, 13 Aug 2025 06:19:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4beasm46360397f8f.30.2025.08.13.06.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 06:19:16 -0700 (PDT)
Message-ID: <5303c45e-d95b-4bc8-9cd1-bf4efe6bfbae@gmail.com>
Date: Wed, 13 Aug 2025 14:19:14 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Potential Null Pointer Dereference detected by static analysis
 tool
To: Cheng <prophecheng@stu.pku.edu.cn>, git@vger.kernel.org
References: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <AAkArwD3JXZP4EIjvKF0Waow.1.1755044612233.Hmail.2201111603@stu.pku.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Cheng

On 13/08/2025 01:23, Cheng wrote:
> 
> 
> line 326 in builtin/describe.cdescribe.c, which is located in the function describe_commit. In the following code, cmit could be NULL passed to the call, which then causes a NULL dereference. Seems should be replaced lookup_commit_reference with lookup_commit_or_die.
> 
> 
> ```cpp
> cmit = lookup_commit_reference(the_repository, oid);
> n = find_commit_name(&cmit->object.oid);
> ```
>      
> 
> 
> The NULL value seems to come from function lookup_commit_reference_gently where:
> 
> - 1. call to deref_tag may return NULL.
> 
> - 2. call to object_as_type may return NULL.
> 
> 
> In this repository,  other calls  lookup_commit_reference are followed by a null check. So this seems to lead to NULL dereference. Can I confirm with you whether this is a true positive bug report?

I had a quick look at the callers of describe_commit() and they all seem 
to use an oid that they get from looking up a commit so I'm not sure 
under what circumstances this call to lookup_commit_reference() can fail.

Thanks

Phillip

