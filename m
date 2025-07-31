Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5F286347
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753971655; cv=none; b=KTsrgku3SQ7AThi9+m9pIWLTB7mzJDa4HIvC2njcy9gvV9n06IubYjr3lxIyVPg8LCP0OvsWGRw5OapvmO3eWUeKWEr6cK2juULmngwbeOGPzWpndO6riymGVj7zopfh65II+sUZg9VBLLCYD/C7UeC72IfkQwH/PP04Faeyemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753971655; c=relaxed/simple;
	bh=2UFQQzE1dNlWFAr9WZvJg0+SjQw6DOY6KUrsBtaVZ8w=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sp4MQIfnqwxvQOsAYqAvH3HyzyFrizOpJgcTJpBVusmYnlqRXN5zZukJByYN+jNi/WCWL27th/i4bGcvOYm2FUHjfXss54NgmLajK4jcjfXl3onf1/ivvpFzE3mfTgeAIfU5JMBhtNs6QyVK6HFrUy/zn/BakNW/8MtkLaelorQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vz0lTmHN; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vz0lTmHN"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b7862bd22bso1264311f8f.1
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753971652; x=1754576452; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6f8qegzW21fA+Ecm4OUYYk10SaHCGMjLtY/S/bCSQwc=;
        b=Vz0lTmHNyEeo7S3jka+e8UeiWxkODv6hWf+OtI07asOzfIBeCkdgj+scnyA45ewwap
         k4vi9gqVT0WAYQ0fUf/3o5PuY4OOr+ud9cxWZTo5yx9wzpKx4/RhJAo9xsxk2ahuX5xt
         equbeVfST6RzAZ0m89KNsaMJAjUB/yAD49cF7hcG4s+7GrdonGb73fXYK8yi/5u5Kwzj
         E9QEIC0TFPCMxO1T2RP4ygvQq7nyEIWhfRYLtdtaq/cywGlDzgNxKDHGhcIOE8q5t1x/
         ++WoWYgVpMa/f1cxtPSsVE2ETT/ixIxpnOlusnaKBsetkfBL/8xkY7Cp5EdBt8hmjige
         Vs6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753971652; x=1754576452;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6f8qegzW21fA+Ecm4OUYYk10SaHCGMjLtY/S/bCSQwc=;
        b=fqoGKtXte8+YOkFL3LmzYKfdu5FaSiEvbB+rphUFm+HPbKhsQ/Ys5ybhHldt8xoZ1B
         YORGkgqnu7rGX8hKHY3VyJB/ig6Kr77TAVudCzv/7+FLThArPi1lYLJ3ljRFkvAm120J
         3D/PC0pel+StJzsyUQu6PrjSV1MiuO0cLYeVXQjIszpLCKYcot//POdgM5ABMbs+xXCZ
         aoh0zlcxItZFdn5HeuB5fuFnZMwXKuy6VmYhmyWG194RLhk3JvF5NLX3537S/ojedPe5
         oi66yYq8zFK4F73byjbqzWnRZXIiBkdBO8cDxdny61TOC5IdZ51nN22Uo64omM2aE8yo
         Hffg==
X-Forwarded-Encrypted: i=1; AJvYcCXRtm6lM2+3Gdhq0xMwxoTLNUYW2ekhVnr1Odj8QVJ6gkAlpPdUKduB/EAxjJyAljodwn0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9coY+Y1qGLpgzZIgd3vo39wH+los+QcSAi7Jt5oC0eAa3RXbf
	8jX3ly/tbdkoF92/b173sJYtCFKO/qQ+g6t8wokuwkoSHRClzI6CSVdU
