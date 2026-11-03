Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793692498;
	b=XkIKiethT/u8doWQpl2E0o0hS8eYKfhf9nV1zo5UlKvSeSw27n6NR2TacHBug9frk6Ec
	 Kjp9VXl7G2PLXOtd3dglro5Az2fZ7ClzVJ3rAIkVR4DC98wCxhadYRzv70wpDKz6MZe4T
	 CbUef964ONp/MdsbB9zamIlWuWybqXl27nYulVP2gHbnLzfpHjwds34k3nt8w/86dW5Ot
	 pttwSy87hGaxtvoDzWfWVr0mCe9q851dqbMInulocIIHVJBIzoVY93UcjxzM31E9jG7Rj
	 8J6pRQxm5+v38f0SP8/at5yEp0jbtFo3ghhuKBTxS2lgUkcTKtULSs2zXPNXt6Troig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793692498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=zISrTlmfAgg/UaxZH7pTjQTTV1qgn+/0E4ODmRsYrhA=;
	b=b7ame6A/1sAFrPYDOfLRQGLwZWvnUHnUKxBiYV772OQA8iPm1L/XaPDk3tV9F2AKmryp
	 lLxHf+0S3+7oYiu1xqU090y9HeOiajvFQPaVr2v1RQt9wD2onKHpFj3QHQEDLlcQYL1eK
	 /DSMyN+P28dO3iENk6NUXU3ekoHF3EyV1UrHW9pAPObzuw8w5JOAQXqhBM8Mv6zlMWv8m
	 t9H4Mvd9FLTob+8pD3AF4UIxfmCJ27lQa02tTBek+F1tYnA9o7rvXBnhYrGM4Vta0XO4+
	 H9ronmkJMJ/iLv6YmSOZI15/qCA5TjCC2MgijU5WMkgs1IrrvqGukzVQq45k1ZnGzQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="o6k+QKE/";
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E497606A334
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:54:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E497606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o6k+QKE/
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ace1f3897cso1777161a91.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 23:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793692497; x=1794297297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zISrTlmfAgg/UaxZH7pTjQTTV1qgn+/0E4ODmRsYrhA=;
        b=o6k+QKE/WtJkca9kbbCI5xXk0BsnqbrPwcqpQPDySrWnh/w964PTYROu54eIyAoXFH
         hvfzf8mNrEZW2ibr/Teo6IadQz1W3dQTykJdLC9WoyuFu5HsubLTpdGqeauc7//Okg6O
         XnaQ+fTfiO9Nj9n+/kWoyFy15swNNt88uKwELq6jYNV/cAbZM1edzlNwg78uyxaigzqR
         LcYEIMDdvxZylVmvXGStCyD3sg+YDa7d3ciC7AmRj10uCaVMZyCtzCROkfGGN0xzMLQp
         JKdmzU9RXmBNbt0kGqCSkCA0yblaTV9R0ErLrmKmm2aYKyrgsEUCJoRpj8fJNrh8optG
         NKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793692497; x=1794297297;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zISrTlmfAgg/UaxZH7pTjQTTV1qgn+/0E4ODmRsYrhA=;
        b=a1Z3AXgz/HCf/JgGl6jXFlUS8KCxAxXZ08x+cFKVSCBg71DnYM2OmQ1cyiLlC3pidf
         j1mA6Ea4Gc8jrLv8rk48Oev3wO1LviZ/pAk4vHh6feoS3eM3YWPbY1mH54GkG2eWMIou
         EAU7dI+CNn6fhb6x+JB9+u6dS1OsFL8GEIV0D2rTaGb9/z+Hbd42wa0uODuO9dy/i+RX
         ldZASLU6oCPY0lKZIJ+x2hR4yHqLXKtZu1iE/vxM704UdtQsddlBMzr9jamtgCGYhQrd
         +bvZev2gHFLARcC2OtAltwJ4Ul5has3mpzBTqWnOlHJnchef2gdzuSw5SIMIjq3yMt8f
         G6ww==
X-Forwarded-Encrypted: i=1; AKwUvBxQR+g0yCRoaWGPDR8xn2p8chJj3/orBU0gXgbWg/RcuwTp2G2ZNiOS8BbzFyklGT468n4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zDmAdX1aXxgGsQT/7vrEPjMwcZI/eHYLpfUUVQ3QcKVLPR9ep
	++u5nA5LAH6D4R2NbrT01jO8hLkcj1K4XuwB5pLREovhspjnLC2scleq
