Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794771002;
	b=XHv6W6LtKwALRbMNVfn9d9pYR4eGmkRanSCCcuR0ADWIDixUdnawGMM+kg/LKzpYMxIL
	 cr3bSwUIq5KnHIXhbPIk1qNyVlDj1DmfRjqoCoOGZfAzpahlMkFXL09BqgqpR0lT1gAY2
	 CQ1tCxEpTCtTpKhypEjrOVcsCKUYsah5hg9nkYiW/j1/24PJkl5d32QASHUbatRiXUbOe
	 nP9uqMyKdX1UPlRkZVQJDTMCDR6NGeHxsQmgkyei6kIxKKfOO9HPp0NtYkdvtktUnC7gr
	 nhWh3eG/VQ/qfC9/uL3gEI1ZFf51S6uripWJCY2qa6zvumqexkf+ioviHVDiAbwezYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794771002;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport:Content-Transfer-Encoding;
	bh=pIOO/3gKOAZ59NvxL+RW7lJfroRszoxkbLUKt4bqPhE=;
	b=4UXcAGU31pSuYZbeIdSUYwDEpsWW21M3F6OPccJLRIXkF1RasOEHu74SEXy2AGN2malL
	 zJsngti+NGfT0dCY5Mk+MtcIzfTrs5QwSYFBJtmi0Bgqi4xmoBNCndYtKxgl100mcCvDr
	 uaLDOF0CuSxNOW5Z9P26Xl7Uqr6qZHldwmTyuyf2lHZoBSiVX26QTa9JX87bioLlHmV0J
	 H5eGbYiZ1FrSq9DcqR904IkPuvWEAtyqQ+7Z/a7/u1M/IQXXwwlNTC7eth0noyfF/uqhF
	 kslf7JiHLhYBi2dHw/B4JCVENRZRYVW5Mk0WusxuFeZvtMSgrtChomswpACSTzuXhng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gRWhkAIw;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D043606A339
	for <git@vger.kernel.org>; Sun, 15 Nov 2026 19:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D043606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gRWhkAIw
DKIM2-Signature:  i=1; m=1; t=1794770999;
 mf=PEpvaGFubmVzLlNjaGluZGVsaW5AZ214LmRlPg==;
 rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:B9x9gAcZJovLq8Xg3KGYa4rvbPwK
   0NfFHIHmwRYwjyvD4KeF5/KpjaMv+Q4FL1HW7donU8t1IvV22VuBN8AbppPC+xpsALByDJvVj/E
   Ee5EwL74HKTY2V7WPL52ILqnckIsvOLQ3hKKTxO1DbZQQqpFmpu4iDA21yxaH1FfIyT2odyB394
   E85ADb99z74g7HsYN7sjkNWMDBxNSvgZMSyXXrCTVpeZXv1ufbOgp7Ukj1PyskNll7MiDBIhVux
   uaT6MG+n2wQr8i9KKoaXy9WBZ2CZ0sbXLy8lqePEMHLEVUugRUw5WiNxuDLnfTUiRSGRWyHcjTO
   ybklqf5wJZ4+aA==;
Message-Instance:  m=1;
 h=sha256:
   ZwsT7t30n64s9zdbqv5btJZC/G8TjjXakU1yiWoxZoI=:
   IVxo1vn7QRbchbS1MIFF5UH8R3LT7uT4SGUh1//tbb8=,
  sha512:
   BgdfYEDSZD2cLpRyWLZFj08PAtrPGIj/jz/Qk772+HKWELv4aWY7BXJCs9Ly/wiV3JCjHdaNT5wTJ8uPHmqGmg==:
   XPzpONIKhKoZyleg3YFWvxwZe4hD3wRuSy/c0gb+DpT3r9+N/CXasrIG3RdrqxfNuiFWjSV2wPJxX9id/f9jgQ==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1794770998; x=1795375798;
	i=johannes.schindelin@gmx.de;
	bh=pIOO/3gKOAZ59NvxL+RW7lJfroRszoxkbLUKt4bqPhE=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gRWhkAIwKS4iAC6QIr9cjOI9E1qN7MIkihexUL1kblMl1zHTpc8SQcBEOuAkHXaw
	 1Y3HZ9thMjwkNycemBxuTq+Qz1pLpVrGzMQdbPmy7Pn1QD/NQSU379avq9qHx6tRt
	 q4DsZxKxhrV6vQiHQIlD0JLqIVZkvPZQa2iK7fWSlrY92nYtCR+yroP9b9FiK/mCm
	 T/6J1OZOV8uxSv+RrgS+frYY29SFiSntetcQKnpoRWUAxwVbJ5SKeAkLRsbkgHglW
	 ri3gFX4j7tKvqsNvdxM2jDPzXu9REeNFP9iNG2FRRL/jOlAzQyMJzvSU7hLrb4M4M
	 JCqhRG1u7cHyWK2v3A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH5a-1wsVlC2xye-00flEU; Sun, 15
 Nov 2026 20:29:58 +0100
