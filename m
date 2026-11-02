Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613589;
	b=0oiQmJ1Xx0BrkzLHNtsefSdH2W4wUzXK+27YRMXh8Z+9vNzfE30vNGzb9O1l3N8Wg7FS
	 bRyQW4A2O8j92pVHyIsEAkfZCBB6Q/dDFR03H4xJJwR0A2epmiiLIXF5Hg7Sw0K+Ers7Q
	 Uti/7/uIif5M9VWA5s8XH7XlA0Oc9sgNgGHczf6+R+JkoST4QeE7N92DKL4dUTFNJLYSU
	 RINkKAyLk3dPdplSiMHgQkeACXp+yDtrZmngsuBnKC1ZgXSvrvo2yezhONKYfZhxKEzTP
	 5N6sFIFty0fOsJ/jbm7p6gW9ykHNDnVHqlcQ3EBZ1uwYJOYVbyXz0qSMU9cvjbSGCkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613589;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jNyq4d5kcQLKlj7YGgLTkN0cguzmkm579kl2hFqXgVM=;
	b=cLgBx3dr+DnCmhOrQyS/8LDhzzHsajyguxxQPZHh/96JKlLQ6a6ALUlrp7n3qImY917n
	 TFmuhNHYdvTtbju9VmpPF6NzezNIVMGuSSCnLXeoIUJfWHmpBOUGUr9nF9ACIvGLKq/fa
	 TYmCQppbuhyM17JN/0cusAkwZfpLNd7o08SqN+bZxHLNrhCWvLHp/o4iu9+qbJR5Ogesl
	 fuNYVn+oARmvSyxa0fqVLZgcWhrZiAmvFEJcg0Bv+p/6cflQbEpQw1w3FH8QW4nb1r1hR
	 wZ9jF0beipltLeFhrh5lDMjsxstoCwW+ANHCI7+oS6XW57T0/KC7EMZxcQt2kbg+D9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=jV9r+m6J;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="F/dUdqRy";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757B6606A32D
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757B6606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=jV9r+m6J;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=F/dUdqRy
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BA5E47A01D4
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:59:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 04:59:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793613588; x=1793699988; bh=jNyq4d5kcQ
	LKlj7YGgLTkN0cguzmkm579kl2hFqXgVM=; b=jV9r+m6JHVjreDzlffOLgGB37B
	HyO6CgLX+tYSaVAN3DcZfx1v0xLE2qV8WjqNdfYWlhD01S8pH1JP8V4qo+H6kYD+
	dkpOXD+k8AIbX2PtABjf24qzCpg7ejC8/vN/r1b3E8ohz0j6Ur/SEgzfAY00l+gh
	uTCxEQOaUZIDCQqoyM6Dvq92JtFc/tmIoJIpnLjX9USq4NMfGCHMgX/WZ/qEU6ep
	ceZKreiJhRTK5Nh4ENmS9yrioAYCIyrxLqZ7VdJMjBWOve95L0w3AE49cz9zpXSf
	m4cIP6zxF6RU2cTMVl1I0oZ0OfaNd+L1tn+37Dm426pqdPB22Qc3ET6ulUJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793613588; x=1793699988; bh=jNyq4d5kcQLKlj7YGgLTkN0cguzmkm579kl
	2hFqXgVM=; b=F/dUdqRyTtMOuNBmKJX02VdC9HP8M7XUANsoHrjJawmKeS1/ltx
	Csr3y9V5Ae4CnzMv+fmmWw4F9Bxr1MoZOe2gMP5Je67EEngSLFlBOcOMI4Cjxvqj
	M5uMuz1CsbXw2I3NrVnXCPsu6oDD8lXPqgTr30scEDkasBFIzqfniPryZrJEiiFP
	gIPngoWMO6lnbogLojoAFzsoAfdC5VzinRPXm3C9mUM2fA7yiRCr31TBy7c3a932
	cVJrlqJeN+bGQwrKLsFmQPOb2yHzHHXPhcrgsJ9PUITxlK+tOgVXNFI1Wq/W42pw
	JuTF1JB8NTRR1Pdi+uaqFPakPpoemGNPNQQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793613588; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:AXTfY9cjncBHhYvEHZj8gIIzDD26ubt5lISRvkgcyILIe6H
	wYjYs7lZcPrbznFi8NG0j031FTNtXKXv72YAwJx5awbBdvR+4o/xkj0lCTneV1Xu
	abdVEmV9B2eVDYPvKouzAplc224h3Hd88JBP6bU/uBWlYR/fCWwdqGRGnXYNtiVi
	wizKAH2sA0dkNu88UbdW6d7eup2KNdJlbb4wy0CNZhdMxOrBY72I2H1PVxDv1QZ1
	zKXlL0qYPRu7+kXcr+Y9Rb5FPxkP285TZlGY+KHwyn/kt8OQG1GWEU/3zU+Gcv8A
	Wcm2xgCgtEkmt/H6lDen7czR4kLHu4BjuBSmLag==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VRvHtUqounrbaIdEX1z02i5Xian694UPC7Ajz09ze1k=:rri4crjTBHR6u0LYYbN1vJUNINQL0snV06ikJhXoLSI=;
