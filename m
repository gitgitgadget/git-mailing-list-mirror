Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795569246;
	b=TEdX3MX1wqK0NysvxoxhUTTwgNeHSvsAyny7pcuZRt6AkLlfGOCE0nqjRrFDwl6blU2K
	 6zvy89xGv6IlJpl+woInXhbHFk/LlnqhfJayBTVsY8h8kvYMcmiHMXKuP5tcWdWacyx/P
	 PXrCtuKKUGwrkDrjoDBmX93/dEhC8Gv6dQAGqro0unG3UB2bdip6c3xebM98mRFKH8jjy
	 ms5WgVbpqbZRYhDXsUuovlhQTczozDDFsKN2bReURGe5MwCDvVhKiVMmObc0C/jcBXy0O
	 KFCAETK1G9mhzkxULxTzqIR6OAr0APl8CrKI8fe0nB3rSr0d31Q8DrX4IQoxME6WBGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569246;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=YMyIjwpLB6YmjMXZqOxxbvju4479AgrmJLr3KakVKEc=;
	b=RnjoIRsUfSXJ0Wo2SaoRN2bUb4tmFb7pJP3iLO6HwVFCeLdmPUezW1qTnZqpobYdn4gh
	 1zi/4vf21b9WtxCuHaDvBJbD8qSnAmCwgZj0T5t3ig9x/KYGvvpE1mdZmfbBc2huCqUnB
	 yGnUejmB5kUMVjnyZR3vImFiAqCoHU8qnTyaSbwvxrzYz/qcWoELplBi59+wRKnS65N5z
	 UBJih2dBT1mQb+/Wzsg8xMLDMvFaKEE6Q7CgvElfG6J7Lf5H3sTjYrzfRC3+vFXAvfocW
	 e6WTge+roA0SpT6wcVQVpEdXJDfCMeUFjHCd1jyHapybFhn5gvvO/TP3cd8AP9F0v+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TDqBeR6p;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a7TIouhj;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27C4606A31E
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 01:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A27C4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=TDqBeR6p;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=a7TIouhj
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EA7027A05FE
	for <git@vger.kernel.org>; Tue, 24 Nov 2026 20:14:04 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Nov 2026 20:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795569244; x=1795655644; bh=YMyIjwpLB6
	YmjMXZqOxxbvju4479AgrmJLr3KakVKEc=; b=TDqBeR6p+uEsLrIEl4k2LqjADC
	0o2N+lqQYh3l/aVJDDPevsPIxsCgLD4ifiGzRJuGAHMvxjHujMEiLb6XNo4Dntf8
	bLxYJrWZGD7K+HAoPMGKjenbc8J+dmDEPUiEKcwSHdczvHWAayskKU2u6iISZlDh
	9Oii9/E9xF14/vL+bbMjyaFHU8pO9WBqO1A/zhRqVj3G2rNzShVU+XY4xpKnKFae
	xEqhvgveXs8MwDavCtDPmoI16GNOjYLD3zTjga/OKLGAz87wg+SXOgQPyP5yhgjt
	t7HMNoe238XckEAzorbSL4Njdc+IAklO8OW2Wpu0cO2cDv3oDdVeFeW1e3+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795569244; x=1795655644; bh=YMyIjwpLB6YmjMXZqOxxbvju4479AgrmJLr
	3KakVKEc=; b=a7TIouhjDsF//BJb/LnNsuCzbhD+YaTl3lFGX7s3ZhElbMsk35v
	dmb/5ytbm4zEKBVYFdtQvdK1VQqjmo5boaHQjl2+qwilWrG0ikajZtydJ4/WJ0ox
	q3F4686m77mS1ZhSCYxog/oOYlt/Y/xLXMektc3DitkxF3iucXxLPw9i9t5Vudqd
	s1qqMox3gL/DlG93m8IX+YzMXepc++Axu5A6OEdiDMcrwyw8N6lTs+02W9Pq4o+m
	NH3OCmHOyyqj8hlg9Hr6R/AoEF44tdnmCgKIFV3rtvHEjIi5VxhkJFSiEH+DfHMx
	jfBmVwIjwetcmQTVYFFyaipvSYdSHRxIOjQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795569244; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:dgBJTTlXypZGSa03DtD/Bzxhxd0rcjaPXhZvNEUWObbAMwL
	c4j8JKwQ5y161itaHEqsyj10F+S6cm9SSRk23SWAky/I4vTnRJNe7G9z/vz03W/G
	OB3V/YHRjqh0uR3LZ6TPIh1mmmdYjzJYHJcP7/lNHdfcDR6YzbDahfgrMgYg/1UR
	EvtQD8JNPskWtTry5zgEfYazv1YIIoCyp1uDNYmnq6yJ58QRvm7ixUWtdbQnMsa5
	21CaO6ME1FrjyK/Dxd5cisPABonB2y+gdmgz+yBT55Yy2LzUB8RrhtGE/aA+BLBn
	e6PGRCns0HY60ZSFaIHHoeKnU3znCqAzXA9tT+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:lbePyIO7uQNbQbwJoVqCmbx8LjagvmMGQUfBYi3N1gQ=:TFE5QIuNmt/qPMr8nUEtQ8DJzAeWz2g3QSCKIm+iixs=;
