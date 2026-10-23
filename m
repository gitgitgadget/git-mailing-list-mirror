Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797240;
	b=zxppa3cg8W448M/MNAAIY8Rt0PnluOLLpFzItTWbt8ePNhH8qYps9l1bPjAXwLJRD1Mt
	 vmSGKQcicYaAULPfJCgtJ6TMWHMdeOSsqb279SxM/zl6I/iIq9a7K2Dsf2+n9e+KYFY6N
	 1pE3Me06zpRFo2Gip3VYMPEBz9EwBFH2IyG6v8UfX0JteyXfK291S8Yfb3Q0GJZkBSXQv
	 vCLasj/NWemVBSEJEKAqOcPgbClX7NWY4QLcxLXN6hbtReG1PLTxm0LXI7BGyReqRBbNs
	 9jdaFOgbuo4NDqo2JT0NtZxWlzs7Ev8LIenpAd/p+yQJAcyrMk5VemRKCbW2+Mt35mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797240;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=eIg3ZTPJS3Yxcrtwu4cnMMZqXDqoR8VwZS46mu556Zs=;
	b=PzKxFH2isbG900EjkoRSUxKau3xLV//Njwmh6VMvPrZ5LcwVSnlvn6gvFNsBjPFEoiDc
	 h2XUoeLP6SVcNAF3TBmyEk7ibPaCjEXw70PnUEZl3wPNNVHL8gq2TnVSVeiSe7DQeW66z
	 xXfy092nQv6zubI4C1b1p+vkJWtWBt2EIkZ0W9vlz/h0H+vxz9FhtvL5F+QHvchd1cvlo
	 XiIQg2f7NLLN8xfmzde9mpv4Lbo8BlPB0lX9gbkW/V2+XZC4tExH+vaqK/jkg2ipB+zgy
	 GEk+2Dx2CHTSOwKK3dNf72GoQAVg6rOeW0LmttaL4EmMK1iHAykf9v0qmPJ1NjqV/dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=FwIiHGbY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=K4RHutg7;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9F5606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 23:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E9F5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=FwIiHGbY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=K4RHutg7
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E6F6F1D00082
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 19:13:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 23 Oct 2026 19:13:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792797238; x=1792883638; bh=eIg3ZTPJS3
	Yxcrtwu4cnMMZqXDqoR8VwZS46mu556Zs=; b=FwIiHGbYIpfk+Ks0W12kCvu5BD
	az2xK4nmi7a8RmuOHDhxEupzDi/CevFMMSdno4acRMpGpjpaiI5GZZ0ZGvH+0BWw
	Hz/0fsks8A2P9/gKQSsgQpY2bXNlw+l1zylDsrnzGpUUAZrhM1kdb8trA5g+PfIN
	4SgXTd8ciQ1b2E7U7BxWk8ybPFlixNfOM3DZNyyOAt7x1SmZ9Te4l2cV7aDXKe3h
	JF90Sp32aZVIVVPOI5A9y4nSF27j+WtuS1K/9DQcwsicPu275D0ipOOPWZsRxPi5
	vtxflo9CY4Ndz6PvNF6Ps1iNrgDLITZV4ObH9YxDLHlP3vcr0eP822rooE1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792797238; x=1792883638; bh=eIg3ZTPJS3Yxcrtwu4cnMMZqXDqoR8VwZS4
	6mu556Zs=; b=K4RHutg7dSH/8CvvZs1GfZ+G3kyyWMnkxCIrCXFbMpfGCBygEpU
	ZPYuz63iZcNq7LarWzlFRq1ltGI4ZJAqlCBPmuUq81Bzf41pHmzipybwqzR4kJon
	kW8AHhtRguW26geV63i2LvZVTTiAG5KtS0qGOb8p86TUzlwDwgkux3yEP9XoAx4j
	/H0upT/B3utLdO6bvGIBzqHGx+SutzJti2HW3gDPtqxsfPUVI+YYqLya4SHmsQ2P
	vgfN7UJAbFEXP2uONLQvepYkRuDYhAGr//QFWwDmxThbu3eQ5JQ0If4Cq1FhIdxl
	IPVAGZyKjQFapPHp4VpgMYXKWgZyXikj+Cw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792797238; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ILgAdYiaRfGGYfn7xqoLhFudBLJ45AH6eXEp+BAqTw6dLNk
	qtoWkSUcFCOWK+6l3J34e4RYy2KqeSqNGgySI0TlTQhwrgi9MeCJZM+UXNEbHx5F
	pxTq8ChbNAiWcF7Wp6vWesPyuFW4VHlGm+cdP+icxE6xxe4lTXwv+UQJphIkH9l4
	i2AMknpiKLgCz7siviS0bZT4DAbELHHItgaNThZMSo8xHhlB9ikULbp2YrsSKnDA
	rDet5I7SnX2jAuBInTi/B5zXfSMiVviCQtfuYXiOqRrrZEPgEutDmoXsJZ4+0UNQ
	Lq5385AE/oM2WivhkGbqiFLX2VN85/w5Rf9UnQw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:zL0fPqsqlmlPEt2ihzMWUqn1Lo8uf8bikL9E9do5xDg=:Jvwq8sgz4oV23ujHd2py0O6S4J30a6Ez5f634Ip42Og=;
