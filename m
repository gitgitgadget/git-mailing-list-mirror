Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451573;
	b=SI0Vz4pAm7iQrnkIGiS6+KSh1LRZXFmr4UP7hY7Jad7pRkKE8FwTxT6nuLmabd2KsFTq
	 c+3suDJDh7N335ZXf6pHYZMPsp7zcXNlCOTNpOesZi/0IfCdgtWpd2QkxWoaVIt0awgRo
	 vpt+VbOy5peHkIyBRW8gQ3M65fC2CVOaxCy2vXfVydMwsaC9HByOa5pk0JUFYRRRNtctV
	 85qkDtex4zjRC0WnDgH8tULfDItyZqj763mHcCulULybo01ja6x6uTr5kr7E7S6jliSOx
	 /T0XI72OkE7XqHftCXFdm+1Uqmsq17vaayZfvSYjeWfAuNz/AZ7OWBavie/jAQxLtGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451573;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=+CYQVN21GthEjfjUy1CnoOI+gSL/f9w7bk7ZjS5VSZM=;
	b=isyI11J0gGUWqxW5SCpXWKI4rZg7dv+8xqckCgmghLz3UWJRQJnJTKy8m/8LaqNYaf0U
	 mM6sQf8ejJ8DobLztOTe/Yy22R+OaMUa2Qer/ColDWonA4Qu+evy5dmcelG2LjIoyT+wS
	 jta9grVt7GyPtvEvEwnvJEnhHu0X+1SW1u3bXuug0M6JuO+zMW2yp1mUa0F6bW5zqRuan
	 iUE27Y3JgrQJa9v74zusUnw6w/+7zCwek+8F5RKWaEB6MQ6rhzz8mnQndLM6Ma6hDp3hh
	 TM85RkaDWHkP+SenHE7QUSkdxlVvSyOLDrfdkvD6AyyGWvvQnp6mXtbKEnt65DZppnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dk7Ytfys;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QWqcy+Rd;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6E6606A31A
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 23:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B6E6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=dk7Ytfys;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=QWqcy+Rd
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 94101EC018D
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 19:12:51 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 19 Oct 2026 19:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792451571; x=1792537971; bh=+CYQVN21Gt
	hEjfjUy1CnoOI+gSL/f9w7bk7ZjS5VSZM=; b=dk7Ytfys0bHRRQ+oGk3UQG4PDx
	s9sqx9/CpvEhQmkwhI2eew/ct7rBZ13mKtbvOX6YWKzaPTQ+ugjoLWVIQadsbVoh
	UFYTQC9Gz09P8hvCo3W8SpuM+HcszhHRgenCvL0QXoABm0t5+SH8Pv2rV5jtyfbi
	Hqysb1KFX3Yan8zEH+57s+uEbTFpnBUusvIk1IuFRX5eKN4rEt8Bb+ks++KxyD1O
	NFfKkE+meIkie8r72Xy90rDrKpBAImN8FvsQNOw6F+izvstPbY8FDf0u3K86BRIu
	LAQa/jHp7xEbJhURjs6QE7l+PbF1CgMaQqfCovUGYdrPvzBi383iot6Dan8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792451571; x=1792537971; bh=+CYQVN21GthEjfjUy1CnoOI+gSL/f9w7bk7
	ZjS5VSZM=; b=QWqcy+RdYZjtjrdL8USZJyuAnjR0fIuP+i3mjf+S0g+kEyiOPSD
	4A7uh6jefiwpyFw1henaaYXhieYgfAtWqTJkWg6qG0cM7nG/fwaOL/S3qaOT2uzO
	aCIrZftA3k3ExA8p4q4Mvox+Fwt3QgGW3q3EfAYN5Ozzcrg8krX1qCJ53Hz5LUm8
	1Mpak4IoLz9vpu6dHfKRDM74rd8j15ETrAggVveSxwITs8u3z/a84X+gVCEukwgZ
	VV76MZbZOvk0JMzeCSdrvQa5kB2YrOK9QNu7Udkkuq4eBceY3nLafjzLpN8EGqie
	lmNu6PMWn5LPmdGsqVeJ63t+M7jBTg9Lm1Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792451571; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:KIbrUCnKfDnTuL6EDQFxMUlu+G7QSfeykUE2zcMUOSWC2PT
	FnNsKojsamEkwhwOJ3sn7IpvpyJmD1IY+Tsx4VYRRgqCmjTEG3o3HyySdZ471VnI
	dJZ/juHFIwPbchemW1m01aKFEOAFKin7dESOsSY7d9mfOuPi8Ybmptc3BHGctePd
	siVkLTiDO9n1qVcUIq+L+zUxN/6kThOQV7LGfv18+4tB0X+EYz5+Z7zR5CtMiODd
	dv4MEgjB6I5wmytTs10zP006jAxFmw+qBuJ/2rsw6+8KsGrwt8KqgJnMmDVNrANK
	iAxQvf9xQFrtevF1hBuN0toPcJ2uKsqQMbS2VpQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:OVqRm8oGe6CQ0jwTLRVy5SXEEMOepn96oQJkllgXmhU=:YFwlsYgOi7XnHP8/qfpDz+6w+chSVbspZPwXtY28r5Q=;
