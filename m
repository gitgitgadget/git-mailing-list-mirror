Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815226;
	b=oVVUfsGy55ZgN80hclR5/b25rR0KiIFtjeRPZAx1Yabt9wIUvGlLbh4GA3uaPoNUwyIB
	 e61aTo2u2D0ADUvl8KFL14alR1/wbzrS1jzymlTWjZZ9dWxhH58DeN3PkexophSWOWfYy
	 7fRFYWy73IqvrUqwVhEfloiu+v50JUNXIFmUuUggCKFz3ysOX6TH48mkNPSaVxSxlItY6
	 0AUjCjD4bGdqItuK/4TT0PvQb7GQDee9Doit162EUA19H1Bqa4wS4sskg5rgW3PFhdl5o
	 IU5DsW0Iue1ogfBJMWNmO1yZ+8c+FaDnUtWq1Wz7hzo9p83wS3PBDaJOLcE0Iyey3ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Content-Transfer-Encoding:From:Mime-Version:Subject:Date:
	 Message-Id:References:Cc:In-Reply-To:To:X-Mailer;
	bh=fvNFVERz7t2+FGoMC5GdMPQeOCuWIBAx0J7PIzdfCPg=;
	b=SAcIMwN+nttL52ezpf9kIlN3yF1zzHgWB9+qW2ln5HzH9XDwo5x0Yde0DsTb5izQrr6E
	 fuAQuTmtu4UbCeA7A8FojiDqP80boC99XRRjoQnvIxsASZ4fbjQ6/Gtyu5QxIok6TwExB
	 I5r9BiRcUyzSYUwhvXfQQNOt+8szBg9VZJY5SD7GmBQ6lbSBCWdfgTpCsdU9cMsFFEGYv
	 sNXZSveTaICHY+eBDekIYBovPwdFqAHPRg1HO3yPazTt+G1KK+EvH3zqZpFH3Bm+wa8H+
	 7WSy7GbTIecCeH1Eyc4gKzPQdEYNe8TaUBdP5RSQ9EciiQ4TtYrGdNQeIMBorGZ3EKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovVebp8T;
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2446074A50
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0A2446074A50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ovVebp8T
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-679a2297c55so1404632d50.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 10:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815225; x=1794420025; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvNFVERz7t2+FGoMC5GdMPQeOCuWIBAx0J7PIzdfCPg=;
        b=ovVebp8TwkYlxTXe5mYojLQ05y6I/42S9rHSHh3IS6UrzMCCIiz5LVLi8OeeDqw8AM
         PKI2/Da+VnFHNSb2X53dHSbM69wnrZ9EQMsShyhtENkZ9RtZMNE6foOotQ4n8c5DQB8Z
         z+6NrpdwLG0OcDQhKqA22bfRV0yP5AJITPp5Nb/21mf1wMfLLgzFuYILUaGvGsx0ZfTs
         vFBFfHyR5gUVZE9dwgB6flJFOu4+UiItssrtY35VEEJQScm5TKMgyPxMbZA7UCQ2HqjI
         G4wsxuLaSjzrxZS+IVgMxi4DMXQ63KlUlNqmzi9alQM24ern1h4w/Mz78e7x7LJDI4tN
         qyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815225; x=1794420025;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvNFVERz7t2+FGoMC5GdMPQeOCuWIBAx0J7PIzdfCPg=;
        b=f7qH1ZMnj03CZSxdEJaPw+Nr+BQQPaxHedTBBn5qHUoCgGBeyPfJy8ZBGU2sntr+en
         6PusVICdR6seprbpEUA9Ln+Lbutio2FYbKm0+896ZHh3Azjwa9wRdQ8qLdkfTDI5hZuh
         1SwdkW34D1BZ0x3oei81XEV50K2S0ru9vpxyskcm/terTWc0kpf1NZcYZkOHu6SDcyih
         gUT5/6/Fz6bREt8HRALUuqKigClp7fB49ffDxoxE8KC2MSSTsypsHdZo0NXnAFwgq6XL
         ecCjQIgZIv6ojk76vHWQvXZ4UOUlgF25T7HuN4oPlwS4C+qwvG45Xje0mTy/lwdaWIuY
         cuHg==
X-Forwarded-Encrypted: i=1; AKwUvBwfGQ2gpUBVD2CXPD++vRv+fvL50DRAIheiL6CWzX3DWvQOtFrQEtMZDyEo+n8F2SIrOWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/VaFoVy0Ve3xq35rOY3unWmWINFzK9pv/4l19OTimr8R2LebCF
	/p919vbOUs7fXKStkB2alj67jvDyTC8SEIHjJ8FiC74obQ3qgisPz4KmMOY1tA==
