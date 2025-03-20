Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0449421859F
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742469038; cv=none; b=AySVKtF9sqpwolWffLRtthW6/UBwChqG4a0yC79gxntr5N9+oJMiBWzv/28Jo4BfSQVHGlH1vUu2m3CLTMC8QonEzZgkf8XvvJM17J3h0vdA5y+0I2LdbmsarEybzmhzd1MVEJKXm01S8SRyhJv7+u3mm7EFHdcH1D7dutVru1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742469038; c=relaxed/simple;
	bh=TfeNqELcCUsrZqGkgFXiTT7qgCLh/QqqbECsqYw1hC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KHa0FPAioYoUCI4fBP7Y5Vtjt01+9jt2G50KNKuovDq4MTrnjKkRp3u+kaeqLF403cD4kE+30jm6Col/0b43uFodKoiP4vCnGS/frXCy8tfV2UBhisLOvhO+OmYsKAnmBj6aKK85Zwr2TqfN+QbqLaeovGu+klRJ5KuckUX0uqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IleYgt69; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IleYgt69"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3912baafc58so516387f8f.1
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742469035; x=1743073835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VS/Ia0pGqBfXQg55btXLzHmdnC0oVEw9mp4WMzGu2X8=;
        b=IleYgt69z/DDvPWoM+3EZA/Pj1zDNVyOTIekX8klQHKCG5xvdpF+wiA94TdZiHdlAA
         /OMAxgy/aVzqWJzuwn5q8qknFQ0dShxYXhSNAJmsTGVfisC5glHntirEWtsBvcYFjiPF
         uG4nVHw6MEgIpeY3Ho0CE05tKJn/7CGl0lxItwtEUlttZxHuYMPw1invLiX75MEGmvRs
         3r18YpOv8NqwkFa6hGWwpvLnXXS2lFVr47BzI8G7TWDTDn51kG8ZiU3rLIjqjGmMpDmz
         af83X/aVDaKEsfchwddohVCg0kviI90nnhyUK7EUHzIWmyTIcom26xs2GtxYSTi0hdo2
         JtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742469035; x=1743073835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VS/Ia0pGqBfXQg55btXLzHmdnC0oVEw9mp4WMzGu2X8=;
        b=DHTwtsELUavQJNwW2noBYX1OjcMkU/I8uYN41NUUIMySgXeEOtYp0p4r2/Zh6CuXCb
         FhnjUTx/23TOnOTikSgWa6W19Jsgl0t+M8J4cKj3zdKqHKRfdIXHzMvaS4pvlQkwUV1L
         ehkmFqbpnVBQHhSYysZ58AhaH1UBUBlZNGPH3DmgXbwtxTsF9iesc7LvMAD3QpyUWQ3g
         U2tewRYscPi7Uft3+zMJ4M8/o1Ep5Ofv/cWvxIIZgNkZkiA3HJbJC3ScQteM0eN91jvR
         u8jvrqE2oTN/ClY6StQCA0v0NrZQwlDcmRRqhByOUiUWjwijFdwgCgjjFNNf+t4DexvI
         bZyA==
X-Forwarded-Encrypted: i=1; AJvYcCVZd2IGxTFcaOR5maflQ1REDpPyCvcLe47bQmKBr4nf6AVADlY9C2pHPJhC4K3iBN8oGlg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2JrBweHyX11TJRfqxeBRr+lUnq6BYgEf8A2WpKdA/r5jsiXbp
	woMGGwUd7alVvHU1H3+g0KSDfWtk3YZ16p9Q/br1lEvLWsCEOOeM
X-Gm-Gg: ASbGnct0IZQ90VELxYj32Tv73zdqtJSrHJ14yi5BuOqunpkAk7Z1hwlz/jFPrvC+ugd
	jkVMANqcLXfBcIF77gQberohYg34sfDbih5uf4ZPlcdZ2QgvaMtzXj02xHQqEVHGSH/q7ZYsVJS
	FWfY5vSK6mKJY1RUkioSHxDwf5kMHN+/59//yj+wLU5yTZ5Ya8yUyCTnYMlyP47zy1XSrPXTROj
	cyaX/yP+yZsf2l1oVJIQuzI4ebf9wd594ZEbrR+JuMlj4pbhzKpqpeL/mDiULIusq3HrmRcg9Gy
	uNkhx8q0ZGhIWKOCDxaQnpmFViVihHI+zpk/YHmha6wQrMAvN06bA74YVnWV5Ega7CpfSRWcOQg
	TSRO021Z2iBuFxtpDl5PsR0afHipPf2I=
X-Google-Smtp-Source: AGHT+IGGBuVpYZzMd62cVHDRV2l2xGw35lDEJcvxlTT0LTf6jsZaGCE7Q+Tjpom55Mp7Q0r611pfAg==
X-Received: by 2002:a5d:47ca:0:b0:390:f699:8c27 with SMTP id ffacd0b85a97d-399795acae1mr2522758f8f.12.1742469034945;
        Thu, 20 Mar 2025 04:10:34 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c7df3506sm24184740f8f.11.2025.03.20.04.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 04:10:34 -0700 (PDT)
Message-ID: <926210f4-a8ff-4ac2-8b7f-85cd5598d77b@gmail.com>
Date: Thu, 20 Mar 2025 11:10:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/2] clone: suppress unexpected advice message during
 clone
To: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im
References: <fff634dh5qeb4rgjqn7cru7v4a2voj4us4thvwtttxjcdnu2bu@jvv3htcon2ul>
 <20250320014646.2899791-1-jltobler@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250320014646.2899791-1-jltobler@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Justin

On 20/03/2025 01:46, Justin Tobler wrote:
> 
> A side-effect of this change is that the location of the first
> `git_default_branch_name()` gets deferred to a later point of execution.
> This matters because `git_default_branch_name()` only computes the
> default branch name once and returns a cached value for subsequent
> invocations. After this change, the `git_default_branch_name()` call
> site that actually computes the value becomes `guess_remote_head()` and
> is configured to always show the advice message.

Isn't the fundamental cause of this bug that advise() ignores 
GIT_ADVICE? I'm not really clear why "git --no-advice" only applies to 
advice that is guarded by advice_enabled() when it is documented as 
disabling all advice hints.

Best Wishes

Phillip
