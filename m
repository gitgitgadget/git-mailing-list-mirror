Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F90B157A7D
	for <git@vger.kernel.org>; Mon, 15 Apr 2024 22:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713221480; cv=none; b=iGvdFuDVAW43TEpd5gXNjav7Xk87rK2HVkbkQshKiSa2eECNbbWgS63UZF2IavE5cqKI6tcSfWa4uombof9QyxnLMQhvbk+GSQGmaldEU6Z2KTN71pCGXYKJPj5evwvVv+q6vMAnaO0qxRLcdh4fOFCuUmX0atRdYu/Kp8ynyu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713221480; c=relaxed/simple;
	bh=zWGFqrm1l0cPZvOalVR5PZjfyjKeXtce6oqZCR1/mCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4fH+FIIQE3S/Jhj6Dn4Qw783FJ8exa2geI9p+zjxBgAC57mqaIvGEDmAZjUn5HWWzHcsslKYDMRouI7MoqiDJ4jzeRJumEbsBPtzqEhCCJLSC96A6291thwHxLw740DOA8fFTn3TBbIhtilSZrpkx2Es4eijO06i5IJDa427Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=IUHGBP7P; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="IUHGBP7P"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-61ad5f2c231so16425847b3.2
        for <git@vger.kernel.org>; Mon, 15 Apr 2024 15:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1713221478; x=1713826278; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lY+2DmtghyG2FGxNDBn8JA8FesBjGn5Uy2DXrz8uVo=;
        b=IUHGBP7PkyohvLFhWFaQVxOJxTXbkRrCBUnZsyVWI//BQS6XBKZNIDPQ92tLXnzBSu
         wgsW3j0xpLok7Sug802ugZa0i+rxJyxMkK2EAFHupqA+FGQnJXCVzmu0yAlFMucOHHUR
         tH7eLd+Cw6FuU2tZ7Ls/y3tf8d8oBtwbCbnB4fL8MdIURvFxEab2wr9K0gmeuIylMUNd
         8yK7PG7vBGwrXWhZAr9LW3C+xzKMK4cwecDckZYjpxrcAq5usLIZIpzB23S9SOHle7i7
         wu2r1BWlq59GlfGmgt93ziWudLDXtgKrxvppS+id+QQ1qBcxh7ILyA1gN1vTe1aQkK8n
         pQig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713221478; x=1713826278;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lY+2DmtghyG2FGxNDBn8JA8FesBjGn5Uy2DXrz8uVo=;
        b=wbxzxaZ9zNdpcVXjPcxN9SfdTZrkFqxCyjtNmVrbAGOT6wiQB0sn16c5uII347tqLK
         zTZeRMmPDRgvjLDAK135K+D2UGKCsDYIsgZpa80N6dpykm17HmYFZ6DiHw/jFk17JQ+z
         e7P8q6MkEjdB0NbB0IBup0d6VEUHqLbiFo+Ixm7EmycdIfHfab71+5Yh72xFORmfkV/1
         mlscKiZ/duyZa5Kg409mbXCgvywIpMhjj7/aciG3jSbJNmKb4KPY6NDfrvuC7wQVO9Nu
         TwDFQq0j9b22biViO1dTtCnNUPLB/4z8A6NESIdf1Bgz+Vyj8eUjYwYFxYophLeulhgh
         asgA==
X-Gm-Message-State: AOJu0YyjlSba/YrlBkGdqHycAogCKajPgZ+bi9CkVa5PwQiCFOS9SOkM
	r6G+QwrI0Akls/olDAAYoAk8Snagip7XgvaVZpWKJMaURDxdWwhNJoiNpc9kJb4qH+6VPE//D9W
	Xmxs=
X-Google-Smtp-Source: AGHT+IG1m5J7DAyfKimSvdQhFfctfl+TZekrP1OstUpStdtomAZPJqsi/YLbhFpRtG8oDPzH4Bj7pg==
X-Received: by 2002:a81:7344:0:b0:60a:17a2:5627 with SMTP id o65-20020a817344000000b0060a17a25627mr10173597ywc.50.1713221478100;
        Mon, 15 Apr 2024 15:51:18 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r13-20020a81e40d000000b006088f2afc2dsm2262632ywl.87.2024.04.15.15.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 15:51:17 -0700 (PDT)
Date: Mon, 15 Apr 2024 18:51:16 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <Zh2vZB/60QlLYjUZ@nand.local>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
 <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>

On Mon, Apr 15, 2024 at 08:41:25AM +0200, Patrick Steinhardt wrote:
> diff --git a/midx.c b/midx.c
> index ae3b49166c..6f07de3688 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -170,9 +170,10 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
>
>  	pair_chunk(cf, MIDX_CHUNKID_LARGEOFFSETS, &m->chunk_large_offsets,
>  		   &m->chunk_large_offsets_len);
> -	pair_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
> -		   (const unsigned char **)&m->chunk_bitmapped_packs,
> -		   &m->chunk_bitmapped_packs_len);
> +	if (git_env_bool("GIT_TEST_MIDX_READ_BTMP", 1))
> +		pair_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
> +			   (const unsigned char **)&m->chunk_bitmapped_packs,
> +			   &m->chunk_bitmapped_packs_len);

