Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352694;
	b=yubtV4lyBUMrN5fr+ccwCnRtEmblwbHBZwAZ1B9ESjbOFL8a4jZFjEFtqvgzQ+dRDEyP
	 988RkDCH5fglQEPcXGkKf2C/oJWFslejgBSW0Cd8CSc3+9Qu6KPJH0aTqjvVD5dI8xek/
	 vY5mIe0Pg3R+awz+RyaUiJLQOmEIvloZKWPfPuE1oNyNwyB4LRMiyxth5rWiPeG0MT94Z
	 uAGzI+i0c/ysVqtelvNZ35XpO0bZy2n73FbWJ9gTSfbfAOkwyj/cwtkz1mUdvWTRn73ql
	 /AhQbg5m9YkPpNfNurCrKLIKJaGZ59jcvAiYQJKQhImJhByXAuJojyadZfP1lMJ6pTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352694;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OcEzMhOM5zgBhfzvO2HqR4+g47ZmNq4IsJJv7sxMbp0=;
	b=eFWLA0N+h/G2iU2Oou8zy8Kk6zbmCCMymapDbMKEqT3KLt3ry4e/IXwQB2SgoT8ZIotW
	 q4iIhtipZ/AZwJnhjVuxs7AmcDUu3B9mxhhCHeTECUHsE930x3MJLjUDyZQa6tz1nxS98
	 CDJVmTrlrCDSRk3UCZQhkq8DbNNwN0xgxz6yqzFaIyN8Wwv+DpmaHIw7G1TYLjICGVUmD
	 U5h93/MGqHj2PaaIi9y5HSh/CRlgVrsRjinknRIUKQAz1+Jhit7Tl2nfEzVtq1vuuHfSg
	 o0RmS62DqoWm+U66wx+PtNjp25bK56csodcKSM75TayazXfDVa6xLcheaLcO48A3Mmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZAA9ht42;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Kqx4c+f4;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588FB606A31C
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 09:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 588FB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZAA9ht42;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Kqx4c+f4
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B13DC1D00082
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 05:31:32 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 30 Oct 2026 05:31:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793352692; x=1793439092; bh=OcEzMhOM5z
	gBhfzvO2HqR4+g47ZmNq4IsJJv7sxMbp0=; b=ZAA9ht42x8j+QEAPCXi0qY57+Y
	4sKUv26XPGn8ZuSrv374LaXV3sTaTU7acSXGCL238TlU4lMkFk/i1PLkzC834AMH
	WEjURqLl/IW6/ddCvDCVS4R0vKpQDNZkrr1AW0ChT5QqAI22IXd5fuEl/nzsPq+2
	sZmKdqKDy97JBAU9SN6hrTvlyaU436Hl0Y2h+FfWn4CRsBO+a2pVEjjys3r2GI5j
	bfgX1xQKqS0uehFxg+iX5G8Tk/Zb/RNtX9BOkQmU14esaiKcgRwFvrVl9nZAIekd
	6LpuU9FIw1axGD4xzZelSXngubopqhX5LwgBCtNFeExnXUE1XZ0B3QCehbYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793352692; x=1793439092; bh=OcEzMhOM5zgBhfzvO2HqR4+g47ZmNq4IsJJ
	v7sxMbp0=; b=Kqx4c+f4LRzEMnvjs3r/DNu8l+qXKQe7ar/uC4LiSyRqsXTJkuA
	TVSBwAb1nCDOjQrEE8jSiHqfHeNfSNlWppjA2E8uMsWV+Zu9T+z6Vlxu1EDQy1lm
	dtAl7827kEV5Kgqar86KViIn47N3LYfoUsDNuX9J3EiV38MgRSFuIIjso6Ak+unU
	oFjLng0caldCH9Yio/PNBov2ByiQRreGFkqiCqHuKCt93TQkllMgVJwgMHVjyqga
	HhcQh4LLeUp295M/OeISTAVeg2cR/5X368i8ozNNfeRI+PY3Eg2YNb5hXifJzr3c
	jDvy8xBHiZJVjB5SebMoB8E7L+jIdWdumSg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793352692; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:DDr41hG/vbPf+QevU2UPu2IWbekkB/tg9dayxeTG3OkdOcH
	PQbBxceV3N3KCN/yBbVaulB/3GykUBNooQe25/4lD8tNTAKKdE3oP4aYpuRKql8m
	u93Qm8SzrfefeQunDg/z10y812U9+RKVyKp3j1swAhrBfdSj1G12CItqpkEWhE/Y
	a/Yc9mMH8zbJt3LWvXsLbVP7u87+OqPWlC0qfGNhlj5ND+gjKmuqhXzGw9ULircQ
	eaDMYlwW6q7CXj4K7c71b7kuMYbJ6P3Iy4Q0VrsB5vhB9hrz/+5RqNtYlIC6APBH
	twx9TZxzW6tTZMKCm/qAztUhgc5gnW2plxCdV9A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:bNRcNb/cDGFTmSlPMnAw8Bc5raYRlLMU6pgm2elJmPo=:/LCz44335c8227tPzZAFautr7j134ttjLGuVNx1RKfA=;
