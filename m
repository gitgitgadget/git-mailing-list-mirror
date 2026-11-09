Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220763;
	b=kZepplJ2ViwQG6VuzJIax3rEWSrbzezXQLAN7XvYxLzXZJ6AB3S+FRW4LlSyyeezY1Dt
	 LmtIugzht0PabBd5OcSc5NXngToANIJw44RJ6aGXUpwg2Pfh0MFaX83kqaHbk99Kf2bgn
	 IKmOsZb5HUuxF2iXsl77BVo0CGxC4p0qi7jLzxnfKPQvaZfQkLJXN5fh64/3o4noSyc9s
	 ujY0HN7S3K8ld97yqFuhZjRl6lGdlIvAexVULibDcaK9M4sb6FtTs32bNb0S/Ndu+uGIA
	 3wBZrhiuIFbIRpA8TT/r0xk0/V33w6ODiZ7TOHHz0CBWI17XykNOTpGUKHbEw8emyrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gSDPLEGIpLI6dE0+Yxk6TV0gUb2OGOFgcULwmj6yg4Q=;
	b=LGbXaMuJGUAJXR8Wn5bS4N6ft1JpDIDSanfFv0uNUoulwEszo5/kSIC6F0PITYFgw8Oa
	 pMWNLbh2NKtA46WurufD+dcwaexV5WJSFU6qvtqMJ1rAl4o9PBlcqRVKfB0QOr+JK8UlE
	 LUYEInYmXFMT6wOjwRC5IpTt2+0lSkNzSDtDBg1+irGn2yd5s/7epMeB/+9lEw5cta94a
	 sVnty4+KtcucqOg+7NAznGaTMekvLVbiKDNVodN97pspLtcDqbDM/B0jhT5O0MlnP6T+0
	 vUdNAj8mGeC7WKfDy/qFIv41Yz+u6c0AlQKbMAce/DSTB8tZy+xYWoxeZHjL5A9TnKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rqc8mVpI;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DD2606A31C
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 10:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31DD2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Rqc8mVpI
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso470673a91.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 02:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794220762; x=1794825562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gSDPLEGIpLI6dE0+Yxk6TV0gUb2OGOFgcULwmj6yg4Q=;
        b=Rqc8mVpI19oPoK8h/hWVD/iVCFySko6gIOfOikhZoxyURZTi4Z85u4CaVAu67mQh5G
         w+pP6baFZCrwuU8yrI6qtG2UKbea7qHSRqBUFGtMfC3O0AWpQfIrGSWC6Dnvwi8F3wKv
         CMIdwAR6J2aS7ZHHBfh2D0jzZ5/tPEjFjr9D7UW16ZnE53a2mM8afxXcpcao/yiXZC7z
         rnf2ahz+LxfbhnniN5ASGtAoZAESqbXQkMcX7b3etH4WGcSNNt/CkIRbgJY+nYRsbeJa
         U6OeDTrJ6aX6uYV8xzBOV4dqp+g61zAHvUu0n7ZRM37p44CNT6ZzjTKXU+yAcx+scPNN
         yPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794220762; x=1794825562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gSDPLEGIpLI6dE0+Yxk6TV0gUb2OGOFgcULwmj6yg4Q=;
        b=pKHJgE+FXtGC3rgHi2IyXOkTMk8tNIDFFe4Eph6FAlwxrpWhobOk7AMsRf9uqVArTv
         vNpKn+B4xpyxD7buwW2SRZuDgxgjTgXKCdVYxpz09xoyxJpuB0yYIJuZbWzAGQB7shJs
         ykMrcPas66iu0ouFuL1+ff8tGE3f+7Rs6CaqL+RIcK882xoDFBT4q5kUEabwKzTsvJRn
         A8fF/J6n9dA3Y1Rj2QN3GaXlLDWnvMqxuw0DIzF6aLfF6Amti8o34v+sX5qjA1Bh34pq
         t5jFQV0iTaFGdALl90/2J9AJlWcsGtXT1hlBmZ8VAspYIwrI6m5L0JVnDavklIr6LDkS
         eJUA==
X-Forwarded-Encrypted: i=1; AL+hErGC1VvMfvoWAz5cQVG1CX01shRJBIjwbBeNWCKLnP8YILFVEV6DgOW6bwopdoiiIQljnTI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/OxGGU+TbCm7q0PzMtG+gkMJbaOmdkyp/NONcO3czrwW3ETEfs
	uGNElPTiYjNW5Gv83QZ2IlHT6PRFgVJTNGUJlUrFFcUIKv94IoCK9Ohn
X-Gm-Gg: AYBFou2Yv+lanK20unGM5n9SFS7JmC1WJwCjGb2Xo5hR1jVBuFmAVLmFO2/jA+BNiZr
	CbJ1QZcbqL+Yo1IbvtBm3MLFn3n80q3OUsJEayQ6//nGU7G97NyiPfYFvRTZBvXJCls4CSZ6W42
	qLWHt+FxdxCM99cLCEhqZAnic7EwpqN1bJMCcUlU4Nz2nqcyzZSjG3DsXyUQ0uhHWl/pgF1DLrJ
	k/y+Eue0+e6GsR0J8W9jsVFkKLNpaSNreb8LogSSI93GecASCIuQ0cN2JfQ2HoZvbBxgOyFuAgf
	bk7iDfcev3UL18GqWEO3xTeH674CJ1yUWEsWovml6+R/JKg4zH0MZ+Oh3nHW+gXrDJvhv7cHcr+
	ZHiPQdh4BDaWdY9Lw2q86u0hKbXpw9swjp6gDoDdzVVEjtdd+PMVCC6rTzMwRbJJG++BoovBb0z
	Xgo0eUcpZPE0ARho1cROmtKeebG9qG7BVlKv5tmHSyhxOuJW4HR1qtPJhnHES+IBXdSj60EEMLP
	Oekct0Vev74U6CuEv/j3VQm67Uhv5HgJ7yvnK+3Ksp+bg4PVwdaT/8h0YSEQVJaogvGWUEvbapW
	wt7V7bDT/TZn1v2/3MpSw9cmvbs72RTd1VAgc3+eUDCDSObaUpDZV9U5DyF0m45QobFKa27GUg=
	=
X-Received: by 2002:a17:90b:5548:b0:3ad:870b:b6d4 with SMTP id 98e67ed59e1d1-3b12d1003a5mr3607235a91.1.1794220762395;
        Mon, 09 Nov 2026 02:39:22 -0800 (PST)
Received: from LAPTOP-PVRSMPQK ([223.190.82.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b12797095fsm6346027a91.16.2026.11.09.02.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 02:39:21 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 2/3] remote: do not show credentials when relative_url() fails
Date: Mon,  9 Nov 2026 10:39:16 +0000
Message-ID: <20261109103916.397673-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.344.gfa103ac04e
In-Reply-To: <85924f20-298f-401e-88f7-7fb3f949d0fe@gmail.com>
References: <85924f20-298f-401e-88f7-7fb3f949d0fe@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I'm less convinced on this factor. I understand anonymizing the URL if
> we are sending it to a location that is perhaps "less trusted" (like
> trace logs) but the user asked us to operate on a given URL that caused
> problems, so they should know the string that caused problems.

I answered this on the cover letter by mistake. Here it is again. Apologies for the spam.

Fair point. I tried it with a password in the remote URL but the "failed
to download bundle from URI" warning prints it as is. I think this patch
will only cover this one message. The reason I did it is that git
already hides the password when it shows a remote URL. For eg. in the
"From" line of fetch. It is a separate patch so it is easy to drop if
you and Patrick think it is not worth it.
