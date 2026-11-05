Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793837413;
	b=e10FwUO53AdbMyN1fmBMojU4dWxMVBmlZc6k1p3geFQar8m5VhFVQCa/rj5n+KWjgIsX
	 s1+XhXysweHSGYsERyNasRJOPsLD534WxkC+L2LfIuaOX1PCrC0wrjMSLhTkRjywKUOiZ
	 TAPvCj03bOd/iMr+b/HWW0mY8Vssd5XJ8WcuspJ35jSIMOqIvcddKSmMMaxHBe3TNo1eY
	 ANgtdk/pyVkfcIP1f18505Ij2KT78JlE2ZZm/fcZJO/SRXLSpBaRWYl08ZWU0evtDX81f
	 tJJSlKcRHI8TfuujTvD13C8c3GM+8XxAztKMMAo8YaIdZT1XVC/6/50TSw9jwBLYSkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793837413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:In-Reply-To:References:MIME-Version:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Hptom25Bj+9O3TjFNhsDTCPketxBSLCUWWrw1mhttvg=;
	b=hLd8edPb62PUqYypnUEygdRCgSxpO030I/hx0Hi1ZmQgZhi2NqEkbeqTxq3VliQgj9nu
	 O7ha+QwLOnq0FtO7oZ8PB/8AooSXvzX4NrT1gaALEcbjUB7BiXEmbDvF2klpjLX6BM3oz
	 TfIaG+vanSqIifVHL3bAUViyq4yLs4bGGRUKWNmvMC8wDNywwGbYDLvZaTi/qdqcmUGrK
	 w5c1tqNiLNQTkXaNS2gSY3WwonzpTwIL9ZSQahiLCtF+aUon77TayBpN9IpnxtLxu+Mj0
	 taCQVRoOSsIIWfdGWtAFstzCU9lKtq/NqrdYSuq/cR39O+BS12Xgj4mWsgnesViNx0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ak9kSCnU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1F5606EE9A
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:10:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B1F5606EE9A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ak9kSCnU
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b56c90b38eso5139a12.0
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:10:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793837411; cv=none;
        d=google.com; s=arc-20260327;
        b=cWkrcmB3roleVGffBb3Gw/BXkXd/+MlX/oFejP+dQwhI2XYBVWdTK0ILIuWM8e3azp
         pjZ4G+IY5RpFve2BhdMLrmVkcru6i2+90lMsdtlhX3/2myyK16DKvXSZWII39oTYU8hQ
         eX/AB+VmGiWMXhfYpXB6YAfjYWak5CyEYoNcutFYUHfFk0nu6NGlssldbpUvJZC1FxDi
         4V8I0PqZ+kscO4DiIStiYbc9xXmRw4GNDeh8xg8e8o4yLrhFetQzy0Ix+urMk+GT71jT
         9MGrH4sd1Fa4bmHPt1jUhq47onMj51QkL0eHIcnD2WoVucJIzUuV0pK4rc+iT+OxJRM3
         ZDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=Hptom25Bj+9O3TjFNhsDTCPketxBSLCUWWrw1mhttvg=;
        fh=remT/3e+QLZvjXm6f3hr6ZTkw9xB3PUdS1DnF4NJFCA=;
        b=hkxMozqy7cRYtfjHSiDapyvgfftLAgpPGURQW45Zr3e8EB20nX5rqhhbDZbt25j11P
         iR8Fq5YLhrKvppKCna+fxU9WBiOFIjM4NhPYG/QqW2cPaYA5bTut8tI1M2goauuRw5Cw
         MfhTAva8E3YoOpvtfxteiKWPPcXVfvCVDF/ekNg+IACSwwP/+Dc3MoJGyH2zibo03spx
         rQ3sBtAp0Sws8ZjEuftnxMj6VF1QMieACRjfc9IEgHqe2SwhKfWAh2NqqXV4NSbWiHTb
         StSJmRuGCvcI+lhLBobURqw1AaZ5dEyUccvcOz1K4eHVy4kgj6+hqbmSuDIocWE20/hG
         KwCQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793837411; x=1794442211; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hptom25Bj+9O3TjFNhsDTCPketxBSLCUWWrw1mhttvg=;
        b=ak9kSCnU/LdDy0bYihTIF2dOMKd1LIQ08TLLzqWtCTWOe8tw8x/hhuF6J3RwMZpVTu
         kPYMmTRfGlkV4fUFG1Nh0STddf2xmT0SLnIedQF82w89WKlAc7huWrmvwJkaU1cCCJ6U
         HEOlkCmqs1OoXfRw0PnhpH7ZGihtl52v+uE4/9/m4VzKrlpyYD6xXO2fWS8r0ikriKUL
         /GYWucdNUwlWnNghw5uhmk7HLoEu0LMvFdHNCP2/4LNQnF3l1/XCyqOmzjhXIgm7I0ZR
         YN9UJZ8eX9Dev6Y08CZ5AxyObFqPbVmJ1B51yFVGy227fjh29eBMaNOm2ke5SLEROCYj
         15fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793837411; x=1794442211;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Hptom25Bj+9O3TjFNhsDTCPketxBSLCUWWrw1mhttvg=;
        b=NcwIiQXWoUFWikhCblzeZT/scR+4ZnsbxlQ4zSvNNFSKHeRUBYBZ+/3LMDurOe7kx8
         U5og9/lO0TkiYnbJYScKqrKBh9gYjC2dawJlJAKEWFmtSkG6LWumLd+SUTlkFZ8NOVc2
         UEWwX7pIWmwR0qHfZv3cKy+pDPA1Zt+f7XR6OmD25K1WOCnLhD5377idQTKJC5NasF0B
         7CtWSR+KQp/DyACNIfp0/35BOEpKpOhq9MG5G+iddUWdQouWonWm9f0N9f5/Ev8vRvRc
         nTk7JXxpbFqklfjj8gCKYBzMsCf/FDahe0M3Bu7ap8Vna/Bz5HyydQh26eB9g4bG52iE
         E5JQ==
