Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908612;
	b=zXmCqzXW7Yv4fW6+fyNdORBIwcDbFtWuRvx7xq94+hJp6RX/eWqr2OHon2Xmv+tzfeJF
	 mOhn9X4oWwqOao7Ae+cOglS46SiEBBH3Vwb3XCwnW2T3k+hwkgtqhNgS0mUQecgZq47fp
	 MYt8o53eB9mYvt7oF1U3LDGQ70XLokIKAisVoop2KmqTPqH4MfyoIeglkEJEkaJsGkjZv
	 w74tzVICApuGGF43UEcxBss8TzfIz+O+SFGU025cWM8uxFfs35tlXu+SNcYgSiomL8vF2
	 H6fCIigP030w2Gw5ccYjGCuOgZaFqnqfW8fW95MQziLs0zvjPm1nozLs936sI8h5M8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908612;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=Nf77Ek31ZCuDJieCB35kqwq1lmanCRO6q5HEfU+AfWM=;
	b=A8f+eQta16IeOE8/DuyG67qoyVx0URf558+Asga1xTlTEksnxAXYedBfN8D8aFRgVxHM
	 WuRnlps4CyeMfTeGhQfypdC8f83vt9rHGkgMKlzfHX14OyUCQriccUrWfk6cI75YhgGpL
	 r0sEfl3xdjUTztHEL4f0qSs4XvbdMyyBuqEwO22+ZjTjvolaxdYcvUMd129rYYurRnpGU
	 1N6Yun74BFcYNYkxB0cY1+1UU8CsHNk5tw2AGVE4EsGSUKnjX29LwjirC4an1yEuUH65H
	 iFv5aHkwXGhLoxYdzq0DAkIcRV7jtlABMyf95w2BB1SmASpJbB0WPJh7vjEW0JWYRLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=P7jwQWyy;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="P/POGDs8";
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67C606A32E
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 19:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA67C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=P7jwQWyy;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=P/POGDs8
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1C252140011F
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 14:56:51 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 05 Nov 2026 14:56:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793908611; x=1793995011; bh=Nf77Ek31ZC
	uDJieCB35kqwq1lmanCRO6q5HEfU+AfWM=; b=P7jwQWyyAiZEAHqzRezaAnlLcP
	xbJAO7HdxCBzUnH+zwpMqi2cI8JW+jKv57ZATdgSigp8odpmIQFBXa/AeglWPFBo
	7466jevWOeQkzgTYGmB/ZtUgD/ypi2+IMVVzMHgmn7WKyPYLquB7HUJcpYxywwep
	U10kI80u3Kf0f9EhnxJgTz+pFMWEJPZW9TfpqQBmwmPVcxdmdMAUDqz/eZkQfw6V
	vAKfDs0eMy/VLODw+ZEwOQ132ZHo9HWnXw9jpAPkrdOyv4eziEA+jrxNOssU2ixU
	chfgLGIG+KUrEPrBPFAI7zkAn0YcnYyIbvbHnsxz1d3chLre/+cxCcqtuQdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793908611; x=1793995011; bh=Nf77Ek31ZCuDJieCB35kqwq1lmanCRO6q5H
	EfU+AfWM=; b=P/POGDs8Ywy1NA6vJoVBOs1WhfIACtXMjQxwAUA/hU8t5W116tS
	FfEgJ7NvTgdf8B7n/RTjI5qNpAR+bagp/oAdnafDtcv5SqQSnl5lPyrlgn4EyRRo
	Z8XsPpWLC7W9cLgeUimiuZR38H5yQ/uXSieQu5o57NYA3J9n7bex6+25Fw7y0MOa
	1ZHOB/zg2fA4JPYkT/Z70VdacO6WdM6IHlkeu0YFFn9WbvmSEUDtH2aOTrXagW05
	vFAwOF6k/qJTzeVPZj7tXwep2aAyumWRc8b2dUJGeXfVZSMsICnILd6MXeMknNq0
	V3H40NvJi0spPg08hHyTVJyU36IbGXM+Upg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793908611; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:jPWfbs1wiXV8SxVrH7vO7hqq+w/kbAD1ID/epIQqn0eC00o
	kbO82PyDMSXn3bCcehB7x/prTdtGkW44TXvqaZtu1HxR3NPqBVR99t05LrLiRfmp
	CUjggXHSwayuEnssNkxLMvsK0xqngKgI8zzNAem4PJ4UaDKZXlCk6/iZL/x/c/+O
	WVcxA3kIiAae6YYxl4D3c+WI1YVPhg0GLHqnjTrXu9h1pMBMkgEoSe6UT8GgqlGT
	OH5zwj7orDsSTczxuXhLNsyX1SegmBFAEamb3kePSdeUPebNpPCdNG74qKLP9XgM
	QqKQOd1FmDiX9PGTrVrLh1zt6bhO+6k8Ezo+7Xw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QvryfQadgLwIZC/o3FPo9gMNw6tn/sjkInDIjYhTwz0=:9kK0ZHJxNlRHFNHr/Xs9M7q+Y6CCRJb4aKCusro9MjQ=;
