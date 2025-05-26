Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3622A1DF271
	for <git@vger.kernel.org>; Mon, 26 May 2025 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244242; cv=none; b=ors3jxLKgmO9e6Nq1CYyOky9aumvcZ9UMvlUkj5ypTpZ07u86ZjRmxkpu6Poe2lSV2Wc4LMnhg2RPCNJ7QSqG8F5NZ5x6u9WxjrpvOQa494LCSsd/gxa7j0gFxqI4Sw17L95mfy83K5D0mLpG1gzGE4eSeqZXCE6PupRj8NaxL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244242; c=relaxed/simple;
	bh=51TTmI596P8wzdUO5OW5G9RG2hNRETAZyOlwWw4Vwco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aKdxWIGu9KNsRxrqcGUwoi8AI4a3nbYmGS5Mm87KCevjfp3hkrzjuX+BSsDX4lBeU0B+vwernddOdLVREW9Pr3VX+6LMGSgytnKYSinCa5VtCA1f0QXri2ETaKLqVFLb1YDe04uooNKU/tP7Aqk0l+CzbssId3wSgb0cki4C8gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qAhC++Y4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=neYa7yJU; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qAhC++Y4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="neYa7yJU"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 705EA138044A;
	Mon, 26 May 2025 03:23:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 26 May 2025 03:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748244239; x=1748330639; bh=kx3NuW34YL
	Fv3IADGdf06sqHPPmDfyZxcRVltJF1N4Q=; b=qAhC++Y416goTsXPo0yY7Jnc88
	y38Hh4in3R5TTXpqwFcJYDzRHePJfif/d6UEKybf40875amnd4OyO+J485mEMxqo
	sLPSAw7XMPDQsQOY/G4dJNaC+LPFsh3B/RchO/FMQn6nAA5t2FnvuVfGJYCL8yNT
	5Nl6s3B7MhUUSa2Rh1bhhelNU/x2nabugSd42SnyMFwpoPyTd3hX67IWio5HHAVt
	AngH14pZBoS6F+koYJeMWDIeVQDsqmOUCg93/SgUwVLt+NsVaJYdAsIN8RdHtGMf
	zFRFjnXmGriaQSZEfThCil6TP37+G77wW0V88+/QEMlInsc5uQLL2PwOxAdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748244239; x=1748330639; bh=kx3NuW34YLFv3IADGdf06sqHPPmDfyZxcRV
	ltJF1N4Q=; b=neYa7yJUsYEwkU8BCAY08aAeH8q5wTdbRT+2wxBF/FxqCwazedw
	irpFA0b8bjuPCIWrVKWUkSPNHMBqBKwpT4SaLIOuDMdqqLdhihEKqNCUoAWl0721
	xODUf9vgDQGsP4uwnc0Bl3gdZPsrpxGFrvulvr7YxR2EXPBujshKjBgJ/LbhICdf
	gO0ZKG3Pu+/d6+y2gKWqGmxANkJVl5Asp40KRb6laXeq+KiSQ1b30rGlxhzJ1bC4
	sVf/misAPFf6SgJSdFzl8kd8og3n7uz43omZwG2ntApS4KQ6vKEY51eaUmVAEZS3
	/6lB/IbpdOf8TrD46Hp4/lv1BcLjr5JZRSw==
X-ME-Sender: <xms:Dxc0aJ84aPzW5qe3p9FIpcci-GE5gXCNlxEU7y4-utb79QqjENB_fw>
    <xme:Dxc0aNsRyXfg0VgwuwKzlYhAhAMc1ZjY7Djl6m6G9dsfsTYCt_MFRC_Co2knJT3Re
    weSvpEbSTX1HF8s-w>
X-ME-Received: <xmr:Dxc0aHC06_36D_YXX_m7CEiODaOOraBRl9P86QhQzGSTV9FQLiZ-kcEsOLQtmachf_iny44w1uD4sFE-7-LTB7s1_N0NyNcHufxQuANm1xqDLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieelvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    rfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrf
    grthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefh
    jedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtgho
    mhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Dxc0aNffm51WqP6cuTg_RTjHv1dZPcFJLnuJcZftGfkKJEMIxRK3Tg>
    <xmx:Dxc0aOM88S65-nmGZWAYey9JHKF361mHMnyLyyvf9fqU3fCkFSfOdQ>
    <xmx:Dxc0aPl6lTVPKoXKUsGIrhMQLUxpTIMv1-jpmLjWPdRuy4z0b1IwJQ>
    <xmx:Dxc0aIujStt1LdE14QTqV5mEXLkm9xG1eBEWToct1vacM8bydBBwfw>
    <xmx:Dxc0aC4BW3SfIbEhx82vxDQ4i37QtjMqxvbFo_h_stt7Ou4ivnxCDqNV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 03:23:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 27cd8a0c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 07:23:57 +0000 (UTC)
Date: Mon, 26 May 2025 09:23:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] midx-write.c: guard against incremental MIDXs in
 want_included_pack()
Message-ID: <aDQXDOelx3fc8W2n@pks.im>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <d2f9645aa15b58824531fe5d981d2a73372b9482.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2f9645aa15b58824531fe5d981d2a73372b9482.1748198489.git.me@ttaylorr.com>

On Sun, May 25, 2025 at 02:41:54PM -0400, Taylor Blau wrote:
[snip]
> So want_included_pack() is OK becuase it will never encounter a

s/becuase/because/

> situation where it has to chase backwards through the '->base_midx'
> pointer. But that is not immediately clear from reading the code, and is
> too fragile for my comfort. Make this more clear by adding an ASSERT()
> to the above effect.
> 
> Apply the same treatment to each of the fill_included_packs-related
> functions as well, since those are deceptively OK by the same reasoning.

Ok.

Patrick
