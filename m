Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290761;
	b=LKptp2JAlE02fLFfTv5bvdJJ/0MoU2AXEDhN7bwf8T5qtUHWLhAEp6lQFLtLK12a9OnN
	 Beo1aWfDtpdDpb2bzK4mzOnFVAb2tsmZy7KPzzxMEtDwW4+H1pimjBglWpihhJ/3JKmX8
	 dw2Gy/DSMONExp19KIHskZRQ+pFhZXvkTFKmdWhSODn6FaecCZ1DbHoas1FTp/lHGhpOL
	 dU26eNQBSj16UP/8cbxyVpLAgA0ltlyBdtC3q3r0YJyu9y+A8sGqIVuOqgcx6/RK+cX52
	 s1rkuL0VPLzlSQ8bOp+O1/5Mf992iS44X7gDBzuEnNN+zccMPC1+7ZqTweIFB8ZIZ6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290761;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=MVd2aCVeCVZpN6n/J/ABw+j3fhaHWGMBkKj0s18LLG4=;
	b=KihqKJ19sFe6po1YlSqYeGTexnD38gEvl1nQiO0Z0zdsvbOB1Lbquz4lepAzrmZaRBDt
	 x66ZeaerFRM/xJip8W+VwnnsSwgmemKq3+ZpDMXWvv260mCIwGIRwWLBU3WYc3S/TSDjM
	 ox9VpyEeo/BOFvmSvgMIeW37x64jOPc0vcWha5lBeZIjMmwpONHCRB0r0I/nhz873OPS5
	 i14cZi7Q3wVAkGqqAcCYSIfVc/2vpmOelQnT4fUjokC1gYCl0Jw4Tae+oUSeDxYEFaQSW
	 0ouUEvBN95IdOpn84N0bxowj1UjakeADPosEm7GCy2nUSFqSZcpFzyr84ydlu9gFPVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UGif+kCs;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UhsFwVA2;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92A606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 16:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB92A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=UGif+kCs;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=UhsFwVA2
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1CCFE7A015F
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:19:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 12:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793290759; x=1793377159; bh=MVd2aCVeCV
	ZpN6n/J/ABw+j3fhaHWGMBkKj0s18LLG4=; b=UGif+kCsHrvs4Ge7v6jjvjAhph
	QtlyussTapegr3kfDxsCyiwxtVJklKm4qklkcysM8KLKVh9/rTAl+9p+zklON3RG
	hWAN1ABEvlU3wixyS4jxwOrPJF9GChmC1hJFCnO4MjbrsSo5rdJf3zOrTyQFdC3s
	q78KeWxI+Vhr22/z5ufkySxML1nuLPVnKnFL56RkkGcq/gAs++9zqiQvOwwDqctU
	1E+CO47OEivXaXWmSmVk9yti795wXQVLi+sC3hRJJPaLRM1yEZu1H1bRfgvnhGEW
	U3JWdOQyDsLMloatVMM0oRtzPM6Pfg99oQ94+ZKxSyAZ55PV47ML06bGFnvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793290759; x=1793377159; bh=MVd2aCVeCVZpN6n/J/ABw+j3fhaHWGMBkKj
	0s18LLG4=; b=UhsFwVA28ZLTzQC3viBKcMn5YGK83RoRDS6Hb7lNQ9OyqdPExl9
	gJ6xSxt7w1iGzH9kRY2syL3sYP7FxL0VvOtBiC7AgbfPizvM7g6EcBCRBcq0uWLx
	sK9KX+l4VzbiPtcGcXFXOOJLK9VeHtI3QkG+hhtls1hAxL4NrAzTB9wXasAqoEUD
	W93uBixryD1IFslXXIePDUcXNBaz/6YyYRQoJZ4gHdz/gR6lMjuxnBfWitEX8AxS
	iNj3hL9XkKb7/iLq1LqTFQ4gZHxBVOBscM5Z/AzB5hk6rzcRQSLx8HspDq6ecRI8
	BAdIW+OGhirTNwMv+YUH0K7otUBcfEtRbQA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793290759; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:WVumYS+HKqDshOxqBItPLwx08N4p4kHedGav1xqtHcGCcf9
	8BgbyxACUOMZKyb8jAkaGW32SKT1zZi1rfPzxv8FqVxM17OSrmQsA6GgexyQld4A
	hljGx8Yzu08kjYtuQSDu9rRmV0Lc4Yq2L8H8iNe9FCVmEWri9xjWYedyqG/yTWAA
	+xFmyZltwiKstOpC+Rnfd+pLvu4VcEwNW925txQYvThvujExj/um55Xi5ksdNIZS
	Eq3X79Ji22jxSc6zGyXA6Vqx50C8N1Pc1VceWRRTlRkf5aL/L4h5t2WJ9dNuR/7S
	C4ikrUKYcgxjHNXuI+YLGdHC/pMNnNdR+rjaR9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:8yHcup+FCjqCTtBr10+qd4JhCGgii9JU6W4SWe93CG4=:7CKDuasVhL/cw0PdF48M+6+B4z3ZB0Hk//e3FEWv/vY=;
