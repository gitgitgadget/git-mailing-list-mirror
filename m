Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210489;
	b=un7q7VgWnr8KCarLA4KvnnfHvg4iRBDPNJQ291jCTsL191F6hI0dX3yW8iRF+B32mL5B
	 NQZC1arsnEhTsxKIAn0aG6TSOfz2Jd1XzCbZ8qx6B/7lj6b+L0toMQp4O4/X0zDPwCc00
	 BkKpWaOfzLZy2rGWeJE5O2hyENNlhUbSKu/tk6jy9qjPbTx/4+DhhEhpiaH/WF7hUKaiI
	 fnnYDTarVLFL7p+bNLL8hbuwGSiQp8aM+PoRse26fSroMuddP40tKmnjMCX9+SBzRd/Hg
	 SimpEjAGLpxIYUTRfz14gN0a5qf1gCMHcY/mMx/r4GIrD6ZcSzn6pxNcdvNJIjsMUwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210489;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=1JKuG7njZpkOhkxqLpUEOwECmreG6+n7mzLc5vqFxCU=;
	b=0mivphJClIb0PFownW1qZcaj+oqlta2x5Y2lCNACtW4rV/cG1WMRS0hPuEbAhcrBz8fH
	 ZyqGSf53P/ygqsCPC3D5m3ZH5dSfBMkz5NTwSmh6AFP1RPEmGUoOT09P+K5zGlUlHJmJq
	 xZDyCvaoC+FsxastZ+fb6JUp1sbm2SsBr3R+eoubEJ4M33WaShlcYAL1WCqHdJyfQsV2b
	 ksj0Tk31GfA2YFUbOoeqRHReKwC8T75WRW8LOYh6QPwdhpGMNOlLJnMiLUoXVw2H2aUh3
	 QrZiiNdMDb6rfJsRRB15VeQ/n4nB6oSfvcK2cZsQ2+ab8lCIHNB7QwHNKqPkfjVeLuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bFEHspEu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZIRkgGyz;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44D5606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 18:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D44D5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bFEHspEu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZIRkgGyz
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F3B714000E4
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:01:28 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 28 Oct 2026 14:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793210488; x=1793296888; bh=1JKuG7njZp
	kOhkxqLpUEOwECmreG6+n7mzLc5vqFxCU=; b=bFEHspEuddY6GaAU/NEfMA74vm
	KAvo8WGDdhGFtSYQGVrKsAnaols9mx1jNKZENRV2tMiSq7piFxgoY8DzkcdXKcFo
	h7dRDfoQPZxD7Mhwsuz/EsbZq+pKLCHnwu0aVBiynw16iOfVVSTVt+ba1PEOiq85
	tzTo40H6EuqGflORE/R23TdsbzT8eNcN1juinCrFYUyjbiLlUZVC7p2mJ7x+piir
	mMSlh+BIs+wGFIBTKmKmkg8adHlp8nnW6xHggsDT8w1wPkvA21/pa2M8n/L4yBjM
	YlnLeALQ0iqjNpgAr7ETv07BZRpaKbdhD6JOfbFZz5tqMvfnSBiANKvrH9xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793210488; x=1793296888; bh=1JKuG7njZpkOhkxqLpUEOwECmreG6+n7mzL
	c5vqFxCU=; b=ZIRkgGyzUGrnJRVfZ5ZCx+Ym+o8gn9yp7akBVdDVDrXlfTeyNII
	nP+NPP5Qf0fW93zAFjbRHClqM2t3hAiTRzI/YnSTb30AKOoPfmhKZRjsRQj8AO82
	hU94m+N8RwPzl/WPp11NQFJM+glowWLl/F8KwN2AaPE5W7Bzh5k4E7my6U654T8d
	5fTHuED1aj0HyDjGMXoM593+dlbpsdUephtl+qUO8Uw/3CzAZn29Zy5rsfZylWhB
	+E4U4k7KE4GQLbOV9pL/+CLqABXwuljZZqrur7apT/+EBA7LBFdnamMXTeBWDbUB
	8U0DKRMGxIgC8Xxxn8qE3qxFluCDcugzKbQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793210488; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:FsalQe8ESlgv7BAF6+QqP66IEQcPE6FnFqQ10t1HqCoodLM
	ByQHbeV6i7+hk791JepzIpWtu+h63jBppmcwnGDRr0lGann3povY7xUpiDpYMZci
	8IMq/Y2kNSb9ZiaVzFwWLNd9E1MVeB9Xp51x4dPCSPTiR3pdkGzx3JoCbBkStnSD
	1q8KDOQWWPOTCb2BN3u/JnriS6ZTuyu8OoRB5NCVO+Eo5uI8f4CUQO8b6UlYJnLH
	djG5CKFLs3Bdn6uUSCfOuWj2LPIGoVtcNbocKtSfaHLkU8EU10lMkoTPuDLguUhb
	7PECDfz0ie6ZRQOwTLds3tU1uyLwEBp8BBylYkw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:PjUxDSyyyutYetAkLoMoYZiZfn3PMRCSQAI1TwPhWvo=:3HouRgbHjPrscMnzbHvf/rPqknA8x+5XBw5fcQvDZ1o=;
