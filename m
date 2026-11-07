Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092663;
	b=skW5DblJjzCaoihRhRGcVPuvNibHmyQQKMpqM349zK4yp67VclNAmZ1FJR6oPYk++kB3
	 r2/bse/R62w/qGITcd47oIOUBICECSAZxFrHUh4PoOyUqD5impq5SeV8WJQ84o670tOuM
	 E5B+05aWo0tRWcv+LXPWCCsBWXFUElg3E2R+bp40i+6CPU6q8+KA0sAAOilErieZDIj3t
	 cTaN8wYf73Ug28ajDhoLo9Z8d8VtKrkC8DLGsoqUq2lCYuYdHddtbO8KkBK2q1MqovM7s
	 KLM4wb0Q9Hq6iJxaHFtz4ZtPcQIuFC0GR0DW9p+X/qTmkFPcwZaKbRiguRy5VScP+yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092663;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=LHqu/lbW4CyJiggMjoybSqnSNujve0R1QkHTAI5qqaM=;
	b=hW22NHHy/93lhfN5lj/oaJSxlIPhZ4aR7jbHjZjPqfWjqkfZermz6ltOeoJXkSsYkZ2F
	 3cACtie3NoJMN2VMresChdtKP3Q1djgHhYk/IUQmXZ/M2ylmZM2zbDs7SV9dO8piq0cfe
	 p16BkqNm2U8GolwyiBWvTtONpW21+4+0KSaHLQEiG6HLdAy+NjvMW/8dnxXrFX2V27uch
	 /9f77ikNMYeTazU80OnlUtWlhLETvqFxLE4xtidsrwkZMOnp/QbnsIaUZcOKsG4cZJ/gu
	 aXiexOr2cVYoEf9nfFLrEdKsuQ37/iT/u68EVbLu+q6NB2oi94XISCR5aCyJluy+IBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KnACzi9D;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="U0keM/9E";
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ECA606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 23:04:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69ECA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KnACzi9D;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=U0keM/9E
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BDEE67A00E8
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 18:04:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 18:04:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794092662; x=1794179062; bh=LHqu/lbW4C
	yJiggMjoybSqnSNujve0R1QkHTAI5qqaM=; b=KnACzi9DwIneMqCrmogv+z7SGS
	sBl7uTqt1/npyUf8AdYa51yjzeTEC7ndOsA1KOBnb6SccWMbD/7C9jJP2/uUVNiv
	YxCJ/XXLOfBUIpbLvYedoo/S7ms+uRJ7gSbDLJtnhRXU17SKKGutIL0YaTNasudi
	pOzlZCLx2QuIJ3yDCuGCKSWe3NashCOtkucVCz/GSXhDqDmw0RDUJ0aP/cF49ZV1
	TCTNIftJiWc0HPZz51GN++MzGdancUr8Ty1HurVrlPvW16+f45tkO7x8qSigZ2Ff
	3zi7rz38QvMoxeqD8lrhDnHc6xnzhWCe5gEnMWgKyERwLv/VSU1qI5XnmSZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794092662; x=1794179062; bh=LHqu/lbW4CyJiggMjoybSqnSNujve0R1QkH
	TAI5qqaM=; b=U0keM/9EC8ZMK3UH++E4vEaecbZNQe7mvozT9N8yw9el9Welmwd
	LY8x/VErKkD9kvmFtfvLp6Sjh4uldvLzgNLBtLPCKJegaOve4dtPbJvQhXGw2rjM
	S0aI+q/AqqMr1fCLHL8sgauFh1V3sJ4to8NcRDJDsdipwuIjepxRJGdkM72MdmL7
	7xl3IXEl0PU+zlU/F830+1kgUt6cgMfUxh1xv1KIqgUirpNNvAUxSAkgESxh1ZvJ
	HtmZb5W4okWtJwNUGWEHuhYqcaKnkN8Tg9F4ej/K9q1wgNIMM9RD5K+mA+HoDFk2
	rYMEB3vQl/iRH7ZU4/PQ8iQFwKfrLDu3TMg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794092662; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:ejwGpws1DbdxywrL2HxTmO6FRg9oM4tA2xhGUMxNKAFywXe
	V8A11xhyuc4qJqllhRJIMGilayPAZ0WVQlAJaBHFKlR92auMAfdcvBxd/NftDUlF
	O6m+tMogt0WYChP2EFal79vda3hYNPtBOsS2BZmJTFwvCjVmeQcOFMSrYK/tFLBk
	IWGKl7gqFm9lPvxdXsT9FZnY1qMVvryZYF6rP3EOqrJg0bN4L19Xwp/f4W9Ew7DA
	tZdbbO3aJT9WW1WNW1m+TU+MQyVMWeYkJa6Hh1bS3zflrOjJBVDWDnDqfutpEY64
	x22vGeWDKXy/Dp74SI3Oi0QTg5/v1cTBtnaG/ww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:3csr/TTEEjA9nXqIhc15WbZ+5SwIHx2vfcstBv6YmQE=:DLWH4OBn5+SjCLurNUg6n1tbJcWieoJ6ZgL8mFAzFOA=;
