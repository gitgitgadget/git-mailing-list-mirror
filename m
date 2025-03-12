Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034D22512E4
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 15:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741793816; cv=none; b=qmzMcHZQXj0nuRsbjXLjj/ZvcUFFVe9Nj1zKJjzysObdSUpzIfUFB3RKB4njAPV61OPHgFvnCKUDEdNxFzz4khf+gm4OjWyH75EeBAEVc8lHnL2Hk5Y81ckrzsRHrSBVFbtcQGIJoN/UYAF/24K35JWxKhyjdJbvs+IvdAx1uJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741793816; c=relaxed/simple;
	bh=/ksgFA44HW3OIwuKe1uWW+amSBzNeMDmTax24mySkrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcEYR5tv3O6O0oHF4asBhLn4RpbfeIKGUkU/nPtCl0dpQgD0NPPu7qgR+l07XyeutnCj6idyrvhSHEpFT7i5OMEcGeii6lKEigcqSYtoXqlYwrz7EUuW11aHmgJXh11wmHaEkM6XBH53MXs845BdX7M5l0CKpfJmC1s7jU3OY0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P7n1OYGH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=6FfxS5Op; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P7n1OYGH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="6FfxS5Op"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 3A6131140158;
	Wed, 12 Mar 2025 11:36:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 12 Mar 2025 11:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741793814; x=1741880214; bh=JOm4Ltnb5w
	8GLR7L0WVYhqXbnLRxpjQfXMuK6LzHBOY=; b=P7n1OYGHjJ/V5szp199f+7dfAu
	I1JXqoTkxbSW+YXDrdIl0JPoKH+PHVEfhctxj3wtTItBWgshnIfavBeAsMY74gdH
	B490RU0oEmLM84BVIQ6dWlhafVtYGz4dcYVfKCroS2lB0OA2sI1RdLKKEEOUScSN
	jyip6UPxx9KBjFcXbKnqh23tnSbGT4zo2KYo9olrpycyYYMc3+9iOSyhCTWpPFsX
	7rQX4dO4I4B/0V11kbxAbutyi4ehHhCR5I2Q9sLHVbfPdEJZrB7euj9MiXeCSt55
	eMWQCEU5f65jYqvehyh5bVU+7Ky4t23eEVNRbn6Wx9VDWAlagBgQo5d85Gow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741793814; x=1741880214; bh=JOm4Ltnb5w8GLR7L0WVYhqXbnLRxpjQfXMu
	K6LzHBOY=; b=6FfxS5OpKHXOYAhy4g0tfkIH6pBTegbYjDkrwYwGM3N3G2QVcwj
	vHNoAIuyAO9dref7Z1gk+0S7m1WqV5+gY4j4fUeuxIqtHevqqJ4R5v/naJJerrvW
	t+FESIt5gA8nwhMqEw4sf6esiHZ8UpvtpOzC5oCaQ4ZFEkXubFvV//Zjwaqqy1XB
	6fZraQpX/cW5oTGtiR1+DQShJny+siy+KRdvdjbjOR+Vk5FrP1XUhrgShJvOlytM
	hCgxrpUlzUXmtaet3QeGvCHHNDJf647lbPDMooT6dPqYG1AKZ7AHuX7vJwK4R363
	bqq8vRmyazJT1Z9VaUliK46IMhaGycAUyzg==
X-ME-Sender: <xms:FarRZ2jemoP4R5hqFBUmOCgH054Mgl1O_duATNnoED1nZ8RQhg4kgw>
    <xme:FarRZ3A-mKzefmLvlFtF2cqXeTQUPV8R4AMQCJyi7r7aBhExSpuPdpAIsQD0yrE6I
    Ltf1Nlus3V0ZyBEKA>
X-ME-Received: <xmr:FarRZ-GNi-v5It1dqZv8D5W3YiLlIiv-nKHo52YgKlLoPSv4D-mILQ2QJ4Ii7wucDMFJfzcsVsDoY9LffyXWCU8g3ydBi5DrJHr9Kwsw_Ex3tqsgUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgt
    phhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprh
    gtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:FarRZ_T6Mtr5Im3Q1FC36fKzFlH1VfJypgEAK1gbUiWvneWBTQdJmQ>
    <xmx:FarRZzzWX-KcLtRIpQZqmWbVPUZjtvYCHjzsRSl2u9pdjvKw5mwUsA>
    <xmx:FarRZ967foVGeXhyVt_tycYR6TvnrV40VF_Rn6x-IGO1VIG3bYbL4w>
    <xmx:FarRZwwDBdugVucOVMtZos3uCNwEUWPAI-h8Qu9qEG4Vgpxk9jae-g>
    <xmx:FqrRZ6xETkBR26Zly0Zw52cXjZmjSUDoORYnW2oayYEBA4_BNt1Ksgfs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Mar 2025 11:36:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ad80849 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Mar 2025 15:36:51 +0000 (UTC)
Date: Wed, 12 Mar 2025 16:36:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v5 09/16] refs/iterator: separate lifecycle from iteration
Message-ID: <Z9GqErzv39SCEb5v@pks.im>
References: <20250306-pks-update-ref-optimization-v5-0-dcb2ee037e97@pks.im>
 <20250306-pks-update-ref-optimization-v5-9-dcb2ee037e97@pks.im>
 <Z9GQDJxT1Gu9nzGp@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GQDJxT1Gu9nzGp@ArchLinux>

On Wed, Mar 12, 2025 at 09:45:48PM +0800, shejialuo wrote:
> On Thu, Mar 06, 2025 at 04:08:40PM +0100, Patrick Steinhardt wrote:
> 
> > @@ -350,19 +338,10 @@ static int prefix_ref_iterator_advance(struct ref_iterator *ref_iterator)
> >  
> >  	while ((ok = ref_iterator_advance(iter->iter0)) == ITER_OK) {
> >  		int cmp = compare_prefix(iter->iter0->refname, iter->prefix);
> > -
> >  		if (cmp < 0)
> >  			continue;
> > -
> > -		if (cmp > 0) {
> > -			/*
> > -			 * As the source iterator is ordered, we
> > -			 * can stop the iteration as soon as we see a
> > -			 * refname that comes after the prefix:
> > -			 */
> > -			ok = ref_iterator_abort(iter->iter0);
> > -			break;
> > -		}
> > +		if (cmp > 0)
> > +			return ITER_DONE;
> 
> Should we maintain the above comment? Why do we delete the comment. I
> somehow think the comment makes sense.

Yeah, let's. I'll add it back in.

Patrick
