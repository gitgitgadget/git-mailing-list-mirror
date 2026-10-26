Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792991934;
	b=244b2af6oPDHd8JgfefyzmI1Mj3oxh58gy9NLkMlj4Gz+j3rm9d90S3IQw+CjBtBwIm0
	 RSaN3W4w1g6OTYx53dJXQv5t7DZCIAjk/APKnPCoaGGdFg9oJb+8KrOUF/46E6YpvaNIA
	 7OtrPB2vgI8deiuewLsy2uF45FReu6fkpjUusmzqM4dLTb6mh1AB1/wu8bxQxt193hW52
	 NxYVbkRaf9g4WxE1g/4Oj06tWUblyKnWUkHI8caMs34ZjhClLFO67KTD8sBaqaSe4NBS9
	 JppdQIoIyXygB8gYwtYaRPXWvNw8ZdYgBmPWAYzXV7kFcV2gcHjAKnnzN1FVFqlg2jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792991934;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=7JJu0fJNNPnxO7OuXvpr9W5a6so+UavC9AUdyP3VL/s=;
	b=wtcpcuksvnyb3tvShCBs7Ygjc6nUQmjXull0s0fE8ULowSyN4Fs2Vawq7KrPN4N4VnZs
	 +q0e7JQt+4XaexAdAPPPQUE3uH3HOG6J2z57caF3ogBX0s/VzC7nMtpyiZjkTXeUzY+Af
	 N4IvVyzcT42pB+ADzxLuTg5pJAHSDZXhxvHXorniQ7oZGxqFFIPsnydYljXrlmU0vdJ10
	 5s2437e4Ivti3sl7a3LfdMBalMA4n4fCA4zZ1hdSucRX1ahlpGYnfaJ2uURjqOUcgYPQA
	 Tc6Y2bc+LmwcPzKGYCrHg03/DY8p4Mzs0e6SZOnH4Z6L46R0KeFlbzl3DpcpUdSzPBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Q3H2cifD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="TRW8lc/E";
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B828606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 05:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B828606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Q3H2cifD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=TRW8lc/E
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id A0A00EC0072
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 01:18:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 26 Oct 2026 01:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792991932; x=1793078332; bh=7JJu0fJNNP
	nxO7OuXvpr9W5a6so+UavC9AUdyP3VL/s=; b=Q3H2cifD46ZHGz7nfbvKD5/Iph
	s+GlFtS27QF0xgxVo1+rA7PE+nF6a4p3AnPxQJlwh4NQ2gvGzVYU58/HvKqg4Qd+
	eH6lIWzvirjZs8PZ9rJ9vva0OUXNBjkPKDEOVUfElIFJyDQu2uI6avwthSnNCcCi
	AGf14VXe4Ihgh/OVjHFwftcEvSFOuQlvH3EonpTyyOAHPNEGD/oLAc4Uj49XruIQ
	osBrHUCHMaDUC6ZuEtUvpQu1wOOxIyljbbfSzZ8Ixe4SvqxoH4sQwnFGq43z/BNg
	RHbRet8+u7d7L7kBNEJsne102BwWwOMpmzb5TfRUQmUCaPolcg89kAROMLEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792991932; x=1793078332; bh=7JJu0fJNNPnxO7OuXvpr9W5a6so+UavC9AU
	dyP3VL/s=; b=TRW8lc/EWSxE9Lc3k4SO9YB9EYfcG00dhO/E5p6Yc0fwkJsjS4N
	+hfMiv/m/5qT0Yo05LlSwhRCv9q37AwZi2DPMXnuTncBQtQPfpNquVKX4nx1Zz+G
	pjqBxzH5YXPzp0VNJbfsnw7rtAbaSTy54/JP/CTMpspUf7kdrZ76CBUFuaxbhN0F
	4pJOeojhWdjtkNlUYDcLVQ9ZNV1jMuJhrjy8MfXDSaXs/K374DasBXPSF27XWlza
	5ocDRBXZ5gXGrff3u9jGIuPeMP6B52cAOnvcfrW+ZXeE25qblhGpjZ7yEIpo9Vlx
	EqZtlWiVMLkswBcHvFaGM8Fcwt1A74bEFBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792991932; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:BLaGnPZ973sOjd5M1oDwixxOBCo1uLRd6ukhgCcjsa3s1Wm
	1UJZa/BTbyPRhXma6SeEY2cFMFqFvk4hzsum7nZZSXmoBHrpPY5IKjTK0a2Qf1XP
	si+p2IEDk/Txh7o86+GdeFW7aC4s6S4HYkgRGpN+G5WyT3iqpfoObw5KzAse7Tou
	AeornhGlAgYIWRj1YaGgBalmpcav6QT+eejS7RytELWd7AzmicFMEXzOsqn8RWQt
	FXfLOa6nUEkmeAtAv2nk7FWYh119bgCrthrDyitU/ORwv/sImoP6Xf1LrTx30XM3
	EZyow2CTnTdLs+H2aWEisOwesnmw08ek7F71SUw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:srCfz4IJqGAodhIoNRoB5ozDIMHc6gLgZoeXXkCJ44I=:7JJu0fJNNPnxO7OuXvpr9W5a6so+UavC9AUdyP3VL/s=;
