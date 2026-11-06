Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793937824;
	b=W4lpCPnt4+ciIun+04dO2wabLR7n3BdlFwOzEEhZQ9RJXDLyPXW/qZXslSR04+79BlG8
	 5DfTX836YKwjE1OO8gWOOTO0xzqU/KrjMSzJKMNCnupXAaqzCqOqhamm6+NmPzHxKP8QM
	 7Vqt8h/nzYelqd3RyImWd/kYliANu7377HPuLp3hkXq5Fb8rWdnrryMpqdUGSgOX4NQZY
	 qNju3L4uXoD1vgdmlDPKWZdd2suveOJGY6VIazNGhYQ7SyONYj81O6Dk4osAjT7diVDjL
	 3X/ajl9YIwxKyRGkerxn1yUjnVlI9sZuvkbsVtQRPxA8E4bSXSwnMFakhtTpMeettOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793937824;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=upmvkU6v0108fBFTAF/bMYD+ClROKtS0lxlRlcYljUo=;
	b=yh2sSuc9V2UaSmBQ/Rime65IFout5t32dJw8x2BA3bTrzn16BgIlKGjxCdJzlptji96H
	 7u/mMp38KTNJWZGJ0WtD2GeI4HmRo/UDSdAersjz4MYvN+GeUF6l/7L8w2gEYRohzJzlF
	 BP6sHbO73Be3hooeVantHxQNWkmrZURpiXzJLvVyirRPyoqs6rqOChAsNJTajp0f2d0Fm
	 iwK9neADDLXQrqvDlmWdw+/Xs6rnshaaet2BeCmrrKDdX1fT7SnPhIDU468JYvdsNtuBR
	 02ssi8b+mLmAZhDvfDmatz7OsI5tntpt2ILO8SJHeq2HFvz2G66ewKZ3Y2WUwc8o7vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b="MhVwdc2/";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rOigjYuV;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2AC606A31B
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 04:03:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2AC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=MhVwdc2/;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rOigjYuV
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7EF461400113
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 23:03:42 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 05 Nov 2026 23:03:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793937822; x=1794024222; bh=upmvkU6v01
	08fBFTAF/bMYD+ClROKtS0lxlRlcYljUo=; b=MhVwdc2/JmY379XQox8EwecKTU
	PNuTh0eCKfpXzUpsga5mRlammYIy/2I3IOiDhvDrW5eOVAoLv7GS0SQZp9nyOet6
	M/s/K4TDuqX5Asei6vvmzZMNjrya4LZ4vq0YLCj8MVCmw4ymIdP4en1EEHLpQtz4
	M3GeM0sw7yiVi2dhY69RGmD/RxZ9dfQ1Xwb3A6OMGWZUgBaV0IrKBVhRuNC5skwv
	3xPxnmsythIkwaIMmNENfHZrklS2Rb9vB7D+JNz5cD4LbTp7xpmKtx1RM6vVZJzr
	KtNraIeQdcE6r/rHynWrJZ0qF5LbQ3O/hu8Uf0p+dTJD3bmnnbP3eLoOutyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793937822; x=1794024222; bh=upmvkU6v0108fBFTAF/bMYD+ClROKtS0lxl
	RlcYljUo=; b=rOigjYuVEj0YV7CDTS2JLqAFeR90Lyd3SjqXqjH1H1s1+pnSkbk
	E84shV2fy5xHkSVXckriSgfwDFMPMebX1Ck9a8gD5rG+HY9TxG+2pxGOp2DX6ril
	kon3iyYDtn4bYR/Fgx++sPB0TwNiz7o+p7xnukD8aPj8IaP7SpfEjF//ma5a2q/i
	NMVSEzEQsAkzic4bEk1gXbdfDHF7xhYMAamdDA2/edXbxdwYUMkTVhkf8SktNRQC
	3UppAiuVYZRFDSZHhkb3o8oy99TSD6Q+D5S0sTMqWEEgWiEcxes1lYBBJ5BNv/YI
	j9wP5lMds/DNjcaq4B+iwQZxszZteT4f/AQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793937822; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:eTL3ipyFMwVnV6Mi4ULlA03gwQijMVO3tN92pCVnzP/mrzH
	LPqKyOYmke5XiEbJxj5CAYy6rKViVYr6jLzRkXwX4ey7D0TCJqcVujiYaMRw5LHf
	/z/u48hvdncbzRyZzFFdMPwzWOeyiMpXWFsIdk8/43/pOK78yPNxahZBV6g9Mn1a
	zvO22/jliLhmjNAfueSc8H7wpaYIrjpI4dO3qz/ythL3GKValf1DA9IScJk/Cpi5
	mtnT0obmfemJX8wSP0uhS1KaSFRt3Ga/NMjKu9ONyCvK/M6ej8qDiB2v18eksiZs
	GN9hidoG6Q/4sXGO4zlO+SIV/z/hxMGGYjqy0PA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:ZBoAIei//amqSn59C9UXJNkjS6wplSfD6SQE/V4K1f4=:pzgmn7q2rnjXOk9RidP1rcwsZ/pLioACAFwwxxdTLzQ=;
