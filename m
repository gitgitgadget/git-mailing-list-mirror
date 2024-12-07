Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C124A1C
	for <git@vger.kernel.org>; Sat,  7 Dec 2024 06:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733552474; cv=none; b=i1Gz8MVz6i4pabCHR4rkcK+jCsHVchmSIcRkAjCJw2ZPiO+GSHV2ZFNzBINnZDf+8Bwwy0zlLXpafIS0E5LilZyzGJJwtvhYYRKoXbfIYVDgWuAQnsB7FOwDdc6rwH417wn+4NKJlDCWYe1NIaHtRA/LQhI2QBk+ZxfRajNli+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733552474; c=relaxed/simple;
	bh=gkkBVZ+mHzB8oKy4Tz2/7yfNfvG+BYwbJ8tGHMmBfds=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LKWGcmo63b/xlxo6ns/rIIKOb0O6p7IgcZTh+U2ofLk0NLbp1XiumIWSf19fLq5QYlr3i0jIZazp+ueytDwACUbVzr+QFS0bhnVQOt2Alc4L3b4QhJoyADymrm29ilAehe4AANitl/qg0mXEf7RlwWNAhwAXweX3dFhZj5RnLGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QlSRw6s8; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QlSRw6s8"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1AA321140196;
	Sat,  7 Dec 2024 01:21:11 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sat, 07 Dec 2024 01:21:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733552471; x=1733638871; bh=NqwCYURwjRhl1jCsz0FhqhDyX1x07McW16q
	L/dG+vP0=; b=QlSRw6s8PEkeyCg4sSy/V+Ds3847bzGMc2WIMzbDmiw+a3aLOLh
	WsmRyNNVbIakRswqpnvQFXVK327sEjI2NHjN6GgqDlVwRfdN2UPZrtuA1gqtE6Ac
	yxjcQxwsEbsHamRl121O08svTHhTLkdrnA4MBUMh0ON/ekBwL33OyXIKCkpelcF/
	AHcczucseUVU9j98EVXiDmWDloPNDXg08iSKsGhRPr7RSVsRk/8GFY3lSb02PUeF
	nCbIlEvRMkWcYF9OKKqhJ7GFW4/7ETZ0davRTVhauaRDFYvcgRSu2s14+srAC8Th
	15mM86BfLNPXJld6AP5FixHLS38CK7eVgpw==
X-ME-Sender: <xms:VulTZ8rht6_AuYbcPPBijh6JxjWv6sY4xf8TV6FHmOJtd2OaUJa_qQ>
    <xme:VulTZyq7VKCGq4NzhXYGw1quaCiwHB-6XDjS9VNXLL4cgllDTbwchOVago72UBbhD
    Nt4dtgFpkJkAoIhOQ>
X-ME-Received: <xmr:VulTZxPFU1KHLRDx-AfhCpteS4o_eUVgihnZqw_sBfhoZCGPLt9kzpvNYw_VnbnDJCy4n0GI5lPdYwZ6XaG6P0-uXCTE6ka2_K2vW8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjedtgdekkecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:VulTZz5nIb01LXA8xiXwQZF6qUkugPIDsMB-sUPx--wcsJMvS06jwQ>
    <xmx:VulTZ75tZrfvSdq9yrajIYyeFGcisb-vk1TNJvzyGlxt-X-3niKz1g>
    <xmx:VulTZzgKRI3xeel6-jsgFylPeTdtDwNNIl6h-XPP25jvVRwrl2ECew>
    <xmx:VulTZ147ZLVlIMHDFeZVomWimQK6uKnaQXj2f2EuV1YDDMooG6MHNQ>
    <xmx:V-lTZ1sYGjMs1xmr_PQlmoDljJx5AxOuysZ2u4amIwXqRKFUsREAURRF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Dec 2024 01:21:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 1/5] version: refactor strbuf_sanitize()
In-Reply-To: <20241206124248.160494-2-christian.couder@gmail.com> (Christian
	Couder's message of "Fri, 6 Dec 2024 13:42:44 +0100")
References: <20240910163000.1985723-1-christian.couder@gmail.com>
	<20241206124248.160494-1-christian.couder@gmail.com>
	<20241206124248.160494-2-christian.couder@gmail.com>
Date: Sat, 07 Dec 2024 15:21:08 +0900
Message-ID: <xmqqfrn0ui7f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> +/*
> + * Trim and replace each character with ascii code below 32 or above
> + * 127 (included) using a dot '.' character. Useful for sending
> + * capabilities.
> + */
> +void strbuf_sanitize(struct strbuf *sb);

I am not getting "Useful for sending capabilities" here, and feel
that it is somewhat an unsubstantiated claim.  If some information
is going to be transferred (which the phrase "sending capabilities"
hints), I'd expect that we try as hard as possible not to lose
information, but redact-non-ASCII is the total opposite of "not
losing information".

> diff --git a/version.c b/version.c
> index 41b718c29e..951e6dca74 100644
> --- a/version.c
> +++ b/version.c
> @@ -24,15 +24,10 @@ const char *git_user_agent_sanitized(void)
>  
>  	if (!agent) {
>  		struct strbuf buf = STRBUF_INIT;
> -		int i;
>  
>  		strbuf_addstr(&buf, git_user_agent());
> -		strbuf_trim(&buf);
> -		for (i = 0; i < buf.len; i++) {
> -			if (buf.buf[i] <= 32 || buf.buf[i] >= 127)
> -				buf.buf[i] = '.';
> -		}
> -		agent = buf.buf;
> +		strbuf_sanitize(&buf);
> +		agent = strbuf_detach(&buf, NULL);
>  	}
>  
>  	return agent;

This is very faithful rewrite of the original.  The original had a
strbuf on stack, and after creating user-agent string in it, a
function scope static variable "agent" is made to point at it and
then the stack the strbuf was on is allowed to go out of scope.
Since the variable "agent" is holding onto the piece of memory, the
leak checker does not complain about anything.  The rewritten
version is leak-free for exactly the same reason, but because it
calls strbuf_detach() before the strbuf goes out of scope to
officially transfer the ownership to the variable "agent", it tells
what is going on to readers a lot more clearly.

Nicely done.

By the way, as we are trimming, I am very very much tempted to
squish a run of non-ASCII bytes into one dot, perhaps like

	void redact_non_printables(struct strbuf *sb)
	{
		size_t dst = 0;
                int skipped = 0;

        	strbuf_trim(sb);
		for (size_t src = 0; src < sb->len; src++) {
                	int ch = sb->buf[src];
			if (ch <= 32 && 127 <= ch) {
                                if (skipped)
                                	continue;
                        	ch = '.';
			}
                        sb->buf[dst++] = ch;
                        skipped = (ch == '.');
		}
	}

or even without strbuf_trim(), which would turn any leading or
trailing run of whitespaces into '.'.

But that is an improvement that can be easily done on top after the
dust settles and better left as #leftoverbits material.