X-ME-Sender: <xms:gt_sai8OdPLeTeGqVyzkQcK1CS8hh3KpQv1MK04F2MOOSZOnHu0bJQ>
    <xme:gt_sak9ISlRlt5nucle-3MBIzqmxlbyVF4oS7gGY6eatdeVppSbCJG7V5QsPlweee
    Ouz7Rm2gxekkPCsqtfW5naej60sGbFYBxun9Q32QOBpFcX4dAR-HKI>
X-ME-Received: <xmr:gt_saqSfr7Yg9_LDqcbs3R4FaXhWymSXD447ltf4xsV5vZGo1dj-pmtC6LXteIBScE0xxVTpL0-eJA8FCjPBqvriqB74HrUunkJX>
X-ME-Proxy-Cause: dmFkZTECNs6QafmKEyK/XBSN3/3HyJ7P8IYG+xyrs+QT0KuZSsNIBp6CiAfkK3KUEKEs7o
    kgveHOwwEuibZ4mJ+P1LxoX2NdMvSuzddMj2QAaIIhl23Jg/XShRuQFt7R8wMERmn3AuAb
    Bq3gVANbTwIyyJOvVu/ivxYEj+wQiuzk5okfUhn6I2GIwkh/T7KX0UWfjIDy1lke0aZfib
    pG0gExN5Zuo5gMgiDotkCWFDKvVBD93/fkGTGxByqQcKQcKNTuArSv7rOHu3zk/b+OxCIC
    XcvdIwl/shf97pSou3x9YKCToQPjwmI4zSRHDBborOg06vYV/r+5HjhRoumKy+UAxKxhOd
    zLmv98XS/HaCUoEpTkxvhdRyP8viXPErcMTMx/LQJtuihevYyFH9EhEG1KJGmdLzfPni1H
    eo+zw9MMeyArD0k+Gux7xQz85fWCpzODD1O/PVSBmmeGR7iC4RwSl6oJC1SQ4kFm2KfCiy
    I/kFmJg8YVk+EPC57scgv/oy4dvyLQjdYKI0sbpa5MHq8Q6UWb5TobXaIIiw30g1KRL1Od
    gaStFHhkoRVpn0BaFHBgSqlYa46UiFXYSaC1ZVx3j6QazpCac1teVMnv1ADnUF7zRk/qiu
    yumA4l77kLMILgJylAENh+c6coyD3LoYGwcmt27bEx+skkIOgg/InAB1KQ6g
X-ME-Proxy: <xmx:gt_sage_E4TFNDPL1t1tWWoJ5b4OHgfdm3zjLjETPLzpuZ3jIy7mlA>
    <xmx:gt_samB0MW4nLmnz5FMOdgTiUTY8B_N3tlrni2ndLfmndVg1CXL2vQ>
    <xmx:gt_saqksajTURoL6-n8yh8ujwjmaJnEXubILu2Jfmt3BZZxr__2H5Q>
    <xmx:gt_sapc1--JxVLGerCbF0X2y6hPJMkdQGQWJ_V-xWd7BFMgRgFRqNg>
    <xmx:g9_sav-wNHeKgXMZ1wDm_aMi2_GYmOihbjSEniekfG_oyl6SP5w9ULfw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 14:56:50 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Kristofer Karlsson <krka@spotify.com>,  Kristofer Karlsson via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Patrick
 Steinhardt <ps@pks.im>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2] odb: do not list our own refs as alternate refs in
 the quarantine
In-Reply-To: <20261105185632.GA2898829@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 5 Nov 2026 13:56:32 -0500")
References: <pull.2285.git.1793200705017.gitgitgadget@gmail.com>
	<pull.2285.v2.git.1793619933300.gitgitgadget@gmail.com>
	<20261104024806.GA1492379@coredump.intra.peff.net>
	<CAL71e4OreARF+dbCU3S8-_umrFEptPLPUiPDH3SYBx6OYjVpfg@mail.gmail.com>
	<20261105185632.GA2898829@coredump.intra.peff.net>
Date: Thu, 05 Nov 2026 11:56:49 -0800
Message-ID: <xmqqwlqrrr0e.fsf@gitster.g>
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

Jeff King <peff@peff.net> writes:

> On Wed, Nov 04, 2026 at 11:25:38AM +0100, Kristofer Karlsson wrote:
>
>> No, I think you are right.  The quarantine parent only matters when
>> the object directory is not under the commondir, which is rare.  Your
>> version is essentially my v1 without the "this is a hack" framing
>> (and also cleaner).
>
> What we really want is "where are we reading our local refs from" (to
> avoid reading them again). So even if you have an object directory not
> under the commondir, we would not find our repo again by looking at the
> parent of that directory.
>
> But I also won't be surprised if there is some arcane working tree setup
> that I'm missing.

With those historic environment variables like GIT_DIR and
GIT_WORK_TREE, and GIT_OBJECT_DIRECTORY, any random arrangement is
possible, I am afraid.  I do not know if it is worth worrying about,
though.  We've seen people use out-of-tree GIT_DIR by using the
former two environment variables, and I can see why people find it
attractive, but I do not recall people using creative uses of
GIT_OBJECT_DIRECTORY to tear /objects directory out of GIT_DIR, and
what the perceived advantage of doing so are..

> Anyway, what's in your v3 looks good to me. Thanks for fixing this!

Thanks, both.  Let me mark the topic as ready for 'next'.
