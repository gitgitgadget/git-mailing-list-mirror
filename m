Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795717607;
	b=k2xmJh1qxPHwSwiLaWueVYOjTFzGnrss6vxRwh20GMwG9o4DXT22VOhOi1QyoQgZCRa5
	 vrqeondXIcoYJUcHHB3eZ/JlQzN0tQmZA+jGQbUkRjUtInYpSUGYr8H2STH0S6XsQTFi3
	 ReJab1s6cNNncj9iMSieYzGjnKbIW3nDLi2JszNz/sCbPngszxN0dXS/4KfQzDSPHjXqq
	 8wCQkn7KN4dfzClJ/mNY033O/Xqsyaw1qKL1spRDiu9jAO+idYs51y5/HsNhQI977sNu0
	 PQW7s9gG2zZLWSr53xlObaX0PzY9ByzZG+cnb/BZ3GkMeXDIea6QSIarrL9k/zOkgcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795717607;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=iBds96tdQcRrE9RJILVk6D6xGMcmX9ZNPsCqq/NCuLI=;
	b=ObecwiAW2hIc+a+SDUuNW6sJBeRJGoX6zolDd4g/QUtDefFa2NHbrGRmbD8mLVgaBHZF
	 vwfepwXkogVpM8y851mqlTaiqRn5ukc606t9rfrOFLYjaI71+hi5yltBWHy/3mBFppwGP
	 Y40lNTbuxaQJ14wzEBWt7Du9BI/rEaQT63V2eSBkhprvsHlDjVJGfd4ReADScygGePm4C
	 NUpx+cmlKFHztJA7LYmZkmhjgjmeLXtK1eoWxPIo0t6R9HfPokx8m/+q4EThGtXnclYL7
	 hSF6z4SzVb5ceJ6pM70aWeB8qfH4Z1qptd/WK3SXpIT+huFgkW+hTdFuPR15y0VURvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CkPCdwoq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OwarJhLq;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A6606A31C
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 18:26:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A60A6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=CkPCdwoq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=OwarJhLq
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0007A7A04EB
	for <git@vger.kernel.org>; Thu, 26 Nov 2026 13:26:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 26 Nov 2026 13:26:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795717605; x=1795804005; bh=iBds96tdQc
	RrE9RJILVk6D6xGMcmX9ZNPsCqq/NCuLI=; b=CkPCdwoqTXB/5T3jU5MwkYRA+M
	lKlk+td5NdDpDzA9o9i6NFxo466YXpA3bFBPoZumI9WkmURdtv4wAKaS1LCChjwG
	qFaa78PgYoxETvc312NWdeCuJ8CoxMdC3OD+tIuUxoDq6du9wtGTmy9w9O0cQ1ZV
	7I2yjwSKu7UCm7nZPbA1rX9I5gVxDgTXgDN50PZW17Gs4saJUp9JX4nsDf9yHzAM
	6nz/DosbWVGqVd5JEhsboUdVcpbrBrqBH0OdoueGP3lgancVhlo7JT5AJIh2AnHJ
	6S8PybhZ24mI3PLS8o2POtw/06Y9vQtR4ICmrOZkAjkT5ty78+TQ1MRKvLEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795717605; x=1795804005; bh=iBds96tdQcRrE9RJILVk6D6xGMcmX9ZNPsC
	qq/NCuLI=; b=OwarJhLqlphBhQixVHslFGi+EMnHjYy21vvhijT77kqSkeL/0fS
	PK9grby4UPIwimQKQkenYS2g+FvrT7UbPfWj+6tK6aeqzhWLzOdOjvC2mZu2fi8e
	Z9Qscrgkt4wGYzMDuactwabBA9Z+A0BZA/oqM+GEZr+seKhgfeJZKP0OFXKsjMnb
	xv4eg31IbD571Y6O1gXtYqNRsOAa/QlONgaKAyIhU6Am6/jUsZfr1Z+7/BrWjzjH
	U+1qFUFmb/J4ScR+pVVEw83BNW1+PiseqHCiibIdKTBd+Cbruc+DcVlDZxWFh/3O
	qWgo/ivWTCZ0CgIAIp94reUf6MaotTt7Beg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795717605; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Mo8o+Wx1fjB6IezaiG5tOATGvwbpytHQJEG9y0LESPZsEJB
	MtLF33BaDG1iCPHvLudfkAeZA3kQC8mnCiZXi5P0UrodsqDqZvJYVzf57ttaFYaj
	nIVEkue9intWQ+p3gZl7F1BKnHX7PeWQop1mGT5pQRqDjYctiYLwQ3pRopzSSO3+
	yClC/aDmtPMtm0YToTgr3cd2WRCqqqHm3x7ohX+bP8wSi5ETcapY96B2635SoYK/
	3zJoG8OAKIEk5Vw4MS1dkzneSQ+9TaQiLUF+JI82BoXDhv05UtglC5EsYfkX9Coo
	cDxA90fBrqzuVy58G2nuDkqbE6j2c2hQKSOm8Cw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:dojm65/m/58XsBthFL0c5SRtVfxtAm20Ka6rLOzACHs=:DRlcvu8iRr3DiOxf+fApXr+UqrCyGs9SjDY7JClCk6Q=;
