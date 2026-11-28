Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795848863;
	b=K71Z5B6aAoJXApY7uYYGHMU0/tcu7qQmyJrtZDxXwF3fy6rW8pqEXU+U2P9uCOQE+v17
	 VsiL1gz0HMnyWvaugvt510M5/YQxKxnksRLlhS7JGcU9CBX/n+o8Ltyf1drBbRzZ0ZdWg
	 zUJ3E5Q3VWtWBK1VvwD5r32jSvWCxr51wqT0myudnMIchspPckuG5+X24/2IokslZAmDB
	 SHgJyywoJONzfktRsHmjUbcUFllxixMpUS23sfiWA/OdhZw38rb9NgAqTrt92s2btQyIo
	 YwzPlbPkxvrzQ8bq6NIx3P1R5j5jwd63ykpowAqHavkcEej5pFcDAsR0MhKHJBCBliQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795848863;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=lmsH6U2tUNx+gPcVhEMAQiM6r7r2D4fpiAJGaPu870w=;
	b=mE6grRebBliDpCUSnDmRrUWA6v5Zw77UnHhIUxomL6p5zjRl7NhUXBgST8G6vvjbUnsx
	 sQ0tfNmqWnGupX3vOrm7FTm6zew7kDe0i0K1brI9w9DLKwdGhUnbJIoP2fFLL0dCnM6cb
	 Ig+kfb9504qjm9Kqmw00Ok5ZsVhHyQ8xAlNSGIr6a9cJO6rybl5vRutXCtCszLvxcUFLd
	 hobUIPugnApTz0/VY3aCicS+wK7fw9+QpRe5xFbVSZ98ZHI3Drnkg0uPKpzzJVFYTKKxX
	 blmOOj3OA38FfIjKThwYZKveEWUcDpgjdk99MV6xMyG2OgFO1PaGp8n064Dq5VFFzjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EjwBl6Fg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xcUBW38o;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86847606A324
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 06:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86847606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=EjwBl6Fg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xcUBW38o
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id AB553EC0A6B
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 01:54:21 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sat, 28 Nov 2026 01:54:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795848861; x=1795935261; bh=lmsH6U2tUN
	x+gPcVhEMAQiM6r7r2D4fpiAJGaPu870w=; b=EjwBl6FgakX+v/PQGPg3HGZgz+
	hRWyVsvILkcdI8zdTZykLtw5mOi71EpEtGyk/mlnv0nxISRFUuuo4dL4UZH2d5/J
	CYvbT591n/AXxDOS0/AOok5hRJo8tZRziDgvmvIvEu0oRfTLpZVDFX7W8XlOYnC7
	FFjKtF5nYO4ljOh/rO5Cj97xh1WWykm+wy4VdmBCo+qJAUy9p/L7sPEyXX4Ls0cK
	G0P8ykB8Dn7cbuDVWCAsNTptTmEDN/U1W2UGeIM3zagTWYRBK3GMZsYz46Msevkn
	SJKbAiMvV4a6zQq8x9G1GYtdxNpvyxoMu4NOhOOeisImNBxTufCS6IeOpRTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795848861; x=1795935261; bh=lmsH6U2tUNx+gPcVhEMAQiM6r7r2D4fpiAJ
	GaPu870w=; b=xcUBW38o85yTW9VVU2BsXUeb9CmhNRV+jzbVMsFp1n1yVFSxmAV
	/jVSg54Dkadcd3bME5mkxwchyhYOZKhP5cIiVi1bhA2bDFatUndEP9K2Z5akkz7k
	BFE+Gs0CgruXyJ95he7/8EozI3l1d13g/5NHTpN1thRgfr0XQT8erffEybVEl8LN
	brgZ2aBZ+o78AD6OTryzwbZU682bIN/yIkUTyOgPh1+hLB7uVIdgWv3uEyoulaFl
	DkaoQlq8PwNtG8EhKl72Jk6RU3qb5s4D5Lc1qexjAU664feh6hQlJWvRqOhwz1pW
	wg3FwLpvWFwFkQReAVZml4QqTg8RAQA4ocg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795848861; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:mlCZ3YJk4hSa/7/z8Ig/oSgYkLebedVvZr7wYfZK94EkbqD
	4y2i1ZwAaihGqrdrcjmRGMEL6UmnP+gV3z+nj9UX3v5+OVidPGY89Gn7SagVSkFz
	RDiVDMAnopusUYPyTob3yLa5QYyS+fYkiGsglixd/xYEAC4PTpTJrK3oK3v1DKe7
	L4rwKD0xPpqQ67TcNGH8MNhUIYEzi7GBDE5xrUaHHigmxk7FGWrgTpUJAwOeCnSN
	wpEYCXrCbBcP4wXguWFECCFevHp7qCnDpRtAoisenCDggJ7BB/fS+l9GNddya4JJ
	c2/rnNZXyxaproyAyk4ZG8TJciNcjGWoCDiKO9g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:SfTsS8nnH5SWiEEXyFyWB3LkfseS3V85iDzBVqQG5ro=:Oj7xdYXP7DRvOL/x0M95XVu0OPwp8oYy003BgmPyoDk=;
