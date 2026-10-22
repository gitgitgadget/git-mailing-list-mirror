Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792697419;
	b=mrdFCel4BQq0G2SAUHvalXVt3CzIQ4XSP2meefd95/Tpn2qx/L4wHwx2MllODxOl1Bgg
	 mxigYnij/MheSOOdvg95go8fj6JMnHi81Jrg1phrL7oIhzee/45FT2NLIELpDdbJYkJwp
	 YPWDL+zLFtRichwdr9eGseAjbsktCku83AYhPN79U//SxL8HLEd+swe4MO9MQE/Wo+e3Z
	 roSLaguunKMXivk0tG0N5XA2isIAsgu+zpKrOIA2i0T2GYMIpVTDSaxxPARRBUbkmnLBt
	 OBaUllW76Ci+4kkVwiL1AUbwjbqx6cUO6huMRml/H0exdFe/S0N27oe71Q5wqQZyEog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792697419;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=scHHkc9m7Au94MQGn6/ug7dm7hwen4k6IqJAgn1twLQ=;
	b=kE42JeMb6h/Kb7qn9YOWAGPkDeoYuH4ZbvjQKDWacWx1lm0Axd2RI7lR/aUfJWjcfTr1
	 KgMV3oD3Y/Jb9GqMRyA9DZ9NICUDzoeUqFgzmc9wL6tsE+uoAFGOTga6/UZEsIdq2aNkA
	 T5dYsWybpIA4Wy2Uiq9s/f3cBdRWVziaT3fByO3fEcBPu6EeQ+RypETDQjLcSg1JHIVfh
	 gi19z9/snY0Ypido126ocuZefA6LVNet+kc6cmBOSY+y1LUoLNV1WxhMH3gXwhFH65moL
	 hTc63cQgp35vq2rv+2pxgeUkT8m+4eaMgpS5GseLaOKiCd/UIO+TAKwm+QwA2UvSuMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=AzYk2UjC;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pDG72thc;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B7606A31F
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 19:30:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B5B7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=AzYk2UjC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=pDG72thc
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A90917A01E4
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 15:30:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 22 Oct 2026 15:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792697418; x=1792783818; bh=scHHkc9m7A
	u94MQGn6/ug7dm7hwen4k6IqJAgn1twLQ=; b=AzYk2UjCjfaJ+2uCdD8JPJLQSv
	9a6qsoXI1ppkHRkHv7PNzXlpxxcIjkF9qYzl0dfFhsO6B1qOK8Cs4BOtKzent/mt
	BjKBUuS0KdXODg0wkEe1E9rI2QlwZAj6FxkANeCilNyhjwZUrOY+z4uXRpG58ygP
	TFoNpgjY4jkIfzudGqDkHOjldXk7sZ2aci1k6aolb0Q6tGO+OjNVtgBxUvi0zE5z
	FGM4lXjKAWsdwsrc8sgO4wuA8wqeXPqXTCZhpoLLp3juuDTDmz5kDKCoRoPpO4nM
	D6P/K3WRBkREGzFWokvu9x03IYYH0f/9IGKdsFQMdJXKFL64aD15Jj60s5Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792697418; x=1792783818; bh=scHHkc9m7Au94MQGn6/ug7dm7hwen4k6IqJ
	Agn1twLQ=; b=pDG72thckHjTqdzUM6KZAKINDFOCjg0nUNHLNxd/3AdK9CdhcC8
	jVdaatQnc8ix/cFLvbOzeo4/GfhTKT6FrqB2WZuaPhIi7JlIk/S1gRKaaBuRigEV
	//LHmfQ+gIWbu4sM9e7cpHL2MFlmlFVM3+pPbteMgaueMga/0wNDKlRGa5U2fXQH
	t/5p5TEycT/213ifh2yce/pWelBKg7M+O+QOoznLSkslfkXOyF6xmaqwsnqvyp1O
	TiPdG96bALGjX2AEY8Hpb4sbKPeas1PYU+ZCW3xQSBWpV4jBY/4FpIaNMuQ70smF
	hZ6Ggc5KlepwJ60bqcgknjTAEeMBQCFeX7Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792697418; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Ca6fCFdeAZIwofhUVE2u+PE7wmZwqgrmKTJ1K8HHvh/m4SZ
	ifSbZoWU3tzRfKGrrgFH6CV72Gm9LX12oGlasuyjCdjRuS1d1jYjEFDGS6sIAhHK
	RB0pFqC940M+1KRCp2Xv19XQNmINmqHgexIlRA1rwCTskBk0s/a0V6iYrEv06/q1
	ulBS0zlogL1xppPAt9lVzModmaUxb+PYnK9GX9w3IXhaBNiFOPSRrGtiWXKKGdxj
	iCo6JdA/0TiYXBHuIiigVItbh/seSw4EUwexp5aCkXkLGXYHLFTc43jxEFsLTOuk
	TtzkXelMZO1gf1SFl+pwoF+ZVp5kLUnj8yVi9OQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:v6WTgIOLeID0OyxQzAxcDLgxA4vpXcG0q6OGU9iBXrM=:xqeyqWfSRVzgsc8V5w88C0Gr9czwVxs/BG57Qfdxjhw=;
X-ME-Sender: <xms:SmTaam3gW4xxrHt5LbTBH46qbj8lv1jNWPZpGHMqGeXVBAMlzL_KTg>
    <xme:SmTaarWACrhyEzUR4Qtifrl1wuQKSKB8CRRaC2zL8Tg5rOlztaHAcbBlOSH2ekck_
    xtasy3Gms-j0JSa_plxKEcLGpOXrPJNCAzZ4KImGF4e1hcIwDGaJw>
