Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794093312;
	b=ofyFqFaHK/zUahy5L8hQJxDuONan/NOFYiZ7WvdWhZEFnWYFBqWcDKLBR2gkdciiRA8U
	 EMxo2DfBr+FlZ+eyLjl5sCt7s9kN3bEV0vka0g9y3lKXWjpiAtt990qkensz8bm5jKTfU
	 gp3wBunzpiqbii8TpEkwea3/+JwKMhk+tbu9wNA6qNHdmdHv9VQQhrjEHKjEQqjwa5l9h
	 ohA3er7aXXV9Vb/h2EHVWgEWZf+kGzS6DWAclMKqFNtBXnHY8hbWCRrfmfVZzykEzLOef
	 hgDi64W3e9Ijz6Igkrt20pu+KHHeiIQ3X/nPsxMu8mbUTMigjjfnAndvL7OMwsGKdYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794093312;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=TrmaCeabVRLyj1QNKEknJ80bEP9+yMpzSyMK4dQOz8Y=;
	b=o6FYG9qEwKbiOmysyCODz74fSfcdfFBUgPXJUju6DMYsCwWUiUuz59kYGb2HqE33vdu7
	 go5uB/S6BzeLai0yIpV2har0t9yuf4XSsb5L96OTeonJSbDahy0qkfM5KEz+E4vmB57Q/
	 2/qTr97ChubTx9yLMK/+Emk2CVx3YbNezJaCCx+Do1L2s0yZNDTXpXcqkO+sp1W+no5Wx
	 FgszSMmJrDqOw8EKVsDBWzLforGOkU5LZO/Zs0Y4n3Y/2QBFEMBPflfVWI0GVt4CBsBWn
	 qSfjF8W4pJ6tu0Vy3zRGHTCI3c3FiQBNG5M0aQlzHeSpxT1Txf7piAPbVL3/bPJRAmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MS8w9IAB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D8jQs5dQ;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5A606A326
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 23:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF5A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MS8w9IAB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D8jQs5dQ
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 500D71D00100
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 18:15:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 07 Nov 2026 18:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794093311; x=1794179711; bh=TrmaCeabVR
	Lyj1QNKEknJ80bEP9+yMpzSyMK4dQOz8Y=; b=MS8w9IABrvqZBRHjj1nZsEP+7F
	5M0wQFz68//5c3TeTa+z0qlWQvwXzTMAtCmvzeKLAblBH3m1nQ24InbdKBOyZ+fI
	bkjrBeSi6Tbygv3EdVhQk5ejYQB2CQNfgXP+YJS3CIYPoPR4nPywpsyCzUKIvHY8
	42RpL7UkX7lPza8dNMXIhitO9kARi+6Wo5bDNeuNlvWsIeeSUk4ihXND2lZz50k+
	8gZwCr5i58YT9so9U11FFBgr2xaWIDaXWmDrnDi917fcD0j0Uuul/sHfFBBXWOQn
	PT7BYX1MWDdCHhyhyj5A2iaZ7jEjJGKpfqbfLYCQqNixycEF9rMa78xMeKVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794093311; x=1794179711; bh=TrmaCeabVRLyj1QNKEknJ80bEP9+yMpzSyM
	K4dQOz8Y=; b=D8jQs5dQTvwn6V2YGGE+OsJUblDwcho4n0B5EXIlmPE540VmjJc
	UG6hKUEUhYqVWrI5Lu09FhGU58fwXSQJkjvMOCSbOixLv4zlO1YLwjGkS4TfL6OJ
	lnjzNSZQNSBxK9zb858SZLiKo/61U8+2oHolfC3yLoYrdEz4d+Yq/+0N544Iu6U1
	+QX/5CzWWFcjavciHOUDs3QcnDcAfphkImvEf6TF+QYn3jIeeGpeZUjjxJB/gtCa
	g/3cqrKJne9vyspAOINvkQNWwhiJW4C2KxoowDrD5lLCdaV3dQNIxdTRkdWiTHHS
	Pf2BpfCxAz7FSkpnx51eI3IJn58huKz2aKQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794093311; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:bt6w8Sw6i13WKzc2LW+x3LiaJgI/AkqdPS++rEwUQvpvdj0
	WxjxwFPi6NjIp5tfuQo8vWhi6VV9w7j5QH6fuKd5jBpV6hGJN/5P218lNtNsOSey
	UxiXypDy8qCkwTkE907G4tVt7x7uGZyiUdHTGjlRLx50z7uTScCA2S3qCNBRo4rh
	MbHBwpm+8rCrqDAYSKm30ez4N4qWKX2BOrA54QM8FXSOu3DA5iwPMMXEjzkbBRnl
	88zLIdjiNVPtYdMDSOhFZEgd93b2E6VtGyuCe64B3Mrx6D7wbReKgZuYR8x0D+0z
	WRUONpx7/hrnq38lZWrajuyu6v7EGdFwpcQtZmg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:Ac9URy6w3v305KUdZYJW/U2TmEUsOV8hd2G0/0UPL8s=:Huq03rlGVhUtSwIOmpngxhWbByn7B97zZqNBG44/Ao4=;
