Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795583561;
	b=BXy0TMQHutAt40Ywvmb97gJ1c9XHd2b1j1pRAGPaCzm1AT5Znx9QvtMKrhiDSdfZxhJM
	 5Y7ajgfipfNX0YZd8hytbaLZpwmnuRUA/IfTgfZWd1kq1h7yWntw8WUpbtEyTlu+4m7e/
	 iH6l15NV7suHtHpatDUS++4h45/b/1iIpbD92lZIvqLFJnJAFusBpQkADj+fOSrB/NkY1
	 zWc2BpEVTA4xyD02Nfaa3t4IvN5u6q+eVB1HLdBA+/rZ1gxoKws5wbWKmcFsBdjQlz8Jv
	 ou85wTpBGxgN2yMA41UPFLPNJY3l4jiHhxqZY63HIj/aHBJGVqFGn2sBqcFRNJYETQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795583561;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=6gLmm3el/RaBLdHSAe9/Cqwhv3sdZpGMUOxgAucHx2g=;
	b=GMywOtZBv4R2JSFW9uHT/Vauf8u39k/DDHP5kGg2jOiIgvib4ab/X8MI9wErxmY1FoOI
	 3xCOcZFo+Ie7VlXEMYCy/4OvWhvB2yv5K6ZPyje4pbMYABjfQ+pUqjz++iQD6IMsyUW9p
	 q9HQrGYOXdhsFMTtAMOnkODhDlGVR0qJtTM7gK/6MAeigHDYVTgidl4C3jqPRhs2F8rQ9
	 QVIea9/PwlEi1XI8AFPWkC7iHO9m6uh7ohE0jFIkUrBkftte5EvEuptBWBKa65vjqPXfW
	 W2tKqE23RBjLt6qTCGsLTe+MVjBfP9VHGLA3cE3QJkJqgHsYXqYHbeOHYUFVPt/UT3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mzYJ9GXq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="q8lDjhu/";
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D75606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 05:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D75606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mzYJ9GXq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=q8lDjhu/
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E43B17A05FE
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 00:12:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 25 Nov 2026 00:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795583559; x=1795669959; bh=6gLmm3el/R
	aBLdHSAe9/Cqwhv3sdZpGMUOxgAucHx2g=; b=mzYJ9GXqHlV7Lto6NeEraaxzVH
	4WV+y6QNmw1S9LaaIOc3Zk3tu1ZhIiu4uUp+h/kAjMaoz112mxgIepk5aZ8pXDyO
	Ee+Ix8wnXhD1BSPihU33OL8aNvTcyeSi/+yCCscElwrJoe60AE7uYEhV06e63yAz
	+I19600hkpSnhuDdFzGuCt5Wi2EUOIuQf1tSSGovbqkPGuRykp1nTtFUfGbUXMRq
	suMpC/z34K6cM/XtGbaUxW4rzSyiO6d66U3jRfR+CbGT3bPR7eUi3ZeuEx6ZD/8S
	5HapQK5l3adsFQuKNm7+3zSh9jfsNnWFoDN4+VDYugaUq6mLYOhKPu6rtUPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795583559; x=1795669959; bh=6gLmm3el/RaBLdHSAe9/Cqwhv3sdZpGMUOx
	gAucHx2g=; b=q8lDjhu/GG6X9hHekWj99mvO1pl0e0Xt4fZVXFVAM12yVUcbIBw
	FKw40B1Ec8FmezutsHMBWMmdoNI9euJpdv2rUHhNW12A8JsdCoPWI26LZjOg63ia
	CCttRJCD/RVnt7+DAcFz4wl3u0NhIY/j29gkcZGlfxb5ObNvi1yaEYUmAOxkeAt8
	sbA+OQ1awzt38sSm7IV/p0B690Pnx5Xx9duUe/8In32y7Bt2JG1tFSYcU9Z0T7/W
	dch5GE4EoeYdy4QEbFvExfFO2prLzxRjfGOCUdQC8WaIJ6hGHGrCENPxUbZ5rs/Y
	ikyQGXyEAKaq3blqgoFWqnSCMvs39ToumYw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795583559; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nAWLd+PiMRcLaX8zyxUJUZcwk9Csxr72EHCIRv3OZH6Ydi2
	kisEqC0MylFqglGRGv3j5vbkJNHQtNGT1bkImUXiJWpYraP6Fbg/jBFpE0Yaxlce
	IHQAQvI5agmu9hFIx02qdTDv4N0umQqrzEg8BSjlWfdVxLShVrtNqiaOGjZrLInn
	QTZ6oGja1sf+yIgUGm0UwVF7xlYWpEk805Fi77ELhj0IAhdOWOuKV713uzZoYaAO
	rY2IHBtcHxEQRQMAg9dV6r1NjI0Lv8q6hn0ENWc87FQpMPW9T/w2LubZ7/moIMj1
	+7X+oTj7xJLjyPcvzXAKHoyBii7chl1S+CuAEfw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:xt87vAEAt5TxnpBacMdoI//RT8bARHR2kaHmXgU8Huw=:8YhI4cmcfL10cOwqFQpkFpe4GY/mi3+OGFGC//PWdTU=;
