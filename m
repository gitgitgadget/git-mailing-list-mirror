Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEE94A1C
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 02:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742265802; cv=none; b=OkL+ejS0btaAf0tW8aq9SQjZhpUIPS1kIRg5TNqTf7TNOtTu9SIlP688WUZrbPXEh7AzWmBvvPir5ADW4kjKI+8jXCo+IYueBaK4zSsBwBd057Dd6pd3nMJzXUZpCmSXmdnaxG631JfXZDVfYvi+k8LWaXboiIcZusCs2yYPoUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742265802; c=relaxed/simple;
	bh=UnvF3Czw3ESBMMwJEsQp5TiR0X3NfgiNsu1HPHXkwWI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BxL/0+ViQ2Eb1DqmNAevb73pgrpW1YH4FVdEFK0Oe6m1Un5s4HPSe+n+js2iFG0manjuwZMfGVmGKT21ZUQoMgT5lGEkc6sopZR6+6+V8IRPhHAAObfnIMok+/f9WrfmRslH+KdnHhrevr6PgwNk6bcdLuGCy2GmZf1G3ASyXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P9JrKyPm; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P9JrKyPm"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d43c972616so16294255ab.0
        for <git@vger.kernel.org>; Mon, 17 Mar 2025 19:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742265800; x=1742870600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GUZVYEJid92mC15/sf9m1rmsvD4DXcX/SsUBrCBf60=;
        b=P9JrKyPmPM7IO+KHPXDyCfB5Zl7mkfq9AfBrrbhiDXcsAhhMQdskyW2uOYSc7rXpgP
         z9a3YnyZiT0FaDyUIDTYUcXKvljYJiTBMrp1Aq7JJGz+yBYQz+gHre5xgqUJ0IAPn6Rb
         oflyw2WWUUK5AZeJwWDOLkMBsj8X3DGxv3wJZ2buQsONAuZt9aj1E0USVU3YmjX4ZbN5
         ZWcoLBAd1a6VY0p7TiPDGffRf1zz+mFqw0GzBwFWEd0hR5hIsrYH8WPwyDcgRevA3+ji
         aIdDQ5Mxra+iEyanWghcnXM7NKzQso/Y91+QBF7S6Em0otC/GCSZOSKkFuw3b7thcTv1
         XQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742265800; x=1742870600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GUZVYEJid92mC15/sf9m1rmsvD4DXcX/SsUBrCBf60=;
        b=MFhg1FODeKnRCEIQIg7ypjsplORou4fE8TZIIYPLZgBD1csPRpAbq99uaknK/UOZn2
         pKRSZnJHkH3W86Ls6U6twj92AmE7Vg5uW9oN1ZhMsFdG7gxXNYu5X18JzuV2EFcTRiVH
         rP/CqhDmam9W3ggxPDlg+A8mAyVLF69VkttFeF951ob6unIXvbKwEb9uR5r+buc9zhLl
         EThrcJefUqODuiIzUangW5mS7RxOrmAC8+uMC8DKRcUizZ9GeRWKg/lzB3m64DouWm1n
         TFPbce02LZigkD7Toy//k6eJ299v4ltTYgh50t21BUxT3ALm9c4xnYKPKur+jpCnjCsv
         uLrw==
X-Gm-Message-State: AOJu0Ywz2A08ABDoFaQc3TbqV+NTGhVWNzIeO2JVnqs0PYpiV972QUKz
	IR7w475Si0jJTnrWNkXhYjcPR1HIRSTJrmuY7pOUSA+Kkm1970crHV5OOHMLMwtCocPGeTyAVVn
	OK5rUo8pkvaSk154y5BFXmE7FWrUssA==
X-Gm-Gg: ASbGncs5twevN92MZRQC64oXL2ulgx3bt9Q+2l4doEVBwjNgvyQDKeI6mE0fWmUKS+q
	tSnMmvKLu24sRhR36hCL7o8ojCqvO+loRulHFMVths49JSs5z4LzcylBx/+jdcuiIXhy2W3syaw
	QfKo7DDEVGEz2ECjpSQ0r/qyYHlFBbOISUjGMUafmjLhmirKrL9GLMpHMsZAw4JdlHGOFTsA==
