Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793434204;
	b=wAzAMg36ENIziQRhO5E05BGhY8cvfxUw8F+5S48+xm9Ar79CAsr1UY7YV08S3WesiSXa
	 DhJNytw0vS8XewbroOerrk5arGn9geTYip7iv2P5c12dXo+Mk9Zy8bowbtR5qybDorKEx
	 /YPl4ItpqKY8NEALjv/pa83e2uhut+Zi6FDjkv8q1QsTe5IAeiZRGaYb68pD1gJPzl6JK
	 x7Sz6QtWELy/RXsoa2x7Fji8zOzCmO79kAbi1DERH5090yISNbWNJFc+diEwBdCBFDsei
	 IqBWx/zLse373p90Llig/bArtuBqJwQN+Oxvhzzb+QTZUOvmzD65PDyrZhaXe0Af8Dw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793434204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Y3mYO7spX0EL7hFwvq/pH/NXbwd73kMeRLA4CesO3jA=;
	b=UZN3dHf1ktyAx99ukz6sZYLLG9zljyFkk+uRaXPmmALuthbsxJ8W5xrLpfnO3Cxmk2re
	 8bqFN8Jf9MeB8Ca93l6yMt4yy2TSBdTVc/8nl4NQpFYsLCeFo9/889RyNjrQr5QkutT5X
	 NpfvXpJgakIN4wkISjaVGsItScgjNnOSmSqkcJgv9KUXtYP6L3Ryg+0UsNrhXFzFKNR+6
	 CMDDCGTUkr3mhTtyRLY4vdEdd4QuGEqFjrXO0PWrxyQHQIPEpJ9/O8ScUi0wjvxPv5ufz
	 dThthEtIss2eqO4iBN7AIcJthKSP6BtnwGhRxRh5RAvCtYdEOoxQrvV2R8GzskiIoAg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qrld7XDw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E169606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 08:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E169606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qrld7XDw
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b1a86c0316so1856354a12.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 01:10:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793434202; cv=none;
        d=google.com; s=arc-20260327;
        b=F/nCcH3+B+gV3hB3huCHuHecp3TodBKNgiAxu5u/5ukfxKYJavmrM3Y6J1f6jSRA3V
         cVRQCQ85zPdpohCRXZ4nvxsK1Ydz27N5oSA4yxiV5UhjYoqE1Rr3tYOEzSrG7M8N+hyc
         113ADfMjaSqfmPp35n++B3ds1H4qY6FavZckGXBl87Eu58ZsqPcwEWh1zNGi8J7Rahsw
         +bmHEJUYskVtitWiyccSGmwfnA1C5jhsX7k2IqMey5ud307RqyNzCTB86VRFRL8lHJs1
         aJvGlPcaPcko5wm+baTyaH8DYIYzH1AjSgTYHWhXaWIdcy7W/6ID8HxVMo65p3pTNSdn
         kTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Y3mYO7spX0EL7hFwvq/pH/NXbwd73kMeRLA4CesO3jA=;
        fh=nr1v3I221/JHfgJZUgYs7CP2qCsAYp0Lsc1u3ivjkeU=;
        b=PNZU93KV9f4E7/3fVTlt28oh0GzLKY0LDYsX5Zwduy75C/IH82XlyaW7N02EGI88Bp
         nLL0vMwKOPmm24NOJrettR+EfDMg8wW9f/Aky/Neq2Mxt9PRbZVnxyr8gp8D0KgoUk1h
         RcC+cnDx5Ot3I67DFFkvOb/QAJJRAa/yJmPdGlfimi6Xh7cefoUkGzsi9tfEhmFE7+GT
         qrZoXS+b9ACM/80NOHz9rxoI3x4UuBUykeia5LdkXpJD/4zbu35cuB4z4ZW2r8hfsJy9
         NklRS6efEUzX93sqWIO6WOy5ycyHqaRyA8ypilTHdXmCleMNnX0tPrAGGcED56V7sAIB
         83YQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793434202; x=1794039002; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y3mYO7spX0EL7hFwvq/pH/NXbwd73kMeRLA4CesO3jA=;
        b=Qrld7XDwnvori2t+/yjp72Cu83DscYHEkCxPi46uiVPkBrBxZAX30ETV2RjEiLpUbe
         4Hw8RDqpoxJOrIQIXMxqqgFtf3JsoDVz4Bd3e4IE1YiCVwOL3cMETypo4Khi5jooM+3l
         vhBGerY86t8nTdwyko8D4JmrjxunSfr0/ivqdi0K9UahzrxzTKZ1zY3hkjl25OYK9CWw
         o+semMAkvZyLnVHm7HvzeDWJnXG8exRryc7aRlja3my89rzIDZ0f+xB9cpJoHEvStpAS
         YuU9yBQjONk8Xe7muwxEEHvnzFdvdVJF10VtEjm8dBSQRH8CoP7+2kxW2w2WG7ZCz9/d
         Bgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793434202; x=1794039002;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Y3mYO7spX0EL7hFwvq/pH/NXbwd73kMeRLA4CesO3jA=;
        b=eRnZr04B24ZtiCDE5nJe/7Azm0CCZzzayyZWPS9nT0CVNMf4TS9DrWBKr8CgsEbMbu
         Cuy3sfhfDww390V68N4RNdM45EalBu61SunFAzj+AXeW6t9QXpRLNc3kdaSQT5ooZNrV
         gesUPu69YwdS1sb7yv4MR7SCNOyQFhxq63BHV6G+vTPgKTVtia37hk6qMriQnDaqG7ei
         M/7Z7QTjfCypN9aJaKM0sM8bNA+3pTVqig/+Bq2JvzSb5aNHLKLPoAa5wgWBgH2NQCI/
         wZ/k1uPupL1k+VQ7Tedb6Wn1jCjHr/Q86MmnXtd51UylNeVC7HELiMXTVc2F+vtSJK/V
         xfmA==
