Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ADF45BFA
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708378889; cv=none; b=IhXouT9c5Fj3EUJfVcKFNMg2bAiAsQQp1D/qVO/HTWT7l7TM4vGa0Mcf1ZyKsA3BGD3yamQ5VIvA3uRs+ScVC1hvgzi5utGbIeQ2VXvE2XR6n4wuvn3ymVWIVkQfjTfpWB+4Yyx+pJ/cgOjwsGF7mrgSYyw5eQix6aZ3UwW6zV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708378889; c=relaxed/simple;
	bh=LYCDZkwrpgQyLA8WJcXLpltq/BNmc7/WC44AGLdCvbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SsIp06qPOODJQ7a1kkCLwpN1vMTjRVguG8hoApNVaeH+/S6WouiHa02Z/BkKaBFO3de2AkdeS0fJ9FAvm3Lzp0E3e299m8Xix4Cgmky9+B1Gdd4D3WGHllaHppx1Kf84sdrpmV3xoHlN0p8wBdKZ370G74wNnmRyvT7GjR4imNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gO+XHGFr; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gO+XHGFr"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c02b993a5aso2864220b6e.1
        for <git@vger.kernel.org>; Mon, 19 Feb 2024 13:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708378887; x=1708983687; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xBi0o1dd2GgOHeQ0Z35Fwy2qO4yc97IGD3C4JtmLLg=;
        b=gO+XHGFrFs7WXrpS7l7tL9gCRZU7le2xIHNdSEUe+WVuLUHPdqx55BxesSbwnosWgV
         cVPGWU3hvYyokM7el/mZve5zd51ut+Az/DjJeU/atxCr/cNu78P9p8sds9qEKOKJj6w8
         4D6eFABrONyYdzCNGV13KYj8eCgGQThHCm91kYGvmyEZSnZqfs4pwYI4dcs6aiQQZAPa
         6Ul+c4axytxKshglPVc2/TbI1KQuxYOzrDL0DUU256VGftxQQ962cE/mO82wQscbc1p7
         FkUEFWwyYXOL+RsOAVdXzCVUiGVVcTMQL+YXT2/RZo3TRXIQz6z0n9iIiPlnJO/oJWuz
         tkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708378887; x=1708983687;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xBi0o1dd2GgOHeQ0Z35Fwy2qO4yc97IGD3C4JtmLLg=;
        b=JTMOybs4fXWzT2WIsRFeHCD4Crr1XdZFX6TYvO9UsItR7mSr7oUVGmSHMr4nRhvQ+F
         n4Ui9UTg1LhPmVynTT5k0hp/ggPHWjtDbKoLMzkH6gKCTDb23mRrOD27tj3E9zIjZ4um
         NU4ugIBK+MHthWEdKjsGNzlPDBi6bq03SO9AEgDvKsNkNdpDXELYMMEHuBgJ+xob+R/0
         oZlAqelsfad/mNxIhmhusULbR7ieTQUO8HDsJxQSIBM43qfF+Gvffns+wVU01OXhWt6R
         mzIxMFc5c3Yd4bW61fLMeUl2dVu7TXTF2GloH8S8Oe5vwrpOkF1LqwJNjbgPKo7eS/IB
         kkfg==
X-Forwarded-Encrypted: i=1; AJvYcCXUX7J2QYMjh7Etb3aJfZL75T/PgnSulOpw+VI4pEjTbQq0qYUox0ISdcQKGDhjDJROSjKAyIhlHD1yfMKzw/bX0Qfi
X-Gm-Message-State: AOJu0YwoPIwPFypTDtxmhs2m04vXGyYI0p8LO3AQO80rOkl6kFjANmwT
	ny2TRtpkgLJC+dNgtdriqMm7fEcW4j/TOnlCjOXzEwS5thZ2K0i5Zihc/Gg5Gbdm/Q==
X-Google-Smtp-Source: AGHT+IEVzR8+cRI5O7B59hOGuPgpNihRqwgWLEPn5Bnd6Wg669DH57KSVPY4nxUh5YnY/2dEpviNvQ==
X-Received: by 2002:a05:6871:d218:b0:21f:afe:b9a1 with SMTP id pk24-20020a056871d21800b0021f0afeb9a1mr1448618oac.47.1708378887544;
        Mon, 19 Feb 2024 13:41:27 -0800 (PST)
Received: from [10.197.96.0] ([152.3.43.40])
        by smtp.gmail.com with ESMTPSA id y4-20020a05622a004400b0042dfe8a65b4sm2153759qtw.76.2024.02.19.13.41.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 13:41:27 -0800 (PST)
Message-ID: <cdc377ea-d810-49c6-9124-c450aff34118@gmail.com>
Date: Mon, 19 Feb 2024 16:41:25 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] builtin/stash: configs keepIndex, includeUntracked
Content-Language: en-US
To: =?UTF-8?Q?Jean-No=C3=ABl_Avila?= <avila.jn@gmail.com>, git@vger.kernel.org
References: <20240218033146.372727-2-rpc01234@gmail.com>
 <fc7a8c46-61e4-4b5d-b625-cbc845b81590@gmail.com>
From: Ricardo C <rpc01234@gmail.com>
Autocrypt: addr=rpc01234@gmail.com; keydata=
 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
 jjbjCH/5+g==
In-Reply-To: <fc7a8c46-61e4-4b5d-b625-cbc845b81590@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 2/19/24 03:04, Jean-Noël Avila wrote:
> I'm not sure this would be better, but instead of mixing option compatibility 
> and actually building your logic, why not use a series of
> die_for_incompatible_opt3 and the like in order to clear the option lists, 
> then build your action logic without resorting to special values?

I'm not sure dying would be appropriate here, since the original behavior was 
already to clean up buffers and such and then return an errorful value (-1), 
and I'd rather keep maximum backwards compatibility. Also, the special value 
of -1 for `keep_index` and `include_untracked` is necessary to detect whether 
the variable was set by the CLI flags or if it is fine to override with the 
config value.

This could be addressed by moving more logic up to `push_stash` and 
`save_stash` (where the arguments are parsed), but this would need much more 
rewriting and would lead to some code duplication, for what I think is minimal 
gain.

Thank you,

Ricardo
