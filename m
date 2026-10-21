Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792572601;
	b=db2E2h61oO7hdfLKpH3n0HWKOrfjOz9UIgcoUKfKxY/Yq1lmuKyKjogwV23XVPR0DWhd
	 V7cH6JlMQbvTtxdcaPg27bzGAqpJZNfcS1hSLfC7yByNH6a8CfoHhShGcUmIt3CrhjOoD
	 cPDCbu+Wo35fOHD/9Z2iXjy0wLd7sVWPhSmm7S9ILRwRgtglMzOIjA221d0n9NN6+QU9M
	 VnT2+Z4dt/GOb8v4+JLxTQ3H/8WcoiA/e+12eAXlqJB7VwpXrN8zbHxF3onmC0zV5x+3O
	 2K9Z6lbnqE5BKIveQBEbQu1Vsy0gNOjZXkAIPugL1p74lV2CxjIDa7KRDlgM43YMzRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792572601;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8lGWh79Nh9n0AbCqdrSCG5VVAVrqobT8OfUhDUoZnDI=;
	b=jZd9VCSkO1c5VCfj7Fd7YxagTq6LaPAgUkMR+wGWkf6mahRUqlREApZzYZbhHhCI27lp
	 AWvd73MpjonQiIhYLbqvGv71kxqMXMMa6K9IaFEa/5/5ujdpkxX0buwLPmgsn8JLvdk5n
	 zdlmnJxq3FyPjE7jjlodshtIJXnV/LFs2ufPcTsWpckFrAq2y091TmHRquhVbdg1WZhu5
	 HtBSR190o7WsLSyImFbMBd/6ETtggTA9j3z9WMZ/d5zS5xcDBposoOfMEtW1d4i8St2oX
	 cbiWB41MYg9OP/wLIS1n42QWHwxv/ObOQhjneO9ZHknmoIMXMoE/AcuyEsuAIgeG9zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b="aqE/6i7L";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b9U9ZOCD;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECEF606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BECEF606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=aqE/6i7L;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b9U9ZOCD
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 2BF2F1D00044
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:50:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 21 Oct 2026 04:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792572599; x=1792658999; bh=8lGWh79Nh9
	n0AbCqdrSCG5VVAVrqobT8OfUhDUoZnDI=; b=aqE/6i7LPfcT4jTc93tIVmfxtU
	zuK6Q6b3QMyGr84+gtMo+ArwISEU4+BPkLDAp+SgT9221OKnwYqQvaLOdcaI6sz3
	2km7fKDM37dkdkKmCKoanmtQsvXbc0neOWHcXjRz6T3hoH2Lq1kSFFzLrYTjJKg+
	W2QLlmmBgrDsjITZvU48tTzcxkZMY8QcG7hIm+nI7gu6wuz8ZXeLdpjy8MDZPRCy
	nLPs8e18eFdYSFpraQWYxkas3Ub/e5v2jWgoeceousA3Rd8JbPSVID6R4XF4D05X
	yQhnbsF72VE1qQFJgDHxdnvKSEXSFqgCGMYkKjdlBc7pXpX9PLApBRjmu/0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792572599; x=1792658999; bh=8lGWh79Nh9n0AbCqdrSCG5VVAVrqobT8OfU
	hDUoZnDI=; b=b9U9ZOCDr+1XoLLzvk3SR+UVlbXzm1h5rfvugh+Ey74Bj8b0cEj
	EkKIXg6+cFlh8sLnYZ0jNqoNPp327NRvc+7Wzt1wek1aMgtRpDwLrhbEJH8VHsYY
	Zn/SwD9tjAlzQeLyKMLzY7vjnjiuttlSIG2rZchk5fGL+bJYMKGeef5St5Z8znOm
	/TsrT4eJbw4/AmOL9pD/juMzpczxAAzAK0ZIIj23DNUbFK5T6TVqdCiVXcvjiFlL
	2OBSsPzLY6Ubw87apI8QedMe9hC4QkwKTe/Z6vs/Xh6aPJy8M+T2i7VVMzJkZniJ
	WoF7g1bxaSJAK6GnhywC2BGoBgHm2FIVhRQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792572599; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WIoDRzTWDrSI6Ax4fhr2Coay4Mv8igcNNPiPjPMTNJWSRIK
	7Vrj/KtpjKA5evFC0I54TBoXtrEL4HbnqY8+audChs0PWMCq8GeGeitNxstsYBGX
	j2Rvotavl/Zw4kHQPGoEzERMhiV2ZahzxOojc7VzE/SsaRwruzTGcvhlUGX17L/z
	xBTOmjb9sxn0MioVnNpkwxVdT6m+mXnKVpA5NOi/IAgHXH/I313lFAaRRrXBMTjp
	KLC2j13JJ/WZzO7HbhMZKW6mTvp/dhkMcUYPulAe87B+2bH2DLrd5RCm5YWio6DH
	1osZB6MwnPnI74/yqN4WRgLR6KzShnwiueCKPcw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:IEXR/ymM1hicKjjxI/XtA8Sk8cU4jw5UnjpG2eC4X08=:5aPDWcyYdQxsig33FzN9lsuX2o13u18FyugLKpeo3w4=;
