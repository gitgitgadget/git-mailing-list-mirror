Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204035;
	b=obZWDnc3L6Sz1JWH2wFsntWO3veU9YJ0xzTmibnYIoqP3bl2Udfsg3ubiaUUKt8/P3Hh
	 NzKgKEj+MrXrv9savMBKpnYjzDns9EEMl4xyRnjXAGRNWb+eDcbfghI2oOAYupJ5TNiKv
	 SqXp2TAWCMW13wHkOznreBXfDjJi7w9CMnUOxC9NnBqQU0qmSIXWhxj2R/GzgQAMW7oeW
	 rtZU7XydFawHg0EG8QagSSbXCM7XuM0gFTTYtHt+W3wam9QIPaTwFrWQmlYRj/VFcisFQ
	 iExbiJYLQteu901pm9hz6t5kl/e/s49kh+cFSyIXzcvPvQuB5jl4GZKR3jY6X2FXWvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204035;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3XUkr9DSqkrkzlC5BZ8Lc0a7R0DeNjlUyt1a2Iz8LHY=;
	b=u/Bs0vhuJrRBu48zMks7MGg1dXAZ7AsC2fxe7BIl6DhJVu+VgPP0yti0NeA0xCl6nSIW
	 DIp671F70A2mccUO2AGZDrVfIfQM/Kzl1L+xDoMO4Nh8cy9qxpswglNE9KvPSNqqG+z+b
	 08Btgb0WLEjtWtBTIRNtqr9bNlvUFE57VVHZBF614cJlFyPFPyzeYCXVt0cbaG0QP+cE/
	 jyu8LxeAY5R37eWdgzYWlcVvC/BYAZr99J+Cx/pn5n4uD79s3UOrQ/SxGCNHg/U+nDTzB
	 RmLMiehXgcYUX/HiS+z0t67ZF2XM7bOlc8TttZA78ydYfzl2xYrfpr6cNikFjjHI6Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NHee40Di;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ecrogwKj;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB57606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DB57606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NHee40Di;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ecrogwKj
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E45D7A0112
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 12:13:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 12:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793204033; x=1793290433; bh=3XUkr9DSqk
	rkzlC5BZ8Lc0a7R0DeNjlUyt1a2Iz8LHY=; b=NHee40DiJc2kH4Og1LmTwt5L4B
	S4JxAjXqw/lL1SUyMr1M6g4A0mkjB4E3yRTRZJ4R0h8t8OE7DLsrt3wXszVpyprn
	MneD1l8+kQAk0oZVXTqpP/hAjDSG+GSccYtllJytMnw1hg3JQIry8LCKLLM9lAV9
	ca2kLUvjJZbv23/X3wGvbzXzQztOFpVEltqdxaflp8nEnM9/WoDAa7izrVNuBZ8W
	+qT/VLHVAfOQt1lmWBLAiiLGBuGmxw4bpcikL3trAABL6h2QFmUjUFc6KhHGSlz8
	UbtmeLnRml/UWJkG95iHH8e/UOACR6pqA+SLowg1+Lezq2alhf38/DRzANTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793204033; x=1793290433; bh=3XUkr9DSqkrkzlC5BZ8Lc0a7R0DeNjlUyt1
	a2Iz8LHY=; b=ecrogwKjXNwgUCk1VT+6GXqm2mAIM7uMwAbXGDq+qdPmJVwxkGP
	ZbQdkwZ8wDKveY7aseGjNLaf8owzrLeWDaot61NDvJjscOGZW84AJamFPJ+HtXSO
	9kxtKbNhLZqezaYoOto75y2NJYbyKP09+5i/X59y/uHDHlWc4PLFLzSym6X+Q/PF
	A1htQrU5sZuntTgFppcw7qmzVEfBKgtsEiBxpWsDHZCUXbQiAstQ2IcRzqfCERsI
	SVsVuxCsP6A9eybxRItsKaeD+gzgaWTvg7uIsHNloNajEbjvUl5e/S7Baj+RhL90
	RG5gRjpuG0QI3DIYI+oqDZ4tBhiDCEbDUqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793204033; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hn2LgzYF8NBjfL0xCNYt9MdOp3QrDEBiFFWwH9ZNaOEtnQg
	9t27/spQi+i/iUhW/dDqgfo1xl5yXw+sWYHaPB7Tm0w6fJRGvFKkHzFdLsxyr3i2
	EVOMyravIxD30d57E6sIm48xhIBr7/PB7G4aV4AcJ195Tqb1MSVbJFCjMefaBgU3
	e5JbScHzhxa3gVyPlL3cfO2vSkUd/YO1jHMmAYoAAeaVBxL5RCBi6PpdTYbvNGFi
	g2oPhE1vqJbpMC+bMuxFi4a4NQlwRTMV4Pm9stxnpEl4gaD03TdmBE0jUS24n89C
	V9QTFErONHl3J+x1n9h0xEUa2KPOkjo0VYEVgsQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:GijzKEolouzL8TVUsN7c9Bc8JfMZqHqNps5Ct+IOqYw=:Ph+hZ6vc/WJg9TO/gi9QbIf27l9F0SD+LxMUSRAVSHc=;
