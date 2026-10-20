Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792469491;
	b=mno8Z9ttCg5YNY+w8yLPN6O78QqcqDid3U3hwmLWFxy8ghaAZbTsxQ0ZdDpc1iNjO1CL
	 +dQLi9RspCz462o3JHzOlhEivdWUAfx3DO94EpVG1UZmi3wPE2t6jzvbmaWJaCHae02J9
	 TjgWfPvZq/TwBvoBwNXg9hEd+B6KDy+BWoDOz4YmYAejavQ/eLdzM9lHZohkAtYMm337R
	 x2IiGTeQzkmtMNNR9Bu7CJB3pPvHEweDSqZ/VpWLBulEFlllbcnNed7l+PchOJy2FCutT
	 hFssK8MqZO2KUBKM5LuNRaYZTHbFBBwiE91T0NJuY0wS7sZmfx6+QpQ5SkGv8/4+C3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792469491;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6NV/dr5jwT+ycdiUTQ689JqZtTEU4FWp8EyH7c6fR8M=;
	b=q9iMlv9CqF6pf9Mu2Vrg70UPz0jBk/gzMn3y0dpvKSVd6P42k0O9fHaFGdVZjwb+wml5
	 Z3KBDCW5bqH7cIUaLcUrdAZnckCck6HQ17Py0Qef8oOuWVc9TtLu3n8XY/Zol3cClHFuD
	 SineYqbBKGGiMeGT06bFeynWZTFBQ25xNrNWtMz9gfIKw6LhYc+jm8SMVEGPeSLMFlBn4
	 SaQ/8mXPg/gXRjEYv/8+KJBGesqJvFfghb15nNtjX6j3iqJUsspjSoQriOzKmvTU9sg8B
	 IuWlG7XHNP+Fu7dX7+vyXcl0Y7GWzPQFA3BANxO5QFzF4+XFhUXyG1hnkALyu8vRyXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZCmQmhs+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jf1hNUJ2;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EC2606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 04:11:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92EC2606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZCmQmhs+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jf1hNUJ2
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id B4A56EC00C3
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 00:11:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 20 Oct 2026 00:11:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792469489;
	 x=1792555889; bh=6NV/dr5jwT+ycdiUTQ689JqZtTEU4FWp8EyH7c6fR8M=; b=
	ZCmQmhs+4HyQb/FZTjyinui1nZXfdcFLymxtRrWBT4HZ1QczPbbAz/i5Isl9senu
	i/VJ1Sw0/pqxHargv7dTBcdAOVxOizagjroHCg4BhXr38En+t3HPwwv9O1tr8zzY
	lmIKqEMQMhuEJXxL19Lpkw3ILRfIUQoPYiyWlzprwfb+QZ6FcxVr23KcKHkHVH/K
	LMlXVn4R9yE/qHWBdJVL8Kz4r3HmcipdHjGb3IwBB2gna+hLzvH5tXQs6dk2NGCE
	tzwWXgnUOQYkcxinyEbvE2uTkMYedFJRAdei/ZWO4RYwy1TpKPzRr0SUdE8DPhlS
	+xhXaun6e40VFfx85WHjPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792469489; x=
	1792555889; bh=6NV/dr5jwT+ycdiUTQ689JqZtTEU4FWp8EyH7c6fR8M=; b=j
	f1hNUJ2QFsPsnVHiSH0RhH3ANqJDFeFEhzGtTLKDIB2jMw0s57T6zzBw/vwuWWQv
	1wXXpex0Xn5C6PkSGOopsvikIyv9AEycJxvm7iP2KHbv9GuwJ0LwX1A1VlVja44J
	VnwuOogyrEkZlQCqE2KzQ0MhMFdVKPcmu9wtrNwS8vhb4yigpWcGCKFhSWieVc3O
	t030CzG+ud4g7s9jifD6kYeIQCR7bIfAFSFhLHd1C2l+XAovh6lj0OnZlMw1dy25
	xHveMM/7+htdjiapx7AV7rG8T6S7TUZvt7NJEXfGcx4KZNwHA2d7Xi1/k/lwU/IY
	v2i4EweumSmnmu0jdODbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792469489; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:oDqtS8rrCsUGCHGcq5z4F/RQMNEQAV3rvkydN08n1eoHzUH
	7rSAz1uQsgLgR942yUeGkeOsrE6FZXHp1WzsSQWbVkzernXFOp57b3LEu3joAkwc
	b/nxp8NEz+3RWVig96Akpv/LP0LpQ3AuHJcPbq5LmRndklaYuQ9I4MEhxjcEZPTf
	63lZ3chWSahsnZlUtpb8+oxIMr8Zm08bLBcw0EKdXHc6dyiUaHlO4iVhBd/jJY9G
	3Xo2vhRMEJ6V1j2b8WI+Asr0Bchvnl/slNS32+pDVXM0FY0D8hYYtPrGtzcrhyw8
	WwuFe4RwsbBksVtNAp45NyzA/f9gnffL+BBswxQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:gyfJyGnEWwKmyhblSxeb+gRXn1n30cMT13XQsz+w0ZI=:6NV/dr5jwT+ycdiUTQ689JqZtTEU4FWp8EyH7c6fR8M=;