Date: Sun, 15 Nov 2026 20:29:57 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood123@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH 4/5] git-compat-util: add `signed_mult_overflows` and
 `mult_overflows` macros
In-Reply-To: <373f7186-3da6-4715-a4ce-cd5f56895176@gmail.com>
Message-ID: <c84cca33-2267-72de-1e7d-3251d35239ce@gmx.de>
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com> <3dcc3d97570ea7f96628d02941d7424f84f7bf39.1791958171.git.gitgitgadget@gmail.com> <373f7186-3da6-4715-a4ce-cd5f56895176@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:eAezQj5Schhv1A63rBkgtmZM0SzfaRyYFCeH/GWg2rGHsWsPHWP
 usb5ogpu5SgrtjrWktrgIkIT0JHlLPdKhEtUh34GNUbJQo0nlKLMfeZNXt/yoOf3lX/tpja
 cryiz8RK9cft3mOiJ2xAawBMD0dGyLUvcgDR5YRAFDumanzTAJLaWt4G3bLE2JUqb5+/ji7
 PXy23ilLAFGaIZ8ehlEjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iJawKfBLVyk=;Nb2tTZY6m/1lHsOQlheAvMkYtAc
 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
 x3DK08tIQ87y/InY7KqYl1itlzJQ==
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, 15 Oct 2026, Phillip Wood wrote:

> On 14/10/2026 07:09, Johannes Schindelin via GitGitGadget wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >=20
> > `unsigned_mult_overflows()` does not cover signed arithmetic, but type=
s
> > such as `time_t` can be signed or unsigned. Add signed and type-generi=
c
> > guards so callers can check multiplication overflow in either case.
>=20
> It would have been nice to mention that the type-generic macro is gcc on=
ly so
> we cannot rely on this for safety checks.

True. And that is really not satifying at all.

> >   #define maximum_signed_value_of_type(a) \
> >       (INTMAX_MAX >> (bitsizeof(intmax_t) - bitsizeof(a)))
> >   +/* Account for the extra negative value on two's-complement targets=
. */
> > +#define minimum_signed_value_of_type(a) \
> > +    (-maximum_signed_value_of_type(a) - (INTMAX_MIN < -INTMAX_MAX))
>=20
> Do we support any platforms that do not use two's complement arithmetic?=
 C23
> makes it mandatory so presumably there are not may contemporary platform=
s out
> there that do not use it.

Honestly, I had not even thought about that. I just assumed that it was
the C standard, not something C23 introduced. Sorry about that.

> > +/*
> > + * Returns true if the multiplication of "a" and "b" will
> > + * overflow or underflow a signed type. The types of "a" and "b"
> > + * must match and must be signed. Note that this macro evaluates
> > + * both "a" and "b" twice!
>=20
> At least twice I think
>=20
> > + */
> > +#define signed_mult_overflows(a, b) \
>=20
> As the macro relies on both operands being the same width, can we use
> BUILD_ASSERT_OR_ZERO() to ensure sizeof(a) =3D=3D sizeof(b) here?
>=20
> > +    (((a) > 0 && (b) > 0 && (a) > maximum_signed_value_of_type(a) / (=
b)) ||
> > \
> > +     ((a) < 0 && (b) < 0 && (a) < maximum_signed_value_of_type(a) / (=
b)) ||
> > \
> > +     ((a) > 0 && (b) < 0 && (b) < minimum_signed_value_of_type(a) / (=
a)) ||
> > \
> > +     ((a) < 0 && (b) > 0 && (a) < minimum_signed_value_of_type(b) / (=
b)))

Thank you for reviewing to thoroughly, and essentially proving that this
is a doomed approach.

I dropped these macros from v2.

Ciao,
Johannes

>=20
> Thanks
>=20
> Phillip
>=20
> > +
> > +/*
> > + * Returns true if the product of "a" and "b", after the usual arithm=
etic
> > + * conversions, cannot be represented in the multiplication expressio=
n's
> > + * type. The operands must be integers and may be evaluated more than=
 once.
> > + */
> > +#if GIT_GNUC_PREREQ(3, 1)
> > +#define mult_overflows(a, b) \
> > +    (is_unsigned_type((a) * (b)) \
> > +     ? unsigned_mult_overflows((__typeof__((a) * (b)))(a), \
> > +			       (__typeof__((a) * (b)))(b)) \
> > +     : signed_mult_overflows((__typeof__((a) * (b)))(a), \
> > +			     (__typeof__((a) * (b)))(b)))
> > +#else
> > +/*
> > + * This implementation needs GNU `typeof` to convert both operands to=
 the
> > + * multiplication's type. Skip the check without that extension.
> > + */
> > +#define mult_overflows(a, b) 0
> > +#endif
> > +
> >   /*
> >    * Returns true if the left shift of "a" by "shift" bits will
> >    * overflow. The type of "a" must be unsigned.
>=20
>=20
