Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1347916C877
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761338; cv=none; b=t4Eu7ZVdJDV3iZhn6HXue9hMTuJwUJ9+9qJstThHCcIG0ho+aKFCyp23XmOkAU/Sxt+TUwM56Rfqp3OGw9gVErbL9fP171gDSzY2XcdyDH5C4xX0ZfScjS4zAB6bY8psz6IeoGkzhUHyD7Nl51yjp7VK9DAL9UScVnH2AXYEvio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761338; c=relaxed/simple;
	bh=cCeM0P22eA60O/ihk6r9bHAAajBDwLwgzdBxcfPvcs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgR36wU1a3K0f+dmth4aQruIiyg4vTIx/Ohs1bnnODYCS/BJBXm0aLZ/Eaz+vVyj10Weli0KFQjaKlQiwC90SrIeMLhzRq5MMYxurElKE/V+LLpE8OYIugyWWek3Sgq7BBFZ0HUUbd4255P9Jo6FHBlo+R2nfyYMPtjEtTqYED4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=VcCsUgDT; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="VcCsUgDT"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-434d0a63151so15299711cf.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2024 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712761335; x=1713366135; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjZaEYMjhh+gS4eoYIKyUU9TYOgjIOO5dGsQFMustwo=;
        b=VcCsUgDTpHwO+QPzFacJrsYyxy66JXfnU66QQGHDsv7ZcTTQ646gR6GqCn70AKqLJ1
         mZHuAglBSfsRZuJMG8pR4EjoLBZ0doXESeU8XuOeSjky/l2hPXuu90BXUK+s5yLgL/9o
         bfSJ2yZ3D0ilIHsx5w/Ho0/Ve2Y8vVkKwOe/UofHrtPw2RCAeoSdGNVf8GWeMepmIUEV
         WTnVpbRqriGISpgF7GtyUELdKgzvDrF58iRqJLorqMZNvx8/uiNDTWHa8lK3xg4EdaQK
         IbctMuaDk9AG2cCQGoxI3O7DF7xxxFv1dTtongp25uJpgI4vKn05kOwFLP7xezKxfaY1
         y0Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712761335; x=1713366135;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjZaEYMjhh+gS4eoYIKyUU9TYOgjIOO5dGsQFMustwo=;
        b=rFK4OFXchpqgvO4b//kXRsFKhsMNquPdMqBUtngX2wBreNdjSK2RbrHqhJzkHdkObb
         HmSft0AmFTBP/xhRiioyvUPgdht3TJMB6erSU8wIOVwIv3ekmwsVs5xksoi1SopoUq17
         9TzZBdLimj5gcPE9IGr3XwMvb4/PobmpGerMrcCS3xdRE1nQ29N4KDl+M9ZzuJKdDphC
         6zjRMnKrAYpSrjTu/6bpWrMyI959vmbBGA6XrwklzvXG/pQvqbWGMpckan1NUkJqnFNi
         3cRrtPSZFvvAvMbxLR9xtvq+5BoInr/ZInylQ6Ml6Ix1AVDz7M+IeK8xfLCpX5RS/bto
         XZmg==
X-Gm-Message-State: AOJu0YxNP2fV7WhPnGraXolN7gxZ6WfC/H784pTqYhXlnCEorDsvGscK
	puyUMMhS1tDaYGMkcCI2zCADYlK/v2mJN7uejg9nLHTmutnTxjbSgrW+7V4ZmuKr7D81JU5LMpe
	q9Yo=
X-Google-Smtp-Source: AGHT+IE9LBe3vVelSn+RNlYyVv+QmhC8v21ytJc4wmm134Yw1mkyk8Gd8hngRmpFffHZ6joiScynEg==
X-Received: by 2002:ac8:7fc8:0:b0:434:a317:2df4 with SMTP id b8-20020ac87fc8000000b00434a3172df4mr2926206qtk.25.1712761334643;
        Wed, 10 Apr 2024 08:02:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i9-20020ac860c9000000b00434a352e239sm3150162qtm.43.2024.04.10.08.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 08:02:13 -0700 (PDT)
Date: Wed, 10 Apr 2024 11:02:10 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <Zhap8iyMYytCM+on@nand.local>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>

