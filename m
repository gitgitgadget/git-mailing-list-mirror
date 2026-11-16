Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794846316;
	b=yws47MSNrz7puZZ1DFSp8yofNSJADWaxcnBsZLfMsFxKn+vVXMTLLGU8+C/s1BV6XP53
	 cIs2LW2xrckBI+jv2qaYx1Q2mSDx6Zc9YNft50Rca82TwQ6FK+EldD0tDflHM+dHG2Z/p
	 WjsfToclr6aHd23PF1nghu0rgBaiPhyqruE7eXrLfCd0rNJZKxHdPGQFmxErxt879oYyJ
	 4cAlDqR2zXVNv3jMng0RZetu7+pHJEOgauWx+rjazRKYB1a9ToSUcp2OQ3PN2hdnKHY9l
	 rYrTBlxSAx1cVR1bUo9BrUTgTDr2sTduiXGfsxmWSYO9VzgxltzhO/aBe9ts564tjFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794846316;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=97MF44pDL/Dx4tn9u6seudb20pgZAL6xQYCE0aaVNvo=;
	b=a4V80FMdz8UwMfPanikCHBwKi7iDxPXBYKrwI71uyrZ8ZRQ5moMrtF9z5Uptw5lqlU7+
	 uIarK46vGYNEQBvye9GOgNqWXckttausO3LMTl3JzYApfTdU3vCZRmwrNscrPCmkBhzap
	 i8LcOcvOsAaq66wnhcVOMNVnfu8Bqx33+9nxbVI41yzp4/tdP4CkjcHj4EtM/9QTWH/uX
	 QF2AoIVMSatOOaxVdmw4n9JoYj8uNDhTc3NCkw97eFMm2NBrDqgpGCQlxUaAZhkqqb7de
	 qNtqUZlhV1eBs6plOqEcBKxMvdtTrOkqlCgm2faiDHUmpMI6XeziR1hYtxBHfCLOgiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WB+YQTQg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="gwQ/lf3L";
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D0606A322
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:25:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE4D0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=WB+YQTQg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gwQ/lf3L
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F140B1400068
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 11:25:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 16 Nov 2026 11:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794846314; x=1794932714; bh=97MF44pDL/
	Dx4tn9u6seudb20pgZAL6xQYCE0aaVNvo=; b=WB+YQTQgd4v2VZy+oHwZlAmwnf
	q/OGD/gcwXC2VDc/DxxwVlteKQDDSKFq+JyHqaw88+9HPNPqo/NazUAnV8kS5eYu
	/puOpwQG2jLqPXMRyeIzxWdtpWPB6GvXk7zxVBYz63v5dfkARDXJptqIPxjrVUJv
	mCmllSbbSkIoPJUHLnhv9AXItWQlZO+pb0++4rKZkYS06plLEE6U9yOq8PgwMGo8
	jsHaLmTc+66WY7QeLGfsXdw/SAlUvX8k7EQt2ITIuZ8pQmhouy0PdGLncyBfIAFJ
	djDxXArdGjSLGi9E38PSM9CkHo/Hi8gUfkA8d0faycKcmTo01gKFpqY+QHkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794846314; x=1794932714; bh=97MF44pDL/Dx4tn9u6seudb20pgZAL6xQYC
	E0aaVNvo=; b=gwQ/lf3LTtLAbon9Gg6bpjW/ZZCmi3jsP+xdNpkJZQpazYpRCjO
	oXQ2bJqFy1gtnocfGiFWKxK5nxjTwz37lxzwyydFQ1Z3mhyfVobCjGFj41VuA4to
	szZVICXTgcXfl761mHD4VhbYWfDCE+iG+waIgOTb2z84qaxDSgCLs8i7UYIkocJv
	Ns935mMbg0B9BnOLmYvOT4EpflMnOWPlVZ3KztP5rSgGShW6RcWCyWKZmMxZYwDJ
	ciBwDIjXXaedJNVcdL1yEdMo3B1suowjI5Qx7wqQUUIZ7T6jeOOMWVr8wOmjw14U
	Sw1tg8GOcU4/9/NaGQYoJIcGw1DCEoY1ogg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794846314; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Jyu1fb1b2cXJDBPQiB9zyYPNuW2+3vrdga3o0m8oC8nAg1K
	epnYockKlxSolIcv2PIYW68T/VK7AMd5EHUiX8xFNTOAE/3JVC2IAvl+6G2q5/nf
	ynwKBl70mEeF5xmy3m6RlEXQHeherrmj6tWIkQAapaErxJxjecWyc8FW7nHY9Cva
	kStEXKXdIQ3gYhZaaYfeEWZi69Xq/PxT9R51Nq7Qz7zvrtNDmLc9NjEmto6dZCQW
	jRcvP0etqxLORx+cYWgM8MimSPi5cLL9oMd85YWVeq4j4xeNH//mhaN/EYhu3fkm
	jYQoSgnETmy1oTuySjLVcOYGskuW37UrJafignQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:i4/Bi7cKEDwZbRFJAigK5ELyvVKjAP+Dz3y/GE1oxB0=:ZKBmfwrMZyeTmzVtuZRkcdUg3VoDLaqIhxwgT5jnT0I=;
