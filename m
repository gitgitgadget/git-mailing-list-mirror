Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118431;
	b=RO4nZDSY+jfbCfBF1b2jrp7GwE//LR+O6NRLw7LMF9My+Pd4e38uLiHY82JbmEYTNnTd
	 C8M9NA5n+Oxu4wHlYdQDnIuwq9eJ/PamC2PAdMW65sMBhaMgG4Rfuix23xqqJ4ZSUywKM
	 whsOzaNUKN61ATdFYB/AqK0A2BnXwnMDGu27M2vx0zgfHVagszMtGBJGCO+BBN+viqnKx
	 0R9wHq4ea7n7tUQjLYP1N8ru63g0iVLJ+DABMwTgerCgZUpugs3QvxYYC34X34xXtrPKT
	 FAFdbZfb7iSPeOl9koswbXiCMm3Rc/pUZhHlC0t9U03Vsl9XHaCIicvoZKVsBGMRP9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118431;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=u0KTbHWJkKlmKj1Nn4oeA8f2uhenaIzVz10O//O5jQc=;
	b=NZLnKbRFY3I6fjfbn9gqu44573J79GQ97foFSr69aUof+kpxu11q8cZDr/Dat2718g3d
	 LTr8ZMRQ/9JZkjnJOiyMi36v8ZUxKQujdqgU8Tzy0oIro1+kcOQ4eLoEFNL5oGoFdcys+
	 iDcXQsRLuSw15D5RIYcHVhqGbwNaOTZX7eNb4BN7txd2jFzh4Dsy4+Nk73fGmZxsC15kE
	 Dx4ygd6tIslCh/AbD4v2ssRy7XZ1TxU95ZXkXTAvyyGt/lg73VHZo50WjPpCmAOpKwYHj
	 BEVcjZgP2EuhiJw++KPfSppETI3+GoDTpCBGBH0EoApYmM2hGpujH0suUQoaKyQEXxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=GmldPcWz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vPnJWluj;
	arc=none smtp.remote-ip=202.12.124.159
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0C7606A322
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 16:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B0C7606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=GmldPcWz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vPnJWluj
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEE887A016A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 12:27:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 27 Oct 2026 12:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793118429; x=1793204829; bh=u0KTbHWJkK
	lmKj1Nn4oeA8f2uhenaIzVz10O//O5jQc=; b=GmldPcWzRdMFGZBhEmUTQ1z2mi
	RMJf4yk59qhofDaH0NQu0w/vGojRfkodj7WdgDAzzqB1EVODt40ivqEUk8arUPto
	HNH0D6QoZ0QmT+nR95iXy4Y/mr4F0cIUNfwvJnMIgVvV7BBLPBnr343I62cQFvYC
	ofAfpEZoL6F5pBGuk2jSc2ZH9TXHbDy8x68rgYRT151BVsnM7AMK+C3j4xzUPI9t
	X2cR0JmQzrqdcUWMjpJXie+HKIo5MZgm4g9z+3WSowvN3pJnY1DmjkdxEQWM4ZYR
	kHZtSeJwTsUBDPpYh0wxpJ4yeDk31/AiDSCMG2fiSGj0RvbEbhBk/Ldszc4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793118429; x=1793204829; bh=u0KTbHWJkKlmKj1Nn4oeA8f2uhenaIzVz10
	O//O5jQc=; b=vPnJWlujouvPcgSt3bSRaZzEKjgDmOX3coXHv4vC8b6mLqV9UQU
	ELX6nRrLyueB8jOxjNGwI7AvuoHKhy1QYWj3xbiNi55c7JqAd5g+yZg46F9w2Ab8
	py1VMxNtWtaWVqLxk1TskIw8jKa8b2ndNVvtz9lgVrTYGAVKnJei/Dqr7Jj5mbZv
	SEB30eqWVBetjUPcWhy9DFdMsmdzxAYByaN5P6exkGiymElKrhg328niAJdlosCs
	hiee3Yll6QDHYscWpMnbGWQXvev8te6UnDK4noQFeuf0qd5rxpspWHxmmCLFk/qt
	vJ5zVhzkKNbt71T794L+QVTUoZbd2WhdVFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793118429; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:V11AVxHobRBwlDY8BJpFKUqEhr5C4FlIVgWuYfJ96/r4CBS
	sSShoYyF9K42j+xrPfaQoXya9WW04PIsmpH8r8S9B4lNZU/awsgb1y6tn2O13mPx
	DGDdseeJNuEauUvyc351AIoxTk9PrccxGs6ufOtd0Q7VCa2EVKNhZzdBA0JmqDwW
	nrkSiULo58O+TOSkgvA9C5IIvt9Bmv8jFsEYzsjWHietCgBb9fjo29ZXxeFgLHPO
	d09Gy+jd6CS5CmENAONXOxWCG1Bu6kiHSWPF4bX4JbVHV4HVo2hHEt6NbvzPF9Ch
	guNEgYef1agEj1Wc/aEmzdTjW2lUTsG5Ysl2yDQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QQlkRK4ug/MS9ooBSLJw15VgNT8AJKxo7Nr/hQ+FbAA=:+G4UkmB9OLRlIK3D7M6l76Rr0Nq26cyfcDGfaeibSEc=;
X-ME-Sender: <xms:3dDgat_ARQhTNNmpeGzoZ6rA4jJSlD2I6EiPkK7VGzLMuugTJmYJIw>
    <xme:3dDgala6AFjo8I7WI2Ox3NjdjtkvHS4Qm7g1EyiCcKzwE3T1d0ubWxQrXb-I3R26-
    tZc76zqmGNZtsZMPoO08CFDuTiPnrhVGaQ8Q8i3yvAezSg0OMuQyX8>
