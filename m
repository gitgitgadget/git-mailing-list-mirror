Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817130;
	b=sDsf+qHCH2poVh281LFG/AK4QCxiWjm45OFFr6cmzqwew61YLzIKkTNGVNOilF3i7wKc
	 45zcEfa+Ru41QnvwigWX0nUVF2J4tlWAvS2JOHGv3yofTF+43uJraCx4qS5QF3QvZCqx5
	 4Q/cnkJHy0NqGF9F/RL+ON9GQ8f6Ij7JlsK1yiakhqS6hh/lDBH2cyt0U5pgHsj4eJM7p
	 fw/kKEkBp49fcfVJRNpsKNBL36Y5fbtZXpkKKqQIVfCt0naDorN6fAw30d0w5NLMqav2f
	 8HFm5r3o5cb+jZK1O9EwfYjCLuBL00knMrLAD8D2idz9I6/PV1iSJ1H/+wfnP/U1Lyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817130;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Q2zSh/Wj+OeBJeZC/NCeBbQkwC11+n4qmIA1E+3OlUY=;
	b=Ti1E7jxKKy2WNaZLPccKodedZChHCZ1EOHNBtNj171Tb6II5lU35My9QusqxN25yRjPF
	 dmVWsYLwsKZ7MISODAL+d4IMfQBgKtAiDr/TkEXJpSn9IFlJoRtizJToFDXBKW28ijIuG
	 j60Ln8WBOTb9oASWjjO3FADD35jQ2WoURtyTxBmnRa9N6lNO6ORQl9M7nZ+4Sr/NzxCyY
	 hZmabyqeqRIB4YiGtlsYCZpAcIdp645m6zS6V3A9VFshMijbyeLdBMYgyERhhVYuK/UPU
	 1OilOrNjEEckHjG9gHIexmJwHH/7ue5+c1uJEEVp4uRpFs5O1UzUVZGIAwwym4/LoPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bbXEOpY8;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n7ReQc44;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76272606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 18:32:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76272606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=bbXEOpY8;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=n7ReQc44
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 665B1140016D
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 13:32:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 04 Nov 2026 13:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793817128; x=1793903528; bh=Q2zSh/Wj+O
	eBJeZC/NCeBbQkwC11+n4qmIA1E+3OlUY=; b=bbXEOpY8DlycQI7pGHC5IaLf3i
	bnCPbmNjOc0qi+DyQ0GNpKvmGtZVdJiK02JyRTR5p3BnCH6CrrHsNOrtv6aHAwWu
	cWqgKwWsV/wTcJt4lunBuhmcm2HXROq0PVnoTGe9ndl2ZA5AJ9L2N+WHZtsfpmVq
	7rMCiarewwSYb3RrySTH0nWmRNUedDJ/LtPuG3KLeoNerHIkKoW75wSPS528vpbq
	oKN3uCYEuTDWNHiOpaBfCOGjsG4fVcct5Oiy+KwbuR3WbfHelCuXF3rhn7DktBwY
	JyhSWUb2qG1tQCDGKpHkatdBudPlepuZ2C4wASM+HwCU2KFgM4yVLEWfkI4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793817128; x=1793903528; bh=Q2zSh/Wj+OeBJeZC/NCeBbQkwC11+n4qmIA
	1E+3OlUY=; b=n7ReQc44j7Xh3d7nLw3sG8RcW7NPxZ2q/P9DSgyqODO9QFNe4B+
	yoHHvYMIDOesvLPb+ceR6EntaV7F8ZKNKIcQQ0nmijgySh8VBPO16pjAvz2Qllpf
	3mwcl0BOzSfjt/rOWaBtEflykTvfe38EeDCV7tddIJrk8Ny+XxKWQAp4xXUcjXnP
	7nD47B+qhNw9zaKu+m8aGq9ZllpH2APYNB6YCXX+dYiyzLMndhPK2F6s1gKBLmPC
	TbOvyvMa02xGMn3J6evOSqn/baWjrET3ja+/30BIghY7YxIgWylwVyMU0c3235oM
	hUlinJCTr6gjG60iMxkozNC+Oe0wsSFwoFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793817128; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:F+IPqgxqW8A5jHwidW69BFtTxSDfINMqbuMVFcq4GUTxoLf
	rKyF+NYxCAtu6eEG189x/axI5yrbbeq/NtbKFDv1B27aterhwaR7xd6ZBYcV1/FC
	oh/8yObXsEGHAKtWkWI55/yWDrOEHnMqrlGbDMvx0CkhvGemgEV3W8mmT5NLF4xL
	vFeALMfzWn8zOhOrLZvdWIrZKMv9FDvcpX4vQmC2BpX1DB9La7bplGf/3eH7P0/+
	kW8HRPOD9ONioySB4DHsDOK7igOE2zft/uHfAacRUz8fZ3O7us2hnJps0ciSgHqx
	d0sxH212HY86eG0HmKJeJNXO91NAZbBcmwnP4IA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:XYJeAkmLXkQKxD/E9xmDLVGQQZO7ithGwVE1a7mzx4E=:yMwWA4lVATrqstb7sY05Pverimv1Pwhcr1xzhCSWVtg=;
