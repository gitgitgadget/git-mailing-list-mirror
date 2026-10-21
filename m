Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792570159;
	b=pTTPl8Rjt5IAlLHJG3brK19GV+b3cWzSVTaqzwpA0J0CsxvyX8hIkXrbzsQ+3+2Lxhal
	 u9EMTbbwAA26vt5Irr6zFBmh6CeHo5Gg2pNPThn1dJmSYoqqniYSPQX0ZTwZ4ykzOrJuZ
	 jygcuTSmYr6NAg1kN43tHOea+6bZdUeJ27Ww6n94vJFnxYDCdiGJQWU9+u6RvfjPhOGBN
	 yUBDq5HsMP99Ywx+5oOFZvbic4kvyCiq1jnwLMEVqwHSs3IcV9h1T9jbSPDc4StsTj2nK
	 6cbHWmW6Z0sqT0nCdIfItrjcVjDoinY3Bc9yiZ4wT9Ro3tOaMbo66QRahzAIbQOqh4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792570159;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=aiQcKPPV2bhw6QwHDD7U0XhcKRvpgdxyJ+mJGtHMBMo=;
	b=d57dwqAD53VwCyJgCWpip/26XEF2LtS5zAHSvLkACyOkQbhmRrZafkyPjtnLaiDZj09k
	 KAXKm8/bDdsjLyzaD6/RBEItYdsUGon/uEETu9nL96odufpI8APU32Kjf4WY+7YPSWakS
	 9Y9ffxCjLDYvyzxZaaE75m/powIrorkc8CqWWGMR3m0jhoRgT2mXBMLGxcDW7E5YxTa37
	 ixo5rTxjdBxXsZjz6FEKojvi2kWW4SJCV0ogiX0uI4qPK67XSjrj+o5fF9hg89pR9zlHB
	 uQjm7ZfCPzWNjOFqFByB9g2nLoe/rLlFxUjSFEQwpGrolIi0ivTJ863kRdXph49WZGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aIHZKEME;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wv9ZKcga;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCAA606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECCAA606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aIHZKEME;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=wv9ZKcga
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 535C51D00105
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:09:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 21 Oct 2026 04:09:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792570157; x=1792656557; bh=aiQcKPPV2b
	hw6QwHDD7U0XhcKRvpgdxyJ+mJGtHMBMo=; b=aIHZKEMEoF0Gs7Zn/6yQtBYOdo
	Fn3VPnoOG9jOit2VzLyDNLS2A9j/GgXtOYcy6VlIxYeBOrHyU3qj4ZY/nAcTlq9v
	Z6DhY5ldiSMJd7rKgSgo55KWMC1mKPX4z9CWAI9Uw41EIhHPQSmdrV2yvEU4akRD
	dPZWofOvc4NrDYxIU0LFMMprXfP+HaPEzCHs+jgPLIflMPFZy32YZYCUAyIty4Ag
	vG/Y/QKqq0lNj7xQGnk+hE0y1KGhGIyfLIau/X8Ryt1rfjNEzQhVMdI7lX0ESztm
	k5z9aqUM1sm4PPL46rwbog5Q6irTlJZRRmM0RPcfuKNHtc38R2x5PAKJ7V0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792570157; x=1792656557; bh=aiQcKPPV2bhw6QwHDD7U0XhcKRvpgdxyJ+m
	JGtHMBMo=; b=wv9ZKcga2K9cPxooPLfiBOCE7QH/WLsHF0qwXFoUvrYPSLp6mZL
	mvcdzZ09SdVxh+R6sc4otZR11EG314eEVdrbB3KAPKbT5MWlfZ24Hm4h2eTpNXXT
	SMhRewVamp5jLkSWH6tFpv18x/e6sXwnO1pKd6VMKiTq2dEjvvI7MiXlP/rH8xAC
	94KGvm+tVLth4a99DrXefk69RNc/JkcOS+PqDnuul5msAOb2i7QGt8SWgMz7Sfyy
	lt7MTsJ8/EU1yPzI/kJ4q+tr67sws1ePiw1Y/fWlDe6D++3A3vwwbt5jPz+XgJcA
	lOnvSRPk6SyEfCaCH6OVaQOfhc8b14uZgVw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792570157; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:nsD1DGYjWdxxwLkHal/98PussP5Stsj768hsgKl3onkqJ97
	bECCphsDoumt8GvHWR/v15AZTI1I1mxxHDMcgMjBhVA/z/3fgUPi+5y8TGMYcRGt
	2s3FEr0pR9xOJJupeTuihu5fyvIu08avvIapQRI05TLWsdaKizQX8jphkrxG4DgZ
	2BTguiLZXCaBIrPi2Y6nzRk+CgK++PZQjFchRCwddNycfBfsUs2eKo4v4QKO0B54
	g0z5xdtdKa067BRWVW/xHtKJ29eNmCRIHENXsogZIkTDd7GAckNpatkmv4ev3BL/
	B4/p5LUGP5i2PpNxqnUeOX0iarZxIgDCrAYe9pg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:w2Am1tbSjmgGhGrva3Erx8/7ZB1mgUJ5iIxUPXjnjkU=:8sRsGFqBt5oUj+ype/pcFNVfv9ubPne67zhZhSfYm6k=;
X-ME-Sender: <xms:LXPYamqZ0CcVJ41SZ5TejQlRyuUk83ZgoC1Yuu1MTNvBOF0J9bWf2g>
    <xme:LXPYarh0i9L2yRhbk51Z1ZpDSC5pL82Z8CBMpWHgNScMqLF0ZdYvw1yW8i7GsYP2m
    XMXKMu4VyuC4Q9B7IV2qahxQhrVw9u2z_dVHhKlteVPDsClKNKN9jQ>
