Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792758628;
	b=iPt1G+TP7Bvv/Ra5CLzX6Y5G4Xhjc1ZCnobC16y9t0lLnsZ90c5lUftnUbuH01RvWQzA
	 qFe+MzXbVBxK7o7DouJRD6y0+sXAZSu49m5/VhdHRc3rzDAFFdkpgMaoTw/AU85hR4XXn
	 BXwbBkablTlnONiPCI6aNbzT1JWNiyOUGx10TC085rbB/YGjquDWy/cIqs8Vfhd/UNoqn
	 CthwIxz183cv8ZWhcm6Yc+4IhdxZUadLVO5DoOFyoez5ycjpkWHKcKrLMeOyDtWajKKbO
	 sw5SPmVnNvyErtYXyvFiUmB1A/9O+vPWsQangbQhsQtv5GDAnuUjH5g2fTVAiHKEFgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792758628;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GEeL2yEtKXg4olAD+GnDvIokOWZz5QsYmzn7BS1bV30=;
	b=gm3Uo3EFqhMzUv+7nl6yrRZKulrQ173wi7DyJrOQRr1CEbhQ8QwTO9uRQJgfsij2iVQI
	 mSfaGYzEjnrvalfcnX9YtPtJshZ2tAaAZGnavzL6OAyjf/0oLWdCcFtEOLL2pzTGyV/ky
	 Uoi8R58oClRlsWKQymdMZWhIId9UUK659OskznOxeG770BzLKS8YRkocIqLj9TVRVVbQN
	 oK79Nw914sVkiAYSKVgnVOEgPOnhkYkhe5xXIY32aBZpVtHW5KV77ntCFsgrST2afF5+T
	 w5DOON/HXMHf86XbuNZqpl/+hfqZO8mkqBQv+82zR5ANjvRTTIq/cT9VvYefMPjdIKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VidFiToh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZaGFxzXA;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADE5606A320
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ADE5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VidFiToh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZaGFxzXA
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C39B1D00212
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:30:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 08:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792758627; x=1792845027; bh=GEeL2yEtKX
	g4olAD+GnDvIokOWZz5QsYmzn7BS1bV30=; b=VidFiTohv/f0kI8NuqEfun5dfc
	zROy/p6RaB2F2QE69oCd/H9k65ROd2VWxqAfIDBtGE124WTd5BcbjBYMlFcWpznG
	6lKP/K874s481ot7GcUOsQnli6i4/WML/T0X3r167DaKEkUhLoY2Sn+cVrVjKYtK
	DH2XwOOPULn3mpuTVlF1z13VZmpY4GaSMJxYU5tGcn7cL6RNkHqKbJQeY/8hucjW
	RFicppTmeUwGoREANdm6Jb/ior+1W8yNTxZbyc1QK4hrdlmI4xvYGxP6jh9dbRk+
	9A8pLj6MMx/U0sX3pJisCxucrg2EtgkkKOs6g0YRN7Boe0aXTowTUTrL1uEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792758627; x=1792845027; bh=GEeL2yEtKXg4olAD+GnDvIokOWZz5QsYmzn
	7BS1bV30=; b=ZaGFxzXAWq2w9s7ca4MV7LcVTuC014qF3ceS1jO3Oc0KsS+R9sW
	paisbcde0ViL6Esp8grVXPR2u4mSfkhax4Ly960CqS4nd9g4slBnnmMMbJOtR9MA
	nLxinBUejcjzPtECfH2pB9jzXj/NYjJzDoPIGxg56I2d5g7OmhoXQ3CNI68Lr8YA
	0tb34kDmror2wVYmPSTP84q6E0DsTj95kKIox1+IVNPioYYHpMSu40jPOspddAUT
	8vRNrkFlCtMVe/EfSvjq8lFrFH41hwjJGUzK7gMF/EiMJ1czueFbSKmUvn/mPuh1
	osQ/lptOoQQH52TpF3jH/LHB45aXE/ix+Fg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792758627; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UG5ViNKWET403pRyxuKmb/q0W7H1K8orBXywSp6MN23Sev6
	RrcjdJ9BCfmU1snrSMJwy1oKTnGtwBtr9RieaRksgPh6cmMGz3ILBCdFexruGze+
	DfDjoubxRxnF+ZqNKQLVYoYKnMElnazfsMxPDiJayRlKHgT3dNcFd/szP01KgbtG
	XqXC9iXzvVXzsPHDuWiYJmMti5LtQJ6TePGb+23mnGkgk22IwZYzMgeoVkEbfdb1
	8hL/05WiCEAVpieXVlLJNdlJWKCxriW+a6ABXVullYjPhwJTExTwBRq4TsEpakDW
	t9fUGHhUsGXPGokikfgd1QNn0J3LwNPtd8ZfBMA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:9mibtwWt05wwzgbdt5YAGEzrBRO1qIap560TiFGeRzo=:lHKFn1RDI8K/JxwRvDxyFhVSpN7G2k98BsigEz0OXg4=;
