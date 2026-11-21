Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795228747;
	b=PzIq4G+Obo/5rRmmeZKWPpmUVXQBSGqxb0NoH7SyfvqPDhI+pL4Fu4saeC/gbSQvC0g7
	 ZLzbvt6Qyn3PghaBDqiaHdC+HLkgB4j3nYtXRwXZt5zZuKZLkCdoHiv0VmokzkwieU+3w
	 fIJmZB4Z+N3Nvc9FeHQ04hEgSMaOyWyA8xqBFBggULgcfsc8fpkkGG+ygiHJUMKrc4315
	 bYJeX+u00exj+Vi9hwqKorMunTinIdElAP7nlq4THA/+94YxHWRh1/lawmuRvlOudwWN0
	 gi+6kjkO1hByoeD0FdY4QEafj1ulSUVpvvqxa8k1E5yD0qEsRGPEi+7i0ZflbCGmO/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795228747;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=Xu7rdlj5Q7upiARZnmg17QOI7wEjZ5lVyCWe3shhz+k=;
	b=wXBjtzU1dROvpdQ1gJMg92abj8ZITFiZ3+Qd4BCmAjFgqpzKC82ON+AzukJyGqmnnyuC
	 iEqWJHiNY8B5hXvKHrvlHf9Ce9U6q1EfMTvaJad8Vq34yJFCZiTUyXyTW6Eu9+hxZbiPt
	 rFJqV4YZpIrZEeCIv8Pp65W4ooJn4KxaQ0GKZC1JidoDEehZwQR1IXIgp+XeJ/k+KnIFV
	 7GkJTT+gyY/mj8jsNIzwNcFksXXJ2RrKgWbDIpf3q/sVmF9JdsHqCWnTHSnE6KX0PETWL
	 c/nDBPSRwWvR7InvOGO8kSf0joAg43qQOQ00kUFJLomWcBXtk+a8lcT2Cmt9dRIUvKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R2zVmXPh;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD8C606A683
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 02:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD8C606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=R2zVmXPh
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b30cbfa628so11241647b3.0
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 18:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795228746; x=1795833546; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xu7rdlj5Q7upiARZnmg17QOI7wEjZ5lVyCWe3shhz+k=;
        b=R2zVmXPh0dgOcsFm3GmVWjOkuMqrbOILjmg9/tc+xat4t+q1BS3zBuG0gR31DOcbeN
         5NCcGFZYw+SSQS7E8bT8hVMLlYwViXYKNXeirJ6m3M5r/PTAVArp7gZ7JBT1knKdPBIv
         x+l08klJLutU9o+XtNjtYLr2uR2sM0MAdB85ZRLGnV5GldSz6bLhsQihY0GvuGt1+97v
         Nm9/rvYQba37IyQgJ4qTSXTIR+NRjHpy3TRXIte9UellGJsO5/eMR8IFsHNBItvqjQ8K
         haC1Q+QD/SqjtwGppj/WTh3RjgY63ptcEUdQv5PqjPNyyGLOm6Xjai272ZAizE8yEwWe
         wPJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795228746; x=1795833546;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Xu7rdlj5Q7upiARZnmg17QOI7wEjZ5lVyCWe3shhz+k=;
        b=GHLnxeCub6q14oMbke8D6avSkWA3V+SE3QqriBkAtaeAHpQovJO/PaRCZbuLV41D4H
         1cv/rj8VQyu5KRrfi6xRiPpgRAMtzFK9uEKxr9q0z+MQcf6HCDMfvOEyg27psoVS4URO
         dcDJaPdEN+P2mA+NgW/Si4PelThxdDvIvXnfBIBVKRKkdB9y01eiINR+FyC4BSSG3509
         TcFBsX6Lt5urVRzSH9QAsb9uKP7MgDPfFpgVvFX6Vqs7m08XSwPWXHcvwFA9ObImL9F4
         qmcpFXKyJXG2q19DRVkZlJcJyaoXskfWB4ffsVKzF3nzlvtRgVhsD/AJLdptlAK8zKGh
         wg6w==
X-Gm-Message-State: APuU4Z9qi3ga1m7Ob6wdXFPGCGYCsMov4a4TD+wk1zFntFlxpE3xv1mg
	xlo2MiFcBTKaYQfq7oZlZe70DRcTFXJu40Ku/sN+7oRHZDcKe4qfFcXa
X-Gm-Gg: AZFdTZcBliNrI0vCoWsn8GBdYDYt8JnYqmBC1vZB2ryqpj3o3hvXXW6MCuHemWWa4bx
	ElP4ZFveo4C76kLEna/LWNIh6fONIPrdsuMbQqtaXm3DoPeXgdJRUTyjObSszfoaCQRGNnmGNRn
	IlwoM3uxzvkGkuLDKrA4/svwtvxee4g1/QLIdpU164p9qEI8FI3Az4AChfCGRfDp6Ynp2mFcKuy
	YKHudXKcKp1s1BEKfdMr/Dav3WhtmZn4+SrxkHaFP6BERZc2sAujSNE4zEsQqbytxowegwKJrlA
	8X0bnNDtajj3FmTJdVUs3y1+LVhSRA1jsl2zPZv0uZi7nYI2yY+jqn10rB68q3W4nL0pzHA6pyJ
	tJrQEZaPNbndKVaeU53YKKJrlPbI1wMAydtjJWPlPnIvXOp1fuAEEACgOyia1ZmBAsLlc1YfW4t
	S8LHsJ9ckhEuI+aC0IR2CcU7BbE5DNJtNVruoa5WyWj7RTlgnpjhH7QLLaWUCoRfb2uPYZa2qdr
	r1vY9GDpEaEmF2hL4wlXwtOiUG22wAEqy3HGqYza8zU6x+RPrcUXArMOOm5Df+TJWyqjk5xepEm
	2o1UUs7C/3elX/7JdWcpPBo4pnAF3MpVgiUNoXbbjJQgQWTAQNMzDEzJbo9t6i+9QnPvMJSOUmZ
	IjSUky/Fx15ilfiyW8/J08pBq0xzP56qtgTgutqOmji08EKLqieKx6auH9WLDqlUKJryowk4Dwg
	9mCQ==
X-Received: by 2002:a05:690c:620b:b0:8b4:c2c4:c5f4 with SMTP id 00721157ae682-8b5205537camr20408367b3.67.1795228746010;
        Fri, 20 Nov 2026 18:39:06 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:a062:d8cf:edad:b70c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b520330e86sm21371687b3.38.2026.11.20.18.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 18:39:05 -0800 (PST)
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
Subject: Re: Branch Awareness
Date: Fri, 20 Nov 2026 21:38:55 -0500
Message-Id: <71943758-1A3B-44F5-9BDA-233F16AC41C7@gmail.com>
References: <CAA8YNQAsyUe275DLPRnB4dym5aq9ZyemA39u+HJciKzat5tNQA@mail.gmail.com>
Cc: git@vger.kernel.org
In-Reply-To: <CAA8YNQAsyUe275DLPRnB4dym5aq9ZyemA39u+HJciKzat5tNQA@mail.gmail.com>
To: Jordan K <jordankadish93@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 19 nov. 2026 =C3=A0 04:54, Jordan K <jordankadish93@gmail.com> a =C3=A9=
crit :
>=20
> =EF=BB=BFI have a situation at my current workplace that led me to conside=
r this feature:
>=20
> We crudely pass around a `settings.py` file that doesn't match the one
> stored in our `main` branch, as many workplaces do.

We sometimes carry =C2=AB .env.example =C2=BB that folks should modify
into =C2=AB .env =C2=BB, which is ignored.=
