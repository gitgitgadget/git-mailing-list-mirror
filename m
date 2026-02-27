Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E657D1F92E
	for <git@vger.kernel.org>; Fri, 27 Feb 2026 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772183031; cv=none; b=MeP12VdO/SvR6HgkUrzCh02ZEPxAiNbd+sJDI98imNY10v+xgsXdSLTH/ptfV62Fap0j4dxrea9lTv6QabO/aPQDychwAnZLDZtdWBuzvGERfPUps3bXGfFtJRHzjY1Qy9CUNpjx8Ogji7sAlopf5Yn8bNg2oDatF1kOxCuW7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772183031; c=relaxed/simple;
	bh=1TSsd58LLz/+GrQBG/g529ZV/a4/xZK67u8PCiSRzQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jh+0EQMEpsze0wqNbgpwQ6ZDWmr8piTBNloxduj+ynCeB5APZYCIiJF0N5p9ocDpqkJeve+wZP9IL6C0mKcAEkoMef2B/HTmYWB/oOU5qnaa3CsGJQNbUiOkd5SNcnwi+dR7OkkCYhsdK8KQavrGY4WuRv08f23VYo7nIOh2z3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hs7S0rh7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hs7S0rh7"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48374014a77so20064005e9.3
        for <git@vger.kernel.org>; Fri, 27 Feb 2026 01:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772183028; x=1772787828; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KPoAi2Jj06tlsjxB31eiCB4skHRTYrURC0Y0jO+0a/k=;
        b=Hs7S0rh7aaIgxNQzjMaNRM+lBVA0/EvSPBPg5xhXdp8iZ7M/AWw/xodS3KjlrVhz4R
         1gBjuOGTVFr1pBUl0tzs+xgoCVkgbsef3kGO3hmUGZz7L4nOP4TYdAsIdn5IHUb8iImx
         T8MZ6/8EkoscguVzsMlE0RFwwUlF8jFzgD0cuTltcnepS0I/AZD4gvsehySE+R0+zB02
         I14kBspwtk4OZww7pK97wW/BkgWTVQ7sfM3e90I3FY7MSWVg+6f+fm+2YQ+yyJ9lhseR
         NSU9ywFY5QAKEBrCyBu8k4i7Gm4ZSUK5s+Gm6nj4Td4GjW70IrcWtuzTdGwsjK8WbvrT
         DIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772183028; x=1772787828;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPoAi2Jj06tlsjxB31eiCB4skHRTYrURC0Y0jO+0a/k=;
        b=uQJDJx+ISwjFG/8cV7LHBOjh6JSqTCSSd/87HejFfqZ+Ox3t1UKKIbiMQP/KDyHTnX
         OkdmScPCoJb0rWOIuW2nCDn+PWeyezzrbqEoXCYo4hMTZdIpVKX7OekwkiNh94PLIexT
         hyE4kv1j99oe3iuL/dladZ5AEotxh5Hq2+o3BgpFJql07OEjg2dGXdX3pueSJVtetEX/
         4qMlmsta5UFy4VVrWqdlaUfMJ1fxY4zqqu1fD1E6PZjchBx4O72WaKeENp+WRTYU1tBM
         t6l8huNzqtYYYg1RWUTZCgMYkpO8wj3iLDasVV+QTrEOe3r1FOcyxyz9Lyng7TW8zk/V
         WFxw==
X-Forwarded-Encrypted: i=1; AJvYcCWOZ0zaUlMTDkkOEuAwIj1Wo/EcRS4vyhst2vJ3Bte17N4R3n/RSQn4Z24TbNMx8muTJPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCLTySRCmTHj2Q4WSZOubYTQtS+8oO+9zT84dCOV3GGxFVOehk
	y0l4qYs/QUwgDvXrcR8/ZaQvf7bmZlXKEHgyjT7nG6uLkTJyqqMTR0AJ
X-Gm-Gg: ATEYQzyQN1+ZETlywYto+IAxo+ffPU/NkIkKZGNnopKL+CDX0tS7VnDbjj1ftArt7SD
	pV2V0E8/pc/W2mww+8ZrTCsAYD3KZ6p3JR1ObyfaxbOTCX0suLJzDhiF/npEQaNREYQzz5BgW9b
	8SX0qdHp3Rigc+bT5/cKkTqF6BY1ruJadVA3SvqpMyoVke2T6nwRuHXQD3+Mco0zqVr4dFB3eH5
	kiswEqqEPsKWjA8ERHRqGKIT2cC5SAbqQ8Q0dnL91ir6ZYpneXSmqaSXkkDi+e0qdEjV9EHZHKq
	TKqe1bVzFN15dUPuKecE+q3Q8AUKK2nHFZG3QH0+OX8GjAvz64wajf/ZW+Gk6y8x29LBnLjwTeL
	BuEpXYNy25+F+/Tkgt/zbfvcm4+VWrutCz/mHYHMQpxBwsJXqw+cdjQMcBtBfL4dbrzcvPo69WT
	My/hst0yg1RlODRFHUfR1Czsu3JCUIyGp+jKt1sTQyVowhHiM5o0M6zibfp1bE/qp/2jlRjcC0H
	zeI/A==
X-Received: by 2002:a05:600c:c4a6:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-483c9bc0344mr28948975e9.12.1772183028082;
        Fri, 27 Feb 2026 01:03:48 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c35910f1sm84471115e9.2.2026.02.27.01.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 01:03:47 -0800 (PST)
Message-ID: <1d43d1d0-bf6b-4806-834e-89f545fab766@gmail.com>
Date: Fri, 27 Feb 2026 09:03:46 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][Draft Proposal v4] Refactoring in order to reduce Git's
 global state
To: Tian Yuchen <a3205153416@gmail.com>, git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
 Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
References: <ab45758c-fbcf-42b2-96df-030eef8526c3@gmail.com>
 <b98780d7-3aa9-4838-9234-290b1d72ffd7@gmail.com>
 <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <5e5f07ec-72ba-46ee-812c-d6773a4bdbe7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Tian

On 26/02/2026 17:02, Tian Yuchen wrote:
> [...]
> Although the principle is simple, the scope of changes is extensive. The
> following three-step approach can serve as a guiding principle for it:

There are four steps below

>    1. Identify isolated environment variables currently residing in the
>       global scope. Conduct a case-by-case analysis to map each variable
>       to its most appropriate existing home (e.g., struct repo_settings
>       for configuration values, or specific localized structs within
>       struct repository).

Note that as settings in struct repo_settings are lazily parsed, it is 
only suitable for settings that are already lazily parsed. That means it 
is not a suitable home for any settings that are parsed at startup by 
git_default_config().

>    2. Instead of blindly passing struct repository *repo down into every
>       single low-level library function, bubbling the dependency up is
>       the true goal. External callers of the functions must be carefully
>       audited to prevent regressions.

Where a function only needs one piece of information from struct 
repository that sounds like a good strategy.

>    3. Safely remove the old global variables and macro definitions. Make
>       full use of Git's existing GitLab/GitHub CI and utilize local
>       Meson builds with AddressSanitizer enabled to ensure that the new
>       lifecycle introduces zero memory leaks.
>    4. Many globals like `editor_program` are parsed once and remain
>       available globally. New data flow might need to be designed to
>       maintain the lazy-loading efficiency.

Although `editor_program` is parsed once, that happens in 
git_default_config() so it is not lazily loaded and making it lazily 
loaded would be a regression as if the config value is invalid we want 
to exit with an error early in the process, not just before we prompt 
the user to edit a file.

Thanks

Phillip

