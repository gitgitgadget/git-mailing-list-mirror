Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374255;
	b=ICSDZvKzF5HViwUO1JxLzNN4swM5Hc3duWqu1UyKpsmMgW8n6gLjramG7aQSl/7Cjvln
	 bBQpOMEymiBjflZnabUwd5bI7BYGsoGZ38WAcBTTnuxJLQ46py2c2hANBD7DY7ngcQ+7t
	 2IyWKRa76kKjmZTfAXi1o3xyGkS04z1DUvIdMopwM28UhM4doF65E2Tx9W2oJ8dGQHTzn
	 heZYayvKaj5cPlpuj4iKS8t/+CbRV1pXUtwly8LKYsL2EduR0DFzA6P49utKN0wMLLklS
	 Hgc8QThLmzwa6h5AAvMxkmxb5I6YVEEyS4ER/XuVXtCFbnBVaNxj2HqffWRTGSVtSAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374255;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=n5jm7HL6HHCsJOfYjy2QBKao09aJs2/DBh7VOXmlB8g=;
	b=fmVwiSeh/cCEjdeVlT7Dz+JKvMd1eHm2XReb1lzQaa5LhuFSin4fQIo6ckbdhuQ20KgV
	 tmZ+cbDIFGHna3OiN1NzXDEb9N7z8Wa4bOEXJqEiARH38g5QUVyTnE3E7tRVNNhG93dvg
	 yTS9/2fxWvx2qN/nEGOlJDs0C3+uxLcg3nkwPq3PJ7/7z2C93/CMas1XPEzm8C/NW2niG
	 PDsMQSf4TbqzUlnjidbxplz3ZHpexpFxb9doLx+uG7mClAsQChonY9ix5E/I1FlgkeAxj
	 AUWaMJu+IhnZgFkppdf75lcnFgBhNwaqcgpw8HdL68WgS4Ch4z5GPckaas7rqmx1Anw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C146VkKO;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="km4yv6c/";
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7215606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 19:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7215606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=C146VkKO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=km4yv6c/
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A5E3814002EE
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 14:04:13 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sun, 22 Nov 2026 14:04:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795374253; x=1795460653; bh=n5jm7HL6HH
	CsJOfYjy2QBKao09aJs2/DBh7VOXmlB8g=; b=C146VkKOhISoChbMBF52HAxlZH
	q6qO0JzXWdchJwVhCMxioXD8ImZXlZGhF62IOK7hTCx8+aQ+t08kVc4fwbAhL6yl
	I6SyvJGc8m5TSeCmRsCPgejmpfdn4dgnKLIL7eP0jmaQE4aXXnWmTFysrF2KvyAo
	obPQM/P4SE8jhUEmtfrIySqcKA84JNQ/bQWJeWj5YgtxrGOAg4rCam9dF8uq/tTo
	dibTFDSLYjkHPZgdAr3+98/y3I/7ByyhjcqHZHUwPwQxxAGjA1ZafqB5+Ck+N3ui
	q5ZwyEq4STaVXAuKPPkS7Xiq6jox7xKh9PlqLJtfIGaDa2nyRHqOrCIq0qQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795374253; x=1795460653; bh=n5jm7HL6HHCsJOfYjy2QBKao09aJs2/DBh7
	VOXmlB8g=; b=km4yv6c/frRtYFvF42g2HSkO5QwJJ9cnp5d+ptb1kBRQrfYXUhp
	AZk5diBHUDjrQxT7Kwu+cneZ/whaSp/pT41NjAbtsw8XChU4+boD4KTOoLg0dO0L
	IjUxc8hsb3aPqu3qxNHB4PTOThKJ0aEJZiDzmgiv5RXlCsw3yH2VYH5+YXmpRza4
	Rnk3lIlu+I0b54hRAwh7jIAAZkgpChAWR9SEHDNGmvq+Xt4N3MvaVF9Btbm4IGLg
	MfpudeID7/zlUuQethVRLtS337FW6JDYrVmXJZ1x6ehw71Lw/2WZmHe9OVeUU4Hf
	znkysTHOj3TaZqRhdB339jmfGc3q7erkcIQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795374253; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XVALXFQ+qQi5F/pJQYVGMxQIm0TdSTpN7+rb42tCfBl7ohG
	B/JpdotfVgx5tsys2MAb80Q/jq/xqnd1pmB0hm+3G+E6k0U7irQqNCVMHo7GClBu
	1wkGWbXqR9IDqxdaVuH7XLh9LCyQcY2VRAbEIKPOhH6leZoo4QJqOAXJc+Qo5vey
	342lo8wtkTR3tHgS8KDbbyI/k527cEYjR1DbO2lLLBM6oufw7Z+xBdO1S2ZaLb+I
	JjDc/eCU0RrlhwmPNB0g72ZipNfgh+yHNuJ1F6OUHK39vyi66jwk+DJeIIXCdoV5
	36dFe2lBeigF14qNHoMIQ6kTzoSkgjQa+ZzfX3g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:byGcTw+ft8SMqfv7eC5FtLtZmaeqo9iCDqN8u5go+Tk=:Vh+aYtGaBJasbowRXOcQ0/TRbjLGAuBub0xbsA12e0Y=;
