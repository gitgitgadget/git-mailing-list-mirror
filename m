Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616475;
	b=ZsX8RpEA3CcN/0I9lJzCq3i9Ne5XI8vNlcVPJRpLb+peiaRpLDvUdPyAO0jLK9lOupAR
	 mV0EYxHMZTYm9ltv1JTQeFx2eshDMl8UrNIXSvxWbtNsyR93PnYAxLgQQGQGKRaNDKhY1
	 3RFxqKA36Lmt9SeH79gGmK67i13/Vq/7G5eYvifXOR0uJ3eZ27X4CLg7l8XW6uEaZPuzD
	 JNxqW7jTNNJNdY1YvlpD9lwT+wtRhhQyKerQ+GbHRZiYEbbbCeKtHQZPiI1ywEh2DrPDt
	 4+WI5AynpWpMsPOX3oiqr2hzfVRNZrLb0EvyLMfJCvkUTqTtrNI9BNvhewlBUjJMd9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616475;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1+aIxRExnWo8tsS5ZRj7UWvFCgViSArxi1WC2gycE1g=;
	b=nk3NchVzFCK/DrrpSh6K7j3YEvx9b2jg/jT9RQ+L/M2GH2r5/nY35Gn8Seb+gmZ3AOnq
	 QJh8LwCc5a6R8AnlplMnRbNgD80mEMnfXm9ntqtDTxEoJ1W+HExCa5w2La5taaiMztH8q
	 DpIb05wUZxEZ1nmJ0UkQv3Zjm8lJcYV/waiQrFa6MBNGrTEbuR/50tK9iLfUxhnTVgGqj
	 Z9vv695kEN7MO6WPf8OrgOoUS+vh//+lalN41cvG0f0Vtj5kt6rbc/G4RvgY6rCIYMYDA
	 aHC8RYiR+zFAJbioaGtI7S6o7lMtdP/juuV9Miw/fDqbKuwh9sbh0MKHLPQeL/NiGiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="Mwz/SCBL";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n1PyxVh0;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833ED606A331
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 00:34:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 833ED606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Mwz/SCBL;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n1PyxVh0
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D75897A012D
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 19:34:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 19:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794616474; x=1794702874; bh=1+aIxRExnW
	o8tsS5ZRj7UWvFCgViSArxi1WC2gycE1g=; b=Mwz/SCBLcAbV84KYUPVoCPdspc
	KTgk7Nx3+5v72uupD1F0gSR4tJDj4NpN9tX6ukO3QslytwaOwphbpf2S8/E/n13q
	LQP6RJuCsOv/MEUUr6NazdO7LzN+Twb6WfY9C19h5H1hJD3mxER0p25qZ+5++UDM
	NdJNtjLXRV9u6KDnByq1sKPh3eM17zDBfvA83OUtdNE7ovDou9UNOqOVOYzriirq
	pHfs+TdihvVuqFWjdusoc3fjprbV5mLRR1/vmMSRxYG+KZOvCrxWD5fOE9pScrgG
	pztyG+MFlcD8xDw7d/qVOHfR+V4/mp2jl8IMproM/na2SQJ/VuPLElJgi6Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794616474; x=1794702874; bh=1+aIxRExnWo8tsS5ZRj7UWvFCgViSArxi1W
	C2gycE1g=; b=n1PyxVh07lskOt2HHFTf8B2WbePHRySsANPgIgj7J69R6HFQrzF
	mzI2Y2BLc8A8CKSEd3yh1tHQB8kjpJU5CIXPoZbN7/zVzu+X5BRWpPS+w+Fqlkfx
	cF2+kIqinDy55JxUlstGXi+7XqCJI9kn5cxoKUUSvGGXjNELurkgpFyPwLdXTDXT
	1AJzyJrEcO9LXRVhY6GBr4VaRL3eXNyv84OOYUcqH4PTcG4OS2r+4ttDqAtt3vSR
	11/F/XCSu48LJC2yqw4Xvg9hwHw/diL/084iaIGzdNQ26IpWSNmVxcvwuWHIKmlX
	+il1H8L1okhXmByvzQS6GDoI8ZZgiz0ZMQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794616474; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DFsfPvr5oIiKkcjQ/GwbSX9mQX/kLo0P5lA7uNFJlTJt8Z8
	X0Erm9b2zlZNTrvoWr2WgcsrETixyjvTH2kUkhn6zFtAxsakYvw/Zn5PgoAVuEeT
	buMALRFUCg60T5RO2FhtIo4etl9R+N7mD9htUewieIGwBwDr17ml3Kx2XeNiBifR
	gLAK7CRcta1qiSSXCHBwHUJz0gx04RuY0aZIozLYvbvk+Rgv8oqI52LPwfbYPlHO
	0OW5xsUBNQOr+ouSp1rW/KsZRHsZmjnBzmW+6ksMWTkk8CTalcRjfYQe7DQBgztb
	4KS/1HIKZlaTodPsHJOj0eM2hHGqqkNS0Xm5l4g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:DDBCWwOIxSl9tACeSHm/8MvZyxcx/hIdLRArz0w1lzw=:TojcwtMMh5z2teGC9L64gQKsJjoAIVaR6mheNQ0kOXE=;
