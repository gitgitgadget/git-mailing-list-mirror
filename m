Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453446;
	b=hGv2sPvjV0ZV12eId9sCm0k7GHajBibAkFEuoypYglQrCLMAsWNxwsxMiowN1OimM/qh
	 2Va2D59gB8CaRNTmrDPPm+4x19wZC4fKlQtI3aWlvSzhHnjsnCiyKwtTGKmZtn12eiMIT
	 y65lyL0QC67VmqInV2u5rLwKQGqzrOncYGohfGQQITS6eWuCtax2BIKKehzQ1VO61OLZM
	 3E+15Ckx1LfhdVLie9ef7IxNzPdwL7QFw+jzhszYpkXn1cFia2sXyjT5+iL3mmaln/s8d
	 EkuOXOBgywuf8PaT6ZVINpKzBG0co8s9T7bqPIDMejn7RTKmhNTHq8g4JYVb5klIsnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XmdsJeyE4rpRVHsdnDc9OVQ5GpFBlKpU18EbKn8kat4=;
	b=r4182W7guE7ijse29Sk7jJUfkfoqUrqzfAd614s1DGhW7sd32nBqb2SlTcR6k7blIf70
	 12NnJpxy80ZQBIEP5Tx3Fae65YBbBgUKPpVWGDq6xJs5Dxeq0qyvB71nE0ovQAV4qzzCr
	 qiLAroQy8zvcN7+V8R2myQxCXADq0yectKnTgeWm6Dda8zIZwVQluhz3R2k6zwi1fIM+t
	 euI83b7sm6EauYGgwCxFwfek/RkxfxHeFnFKCqdJnwAsnk2ApeblyUJlB0VgTG/klNh8b
	 mE8El5vLUWNQUdmz1dqV+AOc+JjV2u9u6mjKflxh0SfVPgW2N+mPuuH4so1iHNYuVhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ny28lU2f;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qfoxLSPm;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED30606A31A
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 17:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DED30606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ny28lU2f;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=qfoxLSPm
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0E0F71400389
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 12:04:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 23 Nov 2026 12:04:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795453445;
	 x=1795539845; bh=XmdsJeyE4rpRVHsdnDc9OVQ5GpFBlKpU18EbKn8kat4=; b=
	ny28lU2fZjWUb6SQdfJspL03vK3xMh7muJuVAwLPas0WIpAb96GFY6OFwAUr0a5u
	8zmsesDecrGNbBiBARzYdaUztdhrUOQAM7izhO0cjrcjZ9qQHXt7A0w+sxp5PZEs
	8KCLv0lsc1lmCxius5D/uks5BALwfKvFR2EH1KlftWaKAseJ3nXSnz1GubldoJsk
	wqCPPklzSiFbXNqlmTiVf3r1AELa9OTpbK3vKxQJGjKOmnjUH66OUHFBXns1aV+L
	po/vhxCoxVfjhj51cvZ5vxQ4rkuYwo1MIeA2cgnpQcmsvw+eBAVxidB0Igo3CAD+
	QbOKVZRVP74vZQvDuOb8sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795453445; x=
	1795539845; bh=XmdsJeyE4rpRVHsdnDc9OVQ5GpFBlKpU18EbKn8kat4=; b=q
	foxLSPmh/hn3x4aoVaVrp6Og0h9QWUXCkjtFYEIyjSX6QU1b1nwslaaCB2M4w/UG
	VImP6iFND5i+Ncds8oJiwZEeE2vqaPM3ew7Kp2aA+uaFNnXSHHzhHucLTvqf2GGU
	DlfC3Mu/gXWHGe2XWW6Y12TBtt/L5Mhuu/EPS0BCV+qGnjZQBcEK9m+iKVOZKLwV
	L1Rnl2J1MbfXoJNUX+TSMHnLkmfwfa618+3HzyGpQXAbW6s+9qnlPiUvXsl1k0jQ
	kIfC2IkaGnegTUJL4wAS9QJu43vbx6bfARemGsiWizxtRHG1M7mDFIuT01ufiRau
	jw78z1gZVsFglr7VjJuqw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795453445; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:l6706rNRwMtNf0D8BhY47fT7u1yIbiTUvXoV7Ny6oQit4KP
	ykx2HnYhwKKyUVG8I06QOU1BW/G5bnW/ah45/BUj0r4OCspDn5mkVXtsERYyWrhC
	ALpjdspHvE1zCzg5Nsa3WsC4V+rK/eJXN3+2d/lVtSu1qfOpyfbdDGP6t2rQO01W
	PT7O9zjZDP19mN55mmIc3QkliLYMstqW9TSBt+TSINkc6TinLtY/apZUvnkteVTS
	PqwAnDmSVNdv4VRQW29FgwE1BYuSnWTvvQtApY6/D86GvFDac2yZOUox8/3gyyUA
	FFOkSGiydEC5/jiT6B/rVFBLSgO9/XPMqoVQtwg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:RlQy6AMYSYHeCPZdDhkSXdtWgxRVhvYrPv2ZsSzEwJE=:uVQcpFTlo1FErLLrW8lmCgccTaJRE5l72TrdmL12dJ8=;
