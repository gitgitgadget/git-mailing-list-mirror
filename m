Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794951787;
	b=0iukxNHR1vkncH17E7Qpr7Ddla08p1YmQIumvTqK4ZX6J4nwcuUAjWUq7T5qMVSh0+Li
	 xvRgsYdoAWeFtFiyRETyP/fwTwWhP8N6hwgbTxBbSn9yhY/KewC79aGHiGZ1kvJrHuV4t
	 GIfbJgOpHWAkZUXp/5g8bwlQ+EOrrtN+wK6g5NcuLH82e0wkkFcASjGRalNxw0Ly5lKoa
	 cSnOQUmlIOiEmEXGJnu8rHPjB2QwjfGyfGR7wKdV/EJgBg67ka1+iRgKv8KoQbKVYMEax
	 9f/NDI6EjwO3L4j0f0HdJhocFVWiObRkd6D+7oVTo0bxgHwmHIhBfeSICNEu/L9cVng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794951787;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vlnkdvhMTvYS4kEcOaLZ+rzH//+CD/+20Lg8WkXV0hw=;
	b=P1v61VNc56f0OPMXRwvU8HUTp1+fplv1KdFToW/mpeAqN/mky5b801RQMFnjXfygjDai
	 X1NZG3uTuANj5R3H0mTXcEifXmyCpIILNA2yve0/aBPZwfVaSPE0F326fU71sv6Py6AvB
	 fSGrO4CyrmhO1MLUeU0Ue1ldqmuL23wafPIF6LhY/35SMz7I+gEYuVCX+IBCzc+Qj2yMo
	 nB3J8pyJjbP5N+A7qNMFu4GHOf4jjKMm4V0WDVHAeZgq4D/nmGwB52C8l5WxffwFoykMh
	 EnGs3t8qQtSbiw0JJEIHwmi6SZ3n8UzCmy1JuxEjWrAshZ9gTtth0nH9PmiTiobcVbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="SkqZ/3CS";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FKs7JtHN;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C53F606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 21:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C53F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SkqZ/3CS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=FKs7JtHN
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id EA7571D00100
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 16:43:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Tue, 17 Nov 2026 16:43:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794951785; x=1795038185; bh=vlnkdvhMTv
	YS4kEcOaLZ+rzH//+CD/+20Lg8WkXV0hw=; b=SkqZ/3CSnqGBZM5Za9bLlcv+nt
	VE52xbw9/pLXmcjMjihkkoUksm0GOW9sIdXmCjElV4MZ5Fn4OWcWLgFgQPRRYSli
	JSbR/EgSS3/PnEvsLjD+wqQwmZonFl6EXkV4/YCNjiidbwivOfK1+y7IrHyCvA+P
	EnBpmwfxNhDeWqOnC+m4A6nIovXahFC4c1fppo/tjHaVDpkDio4yVkSwautS6wl6
	ojHys5q+k9mcl17h0u+DAV6X9SX8KGGHoE7xDmwKXVGbKndhDYqXRuNzPCK3E22i
	TAIOOkfdUqtxBM5qOprkDP+7Sq2oSqzYNYv3wWSLARsXgbrN1GDTNp7jpSJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794951785; x=1795038185; bh=vlnkdvhMTvYS4kEcOaLZ+rzH//+CD/+20Lg
	8WkXV0hw=; b=FKs7JtHNwEJidjwAMl+ISQbUVg6yZahI/KSVj5poIzwVBsMftQB
	gx89J2em46fZV0jfLYqc6caTjjTxWWkaj3vK32F/bZKDS1HUgOnol3feW46n/rV8
	9GPRkKyPqeN39G5oATwLzyIs2nvq/Ev0Q+XQ5Qc23LcHSkzbon+56NsRnK8fTDsk
	v6K1Bqu4y30bSsV4+apPEKh0ulW//KIgut/U1EHF3aVcbh8Q9nmd6L1oOmP6c5n8
	oaXFNsfzqR4JYk4VZIGIeTlxJUzQtnON5sv0rWZokidWE7V2ZcRnnYkBlCyxLf+S
	PTBL+cM7kRprW9mzpsRrv/JniS/bevqPW5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794951785; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:B9pj6ctUooNMagUVfohIUoG6dhSi8T5A/ncAEsREWgl+dUV
	gAQA/UaP0+kGGi6EitaGM57HbtFWxDN22qOvtClUFFzG1qE+azTV96pr9rbgmn4X
	9BwvB6+OQMV0IXWc22j3vmQ4KietplZsDx67k/REf98UQqamQ8f86UuCmbdijgeu
	XiBORFb4t0weFzu7AgaFcUeOyIWFSfpLIy2KvZy+kTs3h/ADIbaFCBU6U3346ouq
	BkZ9frNu4NF9SWx9TF3DfkccitfElKG/4LwkwsU1vYSbId6cz+lEz2mHe2yaz3Tf
	hLpoktwxMQcP3bTmFrYRbN7u3vuMAHs0nn9nQ5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:SL9sK1PG+bh0J8xGPbF5Lirlv3dVeTr/hSn1FP0pNWE=:bM7ltKTuJzva18svv0E3VW0xfg1NRhDFFMM2QhCoX54=;
X-ME-Sender: <xms:acr8apYCpfdM_61VHLJGsAJNZ_TScE5OamM1W8zrIDc6N9Vw6FeOzw>
    <xme:acr8an3VrtkVwiS9M6aoeDX-5lWDTrOQqGM2hk5VsPEQRHltOKdPrtDGJhUIRHB9W
    Gl8TH60Hsx1WhQlDh7Fnjz3YVQPQSFXOMZWbNjGhLv4Z6X6snlUOE0>
