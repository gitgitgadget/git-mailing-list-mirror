Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792522969;
	b=rVXvvRcfVNOa//vGOg9YP990i7ngoFLUkqnCBjszA4sJwrVVBurRi4wuqnR2if/QNOTT
	 nZWop35Nnuri/HZEcSuMN3ycXExkj2WL0fwtI+cZpF3q8bu4+0U3PrIjMiCRdSjG1ULsh
	 OfwvT6kFMM6ac7vE2KN4JG4IrlV3dIfXkyLIkk0ggzdw7lopyj+apJdOavTLeF1GShGDd
	 cHuL2Xxjy6UDjg7rw0eVGPgVg7YNlbivIV+13AS1hUDsjk7wd9ZVEhn+28hkceSDgtb1l
	 lGOYX89BstLFbwJmHxHQ6gDT/noo/gtM4zW4poLa41Xn6zg7QcXfR3AYT+jwIG4o3fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792522969;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=gVOBVshmOo4FJlp+VmC5NWxRE1TUIqpvXVKsXzjK8JM=;
	b=vAQp83aOz0csqehhJ/7cVlSOdvs1Z0dtswMZwHWIP0vi8y5E4DWVz+qVHV88dUaGWMwf
	 Boey5GJNJIAtKgeDu5rT/3XT+0yiDYBrYc+QuqoEiLeS8iLvqGHNGRY8PFvZguUG8wf90
	 Y4u+rj3O9p1eGifq1PHpWQ8j5eJ9P61+/1Fv64Weh7NDV47AfpBWs2Bcvy8luaLzYwPlr
	 xZugRNExd86oSgGtCtiXEC+VL82tadA9/V9bW5y7ybrMdvJ+SMJQr/kck9rLd0kMhKsNt
	 amTnG+x5sBTZYTlVWBJdiTIbN3k1KVIygsR6GYUDqJxqs3bwCINwzkEwVPhOFy/ynSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fastmail.com;
	spf=pass smtp.mailfrom=fastmail.com;
	dkim=pass header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=GtM11Kfl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OOiI5H7m;
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6E3606A31A
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 19:02:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB6E3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fastmail.com header.i=@fastmail.com header.a=rsa-sha256 header.s=fm2 header.b=GtM11Kfl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=OOiI5H7m
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C4BCB7A00AC
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:02:47 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Tue, 20 Oct 2026 15:02:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792522964;
	 x=1792609364; bh=gVOBVshmOo4FJlp+VmC5NWxRE1TUIqpvXVKsXzjK8JM=; b=
	GtM11Kfl7dm+eshHC1JO+KmYtEENvx5EscOPnznFHNI/8LH6wHs/w7SOiMI3DYs9
	DWrk7kgW8ZUMKN+f8iUVakDAwYZ48yxQF2KBP/GftPJzVhldIG0puW7zt8jW9+kC
	Qu1XzB44cyvmu/ySf1n8ShCo0fJFCTuMnFNhwyCSH+X0SAt6gkccWLT+B1PzfmhQ
	IibTj1maeQnzU6sKGjDXPy4bh9oxkyo3lSE3do+DdfD5GGt6r38zZwu968oCezvH
	WUuqLrYeEb/0O3LQvfEKKN2ivzXj/LZVzkgCXo6p1T1pBN2SH2rxVp7pONl4/nJU
	M18E4PIR27mnE83mf3uk4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792522964; x=
	1792609364; bh=gVOBVshmOo4FJlp+VmC5NWxRE1TUIqpvXVKsXzjK8JM=; b=O
	OiI5H7mqvk3Lk8pX62ljtkS0ISEv2Qxx3wMdrszcun0sxI/Eo/VskhIRS35ikke1
	Sgbkb9yqry/eBhlgSSs4JURomziFpVHT9ZGpMUjCKYZJWLPywvw6VdL1C3MAyah2
	EDT2xOA22MFGnPFxlGw8rlphJI4NpBYORTUiYVCajWGoZvD+NZYAZ9nPE18Plu/L
	ctn2HiVurMVpepRAivjORA5xdC4ehCzc82ksqPCqI7wm/imCVZi/QZwmhqiKleYq
	WcX0BxYDhZde0u/rUeLYpRrDXvlWAQJxSRea1nnmURDL0kwKVGpyUib2r9Q/HjrA
	urINN0cLP9bv4SALyrLgg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=fastmail.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792522964; d=fastmail.com;
	mf=PGtyaXN0b2ZmZXJoYXVnc2Jha2tAZmFzdG1haWwuY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:PXLbmZi/H0Zbf7hiNeme8l3Z8SK415UOgz4M2x9cq/KutzU
	VKqlqUSj6xGfQKsFWzJ8U4//nx1DeKhQqM5cItBUnvTA/EN0B1F2cfBY/FP91ltI
	++z9pa2ktS32LOwxuefhaoFo/PRF7IH1UqPTAzLCS1/Wgn0cmj/hqWXmevRpmVbD
	iD+Hip0BM5cgZN6p28EoIoM6B5Gm9HwhkqVwn1WD/Wz2fvni6NWgdQjOwOK3D6vZ
	X+MfKmbfKQ7RT/63xyttMBAS22LTq+dC/ajrGk07uNTi4gBPqA8k9S14CLcicGC8
	YOZOZS68Qu2r9o0JDDWJFa8W56f0Oq5PPGcsBwA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:niS7Xxdzzppkm2nAY8i6FQ76v8jZlJC2GM/Fteg5QGg=:gVOBVshmOo4FJlp+VmC5NWxRE1TUIqpvXVKsXzjK8JM=;
