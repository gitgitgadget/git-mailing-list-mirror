Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509065;
	b=WolWbELfn1p0bTEN5qGUoc+jLAzeue83gFirkhzEchdBh3E7L5dBu6sUyTLe7U8ejfSJ
	 9xn/7VVTeuMRr4jX9LLB9GmMBE0oD/K/ZjHm/rg1iiNKye2Do6J/ghHvn5a8RLyl0qOWM
	 mAM6LMPGXH4oMdMzrjo3yre0+Lv3SoSl0LEIY3F+op1z/ypcDdgL+lMOt4rMH/Cszsv1p
	 WqceKYpRMRVPsv9rTffhaiSAWo2ylX4sJVI4jMtrHWPqe89F3CSqcfqDVd0RgWtBEr8gc
	 hrt7GFaigDySLfhUs4YZK25eGTJmOqSVm51oPC/PLxE8URr+GyUqkG6ZRqKnSZwQz1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509065;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3FYWQLDaY7jV5j/W9ked+V9bRHI7hPE2uVY10jT5ix8=;
	b=DCzzAH2qa9nICJ+SCeZ283IFIBIN9rfidSzB1zDf1tpOWKHcHLwpmpy98HmgCZ8snipY
	 WAI+Ygwp40sx4AFIeG3lhHvJU1JA9Rw/72OA8lxBysYV9PLTDE0kwv+rBOP2Tw2j83lmJ
	 6l+r8S/BoXOspdKLuP9huA9Fpj/sPVF/ZYLp4VupJs5UPLvl7+AXiAsW9CiD6u5KQWyYi
	 MnaMik5oOZ/0/l4vDgEFoDCjC/FW5URlQ7K1hd+5gsQy7r8j/ckMBQ+8NKAzvhKiTjvpD
	 0jLIzqzgRqZf0+CpzU1DS+eSNxDbfsihO8KFvGOiZFe0vA+XG0csFR7gdxTEpsBeazA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vXRQvH5E;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bTsucb8S;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5521E606A322
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:11:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5521E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=vXRQvH5E;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=bTsucb8S
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9DBF67A012B
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 11:11:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 20 Oct 2026 11:11:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792509064; x=1792595464; bh=3FYWQLDaY7
	jV5j/W9ked+V9bRHI7hPE2uVY10jT5ix8=; b=vXRQvH5EH9uRx4eZ1+H+BieQbs
	iV43bZuS4C0m2Rk/ZRi/d13HgTegR/z8LYGwWqRAm/pCiR2WVa6+OFgfRAh3qBcD
	dXDnIMNOOX2hUc1xQlL7QwjGyTa9GGC6JPHTP0g+6EHdbKsA76gWkOaYAEj4v3on
	QenCPfgngd9FFm7+BuwCnOtOR16XS1khzy01Aiqjh7SiXVhnwdLJtfpHMO3bc5p3
	OQQTMoTVVdMZyDh1POuewX+A1K3SrJb173w+Su0c/nDfzHJajRPNA0HwrH9bn0EO
	p5jUijjpzhH9sdm6BrF+rOsZJ5CUV3Pf7q5eB294G3oF7nDZdkklZ03tREdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792509064; x=1792595464; bh=3FYWQLDaY7jV5j/W9ked+V9bRHI7hPE2uVY
	10jT5ix8=; b=bTsucb8SwCnYF4mXZPflwFiYss7YRN6jCwZR/dNS+RAFT1SZMZy
	FDdv+7IpoGaMDte34qPBQNIMMoxX/RSadI9iV7bNMEr2M6l7J6YMm2ZHI9B3Stb5
	R90dalhQO6dyARXyTF7aFBz+YLYPOR0vViOaaGAWFOcSTX79C8RMUMt43PGYyMDM
	2/rdkREhV+METtMrFllxnvfRSKTvwpwicD6YuQMHoqO6vw2+TlE4m8FC4wSl1Z4W
	3ihQqc4eAkHdHBJQPZmLzXDOjHBYmPSc5Weea7qzhrfP8qssln1/XDxpzgXx+phl
	m4ukpijIM3tT9dZ+XeIuJYEqb/OXsG8hkFQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792509064; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:pJsyS8Td6u+6RtZG3ySRli4blP/JamuONgg8Hb3O0AdcHik
	rGNQZT+zuuYCzp/Dpj61Lx1UCa6OGdR0sC9tB06z3j1ECPRKtLs0PVFXzfP/0Cmc
	1HsFVdfiKT5d04vAF+lIsQblECk0lBTHBl6a30ip2w2LAjK3Hf7hkdTbu6Ml9Ogd
	cjO0/jTL4cxheqILkbGjZj/7nX65t9dpyYZjlkyydBnk4dmTrJTEKHXwhr5BUin+
	tnGlWlE1IedQrGXQWKdDRsuhsstE+SgN7+r2i5tPjYzgrl0RL+4F6vFr8v7BrJL5
	SdvF/fJw7UtzWiGJ8dfvjcXgRcYUG4QDVajYSww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:2aKEz8AUigKzhR09C2ttMv1KiqByOK/J4/IvRw+dxbY=:WPPDhwkSB3bnOo2Ap8vFpOWAI2kAxzuvAfufHrGQc0w=;