X-ME-Sender: <xms:rTwDa6jSzhoAYzBs-QayH3lP9Bcaj7SE0ZlwwAu3Re1ggGI-J38KaQ>
    <xme:rTwDa9SlAB1yZuKBJ366IWX82XQvncj47yr5hL09xEhb5vo_p0eQnfRh_BfI3C5DM
    fgOZqv2crDIfHOS1f2bWe1KAQZUgIfaEzErdVcRsfFOyj0Uwf3pNQ>
X-ME-Received: <xmr:rTwDa0Xv9pBUnMSU6AzpJO3zs4lVAGDKS5i8kgWI4f7_IdAb7YibXzKofWxjvpz2UymnxMhYHzYx0FbwH6O7SYXhsRWiTqoBIEO1XQY>
X-ME-Proxy-Cause: dmFkZTER8pZN3yGxq5m7ko+nG+CYw7wMqLsCmOA8u/JjQfAtQXqDL75cZ1Tg2mDLK1r74P
    DtlwBt08ZhEuWTWWtGZkBCiXCb+FaKR8QVZqlhiog/hFb+f2ptYQpd1R6HMoaCkB+BvT1M
    +n/SbRQUv+S7xXoZSe5ZF9PWNmAdgrnws14UK0DMjozYPSjiMU39IMyssQU1+j8djwj/7d
    Ps3ydhmaw+CKpUxQyEPHdLbB2bL0DABKr3WBB3b+CbI5LlrSyj502Ne4entR4KHWjQXYKP
    hwG8odrc7qG7MMl2C7iCalT9QLTv1W5lKadzDXSlPoP8nwZ7rP7FIx0X+kSlaEcoq8kFSK
    3c3/v2i5f8isxP0IXj5k1Ld1D2ShhtIqCTKbzslLTBHNYiRw6iNom9RBsrHk+bsci2Yt7V
    D4AqaroKHnhmmEbafugu7uagB9rx4sZtkjEugJ12d0XuVRMcNjXE0UpyjlHtptivIiEl+F
    go197y5FUZizgTgqt7UTNVOuCHC9il5x4DqS2wW8YsbeU50bnXlEjWQqGspr5VjMN3nzyU
    p6a5aWanO1Fe/fdDTUcGP9b12rjYoyJ6AJ1boVdKCn0McShDDrW2svLB10GooI5F5o6S8t
    JQSbR6l7cz3Cmz03DNq2jsuwcYoJ5G2jFnQbM3n0CF3i8EnhlJgNE7vfFluw
X-ME-Proxy: <xmx:rTwDa5RMZ4ybkJRQWxb9tFYXwi2kpFdz5u8pxHfnAitomo3ABlr05g>
    <xmx:rTwDa2ln7c60sU4iP1xoua51xumjAyO907JiJ6F69u4_2i4_YatDPA>
    <xmx:rTwDa369Fhu8eZV3UnaStF9ShQOoawZnZwpzM0DX64CD5u0xCo-GuQ>
    <xmx:rTwDa0g-8F6hjJQEHN0RyOxj1ZTMFMWDNqQhjrggEglr4_2_yD1qeA>
    <xmx:rTwDa15Y4NydxaJc21lJNJNhoHMsAv49SfHfC54RAubTha81-kzOGFxx>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Nov 2026 14:04:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Cc: git@vger.kernel.org,
  Patrick Steinhardt <ps@pks.im>,
  Adrian Ratiu <adrian.ratiu@collabora.com>,
  Jacob Keller <jacob.keller@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] submodule: make '^/' work like '../' but with an
 absolute path
In-Reply-To: <xmqq1p9550ic.fsf@gitster.g> (Junio C. Hamano's message of "Sat,
	31 Oct 2026 08:54:19 -0700")
References: <20260929185122.3127574-1-lightofmysoul@gmail.com>
	<xmqqmrrzkppq.fsf@gitster.g>
	<20261030150739.3855910-1-lightofmysoul@gmail.com>
	<xmqq1p9550ic.fsf@gitster.g>
Date: Sun, 22 Nov 2026 11:04:11 -0800
Message-ID: <xmqqzev0k7ro.fsf@gitster.g>
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

Junio C Hamano <gitster@pobox.com> writes:

> Stanislav Aleksandrov <lightofmysoul@gmail.com> writes:
>
>> Thanks for fixing the test number. The t7428 squash looks good to me,
>> please squash it in.
>
> I'll keep them separate, as the fix-up will become unnecessary as
> long as you remember the need for it when the patch leaves RFC
> status; the test number crashing would not be the only thing that
> needs fixing, I presume.

The thread went dark after this exchange.  Re-reading the main
thread of the review conversation, Jacob's review [*] does sound
like a strong enough endorsement that thought the design issues
through, so I am inclined to say I can do the proposed squash and
mark the topic as ready for 'next'.

Please holler if any heavy submodule users (I do not qualify myself)
find the new behaviour problematic before I merge the topic down.

Thanks.


[Reference]

 * https://lore.kernel.org/git/CA+P7+xo8J_+3QECoGHnN1AxXPpjaKaHp3VoN9EEcyhZ+Q1fzew@mail.gmail.com/
