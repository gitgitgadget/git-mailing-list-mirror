Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098792;
	b=2GALdU2JIcR70o2FwT+V5EW5yF8o5cvrom5y/K5aRiLIIlM/fS9wSZcFrdhLGn9JfD7f
	 jR1uHm3Ul9Q6x44FcBrXu57w/w0vSkRBgrl65nDaORB7qBy9yw0Db91fcvvRA4xS29vVC
	 L25lqImt1UVdJzXtaK5sWQEYst4ilbzEl9FPDYmwUUP02ETmQkrm4nsRvzVJz9iquzhip
	 BqZrd1sYpmicFXd8C+bki772GPHF7SHrVZJvGstGi/qdivfV+jLoFfBTwNwHn477ACae3
	 1LonJT6FwBpXbn0PunikRuOQDVBgfYlOQiJ1Jtp8/rFdaN+cpLpOl/YvP99ujLl/hHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098792;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AkgyyoRuZCCUg3lHv/ciWNt6OdArI6ihQTMi5D2Fm0U=;
	b=h7V2QozPFizTAYBH1QnlrkXccX13rogeSLsj7YfE1cUNNyQLeic1FhQi/gY3ktTsMR10
	 XuyWvieH636SfHYLvOTFImdCTmCbTpAI8C5DoOa68v2A/8S5oa7xbYN5C0DP0KIb9VPXA
	 kLmxUx+9S3dUMyH5xmuH6OOjtXifUdVrPfb/pwNbh+7pD8Tsu61pKHNIMUVkfXeOpn9+O
	 SEe/jOBhLhhoLbIvphauDACMPAvBrGOY3nD4ATOhB73RFJgR7XyWredYw5KXoC0eEBovn
	 mUsZ3gtpIe/vP1ZAe98vSCV0GmRJaK+W3J879TgT0JMP2JAIAOIZArQWLA3oHIJA3Ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fhu5s2FF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=brkZEqDX;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B868606A31B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 10:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B868606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=fhu5s2FF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=brkZEqDX
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id CF4B01D000F1
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 06:59:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 27 Oct 2026 06:59:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793098791; x=1793185191; bh=AkgyyoRuZC
	CUg3lHv/ciWNt6OdArI6ihQTMi5D2Fm0U=; b=fhu5s2FF4c9z4easHkmgNYgFC+
	YEPpQx+oOrEKnLcNh88AnR06Nz6+yaTQ6Wl9cmSm2Yyicc0+JQf55rn01rWAtDfq
	XdWrmmPCrDDZNZPAYiqRiO55rCHgAFI7ApnTWaW221IO7iFvt1C8hLdfU9ZugGMf
	urJbYe4jH8r+Aho9PaYMobTm0Zwn8SNCFBMEHdfF808eSqsSvyPB38AHBKzKU1W4
	R33/HyFzu37gxU8aFrDKjLGUHed5h3hReQ7DcuTlyaCLu5dd2KwrEw32kUh2Cw2p
	YAGKeOPYDKcdvARYqZSkjeq4Zz+p+UMXW3SYDWxPolToYhX04vd+zJEcDTXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793098791; x=1793185191; bh=AkgyyoRuZCCUg3lHv/ciWNt6OdArI6ihQTM
	i5D2Fm0U=; b=brkZEqDXOMXUg17/pK0zA1BBEr2PsggWBRKm5xwv4rGTwaBfYz7
	rC7YTeVpk03+lH75KMvRRZki4MbThbBiRr6/XbrPAzq50+pSExc4MWOYv4dAQMjb
	NiDIyDC3IZc8jmJg6fDYQWSPcko/P/CJXKfG6oKpbQsr+IRgl0bKDxXCt9kF94H+
	7Xp3lhpEGrBBAcqZw3r3bgA0lLgdY9mXaSYUe3+imRUFZlgu8iDcx+N5cFK2R1u3
	0ooEyw/+OFuf23Yf9daaOMXeTOJIfmre8aJo/LBiWXTfpF/5NKjkFD7XJlrYZLRW
	3Osgl28Mmn7YyX2qb5eWE6lIPLtwbCqlmxA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793098791; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:cFP66AzHRjpTB0E7vSFXkGkzfOE3FO8ahwAkPwQcc/N4xYy
	yWB3QGbsGTd4J3Z68YZvvifjK5zV8+6hSv5GVTu2OWMfiTuTtFsxwe8WkHhWprC8
	rJPwdpkeYqgoSi0jgcE9UXUtjwu8Ksdj5ErsRL+iqFZ7Yc5A9TlOnMJses+cBwA3
	t7DQATrsPzTG0q4Ps2+xpVwizPZvw0ChsqDjsSOpG0h31XbpQx3eQfzuyfl5Iga7
	nbdNHO5OK6OZAPIbEeiK+aiBrbGqWalnKG5h8jt1l5pMvWmKjvR3RCOoFjNDBhdc
	vTlFIR7/VOvX6J1wDiuDL/96H4rezhY/BLCax6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:T9Bgc/540USYuSrO0VxQI2BYG/oG83NM3i0KIB9NEMY=:AkgyyoRuZCCUg3lHv/ciWNt6OdArI6ihQTMi5D2Fm0U=;
