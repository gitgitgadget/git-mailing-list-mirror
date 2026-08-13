Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84938CFE8
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610955; cv=none; b=OX0NX2wNsrgiVMbF0VU2VVFNlYMNHeMTnRgVrkS8lT8+FAabZn5HNSSnoi0h+fudx6GnyGWqOuZzKDtSAuXj0GXYOb/5OH1RfZbM3S7zfbNllvvIPgP8EzUFe/jRwPCLjhSLs6jPhLgIIkujl1KrtKIJIFENvHjuPGfI4/Z4kmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610955; c=relaxed/simple;
	bh=5wbS3ya0U2Dq5NV0tC+DRegnxQrEFQpkZ1yg45hcJRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g+qeZy6kLqg1YH2XbLbdygqbpugF85g5UiDi7YY8YH7nLTLKi+CtqliFzcXEfK62DudfaICtDzkQ3T9r1flX6zFyiWpRv61CdhN7oiZhoJJaJCv4104susCXqoq8xbhhipML7HO/oK5dy7mlrtzhy/qbXc4ZbryjvI2Ix0xA1g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gizXBw6y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M7/zbAkQ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gizXBw6y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M7/zbAkQ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 513217A0016;
	Thu, 13 Aug 2026 04:49:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 13 Aug 2026 04:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1786610950; x=1786697350; bh=GTXtiAZly4
	6Tmz/C5lVAksDAIO7sYlFkopCDXWu6ToU=; b=gizXBw6yVj+AkvOgI7idn17JYe
	+PlmfPHu0AY9FD6T2/eVQG/oMA3isqJpngTnGaMLAv2xtg47iI1AQSBQaJr+AvGN
	GViY0cyWa9Vz+l3VPsUqFgvwsmBixgQygnouY+1Jg3RgGsMc5R14seSrMnnzGXqu
	jV3oQn/3fNoqOKlwjBGrfNcOqy8svFzQ3tyxxeqPM+L/m+HEVfocH1I4O9aZPSI4
	AHUg0zBaV+nTkd4b3rJuZChjKMl79lRLIhJTUvLvk+cFQwXDIEtSYkRBeZEAzYcv
	dNKqntk01mgvacA4JY292XUQlY7iJkC3okJL90P/hP+aQUX5Ixf4XDCOJ0yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786610950; x=1786697350; bh=GTXtiAZly46Tmz/C5lVAksDAIO7sYlFkopC
	DXWu6ToU=; b=M7/zbAkQXcMrWTVAOs4zXAPBdm3wdriQx8OfU2IaRPdKoRK6nhs
	YG4Ityny/cszORYcdYBchSawoJSTubta3QyltOvvHnGzDldRqAlFdkpGu4FFVYzo
	Iqy6Xa1E7mSJWeDn6YO9zgmONf+KKuppx85azADDcSYbbzQsqF8/qVNUHRgRyAf9
	dGRAGJv3xqcKJZ0zQf8322Q5PF2RMdIa7O10b6Jc1CS+Wy0i5WEKI+dojcUjtAF4
	T2JmfnLPqHqvYlG53tRIPBCZ5BnD+Mvyt4kmSq+lNKf8w69G1B0Y6gnKZobnvjMO
	cweIH1Wc6Hl+mse7K2OazGl5R5w1u1AgbJw==
X-ME-Sender: <xms:BoV9athrNEHUC1laU1u301VLTrcrFGu4C2ZIYsG1LW2u6FaBcYZRhw>
    <xme:BoV9als8x47Zoc2f4XTZK5y-miQcYCqTmHx3u5hy5vRMfwjO2GgvsU4qq_HEUvsH2
    -13zw_PpOrw3T_y5If8-EhOEHN4UvOebQx_ueNHNjgKruJvrpNwtw>
X-ME-Received: <xmr:BoV9am7PtaH7ak0yWCVgXlcPcerwlplbNaR6N3-cUZVmNZ-pJ978PUnnARzNxdRhneLySBg_qDo_MuwjX2cnxAC6C0EShFRPHb_psvuDScvA>
X-ME-Proxy-Cause: dmFkZTGD5AWXFrQiFHWeHRWnpy+LownMaGCjod0S/XfDsWQ4+HI18NoZwkQigqrQb/ilGF
    yG+CdUTDchQZCxxRoO+EK1Q6czHchb6LVEWqtwOulU2bm3b/e7VYcnoLuhh0LSP5CFBI05
    rz6CVTkkMZEG9Kw0fAJtRpLhrxkMez/U9apq8v5VzfHrkaGFn3ErPZvDFHrdkywgnpHgjk
    Iy+kPBWZpRXjuyCJJuPoNzMiQVR0YDUptdmz3k6wUYrMfzOOO4mjTmknbd2Iny8Q5f6ua4
    SvrbEuVD/4wm5CgwFwi/llQgoVE4AvIUxIP7cgz7unggMkwSbLXH96pJNgcAAKy0NsshDv
    GvBTSlUqoCko7JtfFFQUbHfwSjnmSvT1YuhqxiPPhUZ1b0xKbJDNVU71sAIXoWcxEmAe3M
    udxoiraXmOPfxZAkgpdAlSogxRSj2CI0DWt8JRTloi8hzshfXqr6qcEnx5OTRqPuy/HnQT
    jpXTBDGQVKDD62FyAGxWIjOJwhqkcKOEXmwdAgQP513+k0zd+JNBnIN2Tl/pDS7UGR78ag
    bEQveWXNBlZObjbk9Euk1T26jdY4Nb5CIrV7UZPgWcgeSjkFlpOQvRldcBwvcKrOx9cOKT
    ZmkwP4BXEFl7bJ0c44cAVS4+maRKNCRFeLUJ5vgw94GHxDy/HthoJ4/WSaQQ
