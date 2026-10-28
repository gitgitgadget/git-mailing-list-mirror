Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213850;
	b=DS29VRA8Uxl/Yo4e12bTkVgsmMdG9ZYj/YettIjTYr602YBS+fRi2bFVtJS1MCh9im5o
	 zNScH3qpMiPmf/vRDQD2TYjnU6HbFBlNYe+SP9w5BtYVg8PPPL6Bf1aexXrWiRb86Jhyo
	 2YjhhUoGFICc8WrFPYnAJPyyVvS8zjkEdOuwuhScBkFHTvYtBWFnog+kl8UpAB/MbCCps
	 O/Q5UktG3bMnSe3EtxKVbm0GBysswvLivpS26/FKmR4+CdNFC4Z0CyOQlJUqL0ymsF0Kv
	 chYSbfXR+D6N+ArN26OIGIy4fMWg8CN0yNnVFgiMFuH9DsPZgX0a/FGRLZoq5MhyMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213850;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=/LcIrwXzUcxE1Cx5Gsrxn/65zutohfQPh3BgRMuGGfM=;
	b=0BneUegrvooIE0wxo4HwjVCkvo+oY6O0Zefndvt2OfZgIzISIxVn0V7rN88SS8Yy17NH
	 yRv93I8RiL6kPaZ+3bvehpPa7iCQPP8xaGWHnAmOqAzGYc8uooWbRIPhLBlc3n9JXua/x
	 DK/t/B3suaKpraFs03xq3e1y0fW7Cmem4g/3c68VVQF232dmL2xVRfnxdZUTBCeBaz//V
	 CdDV+dFkUZ6yTR3A+XGyyiI8Kf4vEwRTO0Ex/Sr7GQnp9yn/MG9zqk89OqHTC061zP8qx
	 2OjYFATBh3N2ZxSJSapFOCz2XY2xTbdCdjwRB78l/6sr8R5AfCTy75u6hbLI+x3nHVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ddkdAKBg;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HdQXMfJ0;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3BD606A320
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 18:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A3BD606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ddkdAKBg;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HdQXMfJ0
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 727A5EC02A4
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:57:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 28 Oct 2026 14:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793213849; x=1793300249; bh=/LcIrwXzUc
	xE1Cx5Gsrxn/65zutohfQPh3BgRMuGGfM=; b=ddkdAKBg07MTMF4YDTvahfPsAu
	YLw1Eu0X+ywrBQNbYncNQZSRNz+8tq+MCHmaCEfN14saYmTQmJzdw90MgxrTWEhv
	k+ialfCiNTOtngyMbXrdd5zqzn/b7yZNgzA2abHscEZeKZDZfL50XQ4cqMq+w31N
	ur4XW3dr5Sg9sC2sTlNDHUmtbMhFIXNPcKgBGBQGuPgWjMUWp0frePDIUGcMF7bx
	iDhi0kZgs4t3WoFeMBcpWUvnfhJPjtoZNN4nv2znmjnu60ifLFkacpJRFzYRSnyp
	z7tNeTGR3GIRZYt8HZEN9psthxX+S/F8Gk2fR9PIwFOHa3Yurmn2/0P4B4BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793213849; x=1793300249; bh=/LcIrwXzUcxE1Cx5Gsrxn/65zutohfQPh3B
	gRMuGGfM=; b=HdQXMfJ0Xdni5O/ykYITTSGJJZx5YYzhOht59USV/Dv7p9bizQf
	rNYoZ0RxjeGPRC0IX44iJbCVvt1r2oqiO918LkPwDlscJ7KKWeUlW+xznCfCJvrL
	ig2dEZ9KiP/4JfjgmRF72HIv9xIf0nIunELoOlmBWQszSuvsKmShUOw/z1/hIamG
	xADHwYf9pX5EM3+NTkUh/GRdQJMhCSXT5FYrlmnRYV6uetv3EmrYcoHgTD20YlKD
	iKQ/K4RzDsPVJvq19PUyBbVA4axmw44EhV8PmY+GGPLPRVKqdieanmwoqDLfvdvI
	5UULn+RH1mEIGP4ySu7Ko81RlzJaOBSGwMw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793213849; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:i31JoOvPDE1MKBwz6cX4N7Ih4qtO4WrXxZDtUlgJXPKNc5+
	oK6IIIoKYlqQ53VeoeDF1nVYmhCJAokoj8UnMohvFSS9llGAVQAroDzhklDrT5PQ
	jxf3fAk2ej+RthqJGNWkDbYW+9Xv2A8D5eLH7OCM1BWJ2CthSqdqqMwn46A0XYnZ
	g0PSxtAGSNo+IT+Ibz8Tj7AbIT7LHais6tDfNA2uqXY3ThYz0VfAH/MlUeRKkkaX
	2diXW2gN0KVFNOK6nIOfziKLX4OTnyIWk3h/hFpwPBVa3g3ZKB6Ikztdy8fHIqDM
	1ub3EYHJ4RRrxo78TxLq222Gkz1FDuWw8Xjg+pA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:StyqOD8LnZ9wq6q0/VBG+uvmgkdieg1YL8kGPVY+QGI=:ePm9p5iSONmmLEVwe5UcGfiqyqsvxldNTxE9++W17n8=;
X-ME-Sender: <xms:mUXiaoL6M6LT1pt54fmeWwceY7Z2hfQp8XrTyadEdyy9a7SN0ucWzw>
    <xme:mUXiavI1OdIu2U36QM0h-LDfRqoGqjTRSFTDkJI0AXP-yEhvygUPXu9Fc61ggfEoD
    wj41l-eL_SK7YTn98J5sqCZpbJabX53NRZ555PPaRStgoq6myq99w>
