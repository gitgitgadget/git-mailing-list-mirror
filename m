Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082972;
	b=O/wgqLSWOGl+q8w8XJTkYYjyQB5HPVUXNKChmspG8jI6or9a97RNA+vZLdXny5NdERu4
	 PywY5UmfE54s2oLPhtHZGS1ZrttAzyNEJNIocoXrjJvSZbP9LCVFem0f4UKfZPWD73p8C
	 YpiUaJtEDWMQv1/oV7v4E4vNFb3u82WjPB1xz1jPbb8emtYntyhIqkxSAC1UcA+YJ1pea
	 UZjzmLr3a5sZdfbqO29AGOgXHGuuxlhrxMivHUBiAfkavNAN3FKXvp+Kp+ocDOSW1zTg5
	 o16mhQFETznquzo+kXi6CEMo4Ui7HMXj6dWNfAdkL1S97mCWglFvq4UGTOHf5+Eiskg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082972;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ck54xLs5HlZWtgmM7J5LC3nFErFZb6X8Rhin/NWL+6s=;
	b=HeTrmDlBOEwg0EBQyIBRFeYszBdHdNvaDdIW0p8c+pEy+EVdudQGkwLnCEoBEIe9Jhag
	 U5wEc1EfWs/0oV0lC7Py1Pc5R23vBLXDqCkLGhKnRsMx8CE6n14Kolvg/rGwfEC3xZruD
	 BzQb9sqfyTXe+LKo9rA1LRmVTfkJupqCqrK4VmOSPokt4UnCjGVnJJdWjrqTSt/yxGJFQ
	 j7Y7Lempr/5ezFhUjBqGxcRUsD133ULhkvX0SesFt3ZJoAAEZHK1emDDRu1T5J2wWVR/U
	 oik6GDjQjoh9rJ2mdqaqydI5Y8WFSGnk57YeS/sC5mfOWtUY/rlBsn06fO4FHyLABIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CYyVYP+f;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=t+ZDEPLT;
	arc=none smtp.remote-ip=103.168.172.149
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75B5606A325
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 10:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C75B5606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CYyVYP+f;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=t+ZDEPLT
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EF2B3EC05A1
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:09:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Nov 2026 05:09:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1795082970; x=1795169370; bh=ck54xLs5Hl
	ZWtgmM7J5LC3nFErFZb6X8Rhin/NWL+6s=; b=CYyVYP+f6J8D4csLrScYXofxyH
	Ag5G1fWo7DaCNLDRxsRrYLIc60bIkbAqB9sv84m1mQt10WOXtVOJJ0wP+cC6+kCP
	vc4qhBK+ql/kJReI2xI7dCdSPOkniiPL6/MJzNOT8ge0in26KR0fmUoJHq50a9FV
	0gXbS80tInDJMQEF065xBJNNDGnx1Of5+vCwqPn6fWOtW2Ccou91nHYn6vWcu5GV
	YziBdq7eVW8zDtchLCisxik7/dVPIsxYlJo/Q5vsqJvFWBaGMF3ziFH/nB0jVfwm
	S9NDk7b/D+S943cqBcAvVEQBNw9w384CbzGtxYO84DGOrWanWy1V5WOTCD4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795082970; x=1795169370; bh=ck54xLs5HlZWtgmM7J5LC3nFErFZb6X8Rhi
	n/NWL+6s=; b=t+ZDEPLT2gWmj4Tl0GWXYQ+p2w/nIVz0gTgviSwA+TjF9N3hlG5
	FZeeOZjniYnuQyeBNdlJBhAgD0ASbvq46mFY2XknP+C4ETaUfWM+AC2Mb7JO8vEK
	mMRxYFa/wj/bwvRWIjIAG9dwOXZpv6IkyYCjhZ6SvO+xtCXKhwXx3VVA6M0eDduA
	nCp/ucKRFB5ZJJjJcGze7G31wzqOvIJQ9CAZiE4821+EAfQv31N1LoXwzgZKp/bO
	S317TB+9uehOQY/9wuIS8Xgkoa/oBw+feKEFbqNXgUTvEDrqOtgFrLmw6MlghBF6
	WDBXLjpfW3ihsGpkZxF1+Zqqf1A9DzCTLlg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795082970; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:f+fx7XQSBaypztHgZkLFsDruf1mBLhYMX6AVyKzphobVBYN
	HcvbIj2eg4JntApsJxF2mMDYhh7ht4k5KjfULopt6Hefz8DuPDQVkxbnzkCs/dHB
	g79rJXqOlMPbciOYEiCw2dlr1zU1KQ3P/D8St/iFQxflnV6yYUSqVEmQgqBxA5rP
	husIW0QWCTBbuCKItQ+MSnVzm7B1TnGe1TSiLFOBLMEpxzkV/J01LCYHB8CPy/Qd
	GwXFPMEKwZOmt5sjwmgaO+ffMavvzFZ5i2jVYdx2MEi8V2i7uyVEmkMYiV8f4QuC
	xTAiUmFLedM9nQ/Cihpc8Psa2mZQY3M72LYkjCQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:Rx1FPZt8v7jiNG3c1McR7pYcv0UucB9KP/7BuWeX0Zg=:R0jgx1KVqpckjodjB27yMN+ILUSCIyTVksJ5zgqQXkM=;