X-ME-Received: <xmr:LXPYajiV8LyGQxp2sYR3E6JPIWOgv23FSQQuac0eOrrwdanshKcQJg>
X-ME-Proxy-Cause: dmFkZTFno3MIXvjVH+vS7aXxAcWqVPn2t/mAC2BGUBC2LGzujlSJTVRQEEXqpeNy/Jb7Dm
    I7IlHDftRyBsLMMKrtMYDkc63/Ed4zAiYpFZNhJe6yYvBjrnH0UrCQUo22f/LSexxNRI4k
    gt7yrNm0OFuoq51KROtUPmEuKz7X6nsXaiTtvOymn3t3JDg3xD/moNrR6cCs4ryy/kQ4rs
    hdbeoarsmUj06IbZVUb1GvJKRr5hWbylXdlBb3fBYw9NL4sWxZS/yQVPRcvDApkFCtcG1w
    OIC7DRteFe8YxTaJzoAYqrD3K7SBOATFshHK5gL3lScbGlLxQvu4RChoirEmYU1h2fSSHJ
    IMb17/bIwSGb3Ik5VejuoiOEf+94GiW5VbDE0Zlk5kJ+uWbo1IZi3IwtSLMzMQ6A5Kpy4U
    e9JuJ8fOZRQ0g+f5eONXyN+oRK6fP0VqpsEw0q3s2fq8FTSAmougBrKqxOgBA/vtdzVXk6
    P1sVfUWkbjpfjGNJ9uyfwvXTGGszEfbRCEERzrdOAwhKt9f/FQoBZwzWi/xDOhdaCFdclQ
    5g23s4QqEm27BrehRaCWo3kOhlpSOhPy25qidYL2L7NHIvW4SishhJdiEX97DVYUQAGi2l
    4b3kzNMetSLur9Kjdp8L3b/5vLKVfONIPl9BbVj3/U1zTODc96e1JiLwgZnw
X-ME-Proxy: <xmx:LXPYahgDwT0hom3wgJgMOt8OaAZ3wXAAcxW-ZH7cuiac_aTAxytBfQ>
    <xmx:LXPYajKeK5N2Zpj5rUF6-JEm03iljhzOsH7ZrXU7nivvdBL1iza_Cg>
    <xmx:LXPYagGhxw_kQt-JJEFk4DqDkW7PRKezWTt12hJvSuuZ-dwLSgmjRA>
    <xmx:LXPYanS7y7M5KfMtnYEptficw_Uro_DRQr7iq_JlASabYi9TpRz28w>
    <xmx:LXPYahnAti04XquQTPwrzUpqMbRml3W5PJETL1dCLXCVIYnT-_jsQHG7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:09:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44f89ab2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 08:09:15 +0000 (UTC)
Date: Wed, 21 Oct 2026 10:09:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Joy via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Usman Akinyemi>" <usmanakinyemi202@gmail.com>,
	"Christian Couder@imap.fastmail.com>" <christian.couder@gmail.com>,
	Joy <soniqjjj@gmail.com>
Subject: Re: [PATCH] config: move pack size limit into repo config
Message-ID: <athzKcUyQjqUTKzZ@pks.im>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
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
In-Reply-To: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>

On Tue, Oct 20, 2026 at 06:56:27PM +0000, Joy via GitGitGadget wrote:
> From: Joy Gundu <soniqjjj@gmail.com>
> 
> Store the pack.packsizelimit value in repository configuration
> rather than keeping it in a standalone global variable for the repository.
> 
> Update the configuration parser and pack-writing code to read
> the value from repo_config_values rather than a global variable.
> 
> This change removes one piece of global configuration state from Git
> and helps make Git code easier to reuse as a library component.

The commit message typically starts with an observation, followed by an
explanation what's bad about the observed status quo and then finally
explains how that state is improved. The order you have here does not
match that typical flow.

> diff --git a/environment.c b/environment.c
> index c83cf44839..e350d6949e 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -728,7 +727,7 @@ int git_default_config(const char *var, const char *value,
>  	}
>  
>  	if (!strcmp(var, "pack.packsizelimit")) {
> -		pack_size_limit_cfg = git_config_ulong(var, value, ctx->kvi);
> +		cfg->pack_size_limit = git_config_ulong(var, value, ctx->kvi);
>  		return 0;
>  	}
>  
> @@ -768,6 +767,7 @@ void repo_config_values_init(struct repo_config_values *cfg)
>  	cfg->check_stat = 1;
>  	cfg->zlib_compression_level = Z_BEST_SPEED;
>  	cfg->pack_compression_level = Z_DEFAULT_COMPRESSION;
> +	cfg->pack_size_limit = 0;
>  	cfg->precomposed_unicode = -1; /* see probe_utf8_pathname_composition() */
>  	cfg->core_sparse_checkout_cone = 0;
>  	cfg->warn_on_object_refname_ambiguity = 1;

Hmm, quite annoying that we need to explicitly zero out all these
fields. Maybe we should adapt `repo_config_values_init()` to first
`memset(cfg, 0, sizeof(*cfg))`? That would allow us to remove a lot of
assignments. If you want to do that, it would be great to do it as a
preparatory patch in the same series.

Other than that the diff looks exactly the same as a local patch I had
already written myself, so thanks for allowing me to worry about one
less thing :)

Patrick
