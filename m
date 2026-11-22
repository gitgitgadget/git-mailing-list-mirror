Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795309035;
	b=dyQz0ApoDqqSUPPL0Tp41+ztQPiK9Tdn6U1TWR2ZW1jpjzkjq3bItVa7QV8N3RWX3Mlq
	 izjJ1OVVVYOXyUFRby5z8vBovdIlXILoDCgyVzyorZgV3/63ibTQI4I9crQOESmjoLpJd
	 HBpys1sEcLbpl4WS59eNX1uy3J9Jvw0X3vnkGB+nC7gnfAhWGnv5RSTZjLhAOls0ZWYAI
	 H6Smmhkb5CyXz5g7i7XYquNKL9VMTAxYzAo0CrrKekGhiuuzQraKSP2QOJkGsMDSOS0zJ
	 yo3UMlRO0QAuetA2yry0HxSrnsUhvF9XpH4kacQvd/WnW7C1RhMG69prXrMO72piRuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795309035;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XnORRzmkupjTo3Y7Umsg8J5L8FK2ywnsE59U4tLrvu4=;
	b=uIJyA5xxs+IPWBMESOFPQrmDxaWxT1GG/oQfKqrFgWaIWtCYCGsiQQwJrNtH6eTvq+Bt
	 kWD7O4nrl/9nHCW2T+duzWglpGuGcEPGSJpud5HMI/4mGcjFX7BuQl7kkaa2p40CLvsem
	 wPC1GHHeRT8FO9/G1YEAzeNu5Hqswx6e3eoqIBuReNlT/rgXQxIRTaArs0cImLroIuJ1W
	 uqlZn0KuFrs3O52ooPV8upLLzaxl4mjm2ykPBX/7K4etxqRwnImHKSLdcPXUl4jJWZSqw
	 k4WvRwIn1q0mHIm5ubiRQgYKmClZFE6j+rQpzM/iX8sGt5x7WUobFkyiUR7Cz3U+EIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="b/9PYVEX";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ppsAsuH0;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEED2606A320
	for <git@vger.kernel.org>; Sun, 22 Nov 2026 00:57:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEED2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=b/9PYVEX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ppsAsuH0
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE42D140015A
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 19:57:13 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 21 Nov 2026 19:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795309033; x=1795395433; bh=XnORRzmkup
	jTo3Y7Umsg8J5L8FK2ywnsE59U4tLrvu4=; b=b/9PYVEXcpqjvZWKLi8u3gL/K/
	hOIZb4wTk7ZYNkOYx6IP5CJUI3InGZ7yqyEvVh+5dT2QMl03WPdizTAEOFIDxiHc
	FKFWaAac4mg60RKtdodtkI4CZjhnIiG//WB983x0vosDkPRKwlQS3sB4XiVYw5Nk
	MxW98+I1HGLBcZB2GhjPp9/czrsKx9OzesAK1+WTbaFcdL7T70QHXsNGiXhD3vGb
	AqceOmShmUghsQmIDkRXqfZ6wZMSEdAKh9/WAuojGwfQTAp7PD2e4id26/KdOxi/
	hFc89HyKIlSo47J1VNdcAGCUgg8LWXTCH8CqnAfWmTfweklVKmK3FRRMa/dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795309033; x=1795395433; bh=XnORRzmkupjTo3Y7Umsg8J5L8FK2ywnsE59
	U4tLrvu4=; b=ppsAsuH0L4Ev3KLczCzyE3Qsh8b7pXiHV64L+B/MSyUD73Yd7V/
	qeZSxMzWNqACI+AWb2vC1HqW7gZgBFEmrqkKckJYqcRWJqIEDULtwDoGelmcu3Un
	hy2gSIXTj0H8kK0BQtOkVHmW20puSyR5yyMHKn0YSPNx8AV1nwijIjqFsBHlzb0D
	9col0F44/xjLh80xmhiLapmCOzFQieJTUqeNDMxs1MYvHlZdxQDC+ePc50PZC0v2
	Fya2ktOkZzeBYlK5izPY9OwRZrMjMrQCjY7RCSvsoYQixCLq1eOlznnte9en6aOE
	1cMydFBXT+JWM7vX9qJHS6Ni3t1Bai+Lt3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795309033; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:fIQkbez0adynkqNfHMA14c5uowX6vyTAF3YP2QHnDF9vwrl
	Z/GBRwqM1O38U05fntZAUg8dmV++YPTyB5hXvA59x2haUtBTKmDxvctUpWZL35AH
	bpTkrrxg1EN2rM8l3+6C1X2fmrhyYZnKpF1wRK/QNEI8uBAwbYzV7AYYALs1/jXz
	YhMypGczRwut4ZyhGpY76CS+SXtGZ1hY4HrJjFMqFZzz+ioTQt0atmuxop55DKBH
	tyAWaRpAV0lcbJT2f4ktWHRiMm7Wx8mB0JcBC1YiCZLcqmUpXc8o49Ssx5RCFMG0
	hAY+/1AHBKss300Ig24PfhQbbx2x3ZNFU87bXYg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:BosfAy7QvkUYNG5SWvNcIVducDSh0jJ4che2yXXleGY=:9mHurqTz0AmCM5jK/seudxsiX6xjRyrrT59dX3nn200=;
