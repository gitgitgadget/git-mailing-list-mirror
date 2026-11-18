Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795008862;
	b=hPIVUvnrlS667XiqBQy++CVjkYn+orhSJ9k8xXPw4Mm7F4NFG4Caf9IUBwyu4M+C++C3
	 6QYLtuiWSXQRQaP0dkXr+/+hNbjWjkXsywwjuS67g2XPTxRF7OwTojl5hE1I8K5xeLy1g
	 ul/yD0Us7q35wgn0cCBqKUv827ebhewdgTQ1QWbE8F2yCGtHleJ/T8W9OD52+tm50wV3l
	 fh3f55mm0oAuPpmWKYfoVD+Loiv3RRB7H0mRbm2KcW92QYnrB0kCnMFsl3aiJ+MOfCFM1
	 SMcUNlpasSFkWYaB4/n5SHnames8hlSVTucGF8NFAjtEujJFkWfobzWJRumxAXTpMLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795008862;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OlxVjSEc0ysdjM1+Qb9jR4U65IIUwARNOKCKqH1qyNc=;
	b=F664jUWxXCBjWty8CWzuaavJvVoOckZ7mqhKkTv69HIUTr852PcRP6fctYswna6wQVqZ
	 HLBTrIl40o6EZWCSTj4cgFZrG+QFa0hANfOTeJQVyFHGIR84ioXUDAKlK5pHAwIFC2OFi
	 CDxwAw/O9N9AK0UXaCklqaeh/tHWYIr9N95Ube2KXls0SVfsGtJ8qPdn3krJAm7jkrlgj
	 EKRR4Z4dtB9bjRfDeNy/tIZ9Vyfahhyk1iStPsc35YWI6SFQYC0V/d8lO0r2ZgQq3Z9gR
	 0iUlqV4y9XW0hPsX2K0zGyhOi3f0w+ppGjB7FgPOCvdwp5SBAwF+6HpnEbfGmTArjGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=HwPcxXkS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RKE6z47a;
	arc=none smtp.remote-ip=103.168.172.151
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A04606A31C
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 13:34:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88A04606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=HwPcxXkS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=RKE6z47a
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id ACE0AEC0AFC
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 08:34:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 18 Nov 2026 08:34:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795008860; x=1795095260; bh=OlxVjSEc0y
	sdjM1+Qb9jR4U65IIUwARNOKCKqH1qyNc=; b=HwPcxXkS21V7j7JWC7IqHLSAZK
	1FS47QtozDtQT697vZ5E97oTtWSahHN6mDaqqFKjunYWRmdlMAUI2oLExGVmqcwB
	Y1DHi35JLT8Mk8xBybPlZOath7TxXRuKCOt1b2Bx/t96HSUab/vAkvMOIeiv0iWZ
	+zOwiNeQe35ymBmgMVaE1SixUZKuejCSBbKWEi1bgbgwoW510ejLAYl5cMdhs63p
	87a7S9kQzBeJ2FS+YcMUvzOv5RcgPEwXh5z7xq9U9TkmxEqOaVFD9TVcBm5ZUfnH
	DWpL8AnfxauwrQwTV1HkvmeUdfZ9Krck07CxbZsqe0VQ5/YrUHTuc9DkVCMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795008860; x=1795095260; bh=OlxVjSEc0ysdjM1+Qb9jR4U65IIUwARNOKC
	KqH1qyNc=; b=RKE6z47aC9aGPySY2p1yplm8kxX/tRtdAb80VTjGe9wqj+mz7+j
	dHvP0erzeatmiuua7IHJfXs4qL3JZNNY8OBBK0QAAvRW3ane5WtLTosF7Y6V+24P
	rAuU1cj7S72APwpgUSHwIP/6UFtjKLvyyBmj7nNSNbfHhfHsFHvWI2iPv+xV7Wef
	3ts9yv2WTURW5+0tj+j72JXGXlM55jdocbS8q2K/gcW1tuxiXYmq7DX5GHwC2hwK
	Ir4WsYtyTl5Bs3CiUvB4QCaB/GtYpPMq5QceW8G+bsMYk/FyeR9GZkSs8ZSXtVqe
	sdDf2WTYfztXFCJUhpowSI0Wy0YfmS5MXvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795008860; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:qX6xgcTqkwdS5mPB+X4QgtmTzcnNL9O+cn5gV+3TbbsJk8Q
	7QBkfdOt9pbI4Nni/V3CdKmsFgDcco6Ot5WAbyvrmAipGBpFjfxjcme3NJOpB/Fo
	w6cLGgKs6dXV6PQjodeM4dP/Vgbl7xAhZvu7jaiFaO1/bxcBvw4zpzLpudfTcUqv
	OapSd+/gxkAI1AIL/8wpwb/FBawNWmVLHoe3YnKArNe28E9QH5K1o/m+hP7k47QS
	F0cnHhh6kA4M2/Z6tg6chK4Z4PwF1uJjZcCAKCRxPGxjLk6gxWRoIzzOJUOFZopD
	C3QvaNc6PWxuzz9xQM46BniylJ3RR6jHitOXLzQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:xJ4UXKXEC6R+IA2QLxPZd5wKSrstdqUfYekZYJnluWk=:bms4Pe/a116+gY9mCVZ4+PIgGTG/LthRzOBWGZPMH+0=;
