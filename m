Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C78E26A0CC
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 11:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751371102; cv=none; b=r5h5AfdvHuIT59C4Cv2G+xsks+23DEWCUaOnNIcufT6Z4NPcnGLqfUoEvzMilWJpKF2RfrojLqvNsoiBbsaiY4CtfPodzcedo4kC6o/rARW/DFGYpTO5kREKKvyRN9RjhyoMqoVaFCovNQGwMlXsOW2f447rP5/63DtBPPkhimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751371102; c=relaxed/simple;
	bh=hOqjYmoA/H+KoLSZb5LPUSp2ceJXaCdZH7Wqnx3jmxE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XI8irDbvPnpP8wYvlPhiYLTJ3YCuFWxPBxNCFPIuElWwIYdetoJWsCVS2jdFwy6W9cFiD1UwJ3+023LbxvmCMFbgMfiMAJxkWlVCVL57Gd8SZQGVOsTkNvBbKSsIGdgdUfbhska2aOmnmBefaqHnhLeP/+vtvCWlny8y///UG6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qHie1+P8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JLkSMCd0; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qHie1+P8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JLkSMCd0"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CCAD7A0130;
	Tue,  1 Jul 2025 07:58:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 01 Jul 2025 07:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751371099; x=1751457499; bh=unN1cedvCQ
	/y+TiMz+8kNNd3Rz6a/u0QavBh5KJlCfg=; b=qHie1+P8TXPJZvDbCIdWKiuwk2
	Th4higpevtsZeduq1T96+6aWnxn6lEICySU2p5hyyWEgOSonm+wpjB0atw7F2jVq
	gBbnXhzEulAHLoRZiTu8iCoAFpoJJp2mhxfwEhZt22f1xvifPPQyTF8PuLRVlOm8
	43e5M+q4kRjzeeyAph5LInhl2dBoGxgIbs9iXG3SLQmaLV1bASfHxT92VDmCUQeI
	l9vfzj34YdvrzeW+EyJL3oq75/s6p7BJaYElmJ38LaTcSpTO/GPkbtXDOkRNTrlX
	lPkIyXzpJgp5wKUA/BqJ2wq7EEvMxtzjqgXcDdCor+0sYK8Tu6YhAKP/Cn9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751371099; x=1751457499; bh=unN1cedvCQ/y+TiMz+8kNNd3Rz6a/u0QavB
	h5KJlCfg=; b=JLkSMCd0YjB+rUGlwxcZ5aKmvFTCV6BraxAPj0wnIwSrRQYhqMS
	lBn3TtIVnk8CHgUj1Q67sQG67tGlHRFZP14b6yyQ1KV4b609JAbyBmAfRzG82FLM
	btXwtmQmcw9Y2b2hWUUKDpMT4YaKH5WEn8PLX3NZLMX3J/wqXlMChPfGZ38GQxW8
	4klR16/6DnqjPvVHcDRvHIqFOdeCtxLoeXiCJjDOV/9xQgNTOV9uPQ9Lt1SS5Cq2
	W6qrlas1LU6RL37PQZLr3H79tbYmCKC+2/VYe8NZgmPmoMDtyGlGxYOA564luwQ/
	31+mb4biPHSVoQt9gdc9sg/ydf/8yzOo5VQ==
X-ME-Sender: <xms:Ws1jaN1x5NQYyKsUMtlob_yKvuOz24gzqbE8pNXnsXWrm4vTMPi96Q>
    <xme:Ws1jaEElQ8lbw0bqI-QQxy9_v4-cAX1QSdtejPrxIvggmCfpZ88r40Jwh3aZgF8fg
    5tQCDDzZryUnddqXQ>
X-ME-Received: <xmr:Ws1jaN6aW7KLZ1W-BoHrnJREHIlWG5_HSrCADEElhIV2LZIi7RTZWak1f4QL06Y32NbZ8Xg2WUr-0rXCCne5EjoOzSTvz6mDYr1gQuOxlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    dugffgtdffleetheevkeevtddtkeetgeeiveduhedvuedvueejhfehveejgefhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehhmhhoohhrvges
    qhhumhhulhhordgtohhm
X-ME-Proxy: <xmx:Ws1jaK3Qr8s6gWMcmz50aEs560Ua6xZ23HCr3GaSc06MyjdSZbev0Q>
    <xmx:Ws1jaAEMF1Gq6mZQ9FMuXhXgdrIU7jbyYMDzqQWkszv1sMU-Sfwu7g>
    <xmx:Ws1jaL-ea6uvzIbgA6CZnIZ5qjei1W-MAKYB1vJJq-YzZ4Sj8NDLDg>
    <xmx:Ws1jaNnCIxrUsrNbxhTDOmFrfic_DNTfoGYKdz_pPL4jZmf3mSgHQQ>
    <xmx:W81jaOGDA41fpxrfxqNwTkACY5wMM80DC8rdMM_iZQCE7MyqWJr_jfwk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 07:58:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6be53135 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 1 Jul 2025 11:58:16 +0000 (UTC)
Date: Tue, 1 Jul 2025 13:58:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Haylin Moore <hmoore@qumulo.com>, git@vger.kernel.org
Subject: Re: git only writing 4k at a time
Message-ID: <aGPNVRxZQiFpCIFs@pks.im>
References: <CALnKHDCH_174KnP6Um+G8YCpDBGNNk40xS0T2K6VtnDv9hE37Q@mail.gmail.com>
 <aFM9Uh0K2TSAuoHb@fruit.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFM9Uh0K2TSAuoHb@fruit.crustytoothpaste.net>

On Wed, Jun 18, 2025 at 10:27:30PM +0000, brian m. carlson wrote:
> On 2025-06-18 at 20:58:52, Haylin Moore wrote:
> > Hiya list,
> > 
> > I've been investigating some performance issues around git clones over
> > network mounts. We have noticed that git is only writing 4k at a time.
> > These small serial writes are making it such that even though each
> > write is only a 3ms operation, the total time balloons. Looking around
> > the source code I found that reftable_writer is initialized by default
> > (though I cannot find the block_size argument being supplied in my
> > cursory look) always to DEFAULT_BLOCK_SIZE (4096). Is there some way
> > to increase/configure this block size such that larger writes happen?
> > In git/Documentation/config/reftable.adoc this block size is mentioned
> > in a manner that almost feels configurable, but I'm not sure if this
> > is just internal for development.
> 
> It's fine to adjust reftable.blockSize upwards if you'd like, which
> controls the block size for reftable writes (which is what you're seeing
> if the writes are from the reftable code).  I think at least some
> versions of JGit use 64 KiB for various reasons.

Yup. The default block size of 4kB was picked because most filesystems
use it. Google uses 64kB because to the best of my knowledge they use
Spanner to store the tables? At least that's what I recall from past
conversations.

> As the documentation describes, there may be some performance penalties
> during reads since more refs will have to be read, so reading a single
> ref will likely be more expensive.  However, you may find that
> acceptable and you can adjust the values such that they provide the
> right balance in your environment.  I would definitely recommend a
> power-of-two block size, though.

So this kind of depends on the filesystem's block size. If yours uses
bigger blocks it's definitely recommended to adjust as needed. The block
size is ultimately a tradeoff, and the best value heavily depends on
both your system and on your use case.

I'm curious though -- are you sure that this is actually the bottleneck?
Reftables are only used if you explicitly opted into them, and I would
be very surprised if a clone is really slowed down significantly by a
clone.

Patrick