X-ME-Sender: <xms:5XkIa84VQnLManjh1d_QIgCIsJPQN36CZkQv_Rc0y4V02D6n2n2kmA>
    <xme:5XkIawJhcMKZSgJAtUl6E5wjlxsMTOkmVxm-DXAy4WYfnBNVdKIEu1BspLOquRf-U
    0K54kQi10PPDotzWMfdjlwVKvcKFg2fvx8boZ39nKPylAsXbOw0t1Q>
X-ME-Received: <xmr:5XkIa9v1HNYseWCYCMqXy3C1szop9TF-ozmM4KjwFb_-pL1JPhKxeVnmeykNxdvnuUmx9l6IwP5F0FeKXewoMvTGQOsqdi_TRFbSI04>
X-ME-Proxy-Cause: dmFkZTFZdleMLZ/bqE17PMdTOKAnVM0m4rD9H/+QElcRKWv9j/kBWKPcSBlYDHstRmEsPk
    NkXgiGK8bSUdftci/vY5q6frBrAB5rnXVbM8eAS8eMbOk/bc4Jf1j05bZNjvoPDc4YLChw
    reECXfaSOAnXZdeUV1XIQW6OTfGUj0Bc7cSAT2uG+OjUY1So/duvPrz4mEaa0lAjVpGD8x
    yHC1waplKUy77wJ0Q8UWx6T4TFr+40KjVHFr0wYrykW2RwkY7j5bfyFmAPltDHQkZXEsRR
    VooYZ5hIvttD3IsDtpvV2yQDR6aPoqTajXNtIuFs5yPoX+X3hxqeHXGji3LBZ6S3xv6FVG
    43MeB1jCA3zYyRtg8nScararnA1e7RAN7I3XVHKGspbs0w4Y93RCfadDicAvxJQudHf8rP
    GQalrj7HreLYUnXKoe69nMzcEdrvoqGVqvrUy8F0FzEAwLeCGtW+Wc5WqGaAUFn7OQuFvi
    Gk4OJ+SniiM3F+lACwdHcJqgxeZXK+G729lfAr2VbPLl1pavEu5n5Of+/4EeAJ+QUHTCHk
    CYur9U0Q5skoBYYv12X/19afZPkkmydZQHu3B1ODGHKm3AivWEBHSZHqFqGN7p4VaRXFM8
    TypWUgFg+10nJrys5dRIhyPEWBFKwQEPfPHStEwLs5W3cbPNNmZnsalxG84Q
X-ME-Proxy: <xmx:5XkIa3Leyk1X8uT-StPtBjPBddy8H976CzmZfb0dr1O5UTbuMYZYOg>
    <xmx:5XkIa-_2B5iZVbOMPhljO43rO2xB1mAEPexANJGfOuuao8yOPO0wow>
    <xmx:5XkIa4w94BtV7NQ7hMRhlvduO5yGbOrCAllw7fFn_h4VOXd8p-plIw>
    <xmx:5XkIaz5YsO7YZfpL6wg1TdLEVEyskzKccl8mrMiKgL83sbYXAu0b-A>
    <xmx:5XkIa8_Yvm7CE3pSAV5dHMTaQSsoehdu_qZFJZFGA2tuggPFg_6e48Sd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 13:26:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ben Knoble <ben.knoble@gmail.com>,  Harald Nordgren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Harald Nordgren
 <haraldnordgren@gmail.com>,  nahidhasan141400@gmail.com
