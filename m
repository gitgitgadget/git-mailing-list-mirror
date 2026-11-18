Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795038628;
	b=AF48qAN5u7tcDUuF24hHlsolWep6xh7bVFYfcqis31R3f79XvvHIO9jyidugs6jiwl9g
	 4wK8fVYvgqRGNrZo6TEZrnmbnDYjzcULgkrVAnzTYI7zPNQYLmjHJPE3GaxgRRks4meNA
	 N432v6mnbX9QoMPEfcRlTcs8CvPWOZbQJsPUZA9XbMTNmLDMfD2IMUbwzqj0mJCz2i8n/
	 cw5ajo6sSan6gHvURnHCUzkct1YgvYdl53POmlMuGaS/N69MB893dYWx4KI3C0E0+3GDG
	 WqkkkQupy78Eolm85tucWF+cJ0XWl01qmWItuufq9kJNWfw7o4oBZsm/MKLMb/aqCDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038628;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=rY28MxyJjQrz81Wz/IeWeurhTzsZ8TPA10q9OLMZ/hs=;
	b=at79XmKkjefsYinkhsWuQ2NMAgYKbto7WKC7C1vV82+IwRYrrdGxgHypTSkieamsogG6
	 qFsDewNS3SVFvGuC1jagc9uR7IXx8BYDZQSjM4qpPaFZLEXsGe78FpNcVT9E4cg4cRFkW
	 lKnbunqkXgEtr9sK43sPxmnHdpml/+BM8Tuy72DXYQZ4oQfHM0nJdP8IqpBdo0nntWqU4
	 XR5KBlM6xlJV5scEk75NFK0LqpO08CdC7vA9GOnjGx730a9L5epfDPtdmoVoip5YNHwuw
	 C4w4WxJUsIcW5JJnCGjPKxRHo+v7tXu1FKiyzxO42sMqk8K3M6PrRaA+sb69d36unZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TzCsAfBL;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A5d2jUyT;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BA606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:50:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B2BA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TzCsAfBL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A5d2jUyT
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BD6AEC0808
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 16:50:27 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 18 Nov 2026 16:50:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1795038627;
	 x=1795125027; bh=rY28MxyJjQrz81Wz/IeWeurhTzsZ8TPA10q9OLMZ/hs=; b=
	TzCsAfBLLQvGG+ihe+E9fqi23DXNoUPxPWLNCG2W47TXGWUKGvg587RZ7+SDWzEz
	YHnwwJI1bMPBDMoOpV+cnOluRVxXekcND0z7lFUENGrDdMDDMQ98W/KotvNG9reZ
	sZxoCNWgJMSfYE70YUoXBHVkN8Mcury0sm5B1Q1nCtBI4CJkQGvuCeFpTYPXL+KU
	3Jt4ptKqC/p+BR+98dObQWnIPw6PSWIlCNjVYoAKKe9fzE3LPdukEftGV65+zjEv
	o+PHQ8auZY3BItfAn5L9+Logf2zPtNSF3bjuLLoAV7Iqj1hc6C1tHuuPaPal9DCS
	vTIIYsUE4+njWqdMvCZ/yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795038627; x=
	1795125027; bh=rY28MxyJjQrz81Wz/IeWeurhTzsZ8TPA10q9OLMZ/hs=; b=A
	5d2jUyTNItoxQmMCZOAWfURbp3lzrBZHpWrdRIiqH7aHdScLHcA7A0G+EzohmiAg
	XILZAwh7O7a1WMaNIY8Hn0v8y7AAX0tm6ZoLTlCMdxJXMYfTE740nB02RkmXzlz0
	4Mlc0K6jAHYul7c4ofr6t2U1RrgqPtHhNZa0FMj3g6U6LH8dNe9a8MAgQ2esDafT
	wjx9Z9FWE+hXwtYKthk4yaJkNmV/MolqO5Jx5/LTGSqmBRCKt6Mdsov6jdJR/eMd
	oiycCQxVIH6yMmP9qFJB3A7f/HbYgHQUFGMziSTuK8KMKLZoUk9bK0NGPLortgfw
	CobgeyRoxcCZuTROYfCAg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795038627; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:X1v3rdIpmKCslS4ES78rgNqLPhPGtgZScfM2L/G3MWpHPxp
	Cmvs7lKXxnUqcspWDBHaAyYM953/tt1fB9v0/18Qo0zwLm2AZ4yj96+b2TvHEqh+
	7uL2HiFFO+LOZ/xZbOaG71WSKTCfNU1p92f/62srRJn+uW6UVbGrYtVk3WpTeL11
	KHbXClx3BUhMG422U/sMjL3/rnRSSCjXfgzS28sPrB/asuC6iyGRVaggYAM7k/Ax
	C/iwbK5f7ib1FmHenExSfbQPwaBbGo9g6WE0e6paxbSb72oj9n0VIXtyXay7xzD2
	T1Np9QGX3phdSaU1UJ/+If3IvKjWJ7jN9qMVMyA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:kA1T0kYiFcurrl6rL34jcD1k3GMivEuD+GtIBcDEfs4=:F8dRjVVEXFn9sFwfpJO2X12bG18lVRYpCw8zjCp8ANo=;
