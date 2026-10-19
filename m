Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447886;
	b=vF2xW88k0FUWQAF+dsCPK+/Bl7Za2JPwIHRuNiJ6kGWeNtSB3CaT6v7LGRZFwlEMW64V
	 K5agDlB6EwBRNJPOGgPx3pP4fPKYqUJUj1P+dDKCv6v1oQ2kEfJHdixN64j5RANLAhXZo
	 3NCsv/gxfxAJFwhjN//1G9jdNUCenPvpmZqTnwbM7adxUcSuwBXT6Tq2Lws2MxInTeF7q
	 rvpvpkf/pb+87R5fZQUD3QPA1/OqlyoVhrEkN1omFH8lvIjaFHLOyHlBP2zCnSTgmsB6U
	 i9+SivW7dj48LblgXF6LJg/h//Virk3Utc2ERoso5ckW3m/8MRlSQsWJqvu/TiO2MbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447886;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=ZYNE4YiwPAN4DhGgoLQb6qMYtSH8E810eoS5zR05W34=;
	b=E+4JIoUpYGqpyJbgcvP4QJtxcr0e2LakZP7GNM+vIJdsH5nlFC2aIqkb/h0uhDhIo79R
	 9o1Tc6bv1piXQEz6GoBoavxSVmSRxdNt8drwaO/s4BSsQAhhe9ULMSsLZkDQGR7HHEcNq
	 TT2KRC79SS1wyHxFxmsW4OjU5z3uEBXG3cHy6bE8DkckYOlfBSnTQxS/ab+qZwEbaGti6
	 VZVWkpHPoLfcymSMeHwB2z6rQ3av0xL0U7iWE56Th/f3ZWAA53N/A2sCYom13VVd4Okze
	 z9jNkeAQvwe5kp4eQiZBuXI8LV6cCAnk8Qf8fcrw4R0f6u3WXL9RPQUXWntVOb94+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XmDkEq8j;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kygyhPcF;
	arc=none smtp.remote-ip=103.168.172.155
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC41606A31B
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 22:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CC41606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=XmDkEq8j;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=kygyhPcF
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 824AA14000B6
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 18:11:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 19 Oct 2026 18:11:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1792447885; x=1792534285; bh=ZYNE4YiwPA
	N4DhGgoLQb6qMYtSH8E810eoS5zR05W34=; b=XmDkEq8j65O+pbAP5Duu2lJyz+
	BKDoC40KHLp2eumAjiuWk5U7fCQ2JYKtFU6j4VKoeKopCoY+NTyT5PUo7454xIQB
	weZw2OvRlzGPqyuRGk7vrKHLpZfswsQaAMBsSd69oq9xhQLzhf5jf53E4z8A0jHF
	uRzYLqzwfJSI1vA0XNYSEX5pO453jTT7bCvlRVXJj2M8TePn5NBDurtf/u2qbqj6
	xEu95cSuzu3XbUWaSit8q4r9hliLiiRUf4I+rO9KCBg7h9ZaEt7U9XOjLpfh47RK
	kLY5byWyZWPNgrkQTUTxp2alkXSUKhJRtcI54RRA6f/CF7K2dHj0N92vC1KQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792447885; x=1792534285; bh=ZYNE4YiwPAN4DhGgoLQb6qMYtSH8E810eoS
	5zR05W34=; b=kygyhPcFcg+GZM8wiDGqmKNrtlVbV21qeKO5/427cdRx4nq4aJi
	KmaLVmCpnCJlSx/q655vPHESDfFW5xerjgcUfTkkxFaaJnIx9cwfHfJiHsC3l3CF
	qSWiWD/AbCPlHtEcAUOnrdzjA3XGKmojUmopPwMgGH8tTKMJuK+aRe1gqqElwDt8
	ipyMM1xm9AgIXYV7m4j1TQ9MtaBiZM2dHQ1WS04JR+CAFJ5MCkV+kuga5pugkAAA
	dcDtPqiEOMfP5R6xdIxObM4CxYzPfduOueuiCNoDUMfaoWwAZUogwy2PS6DK3B7x
	+9bzSZFkoN8aNbjX15WIx+yAhfDrKgrGs4Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792447885; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:QBoaWp5N14MH8dFbEWyAAzoCVNq6WQScqcjlvsUARQSpAWx
	Na2shk4SDsmJOXiYq5a0ekuGu+TvxhJ9hcG9wj/xAo2lsGz3xrYMzPhGc2kRFSey
	Aydi2PZOLQUGhJz7HmJfTLzJSqEMQuO9PukVPcz5lRCmvQX3/z579ruhRmm24Rts
	V2UzY+8H0NGqa6yFHOZ7TH+RMM/3rDkvEGFsnM42/4Nplyh4v6daY8tC8AwyFyf2
	fqTfzbaLu1hECrz+F+oAlnRZt8t8hHT30W2exzIykaikIqMUbCHCDF8iajoa92ER
	juj5rs1R/prSr+GY/fKwKjjpf5SCNi3/2+DrTLA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:QpLmHWfDdvJtoG+s+4WqwhtCXFJzUPaR2igeM9eHdAY=:y9jpZs9zVxVBan44W0KfEPKkj74qQqnQyjJ5zevciV0=;
