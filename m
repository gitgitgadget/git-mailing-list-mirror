Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0961F4276
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740999316; cv=none; b=X7QjRnhSywdxShaAk6QVvBYtLhBSi8u72mWRdK3aGxBnDZlmMCzz8wnyFQIROXHx3Do92gw04Wro4tY3p+ySXFk2A17kZo540TBPlRr4gqnsvQlc8Y9F5T5kRNg7GV5rny2qPFE/Uw6hw1POCilS9qmR47G+wi2PsO+/ho+uefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740999316; c=relaxed/simple;
	bh=HD6BYDlYNj82V7fouyyyXEKX21bGTxwhbxv7TBgVPaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2D/k+R76v8Vpx3gdaM9npslvCGmOU8c9sZmGrDVu1xgFrFDktHzWVzupcdoxXdiiH5ULCGzBp51j07L/llqXhe6yaBbXAyDhumO2GKnDqEjX45Jmk2wwdtfbwNZI4iku2ebU3KxgXvzDWlYSC6uqOIN/08IFoIK3Y8yCro+qAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BQMSbV+U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7s5cIOgo; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BQMSbV+U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7s5cIOgo"
Received: from phl-compute-13.internal (phl-compute-13.phl.internal [10.202.2.53])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BDBDC25401C6;
	Mon,  3 Mar 2025 05:55:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-13.internal (MEProxy); Mon, 03 Mar 2025 05:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740999312; x=1741085712; bh=P7vQQIXY4/
	kshT2MB82ijbcA1HKtRUROiHndgHet2fg=; b=BQMSbV+U4+vWWddBEGmQJk1/ac
	OmjAfZYhy9XUp0pE+LNgUZ9nd9bti/K+AJPLDR491WQqy8BatMWaIgA7zP/kwIj6
	TTEQxAjl4/LtwqUUvUQxkvr9bb5s0tkK2tabzSZk6YF3Noq+pntYp0a3jHAmlgcW
	uNisPiFRjBVwzhCHBvCgeHgTpByFW1SwBpuWLopHyYNKb/1xjiuT5GoGigGeTs0f
	vAl/EQS9GITvNQkX+cFo9f54yJ00en5lIMuacuTMCkV6dn1C+NcHlRkLET7bGkBU
	LdsGEXqGk+JBFphFQJKKYcjEQfm1sSsUJ5unf8MuZ2Y1WbYGCbkLtnAO2JWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740999312; x=1741085712; bh=P7vQQIXY4/kshT2MB82ijbcA1HKtRUROiHn
	dgHet2fg=; b=7s5cIOgoY5riqc6U67lKPfQlHV0NRTT5qRkZgDG9SdXbPiSYhuU
	Vy9tFHbB8fOXgf545Qlonp/W3YIBSx2IwOUp29dUzdxjAdJ2X+zKYPw+dtRkmqVg
	h4tXb/fLkV3A9s7ry8q7K2kZKdDb8CQjVGguAz7krn1vBiq38fYjbbCdomRhzslo
	SQO5z1LWKkijwRoFHCTRRfdwRvOgKhft/jeXAr2MHSUXlSs8w4lxxsRFWgFR0CO2
	Jqglw6LPpxqGSVY2LSb5d0ICagRT1MQSmobjPY5e7SGRnvGMZUXX6FTVeLgxunr1
	DpCfe9TT9UjzKOWo+3ia6wot7N4FQLC0PPw==
X-ME-Sender: <xms:kIrFZ_4-m1bi87ICIEouv8fD57fv6QOebYHeuE4mfv4A6VUzFBUieg>
    <xme:kIrFZ04i0PhEI_Ib9UGIUJW8FiTKycDtPp3FiAnPEyubRbC1gu1kZPmFxYn-aAXjB
    LMI8UbnP3BwxxPayg>
