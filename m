Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701045;
	b=SRHIsTiCj0aIedXpXWRjqwxoJaPmUO3zopLXZDnpA6ISvEzBrbrIt2EBWt9K6gD173js
	 bHYIPjWOWGqjpogaSMaVG02YSx/KREbOv56eGqL9ejuyVZeIHUkO6Eq8fJH4/JZRpcuz9
	 /46ta0JwV4lQrZ3P7ap4i9R1HRaTe9coV13mPYdlupVKVNBLJ+ZxQHwKqkPxanz1p1SF3
	 KUhRvEAMacwTeArtnHT1/1FLMQjZ0GgWJ2xprsYsncjwllbIZ4dMyZ3JUt+9kJtQ7wwWp
	 /2UVK4PrEF1v2SidR07v06Rl5lQ/CH/Q+3UxYz/MqiFDFt66/BFvmEZkNHMWvQx6OFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701045;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=c7QkNcxmvKq2IMvQ3l8BE7/iMCwwQkLcn6U025jNQJg=;
	b=AFcX7BgYVOjg++zvsyIn4LNFn4pY+DWr4fXrxjSA4iPElq67QAl3HNGOxxIhNP4saIYc
	 qxFJ7RbIZMWTlWsxVRcXeEEZeko6HGkhxkZ0FBiufLCuUVfLM2OxnvqotYh5kzxVoiR4y
	 szLSpoFbvAVThRShdxIg6EnKj63HxsTyo6XWGznat7uDWMXAIDWFWUWLRpfzIaFYwZyvZ
	 0Y9M8KD0mbHpd5RYJU+L83idVCDYuUKUWpxqXeRvOEDKbzd+X7To5kXdiymM27qv4IO42
	 yk8iJQBNw6NGrTpW6FxboeljO5TNzKlLRzWz6VCOA6USqmfYOjbWzSUefwpQobgXrYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hCOVVgZS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KkBxaoZl;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBDB606B119
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 10:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BBBDB606B119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hCOVVgZS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=KkBxaoZl
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0C75D1D000B9
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 05:17:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Nov 2026 05:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793701043; x=1793787443; bh=c7QkNcxmvK
	q2IMvQ3l8BE7/iMCwwQkLcn6U025jNQJg=; b=hCOVVgZS3dgESJGm9Ow/s+XAFn
	5kQZEJZtCYDPETP1DC/Ww3iuDo5nwmFqaEvNMeYEfbxBGKooo1BNWHUoki2AUFa9
	k6jgyY1l0QW+Pumgmvnq910A5IYytRgAFz/vX7q+FFweiFQeDWVf2Bxp908C6QhB
	IRP0lsx2JpY6U/8yVVrws8L6R4Aoqxq7pIVaihufDXUxaEZi+bM9DwgiTZhx3ZFO
	6qqibvZFrAwh8tSQOWgBgvlOtKf3FuJ4mTEa93sSE1eIQYc3qFnQD+cyVapTKfX7
	UDpWggUXRYGsfXkN0mO3DP5St2egiD4b2UzPYJMrVL+QfJ3W0L/ygPMQX76g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793701043; x=1793787443; bh=c7QkNcxmvKq2IMvQ3l8BE7/iMCwwQkLcn6U
	025jNQJg=; b=KkBxaoZlUeKTWSndd1LUAooRQPKZffyFzMnTqEv4jT9r0XGZM8X
	xhwVdcHf0LWfHWO3DFt5K0gy4kIShSLotZpEu4LWekDAU8IVn4Re9sn2qsL/oBr+
	3YtPpb+FBuVyXIsyyOsArvlwhmxUL/Ho2J7gkY55cc9ZTJXMtOlAHZU+iW18xFDM
	jmQbA+VQV2QCaSZm6mmJpF6JXPnqMKZBj2YfLtm4zXFrdKZHQzEk9L4XMlGWG2M5
	F3GcNqZDl6HwnQ30kfXCCy7TBt6xxmmka9wHJcaOdI8nvGpoTuydNAtF1icTgAlN
	ElDDYUTaQz8b8euO3Flkf3Xf8sydaQnqLNA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793701043; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Vni9fHgrvu3Ep+caTrvMC7C3adi9tcVyAKw4jmPNuCFVM2I
	jLlp7Hqc+WxMl+oj64go3ArRO6krefG+xvgqvcrp7ruexB3ht7FXDwo8IMg2DDAc
	Il5L2O2orZzE0diUFxY21KyBWmEU6smvVW2Rk5G3w2paxswBOvhn3kwaBDiB6biG
	HLH6rPl3q+Uwjj/VaGzLp84GC5z2+5mfzq6in7RXx1KYrMm4jFPmvVsbrErCLU7v
	u2CZwT1NX4URjJbbQwSuH2LwytmYS63ECZDIMz2+zrC+RGMC+miwEoT6DlqJwbzs
	IXgbnZPL2oG4AnFLOyy4MtH8TF1r34+G+iUXZ6Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:pZkP0rgWLIGmKdioJ3MZpOl5FiVekLBNlPZbAYZu7F0=:DTzgc7frLCUI05EMO9IYLi9wkIHopuUsCeYs7WR/ypE=;
