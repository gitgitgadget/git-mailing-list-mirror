Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794617;
	b=BwUbKpbjlKqoM/QUdHJu74UV1VAf7mwW99R4FmUVhp2e81GcQomjUQeDEUrVdXQ3qkIB
	 vxpXqxGHUJFDoHVkkClosbGoP5LspdgB8D6KXemOjNq6j1Cwf5/zsJEgzAdfrs5UqYCIc
	 2onk4lTBbKYRiriq0u/mEVbGXQ4N90mQ5Yv4ykso4ZVMIfP1YFD+YPZuRYjCFwZprg+de
	 Q4BVoZUIbkjU0Dd/fYK9xuyzobKx7zve9rDnZNjRwOCq6YF8YdrxCCckHtgBp3InXgj/T
	 q7SpDaZd+ufLZZTA6z1lQJP3/5gPFcIlEV7AuIAQWei6sp+hfqE9ymOye61x8xijgxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794617;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=1xndHHjwZN0bQMzrqEsacghqAaEejbY2T0EmxMSBziA=;
	b=PO6YVF+haaw/ZxYqT7H+sKKiXQ3DO4tx2GsXdaXS6GPZIEOhl2guZWNVqdF38JsV7YdB
	 2rniD3tw7I9a2c0pSfHsncgrMPshdCer2vPJuEAVAcri+PYFxn37kSHTaQy163QLFYja3
	 Bh20N1ZJvMsI7pDXq7eb/ecyYWkzAa4TupknYp6ICWxTWbcO9tUHVWLsf2oegJKihEtYw
	 DMJjX8Zr2Oh76Dax6zM2qWYR4PRW1ZVl6xGAjAXfm5/RLu7BInt3RawvPUfyDzoG6owvr
	 XprnIZXYkztUJ9fnL47YokcV+XzW/KBGiMhrrWLQHJN8l6btq56dz2xPoSP3G7kHPWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nBxSi4ZK;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xZId4gCF;
	arc=none smtp.remote-ip=103.168.172.147
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9C4606A326
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 12:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E9C4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=nBxSi4ZK;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=xZId4gCF
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 78923EC00B4
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 07:16:55 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 07:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1793794615; x=1793881015; bh=1xndHHjwZN
	0bQMzrqEsacghqAaEejbY2T0EmxMSBziA=; b=nBxSi4ZK8ijh9cW4bzi4oqHRQe
	GfsauQutAdVrsIedJ999vunlgy6fkRdq3NKIjUmfb9OvKZs1Qcuwh7DaWhJLZI/z
	u1DSgd4HpunO7q+9ZuS9Eja1FsMRLBqPJFWxnejbA0miypC0y1SgKV2kUJ5gYtB+
	Rj80mrmIaRSbtOvLn+10HmbA+zgREJITPKpP6k0gCCsvehkiyH+IrcPyZL8UKBK+
	VWtselWIM7Bx6WaBBJWhEY54NGzlYncsqrHTU5DlZc1Cc5QeDd58/eT/b841W8cQ
	3s2TBs0iejsaM7JfTnHPns3+i4rP/HXUIygcB4p2SjdSGKyJpL+SfYmwSLMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1793794615; x=1793881015; bh=1xndHHjwZN0bQMzrqEsacghqAaEe
	jbY2T0EmxMSBziA=; b=xZId4gCFqg2yoffEJlrMMW17K4UNTEh1Q8QfGAkD2Bgl
	TMnzhPw9Y7p5nWJEe/2puSSXvBYbY+S6OuH33FFiHMgcbMxDB7CwJJQuerbNUJDw
	n7jH7p38JUSYIiNr+MkVZXKjmIiJVnRpA2vy9tRUggmWOMuyYei777174Ufa90hN
	lJuLq0JU937Kzt5tIWQ3Jo6WUKFZodFqpCbbKTaAFwo1CmweNlcdF2DrMacKzLyN
	YzRrqgS/M+VO1lLkAUyqXVNE98TiKjcRahEbT9hwKKN//wN+T6Zoy2NRy/oL97HD
	p4NUb0RbfqDvQZwcB3hF5CCsYk266a0G+A1WkTY6Iw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793794615; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:0ABjcPAhkb10iDVfu6tSK91hXpuwTYF01bvyEoxGBeHxLTR
	dit/B2+c8OMVV2zdneNq81GwaxKN+8M+wM1Movyvbd6L2ky0F23KZal686m/ExIm
	4cE4U80JCpNEGG62xOQyAhKCMIXKhWMPI/7KRNARVxyFF2dVCK/SkiLxN7fDQSs6
	ugo30w4hjsN749MEykTrY0KenVkbNMMHRmrx56r6IbSCtQkAgmvWHb+LuOB1Gq0i
	ohwMu62m4xjU3iObo1Mx9ZGUucqEm2uPS+di+w5QCPU6Nyn0voUjZg4Rq1pQAAUx
	z9KlHcRkk65/YzunbqwnebRwndEm8i4gdu254uA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:FQGcUKhH0yj8ZrfRHVOH6X2ajJwaoe/sYIuLR3grG7Y=:+e1mdgp36mqkbfam39kUgRw9xkJnNFekO3Ux3nCjHk8=;