X-ME-Sender: <xms:2sr-apT0cyfZ-Ph4F5ZQzayQsKJBdCURe5ZtPNlZ3N4xI_O8lLS9Iw>
    <xme:2sr-ah0W9VhHYiqpx5ln-scTKJbLMnuwO-t9PlQ71dmiiuquUcS-a6K-P_3RChZ1O
    _8E_mRBhZCz7by1BTuOHLk_3g0q64yS6qSXwcGshnE1VEz9UPFciQ>
X-ME-Received: <xmr:2sr-alA2gS74yHx1EJX5UFa399RndRf6CQ14f-HDGYIuNXkeDvkiSHoGBZG09cMcbZ6Gjso>
X-ME-Proxy-Cause: dmFkZTECyeg1aWG7hrj0fCMNc8UDPOKzhyaLoCRfwNP3zaEvaYdhwD6/HfMyHp4C3FVlPp
    lnTV9aBajPfZk4yjQLeXJ5NyDQMh/QKZoegir0uXvHhrKB0WgCA9KwNwM1r90uxKKNsx6w
    q8dqOIO3afhS3HFKfE1huX2NTWNnhMIR4zww624l1pgQie+sGu3DJAPtONpCdmlJK3f3a9
    2qFRcSZbagzinmhkR5sQjzipC0iOPLVfwsgqG1R3n6ZHq0lnDpSmiVmDoC7+r74NNxzqRL
    mDaoMSvLwAw5Qpky8uFadR0DPeFKOU1dV3Uzk2XzqPsrFfFS90cwYg0i1WmFuAyJFHc5qG
    37237bc0qI5VQG9GYzwt1rtxLTuUnV9wJhcxz4WySCNXKEceUELtT78gw8rGDwAvE9eThh
    zKhFezRRa6WjYqGSpqLoEcyPT46bpF7QZDPR57lspVnZTcIUPo9X7nnxQ4aqF7FzGX22Ms
    jqyKnkssiIYhDvY4b9h4Q7nLVmzowEjXMx8fUEEDuAdMzGoSu2NQD/3D7vVfmeX/MVJx23
    RZ1g8PW0zhmqf60Xf+Kv39pa901kTe+0xWolMEp0FUwZA5KzoKa9kaWyuDJz0ppT6HLs3d
    xslrfh0rjCWXjQ/wUjNi2tvFxldAF8Sl1eOzgPI09pMIjrNqeAbVYAmnuilw
X-ME-Proxy: <xmx:2sr-atgdecotFcu5HNq81Sh6nUoKu8MfqCK067Ib56627PTIEUDnjw>
    <xmx:2sr-anNTwAEM8kwq27_t9nejYIUkkr-BqEMhP74XIuJ1_t5ohurLYg>
    <xmx:2sr-at_XmBIW9mX3Ggkj1KeoJb_SF7MCU5NzK2o438yrqgtaGs7pqw>
    <xmx:2sr-aoeUXSPRrfM4exslkN2hk4WVbGQDA9kKxE3KDxDof4Y2rJk9lA>
    <xmx:2sr-atn8zFWyn4Q7lu9yeUTtcZ7mwLpBhGJKwNtSCxIcFkZzXY8C3gGv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Nov 2026 05:09:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 69134242 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Nov 2026 10:09:27 +0000 (UTC)
Date: Thu, 19 Nov 2026 11:09:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Kristofer Karlsson <krka@spotify.com>,
	Han Xin <hanxin.hx@alibaba-inc.com>,
	Han Xin <chiyutianyi@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/4] unpack-objects: use size_t for object sizes
Message-ID: <av7K08K9MIQyxRTW@pks.im>
References: <cover.1793446357.git.gitter.spiros@gmail.com>
 <cover.1794984184.git.gitter.spiros@gmail.com>
 <b2c3d349a4ac73da7e1d066ac43754d3e6939b9f.1794984184.git.gitter.spiros@gmail.com>
 <av2pBh7vLj5DVDha@pks.im>
 <xmqqwlqa6poo.fsf@gitster.g>
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
In-Reply-To: <xmqqwlqa6poo.fsf@gitster.g>

On Wed, Nov 18, 2026 at 08:59:35AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > What's worth documenting is the unexpected parts in your patch, and
> > things that may not be immediately obvious to a reviewer. But you also
> > document what specifically you are doing to what function, and that's
> > quite obvious from the diff itself. So overall I bet that this message
> > could be condensed to half or even a third of its size without losing
> > much information.
> 
> Good observation and matches my impression on recent proposed log
> messages I see on the list, not limited to this author but by
> others.  Perhaps people should paste their text to their nearby
> faviourite LLM and ask it to condense it down by 70% without losing
> substance, and notch it down if they feel the result lost too much,
> or something.

That assumes that it's their text in the first place, and in many cases
I'd say it's obvious that it is not. The offending texts really look too
similar for this to be sheer coincidence. So we can probably avoid one
roundtrip by telling the LLM to be concise in the first go already.

Patrick
