Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795203348;
	b=AHZwHeq7fVDxmJw/EaulLHInX6VG6N18sfrZbBphzRlRFKY/QdXG5LQTTD1FOTzRcgjA
	 C8+MRozZhZP2yYjqkn8HAlZUljJEjWzRCGlZid7dSZEoFaVwV0WAyCxBXvxeFoQADjJBu
	 aFkW9PsBC/h1dHT12XBLvLZZ7U78ojLfj2e/VwpKay59KWyMLkeVHXX+TrOVT6I/cdL/s
	 GsavXS+yatEOo5HcZtbgpYmWMASEhs1rK2TLvWz/oSZYU9OwolMPefc6u2cXDypkw7W70
	 eHjQ49VyjUS1yCFExTlkEGgfaxYBpKCpL3k6E/4wl1aBLDn0vTB3L8JQ0fs2hvEek/w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795203348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=21qrh+8o/e9eOBKwthSO1HAj2ndSWyBq8L0dxVJlSzk=;
	b=xjsJ32lkaF1mb3Y1rsboOVwtBf+UhNrc32q5F+9LnkTTQHELDsS3vN4f3APr3vDf0kVG
	 ThT8pbqxp2hr/8z8SuO4RhRDIMmunvrsdCWrLoYtEwtI370CA/zV0sEm/RxaOeJNxiKKn
	 Npju8nA25JdLuCCSwVMbhx2EXw/jxJHYhzuPtq4FCo5Bulol003CsqIPayy0Q/hF9sI52
	 +nYjFptKxLlM+/Yf4Xmkv2xHVZxSshj2xaJbWzBVT7cQUFgCCScUIyrLZ9sfcCGBeX2BJ
	 oBuLdZhe5bI5GoZj8jPLgDEI+cT7tMkBOf9+kXGUpsUdATAzUrito7MddkRGC1/AKAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJmyoeFr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E5606A6CF
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 19:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D3E5606A6CF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VJmyoeFr
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6b8784a3284so1894076a12.1
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 11:35:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795203344; cv=none;
        d=google.com; s=arc-20260327;
        b=J8gZJiBZypXr6bcrWjnDU9GY6RP7SahNkR/KZm8COSLHVeTjEIbelyM2kcta5uBZkE
         iMowNzPw+paUOgZpYnyaQoq5ZMOqQOI0ZhkgFP4pr/pqtOWRl94NtCe8J2KIBTIkF20M
         U5m4TX6hQR5F4cce88XLojRoti7ubA/XUN4WCWChuzUcCNmXhHs2UxD/QX1BBOijplDX
         ywfg43IODsTY3ylJIjNojfZAGblvqbusRJyW3Ae0r6L6YBBqXnBzxjZEudf3G5qwQcip
         wN/Hot/Jh7v8csDdr3WFFXNB8NrFhIGOopEAaiNZdf6GwaZ+m5JBShFwDlxuRZLAh0Ce
         nXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=21qrh+8o/e9eOBKwthSO1HAj2ndSWyBq8L0dxVJlSzk=;
        fh=4p7AWUdCb8Bjx1k5s0WSGQWH2VPRMsaoxx46XhGw5g8=;
        b=Dx4gv1rsi0NRkI9lzJoElwonZseAwIXQ+EZ8Tx6JUgDiu/YAsE0H9uNAllMevhF54Q
         5pSkfySJD9dQJw0Y89rOIJl3IhbM83du9xPBnS5s4kDFMNCFCudmC8AoxU4X1hGBRHOC
         tNU9SgoZTln/BNiQ+jAnWiqWcpIMGusfLEk6N89Tx3qXBRALDJbGvn/HGYTgPYOt5cc6
         I7CnlrbO6QGtGt/PN/UD4WTQAuc9cJon7xxwOYVxEb7Oc3oOt4G7Ft4i8QNIAow1OvjJ
         T+oq9Dse/4+RL0e7eu6lEITpdiibNJkgslogpLA8xmbgkA+uJWK/VyjYbu1yNyimnF1x
         13Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795203344; x=1795808144; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21qrh+8o/e9eOBKwthSO1HAj2ndSWyBq8L0dxVJlSzk=;
        b=VJmyoeFrbM+ivBho6xZjXjfiK7mpjHcgqA5KYgqM926Oc7FRLxOpe1Kxy39PJ3uL+w
         IZUN7g7LvNmUqPI/I2Hjm+f2dVlamSCjLJ8tgaRiT/dkhzlXkC+sqSGUIhZLX8CecT8b
         +gSyd9rNQajXC/g8wQVirzggtyqV6ENBSX5NPSFZ4AcyvdiZnUrE4rNbsrEdgVrl90AP
         u839MVhsuPe1cWbbUt2W7zE+B2ZZ1o8je4/mu7u9BRRDn4blcJ113V1F4pmBQOLgsiEW
         IGihez2Bt24LPXpWPgeECHkk4FPh8NwFoY7PaRAahfOFT6kNInhxLP8DWqnZqoSpZfRu
         hsxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795203344; x=1795808144;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=21qrh+8o/e9eOBKwthSO1HAj2ndSWyBq8L0dxVJlSzk=;
        b=RlizPCJX9urSkx8xGgsj+fkoI6haC4zq2JuKU9VwdBbk/LJ2/Bpke0d01/XXocOQj3
         F2JaJ/sh6naecZ3B4NtTZChGatdMRb+frQ34wEOM1aDQ+IDxcDVoqyEo/+2hsnpIdC/A
         GzQftG6huLOtKs+wzy6m2i7Ux0A11IXABw+d4g9TjpMDskPrLU7rpGPU5MiKMfueWF0o
         PxaukPWzYe17FXj6YZURFSQZB4JFxaArpVrAcgh8sffB2X1hCFGOToCiKPIs5bFIJjTd
         486d8/Zin1ct+IjmMorBZd7WkyDJVj4KNSQQRt19CW9k1HEI9i2NXGi6okaa2hrLSyD8
         ao6Q==
