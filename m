Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930354;
	b=FQoCK/AjrEgrm33U1Vy+A9EuIpMTV/Yw5PtLWdUmR6JMTjpkRdz8KfqCr/OOLiC2BL1A
	 FO3SVM+XwWHAx448h2fHd+xyfx9NtUtfpD/sjAkcTkReq7k3lxbeYCPUuRuiMsfjoxUlt
	 P7Q0G5sPMb0kndaJUvs8Wxr11OR1wiaHLICsWZAQJdvriATbklspjyy1P4cfey8yjZoOW
	 M77B4I/yNhAJr92vJ5bV2vmJhrXv0XUCWBkNLaXtbRLplp3N8fA8CZXKFKMivMZ/vxG/u
	 PMqNnVGOK9MaWO5e+U+hbNzuapSHPcPG9dd0EgXkz7j4mWeG5AEy7yWC81EIiiLnqPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930354;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Mo7BU5DCWKONLSIfMLZFhxqDeDpqQpjwxBtD1WY32BE=;
	b=Q/MVtBbQ0/oa1e/Xr+QYV+tQQbkisL+WmOqqScjWvIpHmvsxYk6FdQ3f5D6uI30VmwkX
	 11nb/ZRKL5pbg6eDZW3dF2eDdfiWpERCrYiHh8qJnv7K2OaABBkE+3eBrl/Xcqu2+JB/e
	 vZsl5A96GUyBlYSa4IpJVgPEtMFPF15r0QctwhoJJ7jtWs3WO2IfCOktS8+lsyudywR1u
	 bFHDIx6CrZSbo7LGXOiQflHndJCF3iZt969g3FGi1oV2b59CEGYM7fKUSGzjkcrp8qrqn
	 qpkPy/jH4ak0aKvsMf2No+EUhlrkIbiO/Hz9DCYqJ65/+QuPztSuprRdHLkiaW1rlVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Xtjlws+I;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Gn23KaaB;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5B606A31B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 01:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FD5B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Xtjlws+I;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Gn23KaaB
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97B4614000FD
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 20:59:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 20:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793930352; x=1794016752; bh=Mo7BU5DCWK
	ONLSIfMLZFhxqDeDpqQpjwxBtD1WY32BE=; b=Xtjlws+IH5f2ufwKX2iEAydbSh
	mTfi2xuzONZLwkGMwTK+TkQD8bO1/p3PrnfR5nEaryqGa+RQXltA+U5txgh1/NEE
	Xeg+jdbhDKTWjcMWDCQNijvKsd8xpPyvZLyetOvUN6KgoL8X6pj0JHRZ3NdYr2EZ
	eJkiV8LMoeiKQNfdsKYW2MUClS2xMsi/+iNMNp4zxlIqNPgdlJmjbj5oNHhEeoMU
	/cMWWciOfdjeXxTABW+UK9sne4KZ5LPe25pjcev3gYnMX40o/DjP7Un0DwAsPe7c
	qMOoJ4c8krPQn3Rn9fHhryjWY7t4YJZVXEaCy5vtQg3bTYkc0U51uM/yJOZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793930352; x=1794016752; bh=Mo7BU5DCWKONLSIfMLZFhxqDeDpqQpjwxBt
	D1WY32BE=; b=Gn23KaaBYgaD1OwkEtHjpCGcdwJcYZb5xBV6gCEygeOTWPvDtiI
	aEnn60NC7hTIHa5fskAbSl7OJpEk9yQ0Q7e3rwmp5m1tu05gLHbjYC5AdiFfPtsm
	5JwMdP7Vq3zR7TI7mYkE3wYSUwdBRYAoTPws/jQnSRddTeOqwmzRN2jgUGHygD58
	iYQgfSPl8ri1ndol2cFhN9+GUsuUqIpNAsBgsNAR/DeJu18B5SPbYVfOPEP1aCgl
	+NCcveZsgCshMEQDAfjmxr96xRhJv3rIhGhPC62UdBfEurculuy8TP2EoBI6MLjc
	GhCZW0Ilp8FCnY1FjO9ckHndAakjEbA/FoA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793930352; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WrB3FnIxLHGZOo1h2YC/fYJLe607Ohfq5zVoMbTbJfK6G+U
	JMmrGbyNQxVa0GY0b0HYup/zLUZAEz3Mc3ZXanJzosXxTEyNYagOg6HLj7IVOlC7
	hlwhuq4OFE4DNsTpim10tRUYScSdkszY7Dfp6sB47Kl5aSeKrGBZ/ON4LP7HMCyF
	xZ/trp1a0Qm1Z5Tm7j8tM9oo5zhJZatNPtJ1WJLepxNwMO12TbAEKrgEMBK1UH2P
	RbEjNy461SzUjMR0Rwp8anOafbLynFrw5hWrRHZrktpbcWE47jhWJ2rbxEgVxYnn
	oQshcS9cJ3rL5WGy86umfOeodxRgR4qzh02pIAA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zQ18lMX5p3HWm+uEPeEruEGlcP4qnWf3jxH+21lMYPQ=:bCLyf79bWafgZUMyocQzHBxpT5m+Ksyqlvb5z5Ud3lE=;
