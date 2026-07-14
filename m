Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC93C1F
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990827; cv=none; b=BTz3vpWFx5UVSYRT1OEB9eOz952scUnq7zdp9HGEtnIs+XXLGCChecFLZ/226NnCJ2+bTHqBcDGKMB4TWYgvKhruB/yl3JYqnK6KgReSRJXLSxlQfjARIlmMFbYMW+OhhNA+FHTGCjzLt7bHxrdYtdiFl5ZfDJNA2UDAtZnQS/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990827; c=relaxed/simple;
	bh=8a5HLrKTomoPPpR1R5LRKjPRWyaiM1H2y8UDdJ6w8x0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fJVZte/XHVtcHnpyz6nWWSStcnMYUP+0UjDDlDlNlW+uwS1AuXRk/mqmC1tNvLkNm//WGVybb2itwkg/C6XNG7uyWSgugRROMb+O68CjGtdAkrzxWL4ucpsrDBA1xPUNAV5cMDLa5rTFbSNJhd4svpOIH1EmQ7eXEtBABWG52Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=t/VsbxQG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Jr+lMu1L; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="t/VsbxQG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jr+lMu1L"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0339D7A0158;
	Mon, 13 Jul 2026 21:00:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 13 Jul 2026 21:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783990823; x=1784077223; bh=43Ew/P1oVp
	etwCKHZxWqjg30w8bWD8pSxxTNCtj1CVM=; b=t/VsbxQGRrZ/0nniUgZUHbZPHt
	aAaJ5rV1u1AdWYkZBu8w9AVuRAdr6GPnypdhSAdkrZkZvyuLGOCQqAAsWcoeZJp+
	MXuPN/k3IvR/0Kc6gEjoj42eMWg0eIjcp8iv7rjoTVBp/jU0muCCjQwz1qURC2PE
	Q1VtA1f20YBsWqEh4HNmSRiBH3RT01E4Q8gDCKOOSGXJc3ZnaJ7HUIYnd06TR52+
	ZNfSq7IOxfFUeNjXILhTzIRFhKArB4n5BrGPuWuHwsTphVURrAfzopUvseiE10kp
	h/80/TMukHGEqmTOjeiPQuvQgSk7mYcNLqE5k+DyJRwbhkIeL7TTyFVblWlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783990823; x=1784077223; bh=43Ew/P1oVpetwCKHZxWqjg30w8bWD8pSxxT
	NCtj1CVM=; b=Jr+lMu1LwwmkyzVQfutopP2FtRj9N58AdmRr0LoOGDt1PTBnB8J
	iLbVu89NH2hlGt+U16QlKlFRjjTgeZ93K6BATfpXXeGchibndPIXIdf3/H9Jn4wh
	FXpHZ5vj2l0hTHi7DK7M7j3e88W2uKXeHVn9vJNCi3GM1EqkMASo5cUinPyM8IJv
	RZHxMO5QPuCuokhOsPA9t4upjZ0DyYbEuLqcQwRaZdwMihoT9qvaJkN6oBLNpkLV
	Neik04/a9DI+cP1vGC8jSGRw+i9NThNEnA9+S5KOcqb8aK2tYckZ9X1+FM7Hv9cw
	w2VmGDpiGFlAvmRJDO0ZO5i9nw2GcfCWbow==
X-ME-Sender: <xms:J4pVapU4KJN34AoCQ6itj4idI527zy19q-WTDTqfDknOfWwwY0zcxQ>
    <xme:J4pVasLVBV08KMkP2yzTfiOK7iw8-b0wJEe45ajqz6GQXeBoqi46CXruzWzf44VCJ
    OobqP3v2x_a2zyCHywv0NMS9RzxT2JoPTDMmimEal5Z8vR24FsMvyQ>