OK, so we're switching to a new GIT_TEST_-variable here, which controls
whether or not we read the BTMP chunk. That makes sense, and is much
appreciated :-).

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 2baeabacee..35c5ef9d3c 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2049,7 +2049,10 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>
>  	load_reverse_index(r, bitmap_git);
>
> -	if (bitmap_is_midx(bitmap_git)) {
> +	if (!bitmap_is_midx(bitmap_git) || !bitmap_git->midx->chunk_bitmapped_packs)
> +		multi_pack_reuse = 0;
> +

Either we don't have a MIDX, or we do, but it doesn't have a BTMP chunk.
In either case, we should disable multi-pack reuse (either using the
single pack corresponding with a classic pack-bitmap, or the preferred
pack if using a MIDX bitamp written prior to the BTMP chunk).

Looking good.

> +	if (multi_pack_reuse) {
>  		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
>  			struct bitmapped_pack pack;
>  			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
> @@ -2062,34 +2065,32 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>  			if (!pack.bitmap_nr)
>  				continue;
>
> -			if (!multi_pack_reuse && pack.bitmap_pos) {
> -				/*
> -				 * If we're only reusing a single pack, skip
> -				 * over any packs which are not positioned at
> -				 * the beginning of the MIDX bitmap.
> -				 *
> -				 * This is consistent with the existing
> -				 * single-pack reuse behavior, which only reuses
> -				 * parts of the MIDX's preferred pack.
> -				 */
> -				continue;
> -			}

Yep, this hunk can go since it used to belong to the outer if-statement
in the pre-image that was conditioned on 'bitmap_is_midx()'. This is
dealt with separately, since we know ahead of time we're doing
multi-pack reuse (and can do so).
> -
>  			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
>  			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
>
>  			objects_nr += pack.p->num_objects;
> -
> -			if (!multi_pack_reuse)
> -				break;
>  		}
>
>  		QSORT(packs, packs_nr, bitmapped_pack_cmp);
>  	} else {
> +		struct packed_git *pack;
> +
> +		if (bitmap_is_midx(bitmap_git)) {
> +			uint32_t preferred_pack_pos;
> +
> +			if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
> +				warning(_("unable to compute preferred pack, disabling pack-reuse"));
> +				return;
> +			}
> +
> +			pack = bitmap_git->midx->packs[preferred_pack_pos];
> +		} else {
> +			pack = bitmap_git->pack;
> +		}
> +

Looking good. Here we're doing single-pack reuse (either from the pack
corresponding with the bitmap or the MIDX's preferred pack). Either way
we set the 'pack' variable to point at the appropriate pack, and then
add that pack to the list of reusable packs below. Good.

>  		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> -
> -		packs[packs_nr].p = bitmap_git->pack;
> -		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
> +		packs[packs_nr].p = pack;
> +		packs[packs_nr].bitmap_nr = pack->num_objects;
>  		packs[packs_nr].bitmap_pos = 0;
>
>  		objects_nr = packs[packs_nr++].bitmap_nr;

Makes sense.

> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index 70d1b58709..5d7d321840 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -513,4 +513,21 @@ test_expect_success 'corrupt MIDX with bitmap causes fallback' '
>  	)
>  '
>
> +for allow_pack_reuse in single multi
> +do
> +	test_expect_success "reading MIDX without BTMP chunk does not complain with $allow_pack_reuse pack reuse" '
> +		test_when_finished "rm -rf midx-without-btmp" &&
> +		git init midx-without-btmp &&
> +		(
> +			cd midx-without-btmp &&
> +			test_commit initial &&
> +
> +			git repack -Adbl --write-bitmap-index --write-midx &&

`-b` is redundant with `--write-bitmap-index`.

> +			GIT_TEST_MIDX_READ_BTMP=false git -c pack.allowPackReuse=$allow_pack_reuse \
> +				pack-objects --all --use-bitmap-index --stdout </dev/null >/dev/null 2>err &&

A small note here, but setting stdin to read from /dev/null is
unnecessary with `--all.`

> +			test_must_be_empty err
> +		)
> +	'
> +done
> +

This test looks like it's exercising the right thing, but I'm not sure
why it was split into two separate tests. Perhaps to allow the two to
fail separately?

Either way, the repository initialization, test_commit, and repacking
could probably be combined into a single step to avoid re-running them
for different values of $allow_pack_reuse.

I would probably have written:

    git init midx-without-btmp &&
    (
        cd midx-without-btmp &&

        test_commit base &&
        git repack -adb --write-midx &&

        for c in single multi
        do
            GIT_TEST_MIDX_READ_BTMP=false git -c pack.allowPackReuse=$c pack-objects \
              --all --use-bitmap-index --stdout >/dev/null 2>err &&
            test_must_be_empty err || return 1
        done
    )

TBH, I would like to see this test cleaned up before merging this one
down. But otherwise this patch is looking good.

Thanks,
Taylor
