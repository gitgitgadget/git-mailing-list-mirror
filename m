Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793611885;
	b=ZhRqxQzkCUNEpiVmK9On9Ujcc/yaBAvuPEnaLmrsD9QvWiIbix2HQEbfZBeBT66yiKBL
	 3xh4tDLzuEnmQaPH30+bkRlomU77btyClc6/Y4Qz8UpWlhTNn/pHJEkpePkbiprrOc54l
	 FxmSG7OZgJUZWWiAjyVCNCZd6zBsiNz93AP87RNZCyYkPv/v/bMdLN9qV7f6OhQAT4hz2
	 HMsmNEmTH1MT7hP5va8ET+kNHlV6ed2/i6TjhKe0/W+AulqcV8/mhf4pYFq+WlBD9pzuR
	 rqBX4FmXuoHyVAxob4HYuI7uTrU/CilUFLL8wOyve8BI9WBQCypbrKd7tHXu2MHk+HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793611885;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+LOHi1bz1VNl2NWMFRa51qehD1Fn01j/7ActfbBdJas=;
	b=SYbytIZGTYTdyEsSx+Kv6f2VtjsWzrjaSbydAPODLtHb3SVjsqI1LgObgOyitl26SFD0
	 u/MYbwquuDMAYJZEXidnzu0d6rWtdHik3g5Wr3tyPy2GLowVFyMenWpLW9/QWDF3ao314
	 7opZrHHwy2BqDCUCKD6NuNs2rpaIqTWVXVmyY8l4QnmMdWooSeqdYMIb0Md7Y6dfy9pdj
	 KSNuYhDaVTy8+SnG+7y5WFH0UeGWQy4QCzZgjaCuxNXzCis+6p/EjsjY6PxDv6iYuFC8h
	 dZRPN7Xm1vmF5F0SvHTOO95GBQwwsuOa7YbemBoy7Amk9GJFLpY9HxsykSAnaV8uQiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MRdYmyNY;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jQiC3gkb;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C7606A332
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:31:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF7C7606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=MRdYmyNY;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=jQiC3gkb
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FD2C7A00C1
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:31:24 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 04:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793611884;
	 x=1793698284; bh=+LOHi1bz1VNl2NWMFRa51qehD1Fn01j/7ActfbBdJas=; b=
	MRdYmyNY77Tdef7OyOLpigB1E+pxAR3pJa2wb//4zE1yQZXvR/5tpE1hspT/qiv2
	LF/BrRN+wCm6A9L2ania/K1BFILv2Xrn2GCk5wxqQhWNTVpXx/nAEiR8PFqctToe
	DgIa159U8Kb+USMmtryOYv8UMdE5AZyB49uQPXlRzwORl3S8NAszur3pSefD5Hem
	TofDqy72QGIJXw5kmV7dL73AXyamwptkfzKcVBKDEhCSyp3kEnabNCWWN08I45GE
	bcRpMobLdYwO6DLfQ1pex/3ZmdJlXiB7+2ghzjH9f/SzUfPvWm/6EPTJw57qvmuc
	GaiZkOrZoTSkh+T+jZl/4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793611884; x=
	1793698284; bh=+LOHi1bz1VNl2NWMFRa51qehD1Fn01j/7ActfbBdJas=; b=j
	QiC3gkbagckKJm9CiZyg39sX7QBk6zhZPFuHIgBW9FlQHWhylWQr9KOoYPylwGfV
	cOrfS0SvXQVScvmvWwXRnvgUxQH66vbetqHk6movUs2RkdR+jOCDuxU9yVdA8nWG
	OU6Ow1Lcw38NB3nytLW16n3AcfwdCrGXoaHDyY3158sVT/elPzjdKpBmE2tOb4aB
	N9LAYaeeZ7o4IKc6YiCs78z4ORum4qSB5VapVRKhc5kXmOfiMB/pCEeoB8Eco+mh
	wOh2vx2r/yeQ0rYxNIcoMu9zuhmcqxlw9ombiSqMf7x8HTY/UDAZC2D5FgRwMq4u
	YRmwIIZID3BNpVkPBb2BQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793611884; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UGxX1Xti6fYDmy7K7jy0qBFcsi+VVsxO7SwU9GUlN36iHmE
	HjVb6trYkhYEKKdFt8KqJx7PJrTEnSkEpq2Fy+jkuGCpF8Lt5ZfMemsC6iQ+Z7nQ
	GnSh98QjTlgguiLzPmInyuOk/3lXHobNQBxKUUnwY3V3zk4K+uwlaaN5J9iwmadQ
	fJbFu2lHZhIasHc9DZmBMnWZq6FfsQFr8Ld2BWTdkI98NAJi3xGM448DguYyVuKy
	rGkYkpKm0OeP1a5YwA524ijBCdm9EgzcqYYQwr8d/nrzclZ+/ymYPa5NRvDi6eg1
	0K9zl6YswtxvheHVWS7gFx3ETfWeFcU8i5DMbgg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:lmFOvm7v0lC0Cm9uKPgG+RJss05PBUAikwZGTHbBpxw=:+LOHi1bz1VNl2NWMFRa51qehD1Fn01j/7ActfbBdJas=;
