Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.154
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794811553;
	b=JXsX8GuuOXszQgRiRz8IcCmK5wDC/njh9QAlYUGhWDRYvQNzft+L2IPAXKnpJ2s5wpHY
	 4wCRa7mrJktYB9CGpc9ZR3zsrBs/BdRdybtk8qtz+YMgLwcrHvfQPOS6Y8M3TK9EC+mlk
	 SFv24n5UQTyZup+FTpQh+Qe0KBcI+LvP9ZZdpmD6hBldmmZI+NhNsvQlHHcPd5U15ARBe
	 ZNgc3uP2qhU4qppsiADw38L520qnlymaX++DXag6vJ2QONc/HYMS3tU+j5BCSKapVjL9k
	 kLjZpxVGNi8GyJuOPxkq3sOXrbvgH4IoJWRs9LAdLV7InlyqV37fEeIAXtEPD2dFTiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794811553;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gNqdLbZB9ShQsLV2Oxi2bR8c0jgmHgrOKJ2tJpRcytA=;
	b=j9/jfoxA8VeZuYED9FVwpyZ2M6ovLUSpQ+KppJsRLoTXb+58sowe/ePeIvwLv6FpFjPt
	 ZLSbVshXGCpnbTh20OBnNs0owoXVwJ6Ss+EKwQ+0hxpJO49BrF/6xvGmEd/RZbpMbNOh4
	 F545suD15f96oLq+ntGfKHrVXCYUKGE6dY+xp4pbVGMNjbj+6TFFAW8hhm0ijlor47KhM
	 1wKZx0zEbb1ONWtKKMwqdanB/fUGklZFa6hEjDaX5sKbBkHv0tP/sBPdlJZfAZSaeEa2I
	 BbUX1o1dkVgjiWfasJICguQJncMLmKzICSYjYHMVl02FobtaTsL+CQcrY5slVEcgAzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CI5qsUbh;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Uptdgeaa;
	arc=none smtp.remote-ip=202.12.124.154
Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7EB606A323
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 06:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A7EB606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=CI5qsUbh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Uptdgeaa
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07DCB7A01A8
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 01:45:52 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 16 Nov 2026 01:45:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1794811551; x=1794897951; bh=gNqdLbZB9S
	hQsLV2Oxi2bR8c0jgmHgrOKJ2tJpRcytA=; b=CI5qsUbhOVBtchq8QHVJ0I9O1C
	pOzdAgDzcSgBWMggionR0fboSJDz1vSXpWh+BWW2+uP26F8fBYfQdENzWgmiLNXN
	VSYS1F7nTQ85QBxHwK2RRhChmz28Ev6MABOsAPg1HjvZNxCsDN3Lupxuo08r+rdK
	0Aj2BI3af3FbYNQRns3OEqpmMrGL9ptBNLqgeTxTsQj/NP0RXoTP7ZtsAk49/5HT
	GMLYm7Vho8+SXk8UAzx9acRW+7pmMG4E09kPMcRpPir+xk9rrnhHYtZ5KwsoESc7
	qiguEyXtZEn3iq13uHJ6ePWcs+/WDHjfctaZeCon6SCVcP9lY8uHOlJ/XHew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794811551; x=1794897951; bh=gNqdLbZB9ShQsLV2Oxi2bR8c0jgmHgrOKJ2
	tJpRcytA=; b=Uptdgeaa355s10H/ad6UG5ek3eiJ5p85yLNsHmc8jR8XiW8Xtma
	GNeHmR/MEUrttdYcSQ1n6B3c4cR6QBBjwdKTovck0bIFIugnaMzSqBrYlor8x1JS
	PinsVb76tH43yPlUP2jlFHXJUXCUy9jB6+0gwT+3lfbfFROsBUq7y4Lg6nJDkTYu
	cUnA5Zcjr+46FvT8KLnvRJRcR2NecAPB022zHf8f1KbFaOu2nM0WhxdHEzg+EmrG
	+riFzpolDjyufeCYbCqyVvyUCBg7/efF5Rt9mxUjpFOgeTUNBVs1ucVtt3G6e5Wa
	UsJ3GGaulE42O26Z8/NSX328IT+tzGE2cgA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794811551; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:r8BZyhIKNs0AEN1LZT0kmFkfm/c2gSfXt+OxhPIqFufUr7Q
	wN91S/RsLKkuYkT1fTjUu+wrWDqqGlbzb+OHPRmxl4vulDnuUpVpKWWHlq0rJvLw
	YazZ2lLywRCKNr+cet3a5zm/IqRqpf02eNBhk8WhiXzXy8BePY75BojqHQpANV9u
	TdE+RvI1sDJUj/J3PqtwUixmS6YEpdj4hs4YJnZuEA9GyuIbl7fRBDMsJG0zVHMK
	2ukbj0gsoD8hq45JuDdfSpWEy/zPD4ixh6XZfrcS51wmEgCGCswq57TCqzFWgjil
	HwxLMYmSLMqd8+8NnAANJ/xSJINAiZzJT47b9Ig==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:ZayZd6FwAA+FtgSF97ssYASqOEEiRAkXd4HF8MJ7WLM=:Q5uRHB3gr0kICuNGRI4QD8hkw2iEodahjfBByQvvPpM=;
