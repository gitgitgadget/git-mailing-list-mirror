Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349774;
	b=r31KHqLqfRmfCNQv+AgeW1FkoidsSHstq23j0OQPtsdMMOGEN0VGa3KBhcqUgJnL4+8Z
	 VOUV+3dOlwVKRP12jboeu7OBhh8bGeLvSqwP6feAHNNGhl6mrswCdAEIIVF1SJzU22yNg
	 CFx2IxaTm4d5fOwIO6t7eLSIYeSTxsTEQMcB3xjdfTJZQC2xljkJGqEx0sRHaZTfcFkQR
	 2IE1hA84seIBeqSWdpk+0SppSra8zam/SbmvjBx6eppUPEceNYeO/LadL8sOK1NP+f+5b
	 xzG0PxRgNuUHGkpkLf4WW7bRBpuWBFlSNq6ICIC8EoUh1nKYSCTWCkYx0tee0OB0kzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349774;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=GXUKUc0hLOwvgmbiutbPJvCBpkWTTcGQQOvh7PPIzCE=;
	b=FcxSX6WYhEkjHrqbRUB9etNmxXkHMPFqT2I0nmvRMnmYg9lCMBZQb5zkJOI8u8MnVGIx
	 w6HWeftETx8OsEjDMmCunMVc786DodEEIJaYMRgjHGZ1EGThFcqAKchg8g/6Y8xnyleLG
	 phIAO3jobmn6HCJ/qI9HdBCLvbjpc/D+IhPpdB1H8GQNAfTJdUsjpLn/iq8p5IsxyBRnh
	 XgivVvVP/Z0ylHPLjl4+UZEWLGEjEUepDDsnXOM/MsVRsH6jm0YtymF4lsPlLE6dFDKKE
	 CSzfEZZAgZotlom6jl4QimS/G7QkwB2de8RHQq7hrBeboEW5uXSkm8bq2JEf16Zxzjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lzC10RCo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bx3MvJQk;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260B606A325
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 22:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C260B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=lzC10RCo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=bx3MvJQk
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A3607A026B
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:29:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 10 Nov 2026 17:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794349772;
	 x=1794436172; bh=GXUKUc0hLOwvgmbiutbPJvCBpkWTTcGQQOvh7PPIzCE=; b=
	lzC10RCojRW7HHmyzoVI/2Lr7oxABImzQ/cgn7eRZNNS/YFap4pgxay/xS2LLkix
	ACWZH9FfYxrRpZIMqUI8YfpF6MfsSVrfz19ie5wBARyR+YNiiPUvkww+F5iZpeU0
	8yNYOniRrtuIoIzFIB4jlG+dZzM1ZvCo7L+7+aiKc+Kslxt0jTWUANxN7Qrs39bb
	VAwgJIagw38TsvBznlpYLraJNwA/UBJ31ak+fVgHF28HFSdwNdz2cq2ONHBbSBIO
	W9Qp0yh54iPTKb+eQ0Wmni+xg2I3gBfGhDXBBXelbd0dSv10Ke/dvrbL/jJB2Q2/
	qTXB1FwWzMJnnxbnBPC+WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794349772; x=
	1794436172; bh=GXUKUc0hLOwvgmbiutbPJvCBpkWTTcGQQOvh7PPIzCE=; b=b
	x3MvJQkJ2XsAJaZ5URZJifA9rqO0sCrDU2DphtPFENhmHT1I+1jRpRihT4W/p4TN
	oz7ooaMr+uiaycA7FE1aUL6I70+dPI9MLUppwRsopY4KHwwyowHLwyKplavi3C69
	IiDKt8NxlV+m/OuvpvApZuWSlQ7SOLgwqkyVMeXe7SkMpb4AZmqac4AipZ1ZQWo/
	hWHJ2P4bRJajapVo0Tjkh5p2z77e4uUtYNYfjemQ85R55FCLPZiGC8/pnTXl/ky2
	8w4B/wQSa0L33+mFrwUJ9MWaU1kcfuivb0AVMgEWFEQxJT0p5mg1JvOp2zEQFxov
	FQScxlUJHShBtFcIsyRCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794349772; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:IsDGSGoSgvBmVa2d1/nFrsKffKZcwOM4zu3GJWQMxUVdl3A
	ZD+jJfNPUlHONylqZZmNuXUMraGLrKPDMlslYpNX3JxdbOrc6S1HnDGF1ru7L1qn
	OJQ1/8cPsdBVK6IPF6MDmNo2A0sLHRnRIapq/rdVNErIT5A/mvcB1wfC4fU2dW/Y
	oZgL4HewML/aR1PYRmXKh5JfLc5Wrbta753OEpdN7pdtPia5Odb9Fec/InrqT/L5
	ZnUx07iUAwAM+WnszbQpyiaCV7UZPSJls4wfVC7d3kXj3N0ICdH8sCe9SxMzftne
	A/WSTr7RVx2YYOCF+g9sTm7blxmS5i1wAp+359g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:DYtdldExHBY5GtlpMHLEcWD8YK7TYudFzvuAZyyyoiE=:MSeNZjNkkD5RKKiiYagM9EnomJFfo9cNDP/9HIa8vZs=;
