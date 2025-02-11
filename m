Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB28261571
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 17:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295640; cv=none; b=TQPv6yqFidH4q6th7ZgtDIZrkSI+aAhyWT80oGXrSXRBfiKR4BZ5bbnPz+S9WQBiw6WZTZZrvHqQYa2CQXGrSPfC19ft+7q66yiQd82ImBCvexIWtl+v3C3v5ClIqXSBmChp9yOv6/6upD47qIzdcrHoflk6wLAuJa02F7qSGGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295640; c=relaxed/simple;
	bh=eUGs4ln3NSSuguLW5VbZ3dJAH3ZusO8nvJTEcMa44Gc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Zgsl+Rd7HbhWEDAuSgKicKebzSEaC/zaZSBXcC7W3/NCovrBrp6koWE1MWasDavoKy++H429ErrHhWnuZjy5tpODtkM8GCjwK9nu9xdQhoL3480YQXC19+G0lHSmUgqlFeFDT+3PxkLtm3BgQTQ+R0EPqCtYmWH7PldMpQO/l58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpBNNyaq; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpBNNyaq"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43948021a45so21306665e9.1
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 09:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739295636; x=1739900436; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JL9C/EmJ0+2CZ+//Cgakhvk7L7N+diwHYIIxtiKkM5o=;
        b=lpBNNyaq4enmIL9hIC/INZmJBsbnDaIjKSNgWsK9d4na4vPEeeypfr1cs+kDfPOMDb
         T1qzl3IJLHxgvdWXGxWNlSH1773FJfKMBRhDe20T3kRuoTy4bvb7+hVMtGRLbLrFJlEr
         CSwONjVIbpgD+0h4JP4q1IBSxjbqoZvI6Mv18njqJXFwU8WCXqwWmn1zjNvwc33qbUQB
         lV+aWFiS8sl0nSwDhq1CNadxMYldvber95z1LmJMlPoETRYTffUQwCosSm2F283LrUaG
         Aoc0gmOv0G5gFDvJviR3uVyIsQ/yR1o0Ve+Fg4KJEZkPvmSfsGvfr6NUrCDD365gqCwN
         wi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295636; x=1739900436;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:reply-to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JL9C/EmJ0+2CZ+//Cgakhvk7L7N+diwHYIIxtiKkM5o=;
        b=BvMWrgttFbvBrVedLKOzUqQWDX+uOdE6mZVFwHBMctsfnK/1Yvaj+yqpAAqK3y7Bfl
         VcPuE2Jw/u+NwsyBHIpQY3xv2sP09/S5AzOYmH0x5nJQSAoM7xWrM17S9LOq92UPBqrp
         YgkT+H4gtJGKFlsusW/bejtQrM7+TA6p9KWHPLLgLcibS5koQu2CoddSi5M7e8UM3gud
         1DleUd+dJ6t0w6QZ3RSBRnqWL2Be5aMdYpTiozRj9k8lS4CIBkWhr9wZXdt/au4VK2Qa
         x990DHOfUB+4pz2lSvt9vwBUrEWucn0kDwoLyQVPvn+27eBDARoGRbVhSJUj4DMXAbYv
         oRTA==
X-Forwarded-Encrypted: i=1; AJvYcCXShYQneggwTPSK30CZAgvL30cz7PF0gjTOtqaytTD1/AoyKsCTYJ2LpgM3cs6yb10qAE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnb6u+ijUwRU79Vfg6C8xS5mvw6qn3IML+JxiRl9iFTUpOzxz4
	WfpoQ/8rL2do5ZaOatKFG9kAscI1YPbYQX92lAjGBuXYDePnwtQd
X-Gm-Gg: ASbGncvjwCZ4xUXZavn/c5dI2emwypIO2sXJmZWpEP6vTv887pyykoGY1M4BDfV9qeW
	803pxUM/s5qb6nox/aUtujDht0GiZ1JCdIY4rpKXuv7dWdGv0Zp8/y6LW49J4vjsm7IBQluq4Xd
	EaVibwwsDc0/AJo8frrBNcGgV8sdkglloUjcdwGHmEDRVnHZtst2Jmjm7feSAVIG94x0oGsyXMt
	4DXiZFAwZGHi8GOmmz36R3hRgsmvGPKnLrUO3zkYNYBiFpS1gek0xMOf9eDbCocLfzOsG31z3pB
	WoXsVVOp3WtUeCNy/VIk8j/o7/viCoPU5XKXV4RpvUY/rHtSsbqWOJA6uhXMx/U3CMHYQg==
X-Google-Smtp-Source: AGHT+IFblJhgt2LcC7k/HAdD0/CkvrLa4EZKn4Kd9Dyz+LQM1xfG5gO96b1kJnBw5IIVh4ZRi58hXw==
X-Received: by 2002:a05:600c:4f41:b0:439:30bd:7df9 with SMTP id 5b1f17b1804b1-439581665a3mr1451265e9.9.1739295636517;
        Tue, 11 Feb 2025 09:40:36 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43946bff4d4sm59298885e9.3.2025.02.11.09.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 09:40:36 -0800 (PST)
Message-ID: <786eef7b-94e5-4f92-a82c-aeea69b5c103@gmail.com>
Date: Tue, 11 Feb 2025 17:40:35 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/6] refs: introduce support for partial reference
 transactions
From: Phillip Wood <phillip.wood123@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: ps@pks.im, jltobler@gmail.com
References: <20250207-245-partially-atomic-ref-updates-v1-0-e6a3690ff23a@gmail.com>
 <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com>
Content-Language: en-US
In-Reply-To: <4beb0359-763d-425d-b416-ac40bda59e2e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/02/2025 17:03, Phillip Wood wrote:
> On 07/02/2025 07:34, Karthik Nayak wrote:
 >
>> This series introduces support for partial reference transactions,
>> allowing individual reference updates to fail while letting others
>> proceed.

Thinking about this some more it is possible to skip the checking the 
current value of the ref so what is making the transaction fail? Is it 
D/F conflicts or something else?

Best Wishes

Phillip

