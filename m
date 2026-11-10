Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794343643;
	b=EejpgChUxOdzJoCQCN5N9+cBU1OJlOZBAHGxiR9h6zrPfHEwbAWsjTWFEWzGC0qYgOOK
	 jtl0IaKkaMLgWqERzy3eG3vn7v5zHJkVn7f3yT2oZzNytRkfMo34s/NElsaE5OBDaJHDg
	 3xd0x0l+Js/A4X+MIoZ6B2p4v5DXnl/Nkc2aShOoaEiZw4Cu9d1NW4oGBMsIZOB3BH9Vs
	 jPJE/UoeZocYwdbqDtc1GtnXjmoAsZ4NmOZUY6fTNVuAASt7M1IIoX7zbA16jvpiQ76yO
	 45t4wLIM54I2B0J6pqBaYFVA1OuJL2zpNHC3nEZywDiyBeC0QnSwyJO7fPKcTzC5+Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794343643;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=2XjH4WriH4k86ObaftxBOIkgoOoQhPHuPjVge+zVBuY=;
	b=NL1OFVjeojG98QRTBr9GRp1Vu8Vj3CXcqW91Yv6Z+e3J0iuYF9/ppshSZKpLGGEwr6y3
	 NNt/TzcBfu8r+hVI/DBt6Tul1JiMOPl+BFZhJgnkQUCipDbaAeV2KougZG8krI7f5tFG3
	 48XlKrZajtgKQEVAb/ONfgB5Y6PPio55nNz5n4uwTw3gnt/doiIBJK4er3+gDFCFAL7kR
	 JJ3SGAIUiGEKPzhGIdvd0TSBGsKjm3QfRPECYqFFpkFrF7U1c/W5HFeAmG+ckvwQ90JR8
	 PU4s+1JTF2tsTlDYeLUhkiHaKG0pglc9PkNFAp+obKFe9G29CACS+nIkCCczTs/uYSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GdtOowhv;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vcuLAjni;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916DD606A320
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 20:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 916DD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=GdtOowhv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=vcuLAjni
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0B3781D00232
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 15:47:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 10 Nov 2026 15:47:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794343641; x=1794430041; bh=2XjH4WriH4
	k86ObaftxBOIkgoOoQhPHuPjVge+zVBuY=; b=GdtOowhvFOdV1ZpZ9+heks/iuO
	hzFTODG5xZ4NsvVikWfZ3YOT3OAzf05OgkcpBKPxASxr1CZMxILKm+xu1hWnhvzB
	R88ISzwDuTUStg57KhnA9slfpf45/3XwLx6u3GXDuP75z6k0bwUSONUFOqjUQODR
	+xmCfcDHoKSr5YYrJgZyjnZJBFJRpodoBLf6mDHqhYlmVFtPtH57JVtWoPNGUBYO
	PxuC7ZbdmjCK9H3Z8NE7hDAv1UKDR0+BnDlqg/sTWNiW4j7RuPEX/fXq36d6Y6Uw
	I9chnPFJMWPckV8m+YyxWWRtD7+T2xaNwMn1C0cajigSmp44aD1vlvB6GJwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794343641; x=1794430041; bh=2XjH4WriH4k86ObaftxBOIkgoOoQhPHuPjV
	ge+zVBuY=; b=vcuLAjni8hPH6/+1ctiNS/LCNb97jyhPjfh/1p6mrckDzQSeO7R
	dEP29FQmSyJ6PFA1+6jBgQ1PlWKffkQMxRVyrhPwovn2qXGtuyVRLiIMxGmcGad8
	yboV8/ESRWjr9OFvQP26htXiZQXL3j/josUuDhGFdy/EcL9uBO9AzHq7SBRH9TrT
	nMWuPwE397AH/+i2IcO9Aj0hcSg1S7mERSLry2annOjWOHP5SKYHNSQEG8Pvoce2
	iWVZMEeEeyA0RxzYjnbgol66KOCTVsyscTQ8dHpuAoHRP9anfc22d5psdAY34wzH
	dA331Qn4R9A3Xp+Plt/R6tE1BpEciUhD1YQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794343641; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:MbESDS1Yv3I2E8YfSgNN8TW/y98lpdXFJQbB/bYLRK82soF
	XM0CJfdMvj8RgFL3utDRtNu6ewKBuGx+qK6ugD0H3A8Us7a4kON3IlEo8egNC7pK
	5RCl6bSsBH5OAgXiC76qdPWYRi/7b9vjEydeLcIIR4BT1zOu+Zht8IbnxmO35UqH
	idtmg4GUAdwsUl/TqeGhwgZAQO1FgEQsp//Dmh1SPSBQFnPPNaPcqyXXONpZXZlc
	5ijVgJvWrVDpU6vWuLZWW5dypXfbOIjnYa+kS5Y4d2w5kjvkTqR0VUWVVF/5r5ho
	9Fwd3GpmreA5YtRz89uodU8Of/vygVXWcMZQ+5Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BEbp7Jon+a2u9CyRxEuAcoG8vE5PGbFrNgtLp+eoTAU=:Mf3A80PJ4CXBpCA2MEJPWEhz9JQ2P0MEiPK8qBVJda4=;
