Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920F2360
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 06:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733553351; cv=none; b=cb8SLZzVHGDP3t2lqEwpoteN+a569qpCN1fRWI3+WsmEh4yydZQ/35jf61PSmRzImAgbUeE4IjR4al+HFqtMgu6KTFoNMViCvnIgZ4tb8rHOjKU8BzA2pYP+/LrGOrPhSP4xBeIceBpC9S1H/hFRIK75DrHSSXzHLp2JRoNaTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733553351; c=relaxed/simple;
	bh=cOVU3F1L0UTPqT4C+fZgWmKoJqiqwIHlxt9yhHUl/lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e5i7/MJADTcDJccztFrxpRj8qCwDqEwYHKnj/LtrwYHd6AUHr+KM9cSUIH9YIKNE0RfEXHby1iDHk9KCujg4eUfqg+p5ZHCgL0OwiXh4r53lExwWAPHnTL9l3e53Ts7ajmmWhz8CmqWrVJmUR2rgXrh6WN6/FGHWW9wXOztIwu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wIwTtd03; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wIwTtd03"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 73FEA13836F1;
	Sat,  7 Dec 2024 01:35:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 07 Dec 2024 01:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733553348; x=1733639748; bh=ZoxUwiDzPHNtuK2CQ8k+MHZs1Cn0w5Hm5kt
	V+pMBoAo=; b=wIwTtd03HxNN8UVFhjDLhOnX2KIlghQtALcFqzKBe9p8Y1KgLTV
	FvP9RqXCuhowsOopS4CC9j6W4Qu5Y3viid93hFwtaX+5MLl6s4nTWXgpMvz6BRl+
	SPxvVD/Po/yYnYAy3U3PI8lICbO4E80vJOsiMKuMNk30HzuAAfr4hnyWTCJAslpk
	AHRFM6NfLJ5FwuNd+uhJVqSsz+bf1NzcxUWkfVUsGGBWyJOqU9a0180I7s5l5+jN
	R1OrSsC2efVUReGAJnlye7ySWzCewaWoigDkYpBOH+TyA5LsMNtUziftoOLUXpvf
	KZlKHN3lW5eKXnxew78CTui8NgUll9Twe1Q==
X-ME-Sender: <xms:w-xTZzlhOy6cUSDXCfd2FIfY4tU9miQg8vEUDlSiYYMDGHzsczBi1g>
    <xme:w-xTZ223I19RCJSWkYKo_6oTm-MRdfK9NSYVFvMM6hKq5GxiWndjVZSwRusH7O-HM
    5nFY2QxHwNq2X13gg>
X-ME-Received: <xmr:w-xTZ5pf3S61-R7ck_IPotPJKxGVtWE2hSqwTp63JK6j8Qhcfpqjsii4xZQazrK3f_orNR_sGSVpyh_NaENPSDfE3BFtEQb5groCl68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedtgdeludcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:w-xTZ7l8AcsRODwAhEfp3GFF_ikXOogQjLBL41eKcSQdsk-8oXzgvQ>
    <xmx:w-xTZx0VgGoJFvOqlz5R-8Rc2qUqykSagjwOJ_EzbTH9YJqRJA9BJQ>
    <xmx:w-xTZ6unI4mX7CrZemUB1Sq9b7fHHdRThdhNnJJTio42QpRlpcFfzQ>
    <xmx:w-xTZ1WXE7unW3At2KlBsGWSnSeRG_74GBb0svJMTCsqjOlUN2ogNA>
    <xmx:xOxTZ6Jia-or25TA6xxM8cJjnqwIr2GCTs0kpAbz_klrqJ3DGtAXFhVW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Dec 2024 01:35:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 2/5] strbuf: refactor strbuf_trim_trailing_ch()
In-Reply-To: <20241206124248.160494-3-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 6 Dec 2024 13:42:45 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
	<20241206124248.160494-3-christian.couder@gmail.com>
Date: Sat, 07 Dec 2024 15:35:46 +0900
Message-ID: <xmqqzfl8t2yl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> We often have to split strings at some specified terminator character.
> The strbuf_split*() functions, that we can use for this purpose,
> return substrings that include the terminator character, so we often
> need to remove that character.
>
> When it is a whitespace, newline or directory separator, the
> terminator character can easily be removed using an existing triming
> function like strbuf_rtrim(), strbuf_trim_trailing_newline() or
> strbuf_trim_trailing_dir_sep(). There is no function to remove that
> character when it's not one of those characters though.

Heh, totally uninteresting (alternative being open coding this one).
If we pass, instead of a single character 'c', an array of characters
to be stripped from the right (like strspn() allows you to skip from
the left), I may have been a bit more receptive, though ;-)

> +void strbuf_trim_trailing_ch(struct strbuf *sb, int c)
> +{
> +	while (sb->len > 0 && sb->buf[sb->len - 1] == c)
> +		sb->len--;
> +	sb->buf[sb->len] = '\0';
> +}

So, trim_trailing will leave "foo" when "foo,,," is fed with c set
to ','.

> diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
> index 22a99a0682..9da1f8466c 100644
> --- a/trace2/tr2_cfg.c
> +++ b/trace2/tr2_cfg.c
> @@ -35,10 +35,7 @@ static int tr2_cfg_load_patterns(void)
>  
>  	tr2_cfg_patterns = strbuf_split_buf(envvar, strlen(envvar), ',', -1);
>  	for (s = tr2_cfg_patterns; *s; s++) {
> -		struct strbuf *buf = *s;
> -
> -		if (buf->len && buf->buf[buf->len - 1] == ',')
> -			strbuf_setlen(buf, buf->len - 1);
> +		strbuf_trim_trailing_ch(*s, ',');

And the only thing that prevents this rewrite from being buggy is
the use of misdesigned strbuf_split_buf() function (which by now we
should have deprecated!).  Because it splits at ',', we won't have
more than one ',' trailing, but we still split that one trailing
comma because the misdesigned strbuf_split_buf() leaves the
separator at the end of each element.

This does not look like a very convincing example to demonstrate why
the new helper function is useful, at least to me.  

If somebody would touch this area of code, I think a lot nicer
clean-up would be to rewrite the thing into a helper function that
is called from here, and the other one in the next hunk in a single
patch, and then clean up the refactored helper function not to use
the strbuf_split_buf().  Looking at the way tr2_cfg_patterns and
tr2_cfg_env_vars are used, they have *NO* valid reason why they have
to be a strbuf.  Once populated, they are only used for a constant
string pointed at by their .buf member.  A string_list constructed
by appending (i.e. not sorted) would be a lot more suitable data
structure.

>  		strbuf_trim_trailing_newline(*s);
>  		strbuf_trim(*s);
>  	}
> @@ -74,10 +71,7 @@ static int tr2_load_env_vars(void)
>  
>  	tr2_cfg_env_vars = strbuf_split_buf(varlist, strlen(varlist), ',', -1);
>  	for (s = tr2_cfg_env_vars; *s; s++) {
> -		struct strbuf *buf = *s;
> -
> -		if (buf->len && buf->buf[buf->len - 1] == ',')
> -			strbuf_setlen(buf, buf->len - 1);
> +		strbuf_trim_trailing_ch(*s, ',');
>  		strbuf_trim_trailing_newline(*s);
>  		strbuf_trim(*s);
>  	}