X-ME-Sender: <xms:B3LjasrHjU-9XwlphQeiZcXY-dexVY46_mCvoCMQSE3hGGIzmTBGgg>
    <xme:B3LjahuIfildwHSEJFKGgDkQ0SknVa82eWbabUjhuE8WOQapXXn9poWIYDzhgaz3Q
    syhHnGD7rEhlIaCuWkEJ1_JdHW5GylW41EfQIBf02ky0iBjLb6JzZk>
X-ME-Received: <xmr:B3LjanbzmM8_TRj9Bq92u1HjTHnJ4T4mU6HbHS7LjlHR_WxPoGX1cSwr70P5Sf4wjs7WsRgwkPBJ-bVycqqF9QGZ5JcvB_GdImCR>
X-ME-Proxy-Cause: dmFkZTFqiAR6dZjKs5vsrqQLN/MByrkVlej5bimQq/UcPAkW6E5l/Nq97t3iibc1i6508Q
    j+W/nhGiG6X6B3xzddVD/wM7UGrTdNJmrOfAy2AhiSs0rS7GQyDAl3xxYtXFrFyA8Iaoad
    tDmncR9TH2rmKemz8Zh/Z9zf5emhXhTJ8b25MI1ZZIN6Fe0Iea1Aks+T7Qsz2bpg0owxTj
    XQB7n48zKcymogPp+hPw6qAlfiHCRbbS08EP05srL9EuoJ+qDZmzZTf11rYGkzJKku1kNV
    IHE3+Nz7jXDOQ5UCVW2A2Kxvg5Skq7ZNuiPD448QYJGUX0LRSVB8isxJh0qVP+wqrbHWL+
    5fDbWfnayr7WOm6d9fPVzBgxHgUKHDmH7sSsGzMXzFQeUQdXiIOTUJ7BNEpxGyXaTGCbBW
    x9Fyr4n1tHpQiSq6rTSFelmsd1NHPTTe2EeU2DxN2belj7EyoT5+rSIsmyrxBfk9wGjPVr
    ApGyE7z+AeWVhdnELsepyOqtxAi/EswDvZFVsxi8F2v9XA2YecDbszZLHpjebvqbMcp+HV
    VLFDuo1iEv6VvW42haRJVGyXAUYtte1UcyQ9VxtUCu+YCWCMpBv0CxlpgeNZWuggpHn/nV
    sgBhu1WGmGoSv6pvqU/eHLcQGcW5puvepqNQCvbqb2lPMYb0r3BOqXw2Jwhg
X-ME-Proxy: <xmx:B3LjagbLjAg0JnhfmTkB26DFNcWf_JtGG_O4DLpmnbP69kYfwLA76Q>
    <xmx:B3LjaglkIKhIiTIkd5HBlwFrD129kd_L5cW0VZvnAlmU6a4sSOmCkg>
    <xmx:B3Ljar2rrpbMqYWVK-L9EDHDZmDphwf1cBuLgBgUxXKr4TD7jvlICw>
    <xmx:B3Ljag0-qtGOoRKUxGeamgUasNqjo5_nrV97FKIMjNdTNNOFWIWQYA>
    <xmx:B3LjaspWKlOlk9vVL9-fntmMGrNCGivAZuLDVOUjViBZQHQf-quAAszf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 12:19:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  pabloosabaterr@gmail.com,
  christian.couder@gmail.com,  usmanakinyemi202@gmail.com,
  siddharthasthana31@gmail.com,  kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH v2] range-diff: use diffopt->repo instead of
 the_repository
In-Reply-To: <20261029084720.93221-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Thu, 29 Oct 2026 09:47:20 +0100")
References: <DMGX0XEZIMHC.2P0KB28XC83HV@gmail.com>
	<20261029084720.93221-1-okhuomonajayi54@gmail.com>
Date: Thu, 29 Oct 2026 09:19:17 -0700
Message-ID: <xmqqzevw4gze.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> output_pair_header() and patch_diff() receive a diffopt whose repo
> field names the repository to work on, yet they abbreviate object
> names and look up commits in the_repository. get_filespec(), called
> from patch_diff(), also uses the_hash_algo, which is the hash
> algorithm of the_repository. If a caller set up diffopt for another
> repository, these functions would still read from the global one.
>
> Use diffopt->repo in output_pair_header(), and add a hash algorithm
> parameter to get_filespec() so that patch_diff() can pass
> diffopt->repo->hash_algo.
>
> Keep USE_THE_REPOSITORY_VARIABLE because read_patches(), output() and
> is_range_diff_range() still use the_repository.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---
> Changes since v1:
> - Reworded the commit message as suggested by Pablo. No code was
>   changed.
>
> Thanks, Pablo, for the review.

OK, well written.  Except for the "In-reply-to:" header that should
point at your earlier iteration of the patch (not a review message
your earlier iteration received), everything I see here looks good.

Will queue.