X-ME-Sender: <xms:QR_iahcy8lf6b1ZynclQKAQriuU_e_Z1R86To_Ur_eF4S9LMRV8Nbw>
    <xme:QR_iahzeB11VmnoWlKVh4wKVpbRcMBtB-va03g6XXPl6IJV0iypPr9x8rMzQKs1jZ
    TpWgHytMjctwC7WneS09dgReoRSblbhgAePZaJOoflbSvh_IiPXMX4>
X-ME-Received: <xmr:QR_iauKO1D45QBSTXhvyv2Bhu50CJRX2yYZTrEC7w1IMgLfCWF70aQp9rvFjJJYWSUZKH5-FRZzBeD2-wzDCn4kgbjJ2vqYqO2FI>
X-ME-Proxy-Cause: dmFkZTEfRSWYCsBRzMxC+enxnMB0axup94pQfNmNhxzPfe9AfZgrxlNB+sejBUoQ6rpFTy
    TNtH6+hHdvhCuK89Pv4cbO5qg1KM9h0TJd6RHWUnZuP+lt+H6bm0P7b2s+EK4E2WWG5e3/
    e/0oiwxXu/DH57CoVuBez7HK8f3rjm25f23nykBQXNvlx/Y1G6Xkfsc6ab6HjVAHljXIMj
    HpKI0GZBUMWb8GHoLWLgl+DrSf+FPuxXz16TO8iPBd9ddnGt8LRSvbuWvp/Kz90jb3vruP
    NoKGO0BFL+VY/HsCEhAO7tDeRiE1396trUIfe9OqucwSXSe3QWa15chWRW5cuqgwfTgkRE
    PeIRuqFVlfLuZTr9r+VPrC+FFBz1zIzN07Gu2EJiE7PqtojYcT2jsHieI1Nd7EqsozX9h6
    M0td/axYhltxg+BNVk7vefwFj31fo6ks6N0bz7TUGF8Z3tN2H+VacpWtob7HWyjL2AIgtR
    Bhoej4Q/VsNLliN+RrpuH8tZG8Ew6nVp/73DBsaJO8NvQbUGaaAveSj5mT9OOQ3CV7J/+/
    LUUs/958/Gb5wIh+Hi8cDJFrDr/lVNqssOQFJAQ+4x2ZZtkZia60FBnfQayJtMSjJn7fQf
    KqpCy/OF0NKI4u/vGWtVO8Qz5fQt/4cnvtAFjgUPm8G/AHmK8vgRD80vXX5g
X-ME-Proxy: <xmx:QR_iarGXxHo_E-sdeoMo6Tyy57Bxq0_laGBKBqvCF0qT4yR8Gonbug>
    <xmx:QR_iai_MqbxErZ9YU78q6OLT9UVVZ_R_T9Vs9NMJ1PCp7T-IqZ6HxQ>
    <xmx:QR_iajLgs_Bur4aeGJn4RhZmPc03mjw7aNMx4nXwXT5eyPj-O43w-A>
    <xmx:QR_iaotdIuvBted2_rUpFBy9wjXNtIFR_ttiiiQKACIW1QzOHhea_w>
    <xmx:QR_ias7jegSktXnvkVubnR5oMF6sQyXtthdGlD70lNj1_HZzqC49actu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 12:13:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH v4] prune-packed: remove USE_THE_REPOSITORY_VARIABLE
In-Reply-To: <auGiFa6QsNLPWK0h@pks.im> (Patrick Steinhardt's message of "Wed,
	28 Oct 2026 08:19:49 +0100")
References: <pull.2266.git.1792341073005.gitgitgadget@gmail.com>
	<pull.2266.v4.git.1793120342393.gitgitgadget@gmail.com>
	<auGiFa6QsNLPWK0h@pks.im>
Date: Wed, 28 Oct 2026 09:13:52 -0700
Message-ID: <xmqq4ie5dcqn.fsf@gitster.g>
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

> On Tue, Oct 27, 2026 at 04:59:02PM +0000, Shashank S via GitGitGadget wrote:
>> Range-diff vs v3:
>
> Thanks, this version looks good to me.
>
> Patrick

Thanks for writing and reviewing.  Will mark the topic as ready for
'next'.
