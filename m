Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478526;
	b=W1xjTPZkw4ITLfTfvpmg/Yip9NZj9c/73FRetWGRrQGkPgotR0QgaQegBp5N7sMgZNOR
	 3uukyEXEc1Dp3Ijj4tPuWNpPE0HWqcc07KaflgR+3sot9qXZ11XIwUHzOmLVCveVgx4sX
	 hFZcOjBkfzhEJTohlpbBMBJgWtheSKp210sIGPBL8/1Z/oncz22MBCKAJxWlowSepoIos
	 EvoQSVcHPMdZGR0MHzZw1lvbEH9579SxOHR1ZHCuKd4FoJ38R8q85g/lEWcRsM2fX9YmS
	 r0XD57hZXMJc2D9bt3N15WJiLQ6IAl/z9jFmPQC/jXtYWmloHxL1Iyfg4B8RmECbSXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478526;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8OfkaH/lVIgy1Gc/3nAeYSdb3Tz1JYWgwgcsq1+Nht0=;
	b=3T68Z8ZOMQUN3CKgwybbFMRWFMOQCpzv3Clu87zv1yS6XYw/ykHnwOBUQ5jouyBzFInW
	 jE8fswfCsLxQ+N3xhCaxwSOSKnS++Z70yRc34ZaIrasKk991HDFip9xM0Y4PxJKKMiNQG
	 TriAIzb0bQE6ny4dyBv8ti5tCynbZy1Ji045l/uiaEIJOUvbvmerLGhrYT9pZAo9gyHnP
	 LIGHpkP1Lq7jp8y5aLm3sD3vaY0BRM/rk23LJ1A3xOoFPbPnwZDA5Ct+nN/SYW8xKKl1N
	 Exrhv9oaIUwImnAUZqTmKdliTN75hHhSU/tm8VzXKXkA6bUIgBfhb76zrhBLCfS885g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=n5C1EaIm;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="vt/wg01x";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3047C606A321
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 06:42:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3047C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=n5C1EaIm;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vt/wg01x
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6B8ED140007D
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 02:42:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 02:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792478525; x=1792564925; bh=8OfkaH/lVI
	gy1Gc/3nAeYSdb3Tz1JYWgwgcsq1+Nht0=; b=n5C1EaImH2ARypBSxo2j3p0Hfa
	oeEIECjagKmrl4Lwn7kjUmgPJwSLQW7imkLmr6YmgNpFaH85H4o7xWzUHGuGKZMR
	1HYF2/QKYLub9ClRYDsZ/CtJ1DxinDcFIYtArpP61kc3W3x3L6ICTHd5fIZVRi+x
	35kqbqhGcOMI19cwujFgqTqc92SSpE0nktDTn7LONfxmewI0E+tAH7q6hYcJT06l
	vG9AhakpjaaQvmkEcNsweVQXRCywaLT0E8ZpTOWeLkd2wlF+dYr0Esn+i5vPE2UV
	HuCRh1PvaF8cSPUdpUAGgts2QqZlU2BVWF+2QTnamK5Jxx75A3ArnczzWXFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792478525; x=1792564925; bh=8OfkaH/lVIgy1Gc/3nAeYSdb3Tz1JYWgwgc
	sq1+Nht0=; b=vt/wg01xG0wZaPYjv7eX/6CxCTmirU+LzG0LfoWPtcVrux81D0o
	niFey0bABKUF2AM6L0MTmhoGW1qqCeOpsxp4YV6vcdTeBFfjFjre9z3r5WizzCqm
	Ls+G16WdM9pmlLw5LgbdaHG7SM8NByT+p2lgQWcQhlnYh0jBSmYJFUI8VWWdCUNx
	6FAeBDLHM1/743nw7f1vPv9ofWITSM9Z2zkvfym6BU6+Fg9ru5TJ/BJ9S17aTr6+
	Udq67CznPzpd48UjeDliKFVPzvOBK/ufT+tPhV6Sp7H2t+R4XGNvX7jyslQt+NZd
	fVoKtUHC9lKZ/M6ZQVkNfIDXJliq+AfTbbw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792478525; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VfNqP15PEdctY98YhX00sT44m5IZ8Z9SdC9PcdpSQ5XVrdn
	dLGD8HTHU7CdMfLqzAo2xg59uAkSNiGp2iSSUDussnOpcOQlypmrOXIW33bxvAAP
	0vOtIYX2kBAKOu2JSvHKt4sY6uZUpCdOdU9H1MlBVJKbBFxHbP5luRAMLfTf6sk6
	uKJtNmUUKD+zWEPxm66Ax2wqCvD2W1Lbw1CPROn83CjqMCIud9knGyrPDKGH+Fvo
	JnHG85IX8AvGhwJMBq0MC6WA38eClKKeXmxoThQaGCOmd8Ve3kfyv32EhkOHISqY
	eD/g1xY6F7oGKnj1WF8vywWt3K2rlKMiIYt3rkQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:E02f8GJYMc1VZ7UfGH7RynNK5+KtwwdVT8BWz9KFr/o=:IPsOQhthybz+TDQOEZktxuN4ZPePK3AektPmZzxO76Y=;
X-ME-Sender: <xms:PQ3XakxCBHPy_rDeO1z41bmiq1fpjovKQOmN4P7lefCccvWW9KPabQ>
    <xme:PQ3Xavt5QoTPCBBm0AyCi5GQ0LrhJmbee3EwJQYQnoZ-7rLfVtJXZ8yr45Z0HSfdf
    QF-JWMC425Kv88n7VgiLBWCgA-zqX7EOhO12Mvyq2zLSmn_rJ7dI_I>