X-ME-Received: <xmr:acr8apU8-SyvNYl0attpLZqi_ChOkH60FEtDS0UXU3LWR0GtgMXJEM_6wzX9JWO2BdNRboz6QCZtDk2jvRXpuQJI5fYwnl4sDhH9>
X-ME-Proxy-Cause: dmFkZTGHXl7Omy8my97x8edvQ7Yn1PtEQsdikw5LnujCwA0/qt7ffhFJ2kCykG291rTVbY
    +SAx/Vj4jnZC9oOOJOkJ8vF45Nvj1em75V164XvMkPsVQtaOEOcl/VNTK4V6sKX4I0z5KL
    se2WHWfZd5nHH2YNO8WCujW1vTsotRaJaQf0/2YkSbNno3xZrd6kIG9qk28wvRJFnati+f
    PuGkhVcvZvVDwlOSqzzks3m84NMG0ypNh/eNONra+Tnq0y6Z+Mc1Pyx+Ad17APmmXLWsHY
    5I+wTNSFLhO6MIfCzs3auj9A25xUsaPunsrHGFZMhLLz1NVZYpFTCbhZidlHvmXRJ9DXEK
    om2y+vEi92Lfg1/tAFuIQKXNPCSj8vKUqLPLzXieuP7FsUBkhoTHQBG2ZRL1cJTEwLzbzi
    LQ0FosIVo8DyjhKKBYlCosBe022Hb/yzh1lxUrlVL0NUOT5E1uPyA+/M6r4eftqhkN2lgc
    0A8L8sGYaHmDGdqS5ta7oKy7CrJoXPVr63ZPWzz20qyDramTFW9icJbkFwfKt8iYRqU/T6
    rcKmnovOnNL9nuuv+U5Lljn6Y/+TEnyFk9nQitKhbxIvL4LUKsl4nnvK26mR1z3UZ7Q9i5
    utt8gOGx0Mg5HVdF3iyIjIKUAZPRbku0p1Q+9Z/TuV5asfXHZEDx/MmYpopg
X-ME-Proxy: <xmx:acr8ahUtswrangccwlksQpf3U9ON4puvH6QZK08H0p_Fc85FVEWFBQ>
    <xmx:acr8aoeLiLgXUKVJ4VFaFGRfY-0o4rn7il973jtJN6lJEVi8FV2aaA>
    <xmx:acr8aqUzhPxfBXXHYhTRqUxe_ZeNI_Yl7_16Z6rOnzbvl-6Uq8t1Ew>
    <xmx:acr8ahdFn2rJNrCVZPC3eBmMsDXKiW_kVIS33EDVoyS53138PG5O3g>
    <xmx:acr8akfNc3Q4tHroCsHwGj89bDIe8UVntbSu8ESJeBgpYaENhvAApQCS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 16:43:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <ghy0arkv39.fsf@gouders.net> (Dirk Gouders's message of "Tue, 17
	Nov 2026 22:26:50 +0100")
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
	<ghy0arkv39.fsf@gouders.net>
Date: Tue, 17 Nov 2026 13:43:03 -0800
Message-ID: <xmqqbj7ncexk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Dirk Gouders <dirk@gouders.net> writes:

> You have better knowledge of the users of this function: would an early
> return perhaps handle a significant amount of cases?
>
>         /* The shortest SGR sequence is "\033[m". */
>         if (len < 3)
>                 return 0;

Do you have any benchmarks?  I don't.

I find it of dubious performance merit to run this comparison for a
long string as it is eaten one UTF-8 characters at a time by the
caller, and when the length is actually shorter than 3, then
runnning the remainder of the function for a few steps should not be
10x more expensive than the above comparison, no?

> And, why not add some tests (the untested function I showed had
> an off-by-one error):

Sounds good.  Should I just steal what you sent out?

> diff --git a/Makefile b/Makefile
> index 4c84eea6e2..3c8dc9ca40 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1564,6 +1564,7 @@ CLAR_TEST_SUITES += u-strvec
>  CLAR_TEST_SUITES += u-trailer
>  CLAR_TEST_SUITES += u-urlmatch-normalization
>  CLAR_TEST_SUITES += u-utf8-width
> +CLAR_TEST_SUITES += u-utf8-ansi
>  CLAR_TEST_PROG = $(UNIT_TEST_BIN)/unit-tests$(X)
>  CLAR_TEST_OBJS = $(patsubst %,$(UNIT_TEST_DIR)/%.o,$(CLAR_TEST_SUITES))
>  CLAR_TEST_OBJS += $(UNIT_TEST_DIR)/clar/clar.o
> diff --git a/t/meson.build b/t/meson.build
> index 1cf1d95f70..e224df58c8 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -27,6 +27,7 @@ clar_test_suites = [
>    'unit-tests/u-trailer.c',
>    'unit-tests/u-urlmatch-normalization.c',
>    'unit-tests/u-utf8-width.c',
> +  'unit-tests/u-utf8-ansi.c',
>  ]
>  
>  clar_sources = [
> diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
> new file mode 100644
> index 0000000000..c19d8bce78
> --- /dev/null
> +++ b/t/unit-tests/u-utf8-ansi.c
> @@ -0,0 +1,14 @@
> +#include "unit-test.h"
> +#include "utf8.h"
> +#include "strbuf.h"
> +
> +/*
> + * Test len limited functions for ANSI SGR lengths.
> + */
> +void test_utf8_ansi__sgr_len(void)
> +{
> +	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033[m", 2));
> +	cl_assert_equal_i(3, display_mode_esc_sequence_len_counted("\033[m", 3));
> +	cl_assert_equal_i(5, display_mode_esc_sequence_len_counted("\033[31m", 5));
> +	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[0;31m", 7));
> +}

Thanks.
