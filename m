Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCD313D503
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 00:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765326136; cv=none; b=PN3gdDqb7pvHE+qo5kOtwThJekuhEuVDAAbxu31o33lf5x1YpSaoKYmDJ1EOIHwAUFOdvSVF+lFeO+hxx+k2OEiZpNs8W7SRhOewLzYl7E+yJxx2KQAi67GKFUPtGVoYLldp/iabCNqQwRl52KusmrVWx3JaYp7MtP4DJu14gF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765326136; c=relaxed/simple;
	bh=r9Mvp3jzbDeqZJN01xuh71tbqwDHsiJHitU1PLSP/E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPmNO3PyPLd4QdVdZOOpZoD08a3ndeatMcDsYGYiYv7bW0NgfGtZRdA7PjAFng1LRis9p61fx3QTl8LIqShNRrUZxYUL+EjcqF1unvdjjLogPj1EbEWrQt8o7j0d66krewV3Cy07FhXip8XeFaVKRMAbHvhVScdma5bmjCdNMr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=UJCsy00/; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="UJCsy00/"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6420c08f886so7775077d50.3
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 16:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1765326133; x=1765930933; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WJog0AaZzs8n8ARXYSr7UN2/AIRU+CjTNeMSQtmFgyg=;
        b=UJCsy00/hohnmoiWaIAEMo5KFYX076k6HLfsP9DiKGFaH1GUOAhj+D41Oapo56oqP5
         TGJiYsmuLhKDPcfa5spWu4ldrPopUY6L0yP7d/ZkWcc3beKLhYwOk8EZL4HmSFFb5uHl
         0wykV/DZNvCozrwf5G5c07YXHV4dSIQsaDiB35KJFIUq/fDjtJ/rgT2t3ZAKtDXi6YBJ
         K299oV5E+f3gG2TzzShmUUIrj2qifB+uOml9GzvIrdNrKcCP1M2DVZz8Lot5AqUXIpjX
         KzZaO6QPwjV+MsxUBywH5dQbhieDS/JMBrQjl3xRq7nlPKetC7WzpeYKPnPuUlMttsNa
         3UrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765326133; x=1765930933;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WJog0AaZzs8n8ARXYSr7UN2/AIRU+CjTNeMSQtmFgyg=;
        b=pAptuhVgF7MGajxrHnoLrzGGFKgEDH3z6m+zOf1oRYyAilWuoKEBOVz08UR/h20EF9
         Jfu26CEoYxpkI+G/dx9nwWfaBBhYkVYbqrIlCkRxjpBaiPwdeDfZEHq+DHeVj79m23Dy
         CGGw3CoDBzfnN86u8l0XK9oV6ShcyZsjXBcbcvAj0CivT9TPSDdDzUXWy3om8njvg9oe
         g4PBFzD5MdNVHzq6PHxblJyrPu6c9jIdJPynYJyMCWwnQNGCmbPZsNl+Oz/FciyBNA3h
         9x1rcV2QtM3UMA/0oWf2ozw09tyS5meiKcnS2c74B7jrJyMXB4rGGrXygNpYVpKTgfkP
         Uhzw==
X-Gm-Message-State: AOJu0YzEK9/kBWgCpcOIPRFy3JV7q5IDgdVsdDj1Ig6C1whAsv0f30zd
	sNI9q7q/Zj5D2vkSciwGLKbWLg7VEvChMfsKxyAAAiigDwv9+SK5uIi5MsLi/Jyy7dnsj7xwhV5
	XUqjpc1E=
X-Gm-Gg: AY/fxX5gs2NjkIxDsTkk3Bv6Ek5bb9+FDpSRm7pr3S5qOkxazIZqJSw68cNhrQKrTUh
	F8tcsCEOM1z0xCq6+qMpLaR/ht6FEs7sU22VuNGBPN5TMQ7B9F3eQclvdLpkEcFLfya9qFxq8kO
	x63te+/gnQJrmZSbyxyZ30kAKCZEaKO+p0pW24TsizrSBb4bmNvYwthv+Fznv2xYT3gJxB6ptbv
	hkYCPZBQfdnEE9u4z6XOiG8cm72QGZzbdE79oLOhNrKDfNzzdDVYfZBKyT6x3WL9Zh0icVXALIJ
	uLj/+G+COPsreMG00sg/2tmdOrgVwhiIvh6DX9wWbinvi3H2Ey/l6mI1MwTkYGhEKzdhIx1X8PH
	c7ytz40C06CIrPv/Iyy16Dl4YHUdJpRWEVlFguh9i/u0z2bTlVS0DMZRKAaTbpNn8UY9P6ILyRc
	y9Lj9k96DRPW40FHv7lkzDNY3LmuRlvLSgYlp9vS31Ogdy3IN5HxK+/SRVEq0t82Tny58Yzrfmf
	flmH8Dipqhu1d6m5zYha9v+xAyB
X-Google-Smtp-Source: AGHT+IGTfwKSFIabQk4J9xO8L7vlVmOje9eo1LE6jjTTReD1PbRIdTwY+47JVHlitmKPhTnu6D0zUg==
X-Received: by 2002:a05:690e:259c:b0:641:718:8a28 with SMTP id 956f58d0204a3-6446eacd564mr507186d50.40.1765326132554;
        Tue, 09 Dec 2025 16:22:12 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78c1b4d0da7sm64681257b3.19.2025.12.09.16.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 16:22:12 -0800 (PST)
Date: Tue, 9 Dec 2025 19:22:11 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] midx: fix `BUG()` when getting preferred pack
 without a reverse index
