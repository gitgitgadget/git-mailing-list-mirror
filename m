Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793025446;
	b=Phn3SyKdK8hKX0adDYY5xgZDpC7ESBA9EZPNdvHz3BsrBaUKklI5SMtnuZKYZs2bwM9l
	 g2XShWKd3se8mfebFzqKnDmyQTNotEVfBarlLAddLRTMl46HE/jeH5Oxr+EzSv+3SG4bL
	 RycAl17GGJ/81scDG9QEy1nHMBCiUHXBs35PMPjhlg5zOhNA8mKTVaG71Eef2D/bcZAVH
	 XSHDViTnIzUkLqWnsOlirvjmxAm9RJuAZG5R6o6CPyBp4teYqbISApC1ftezEQ1W6z8PD
	 IF3iz4XBg4761nnT7+bb7o/UxkbnGSYA1E8avXWMcXpppmn8vNgVVpzT7R+mIjU+3GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793025446;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=G/yMscimLZN00KvIsq8Urh65Iat2AVDX84CUJZPR4I0=;
	b=NSvJgF26t58GNCX73KsY/2BnlrsxlbrssRjdhVS2yvRCbZ91HjZuvcUwj9f+vSdkz6Ij
	 f2tCU2TUZreuLZmsA3YH5WOjTrH4ocTX3vSaHmdT/tl/DGPO5KXSK/C0Qnb87aKYrpaq7
	 36cnOpsr6ltHiywqmvHLB9KTgnhAtJWNTE+TZnIR1ARU4qbSW6X1Mfs2mnGN4zaEc7b4c
	 OWza6kaPGlFAMn7lK0LeikfIiDVEKM9dRRFjBGOSUd/abFRIGXrR0n6nJjqXDFZZfVL5k
	 1iI3SLODm91kgxc8JYrncZkXdwopz+JGdPSslHFKNixepP0+Ya6SHw7n/jtDhGuz2og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=euZVYkNZ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pLmFqQQJ;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF85606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 14:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AF85606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=euZVYkNZ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pLmFqQQJ
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9653F7A0382
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 10:37:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 26 Oct 2026 10:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793025445; x=1793111845; bh=G/yMscimLZ
	N00KvIsq8Urh65Iat2AVDX84CUJZPR4I0=; b=euZVYkNZNSibGWfQ2BeWVcDzHQ
	TV3NiQJ6Su92j8/66DBNG5FUPbU8FWWpAFG4oARlMbPeTsvaarKPSkCdB9AmxHsy
	RiU+e0B2AHhPnQqVvN+a4oMHsSqin2pb2W4fI/+sJ+oKaRCMfNi3j5W/X81Oe07E
	F01mTzRSoc4sqXmC5iVLN9fZQuvM1ekRuwuvOO3vae7AaVOb/2NdFTr8HAv83AXb
	twKH8UUZ1PRaUgp4X9fIEzSkGoivwvU5h9RBN229k9q4amO9elwneTfoLAqBnzwR
	O9ivt2onUBJq9ylHDnAO9S+VSCRyKZKuK1OUAM1txLLSkQZRdPiiaoTaE1og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793025445; x=1793111845; bh=G/yMscimLZN00KvIsq8Urh65Iat2AVDX84C
	UJZPR4I0=; b=pLmFqQQJ4d6dcIQi5qdZyPYpj6WKP3JUWiwsqd2m2SW/P7uC9r7
	lz6zZGTk4iayXsEsFf771Qfkd2C4fR5O7muzg9Y6Nfwl0Au5rNF+qOyHPtzgN7b2
	1e3okLiI/00PVcfoEpR6cwzbRWqkGYhWNJinJvmqhy5OB+aFTEngOTIfsvtvvFnV
	+avcEfhnPHPtEaxoCG9pqw52SQwHBD96/rVOCIr8dITF8mfA4tUkxAAddhwCuaC7
	5JZ9O69jBmZRijVZUcWi/t20LJXqx6R/BbzeJitbVpSjVz6gMyEa3ydrLHxl37RL
	MW3EqhY7mCsHN4J9eLs3NspAOhd4aq6uXHQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793025445; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QsLMijfYmSgGsUOsXAbfW/AeDHujYiqajRvgGhVPbFsASU8
	3G0Tuz5B7taUqxUC+aKUjkESII8UlkGs/DkI5TAmFWaLJmz5vPRrARtpJ1WjPtLi
	i4jJP/EhRkC9m4aHFKRAFHXSqGu2p5+bk0jR5iYV2ZREAS8g8/dNyv6NMXNEbMeX
	00OwGpUdILQT9n1vzbwZFBKY4yemAxQ0bOU7ZIlAQZj0tl9QrscuSiAjCVWmRfcK
	PEuuEPn4XxOXbZL+bWlkmRmbqJfSizN4p9Ny7klwBUs0zhbfXiyO9HxkEws80kZE
	nWC1gKzGY63y3RzKfL0l8baE5+Cxfk2ppj7F4Nw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:oZaZl4ZEBM8jEDS6YIa1/agIVxl8mZ9LcqvEX3KT2eE=:IDuCvzE0/5rJOcGRyj9IrW8qvfMiLOrEcyH6GsxDcjs=;
