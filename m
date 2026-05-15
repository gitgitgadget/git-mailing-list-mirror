Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF83EB7FE
	for <git@vger.kernel.org>; Fri, 15 May 2026 07:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778830275; cv=none; b=kdO9JHMQht9Je3g0QcjC9ESufxsHSc1PbFfrmhSws8qLA2IB6pNYA2nLCt8CjN8EI2CVB7h/UPTZZ1fJRDYis+PYWRh7Ns4TKzVz7fULftc97iDwfsG+nUI7HPfgHlf1Mn+h3ruauooTv/meYUv1BZ2xoF8deco/mhGJGf7LM04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778830275; c=relaxed/simple;
	bh=p6wmnkxhHUAXZLlEKOeqWdcm3B66cPM/QNazx219ABA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aVgn6EkBkdWrSTVrw96KNNMIWDu+XwBWld4sOihSwqBwDoO6mCktRdjYuhJu+1atxC0tlmnHMrDezUz9RSyioVZ0Uk6nu1h7QmPYhx4r4gHak++6+wtr7intYuyk581JpkYibNYXu+/fUms9ZBDeUrrVdxD/byjsY2uoDIQysRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KXHp60lw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NOSY93tp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KXHp60lw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NOSY93tp"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 852581D000FE;
	Fri, 15 May 2026 03:31:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 15 May 2026 03:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1778830272; x=1778916672; bh=Q1/efjGv53
	44dTVLbeRYYB7M3B9RDsY9vvd4+GX5IoQ=; b=KXHp60lwp7cUqTi8/aYTpOfqdN
	pkyXas1qmNGhveB89eBE2Uo4RdlG9bXknUFMBafb0y7+9EYNLtxSVONEdTYdePwM
	nGE09i77XSp+QTXvTz4Yq7NGrdRbMoBz9aqOx5qSlXGks18FGbOcS/jMo8CIiZPV
	NG7yIvhlEX4bmqhMuOldi4X7wu77ALxvMLAq+X3+eeYuPC2INsDfdB7u9mvKRe7x
	0WvLdU2f1wa9D+ljuoVkmW/EDhMMa+09NmrbqAOhE/WudjP+V1i8faT1GU4yKUPb
	zUg99VyS66pxzv7ngZUwtvkADH1/oqMpez5omt3KLlx7p5J6oDOGsKLiXQrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1778830272; x=1778916672; bh=Q1/efjGv5344dTVLbeRYYB7M3B9RDsY9vvd
	4+GX5IoQ=; b=NOSY93tpvC0M9veuUE1DGt9R728PmW038U/QqCgrulT5hE9asHe
	Ye1KGpzYe2RKwRAf1K8O3fdT1kqut1XExnmAF0d4A/HvTzelJm8yGv30+Jn91ebJ
	d8GljEj7MwsIlCVWzkBpevm4RJJZeXJRtWOx6/uAkA4Rtff0dNAjbs6tf1z4EOs+
	MMADlh00rUJP3hniflphGNEt4xaS7chx5HVsjj4BRZWbC6LX21/m7rAMzd3+Jath
	+n+pP3RWuqCQU1Qpd5PtkdLAr92u/tSdHdwctivw00LBcoUV7A8FLwL3jYGU8gt6
	1qxf70QK0dlwOT0yRCQdYqsbzLmoNmGb96w==
X-ME-Sender: <xms:wMsGasnN6Wict6GbcZ_GpQGpU8AbG5hHayNhmQMRsSO5Z_nZkzikkw>
    <xme:wMsGai316SBtdFWGIJsiUrpSfckgvnQqasGKzAQpUdWQFEpKr3Zm10D7Ngpl0X1XZ
    o-cBwIcsYFYv_EUwFLFLgTa-39278wsO-Sit3HspdTLM-Z3I3jYAA>
X-ME-Received: <xmr:wMsGavrfSa-p2ZAnJ5RWz-X-YNGZ_eJcxuVl_lfAADwdTYBgQsIXPEzlrqTc4bQdYCOiTZ5fYlSB5q5WLtIcyyV6H_1Bo_bR-BM4Q7CKwc4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelkedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epteduffevjeelleejuddtjedugeejteekuedufefhudevkeelkeduuedugedvheelnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhmpdhrtghpthhtohepshgvsghtrghrughifhesnhgtfhdrtggrpdhrtghpthhtohep
    ghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wMsGancHRyG-vSAuKiygFy6g4rxjLJ9PgbDki3kkqT4jIeg10aBCYg>
    <xmx:wMsGampN6LzIUstJwkdMQy7Y0WVEtrlUlGVHgS5PmPkeftpYAxKM4Q>
    <xmx:wMsGagGAxLw2p2jLwTdgfOvDIBNM38A4caJspg9n8N17wQZs2qqPwQ>
    <xmx:wMsGaut5glEVQRgvdJo90k8WrUJ1uRoKqoDVxsNyPr_MTIWKEuU6Ng>
    <xmx:wMsGarZq-sLIrk2IjW-WGfRn3U35tO6ICrvth_Lxnp_MRFVbRqjYUseH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 May 2026 03:31:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2942bd07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 May 2026 07:31:08 +0000 (UTC)
Date: Fri, 15 May 2026 09:31:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sebastien Tardif via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Sebastien Tardif <sebtardif@ncf.ca>
Subject: Re: [PATCH 0/3] daemon: fix network address handling bugs
Message-ID: <agbLuuEgkllvbxDX@pks.im>
References: <pull.2300.git.git.1778773592.gitgitgadget@gmail.com>
 <xmqqfr3tg5me.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr3tg5me.fsf@gitster.g>

On Fri, May 15, 2026 at 04:20:41AM +0900, Junio C Hamano wrote:
> "Sebastien Tardif via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > Fix three related issues in daemon.c's network address handling:
> 
> Thanks for separating patches so that each of them addresses one
> specific issue.
> 
> It would have been better if you sent this series as [PATCH v2] as a
> reply to <pull.2299.git.git.1778291290159.gitgitgadget@gmail.com>,
> which is the previous round.  That way, the mailing list archive
> will keep the related discussions together on the same page.  If we
> visit the page for the cover letter I am responding to,
> 
>   https://lore.kernel.org/git/pull.2300.git.git.1778773592.gitgitgadget@gmail.com/
> 
> nobody can see that there was a previous iteration so those who
> looked at the earlier effort cannot refer back to it and compare.

True. Other than that though I'm happy with this iteration. Thanks!

Patrick