On Tue, Apr 09, 2024 at 07:59:25AM +0200, Patrick Steinhardt wrote:
> One thing that we glossed over though is backwards compatibility with
> repositories that do not yet have BTMP chunks in their multi-pack index.
> In that case, `nth_bitmapped_pack()` would return an error, which causes
> us to emit a warning followed by another error message. These warnings
> are visible to users that fetch from a repository:
>
> ```
> $ git fetch
> ...
> remote: error: MIDX does not contain the BTMP chunk
> remote: warning: unable to load pack: 'pack-f6bb7bd71d345ea9fe604b60cab9ba9ece54ffbe.idx', disabling pack-reuse
> remote: Enumerating objects: 40, done.
> remote: Counting objects: 100% (40/40), done.
> remote: Compressing objects: 100% (39/39), done.
> remote: Total 40 (delta 5), reused 0 (delta 0), pack-reused 0 (from 0)
> ...
> ```

Nice catch. This is definitely an oversight from my original series,
which should not disrupt single-pack reuse from the MIDX's preferred
pack when using a MIDX/bitmap written prior to the introduction of the
BTMP chunk.

> Fix this issue by partially reverting the logic back to what we had
> before this patch series landed. Namely, in the case where we have no
> BTMP chunks or when `pack.allowPackReuse=single` are set, we use the
> preferred pack instead of consulting the BTMP chunks.

I think that the approach here makes sense to me. The gist is:

- If we don't have a BTMP chunk, then only reuse objects from the
  preferred pack.

- Otherwise, we do have a BTMP chunk (or we're not doing multi-pack
  reuse). If we are reusing objects from multiple packs, then do the
  usual MIDX reuse routines.

- Otherwise, we're doing single-pack reuse. In that case, only reuse
  objects from the preferred pack.

> diff --git a/midx.c b/midx.c
> index 41521e019c..6903e9dfd2 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1661,9 +1661,10 @@ static int write_midx_internal(const char *object_dir,
>  		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
>  			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
>  			  write_midx_revindex);
> -		add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
> -			  bitmapped_packs_concat_len,
> -			  write_midx_bitmapped_packs);
> +		if (git_env_bool("GIT_TEST_MIDX_WRITE_BTMP", 1))
> +			add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
> +				  bitmapped_packs_concat_len,
> +				  write_midx_bitmapped_packs);

I wish that this were possible to exercise without a new
GIT_TEST_-variable. I think there are a couple of alternatives:

You could introduce a new GIT_TEST_MIDX_READ_BTMP variable, and then set
that to control whether or not we read the BTMP chunk. This is what we
did in:

  - 28cd730680d (pack-bitmap: prepare to read lookup table extension,
    2022-08-14), as well as in

  - 7f514b7a5e7 (midx: read `RIDX` chunk when present, 2022-01-25)

. I have a vague preference towards controlling whether or not we read
the BTMP chunk (as opposed to whether or not we write it) as this
removes a potential footgun for users who might accidentally disable
writing a BTMP chunk (in which case you have to rewrite the whole MIDX)
as opposed to reading it (in which case you just change your environment
variable).

Of course, that is still using a GIT_TEST_-variable, which is less than
ideal IMHO. The other alternative would be to store a MIDX file as a
test fixture in the tree (which we do in a couple of places). But with
the recent xz shenanigans, I'm not sure that's a great idea either ;-).

> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 2baeabacee..f286805724 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -2049,7 +2049,25 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>
>  	load_reverse_index(r, bitmap_git);
>
> -	if (bitmap_is_midx(bitmap_git)) {
> +	if (bitmap_is_midx(bitmap_git) &&
> +	    (!multi_pack_reuse || !bitmap_git->midx->chunk_bitmapped_packs)) {
> +		uint32_t preferred_pack_pos;
> +		struct packed_git *pack;
> +
> +		if (midx_preferred_pack(bitmap_git->midx, &preferred_pack_pos) < 0) {
> +			warning(_("unable to compute preferred pack, disabling pack-reuse"));
> +			return;
> +		}
> +
> +		pack = bitmap_git->midx->packs[preferred_pack_pos];
> +
> +		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> +		packs[packs_nr].p = pack;
> +		packs[packs_nr].bitmap_nr = pack->num_objects;
> +		packs[packs_nr].bitmap_pos = 0;
> +
> +		objects_nr = packs[packs_nr++].bitmap_nr;
> +	} else if (bitmap_is_midx(bitmap_git)) {
>  		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
>  			struct bitmapped_pack pack;
>  			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {

This all makes sense to me. I think we could make the result slightly
more readable by handling the case where we're doing multi-pack reuse
separately from the case where we're not.

I tried to make that change locally to see if it was a good idea, and
I'm reasonably happy with the result. I can't think of a great way to
talk about it without just showing the resulting patch (as the
inter-diff is fairly difficult to read IMHO). So here is the resulting
patch (forging your s-o-b):

--- 8< ---
Subject: [PATCH] pack-bitmap: gracefully handle missing BTMP chunks

In 0fea6b73f1 (Merge branch 'tb/multi-pack-verbatim-reuse', 2024-01-12)
we have introduced multi-pack verbatim reuse of objects. This series has
introduced a new BTMP chunk, which encodes information about bitmapped
objects in the multi-pack index. Starting with dab60934e3 (pack-bitmap:
pass `bitmapped_pack` struct to pack-reuse functions, 2023-12-14) we use
this information to figure out objects which we can reuse from each of
the packfiles.

One thing that we glossed over though is backwards compatibility with
repositories that do not yet have BTMP chunks in their multi-pack index.
In that case, `nth_bitmapped_pack()` would return an error, which causes
us to emit a warning followed by another error message. These warnings
are visible to users that fetch from a repository:

```
$ git fetch
...
remote: error: MIDX does not contain the BTMP chunk
remote: warning: unable to load pack: 'pack-f6bb7bd71d345ea9fe604b60cab9ba9ece54ffbe.idx', disabling pack-reuse
remote: Enumerating objects: 40, done.
remote: Counting objects: 100% (40/40), done.
remote: Compressing objects: 100% (39/39), done.
remote: Total 40 (delta 5), reused 0 (delta 0), pack-reused 0 (from 0)
...
```

While the fetch succeeds the user is left wondering what they did wrong.
Furthermore, as visible both from the warning and from the reuse stats,
pack-reuse is completely disabled in such repositories.

What is quite interesting is that this issue can even be triggered in
case `pack.allowPackReuse=single` is set, which is the default value.
One could have expected that in this case we fall back to the old logic,
which is to use the preferred packfile without consulting BTMP chunks at
all. But either we fail with the above error in case they are missing,
or we use the first pack in the multi-pack-index. The former case
disables pack-reuse altogether, whereas the latter case may result in
reusing objects from a suboptimal packfile.

Fix this issue by partially reverting the logic back to what we had
before this patch series landed. Namely, in the case where we have no
BTMP chunks or when `pack.allowPackReuse=single` are set, we use the
preferred pack instead of consulting the BTMP chunks.

Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                        |  7 +++---
 pack-bitmap.c                 | 44 +++++++++++++++++++----------------
 t/t5326-multi-pack-bitmaps.sh | 22 ++++++++++++++++++
 3 files changed, 50 insertions(+), 23 deletions(-)

diff --git a/midx.c b/midx.c
index 41521e019c6..6903e9dfd25 100644
--- a/midx.c
+++ b/midx.c
@@ -1661,9 +1661,10 @@ static int write_midx_internal(const char *object_dir,
 		add_chunk(cf, MIDX_CHUNKID_REVINDEX,
 			  st_mult(ctx.entries_nr, sizeof(uint32_t)),
 			  write_midx_revindex);
-		add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
-			  bitmapped_packs_concat_len,
-			  write_midx_bitmapped_packs);
+		if (git_env_bool("GIT_TEST_MIDX_WRITE_BTMP", 1))
+			add_chunk(cf, MIDX_CHUNKID_BITMAPPEDPACKS,
+				  bitmapped_packs_concat_len,
+				  write_midx_bitmapped_packs);
 	}

 	write_midx_header(f, get_num_chunks(cf), ctx.nr - dropped_packs);
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2baeabacee1..44b32ee3561 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -2049,7 +2049,14 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,

 	load_reverse_index(r, bitmap_git);

-	if (bitmap_is_midx(bitmap_git)) {
+	if (!bitmap_is_midx(bitmap_git) ||
+	    !bitmap_git->midx->chunk_bitmapped_packs)
+		multi_pack_reuse = 0;
+
+	if (multi_pack_reuse) {
+		if (!bitmap_is_midx(bitmap_git))
+			BUG("attempting to perform multi-pack reuse on non-MIDX bitmap");
+
 		for (i = 0; i < bitmap_git->midx->num_packs; i++) {
 			struct bitmapped_pack pack;
 			if (nth_bitmapped_pack(r, bitmap_git->midx, &pack, i) < 0) {
@@ -2062,36 +2069,33 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
 			if (!pack.bitmap_nr)
 				continue;

-			if (!multi_pack_reuse && pack.bitmap_pos) {
-				/*
-				 * If we're only reusing a single pack, skip
-				 * over any packs which are not positioned at
-				 * the beginning of the MIDX bitmap.
-				 *
-				 * This is consistent with the existing
-				 * single-pack reuse behavior, which only reuses
-				 * parts of the MIDX's preferred pack.
-				 */
-				continue;
-			}
-
 			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
 			memcpy(&packs[packs_nr++], &pack, sizeof(pack));

 			objects_nr += pack.p->num_objects;
-
-			if (!multi_pack_reuse)
-				break;
 		}

 		QSORT(packs, packs_nr, bitmapped_pack_cmp);
 	} else {
+		struct packed_git *pack;
+		if (bitmap_is_midx(bitmap_git)) {
+			uint32_t pack_int_id;
+			if (midx_preferred_pack(bitmap_git->midx, &pack_int_id) < 0) {
+				warning(_("unable to compute preferred pack, "
+					  "disabling pack-reuse"));
+				return;
+			}
+
+			pack = bitmap_git->midx->packs[pack_int_id];
+		} else {
+			pack = bitmap_git->pack;
+		}
+
 		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);

-		packs[packs_nr].p = bitmap_git->pack;
-		packs[packs_nr].bitmap_nr = bitmap_git->pack->num_objects;
+		packs[packs_nr].p = pack;
+		packs[packs_nr].bitmap_nr = pack->num_objects;
 		packs[packs_nr].bitmap_pos = 0;
-
 		objects_nr = packs[packs_nr++].bitmap_nr;
 	}

diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 70d1b58709a..ee3843b2390 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -513,4 +513,26 @@ test_expect_success 'corrupt MIDX with bitmap causes fallback' '
 	)
 '

+for allow_pack_reuse in single multi
+do
+	test_expect_success "MIDX without BTMP chunk does not complain with $allow_pack_reuse pack reuse" '
+		test_when_finished "rm -rf midx-without-btmp" &&
+		git init midx-without-btmp &&
+		(
+			cd midx-without-btmp &&
+			test_commit initial &&
+
+			# Write a multi-pack index that does have a bitmap, but
+			# no BTMP chunk. Such MIDX files would not be generated
+			# by modern Git anymore, but they were generated by
+			# older Git versions.
+			GIT_TEST_MIDX_WRITE_BTMP=false \
+				git repack -Adbl --write-bitmap-index --write-midx &&
+			git -c pack.allowPackReuse=$allow_pack_reuse \
+				pack-objects --all --use-bitmap-index --stdout </dev/null >/dev/null 2>err &&
+			test_must_be_empty err
+		)
+	'
+done
+
 test_done

base-commit: 91ec36f2cca02d33ab0ed6e87195c6fe801debae
--
2.44.0.549.g74a2f60dcb0
--- >8 ---

The way I would structure this series is to first apply the portion of
the above patch *without* these lines:

-	if (bitmap_is_midx(bitmap_git)) {
+	if (!bitmap_is_midx(bitmap_git) ||
+	    !bitmap_git->midx->chunk_bitmapped_packs)
+		multi_pack_reuse = 0;
+

, so we're still able to reproduce the issue. Then, apply the remaining
portions (the above diff, the test, and the GIT_TEST_MIDX_WRITE_BTMP
stuff) to demonstrate that the issue is fixed via a separate commit.

I'm happy to write that up, and equally happy to not do it ;-). Sorry
for the lengthy review, but thank you very much for spotting and fixing
this issue.

Thanks,
Taylor