X-ME-Received: <xmr:mUXiattx1e1mMtu38kKMgPPn97NO-lCOzBdYUqi-L7-ke5iI5wpLNTu5hqMMgTkwVD1v_K3hIHF7-NrzFIWnnOuYC-OBmmDnBier>
X-ME-Proxy-Cause: dmFkZTEsFLOL0TNBSRg/v2aQ2A8fpSpgixjM7AKtqe0EihhxHxxuow3S6mjnwh7qVWwHzy
    5ta+WOVmViudnXBUPtmwN6objPtpcEYYVcbVoFBTMhRyoXfLPKM5k67DQCeWkKUaHmGIHB
    ozxvgztxSmlIAxVNsYRHodOi0NFSIQ2Kaq32mhAtXdvwOls8PedVdL06sOkpk2ddBvODYH
    gdKGesWuyxkxQ6oxY8iXo7ZRnu88u/1v4tkh9JcyxAHarB8w5YM7806zLgxgIO1K2jKV3a
    uzBwoZwMv8Yz+V2VciDmLyc73BHe28hHBpzWdEWeCvQx7MqWOiUrbYnCJSKHIlehLSJBWl
    cUNnxJDVJ9zskQ5ko7Dd3JRjj/itZFxEhf4TRMsIui5PzWlsOEi78E+re8a1VXdFaPtOk2
    1xzR1h7gvYy7RV6FUrEkhIooSFZ46TYH620N4Av84N071KVVIUZkHgF5rodrseiAdp3dS6
    kDE87RR2WbLwk6hlTAWjZ1olk3xUuTZZ9GKWHhWaK2flIREmOPBy7PSSZ+W987+j5jA0VT
    KCnFw8YsaIsMcaCLp6LBJBvBpq4iWCEgdJrX1w8z/ZtxRqdmb0n8zlNNiKpq6ApZ3DwUCx
    ZzOI0/9kMZs2O/aaKycQyD4+7rnbVDhtNNAJs+O5MAHgrtse96WzZJf3X91w
X-ME-Proxy: <xmx:mUXiakRKMMF3Su75AmWFY_13NfUWE6dI9uV0-iW5ZHXy5SQ2r5XJRQ>
    <xmx:mUXiarPsOcDZN1DRnFnVa06fH9PJ545igpDvY8YiuzMLJccjsSmB8A>
    <xmx:mUXiahbo7KCHoezzsosuDHOTo7y5tblTUdzclR2XgcAxv20jP6c2BQ>
    <xmx:mUXiatyole0eNxxWVJOmSsl6Lpsc6NLJrB540siTv60CuQ5nBjakcw>
    <xmx:mUXiatNXTG59HwU-6nmAttorgDtDSaD2K_r66pMCWp5plPLrCY3rHt4v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 14:57:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 4/5] setup: provide hint about auto-discovery boundaries
In-Reply-To: <20261028115412.169748-5-kaartic.sivaraam@gmail.com> (Kaartic
	Sivaraam's message of "Wed, 28 Oct 2026 17:24:02 +0530")
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
	<20261028115412.169748-1-kaartic.sivaraam@gmail.com>
	<20261028115412.169748-5-kaartic.sivaraam@gmail.com>
Date: Wed, 28 Oct 2026 11:57:27 -0700
Message-ID: <xmqqa4nxac14.fsf@gitster.g>
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

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> In the same spirit as the previous commit, we want to improve the UX
> of the Git repository discovery case when the GIT_CEILING_DIRECTORIES
> environment varaible is set. For instance, consider the following
> scenario:
>
>   $ cd ~ && git init                    # dotfiles repo at ~/.git
>   $ echo 'export GIT_CEILING_DIRECTORIES=$HOME' >> ~/.bashrc
>                                         # stop ~/.git swallowing every
>                                         # non-repo directory under ~
>   ...weeks later...
>   $ cd ~/.config/nvim
>   $ vim init.lua
>   $ git status
>   fatal: not a git repository (or any of the parent directories): .git
>
> The error message is a bit unhelpful as the gut reaction of the user
> would be to wonder why their ~/.git directory was not discovered even
> though the message says it checked the parent directories. We can't
> really blame the user for not remembering that they had
> GIT_CEILING_DIRECTORIES configured in their ~/.bashrc.
>
> Improve this error reporting UX by giving an additional hint about the
> ceiling that auto-discovery was bounded by and also mention what
> GIT_CEILING_DIRECTORIES was configured to. With this, the user would
> see the following:
>
>   ...
>   $ git status
>   fatal: not a git repository (or any of the parent directories): .git
>   searched from '/home/user/.config/nvim' up to '/home/user/.config'
>   $GIT_CEILING_DIRECTORIES is set to '/home/user'

The second line of the output gives a much better information than
before.  Stepping back a bit, the "(or any of the ...)" was a weak
and ineffective attempt to say that ".git" we claim is not a valid
repository is not necessarily in the current directory.  But would
it be still needed with the more explicit "we looked for it from
here to there"?  Can we combine both into a single statement somehow
to make it more concise and understandable?

Here is my attempt.  Would this

    fatal: no valid repository ".git" found in "/home/user/.config/nvim"
    or any of its parent directories up to "/home/user/.config".

or something like that be easier to read?

Of course, such a change would break scripts that attempt to parse
this error message, so even if it is easier for humans, there could
be downside.

> -		test_grep "not a git repository (or any of the parent directories)" stderr
> +		test_grep "not a git repository (or any of the parent directories)" stderr &&
> +		test_grep "searched from .*ceil/sub.*up to.*ceil." stderr &&
> +		test_grep "GIT_CEILING_DIRECTORIES is set to" stderr
>  	)
>  '
