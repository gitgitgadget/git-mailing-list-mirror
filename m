Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E143D7D7E
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070700; cv=none; b=QPgcW8IYsuBgkLrlipwyhrhJ0S+yoJkhdp06GWxKturZaYb1wEZ9dMFZNFhe4H+5jiraHhN1ulk8uj3AY73XioC0gEv6iQu6pGwCvi8heMNeILhIpUbTPhC5JH06QYhlCZZS7UbaiTtVG/42UXVoY+DD5Lzafd7x1COig4FC2t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070700; c=relaxed/simple;
	bh=nF9ttViR1MO+4TsYn7qE+DvVYDbFTqAA4TdHy7acwEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jnZC1QPSmnbE+9ruOgGflX+Tj9s6lcqDLSt/e4vf8mYFN/A8Y7PZPdlhSV18Zpv49C156oCnWXhCTXj340BqwGugLjcB9iOYIFYCOpdphTyFzpJem1gQPlaCqesdXKUDNyEwfxlVK6JmGkEZ5+x1pHaV7USxpVUYBJz2v3wHCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iBOnvXtN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rVJIZ7YP; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iBOnvXtN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rVJIZ7YP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA5EE140010F;
	Mon,  9 Mar 2026 11:38:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 09 Mar 2026 11:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773070698; x=1773157098; bh=oTkdYvpd/h
	oXmW/8lQwxMr85Q1ShsXzykegtd2Ty4pc=; b=iBOnvXtNdzl6wqgu1+4o+uzv2i
	VAVU9fQwPwEcxvKToN8aJyfqebPcyfUfFspUNwEesF3stAcdk3lf0uqaWBbPf/0w
	tHdsiNfl+im8CFs6S+vPxMFyEe8y2UjaugZQKXdny4uqGitNWLMZ/lfGvE9aST16
	GFFv11IndgI9dxtMRgEbYrRWJCOtDrZL9M7WMug+4dYKELn2g6vFDR2hrSEfKJzl
	u+4a3P3XzfJO40aThJvLTUvVwpWY2efw1F0eTZubAJI9DlxwRWGVUNNYlS0HrgK9
	KxC6MMh0e6je6UKPO5XI3yyWBrtK+ADRFVnQU9hbwE8m2gaRyKKZKDEgqgZg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773070698; x=1773157098; bh=oTkdYvpd/hoXmW/8lQwxMr85Q1ShsXzykeg
	td2Ty4pc=; b=rVJIZ7YPDt0qmLb6XdPxm8dTmEtRE3L4fpvpkhncrNwPpFM/SDL
	T5fk1inHLURw2Nt9/4F/9OxZt0Z+nKj6b/g76RYMdQ3lRc5l2/RUCdqyrQm/k384
	f0gO6eSNs2BpTpnIp3O0X66w87u2POn4tY5QMOFHhOEXBOZM4g5/cXEIACnb5DZw
	DyxYZ4sY8xQMroCTjzhpc8CHfyXhPhN+z/BRs7FcwUjV94qaq6Z6TK8uA0kiyl2U
	xxqNQdlOCE9rIzQpl4tEOjOmP7nT4Htp2x4+N1M9o0u3yu5gO6GYSMuvZPgN/gZc
	jpf9X5IPbZTV7mFbymrfjxcuKAAuWLyja/g==
X-ME-Sender: <xms:aumuaZwnU32w32aOtc-Ao-30yzuaRjYz6sa-dQ8kjTPH61iHHULPjA>
    <xme:aumuaQTG_EBi_DAkuM9K02N_-IgN1zo3rB8uckPSk51MiUTByw9_ax5ih544zdAe4
    HMmQF2x_Kvyn7diZU8wDfw9tF0R5lsN-UZIlKpGNKGeJhFOY2763w>
X-ME-Received: <xmr:aumuaYX1ITeAkes9dmyOu4MHTTqEDMCBEVU7AXO1eJQOgjer1lgjENrEJR5TSJjFSMghMBEtvn32C8CCJSB5Apd5Wkr0HFrHDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeekhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvvghs
    hhhighhurhhgrghonhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:aumuaaYVx4GcpImOSTw99NIUb6dhGUx-kkKEtl3S7eNwV91GlXiTqQ>
    <xmx:aumuaW2RgLWLmcNoybOYKdm2qwoDu5ZQ_xwVT2R3aWC5wb6ToxpA0w>
    <xmx:aumuaUgneK9U6_-vm7GEaO0fjYQ2QU3uqsUruoILz-kQHzNY6QPIKw>
    <xmx:aumuaSZ9vtc0cRzjlCMncbfu4JkZEbCxyPlm_tXYtYZAz1WkUXMFoA>
    <xmx:aumuaaRoPAzfWFZLN3o5MWTBOhumHsb0fMxBnd6ScOI6jLn7HuC6eEgY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 11:38:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v1 2/2] list-objects-filter-options: avoid
 strbuf_split_str()
In-Reply-To: <20260308180359.31188-3-deveshigurgaon@gmail.com> (Deveshi
	Dwivedi's message of "Sun, 8 Mar 2026 18:03:59 +0000")
References: <20260308180359.31188-1-deveshigurgaon@gmail.com>
	<20260308180359.31188-3-deveshigurgaon@gmail.com>
Date: Mon, 09 Mar 2026 08:38:16 -0700
Message-ID: <xmqqjyvl57yv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Deveshi Dwivedi <deveshigurgaon@gmail.com> writes:

> parse_combine_filter() splits a combine: filter spec at '+' using
> strbuf_split_str(), which yields an array of strbufs with the
> delimiter left at the end of each non-final piece.  The code then
> mutates each non-final piece to strip the trailing '+' before parsing.
>
> Allocating an array of strbufs is unnecessary.  The function processes
> one sub-spec at a time and does not use strbuf editing on the pieces.
> The two helpers it calls, has_reserved_character() and
> parse_combine_subfilter(), only read the string content of the strbuf
> they receive.
>
> Walk the input string directly with strchr() to find each '+'.  Copy
> each sub-spec into a temporary buffer and strip the '+' only when
> another sub-spec follows.  Change the helpers to take const char *
> instead of struct strbuf *.

Makes sense.  Instead of finding '+' and making many small copies
piecemeal, you could make a single copy of "const char *arg" once,
walk that string using strchr() looking for the next '+', and
replace '+' with '\0' before processing the current piece and
iterate, which may reduce the need for many small allocations and
deallocations, but I do not know if it is worth it.  Benchmarking
it would not yield measurable difference, I suspect.

> +	while (*p && !result) {
> +		const char *sep = strchr(p, '+');
> +		size_t len = sep ? (size_t)(sep - p + 1) : strlen(p);
> +		char *sub = xmemdupz(p, len);
> +
> +		/* strip '+' separator, but only when more sub-specs follow */
> +		if (sep && *(sep + 1))
> +			sub[len - 1] = '\0';
> +
> +		result = parse_combine_subfilter(filter_options, sub, errbuf);
> +		free(sub);
> +		if (!sep)
> +			break;
> +		p = sep + 1;
>  	}

Hmph, would this loop handle a trailing '+' the same way as before,
e.g., "combine:tree:2+"?  The original would have split the string
into ["tree:2+", ""] and the last call to parse_combine_subfilter()
would have been made with an empty string.  The new code does not
make that last call with an empty string.  Perhaps the differences
do not matter?  I dunno.

Other than that, nice to see one fewer use of "splitting into an
array of strbuf" pattern.

Thanks.