X-ME-Sender: <xms:FF_oam2Q_h_AXgGpNvf3tkbFBXae_93Jkb7aghnX3rfxOH0q23rYeA>
    <xme:FF_oaghkc7Fx7yiLTaYZ2bKJ8cw1zRpGevMQmOCenGdhwpPbxSig8mArRSSnsQvYd
    klLzR4S877_bN2U8SXydVp5WtJKj8J1F8JxqUVRRTVVKBwFMsDu>
X-ME-Received: <xmr:FF_oasTP3pWVYLxFIyGhj3BIcvJ_cA1N-DW2Xaoyfw-QjLe6mR5CBwWv6xG5eEchy94orA>
X-ME-Proxy-Cause: dmFkZTGdD+KkHXhUCe3R6sG2YrPfsLq9WccO/wjOtN5iRnKbAz/ZAZRj93yZxuWQD71NCN
    qcXYtjFdio0OxgtCMaglnM3hLbhRtnXOIxcC8G6O+204ux6z+MrWYJ5FUl4ocEX8EumEan
    o2fk00KBMPY+jQteDD3zFSoC1eUAFwhhmzc82vvGWjnffwmQ1zsmT9L9Sz2oQTx3i0/pMF
    RvckrNWa0gVE+9mllf85N1g5bkQYNPs2t9/v0jIDYS7WsRQX8Sd9+A1BmdXXqiDQA8gPMz
    x770Llu62STXv7W/snsCYkNbx6KaVizDPEP6bgbcVqYVhpSQsumrku3Hij+kLhRxJWald+
    QveBnDu0xswdXGBpXFg7BTHabzt/2TDGKXul2B99NoWlbXNbESEtDLrWTaaKnU5C3K1Fa6
    HaJc/IG7iPaxdVnywchxMDVONa0gdxofNkB0WDngWR0+4Xy4bfrA0pIDw1sc9OiXzT4myL
    XkQ4Xm9SmUT51bd9fgGSpiVeZgq6irgZwb79sDlKCZheaVOhrFDevhM0MVl3H3cNBkCezL
    thkumgeOncrmJTRv+hPVYGcoVOAQscVkIA5b2OWg2ZDM4WgCNxIPDBZVArz+/kBMQO2B6R
    RdHA4RrUD0x5CachMDkOtyL1a+uwss7ITKC3oETlzLRBmZk9sYuv3eAAk1zg
