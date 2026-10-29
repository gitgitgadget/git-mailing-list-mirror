Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.150
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793303591;
	b=TxGDOk67Nzh5Ro6Kw3Q2em4WFm616+PAjdg9+j1oOP4mmmj+ErnMmNfU+k4IXNV+WdKq
	 wVTQS84mvrPpUwowEWqWuIIO1KZsIyaI++WI3sKtOXfOoK6K0/0iTnKhlpZAsQZ7xlN0O
	 /O4/HO5lr12honRxin/BisVJ0dbpiVjFPlbLGbO7ipxc2vPLjVyDEydNoQ6VI6UcnCUeJ
	 dajBPfRw/ojcA7PBiQ7GdMQQzyHR6IWpH4yPSopWKWTKSvo6meffeV8RgSwe2GJeSnYyC
	 xgj57rRRQw/mnIT/8w+lZIpwPdIt3CplAa0jEkHhsCKZ4WwyYy4+oBCZwvGD6GethkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793303591;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZbYu/8zZlV5dFbyRpu9UkYC/ndXyNUaDQBHOjQQzoqQ=;
	b=vbL2ekZQfntcvJZZOjWkuTzEJCyc/IVHDmrSdFoHIG1ojMgeHQrL2KJr4h4Kz67E/Ah2
	 uXwkWLNG3i7NrKwpVmyomrRjO1wV1BAyMi0Cbt7tv3U8gpKpxmYSPCa3tcHPoeVl4uLcb
	 R+9m0NSY7j2Uj84IvGkobj0o9j6IcU246zY+qPOWnX6JJN6+C8Sy4j+A2/UcpdqP7hhSP
	 Bd5v3hwPTTcovSXZrFyb5DXLYzcsDqZCxpPxuiaHZL4BrzE3wNFaMPv+zUT4WnuEn5XHh
	 +whS28B+paBw2bqxTGof2v2NK9eL+wHn9Ug2iziojrTxW+SGRWcJI0leOSBTJeAiocA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Hh8UsSzu;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZfH2l22y;
	arc=none smtp.remote-ip=202.12.124.150
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E6B606A31A
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 19:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7E6B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=Hh8UsSzu;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZfH2l22y
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 292831D000C6
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 15:53:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 29 Oct 2026 15:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1793303589; x=1793389989; bh=ZbYu/8zZlV
	5dFbyRpu9UkYC/ndXyNUaDQBHOjQQzoqQ=; b=Hh8UsSzuXY5nTO30aiJm5yKW8d
	bXSPzGIE4FGEmg9yyUnpwxaFFRDe7cuuAv7BNV8kzhUtKs1B1RHAcILm98QyszfT
	6lfieBx5Xe8rAstfXKAyiBNd8VlHHKEnpovCUA3rIITJvDVS0GNFnWXDVG3E4/Zs
	VSTq4RyRF5zzaRCKmAh6+z0XWc16PFb3Abc8Tdorytb8axac8JL213B9GMHnn5Kg
	1GfjChkq9reIqICpIe2LQsDaX3SrUxs0EX5StMOHVy6ORyVU3qAHtsWzgguHrBAF
	AIk4T7dgrt9ZcRe2DzD1GOgSgXcMYx2LC4K+UuhSvgzEES63O7iUizKR35hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793303589; x=1793389989; bh=ZbYu/8zZlV5dFbyRpu9UkYC/ndXyNUaDQBH
	OjQQzoqQ=; b=ZfH2l22y2UJva3YXxb3Fd1OhdNsPSHoAmiE0ETx2xIdHO2DGZSa
	EjTR2ADeAZPhYObFN0z8vpmySQg5/H5MWqwdut6eCb48WKudiCiEFCBvile62Cvf
	FuG0E0h6T2+kA2xcOfOMN5famUMCqBDlFpw1/jJu3egweGJmsrVI/yKIIjogsEjm
	ni+DQecXA1SzyfSU3ga/2u+WC3EuGqtXIfHJXxb5fWvn7yborcz8/fEOCPtn78YW
	CzYx0+0fZNNGHbQkqjqF8yOZJCENjBFquFvbNFWV/dt0IfOWeho1+DNBS1HTmIzx
	CG6bOsApOiq4UApqZAMN5Xv4tuWlxGma9Zw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793303589; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:O5xLDpjrPTfQzfaUUuw/gWArWkMBQvJ1QMwnPqVYQFjWbJz
	jbdpoNHaxxxB+yyk7C+iZBy1Lw75UoJDI9CAn9/Ss/kLUrErlx2dBJ5hmI9BsgGA
	B2Cy1I9GeRBdneijmFlrgOJCoFx8tnguUEjQUYtyYPcJB0T5hf0x/0nNJy5sAbku
	nHKUpbjtC+Jcf+Focs8OKIkjNUosjl16nUsw70vcXdPGHRivs6LrnjFhTk8OGJ4N
	E3Gp3ckvf/lyfxO4IoJhHUDMGxeE/y//LKBXWa6On1rpiEmiOH13p3GxCLpokOf6
	WvAAHxVmLuCV95smI4EPmPdO59oigQYo2c67RNQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:AgsseJFRhEEwCBowurY6W2HQpGS6kpeoCMUO/9LB2S4=:tBenGnX1m5IHUN2Xng1IyhX7BmJL1otMkCIQImFmGmE=;