X-ME-Received: <xmr:kIrFZ2cHuSoAlCOZtFDG0ymcoBRegY0g7i3Xlc27nICO4LDaK80CcBtqDMWcY6UyVX9PB81R2El6ep6H1wIXQVLvT7lsQmdJfg-jSU31LXuyC9bJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelkeelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhm
    rghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kIrFZwIdRtcGhZErfepYs-R3twV1oNovUFwrla9aE7098v3YLIhbvw>
    <xmx:kIrFZzLqBV1OY_JkFDhEB32ewMrvI5XDtdvkp_NgXldq6PJENxHhHg>
    <xmx:kIrFZ5w_7K71UKNs3-3-gymF6NT3yaJoYpzWzv-wgB-iy2NNKrPilg>
    <xmx:kIrFZ_LOKhrodWJOxw60-nIMsRcfm2UzFXmxa4bEXkJSCcFYW0HWdA>
    <xmx:kIrFZ5ieBO5D9QIl_f7_AsmJJwo52Tj4VNvcc6y_dkBdEHCIEwg-3wdj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Mar 2025 05:55:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7b92f8fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Mar 2025 10:55:10 +0000 (UTC)
Date: Mon, 3 Mar 2025 11:55:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 03/13] pack-bitmap.c: open and store incremental
 bitmap layers
Message-ID: <Z8WKjegeTs9aAsBr@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <5b5d625cbe02560a20c12b7dd20aeda4979017bb.1732054032.git.me@ttaylorr.com>
 <Z8GJbOoY9Z3VMSEM@pks.im>
 <Z8JLbxBQh7XUpplz@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8JLbxBQh7XUpplz@nand.local>

On Fri, Feb 28, 2025 at 06:49:03PM -0500, Taylor Blau wrote:
> On Fri, Feb 28, 2025 at 11:01:16AM +0100, Patrick Steinhardt wrote:
> > On Tue, Nov 19, 2024 at 05:07:26PM -0500, Taylor Blau wrote:
> > > Prepare the pack-bitmap machinery to work with incremental MIDXs by
> > > adding a new "base" field to keep track of the bitmap index associated
> > > with the previous MIDX layer.
> > >
> > > The changes in this commit are mostly boilerplate to open the correct
> > > bitmap(s), add them to the chain bitmap layers along the "base" pointer,
> >
> > s/bitmap layers/of &/
> >
> > > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > > index bba9c6a905a..41675a69f68 100644
> > > --- a/pack-bitmap.c
> > > +++ b/pack-bitmap.c
> > > @@ -54,6 +54,13 @@ struct bitmap_index {
> > >  	struct packed_git *pack;
> > >  	struct multi_pack_index *midx;
> > >
> > > +	/*
> > > +	 * If using a multi-pack index chain, 'base' points to the
> > > +	 * bitmap index corresponding to this bitmap's midx->base_midx.
> > > +	 */
> > > +	struct bitmap_index *base;
> > > +	uint32_t base_nr;
> > > +
> >
> > It would be nice to point out that `base_nr` is not 0-indexed, but
> > 1-indexed, which is rather uncommon. Is there any particular reason why
> > you made it 1-indexed?
> 
> Hah, I have no idea! If I remember correctly, it's because it makes it
> (slightly) more convenient to do:
> 
>     ewah_or_iterator_init(it, bitmap_git->commits_all,
>                           bitmap_git->base_nr);
> 
> , instead of incrementing 'base_nr' by 1 to determine the number of
> sub-iterators to allocate.
> 
> So I think there are a couple of options here. Short of doing nothing,
> we could:
> 
>  1. Rename 'base_nr' to 'layers_nr' which would make it clearer that the
>     count includes the current layer, thus making it 1-indexed.
> 
>  2. Leave 'base_nr' named as-is, but make it 0-indexed, and have callers add
>     1 when they need to know the number of layers.
> 
> I prefer the explicitness of (2), which is how I adjusted things
> locally. But if you prefer (1) or some yet-unknown (3), I'm happy to
> adjust it further!

Yup, I also favor (2) here as it is the least surprising option to me.

Patrick
