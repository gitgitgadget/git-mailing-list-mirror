Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC422AE9F
	for <git@vger.kernel.org>; Sat, 19 Oct 2024 16:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729356427; cv=none; b=RRgetyweH2edKk9LyCkL1DxSt3JZkMoSKpGNjeF46Q/02K48QmU7vspJYNGCQb7JLVoEPXh64JXDlX5zbE8LPURAL7Wmsf3YIBkpaJPkDOoDOIeudLN1sQ8c4wan8U/NE2M8Iz0AnABcTTQvDa6K79FYMK8XVK2RXU7ergbcNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729356427; c=relaxed/simple;
	bh=cmNan4QKAiD3fw9Tj63eASg8CmfaqTYjPftuXd+UmWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y/BuYcEI0IFXLhuarhHkpjBlbgFGejUauKS+ypIFdAWX0MfAv4HmpDC2XNeZDszG9tthUyteqIDzrrThM5KWsuEYPBWDCSTXQ07CEFvzLCuj0Lk8ye2GJELhlC2hYJz1K461cW9vSUkyvXWoWZeAEotSFZQN7SfzdCehw8WFA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FjnxLlM2; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FjnxLlM2"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso2787584e87.1
        for <git@vger.kernel.org>; Sat, 19 Oct 2024 09:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729356423; x=1729961223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=agRSfJoeMef8IozCiSvIryJb1u30xGsw1bJ2sT2W9ho=;
        b=FjnxLlM2WtKTujbje9O7lTgQbn4AFa65WJW+FqJzACm4wKHRUJq1Uney7+IzW9lTnW
         pJ+Bx3KW03Xw2WW2sgs9Cb3TWhHH4u0JK0wA/1yZy2MX1oOtZ/vJ7L+cqM9o01AFAqoS
         lPorqYxlwq6d5hw0sf6KfpPzTwtwWX8gH0M0+xmIBxJja08b/CxFToqTxViosfM+ccXN
         bU/3KDdkO0baotBcRBYgS4ARYw5e4m1CJHTPPufRZE4YBlhMtFMca5QJorJntP6mrJIs
         FCaZ5gk2XVxALVF0OAB/OLDJ6gm9ovCckikVdKVKy0Js8c8lFFU67LDQjsXbOxzmwqny
         4Ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729356423; x=1729961223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=agRSfJoeMef8IozCiSvIryJb1u30xGsw1bJ2sT2W9ho=;
        b=hgut5/vOZzqvgKvbnCBrpIFHrHkTdViOBeEv4cr2hzmlAw/c6Pc+BsyfkZcqExMc1T
         p/VgXRdAzTgSazt4jo0rNoCorEBI3N0sAouo6ZMvCua3Qwa41KXZpAcKjLzApu85W9LL
         QOjlQmoTuTvcGwMbxQvZDU0s8DMk1oAA0ZaNJVg9Eztne/oRkyA3vEq0UyTwaN2CMvJz
         Sh9x6xr0jW7JN/p4C/H/h0SLN2x5wFe1LtV0pxI8K+nsuiXi/vddqwu+/O86zd8Xl/wZ
         MeKjRTk39tRFP9Z8o7JY19dKTvJHnGf/49Ori3Al3lebj8D765qv3NO5++Ke2sJYciRB
         I/nw==
X-Forwarded-Encrypted: i=1; AJvYcCUFLvzdR+jzSMXFVXsWAve0Ds9J3J7+hfEnF+AUTUUpDfCaSyC9mf70WHI+L34dJ/xrKR4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38z/mowm9oBc4qlv7vqgGT2ugLb/bRoQvH4BGZpsUuIr2XBEQ
	+VUe1NTPsYxMZAc/0PrVXvlSEBaAq5KnxtpGGzI4A01MdzXIfipA
X-Google-Smtp-Source: AGHT+IGKsARYGaePPZpSS//Y/rFdFoDQfUGJA3YW3BYZ+hZ8+gZIYq9pt3sE4ZEcm8VFQmuw407+Fw==
X-Received: by 2002:a05:6512:1291:b0:539:f035:e158 with SMTP id 2adb3069b0e04-53a15467874mr3159583e87.18.1729356422684;
        Sat, 19 Oct 2024 09:47:02 -0700 (PDT)
Received: from [192.168.1.216] (89-67-228-254.dynamic.chello.pl. [89.67.228.254])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151b98d6sm561093e87.111.2024.10.19.09.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 09:47:02 -0700 (PDT)
Message-ID: <72184384-07ff-4f74-91d7-280ca78407b5@gmail.com>
Date: Sat, 19 Oct 2024 18:46:59 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] doc: document how uploadpack.allowAnySHA1InWant impact
 other allow options
To: Piotr Szlazak via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Christian Couder <chriscool@tuxfamily.org>, Taylor Blau
 <me@ttaylorr.com>, Jeff King <peff@peff.net>
References: <pull.1814.git.git.1729112794671.gitgitgadget@gmail.com>
 <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>
Content-Language: en-US
From: Piotr Szlazak <piotr.szlazak@gmail.com>
In-Reply-To: <pull.1814.v2.git.git.1729355997353.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 19.10.2024 18:39, Piotr Szlazak via GitGitGadget wrote:
> From: Piotr Szlazak <piotr.szlazak@gmail.com>
>
> Document how setting of `uploadpack.allowAnySHA1InWant`
> influences other `uploadpack` options - `allowTipSHA1InWant`
> and `allowReachableSHA1InWant`.
>
> Signed-off-by: Piotr Szlazak <piotr.szlazak@gmail.com>
> ---
>      doc: document how uploadpack.allowAnySHA1InWant impact other allow
>      options
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1814%2Fpszlazak%2Fupload-pack-allow-flags-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1814/pszlazak/upload-pack-allow-flags-v2
> Pull-Request: https://github.com/git/git/pull/1814
>
> Range-diff vs v1:
>
>   1:  8a2673bdf31 < -:  ----------- upload-pack: fix how ALLOW_ANY_SHA1 flag is disabled
>   -:  ----------- > 1:  2a9fa4dabba doc: document how uploadpack.allowAnySHA1InWant impact other allow options
>
>
>   Documentation/config/uploadpack.txt | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
> index 16264d82a72..0e1dda944a5 100644
> --- a/Documentation/config/uploadpack.txt
> +++ b/Documentation/config/uploadpack.txt
> @@ -25,7 +25,11 @@ uploadpack.allowReachableSHA1InWant::
>   uploadpack.allowAnySHA1InWant::
>   	Allow `upload-pack` to accept a fetch request that asks for any
>   	object at all.
> -	Defaults to `false`.
> +	It implies `uploadpack.allowTipSHA1InWant` and
> +	`uploadpack.allowReachableSHA1InWant`. If set to `true` it will
> +	enable both of them, it set to `false` it will disable both of
> +	them.
> +	By default not set.
>   
>   uploadpack.keepAlive::
>   	When `upload-pack` has started `pack-objects`, there may be a
>
> base-commit: 34b6ce9b30747131b6e781ff718a45328aa887d0

PATCH v2 which updates documentation.

I wrote 'By default not set', as definitely 'Defaults to `false`' in not 
true.

Only when `uploadpack.allowAnySHA1InWant` set to `true` or `false` it 
will affect reported capabilities.

Regards,

Piotr