X-ME-Sender: <xms:NyLras4tFmie6UxrMO2CJmvEN0n26uKII1jUyU2bF-8_1EPX731xBw>
    <xme:NyLraj40FPV_Ur1ch9Yl0FT5z1OhjxH07MVdBBx6GMYWJbgWxCHNq4232vMUQctHb
    VqW3Au3VZnVE8tQZ1tyujSsf1CfMqoIrZlJUmucuFMfPUhRbi1b3g>
X-ME-Received: <xmr:NyLrapHo-qHJP487l5ZhutOPwjwA4qG5jIM9aiYB-YO2QuEh18r6jxiaT70quhK32s1KQ14>
X-ME-Proxy-Cause: dmFkZTGibJ6oNtkUtQEroLnRFWxcjPslAS7erEA2/WjLwDwmPbmr01vuBywNW3PEOWY66f
    kCoL12JCSXkqhx2YxfvrvI9MXACkr5KqbbT8431USxX29A2Ts1Mq0hv/qyoTlC7EUR7BGr
    oJPdYFR/GhyyeJhhikQNXBH4BI4fJSv1kqBEGhirk9MsV3dB5g+m+Sdm7NgW8xskM2rdBS
    Wixi0Qt8bwaebHZHOlcj+mFTmSBzGdV2iKrmK2WvYW0tu5iSYDkSY8feXgtc/f2sfuHgsY
    yaqjAMedE0X1p1Q5OemMZJ3kDVH2aaoiSdg2QzDl0hZl+exeaK6nl792mIm61qeSkUxdXz
    9CIHCM9AT+o48cmb2ib/Sm5WKSqCWuoNAFw0tXhNprQA5Mw5F9b8dh1KAqkMjP4VyAmgLl
    Md/1Gj4M9cYeCUSg9EprpGvGAgBMcs2cUuen32NqLaXur2E3jrEfUXK4XYyLqegKufqGCI
    /h1FFm2GzzUVSDx4TpgxmEcNP5igiSyvCeMMtiBlnb8zeVTQcyibIFlnBHWuDVotcNTgAH
    gza9BN70KgLkujdF1mCwShkezeaLn4vLWal99QxBiKApvB/qsQwvzwEEW/KUzJv9vhEFB1
    h7zQiMAKzFGdZQyHZoaZmI9Bax8wB287vxBdoKenzBD5+12A6yrdxjTfJ/Gg
X-ME-Proxy: <xmx:NyLrasSUTbAlFLTEjGMlI3USA2pX4H-WI4QnL6unoPgTDFdjmvcNhg>
    <xmx:NyLraivtJstr5cKfBJeQUylfZKYG0Aao34KGBsPe_iXfGXxV3JOTWQ>
    <xmx:NyLraryI4wMISHJE1vzztizAB2E13-rlTguje38jMnPkodtalVo7Mg>
    <xmx:NyLras7SngUAjwam_KgKh1Ura3OHzNUt8DgrREO87nS7knRKQgFZiw>
    <xmx:NyLrahU5T7G50mQ2YlRY5Hg67MgLH4v5MkxSgg2aW9pbic9ORmmbl3Co>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Nov 2026 07:16:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 845a8088 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Nov 2026 12:16:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] odb/source-loose: fix failing existence checks caused
 by stale cache
Date: Wed, 04 Nov 2026 13:16:33 +0100
Message-Id: <20261104-pks-odb-loose-stale-cache-v1-0-a00d5cdb5e7d@pks.im>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB3IBNHaq4iLGEedVoxkVAri3
 ZvazYNv8f4TlKOwwjM7IfIhKmFJoDwDP7llZJQ+GayxJZEpcH0rhr7DOQRl1M3NjN75KS2VZKr
 6UdnaQPqvkQf53O2m/Vv37sV++wXhur4XU3ECfQAAAA==
X-Change-ID: 20261104-pks-odb-loose-stale-cache-c16107987290
To: git@vger.kernel.org
Cc: Patrick Ohly <patrick.ohly@intel.com>
X-Mailer: b4 0.15.2

Hi,

this small patch series fixes the bug reported in [1].

In summary, when git-merge(1) writes merged blobs it may be unable to
read them back because the loose object cache does not get updated.
Consequently, we may think that the blobs do not exist locally, and thus
in a promisor remote we may perform a backfill fetch. But as the remote
doesn't know those objects we'll fail.

Thanks!

Patrick

[1]: yrjh1p92qc7w.fsf@pohly-mobl1.fritz.box

---
Patrick Steinhardt (2):
      odb/source-loose: extract logic to retrieve subdirectory bitmap
      odb/source-loose: fix existence checks for newly written objects

 odb/source-loose.c       | 54 +++++++++++++++++++++++++++++++++++++++---------
 t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 10 deletions(-)


---
base-commit: 750f5de7dfe9a4062f95088212b063f189d50e91
change-id: 20261104-pks-odb-loose-stale-cache-c16107987290

