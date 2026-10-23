Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792731403;
	b=XZE0Z+5x8D21TuvqywZbecILLUpgdcq+Fnv0SPySpO7bwLt9t77fm0zJz7rLYhh3dIs2
	 KObMf9TuWJ/lthwyhXC6AcmFWlaCasLkXkP5msW3M96mQg8FZDA3gkdCtww6F248E3A7P
	 Dhb7K5mzAZUvCDr6JvLgt5M46ETXUE6lo6mW6RvLi+YBvFBMr+iPGderimuTA3Q/PyxbO
	 30yq2G/D8ddAQor5fJfgsNLxAoKB4fbLox1kJLZ8HCLP199PcFmopzelHAvzH06Gi9ZRt
	 kr321X5+EpZGIzrTWIBIk1Z6UOjf+CGF7HcZ4oUwPU1RLMiadtdrplpmIXovlTqwwew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792731403;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=od6XGDK9vomaoI81FXjX0R9fUnHcB4M05uI9ekS80n0=;
	b=c0Rr0oVUD0FyBfRCxaZXCf7Rmyq2/LmDl/2Xbtnxi2a33v/PUREyzUAOg0m7miWZ1hDO
	 UTGo3pbIIUC3LRyThJVDPmJdrvIDy2RclaMglf8Hr4h3XqMiNLNmSNA8eIth6TWP9FhW0
	 wAXPxqb95PMcXN8TnrORz0eTAsInkb1aNEPRHt5m586Pz87A9jRSuZDw9hFOzJhsNsAWq
	 KXGe5c+bp60u9FSMuDqVXgyLkMAaAhjx8B1hlsNe465B89N9JaVIDZui4jlDWEGpurjT1
	 HCY2fRmtyJagCmnXA+jomm2BKHG3IIV1rJWRX6C5jVlSEKhhjQy83S1N4x9jyN46wKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=BPkyp1UO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cRkIWpCM;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624E1606A319
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 04:56:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 624E1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=BPkyp1UO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cRkIWpCM
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B968814000B6
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 00:56:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 00:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792731401; x=1792817801; bh=od6XGDK9vo
	maoI81FXjX0R9fUnHcB4M05uI9ekS80n0=; b=BPkyp1UON36HDIWdrnayGnMNwv
	wUMuoBx+6U0n6xz40h/yAQ0QzTdQp4IRdMMZPOQJ0uX3WB5i2WM3K7yg114HIIDF
	y532K+QFEDrYSXHlbSRcyvLvBj5UkKYNuc+ua5jilJ8CMIcMhtSJLnQ+hXh/znH1
	XLyDJ4lxienEmbbvRaPYIU39XeqTvmri4o9W9fNvtb5777FK1HH97iwxBYcs5RA/
	n2PBRUI32UFHiQIJgEk2dJUyGQXD3J47ANU5WvX3NJ74PDJZutWNu3TNHZc5j1Iq
	k4znAhKigyCJyK9oHrR+jR03yHV24KSNGrYjx1WvTYzG/qNhyVVnPC2g4V4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792731401; x=1792817801; bh=od6XGDK9vomaoI81FXjX0R9fUnHcB4M05uI
	9ekS80n0=; b=cRkIWpCMcCbHJLdunCbexYazVRQtgVGVSfkfKNkhaSoLx531fD7
	ZylfKJt2J6upNDY3sMftTYcvZm+oOsu21C/Iy/IC0Vlab6QziX8HdhWspXcaScqF
	XylVivC95dAD83UuMxdke2xrKLbq2IRyychke9QBYKbZwTkp8oanNKZ6djXps7cy
	BukXxrpBXyRPvHIZ5QL0WnHvbUIUgJrlSp8MOGb8ZvEyLMCsS1AxYGpj59Yiy/Xh
	2KEJXvFFGQCByzK5kfNdkzwPlSWviYkqi0iHuBr7frsWooIsbZo0zARwPEwuLB11
	U8TvtyCCehSLUuPe6ZFeQNt+jtZ6cAweA1A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792731401; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:qNcRltbfGrdIEk8C+OFj31jPZFBNY+mwkXTwv3GIiyLNtif
	GrWv0zLd/ZYeZ2JLtcZEtpOlTJCZaDSRgBizVDEosQ0dx7HuxBYCg8YVgu0gJaou
	kf6QLnzN5uhPlGGsknEpLt3OeCtiNc0RsQgHX1nvwpSnv9vVHJ9+uJbdZSfRwwaR
	JU20Mx2wblX3UVcRdGgtfQp8U+CltlZ9snyj/DtqP8Txqqmjmf802mm+yQVfVdTc
	r6dX07PMjTHPcFYIEI9gRu4ms5tx6y5mGCI0SCt0LBbtitn6LI24zWmUJ98n4U1g
	l0o2VaslW8sBgTkS+V5NilGQPkfp7XWqbww1ZFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:aIvuFDyVlAyAi3RZ8XIeUG8V3o7DNUq14fjFyfXITCA=:b2h5KgBsXE7Mrhy9Q6k5O+m+BUMStB0Gkq4LsAhct5k=;
