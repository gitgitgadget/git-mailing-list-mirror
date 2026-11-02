Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638186;
	b=y8vDYbKSMvpvlp7UDDWsl/yrROtStFz2m/PeYuVDL/Y4YUU1pSgVW5rO0gBagV9/gJ6E
	 zGENhssFcO52FJzSXK47YRTnzHPcKjkIvO6NWirnH9g6ClAWQNu5oaljfnIuSZk18G9ja
	 KgPCDxWealkBOodcgnepYaesDRKtM3j4KckSBgnhAmp9hQQVp2eCFwGvEeSzdlEwF32NH
	 ysLy37AfYACSLQUPBxZ5lpn8/5bihKgLd6qlsRgnxqrWwAFo+U7q+hEzkF1JgSuUoNxYk
	 /BPszBUqStJpbV5Q2GJTHWXWE/reOfYRYFANHlAWEp1n3WW0U61r1MCLD+pA8t0QLmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638186;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=NQwRtz1S1Fu+IEuwsNEBKhuQyWQGAAc1x9hni7mjxU0=;
	b=nrUIxv9zqwDzIHlZHfZgskltKKvnEACZbXyHNyf1Jm3EX5VeyXld8Qfn89xvCayLx4ju
	 xG0mvIIj6sy5p+dnYKHQzccC8lhvR7P1oJqes5VA4P3R8GNOwgKsOksb40EniDlD0VCwc
	 MjQjv0qrzpIDOe6G2JduWOJ8LusLPz5T1kWpM7hv02AP2Iv7GbXv2q+Y2BX0Z0UtPsMGP
	 hSIlKjmODWy38Clbp2MIBwkL32Vyi5esh97ZfjXSKtBGOQhcYD10WriMCzgLXWUzWBPcv
	 mRWjBqsewg74LjQtiRxFZcnE30p2hQGj2nkI5vQd4stUEMQOJnf38pwrAtj3BWmsffg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNLtsuoq;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D82E607464C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 16:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D82E607464C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KNLtsuoq
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0e21048f8so26546577b3.0
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 08:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638185; x=1794242985; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQwRtz1S1Fu+IEuwsNEBKhuQyWQGAAc1x9hni7mjxU0=;
        b=KNLtsuoq1aPnIBh+Nf/+vZqWt0oXtqxt95S1gy1+QCt3jPBPp5IS6vFiv3VBemrqIL
         i3bNC0dcYhsBZXbW+Cjpbupd9RonABw/BgM4WLf5P7JCH3fqbRo3YghKcT9d3VdB0oIR
         jYc0+fKCHtRAKC6AdxWBJYfi+lyhMD6rlxP40uvKmBBTbcF9eiFb048kXHgevfFlkAfu
         W+7WmDPRnSLo98Y40DhIq+M9594vnt20H7Hr76kJ1lAvhtPr8YyHTCM86F8WuCd2jW1a
         Qjld8yag9J+gjjR02akI6Cv23ceS7bTfkRVHvr2JcmGiE0W1UNOa1Ucrz73K8eLCfaxb
         47pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638185; x=1794242985;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NQwRtz1S1Fu+IEuwsNEBKhuQyWQGAAc1x9hni7mjxU0=;
        b=UkGtfZ4rfuetDQYUudXXiCDCpQ8G/qJ+HUZDrLo2sbkF/fswqTVmfx4kxzQNAoOrxl
         Xys0cvtULZykeC/VyI4NQbt7+a2r4FbafOo7//11lMI+8obxjrlskB8BBOJpwJDGBUXN
         KRen5Sg2cbJKhwSNzTn6ShRHpHyZenvD0xhEx6exa9DevfTm/apIoAbSXOJLs6icrWO6
         zGm2VonKowcFEujF8PxHws4HosHaobO09Kc+a10wbcLrumk00TmO/ps97GPbj2cwaTAk
         oGMUxdXcbo6LuXiG8o7KYyKSorf+YYf7uNrPtctj8hHvoNpWulsT/bxZ22aVh2aZ1q39
         cpLg==
X-Forwarded-Encrypted: i=1; AKwUvBwKvJHM3CL3Bhv7vx/EiZEy06IAgYg+f2dSNLdY/ZAhsF+CobO1Mw1zxMpKbj2Svk8gE6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NbAsMBXtuY4DnFrxpecCufZE/7NzYBNELsupZcsPNqukZpkFM
	y6x7SVF6MbwDDqqSjn4c+3fnQl5seaIu4IZjI5yQOE6sNObvRRpFL6KBEltHrg==