X-Forwarded-Encrypted: i=1; AKwUvByp8hCVXRnZa8cB79BiyTZmf4/qj9qUbLcB4UoQKLjCwiNuF7A0KdE8a8h1m+KNj24G4OM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVoC6ESv1jrPB3ktkvIiLPPHAx9Wq/BaokkcM/Pf89XdsVkHdq
	E57S2cTAb8rVio/LX3e0Niec8AXUW4bHH0YIygsOUs9LZ7BjBNXAkDeBybUUq6rNCr69X1Kdq1O
	SaLivdXJuIoqmWNEskjFQwCckCKZfb5M=
X-Gm-Gg: AYBFou14kTz5t9oNqb+Ccj41pL2btEwwBE7yssjzL1tb7/QiNXcf4JGbUWckBm1m01X
	5iGlD4VcessSdiobpQuuKqfJdrYdzWKq4hcUbnYxuC+RQJJSdgzD2BcHu2xbet6Z84S8mFboaHG
	rYMSdn/tsNAfDkLFqGdbVoj6QHvwNL3J0WfGVmW3wZzsKQCiBFJAg96RtZmAIQ9X37ESX5VqJTY
	gvANUes8dtuzWj1B6Od+v0UqxZVuF383MQtQf9v+MbDc13EmZZYT2xKCpVB9eqIETTTlCWs6xhi
	4WRsp0ghhSuAEWeZ/m3JZIsrkq7U/G09QZb4TF9x054J8Dbj6WCg6+EpMrWQF3LoYB9ocbbgQ2e
	4k739naHZicPjmDHBJzsOaaoB03KXAy1Cow4=
X-Received: by 2002:a05:6402:42cc:b0:6b4:66c9:92c7 with SMTP id
 4fb4d7f45d1cf-6b4d4c739c5mr3275419a12.24.1793434202413; Sat, 31 Oct 2026
 01:10:02 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <pull.2425.v5.git.git.1793357582.gitgitgadget@gmail.com> <bf30f57ceb77c5052a72aa7dc01e3bb163993a63.1793357582.git.gitgitgadget@gmail.com>
 <xmqq33tnvw58.fsf@gitster.g>
In-Reply-To: <xmqq33tnvw58.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Sat, 31 Oct 2026 10:09:26 +0200
X-Gm-Features: AclHuK9S3lTY7dqlYaW3CpdcLeENbuiTTl9hdncs6iU4N-4V4w4ETzRgq3cq7ls
Message-ID: <CAHwyqnUqkA+RzXNq4C0Lm0mK2-70YQkjnj9s_0E4M+7tGMN=fQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] branch: add --delete-integrated to delete rebase
 and squash merged branches
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Jasper Mayone <me@jaspermayone.com>
Content-Type: text/plain; charset="UTF-8"

> > +static void find_landed_commits(struct landing_search *searches,
> > +                             size_t searches_nr,
> > +                             struct strmap *landed_commits)
> > +{
> > +     struct changed_paths cache;
> > +     struct diff_options opt;
>
> A tiny nit, but because so many things are called x_option in our
> codebase, I am used to seeing the variable also carry "x" to match,
> or the use of mere "opt" down below would make us go back to see
> what kind of option it refers to while reading the code.  I'd liked
> to see this called "diffopt" instead.

Ok.


Harald