X-ME-Sender: <xms:CenaapaqjOwtIgxJ1e8yNLlx6135cLQ_05bC4_gWYcjA0Ttc_IWSlQ>
    <xme:CenaanYmntLFm6qTptElvsT2DzfUowQB7_giJdVUVydwGFIbJfAqzFwZspu5Bg4qs
    aWweOYCF_kzO0QeU58edu4g6wBjvBroShMgug5cfTjuOihK2g-ftw>
X-ME-Received: <xmr:Cenaag9ylvpY69K4sh_TWgu9Pok_DXXuyZ5guIyXPuad4Xj9WFBxrN241182Jx22MqSeJBHqZW-AYNwUxfJuEzY3TyOTgR3Mrc5w>
X-ME-Proxy-Cause: dmFkZTETTJsUvVY48n8KiL/Fie/IW2cRdRPnZBZJSjFI3ZK7gJ3V8727Kgl6gg7epmo5lm
    HQjIdmCITpaFM7kB0L5aJ7b2tj6XB6l5Hx4y8enZPqjFzWMEKg31j7knQ4GcT8aML2e3ED
    kHfRvJaKXyDsU2oVdxy9X/zN+cgw6QU3CNHQqx6hRFBMVHx1sDmk4RZBz3+VcXmbVH+ZMR
    vi7NLvAFlUXZuE3IhMg7zb0T5GwCq+bZ2NYE+AK/VVDambz0N+KzC2B7l5JiZ/d4DqRR60
    hwgX1GckxTJlnsSy83tw+nFlzgcoJPkIyJstXLQK6MenN2l1eo0ZU+4bDlLnetMJ2dWIT2
    2oT/XCbvbxF+usEM9olBQlJVG+brAaYGLld4Q2k/N0SfHh56vF02WYGghtiKONIddv16bQ
    SFEiOGNW79q/0aHHmGnyOChrjLF+BPIZJh9h9MOvcYu0LKwO1nSbdgnw7w9Ia4dEtW5RG5
    IUjknyCNoEF1BwX7WtTdYKVFyR7wFOsXd6W+jLY2PA77QC1Zz0RPD/A9Za9Sz9HcGgqDqh
    elBnEhBeRAi0V2js96TbwPew466LTnci3MM2ux+bS4jcxkyuCY9gnuyPifEXFn81l7s+PN
    krjLdN9DWLzHW1o20e8zROivUAtIoBMs0fVSfrZPdn2b+36VZ3+9xvqb127g
X-ME-Proxy: <xmx:CenaamgYfN3GfJOpZzPOV0Vwb_7Ag9ONn8Okpp1zjNv9eHb4XnycRA>
    <xmx:CenaagcK5Sja69NheK_snCC1uP-Nr1UnO3NuesMgqKfgGWW7wqXMTQ>
    <xmx:Cenaatrckc8AXUmmp3kkrP3uZv8yzyAPseqNLR4rEn0KE8snqp-f2Q>
    <xmx:CenaalD4aZqE6oq0E45sJcB-PdnqZweF8MJZEl8dXom-PbKkOJGMAg>
    <xmx:CenaapMckVOGo4QCmxf3bkNScgtugTDfOpbhAmITLQdp8Lto9eYQ7s8z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 00:56:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Emily Shaffer <emilyshaffer@google.com>,  git@vger.kernel.org
Subject: Re: [PATCH] Documentation: propose community voting process
In-Reply-To: <atokQ8nPx2StLq_O@denethor> (Justin Tobler's message of "Thu, 22
	Oct 2026 10:35:31 -0500")
References: <20261021200341.378978-1-emilyshaffer@google.com>
	<xmqqfqxylnct.fsf@gitster.g> <atokQ8nPx2StLq_O@denethor>
Date: Thu, 22 Oct 2026 21:56:40 -0700
Message-ID: <xmqqv76taubb.fsf@gitster.g>
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

Justin Tobler <jltobler@gmail.com> writes:

>> That is a fairly low bar to cross, especially the code review count,
>> as it will not be easy to define and enforce some rule that rejects
>> a response to a patch that only says "thanks, I like the feature
>> this proposes" without reading any parts of the message.  
>
> I also agree that the proposed eligibility requirements here seem quite
> too low. From my point of view, ideally eligible voters would primarily
> consist of individuals in the community that have both a vested and
> current interest in the project. If an individual submitted a handful of
> patches 15 years ago, but have not been involved in the community since,
> should they still be eligible to vote? Maybe it would be worth
> discussing whether contributions must have come from one of last X
> releases in order to be considered eligible?

Again, I would urge us to resist the temptation to make the rules
more elaborate (see my response to Phillip elsewhere in the thread).
Once we start saying "such an ancient contribution alone shouldn't
qualify you to vote", it is essentially the same as saying "with
more recent involvement, and with more vested and current interest,
you should have more influence".  With that line of thought, we
would end up with rules like "your commit made X days ago earns you
1/X vote" (where influence decays with the age of contribution) or
"summing votes earned across all commits in released versions, and
that is the number of votes you can cast" (where the more you have
contributed, the more valuable your input would be to the project).

I do not think we want to go there, and we should instead limit
ourselves to "each of you gets one vote, and this is the simple rule
to tell if you can vote."  That is simpler to explain and makes it
hard for any potential detractors to claim unfairness.

Thanks.
