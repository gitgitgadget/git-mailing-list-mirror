Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793975135;
	b=r8DKnDiSgE5lQcxoRDEXJJ0F3XPGGgj2vSfj49GPtFQPr/G835Rwre0vkRtVTU/CMDmx
	 AzpSXr7d7U5eCxtuqdZPlYjFJoeDsJAhwQzCD1lSS8T55Jl0qJN8Qx2jNoF5lv4qGAFXu
	 cKaruqxi7Y2F/E0NqYwUp2GvUq1LyYVyDJ62szIPbcgPP5+c49iG9SGFPYG+Quo2mY0pi
	 t+IkXoUmg3SBEkRzwsuyVQnWdtYXcKsazSzlOM8Nl39GfIAAjvcIe1cG/mKGI873tLflz
	 Mz2+hvpO9KqxfYTaTlEPrwXGdH5kvyxwxN0enR7Q8cF4Qjgy5nL28+Q4P5uZaHBn3EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793975135;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FHpYYYaN4KH2u8qSz6VzZjMTOYfL/FxxH6Z8TvwnipU=;
	b=qY8lVuDc1v+Fnddb1wAs7o0WKxf533gWzNUSsrsomM1ytRB6LYKwqbKLIDPEyrow0Qg6
	 xmddvNfJMJci8F2w/LpkWMCTIzpul+IiBqR0yF+etWcXjglGJaJTT5uBkx+ThXdOKUgbb
	 pBrk1gr/o6naQjSxTnpqFveizl3cb/06NRy7QBWCjZjdlmh9YN2z1cTN8PrUEhHFy1u+3
	 srVTMRNQ4cbTbQs+2j5K87dNol/xXfiMzryWoGoVEkMotZwc/JocG78R/4bJvwEStrdeJ
	 i8Z1ojfRIdahnpMDC7a2IhMMJnwWzzN27eUUk0hRyujQBY0xWZO0I6G0g8jRuJc3QCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=sb7CHF91;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D6C7jEKG;
	arc=none smtp.remote-ip=202.12.124.157
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9B4606A32C
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 14:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D9B4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=sb7CHF91;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=D6C7jEKG
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5F6817A00B8
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 09:25:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 06 Nov 2026 09:25:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1793975133; x=1794061533; bh=FHpYYYaN4K
	H2u8qSz6VzZjMTOYfL/FxxH6Z8TvwnipU=; b=sb7CHF91M7fwj+jVppp7R5vzVQ
	UTVl35oj0mQiQ/bqKlUJHiVa6SP9821eNFs9ALP6WJZaeApr/i9wE2E7xQRILNH9
	F04yiB8IlKRJSzpFzfUlNEPC4K7mDAMRMpy03yWS/YsKGeX4KWafzdMyzZfwDqhB
	ykWPovoRp6hCZq/e3St5OMcqaDkXiTEVthvandlgkTPfSsHuEh/qXUXfFT8bXHiA
	f/cK/hJTf3zAUUFlQIMvecvogA2Wr/orPXQK3I15xRdfEh9M/GgF77cDv0Z8dmdF
	NdzCE3bAOVMmaNKnJmXJTYT4VCrMrbrsuxuypl90HqTfbQJGeIxtfatJRTWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1793975133; x=1794061533; bh=FHpYYYaN4KH2u8qSz6VzZjMTOYfL/FxxH6Z
	8TvwnipU=; b=D6C7jEKGHNqI7N8fJuGEAez3Ly8G/sWHwajmD1S8q9fZGofZtp3
	xQv70K0e4/9VG1ETQLcY3yNlC3LQ/kkXTU3CFTkPP/ducDPbJQDriDiPVaG0B4Yv
	K1IF7bSTLmtjV2+OPa/5SqSGCbftryFCnZ42TbTooL3e+hf3o+oLCayteWIzXK0q
	0nPy9UV2rkSAEV2xpM5XuwdqQa0lg4yEQ6pozzzUGOMTebbfOp3Dg1oRvCEhbE2X
	oyhlT+K5hPHOiQKEnccrw10+Cu3A7m41R5eksEylmlcPlu3BR3Hs65YCsQEZ8aiO
	vJqw/Yjr8TfKrs+dDiL4X0LoO9+CZeKf+6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793975133; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:0MYbaOBkvsy/1h+H60Pc+IkLBVU0ZLIECXNqjY+YkisvQG/
	BmI0UOHeu794AlL5er3C+Mg1i924jrYJ9cJ89ad2F7+emq00UeWxXgxVTm3uSNNu
	qDqw8ZDEpw3dFxGYAdQB6E6NMZEvqehy8GSL4s3F+CH8uc6BCUOSZJGUJbysRXXT
	ioiwJ/uszFHWqJveykQW6xu/MJKKmiIHM0hcIUkeOzwn4rBsAI9t9hPnrWlXDo4A
	wgIS2cCLConceHyC9gUZNWbDQpcweGl30AMe9DPu+4NB3LkCLY+bI5d9Jfzt+q4C
	u8WFPl55He8sBn40dh2Zs7JToWj65po8jZsb2ZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gK724cNlbPiR84uGDao1GnuXhMCQcqm/ZUOlUt5xOsc=:PqJuIoJkzHCbPF+FG6f/fCLYtZU8MkOETekAJJ683Kc=;
