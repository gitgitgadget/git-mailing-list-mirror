Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792609274;
	b=hhNEUOLjN03C1TJDtIwyFfh/85wnA6sgPh2OrQFM61CUZwRrZiY8E7+J/U8jh9f8Nsk5
	 j52WcIr8nJjm+zql06ENUCwlAU++EcpXgljVfid5ej+Y3SB54Bwqh6baTil/Xs5H4G2dV
	 p6Y58uhLzdj3JstpaiTWcLllyV8w6AunLu+6sD5hYsJPtKlNXN+ww9q1CVmxoS3EY+GVd
	 yjPB+e2dN2WL37F9NRv0kK3J4dKt1khFBvQQWDfbwF4d+6q9c5AYIkoD/1cRYgHawIyDB
	 g0YycCE4nivjtU8qYN54jBJnwdwJ1OddlU299H9DiRCXsyfTL1GO8qWsMj7gThkk4VA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609274;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=PP0iJYVGAyDHnuQ3ew//P6opdjqJX2OD4t+LXaR3f3E=;
	b=Yi220I5tQQeeRvxpxlinOcsb8a5bDEf7TTY0Va3Df8ikeDTQd7c1FcQ+Bw/cnYm+1BDJ
	 glxwLq4EV+7SN7NqS3jHtIP6sd9JZx3DWvFj2ZcKlzhQGUf+6VIy57GcALAY1qUD4QXQW
	 a5/p73SZcEvJKRaBO4AWgJ2vc/WqEK/hN+SAQ5ctIhuhPB9v0ODoID5YgVJPfNZWlkEVT
	 im8Qunvg5qjqTCNTwBph/XBXB7uUp30Gqndx02VCTZss0pfv1dtBsiZVQTZxNDiqVPpjo
	 xlGET19Xq9CbZH40HKaWPnq4ZmjbuqG9zMjsWOTK7lMDynliAslXbPw+lgnHcg85+3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MC7+hO+X;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nDYxsHnS;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B869606A31A
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 19:01:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B869606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MC7+hO+X;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=nDYxsHnS
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7F5527A00EC
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 15:01:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 21 Oct 2026 15:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792609273; x=1792695673; bh=PP0iJYVGAy
	DHnuQ3ew//P6opdjqJX2OD4t+LXaR3f3E=; b=MC7+hO+Xcq5S/bs3IkXRDORJ28
	zQmOHUaeGC0xXmD7ljueLMkXS8tukw+qD22w8AIefefqCvgDcO5IlllvjqoW63Xo
	GjKZeePE6/UuaGpd8DRclJ5muZ5q2KoF4j8UUGUUccV79j9hy9aKhXQfJhUNPNy6
	jVTaHOPnPXai5X2hzDeORZhErk1YmopGrQFD50rs9stFRg/zYQsnDu0GC3o/c28T
	4nWsEYTtwj2HhAfYzA6PwxWuc7Hi4CxyX+8CSW1Ls7a0Z+urZoZEikOY4YcL9VEG
	uuE5HNR8U8jg4mtSQpvVPKXjvXmPU0r9jYyI/iG7ojMgTT1e2JvkDHZKOAmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792609273; x=1792695673; bh=PP0iJYVGAyDHnuQ3ew//P6opdjqJX2OD4t+
	LXaR3f3E=; b=nDYxsHnSi99z9ZXdThS5/TLI6qR5OmIwz0Rw5jXR5Nu0hFQnXDN
	SfeYE/oOu+OfjmIj9DG6cjVOkSOKrWx8FLr+l0kLhB1KTTnhunnjoWdWI+MqrkEN
	vuYla6CBX83YgkLzO+tmnMO7u7pzNOeRurB2jk348h5hN4bBkRBpAB1uaTtLqULc
	J6DaimLSds67OUeirnOlCtD7eOLT+Bj5sDIdgt35h4ab3fokhJgibuv7HUWFXE8c
	mC+xT8WH3KbN3Vef7zLGhS5phIB2OFRI4X6uE0mKBv7LGvIHr5tVscqYQ2/PzZ9U
	9dD7G+fJQG/JC0AcMBN7lm9/kFI48iVlCTw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792609273; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:JFDPUwPmbzMbIkGvWoy/89GKcMd2qN8pIncg+1rrABN5ttr
	g7o/SqYxM41oStCc1DGThaOlTFA4of89z9b9DsGdOcgb64AVHMzh1T0QYWXSfEdq
	hxYHwXrxgOPi9dd1iRQl+ETIV7qzN4tLBarL7qR1LxrH2sqhpw4PONCuwz9nVgtU
	+WOq8ZijC9MN7cprEks7XSV77V2mdWQgVtxEP0sUZTYbuFuuPGZlr+W6VyG+hz5c
	C1NCU/gtAaIFbKvEaVOD3rSUDt40NBaGlJ870nKkBNzS4U2JWFmk+AI63BNphOSt
	5GnBqoHT3CZdEaauZIqxC5w8s+SUPY7xVuqPV1A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:IMD4SpxLNHFNKg3Tk0Utrm8dYSS+qxtbMGAOGVRnk5U=:w96SVKLWVLxNGRdc/0k5HlSXRng73sROPym/5gf2LOE=;
