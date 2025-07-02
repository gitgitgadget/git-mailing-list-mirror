Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0F42D3723
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 15:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751468912; cv=none; b=UEN7PmvJab3QBHsa2Dc68ykZq5HWWiA2t0OYqn99GpVB/VyJzcR6Vu2Qi25/YLPTKgBm2QiQxU3Z85S+WnDOBDvvC02rPWD3lPqlRzca6YOLBccNgjJQ903iQCXwsZrF//rq0okO6aw5NTV5rJUjcEXPSi1RVNSFDujJ+il295o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751468912; c=relaxed/simple;
	bh=TToSD4MIJqiYrrGpaiPnox4+2iXTitfKWqMizkuWoog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9ac6VKuqPuwrIy2+DxhzzenlXrrnT50jL1EkLA77/r0s59FlnInc5cc4fRBvCLOuKINZSn0EJExdfn5oASWNT6MIdiaMbALOIsMJxdZczqHvMILGuBK64AbLWG4j3ecfGjzERUiFxxxG+rDq78YxaBLDxH70Gp3Z0VtlSWXeDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IBul55IT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTru1m00; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IBul55IT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTru1m00"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C50CB7A0288;
	Wed,  2 Jul 2025 11:08:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Jul 2025 11:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1751468909; x=1751555309; bh=/8yTC5BSU3
	g0ee3Ti7RzU3Nim/fESS8nUc4pvnf/tFw=; b=IBul55ITD34C80VumUDiyhUnGa
	RlPlyeFL8l3dXeCBrtTjI0so9MGkMzz65mfvcLZdBc5KAdK7+59POuKpOv0VSQmD
	AYA1m46JlYbSVOIVfOCglIqmJ2rSnledVkbFXG47nGs//17VzWIAV4nz/NU0neko
	I5VhvgwTmGasftXS1CqykBMsWI51Wn1PXFbeWp787ULAhA1qA28QP+szgFoQdP2i
	Am4i3DTk79FghLnLiscQEO1HTQvAOeDMRBeC7e9hHyzuh9IL13x9F4AxPlVjx4cZ
	smflslckshVOtIXwWH5izyZ6kChQ4y2J+X3luaf6toQA0z8ltAB2+zWemy3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751468909; x=1751555309; bh=/8yTC5BSU3g0ee3Ti7RzU3Nim/fESS8nUc4
	pvnf/tFw=; b=iTru1m00fY2pFIsSLxc97Lmt33muqvwSxezZovIX8whT179PwF4
	IT9oy9bup4tI+1hBSTMvQJrGuGatt+LGuddgXbD7FzfPDl/Uk3utdPFTCLaT5VfN
	gLnm/r9funt3J6qBJHtNSbFk9rTM7axOxLl/5jih86Gz9SUmpQM6sFKuZ4JLr7I+
	JtGw9SSdvA6Qiv5Kdbiom8czUe9/DzryxF0CHSWojYLouXm7QktpfstGL7MF/KAE
	t6t9ia2PlOcx0oRGfUrl2WsxA6PZBlmlR8/+ROjF+NhEd1iJtmNr3ZiiLUbqbjYV
	wJKrBUc4nNfvNA8Eg8ic1tuTQXo30rkszEQ==
X-ME-Sender: <xms:bEtlaHVx4wXg5QwYbS3laY3u0gqmV9YUfL_ldHkxcvtgVZFL1AKvfQ>
    <xme:bEtlaPmImC8546auF9S-qAmV2peZS3Zd6xHJi1rxska82eeA2G_5xj63owvsz2nuf
    zkWI5VikcI4HkacaA>
X-ME-Received: <xmr:bEtlaDZg7nkJO2tCvQNle0JI9133kpd9joQCc6gO3tP53DnAODA9ZEBO5Wgqry31gt6n1EagoNEHL00OeU0eOYuCcAwrBUVkxMMfgS7ceA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhe
    fgueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopeehtddvtddvgeeffedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghn
X-ME-Proxy: <xmx:bEtlaCXnmt-T1SRf2r4PyuHjb9GBqwD3f8FvPepN1r9CnNtFCcRVqg>
    <xmx:bEtlaBlt_8h4XSk5Eyu8mclEqCfbMhqZ2628Mo_gOaoW7n3kM5qIXg>
    <xmx:bEtlaPeFuNJxWIx8QJIfHluBqyGavSySixzTWVzSYfKaJyVivDajuQ>
    <xmx:bEtlaLGFPqX-xQ9wUMmuI1hL08Lxl26jVRUtOVXsuHX_OmScLpc2Kg>
    <xmx:bUtlaPSFcnffgWvl6kZ39ZLKZfSffb_Y7Vg-lghyZCmZVY6_scudPGAp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Jul 2025 11:08:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 39ce07dd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 2 Jul 2025 15:08:26 +0000 (UTC)
