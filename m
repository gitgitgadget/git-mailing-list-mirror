Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917735;
	b=46cCZf3gXLJfbAOeGPjIYamyylldwKZWfx/EszOvONF+iRvw7lmhZrqUyrDE2SfA+IDx
	 6enESoqQn+g3va0gUTe1dL6KabOTTeAGHKsKgCfJY9Ogi0rwrBXq6S4/b/I+ROCVw3e3V
	 8OPNlmfUyGgPtne7ipW9o6mKY5/oL0n6zwIImTJB73AnH9KEfhD1KMDEq9IeNFyTu14Oe
	 CeJ4eX6XfRmC3DagDnFwSQQZzhAeA3y+qv2Lx5zCcyAcvbpd06urtmog/uVey15GI8+x9
	 U6vhhlqvy9VHpwrsWEWh8DJ+ic4utWqTnWxX9aHXvh8Bm+unk4HqdqSL6EnzyK+l1tA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917735;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vJ/bBuF4yxK8oPQFYFraa0vt5Nw+XI2VBR3EHO6KUTo=;
	b=qYg10VSq7em1KQBlKQTSKFD1Z9XfBCpTKN7dT5XSuzbDch9ukBwSYRhDT6ltRN7RH6TN
	 UyLS9vy9h0BZZMVgB1C/XFdK9CnJ0jSeHVbSm0DF+Q1pCZbNgJNCJFQBOo5KQ11H2ZTNp
	 x6KDPyGphskhmgykB/pdCmDt2MFBWWNvCeNIUFfL4/rLd2qZiVtzeH3zmyR3fOZKJYAlk
	 4wgH5fYJDfMxG0DnPEgTnzLWkCC6tFD2SGRAdNukhL2TtvOLzRsleEXTltF8IOgpuDtIa
	 m6SOgUuC/BzcOMSneQfro3/eC0eNU6o6XlTUo9BY/vu0+7+kCNDaX2UpIH278V+t7+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="I/r5cZhS";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W6Fal0j9;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF2D606A32E
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 22:28:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAF2D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=I/r5cZhS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W6Fal0j9
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id F354EEC02C6
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:28:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 05 Nov 2026 17:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793917733; x=1794004133; bh=vJ/bBuF4yx
	K8oPQFYFraa0vt5Nw+XI2VBR3EHO6KUTo=; b=I/r5cZhSJFQKgGb0u+oajLku3T
	pSxauIPcMEI3Qoug5LsjigzFbfWYFxJ9X+4I661WPeMQmGh60fZutc3IZjwp0OU2
	iTdT31pXWFDlg+eGTZ5B3pMSj5F+AueV21GL6CKFxWEJ3fEYalb0uqv+Cf9VIrUH
	FOQubo7qxJI50vzogGub7PR4c74bKMgx6PWlJWI+vLGxGjcxuACryQVZqM44ujQr
	v+pzp3nsDCc645TqC9/FdVfqZx3m3T6oSSRYkLuvYJIiIh0bmLv8/Qd49RLgwCLb
	+hiO6Hd9IGxP5oiziUkccRGsAoaqTpRwG/QUUd+Vog2XXq5WZrfyhIGSDnnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793917733; x=1794004133; bh=vJ/bBuF4yxK8oPQFYFraa0vt5Nw+XI2VBR3
	EHO6KUTo=; b=W6Fal0j9MlKuCHz2F8YM/vVT+cv+X3qGfIpiSFuGjlngKx/HJzV
	OYD5Ioumj4uzzZaZJ6R3QKUCP2dJuToPX65UfQZc6fok8HGLgcSba6A4a9+3NOuO
	WQCFWUmqBb17b0AVUnd9yE/D74kMTnWpYznhWASz2siZIKmW3oaV16/qBvCBgzLu
	YsD6Up92A/UG/mNKQmKMVuAdWTA9d5nL+T+gNdQ7hUsoMaxKja9C3L5ctOIx7+Dv
	Mr5zq+Gde7GKEzbTabgQYS7xax3BsjR+EcUYgIJUyXpI6ZL2Y/WDhHIDTSJ/it99
	hlpgZ6Yc+11HmIZM8/XLXgwU9ZhJh2r0f1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793917733; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:l+uLZ7nwH78VPtGE76FYWGi1PDMHZiWiwUSKy4iOlZcpPZN
	IPfU6U+pztdiVhbeHwIXfeNY+VzrzmaMRioOcNzX+L2ugpve8n9U/6eOqeUMxBid
	jZ11YcDqpxRjvOSmuApwH0WDku+urNsjoVJnoTdiZf/N+SjovB66FfsrQo5ijhpd
	zQaBscWDRI8H+xLvlJqIX1y0OpNawEl05Q+OcZUmXZg9kaoT3//Pa/1Ac2kG5SCI
	C3ZrjWsTLNkO2UgkQmkoRwvCbUrgt+7Eu3wfuout0kIO0uLNytl5FfES/1oGEV55
	6Ly+fTBFQjLSuv9ksrTgTDjVsW1vnR8Xe0gIAhQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:nxHi0E44AvumYLc7U0dVvlNWDCzJ/KZi5NJXBH9o6Q0=:uYUGRIxDEtIj+q+cCWT2GftwSVs8pw9kYUmg9Uxxu1I=;
