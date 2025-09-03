Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1752853E0
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 10:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756894522; cv=none; b=YEzeG17Ad6rb8in8c0cMr3blR6OB6gBXmZYc0pug5TXy0XVCmMY1H2yfaqfUpGvkZfiHLLJjds16MaZaa1ebeFTUHUEpfFvwBOZ2gUgOf8OOiO1Ld1yEvVs/L1O7EON982Ip5Z9d3MdL59L3mSyEqSwitfZaQ8AmOKYIsC9haws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756894522; c=relaxed/simple;
	bh=oHN1+syDo8smLcE/Gy7+d6D7+CyZusCB7OAGqfzED3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvJwQVL0lSygON3XmMPGMnBygSIN+980oBh3H53i08zIt3Hi/Tmpgf6uJmSLIYGp5vFVXUQNjqVbWiinRxGWxYUnctipee/Dm3WJ2uPcuTkBbRoE7h5TzcSpENbkQ+MC9ncCylYKNPzykpWzYd5nK1Bw0gYVmSqgClzEo209pMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rzBUx7Wf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LAXn5ixp; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rzBUx7Wf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LAXn5ixp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B9A4C14003FB;
	Wed,  3 Sep 2025 06:15:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 03 Sep 2025 06:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1756894519; x=1756980919; bh=UlkkHl5/md
	PGh9Ob2DDzBaRzLlcQ0hzcqoBi+QpVW4E=; b=rzBUx7WfPbv47OZBwxKaemmJwG
	37TCWbVunu3ZgfFp0Z5VJGlMaT3BDJrKyd6ZOmrVzyz9X0MHgmqV5oTdhHjZY0Ga
	0wGYFaoXPxHgQnDT7tTmamY7bucIFzngCo83t6HwDK2OmPvwfffS8PT+m1/4oIGN
	dhUqzrbl18Der+LEYAl5iuUsG51doRygdj/Acr6tnp5z4QLmzFpyNWHdnzWg7aAa
	7IbBCwHWdvaOGNbMCJptogSM0S3QgaTcVg49sI7U6mwSxAnsaGo0FtZTQgG29tU2
	OqrSV2+d4IHdXQ1i9X7sInH4SCa7qikLsdu13fLloM55mWhPnDf13NXzzHIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756894519; x=1756980919; bh=UlkkHl5/mdPGh9Ob2DDzBaRzLlcQ0hzcqoB
	i+QpVW4E=; b=LAXn5ixpFufhq/C6BilSFCnv4Qchnpj1O8DFJ7XomkGSvhQ5Xna
	t48HfEl2X5oTLbzvbJyTaUVxNnKOF9o2Xlr1Uyyf2XTaSYIcHQKNERehq3hf0zwp
	lvscQthTXQQTNbyJ3h/e2fyHpQblpFih6ZbN+a9lkhuuG35MGqbH74I+rFVur4eE
	i23buU+H9on9yMfkH4BrGPNTJWJdYGzd4J7+EZA7BOzLDfLnxdz1MB2KMHYBy4ad
	u5fXMpmx65Ey4ynWydTZcot9qsKKSsjp4XRF9d3lv6x7WfS/a8bK52J2rk4VHbS4
	jSiHyUQZ7p/Y9+39nA0QQV4tut6vvMIFonw==
X-ME-Sender: <xms:NxW4aCQU9qp8F6sJbnIDyQH15LTX8-QSi3X5xwmHg_d7qGJ1NFdjTg>
    <xme:NxW4aDR-IU1WyJg1Hg3L7tH1UoERKjqD9AoPZ3gie62yBUcc1ayPnBfwtQcAUKhNR
    z0ouho9NRc4_I7EFw>
X-ME-Received: <xmr:NxW4aGSeNuRppVQ4t1TBqTlJrGAb9TY-Xb3vGWpK6vwvk4nDT_sO4sIQcUbhLE4iDG2b8KMXstsg5sXMGXp8jx0yGl3jfX9WbHYLcrY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    shhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:NxW4aI4F1S7FIVMKEJRkpybDb1AJdXIHWsbt5WyffEAN5KUwMjQKGA>
    <xmx:NxW4aC1LlZq4eEboLptpNj6rLGQKl9myRu18aZ_QzyukUfTNhTPW2Q>
    <xmx:NxW4aDC40JzuRwv4lLC-2UWgTNdZB7ySTfbAieylyhwFeKKdmcNuaw>
    <xmx:NxW4aNPNCq63rnSsQ37z-n0NyovRUgprC6bIh5D5lWwI1QQqK8O1Sg>
    <xmx:NxW4aA0689oL-cA1LUMoBJzEo-GBuavt2SST3DaYiGi0kUdN5YfTqDrl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 06:15:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5eae1c9e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 3 Sep 2025 10:15:18 +0000 (UTC)
Date: Wed, 3 Sep 2025 12:15:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/6] midx-write: use cleanup when incremental midx
 fails
Message-ID: <aLgVMxIeOH_goTG5@pks.im>
References: <pull.1965.git.1756402795.gitgitgadget@gmail.com>
 <pull.1965.v2.git.1756589007.gitgitgadget@gmail.com>
 <c4f75cca094dd47c431de52e335ccaaf8b06355b.1756589007.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4f75cca094dd47c431de52e335ccaaf8b06355b.1756589007.git.gitgitgadget@gmail.com>

On Sat, Aug 30, 2025 at 09:23:24PM +0000, Derrick Stolee via GitGitGadget wrote:
> diff --git a/midx-write.c b/midx-write.c
> index 0f1d5653ab..cb0211289d 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -1327,13 +1327,15 @@ static int write_midx_internal(struct repository *r, const char *object_dir,
>  		incr = mks_tempfile_m(midx_name.buf, 0444);
>  		if (!incr) {
>  			error(_("unable to create temporary MIDX layer"));
> -			return -1;
> +			result = -1;
> +			goto cleanup;

We can instead use `result = error(...); goto cleanup;` here and in most
other cases.

Patrick
