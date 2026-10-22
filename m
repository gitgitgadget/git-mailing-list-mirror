Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689280;
	b=oWgbo18QPRyxudt1KPj69PDFNiGY4rJEWjcHpEOlPTxVa21TlBLjxo/W1N8maKDWblS1
	 ebhl51o+5A5pGGjSTG2LI3tf9NWWXVyzF3iktF2gul9aOgFf/MUvDCN0rc/8ZSAD4ObWR
	 pduBAY+s/736vH2w5uRYlYk6XSQFogG0DHpqvLnKVVlcnN867usHD7PSlRMbsfzqqhWVo
	 dFT1Xv9MQEymEa2wzjtGTPrRySHSgeWJSgrENfe6mcIEr8TnLugfgjepLSYBxBCIxyzE8
	 8cwCbEfuUSI0gB4ANvndX0EkxL6BPU0U7LIkr1EjfYyglG2h5SF8Y0WBSbXP4HfjJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=Nd2X30PwHIiim52bmesweho//9llXQ7fiJQFefBSlO4=;
	b=DV6ngCeBP7RU3CBqa0mWT9rCwLXsoLi9LTRr4/zN4wGgywL2VtHXD6xtdllVUf6qGQhR
	 xaGjpeksQMCyc+IuQEg41bdCXBByEqguxPgGVdj2hNjsebAnJQMMHnLjVaEW275UjfFRB
	 ZGzqy56n3nsMysIa7cwY+SkeSmItxcvCreVYHFbbO/spQC7yaVtjlUdtj9ov68uzIUC5Q
	 i2pnc6s7XNFYRiVV8v+q+n8wFJWpCEKsuQL4CxY2eivxhpOuTPlIGOu1SFXHuRkxLMyvj
	 Y5YtO1ASpLxGqhgHpEwGoMoiHpQ9LD7KCyXOzJyvWIeFNdXns/YMJ3OpgeAHCAEht2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a5dfE747;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB938606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB938606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a5dfE747
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-679a420b5afso111678d50.3
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792689279; x=1793294079; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nd2X30PwHIiim52bmesweho//9llXQ7fiJQFefBSlO4=;
        b=a5dfE7475bAdH7lkbmTjYVsUd2V+1vh9/s+h5kuP01aPGgLA1x5h39USatI9hwpVdz
         eBuxDRyK99GzNUhf/j05xtaAFIXSFxYriYC//4Q9BU9jnch8TZrYBjuHsvB3ZB88mp2D
         Y8Yooi0K/EIcAbXeFSdTo0HEs7cNXJ/9qnPzkiHHyYk+qztNT2089mqrka54tbBI+Ody
         YXq5MmlBAgMl8Mc+WuEXrIZycLNjFYrxalDBjgZA61rl2P7j3U/1I4fMGMicJvAaBizc
         t1HlyCjXHKO6mpkK/SP54tZl1Lx7LmxisV3GV9VSmFdeMVcuGQf8EAIb6Res/QY1hk4Q
         Q4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792689279; x=1793294079;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nd2X30PwHIiim52bmesweho//9llXQ7fiJQFefBSlO4=;
        b=EDZh4MkRr9yM1WjO0yhALH9U8nDDtHMF/DXH0amncdEvnDWlsvh4rL5hNIXc7UNp/h
         t4AJ2DaqVcbU/zwb6XNiLvGbGj3BBKVKrM8IZ+Wdr6LvSPgzn+xiapzzCxfma9oCgQ3A
         2r8S/h7To/NrNSLlTzxli8m/4xsI5q+C5iRy25NuUJaOki/KBVQb3WV+Kq8ORxZjTOCi
         Da0vSzNOTxwxz9o9ucvl69ibrWbFyh3v0Rpi7sv3OGG1A/2FO0alpOwZaJLCBXeFUqha
         JUu11oDRuzcajJbOwUO1UKIJyZQ6vXFgryNrxcy0R0LB1jnPYfIKxEAVB6844YlpAemn
         sF8A==
