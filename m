Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793298694;
	b=SxOjBQSugRSM/mPeOAruoL6Q5zrGJVgW3atmNHn7YAIFWu7Kg5hOMW1+REYw5CZtWsVy
	 Ot0s54pTpdrlMaEJnbM6EePdqqbPJ+oI/Iz25uBzKhD2/OnT601KL814/VEls/a4TMmQE
	 NTKT2cxByx0HEJt53um9Uo1C7WasraEb/rRLo8ltvImY/YlmjSkyW+whW0tdnbidumsTE
	 0Bun+v7AeWPrRChT3u09+oKdPovlksHU+L2YaXLYH5NLJinSMi+KUwxGEucD5/8m6GttJ
	 lxHflBlQpECgDVBkdbyMMU9OCkVWPXNucnupqQK3Hq/kra73lJ94yiTJXfk0A3V+7fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298694;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=dMCB4O3peKSaDrTlGMiZ4kqr7Rh+QkRWsrW84MQgkG4=;
	b=y0xOUPExn2Xq/BYx1LbKD/3Q7RpNbUbEYTzjhP9XMIouPLiIvbw8N08bNB87xjdChkuN
	 tHZYy3Aa1E+swjPNrzTA5SKFZN87AFnGMf2AmP3scpNHYzZjO9O1D2RtnEdJB1CYudVd3
	 nEA0YIAuVICtzSO2KeOTbDMQ84SoLPJ3E01undLzMzCZ97SF2wastNr0W7zkkUfbILKdr
	 a4ha8EqgmgZsMx0q4R49LFk8yMTnE0z4kq+bvuZrUHDkkBgqGFTV1IifflHqIMXDxbliL
	 AhJfuRiE/eivtX3YeBfFbWzJPQDVinFMbwSyFuU0obqwB0J+4ma9PEn5dejOmsHOI+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZXt6ZANQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qwP2ulnp;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACEE606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 18:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CACEE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=ZXt6ZANQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qwP2ulnp
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A5761D00168
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 14:31:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 29 Oct 2026 14:31:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793298692; x=1793385092; bh=dMCB4O3peK
	SaDrTlGMiZ4kqr7Rh+QkRWsrW84MQgkG4=; b=ZXt6ZANQvFB7H3BuF4Bl5qQ9e7
	xVeZgZB4AJWUDY0VH+NRGN5WhB6Yoz0D/PQFhGEhV2Dj/dyUqRRy/FQ3bFWaIjXH
	wP7FxPulVL8h0hHJfb874OJBRuI6eipydBeMuouxvtlxQghg76Q3i7+g5zq2/l29
	UtcJcR9yrJ4XGAD3bhlEdlgEK2puASoKtxKHNOuYuRXr6DBHTe/fXtAGPbhL5zCn
	uYqaA+ffNZw3M4WLbzBWJKURo+3MX+meNS5piBNjSbj37Xywlrcp4vc9uICjZzY3
	lFcsy4kYDrIqA8olMFreozNHfJF7pWI9Zpx2DdoV2wQla7Y8xsyjknV1LLcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793298692; x=1793385092; bh=dMCB4O3peKSaDrTlGMiZ4kqr7Rh+QkRWsrW
	84MQgkG4=; b=qwP2ulnpWYu/+Ty81yTpGkZvJZMtyu4c6QzioeilekQyT31MF+N
	5aMOjzBbB+Ta0GJCdulbu+Xi5ZL6niMvxAng/iX+vymHLRFlVgPRZp8Z/5n9VnCm
	XhiEOlJwCmKujHVAyQLhwPmBZBRBpezjpX+1oDAWaH5Kas9sVm3TDV3EwIulu7HU
	Mf5VOrtDfu+47yoS5rS5iFfqUb8BdAvUpfYuTTKa4MD82is8QWrZe93Xo1pIil1V
	n3yV9coh4+s9ZTrEUjqSsDDETOA4vfCyJW9w37c+9MFQDNc+3wwGfmcnF5nzZad5
	giQbOMQZGpjohFmxxuBwVIflQpi1eNqPt3Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793298692; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:eQ0pTOpKFo/bvCgcAq6U8wgWMsv5Vwaoy2kz+u6hp/IlN/W
	KoKCBCqVp/YUL2LEnebUsgP3MUQXv6P/iJ99fJvr7/F/i/L8YH2/FBYKVUifDsAk
	X+yy4sF4M78lJcWJoZlhk0Pnleyjt0OF7ERpMXKlp8/dR7cU8M55KNBDTyR9wLhu
	Zeh5r7jSI84NxqoRGZElIiPlCVujSOt0UcGujMTK1Zye9UGzw6XJFFIIjW6Wp4xL
	KJE8SBz76D9a8/RlHApZEZzYhix6hfRoqyLtiwfXI/tmww2GmlRoS5t8q4uuNjfC
	AhHwgZKIkRZjjkuTzIxiA0PpQsCBWty2PCiF4dA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:5Z+JSHm/e8wwttFGOSuiZQYLmiA0+VAyANsuaVOMdao=:WJjs2c/crDI76rMPhGRkcjWSYIOSaQFGbUBB3MEXU04=;