X-ME-Sender: <xms:BHIEaxcAkXeH8PsQ1PvQEMqM3-NEkp5g7cNy5LM_8kxbZtO1y7QGSg>
    <xme:BHIEa2N0NJngOZQWEfUvta4BivZ22XDTfBmSGo2ter40ug8YOOruvoUr2kwKK84CR
    IipeNt4bAudpmp7za0PdNFaYbp1A7lZw2BjHSQ46yMCS7vcL2loZyog>
X-ME-Received: <xmr:BHIEa_iNFO9opAVJITNTvaV66vAUzksoBgQfPtKahL5hd2frHD1kBgp3k5EEBznsnPoXVr8INErtMJ1HwlWOwpr9AXf4OK6wzYVmpf4>
X-ME-Proxy-Cause: dmFkZTGHIqCZpJw5xZZDL+7/Ps1gn65eD7YriaM0xCBRh3tzRjmPbuNF3cjaW494+JVwgM
    vxlsf4ubSwFK6+BTLY6Nsqkx/Y9uGkLTfybqxlO5WjjHT/rcY3jwyeA6vbMYXSl+hw6Kuz
    0fSiLdkfBQO74hxOEzIfUshp/vXFFKKekbbF1cyxc/TwkTfYgTUbswCj9JbKcLZuUIw4Zv
    7ylDuUZWhmuRcdOEnwpi+s6Wtwc3by3sPk24f2qN42tNT2WI5bqs7dBdvfRvJHKdmjsXq5
    5APz7ZRulsmULwzJXtpXqLuGzczNB0Q0+BmlRKXAlJ2xvyFPUPI1VLgMhnzX4p56yTwxrv
    3XT7FgXNm5YAVetlFDYLm4s3VbibfoBvhwgJl5xDI8qiyToyhS0R7ms2ZSZo8C4OW2zhHX
    F5btHnifgpnsO9sMmRr6U+LQMQ1Ka0On1a1sD1v1/q635RX2tzZHFfCaXm20JtFB1sB4uI
    rbT+WvpwEXo9jc13jhhT1pzlnlpVH31eciTZ1uJy7FhxsW1zQJ8TCaEUlEP0y+g3/Y5AOD
    b6JPbO0X6EkW/UPqMuZk85xMtbiyqsj0ynD3Ql9BI4IqnrTpdlTuOAFWlFqvRUBoKVrJp+
    gNiQoa7FtDajmaGZQJSrsVEcbT8Qnygz/cKasg9VPLwnrqbUQXuFwSB9ISmA
