Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793601677;
	b=iZAZTsnD+roYCWO+HwZlfVKFgss7V1oQDxKBZv36meSdud8LFfV0zQh+GBV/vpGH9qNf
	 lIuS7ahng6LJycIMKGO/inX76LoYHd1WQpo/cjIlpUV2uaiPEBDj7gkARrZBZ5vGW85fL
	 WQqOJnvtrqK05rbX1UP+cYaO//1UB9lKFk6nT95fB4Cr6pHrVuFuIG5m2Mo1PCu/AGvim
	 0hePFR6lW75fEOntkiFSyiL8Kg94frRrmL4x8f0qBp7wITUWMIqafZ6tAOtMiVIBCs3IQ
	 ExnNFHLsuQKyBr1OlTz/6E4npLjxizTmJ9Ibr2JZPRnpYlQR731245jmpnGQKHVz4rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793601677;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=z4+64xa4MFVzda66TfoAG3njfIZQz7e8fxXOIhoP8Lk=;
	b=xRo9SvYw6UnMmJXx93c+n5CjI9Pox4C097n5rJprPyKVsHIuJ9dzAkZH//H7HqgHiRAa
	 ZUrkN+a1r8j9YqMqBtV5b0aQOi8WjBk4/1nciaUTh4Bq24RiPW/I2L5yz+9m1el8E5QNS
	 rmDQ6+lvA6lhqRlI1VJjMdlRgTtkRi84rZul3qmXAt4jr1L2AjHje/1PtGNUXNekISFiX
	 oaWrxybe47QQXG4zNH3st28s2wp0T5DDPTyu1bWAaUKFslQcPpVwnj7rx/iCkMvJ/RVqn
	 okSh2r83LmM1ORXgYrby4bajlvgFoiHErUvbE+7dXJ+yv524IYF4RaQ5uaJ0eC54wzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b="TgIh4c/5";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IzX7QduQ;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A242606A32C
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A242606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=TgIh4c/5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IzX7QduQ
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B51317A0165
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 01:41:16 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Mon, 02 Nov 2026 01:41:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793601676; x=1793688076; bh=z4+64xa4MF
	Vzda66TfoAG3njfIZQz7e8fxXOIhoP8Lk=; b=TgIh4c/55ERK3lFHspw8vdV55a
	acvEV3PmhgUKux/0NNRsaWRV+t1MSy1r1b6Kez1K8N4jPAQBhEDT2zrcs6jVFT8w
	AqiR+qQ5rPqKccrf8xaz2xMYK2hjnTYJeqDvmUm1poez2fyRuTs2kNfIViQnF39k
	GdjBjzQpAWUR0bLDw9bi470ida6QiAjgO0mp8HeSwOv/oLBdUvppNzfF9kY/aZfp
	C7tPd406fD+8/472jXcQT32CZl9wBmPxVcNh75O/Xc9OuTXXF3nktt+z7oU/TLnL
	exn3ibgHxpR0ySjXNfB2sfrZCN1dRj/nkoZTaGI5g6In7cmDd8PDiBBDjs2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793601676; x=1793688076; bh=z4+64xa4MFVzda66TfoAG3njfIZQz7e8fxX
	OIhoP8Lk=; b=IzX7QduQ06E0xdbASTpjyf6bBKAGAoDUSEQfBcC4Y8GLxnBWnoX
	jNMUUaWFiz3lEduVMuMnbhNFCKWNSsEJENWHk9YvUf/Jvbwzs+WTBhWt4CPzNkFf
	ZzxmvGRLTUofeFHUDDiYgJRCRYFKf3TWKEAwits9gcRDNKb+cq1JIGYOrPouhLeb
	zjAwe9zoa/0XEViJo1W9A+bndK7w1qwLq9yt+Xiso9GPU13NqsyWh4Wq4flD3hwZ
	OrFTW5AgZwgHNPI/WMM77E5So4U2jh+6J3DVVJyW1TlVYUd45FaLG0owixajwlmp
	5826VaTRTBd600zWhtKH3wFEDmmNEiBZRvg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793601676; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:VEUxNVUzvPsPhjXwPaF7qbkZ27EfmFa65yKy0XINNub8YxU
	MBuoEQ8opaZiY7DyvMjh1zcoCSLAE/RYCHpGfaBJrKRALBy8OXxrfGIfAIjLBp/n
	+fAA4cgMAn5KVVqGsVRVoYWGCJEuF0acL437CC6k6ghMuJFaVAriGIUPSUzx/Nlj
	iXgNSvLPbDDjLvRoQRL8CKRrTTZOuNvK1Pu3mEshKKrCx871+qRli52EMd8ya9S2
	s1cYh5qSe32IUlWBarqetsFTdamxpv3nm3zENBzzmxlAznWeWrhEFhrUfUdKZ98L
	ZTfjIS+wv8/qdulsSl+sLym+4h5u6NLC+bLUwdA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gK1p4SywEqTI4lO3k35ocTHBEHSemTiks2TKOwLGW5E=:+XYeA5tMXLmAdefvImSiOBGb5GrwItMXWY/r1jMHAcY=;