X-ME-Sender: <xms:nlHtatO5K4zO2DzHbaZREKCq-LGepJFO-e6Zwne849cKbr3xcjpipg>
    <xme:nlHtam9xRKMt6yJIBoS-jHFT3Bgm865wtCFlTeHkqsj67u73C8YOfdIqYyeMziHwp
    R2jOUU1LYtafgR_XVbr1u5haR7KuItkU94vBozOFppiVX9oBLAd8R4>
X-ME-Received: <xmr:nlHtahQUTETYlBoZLoO9rGrVu0Da19voQ0g2Q7EITl5iR_wsJ7i7OA7F66YZGyuOP5tTHrXQSg9HKxti8fbtCNwrSr4WJMpJcEwS>
X-ME-Proxy-Cause: dmFkZTEgduTcFUlzyAOKGhtBDdR5LzeRbL/+kLAekVaaAGBigqduPCx9BQYgWIKUVUA7e9
    +Xic9jlpkvs/u+78jYhz4W/6X19JxMP8vp6FAS6vESNcHM03VIZJNlOIL3c7J9ydw+VsXt
    qKtgh1AU/d0mYZLii4oq4uY6uZN+6fqLxKCjkVz98sPuRncYWnlHTFEnnrwRhaYZzPWyIx
    fPSFirSFaLRJX8QhpiEePmavkm4iWh1YgqxrcybSOAoe/+H3Tgmo6JiwXKu+Qn2zVQQCPf
    qKkyl4O4LIoe5s3eMl9VszmLSYht19ow5dOLdmeP33vq9SCQpN1ucaFYPXKUrqIddoljhz
    Kr4tKtEMbdA92TeFHuRWFTzOr+RVQnnP1O04cCHVVp3yfAUF46P6ZW3rPWph5e+W4elHYb
    Se/X8fNPubsmqG824D/uoR/QVwHyTXOM2+3y5pqrO4feqDLP0OiEJkQFOAu2CaVf7RPaLq
    ah6c1lxo0wpubUmq205yxbKTh/0TF03csWvDyj/L1hCnWSXI3ZiiVqOXpSerdlUrdUiZlq
    zpbMhZOb7E2xo7Z6ZiGBlC3KEA3RrxsQNttW474pnL4r3S29G0mL96QKU51yC+yMTaz0Tc
    LLialYTDI0huettLZOHoTlPlIz/oJhbRSY2mtvp/RPb6s25DZTlODAktBpqA
X-ME-Proxy: <xmx:nlHtaomS_iGHc50BuWbahydlO6q7m9MEZ6Fp7IQ1tXrEC9D5uv9afQ>
    <xmx:nlHtahSwmMLqrgs0SSY2LjEqJ4FI6lKij56hZ_hOM68pscR55yD_Kg>
    <xmx:nlHtamM-OwKk4DrFWNhNVBuegbfpDqdCDOn5EOtGWxGj-3gzbozS1g>
    <xmx:nlHtaqWVdRJku-R0ebAmJQkBEParHG248wj5lDfzAuTfJt1RU19moQ>
    <xmx:nlHtarAMPax3EE7jG6TsuiDwMZMuvhWSE0zMGrmepHUXFnh_J2ESbJ4V>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Nov 2026 23:03:41 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Matt Hunter" <m@lfurio.us>
Cc: "Colin Hinton" <colinlewishinton@gmail.com>,  <git@vger.kernel.org>
Subject: Re: [PATCH v2] remote.c: defer remote.<name>.followRemoteHEAD
 validation
In-Reply-To: <DMJFKJCI5DLL.12R7AMFO4DK2Y@lfurio.us> (Matt Hunter's message of
	"Sat, 31 Oct 2026 20:00:00 -0400")
References: <20261018235508.848-1-colinlewishinton@gmail.com>
	<20261023185007.21642-1-colinlewishinton@gmail.com>
	<xmqqecdezfr1.fsf@gitster.g>
	<CAHeTm9NOqLA=BfTU9ABDFt8+jOzaRDPRrMNP8thzAQN2NVZAew@mail.gmail.com>
	<xmqqmrrxdhox.fsf@gitster.g> <DMHZCS9LOW3N.ZJ3947HUCXZ8@lfurio.us>
	<xmqq33tnz0hb.fsf@gitster.g> <DMJFKJCI5DLL.12R7AMFO4DK2Y@lfurio.us>
Date: Thu, 05 Nov 2026 20:03:40 -0800
Message-ID: <xmqqjymqobc3.fsf@gitster.g>
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

> I should explain myself better.  I don't mean Colin should avoid
> splitting out logic from the main flow in do_fetch.  But the end result
> can be reached without introducing a new function.  I find needing to
> hold fewer functions in my head makes the code easier to reason about,
> though that is a subjective point.
>
> The idea in my head is below and is
> Signed-off-by: Matt Hunter <m@lfurio.us>
> Feel free to run with this or not.

Hmph, interesting.  Can you rewrite Colin's patch using this, and
then merge the result into 'seen' (after reverting Colin's topic
ch/remote-defer-follow-remote-head-validation from 'seen' first) to
see how badly it crashes with other topics in flight?

Thanks.



