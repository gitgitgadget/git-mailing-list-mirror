Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5186BB5B
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369370; cv=none; b=noGg4vBTrBzY5KZaVRKkOz+cvHoSRZq9xqdqA7MqGR1VNbcAP6NzTs/CuviHSaR+WoulYoAs1YHfEXMUKnqlhd8Yq2MC3WGI4GijapmBvCD0acokxBLv9ix3+7dAow7uKeW5OiRPf9GgqiDiEjRgcdH8jCX5VH/ePyWglMpaRJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369370; c=relaxed/simple;
	bh=8bm5ow/opiBFtFRtP2Q/TS4qERKTRkQgZiGOtpdeQdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkN3SvceBfKJJ8bFlFUD34J1//KnA7kHSHJSCRPEhOML7oTfehmBWgoAUNZJH9DXUf7IsJ4F/yTnGfXDcuFK1R3wt7CeifH6H2f7o6KuSrm2LYAydODIyGIk489z9lbl7fq90x5ZY9HZbvLbB8lCbLro8l90IvBxzf8BtARSoGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FG+hLCIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iHnQno6C; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FG+hLCIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iHnQno6C"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09F677A0119;
	Thu, 25 Jun 2026 02:36:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 25 Jun 2026 02:36:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782369368; x=1782455768; bh=KMtAR+E505
	GUoC07qg8A06oD2wgNIqG9R5jbt4I9554=; b=FG+hLCIBPIAmnf5S9M3ZH2N+bG
	8pUAmeVeccYjRRTHtcNKExra4sbzXUXeIRfko+ZXCD15a3IxfeY+QlAjjntjsv27
	gBz/hBi+ql6IxDsmGtFSAi16ap60iqxA7Rn3KuXIvKLtXBKsZs3cP7yjC88W91kg
	6KV99NeVs+HNJ48eTPa3x2f6eh/IOlm2rJ35H9xVsg3/BvSdwVlS3gEq3p4jQUkn
	rdXlcnOtwRCFhI2BNAIN05Yw3gfyOeRzb9gOWKudsASV/pniK5U693uAnvPyawa/
	p3aK7XCg3Dpo+7J7lL0ARmZIx896dwIsXR4nyLfM+ubGE5hPV7DTxIU9D1Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782369368; x=1782455768; bh=KMtAR+E505GUoC07qg8A06oD2wgNIqG9R5j
	bt4I9554=; b=iHnQno6Cjvr9KI+D4DL7e1namJxlOo8lVvEPd4ssBSG1y/gBOZ0
	Ht7ZpgoPp8I/FaHqYuuVCWjOcgcluVRhBUA1ILek24bX7eoSJ1qfvtQ3aV02fav9
	bStbglSee/HUaOn6ewEk9K89M4XIkrbUaPaIYnSlgQ2hndTk/QOI98aEHoidmtSb
	/r2fWrXXpdGb8l/tIiUebIy9HAFvashcWJyYeb7ZeHbd+a+aEQkYEx12TVhF/WsN
	eDTBi8+Bpouv/mc/KjXC7JyHFK0JIuUAIDL2R1kSvi2E26jwyxqUr0ndHFvOaIrT
	speIT0kgkDkwZKUUwgMZM/ExDjlZtRET4KA==
X-ME-Sender: <xms:WMw8ajZ7kqYE-7hKEC1MRfjyKft4BwC7eAqys6jh-gGYDXzkYMle4A>
    <xme:WMw8apa6B1TgvgUUuwB1JOZp8BuKz5MEc52ymj_FHh38M8j5IMv6rXruA6jeH2Uv2
    s2CcAZswMabpATV3q6fYeHNjl2O6WIlOcQLDEJStV8I64-Gcec9-A>