X-ME-Received: <xmr:3dDgak31w8PKrmfTGYPC9wld0i2PxOm6olgaHhOaBpyG3WmeimYxWSSTMECacYsm55rD7CM0KSgSvQF0PRXQqxo0O3RsHK4qYTGf>
X-ME-Proxy-Cause: dmFkZTF0vPsz8ZOGtpVPHXp0v5nPOpEdNJZwDg0juEJNyUMeAeR9jtfcmYAEXKNy8Xc5n7
    Mw1vjK1eYBCa7zYYt8U7/F7q/CLHnM4kIrkaZA8tFLtxciE1dNhsi7fSJP1vK85egFeOLM
    AhAPVyKm0M0h8DidClvBOxSSXQU+M3wSWwYlRIFm/sRGwSu2fvtY+wLlWK6QdBamCQL5HN
    flsfKWs8BMWnIVk48NhwRUTv3hKLgGHsaquYi31irD9IjxP7hVIJngLVaOXy7nfwz5uJzH
    25jeHB3VYl9xc5SrYd78AHmbcWYx2xy54vNnLNMuV7QlnLy/rIqDbflEFykuyRu+iopEPi
    ZHzgyV0XR9SbQa/rnYlOgLmumm/xUVF7IgHyh0jPLnXGHCGsDcySeNY7ZbwSs8kSo7PEyv
    MccSdY9HhmYk+S+nxxzX+P18vy6fEpRvO9g3TVHcNAcqPTTSG4yTK7f9K6G722bP3oYQ4Z
    w21uak8qRJrrvNYxVxpVVXunao28VYD475leagu/OB6RMUP+VQqZETnGWz8hDT1SNHIVRK
    HtFg3+47ZV4BnN7o/j9RQCsGgztY8XHFqie6GKanueEJaRLCjlrFR1s35PuEZtFaJ0t4Yc
    SAGSxhJzDO31lXXJqiGQWblt/FhJT5IfcdDjqRFTK7Lv22ytzgjwRkfaqeMQ
X-ME-Proxy: <xmx:3dDgaoYPvDV67SdazvxX3gyNAIaqbUTK5hPkYrrwEnf7TFRI2MavcA>
    <xmx:3dDgakLPAsG-cUA0qx3tqVb_89QCkd-lqEOor8v-lXHM6DwpyPfjqQ>
    <xmx:3dDgavGpb5A8sPSRYxvF0_HHrYcmvalb1mft2GGg702cK7-U5te-vA>
    <xmx:3dDgajtYboh1jwdD5bTfaKQ8WHShMMlkkdP5hA5fhPP6xJ-KGoBjTQ>
    <xmx:3dDgauhZLStLL_DVgPfn7Kyln9wn-OwTquXgqEfmRBJWq9nZSGfA5SH->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 12:27:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Pablo Sabater" <pabloosabaterr@gmail.com>
Cc: "Srujith A Poojary via GitGitGadget" <gitgitgadget@gmail.com>,
  <git@vger.kernel.org>,  "Phillip Wood" <phillip.wood123@gmail.com>,
  "Srujith A Poojary" <poojarysrujith@gmail.com>
Subject: Re: [PATCH v7] diff-delta: use safe integer arithmetic
In-Reply-To: <DMFLKY90144W.2W4T9I9V2PEYO@gmail.com> (Pablo Sabater's message
	of "Tue, 27 Oct 2026 11:52:00 +0000")
References: <pull.2276.git.1792727808109.gitgitgadget@gmail.com>
	<pull.2276.v7.git.1793098852493.gitgitgadget@gmail.com>
	<DMFLKY90144W.2W4T9I9V2PEYO@gmail.com>
Date: Tue, 27 Oct 2026 09:27:07 -0700
Message-ID: <xmqqtsm7m7ms.fsf@gitster.g>
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

"Pablo Sabater" <pabloosabaterr@gmail.com> writes:

> On Tue Oct 27, 2026 at 11:00 AM WET, Srujith A Poojary via GitGitGadget wrote:
>> From: Srujith A Poojary <poojarysrujith@gmail.com>
>>
> [snip]
>>
>> For the unpacked index allocation:
>> - sizeof(struct unpacked_index_entry) is exactly 16 bytes on 32-bit systems

"exactly 16 bytes"?  That sounds fishy.

It is implementation defined, a naive expectation is it would be
more common to make it occupy 12 bytes, and we should expect it to
be larger like 16 bytes depending on platforms.

The C standard (e.g., ISO/IEC 9899:1999) has this:

    Within a structure object, the non-bit-field members and the
    units in which bit-fields reside have addresses that increase in
    the order in which they are declared.  A pointer to a structure
    object, suitably converted, points to its initial member (or if
    that member is a bit-field, then to the unit in which it
    resides), and vice versa.  There may be unnamed padding within a
    structure object, but not at its beginning.

For a 32-bit platform, the minimum natural alignment for a 4-byte
unsigned int, unsigned char *, and a pointer to a struct, are all 4
bytes.  However, the standard specifies minimum requirements, not
maximums.  A compiler is entirely free to choose a stricter
alignment (such as 16 bytes) for performance optimization reasons,
e.g., to align for better cache line utilization or vectorization.

I think your math is correct in that the computation for allocation
size would not overflow if we can assume the struct involved is
always 12-byte on 32-bit systems.  That would make this patch
unnecessary (and the patch is unnecessary on 64-bit systems with
wider size_t to begin with).  But we cannot assume the best case.

We could assume sizeof(struct unpacked_index_entry) == 12 on
platforms where we can depend on GCC/Clang's __attribute__((packed))
and C11's <stdalign.h>, but we are not doing that (and I am not sure
if we want to, as these can introduce different portability issues).

Thanks for pointing out the fishy description.


