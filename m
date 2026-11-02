Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612507;
	b=35JptReEimlEOYV//fpgfb5T5ygJIBxod51Th8AyVbIKj+b2qliYW0G5u01IHdszdK4u
	 9eV3A2xRAwE99FiOr2HN3bFQvh0jtyS4QyPiiNrwj5FZsM7bOlS0PMmiubs1H+45VexQB
	 7Dqg5btjemsZrk7T2OtIbnfLJrThHZB0VI3CUINqw0dwvPmolu5YKW87WlhybrCTLQWUg
	 twHLsc/OsKsZgTP98skd7QJ2mFcJ3nPU+UuAL0UxShNnKUwh1MkCQMM2/QwJoQviMVAGD
	 ksYlh8V1pNcU1CgENWQL/stL040PpCd3WCS27eVZ4B89iXqAIUbLVi6v9llrpmgT6xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612507;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=hTmPFpOwSrZv13nRhm2TWE/icYBC6ga8oxihIYT5j/c=;
	b=G591Qd6qxi0kktgd50ucaIzwYo2HoTnps3y+G/N8pWyActqsI02FR5+ZOImHztylrjzS
	 GvZOWrUWbBYjZXNeQqVF8zvWTNv5mV1oI9JzCp1cji0dtTzFVITobwQobsfBGJa/sMjHW
	 8ovl2Mcw+nEtc9vIF3xfKlhKdLMLY/dLEoq4k7f7ZysE6gmUEk7NgwKYT6dAd/ei2fdYn
	 iKbUXDoSavG99TIJm/5A6rAEckOo5UCsRz7TRxangOuLaa9kwFNUnkaRjt3aLtr3Fd2YL
	 HfN1MAuYV93cUaFet51koSjhLVl1xJY68Lb+7z5j061tErmWO4+0hYXTpWCmz9sD4Qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=mciXab5U;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EVvki9Ch;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA29A606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 09:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA29A606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=mciXab5U;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=EVvki9Ch
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 32E3B7A0121
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 04:41:46 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 02 Nov 2026 04:41:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793612505; x=1793698905; bh=hTmPFpOwSr
	Zv13nRhm2TWE/icYBC6ga8oxihIYT5j/c=; b=mciXab5UOV162armGVvSJbZLw9
	0aZ3/glxn8bvOopqT8+FEKRBKfKN3Pjol5DpR0Oi6kSYho25OLndmtwryEnBndN6
	T0ZY+1hKp80d29He1Dg7HMvULPTjuRWLkaYKNUF6Tqm6LwvRBAipHoQP41GmspWs
	cTs6Q/oHryUxIYRiweMmC+5sa5bI8jstym4e5ruIF0JzsBviwHJwNDcCD2if6riU
	gFI+JTVbFv0tr/DiyfSUGzjrgXCJJ3vczHK6DL/cp5ILGiHWGmyRl62JlvYc9Tp8
	M4tA/nAV0zIdrgIsYPoE0wALIDbTQgUP47wHXfADiXM8cFKutnCP4+J70TaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793612505; x=1793698905; bh=hTmPFpOwSrZv13nRhm2TWE/icYBC6ga8oxi
	hIYT5j/c=; b=EVvki9Ch2VDBBtVFv+OcBYmwy9hnpr+adEcNBn8YsZl9ud3J2EN
	sAEJ5eQJkb5eDfnyQMY/m/nT//dQao4sUssZRlUITA8ybhlO/9+bfojFryNPdcOT
	CZwjHK+L2gJkjiW8Wu2W6pGw8g01BgmvpXWaWAESUV1fM1R8jaiNwegsEBnAHSRL
	/Au+TVBMGlwlLabybcFr7yxS4IWSUi14QrXYHyFSLXGg3euFIzR2ewFake4eeY1d
	4B4SSeRgB66dVrzf8CqzBMyrqlfh/McQ5ZpNuFpKLi6Q0mOlJr7hTD+73WBRLU/Z
	s/p8SR72UHkNRw238Gxt9+nmsr05wFiUr/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793612505; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:akTY4/vuojXN6vGgJFBvdoT9IN9/Wq3bBLy9rX2nb3K0P46
	9LOP+V50XdMyeEl4ypJvyeX1JW7IcLp81BbDywQXbUu8kqmeJCpMi0ZozuR1igw+
	Fmac2AAABP3JRIrfy/nymsgGoOpL0p4ScuNztHAxIlHi1QpMpk7HrmlDTjkticoe
	7TaHZLDiPD7KcSTpr5MXRbK+IY7jUyZXun21k499dAWhuRY6Hojj/1o0sxfkS8XQ
	hf8pEkjMv7SYmLeiOk5BZlG4WnWhg5IlH27FrceVpq7OsnIDTcwBpp4xHoAgRnom
	kSBcfvc7iDb2+Y5E4/tnUT1X+FI54KgcYpfAVWA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:U/GQboqHmt8WJB7Muhx5ezUuwTXvDMIe+dlB9PWM3TY=:CyM00pNQRlUKWt1nGLtCI16dgXAziRjtzXDYVXyXBVM=;
