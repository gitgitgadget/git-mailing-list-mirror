Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516687;
	b=1EjZ2PvvLHtTidH8pNIHy8KganRTwxeER0TxSVKQVUxLlA40yd3+MGyedhE+2ysSLDsa
	 4l4WudoxpBO66gApfqcQ8RvCx0q3UdlCWF/mEtd3Ztf51ZxYyy8JF/I0iqxBDRUgammbx
	 rWKYxVVQwoakUGT5xNEU3gVHpv729UJlDk3QGeIdbG8erxKOl8c8TPQSj7g66JEkvRm/A
	 Iq1lDMgMqkBWvnQUPNMWQtEPuoFinTHaYRqsNOG40ebon4IUi+JxpUZaeTNPAJA6HnHPp
	 +o1UkOKfGbE5T/GauoMbv7W/jtE63WSYYM/z5Ut/cbVyt3NYUIZ/giscIq8OfWqFqVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516687;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=439eEFuXJFesnjWZpUNl3mKd4MAD90VLXHXI3eT0dYE=;
	b=Bn2mpI7ukWejV0oMRjfewFxhY1ux0Hix2AO0Tpr21V4gK+m1QeQsF06Mk3cFno8sOw3u
	 R3h5GrZMQO3lE36qYTYQjXaZJvwiH0M3GQH1cMs4LvuYazT7naW2LF64bvBubZwEFw7WI
	 wrxGAx7yTYuAhmTPrrsMKB6E2x36PgkuPs2l2M2I8f54SQfuz7SXK7Mmye81Pe1gmGEFe
	 NWrmjvlyfq4VbCg3YSEIhrfrfbB3AXOkIQaUUbqSJmzfs8tVt/sVYpj5riZVy0evSYdiy
	 4ti6y8N+gCXg5Me/8Bs8ABIevTo6eY6Ch/tkYzf5PE3pus19gtXdQF+vNaiCs9BJaWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M1p43CUa;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ddj1o8MO;
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D217606A31C
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 20:51:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D217606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=M1p43CUa;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ddj1o8MO
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E0E9D7A030D
	for <git@vger.kernel.org>; Thu, 12 Nov 2026 15:51:23 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 12 Nov 2026 15:51:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1794516683; x=1794603083; bh=439eEFuXJF
	esnjWZpUNl3mKd4MAD90VLXHXI3eT0dYE=; b=M1p43CUahgpVpOYYVDhvOZIb2F
	1tWr24UeTRFZierwsu1VSZeLqomLyS4/ZNpjCO/akFZ18uSoRoje1N08AtqKZsCb
	YCNT2jvPu12yxb0Nk95eGJFgLA9/GcQ5jedP4oZxCak1Mvdl2r0Rby9xnSeld8To
	ZYOP1JM0Z4kkIcAFdaLNBEDjBaUmJwPJRfBQURpBtdqA8365ASdBWhs81ugoyEPw
	czrPNMKsHXfYa0Lw7+kpIS0ZZnsHukCGWZX6xAnQtw+8lgsow0+AKu6y/KWg2MGQ
	RXRGuj+UQc45e9r+AYsrO6PhPdtI1KJ9KwLwFv7pSv9CD0UlY0lqzOSjUm4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794516683; x=1794603083; bh=439eEFuXJFesnjWZpUNl3mKd4MAD90VLXHX
	I3eT0dYE=; b=ddj1o8MOb25CsQ/Gp9JXdwz7ODoeXFLZzPy2EQKpLPSMSSHedPw
	5ZLwlzaJ+8V/OoL0QDYOIEsOd3ZcaxgSfhWXq2+D5VrWGxn3OW+9sevG9h3XgYpp
	tDQXg9T0feQNGEDrkzq0VBustTdlDmwGWUVARJsOiBJ229swLPUJtuiNFTjVkVcG
	gZDMHZM5Ay7+K75urFHhulooWpE+gxT5Lbtfp+TYE8zd1Kk9NIeuVkYYEQbjhv51
	NtX1l4dixltemHXl/LCNL0M9vMpeiNmpZTFNNa2r0WI/RnL1m5jBUBqAXgZ9xqmR
	2KF/fvOrYAj9USi7JYPNhKjnzFMd0c8MXYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794516683; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:WPwVlkrQNYY7BIp+HT4nRCeaQOfTQfviitJ+y1f5Qw6Gm8u
	uVJZPs1Cc20SvLZ/Jn1UvTe2j0CAJz0cdcDPUKJ0r2RUhJdy8ZSJGN5+t0SOQUAL
	OeaN16maz2oRdSlM8yu1R+GyhFH32S8CiBUQkGHTXpUV66PPC+Id/W5+At+vEysH
	yBIR6Kf7aNmg/QhhphiFIcDX8/3aAp+8keaB6vjNPYFCA6dXFWgrBPIASsByW6Zb
	oGEGYetdI3R0wBuyKEdg5KMY5qOarT4/spjGss+hHFvJ0nSvoV6NzCc261o6+T3C
	9KVGdO9mWxA0jlZC+zt8Dd1OlZVvJCYnoQmkK9Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:wAA5X/XHQKxLlIR31vnqif6ajGthfUEYRw+Rc5BJWDo=:VUfqr2pSCpqT7Wwebk5yWWAtIrYYiqynDZSVehlVHtg=;
X-ME-Sender: <xms:yyb2agV5LmPKweFNrx_clt9J81IQxMHRnFQdebC1iMXJGUPVcrN9Yg>
    <xme:yyb2asD88ZN4qyQVUjmFrUC8SVxPXD20DoddjxR8YBO1WpXJ4yJoI2U1cic-1Yc2D
    pJllxiRzkob7k4Zp82lpy5zeXNeVfH4tjg9ux03k2Yx85qasRcj1Sf_>
