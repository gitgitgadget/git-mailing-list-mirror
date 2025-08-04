Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03EA2E36F4
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754289360; cv=none; b=SvcNKWhUHtiHVYxEN5KGj9VemZo8xTpYRCBHG5rxdwJxndG4MXp+Cdk9R5H2oHH06Y1nG+tHlxMkATcuLu3UaUbSRvgpTSsT+uA8ePMIczvMHozM17Qu/sQssjjXcId7RoXIQ/IKF1nWFzvPGg8mPqQ21KNBzK8ybQj8k/I7Hn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754289360; c=relaxed/simple;
	bh=laWuMHAtUru2tx9jqDA9DmOQHkKeRkxsCYYZ8c1tQyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6GV/vuxFaZQeATsxP6i7EDVYiUQhGZqeCavQPs+bT6faS5du0r7kVI9oUee/xFSRpOBktOipcZXqiD9NUgbqutlWrTTlX1Cg6tZZbA+bpoHc4UkOcEQHLnyMjwhXodmWWst9uv+lb9Sa8DQe0bVSiNBpLKm+YNZUCRSLkDQfso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ut+CjSPK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aCC7TkQb; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ut+CjSPK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aCC7TkQb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 997D81D0010A;
	Mon,  4 Aug 2025 02:35:56 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 02:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754289356; x=1754375756; bh=W18lSbL9Wb
	3+2JVPhuTsnqgoXgBfwG+5DCLh00ZTt8E=; b=Ut+CjSPKqUAqTcV59svPyNykv7
	OugIgw0off3BqiRY/fxVUVcY8mT9J9FeScBtCo330bAapScZ4B68zdAq1305c/xk
	xFncghDzaaPhIzRqCXZoR3X6fizzu3+kZruE3rbNj6x/dTYk13AgiQzfAvqy9e2m
	Ioz9i51TDQGNDtW26CLJzaYAETIDykE0mEjzOtEVtUqF+D2hzpnFy6ubch3+nCvJ
	V2U/yeHCbFJxrr9RHt72gTVaqnN5yjxAsJI0TBGKzCM/TirEjtPuDnMRaL/hFE+f
	YWx6URV+qpwUSwI1V+nCPkaUW/EQaWe468TVCx/KeP/JAROlsvGRUOXotbNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754289356; x=1754375756; bh=W18lSbL9Wb3+2JVPhuTsnqgoXgBfwG+5DCL
	h00ZTt8E=; b=aCC7TkQb3hHuMGPI3Xypeko2DN3tGNuSMq4lfVUXC+T/3VvRZaG
	ZsfiW8nEoi/FFUYvu9upmNtyV0yCI/Vulxdd5aYAFY+0t8z4hhEVwqJjle8J6+OS
	5w5/ExH0NvDyVG1FYoCwgCRTGDOBOS150G/lNAYVidPjnNrg5X+lcSbji1dbRgGU
	e4gzNxei1xKbKOhn2lWtfMS9lLmd+9lxfxJfmKfvBLR7u69cdCS76xQdjZ1i7LKZ
	wgmRxCyo27lmsdyzNIj1H7HZqEAf3tLpxvfw9OljKK6DBPgKJ+rpcF7UzR1E1cB6
	S7YY5aPxfD5PLPF3jWNZgBPV5/aDx5+HpVQ==
X-ME-Sender: <xms:zFSQaBuB8cIK6JFng5MHqtGjDXHecde1q-k05nZ8RwjRCm_u41lJjQ>
    <xme:zFSQaHUP1PC1ReBWoSbk7Fgnulgxftf6lIFs8eZvDK1K6yzmYTU-0C-RPABA33nYF
    LRvY4WtvU-ZlZYQqQ>
X-ME-Received: <xmr:zFSQaEholtPyTtIz5FRDN7HCpXTXW2vfGDhSl_eHK9jSMpC7BveDMAaAUhJAjGR0y-R9xjOCL8QMuJNnHB1rfcKZ6vmbQi7R_f6keWaIS_8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsges
    ghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
X-ME-Proxy: <xmx:zFSQaHpGm0w6jZIHr7EsB6EMFTbCWgr-LI3EqTfHW6M83AkCkLF4kg>
    <xmx:zFSQaCFUiPXmS358v93HpqcYs2ES7Ei14-4bAjlHMFeH-8wncyYFqA>
    <xmx:zFSQaE50FPxHucofhB0t6RF19PHS-Ds0Q7KBbCCkRu59LCdiRIoOwg>
    <xmx:zFSQaCeA5whzofBUF4FZEixVCaT6U5wj-oeYqUJpW8kXj_c9mxuLbQ>
    <xmx:zFSQaHtFK2qt5TbkXWRjEtN3lATPzP-JFYlq8UhzzAVVruZZt3Hv00m3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 02:35:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cbea3b1d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 06:35:53 +0000 (UTC)
Date: Mon, 4 Aug 2025 08:35:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/4] last-modified: new subcommand to show when files
 were last modified
Message-ID: <aJBUxj7li3XsokdR@pks.im>
References: <20250716133206.1787549-1-toon@iotcl.com>
 <20250730175510.987383-2-toon@iotcl.com>
 <CAP8UFD0AEKDmvQJTanL+ZS+U66WAZz=FKSJ3LPE1QHSEyH-zNw@mail.gmail.com>
 <aIyVft9PdlorttzZ@pks.im>
 <xmqq7bznm0nk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bznm0nk.fsf@gitster.g>

On Fri, Aug 01, 2025 at 10:06:55AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >> > +static void last_modified_release(struct last_modified *lm)
> >> 
> >> I think these days we tend to name those functions using "clear"
> >> instead of "release"
> >
> > It actually depends: if the structure can be immediately reused
> > afterwards without requiring another reinit it would be caller "clear"
> > indeed. On the other hand, if we only release memory it's "release".
> >
> > I think this function here falls into the latter category, so it's
> > correctly named.
> 
> Given that even a long-time contributor gets confused (including me,
> who needed to see where we documented this for our developers),
> perhaps a clarification patch is in order?
> 
> --- >8 ---
> Subject: CodingGuidelines: clarify that S_release() does not reinitialize
> 
> In the section for naming various API functions, the fact that
> S_release() only releases the resources without preparing the
> structure for immediate reuse becomes only apparent when you
> readentries for S_release() and S_clear().
> 
> Clarify the description of S_release() a bit to make the entry self
> sufficient.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/CodingGuidelines | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git c/Documentation/CodingGuidelines w/Documentation/CodingGuidelines
> index c1046abfb7..76ec6268f2 100644
> --- c/Documentation/CodingGuidelines
> +++ w/Documentation/CodingGuidelines
> @@ -610,8 +610,9 @@ For C programs:
>      - `S_init()` initializes a structure without allocating the
>        structure itself.
>  
> -    - `S_release()` releases a structure's contents without freeing the
> -      structure.
> +    - `S_release()` releases a structure's contents without reinitializing
> +      the structure for immediate reuse, and without freeing the structure
> +      itself.
>  
>      - `S_clear()` is equivalent to `S_release()` followed by `S_init()`
>        such that the structure is directly usable after clearing it. When

Yup, this looks like a reasonable change to me, thanks!

Patrick