X-ME-Sender: <xms:8enWai36i-RhbADikQcn4cFe_00HC0s8zj7HWXlBzNHzPdR5ubOydw>
    <xme:8enWasjqq2vtA5r6ng3R74PEwmOSIuyzu8JeSpscmwgGSwD8kLsdHg10BziPTt9H3
    HEW6Puh0jvJ_pA9fj9rtClm0VGiAy-t8_eTGlkvdb1vROkGZJ7uD2E>
X-ME-Received: <xmr:8enWaoSvAGIURfZgLJq7cjnLOZl2etXsA7idai0mVIPPCrXe29M-mwXYpSZlQpmvbC4KymP8ZLvZjaqNSrsBYUVbJejIXz-5IbVE>
X-ME-Proxy-Cause: dmFkZTE4aI6xSM4NITwBnwLqEb73or79Z+pJI/P1Hd9Sv1nvuCWuzAdfJiLsZE5FGyqQoA
    nL83G6gor/NssIV/8fTuZpL+ieceZnKnLhowQq6RzVQF+gijWfvkFR13A31SKho2qyEjfK
    VImDdBxjir5yMZjB/CZ6N1Ess6yrvGsEflZaWNtpKleCprVb7bOtOj9NkNc/gJz0H/zaCO
    hwKry7R0e69oLm8UcS3tlhDPZlZEsMUGTBH27X87FzfWAfeEGpdUi0/FEBJzZ8tyiEAMb4
    ots8pfEqNSL1UYC8L8RMTkRSWXMvhhxeThRs4mYwiElHwDREPDucnxMpVTGdqst04Pc2Up
    XqVGt788lJWLPUmqH1NTP7ec1B2RidSkl5l7U4qfFB7WKgRP3dcI9dmv0q6x7erxblgMhx
    aRtTd6/lmgiiV5ixVKG/+sT272pwkbRhfNkga5UoO5m7zcg8PVin7TthLHREgIl48osSrh
    S0SbaBy5RvKuYcgaVCV3iLqUitHv87nbVsjEeIjetHO78fjq8RPnDNhqSW8wZA7HMrpcU+
    vK+HLBHiR1Eo+2WtrPJAqzyPfvSj5H08vvK/TR+rngduDikLWz/Hdn2w/SE2nGvqMlHjhl
    37Yvz+oJaYLES8ff2yEF84UITDNGVltxK6z4rEoybouMlHbfYrpeoLY57WrA
X-ME-Proxy: <xmx:8enWatjWdYY-dZMusjWjKNx2oXoTK1PQeuOrHiSc0cxMopN1cM-JrQ>
    <xmx:8enWao4FtOge7KtD8V_3SkMMHYVCRBewAKWioisPim8ch_ZOEAOP6g>
    <xmx:8enWaqByHR_RP8wIj82CT34_eZLao2gSb8Zvqwls7OJgpOzscaUhuA>
    <xmx:8enWavaX2I1VFyGxVolGfC4B1S9RwCP1YdsNqMf_3a8u3DTlG9_8Sw>
    <xmx:8enWagjfF9xXDnAebQfv-GtXAStZgw54A997qsTYPi6MB3Op13n5dUTW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 00:11:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?5LqV5LiK5Y+4?= <inoue.tsukasa.4@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: switch/checkout stops halfway when it fails to write tracking
 config
In-Reply-To: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
	(=?utf-8?B?IuS6leS4iuWPuCIncw==?= message of "Tue, 20 Oct 2026 10:39:14
 +0900")
References: <CAP8tz2JPXzq=Skokn4OtH8t6c3b+p1Wny1iX6AhXReUGvsBhuw@mail.gmail.com>
Date: Mon, 19 Oct 2026 21:11:27 -0700
Message-ID: <xmqq8q3typsg.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

井上司 <inoue.tsukasa.4@gmail.com> writes:

> 7. Next steps
> I would like to work on a fix. Should checkout finish the switch and only
> report the tracking error, or should it fail before touching the worktree?

Either would be an improvement over the reported behaviour, but if
we can make it atomic "all-or-none" matter, that would be more
preferrable than switching without setting up the tracking.