X-ME-Sender: <xms:a1joahH88MBm7o0i0c-JIDnFjLeIUrEqVW55nhll52unC_6Ulhffwg>
    <xme:a1joao55cvkedOb_DVXcrO1QrjKh1dfKByKYxVCjRGNEq2fanW6zvzTkLoOfNzHho
    8ty0Gwg-xQ_OYtSw0rTmJcl_-DV4IFJMCGXzALhg9z16vkfsrMWeQ>
X-ME-Received: <xmr:a1joamwq-ci-e49z61LTQuItYtO2DX0oxBirnP5dTNh0_DCrKa0Is2oHcWYHRcibpklWCK-R4i3Kn07tWoXHQyi9GhX3ZvxTdf6J>
X-ME-Proxy-Cause: dmFkZTGPvXlE0nmyUzz5RwcjwzWgjZ24GAwpPeHq+gpTSPGwymFLg5NFXlX1it9qaXejQm
    BLiBHNDS2/GQUUVfmqo+BSLAEql3QqvQRcisio+j9M5EXCkMoNJKkV9XJqWEHSs7rtg9o/
    fWkmKEvPO3ldGiSgsCxUqMmBPss7i/VQ/VjgLlg8swLbfdaEcvkdVH/KMGuSYKbxXgV7+C
    2ZIclzRUBdatwMwcJRy1onm6nxd2CAaKbfGSZncW3wTzjlf8QD8bl7GvrK3W6nRlqjPWeo
    HITTYnegc1RJgao3QUKN0i+jqlTB0b3ZY8JxD9MRqMULfJnK2ITHyhMex3/PLXDj7KTrMK
    S0Z6TAHn0P05K0tzPuZ+wL1GiR8ThkVaisk2o93th66scuyesMshHHwrAZ2nbUYHgPFv9R
    xm+ElLFsW7q5sBiJQ3Q6fD7iaaaAnwKV+yGVYFZAS2VDxPwQMo0nOpJUqV2vw23W6deSkn
    JNoOd5FB/+ChZ6gd+u0aWUDknHYicdVMUqHkyf3gwbMUETT+o1l+KQm4ax6hVs4viFxWWW
    fXi25nB2oitsb5a4giXetqw2o2cUfSLE3Bpk8wPsbs2p22RTC2IGMXq3PfNF5ng64HNqPw
    4HK9//Ta747RsLS7pq5rl+dZesGsFtJvL520PhaWZXWeWNhdModRanqjLWcw
X-ME-Proxy: <xmx:a1joanPNUD9Fwu145sXkvqlByVsLxsTamKdcHXxke17YBEK4rNHsXw>
    <xmx:a1joasn7gC_1rUvnldKKCv4xgO8qJYM-h7KMa7S9CQHSqgh06djMyg>
    <xmx:a1joasSAD5kdVrxtooUQz0FgyZAMH5P2o30PyOeMuO0FAjB4VWcQWw>
    <xmx:a1joarXnAI9iMi45mQm4lY8dI9xea5P_hUGqkit84gxO7xM78XmvZA>
    <xmx:bFjoajBi0VilUiE12-JEI19xYl0ae1RqRNO95ms_ZM8Om3M3KhQj7tbj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:31:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Phil Hord <phil.hord@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,  "D . Ben
 Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v6 1/1] refs: report old values to transaction hooks
In-Reply-To: <CACQ=SRFWAJSRO7d5PcTK_FZBJrhdcr1ff_FfTUWmnQNB-WBnUA@mail.gmail.com>
	(Maciej Ciemborowicz's message of "Wed, 30 Sep 2026 05:11:30 +0200")
References: <cover.1790196627.git.maciej.ciemborowicz@gmail.com>
	<cover.1790269745.git.maciej.ciemborowicz@gmail.com>
	<2af3eeadd18806c5298d53072428656885cff89d.1790269745.git.maciej.ciemborowicz@gmail.com>
	<CACQ=SRFWAJSRO7d5PcTK_FZBJrhdcr1ff_FfTUWmnQNB-WBnUA@mail.gmail.com>
Date: Mon, 02 Nov 2026 01:31:22 -0800
Message-ID: <xmqqcxsnlgut.fsf@gitster.g>
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Maciej Ciemborowicz <maciej.ciemborowicz@gmail.com> writes:

> If anyone finds the time, I’d appreciate a code review. I’d like to
> close this chapter (hopefully get it upstream) and move on to working
> on the next bug.
>
> Thanks,
> - Maciej Ciemborowicz

It seems that nobody was interested in this for a full month.

Unless we see some volunteers to give it a review in a few weeks, I
will discard the topic out of my tree, as 'seen' has been crowded
with topics that have been collecting dust without getting many
reviews.
