Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443338;
	b=Af4b3w62+rUye8+abUwCIu5xnvhKuWEvO2T3Puh02UDRyGbQsskulg1IdRVd/XLPaidl
	 QqgKnkH6Ta327lnzlgP5LBS5sB25auAstINM27r6jeGVU4DSmgwUrOc4v4mgSsShWX2CR
	 5T9sGU8FHaA5I3IubwuhSjBn7yWhk+kIeXVy+GfjP7q/ptxClxm8T44hvkMZpGyCTDfmv
	 FbzOedjRZVM3gMfOYtKXexFv0F8zqPzE4fFVt4tqHJRWFbhhXxnB+ObYeYUU6C20kbjGC
	 nWiIF8vcWI+yRBQcnW7Ju1LKHBtS3aWa3JU2HCcWQxSTqt91SxKGCsdOY6saifsihDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443338;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dy4tWCKdYLoOtuZNFZTnspZePtECI8CM0riw2EUo3F4=;
	b=t13lTGWjT1IRooeZABUvqp4V4BWw1jkLJwBew6rlqu7tMZUzUwKmvGS8J78hOvymiu8w
	 jtKrNr+RwO989DL7O1MKoLoQZqkfQW7PEFbHTuQ1jRF+nxoR7zPx2rPRpqD5iyLBtwYxU
	 4kjYFHlW7oocTSPObuqCUXnK47TQ2RTPfk4aOgw9lVL+c4B3YrY/lyBchOsh4j2xEaRyb
	 vUNqkuwGzw1hPriri6tIgDbc+Lt190Lm104bFahzGsVTKNM4XGTjvLG6sd54y5uRGsbbB
	 dYFZ+aM+A7KB2PzVap7ro/lkyZPcYMp+M5BEsL3+G0I82uzzqMg9Jwwaf5unGE025MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PshHbd7H;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ejermo8X;
	arc=none smtp.remote-ip=103.168.172.150
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8F606A319
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 20:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2B8F606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=PshHbd7H;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Ejermo8X
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 0AA66EC0100
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:55:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 19 Oct 2026 16:55:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792443337; x=1792529737; bh=dy4tWCKdYL
	oOtuZNFZTnspZePtECI8CM0riw2EUo3F4=; b=PshHbd7HxHhLWYTHmyQfiWlVJl
	GO5IFzD1vfpMNwwnKZtN7X3xvEDHNh3MZOIloOKoE1v8KgGG1Tu945lBR9TawAjR
	eQzxTfDvR703Wl1OKzJwhrEbiopLyvYVB0sWSbDLVZr4ooMISRb7bJCL6f72xbSj
	t6AFeVANOhPA8m6rCmOg7qMBitI/v+5A3P22pZzXoVVT11NtYnPtfV5+mB3V7jVK
	J1lwTJ0/Q/nP6IB5gacUIZAxnW2c8jcUd+GFtbH2MnmXFtu4wZCxSfruazKm7vsB
	ub1Vkr0TK9803LS2P9+irps2a1ZX0OxfjSZ32CMuMmdoV5WnuVdNwkiQAyRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792443337; x=1792529737; bh=dy4tWCKdYLoOtuZNFZTnspZePtECI8CM0ri
	w2EUo3F4=; b=Ejermo8XHR11xF4OQOotR8TqF+CMf6kdvf6pEnPa6Lloyj2kucS
	SC+gd9lTq2qOWGQExlmGxMOvk9+fTVcqPRqCT4svExRZKV3vZUBLUmYH8wqMATlv
	bx6O234hcI+7PAnPGBCaXzX7WwuDDRLO70A7zwM8qCwt7d96iQLOK2ctQANkB0h4
	NIOl0qxxO5bqttqnvIuRK8XNEjAUooNw1X75tVsxpYJ2BYR6rdQR1KwIaPmzNBBB
	wkK8iao7HiIKFuFZrWwifjd8HyYhWUUUmIRCg+uSs1k8ikQXDwRY0A2+X6ddGEz/
	brugVtDsmRYWs0YO6lh7YCf/n6IcGePw4Pg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792443337; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:jsDCncF87pBnTqbw+NrOVt8oGuHhFZPPMYq0rPXmRehgfzq
	ytDjOl7S2FXX3n4bn5RXmUcZAtLCXDWP+IeM1ODX4x5eqnnu694bVbDW19AINX/S
	aZ2/c2PH9XRCzSS0lpK+JzA0C/YkWagTcA7Jjq3rK7zgSPD2qImUwYj5mWRs3DoR
	9wtIxUR1pdSFan/Q7aVxyNtEyqa56ibY7jeSMaCIt3IfdPD+yxE0xJMXYHsNyz0Y
	KVGnPAqUCFq86BqhY1k0pAYHm2yWDuDZ8GGnHYTHoiENjCiHYEDm8rgNFUqwmULx
	orCsCAztHDOBrD51ebNrfgJ/O67mvST/M+djUfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xfCn9KkW98sNPN/0CnBMv6tQuTzbO0MkL3fJWB3TY/M=:n4nak3e6d5aGlCjK6MFUFhJBeaeXErucfvig/kjd6V8=;
X-ME-Sender: <xms:yIPWavJgPk75pD3p8SfxlR-qoHL8I1vcerTiaEmrURx3qdgTCKORiA>
    <xme:yIPWam30MY40MB9fe42ELQmHPN572utNnzOhWvOJt5_9knVgW4GXY2sNFqPPZzx9G
    wh_I0cnGSVtG0aUYnOl1tI42L2HSDpsXzgJMpmhTYrvveHHZMdOHcQ>