X-ME-Sender: <xms:6T0Ca8ZcDirI128va0YFlqrUvXwA9rqYpfg6WIYRhNRRWVK_StkCKQ>
    <xme:6T0Ca59EszyuLRj7uoW-P4_bg7YbYn1KveRhvc4cow0jZKTwZXp4IvjLnnfXgZoa8
    TNnoqlEc_lf8ffcpF7F2r8k7q8UV9zBp41riiT2pzCck2zHzp70-7g>
X-ME-Received: <xmr:6T0Ca6nmrJNaAcvrzLH1S9rvTZ2mQdoQIKTJgxihxR-S8rU0Z-RDDZhp-euf0VC6YXA6kQwXWpdS00wUeD0tbPifaac0b3uPtb_5>
X-ME-Proxy-Cause: dmFkZTF20+BbNu9f6kfg04MdMb0ZYonCfl3gPPa3r7J2nB7HInycW6xTf3tPODR2U+SIZl
    6/VIzH/gqptVmDFzBTc0+2+x+btFzT73ZrFUEQoIbbUBGqBPoRgldXbRY+dDelnXJPRVcc
    zMDOfIBGZzqyp5x4VL2nkxWVaknzrSL0hlo8oLsslLeM80jAiEq9h+IRxBldAU4rFNkNCU
    Npca16RYgy076gKqSjbw7w5QY1Fp3x7mlvAWJFDZUgz+ZcDjHrFoYAUpyPKY9MaRb6MmIu
    kAFAfLtZN1+do3qhiWJQUrVdtDGPPG/JSSHSnsoovFbHePnRasaoZLnrk5LjP9QL3urImq
    KOcTyASP20jL6uMQ677mKB9IO6Tftbc6zy9hrh/xCr8gpYT2VBcTwcvfBM+DDFkv0KnArI
    wh2J1a4U7FN4x1Sa2FLwgGnRNOi2k6J2mL0wIGqu/IUe78aQ5YaoBNZaZkbbS03ab99WAM
    x4EMa4/waGr3NM8k7UfN1M0LlVbb5l9T6tYDl5x2NrmWhsorfE6ZIaJMy/gRZuLcHd/EhD
    qFHFtujM2V4dVCh0chGw3JGtu9HooDQlYOkpZAIuLX+LjryZlD22kDx5kqpbgvY1PStnJ9
    HTN0Cce3YlFi7m77DUrZIvokEeZTmKJaouG1H2ZBA+XeR4mAi/1q0by7DOxA
X-ME-Proxy: <xmx:6T0Ca2zBMnejFerz17GCKlcYSGBEDMMLIBbwKP8ehooS2yvuxibuxg>
    <xmx:6T0Ca86Sc9OT8FobUI0gfCOd8e-NiVz7gdjwBAq-MFjEvbOrwoS0fg>
    <xmx:6T0Ca-VLpOlXaj-8dyHvliv1ITiL6zPpHM6fleS-9f3Z23Zsz_3WXQ>
    <xmx:6T0Ca8IKR209WEIuJYA3pX9e2F45w3Qv0cIXPJm9eKkf5LwL_cc7xA>
    <xmx:6T0Ca4w46MYEElWyXD24Oz9HeaklYfsAUbOSc-XtRDGn4HVJsaXMGeKN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Nov 2026 19:57:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>
Subject: Re: [PATCH v9 1/4] branch: move the deleteMerged opt-out check into
 a helper
In-Reply-To: <CAHwyqnVqv7XTeiWc2f1ApM1-TmVHJZtcqyPN7vQfe0RPXxGULQ@mail.gmail.com>
	(Harald Nordgren's message of "Sat, 21 Nov 2026 21:34:26 +0100")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
	<37ef7636e069ce528728c43cd79f678293e0d035.1795184664.git.gitgitgadget@gmail.com>
	<xmqqy0anpbzb.fsf@gitster.g> <xmqqmrr3pbdo.fsf@gitster.g>
	<CAHwyqnVqv7XTeiWc2f1ApM1-TmVHJZtcqyPN7vQfe0RPXxGULQ@mail.gmail.com>
Date: Sat, 21 Nov 2026 16:57:11 -0800
Message-ID: <xmqq4id9lm3c.fsf@gitster.g>
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

Harald Nordgren <haraldnordgren@gmail.com> writes:

>> > I am afraid that this is a somewhat selfish choice of a name that we
>> > would regret later, as it assumes that "delete once it is merged
>> > elsewhere" will continue to be the only destructive operation that
>> > people may want to exempt some branches from.  The configuration key
>> > is named very specifically for that destructive operation (i.e.,
>> > setting branch.<name>.deleteMerged to false is a way to say "no,
>> > even if it is merged, do not delete it"), so there is an impedance
>> > mismatch.
>
> Good point.
>
>> >  (1) naming this function to make it clear that this is about
>> >      opting out of the deleteMerged operation, or
>
> Went with (1), it is now opted_out_of_delete_merged().

Hmph, wouldn't it mean we also need to allow people optiong out of
delete_integrated() as well?  I am not sure if we want to go there.

