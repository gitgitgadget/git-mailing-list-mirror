Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162915;
	b=tMvhW5y4/X3XLBidRJdjk1X4V6YY3X8glxFAUI1BNcJm54to7wDlY0bIXNqnJKxyVuyG
	 XdW5Z6gt7RdTwtqMm06sXHQZ9tV3JtW2rynQVv0aB8y3dVmol3IDH0R0dRBM8/DNwXMsM
	 OaPdYXE5Y/R8/4yz8Itz7D6ddM+1Xl+lt0oLHnyhATuZlgkATemeRjaH4Awo93TElkbxe
	 4Ln4Tew52tYCMfxAAtKSH26otLNfY8ufnpGiuIdBPk4IPW+b2/BP4kSdH6j6gSSWTH5Cq
	 oM//SHB701kbsjGwT9DNeTk4bpEY09lGYNNdMrzLvv6VaUDtg66pzv0yUTG9yfI9HvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162915;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=e1S94lRlBw64Wa/ln11NvMX8MYGiLziEBxaKxf1FABs=;
	b=fSxnQbnxFCrrYaI1Iiv/AMa8ZK2yPIZhK8coIr0ywcvewa6bp6jjkwOTvrCFTUw1oRlx
	 fQq548m9Byj38wiW7aqU3z4PD5+JJt52cwIqsDPjoCOiNl0UXEkOBv4efD0GpK1vLgmWF
	 yc6Yl6xMeGbm0M4rJn1P1HwvxQydDxVvrRlJzAqBwp3YomZdTd/DhC6ECSx2jJinBExsu
	 xaZmdC8P7fn0djaRodXnPHMq8mpDXEfBK409c5Dn/eT2uRguc1K6+YZO2/8ufT+OSNTwg
	 ZegeAtx5VlMXbhMTygk1hm1wpHZffFp0phK2GxA26f8NS32O9NEdIUnPi1mB+g2eRSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lTxabC39;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g1kn4eT0;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295B4606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 18:35:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 295B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lTxabC39;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=g1kn4eT0
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6296D14000CF
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 13:35:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sun, 08 Nov 2026 13:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794162914; x=1794249314; bh=e1S94lRlBw
	64Wa/ln11NvMX8MYGiLziEBxaKxf1FABs=; b=lTxabC398hMEbP000TQR1QzheL
	tQxA8SjRcxmsZMFSdfLXdQ8vXN4CTLP7ycHknxCAlQT+3tfD7V2LUtaE83lKxNdU
	JeK6H6fTo412XreUu2SE5zn74rzi/34gvlG5a6Jv0xiBqL739pY/F3sq70euUre+
	4ywIzxr1a1af16EvY+9Xt8TsIaFmYBUPvUm0iA5sVdeis4fpco9ppIof6x0spIzX
	6bZhIr/F9TncKmDdBorwdYfZ0g44g7yYNh9BG/BX1uZMeExMrOk++sUcfABaaqt2
	fV79Qg969V2K1gN9zu4sz4lxBSycAXkA0veArZsD1YuXJFc8nLqvuKtJeN6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794162914; x=1794249314; bh=e1S94lRlBw64Wa/ln11NvMX8MYGiLziEBxa
	Kxf1FABs=; b=g1kn4eT0lG7ted52Ed6xVM1UJLIhmKbiPvK9cHTvOO4LS444AW5
	20nlfHeMoFTd/DObXuq9CB53zwRXLIvn1vLmLhEuImfNV214lh+lyknr77Laoxr0
	hZnd+OjpUc4gOLSoHRhskFyZ7wUb3Mn1mQxPkauBE45KXk8f8UMhj8LpAmblvHmc
	svVBcfdF0y2Q8gwGnlqVVPabPsp4Hjdf1nc9zhWsQbotrVVxQCu1rxHcDDHrde9c
	p8RzRWpHtaj9pamV0PeG+pUmRjRjdJGEg4P7yVOzxegBSHXjQ/pdrYRy7Vrmkq3P
	InlW4aFfMCUHMPqrQTrh4/vREXfPsmGXQXA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794162914; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:JRqDKGsEnBJIrIw799ZNqd7/EzeZvx2gjmlRabNbA8Ap6S1
	qLhes6n/R1KWqHx4oqgGlSnyNHPlwXimUSaJ0T2wCXGCON/PR8w2k31kRnpJD+Gv
	2NloTRb5Wl/TcfObTl+gy9+87H74oXgzMxlYVN5pmxw0nZmxR/u5JJ3FkjtHJ2yc
	pfWgMMDNwYwlC2nsMkt1hQrg5f0iUGDHNI/jLlu35gtH2kN2gM3rNXW4BlEz/uaT
	J+oWPOXwYI1eA4IdzfTYxgkPmsSM7lSy7kbxBN/djOz9tHJ9ieFgX0wkU14UWFkO
	MZ0ZFeNRxG2xoMjwF+00lFxzrkJU9pFmc/DLHfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:MSWlhkHWlRqTVAeWL/spwCnBg3h/G0u0iP++X3yflg0=:6AjRXuBTO09R54xKlRqhhsLZBIHWuxUinG1ky/w/ciE=;
