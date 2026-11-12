Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794521891;
	b=j61DutXaRlCduP+NWmXQf+CWaM7MDBVV50gjiOh2JMOnOrW9P++DhsjBxSoV51kwz+ul
	 jr2zBXla++0FgxRUWpzmPvY46VV3zmIZHJjBQUPZPj6cP2CmO43qbOpPme+IJZGMdoamN
	 NDW5hhlAaWrqU1aLM/AI12zwyhOPvDA12XFBHEuCsVyPlg0n257UWiBTUuEeIfpywhxvS
	 vr3it8B84H/VnyFjifsxsb2yoP3Cce2plf24aX8BZIyHqEDhRRNC7HpBrrVTtdzBV2EGG
	 qg0kYghIqW8hX+d3GJfYnB7weH2MHpGL+0oDFsG3wCPTlh3safqfKFh+ZXc08zF2rNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794521891;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=MK6JLf/uvpUnfxIY0oeKi7oRHzcMn1MzLsYpZmQjU0I=;
	b=abbejvWbGnx18I8G8g3CfsKM5DjjuKEZDlDmojGjZTVr7TnTCy7JDvbVIs9qrv6rjRmj
	 7IVHnXnCqeoDnTQ1AumsvkSylSkzqEUAe1t4rBMQKwVQVab7GFFOWkDDzmkI3bJjvFpJo
	 IL0QoYnWnfFGlZudIM1Hzsin8TwGecSu7FSaXyecWIjFibBVAOhDUwjXGl7BBplEYv0+M
	 oXdgQShORLFEx+z0/7yRDTcCdQiypxog2CTSTeilSK/jsW0UsYl+MorkyL9Z6LdOlslKm
	 O82qk/Pttc1fc5mhAuFikfNcwrTLnubCDjtApBAaSv9ISeqetLmuVzuevVB3WayxYaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=b0wvoJ9Q;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LAynm8WC;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB2E606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 22:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDB2E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=b0wvoJ9Q;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LAynm8WC
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E1BFE1D005DF
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 17:18:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 12 Nov 2026 17:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794521889; x=1794608289; bh=MK6JLf/uvp
	UnfxIY0oeKi7oRHzcMn1MzLsYpZmQjU0I=; b=b0wvoJ9QH10xGgi2wXqYZeXxeM
	2hfptqrWyW1bKw+2SBoE2euz9xk+8KR0mNaSFqBIxtcpO7Wgw6uWhviedwenHEaA
	IaCLfJaOkxgUqnJnGrAryxzzNuvoqzQRi20Ho/piqIkMODo7ZjSj/EssU7nQf31J
	WGQJJkDCDPjXrQPLX3Ret7tgUQT1Zb4zrvV0Tj1RVMh54yGZuPDOo1FWMBwePP/K
	K5me2cGbJlHXD4vkB9atYkIQEFVa/u6rex2aKZHNuh95/tb30W8LXqSRrMMT8/2M
	fxCa+OCnf2bnsC6XRpaof9H7BJkHrLqojCFOWRq6j7SxK6kkm9WuiqFkaGbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794521889; x=1794608289; bh=MK6JLf/uvpUnfxIY0oeKi7oRHzcMn1MzLsY
	pZmQjU0I=; b=LAynm8WC6g1RtUFUdJ/2KDCNtyVCecK1Cr6Vcd0/UjsjvKDC5n1
	0c9lBfTNy4IFK9dD+bxzJcyJZOqfn1d9ue8DOttbKWki/uw7hLkyPuNzO30kHHp+
	AYJeJ6OOrgOejMV7u96wBPtsLNQoYM5ps2mowEFMqKpZEcVspjtQKyAUagtM3+Ws
	XGdZwgqQ5m89In1gFCK2J88WIh0C7GzmBscIrMAeGz5VmKpOFt3VpnSgBkRLO55g
	ETM3SIBRBD1rCKiidj45NZM4gnDwy6+50mN08MnFsIBNCrO+OG7oo8DdtFRQ6aWZ
	r5PxhIu4scRAnJO21TA2nQWVhJ12spPwX1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794521889; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:T1hJ/I98NLxOdy5zkt1DKCIV/ZKZRQi8Bb+4l6Bz/k6S4uX
	IBplrytSQ4Hyl8xfxTIi6tHRTPZKPv6GrjD06mygwHtd+e9J+B/gpArjvaRuJCRY
	knelgf0zIIiqL6Ze7bprtBYhQNzC2F4D57qxLkHFMH7vNJ6OZpiJWQRLvWsSeRw+
	Woc8crfQhUIxaiEuRo0F7WpZyAZDwPIw1yjkzEki+M40DkYXYGZzS5jwSy/eXedz
	eK4dfSfmkwCCFkz0s/ArK8jMLjzxuJKRDe26BFHF9gGZc/DSAGeJtv/RLGOkzJ9X
	BUXWhz2WzRhsQFw1GuHxWO1euz/ISkAxdHH9Kqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xNp71SiF7OjhN4hhs6DDMa7woXatwOLcB7SFEj9xD9o=:PmGdAN6a+tHSbdxyam0AI0otZddpVnEyBEjmJ4h3Imo=;