X-ME-Sender: <xms:mqz3ap1021XYX2ttkUxqjOmT0bV8qLG3_gwwVEm5K5oufbFhJJQX9w>
    <xme:mqz3aniswxGt0itYbw09RRi1mFOHsJL9nO2QEGKEiomu-DY8b_fL-Uq_tuoMNsAx3
    hEPfU0F2axZNJTjATqv0G05SvitcFrtAX-AobVUry4Ej7NOGXeySCE>
X-ME-Received: <xmr:mqz3anRHYqC8ahPv8uNQTmjZwtEoYXOrsBaRle6kC-JQlxnh29wxjZVUuvJlITZw0pRBrJEOzOedWXNvR0Ncbxd6zakc3A3abYhE>
X-ME-Proxy-Cause: dmFkZTFBSBHtL11WlFuchpMYT5jzmKDx0sIa8DKKW4WIpWc/C8aiHwx3vPQC+uxfl8rLSQ
    Av8EV56lW0/fr+Rzbz/82Z0QTW+rF1nyrx45JWdQzK8jm5Nipw8by/vj5FdmRghEHOGd5/
    4kGLZScwgjduAzvLgaQDrwEj1LRQnXYhNydzPB14XWHGEIBCVyNsN71johOJPTBTFN//N0
    j7f+7DkDvkc2h9nM0VacjpXkiGVlOwyLmsRilNGT4QzcnWEy25aMTl7sHoUYuw36ulEKxy
    Yuezk8jetxZqOb7ai820HdQ9EPVRPtlX1Cqn2uu0CMYpEZyUD0kMCMykWaqYa78S16fpDf
    BIZVqMCOU7wLXceMJ/MHxSvgiYkik2Gf3OkerliUI/BGtxkQuR2wgvPNzdbIuSnGvlzT74
    QfSgbkjp7255Nfsi63v3N9luQyYRVtxp3E8h+dmhv9fjxL8L95oSwQVKefmYuRkq7lsFXu
    PqI6J/6KmEIvJOvSA3otu00NDSwUZQIkgTzaIrhMhC5z3Hq0PRqi5s2y4xFNd8bU8rc17j
    iYaNZRmmTaqNAJHtiOyoG9J9PIqneXq7FKOQbXPUryx5AbwL/rYxBh2fQjMHeFjW/PoEU4
    HMVmtksczTT1koRPgsgy1JIdMyQrfPzUqA4Y3PsLJDfnEAcdlzWf0xU5RpGA
X-ME-Proxy: <xmx:mqz3aggoxfVA5-ZteUygagNFFx5_skZF15fNpSykFMkqKuKYFqyHEg>
    <xmx:mqz3av62qgg2bP0Qt1Cpm7TiEeU5nf02tqWj5ne0m_myGSxEO3eBRw>
    <xmx:mqz3alCf0REUfZSeUe27qc6rxAQbiCLXwu2IRMtalS8YVquIcNNYGw>
    <xmx:mqz3aua-9ZYjep-vwrA8bWvNXmKI4L5ybY7OhOOiSMI82erHASQhAQ>
    <xmx:mqz3anMUTDAEMycXvkNpAEjPgc4SMqHcPylMjOyLhzi09SOQcHdFjAf9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Nov 2026 19:34:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #05)
In-Reply-To: <avehwsI-uOJ6DldC@fruit.crustytoothpaste.net> (brian m. carlson's
	message of "Fri, 13 Nov 2026 23:48:19 +0000")
References: <xmqqpkw9fwc1.fsf@gitster.g>
	<avehwsI-uOJ6DldC@fruit.crustytoothpaste.net>
Date: Fri, 13 Nov 2026 16:34:32 -0800
Message-ID: <xmqqcxs88d47.fsf@gitster.g>
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

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> * bc/restrict-hex-to-lowercase (2026-09-07) 7 commits
>>  - hex: allow only lowercase object IDs in breaking changes mode
>>  - t5324: adjust tests for corrupt commit-graph
>>  - object-name: use hexval
>>  - hex: label usages of hex parsing for object IDs
>>  - hex: make hex_to_bytes accept kind of hex to use
>>  - hex: allow specifying hex type with hex2chr
>>  - hex: add functionality for lowercase-only hex
>> 
>>  The parser for hex object names has been updated to reject uppercase
>>  hexadecimal characters when running in the breaking changes mode, in
>>  preparation for Git 3.0.
>> 
>>  Needs review.
>>  source: <20260907195941.1024289-1-sandals@crustytoothpaste.net>
>
> I would love a review if someone can provide one.

Yeah, I have been saving my bandwidth and looking at other patches
after I saw somebody else volunteered (IIRC it was Patrick but I may
be misremembering).