X-ME-Received: <xmr:WMw8aq9DHz3_NGT__fi_aTPuMXctUlSMl8smcqymeV4LxRRB4IuOzAEhLqkZlO-dObjceq3nbE_yaWdBuyZJaYP_s_j21t87Af7AbDUayA>
X-ME-Proxy-Cause: dmFkZTFAPhkoUC0kHphpIPFRZNVZ7cUpKz6Kgpae/Gl6igDqXO64PF3zYrmN/mC6wQyPY2
    SstG1ahHDvHSTzsZXKImHv9KDO7K5A3gqo9hbuHsFrqM3jNUF39VbE1VRCZ81wQ9+W6yl1
    l8B+YaV8djWGg3x7CLlZEFogTf8e6EPhZ9HJBumFB11Z9aIhzmKgiI5TmpkPfjsjmrcAf3
    5Tp+q5v4mpLIKaS9P7qzhxEV1UzpMrEhawhwa+tSePNZWw7Xp/p0ooPhwK+YlPCe6rn2Fr
    V0Roe+xMMmm9yvL0QNQvi0hpCLKe+aVtzo3FFnoGGP6zDmaLUvYjPzMJ6U2rj7ylUVuuj1
    1sa87k3evP1QSqd6pzk+G27MG/Gxt5tG9BwascyOxOwd/sS2jMW1hpTS13kFBb1nOnE334
    0uhOaxr5Pl0QprcePJMWW+z/Jeh7e0au5a7avu1FQ4xAKo25bnBqmbrCkBtNVJpTiRj3Le
    W/Pju7eAyKQs8Io01GrLMfl2ITisTMuoPaesDN4qzzK2+eXUPjhHNDwl4j6eBH8bH0pJ7d
    nC1TbUJbTaLrFTxqE1rbKk1iPoPKBXbAf/1d7Y8wzHEqRGWnEM33zYx8NQr+ObVxUx/6l9
    sId7MqniM+QNmhqGbBdUmxJ83E4X3isiooON0BKrhj4SORBjooGJLaAG0RcQ
X-ME-Proxy: <xmx:WMw8aogZkx1D-bCe5yOdWxqlR4fETI8JzJa8FtgMjG8oTONOiJSy5Q>
    <xmx:WMw8aqdEM-ePeG6eUfdgaSBGJeKXokKxv4t89uwVDUVdfqE1Uq85wQ>
    <xmx:WMw8avqSDOtVusfEJmM_3rHaDKl920GGKfPmAj2yAUowsmloKuwmIA>
    <xmx:WMw8avBDyjIXYHIAQzkNw-KPFTV8KHGZn0oOnQWZKgx24-uZqVvl-w>
    <xmx:WMw8atCzh9e-uBBWpi-iexWVC6Y25jJRQ7zkbgY4oKhj7-VdcVpvsFzW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 02:36:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e25842ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 06:36:07 +0000 (UTC)
Date: Thu, 25 Jun 2026 08:36:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 10/11] refs/reftable: lazy-load configuration to fix
 chicken-and-egg
Message-ID: <ajzMVbyfkNF_LEgX@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
 <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-10-018475013dbc@pks.im>
 <ajxU-McoGrfkeKTs@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajxU-McoGrfkeKTs@denethor>

On Wed, Jun 24, 2026 at 05:18:21PM -0500, Justin Tobler wrote:
> On 26/06/22 10:28AM, Patrick Steinhardt wrote:
> > diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> > index 608d71cf10..d74131a5ae 100644
> > --- a/refs/reftable-backend.c
> > +++ b/refs/reftable-backend.c
> > @@ -141,10 +141,21 @@ struct reftable_ref_store {
> >  	 */
> >  	struct strmap worktree_backends;
> >  	struct reftable_stack_options stack_options;
> > -	struct reftable_write_options write_options;
> > +
> > +	/*
> > +	 * Options used when writing to or compacting the reftable stacks.
> > +	 * These are parsed from the configuration lazily on first use via
> > +	 * `reftable_be_write_options()` so that we don't have to access the
> > +	 * configuration when initializing the ref store. Do not access these
> > +	 * fields directly, but use the accessor instead.
> > +	 */
> > +	struct reftable_be_write_options {
> > +		struct reftable_write_options opts;
> > +		enum log_refs_config log_all_ref_updates;
> 
> Any reason in particular that `log_all_ref_updates` is the only option
> outside of `struct reftlable_write_options` here? Isn't it also only
> used during writes?

`log_all_ref_updates` is part of the backend's logic, whereas the
`struct reftable_write_options` is part of the reftable library's logic.
So they have different scopes, and the former cannot be handled in the
library.

Patrick
