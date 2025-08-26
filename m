Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0411A256B
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207252; cv=none; b=U9rTBnszzIrxEe/rALEfh253Vb6Wno9OQwWQrNBcSEcihf23tWmBK5mFmu3LcVNpgDbr4wCzS+P4w976zKBMcAOCrMxQ9fB5ZxyuopbWrOkfSboM6p59btbqkJZ8tIA32RLpxxtftr4kQZhlbuklPmyefRG5d1hHaWnvaQ3XxA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207252; c=relaxed/simple;
	bh=GBIsi4Fqp/C/6P33aOeN3ignzs+J+X1T0/CUiNux+Og=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Dza0KXwz1DPH+6+fUuRE+hNIu6A4dEKjKHMWCwEs28U6jE9uq36GKzQZ2uH2/VOChREqHZ/PP7cjHc7U/cx/fAG8LKh3WEA6W1QqcscDol2pvna1U6q+kaEYjsoLy1XlZ1+2eUIykxj8wdzn3HBXHF1CL35t9YxXK3oin5c+VHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHLNj9iK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHLNj9iK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a286135c8so32782615e9.0
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756207249; x=1756812049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wctkAbK+eC2n4QkR9L3efcJAL6oCP6Iiyiq+nwM5Jsk=;
        b=QHLNj9iKjviyNgYNO6kuxRd5d6UTze+BjWFn4HfA9y00loAadLVn7yIaHS4PvlHwJM
         m1cPghxbfeWGZ7yhGGYPK3a+jbF5clVQtFrupOMGWfSKS7d3K3Eh3XNQYaWx7vwWySHR
         NCJtT5t4/HbnJ9JJVBooJT6vXNRse8Qoz7pTrHmpdbBGHYhUVwW7CwMDzQzlU5lhkVFz
         F9LV8RMH1AgeDF5FK1iWiio3xMc/SYLVjuyHBM7vOVgpEE/ngXNMoeos01Ywp4y8pHp6
         aJCuvb9iYJkoVPTMZzra1kK4TpFrtPJnHRTm1AXWJnxH3UUUozVSzeMaRt0hn3K+pmI+
         Ajiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207249; x=1756812049;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wctkAbK+eC2n4QkR9L3efcJAL6oCP6Iiyiq+nwM5Jsk=;
        b=Xzghr3gR6PyGVsNAHidX2HlsSwoJ8+Xq7p8legCxCJK8Wvq5+rOVlOpwbIQatdUa12
         JzhTqaQcHLMQKdJgnW9+DrcVptKuZxRYffn+e6ZYYBTpbiWttwx4w5iUsatf/QpSBWoE
         flQrNMpw9PiE5FCw4iAtCzzRHITNNF2DZRr3h6ml+LdodWa7KPzNBMKj5A+HOMb5Gz/c
         NWp8BkYCZxuQ+noieH9MsRHrvocmP7S2+zsDhM+4zxgHMvADcgRILlZewrS3ipEOagYo
         O9Rt81Y6K/6vlJ2oAizqkd9cNVyg13whPLxvTsA8fTXYTMjhStqOEFIwLf9+7R+WAm1S
         js0g==
X-Forwarded-Encrypted: i=1; AJvYcCVgbP43ZkF48vdbL7waRhE9gojSNiX6zSXiFCLZHKLvNO/iP3tKiDwwCsrO1jvIBC/ymoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk13L3+W6EgDZGhl81mLwL/QUgjxlI2sNXXoJisaei/KOdI/B0
	K9c3NHbzxVsE9b9IG1a2k4j/3zMgpjnmBwtnF1hj8OHi7DM4JMoGIAmF
X-Gm-Gg: ASbGnctZ7nH/NUP1/O9XpC6IRtgC9F4T44GFDM4Ala58doDUVZQJZi6ZQLaxFU7Aa+d
	AiC6tvlAkBW+/d9gpBp1WxTPR4ZoVDWzuu+qiH5TxF20Wyc13dPJkemjuG5bjIWK6lgPEhs5nC/
	/7OhYeNLlxdqEvq9JeBYsxmeyCdTaXsxd7qZAQhVeDkMxoDeulq6DQmYkWNM/uVR/3lNJXI/xQm
	l6u1dtNVr8yO85gHrxtYK7kmhzFxk7wcOFR12u0J2+3Xwr7+RUWCjLgJ5PEj0Svlp6qLJztBfCo
	gA5aRlhTmF73DFpbGsMU4Uo651hpfeh0iqk30xVH0URKVwgArqY7ztK1PmugFRrHThFERFAFkrD
	xDOoeR6ZO/g/EBJ4oM8/kh3u3Nylwud6KZ99uXu9ZkwCl0bfhUILft9rUzXe9UCnmHaGzq22b7W
	LyYQnNSs/gGfCm
X-Google-Smtp-Source: AGHT+IEz8TsIU9EkkoP6r/LOjk08GoiA/jE+By7L2NTtuQuPK0UqaLsGwQkOCjelIypMYdADxO/v1Q==
X-Received: by 2002:a05:600c:a20c:b0:456:1146:5c01 with SMTP id 5b1f17b1804b1-45b6870d983mr8563405e9.12.1756207249181;
        Tue, 26 Aug 2025 04:20:49 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c? ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b57487910sm145703735e9.15.2025.08.26.04.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:20:48 -0700 (PDT)
Message-ID: <d471591b-5f95-497e-ac5f-bf186a3c05a1@gmail.com>
Date: Tue, 26 Aug 2025 12:20:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rename default branch from 'master' to 'main' in refs and
 test scripts
From: Phillip Wood <phillip.wood123@gmail.com>
To: Wing Huang via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Wing Huang <huangsen365@gmail.com>, Andreas Schwab <schwab@linux-m68k.org>
References: <pull.1961.git.1756183921623.gitgitgadget@gmail.com>
 <0a574b62-273e-4519-855f-66c554cd93c7@gmail.com>
Content-Language: en-US
In-Reply-To: <0a574b62-273e-4519-855f-66c554cd93c7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/08/2025 10:58, Phillip Wood wrote:
> On 26/08/2025 05:52, Wing Huang via GitGitGadget wrote:
>> From: Wing Huang <huangsen365@gmail.com>
>>
>>      rename default branch from 'master' to 'main' in refs and test 
>> scripts
>>      This patch updates Git's default branch name from 'master' to 
>> 'main' to
>>      align with modern naming conventions adopted across the industry.
> 
> Thank you for your interest in this. We're currently planning to change 
> the default branch name when Git 3.0 is released as documented in 
> Documentation/BreakingChanges.adoc. 

Oh, sorry it seems I imagined that. I've just checked and there is no 
entry in that document about the default branch name. I do think that 
the 3.0 release would be a good time to change the default branch name 
though.

Thanks

Phillip

