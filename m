Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44623329E49
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 04:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770698152; cv=none; b=VqmdAlNSjMBwFu9jg+wzlAGVFm+O5uR2j1b7/9lzsSyqCj33+nwuZLk35fFT5mYYkL68pxyb6gKPkc4NbArzkIAVMDztgcxoONAjUKnd+QOVkYnJgHsSHB/WDMfaH0YhzZEPmYYSKEFppCwZJYVhMJ0OEMrq1XJYDI7ATComm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770698152; c=relaxed/simple;
	bh=ZNrUzj7leks9CdrQI2W7Mri9/R8QYmzTedl4H3p+izE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ai3eoTUzn/eyBcfeYWk5w+nenYfowcpIXCcWeyFpN+D2tqOTlzPIOEP+uTdJoqhq577RDcoNuUbUeNjRj79Z375aWHwTuXaSr2Ao2Yq8GQ4USsEjPBMmag7XrqOHa+tgPe5VjQgBEpAhXpxLXGQZweJJCPovI04uPO7kW5cKWhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTEKEiUu; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTEKEiUu"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c6aaf3cd62so45216085a.3
        for <git@vger.kernel.org>; Mon, 09 Feb 2026 20:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770698150; x=1771302950; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q/hE5kYI/owbE+rz0qjtJWMEcgR86StZLKGvqrChrKA=;
        b=gTEKEiUutHp3CRHgljePQA+WYQNHMZ/TJDceHz0u0I/6V+wZ0Vnha00t+hYWRdHAiH
         L6kx15PxkAgdP4Ftl+zplucUjLQrvTX4/Wcc3oW/P2CO0PhtpKwV/dQ65/+JHAMMeIuF
         CF6Lr5TD6RsR5PUpu0jM46/jKYkcPQoYLz1P7fjkYxoXS32zjiueh53zlymZZWgTO4ti
         4rh97SncrKbNtvAzVOsnru3AJC/8mSQX1fASTfkjeAGUjlw0F+V4xLCb5z5gzNyXwwUx
         4KAqUp5Msb7rgWLKoKTs2NKzZw5mrJ9yybXqYyxJ62KOAjXm4NGzlvfP/Z3rXuVhFnSk
         nbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770698150; x=1771302950;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q/hE5kYI/owbE+rz0qjtJWMEcgR86StZLKGvqrChrKA=;
        b=fg0D1Y3td5yzOCcNyWZhpeCP1ojDide0sJdXzLXMmCXqp5jDDeJCC8sCXgQ+9UnLdQ
         6ypLSjZPxdyhbTQ0/iry70HsVfJpkd4+DzlAaoDixMnEZW1HvacsU9BchC5l9rhhSqD6
         FwZtMl4+XT/Ep49zKFFOJbvAH3L6kvAOmuD37c4NDpTGH5LVhIqzjSUQJ/ZlqyUS0p7o
         KPEjktwQndcsfS0I0nYAi/mY6jdqQgLGOc3zkAzqDeKxoEjXzpbZGQHwbufSVbCxdvXU
         XiKBLRWr+U2Zw+RBliWkItQgHhkA6bbgYqIg3vFzEfdVokwOuTP9Khmn9y3d9zd8x5rW
         z3fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsuVsETBSaAxl5x6O2hSuatK5o6b6mw5CBh//+oNBTAS3kIUXrpp6ZZpmpg7yeYDWV76g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG0GChAJmb1wz4B4k+p8Zu2rJE8zPeaMr/8w6fhRbqVlmAN4wU
	oZLMXoQ8MGzpsZM5Rvlhvf8bjimIdbLocqPSZzNHIuPtKTQE1LUiSfhIzr7QZg==
X-Gm-Gg: AZuq6aI+jddZ8PWvCsujXpvV9/KvOJ6nUlCVbwzbdnMjpRNMtZPsi2o9RscRWOWIQQZ
	3zxOW5x/7+8gs029ac1+FGmHUYpUDBSXpEC7pZDmUjRtokN4SO0UT13DLakTixvZtgPXwle8/mJ
	nXGVdIAPiWUxxPMHgTKQL9x9yfqv7Y1LMEwB/9on8Qe27ksDLoDQxH3pe5xKwNW793GMYRZB8Qo
	J45PoQ5mE6q3oM9bMjw5JUVgzfh9XltNXBluVI/0owBlQCkziFiAz/m4toprUGaY8b9F8zjgdgr
	jeoxdtkdvAzV1VNv+4w4jff/Y9iw1YvolW4Uvh4DmVvJm/vKeTQX/n+/GE1RTu0/MDBPNouEgu8
	W64Euoc48XWddCI0tWidkVwCRlXUHPaKyxswaykHT8256fq1MMSxOcVztG81yhTyb1istgtDVhn
	gkibmqRe1vTWA5mV2Yn/gZIBZxoz9rCbBLqhCMwxZhq+eemmnKu+Kk9x3/RCW5JL7uO6LDZGQQC
	Kv6DAji
X-Received: by 2002:a05:620a:1a22:b0:8ca:305b:749b with SMTP id af79cd13be357-8caf1fa789bmr1776980385a.60.1770698150227;
        Mon, 09 Feb 2026 20:35:50 -0800 (PST)
Received: from [192.168.1.109] ([136.61.121.155])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c057751sm91891996d6.43.2026.02.09.20.35.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Feb 2026 20:35:49 -0800 (PST)
Message-ID: <b365b5a8-b66c-40ac-bd85-a57aa9fa7d12@gmail.com>
Date: Mon, 9 Feb 2026 23:35:48 -0500
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] merge-ours: sparse-index integration
To: Sam Bostock via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Sam Bostock <sam@sambostock.ca>
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
 <pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.2189.v2.git.git.1770405383.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/2026 2:16 PM, Sam Bostock via GitGitGadget wrote:
> This short series teaches merge-ours to work with a sparse index as a small
> step toward broader sparse-index support.
> 
> Patch 1 is a preparatory cleanup that converts merge-ours away from
> the_repository global, using the repo parameter instead.
> 
> Patch 2 adds the actual sparse-index integration and tests.

Thanks for working in this area. We have a long tail of instances where
the sparse-index could be integrated at its most bare-minimum case.

> Developed with AI assistance (Claude).

My experiments with such tools seem to do well when there are clear
examples of how to make tests and how to make appropriate fixes. The
tests added to t1092 follow the standard model for checking that
the index isn't expanded. Perhaps the many cases we have for these
integrations could be tackled more easily with such tools. I expect
that they are _mostly_ boilerplate tests and minor fixes (but don't
look too closely at 'git mv' which doesn't have clear patterns with
sparse-checkout even with a full index).

The one thing I didn't see that we normally see is a case where the
sparse index _is_ expanded, but that shouldn't happen with the 'ours'
strategy! Excellent.

These patches LGTM.

Thanks,
-Stolee

