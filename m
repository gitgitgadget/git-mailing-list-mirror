Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9B3227B9C
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 20:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742500831; cv=none; b=lkwLLZ/tuB24r2ch+iBQh0/MeuVDlP+UKagDZK5By9LtjvP7pFiVcvwDcgdFxdX/Y4USaHgU7z+MG/XdjNIFSin7kkKqzz4xp49RrCxPOUWj1QLNpfKtypH4kCagrJsW/fKuZOgPC53vx9np1lbDmKeoQy2Iol5ceGX2JvF/l2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742500831; c=relaxed/simple;
	bh=0pDX/OPh2yOQ6pcXOdqBMczJcOmLTVLGKwUeQNBJ63o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qrNhKKE/GX70e7wXlJpMrCD0IkkIptfzz5X6cVuplsXiiuJyKyVkOXBqPHnVRmrKwMuFeXLIgGx0M6aAI/81kV9SdurXQWjV/JXk6XNs+hBwF5iULey8MyUu3nrr5+fvks3CCNxoA+2RQPunwEqdlU9pfeSipxndtBFREmwZUTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lLoplePH; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lLoplePH"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3cfce97a3d9so4890125ab.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742500828; x=1743105628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k14H01b9CzS2sn1fX4h1G9dYxRNEg5E2xs/RYReSQfg=;
        b=lLoplePHpvEFqaxEMz1U5d5hCmRyEBMBK4kICeUDaW33nC69eXoA5Hhcm1WKVV5e4N
         7+ecHsUQ/lUq/rYE+zlqRLGG9bo2jIJg0t4OzzMFP7gdltI3pJxyFAnZ5mvOUluhIIeV
         iLn1ox/fSZvNCSNemmJvuviTYlry/aLIa5+Lry7CrRWy1km/Czd5qyNtXFwKB5JmsTqI
         UE8dMXBMHxFYq8k9zJdLoYpOqJ2IaUAGYYUqyQHVmjZ6y3rqsFiHx1Xdlzc7O8fxoXbW
         jyVb2x37jSad5Z/tzNkgko5z14oVBaeHuHz/6SSW6CPseXaP5qOXzz0LCXiVa9BLzsu5
         T/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742500828; x=1743105628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k14H01b9CzS2sn1fX4h1G9dYxRNEg5E2xs/RYReSQfg=;
        b=Tc+8mdSg3N+D58BwJdcKRb4q2i7he8us9wcwA95rqXp90zdL2EiX7Nafqx/zjsNTsV
         mnaKfHrCtNathgSJy9L7J1SXCa2vlY24mktqDOnnYF8jC34nqdh9KbFE2UJe7RpiIaZC
         h3+PxKMMkKlAfHo1zfdrV4RlgHNKeObM+0/ZJyMw8FXeccT4S0ephkAG4Kf50QabYFF1
         AKREOiz2N8PnhJ9XQ5CJc1V2j8FCeDqDV7u8G+/FskGwmnCXhpbDuRNIO0+3Y8hsSwLf
         v9W/0JwxSeA1M5EOzqQQ6wd0unu4jgrnRRz416Fb7Qy0z8hJUTXoF5zpcueL3kgScDNP
         2nhw==
X-Gm-Message-State: AOJu0Yw1As8MwGY3NLF+0njGKn0F0b1LhDomoC9mCkWcSNqIV6N6VZSD
	I+wv9wJRvVo24/94eivSbowW7QesrUr3npX8mMXxg4BjUoxlTL8Qq9IzizNTfWuAhaUZBespzyK
	1vgT3y/HfMFNWLzG+uVheDUFohfk=
X-Gm-Gg: ASbGncvuO30A1asjaFp43TJfJMM1SXJBU74Fx7iP+8p0uULWftZ6VWvYnJ6U948NxwT
	sxQoG1sQVGQyLuoSreJE3pbAvlJD5V3Ux7jASMifBGfedkCXkVF6C/DlfhxUPTENi7KxcO79/te
	94JhMx+aCSWMKyABScYDopjlqi8lIE
