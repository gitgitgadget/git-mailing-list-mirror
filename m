Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986630;
	b=DCosE7vOm/VL4oR0hhxDidpSzzQak5XkCZDlp1H0zZbotAwOBdD9UtDw0EjN8ZBkyHzs
	 7OTUdARfKiZYVfOLNy0P0x9PF/f00MXAYL4BcSVRHPFjpDLjT/0/ra5fSRYa+fzJCegVu
	 J6Fv/+pBAsXwqk4SBRd/sE/R9XvOroqLXTh59UEn3JOi5IXMnC++XElDmZaLZbCuKr2Qt
	 DQi74A8yPN5/A1CJ4J2dWTIrswRoOjMQ0DIXJEk0Ao4+pdYIWXTQVA4dSAVrwOr/nAWeC
	 rVH4MjIp+7pjF28sGV1yJbyJZrQk79+Y1BW4XtnZQKXBV/sZAxQ8kTP83BlxodF54Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986630;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=PFs+BYeVngQC02S0+cZSzjcUOCJiecs6BNaAnoxAsMg=;
	b=0Zy7mYf9QwxO4aAYVqvU3Wjpktxf4s+zjnjygLpb07+meYFJ3mcYJFsTqn2rmcEphyH2
	 9qEYvMYH/e75dLR0ItRJx1H7ZY3narwUuXxrTUjwFhqL/9Uxs7vspGuLyEuMwwvESaDoc
	 SduZt9gmgsSaOwnYRVrL38TQo44FZVL2NyptzHNKZoQMKzkaTZD/GqzpVU7x31u6h/oCv
	 6wAPSUbSEnHELocN/KNmEsqjV4O7eAQkDSXIy9wL50LCEihZkNpRQXcX74EjDPdP5skDW
	 ukEhcnjDI2+S3iGpLNeNrE8tVw85+lD4XLClh5OC3oFYb5ycd1PN690GqB3kTV5r00A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=m3mF9C9A;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cAvDwxn+;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AF606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:50:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E48AF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=m3mF9C9A;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cAvDwxn+
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id EE509EC00F4
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 23:50:28 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Sun, 25 Oct 2026 23:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792986628; x=1793073028; bh=PFs+BYeVng
	QC02S0+cZSzjcUOCJiecs6BNaAnoxAsMg=; b=m3mF9C9Al6/aW3bnUJze8YYy8E
	/mjbSOTBkpS+R/NHv8z+XLaim8trDhaSJdzK3IJRFNd0ZHHf7Ubjzyfh0qRxwxMJ
	dd/Ezbp5fiIxLowP4ZKDif4UQSG4UTCP+uOa0Vz+c8AVpZmHrJkoB8FutSyn4APD
	G5ifC9NFR/6YSbFioOUZmq52qaWZ5hxQpEmfDQG54YZb8InmCUuBBXl8A1/YQ1fG
	ZxWnZWnZsBChVMBMXj3gjhnGzF26MvaX5Zi5aTqoHKChnw4KqesvGxgZHeBCgdS9
	j6gUui8Bo6k5ghNrkAgXgDSqugwk2zG3NlKy2xempKiuXRzjD24l9aLHeylw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792986628; x=1793073028; bh=PFs+BYeVngQC02S0+cZSzjcUOCJiecs6BNa
	AnoxAsMg=; b=cAvDwxn+RDcqjx3J+ksEImsbIVNS/Mp8BcXMZu5CYWNlNeK5+zj
	KmbuclNa2HKbgzenEw8xEfAUHamE8d/Z4tlJ8U2GwISAJSH1Jjit8frX+5SLG++M
	HR/oCiT714NXe9OKBFfj3G8HASrgLs+4FU/FPi3I0obluppN08WzS7GNF5mqOMpp
	G0DTvqt7Xmf6h0I2MhI0DaHl0vcIWsrV4Kqf2kQQqjk69oyCEIOH429hQUaeAth9
	JxuT2f1C/G2UXPtIMjHqmHvMKMCG3ha0sGLChNfoXqPQX2ARjuwoKW8+lyu5lqbm
	jRzkLQlTmUXia7TovvugfNQNlSzcStLamrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792986628; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:PFHbT4XBLuGBZ8OooHr0X6JEU69DygAOUti8jM7sfzfb6ds
	9Sf7w5kneFSRK6SY0loaHSBGpLywBe0b2POS5n6Eb7bL2KSzqHsOvsHk3gmDxfR/
	QdRIR8mZ1rn7r5Cuju+9ed0MKpu/v35tjs4Wy7R6S9QmNbBh3j1lM80P9o2/gshl
	Lf5X601f8HXEQDU78BURCmDM5Mlt4Bp09PDG5EQ1YZNTsqxnuNdax7Ndf8y/wKWr
	TmyoZz4loPUy14x9a5CqayEevjiDY/leBOVHh5bSUFXaDb5nuCU/qCo6jFOfx6a7
	RHln6d/KKHEsYRe8UICQUinn48pCqZcB6JLxctA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:X8xsoGQOm5HILMCEYhjpVUqXtDJSFaseDqJivZPE09M=:151h5wlLfCDNGwiYKXfg/L8QuN1opGYBLvTDP90OSaA=;
