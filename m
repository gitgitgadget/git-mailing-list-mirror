Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FBA22ACF1
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035868; cv=none; b=VH1OTERBTVVI5O8RpHnnZv+8jPJRwALvTaM9QaazjWLu+7Fox2XP06JH2INARgdlKMFaKcGP5A9OnyyduAnRzjHGvEJ+mAGSnSWo0YJXLtX9zSD1x+SPwwtd72SS1h7oQhS8azzlN6GnMyulrYmyucz445ykhFWweQPiiCzPJxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035868; c=relaxed/simple;
	bh=FA4vTeJlKEVeWkfayF6N191ceVhkdOtU/C74RXpAVnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MrDGilEpCiGm99VrhQ8fW3nuk+MyXFsieGpmaZDcjMYJevFaxrCtjHj/MEfrnnHQsIEx7IDvKPfrSbB1TCGA/3tCbXzjzH9nKRbgSnbc8HjO0AGCWlQ9I+Xsukl4v8ImiTFTTVZlcOJBqkr/SmCJwMsBDSTICjIQ9tWjnLSb8Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EcWZDd/d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pn7aV+lB; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EcWZDd/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pn7aV+lB"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id EF7F11140149;
	Thu, 16 Jan 2025 08:57:45 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 16 Jan 2025 08:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737035865; x=1737122265; bh=eNFJtze406
	+vJPTLbJzs2zADWDTA6P6C85XPJkdrqAY=; b=EcWZDd/d7vVokVsCxxyKEdRY40
	PN47iePaT5x4Jh6YUPLJGeWsFuXxJ66nVpt7rd4wvNtT/4RIf4oH3wNJ55D0+6wS
	dpYHwj+LLa1ml8CwIM2f8hHgabci7uqvqpQ+KZzdabXYAVZ3ES16MNMTjLzmGx0v
	CS1ejUP+jRdz07tVo36raVgXIQFklv5UUj4mkg+2Pg7vPrd2Dw8Dd8nIfzYVScCs
	Q7vs1O8MCA40qRJXbpI88wS1hOJk2JLUcFkV+cnlkOecPImM2zOCkZSDmpoLdZDC
	ZlEu8YXPSrmBJi15CL599vZ+/DKp9VEVSw91zfAD4+peyRjcvJm2tYpIFIyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737035865; x=1737122265; bh=eNFJtze406+vJPTLbJzs2zADWDTA6P6C85X
	PJkdrqAY=; b=Pn7aV+lB/zcOUjNjpzstBOjxKy/aIwivsKWZpeJZBUUOy6apb+U
	9ykdBb7c3U8dR8rJWThyZeFYiK9aBDHG5iYMoJr5MQKiFSvyOvhwMjmsSUla+2CI
	2j6skWFdj0Z7SnT8UqtbYLvL+eYSzor0Fos9a/UGxzN4hUfvBQabgcfxQPbMTLtw
	PqegnvAyuO/xIHkF840JjdqvnvFf+YV3lB2q5UyYhg2iH/uEcZip7YPo4FrsBgun
	fmnL3FG/OxrJTPM4J0SbKLEHvMmUA9OxkcMIkwDRGruU6MJX4QWo42EkQQFji2V3
	Z8cD4tsUE1Lh7TggpqxfWOjlXXrWF/Uud/w==
X-ME-Sender: <xms:WRCJZ0kTBPu9Qfe-Yje48bjVuHshGTnzNY20bCDbvirRD2d3B1_ISw>
    <xme:WRCJZz3oUeckF6hSLsmaRYWw9MH90PV6-zspccnBZTy3O0_2RKRWipG_Uiu1bqpX8
    UvO4ue-Lq8jRp-zYw>
X-ME-Received: <xmr:WRCJZyoIIwo5CWRPneBdFNOQnide1v337ApZycl7o8zvuuaQh6fcOxfLICZTixed9Bat74RzaJ_yva7DpmNIP66-HTHuG_zQHed6L-FJQcepuCvxYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhhhrghg
    ghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:WRCJZwmi2wHxsxO7ki-aKEu5DsxeGvgfsM3eSo3XbaYGX7nmi62ayw>
    <xmx:WRCJZy3Yp4hARkOyTomql3NvqZtFgB9muM7Ftruoka28F-P5kJfi2g>
    <xmx:WRCJZ3sVEsxfKdfMZof1-FCGsTSnoWATaL0ArmsRBgneJWZZMHkgOA>
    <xmx:WRCJZ-U4AQ12ImNBgnAAnZ-M_p1bcOUcvuOatleEW61EJ-uFFat9jw>
    <xmx:WRCJZ-_EQDIpD-60Mr4ERXAd3AlSeI3HArG6k3fUqJn7ULFEN0DPPAxQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 08:57:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d329bb7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 13:57:44 +0000 (UTC)
Date: Thu, 16 Jan 2025 14:57:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/10] packed-backend: add "packed-refs" entry
 consistency check
Message-ID: <Z4kQV4Nve632rJ3s@pks.im>
References: <Z3qNUizvHJLgMx1y@ArchLinux>
 <Z3qOB2_zrDHOh-Gx@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3qOB2_zrDHOh-Gx@ArchLinux>

On Sun, Jan 05, 2025 at 09:49:59PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index f6142a4402..6e521a9f87 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1822,7 +1822,96 @@ static int packed_fsck_ref_header(struct fsck_options *o, const char *start, con
>  	return 0;
>  }
>  
> +static int packed_fsck_ref_peeled_line(struct fsck_options *o,
> +				       struct ref_store *ref_store, int line_number,
> +				       const char *start, const char *eol)
> +{
> +	struct strbuf peeled_entry = STRBUF_INIT;
> +	struct fsck_ref_report report = { 0 };
> +	struct object_id peeled;
> +	const char *p;
> +	int ret = 0;
> +
> +	strbuf_addf(&peeled_entry, "packed-refs line %d", line_number);
> +	report.path = peeled_entry.buf;
> +
> +	start++;
> +	if (parse_oid_hex_algop(start, &peeled, &p, ref_store->repo->hash_algo)) {
> +		ret |= fsck_report_ref(o, &report,
> +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
> +				       "'%.*s' has invalid peeled oid",
> +				       (int)(eol - start), start);
> +		goto cleanup;
> +	}
> +
> +	if (p != eol) {
> +		ret |= fsck_report_ref(o, &report,
> +				       FSCK_MSG_BAD_PACKED_REF_ENTRY,
> +				       "has trailing garbage after peeled oid '%.*s'",
> +				       (int)(eol - p), p);
> +		goto cleanup;
> +	}
> +
> +cleanup:
> +	strbuf_release(&peeled_entry);
> +	return ret;
> +}
> +
> +static int packed_fsck_ref_main_line(struct fsck_options *o,
> +				     struct ref_store *ref_store, int line_number,
> +				     const char *start, const char *eol)
> +{
> +	struct strbuf packed_entry = STRBUF_INIT;
> +	struct fsck_ref_report report = { 0 };
> +	struct strbuf refname = STRBUF_INIT;

It feels quite inefficient to create a separate buffer for every
invocation of this function, as there can be many million refs in a
repo. Might be something to avoid by passing in a scratch buffer.

Patrick
