Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D580237647F
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777469329; cv=none; b=DS1Gei+AvkDV65yylBeVuWBvG3UzQ/kq0Qqzjw12vJQH3uhYepX2A6cPQK7aL5aDQ3ml8AxFnXWvpyLpiTag2mo58ih0ZdCJd1TRfVRQdWswVaS8u0+xP+TmY+4i6jXIiFDG7YvnR4v+CgWm2ZFVVLM0JNeqNm0971HQJ8FPCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777469329; c=relaxed/simple;
	bh=nk+sVl9dCo61fRzQaScmO3f7iHJ3Z9CpGWuez4I5VaU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jzRBCpWRr/hCq9ArUMxUYcAoByJ2GiiPoFUGnsRDU2A/i6UVwOjmI7oBqOr7rgwc42Bqs4NDGKDlzOmbzzuLwRYy1vZzb0CglNwgtsJdEIkI2wf3R60mIG+Qm+hfZw8vYNeKn83NYGb++nT6dWYBIQkgWw/LcUJ5k1IQFHBKV6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8U0CwRr; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8U0CwRr"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50d876329bbso129260751cf.2
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 06:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777469327; x=1778074127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4IrtQOfhTjJETG0YasWazPhjkLbwsJGoZg+yWCXEZv4=;
        b=R8U0CwRrBHq0Jbps9LZjHHUGPcEmCen7JP64D6pMk8Rsx3P7wT8FRfDFV8lnpynRWX
         cL1qPX7erQ82EVBkUJrNN1eVlwmUnZL0fD3QtikiNRb8PKesdtW/KHhEYclgh9uFCTdl
         pnQ6WBwBWirkoEYPCCSj8I5R0LC4ALJSqExHTyrP/WetZbo+OA43jmp5EA4jAUSiTS2w
         ZYCyLThhP6SAMr63YTgUeAfiSIVwcgYXF61+jlCqK+RHkozmf4+UVmzC03N0ll6dRybg
         Jlw8vF2uC9KrqS6nDe2XrRlbSM1RiSOxKOjondcT8hCPUtAbqvbJWrjN0/a0wGTileCN
         pHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777469327; x=1778074127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4IrtQOfhTjJETG0YasWazPhjkLbwsJGoZg+yWCXEZv4=;
        b=GBXktwrREh39zzgtGxVw+a4K+5QUm1xzyuytkXHfFvJPrpnhyFTu5vbdO3IOEsMAnO
         4jizwL6HIamN0bceMJRyWc+gtRvTcx4f3kJy0ZSTNCBuISPVlFbsX4aF6gFxAsLynSQj
         6tL2sDaFjPMZNZfBWnck/uW9JIo5vFZSwwWXjtnIWsBujaa0uhPAkjw+j/ynEI9Q2fbT
         wuTfEU/cX9Zy+6cDXusgtVXQkewYVdn/VPzGzOZw3NZnZ8vu0xzBX4wVjsxovUfkZzV0
         kaAZRNXTcp9eqhn7atTABXWpjJbUw8OW6IASEiFt5hfZF0xoE9nQvV3nKwF38ZjZr2E0
         1cPA==
X-Forwarded-Encrypted: i=1; AFNElJ/+srwNdjPoeTEn9hg4RBLGMrRhvWw9XD1Vn38We+1AGFtl0212I+4CCd3y7xqYHn6lQCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXZIMif8qZDBXPUkdG14B3NgQ2dS5EFKK+xfs1bXqDAWD2/bxM
	jWlc6zXR3dMeqBspoZY/7s7CSLUSxN1gY5WCP1bMN3AXqoHBHUrtiuJQ
X-Gm-Gg: AeBDievf8LhKphpw8XmFmkrXTBUWzy2bW0cRlaiKGk00o3/w9gttkMu3ROFEmAT9+B3
	s+ytikhWr23XLNn/j5yY0ETVYuOtMzCmvoCHTGN3sp+oVnZWycg5RpNSAmWG4vhcf1Wk6yPFwLk
	UmbQSR99MIdplwT/5PZ+1xkXLWOSQogZa0c/1/JdZDNTa0tsGv+F8VFQCCRlOKW9B14+3OlGS35
	kgxHYoUDnK8f0dmgXOzS4KnABzQkUTydBhwvyHmhJ7zCX6aaZ/MbjdaTEiqBH6wGfLuTbOepqZv
	5UvfAbexrrjChnLm/lL6uKFZTF+ZKuV6hv/X8GTOrTLOriddWv8JNxj+0cgFWOHQT/o7LmjZDgY
	lRIGpsGhE8fO1jCcJn2F+P2G9ALjVSESHtdotKVED0Xgz5AC7jlNmi9OEHIr3xHFBY4clkYmRB8
	oA29CYBXF3W0CFPaah4Ehm1Sz/5r7yGC/F3lEUU6DIOih67ITnbdOz0v0XNarNuz953jMjn2ebJ
	QQUyKYNgYMYrgLekRHEiplTDZxqOwaK8FvqPlXZuqnCluCvP8CnMQto5ndzZfbySKiAF/QR
X-Received: by 2002:a05:622a:5908:b0:50b:4b3c:7554 with SMTP id d75a77b69052e-5100e0f46dbmr110271491cf.10.1777469326615;
        Wed, 29 Apr 2026 06:28:46 -0700 (PDT)
Received: from ?IPV6:2605:a601:9b88:8300:c8b0:7338:485b:4bd7? ([2605:a601:9b88:8300:c8b0:7338:485b:4bd7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef70dcd2sm20157266d6.17.2026.04.29.06.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 06:28:45 -0700 (PDT)
Message-ID: <1b2ce8fe-7c99-4dde-ae07-1443d03cf523@gmail.com>
Date: Wed, 29 Apr 2026 09:28:45 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] delta, packfile: use size_t for delta header sizes
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.2102.git.1777393580.gitgitgadget@gmail.com>
 <3274cba862ae42a6813710410274a692ec0f5d29.1777393580.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <3274cba862ae42a6813710410274a692ec0f5d29.1777393580.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/28/26 12:26 PM, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The delta header decoding functions return unsigned long, which
> truncates on Windows for objects larger than 4GB. Introduce size_t
> variants get_delta_hdr_size_sz() and get_size_from_delta_sz() that
> preserve the full 64-bit size, and use them in packed_object_info()
> where the size is needed for streaming decisions.

> + * Size_t variant that doesn't truncate - use for >4GB objects on Windows.
> + */
> +static inline size_t get_delta_hdr_size_sz(const unsigned char **datap,
> +					   const unsigned char *top)
...
> +static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
> +					       const unsigned char *top)
> +{
> +	size_t size = get_delta_hdr_size_sz(datap, top);
>   	return cast_size_t_to_ulong(size);
>   }

I like this trick to use the 64-bit implementation and only to
down-cast for API compatibility. This allows a more gradual
transition than if we replaced ulongs with size_ts everywhere
at once.

Thanks,
-Stolee