Message-ID: <aTi9M/F0sZzK/usA@nand.local>
References: <20251208-pks-skip-noop-rewrite-v1-0-430d52dba9f0@pks.im>
 <20251208-pks-skip-noop-rewrite-v1-1-430d52dba9f0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251208-pks-skip-noop-rewrite-v1-1-430d52dba9f0@pks.im>

On Mon, Dec 08, 2025 at 07:27:14PM +0100, Patrick Steinhardt wrote:
> The function `midx_preferred_pack()` returns the preferred pack for a
> given multi-pack index. To compute the preferred pack we:
>
>   1. Look up the position of the first object indexed by the multi-pack
>      index.
>
>   2. Convert this position from pseudo-pack order into MIDX order.
>
>   3. We then look up pack that corresponds to this MIDX index.

I think the implementation of midx_preferred_pack() works a little bit
differently than is described here. I often get confused when working in
this area juggling between the various object/pack orderings in my head.

midx_preferred_pack() cares about converting from the first position in
pseudo-pack order back into MIDX object order. To do that, we convert
the pseudo-pack position into a MIDX one, and then lookup the pack that
represents that object.

Effectively we're doing something like:

    uint32_t pseudo_pack_pos = m->num_objects_in_base;
    uint32_t midx_pos = pack_pos_to_midx(m, pseudo_pack_pos);
    uint32_t pack_int_id = nth_midxed_pack_int_id(m, midx_pos);

> This reliably returns the preferred pack given that all of its contained
> objects will be up front in pseudo-pack order.
>
> The second step that turns the pseudo-pack order into MIDX order
> requires the reverse index though, which may not exist for example when
> the MIDX does not have a bitmap. And in that case one may easily hit a
> bug:
>
>     BUG: ../pack-revindex.c:491: pack_pos_to_midx: reverse index not yet loaded

That makes sense, we can't convert a pseudo-pack position into a
MIDX-relative position without a reverse index to tell us where that bit
goes.

> In theory, `midx_preferred_pack()` already knows to handle the case
> where no reverse index exists, as it calls `load_midx_revindex()` before
> calling into `midx_preferred_pack()`. [...]

Right, it handles this case by returning -1 to indicate that it didn't
have enough information to determine the preferred pack.

> [...] But we only check for negative
> return values there, even though the function returns a positive error
> code in case the reverse index does not exist.

Ah. It looks like that was changed in 5a6072f631d (fsck: validate .rev
file header, 2023-04-17), but it looks like the caller here did not
learn about that change. It may be worth mentioning that commit in your
patch message.

While reviewing, I wanted to make sure that there weren't any other
callers of load_midx_revindex() that were also missing this check. The
return value of that function is propagated through the two expected
functions:

    $ git grep -p load_revindex_from_disk
    pack-revindex.c=struct revindex_header {
    pack-revindex.c:static int load_revindex_from_disk(const struct git_hash_algo *algo,
    pack-revindex.c=int load_pack_revindex_from_disk(struct packed_git *p)
    pack-revindex.c:        ret = load_revindex_from_disk(p->repo->hash_algo,
    pack-revindex.c=int load_midx_revindex(struct multi_pack_index *m)
    pack-revindex.c:        ret = load_revindex_from_disk(m->source->odb->repo->hash_algo,

, and checking through the callers of those two functions, all are
prepared to handle a >0 return value.

> diff --git a/midx.c b/midx.c
> index 24e1e72175..b681b18fc1 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -686,7 +686,7 @@ int midx_preferred_pack(struct multi_pack_index *m, uint32_t *pack_int_id)
>  {
>  	if (m->preferred_pack_idx == -1) {
>  		uint32_t midx_pos;
> -		if (load_midx_revindex(m) < 0) {
> +		if (load_midx_revindex(m)) {
>  			m->preferred_pack_idx = -2;
>  			return -1;
>  		}
> diff --git a/pack-revindex.h b/pack-revindex.h
> index 422c2487ae..0042892091 100644
> --- a/pack-revindex.h
> +++ b/pack-revindex.h
> @@ -72,7 +72,8 @@ int verify_pack_revindex(struct packed_git *p);
>   * multi-pack index by mmap-ing it and assigning pointers in the
>   * multi_pack_index to point at it.
>   *
> - * A negative number is returned on error.
> + * A negative number is returned on error. A positive number is returned in
> + * case the multi-pack-index does not have a reverse index.

Makes sense.

> diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
> index 93f319a4b2..9492a9737b 100755
> --- a/t/t5319-multi-pack-index.sh
> +++ b/t/t5319-multi-pack-index.sh
> @@ -350,7 +350,20 @@ test_expect_success 'preferred pack from existing MIDX without bitmaps' '
>  		# the new MIDX
>  		git multi-pack-index write --preferred-pack=pack-$pack.pack
>  	)
> +'
>
> +test_expect_success 'preferred pack cannot be determined without bitmap' '
> +	test_when_finished "rm -fr preferred-can-be-queried" &&
> +	git init preferred-can-be-queried &&
> +	(
> +		cd preferred-can-be-queried &&
> +		test_commit initial &&
> +		git repack -Adl --write-midx --no-write-bitmap-index &&
> +		test_must_fail test-tool read-midx --preferred-pack .git/objects 2>err &&
> +		test_grep "could not determine MIDX preferred pack" err &&

Looks good. I think that it's fine to end the test here, since we have
extensive coverage that we can determine the preferred pack when there
is a MIDX and matching bitmap, but I definitely don't feel strongly
about it.

Thanks,
Taylor