X-ME-Sender: <xms:JaTjagJ_gcmu4WE8mVShWB8cr1efKkHC5dpkvCvD3unc5sxhe7lTlw>
    <xme:JaTjannX6Kdv3ak7hlRy8S_zyarrNIIjd_VUlqXinXxgydJEfUldEDWEblTkxbd1G
    z0r2Pv9sR-3sm-vUlUJuE2TTOnzwCs1mfQDzf5L9TL4bM_ggIO0KAcD>
X-ME-Received: <xmr:JaTjauF8xHX7I5opqeFVyelksOw2TpbFAj7vWyOv4TxkQloSoon4ZmbtdeSjhns9na2mg5kUkgKmEuOJdDJnsx8DS36s0_Aw3ISc>
X-ME-Proxy-Cause: dmFkZTEgbPj9CqGeyWbLe2FYIaUEU5/mV3fZSEBxtuZXYxyXeQ6PHDjmeKAzc7rqe8ZIqs
    kicDUnpRVlw3XZlRLnIEKDLpIUcTsmlIRhBJUHzZm5Td5K6YBJezu5NClSjQ4SSl/8yQAo
    K8nV6dLU+Pc5ly7zCajXkFl1d60gcLqYgwj7+WGvts8T54y0izG5pN1120ituzOpyvAubE
    Ol4ICN2uN0l/fqcPzIQ9lzm2thktTfJ3KVASHySUffCLpHUhUPUnkqaP6rUD8Oa30gzXMf
    ZYc7H5oRgpxNW4tIOtWkCb87B1NLK2qgbn93gwc4noc+Hqk61jBYMv7nUcN5Cf3V2fm4t0
    XA7nWTVOC02PluHgVXM9OIUvKs9QEW1zhB90eU3LhCwnyhDBP3+vsmuhH7Eu/rIUiA8o72
    A/r2Jp8MP7n4xvYcV7I4ST2c0pLnHLkbhRzx/HaMY/QDkN6qewE6GNUwDSMfKwV9JxqwrN
    zN+doWTwjUtKsakwERwBNPrRaYMze0OMH/lDN0SrK+qWLB53uuU7+QLICEwRk6dd2FrmCC
    /jQ6qDPARb5iO2qZwbGGYtkz0pqF8z8PDzPnvNNA/GAE5coKTwUbGw3PRraVYz2inGc8zo
    7kMnW/02vjwrHCjrYCwX9JzfyyzqfWQX9Z6W/7y9UEq6CH/IBXAQ4+8X2SjQ
X-ME-Proxy: <xmx:JaTjanHVEdOy23xNaar8mae2LjqZ7UP6DQjXdtahaX5xPq6dFdWl7A>
    <xmx:JaTjarPi6BCLqITn8QxVf3IDeBYC0bESo5Dfp7fsFykfYiAhGFxW7Q>
    <xmx:JaTjamHZarCX2QRtfPWIWf2D331qd4FkuHcK-LeODL5t2W33yXYl9g>
    <xmx:JaTjaiO-Cg635wYDGYJtkwncv-XWaVX6fYwVlCXsxoDq2_l0cJlGDw>
    <xmx:JaTjavt1amaDetrI-s5-XAW8XuLrX5ehWuDkqoUKwTPCZJECHBFdl-gQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Oct 2026 15:53:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Mark C. Chu-Carroll" <markchucarroll@fastmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 1/2] repo: add level of concern reporting
In-Reply-To: <20261029-b4-repo-structure-concern-v4-1-d813537ec617@fastmail.com>
	(Mark C. Chu-Carroll's message of "Thu, 29 Oct 2026 13:52:22 -0400")
References: <20261029-b4-repo-structure-concern-v4-0-d813537ec617@fastmail.com>
	<20261029-b4-repo-structure-concern-v4-1-d813537ec617@fastmail.com>
Date: Thu, 29 Oct 2026 12:53:07 -0700
Message-ID: <xmqqld7g1dy4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Mark C. Chu-Carroll" <markchucarroll@fastmail.com> writes:

> @@ -550,51 +700,76 @@ static void stats_table_setup_structure(struct stats_table *table,
>  	stats_table_object_size_addf(table,
>  				     &objects->largest.commit_size.oid,
>  				     objects->largest.commit_size.value,
> +				     repo_structure_concern_level(
> +					     CONCERN_STAT_COMMIT_LARGEST,
> +					     objects->largest.commit_size.value,
> +					     repo_structure_concern_thresholds),
>  				     "    * %s", _("Maximum size"));

So, objects->largest.commit_size is computed using the value in
objects->largest.commit_size.value field.

>  	stats_table_object_size_addf(table,
>  				     &objects->largest.tree_size.oid,
>  				     objects->largest.tree_size.value,
> +				     repo_structure_concern_level(
> +					     CONCERN_STAT_TREE_LARGEST,
> +					     objects->largest.commit_size.value,
> +					     repo_structure_concern_thresholds),
>  				     "    * %s", _("Maximum size"));

And the same objects->largest.commit_size.value is also used to
compute objects->largest.tree_size here.

Copy and paste mistake, perhaps?

Please do not take this "review" to mean that this is the only
glitch I spotted, or that I will advocate for its inclusion in
'next' once it is fixed.  I am merely pointing out what I happened
to notice while driving by.

I do not have a strong opinion for or against the feature itself,
nor have I read the entire patch carefully.

Thanks.