X-ME-Sender: <xms:BM7ealB_9194oFJdCTJr-wIQJ5VA-9Up9HR3gslXkS_FZ6mBGl1BHw>
    <xme:BM7ealwZUfX1cf_7M6YINYiyBQLxl3s-ej_nywFPnuWHJRf0W8_xgMHoHjGxoJahq
    l3mI_epzMPT9XIPNU4XNoAw_Z6Fo7VS6ctYytX4lD31pqyo9FFA1w>
X-ME-Received: <xmr:BM7eai1QZGT9g1MQJDhz-dR7SCWnm4LGgThj8401npQN2NQ8RZyLqVFgOHfWSQ3GyXg3dcYaYhjL_RuMaGhyCdq6arqrccRRiPo0>
X-ME-Proxy-Cause: dmFkZTGT4DlZaWdZH7jGYoLkoMwcqgKmJ2vi2ZdOAPOg307fAsnGSdvGEbLDDvdBRRDCFH
    +XCok1Vxc3oU1i5YCezl7WGmMpYtSHe3YRWFHK8sDw2Qu+ggf7RRs5xBA7o8cNjIQnhwBn
    SCLha+BynZtxpeYihv00uXGPV6/F6b+QRbnKPvNXhoQFCgm77tD4SeR9MNdC7wXi2NUMru
    wB0OSaZ+CWMZAriA2YT2Xj6QWA3NuZkuwfHD3mqIdvIcNQzfsbUptfI7D5aLReHsCKggG6
    aJC/HHDaOH0gUAvXrTgxpv5SuS2Clo3PTp22H/0JQOmnS09Qm9rgRbrRLYxTnVlKuU01Z5
    TKl7A2ZkvtmgXqgI+cCMKV2OdhkM2cqUDcmdKVbOz3bNleEIbD5sGab9H2wwkr1paTf8SW
    oBVQMT2yWxLzWTWiw2pmH5AF5eHGNRTWG6PU3EKT6TtiIT3Y1RAAtWdiLAvEceR1xxrJiD
    Bu5WKGC//NvsHOYY29sMoNegpXyjmHlUAW6b9aYauZfJlb7EL1Mo5/uujGh7Ftn0ZVwqox
    Fxsa1yY+9b8aBdyfKGAE9DtVn6W67imn4KHZDbF98/hJMIMT0cVPd/6xdUz6QmmyiRkM4G
    5nNaWMSKHlcjBvHlvjsuErfz5IeXen5K24L1g+C2VxLi7HLJ+r02k5EFvKGA
X-ME-Proxy: <xmx:BM7ealz_6VwOTJQ0-psZwebXQ5qj6kKMT8VB8tn2gnu0Iouoh-zs2w>
    <xmx:BM7eapE2k0MFkUDKovRNB0BJGoXPtYLeDPjPzOFyK6FfqsVGANcoiw>
    <xmx:BM7eaobhrWYxOaS2xOQ7Suus_ldFNbYvNwvRqa38bmQm3cxP_U2yPg>
    <xmx:BM7earDFCYB2V7vaeFispf1tMssXinVFApVgXqhEukZyAxeQYUxHYQ>
    <xmx:BM7eanGNcSEjNSNjOuAifwwLeHEj8cFOIc95zj-bxzaWPBKpI0wS9V7v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 23:50:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Tuomas Ahola <taahol@utu.fi>,  Phillip Wood <phillip.wood123@gmail.com>,
  Emily Shaffer <nasamuffin@google.com>,  git@vger.kernel.org,  Justin
 Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <20261026011731.GA3575069@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 25 Oct 2026 21:17:31 -0400")
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
	<20261021200341.378978-1-emilyshaffer@google.com>
	<CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
	<b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
	<xmqq4iedc99a.fsf@gitster.g> <20261024111856.8s8qu%taahol@utu.fi>
	<20261026011731.GA3575069@coredump.intra.peff.net>
Date: Sun, 25 Oct 2026 20:50:26 -0700
Message-ID: <xmqqcxsxw265.fsf@gitster.g>
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

Jeff King <peff@peff.net> writes:

> But if somebody is picking a number, looking at "git shortlog -ns
> --no-merges | sort -rn" may be interesting, just to get a sense of how

I very much appreciate the "--no-merges" part of the command line ;-)

> ... But if you just intersect "N commits over all time" and
> "has _any_ commits in the last M years", then you can get a table like:
>
> total    | Active in the last N years
> commits  |  N=1    N=2    N=3    N=5
> ----------------------------------------------------
>     200  |   17     22     24     30
>      50  |   34     47     56     67
>      10  |   71    104    124    155
>       1  |  239    357    457    628
>
> Those aren't necessarily perfect metrics, but if we consider them good
> enough and just want to tune the parameters, we could probably pick a
> spot in the table that has about the number of votes we'd want to deal
> with.

Sounds like an interesting approach.