X-Gm-Gg: AYBFou1neswIaQWEyWV5aqvrvbsocQ6QJRfNe0Y6vBtwNYtNLi0sGhQjBhegYNX1qtU
	lXhwv5H5UCSf98u4I7jhOO8YZNGsmRyTJLbHoidFobb/kqG72qokc7bxKA8GUJo3zfKp2PcE6jP
	Lv8sbhMV3fLy1F9+SKDOJyOMmhOIzH0GiL2tEK7X/mq9oQvRth/HLIhU8q8JF0RxNPn555ajDPv
	6z7SYV+lC0PnPWoL72v44uqnAt/VbCC6337Q1fsbAO1y2ksxODVg2jjNwDLfHTZREIE6aZqBFkC
	ay91QfIH/m8cgQA0TlAYaFckQPxRaz1GvrL2iFEGGanWMc2eK9tA+milDluO9mTVBQhjeH5yP/U
	5ABdagZ69fjwevQZ7FR3KRZa6qOkZrXAa9KkpMwTdIlc8H2r317qSlxeCfJHjsPv9uu54zQwc1R
	C5XZGaaxNBP4TzNBLdNaA2XDqn17yGsDdcYdlAUQQBIAzotaqpR9/LwvfowjxoKFJ4LxTdWY6an
	466pYALoxkHQS99fl4p1AkzaDhR1D7JOVL4fbB6QQ/FGk7BcvLBUc3C3jM3w18BoVVO4yKaYGfA
	BTcHwLjNkcBJWPsLvuV0KnJydlqyqzBt0vLbSxuUiKxroRMoQysPNMh4khhpD56MRtcPvRFQFu/
	CQLyHgO1AwkWI0RfC030fv2aJnqi8QIy0VSWI7dnprPM1XovVhI2rlxdjny/cT7nhs45a0IBVZ1
	+CnQ==
X-Received: by 2002:a05:690e:4410:b0:675:6f9d:dd5c with SMTP id 956f58d0204a3-67ba5074c9fmr9226615d50.73.1793815224648;
        Wed, 04 Nov 2026 10:00:24 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:9d46:600:c5d0:c9f2:df6f:9145])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67bee273e69sm1947952d50.14.2026.11.04.10.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:00:24 -0800 (PST)
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
Date: Wed, 4 Nov 2026 13:00:13 -0500
Message-Id: <2D59CFA3-B1A6-49E3-A930-C3057D97D507@gmail.com>
References: <62095245-8121-4698-b1aa-ff239286d9e9@app.fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Matt Hunter <m@lfurio.us>,
 Harald Nordgren <haraldnordgren@gmail.com>, git@vger.kernel.org,
 GGG <gitgitgadget@gmail.com>
In-Reply-To: <62095245-8121-4698-b1aa-ff239286d9e9@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 4 nov. 2026 =C3=A0 06:27, Kristoffer Haugsbakk <kristofferhaugsbakk@fas=
tmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Tue, Nov 3, 2026, at 02:10, Ben Knoble wrote:
>>>> Le 2 nov. 2026 =C3=A0 19:16, Junio C Hamano <gitster@pobox.com> a =C3=A9=
crit :
>>>=20
>>> =EF=BB=BF"Matt Hunter" <m@lfurio.us> writes:
>>>=20
>>>> Wouldn't invoking as
>>>>=20
>>>>   git range-diff origin/master
>>>>       pr-git-2401/HaraldNordgren/range-diff-matched-only-v3
>>>>       range-diff-matched-only
>>>>=20
>>>> address this case?
>>>=20
>>> Three-rev form where <base> and two evolutions <rev1> and <rev2> are
>>> given, and <base>..<rev1> and <base>..<rev2> are compared?
>>>=20
>>> I thought Harald's case was to take the patches from the previous
>>> round of the topic and rebase them on top of a different base (e.g.,
>>> updated origin/master), so there is no suitable single <base> for
>>> the three-rev form, but I may have misunderstood his example.
>>=20
>> I think origin..old-topic and origin..new-topic
>> would both select only the =E2=80=9Ctopic=E2=80=9D commits as long as bot=
h
>> bases are reachable from origin (which seems to be the
>> described case, to me).
>>=20
>> I agree with Matt that better selection of inputs to range-diff
>> makes this specific case better :)
>=20
> I use the
>=20
>     base..old base..new
>=20
> Form as well.[1] Then it indeed does not matter if you have rebased or
> not, as far as unrelated commits are concerned. You won=E2=80=99t get unre=
lated
> commits.
>=20
> =E2=80=A0 1: The repetition seems a bit inevitable and annoying, but I use=
 a
>     script for assembling all of the options to git-format-patch(1).

What repetition?=20

    git range-diff base old new

;)=