X-Gm-Gg: ASbGncujO6FqXDlRxowpbFGzw8zWySIbcof83ULDOx4METqpTpyXQoQ0gbJEASwEXhO
	VMMmBPPVNOZPXWA2aHPG6na5rKRWIBGdMdR0BpgAQTn30UiUvHnQEVZvwsjQiTb9dQhWLBuRuni
	SllqRPzr6vAKFnt0WcY+PduXVh8RUCRvPUs8om42L7HC17nuvg1Ow9rV0MV8KAH6cGlTiE8/y/d
	KduAN1hgR0fKPDVfqWMHLjPo3hiN33bLRQidhlorXz+TU1Ie1UicyLTEcKkSvwaRW/gucgW05Sf
	6mTwsljh3HclbbqzrrBw5iIXHmtrBuRWQmiUIKtL1sF0AhC8P3Hj8YVPITnMzWDaGSrpl/R5VtW
	HD2FF62YxN/dJnFXgwr8MOu9QZ94EOpEu9iHqZb+7hrCgeQJxcCGo7ZDhUtdBxhZy7ESJr8PKqY
	mR/rZP5HF5R4I=
X-Google-Smtp-Source: AGHT+IGeCsGbIYkXLvUZ62h8/K9nVnYemMtwCdWbM05Nb1Ixy49H7NcMJPMiKom9/aeDPM3BT/Rk2g==
X-Received: by 2002:a05:6000:1acd:b0:3b7:8735:9453 with SMTP id ffacd0b85a97d-3b79d41f9d5mr1999625f8f.3.1753971652136;
        Thu, 31 Jul 2025 07:20:52 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abf33sm2552634f8f.7.2025.07.31.07.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 07:20:51 -0700 (PDT)
Message-ID: <ad453eee-23cd-42fe-97bd-1ff0fc2f3edf@gmail.com>
Date: Thu, 31 Jul 2025 15:20:44 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 4/7] xdiff: make fields of xrecord_t Rust friendly
To: Ezekiel Newren <ezekielnewren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <6df9f50a8f4ca29b2c3ba1e39982b6d516146bb3.1752784344.git.gitgitgadget@gmail.com>
 <91f6352f-abc4-4e99-938b-6a56aba2faed@gmail.com>
 <CAH=ZcbCnEpBokM9rxmmkeM9GT948n7+RipXODHLfPssuwJuVCw@mail.gmail.com>
 <a765cde9-0fad-414a-996f-2ec162d1e4f3@gmail.com>
 <CAH=ZcbALsQqTrvNJ4ZKmVWc6PHtTA+8k8p6_D=x=BfMXxnayfA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAH=ZcbALsQqTrvNJ4ZKmVWc6PHtTA+8k8p6_D=x=BfMXxnayfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/07/2025 21:14, Ezekiel Newren wrote:
> On Mon, Jul 28, 2025 at 1:52 PM Phillip Wood <phillip.wood123@gmail.com> wrote:
> 
> Ah, I misunderstood the scope of your question. I could not fit an
> example of why this design pattern made sense into this patch series,
> so I'll explain with an example here:
> 
> If C defines a struct like below then it's obvious how to translate
> that into rust for ffi purposes. It also makes it clear that this C
> struct is expressly for the purpose of C <-> Rust interoperability.
> struct some_struct {
>      u8* ptr;
>      usize length;
>      u64 counter;
> };
> 
> This is how that C struct needs to be defined in Rust so that it can
> interoperate with C, and making C use the Rust types reduces the
> chance of copy paste, and primitive type definition mismatch errors.
> #[repr(C)]
> pub struct some_struct {
>      ptr: *mut u8,
>      length: usize,
>      counter: u64,
> };

How is the pointer, length pair used in rust? Normally one would use a 
slice so do we have to construct a slice every time we want to use the 
data in this struct, or do we copy the data in this struct into to a an 
idiomatic struct with a slice member? If we end up copying there doesn't 
seem much point in changing all the types in the C struct as we can 
define a rust struct using *c_char, c_long etc. to interface with the C 
code and covert them to an appropriate rust type when we copy the data 
to the idiomatic version that is then used by the rust of the rust code. 
I can see the value of the typedefs for documenting C<->rust interop if 
the same struct is used by both but if we end up copying data on the 
rust side I'm not so sure.

Thanks

Phillip