X-ME-Sender: <xms:R24GawSgyqBZUXxdzu_gUxtnwZgRnrRdFHaCjY4F1-N4Ytl7OvSmKQ>
    <xme:R24Ga820Igy-d07Z-nvVP_-2jqmfvABsdFZ40s8r2NzHBUnsY18nrfTTY1DR7BUFm
    6Lu_mWBW8DuR8s3OpbaCr6TfuToBScyLQI7tJjHCcrjpsM-7ev7r4Q>
X-ME-Received: <xmr:R24Ga0Dnv1-dsFcPdw0AkDVfY4R3Ae33tSQBLWZnOTHV_CxS6KATp4wQFGtfU6o6RbbQfNvG5CULaFBYl32NrJ712mgTwq_psqXrGLk>
X-ME-Proxy-Cause: dmFkZTEG+y8zg7oPicHeSgh8N5icbGflKAjHStVamMqehUNKYUWZsDfNj5rIS4dEPKag1n
    +NIi/O6nt1BH0NUIT7KXvFg2HwP1P1fUxZRaRKetCI2rG2PokqrRIkzt+Vz/2MgjkH3Ner
    CZa/w2tagTdXTOlr980v5cXW83Fb1liDf6gT8R9ALCkbIpEj8cgO3sAmU7lH9jdimjiK8T
    vWqZjLQanEHqEhfbiww9PRyPIJzdamZQMl5MVOLauP1LH7ObSoEPsvIiNlS4xZrlNoLFY5
    HaVNPnDzTp7YG5+D+W/Kst/DT3y7eVHqYLVFnnKmgaTWYIPxgIgojL62Die6IR9rCOIIQG
    KLozwBa6uqBPlTAKuWAQzUIQYDYUMrPhMelUsbSPtqdm9w6ztE+wL8UF17mxddn9cHGmLA
    N6PCYbXZSpifjfTslPPvMgMfMordm+hlxw2avRy8ceYiQKNMF7Zre/37ulNUXvWIN3p9wB
    ag2GxRf03nMxsC/UeqH4eJYVTUGPj8wNcoAFR4RKvy39T9zhV2co7EkAOSkFPHVfmfwj9Q
    Hj3RZf3f4BTTo5nALbzHxVH45wv+HmgxStzWJgsxCjBmY8dxIFvSOFzp8vuMuTyGlBsfG6
    egxtWvzYYMdie/L87zoagcvbAsy7hucStTv0DwyyLMtIKAuJwreBN872HYKg
X-ME-Proxy: <xmx:R24GawgUYlI_qHEQulj2ATPPw6hny6OckLhc371dlALUVbQKH6pWoQ>
    <xmx:R24Ga-NFYMFus4HUSbyTmSnCjiN54whv6yZJI8Mj7PgyHSt8WudVgQ>
    <xmx:R24Ga4-xw_xpexHBiQxC3pPbCFwPa51yJZaIXz8u_UgMLQyutVNSmQ>
    <xmx:R24Ga3dkcKWhPXv9XlBEwBP6tcKOF0nKd06UAP4O6uR953718zRZxA>
    <xmx:R24Ga7TlDpGoHrbvDuy3YVhdLjgA7tOozJBi_LFuL9HJGbwMMAgY_G2U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Nov 2026 00:12:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v2 4/5] notes: pass the repository to the ref glob helpers
In-Reply-To: <20261124172146.18330-5-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Tue, 24 Nov 2026 18:21:45 +0100")
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-5-okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 21:12:37 -0800
Message-ID: <xmqqse0pbika.fsf@gitster.g>
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

> string_list_add_refs_by_glob() and
> string_list_add_refs_from_colon_sep() walk refs in
> the_repository. The caller already knows which repository
> that is.
>
> Take the repository as their first argument. Callers pass
> the_repository for now.

OK.  The callers all seem to have been converted.  Looking good.

