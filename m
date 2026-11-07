Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794092133;
	b=3hCbjVOA2GPY1aCr7j1FOO534JvThM/qARSs1NcXwaaYupkZMZRJ5o/dESjxFUsueBxq
	 ICAlkhWSGL5DimhlPe267wd/P33PFbirL+bfFm20vXCwWxG/QvMG7jC3UL6kWdjknxuS0
	 42RpIR+39vq1j2+Lk7P0reZ4WMxMu+HovUMP1P0saStzu2DTKifuw2jQqSkHrqCwcEynM
	 L5FbyB0F6NtJ1Sip+GiPkOLyj/o+tTShbv/pKn8yKHEz2Gn+qvO6wWSnu/w2FeNMFfDl8
	 WF/I3NbDBlur9+7Na3ygcmNWBpFmKKbaYVz/xzByFyNkQ0xarrMongAQWI6RkVMzlMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794092133;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=3afwAk+mPC8fGwi2IUU7IClQhXH8B14dpHQtp+jeaXg=;
	b=oRdkvm1GlC5Sa86vQjW0MVGt5/u80vHAp8Jlr/GDiC5L5Hv1cbavp2AUxsbeyDLtjXN7
	 VKnQuvD8rP9MQRul6aWpW5jRgECh4OpsEVqpmO80V7mgCZc7aZzIWBBWI/enCbPxtiIS7
	 Y2rlpuY4ZO946cYdyXr7qSjNOGPvad/5N67l0TlPbHIYd/yTp/Y28Sh68eQmmZKAnklxZ
	 xrq6GmXAs0nEpROEqNO8aEbSNB2TPPVUJAGuNodCm2DjFj6KkZDh1Jvon8ZIHGv8ZvRWL
	 bmqROuSEFQAIF9VtBWOYQudZGg3RFd4eAeEo4zjV993j0ttN1o6pa5P73ounYLP6bsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kio17UGF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Oe8p0lnt;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C577606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 22:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C577606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=kio17UGF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Oe8p0lnt
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 61F267A00FD
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 17:55:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Sat, 07 Nov 2026 17:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794092131; x=1794178531; bh=3afwAk+mPC
	8fGwi2IUU7IClQhXH8B14dpHQtp+jeaXg=; b=kio17UGFVhaTw/JY3iEO8c3/6Y
	B5XczLoJnT6CE+1toiMRS229JCHL1f2F8EdlbuRy99eMZor2khJRFmAdvh8TtYt4
	kSeX8uMY9YHRAxt+EosdcVBnCMn5kV3mhRFFwUzst5yrVxYxjFPjxOgq4bQwV6GZ
	mmXmIbxfBbDKklvgfKwWDvrBuMYWiu4EtzUMhcVhRkM/9+FVDZrKXHrSdK2Q34i6
	uyGMmLRaKfq82l9QrKH4B+H9q28F3vVqB4UY+Qix/e7zhN85l6GxiuwGI4oIAx+n
	43Ao2EMBTgo+AA5Tlub1zqRj+thdOaNV4woTYgdHCThQDqwIf9P9WsXaH4QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794092131; x=1794178531; bh=3afwAk+mPC8fGwi2IUU7IClQhXH8B14dpHQ
	tp+jeaXg=; b=Oe8p0lnt+YD19OCZ9ML4+kpq/aHH6qxRXD3VqZYmvScqlpba+3w
	+a71h3TveV/Q3lWjp1prHf4hzNYvuIVZ+YguugVrO+hI9nwu9sLLMmWXmHogYtN9
	7Qc0JZQnUNkk+dey4y+TEDiVXxhT59S3iD0Tygoaq8yIS8jgpwN7KLQEirEMFi91
	0mfG7wUYenBmHJcvJ8M1Ut11JjugtpGAr+SoFI11AxgVtkJ5y6OoZdSL3HvzZBbo
	0L9Noopnp1+280sTOIu2AhVLUxzC0CxvHsf/UwuKi0dr4BbQ7j1CXCOea1gIcjgH
	zXCQo6rWZvC/V0WHhAeYJkaogTGOW+GoD1w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794092131; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NsqveD5GzUq++l5R83/kShMyNB2iUEhZSF3O0BvhA+ywSrw
	mINoWresLELCHY3DpErnt7VZNleCXlE3QjoHsGYElOt8GcR7bVxJsZNhvMwjeQuD
	9GXCAXnpLzN5kLczTgQrYwTDtnpVKj0AMxVug5JtJzv1L2dUvtl4QDnS87NmVG4u
	3FYmdjwOxZmRIsxi76zvZGTdrexFMpNyo7T0TIxQA4K01qelgrG+EbHdrsUoEA2Z
	vP9gQRnDN+eTnmEkHdisR4ImSoDwjerkEkq3WIMmPBBY8JRI2JMtB+BBBGHG+DIw
	AL0eTDCdPQsnUfYcysZ94dDwQVp+ItCqOyloVcA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:J53YATgKgSz691kZWib+8dI3fdCruQJkaDb3X4+HqNw=:p2k1PuV2TNTuMYl/8IA11zgTm7LaSJEcGztVrbMcGjE=;
X-ME-Sender: <xms:Y6zvajwBFcH_LAUQnLqwcniJsEZBSSFaBuWq6AvOcOUKSpYqUie2DQ>
    <xme:Y6zvaiQvjKPRos02ypdZ_U3Vy6XdeohGxm4ck9zX8lPUdu3QSgE7HDAV8jiHyfJI7
    ZXmjvmx9ZYyC5LG3ake8BoQvWg8RAne4gNTQQ9iVgQ555NH9DamEUI>
