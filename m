Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299882;
	b=pFmr4QgKk2laCQfadC50Dxy0HQpK2FOuH4Vst99h6SZttzxSOpqt0NukKGHj+9mOQrz3
	 s4raYGSHQfNBVBDLxDrTgWVByzNEE397efQs6ToPZVTyPfGevM5v0/LcUFy46dzXPqG2j
	 KqTXbOvM5ahQhNNnjsNdMU2f6j+mlWyH4h148f07TygWMoEeReXhIrYHdBX6Ob3LBarP/
	 GLxCBWj5KXQ80IGkQfj7+f8c8RmYZZsyjQ0jC/FGEuigW+itX6d1L+irTC2jf+9dkPEHz
	 8YcUhSuGl5ucfs7mfnv0r9oZqISEuizt9Oiv4RANhX+okkOXXdZqA6PF47Sb72fJpaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299882;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=v70iFdc8OB1A4FGYO+PTd2PXapBbqGr6KAB+KAhr/Rc=;
	b=qz4qOK1foKNcv3Tn5iMIAc1sr9yhcHTBO0pbhAmEG1KtxwTyvLL0F6EBjZU9BzX9M9N2
	 Dy/9/EnczHpTAaG+doydKStbdkfKbAtrYj56rL0SmgrMOYfplJoY8nt3WK7roNY98x8m2
	 2EoTpruT8/5xaxc1EFRorlgVxEIA5MMjWxunezvpSftnFYhUz2jiKSRIY5OPFFGe15KrU
	 mksmw51L4ZI7N2zP0ibwQ24BRHvwZ2G1UUwmKICvK2S5AKrzzhdi4i2FAvvup9GLsUasS
	 H5FExfn4Hs0qtKE5OSj+C6lJTaYJmDDKbBpmBz7GBsGgCJfi4E0XxCc9p0BZzHaK6Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Bg612tHU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZdzqoySE;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DEC606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99DEC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Bg612tHU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZdzqoySE
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DDAEA7A00FB
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:51:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 14:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793299880; x=1793386280; bh=v70iFdc8OB
	1A4FGYO+PTd2PXapBbqGr6KAB+KAhr/Rc=; b=Bg612tHUSzQ6Lb51z+1zKyfVRE
	xLiklyXPEKTAPeOF0Eb+v5pgdxq1W0SkI5wC0Sxtz+nR6ls091EFXESbFYFXmlf0
	zPjJGw0q3deQr06COp3ppTjWjoU/M8m/IfJeZCJDZNkSRwaA0toFiQHnTEPmxMom
	0/eUTMgKOJp11qAZQFal09oVngqVw0L9hpV3/46Q2dkbbCVyPOfopg7tFMLJVf/5
	VsxiODMwOpnA/T8ZuUFL7dVnPf4NjHfeQd5SK7fNCqZ4zdSupeD0qYqg1EUgO4Kw
	bPecEsgRvs7MitN33OPruBggeYMdjfSBIv1H3vACiLf4nahFV4V01Wyl7E+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793299880; x=1793386280; bh=v70iFdc8OB1A4FGYO+PTd2PXapBbqGr6KAB
	+KAhr/Rc=; b=ZdzqoySEXewGHhYR2aLUqkmCByiVpJDoTtQ1jj+Jpqd5fo4JxgV
	H7cNivP0xljw+qlUtcXdc73ONRmfzSnq0Rxe3HkUZGjeIooqi65Teg7OIGf/asRm
	qfBUeIoWaBHewJfLNeTDuj5rnwpZGt+nga/iYRU9cmUbZDg2kJG9KWi3+Sjxbaay
	ekGYgkDcn7cjyJozAmasV5D19b4CDBQLxsmAQ88Zb/9XVEZcODHylpPJrrxlI27q
	bOoK0GBPsdo7LDW1t8zoTv97V0BxBu4hjVrm17E1NW01PLCMzCtCZz+9zS74j6ZY
	SRCNV85DnBNLpMXPipwtFU4uqz4dAIvTYZA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793299880; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KGOGI7dKZ9sQA2P8vlJj/R94BLzDHhmsmUHbiF7ru4LIJIM
	w0guk4DDeL4aqgDv7owlm5OTdD2ewyuSe2j6cOIOKTPv6wH7LfeATbznFDoyXsjo
	Nyfm2Fx5xxt2fa7F4i/Prnog0uWNmAYQ+BEtxDuLiREDyGxs1YqJc2WDQJ0udLK1
	L+YGJ4dzfIUpP5Y8wwrpBV6OPdWwDuRWOIfuEwHAOgcRfeFs5P9zT9dya5FSVlw5
	9TUbGj0/hcGG7Pcy5OvdzI5ypXGlOxosc7xZL8qHn9fnFWfOePppQNKrNe+xefm4
	6DhHfGNIwEM19hXWM2dy7BDaXlPODsZyNAoGsLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ds5t3zt7PxuupiY43hr1AwiLsM0QGq8gpQmJuR6ZXpo=:w/eRjLNck3NgHTqN8s/6uJJ029JY+1u/EGfz/hjoyw0=;
