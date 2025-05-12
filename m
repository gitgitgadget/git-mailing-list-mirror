Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EDE258CF3
	for <git@vger.kernel.org>; Mon, 12 May 2025 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747038349; cv=none; b=QaAEIN+Mqz0ddXrdfzprBxT+YPmI+yHc2+gOtTNDC4wO3LgaXGtl4Qt9ZKhBAdMbpuCfH9J8QEEvO7ZwVyaQ68wJ/GcVm6dgrfbNmF+EeS1f0aKJ6jd4XfA6tnnvn9jKSsdIgwBdH3GTn66aVH+/DmRgg4GXAc1AGNBtnNhwIH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747038349; c=relaxed/simple;
	bh=+xJ4qAiLuaLcRqCUghNQPL1tOx1naxkCy2I0ShAYrwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PlMbrcySY8q6yLpHxcoD6VIvVYp7jvC5pHmQKSeaMuOubXPC7a7yl3Mfwp3pVYDR4jBdRajsTi22bb+AVa0IGCjVWwxakzD/io/QxZp4FJeGSAORDPZQozpZK/cSLaqofEtnIcquKjj/fCIcChAwu3qd/OLsMfLcrdk9YH8GDNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hFnvfCR6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GlHC0l2o; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hFnvfCR6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GlHC0l2o"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 74FDE1140146;
	Mon, 12 May 2025 04:25:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 May 2025 04:25:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747038345; x=1747124745; bh=JAe+xhHK1i
	T7SjIXZzsx7a1f4zYYPVBL6omTvPOKTb0=; b=hFnvfCR6zxkdptoii+JcYuZ9O+
	6Hqx8QfrHIMaR0E0gRyi1Lm6m9sW5H9I5Q4b0nsWtUEm7Yl7YtiQ0r1y92Im4Lk0
	ed65gyzqqe4zNwxXn44+abseYcKet75ze0OYv25r/VTFxS0cr5sef/acy4zudZQ4
	F5qLnDgnov1A9zSaR2kXZufjvplddor6RpM0R6h0KGPHPuhGjxbBM/jXwIxMT3Az
	djIA9ou9adbeVunu062OOEFEjsb2hNqpxhpnG35j9wwC6W3297291cudeBQoKZu8
	Gi8FEg+BlJ0KIH8qxvd0+dirnc9aSmjwoHn8XObEhfyc5W2UXJrzVLjhhzgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747038345; x=1747124745; bh=JAe+xhHK1iT7SjIXZzsx7a1f4zYYPVBL6om
	TvPOKTb0=; b=GlHC0l2o97J3dTXqOeUdWiyBo8j5/GH32ZdnTKulmCYVTTPE571
	9ra16fXIKP1FKCTFBN2+vC9BcjegkRF1/zdO1r223EfB2p0l2pYWbPItsAYLIYqL
	xQjK36dEvpgZTsoCdjq0CYvCdO6vVw7FrtlVddE3eFsgo+fF5hJJeE20uiKvY4Ga
	59xTDKjOo4ciruR8azdLx90dB0oE+H92MK1XoV9KNu7JgayeB450Ke+nJ3AIoU4F
	DUoFa5+LJnGRP5T+SBkKHnoQGF+gtWfG7veX32kuokmuHwJzXZL18RGaIhvC/XzZ
	N9GGLBSnyU9JY1Tq4uphS7g292kNHMMbCJQ==
X-ME-Sender: <xms:ibAhaCwvFKvDwmRockZ2PuCBJr_Wl-rCyskxP0FBY_M9Cib6Ju5mdA>
    <xme:ibAhaOS5f-bGGLvowwPWbaMghMNS4WrLZeS2FzA_1BDZnSKboZL1jU4gI4TrEkv2H
    Tkovf6CLJ2YXJu5JA>
X-ME-Received: <xmr:ibAhaEVW9fIf-8vv6MTfDXD5hvjsl6OXA5qCUal5groPge834rTYrtMZT1laoovmffL_VwLnKlwL4lkEWOta9EaYR2-bojNFafxDNRMsxYo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftddtjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohephedtvddtvdegfeeftddtheeisehsmhgrihhlrd
    hnjhhurdgvughurdgtnhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:ibAhaIgld4CJCfEcRoRdGTsxwc6f11ykdYFfsJE4I0NLN51_Qqking>
    <xmx:ibAhaEDvFoT5P0LDEg-9m8-ks85-q6lO3Vl2lw4ZLUztJdJ-9K6WMw>
    <xmx:ibAhaJL6nWi4jdD-Cm7M4JE5m9B1D51kLoSxJCxRTAaiODxHndwp1A>
    <xmx:ibAhaLBtmIdr5bODBPNzsGthMlBeFC-wTo3ykDZUkdx8cknyqAw4xA>
    <xmx:ibAhaJ_qHGveGFUDtGF0wblQDxpRYjseKuBJHs50w63kS8PLIhdaZTDH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 May 2025 04:25:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ee2d87e8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 12 May 2025 08:25:42 +0000 (UTC)
Date: Mon, 12 May 2025 10:25:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v2] reftable/writer: fix memory leak if write fails
Message-ID: <aCGwgbJ_dbO4vKq3@pks.im>
References: <pull.1958.git.git.1746849030749.gitgitgadget@gmail.com>
 <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1958.v2.git.git.1746980165245.gitgitgadget@gmail.com>

On Sun, May 11, 2025 at 04:16:04PM +0000, Lidong Yan via GitGitGadget wrote:
> From: Lidong Yan <502024330056@smail.nju.edu.cn>
> 
> In reftable/writer.c:padded_write(), if w->writer failed, zeroed
> allocated in `reftable_calloc` will leak. w->writer could be
> `reftable_write_data` in reftable/stack.c, and could fail due to
> some write error. Simply add reftable_free(zeroed) will solve this
> problem.
> 
> In reftable/writer.c:writer_index_hash(), if `reftable_buf_add` failed,
> key allocated by `reftable_malloc` will not be insert into `obj_index_tree`
> thus leaks. Simple add reftable_free(key) will solve this problem.

Nit: I think it would be sensible to split these up into two commits, as
they touch different areas of the code.

> diff --git a/reftable/writer.c b/reftable/writer.c
> index cb16f71be49..3b4ebdd6dce 100644
> --- a/reftable/writer.c
> +++ b/reftable/writer.c
> @@ -57,8 +57,10 @@ static int padded_write(struct reftable_writer *w, uint8_t *data, size_t len,
>  			return -1;
>  
>  		n = w->write(w->write_arg, zeroed, w->pending_padding);
> -		if (n < 0)
> +		if (n < 0) {
> +			reftable_free(zeroed);
>  			return n;
> +		}
>  
>  		w->pending_padding = 0;
>  		reftable_free(zeroed);

Makes sense.

> @@ -256,8 +258,10 @@ static int writer_index_hash(struct reftable_writer *w, struct reftable_buf *has
>  
>  		reftable_buf_reset(&key->hash);
>  		err = reftable_buf_add(&key->hash, hash->buf, hash->len);
> -		if (err < 0)
> +		if (err < 0) {
> +			reftable_free(key);
>  			return err;
> +		}
>  		tree_insert(&w->obj_index_tree, key,
>  			    &obj_index_tree_node_compare);
>  	} else {

Makes sense, as well. We want to add the node to the object index tree,
but if a step before fails then we naturally want to free the node.

Patrick
