Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845235;
	b=nfOnaYzxFjngisFZM2CObMxND5QMMva2OD4Pv0jZvYYRdbZW4QtZMIyvAlmi02MnCxqn
	 105JcOydmMi8tmOFQ2n/fUQ2tHRreSNR4t1ZNTQO7L/7/cqAuxHAGZX/dR/OdqfK0omks
	 Ie6VLk0XAK1LpfSUp2Ow1Ix4N2w8wz/AW2B9fDeifFYvJlg0YuJYpfgMg2Y4hQIxa+8oR
	 gIn95wX7Y51qt+SnP9LSvgp2DPojmAo/fWpQjMNB5XxQ9PuYBMTn+A+nhVCvkemj35bOj
	 da2FWSkOgAwyB3RgOkuDyjvjoR5XJUK6DqCr0dcSAP4+Uo3TvcaLWQk+2rFtzRdndEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845235;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=XwMg3XbeJz7uXLo4L0dc5eR36YlDulc/3pnZEeH0W38=;
	b=Iq9RbmcONUwu4SZEl7fKDQqO24oUdDA35M84QCbuMjf0fACRdxAC7649yDRJ+K/58E6r
	 UOxAcoz2b0QGVVUpC5WB7u61M+/9c/Pu2S+k+UHYmA2ct7sTPYeKLFr51XcKbzKwZw5Pf
	 dOcS52u1nVyFuGZaFIahCxUUygO3vl4ON51UqbplZNbkbBsK0H+HR9+R6fwsxUrN+8FHo
	 l61CxKVCzC3EerIs0NAEtj4+sPuMHem0f+qatCi1kj4SkXYoQUAteiLGcDiI5cIhnYHTl
	 XOZ41AcujkdxOchEGza9scZaRchy1pdQaIIQLxr2YOJm23Ehn56/25A7kKOCqsz+tYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XvqKPB14;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="btc/d/RX";
	arc=none smtp.remote-ip=103.168.172.153
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AAF606A31C
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 16:07:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2AAF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=XvqKPB14;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=btc/d/RX
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3243C1400043
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 11:07:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 16 Nov 2026 11:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794845234; x=1794931634; bh=XwMg3XbeJz
	7uXLo4L0dc5eR36YlDulc/3pnZEeH0W38=; b=XvqKPB14VJlSnkxqmYEzlNRxqM
	eCPinPExVI9mr6PMQfcKdH5wgD3sT29Jk4wAeu/qwVch1UmpoesTazFkwjiaj5WR
	v1+2UBsTnNtiLbQvmLU6rFe9Wy6E5uI3F7jt/QKeu1Eus4RBCVS/mXp9Fp+ABtXE
	v5414UyOvyOT5N6kXXiYOjdIHPmxhhmQEHDCs3vNCNSWQbILM2kM/tZa7ykO5gXr
	IE6704w9rTjhJ7TEZZKXyu7Zzi1lHT2XPZv5QcccECs7l7Qnz3ijPW9qPnCNvlfL
	q+hIA2qjqQqxuiAcQojZBMgYBVtk6MioZ0Fpu5hgMdoQjoo9kBbB19IlL0SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794845234; x=1794931634; bh=XwMg3XbeJz7uXLo4L0dc5eR36YlDulc/3pn
	ZEeH0W38=; b=btc/d/RX/ZP9fyb89h9Wb9pZ1hsK9TaEd9vy3DykUkdMLpPfJo8
	n4CsespbG+2wYOUdYtDqJXdnULaDBXqghe9sZU01VpaBKQ44LVVM+Yfo+F7FzpnG
	gzF2nyWVCu96TNiBKsHVV5gj/GsmHhbjYVt+bvQsaPIbYSJ8+9C2054W8sasuQ/N
	CgyEZZEBqt0OZbYnsmcRy14b+xTm7Fit6OS7U9paj13S6wphMmhlNO+vFcW8EtFe
	7q1xEBdLUg9yt5Xm4XDV0RcvOtEITErBsDxJJdoN5iCRH0DwNasAZt2ChPQGMPth
	8Uc9UmYufSs/oVESct9UrkmFlHTyu9cAJnw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794845234; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:gvIEBwl5pQ3upvWhFynmdIqlP+61alyK4pP8xoj+C5rC94q
	gkuCEcfNdqLP85+2jfg926c8w2HN5DOhIoE0yFo/MIeb/PKFJxgEGq7x+zTfluet
	/OXWgieF6xDDerK7F9VwepWa8bLjyeBnd2MgUls9j6t0TMXr4a8SouJLmThytbuv
	61W9WqVavugck8piCyhotJ3LxdvbT5RF5hF1vl7LF7/YCkbTbLgzq1TuhJr8oEAD
	la2jiSntqC+dDhTA+BoQSVd+C3wKwiq68t3DJR6tSCIBD3wOF1MSu269ZQ5aaeUl
	PsS3AFT4mPziScazZauUDi9s59SCleoev2d/JvQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:HWM7xCQCQHY7atMfhQVUQ4034BAl2f97boUcH8eRbms=:cnidwKyyRprrKokIcVJriEBEPZRLAtp2esJSeHBP9uA=;