X-ME-Sender: <xms:Y1PbainevMVbY5MAxwCQtgsirj_FGw183nADwLhez80OAc7Ju_v6fg>
    <xme:Y1Pbav0MYxXZvZ2XNcAZcZgbcjsUmhjCsncxVBQlQbqM9rPclFVTx-k2r9Wl6JfEV
    6_PVFtitYjxYPQMYCHBa6k3jTExtj1H_XIeQgRcW408ao-OvdXq>
X-ME-Received: <xmr:Y1PbauTLXKzbM6kiKccbFqMU5JdSqg8q5Ee1nwVpro8Z2xwGgNtr1MucNZeZANZH3fl_oQ>
X-ME-Proxy-Cause: dmFkZTFylThyd5lCxdNrZVp8QhDvP3h3JONBT1NI2+G9iufXoUrycp/DCL+12U2UTeljzs
    s8UNnk/Smr1GJlumilNCM57prJxQmX+vSafjPstENwEQcQETcsP92KxuEe6RyHYF5A33vx
    f9B+Gcg2Bu50pDyn/FpRgD5Gymfc+GUpXa61g4Lsy6AOwaXc9A1O3rmKruqphcFuC9BySv
    PpJ1kDjRPypBGsDASrg2aEbx8h1eG6fmvn4E8XEnYMx1h5ZX3tWV11zyzuJ8UIIdpXQg8l
    NOHA6Z0q4B70EviMQAvShxW7SgTA2EoZKiEmRJMikeflRoeDSFHMhESEYtwCHjwE94Pvo9
    /rNzK+A0281ib3794FxBzy37APj7bqz7OylzbY9Oa3FYFpeSegRCZFnBjbWv2x5hMZZX53
    rdktiDj58Cro/SLVFqR2wXMDd3CXIBVpXNGfVKH/QuJ3ypRCt8OY0BRZfHD2dnMFZOk1Rj
    3M+4IHSv1Gy0qsrK3qpGuULB8SdkAg9rZQqtXlJrievYdwtC7GrMA41vsoQ53SUxdn5YJq
    rklK7JzKut4WF5CvCXz5edvQ5Kiv2hJZK0Mz4rR48wS1AiMTVtItGAH8vPZ67oA8/7tjLN
    nGYsJ4gY+qAdLUFRzbAdUETPesAoLJ/u33aKhtR+2UfRGV+yBh8uqpS++E0A
X-ME-Proxy: <xmx:Y1Pbahvxu5jp2v0ZF9pWR-8kzrO6vhZi0lkEnqXpku_JHx9WrwhMDQ>
    <xmx:Y1PbajZoTnvPSHaUPL3YgW5oAmz2KNw21EcUZJBxieXvDdwS3LQurA>
    <xmx:Y1PbamvOYnVIfOTQDkxEXgtxKpfkRHBK9nVT8BObcA9DGFJv0zGryg>
    <xmx:Y1PbalG4vrAB1JA15yqtNsqdg-WLWU7bT06XV3MEtaLN-Rduk1BA1Q>
    <xmx:Y1Pbat800RHDC19XSjDEXviCIX01PwDwg5BjXxYe5ba-g-BVtB3x-V70>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:30:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70a1724f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:30:25 +0000 (UTC)
