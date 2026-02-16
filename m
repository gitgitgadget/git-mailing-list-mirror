Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A7D381C4
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771226632; cv=none; b=uRFa+59nrVM6I8Lk2AoxZNAsyR41f4Vb09fSKhr2q6qDeWkqQzTLQNgdBvmEk3IzIg4IgADrPp6bsLlQyxtLo4Lerph8BSBmrnug9+J/NwWja2tQPsqRQ8EhnF4QQ1MpW1REqihcHYaX9QMXWhsQv891HrUn1sAI8PdRie9BWaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771226632; c=relaxed/simple;
	bh=ag5SGIMmKdd7he5N+WLKOzwt7kg+xtJhVF91rm9K9UE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TM3tncr/rmXmwiJZfusGkTfr10MDolca5HPEWAnswGHO6L5EqHctCF2cbSo7/ieiL22ewHa9xtQmkbQdwpSCEVq7233+o89gZQa+L9gpoEFyGrr+7FkqrvNhHya54lE/B+YZ/17BYASYLQP0MnZ2Y1qNZyFpNailGlrNG3ruuAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JarA0p+Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FrGKYbU3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JarA0p+Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FrGKYbU3"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E92237A0103;
	Mon, 16 Feb 2026 02:23:50 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Mon, 16 Feb 2026 02:23:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771226630; x=1771313030; bh=+4HtwsB+Nf
	rp9lyM9/+UqahEV7dVg+pgke8F+5ap36U=; b=JarA0p+QlDMpEFGr7HPC7xAZ4R
	cP4Fq9v0nGcxWMkFSs30bjMQvv5QYccD7vJxGgeNf+oSJbfxDwglGP4i9TW1J02g
	A5bNsxPbfQYGQbQL2Kl7OVx7ExO7+sQ7du5Z5cjvbvnv8QeTV96/NcXdm8ymXzt8
	pjcMVCS/GY1Gihq/y1ct2f2YUnKtzya5WkHu2pL1oHl0kS3jzxki1Hl6/dP2fQoy
	KjyjlDUcBp1PqqgAz/vyY85fsg8xJmhgNpyhgvKNAfTxqNbrmd46LoANeYiQaFbY
	ufzWDCvzcoAP7liv0ebHeKog+HCJaQjG/yM43dkUnYlV45eygEalrxRppyXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771226630; x=1771313030; bh=+4HtwsB+Nfrp9lyM9/+UqahEV7dVg+pgke8
	F+5ap36U=; b=FrGKYbU3pdtAt+YWSmazgSsZHSGzD/KPw0+bwyMDElW6cftCdWM
	e+BTM+5kIHd9JRN4PhZZ1kEMVwA8+j8WxjthVwxhVw3vGpRa3G6LO6ZnsoUCWgFH
	o/Jp/CYH6PGgvRbMIUQ2/qIXnLjuPGolrcrFJz1MoU9rgRNHp/jrtxJzhPjXIEAE
	Im4bNtBQkD/QhTe4hynK9v/vlnApvUX0wsNrVZiQKuNydejU0L2Lq0Y5Vr2x4ZpN
	0EOG+F+G5jrUnn/mQEvx3CxYUegaSrLKs94hCLIhNtZDWtlj8DhHCPbonZisVKAU
	5nX6LfDgrh+OG75p8AMlzZw66cMrV+fx74Q==
X-ME-Sender: <xms:BsaSaRvsVnorBhLpooi5Qw66gSv8fLJFU1tyK1Cin7gegRvSlQzK3g>
    <xme:BsaSaReKNaUqUWPYCc862Vf7Yjz2B1Qy_nTSmlQRz6dd7gctkB6fadJxVLKI4cF4N
    UtLZyNXvFdLo_p8iaK1igl1zwlw8BI2-m4ALCIN5tSw3kZ8sx1b>
