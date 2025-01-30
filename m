Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B34A143888
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738217077; cv=none; b=pXUQNcFVTUdDxPvGEU1SL/ANYVWA4KjQ1f37i2t/SAsbMAg14XwPYyjVsKan9q0egEPtqcMzFNKCCGtO0MWSJcGD4Z7Mquc/fuCQsVa3OWz8oVsC6iLmut2pcdnVE6D+efyx8YmwU6ACFCM1rvWiksaxLNvY9t448/N39Zbpx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738217077; c=relaxed/simple;
	bh=GfDLNtGgX4vvT4mTl0gUTKaPOAji6ET0+/gOPiTMn6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zov5GICNwMdU4PXoGC3GktTx/a/d+A51ClHCOAhvsvR5sRHlEhDuCZDqF/b/VpgU1DAGRDcu0BVXS+2opKusUmc//bhT2tMGpFVZjJ+tSIPvttl7PA2El9gusKxAlZnUIrbFX0ndGJFz5qCh7zT68oLx+cP8xR7noQbX75677N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PolfXelb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lbV9P+9a; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PolfXelb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lbV9P+9a"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id F1745114016D;
	Thu, 30 Jan 2025 01:04:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 30 Jan 2025 01:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738217073; x=1738303473; bh=xXFC9908Vs
	CS6zIg/g3LNC2jLMo/DPgeJN5lza/2g8E=; b=PolfXelb4S5L20LS59hRk+MvNT
	ZO7SLYZwRL4m9mu4aeQLK+y5K5TbNW064lne4y0LC6zYhmGTAT4ayavu7+KJgOfi
	eIZvEB8e+/iFQv2Uik1mumQo88U/XR4hP3ccqMYKyJ2t3Psm2zf21//oObjdgIvW
	ZFP32IN25+iu79TjtsOzDGZLEIjJ+Nl9ymuZN5eoCUzfzcsiRyk0ChHF7q2LhnSp
	N3FJAAXKNPIk3Gvb7R/awxGygECbi2cweRHat6ylIX79IDwE9PGD4Swdw+pIDxXa
	ZlnTFdRGZS1UuZo50lErpfMDecg34KXb9aZodJ8pYW+x1Z+gv1qZ8xWR7JLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738217073; x=1738303473; bh=xXFC9908VsCS6zIg/g3LNC2jLMo/DPgeJN5
	lza/2g8E=; b=lbV9P+9aOAXY77x5fLivIjJCgrP+vEXGQlbE+8dsCw6yzkG+taG
	YI/3nueBzUOMv4BmvmVfsyHNK6Oxgoz9c/1KqCb0D1ZnG6Kg8kCkJcv0LhqkE83M
	Siqak6zrdpVMMOtS0uwKL+cRuVKEDEHRE/FXuoIsKmLOTN6Y8jFwGNkJjaFV1atd
	cCfrZHcTk1+7mpWAwDJjQISDcwSTOLzAO7uiIqZcUCZOLNkqkvMv0uMiukoLkCUQ
	xbnOxI1KAEB+dmIsRLDaUhVFmJ9Pe597qK9BYlPsgLXn7gfkg3BRwGXgmb8YAJz1
	eD74eD95kPWg5duoj42P2zhVvraksyrknlA==
X-ME-Sender: <xms:cRabZ11jKBJUs4Ro19jC09Go_YcQ0UIaAAILIRWe9anT61H6S66PRQ>
    <xme:cRabZ8H4KYwq6R0uF6ApkK09iGTgfIoEjJLj2zHn2eJkpoRWgk-xz38vuN3oiMOUr
    qQROlX9JAFeE-M6yQ>
X-ME-Received: <xmr:cRabZ16oqApQh32FgItb-7Qco4OjYHW5QmFVS2yybCj16ucNgtZ-ZawXAg3EFHvINBL0_z3dpfa0ckgv9Iq9RpqFQT_W5-5Cje2PDXznrbUX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:cRabZy2QnxCtXyO_qLKTDadzdAMdLXb5S2oOx3J5pFRMV_Yi53Mx9g>
    <xmx:cRabZ4GVOJuyDJsxuNtUHwwz1A8-9rtpxDgjitoSqHm3dPva5QxArg>
    <xmx:cRabZz8qPB_QApmJTcntfREOyz8xnW5KhpL5YNp16jJ6DWrCjDvNCQ>
    <xmx:cRabZ1koRGFWpG7gf2S67I49NJVvYwbgRrk7FYNClH9TRKG7f-m0Rg>
    <xmx:cRabZ9Rxlp58dI_Xiwg7EW88mw-nv0EvrOr1jfumEECFuoSUaHAdT3nw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 01:04:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b5de60d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 06:04:31 +0000 (UTC)
Date: Thu, 30 Jan 2025 07:04:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/2] Plug two memory leaks exposed via Meson
Message-ID: <Z5sWbg_0ri3V_yDm@pks.im>
References: <20250129-b4-pks-memory-leaks-v1-0-79e41299eb0c@pks.im>
 <20250129200509.GA2331283@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250129200509.GA2331283@coredump.intra.peff.net>

On Wed, Jan 29, 2025 at 03:05:09PM -0500, Jeff King wrote:
> On Wed, Jan 29, 2025 at 05:24:13PM +0100, Patrick Steinhardt wrote:
> 
> > I've had the need to play around with the memory leak sanitizer today
> > and for the first time used it with Meson. Interestingly enough, a test
> > run with Meson flags two memory leaks that our Makefile doesn't. I
> > haven't found the time yet to figure out why that is, but this small
> > patch series fixes both of these leaks.
> 
> At least for the first one, it depends on how long the path to your
> trash directory is. Doing this:
> 
>   make SANITIZE=leak
>   cd t
>   ./t0301-credential-cache.sh --root=/tmp/this_is_a_very_long_path/the_size_of_sockaddr_un_sun_path_is_usually_108
> 
> will fail reliably (it's not 108, but with the trash directory and xdg
> boilerplate tacked on, it is).  The failed chdir() triggers because it's
> trying the xdg path to see if it exists.

That makes sense indeed, thanks for digging. I'll add that info to the
commit message.

[snip]
> This test would trigger it reliably, but it's weirdly specific:
> 
> diff --git a/t/t0301-credential-cache.sh b/t/t0301-credential-cache.sh
> index dc30289f75..0ef8ce4e60 100755
> --- a/t/t0301-credential-cache.sh
> +++ b/t/t0301-credential-cache.sh
> @@ -134,6 +134,13 @@ test_expect_success SYMLINKS 'use user socket if user directory is a symlink to
>  	test_path_is_socket "$HOME/.git-credential-cache/socket"
>  '
>  
> +test_expect_success 'error path for chdir of long socket name' '
> +	A=aaaaaaaaaaaaaaaa &&
> +	LONG=$A/$A/$A/$A/$A/$A/$A/$A &&
> +	# do not create $LONG; we want to trigger the error
> +	git credential-cache --socket "$PWD/$LONG/socket" exit
> +'
> +
>  helper_test_timeout cache --timeout=1
>  
>  test_done
> 
> So I don't know if it's worth adding in to your patch. The fix itself is
> obviously correct.

Yeah, it doesn't really feel worth it from my perspective.

Patrick
