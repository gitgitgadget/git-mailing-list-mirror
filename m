Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793691702;
	b=3OhwVKRMObcRhxlENJhpUfsa5aQt293qA9B+gmwVtAnCPJ56dRhIKqSY0oXTzU013Svo
	 6eYyDjzZuaZ6JcDJA83ERCEWCIX+1+jXe5HpO06XFPUp/dQwUCAs9OLYGgrno5hKLtZKA
	 FMhF6amhvWdDZvbT7gMq8PE1SL6M+qdazlkqcGEe9Akfsovav14GYha5YWBQMtPglr9or
	 qlrHIsrvTajwC7CLEmKLFGpi8RhFa1hPIVzzvQ3krVwywRyFHBqOce4CUh2ziS2Si6R7b
	 Zly908OFm0ZVsQn78IMEAyKRJcmTnaY5Vctgy5I5oPsiCzF5ScihzY4oPKuBzObcMBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793691702;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=JRyLBi8Q3K1wvA5rPnSJXUXY+pGqmeGBFae3UNwJLRg=;
	b=gx3BdjFMf4OIkXnn+URsytUFt3Ibkjhf1iASKQBxjH1ixeMghFh7jyzzHy5p+j6hrwrY
	 x9A9KkX2G2CcrLc5eC/EtjCxVuff3zA2IfUSsm1m3KnRXwriagXOdMrUNe7HbllL0hbS6
	 PCX4AmPvMEkK4O4a0+LB+srMurZxAmVKdRgI0/YiqCRMLRJfBIDf4D4rdKUvgx33txDLI
	 Tyu4Y3dMpLWLRU4H0BdBq+NJOvfHLhrWs4yT5yGmdKB1Y9Y+UbxbIBChZFV+yK1Xlns0M
	 HhUeUwDttACjInaKs6TKXNzA9uL8Erfr8BO1T+/Qu9evDW9ArhtGIHIa6rdYxEkvdKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=RGlHAyiq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BpdW1bkY;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F52B606A330
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:41:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F52B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=RGlHAyiq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=BpdW1bkY
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 991DF1D000FF
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:41:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 03 Nov 2026 02:41:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793691701; x=1793778101; bh=JRyLBi8Q3K
	1wvA5rPnSJXUXY+pGqmeGBFae3UNwJLRg=; b=RGlHAyiq/4g+jge7aJA62RqFts
	DK716sHkW+VnRS8ptdYRDgxOh2c5NNjNA0oJ1aJffcuvjGhIK2z/0o5X6PzdQ2Xa
	tKsT+wEx6kOdohYVzUwJEUzl7misfDUvRdDL4Kd3SnKSrV4ojKXtGzX2+9f7i98V
	9hcH/nhWoJvwJDTdjorfetMXU5N9jBlU8dIdM/R6NAsjXICvA/vUFi797IYIekn4
	WMVV2gIvRV9Bzanf+QkuNy3fw3PTIVq/796hbYCSHR8ZahaL5EKvmzas4C+ZcTRm
	AEBrLgQjeOgvxAcUu83RSHN9Oh1hGsCq+LdV+JpVnWRMcJg5RYuUWptq8CKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793691701; x=1793778101; bh=JRyLBi8Q3K1wvA5rPnSJXUXY+pGqmeGBFae
	3UNwJLRg=; b=BpdW1bkYObwq5yBC68UOP4OxwWaaT0qFf70ciqnyHBZ2CXYtCBP
	JdOJZeH4IlUZGRz5oVGIGuk8704yVz+06virMgeO2CQnCGD6sum5DrGpmGuyo8Mq
	srcglyYbuR7D1kJq6qw+Y0CO05qEBHkmhsQ/GMSinjrX52AK3fH6bJZ1xdAVN139
	1qoTo0tQzEjYO88D2mqfpJL2amcL+vkgb5V6HpTLZncRVE54mw1wozqBfcx3blzk
	Qmnfh4AcZzKrMnQBrF2qpZPWVuVwUdNH2nDcRHsVwzB2tqmjvLJIZVkhZxjvADgF
	Ni+ZxyxTA0RiuxBvFXcQtPCp1qSuLehOOMQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793691701; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fqOQX3IcYEfk/F1hpXhQa9cFLxobNAU5PSGvRB0TCalkKUp
	A/pnKoYssxqIuQ9tCAyWWha6N80ykSs8qEzKS+6Okf9mK/foiK+98UuGXZRJYc4p
	Q0LkMYuvLvJoOafVEw0fBVAfhd2xnidLbXE5OW4TpMQ1IE3FiYRWZXwg6zdbvFJo
	GTVBrMIknYxHADYOBQeNrbsPpK9ptFd9toulvide41Dqv8mHJMNcHqdOevtIzOHJ
	cg64u23K5gqZ6KNt9qbx/QS3aeVrFpKiK1ds1qLCaLkS1UdMBR7FexURC26VENG4
	DkDYXfGOLlrdQjDQsBlQw+CPGzg/s23XN6b0iSg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:PCwdrFC3u/7OQ6b+ajjKY8fiDK0G2JdrpGELeljuJNU=:cdrNoWO7+oFQpMpy+TIfgZIXDMCMjdeou5cgYAg9kvM=;
