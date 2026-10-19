Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D2D39A047
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 05:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389440; cv=none; b=dCN2+hfD2zY0kf9wFsDu0KL+WRrkAVlwZHtWreE4wqFq6vkM1GKnh5QlIySxXYpGRpTXNaVLnWfXRUfWDhnUGTqeuiqmo9zNVrwUKJUT2ggX4GFyfsjFbZEWCsFNGHVjmBvxq2FS15cq133sH7gPmk+b96S6kLPRr4HaljCA7gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389440; c=relaxed/simple;
	bh=dzjOlaTojsUlvNfFTKBppHf8cCeXRfTkS2mQHu0FMMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtkqbDVTnJFjROlJooiVzKS29mVna7ezDpicW7XJRrp075om2laahu51/iJyfC0ZU0G0JLQPtmP/QsTC6K+KkCWssM55tljclQd49C8thMueNGkjPRuMfCC5lPa+wlQIxCq5Kuqxzguhk/YnfHSA8t1hgljxTsH10ZeU7FDWTCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=j3nNemkU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XgFHEaFy; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="j3nNemkU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XgFHEaFy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 14CF21D000D3
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 01:57:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 19 Oct 2026 01:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792389437; x=1792475837; bh=xBpvlHWRTe
	t80PsnN5+R/f3L7H1zvsilPfHVh1xnqp0=; b=j3nNemkUIQe0kH3OPTlL4m21q8
	QdO29LZTzP2c3PDOJPj98OFoqLJ8LFjjbXEw6c81fL02/LKZ+mP19HGWRwuyAJfU
	bumkKk7tgQThHPhSQR3cH92pgRXNeYqCUUAGasF63JNFp647F8EfplXBcSF3InY5
	bld+5QNk9INsuQJsDyYxJYHXYe2DOxM8nTHr9d5B88m8hAPpBgbWQhixrvK0hPv1
	6qPLS6Kx+FUo+ddaCuokzxwMvjTfdR6P1rZqlH2SoCFl6lYY1LqI/o/wlJeM33pf
	MoRlVkNPywGgwGLVeGr4/zowI0f9OODk2PbYM6BcWzhH2lnl1Hdq/0WCLWAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792389437; x=1792475837; bh=xBpvlHWRTet80PsnN5+R/f3L7H1zvsilPfH
	Vh1xnqp0=; b=XgFHEaFyx7jenwm4fHLSOreZnRrEwatKkLk8RYszZzQdkWg3/Wk
	mQ9j4iW09twDsPqt9gkD5pSnkTOcIY5WTeu9UQvlkQxg+mjx/OH+nSdHaEUjZ0p9
	95wIVRgyPadXs9/vlfUw30mkNzzrkXhdaaBIdcS/lFuVbeqbz5xVklsd6TgD3prn
	ekQYsIKwYSNig2n89GcsKD1VSKeFhJIFnaRjomqK6qnWP4Evg5nfX34KhCWp0rQC
	2bDD1ux97syeK5JGQ3FuGaWCURNpEnSz+E8fqOI1sOGEEmhPNX4hJsyt+umh/V+N
	detgCJSaKqSadKGnSMY4rXGF0DQ/U/JbpGg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792389437; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:oMLxRxhIhpV2Zgg1Mkg6PGiAoOqSDol7/ymVfRu8Ts4xdaw
	8UUuyB1OH5dHHncjJH9MqsZpmbmXfdgcmFQa5+2Yu5CXzcVQSRjke5SLzyONyZtO
	zdYGNZaJvKY9VDXZWXnIA7SIHXfx3D8jPvlIeJ1fuqOTimheknPE4+5TTHIgZRNV
	TBPBGM2Sr0veuwsVRwjrk15s64rOFdZVHkMV/Q7Tve9Ssys2DhFeoJOefI0RGWRt
	pWJq3liv7MHYNmpGEMCR/u3uiE9i9ew6TBHH97g8KFeHtMT2cEkFGOEAdrydULC+
	wNC5IogsijW+/van/FVrhiXSxs8Ucr1eRm/a9bw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IJKbHHL6nW+12sWxLlXrmu17R+Di7dDTARMJ5fzKIn8=:dzjOlaTojsUlvNfFTKBppHf8cCeXRfTkS2mQHu0FMMA=;
X-ME-Sender: <xms:PbHVai1C1Pz8T3vqZpgG6gD_Ez6oxZq54lOmkg0MDbaxr32R4HUPVw>
    <xme:PbHVasiSIhNL70dnJYIu7fg5eFaLZPsIOpEvlEyqx3XMIGtcsw8xCNznMGrMXVhRa
    Wi9lu0JuxPDorfdjbL5-WrvjzG3csCqTVS96-jcb4vPM1WfwfBxHNg>
