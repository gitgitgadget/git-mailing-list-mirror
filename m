Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0E831AA96
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 13:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771509428; cv=none; b=EEeoc699R2ECFsi8W12PStESNQ/BQYK2AzDpucP21jegd5K7fQ1hQojvlsrVcZ3OsP0hqNNIMP8dUU/hDvbWMx3LvirndZECUk/F0TTUSZf03z4KFMwXVytlFvfB/2+DjTOIMfd4fB6GppTHZ5UdITQK1/qTQ/AImgbmq0Uug7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771509428; c=relaxed/simple;
	bh=GxLkStmcr9A7XeQGr1KzdcNJK18wdIOcMxYZvyNWBrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZKWOu/btBCfdh9mevVPM/LL+jTnk9OzDW7K2xsKjiEv3qKuvdd/EK27zyNOYcLqXeeBPzKDfXHYk80wvMl0UzBKyy5pQUCQdEAe2D4/jWp2GNGwuO5DSYlz9BDq8njVf+clgPx5y8sAzuaraPQYywpnEZJdMz9+X7ZbLuQXUCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HVZGHOGo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HL+mG2jw; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HVZGHOGo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HL+mG2jw"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 92E8814001BE;
	Thu, 19 Feb 2026 08:57:05 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 19 Feb 2026 08:57:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771509425;
	 x=1771595825; bh=kH26J7d1rFdJc1tpfy9/IYt2kOlnR/xaySb43rz3VXs=; b=
	HVZGHOGo+3jvjcBgRAqIP+kMKX8Tm1yUxUB+Lpi5xkQKjdNVl7uHe9p+IlYz2SQP
	T2phGVTmh5OqFtFIieFwYrRhy8vvh/th/IWkSK8kew88dYXq/UxHA6P8YMkaTi7x
	kCW1WrmOg3Jzs5mgds9wii6MQn813Ew65dglf4s/g/nFQ0xnhwD2rlYQVTo06ltb
	CQEkVtbIAdzoFHuYLH5Tm8w3J/0DVsTu5BuMSosBPGLTASh8flEqsqwCYuQF+LG+
	CxyMMSHD5I6aCSEPL22KQWnwS8ieReEWV7KJKvYoRA5rTgtwpf+BJu7tpsQyHcpc
	vT2WibaYOH2QkVPMrPTOPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771509425; x=
	1771595825; bh=kH26J7d1rFdJc1tpfy9/IYt2kOlnR/xaySb43rz3VXs=; b=H
	L+mG2jwcKAUcnpOqECwSwp5GQ8F7DV7Lcwsw0LRWyJ6sgg0bwP5CBg7Z18084K3K
	UiyB4GgoxwX4UaHS5mpuM8PywekK/2HSoOwcwXBPym719GYjZ6G663PgNDgURn3G
	NxebTK9KKvERO0MLUmT/50XNiLuwwlhx1jmUwPGU1wB2e24ow/9ajwlUHueq2aDd
	zQ1oDr9/M6X0uEMe36+2kpsAUJ1DPnuTgQPPBY/ltBp8F9SRfT9jNx7bdVK2LMAb
	1L04lL4DtGrCZHGr/ewmzqeDeAgpgH0QL2vtt04j9qlvd79/O+P+gbnrJaOoIKE5
	xhsBpJbHKCCTCwVl0cuoA==
X-ME-Sender: <xms:sRaXafyJFyOViRKcLgE_SR974fRAT7g14qZerz1hvKG5RjZOz7HPMw>
    <xme:sRaXaQmYO7fQvBa6dk0HxwqFy0lUMYnk19RFt3pe8kZw9Hn8AZxuBwA4w76VrnIze
    GgQPYiLyMrMP_Ndi1kQ4D4poi2zvLj2c52ESSP5syljlE-ivLec>
X-ME-Received: <xmr:sRaXaQmhueuyMllCLW7Ia-NG2Lw22jvcN2Sp-9ze_aRapYlVwHoUAC_7LepOKPm8HIlRM1SstDLePxeoM9GQEOeeFLc35mD3WsBCLFMPDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehjedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghvrghnrdhmrg
    hrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgdoghhi
    thhhuhgssehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvth
X-ME-Proxy: <xmx:sRaXaazFM_ZMb9DEukGHHNc5ZfG3BUZkDxHejA-SpAGcZvYH39SWvw>
    <xmx:sRaXadooPMiACIzTxjeVhxxgRGB0kEh7WlzrifjJPYs9PuGQqHz6Tw>
    <xmx:sRaXaR5FFwIT8GNw7px8AIoRT71talf5gAwJ8z-dybWOeWpBKk9iyg>
    <xmx:sRaXacc97XI7hsPT51Pt5Phm79uNOTiTxl6CePbaCIr067ZxEOvzWQ>
    <xmx:sRaXacv1lvs8R4AfEZ7WADnNXMEOaS48s9Hk9IeJVq73_1UGHaNrz3KL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 08:57:03 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 94061c5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 13:57:02 +0000 (UTC)
Date: Thu, 19 Feb 2026 14:56:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH v5] build: regenerate config-list.h when Documentation
 changes
Message-ID: <aZcWq9SapNnRAXti@pks.im>
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>

On Wed, Feb 18, 2026 at 09:37:59AM -0500, D. Ben Knoble wrote:
> diff --git a/generate-configlist.sh b/generate-configlist.sh
> index 75c39ade20..39ac8845ab 100755
> --- a/generate-configlist.sh
> +++ b/generate-configlist.sh
> @@ -36,3 +37,11 @@ print_config_list () {
>  	echo
>  	print_config_list
>  } >"$OUTPUT"
> +
> +if test -n "$DEPFILE"

We could arguably drop conditional now that both the Makefile and Meson
pass that argument, but I don't mind it much.

> +then
> +	QUOTED_OUTPUT="$(printf '%s\n' "$OUTPUT" | sed 's,[&/\],\\&,g')"
> +	printf '%s\n' "$SOURCE_DIR"/Documentation/*config.adoc \
> +		"$SOURCE_DIR"/Documentation/config/*.adoc |
> +		sed -e 's/[# ]/\\&/g' -e "s/^/$QUOTED_OUTPUT: /" >"$DEPFILE"
> +fi

Okay, so we first quote the target output file once, and then we quote
the sources with a single call to sed(1), too. To not perform quoting
of the target output file twice we don't include it in the printf call,
but instead prepend it to each line.

Looks reasonable to me, and we spawn at most two sed(1) processes. Nice.

> diff --git a/meson.build b/meson.build
> index 762e2d0fc0..74b459b004 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -720,11 +720,14 @@ endif
>  
>  builtin_sources += custom_target(
>    output: 'config-list.h',
> +  depfile: 'config-list.h.d',
> +  depend_files: [ 'generate-configlist.sh' ],
>    command: [
>      shell,
> -    meson.current_source_dir() + '/generate-configlist.sh',
> +    meson.current_source_dir() / 'generate-configlist.sh',
>      meson.current_source_dir(),
>      '@OUTPUT@',
> +    '@DEPFILE@',
>    ],
>    env: script_environment,
>  )
> 
> Diff-intervalle contre v4 :
> 1:  e2f4e1f9ba < -:  ---------- completion: add stash import, export

The range-diff is a bit broken, but that doesn't really matter much.
Overall this patch looks good to me, thanks!

Patrick
