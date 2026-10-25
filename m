Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792966510;
	b=O9CPuhnPEt+hrpQSlXE/YqDE6uCFr6xZaKjfeYJEMJQomUrlmsoV9mD7pwIEprZNpjbH
	 bkfw6S1++THDbRHhUHiwGHgB+e6npfG51rMXccJwZzQVHkj5SnkSCBxVCmBNIb/IO4wOF
	 TEewqo/le3YOIn/dUNtt6cBNCcp1IqRYTwWcNPRtyS16FtIeOfbCMn+Zj7shdor8DfbtN
	 oFwCwCENwUNrHpTHCCJOf5+qQvOeW/HJj50JztwIilQf4roH0GBEHP8LZTlCUhKe0pMqy
	 s84yifBrqBXg/3svvZG0MR2DMJDGTUbAqKbdkR3AZBFrsZn7NAt3s6TLcy0/B1Rv/cw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792966510;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=lkorlKMsS2/L9sxWX8p1sSIRXHHGugSlQzHUA5YwR6E=;
	b=Mto6ZeNqd/Tvm+ch1RpEtYz3BW3Y63BcDOviYWJZvdRs9LTCI+TIClRQ+v9BS1whrsYv
	 vpxyAU6IkBMs0g0JFS9rpjgfkuFnPbUPgD9HaotQobf+AWCi/F8BDGhRSAA7CPwXpxOU8
	 b7WdZoHxTMfjTRYfTCBUfJZ8pifRRtKUprVnsNivzvbh3DoVddNJO/FORCgDYtXvaR6I7
	 mGMa+NftdVcFeEQgAH1BUybJ8iqbsCkcRczxuPs7++/+5D4nD8YE0MJWzp4O1AGHjmFgZ
	 O6aeWlpHqaLQarPoMt1RRkpaImuxfdzwvI0qFMuKwEzgCYZdhy+nf0eWbc9Bi8xItdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=niiQ7RT0;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b++LOybe;
	arc=none smtp.remote-ip=103.168.172.156
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A1E606A31E
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 22:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9A1E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=niiQ7RT0;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=b++LOybe
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 93FF214001D4
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 18:15:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 25 Oct 2026 18:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792966508; x=1793052908; bh=lkorlKMsS2
	/L9sxWX8p1sSIRXHHGugSlQzHUA5YwR6E=; b=niiQ7RT0NvYGiBuMxLr7Rq/yUl
	ygR2r/OScY9D9CkxNS85uk3DgPXB7oPCVCEasYapmd6Y5ME2xZm6O7nwwd//F7cq
	Wp/FLoWz1PVLmrsf/AWAiqxHpZDws3ihKkFEaNSjn6EwUjocFFEe+6f24cDIixNQ
	ps/VegvFZav/OCanFsJDOQKsrF1H03FDqS9NaA8WzkdFQcicS33QA8NsRGP4mqT7
	n28HKBwGCfNI5EgRvtfUwpb8SKgdR+yq7HNpkmlAZjVN61nfdztW+Bv5OwEdlXF7
	4ucAyWlCxJVjNqwGDpUNmhcmRCciQwzthuIsxb4JUwj7wL5vhEaQQMEPjiLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792966508; x=1793052908; bh=lkorlKMsS2/L9sxWX8p1sSIRXHHGugSlQzH
	UA5YwR6E=; b=b++LOybeoW5VB3M6+uV5B2OS0XZxfwFzfqM2UzPUMDsG1QIlTlb
	EJ9BTltu0gL15Wt3L1O3PKFCgfym6zaxQO6SuyqE5Q8fghwS4R5KpogSX3c9RAAT
	rybi7yN2cgY6zaOFEvDYkJ4UgZXwReXwmMnTJYBS5KVpHUpcdXKcr46eDDzCVp8h
	xNfxc7zY139ieSQ2bZ9WT6O7G68ec/AVeSOMyA+LH15Xc3x72HH+4PqEHNqCy2BT
	GhRQjvjB9/8KpjOgkVfO++3rp/YIl6ojQAasmpXu4bz4/9TpPwEwpd15wd5HNnA4
	NYP/2/j5wE1YMy+W37PXrzP407aryZNCjvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792966508; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:XruBJHgLTPA+7JVM22uUEHFlppuFJth7FxrWeATUzTXcULO
	1LxN+gLfqADIWHSldJCUEA+M0SBKm2dv/witCqxsedUb2fBqr2JNeuvVz8tYfZMJ
	LqTEmFjKQNAk3Q8T1cpKJ65eve4pK3v1nyFIbmUf6If/I36PpmV0T210wSz4edWX
	l23uC6vEdkxWWwRL7tvILhhXNDfBom83f2B7cqgPeDaqjbxS+nwygikWH7fCJfVA
	7ucQZZjn2SD2tltM2n+GLoHICEyTYOUvVN/0v2pRzhk2qBEXvxLATKX8o3EkbamY
	vvztF/jnR19lg5N5Gh+BhZUFtfmPgCVBx+plqvg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YhkrEiyM+6cXkzUzPa2JbqUgfSGpTYYYfVo3lCnhE0M=:rL83QOLybWvYbnglNUt6+x2m0iHigINFYIuMUfz/HtQ=;
