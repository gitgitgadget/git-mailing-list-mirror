Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793644541;
	b=mEkgT3ldcIbPdWo4M9KqK9kBClwazKBTmwpxcyd7ETwFHxlWTwc+2ZAG3sUUqia/IyGv
	 ncCRnYJAWvLPQR974bF180algVAYVuYvu+LtOfTzMp9bgG7QOmWbhGDjoJhtgW7baS3BI
	 9VUcY9xwLnM+MQ7XLkXTfZq2qDbYwk+gSKTQcgjXZrx4o0VRBGJLvWbNjy5rZnHefbl6u
	 yeb1koPBI4UfRlpkO5h5VG/LQGK9eR/ITFh7OebLrGk+IgUvkRXulBsif1rLFQ0mkbLQy
	 J6XrSpqMp27v5ONWjbmTm+tIBLPd8wVLNGSM+ubd52qoh9L+CQB5qacM0VxtkkGAQlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793644541;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=cb+/pnODvjB2SkCr9x8H71b+AyJ+TD/0aBlPajNsS2I=;
	b=FAftEcO93xdiMVZatGQnsypVcwboQMM8SaF4TrZayE+hmApDFrY24RDF7cs7AdUSAdsV
	 RblulsQH8MYBqkfrK8MuUdlv+/qnezsLj1Sqt780OWk7bD/KCwvUtKH644/sR0OxKZaPo
	 lD1uzcPoiDa08T7bymZ9kVlLfARqoctw016LyD4j69NUnQFF2MuLoE37/+oGNAVMQp2C9
	 HrDMTS86bB8U9JI+a3nAUl3o8b31WFOdO2W7ee9f9CevDdOEEb7RxnQlaY7p4K4C7lD33
	 X/s6RA2q86CA6mPgQ6l0XcQYtYOJ1rELYT6iDi8zr7Zbs3GljlwogcnZemWKtni8U2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="A7/2XpRC";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cVEF0ccv;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 517AB606A326
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 18:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 517AB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=A7/2XpRC;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cVEF0ccv
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAD757A00CB
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 13:35:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 13:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793644540; x=1793730940; bh=cb+/pnODvj
	B2SkCr9x8H71b+AyJ+TD/0aBlPajNsS2I=; b=A7/2XpRCLgMYmp4qA83SEbfsJN
	Nt8CFOO8dJYMrcwp+zJd2ccSAAUppJhVebQRxZPAtWHc8AhHpVsCrm1Me9PPsliV
	Bv/9gVa3As+lqCJsxXSsdP9B+ubvc/PL7+AerUScuHXjH1Z9yZSn6GJyj5s6aoL2
	ZsLimvbEmBq4tb2BsrjnOCr+2bQjZUHhvTBkXcnK8I6alEOOSFbYhcctjzv8zPjO
	+Q/ctVCORg1KQDwu86XeQ5vNwdDnq9s38mgXhQ/IlzeJxIpLq7UdSiOCk04Re4Zq
	8rD3YxBxZHoovz4GeLczqNJjKCUlKmpY/cu8+SVD6GhOhjJ+r01BAlY4xqIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793644540; x=1793730940; bh=cb+/pnODvjB2SkCr9x8H71b+AyJ+TD/0aBl
	PajNsS2I=; b=cVEF0ccvBNd2i6hfj3QmnOfDJ8vM9s9ochnkOyh/7AtSRVpTTD7
	O9Tb9Otc3EjnZZccJgLuJjMPjSXy4JIJohEGlF01EEy7nN8Hf4SVf27noPOi7EmM
	N5fAi1Q7mA00dU1FfzApLaBBbo2i7imXsD9CrNTWvKhHBMGefBSVTOQF2ec9hq/L
	/UjMyN0sPknAuKgoGrFKdjL0TjLTHCYIui7q/jvSghYpi5ZsmMI4KllJiG+YYycb
	jePDKrOQeFLW6YYEDZhLpOXgMbl993XwORy/xIlT6T5dLbtIgXjP8cOD9UcCcTw1
	MGdnE3LNU/Zbm51jOZI1NGU2y7Ir3F6n1Tw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793644540; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:hpzFakVqL1owtVk51ZX3h1ObFOwE7lH0kmHee+HNE3p7dBQ
	NpTXVg4DUnzvYv1LbqZ2buyKhcIoQ+4lHi4xNgJNDYIoY6GEK2hqoWQzb9dPajz1
	DlWc7CML8D1VQyRMpG+1uqAu6ZuJWGCoKHOKv6NDDjHnbaEH8UO1kRO7ezBIzZna
	u4i1/5X0uerC4AcLPx2rMU4BxwnPV7KMmriWCTV0ZLDOqC6ieX87q7KmyS5xR1pl
	HHFhosB1UTziubu0exhRFw/tkJXJM0dW+LGJj7fN7lBh5OXgXljHu2vu7Y3L8pIR
	p0pjSVrq0lFHt/Xs21yN1J4MKjJthIRBLHc1hpg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QJD19NZsBNPlTkjFkpZFk4EDxukrZzQDyHqE4bgU03Y=:sKNX0E8WF6Ip5v/LfGhim7xiWKSDplepR7TDuKpPWA0=;
