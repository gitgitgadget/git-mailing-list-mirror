Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792507041;
	b=WO2bjVhok5Rv4yLcOIkAgPFSK5Ag428gSDcwb7Mox/wE2jgVVs4PE6pZi2iwl+43yw0x
	 kr8i4G8hQE8bYz2y9jenWkPdoVS5xzZRBAbRDtxKBXD4HGbNXYFVKp91fwsomy3jRngkt
	 x5VfWC5VE3rWvhnQThe0CxVIlfIAaZE1NYSYqZbWyDCdyWi5vlIFMgi3siTqpCHEp78qn
	 1ln99Th1RK4FkulUYNbX67yb8YNdN5cqMQ4qhu3m8KD+GDxD3Y1qmy2m7L89QygsDay/U
	 Ewm37vIDSTVPfLc6COIjnKmow0nTmLJYTYX83mf6GbNFi8DDosr91fJpwteL2V1riYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792507041;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=n8EZOmoqLqnG720OVWoIjVLv6dzVUfu6c5V80B/KnOA=;
	b=Y5/KWg1aKwx40EDNKNY8EcK+H2U8ro3+LTfW0JBRSkLLX7OuC+yZX9kf8JtxZzY5B79u
	 PAIJ3Pvub0FGpWqPDMMZy+7VsQfZhxNUsyVyVMOQzXWjITkTqkXN7pNS7lM7Z4e0EB5Mv
	 WHRbHYBVM28DvaZc1MhNo+wR0IbDTYRwNVqyMPeWVL7qcjoY8xMpPiw5duMaLpAiFES7b
	 Ho8Ghbh2cGQoPJRxtRmguY2+z0CY7plSNgS9mdty6PWk5R+qSgWAlmk/QvBu6TwabvjiT
	 Mhlh1L5gQdiUQhTqQZEAmEp8ZmaLIVcNdJJEpjVN95JRfF5qhs8JUsjGoUgErtiR8fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=n973SPFW;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="m/OUMgOf";
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7E9606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA7E9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=n973SPFW;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=m/OUMgOf
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A4057A0120
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:37:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 10:37:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792507039; x=1792593439; bh=n8EZOmoqLq
	nG720OVWoIjVLv6dzVUfu6c5V80B/KnOA=; b=n973SPFWnvvrLOrC9nz5yOvPe8
	m1VGbOIFS/Y1BY0uqh+CHEd1Su0dNp5b8KZ3KU6Gjc/fAbN1VQV9smTrl5EexDOx
	F8v5ZNaGXoRQDtD31sPR9zy43eVPRh93ROObwMSsjN3D8iiG9+Uo/TW/WyEnM+HG
	DzS8u2ecorgqQWpoMVe4+4R6Bc9p+YcP6V8BRE74sFBjtWiMfzs0Ln+XSoMD+a/d
	gFb57TjaveZ3cIiB09ItoxvbpUZ58/GDDnapeXqC4Zwut2OPaCN+r7AscRl9jO1g
	C6Lbaj4rapNxoPvEFxLjm0QFnSCOTYll9tC2WFnU43Kx+l+63wibzwFLmOQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792507039; x=1792593439; bh=n8EZOmoqLqnG720OVWoIjVLv6dzVUfu6c5V
	80B/KnOA=; b=m/OUMgOfqHjs8HP5uyQ7O6ZnDJOImOBiH7hcqg9Ln4hRua+Oil7
	fw//x7gMypyRycnQLyOYFV6dIzk4eRLmgbNeOjJ9cGPfGeaZmtK7/6Cvm7fsz6Wy
	A0FSSd46VG8fXDDqboBYJzzpBOJBrUVa4lvABjKj5OHFFiSlIhtLC81LcAIXjWAe
	ExYoC+5Mp9qOM86TDe/vlfeFIYPE/YYr1vDIxS9qRkjI0YAN7wbpOApsdsdUpNV7
	T2D8VMvgKoy4DbmpO4k/+sovLLltmTVeifL3NVvidNZ6T8SifuF8+Q/lQe6G6MGX
	JfZZ59rSHjmWL2JOR2EjZ/AFmpEoD+b0V4A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792507039; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QX/5AM5Bbx3fi6pUJBq1Es/ouZWig6Nwfz342UzmzbjcgJs
	nKW08/wEeaPR/DI0R4kfcuQvVSm+UC/+mz7AyXaBIu2zi65b9SEyKo433Um2wLBY
	5hW+9qEBYbECjRNb1jdvNEBK0znnwPCblyYXhDUY/5lrMHGhOyh/PwTizcjqmusP
	WEp9TvjQ/UEQ6EOxVeQYN/55vKQI1VycShYxRD7GnM7npE6hl/ogkFfLPNWyvAfN
	ZqEoJeqbZIic+M97qk+ymZkkTbFD4HtSYYBshDxj49fFzSZKaZtoKh0k6YhD7m5f
	RlT5gxS2rIVxXgpuL8grjFr7uA2JclCrJrQQlPQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xr2bjtqFv7AMX9oz5ssLS/ME0oUp/c08Wk5r4DItES8=:ax90igUIB7GaYmLq+mNVwUU7udZ6pjobt0wXUKHTw0g=;