X-ME-Sender: <xms:J3rrakezkGjDG370b2myXgxTWXCkOjP7QR2XFtfeBNYfxIOP-LcDMQ>
    <xme:J3rram6N0eyaPQ_xAPswTCxrl0ZY7S9tDJnrJwXCxjdeCq35r32ZGn0GHpRyx3PVF
    t4G9znLve20JsZpKlHrkSQjMoPfBJFD3ws9JEfuMkZdjVaPdf5idw>
X-ME-Received: <xmr:J3rrajvgZidcTZ9ycIA2rMfBlmrIXtOSqSzt2DDKoXbfyl6396WNXdJWNCkZqdrooZZYZu0UDXDEdXGzT8MXINFBqx-vr-gTNhnF>
X-ME-Proxy-Cause: dmFkZTETSJZP4OfFUDfX32HM2AVyBcyX8LQIxQrIMlGWBXQj5A5RovVxbFjzOiBSIGAGmV
    TByFg8uViIjtBcxI/mC/rtcp3iDIHD4Oi4fEwiNxYcWqE0a1IXsTBisLHcOpHCeXas8Uft
    ie00ssxHnWykVQrJGjt39nGaIO2w0V7gePHqXVSHuBpd0ZrPT/Q3W5vIcYMcyNgpUrAGu/
    HHoONVEeEXp4V7a01AXohcUzNQH7f0R8fil9Z7bLIwNRM/jQgODYCukfIIefnpuNAZFsle
    XE+PuhXKz8vdk6M1Llz1bOs4K5PWTheL19gdRKNej7QKiGdT4LzLfQLzecahlFHwjZeWhQ
    Y+Dl3W1QurdPfTrSNAkTybuSfgsnBxfRugsYA7B2MPfMos5cm+KlxKSv+MoJqkwXJuTehT
    GF2Jnv/mi1wLlGmIEnP77gCryyVMBA624XvrkdtBy0HhMj+q6Aa85rNdpT6fSH+5wydMCs
    P12UjW9nrUq1IEV+0sb0mYwrX8m2kGcrd7fiNVdT6W6S5aba2UtLHkmsvukTudpguVlj02
    Nyb3K+mn+c3zC8RMzlaEN4UGWj6Wac6EGYGuiJcl5tdMKhJImCHjQyXM1bvWKO+1Qt9b6j
    K76B+nTvKrKvzpO1Dc8zUyfXHq4m8YygIbuanZA504RKBHU3BqpNGF4CvAnQ
X-ME-Proxy: <xmx:J3rrauja82YODkWxGw8Gctm5bVO5SnIu5htU61Qr-oELk0FNHvlgVw>
    <xmx:J3rramoAO16C3gqA4jbGW1uMGHIpeT29suKbtq6XzGPlUUDNsc_kNA>
    <xmx:J3rrajtkn_14nHzqFtZaBfp2worX51XmmNlLCTUwvaEq3DPKVKG2Vg>
    <xmx:J3rrahZt21QuBkjcd6A204sfx116AcyRUNv78YcElflDKLXVLG5g5Q>
    <xmx:KHrrahdX1GeTcMysa8spl0EGjv1RA01RG4Agd8BPyUfqAd_9SlqWFYxO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 13:32:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
  Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 0/7] ci: consolidate test variables
In-Reply-To: <20261104063645.GC1543013@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 4 Nov 2026 01:36:45 -0500")
References: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
	<20261102-b4-pks-ci-test-vars-consolidation-v2-0-a5485c437c62@pks.im>
	<0b0a3de3-b758-4a1b-b8a0-9804b362b261@gmail.com>
	<20261104063645.GC1543013@coredump.intra.peff.net>
Date: Wed, 04 Nov 2026 10:32:05 -0800
Message-ID: <xmqqik2c1m8q.fsf@gitster.g>
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

> On Mon, Nov 02, 2026 at 04:03:29PM +0000, Phillip Wood wrote:
>
>> On 02/11/2026 11:17, Patrick Steinhardt wrote:
>> > 
>> > The series is built on top of 37b3475fb53 (The 9th batch, 2026-10-25).
>> > 
>> > Changes in v2:
>> >    - Drop the last patch, as the reviewers seemed to favor an approach
>> >      that's not compatible with my own use case for this change. We can
>> >      still discuss this separately.
>> 
>> Fair enough, this is ready for next as far as I concerned
>
> Me too.

Thanks, all.
