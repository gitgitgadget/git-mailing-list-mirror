Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C14738BF6A
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 04:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787115156; cv=none; b=txoAymCI/x/ItSvE4iYt2PDyCbxBm9ZBhhzZl+Rv+2to40iwFkbN62U3bKzr7nUwvXAHxKZZdPZGJsV7F2IsWAWBv1Prz/RZDIiz68JK9ZXlvWJe++3mknMhITF638Vf2gaDTPyA55DFkeeObS5qr3WB1dpsTPHkh2jJ2aV0eCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787115156; c=relaxed/simple;
	bh=ucdo2AagWuH8Pgsy02WU/LKfsb5ILmaWHJ5NISLnj1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s28RFVmBVNs3eKGErdxayKS2hSaGsErb5xCHPsH4yJZfOcmwu5euIq4FjgZcTWLuAQmPgrUftLsKC62FwxqUOnsRzlFy+MwmazX1kXR9yXiFVhqsmmfUuOarZLM2CfcaQRaorBuK1C/z/kGz6AwMjmT1mi7xDGvjc9WbRMCQ4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F2bgYCUM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WbFyq6Fq; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F2bgYCUM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WbFyq6Fq"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CBFDA1D00075;
	Wed, 19 Aug 2026 00:52:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 19 Aug 2026 00:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787115152; x=1787201552; bh=Ktkjv9e+9h
	V0s+/eIH/L2hH13URpXvaQ7okHXhRkdJc=; b=F2bgYCUMzi8sSr4UecfRZjYHIQ
	4K9dU6dHGNBWq7M52oDleu2px7uZq2ZEjfWoz8f2Nvti+oVo4sTwuJFmhOEFJC52
	d1wjuder5wbxpaiC2qLY6MwwZ7VvqDlgyW0u2SJxlPJGGX7IYVfUClHbaDfZ7t3V
	wO3mRXrKZAgPv58V20y/UMb1txm+P9FG2gKUsSDQ8KrMx7KOGF5VduoTsa0EZ91D
	rQKYh03D+pPD1wTldHhllMs5B6GGb8g8/sIIt/L/mv15Kx6HggVq1QB2zU26ihyR
	dBsag3UjgvjZlsC5egkQQ583nt3O03JCunHhLHZb9m4C0NkA9CvY/z7iN5HQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787115152; x=1787201552; bh=Ktkjv9e+9hV0s+/eIH/L2hH13URpXvaQ7ok
	HXhRkdJc=; b=WbFyq6FqalfY3KAri1YKMiSg9RUxgj2Hb7yS6MuTrfzogneW4J6
	0pjTDgq/pGGwaI2eNZaUP2H2QkP43oIeYpkgvdc73wyBkJxNn0NmPTqGtqpw9ARc
	k1XLk8niy0XhXVbZI716Go6ex78wfTgwEex6aAun125T1pkAImlvxXgEov1w8YTO
	ET/EvKPKDhlImpT+0aGlar6hKRXsXzdMANeHbs3ogpsm+zHkA24OZvVhx476ctOe
	smPMJlQqALnuG9oBk3PqMB9Sne1ZHU72YxF5VO7duZc0i1RxSwlOiW08yBnkAJD8
	tyibDij0Csw81krNx5jiBMJZFYmtE3+9SWA==
X-ME-Sender: <xms:jzaFavRlONPJzTyK2TixFeHbt4pKXXTmMPZ_11URaLxlTFbY9cpa6A>
    <xme:jzaFaoOYXuFLrLF_vmlb2TymleBlPSuTEpuG_s3zBmBFqeWD5Cj4xPI6w9Gj-eBYJ
    rrUedxT3ElTnTvNU7t0JT6C299wcXoUawjY3LHHd0HxPzK2dlRi-A>