X-ME-Sender: <xms:_rDvapXF9yXg9ptBZ4-0cVIxTpjsfdlSMskO0qeW_Edw06vJiHaf0Q>
    <xme:_rDvalGRccRXE3DXX3QEEHDihCG9J1ptHWfz31A_LBNzTHXngHA4AXcOORBsedu9J
    I10j33o9vjTqnCGZLjIr9nyWH3-10WEepVuSo1n-VhU8gHYNTibefM>
X-ME-Received: <xmr:_rDvar3PNmcXQv5UPeLgCxsbOVjIUTvR6q4ezzJCV4hjW1vRfAxAtiqVP86BRQakurhMcFPNTzRX5hZ6clKlEHzMov8CkOMVJGoo>
X-ME-Proxy-Cause: dmFkZTFC3ePROiIPs8gbmFJY1WTC27m2qsu/AECjJR8p8bQB5hjmiZoBYNr87gdpr+3ZCE
    kun2sZalZW4hlWVRf7DSYKBIq3I+foStB7pkMzhJYxCqWEBL43pnY+TA294qoL7E53gjvW
    zPSBprnjkLQFrWcNsAgzAX5AIqdAPL+k3tzRS51CTICtxCF8DdFOzTuqchqMovK3Q7+noz
    FRnYyNNNAR0iTs/Kgf2VrP6iysM8zeV//rDE9FXNDYTFnRqRXl9ZI1v4CYfX4vJe/JdZxz
    W35O6f1A3C8JPGe1oZQdD5WWAm1REWspysaarBOwVZxRJ4UyjFhf4sqZeRrqcLkWs18bSZ
    yg6tzqOA1+hnHMMWTn9Q9je4bOYIS5f89jc7DCTkGIxg/8zlop0FSxRDJV0YkdIcnHCoye
    WFDW4w4BZCI4tFRqJKPDj+cqGIDyAUeiGgj+QEMp2JnBuIaXglvjb9pRbmtyMXedg1Gbm7
    5SOGSHtRcwvYi5DuRC//CX59uv5juFaWl/SAAvJKkcucc+JqH/JWNIIYULzwoYEDMxa/NM
    jDF2JxhtXql1f9Qiw0W+FZQrLynsDtvXI5i+XsG/tmmWTtX9gRX+JeGRqHn9t9eKxL0WZ7
    gtmP42o31MdJoUGIDWQbT3BqJDoQUvFoFUC5A7/E164E/l8wbBw4a1Ko3P4w
X-ME-Proxy: <xmx:_rDvanP-S85KACuUqWlmgqdKrsrvrmeWIjZfbLw-6AO2wbuy-kZuBg>
    <xmx:_rDvaq4C92xNBnODGMQzw7Y-TDtli7yC0m72rONCRkb1H22xiWACAQ>
    <xmx:_rDvah3ANQR9rCRwV1s88GqQyhj8Dukzi7iYxqaMay9D1eUtvVWqqQ>
    <xmx:_rDvarwbqk3Ya2SxhWCBqVDk3KvktqOlS0MZXVCwrE4WejG-hOeIZQ>
    <xmx:_7Dvaiy5s1YcasQNBT8C_gbkltJD82mnR7ifrW8hNFM8QA-7VXfpK6pB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Nov 2026 18:15:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Kristofer
 Karlsson <krka@spotify.com>
Subject: Re: [PATCH 1/3] t/helper: rename test-genzeros.c to test-genbytes.c
In-Reply-To: <b4378b352769cdcc2e9cfdf40efe173123ea9ab4.1794063565.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Sat, 07 Nov 2026
	14:59:23 +0000")
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
	<b4378b352769cdcc2e9cfdf40efe173123ea9ab4.1794063565.git.gitgitgadget@gmail.com>
Date: Sat, 07 Nov 2026 15:15:09 -0800
Message-ID: <xmqqwlqo8c8y.fsf@gitster.g>
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

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> The next commit adds a "genbytes" command to this file and turns
> "genzeros" into a thin wrapper around it.  Rename the file in a
> separate step first, so that git can detect the rename and the actual
> changes show up as a regular diff, which is easier to review.
>
> No functional changes.
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  Makefile                                      | 2 +-
>  t/helper/meson.build                          | 2 +-
>  t/helper/{test-genzeros.c => test-genbytes.c} | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename t/helper/{test-genzeros.c => test-genbytes.c} (100%)

Needless to say, with this patch applied, the following tests would
now fail, unable to find "test-tool genzeros".

    t0613-reftable-write-options.sh
    t1007-hash-object.sh
    t1051-large-conversion.sh
    t1450-fsck.sh
    t4141-apply-too-large.sh
    t4205-log-pretty-formats.sh
    t5300-pack-object.sh
    t5318-commit-graph.sh
    t7006-pager.sh
    t9850-shell.sh

FWIW, if you apply [1/3] and [2/3], squash them together, then give
a custom rename factor to the command, e.g.,

    $ git format-patch -M3 -1

to format the resulting single patch, you will see a modification of
genzeros while the file gets renamed just fine, and you would not
have to break these tests in the middle of a series.