X-ME-Sender: <xms:JQPtak8pTLs6Q2kDi1ijADBkezinB5fmi68kQbI4WBiFxqu-bTAxdA>
    <xme:JQPtakKIMHW4tKi-W6Pwz0lE2rZaZ5cI4Y6cgtiPtbRtBWgNg6o0TdhMKClICSWDc
    0k8BsIZFrgRUSgC9fEGua2Lwoy-j2jMptx7ChOFis2IAopAoMTy5DE>
X-ME-Received: <xmr:JQPtanZYa42DC4MJRXPJAKaJE-aqSq4y84dUom5IsgZVIgzvs8H2lyFr_ozlALzZ9X-u3kkBgvc-auTz8ckF00TFsYGDZITeDRYQ>
X-ME-Proxy-Cause: dmFkZTGP6N/zvmJhDuhLJGAqkDsTRaZT4K5hzxeDNZpDhB9cs7UWAb9PrAtmktQoQD4IjA
    zc3XsceA0cQGoNyi1BCYjznJUgGhUb/9X9WT4l/f+niFQMB9AKY75bzQbTR5sO2+0QJ3hb
    mnjs8Kq2xqLF+6j0eIQNMPodfLDtz4tki1UOor28dyK7Miv21DONsKkQTLnWfiopEmYWNE
    eXul+ixoJcr+PLu06UU45bz41oD1WD+X/1ocDXhc+2QKqq5y3r5wwmkVVy5LtDavA/7JXz
    jLrFDz1dIsh+P4RuWUYYCRWuYJaPDhZAPufm0S/097jhGvJoEh3DhRIyRMPf4naMs/uUoB
    V6RlH2Hv3rbJ86v+96/Os6XjPHL5H/EN8Q1ROUrCpSZLrLJaibpEM+UIlr3a2DysLE/rBb
    nJZKSS3yd6DGRuR5MjuZzxeSfVtRC95JkNZohoy+DufewDFGnMGGQfx6BiqIO/0mSba+Wi
    Z6NHAo936AE4geaz7yyaMDVjk+8AAF0nZkon0/w3wQl2U9Cos+m7wm1HJnyp/wSx1L+V8m
    a+dWH5HssWXcHjX9k0wEvmbCOUwF22+2scRgNawrZ/5LdEvziZZcocUXW7lA4fthAtYBK/
    gm4wXkNhxb4eGjQApkZ0yLIKNH8CqLKJtnhlnneyiL7wX2FIGdzIYRlOPQuA
X-ME-Proxy: <xmx:JQPtauIxwXGk9jU81xcSMRsVUm9QoVPbixxu0sXsoFPwDJFjamzZUg>
    <xmx:JQPtatDEzGQ9RCk0fla84CLJxEItnLVzH-SLNX8Mg0ZJ0x7IvjjC2w>
    <xmx:JQPtarotVL7fqOhDHXn4G5HjrGLDX-1FnJIO9FokfY4YoIDmjFohtg>
    <xmx:JQPtagieN4zDtjnBD9vekhjNUz8kRHYLNDE-kNM7F5-iV6QYW-_E8g>
    <xmx:JQPtanwTbnjyD8qTst1Gj9KnBy00PU0paDwBcj_tlHzzGdm6U467hpSW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 17:28:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jon Simons <jon@jonsimons.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 05/12] send-pack: plug leak upon match_push_refs failure
In-Reply-To: <20261014031347.50433-6-jon@jonsimons.org> (Jon Simons's message
	of "Tue, 13 Oct 2026 23:13:40 -0400")
References: <20261009192953.81794-1-jon@jonsimons.org>
	<20261014031347.50433-1-jon@jonsimons.org>
	<20261014031347.50433-6-jon@jonsimons.org>
Date: Thu, 05 Nov 2026 14:28:52 -0800
Message-ID: <xmqqwlqqq5ej.fsf@gitster.g>
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

Jon Simons <jon@jonsimons.org> writes:

> Otherwise memory leak tests will flag the missing finish_connect().
>
> Signed-off-by: Jon Simons <jon@jonsimons.org>
> ---
>  builtin/send-pack.c | 3 +++
>  1 file changed, 3 insertions(+)

Looks trivially correct.

>
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index d6cdbae472..4e6a45ba30 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -311,6 +311,9 @@ int cmd_send_pack(int argc,
>  	/* match them up */
>  	if (match_push_refs(local_refs, &remote_refs, &rs, flags)) {
>  		ret = -1;

> +		close(fd[1]);
> +		close(fd[0]);
> +		finish_connect(conn);
>  		goto cleanup;
>  	}
>  	if (!is_empty_cas(&cas))
