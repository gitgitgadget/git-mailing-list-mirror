Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F9D23E25B
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 04:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774326362; cv=none; b=Cy2PPF7Br1FSmJvf+WpNbZYV8+v3Nt9pU9PR4HtOFG6lsAODGRH5fSJ1m2BqWalNbvu6tMHcHFu1o88/a9Cg3W61XQx60cT7uAUxWr0LK+HbenQrmb0LeKwWYPfzi9Mojy4Fenv0pNmx507QkyM05AbOYaOHyYCIBGSDy1K8pmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774326362; c=relaxed/simple;
	bh=vM47t/wdWJ+E9jYqoBaNfQ5hO7RmNF33VW+Cw9I3GLc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YViaUsB6XIEgfvisUrnN3vzyQ0A+/lADk3huwSTcEPsiA/qmjlXATTsJUm399VTsKWiFIxSaosPEZSlZrJMClTXzhO1ZiXNZmy9mUyHngZ1BPOaMm3k86TxMYMz+vbctZo5eKjgzsTNn2yDOB0ojHlWJQ/Gm/yOH34OdHTF+w7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ir20DWE0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=1vOctP3F; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ir20DWE0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1vOctP3F"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 732367A01BF;
	Tue, 24 Mar 2026 00:25:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 00:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1774326359; x=1774412759; bh=wdAXtsCRGT
	hjlr31MuYQluck4hZZ/7RIAOjkCzZKPDI=; b=Ir20DWE0g/h5XV5jaS8+PztGTx
	t326G2bHnn/wK1zxUv+UxLbJAi5ZRSjnfnnbv+LIWThhZyA5gfDbHbsyDsKVZ4Tf
	aRILt9HNa2DuRRPheFNd0Xp0VPNLBY9Q5ejEAov7OekduPxdMhNWlHqvUMrA3Ncl
	NS3e24TA3ACHlGRv92xTJI7URTjJwln6Mv0UlUtgVe4qBH8JwRUxKoKf4RIFmRYk
	UkWdl4IEK1Z1ZB9r2zqM/VeXRAIpmapuSun8FWk5xj71K+nj8f4fjDWPtlEvS2uq
	F4XfiA13+MXidrXTZdJbQdLWJ2m8X/8GEAJ3MkWanCJ2Kk5vTG8zC52aP5uA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774326359; x=1774412759; bh=wdAXtsCRGThjlr31MuYQluck4hZZ/7RIAOj
	kCzZKPDI=; b=1vOctP3FZBvF7goE7892AM73NwMvcO6kBP4/jzrc6L7K4u3g8vL
	m/w0SKih29rQyNj+6yvu+sdvjkIjVCm9YsvrSbNdXnjHbLhmdri+SYxKcSRSYWT8
	pQnU/giXAZGbwJse5++FxyPRcEtngGtmaGe86Qxl0d3fLWNM2BsKegTtrt1S46lD
	pEcW1cAtQ2yEWdsue4VktZnOSGroxuegPdurc4qEcU1OJeVg2N5Z9nzBxo1Rt1/m
	gnpByWCOY/mYH022nTMMi15+F6Dqv86FkvGrKJXudDSpt61M7iwMMfS9DNWF8/rA
	b3bQ6E3W+bLyCszlKmDn/ghLdGUG/pDKPOg==
X-ME-Sender: <xms:VxLCaQ2h11guXV8eK8MS-3fsMs_EJWOzaE-_AA7J9RqGizotrka3xA>
    <xme:VxLCaeyB7kOXAHYc-AaXCJpnnKOL823hfZ0VEew76sf_57wS_I-K7eVUMM3tP9_jI
    qN1vF5bcBWRyS1OzlqW5oDllOgeIjMRYvzy-F43OG_oqk0vqiGELw>
X-ME-Received: <xmr:VxLCaSu0mutDjIkkLHSOrl4_1N5vxAWr_gvCV2J9Zsh9muDiMDrtdALq623XVFMZVgcyzlkcBFnyePzf9QlXi7rc9j9B74jinQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeettdduhedthfetudettdffffegffektdeufeehudevledtveekteekuddt
    tdehnecuffhomhgrihhnpehhthhtphdqfhgvthgthhdqshhmrghrthdrshhhnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhes
    phhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpd
    hrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghi
    lhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhholhhishhsgedvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhholhhi
    shhssehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:VxLCaQzITpSLbQV8UT4aov3myrTBx9yo9nyrxj9oHjm0DHxtNkUnww>
    <xmx:VxLCaVDEyyaxUHxxjWLFJeAhL-EKUgmxM9HZQ-0K9QCxjHkYuQNRIw>
    <xmx:VxLCaeeUEoC2LK0I2rVpnRxJPZLFlTzjlCiPECCTz10kqGUYf4G3uA>
    <xmx:VxLCaflmrd4JtRJHb6YRM70Xjhf48IVFUE5S1SWPr910mZrgUoxCPA>
    <xmx:VxLCabkW6OSImKB3qwZV5CH4AH5e6rUaUw4PH2Tz6IYfntCTpl3oAYu1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 00:25:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org,  joliss42@gmail.com,  joliss@gmail.com,  peff@peff.net
Subject: Re: [PATCH v4 1/2] remote-curl: fall back to default hash outside repo
In-Reply-To: <20260324015734.18470-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Tue, 24 Mar 2026 07:27:33 +0530")
References: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
	<20260324015734.18470-1-jayatheerthkulkarni2005@gmail.com>
Date: Mon, 23 Mar 2026 21:25:57 -0700
Message-ID: <xmqqfr5p3lbe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> Instead of pushing a NULL-guard workaround down into parse_refspec(),
> fix this by mirroring the ls-remote workaround directly in
> remote-curl.c. If we are operating outside a repository, initialize
> the_hash_algo to GIT_HASH_DEFAULT. This keeps the HTTP transport
> consistent with non-HTTP transports that execute in-process, preventing
> crashes without altering the generic refspec parsing logic.

Thanks.

>
> Reported-by: Jo Liss <joliss@gmail.com>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
> Thanks Peff and Junio this has been informative.
> I understood a lot of things here.
>
>  remote-curl.c               | 5 +++++
>  t/t5551-http-fetch-smart.sh | 7 +++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/remote-curl.c b/remote-curl.c
> index 92e40bb682..60774af929 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -1552,6 +1552,11 @@ int cmd_main(int argc, const char **argv)
>  		goto cleanup;
>  	}
>  
> +	/* yuck, see 9e89dcb66a (builtin/ls-remote: fall back to SHA1 outside
> +	 * of a repo, 2024-08-02) */
> +	if (nongit)
> +		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
> +
>  	options.verbosity = 1;
>  	options.progress = !!isatty(2);
>  	options.thin = 1;
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index 73cf531580..a26b6c2844 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -782,4 +782,11 @@ test_expect_success 'tag following always works over v0 http' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'ls-remote outside repo does not segfault with fetch refspec' '
> +	nongit git \
> +		-c remote.origin.url="$HTTPD_URL/smart/repo.git" \
> +		-c remote.origin.fetch=anything \
> +		ls-remote origin
> +'
> +
>  test_done
