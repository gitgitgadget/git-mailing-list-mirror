Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270C258A
	for <git@vger.kernel.org>; Fri, 24 Jan 2025 05:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737698203; cv=none; b=oCEV0QoWEMWNkIQYrGp5s2ycE7b96JDBBQcKKU0rWUsCI+mzFPjm69PCt2X3g+GNDnE5SAp3mtLhqpYwhVAk8UHU2n8T0B+25OEroGXU4EuisNneLFW/n2mhbKXihigUz6gWs29W1I/hjhlRo0UDzKr4HJyGgSuMu/Pef8K3K3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737698203; c=relaxed/simple;
	bh=Wb+yQh2b0TTf7Eo4dAsn1WJdGdFmXGCpoJvVyFTpjUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9yJJRJ2kiaotYWTpRUwIKMzNyMo0pdbxsWJh8QDsyBjrAhpJ1lOuvqHCyGFJ1/W9O33xvcmIFB46Z/EAqQslRA2Y8+M/odb4eWSUKrIoMGe1f8HMaHllm1tcN6MQLwSbPJOIQNIGrCDo+xtArMkEtPFA6ckEmwgyGrzsIflQFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r573LWkT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A+qRXmqx; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r573LWkT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A+qRXmqx"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 87A27254005F;
	Fri, 24 Jan 2025 00:56:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Fri, 24 Jan 2025 00:56:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737698199; x=1737784599; bh=gIcorwfjYY
	wWOKVHEYYMfjYqhAyNhxbdEHwvHAIVa7M=; b=r573LWkTCu2hr3u0yuDoSpZ2B3
	nDaGIJLHXb57kKxakT+7jK76O/eNRQ8be3DTRS+FdgNPeOe0TRrytmWobGuZQ7j0
	SGPaQUeqXgAZ9FxKI5Ef9aygZvh+M9aEaTo1mgksXKcazaAGv+SxhdQkGCF1FfrU
	XwaI8JQ1dcYxz/UWLs/mO0OHQDMVR6f/7+T8Je+dlb6W9KyXL1HAq7Q4t6Kmm0OU
	bkM9r7+okszD5dUrLf7fmDtAaIrhUIUByp/mZZ7t1z/xEcHkDiYDkAD7GF8QKnbv
	kD2H1AwBLzSdPADOCZoz7ObAD4B7gJ4bMHSvPc06sCiKQjWM2NbfXQgENykA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737698199; x=1737784599; bh=gIcorwfjYYwWOKVHEYYMfjYqhAyNhxbdEHw
	vHAIVa7M=; b=A+qRXmqx7cbbBAW1WeKBqWvCF/P/wa4NtPg/YQBrZoJSFv6IUTU
	gTIG9dcm2JhQW6kwqi7UMG94xwsOoFhKI/qCVRk7NMTr1d4tDe4aNPHop+b7LWqK
	G02PduAn5WfLrP1LIbWYfjvZ0/KI0xNAQZWUUXvc+kW4B/tO34fknhdoIuCrm5Qb
	L/qW9dcyX5yVj6X/P37VvggG7G9JJSHVcENNoRb/op4ziuD/bGiHh+X+rwx0vE3U
	TznNEC22zI8pOnjhTAryQDDwbPmQpqtDrh++z5RrC0fPRk39kXOsp+mJzEKuDrh5
	ecYJuTRKEfd4UmJDeRBqofP4ykz3c3U+HZQ==
X-ME-Sender: <xms:lyuTZ7gjdvTvJW0PsDyO5NmcDg7r_cET-CQGWJiB-RMHki95vEN2lg>
    <xme:lyuTZ4Ch-v_11DaX9PDAby7m4F62WV1JkcqAPwZlf-AHPXTucWCcUicPQVHOo_Cfm
    RC2H5K1Ja7JHJIohQ>
X-ME-Received: <xmr:lyuTZ7EbMASXY1y9ir9RiNBmyg0VzWnev21MSFOsjWsDp9hxc2eGVBwTMEk0wTsBT0mAYBVx9rNC6GWYUZntrib3jt5DWTnXHFx-yiCZHetlug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepsggvnhgtvgesfhgvrhguihhnrghnugihrdgtohhmpdhrtghpthhtohep
    lhhishhtsegvfihorhhmrdguvgdprhgtphhtthhopehmrghilhesvgifohhrmhdruggv