X-ME-Sender: <xms:pWXfalV4gENVtxQLZ3LzlPky56V4Euq75JdGW99cG5a4JhmMltpwHg>
    <xme:pWXfan2e-cx397Ixbh6A38cvCIvo_-AeU9DW1QMz2Xldlk6FkOYUIxHZm5zGccnXP
    ed1PQUpN6O11cl3W9jmsqQm1n5Uu7EPQcGCSVEOnczX3zDq3KqNMw>
X-ME-Received: <xmr:pWXfajqlLPeXuOL0XmGyvbRBdZLnj10h7tkM3yIpJ3uuSFBHMNq2O0ZxeUVmDLTOcahEj0iRKLzZsB6Jd1Dmrc82sbhXFay5-VM->
X-ME-Proxy-Cause: dmFkZTEa0EsHbOVoAg/plgtCfJ3OSjavqQZSmLLFfyAFGg7fVmDjKG3d7KCaTDYgRCwtPq
    rC/N+zmTTVob+XM1q7dGA8G3uFThi3f+i4VxHEdPUofLs+I8iFfb+WNqFCeIPxwDYosb/g
    DQxZzWbP1JIYk1T/eI3xEKrrfTM38fKPnRzTg2xA0I1r8Ixr42V6EkFmPmwAmCrPEFxuxU
    yP77f7OM8S71yF8OuXDhAqTdki9LaFth+wfqFN8tTThHdFlY+UFbsbicskS4Z9HXQAeQBf
    GuWkJfPnKkx0jmUekyxl5r6hTDc7Cmy2qMSIo73yp/6qL3OLBW9RNw54xOKkaXcCIgpnNh
    LSA0fPgAMNUaQ12b4BPewKfwjibmuDWmqQKa4G1lR5eKGTvXY95mzUhzrEGhsQxwYd56sW
    UsO9JLwH4VIbOFfQQehTWpAyH920+WGnoM5ukM/FaHZbIqs336DY4PvyCk4R2PYSde43QL
    w786VY2h1jyA9jc/23W4w7SaQPZFx/Y3BPAfBGijvXm1d3pSzCRi6Sx1QJlF/Jc3IwjxXN
    VcQMipkOdK5wx/C/5DdnNxB1erXEhTguTrehSgwQVLCF9KvuHoVSgWBhdcUUaLjAx3iCoc
    OCj65SGZzrzjWW+LBCalkBudXEsa7Pgb+5YN2DLQcN8wm6JSEDJUCAXI5MNA
X-ME-Proxy: <xmx:pWXfauXjm4aDh3lyy2CM26_buxWyC7EKHq6GhpyrvkTXRz6s1UK2TA>
    <xmx:pWXfauaa8FNzGnar_LaeF14GoCMyanx-7Ev8OYAg6dKsUSbtETLEyw>
    <xmx:pWXfarf38XqSXFT4z5MrYUhIxl55e7A9XHLWfVvNnoAjdR_5_1WbvA>
    <xmx:pWXfao0-I0ALy4x_kmVjbxMsfLUJpWqhbNIuyddVa7MoW5O2aKcEVQ>
    <xmx:pWXfakCcWEdQQCuRQeeodnhbNohwxQ-WbFIDx6bporaqbGKze8RuJ3WB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 10:37:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Julia Evans" <gitgitgadget@gmail.com>,  git@vger.kernel.org,  "Patrick
 Steinhardt" <ps@pks.im>,  "Jeff King" <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>
Subject: Re: [PATCH v4 1/6] doc: add new gitmergeconflicts man page
In-Reply-To: <2564bcc2-2f78-4ea2-9b6f-c033e95983d8@app.fastmail.com> (Julia
	Evans's message of "Mon, 26 Oct 2026 08:35:47 -0400")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v4.git.1792764293.gitgitgadget@gmail.com>
	<486a77dbd78e111f66f8878594a30974c2abe53f.1792764293.git.gitgitgadget@gmail.com>
	<xmqqtsmc44c1.fsf@gitster.g>
	<2564bcc2-2f78-4ea2-9b6f-c033e95983d8@app.fastmail.com>
Date: Mon, 26 Oct 2026 07:37:23 -0700
Message-ID: <xmqqmrs0v87w.fsf@gitster.g>
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

"Julia Evans" <julia@jvns.ca> writes:

>> So, let's rewrite the reason a bit more tightly.
>>
>>     since one side removed `banana` while the other side did not
>>     touch, and the same happend to `cherry`, it makes sense to
>>     remove both from the list ...
>
> I tried to edit this (like below) but only ended up removing "probably".
> But "probably" was there for a reason, since this is a made up example
> and in the real world you would really need to apply some judgement
> to know what the right thing to do is. I left it as is.
>
> -side removed `banana` and one side removed `cherry`, it would probably
> -make sense to remove both from the list, like this:
> +side removed `banana` and one side removed `cherry`, it makes sense
> +to remove both from the list, like this:

Are we talking past each other?  I did not mean "probably" was not
tight enough, and probably is probably a good thing to have there.

The value I wanted to bring on the table was to point out that the
changes are not just "one side did something", but "one side did
something where the other side had no opinion on (hence it didn't do
anything)".  It is the basis of how 3-way merge works and helps to
resolve the example for removal of both.