X-ME-Sender: <xms:n6b6ajOgRv4PVY-MVbzCykSKe-UOIE8uIrqUIjF9I-itIS77fKALdA>
    <xme:n6b6ahpJdZgEHU_OtXCNWXIC37Zrnm7y7TwymTsr2qg1uCegoEidEtrbUVxINhdl0
    Ymh0KhE5fdm6W3Yg54jRWjq1W_14i3ZUfX8ge2HvrxFnRxLQZtg>
X-ME-Received: <xmr:n6b6asHWWIKHH3OGwhoFVjfgSh-lziOaXgVhBxRxX9lKyDuq8NM2WU-THpXKQPgxUTsIir4>
X-ME-Proxy-Cause: dmFkZTEZ6wNe1Au1L+vgTg6ldUbWmfXrYlrpBEBg0ISB5GoRZcMNK9TN/252KQn7ZBonb3
    FDs3+tDBcn2B9f68zbx3dG0W4kMXRPdzTfWBP1weNz6XNKSTM6WSNeE4TUHQMdcW6XEHf5
    CEC06nC9GGIF2sgckpmsk1t/gfttJ+XgfYBxemdS7goKrxsrHOdyOrLwRuq7ijQe/S6NDg
    WV5/0cfgU7+vcBq5UDjYICWGK35RyPdQuUk/SFY+O5TZpBUKY005ILqiaTRVv6NmWQg23M
    8MLZL+yPj4Nw8qcgginn/5+b7tT9NPWhyeHvBscuAQJw4N6pUtv1mfN9PIhRErQ0uRqUSe
    kci8N536T6uQwBExZRBfuVslp+DGoRWCEWc/B0GJO0ZOw7c/INpejqLa2Fme/Lst/T1R2L
    26qhsviRtxE54U+Cxhi9D9AHqL2l27/ShMCnVd/Qwn+kC94NOS2mFZlFgri7XCTI78v9jw
    gntXSnh/7vRg90u37Bc3eophV9lQZEskG9z1CrieAZwOKezhuY5wumgYVY+4vkbUobxGdz
    g8j7eUJMIwOmBLzkkKe7PPf63lB8LiZtThbbH35bCAJ/+B9OxCGUky/JuUXjl0/4bqsD8x
    RlZeHfzSuzHjDAB9AJinS1RBeqY7evKJB+euW2qUMR1NMDxBRu8okH6rE3Dg