X-ME-Sender: <xms:n3zXaiEapFliIOXmyYxIftYKoIwjqEowlgQCxIyCVR766ojnJ23s8A>
    <xme:n3zXaqy9lgANxxlT1axw3G-Nfzg3oR63St3zk50JuHJ-8otPx-YdLb_g3qFLP7l3K
    pBlbtfdNYrpEiZFa6QpQGNGmsJ8XZH72gQ6Ub1WOtU_WLpMtrQEXEo>
X-ME-Received: <xmr:n3zXaphSpeUF-Mlqbmc8Fph2YvalzZwFa9gHAa2U-HRFpyWM6_9bsEzA4hE96gexQWiAxw>
X-ME-Proxy-Cause: dmFkZTGs/Ze/5FaVPgNBoOfb15v0ljJFgFQKrFo62vDS/FWaIGumnp20i1PW3FJWeUegjQ
    +4HRoa2JDHyw8hVdhzZBbgqD4AbNFm7RP5mveVdKPoCIv3/kRQIGAGbs+loqGDjndzFQSU
    Ezm0SLUHd9bZ96gjr/1vW3WS6BGzTqkg2zFy+vK1IxWRT3xs9vjuDNmcZYlUIQUdrNS4tr
    rRk47gnf83lJxzx2ApYqaoVRL05uuswFS0GGiTjZlfXExMAFMHZhBuvdOcFhYWQMgzZYqk
    /a8NHppWf05nLzvnTo0hJIfmR3qlvNzaBUmmZseoUcrls8UW8WVtdkrHYyiIDqxiJjOtrn
    tpE6mXo9oCObLDOsXcHyUyTOQk+p0iWw9fkyrXXjDGYzK/syP3ONQtAwtkUnYWGMZb+nEn
    lCkLzNdWv+AB1EjUO/0kuKppWd8cHw7JNyhEDpwIjtkY3+4EBEpJ3uYnsdgGxjjiWHL7jb
    Q4xee6MmCnypiF6QJJpIqjBqFvx/Din42VZmA/VyuPeMIUB3PkDwiOqzKKoH4vy7eDC46K
    aHk5ok3wAygADKZG+G8hi8tDSthLRhqDXQn+kzDERbwzxtcTz4La9zIVSnQA2klNhB3/bC
    32sNA+zz17kv9WChie3Y5ZAsllpzET6ED7DNAWRocF1WeZGwD/x0UtF5GljQ
X-ME-Proxy: <xmx:n3zXalw-gyzYm4hdDr3uL_4bNe8CpGpM1_Efjbv8eFGl0RztND3XvA>
    <xmx:n3zXasKwGY3HktdvLKiUSXzstmYqyfZDsgiWa9b5TSaO66_uHIG__g>
    <xmx:n3zXasQPKGIo1gsoiaSjJMh0O9y7LVErZpl7IKAUieEIgVEAJSFCFQ>
    <xmx:n3zXakrYu7cD67RSxP3IvibUtU_HuBdYOfAwwfz6BXWx10GDUXe0DQ>
    <xmx:n3zXak-GyO_vULLlzwPc1EQCVmsak6rsExWjnr_iAqxwQZ-QW5PO4Cmv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 10:37:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82236bc0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 14:37:17 +0000 (UTC)
Date: Tue, 20 Oct 2026 16:37:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Matt Hunter <m@lfurio.us>, git@vger.kernel.org
Subject: Re: [PATCH] init: show absolute path of (re)initialized repository
Message-ID: <atd8mopIi44pMBAC@pks.im>
References: <20261020053932.1274210-1-m@lfurio.us>
 <atcQb_V69vvKnxoF@pks.im>
 <CAHwyqnVf++okhdjUuVewkK5ZhqbKSoE3TixhpNORdWrMGUA=mw@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHwyqnVf++okhdjUuVewkK5ZhqbKSoE3TixhpNORdWrMGUA=mw@mail.gmail.com>

On Tue, Oct 20, 2026 at 02:37:05PM +0200, Harald Nordgren wrote:
> > I'm a bit on the fence about whether we want to have a regression test
> > or not. It feels like a very specific thing in the user-facing output,
> > so it's a bit dubious whether it's really worth it. But on the other
> > hand, folks like you seem to care enough to make the test worthwhile, so
> > maybe we should have one?
> 
> It seems self-evident that we need a regression test here. Because
> it's specifically the thing that would have prevented it, and the only
> thing that will prevent a new regression later on :)

I wouldn't necessarily say self-evident as the result isn't wrong. It's
still correct, even though it has changed compared to the previous
status quo.

Patrick