X-ME-Sender: <xms:9GPkahOYtGwpNkaPt0KiJzgyb1JViip9yx1kT-dQ2YaJ1UmUqUyQOg>
    <xme:9GPkap9xnQ1l55Pp2cgvRV0xP80PnS2SKAXlWgZr1GqpRu-9nxGncBPMIl__F0nGN
    HGNVVRelfS1GLGKO1hIBNI2vIm5GlWOEWtYzJSi3cwt9IEaRhpWCRo>
X-ME-Received: <xmr:9GPkat4w-xSCvwDhjbvzWfIxI0WG7TAXMi8pD-AZubD260vKLO2nXoN80Zu8WPSNjK7oXQ>
X-ME-Proxy-Cause: dmFkZTERigPx4/+XOhleFP+fws1kQIi4jsaxNn19RrXO/UZqPlHvGxRUafJ2Brt+tZXhB3
    W9DPe4bN4a70tKcPdzNi50F/cVtnPQWlGuUdkVk+crz4+3WwXR+eUPiK/1VDiwMstGezS2
    f/gHLd06mD+UUaPonh7s5JT/5lUhJ2LkXubWOmTQy7Lqtxn4uubGrC86I7LJvouq8+uXrJ
    dFBMWocBawjcH3DrVkjG3DiotCa+86ECuDDyPqgLxZkAt0oDLJpM2pjq0vRh7slpoyH/P1
    LJnRu7rQ+LppZOq8dDTfB92uXasKH6/TePrnXFrsounpgTckCPoZcLjGvkQOgKX0WxOBpy
    0lEVX8aPrb8P30I6lwHoFbIOY6Jo58Up+zxi79hp72Ovsvqo8lT7MvBl/9NYlxvjISbtdq
    f/OsihgEj0xBYBU8axvzh/Uq00n89REv/o/lgOVe1x00cA/JJYDdcrKkNaI+ybnInVkgS4
    QYfu4j22fWVenPRDcZ1CihzjZ+A6WheNhL08JNV1IJX5QhPrsJuyNkAdW3DdOyWDINFJZ/
    H4WbYfGaKkhWfaeKRqmFXmTRjy84IkLaA+v/8i8kp8s/XQ0MGYCUhJV7X9SYTxGjtOlMOw
    FzW+qz2OUzGprFMJBiueWJr9l6nXBe+x3tkPhi/2+UD2y7i/rPeJQO5JkD2A
X-ME-Proxy: <xmx:9GPkao2LXVVucAjBIb784qJFH9r6FmKDq6Xp1r1TAfcA1TnwO2IpRg>
    <xmx:9GPkasCW9zntPdw6ZPUi011l6PXl1AyYMi1v1iGfXKTTQTp8ZC1xbw>
    <xmx:9GPkai2bczb23C8kYRA9JshanVU59UMnhZyjYb-cvxzJaBlXEd_hUw>
    <xmx:9GPkausytPugAy9R-t1HRFUtgx30sPnJReDaZDOlkJWsLw-WH8hYpA>
    <xmx:9GPkaskrzlDU4_glcLpJ9CQsq3ypDSioneY9oqWCg_ehIA9wJPWP8HYF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 05:31:31 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 266e3354 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 09:31:29 +0000 (UTC)
Date: Fri, 30 Oct 2026 10:31:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] unpack-trees: hide verify_uptodate()
Message-ID: <auRj7rRyg15WYiFc@pks.im>
References: <xmqqqzh97d2r.fsf@gitster.g>
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
In-Reply-To: <xmqqqzh97d2r.fsf@gitster.g>

On Wed, Oct 28, 2026 at 02:03:08PM -0700, Junio C Hamano wrote:
> 64b1abe962 (merge-recursive: fix overwriting dirty files involved in
> renames, 2018-04-19) made this function available to external callers.
> 
> With the removal of the "recursive" strategy in ad45b327c0
> (merge-recursive.[ch]: thoroughly debug these, 2025-04-08), the last

Heh, this commit message confused me for a second, until I remembered
the discussion that we had around it back then.

> external caller of this function want away.

But history checks out...

> diff --git a/unpack-trees.c b/unpack-trees.c
> index 1802809ad3..3298773490 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -2269,8 +2269,8 @@ static int verify_uptodate_1(const struct cache_entry *ce,
>  	return add_rejected_path(o, error_type, ce->name);
>  }
>  
> -int verify_uptodate(const struct cache_entry *ce,
> -		    struct unpack_trees_options *o)
> +static int verify_uptodate(const struct cache_entry *ce,
> +			   struct unpack_trees_options *o)
>  {
>  	if (!o->skip_sparse_checkout &&
>  	    (ce->ce_flags & CE_SKIP_WORKTREE) &&
> diff --git a/unpack-trees.h b/unpack-trees.h
> index 5867e26e17..638a6b076d 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -123,9 +123,6 @@ enum update_sparsity_result {
>  enum update_sparsity_result update_sparsity(struct unpack_trees_options *options,
>  					    struct pattern_list *pl);
>  
> -int verify_uptodate(const struct cache_entry *ce,
> -		    struct unpack_trees_options *o);
> -

... and the diff looks good. So assuming this compiles and links the
change is obviously correct.

Thanks!

Patrick
