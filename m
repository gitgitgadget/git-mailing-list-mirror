Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341195;
	b=M/O2kPVsTqi6ximaBf7uQ28mFGwjDF2sOFPwU14HCP2WOGdUyHAJkGU2GAzisBexEL3f
	 g75oV+tbOQFIivW0VI+gBuIcYaqwsiL1mh+Nn3srJOx96T76KT2Hn3MYZ8wY9aIMp0Z/p
	 0WfNwna2dBhPVfHpvYlwYOM3Hf/QM8NpOrPKSYecp3igcN5zHHaRlrTL/PPxsqmYHpSSl
	 b8/yaCxPM6M4f3U/sOezTnO2dAvV3UXp2BOoaTJEcI+aOxS4K91j2855Hzq02lnkbdmcj
	 90eWGlNoBuRXZ7FG7QWKAVCEtmioa/4w/lqUiZI75IC1d8Pjmeg5LJaEFgtVldgX6fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341195;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=xCoA239HUvk2YCk/8da1xGAQ6sokjIycTdwgtEI/3aI=;
	b=V6uXGPlYKFo5NSP9wxqEBxcoQqT55Uvedf3gmE//Mix5RRnL+qmAKpxH3qIkKjRNJMGj
	 Cs0W6KpFOd2zkO6mSIO5lrySc8Y7gMCeANa5vq3X0wtzVp6L1rDspk1vqbKbL4jMFcJwx
	 AMj/FU0eWz2Sqtojj1i/V/cPn4j2HlQm20PMnaQeDklZpsVvMG19LCQNXs8cWh+iRoKOm
	 CRfTsJmdnL6fv9bV1KzH9gsAG1MmkLx1L2+c9EfHyACQSJqqu6xZxIlLp/2/BFXhUmYII
	 a3g/2fjzHj/ubV2wE644EXS+jiMN5TrWI9bXukW7WMyOVxhpD9zC3XNfF1DSG+VXsMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=foZsTaLT;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DhJOPrOS;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1F606A323
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:06:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99A1F606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=foZsTaLT;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DhJOPrOS
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 0BB951D000AE
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:06:33 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 10 Nov 2026 15:06:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794341193; x=1794427593; bh=xCoA239HUv
	k2YCk/8da1xGAQ6sokjIycTdwgtEI/3aI=; b=foZsTaLTfCGlV2+ZNH1xijASRS
	hgDYwSf5170DRZjOT9J3zUsF6IWg+YCW5IXDWiK+OMXN6cjmxEroMnautlvy9ufB
	D6RgKorgb8eH985YKPiyoEeqMbHhTD+iDMG9jjRLGVMAlbYgze168PW9kjkfz+/1
	HPAJe6HgfdOefUL23e3GvJSKbr1LhqzhcPSlz4rsj+tGgFL2PyDLdse+cBYifojo
	cjgomz4HYxI7uMRAZvAKgYKXX8Cu1ld1RcaZfoOQyY6XeVDLew1CnFdBgzf5pJ/r
	2ZhYlBwxBiFj7EyoLOyj2nxJIFfqZ7/J4APSt3eDR6Q+tb2QmRYVVAT+efVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794341193; x=1794427593; bh=xCoA239HUvk2YCk/8da1xGAQ6sokjIycTdw
	gtEI/3aI=; b=DhJOPrOSRm5dDeh97ii3+4SJEJlpj4Uveny4n1dF7XAh0ixrjvd
	RL4pSKi3oTwh4xrmHEcCfR6YqrYRZWVpd/hR4qeKaiilm5TJejf7exkxuHuSQ1zg
	slfWbALau55ZX/KAwPL+hdkLQXfuoA9mNmC42AELWLQExHvE5G3NKPlggi8AG7cA
	gZ0d5bsrbQVwpUsArKchnMOpeeHkGvjolzSHiN5RAUvlHD/6shajA8TA9S7iI9Ab
	pE1hLYL/ZtnUwuMUKN6S+dehdCJ8XF1Sr1EqAylcHXpc6ggFAOXwBZslaefXlMTi
	EKTzcvC9rJFRE7Yw07RqBAkhFnZD/3dTKqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794341193; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:QtGBHGYs3/npki2YtG+euISeBNtFcmXU0+sZ2gEl2MA9Dc3
	RX5lNn4D8UgpOJzfgznoKd+ZBaWwpedhCwAUso8AZcTU9Jii/kywpf2QWF7fyWWW
	tvcewLMfrf4Y0mXE+UgfKaKPxbxNzBm+EKejTDMTtoYgx8LQKoKQWzmDlts7D2e3
	E9jsj32pYn0z4QS2t4Bb5fkmobg1eZXMXKRk7if9fXRby7IHoY53WuHlQMFlZ1dI
	4D1Z1nv/A6HlQCpgLBLiEIXv2lrHlbAoNTeAyryang4Cq3XfcngPdzjMe7tjBCzH
	PKLFsCFyIedGGGiLfsoI4PkvM2OdieoJUOrzt1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BDXumq+TRwSkxwGi5Axo2G8GWU+UayOemZci3rXH5Bc=:mz4RuQYkZ6Uxh/KaUBLSXYGQds19uNPU6l+vxfdeEUU=;
