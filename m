Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453451;
	b=wxBEz0zmIYqBhIIx6+gg5686nSyz1QbkG+HuIyzhvIm3wD9pYeDLQ8cnYfOK8ukZT8zG
	 JEPwnp8Ho8JHY7Z++mtR64TqM/f5MKXnzXpX/RyGTtGasu1GidEW7GcuMmr5SRDwopqXZ
	 NL47L6ywpb9zXQkZy8hdfzJmMu6xZoDA4ornW6qadE7A6/FswA0WEz0ejMpenCQLbIFK4
	 4WT4dfbIZNUgE0WWMMbdjPeLLncKbG5Vn3/VE+xXKmySSuzcVR89ffI1Q7vHF04veH9LL
	 NG/rdjtcI7wdShV3qd8BvVagBrQdIkrf5vVIFwTDxvKYRUK5zUOYtUCsy6k5SIyEU7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453451;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=FwvlV1MVMTgdyLleYTwzjAveDudfhOhpp2svP77aXjA=;
	b=WCUvvkQXywNiEryVdqzG9vNtNZ08IB1EYLGpEnSW5rRfF6ksjy1wsnVxXG/BqsHB8GFd
	 uoEcus5E1sGUCVKQSDW+RAcSJF1blIW82csSC8lVBOcxeHbpTOIbLogxkFEkJmBsoOfXT
	 BdFBCSMHYDHUOZW6z008fy8qz769bULu89Uf8Ul6Uh3rWQgmUCNR37UxJyU090khMWPu4
	 Cmt7MWGc1WlfZfj4hoUCdN3N6qnavaLPAq+JTiiNlBUeh2It43awZafGPEJCP/KeKK11w
	 brpNczEKATAny9YCENypYUNCchSXEbvzRq7FJIXd4fao2TrDQtzOcqaEwr6qI3GZlZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fGLIPV6j;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="HhVL/qcL";
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45B606A331
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 17:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA45B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=fGLIPV6j;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=HhVL/qcL
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 18FF7EC1218
	for <git@vger.kernel.org>; Mon, 23 Nov 2026 12:04:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 23 Nov 2026 12:04:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795453450;
	 x=1795539850; bh=FwvlV1MVMTgdyLleYTwzjAveDudfhOhpp2svP77aXjA=; b=
	fGLIPV6jCHdITXamU7ys5tAlbpNeFvSpRDlmrzUyz04Vdr2rhQdrSYUXJmYcG0+G
	lultiIOqmM7tvuJ/oRrDioMevYfm8cbV+PwS0QpJ0DbOe/dNP719RKBfHligIWhS
	OnAecjB9FwyUFDMxvJypWZ5FKVlFeDhgwbsm9FL7JPZgQcSBW90LJevYJ6QSe25N
	JmtlMUZ+rrsk6kdSBMe8Orp9UQqnF5sjrXkgfat7FlkCQTQHR4fH+nbhKBzbNevw
	/PlSFpb8g8JqSwZl/mEOS9zfZY99PGOfhEvdFt2MyIKHaX6bt1l0aGImwEEOGYyg
	ZPRKJ1ivohGfaRPZYpe3XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795453450; x=
	1795539850; bh=FwvlV1MVMTgdyLleYTwzjAveDudfhOhpp2svP77aXjA=; b=H
	hVL/qcLcRqwoOptqtt3x5YwDiYb74roJO58qRz5JpN+zKBi6jCpB7ANS68htjzP0
	h2BEDANR4F9pAnYGv04uh76tJpgyrZQdbO8/zcR/NdJzNDjCWaBb3glsCPS8rvGB
	NyVou/+xCJ2KMZMGwJ7fjgj2GVqeAP7PBG5D9gmZmFzAYECqsyVWlyOgKyCymZjT
	AP5UIJeOxrD1mVZxKoKEhpCzuyImgdNzNlnbfXMVAfDI277Llp2b1x/rr+udVDoL
	/XIhN4GXJKxkP4YlsiKboCjJD1ciV+uiO5OEd5Jbr4skEa+POwt1EugMf4CTDNJs
	d2NjuWLo0eKPIpnRUyf5w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795453450; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:g1iA9+2o0k79DyWBVyJDdbQTDpobIQpcOh14U3uWVhVxugN
	NqG35Qwyu674wmbnmeFNMBl1LRGiZBkdJnauXW5ECrMnsc++y9gwg9Utlonq6IhK
	QyOXMOrgNYdfblxl+AolImSpCxn2n71AYEbbkFR93GhkdYqUdobbXheZeatAjcf/
	BRb4xVjDCkTVJFi6J2gQg4xT42J90Sz/NEaAxgq181nv+neMWaco9YsG2NBP/aj5
	48vfYuCY3YftZ4gIQujnFOb5u5pEKpjV0anklxeCCV/0SdyeHXJ6/QYd8mEb+Bx/
	i8qdEOTC5WXNhUuqHRmtOaJ/kxRMieiLKBn4X8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:WFXpTZqHZCvaYYl/LO6wG2al1Ru2AAP3nssVfoP+OTY=:HMM3eck3UN5hkX6IcThwckAuNbjBBPyWQFWOpd2JxfI=;