X-ME-Sender: <xms:jZXWakCxi6hcxYh9YVrRFVbKBXSwIKS8TsE3pT3n3f0VrQU7yhAa4Q>
    <xme:jZXWati46I5Gg8rKNz4FGQ03nwYDIuDjoYHs793PqIwg2JbDB0_rNqw51O46Fzzp1
    HoTG2eMLCUd1Y4p1LS87XnUVoA1hSc8AqM15HTdSZTWV-VJzmCA>
X-ME-Received: <xmr:jZXWasnRMhQ5CIj3ZaSz-6Adc8Ih1iHq3QB1tOPfEESkAKuAGYGj4Ye1kirSH8F-l6cDp1YsBnNKSYSbHgFpM4IzTBDGA0OU4Qi9>
X-ME-Proxy-Cause: dmFkZTEGlMi1/PYrRZn9Mqjqmni+sg9/rztBg2KnrVWIpyOsDnXscNXu9G+Q13wIZtP274
    np9FAj6Nuu/SyCbtC7g+C1QX3pd1i8zVHWR3Xh3r5bGYv8meAY5pVXRKqPc4+N4uneUxjX
    lbFKj6J4ODCgn4m90KxRESsafjtPBOlcOIk6XXq5nhdjBcZPu2glctobG8XPROdIyqLZC4
    YlLyMCdLxanADMOT8yOlueB/TYQu+clUPwFho1r7E0if+5WPYBxcXb3g/2LwI2rk+NLZl+
    mMb09Q4miaUjDUAObzhwBeh6K6IHPHFEBQ5k9PqYcG4ByZdyTEQAgDX1QMBog/a84n/msq
    YHmPW7hxGd5jA1e6sQfWKAJZWqQBDQ9fHvLR/752xDD9G5T5gQ4Kaok8Mmm3Htls39kBSX
    IUOuwwX0wm3idZZWpXAWx9MU+5eagH7tkMCrUhsJOrWiVtx1CLdQkuDSFUJNl08Ny1eVV7
    0CxOgyFkYIKRHfYOvJw6bWwT9UaBlQds2sIlaZJFt/j532J9jBEbEZYBq/mWKJ6bNtI6ZQ
    SZYIgPoUmyPd2TMjufPD4TLnn5x3nQstS43YoNRRDPV29ti2VTxyBtaRPJEf9f4MpTwbcj
    tTCFr9Jpc8UvONyVRtrQ7Sn2+NOXlO7WjLNsgI6uxQiLzMm5Z6wLHTZQsH6Q
X-ME-Proxy: <xmx:jZXWapr2ic5Y9k7ftZRXdasuuy9IYOfxCs2-NJBpdgWsWEHcKNp5ag>
    <xmx:jZXWalGRhXM4OO0XEG6oQdYe-aY5zd2OYW98AaACRNh5MKSC3RXa5Q>
    <xmx:jZXWalzzr7P33LIJnTEqyqPMzytMLQqAWppEeVPf9S4QUQPVivQjdQ>
    <xmx:jZXWaqpZSj9_DqzVKYnXAszNx-8ryGwbKuBBFgk__siCyMq730TAmQ>
    <xmx:jZXWakGtebpbTG6Oga9dDNImpJalvXaIhwAtbui1dJX8OhN9uDN6ynz2>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Oct 2026 18:11:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aniket Gupta <aniketgupta3001@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [GSoC PATCH] fsck: use Q_() for the verbose connectivity message
In-Reply-To: <20261019153725.333-1-aniketgupta3001@gmail.com> (Aniket Gupta's
	message of "Mon, 19 Oct 2026 15:37:25 +0000")
References: <20261019153725.333-1-aniketgupta3001@gmail.com>
Date: Mon, 19 Oct 2026 15:11:23 -0700
Message-ID: <xmqqld7t1gtw.fsf@gitster.g>
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

Aniket Gupta <aniketgupta3001@gmail.com> writes:

> The verbose "Checking connectivity" message has the word "objects"
> hardcoded as a plural inside a plain _(), so translators can't give the
> right form for the number. Use Q_() like the other count messages so
> gettext can pick it. English output stays the same.
>
> Signed-off-by: Aniket Gupta <aniketgupta3001@gmail.com>
> ---
> The number printed here comes from the hash table size in
> get_max_object_index() and not a real object count, so it never
> says 1. Left that alone, can look at it separately if people think
> it's worth it.

The size of the hashtable we use ought to be comfortably larger than
the actual number of objects we are looking at for the hashtable to
perform well, so the number we are showing indeed is not the actual
number of objects.  Nevertheless, using Q_() is the right thing to
do here, especially to support languages with more complex plural
forms.

We _could_ add a NEEDSWORK comment near there to say that future
developers may want to think about the number being inaccurate and
do something about it (or not), but I think your decision not to
address the inaccuracies in this patch even though you noticed it is
the right one.

Will queue.  Thanks.

>  builtin/fsck.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 9af4cc085..fedf8f853 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -379,7 +379,10 @@ static void check_connectivity(struct repository *repo)
>  	/* Look up all the requirements, warn about missing objects.. */
>  	max = get_max_object_index(repo);
>  	if (verbose)
> -		fprintf_ln(stderr, _("Checking connectivity (%d objects)"), max);
> +		fprintf_ln(stderr, Q_("Checking connectivity (%d object)",
> +				      "Checking connectivity (%d objects)",
> +				      max),
> +			   max);
>  
>  	for (i = 0; i < max; i++) {
>  		struct object *obj = get_indexed_object(repo, i);
