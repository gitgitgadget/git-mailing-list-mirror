Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69037F74A
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788563432; cv=none; b=fmuxoICDlC4a+ibIwHI4259encPfkm/b49WMBV2fyX7fteUL37wnqT6Qd764EMiUu6tFnTQxjYEgQjsFmeGRQddi1ydz3OG0sYPCR0KXovKTJxr9VSrMo+icofTit+q8vJa2K5D3cIgePMiNhQuVuxz/JuLOorQpzlaYEtg/rmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788563432; c=relaxed/simple;
	bh=xebjwstHQpWPUWfuMT6kNr+YJVOcHxZZiQFcOHcuUg8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=huXqdwB14oHemOdb4IiC9JLfA/DNSSNhwRNv+WgHSl7dcQiYHBxPF6/nhHGztZ3av1XyirYKHlS2pRBkU3pFAxPrU/2tqMzzZb2ALsP/TQlzR1w37oC+DXaGsDC94N1pCIOngzmE+cP6HV6GX5liLouSxui0wWx8dtoSd1BOgi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com; spf=pass smtp.mailfrom=artagnon.com; dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b=UcR4EckF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjA+wrgy; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=artagnon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=artagnon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=artagnon.com header.i=@artagnon.com header.b="UcR4EckF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjA+wrgy"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 532587A00C4;
	Fri,  4 Sep 2026 19:10:29 -0400 (EDT)
Received: from ams-imap-13 ([10.64.2.33])
  by ams-compute-02.internal (MEProxy); Fri, 04 Sep 2026 19:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=artagnon.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1788563428;
	 x=1788649828; bh=DOE3RCUA2vv8mYd/Ol7Rq7m3jBjsCS88Zvdx4KrsxrA=; b=
	UcR4EckFRcxqR5kFVIYYy0/wOLaIT5jyjwkcZ2yCj8ZS9sctsP+n0c73OhAbVV8Q
	EAqe6q3lDeO/zhIXM5a4F/1Hg9ainIUHAkm8mpbQcESBx57mWCvpMm4et9bShS21
	3QvF4+/4fglxh1VCo2Sanl4G3edn3yu9qDxAuPI8wKYS8XYJmZHp4JYZXu9s/UgY
	eGcniWVWORI5nWNbgNvstXQGvdJfaktEP38VYSKHyjzt1yw1zowWmu70KzBo1iNN
	0PzShHSi0EYOy3+BxCOe1Ok5heN4BrodBPw9fWJtXmJVyEdjs8Z7BHGsTDLRhXWX
	+rBNYINWr2WcE3A3w6RpBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788563428; x=
	1788649828; bh=DOE3RCUA2vv8mYd/Ol7Rq7m3jBjsCS88Zvdx4KrsxrA=; b=Q
	jA+wrgy2qrI/fYD8j9qaS305HwKR6sGp79B00IflfdM534UwlVQlre6k3nCKzQKh
	nLXqmuk8Q45TcIEc/QyI1ie5SFesVM0PGQc9iXy4p4ip/8sCpRIeAtE6gshUQVya
	xlmb5Vlirijovvf7k22TpSsgTU5sENyK4vD17Xrw/GFsyBdkrgJ4rlBomIPEy7JK
	Vlh4/ayedwp2U0aOpMObtjPuVOGp6PES0dZ4x9GWb+tY7Wl8rpaVsGjY1El39uZh
	Ap8S/O1r3tCp4R2RAsStE8G5/rj6XYHCyQj9m6TNX9OOHGcOqQ36xpOm4V0SmZaL
	dL/A/Ti1V6RDc6eQj5trQ==
X-ME-Sender: <xms:4U-bauSpcoo3eUfNRa5EGOkf8NVvuGpatVrZBUvQd_hu13OJbFiEVQ>
    <xme:4U-baukBNCnCnmPvK-dpLRMAMgegUIRvBdOsvZAY86GzQCGpWrOoEeTKqucEDnUzK
    CcyMrpbVyTCEiyTX8QuTjGemBYzV9m8Djo90JEWZnym-FN5UOY3DR4>