X-ME-Sender: <xms:2FroahSupUbws9q2f4K2RFj7uZIrJd9xkkVFgkZaJLoin9zeDt60WA>
    <xme:2FroatAaL8CCuRq8zbwh7pvni8ldbtzVYE_PXGKiGyJqiW-WEXH4pbQKzdnLhFoEd
    VvBvmx6MJh9P7HdejuEcTcTsu5n6UPUBCGxXRIKO6d960EX8oUu9g0>
X-ME-Received: <xmr:2FroapEmKSkNNbHP2qyWHG3JsOp7g5xEM34BvguS237ZaxwhN24_2048x64SB0BiECmF4A>
X-ME-Proxy-Cause: dmFkZTEoNnPL8fA9CEw2p9vLjXPveWZy9OVIlxXmfVNdbHucftL58HO8qtWbiw90ykcxIv
    hta9AMOi9D7Zkp23L4RgdvuHDH6SBKtPYYqSIRBVjF2EEP9kEDSGOyiWLP21KFTH2a0RBL
    NXDhCbYTW2d2Vk4jhe/j67eYBBdMrdZfbltMPvOl07LGisx6rxXXx8DhrrW19SD00SoP8Z
    B0CsJvq+e6OYTEFIama+sVqaYopf60NUfDqfYWHteGMeyvZhalCM+uwjeegAd1QB9uEPBk
    QiKuP+DJr+imhgmiHkE7O+KgqjppVbVfbAvF/gmDuj0Gx1kt/nBgwycTLb8QjAOEloO9RK
    oHbBl2QcwFJEWQFrttCyGYTChS/psxo0Pdc+nTnQmk73MYWaoIs8qjVFjd+a34+USrv1ZM
    tzmk1ieWxE+nU899iye6Qb9eLhnjQvgYx/zsDKxMnLQipX5ZZYFhlBCvrt13GoGqZ3pMDm
    wr8AQ8s0516fstn9znGtGDdrKto3ZhZ3x0HHBw+KztL8qUzLU51MqNE5xuAAhPzloyrQe2
    1A0Jr0fMgKkSgwTlSlLRpkuaPFDm8Pu2+b9vdkmVre3+U+Z7emMD5XdgYkuMob3voOIOc5
    bwJewUa+vhPfP7j489iAr1ezyQXlb0D2NS8po/nsp4QDEbGBsgdvCxgI/tiA
X-ME-Proxy: <xmx:2FroavAfh1kRJPAkOR9It5FyVY4UkxsZtdGgQsT3Du1MUkMwb4Yncg>
    <xmx:2FroapUNL14w8YaCBjE0438xZHNBYusUW5loAOa0VkmaQjvt6YZ3cA>
    <xmx:2FroajoG5m3LBA5xaNucGNNDFIWP8oywbcPWSfFsYqQku0_4dFt-ww>
    <xmx:2FroalQe2_EjFckJ9jJFljfPcwII-3fSUm9TlsknLpAQ94eh5RVcZw>
    <xmx:2VroamXntNduRHjasnB3-wEfyeSNj5WF5F0u1P8JijmQ-cCtmlpVXjJJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 04:41:43 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ecaf3202 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Nov 2026 09:41:40 +0000 (UTC)
Date: Mon, 2 Nov 2026 10:41:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Emily Shaffer <nasamuffin@google.com>, Tuomas Ahola <taahol@utu.fi>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <auha0Ze6xksBXaVx@pks.im>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
 <20261026011731.GA3575069@coredump.intra.peff.net>
 <at8IBMQZtJP3bQ9-@pks.im>
 <CAJoAoZnqzKv8ocsi1a-nC6LaRnpKKCO0Bxt-Pdn0dDUziEcpAg@mail.gmail.com>
 <20261030180016.GA7582@coredump.intra.peff.net>
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
In-Reply-To: <20261030180016.GA7582@coredump.intra.peff.net>

On Fri, Oct 30, 2026 at 02:00:16PM -0400, Jeff King wrote:
> The "X commits and active in the last Y years" one covers you, I think,
> but probably excludes Linus (depending on the exact parameters).
> 
> At some point, though, I think there are are always going to be weird
> exceptions and it is going to be hard to come up with an algorithmic
> rule to get the right set. Perhaps there needs to be some human input
> ("we all agree this person is an important part of the community, even
> though they do not technically meet the metrics"). If the metric gets us
> 99% of the way there, then that keeps the human scaling part down.

One counterargument though: is it really that unexpected to eventually
exclude people from the voting process if they haven't been active in a
long time? I think that the ability to cast an _informed_ vote will
quite often require context on how that certain topic has been impacting
the community. And sure, a person that hasn't been active in a decade
can of course try to discover that context before casting the vote, but
that only goes so far.

> Of course that opens the can of worms of: how does the human part work.
> Which humans? IMHO I would be comfortable with Junio or the PLC just
> saying "these people also get a vote" (with probably a big initial list,
> and then periodic updates).

If we do that it needs to be fully transparent though: who has been
added to the list by whom and what is the specific reasoning behind it.
But as long as we have that and as long as it's made public well ahead
of time so that it can be discussed (and challenged, if needed) I'm fine
with such a process.

Patrick