X-ME-Proxy: <xmx:FF_oahgSA2iDg1Krw_lTJBFXB8kgxSub1ZeYYL_XTd0SnF_KZwSbfQ>
    <xmx:FF_oas6_EfSf_XwdPkvvMc0nGNmJ0fBu0u7heYKBDuSU9bj5M7ezoA>
    <xmx:FF_oauA_W17U9WydXixgVa6cyEvsl2aRx8XfyeetUYpBBtEKmVi68A>
    <xmx:FF_oajZ8kLgKLtZAOD8s7vy2XzIAwBbFxTAwnj98YBBLdvzi4FFxxw>
    <xmx:FF_oakhoO5djtv86ocLBhUCb4GsYP3uDkI8PcPZwGQuIRAkvPK57z97C>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:59:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ffb5b7ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 09:59:46 +0000 (UTC)
Date: Mon, 2 Nov 2026 10:59:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: Ejecting things more aggressively out of 'seen'?
Message-ID: <auhfD1ryB-7JwOYl@pks.im>
References: <xmqqfr15ruw7.fsf@gitster.g>
 <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
 <xmqq1pclc210.fsf@gitster.g>
 <414ebe62-c7f6-4d44-bde2-b689e35accfc@gmail.com>
 <xmqqbjbpptzr.fsf@gitster.g>
 <47bd0302-fc52-4df0-98a0-6fad7eb0fb05@gmail.com>
 <xmqq1p93ofjx.fsf@gitster.g>
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
In-Reply-To: <xmqq1p93ofjx.fsf@gitster.g>

On Sun, Nov 01, 2026 at 11:31:14PM -0800, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > On 29/07/2026 18:48, Junio C Hamano wrote:
> >> 
> >> Perhaps the sensible thing for me to do is to stop taking any new
> >> topics into 'seen', even if I've spotted them, until I see somebody
> >> give them a real review.
> >> 
> >> Otherwise, it becomes too tempting for me to jump in, give them a
> >> superficial read after seeing them linger in the "What's Cooking"
> >> draft in the "Needs review" state for too long, and, believing I've
> >> seen enough, mark them for 'next'.  If I don't queue a patch that
> >> nobody seems to have read carefully, I won't succumb to such
> >> temptation.
> >
> > Maybe, though I do find having the patches in seen makes it easier to do 
> > an in-depth review as it means I don't have to apply them myself.
> 
> I have operated in "aggressively accept many things into 'seen'"
> mode for some time since this exchange.  We ended up with many
> "Needs review" topics, which nobody was interested in, sitting in
> 'seen' for weeks.  Having these and other topics in 'seen' may have
> helped other topics get reviewed, which might have been missed by
> you and others if they were not in my tree in a readily available
> form.  Thus, it is not entirely fair to declare this a failed
> experiment.
> 
> Still, we need to decide, and better yet, establish a policy on, how
> to deal with topics that remain unreviewed even after lingering in
> 'seen' for quite some time.
> 
> A mechanically applicable set of policies makes it easier to manage
> a large volume of topics.  Some of these are currently written down,
> while others may have been guessed by those who read a few "What's
> cooking" reports in a row:
> 
>  - A topic that has spent a week in 'next' graduates to 'master',
>    unless there is a strong reason to do otherwise.
> 
>  - A topic marked as "Will merge to 'next'" is merged 60 hours after
>    such a label is applied (in other words, people can stop me if
>    they act soon enough).

One state that confuses newcomers quite often is "Will merge to 'next'?"
with a question mark at the end. If we were to document these we shuld
probably also document that state.

>  - A topic goes into the "Waiting for response" state once reviewed,
>    where it remains until the author responds.  After staying in
>    this state for a month or so, it is demoted to the "Stalled"
>    state, and eventually dropped.
> 
> We should probably have a rule that says "a topic that did not get
> reviewed for N weeks is ejected from 'seen'".

I think that's reasonable. Becoming a bit more aggressive there doesn't
make too much of a difference anyway -- if a topic gets evicted from
"seen" and then later on regains interest then it can still be included
into "seen" again.

By gut feeling I'd use the same rule as for "Waiting for response".

Patrick
