Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983180;
	b=GYRkIvnAd2zFYJ+CCSYW/jsRSnMnP+fw4slbqdQYcnoLLowSJGoUwllzXkCWkzd/auup
	 c6m+FmGCmxmRmR0uc/Lz5jZ/e+YUY3ffeD4O6nkRGYuJKtpZ9tCJMAWXlsN6AU6p2YYBe
	 JHWXPa6vd5ChKculxNH7HLEBhcByeyOkmYkLAVagb8M4I3W8GZ/j6rLr9N/X9GMi09roF
	 Ke/QA31sPJRpcrdLDKeukkjufizQvViLFrNIxV1ex83xPYHWAOQiW4k+/96Wzcf/wosAf
	 fHd8vEsorW2DKxIGDKgGHHQKiHuAm6cAl77YvRqv2CFAe7hinzZNpFclCjUFCsHeFjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983180;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=JCOf4wTMk09ZhozCpnWHT+IFzYUYk+lODKCt6ifOO38=;
	b=xXKgpOZ4bS+Bwd+bGS+oD02jjQ+Q0k0jmMMW2GWFbHdsztNojSgQ4WU/6zCg+EaBVm/O
	 NMMOC7Dfko/p+XWavkk0A9q4fsaO4HWqJYDylD8QJLDYzXcguvTEts/S8dS1KkNN66Xr1
	 xWCA7epRZpK850T4ZIgx080vhPioX5R6B3SvzCHMeoSxIqOrKD/jIxQMl1T/9/FTqPP54
	 zRHV7Bd7e1mQXzV9N2izyziqcx61INCivcLPNTgYMi4r86+R2If0hE3gmKJTuWHLu+wV8
	 OJ2KvFBfzZtInd2ya3xPsJB8zJw3rfglVVvYt021Ayp+5qEfRQG6cz+EGRPvO6dpjpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ABJiBQiN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Aa578MPV;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562E606A326
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 16:39:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5562E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ABJiBQiN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Aa578MPV
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5C43D7A00FB
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 11:39:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 06 Nov 2026 11:39:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793983179; x=1794069579; bh=JCOf4wTMk0
	9ZhozCpnWHT+IFzYUYk+lODKCt6ifOO38=; b=ABJiBQiNa9H7A2nAV7TODi6JGR
	Ncgm70ClFbMASySdG+OYhx0B+wBdmVh8BNG+N3VxKgaJhWXGgTbPR8ItJTLusoot
	lkNQtUNyfBQKOANtuxTSd3B2ewfdCbCqRoaE0LWhTFxgj+NZZXhAomT0aKkmZmul
	aHnmnrdAS8Pp+5QvklP0aY2GAqu9TiVShVZnSAFs2lCGSs/LcFr0k0NqmVxuG7LL
	B6GDPilPdu1fuZuzBFIqMnO7Qb7gb0QRS20zx8QId6nshQ2x0ZAYZV2dzYCQMYLT
	Wk7zKr7njZWrpsJS/uA8+d5qbw1o5LT4gwfFgA98jT44SXkQLdAFyeIih/3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793983179; x=1794069579; bh=JCOf4wTMk09ZhozCpnWHT+IFzYUYk+lODKC
	t6ifOO38=; b=Aa578MPVUjmRZvqL1V3v+CmCmwB9c8RZ0HIrtOX0DJqZxGdso4f
	kNsOfU5q3NFfiVDyNix/rocU2TwmjU2ypJTp/rp2LoSpwcQKi72NU67e307eriCV
	ZanjznMyMDOvfSDCCF7sBacuM4KSAvfwDkvU4jPk7lnAka02j1qFQIxv1DIJGTMI
	xQPsBXkvgUzsbnxIq+/IeOFp8zOxQxbHocrf6slIOfiBIzpXU5mT2S/DOJx9TTtZ
	qMA7YO5twrmnVH090TwcR9RvYjL8eNjrmTZ8OoFG0Ab+MhBC0Xap6NzvoqNlxpuv
	kBD6/li8t7AXMzYdJI+Edek8sg8lpMy9Bbw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793983179; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jY8NSB4lz3gNwhPVi9NvnRM5L6dmd4wFD+Vglt19F3bCaNP
	o4RnaDZNR49YxOCKmdnMHkm9skVeCypPbTPTFCBAMgkTq70M5bC8Ybys66FCM6uo
	2r3dwQ5FwcF1HjSkXusCTLmL1PRPJTOrXbvwW+MQNFKkCmK1C1RNQcu/RK/Z8Oev
	oKM0CIPFnHNU1QCEnOj4aIzfpntjP4QsjwRaJPVqJMGtX6WAS9NDdgyFjkGxDp10
	0x7BRHgl424KDKfuAJune2rkGoB/mRdsfBgqjPGzPARP/yaLTq5RSWBsTX8+Yw0f
	N5n0fKjbH/TO3t7ebuIeYnIbpJY0R24hHlBTlRw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gtRrReCVqt87Ocu/XeJVAv2AxWgFWEaE1JbcnOO3mmY=:Hvr7WDZUXnwbNWnBipSeH2BmZo5h1oE0TGQhv0Nvh7M=;