X-ME-Received: <xmr:yIPWahhbHpDzS3D7mqD2h-r_PMV8iw8OBp2XHKWgCxOWHQvz24-OJM-XMdkwJ5O3AAA092ltZWxXGgEJBX3rc7jEy-x5LEx8rtQC>
X-ME-Proxy-Cause: dmFkZTGIt2osOkNwuLlWgGv3yboUj4DTpd3Dppzn9lC2l85z3C/wCjQPc1RpP9BGoLwXpt
    EC/2G5D1DOgwAdy2GYDHMo8LhVrhWWssyvw5mOLnXNpkbOgsW/kKKcQ7XNqc+HDxfAupag
    0b0bBdAy8TFdmBENAmEzvzKgOPczhzeKmG7GTywq3cbEnNk0IqONFcgjih05hoRcd96AMR
    Tn7Sz867lTDb7vkVi9MUnmhMS+0oNSQh3pDGsfdZxnU25qaSGHzk5KYfrYkVMe98Og1PHo
    jvX9s47lBwcfLQdI+UISTuqSlmuCUOxmop2zDV86UdFiyb9m18QhM+mC147thfGfzyCfWp
    qf9lLwIX/l260yrSQWEpQcgJSKJqI6fesJM8/oIjNpH4A0BSFF9nX1ZEl/IV3vrGpOQRSY
    tOj3fZ15nynPy8+gFbRy/vaXA8texYu0KbYDoCT8UAeO8jJgRsWhBvZiHWtire6Arhvy/m
    zDR2gNx8Bo0gArcmGwhaizFsidytELujguFqacPz/PKzLQIUZj6QH8tahNxzvyCQjhHB/v
    e381Dalzz08VMraCSdxzrzS0txuLyjuoXi0T9wyktxXIiZeMvheamxbk2ZZ3gZnhSHqoY3
    t9apF2pCwHxKJzTl10FY0X8DP4hnlS2a6oW/Nu/xroA7o6Ux2Tbs8yd1zZaQ
X-ME-Proxy: <xmx:yIPWavXI0VAe7Ia39k0eYhlg873vkjv9psp0m96NGx1NWKhz0CG5UA>
    <xmx:yIPWaoV9MAJb7nBIt8zd1hICB1dlbUVGLsAK5Xg-jPffbZ9pacfWnA>
    <xmx:yIPWangONxvalQdSeVRW6AIB5JQBk1HM9qxy8jE_VXi0OrbW4m8jpA>
    <xmx:yIPWarZvGYKwPDASupmRde9LxA64haYLjeKSEXenCd29nlaa4L6Usw>
    <xmx:yYPWai3Z3pUsIBK-1E1KdYl1WEheNAx0m477c89n_4MfH70-2vP6Lkuv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 16:55:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Olof Fairbrook <olof.fairbrook@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff King
 <peff@peff.net>,  Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH] config: read the bytes of a blob as unsigned characters
In-Reply-To: <20261018152426.2716899-1-olof.fairbrook@gmail.com> (Olof
	Fairbrook's message of "Sun, 18 Oct 2026 17:24:26 +0200")
References: <20261018152426.2716899-1-olof.fairbrook@gmail.com>
Date: Mon, 19 Oct 2026 13:55:35 -0700
Message-ID: <xmqq1p9l4dh4.fsf@gitster.g>
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

Olof Fairbrook <olof.fairbrook@gmail.com> writes:

> "git config --blob" and the other readers of config from memory get
> each byte from config_buf_fgetc(), which returns it as a plain "char".
> Where "char" is signed, as on x86, a byte 0xff comes back as -1, which
> is EOF, and any byte from 0x80 up as a negative number.  So the parser
> stops at a byte 0xff and silently ignores the rest of the blob:
>
>   $ printf '# caf\377\n[some]\n\tkey = value\n' >config
>   $ git config --blob=$(git hash-object -w config) --list
>   $
>
> and a blob that starts with a UTF-8 byte order mark is a "bad config
> line 1", because the code that skips the mark compares with unsigned
> bytes.  A config file has neither problem, as getc() returns unsigned
> bytes.  ".gitmodules" read from a commit goes through the same reader.

Nicely explained, even though it is a tad overly verbose side
(especially given that the example code is something we can see in
the added test easily).

> This has been so since config_buf_fgetc() was added in 1bc888193e
> (teach config --blob option to parse config from database,
> 2013-07-12).
>
> Return the byte as an unsigned char, as getc() does.
> config_buf_ungetc() checks that it is given back the byte it read; it
> now compares with the byte as an unsigned char too, or a CR followed
> by such a byte would hit its BUG().

Very nice.  Will queue as-is.

> diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
> index 5cb546dd00..e2c0883350 100755
> --- a/t/t1307-config-blob.sh
> +++ b/t/t1307-config-blob.sh
> @@ -72,6 +72,27 @@ test_expect_success 'can parse blob ending with CR' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'a byte 0xff does not end a blob' '
> +	test_commit --printf FF config "# caf\\377\\n[some]\\n\\tkey = value\\n" &&
> +	echo value >expect &&
> +	git config --blob=HEAD:config some.key >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'a byte 0xff after a CR in a blob' '
> +	test_commit --printf CRFF config "# a\\r\\377\\n[some]\\n\\tkey = value\\n" &&
> +	echo value >expect &&
> +	git config --blob=HEAD:config some.key >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'can parse blob starting with a byte order mark' '
> +	test_commit --printf BOM config "\\357\\273\\277[some]\\n\\tkey = value\\n" &&
> +	echo value >expect &&
> +	git config --blob=HEAD:config some.key >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'config --blob outside of a repository is an error' '
>  	nongit test_must_fail git config --blob=foo --list
>  '
>
> base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
