Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794090983;
	b=DFnH41MOGeIZeOpCCosmAbUAjw+r4VrPXZVCefbSQR/xFy4WOEhQvV+xS+jalsiMbVcX
	 tSeKwMFKyNBDU30BQn/zY7nSv5gdVmrJ0/P6q7QlubCzhWExAPqSUZmOMQijcM3xba6H0
	 oQgTilVa/UaV13Iw9elHek6iZI180ES7aiRTied+iiJ1cF+h+gWAeJrOcwxLxc0MJ0Wca
	 KPVXLf6zFz6eMnPN/guKTawkZ/VzCO6/30OQ3ow0e9wGceZQ8KquVU7ZT5alwSyJkz8Qc
	 56WaSujHRavfLiED+EKwloZ7h/LEssnsDbEFgW44X+6oZKhjOXfbxawStZI05CBjuZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794090983;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Importance:Date:
	 Message-ID:User-Agent:MIME-Version:Content-Type;
	bh=zif3QZr84IMhUnWqX2QSF+Q/f5E0RgRiR9KkBVCSF7g=;
	b=YjeEw4Gwaf/Q9mbFZu51HZ/D8P6GoS554fFjuLDEweuu77vykigl3yGxBv5I9e1hsMS/
	 W+XANfhcCOZSEy0hc71cqruHObjbClY6dOFpMeZzwPJMjp/I5SpXMfes9q0Paoxb06rKs
	 jX1l1UhFZy8lf3PMRo5unMFpuwggOF8vcfKyGewW3N6L4euKSMliOwwfWyP1VScGmTK6I
	 3VS2op17RYlY3GlLaaNPguNQYilB6AulNZhpRrzOs/FciSatlwbJl7/ZTl5aNWAttSzCt
	 iM0ARTHRA4ohtoRFLiCa2jwEAlIjqzi94M6j5seCgIaCRO7xqwCFYg1a+tRHo+W4Pog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gPxOqxBl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="M8/sWLZ3";
	arc=none smtp.remote-ip=202.12.124.152
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A21606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 22:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2A21606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=gPxOqxBl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=M8/sWLZ3
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3CD327A0120
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 17:36:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 07 Nov 2026 17:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794090981; x=1794177381; bh=zif3QZr84I
	MhUnWqX2QSF+Q/f5E0RgRiR9KkBVCSF7g=; b=gPxOqxBllunni5qaS2E0+rtwlh
	NIixtM+E2QyIzGb7qHwdVb9wZCZaU03aYkPkPSHyDrMNp6nPvvhJgiORTHEDfNEb
	ALFIefVLtST9aGW7CFb/uWo3mnSsmVqjsqSO6HzBvzo+RsWeQPm3Ghq2cKAaWVUJ
	O8w0aJCyN4+1hAA1ROsVf9HdbKG8cFIUrqCJCeN1mis284decBy+iEun2SPdhyVk
	7AZnPFiJM56N2rbZzBTIrszFEmrNaFirsGSXnO73wqOzroQANgc5corB2AI9wqdG
	VDtRhi+oTPYShRLkD0YoTMScY3sKt+vCi7envWJ7yxxEQIoSxbqWDPXY8rdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794090981; x=1794177381; bh=zif3QZr84IMhUnWqX2QSF+Q/f5E0RgRiR9K
	kBVCSF7g=; b=M8/sWLZ3gFDy7nj+aJSOIVWJCuAWDFIwx4zClqszzp5q3m2WCdW
	zhfkErXiLsEeRsfKIeabZIqrQHnvygrYfvmIsV0DqcOKwOItFcqmx6EpHLr31itp
	7eI9mjtWnXEwQGl+HYrwfJpod6Em9AOhIYkJJBtUNCtbFftY6Q2OV0xcojgu/MbO
	AVOoI9bvTspbeRbzHogbXcw0E8ORwptuoN4YYmUUcTwAv21Oky7Hz4GCI/h4eoWd
	MySU9t4k96gr4WsTyLRpxePa4gpmR8cEhXi6bKZ4/2oCqRt/R+1BxRBzGYWFkQNq
	VMshoyhE4xh0sozIG7CACLIG/XiuIjJTGmA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794090981; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:UEkH+aZ+GX/8GJ8excJpqGcrIr8N8JRDSCBI+C6GahscSOX
	eKfEToIHRPDO6ACGoE9q2iCOk9R7d6WtJIW+fwPvA9M+kz5M7yQULCL3u7sh2HIu
	B5QPnIVCUOmACsNzpfm9DAAIaT/YJUZvVxBreLOKV4YN0KHW87o0O8R6V+jjVLpV
	UCOqjgwqYA95IlqX4VmIFQwwre9IP/73wIyReD4OZ6FirhVdya1A6wRIvhUZULd8
	MLkHhjSdaL3dPSodxQcjNDIauyhPsBZVCJcckb/4ZpLjP7ubpBazI/VOEnbVPgXl
	WgIYJ1WO6wn4SRgXuynv3SddakdfD2t3HazyBDw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-type,date,feedback-id,from,importance,in-reply-to,
	message-id,mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:V/M4Nz89V+EwVIOS1A+jiHiEDoJUreFIbutWXBZWCrU=:ZuGPxEn/thxhY+XA0Bmh6Hr+MMoLSTisusLYHCwuh9Y=;