X-ME-Sender: <xms:s7Tpah-eMlSSoOhtUialcfEpWd_FDL0IJXPYXslewlBtFfxCfWosbQ>
    <xme:s7TpaskTXhUYoT2Unn6pqooqa1ypUBOhPrBkPSzlFahLMz6k91cnw3NjRoszMaGRd
    P8A7o4HrJURyr4K_6F6LNJ5amphE6X_Ymh13uo1V_n61WsZfKkJTmM>
X-ME-Received: <xmr:s7TpanWVM82muVRZtu_FSKDfzN5y8JSwtQWtjJScwyu8RVCihd4s2Q>
X-ME-Proxy-Cause: dmFkZTErF9kKBUv6Loq9o4X/AF/Uh28bOqZDJb4zVatY+USv59LDODSHeJt4BMPW7PnNfE
    S+7fSY9HcZxyf0HmwBkAwKTYkxoktCUfD6FxkDy4Ek/6f5czWlk1hvUVeVJdKBpyLyOEcw
    kGg+SDP4CdRjr58EqRasJZWGSOXrnTuO9JaBJow35bH+rm7eejfym09pbseZdq+bTne19/
    HiYa7lyDaDRLHqfDE535aqoEIPKJDbaVS8IrBbO3efrgl9ZQaEvXKRiTXC5uy27L4jTpjB
    jy7m481W6GcNm6V1Tkzo6fnby1ZAPBGT+xFoDoBeLeVigI6CeFU+LN6BzFh9rVr/O2jvjl
    G8WpQSLmcO8W0Eaay2nme4sLXpOmruwPk1wN/xwbaWEuIQ9q5WcBdrzyBQz2LuZbsGglEL
    p1X2YXxTJTYu0dqL1fJ149uJ/1qVGZnv77wqJO53KL/DgnXvwYDFWpKMI19YIGnIC7kqVX
    gvJsYfUp5/thJV1Vy7Jb/fPayV35DQdzSRtxsAj1SQNX/XVAA7sBjfu+0hY3ydm5bkDFEt
    VC9MMR5vNePkQEgCVNenCG6BzYQNsnKuiq3kD33uOdTHLKBg8Slm2j2BNGQH7/3MLFB5ox
    Gg93UqFVIdAMud3ry+vRNkMwj/Euz2iBrXM4Xh0dyFMm02mxzeAQud8e5xjQ
X-ME-Proxy: <xmx:s7TpahHrunp4cfDDZQQ4BWxxxmjxHkynbYxgeItY5eoRQPWmt_GDVA>
    <xmx:s7TpajcZidc_jArREbh2HpANC1y8zuTKr2PrQErenGRBUJCewd7axQ>
    <xmx:s7TpaiKAt-aDDPSE5eOq9s5YL1ffDEi0WuMKJU36CC8PQT5rKi8o1Q>
    <xmx:s7TpaoFi0QrlOk4Gn1QdRcurvJPDVFUUNIwZdJxAI4iC1e6wZ1nGHA>
    <xmx:s7TpaiEHcC7azktdm8GXbIWlQNmI05EUWg9FcQx8fDaUhJ2bODKdroNO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 05:17:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4f1ccf02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 10:17:19 +0000 (UTC)
Date: Tue, 3 Nov 2026 11:17:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] rev-list: ignore replacements in the connectivity check
Message-ID: <aum0rJ6T-OFWrMqW@pks.im>
References: <pull.2279.git.1793634429929.gitgitgadget@gmail.com>
 <xmqq4idyhotf.fsf@gitster.g>
 <CAL71e4M7yFnTzYD0eVVGRmzkzSXbU0KZ-JScQOyB4-dB5xkAHA@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4M7yFnTzYD0eVVGRmzkzSXbU0KZ-JScQOyB4-dB5xkAHA@mail.gmail.com>

On Tue, Nov 03, 2026 at 09:35:07AM +0100, Kristofer Karlsson wrote:
> On Mon, 2 Nov 2026 at 23:05, Junio C Hamano <gitster@pobox.com> wrote:
> >
> > "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >
> > > Teach the connectivity check to ignore replacements as well, so
> > > that it verifies the same objects that the commands relying on its
> > > result will read.
> >
> > Sounds like absolutely the right thing to do.  We might want to say
> > that we check both the original and the replacement, i.e., instead
> > of ignoring replace refs, we ensure that the commits, trees, and
> > blobs reachable from the replacement objects all exist by treating
> > those objects as if they were also at the tips of the connectivity
> > graph.
> >
> > [snip]
> > We can address the "shouldn't we make sure that replacement objects
> > used when the resulting history is in use are backed by objects
> > reachable from them?" issue separately.

Yeah, I was wondering whether we shouldn't verify both original and
replacement object. Previously we checked the latter, now we check the
former. But is either of those variants the correct thing to do?

> I have not fully thought this through yet, but I'm happy
> to follow up with further strengthening if there's a gap here.
> 
> My preliminary thinking is that since replacements are
> implemented as regular refs (refs/replace/OLD -> NEW),
> their reachable objects should already be covered by
> ordinary connectivity checks when those refs are fetched
> or pushed.

That's fair, I guess. The question though is whether we can rely on that
property when the replace ref was already written locally. But I'm not
sure that we even _should_ care about that. It's arguably the
responsibility of the user that wrote the replace ref to make sure that
the new object is valid. And in the context of the connectivity check
done as part of a push we always assume that existing refs are fully
connected anyway.

So overall I'm aligned with this change.

Patrick