X-ME-Sender: <xms:XDYGa1OkzH2AiL7NuFpwAVp7yuYIb_3QYh1CfhUgVuWHw2-zriRpTg>
    <xme:XDYGa3CEsXC3TQj_CRs58LUAZI6vwMoE0bVtBGrZVVuNzui3J0TjzgeAcH6f9pjTC
    1DN12HcNwtihJjplDdPq-mlJuRyjlkdGApoTC1ETFgy1sskhJNH>
X-ME-Received: <xmr:XDYGa6fBXkPcZZnnVWicR4jQGw7Bj5rPl4wW4ySOMr-7nU2hiYuzSgPCdW0Sy29j59ZmwfFeEiwRd-pXXwxSP48tS9A0GZF_fCC7K7Q>
X-ME-Proxy-Cause: dmFkZTGm5PgUrLVxo9gt8Zn/5D0rpe+ZbtNu/OEKhqB/WPDqXWXAs6nJFgMQG5s8ztICet
    P3dFvYrV+3UmpOELrOCUPQ7abgI64P+aX053OYWYwinGdGGSYOGYhWHYfEm9Z6nMbAuNLo
    B+jqDbbxJo9N4kuFErrRQync0etkch6NNgqJCandf1iYCCu1ZStIUSmpANveFYtOzCUKe5
    lFIDTPNdmF8bZzthXuwuaIg2vSwzXBlI6pQ9r4Tk+vCuOxdU/4TtjugSRxZS+UGwmfraY/
    oXwBu9yd5hPbEU/q8LtdsSKif68ALS+j5GVLUcRgwN5DtJg5jE/J59ZxukSDFYI234gYkc
    JfjJmkVDpNlODnnNSvx1CH7eMrCgAbpOCvRzDpCHLAa0ojlCxwPTNmuuotgq9Ic4RCz+0w
    i+/XUnOBl0wzkKMj7waoEMbviknl62QIUtZ3t2UsjG4dzD6VgpNjeCSK94W2cj0qxtEEO5
    3DfT8+1HmTWp2q0vmhDGKswAZFECWUo1b0GLM12JCf54qGCtcUNY4YWJ9ryQwMBEBYrTjV
    oDWummCNj4X61ZNrd9wtDOHBn5P6wlHcRgRnfODnRmZb6Au6cDTJDpStFXyiOQUrYXu8ZE
    lPptgIiKvc7gb0638FfhP3yAIAUcLuAyBuKk1q9ksG3QQgGNHedYvYUQANCg
X-ME-Proxy: <xmx:XDYGa-ObMZ4GaG7b9oU_3Ae2qUy5nynOAJCFZfG3h3HFpboY_Xenew>
    <xmx:XDYGayLgr6QhNCm-H2fImCsSjjunRagFnxm6agw0nC2HUE7qrTm4yg>
    <xmx:XDYGa2L4UB4qUBI0j3hIqYLRKYmt1amDvk3ktQ1wYUWwsrPpaZhrVg>
    <xmx:XDYGa04evSDBWVqf_Cfy6_Cz9PrcaZoYtWv64GSEIZG0Kuj4rqqMYg>
    <xmx:XDYGa0uynje7rvckI839VrSXqbbVzDz4fsnxiAtobz4ndsBu-WC3v9wP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Nov 2026 20:14:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  ps@pks.im,
  usmanakinyemi202@gmail.com,  siddharthasthana31@gmail.com,
  kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v2 0/5] notes: start passing the repository through
 notes.[ch]
In-Reply-To: <20261124172146.18330-1-okhuomonajayi54@gmail.com> (Okhuomon
	Ajayi's message of "Tue, 24 Nov 2026 18:21:41 +0100")
References: <20261105203344.48513-1-okhuomonajayi54@gmail.com>
	<20261124172146.18330-1-okhuomonajayi54@gmail.com>
Date: Tue, 24 Nov 2026 17:14:02 -0800
Message-ID: <xmqqld6hg1b9.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> This is a preparatory series. It makes the code in notes.[c,h] and its
> direct callers work on the repository stored in struct notes_tree instead
> of the_repository. It deliberately does not convert the whole notes
> subsystem yet; it does the bulk of the work in notes.[c,h] and leaves the
> rest for future series.

Framing this as a preparatory series and splitting out the remaining
work makes the scope very clear.

> What is left for future series:
>  - notes.c: the display-notes code keeps its state in globals, and log,
>    format-patch, diff-tree and format-rev are given a repository but do
>    not pass it on. format_note() still falls back to the global
>    default_notes_tree, and expand_loose_notes_ref() only takes a strbuf.
>    The hash-size helpers are also still on the global.
>  - notes-utils.[c,h]: still use the_repository. And the hash-size helpers
>    still on the global are reached from here, through create_notes_commit()
>    -> write_notes_tree(), so converting notes-utils is tied to converting
>    those helpers too.
>  - notes-merge.[c,h]: still work on the global repository.

It seems taht notes-cache.c also still uses the_repository in
notes_cache_match_validity(), notes_cache_write(), notes_cache_get(),
and notes_cache_put(), even though notes_cache_init() now passes its
repository parameter to notes_tree_init().

Apart from the NULL check needed in copy_note() on patch 3, the series
looks in good shape.