X-Google-Smtp-Source: AGHT+IGDIjsYbxh1m1bnDDThlYBBBy5ptx9M+eNR12XkcwfxRYy4lmz+La+zCoQ6h7zNk+/s7GAI3aAy4sCgUTXKP9s=
X-Received: by 2002:a05:6e02:1f05:b0:3d3:fdb8:17a7 with SMTP id
 e9e14a558f8ab-3d5960e1e34mr9904085ab.6.1742500828002; Thu, 20 Mar 2025
 13:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723755667.git.me@ttaylorr.com> <cover.1742493373.git.me@ttaylorr.com>
In-Reply-To: <cover.1742493373.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 20 Mar 2025 13:00:00 -0700
X-Gm-Features: AQ5f1Jrae2CBzGTR_u9lzN2U-Do7ew8BRNIfmc71NO0BPAAahW1jVCKIlDX2O6k
Message-ID: <CABPp-BGv_KDdviT0C6khs0gaoHLSt+ZfmbAVrAkTyT9PC1=Unw@mail.gmail.com>
Subject: Re: [PATCH v5 00/14] midx: incremental multi-pack indexes, part two
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
	Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 10:56=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrot=
e:
>
> This is another new round of my series to implement bitmap support for
> incremental multi-pack indexes (MIDXs). It is still based on 683c54c999
> (Git 2.49, 2025-03-14).
>
> =3D=3D Changes since last time
>
> This round addresses thorough review from Elijah and Peff. The series
> substantively is unchanged, but there are lots of little quality-of-life
> and commit message readability improvements throughout. As usual, there
> is a range-diff below for convenience.
>
[...]
> Range-diff against v4:
>  -:  ---------- >  1:  6af65fdaac Documentation: remove a "future work" i=
tem from the MIDX docs
>  1:  f565f2fff1 !  2:  0897359506 Documentation: describe incremental MID=
X bitmaps
>     @@ Documentation/technical/multi-pack-index.adoc: objects_nr($H2) + o=
bjects_nr($H1)
>      +`o1` and `o2` are compared as follows:
>      +
>      +1. If `o1` appears in an earlier layer of the MIDX chain than `o2`,=
 then
>     -+  `o1` is considered less than `o2`.
>     ++  `o1` sorts ahead of `o2`.
>      +
>      +2. Otherwise, if `o1` and `o2` appear in the same MIDX layer, and t=
hat
>      +   MIDX layer has no base, then if one of `pack(o1)` and `pack(o2)`=
 is
>     -+   preferred and the other is not, then the preferred one sorts fir=
st. If
>     -+   there is a base layer (i.e. the MIDX layer is not the first laye=
r in
>     -+   the chain), then if `pack(o1)` appears earlier in that MIDX laye=
r's
>     -+   pack order, than `o1` is less than `o2`. Likewise if `pack(o2)`
>     -+   appears earlier, than the opposite is true.
>     ++   preferred and the other is not, then the preferred one sorts ahe=
ad of
>     ++   the non-preferred one. If there is a base layer (i.e. the MIDX l=
ayer
>     ++   is not the first layer in the chain), then if `pack(o1)` appears
>     ++   earlier in that MIDX layer's pack order, then `o1` sorts ahead o=
f
>     ++   `o2`. Likewise if `pack(o2)` appears earlier, then the opposite =
is
>     ++   true.
>      +
>      +3. Otherwise, `o1` and `o2` appear in the same pack, and thus in th=
e
>      +   same MIDX layer. Sort `o1` and `o2` by their offset within their
>     @@ Documentation/technical/multi-pack-index.adoc: objects_nr($H2) + o=
bjects_nr($H1)
>      +The structure of a `*.bitmap` file belonging to an incremental MIDX
>      +chain is identical to that of a non-incremental MIDX bitmap, or a
>      +classic single-pack bitmap. Since objects are added to the end of t=
he
>     -+incremental MIDX's pseudo-pack order (see: above), it is possible t=
o
>     ++incremental MIDX's pseudo-pack order (see above), it is possible to
>      +extend a bitmap when appending to the end of a MIDX chain.
>      +
>      +(Note: it is possible likewise to compress a contiguous sequence of=
 MIDX
>     -+incremental layers, and their `*.bitmap`(s) into a single layer and
>     ++incremental layers, and their `*.bitmap` files into a single layer =
and
>      +`*.bitmap`, but this is not yet implemented.)
>      +
>      +The object positions used are global within the pseudo-pack order, =
so
>  2:  f2a232e556 !  3:  5eac0d1485 pack-revindex: prepare for incremental =
MIDX bitmaps
>     @@ Commit message
>              incremental or not.
>
>            - pack_pos_to_midx() and midx_to_pack_pos() now both take in a=
 global
