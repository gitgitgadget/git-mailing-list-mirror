Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793131904;
	b=RNrtzO5BcxlCSneIvbgBpN5ApG2Hb1LXf3monDp3J+tvc/8sEMiQymISVSt6lPR2BooO
	 h6yWdWMWYcofRpJe5yPpBfo2LKMiytJDasCjU1FEis58tCdb1xQE/ouSnVvxTxYseFav0
	 w9RqBWBCu3u7MFDbFnr4xHdHbQIFlyB1PmCMu+vlFWKV33PSLOxR9uLTer/C4CJP9iqJZ
	 k7EyNLOrwZJo5fMkoZPm4Mn1y9Vasdy1sC4hPm5C30RLi+87AK5vIeTFrJSqZ9xuS44gi
	 PbgjMFHFjAwqG1pbqbFuoF09ZwMJSqTwPHKWkf9hLw0dNtFfLUxA8JVxXAGUDh/HhDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793131904;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3ISW4e8dGjm4chRiQgii+Xq/GRgvsnlKGBn6nlvzZ9E=;
	b=nDMzqdJTi67Ze/lOr+57MP+JMqc2fYUWIy4FzJz4nOA6pqZHSkKakOZ4fC0UZth0vRSU
	 QWxv9tjOnDdfZpWoej2VQYSMuAD3MAmHrCf60wKT+orX6lkGFDahyUDnPiURTMVFDaZiG
	 wJ8zZXhDI87FIGi3MhrZ7IYihcUh1NShXc3E2xzU/bsqoE6MPbF0KLQWoKREmokjVePHq
	 zDT//+FMDC8qaTYxJDehFPnqH2PEfsmjVvNDxljorA/9pG4HU9cEr2NWoPPAOBH1XcK3i
	 tEK7tauu+5BGxr04nUe/9BPGuwl5IPU1CDAaqkLW2K2K2AEbjoNQZcspGBs7DdYHwrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oFpwrrS2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DQf17sUF;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2526606A31A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 20:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2526606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=oFpwrrS2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=DQf17sUF
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3DE47A0115
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:11:42 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 27 Oct 2026 16:11:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793131902; x=1793218302; bh=3ISW4e8dGj
	m4chRiQgii+Xq/GRgvsnlKGBn6nlvzZ9E=; b=oFpwrrS2rNyfVEstucIFIhTA2B
	QINhdlvShXmBCxPbSpRja/8myoymLY+GRo2uEbrKQ6OexGEIkLeHnveER0mbPZ4P
	JPCd4Y5LIbHR+oXUkQDUAMk+eXemTOQTN/zs7b9rOujcrbXZ3cGgYc+Fc5yE/ZY5
	1yQLzYO63WgqqZ6x4qXIVTIHbFUvMtkLSaQ7QvGMOI0e9tSX/IzzLX65Kz4SVETq
	JzXpAjfUcMILrBeOw7Bw4LXLRxZ12eeMuCxZ1ZbYG7Is53iaWpjIrH0QvHHgeZmr
	E+F/Pr1vHXp76f39JT7ss5MePL9g1W3EvTkPF6tcRwvwkQqKx+I4C6TcsIeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793131902; x=1793218302; bh=3ISW4e8dGjm4chRiQgii+Xq/GRgvsnlKGBn
	6nlvzZ9E=; b=DQf17sUFk7hSuRY5RiASW1mcpfVLR/bCBHtxDNWpQyF8EbLTwOK
	ysmB8krryAGtF9+7FxPSNRLAdZ7vaHEChTwXQG/Meb+MmlXrDNYNwrlyvj1D1OBM
	0nKbJELfIo8y7gYFa5Ig+IQU/VAZqVULFZmtdmOt68YJz8DuTCXEj4C7pD2D6gvV
	agOo2YovHaQyVfRpKlTEgVWQQc0CwZmw/hVq8ChxJ9wd6SrjsCWujP1zU27uRT8n
	JrdN8ZDLIhTLpz3yInhqWy6bKegNdNW5PSG0oFwPG52nHwkk484b84kGys0gWolx
	2dzbC2VaQxGkVUq2UZbNa64eSUXYd1jo+zg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793131902; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gxXqGSYezZ+RzL2u/2UlV9/jWQ4jiMEIxUqxI7ybt5p1vRw
	95Q8oaCOfInha33mO1THH//M1rGRvNeC9a3Ldfk91dWvxVh4LQ+Oy2BeuZyY+hum
	lwww/bU+twmctU6LK9GaAW7sUvQSUlr09b8t1rBNrMtgTE33HOb5S/dxPA/t51lS
	eeXAsmdUGzcww6S9u49+xi3UUMDPBjDvNo+WGlfnTsTqz5gtPKaRMkFHEgxlE5rQ
	3ma9zYu12xx/mKFjYqjJ3tf2jYUkB/0RucLTddgWTGu8+QfyRWdX9XDXCTJYILuJ
	x/0MFGdexY4z4TZcHpNH0/tkZTx19GC4JMjQtHQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4ARq9aN6fBBS3+dW6VjWizuUCMVmE1oDH0VT6czgbbQ=:QH2+QSjWAYNldbLFvkZ0/hMI7a0RshcBMHYvOw32n98=;
