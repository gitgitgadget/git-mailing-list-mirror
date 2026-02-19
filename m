Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271FC3EBF16
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508607; cv=none; b=MgY/p88+zdvYw16JLt04bsoHKMJeKoJyEK49PdJrGTgwjw4kLHAK+s23IR0bql+sdgrhTu35/OP0/JB0jUyfhLb+KBp7Nv4elgKkDcM3ZNxjDDlzrUMxRsjxheyWSfuzdo9ssB/Tw1yU+AysNpIcH1i8js+6VP5JkEvpWTYnFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508607; c=relaxed/simple;
	bh=0ir0qFbJuCfUJU/7n/sCerhfhjzzba5426SyQ8E5f6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNWwSCZXdk/MuPnAkDJnOJLzsla4pLnBef1Xe1I+NKGWCued94CEtq9JFwU0E/Xlm7kgzTjZm2ZaSOqj5VKJtNyFnxuIGHvgwAD8Ph5tOlpiXKgoepoLAW1iTKjy9dhfg7SYaYt+xZuoyLfYZJiANUJkwGQylkCTABEqPZ57njQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ju/1w7Gm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pr1Sy0LC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ju/1w7Gm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pr1Sy0LC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4BAABEC0325;
	Thu, 19 Feb 2026 08:43:25 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 19 Feb 2026 08:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771508605; x=1771595005; bh=0ir0qFbJuC
	fUJU/7n/sCerhfhjzzba5426SyQ8E5f6I=; b=ju/1w7GmOy5QJibL9C0MvruWmk
	w95LOSIjG7EJ28eSKKPcUjbCWDyfV3KXiEQp0KI3FwGNs1iuvIlxr5uuvAhc0u6b
	datiJzPm0QzavoH+3LVVKVKn9DmgKWD3V3KzUM3RxBwvbXDFfEdSLVVycQ/EKGBw
	71D+DW4IV7XbOe+oBA23w29D/Yo6XZLK1Uozbp2ttDHTYvrjPVF6ZEFLx3HqwOSY
	kV9B3YNjFFgaPU2hvkU69ldsY1mtxxeD4G+/u2HvKqdt8dRv8kRfl6W6Vzfw6ST1
	bilN/fo15MVOezGJbAqimfqD3PhD8nXal4qFg2QQ/AHQWKBuqIPZpx2ZtvlQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771508605; x=1771595005; bh=0ir0qFbJuCfUJU/7n/sCerhfhjzzba5426S
	yQ8E5f6I=; b=Pr1Sy0LCPlNKquTbSvA3TLM2NFDQTLQDqPzYgds+KyBN9TpE07B
	/CMZilL/kX2gl5SsaJ+bcBmmJ9GZgGLQBCW2qfVhu1FoP/0yP9Dm+rqax17uDTmW
	IpjTEvM5X7AU2xWi9yAkF4syU3Z18qmJQ981J0yBnmdXrT9cKXClGYfj0htCcvet
	X1hKLtZ2UeGr3NVvqNpYmS+ki+eRIPUbwMteURJ6ixlUWM402Y8rBCbQ0PI6WA2c
	m+VvKyajT0mJskjVx+Qlw7daIBF+emdwBLKzpXlE4cTIAWLarAKd5EAAluhd0Vjn
	sDYOCCaawn+XehhILA92rDqu1upZDVGLDcw==
X-ME-Sender: <xms:fROXaRPZhGr24GGMM4bj3Bak3MC0QUzP6CWbhwfZWm12Zg7UUSOY3g>
    <xme:fROXaZ8eryUYP5kC7iPGlOMwXEWU_R8Bke6HhM6iw-giXtyTwbERpw_uR8VCJiW1X
    oBXdQ9Jq-Kd-bNJKcbbLAD184IR_eOuVjJv1t3F9KvaDmgWab1eGg>
X-ME-Received: <xmr:fROXad7Z77E4f1wHjlucmJX1bXex3FvpzEBgDNCFZ5-poLv-IQR9lLQobRju-M5W9hfe5rvIMsUEoKz_5G6P0-ITfMJYGKZMLxVsOon7bA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fROXaY2AX8WVkW5-v5qRWARX_wm4nAuDNuSjS6DKqBv9NpGSEx7aeQ>
    <xmx:fROXacDn6oiMeq9dG0Uw__My67RPUoEIZpYmUE_7JpqO3Xu8tntsHg>
    <xmx:fROXaS0Y0xopHf4xJuJDZHvtEjSAHfwJhwW9euS0CbXCU8mhZmR14Q>
    <xmx:fROXaetrqj6-_ESm41TFl8OyNoIi66GneIO5gcO2f4m_3xBg2V-kVA>
    <xmx:fROXaT_tn1otwgKtW3zK6OTLQFsIrJr5fLVvlw8Sa3saT17V9HqggYQe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 08:43:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fcd8f2d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 13:43:22 +0000 (UTC)
Date: Thu, 19 Feb 2026 14:43:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] object-file: use `container_of()` to convert from base
 types
Message-ID: <aZcTcgKDg6N4QW3j@pks.im>
References: <20260218210120.1146078-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218210120.1146078-1-jltobler@gmail.com>

On Wed, Feb 18, 2026 at 03:01:20PM -0600, Justin Tobler wrote:
> To improve code hygiene, replace direct casts from `struct
> odb_transaction` and `struct odb_read_stream` to their concrete
> implementations with `container_of()`.

Right. The reason we want to do this is so that we become independent of
the order in which members in `struct odb_read_stream` are declared.

The changes all look good to me, thanks!

Patrick
