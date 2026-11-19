Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090536;
	b=qVIOPlbYHuG16H/evToXL4vFCQ95L0KvmTBzxhTPSmGdmAVmur6BxupIqUa1s2kVRju3
	 /Bh23P9TmeInnu8UwqqY9LNAN5HiG3ieSCsVgi9Wd0I9W18aeg+FKElP9pB1MuYmiJqKE
	 BntGUGQL1dk+LyJRAOkjHffjaO6VAVsjyODTiswYegbshWGG56QLCGfgQNaTLoUhcxMGr
	 LyTCOL706RsUDupQmyEhrLnLsF4pMsW7hB5GSziRfBsZrnluRidw4TOoBnFsBu242VoaV
	 8fE5LQazLktF1Op/b54/3I7+TT3aaWuwFFeHY2IADVL90ZUkyvF+/Ejh01IWBLm7F5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090536;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qH1h1HN/ww+TEkMRFr9hsZOOCUZCsoMKAde60Q0NeQ8=;
	b=Tk4Rmgu96fxLZ9aDQmbjjU4TaKTNlMQiDogHY2ASJ/bVHA5PknydpAj75Ys7PdFUhFR/
	 D2dn6telAoS6hFaayD5w3q1jgD/xL31T9xl6J7tx9/rBVVLmOnGmQxDJVUT3ZAY9gmco9
	 ES6HbrucgBtcN7sCz9EbJZNnnngp694jFpJ8n/QBZQDcIsChDdZzkIf6CJD2RkiKp1Lj+
	 Vh3boBDQQtCa8Dv2BylHyf6M0qR6KkkNntTxaN7ewPGO7Uwl7+Fx9DDvTne+WjJSGob+A
	 xLaImadSVch5Bf6QgUk0s1HahCDce2fW9liuHFIlYRpTNxAkqqKd7GXebraBRWuF/SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=OwhZ1hsg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=R0MLcV3W;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9BC606A32F
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 12:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F9BC606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=OwhZ1hsg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=R0MLcV3W
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BD02EC0933
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 07:15:35 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 07:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795090535; x=1795176935; bh=qH1h1HN/ww
	+TEkMRFr9hsZOOCUZCsoMKAde60Q0NeQ8=; b=OwhZ1hsg1zl2gxIeP5A7k0heMZ
	eRbnCqYM+TLJ/MoRHYa5N7OrPXPuGXtqoIK9zMu5f6ewJ2wlU+GryhQCLOItL9fT
	xT7IYjRGfWYgZLJ6U9Cdg66YrfqRiiRUjXfLwjyfP7oJpcBk5WMMx/AO1HfYHOvA
	ztfj4bcXMH1CUFsZfD8PjBBgeLv6w8DCGZcTG+Z8D29SVJxPgdEpurSZtEZEou20
	yyufhRhdp9JhH3KUitIURZvq1aUExqsm4/rjxS6ufJN39HSz69Wx2+t1rCr9HVDx
	8QJmPjXJ1a+iVjp7BNQNp7Lv6i+9y/KsuVHaLgoKyrxVUyGdtceutw+OIVuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795090535; x=1795176935; bh=qH1h1HN/ww+TEkMRFr9hsZOOCUZCsoMKAde
	60Q0NeQ8=; b=R0MLcV3WtSxmIs3eVDRu3gLH8qhiutKDfUfuZ/TGYD9K5GB1sLs
	X88lZqp6NC+gSmirZmjCs1ReMiXmm6pGZFyOSkr6NqZ9aMcggGFIRRAhuaJBy8PF
	StNB7YBsUihT6CIqpAAqPLftPXBNLMnBWYMATtgqFhLRVVuJ7y8bjhbdOcSPFJTF
	EDBwgjaTo1Q+Rk8ByoKN6LfRuMSAVq9X+Kw8ZykT4erlllOnjXgoAho78aXOVcdW
	NUZ8T2JH1lxWejt+aDhqdKf76Z/eVCWGkWXrsAORkGyywehw2n44uECyzS1YWHmv
	z1a7bpB9KIoSrtTxHzH94TUQV6x263c/rFw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795090535; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:BjdOctiof+RWjg2h4jBSFyHA+CKkBYrHaTVo4x9XrDabSj+
	P3K6AEFj2vw82jTMDjf3QSyfntKc7wnslra8ji7b81hV0O8kqLB16bWHm1OGLOtH
	ZGyiBmUk3nAmbPtM1zSPL9AHiDthBlaC7nFCyTlYFxdGA3dNPRxylKqP7/Swbh4c
	K3e/pGpN8FUJu8x4teg4MFsjQyX3XaceVwYyioKiOwDuObSifmlDOOd0Iia3lHpB
	tXdFVJjLwzM2b+Eg/GgjoMZA/8PydNIH//PZHUta3eAPoIjK+I/QRaTvkVRBzhvb
	9H2iJQllNEyyyVztizI5XUdSR5D6ejQWE0fNUrQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:m4Fc/mwqkgmV7N2R4jNicM+/UBa2eFDBlL1dOcvY+ew=:qH1h1HN/ww+TEkMRFr9hsZOOCUZCsoMKAde60Q0NeQ8=;