X-ME-Proxy-Cause: dmFkZTEgBHxHJb9Ydqi1MczhA6e8CeGciXvRxTjW5CTwblsd0JM6q6EuCDzau7aSIEwPV7
    LmiOzlzCeAIro9bMnp2PC80Yx3M1uLx7JKJmvWHaWInHPIm4wJOtW/bH9XV+6k+IMBUutF
    gbD+ieh7gXMHxWmH8Wmw/FvRHYseZovv3JjstKkOhWTZxjICULGUuC9OcOYPKq99KQ10Fw
    LGxVHb2U0t5ZC7ZKVx/u7a0agmLlQES3yT1mR04subHB91d6Yi3mMWy81yxqrjb4bgy8X4
    wanRfsmktPwlP6lDgfTQz+XGZeeRJceu0OQi4Vf5o9rdcP1Rpboqq+GyN9WDDdpkVEyjDn
    5ivzm+6EoV60dZbc2/JUJ9QTk1EU9E53dEjoNCberqASng5QRxBoAkElg+T9IUhny6dVxb
    0xlLSiBJwdhWEl9zhiB+lcyVBNIAASus5vIQ25L8CSJfhUZMEnKxRFTt/qKNslr/bxd98D
    WoZCLeaoLArhx6+lclBjhRXE4Yo9jsmzxEz0463g8HgNAyPKXON71NNprrR/umxiCOHuIF
    E+ugkK4qk+ejG8fEQxoggVl2FZO5OAv89yaH+e3viHER5Yr8WS0Zp0KNHOUG4EaONwJULd
    2qjvrNmdotkd+CE9exbQZ4YCifHe7U7j2EEZD7kTfWlVizO0OzxN8GQ6YatQ
X-ME-Proxy: <xmx:40-bag9SC4OuJlosoFPWy45rzErQFdqdgqmrFIqEk8BMMthrUSjnBg>
    <xmx:40-bamqzOceVf1QvQTkkRWNYFcbdD5wK6LDuyKEetCYXhZmVnzQA2Q>
    <xmx:40-batkdQeao6vcBD3ccT78atBGLlo3PzrqlTxMvqnGkwwZCJ9x0zA>
    <xmx:40-batKWLtpNGy1ezawP4XK0aNTwnJlpUrONI2uf8FrY7waw3Dpidg>
    <xmx:5E-bajDCZMnuHywRbR16tpbyFQZPlAgvJcJ8WP4fBcSE7N5vCFfymb4l>
Feedback-ID: ifc014702:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id DFBDCF80082; Fri,  4 Sep 2026 19:10:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AHWNdWDjOfzF
Date: Sat, 05 Sep 2026 00:10:05 +0100
From: "Ramkumar Ramachandra" <r@artagnon.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: "Git List" <git@vger.kernel.org>
Message-Id: <14ec96fa-897c-4bf6-a2e9-cd0c6e9b4474@app.fastmail.com>
In-Reply-To: <5ae09f8a-4acd-4c70-9088-3322195ed08c@app.fastmail.com>
References: <7fb200e9-ff28-4b22-9d9e-dbdec83c2835@app.fastmail.com>
 <apsaaQrngwYIVeVM@fruit.crustytoothpaste.net>
 <5ae09f8a-4acd-4c70-9088-3322195ed08c@app.fastmail.com>
Subject: Re: User report on git 2.55.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Ramkumar Ramachandra wrote:
> brian m. carlson wrote:
>> Do you maybe have some sort of security software running on your Mac?
>
> I think it's clean, but it's still a possibility that the workplace 
> installed something recently: I don't see any other strange symptoms 
> with any other software though, and everything seems to working 
> reliably? Perhaps the most common task: I run llvm tests over 30 times 
> a day on different changes, and it never reports any spurious failures? 
> I will nevertheless ask the IT team at my workplace if something that I 
> can't see was installed. I don't use my personal laptop for llvm work, 
> so doing that comparison is not possible.

I found the malware: it's Crowdstrike Falcon x(

Case closed.

Warm regards,
Ram