X-ME-Sender: <xms:fgXhatNAw9VU8ibo2nqR2-UBVVUuL4mjZjRnu-V3jzyaqBF_nDNnaQ>
    <xme:fgXham0SEUgz79xI1I8rZRSbe3b6wtI8_9_lPRoO9DLcqQ0QcJw0a2g0h6DZYJU7z
    HAJSdyW6E_hN0yKd_RlISfI4l4AfMdPgA2pHm2JoZh87xfPGptphw>
X-ME-Received: <xmr:fgXhaklZYSssGJQHoLe7oo7CQ0jSXgPphGIcOg64dwiV5GvlmRXnlbBnk1RLp1V_ImWR4q9xRFCCl9kQABu7VVyPTBHzjpIraO17>
X-ME-Proxy-Cause: dmFkZTFLPeawIC2WCZm/mQT1+rp94W5h2WyI7L3y99jy48rnxKiqLsfciiu1EZ0m9ejSV8
    NDhXT8bcsk9zl5t240YsZAtT6QI66edNVR0i28+e9wbwGtNdENWXZEEX4NhVgHQ4U8coto
    lFUCTfLOl9Bvilje7mFxjQTWKV8QccjoDI+80wnlKkahJcx1Jo/Mb0ysqCbg9UM1qP5TPl
    Vu1bqBHVcgBHBwmPlULK48qyzGJ3+0G50PZI6/mDOed+ZDkDP1JgD50xiPcW7zM2NbNKKQ
    e2NB0N5/4R35O5VkWehrRXzHp0ni0TtH42oD73qiJMpM2d3JW1dM+LzG+EoacumI01dAdo
    A9ise0SmmQqsZPCNjrD1m3F7rlzFNo/yKFnMvgwuGaC+JZ+KcVtPVY/XhZqeEc82rnyu3c
    gbr8IQkDd8w8hmsCM/NZV8ik8PND8mm3xB0ghfa8yPRmPzyrCaDmCDUo3UkL/IMP0bLvOo
    5CSYIpo2bniWzthB4mQJc9yzWK5uQwCKW76IpJK/hZw03N4hQkoQOfNX3KzR8M/6SPxsOX
    6iebnoqWaSdw16NnldYAyCaxEYg4MHlW4/UVT3HkHlGcfUhv0I2dtOTS/9YtYb7j5DWh7H
    CTZD8I7OaEE5DnXTfurdsLWbJHKpzLL/+LAhRB+wnMvjANjtcEwzp2iHlRyQ
X-ME-Proxy: <xmx:fgXhalXElxEqosESE9JbETHxolz069eFHwLiMMGDE8aRp8Grh2mDzw>
    <xmx:fgXhaiuzdMEy-l0hemUDcT5I37Bp9UlokBdLPu4Cs5WjrJ5510HGDw>
    <xmx:fgXhagZFSbGiSulmZstEODna0-w5VZwC7PLQAL7JMQU_oaz-iSEEOw>
    <xmx:fgXhapUP93sYsiUpHuhGCkqSgfSeYQR8F3Ii0TNKBXMSF0xlXP9I2A>
    <xmx:fgXhanyoxgOzPLdXNWbFFM0OvxY2dubeSkHwHMC3kgsHV6FitalC-suT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 16:11:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Long 76 <long76.git@mail.ru>,  Matt Hunter
 <m@lfurio.us>
Subject: Re: [PATCH 3/3] sequencer: remove AUTO_MERGE at the end of a rebase
In-Reply-To: <2fcb42a0858dffe45241cbced066dd0c0f5da76f.1793098652.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Tue, 27 Oct 2026 10:57:57 +0000")
References: <cover.1793098652.git.phillip.wood@dunelm.org.uk>
	<2fcb42a0858dffe45241cbced066dd0c0f5da76f.1793098652.git.phillip.wood@dunelm.org.uk>
Date: Tue, 27 Oct 2026 13:11:40 -0700
Message-ID: <xmqqcxsuj43n.fsf@gitster.g>
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

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If there are conflicts when picking a commit, the merge machinery
> creates a ref called AUTO_MERGE that the user can use to compare their
> conflict resolution to the conflicted result. The sequencer tries to
> remove that ref on every iteration of the loop that picks commits,
> but it is only written if we stop for conflicts, so it only needs
> to be removed when we enter the loop, not on every iteration. The
> ref is not removed after the loop has finished, which means that if
> the last pick has conflicts it is left behind after the rebase has
> finished. Fix this by removing the ref before the start of the loop
> in pick_commits() as the last commit did for REBASE_HEAD. The tests
> modified by the last commit are extended to check AUTO_MERGE as well.

Nice observation.  The patch is surprisingly short and to the point.

Overall looking very good.

Thanks.