X-ME-Sender: <xms:-AvZapi7-QpLtZEKom4tIf28Zkl-uk_sCEuRZ8muPs8pXCUs7uIWHQ>
    <xme:-AvZatFqaFmlHhoVL-gs3Y6kMyLCWwoZrnrdXQnDuw4LXoP-glUjPppTR_h22p_zB
    W2zaB9E7VDdBPWre48D9WuBqs0p7p_w_VYhb63Zwo-oMTZtiQ3w04c>
X-ME-Received: <xmr:-AvZavT-pSu4NMoj5epPsx4-12PIDBdFh2SQb8XUFmL2DkuS4rfE4nqJgJLq0hlLTpjz3gEqoq_5BDnE-QPNis8Z3IHlTYlelWnH>
X-ME-Proxy-Cause: dmFkZTFsuqjdVnfv+lKqB7euGyL0Cd82fhnJvMVpORSSPiMwrxeivn8aPbtbh0X3tbUqmB
    rV3HEuGig5RCmgCUnwiyAK66zwu7CVcm9t8O278Ad2Qv4PJ8SKlsKlG0W90l/ptjK0zC//
    e6FN7tHPNR5/zrmsIo+K75iQt7evyCZuQLgT/JbE36snNdLrAIy5OjMhNXISTYS0uMm6QD
    EYdHtsGXkTPeS3DWzaeKHoXTHfDr9UDu9XXuGRoHlHF0CPqtNDe6MdN52zTuKqd3pWhloJ
    RBBxqsXAOdC9TKFKmbQKOV5eOJtXfI0Z6AAUXmrkl4Jt1tPjB1EU9OPB/lqzsaiOd3DBA5
    P0MW8IGrrfLPbIgrqdaMKI+JYQEIFY4eoxMDVI3Yux44HcgOzMfHFGBmoebRgrnKguxyQi
    n1u+y9BtPtVTU5BTnHY0l+/ssUAX6coB3lDZwOOhL18qpZBvvq+LUA8lnwr6wGgmSNRp3a
    bC0mKNv+e/6XqAfjpeUkAxXvSPU2Jzg0aIvQR54OxZwSxW4r/4ksgKYbACosJXzhDNJIKF
    yR0ECrjdhdaOpJbPQInG9bomo4VThwC+7fjBeNFX4USYT6rk6XGSZzeSDet32G2JvZeDNs
    d/9MgSrvjWjTwxceEck9abptw5UhTZl0kgksAMGmcZmihhOtJtb3qb9xNIqg
X-ME-Proxy: <xmx:-AvZaqzjlc6Ig8FZuqahr_9oYugvNkXR4kAYgzGhU7-ljmf0kxQBDQ>
    <xmx:-AvZarcGLdO_JX174rr5zxWS_iwvy5Agfaf0zsbk6m6s-colOqTWbw>
    <xmx:-AvZatNDoCGtxPTaCjNjHWsUVCIvdQWjThAko0yUvd6FBJ81W1d7lw>
    <xmx:-AvZamvDc1HbVeaQHnCF1dV9osqj7BgxsbmiPCKGRLcAiw1CNtVG2g>
    <xmx:-QvZakvsmWwkrNYRCQBQOqytzNAyo83_f0vnEenMQJrGFuzzGvPAiVOR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 15:01:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  Patrick Steinhardt <ps@pks.im>,  Elijah
 Newren <newren@gmail.com>,  Jeff King <peff@peff.net>,  Johannes
 Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 00/13] SHA-1/SHA-256 interoperability, part 3: pack
 index v3
In-Reply-To: <20261021063245.2917625-1-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 21 Oct 2026 08:32:32 +0200")
References: <20261021063245.2917625-1-christian.couder@gmail.com>
Date: Wed, 21 Oct 2026 12:01:11 -0700
Message-ID: <xmqqzew6naiw.fsf@gitster.g>
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

> My `Signed-off-by: ...` was added only to the changed patches.

Please read DCO again; it is fairly clear on what you need to do in
cases like this:

    b. The contribution is based upon previous work that, to the best
       of my knowledge, is covered under an appropriate open source
       license and I have the right under that license to submit that
       work with modifications, whether created in whole or in part
       by me, under the same open source license (unless I am
       permitted to submit under a different license), as indicated
       in the file; or

    c. The contribution was provided directly to me by some other
       person who certified (a), (b) or (c) and I have not modified
       it.

b. covers the ones you changed. c. covers the ones you are relaying.
You need to sign both kinds off.

>  - Patches 1 and 4 are adapted to `ps/odb-files-alternates`. There is
>    now a single `odb->source`, so `odb_map_oid()` and
>    `odb_write_oid_map()` just dispatch to it. The files backend checks
>    each of its object directories in turn (main directory first, then
>    alternates) and writes mappings into the main directory, like it
>    does for objects. The `read_alternates` callbacks are dropped, as
>    the topic removed them.

Thanks for rebasing these (and all others), and

>  - Patches 7, 8, 11 and 12 now also add tests to t1016 for the
>    problems fixed in them, which were not covered before. They use a
>    new small `create_compat_repo()` helper introduced in patch 7.

adding tests and generally polishing them.

