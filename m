Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D28212D61
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 12:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737547511; cv=none; b=VqsdU2pnddwOyAeTTPBmilk+TpkM1cjGxKOFDAjQGlqc8hHw6RqpISDeMvuND96c9GTAavWAnlNkLRJf+YG+eUzljn65OLY/sSZb506MXssPFuE5nWhuF4L0UNVznId8aD3qE5vg1bI63nZGMTa4D2VkPsEE71UWSSBWZU1wabQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737547511; c=relaxed/simple;
	bh=Sp20c5r/o8R3x/S50EwNkd7iF8s1KthFZV9yD9+lHLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wy+Ic8e+xmeQT5RQjzwAFPIxbmcNT+IRvoeUS2msGoPWYp5iCBQvSfGiWjs+wiVPRy0sSr+b/9bFPfXLEUvy5WS6IGjgrGxsfEJ2QbzMXKXc39sdWKsBgf5jrEvFmV169PBNI0BxnIBTSjJBq0lqazmnMDGjGH6shOlUMuVAsmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P/OuLo9C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+5nNOJO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P/OuLo9C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+5nNOJO"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CC5C1140093;
	Wed, 22 Jan 2025 07:05:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 22 Jan 2025 07:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737547508; x=1737633908; bh=Z6O9C2LeTE
	E56DWn/JspXC/x9at9UoSQlQxctT7xjWE=; b=P/OuLo9CcXMHX+CZXkxkjHYieX
	m+i5SYbWJhO71uEO6Fqo2piGo29ZObRkdEFcaTSgbTNBKIerPvbGuBw8jTJPu6hv
	DNkxRdFXP9GvuGIWxBInQFJFGOUarYQlaUaCIqZD3YZKI6eNbGneUDH5WhTW95mO
	glOvjbcuP4/g2KAtai8CSzilT7xZZPLaeoEcZYY6ugNmewLisDX4W9y/VvkrydT9
	9FUs0+BDOsC+gwMbiNmAXLYrlKRl+lyOO8csWGD30G5vJNOd3+BYdOOmClILlHQV
	mRWZmD5N0OHnj22+RVbPgO2wqd8U0tNeQZezEkk+AVmfpsc5CjGVxDkgsd9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737547508; x=1737633908; bh=Z6O9C2LeTEE56DWn/JspXC/x9at9UoSQlQx
	ctT7xjWE=; b=B+5nNOJOC0iJ2GOiwC2cyNG52+qQH5ZJRaahs0BUNt8SJdvgzxq
	K4vroqH4XabgJQRAW0Ed0qIHsGzXypkzH35M+5l8zGioNlsEr0jSHHV6Vk+pboQX
	ekch/RuneGJWNmiVNMV0UtBNbe1idMGS1RKSuDl10v6oUNYopssiLg1YEXh1Sf20
	Mj6w4GL3USHEuyklK9YtNat+nM9QFuGKPXiI4Oc/tVrwKfmEDFdEy10z5YxeQHAJ
	VbuyUZ+7sU9OctG4FYq8cOmihOKPzIKoYibC9tD3/kM0Y3/70hJTzV5sOcQyXBCE
	j8UtoG55Tw71/8vyiye6ryUqknLc2tLORYQ==
X-ME-Sender: <xms:896QZ8d7Tc_w9Lj_-qzm6K4007QN6ymFjP6a33fkKJTg2u_2qA4LBQ>
    <xme:896QZ-OZnNboTsKMMh064gwVg7Mwq7uvPQE_rMmzqyMRt7MnR9HQCZ8tgX4n3gG_X
    o1mpG09ActjX8o31A>
X-ME-Received: <xmr:896QZ9jPk8EjyO4euxpNJL5FtVKbKfCfhFhkhe12BNXWDORLqJXeuUNqu4znlJA71JlaZQBAUATBPg9yhLbjd9BhCq-DWQdAJGm-sPaik4g5uik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejfedgudeiudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmihhrthhhrdhhih
    gtkhhfohhrugesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:896QZx_7rmgNsSsNylECVXW--doJLcYEE1eFwr_Tv5i9iLlhubMC5g>
    <xmx:896QZ4uK9mbgwVdrRHAzptZnOVUfeyaPfD0lNDkXGc6PF3RcEFac8Q>
    <xmx:896QZ4F7fBrBG5WEHE_hKDMs9hmBFWz-JYux7z3UI7EoRfygajbM0g>
    <xmx:896QZ3MNgEmpB4dGUyX1MJukfi14mL2MXZAXTzMABAnM1hZO5AIKqQ>
    <xmx:9N6QZ8hgPZ-rC86d9xY7qiHnb3rVXz897hxNPSVN3mG0GHCTDeXvc1qG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 07:05:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 899121eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Jan 2025 12:05:04 +0000 (UTC)
Date: Wed, 22 Jan 2025 13:05:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Evan Martin <evan.martin@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 06/11] meson: wire up generation of distribution
 archive
Message-ID: <Z5De75u-TpwmUpZ7@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
 <20250114-b4-pks-meson-additions-v2-6-8d7ec676cfd9@pks.im>
 <87plkgibr0.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87plkgibr0.fsf@iotcl.com>

On Tue, Jan 21, 2025 at 01:37:23PM +0100, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Meson knows to generate distribution archives via `meson dist`. In
> > addition to generating the archive itself, this target also knows to
> > compile and execute tests from that archive, which helps to ensure that
> > the result is an adequate drop-in replacement for the versioned project.
> >
> > While this already works as-is, one omission is that we don't propagate
> > the commit that this is built from into the resulting archive. This can
> > be fixed though by adding a distribution script that propagates the
> > version into the "version" file, which GIT-VERSION-GEN knows to read if
> > present.
> >
> > Use GIT-VERSION-GEN to populate that file. As the script is executed in
> > the build directory, not in the directory where we generate the archive,
> > we have adapt it to honor the "MESON_DIST_ROOT" environment variable.
> 
> I failed to understand why you couldn't pass the absolute path of the
> output file to GIT-VERSION-GEN. So I looked at the previous version of
> this patch, and it seems you explain better over there.
> 
> I was testing things locally and tried this line for the last argument
> to the script:
> 
>   run_command(shell, '-c', 'echo $MESON_DIST_ROOT', capture: true, check: true).stdout().strip() / 'version',
> 
> And I think I understand it better now. Meson does not execute this when
> you run `meson dist`, but when it (re)generates it's build files. At
> that stage $MESON_DIST_ROOT is not set.
> 
> It's unfortunate we have to learn GIT-VERSION-GEN about the
> $MESON_DIST_ROOT environment variable, but I don't see any other way.

Hm. Thinking about it a bit more there is an alternative:

    meson.add_dist_script(
      shell,
      '-c',
      '"$1" "$2" "$3" --format="@GIT_VERSION@" "$MESON_DIST_ROOT/version"',
      'GIT-VERSION-GEN',
      shell,
      meson.current_source_dir() / 'GIT-VERSION-GEN',
      meson.current_source_dir(),
    )

I think this is a much better solution as it doesn't require us to teach
the script about `MESON_DIST_ROOT`.

Patrick