X-ME-Sender: <xms:XePtaq2q1iTc1FVndC0XOd0Fi_HHz-WJ-LFTq5Zjji3SVkxa3oZ-NQ>
    <xme:XePtakHaaE3V0ojVfPssPX9Vw88kfCCRNvTMJja7_ltGLKB3-gP7MH3nimiiuhs7_
    jPfNeQrfKbKkHZohpIL41W5ycK83TUJ5qeWZHoxK20u1spvUfsW7xw>
X-ME-Received: <xmr:XePtan5hkSlAAlTZxt-HqSi7laCk5NYtgsUToN1engb5yg5iuxsVTTdBWrQRR949fvIkjw>
X-ME-Proxy-Cause: dmFkZTGlPCBXI0rlarZsE2MQREDzcuAmauVC7N63RyOgfdNgCw0Dflz5+tUSz32igigWkB
    Jws+HFMq16dyW5UvWzzvWR2rLUkNUMPTKHTzuX/eXd2yZXM+sLKZnwZXj4xM7oBpx8yUz6
    jx5tlrXYKRwQ6RV860IWazDHOWZuO+eparw5EYSCSlPx77O6+HH0JRkvQ5n9lTZIwOAhN1
    0Z3E9iZucyZfw3eKAx9Z9UGXfSrrl3/iTEVg+ndhEBSQ4dm8qst5M8g9tZyj5VNcUPI8kL
    qPxQbV7n2tQ39DzNN65xqqi1esHsLraBkJkN5LrcL0R0SGDNrbyjswlJH3AMixwdRZxXPm
    ASzihqHz8WaoJrWhs2r08lK2durIPeG/owvbs0q0SG7z43BG1tBwdBWYlVHKfSebniFytK
    lObUAUmSo1+L037Pc8KjIHfms4Kpyg2DEJ1t5hRguB1bl+tVNnlFs4CeUgmuVyk0+rm4h/
    2l3/S7k6/BEZJSr5zyFvEn8BuxnmsyFSd9tLj3BF7MglfFi1OMKXEbHw0k3ZKIdIr+2HoT
    MYkTRUINqk7r+J9apGUPMF9oQpU5B0NV0XuvisAq4VkmVw+hMoiSbtdc0I9jMXXKhALhdD
    4FMia6nVvkFXvnCYDGNR2HGRXbwoDRrWXhTOOW4j/dMFP3wbzuxoKpwRewuQ
X-ME-Proxy: <xmx:XePtaqvExU1Xdloeqg4CURotxe3uxJknlhUofI_AESuKy-0OmJ0qHQ>
    <xmx:XePtao6UyxATYlOZ1iHp233jtUq2VrzNgkjWV5InNYBxpFFGfVPw1w>
    <xmx:XePtalUipHOVbVj_zlu9hs6YS1Hy1TlwGTw2CwLgx2J2OY5f9-FuUw>
    <xmx:XePtaq8PApgplNXyH5FLkljSBwroE4Gxug473XspXOGKrgJy1yiwWw>
    <xmx:XePtajYR8Bb3h5RgTNvw6-QBtalLb1qINRM0MCnITyr-d6ZtrYhNgAat>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 09:25:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e6f4612 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 14:25:31 +0000 (UTC)
Date: Fri, 6 Nov 2026 15:25:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,
	"Mark C. Chu-Carroll" <markchucarroll@fastmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 11/12] builtin/rerere: use `OPT_SUBCOMMAND()`