X-ME-Sender: <xms:NurbalS9KGXXBdS91l2vNVASHSf5cV7QYF8d-oH8aq8_A58rOHiFDQ>
    <xme:NurbaidWUwV-4GwEcyx3TM8M6o9pguxeGX_QjParqkFxg_ow5etFImvhwzlVxzSug
    gyri8yEtqGT8t7vWGmhP1ifMFHhjAXKLv39JRD7e2Bcs3HsMKYSRA>
X-ME-Received: <xmr:NurbakoTmqryoqdKnd4T8WTKi4siXcJ11ru6HW5xD8fYD7nHFu3yLo97YJ4iZLkLCzg02VXThSfdMogDgq9L7Jxj7-94D4sM1iOk>
X-ME-Proxy-Cause: dmFkZTEGIIhU9SSPblpXVFrGA5/m7DJHenRylX+vLUSP49FR257p9UV6680N4uyH8eoqTv
    0GjRVSMLqIh+HkLRLRw1BMOjqmmxWr6QVpIK3AO01sg9/iYJTl4G02YJwbKbuPLBDA2ysG
    TDvWKAp8KhJZMnG9WB/StwjvFwLy327HVn6ept8xOZaMRUad/JO527lcEbAVP/7jJwZPn/
    ZMYw7w7gvTJh4JIGCkcAXONjDqHxNAbSyxZhluyiodyfDsIS5r5iPEtCuM7LnUI4F1dNOW
    SLon+aadVUou/l4BKOntHD7HNODK5R78mGvZnOkfmqBhXEo/43DB1SMLKcJDP4W9h/3si8
    1JtS8eGuFm2rLRppU2kTl1U1EDzuvVDKbifM3KFDv0F+gUyPBJB4KBwaADuBpO/Epz0rJy
    aMvhU9qM9kvRbxtZItBMkIIkgDVFx4n1Oa8Ly1/NgbNpmMw10Tn4e5gQ1P80oAw1qDeTRr
    NHLH3m8+ro4w8/e+6G0WBrsbJLASQcf1r6e7iKQiuN+/Sg93dlwzEjijMZI5WLyxv64Jwm
    F5kCMrR9u+PuOQe+G370i9C9nHoj+7tV7Chexjf/EGrpV2AqJju/8dym1pA4sOdj6mJgXZ
    n9pzOp9UvHFSrQlq6uowbIk+vuZEtDPb7ICJKJPx3Ay7Jg/txcF7snHcNgoQ
X-ME-Proxy: <xmx:Nurbaj8iFOkYd1Clmz9rgIVLQvn3-Fv4ji-VXhqtKg84TUNYEsFhRA>
    <xmx:Nurbagf-4O4_xw0PrLNOd-UfaFw0fPxX3K6SzchVSeJ1AFny-osOWw>
    <xmx:NurbatKRqql3zwXeu0dL6mkxoDCtj39Xu8j9Q1Ddpb2VN8joCHWF7Q>
    <xmx:Nurbagg5QxR_KBOU3fgYwKJHowM9N43SU6FA8ks4LC9sWL-nqvN06Q>
    <xmx:Nurbau3QKjeyTVSyxnXxI-C8rZqpZzpYX4SWN8owZMmYvmKuQRpVyfq4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 19:13:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>,  Phillip
 Wood <phillip.wood123@gmail.com>,  "D. Ben Knoble" <ben.knoble@gmail.com>,
  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v10 0/5] fetch: avoid fetching every branch of a new
 remote in a shallow repo
In-Reply-To: <pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Tue, 20 Oct 2026 13:42:53
	+0000")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
Date: Fri, 23 Oct 2026 16:13:57 -0700
Message-ID: <xmqqcxt02eoa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Avoid fetching every branch of a new remote in a shallow repo.
>
> Changes in v10:
>
>  * Resolve merge conflict after master integrated
>    ch/fetch-followremotehead-lazy-validation.

> Harald Nordgren (5):
>   fetch: add remote.<name>.refmap
>   fetch: extract collect_upstream_from_remote() helper
>   fetch: infer branches to fetch from a refmap-only remote
>   remote: add "git remote add --limited-fetch"
>   remote: default to --limited-fetch in a shallow repository
>
>  Documentation/config/remote.adoc |   8 +++
>  Documentation/fetch-options.adoc |   5 ++
>  Documentation/git-remote.adoc    |  14 +++-
>  builtin/fetch.c                  |  92 ++++++++++++++++++++----
>  builtin/remote.c                 |  31 ++++++--
>  remote.c                         |  51 ++++++++++++-
>  remote.h                         |  19 +++++
>  t/meson.build                    |   1 +
>  t/t5505-remote.sh                |  76 ++++++++++++++++++++
>  t/t5510-fetch.sh                 |  63 ++++++++++++++++
>  t/t5586-fetch-refmap.sh          | 119 +++++++++++++++++++++++++++++++
>  11 files changed, 456 insertions(+), 23 deletions(-)
>  create mode 100755 t/t5586-fetch-refmap.sh

This topic seeems fairly well done, without seeing any additional
comments in the last two rounds, but I am highly disturbed that I
was practically the only person who reviewd its later iterations.
Because I am not a target audience of the feature, I would not be
surprised if I am missing something large.

I would very much appreciate if somebody else can give the series
one more read and Ack them, so that we can move it forward.

Thanks.
