Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794693311;
	b=5LQ0w/8DXqnNOg4RspMtcnpf2B+v82kR10SyYUp3NLZMz1mTlgnx0H5J60pDV1zC+Wu4
	 lCQLbGjTo5NcC5g7hg2neTNMJyovfFgG+wjASQG894N6uSfi9AWwLY2393ytSuLSGnm63
	 yDtFiAglGW46XkphWU+uqwLwbzGDqbdm3bq5y+MJ8MBzquGehWkzXqRLDVubpgJEMiCZa
	 QXp2zyeRd+3+P/NSrBuPfV8pQB9gbt49LFsnt8EPOmPN92S5e8SI0xd5+c1rOzzJDHJdA
	 17QFfesC3FKVn1O1N9IsulmPbjirKJ3Tho121xata5x7pYLRnEzXwwXthg1Vc9Gdgaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794693311;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=g2BaO/VGFF2RS0ObW6W4HsftYigRhW9hftgiz1ld1UQ=;
	b=ix+d3eUNxwpKc1HI7dNqQYrYQJzhFuMS9dAVtO2rf66wn9AxG1vRHiokmwDBfSJaCp91
	 +QU4B7iWc0Lvbh3jDNUuvWyBSpRJsF3zpMBXN47Hjh8hD/jU/Duq5BAH/7WnVXOFh3KTg
	 aWnNMPmzAJBVf7VzcIBfHm4UT61QbrG3rdurwJyyw5UwSjEfz62x9Y0Sfzr+lpEcvV0gF
	 oNnWgIC51LWbyU6Jgw+FO4SGdS8ToSm4F5TP2QlG97QOtP8gt09w5NblNal9UvVeY6H5N
	 zC6cwpKv9sw2D/HWQGOg9mqvrNem4RLKV7L3ti782sM0qflKGBJjWJM8v1wmuqqO7ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZkM5YIi+;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fcleee39;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A2E606A323
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 21:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3A2E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=ZkM5YIi+;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=fcleee39
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D3B067A007F
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 16:55:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Sat, 14 Nov 2026 16:55:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794693309; x=1794779709; bh=g2BaO/VGFF
	2RS0ObW6W4HsftYigRhW9hftgiz1ld1UQ=; b=ZkM5YIi+vnxHf8vnku2zDHSVfi
	2wL3TwK42J7flhfx39rFHMgl4YBiKtdYb5dGSoMkTfFdV0Qs6sxL1faxOJl/8dNq
	CheuqTud8VER/yLm4DSbNLn9rBQXaQYs/VTLM7xDnnIxQJTKWzCZ3Yy2CtrvLjBj
	wW+5oD0xSHMW2l7TtAkRcs5XKO5Do+AHXqSKj1lw92sq5b7hHHvY3yZNW6HJVjyN
	ZF4HTko/fqX+IfGzAgQ5bLxotkYEdbSxD1XQheZN36W+fGXl7IbTGKVj/QPtLIUg
	LnYwxSHgLQc6pQPrD1Wt1uSpOyH9+n4fQuQ9uopqtxURRusg8vlrrCwZKjhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794693309; x=1794779709; bh=g2BaO/VGFF2RS0ObW6W4HsftYigRhW9hftg
	iz1ld1UQ=; b=fcleee39oAXlrMssR5rRlXido5yn3pTpLivWQeoaDqEa0daTTI5
	av2pXJunIw7GtevkVUqxSrm2O2uCj/Rl0wOXfpy3c4wpgp1BzsuQh/a4mXyqZVBp
	ENxvGHt8UCLeLPlComfv1i1FUb+DSIdIdq7XTbxkTkhehI8ib8nNxc2eewpcKkry
	ArkkLXQlf10S/jccw5gDeQ6Xvhbu6NWAOQq2X3B0x0JTokL/YNM+LbkmQlSDD3d1
	gmIqINbttfjeqGLqM0AhE+6/MvSNvcY7S5KLpkG8WUIZbjUEqFM5IATM1f1MK512
	d4VwkhLW0spm7jJJsXLPMX7H05wvRfnsg6g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794693309; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:KUOqFJ8SD0xoPD2ki/ZcDODITqVg7veD7pcBDuLArlR3eZr
	/uGQweAf1z1EhGGHA4WmgVU1vkFxER3MoZK143HP5PZeDdTn7vj1swp/b9lvj2l2
	SW1Fgk0JMoLhgk2x8+trARj5KZ0rBB4Wxx6my87XD3woJAAd8QX2aIY9VmGZ6GNT
	+eSTX82imO3vAOq8WQzFxn2aBnyrqxSGGcY+axHbrAirfKkcyri9VnPHa5H/d1wy
	rqVGjaEVwvUEHpIoKVgE02rrOnVX/a6yUj1qbEhDqHMPEuyCpx2fnivDvwYWd3kO
	MqvIp8a76NCW8NKo/yfxScX7FxFpLCBpDVuKbcQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:mtCknBmXA42KKdLWhflFVlECMQtlGCdarxFbEnGEJG4=:ycsjX1zVU4pza8sANxgN/ebk8RvzpaRdRebGDHK/UaQ=;