X-ME-Received: <xmr:PbHVaoQ3diqzrumxY5OQAWPkMGIrXY5aLCJtxYDR3yRAmIQuBQscTA>
X-ME-Proxy-Cause: dmFkZTEqoUMfhtaqatE/JEwT3jRWwUsoswHPzauoUgTqkW7IG2WlaQZK0E94e7pPQUS/su
    kSIRoMZ0gnuPfp2j/1yXn0tyqux/m5AqxCb7G33s59X9iLxabkbbzf9B6jG+hIoqa1cxC1
    ah5zwNx0uSrn1ZcMc5uPUYpF429NEArQBBr98il+e/6pJiZNPlxXmNGjm5Yaqrlud8Cc4q
    mSE9K4dbjbUrOxt20wVt+DMPpxIAjviURN74sggEvhleA8ywmZr/pg+j6LLxIWo+JkM6fW
    15IOl1EdtsxoCbdSMF3TmiYGAKdJeOLAf4qBN+3/GdIdd7/woey8CH1DpEvOEWW+QLBtKB
    jC6/cwtzttQnB7jctcdC7uW+irm5X5NlzMYdz6HlsE6ouyeoYw7te7ShaT4ePChIiR//X8
    BTemULIEjJQgYn8oyphBcm0RV3TExbAbvpFtLAkPWOTeA4JhsJr43DfSk9la7QTMbJQQsh
    aXBrF2l/afT8kr1Zk1azYPabmBtQB57cuiP+QvJChhIh+gOtH/JAyFiE4cZ4DxJhN+0d5h
    BxnYqAzcBrqCq0ACGnXJroJwJpIMGgtDH75MXKZCpUJLRlqrxBRFpyjtYxFWA1nQbwky0Y
    Il0NQNg8dBIPpJXhs28yxzZpquIfXn/kVqLhXO6yrWT9M808EyQjQiOWAoug
X-ME-Proxy: <xmx:PbHVati-sNidjPzK4EGW1UBnncuo36xO_AIoT8c58pYM93RWjf2e-g>
    <xmx:PbHVao7NOLhjHsUfRSTf3r3JPCdS_0AMbjp9p3Y9QY3yk6UmphLUZg>
    <xmx:PbHVaqCaViYUGd-Gy7do3Sofpd2Hf1kCj6cOHtdUZbVjHrcJSyfo-Q>
    <xmx:PbHVavafHtts2A2DBgskJMC5tfsqi4hcZlTBXBVCSb_fe-2_GvgGSA>
    <xmx:PbHVao9XEImgRf6PQeMrraVsX1kmhZWq11v1mg_QPP2yxjZg51GDxH2F>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 01:57:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4a2fed8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Oct 2026 05:57:13 +0000 (UTC)
Date: Mon, 19 Oct 2026 07:57:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] refs/files: keep root refs out of loose ref cache
Message-ID: <atWxNvZn3CYTBuFp@pks.im>
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
 <20261017200405.2332914-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017200405.2332914-1-andy.koppe@gmail.com>

On Sat, Oct 17, 2026 at 09:04:00PM +0100, Andy Koppe wrote:
> Changes since v1:
> - Move create_root_ref_cache() below get_loose_ref_cache() for a smaller
>   diff, and tweak its comment.
> - Correct the documentation, help text and refs.h comment for
>   `--include-root-refs`, which claimed that it lists pseudorefs.
> - Consider alternative approaches in the log message.

It would help to also get a range-diff relative to v1 so that a reviewer
can see what exxactly has changed between the two versions.

> diff --git a/Documentation/for-each-ref-options.adoc b/Documentation/for-each-ref-options.adoc
> index 54e2fa95c2..b93ffbd74d 100644
> --- a/Documentation/for-each-ref-options.adoc
> +++ b/Documentation/for-each-ref-options.adoc
> @@ -73,7 +73,8 @@ TAB %(refname)`.
>  	using the same rules as _<pattern>_ above.
>  
>  `--include-root-refs`::
> -	List root refs (`HEAD` and pseudorefs) apart from regular refs.
> +	List root refs such as `HEAD` and `ORIG_HEAD` in addition to regular
> +	refs. (The pseudorefs `FETCH_HEAD` and `MERGE_HEAD` are not included.)
>  
>  `--start-after=<marker>`::
>      Allows paginating the output by skipping references up to and including the

These changes make sense, but they are unrelated to the fix. They should
thus go into a separate commit.

Patrick 