>     -        object position in the MIDX pseudo-pack order, and finds the
>     +        object position in the MIDX pseudo-pack order, and find the
>              earliest containing MIDX (similar to midx.c::midx_for_object=
().
>
>            - midx_pack_order_cmp() adjusts its call to pack_pos_to_midx()=
 by the
>     @@ pack-bitmap.c: static struct ewah_bitmap *read_bitmap_1(struct bit=
map_index *ind
>         return read_bitmap(index->map, index->map_size, &index->map_pos);
>       }
>
>     -+static uint32_t bitmap_non_extended_bits(struct bitmap_index *index=
)
>     ++static uint32_t bitmap_num_objects_total(struct bitmap_index *index=
)
>      +{
>      +  if (index->midx) {
>      +          struct multi_pack_index *m =3D index->midx;
>     @@ pack-bitmap.c: static inline int bitmap_position_extended(struct b=
itmap_index *b
>         if (pos < kh_end(positions)) {
>                 int bitmap_pos =3D kh_value(positions, pos);
>      -          return bitmap_pos + bitmap_num_objects(bitmap_git);
>     -+          return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
>     ++          return bitmap_pos + bitmap_num_objects_total(bitmap_git);
>         }
>
>         return -1;
>     @@ pack-bitmap.c: static int ext_index_add_object(struct bitmap_index=
 *bitmap_git,
>         }
>
>      -  return bitmap_pos + bitmap_num_objects(bitmap_git);
>     -+  return bitmap_pos + bitmap_non_extended_bits(bitmap_git);
>     ++  return bitmap_pos + bitmap_num_objects_total(bitmap_git);
>       }
>
>       struct bitmap_show_data {
>     @@ pack-bitmap.c: static void show_extended_objects(struct bitmap_ind=
ex *bitmap_git
>
>      -          if (!bitmap_get(objects, st_add(bitmap_num_objects(bitmap=
_git), i)))
>      +          if (!bitmap_get(objects,
>     -+                          st_add(bitmap_non_extended_bits(bitmap_gi=
t), i)))
>     ++                          st_add(bitmap_num_objects_total(bitmap_gi=
t),
>     ++                                 i)))
>                         continue;
>
>                 obj =3D eindex->objects[i];
>     @@ pack-bitmap.c: static void filter_bitmap_exclude_type(struct bitma=
p_index *bitma
>          */
>         for (i =3D 0; i < eindex->count; i++) {
>      -          size_t pos =3D st_add(i, bitmap_num_objects(bitmap_git));
>     -+          size_t pos =3D st_add(i, bitmap_non_extended_bits(bitmap_=
git));
>     ++          size_t pos =3D st_add(i, bitmap_num_objects_total(bitmap_=
git));
>                 if (eindex->objects[i]->type =3D=3D type &&
>                     bitmap_get(to_filter, pos) &&
>                     !bitmap_get(tips, pos))
>     @@ pack-bitmap.c: static unsigned long get_size_by_pos(struct bitmap_=
index *bitmap_
>         oi.sizep =3D &size;
>
>      -  if (pos < bitmap_num_objects(bitmap_git)) {
>     -+  if (pos < bitmap_non_extended_bits(bitmap_git)) {
>     ++  if (pos < bitmap_num_objects_total(bitmap_git)) {
>                 struct packed_git *pack;
>                 off_t ofs;
>
>      @@ pack-bitmap.c: static unsigned long get_size_by_pos(struct bitmap=
_index *bitmap_git,
>     +                   die(_("unable to get size of %s"), oid_to_hex(&oi=
d));
>                 }
>         } else {
>     ++          size_t eindex_pos =3D pos - bitmap_num_objects_total(bitm=
ap_git);
>                 struct eindex *eindex =3D &bitmap_git->ext_index;
>      -          struct object *obj =3D eindex->objects[pos - bitmap_num_o=
bjects(bitmap_git)];
>     -+          struct object *obj =3D eindex->objects[pos - bitmap_non_e=
xtended_bits(bitmap_git)];
>     ++          struct object *obj =3D eindex->objects[eindex_pos];
>                 if (oid_object_info_extended(bitmap_repo(bitmap_git), &ob=
j->oid,
>                                              &oi, 0) < 0)
>                         die(_("unable to get size of %s"), oid_to_hex(&ob=
j->oid));
>     @@ pack-bitmap.c: static void filter_packed_objects_from_bitmap(struc=
t bitmap_index
>         size_t i, pos;
>
>      -  objects_nr =3D bitmap_num_objects(bitmap_git);
>     -+  objects_nr =3D bitmap_non_extended_bits(bitmap_git);
>     ++  objects_nr =3D bitmap_num_objects_total(bitmap_git);
>         pos =3D objects_nr / BITS_IN_EWORD;
>
>         if (pos > result->word_alloc)
>     @@ pack-bitmap.c: static uint32_t count_object_type(struct bitmap_ind=
ex *bitmap_git
>                 if (eindex->objects[i]->type =3D=3D type &&
>                     bitmap_get(objects,
>      -                         st_add(bitmap_num_objects(bitmap_git), i))=
)
>     -+                         st_add(bitmap_non_extended_bits(bitmap_git=
), i)))
>     ++                         st_add(bitmap_num_objects_total(bitmap_git=
), i)))
>                         count++;
>         }
>
>     @@ pack-bitmap.c: uint32_t *create_bitmap_mapping(struct bitmap_index=
 *bitmap_git,
>                     "extension");
>
>      -  num_objects =3D bitmap_num_objects(bitmap_git);
>     -+  num_objects =3D bitmap_non_extended_bits(bitmap_git);
>     ++  num_objects =3D bitmap_num_objects_total(bitmap_git);
>         CALLOC_ARRAY(reposition, num_objects);
>
>         for (i =3D 0; i < num_objects; ++i) {
>     @@ pack-bitmap.c: static off_t get_disk_usage_for_extended(struct bit=
map_index *bit
>
>                 if (!bitmap_get(result,
>      -                          st_add(bitmap_num_objects(bitmap_git), i)=
))
>     -+                          st_add(bitmap_non_extended_bits(bitmap_gi=
t), i)))
>     ++                          st_add(bitmap_num_objects_total(bitmap_gi=
t),
>     ++                                 i)))
>                         continue;
>
>                 if (oid_object_info_extended(bitmap_repo(bitmap_git), &ob=
j->oid,
>  3:  aca0318fb1 !  4:  922ea2f607 pack-bitmap.c: open and store increment=
al bitmap layers
>     @@ Commit message
>          with the previous MIDX layer.
>
>          The changes in this commit are mostly boilerplate to open the co=
rrect
>     -    bitmap(s), add them to the chain bitmap layers along the "base" =
pointer,
>     -    ensures that the correct packs and their reverse indexes are loa=
ded
>     -    across MIDX layers, etc.
>     +    bitmap(s), add them to the chain of bitmap layers along the "bas=
e"
>     +    pointer, ensure that the correct packs and their reverse indexes=
 are
>     +    loaded across MIDX layers, etc.
>
>          While we're at it, keep track of a base_nr field to indicate how=
 many
>          bitmap layers (including the current bitmap) exist. This will be=
 used in
>  4:  832fd0e8dc =3D  5:  8fedd96614 pack-bitmap.c: teach `bitmap_for_comm=
it()` about incremental MIDXs
>  5:  c7c9f89956 =3D  6:  dccc1b2d2e pack-bitmap.c: teach `show_objects_fo=
r_type()` about incremental MIDXs
>  6:  14d3d80c3d !  7:  e31bddd240 pack-bitmap.c: support bitmap pack-reus=
e with incremental MIDXs
>     @@ Commit message
>
>          Likewise, in reuse_partial_packfile_from_bitmap(), when reusing =
only a
>          single pack from a MIDX, use the oldest layer's preferred pack a=
s it is
>     -    likely to contain the most amount of reusable sections.
>     +    likely to contain the largest number of reusable sections.
>
>          Signed-off-by: Taylor Blau <me@ttaylorr.com>
>
>  7:  b45a9ccbc2 !  8:  d9dfcb5a1b pack-bitmap.c: teach `rev-list --test-b=
itmap` about incremental MIDXs
>     @@ pack-bitmap.c: static void test_show_commit(struct commit *commit,=
 void *data)
>      +  tdata->tags =3D ewah_to_bitmap(bitmap_git->tags);
>      +
>      +  if (bitmap_git->base) {
>     -+          CALLOC_ARRAY(tdata->base_tdata, 1);
>     ++          tdata->base_tdata =3D xmalloc(sizeof(struct bitmap_test_d=
ata));
>      +          bitmap_test_data_prepare(tdata->base_tdata, bitmap_git->b=
ase);
>      +  }
>      +}
>  8:  c1eefeae99 =3D  9:  b1bd60d25d pack-bitmap.c: compute disk-usage wit=
h incremental MIDXs
>  9:  11c4b7b949 =3D 10:  7477a8ac03 pack-bitmap.c: apply pseudo-merge com=
mits with incremental MIDXs
> 10:  cb08ad6a62 ! 11:  0fbef17acc ewah: implement `struct ewah_or_iterato=
r`
>     @@ ewah/ewah_bitmap.c: void ewah_iterator_init(struct ewah_iterator *=
it, struct ewa
>      +  return ret;
>      +}
>      +
>     -+void ewah_or_iterator_free(struct ewah_or_iterator *it)
>     ++void ewah_or_iterator_release(struct ewah_or_iterator *it)
>      +{
>      +  free(it->its);
>      +}
>     @@ ewah/ewok.h: void ewah_iterator_init(struct ewah_iterator *it, str=
uct ewah_bitma
>      +
>      +int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *i=
t);
>      +
>     -+void ewah_or_iterator_free(struct ewah_or_iterator *it);
>     ++void ewah_or_iterator_release(struct ewah_or_iterator *it);
>      +
>       void ewah_xor(
>         struct ewah_bitmap *ewah_i,
> 11:  a29f4ee60d ! 12:  439e743fd5 pack-bitmap.c: keep track of each layer=
's type bitmaps
>     @@ pack-bitmap.c: struct bitmap_index {
>      +   * commits_all[n-2] is the commits field of this bitmap's
>      +   * 'base', and so on.
>      +   *
>     -+   * When either associated either with a non-incremental MIDX, or
>     -+   * a single packfile, these arrays each contain a single
>     -+   * element.
>     ++   * When associated either with a non-incremental MIDX or a
>     ++   * single packfile, these arrays each contain a single element.
>      +   */
>      +  struct ewah_bitmap **commits_all;
>      +  struct ewah_bitmap **trees_all;
> 12:  a1cf65bedc ! 13:  dcb45e349e pack-bitmap.c: use `ewah_or_iterator` f=
or type bitmap iterators
>     @@ pack-bitmap.c: static void show_objects_for_type(
>                 }
>         }
>      +
>     -+  ewah_or_iterator_free(&it);
>     ++  ewah_or_iterator_release(&it);
>       }
>
>       static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
>     @@ pack-bitmap.c: static void filter_bitmap_exclude_type(struct bitma=
p_index *bitma
>                         bitmap_unset(to_filter, pos);
>         }
>
>     -+  ewah_or_iterator_free(&it);
>     ++  ewah_or_iterator_release(&it);
>         bitmap_free(tips);
>       }
>
>     @@ pack-bitmap.c: static void filter_bitmap_blob_limit(struct bitmap_=
index *bitmap_
>                         bitmap_unset(to_filter, pos);
>         }
>
>     -+  ewah_or_iterator_free(&it);
>     ++  ewah_or_iterator_release(&it);
>         bitmap_free(tips);
>       }
>
>     @@ pack-bitmap.c: static uint32_t count_object_type(struct bitmap_ind=
ex *bitmap_git
>                         count++;
>         }
>
>     -+  ewah_or_iterator_free(&it);
>     ++  ewah_or_iterator_release(&it);
>      +
>         return count;
>       }
>     @@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap_=
index *bitmap_
>                 }
>         }
>
>     -+  ewah_or_iterator_free(&it);
>     ++  ewah_or_iterator_release(&it);
>      +
>         return total;
>       }
> 13:  d0d564685b ! 14:  13568cfa3b midx: implement writing incremental MID=
X bitmaps
>     @@ builtin/pack-objects.c: static void write_pack_file(void)
>                                 bitmap_writer_build_type_index(&bitmap_wr=
iter,
>                                                                written_li=
st);
>
>     - ## ewah/ewah_bitmap.c ##
>     -@@ ewah/ewah_bitmap.c: int ewah_or_iterator_next(eword_t *next, stru=
ct ewah_or_iterator *it)
>     -   return ret;
>     - }
>     -
>     --void ewah_or_iterator_free(struct ewah_or_iterator *it)
>     -+void ewah_or_iterator_release(struct ewah_or_iterator *it)
>     - {
>     -   free(it->its);
>     - }
>     -
>     - ## ewah/ewok.h ##
>     -@@ ewah/ewok.h: void ewah_or_iterator_init(struct ewah_or_iterator *=
it,
>     -
>     - int ewah_or_iterator_next(eword_t *next, struct ewah_or_iterator *i=
t);
>     -
>     --void ewah_or_iterator_free(struct ewah_or_iterator *it);
>     -+void ewah_or_iterator_release(struct ewah_or_iterator *it);
>     -
>     - void ewah_xor(
>     -   struct ewah_bitmap *ewah_i,
>     -
>       ## midx-write.c ##
>      @@ midx-write.c: static uint32_t *midx_pack_order(struct write_midx_=
context *ctx)
>         return pack_order;
>     @@ pack-bitmap-write.c: void bitmap_writer_finish(struct bitmap_write=
r *writer,
>
>         write_selected_commits_v1(writer, f, offsets);
>
>     - ## pack-bitmap.c ##
>     -@@ pack-bitmap.c: static void show_objects_for_type(
>     -           }
>     -   }
>     -
>     --  ewah_or_iterator_free(&it);
>     -+  ewah_or_iterator_release(&it);
>     - }
>     -
>     - static int in_bitmapped_pack(struct bitmap_index *bitmap_git,
>     -@@ pack-bitmap.c: static void filter_bitmap_exclude_type(struct bitm=
ap_index *bitmap_git,
>     -                   bitmap_unset(to_filter, pos);
>     -   }
>     -
>     --  ewah_or_iterator_free(&it);
>     -+  ewah_or_iterator_release(&it);
>     -   bitmap_free(tips);
>     - }
>     -
>     -@@ pack-bitmap.c: static void filter_bitmap_blob_limit(struct bitmap=
_index *bitmap_git,
>     -                   bitmap_unset(to_filter, pos);
>     -   }
>     -
>     --  ewah_or_iterator_free(&it);
>     -+  ewah_or_iterator_release(&it);
>     -   bitmap_free(tips);
>     - }
>     -
>     -@@ pack-bitmap.c: static uint32_t count_object_type(struct bitmap_in=
dex *bitmap_git,
>     -                   count++;
>     -   }
>     -
>     --  ewah_or_iterator_free(&it);
>     -+  ewah_or_iterator_release(&it);
>     -
>     -   return count;
>     - }
>     -@@ pack-bitmap.c: static off_t get_disk_usage_for_type(struct bitmap=
_index *bitmap_git,
>     -           }
>     -   }
>     -
>     --  ewah_or_iterator_free(&it);
>     -+  ewah_or_iterator_release(&it);
>     -
>     -   return total;
>     - }
>     -
>       ## pack-bitmap.h ##
>      @@ pack-bitmap.h: struct bitmap_writer {
>
>     @@ t/t5334-incremental-multi-pack-index.sh: test_expect_success 'conv=
ert incrementa
>      +'
>      +
>      +test_expect_success 'midx verify with multiple layers' '
>     ++  test_path_is_file "$midx_chain" &&
>     ++  test_line_count =3D 2 "$midx_chain" &&
>     ++
>      +  git multi-pack-index verify
>      +'
>      +
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> --
> 2.49.0.14.g88b49c1b34

Reading the range-diff plus the new first patch, all my feedback has
been addressed with this round.
