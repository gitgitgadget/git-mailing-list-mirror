Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792775390;
	b=IaR2P6SRY6O6ChKxlkRPmE38wzvCRPWdOv5KD+s+V5f03cFXMfMlDDqUQ4NEdxKQdtPv
	 McjD9ELpW+9ckztWjwWVdE96NPnB5ssay5dttYeo8pPHYoHMgWk+13yrd669J4w/h+n59
	 Tso+zVxUltS5tgQ52z1/Qr/+3zV1OUlg9b+9XJr2hBu5cemBawhDXZdojE3zOwWPrulJZ
	 sy7d3o/PNvou1mFmTC7lQp7kwdlFquUbqTTcws73G+Se6Kp/zxDrakAt1hBxwWS/8V9Od
	 2VO3SatCjUyEuLQtOPvTFQBS8NpKmMUprnxsBYXjo4w8JunUW7dmC1cy7yLNEx3ARTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792775390;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dHNzpXYKfTiB3RY27xeM2CTa0Pp0Btq54Lzq/CUrjNA=;
	b=fii/ixy5rBro4CMg9GI14AiuhuRV1hXQxfm6N7xMHNGY0Zmfjh5niZusi0bD8GosV5kI
	 m9Iq0uMpRNeNGIIPb1AznT/HLGcLHvrV++Mdl27v/pCuLP6eCbv6WpvooK/Qb5R+kxqw7
	 jp8kf/cZIYOFWHNKYY3j2shZeeWsapXUMecUVyw6FLHyShQt67IzOBBTE0wO0ZoteLAJT
	 ajDSXL52fPiP5wv0Nmymv6bpmH4KcQqjn+VyJVxEvdSvTNBNVBMgGBzWVWOVOo9BcElOV
	 7Y0ztERIV9p8wuh8ZrlqBWAdMQx4FW4LTcuWn721ua5saC6y8Z8KWEpOl2oyuuEqf3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bOcq37TD;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=caYcyzxk;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BD5606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 17:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BD5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=bOcq37TD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=caYcyzxk
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4A4051400120
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 13:09:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 23 Oct 2026 13:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792775389; x=1792861789; bh=dHNzpXYKfT
	iB3RY27xeM2CTa0Pp0Btq54Lzq/CUrjNA=; b=bOcq37TDOAxbDsef1e8pFocB+r
	xn4op0UPDvImWmwY2cMh9KLbkKCZq2S/29ayXzDJttKcMgMIndsZVKOMiwd0JO5r
	3b56Qw9ZKmsjaxX5uMF+gSSy1jB9eF3KI8UdGwNEWmi1e6zBiie4mM68wWVw35Ez
	mHWazeBWbN7SukPOiw6xzdxwtcKnJqtOmmv2Cy7ANeq0l8rqbbyHTlO72xF0s684
	uM9slu3RcKBpx5E+puwNvW2G53ko6O/pcPmeM0kuWkv7+Zs3zAnNQH5PfVmctZMz
	7WY8ZoNkhxiQdq1Gy+S+u/G742V34a/dhJi/ja72Qr6+0M9PtU+N6Axequmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792775389; x=1792861789; bh=dHNzpXYKfTiB3RY27xeM2CTa0Pp0Btq54Lz
	q/CUrjNA=; b=caYcyzxkXpUmN3FepnU1x9OOpCNzRg5ycxY0aUvWU921LBIwWVp
	wm8h8uN8dqMhs32vl4M49JMm/C2duDNVpAQiwzQTxUrMyE78ZHvGaughDh00n4i5
	ChIIE6uUZt0Om+Highy3+97HOChITaYt7YyXdDU9g/pPyPYsG9iGqJG8bQW9o8bs
	Wx5Oyg/snfLL/DLhtS37ZX0AwgRDryrNP4vzuC2LpzfTJFDA0pmrFJDBFSrEWmR/
	oxK/Ktl3xDl7Oqya/4Io2SuWeHBHCY5neTjwTkAzuLD0okGSDCFVAa5UcsPY5ohU
	h9cRXRr43gTpx9I2RWIi9/dlUmN392bPRsA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792775389; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:cEjesUiiwuQAigmHZM9yLpk72TxuO7uP9+4Amc/p3IqH0A9
	iHNCgjRkOzMEXW7LnWvaaSIPk4NuTBd8JJJ6n1rxCn4qO2hgfXKMoPEVFcrh0l5e
	+5Jiv48rUVt/Q50hHyJfq4T8XjHoJDIHZkrnQ3xMLwxb2e9PN3jsHTZ9Ucik/rsx
	GXjUN4IRZ6aNIu1iwHnlluJDP/p1evSB+VZTTg+zQBdjdajxoTw7QChpNT+QRjeG
	mym8lke5bhzgRFAb5rOz4IdDsaOqWK3cRBaIIoNdmHI75kXN2uwofdK9npiJG0CS
	gcT617m6Wado19lmt/3EkUvM4dWVp0txBN8r+bQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:S2znY4E5K1DB97gC9uA9IaVA472ZpGnREMXWmZy0J58=:Gzg0lDzFFvjbUcZYdyjDWBH9uExh1cZkDSe56HPuDbE=;