X-ME-Proxy: <xmx:BHIEa51QDQ3vtSIVvnt-GZtJild2lYP3nkkZ8aRcQ6dNhi3HZ9AGxw>
    <xmx:BHIEa5iWFak_d2-3EF_3fH_LaBFHqVFHUGDeGF1pPb1gJpRnGcANUQ>
    <xmx:BHIEa5f8M1acOdv0lFSdX3XUZ5MUGh3wVbP5N2oo6GKAoixf8z_qNw>
    <xmx:BHIEa8lJMb5cB0J-O9iv9PAb1wDy3nORWagvTiyRZtbfhsKyF1D4hA>
    <xmx:BXIEaziZz-qPRYTjKg1I0IrQMfbNJOhLTRCPJIOHFe-4xyM8NqGX_P7N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 12:04:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5 1/4] utf8: add display_mode_esc_sequence_len_counted()
In-Reply-To: <20261122-master-v5-1-313bd1bb3c45@gouders.net> (Dirk Gouders's
	message of "Sun, 22 Nov 2026 15:51:24 +0100")
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
	<20261122-master-v5-1-313bd1bb3c45@gouders.net>
Date: Mon, 23 Nov 2026 09:04:02 -0800
Message-ID: <xmqqa4mza399.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Dirk Gouders <dirk@gouders.net> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> display_mode_esc_sequence_len() scans for an ANSI display mode
> escape sequence (e.g. "ESC [ 1 ; 31 m") at the start of a string,
> relying on NUL termination to stop.  Some callers, however, work on
> a counted buffer: utf8_strnwidth() takes <string, len> and must not
> scan past it, while strbuf_utf8_replace() and
> strbuf_add_wrapped_text() know (or can cheaply learn) the end.
>
> Add display_mode_esc_sequence_len_counted() taking <ptr, len>,
> which never reads at or beyond ptr[len], and make
> display_mode_esc_sequence_len() a thin wrapper for NUL-terminated
> strings.

Good.

> Use the counted variant in utf8_strnwidth() for correctness, and in
> strbuf_utf8_replace() and strbuf_add_wrapped_text() (computing the
> end once upfront in the latter) to avoid measuring the remaining
> text in each iteration.

OK, but the latter needs a slight fix (see below).

> [Dirk Gouders: allow SIZE_MAX to be passed for NUL-terminated strings
>  to avoid O(n²) degradation as suggested by Andy Koppe.  Also add
>  tests for these functions.]
>
> Helped-by: Andy Koppe <andy.koppe@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>

Minor nit.  These ought to be a chronological record of custodial chain.
The original author's sign-off comes first, then Helped-by and [note on
the help in square brackets], and finally the sign-off of person who is
relaying the final package.

> diff --git a/t/unit-tests/u-utf8-ansi.c b/t/unit-tests/u-utf8-ansi.c
> new file mode 100644
> index 0000000000..d969737000
> --- /dev/null
> +++ b/t/unit-tests/u-utf8-ansi.c
> @@ -0,0 +1,86 @@
> +#include "unit-test.h"
> +#include "utf8.h"
> +#include "strbuf.h"

Do we use <strbuf.h> at this stage?  I do not think so (and
<unit-test.h> includes it anyway).

> +
> +/*
> + * Test display_mode_esc_sequence_len_counted() for NUL-terminated strings.
> + */
> +void test_utf8_ansi__sgr_len_counted(void)
> +{
> +	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("", SIZE_MAX));
> +
> +	cl_assert_equal_i(0, display_mode_esc_sequence_len_counted("\033", SIZE_MAX));
> +...
> +	cl_assert_equal_i(7, display_mode_esc_sequence_len_counted("\033[31;0ma", SIZE_MAX));

It is sad that these lines have to become this long.

As the values returned from display_mode_esc_sequence_len_counted() and
friends are all size_t, not signed, cl_assert_equal_u() would be a much
more appropriate assertion here.

See how t/unit-tests/u-odb-inmemory.c:cl_assert_object_info() nearby
uses it to check values of type size_t.