X-ME-Sender: <xms:_NfoaompN3FT1xlXLkyBfhpkdUxvako3PsciyVR4q_m9QGGhd0_dfQ>
    <xme:_NfoausrfWrBCcmd0kZgRc1OJpL3mPVL2Q5YvaV9fXie0YNAxRYxEb14DVQpOFnje
    LEyM0SBKaUxfwD9LJmp_SkRyxRoLEgXFclR-0izAXGZw5c2AMWdkpk4>
X-ME-Received: <xmr:_Nfoau9nd7bpFAfm5Je5nMcQss-qZ7ttxIGP2KYlx4U9iwIWmY8rGnUV9enE-Op-RJB9tlxmcI9ja0kDT6B0CnQvcEmph3gQ8_ww>
X-ME-Proxy-Cause: dmFkZTFT43FhpukAkfpj9/GUjCRUTOoY2lR64CWCUj5LukJhL0GruRooxdKboyNqDGA13q
    rV0RBjc4M4RxjSkbK+zyXtkuPK2FF/aj0hzNT8iQ+A9+7T+cnh0f7OTg+luj5YsXfB3w8O
    fMoXiTENI1pNACFjR+jgKdIZBL3/ZnAXh13JdGrKSQo4NybqOe+vStS61OTSCZtinrpbIH
    WwpluGGdDaG/wM6gm6KrxTSZlj56fE7hEiKaTQR9BdtcnAT1h4yXpAXuOJSKBJ2dUgjOCs
    M5XyL+BjbsIoxr/hXZ7utdsh57D22Zmx5CVYp5Xz99ju/qfp7mJ2q7r606MahS1zq43Nl+
    KvSHZlu9mv0hu/ISeBhp449NEhX8r2LFsiBnvIsJjY6tsmEkNE3gZtk/uyIcltfKLozCWH
    dD4k3dDGQcOuSBm14HU6JapSJ+dUaTyIpWCCWZD683rEJ2PuVQ2lMeYmbtTzMVtPbPnrAM
    8Xjlxjz+GbjGQyNtSf6r3yUEppcIjnjoueP30ykmxs6z7GJR62GV0cHZeimTlZKWChGO5j
    UK/P756VYlMtO1gnSgV3QzdQ3wjhyxOBfqofM+rdnnt8UIehk+axTTxWjwvRxM9bzEHIM2
    rz+u1BiRvhrLD97MMSSEVfaejGFq6MqJH0soO3xzxr8syyvq3LzyXH9ByjkQ
X-ME-Proxy: <xmx:_NfoagMlLZD8_YH19xmjRHzufXSNs7M5Fx4nbrPC3nWO_aOuXifQpQ>
    <xmx:_NfoakExU-Ad0wELQcE3tVuYepmJw99fo_vYF-1sjOHbIVbGEZ_Icg>
    <xmx:_NfoamS4lAuSrLJvmdpcv4O7t-N2uwHT0uuVhJB5rxbUZqEIOlaaKw>
    <xmx:_NfoapuiZZYIMp2kjpzVQxFRIOPSPGw_55TuV9FeLzb-OTEJY8HEKg>
    <xmx:_NfoavctMmlZo7Dbe7s1G7pYIVQBOv_6tipz628ZJCs0CW_1I1GMRQMk>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 13:35:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow
 clone
In-Reply-To: <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
	(Harald Nordgren's message of "Mon, 2 Nov 2026 11:06:53 +0100")
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
	<pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
	<xmqqtslzlhbm.fsf@gitster.g>
	<CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
Date: Mon, 02 Nov 2026 10:35:38 -0800
Message-ID: <xmqqy0bbhyit.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> We unfortunately haven't seen many folks interested in this change.
>> Is anybody interested in reviewing the patch to give it a push?
>>
>> Unless we see some volunteers to give it a review in a few weeks, I
>> will discard the topic out of my tree, as 'seen' has been crowded
>> with topics that have been collecting dust without getting many
>> reviews.
>
> Is it possible that maybe the review process needs to change if too
> many things are getting stuck? Rather than discarding acceptable work.

If it were acceptable, it would have long been in 'next' and
'master', though.  One of the important criteria for being
acceptable is whether others find it a reasonable change to make to
the system, and I do not know of a way to show that other than by
positive reviews.

And that is why I pinged the thread again.
