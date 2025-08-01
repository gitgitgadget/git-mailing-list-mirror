Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EB926E6E3
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059466; cv=none; b=qybsACsa/RImpONsXdFp7PzCFaQrY1jlTSNAzAwIhv04E66PGiVfobVZ5Vug+v6MdEEHDqnGkB1fO3a49gF/v+HwZFlhgIfTwCJepvlQ1MV4cwAzQWBwRvv/tklFDHj4Q00fsvXscpL0yDWOTmFWcjNRrkCM8+GQHcClRvQlqVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059466; c=relaxed/simple;
	bh=Tl0fvQitXsP3+sntMl4v2jZ0d083ccvC0rf1z77v/YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3pkAoNNpkewCTl+exeUAfyBONu2VT9v5ay5vDrBxuS/PEF7FNJmHpq5ZTPWpucesa3FAKSdHbFTMUSSaeGS8f3CIfAYD/WNT9N00ui3X19sADfkBBaU9AEFXmNE8S9+kfXcc1EhG+BK+Blxb5cla5/b1drHAw/9/CxZMgWlzso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LrdJYQo6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EjUbHfCW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LrdJYQo6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EjUbHfCW"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0968F7A01AB;
	Fri,  1 Aug 2025 10:44:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 10:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754059462;
	 x=1754145862; bh=Lg3LUKBUQ5/2Hzsr+Zl3S/c4qaqWKH67RAvjAYoiznE=; b=
	LrdJYQo6aNWcnYfLYm4zgu1wC6QWoOk5e6QP81gV1XUUF6kuA422/4Hdm0PXqTLR
	sqIzabd+00nFT6mZ9iFZMi5hZI1jemo4xuHrMjc0USR7vohX1G16UclAehMEcvCo
	CSeypFTe9Qeik1MyeEkaxfEf8U9MJWELGIdyH/VCB9ipyNVJixWV93EIhKP5VJIl
	3arWyYti7Wn4v/TmQmVCJMkJcdybdrLKyicAduddWrL252rZFPpp0O7gECYFuW9/
	s8KvcWFdyWi1JPORo1QiRDI6enQk3bL2EU+j4WWydFEBwai62EEHS/Q7e5P+LFnP
	DZSVY8VP1U6T1GAmMN6KsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754059462; x=
	1754145862; bh=Lg3LUKBUQ5/2Hzsr+Zl3S/c4qaqWKH67RAvjAYoiznE=; b=E
	jUbHfCWOLqiUWuXsbpsPdPeGfcFOb1Cg1l/+VXm93swddCQqnIySc9DK4m8mVJWq
	4ZHCMk65WEMDA6D6W3D5XMhRuGeIsUc+6yj+Fu+KuYlz8TJpeqfH27zXpcWAatZm
	Lqn14YeYPB5PpNPj9i0VU/cG39U1+MjSF1y1IzRnpbUxsHhLsfsv4nalFli6Db7P
	OP1WCd4w5C/2ejpjd+3P4P9nVWNqn3o9vgd1MYfpNgl6sqW50f0++0Wqk+EYfNBj
	A9SZ1qvCCVVVb0WRUbogTPqG/NPXHFqz4MEJmq9fkMNR58j9XSY1XpW8ptlDiZmF
	ytw7zQItWCd13/p+hnXxA==
X-ME-Sender: <xms:xtKMaNJmSbcGRCGeVd6p3I6lOuJgHCDCbu26H7_3IRXdpporWmCi3w>
    <xme:xtKMaJVpghaMW-RLTEL9X2DanV15dyxFnuEr9xzvDik5tjwRL7pw7Nrj6aeGMcphg
    5pSmTdIUHPHhsRucQ>
X-ME-Received: <xmr:xtKMaHgbmXNXJm_U-GINIhwQtNxrHTPc-QkXfwcrJX-av9L31nWbxvhKn6I_bsc5-B4PVadYfRuwDh8bDnX8OgOUuc9AbqtR49SGNqtztGfR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtih
    hnsehmrghrthhinhdrshht
X-ME-Proxy: <xmx:xtKMaM__RBPXRgMaRwuLGmyMiJWX1BAJfKxERDpBH5GRMkzVWYd7Pw>
    <xmx:xtKMaJDQoCS0mCiuVUAFP3VLwPbeDmvEOacKw6Hz6W5e9sa6DFwagw>
    <xmx:xtKMaBLgLhSpUuAJ0nsJCw-VQ9XczpLrNI-5S1TRfg63amT6TiXO9Q>
    <xmx:xtKMaEmLr5MZhhldxmOtCtzfsVzfechH0wliSeRaDNBA16f1_7glbg>
    <xmx:xtKMaFHauuevhjjNpPMIqBlIFDO7gm2hbthOq17sp0fVKWq_4muPIlgb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 10:44:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19027786 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 1 Aug 2025 14:44:19 +0000 (UTC)
Date: Fri, 1 Aug 2025 16:44:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?Q?Storsj=C3=B6?= <martin@martin.st>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3] meson: Tolerate errors from git ls-files --deduplicate
Message-ID: <aIzSun25-RhmAfOd@pks.im>
References: <dff715f2-9d26-148-5046-6b7190b9414f@martin.st>
 <20250801102554.1904715-1-martin@martin.st>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801102554.1904715-1-martin@martin.st>

On Fri, Aug 01, 2025 at 01:25:41PM +0300, Martin Storsjö wrote:
> When using the Meson build system with an old-enough Git version
> that does not yet know the `git ls-files --deduplicate` option one
> can observe the following error:
> 
>     ../meson.build:697:19: ERROR: Command `/usr/bin/git -C /home/martin/code/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*' ':!xdiff'` failed with status 129.
> 
> The failing command is used to find all header files in our code
> base, which is required for static analysis.
> 
> Static analysis is an entirely optional feature that distributors
> typically don't care about, and we already know to skip running the
> command when we are not in a Git repository. But we do not handle
> the above failure gracefully, even though we could.
> 
> Fix this by passing `check: false` to `run_command`, which makes it
> tolerate failures. Then check `returncode()` manually to decide
> whether to inspect the output.

Thanks, this version looks good to me!

Patrick
