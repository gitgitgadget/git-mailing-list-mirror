Received: from mx1.catap.net (mx1.catap.net [162.55.82.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515CB1DD543
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=162.55.82.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758303792; cv=fail; b=C2ACoBhgpS2V7RjJys5b99WfdHSeHI8IQ7D5M27Gk/inY+dQk/QOQlpmwm+W2Dq5Zq4VpGOB4hoXA9ectYw/WFOd3/1Nr+UYVCfH5FPAcjZnczJhuU/ZQkbGontm9Ej7nvFif4kGTt90ObRt+l3sIjSjmK1hqglke42pTxQl3Yg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758303792; c=relaxed/simple;
	bh=ISJcCjoPOJx+FK+w3pVGwvNlW1yj96ps9y7MYNY4fx0=;
	h=From:Content-Type:Mime-Version:Subject:Date:Message-Id:Cc:To; b=EGruIZlOuJ6evwPXwckGgjj3GnSvX9OHwwXd6NARLzVa7gNnruw9ZYLYtxgiXH7lIvzcHxK30vmUCrRhZypq0HQlSPInqbdpdmFjmPFacwQDPPPs+XkER3ASgGDQCixvkrrrtc4692GUmKaix5YO6Rv8MroSi9sDjArW59+QIMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=macos-powerpc.org; spf=pass smtp.mailfrom=macos-powerpc.org; dkim=pass (2048-bit key) header.d=macos-powerpc.org header.i=@macos-powerpc.org header.b=eAVMxvv/; dkim=permerror (0-bit key) header.d=macos-powerpc.org header.i=@macos-powerpc.org header.b=j8g3oTsv; arc=fail smtp.client-ip=162.55.82.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=macos-powerpc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=macos-powerpc.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=macos-powerpc.org header.i=@macos-powerpc.org header.b="eAVMxvv/";
	dkim=permerror (0-bit key) header.d=macos-powerpc.org header.i=@macos-powerpc.org header.b="j8g3oTsv"
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=EIoMNxA
	q7br6TNAMs2svR/gduYQi8A09+C2FR575xlpr2X2ahxDxMIAKEGyQVPZ+R4IZRJ9IrCR5v
	mmdujGjknZfRv2TmsQXSqvNBX1D6fr77evJ6fJSkPgf9+mGjhMU9MUWsbTwfm+JqSeHP9V
	m5qOR8vRpZCpTnaT5GI4vrP5JE3FyV6hF58mE59MSGVbfHgngLzBguYD2qqGw+Fw/4BGlk
	hdzN2pPVXxrZBiO3k6oTdonoul+LexzIENi94bmJhQjGaV2LHUFNhRGVzIB9qgrFL28Oek
	lF2W+WVAZfMcdwEC+VaWLRi17I+UzJtW/qqWnysQM1WKFopvJN7g2bw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=I
	SJcCjoPOJx+FK+w3pVGwvNlW1yj96ps9y7MYNY4fx0=; h=to:cc:date:subject:
	reply-to:from:dkim-signature:dkim-signature; d=mx.catap.net; b=v4hdGlx
	yIQMNAQYlNv4A36HamtgvNCYp5HATejfwcb2SnLfUuiRoSjvFKfm/sBmRXvaiskENtWgbp
	anjgLwPWM1wS9JZclyDx+8xFnMwNyHDcM58LVC93kkEfp7Gum0URIkpjTumumkbPL8yO3m
	wgSDwkAN4IaI61ss40zAAjh9lXQP1NsDLEsF80S1a+iF0rVL4e5YoK/jxj6xmw7UAfk70e
	k6XTQWKKkyuU5z0HePf/iQ6EFydIDsxac8ZRq1ibUusaC1/Ugf4LL2zbvSDO6lBhnSS6L1
	SG9KQn/lUJHiwOb470b/Mjb7Usl1nB/A8y4Bupdxvh/Zyi3zeb/rlfg==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
	header.s=20240125rsa header.d=macos-powerpc.org header.a=rsa-sha256 
	header.b=eAVMxvv/; dkim=pass header.s=20240125ed25519 
	header.d=macos-powerpc.org header.a=ed25519-sha256 header.b=j8g3oTsv;
	arc=none; iprev=pass; spf=none smtp.helo=postmaster@smtpclient.apple;
	spf=softfail smtp.mailfrom=barracuda@macos-powerpc.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=ISJcCjoP
	OJx+FK+w3pVGwvNlW1yj96ps9y7MYNY4fx0=; h=to:cc:date:subject:reply-to:
	from; d=macos-powerpc.org; b=eAVMxvv/hxREGpYpZywOgHYkYclYSEKRvNdVzAlbK
	HiW8OWfJIPMZCg53uK56iXgt07iXX3VU+b6gDOtmygIY7jmynuRrYXc1JABWrVFioLGChW
	Ayg+O/MM105x++L3bDK6NdAQVTedQk8WXmidMAsEdcxUmPUl1XOf2j5PA4Ruw1O1C8olt6
	GPV/Bl35KoeQ84c9d7XG47FeSVuqdODa9kBSsBu/C8e7vZ9+TVFTHv8NazQ0mLa5fEqlzY
	ruzM1Dtbr7348MDymIelEM6i7xHqZZ0FSTz+JSS7LnS2Qyf0XNNCIjSkGvG6B+Cftyi0A+
	OqFsBKy2bBFvUh5099g5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
	bh=ISJcCjoPOJx+FK+w3pVGwvNlW1yj96ps9y7MYNY4fx0=; h=to:cc:date:subject:
	reply-to:from; d=macos-powerpc.org; b=j8g3oTsvZPHSiQQ2nRaTIU1ZlLPQ1Ogj
	btFPzQnggAINweUiIhCQa4gfQj+MbJD+SlHZ2kiGnfZsSNg+FBU1Dg==
Received: 
	by mx1.catap.net (OpenSMTPD) with ESMTPSA id 048da4b1 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
	Fri, 19 Sep 2025 19:36:29 +0200 (CEST)
From: Sergey Fedorov <barracuda@macos-powerpc.org>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Reply-To: 20250904-b4-pks-rust-breaking-change-v1-0-3af1d25e0be9@pks.im
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51.11.1\))
Subject: Re: [PATCH RFC 0/3] Introduce Rust and announce that it will become
 mandatorty
