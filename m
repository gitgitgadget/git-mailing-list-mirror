Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204704;
	b=5c2CNGy28Bnh4VDs39nmy6eFIu22DJlIs9OpUkqEW4otHvrYQEdEMpUSIVn33KKU8zlZ
	 aaKP3yW/AzyHoCMqQP+0Oc7Qs4FHxhbFu2PVmh78fkZ8RA/I8kHKfylmK02453YO/dLC4
	 IRxbaj6apRh6SyMgEXhd7uZLMlCxT31yRgO+bAcwaB3MDJDb/yx4dBs3bvq4mI/M7qdoM
	 6m4bQWgGkpqNhbHKiGec5zYQMHlPshlNo7UHUGNm6SfEx9FhFnFRfu3tmDNtSRPkdHIfq
	 aMLkVm5b9w7tagQy9TFPWNGwCVBbSiWmKVIEqUGAfLQty4blIYaVBuQUSLN69DmYpRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204704;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=8XTt6xpB1FDMJ/g7mh5Tgv7kKrwUkXBSO8nn4BJhVH4=;
	b=CZMYrG/LlGLDsLh2EuG02rprVjTykXJ/bVV+c2anGhTnOV8b308Ry5sTPQEw+g7Grm+x
	 OpOKYJw5ma20FYRlqkUDqy/9ZR0ADP+ckTpEJDtN3hbsKQgkwONogTcnt4izPm93honXM
	 7QwkBwcHL/9VZEUiBBh6q5d3/1Pe7K7vzWVFZXJXQF6gcPhICORab+r19YWDfuVQS1fTC
	 k3vJlJfe7FtIzUrjr9nHDoYwMU2iZLwblMAmvMUDpohMsiZKLEkLuGnQ8xMZcSP0j5dZY
	 fCW/LgcuvEtYRVANWEf9ZK6jJBXrku7C1k6ChCAnchRj7tXhVMT9QVDL2NqB+Ga6Rxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="HT/By2Pf";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="tXBHWd/z";
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E7C606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1E7C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=HT/By2Pf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=tXBHWd/z
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFEA07A009F
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:25:02 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 28 Oct 2026 12:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793204702; x=1793291102; bh=8XTt6xpB1F
	DMJ/g7mh5Tgv7kKrwUkXBSO8nn4BJhVH4=; b=HT/By2PfAbfRoxzm0EwThtMgOh
	Vp+sdhbI8A/QxSxlOAN6ggYXCPbYePKreKYUZSAbuzJpdmqzCEmx9oMn52BOf+ar
	lL5mwyavoSbLuuCO/XihU3M/JBHX3vjp8F0TtrxuNTqj47KrUzDHaOD+s5NoqAcB
	hjk0C2v+xXkpjXlNUEXiYiNqXxqfYGPH1yRKQkimah6ujZ5pXUlIXguXBbISUw/r
	Zv0SisEwl3dFjGpMekfv/zEsUvB1oVQMDYXewGiGp6fXPMpjQx0I7Ah7CDvHTqps
	R9MJkFh5gGoUxrAxlU6L+48vNbsrOSuCONfHZ4klVAlpj6LroEAKEgiqIvYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793204702; x=1793291102; bh=8XTt6xpB1FDMJ/g7mh5Tgv7kKrwUkXBSO8n
	n4BJhVH4=; b=tXBHWd/z8nOzPOnPgVDB4cWk2d39fINdJPkkfpPrmUFE+sqU88E
	47WZ1GFhEYex7QVLU1+IahqznfeyV3FgALL5BN05GSPOKt5XBY+AWMl0DwpQk0Xj
	em/oggfYTZuiJEIEkyyQnUoPdgmJfq030YE70JPqz/uKdD7hsihsIAIB9DCmMfmj
	q5zDiZ8tUhJ1ru/vCJuHOm7c51X0suV/ugJhs3AQBODpf2kOw1hqXmQziNCIdXLc
	4i/bvXJEnzQnRdu4Uo9l0VfWKHV92LvJUE5azP7ltvonJ4MfaLuIw5r9A7s8CLpk
	UQhYj+SeYcWSZdn+yml540N68QsiInDycHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793204702; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ba7B7IV+cG1d4Vh4zZMr22iSbaCByO3qcMRr0syEMpU1yeW
	ortQ+b6zIwvxNGEFkWecgNrjWf+G/dF76BH3F+NkbnPnLpqFxGVKlwhrXFhb1k7v
	ZwAf1gw3U2JkuaRMGX1dE179LpN3tRiBeIF9nypMYslaxtqfVZEdfHeYZwyXmmL8
	VYbt3out3ztFFRpUMclqRrsRubUYzvCoTFS99hC5iiwK2D+MfpjMafC2Y7UZl24v
	SHNpGUV7EInn4L9cPPppxbzQtXS0qObplgGwX+X2BEigV9OWI60JXb7asOX1Dmq6
	1L7YMNX/u2cQRScAb6X+mmyOhBRRltpbZ9oDLow==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Yq2yMBP0TS1pomyz8ZU6BEhRrOc3/NSHPxG0CAspQQo=:Pw5xcVp8ZhAflstXgOv6jc2l2j0oTRzolgOlZZmvTTQ=;
