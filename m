Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045872;
	b=iUn63qi483BMlm7Z+qtyxfxP2YPdFqkapw5+uHpGoLIdFMloHw2PO8lAprr5GlKuvZTT
	 BK8OwwyDkuHTOHS7O8h7Bw3cSxG3t9uKj4+UXvYfTeXkg0GNn0c2P1bcUJ7raeii+cpsY
	 Nz4xvRPEVD/BvNsSizxrO0dtnL2/y+DA4yzbpbhlD+GYmqDJwooQr8x8BslU3kMCweNzR
	 oFEPPO9xGvcqTzNdyYo2Bdov/k4fdvDk3csfwqnhlZ+uhHuh3Uok91p8bnTVsVYm+8XDJ
	 IGXGkbuGN8IHSqDEC12b5qA9/ZaApeV00IVi5txzeYjBAERpUw96XPWWIUF8XewV8eQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045872;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=IvfkQ5W0t0lAh6psN/Her22H5bJ92bdH4hxBIatchQ8=;
	b=OXKF0gMpAqVOb21j3BkOmMVPlrd1Gmg2OLkUqSqcvRp2+HFRE/2gDtzbFKvS+am13HPO
	 UYEPDqC140Iljd6MFu+o9pBahWXfR1HSqhCYTusv/gcGDmIxj8Z+IGQmWay7C0BAI1ng2
	 grKCEDjf7PoCfkxLXaxT5neWni34CavPyb3nsbwo4VyQLloVdKXbhGTrKp1HD+bTnKcES
	 JoQK9Ey5Fwj31A+Px0TjkcR9wPobhB9v+KPxJ79jRHJQ+Shxz342chqHx2wBVM4pGMtYJ
	 Wd/MqtQN6FkQD7ayj+wC0cGIZKZA/9DNsaIc3yRdrenqXb74KGq4hkMdrBzj7Vz7Gmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ggtiQ3r5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E7YDBN0r;
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFED606A31F
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 20:17:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFFED606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ggtiQ3r5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=E7YDBN0r
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C63D1400A32
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 16:17:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Mon, 26 Oct 2026 16:17:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793045870; x=1793132270; bh=IvfkQ5W0t0
	lAh6psN/Her22H5bJ92bdH4hxBIatchQ8=; b=ggtiQ3r5bXMmW9MDX7+6XobXJY
	FFwbIW9WU8hf9tYQpwFrLUYARSwp3cHCHwOP5qSHym8A48JYEc7P09BW5LtNjKMW
	62k28GC+KWV/JdqFBS018oenCph5utG5dOfPlycuI6NdzVCTP5TvI1JFBRhB9lgA
	xfgUzve9I4NZGAvqegbUt0qaBBag1I9TEGY31PEm2vw+zOqdA9MnSP6hQyNkWz3A
	1aS2acvng6xWqIX84pq0SHcnZ2yo5B4oloB3JFNdWQsDJbttJ8TXDkF9IGew33ZU
	SRxrtBpQ46Wo+CAmfSfqjjNdj4LY5+lg49ptdYcBQRYpeE1xLu7rN32WkecQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793045870; x=1793132270; bh=IvfkQ5W0t0lAh6psN/Her22H5bJ92bdH4hx
	BIatchQ8=; b=E7YDBN0rra/RTYMBABaeUqZRK5ENYvJcA5Xls+S14EK4BaXka+0
	mmJ+uw4UP9m6wghjGmk/Us+JQNDlA0uWFJf8FWAOYnY+GCGw6EV4unfQ/lBqZYNT
	/rRMab7P2DqJKEjONQ8uimlatEv75dIZTKsOziOoe5jGdwXxCj9KYQuH7TcP5KNU
	RJi6klCzGP73xXXJvaFMn8GzaRNilHsoLdAOS/pKjZoXCk2NqRFUzzIR9/Aa97no
	xsc9ycSM6V/QaBgVRAbOUdp8n7HFD7jcO1FQ658OhKwQcMGPRzE6JWdiN9nt1FP3
	CkHtsJWeoeOsKHldoUnBZHITYrrjR142i2g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793045870; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:qTcc/yxgjxDsVoXB/jaTyqeEjhJBJG3fDaYjD6YKv+wZQRF
	k7KrLLHQ/O0vhixTXs9S0andRRmTOQRp9fC7/lB28GiVOobXzKP7lFz/13LoUsiF
	lwLHTo9jOcvFpvwIBd5XOsc3cI7oLjT9hEB2/JlpNW/h7sdx7d9B1gPObkVEqabN
	KMAxBzbrtbHQaFh3lSNukYackwgk4z/7UVX/BTmOyfBHMJCr5eDg6bqa6Y9XEyg/
	QPzN9xUe9vK1IFRCZcTgdoSjynT6XQ2cwJDG2RBGk/uenFHCsyNmfnz2ZA8Vgz7Y
	aQOCnGnBojm/Pn/Ii2kdbYSj4AD/l2fclz2Ap8g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5WFSJK03AUFQAm691WMFxDoMp09AMOlUq36I6YrrCy4=:dhq+V/IGmJlVqME3u+nNRUlYEKtjDst2ZrtXny39ZtA=;
