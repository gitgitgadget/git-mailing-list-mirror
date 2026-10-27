Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793134800;
	b=U34IGsJrIzQNWhfcr3pEM634OL6HTStlizA0lP4qKYbaiXqJxFwWtjh9r/ObFD/IwU3f
	 8ADvO3VYv/oMbWYt3G/HTmIWtLFGMycx895zp1olssgBopy5oP7pxGxRIq5bsBl4lMJQP
	 EUghA0hyMzo2JO+QaNqJcvNDdUHf/r2Pmaz9eFT7Qg5EsZlfDFBuAExfHAQGnSACRk343
	 TdFusnoPz6gJ9R/B2OalM/DGK02IO74uLJ4RxNsUU7/P5XchcY9/etBwpb/VHJ8YxUevu
	 hcryy8QxHeIyFf9L3XVY+g7bcN0s5G3ba2V70g1luytXJW6AXXq+oIpnebZdxRYsEeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793134800;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=SByol0sFDyBNkkQr8f4ssUu6EreRK/JC/VBkr1m0LhA=;
	b=b7DgbvOqMXLJ3KLPqInEoE/Q8VugItOnS4M6pZR9epWfBgzs9dSaRnZS8pN5WHWXpRg5
	 HBj0ZTuTI/fXLeeubsRecubTxp7c50r/0Mmnvfcja29ffKD0VonuR1Mp8lsMUdflmE0jZ
	 EpO4Nj2DFJirRxYY9ry3OkmNWwz9gER1Y/wCY3dpHG51inH9vKTo9zJKZ61YvNIwEwY3N
	 P5mFmR8z6q+MESc6y0KCt7/YCUrhPWXLXPOQZNaJtwQURvF80TskF1w4qaX0u2YtmFY8u
	 +WsVYK2epEnbYv0+kto5ttriHz3car6b+Ou52yMp5qfOi8OS3H3Gw+x10GoN4Hvn7oA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=FU9tfA4K;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mHORJ714;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D43606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18D43606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=FU9tfA4K;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mHORJ714
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 73AB41D000E9
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:59:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 16:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793134799; x=1793221199; bh=SByol0sFDy
	BNkkQr8f4ssUu6EreRK/JC/VBkr1m0LhA=; b=FU9tfA4KV2lvyqqV6SCI/5jN1c
	RxF9ppaKoUUaunuW3LRMM37ZRptkmPG9O/jD3/OMm5gVb5qz4zctw2U3fiSILbkO
	oLpHqhe9qUpuBWxsaME2+jK58nvtccZUCaKjDoTKVm4fPb+12oEEEhTfBA53lUzv
	2oxiFC1n6PEaJlrIeEPLfsrJQfsaORVfuBXKW41vML4Ujl9ebX8waODXUvc1OTQm
	Ha0cPGlayi2iUbqErT3jqg44c6ftbAYFlzKOsvIR3PrOcHt6I8rfzrOSe2RmAPoq
	h3M4N2y1lJHNyc23drsHOKaofmyoYVLZxTxIqocXuEqZtEq2n0ZmUqNEhApw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793134799; x=1793221199; bh=SByol0sFDyBNkkQr8f4ssUu6EreRK/JC/VB
	kr1m0LhA=; b=mHORJ7141eWpgZnzaHSLMpP7k24QL513WY+wM7IdMSPOF3igkov
	8+JydemvVlYswKGJF/KsQ1jAmezEITLUydp1EvOK8rYFTjS5sXjwFRqqd3JQmolC
	Eu4qykCLKtOEfn+uyn2bqzEefTbpmqyXdSaQYTD41rHgOCpvjv1I84XhGm27x6V2
	KgzaXVVofHUys79stgRinjHfEY8exP0HrCJmkrTlBODHIC1wSUP0/kYbq0xVJm6a
	cS46r1X7TefPS7duOyBiBIKw/YUVAalB7RKsGYly2yWOAEye3JGIuEmcay97Snpf
	fE9g/WzGl7w2tBP3pm+0ZfIeTu7cMm+B75w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793134799; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:OauLxQui+Cbo0kWZNCf4Vq/4tSjjrMo3hCoqE2mCsRK0bKm
	X0xb3RiE1fxp8jV1zXNhSc2Vbo2FQxycC5YHivIwbX2jjgm97XXZkOKiOg4Xt0gF
	r+UaEuR2gVuW57iHe3GFR5chk9l0RvrpYF1VKiQKsoIqK0YfMlCztCswfdrfQPDG
	lioak+0lVJynxkxZVDK4IfSchFynS2P76/vn909GjQB4RdSv9oS2nzmjQNNc+TdB
	1m5TzusrJiBqcLFFM0VVNPZBgVy2hiXWVMCkg1I1N1VvgnKUfzN0aUM2vCOpYYDQ
	fqy4MvVxy8NQjodZaf5kRQD/EczpX4l7LkixnZg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NsvDw2rdTnk1VuBlm9aListagx2XFQSFiEvwuyra9i8=:LI0+uInI42dYyoezEiARnLxvbGU48WBVqHxLrWi1qGU=;
