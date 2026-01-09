Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC3235B12B
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962313; cv=none; b=bhx6oItxq6ZDJE4cj5stzlQDtQCTP/y8eX2b4gcMmMTkDPYRzUDFmXccB0GPNlljKx+mMiK7FkdGoqhBiJaPDfs5fmgevYwjSX5kOHHir/DoaCS+nBYPerkwvzNJc9T8DzB4+uK+bwhR4+FlTyP0oQUF4pywr3kajsCUmYC6dVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962313; c=relaxed/simple;
	bh=WZbLSTw6eGZ7Y215b9CfcxvdREvqII0BAO0JVmcpOFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHKPsKCKFr/L7B1QRnlZbOJ8RJF4K+wwjk8JPK2+WBB3L8ExF2ktaPzqgnocbpUbZ6el4keaW0793SwPx21POo/KBHTiZt/a1nuiQg4OU9IFGRPPL/jAp4mEhi9NRGY4XO5ECXK3SSA4+5uC31AoTvxqprLtaJ4wPaH3Z0VgrkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TzsHloLj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RB5Go4U5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TzsHloLj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RB5Go4U5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1E6057A016F;
	Fri,  9 Jan 2026 07:38:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 07:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1767962310; x=1768048710; bh=WEuULDAsLi
	D/VtDG9BXzC043OCijvkpglpDrReqYy+g=; b=TzsHloLji/2yAWx+RG1XV5KLVk
	pLVCTt+7DJq1JyIIbJXy/X24n6FNsE3FjlLbeOfmSRTjczGOOKxGXFmVhY+UQufJ
	hbJII23QP6hwJUbd/ShQjQUUdRg19y/jSbLkGvrbg8NNrAJqFPJWDDWzQ/L9BWWb
	/qcAc74zbBCGK42wtjSjzm1gY+wZHyX2UwbmNdGXIyOL4gx+zV7kt3OKxUOmCAoH
	Yox4GGQ3g5TsOR9bqXzFrPzYp2ogHXdXdXeRuRPEBZAE47j9WTnrJGxvz4AeVRan
	iKOMAEGjptOZ6vMRrfWcd/K7x2+0u/9rmoC81r0hNsMDxQr1/eWtx/k4C+aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767962310; x=1768048710; bh=WEuULDAsLiD/VtDG9BXzC043OCijvkpglpD
	rReqYy+g=; b=RB5Go4U5e4SHCLTffVNgmx12ZX892TMYZFgU42DK2CxT/dThD6O
	K4kWl1m6TIIV6a41c8O2PUzL5GNTJIjf7bqSvTEX7kT8kNlBmSJAo2NwE904nK+O
	4jX6jElYTGmwhFA6h/YJBRP/nP5YOctsMohtTrV/+KL9QlqLUfUJ17Z586tsKFFn
	QIV9bOg1yj5V1/SkzmBuh44tGukQAUEq6O3kG/GtpcjVZJQylH/QphybH2xFuCcb
	rxFYEzETUJEq7ySYdIRyZ0Z2+nBMvhNfXAjrsEFMJe9sVfOHy7312Z5CotRdrMzJ
	D8Y1Tlb+J9wFxCv2+jJtfLGl96HoLAM2gKw==
X-ME-Sender: <xms:xvZgabEeTc9PwXrrmwAWw-WkfdMXPNHl8afYjrAbXA2uMBmNKvfOdg>
    <xme:xvZgaakbY1Xc0YibabAbOPtAdD5ytavvIDal7JU2a2qV5rYYEXi9lDxxtmTx6DNoJ
    pTXKZo7CSPxpej8axA8usdWcNZMY2_hIlEXTRCvGj7EGZszhgOjBA>
X-ME-Received: <xmr:xvZgafZ4HF8J9rNHBtxaYnAY-DiCfMhbKCIBTCSkdzkK79LRgj5XT9KtRmRuGgCt6sCo_EbSl43qXO0NS8ZxpoeJbkB5WCUDj-8CXZzh2w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epudehtdeutddvtdfhkeeuveeijeefgfeivefhtdefhfduteeigfeugfefgfejtdeunecu
    ffhomhgrihhnpeifihhkihhpvgguihgrrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthht
    ohepjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstg
    hhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhgihhtghgrughgvght
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepshgthhifrggssehlihhnuhigqdhmieekkh
    drohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehophhohhhorhgvlhesrhgvughhrghtrdgtohhmpdhrtghpthhtohepshgrnhgurghl
    shestghruhhsthihthhoohhthhhprghsthgvrdhnvght
X-ME-Proxy: <xmx:xvZgafHyQ3mqvrZXC3665Lg4gIqsi-IcsaRlR0lioG6W4RBZMfkWbw>
    <xmx:xvZgaQLLE-qwulVeFlx6YquzFgz2T8_4oG7XCI4ykZ9Y6nBPw5UlpA>
    <xmx:xvZgaaOb9qZBMrUpG_Oy8uPaxynA23Dp-tdozwcip11WjT_94didyA>
    <xmx:xvZgaQkS8-5DZ0UtVlU5EwqeJE7cGEoBh5_OL0eBnEzaauQFTTw5bw>
    <xmx:xvZgadWybdHSWHkTOYyOKejVy0ejya4BlZtiijckKkm9DCnfg1v8YjDN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:38:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7de371d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:38:28 +0000 (UTC)