X-ME-Sender: <xms:3iHiapANhki6eC9PtTFSIfQAOTjMyCIL_Ld4ha-NrgwrtVZ3PkZnEA>
    <xme:3iHiau8d1WNtfz_S09XgEVGgv_PU5d55mQuVcE_Y0TQIOH6nazluoToA6-fF9mGEb
    brpcA_R7wLiBlQbqiXEF6tdB-w5CpLgTIA7BPDT8oMA_XCeULIY69WE>
X-ME-Received: <xmr:3iHiah-BdAkhRK3O9CD_LqE6Ns6l2vPWGp2thKNxfvgITStZ1VPr8SPeFpwagc8jyqAevViL0KsXQjR8b6FN2Ize1qF0ohuRICog>
X-ME-Proxy-Cause: dmFkZTFiyXKhX9CpOYhjacvX7Ne2GcQ/shc0a17XK0GmHKYCGDCzn6Z75iOoLoSCueqcyB
    60ZqGHtDdFmd5hzPyG16L/uQPh/rvXhRD/d9+hK7/EoWWPhVX0kjsuvoOzZ5leOZdOkMuA
    /tqUxhb7ddsNx55PbODR+08YVPML601gglZcONZpU8GvexyGXs+ZcPs2mry91sCrwkQ15y
    c/Rl+kZgO1003TYjKMYGlo82qSqctGHckO2QpIGLwTG1g7EccY9a+bJdpFRZo3jrZ8wTb5
    1KOBC8zIe3MkjfYNKPsuopIdOjYV0nFzaPD+4iRkfNb/Jb41rKqLZAzvOOHTFMY1D1Gjbh
    TVnWwobqxc8R0aXvGDijdZ8w70UC+dMKnyitQ7xq3J58Q0pX74fX9Baki7+P6jfRXSZOOa
    1OXcVNnLNmVjrYWxLyhzLk+3AkgbPw1IbYDzqxBPTZpmOxUXZAAM/gGu2u1VpyHH0g5urv
    cx1OZ7JUNLXJECRTJ8P7gHrQHgsGwdKvu5Cy4o20UTxPzDW2T95qy9K0BgnSAnKfSc0rsd
    xHHRq9n5kJyaHUYZQi3M25glhPR1ISzjGvYUbSvcnwJa3gO3Jm3y1JRzCXiI7+zcfUYiiB
    Z/Zdn5ExV1f894J8+y5k7nGby6fUMu7MMs/9q/9zYd1vGdxK7ZLHdgqf+UzQ
X-ME-Proxy: <xmx:3iHiatdX-4V2PRMK2wxvnoCGJto-2ALruEAaD4Skv_hJeL5D3-fA7w>
    <xmx:3iHiaiEMhbNoiXfMzvUvjvv31yyPRFFYl9s2D_gTAwra4OKY1feGjw>
    <xmx:3iHiajdRic_6sYuFQeRqKTxbi2mIL7BVHvi21mrxGPwXYed7dVn6Gg>
    <xmx:3iHiakEI9rqaKFhyKqL36DfGis_0szrJ7LWQc6Bslbz2vOz3G7OLDg>
    <xmx:3iHianEvOeU3mNiDZt9jgseayAMkl8_4i-BqClJrmS_U7DFmRmaVgL_9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:25:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/12] rerere: rename `repo_rerere()`
In-Reply-To: <auGzRmkt6Mk6peSp@pks.im> (Patrick Steinhardt's message of "Wed,
	28 Oct 2026 09:33:19 +0100")
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
	<20261027-pks-rerere-subcommands-v1-1-d836c36ce0c5@pks.im>
	<xmqqv76mj563.fsf@gitster.g> <auGzRmkt6Mk6peSp@pks.im>
Date: Wed, 28 Oct 2026 09:25:00 -0700
Message-ID: <xmqqwlr1bxnn.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> I was picking "record" because that's also what git-rerere(1) says:
>
>   This command assists the developer in this process by recording
>   conflicted automerge results and corresponding hand resolve results on
>   the initial manual merge, and applying previously recorded hand
>   resolutions to their corresponding automerge results.
>
> But I guess your point is valid, as we don't only do that, but also
> update merge conflicts locally. I'd pick your "perform" proposal in that

Yup, the description above says "recording" and "applying".

> case and rename it to `rerere_perform()` instead. That name is somewhat
> vague, but I guess that cannot be helped because it actually does a
> bunch of things at once.

Let's just call it rerere(), then.

It was the original name for the operation before it was renamed in
35843b1123 (rerere.c: remove implicit dependency on the_index,
2018-09-21), which taught it to take an instance of a repository
structure.

Going back to that original name is in line with what I said
earlier.  The "repo_" prefix is a mistaken trend, and once
everything becomes free from the_repository, it would become
redundant and unnecessary.

Thanks.