X-ME-Received: <xmr:SmTaahJHO1QWkvhjd3pke-XuUTTRqINEtUFgK3qnWIsGt3hEs_gALmjHooYM2Qon1c2uogDrgzGFPl7Z5s-Z7Pi8w0ZNjmOdLpgY>
X-ME-Proxy-Cause: dmFkZTFdGu3U8GNPKSjo6nVcxRCq+7Qwgc1bZGN5oRHNlC+RIy6Zr5gbvdqvF4PT36tRxU
    mCFS8izhMzna4IDyXmvIAzVdu2OaRmxbBhkJ167rDwPupQxJxPj1cpncDIrIoRqTo6KtHz
    j4E8VScj7zn3cCWc+EA2b5HrBMJ0Je8HBHytf5gt1RtdUVfFcYn1SzaurM7VJeHAqWqiAQ
    ygZdHml3Ih1lTu2Gwmg0x6/X9p+qt5gl88b6GWhmQ97vlyqxF9s5LgG4i4a3lfJTKxWT4h
    GwSsV3/Q+icaPJr7IhSphq+gy7rOx8f852+uMwcnEz9YyJl4SeBuhxSO+34nVrUoDv8frp
    asIFurZZCVZ7OPzkOyn34hCCfJsDWHP8OjF9ISEHCpl9flskBx7A2tntDhWzVQ/FrnqaaM
    z/TANIaHjh2hR9gMUrAtTPlgnnHGqTjtSX7vaqgiAWRdDdH0FtDN9BJnHrNMiBxH4Xqn2b
    OHTQmGpl99e5iGRsw94WbYj+YQJCMfa4ZbAMk7zxyJeE8P1HuqNddjWavPg6meth5nkZ+B
    nT9FP8rv3R2wFrdG7+lyRY3G7J8+JBlvFAi+gBfAOCqydGpmE90CBXGgBfIEduUQn50fkF
    +/5sCUd+hHFJKFQyTxWyCZ0cq+C3d+gtCjLtlJ3675pNuIt8qJcwgybeMzzw
X-ME-Proxy: <xmx:SmTaat3cXs6Y21UlcgMYN2eL6Dzbz_sBWnQQjOHd6n67t6AOU0y8lg>
    <xmx:SmTaan5sQ6L3dOfbqPGm5NnqkSbaA1qF18VakO9hrirYmd8m9pC0Ew>
    <xmx:SmTaam_Fo0QnLu6Vx8n2tffEqDn7ZI2Y_CpASCxrrHOHS9hRRQLTcQ>
    <xmx:SmTaauUlSxU745WsFC9AxvWxRMM3M-IDjL79TaOBI7rU0sCUgNvoyA>
    <xmx:SmTaanL6goDdHEhU8vvHlXz1mre0d2hEi_j9z2BDaaehzZUGwkKjQD9y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Oct 2026 15:30:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  usmanakinyemi202@gmail.com,
  christian.couder@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v2] checkout: pass the repository to
 unique_tracking_name()
In-Reply-To: <xmqqo6clfu19.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	22 Oct 2026 11:51:30 -0700")
References: <20261017225326.7827-1-okhuomonajayi54@gmail.com>
	<20261022105641.68963-1-okhuomonajayi54@gmail.com>
	<xmqqo6clfu19.fsf@gitster.g>
Date: Thu, 22 Oct 2026 12:30:16 -0700
Message-ID: <xmqq33txfs8n.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Replace the last sentence with something like:
>
>     The callers still cannot call unique_tracking_name() with an
>     arbitrary repository parameter other than the_repository, until
>     the call in unique_tracking_name() to for_each_remote(), which
>     only works with the_repository, is updated to take an arbitrary
>     repository instance.
>
> perhaps?
>
> And explained that way, it becomes dubious if we chose a good place
> to stop.  The updated unique_tracking_name() gives an illusion that
> callers now can pass an arbitrary repository to it and expect it to
> work correctly with the given repository, but it does not.
>
> So, I dunno.

I think we need to improve the situation by doing something like the
attached patch.  We already have similar provisions in environment.h
(to clarify that have_git_dir() and friends only work with
'the_repository'), hash.h ('the_hash_algo'), hex.h (get_hash_hex(),
get_oid_hex(), etc.), path.h (GIT_PATH_FUNC() macro) and
repository.h ('the_repository' itself).

As we pass a 'struct repository' pointer to more functions, making
sure they do not call functions that still work only with
'the_repository' will become more important.

I suspect that in remote.h, there may be more symbols that need to
be hidden when 'USE_THE_REPOSITORY_VARIABLE' is not defined, to
ensure functions written without the macro can truly work with
an arbitrary repository instance.  The attached patch is just to
illustrate the direction.

This is totally outside your topic and meant for more senior
developers who help polish the foundation of the codebase.

Thanks.


 remote.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git i/remote.h w/remote.h
index bfa5218c6e..eb7d4481eb 100644
--- i/remote.h
+++ w/remote.h
@@ -145,8 +145,10 @@ int remote_is_configured(struct remote *remote, int in_repo);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
 
+#ifdef USE_THE_REPOSITORY_VARIABLE
 /* iterate through struct remotes */
 int for_each_remote(each_remote_fn fn, void *priv);
+#endif
 
 int remote_has_url(struct remote *remote, const char *url);
 struct strvec *push_url_of_remote(struct remote *remote);