Date: Fri, 9 Jan 2026 13:38:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Ondrej Pohorelsky <opohorel@redhat.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 3/4] sideband: do allow ANSI color sequences by default
Message-ID: <aWD2wpyOo0Tr34OD@pks.im>
References: <pull.1853.git.1736878772.gitgitgadget@gmail.com>
 <pull.1853.v2.git.1765981422.gitgitgadget@gmail.com>
 <44585ba1f4223f053820d82f1513c2258e1e0059.1765981422.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44585ba1f4223f053820d82f1513c2258e1e0059.1765981422.git.gitgitgadget@gmail.com>

On Wed, Dec 17, 2025 at 02:23:41PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The preceding two commits introduced special handling of the sideband
> channel to neutralize ANSI escape sequences before sending the payload
> to the terminal, and `sideband.allowControlCharacters` to override that
> behavior.
> 
> However, as reported by brian m. carlson, some `pre-receive` hooks that
> are actively used in practice want to color their messages and therefore
> rely on the fact that Git passes them through to the terminal, even
> though they have no way to determine whether the receiving side can
> actually handle Escape sequences (think e.g. about the practice
> recommended by Git that third-party applications wishing to use Git
> functionality parse the output of Git commands).
> 
> In contrast to other ANSI escape sequences, it is highly unlikely that
> coloring sequences can be essential tools in attack vectors that mislead
> Git users e.g. by hiding crucial information.

The worst that they can do is to set up both fore- and background color
to be the same so that text isn't visible. But I think that's an okay
tradeoff.

> Therefore we can have both: Continue to allow ANSI coloring sequences to
> be passed to the terminal by default, and neutralize all other ANSI
> Escape sequences.

Makes sense.

> diff --git a/Documentation/config/sideband.txt b/Documentation/config/sideband.txt
> index 3fb5045cd7..e5b7383c7a 100644
> --- a/Documentation/config/sideband.txt
> +++ b/Documentation/config/sideband.txt
> @@ -1,5 +1,17 @@
>  sideband.allowControlCharacters::
>  	By default, control characters that are delivered via the sideband
> -	are masked, to prevent potentially unwanted ANSI escape sequences
> -	from being sent to the terminal. Use this config setting to override
> -	this behavior.
> +	are masked, except ANSI color sequences. This prevents potentially
> +	unwanted ANSI escape sequences from being sent to the terminal. Use
> +	this config setting to override this behavior:
> ++
> +--
> +	default::
> +	color::
> +		Allow ANSI color sequences, line feeds and horizontal tabs,
> +		but mask all other control characters. This is the default.
> +	false::
> +		Mask all control characters other than line feeds and
> +		horizontal tabs.
> +	true::
> +		Allow all control characters to be sent to the terminal.
> +--

Nit: I think that our modern doc style requires the values to use
backticks. E.g. "`default`::".

> diff --git a/sideband.c b/sideband.c
> index 997430f2ea..fb43008ab7 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -40,8 +45,26 @@ static int use_sideband_colors(void)
>  	if (use_sideband_colors_cached >= 0)
>  		return use_sideband_colors_cached;
>  
> -	git_config_get_bool("sideband.allowcontrolcharacters",
> -			    &allow_control_characters);
> +	switch (git_config_get_maybe_bool("sideband.allowcontrolcharacters", &i)) {
> +	case 0: /* Boolean value */
> +		allow_control_characters = i ? ALLOW_ALL_CONTROL_CHARACTERS :
> +			ALLOW_NO_CONTROL_CHARACTERS;
> +		break;
> +	case -1: /* non-Boolean value */
> +		if (git_config_get_string_tmp("sideband.allowcontrolcharacters",
> +					      &value))
> +			; /* huh? `get_maybe_bool()` returned -1 */

This case is something that shouldn't happen in practice because we know
that the config ought to exist. I guess it _could_ indicate a race
condition, even though it's extremely unlikely to ever happen. So I was
thinking about whether we want to `BUG()` here, but I guess just
ignoring this is fine, as well.

> @@ -70,9 +93,41 @@ void list_config_color_sideband_slots(struct string_list *list, const char *pref
>  		list_config_item(list, prefix, keywords[i].keyword);
>  }
>  
> +static int handle_ansi_color_sequence(struct strbuf *dest, const char *src, int n)
> +{
> +	int i;
> +
> +	/*
> +	 * Valid ANSI color sequences are of the form
> +	 *
> +	 * ESC [ [<n> [; <n>]*] m
> +	 *
> +	 * These are part of the Select Graphic Rendition sequences which
> +	 * contain more than just color sequences, for more details see
> +	 * https://en.wikipedia.org/wiki/ANSI_escape_code#SGR.
> +	 */
> +
> +	if (allow_control_characters != ALLOW_ANSI_COLOR_SEQUENCES ||
> +	    n < 3 || src[0] != '\x1b' || src[1] != '[')
> +		return 0;

This would break in case `allow_control_characters` allows _all_ ANSI
sequences. But that doesn't matter right now because the function is
only called via `strbuf_add_sanitized()` when we're sanitizing at least
some characters.

Might be worth though to add a call to `BUG()` in case we see an
unsupported value for `allow_control_characters`.

> +	for (i = 2; i < n; i++) {
> +		if (src[i] == 'm') {
> +			strbuf_add(dest, src, i + 1);
> +			return i;
> +		}
> +		if (!isdigit(src[i]) && src[i] != ';')
> +			break;
> +	}

Okay, so this loop scans until we find the final "m" character that
terminates the sequence. Looks good to me.

Patrick