X-ME-Sender: <xms:dzjianUMt7DV7d9ZzZSvn7fpniZMKuzEAYlQN-64z1IAjEhdoT18yQ>
    <xme:dzjiah1wy6NklwNOL1H3gNIxfTiu_N9VFA9LwsrKn0huTbNgXc6Vcb09F_Gj19xFm
    eEHSFax2sZY3JQPOIHOESvbVGdspXp3QlFInpTI-PP97qFkD6fvCXQ>
X-ME-Received: <xmr:dzjialqmWPAif-1ccm21zCrcftTKOO1wttujDlTnx42EuJMyKPfSp25glDe8nhYQ_LWiGGe4RBkxlaphgyF75v3Ru1vq16b_VwtC>
X-ME-Proxy-Cause: dmFkZTEu7g1+5fp9kpcQcVsPmPPld5TWLfzasV0BjSgieJK6tR4MD3enGUr3ixrzQPRZxV
    hdfzuTDpcMDKUU3N29BdYnWINM6t8vdAO5ehu5RVLV+VaH9Tgh+e5z8Q+K3D89nP2ulzah
    2xn6NSCXdiw9teM0uKN//JPmfBqOpLnLkhabW1bpkGtNRvo7ScMAZNC5xMAn9NTBArDxVe
    vSAQE1Uf9sV50fCIt+hjmSqpZ6XAFvw413K3OpO3/gRURyV7pz29XwigAIcpmmbnEEY93a
    AKYNByYOAvqVPuO4K0sj13f8QOe9RV9eSDdhBlujgdBcaI4/IANdCYfBsKY6PctqGEJcd0
    VNsc1nNFnzFKBkjeHX2FeJzvYIkHzni3w5M07+2cV0HOtlh3DgekQgwY1Dd2PgnBL1kQwh
    Pd5xLJbSslEVuoNosq9lFq9EJzHjvrlE42QCNsgLmFXcefXdnpC0wH6JFIn0nZFiAa2CKr
    J1FJaDoVN/3UC0GmxTJN7KU/M0S8/c1scNzh29Djf+Ligo5cZRnnPPMP/Vtlr3iOrerPPu
    EjawToUg/l2TBqqKbHsI2UkrX86GTt2vjgfvFxmHcfm9tu+JThrxyTLRnhzeAJmMIsvEoJ
    80RUeLv2fMP1Eb0A9qarBRyW2N5fpSh39pR37171i1I5AQq1enuc6v49/S7w
X-ME-Proxy: <xmx:dzjiaoUe2_AQTAzfO38U8VUSX9HpY2YfTJafMUv2pPCdYbOoeepyug>
    <xmx:dzjiagZRCCsymCFWut1mVAWzRFhCNWi-unMC1rzX5wsUqQGGUJrqUA>
    <xmx:dzjialdDKwOy00gulniBr3kj28d3XjywMcjUoNMH12Mf0Zwlugx24g>
    <xmx:dzjiaq0x-jGoWF4LYa4av6ZfkKK11osXY1YbZlaLVyPiJ7eNbBg__w>
    <xmx:eDjiasdEC8yAIiDu4PHzjeWjlXq5yJ0XHBdnp-TQS5F4H4mQGCYRBbsZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 14:01:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Tuomas
 Ahola <taahol@utu.fi>,  Richard Kerry <richard.kerry@atos.ai>,  Julia
 Evans <julia@jvns.ca>
Subject: Re: [PATCH v4 1/2] doc: remove gittutorial
In-Reply-To: <64d9811539b531104d01ae4382c90230eea01c61.1793198687.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Wed, 28 Oct 2026 14:44:46
	+0000")
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
	<pull.2248.v4.git.1793198687.gitgitgadget@gmail.com>
	<64d9811539b531104d01ae4382c90230eea01c61.1793198687.git.gitgitgadget@gmail.com>
Date: Wed, 28 Oct 2026 11:01:25 -0700
Message-ID: <xmqqh5i5aemi.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> The next commit replaces it with a new tutorial.
>
> Do this as a remove/add instead of just replacing the file in a single
> commit to make the patches easier to read on the mailing list, since the
> existing content isn't being reused.
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/gittutorial.adoc | 671 ---------------------------------
>  1 file changed, 671 deletions(-)
>  delete mode 100644 Documentation/gittutorial.adoc

Strictly speaking, this step alone would break "make check-docs"
because it fails to remove the reference to the removed document
that is in Documentation/git.adoc file.  To be peanticly correct,
this step must remove the reference from there, and then the next
step must add it back, to make sure each and every step of the patch
series builds and tests correctly.

$ make check-docs
...
    LINT GITLINK git.adoc
git.adoc:1211: error: gittutorial[7]: link outside of our own docs, shown with 'HERE' below:
git.adoc:1211:  'linkgit:gittutorial[7]' <-- HERE

I personally am too busy to worry about the "each and every step
must correctly build and test" rule while flipping 100+ topics in
'seen' myself, so I'll update this topic in 'seen' as-is, but if we
ever need rerolling this series, then we may want to remember
cleaning it up.

Having said all that, it seems to me that this version is now in a
pretty good shape to be merged to 'next'?

Thanks.

