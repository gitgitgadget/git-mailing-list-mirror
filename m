Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5953AFB11
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 13:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782136424; cv=none; b=opMdgIa+5Subnsxh9mBo9OCcnjcqQufbYEv5vdyFdlap5QxXeSSAfmt0eUKSaDj1YpI05bfxFN2gQ/Dde+oNs32fFFLF7eGgBEXxB/QB28KjAQJVkxAxMnM6Rse22tVsx0rqmp0maK0KWw3SIScm1CR5T9/iMyk9Cb2ZfUvNIwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782136424; c=relaxed/simple;
	bh=6uu2qT1C682q0AKyWejrFevvLJpZw2GXimr26RSP9UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYXxkaRYTdw7hAWC8SWx3Pdtf+Tbtz07c4HxqIFOPBgVCOYvCqiSCvQBXtTAUSxKIWJkyABQondLBuO34pBtznw+7qNJEbY7Jab/xzXBLiPswa9m20byw0Nak0ydjw0U5BsAAr/o34WYnRBxsRrQJamUGV0BUZ0w6pCUYxN92Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YkAa6BNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WNGmRvxc; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YkAa6BNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WNGmRvxc"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 08535EC003C;
	Mon, 22 Jun 2026 09:53:43 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 22 Jun 2026 09:53:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782136423; x=1782222823; bh=WCPBk4Mv2s
	YNUz88bbBq6jyR6IVQP+Bq3aDXpyVGDPw=; b=YkAa6BNFgjVgxx0Ow9vYnoRJ49
	UwrWyvDyoOwfxKrw4l66LNtZM5Pwqx/Zb0hPLMcMbQQab7oGeGtkbbBaH814O/a4
	k1vzxatXPhdEBAN4oiNyCt5VuzAL8RvQqoYq423PuYZu5etwBdmTqqpqZUAdfzSO
	ZtDy95td0ZLJ+tKWkvQobzH40EP47iZw4BUUh4XnuebRXW2wMrwO42meVWAgefjv
	Kz0/U0Sx+jJ+iWeNPHS6F4Db/4WtF3TMhXnAlcvpXi8MFe9Q+z3eKb34+OU0Z0h6
	JqIZQDiP8vm5fW9F/SCS3xZNSN2BcPCtdJ7qeyOH0qXxATkm9zWiV47VWQRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782136423; x=1782222823; bh=WCPBk4Mv2sYNUz88bbBq6jyR6IVQP+Bq3aD
	XpyVGDPw=; b=WNGmRvxcorkpOBn23e2U2aRkl+Bw5B76uIzPczSow9jAFBL5ZAq
	dkPeYUI7n8VrwWnH7OwVF3oRjfGOt5p6thEyPr2cur/eR1j8aiPs2W7ckyix3qUH
	ptulemRtxUQzvaHR9auKOkIc4KIGZJTxrhBBi48gf/xITjgkDWXliWpttqj0aSJh
	f0joXpJ4ch/GXLnlotZ93JAAD8VvidaPoKWBRDMcrP68IERez+6ohIvMe/jhqGDF
	e3Dt44e2IS1HZk+SH9bLkgemzW7AeWl2WADNybnybDBd5N8ddPN0NkF0UIJSVAv1
	dhsct4K9aJwEGErCJZ3OZnXm+9q+ChJ6ctQ==
X-ME-Sender: <xms:Zj45asiELvMj7VtXxnjuYigeLn3_3oQkJfK1P7ckhpdWEpOuqjzwmg>
    <xme:Zj45ascwTOCvlE4mfFHTReGR0YCEMglYKyJvRuaQphk80U2vTAKyZj9LQT__SaG4B
    vrWDJ2iBlPivVoRJdTbPapLWmi-Gka3TEzdSE7kLnRMSRKwDUHyDgQ>