X-ME-Received: <xmr:Y6zvaiV4JLCwp5_lkjt9D7nNmi_63avTxtNw4VwgFNv79hYuNIH-ZWHbmsHuHaytAyys9i6JG7VIo14SBou6cjg2mDnKnpgVwnf0>
X-ME-Proxy-Cause: dmFkZTEfca8VJMyQhpM3sqB6EX8EPfp8E3vYjw82ahOGaNwMzYLUDUU0oTM6i5gJRTK0ZI
    YyC8y7M1IlLakTvAjNdGUzYPKB5h3SzTtJ1P8KBwPzXu1scrR3vzcLHjxiTu6EeKIEWbpP
    TIBeFPUYyDDQ7Wa2oTv1JUFaWcL34LBqjY3QQomsIMFhYwRAhMDLJuSJDpe0BkzdXBRGQ3
    eGfsB7ujDxE0VabvyVTE8ce7X4txV5zUxtBmmBIIjXWbkooDaM7GVfLsimd7NGL7YmYiZR
    wiaecLacmyhKfyWj7ieWCvQz13rqHwOV1VDpZAvb6ZcHTXUC69MwqxUILzjFgyuJDG+6rM
    2+gtGcQdLDU9JJFV3cW489+jdga2M6gmM/hUgOQWiKp6c6xn03O4hKcdk5pwAOGvtjlpFn
    LcEGK/Va7VgsgMTjycA88qmaE+y2pd2skTtO1a1owSYEgV3g81RpwMU8DiEymksXgnnh1T
    VCUUOeb+PRrYTnlm4GZTMFmNhu+ugfJ1XtRkgSLhy4K+0pzK//KQKiP7wAOlMaXCnvPiE+
    QZqNKsT1l/ksjJ2EwYkQyH2DsBInd4JZiRvTb1nstS2ovpCwE3C1E0bkIloiwRtG0xklWx
    2m6BK9AsThNtjIXKaux4Uf4CJHbYZ3EsX+TLwukcsOnxzhLMAq2VyFYc/bhA
X-ME-Proxy: <xmx:Y6zvasZztHR2XKxbikWYDBTDIIM681A_uvV3KuOq3eOU6DvULaJPEA>
    <xmx:Y6zvag1louzbA0HmwpO9poq_7UN2FEfxltdOpMjQeoGtTGwhzwuKvQ>
    <xmx:Y6zvamgCgWTaV3dIdbW1Pzblmy6hPJfjWhvvlmPUv_lY64U6VgFxIQ>
    <xmx:Y6zvasaJ4qIEZgdPeZ7wMBks6TNcFkdijMIHQO5cQZqDk32qxzds2g>
    <xmx:Y6zvap1evD5KtzUNq9mwa9TA4SOPQj5IK4E8dXqqeWibu1hWIR28xNdo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 17:55:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Subject: Re: [PATCH] partial-clone: document promisor remote fetch ordering
In-Reply-To: <20261107150433.17540-1-husainsitamuwala21@gmail.com> (Hussain
	Sitamouwala's message of "Sat, 7 Nov 2026 15:04:33 +0000")
References: <20261107150433.17540-1-husainsitamuwala21@gmail.com>
Date: Sat, 07 Nov 2026 14:55:29 -0800
Message-ID: <xmqq5wy89rq6.fsf@gitster.g>
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

Hussain Sitamouwala <husainsitamuwala21@gmail.com> writes:

> Document that accepted promisor remotes are tried before other promisor remotes, and that Git falls back to the next remote when a fetch fails.

Hussain, the above line is overly long.  Usual line-length
limitation rules for this mailing list applies (~70 columns).

Hussain, where did this documentation update come from?  What
prompted you to make this update?  Is this documenting a
long-standing existing behaviour?  Is this trying to fill
documentation gap left by more recent behaviour change?  Something
else?

Christian, does the behaviour this patch documents the current one?
How does it relate to 8808e61fd3 (promisor-remote: try accepted
remotes before others in get_direct(), 2026-04-07) which you did?

It seems there are multiple people sending messages with words like
"promisor", "fetch", "order", and "Outreachy" on their "Subject:"
fairly recently, but are you in charge of herding these folks, or is
somebody else helping them?  Without knowing if there is somebody
central coordinating these that I can ask about, it is hard to tell
if these people are making coherent effort to achieve something
worthwhile, or if they are just randomly banging the door.

Thanks.

> Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
> ---
>  Documentation/technical/partial-clone.adoc | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
> index 18718a3840..9720b856ce 100644
> --- a/Documentation/technical/partial-clone.adoc
> +++ b/Documentation/technical/partial-clone.adoc
> @@ -195,7 +195,9 @@ cache servers for fetching missing blobs while continuing to do
>  filtered `git-fetch` commands from the central server.
>  
>  When fetching objects, promisor remotes are tried one after the other
> -until all the objects have been fetched.
> +until all the objects have been fetched. Promisor remotes accepted from a
> +server are tried before other promisor remotes. If a fetch from a remote fails,
> +Git tries the remaining objects from the next remote.
>  
>  Remotes that are considered "promisor" remotes are those specified by
>  the following configuration variables:
