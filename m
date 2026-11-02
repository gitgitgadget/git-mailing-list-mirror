Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793610080;
	b=4ozKaV67IpLWz1VNLFlVnaDKIgptJK/kX0n2c2xk6UsQIgCyJ7oyU7/XWSGZAURiUj9w
	 CyEhc8qqXfFv2XO88A9GLGDREq16Gly4bxJNWcJrQiFhv+Yajkj9RYVn6RkHvJ2GQ5z8/
	 vNYk6zrrTBDWmheDbDUWWgfO59yM1f8w8xYFyJ4jSAKg4AS+tWq+itS64GNkek/ZcWOay
	 VqyRJo+X9oqT8YuakXHZX6WaB3pm7SLPdmt7EPVrOMs5yn7T7tA0Iq4jIYqsCK+jBRnEY
	 9czBtE6xqPKBSoqLYs605Q4fcKtvYjHXL7KBvrvtgxl8ztvXFtRKmODKBupfIIRoopg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793610080;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=jh91q0AuaGNXxr8oPXATCJx3p/3kpJEbINLP48oPLrw=;
	b=TxTtGKJY1+QTn2VgNZi992I1+80mujUb8iOrfP2cZHDDN0DRXZqsxVqkFe/6TcgaVW+m
	 Ds/saA++r3FbOk8D/NxcM//m1wjRCAbnz98MXl4tcq5TFmBVEGhT4PZfTaYsmNUUUVSle
	 A/ISbeVpBUJauA5fNbJjH4pOdSGJebCZnLPJnMmSOPiEjxYqbyKT+diNPXN4Reqrpo2gy
	 ovCSODPlPKiWqRTN+WNDdtiHRGQx9afCjwyIDl6leVPjoOfS/0qbNaGUkm1wF4d9iQ/ds
	 fyHT3x/V3GqSdDK4l9UDa8V2VH3NOnaBUVEfTJb5Blaz0Fvl0WAo13DqKFfA7ahmkTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OC9O70Y2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=W5rylF5e;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35962606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35962606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=OC9O70Y2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=W5rylF5e
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8E9887A0078
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:01:19 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 02 Nov 2026 04:01:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793610079; x=1793696479; bh=jh91q0AuaG
	NXxr8oPXATCJx3p/3kpJEbINLP48oPLrw=; b=OC9O70Y2AooXnGbWzZYrWZXOow
	iXleCBIjqZ5mq9US5bqpgoPAoy0A/DBBIUtrx8SBxhkB6dUCgZgFeJB7HE99wgMD
	nBS4QSpQh8eyYu3BjigvUD8UmTEH6OOA8uh5Q+xMlpqfUA0qDaE+5GqGgBWBhqQY
	++sQ8pgmufQDpOwnKqxDARImyGd2E5iAVkp9YcA7Qy9ZcyBh5AyBi/oRaeKc1FAG
	5tt66gLHVlTl6A+riCLF3pqz6B2O3bDQArAbTzX+Rxpk3Ew+fut4uKY2uQFRb8pR
	2g1w6NA9xLcmqJCmPyhpqoN9TyJLf8V1BzdMYT67fOtdYwmMq4DvsFqVDyzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793610079; x=1793696479; bh=jh91q0AuaGNXxr8oPXATCJx3p/3kpJEbINL
	P48oPLrw=; b=W5rylF5e4yDHZJNt0DosfPyt8MLfurw9Q9OrGmKluNeXE0GAyS5
	yv9eOsHxHd8TB6rVB5A6y9RmM3R6y4cub4UOqPokxI2aVb2TjqoEpnhkKMcT0R0R
	A5C4NBnK5E1oNeL/jBAMRgLn1rRkxxzAEvEU0Yiv5m2CUszKxb8g7ykcf27LZXt+
	za5u3X67z6jZnAx+y+6XJkdkHlTwrjA4JfHxHtF/emeAuMxFQ0yu6sEPTqklCCx7
	+nXoPz6bOhHpghALXTw0xfgBBMnOMZqNM8PITtJ/8tVPzQGr7i8ekJ5rCBEvkdDv
	vIsPFzUYIhjzudiJHsLjdKQNmgNLezlulzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793610079; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:D6qZnQ7T2b+W2iPjx7sPk/jq9Q51HfNYbLYoiBZEIQNgVWm
	SO5bRD2VABfmmYS54ADhxNIiny+mb78zJQ0seHSFr2KVLrKJW2Zgnr0/1eARw9a1
	FqDUHukP6W8k2zaHhcUON7KYXanwuQQryo3C1Jv0CMji5gGXtSTdIk4T+Pb0Fs5g
	n88xbAyTFaXulWYaRRzYjmr4+XLOOBJ0E9LvqfSXq9Iz0K4LnHzF+OUDINeyTauu
	XZxQS0z4XH0xzz8S9Tc1E5b+pqxbTKKkIpAAOMu3doegYXiGpRy+auuA9KWbDzBf
	WXVYAwXtNk2/1yhJkbEGGss8WCBA4eYT2jL3oKw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zkwbBU03PdWwh5R11IrE7d0I9grx19Jn/nvMXdAu8nY=:LRsEK8UyObJXy22G3+5qRkpxEh9H8m5QvFA1ksTnFWg=;
