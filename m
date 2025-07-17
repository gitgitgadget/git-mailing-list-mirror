Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14DE22E49B1
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752765578; cv=none; b=PCMGh7xUcf1t+uOhzwVo1JbrRH7aIEZ/t9pkmYKqIYnJNhrYOFS8TD06x9PGFUplCyqf0nIyi7c16tb9wdqenk/6VuMUdtckR6UJuvm0ghJBPx6qfTK7Ra0La0+zKBKoy/qTwttmJaLT2ocvMVVAAp2sRXa+4+DKf3mdhLJD7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752765578; c=relaxed/simple;
	bh=ErjsNTv4c7v+b1getgGaTtyOQjm5RSK7BJ2AHexT9bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=twtzchFb04laF254PAI0Edkrpru/xURAPnJ0pv1iuAAz81sA4pCpIPI5ClKRTmBBWb0DA2pl5hleWp/evkjAmO0W2l+Rc9ApttlfQpqqjZX0JN8kuCFwm7t+2iWouAVm/v7qL7zsB5z5lrdRV3McRnbyVSaRQtHnneJk9Z6+BHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DjzeQaea; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DjzeQaea"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d6ade159so7744485e9.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752765575; x=1753370375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F9n5Rz2jBP6HIynfB/JyOkDmcj2a0QfJcKeJd3gU4hE=;
        b=DjzeQaeaRDVVxCG0chr26fx7skzrr7vBMKG6Y6YpVkI7oY+WzFDZCCnFWpseIjWAuG
         R/9EJedvD4d0ax6ZePGywwNN2rZA6+sBkn+dfxbB6RXOfC7uITvJbP2qgB1vZiOsjIRs
         awBwSoTrVdJFdVqdKEheqWKpf2UOF4D1FV4DwMCvCiaFo9IML2+L8euVJDsn+OaqBEXr
         SDESNRuIGgVoWXtg0ps/3ObAG4z40mTsCJNs+D3NjNFf8S0EiLGK1FRfevWrK9pqhc/5
         2d5hqiWl2PptD9Dx2GDF7MVzksp/PvZNPEcdeVdfRuabaNZe7zS+NR4rx5SXee6AfppD
         sQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752765575; x=1753370375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9n5Rz2jBP6HIynfB/JyOkDmcj2a0QfJcKeJd3gU4hE=;
        b=WV70MshC29V2bd/lK8AIbIVDccxCjGeUrq1iOQQLQEgfW7lagn2MhA6XUIhKwhHb0p
         LE8+gd+GC27uvHoPUx+SiJcuR13GiR5XaO8Vqhuq0qZRosDAKZfVHXVx7CNV4wlpO3vW
         vsXf2piOlxW0qHhBkotlOQs0qEuQL+zvRxIUyd7TVVjOGwMZ4Fw0YuzyjdOZqKHuc/Dy
         x4iLHbl4B80hlV68b3/pTnTm7RRYU7nD38xQ8m93EI/fBmbLszfcdgHChzDHdYFWpUYp
         P/Ji2+5WxJ5Vd2qhqZ9oARB1UtgMEMV34buYqMigsUlsqByCbF/mkas0SWk11DYqdPMp
         3Rew==
X-Forwarded-Encrypted: i=1; AJvYcCWKduDrYGXmcNl7iA3dB56TWCtXG66eleBpKDeZedFJV6zJ4bkSD3TnbYgFMFtV8KB39Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY5/wjQcx2PMFN0I4aMCwlyhXkQIAoOlBgyv917NuEB4GrAU9E
	sjJc578GoQug4AKFA5UDuiqY3Uhd0VTUpsHGKpZK9CGwrAP17YpOWYer
X-Gm-Gg: ASbGnct9UOeJOcpKwNGbKY7kvbh2Xmf3pZ5bIhSNyZXdIEAg7bPPTHYfs153Ar9wG3Q
	zMk4XjyWhN7cGR3quFNIzsKbyY01OBTCpR7XDqVend1u3f3CzoYm8Vko7G2c7ePwHUBpM+SrdrA
	Q9m8E1/IllFgjddMSdSY63zh2FR7cQ05DY7/HYTXpHaKcoolnWP+Hs+SjgMFzICk3aMOKLDVALA
	k79IHbanYwYMGH8PQOlgDAcCr5F3EzgoJ0jT24c3F8sciK/ARnM/Mc+G+EigaI3x7eCs3blPCXG
	rkiaSvJuhOv8fNdgLe9NSvpiLFJq57ZbEPACBMR+MXpMf3p2TloaAs+7RkryMa5YttKCElzeHiT
	da/FJ1/P6RUAsqDM9dXRwr7uZwtQ4z2KqZwdl4scRc0eKO4PwAhRbpu39dhrm7OgKMjGRPPQuB/
	o9
X-Google-Smtp-Source: AGHT+IEtU3jQSrTbV4iaVQmHYHp6T+8R/+ymC3aRHjFpHFdg+m8dfFqhbbCtKXNVcbRv4t7cD9oUkw==
X-Received: by 2002:a05:600c:8211:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-4563609dcacmr32111675e9.0.1752765575044;
        Thu, 17 Jul 2025 08:19:35 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45634f933ffsm25396915e9.29.2025.07.17.08.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 08:19:34 -0700 (PDT)
Message-ID: <0026a11f-373f-40e8-aa29-9ada050904a4@gmail.com>
Date: Thu, 17 Jul 2025 16:19:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 17/19] environment: move compression level into repo
 settings
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
 Ayush Chandekar <ayu.chandekar@gmail.com>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
 <20250709-pks-object-file-wo-the-repository-v1-17-62627b55707f@pks.im>
 <32fceddc-c867-4a47-bde8-c873279edbc1@gmail.com> <xmqqbjpq1rs0.fsf@gitster.g>
 <aHY7LYHqVj-ECf_z@pks.im> <f6479d6a-32a4-4a49-a75c-589978cb9a57@gmail.com>
 <aHZ94u-xULDDBb7C@pks.im> <aHehaghOW16vPee7@pks.im>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <aHehaghOW16vPee7@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 16/07/2025 13:56, Patrick Steinhardt wrote:
> On Tue, Jul 15, 2025 at 06:12:18PM +0200, Patrick Steinhardt wrote:
>>
>> Hm, yeah, I think adding it to `repo_config()` might be a viable
>> approach. I'll give it a try tomorrow and see what breaks :)
> 
> The answer is "quite a lot". I'm now 15 patches deep to try and fix
> this and am nowhere close to a working state yet. The single biggest
> issue is `core.shared_repository`, which is used in a ton of places and
> which causes all kinds of pain.

That's a shame
> I think I'll stop working on this for now, and would rather like to drop
> the last three patches from this series so that we can move forward with
> it.

That sounds sensible

Thanks

Phillip