X-ME-Sender: <xms:nXoKa5lJDvmG62HLHa19iHy6WM30iJ-rwHe5sn10Ic0mk-fIcxMh3w>
    <xme:nXoKa72Mb8tBe3Bh72eaD8RNljYgDId6k04CpfwMBmEen--0X8mhRHBqO4SycOpDl
    luhZHLCXw3EnTtqI3OZklTuBlG4sd18WOQzAXpRvckR9EB5xE3mlQ>
X-ME-Received: <xmr:nXoKa0rIFunGdHuYLlkNQTvUh_5DVOirHLzU4VsVE_u7JfIeKoLqcWWn713hfVjbKQ8ry8mxMRs-XEMM6wyJHI7zTRRdyjMVMHzjzac>
X-ME-Proxy-Cause: dmFkZTGVLhxu++sxTveZd1RnDu/XNrebnOEzQwRuI0uYCtcHH2tJCaOkxYXqqhOfaYwFFw
    xjTe9ndbfHLFnwChJoZdywxRS491MAx1JDxo0rceIoQ1nxR9OScVYW9Kwr6tzilpSA6Hdy
    DLS+PxEb1ldsggFRhM23MLNga3SByJnCBXAKqIMTynvnGV2A1sHhVLvDL3dpaNAcJioNY5
    +LYOIwBzouaj7XXCbx2VqLO+61bXAkxtsGs84lYWUqDd4OxS2a1PdWeeM0Ct27yPu+SqT8
    pWqx2n/I8ZyyRTwTNe2Dq6FUsUmWZnGAsSSUqhGBfR9id7iH38JVwD8cqKiwcctbVLsjCr
    hSTUxsh4ETk2dqgW/IxWcjGDW3orrSW6Hht9U6X6gQb/mAQpqnQL0zhssD8j8ISgbp6fYE
    EQrgwAovG5Rq6V2T2trTlorQ/I+4o18uiNfQBnHS6Jg6M505605J6aGqgxhT75cE9ZLmHW
    khDnEcegb96ClIWxpBLftdHqI4yItwts66tZ5SconRE7F+UtBo4b8otuB7+MiO3oM9MjgH
    J3fXADgqJ0+ZFZIvQopc1WecveJPdTSeV5gMYxN38bl77U8lDm91+jnmfXebtV+bSzy4SN
    xCZbq+W1y8B1mb73LA/RHUNpGEfkB+0auh8bXX6T12B9kkuXWI+iQB/dxWDw
X-ME-Proxy: <xmx:nXoKa4fR_V9DjSaVcMmbyC7BA6P0cnW-s-h96xa_tmP0Fx8gohuT-g>
    <xmx:nXoKazq2BtE7J1WXSr5sAzsQyLgae6dnsXqkJ0CB_QqbP_odprz7mA>
    <xmx:nXoKa5EAop98iejewlgypzcmJSp1fxbTiCKn3agmH5LF1dJ-Mc7-FQ>
    <xmx:nXoKazuXE1CeP5IOqn_IUb4mIUhrH93y1ioNLOnxU1wIY7pu8GJtcw>
    <xmx:nXoKawJvYa4mVBsNm8ahx6orCyEUJySiy6QpqRFYGaDOHeDpklJlJvro>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Nov 2026 01:54:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org,  Mike Beaton <mjsbeaton@gmail.com>
Subject: Re: [PATCH] dir: do not turn blank ignore-file lines into patterns
In-Reply-To: <20261106182945.1316297-1-aniketgupta3001@gmail.com> (Aniket
	Gupta's message of "Fri, 6 Nov 2026 18:29:45 +0000")
References: <CAHzAAWSi9D1mRL=A5-9GxzqQwo9jJ=45Hmxj3hVAF=8wkNZLmg@mail.gmail.com>
	<20261106182945.1316297-1-aniketgupta3001@gmail.com>
Date: Fri, 27 Nov 2026 22:54:20 -0800
Message-ID: <xmqq4id1xx7n.fsf@gitster.g>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> A blank line in an ignore file matches nothing. But
> add_patterns_from_buffer() only skips a line when it is completely
> empty.

Well, isn't that the definition of an empty line?

Or are you saying that a line with some whitespace characters on it is
"a blank line" that should not match anything?  It is entirely possible
that a misguided or loosely written documentation page claims that a
blank line is ignored when it should have said that an empty line is
ignored, but I am afraid that such a position may be a bit hard to
justify, as there won't be a way to match a file with a funny name,
like three spaces, e.g.,

    $ echo three spaces >"   "

no?

> A line that holds just a carriage return i.e a blank line in a
> file with CRLF line endings or just spaces, is not empty at that
> point.

"A line that holds just a CR in a file with CRLF line endings" is a
confusing phrasing.  Do you mean a three-byte line "\r\r\n"?  That is
hardly an empty line (it has a lone CR on it).  On the other hand, by
definition, a line with two bytes "\r\n" in a file with CRLF line
endings is an empty line.  Without making it clear which one you mean,
it is hard for readers to agree or disagree with the statement.

So...?