X-ME-Sender: <xms:4sDwagr7dH28TeIX4dW_y_F16RclnlXD3W0mm29uxhqU-_1owAQ-0w>
    <xme:4sDwatjFvrihJz76ozIeHSCXI_zIUGiJMlQampV5_S_P0NBxcLDXx-0gfmaVj7xg4
    7QPdiBcey5YbF3SUXMAeTMEpwQu2VQ0SXvHgUE4uwTqvpuB0wE6gg>
X-ME-Received: <xmr:4sDwatjfLGWfEfGDbL9bFPZQbHROEu8teE-PejvP5yAqkUoENsWwhgf49sWr0X551nkFOqb6Pbh5-MuAxEjBTngGfPgsZNZ2kv4s>
X-ME-Proxy-Cause: dmFkZTGnqgBvwszE80gaI5l2cw/QAvFLQPtLkKBq4PtaEIBKWmOHXbmgOvE5snR0NerRYg
    PrIfk6UEusNhqxfFM6ZFoeOLy4T0G3x/QQqYy+2Lcqh3cX6Ldd9K67dbBgvFKvaOPXoEpf
    5S7D4+nhu+xVlXcvWHQLKchkG7aamcSmdb+eeDCyoSolZ2pLMsFg/Apf2oYFDwpr1zysLf
    y/52nWsLU0t2l3iJJaDEmooPzKM3W8+hmMW1LUtBgiGeJ7rdDwOqnBYQ7BR5eL/9MnMWAl
    O5BrvxErzHvDz63rbpPOhG9m4K9TndGPJtVNq5gN8csfvFjLX6nxG178ETcPOwP1ZuWwKW
    O3rLVSiVd7wnJIY9hBjqiP7Dk0jPdtsX+v8/NdEf9CV1QdPOy3xR8MwlJ19Pept+LLrw2L
    uPJtF6CXIU8hPYtS18ZbbhRIlgSDQnOwG5SHh1U+5QLzWUC+AX0pc77S4wvxbMYEwby+hy
    gPRJli7qxuAIhzUxbDtMh99bxuTE7pNdPgaKloQBBIR8c6y6QC2jBRrwTsCa78+Qbc1WTI
    X/TC+Xk1QNqjhpk2Sj655tQvDHItFagKQOny8aF3H7VLNjeuzIU7iyb2DruEXrnHV6JjEH
    Js0kFqdOeZEwfRVfIbiDKvjrXPXCBsFN3JEPISivxucsNrLsduhR22P/nvoA
X-ME-Proxy: <xmx:4sDwajiJ-JUBdhfx_UdTKQ80pSzQmq7pzZEsXQn3KQdgoLuYatE1eQ>
    <xmx:4sDwatJ50GqEB5GOSvYVyoeuohGGkCq6-KqfNN8RqwO2_HjD-57PFA>
    <xmx:4sDwaiHkyjVxqfxKscqZP5Rxmzg61yb0OuIsmxa7yeJNSuFy58lBxQ>
    <xmx:4sDwahQQ_nL16FQju9CLoYjkD7xk9M6ABgRpVr0c6YBPvZJkOZrxkA>
    <xmx:4sDwarjeVOruwEM1D9YSJRJpABrltRl4roYFJUaQ1acRSnbGtkkgACFW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Nov 2026 13:35:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/3] t/helper: rename test-genzeros.c to test-genbytes.c
In-Reply-To: <CAL71e4MiH62mpy0poRG5pSz=GPpoLWo-qPi_inaav9CgqDn5hg@mail.gmail.com>
	(Kristofer Karlsson's message of "Sun, 8 Nov 2026 10:10:02 +0100")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<b4378b352769cdcc2e9cfdf40efe173123ea9ab4.1794063565.git.gitgitgadget@gmail.com>
	<xmqqwlqo8c8y.fsf@gitster.g> <xmqqpkwg53us.fsf@gitster.g>
	<CAL71e4MiH62mpy0poRG5pSz=GPpoLWo-qPi_inaav9CgqDn5hg@mail.gmail.com>
Date: Sun, 08 Nov 2026 10:35:12 -0800
Message-ID: <xmqqcxsf41en.fsf@gitster.g>
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

Kristofer Karlsson <krka@spotify.com> writes:

> When using the GGG workflow I think that option is not available,
> though I will see if I can try formatting and sending the patch
> manually for this one instead.  (Or try to submit a patch to GGG
> to allow for configuring this too.)
>
> I could squash it all into a single patch too, which I think
> would make sense if we don't need the intermediate state
> where both genzeros and genbytes exist at the same time.
>
> What's your preference?

I have no strong preference between keeping both genzeros() and
genbytes() or rewriting users of genzeros() to use genbytes(), and I
prefer to leave that out of the decision.

My preference is to optimize for those who consume the resulting
history the most over the longer term.

Your split between a "pure rename" and a "modification in place"
is optimizing for those who review the patches on the mailing list
(arguably due to tool limitations).  While they are an important
audience of yours (after all, without their support, your change
would not end up in the final history), those who will read the
history via "git log" or "git show" to see what happened later are
the more important readers of your work in the long run.  To them,
a single rename-and-modify commit is much easier to understand, I
would think.

