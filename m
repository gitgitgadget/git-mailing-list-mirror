Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A273CCFAE
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 07:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943319; cv=none; b=pB+h6XshZ06MZjtrpGH+EwyabAFClmvd+LoSxUrMCHGSWXswZmq9we+2LEWBp/gADtka8Dyv68UGj19MtN55Rxirb2gC29ytFGWEY1CguQAztQyuULfOJnFBkk6dFS8qxR/CZe9KhQTjAjL5ilsoTvYKXH+wHtG41rNw28zVnyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943319; c=relaxed/simple;
	bh=8uZ97Smq5Irf/AG/EhRdRn/r2CmHQz+lWZ+ef5vt+Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MtOtwNkvjnq1/wN8YuE1xSU6fnuskawWgDi0Hf6qUlYU+IE2DQAduU3NA7TjCML+TEYJEasIkLObhrF2cOyKL73J11wazpG9FFyEJI07f+seOEEZGGRf5OcP2Vf4MONiGytS+F7NYW6ffOiZZIg6rjsJeJtFigEbSsvdGdG2HdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SHXwq8MH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WnAeLOqM; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SHXwq8MH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WnAeLOqM"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D86A1400259;
	Tue, 31 Mar 2026 03:48:37 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 31 Mar 2026 03:48:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1774943317; x=1775029717; bh=3mb2kgXM4V
	02WkU63Zj4ceVEC1N2XaiaKPpSceiIwI8=; b=SHXwq8MHlvIHViDyKFaqlcdOI8
	e2cJOf2CcY5TgC2CyrPkCh/A77Gri2kzkp/390R75q/nm7sXVQTUwmix9gs10F9V
	cOWF+6SibEcpwvqWFzBzxpfcrWTPHhCvRnjcSi7lInevqjdP2qrqoFcsRNB0nGdK
	IR4ggwu6/Z/6DY2YMR/QGBMQca65vH1TDBNP62U1FCleseqe96xz6p4UX/ibikzV
	3p8YQY3lD9rh6TVYY7LaYx9F8f7IduxMF/Ws3mkN+K+M5SeOd6ejNu6PtwQQRYlf
	itAgJ0SJAQdgICmYROY+TIIl0+doZUAUrTFm6I0+z2QHrgHd8hGpkftEO7ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774943317; x=1775029717; bh=3mb2kgXM4V02WkU63Zj4ceVEC1N2XaiaKPp
	SceiIwI8=; b=WnAeLOqMMIEylK+87Ji7c1Jc1R0ybgbNJbXL2JPAi1vGUJTxgx7
	VlJ03ffscbTShU00IMCoogPgA6Dn+6iGevSsk5kFrJs+4fsSibTGW3wonKxdNNsc
	75gY7cdoCpfZDpmAdxtln5WI3u7sgRo9sViqnrQCOscjMmjbNlcWFmTxOOHy6WLq
	NRSWKE311kVqF2VliuB/QkucZJqRzbeTeNuKbmqr8rN+0rZ2bVnPcRPYII/Pvibt
	HzmZHLBNWtXFn50eyrSW5Neb6perP0URx3IQGO58NlQGDfrXIrN7Zwov1ajZiv41
	DgeFbe4zCO4Nzwd8RoP3b2gUWIgD2bR868g==
X-ME-Sender: <xms:VXzLaX8CJ4YcSPeV-OWkTVVUq-JW-vXTgu-zscDA1xj9AhIksAew_w>
    <xme:VXzLaZvJgXLVfkVK3MBdgNfa1QseNtUY1TvgMZ4edijum_7-AUgIgCBJVkmaFYAVM
    l22SY8JA-12Y2BIWYWejGlhOUh-n3XwncccYovKwXwNSaFFl2M5AA>
X-ME-Received: <xmr:VXzLaSoPkdUgajMQYpCyQfsWBcGANfbA8Z2Cq6n6E9pfKqeNfVgbwyKZvjc4e10belqrfYA8OYFK-DSJ-TExNLYXq0l4WxU0qNgADr9NI8M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedufedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:VXzLael59dAZKKZ68yFXsZcUhQZizaECb5fC6zyurSIH3ZOi5triSA>
    <xmx:VXzLaey7nt4o5AAGv183vd2eJFAWDuEGLtSObVEEEwvud7V0Jxmy1A>
    <xmx:VXzLaen2k-kKukqeexZJLX4l9yI1l4zOW287ehjTq_cqqRYOoT-xrQ>
    <xmx:VXzLafcpNuymjDppHJNSEDSh-j0zFEoJdFQtE0WznHfiJM_PEU23qg>
    <xmx:VXzLaWvNAfCAReQvo4Maz24pfVhSGpxG8SLK3k6fmuZpUk5bWDM6En95>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 03:48:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c0ed165c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 07:48:36 +0000 (UTC)
Date: Tue, 31 Mar 2026 09:48:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/6] odb/transaction: use pluggable `begin_transaction()`
Message-ID: <act8UWTmK5iM2iT-@pks.im>
References: <20260331033835.2863514-1-jltobler@gmail.com>
 <20260331033835.2863514-3-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331033835.2863514-3-jltobler@gmail.com>

On Mon, Mar 30, 2026 at 10:38:31PM -0500, Justin Tobler wrote:
> Each ODB source is expected to provide an ODB transaction implementation
> that should be used when starting a transaction. With d6fc6fe6f8
> (odb/source: make `begin_transaction()` function pluggable, 2026-03-05),
> the `struct odb_source` now provides a pluggable callback for beginning
> transactions. Use the callback provided by the ODB source accordingly.

Yup, this is an obvious oversight on my part.

> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  odb/transaction.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/odb/transaction.c b/odb/transaction.c
> index 9bf3f347dc..592ac84075 100644
> --- a/odb/transaction.c
> +++ b/odb/transaction.c
> @@ -1,5 +1,5 @@
>  #include "git-compat-util.h"
> -#include "object-file.h"
> +#include "odb/source.h"
>  #include "odb/transaction.h"
>  
>  struct odb_transaction *odb_transaction_begin(struct object_database *odb)

Nice to see that we don't have to care about "object-file.h" anymore.

Patrick
