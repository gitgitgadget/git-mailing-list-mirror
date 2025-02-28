Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128352580CE
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740736899; cv=none; b=JqMhN2cUH1lBlFBzLUdTpnXxHWvYXRAZ30+FnTAsHplbWItwPTksjF2CQpGdCYRiSL8iMN5rUEQXzdIxEwXdxNJyg7ZbPAuO5QNsn3jdFZgcomdbe79nn1lk5rm45fm2l81ERaqAMfTIbdZUL2qLCshyawd9Pik4yRqCTRpq9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740736899; c=relaxed/simple;
	bh=N8/q+XYnJh/RyPSgcNS9ELWnOTnKi3Cp4P7388jpjGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAcfD3t+WWMjT7hN3QzqgPvYIeMkhULNqlTVnSmEECzUP0e5DbaIVhq+hR9RBYfixTVyD0xOukfqM/BOTQ8UmShMbtnXFtNKQeO8HBgteEaZr17OKGf7nqynmc9iDuCqcPDwW47oRgl5xQ1v16QMJJKp3Ydz+NVQSjoLbIN+Mtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MdQB5Gqr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pp4shqPC; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MdQB5Gqr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pp4shqPC"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 21AFA138016A;
	Fri, 28 Feb 2025 05:01:37 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 28 Feb 2025 05:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1740736897; x=1740823297; bh=/va/TGmDYU
	opKtoe1J7ZxTexccfXhvo9TXp/n2pQuQQ=; b=MdQB5GqrJ1MNiFiiEdcUgtezBe
	lBrv6k6DAF75mRiIkhZAyTEg8NQn/oCi8txdE+oQZZWSO7eEf5DsWIm2WmQMn+eJ
	NjS7jVOXWJR3pFJSLu8Yekpg0ENX2yQamaW/fIQeYux8YaDMqEG8KDJzJygkC3YL
	rWLzCW5EUxxZ5jQwlarglMGmpz+NFIAeVopt8xZtUIHmqRt1H2kFOvQy305hwLOi
	a28CDWE8lsS92FX0KiHnkRNdhhioRqhJbNMheK/qM+/kVLnKHfj4RV1s4CEKbueA
	kPtzOnQUXWRR03Bk49HH+/7iWAupNswc3PD8PxwSPbMo0BMnfuFBoTjYn8tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740736897; x=1740823297; bh=/va/TGmDYUopKtoe1J7ZxTexccfXhvo9TXp
	/n2pQuQQ=; b=Pp4shqPCar/xg3dY8Ab0/DbRjj3646ZQYYkGiC+58gO+w384PRj
	svnvfZUqJimMTG9ZgJTM96DuMccKRfCBOsAWWDrFjYbiyWvu4ZkZE5gwnWQmPgdJ
	Gxr4mEYloiaSCepuyXGCp8VqlyoI95aJxVSKY2BKkuw+hX+DRmjiLXU30beO5VrD
	C1f5x8/TPi9oWABgxHrtgO3Vw2Pjfs5TmwtCgnqfpmiNw6cUPk5bLLLujkcFSGhj
	+NAfzpunPUaSuzji9Pi+xGuS/U6m7WO2EwEqN4uNMDQhX5wxWcZGVoSZxxoVb3dX
	ZGs9nrWyyPGIwm+3x4Ii/38kY3GY425AyJQ==
X-ME-Sender: <xms:gYnBZ1ePvoT_3rku5s1IlO-s4qNySITBWH4xO6NTtWNZ5fhTXx1gxA>
    <xme:gYnBZzNOFZiKXRg-zdBrGQID6C0CGe7iaEJmkUUREFhZDokiWdFRE_J_t7NpjzhdR
    ywN7coZ_5DkMMYeJw>
X-ME-Received: <xmr:gYnBZ-h1uC2GC6wUh5TJtN6HPeIQHSMPXutuW0MLk37dhOv1S6ggNA7vDwSp7a53DyfUAt1_xgQqdtOqRdo3OAlBEkQ4DU1dmn7rMnQ9kVUzA4XJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltddtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:gYnBZ-8PPFjsv4zaffJ-f521XrYBE1fVtGFVIdHWZfkWArowCdPu2A>
    <xmx:gYnBZxtHe7buGVomQDIcJVVyOtdl1jdJUGIvvj_teyWXfUJdsZdQFw>
    <xmx:gYnBZ9EkKuyq4Jzfmpyse9Pkp8PxsG_8HEj6730VPiCER4oDj0dPxA>
    <xmx:gYnBZ4METwycBJqy0pa4eg1LZhLzsQ-ROUx6RrpPwWagwCPTxUZOJA>
    <xmx:gYnBZ_WtUG62SLtofdZDyZRybAokpuRcMuqsesI5FisnPHv3ECP0x3tt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 05:01:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2c2c92f3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 28 Feb 2025 10:01:35 +0000 (UTC)
Date: Fri, 28 Feb 2025 11:01:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/13] pack-bitmap.c: keep track of each layer's type
 bitmaps
Message-ID: <Z8GJfjhGAbXnA1LW@pks.im>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1732054032.git.me@ttaylorr.com>
 <9ab8fb472f48f42f7e0eebc6f0f986c6c74970e9.1732054032.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ab8fb472f48f42f7e0eebc6f0f986c6c74970e9.1732054032.git.me@ttaylorr.com>

On Tue, Nov 19, 2024 at 05:07:50PM -0500, Taylor Blau wrote:
> @@ -586,7 +604,29 @@ static int load_reverse_index(struct repository *r, struct bitmap_index *bitmap_
>  	return load_pack_revindex(r, bitmap_git->pack);
>  }
>  
> -static int load_bitmap(struct repository *r, struct bitmap_index *bitmap_git)
> +static void load_all_type_bitmaps(struct bitmap_index *bitmap_git)
> +{
> +	struct bitmap_index *curr = bitmap_git;
> +	size_t i = bitmap_git->base_nr - 1;
> +
> +	ALLOC_ARRAY(bitmap_git->commits_all, bitmap_git->base_nr);
> +	ALLOC_ARRAY(bitmap_git->trees_all, bitmap_git->base_nr);
> +	ALLOC_ARRAY(bitmap_git->blobs_all, bitmap_git->base_nr);
> +	ALLOC_ARRAY(bitmap_git->tags_all, bitmap_git->base_nr);
> +
> +	while (curr) {
> +		bitmap_git->commits_all[i] = curr->commits;
> +		bitmap_git->trees_all[i] = curr->trees;
> +		bitmap_git->blobs_all[i] = curr->blobs;
> +		bitmap_git->tags_all[i] = curr->tags;
> +
> +		curr = curr->base;
> +		i -= 1;

Do we want to `BUG()` in case `i == 0` before this statement?

Patrick