X-ME-Sender: <xms:brXfagMOouIxIhxf_DtsgUsp3etLxx2nPWgijd-nvU4MWHppKdjg_A>
    <xme:brXfaqrqy5MhuZE07PP3yI02KijBnJBQ3nbF1rtvYyDcjxQt9YhWmAQfDbxV6GaRO
    jqWJjC-UB4NTRcHmIciiDEFSNJsTR1V2higQsC773VUrWYYlx4X9xs>
X-ME-Received: <xmr:brXfahEBIyxkUEHVv6h-_ClQP961aKA2-fa0EdvCv9IcifqzEV-oKYlqxXf2_6kzaw06h1oAXy3NaQ1XpYb958k1F2yAZCz_413Y>
X-ME-Proxy-Cause: dmFkZTGiKU/goFIzdO25dTZ2rFRMDDvKE7j8IPVmxiW2zmMDI+swHv5sb8YzTWjS2AT/6V
    ZVRDS4rnkZdyCHWK+HOqUBzjWLDH1zT1BwUryUfowuZMrlKuWzxT+Gz0XszPakpRwh56uV
    KdPoPvaPRPp6SdA8yB0w/t3orcW26NMvikkYse0aI7J6gA5orbr+QIMC1/nshCLBV6uHhp
    GZrybfxmwCmowOH1Fhe+G5H4lB62r2PC/P/IypB5PZaFpGy9NAVpDHefTjDdOKtluooAtU
    zhB7nVIn1S/8bZLbVDBJhxBTsEx8rBvVdvn7S9qeMztqNytpYT6X25QwagRPRtY6dIUkD6
    Y203KXYTSH4hniAVnuABNO+givUGQ80mCMmDfG7TWJqFbHwKOy2uM/W6WViocpRG4aYVfj
    zQUSxNH6t8VUZ8TV4jthdMLbBOuazqYSuqiwB2KlzFiok6gAxVbCj7bFzXKUFOJ1WKLWTF
    N4JzBwQsJS0hl1apJYGG2W8qXDtnfypANFPwAr6xQUUQ/hP2nFV/FUP/bR7ljn1Xsf8iIW
    koRlQkQrpvA+m/vGRIhj+4MZXytVX+DaohI+i+Pac14zK2rR7LB1yJyE7Mcr1MeKiN31m0
    QL0W6x28EH+vxITyB+kw5YUUijQmREgs1FvLh16bxAp8AzzpPQrDTAVfIJpA
X-ME-Proxy: <xmx:brXfavopdtvYYR3avJJFaP9rUu-2-ktfNBk-6YIAyAk7n9odyIZcoA>
    <xmx:brXfaqZK9H9_BH3UpgdUH_GFwZYtiSkfVflF3fSpmRje5FMaob_Cdw>
    <xmx:brXfaoULTUqI8dOYPkLCQfamgnsLzZlmdQa4-z3WCAHiKXvpQ3YFsw>
    <xmx:brXfaj_cy909opKb9P8uxoXqt9LKsc_lcyb2-Wr8ODE9o6lhweKIXQ>
    <xmx:brXfalZH1XddKME3el4gix5tibwdUzH7KTVnWtfMT-PzdXpVzS21F_k5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 16:17:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans" <julia@jvns.ca>
Cc: "Richard Kerry" <richard.kerry@atos.ai>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "Julia Evans" <gitgitgadget@gmail.com>,  "Johannes
 Schindelin" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
In-Reply-To: <a8dc2d4e-bbe3-4190-b889-d9f1355e8d2d@app.fastmail.com> (Julia
	Evans's message of "Mon, 26 Oct 2026 15:14:53 -0400")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
	<xmqqzew8wb3g.fsf@gitster.g>
	<60D4F9B6-0858-43FC-8C2A-B6200640961E@jvns.ca>
	<AS4PR02MB8336459DD1A4537A43A5C724EB612@AS4PR02MB8336.eurprd02.prod.outlook.com>
	<a8dc2d4e-bbe3-4190-b889-d9f1355e8d2d@app.fastmail.com>
Date: Mon, 26 Oct 2026 13:17:48 -0700
Message-ID: <xmqq33tsqkr7.fsf@gitster.g>
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

>> In short, if it mentions of someone using ssh and vim, I immediately 
>> think they are a Linux user, and I may tend to skip those parts of an 
>> article, or even assume the whole thing is not aimed at me.
>
> This makes sense to me, and I agree it's important to be careful about
> how we talk about SSH and vim for the reasons you say.
>
> I think a lot about how to make sure that the Git documentation is
> trustworthy and credible, and when we suggest using tools that are
> unfamiliar or not commonly used, it reduces credibility and makes it
> more likely that people will leave to find information somewhere else.

OK, so shall I mark the topic on hold until you decide if I should
expect a reroll or we'll address the above in follow-up changes in
other topics in future?

Thanks.
