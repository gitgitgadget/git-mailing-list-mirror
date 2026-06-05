Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDF6305691
	for <git@vger.kernel.org>; Fri,  5 Jun 2026 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780694322; cv=none; b=QbZrbJ1dxboLZgZMtvj7RySeYD9fX3S4wq/yy60EBt5ytsOeQoy+G/1VHp0dMFkibrpSs3/Gxgz4RPrOxKbEZGyI0PPY/zv7C5DyC7VHJh6LZb5po5IR39GNaLOnNuEDpWPMFM02SvdtfiZQmAeKi1bM+0C2Md9bTFY/H0Et6GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780694322; c=relaxed/simple;
	bh=pEfCCefvGx/06U4mtcKoVZ1/lTdE5VSYE+Y+u7/Jq38=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fPJUAa8V5gRtVK9iQHJQ+5u7ygwQm0FwNmfwiyAB7iiTaUUjxhnmCWkYr2iAZ2qDIY1lVNsiug2v4XVqgPCRxrRH604Y3G9y6604ZFdSyRAL2z3szqPYsPRpHBbe7z08G3vgfUXa+e9mJwN294bMro1pZDLHKSvLZynEbej0o0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U8smv9x0; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8smv9x0"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7e053987001so31061947b3.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2026 14:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780694320; x=1781299120; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pEfCCefvGx/06U4mtcKoVZ1/lTdE5VSYE+Y+u7/Jq38=;
        b=U8smv9x0/DpDJ//g0z/XmojnA4e2WN1RwFB7xUSO4u+aGoq8q1ZDxi2aHxgfl0t02H
         QZxbTJah5e2ehfy920xeDIeISRwET1bUemXIzD2sdSrfsDrehu62zb6eCyOSO8jyMdk3
         kKxT130zyfSLxlXhruLKHXxOH1SGQ84TphG11Xd5vgObSt/0D0VydyfJu4IWt733OsAu
         5u3lRz7AnOdd949Hj4sRVMDr5E6gVsI3XOhpGvCutvVpy9j0e2DQJBqpWB0QqpNIudOh
         XubNHDoARRikosx0WhyE/B3MQPct/HW/f8+XXknp9cpKwKA9AwJjIx/9ENkK+D5Gn5Ef
         286Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780694320; x=1781299120;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pEfCCefvGx/06U4mtcKoVZ1/lTdE5VSYE+Y+u7/Jq38=;
        b=drBHwwbydV87QlVhN1xSTnICnS1gyBNCErt1krxDZMb5wkXVc6h3vCILxKtGjOU3x6
         pNaATqjCbgPp0Eg3YW6SkD2KWr5xp4hkhei++TqIulhaGFnFGA9hAf0hMJya/LgS/d5O
         2em9HKKOM2GWVY8D7SOzaohpLZZeUP9ErJFvaDGTCEfK3ZwIvFvRHH99UZ0kO/CfSOst
         jVdJCtADKVtCnYozGs6eHJNC9d8QHGjYTtV0ApkhnsqFJa+xpeRk3Nritl9wQaRt3Rxj
         If3Gce7lFSz/W1Hmo9tssTYrIurpwjWKw/QRlr24B3RAR6w9X4/ggjZJxyCxVtTB7YbD
         RNlA==
X-Forwarded-Encrypted: i=1; AFNElJ+EW7tcnKf2G4KS7C0z2LtpVFU6JuNvtpRzAJViIxJ1RbM8UpHVLfe0XC3QDrODzjLVzK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCJJIpnxYBbXX+fUVuAQ+6Jx3cpbD2f4GaazcD9HDSfJzQjyW2
	tJWtH1ul6utwI8r7IVdC4j5aLjgNqDl2PeR8RxSzJ8wjRTzih5dVHabr
X-Gm-Gg: Acq92OH1xuzPqW+IyBuCb0MZZM5qfRpqj7M70+KqlrmzsbQwsvFnvZboVHJqoTvyHzL
	x6rGMhvdcrHn3otobHJ6a0UiBnqVtzHZlBHAUGb5F8dw7SaHybkWaIDiTDVs7o14IrKu8+5fOvy
	nT06ivzpimRjW9LZg56swrANi6crVnDmN04nI3PcwqZ/KFc6bW1DSw1OeO9S5kilAqheTw5JVFm
	2vhq9VYWvuJyJGmW85/a4LfY6JdMAswXwViAyYdS3fSyHPE7A0n6Ua5FH2UGPS2QAH4Df9ZBTUQ
	2gkBGQx5wxHF1MtFm0A2Cqp8f7/jtibWCwXleagJNohOPh2c7Df1r6mm1YVXXgGw6HQelQJ5k9k
	1pq649gqKDKM19Qf5ym+2a5RJMaZi6UWZUNQOP7uJXs2sCsqSW+zs1sm30sm2vN6FhkXhYJ8Ahp
	xqe9F2/+HaUU9kUVUp2ktOZFa2kj9mI46ecUuexnVjpZ82rRAgtgGCZ4b+DstKnBrJfgT0eXL4s
	ELG9fS+YX3WP7gyVQ==
X-Received: by 2002:a05:690c:6905:b0:7dd:a645:a57 with SMTP id 00721157ae682-7ed50d621a8mr35776467b3.10.1780694319681;
        Fri, 05 Jun 2026 14:18:39 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:460:aeb0:e51e:78da:6dda:a5d4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea23a9a421sm55521447b3.39.2026.06.05.14.18.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Jun 2026 14:18:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH v3] index-pack: retain child bases in delta cache
From: Arijit Banerjee <arijit91@gmail.com>
In-Reply-To: <20260604071204.GA3196596@coredump.intra.peff.net>
Date: Fri, 5 Jun 2026 14:18:27 -0700
Cc: Arijit Banerjee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Derrick Stolee <stolee@gmail.com>,
 Arijit Banerjee <arijit@effectiveailabs.com>
Content-Transfer-Encoding: 7bit
Message-Id: <08B48BBE-4084-4619-94B0-503158B93BEF@gmail.com>
References: <pull.2131.v2.git.1780330402264.gitgitgadget@gmail.com>
 <pull.2131.v3.git.1780445118653.gitgitgadget@gmail.com>
 <20260604071204.GA3196596@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.700.81.1.4)

Apologies, my earlier replies were sent through GitHub's notification
emails and appeared only as PR comments, so they did not reach the mailing
list.

On Thu, Jun 4, 2026, Jeff King wrote:
> So I am happy with either v2 or v3.

I also did not see a meaningful performance difference between v2 and v3.
I am happy with either direction and defer to the maintainers on whether
v3's more precise release is worth the added complexity.

On Wed, Jun 3, 2026, Derrick Stolee wrote:
> Did you see any evidence that this change has the intended effect of
> reducing process memory proactively instead of relying on cache evictions?

I do not have strong RSS evidence. The spot checks showed no meaningful RSS
change, and max RSS is not a good signal here because free_base_data()
lowers Git's internal base_cache_used accounting but may not return pages
to the OS or reduce the recorded peak.

The evidence for v3 is therefore structural: it releases the cached data
once all direct children have been dispatched and retain_data reaches zero,
rather than waiting for cache-pressure eviction.

Thanks,
Arijit