X-Google-Smtp-Source: AGHT+IEcUNyLMKNPz0EgqsvflGxQur/jvEWSsh3k4pvUBdeuy44JcBMdtYoiYx8KFzt6JdgFwLK1yG2ukF9/9PHBr8o=
X-Received: by 2002:a92:b704:0:b0:3d1:84ad:165e with SMTP id
 e9e14a558f8ab-3d57c321510mr16098185ab.7.1742265799869; Mon, 17 Mar 2025
 19:43:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723755667.git.me@ttaylorr.com> <cover.1741983492.git.me@ttaylorr.com>
 <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>
In-Reply-To: <f2a232e556a066c1a5083f02584ddc3637ecfc48.1741983492.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 17 Mar 2025 19:43:07 -0700
X-Gm-Features: AQ5f1JrXtlUGzTTA2-yYVlG2J_RLnzMK6_7NRrIfh3c-pSJxJVXcK-jXGHG3jG8
Message-ID: <CABPp-BGbw+MOq9=cQzO5sc3XkakZQhXXg3r0iKeY5-p-4QR-3g@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] pack-revindex: prepare for incremental MIDX bitmaps
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 1:18=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> Prepare the reverse index machinery to handle object lookups in an
> incremental MIDX bitmap. These changes are broken out across a few
> functions:
>
>   - load_midx_revindex() learns to use the appropriate MIDX filename
>     depending on whether the given 'struct multi_pack_index *' is
>     incremental or not.
>
>   - pack_pos_to_midx() and midx_to_pack_pos() now both take in a global
>     object position in the MIDX pseudo-pack order, and finds the
>     earliest containing MIDX (similar to midx.c::midx_for_object().

s/finds/find/ ?


>
>   - midx_pack_order_cmp() adjusts its call to pack_pos_to_midx() by the
>     number of objects in the base (since 'vb - midx->revindx_data' is
>     relative to the containing MIDX, and pack_pos_to_midx() expects a
>     global position).
>
>     Likewise, this function adjusts its output by adding
>     m->num_objects_in_base to return a global position out through the
>     `*pos` pointer.
>
> Together, these changes are sufficient to use the multi-pack index's
> reverse index format for incremental multi-pack reachability bitmaps.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  pack-bitmap.c   | 40 ++++++++++++++++++++++++++++------------
>  pack-revindex.c | 34 +++++++++++++++++++++++++---------
>  2 files changed, 53 insertions(+), 21 deletions(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 6406953d32..c26d85b5db 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -170,6 +170,15 @@ static struct ewah_bitmap *read_bitmap_1(struct bitm=
ap_index *index)
>         return read_bitmap(index->map, index->map_size, &index->map_pos);
>  }
>
> +static uint32_t bitmap_non_extended_bits(struct bitmap_index *index)
> +{
> +       if (index->midx) {
> +               struct multi_pack_index *m =3D index->midx;
> +               return m->num_objects + m->num_objects_in_base;
> +       }
> +       return index->pack->num_objects;
> +}
> +
>  static uint32_t bitmap_num_objects(struct bitmap_index *index)
>  {
>         if (index->midx)
> @@ -924,7 +933,7 @@ static inline int bitmap_position_extended(struct bit=
map_index *bitmap_git,
>
>         if (pos < kh_end(positions)) {
>                 int bitmap_pos =3D kh_value(positions, pos);
> -               return bitmap_pos + bitmap_num_objects(bitmap_git);
> +               return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
>         }
>
>         return -1;
> @@ -992,7 +1001,7 @@ static int ext_index_add_object(struct bitmap_index =
*bitmap_git,
>                 bitmap_pos =3D kh_value(eindex->positions, hash_pos);
>         }
>
> -       return bitmap_pos + bitmap_num_objects(bitmap_git);
> +       return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
>  }
>
>  struct bitmap_show_data {
> @@ -1342,11 +1351,17 @@ struct ewah_bitmap *pseudo_merge_bitmap_for_commi=
t(struct bitmap_index *bitmap_g
>                 if (pos < 0 || pos >=3D bitmap_num_objects(bitmap_git))
>                         goto done;
>
> +               /*
> +                * Use bitmap-relative positions instead of offsetting
> +                * by bitmap_git->num_objects_in_base because we use
> +                * this to find a match in pseudo_merge_for_parents(),
> +                * and pseudo-merge groups cannot span multiple bitmap
> +                * layers.
> +                */
>                 bitmap_set(parents, pos);
>         }
>
> -       match =3D pseudo_merge_for_parents(&bitmap_git->pseudo_merges,
> -                                               parents);
> +       match =3D pseudo_merge_for_parents(&bitmap_git->pseudo_merges, pa=
rents);
>
>  done:
>         bitmap_free(parents);
> @@ -1500,7 +1515,8 @@ static void show_extended_objects(struct bitmap_ind=
ex *bitmap_git,
>         for (i =3D 0; i < eindex->count; ++i) {
>                 struct object *obj;
>
> -               if (!bitmap_get(objects, st_add(bitmap_num_objects(bitmap=
_git), i)))
> +               if (!bitmap_get(objects,
> +                               st_add(bitmap_non_extended_bits(bitmap_gi=
t), i)))
>                         continue;
>
>                 obj =3D eindex->objects[i];
> @@ -1679,7 +1695,7 @@ static void filter_bitmap_exclude_type(struct bitma=
p_index *bitmap_git,
>          * them individually.
>          */
>         for (i =3D 0; i < eindex->count; i++) {
> -               size_t pos =3D st_add(i, bitmap_num_objects(bitmap_git));
> +               size_t pos =3D st_add(i, bitmap_non_extended_bits(bitmap_=
git));
>                 if (eindex->objects[i]->type =3D=3D type &&
>                     bitmap_get(to_filter, pos) &&
>                     !bitmap_get(tips, pos))
> @@ -1705,7 +1721,7 @@ static unsigned long get_size_by_pos(struct bitmap_=
index *bitmap_git,
>
>         oi.sizep =3D &size;
>
> -       if (pos < bitmap_num_objects(bitmap_git)) {
> +       if (pos < bitmap_non_extended_bits(bitmap_git)) {
>                 struct packed_git *pack;
>                 off_t ofs;
>
> @@ -1729,7 +1745,7 @@ static unsigned long get_size_by_pos(struct bitmap_=
index *bitmap_git,
>                 }
>         } else {
>                 struct eindex *eindex =3D &bitmap_git->ext_index;
> -               struct object *obj =3D eindex->objects[pos - bitmap_num_o=
bjects(bitmap_git)];
> +               struct object *obj =3D eindex->objects[pos - bitmap_non_e=
xtended_bits(bitmap_git)];
>                 if (oid_object_info_extended(bitmap_repo(bitmap_git), &ob=
j->oid,
>                                              &oi, 0) < 0)
>                         die(_("unable to get size of %s"), oid_to_hex(&ob=
j->oid));
> @@ -1882,7 +1898,7 @@ static void filter_packed_objects_from_bitmap(struc=
t bitmap_index *bitmap_git,
>         uint32_t objects_nr;
>         size_t i, pos;
>
> -       objects_nr =3D bitmap_num_objects(bitmap_git);
> +       objects_nr =3D bitmap_non_extended_bits(bitmap_git);
>         pos =3D objects_nr / BITS_IN_EWORD;
>
>         if (pos > result->word_alloc)
> @@ -2419,7 +2435,7 @@ static uint32_t count_object_type(struct bitmap_ind=
ex *bitmap_git,
>         for (i =3D 0; i < eindex->count; ++i) {
>                 if (eindex->objects[i]->type =3D=3D type &&
>                     bitmap_get(objects,
> -                              st_add(bitmap_num_objects(bitmap_git), i))=
)
> +                              st_add(bitmap_non_extended_bits(bitmap_git=
), i)))
>                         count++;
>         }
>
> @@ -2820,7 +2836,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index=
 *bitmap_git,
>                 BUG("rebuild_existing_bitmaps: missing required rev-cache=
 "
>                     "extension");
>
> -       num_objects =3D bitmap_num_objects(bitmap_git);
> +       num_objects =3D bitmap_non_extended_bits(bitmap_git);
>         CALLOC_ARRAY(reposition, num_objects);
>
>         for (i =3D 0; i < num_objects; ++i) {
> @@ -2963,7 +2979,7 @@ static off_t get_disk_usage_for_extended(struct bit=
map_index *bitmap_git)
>                 struct object *obj =3D eindex->objects[i];
>
>                 if (!bitmap_get(result,
> -                               st_add(bitmap_num_objects(bitmap_git), i)=
))
> +                               st_add(bitmap_non_extended_bits(bitmap_gi=
t), i)))
>                         continue;
>
>                 if (oid_object_info_extended(bitmap_repo(bitmap_git), &ob=
j->oid,
> diff --git a/pack-revindex.c b/pack-revindex.c
> index d3832478d9..d3faab6a37 100644
> --- a/pack-revindex.c
> +++ b/pack-revindex.c
> @@ -383,8 +383,14 @@ int load_midx_revindex(struct multi_pack_index *m)
>         trace2_data_string("load_midx_revindex", the_repository,
>                            "source", "rev");
>
> -       get_midx_filename_ext(m->repo->hash_algo, &revindex_name, m->obje=
ct_dir,
> -                             get_midx_checksum(m), MIDX_EXT_REV);
> +       if (m->has_chain)
> +               get_split_midx_filename_ext(m->repo->hash_algo, &revindex=
_name,
> +                                           m->object_dir, get_midx_check=
sum(m),
> +                                           MIDX_EXT_REV);
> +       else
> +               get_midx_filename_ext(m->repo->hash_algo, &revindex_name,
> +                                     m->object_dir, get_midx_checksum(m)=
,
> +                                     MIDX_EXT_REV);
>
>         ret =3D load_revindex_from_disk(revindex_name.buf,
>                                       m->num_objects,
> @@ -471,11 +477,15 @@ off_t pack_pos_to_offset(struct packed_git *p, uint=
32_t pos)
>
>  uint32_t pack_pos_to_midx(struct multi_pack_index *m, uint32_t pos)
>  {
> +       while (m && pos < m->num_objects_in_base)
> +               m =3D m->base_midx;
> +       if (!m)
> +               BUG("NULL multi-pack-index for object position: %"PRIu32,=
 pos);
>         if (!m->revindex_data)
>                 BUG("pack_pos_to_midx: reverse index not yet loaded");
> -       if (m->num_objects <=3D pos)
> +       if (m->num_objects + m->num_objects_in_base <=3D pos)
>                 BUG("pack_pos_to_midx: out-of-bounds object at %"PRIu32, =
pos);
> -       return get_be32(m->revindex_data + pos);
> +       return get_be32(m->revindex_data + pos - m->num_objects_in_base);
>  }
>
>  struct midx_pack_key {
> @@ -491,7 +501,8 @@ static int midx_pack_order_cmp(const void *va, const =
void *vb)
>         const struct midx_pack_key *key =3D va;
>         struct multi_pack_index *midx =3D key->midx;
>
> -       uint32_t versus =3D pack_pos_to_midx(midx, (uint32_t*)vb - (const=
 uint32_t *)midx->revindex_data);
> +       size_t pos =3D (uint32_t *)vb - (const uint32_t *)midx->revindex_=
data;
> +       uint32_t versus =3D pack_pos_to_midx(midx, pos + midx->num_object=
s_in_base);
>         uint32_t versus_pack =3D nth_midxed_pack_int_id(midx, versus);
>         off_t versus_offset;
>
> @@ -529,9 +540,9 @@ static int midx_key_to_pack_pos(struct multi_pack_ind=
ex *m,
>  {
>         uint32_t *found;
>
> -       if (key->pack >=3D m->num_packs)
> +       if (key->pack >=3D m->num_packs + m->num_packs_in_base)
>                 BUG("MIDX pack lookup out of bounds (%"PRIu32" >=3D %"PRI=
u32")",
> -                   key->pack, m->num_packs);
> +                   key->pack, m->num_packs + m->num_packs_in_base);
>         /*
>          * The preferred pack sorts first, so determine its identifier by
>          * looking at the first object in pseudo-pack order.
> @@ -551,7 +562,8 @@ static int midx_key_to_pack_pos(struct multi_pack_ind=
ex *m,
>         if (!found)
>                 return -1;
>
> -       *pos =3D found - m->revindex_data;
> +       *pos =3D (found - m->revindex_data) + m->num_objects_in_base;
> +
>         return 0;
>  }
>
> @@ -559,9 +571,13 @@ int midx_to_pack_pos(struct multi_pack_index *m, uin=
t32_t at, uint32_t *pos)
>  {
>         struct midx_pack_key key;
>
> +       while (m && at < m->num_objects_in_base)
> +               m =3D m->base_midx;
> +       if (!m)
> +               BUG("NULL multi-pack-index for object position: %"PRIu32,=
 at);
>         if (!m->revindex_data)
>                 BUG("midx_to_pack_pos: reverse index not yet loaded");
> -       if (m->num_objects <=3D at)
> +       if (m->num_objects + m->num_objects_in_base <=3D at)
>                 BUG("midx_to_pack_pos: out-of-bounds object at %"PRIu32, =
at);
>
>         key.pack =3D nth_midxed_pack_int_id(m, at);
> --
> 2.49.0.13.gd0d564685b
>
