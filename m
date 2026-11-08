Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794165075;
	b=VulkHCDddv+EqtMhdmUrzzRPsfXg5CFeRMQ38iNAV0UqSlRUPaoNUkAWF76A66ID38py
	 9MSPbXzoH8InRn671wSxZT8j9OQ4bZPzAczCbNgyXkqnvqODEHGAaXVm18RITbLfZUOQI
	 vcyLmPbC6czaTTuJ16oKZQgTOvu+NjkJbdnvdkt4ylaiQ5xFT29bEz4knprvh9G/1OZaO
	 2fMPsSlbT6UBNqTl3FoVqnR/R4xumN1Xn0DGsFMGLLDzKGHKV7JNjVZfBdsy32TzvAEc1
	 /OD25+21M9xI0MOhJ9Y5Q2la34WEGwl+610hoBH80aZmSNa0ROQ87YrBwgWbqB7MIOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=t0pPQwiHBP6tP9rmrKmiYsDYi9KccNgIk4LSEBuPgzk=;
	b=OC2OeftQPzCLdCai/+CbAcROKhNvQSRQqEDTHWniqkQwI+soBsVmHS7eGEk3QkwZLfYG
	 DI0aVvn70RepdHp844N80i4Fs37dXbhsNOeNZfJj377ew/7uG2vUMNaYhMSOXzFe3lAFP
	 nPpMGPNls/xjcO+lOsN0WMhvxPrp4HfNgg6Hp3XEgyui6iBp8Q2w2yODtTeaw2h6mpMXq
	 J2HxSy4NPigNua9Hdct9dd/MMu43MFtZql44YyDDONj+hnECOe+cIyduvv7OS6ggJGpEA
	 Sm6P4baLgErqAmbVO2LMKBlxjJ4XTyeqnXW6xdd61PElcdL/ut4frnd23ECtJK8iCrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=spotify.com;
	spf=pass smtp.mailfrom=spotify.com;
	dkim=pass header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=chIEWF3I;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4B4606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D4B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=spotify.com header.i=@spotify.com header.a=rsa-sha256 header.s=google header.b=chIEWF3I
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d473cfff6so29147666b.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 11:11:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794165073; cv=none;
        d=google.com; s=arc-20260327;
        b=WIWWvnkWFK7NsZz/DQ1eSSLgVyiRo4c9yjvIlEvksrUa+UBcufONVaTFNf2jyD6YQp
         dafykBC5j7x276HTSurfD6WsVrL97ebodKhTX7qyt2zZaEhtWWcMfaa9sxXOOnt88SqL
         0qntu+Vk0CdnTJJQ11ayV4EkG0XeCa9903Gt0j3V71xsR8VxIdvJAQXUUmfrVbQIhU6l
         pFoPMxUxyILyF0Qe82s6F5Y5sXhKKHpkVB+zOa/pH1vyCGh44x/CXjdV5KuPv6DbUfZH
         g81YoMjNSOlZd1Zf5LvTjEQXgd9irSn1RCSs8HxGMFgKYaCVAU6RmCJyDpKoUnWeIh5F
         YVvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=t0pPQwiHBP6tP9rmrKmiYsDYi9KccNgIk4LSEBuPgzk=;
        fh=O9ZxREKmykoirDNqiogHnCh0E5sLPC0pvvbgSwDCHxo=;
        b=Y7s7M4sUrHJOxTp8P2AZhOHCx8KtwbIgwsb6OvnawTf1WxY+v67DOQa9OrSJ73sYmW
         pssLTi/+5QCOt+JBbmNFpEGOYC+w5lBdxjt3zx0TD07aqXTOfPHn9ljNu7N9zbOhCRGr
         RYIfFWpaFOaHmI6wUhztMIe4Eg70QZ6gDetW4qJ8nwLPsBIe6tx1+sYMuWKD2yL6xfdC
         UK2K78iJlYIfb7x+IMTYmMbNJ4UMOYMh6lLuwar6WzBG63x6G6Jb8QjDUq8eeMJ+Q1Uu
         blD86NtAShzG6vFenm9UjpFDOa3xlBq95XO4oQyD3cGkYut1JvSrNkuvylamv/3daRIC
         AJ+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1794165073; x=1794769873; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t0pPQwiHBP6tP9rmrKmiYsDYi9KccNgIk4LSEBuPgzk=;
        b=chIEWF3IAVK2+yYRbWyB37WJYSZ0PFU1ZCtpiP2nj3W//OzJ0QtuEwXN5JdI+khtDO
         6OIVQ6AAlD/tntOnRP8nMVox8BYapU0OjNMflGOAREFd6Tk+VTlVolcMuCQWaVyGNn4u
         ibufe/+kfGGzIQQzEyAl80FBXrNsVvAT2Z/Os=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794165073; x=1794769873;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t0pPQwiHBP6tP9rmrKmiYsDYi9KccNgIk4LSEBuPgzk=;
        b=LsDbpr0powduSV+BOx3j8leEI5RKDmPy5lk/QvYpFhAoC0hLIVvAKFKJgYry2Ogrre
         SPepmAt/9I7jDIfmisCUFHsp7nMficgmVDHflbdP9Z128joS3ghS+ZdK3tes+tj5hjcp
         EeeSuT6Wj2nDoMJ/hDiwO/cgUjVKpdzqQcXHuX7IjXK2jjFA2W5YpX/UeobZ8vm/eP2D
         0LEF+PU/BOuYmwQ+eKRn0Br5QfWU51tF/l70/4pdlRXuaz8Fz9EfZ+eTpytC8vKe96m0
         KSmUZ7jMsGOndabqY2KCua+gYAfyQOJm3leVn7xvSFTJndMn7VWuWYnV7mbpD4aHBTQo
         SORQ==
