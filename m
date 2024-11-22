Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89680230999
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732240801; cv=none; b=ia/JkecHkB3lZAe1e8DUk6vUBEL0NH4AsU2XRtgKJFG72hjO20pl5EJKVRSi1TKUUGBYgJ0QQu2x6MbUSNmNw67ULkhMnLeMbjooGcPksg4CtFhBwYcXsFpbHOhIpRL+HSHE2rWXgBWuAXmtZAnXLRBb0e80Seo/RkfEIJrpshE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732240801; c=relaxed/simple;
	bh=rP1+3FuOkTkTYFIYUWEcp45s5V63nDqsQ2F4AQA9Cb4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oPq/QUZtctpzQ/ora5AxD+mrIFScCK7ipHpMZGrzjWZJHE180UH4gjYzmAP0KL6dtlJ4ckiKodE0i2qT+RHa3nM6CZkbMoY6ajrlDuReeLC2ptayJaUIfTou5qtx9E3bghWsXt8wh11J/uwDSQgSdtDikTTmYIP8VWkELCCW9TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vfbHPlrb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vfbHPlrb"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 8E2AE1380604;
	Thu, 21 Nov 2024 20:59:58 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 21 Nov 2024 20:59:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732240798; x=1732327198; bh=bl5Ik9wpL+5Gv87239UGe9dNokCys25YdoS
	LwcveU5A=; b=vfbHPlrbhCBPKFKynVFS9hOs2iuBjexymWF8MzxmUQc1pe2l579
	tAJlO69yfQDRfx17Ov/Xd8rmLpjeCep0M5ZZMTqYzfjdDGcenAtFku/rL1Ou4zsp
	S4jlyVF3WcEVIwk9IYZ1wKai+63Xf2imGKG2+NXatV2tOFkCLr++pYDtoFzWjTlj
	4KQdaoBE7g3c1QsZGo4EXjHwMFdiPpfu1oLVKRjZi8ZIHdTD77M52rtXL754y1IF
	dCzXZmcpZWhsRznyDkGamqM/AyRc8rNitLOb7MXbtyyYt1ZkWKU1rN3gILqjjtbD
	C04BDOTeR1o7Rx7FoSUsHNA8CUpT461ZaEA==
X-ME-Sender: <xms:nuU_Z-Cm79Xv-DP-CGZNnxl2VbGDlWxZeMvVMqc69REPvX8Ox7ZQDg>
    <xme:nuU_Z4hpbcXoEXvyEIcMPNFAtO-XxtHvTup0qGbkaQs6avzES1kx1pLTQOAUBMVJE
    JI6MWNRVLX4P-2w2A>
X-ME-Received: <xmr:nuU_Zxl3Jo0Wbpa7Z6uMjnD-aTqoUudRk85B7aNM_GBD0Nz_96p0VFvXboD_zM-lC1p-nxYNFiRbXJsAuXxbtmrim7UNo9FKgHnh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeejgdegudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:nuU_Z8yXUGZQ2AQA7_r69Y1DyKW5UJrPNAY7_qmTNTlyo3hZl4ngVg>
    <xmx:nuU_ZzSuBQ16iwjbd0ffZeQA2e_3_lrHWrvgkMPrpzES0Sq2C9AM_g>
    <xmx:nuU_Z3aAxNZTGZxa1qZMjjhz7DZr5vHCGU00BrFJAId7HvutRw3rHg>
    <xmx:nuU_Z8RHejB7_ZBjeVRm0LhfbfwO5tbUer0-V3uk_mMzAH7fuQC5qg>
    <xmx:nuU_Z9c-1Hv-jprp-XB08MrkljYguW9kFtdCA77V2HCruA8vUFCvaboK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Nov 2024 20:59:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/5] transport: propagate fsck configuration during
 bundle fetch
In-Reply-To: <20241121204119.1440773-6-jltobler@gmail.com> (Justin Tobler's
	message of "Thu, 21 Nov 2024 14:41:19 -0600")
References: <20241121204119.1440773-1-jltobler@gmail.com>
	<20241121204119.1440773-6-jltobler@gmail.com>
Date: Fri, 22 Nov 2024 10:59:56 +0900
Message-ID: <xmqq5xogc9k3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> When fetching directly from a bundle, fsck message severity
> configuration is not propagated to the underlying git-index-pack(1). It
> is only capable of enabling or disabling fsck checks entirely. This does
> not align with the fsck behavior for fetches through git-fetch-pack(1).
>
> Use the message configuration from fetch-pack and wire it through to
> `unbundle()` to enable the same fsck configuration as done through
> fetch-pack.
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  t/t5607-clone-bundle.sh | 7 +++++++
>  transport.c             | 5 +++++
>  2 files changed, 12 insertions(+)

Nicely done.

>
> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index 7ceaa8194d..c69aa88eae 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -171,6 +171,13 @@ test_expect_success 'clone bundle with different fsckObjects configurations' '
>  
>  	test_must_fail git -c transfer.fsckObjects=true \
>  		clone bundle-fsck/bad.bundle bundle-transfer-fsck 2>err &&
> +	test_grep "missingEmail" err &&
> +
> +	git -c fetch.fsckObjects=true -c fetch.fsck.missingEmail=ignore \
> +		clone bundle-fsck/bad.bundle bundle-fsck-ignore &&
> +
> +	test_must_fail git -c fetch.fsckObjects=true -c fetch.fsck.missingEmail=error \
> +		clone bundle-fsck/bad.bundle bundle-fsck-error 2>err &&
>  	test_grep "missingEmail" err
>  '
>  
> diff --git a/transport.c b/transport.c
> index 7e0ec4adc9..a9e03c3964 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -178,6 +178,7 @@ static int fetch_refs_from_bundle(struct transport *transport,
>  {
>  	struct verify_bundle_opts opts = { .flags = fetch_pack_fsck_objects() ?
>  							    VERIFY_BUNDLE_FSCK : 0 };
> +	struct fetch_pack_options fetch_pack_options = FETCH_PACK_OPTIONS_INIT;
>  	struct bundle_transport_data *data = transport->data;
>  	struct strvec extra_index_pack_args = STRVEC_INIT;
>  	int ret;
> @@ -188,11 +189,15 @@ static int fetch_refs_from_bundle(struct transport *transport,
>  	if (!data->get_refs_from_bundle_called)
>  		get_refs_from_bundle_inner(transport);
>  
> +	git_config(fetch_pack_config_cb, &fetch_pack_options);
> +	opts.fsck_msg_types = fetch_pack_options.fsck_msg_types.buf;
> +
>  	ret = unbundle(the_repository, &data->header, data->fd,
>  		       &extra_index_pack_args, &opts);
>  	transport->hash_algo = data->header.hash_algo;
>  
>  	strvec_clear(&extra_index_pack_args);
> +	strbuf_release(&fetch_pack_options.fsck_msg_types);
>  	return ret;
>  }
