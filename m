Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B966863D
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742820381; cv=none; b=lKsW7HhJtuodjbYN/IKMvAyq9IIWyG/YlWrydCB585ZERWKP5vNGqHPqvGpYFZAh1F1qsoYouzy2qjAO0sOveNAo3KWpeymDzeUnumdco43vQvmnX2cnL60bBKmxDNlsIsFL0lxYXCgpJWuKUBNY0rCvD440F3/3+cMBeRtMbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742820381; c=relaxed/simple;
	bh=1BGW6HxfOYTWw+OpHNjNAtSxu8ldOfJM4w4WOKobUh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRwD9LJM+IWphW8q8YYJPsVxaXhrh52Fm2PIuYCB9qHx7Qr6iBVH6lpMR4cyJK4mxqtxqrhqQRH2LVkfnqMEu0CzhNQxrjyxnfgSEs0eGVEdJXeH3eUFcG64FKLcrlsEm3+PPLAbg1mPzxZHHuSnX4S5ncH91GlAQj6sLCOu/0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rz2+Lq7v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IgUVB4K3; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rz2+Lq7v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IgUVB4K3"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id A90411140146;
	Mon, 24 Mar 2025 08:46:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 24 Mar 2025 08:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742820378;
	 x=1742906778; bh=2F6FSjY1NjTr6Tt99aaxzV4h0syrcpIl9CA35vjZuRs=; b=
	rz2+Lq7vNJrqmGCGKdTcOQNjV7QFEEk8O9jTUVf8FYMTBD2VkYZE5bpJcCRe+Dl7
	3Xfqv9pbxWuUnzl83mwCzJKvGUqcWvR3j8uJ/IYUCfI1fdry9YBXPHrNpvFNg0+T
	h8uhB/OjlWknh+/aSWEtdCV0TlE7Oye9EWiERyGWyORzSHx3Dx8cVi67sFRkl+Xh
	Db0WsyoAojKQSlSUcqIsS3iJ76wcnI3EvvKxqbleNuZ275bqos0zQZV32zPmqlHU
	hen22A/J+IuGVMpAl3AxnDhg020wDxbwHVr9SVRn4CVHuzk9gJiF5DdFuavxuL2U
	OMqDrT+rFsjBMctWJMjkgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742820378; x=
	1742906778; bh=2F6FSjY1NjTr6Tt99aaxzV4h0syrcpIl9CA35vjZuRs=; b=I
	gUVB4K3v9JSfhyxzbojw4tasO+/3Db62k9h5vWiMR/w1c9k9fCW3jfVZpuU6rffb
	bMqjz//lAhB5r+As9TGkGSDwEjS4NFMNIQ8lhvitokLvge6zrW4LnrwWNgQqw3+D
	cTweLmsJz4WL2Mj4tlqR3TV5m7GkPH73ecurFRCRtN5iYJT8l/v+0yHblGI7RshL
	n8EJeVFemiXCfmIgZxSa8jbvCGRb1EsVSU9xdw5jdkb3ttGnvEYQQj8+Qx6c8vN9
	mqCNkqyf5/dCJen0Y38TnrpMDpm3QoPqP+u02ozSb4NmoO+Ek+PwmkSo62atGowa
	QZyEBDSrnQtdFYtjcm3wQ==
X-ME-Sender: <xms:GlThZ-lwQpULQ3mgHFeALirdnoZ67uUvZ1vo2PSMi-IDPBNjQYCXeg>
    <xme:GlThZ12Ffasz8bKPQHSbAft2Tibdgmo9oTVaQ7Rqf2T6c87Zq2Ct09zpcFJBbmzPJ
    7E87-lHYwvQpoooIQ>
X-ME-Received: <xmr:GlThZ8quX1memxzIqEPvkCeDUahnBdMqYfSDXoLmld9Be4Iagov99gOwHAdj9R1iWcYkw75jf6h6prts2dpDjKfPiO50Py5kx427q5GOieBjdaE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhm
    gidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:GlThZylU4pfQAf2Fk1X_Dlvn03loV7Zr0akujH_X-ziSM80KiNfW7Q>
    <xmx:GlThZ81vCmN5smygzvM0IhMARAoH0Fsr6k8YccvDW9bZn9HeWyzBZw>
    <xmx:GlThZ5tkxuNMyWsZ-p0t46ajMDgMlJvOoFUHX9Z1QF3VWYFIfqyScg>
    <xmx:GlThZ4WpXdWEVLNj-aPTouOJD4iTQEhhbny9Z8-MdgLSbW_YTI0V7Q>
    <xmx:GlThZ5yiHkqCqCfnUjDor0-WE2Pk_GVk4o6ZI6rRNGrBvZX4QvUEbsjB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 24 Mar 2025 08:46:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e98697ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Mar 2025 12:46:15 +0000 (UTC)
Date: Mon, 24 Mar 2025 13:46:10 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 13/20] t: refactor tests depending on Perl for textconv
 scripts
Message-ID: <Z-FUEhraLaDODbmO@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
 <20250320-b4-pks-t-perlless-v1-13-b1eefe27ac55@pks.im>
 <CAPig+cQdoZwY3u-xr49Jb8aaQmE69p4i4RUdy=cRv-V7VoWENg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQdoZwY3u-xr49Jb8aaQmE69p4i4RUdy=cRv-V7VoWENg@mail.gmail.com>

On Thu, Mar 20, 2025 at 03:37:08PM -0400, Eric Sunshine wrote:
> On Thu, Mar 20, 2025 at 5:37 AM Patrick Steinhardt <ps@pks.im> wrote:
> > We have a couple of tests that depend on Perl for textconv scripts.
> > Refactor these tests to instead be implemented via shell utilities so
> > that we can drop a couple of PERL_TEST_HELPERS prerequisites.
> >
> > Note that not all of the conversions are a one-to-one equivalent to the
> > previous textconv scripts. But that's not really needed in the first
> > place: we only care that the textconv script does something, and that
> > can be verified trivially without having a full-blown invocation of
> > hexdump. So at times, the implementation of the textconv scripts is
> > reduced to their bare minimum.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > -test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textconv' '
> > +test_expect_success 'rewrite diff respects textconv' '
> >         git diff -B >diff &&
> > -       grep "dissimilarity index" diff &&
> > -       grep "^-61" diff &&
> > -       grep "^-0" diff
> > +       test_grep "dissimilarity index" diff &&
> > +       test_grep "^-3d 0a 00" diff &&
> > +       test_grep "^+3d 0a 01" diff
> >  '
> 
> This change seems unrelated to the stated purpose (`textconv`) of this patch(?).

Not quite. The test previously didn't run because it depends on the
Perl-based textconv script. Now that this textconv script was adapted
to use shell scripting instead it can run, but as explained in the
commit message the output of the textconv script changed. We don't
really care for the exact output at all, we only care that textconv did
its thing. But we do have to adapt the test accordingly.

Patrick