X-ME-Sender: <xms:vdj4avd1YkclsV_cw0-YkFop5Lby0KX-Ta9HKfvwKJo219ETSMap-g>
    <xme:vdj4asobbn6AffZaGeaMQrFj-AQluApD8x0VNPnWNn_BmeXNSssFa4jDa-9G8WtgJ
    JndOUoXzvlsR_CPk6JMpfRlemTrkjIiXDKNP3s1UEZCKoQmUkZWzg>
X-ME-Received: <xmr:vdj4al5Zj8BVYM_pdImXB0GOMAO--CbUikmoRAByuIDirBKoJQcljmqVyEKOvvYnq30VoGuW3_b-2cfCAFStj6ghmEkwobvOp_1B>
X-ME-Proxy-Cause: dmFkZTFqBq8NDOsBjjPTer25VhLnnwt1428dcZzOIwN9Vl3X9sn35OZQIB1c6sS/9ojFyy
    eTyf4kTXkfqGpPnvFCr7MhMnZYMxqI8WzkEy+P/nz0wh+knrPRHQC3hX9ypsQfrjeBl3vQ
    Wo4Bf4VVLLWGuawMluJt1h2wiqxzlIxRuNjCuPiZjxD3yu1/nMQR8hNWIkqKsMRvDYH4ZM
    7WXQnPrbdlSubicByjgRbw/T5URSb/HxsHZBUYuxKa5GTVfYKM796PT/3jzfHB2np8QwUv
    Ilj6Ry+5Q679GaJFGOM5juJMluFwLCXMBTnl5yKC2DYvCd8NoR1xOF2/yXcbgulYqSEbHC
    a7Ht+D3q0F/KvX5gd+BHDnZv0ow9k+twKKswrnLKBwyHq05MjlSqf253svJqUZZE/0R23M
    GDnvxRMGxYjfnCyB+G2aFbgnEwof002umlAEsznmaZgWt2+A0rzvD5CSvt9WqcQlbq/svd
    SlZ9RDaIys95BrEbvxoeTonkE6ZAiPyF2ZdFDa1HBySuJsg28vMbJ51wiUB2iB7MgzX8k5
    ZJ2yNhEgno0b1D6L0TtDjFYATB9puxRDSEqrpyvosyYzidB1lTRs6Jm2inJiAZeMRgMoz+
    ro+VMobb32cKUSRW0JOsL384ubE/yq2fvHYhilQ6TWQZLxEHCI2NRR0OeWYQ
X-ME-Proxy: <xmx:vdj4aqoExpayDf7wmuzZu-kE_I9NM3jEX3qNlK91IoEvuy4AgTiMWQ>
    <xmx:vdj4avgzmj2EuUqE4ul29sh1KV6TZdjU9sHriqnuh05Haqr13zF1GA>
    <xmx:vdj4asJxishujYBRTTQYV1_UtZnp49hDPgFbYMtJJTOu5dd9vVnLew>
    <xmx:vdj4anDF0U1a_C8gUVkX7ZEuY25jBhFaxrj8K8JaEa1ILmg1jvFu3Q>
    <xmx:vdj4aoT04OnXlyfbRpbNM1sFp1V-wwSx6xu8me1lAHDTk9g0JYV0sCz8>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 16:55:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] doc/gitcli: minor fixes
In-Reply-To: <20261114201632.103400-1-dirk@gouders.net> (Dirk Gouders's
	message of "Sat, 14 Nov 2026 21:15:44 +0100")
References: <20261114201632.103400-1-dirk@gouders.net>
Date: Sat, 14 Nov 2026 13:55:07 -0800
Message-ID: <xmqqik1znkn8.fsf@gitster.g>
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

Dirk Gouders <dirk@gouders.net> writes:

> -This manual describes the convention used throughout Git CLI.
> +This manual describes the conventions used throughout Git CLI.

OK.

> @@ -28,7 +28,7 @@ arguments.  Here are the rules:
>     `v1.0` and `v2.0` are revisions and `arch/x86` and `include/asm-x86`
>     are paths.
>  
> - * When an argument can be misunderstood as either a revision or a path,
> + * When arguments can be misunderstood as either a revision or a path,
>     they can be disambiguated by placing `--` between them.

I would rather have left the subject as-is, and then rewrote the
conclusion part to "it can be disambiguated by placing `--` before
or arter it".  Once you start talking about multiple arguments, you
would have to also reorder them so that all revs come first, then
'--', and then all paths. 

> @@ -76,8 +76,8 @@ you will.
>  Here are the rules regarding the "flags" that you should follow when you are
>  scripting Git:
>  
> - * Splitting short options to separate words (prefer `git foo -a -b`
> -   to `git foo -ab`, the latter may not even work).
> + * Split short options to separate words: prefer `git foo -a -b`
> +   to `git foo -ab` (the latter may not even work).

OK.

Thanks.