X-ME-Received: <xmr:Zj45aheXNbIsVha9OvcUFQCMqZJuqEe98uuPOwqxibFwgc4hgNFabj0p73UontYzF8r_2qbBn1I-bPZvFAgVnX-CSTXLf560nB1Hj8oPWQ>
X-ME-Proxy-Cause: dmFkZTFP9G7rdRNbZW9L/nQfLB8/CQQSJ3r9QGTpBNdXtr+vnVFoiP0HQQ77zN9Q1U8/G5
    1y+EMsZ8tUJ2kAAGBgWnysuE6Llfp55Q9fZDx+3JP+NXf95aMhjH2usWXW84skxsAxjdPJ
    tOJI5n/5JTr6Iy8LxIShuom85vAfPmqwpYsth2iDyz14gQ2XYjKeVM9HdiEQXDxl/Ly4Xt
    FohK1Kt8osB504VDnavu9kd+LSpRBwLVqJq+Vc+osQZv0yrTQwtEljvIE/jc0pjOpUOOtF
    Pd5Yt5KlWy5H3LD/AIoBd+wzxXLaebqof0bUNnHxGh8cJl2RLroO1vEMJn1AzletxPn4Xu
    PN/V4D7ra6eBkMZm2OXEQOz9k8pkprs+5DGpvQ9kFfjh/CEcvOk/A4lmhuq19+cNjE5t48
    1bJVu/HOvGM+ewQDnSRts1wmLo0UfFpioSXWac2SZaDP8ZKKCh05a0caI/RjGhf3Du0LYs
    cr4gpKxustxp7MSuS6EWFnxl+xSGRvQNLYEDfysmMlrZvhxXNh/5pH703Bp/USVb3dr2hS
    Qvmg7sqi1aVBuCTSBeQSzUEsyblSz0mkftvsUimTZkJ2HluPh7yQPtNFjdabKPPU/JFl4x
    SABDzBQvt4zpRpmR/yl+ASTY+eVh+y6bfklgZLhe+3S8j3r/Y2OVBv2bzQ0g
X-ME-Proxy: <xmx:Zj45am-CjiodSddrkAX-mfAW7YTalL1Cln__q3vplpTj6sb45Dy1OA>
    <xmx:Zj45atm-khKIcUq7p0LAGCFfyL6m7lT7tY9IKt8uqNrXF0cg8pwNVw>
    <xmx:Zj45ao-5j-jwWvXDWLF4HcLbaTJmFmVOpfep2TCNtEK89ccQ5KjV_g>
    <xmx:Zj45armFj6VeA5qAzV0Nt7xXkQbND19uRpeSewiP2wQ7-o4yCyABZw>
    <xmx:Zz45asf5LJ4NNYvb15xxK_hpYvV6nH1NKZWcmpG5x5WOV85sLoMjHAKl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 09:53:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 865dfe99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 13:53:40 +0000 (UTC)
Date: Mon, 22 Jun 2026 15:53:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 1/3] replay: refactor enum replay_mode into a bool
Message-ID: <ajk-YQxLWfspNWIm@pks.im>
References: <20260622-toon-git-replay-drop-merges-v4-0-ff257f534319@iotcl.com>
 <20260622-toon-git-replay-drop-merges-v4-1-ff257f534319@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622-toon-git-replay-drop-merges-v4-1-ff257f534319@iotcl.com>

On Mon, Jun 22, 2026 at 02:41:55PM +0200, Toon Claes wrote:
> In 2760ee4983 (replay: add --revert mode to reverse commit changes,
> 2026-03-26) the enum `replay_mode` was introduced. This has two possible
> values:
> 
>  - The value `REPLAY_MODE_REVERT` is used when option `--revert` is
>    passed to git-replay(1). When using this value the commits are
>    processed in reverse order and the inverse of the changes are
>    applied.
> 
>  - The value `REPLAY_MODE_PICK` is used when either option `--onto` or
>    `--advance` is used. In both cases the commits are processed in
>    normal order, and the changes are applied as-is.
> 
> Since there are only two possible values of this enum, simplify the code
> by converting the enum into a bool. This avoids adding code paths that
> check for invalid values of the enum, and shortens code where the value
> is checked with a ternary operator.

That's fair, and the result is easier to write. But is it really easier
to read? And what if we ever have to create a third mode going forward?

I'm generally no fan of booleans as parameters as they basically give
you no information at all at the callsite, except if you're lucky and
you already have an aptly-named variable available that you can pass.
Which seems to be the case here, but I'm still not sure whether this
change really improves the code.

Patrick
