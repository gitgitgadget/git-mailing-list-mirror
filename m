Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F831227B81
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745959704; cv=none; b=cdnlauX9o+J6c/U5tAEYD/LBcCQckrA33LZIgdooKGHNZjenk2CNad3PNtsdu1QoB8hcfkxbkNshIxmsHUtyqSpk8SekmEyvf9KLWIdVCOq8QDkvQwi65c2SCp3h0AbdttO4fi0Nw1uPgg30ZJ7tNnm1bBWR7fCDLC6OEFuj5dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745959704; c=relaxed/simple;
	bh=BpE+WCL2EG43KSnqh/RrHFdR8GQc4mkvbMMHW7gGyk0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K6W7tIA1kEEk6CIGDwg2hlQ9mXMsaTltuAG0qeQNM3qm8sgR7+oUnj4emRuNUQuptrQrG+PCE9HMY6H5/OL9SJXETTFiEz3sMhuP2V6ndwc8bIm4YrUwZct/bVw2uJt3zfPlYdKzL4MjoprhKY2jHk9oMecHOc/2ccRbbCOuL1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pK9y+cjH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nX+xq6d1; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pK9y+cjH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nX+xq6d1"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D112114025A;
	Tue, 29 Apr 2025 16:48:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 29 Apr 2025 16:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745959700; x=1746046100; bh=FcZ1+fO+t2
	0ibc/8R5uh0Orty8dB/K9GQNyvDgg0w8M=; b=pK9y+cjHAtzjc1fscEKP6OLIWE
	O7Dsq7+X/0CXVoNHZ/YzSdYAhC7dMoK7CYcKEDfhwRn7wH/ssINA8/Jp4VaEdTOU
	ln+UAXkrI2XWfcrqL7wdN8RsnlZLbcX5JpOU4Uo/R5sBvxYzL53iR1F8vvegfnst
	va+zlnBGW7o7+y+l8dICJgjpegJD1gtQdIuadFTgLJ0eQZZPghgzgeTKQ33benY5
	HoSJPmIeQkzcJjWxyBL6u10MAEVRqQjUb0+OGTKtfvXF1pB13pK9ksBNGWoh5K/+
	oDZfoKUyO1fx7+eU0ZFoGhUv7s79mqdzKVdmT7z0ePtO0FyilAlhh0ov1qsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745959700; x=1746046100; bh=FcZ1+fO+t20ibc/8R5uh0Orty8dB/K9GQNy
	vDgg0w8M=; b=nX+xq6d1anDkwwVZy+yQpHfiSAQX4cwAh8ulkUYRdO1FhcBW172
	Fh3+iAXSC/owruBas55phJOA75t95/xCdUtFkfa2WlDNkbX5z++KywHdgUgKUL/e
	vU17dh6QsTvHgBdacrNweSuj6XD82/2zlJy4/F7vRg/NvRmkJDbAhC2kKKFTrlpn
	Ah22yBI3O62+eE9liYq2vZX2hp8m68GbNAAYxnHpAojUozUsGOk4EhBq6dkSh6Zp
	3kd4qCA6IF39g7/1UR0hdM2nDvyxqxY+ZVdIOv0g82mrkc8txSNuGXtAnGOiesuq
	2cuQpo1xrH1HttrkBXm1loqNPYGPytx9QUQ==
X-ME-Sender: <xms:EzsRaNmUtaRTjMHR2bJdkdnlbY6ma015QhFqjSJlNi4iMH9zmyvZ7w>
    <xme:EzsRaI1yDfMFv6djiHH_Nm82reLkxIuzy79wOY9ebU-Nrk2i2u9GXDH0olgGn_cpa
    6UcMi19Nyn2qwSb4g>
X-ME-Received: <xmr:EzsRaDrMAGks02OucPUQ417Db-CQPCkjLJxX5d3yV7zfeqKUrNw7A3A-26_3ZCBh3Y8iNAAkbU2Wm66jhq_H2rc5a4ef5W4kaH1_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieegkedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhohh
    grnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:FDsRaNl8LkOvv3-q0EfbZGVCuOM_gqSdhPK8tHXmOw9ulZ_91fOOKQ>
    <xmx:FDsRaL3iReGKnlO7zFs6--t51RqMNcUI8WekZViwmLCxO8fU4n-1sg>
    <xmx:FDsRaMv0mSFsOhikeUapS2bIAtwRpkbVC8Lf-4ACC4UAcLY9MckZdg>
    <xmx:FDsRaPUtPcjLe-u6BQmgmoTfle51p58ZuIjlc8cH-PLv14kUubwKeQ>
    <xmx:FDsRaBIVDTvEELbuB4EP1QOb5P4wLp-Y7yAfL8Yk70FYHV7D5HThf4Of>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 16:48:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci(win+Meson): build in Release mode, avoiding t7001-mv
 hangs
