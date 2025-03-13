Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00362676CE
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870547; cv=none; b=cIbuhsU++qWTN21lobDKGoAfM/TLytg6vSL0G2y9fgk4jbfuIy/WcASxnYh5+8bxLrzHYJNgO6gtR6mfGC6MZUG260gifP2R157TD7xtG3XKEX4qKVzeDOvn6qSeB13yryP8I7e2v+MZdJTnd9UWkM6NkUxsXQFlzOQ5vP+HcWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870547; c=relaxed/simple;
	bh=N9VuA0yK0q/iemr4WJRj5tOHnfDVFNwkfIG+edLI464=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi5MRmDgEKxQoTUzV4e8jDKQnD47EQo79Qaz3cV0xqaHetoZtv1oVCWqLzIFWz1vEZ0Kj04ibY7s2kgjuhipqEnNM3OaZxJ3yNFGEA9VBj0POMH4+fruvVb3DhJyEFeJgPx3FXKD08w4j6UtYhylRCgdwuUTNzEQvEFxVPl2QX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Aqt26N+Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FR4IdaPa; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Aqt26N+Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FR4IdaPa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id A67411382D10;
	Thu, 13 Mar 2025 08:55:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 13 Mar 2025 08:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741870543; x=1741956943; bh=vDBtbFbJ9P
	7LVluXd+kYvqIuh6lAUoY3KyU6b1RAVig=; b=Aqt26N+YRL+bNZONb0MBcmu869
	bN/izOINhU3jmGMJat4Uvb42XJXlEiT6KNRFIDZ1Jv+ALdk/KV60K33Fwot4H7RC
	oxsyNj7CUUBn02G2z0TUrloAOfCunV+rFyzjJLi7cZ4cf/zOlmBbRAri/4Jlxti0
	PxLbta6PLZ0evqoiAA+AzXCOWAWHn1mj77T/Zp9KoCrNpyiyR62VMFXvMvWmrIm6
	CBMTFMzroA6sgBEdLslCff+5evjz5vomxfIkvpZb803d3aB/3rzKbq7XQ2rU9z1V
	PJaBxgVs2wZfVT32xoVQBSLTYBU09nP/ohdBqnYZJF62ju+GDjwp+zlB48VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741870543; x=1741956943; bh=vDBtbFbJ9P7LVluXd+kYvqIuh6lAUoY3KyU
	6b1RAVig=; b=FR4IdaPahdRZyAC8eaDIlfgXglyu9GGxmR1fDKrEcjC6Yq/2SEo
	prRLYJwsaQ5THsPwui2VDidSLYMOBWAeTEmneH3k2oDGw1oPuSuqxhM3IDPvx8cz
	Jh1eYAAfzBDMVjUOGAiRgF/5h+QOZdBvOMVrxebXRgKlNquWCcnpK3LaUDAqpj/h
	jYDiiBQJFstjxIye5MWR3irq+LEWsShm1vh5AsrpXl/xt/9n+olp/FpOmznTzf0V
	s4J24W42raThHKulJD4TgNoM9D40buwYlVDChqd63f3uSkdOBMB/l725laakgGnC
	by3nlS9chTNTq4Ig1liEHpOJWVfhYDCWtLw==
X-ME-Sender: <xms:z9XSZ_pj-K1eBoNDgiaSYD7SkcxSY3KNxrqj22rzJK35V81HR1J7RQ>
    <xme:z9XSZ5pJA3unpqxrbpftTiXdq5Bx83Rb3pXs7FWKw1W21PvAwWEu6f3R6zK1muxry
    zSuHPeYpprordI6Pw>
