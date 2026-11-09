Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256269;
	b=YfNC/Y5Ji9jftEiKNEwXjdxfYVI5vEmIfi3RbEa9SdpYQNZTMaHHCzAv7Qh2c45naBxh
	 njhYKn0Fi5t6v4EzIznH2JIgoGAmhzmRIN/RG117qYUgnmJrSwke4uSgdtaDFElON2/0+
	 uX7TpKHgIXg+9xwGOLdlzPZOKZ/hK9rs60ou+BdNimizRu6gdyNXWY2lc2uiL/d+F6JPW
	 uVsGmNVhB0KlyD6d3hm52DYjvDTzJHAZxVXOXIV64L8eIGR6bsJQZLcXUebk19jc6uQe7
	 FP9DFTiBhCcurZ7AEXjoRmKgh9Yw0YmTsOU0sChXaV30wVfBfK3ylNK47BjIhjZ5HOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256269;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=E8RUXZg/owbjuvndPCa6yaZGseApyxAKLbIM9RvHxSw=;
	b=cxWTvJDcf0cutwiBcbG+WCqNKrGNLJYiqr25QN9jlICUzKbqRh0LFUPWe/M7lPYf7n9t
	 kJc7n7L4n+qtVULDIzwxV6LxmyUy24LvAdTCaap8uUTUwvHN3Y5yB/AA1QEH4BZUFJkBR
	 TwAK2M98XvZq9Yy1PtaTRf80C5h8f4MwM2Z0dYU80eqi8pniUscUJfjdcaQSHwQBlWPPr
	 ZdDKFXFygsbBDMSN2B+EXBrEAjCm1yTTapCJPJhVh/BOX0jy92ovRdBNv3I3YPJhfGtEx
	 EHWw2aqu7gX4oNNCYCJqZC3ePVWruFyDHeMg3UWl5dUmnnzRUPA8yLZiOql3HN3VpfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TI367a8P;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aoVf+Smh;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028B606A325
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C028B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TI367a8P;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=aoVf+Smh
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 0102AEC011A
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:31:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 09 Nov 2026 15:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794256267; x=1794342667; bh=E8RUXZg/ow
	bjuvndPCa6yaZGseApyxAKLbIM9RvHxSw=; b=TI367a8PqH8/QeN278uA7Z1Q2L
	tyWuFsNmTx7kSn/5EjWpWH1Vn0MAmsXZ2aFB1BRoojsYadw3dzXEkcHKWGDulv1l
	FQfqpQFsUub8HfzR/lQGTtykVXAjgaF9FKIRBMQVz2qsBv57fvXvYycAFimVSmkX
	rwl8d2xxcX78ZFCAlDtIXcx+1WXV8Jhn6l3l+KHsvy5A0XnZC+GYQ3Am47Mfe2xA
	RyA/Cufdn9x5j9OvZXmf+IyscqMJeUGSGOezbPH41hYaKTMwTgOOkvOMKD2y2IP1
	O+BzkdYEctg5x9qY5KUnWuNrwFYQCzmG2IbHyG85dbRyCayDFaDZWaRCGJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794256267; x=1794342667; bh=E8RUXZg/owbjuvndPCa6yaZGseApyxAKLbI
	M9RvHxSw=; b=aoVf+Smha3/+lIgoHZJoT80FsiUjxs/D1gZr/lGZEqmMprPOy/P
	QgY07XOlUBGx8nWnJcAeLNPiK64rSZIF24SCLDPwhHUG97niunpGC3OjvcORlDkg
	5xJZ5NTpBvAtV67Ge8jlw69tcWoDq9fSiOXGxOQ2FkPWv7K4f274xcg1aN5WZDPO
	rzvZ9xpfmFN12WL0S7pZ4gXuysgX136jKRZRtR9sac2Kc+luizpTJgHIYKs5ro9+
	fUNbf6k0PKKryx8iSzv9dxcLU4D2dkZtLRiaUc7Fma7daPedP7o5wMqBYNZum8fZ
	+IphblZpOO3yDfT+ZD7LFD3CGDNMrx4lqTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794256267; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FqUUnKSrlRYtVw8d5ev5TPicGcyTeQA8ug1ERAKwA9BvqUU
	1BeqS8Q8WUmyfhs0eTsHidecvLPyFCL4RQ8YkI/TdPVDoVYz3BH4WbZIovYTvgSt
	GMFiAoJj1eTePCOxucNxAqM2kG4MHwgNEaCZtkuhLFAXsMMjPIZQzgnbbah6++xZ
	QEOVKrOxr3bXmAv2T6ugktTg1KhsjoZNQ9NoVkFO9wagm0xri9EZH13/13IMJLfx
	7BTA40IGfJRSmX60knKjcy1dSHyypK6XG6lwev2bX73MHD74Vv02LvpSqtceXBAB
	iTr/k+mRUcjfuhbu/WzVQW85f5eyOPntmDSVr7A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xP2u22pitWIFKTJlMU8TnZJC+Oi83mWAuywNMh1OoeQ=:zX2uwyzm5IEZQtd4lIYtx1H/8ijB4P9P3DIAblZ9eMA=;
