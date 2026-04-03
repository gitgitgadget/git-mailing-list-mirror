Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72FD35F603
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775238061; cv=none; b=Byf13xX8BmbSVNqVMjzDw7nH6t5C0cRT1VS39w+7oKOa7kANFnfF+L1JPghxHBEHC1cWULQgQl1/5/H/3meOCh8Pe4zFZh2dDuwVyuMBBhrVW0VjeJ8wXYaf74L7PwnMhRw5sO9a5L7/wH2vZOXg5whcHGOjLYYzxe9FyWSMp2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775238061; c=relaxed/simple;
	bh=Z5CPITwQix6w8e5c+33S1Ujm50vjQWIsLYApqZiMT4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G1xFeF/TXQWGbn1M5TIKwZyvZCjMUZUMUcO/WfOKxYgipDcMPMTDtU8lylpwSbRFjSJczq1EE7grYsOpcBarSBN7IOjFJmrI1VfrbCUrjFdCf+qef9GAFrJb4S0zP1tqHgRYp6AlqZ+S4msXlp8O/paRnCyVZqd5GZufdqHpuBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qmVjm82N; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qmVjm82N"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b0baebcb55so5914445ad.0
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 10:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775238060; x=1775842860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fqadWfVP/3LGoZVV+xACZrJXu8+PqmVj816dB4SEv1w=;
        b=qmVjm82NvY2Pl9djdXNXGIEf8HMg7RgZtpJe7Mpr176scRuABGS97sF19C6V2jecqs
         Yu07qCqMkS0GCAnce8Y+OgekfxN/1oN6cH/cjQFwHmDHxZK5mDm3Xy99HcRwmNokSa9Y
         IMvWykHwoIOW9JhbEzJfS1RzGmY5/Qtlu8k3YQU6KqQG9oIU/c+k5/vZJYmlQdhuJ7Ab
         X5NRchmLW0bnofVfYKqqZVNkDvE9EJvURkV6BzZB5N3v8qFHs/mhmsU5NhayED3M8N4S
         Gs8D7Z+K+qxcWmaCrTzF4Ka0DgtsKS7uRpTOaJ+RkIkN8UM8WiiUOWOm7ZCPVPX4dVIG
         TPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775238060; x=1775842860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fqadWfVP/3LGoZVV+xACZrJXu8+PqmVj816dB4SEv1w=;
        b=Nk2xdBnKjuYg/rZXQO2sphkiKWS+VBT+mE/xcZVYen3zKXg94IM6NwPOSiBSJQfdug
         mICZTHUr+1/qcl7ywCLUxzrzvPT9XG9hzrSOmDibStShsyeUvuvjce2Ohr7tmHKdaDMi
         aONjALMT/rVEMlsBOlnXvWr2nKodMcg/6Mv6aYWRYlo7LIeALcXLQ3MsbsUc7MOpHNwP
         JcQ1F23Riov9iaQojBqRpEO1Kr9I/o9/6p781XnmvYGYUTQJKcs6H359LEAVm82sW4Ml
         +5BZDYaMf5GYuHqUZrWbMNRoxTva6jyyDYr5svLHA6xvE93xUvVuxjD4FrJXcKB+DgKu
         uqUw==
X-Forwarded-Encrypted: i=1; AJvYcCXn14kbm8GaGvNfayYOZwt9d5Q4we8PUxEPszZDX+XozG5D37EtMu3AB4zZ3fFgbMzfMGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwilCav5xuGN+TkscrZJ/ovZEqP7YHJmTGObTsV1Hsl3YOZSKo3
	NzHy+pgwLa12CCV1AjR5Z4r3RrB4nh7+RyQa3epR7xI9RLsCA5cCpzxC
X-Gm-Gg: AeBDies0df1dy3QCY2EmxUeGDJjrIj1ocmydlXMdpErKGf1nmRGYfHSqYOmkmdGLzK8
	WTeYPOwMxzgjTyIcl9Ld9Gu7kMNZxe0qKnIz9YZGFZbMOKg49nxRb/motAhatlsY9QdzaT4S29O
	OznvpjpI2uIzfQXM8FsoLjagbuJ9+ZmDuT06kxJjuke8tbERBm1n7drT9GkLvReD0GlWwlWSaBi
	bTnyeb7pMCYpRxoQrY33SW7yNp3FFlG0rXnWDxVRETxJzr9UCu/9fhfyfHmId9vgWR4kZ1wmoD3
	LGKT4LrIFjaKRz82szRTEA0MK6rR97D4aNr+5k7QzZXx+ZN1ZF2wgeX6NTBgWcS+PIuEfGmtTjo
	2HA5ZX9wrXrJeKjR3A/gu0X2ZxUyUYQBaFuv15bFxYhm+ADdc10LcWRHq7LlzYHd1wPO40XxM7G
	JzHEwvvxFtuNWo9a3PzgB9nnBl6qV5Y8cASNUgdBi/pjcDCohMG7k+bGqtT/HyUyEC/c+iG0Qje
	6NcouQGlFo=
X-Received: by 2002:a17:902:f54a:b0:2b0:ac1e:972e with SMTP id d9443c01a7336-2b2819577b1mr24111275ad.8.1775238059849;
        Fri, 03 Apr 2026 10:40:59 -0700 (PDT)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2747af6e7sm64447995ad.37.2026.04.03.10.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 10:40:59 -0700 (PDT)
Message-ID: <5017740b-4437-4e55-b019-244b33eed05a@gmail.com>
Date: Sat, 4 Apr 2026 01:40:55 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] refs: add struct repository parameter in
 get_files_ref_lock_timeout_ms()
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, gitster@pobox.com, bkkaracay@gmail.com
References: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260403120938.1142533-2-shreyanshpaliwalcmsmn@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260403120938.1142533-2-shreyanshpaliwalcmsmn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/3/26 20:08, Shreyansh Paliwal wrote:
> -long get_files_ref_lock_timeout_ms(void)
> +long get_files_ref_lock_timeout_ms(struct repository *repo)
>   {
>   	static int configured = 0;
>   
> @@ -997,7 +997,7 @@ long get_files_ref_lock_timeout_ms(void)
>   	static int timeout_ms = 100;
> 

A very minor and trivial question: the 'static' keyword is still present 
here. This is entirely understandable, given that you mentioned earlier 
that...

> Hi Yuchen,
> 
> I have acknowledged this in a previous reply to Burak. As stated there,
> this is a valid issue and would require moving the config into
> repo-settings struct.
> In this patch, I focused on removing the dependency on
> 'the_repository' while preserving existing behavior. Global state
> removal and multi-repo correctness is an incremental process,
> so I would prefer to handle this in a follow-up change.
> I'll also update the patch title in the next version to better reflect
> the scope of the change.

But if that is the case, the accuracy of this line in the commit message:

> This reduces reliance on the_repository global.

..is open to question. Or perhaps it would be worth mentioning:

"Note: This function still uses static variables, which means it does 
not fully support in-process multi-repo usage yet. This will be 
addressed in a follow-up by moving the configuration to the 
'repo-settings' struct, but changing the signature is a necessary first 
step..."

or something (shorter)?

To reiterate, I think this is a minor issue, so it would be better if 
you decide for yourself. Other parts look good to me. ;)

Regards, Yuchen


