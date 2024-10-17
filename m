Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35011DC1A2
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729166303; cv=none; b=Sdq8TqJwj3LdijM7L6WHwHk5XL7dM4dKNAu2kBBGAQRD5rFNgTCzv4UsGRJzBx2On9OI4hysFEQRXAS/+JHH1w0E5iRYdnX6/Ec+4lARkYk1WCvdjfk2Nhds1r1OqHUIi3eZyJKUUmPYN9KSkA484UDkFqGQm4kna1t3Yz12+Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729166303; c=relaxed/simple;
	bh=aI865skXIkg+X94VEjod4C3uMsvXajS64SsYj97ac7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6A1aPNmn3wPTlzC4LIO1i9Te5ZWo+OMwX4Onx+l6rhz4ZeBA3Gpc+681RiQhN0tLC/40VEeQ+1wKqNCS/NqL9DjX1LKgA+4JBL17NGqF05ADhDS/2COnHTE4fcJaW48Tw5ZCJxsG/Db9kUgovILKTt7Z7h6YoGv3pFETZd7Z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LNX60f8t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a4sQC92f; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LNX60f8t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a4sQC92f"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id BF18211400B8;
	Thu, 17 Oct 2024 07:58:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 17 Oct 2024 07:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729166297;
	 x=1729252697; bh=MXeo/P0mQVXNSkGNkQ362uf5BRwWKB22GjfE8FSiDtU=; b=
	LNX60f8tQVWXCqE73aTKPc5hXwt2mcskf/+CN10n00VmzVAp9P5Zm/QRtesXjizA
	bb9RpbDBtxwp16GRuuYsIw+75sL7aEd4uNmAi5VJEw9pFUC6iBtlJhtJDx4rGK0/
	aY84OIYIaDIRs5/G4jPBWXNl0jmGNXaoJJ5Wl/u6KRw5aKZVfwxOG2DWifbXLPY1
	QKtFDiH8XGnYN3Os3JPUs5FpFbAa/1T4jKAWM7GxtCh63Rj0nXjTziVG5vGp3s5T
	SZPgO7riT9EhBNa9UO3HZZT3F4wuRIyTlUv+UbxO5pspcc1EEab9pYVNqlFih3fh
	3e6QqNHkvnhdoLvHZNuGew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729166297; x=
	1729252697; bh=MXeo/P0mQVXNSkGNkQ362uf5BRwWKB22GjfE8FSiDtU=; b=a
	4sQC92f/um38ywgFev0eIH5zk/G03K1BbHNCeiI8hNT9mM6l/yHVl+HZF9kiVfbU
	UCY4GzxS1dT112Ey+HVB3HOj3Utue0FVfZkX1od/P1GjYnlzq4lWPoZx9QZ/sFmz
	WABXqDggCM3rtwbSHgcTVNrVRaVCkWMaBzLdm98/GWsvpt8i0ReqhNNY24ciyRzA
	IYtaHQ7eePs5stQIbG3DiuAnNuf7VJJ3vwTeV97YIyVWAIQANPr2ZFsF4JyrvrG7
	1aK84PU6jRMUUlqmM/W84Nh2j7MhxyWLdub60+t6xHr8LKxUhKlWjnRZhGqBqYJz
	dOVPHQIkNsz/N+/bjGEBw==
X-ME-Sender: <xms:2fsQZ-bswZ6ghr8a8izJu_JmiWb2HOF3PNe2qeEgH3q96-zRzZydRg>
    <xme:2fsQZxaeZvP0lQnyvgFRcgUU7fpadYaJJ5m9nYhs5Olp6U70dZ5XZ6ABveyYvAre-
    WRPtJyifbbINolQ9Q>
X-ME-Received: <xmr:2fsQZ49rYZyrKz9ynRD8GJ-wYXey3lgxDhQWa_SrQS1O6i8q4tfy-vqXiZqJSOkFx-Qcet54BGgeiWctUIkxmM5uhUEQ2mt5I6sjm1reZINHUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepfiholhhfsehorhhiohhlvgdrshihshhtvghmshdprhgtphhtthhopehm
    vgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:2fsQZwqy1IqK8PIEmsMaczL5_Stvju43BgkZojcHQPm1e-TeCidcww>
    <xmx:2fsQZ5qOAD55BttEHeuCMyTXMaMcG2CCsAgJLThRnLEqF6o5q6ni6Q>
    <xmx:2fsQZ-SvOWmcpFlvGNkbQkGNOVAfzN3cLdN6Q_7dFEY5XhTWnbk8gA>
    <xmx:2fsQZ5pNZPIEDkp-ySC3OeZULmoEvw4Do0Ns8rSi4tIAQV2lt-v3JQ>
    <xmx:2fsQZwWuSlKI6LcHquE0icZi_asO_0jo9GFPp0Prn77qRqMmfPgayKdd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 07:58:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 577de63c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 11:56:52 +0000 (UTC)
Date: Thu, 17 Oct 2024 13:58:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <ZxD7j-ciyAGHrGwM@pks.im>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <20241016182124.48148-1-wolf@oriole.systems>
 <20241016182124.48148-2-wolf@oriole.systems>
 <ZxASXLz4lA+E9MuQ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxASXLz4lA+E9MuQ@nand.local>

On Wed, Oct 16, 2024 at 03:22:04PM -0400, Taylor Blau wrote:
> On Wed, Oct 16, 2024 at 08:21:23PM +0200, Wolfgang Müller wrote:
> > Whilst git-shortlog(1) does not explicitly need any repository
> > information when run without reference to one, it still parses some of
> > its arguments with parse_revision_opt() which assumes that the hash
> > algorithm is set. However, in c8aed5e8da (repository: stop setting SHA1
> > as the default object hash, 2024-05-07) we stopped setting up a default
> > hash algorithm and instead require commands to set it up explicitly.
> >
> > This was done for most other commands like in ab274909d4 (builtin/diff:
> > explicitly set hash algo when there is no repo, 2024-05-07) but was
> > missed for builtin/shortlog, making git-shortlog(1) segfault outside of
> > a repository when given arguments like --author that trigger a call to
> > parse_revision_opt().
> 
> Good analysis.
> 
> > Fix this for now by explicitly setting the hash algorithm to SHA1. Also
> > add a regression test for the segfault.
> 
> Makes sense.
> 
> > Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
> > Thanks-to: Eric Sunshine <sunshine@sunshineco.com>
> 
> In the future, please ensure that your Signed-off-by is the last trailer
> in the section to indicate that you have certified everything above it
> (which in that case would include your Thanks-to here).

I think it's also more common to use "Helped-by" instead of "Thanks-to".
I see you have the same trailer in v4, but don't necessarily think that
it is a good-enough reason to reroll.

Patrick
