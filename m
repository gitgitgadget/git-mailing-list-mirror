Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506828;
	b=hpikBcPRB232v6dV4yv2CjxvEmKNVW4Gf+F1fsi/T2APQoKyJM4xBLCtMHsvcQw3NVEj
	 d1WjAfBtn9MENGlv0JQsECazAMLcwv0fbZxUSl0LWCdrO/ezz2oRCY5q3jlu+irtMPKMB
	 yEJBvGONj1iesNvaAW/AE46yPkc43hZza+/akyRFmQrK6bLu6F4uYJJlBbxyNwKiR8TI9
	 LKg2mowEzdVN/4fnqbl1gNfO7mEB1txh0JKnH89PrXVuCXWs/95nmmswbqqymjAFSrYGF
	 +YosCcUmunv9F3bqncrlSjekRT54lS+m4bFlwMLkPhiyKrP/ZZRl45zuOfgFJ2cNDIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506828;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2vjJdrGQe0dlq7X9v3IGQJcstY9I9zxGvxd3mOXBH+M=;
	b=Mq/D2XzRZ68eqROqCb66vqctYty0GTr3jkJjdccnoRIecfIRAxttvgagMzhP2ePebMom
	 OgZcQvXOcGMj02c4Rrk1AxDqCFh6RI+ru/BnOVUln2UTu9YBufgQpNilumiQPip6WMOg+
	 Fj2+QMd1Ib+VHMa/uoQrltZ5l5bwfRh45oyvPs4Zpq87uQrbEzFmvhrUN7zVqsY8EZrpP
	 J9YTvT19fFloeFAcbE/qlJfEATg3wfj61zA0snt+Al/a6SM9bWsoYcntfHsNAf1EudQ0H
	 /3CxxUjheygusYXvJymJ367V4jryRQpOZjWqRPY+tCd84DcB6pkWiAQdXXs/CmbxT1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fbUZksUr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=u2VwW85c;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3537D606A31B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 14:33:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3537D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fbUZksUr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=u2VwW85c
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8A5CF7A00C8
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 10:33:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 20 Oct 2026 10:33:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792506827; x=1792593227; bh=2vjJdrGQe0
	dlq7X9v3IGQJcstY9I9zxGvxd3mOXBH+M=; b=fbUZksUrkCdLeOrObNGQGR3EHP
	c+bOzJKaRK4pPk7CxJ2M8DUJgHSt8HiDLJFJvrUqptIavOKtA4TqwH7lsBZf305N
	TBWfPakGNE1sXxCwgc5xBGVghgDAKIRgOJvhU4XuhXB8+j4Ar8c1EwEOItWLO3ai
	pXmhyTgP0X/OUJVCDFLHMW8G5hcTI1t8BTUhE5b5hRgFPGif+hktOAAdprUVUgPm
	YDi9tgV3UyKQJm/1nMtV229WztA3D3uvi3bSmoK7QGzZNK2/Itd/Sj4KtEntAJVJ
	geBIYJ1q3kDMaJ+XMoiJ14tJ32LKnZdGwqb8l9oBCQutzkEcw2FYDv7/LonQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792506827; x=1792593227; bh=2vjJdrGQe0dlq7X9v3IGQJcstY9I9zxGvxd
	3mOXBH+M=; b=u2VwW85cxeEq4i1rSNKcOq5PuhAJaNoHdMx3ah7zzx80IHuCAM2
	aQHbeVt1fbC1XUDW+ao6EDfttsVmYDhckwFBDmIbF99l4Ww3UJ+T4q8h4CuBIOUk
	R4g41Su4NHjCd7i0KRd+YON5khoBqKAdPh+sHfym7TQ9oO+S1tWdbHbxxw7gjgkw
	kHg76cqBarJNjhiHOa89MuSbt8Xj/iZ8FSprVCCRDd+9MUUjppIWPjORAy861dsu
	OVFRxki02G/YsIUZ76OLkaLTmCckt6svtep5PevR0fgDeam07upyldel9Do5nLg2
	3DTJ1AU91WPC4aMiUXH6NlunzLw2eUtFhbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792506827; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BqWlJt1JCM/xh6gCwBdG8z8QK16EizEX6s+aLgXnBxPlz64
	94HaeiJigwfekz3Z//Zsg7QGlX0q4us2XsMZXC6+9UxnTVKpkx5puOre4x2J4Ta0
	BKxzX1g9gnVTOwSiSUMHf7SgDMhqNls0OPzXP0gumavZd+LBd5mA48/obNNcwjYo
	Se4Snx3Yh6/q0ZVx0gamaf6CdpVQaHMtmY5eQUofRFXf+iGIpiy5KbHGHwNSzs+T
	jiYd6s5pMLHbYBFcpe0mUuOIa8Qj0yFlWTIc/of2BOVroW1yWfCYbL62WLhg4Bee
	a7B3Zu5uFRSbCzC3nrTMLvsjCsvm06QvDHjJDkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:M57OkLBzHLDeHa7oqTNwm0HGpY+7VuPmpeO4EdfVqYA=:NukYOqbAsIstqKj3t5ynHDTe7MWRYa3u8jMa6NwrUdg=;