X-ME-Sender: <xms:J4Tgaownd-WjOq_qrb0xvCluX-yRPBO1zU1MgZ3n_LCdPhIdAs1MlQ>
    <xme:J4TgajuWJVCicAYPZP6Xi3QTNvfi75hAaYcE2U1q_9JxLkUJA2-xZHpX8BG19WsAM
    3W09xzfPJepp3z6Jt2WN3pcfqmvrAIFJ5hHJ5GrpYsytyZgmL6jng>
X-ME-Received: <xmr:J4TgansB3MHphbyMDZl8kI2Mh5ChfFqeh1HdwMilvdqybDwp9WfP8w>
X-ME-Proxy-Cause: dmFkZTFMNnaKzt2lG+KoKptpMi0c0RXRWg/WgjPJ7MCnb7FWdWwM8squzc0TlyWs8N/T+n
    J7+YXsEUIGbL2Fg/dEOjElBBUgBko3JjlpLCgOtySM0KTmsy9O4ba2AaCQ8Yv8PjGksVUp
    25QjjaomYJPV5CbL5F2RyJ4L3ajywluW1smKZPh3R9UZVOO1c+Yztlfdv64vR4SrSxcYLc
    6X3dUr5kh6w9ZHQGPhFSCpLKf5+1d2hPrHI42SyniZLoc6OMNE2LcYoQeNUCqfY++ckV9m
    9270c2h+XlTMJVh1nkZcorU202Vie44ze8VO0wmoNlZmOe/5W7KV7Z8rSrq7LXtsPkkoD1
    nPBwuGhMBllpunvsHchahlh65ZkfalwPWNKSp+Tr0fcd12Cy0imE/G8F8QP5FEHm44HLGg
    +Ibzm6RPR1KGTGFbwbUUnHuIF0s6Dw404g3kp47JdsAXbTTWJz1ZvALwM8yTJAuyEsiPsv
    smLSIuPFGJ0S/4nx6y4XcFfMi/7xXf67oLKBvwFL2y2Aap8/f+Gdns0/PdavWZ1TX6JneZ
    WF0eNSGwttIT85LPVL9WnV00FXoz5HajsPjIfwYy6sY7ePvkNiwEKwxbry2xujHQ3cGD2w
    yK8uBPn2WbZu24Psk3trG6M97czdjj1QoY5rI1kuMQI0YCo8x3y7nD3H6tuQ
X-ME-Proxy: <xmx:J4TgagOnLyQqQjJtEDdhZIbxRmnsWf_NRnvFDe0QfWwlIjL0MW3Acw>
    <xmx:J4Tgat1JfDOymOTNLHa6_jvJplulYTbTf1v98YtjL27x1PmbYRlE3Q>
    <xmx:J4TgakOClV7c4_lVX3aQKmAkMiFt0WihP9YrJnVlwAVMbFbVlrwDOQ>
    <xmx:J4Tgal2yRzaHP2Pxm9QuIODhEVzcBXRzLR9ga1YBM6ZCObYxAOShnQ>
    <xmx:J4TgalqbRXqxF8Q9gHeBzSV_Ak343WaQe0dwr-9-52xP4fZIBeeY-ymy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 06:59:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00629d82 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 10:59:49 +0000 (UTC)
Date: Tue, 27 Oct 2026 11:59:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v4 3/4] imap-send: check git send-email copies like other
 messages
Message-ID: <auCEGdYgWQy5R8Px@pks.im>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
 <pull.2456.v4.git.git.1793089879.gitgitgadget@gmail.com>
 <919e38c31d83d3cb01aae49e59112868ea9a1fed.1793089879.git.gitgitgadget@gmail.com>
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
In-Reply-To: <919e38c31d83d3cb01aae49e59112868ea9a1fed.1793089879.git.gitgitgadget@gmail.com>

On Tue, Oct 27, 2026 at 08:31:18AM +0000, Harald Nordgren via GitGitGadget wrote:
> This makes the check stricter when some other script writes an mbox
> with a "From git-send-email" line. RFC 5322 requires a Date header but
> only recommends Subject, so a valid message from such a script may
> lack a Subject and would no longer be counted. imap-send has always
> required a Subject under any other "From " line, though, and only
> refuses an mbox when none of its messages are counted, so treating
> these copies like the rest should not affect anyone in practice.

Makes sense. I think it's highly unlikely that anyone ever formats patch
series without a Subject and then expects everything to "just work". So
even though we are tightening checks, I don't see that this will have
any negative consequences.

Patrick