X-ME-Sender: <xms:iy3yastI-H-C8aTG6E9nsVIaMG1nGBDgqb7GjIuXBg53oozZQk0kyQ>
    <xme:iy3yatKhsqrG6hMzJa3ohIVRvk47_Lq1jlqg1Og_uQR2W1OJ_oy-V1Ox6qrHTE7yB
    HdRIC4udMafRCtnyIB1a9dCXwQILDlAjEvEvDV7PTDWVU-Y3jjCkoFl>
X-ME-Received: <xmr:iy3yahntzL2uf_lUKPRSW_XIQfF0ej2Cd_JRnSZtnIrupWstZjLXeIfCbtnr-bDzMZbcWut7U69rr67qtnFaXb7oO1TEtORduvGh>
X-ME-Proxy-Cause: dmFkZTE0RmlJILTOObypmF5ORqafQxZ4Bz1Vmwnml0MhbHobnYuDvbtIFj6II58uxyZ01S
    eCjXAqZ8Wem/S1eV2lgyciIvMYrPUTuQCQd/xZu2akTY6GByBejFZcUkDxmY51LGx413zV
    KEtLx8TX4uHUZ+cUJE1Rbc4J0/nkcn1dp9E7p78aRswcjASzqPPLI32BaI8xQp3ObXjdYB
    YlAVxtwB7yRegoIUsgaoTmOOdw1IndUvBKByBnsZ8ANOHTwzvsukkmAZpCPhDQ1TmChxp+
    yBKZKEwvbffqEk/YucVyCu9509QeG10A2zJPZjAQaSpi0ua6YR205m/H0M92rhLVYNgkC8
    VCO5kRwjTiycJMnYFBl73Q0+Dw04OcVXYPzMHPZpnwi00iAeEr35L/KImiOgaXFSTMg6x/
    3GTxwXQViXDQlUpmKSFSUuppC70sxsacAWDSwD7N5N7Cg1nmLaSEs+l5ovpsilxRSS6lhO
    Ix6lrP2WRMZknp9tKqR+PUsCkT+Te9ogUlwGtUYDp/wy72DcplsH2Jmm9e2kzmrEcz3ANS
    nUjq3/BwRbux/5Egu/mozRQU3cokct20E3rqmPWsMTvC/YyqC22gRRr6q1e40mhQJ1sPEC
    D3nIEgHvpty5x/lhAzvy9avq6MMimRHjw01SxaLANTmOuomS5ZdmnsLgEnxg
X-ME-Proxy: <xmx:iy3yamLZPhIWevDpZLiNbyi8VZq2OvXVd3znOPvGNTEWKeXHxkR2oA>
    <xmx:iy3yau5p3gTfSBKFUp1fWx52raP57Dzn1Qio-A8Gz2GvFpx54uyAmA>
    <xmx:iy3yai0Nd4Bx57QTRijqNrCo1c4TxHVZBezXNYFrO1cxQDNNLAym1g>
    <xmx:iy3yaseAC-J2YvNMhJHVTpoYCMm3iliHLoM1Spqc6OrtpkZ6tIcHuQ>
    <xmx:iy3yapczjZXtg6ZRxy-I2Y32oLLVVlTFFypSDVy0ts1ZVk2s1mnyIJmK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:31:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
In-Reply-To: <20261109185301.GB1322417@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 9 Nov 2026 13:53:01 -0500")
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
	<pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
	<20261108023730.GA1242909@coredump.intra.peff.net>
	<xmqq33tc6ium.fsf@gitster.g>
	<20261109185301.GB1322417@coredump.intra.peff.net>
Date: Mon, 09 Nov 2026 12:31:06 -0800
Message-ID: <xmqqh5hpycfp.fsf@gitster.g>
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

> On Sat, Nov 07, 2026 at 08:35:29PM -0800, Junio C Hamano wrote:
>
>> An offtopic tangent but didn't we repeatedly float ideas to drop
>> support for AsciiDoc, make sure our documentation set renders well
>> only with AsciiDoctor, and tell folks who do not use AsciiDoctor to
>> use pre-rendered documentation pages from git-htmldocs.git and
>> git-manpages.git repositories at https://git.kernel.org/pub/scm/git/
>> during the past several months?
>
> Yeah, that's what I was hinting at near the bottom of my message. :)
>
> But it's a big enough change that this series should probably just
> accept the ugly syntax for now, rather than waiting for us to drop
> python asciidoc support.

Yup, agreed.  Improvements for these examples do not have to be held
hostage on the toolchain support.

