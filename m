Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701417;
	b=tpyY8/AOIs7dINvYHFq55bV4S7z8RQ9FpCjD7PbkfRA03NmzqUPJvil2oLjaoivLv6s6
	 lX12Kqxki4QXp4+o4WZjHnbRS6RhMH5dlpg/LAZSxR6GZZsPbcIe6JL6jNE4Qjvw+b8TJ
	 jRygOZ2fZnw2QQimrKanKbGiweCixvpia6Kt2HSd7qlaubSw8O41FXooqHsv923sw+LEl
	 6ODk2nb/RxJx4RaxBvYaLmJ0AdOzkqajhLaWC8QRWQevWBiS1Pud78rOMdaGJHTLyK/q+
	 cWK3+FX3kW9B+ku1X/QEcsrMALM8DIx5RAgGdFY7EiOvl91hdwDXRBMKp60FG85gdRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701417;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6+yrEOtN3KwPHTnuONWfmgBeXF3pYTbfuz0XTXg4Wv4=;
	b=qebEQLRZHhR7WvCPaqIvjChnte5tlG+qYlLX7j8fZjjNL1S4c7iXLO90s9MSPfe4kJ2L
	 a9w20GtlCwABOUs5aH640FqPL0nIgv+JPtBvkzbJBg6AouKuf2gRQP8IscAC+9ICL+duk
	 hJx1twkHHCF9I2GlKG3DG//aIVOkWqj2sMufZoLb35BGMxn+XZuSVeqgweNbs2+gYYJ/T
	 gfXOF9pqMfzHm4XDAHRj25znrn/vZ7NJurVb/aEHWB0uFi5Ms9o8HmKgdGqRmTNWNuX+Q
	 XZTgqhtmYpkV2bRfbh+NjzSSOdCVBWit4nxe1ngXnUp4ZYOf1pQ1Ct7q9hXZKIL2qIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=R3AdBUFe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3McXlyY4;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D979E6083601
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D979E6083601
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=R3AdBUFe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=3McXlyY4
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 365CD7A00E0
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 05:23:36 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 03 Nov 2026 05:23:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793701415; x=1793787815; bh=6+yrEOtN3K
	wPHTnuONWfmgBeXF3pYTbfuz0XTXg4Wv4=; b=R3AdBUFeIWc4/9pB+v956Frh+Y
	1maqFyei3Nr+NQPIEbcnULaPydnJ4GeF5Xtx70MbaEQDJCSgQttqVsihZAsYPD56
	FQio4MLATtmEAXK2do6oC4JhRySQ3qVdNlgJM6XxLPhT4LRGlFNA+VT1j5ZIByJR
	2oYjRo5Zw4pp7MzgLsh6wyOb0aWTF0hTPEaHsaaLu3BiH2++9JOsQ1+qDK5ow7TL
	GBZN0eyXhV8JkteB0HaKzBOHqQta1EclUdbg+Y338TTV5Hno0hz7dsEgQwc7j/Z6
	gOipu2A7akLNWnYJOoQR9r404iJFAlDZErhUyIJ2f0Dt3ZfbUtgYNOG1zzWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793701415; x=1793787815; bh=6+yrEOtN3KwPHTnuONWfmgBeXF3pYTbfuz0
	XTXg4Wv4=; b=3McXlyY4+yHt3AOiBswiQ9SXrWtW8Bvxt1B/zhxVIw04mCijhgq
	K4xK+NTmlZ/D7BuTh5n0Wcti14HRS+LOUwvTAbKAf+dp44rcK6xcvhK719xyw4uS
	/T5LYhvvff1Yj8M9ULCKKX1OJbnVh2DAUOrLKAz3tpktlTj6iOGZa8ME5uUkNPwh
	z6oK+tELvaprMeFH9MzWHIQfZiZZ4q8VyL7DU4XieoOwvMzPNTUdj0cF3argHPdq
	JbTnVqvEBvGxNt2D2ZJ9+2QEsbQQIjB+UtplB0drQ/mS2YuCIZO6/t3b31qy+CfF
	CPftPgnyM7oko4MZoeJ0yRsyG2GYsA4yy2A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793701415; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:0PYqtyl2eopSAB0Y6krGvV+/pMkkwj3k7J6sFzD4/6eK9Ec
	qdCkm7xdCuYtN7K+X1knlrnp5G7/zDlcnpwasvbP7wVNB/KJODRnUV3SKrMJW4qv
	9Nc3YIAtjF2TcISkBQJtoI3VnjFK+wjuIovtALM9R4kqNk9857tPyvRS8j88CzmK
	olU+F8kAK3ETLiOLIViKJJkIyey1EG46oiOUNAhzcmkKZ/l2eSTuaEOdu+wrEg+G
	UusKXIAZopCMMiczWXg7hRowZak/QQ88d4tw4MrKtmUgwFNSj6HAjc8iK3kMPdAh
	MNM+Pw5fu84+F6mOBLqRmzMKJ2//VBMf5dIqK9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:x+1GI0UP1MJzXwLSt24CCXXnJdmImNh7EefTEXELNf4=:wqm+ntEH+IEF4bspGRmvVeSFpJyYmx12OmiS+tsP9Kg=;