X-ME-Sender: <xms:ygLuaq-OZNQa0IhIIq0LDoDxUVonchWEr_dTUAvX8wbhK7qlo6yf4Q>
    <xme:ygLuahnhgi0G5ZMkkqz9Nkzx-qsYvKH3nHJxfdUrq9j6vJ3VgvAXaIo3dZJTS7Xi4
    hagnqLcdcO3egTC5hPPdTMhU0eaL49RFljPIgPxzlRFPthxm7ih6g>
X-ME-Received: <xmr:ygLuaoXgFMuukGi6vkyoYS_GPGMV2znpHyiwYqUeNUJZqds5x-9RYkV8CU1nw3YRuedyC1jgcSCdwAyFIaS-ILqVuydDYONM905M>
X-ME-Proxy-Cause: dmFkZTFAxxut+Sc4T5QMm02C71qg1p9keFiqcP0Igf9dBpb29MiX0CULei5PnjXbPfxBW7
    1tDQw2z+VfY6D/59wAsJoU9w/t7W6jR7XyU3bfXNy8/xfBnJ6t+ixHHPMymQ4KBfqJws+p
    gXM1l8yw8/ICpuqcBE+l7D0Bo65fEF7bawWkK+JKdTYFiiHS3U1zTakfnokjWrNheOc/zX
    fA0QGf1e4eXMx0FvrnTYIfQd96BnfRm7VY5dvHVmqDe0nqIUVgaSTqkf5DbhtPU8F6WCze
    vrt/f5XBYrgMCoQxxfu25rjx8Z0jmt8+2u1hoQZVFQ13xYSPCuCigPmkpseKQ092Ve1duL
    ZSlu2/4aW/85/Zf0YBL62LCm0OvjnxmzgG1tqGWQf4XW7Yxj+Mt6/PosNRA1ucTc/kbtgz
    d/D30lZoETFiVcWq9SlNUKgjdYrG1yT1iTR26WevgUMM6k9E47eJkRw3NLHKs+JnXa3yG+
    HTQt01qttYdBq4e8KaXTyx7pqHVGwMQWrowOJ1vZ360B0aY/UQ/AoTsxfs7Wrwbr+Wsm3n
    kSGPDNZjOyfNgU1RdSFrtZISdhzG3WJaJ3R3MYsOa19CWXBo+h43GoXKlXJEhUTRAUMYYQ
    SwITBsO7lobCJChd6WeEwa9hxDv46LrLAPHioLawAiP+0I4N/2W2ehYfewQw
X-ME-Proxy: <xmx:ygLuauFA2A8_qtcM-3QFCBED9gE6Kh8bhn-cS2QJgk-njihb4nUw1w>
    <xmx:ygLuaseC3ysnvYC_YMT_5urdG9bAEeVXTk8g3B-AOIxmJLn5ujKrAQ>
    <xmx:ygLuanLSGaNVTF5iCxs_aDnQd8p86DLciCEr8BCwNhOD80R7mDKDAA>
    <xmx:ygLuapFOYtiDzAT9ajYOFvUE49e0502VtJ81dpZSISJp5r_7-giyaw>
    <xmx:ywLualUm-wOsq5xNg_eDbtc0TnyGogZUplhIu9CbI4etzS4VUpo7ebiX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 11:39:38 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "Mark C. Chu-Carroll"
 <markchucarroll@fastmail.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 02/12] rerere: convert flags into an enum
In-Reply-To: <20261106-pks-rerere-subcommands-v3-2-4ff164d8fb81@pks.im>
	(Patrick Steinhardt's message of "Fri, 06 Nov 2026 16:13:56 +0100")
References: <20261106-pks-rerere-subcommands-v3-0-4ff164d8fb81@pks.im>
	<20261106-pks-rerere-subcommands-v3-2-4ff164d8fb81@pks.im>
Date: Fri, 06 Nov 2026 08:39:37 -0800
Message-ID: <xmqqqzgxlxrq.fsf@gitster.g>
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

> +enum rerere_flags {
> +	/*
> +	 * Auto-update the index with previously recorded resolutions. This can
> +	 * be used to explicitly override "rerere.autoUpdate".
> +	 */
> +	RERERE_AUTOUPDATE = (1 << 0),
> +
> +	/*
> +	 * Reverse of RERERE_AUTOUPDATE. That is, update the file in the
> +	 * working tree but don't touch the index.
> +	 */
> +	RERERE_NOAUTOUPDATE = (1 << 1),

As you have updated the comment in this iteration, I'll throw a bit
of review in.  The new comment is not wrong per-se, but the one from
the previous iteration was sufficient to convey the same thing.  In
other words, I see no improvement in v3 over what you had in v2 for
this bit.

What BOTH versions lack is an explanation why RERERE_NOAUTOUPDATE is
needed in the first place.  In other words, "How is it different
from the lack of RERERE_AUTOUPDATE bit?" is not answered here.  And
I think that is a lot more important thing to clarify.

> +	/* Skip acquiring the MERGE_RR.lock for a read-only operation. */
> +	RERERE_READONLY = (1 << 2),
> +
> +	/* If MERGE_RR.lock is taken, return -1 as if rerere were disabled. */
> +	RERERE_NOWAIT = (1 << 3),
> +};