X-ME-Sender: <xms:SXnzaoDUh26Yo-jhywPTFdN6mo3AkdLmWEYGccPzx4KHpflSriEL8Q>
    <xme:SXnzah9ykrA6Mx2erDavGytg0OQAFh-qkbuiI0GlRf_6JUnJrZNs89HIZ9ZuUKSPE
    w6t5bFL1XosBmOQXuaeWVz-UHjfAH26l0gSEwFOK1cQvz0K9kxslSE>
X-ME-Received: <xmr:SXnzao959AsEKvmbxyFVV_Aj70METOt0EX9Bd-g73pTvXjb7-BDsKNHYdeu7eUWCZCmwrqPz81R1G2pqH1fk1fMr4WZ_FqhgohFG>
X-ME-Proxy-Cause: dmFkZTEXM5X+HXueNIUg6Ogxu8FhtbTJdaa1Pt+aVHdesPtZ4imXWsxOXjvAs4FrWgyiJK
    9TUH5o5uPrQStZJdQLfxczIndcK+nvWygAqa1JosBCGxDh+ojW8VI1O58sFz+5LD7pDltp
    S2TTENOGcw+q+E0LClYAUYLra2FaVQw8PKVeocjpoJmUKku7c57VvW2sVKP1QBn1/70lQr
    5GYlLZBsUSw3h7oJfguotenD+mK+0qAZrkWFD1GGgGLxXoiDxGMNbc8Vo6rZZGn3OxbTeC
    2DuriscHWw1VWcOYFmUgH/gNN2bG5/C/Javj82ULEuOIcwhNI0cYfRxDYTG7pDb7vOw2iJ
    9/gUPrT5yz+VuHatNNGK3wvSz538s2G5WLOd7Zjy18NBf6vNDrfDwz3ziGEgKb1HrfGQdI
    oxGDKsx8+CUNANQrNvGGCh6XZGWRlHbi/gKrNs2Far5hEnBMEqFBTyXukvvSDov96bNxr6
    TzEO5i8Y+zd1pCK5+xWM2xVojFLybQMs3S5J+wcNsaCZJh2LD2i9gRGk98tHsOhoVkGMdf
    EsL/sNmofRyFeCfqTx0gY9q5UfEG1Cy9s8cxtiK5hB3CQl/zHENREKI6OjIEnKrCI0ALLT
    coAOTf+AeAIUGhMMm1jd00Kf9xj8qRtcE4lIVESlUd91JtaZW7tkxeTS7NGg
X-ME-Proxy: <xmx:SXnzaoe_7LYsZlHzdnfSLI3B9s-9E2sQhIxynFTE5-z0kr-RmBtagg>
    <xmx:SXnzahFStqMJ2YtQ-P_F-f-8pIkIslT9LqSY-_lW-MVXtPnXelEzAw>
    <xmx:SXnzame4mfIq7eqc12I_qia3LnOtbNe7P7GVg6_javg-FQSscEUhkQ>
    <xmx:SXnzarEX5yUVQbjYDZ7t-m-1Ni0VXFU2BOf6WZ3FKaWGeal4q7ukbQ>
    <xmx:SXnzah9Z-WOc9-l3B_yiayrEAjuGnaNB0htpnAObEvwxPgepyWOunBFZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 15:06:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 00/20] t9300: group and move tests to other files
In-Reply-To: <xmqqik24tz2x.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	10 Nov 2026 08:45:26 -0800")
References: <20261110-kn-fast-import-tests-1-v1-0-dbd9ee502aae@gmail.com>
	<xmqqik24tz2x.fsf@gitster.g>
Date: Tue, 10 Nov 2026 12:06:32 -0800
Message-ID: <xmqqfqx8qwmv.fsf@gitster.g>
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

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> While reading the git-fast-import(1) code, I stumbled upon t9300. The
>> test file is around 4000 LoC and each test has some dependency on the
>> state setup by previous tests.
>>
>> This long series unwinds some of these tests and moves them into
>> new/existing tests based on what they exercise. This leaves t9300 in a
>> better state. I think we can do more here, but I decided to stop before
>> this series got even longer. Based on the reception of this series, I
>> will follow up with more cleanups.
>
> Wow, cleaning up this script is long overdue.  Thanks for tackling it.

Having said that, there are a few topics in flight that touch this
age-old script and they are already in 'next'.

(cc/early-scan-options)
c2b4099f84 fast-import: use early_scan_options() for --allow-unsafe-features
cc4affc5ee parse-options: add early_scan_options()
f7fd8656e9 parse-options: extract lookup_long_opt() from parse_long_opt()
6aa1fb2271 parse-options: add parse_options_takes_argument()

(tj/drop-no-parseopt)
1db50e0e62 t0012: catch builtins that keep NO_PARSEOPT after conversion
5d735e50ef git.c: drop NO_PARSEOPT from builtins that use parse-options
ee68c316a7 parse-options: answer --git-completion-helper before command runs

So you may want to rebase this clean-up on a synthetic base, starting
at 1891de46f7 (Sync with Git 2.56.1, 2026-11-09) and merging these
two topics on top.

Thanks.