X-ME-Sender: <xms:J7bpatf4uoJeAkpkLu7_MbKrAGeyWY-uEN8aJRPUTuLiJblsmjodgQ>
    <xme:J7bpaioVMy94qVSS58ALfF5oFdczc28VNBVt6PMfYeXweyCn2siWDqbvnpggqQ1kf
    OkBibJkDVmk8IObBmqendcWbDhSV9RBhtX5R2k2yTLtMLlK-lK6>
X-ME-Received: <xmr:J7bpaj7H-SBsVEpgzLJiuuHo7YJdkPFPqiJ8SpOjY47TNH6sWJmMmg>
X-ME-Proxy-Cause: dmFkZTEe2hurEv+9+8nD3sCQAEdb/cmY/JJxW2bvFtK6xKlnDzBL71wlRhx0IpmubSKApA
    7zpp5uCGEQI4bv/3HaX5dFJAPuIYa9vEYOID72CBM/Ovxs59XTW36TaKwLrHij7uAWIyBD
    rkKNzPnzD9NjZEQcQD4+FBryk6AO7tQ3Sq4QOlO/fSR2N+jA3GhTM/0ngDDZlozWyXa53R
    IRfAMnzNoRIarRqWDsQ8bwIrcCz6DhxdSwz67PHvwiYZAWJVx1bBPmycqECftoSOY+Qa8Z
    c/fNFbzouisynOeCsRsyZt4zdZEEJxAxRfWbw6RtRlH34rRT1mlYadItF8aTKkysPSEdk2
    wINZg0paR17DTw50E8fKGhVksI03lpp+FVAk9+r7O3LG02TomfSPiiuKu1PdFsrwzLjYiP
    INlgS2o+gS7XYTK0aUHs1cHt4AAxM05G2EvUYPgN3EbAaiowTY2Fqhy9PNH7h5EA1szzn/
    IcNSrp8snASTnmxIV8pSv5cpi3xXLPQu+EK6uwKKYYJoIvNiD5WuqPGmmtln9n3P8MsGe9
    gYHeScDhVauKlnHjsW2T7oziHUx3t6YVbwhm5Yqw/n1q4kGFh/MQuRfkA7OMLgARG7xR1S
    cvpxzQ/dukAWHLWm7I1tf00T9vS4LsQPrx6xNAkZP53b5/5SEvGQxqHqsVPw
X-ME-Proxy: <xmx:J7bpagoNTs0TNJF8XpMkFzaCHJFC-xjsEFSQcu-XNuSqmY7baDvO0g>
    <xmx:J7bpatgEjKXDCB1QazflygRlTx9caC8N4X2kPNbYkOgz5r5mUP8Rng>
    <xmx:J7bpaiKhqRoF9EBW8LLD-ytcw-eP7BEFnZCyzLqZPr9So7inLuCp3A>
    <xmx:J7bpalAxKTYRMB-1pV-8KRIJ7oqhi46V186GlUxdP1z6CsSPb4mz4g>
    <xmx:J7bparYNllGKDdecA1Saq-5ZZ0n1mv-hnF8_s26nAXcSDb-fEHyvt7sn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 05:23:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c2e6e34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 10:23:33 +0000 (UTC)
Date: Tue, 3 Nov 2026 11:23:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/4] mark symbols that are unnecessarily public static
Message-ID: <aum2IssjPCGMySLm@pks.im>
References: <20261030173956.585250-1-gitster@pobox.com>
 <20261030182648.GE7582@coredump.intra.peff.net>
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
In-Reply-To: <20261030182648.GE7582@coredump.intra.peff.net>

On Fri, Oct 30, 2026 at 02:26:48PM -0400, Jeff King wrote:
> On Fri, Oct 30, 2026 at 10:39:52AM -0700, Junio C Hamano wrote:
> 
> > Over the years, refactoring various subsystems, adding new callers,
> > and rewriting them from scratch, made some symbols that started as
> > static into global, and some other symbols that started as global,
> > no longer need to be visible outside a file that use them.  Here is
> > a small patch series that turns them back into file-scope static.
> > 
> > Honestly, I suspect that [3/4] was probably better with a forward
> > declaration in the preview I sent earlier, but in the longer term,
> > readers would not care if this conversion ended up in a large code
> > movement, as they do not have to even know it.
> 
> The subject for patch 1 caught my eye, but I eyeballed the whole series
> and they all look reasonable to me. I agree that big code movement is
> sometimes annoying in a diff, but the flip side is that the resulting
> file is nicer to read and maintain.

Yup, I'm happy, as well. There's two tiny nits on the commit messages,
but nothing that'd really need a reroll.

Thanks!

Patrick
