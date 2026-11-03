Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793739414;
	b=HMfUGqJDihJQBaRSEiZtTkEpDGE2LiIvQlT1+QGcuUr/2PC0V/DwNTsn22Ps07v60sPH
	 pBy4fPVT73Df+6lzjh7q2jAYSlNvNmyJmeNgv+TM5zMyNfF3ULfCaIDxOPJoaD0wWBix0
	 jLhXRRWyBzMfA22RJ+Efwu8trDAkXvQDNyIH7KiFC2SR7ezWMXGrS3qgUnXKWvx8+32Ny
	 nO8r/qyhFRv43+sPoQ4zOQhnvz/fU/vkOlFdd/C72cnyTiaWAmOY4iRgucJnjEKD6xcjd
	 Iccl7lHvJD8Y4kNt4cHG8ha2NU+1wyjtf5RtNYghjijUCiu/spDUG5lZxu9hcy9ip7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739414;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=OVYdG3LVuDv4pCXDn8ZjmnRe6wfUyxWK5q7vq2FIwqE=;
	b=oT8rs+/PqB8YojNDxq0FvYmaszme2Yj9WjJW/8RdOHuKJ5n0qm/7EnUtMmsjxRwqjpV7
	 LfIO8rK7a6lN9hAGxVWSgvujijLzHtfkdC1uE5Z+oFaBklLlPFscLVXVL6uGc/lGLLVYE
	 KYeVyhWZSTCvp9xrN1EpYiyJcziWQzt1rJGF43PsJ0UotfjoZUn2iQKhL+vK6jYvx2lkt
	 fMGHt/VAkXNyiFeVQQ90/VL4K3BjCWOo9DbQAt2mStiuX8MDD89zF9dVxA63YqdQoqe+N
	 4eJ6PZqtqRL/Nnlx9Ns1uOkamYWjcMT7j7mf0GHcsgc3OdN9ipAu/2E8v+KkS87wTEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=c0vyM96e;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A72687HG;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F60606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 20:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0F60606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=c0vyM96e;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=A72687HG
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D3D2140011C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 15:56:53 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Tue, 03 Nov 2026 15:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793739413; x=1793825813; bh=OVYdG3LVuD
	v4pCXDn8ZjmnRe6wfUyxWK5q7vq2FIwqE=; b=c0vyM96eEIpi66qxddT5OLWDYr
	Kb1w0rtdX0+DBq9nk2UjoJWdw1hV05fxoP4qaWBQfueOWgVaU0H9xOTkOgBZKpPp
	c1f+uMqoWuvYiHf/4VhoexWxy8Nptad/mPiMysFHw/kKgFVJKKCbeQukdfLHA5bt
	o9vd54a/iyk2x7y0fTwHJG3FH3Yqx57VzBWeZuao7fKFPQCTI1pWhZgWQ7FFqgZp
	VE7u41y7FFWWjNnqv4yED/rjbLIjUmD3W3GRTgI87zKPo9YttlQUcMrMkRxxOGGy
	9uck0gEHrlyBlQ+KrDq4R1cBIOGeislx89XlJe8eodzVTpcu1c/N/yb7PAVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793739413; x=1793825813; bh=OVYdG3LVuDv4pCXDn8ZjmnRe6wfUyxWK5q7
	vq2FIwqE=; b=A72687HGkzXddDbaKooyoh2YycEAcJnd+HIhAweaq4DjrrE+X5g
	kV+ZJynBMZCvdBSPfD7YmdPzsDFoic/iQaImCjA6xNyT02mmUKYZ/3gJs84Pxm1C
	TU45apEaj9zEfgD/FE9jPtzeVJY1G9T4GIj7hBsvKPyCEbCt4ykqXuOvO5z7bxVe
	YwrGjIgrsA76SRXpoRy/LaXSK1/Sffp/iMsi9lE1YL1IcFDCikN/wcWpVS937esZ
	dtvsE8KboljvCQ4VW4B4wZLmcnaqn3VHQ8xDfsC19vdLqp8jBWdZd4d8FiZKmq9x
	tuFA3oKKrIbAtSLA1xLD4cEXRupgvWlKz1g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793739413; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:GULBP4D0qBBZvGSUYiSs4MkqQQ5vEqWKsXpkDfTzuRVP7In
	Q2nRqWXexYigQAOZRRNSklJpPx+jTAuyQuMtjWT2xSEp8353UglySmANWzoKCzED
	et6SLPUvAHKOUlnhj7bvlvIMmaYHiKG+yGNLM4lJnXcSDANPmQb6fMs2tyhk8OBj
	k5tIL8atEGhGtZegfxDRGgqXkFht7DTxFfIqXIarKkYoVXsEbm6fqd+0YYiaSbOi
	B+nSvNVLlObBGtkZV2GvjEzh6zuRTN35qxRorxT0/V51TjTu0o6ZA1QAHUHnJG7m
	pNcqhgeuMEPxI5sv6ItUoi6NUursP85seAuT4Ew==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HvlPoCawEiqaZp6ui395fRj66xKOCFLSt4CR9fyXBMg=:cWut87cxo8B0WOov4qOO5D/Qgmp3K73YycVpjh0nZG8=;