X-Forwarded-Encrypted: i=1; AL+hErHiIswK3UkHO7CTRarkvV2kFO4LQyyVGA1RmfvdD1SHj6R2J9q/EOFit62aALj3CjRCu84=@vger.kernel.org
X-Gm-Message-State: APuU4Z/L700OZyMWbUtA/wB9+AMVjgGoZO0kiMef4ryq0b5sR7eHxKG+
	smY8BWzYULbzVCe6eN+zyR8i+4r+4GLNguCYzdnCs21VrJGgHm/RjkoMDZv3UU0bcq7Glhqnp+r
	PJGfdHNOBDZqxajzTjoe2UJo5gaMwJU23av7kbTNZ3ypb9ZOBrteQu4fS1A==
X-Gm-Gg: AYBFou0Ae+DhkaO4goQUKzVxHnz1HLMcqGhN6YJrd25MbftECHof6fOjNOAXAL/CO+E
	QSyD7BVb8QSlLsWh9dAl8StYQ9AoFWAXED0KCuqLmvyjhAlhq784l0dd7zHArmZOzmOo7ULdFxM
	SsECVmT58q4r8U59wqqgNxmMNaJMAsXSzuDo+gR3XvlnqS2Iq2F4jjMx9DnFq7s+m7glw/s1jCP
	Sod0e7Q2ndH3WNNNQ/n0sXyXKfH61TUbjHsPx5tMhpNtQsRJe43SPgSaQIrAUQ6FbSfNetFCrYp
	AJsFqIRAVSN1Pyj92YjAWCz0LU0spha2/W4cWZGzPLy6983jsva2nrS6ITFLPvOd3Hww+SFLhEX
	1d80vcekXGJSBXfBHXN6JdwJ6dOQdSB51l1W2/nI=
X-Received: by 2002:a17:907:3f9a:b0:c49:cdc8:10cf with SMTP id
 a640c23a62f3a-c4d6dd7bf0dmr141148166b.40.1794165072758; Sun, 08 Nov 2026
 11:11:12 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <b4378b352769cdcc2e9cfdf40efe173123ea9ab4.1794063565.git.gitgitgadget@gmail.com>
 <xmqqwlqo8c8y.fsf@gitster.g> <xmqqpkwg53us.fsf@gitster.g> <CAL71e4MiH62mpy0poRG5pSz=GPpoLWo-qPi_inaav9CgqDn5hg@mail.gmail.com>
 <xmqqcxsf41en.fsf@gitster.g>
In-Reply-To: <xmqqcxsf41en.fsf@gitster.g>
From: Kristofer Karlsson <krka@spotify.com>
Date: Sun, 8 Nov 2026 20:10:59 +0100
X-Gm-Features: AclHuK_aOj_GIyJdx_O1l18xHOUH-_30kmQ1r8UUbsJEET5YJiLEG03pefYe14s
Message-ID: <CAL71e4NSAUQz=s8DVSK42=ZK-626qqVBs+YSJra9d+SLV9DPSg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t/helper: rename test-genzeros.c to test-genbytes.c
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Nov 2026 at 19:35, Junio C Hamano <gitster@pobox.com> wrote:
>
> > I could squash it all into a single patch too, which I think
> > would make sense if we don't need the intermediate state
> > where both genzeros and genbytes exist at the same time.
> >
> > What's your preference?
>
> I have no strong preference between keeping both genzeros() and
> genbytes() or rewriting users of genzeros() to use genbytes(), and I
> prefer to leave that out of the decision.
>
> My preference is to optimize for those who consume the resulting
> history the most over the longer term.
>
> Your split between a "pure rename" and a "modification in place"
> is optimizing for those who review the patches on the mailing list
> (arguably due to tool limitations).  While they are an important
> audience of yours (after all, without their support, your change
> would not end up in the final history), those who will read the
> history via "git log" or "git show" to see what happened later are
> the more important readers of your work in the long run.  To them,
> a single rename-and-modify commit is much easier to understand, I
> would think.

That's fair -- For v2 I will squash patches 1 and 2 and keep
patch 3.  I'll also add the lowercase hex as input format.
The similarity seems to be ~29%, so running it with -M20% would
only mildly reduce the diff, though I think the diff is
manageable to consume anyway.

Thanks,
Kristofer
