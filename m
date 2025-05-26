Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5A71DD529
	for <git@vger.kernel.org>; Mon, 26 May 2025 07:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244239; cv=none; b=s99vjJk0mfPXrB6tKQgg5VNGwduU0Vc+nMPCU9Ouiu3gp8tXwJOK3Z2kAtIiHrtMGzyvCIyBmTtS5BycsOzRfkB9Cb+ypK6DaQVwrNzglGTr5PIV+MkvOSSkEZcDR5W4W/NY7QeO8hahAFudRYaa79bAiv+l7NEPVEcRF0BJZ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244239; c=relaxed/simple;
	bh=im7k3Cr976M73AQF0MWSwI3dB277uHNVfGA8IirKwvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZtvaCr2roQRP6FdMs2MlU01Zzmt0yXL9xmvUf1IqjvNWBmMKwk3m6CFZJV7/5SX0Z7EWpLgDkbbms9e5EbeaMfvIOlwzM6v4kl6cpPAjAWTGiqVzzng668DHJHh3sEz4YfwxAEQkGttz0uoYyyZXgN/OBwug9udVtqnFSO1nC8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JQPzxIbJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=InkKiSc6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JQPzxIbJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="InkKiSc6"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 2E505138046A;
	Mon, 26 May 2025 03:23:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 26 May 2025 03:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748244236; x=1748330636; bh=H/3/1KMPaz
	cSq5+Erco9BmMfIbwiZjaP26r5K4qovM4=; b=JQPzxIbJfuUK9AmSsUYQK68MQg
	Z+mRKqgw1Zzm7yRdJF5c7k4pJp13/kHCcuu3uiGtQHfSUWwMtHelB7ogGWmSSLmj
	WYyt+zVoBqAZdxA2bmEEycn7dJBLbxdg8wCB3SgxJ7ADlI6hwO3+bL03nzr7H9/Q
	xb6Tc6bU7n4FbHzPDHZwOkSxiiy1C1jq0TICc6NJmWVmaEkjzJ7DXYjJLzYzHu3G
	J/2hCJiSOxT76LhDccc4OCc74nr5nFDaznhwsGr5/ZHVUuLEzJ1jBMP11jz5njDO
	gd19G0TeYyASS9qCyXxzzsxfxYv123ihMTATK4VTh75Vgnam5O2NaKcfj7CA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748244236; x=1748330636; bh=H/3/1KMPazcSq5+Erco9BmMfIbwiZjaP26r
	5K4qovM4=; b=InkKiSc6NVrLLcT1kzh0hexC1+U4mD5JvMsuEWQUrXsbwlJkLIw
	+hnOdRNiTvolwnQbRPXxB2lilTsm3XmMTXsJjuTqwXlE/deMg1/Hp9plsk//QQqB
	McvD3qgDIznwJpVua6wUCSYfagXMRTFgaCgDTO/bL6q6FziVjRBTFkEC0YhPhKDP
	qCtFx3wJEAeet7vn26jDKIFuwgghZtjz+m1Exjl+Zi3GR1mcNhQCn/jywCiekUXK
	wtc0l/+KPryApqibmMLwVXY5O2YTx0myVi9s3pEGEJ6BhM8/BVb5p1VAWQMqCIXk
	40GYt3p7avXrgeqGY66I+5ihbwdHzoQFsKQ==
X-ME-Sender: <xms:Cxc0aCBWaoTIiSpEbzNEHcYKzlQkc0MXwx4-diF2gZ_A9Idvo2Abtw>
    <xme:Cxc0aMiHHVitw2qbT9tZpq7V-ou2OHjHiBGGwb_1KLVl5MPk6QDZ8SZsQACicG2w9
    a6bmxulF2XUDJ7KgQ>
X-ME-Received: <xmr:Cxc0aFnYUKC8FhLZRd4HvwPH8ydIDoUSYMJ0pN3HT436HWhkq8lD3QXwJcSyoqnGY9TCFyE4HSPZo-V7zJWFNQSjPeOElodlmWHfJ4isFzCHNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduieeludculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhep
    rfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrf
    grthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefh
    jedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:Cxc0aAyAu8k0EZpA74mBo7cMy4DmD4tRP9Tvp96yMCgG3Ysum9OBSw>
    <xmx:Cxc0aHQRNAlYHdYeHDF9KzyWc7E5-zx2uFMV1PL9ns4aeGOAivh1fA>
    <xmx:Cxc0aLZCsOLWP4L8bwie2BvV7hv0TSh1KawNmIFUuKw1UGyPwy__Bg>
    <xmx:Cxc0aAR9Yadr8E9j84oUAvoN8LZDRuhh6FtMEuUXWa0kw7VFS6WQ8Q>
    <xmx:DBc0aFfCk1NOW1dyOzMRMQQQqZJvnwdUlcv2XlESQhDUJMbdJW5pWZ5L>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 May 2025 03:23:55 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 30899451 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 26 May 2025 07:23:53 +0000 (UTC)
Date: Mon, 26 May 2025 09:23:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] pack-bitmap.c: fix broken warning() when missing
 MIDX'd pack
Message-ID: <aDQXBBrL2Ni69gwE@pks.im>
References: <aDC0bK+NOuuVvQtb@nand.local>
 <cover.1748198489.git.me@ttaylorr.com>
 <ad7295b11b2e2c48d859623bf1bcfd92ef15ef9d.1748198489.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad7295b11b2e2c48d859623bf1bcfd92ef15ef9d.1748198489.git.me@ttaylorr.com>

On Sun, May 25, 2025 at 02:41:51PM -0400, Taylor Blau wrote:
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index b9f1d86604..99c4927e9c 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -490,7 +490,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
>  	for (i = 0; i < bitmap_git->midx->num_packs + bitmap_git->midx->num_packs_in_base; i++) {
>  		if (prepare_midx_pack(bitmap_repo(bitmap_git), bitmap_git->midx, i)) {
>  			warning(_("could not open pack %s"),
> -				bitmap_git->midx->pack_names[i]);
> +				bitmap_git->midx->pack_names[i - bitmap_git->midx->num_packs_in_base]);

Doesn't this cause a negative array index though in the case where
`prepare_midx_pack()` returns an error for any `i` smaller than the
number of packs in base?

Patrick
