Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6463191AA
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757093255; cv=none; b=MnpmJ4Qs+OJfDHbA/tsZPpDl3obbAIR3c7++pjjqk9d8D+EEOebThVZXxHYHKunbZSK5/4y6NuNHbhU8Qv7Cbwiar3uuEmKM/nA07Hzk7B4Q2Xt1DhWCsdAJabbmcwd6hrP51XKAFqc7JvRev8OufvZ6DAZhC1sDDnSRyiaYHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757093255; c=relaxed/simple;
	bh=ncsaLUT4WdJFhITgoTslHqJm7/5zwinOI3Bei5XMARw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D0jrzBnSZVHrsq0reBIW2kGQFNjNaI/f3IAUnlDGZ70tF03M+wQxLJZZ69zvYkf/NsQwwKNIfplKRPj+uNAXJ21+Ru0sOpF7qj8G4D9JgVbGLAh3+qQLM3Kv1TxKkAsn0beLros+/LPPiSZ8GW8xYJmZjeOVbvIwc2/Ny1tf26A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHebeyfH; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHebeyfH"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3dae49b117bso1986567f8f.1
        for <git@vger.kernel.org>; Fri, 05 Sep 2025 10:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757093252; x=1757698052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncsaLUT4WdJFhITgoTslHqJm7/5zwinOI3Bei5XMARw=;
        b=BHebeyfHHAnC42+tcWBk867EvGKz+9X+4m2Xci4QhU+9f3sXwbySrUXCkXmmJMJvG8
         ZZxTji/SrQIrWaIZUqJ695PsU12/mXhodveW3D5VF/lKPtUZxG60M2/m8zg5W4y1FFY5
         c8MYx6jNQpb+ZtJsCDywYxXKS5cfE+2f24zglOVZBbNaSC9D2v7wnXsdsvmz22mDUJ8D
         ZYZhgVuQUfiabXsB9FrPpHrVbVoGNLSObI+U8a6Msc6PodTJJAi6rWmSewgKWLwZSMCC
         sjgOK7IZi7Whl3uQmdwXZo/3CKKcMqfUtZ7RVYM+fr2d1ple4v3mqpkQDtDSrqOqGSMn
         Xy/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757093252; x=1757698052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncsaLUT4WdJFhITgoTslHqJm7/5zwinOI3Bei5XMARw=;
        b=lptNOe2TGmXM2IeJE3SF/RjIwWiqqfumTcTmb6tgruxyfMq6RmkNZZU+K8cJvX1NDl
         9MCrESbfbmp6zUISwE9dqKlq7LwXBryz0oar85hklg2d6DPyvGz51JKtOipK9YA+LBQL
         L3TpR2k6tGapQQOY0VusjeSjeFob+ZJeKHFeZRfVrEvz+mbjwwgSccQEXTBMI9bgji5Q
         ykFl4/IJSg+DwZcoLJ7JlxQtxc3dcYldMd66Ua3Sko82ZQTeNu9OU0UpDg4WfQCEV7kr
         in2tq+hOm0ws8vGGGbINxH80YQSj46sxKZ5BD7yqVeYc2V3tmekdeAPEyWapLA0he/eQ
         0xBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAVyjlVWrhgH2buAp5xKLryMPpl3P6Ln3H42Qc5GUZBAkSRtGHdDt1lMOaVMKZwKllrvo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzso2u1Z79qGuuA3BSzCHnCZR36ekqx+dOST7McRIybVgGypBlo
	BsF6qMuxUXbv5Zop39aSc89iCm7pNvlBU2YaP8KEdKgFc1ws2hDvkNmh
X-Gm-Gg: ASbGncuEVpO/K5GcOYNMJiYKJJRFOUqulfBkOmQ/iRRFFz3BJ03MfAcuLBof2TlIXfA
	VHJce3m1PR0d5WuBE1LHOPa+SPax9NaKHC6NTte27cN5v7fOZUT+nLSiCFlFvUG5xjK/xMnEVeu
	8BXj8gtbH1oc/9GDNWzhuKN1qKtRCau1vWM5+6wRh7BJxzbDO+8anqyvz0xh/wA5eyysLc9Lghk
	uljUK8FAMaQAoLqYCi6K/85SrxeWEtCCt1uNByEA9vjBUZ1SeG5Ct5QjUHzaBDKVmOkvLji0kNP
	vFHusgNrMlguyXjGPQ4h1l9NtR2JbZivKD/AmjtfxPYIftmrAQyQChmaUTlh78/o85EBbMHFPna
	9it9vSvHc3Nwp3hGpp3mi9V9CFjGIT6X/OJrkpZuqqfWX9O6DG6Jaa+iZBENyycGgxSUwaA==
X-Google-Smtp-Source: AGHT+IFh+iFDjH3pQo9+3vEoSF+b/x0RaLj3FZCXEB/g9eJHJ21pdzLUlYPiXhiSup9qxIs9ekypcA==
X-Received: by 2002:a5d:588f:0:b0:3e2:804b:bfcd with SMTP id ffacd0b85a97d-3e2805b0773mr3701040f8f.19.1757093251385;
        Fri, 05 Sep 2025 10:27:31 -0700 (PDT)
Received: from [192.168.0.4] (ptr-178-51-222-125.dyn.orange.be. [178.51.222.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e552618813sm197322f8f.41.2025.09.05.10.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:27:30 -0700 (PDT)
Message-ID: <4010daa5-92af-4d96-a27b-bcb6eeb5d3a1@gmail.com>
Date: Fri, 5 Sep 2025 19:27:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] alloc: fix dangling pointer in alloc_state cleanup
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?44OO44Km44OpIHwgRmxhcmUgdmlhIEdpdEdpdEdhZGdldA==?=
 <gitgitgadget@gmail.com>, git@vger.kernel.org
References: <pull.2040.v4.git.git.1756941427825.gitgitgadget@gmail.com>
 <pull.2040.v5.git.git.1757007856062.gitgitgadget@gmail.com>
 <20250904204932.GD30633@coredump.intra.peff.net> <xmqqjz2d7t2q.fsf@gitster.g>
 <8f831259-7372-4357-b059-cc21f7a04864@gmail.com>
 <20250905132309.GC596956@coredump.intra.peff.net>
Content-Language: en-US
From: =?UTF-8?B?44OO44Km44OpIHwgRmxhcmU=?= <nouraellm@gmail.com>
In-Reply-To: <20250905132309.GC596956@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>> > I agree that is the right thing. But it is equivalent to:
>>>
>>> > if (!s) return;
>>>
>>> > since we'll have just assigned "s". Which one to choose is purely a
>>> > matter of style. Using "*s_" perhaps makes it more clear that we are
>>> > sanity-checking the input (and could happen even before we assign "s").
>>> > Using "s" is consistent with the rest of the function in working with
>>> > the more direct pointer value. I am happy with either.

I know, I used the original one (**s_) for the explanation. No the check cannot
happen before we assign (that's what I did initially) because tests will
fail given C90 requires declarations to be at the top of the block.

