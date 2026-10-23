Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792779270;
	b=RSuWNbEE/nbfquKwx2zly9jBDAF/+0XInEXjAu8yLQuonw+X6IM2fP2t+Sj1y9N6ZQcL
	 IbliBCg3zuc53iSfu1mO+hrsUqXd0TN3y0cSeb3rMHXFwXlu3KYuduuh3bYPaalvKLacW
	 v6WRSLgeksTxAZDetx1zDJYcsnelknx6Xj+BWpkZb4yo7aNFZwN3f9pW3zFd0P6/zV3aN
	 ZqB6NFqPlmq6A9WWQXhKVbgfQYTVDBpjGtxjEUHFD7wBqYboTEAlQNJdYy3uYhclqG/l8
	 I8FVdu/yZVEsXeh1MD5+C8Vm/zonRSRGLyBqOeg5JofmVq/I98jUWTmHN9PVlvq15Uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792779270;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=yh2G19Ch4yfkUYGEzC8nNE6YLwfJOhVWaHVK4ZmsLkQ=;
	b=HHbiUQOh34wT6tQfwnFcD++4Eq2mBKlg7cS5HxpXWIBsPzw2AIula2Jlbsmf7uc81Ki+
	 avNUKfQnbA71GvWTJIalGSTnQ/U66zmr4ZkwJ5+CCmkH3XWQPN3CzjzbUl1ABeAYxcdp7
	 SiB7zsvs2Q+Euw/I70vFnWVMkv6tY51BmPyBhKOCI3xTgklsgOxvEKlWagAh3VYL04GFv
	 qEQ5xsazK6nelH/76KwN9+LND/DhH34emb/1DGjFnBPUxC6jHjthkNHuZ96jG02YMD2mt
	 /TBqImtaTVnzRHE6Aheq6aGEQCh/mdwKGz1WuC2Hq/8hYcGrWO3Ufsqvmp4+ek8qnqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=YuF9rmEB;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gYbm0+9t;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08541606A31A
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 18:14:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08541606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=YuF9rmEB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gYbm0+9t
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 519727A011B
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 14:14:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Fri, 23 Oct 2026 14:14:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792779269; x=1792865669; bh=yh2G19Ch4y
	fkUYGEzC8nNE6YLwfJOhVWaHVK4ZmsLkQ=; b=YuF9rmEBy8mbAdmETnKFFvmNhH
	OSTSSGGh2G5qfFvQAXluQqwWaSVRR7V3e9FLXphgF64Jcr+VUtg9rbL1Cfqbu7zw
	Ywncw2Xl/klWDu3x/ymq8vZAVdUvmD//vqK1jaxt7DifOLoZQsyTBKbUrb69FxQP
	fXrT18ULSpZYSWNA+JD4cGKMev2fFKnqP52wMM4+e/svN2hfCPo3ZpUEPAyak7zn
	+burF7KAotrdVW9l8awh8dNwoSsJxFddsiq7pX+hjpt2KObKS7Zsz3WSfUEBLqEO
	Reu7IImrenDs5daUIEGbQKCQxCXoZpfTymorXFSJ86vj9vRmS4FUMDacIlIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792779269; x=1792865669; bh=yh2G19Ch4yfkUYGEzC8nNE6YLwfJOhVWaHV
	K4ZmsLkQ=; b=gYbm0+9tFTMTkton+VOGqAjsXIFVHFQFF/709SnhUQqlFJoqARY
	xrpO2BIcVlmFC4WmHVNwfBYGx5+XEAKs2dy+zhux+l7ChEmZHOk4Y8vmO7xKFshn
	k9qPZ1mFXKC0DWa7oq4ilABkUlrQX2JcfLDc6K77Dc1IcTSq2KyNLQeSW5Ijvobm
	TE2gaS+BceKNWgTagoQ8i1iFj5Bp+71fw2LrGDSNI+Yd8MCpPHd/rhanFFjZFzSu
	cBR4O6ajct73QOgH8kSyK/SNdAamQl13970wqL0+eAkjbjnlzOAlSIETrWddDHBd
	eETxxuQNOv1nOdozf1Ob36MTgBw7KA9mjrg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792779269; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:fiXXtb5ooCFrRirKIcoohzBOI2XSOPAPpHnqXezSpv06deH
	T2AKtAe2FGbYYe0K+yJBq6sshHCPcBAmMIOOacf0JYI17qP+MIZUksVkjKMezBwj
	mHEVdNtc6hz/KFyd1feCWrNKRLandMKJ3kUCLY26Z75AMAYbE9O2wdk2BawjHpQO
	F4fbEYQKFfgHcW2ha/OhoKS4uhmRBxcf7qOEwrlTReiLQspzEG9YdLRbt+4VEwru
	BENo5fEXYgtOSsldzUB8jUS/f2qxNw47AQxf0xR1D42Jb1TIVujyVKQDhzjh3dEI
	R23UfzFNosvD2NgGvld3K5cx9RxTrnbEYnJvDDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:4jojhKb8xpL+brkdG1aOkA8hDUZImzAp5CMwUnqn7Yo=:zB8rk4oL3+UyvDnTxpWJ1izVb3S4bVjDxLrSnCv9yOA=;
