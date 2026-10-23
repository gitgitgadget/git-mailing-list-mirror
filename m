Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759444;
	b=LVipGS6qccTknoro4qLGyvR+7xYYqnJIYZ1phms8FybRQs+7qlK+fC3oNBnHNWXj7Un4
	 ug7/9B6Fe9lH+Q2EIzN6RQxpdifZLOtNiyYqykuKd7Cga57OwvRclGcpvFHDU1XaTEixa
	 ZUL0XF+i8ahgOb+9y+mT+H9yOU8T6hApbdyleCdnbT4BQl8Y/LjgXP/EEz5KWQzN6pBza
	 9TI++mw9Iq9Lte61ldz6BFpEgyO/ulROgEg0gWOrlX1G9TEehzd6eXDlKU5x8DQW3XGE9
	 VctpqlV+ZgfRGHSryRNFt+z893t8v51k4vCNv8Jp4RC4a1ZEs1olvfrTnF7Z6u1KL4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759444;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 Content-Transfer-Encoding:From:Mime-Version:Subject:Date:Message-Id:
	 References:Cc:In-Reply-To:To:X-Mailer;
	bh=zIViLfkKV43CcarbTT2LoOdzr7Z2WGObd8umT+NuCYk=;
	b=B9qcktHJG/WdYyKUnAsMgZIYTeATbDH3cTcodpj7E3XIZTRK4j65DIfoHuDUUzurC/Mh
	 +WcROl9CimiPWeXRllRgdjWZJwHTcYiojgjMRCUSvLAimGQPqbnikqSwx6TjOlCQV5bbV
	 Avj2fwj003GvMwU6UOKSrF+R29n3BQJ+bS4sC2XDhbLcYDVlb8Iq/i4dgL4Uq0TAjec+Z
	 Gg+X77cjpaRt1kOL9ifU4Ahz/kdmzyA8Techl7jBrFZcJEeQRLGKjJ9uekjoJa4bObAgs
	 xv2YfZrlvao0/ITJejbo6yl76LANPg6K708BzJkxBKE7vxB8lwxxtdflCtkSDNwd9NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lb+GVQJf;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA592606A320
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA592606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lb+GVQJf
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8ac9d666d4eso7199817b3.3
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 05:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792759443; x=1793364243; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zIViLfkKV43CcarbTT2LoOdzr7Z2WGObd8umT+NuCYk=;
        b=lb+GVQJfG8Gp8cfKiWGS2tEFgQMLxENGLucDA9HbVGdWwXYbqT62QA/BpLSLFGvdce
         yVcjclUHWq/TPuyfAo9VYoYWh+m19hWcpNxCM02L0ikZcems+p3kQcLGccDz9R26UriI
         ubZF5EOD5bqaVErUeMSk+6g+dloKySCDxF/fAnQ5K+4lrjy+VETZ06TJHtBNpKn5Z6zu
         Ro+KhO4lL+EyDpGyeKpFRu3q4mYDgGD72ArISrP1NUD685B5WBwMjTJZ/3FguBKtcdko
         5z2ypjUzbzBQ3tzryKCqSJXpsIPbRgtmbYq8/rguvmHk/gnpZaPzgsf7Mnw+f9RxbaMz
         3OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792759443; x=1793364243;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zIViLfkKV43CcarbTT2LoOdzr7Z2WGObd8umT+NuCYk=;
        b=Havu2h+Sra0gXDK8SXRogqbMR/Nnxq/o2LVy7qCaIC2HsXGNF/HcL2jusjrYH8ui4p
         AR33SY0hd0980jNq29gSstSQaZxOG0l+avY/IEFpK+b1Hsf+0X2ick0xRIVVFjNXOPt9
         aAD1GaSheJj1qo06LKOGtth1PmaqNUrVPJgLt+5DnKqDnpzL40KbMeS2hGUtly06+hC1
         Fwehkcbp6SvMuobysNGfYV/fLS4Vu/aD9fKzyM926QzJHI4Ej7ZFOKM7ekL16NzaOdQI
         +Jh7k27oB9d3X4vMpTAG4DtHVSIM51TLFMjQk7dlcbLUlqSwnx8sIZbGH29Gpj012Pq2
         b2oA==