X-ME-Sender: <xms:qJXjaklbe4rUQuXYfLnipWpjRBuTmx-udZEXMERSr7X3CJWxaeXTeg>
    <xme:qJXjarRrp_H56Q1hUQ0agFshQMqnnbIWvvcuoBSJgvt38LL9MNUVd7f6QLDCKqpDq
    4v27oFicU8vywDzwXW5zrBhLV_e8cLR9vd0QptWMXjvzV6f3L7jggY9>
X-ME-Received: <xmr:qJXjagCceuUQY7Aoyd3syubNoTu4qoU-0Ht_eI8rFDpeF66qbD6bemBxT0ha50rlsMYSdqSvbaIWY_aW8AuZQA0SgYtFPSHzmev2>
X-ME-Proxy-Cause: dmFkZTE6zRkjhG9ZuRVKJnfu2jsUTZL/mvjevSLA55GRiJwhMaJEI0UOcFmqZxfVchyRQY
    xz8d55g3jb5BvYWIbaGmH1PFNujwbbrI+DawmMswlkcfsWTE+ZhDUYVQpgnMPUfwLc+EEP
    rD5I3X9jJKlpxc//JmrNfKV+yZj6TqwSsFmvdQAd83+0KT8meUj2T2REWrP7ZY8R90Z/3Z
    OgTVkcv7tR1HXEaujQQysRRg/KBmniQmASrlZVvoO4r4xD4qVRqn/TJg/0C8rckQa6ViMi
    VhgQjl9rBDyHVblO+Q+QGO4XeF5iOBc6TYSiXjdaECw20vRYRzhobpWJ8LdxRA4cYnN1SD
    W3fX5U2+LX/S47v23OQxKT9PAhQj1CRbnL6fOc3m0CI0Nj/D6qVefQ3bue90r6bGxR1kQJ
    H4OLHrYVTjHyiAbXHvvU5ygvCfYSmG7LeHth2t4FtPMs331WLfpoUBU23T9VTq367enKSn
    yCw1546hQaUNbtcEoui928xuvhuKXuBbHo+DEMAIGVbP5ALOgBlxoZHebJN4BjuvYXQuOc
    Pw+59woPHyIzPEVu3JF/TCB8At2sUOfCgH4eYAsmdxGIXDPv1UzmLOHJOHOdfFyONCCnYr
    9UXDnGZBgLpsVSPVMvvCQZMxt4gWGfAnKhjKlnjXoa8XMnf3TdxArmhoe4Bw
X-ME-Proxy: <xmx:qJXjaqTvJpZKfNsXevdA8J2eczWkk3ancwKRyJGUjcALcrGXs8nElQ>
    <xmx:qJXjamrccne5l2066dJZchy6JymLeThQvU9p4ip5VXzT6nzV3-XMfQ>
    <xmx:qJXjakyWODZ60yiU31703zN4iuwzmMY9FYvPJZBRJdO0F-zrcbo6iw>
    <xmx:qJXjajJQA9F7LcE4NIrhgkbe5Wk6jkEW5hOlfb30IcIGJVRzlzUIFA>
    <xmx:qJXjavQ-ufLl0FrCNRzFX1GsWctkoBeHL6L4ozwl-BEPL5lLjv93ekRu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 14:51:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tilak Kumar <raaztilak07@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] t0410: use test_path_exists instead of test -e
In-Reply-To: <20261029141515.68254-1-raaztilak07@gmail.com> (Tilak Kumar's
	message of "Thu, 29 Oct 2026 19:45:15 +0530")
References: <20261029141515.68254-1-raaztilak07@gmail.com>
Date: Thu, 29 Oct 2026 11:51:18 -0700
Message-ID: <xmqqy0bg1gt5.fsf@gitster.g>
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

Tilak Kumar <raaztilak07@gmail.com> writes:

> Use the test_path_exists helper so that a missing
> promisor packfile is reported with a clear message
> instead of failing silently.
>
> Signed-off-by: Tilak Kumar <raaztilak07@gmail.com>
> ---
>  t/t0410-partial-clone.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense.  Will queue.

Thanks.