X-Gm-Gg: AYBFou0VbZ/DEq58wMQt63kG+s2k0s/rpbc5Kya3yPjMO215GUknLuzG9xxU+Dm3DTx
	vioFFdKvwqvNmPHzvObZr+qbgZI6/ZJqjMtvEv2MpYJDcycHKSwq45T5jfUHwjaSrdJZz/RSzvV
	Ka6BCjyqtmixcDX9C8NuVTE8Wv4lSmkK5muWI804iOs4UijIg79HoY+REksYZ8HglrHQDR92tUY
	mX1N/ZEfycpm7djIoYR4pbOWHTgoOmd/YwYQDpD2kEMYwqiHedklnIFh4iKwHifnJzWuynlUK3O
	jU/fY5hKuNngSVKlweERoJexwk5dpdL0NIzzdAn+8KVFwYB5SEMEmW0vn39DbwvyGfgGsPo+gsN
	MzziHdiU6ooNs3DXlTbKI9VuWONr41BB+IasYK9qRIoKfat3HALZVr1wcjHUp0bYRuVO/S1ADa+
	OW6xBLYfF5L4CkFBPDrstTTkAz3ioPr9EIvjRAAt5QYKo780d4tNgjvPak4pAwFHHxvngejdTwj
	1Y9via2ymQFmISPOJ3EbbOpgt9jpzaa95oSI5y3n8Q+6gDmL00EQ3aPbLhe8A4Xt6LTp5mTxcW2
	kUnFT90F75JonYVU1gdUXmWWH6Zv281ce+nmNyI=
X-Received: by 2002:a17:90b:164f:b0:3ac:9ed8:f310 with SMTP id 98e67ed59e1d1-3ae8984da7fmr10954102a91.49.1793692497072;
        Mon, 02 Nov 2026 23:54:57 -0800 (PST)
Received: from [192.168.0.11] ([106.51.26.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c627260sm3076573a91.8.2026.11.02.23.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 23:54:56 -0800 (PST)
Message-ID: <faf0b5e6-1c63-4c68-9f23-42a452879854@gmail.com>
Date: Tue, 3 Nov 2026 13:24:52 +0530
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] Standardize early option scanning
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
 Cynthia Uche <herroyalpriestess@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
 "brian m . carlson" <sandals@crustytoothpaste.net>,
 Johannes Schindelin <Johannes.Schindelin@gmx.de>,
 Justin Tobler <jltobler@gmail.com>
References: <20261012074413.337183-1-christian.couder@gmail.com>
 <20261102151447.734680-6-christian.couder@gmail.com>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <20261102151447.734680-6-christian.couder@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/2/26 20:44, Christian Couder wrote:
> Changes since v3
> ================
> 
> Thanks a lot to Junio, Kaartic and Cynthia who reviewed previous
> versions.
> 
> There are a number of small changes since v3:
> 
>   - In patch 2/4, a `switch` statement is now used in parse_long_opt()
>     to process the result from lookup_long_opt().
> 
>   - In patch 3/4, a parse_options_check() call has been added to
>     early_scan_options(), after aliases are preprocessed, so that the
>     options are checked before the scan relies on them, rather than
>     only later by parse_options().
> 
>   - In patch 3/4, in "parse-options.h":
> 
>     - the comment before early_scan_fn() has been improved to mention
>       that the `option` argument may point into a temporary copy of the
>       options, and
> 
>     - the end of the comment before early_scan_options() has been made
>       clearer and now mentions that EARLY_SCAN_STOP_AT_NON_OPTION is
>       safe to use even if PARSE_OPT_STOP_AT_NON_OPTION is not passed to
>       parse_options().
> 
>   - In patch 4/4:
> 
>     - the comment before the call to early_scan_options() in
>       cmd_fast_import() has been improved to explain why
>       EARLY_SCAN_STOP_AT_NON_OPTION is passed,
> 
>     - a new test has been added to check that unsafe "feature" commands
>       from the stream are refused when `--allow-unsafe-features` comes
>       after a non-option argument, which parse_argv() rejects anyway.
> 

Thanks! This version looks good to me!

-- 
Sivaraam