X-ME-Sender: <xms:ox3-ahlBWtFHEvBj3Vd60Ozh_zGIOLzxQTLG5zgG_8igCPm_dzcGRg>
    <xme:ox3-akQlyJxNw9VZD3oGX4vmnL1BhalMKXN2FydTYPYMa3CTPPLhQe3ShtDYfRgja
    f7hDMFfWYKAWu-u3ScIVmvVLjYwOyF_fkk5u6Kc00b9UdBOX84aKw>
X-ME-Received: <xmr:ox3-alD-4BkxX38rFSIXlRRT76rrjdx2xFHIrqMnbcDqrH3NW-xcI4-LDMBLJwu3ODz-5w2vpqXiOuYLu3bXA-VKK7FHYX4k7idY>
X-ME-Proxy-Cause: dmFkZTGEdeSYYGhCGmqKOt+FnWLQ3vwxAQGMxFPh7tFiUHBx9QA12BO1Pw8GxQg2cM6NLe
    pRbLhPwtuzkIcI/RLCwjs1/qDM+FJKb+7ss6Z5/Ai3p0GTL+pVjU0cyzaoomqYLwdiectu
    gw010tvYALgOlEk/xCIrlA+CP/ngrNyVjsvkdylslwXj/os72GhIUnBngSOEzfGaJd3otT
    /KuOYw/47NfQjNAnOYO8NBbZRaJSg7zXdLpX8obFcBwC2nob3TlYsfQWl7MFNp5AMz7uhl
    d/x9zGZbdu2c2vYw2Xnh90XwmsrsSM1HZz7V0IcCc5RBvz4PgkbBzL/frZYFuq6JG1VLH2
    1mhhd+BlT7BQmEv5UW43zHwGb52ZqqSLttbLPO6NW96b0QFqfhBIboi2k3djx4v7K95pj2
    /+kK+lv46KpWIl/dRF5pZ9AnaFG452DixGKyE8biBIpqeyQc70FBv/3if+x362wbD7dnJN
    HqdpK+L9TLNNZALxwWQlGcZzE/6C1I/2IObsjoixb3RcXQHe/d+URky9sDRy3ZOY9iC9HI
    TmALQ/xoSQ8w5x0zUDz81vkcBYBULt44rLBwKuCNj9WEJCyoQYbyTf+djtZscsUqcwgQRj
    ywvZxD169S6nuwNRLxZe8tivQktO8XD+dcv9QUyXKF0c+V1H6aDuoyqWx4ZA
X-ME-Proxy: <xmx:ox3-arSr0uM7yO2okwVsBTgqqw5zqaRUhFeL1HBF8SbsI5uswTxJiA>
    <xmx:ox3-ajpPSBMFPork9LTnOLxJYn1jvPqefuEBI3Qj98n-hhQVNKiCbg>
    <xmx:ox3-atxYAY1AvjoXl7Buekme9WwDIw9PEp7XHgXI1mMnb1Gu3qfEng>
    <xmx:ox3-aoKHC2A24lhiTbVja-j4SwWPZS802cSSFsSjnIijX-6FpS9zKg>
    <xmx:ox3-at4ZEWU_kwo_HuMucqO0AP12QVYQU5u-TWm2tZEtSqZp7dttSE3N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 16:50:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 4/4] utf8: respect boundaries in utf8_strnwidth()
In-Reply-To: <20261118-master-v2-4-3f2aaec15d31@gouders.net> (Dirk Gouders's
	message of "Wed, 18 Nov 2026 22:08:53 +0100")
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net>
	<20261118-master-v2-4-3f2aaec15d31@gouders.net>
Date: Wed, 18 Nov 2026 13:50:25 -0800
Message-ID: <xmqqo6bl3j32.fsf@gitster.g>
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

> utf8_strnwidth() can be called with boundaries that effectively cause
> incomplete multibyte sequences and we should return "len" in such
> cases.
>
> But, utf8_width is used without its optional boundary argument and
> will thus work beyond the given boundary.
>
> Fix this by using the boundary argument for utf8_width.
> Add some tests that cover such situations.
>
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> ---
>  t/unit-tests/u-utf8-width.c | 9 +++++++++
>  utf8.c                      | 5 ++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)

Well spotted, and nicely done.

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
> index 1b88324ea3..8d4b159e1d 100644
> --- a/utf8.c
> +++ b/utf8.c
> @@ -229,6 +229,7 @@ int utf8_strnwidth(const char *string, size_t len, int skip_ansi)
>  	while (string && string < orig + len) {
>  		int glyph_width;
>  		size_t skip;
> +		size_t remainder;
>  
>  		if (skip_ansi ) {
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