X-ME-Sender: <xms:CXIEa8FFDKrK6y_EnQw-Wr3EiuCXfaDKorzd19TUU5GvqCgvjqWwaQ>
    <xme:CXIEa8XZ_3xk0Rgq_dMzKn5mhX_WSO0BePOaBdaskp99BTu00r90nzhHbU88ygFpG
    J4cvGG-OYVSJFQeP8O5cJEKc9PD9-DL7mwFdGVdEI_HMbg-XndW_7g>
X-ME-Received: <xmr:CXIEa7LEHBzoCxrn6d62P6XrSVgF1QMKBXr7fHysL_eyzwYV6CkG0X5OIxRbQyHHjFQpBUJ8gRbaW3bhU1cyzd3A7mYygDzKOUD6Ucc>
X-ME-Proxy-Cause: dmFkZTFjQkqSPJsxyIO7eGNP0KiByFmyHFgp2TiceRzOnIGH3Kw1JARjUgMTC4Dz504UXB
    DeWvbcwyuFKBIYSHppmO657KCFZ3GfCcBMqeBsALlPbAipOkqspZIK8bEGvEZpq9r6lh3x
    FA7/OpdIrENwZ/55r4BHFKwCtlhJWSlLTdPoEJWCuIx3Eb0G1FwsEDYD8Uxj8/V7YnJNN1
    FT10SU5F3cr3aAc5LuOfKcEAIKqnd2lJP1mZ/LxsINpXvXMO4SMX4pB9JvttbkCXgDzsA4
    MSg0HlKmDcQd5Me+aBIFm8uApYr+lY5MNCd3XeADFGQggMrQwCW2c7UzRK6bRk8ato5kfC
    VQAvNa5/whPbqKWlIC/mBJ1nHrK+8PawCEb901zMnKgjLP2aQkwpFkj0u+SGPwqffOVDHV
    Q79jWc+cXGv6x89AGuyicaurhP7jVn/8sZE7gtxOY+kS9Ao3OdntYwji2cue0X5BBMhuY4
    lyUtZY9aTZPX0Ca65/Vd7kWLs4eA7S8vJB6MWpl6TZYr0D+CMu9LnjcShmUaNTHISfWp84
    uHKlbhOOApxnn+gtRUQmpM1SLtaxwHLAC0Vc/FdBsE8CiXML/Pii3f9igE+5Ax2ODGnbQ/
    XzIgIMr2FkFNYStdkU4DIMqqKQAfWRBq442mzDuqYBYAZJmP9l/qDI6uh63A