In-Reply-To: <aBDD-NeN2YoQbU9S@pks.im> (Patrick Steinhardt's message of "Tue,
	29 Apr 2025 14:20:08 +0200")
References: <pull.1908.git.1745593515875.gitgitgadget@gmail.com>
	<xmqqmsc4uv6d.fsf@gitster.g> <aA8ymUzWM2t0QkFP@pks.im>
	<xmqq8qnkdxu9.fsf@gitster.g> <aBDD-NeN2YoQbU9S@pks.im>
Date: Tue, 29 Apr 2025 13:48:18 -0700
Message-ID: <xmqqplgu4ru5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> @@ -213,6 +228,8 @@ int cmd_mv(int argc,
>  	struct cache_entry *ce;
>  	struct string_list only_match_skip_worktree = STRING_LIST_INIT_DUP;
>  	struct string_list dirty_paths = STRING_LIST_INIT_DUP;
> +	struct hashmap moved_dirs = HASHMAP_INIT(pathmap_cmp, NULL);
> +	struct strbuf pathbuf = STRBUF_INIT;
>  	int ret;
>  
>  	git_config(git_default_config, NULL);
> @@ -331,11 +348,17 @@ int cmd_mv(int argc,
>  
>  dir_check:
>  		if (S_ISDIR(st.st_mode)) {
> +			struct pathmap_entry *entry;
>  			char *dst_with_slash;
>  			size_t dst_with_slash_len;
>  			int j, n;
>  			int first = index_name_pos(the_repository->index, src, length), last;
>  
> +			entry = xmalloc(sizeof(*entry));
> +			entry->path = src;
> +			hashmap_entry_init(&entry->ent, fspathhash(src));
> +			hashmap_add(&moved_dirs, &entry->ent);
> +

OK, this collects in moved_dirs the directories that will get moved.
And then a separate loop, ...

> +	for (i = 0; i < argc; i++) {
> +		const char *slash_pos;
> +
> +		strbuf_addstr(&pathbuf, sources.v[i]);

Shouldn't there be a call to strbuf_reset(&pathbuf) before doing
this?

> +		slash_pos = strrchr(pathbuf.buf, '/');

And start from the deepest directory, going one level up per
iteration, ...

> +		while (slash_pos > pathbuf.buf) {
> +			struct pathmap_entry needle;
> +
> +			strbuf_setlen(&pathbuf, slash_pos - pathbuf.buf);
> +
> +			needle.path = pathbuf.buf;
> +			hashmap_entry_init(&needle.ent, fspathhash(pathbuf.buf));

... see if the path being moved falls within that subdirectory.

> +			if (!hashmap_get_entry(&moved_dirs, &needle, ent, NULL))
> +				continue;

If there is no overlap, we need to do anything special.

> +			if (!ignore_errors)
> +				die(_("cannot move both parent directory '%s' and its child '%s'"),
> +				    pathbuf.buf, sources.v[i]);

Otherwise we are in trouble.

> +			if (--argc > 0) {
> +				int n = argc - i;
> +				strvec_remove(&sources, i);
> +				strvec_remove(&destinations, i);
> +				MOVE_ARRAY(modes + i, modes + i + 1, n);
> +				MOVE_ARRAY(submodule_gitfiles + i,
> +					   submodule_gitfiles + i + 1, n);
> +				i--;
> +				break;
> +			}

So with

	$ git mv a/ a/b x y z/

then a/ is left in the argv[]/sources[]/destinations[] arrays, and
upon inspecting a/b, we come here and in order to ignore a/b, we
shift it out; the resulting arrays would have a/, x, and y being
moved to z/.

It somehow feels troubling that it would lead to a different result
if I give a morally equivalent arguments, i.e.

	$ git mv a/b a/ x y z/

where a/b survives and a/ gets omitted.

One thing that came to my mind (without concrete "here is the right
way to solve it" that I am myself convinced) is this.

 * Should this code path even have its own ignore-errors handling?
   "git mv a b z/", when 'a' does not exist, may ignore 'a' and move
   only 'b', which may make sense.  But the original command line in
   that case is a plausibly correct one if there weren't missing or
   unmovable paths.  The command line "git mv a/ a/b z/" seems to
   fall into a different category (aka "total nonsense"); no matter
   how you fix the items in your working tree files, you cannot make
   it plausibly correct.


a totally unrelated tangent that made me scratch my head while
reading the original ocde is the dest_paths variable.  It is never
used as a collection to hold potentially multiple paths; it is a
strvec only to be able to call internel_prefix_pathspec() with, and
used only once with only one element in the vector.  At least it
should lose the plural 's' suffix to unconfuse its readers, I would
think.
