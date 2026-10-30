Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356001;
	b=QKcYYckUUmA0eTd847SetMIcRABfxjJFpUJHaUGcOYiXLo+vhnTQXoZ/+/EFH+fFhPTL
	 6Euf/k4w+kaPWOGbUnEnsDAmT0eHFlNjGWrftaAHLBHAgSW7k2hh7yRdCAxhPBs0bEFwO
	 6IAczSCIrbOG5V7XX27L8AOlXkJ4ZWJRivkYigBNY43mLgqebBjGoipauZ2K74CduykF3
	 9ekuG/zw/Y4gnZ6nXY5xhAUzNP0s9S/UEMb6PAiUBdu9QvbeKiNZJ3mNWUNfZGXt+GPUs
	 szxvU2xj3TNlklW1sTyk+yrFNnsre1tn3Gu10VuFcvDHfV040QQGEu9f8GrzsDq4OTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356001;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WQGrEGREqOhZo5cqoRJWzPntTu6B626/kFqHnS8m7IA=;
	b=wjaEnZw+WkIY1SW7OhcxWzxeS/fBya4X62enN6Bs/4rTqmTKohr2eu31zZ6CUMr/5Bs5
	 adsQtSCpxHtAmpoDUqokbtCh2pzXC1TWUTUSMRRSpeeNwD3i6U8TfpFuzLP2dS6AWv5LO
	 uPcnpoSYbtCHT9rT84fyhJnvyfLbAPoxEAXvs+dOZumxv5UMk3WZUx9j6Zbn7g6AGVWRM
	 787fzNlYMjwpG7Do2EvrQeHb3zgEGgKQs1+GErGycD+ovqMGG5Ma52fht/unC1DYJ4Akh
	 6Bv+2UfHXXfhZQaq9KuflALdAcN1j/pVJH4tFpiy9eEWK+RbwMUB2B5p2CNgvgqjkGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ccHisrad;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Q5TiQavW;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16307606A321
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:26:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16307606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ccHisrad;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Q5TiQavW
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 93D787A0187
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:26:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 30 Oct 2026 06:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793356000; x=1793442400; bh=WQGrEGREqO
	hZo5cqoRJWzPntTu6B626/kFqHnS8m7IA=; b=ccHisrad8g1LPG2IDXy52evKtK
	IK8f8Vo0gxURv2PZBucOxKzYuz8aPMHP2Yozikc1Uq2o8ZJGeh+p29b3yEZnAJfW
	kr8oLFa+pJ4hpLitthSx81KHLFC0HOm59lWODd3aaS0C94UN/EfA/ERqlv+EeLDH
	orBfT1469GRJE+Q6z6jWQCm2mzcnDJIkQPe6p3IH72rh35n3aJulD1Jtqy2EmeXD
	BTqpLarahHk6/fIyd6PoEodekQ2QdOqerdvJfuFqWk6Lj0eeEqcxrKrXHHG1CVGH
	miZWYoNsIT7/MkRGhr+M39Lz0GOljAlRjomWur+8+L4H6kBudvnZw3MvYUaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793356000; x=1793442400; bh=WQGrEGREqOhZo5cqoRJWzPntTu6B626/kFq
	HnS8m7IA=; b=Q5TiQavWkT/ce/3xZrn/QFdfWdAS+9kBxAoVra/BOsRBxS9ua/A
	e4Pm8XBmMmviOBazyJbwi1hb90xD9iTNhA5iS8GWClpRscuIa+iTInznpfrwl1Nw
	d+Uqy10CasuSYZv8YIj/4s3mx8/y1PSxQwbgD+gGXRt7TQDZOJjZnva1U1wUI+P6
	jSzFsLpphctV1qUvv+hIQ3+pPfUOqsIKvcqpjCy6C/YX/i9aszkoKwTeqUqkF6o0
	RE1S4QOUyQcf4eLyqLohc5xZmBjhRz8H9XCvPZ+vs+p92XZGd0zxrdeEYz7j1AMa
	VdaYP49PjFbSdrYjf3OZZBbNrqkcUqaVFsQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793356000; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:CUkcj+DGVFdeKEiD+5BFAFL909weHgzYix7u3mVNcMC5926
	s6hYjoaMMLJuW0SMQ0BVGsqfnchm84Wywf/+sqiqt0fk9nR5zXHEiUabu7rliBKJ
	spv0Ky5rQkliyVi5l4scriJH078q3ltYhBQpE6zgO1m/MOwv2m9JBP5uBV4AcEym
	8obIZp5zd94MTcD2j8P4Kn9zhPGBbWCC7sKuwNgW3C6ni+O+EgcTpk/phQKG6SPS
	X+0y3Pr9y07TwuFGogd1BM29hjcEqxyF1xnTccyPb1D5TyaJxD2uAXSkMssBFLrG
	JIRosd+JH7wsg8wHbulwvXW+1bel9xsDeDPycaA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HbNiPfXIUV46sAuYtau7+znkeu5LoNMxUM5MQog9YJ8=:0kv8JgYQfq1V2bhgcoGpbuksE1wDADXPEPb9ULmpnmQ=;