X-ME-Sender: <xms:y3vXakj7e14hGS2HhnEYR03CQU9dr6fOxGkQSU0U0Uy6UUCi0X_2ww>
    <xme:y3vXakelvmbLURSkdMp4y8TzhSIRVQP-izZmsgm3xjbILtRb9nPLtSb_rmpRWFWEG
    9uku-TD4oWM4EB6mh_F6Lq2SyGmtaVvFS8aPSpal1wx8Q8opZczOT3p>
X-ME-Received: <xmr:y3vXapcxnCudjcKyR1OvKEZIFFlK5kfhoWr0YMG7ChhDBGFRsOPw7K8d4p9IRLDqiaR8qQ>
X-ME-Proxy-Cause: dmFkZTEhySPt7G7Os3R5TjlFKGEUUDfgjPMy/QfokM+qMgGS/nmm86b1W+2eofir/EBs7O
    S1yHUgCol/qXN3uuVYLi3uMG0ZpMzYXFFI2kar+8XDsUcsHusPttVhoB0xcle0xpOGcuhm
    bY8yM6DScBtNcNXoq47NMycVQQbHma7H/9vAKznuVZIFUqZi6OAvtEahTxkkmk6Ku2NCHN
    qU/pCCFGLA+WUNy8eosqRRMDyVsAGtTD4Q8rj8GEjuIinp38Fb6v828ZUDl99DJjhGohHI
    HoB3X5IZpA0DQsjCh8B1KgxrLb/AxbzGXPghExb+vhB5pA/J0zDicyKbnKR30XstnOQqUR
    y/1XMfcVtqWlypvpSa4pKxInLBVS2FzL+AqfTQypq6Hd8jcoXAQrNKDEYolXMfPiTXHf6i
    M61d6kXlr4VKgtcqwKiYFymBurS6carhQgVm8ZzKM6X84x4LokOgIs8AudP45v1Ir7ZGdM
    vdu9Un1zyy0M072QMPQHxBAhP/mTmcAKuP/m43hA0202aOG+2uzBLiwsA/mQfFXey07lU0
    bfMaynThROD+APCjPidiTk3DSM2grslwgFlcAhZ3c8Ojj5LCozVmbV8jKqQv8TYnbSSpxp
    +K46CW8vBXzGSb0rnH9xdv+vK+5v0YH7vsxQhom6ps2nenZUDBhVyiB1Q5SA
X-ME-Proxy: <xmx:y3vXau9KDXgETcDcqRnoV8fxMvzCX8u6OhrovElD4Yq3N4HbtoD4OA>
    <xmx:y3vXalkdsc-qJ69ljhV-3gI96M2PISw9Aat7ibvRzjcMLNGrAkzVEA>
    <xmx:y3vXag_2ZNXXZRSPTsEF6D5Y25aI5jDtSZqXerjvUK_EhRG6YQrG4A>
    <xmx:y3vXajlItdZaW__Gz6F1Pv_VdgdlBtrmRkivkRIUSocsGFezPSy8Cw>
    <xmx:y3vXakoWHVfG3TULln-1tt12SeHhYGIJ6C7gI2MgFyIF0KSS2Aio0iK4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 10:33:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dddf09e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 14:33:45 +0000 (UTC)