X-ME-Sender: <xms:bH_eajQIAuDXS3R4LOQfT2y5dz7UJx3nLqScm7oPh3SM805Ncq9FpQ>
    <xme:bH_eaod3ndMR45M7uERG5zCodS2HudNApWlI4BpJ_zmeGn6VBU0hRsDEWhKuZLd76
    xbb3SOOsfjaDJpft0QxDKvgaqiu2tGOD2AohLSCKOZG51gIomnwnAU>
X-ME-Received: <xmr:bH_eaiqJph5n_ASSXcVOqEGmFEYLW7Rr7yznHEAHPB1d_6yQoMlubLUyaDdgQM-17fQyrTeudR2rL__Cu6tWf4kfeOmU05WB-rVA>
X-ME-Proxy-Cause: dmFkZTEahQuEXYma9u+G8Bpkoo43dkEFYW1UCskFK9660ZVXmNFjtQdZQuOz7910JJPvcf
    ng7upZcMgXWmx2kFuC2vvdagKGHvB/+HcWgwP7zMBCZh+h09nJwfOnXhxlDxTLxjxoGWdI
    9e0Fpf3pMv3efvXN9MCpw5al/jMKxQgORXjQUnr82Zt3ma7D9C55MzdsxmMJ5Qlodf+oRL
    MIjahtKG1TIHRTIXKy4jazjA5l2Y3ntTifxdcaeWfA9l/VfL0fvEyXvernpuaqp2efNoKK
    dpylxND7CJn/wf+nyexl4Qsx0KrLrvt23inZDC/JN8wBzfXPEUHt9eiP9ZD990GA2MbGBf
    gSWO0AvNtOdGS67g3wVlr0b0WsSTIFGt0kt8a/GPzDq+4TIzlSXiuB01uJS2Z4nxptunLE
    kKWgs8+QxiwrwjVH3k4D5oUInZNUdHape3Ju33tzDz//1gcICKx6fnkJwm/kPXru7KYsuT
    Prqw/MYWYf6S8OnmI9f8oK0VH+j5pZzD881+7ZWuAuRehdTxSb+9BFsjuPbeM9h6eQ7Ys0
    Baw1x+MXDm7KHaopj7M6ThuYlPkxMXNbCeg9PYM35QbyniHpzJL5xpPuw05shTz/agAjg5
    7zvyc6LcQiy8v7pZ+a+5jAveG7tx8bMKQCW8k3KFJVG68li14qPG+oegP8GA
X-ME-Proxy: <xmx:bH_eap-SyW4klH5nukXMgrBjTKhMPBgMb1Wdf41Ik51QW8mP4KPEKQ>
    <xmx:bH_eaucWmLhizjSfq-WvfAJw2RhqRtBcAFGBy6H9Cxw9Qz8TQJsq5Q>
    <xmx:bH_eajJpeTuq3f_zgRoLLJM5KaBFwXI3TDtb_FCPWLwYXQKdfiTDDA>
    <xmx:bH_eaugsVcu8UCNIaCb5w2BLgciEkDheM1jOVnIUZkcHLZ41R3B5eA>
    <xmx:bH_eas3BhT7qGik374i6BV6oeCu3TaxYGUGVrbg6c_UYGd2BFcgQuYPX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 25 Oct 2026 18:15:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [PATCH v10 1/5] fetch: add remote.<name>.refmap
In-Reply-To: <CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
	(D. Ben Knoble's message of "Sun, 25 Oct 2026 10:14:46 -0400")
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v10.git.git.1792503778.gitgitgadget@gmail.com>
	<ba7f1354cd5492ef964ad4d1d398b5ecfc4e0086.1792503778.git.gitgitgadget@gmail.com>
	<CALnO6CAhUNRMf=KZmY6YbC-5g3h8DE6U40HehGwbcRTPhDasrg@mail.gmail.com>
	<CAHwyqnXWxiF6NLh3e4yGq6_y+=A+-_PwKF7D9DJJDxbk_0vF-g@mail.gmail.com>
	<CALnO6CBAEB8=FfZfde0OWvfLJikVkXQ8itP9wZpGHxfxK+y_LQ@mail.gmail.com>
Date: Sun, 25 Oct 2026 15:15:06 -0700
Message-ID: <xmqq33ttxw9h.fsf@gitster.g>
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

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> That does look like it would fall back on the refmap, but to be honest
> I'm not sure what is "correct" here :) I was hoping for more
> discussion of the questions I raised to see some thought about what we
> should or shouldn't do. I suppose falling back might be important for
> the later step with --limited-fetch, though?

I just encountered a case where I wished to configure both refmap
and fetch at the same time.  From a second remote (let's call it
"cabal"), store any branch fetched from them in refs/remotes/cabal/
but I want to fetch only their 'master', 'next' and 'seen'.  I'd
want to be able to write something like:

	[remote "cabal"]
		fetch = master next seen
		refmap = +refs/heads/*:refs/remotes/cabal/*

And, no, this does not require any inferring based on what is
checked out and what the checked out branch tracks.
