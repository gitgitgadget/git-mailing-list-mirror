Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18743BD643
	for <git@vger.kernel.org>; Tue,  5 May 2026 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960353; cv=none; b=anlGtrxVqyIIWF+wBBhkD+CQFrLsAKGMG6raAO8UqF5N4f9GyCQQxhn2AYh9C8H03psgPS9dmk3qz1MQu9fCnhhhRuES7eHXv1Dwb8BSoOt8Np46TI2peisdxAINxwfPK5KjtN02jsCyEaAJnPkr2itWQ8fGEceBSxNWqCAWDvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960353; c=relaxed/simple;
	bh=KlfB0wSS10NCyQoyJ1nseZNuoRfSMkBBrgv5b5oF9ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYhmbC0Bgnlfk4m+ZYPKBGFi5Kip6cIiolp295d0YCWjzLp9yHUivB2dohYt40S5p7jBv2vJnT4ewHRJyMa3+Sq7M5olyjjxKqKoW9upMTQugLdR9+9x/xhYiaGjMvF4NvZ4d7A6zjpFFYQA/XblKSVG6hYMRKgM4QZOdlR/g3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jCeVeh9J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zpea295Z; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jCeVeh9J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zpea295Z"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id AFE6E1D0002E;
	Tue,  5 May 2026 01:52:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 01:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1777960350; x=1778046750; bh=5mDC9mUXO3
	//k08y8Ji4uxAIm/xR23UxCTjTF2ign3k=; b=jCeVeh9JT0TIMmCQWe9hU8FiXo
	dp0gtqO7Hj0ec8ldlVdrP8Ki5w0napsk5QsCd46Q24Nl48Z/146DWfVjDrIKHjIX
	0qniLDnp5VXaFf6Qdg1r6HcXWhh0z1WKWQMGl/UCEAz2p69n7VkhA5xGicnu+Ios
	m6zyydnQqqochgUUtY77OK1gB7QDsUHC88SYJfQR25uBVbeHe8oJ+XwCtzBe8u3Q
	3P7pQLj2/WhA6GThudtMx6ArZARXWNxrOAoGs9tjYFBoC50Q/SBbf/nkxMX1Ot2m
	4LB9zXmKHk1p+oJzr/WohWRb7RSc2xOn/oK74rqBKVX+DjrCuK68fXQ9BePg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777960350; x=1778046750; bh=5mDC9mUXO3//k08y8Ji4uxAIm/xR23UxCTj
	TF2ign3k=; b=Zpea295ZQpyh+Xdv/Ilu56Mqg9A8muPs6qPpPgfDXUy8AV7yYzN
	5oJvvhUkK8MXGWQ3AYyOnMc647S2BwIstm+4tN9jPq5+NA5HtbD3kH8r/nnc4uZt
	5CqvPb27/dIOqGhGfKChmQdNps3cFUq092jNPXaVxxFSorMaM232zpTn0QOmTIij
	/mn+nfwXNUNP3nUCGInf/hKj/2PWv2lIzuO0DXbToO/T7MFc3CZ5Kc0Lbnl/3/lY
	YDcoGPquxNMzVK6vdK5gvo51wH0+P+XxfvFHR/V0s+QtpexaIEqPlHq/sV9/xewS
	JljLquCJCaLduR83CLohmR6UlxOIuh9WF2A==
X-ME-Sender: <xms:nYX5aRbwD6aButcw2q009GXju2U8_jiWq7oxLknE_IyviXIyUUrPlw>
    <xme:nYX5af30liB3CEsvnnjWGYaM4ZJ7L5PPCAEJSlXiggjhEOAkks9gjAehsr_SczLyU
    7ChE8qBUECkx55Gs3ii2VZY1FQAIvHXdobLv0sidUgaXTkk61uzmA>
X-ME-Received: <xmr:nYX5aRWmG_TJUWW5vyxS9Nw1HKH8ZJehzx9ZdmKZur07gzZXA_Vi093cfri9Rkum9pumkHPaA9mkUqCHpULLFq6FG-ki_BOCucYiqg6GqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddtleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgt
    ohhm
X-ME-Proxy: <xmx:nYX5aZUYIwEkRuIGk-rRdwuAXxPwPbFP_nwUBS9boEQcSL_6b1mDjg>
    <xmx:nYX5aQfRxE2TK_F2cJhMcciuqSuGQzm8aiTemojnMzP_MGOA8YEd3w>
    <xmx:nYX5aSXLnr_U5uM23qHMvg_hBFQmPuIr1r11CI-wso_w_DVglO0EVA>
    <xmx:nYX5aZfGDgvWZP-kIWXJOXVl4WK8FCn4HSqVm3PbUUqJpBaUNPyGPQ>
    <xmx:noX5aX3dDAwxoP3zlEYc0Ne8zQUvkOIJJKVzWhryyc44f4HAAvBCfO74>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 01:52:29 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e210f138 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 May 2026 05:52:27 +0000 (UTC)
Date: Tue, 5 May 2026 07:52:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, toon@iotcl.com
Subject: Re: [PATCH v4 6/9] update-ref: handle rejections while adding updates
Message-ID: <afmFmGo_Sg33Rv6V@pks.im>
References: <20260504-refs-move-to-generic-layer-v4-0-936ac2f0b1a3@gmail.com>
 <20260504-refs-move-to-generic-layer-v4-6-936ac2f0b1a3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-refs-move-to-generic-layer-v4-6-936ac2f0b1a3@gmail.com>

On Mon, May 04, 2026 at 07:44:10PM +0200, Karthik Nayak wrote:
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 5259cc7226..6355c3dd3e 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -257,6 +266,31 @@ static void print_rejected_refs(const char *refname,
>  	strbuf_release(&sb);
>  }
>  
> +/*
> + * Handle transaction errors. If we're using batches updates, we want to only
> + * die for generic errors and print the remaining to the user.
> + */
> +static void handle_ref_transaction_error(const char *refname,
> +					 struct object_id *new_oid,
> +					 struct object_id *old_oid,
> +					 const char *new_target,
> +					 const char *old_target,
> +					 enum ref_transaction_error tx_err,
> +					 struct strbuf *err,
> +					 struct command_options *opts)
> +{
> +	if (!tx_err)
> +		return;
> +
> +	if (tx_err != REF_TRANSACTION_ERROR_GENERIC && opts->allow_update_failures) {
> +		print_rejected_refs(refname, old_oid, new_oid, old_target,
> +				    new_target, tx_err, err->buf, NULL);
> +		return;
> +	}
> +
> +	die("%s", err->buf);
> +}

It's a bit weird that we pass in the error message as a strbuf given
that we really only care about the actual message.

> @@ -644,6 +699,10 @@ static void update_refs_stdin(unsigned int flags)
>  	struct ref_transaction *transaction;
>  	int i, j;
>  
> +	struct command_options opts = {
> +		.allow_update_failures = flags & REF_TRANSACTION_ALLOW_FAILURE,
> +	};
> +

Nit: stray empty line between the variable declarations.

Other than that this patch looks good to me, thanks!

Patrick