X-ME-Sender: <xms:Z-j-arAwBImhrhY8vm6g9ytyZErqIACxWPeD5CpbYKD6BcVCDMrzRQ>
    <xme:Z-j-ao_SmE6Qw6LZb0mpPXkrGYi64kf74ZO4DxDgGPWMZKIWHVYQD13FMf_yyg435
    _JUWX5aWCGUJMyE_syzxEgw6CHNnFY4dAHiUUuVDPEHAaA9l1d-fa4>
X-ME-Received: <xmr:Z-j-aj8pkBYNmIWwVGyLZP5FPTuwNDzHP-8gns1bxdItHxhRzR4_juwGDcKwQLU4rla86SQ>
X-ME-Proxy-Cause: dmFkZTFZnGOdKRzMJBlowx8UXfAYey+ZiD2Ikd3gz8d5/ww6MTbrduy5AwAKH4jAjt/6Zc
    TC/LB+ym4Pe8WMcD7MFCk3UDlueSO36jQtRXvsX+1CvrPNQbW3Ytzcw43TpxtCIaE36QPk
    g1tREoqc9hMZDtf5m+WZJlBbiqyafKeEhznrOEGeTZcv4x/vLhxWOMOP3TVn5xJfqquYKH
    zkJhz6sjqk3bvva0rsjrrLkIPwc8+5JAl2r25St8vSbhfhQx88g5NikaGWiOZvyzkVIeW0
    NFxAN2kHPOTnhiVyfI6udMNHA453IocFaTqdhnv6efX5WxxApC20PlHTOz0LfjQDXQBIZP
    SB2ldlLarIIQRzdEOVAHAE/VcVXLfn9FRb0YyRBEXM4ySxWKPzY6wifx1N51vze5qmrYVW
    4R29bYWT48snFJQ1yZOVtK09ksyU4ryYtz1HjB4seS35paH+3F4RiDkIzARVnqTggOib7X
    Ss7X5AnUGmVBTWNmfsM0FKegjcQSKe7xjLy6Z0yeXvzF8VPrnQy9RAlB2Wn8KKA3N8gmNR
    PT35+0yYSWlu/3Naqj+EO4FOideAxIOvF2NMAfTm9n69Tp1IHIhABHZf3UseYMbDJvU/MJ
    55Io6WgBdQ6rb2qUfd45EHtSFVX6V7ZR9bbXYNCQNwOKGoCy3mhYI2ofLDnA
X-ME-Proxy: <xmx:Z-j-anetTrFbg5rU4BFg6cfk9H9BPd8D77HYqlZ-eWZySY1lOQB4TQ>
    <xmx:Z-j-akFBbrQXYC9-fbdgaFmYNvnkCu1sU_tN519gV_5ZedgU35BaMA>
    <xmx:Z-j-atevD3I0_mOYJ3Znd2YrVNUv3NyaSDkhyIOV0LKYLEe_EhUiXQ>
    <xmx:Z-j-amESsKJXoYQQ4wKs9-Mc-F5mgNL1itX4R5bqn6PHGNraXBzSew>
    <xmx:Z-j-al6fByh6Bj7QyGDq2-qACEjqGfnzFwPgRWVvMLn55cNBvY6Vu2Bk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 07:15:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e83c7c3a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 12:15:33 +0000 (UTC)
Date: Thu, 19 Nov 2026 13:15:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [PATCH v2 0/6] object-file: eagerly create ODB transaction
 temporary directory
Message-ID: <av7oYYvxdMutzgyP@pks.im>
References: <20261110002251.2007617-1-jltobler@gmail.com>
 <20261119002043.2108654-1-jltobler@gmail.com>
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
In-Reply-To: <20261119002043.2108654-1-jltobler@gmail.com>

On Wed, Nov 18, 2026 at 06:20:37PM -0600, Justin Tobler wrote:
> Range-diff against v1:

All of the changes look sensible to me, so I'm happy with this version.
Thanks!

Patrick