X-ME-Received: <xmr:PQ3Xajt6x1ujqqXzCNBc0adt1K28Mfr75MZTnjw0hcNWiGosUR6wGUiv-OwJqbkUik6jzw>
X-ME-Proxy-Cause: dmFkZTGhfl6yVlHYTNWYvOaZt8NjhbjTNKi+4DbXE3R15yOB4zSy8zFnqa4QadyYlRHOt2
    nGmTWpLGeWiCgOKwM1CdDrQxpxMzPsBTo1FVdw3dyGdP0MYypFEjLhMsAPp+ww4zn+rchL
    ILCdkqlKBWrcEQVg2LU57m4wHmLlXmbnBxiS4xX7OdyK4Y31oEkoWhqFyDN8Yu0vWdQYxf
    ka6xhzOxXnYliVKSj+jc1mDJqCw+FTETXjPM/7aTHTmlE9dkS5MWZ3A5y8UHPKHv/4Z5uP
    UqUiG7mEqwwOR8toSOZoXpU7W6Q6V67E+klSlG1vzWExoFS3wVhuclFCH12NbD4ZU8k2Ti
    lg/NTsPt985uUqRJeEUGARA4oOXIV7w1Mv8XDpvqbop94R4YQxbs94QXvKNscvo0QJVPKr
    b8t1Azec7O88QpC7UQNLPn6ZLkDgnmAWS1Se0RVQqblyEit22Jfmxg3aBXhzeScpmrFNBk
    LM6JJlH3PknFub+r9kJGnHD3/J/WI5jP2BTbek3Kh9ag5QDu9SNsXzc/eSAsj1M5o2UbpF
    QEYN724sVJ3ftyDYNEgheH6ztpAybP/nlMT+LC8lmh5NQveq22VAs+uKFynMb4mqJJwYUA
    ynV5WR4l+61fJC91ht6Mc0JNcex33v71/Dnvv59lIlevQj+t7+G65F++zqYA
X-ME-Proxy: <xmx:PQ3XasOQ7gxRJJPaoa99B1S7um1MC0igYUCIDjGpYJO0PF4QihzFQA>
    <xmx:PQ3Xap1QyM8I8nbKXKSyH_A55RS9JgxagZad94x5vfXPrC463dkxdg>
    <xmx:PQ3XagPiBPJZvjHlEYFo21WXEuqF-Rsf-mfpZdxMbZLibwZ9nIwMEw>
    <xmx:PQ3Xah33udEeQrz60zbJU-U_iFYphnih3ytwlrDGzoD-zpItue_v-Q>
    <xmx:PQ3XavI5wBbEkJy7xoq6ey-zK0MARPcwIhskTEo8yfmPluZBcVyuW-Rp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 02:42:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 90b5852b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 06:42:03 +0000 (UTC)
Date: Tue, 20 Oct 2026 08:42:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Andy Koppe <andy.koppe@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3] refs/files: keep root refs out of loose ref cache
Message-ID: <atcNOMxaz2WxDIA1@pks.im>
References: <20261014153208.2194727-1-andy.koppe@gmail.com>
 <20261019203427.2637569-1-andy.koppe@gmail.com>
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
In-Reply-To: <20261019203427.2637569-1-andy.koppe@gmail.com>

On Mon, Oct 19, 2026 at 09:34:20PM +0100, Andy Koppe wrote:
> With the files backend, root refs such as HEAD or ORIG_HEAD are only
> added to the loose ref cache if REFS_FOR_EACH_INCLUDE_ROOT_REFS is
> passed when the cache is created. If the cache has already been created
> for an earlier ref iterator, root refs are silently omitted. Conversely,
> once they have been added, any later iterator also yields them, whether
> or not they were requested. This has been the case since d0f00c1ac1
> (refs: introduce `refs_for_each_include_root_refs()`, 2024-02-23).
> 
> For example, `git for-each-ref --include-root-refs --merged=main` omits
> root refs that are merged into main, because looking up the given commit
> loads the replace refs, which populates the loose ref cache first. The
> reftable backend is not affected, as it filters root refs for each
> iterator rather than caching them.
> 
> Fix this by keeping the root refs out of the loose ref cache. Instead,
> read them into a separate, temporary ref cache whenever an iterator is
> requested with REFS_FOR_EACH_INCLUDE_ROOT_REFS, and overlay an iterator
> over that cache on the loose ref iterator. The cache is freed along with
> the iterator.
> 
> Alternatively, the root refs could always be added to the loose ref
> cache and skipped during iteration unless requested. But that would mean
> reading them in every command that uses the loose ref cache, even though
> only two call sites actually request them. Also, keeping the root ref
> cache for reuse by later iterators is not worthwhile, because those two
> call sites only request the root refs once per command.

Thanks for spelling out alternative implementations and why we didn't
use them.

> Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
> ---
> Changes from v1:
> - Amend commit message for clarity and to discuss alternatives.
> - Move new create_root_ref_cache() below get_loose_ref_cache() because
>   its comment references the loose ref cache and because it makes for
>   a cleaner diff. Tighten up the comment.
> 
> Changes from v2:
> - Drop fixes to documentation of REFS_FOR_EACH_INCLUDE_ROOT_REFS and
>   --include-root-refs added in v2. I'll create a separate patch with
>   those as well as other fixes for outdated uses of "pseudoref".
> 
> The range diff shows the changes from v1, because they're of more
> interest than dropping the documentation changes I'd added in v2.

Thanks for this. By the way, I would recommend to have a look at b4,
which handles all of the bookkeeping for you.

In any case, this patch looks good to me. Thanks!

Patrick