Date: Wed, 2 Jul 2025 17:08:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v3 1/2] bloom: replace struct bloom_key * with struct
 bloom_keyvec
Message-ID: <aGVLZ9VUf2M1sWhL@pks.im>
References: <20250627062154.1121530-1-502024330056@smail.nju.edu.cn>
 <20250628042140.1097910-2-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628042140.1097910-2-502024330056@smail.nju.edu.cn>

On Sat, Jun 28, 2025 at 12:21:39PM +0800, Lidong Yan wrote:
> diff --git a/bloom.h b/bloom.h
> index 6e46489a20..9e4e832c8c 100644
> --- a/bloom.h
> +++ b/bloom.h
> @@ -74,6 +74,11 @@ struct bloom_key {
>  	uint32_t *hashes;
>  };
>  
> +struct bloom_keyvec {
> +	size_t count;
> +	struct bloom_key key[FLEX_ARRAY];
> +};
> +

A short comment would help readers understand what the intent of this
data structure is.

>  int load_bloom_filter_from_graph(struct commit_graph *g,
>  				 struct bloom_filter *filter,
>  				 uint32_t graph_pos);
> @@ -100,6 +105,17 @@ void add_key_to_filter(const struct bloom_key *key,
>  void init_bloom_filters(void);
>  void deinit_bloom_filters(void);
>  
> +struct bloom_keyvec *create_bloom_keyvec(size_t count);
> +void destroy_bloom_keyvec(struct bloom_keyvec *vec);

These functions are named very unusually for us -- the first version of
this patch series was following our coding guidelines, but this version
here isn't anymore.

 - The primary data structure that a subsystem 'S' deals with is called
   `struct S`. Functions that operate on `struct S` are named
   `S_<verb>()` and should generally receive a pointer to `struct S` as
   first parameter. E.g.

Second, the functions should probably be called `*_new()` and `*_free()`
instead of `create_*()` and `destroy_*()`.

> +static inline void fill_bloom_keyvec_key(const char *data, size_t len,
> +					 struct bloom_keyvec *vec, size_t nr,
> +					 const struct bloom_filter_settings *settings)
> +{
> +	assert(nr < vec->count);
> +	fill_bloom_key(data, len, &vec->key[nr], settings);
> +}
> +

Similarly, this should probably be called `bloom_keyvec_fill_key()`.

>  enum bloom_filter_computed {
>  	BLOOM_NOT_COMPUTED = (1 << 0),
>  	BLOOM_COMPUTED     = (1 << 1),
> @@ -137,4 +153,8 @@ int bloom_filter_contains(const struct bloom_filter *filter,
>  			  const struct bloom_key *key,
>  			  const struct bloom_filter_settings *settings);
>  
> +int bloom_filter_contains_vec(const struct bloom_filter *filter,
> +			      const struct bloom_keyvec *v,
> +			      const struct bloom_filter_settings *settings);
> +
>  #endif

This one looks alright though.

> diff --git a/revision.c b/revision.c
> index afee111196..3aa544c137 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -779,11 +782,8 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
>  		return -1;
>  	}
>  
> -	for (j = 0; result && j < revs->bloom_keys_nr; j++) {
> -		result = bloom_filter_contains(filter,
> -					       &revs->bloom_keys[j],
> -					       revs->bloom_filter_settings);
> -	}
> +	result = bloom_filter_contains_vec(filter, revs->bloom_keyvecs[0],
> +					   revs->bloom_filter_settings);
>  
>  	if (result)
>  		count_bloom_filter_maybe++;

This conversion feels wrong to me. Why don't we end up iterating through
`revs->bloom_keyvecs_nr` here?  We do indeed change it back in the next
patch to use a for loop.

> @@ -3230,10 +3230,10 @@ void release_revisions(struct rev_info *revs)
>  	line_log_free(revs);
>  	oidset_clear(&revs->missing_commits);
>  
> -	for (int i = 0; i < revs->bloom_keys_nr; i++)
> -		clear_bloom_key(&revs->bloom_keys[i]);
> -	FREE_AND_NULL(revs->bloom_keys);
> -	revs->bloom_keys_nr = 0;
> +	for (int i = 0; i < revs->bloom_keyvecs_nr; i++)

It's puzzling that the number of keys is declared as `int`. It's not an
issue introduced by you, but can we maybe fix it while at it?

Patrick