X-ME-Proxy: <xmx:lyuTZ4Q8bEtj28DFLggrSbimXfNnoLsaFOrLwbUkJzawIJjKLaTCfg>
    <xmx:lyuTZ4wgaNn6voFWgI5mtukIwSE88yopKeEOadnP3xbSJkjaQgnBHA>
    <xmx:lyuTZ-4_igiosb0pIWxip_u2Abt0b7kPRe1FY6REYLioKPURt-FZHg>
    <xmx:lyuTZ9ydUp7E_VACg8PiD9-cHo1DibhK6iWmaJPG5sG89YSkqbpDmg>
    <xmx:lyuTZyuMb4LGl9URD7UP_C2OdAQpYpaEGf1dZLCwriFseakh5HAfhIdF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Jan 2025 00:56:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2ac6c355 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 Jan 2025 05:56:36 +0000 (UTC)
Date: Fri, 24 Jan 2025 06:56:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: git@vger.kernel.org, Christian Hesse <mail@eworm.de>,
	Christian Hesse <list@eworm.de>
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare
 repositories
Message-ID: <Z5Mrk02wMdABtrVZ@pks.im>
References: <20250111202628.0e5894e4@leda.eworm.net>
 <20250112165125.130400-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250112165125.130400-1-bence@ferdinandy.com>

On Sun, Jan 12, 2025 at 05:51:22PM +0100, Bence Ferdinandy wrote:
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index fe2b26c74a..625d45be8b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1925,7 +1925,8 @@ static int do_fetch(struct transport *transport,
>  		}
>  	}
>  	if (set_head(remote_refs, transport->remote->follow_remote_head,
> -		transport->remote->no_warn_branch))
> +		transport->remote->no_warn_branch,
> +		transport->remote->mirror))
>  		;
>  		/*
>  		 * Way too many cases where this can go wrong

Nit: At this point it might be sensible to simply pass in the remote
itself, which would allow for an easier callsite and less risk of
getting the order of parameters wrong.

> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 519f7973e3..c75cfe968f 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -589,6 +589,16 @@ test_expect_success 'add --mirror setting HEAD' '
>  	)
>  '
>  
> +test_expect_success 'non-mirror fetch does not interfere with mirror' '
> +	mkdir headnotmain &&

Nit: this can be simplified into `git init --bare -b notmain
headnotmain` so that you don't have to create an empty directory first.
Also, do we want to `test_when_finished rm -rf headnotmain` to clean up
after ourselves?

> +	(
> +		cd headnotmain &&
> +		git init --bare -b notmain &&
> +		git remote add -f other ../two &&
> +		test "$(git symbolic-ref HEAD)" = "refs/heads/notmain"
> +	)
> +'
> +
>  test_expect_success 'add --mirror=fetch' '
>  	mkdir mirror-fetch &&
>  	git init -b main mirror-fetch/parent &&
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 2d9587059f..cfa63ae086 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -84,6 +84,19 @@ test_expect_success "fetch test remote HEAD" '
>  	branch=$(git rev-parse refs/remotes/origin/main) &&
>  	test "z$head" = "z$branch"'
>  
> +test_expect_success "fetch test remote HEAD in bare repository" '
> +	cd "$D" &&
> +	git init --bare barerepo &&
> +	cd barerepo &&

The `cd` needs to happen in a subshell. ALso, the same comment here
regarding whether we want to have `test_when_finished` to clean up
state.

> +	git remote add upstream ../two &&
> +	git fetch upstream &&
> +	git rev-parse --verify refs/remotes/upstream/HEAD &&
> +	git rev-parse --verify refs/remotes/upstream/main &&
> +	head=$(git rev-parse refs/remotes/upstream/HEAD) &&
> +	branch=$(git rev-parse refs/remotes/upstream/main) &&
> +	test "z$head" = "z$branch"'

The closing single-quote should be on its own line.

I see though that you simply follow existing code style, both for the
call to cd(1) and for the single-quote, so these are fine. This test
file could use a makeover, but that is obviously outside of the scope of
this patch series.

Patrick
