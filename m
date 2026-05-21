Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70711A6836
	for <git@vger.kernel.org>; Thu, 21 May 2026 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779356961; cv=none; b=TvzHDBjpoIQ3mdMdFFTY41j0HKxydrvlyBqzhhk9Q/xJbaV26lJxWE56VFeSuRkoq/qL+V0s+G28OxXncuUBMJA/KZ8aPtRMVhTYrc05Z5F6vu3Sd6ZeSsj8Zj45/3/aE6KCJZOyFqKTtEv2u9ZaIkPhwxWgicLqQLn9JptD/Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779356961; c=relaxed/simple;
	bh=Xg7fEINo/bqv+tKZ5IizBYFdwXUhoseXnG/B6l/un7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UytOJjH1u/RXK7s9UPnTCK3Wbo57eo0hs+GUTQPex4UJTxPxdrwm2LUTU3f0OclD/Dhfi+XkdZkaRyeRqUq70UFEvAi5qTI/3yNT5kZFEcQw03YER0vZNA/mkmOH4LSJuWRcn1DAeXH97ztzUGqKpV0CXzGXB36DI4rKnFFBwA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPU3nSV2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPU3nSV2"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-45ea19f412aso524778f8f.3
        for <git@vger.kernel.org>; Thu, 21 May 2026 02:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779356958; x=1779961758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eNvgpeQtEA/zPz2QJAq/4POg6HEuKkQWXw1iE/Afgsc=;
        b=hPU3nSV2fizawYVaKX90vQQGd+izXRwbVoboACBaozyO/5tS+0DOuhAgxCFnxI4rUG
         knQPC04MqInlw69HOIswRr3g5DNuYBOJwh2JwBVEAnrefrmOg4d6PfR0Ss2Fs3tJ+eS/
         D0mXH7ZxMXrN0bQFPcShCj0uRmPdtLJrmzWy+QjdkkX+wNfsZnRVIxHtkpg8d2TBrc8m
         gqeLXp/OojO3uoc3y6izqkjiPHPRRFTjrtcjGuzP6zr4hHbgj7qzZ67G9ilpZKbDxs0Z
         epSckzdrso7B20lo6BX2jt6azk0FSDMeowwLCLy3tBvcsTtxxtl/oasjoDJP606V+BKR
         ryWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779356958; x=1779961758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eNvgpeQtEA/zPz2QJAq/4POg6HEuKkQWXw1iE/Afgsc=;
        b=c17hj75LY8/kp7Kqe2YL1v9UHJ1SOh1TKb+vhxy6imgfxPJDg6YXZCUKF2dV/4OcO3
         EVdzq0R7GvcTh3sSoZMSkHRcu1SjvgYt0ikAgXnVVSTpKlPT0NLpio4OtJNnM3Vz2+bS
         1ATcJRlUzXKrvp8dkcGkk96nfUCpgeuBimOdNnUAvDmUjOEomBQPXSLYywuqEFO3R34s
         KgGXho0vcos5jjNP33Y6nD/mDMx3G08eEDs88CefHXAAZWzDVQk6ocFC4Mk7ztOlpId+
         cR5d0sGUTVlmAATrCLCTzFqQTLkEJ78KlB87WMCjI60vb/IUsueYvv6NcwYX/AiTeUhQ
         nJIw==
X-Gm-Message-State: AOJu0YySvziyiz8Ykp5aI2pqMFL/N2Q7YqI0lRwCRCgB/HWxycwLvJL/
	8R/5crfMgc1Rh7zxp1rsCjbg2bbGaJTd8Wws6SWXQMgXOIDUgztN0DKcBVsjNA==
X-Gm-Gg: Acq92OHizjjqEUUKR3HuzgoJUfNPWrE9ThQCAZ27Q0woOV4FWBrpROYw+LGWSd3wzXv
	XbjjMkmcLotJZ7l67g/KRBZaZ7PRHE1NNU+mEE6aj0Bjp9YxmBjKK8ZKuLhpVMwlduqe666vUdu
	uV5SZzvU6eK2QNbw/qRBdWg8vUEzpiT+iKEgixF52T79EfWFHt5W2yvNDBkImxioFv3WGAcqnOE
	PDO7ZorM7Lx8Thm0bduE4ezy8HWbnrvW2TbiKuAdL1anN+3JeRJZj4VomhSeA3nRqDULKrWLdY7
	qzBRzloFbmI+rOR6lny1Dh4B0epQchUR45djymOJu1ulK61jrgTr6VyCIKeLbyHSjutmU0T/Kte
	SWGiGCve7aZEKqRq3JUcOf7Jkv4UGo9hhTywRMkeNJbjVpVjDfvOJKOs6inQh1u6kG9bHVlm+bv
	GDq4z+TdJ2d3kClqLtlssiC2uSnRf6IadaLfVXPYL6povGkF31WY0qbMMnKzco/qoopjzrrWifM
	so=
X-Received: by 2002:a05:6000:240b:b0:45e:73b4:e731 with SMTP id ffacd0b85a97d-45ea3cedb78mr3296045f8f.14.1779356958033;
        Thu, 21 May 2026 02:49:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:638:c001:a103:efc2:6ce:f580? ([2a0a:ef40:638:c001:a103:efc2:6ce:f580])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eaa7d9e2bsm1570907f8f.10.2026.05.21.02.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 02:49:17 -0700 (PDT)
Message-ID: <b8932b27-8006-4b43-b7e5-1fac0fbf42c7@gmail.com>
Date: Thu, 21 May 2026 10:49:13 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v11] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Junio C Hamano <gitster@pobox.com>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Marc Branchaud <marcnarc@gmail.com>,
 Harald Nordgren <haraldnordgren@gmail.com>
References: <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
 <pull.2281.v11.git.git.1779177508772.gitgitgadget@gmail.com>
 <xmqq1pf77kml.fsf@gitster.g>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq1pf77kml.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/05/2026 11:34, Junio C Hamano wrote:
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>      checkout: --track=fetch
>>      
>>       * Find the right remote by checking which remote's fetch refspec maps
>>         to the user's start-point, instead of assuming the start-point begins
>>         with the remote's name. This fixes cases where the user has a custom
>>         refspec mapping into a namespace whose name differs from the remote
>>         (e.g. fetching from origin into refs/remotes/upstream/*).
> 
> This comment is even before looking at the patch text.  After
> getting one issue pointed out, I'd expect you to think about related
> issues before sending a new round out.
> 
> One.  Have you considered the case where the remote-tracking refs
> are overlapping, e.g., where "origin" and "upstream" point at
> different URLs but they both store in "refs/remotes/upstream/*"?
> Perhaps their URLs may textually be different but are pointing
> logically at the same place (e.g., one ssh:// the other https:// for
> example).
> 
> What should happen?  What does happen after you apply this patch?

It would be worth looking at what "git checkout --track" does in that 
case and seeing if we can share the code.

Thanks

Phillip

> 
>>       * For a bare namespace name, follow <namespace>/HEAD first to figure
>>         out which branch to fetch.
> 
> What should happen if HEAD does not exist?  What does happen after
> you apply this patch?
> 
> Thanks.
> 