Date: Tue, 20 Oct 2026 16:33:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] MyFirstContribution: move preparation of v2 after review
 discussion
Message-ID: <atd7xT6Vj59omtuN@pks.im>
References: <xmqqa4o94e0r.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa4o94e0r.fsf@gitster.g>

On Mon, Oct 19, 2026 at 01:43:48PM -0700, Junio C Hamano wrote:
> The text in the MyFirstContribution documentation tells readers how
> to send v1, how to send v2, and then how to respond to reviews, in
> this order.  It is unclear how much blame can be placed on this
> text, but it somehow seems that senior community members need to
> tell new contributors not to send updated interations of their

s/interations/iterations/

> patches before having any review discussion on the current iteration
> more often these days.
> 
> Here is an attempt to improve the text by moving "how to send v2"
> part much late in the text flow, after discussiong what should
> happen in the review discussion.
> 
> Strengthen the language about not sending the v2 out before engaging
> in the discussion from "It is a good manners to do so" to "Do not
> send v2 before you are done".

Nit: I think this would have been easier to review if you first moved
stuff around without changing the language yet and only then changing it
in a second commit. Like this it's basically impossible to see what was
moved and what needs reviewing.

> diff --git c/Documentation/MyFirstContribution.adoc w/Documentation/MyFirstContribution.adoc
> index 34bfa2e3a9..296ff97262 100644
> --- c/Documentation/MyFirstContribution.adoc
> +++ w/Documentation/MyFirstContribution.adoc
[snip]

Now comes the rewritten part, everything above was simply moved.

> +After a few days, you will hopefully receive a reply to your patchset
> +with some comments.
> +
> +

Nit: two newlines.

> +Try to understand the reviewers' points, and ask questions if you do
> +not understand what reviewers suggested.  Reviewers may also ask you
> +about what you wrote in the patchset, either in the proposed commit
> +log message or in the changes themselves.  You should answer these
> +questions in your response messages, but often the reason why
> +reviewers asked these questions to understand what you meant to write
> +is because your patchset needed clarification to be understood.  Make
> +a mental note that when you send an improved version of the patch,
> +make sure you explain your patch clearly enough so that the next
> +person do not have to ask the same question again.

s/do/does/

> +Try to find the best way to improve your patch they are commenting on
> +together.  Until you are done discussing the current round of reviews
> +with your reviewers, do not start coding, let alone sending the next
> +version of your patch.

This may be a bit broad, as quite often I find myself exploring ideas
before I can properly respond to review feedback. But maybe it's better
to be this pushy given the recent trend of people not responding at all.

> This way both you and your reviewers will save
> +time.  Reviewers can respond to your reasoning before you spend time
> +preparing a version they may not agree with, and later do not need to
> +inspect your v2 to figure out whether you implemented their comment or
> +not.
>  
>  If you are going to push back on a comment, be polite and explain why you feel
>  your original is better; be prepared that the reviewer may still disagree with
> @@ -1501,6 +1401,115 @@ changing history, but since it's local history which you haven't shared with
>  anyone, that is okay for now! (Later, it may not make sense to do this; take a
>  look at the section below this one for some context.)
>  
> +After review discussion concludes for the current iteration, you will
> +work on an improved version of your patch, and you will send the "v2".

Makes sense.

[snip]
> +Same as with the first version, you can use `b4 send` to send out the second
> +version. `b4` automatically bumps the version to `v2`, generates the range-diff
> +against the previous iteration, and threads the new series as a reply to the
> +cover letter of the first version.
> +
> +
> +
> +

This is a lot of empty lines here :)




Thanks!

Patrick