Message-ID: <au3jWCIwBKLV8DXT@pks.im>
References: <20261029-pks-rerere-subcommands-v2-0-07d5ba18e882@pks.im>
 <20261029-pks-rerere-subcommands-v2-11-07d5ba18e882@pks.im>
 <CAOLa=ZQrOyA2k+5EDmh+VJD=gC=68m3D17uKvNUTmaxH2FuNZg@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZQrOyA2k+5EDmh+VJD=gC=68m3D17uKvNUTmaxH2FuNZg@mail.gmail.com>

On Fri, Nov 06, 2026 at 03:44:38AM -0800, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/builtin/rerere.c b/builtin/rerere.c
> > index 3162b074ec6..97c791e420b 100644
> > --- a/builtin/rerere.c
> > +++ b/builtin/rerere.c
> > @@ -211,41 +237,43 @@ int cmd_rerere(int argc,
> >  	       const char *prefix,
> >  	       struct repository *repo)
> >  {
> > -	int autoupdate = -1, flags = 0;
> > -
> > +	parse_opt_subcommand_fn *fn = NULL;
> >  	struct option options[] = {
> > -		OPT_SET_INT(0, "rerere-autoupdate", &autoupdate,
> > -			N_("register clean resolutions in index"), 1),
> > +		OPT_SUBCOMMAND("clear", &fn, cmd_rerere_clear),
> > +		OPT_SUBCOMMAND("diff", &fn, cmd_rerere_diff),
> > +		OPT_SUBCOMMAND("forget", &fn, cmd_rerere_forget),
> > +		OPT_SUBCOMMAND("gc", &fn, cmd_rerere_gc),
> > +		OPT_SUBCOMMAND("remaining", &fn, cmd_rerere_remaining),
> > +		OPT_SUBCOMMAND("status", &fn, cmd_rerere_status),
> >  		OPT_END(),
> >  	};
> >
> >  	argc = parse_options(argc, argv, prefix, options, rerere_usage,
> > -			     PARSE_OPT_KEEP_UNKNOWN_OPT);
> > -
> > +			     PARSE_OPT_KEEP_UNKNOWN_OPT | PARSE_OPT_SUBCOMMAND_OPTIONAL);
> 
> So this matches what I thought.
> 
> >  	repo_config(repo, git_xmerge_config, NULL);
> >
> > -	if (autoupdate == 1)
> > -		flags = RERERE_AUTOUPDATE;
> > -	if (autoupdate == 0)
> > -		flags = RERERE_NOAUTOUPDATE;
> > +	if (!fn) {
> 
> Okay if there's no function we call the default case. I wonder if we
> could've done the inverse to reduce code block. if (fn) reutrn fn(...).
> Doesn't matter much anyway.

I think that the result is actually harder to read in that case, even
though that might just be my personal opinion. But having a return in
the middle of the function is awkward, and I like that the variables
that are specific to the default subcommand are nicely scoped to the
block so that they obviously cannot be used by any other subcommand.

So I prefer to keep this as-is.

> > +		struct strvec args = STRVEC_INIT;
> > +		const char **args_copy;
> > +		int ret;
> >
> > -	if (argc < 1)
> > -		return rerere(repo, flags);
> > -
> > -	if (!strcmp(argv[0], "forget"))
> > -		return cmd_rerere_forget(argc, argv, prefix, repo);
> > -	else if (!strcmp(argv[0], "clear"))
> > -		return cmd_rerere_clear(argc, argv, prefix, repo);
> > -	else if (!strcmp(argv[0], "gc"))
> > -		return cmd_rerere_gc(argc, argv, prefix, repo);
> > -	else if (!strcmp(argv[0], "status"))
> > -		return cmd_rerere_status(argc, argv, prefix, repo);
> > -	else if (!strcmp(argv[0], "remaining"))
> > -		return cmd_rerere_remaining(argc, argv, prefix, repo);
> > -	else if (!strcmp(argv[0], "diff"))
> > -		return cmd_rerere_diff(argc, argv, prefix, repo);
> > -	else
> > -		usage_with_options(rerere_usage, options);
> > +		strvec_push(&args, "perform");
> 
> Worthwhile adding a comment that this is a dummy placeholder subcommand?

Hmm. I could add something like this:

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 97c791e420b..f88bc43e363 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -257,6 +257,7 @@ int cmd_rerere(int argc,
 		const char **args_copy;
 		int ret;
 
+		/* This is a dummy subcommand name. */
 		strvec_push(&args, "perform");
 		strvec_pushv(&args, argv);

But does that really add much value? I myself don't think so, but if you
feel that it does I'm happy to add it in.

Thanks!

Patrick