X-ME-Sender: <xms:86PWakOXlKRMTXX7cQS86Ce4BYZU7VMdSMaa6kUaZFRw_PnkUk_2eA>
    <xme:86PWauraXxZRv8B7wwRCIYC2KrgW82E9sd2jnNVb0Cxcd-mHJy_f7tRiaRLbSe7rw
    R91V9JdIYGObmGME-BVq0rCyhTlOt65qHYymG38K2b-AeHaTYqCqcqe>
X-ME-Received: <xmr:86PWalHM-alVifqqExkRz6rZPlx0kDrUtvVlZ2tWlvscDABwsW9iLKRA4VZfYMFdCYUjb0Ud1Wh6AlHwGX05Vuf6_YdabXCNVs9m>
X-ME-Proxy-Cause: dmFkZTE/ONnjigWMvttv61nWc1f4XqIR7ag31uxd6P4Qld1HNVF6Z7S5jRenuTBCFENqzc
    bIJXolF4w0SrdJA3EAIH4Hhr1nHEo/U7y7mS8SHu0xoUccU2XUcgMu7uBFC4mwt3B+rSLy
    fWNVRW3BHQYIF2L/d4pVesjVxcDfFtCY4ZMSqp/o57y5q60rj2PDDyFdFZ0oMA0zsegVeK
    ffR48eJjOrrMI+Ii64IK4KRaS6VQNB4P/1GVUiEu0bXl7/8ABv933KAnnJC94Ui60n0ZJs
    oTmG8TACAWHu1hIJW4r4xTEewz5uox3ZMmtlF7gT49NAkopvpLHA7Lu7gChNXtluynIQth
    xifTga689gUIon49QZWHsivcgOcA93Xo/hpeFBd2Kbw6vOWXTamE/yb4lt/DX8zgcsayaC
    M4y6Vjuly/8Tdng/AZb4178BRoiyy4BRK4UKWlBu9xv5QTeglx4iCoAhnNie23fPmCuAfL
    +8b8YgBZ3Do6x78gxfmZ085ki5dbtgSoOpQ6gMcWteCt0Vc/PZkBEF2YOays84sJjpZhf3
    6jv67P+oFA5qkb3pYLvQf8kEJE5urdfTYLz0A+jR0bhfGyWQwAsPFQpwBwspcX4yzL9BzE
    SLrftuNLr8PX+k+ynECOUhR81fd13/B0OjO0MzSJ+++AceMwP5HT6HpgVkNA
X-ME-Proxy: <xmx:86PWajo0hknFe3Rx4Q_0dJ-XqSXLQrqMpahbxPrAroYSig_WVhSqLw>
    <xmx:86PWauYn_ritLcD8eW_y3y6Y-wh5INYwxWFao-0eDiJ-Iv-1OzZzSQ>
    <xmx:86PWasW_R-f8U0xiSDpIXXO-L0kljWLCkP6hIKpRpYOfdeMt6IGLBw>
    <xmx:86PWan8bfJ2PsRGfEor5eFwGRF10fHRHXcvNacpulbaMQx-8D2mfMA>
    <xmx:86PWai3pU3uZgYIHf9k0kQnZlcy34f7gMQrWB0Xn5DUPhExMaPqtkV3d>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 19:12:50 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Igor Wiedler <iwiedler@gitlab.com>
Cc: git@vger.kernel.org,  ps@pks.im,  peff@peff.net,  jltobler@gmail.com
Subject: Re: [PATCH v3 0/2] connected: fix the connectivity check with
 alternates in deepening fetches
In-Reply-To: <20261019110918.71193-1-iwiedler@gitlab.com> (Igor Wiedler's
	message of "Mon, 19 Oct 2026 13:09:16 +0200")
References: <20261014181134.56220-1-iwiedler@gitlab.com>
	<20261019110918.71193-1-iwiedler@gitlab.com>
Date: Mon, 19 Oct 2026 16:12:49 -0700
Message-ID: <xmqqy0btz3m6.fsf@gitster.g>
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

Igor Wiedler <iwiedler@gitlab.com> writes:

> In a deepening fetch the connectivity check passes "--alternate-refs"
> as a positive revision and walks the alternate's whole history. With a
> 7M-object alternate that takes 227s after a fetch of an empty pack.
>
> Changes since v2:
>
>  * The shallow alternate test wrote $TRASH_DIRECTORY into
>    objects/info/alternates, which git on Windows cannot resolve. It now
>    uses Peff's version with $(pwd) and relative paths.
>
>  * The trace tests use $(pwd) instead of $PWD.
>
> No code changes.
>
> v2: https://lore.kernel.org/git/20261014181134.56220-1-iwiedler@gitlab.com/
> v1: https://lore.kernel.org/git/20261014103507.35317-1-iwiedler@gitlab.com/
>
> Igor Wiedler (2):
>   connected: negate alternate refs in deepening fetches too
>   odb: ignore refs of shallow and grafted alternates

Your patches are not sent as replies to the cover letter of the same
round, which is not how we expect the threads to be structured.
Please study how others' patch threads look like.

Thanks.