X-ME-Sender: <xms:2YLzaucBoOQrHigcxX02Nk5v_b52ahSCkDfvP91MKpxYjU12EUxeUA>
    <xme:2YLzavpQnN5vtmQEIQlB-wyDH8tsRh9nFCsTwCy1LBJztDF54ucojJbSkUEVRSm9E
    hUC3O0s0VMM6x8rkogYW5IuyNISbnoeeAGFkT0JzzgDNdhdx4hVzDM>
X-ME-Received: <xmr:2YLzas4eReCHJgZl5MB_bYxKkoW8_hWVzrt93LK0Jzo-387hhfBFu6q-zefjbMgDzhJ2Hn7ajnMs20fG8JqFS2IA7wTCuAIjm0GR>
X-ME-Proxy-Cause: dmFkZTETYbfTsx9mpDHjdRxqcYcWFUB8Xg9p5LPlXWtbQvO9BmMRlyG9qBPQ/hJPAUaZxp
    KYrwYKSPhvueFriIyHAIJ+SAPM74OaTqiQbdxZQld7bVbACZUKyzyley8j+fWFfDd9SIa4
    zmoOCluNgGHh3rTrFWs9r31x7F4Jaw/IUBufPS07+kxX4//tp7+kCuwb307TO+GsQcnT7d
    9fuVGDd11KCEohL/SSEBaewlm1qlYuYhy+TKdeah94ksRx/XgoFMkeUy7bYulV4UH9uwA/
    g6BRGfJs6m+cxjZ51rSlb3YOeGTN0itha9nVAzhKp+iKS7HYmJHT45N8MChnxAs+/gC9qn
    fZdY4HeCx0kRyQmL8AoUL+bLVDTB6RL0G2DFxYNtMde1hcF3LVUICvN4s/9QyOU0D1uQpj
    KEhX0ZPcfUN8aIrDg7nyroM0zrPaix+z4YI8UQwFDB+mDvxKeei+InrERai4OITbRxBqa4
    N/s95m8gbatpA2UukjghFXCCF6luVo7K2UXskOZKKwfhN0yxlRY0HqeAbqjRrcX4XFbCH0
    UR1Ss3vDmKzudUaXTN1qyS/U+dxeOvJFAN+kS9Bs3Q+9kXFXSTmnVuULOx5Zr0dS2uXOG6
    iaeAwAOUQvDibwoXasZuvxrwSGc7h2BIzsqOQCbnn84dns51/uuEbdfIvaug
X-ME-Proxy: <xmx:2YLzalq1zYlD9AKubn-CTYtNqYUBiwIeukjTVu4j-swVxYyCAeBfSQ>
    <xmx:2YLzauiO3iIwLDFXN6zp7dOWLtEpE-M50IHC4GKKYzASkvB1pSJC_g>
    <xmx:2YLzavLJmMWqisbTC03D_ulKc7xq9GntZ0YKUahdOdqV1V2lH_bjwQ>
    <xmx:2YLzauBxaNyfYzGB8YKpcwqbuG1MvBuyF6SS-x-BmCCLGADtsE9Otg>
    <xmx:2YLzaro3wc-c45JCMT7Pz_vVxi9btrv5rgIm3Vzk0ydpQILOtPdis_d7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 15:47:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Daniele Sassoli <danielesassoli@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: My summary of the Git Contributors' Summit 2026, was Re: Git
 v3.0 timeline, was Re: What's cooking in git.git (Sep 2026, #08)
In-Reply-To: <6572a59d-e2d2-4930-bc32-add248529d48@gmail.com> (Daniele
	Sassoli's message of "Tue, 10 Nov 2026 12:09:24 -0800")
References: <xmqqwlsei1pv.fsf@gitster.g>
	<76ac51df-cef8-c6a9-2610-8c21f03c6999@gmx.de>
	<xmqq4ifhgzvx.fsf@gitster.g>
	<5cc325c6-579e-4fed-7071-a3ff98d51ccb@gmx.de>
	<BEEE94B1-EEFB-48CA-8B45-EEDB10FE244F@gmail.com>
	<xmqqfqy4b7oq.fsf@gitster.g> <xmqqjymkqx9i.fsf@gitster.g>
	<6572a59d-e2d2-4930-bc32-add248529d48@gmail.com>
Date: Tue, 10 Nov 2026 12:47:20 -0800
Message-ID: <xmqqld70pg6f.fsf@gitster.g>
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

Daniele Sassoli <danielesassoli@gmail.com> writes:

>>> You forgot to mention that the talk is scheduled for Tuesday,
>>> November 10th.
>> And then we no longer see that talk on the Schedule page anymore.
>> Sigh...
> Yes, unfortunately the speaker's had a last minute family emergency and 
> couldn't make it
> to the conference nor present remotely.
> It's unfortunate that this happened, but we'll try to have this 
> presented at other follow-up
> events very soon.

Oh, very sorry to hear that.  Please convey my sympathy to the
presenter.  And thanks for relaying the news.