X-ME-Proxy: <xmx:CXIEa8-5L1omiCOwy4XxRa4ZBxPosg8fcG5c4zSqxshyAK3bT4mZsg>
    <xmx:CXIEa-JMV8GYw4cSELhvZhZCcnlfkjPPAn8KZyAYZVieKfowAkJ0Pg>
    <xmx:CXIEaxkWLew2mMWQOsllZUb7tBMjX-5TtKTA-PHuGCMNkt9ooQIB8A>
    <xmx:CXIEayPyA6a_uOybbqBYK9riLbV0a6tCePQmewDD4TyqAhtZHf_lCQ>
    <xmx:CnIEa1J3FZ_7e3ndibw09mdBZBt4Qcl5XCQRQF5rtYvj3i2NrwJjGxcd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 12:04:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org,  "Junio C Hamano <gitster@pobox.com>, Andy Koppe"
 <andy.koppe@gmail.com>
Subject: Re: [PATCH v5 4/4] utf8: respect boundaries in utf8_strnwidth()
In-Reply-To: <20261122-master-v5-4-313bd1bb3c45@gouders.net> (Dirk Gouders's
	message of "Sun, 22 Nov 2026 15:51:27 +0100")
References: <20261122-master-v5-0-313bd1bb3c45@gouders.net>
	<20261122-master-v5-4-313bd1bb3c45@gouders.net>
Date: Mon, 23 Nov 2026 09:04:08 -0800
Message-ID: <xmqqwlq38oon.fsf@gitster.g>
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

> Subject: Re: [PATCH v5 4/4] utf8: respect boundaries in utf8_strnwidth()

Micronit.  I recall 3/4 was also making utf8_strnwidth() respect
boundaries.  Can we tighten the title to be a bit more specific to what
this patch does, e.g., utf8: bound utf8_width() calls in utf8_strnwidth()
or somtheing?

> utf8_strnwidth() can be called with boundaries that effectively cause
> incomplete multibyte sequences and we should return "len" in such
> cases.
>
> But, utf8_width is used without its optional boundary argument and
> will thus work beyond the given boundary.
>
> Fix this by using the boundary argument for utf8_width.
> Add some tests that cover such situations.

If you follow the convention to mark functions with () suffix,
consistently do so also for utf8_width().  It is a very good change to
make sure that the called utf8_width() will not read beyond the known
end-of-region the caller has.



> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  t/unit-tests/u-utf8-width.c | 9 +++++++++
>  utf8.c                      | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/t/unit-tests/u-utf8-width.c b/t/unit-tests/u-utf8-width.c
> index 5e2b636db9..c4df4dd6a6 100644
> --- a/t/unit-tests/u-utf8-width.c
> +++ b/t/unit-tests/u-utf8-width.c
> @@ -2,6 +2,15 @@
>  #include "utf8.h"
>  #include "strbuf.h"
>  
> +/*
> + * Test utf8_strnwidth for cjk characters invalidated by len argument.
> + */
> +void test_utf8_width__strnwidth_cjk_chopped(void)
> +{
> +	cl_assert_equal_i(1, utf8_strnwidth("三bytes long, 二columns wide", 1, 1));
> +	cl_assert_equal_i(2, utf8_strnwidth("三bytes long, 二columns wide", 3, 1));
> +}
> +
>  /*
>   * Test utf8_strnwidth for strings with SGR sequences and corner case length
>   * arguments.
> diff --git a/utf8.c b/utf8.c
> index dfc5261619..f7fb419545 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -229,6 +229,7 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  	while (string && string < orig + len) {
>  		int glyph_width;
>  		size_t skip;
> +		size_t remainder;
>  
>  		if (skip_ansi) {
>  			while ((skip = display_mode_esc_sequence_len_counted(string,
> @@ -239,7 +240,9 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  				break;
>  		}
>  
> -		glyph_width = utf8_width(&string, NULL);
> +		remainder = orig + len - string;
> +
> +		glyph_width = utf8_width(&string, &remainder);
>  		if (glyph_width > 0)
>  			width += glyph_width;
>  	}