X-ME-Sender: <xms:vOLeatX4Xr9MCeWmAW9ljpadb0JWYmdtKkg7d5DOz3_Z864Hx726TA>
    <xme:vOLeakkRikxKh52AHtts1VE9vKs3HXm1q-txQVf1zjayWhqbbxNa8LvLcBWNQwbfi
    4-fTlAj8XkPEAL65abKPNqeHB-rkczAElSkC3_mfxbIrWZUArjVXgI>
X-ME-Received: <xmr:vOLeaub_hk3GqIRdY6DYlKZ20GKdJDG8JHhvz4z7GSplBTY1-HURRvRoaTJi7-b9dXTi7ODuAYvIgoBSAmrNcTtuebW1wV9chKmU>
X-ME-Proxy-Cause: dmFkZTFWc9gznbzwE+B67AVmLs1t+Ky46bqTOK1b0TCyL11Eyu1EIL3uJMwHkj2GHTaj+b
    6EeOPxV2PWjO8u7T7D3XgliqPwN5+DAsNIdzNcB2eBN+xhWmuBByGT6ClTVKqOgpcoYlUy
    ItRq30NyIxhOuRSabZv6deQdI1GUwTmHKp7vODEH9Ada8zA55vbXahKjnuBj7pWaqJ9bn6
    AOJ7Q4h0fvXPPHWdiGE26a+tax7mNZMNHIyL6DeUJZlYjwyoU8JMUbI1wooSYd3jIibIte
    gIs2TEyY43hDbedZ/3jLeXCYbVliztkarb2d0wIalJBsPVVbKHrqwAomTVfSxPiQBKEcLC
    CIL0slOVqQ0fD5dtYWsHuBSw0WmVnjgYcX17gnR7KTTCGCr41M8LRn1O3HP7eOPaxLLEQl
    SF4UXVqfPox4XDXODZbAmrq/vU1qMmdBdKCFex5vZG8YRaAwN+mQgeeB9IbGc4mACMUWNN
    sh7yqbZbMvcvfJwQ89yhACt5dv+cG/i/y7iXIrO7HcHyVeWlRo+D0SQXxAe1foda1RSsJY
    93wRuQ27GKJui+qy1LO6SwTSyhMGySAnws/hc0jGVEKKf+UgCjWhz3v83VcMZkfJCGfmFD
    r9kRPjoMJZLvSG/kN7+7rFvsNA9j2ALf3GDEUnnscmKtSZ1X2ralX5Vlo0ow
X-ME-Proxy: <xmx:vOLeavOmi4G1ljqfGvaOdoB-4G_dZu5dZthKEuNAWG5wA3JDRVb6UA>
    <xmx:vOLeajadue9BxkRRxYfowi8el0fmMfMHcojSrGWoqJYSO17AUCq-3g>
    <xmx:vOLeat3BpOW3j-km38Fx-Luhg2iSmJ5EO_OPM6DZkLI9DF-iQzuQow>
    <xmx:vOLeapcs-rL61_T7g0_sVajK5wnXtnmCe8t6__ghCZt355s-WxcuNA>
    <xmx:vOLeap7BTDv6kjIh-Wg_75ef07F-Mu1T2SCnZb5DZBOTUyNKZdae4qNt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 01:18:52 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Wasswa Edson <edsonwasswa54@gmail.com>
Cc: git@vger.kernel.org,  Christian Couder <christian.couder@gmail.com>
Subject: Re: [Outreachy PATCH] doc: clarify promisor remote fetch ordering
In-Reply-To: <CA+ew3Ju1N0bCFkTzrop5+ckNCrgGWRzMcrLHu7DAYufzw7Gncg@mail.gmail.com>
	(Wasswa Edson's message of "Mon, 26 Oct 2026 02:35:27 +0300")
References: <CA+ew3JtPJuVNC0PR_wY=8Wxp4-JpJ0wCPvm+a=BdJ33QaMpJMQ@mail.gmail.com>
	<xmqq5wythc57.fsf@gitster.g>
	<CA+ew3Ju1N0bCFkTzrop5+ckNCrgGWRzMcrLHu7DAYufzw7Gncg@mail.gmail.com>
Date: Sun, 25 Oct 2026 22:18:50 -0700
Message-ID: <xmqqy0blujid.fsf@gitster.g>
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

Wasswa Edson <edsonwasswa54@gmail.com> writes:

> ... the implementation
> already has safeguards that prevent arbitrary injection
> Then about the Git server my say is a No, coz a server cannot
> arbitrarily inject a brand-new, untrusted promisor remote onto a
> client by default. The client must explicitly configure acceptance
> policies before any server-advertised remote will be accepted.

An explanation like the above must be in your proposed log message
so that the next person who looks at your patch do not have to ask
the same question.

Also, we frown upon top-posting on this list.

Thanks.