X-ME-Proxy: <xmx:n6b6aupFnowdHnc1sFLwpEvFln2gp88G8wBQo-j9XAZludpfhxqRFQ>
    <xmx:n6b6atbPYdi3vxSyTCpyK6xFasHl-c6I2f9YCwpMriddOlcN7b45ZA>
    <xmx:n6b6avXg175TFTAAVL4E_UjyO6a_SLLMFeSXO3vrxMZH4xkbmzsyFQ>
    <xmx:n6b6au9c6xuz1hx5cNoten82KQ6K44nTlglFOMNn9SzKNBh0F1zjdQ>
    <xmx:n6b6amnQchz9gnExg-RoTfjlqKMeDDsb24VTDtN2G1MRu9-7NwbAArHc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 01:45:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 113cb48d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 06:45:48 +0000 (UTC)
Date: Mon, 16 Nov 2026 07:45:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Abhishek Agarwal <agab0323@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Victoria Dye <vdye@github.com>, Meet Soni <meetsoni3017@gmail.com>
Subject: Re: [PATCH v2] for-each-ref: avoid segfault on --no-format
Message-ID: <avqmmRF9tbFLvlM8@pks.im>
References: <20261113161413.15688-1-agab0323@gmail.com>
 <20261114183718.57552-1-agab0323@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261114183718.57552-1-agab0323@gmail.com>

On Sun, Nov 15, 2026 at 12:07:18AM +0530, Abhishek Agarwal wrote:
> The "--format" option is declared with OPT_STRING(), so the
> parse-options machinery also accepts "--no-format" and sets the
> format string to NULL. The default format is assigned before the
> command line is parsed, so nothing puts it back, and the NULL is
> dereferenced in verify_ref_format():
> 
>     $ git for-each-ref --no-format
>     Segmentation fault
> 
> "git refs list" shares the code and crashes the same way. The
> problem dates back to c3428da87f (Make builtin-for-each-ref.c use
> parse-opts., 2007-10-13).
> 
> "git branch" and "git tag" have the same option and fall back to
> their default format when it is NULL. Do the same here, and assign
> the default after parsing the command line when no format is left.
> "--no-format" then cancels an earlier "--format" and gives the
> default output.

That behaviour is a bit on the weird side if you ask me, but so be it.
It's definitely better compared to crashing.

> Marking the option with PARSE_OPT_NONEG would also stop the crash,
> but then "--no-format" would work for "git branch" and "git tag"
> and be an error here.

Yeah, being consistent is the better pick, I guess.

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 4a2fc421db..4390f3f5e9 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -52,14 +52,14 @@ int for_each_ref_core(int argc, const char **argv, const char *prefix, struct re
>  		OPT_END(),
>  	};
>  
> -	format.format = "%(objectname) %(objecttype)\t%(refname)";
> -
>  	repo_config(repo, git_default_config, NULL);
>  
>  	/* Set default (refname) sorting */
>  	string_list_append(&sorting_options, "refname");
>  
>  	parse_options(argc, argv, prefix, opts, usage, 0);
> +	if (!format.format)
> +		format.format = "%(objectname) %(objecttype)\t%(refname)";
>  	if (format.array_opts.max_count < 0) {
>  		error("invalid --count argument: `%d'", format.array_opts.max_count);
>  		usage_with_options(usage, opts);

Makes sense.

> diff --git a/t/for-each-ref-tests.sh b/t/for-each-ref-tests.sh
> index 4991a82b91..3e0108a7db 100644
> --- a/t/for-each-ref-tests.sh
> +++ b/t/for-each-ref-tests.sh
> @@ -285,6 +285,12 @@ test_expect_success 'Check invalid atoms names are errors' '
>  	test_must_fail ${git_for_each_ref} --format="%(INVALID)" refs/heads
>  '
>  
> +test_expect_success '--no-format restores the default format' '
> +	${git_for_each_ref} refs/heads >expect &&
> +	${git_for_each_ref} --format="%(refname)" --no-format refs/heads >actual &&
> +	test_cmp expect actual
> +'

And the test looks obviously good to me, as well. So this patch looks
good to me overall, thanks!

Patrick
