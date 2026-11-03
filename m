Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793668263;
	b=fpK+C+ITwN/ZfISs2kBpKmhASeeyH+cHpJR78U9JA71xLMAEY73k7Ievlz0I1rSa49e3
	 TyuYUy1GFwMw51SVi8Ls7cD14cMHLolsiabgx2kuqs5WcI2aWuuuOBX25LH+zUkAFXx6c
	 FR1z9SrHw5fFmXnY4u4HkB1JesqPOfiF7Wh+pg68LL0ILZevGnAIrdjiEfn4uDIkTDW9N
	 NSkpPqwiRVMxjIgN6v9jSoLhrQaBa4WWmXucXHHx6pbMp6gbzOyfMXPRy3POK0cycsyvz
	 pAHmFZZcPNk0YSJBNW5hNVb/IIhe67IybwsoPvJhIarjV70kbLFWis72rbHyJGqce5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793668263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=ZHgoDa4ha+cuN7kzJhz7pasRPEw8bjf/9N40ppIqCPQ=;
	b=RRxkI1maMv/oEbZq2yY0i2cfStG1ShJcSOl/v8MwCgdXFgMHUHCSW7QxTm9u+n1DvE9H
	 /XtW/rgA6uxOB3EqkV8gfNUnnJ2AUb1rFBEhnQ9z/u8yhDgRNJO49QfqdEsnzY0TYDs0H
	 N7QPZ4emf03a4UWvfB5ebYa8/U2ItbiNp9LojUaB+cGCq8p8O5c9wXaWT9NFmIlBtKQkH
	 VYqezZbTUqDuoGx5h9cBNXZgdFQntM8fhoZb6+HsV0PEp3J6ooip5tx5uNcwd9yvUpj6f
	 imteoaSxGr9BsZEy2qmR3Edb3oORU8tPVldax9xBQoRI0y1Tey79ADEAImdP90PIr0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEw7nhnK;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D34606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 01:11:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57D34606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEw7nhnK
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ab43af5e97so2574007b3.1
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793668262; x=1794273062; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZHgoDa4ha+cuN7kzJhz7pasRPEw8bjf/9N40ppIqCPQ=;
        b=KEw7nhnKbB6bkbCPqYancGLqXeUrswkMj0wPeRKDLMZbL4tJosdEy3ipLVW0OTI/+Z
         eQPivXF+vVvXVfntElcGuua326vvdKecVdUaPp4TlDA5GR+ZbHkFwon8ik1mnVM+mknX
         bf+waowdDreqJCT0YyejfkmeN5r16O/vEpTt91uqDCmJ/74TH9QXkyammva2Eu/qux26
         eTvrCbywlBIIJULEJHN1m+nFcRYf4uNlMzk4jgcSrQK/0klN1vPUcj4ZmTsInEvVKrtc
         olNaR04JMY7xqK+vsMm1JQWjlG2nFQDqSYkqILE3sIFynppQIfcZzTeIHmJ7s3Aro4aC
         F09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793668262; x=1794273062;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZHgoDa4ha+cuN7kzJhz7pasRPEw8bjf/9N40ppIqCPQ=;
        b=T/AeUyizlwPdzSb60WtyGI+4CFm9EMj0uAIzm5NPQRYR+vjHbgT+8+nnaZO5U8BKgg
         Um8dE7IAVFQn+hyUb+BhzxOh47CL1/mtO50lGBw6iSCxYV0SmWUTg6m52kBxVS+7yNhw
         13trY39aF4y8JxJ6gE82ZJO3FTCb1uTlQZELqHJaRnU+MmSLcTZVowTWpok2tfyCQzaL
         d2hS8p+OLMKy1jaq8Nvo2PWN9wWI2qYBM/feWESSLMHNHsJZShokVWA5GQpHBRwjuGpN
         rVnAWreD951waKrOKe7ug/w2OULRLKSBZKtppDmBnAS5edcGO7s7x7cQGaOrBvtG11oy
         vTaw==
