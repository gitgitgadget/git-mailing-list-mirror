Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBEB2FE562
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755772181; cv=none; b=Qa09USWEi2Zq6ktmIszmvdO5vAnSlrpclYD+7v9/bBSmTN+yp1IaLpOra1YCXgGuIWc8JbNDqRPmrXJaHDQyjeC6ltmDrNuSepZ/8RGwiIEJ3xu2rj+Q6ogYmtezF1l5zSdnJbR2Ef+koxSC/LdYwDCsZ0EV9HfXT2MUHthIEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755772181; c=relaxed/simple;
	bh=K4jxtTetuIEXnDdp2SpIsYw+aMmyp55cbgePSTW+5Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6UQbT7M7rL5GgLvpZAcp0AHFw5t50Z+M0ydxyCLgUbcxuxamI7EM5L2bREHVOTc6ChNGjpf4ti6BFWR0tyg2bLzLL18Izkhyjtg94ipd8BV/S0zdF9taE4XmALxQwkCCob7YDm0xRN+vUIh7CYf1JwavHw4O9pZxiEF6260IC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Qcm6KLZj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XyPvtwy2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Qcm6KLZj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XyPvtwy2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 9EA3DEC0170;
	Thu, 21 Aug 2025 06:29:35 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 21 Aug 2025 06:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755772175; x=1755858575; bh=v1Hfd0EjF/
	0vvgkmoAJD5rvjsPDFirLgaOoaiBrNWbs=; b=Qcm6KLZjklwmVi5Rmw0Z7o+7O7
	QAHkyiQnXIz5ATrq6FyN+OfMp49wNXXXReSXc5ISB1dwNmmnQAEIxt4+52s880kD
	asnaK2/d/2Fcs8Bn5a5yXiqX5GfFPqewvIDNSToFObxjdN0aaFlpQGmVf3BpV0Yc
	YWZXd2ZuUco2rC5X36SaoE7A+VkyCW/DXnup9ZyP/iGGYPhm8nktM0UwSGV5QOmG
	KJnFXpHtbFGZR76iumP01ERlVgasoCPYuPhH+QNgr+n+e7nrh1IPjJbcNtRrZ3yz
	9s1ssRC6XlH+jtFpHUw3/aofIBO0BrzM93WJxOnCzbX4Z1OcfSXB2V1aAtew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755772175; x=1755858575; bh=v1Hfd0EjF/0vvgkmoAJD5rvjsPDFirLgaOo
	aiBrNWbs=; b=XyPvtwy27kZ5VYzewBMOXXisBsdcQhufOXMIMv8hNaMtFu8+3iN
	nuQl6h6EEhrZD2p7qUrm02xC5HMIrsTEVoteOeZv0IVLktgaUKM4McLhennKDQR1
	9zdm8rR1k4JIQmk+FUr+0iXONfHLbxE8OLjfm8hR8hL88akwjxT3i/CLXurIyomt
	Fn6LHk/sFirSboqx63ghaQw9INf9RzgVm3BXDAZY4GRzzenlBJZ9lpoo7eNQgw9c
	QeTFIMpOf9+FuSxYJ/kGs2318whHAN4Y6cG6718u/8g+5z5I+A/C0DI3TWn7RFFE
	obyZtX571k0iUf2NQUTLkc7JBw1d6pv3oYw==
X-ME-Sender: <xms:D_WmaP5oRaamU0_Fd-JtvXXWDVrZ3qtAwb_ZJP-w3n4_bBLUA6VS6Q>
    <xme:D_WmaILwh2rZV9U_cwncMO4DWJljgJqwa2qdyXJhveQgw7taDWwG-HVAPg7bbPDqN
    44Uam8pBU-8ZrSwOQ>
X-ME-Received: <xmr:D_WmaP62mNrhXTBXke8cMW19onTIiN_uTi58Yac37RDBsWjtExZui3vK7Pm9aCkamfI742VJFwbky0m3b6JvsPUJu3lUayRtBpq5PvDA9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedutddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehluhgtrg
    hsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:D_WmaLyZ96dpUs8m1X522j7o5yWMQgDnQmkBR3NmDzKsh2TqzMPcOw>
    <xmx:D_WmaDbebMSDSjkoanpE2rSfwu9mm8JMKdFDAv62-58-6ovxX_xWZw>
    <xmx:D_WmaNQqmo3QGmKmmMNMJHFnHjazakLnsh2E3oIzpNjSl2mCsJmi8g>
    <xmx:D_WmaNx0vYNx7h3NcYg_E1XGUOJc9URASsBRGNRwdXVWZMLad2MVWQ>
    <xmx:D_WmaNHikgNkFjhYSjyZtLe1WP2uafrfSgmBN7WvO3vuodvYYVNfMual>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:29:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0e7b525e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 10:29:34 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:29:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com
Subject: Re: [GSoC PATCH 2/2] repo: add the field objects.format
Message-ID: <aKb1Cw-SuS2t0CqG@pks.im>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250820144247.79197-3-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820144247.79197-3-lucasseikioshiro@gmail.com>

On Wed, Aug 20, 2025 at 11:42:47AM -0300, Lucas Seiki Oshiro wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index b2ec66e454..71ddc5e8c6 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -49,6 +55,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
>  static const struct field repo_info_fields[] = {
>  	{ "layout.bare", get_layout_bare },
>  	{ "layout.shallow", get_layout_shallow },
> +	{ "objects.format", get_objects_format},

There's a missing space here before the closing curly brace. Other than
that this patch looks good to me.

Thanks!

Patrick
