Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD9130DEDC
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 07:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773993367; cv=none; b=KUmU5BgB0fzuS79+ryxdwsjrUucFIVBUZmAyRpv9LiphLoNsyACsRjeWQ3/18H4Wp03O+mySBAfeJrJce+Oq4O8/OGoUhnxo6Gzn3FXwYRutxcmz4sDJV+uY4rp/Yv8G1eRLIAxCE9GpuTTimIaR+6QfvThMTZDQAVc7bFYwfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773993367; c=relaxed/simple;
	bh=WL7HV0416AZUnDRldOv6IpKp8FNF28pwUvddR4nQKc4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=rHbQJxpF/5zSkTWiloSr43JzlWVIbsrLk7Ide6t6AoCuXRChqh8P5wLpvlNXnYMEtb+L24EqQpnwIXqowmV9v1++6bTKAN6LuoElVF7LxB0mLywXe9Yck0PK3N7VU7lyd+wS2SNRWi9No9Chal76z2cyKMZ5oGJNGoRoEhL4TsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=uPw8j9nj; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="uPw8j9nj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1773993356; x=1774598156;
	i=johannes.schindelin@gmx.de;
	bh=XuJxuLn02uyl8ZxBMMTa0VvngGOtdDrqpEcQXZiHS1c=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=uPw8j9nj71CTOctYE3NvassaFhH1sV9oyf/eNkzK/b6Y6He3qZ6Rq3om55rdREJ1
	 PPNL50tNY7THDCjGDm1zZPKUMQP0HwiEBV1VQz4GFV1CONCqX0zETPC0+xRL+EAkh
	 E8HK0ubVfIKUMFuiGXxIDcZCaSvZRIVXCA1SmsfpdEanM4Do0mn+9s3f2d5UUItfA
	 V5d1Mtrc/t1TDTmcJyOpOxifKVfYopILQkpYXIngdGdv7D4rtM/j/G8VhTWY/vDUb
	 XrnMWHgRK+VcnRkqbQw1VXASmbmWNI4wbTxoakO3tHbe83kbObJn6v+OQ9HKsuxeL
	 96A7kUN+6q+YIV8/Zg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsnP-1wHzBh2wpR-00Tcze; Fri, 20
 Mar 2026 08:55:56 +0100
Date: Fri, 20 Mar 2026 08:55:54 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: git@vger.kernel.org, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH] regex: not all macOS platforms seem to have
 REG_ENHANCED
In-Reply-To: <xmqq8qbnigxp.fsf@gitster.g>
Message-ID: <6636e7d2-7a1d-0108-2e62-af27a3ae3cf3@gmx.de>
References: <xmqq8qbnigxp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tc8Jq5oKSmCxm3xz7hHnHGlY5Bxud6+FGGi96qp8Ilr+RkZAKow
 jC1a2IfpkLg5Psv6DagQX5e1zeuviTfFsFDblrSW71JgLd1a4D6xtdP3JAPJueKigfXGGZh
 2+E8EBncELBr/CZmaBru5fRWkPkkg12kVTwsKHfraxz+0ENTJrUhnNqdTMmAMImljVlRpDk
 ZNcdMC/UBD23A4pWtLfjA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TtJ3NGQp6wI=;e6AyvMZnB0z+oV5IJUGEjaxEO56
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Fri, 20 Mar 2026, Junio C Hamano wrote:

> Earlier, 54463d32 (use enhanced basic regular expressions on macOS,
> 2023-01-08) started to use the REG_ENHANCED option when ERE is not
> in use on macOS.  The build seems to have started failing on
> macos-14 CI jobs at GitHub, however, as apparently not all the macOS
> platforms have this flag defined.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  compat/regcomp_enhanced.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/compat/regcomp_enhanced.c b/compat/regcomp_enhanced.c
> index 84193ce53b..51e1358170 100644
> --- a/compat/regcomp_enhanced.c
> +++ b/compat/regcomp_enhanced.c
> @@ -3,7 +3,9 @@
> =20
>  int git_regcomp(regex_t *preg, const char *pattern, int cflags)
>  {
> +#ifdef REG_ENHANCED
>  	if (!(cflags & REG_EXTENDED))
>  		cflags |=3D REG_ENHANCED;
> +#endif

While this lets the build pass, it _does_ change behavior. Where
previously, EREs were enforced, now BREs are silently enforced.

So it might be desirable to instead imitate what `meson.build` does,
namely define `USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS` on macOS when
compiling with `clang`.

But that should already be the case:
https://gitlab.com/git-scm/git/-/blob/v2.53.0/config.mak.uname#L151

> ifeq ($(uname_S),Darwin)
> [...]
> 	USE_ENHANCED_BASIC_REGULAR_EXPRESSIONS =3D YesPlease

So: hmm.

Ciao,
Johannes

>  	return regcomp(preg, pattern, cflags);
>  }
> --=20
> 2.53.0-816-g44373249a2
>=20
>=20
>=20