X-ME-Sender: <xms:lErqarxaHwT4DQFxT9_VRajOEZ20sqrCPiwZmgSOtwwHCmcoYX-q3g>
    <xme:lErqaliO_JisOntzpBvLwIHzqcgOeWQEbVAUd73um3bcfGiRmebiPahachPFzrsUz
    Bft4pgs5E7q3t3dmP3ZKsU3FW_-pjDSnL1i_7d2z8QKarPMgdGkbmY>
X-ME-Received: <xmr:lErqanmHz3_g2ut_KTeFxkxjYhJYr6yPXCf6OHC8p5FGyCGH-tklUI5uOOgn0eT1aw9i1H6IOUn0CADExeN_GCAVL_PkshzXvRU9>
X-ME-Proxy-Cause: dmFkZTGJaGQCBFqeWerzY2MtmaMvFTPCT/POApJqUw5nNkE6/K8vppVkCuyymgKzBovPua
    wvIyQsIk5K2yA6alCf91X2lglQ0V/AfCckD3DO4yj18SVzcgL529Ns0rNohutZxDT4Kvs9
    tbG9k0Ksd4AHw9snqoldsZzjQP0/utR+8pJSoFdCqxJExv+JPX+3ZBAkpFQWMeBIUgyYCQ
    2WQuZwuC/oNiNPCJyZm9AhXrbb9I5BXJlg9cfjyODXKveTiwXTbdbviH12Mb6J0BSZ4v1E
    AyF3tUbgMAosmE3to7eqHXpY8CGIp/o7fCKiaozKl/Z1BDe1y/UX0q8UcyTxn2UEVQ8GLH
    yBsPZ/oHRBo0TiU1VQh3rTy73nEB8EMt5e68aoOK0DlWnhZCfCXot0oDsHtKX26VsqwaxK
    gVR8hySuPZT6XPJ84OhdHXUDI51L8+fnYBJmvxUoWFbIP/pdtj8tDLX4mYNgO2w/90fuTM
    liK1U0U7a2TRfB01ABBxlu3dVi1uF2lxe2tIcikBBBLG9mqprzbItXcFI9Wtich1KSRKCW
    S4NPudjAfjXbj/55aEeHZfEJLd/RGsZ8sJ0q9pCo7vukY8N6p6H1X7shbLJw5+03SSgtir
    nCz/lsQ6iUgIPtEaXK60/2ffE5t6a+DbvG9iSVwVZv8wXzzZqIy+1KxQJ+LQ
X-ME-Proxy: <xmx:lErqarjSTj_jj-eYBPXoH9yiK2vjFAKbOV2VGtVUBAv2Ct3WZ2M4XA>
    <xmx:lErqar3cNd9f6cKPhckmjoP8oBVlSceeFuLyccbPXu3RQcX96RExqA>
    <xmx:lErqakIqyiQu6BJ4r7umQRHqA0kfDnB5ACEuIR9GWiY3uWeb0-KS0w>
    <xmx:lErqarylvfCwhxat-iMeIS18SDv_iMCyUcxWM9zz5Iq9IlYaO7dVlw>
    <xmx:lUrqakht3Qdil3eB5crDpu98qQla3gVmWf6IdqE8t51PikJouxrl2GbJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 15:56:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>,
  Patrick Steinhardt <ps@pks.im>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Ravi Mistry <rmistry@google.com>
Subject: Re: [PATCH v2 3/4] http: add http.retryStatusCodes config option
In-Reply-To: <6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1793732247.git.gitgitgadget@gmail.com>
	(Ravi Mistry via GitGitGadget's message of "Tue, 03 Nov 2026 18:57:26
	+0000")
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
	<pull.2287.v2.git.1793732247.gitgitgadget@gmail.com>
	<6510dddc39ca61fe1ae2f81cb8e7febd5f82d5ca.1793732247.git.gitgitgadget@gmail.com>
Date: Tue, 03 Nov 2026 12:56:51 -0800
Message-ID: <xmqqik2d63cc.fsf@gitster.g>
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

"Ravi Mistry via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  http.retryAfter::
>  	Initial wait time in seconds before retrying when a server returns
> -	HTTP 429 (Too Many Requests) without a Retry-After header.
> +	a retryable HTTP status code without a Retry-After header. The
> +	set of retryable status codes is configured by
> +	`http.retryStatusCodes`, which includes only HTTP 429 (Too Many
> +	Requests) by default.

I as a lazy person would probably have written

	... when a server returns a retryable HTTP status code (see
	`http.retryStatusCodes`) without a Retry-After header.

and omitted everything else, but this is better by being more self
contained ;-).

Looking good.

By the way, after the dust settles, we should fix the formatting of
these variable name entries wholesale.  Looking at a few files in
the same directory, like log.adoc and grep.adoc:

    $ git grep -h '^[^ ]*::$' Documentation/config/{log,grep}.adoc
    `grep.lineNumber`::
    `grep.column`::
    `grep.patternType`::
    `grep.extendedRegexp`::
    `grep.threads`::
    `grep.fullName`::
    `grep.fallbackToNoIndex`::
    `log.abbrevCommit`::
    `log.date`::
    `log.decorate`::
    `log.initialDecorationSet`::
    `log.excludeDecoration`::
    `log.diffMerges`::
    `log.follow`::
    `log.graphColors`::
    `log.graphIndent`::
    `log.showRoot`::
    `log.showSignature`::
    `log.mailmap`::

these names are supposed to be marked up in certain ways, but none
in this file is.

Anyway, the whole series was a pleasant read.  Thanks.