X-ME-Sender: <xms:jDDoagBHuRULHHsmpqXlVeHbx3S_8BMfA33kJQ1zGSIR3W1gpNuyqQ>
    <xme:jDDoap8yf9trFfH1fNPB3HjFt_pusgje-77FcZ_rcvWLlqXeVTjzR7IPqKSUeivuy
    1n8muQhJzblUpSdkc_cVjlVfG2LghgR4AfbvF22hO7FW0xv7rOAuQ>
X-ME-Received: <xmr:jDDoag9wtX0lT5eNxuuPoCNu3qEt56MLW-Njms2Lq8-lAWnviGqqKKYsJ1bCRQt7qgbr53k_1qYLlBvMRwIga9_0bLxaqdJYN3LZ>
X-ME-Proxy-Cause: dmFkZTE1ITeXPKXJM0hVrkh5PfUPlZlvNnqPy8DaJTd2VCbVEAqJEN7J0iwXEjAehomGw1
    oQv3h+i0eca7Gkb+YyeQ/hZxNli56r7hrrbWzCS/UdPjB9m5N92yFzmynCa2X8wWvgVtFE
    wBPrMmIgSz30KY3i738jc65Ozh4OAl7LNLkr5W+WLuF/jUsHNmtSoOl1XMwxRDr6sItCeg
    T8hkETnN7FePIFjiExKycnetRjDOsZ9aSOyUAR/dXa5ajJY1BbN3cRyanQNOHusQ1da88p
    Lae0+B5Bv3Z6/FGq43bG2MYPzi35ROq05gKIX1DbOOv7lB6XM5IaZ5cjkRrmuQVvyUw1A6
    BS9l3GwcH3mHq0Bsn37UvGiGn1+oxolRJ4oQDHkTZ4VYCBn73F1CY19tEgLmD9IDwYallD
    pAQUrZULr/XT7ib7fHnneP/qHA9g66xInVfLZ6DS/8YPV93bYJp9tzHi1jHimOe4JMhZcq
    43erE2Ppoc+S3IixZhA+QbEouoFuw85Zn+IXeWpPpjUIoBBLsdgHp6BJRXrlLWpctsir11
    SKlhmUZI9rL/DTCOUJk0AJLe37r0ZmQK7NtjdasTVgIFBSBUboAIbNeexQyB+rYpJz4O3J
    YyfEFatXL5h/FT8xW8tuKB5Wed8BbH99eAEe+d1Cty1eEAS29Hc9GPRNfVxA
X-ME-Proxy: <xmx:jDDoage0jMHJhvP22DTz-umQJs7LJMq75YSSvEamXy-5QD4ZpKuz1w>
    <xmx:jDDoapFsfEUolYcSEWJsOvb4tBzOc_svGHfKS86c_htY5Ky2xbac-g>
    <xmx:jDDoaucAwj32rldYLMJvUV7FSaQtUG6rEwEJNTUePhoAVe8hNY_LJg>
    <xmx:jDDoajH2MC3rCSJvH3dLpq5GmmFpL3KZSr4b4vM2ntGLA1QiJQVNKQ>
    <xmx:jDDoauIkEPBggjVnKhRAl9ZpsiVAToMwtJ1xzkQ-AttjiDZtHFirMu5B>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 01:41:15 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Tuomas Ahola <taahol@utu.fi>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: update the required Perl version
In-Reply-To: <20261101185846.24208-1-taahol@utu.fi> (Tuomas Ahola's message of
	"Sun, 1 Nov 2026 20:58:46 +0200")
References: <20261101185846.24208-1-taahol@utu.fi>
Date: Sun, 01 Nov 2026 22:41:14 -0800
Message-ID: <xmqq5wyfohv9.fsf@gitster.g>
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

Tuomas Ahola <taahol@utu.fi> writes:

> 702d8c1f3b (Require Perl 5.26.0, 2024-10-23) bumped Git's Perl version
> requirement.  Update CodingGuidelines accordingly.
>
> Signed-off-by: Tuomas Ahola <taahol@utu.fi>
> ---
>  Documentation/CodingGuidelines | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Makes sense.  Thanks.

>
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index c06f5d3071..9b17ab34db 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -703,7 +703,7 @@ For Perl programs:
>  
>   - Most of the C guidelines above apply.
>  
> - - We try to support Perl 5.8.1 and later ("use Perl 5.008001").
> + - We try to support Perl 5.26.0 and later ("use Perl 5.026000").
>  
>   - use strict and use warnings are strongly preferred.
>  
>
> base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
