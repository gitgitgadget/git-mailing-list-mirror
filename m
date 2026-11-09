Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254672;
	b=rabiAJ8Ee/z7iDDzkZebctwHX1xl/89KGNxrXPcXGdObMFc7izu3nq1amQEPdA/lJmFH
	 LQmYz3o47skP7rw3TtqjXxR933kHCCToavatHvaS7bP2BrHhviZZ89bkIJywOXTvqlTe9
	 SMe0ktPFBLDzb16+Sc3fNp77oLhcPAER8qR2j2Ld5SYdxjWB36crf93haqMoHCA0HiDGZ
	 PmfeRUK81BZaqDIZ9ZXOBOHb54KfeyaspDvufQQMrlX5nhgOqX7DqPml5qYfHAbCT+cLx
	 xTEPrzuIrO14zEJ9+sjfHwv8x3/C/eSZsfmkcRmCwRS6X5UFAxdsQSF7C0yldhMp7mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254672;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=aXnw9NS0drSD+aXAu6WJUkClj/1AjrNrKLyBKqy+4VY=;
	b=cnShKQNrTLpt2SLXMVkI+8KcEByuxfpB0O77MhWdUDRJN7Z13mR0ZTwqOO2fJOG0Ca+s
	 MrpHM+eb1uf+TNMLsOVfL5xdjAjmVnp7MaVtReOC/wIPvAp0dMe201RLZjOtkWsv3wBRu
	 bf6d3GsnLOJ+fjlM5NN1Z2Q4LKnG1Dk3gR2RgaMyTygG4AfAIW0x80pfAqG8LOernYbFr
	 RXfwBdhlWfRWlVMnq92tdjqPqGHPSQKVWNtK3r2FIWKCSgqvL358MqStpwkPlZXGdwp9J
	 K8ZDInIG5xLRpA06REslUfZN+N15pbGho/v9mAQ5q/fCblrXx+umacw+GzlvW5D2bUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mId9dV8b;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DOKZNONi;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841A0606A326
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 20:04:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 841A0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mId9dV8b;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=DOKZNONi
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B58B5140012B
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 15:04:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Mon, 09 Nov 2026 15:04:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794254671; x=1794341071; bh=aXnw9NS0dr
	SD+aXAu6WJUkClj/1AjrNrKLyBKqy+4VY=; b=mId9dV8berc7Qm8i2i5oNui59w
	0thSvuCgPAFcpUSSPKtBlwy9gXOJjWtoe7rMGd/cQITrlak3Orh4wxm65ufDuHB0
	VSO2RJcDy/0Lo1afSqJ0U83AQoFKcvVLuBisS0tlEtxGeOv8+Ohp+ikNH9m0Tghf
	gN5jZREEMKLBh6sJqyL3HVWKMeXxigoxF5UG50couNFCictrofxWGy72o0mZ1Q8k
	OLXxwO2v2b+C37PgMabPUx5dG4z276/GzbFIvT8tCps3pwbpSGu/ovl8cwTS0apu
	2VXF3+3r6yh2ZUjKJYkrsGwtjaWFRXgiS5emuzkh6bcCQFPnqG+d06UvAEHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794254671; x=1794341071; bh=aXnw9NS0drSD+aXAu6WJUkClj/1AjrNrKLy
	BKqy+4VY=; b=DOKZNONilpB0CEJGJ58V4Gs7D7Xjvvd9/T8NvLXF7pEQkTVxrMw
	T9y3XoGxYV+PGEpXe641yca3t3WmaoUIGptXOtqWj+umSXowOBKdece4AHrv1AH+
	VLzaFXbVOwFWIq2iwEa+zYOwpOQDVyS/zldCtEHhUsWU0vcLOA6V0YdvJT1Q6oMA
	YN1KVaGmPBoOlDvm7nkiuaqyMbNUJWyhR5o8upl3BbDE7PlYQanbBw5lg/NQCxmb
	JALiKQEjKcyzf3y6RDBm1Ds1drRiFjH103L+Br5Bmu9Hcn0GtxLX5iHd7+SUTP8T
	MXBRGtp2XcTLHr+YQ/6Nr8UTp1ta0U+doqA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794254671; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:J4IReZ7pgLjKZiSkOSHgsd9yHUHIox1/0Cf7eqYeEQeRmGN
	T6QMd0lpv/UJRRpG9ilP5AGQQlsxozj+H5e7xJE6+T8w4/Zchr/uMnougB6CG9n4
	srGsIgsBzLZaWgk0y92QmTrT01xkJjfg7VN3OfN30W9dtJlb/uocfP4naLsW8uN4
	rauLX2oBU5x598Ub20k+nhfCUf1AcInUh5/CTj25aaeZgS7m7Ab96bA1TajpfhOh
	TYjSouegxBgkgkiJts5fqJoeZRf1wN064J39YF8NYfZZXJUJmp0TwxPj4FVn6TJT
	6wKLgPDU6DM5PLyTqmyDcMycUijFHkt5xhygotg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:vMotRowGZdvBu4PsIcx1u//h5LjG7GkXuUVmZ7+w/R8=:xrbVKuRK3mks7o6DBs49Psfzi6S2hZnAsbj/zQnIYFM=;