X-ME-Sender: <xms:ITv2am_iIlm4RFeLRsTABZqWGBOTyO4gD-7ZpPAaJlIU8kv4p55trg>
    <xme:ITv2atkJy2b7H5p-hLDJSyY-_zMrgvm7fjjBHkIonBcJ-iqELgeN39sfT3InU-kz-
    SBNDeEmFAzSQgrUMnecOmR0BsL9cPij5D3oXlh0XdX7giT2UqeZCA>
X-ME-Received: <xmr:ITv2akW6ahTnMkON_KVLh-nKpbPNs_ZdfMnSsqsEmRkAJgsL_asFhEehZgNKyAJ6oUf6MbAc8OGWXqSTXao5IzVj4xxsZO72ID7F>
X-ME-Proxy-Cause: dmFkZTGWQIy34+0RthExV3JKgpK7z1EHfHY8f1UktNGypIRSjVTrJbbJCbLmO1wfdtwlez
    8M+JfGiX2+zOvAvRFUqfQEUP/+xniLJclqu9zA9RusjrfqGdUGQjrTkdV+kZqnuUXQ3tAo
    X8DXvRijUiqjcZOY9q7L9E5ixDwLas0eRt+doszzNnyiOa87aePYiOpa0TGKF1tXmtpwXl
    nV1WXgVV+tl+jgzWqbJsZoiTiVqV3CgRXpHllVYbsgQWOJzVio0BTlr8QI3TCCBkSOlggA
    vPRCJpvuIzqsLSLXu0mySZfJpnAwCl7Pu77E28SHnKP15sgIE5O5HUXXdQJ+DhmYDHg/pI
    hPCAhBlLiy51IQ+zdn/q9K71DbOEgHkVtbgGQ/svcJXB4AIBbFyszec1H0wzreAcpe7pWr
    wEdD0xXq0FmNwG6VjD0Kvb/66sCQ6ienhK5Ps/8FlH6W0iAGH8t7NVk2MiD8djtDNgJK/+
    vLNpNvQkaOyKv99YHiPC7WFgcnwGpHoeVcA/3oO+YidqNW2ER2sokfpyZna2+v7GOV/unj
    Zdpt3Brym5KyaNA0OV5ogOBzdI7bxMZpMV2FjzRgpFTJTu/UH6UPWGFRLyMFMUbKg6DAga
    qTrAEiypuM7ExKkEI6Ln/r2RWIrre9o9c8eQGaScJfZqD69mRm/HgddNSmEQ
X-ME-Proxy: <xmx:ITv2aqF3CKiFTaO-Y5oa_ybyACc0lG-bnFmEZHfNa1uE5r38ncBEQw>
    <xmx:ITv2aodSl0JnExzF7YfXi6N0xlOcfCHHjHXd1EToJnpl4p83MSkXjQ>
    <xmx:ITv2ajLHA3m7co_v1dPqiS-rcASIGnfeuR9P5O_MizbUTL2Dx2DAOQ>
    <xmx:ITv2alEE5D_ryrtRpTqyRQ-qtvKiUa3kGn4YDoM0pc7lTxZsCj7b2w>
    <xmx:ITv2aqB0MMur6Hh3a3MJ2xXWgHYSMzLQCbm1xa0Ukke-Kz7nZfemXQnp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 17:18:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Matt Cote
 <mcote@nvidia.com>
Subject: Re: [PATCH 1/3] connect: let write_command_and_capabilities() send
 a promisor-remote reply
In-Reply-To: <20261112195858.53788-6-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 12 Nov 2026 20:59:00 +0100")
References: <20261112195858.53788-5-christian.couder@gmail.com>
	<20261112195858.53788-6-christian.couder@gmail.com>
Date: Thu, 12 Nov 2026 14:18:07 -0800
Message-ID: <xmqq8q2xhexs.fsf@gitster.g>
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

Christian Couder <christian.couder@gmail.com> writes:

>  void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
> -				    const struct string_list *server_options)
> +				    const struct string_list *server_options,
> +				    const char *promisor_remote_reply)
>  {
>  	const char *hash_name;
>  	int advertise_sid = 0;
> @@ -754,6 +755,9 @@ void write_command_and_capabilities(struct strbuf *req_buf, const char *command,
>  		die(_("the server does not support algorithm '%s'"),
>  		    the_hash_algo->name);
>  	}
> +	if (promisor_remote_reply)
> +		packet_buf_write(req_buf, "promisor-remote=%s",
> +				 promisor_remote_reply);
>  	packet_buf_delim(req_buf);
>  }

This function was designed to have a fairly generic "here we send a
command and then capability exchange based on the settings stored in
the string list" interface for extensibility.  It is highly annoying
that we are now adding a specific option here to be sent outside the
framework.

Isn't the misdesign being corrected that the "promisor-remote=..."
string was not sent as part of these server options list of strings?
Can we fix it without contaminating the API like this patch does, or
is it too late?