X-ME-Received: <xmr:z9XSZ8MK37FVTDlq3N6DB71I1Wcevv6rKhf7FZodyG2mgMFjfsvnhmhxHSm7OZEtOESwvTvYOFJTvL7P6E7GPvUF70Xsil354gPye2yLOFgwmRz9Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdektdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosg
    hlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:z9XSZy4zSmpoX8KzSw0s7hHNy80T9TzVUihFJQ2YAhZ4nmcEjcwiZA>
    <xmx:z9XSZ-7iPjpxMV-pSPNNeLJeU5eU_i8meT4mIxMTuf80Ja9t5EkX8Q>
    <xmx:z9XSZ6gP92S526lQKT6k6EJVgcyyHjiNE5pWVt3vi_6yntFX_P6_lQ>
    <xmx:z9XSZw4swIYGpK1tgzdKdaUexBNMtLuyBy-DAd18JNQGKTDMfi58Ow>
    <xmx:z9XSZwSdcN0DvoKL0XJ4Fhov4w39nlXRjBfTPma3ovNf2J37pMSPt1X3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 08:55:42 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6f3319d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Mar 2025 12:55:42 +0000 (UTC)
Date: Thu, 13 Mar 2025 13:55:41 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, peff@peff.net,
	ben.knoble@gmail.com
Subject: Re: [PATCH v2 6/6] rev-list: support NUL-delimited --missing option
Message-ID: <Z9LVzWX4-6KGV6S7@pks.im>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250313001706.3390502-1-jltobler@gmail.com>
 <20250313001706.3390502-7-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313001706.3390502-7-jltobler@gmail.com>

On Wed, Mar 12, 2025 at 07:17:06PM -0500, Justin Tobler wrote:
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index d400d76cf2..145ded5c78 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -371,8 +371,8 @@ ifdef::git-rev-list[]
>  <OID> NUL [<token>=<value> NUL]...
>  -----------------------------------------------------------------------
>  +
> -Additional object metadata, such as object paths or boundary objects, is
> -printed using the `<token>=<value>` form. Token values are printed as-is
> +Additional object metadata, such as object paths or boundary/missing objects,
> +is printed using the `<token>=<value>` form. Token values are printed as-is
>  without any encoding/truncation. An OID entry never contains a '=' character
>  and thus is used to signal the start of a new object record. Examples:
>  +

Nit: I don't think we need to update this paragraph here as it is
written as a non-exhaustive list anyway.

> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 7c6d4b25b0..d7b4dd48ff 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -136,24 +136,39 @@ static void print_missing_object(struct missing_objects_map_entry *entry,
>  {
>  	struct strbuf sb = STRBUF_INIT;
>  
> +	if (line_term)
> +		putchar('?');
> +
> +	printf("%s", oid_to_hex(&entry->entry.oid));
> +
> +	if (!line_term)
> +		printf("%cmissing=yes", info_term);
> +
>  	if (!print_missing_info) {
> -		printf("?%s\n", oid_to_hex(&entry->entry.oid));
> +		putchar(line_term);
>  		return;
>  	}
>  
>  	if (entry->path && *entry->path) {
>  		struct strbuf path = STRBUF_INIT;

Nit: the variable and its cleanup could be moved closer to where it's
used.

> -		strbuf_addstr(&sb, " path=");
> -		quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
> -		strbuf_addbuf(&sb, &path);
> +		strbuf_addf(&sb, "%cpath=", info_term);
> +
> +		if (line_term) {
> +			quote_path(entry->path, NULL, &path, QUOTE_PATH_QUOTE_SP);
> +			strbuf_addbuf(&sb, &path);
> +		} else {
> +			strbuf_addstr(&sb, entry->path);
> +		}
>  
>  		strbuf_release(&path);
>  	}
>  	if (entry->type)
> -		strbuf_addf(&sb, " type=%s", type_name(entry->type));
> +		strbuf_addf(&sb, "%ctype=%s", info_term, type_name(entry->type));
> +
> +	fwrite(sb.buf, sizeof(char), sb.len, stdout);
> +	putchar(line_term);
>  
> -	printf("?%s%s\n", oid_to_hex(&entry->entry.oid), sb.buf);
>  	strbuf_release(&sb);
>  }
>  

Patrick
