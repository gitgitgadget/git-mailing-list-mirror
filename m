Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EA4A01
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 06:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739427099; cv=none; b=TomHXjCc/UXYLpikz2xM52JcPysdohq/vujGRyjR8SSFurznvVv0WvXkbBTzvgsfqBqvQm6wuP1LXR3QLcpwlTjz7jLcEoUNvVIIc/k1OZVT6UXV6xM5TQWIE6wkjG7tdTXpfs5g4qovmzO4kOjmaaFd1Rj0xlFFXPQZd4cjohE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739427099; c=relaxed/simple;
	bh=NLn0PgzDE9B6P0Hl2Jv4H72QIitJ5LftC+ocsjzjhBM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZcG3Aodn/+A3apHwXhmA+TkxSq0RVcnwaBqTCyiB/8SIY/RrPPIepUuve10Tmg5xp0dLuWY6xj02ubEyeVjcEN/QimsS2UbnAaClmh1OIztp1dN8mnZHTlIUkUiifuwwoUmIHVdmWXbwFQQRnHkn8o+XiG/U/S8bQZ4ao5+V/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ramhwns9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BpVWJ3bm; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ramhwns9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpVWJ3bm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 6652E1140113;
	Thu, 13 Feb 2025 01:11:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 13 Feb 2025 01:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739427096; x=1739513496; bh=CQeiUXFTb7
	sEm3pr9uKJy4jnUbcLiPbx93u6QxlA0AA=; b=ramhwns9EXf3Ib2rHg+gUqBZFq
	qoCg8BiaJJD+gE7HlVr5LTkSFYmIG7Tb/c9Az/oTKljZnfzNbGhf0bg4CDBMmW90
	A4yRrbyu72gZMydP/R6LOziG9VrzlM4lLBl27tAFTQr+q059LoJc9O1PIeLMSVJu
	C8IjxwzQ2UCb24tWbtXrLn+fHv3vNmxP6lcE3pqgjqtF45rqJJJpZRHPcTIBJhuE
	iRR8B5rcVIQWIIHGN5pzaDVfWSjDFOXylwYgbMSmYC75b6158ur1UDULoBvfm/0N
	RVD9hvIJ/WRCJ7eOWy0a/ZlIPIS9i7B0fEkzGbOezJEn+IDQyh5VodhhValw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739427096; x=1739513496; bh=CQeiUXFTb7sEm3pr9uKJy4jnUbcLiPbx93u
	6QxlA0AA=; b=BpVWJ3bmK9KFpySSOayB5e4CCs595p3SYKbgexG+mHXYxmIfmHR
	ybxGm2oTZpTvQ9+dR/srFN1KqeyB+Pm8vvm3y5CC82lN6O9PZGC2mT8YXzJkvg9J
	oveSf9anDrtA39fpcgDVLg4Ao1VS5V/Cd26x1eRgpWgGQtmlKjaUV6Ejz6QF535L
	/mfFzCyz1f7aaQ1Ngzu88TlnFWfnUUSTjLScPaYZKCdmcnL0L5jCUU5lcVK4rsTi
	dI9YCG+e3UTGfVnOOIyLXnqPhcUtf/d+ZHItIPb73r+HIL1wc55/slAfGJQz7gxv
	zlrCJLBJSoEpoyjt8RrUjwLgCaap5xCbqWg==
X-ME-Sender: <xms:F42tZ5-67iVrIAldCigiPHFQ4bdKzrT2Dib4SrLr-K88lRGZvFdILQ>
    <xme:F42tZ9tr2tZ6CIkT7A6Ub3PBTaTeWRhW1TPtUOXnF57KB2HUUFGMSe346T3Yu2oeJ
    YzDmmUcFnxR4EllOg>
X-ME-Received: <xmr:GI2tZ3AGKwdQAkECFTb4v7tKKlibYaYaNgandule_IxCKXKXnUXvH3KymZJkG_10vcz1LOWOjzYWRYxCgZs5DwqmoCQnXDDbhjqOUT1Msy97Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegiedtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepheekfeefgeegvdegvdeffeehtedttdffjeeuffelgffg
    heefleffleejvdefheeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GI2tZ9fJPQn8nFqU3lx1jeHqQMR-EFY9GUcmyV9R9_Q_9lxxy-X70Q>
    <xmx:GI2tZ-PeHTMqi3D9MU4LW8u7qqbagxplFvAJaNWD5hfgCiDhN3NTpg>
    <xmx:GI2tZ_l0Im54Q4_fu9QiRT0nbxQ1DAQBBO9-aEWrE71WkN6R83uVfg>
    <xmx:GI2tZ4sV7Q9lJWLUjqfTUzBoHg2JH9sPATyE_MDyvYuv5XeC-ah9Cw>
    <xmx:GI2tZ7ogvQ1SKtmyWbzDwLaS24y9lMmusQuaNrHsPGlQLF8kySmON0V->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Feb 2025 01:11:35 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ab8776bc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Feb 2025 06:11:34 +0000 (UTC)
Date: Thu, 13 Feb 2025 07:11:33 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <Z62NFXja4CkrxSil@pks.im>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>

On Thu, Feb 13, 2025 at 12:01:59AM +0000, brian m. carlson wrote:
> It takes about 30 times as long to perform using the reftable backend,
> which is concerning.  While this is a synthetic measurement, I had
> intended to use it to determine the performance characteristics of
> the reference update portion when pushing a large repository for the
> first time.

Interesting, that's an edge case I didn't yet see. I know about some
cases where reftables are ~10% slower, but 30x slower is in a different
ballpark.

> I admit I haven't done any other particular investigation as to what's
> going wrong here, but the behaviour is very noticeable so it may be easy
> to profile.

No worries, I'm already happy to have gotten the report in the first
place :) I'll investigate, but probably won't get to it before next
week.

Thanks!

Patrick