X-ME-Sender: <xms:NJDpalrTKXheX44Ggh_dQluOc_8RS7yC9ekMc6nksX8esQfBxb_GJw>
    <xme:NJDpauqZ2AMRbraml-3TnOKGFxfgDTFjiMx6ggds5CtZ0izZpWXnZiAaRyJq6qT7A
    GqCBZG3IKnAuLTNpQA5QKSfS8To8-fzq7XrDl9Gv2fQCmDOwxT_pw>
X-ME-Received: <xmr:NJDpanPSI3sUvRrziWXW_S9ElNhhowMRKmQTR0DFwDt5IynBzwCa4A>
X-ME-Proxy-Cause: dmFkZTGBKtt9vtcgOSKVSC6pFPHYbN02jnBxWlBbxlAv65w3QLtQyb2qap4A83I4AO1uiH
    XREKs15cZn37Oiz06GoZ8i4zaZGNCrl0T8/fKPds6oBlXA6rwBkx29FU4mVSDSfSxVaCZI
    PhtjZNshmWRx1w/YntNwgcpPbbOCAeyFPrwotVIBHdqQzXSkXDqbQCuE4H7t8txIW0Dqmm
    W6snNW2Ve+d6KNuH7V6ZCKnrxvIyPwHdRzTPAvvFM/iyJEA5x02ndYVh1mrjA1lIMpN1Ww
    0lXmZnPrYcjeJE88A+lDAhic96Rth2HcmPWye6GpyU1O/M4M9EfsSK0WxH4/u0khFWLmJR
    J5lPuftMMsktMBL0B6frH2mOGxj2ZTjcwopeM6mwDF75EmXo2skjl1zONhK+4i5PoJOkS7
    jMSfBtpxoRNQhhnHc+6/F4Z7QF1h8vbsHXcOELQHxOK6sqmtI00hCR8GzZTvULQapaPUqS
    /BNDjM5XQZqz/A7tqSlpJLWsKcbINrOPspjtAddTe/Wzs97+G5U/jwblDMSQe1vx0mBshF
    e741syGyeRW8sq6a7MwbbXCMLKIoS8dDyHd2Tm0hTAatw3gxHJvuMVVEGLrWYBTUpayb9A
    a7HpG1jb+bk3cmzuD6/xB9lhk+KSdkn5R+FP8Pm2iwItn/2cutYnwUxYVj3w
X-ME-Proxy: <xmx:NJDpavz6dzKyIOJk0lPEslmCarUOR-wwbpmPXnZp_KV-ADaInMepiw>
    <xmx:NJDpagt7Jd6XGlXmjZzuV929Tf8DBKKetpZSk2AGuVTZPp0LDjv2_A>
    <xmx:NJDpao6TO4ktrq3oaqF8P96OKx9aIGYtnb2jeZXAynZK-dkwKZ0LiQ>
    <xmx:NJDpavR6wqcPW0pjgS1Tm8lwE0SPWISkaK7_j_rCb2vOFgXgyuuJYg>
    <xmx:NZDpatfWnDI273_kzDFdBBiyPHmxvaGDXKc3H1OWH42xJGWYA7u-N23u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 02:41:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf0b47e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 07:41:38 +0000 (UTC)
Date: Tue, 3 Nov 2026 08:41:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tuomas Ahola <taahol@utu.fi>
Cc: git@vger.kernel.org, Ed Maste <emaste@FreeBSD.org>,
	Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: Is anybody using .cirrus.yml?
Message-ID: <aumQMJLMeI4sfeNI@pks.im>
References: <20261102204151.MA00I%taahol@utu.fi>
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
In-Reply-To: <20261102204151.MA00I%taahol@utu.fi>

On Mon, Nov 02, 2026 at 10:41:51PM +0200, Tuomas Ahola wrote:
> It seems that Cirrus-CI has sort of passed away[1], but are there some other
> tools and services available that could ingest our .cirrus.yml?  Or is that
> file just gathering dust?

I didn't even know we still had it, and to the best of my knowledge
nobody uses it nowadays. Which is a bit of a shame because it used to
provide test coverage for FreeBSD, seemingly, and neither GitLab CI nor
GitHub Workflows provide that natively.

Anyway, if nobody runs it anymore we should remove it. But let's wait a
few days for Carlo to answer in case he still does have a usecase for
it before we send a patch to drop it.

Patrick
