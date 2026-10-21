Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792569610;
	b=yF+JuXqwJ+DSRyO5QaeNW9xq5Bo5KXktqEKGwPSsPCI5jjSCmr2Neeqmk/QYTrc89ovl
	 hKMS3du+XiIv+AHvi4ntVKdio7uXlfia4v1EslFN5ZnboUL83fUt7Z09SnzJJn0ORswMQ
	 ts5jFx/m3VHvO/1YWCsMmtDJEi/bxHxH4W5Os8mjXWg3KD7OG3a0X0YjH1gzVbeJbrmzi
	 DDcXx8sy1BnCgcHfHdFDWd4PSgFX/coqrc4ACsdH08YBPQgwLscxhDIZOJoajmlN3cYms
	 mwhcYjsKN+2RcbfYA3ycNqk9+95A+uYZtA5fzJvVxRwIp9x5YKpAq0oMj5jP+KbhiyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792569610;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=WzG/TUhf3qqOu7UICQb95KkRJsC7uay75b133WBgWTw=;
	b=kpnr4m9dWcEau0Q6/lNfgd+d/kAfLWUO4OBRhWAghvLqWA76vumQvx1w8w6w5AmwtBwC
	 DqOqFRJvB9GLIYayKO+tUmA8q89zvDfRk+kO+ztOBJRjKt0Fnw+U7UlecJ9+8ZYPOfoVW
	 BWRVcex5I7nfVK864cObuzcXhFcZu6ZZxzCmyRzzGgzWaNqjVXYULzjEBcUNocM2arOKc
	 IEjyFnVSnYvhHk2izMvjiIpliq7wuIY4wt886V3Xxr86MSTbuUhytTSE+bVm0XncdvzPS
	 lOOSL1bJT1C9Lei/M7eP9PZWRbRKOziZNzfbeMTuFkgTelh6BcQrploKjFO7V50TFzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=LnCb0klU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=doXTRBde;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87007606A31C
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 08:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87007606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=LnCb0klU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=doXTRBde
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id AAE7B1D00110
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 04:00:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 21 Oct 2026 04:00:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1792569608; x=1792656008; bh=WzG/TUhf3q
	qOu7UICQb95KkRJsC7uay75b133WBgWTw=; b=LnCb0klUmdnqN83aGow7vwYypA
	KoEXE8+YwyhZMEt/WrChZfw6SE13QTxH/kbLOts9zhaMKO9h3OXHcMHantraTk5G
	TLcNUk+HeF/ITBy2uLUUYoeRKGY3nlkJqBjGYUyrlMXDtP+TDK9doCAMjkQp091g
	Vn/FEXlplzy/OtbyMPW5NfoIzp0sa5ri1hRh7QGFafn7i5yDHbrjhOEp3MTYMPgP
	K3baV/q+tYHmD0OOlbWpoC7JeI+28ablrnjmMqaCJmijs9jS7cWhXC6qH1J4B10X
	0BzwzG3LvFFT6Iyb3kODMdRU0NQAcaXUZj7x1dS0AGzZyotF1o5YKaaHlfMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792569608; x=1792656008; bh=WzG/TUhf3qqOu7UICQb95KkRJsC7uay75b1
	33WBgWTw=; b=doXTRBdepVSjBuPaa4uvCx6f11b0mEuybFaAzzo6BH/PH8+fQgu
	yVuD0DuJ+36nwT0SjkyJxe7oRjKLCHZxDPLGCam1zHevenWwQqYkNKv/raXMKRSh
	qJvyEq3L4CEk2bOy4jJFtGdzSGKHavG6OGMwNPIt7mVud6NHhm4zZjF1X+lNKnOE
	wviR4MtwFTYSjZZOTEwsrDKK2hlZ37UKCoW4DXtZuZvpbCUovNCZumCh7zPmVsGu
	QqTjJ823pUK8jHJfmUNrCKt/W6SNkaR/jjr3/IQn6hr7DSdO1oqqFiFApfYmxKR6
	gKrTmWnoZWB3pERqPbxQda6k61N2NstjTMw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792569608; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Sboap8AqXF5TZfTHokgJJCZbK7JonvO4QYHttSKHo5895ba
	Pk69sAs/4q8nevVMAhhH5QycrakAb2m9BlOklT2sY/3r2ZZJUhKG7nug7xsC/X2N
	ry8jeptiHvbUMxlg1lJ0NiiV8falc4d5645ZZqB8uN1olF92pxxBF9Uar7mPNNgK
	gOjQVN3luLngIIeToAf2oeUD2rxx6OCVelf0Bp34SGxrME0oH3SdOtLmi5Ubb0Oe
	pPMq3UIEft/uTEvjcFB/218EinKUya2Fvl/wmNc7nJF1OZJQd/bYVPF3U8Rb459j
	syr8zMQOjsOx7yUGU77q4NBpe8VtXOxmcWC5M7A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:N5XYFGVhZhUUcliDqnbIXpPyCsy7DBffSgFySJvaUpY=:WzG/TUhf3qqOu7UICQb95KkRJsC7uay75b133WBgWTw=;