X-ME-Received: <xmr:jzaFaiOqjlkQAJH7lYWMY_uJtrTvKmB3WZlXoKEEC_5LzJ4k1cs0_5T9vHc6_yJDZSFvqe0thgZI7u480s2B_oA6rNkJVRQzN348FdQR>
X-ME-Proxy-Cause: dmFkZTF1iUKXFusF3JuM5xkN1tJpgMYmO79Ms2DPMeOlhi9kpwI1/GrOahm/6luDqkAHwb
    mya2vFria3nSN5pfiQKTo3F3dgFlVq3160V8H5gSz85KwOjGWHwFQamULQNTjnACMxcyOS
    DmwNsj5aiCoDZarxOGhxrmnTKfyCt9ujX7MVmP2fo7tzOo7zG8DptHlzsYmHhvvXjgjE/8
    2e1x+cvq25qzEgzNtuJoLTDrKQFJ4BzE70IorVk+Djlyo70LYFrCBNbQsheyq4OP48pBKF
    6pequVlgx3VZBpgmFL2JilvkFtg3USm2fSAE+edEWehQLYCpaE6tCdyJJvdoqfPh2X4TmL
    xjztShGF7oZNoDcmsOQu7280OwpWDkzvD6nPhzSZ0kGKclhZmsikBszESLpbE+G83VRAaa
    yOKyI045meXAemTIZxbHAzBzoOlbeu3k0pazibr7v5n2Dq7AiGt+iOLPshXdOdibZ33JYG
    a7CLvju+phT8xDp0ToNerIxU2P6C5Axr6O0uognMV98YcA5nhDIQJ1ZPrDQm+Y4zccwPsM
    9/Mxs6qPpk5YA1JaofybkYNEUzkeicd5tI4Zwqs/RUJzUhWJ6l2x0PQJy6owI51SsYAuhy
    YMZNIiupZGZUzxQsWcIDdNiNYDz4UR4wy8PJh9HvwqRTjJ+aSNGb0dB1OkrA
X-ME-Proxy: <xmx:jzaFaotmqGlSM-nYqS_Nu0N6ajMjNYD-7V_F88rRTTeuDEBTyDox7Q>
    <xmx:jzaFasUGWsUWOPlx80KxeoqNCEBeaMve7Sm0i4HAXNjh7LQAEX-XUw>
    <xmx:jzaFagthlwd4UJzsyN1nHuEjlEc1VDNY98PAAOxG1y0i6GxcvE8GAw>
    <xmx:jzaFaoU9m6r4JOX0zR2zAolqqFQ88RCudjmf-wiHANSUlviIISAuog>
    <xmx:kDaFal4MsqNiiODXmViIYk_YE2cu89ogxVfLqv4ANldKzACKg11w7k1P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Aug 2026 00:52:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f59e65af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Aug 2026 04:52:28 +0000 (UTC)
Date: Wed, 19 Aug 2026 06:52:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Stefan Haller <lists@haller-berlin.de>
Subject: Re: [PATCH] odb/files: be less aggressive with geometric repacking
Message-ID: <aoU2iTmskL788erN@pks.im>
References: <20260811-pks-geometric-maintenance-reduce-frequency-v1-1-7a54c42355ac@pks.im>
 <anuFzZluJEU21MB0@denethor>
 <anwIRuuaYG3AgG1m@pks.im>
 <aoTcxJSmKWNhnjZ9@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoTcxJSmKWNhnjZ9@denethor>

On Tue, Aug 18, 2026 at 05:34:54PM -0500, Justin Tobler wrote:
> On 26/08/12 07:44AM, Patrick Steinhardt wrote:
> > On Tue, Aug 11, 2026 at 03:44:12PM -0500, Justin Tobler wrote:
> > > Increasing the loose object threshold here to be more conservative seems
> > > like a reasonable approach. I'm not sure exactly why 6700 was chosen
> > > here. 6700 / 256 ~= 26.2 which means "objects/17/" would have to contain
> > > at least 27 objects before repacking is triggered. That is certainly
> > > much more conservative. I see that 6700 has also been chosen else where
> > > in the codebase as the threshold too. It might be nice to explain the
> > > reasoning a bit more in the commit message though.
> > 
> > Hmm, don't I already do that? In the paragraph you're responding to I'm
> > saying that git-gc(1) already had that default forever, so I'm adjusting
> > our heuristic to match that.
> 
> I think I was just curious as to why 6700 was the chosen number for
> git-gc(1) as well, but its probably just good to be consistent here. I
> think this patch is fine as is.

That's a good question. It has been introduced all the way back in
2c3c439947 (Implement git gc --auto, 2007-09-05), but that commit does
not mention any reasoning for the 6700 limit either.

Digging in history a bit surfaces this nugget [1]. So the limit was
chosen so that git-gc(1) would not trigger for a fully unpacked Git
v0.99, would trigger for v1.0, but not triggering when doing an
incremental gc after going from v0.99 to v1.0. This is of course quite
arbitrary, but as the mail points out, "[t]he default threshold is
arbitrarily set by yours truly" (Junio).

Patrick

[1]: https://lore.kernel.org/git/7vr6lcj2zi.fsf@gitster.siamese.dyndns.org/