X-Gm-Gg: AYBFou0SCt2iOnFQSaVfRNnnmmITHy647s36Hs4pYXoUUH94aLWGV7fRNT4lDMUzRAQ
	Hpt2rNtcb8JKRZgVzaNDozEYqPorBI6llAEif+59HyuMKezKSUqbj0GNuhByCAIsoeFKDmbSdt5
	2cNHgmP++FI0wfHOC2BWhxifv4VSJlXZkYoCVPobvBFbXCfabytGezWObjGxVwLMKHxjSUVcZLU
	mW5/Cosk9ehHYZ6i8lUIR24XM8dSJ3FYXz+jnMAxxhNuMP1decT2YWrLQEd4t0/I1OC2CwYqLxX
	8pqdAmnQTCl2d12TEOp6MtkoZnLwtK/xBzLYcSYMS7XRKS483ygp2a5wL/mAzJJl0sGD5JwrTGn
	VOccpXd6GvB0AHrQ4KpCF9RyIYH3UI6cDQOhIEbLKZprHIPI3dW/YfCOsKTqp5zUBJCzylxvSda
	p2ytAJQ5ThHwzLtUKq/EnnQR4emE91wCJLvh/Bwo+iVDnTiOc/i+uFcvVpBm0iaxXai6q8JX/2O
	Nnz+YGM8yhxE4+/pZie73mAvSjFpk9I5WxQ661azPfzdtU01koE+yaEZV2fOdQbBuGAX9keBjMr
	VLse6QPcwUSzDLWpSLrRO3ISwi4ZRb85+sNzCx5jq2WoqfdxZbp80lMDxacLB3V3ThfUN4If69N
	LccICqGAD/9EuV6ewGIe3k6tDOzfngW9YBd1I5ph2DQQfJMOzZ0aRgTMoKd66c/8Ug1ICfDC6VV
	8=
X-Received: by 2002:a05:690c:6e83:b0:8ae:b617:7113 with SMTP id 00721157ae682-8b2b65d48a7mr73422737b3.6.1793638185263;
        Mon, 02 Nov 2026 08:49:45 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:753f:c392:a7d3:dbf])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b704cd14sm55772667b3.6.2026.11.02.08.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 08:49:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/5] format-rev: add --abbrev, --color, and --date
Date: Mon, 2 Nov 2026 11:49:34 -0500
Message-Id: <2A1E1423-8C1B-48FA-B1BD-DBD422748623@gmail.com>
References: <78d4b7c0-3a3c-4d4f-a9f7-4a6f7618ad88@app.fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
In-Reply-To: <78d4b7c0-3a3c-4d4f-a9f7-4a6f7618ad88@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 2 nov. 2026 =C3=A0 05:51, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Mon, Nov 2, 2026, at 09:51, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>=20
>>> kristofferhaugsbakk@fastmail.com writes:
>>>=20
>>>> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>>>>=20
>>>> Topic name (applied): kh/format-rev-more-options
>>>>=20
>>>> [snip]
>>>=20
>>> Nobody is interested in reviewing these patches?  They looked more
>>> or less OKish to me, but I am not the best person to review this
>>> series, as I do not see much point in this experimental command.
>>> It would be nice to see reviews from those who are more invested
>>> in seeing the command work better than I am.
>>=20
>> Second call.  Anybody?
>>=20
>> Unless we see some volunteers to give it a review in a few weeks, I
>> will discard the topic out of my tree, as 'seen' has been crowded
>> with topics that have been collecting dust without getting many
>> reviews.

Sorry for not getting to it :/

> For you all=E2=80=99s information, what was originally totally unrelated
> research has made me doubt whether this command is needed.[1]
> git-diff-tree(1) cannot do what this command does right out of the box,
> but it looks like some modifications can make it a replacement for `git
> format-rev --stdin-mode=3Drevs`.[2]

I saw these come through, and I=E2=80=99m not sure where you landed.

I was mostly interested in the stdin filter mode that turns hashes
into references; is that supported by your alternative?

> [1]: <ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fastmail.com>;
>    https://lore.kernel.org/git/ce69d94e-7329-449d-b3c3-47d4f3aa608c@app.fa=
stmail.com/
> [2]: <238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fastmail.com>;
>    https://lore.kernel.org/git/238e5652-e95b-4d44-a900-e16aa6ab81f0@app.fa=
stmail.com/
