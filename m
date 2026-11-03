Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672821;
	b=1XzTOzhGujf7rBsAYgYG8XUTGqmXK6yQzRe/tuoP9kBfeV/2XP93O4OTUo4JostSNAUI
	 hTKuzB2MCaK1xtOvUJXEVveL7MNUNn+xv/8eB5Y/CRnyncO83Dlu2fhy9fSi63c0q/rC7
	 GrufvbuyKdSg0s+IdHa/GIc/b4UWwIMO35BvUEHvvM5M0EEkhBvHXTLzYJgUHAFiriqeL
	 0mSzLqZvg7UkSsrfUtMfjJDCAd3AbX71SUOGdxX8T1oKDARjWimrnSOc7GGG6TiIEddD4
	 qLawNwFtO0TnujkkZss+TQqQQSEHbIGOJdn9VTTL0LJJChZburHGpbBZUL9+i4KB1Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672821;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=bFWZPo00WMQPbztj+GBOaZ7CW71pD84VggLkZN43gxI=;
	b=MC/RSXI0pjhEMz/yot68qbzo8cgK3UzMu8igk66Bfjprliyj5W7cKFwoLwV/K0pL0sJL
	 HSylrpS0TryZgGdblL1c8tTVLx9D7/wpDGS4lNaP7jUhhOEZxMVYTtAepxOO6GwbDF+Ci
	 M/zVybJ/Wg8nkshVvLMZnkZPSMZWk8Dau48I/m08kicB1giRkIfxkd0DV2P5Y3X9bKh2N
	 R8zmARgOBAnGLwl0rrxa7CVF8+6qb5uVLHEBK2DsR1p4prbf4Rtk25ONon95tZPYGIpEW
	 d2HaDXUKqOsup7RYFDm4LbsUg06gH7jhg7nM+WMNSN4RGqOw8y8awZPLADnpSz10YGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=laNrOUWB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Pmx9LEeL;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11AE606A324
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 02:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B11AE606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=laNrOUWB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Pmx9LEeL
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id DA8F4EC00AF
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 21:26:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 02 Nov 2026 21:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793672819; x=1793759219; bh=bFWZPo00WM
	QPbztj+GBOaZ7CW71pD84VggLkZN43gxI=; b=laNrOUWBhKgvGa/Xn4aL1eIe4c
	kXpkYHMFrwT2XBirvgyb+9pefEPO/uzDLZxHuCDDA1w1qwFAYkKz6YAtCJH5MWpd
	r2z9ufhoVlcAubXFsHvix5K3MqBRmkUWOjHVdYOwtK4rWPO5fsEDe3rTYHHTZvBn
	eTQOKoFomcG1rcVaOTkxEtOjWaCzwj5pIdlxh0/CJ64Kfv4Yy51h/t1qdVMZ64Gz
	vqUEvoBadbHHvhT20luSmNfkb3nNerZS8dx6fm3t1UVbC4n7Hx9mv/eEPsOZKVol
	qj5wqhOFs/qagK1wT2gqt81TC5nwawPC76TQiR6bpWBO+LYtmyNQAV9VGVgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793672819; x=1793759219; bh=bFWZPo00WMQPbztj+GBOaZ7CW71pD84VggL
	kZN43gxI=; b=Pmx9LEeLAj0iisuJtGa3keSZmiygarn0rxS27B50YgGe/HBbgie
	sgyMXF7pwMGmVxoYVp6MRpUJCrg2fQpDCr9n9EMGErc8lrpI58PqyXEpY2jHITj+
	GvxpOVNkirA/QtaSyPIeVAZ0qdpEMZDo8FOG7skJdFvmY2YGlEhiMZJrAqjVxPyT
	wZq4c8+lLM5Z+Vmt2B1bJlgTmaNE+gRKFqZRwsdH5HVup4YdUjkbF7Jd1CkiFvIz
	RQA8TIJfgKSx4dDrQQ+Xqo4MmLrWGJCvNYIMksyFupnoiY1cZi1MufDiVK67+lIL
	33JoUDntClTig6wfDyiha6lT3W31xA2nrWA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793672819; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QDSEIjaZLOY8B8loiaSy6xZpS2nzELzCL/3IhHXIxI8BTc3
	iE/59uUQ2/2oNaI+U/Fb/ps5wayvVUgttbPxUoooEChZniSL44KBsE2NZflEdpJ/
	5JZ7440KZcTRd6lhqhtcGbkyo1SgG+p6zJ1ly26W8HnW64sStlJbnq+1ChVp0GUS
	Y04/23N4iyOnUEwmOiIkymmIkby/jq3FkM9rrjD314dIWnZNbq2izBGJCoCZ8jAS
	VPPIZDik2YpPKEiP61VDbmTDynfogtfdRGG/+1EUZHZW5u5KSO792Dn2F8QDMI0v
	7K8jedUEwavogBkCskwZ7d7rO6FbJwbY6Uj0VFw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:NajBo/xc/UMXafLAFwP31xrGjPy+uQC6+mIva1cdfpI=:9scubGPRoEdoJvih/VCxtGedK6clAwS0NEjU6R176RU=;