X-Forwarded-Encrypted: i=1; AKwUvBw1ckx8izJf4cnm3mYKwcTGf8PaK91p+YECCvwUNWHxjhFi2a0Y/zU9VD/tK/Zf8fCTHgI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8WZyivP4l4WVX8Rfnc4RibfS7Y1looZemEbLFOEfEVlgis4sxV
	VGnfQ7ryv3wL4ojgij/hSROPA2sqy5iDJaPMDbdahtd5PnUcfXCudQoq
X-Gm-Gg: AYBFou0uOZ9zILfPIiZer/iM65eXAYmJnhfAdLFrPjTEl2U1vJHSJk0g9FsEy2zolFw
	GWTLVVQYtT/ohprW41a0s/g651F8dpmINyWc5ETb0pWaOmgG7VfQBE4hpOx4N/5Fgi6hV9pXQYK
	clTjXqslatu1hbnigdHOvgVh3L770es/P5D0cB1T3MMuW7m0KpO/vVlSltPHsp55I8gk2VIiskt
	pY5sUSeubasxeHOq0Of1j8oOyK2Q4CH+N9WskB/O0TGTeXjjFDyeCthGTewp7N2ZUTVFVPR+btI
	TXwtHNO6eTJXOb2UBinEKNa8xGWjvb1FFssd5Ln0D18ReMwAlG0Lw74ORWqXAah6H3woGBcNXGL
	ciPB4CGvHIx22p76ZfVhtU5+9w9nOWgamyZiYLUC+no9E/ZegA9qB/Lfn9V/QqSdSHJofiNp0tt
	Zk2P6EXwDQJWM9kplB5tq8A3Mm1lpgV37+SwzJm5c9gq2OF+dDF+Yvn/SYUmW+DzdWa7ljnxQ/s
	M45QE4uUnmYjUnrGLga830PcpXZHjwCmkZHFVUsY3wdguCLhhbaLRgGAab3Yjp+a2uX8xXzyhV1
	VwX8OM8ifvaYHjPpJIJwzAV8LGR6PVtRi4WZLU4NW6wCHvGobOKCdGlBXOBGN3zD8avjPKAhcEe
	Pd4fuPqi1oaI/txnFShI7Nu9FXr/9HTae0wKj38VFxUM2ALRZsoMt311yymgEo1jgeK9qPtaJVK
	A=
X-Received: by 2002:a05:690c:e1cd:20b0:873:5c7b:c13a with SMTP id 00721157ae682-8b1c68bc542mr69674917b3.34.1793668262312;
        Mon, 02 Nov 2026 17:11:02 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:d067:3949:fd4:d4cb])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b2b7165abesm62963017b3.32.2026.11.02.17.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 17:11:01 -0800 (PST)
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
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided commits
Date: Mon, 2 Nov 2026 20:10:51 -0500
Message-Id: <427F4BDB-B21B-468E-9C6A-4A7FE3F13688@gmail.com>
References: <xmqqcxsmg473.fsf@gitster.g>
Cc: Matt Hunter <m@lfurio.us>, Harald Nordgren <haraldnordgren@gmail.com>,
 git@vger.kernel.org,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
In-Reply-To: <xmqqcxsmg473.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: iPhone Mail (23D8133)


> Le 2 nov. 2026 =C3=A0 19:16, Junio C Hamano <gitster@pobox.com> a =C3=A9cr=
it :
>=20
> =EF=BB=BF"Matt Hunter" <m@lfurio.us> writes:
>=20
>> Wouldn't invoking as
>>=20
>>    git range-diff origin/master
>>        pr-git-2401/HaraldNordgren/range-diff-matched-only-v3
>>        range-diff-matched-only
>>=20
>> address this case?
>=20
> Three-rev form where <base> and two evolutions <rev1> and <rev2> are
> given, and <base>..<rev1> and <base>..<rev2> are compared? =20
>=20
> I thought Harald's case was to take the patches from the previous
> round of the topic and rebase them on top of a different base (e.g.,
> updated origin/master), so there is no suitable single <base> for
> the three-rev form, but I may have misunderstood his example.

I think origin..old-topic and origin..new-topic=20
would both select only the =E2=80=9Ctopic=E2=80=9D commits as long as both
bases are reachable from origin (which seems to be the
described case, to me).

I agree with Matt that better selection of inputs to range-diff=20
makes this specific case better :)=20=