X-ME-Sender: <xms:iITXaqbw33tJ5NwvXYF993F4hfgOlidyoMCZ89lvIp5AaUW4oWgwJQ>
    <xme:iITXakSBw9hMJ0-RHsP8S0wqq5d3rvUCESDdCWSSosOhZWsFOFiTjuiodXRW2Xxfd
    Kc_BdQaWwlMvBLNPso2x8_0YlavTFeI6kucwDEClXIZCnbTycwmdw>
X-ME-Received: <xmr:iITXatS0I7c6YKn3Sh7Cf2fGOOSdJNnV0LMB96d5KaBRJgq_oC7e5iCWAiTbB1jzVILIyg>
X-ME-Proxy-Cause: dmFkZTFcPZ/AHN4GaOWAjSot+8cG+l8Yy8wfE+GEZT/oZz79NGzB6I3d3zoPCKHT1iA5Jd
    RXev5wJeVJS3W3fR5l+TsFOddX9t9ghCVZVc5JAaUfUT1NPRciUvI1N15HynClZNa5xeZ0
    +B19HuklgVRMuCeD3XjpGeAWj8Egkt/b1YnG0hMkLboXV1wvpsJRXyHJHJUU0khwUWzlde
    Rg0fSgmmsaJmUledmGpiKKB5s2Y5RY+9L0GPbwYGjROsXxBLtEqZIrI1pwRg8E26ZjQx5h
    7SyH1g4EHx02f1Y2Ca9piqooI83JQxZr4mWvOvDwfoJbzCo1be/37lZ8QOW35mrQUzweXS
    +vQTC0R/AuNyP6lzpP62IEAeX9DrFjBnGfskj5CQJFkIB6Z3PvrePA49tzJaYTBe4jWOc8
    q2nqWPmBQggKQsneTacLBIS3WSA3GkFD6rQSWqLMWxnpBdtF4q58J0phhrjZ3Qg1PgsZt0
    T3rjOD0NN/Nr4oLQkmy753n5mXf/CVPYYALP4XeypQ8BPC+8SmjstWypw5aZLgv4MsVbmt
    B5wQdAUGt/UYRxfs/8FgA2EZxXVdujInRR7W0wi98HWQvPSRJcLIJ8nnByrmItIAPKrK8q
    s9Q6vQ6o4L5HrSwqeXbfSyj58hC52EAvNk8GbXK4hDVp7UE9nudhDVxsAMeg
X-ME-Proxy: <xmx:iITXaoSgux-gCMIj29wVhHep0Ee_xpp4anHxqPqKShNQKXaKxMVWjQ>
    <xmx:iITXai6t37u38bzEUy9OeSADnIk5g2lFc8theReFj-7CmkGIfJBz7Q>
    <xmx:iITXak1qOIJ3raBoCpNPxevKQqKYuGcgIsSdX1sLGcoypl3Lom9F1w>
    <xmx:iITXatC4uzx7DjTyTNnsJFVyIT4gDuCdEuaYmzYUa4HPH70jhvBl5A>
    <xmx:iITXatrSI2pzyfLYczrt-ShSnKC1uozBtfX_2mqMufhlDz_YNNKoRtJw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 11:11:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8e40e724 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 15:11:01 +0000 (UTC)
Date: Tue, 20 Oct 2026 17:10:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: m@suozzo.co, Matthew Suozzo via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Emily Shaffer <nasamuffin@google.com>
Subject: Re: [PATCH] reftable/record: bound an object record's offset count
 by its length
Message-ID: <ateEgnW-0M0-O-UP@pks.im>
References: <pull.2255.git.1791989883899.gitgitgadget@gmail.com>
 <atXK0ska_v2rFn8W@pks.im>
 <41edbeff828fcb4a2f3bc903802b14e3aa66f46b@suozzo.co>
 <atcKOhm0Kd5XryAg@pks.im>
 <xmqqqzhkxve6.fsf@gitster.g>
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
In-Reply-To: <xmqqqzhkxve6.fsf@gitster.g>

On Tue, Oct 20, 2026 at 08:08:01AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> By the way, I cannot help but wonder what happened to the AI policy
> discussion that the contributors' summit promised we would have
> soon.  Who is organizing it?

I think Emily wanted to kick it off, if I'm not mistaken.

Patrick