Subject: Re: [PATCH] config: make the suggested "set" command safe to paste
In-Reply-To: <607d6273-14ba-4005-b038-3778ad2812fe@gmail.com> (Phillip Wood's
	message of "Thu, 26 Nov 2026 14:56:14 +0000")
References: <pull.2457.git.git.1795632875345.gitgitgadget@gmail.com>
	<02A50A47-A048-417E-9D1E-0C12D8FB1476@gmail.com>
	<607d6273-14ba-4005-b038-3778ad2812fe@gmail.com>
Date: Thu, 26 Nov 2026 10:26:43 -0800
Message-ID: <xmqqpkvrmot8.fsf@gitster.g>
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

Phillip Wood <phillip.wood123@gmail.com> writes:

> sq_quote_buf_pretty() is intended for that use case, so we already have 
> a central location for that logic.

FWIW, as the inventor of the sq_quote() family of helper functions, I
did NOT know that we were allowed to futz with what the
sq_quote_buf_pretty() class of helpers produce without having to worry
about machine readability and output stability.

That is even though we prominently document them like this:

  These should only be used for human-readable output, as sq_dequote()
  is not smart enough to dequote it.

Two things that come to mind are (1) we may need to find a way to make
it even more prominent, and (2) "smart enough" will become irrelevant
once we start aiming to cater to the user's shell, as predictability is
what sq_dequote() is about, and compatibility with different "faviourite
of the year" shells directly contradicts that goal.

> The output could be prettier though, in particular in would be nice to
> avoid the redundant pairs of single quotes at the beginning and end of
> ''\''hello there'\''' so that it produced \''hello there'\'
> instead. "'hello there'" would be even prettier but would take more
> work.

Yes, but I am not sure if going _specific_ to a single chosen shell,
perhaps via user.shellsyntax = (sh|fish|csh|psh|ksh|...), is a good
direction in general.  There are folks who script in one and interact in
another shell.

And no, going _generic_ to be usable by _any_ shells we care about is a
direction I do not think we want to go.  If backslash becomes active
even inside a pair of single quotes in some but not all shells, then we
must avoid inter-shell ambiguity by not using backslash while inside a
single-quoted environment, by first closing the currently active single
quote, giving a double-backslash (assuming that it is universally
accepted as a single backslash character by everybody), and then going
back to another single-quoted environment, e.g., "'abc'\\'xyz'", which
is the familiar ugliness of our sq_quote() output.  That kind of ugly
output will be needed to be usable by everybody, but then even though it
may be cut-and-paste-able, will it still be understandable?

My pessimistic but practical side is tempted to say that it is a lost
cause to aim for cut-and-paste-ready output.  Rather, we may be better
off if we give output that shows clear boundaries between each
"parameter" to "commands", and have the user express that in their
chosen shell.


[Footnote]

 * 6fb737be5e ([PATCH] Make sq_expand() available as sq_quote().,
   2005-07-07) introduced the sq- (stands for single-quote) quote
   mechanism as an externally available API function.  1fbdab21bb
   (trace: avoid unnecessary quoting, 2018-01-15) added _pretty() as a
   "human readable" variant, the first target being the output from
   tracing.

   The principles laid out there for "pretty" are worth noting:

	Trace output doesn't necessarily need to be shell-compatible,
	but:
    
        - the shell language is a good ballpark for what humans
          consider readable (well, humans versed in command line
          tools)

        - the run_command bits can be cut-and-pasted to a shell,
          and we'll keep that property

        - it covers any cases which would make the output
          visually ambiguous (e.g., embedded whitespace or quotes)

   My reference to "clear boundaries" is about the third point.
