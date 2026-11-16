Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794866922;
	b=eLkNHhhHOl1mw3azFuUacFmktVDYqGzg5Sdw62ANG5oc02QV2q9uLOlj0xMKpkdHYBEh
	 7CpsWiTLk9/7CecGLL5qA70GqOoO4sQT7VlHRPqoNH0TbcJu4Wyk1RFOUoXIJ5OMuTNxH
	 r8Cql4Hrtzv0YueasnWw8Ew9LDd1/gMOg3cPQFhblBzYcaorybwhejNc9yjTCbrh+xs2q
	 xUb1ttcWVzB3zAuLGmPe1/O9zUW/krStru+HUotMltwooSll1kTvlxmoUZZZgWxRm1ybR
	 aW6NiXTqXFBLxOyuW8y5c9JgOZuus439qrpWnlNu8IUVBQSz697ZHS3DsgLGXQy+zYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794866922;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=vyZcifSt7EMJwxlqBSrVZQKFxRO2Co2clASweHY87ow=;
	b=u8avFLdjC4rqRAwBUCSxitaT6TICPlHzQ/kVn9hAvqwI/erqaINbY+wxsEd+Zid32YnI
	 vFXwtJS+6hZXtJ725LMPDC/QvZcm0cjmnJTUbPob1iNzef2ySAffRByeoxseO1gPe949b
	 56MGL3pmOpHdg0fdPtFFIk8SAJGhaUQMe3Uh6eCDv97enHwtZkkZiaekIuMGH42VCOQ3c
	 Ex2vbE5NSy/gAcQvflKX0XFW9U7NzkOUObRJjOf+gHFQkg/TfUS3NDXAeIPltWU/RSWKZ
	 aizRmhH8IEaxgQmxzRlt5z34stLzm7/5T54yW6UZMWuQQw6SJ4W+/aRxgcAng4QXBEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KWZr04Dl;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TqJDGOta;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EF9606A33A
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 22:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19EF9606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=KWZr04Dl;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TqJDGOta
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 3FC67EC0824
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 17:08:41 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Mon, 16 Nov 2026 17:08:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794866921; x=1794953321; bh=vyZcifSt7E
	MJwxlqBSrVZQKFxRO2Co2clASweHY87ow=; b=KWZr04DlfwfPrP4hQneeL4ucVf
	4y1hg+kH9W1+Pmh2p3unfkTE3UDGhvUlPUqdKkmy+gAuVCQaAhbzCtLauPg4J02w
	RGwLypSIu2O2z1raQrVA8H4gewG6t8OEjP6P2R4vSNqK9hYUsd8UC/xSC4xtmpDb
	HtbU9KQKPydJZ9xnVoFla0zW9Wd9damkGzi4TITGtWLCazQjoYv0XE/O2f0FR+pB
	wekbKXjcObhLZhfo3vjV24ZFCe1G9MH3C6tTPf9t2E3RpXU9PpY0uRgMRUfNEDWA
	eP8Os27cnqKa61ICWjaikrksP6Hs3ZpXgHDMjaFDz1aTX7wS8J8KFXNVRUjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794866921; x=1794953321; bh=vyZcifSt7EMJwxlqBSrVZQKFxRO2Co2clAS
	weHY87ow=; b=TqJDGOtaFwnDw9BrHL4oHG9ixGoaRIBkA2y0oX385CvBaHf95ok
	QrjVwEyojBgAq/n0aBnlbjMLIakM0eEjteB7pT73yOIZIZoklo2R/vqR0qMi2TKb
	aWjTxdEb2R8NkTjzLCq5219wB66uURWdb/qPho25kHcljw3bpA3ccS4gClYdoDR7
	ItNF1+sYZIAsqXq3+EAOEtj0ajhfbNEbrL/ax5Tx1bLoK6KerduRTlkXmSCDyIm5
	3opA2/2QWMmnzx/Xud+PMcCUFDJtzD50hFmxNL1PlcuPaLNBs2yLNKSYsCAwgrnA
	eE7bKsvTj69RH64jqCtyncDrxbwWe144zMA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794866921; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:BrcM5la368I+sqHEK6vIILgrK0dBG4y3QUnKsQ95nAj32kT
	HVorELE7q2yBkqFC6f+4tGIWqBWW3LI17RxrDTcMWjI1qf5jKrgFkdf21F+VGzQQ
	0CwglraXrBtCLWaqAqCy2lg3XvcJD5CHlTlK98rzzxScR/qjwkrfHXXh/n12cp4O
	Wf/1wGZj296wk3jdxS0NnBbwdOyNb7eQqqoqqhbvG33LZgphgv1vxw/TVsHOPcAD
	nBtZ1CWRoe/yHaMEQSXzqgVxmUOS7SEWUcjvOnX7i2D6Be7RZKciCX896+PcGkF+
	w5gVUh9sL+A6CpZ+D5QbRaNfhf72pYu0Yh2WeOA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:+EjKzfHjt4nIVeUY9yzcctwklpkwxirQ1sVytCujt7Y=:xjGmABFHtgWG/dP4EznDAtf9MjMNkSshbgsZe0PnjXw=;