X-ME-Proxy: <xmx:BoV9apOVG7S27ACVpVLfj2ty9xn3CZM3wDT0fjFlLPoBn80oWSpiig>
    <xmx:BoV9asuQGjyKOJnzAUqgwvW_p-lSXI-P3DjZZ35ctDScjTXl-aFqKQ>
    <xmx:BoV9akYnuok-lJf9G32FmaEVIeJSmIRhSvbkCwcKToLm-TFmIgn1bw>
    <xmx:BoV9amwTHNo6hHw18U1RvdK450LdqRMvWnZCpB1DxEui7ynDmFrD7g>
    <xmx:BoV9aq_gkEU1qPMHaLDi3FahsqYVfqgkHqsnS9gSRO0eRJXGOX_8sMIc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 04:49:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3da33496 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 08:49:08 +0000 (UTC)
Date: Thu, 13 Aug 2026 10:49:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH 3/3] midx-write: include packs above custom incremental
 base
Message-ID: <an2FAWvyfX2LuGsG@pks.im>
References: <cover.1781294771.git.me@ttaylorr.com>
 <7bf7c87b60532a90c04c4a2404449a9d8ea21214.1781294771.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bf7c87b60532a90c04c4a2404449a9d8ea21214.1781294771.git.me@ttaylorr.com>

On Fri, Jun 12, 2026 at 04:07:14PM -0400, Taylor Blau wrote:
> diff --git a/midx-write.c b/midx-write.c
> index aa438775ebd..c50fdb5c6d1 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -133,8 +133,17 @@ static uint32_t midx_pack_perm(struct write_midx_context *ctx,
>  static int should_include_pack(const struct write_midx_context *ctx,
>  			       const char *file_name)
>  {
> +	struct multi_pack_index *m = ctx->m;
>  	/*
> -	 * Note that at most one of ctx->m and ctx->to_include are set,
> +	 * When writing incrementally, ctx->m may contain layers above
> +	 * the selected base MIDX, which must be included in the new
> +	 * layer.
> +	 */
> +	if (ctx->incremental)
> +		m = ctx->base_midx;
> +	/*
> +	 * Note that at most one of m and ctx->to_include are set,

Is that true? With "--stdin-packs --incremental --base=<foo>" I'd expect
that we have both set now.

> @@ -148,10 +157,7 @@ static int should_include_pack(const struct write_midx_context *ctx,
>  	 * should be performed independently (likely checking
>  	 * to_include before the existing MIDX).
>  	 */
> -	if (ctx->m && midx_contains_pack(ctx->m, file_name))
> -		return 0;
> -	else if (ctx->base_midx && midx_contains_pack(ctx->base_midx,
> -						      file_name))
> +	if (m && midx_contains_pack(m, file_name))
>  		return 0;

Okay, previously we were always checking against `ctx->m`, so we
would exclude packs that are contained in the current MIDX. And that
includes the case where parts of the current MIDX are supposed to be
thrown away because we want to write a new layer that excludes all
layers starting at the base.

This is fixed by instead always comparing against the base MIDX in case
"--incremental" was passed. When the user passes "--base=none" we don't
have any base, and consequently we'd include all packs. Otherwise, we'll
exclude all packs that are already covered by our base, but include all
the other ones.

That feels sensible to me.

>  	else if (ctx->to_include &&
>  		 !string_list_has_string(ctx->to_include, file_name))
> diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
> index 69e96bf8d93..84ff6120978 100755
> --- a/t/t5334-incremental-multi-pack-index.sh
> +++ b/t/t5334-incremental-multi-pack-index.sh
> @@ -119,7 +119,7 @@ test_expect_success 'write MIDX layer with --base without --no-write-chain-file'
>  	test_grep "cannot use --base without --no-write-chain-file" err
>  '
>  
> -test_expect_failure 'write MIDX layer with --base=none and --no-write-chain-file' '
> +test_expect_success 'write MIDX layer with --base=none and --no-write-chain-file' '
>  	test_commit base-none &&
>  	git repack -d &&
>  
> @@ -136,7 +136,7 @@ test_expect_failure 'write MIDX layer with --base=none and --no-write-chain-file
>  	cp "$midx_chain.bak" "$midx_chain"
>  '
>  
> -test_expect_failure 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
> +test_expect_success 'write MIDX layer with --base=<hash> and --no-write-chain-file' '
>  	test_commit base-hash &&
>  	git repack -d &&

And those two tests pass now.

Thanks!

Patrick
