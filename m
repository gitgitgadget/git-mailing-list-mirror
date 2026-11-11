Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794433815;
	b=arx9aFtfNXlmgFGIfiE1ePgo+j9MlvSZqfkuBDLDjTSR6Rmi8Xd8Wmwqr6oZT/E9feUk
	 KdKc2ZIs2TvOPIQ94pqV01/PkbkTGUkjpMCdUQSQSD/AptMunRFZCpEoDGQjodab3SN6r
	 VUfiCKx857aaQX4AgXX09RhbOwibRT5YfHNmslCBwDvpvbfsrLuz0myZ5pLPda9GZ32L4
	 oEChidn9GvJhbu9PmhGPYs0CEuGmOzn8fAUPiIklGbEurIasYKTnxFuFAV4eWa3+o8cwb
	 2hc1A9MyfjYxw3Q8K3gycE6yr6+pmLoe8l3hiFmAx7jlkGyeMhGEuIpbeY/SPWEpV3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433815;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=twN1tmN/58eJB6ZCYZByF6wZa1ilV2h8pr84tlwt/XU=;
	b=HQ4eSrmmJpHHONBXRsuVqT9K4BbpSxtufX+iw3sPwFJYOP5mWnoSmacMqyfzpSUSqYQC
	 RThUN5B9PrT1FPhz5N6x+nqNH8QA82+cQK5ahVxIPF77Mp0sWQUMSpoVND3f0/8KxSUxJ
	 pgc9a71+1ge0Wxa+DekFjxHmc5vi6WKelAA/KkPYMsO0x5FMaJB0ChnuwTl2UsU7O/Bzq
	 uAKvOu/t1WWDpZDN5sVmkMvsGYbRZDvtASvFsKWTTj0DcW7WIV4cQX5RjTfPXTrSOiYog
	 1IXpEgIABXuT1MnS9OGTNU5M4p8xgShzktpbodtbozCLb4XMrr7ivv/xahWFDOc+QOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mCy1SmZd;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WdWXdXcN;
	arc=none smtp.remote-ip=202.12.124.148
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DB3606A324
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 21:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0DB3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=mCy1SmZd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=WdWXdXcN
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AA1A1D0017A
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 16:50:14 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Wed, 11 Nov 2026 16:50:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794433813; x=1794520213; bh=twN1tmN/58
	eJB6ZCYZByF6wZa1ilV2h8pr84tlwt/XU=; b=mCy1SmZdOy6Ka0zxai53xuV07x
	HwBZdPPb4abwHtXCODbJywyPHFH1RVFDYJVcBvyjzdoxwbNWp+Aqg4K1YOESXbsZ
	Q8PU0quI7akUdss7MLMMO0dKouLF3jn4fohGmkOM5MzYp7PWjBnZuvJ32Rdoz2Cp
	xHr90SjP+jJJvjPw565Ug/1cJUQRgEQ8slrTtYoyOsSZ1v7VLbMhejM8umSXs++l
	k3X0cL1ksrdWgby0mO2pLfepLXz6Mx0uwLskmSAdf01KpqbpIg2CKXuwEZgBSQEq
	bxbr4scRlRL3OI1BKLvp2qhToDJm5/PVytEZbUBrhV7iZDBi+wo3ZVEJ3Nfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794433813; x=1794520213; bh=twN1tmN/58eJB6ZCYZByF6wZa1ilV2h8pr8
	4tlwt/XU=; b=WdWXdXcN5Ov/oKn6u//Lo3r9YKHl9CTaLhe7/BmHFVwVtIXURTc
	adsewLYGfoIISSl/B/yaZNm4rJzIlUfzSU8KDyLk/6ECDxfV50+iqX48ojMNANa3
	d8BkNvj3KO1VdiVjo+uc8jq6OxcZmHGOzTegDbex0QHvsfQudUMvxSUEJeLkXMbm
	u+LLeCP6BE9jnkby0GjGqWw5fL15e5Kq8TQ5X3WLOuDJ1Yo8SlBnG6Q/HGo2qp/L
	UOimDlBhpKHvSbSfiQFP1RlbQVn2NZXnKSRx56p8g9dGlJzV5kofhgGMcHfH33xP
	SP+hcoXJmnJV1qtEjie4sUQ/EocAMzAV7HA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794433813; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Muagmyj4GFOat0VK+ZejB0wtB3TrL8S2bNNJ9hIVfYNSjIt
	blB4ylS04ZlSxhKGox+Puny73I0YenNF6Qwb+GGIQkCXqijEfSW9t08AzSA+K3Hb
	bwAt6tJV+ltFfTSGAHGVlK/fm+g37P1RMlofaCwzwlrp9j85kLFXjQ3qcLfEoraz
	+jFLocR8tzwDRshUCvcSmKKBT0Me9UMeHb9eg6WPEL3/HpTA3sv/qSFhFOPOHTZF
	TDPQSALVQxxzs69jeqOd7fKcEomM5Xzu5DsgI0Jyg/t0bZL26pO1iBoe3PkRkOSZ
	IkQGTwBJ1q//1ChhdvNAS8zF1cBhNgJGar0Mq6w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:jZ0r+ZgHQMFstc1cpaxtN4r1WgaTjbn8UDNsgDq4AbM=:6TN7W5Ge2wVjV5DHY02gvb+hCwIkuqLfhY3nBc2q4m4=;
