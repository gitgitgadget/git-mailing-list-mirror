Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FE4369996
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 08:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774341490; cv=none; b=RL7n9iOBRZO6lA2YDp/kGubYb+qv/8stuWfzTP/mqeOiaXzpwiwu047f0KBsWXuLtqghYSqFgnevZTyBUoHCBQ2OvC+f/ap/Wps4NeVojcX3ybpxFy1jZ6xG90uaPPah9NlaCOGWZHmPNVjmn8CXiIc/rx/3jp3EtKsOaEmQ/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774341490; c=relaxed/simple;
	bh=0q7fsSvhTM+AChKq3DXWvBqFSQguEr+OiFM0Av5TxNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTQN8j/C38zSyx1crLEWNSiFg3TuXk9MbLGpBLyIEsG9sDnP5aBeSe09ehirCpbY+2kDcbATUqf1xNAgNQoxTp0TF5S7kGTVoJFonUKCh/Fcr84KhMkKuKva/8cT0xRJFkMeDPQBjF32Ktn/VH65NoBhtCOzVG2OZouh4x1O3to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mGMXx4G0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=khmJDujp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mGMXx4G0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="khmJDujp"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA1FE140018E;
	Tue, 24 Mar 2026 04:38:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 04:38:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774341483; x=1774427883; bh=A1nEvYbh80
	aq1topOpop18KWcKEhku38oDfPW/EcB30=; b=mGMXx4G01Bl/GFrvmfWh0LFXVi
	a5IGqtfnK6fZtS2tmaKFbnZ1VxjuEPjxIVXUq5+vWEq16xcws9iidz7esWS13Lwj
	GsZMhd55/ZqK8oir08+kx8zNGmIeWayyY9KbJVafj3vuKDJmQtwswnVfJhlx5Ehf
	k8P4Xjf8dBgB7uNg1JLZLQIPLguaXus6811t8PnpBsjnpdn+IKeoz5+7Mdci0giJ
	tZrAICqX5qBDwFd4Z1pQ9vRNsRHRP7r73CrNfwq+YyRT7vYtRGg2DuRAIdUwSdTg
	bRaW2DHtWpHna5PgY65CqA3WSfHmev8aT5MIiGnVdAKMI8l8emjugrhDXgCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774341483; x=1774427883; bh=A1nEvYbh80aq1topOpop18KWcKEhku38oDf
	PW/EcB30=; b=khmJDujpB9kZf8vPGq4wKq6LZJ8buQZESHzlvvaVPuNhZ+y7gr4
	tWagtLQs/8hLAAEEVkOx97PaPi59xM3stX78+jvCfDTRnE1fFYF0h2zcV2MNpsHt
	a7KNexloFkEr60Rmo09HIDu3RTp/AKKuCLzp+/TZE3EcZU4Y7KQVlAx+ULO3p87N
	yZYPp/o4zkDv3WJ9kF8QqZL0JiCizc6TS3rftDSY90MGymxWXs9WyyxVgLiLbHJ7
	SUuG1nR5dTdDFqQ8Idwgh0YQ4seQuFCzqHeJq/iGArkPw7Plmrq4nXgQ1LMs2a9e
	H2TKfQeI3raU0FueouP5jKJBEd1QYMVILQw==
X-ME-Sender: <xms:a03CaS_GqBkOdP1qtipi7OkkGs_Rgw6jIboZQnXCBjjDR_Jp4cCmcA>
    <xme:a03CaZmCax8kVtZd-sQhOGa-5eOFWuBk-IY-llh2Tj7OgwNbrvxZcJdGJ1CRcZmbO
    bOsHjdZIpE0OH9nak72bzrLgKpIgOLBqg8oFlzwJRvGH2PsU9OTQA>
X-ME-Received: <xmr:a03CaQWkOq7lhgHQXjoSH4gBD4B01NLkRqh3eTWcI7eq7nDAmx_ByNjS4K9oXxQa4PhNbWcqGfbbW0r4p1qhq6JAeNgxpltuJJ12mJ-QuiOKBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvmhhilhihshhh
    rghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruh
    hsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:a03CaWF-ke5cbUox3F1txlrXYPuAjNYrmWASyUq-Q8FAPs39Jnk3zQ>
    <xmx:a03CaUey_x8Edr6pD7NDgqZ2cvSaYDdSrCGHSQ3YPlTmbGmxoj88Bw>
    <xmx:a03CafILe0mkP33RoiOeFvyUtVoJm8bbs3ai7myquBfG3guIfb52Jw>
    <xmx:a03CaRHKcAuLvAG_BssXfFVGMsQIPDwaUlDkdqzwtnUGfiwHE0mNfQ>
    <xmx:a03CaXZL3xsgOZaPtAZeM16U_wDviSGX4lsiP-auwG1Q8ZadSD3lyU4N>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 04:38:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fbb7fd0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Mar 2026 08:38:02 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:37:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 09/10] hook: show config scope in git hook list
Message-ID: <acJNZ6Tu71YSL57o@pks.im>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-10-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320115211.177351-10-adrian.ratiu@collabora.com>

On Fri, Mar 20, 2026 at 01:52:10PM +0200, Adrian Ratiu wrote:
> diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
> index 966388660a..e7d399ae57 100644
> --- a/Documentation/git-hook.adoc
> +++ b/Documentation/git-hook.adoc
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
> -'git hook' list [-z] <hook-name>
> +'git hook' list [-z] [--show-scope] <hook-name>
>  
>  DESCRIPTION
>  -----------

Taking a random patch that relates to the git-hook(1) command. I was
wondering whether we want to introduce another change here that will
cause git-hook(1) to bail out when given an unknown hook name.

I know that we explicitly want to allow having custom hook events, but I
would argue that 99% of all invocations will use any of Git's own hook
events. And given that it's really easy to misspell the "prereceive"
hook (which really is "pre-receive") I think it would be nice if we told
the user that it's an unknown hook instead of silently doing nothing.

To cover the original use case we could then add something like
"--allow-unknown-hook-name" to make the caller explicitly accept non-Git
hook events.

> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index 7eee84fc39..22cca15fda 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -408,6 +408,25 @@ test_expect_success 'configured hooks run before hookdir hook' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'git hook list --show-scope shows config scope' '
> +	test_config_global hook.global-hook.command "echo global" &&
> +	test_config_global hook.global-hook.event test-hook --add &&
> +	test_config hook.local-hook.command "echo local" &&
> +	test_config hook.local-hook.event test-hook --add &&
> +
> +	cat >expected <<-\EOF &&
> +	global	global-hook
> +	local	local-hook
> +	EOF
> +	git hook list --show-scope test-hook >actual &&
> +	test_cmp expected actual &&
> +
> +	# without --show-scope the scope must not appear
> +	git hook list test-hook >actual &&
> +	test_grep ! "^global	" actual &&
> +	test_grep ! "^local	" actual
> +'

Do we also want to add a hook discovered via ".git/hooks" to show how it
interacts with the new flag?

Patrick