X-ME-Sender: <xms:0rrXapU55_hq1KraCsuxy4pwxk-rcBxTKUu1IUCBfWZ__LKgq3eMNkg>
    <xme:0rrXakY2Gt-q3UpyB8esl_PnB0jiUvd69Igt7aVQGM7ZSukruC2NI6LMnWjVp5Ilt
    cQGFaFqSdCSYj1CSkF2ErX2DC-BxbuSrWwFY9PZQxE7Bqy8G9cYCYI>
X-ME-Proxy-Cause: dmFkZTGWh8V6oe0Jv0a5kMu3Vp6IspmccTbMJlJEpaZ5ThDr+nMQKPZpqtpMsnBDYXPc+P
    jLP7uvUh5TBO9Z2Wyuq80qRsBeRnb6kwYpS1G+oKme/gMf4vRGsb+VK7KYsacE9YW1s4Go
    95O+/2a0T7Fhc6NyRU+MtGbiPmYrHVZ+b5uszAyQqboEqnCisLPAjg+93QBbyBEe7kRUz3
    uaPWC7y+6j6Lu271okFeEWJ8gk+dhOluqutbszO110QzG+B2e9WzE3KKiBwADV/SBBSkZq
    LlbBJ7RhNtTJystYbnh9fBQHqhoV7f/BBd7WSNSAzSSIHwUrcdbf2BxAO6NgqcPv9eoIOW
    qjKJnUdQbPNQXZKVtu33A7YJSNYLlESdawPIoTXTiAebQtFVyibBZy8OWkhyNKeXzJuEAD
    DrwSfUaRQU6C9zRqxtPHwyAslFYrKeSjwH5o/FguqYRavgPh/82upNMnF+1EAOzfNLyw0J
    4aSkEravnPmx2sgskGcHvXRs7j9GktSZvTyA9tWhIUf+d4SRHOn0kjiNpQD8NLc4h7MLCr
    VsIPwLbRIwn1gxBah8XjmoNhubg1uXSVFzjKquGK6SRRXrqcn7PlmFz2yrZIZ2E/Cbpc0Z
    PT6hxAu61Vi1eumGqSQQ61HbO4aTF6334VG24cNcunu4VlmLa1UvDDUS2jkQ
X-ME-Proxy: <xmx:07rXapbJjx2AWoWiD_vBQN1Q5ryBUhe7t9B2qSM_FrJi9z4zL8TMwA>
    <xmx:07rXathVs-T5Lk24eBdMZP3a3K1pkSsRaRkDn4GsaW0uTYdqlvTK8g>
    <xmx:07rXaq_2l_ZDtvkN54-pWy7RLXjaxTmVJ2L7LfOp2qk9PpSTnI8nIA>
    <xmx:07rXaoqK4gc0BLHQymaoqlnNffZ9_oTEC-t3DiZhe2YzdEobdUQLEA>
    <xmx:1LrXanc-nRFi50t7UdvHUqTaU183_geuVHgFyTyIhbnv_dHOeJJ1cc6c>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id CCB5922C00A0; Tue, 20 Oct 2026 15:02:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Tue, 20 Oct 2026 21:02:22 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Thomas Bachem" <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: "Usman Akinyemi" <usmanakinyemi202@gmail.com>,
 "Christian Couder" <christian.couder@gmail.com>, Joy <soniqjjj@gmail.com>
Message-Id: <922955e1-8fe3-4e1f-8f5a-4ecdd61b1411@app.fastmail.com>
In-Reply-To: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
References: <pull.2271.git.1792522587065.gitgitgadget@gmail.com>
Subject: Re: [PATCH] config: move pack size limit into repo config
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 20, 2026, at 20:56, Joy via GitGitGadget wrote:
> From: Joy Gundu <soniqjjj@gmail.com>
>
> [...]
>
> This change removes one piece of global configuration state from Git
> and helps make Git code easier to reuse as a library component.

It's nice to see a paragraph explaining the
overall project in plain terms. Not just
"we are getting rid of globals" or "this is
libification".

>
> Signed-off-by: Joy Gundu <soniqjjj@gmail.com>
> [...]

Sent from mobile