X-ME-Sender: <xms:c0bpakPc1ApwTRI2aI92bJlioEY3BfSd8l-piP2qAfDJBJuUNWu1pA>
    <xme:c0bpauo7u_khhkvKBL4J2lhD1HjdZm3oFsQek1-9L6P9O06RbMu9urAvI9BTBhzpd
    g3Q8SnA1s8Q_aSqbQnbzbNkfRDDDcOfELDyqY2y_20bzQ-mRKQhLN4>
X-ME-Received: <xmr:c0bpalEZCP32fIX04F58gC5UWh8XxBwrRcids2T3HuqPYGyJ78ljmZk9k4HBQiH-2pOAtwQLulwSlCaGTAcObS5GxOX0VPdounVJ>
X-ME-Proxy-Cause: dmFkZTGzPf7yRqKnQAaFQtwi6r5QYPjDD3s/m5SQoxx9HvENZkgcdPMmyP+4D3GajRsgdG
    YQPfamxlZbwKDutYG53ZcjsGvBxV4E+mS2peeMIki1LR65ucYyUYOX+e7+bZ4wsE2hFRfN
    wZW6cIQNFYTtsyGOxO7RUfdMgW4OpKuSCBS+7jPoUlg+zL1Pidjvmq/OWu8veJ8ts/Ghjy
    6XHlTAXsJ8b52lcTxu42+E8E6sK9csNyndArmbydEX2hZCJL3O7vPIT1qaEnE0sX/BzYkm
    0hTrZ4RR2KHmoEuAu8eGAsB/ljuHVPGfqJq9w7QyF1cy8i4UebJbA682aJBn+yYK1F/5HK
    uWBRS5/g5LuaIxFaVbUSyfZUKRXdr0QfZHlI0iinaIb/0REkP0W+tPBkTADlfIz18+c4xG
    Msbq5I/gGCW29nRBMaiGDMYo7QnzhV8oigOJyXFp0t8XOtxKIiPxsnRuPbjcmra7VleXS0
    QCFP5DcxMVN/778uQWBfIzxxYy4w/FYQWqGDXkfA4egZQBujaOwCLFMn3IyMsFnhjAdF2k
    Y5DF0cm3hacuH5tMR6b3ThXmVwj6gTsOgRbXaijvLlrzY8nq54vNeGLZRRuHJW+b3XVfIJ
    G8c4cU4Cp5VnOnSJeSDf10LvSlNKrYIdBi4tbsFkuKiQhQEz1/3pBGxNbzYg
X-ME-Proxy: <xmx:c0bpajr9yntOKdAsTIzO42B7iI737ySb62Y6fJte7kTq3nwD6S3_uQ>
    <xmx:c0bpaua83TiG8WD6gwKnnjIH8_roPnDLHKNAyZfsp4W4vori3cB9AQ>
    <xmx:c0bpasUwWJUkZTaj2F0xpwd3ECad_9Hv1nD_XD4tSAej4NLdoNPbKg>
    <xmx:c0bpan84AqwJgPr9e0mW4-DZJO0Y5jK5VezAVKsBmXpSr_xeHy-37w>
    <xmx:c0bpau7LPOUwy9GyfTBbffhreIbT2Jtk8YwOLhmmT07knIyI-u-Vw94m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 21:26:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Ben Knoble" <ben.knoble@gmail.com>,  "Harald Nordgren"
 <haraldnordgren@gmail.com>,  <git@vger.kernel.org>,  "Harald Nordgren via
 GitGitGadget" <gitgitgadget@gmail.com>
Subject: Re: [PATCH v3] range-diff: add --matched-only to skip one-sided
 commits
In-Reply-To: <DML7B6VVFDH0.3RKFXWKOH0X2L@lfurio.us> (Matt Hunter's message of
	"Mon, 02 Nov 2026 20:56:59 -0500")
References: <xmqqcxsmg473.fsf@gitster.g>
	<427F4BDB-B21B-468E-9C6A-4A7FE3F13688@gmail.com>
	<DML7B6VVFDH0.3RKFXWKOH0X2L@lfurio.us>
Date: Mon, 02 Nov 2026 18:26:57 -0800
Message-ID: <xmqqh5hyejke.fsf@gitster.g>
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

"Matt Hunter" <m@lfurio.us> writes:

> So, I think this <A>...<B> form would yield the expected output if you
> only rewrote history in-place _on the same base commit_, but not in the
> general case?

That is my conclusion and my reason why I do not rebase topic
branches without a good reason.  It is so handy to be able to do

    $ git range-diff @{1}...

after updating the current topic, instead of having to do

    $ git range-diff main..@{1} main..HEAD

where 'main' may have advanced since the previous round forked from
it, or the current round was rebased onto it.