X-ME-Sender: <xms:XlHoauskLFhgGSHQ8L8Ysqrm5EDIYcvHxgk7kHUdIvuBTt3iPGy3BA>
    <xme:XlHoaq7RbLh28khcOZlOOSVN9FWyQpW4m04dSAvVi9nhIm92r9h6gtwgOZUW4eW6I
    k9--3e5m9O4X2gx_0g21iOJQGFu4mPpmQX7S1cm-lwBnPHlqJ40Bt4>
X-ME-Received: <xmr:XlHoanKjna_qC7ZeIFmy-VJ7yNcnjZaZ7TdYckYGSzvOEzKSh8TkMoUxAkDV0INAXhK24KpNUORcbUxJ1m0KEDjVcyEo1927zt7i>
X-ME-Proxy-Cause: dmFkZTFoxXqAl0cYhkZI4CUOXBn74OHeSTruGzujThl3Q3sqaEof1d0mHJXtqdb4TIaK8K
    V4wdQCruLcobwrL+qIZrAmAz8/+g767ZEJrBAaJFmh1j5L6o5R7rO8kop4kw2KIogX3GuK
    5yJr5g0gQVMT4FvJctMDv1E1zkpBNHyYjDeEaNp6lYemCUSfD95WtzYa7teov3WxJj8HtY
    qHEt/2EbwtOlluxaWhOX7dcHf4z1hoMOB9drRxq+Ba6XiiXpYvjges0bxsceTntMMOACYf
    sYfhyiCbplQcSm1eRk1M4SrzZ/BvEbPacBpOhYHanf47xfjAblNObnl7Q1W9vL+Be82VmB
    7LhtKCrXebuTZAeoqfRKuMeXLLSpi0sXATJsn6NSAXruRc9DTSUXe/XJUQ9b7vVxxia4zC
    KPlqK+MZnicDmd/O1OX08/1Zz6+SOvK4clJ2HSdeSUcGHeheCvLdEtQERP7/kY13XeAfI4
    zHXxdRtIlpg9l6mYawgu+vUYUj4gTEy9pwm/vRbcNBA5q1JY3NGNm6ah52gmxSKceCoHZA
    FeQzKYsFhLXZyheTzKI2iXcQxcXKEa/5J78IdvPTsOcBBhVgol+4qGrDla0pPs8p6r4VSc
    YH41LB9g6Dllz2tqSzsWS80X+n8ijBfoJp0a6aQlslMm0+6totKxzinirKUg
X-ME-Proxy: <xmx:X1Hoai6H2dhpUbU9dTqM3gwclKGgPcX1xsRzpj8vVZda54morGp5dQ>
    <xmx:X1Hoaixe27DoujfzhNQVxNzM19h4RvUA98uRAxqaZmTHbWH-z3u7zw>
    <xmx:X1HoauYhJGdV_RE0SZ8Do8kR2x3cIBSQq4VX7Dj7YhpvwkzjoadIlw>
    <xmx:X1HoasQcsoIB1zexXXK_mEKoNG77dw1iNwT9O8JAScF40qIDHOVjlA>
    <xmx:X1HoaiJmUBtqA-JpwwXW-jqL1LiJ11GtfZdej7BTa2q1GZj33zYC_wJs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:01:18 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
Subject: Re: [PATCH] doc: remote-helpers: option pushcert if-asked
In-Reply-To: <20260829183659.29947-1-lorenz.leutgeb@posteo.eu> (Lorenz
	Leutgeb's message of "Sat, 29 Aug 2026 18:37:04 +0000")
References: <20260829183659.29947-1-lorenz.leutgeb@posteo.eu>
Date: Mon, 02 Nov 2026 01:01:17 -0800
Message-ID: <xmqqfqxjmwte.fsf@gitster.g>
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

Lorenz Leutgeb <lorenz.leutgeb@posteo.eu> writes:

> The documentation mentions that the value for the option "pushcert" is
> "true" or "false". This is incomplete, as can be seen by analyzing
> transport-helper.c:1009-1018 (added in commit 30261094b1f7fdcba3b7a1)
> which also implements setting the option to the value "if-asked".
>
> Add the third value to the documentation (added in commit b9299a2bb1).

Except for these commit references not using the --pretty=reference
format, I think the above is good enough, and the patch contents is
true enough.

That's not much of a review, but that needs to suffice for now.

Will mark the topic ready for 'next'.

> Signed-off-by: Lorenz Leutgeb <lorenz.leutgeb@posteo.eu>
> ---
>  Documentation/gitremote-helpers.adoc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/gitremote-helpers.adoc b/Documentation/gitremote-helpers.adoc
> index 39cdece16e..10921e91b9 100644
> --- a/Documentation/gitremote-helpers.adoc
> +++ b/Documentation/gitremote-helpers.adoc
> @@ -523,7 +523,7 @@ set by Git if the remote helper has the 'option' capability.
>  'option update-shallow' {'true'|'false'}::
>  	Allow to extend .git/shallow if the new refs require it.
>  
> -'option pushcert' {'true'|'false'}::
> +'option pushcert' {'true'|'false'|'if-asked'}::
>  	GPG sign pushes.
>  
>  'option push-option' <string>::