Date: Fri, 23 Oct 2026 14:30:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 0/2] MyFirstContribution: discuss then reroll
Message-ID: <attTXu2sSy93_wyq@pks.im>
References: <xmqqa4o94e0r.fsf@gitster.g>
 <20261022211404.380904-1-gitster@pobox.com>
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
In-Reply-To: <20261022211404.380904-1-gitster@pobox.com>

On Thu, Oct 22, 2026 at 02:14:02PM -0700, Junio C Hamano wrote:
> The MyFirstContribution document tells readers how to send v1, how
> to send v2, and then how to respond to reviews, in that order.  It
> uses a fairly weak language "it is a good manners to ..." to respond
> to reviews before rerolling.
> 
> On the mailing list, we find ourselves more and more frequently
> having to tell new contributors not to send updated iterations of
> their patches before having any review discussion on the current
> iteration.
> 
> Here is an attempt to rectify the situation.
> 
> The first patch reorders the sections to explain how to send v1, how
> to respond to reviews, before explaining how to send v2.
> 
> The second patch rewrites the "how to respond to reviews" section to
> strengthen the "it is a good manners" by replacing it with "do not
> send v2 before you have finished discussing v1".
> 
> Relative to v3, this rewrites the "responding to reviews" section
> more tightly, shaving about 1/5 words, without losing substance.

Is this me or is there no v3? I cannot find it online, either.

> Range-diff against v3:
> 1:  e6f4a2a7ca = 1:  9db8ec4b98 MyFirstContribution: move "how to send v2" after discussing reviews
> 2:  27f47d7d65 ! 2:  88abda272c MyFirstContribution: clarify that "reviewing" is a discussion
>     @@ Commit message
>          section largely duplicates the discussion on what to do after
>          getting a review, which is covered in the subsequent section.  Also,
>          the "Reviewing" section does not make it clear from the beginning
>     -    that reviewing is a process of discussion with your reviewers to design
>     -    what the next iteration should look like.
>     +    that reviewing is a process of discussion with your reviewers.
>      
>          Rewrite the "Reviewing" section with stronger language to discourage
>          sending a 'v2' iteration before working together with the reviewers
>     @@ Documentation/MyFirstContribution.adoc: previous one" patches over 2 days), revi
>      -reviewers' questions may be useful thing to use.  Your goal is to make
>      -your v2 clear enough so that it becomes unnecessary for you to give the
>      -same explanation to the next person who reads it.
>     -+After a few days, you will hopefully receive a reply to your patch
>     -+series with some comments.  Carefully read them to understand the
>     -+reviewers' perspective.  Do not hesitate to ask for clarification if
>     -+you do not understand their suggestions.
>     ++After a few days, you may receive comments on your patch series.
>     ++Carefully read them to understand the reviewers' perspective, and do
>     ++not hesitate to ask for clarification.

This overall includes way more changes than expected relative to v2, but
I don't mind condensing our docs a bit.

>     -+Reviewers may also ask about what you wrote in the patch series,
>     -+either in the proposed commit log message or in the changes
>     -+themselves.  Answer these questions in your response.  Often,
>     -+reviewers ask because your patch series needs clarification to be
>     -+understood; use this as feedback to improve the clarity of your
>     -+writing.  When answering, remember to update the patch itself so that
>     -+the next reader will not need to ask the same question.
>     ++Reviewers may also ask about your proposed commit log or the changes.
>     ++Answer these in your response.  They often ask because the patch needs
>     ++clarification; use this feedback to improve your writing, and update
>     ++the patch so the next reader does not have to ask the same question.
>      +
>     -+Do not start coding, let alone send the next version of your patch,
>     -+until you have finished discussing the current one so both sides know
>     -+what to expect.  This saves time for everyone.  Reviewers can respond
>     -+to your explanation before you spend time preparing a patch they might
>     -+reject, and they will not have to inspect 'v2' only to find their
>     ++Do not start coding, much less send the next version, until you finish
>     ++discussing the current one and both sides know what to expect.  This
>     ++saves time, lets reviewers respond before you write a patch they have
>     ++to reject, and avoids forcing them to inspect 'v2' only to find their
>      +concerns unaddressed.

This is the new version that we've discussed.

Patrick