X-Gm-Message-State: APuU4Z9ssP8Jvsc+jyjxzAqQBWek7b1eu0kZ7xYG0/gtBID5cQM1bVnI
	DCYTRjq2ziymD8rQbGkSyqIDEdsvbloEqnqN5G+Gg89i3njr6wmM33MNdHlE5ig6n1vS884UZRj
	HiyRYh8f6wwI8aJhhQwfS6bYUrVa/izY=
X-Gm-Gg: AZFdTZdGvAAlRxSbFmJCkGfEAIo793s8SGGOwBidok1La8klNn7qXmutkQIL21ugBsE
	JiokbJJxwwTwI3CgliInYkkZqHauIikbCtRLyObmQW1YFVtafDWz1pyNkaB1XLSlQt/uSZaNsxk
	Eg8SuyUZUHtaaEhnK//77xOgiX/SsBJ8/oIPo5nGBCwiR69GZUQkLvTV8LM/odEpk31Ocq/RQEh
	wIS9IJ3YzKAlD2B23g5G2E4g63L6WkquJ6L97x9q6/ryBEuKDWUKWhZqZA/ekJ7T00h27b/IVDn
	3ZA3N542OAKxXF/K/+lT4+3NexPSMielXzv9qtV3udRI9WuftbDcpjjfzYM/GHoSEVb2vtHTjKp
	QW/cAgAsH3t39NArFQ9CZXyGCdJQ+1cxG8Ftm
X-Received: by 2002:a05:6402:454d:b0:6ba:139c:47b2 with SMTP id
 4fb4d7f45d1cf-6ba37eb1950mr2774866a12.25.1795203343648; Fri, 20 Nov 2026
 11:35:43 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2437.git.git.1791270504.gitgitgadget@gmail.com>
 <dc0efefa0ef02a04f211cf7e24a8b6855f36e12f.1791270504.git.gitgitgadget@gmail.com>
 <20261120190246.79249-1-aniketgupta3001@gmail.com>
In-Reply-To: <20261120190246.79249-1-aniketgupta3001@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 20 Nov 2026 20:35:04 +0100
X-Gm-Features: Aa3M54pCMA5WShfA26z89hJ1NIImx6O8ezaSOE_Egh15AMeahgYkY30ATAU7nqc
Message-ID: <CAHwyqnXks_cnmLrBxO0E-HkhvMNmnRx8cW9K2Lcyj6tnPUS0hQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] status: say when the push branch was rebased cleanly
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This makes git status slower when the branches have diverged as every
> commit on both sides now needs a patch id. With status.compareBranches =
> @{upstream} @{push} and 3000 commits on both side the status goes from
> 25ms to 150ms. With 10000, it goes from 60ms to 500ms. And with only
> @{upstream} it stays the same.

Hmm, that's bad.

> Would it make sense to count without --cherry-mark first and only run
> the patch id pass when the two counts are small?

Maybe, but maybe the user experience will be weird if people don't
understand why the check is suddenly gone?


Harald