X-ME-Sender: <xms:BKTbambZkF27lVoP4DWfhsW_eIpch2--PPbmz4Mg6JqZw_RL4-88KQ>
    <xme:BKTbag0s2IkWFaD2IY3wq6i7bzaMQSb6hmyJ-M_qmCfoKTN7uheynp5EFk-cnEqqt
    WWoMg0U4Gk4yb3On_7LPHbI9k396VZMXbTuqbhLdIESb_LzOOwobg>
X-ME-Received: <xmr:BKTbauV3GP-CUylfwrkpjBYifseNN4o8CcHG7vn9OcCSq1mK-1p896yu0OMRW4oliGwZsAlkZ9Y4aCIYJuxdX3PkIUClD0dvOPoo>
X-ME-Proxy-Cause: dmFkZTFyMb/cOevKYtETKacMrQoZPDWzZgm/DKExXYjEjb4YM6VbKXXVZAg+B6WTqqxiKJ
    qKbW++Yq28PEMWnGfEJVV+PJjxpjp6Zw2loHAvzEgk+UEduCWxPqc7P8Tr9Yg9wxT0rUP0
    I+HSzHfGQdliv8rrJ5VFJ2SNeaWDpV2Cn9W4JI91NmYNqavJEKzIdWurJB44HpMLZfa8zI
    4YB3tc4y4SKuocLpDtFwuJQf9FOmWEoB1nnPU5s3tQKm4+IDW92xcGj6NcMStz2om7z84H
    Wf6Qgjw2P2ns6BAcQXYX3+sJe3GBzmyGMJOzMc/ljr/YZSKijvz5upGnNYEtZn+Ja3P+YN
    f7WpoC+q4/HVQuBAjG0M3eUhikIHhdxzoQc5FRgZHCE5PMovfFXWYWtrMX0xLY5b08rq7a
    Gk8s52zcK9uK2huRuzbItwR05CMrvy64ReeIZIbl+Q0M0Q4ot6vv3BF+y+O5VILwrzMFpM
    B/V57d5w4+QrH61RAXDvtYEa83MLqV3Xux3SQzBpaov/IreEbFBeD7eXilVIIo8SR1J/pW
    0Zr9/cE3VO2NJk2YmlAyA9m8nVrfWEE9aA9OLi8xfpe0lvLgTDZl3lzvQw7KEWi5qVyLsw
    S03fPXIcyxBwzDBJPAgCDZL2dQl3U4Y1RO/m8oxUhqYUxoBtMPfM1QLwJbig
X-ME-Proxy: <xmx:BKTbaiVOCZ-brohCyQlsLmhR677SceHXT1mGkR3xifRT_ezOQT0PcA>
    <xmx:BKTbalf_qJ2PQUgW6fBU_CdsNPUQzGEZp48GVW7D9eKc-k6uynmmmg>
    <xmx:BKTbajVjItdiXy7RrJx4tHnXCl7FXoRo8b2Qixv5vdhof0DtaP_GAw>
    <xmx:BKTbamfldFf6h8ZQ6GFtb8O5aTUPCnjbgJ7ofHinggkZw2b5MJH2kQ>
    <xmx:BaTbao2IQ10mvdwTEzvkss-fc2rMjWnzYQV32aylH15iVO7IG63EKcBh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 14:14:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Azuama Odinaka Maximus <azuama69@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] rev-list: skip --grep argument in early scan
In-Reply-To: <20261021172458.6373-1-azuama69@gmail.com> (Azuama Odinaka
	Maximus's message of "Wed, 21 Oct 2026 18:24:57 +0100")
References: <20261021151253.3689-1-azuama69@gmail.com>
	<20261021172458.6373-1-azuama69@gmail.com>
Date: Fri, 23 Oct 2026 11:14:27 -0700
Message-ID: <xmqqzew45loc.fsf@gitster.g>
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

Azuama Odinaka Maximus <azuama69@gmail.com> writes:

> +test_expect_success "--grep accepts a pattern beginning with --" '
> +	git rev-list --grep=--missing-only --max-count=1 HEAD >expect &&
> +	git rev-list --grep --missing-only --max-count=1 HEAD >actual &&
> +	test_cmp expect actual
> +'
> +test_expect_success "--grep does not trigger --exclude-promisor-objects in early scan" '
> +    git rev-list --grep=--exclude-promisor-objects --missing=print HEAD >expect &&
> +    git rev-list --grep --exclude-promisor-objects --missing=print HEAD >actual &&
> +    test_cmp expect actual
> +'

Have a blank line between tests.

Do these tests truly verify anything beyond "the command line parser
is not broken by my commit"?  There is nothing in the history that
would trigger '--missing-only'; there is no positive indication that
the pattern starting with "--" was used by '--grep' at all.  The only
clue that '--missing-only' was not taken as a command line option is
that the command did not fail due to a lack of '--missing=<how>'.

The same issue exists in the second added test.

Thanks.