X-ME-Sender: <xms:Mir7alqFuOQ8Wgh0IUBhKtugF4UIS1V3L3rURf5QyCcS4bGAEOeoQw>
    <xme:Mir7avGaKddrx2pQc6OktlZpoAE41VfA7U-CscolbbQ5xt8ESC1XHHunUiWtyeXrg
    SpSAOjjTpAHxxyB1uXXuXkb92fIh2RWu1u8Za55x_ofW9wTooNq6TQ>
X-ME-Received: <xmr:Mir7avmGlQZadyQRYtcnn7dSoYfKsalWQbL_ejhl1vssfX1WPKs85W0Pf0ODUVGpw-3J3sLCPRsexYLQ5hwL2bGfc6PaGCEfyAb9>
X-ME-Proxy-Cause: dmFkZTFxC0D8wjSxYuYMvSJpBvtMUu056BCaIN19I1Jy6uyAHnVtfg0qUTw+fSyhD0Q62b
    Y5Nf8ZY7I0y9So1aKlvOPtLHZo2U1lrK81y9IO2ml6zVV5Iy5KMxCfF0+dv2qHRcSj436U
    +EN9/9zFxztRqw14x+wBDz1p8XjmNE1qTFkbuk1rkm0KLGIN+95ZQMvC+WeckrEMxktxEh
    141ZEtrUgQbI1KWJqgk2vr/R0POAovuLm151wJrXVR3IxsHEpDId9gWnlVuAy9wbnwkhnP
    zhvH/od9Yo07p0i5Oy7XFD8YGI6nFpgHZG5MrJydn6EJlseKsU2pVes53Kgk4d7FXkWHfJ
    yhjnl/4+K3et8Cau1zl5qll4e99OcJWkKK462uqfC6oXWBBC9iqO0zglRIt6SXsm5Fhxun
    2N18aqDs65uoKEVGEj52puDsswGGjNmkScPcGuHdOiPNFWWUSDF5NQRSmcr+iCUi90jO0U
    aaSMRiuuy1EPfrG+GrjFa+gcsalarH15UmN3PYv3bqce7Md0kJziNOjSr/coohqpF8AZ/S
    AwU3rbBIdHKA6gllcpUgAWuFh9krycYShn6ywiLWe4WP2iPdQN4PE+tJGhPHx8yxwpHS1c
    gavRFoF/uDm/4kbhlxhyezzUtV1rjSg3sTmF2KYl2VjRqxblPR+LWhXAFZQA
X-ME-Proxy: <xmx:Mir7aqmxRGkTv9AjDJRdw-g9w41jm43nDszUNW8X-8kg-hZ6NTmHTQ>
    <xmx:Mir7aov2Ckoi_gwbbzhLnMrZCDyEMYV3ZvkIxUtdRM1Zjfgw3MaQsA>
    <xmx:Mir7allc4TxYryxE_vN2oNBLcf1WJKR27td4yskeCf3ghCMYqRxa4A>
    <xmx:Mir7artRyyKLbUz6yqLe43Dm4EFuyy_QdRTXE199PxdKMrpqiTnD1g>
    <xmx:Mir7anH8uu_2FLjyeW1h78S__sg1JsEhgqsdU8BAq8D7PDYMCWy5vVbi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 11:07:12 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t: use test_must_fail instead of NOT operator
In-Reply-To: <20261115-t-tmf-refactor-v1-1-d7a95cdeaedd@gmail.com> (Hardik
	Kumar's message of "Sun, 15 Nov 2026 23:45:21 +0530")
References: <20261115-t-tmf-refactor-v1-1-d7a95cdeaedd@gmail.com>
Date: Mon, 16 Nov 2026 08:07:11 -0800
Message-ID: <xmqqcxs4n4k0.fsf@gitster.g>
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

Hardik Kumar <hardikxk@gmail.com> writes:

> Replace `!` operator with `test_must_fail` for multiple unit tests where
> a git command is expected to fail.
>
> `test_must_fail` handles edge cases like a command killed by a signal
> or a crash because of a segfault, by actually failing the test unlike
> the `!` operator which would result in the test being passed as the
> crash is accepted as a failure (the test is expected to fail).
>
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>
> ---
>  t/t5564-http-proxy.sh       | 4 ++--
>  t/t6030-bisect-porcelain.sh | 4 ++--
>  t/t7400-submodule-basic.sh  | 4 ++--
>  t/t9001-send-email.sh       | 2 +-
>  4 files changed, 7 insertions(+), 7 deletions(-)

All of them look sensible, but I am curious why you chose only
these, among 14 hits in

    $ git grep -l '^[ 	]*! git ' t/

I suspect that it is because these are ...

> -	! git clone -c http.proxy=localhost/path https://example.com/repo.git 2>err && {
> -	! git clone -c http.proxy=socks4://127.0.0.1/path https://example.com/repo.git 2>err && {
> -	! git bisect run ./fail.sh 2>err &&
> -	! git bisect run ./fail.sh 2>err &&

... simple cases in which the use of leading ! negation is the only
issue with them, and if that is the reasoning, I think that is
sensible.  Contrasting these, many of the hits in t2206 (one among
14 hits in the above grep), for example, look like this:

  ! git status --porcelain | grep "^.*$" &&

which violates "do not hide exit status of git behind a pipe" rule,
in addition to have a strange looking leading ! negation.

Will queue.
