Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED628134C
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767796584; cv=none; b=Fuauo/yI4LvgZvyic0kS10H0f7PuD8ZSkzwTYUPDMjZh6tPsQLa6To9qQOxtTbnL7CPElvce1Kk3qlEYUg5OjhQ7Pu2rln0zp97YQK/f/dAUrvnbqrXec/7OWfxRHPma0MOK2xafoOcwvYvdV64fD+rppAmPvasjWxmqgN8a4EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767796584; c=relaxed/simple;
	bh=8eTci6riVPImSbYDxNMx9qQGtOrFHo0x0MvuxImQswo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iS8MXQmIwe0U2YCeWahsvrTvB18ugPm2+pkxL+sWtN/zG5UbHhevOwkuE2dtYPsTKjSkwY5fVoGtjqpvbHdg5462IjFFINGcnJG2hZirSerSPIYizMWSOzi2T/mDAmNYjfGXl7pHuV3qZi7nm9ItgzWAJAqUc/w7H524O5XKTKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6pcXbGs; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6pcXbGs"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-47d493a9b96so13137155e9.1
        for <git@vger.kernel.org>; Wed, 07 Jan 2026 06:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767796581; x=1768401381; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=o/LFLjhORwqmmurRaIEPG6KXN2KW3/KvU/NxaxOg61A=;
        b=I6pcXbGs/baWG2YnLUOjmDZAsveNcwUwZaUmXrgSf2sBfcNpd6e3xSPNdaLMvpCfmj
         TrYMrlKLgLZYwqVo+0DKitqafPGtQ5fuJq09a68wX1typSHb1YSsPL1wXPkSMuO620uq
         7WAEUAIi1CbymycBtL8O7fpcNUkEWlUPpvOHIfedOlX2qpfeh6ZA5zqk5cq7fXigxacC
         TGL6r5A1x+cnn/M+N58kBDMNuL86PFpgpMxgjXLXIBwlt/M0pgFKY9EtAtEfw8HYfZZ9
         NXZ/r5vZJtm8SOeEGSXaA7Uaz/AhIbLXPFn1JCxkHVFs/YDHZ9bfzCYvwQLaD1eKgXC9
         L56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767796581; x=1768401381;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/LFLjhORwqmmurRaIEPG6KXN2KW3/KvU/NxaxOg61A=;
        b=LV3miOd+sRpmlTyVprSb0n/bN8vF6p0dhD4ifZDzhSeYh+2GA08uM6YUd8oNfDenPk
         GUlpmJqaoWckRiVlFYIgnoB/en+ylBDNNLJqKu45Mv9oRi48DOewWzQ2r6u5U469AVsr
         CPvqtdj3H66SVpuwxWXhfz79De3qnfc4YTivZ4SvPhlAiKqvs7+/zHyz1vckyKvNFn5L
         c3MDUTQ2od8KqAbZrxH94eOm1ktzQ9toX7GWwfCfFCWQruL00a/9UeYR2uS9Rjoz/Ttc
         a6Vghec9fN5SxZQfdLZo+rmVio9SU3R00IR8tb+p8/WOlwIVR2MgFwrg+c1YPfqvJxyC
         xN5g==
X-Forwarded-Encrypted: i=1; AJvYcCU8SKUD3Foh7WBOI42xMJS9yiC8o9CsncJm3HX/gaQxFFBxZ2ac9kDAJcgzSNgMlITK134=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBbSmbfctF3+tBhRFS0RvWSDDFVO6ZIcQLI8fe+pS9ELLbPzPy
	7XFuJkK/b3VWU0pR6fKtCH7dWXLj7NPKIgsUFnBWRpDOf/OIF1xaPunV
X-Gm-Gg: AY/fxX5+Rh0iSU4gdSVK4+o+hV1FpkXbFxVu9ieyEpw6fz/RO/634f8m9qs1nfkG3qA
	8znSbkbzOf34iA9zaO7KdjAtLU218kU1NEizvu4POwQxVF5WHgjKYj225C03KMejxrxAHppMn5v
	3M+521qBTgFfa4bKr0KqEb+B7vqQ0VIfrpzdtuJY4uaFmNK7aEK/r9ZkQShABKzD8KF9Oe5xlw/
	oZ2M50ZlnwR8N+PmeLVz+jeGlLx/CQ5p+Ihw5EbGF3lKSbWetUN4IbbR1YhGyl0/VAaaU1yddTk
	vGFv5XrpmG39uFwlq6c6OT4Rd6uMRn11G+ga/CBXWythJsLDGMtNAzYl3sfsjlTRulcIKSQ2Sd0
	dA2AJnN+Nv68osah+xZsAbm+y5zfioqAgPbkYnt+9xIFfpByfQcg7iMqiEjmfFRO2YQZkLOU0Om
	xw82EyaWbf/2pqjfd8JC9juS+EKlYBp1F1pYV5FfaTa308Nin+i5hvpNz5q+iRK8rbcg==
X-Google-Smtp-Source: AGHT+IEJAxIrCaoWIruusJYyYbiwUv9gpuCu2IWIbzBntuQFJFqEt6pIlPWgTju7sKX95tnDx4Eu4w==
X-Received: by 2002:a05:600c:b86:b0:47a:7aa0:175a with SMTP id 5b1f17b1804b1-47d84b3bc85mr30148175e9.26.1767796580770;
        Wed, 07 Jan 2026 06:36:20 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5? ([2a0a:ef40:627:1f01:b22b:2092:b7ed:c8f5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d870dd5b1sm14827595e9.4.2026.01.07.06.36.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 06:36:20 -0800 (PST)
Message-ID: <072dc5ef-e750-4023-bf6c-30b4b143beca@gmail.com>
Date: Wed, 7 Jan 2026 14:36:19 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] ignores: handle non UTF-8 exclude files
To: Matthieu Beauchamp <matthieu.beauchamp.boulay@gmail.com>,
 =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc: Matthieu Beauchamp-Boulay via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Matheus Tavares <matheus.tavb@gmail.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2157.git.git.1767478617198.gitgitgadget@gmail.com>
 <20260104173524.GA29867@tb-raspi4>
 <CALH9GrYi0dYo4LJg8ww1cDOETiOT44m0zQgkxLsxqEuMmv_myQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CALH9GrYi0dYo4LJg8ww1cDOETiOT44m0zQgkxLsxqEuMmv_myQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/01/2026 20:32, Matthieu Beauchamp wrote:
> 
> Yes you are correct, but I want to address the issues for users who may not
> realize that they used the wrong encoding when creating their exclude file.
> For that case I don't see how the fact that powershell can be configured to
> UTF-8 helps, aside from preventing repeating the same mistake.

My concern with that is that it ends up hampering collaboration with 
people using bash on Windows or a native shell on other platforms. If 
they append to a UTF-16 encoded .gitignore with "echo path >>.gitignore" 
you'll end up with a mix of encodings in the same file. Similarly if you 
use powershell to append to an existing file that is UTF-8 encoded with 
"echo hello >>.gitignore" is the appended text UTF-16 encoded resulting 
in mixed encodings in the same file?

Thanks

Phillip