X-ME-Sender: <xms:ai77avXU7i7HiC5T_ZvL6dze69-9sR0nrNWJwX-UNfuEJtsFNoLj9g>
    <xme:ai77auewDXLI99MVrEjEvBo7Ti9cLSpfok7q43PzqLcl0CiLzs-Iv3_m69T1R7Jsp
    mVeemDPon-rO1YhAbnievdM7S7tCxvxwDMtY6pfvmvd5FLsbT_9vw>
X-ME-Received: <xmr:ai77ajtvyuZV6lusfQFq30n9D1X8Ao0Y3coW8Cg-0exopuddzDhlbxkhiZmKXp0WQod5bfXsQETCJzG04WoMQikueMwBuEAbeHmU>
X-ME-Proxy-Cause: dmFkZTE1XEanc75WZ8gaXkkZTfPMNDyvmuMOjgDCWOR+LDvsydid6l3YPheWhsU5+OCs6p
    GtGLg/TvFXFTaZ3mGbxYTKfwDa2EojJtu6QlZYhthK1xWxzYNIFBGebf4DuTyIs2vZynXD
    qawVfwNtM0JztxXZwQ8cWs41GJKmE7NCwE5sMLDfKxjl0axF7sRfjIRw1JHPmAUzS2mb8f
    GnGNCBcEUKD12uGcxh55gXAEz5OiupdbCrOsdNOUmnDCX87YUwu0k+9zgzqkAFOAIn2rVT
    Poo64LIsYo8WqlOfvJm8mtgzXAgA9nPi4sULb71U+3kt7o1oPlH1fg7QNs1hL3IhCkqTcM
    h/tkT93LxuPPA7LQDO8fCQG7OPcRAPrK2CIs4h9sWZLSa5Ky7ZfDn37dq6KGKBy0+ZjlV6
    tNT7VzpPOniFdBWx3urTe/glelbE/EBIBQfjhrxeskCkFTe/jrGZpSJ7F8tDWeN46Yvt4t
    KQk+Xk69q7z+ZJ9Mz4xDzQBrUm2e+XMqp76hCljhEsFZJvk3vRKTWXHFfzqxF0AuKNnbjT
    71XIERA+8nv8LO5vR8OJ/7gKnCSJTUXIOejQ9kpKEoUJGMIu5KQzOxA8Zaj6YbXhwPNJUZ
    PhiCReEVpY3O7m0sipSmtiNw8CDdW8XlbdEJNd/0Q9cxnNob9n9KG29NPhgg
X-ME-Proxy: <xmx:ai77al-IJV6-eYhgB87ZNEIMuRH29m3qu06CGajSVPto67N25glzRw>
    <xmx:ai77am0nKh0RFi-LnJRmMMF3-cI554EqUp6KYAC0Mi8BaROMIVIEtw>
    <xmx:ai77aiAR1yyif5OszSdtbeJUfidYzCICj6qk8gDUgSJ02VG9hUQVsQ>
    <xmx:ai77aqdSrjCg05dhMzKkpK6P_iarefqtqqi_j1s_ZesIPAL1hXxXRA>
    <xmx:ai77aobG7y2pLjTta6HuNgF6PNwM0goiwx_CIB9TYzNJhCZyAv1mMMN8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 11:25:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Ren=C3=A9?=
 Scharfe
 <l.s.r@web.de>
Subject: Re: [PATCH] pretty: fix lost and leaked colors at line breaks
In-Reply-To: <2f9f835e3f99d7de5bbf51be2e8ef4dc0485a46e.1794778250.git.andy.koppe@gmail.com>
	(Andy Koppe's message of "Sun, 15 Nov 2026 21:35:03 +0000")
References: <2f9f835e3f99d7de5bbf51be2e8ef4dc0485a46e.1794778250.git.andy.koppe@gmail.com>
Date: Mon, 16 Nov 2026 08:25:13 -0800
Message-ID: <xmqq4idgn3py.fsf@gitster.g>
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

Andy Koppe <andy.koppe@gmail.com> writes:

> Colors in custom log formats remain in effect until reset, including
> across line breaks. Lines therefore don't necessarily set their own
> colors, nor reset them at their end, which leads to two problems.
>
> Firstly, lines that continue colors from preceding lines lose them when
> shown without that context. Notably, --graph and color-aware pagers such
> as less reset colors at line breaks, so for example "%C(bold)%w(72)%s"
> only makes the first line of a wrapped subject bold, and "%C(cyan)%b"
> only colors the first line of the message body.

And custom format writers have no way to control what happens at the
(artificial) line boundary that wrapping at 72 columns %w(72)
introduces, %b may include many lines but there is nothing for them
to say "at the end of each and every line, do this".  And that is
why you decided that runtime detection is the only way to do this to
help custom formats?

OK.  My initial reaction to the "let's do the same as the default
format output" was "isn't that the responsibility of those who write
their own custom format?", but there clearly is a gap in the custom
format feature that makes it impossible for them to do so.

> The same can happen to
> lines picked out by grepping colored output.

I am not sure if that is a problem.

> Secondly, colors that are still active at the end of a line can leak
> into what follows.

That somehow feels contradictory with the previous point, though.