X-Gm-Message-State: AFq9FYICDXEQyfB6BDODVYfeNlIgDn5Pw8+tpyqXQ1+Fj35t6WNywOZq
	t6UCcOMCaXYu4l2F1wAVuWCPvSU0q9iQaxqX8jJqbIj9VrbVLuEHaQNkDwdSyz9C
X-Gm-Gg: AYBFou1V2bCt0GYB7lxQdlpmmUnrVmv6X7hfLpngKuN7TRPLH3cMjG521EnTkoKDP2/
	Drhw+0784QzkguZk4evigE+NYR5+rty/XRKaOaKQJfzK/Rv5XMJHihPiOKFVPobiTXhLlavh0IF
	Jow5hpPdCppNsLpMsfWrcj6oYKG7iALiM6iu2HIfkD4Z4BFP3u2e1gsRHLl3SunTX1hTHmqD5eT
	8rSrg4LUCJx/oV8SBTvAVCi0qMcMtuBtPQbP5VpxGKE7ixjy1fXqZj/tYjLx7F3xmq96OXDV/ng
	S66E8WDWNPrr+DkllxqfhQeinb/WG664fBTPvtbEZ22nH2viCYTsYXCuKaQRyh0ukhD6C43fYQ0
	K89kxRVjULpzozJnX0G8DVjBv4En+MDMR2I+HljQbt4yFJ1/bF31+3SBKP6Cjs8RMMPotu4vIQ5
	LjOGq/TcS/F3PjCy25SLkXADt+Ij4L4fq692DoBh6YudfbT5/4IcENuMdOPWreBxSe440KDRtFg
	/BsZF6O6n761M/JkWFZ3x+KXoinlUw3qnZ9Yad6gdwiW4ISw9FlyBMzqmCcTFR0YaGwUhuOz3VN
	9sgpmNnVXA5FqVqqMnd0Z5Jn1u9T6+v9c0Kl9Z1SEtASPBiMC6veULsiPO4Tol1zcgNC42oE6tI
	Rmd840H56+9uuuPW8asiYQiHYfXlttzSN6tL4xFhRXTjXXjg=
X-Received: by 2002:a05:690c:c510:b0:8b0:8e9a:a4d4 with SMTP id 00721157ae682-8b157c70be3mr16043457b3.6.1792759442805;
        Fri, 23 Oct 2026 05:44:02 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9d17:3000:1d:477:fbde:1358])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1560cc4aesm12824047b3.12.2026.10.23.05.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 05:44:02 -0700 (PDT)
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
Subject: Re: [PATCH v2 00/13] SHA-1/SHA-256 interoperability, part 3: pack index v3
Date: Fri, 23 Oct 2026 08:43:50 -0400
Message-Id: <16FCA7B0-02D5-4887-B2B0-3B794ECE13D9@gmail.com>
References: <20261023072559.3204273-1-christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 brian m carlson <sandals@crustytoothpaste.net>,
 Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>,
 Jeff King <peff@peff.net>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Christian Couder <christian.couder@gmail.com>
In-Reply-To: <20261023072559.3204273-1-christian.couder@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-Mailer: iPhone Mail (23D8133)



> Le 23 oct. 2026 =C3=A0 03:30, Christian Couder <christian.couder@gmail.com=
> a =C3=A9crit :
>=20
> =EF=BB=BFThis series is the next part of brian m. carlson's SHA-1/SHA-256
> interoperability work.
>=20
> ## Changes compared to v1
>=20
> Thanks to Junio for his comments on this series.
>=20
> The only change compared to v1 is that I added my `Signed-off-by: ...`
> to patches 2, 3 and 5 (that are otherwise unchanged compared to
> brian's original patches).

In such a long cover letter, it might be helpful to present the changes from=
 prior versions much earlier ;)=
