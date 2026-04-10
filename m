Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C23D9DA9
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775833379; cv=none; b=B1cyToEj4HnOQrVfd9UrA3HdzvLkY1mwcZ7x1/1zmytIXCKF+y5YUbhc88XieR+JB1K4JGD/2nlrX4KqwnYwagyy8PSkZ+8njH4oDv/A/bgwRD5mbJ+YvfB7462hGUAa58tS5hLVWOqOSWt0tYjnkxVP2cAFCOfOWHxq8g9j78E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775833379; c=relaxed/simple;
	bh=X7Qk9IXa4khKPdQtG5CpcIJ0omzDk6U5L1oiHEAyQ9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TuXB1c77dhJa1x9Ws7Je/Q9ht9dcA2Xu01BvlWD1nXmhpwseJU/T7QUGUAriRrnBlqXK34d0oL6Gb3E8o55jQB45iGUshlG5wpYmaUoEn0gTy4v1QhwiPgdYDFqRJpP572UjkPwQg5IQNPP/bqOfarzeB3/sSCmQ4zeM/LCJJdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qUWLwdKP; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qUWLwdKP"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-682d981b025so1273353eaf.3
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775833376; x=1776438176; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iOznAv4cKg76GGEEqQr/jTzrWZBL4FIQbYmm1nypbKQ=;
        b=qUWLwdKPNP9m+YlevpM1sUklQN5RPKfT9Y1jEyGXr7lV72K2ifWG3EHCJ08NdwyvpC
         COXflhEG30LVa73msm/Kr7q1wtnc7xL183Fc66TropoZMTlUoDJEkiFzt16L0pdI+lkq
         ll6CcgloIgEZQF7Ngu5mBpIvd6sbT8yHV/Mtm0VdPLyCkIiE8YltL3l0L+GZJ9twmAKi
         HidQpYzGIRhq9C5xFBXzkzI/kRoEU9YAtWTRcopBJ6ZXTKfXD20jpKQBDeB9QV12WHEB
         ptvH6aDuMxsJGVhazuu/G/9hepX93MOyhP+rW7ngqWOlDGaijhxPDRQVfTZBlP/ytOmd
         n8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775833376; x=1776438176;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iOznAv4cKg76GGEEqQr/jTzrWZBL4FIQbYmm1nypbKQ=;
        b=PjcmduSO0WM0fSe+wZnl/yt+cHdkSE81bbZYk/2bWQGAvJS+kQ5H4ClkmJ1ReFFxSN
         2JidiLS5/gW+r7nSZY7uhpZFNMsgqOYgGL8R5VBFj46jO93bu4GiiZe3g20qgJ0q7B68
         qUEz9FCo9f6RBNjrBIcGpuFweJ5SQdqHpa8Sa9l7c38ELln9IhlSBOfmQjY9yhoMMmES
         bmnj0ex9lBDMQsrSgwuE3vIBWgEct9TgMo3zeQ6QYR3zomApJhMCa/sVVQEw0VjhGMXt
         +VD+rMgEOx+ibiuxfmn/sCbGh4uuIEU/wzhHdApJr38SaZEjvogz1zvMiJaLVRC7Eo3/
         oPLg==
X-Forwarded-Encrypted: i=1; AJvYcCWyOQjaXJ1ig7y3hKcihoIqoBjitpSfO7pAeb28fXaAbqahEpYWvqob+L9yYNM4EdrVWtE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynldTRxwGA5H5V4IEXEHN3idZYCkFYYRvV7WrCh1DG8Gx7SrFK
	7te0bTI9fNW7vo9rzWBfTIK6uYDcs1XadquwhVOeVgDlujUpWRIIvwy2
X-Gm-Gg: AeBDies+PkAz/jNt3vZvePgD8cGlsaVwsOehfSqc/jFz3Rugamb5Mt57TbhyXE/Es+T
	wrhKslH4pdioSNR2rrYf3Ohib7WpObJDTTW+nOfWQnxBj/ASoQeFMoFOoxfbVJ/THXGmU8mbLSR
	1M7r/DiFTVy7+wewQMojg+CMkNNFHTq3jzUD5d0fg1xN7og3N4qHrgEhdHwFzREjGgi1/4sk4Bv
	6NhOaNGXQiyU2za5jrqfx2YVNganzoTSYR9g927HrsOvzQ61986f7uwqGPTQnqt6pAmIcxx4MJk
	cmSmvsGK6XS1UfCjp+CTzZwIoRNeTJSymn7xIDe4BwUf0XFniR1v8jtt+QF0PoRFk1u8nYMzo51
	ooByw9LJ9HCSYzc2SNfy6aM73idmNNKm1C7UMk0wN7Av9pglVsTx44FYRa3+IPA9UhMYIUXMmSp
	UFMUsMHTOitwUtxHpiT+vEscv5GK4i7nfrp45ItKOn1Ljkqf4x3yQ08DCUcng0w1YmkOubbDnMx
	CC6wgyd
X-Received: by 2002:a05:6820:1903:b0:67e:42b0:b35e with SMTP id 006d021491bc7-68be5e56d44mr1769740eaf.4.1775833365422;
        Fri, 10 Apr 2026 08:02:45 -0700 (PDT)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd54dd851sm23225141cf.16.2026.04.10.08.02.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 08:02:39 -0700 (PDT)
Message-ID: <00b7a590-28db-409c-bfa0-27327e6aefa7@gmail.com>
Date: Fri, 10 Apr 2026 11:02:33 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Re*: [PATCH v2 0/4] Enable Rust by default
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>, Ezekiel Newren <ezekielnewren@gmail.com>
References: <20260409224434.1861422-1-sandals@crustytoothpaste.net>
 <4efc4133-3726-4b9d-8f06-03c07d48af99@gmail.com>
 <xmqqa4varhod.fsf_-_@gitster.g>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqa4varhod.fsf_-_@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/2026 10:52 AM, Junio C Hamano wrote:
> Subject: rust: we are way beyond 2.53
> 
> Earlier we timelined that we'd tune our build procedures to build
> with Rust by default in Git 2.53, but we are already in prerelease
> freeze for 2.54 now.  Update the BreakingChanges document to delay
> it until Git 2.55 (slated for the end of June 2026).
> 
> Noticed-by: brian m. carlson <sandals@crustytoothpaste.net>
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/BreakingChanges.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git c/Documentation/BreakingChanges.adoc w/Documentation/BreakingChanges.adoc
> index f814450d2f..af59c43f42 100644
> --- c/Documentation/BreakingChanges.adoc
> +++ w/Documentation/BreakingChanges.adoc
> @@ -190,7 +190,7 @@ milestones for the introduction of Rust:
>  1. Initially, with Git 2.52, support for Rust will be auto-detected by Meson and
>     disabled in our Makefile so that the project can sort out the initial
>     infrastructure.
> -2. In Git 2.53, both build systems will default-enable support for Rust.
> +2. In Git 2.55, both build systems will default-enable support for Rust.
>     Consequently, builds will break by default if Rust is not available on the
>     build host. The use of Rust can still be explicitly disabled via build
>     flags.

This patch LGTM and safe to add within the release window.

Thanks,
-Stolee

