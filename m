Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC22397AA
	for <git@vger.kernel.org>; Tue,  6 May 2025 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508221; cv=none; b=Wnz484mgzvyJYTDHMO1Ztrh7mGbf/e5Xe1+LYFvmrm29/LIcfO7IGho8ahHGEYpx5gIECNTiBJu8KU+7Ub+r07K1MGV9LcXP/nubQbJ4JCmE0vltx2cXK7qsLxnKj8qtDbUWXl18TOAxmRrgHvyDkBX8UBOZqBsPEO4coHVcPbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508221; c=relaxed/simple;
	bh=S0lVGsNUrUCp3ysSz3JCoggd7oLu4lMcFDb3/Ml+2K0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBoUlaoLzTW/Sxx20Y8tsu3zqu02RnmdMF3jmAb9hM1TVzZiNh3j8tRIEkXXq7xT19C9MGkxcs0EAYe/HAVXpiLd1B8Uk33H/Bn74ITQYdTQBLOuY8LmRTpAmKj8iWVdGhQHdEbcix4Q+bhex6ac7LBm1i+2SzBrBdBHNOwVesI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uZfpBN3j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FZOB9MVV; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uZfpBN3j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FZOB9MVV"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DE1C1140259;
	Tue,  6 May 2025 01:10:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 06 May 2025 01:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746508216;
	 x=1746594616; bh=IU8xNKzSG4Xe7qN73/g16i0M+a4hVmuxq9Q35KZ2Erc=; b=
	uZfpBN3j5O4Y49vwPtopGpHqPgC0vg/GWDkxfn7ORRW9JO7H5icTvByC9JtHAnsw
	JUK7iCkFt6TsygW/jxUBPaGliU0+9fAEigznW/fFLxOUKZ9fzqPi/YFZZtZ3EvUS
	RdHSe2JeY1EJ3EsvdZfmamiNycMB6XY9p12Zm0v2ytBmN+/XNT9PXqeECL/Xe2tY
	14DX9nD1aC/y1YwVf4B/135bri7drQhzKWoBR3yi4bmXXqUMCCkn2yY+IuSw/2GL
	n+vAKh71xIaupfvEhEzjYiV+TwDAjo94dS4maBuMbhCsJIy23oN0bVteiDZPruY3
	UpZYp4TAlRXSvfqUmpp2OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746508216; x=
	1746594616; bh=IU8xNKzSG4Xe7qN73/g16i0M+a4hVmuxq9Q35KZ2Erc=; b=F
	ZOB9MVVDt22scEfZgWupELRRfyFIUQ8weV4fxajbsmcnvOftXD8/GLPcvOocD7NQ
	ueaL0HtM16Rh0Ig2lWduOMo71F/97K45uvtS9K4fO36nrfk8sA/hZqZ24OxDI/bO
	Ot0KcdrN0WYa9MgcetH+JhGfVD5PhBW45BcKsIx9mn+1E3wasseHX+EAhK3dlUfX
	7cckCCcnfxPNB0RwUt4Q7i7JgyF+BhABF3/KFIOCPVonf9ZHtSllpeVeZud+Vvv2
	BLL0PKvdzhpdaeqSr2ZFwTylT+iBvpWIYyLYazZLkBfSTTzMU52cPROhcxw/3eZU
	Ed59T7r6HQVxnT+PXZSXA==
X-ME-Sender: <xms:t5kZaFYAzbH-D3YhRXiDzgh0_4kd4x3lT2gw7NJLERvMhF6yCAyMzQ>
    <xme:t5kZaMaE1A375ogAQcmEVj_IWWmo5rhie7ycpERYBzcdulqlbSrId5aE_RkhvVckx
    MdRut7fVd3PmpuW_Q>
X-ME-Received: <xmr:t5kZaH_EruQIiPz3OHAbXzIfnXrGNMEr0Zu97Nyeq63yUvPb8l7gXt1enzy2I75fLEU8hEilQXKkwfBexnW-9Jk7K3WZlIxVCcnDwHD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepkhhufhhorhhijhhileeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:t5kZaDow6-4ugTt6t-7hP-9dFMO-jSs745d06wljCRcqzgAsR62pzg>
    <xmx:t5kZaAppMwWQ1qdwlT7coIzMC31c2O2Q7u7eAFbpmSV4w4XhlgXhpQ>
    <xmx:t5kZaJRRYWm0yUg-s0cq6bOEV9ceyfopA7xqMMwowK18vZEV5JyK2g>
    <xmx:t5kZaIpFyEwCRCJsvTR9Zjq2r-c8vo0JU_e7uqVOxjRey_0Bsd1DkQ>
    <xmx:uJkZaAdQtNs4QeBj-vOzAl0hNy-dwT_hJHdki_yoIan9PBrAeK9en4Uw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 May 2025 01:10:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id de4cd89f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 6 May 2025 05:10:13 +0000 (UTC)
Date: Tue, 6 May 2025 07:10:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Seyi Chamber <kuforiji98@gmail.com>, git@vger.kernel.org,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 03/10] t/unit-tests: convert reftable block test to
 use clar
Message-ID: <aBmZtFlcn8CunVg_@pks.im>
References: <20250429175302.23724-1-kuforiji98@gmail.com>
 <20250429175302.23724-4-kuforiji98@gmail.com>
 <aBSXGz_eIljWbb2H@pks.im>
 <CAGedMtcBsT=7=tL_y99_G9xNW43Bttb3dFqy68DfFt0ZgpZ-4Q@mail.gmail.com>
 <aBiKSeTLItw85A8z@pks.im>
 <xmqq7c2uoj40.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7c2uoj40.fsf@gitster.g>

On Mon, May 05, 2025 at 02:14:39PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> >     -M[<n>], --find-renames[=<n>]
> >         Detect renames. If <n> is specified, it is a threshold on the similarity index (i.e. amount
> >         of addition/deletions compared to the file’s size). For example, -M90% means Git should
> >         consider a delete/add pair to be a rename if more than 90% of the file hasn’t changed.
> >         Without a % sign, the number is to be read as a fraction, with a decimal point before it.
> >         I.e., -M5 becomes 0.5, and is thus the same as -M50%. Similarly, -M05 is the same as -M5%.
> >         To limit detection to exact renames, use -M100%. The default similarity index is 50%.
> >
> > What you probably wanted to say is `--find-renames=90%`, but without the
> > percentage sign it is read as a fraction, where 1 means "exact copy" and
> > 0 means "all different".
> 
> I am confused.  -M<number> without trailing %-sign is taken as
> fraction against 1 followed by the same number of '0' has the
> <number> has digits.  -M5 is 5 over 10, -M50 is 50 over 100.  -M90
> is 90 over 100, so -M90 and -M90% should mean the same thing.

Hm, I guess _I_ was confused then. It doesn't feel natural to me that
-M90 would mean 90% whereas -M5 means 50%, and the documentation isn't
quite clear about this, either.

> But you are right.  When you want to claim your pre- and post- image
> files still correspond with each other in a meaningful way, even
> after making extensive change, you would want to _lower_, not raise,
> your similarity threshold.  If the default is -M50, then -M90 would
> be a useful option to reject what Git (mistakenly) thinks are renames
> and tell it to instead consider they are removals and creations.

Yeah, at least that point stands :)

Patrick