X-ME-Sender: <xms:6X77ag9Qrq6KL8i198avePrTGLw3LJJK8VKnz6wgydinJLLOcPQ-dQ>
    <xme:6X77asbRasNoQnf1XDFrm-5iF8lEl7jYk7Tr4eG96pheyoWWxIxsT2mZeKun4YWOu
    QAfpPBpuKUJ7CvbByf0dFJPlH0xQQnerIypNqCQ4zoz4KNTQAoSoA>
X-ME-Received: <xmr:6X77av2PPowfYtGiI-0CVihhk3FYhoriap1YXPCJZVvjTBLl8Vw8qp9h00IeS5DnOcMp5BKJ1Wt28OrXPydPPJgYdyRZ9KmXShVR>
X-ME-Proxy-Cause: dmFkZTGRawD3MKsL3lcbr7r1pqYL286z36UzG/1/W+oMYCccsUrJfShLwWK5X/c08SWqOm
    0aP5ckMA903oen8WW+m59VMVVj0TYVYg+HbSp7qvNOEvAmvH74Qvl+1lyax1YUnuuDAHOY
    kBatqWJuR0rmHsZ1qk5v78Du4m4tV5f+Xl4bLsxC4JZc5+0ECkpPWswcmb4y3rB1uinov3
    rPYzXQ/i5mowL7OAqr01htCI6i94oFdH4uJ5VyMmOLO1AWH0EZg9LdlzFTQyrL4uKH+LDj
    G+xZs17jZuGrcCkbnJ3A/NBqq2TN17kFGdpX2pnhhC1RJJ53Uwes4o4HMlz+Ds+wi0QyUY
    sX5yQgjOIp8TliMpAN6lPXXdgjQaav3/WJzfAH++A3+hIrahQf9bxWE4Jd3r+r0wXDN4pP
    M1krsZDCyVBfQ9aeEl2K96AY715FLO0NlWW0PY4k3bAA5RzKFhE6lhJeOScFveZBRa8O2f
    QwIrQ+p6zM5TOOAGHs3lAogEQeK8UmHCPHE/Bao/PKaqZn8h4oEq/uOca75egtEVa5udvS
    rqxN4cOY1JSoZr8X+MN0XyAbA2j+/M2XiO1epnR4ll3v2eBH3Ic6Q6mk2y5daU8jciSvyS
    DlEabnWCyklUEbuONKhS50WchSH4Ie0/wF2mn+ADtSvB+hvf+g8QIYS1HUqA
X-ME-Proxy: <xmx:6X77anYMKvN4mqVY6N795qT0TsScsqwmvWlA1O_SVNdyOgsZ1faX6g>
    <xmx:6X77anIhV4dj2COAzkDdN88BeW2WihkFLZ_GH7NheUTc45hGigoRWg>
    <xmx:6X77amHIbSiomTISn-XX0KsFe5ugmJOe0DX47IpKiFymL3wqhnDEbQ>
    <xmx:6X77auvtOb6qDSlri3qyFw8dONr0ICuYApuNEonjuMNWqCDt42oYRg>
    <xmx:6X77ahhIHHedkbdyUV_uxk0fJt3pw4NWckOnv-oCkiT9BkKWyw0iJRRn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 17:08:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v7] doc: add new detached HEAD state guide
In-Reply-To: <pull.2250.v7.git.1794843180501.gitgitgadget@gmail.com> (Julia
	Evans via GitGitGadget's message of "Mon, 16 Nov 2026 15:33:00 +0000")
References: <pull.2250.git.1791384721919.gitgitgadget@gmail.com>
	<pull.2250.v7.git.1794843180501.gitgitgadget@gmail.com>
Date: Mon, 16 Nov 2026 14:08:39 -0800
Message-ID: <xmqqik1wjuoo.fsf@gitster.g>
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

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  1:  64f50b8248 ! 1:  020aac7cc4 doc: checkout: rewrite detached HEAD state explanation
>      @@ Metadata
>       Author: Julia Evans <julia@jvns.ca>
>       
>        ## Commit message ##
>      -    doc: checkout: rewrite detached HEAD state explanation
>      +    doc: add new detached HEAD state guide
>       
>      -    The current explanation has the following issues:
>      +    Add a new guide (`git help detached-head`) to help users who
>      +    accidentally end up in detached HEAD state without understanding why.
>      +    Make it dual-purpose so that it can also be used as the DETACHED HEAD
>      +    section in `git-checkout.adoc`. The result is a shorter guide that
>      +    covers more material than the previous section.
>      +
>      +    This fixes the following issues with the current DETACHED HEAD section:

This makes it clearer what we are doing with this change.

>       +it lets you easily check out an old version of your project. For
>       +example, a data scientist could use this to run an old version of a
>       +data pipeline or a programmer could use this to figure out when a bug
>      -+was introduced. By detaching `HEAD`, you don't need to create a
>      -+temporary branch.
>      ++was introduced. You can also use this to make experimental commits
>      ++without being on a branch. By detaching `HEAD`, you don't need to create
>      ++a temporary branch.
>       +
>       +But it's important to know that if you create new commits while in
>       +detached HEAD state, those commits won't be on a branch. This makes

I've stared at this patch for too long that my eyes are
contaminated.  It would be great if somebody gave a hopefully final
pass with a fresh eye before we declare victory and merge it down to
'next'.

Thanks.
