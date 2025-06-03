Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A4E23535B
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 13:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748958089; cv=none; b=Ez6lKiSKG73ZUPjeXdUpJTSWVHFQqhHAVut1WCY5Njkyv9HdwMWZORsn19m+WSdLfCp2jVV1+pv/5akrHL29BqLoX943bT5HSIqOM+LJ/EhchfVJDUfccIdXo9JkcvEMfZcJN97prBetqrIpE18UBo9ln7SUxmTMzxcxRw3chlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748958089; c=relaxed/simple;
	bh=62lNBP+DkrMBkboLAOgdl2SeBt48m1tAWmRfAiaG5OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ie2paP76nSS1QfmLrPN25dYNK2hnUMxbv/pY0ApR7hi27HtV9+R7qPD+f2M7G0/qEl3bkjUzblVmafFDNyFpNBoJCfzshKEFX6F4ePBNbjdxCr3Kp6NHX28bqitN6/AwEEsONyMjbIedPOo3KZ13SQAGgh4e7B+8h/3IaLwocq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UiA8GwJH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJjoccV/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UiA8GwJH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJjoccV/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6322025400EF;
	Tue,  3 Jun 2025 09:41:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 03 Jun 2025 09:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1748958086; x=1749044486; bh=wHkbjK12rq
	b+Wz0wZ1Ac/WdNiqa63mcRUSEQJeaTcZE=; b=UiA8GwJHKLSffM8l2MPaqFF0+t
	PcX9ScQxtJCrA9XBQx0wSg1dhAhfutAfzFZQjlQpEvIsv7jmWt1IruftkmzftSGK
	yBfs0UHRS86afYqhRUDB8Ic2MRi3W+5rQiz114GQIWltrVmfjbbnr/dQWdhmMcec
	O1LFgdP1LL79RTmr37YZTz5b1m0n7ek+Qw/ciBYabPifzldUI7y1LfRlLLEuoxcb
	+oNvVINt3m2OoA3MQuJ+NrlWj0UjszLOVO9suS2rEhy9eM1NmJWnfTaTyeFK3PcN
	nezzzwZ79mSNSe5JQEup6TsZwv2w6sTlbPU7Zyoz9ywD4JXMHf9WL2v8sK3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1748958086; x=1749044486; bh=wHkbjK12rqb+Wz0wZ1Ac/WdNiqa63mcRUSE
	QJeaTcZE=; b=WJjoccV/2kAp1Xz3QxiG2SffQIVzijQbxwS1OOg1z3wpaYkLO/w
	KOjsvr5RPoPnxBRxWvbgSBc+dMSdBlb4Kjo8+C7vZaNs7sOiS+Al+6hqM99krbr3
	tcfCyf+1qbBagj13RgY5SrX3Bsa/MqP1WVQhlQ1jvfzcmL/4uJh1csrvIRPL+FJe
	xT98tZu6ZVr4ih5TVK9UMO/ZQ40oPvUBLHM0tiSbDjEWNAaXQuQ75pnTJls4S/jU
	sMUeoq1KyKqdoFEA7KlMIcA7P0IH9UOFjT67Ja+OzedB9fvAiVeCKT6oF4KkPrmu
	AtL8N6nrrArTK9/EkL9/qDQGKtzAZB6VPpw==
X-ME-Sender: <xms:hvs-aHnQzevPjm7ONT_FQS9KYMe549cwZCBhf4i850bDOc8J-0a8gA>
    <xme:hvs-aK2VcLWtRGWa-jPHxldbrjzNyBxqqoG0ZrqGNSg9z41dl_9LjTauWN8Kconzg
    EKsyGCmy31e929hqQ>
X-ME-Received: <xmr:hvs-aNqARWCJIXQbj4O1aSlpbrErnhZ6fexJh7hG60xLWvga0GMX8Hm4FA8sxw4Sojy5ABBE5Z-FlS0ygJlgeL9fH8hw0zuMxAZ9gtUrCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepshhhhigrmhhthhgrkhhkrghrtddtudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptg
    hhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:hvs-aPkkN4kB2zD9kBa0ST4eW8ZnbKnsqVRVLgZ1VvDdZWiY4NuT-A>
    <xmx:hvs-aF04gjdi2zU7Uh_xLR--0EyxI43K9jp2_FrbedJHeT-4l6X2Mw>
    <xmx:hvs-aOspuL2jaPOlpwYRX2f3VBxqJcLJHQhc1KKk4ODU1i2z6I9ApQ>
    <xmx:hvs-aJWMVB67Ezb4Uge_R2MUb2zH3JYS8A6oGb-ci9QkO-erh4F6rw>
    <xmx:hvs-aOeMsQP6JfBOffMaGYS-Y7IJOsKTTeU1lq2FrthFPszaEmeubh6p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 09:41:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 50b6bcbc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 13:41:23 +0000 (UTC)
Date: Tue, 3 Jun 2025 15:41:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH] environment: move access to "core.sparsecheckout"
 into repo_settings
Message-ID: <aD77fz3N-fLI8DjM@pks.im>
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250603131806.14915-1-ayu.chandekar@gmail.com>

On Tue, Jun 03, 2025 at 06:48:06PM +0530, Ayush Chandekar wrote:
> diff --git a/repo-settings.c b/repo-settings.c
> index 4129f8fb2b..406c70601c 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -81,6 +81,7 @@ void prepare_repo_settings(struct repository *r)
>  		      &r->settings.pack_use_bitmap_boundary_traversal,
>  		      r->settings.pack_use_bitmap_boundary_traversal);
>  	repo_cfg_bool(r, "core.usereplacerefs", &r->settings.read_replace_refs, 1);
> +	repo_cfg_bool(r, "core.sparsecheckout", &r->settings.core_apply_sparse_checkout, 0);

The config is called "core.sparseCheckout", so why is the variable
called `core_apply_sparse_checkout`? `core_sparse_checkout` I would've
understood, but where does "apply" come from? Also, for brevity I think
we could just call it `settings.sparse_checkout`.

> @@ -227,3 +228,13 @@ void repo_settings_reset_shared_repository(struct repository *repo)
>  {
>  	repo->settings.shared_repository_initialized = 0;
>  }
> +
> +int repo_settings_get_apply_sparse_checkout(struct repository *repo)

Same remark here -- where does the "apply" part come from?

> +{
> +	return repo->settings.core_apply_sparse_checkout;
> +}
> +
> +void repo_settings_set_apply_sparse_checkout(struct repository *repo, int value)
> +{
> +	repo->settings.core_apply_sparse_checkout = value;
> +}

Getters and setters only really help in the case where they actually
provide a benefit. These don't though, so it's dubious whether we should
have them.

Also, shouldn't these functions call `prepare_repo_settings()`?
Otherwise we cannot guarantee that those settings have already been
parsed at all. And for the setter it could happen that the settings get
overwritten by the next caller of `prepare_repo_settings()`.

Patrick
