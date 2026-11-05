Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902361;
	b=I24t+TUM8755aCHe6mm7qG3OSY0e3Fj2IRDm8AbaYa9/zrliY6tHI7SBr7clOSS68K+w
	 J+pFri+BHP19QdUuhS9JhMdYWKkSO8O3MYwqGrO97tbch1CujlVi6FcF+cGKUop6m2CnD
	 CvCmTTIIyElOQybuIlWxDQjw2XAyqHMExxSTW764spYvjC+NSMeLvymDUrQ/iGTc6djw+
	 8tPm0GIya3xu7lCBil8igJCbCXxKlCUEUa6qXlMnpMHZOMmQegbmyXPIe5auiAcx4FMSG
	 vJPjnFISQonDMzHNAMeGQe0rV9GTrBGaWLg9c/KuSi8IqxJb4Ja2cEfSKtS1Jawt7rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902361;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Y2BtXLeupHPAYFWqhBJnimf5i4+sXaUHbAUKrrmbU7Q=;
	b=GMUhpvQFcdoJaGgzGYzlUKawZ75G6tAO6+nx/34tZ8OrQ/AeDEVbLstsVkTkugInW4Bq
	 T+clUXM3X0eGeOvC+ImHvYcJ1DL0e5ymAVv+Ry7iDEIQTNORf4iLmwe3UOkueSYdUwhXK
	 vcs0CBp3cayRPJhAh1X0w2huBEGGMrXaEyIv8uH//a1MZC/NSDN7/gX2+XbHgRJPDsI1G
	 GQwLDBTGFVBUM0tgIbfwlqWxz8bCt8oNVTeDBl7gUlJlXetjCETDr2uYbRSm8YDaIH9mt
	 fBG0zIbBfYRtZzUN7Zj8L93zTgaFlag29FmH7/L85wUDub8glFd+o1UV4WhLcl4iyYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z7SqA2tf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JtuQrNtU;
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A493B606A328
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:12:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A493B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=Z7SqA2tf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=JtuQrNtU
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D6E4814000B8
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 13:12:39 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 13:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793902359; x=1793988759; bh=Y2BtXLeupH
	PAYFWqhBJnimf5i4+sXaUHbAUKrrmbU7Q=; b=Z7SqA2tfDdRv3iu+1vxPSCF+nB
	cQjP/S1rltHnAmc7DqdHP4jCKL9bqxHRGjL98CrYbStvGISvIKdGXCRc7LerZ8CA
	s1l0huTXTkyhIL7GZFPlIGWpfntY4TTSP1mL9qCoaFrfzK13ogUdk8MC2/vMR9RS
	9rSXFOncGj6e+bDXDVFxLWoqscnT6jFGC+xxxFAleqVuwDKZs6iCENuqjMVxN+Hp
	GFIPYv7DH9HCrk1wbKZlBc8xZYyDU+k96/FkLCL4LV2WVPuzevTgVeHZj/IiRfgc
	nNaIwergnu2d9vo8rWUzE0ptoppp0eXWPKjoJ+hlhcBxED8buP194SpTDSbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793902359; x=1793988759; bh=Y2BtXLeupHPAYFWqhBJnimf5i4+sXaUHbAU
	KrrmbU7Q=; b=JtuQrNtUozbkObxl7Itf36yJgvYeRdosgnJndBbfsulPcdubnTP
	k24jsbk6ZP4QCZ9sGrNSCeHM3UE0tF/wo37xLYG4Um6uyn4A4lYLygcoOPU39zb8
	GBOft6q+CxDicRzK7FqRVUYqvjzcekcMwASIOgAnu5BoC1rjmmGoZelZnK1k1BPm
	3JDJhJy81OMBSltmTA7rjsIeGa5bXr1HYzyBaODCQMnwplnCso7+txtc1tXjtslg
	fuLYfqQ+ttE7a9I1EXq898g++im4zmavp1V9ndFFe6dGE2Vtz+9EslfwY9h07q8I
	i0NyLlEp/kj+rfp7gWJERybttzfUWxWkx8A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793902359; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NdJwDs47a1wx+XmN9WR2r2nN+wJAsNwurVQr44ezSy6gPzS
	TBzk9Vuo7iaeLg2YmgnR3symzv2DTSvhF4VpKpfpEjNtmYQKWgM3pnEcF/HBgU68
	PDgX5Sd4RcViOs5mDDl5uwTLY3K5v+q2mUD+rFigK3bt+HBdEGx6o032til31Fv6
	YAEZQzbYD0JJi009or8dBGQ4RJfmpGhQj/twfwtyeNdQe8fNSfeRUndYhiWi9pKB
	PkY3hlJWAbdeWNp0VvElVYqzm2oi0KYqo2ugcO+/P8gpRsKx4oSPKqpkbZfXue+u
	rxod2W5kvY6Ssljx/rVN3f/xG4X31OoQh4d/quQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zBoVBP4v0+yRvZz29Q6btiA04Rfl5h3vrjFPSgaro80=:D6mk14kJhMvyC+dEvikp7p7Jh/GwMxiobbaly++LDTA=;