X-ME-Sender: <xms:cDTtakzERMagVRvScn-5fsL-YQbW_ZaEqx0JbIJzMxxKOxke7RmcWw>
    <xme:cDTtavSc4nT_a80lOLHioW0FGkXg4Io-VF8JEjRiYsJ4N2I7U8qmu6u1KBxg2wNYc
    llMgriK5AZ4gPeAtGNdLNxJpVfZ3IazsWAw4B0UZkBVyX82PDnu3Hs>
X-ME-Received: <xmr:cDTtarUZWhRoNNGglRd-_0ZweJ5uKgXf5WEa-gJAa4iuhK5aGlDKzpcjVzkeeEhiZRDt0Pf-K-5B2CSF9irlKi91G6U9k60YAgaN>
X-ME-Proxy-Cause: dmFkZTGI89cH7bYQUmRsPk1rDgnaBT4mzHKXTHI6u4YiUoe0MEcddjpnL+F/RYam9+Fjm8
    iOg896d3Uj6ynA8FLWQK5LPnwwd3dnbvY/C6e3UIy5DUv+PxXMicqgCsO9zf/zgZrQMxBQ
    ebuQEeiSZ4+bPaUGLnpOVydVZpDLicXeZ6V3JAzWbWjJ3+WRX6Wa1XmxroP2oFpmhUVAxX
    c3XwHUfFo8gxAsIZg4HUajkIhm3vqwxgB0DPWnJWRzlMzZdyBdLXl/Gd8Lx1mNqLTt2IKc
    owZWzOxgipMrcC0F29MVzpt5JiBd/B5phXvxdKF2lVjRuLud+S/oC+gmK0tqm7tcMf6PRU
    0vn/5Lq1vnWuR7m2d3khs0dog5vImIdlYp0t/lbyu+hRJSIZraeQflPdD0YXkulTpwYmmP
    /q0WtkIGAlT9wCYmkulNmZOsmdp1osQucmA0Tj5X2eSf6eLg3i1G3E0vUCnpukHELtlxWb
    HZY1yKjMTUKrgK9S1+MSv8EpIGM7r4cn2w9YgPE2vO3skCdUF79jqa06MmZLDLULOW+CpX
    G5QZLePPIxC4lF2hCjIEHmz1yrH3YZ/XcZ0P9/H0oDznQBlYzM3wPWmoINzlKT/KOGHkOr
    8LWa0xPlLwY3r+rUOhMgyKzkc0k3U7Ogdinm5Nfk8fIN5KPp38AjOwXJg+AA
X-ME-Proxy: <xmx:cDTtahaecR-oXOYKZNtNLv0U2EPk6gOEVIs8uYkmUytXwBQwpuUG7Q>
    <xmx:cDTtah1J8fQNUz_XjoMHbOv4tj9HNBNt2d4j8ALRA260E46Csm8E6g>
    <xmx:cDTtajh9vu173mTxBn3ZH_OSdEa43HTHaEndWW6qUFNj3N42M1O0NA>
    <xmx:cDTtala0Juao10Dt3W9kG5UxvfR30wBKc0QfNnOMoo0V94dUPkh_GA>
    <xmx:cDTtal2WuwuFjweHcJQH40SIho_cVRc9WGb2YtfhPveuv2A9F4rAm-cd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 20:59:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?B?6YeN55Sw5LiA6IGW?=
 <kazumasa.shigeta@kanamei.com>
Subject: Re: [PATCH v4 6/7] stash create: remove unnecessary index load and
 refresh
In-Reply-To: <8c54c118307cce6553929f5ff7242f85d0bbc733.1792767795.git.phillip.wood@dunelm.org.uk>
	(Phillip Wood's message of "Fri, 23 Oct 2026 16:03:34 +0100")
References: <cover.1791218125.git.phillip.wood@dunelm.org.uk>
	<cover.1792767794.git.phillip.wood@dunelm.org.uk>
	<8c54c118307cce6553929f5ff7242f85d0bbc733.1792767795.git.phillip.wood@dunelm.org.uk>
Date: Thu, 05 Nov 2026 17:59:11 -0800
Message-ID: <xmqqse1eoh3k.fsf@gitster.g>
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
> create_index_from_tree() is called either directly or indirectly
> from do_create_stash() after it has loaded and refreshed the index,
> so we do not need to refresh it again here. This saves three lstat()
> calls per changed path.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/stash.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index e17f75641a4..f97cd4771a5 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -384,9 +384,6 @@ static int create_index_from_tree(const struct object_id *tree_id,
>  	struct index_state dst_istate = INDEX_STATE_INIT(the_repository);
>  	struct lock_file lock_file = LOCK_INIT;
>  
> -	repo_read_index_preload(the_repository, NULL, 0);
> -	refresh_index(the_repository->index, REFRESH_QUIET, NULL, NULL, NULL);

Makes sense.  As a file-scope static function, we do not have to
worry about calling context to change without we noticing as much as
a public function.  And I agree that with the current calling sequence,
this refresh is not needed.