X-Forwarded-Encrypted: i=1; AKwUvBxt1CdUefD4Fj1LqNdh8LQCv1+jFmDQSa0/Mok4747fJEOm1Vac38r931fRsaEuTwucapY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxld5laFo4g1Uf83tNj9J4D2vs3LOzluiwPuN7z96+3kVH8oxT
	dQu65OY9mUA+WerAvD00jGk6mRJgs6engq3K+fiO+7JyatZgK2KUTgSU
X-Gm-Gg: AYBFou0JW3RXmjYHV0PUNB6GtbXHaB0KAEm+NnQrKEo1GuixmfUvTjAet6aatr3KuI6
	OPdmKJYDtHSuZMaiEvdeGQaHnkjCLHX32r/efjLwYRf4HyRR+dpVYiCKrg3Y6BvpqP1MACaiTbB
	AecQ1BHRN1xtdL7PD/AJOgBKZ1pTb8/Jx1N6XPrhsvAS5zAv3WC1qYcNCQR6wr1BnkveEnt/rLm
	kl6+aLLF7Ll0BoV5+gJV1Gyx8CuI178vMsA1v2wdTDSghFCxeaZRrbjGmU8FJHJPrh4S85lrghf
	Dr9vOCRgjha9Jm94YNMFeHKUOlZ6ONWeGZ35Cctwwtg9hjLGFRCVxOqNJZxObgE5ak5YwtGOFDU
	2zhil2meweuWWoUBgjdzEOGqJQLgqc1zSB9m/N9pMKAw1AXoiPN45Z2o0nR8SlOkfXX4J2aG9G6
	vueJTMIh66hMjTdz92QdI0EGfanhXwO9FfS9ZzmVd3ZMYkK//hG2PHrbUxG46GrwtbB351MGlKN
	HO4+fiB3Sw3OakubmGB6BbbCImn1/Iq79/KHFEoN3siFDmOuispF7ct9Z7I5d4ykuI9aOTYTu/2
	VJINv9vyQNGZnN1r8L23aRw4AxG+UBBgtdGGalr3rxbhLKQLcYjenUTSNj0gRYSROO8PcBYnNqa
	Q90zSSvxgEGrmLXEn70gWh15Pd++PTQ==
X-Received: by 2002:a53:cb45:0:b0:679:be6b:42d5 with SMTP id 956f58d0204a3-67a0e53f024mr1567215d50.98.1792689278713;
        Thu, 22 Oct 2026 10:14:38 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d17:3000:e9a1:bd4a:ffa6:a144])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a3404f773sm24835d50.20.2026.10.22.10.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:14:38 -0700 (PDT)
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
Subject: Re: [RFC] branch: delete gone-upstream branches only when proven merged into a named ref
Date: Thu, 22 Oct 2026 13:14:27 -0400
Message-Id: <3EF4DA22-6739-46FA-8028-74EED08BB931@gmail.com>
References: <CAHwyqnU-BEtOPdVbBXtuEYtFYuL3MqC9nUQeP_Puvq5bsoWEAQ@mail.gmail.com>
Cc: DonQuinleone <don@donquinleone.com>, git@vger.kernel.org,
 Junio C Hamano <gitster@pobox.com>,
 Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAHwyqnU-BEtOPdVbBXtuEYtFYuL3MqC9nUQeP_Puvq5bsoWEAQ@mail.gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 22 oct. 2026 =C3=A0 10:39, Harald Nordgren <haraldnordgren@gmail.com> a=
 =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>> I would much rather see more --option=3Dvalue,value,value syntaxes, like
>>=20
>>     git branch --delete-merged=3D'origin/*,into:origin/master'
>=20
> This feels completely chaotic to me and becomes a kitchen sink :)

But is it better or worse than the kitchen sink of

    git branch --delete-merged origin/* --into origin/master [=E2=80=A6]

? Hm. I suppose if you didn=E2=80=99t like commas, we could allow
repeating the option to =C2=AB stack =C2=BB instead of replacing.

But I get the feeling that=E2=80=99s not what you took issue with ;)=