X-ME-Received: <xmr:BsaSaZyD-h67RuguF7XgKmR95gkP3igu4fDc5gDgQ3lAltUJoeOJGg5AbWObp6oxzSZDLIThBz2hu0Jqls0qHXC4o35ZOqW_gPGoPKDG0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeivdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtohhllhhinhdrfhhunhhkudesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:BsaSaXE_2Ld24ozbavEqu_IgF-TQsDAnX6_1CcbG_uM3LwuyWShOCQ>
    <xmx:BsaSady-f7evTPzecyHAWD52YoWng6pw864er8r0OYevQ16R0ZAxhA>
    <xmx:BsaSaYs5RPB29nJNTpQ3-NAMXXQKWY8j8jsAh69nc5-QfuKVDGJ4XQ>
    <xmx:BsaSaa11zrZMk4pn-rrozTrt7fhLi17IoHJogKcX9wOYtxlcQnLfNQ>
    <xmx:BsaSaVt9qooAOAtdQz1cRyUebLXvll1gFlRSBTFRs3E0UDoAaz4C1esl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 02:23:49 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6166cc85 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 07:23:47 +0000 (UTC)
Date: Mon, 16 Feb 2026 08:23:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Collin Funk <collin.funk1@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] ref-filter: avoid strrchr() in
 rstrip_ref_components()
Message-ID: <aZLGAMiDdZ_vplND@pks.im>
References: <20260215085755.GA86262@coredump.intra.peff.net>
 <20260215090744.GD695631@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215090744.GD695631@coredump.intra.peff.net>

On Sun, Feb 15, 2026 at 04:07:44AM -0500, Jeff King wrote:
> To strip path components from our refname string, we repeatedly call
> strrchr() to find the trailing slash, shortening the string each time by
> assigning NUL over it. This has two downsides:
> 
>   1. Calling strrchr() in a loop is quadratic, since each call has to
>      call strlen() under the hood to find the end of the string (even
>      though we know exactly where it is from the last loop iteration).

Ah, indeed, that's something I missed.

>   2. We need a temporary buffer, since we're munging the string with NUL
>      as we shorten it (which we must do, because strrchr() has no other
>      way of knowing what we consider the end of the string).

Right, upon reading the preceding patch I figured that we can improve
this function even further and avoid the call to `xstrdup()` in the case
where we have less components than we're being asked to strip.

> Using memrchr() would let us fix both of these, but it isn't portable.
> So instead, let's just open-code the string traversal from back to
> front as we loop.
> 
> I doubt that the quadratic nature is a serious concern. You can see it
> in practice with something like:
> 
>   git init
>   git commit --allow-empty -m foo
>   echo "$(git rev-parse HEAD) refs/heads$(perl -e 'print "/a" x 500_000')" >.git/packed-refs
>   time git for-each-ref --format='%(refname:rstrip=-1)'
> 
> That takes ~5.5s to run on my machine before this patch, and ~11ms
> after. But I don't think there's a reasonable way for somebody to infect
> you with such a garbage ref, as the wire protocol is limited to 64k
> pkt-lines. The difference is measurable for me for a 32k-component ref
> (about 19ms vs 7ms), so perhaps you could create some chaos by pushing a
> lot of them. But we also run into filesystem limits (if the loose
> backend is in use), and in practice it seems like there are probably
> simpler and more effective ways to waste CPU.

Agreed, not much of a concern, but good regardless to see it being
addressed.

> Likewise the extra allocation probably isn't really measurable. In fact,
> since our goal is to return an allocated string, we end up having to
> make the same allocation anyway (though it is sized to the result,
> rather than the input). My main goal was simplicity in avoiding the need
> to handle cleaning it up in the early return path.

Likewise.

> diff --git a/ref-filter.c b/ref-filter.c
> index 1008b2fd5a..ac32b0e6bb 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2213,17 +2213,15 @@ static const char *lstrip_ref_components(const char *refname, int len)
>  static const char *rstrip_ref_components(const char *refname, int len)
>  {
>  	int remaining = normalize_component_count(refname, len);
> -	char *start = xstrdup(refname);
> +	const char *end = refname + strlen(refname);
>  
> -	while (remaining-- > 0) {
> -		char *p = strrchr(start, '/');
> -		if (!p) {
> -			free(start);
> +	while (remaining > 0) {
> +		if (end == refname)
>  			return xstrdup("");
> -		} else
> -			p[0] = '\0';
> +		if (*--end == '/')
> +			remaining--;

We start scannign from the trailing NUL byte, so this would also cause
us to detect if the refname had "/" as a suffix. But I assume that's a
case we don't even need to care about, as refs cannot end with a slash
anyway.

Another edge case is if we were passed the empty string, but as we
already abort in case we see that `end == refname` we're good there,
too.

>  	}
> -	return start;
> +	return xmemdupz(refname, end - refname);
>  }

So overall this and all the preceding patches look good to me. Thanks!

Patrick