X-ME-Sender: <xms:dq7van9ckFPLxyDl5hWIKc7VTzMsWx8Ch45G-_KvXgY_MbktsocDjQ>
    <xme:dq7vaqli0skgpmmpAsgJaFws9YhrqvelfKwBF8pBeaQHqD_kRN11DyHucRY2T7i6f
    NYIT-pYq5fpkOiogPtd8bcZ-QWxGmrbYHcGitChapkSBxryb1pP3G4>
X-ME-Received: <xmr:dq7vatVqFhi0yCgtv8ZrjS1p_mXvwIJGboTWjo9iLHx16OhOtTbFMhWNNpVmZKIEnZfSiHRkCsmXj07QRVp1RgeJYlgLwvfX81Ct>
X-ME-Proxy-Cause: dmFkZTFfBEfhJYLXtR5NJU7Z/50nA8vqN4Dygs1R0wGKigE6F68NyS+TsEn9wKkajaqGcU
    nqz0x7a4FxWYXqL3z+p/FRxRyDuVXeENUBwI5TdOxccLr9WSPtBzSTcO21zLV8baDpdw8i
    awlqff+NYb0hN9yeHf0env+ok8Num3klDJjushQYBwlhSOCD5H89OyLtdqOOOSPcwk6EH8
    y0QnTxVBg2gSBo5T/nrGhSm87h8yBHE2PDFMkypbjzPaYfnCwRCCrWWqClrNCrRmm3cU8X
    +VSXM6PH8Z3tD51HWgtZfZ5fr0RNJt830OMUDnBBb88ICgI64FWOF72oekjLoytWMLDMeg
    +nezdrGlGz6SssH8GqG1YtvkeZeSnzc9c5AgvPuzaI9ieS2fYkiLLjH8hnO9HugFJmGR3V
    wfHYz1HuvjrXN7OYf/5oVFdbBTq2RnajjbLBLnrK7AlgjN+omHApRSrHbqCm8NSNdA5On6
    +r3TPk2U0anxkX47BNa+jFEkeH/vx/EjuM/FXgwdIuNIqUJCYjltWnDbY+ERJJS1CLg0hr
    q3XcneYShU5/qcrKRMWKV+tsPbnkZTSmCGz5uXP1CCGY+XPLEHTO9lptyGRFgp+/guLFiY
    GFZc/IvTwp/fHJegvkNOZGX2lBzbQTtehaU0C3aUrqdL7vx86rT53x3f2Z/g
X-ME-Proxy: <xmx:dq7vavEEhB3aPZaLngZBq7T7_VOp1Dx83GYZh6Cnor0gZwKjFm3Z4w>
    <xmx:dq7vapdd6O4CSNowIWcjd4jwyN3hcxZaRtBrFbqqXWDYeQTNxYFyCg>
    <xmx:dq7vagLdNboj43Z8Aa4WDTRt3tSkIRrIGfG81TQB7CZ-_9nPAPftjA>
    <xmx:dq7vauEtkH3L5NjJzDt-oNodfVzQGQME776FmEpOGj_WPC8upsM7MA>
    <xmx:dq7vagGfWgCzRVCdYqS7ix-TvE9LrruuK5IFfsapPAekmd9c-7EsL7rf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:04:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH 0/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
In-Reply-To: <pull.2301.git.1794063565.gitgitgadget@gmail.com> (Kristofer
	Karlsson via GitGitGadget's message of "Sat, 07 Nov 2026 14:59:22
	+0000")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 15:04:20 -0800
Message-ID: <xmqq1p8w9rbf.fsf@gitster.g>
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

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> While looking for slow tests in CI, t4205 stood out on macOS: its EXPENSIVE
> tests take several times longer there than on Linux. A CI experiment showed
> that much of the time was spent in tr(1), which is very slow on macOS for
> the 2GB of data that t4205 generates.
>
> Patch 1 renames test-genzeros.c so that the actual changes in patch 2 show
> up as a regular diff. Patch 2 adds "genbytes" and uses it instead of
> "genzeros | tr", which is where the speedup comes from.

Just being curious.  Would forcing C locale on it help?  I.e.,

	genzeros | LANG=C LC_ALL=C tr ...