X-ME-Sender: <xms:BJHjavHwBoSrL2pW_6sEZem9lwp-h8r6ZhFATgsA5bxORPRvoXiHvQ>
    <xme:BJHjajXdx_LI5iEFzPSzqrgpSXzpRPFNr0ogoIXUuUCXedNQ0WUGf72KFnawinKBr
    pp91a7t7CjxvhynJ2tMhARUQQjzvV44If1bjpNOxtSZ24-KLiKuEl8>
X-ME-Received: <xmr:BJHjamLbnEBwnFnM-dPZGcPLkWN0qJqbM5S7diOZpk1YApq1JtnqkYCUNud94jxj7H2lfVJk-aQlvQJGgiqJIZQQ3kNkjQM2wTcm>
X-ME-Proxy-Cause: dmFkZTE1MU36nHdfyebKGhablRt3DeKbizjoA2XGA/6EwWsSj5Z50mUF1s5u+p0IV0ebuG
    AgprqTn42jHo5G3AWCKd2GA/q2IAWnsgL2QM8ewRzkJZQQXzEvbZxRCQzqHZHImBM9slUW
    Q/ZKL9oAY+hkjmjtJ14YCT7oiv7W5XIQ2O17rzw8Fd9V2Q8uJQIfUJgM5iPrpHBR+gTotF
    n5QIDocGp5u8BCCsIo7Gg4uikvUWMXq73vXU7Ny/iYU0oYnu1bpczL+xVyZ+K8l0EqIDN1
    u9zyG2ACuWdN0XT3448gaQFOVoI2x862TGaFfd3Hc4WmH7mMEU82ra0Wk3vqiIkQlb3tfV
    WkRooOm+wQ1zh6tQkATz1mbr5EaZKaVi2bCgVSTQrj26fOwh1uGSAjEYMntkVDqJmEiG9U
    DDDRd/bH1KelKKaOF0LngWyJbFAYaGEK9OZp0r9/euirsBW8a0YVTGc1uTRJkwCuR7ur7D
    djAA2o8Sx8idYlBfkJcrlzTmpGqXqOo7sJ9wMcT86WU+r2NNCqGlGdKeOsKfYgzd2+cOaL
    MYtW7FI5EqYAhBw6kz94kpGW/x15cFU8FwPF/aScXSiCwi1vVxEE8/RZbCk35pNDIGAAZ0
    eoXQZlNLI/OzCQGGN8QWmKkjoEfXMHLjv3NLLRW2NlvbrmTGhuXMDtxbFAJA
X-ME-Proxy: <xmx:BJHjar-CW4P7_3DR9YHfOXPDh6C89yLFiCNBZ0lQBy7DtCs_02U61Q>
    <xmx:BJHjahJ7w_y-pHbLQLRHbgr_iYk0XMzfRt90DYybzOKhG3RQfSog7g>
    <xmx:BJHjaong-56X1Eq-Ne_c4mKQlvcksPQQ6hxUljWWsbHh4KnRalCThQ>
    <xmx:BJHjatPDMFHcIdZvSeBJH60PtXnjCcmjGRWswYhb0JKUc_neTvPB0g>
    <xmx:BJHjahpQ_TDtB_wGbg8sZdP1l2e5k319la_74K7MwK7SQDNoZeapSU88>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 14:31:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: Immaculate Mecha <immaculatemecha87@gmail.com>,  git@vger.kernel.org
Subject: Re: [Outreachy] Microproject idea: modernize a file-existence check
 in t/t0081-find-pack.sh
In-Reply-To: <CAFpMFfA17dnuLSRt97BrM0u3cHAifJybr_Zc2ahr_zq2nspgsw@mail.gmail.com>
	(Okhuomon Ajayi's message of "Thu, 29 Oct 2026 10:03:16 +0100")
References: <CAKUOgLz3sefhypa9yzLszW43uQ=Jor_nRBAJaBXXv0d8M2ePBw@mail.gmail.com>
	<CAFpMFfA17dnuLSRt97BrM0u3cHAifJybr_Zc2ahr_zq2nspgsw@mail.gmail.com>
Date: Thu, 29 Oct 2026 11:31:31 -0700
Message-ID: <xmqq7bj02wak.fsf@gitster.g>
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

Okhuomon Ajayi <okhuomonajayi54@gmail.com> writes:

> Before choosing a microproject, it helps to search the list archive
> at https://lore.kernel.org/git/ for the file name, and to check the
> "What's cooking" reports, to make sure nobody is already working on
> it.

Great advice.  Reading others' patches and reviews they have
received will prepare a newcomer to avoid making the same mistakes
as they already have made.  Reading Documentation/SubmittingPatches
would also help, but that goes without saying ;-)