X-ME-Received: <xmr:J4pVapAkfqsccnIvaQJQPV6-uyYGtSRwyok8E5xMw0jrMxds7mq_B9rpFmG7En3QjE9ZipFu2cuhsxT_fAzN9jFdxSLJKYBcTMKNZPA>
X-ME-Proxy-Cause: dmFkZTFj9FpmbEJ1h8aF1yoRSaHLpI1qZsmQyl2tPPmHn4J/+PnO/gWUp2bgL/ZPFgbctw
    bHgkPluPRV9TVwTsxdYBUWL916Dv5QnQzDpaGRsNg9IftgJ8wPlHBJ9lMaMUCG+vH4jine
    PS8A65THbY1SyiJXTDQgA3qGZTfTxLdQPn0UJZBaMBOzMXaLn4zLFiVxtuZk4fFkcm7Vom
    hfzTjPyiW38sdDXXWqdL7+M+S87FyF0st97wlhBDIuE1bQxfl76qzjnTFwcKtcSIO6DaUs
    wuksxvqanLD+mto5RAi3Foz/gviHUyzk8yuWBptmYP1vxQ+QZDDtEgbCrA3LhmeITKXsiQ
    YwmzoG8Q9ib3Vhr8CwXo0jMlqhwejSZWCHzW94IxVydSN/kn1cQZ7vp2rOYCvk7VSMzdZu
    1OGufB2oNs6uqcI1h1KguL8nJo8Z2vMIzNyUAeT3HQwSEYgKR5AFaI/GktWhqqKJWRpxUs
    RXkFNx6OjCNr/XDjdtaI+Wm13/C22OYlzl+jJyC8/5Wp7IdfjKHotFoqTQT+VhLzPCp+Qk
    kbxGL4QCghBOMcm4HpXm2iUmSSa9lUTIhp1i9JI0Hnvyq0ZCUVTmsAVy+krVKK2criY1K8
    jvu52dCoQ3y7WALFa4asdk/AGrX1llz24qDpP6s78H9HwZmkX9q1gGLYWBwg
X-ME-Proxy: <xmx:J4pVasem2_u6J2OUijw1d01IxNZye5tNaEcyEiVRNeiXP1H4FkfB9w>
    <xmx:J4pVao38UGfVCqCHuedILaXwyJTt5bhuAWnDsypf8RflTO6Eu7boYQ>
    <xmx:J4pVajjs_-ksy8COSlL7jG09NI8zB8gRCmr61Il3sDNyPAwTy8HstA>
    <xmx:J4pVahng2KwYn_8gIP3-O2no7p0E0AoJrnDNsbdDAimjLBN4m-js2g>
    <xmx:J4pVakqMtuJvPZbbwFUvbM6CFFM4qkuVbp4qU7Oa7F7zgMEehMULmoUg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 21:00:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Jeff King
 <peff@peff.net>,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?=
 Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH 1/2] http: use unique tempfiles for packfile URI downloads
In-Reply-To: <alVn-QmK3K91_tkH@com-76773> (Ted Nyman's message of "Mon, 13 Jul
	2026 15:34:33 -0700")
References: <cover.1783982021.git.tnyman@openai.com>
	<alVn-QmK3K91_tkH@com-76773>
Date: Mon, 13 Jul 2026 18:00:21 -0700
Message-ID: <xmqqse5mv10a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ted Nyman <tnyman@openai.com> writes:

> Since 8d5d2a34df (http-fetch: support fetching packfiles by URL,
> 2020-06-10), packfile URI downloads have been staged at
> objects/pack/pack-<hash>.pack.temp.
>
> The path is derived from the advertised pack hash. Two processes
> fetching the same pack into a shared object database therefore open the
> same file for append. Their writes can corrupt the temporary pack. If
> one process arrives after the other has completed the download, it may
> instead try to resume at EOF, which some HTTP servers reject with 416.
>
> Use the tempfile API to give direct packfile URI downloads unique
> temporary files. Keep the deterministic path for ordinary dumb HTTP
> pack requests, which use it to resume a partial download left by an
> earlier invocation.
>
> This means that a packfile URI download cannot be resumed by a later
> invocation. A retry starts with an empty temporary file instead.

While that does sound like a safe and correct approach, stepping
back briefly, would it not be wasteful for the second process to
download the same packfile that the first has already started
downloading?

Are there better ways for these processes to coordinate with each
other?  Instead of appending to the file, what if the second process
uses a predictable temporary name (which we already use) to open a
new file with O_CREAT | O_EXCL to avoid this redundant work?  If the
open call fails because the file already exists, the second process
can detect that another process is active and wait for it to finish
rather than initiating its own network request.

Doing so might require setting up a trigger or polling mechanism to
wait for the first process's download to complete (and detecting if
the other process dies without cleaning up), though that may open a
can of worms.