X-ME-Sender: <xms:zJrzasKp4rDunKPzfhYsnTgSK_8QJQvMREFW6Y5MXSv87Tzn2Lw3Nw>
    <xme:zJrzajB6C8tJCicIM3cDmLrV6X9HM0aWwp0xCcrOXxQuPSnkRfkBlYLeu2gbPQhCY
    3L3ynMKAnberpHC_8G35vThArpEqKg2NW3_vctVcG1Y3a3-6T9Hxfw>
X-ME-Received: <xmr:zJrzalC5_KpyCVEeBE2uT6anmsTmQa68QobrYDZIJRUFbWz1LdQYlTTwRdK5Ctj8dzfPM0jTmI09ME_M3a8CXxhHt7Rb_a7q7cab>
X-ME-Proxy-Cause: dmFkZTGLINJw2I5EklKw+vm1R8O6/XXWLhRN/jd2+91UpehwX+h9YsedSBU5VQGY06ze+k
    E0W7VN6orKx3C76OpTdYQWQ/U72yGv8jHGiYbH7SUkXutU8S+RwNZ1IKzEqg1x+Ez8upLw
    5pxA270UmUWideF7St5wd5VZDrXrcVR4w1YePXO6+P1LDoBb+i6TeeVVLZDCy3gNMlfd83
    pWwTsI+OMYmHHgIpQD/HnT5yPIfcRct1GO893g+9Lu2YzMEk2emmZdXuQ4k/Kv6RZ1wheJ
    mhgi+xauXCORF0+zoyg3kfAPd3XtHt1PynmFVZDRem9L4EEA5ZaCHKcA5iqEZ4kPacbRhx
    /ARtwIO9r4n8h03PHOYy/iUGTjCkPdp1LlYpLf7H/bqIoAeH0bUzYEpM2pU5ZFr6oCzcVm
    3gC7wvFjFl7vXls72DFEgXUMjtDnzcKMk0QH0Vp/4o6Dc6HQfSu2uunRoctywuPZ8EIcwB
    hR2zKRNCMAKq+6Hd/NUf4kZ/a3N67sUK6sHha75LWyXvZp8qil5Ln0ZMk+lob0Ya4XmAvM
    ghYuybecG1keKOY/hiXj9N5EB6z5O89sQf/Z+aMEkHjgffsI16iklEjGcFjWy902zOpSZA
    yUE9lu8V5qvu9qBEb7jyF2H1Nxlvwadv3UNbYys/tm/hY4/+Ub4ceviBW+qQ
X-ME-Proxy: <xmx:zJrzalDxeZftppdw7YVTrlxpkJef5tc37GpaiziR3Jab_CS1Me2ipw>
    <xmx:zJrzagpcjxiqDFJcdprwXqo87Q2c-PNsH4zAzNDaJ9j6EnJbrpjrTw>
    <xmx:zJrzavmF78r2oPnsXUSHClwiY-JXnGmmsFyFyRf17c05n6FkYD-GDg>
    <xmx:zJrzagwJH2BAizO96gaJu4xduUjNWbRVWqYxiPP6fuYfYIn67oe79Q>
    <xmx:zJrzaoQXpVDzCTH84q03jBCGlSDolXDxDaH-wRN6j4h6CCTJ8rHCZp97>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 17:29:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  stolee@gmail.com,  wyattj.holden@gmail.com
Subject: Re: [PATCH 0/3] Make orphaned commit checks configurable
In-Reply-To: <pull.2264.git.1794337920.gitgitgadget@gmail.com> (Wyatt Holden
	via GitGitGadget's message of "Tue, 10 Nov 2026 19:11:57 +0000")
References: <pull.2264.git.1794337920.gitgitgadget@gmail.com>
Date: Tue, 10 Nov 2026 14:29:30 -0800
Message-ID: <xmqq1p8spbg5.fsf@gitster.g>
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

"Wyatt Holden via GitGitGadget" <gitgitgadget@gmail.com> writes:

> When leaving a detached HEAD, git checkout and git switch
> call orphaned_commit_warning() to warn about commits that are not reachable
> from any existing ref or the destination HEAD. This requires enumerating
> refs and walking commit history, which can be expensive in large
> repositories.

I found some design choices made in 1/3 questionable but overall the
series is coherently done and very easy to understand _why_ it wants
to do what it does.  Nice work.