X-ME-Received: <xmr:yyb2ahwmmxwnjxOFUyvs9U-K0Zq2GsmVPaRYpIhhItNUMSLA4b7etfESwjRGt3OR48L71MGTC3vVwQTGDCpJmHMmMAxdmUyf6lQJ>
X-ME-Proxy-Cause: dmFkZTFJC9jDkFHJyPEPGvWXhVsmDGonfufGWsHgu/rBv8HhVqrzzdKPZm0SKLnE6V2HvY
    vupzhekPE8G9FWYfg6qpd9n4XrK52T7HxQGqGU10Bclt07NjJEzZ8eY0sUY5Byk0tHDg2J
    lTLfsx+ohVPyI/Q0npgAk+dpwVJq5oQlFnMGKldEWO35xMfeI2J8EuzxNIlPFtZ1DqVzd4
    oPDQqh4CJw2z4nwahzM2oFrcX6T1ZeC7H+/AWLjbEeMSjn4aTbRl7KwYv35KcVeyAKABNp
    p7iD0ZTleP/pDchE+XveWojt+KgxUS6OSgoOvwqp79lm3VmuGug0NKnGpMtu3TrWTMWNBd
    owtN85e6+9Es66af3S4CuCihWPSbU1RVaNkoimsI//8pFRjmhz0sPxxuj4QJzt3tH5LBBv
    Ru1cO9+kj4V+1Ie8abHDsIPNGjT0N44eadp9nKcnP5FeUYWT7ukngFXc2ihrzdVwS7ZBV8
    q2LzsiZt9pWIkm+pNBtvuafzNptZSZHYfdXV7VbtxKeq+9I/9hFakaD5skRzNE2U8NQkqC
    ANjxdvF7FjC0hqFvIhu/uzAu5YwOrOXfacawsjwVlFabb2IhFLgtzhSVpuiarpT85Y3Uxm
    jCK1DuLyyXll2YvthIeQ9BCGr3fU54MHpj/D+k+3MazZTFfVfwIasjuyVi1A
X-ME-Proxy: <xmx:yyb2apDl5uQjpL2tD8FaLyuIHT_mRjgv6f6ROHzlTZHgAsPbLmcBfw>
    <xmx:yyb2auaZsNO4ctczKzzpBPzQwCAY1uHQvo2DtxpLZG2A4M1KTubBUw>
    <xmx:yyb2ahisDyugADNqefNi85bFey11a2OeKYMv48LP47phJ81fLMXhVw>
    <xmx:yyb2ag7gPE7I7fNKHvjaKTdwRcJDPHnCNJHF1xZAe8XEo10PFm3TvQ>
    <xmx:yyb2apomugmq4AN0BhWlKKpBUOxU2J1CybPjTS6jXqPs7N_jcWaGKh12>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Nov 2026 15:51:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Windl, Ulrich" <u.windl@ukr.de>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git context diff does not recognize shell function name
In-Reply-To: <340dc2eef42f4f6690c58765a07621e1@ukr.de> (Ulrich Windl's message
	of "Thu, 12 Nov 2026 13:39:58 +0000")
References: <340dc2eef42f4f6690c58765a07621e1@ukr.de>
Date: Thu, 12 Nov 2026 12:51:21 -0800
Message-ID: <xmqqmrrdhiye.fsf@gitster.g>
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

"Windl, Ulrich" <u.windl@ukr.de> writes:

> Hi!
>
> In git 2.51.0 I found a minor issue:

That is a release from more than a year ago, but I do not think we
had any change to userdiff (i.e., built-in patterns that define what
line is the function header for various languages) since then (we
added Swift and tweaked scheme).  So for practical purposes, I would
expect that whatever you saw in Git 2.51 for shell to be reproducible
in today's code.

Or are you reporting that Git 2.50 (or something older than 2.51)
behaved in a way you prefer, and 2.51 behaves differently?

> "git diff" did not show the corresponding shell function
> name. Admittedly I used a somewhat uncommon line-breaking:
>
> The context in question looks like this:
> ---
> ...
> run_query()
> {
>     local p_l_0="$1" LOG_BASE="$2" SUFFIX="$3" URL_BASE="$4" URL="$5" \
> _COUNT="${6:-$COUNT}" RESPONSE_CHECKER="$7"
>     local me="${FUNCNAME[0]}" m
> ...
> ---
>
> The context diff looked like this:
> ---
> ...
> @@ -193,6 +188,36 @@ get_params()
> ... 
> run_query()
>  {

I assume that your e-mail message is whitespace damaged and
run_query() is actually indented by one space, being a context line
together with the opening brace next line?  The header stating
get_params() is expected, as the "function name" do not lookahead to
find run_query() in the hunk it is going to show.

> @@ -201,10 +226,9 @@ _COUNT="${6:-$COUNT}" RESPONSE_CHECKER="$7"

It is not that the line that begins run_query()'s definition does
not look like a beginning of a function.  It is that this _COUNT=
line does look like a beginning of a new thing, and because it comes
after the start of run_query().

The name of the file would affect which set of regular expressions
are used to sift lines into function headers and other lines.  When
the file has no known suffix with language specific rules defined, I
think we just pick any line that begins with a non-whitespace
character, which explains why the line that begins with
_COUNT=... overrides the line that begins with run_query() which
would have been a candidate as another and later candidate.

>      local me="${FUNCNAME[0]}" m
> ...
> ---
> ("..." is deleted lines)
> So this may be a combination of unfortunate context sequencing and
> the first line of the new context being unusual.  The second chunk
> would still be the same context, namely "run_query()".