X-ME-Sender: <xms:zhDhaoYgTOa-qm9Nyc0hzZmWPb3FvC7ef9yMTQHQS1hVilX0DSJZwg>
    <xme:zhDhanF-m5qE0w1IcdzlgWwDkSwDCxiCJLIAeHRAvH2LF9t-GxYO0h-EU8HcjLz5R
    G2EntHmdc25VZpTrZDC0Ua19wgKcxuZk5H5Wlrl1PNW5dcxn_B-I9A>
X-ME-Received: <xmr:zhDhasy2vV61XltAiwHvrc0NT6XcyWt6AED7tjqbYn1u457kXFWqGziYM0_TcVS9c8Pgav4QLPHU7fOfvJ-eNWr9U4Y-s9j5roWD>
X-ME-Proxy-Cause: dmFkZTEsDnenF9V6YkU4kq3326u4mQMo/1KhDz5cWD2P024f7Gl8YDdtv/qGr4gkgTVwyq
    oMeoYwjonT+si09gdU7FpW8HCZJq/WaRKZzDUvQ+nCVnfUmsDTrqs3hx3SD4q7v6KZd3wM
    qpydwP/yIiEtM46KvR+b60+e+ND9QBjuQdn3r7IuVTvLRaKwnqtFRQmnrlB+jCOx3j1Zi7
    qc9Yxv6Ldhn5dZaLCzD9L6k1r7UxqUZqcsCf4kmtrRHnW6UQtFvlPdr3RydMq9+Z5OJudy
    xUxzJ5sCnXfE/1JYI/7K9/FaJvSJjcML/rYq0LiSUgvHaeQt6Xn/WcPje1FMBcVhCQtDEs
    6lnrfMfBVYZkfNa8lHObOkA1nRmAGP4N9yJSXRjKegE1kGrdzOhky2TOP3x15MmLhXXwfn
    0mkBVq2JfjYoS7w0BvtH7BcqpsBCONSB39s4c97W+3/s2/OsXraMM1QN8ys9rCDbGszA8d
    Exx4u4byh94eVxJJzRNdlYGopEMFn8N77RCcukFAqmXN1nhzJiw/t2CrnEl+sWjON4rkd6
    shJ8Gps3rs3VMOaDKjTdoThCN2P5jNfNrElcR1R1UQP2muBfFESGWg7QdCCxTpLBaWKqOT
    rKxbBoqREdRC2Y3E9F/bhQ3vQ9CFiP5xcnFXrpttuiGg54nlcgTiD3og3y2A
X-ME-Proxy: <xmx:zhDhapmM_xjHvrF0VGyHlz5ESEPdCFE3IKtha3vb2Yf48fGki1Cq9w>
    <xmx:zhDhalkiou5uC2xwlXoAJe48gXg5AZ5bHwye6MXLwc6Nz-jysg7C0Q>
    <xmx:zhDhary0IK0aF0wlEKQGU0pcCnD6T-IX_FrZfN_1leOgcIOiLqe-IA>
    <xmx:zhDhaqpSpsxvp9D8VW0EdPoDMR50EpRnLfr0z-6NPaWgkCv70HcDWQ>
    <xmx:zxDhaiK6p0OLFZD91po2geloHZYR3cC-Ut-2Yrn4PH3ZYOwwIUML3Mhf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 16:59:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [PATCH 0/8] ci: consolidate test variables
In-Reply-To: <e1d49985-0ce5-4411-aab7-11d90969363f@gmail.com> (Phillip Wood's
	message of "Tue, 27 Oct 2026 15:00:48 +0000")
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
	<e1d49985-0ce5-4411-aab7-11d90969363f@gmail.com>
Date: Tue, 27 Oct 2026 13:59:57 -0700
Message-ID: <xmqqzevyhnaq.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Patrick
>
> On 27/10/2026 08:18, Patrick Steinhardt wrote:
>> Hi,
>> 
>> this patch series consolidates our test variables as a follow up on the
>> discussions in [1].
>> 
>> The series is built on top of 37b3475fb53 (The 9th batch, 2026-10-25).
>
> I looked at the diff for the whole series rather than the individual 
> patches and it looks nice. The changes to move all the job dependent 
> variable assignments into ci/lib.sh and the removal of the 
> linux-reftable-sha256 job while maintaining our coverage are very 
> welcome. It probably makes sense to disable rust for the sanitizer job 
> which is aimed at checking our C code, though if we end up with more 
> unsafe rust in the future maybe the balance will shift?
>
> Thanks
>
> Phillip

Thanks for writing and reviewing.

