Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900371;
	b=j0xXAbqXoBMLJrOmd0nqPKWxzQWw6Ml31ECfsQuWcWXeRpAArQUWdOxkpqy0Hn+of56Q
	 hKDRCQOePPFPd/m7/Rsogtgt4O8u13S92oLmebkVNoZZl8TqJP7wTNRRbG4jIQeqUA4c/
	 DWVhwIQOKi+RMSxWaPv7jaJUu93lTOkrM6t00EW02bDP1qH/KHztjP9Fsut/7i4D4GQTD
	 SjnKErENlOBbmzA+HEIKhOpEOFcqKUwBUygT12zm6QNJ/MYy5DFmdX5Dif1kX568K8+WX
	 ymzIziI1QCCF4gktJLohIntqpNU/pXPcrLmRHyKX1f8hUFYtOPxscEipYTtHVvQKFBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900371;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=AgKGbi3OqHKRCTEJqEBvVZr4o3FcdEV1KlyjQtuEdy0=;
	b=q1VtgVnCu7ZQ8eXbF5m4HFWPI2ArFPUxAn20bw4ewWm8mBJiIHrv0kI/1fhIlXjOcLq/
	 HV8lnDeQvnuWCTm6BBaqH7THBX+L/j5O5niFevDdZ4ElIo9nghOr0POobZgGdIulQWJdi
	 m/6Uv9MKyCQztu31u3tQDvU70ccrKwrPxQx+Lfq7bUIANd1wyjbV5I2Mn+YQgdZ6lVhN3
	 fvppIApI4QuAbZm29AwxEdkzx/YndsaE4Zr6QTGkyu1o63Dc88NCOaqPtWOqybAuDO7GL
	 h0wzq+dBNqcBs0tFe9FdN0bA2rjor6t9mSYXhZVWWStimLq7GPfp+etglG2rEUPwkYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hfQn7HT2;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="Tu/Naoaj";
	arc=none smtp.remote-ip=103.168.172.154
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2D606A337
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 77D2D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=hfQn7HT2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Tu/Naoaj
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E76514000CC
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 12:39:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 05 Nov 2026 12:39:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793900370; x=1793986770; bh=AgKGbi3OqH
	KRCTEJqEBvVZr4o3FcdEV1KlyjQtuEdy0=; b=hfQn7HT2jR7KFIdHNKRoPIOBxv
	LzJlIQsgaffB6jn8KYCtUJDYy3gCCT4zGg91wQnGWVPfxzt6jF6if+WKMyS7Mk1v
	2eHJt54Xxcx+FVTs1CZUC/MrL7IMN8GHZvsxc0yqQy5C3EfMfBnEkhBj7oNPLb3u
	jkmW8zuLBmmqbcjobYjS/xDUfHhKAkpJS6/9UF9+mVatu0LMGuGj1wco4KM8NaMk
	pHmTQgu2LOAmq8GlaBh5I7XAj2/3qdw7GQNknvld01R5VF9WqOsnSE+oyKeQuSmz
	+zqRJxQCh6aotbgAAJL+shJdSqLMKKYNQzm16W+7BqQbKQPHM9IdVjKHC5Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793900370; x=1793986770; bh=AgKGbi3OqHKRCTEJqEBvVZr4o3FcdEV1Kly
	jQtuEdy0=; b=Tu/NaoajF4n2ai1JO5sYqL5VuDWbCEYP25YaYQvfCc1u4YOMPHF
	7t0Ftu91G140wJfE8eMVmebR4mQceW3LdK7HoUPk6yyNeROVuzZLlCW1UkW+o064
	msJqdy4LpxVkmxALkspV3xgyEoJLFPGn6GdHB4I8M5KS6lLiDEdLKBzarLKAWWeN
	2wclf5rBjQeEvPYIXIYlCk8AXbkUS2HxiUhvntJOMoR7WtXVxProw961nCpZVOLH
	YsBz/wz/bZJxheUOdlXby1ahxsrcZEUVG8P53EmyYD35Miw3bAwO3AEKm+Z8qWYn
	uXxxGtEEYuSFCksS09igBgncZUGPeFvHIbg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793900370; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WlVTfiXN+s4LZfrrK+PuRcB6dyPGGiDBjAWcNVg/76MR/iM
	O7oXl3FLyLJRZ7gVnj1D/7fEHkCXG13FauwQGCKUHe2ZEX9le6RPaM/6Npdyd/NR
	3qMKUU/BYQb2VUy0LReqiqEzZgKDk+IiG/u99un39/Q+TTqX87/DCsXJHfk5Z8/K
	MLPL+LTVu2ft2GKb266A+jRiazUxoFadx177ORYZaZemjLfaXbI89+8Kdt+kU6Ji
	KDcEEfCDtlJYySDKqFN/SEL6kqwdmkdLPzA7C76hNl7AUzgFz+LiPFIZXPlCrPyy
	ocrtSN0sYcmrVO88S3fRrhejDPOWbrA5msjB6FA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:URJWzImJj6XW07gKTCEEJ1LMSHq+/P3Dnga3o+k6ivE=:AgKGbi3OqHKRCTEJqEBvVZr4o3FcdEV1KlyjQtuEdy0=;