X-ME-Sender: <xms:5afvavHQyTIL7hUBxNggGlxmBlpTpDV6J0FwkZVRu8oLcM58bimqJA>
    <xme:5afvajU9AfGqEGA1bdWZkioPL3Q0Km53nx8HNJJLGpT253sa6ICj9YWbwoorYgNa0
    KMjENKi3Q-yHWm9UsAMDaU-EKO5m0Z3menOII4GNLmeZtwNe6BQxYY>
X-ME-Received: <xmr:5afvamK7SousTYLX2FsENrpJkUfNjLk05UjGo0VVlhJ28qWqh9j0x-eErNJfSpZhpQhM6pC3_QpiezndOgadf8cvtfFy5QL7A5L1>
X-ME-Proxy-Cause: dmFkZTGB/vfBaye6d/OTMNjauvLe73oW5PxkwpYN/2Ct+MrfG38IB6rJ8z7v/kcdKYqLGL
    C/zTe8cRs++fUFfF46jjApG7K0D5tmM0l4kontn9YFo4izvqyQp1XEqtGG4kOx68oAetIw
    pzAG7EkE9ccc3IaU4q7EPxN/+n2BoERQo03kNb/CFmyIH7C7z4/F7HKh7n8K4lSH7+wHJq
    CQ5j6DiCb23b026im/X6shuCtQydZBzDVkWDf8mAdDXsq/N4vEtDtjIgWuHzEH01bUvTIp
    4P8OQOrfEkjQChh5W0+Dd6q9dY4Qm6uFiaToSuQ7btsC7ybdWhXEVGIPmegsiBh138FqlX
    eZ5VVTgctqUFLDPVWPnbZ58LHjSoLWDhB6o6bG6h33NwkIz9bNYL0RMgTLoDo6jzU148Bg
    fTlUvc1eEhZwFaijRMdjtCpJJ1mnC1q40WnPGsY6ZdFXdex8qwVUjGU9AarpXzoO4KEf6K
    UybyNsx08egDb+Bo9U9WwHTUYT2ZAh9Fx2Y8dPzeRV91v7OZDg6If9ly9rD+TaPyx13tFl
    e7JX7CPHOmr/0hsbRW1C7Oh4B+tcmyBKoG4xgLYxGIlMd3JPNFp+iLRN8fgmGFSB6eU5Gf
    eIJKxKO1mel1PcWhavmLHN2NuMndJAa0SpMIM1BurIoaM7LyL1l7OTwHPHMQ
X-ME-Proxy: <xmx:5afvar_iowYQdu60lE658cVLgtYHCnS0czAsJ7F432l9x2T7zh0gSQ>
    <xmx:5afvahJb1GhBw73GksrbU90zll8NSWq5Qw5kRxsSsirKFMTbFKlIpQ>
    <xmx:5afvaolAa0um9-gXAgrJyf2Hz2CL8lYIFyKFdkUDCLH6hL8P-lpgkg>
    <xmx:5afvatOj3EwmmNf6oGR9mqAS5oKScNBhXGvp2WOUWnsBpgMeJMuMmQ>
    <xmx:5afvajgFgJqOzy1t-N1c7ngkJJ3c59Qf5hnjhj6x1FbUo9VOM3CCAnDR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 17:36:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/5] Address overflows pointed out by Coverity
In-Reply-To: <pull.2253.git.1791958171.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Wed, 14 Oct 2026 06:09:26
	+0000")
References: <pull.2253.git.1791958171.gitgitgadget@gmail.com>
Importance: high
Date: Sat, 07 Nov 2026 14:36:20 -0800
Message-ID: <xmqqbj809sm3.fsf@gitster.g>
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

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> This patch series is part of my effort to bring Git for Windows' Coverity
> reports down to zero; Previous patch series have been merged in 347fe8a91b5
> (Merge branch 'js/coverity-fixes', 2026-07-16), 0b75ef5168c (Merge branch
> 'js/coverity-fixes-null-safety', 2026-07-19), fcc8c931b53 (Merge branch
> 'js/coverity-unchecked-returns-fix', 2026-08-24) and 8bc9c7fcfd8 (Merge
> branch 'js/coverity-fixes', 2026-10-03).

It has been quite a while since we saw any activity on this thread.

The review discussion on patch [2/5] seems settled and I do not
think the step needs any more work, but the review comments on
patches [3/5], [4/5], and [5/5] are still awaiting a response from
the author.  The topic has been in the "Waiting for response" state
since around Oct 17 (more than 20 days), and without any further
activity, I will let it expire from my tree before long.

Thanks.
