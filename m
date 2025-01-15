Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF7C22E419
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 05:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736919983; cv=none; b=B2D5+OtXVqMzQwwRXNkPxcOK54SO0UddyGwO8GYZXaE6AAt4uPHvPZQZdz27nefqVERqCQs1cgNguJLI3bcOZXqOBJ2aa9Vu3JoJss7ZCwAgb49g100o+1Gf983qDpZO5yCnd4caPG8xgHwnrXt39TRuxyHBmpPir96Iu96HCHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736919983; c=relaxed/simple;
	bh=86vdsphsMeKfNwuZ3XmcriakvhC8yM3cnnqcC8JwTa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vCb57SGL7MtJXj3QHSUN6vchoNgD7alV16fRLDbzv3CrDr6d//FLS3Gr2mT9JRQZ2L2no+7+cCQGRQcCyYyS3JVXP7wb3OdyUolzKi26vp7SPYz3XAFDJLob38NcGpCpLEWx3voXpvHiagg7beuwLU0xFgs/xEiKZLmcNR81DJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DmuT1nPZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHbGSyc7; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DmuT1nPZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHbGSyc7"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D24D825401D4;
	Wed, 15 Jan 2025 00:46:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 15 Jan 2025 00:46:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736919980; x=1737006380; bh=1WSqvZs3s2
	FCgPZfjdaLjipSUNPJ+MFUA292O7H9HRQ=; b=DmuT1nPZDv7v0gHwfbEHoBGovc
	tJ0X4dy5QHhdFOXmMru2HH4l912jQxuWDfuEbLOrFOEQ/Vm8Kuf5nyHUH/QLLoTf
	F+x8hCAmiA2bqQSS/fYDUquOgw/waNk9Tt1Fo2r9z6vNyqbcgRunYtD3yyzc67WN
	/hUiifRsR5F39VTyRiSkAhDoDvJ67UBloJklrkWxeB2WmfUJpDciKnkiYcAxEeDX
	m/LFP1tj2xZHzon4O+eZ/IBjPnSd3N+wxIlsVdehbDhnaJo8ezMLF562gh8jlTlr
	OvBOhw4DEaYktzIK9Un5kNsBcoMnXo6YO0MuaSmCcz11bHyqRuEXB8Py5Z1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736919980; x=1737006380; bh=1WSqvZs3s2FCgPZfjdaLjipSUNPJ+MFUA29
	2O7H9HRQ=; b=lHbGSyc7Kl+NWfgxBXBwLI4FpBLZaH4GHYs69dhDTlMobjKUbIG
	bENFvZjQiS0+uoLtBERdTPmhqI9uBTxy9jmrIKJCOqmFxCGudzcf0lQk3tGlJSiA
	uENuBjaIKc9LYAwlT/j9QsJV9I/F+8khBfe5e8lTBb6Xwu2nMOtf3/gaTw8HowO+
	yxpR2ijMtiIphYKuCfpbOwPC3n0So4E94HK2ggk9bEny/fMOTUH2uo9RoeCGONIp
	ST8RPcrw6SXobenLb5kPb4rav2tlvi4G67V2OPlL/OS+05OZYmjzbMSGsYQ/n4/F
	bDk/lT3mlmhiAedO5/AdY7JXHcMBMTp5PeA==
X-ME-Sender: <xms:rEuHZ-Gl0wrm8zjsBn_7ar-XGvGhdz3qXlXQ7Ue5LW8nNMFzmVtUxQ>
    <xme:rEuHZ_XihxRtR4LDktMwjfPkyjXDv7ccsK0i_x6ZxI8WyNbHStp0tNaXRcKltmKT3
    QsseHojbbUERhefGQ>
X-ME-Received: <xmr:rEuHZ4IYAHuJkx2pQTfwS7MSdIIjwCbQtLg-aD5WuvCoTo86uaCLUkGSqbBwoMmGoys3jrqpwGOoCICOj2FIFRonLZgbg9fx29cN23chb69itr0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehjedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeejvedugefgff
    ffieegtefhgfeikeevfeefheevvdegieetgeeujeeliefhiedtueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomh
X-ME-Proxy: <xmx:rEuHZ4Gnyg39XOfi0MnF3N5YLsPDkTLbSjQpu79DMFKk5z6Ui3BbrQ>
    <xmx:rEuHZ0X89na07d6RH4CuhAWKm8ilqAPBn8JNZWeeMctSPdrEBM4jAQ>
    <xmx:rEuHZ7MDUnSJbAlohVoyUpxnmrmHYQAQVbHCKd80RFmASmlJ0WPw7w>
    <xmx:rEuHZ73230uct31rp1Xi2b47TC5ffQ4ldWZQpJWmU_Pdq5UUhA01yQ>
    <xmx:rEuHZ7QMZorh614b7MTlQjtXabU7CNFb7oZW9IRu5Y_xweDbpuNzEtO2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 00:46:19 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f78dea6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Jan 2025 05:46:18 +0000 (UTC)
Date: Wed, 15 Jan 2025 06:46:17 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
Message-ID: <Z4dLqaDItZ7xsQRS@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
 <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
 <xmqqjzax2nqw.fsf@gitster.g>
 <xmqqa5bt2jc8.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa5bt2jc8.fsf@gitster.g>

On Tue, Jan 14, 2025 at 01:09:43PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> Changes in v2:
> >>   - Wire up zlib-ng in our Makefile.
> >>   - Exercise zlib-ng via CI by adapting our "linux-musl" job to use
> >>     Meson and installing zlib-ng.
> >>   - Link to v1: https://lore.kernel.org/r/20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im
> >>
> >> The series is built on top of fbe8d3079d (Git 2.48, 2025-01-10) with
> >> ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide a summary of
> >> configured backends, 2024-12-30) merged into it.
> >
> > I think you are now also textually depending on the fuzzer thing due
> > to touching meson_options.txt and ci/run-build-and-tests.sh with a
> > later step.
> >
> >>  -:  ---------- >  9:  7ae8f413d4 ci: switch linux-musl to use Meson
> >>  -:  ---------- > 10:  2dd1b49e4f ci: make "linux-musl" job use zlib-ng
> >
> > I will see what other things I can find.
> 
> Yup.  The patch series for some reason still does not seem to apply
> cleanly ([09/10] ci/run-build-and-tests.sh somehow seems to be
> troublesome), but it was easy to wiggle it in when the base was
> prepared with these two topics merged on top of 'master':
> 
>     4610af08e7 ci: make "linux-musl" job use zlib-ng
>     b2ddd0b33e ci: switch linux-musl to use Meson
>     5118183ef4 compat/zlib: allow use of zlib-ng as backend
>     08bf6b2062 git-zlib: cast away potential constness of `next_in` pointer
>     ebf98412e3 compat/zlib: provide stubs for `deflateSetHeader()`
>     29829e5714 compat/zlib: provide `deflateBound()` shim centrally
>     8f19b26bbe git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
>     8aab230253 compat: introduce new "zlib.h" header
>     1ce001beaa git-compat-util: drop `z_const` define
>     b9d4bd5467 compat: drop `uncompress2()` compatibility shim
>     db620fad21 Merge branch 'ps/build-meson-fixes' into ps/zlib-ng
>     64156589d9 Merge branch 'ps/meson-weak-sha1-build' into ps/zlib-ng
> 
> I think the reason is because the other topic that touches the fuzz
> thing we see in the context of [09/10] is not ps/build-meson-fixes
> but something else that is before "--fatal-meson-warnings" was
> added.

Okay, I'll adapt the base accordingly for the next iterations. Thanks!

Patrick