X-ME-Sender: <xms:t3zYatWmNQXfiZCXQ9IkWBDchdHCr2qQ2hqwwTqrwA2nhunLTnu8OA>
    <xme:t3zYajkGq8aYb7gBQytEMrAOv1dy2XkU0tXqyS0gRAnm5PtzllmfFFCmvWg692qzd
    ubsXI0CRnSOQkgkuYkP6BoIZ2d5SIF5X7VeM5L43kZASQudDJNYeAA>
X-ME-Received: <xmr:t3zYanDSPZ36wxA1n8oEI1wGVz6nqixGMY4zxLKTkQ3ulm4CBZBbxA>
X-ME-Proxy-Cause: dmFkZTEkhf5GLF0mkN1N2Ri3ajGE56mu240Sq8h6gNSX/fH9NbMXOhrihrY+yX2CPRDm9O
    /3ML3g9xIyvBlqkAzDAamYx8Lq+H1t1JHzf20lIkFezYQhuSHUW4SZ6q22O4583G16c2km
    EqiupNFHwn8oHvlMgfRoigLK3UqL9JTU5vD5xfOeC4LrE9ot0cvtNyVHu7N0iGPxq1qg48
    rAoghDzsxzLN/O2HpCyxMLTFV1wQMoUcXr6aC4PM2VXmQB5NGVzYN/Bkg5+15gdAN5anyM
    JeHutkO0mZnk1GWOVsT0rDWrvRHs0jMtCE941DRoHH3lEU3eaIe5TnNMVTw9QcHI9eIAd6
    vVaLWWcY7cc1FajvznfCF98RsAUsOQfGvRezyzdhZ6/QB6A3ByOHiorY674wJzc6nAfHPg
    D6lSuf4uDE1wsm8sDe0WUEwMTXlVaI/ogFGB+aSKvpKuu9P7T+p1wSDHD4K6bqDs/GSD8Y
    gmlt4uQh4i2iRNvWW4+0+yBnLGM5KtS2RQ4p5ie4g8hmDXzY2VykzVxVfBYr2yWBB8+y7Y
    I4DS5CwFh4DhVrnz84DWIhWzJFQ4qyDvDWG4bIBTrx5Tdjj0aYC+EWkkNklWtbqSWi7fuC
    6m3SBMxkQ0jXYtu947Ty5BU9pw5Y7QBjv4Eu0p/CmE7A9S7bUb2hSDoXlELQ
X-ME-Proxy: <xmx:t3zYareCfcX6RpJWX7IgxQL6SVtvAOXxvUG5ipmk2n4EpzmJr49E3A>
    <xmx:t3zYaqKPW_aqXGc3fzpZTUDPFCpFkH-tUbBbybj9yZKe6hHjmr0Gsw>
    <xmx:t3zYamef96oxaF-TMz3jbPO6y-GEZKTWc1PJa1VwBjxUw10KDvbPLw>
    <xmx:t3zYap0bLmWfSSmzqkqDqBGucCaWwz3AGYha0AlUUPtkg2ox_fSwqQ>
    <xmx:t3zYaovDl_yMf1YP_pnOSrWHOJaUb1JKAhEwMaMzIylMpkOkEW2UNvd9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:49:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e550da9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 08:49:58 +0000 (UTC)
Date: Wed, 21 Oct 2026 10:49:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] MyFirstContribution: move "how to send v2" after
 discussing reviews
Message-ID: <ath8s3kEQoQwK_lo@pks.im>
References: <xmqqa4o94e0r.fsf@gitster.g>
 <20261020232242.2217109-1-gitster@pobox.com>
 <20261020232242.2217109-2-gitster@pobox.com>
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
In-Reply-To: <20261020232242.2217109-2-gitster@pobox.com>

On Tue, Oct 20, 2026 at 04:22:41PM -0700, Junio C Hamano wrote:
> The MyFirstContribution document tells readers how to send v1, how
> to send v2, and then how to respond to reviews, in that order.
> 
> It is unclear how much blame can be placed on this text, but senior
> community members find themselves more and more frequently having to
> tell new contributors not to send updated iterations of their patches
> before having any review discussion on the current iteration.
> 
> As a small first step to rectify the situation, move the description
> of how to send v2 so that it appears after we have told readers to
> expect and respond to reviews on their first iteration.  This step
> contains no text changes.  Only the ordering changes, which are
> friendly to 'git diff --color-moved', are included here.

Yup. And that command shows that it's a trivial move indeed.

Patrick