X-ME-Sender: <xms:Ur_sak4zo8-4dBq1fCwqY9gtXcJ3XRx7qrEWWJhnQwMXVtmD17SCfg>
    <xme:Ur_sapkt7u_EcYzQ5QH1CaPi4BWXw_5kN7hw8H_qaysrIINRzTQVzzaXV8vmb_wxd
    9SPNXdaXT4z0f7NE4ex2BlTzrurlGxxFwHPS0FXXRBKP2MOVRrmOjD0>
X-ME-Received: <xmr:Ur_satQ6MCXI41b5tMiyuWStLYLdnutWDITaoOxrdbC3PK3IK_VYTncEJhCrxNiovjCiTqJTH6o9yodSdW1GNFvgd-O-KmRYsz91>
X-ME-Proxy-Cause: dmFkZTEaWADjM+Qb8XcL1hGku96c0MAArNdpiqmiSM6t2dzU7yfGwoyfX29N0irQyUG0v2
    f7wZ9FuBnHsqlkGdOtBmT/62R3lQ7PS+d9dfLrfYQpqPJR3xMXZz4bz8EMYjTW7R7enSRP
    lSh+xm6wtOeJpZkeDLwtU4MqpYAF5WPGBL/P6W+RUlIR5vjOkzw9OhobDpbybfamvnDA3y
    pvZf3l8NiButSdhYftCK3k65eRmzC+A9hW3Heg+6wKUN5+ml3pJaPEg3ywUsj5XlBmzDwO
    tfF7VgYyVFvQBJ+0fF97+H4POyXoS4XpS8gX0QWjvde3eszlVAwETYv9Wgc4r7URQ1dxYT
    fH9/qKpiL/vW41DgCIo4bxjTVw3Hf3S/ULEFis5ZfycQNKYZYAAUwoEGlZnvaKiInF/RrF
    twRkMyt3UNuUvPi2ULgXLB5QHzlFNi5XKwZu/G2ykdmVRDRptpn5JtjG3IfrUa+U1NOtTb
    RACHrOP/UBmmT1gcHOsbpGjgqdQ8GaW+kmIXFTrPXTWB9lqmJvpgNxv0DDgBG85xjzl98r
    05y7/iwaRK2aE6KqEb4QNDi/CHd/dhilV2BtIQ51r5sWBN9TjZp1RiJx6sghSDXb2hTNDJ
    NrW0nIy4TbxtWod0LUN+WjI6NolHXrGEiqizmM8/NwiVX4LN+y6lVorDNbqQ
X-ME-Proxy: <xmx:Ur_sagH0wCGl4mI2piYXnmf-EcGtaVggsTwHYG4z81FD0rOvafHyPQ>
    <xmx:Ur_saqGZwu8Ghlakrt1uDp4IOPAy4wtIEfLHL3QSN5HbiTRY_Ano0g>
    <xmx:Ur_samQufrmEPPrYX2fuWVlus6sCCxkJvmWoJoLXX10JbO4zKpbUiA>
    <xmx:Ur_sajIPoOKwJaKmLKFYjwRqkaB4UB4pPKjleNKCEvYVmSsBqDY-hQ>
    <xmx:Ur_sahWakXhE8tPTnz_FrhTHlURN9d0nLb5OXx5sMaDCiLqCMv1dGOcD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 12:39:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes.Schindelin@gmx.de,  ki.stfu@gmail.com
Subject: Re: [PATCH] fsmonitor: invalidate untracked cache after losing history
In-Reply-To: <3d62a579-5bf1-4431-8bfc-757c3c873d80@gmail.com> (Derrick
	Stolee's message of "Thu, 5 Nov 2026 09:08:30 -0500")
References: <pull.2295.git.1793806679163.gitgitgadget@gmail.com>
	<xmqqmrroyztr.fsf@gitster.g>
	<3d62a579-5bf1-4431-8bfc-757c3c873d80@gmail.com>
Date: Thu, 05 Nov 2026 09:39:28 -0800
Message-ID: <xmqqmrrnw52n.fsf@gitster.g>
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

Derrick Stolee <stolee@gmail.com> writes:

> Let me first see if we can take that patch instead of mine. I'll start
> some review over there.

Very much appreciated.