X-ME-Sender: <xms:FeP0aoNpx_ewnMGtQn83pB7UZYK6LqQZc9J6c-K5nJUL5Lr6ET23OQ>
    <xme:FeP0aqwJqURJ_9__SgNup24-HgU0YYCYDi4nBpQjwyDQjhiLsiVqat-MEcmuSuV0s
    S1MjVj5PxQkayX7ikPj0TQ5OkF-UHlfd9uSrmgE1EXxPNUWrwXH2Ro>
X-ME-Received: <xmr:FeP0aqrfivVQL2e2582m1z1twPCQxwccQb479y17Qul0igh2yVg6iFruRg3CsdcgV-RG3KBoprXmNxqiHWbexwe79g2TLuqFUnbq>
X-ME-Proxy-Cause: dmFkZTFnhaXrQZv0W//0Sa1x7lYpJMjjn3LbygKP9lX5u/X5d6AstCmVH0yTTY+JYhSmjt
    2OE82Plnuq9lAFC8WPmUGRhWfxoCTq8Z6A4Mjlp3Bk0SiHSwZ/jBiQGglo1BRKLlalWsmQ
    QUd9lrwR/3xin9CKcQS964j5JUeeE8rkAYyq+fqWN2JNL/jQKOZxpdePQsXFHm4SA3Tvkf
    coZtxUzR/65cZnQlCduujYs+pKi7PjyMuKsvKbIBMGbUqhs1ExKhIfPcdBWFvWTpfU8JeW
    77FTFkSzf2t37y8xY8ic9q2pcCOmOGDTOj30Jizr04baruTXnudAMz6ACqoLFKnzSCf/QQ
    kUuH/GFbe66PrOY5GJHmZrPKdnp/iddHlgNjeqLEyvy+fNSQqTD0pVHSoRU+GOTd7HsOAZ
    +2Qs9bV4tUnkmjVPhy+NvelVGFDrXEptI9+AFQSr3SMZ8LXAWGf20Z4+w99StqMGvKQcsf
    3HseOLIGfkTgEewavBo8edY5L4MA2WOJ4FDAXG8TYTI3DVRGFe67OCsSePHpDlgQOY7XKJ
    XswWaRaEm0o5ifkiiZkT90q4jo/VTrC2607CzOXGCOQFIyJm9XI66NJaw5m6zrQDQjUWtV
    bQ+Q/mejlQwHiwXrdjd+xF8+2mU6rOdbDPuspo4xl85OQvxtYQtQNLW4T8IA
X-ME-Proxy: <xmx:FeP0aqM0eiA-i7uhhMvmrNzaQqwwullRiCNIYmuc_M5mfYPc5yIqDg>
    <xmx:FeP0audxIcYyAncA7-PuzpPJ9DDedn8AayoN_wTdgRwT6I_wp9CAjA>
    <xmx:FeP0agXbheamJMCmtv0Q1mY9mB1SNnlIlhgQD0PVnI_TqCjEsCD68w>
    <xmx:FeP0avDM-XG4-nMOhpHV765S1Vq3qEaS6-Hi06xKjmqbM4pIT2qPzg>
    <xmx:FeP0ahQGw-1mJWwD6_odgIMfj0t0fk7yhHKG2nfQnM_Ht6EuCkGxZz8c>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 16:50:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Roger Koranteng via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Christian Couder
 <christian.couder@gmail.com>,  Siddharth Asthana
 <siddharthasthana31@gmail.com>,  Usman Akinyemi
 <usmanakinyemi202@gmail.com>,  Laveesh Bansal
 <laveeshb@laveeshbansal.com>,  Roger Koranteng <rogerkorantenng@gmail.com>
Subject: Re: [PATCH v2] t1010: add basic tests for mktree --batch
In-Reply-To: <pull.2270.v2.git.1794348807240.gitgitgadget@gmail.com> (Roger
	Koranteng via GitGitGadget's message of "Tue, 10 Nov 2026 22:13:27
	+0000")
References: <pull.2270.git.1792497283164.gitgitgadget@gmail.com>
	<pull.2270.v2.git.1794348807240.gitgitgadget@gmail.com>
Date: Wed, 11 Nov 2026 13:50:11 -0800
Message-ID: <xmqqmrrfm418.fsf@gitster.g>
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

"Roger Koranteng via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Roger Koranteng <rogerkorantenng@gmail.com>
>
> The only "mktree --batch" test in t1010 is the one checking that it
> survives a concurrent repack. Nothing covers basic batch mode, which
> is how the leak fixed in 6272f3bd17 (mktree: plug per-tree leak in
> --batch mode, 2026-08-29) went unnoticed.
>
> Add a few tests for it. Two trees in one batch should get the same
> IDs as running plain "mktree" on each, a trailing blank line should
> not add an extra tree, -z input should work, and a tree that names a
> missing object should make mktree die after printing the trees before
> it. While at it, check that a blank line is rejected without --batch.
>
> Suggested-by: Jeff King <peff@peff.net>
> Tested-by: Laveesh Bansal <laveeshb@laveeshbansal.com>
> Signed-off-by: Roger Koranteng <rogerkorantenng@gmail.com>
> ---

Thanks, for writing and testing.  Queued.