X-ME-Sender: <xms:TyfyanmGyOKKPihkW9iuSMBKU3yS6QtAUALkbVBjkeWKin2qy9myAQ>
    <xme:Tyfyaug4L5XIkck1DZkDzit0dG7G6Ip0GOlYNo9j2WI9v5E8R2gyJoNxl5ggOSu8s
    rGdzRPec3T2Y-pQsjulFDgBl1Duaxa_trm54HGnw7ti1V-iwCp2cAQ>
X-ME-Received: <xmr:TyfyancF3-DNu84ggmAPx5OxhNZip-hVy9LDi32YH5tJs9aKx41bQKA03QHgl-PhVRp8KWYCtXAqXf7NImHIN2Yxk6OMnA6FT-o->
X-ME-Proxy-Cause: dmFkZTEx63/hQCvTnlpr9E5Ca8pzsh/Y1YNjwocjLOO+n53CWyVjYNJ94yLEyvKMR9SEDR
    z1qn4H8V+Ved8+bN1VCBsAZPkHQ6DtS3abovHQ633DLoXgujLxh4cgta5pdVVArRa8mJWp
    RwqoAhWEUQGh9ML0NlrgZVhegEK4Z35mnmTGSTjEFM01bcV2JKk6IaihnhCLpftzHlKgKg
    5qpdLo4Lj9N/0xaEQYv4QJ2joz++3wKexGx/LTxeYuUmZdNMnDhIacaMKLx2qC0XraV4k4
    rOug+rAQIuy+UbJzpoUBLiIVyGES0qp3/oJoa4uyW/fNk/vnYV11nRkYUNo4RrpF2GkUJr
    rDGEa7jVnrShFQBlgRZ0UaqPAKsDpa+COpDa9CLd5lQBHDu9iBcv2ZvcVlZpYwWkVFrwzB
    irlaqxyRVcVE6lYckEfMPKhFuP1s2/HrB72yIyXq/8OgcpYarDvHARWHKQkt5WOw9s0y0b
    kOxoIPaK4AHLdmI5T49RbyZtwyr/zlWZbIdgHa46uEXZ8ET5EbuONzTRmKSbKMoex+Zk7M
    X5F35Pt2GoCRLG1RNLgy+5uPv4rAaOSjtGEdAVm9Jk/c0QmPC3p/qV4O9fGTS2MQCxkIZL
    57J0OUQR0wxo864fBwKNd+AHc2rNdRiCSss/992fq5xK4u2A3n9e43ZW3Qtg
X-ME-Proxy: <xmx:Tyfyamitfz2WPG3Zv7vvN0VCRkohFFQw0CcCDotIDn7UUyIIzSQ27Q>
    <xmx:TyfyanwUflce9WmWUTwmgEZy5E-RUGgDd2kYEOieUf7LT5rJygeBVg>
    <xmx:TyfyaqM_loD_9TB4G1Dmkrfgm_Fi1x0_CIdLoabzBcRk1OQsBQ5RHw>
    <xmx:TyfyagUBcs_6qQKThfw25wcLQQf5joPPSiaD83iOszRR6ZRFGFT9Sg>
    <xmx:TyfyavhX32dPt50U5abzcqvN4isEo3Ihc-pcbSDvIIKm4Yo_I3D5Vo8a>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 15:04:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Laveesh Bansal <laveeshb@laveeshbansal.com>,  git@vger.kernel.org,
  Karthik Nayak <karthik.188@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?=
 =?utf-8?B?w7A=?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH] builtin/reflog: expire --all and named refs in one loop
In-Reply-To: <avGU-Wjkd821PLc0@pks.im> (Patrick Steinhardt's message of "Mon,
	9 Nov 2026 10:40:09 +0100")
References: <20261108012213.89468-1-laveeshb@laveeshbansal.com>
	<avGU-Wjkd821PLc0@pks.im>
Date: Mon, 09 Nov 2026 12:04:29 -0800
Message-ID: <xmqqwlqlydo2.fsf@gitster.g>
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

Patrick Steinhardt <ps@pks.im> writes:

2 Okay, so instead of carrying the logic around `refs_reflog_expire()`
> twice you instead now first gather all reflog names that we want to
> expire, and then we do that in a single step. That seems like a useful
> simplification to me.
>
> One thing I wonder though: now that we first gather reflog names, can't
> we also easily deduplicate them? For example if the same reflog name was
> given multiple times on the command line, or in case the reflog is
> included both via a command line argument and via "--all".
>
> So I wonder whether we should both sort and deduplicate entries here.

Very good point.  I cannot think of a reason why we should not
consider it a bug that the current two-loop model processes and
reports about the same thing twice, and the collect-then-process
model allows deduplication almost for free to address that bug.

Thanks.