X-Forwarded-Encrypted: i=1; AKwUvBy1+spR4umYB1u1zY4pNkGSHccql/sWSBNmDn87uKEXAUmCuG4Z7A0uDKSgdZfJYlEr6fc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+/0+oW0u5mdbd9n3DXw+XJMvD/j7lvfoM7gE2XzSpks+KvuJW7
	b1i7YhhN8X8rfBPA9CPNUcCLbg/BaVHrtkbEm7qbEG5puv1fyhBrXtRgP8Ku22gK41R9UKdZOY5
	Riwq0bvlBAqnaRVqyHsv2dk/rMMA1zKWtgzV332Pi
X-Gm-Gg: AYBFou1IyDaqGTpC62O1WxKkI+9+1g/16lPait5kYwRc2VEXRWaPJjUQwT+6pdH/yGf
	Cox9CbIbmg1IAli1J87OyU7Ul0oolUFaIAJLJ/si5Qc9AQTpTqRlM78ErVzz7VAttqQoxlzjuJ+
	9uM6koAGwaGgVarhPmpPeHMgsUpoe35o3IJmWumW0V+QMFVx5obFQ+pf02dvTMcgnhJXNjkMR/u
	j+BSrVpyvRxuzrPN5wPOX6VZGgsUOwuu+rZQY4Bw2HCIf+qc8SUuW+K4ocottpuCPnaSEEKxca4
	suIqL24943E8sSeyR2WOfZ/KIgVAokrVlHFNzYR74QeM/Axx1G0FTLwhKqNEjBBDrvdBAuMLm8Z
	yekVSyK3/BS0pLJszM30CYUwbqhjj4Qkq4yZdu66uys0LjteCxslv67eUdv7h80+/1BTF0eNA1E
	X7JW2YCDjwJA==
X-Received: by 2002:aa7:c58f:0:b0:6b5:76b2:5e18 with SMTP id
 4fb4d7f45d1cf-6b577f926b5mr29510a12.2.1793837410762; Wed, 04 Nov 2026
 16:10:10 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Nov 2026 16:10:10 -0800
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Nov 2026 16:10:10 -0800
In-Reply-To: <auusPUaYRmUBDsdI@fruit.crustytoothpaste.net>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <pull.2287.v2.git.1793732247.gitgitgadget@gmail.com> <fe1e847dede7579da911b5a9ba16c806b5332723.1793732247.git.gitgitgadget@gmail.com>
 <auusPUaYRmUBDsdI@fruit.crustytoothpaste.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Wed, 4 Nov 2026 16:10:10 -0800
X-Gm-Features: AclHuK85IgtVEXMj_TGKveBU8MJB6I5HMSG0sRczJ4OwRolUMkm82e7pXrwlbBQ
Message-ID: <CAF+mdifcp+qkESZzd=8SmrL6eckxAQXR-4nxxSuL=xCV48OhVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] http: add exponential backoff without Retry-After
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> We should not immediately retry on a 429 response, even if that's the
> behaviour we have now.  The server told us we were being too aggressive,
> so the exact thing we should not do is to continue making requests.  As
> a server operator, I definitely don't want this behaviour; instead, we
> should pick something sensible if no Retry-After is given, such as 30
> seconds.

Makes sense. Junio noted on v1 as well that defaulting http.retryAfter
to 0 does not mesh well with exponential backoff.

What do you think about defaulting http.retryAfter to 1 second, matching
curl's --retry behavior (1s, 2s, 4s, ...)? Because the delay doubles on
each attempt (and Patch 3/4 also reuses http.retryAfter for opt-in
transient 5xx retries), starting at 30s would turn 3 retries into 30s,
60s, and 120s. Starting at 1s avoids hammering the server immediately
while ramping up on repeated failures.

If 1s sounds reasonable, I can send a v3 with that change.

Thanks!