X-ME-Sender: <xms:4HDkaga4rfAn_iVA11ycmgXw9PXZsZ-yuEj6ojbWar8T-nQQr1vEmg>
    <xme:4HDkahZeaD_Grwn6YZ681C_e1d7yKag08nXmXXi3Da8I5q8Hv_PXSb3O-fCE7NkHX
    _q0o8YIt7rHfnEWn0iQF8gTmyldagQ6PGJYfpXdfcn54w2MU7lWySE>
X-ME-Received: <xmr:4HDkaonJiMie7PtssLYFqGa1ShP3zm74sA22ctSzU5NY9E-4zym2NfpA0pWPZIpRmkvkrg>
X-ME-Proxy-Cause: dmFkZTEDALSQ47Oxc36ay7gq9fxnrQD3pVBABBKufYKDb14Vg92FVwLmWoMmQWXyc02OS+
    K/kDCAD208keqguFgt00RLgu/Yk6HiGzxy4daF+5qXzAlNgI1ZMXeSUmjurn/xgpyyiv8O
    M04RO+SftK5i52/QDCznLeWfqB1F9Qkynnl+PGZR1m1M5OYyJRJtH2fqAGs4renwhMinUs
    tIiJmN7wIMuJLDrdL0CPMd/z1MvFZ7GdjN6X0LTxCbwjRJZAomt/WFdvM4MKZZ4vIdeLAX
    aw4YzMHX24EWiMWEKX7foSK9JlQKRWqlFw4L32oYsS8TczwrKy6Jx+vcs373sK5M9YGLPY
    4YBj60V+s2pxtIC+Pld7OFTx5vCEPQtROUl6NWR9C1mLIquhTNjKBRmvy4mWRN5KvD/1Ma
    qTaqR9e7Hao+uJf4mznC8BGvjlRBH1wTnjW0OUEAFthQ04/gzAz9tKVXQb1dlBIGqo1udW
    e/brQsTT0+rYS9vxgqML8nUvJsHq5F881vi+zjDHi7/hqBZaAbcE0HHoRfXM2s27G8yMD/
    VoHWhtZvmjZcxjXMus6sOeXQlZRNNOh1y8eNd1UE23yVRm6G0X7IGgI9iEz787CAPVvUo6
    sqm6wAZsgDmy7L1CF8hK8p4nIJH2XZpMpxW7cVsjp7KGw2EUDuuVQ9JQtALQ
X-ME-Proxy: <xmx:4HDkalwudQf7UW5_pectCslreNC0cNGX_BglgGdzZFEMxIq8sY3udw>
    <xmx:4HDkauPiIeMYecQOMuIf86WyMHoLXEWca9883nAoq9SyrAn1GD_BNA>
    <xmx:4HDkahR4IchTdCpUl1tzDvY7BiQFrMcYO3lGOqhpemqyvFagw-5jmQ>
    <xmx:4HDkakbLJi4dygrcTNKbaAsILK1r-kH30tx9tFxxGOVLfeR-StNLAQ>
    <xmx:4HDkakpcFl0DRvCPCBKaRTNFLARjPUM91ZO6NSWHzu8KIuUagLNhPDJw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 06:26:39 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dc32be2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 10:26:38 +0000 (UTC)
Date: Fri, 30 Oct 2026 11:26:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Root <rootminus0x1@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [BUG] grep --recurse-submodules <tree> dies on a directory
 inside a submodule
Message-ID: <auRw2yZv6p4MKwNJ@pks.im>
References: <CAMtVYEjWd2XwJpXdk3PV2jbNdoOaqS3x+08EMu5byy55RxfRmA@mail.gmail.com>
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
In-Reply-To: <CAMtVYEjWd2XwJpXdk3PV2jbNdoOaqS3x+08EMu5byy55RxfRmA@mail.gmail.com>

Hi,

On Thu, Oct 29, 2026 at 07:52:07PM +0000, Root wrote:
> Hi,
> 
> Since Git 2.56.0, "git grep --recurse-submodules <pattern> <tree>"
> dies when it reaches a directory inside a submodule:
>     fatal: unable to read tree (<id of that directory's tree>)
> 
> The working-tree form ("git grep --recurse-submodules <pattern>") is
> not affected, and neither is a submodule with no directories. Our CI
> passed the same case on 2.55.0.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> 
>     #!/bin/sh
>     set -e
>     work=$(mktemp -d)
>     cd "$work"
> 
>     git init -q sub
>     mkdir sub/dir
>     echo hello >sub/top
>     echo hello >sub/dir/nested
>     git -C sub add top dir/nested
>     git -C sub -c user.name=t -c user.email=t@t commit -qm sub
> 
>     git init -q super
>     git -C super -c protocol.file.allow=always \
>         submodule --quiet add "$work/sub" sub
>     git -C super -c user.name=t -c user.email=t@t commit -qm super
> 
>     git -C super grep --recurse-submodules -e hello HEAD
> 
> What did you expect to happen? (Expected behavior)
> 
>     HEAD:sub/dir/nested:hello
>     HEAD:sub/top:hello
> 
> What happened instead? (Actual behavior)
> 
>     fatal: unable to read tree (935cff11a11f8734cf4e0d40955d1e0e5c12038e)
> 
> with exit status 128. The id is that of the tree of sub/dir.

indeed, thanks for the report. I've sent patches to fix this via [1].

Thanks!

Patrick

[1]: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
