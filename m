Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC249AA44
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 23:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638916; cv=none; b=nG5WzMk1Q2H0ny403cxNxyrT+mXtVJvI/2jsNlKoiTvt1uSVZ7KKx83e5aQO8mvTncxOp1M03ewwIhzydwzZbOc9+MEGjsW3PBRfbVWCcMES+jpUzcBEE8xFp5E6RuENlUgYLXpoUD8xBe+a6bWm9yGuPLSqr1GGcOoalIuRyWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638916; c=relaxed/simple;
	bh=ok1Ea11wn1KCmosdClPtPggPHTRJf0VKd5fpBMOfm20=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=LQPFxilelsdKYif1AdQjynpoipL9XHZjkVMXoG0wWSc7R6IldKnUbVyoSl1Tje6GK+OS3UxYN6+Gp2TPtqjRGp9sG29ef861GevAnH5uYAPrlLuL+aDHz5VgQ7AowM/oWqDkZ/eNGZWzKFrPMcwyy7V2ZrzGeB/D75I5z+Rf+Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me; spf=pass smtp.mailfrom=5ouma.me; dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b=ULHYMWWu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Yz2RCy1t; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=5ouma.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=5ouma.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=5ouma.me header.i=@5ouma.me header.b="ULHYMWWu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Yz2RCy1t"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F16151400067;
	Mon, 28 Sep 2026 19:41:53 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 19:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=5ouma.me; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790638913;
	 x=1790725313; bh=ok1Ea11wn1KCmosdClPtPggPHTRJf0VKd5fpBMOfm20=; b=
	ULHYMWWuA0d9HDM+dHhynEJoJ/ylkXcfFGShxRFQ6tcABLGPosoGd1mLAkhjoIxT
	lgJlW2eBK9pJyhn2Rvk4NcGKWDYHwOgoRaKGWyIbpj1r7/wv0QXl3dgwC6HvqEgQ
	eU2VpIYx5p2SFXO75O9dhzWOW3DpX+LtAXJ3Nc/d57bW8i11f/ml1OfDOpJtF9RB
	7FRg3YItHZl5S0EyE+3UcvdPfMorJmJz7YUUYj+70G2lFzzz3eEmGT3y4L6wQoSc
	OX0AFdOsTQJDWd0uJ32EsVC3ffVHE9C43SYSlBCj6tRJL1H7dnJBl069m42aMmcx
	eGiO5eTkKja9VX9kS+fgYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790638913; x=
	1790725313; bh=ok1Ea11wn1KCmosdClPtPggPHTRJf0VKd5fpBMOfm20=; b=Y
	z2RCy1t6xrXtk3VS6cNaEtUiq7XAYb+h86aGM0sIb2CLmJ6UE4jjvxnMgaGpN9Gk
	PtoxD9HGIKz0vuUdPDsUpHVkGeLE5YxV7G9A8ili7amg7iUaFw/QrBn9rH03wyw3
	lz5k2GylaGm/w3FJmPdc3io5ruJOAXCq5gH/4GOXNiJIPhpbzyRd548vWz83GuoM
	maWck9PFM/b2uSCvtz2OqN1fFRd6LfH9bbYwTjxa3SGsD9clHwuiOf7GQJqpKz+c
	gZQu2Oauw42iOSNWgdRk9d/A9rLl5WNUPNeTQ1+gmvS6FOONDHj62ifxCdg/uoyd
	fWd8G6zh20fXmq6uVC6Hg==
X-ME-Sender: <xms:Qfu6asuNkPz3cxja_2K4rPobWdih08PyhH5NTvCn7CEaz2AGFfUq4w>
    <xme:Qfu6akSVowUdoV6h1GLeHYMvKlLf6qSlyCtIeSKDyeN4gcvpVcrMyP_ammqYq2qbC
    T-kCRNpOSFLhbJE6A07-JeuX6AoJGJGd8o6UMPZ-UNbfAe0RIBGbm-TZw>
X-ME-Proxy-Cause: dmFkZTEbz57tza4o9qDsZQi7LViDQ2OpVv6iEpbbtxGL7SszmYnYMw3JNcxzHfqGKcTHBc
    gkCiCfA1VCjgqTghye3BPKJsCFXrs87e+UieAoFVPR27CaH1RXhz5CiNObXKABLwpNGZ+L
    eDuDdyP9gcpaYMZ0MU7M1Xhb4LVAN1EYOOFu1Y7LkAsN7nflyQs36Fr1FuHpIRidRlik13
    AtpMCOUpXpm81C1dQkffR4m/9+u/gvPbw4z1v0sXnpz/w7r7IB+dyMC94ElUPHYShQh4gb
    oeSVWDS81xniXs1SWmsmxD6dmAGD+R3/UHz2JbQVlIkv4wgezjfpn9jdsC7u/wqg0pSdMR
    aZClCgaRRFlx2Vqjho0hMxG/3BOw44tTVaq3kZJc7/W+Ey8p8lWW2U9o2xmAaHCG4c5LhL
    coJc3b4IHdzosoCIwpR5llVhuPG0SZ5E81L41/0jEslPleNIPg1jJoau/i0rhxF6PBuCEI
    F43Dlrm3M/kANMoUBCt7gviNa1Z6egwb0GxwlimNKyWdIcv124g7hKDy8G1hnjki2KSfQ+
    HLWYAY2z4DXq1fG+HJCkfBAMqsVzIycAibUD18Fn7jjU6ngX8wmoh/+rpSmI7+4mmKz89S
    ShJaOY+l8JPjET+w3xwzdixYW6mvHrjIFZGGqwW9MwZ4nvkAkLLGtVXucgFw
X-ME-Proxy: <xmx:Qfu6aoqHQQLA3KAUAdRNc-pfQiwokH3WNX9QotebVYRiJ0Ig8sLWQA>
    <xmx:Qfu6amY1r13IU-KT8z3SlLcl5uoUJ7OSNn3-GWgm9H0Q8xvTMUL1CA>
    <xmx:Qfu6agTc_GVhgb9Ez7CqxNcHaB5B5RFkSYifX5IYwGXf5CsV06kcBA>
    <xmx:Qfu6at7GlvDJe9x-D92Sjw92bZIT_GFSZ8hbAeE1N_4Dm0phwJPoeg>
    <xmx:Qfu6auA_yHJ8RKJSWkOhLiWuAkZiiil3obaiU24GDjg-oVW0VTv6NPOj>
Feedback-ID: i4b264863:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 7E9FA700069; Mon, 28 Sep 2026 19:41:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 29 Sep 2026 08:39:40 +0900
From: Souma <git@5ouma.me>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <f2dd98d5-4bab-4692-8f3d-313de4b241f8@app.beta.fastmail.com>
In-Reply-To: <xmqq8q4lmco7.fsf@gitster.g>
References: <20260703145037.69832-1-git@5ouma.me>
 <20260912160045.36064-3-git@5ouma.me> <aroX94CD_kOyLnuW@pks.im>
 <xmqqtsn9o1yj.fsf@gitster.g> <xmqq8q4lmco7.fsf@gitster.g>
Subject: Re: [PATCH v3 2/2] history: sign rewritten commits
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,
Thank you for reviewing my patches. I really appreciate your review and =
feedback. I=E2=80=99ll update the commit messages accordingly.

Regarding the name in the Signed-off-by line, Souma is my legal first na=
me, not a handle or pseudonym. So the name I=E2=80=99m using there is my=
 real name.

Thank you again for your time and review.

Best regards,
Souma