Date: Sat, 20 Sep 2025 01:36:08 +0800
Message-Id: <4C760AB2-C102-43A3-B0B9-11E248F3FCE0@macos-powerpc.org>
Cc: Johannes.Schindelin@gmx.de,
 ben.knoble@gmail.com,
 cb@256bit.org,
 collin.funk1@gmail.com,
 contact@hacktivis.me,
 eschwartz@gentoo.org,
 ezekielnewren@gmail.com,
 git@vger.kernel.org,
 gitster@pobox.com,
 me@ttaylorr.com,
 newren@gmail.com,
 phillip.wood123@gmail.com,
 pierre-emmanuel.patry@embecosm.com,
 sam@gentoo.org,
 sandals@crustytoothpaste.net
To: ps@pks.im
X-Mailer: Apple Mail (2.3776.700.51.11.1)


This will be a disaster, please consider not making rust mandatory.
It will break git for all systems without rust, in effect killing not =
only possibility to use GitHub and other git-based services, but also =
breaking build systems, since many ports =E2=80=93 and package managers =
=E2=80=93 rely on git to fetch sources.
As for local version control, git could be replaced with some =
alternative (likely inferior, but at least that is not the end).
There is no replacement, AFAIK, for build systems and for git-based =
online services.

P. S. In case anyone wonders, this is personally relevant for me: I =
won=E2=80=99t be able to continue contributing to open-source anymore =
(at least certainly not like in past years) with git being unusable due =
to broken rust.

