Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99856284671
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759930618; cv=none; b=U4J5bWiRznyo2Sy3VBiT0ac+kC4xCQ+g79OIhMG+qbk4nz3L9uwIn7s/cJVnIdJrV9XDsbL7gJJrHlueeB4lzCwlqnA6koi5yGPDq7TvLTyvr3T5vOXbLgStSxIm10Rq5ZApi2dPeH9PyFESVFZTr5bGIiylVrrgl9XU2JH7Q74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759930618; c=relaxed/simple;
	bh=IHntotoH+YvVaOWNm/ztJBVTyKNOmA40ms10BFJIzYo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=khBkSMgI/r1V/rHnaFouZZSPtEsCVg5zUE3MQ3kS2B1Zs/BAZd4gwJIDM885KbCgcjqfQoXyXnqu9kmeWUKKizVU+RQ7HIeDEIIx5/C9fAGYltHQLyQ3h3fiuP86tMkMdQ5Y3m3Stiuup0zgibOkJOeRwgMPpc82T8/B2Bsa4Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdB0T5Rl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdB0T5Rl"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e48d6b95fso64214345e9.3
        for <git@vger.kernel.org>; Wed, 08 Oct 2025 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759930615; x=1760535415; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pJ4+VwAuu+t5CoO9W35uT20ehktqGzaZ/lI2ZEtbp+Q=;
        b=EdB0T5Rli2cFE2PmGacpR0b6g4s1ospQkq+Yk+rKoNN+eOR0W7MuBAegf/FaRIhklD
         BZUjiCBvbu4jVkD1q9ZofhQJjPoYn236rYi2VaC/wxLfDyT5136kgvjvPw3iXiIrPObE
         N5iV2Yl9kX6IQBlg5gHfESTbqNwo6SV6y2oP4B2n5mVJBCm6AGoB1mb4IKilL6YFveAo
         rJkto3BZkM1PBjejhIFqF5DUfcMOSEbLGwlL5QiCcuoA4HeY59VtLJScTiakNGV3rh0B
         RUnnefzUtfZFwSvdLo9TSn58QrTqO3mzdVMzUCIvHrD+LHW6SxORP+lGM+OiGjkYKbty
         ZKNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759930615; x=1760535415;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pJ4+VwAuu+t5CoO9W35uT20ehktqGzaZ/lI2ZEtbp+Q=;
        b=Ull0eBS0abRUbdgXS7+nZOZaKmzDOH9t8LpI+DBCIJc05li+iNGKdOe372MyhPeDn/
         Qx1VgdwymMgPOPxpf6KYWS83PQSEpP0bQKBY8MdpGmVcTdC5FflBfCvQ7Ndap9S3pSjp
         FpATnbBZvzK3Ny/oMJv53HrH+M0LpTAI5R7ZgrVh/zTwewvYNrvnZknLGDfuudQsHz3P
         uUqre57nE7etq/mSTbdNZsRHFxEBS12tCt2mbw+mKD9G3kFg8b42fInXa5hv0FnVwN/J
         GEGC28RV/HWCQeI9dSuidNlOSLC7zd6BX5e+YeHsB+Fw9UTQa6sNFCQxC2AwlI+ksSy+
         uluQ==
X-Forwarded-Encrypted: i=1; AJvYcCUklY/mkPaeSoLXMM/NqpuKgkTUYU3wCNGeLsdm3i6QvT1Naw4pkN8/NXBevUTnJJw4vgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI/LF0FZeTiWTt7ySMNCfPryMHBZiPBxwuCshXz5SOSlItLAIO
	TS2Yf/sQ9u3UOyHKUUJYa+hOsLu7tFgVqzCijW54o2qv32dC2Jv/9WJeMVHWYbs0q2w=
X-Gm-Gg: ASbGncuOTDM0RbXTYOUr7+/DfzjgVq1q92UxeD6vQgKG1UtsqYMV7HZhFihCIFRP2Ji
	STJTIDs2q7MlmL3nh4ljByfCpLZliRYzGv0QJNhcF0EgzyRyhhxAgbGza9mAEJZjTHw9d2603rP
	SmCyPCju9PX6Hzh6Efo8VFK4C8r0j2SFcbaS22pI259w8pU1Xdkdaiw5YXP80wTX5PI2y+lZAgO
	rtupJVeS6YFBSKFMNqh/wzZDghqkYrvJuXY50fiMz3sGFEb4ieSc9noS+/RxQO1B0lv/qyYGqT0
	jnNrQ+5QNzVons0RUW9TcW0glb00KD2TFtHDtkKlflfUWuuCHlj/QsV1J1bJWmaNu6+Lplm8mla
	rySqleycBA5taKym3t4wfCQkGV5fN+GEp0ZU8HbFKpMK0ZKyuX+2kIbW7j3SSbjQDz44778llD4
	fyRG8v4nkgcQOUZY4rJToohzg=
X-Google-Smtp-Source: AGHT+IGOBQuSL7qksyq5HjIwfk7HIB+h2NUJ8NrLQfQVz2xzMWHpS0ZAnlnVvmawunnGDEJABn7AlQ==
X-Received: by 2002:a05:6000:240d:b0:425:7c3c:82cf with SMTP id ffacd0b85a97d-4266e7cdc8fmr2377280f8f.11.1759930614759;
        Wed, 08 Oct 2025 06:36:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab8b0sm29938249f8f.18.2025.10.08.06.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Oct 2025 06:36:54 -0700 (PDT)
Message-ID: <da003e1f-99b4-4f13-a052-294d3e5f3eab@gmail.com>
Date: Wed, 8 Oct 2025 14:36:51 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4] libgit-rs: add get_bool(), get_ulong(), and
 get_pathname() methods
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 phillip.wood@dunelm.org.uk, ions via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, ions <zara.leonardo@gmail.com>
References: <pull.1977.v3.git.1758945111.gitgitgadget@gmail.com>
 <pull.1977.v4.git.1759221968318.gitgitgadget@gmail.com>
 <0cb55558-a48e-42ac-a80e-a24ee2be55ee@gmail.com>
 <aOQyioJChUkJOXRb@fruit.crustytoothpaste.net>
Content-Language: en-US
In-Reply-To: <aOQyioJChUkJOXRb@fruit.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2025 22:20, brian m. carlson wrote:
> On 2025-10-01 at 10:15:28, Phillip Wood wrote:
>> [I've cc'd brian to sanity check my suggestion for handling c_ulong in rust
>> 1.63 which lacks std::ffi::c_ulong]
>>
>> As I said before this wont work because C's ulong type is platform dependent
>> so you cannot assume it 64 bits wide. Looking at the previous discussion[1]
>> the reason we have these fallback definitions is because std::ffi::c_int etc
>> were only added in rust 1.64 and we want to support rust 1.63 as that is the
>> version shipped by Debian oldstable. I think it would be better to have a
>> separate preparatory patch that changes the existing fallbacks to
>>
>> #[cfg(not(has_std__ff__c_char))]
>> use std::os::raw::{c_char, c_int};
>>
>> and then this patch can add "c_ulong" to the list.
> 
> It's just fine to use `std::os::raw` in general without needing to use
> `std::ffi` conditionally.  I'd just default to that until we move away
> from Rust 1.63.  That's what I do myself.

Thanks brian, that sounds much simpler. Lets add a preparatory commit to 
use std::os::raw unconditionally.

Thanks

Phillip