X-ME-Sender: <xms:F8fsajwikJrGc1FZmVXsL1BP7dWOOqw9sa3gzqMDTmPH8r4YpDfpEg>
    <xme:F8fsaitzQpc0ul_sK8rvI3b6cGaEGGA5RT9JzbP-u0jyhsXAiuMiCcyumrDrrAu3T
    bWSJVSC21ZB_Rc3OXwBSqoZzysn3hjhaKyiCP_kyrqhbqH5ZI3NV3g>
X-ME-Received: <xmr:F8fsaquz5cQFSdLnYgOMam86suMhp4l8OIlGsfMxxCKsrS-gWz72QcqxDw6MYnTkb8RQ4lNXJ3Vbj-IphqEaKI9G9LuVDdmNIyAs>
X-ME-Proxy-Cause: dmFkZTGG/IjsCCQDcmZoikbk/LC6OWacvQ2sH4UB8rz+JOO7erhPwc9C0KHK4d0VZ0UAhb
    4QpIVxRbm/Q4n6yBQKfoXEeoDa6DnL1cE8Bipmxe5WSR3l7YlshL1jcruJVqHwsqlh45zv
    wTmpafuI8LR/fWJBFshd/C46zRhMBXmxh9iWJng0z2Z4T2mXkgWEVg/snTTdzmX9fCz2H2
    XWlZQMY0zCVd/x4BIXtxSmu+xjLydXueMLZ4eElPWA79mA3dpPGmNXjvRB7nKEuJhC+JfX
    WYnt528fpjggQCBhYWSdzTmWV29sqxTi6kp1T15uk7REVPPAFIbysWkYiadGhGVEcHcOen
    J/b0uNWmj3+IFL2lmf/ZOxRClawvXusM6arfeH21MkiRsVBB5MXmhjrI7pte9cy53HMOQL
    tUBL0BXYTqDygjG5WMVRtnm9kqtIATwhcRN2BB9oVVfnM9wu9ndUUDJzpyfhEymVVQkZlG
    or32WapP9OALCu7DZ3Uc9pZwgR3GQ1Yvx44mNeWfenFreAdUWYiab2agD57XY+V90nbWZ5
    bCrgb+GeJr0V896mfWpc0em5Kmlrvd9Ub6eKGHwahbgHvKSmsg5JL+2qfuY0LpgByylVJM
    Dldaq/5uuWUJhYDR8rsMUP2paMtfc9FIZsNwfepsDqJfd1pyBgxiBsoh7STQ
X-ME-Proxy: <xmx:F8fsanOlpwllTZ57OA_fNQe3kQ2OLtflzQ73agIiYJwWDzIWB1ubQw>
    <xmx:F8fsao0_bGXuhXGFhMzRe3V_vKcS8o8pkUvxSfLkTD14XcujQBasBg>
    <xmx:F8fsajM-vVZNzXs6ql91iCO_lAVcjCZyMNCuANyyzoe54rdTtz0Dfg>
    <xmx:F8fsao1XTPM9qyNku9FjlQlXdGWIu-m8QbMJxr5SaDMWPkcQ56RYeQ>
    <xmx:F8fsaq3ShZo4P4YqOBWnZH9cAnAk6lXNzkA8MBQ6AdZyLJoNq4jHeORl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 13:12:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] config: honor file permission bits
In-Reply-To: <auyEPBEDUziv4w8u@pks.im> (Patrick Steinhardt's message of "Thu,
	5 Nov 2026 14:27:24 +0100")
References: <xmqqbj8p7okv.fsf@gitster.g> <xmqqa4o0v76o.fsf@gitster.g>
	<aum4pZp5P0ZRC-cf@pks.im> <xmqqld797msp.fsf@gitster.g>
	<auyEPBEDUziv4w8u@pks.im>
Date: Thu, 05 Nov 2026 10:12:37 -0800
Message-ID: <xmqqwlqruoyy.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

> I don't think the other messages would need to be adapted. We already
> have a mixture of both styles in this files, so I'd prefer to at least
> not make the status quo worse by adding more instances that we know to
> be suboptimal.
>
> In any case, these are just nits and I don't feel strongly about any of
> them.

I scanned the entire file and got the impression that majority of
the messages were without quotes.  While I agree with you that
should be fixed, the patch followed that majority.

You are welcome to direct somebody else to go in and fix all of
them, but I do not want to see you doing so yourself, as your time
and productivity are more valuable elsewhere ;-)