> +/*
> + * Test display_mode_esc_sequence_len_counted() with end pointers.

Probably with "length limits" instead of "end pointers" in this
iteration.

> diff --git a/utf8.c b/utf8.c
> index 96460cc414..503edb8edc 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -16,18 +16,31 @@ struct interval {
>  	ucs_char_t last;
>  };
>  
> -size_t display_mode_esc_sequence_len(const char *s)
> +/*
> + * Return the length of the ANSI display mode escape sequence (e.g.,
> + * "\033[1;31m") that appears at the beginning of the "len" bytes
> + * of string "s", or 0 if the bytes do not begin with a complete
> + * such sequence.  Never looks at s[len] or beyond.
> + */
> +size_t display_mode_esc_sequence_len_counted(const char *s, size_t len)
>  {
> -	const char *p = s;
> -	if (*p++ != '\033')
> +	size_t i = 0;
> +
> +	if (i >= len || s[i++] != '\033')
>  		return 0;
> -	if (*p++ != '[')
> +	if (i >= len || s[i++] != '[')
>  		return 0;
> -	while (isdigit(*p) || *p == ';')
> -		p++;
> -	if (*p++ != 'm')
> +	while (i < len && (isdigit(s[i]) || s[i] == ';'))
> +		i++;
> +	if (i >= len || s[i++] != 'm')
>  		return 0;

Among 4 comparisons between i and len, only one of them follow the
"textual order reflects actual order" principle.  Can we revert it back
to the version I gave you to compare (len <= i) instead, if we allow the
commit to claim to be from me, as I wouldn't write (i >= len) in these
places if I were writing this patch myself.

> +	return i;
> +}

>  /* auxiliary function for binary search in interval table */
> @@ -218,7 +231,8 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  		size_t skip;
>  
>  		while (skip_ansi &&
> -		       (skip = display_mode_esc_sequence_len(string)) != 0)
> +		       (skip = display_mode_esc_sequence_len_counted(string,
> +							orig + len - string)) != 0)
>  			string += skip;
>  
>  		glyph_width = utf8_width(&string, NULL);
> @@ -279,6 +293,7 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
>  {
>  	int indent, w, assume_utf8 = 1;
>  	const char *bol, *space, *start = text;
> +	const char *end = text + strlen(text);

This strlen() call is unconditionally made, even before the check to see
if we divert to strbuf_add_indented_text() with "if (width <= 0)";
measuring the length of text in that code path is wasted.

>  	size_t orig_len = buf->len;
>  
>  	if (width <= 0) {
> @@ -299,7 +314,8 @@ void strbuf_add_wrapped_text(struct strbuf *buf,
>  		char c;
>  		size_t skip;
>  
> -		while ((skip = display_mode_esc_sequence_len(text)))
> +		while ((skip = display_mode_esc_sequence_len_counted(text,
> +								end - text)))
>  			text += skip;

OK, I guess.

It is a bit sad that we cannot use the trick similar to passing SIZE_MAX
to avoid having to prescan to find "end", though.

>  		c = *text;
> @@ -378,7 +394,8 @@ void strbuf_utf8_replace(struct strbuf *sb_src, int pos, int width,
>  		int glyph_width;
>  		size_t n;
>  
> -		while ((n = display_mode_esc_sequence_len(src))) {
> +		while ((n = display_mode_esc_sequence_len_counted(src,
> +								  end - src))) {
>  			strbuf_add(&dst, src, n);
>  			src += n;
>  		}
> diff --git a/utf8.h b/utf8.h
> index cf8ecb0f21..57ca2ab270 100644
> --- a/utf8.h
> +++ b/utf8.h
> @@ -6,6 +6,7 @@ struct strbuf;
>  typedef unsigned int ucs_char_t;  /* assuming 32bit int */
>  
>  size_t display_mode_esc_sequence_len(const char *s);
> +size_t display_mode_esc_sequence_len_counted(const char *s, size_t len);
>  int utf8_width(const char **start, size_t *remainder_p);
>  int utf8_strnwidth(const char *string, size_t len, int skip_ansi);
>  int utf8_strwidth(const char *string);