X-ME-Sender: <xms:3ZTbavbrS97pvzr3TfGqmdLI9CcmmgFqcvc_8gif8bq8ZIEJ9a9HpA>
    <xme:3ZTbatd2g0UKbDolxxNKJcGgfBBfFa895DxZdQJ5gt8HaHZcIeiEADRHnLx5OpHEh
    MnmKNCZwsm_ckVkYBy5EsBma6NqJgYrXyHzVwJ0kAxhvp2UMboJHA>
X-ME-Received: <xmr:3ZTbaoKBf0l76gA5Pixhj8rrXaoWX8XVjX1Q6T9KI3n99KcaJUfhvGyr6_TjxMYrtg83WY3q8bG885mhNkfpY-RlVxERJpQOZ3XW>
X-ME-Proxy-Cause: dmFkZTF97pkpE5qNMIgA0fDbmUaHPEiy4oXbAOrl7DQuU0YMBt2IQFFS8XXUBUkLDTJd+z
    b58fj8uzdrfam0z34il2P+zWqQtRqR+RiCR6suIZInEcU0TPwG5XVwktc5+Sv3rEUISPxp
    kDq8Lhfg0AMbQE92YdeZ6u9JVScdKYrR+DrI1nSRP/W2yoJ9NO34ahY40Eiwc+Vj8rDZ85
    xOBq9yqH9mIVG5yh12hu9UEemj9ao3t7v3FFkYnrTCJ5YKQRkZm2U/I7latvlaNvvMJHsw
    R2ZFMlBr3X6OGlrQVMJoPfRynt51lEzkspBZbSN1+iK4sgmEXvx/TqVY2X2nZAVkd/DGKl
    snEDamV1EuxzSoh+PYZxeHi/Ch3Gdtp9RCVXfRb2MkQRvnG5Bdl8nxSBrapfCD3Rlzvs4T
    mtH+wtziApngIeoRzX1EFZAsoDx/qKf64EpAyIxBc0s+mlGn9wD9EbIgfi8aAytbNF5+Y8
    uxNGXzv5Sbn2tBfodGq9xA5lZ3ypn3ZbxvuSv82lqKXc+jjuFPpUVpVEWnpUpIcDqBktu8
    5WeWmKaFinWa0aajbHveYSwC5I7KEsiPDn4zGBshtFMHAQnhicwYl7bHRyV5n4yze97Yq7
    /Im5VBjja8rPhIlIZj2WB8jQJpjy6DWM9f8DgBRR7CF13jRGsyX61PMtO8jw
X-ME-Proxy: <xmx:3ZTbaiIOZm4XZKcIDm8SAgsc5CdhpICkZqL59UXnpbzUv_AXbUxzyg>
    <xmx:3ZTbavUevV1m4D9cq_FbUHEICQlJWPbz5e_C87B2THQz5jMA40qbdQ>
    <xmx:3ZTbajlK6rN93ky5DX3zJ7Hi6z7p2b96mYuKPpYMKvHmmHGL4P481w>
    <xmx:3ZTbatkgwHZfm54TnuEiAWzppkWOMaz5PHIk25CiQKp45RiiILdiCg>
    <xmx:3ZTbapYwHz-T1T08CQZP-u3Ko9xkvhhWvLUg7LZ-0zIa-BPJNxy6lmGP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 13:09:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: Shashank S via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Shashank S <shashu8660@gmail.com>
Subject: Re: [PATCH] [Outreachy PATCH] t2403: modernize test for directory
 existence
In-Reply-To: <CAPSxiM_gCkW3gvgF-ebK64bUS5za9CQgTFLAn-PnHS12o4afbA@mail.gmail.com>
	(Usman Akinyemi's message of "Thu, 22 Oct 2026 08:34:43 +0100")
References: <pull.2259.git.1792125111461.gitgitgadget@gmail.com>
	<CAPSxiM_gCkW3gvgF-ebK64bUS5za9CQgTFLAn-PnHS12o4afbA@mail.gmail.com>
Date: Fri, 23 Oct 2026 10:09:47 -0700
Message-ID: <xmqqfqxw8ht0.fsf@gitster.g>
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

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

>> --
>> gitgitgadget
>
> Looks good to me.
>
> Thanks

Thanks, both.  Queued.