X-ME-Sender: <xms:XKn9aoHNw4RhjddI_isR-V7xq-IQuQT3u7OnXsf-AUFQFeehqL0fmg>
    <xme:XKn9aoUmGyYqgGyJ40XcTDz9I2bYM_ZK5Z7kgHfp4IOfg6o0_DZZztgEhuO4nVAPA
    0mDxjBEOdWbKQIaWXBBdp9LSCyoEslGL40Ml6C6-0DLoedmR7jz8Oc>
X-ME-Received: <xmr:XKn9anLysOQJ4Z1KMuxZh4AJ2jH0GHnCIzxxpjMK8qevsAYG79qFfQ>
X-ME-Proxy-Cause: dmFkZTEgTsuhisWZmYjrbuQ4SCyQyxag2aCt8bCu96jXYNdl55eUAcekosj00e3WCQ111W
    zYRvgN77rCqEk9B1lZhz8ORjtgRug+jhVqc9YzVX6I4pFVXYZ6996zGbgwRj1t9V0lfXzA
    aOcMgLbZ5tUZVt2duk/4Hos1+iyxQt8xEqST26G6R2kQi8QXvyTq0WOfIIfxrWN2m6QgVA
    B1BHFuXhbXQvpwo9qhqjx0HgvFVrjVT+++s65KJU8cE5hb7JIIsE18jyjfuFaPvi55MRH4
    tCWbBCgD7XfQusZfzJ4yhEzNmVyMYH1CSYfamlUjzp6Rl4Suk/JWjSPaPZfV8Mmq4ICRRu
    Ow+l1oYgS9gYf/sXlCkqEjA0FhbEFaZe/cWcqLuq4Dn0x7voWadehi/7KETtg/PPkYstZJ
    kUtSiMV7AYexXzMh7icwnmU51kqJaP7pk0mR3FaWtyNtSb9VKBOah31ZfKk+19A1ORhDnb
    r2QKRbBz2pUeTVedMnYmsOe+tEWaSeL32VVNDh0126DJcTOyFYaZUSeZG3/+yOouYS3O2J
    EHWA+CGsxUJdTuJboK43KYXVOp5y7/ipfLUVXdHSERNH+kkAEw2+KkMzPAJMJaFD1AGNx0
    wxs/MPsO/8rf7bG5ycd2dwCmRwOqgWeQSXHiAGEWnPH23pZpv6EH466CnSAA
X-ME-Proxy: <xmx:XKn9ao-0YY-WZdCP69fcomJAkxCGb4WahvlZLW44P4VFvvVq8-1kGw>
    <xmx:XKn9aqKQ5_dvYVf98MtbNpuwzja0NU6V59MWQmTmVZSuYJiZIuex1w>
    <xmx:XKn9atlueLkTXOjLyLxxOHJOgVuz2yvAKqVRBX8OucOtlGv1pEMbIw>
    <xmx:XKn9auM71RFFZo3FqddpZIW8-9MI0KDw7kq523_SdRJHx3RhSAdL-w>
    <xmx:XKn9akiUnL0d2rNp8quTfh2fRyMKv75bglG9zIzBeaUXg-_2V6ZyFyad>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 08:34:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f5d7ea90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Nov 2026 13:34:18 +0000 (UTC)
Date: Wed, 18 Nov 2026 14:34:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elia Pinto <gitter.spiros@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] pack-check: use size_t for the size passed to
 verify callbacks
Message-ID: <av2pUyAwTA7e2eOj@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
 <cover.1794984184.git.gitter.spiros@gmail.com>
 <00939c7f1b144fb9dbbc1745e60f7baa18217742.1794984184.git.gitter.spiros@gmail.com>
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
In-Reply-To: <00939c7f1b144fb9dbbc1745e60f7baa18217742.1794984184.git.gitter.spiros@gmail.com>

On Wed, Nov 18, 2026 at 07:56:38AM +0100, Elia Pinto wrote:
> verify_pack() in pack-check.c passes each object to a verify_fn callback
> (defined in pack.h) taking the object size as an "unsigned long", even
> though pack-check already handles it as a size_t. This signature is also
> replicated in struct odb_fsck_options (odb.h) and implemented by
> fsck_obj_buffer() in builtin/fsck.c.
> 
> On platforms where "long" is 32 bits while size_t is 64, such as
> 64-bit Windows, running "git fsck" on packs with objects of 4GiB or
> more passes a truncated size to fsck_obj_buffer(), causing
> parse_object_buffer() and fsck_object() to inspect only a prefix.

The more interesting question to me is: if they only inspect a prefix,
do they actually notice that something is off and report the error? If
not that certainly sounds like a bug to me.

Patrick