X-ME-Sender: <xms:CHHYajV5elVgFL0SsWXjNnwH6dOXProPyil2Wy2oTVOFJN9W3eEVAg>
    <xme:CHHYavR6WBgR0K3p7w0mEsKHgWw-QAHZyuz9GYH4CFYTrCQQ4MznwWeIn8qO4py30
    sbRXo5yRq4vg7ZSVLEYSPdwuQmrchpsD4btSBRw84kl2xpzEz3pU2I>
X-ME-Received: <xmr:CHHYapPs1hX9Tag30tXc-u8a0QqfZV3gzPowjyYCqlK-Ly_JYzEuvw>
X-ME-Proxy-Cause: dmFkZTFfQgUndaswgKJxgB8s/UbcR2uPoIc/2BvTEq+IDRoAEdugbaFraYyQ1mgrZzP1PX
    wRi+CY38vDBZIz0y4lCNoxSCHe4TP0RiBjJU6fDj/s/BdTj6bDqfzVmHFUafOmxLBY6TS6
    zo0lh1OXCcTsPAi+cQtUuw1JfADmKImCZcztOgjyHLWpGIF2cXoZPol+uYXkd5M573vLCM
    zwJXjtZqNk9HHgu+apxshug8BiujfrBEgWMsI8nK2xDKIUBmjJq+FXqm1Iv5JFBqqs4sGj
    rmvJj5nn/CVbz9I5TLPmlfnvc4obHXGwZWYpOaKxsjGp1H9sdRbov4y9UVuitVriSyfuJo
    tkB2V/GYnwdTCn3cIpPs17tJA8ysAzuKBS3vH6on4xelo7Hnl24VCvDmruODE77rfW7t0f
    ev0uyTNwCQzNooyRmiHv6C3tjHdcS/CY/Gk9hT0B1nAFx3MR1z28Jmyah625A38ZFXn4NI
    UI12pVG5PWiBe1DIY2Btdym1ROUNRjS847UJw89LzDBwGBij6nRvmlG56Mrch5rrMTX0G0
    wR2n3sDFa6IxixwRytdN0hUcTBjPPQaNt8jH4tpU1LkSCSCzgOHyqs9ZbneF42aUcikB60
    2NzuCPMrYQof3ToJRo170ePXt847TRc3HMlOmBrDCPHAb9lJmi9xPbNC2y5Q
X-ME-Proxy: <xmx:CHHYalQ8gNoS9sSab-4fYYK2zF2CFYsMrkBMfnxZ50Dsmrae1lup7g>
    <xmx:CHHYavj2shpWvRuFcxoV6YSGlkzSoT9oKHm2Zw1b1CHWeR5SxmwdPQ>
    <xmx:CHHYam8W5nNbX0Jhl-1RE4ZtLxxP3OLsc7iOyj9LcndbaYq36Btouw>
    <xmx:CHHYauG9ew8z7qKGFkMUVzOvBZFtiEseF2L9HP_9jIxm26HWJ5Wv1Q>
    <xmx:CHHYaojeLTq2hYSa531eYvIF6vEAOqbB36_BDMgJRiojbCzg7VQYtWuo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 04:00:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id df594128 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 08:00:06 +0000 (UTC)
Date: Wed, 21 Oct 2026 10:00:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Cynthia Uche <herroyalpriestess@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	usmanakinyemi202@gmail.com, siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [Outreachy PATCH] t2104: avoid suppressing git's exit code
Message-ID: <athxA6S50czDEUYj@pks.im>
References: <20261021033723.5265-1-herroyalpriestess@gmail.com>
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
In-Reply-To: <20261021033723.5265-1-herroyalpriestess@gmail.com>

On Wed, Oct 21, 2026 at 04:37:23AM +0100, Cynthia Uche wrote:
> The exit code of the upstream command in a pipeline is lost, so a
> crash in 'git ls-files' would go unnoticed. Write the output to a
> file and compare that instead.

Makes sense, and the patch looks obviously good to me, too. Thanks!

Patrick
