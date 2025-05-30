Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34D1DE88C
	for <git@vger.kernel.org>; Fri, 30 May 2025 04:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577846; cv=none; b=Bwy2Yv8ddccs5dQ69dPguxAQ6MRM0SHs2T3Sm3LK01Ha6RMv1I9c0vzu7Q4h2jTtWFyWDXR1sCDEEFiNB3+SoHjI6G3P9UREdeiQsBv0zEV14TICXaiVMIirTy6sf7ifufzfDIU8m88DfUIHteNtm4PApPOy7wPtMl308R2HfCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577846; c=relaxed/simple;
	bh=UnDgvd7DKP1k6fdOzBGgCZOCS2kqjS8DnbTPU6XjzTU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=VX4AXW3VASj6CvpNliZwv+odvxp6OEMnKbwFsM2GSeh7T40lf60Mef1qRycduygoBmMUWCCfs++/9CTOzqjALvOL6H8l2ogMYxZjQxV5DEA0oU2k0VZjkMgqeDBofzf4WqtjUhRBovmlkmoZA5mtZ2sOj4TftA3MtZw61J7o1yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz6t1748577805tdf9a7adb
X-QQ-Originating-IP: dOhtKndCcbVx+D4pHavI81HRimYbIZnFSlK+kgn8/Bk=
Received: from smtpclient.apple ( [36.152.24.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 30 May 2025 12:03:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1399090799767469919
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4 2/2] pack-bitmap: add load corrupt bitmap test
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aDjPsMqyYSm+b2Ap@nand.local>
Date: Fri, 30 May 2025 12:03:13 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <963BE708-67DE-4DBA-B1E3-754ADFCD9C26@smail.nju.edu.cn>
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
 <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
 <7876d9a9014ea6a0657f440f7fa1efd496a4a15a.1748140983.git.gitgitgadget@gmail.com>
 <aDjPsMqyYSm+b2Ap@nand.local>
To: Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OH/oXo99N/TGD+ojG9P/yzn3PDtxhstrISrE0bppnZYKKQQmEQ0hW5yY
	ccqD2OIcb+U0LiwRyLrS4kREKP9ldp51KIYd1ku3EAHLkY9/+Avn/xw4McyrKTq76y2LtRU
	lXntWGUr11u0SZyRfeeReVsl8ShmN8Y2W47f1MWqhRfxnizR8tqI8tvepUo/NJakjtZZFI7
	n8V4UrcXAt93Jb7Iru1mvrG0X8qu27ji6U6QGow0Br/numZZfXfl/p8BPlhX00paNZhfH6s
	sISlw6WGa9yjRnpS1VYAX1MF5jBKA/wtJBUt675ug6NBwKjs12Jk81Bp7VMM1hrXgsM8Q/p
	bYpDqDZrSsv51UVKOM5MUguCUdaoH6jA07YBQNN5xOPV7CcsY5Yz5Ok4AhhCIca2f5eqwD3
	Sg0LQyLkWvAiyksRCzK3KrhzB8/GFCxaQUe9mX1LvOKMQmorSajLFBLTqRO9XMkqMIMyVMA
	Sn9Ukmhi2UIkFbr/i/EoJEeEn5OMvALaHVrwtLzKedT/huXP4jBQgLqrfGvIbSh7PGybLZv
	P+dFX9mRGLrjyFsXB6n/34fDNKSUVTvNOaIVwDE/rHLIPIETrgJOXSamcjdcl7pwXpLE582
	AZjatkvpOe7lxhuFVf8AXfZ9zSUyryx42Vl6FOvN3dmdwhAcGdMVm41KaFgc4xjDB/vEysr
	9a976VxxSAflm52PFxzb9kd/xZkp50j482dlxGEdwyQ03OCZDphiEbDEJ/BcWgfpPiyI7/f
	4wn9Gg/iI0gT0nCFHUxhDPkDYgSC4l5xTO17m370R8SYgdwADzr0JMY/2qbbXNke2BaNOmR
	xZmLF0ywl69saFhCS5Pme2+eiKZZOR8oKz2ehepOHTxQqUknqbcKiZewN2Me1mssiAtjreu
	tZsxFkuHwHtBNM32zfhaVyFT5mjaUrxH/xeV44e0qZW/o22vk8wrY2JecgXz1S52hcSr9DW
	egSDKqmDqYFIiIGOAmL73apWn2d0gZdxsjogH8gAWvW00XZ8lLA3nFUoUBNbZYD+dJyljyD
	6NevM+It1ff+C39KNFZ1wm2BMyo7HUVJ9UzuSpIw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8830=E6=97=A5 05:20=EF=BC=8CTaylor Blau =
<me@ttaylorr.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Sun, May 25, 2025 at 02:43:03AM +0000, Lidong Yan via GitGitGadget =
wrote:
>> diff --git a/pack-bitmap.c b/pack-bitmap.c
>> index fd19c2255163..39c1c1bc4ce1 100644
>> --- a/pack-bitmap.c
>> +++ b/pack-bitmap.c
>> @@ -34,6 +34,11 @@ struct stored_bitmap {
>> int flags;
>> };
>>=20
>> +struct stored_bitmap_tag_pos {
>> + struct stored_bitmap stored;
>> + size_t map_pos;
>> +};
>> +
>=20
> Hmm. I was expecting you to add a new member to the stored_bitmap
> structure, not a new structure entirely. Let's read on...
>=20
>> /*
>>  * The active bitmap index for a repository. By design, repositories =
only have
>>  * a single bitmap index available (the index for the biggest =
packfile in
>> @@ -148,6 +153,7 @@ static int existing_bitmaps_hits_nr;
>> static int existing_bitmaps_misses_nr;
>> static int roots_with_bitmaps_nr;
>> static int roots_without_bitmaps_nr;
>> +static int tag_pos_on_bitmap;
>=20
> Why are we only sometimes tagging bitmaps with their position?
>=20
>>=20
>> static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap =
*st)
>> {
>> @@ -314,13 +320,18 @@ static struct stored_bitmap =
*store_bitmap(struct bitmap_index *index,
>>  struct ewah_bitmap *root,
>>  const struct object_id *oid,
>>  struct stored_bitmap *xor_with,
>> -  int flags)
>> +  int flags, size_t map_pos)
>> {
>> struct stored_bitmap *stored;
>> + struct stored_bitmap_tag_pos *tagged;
>=20
> OK.
>=20
>> khiter_t hash_pos;
>> int ret;
>>=20
>> - stored =3D xmalloc(sizeof(struct stored_bitmap));
>> + tagged =3D xmalloc(tag_pos_on_bitmap ? sizeof(struct =
stored_bitmap_tag_pos) :
>> +     sizeof(struct stored_bitmap));
>> + stored =3D &tagged->stored;
>> + if (tag_pos_on_bitmap)
>> + tagged->map_pos =3D map_pos;
>=20
> I am quite worried about this portion of the diff.
>=20
> Here you allocate memory for "tagged" which is a =
stored_bitmap_tag_pos.
> But the amount of bytes you allocate depends on whether the global
> variable tag_pos_on_bitmap is set or not. If it isn't, then you don't
> allocate enough memory here to hold an entire stored_bitmap_tag_pos
> structure.
>=20
> I think within this function you're OK, since you only write into that
> field when tag_pos_on_bitmap is set. But this seems like a recipe for
> disaster if you ever try to read or write into the tagged->map_pos =
field
> when tag_pos_on_bitmap *isn't* set.
>=20
> This happens to work because of where the pointer to the stored_bitmap
> structure lives within the stored_bitmap_tag_pos structure. But this
> seems *extremely* fragile to only save 4 bytes of allocated memory per
> bitmap. Even on a repository with ~1,000 bitmaps (which is rare from =
my
> experience), you're only saving ~3.91 KiB.

Interesting calculation indeed =E2=80=94 I hadn't thought about the =
actual memory
savings that way. I agree it=E2=80=99s not worth the added fragility =
just to save ~4 KiB
in such rare cases. I=E2=80=99ll go ahead and remove the struct =
stored_bitmap_tagged_pos.

>=20
> I would expect something more like the following (based on top of your
> patch here):
>=20
> --- 8< ---
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 39c1c1bc4c..4c3829dba9 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -31,12 +31,8 @@ struct stored_bitmap {
> struct object_id oid;
> struct ewah_bitmap *root;
> struct stored_bitmap *xor;
> - int flags;
> -};
> -
> -struct stored_bitmap_tag_pos {
> - struct stored_bitmap stored;
> size_t map_pos;
> + int flags;
> };
>=20
> /*
> @@ -153,7 +149,6 @@ static int existing_bitmaps_hits_nr;
> static int existing_bitmaps_misses_nr;
> static int roots_with_bitmaps_nr;
> static int roots_without_bitmaps_nr;
> -static int tag_pos_on_bitmap;
>=20
> static struct ewah_bitmap *lookup_stored_bitmap(struct stored_bitmap =
*st)
> {
> @@ -323,17 +318,13 @@ static struct stored_bitmap *store_bitmap(struct =
bitmap_index *index,
>  int flags, size_t map_pos)
> {
> struct stored_bitmap *stored;
> - struct stored_bitmap_tag_pos *tagged;
> khiter_t hash_pos;
> int ret;
>=20
> - tagged =3D xmalloc(tag_pos_on_bitmap ? sizeof(struct =
stored_bitmap_tag_pos) :
> -     sizeof(struct stored_bitmap));
> - stored =3D &tagged->stored;
> - if (tag_pos_on_bitmap)
> - tagged->map_pos =3D map_pos;
> + stored =3D xmalloc(sizeof(struct stored_bitmap));
> stored->root =3D root;
> stored->xor =3D xor_with;
> + stored->map_pos =3D map_pos;
> stored->flags =3D flags;
> oidcpy(&stored->oid, oid);
>=20
> @@ -2878,12 +2869,11 @@ int test_bitmap_commits(struct repository *r)
> int test_bitmap_commits_offset(struct repository *r)
> {
> struct object_id oid;
> - struct stored_bitmap_tag_pos *tagged;
> + struct stored_bitmap *bitmap;
> struct bitmap_index *bitmap_git;
> size_t commit_idx_pos_map_pos, xor_offset_map_pos, flag_map_pos,
> ewah_bitmap_map_pos;
>=20
> - tag_pos_on_bitmap =3D 1;
> bitmap_git =3D prepare_bitmap_git(r);
> if (!bitmap_git)
> die(_("failed to load bitmap indexes"));
> @@ -2897,9 +2887,9 @@ int test_bitmap_commits_offset(struct repository =
*r)
> die(_("failed to load bitmap indexes"));
> }
>=20
> - kh_foreach (bitmap_git->bitmaps, oid, tagged, {
> - commit_idx_pos_map_pos =3D tagged->map_pos;
> - xor_offset_map_pos =3D tagged->map_pos + sizeof(uint32_t);
> + kh_foreach (bitmap_git->bitmaps, oid, bitmap, {
> + commit_idx_pos_map_pos =3D bitmap->map_pos;
> + xor_offset_map_pos =3D bitmap->map_pos + sizeof(uint32_t);
> flag_map_pos =3D xor_offset_map_pos + sizeof(uint8_t);
> ewah_bitmap_map_pos =3D flag_map_pos + sizeof(uint8_t);
> --- >8 ---
>=20
>> stored->root =3D root;
>> stored->xor =3D xor_with;
>> stored->flags =3D flags;
>> @@ -376,10 +387,12 @@ static int load_bitmap_entries_v1(struct =
bitmap_index *index)
>> struct stored_bitmap *xor_bitmap =3D NULL;
>> uint32_t commit_idx_pos;
>> struct object_id oid;
>> + size_t entry_map_pos;
>>=20
>> if (index->map_size - index->map_pos < 6)
>> return error(_("corrupt ewah bitmap: truncated header for entry %d"), =
i);
>>=20
>> + entry_map_pos =3D index->map_pos;
>=20
> Good. This is important since the read_be32() and read_u8() calls =
below
> both adjust the value of index->map_pos past the beginning of the =
bitmap.
>=20
>> @@ -869,6 +883,7 @@ static struct stored_bitmap =
*lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>> int xor_flags;
>> khiter_t hash_pos;
>> struct bitmap_lookup_table_xor_item *xor_item;
>> + size_t entry_map_pos;
>>=20
>> if (is_corrupt)
>> return NULL;
>> @@ -928,6 +943,7 @@ static struct stored_bitmap =
*lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>> goto corrupt;
>> }
>>=20
>> + entry_map_pos =3D bitmap_git->map_pos;
>=20
> Same here.
>=20
>> @@ -969,6 +986,7 @@ static struct stored_bitmap =
*lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>> * Instead, we can skip ahead and immediately read the flags and
>> * ewah bitmap.
>> */
>> + entry_map_pos =3D bitmap_git->map_pos;
>=20
> And here.
>=20
>> +int test_bitmap_commits_offset(struct repository *r)
>> +{
>> + struct object_id oid;
>> + struct stored_bitmap_tag_pos *tagged;
>> + struct bitmap_index *bitmap_git;
>> + size_t commit_idx_pos_map_pos, xor_offset_map_pos, flag_map_pos,
>> + ewah_bitmap_map_pos;
>> +
>> + tag_pos_on_bitmap =3D 1;
>> + bitmap_git =3D prepare_bitmap_git(r);
>> + if (!bitmap_git)
>> + die(_("failed to load bitmap indexes"));
>> +
>=20
> If we either forgot to set this variable here or did so after calling
> prepare_bitmap_git(), then we wouldn't allocate enough memory to store
> the map_pos field in the stored_bitmap_tag_pos structure. When we then
> would try and read that field below, we'd read garbage heap data =
outside
> of our structure.
>=20
>> + /*
>> + * As this function is only used to print bitmap selected
>> + * commits, we don't have to read the commit table.
>> + */
>> + if (bitmap_git->table_lookup) {
>> + if (load_bitmap_entries_v1(bitmap_git) < 0)
>> + die(_("failed to load bitmap indexes"));
>> + }
>=20
> This comment suggests that we can avoid reading the commit table
> altogether. Indeed, calling load_bitmap_entries_v1() here does that,
> since it is not called when loading a bitmap that has a lookup table.
>=20
> So I think the behavior here is correct, but the comment is =
misleading.
> I suspect that the confusion would be resolved by instead writing:
>=20
>    /*
>     * Since this function needs to know the position of each =
individual
>     * bitmap, bypass the commit lookup table (if one exists) by =
forcing
>     * the bitmap to eagerly load its entries.
>     */
>=20
> I think this is copy-and-paste from 28cd730680 (pack-bitmap: prepare =
to
> read lookup table extension, 2022-08-14) via the =
'test_bitmap_commits()'
> function immediately above this one. I think both would benefit from
> some clean-up, since this comment is equally misleading in that
> function.
>=20
> For your purposes, I would either:
>=20
> - remove or (preferably) reword the comment in your new function,
>   leaving the one in test_bitmap_commits() as-is, or
>=20
> - reword the comment in test_bitmap_commits() to be more like the one
>   above, via a preparatory commit, and then introduce the new function
>   using the same wording.
>=20
> Between the two, I think the latter is preferable.

I will add a new commit reword the comment before the last =
addt-test-case commit.

>=20
> As an aside, I think that for bitmaps that do have a commit lookup
> table, you could go slightly faster here by walking over that portion =
of
> the *.bitmap file, since it directly encodes the information you're
> interested in here. But I would avoid doing that, since it too seems
> brittle and I would like to avoid having two separate spots that each
> implement reading the commit table format.
>=20
>> + kh_foreach (bitmap_git->bitmaps, oid, tagged, {
>> + commit_idx_pos_map_pos =3D tagged->map_pos;
>=20
> OK, and here's where we pull out the actual position of the selected
> commit's bitmap.
>=20
>> + xor_offset_map_pos =3D tagged->map_pos + sizeof(uint32_t);
>> + flag_map_pos =3D xor_offset_map_pos + sizeof(uint8_t);
>> + ewah_bitmap_map_pos =3D flag_map_pos + sizeof(uint8_t);
>> +
>> + printf_ln("%s %"PRIuMAX" %"PRIuMAX" %"PRIuMAX" %"PRIuMAX,
>> +  oid_to_hex(&oid),
>> +  (uintmax_t)commit_idx_pos_map_pos,
>> +  (uintmax_t)xor_offset_map_pos,
>> +  (uintmax_t)flag_map_pos,
>> +  (uintmax_t)ewah_bitmap_map_pos);
>=20
> Hmm. We print more information here than just the map_pos. This is
> brittle if the on-disk format changes (e.g., to store the XOR offsets =
in
> some other part of the bitmap). But hopefully future updates to the
> bitmap format will come with updates to this function as well ;-).
>=20
> It feels somewhat unsatisfying to print output like:
>=20
>    $COMMIT_OID <map_pos> <map_pos+4> <map_pos+5> <map_pos+6>
>=20
> , but I think it makes sense here for a couple of reasons:
>=20
> - If we just print the <map_pos>, then the test is responsible for
>   knowing the distance between that and the XOR offset, which extends
>   the brittleness to the test code
>=20
> - likewise, if we print out just the map_pos and the positions of the
>   XOR offset, it feels strange to omit the others.
>=20
>> diff --git a/pack-bitmap.h b/pack-bitmap.h
>> index 382d39499af2..96880ba3d72d 100644
>> --- a/pack-bitmap.h
>> +++ b/pack-bitmap.h
>> @@ -81,6 +81,7 @@ void traverse_bitmap_commit_list(struct =
bitmap_index *,
>> show_reachable_fn show_reachable);
>> void test_bitmap_walk(struct rev_info *revs);
>> int test_bitmap_commits(struct repository *r);
>> +int test_bitmap_commits_offset(struct repository *r);
>> int test_bitmap_hashes(struct repository *r);
>> int test_bitmap_pseudo_merges(struct repository *r);
>> int test_bitmap_pseudo_merge_commits(struct repository *r, uint32_t =
n);
>> diff --git a/t/helper/test-bitmap.c b/t/helper/test-bitmap.c
>> index 3f23f2107268..65a1ab29192b 100644
>> --- a/t/helper/test-bitmap.c
>> +++ b/t/helper/test-bitmap.c
>> @@ -10,6 +10,11 @@ static int bitmap_list_commits(void)
>> return test_bitmap_commits(the_repository);
>> }
>>=20
>> +static int bitmap_list_commits_offset(void)
>> +{
>> + return test_bitmap_commits_offset(the_repository);
>> +}
>> +
>> static int bitmap_dump_hashes(void)
>> {
>> return test_bitmap_hashes(the_repository);
>> @@ -36,6 +41,8 @@ int cmd__bitmap(int argc, const char **argv)
>>=20
>> if (argc =3D=3D 2 && !strcmp(argv[1], "list-commits"))
>> return bitmap_list_commits();
>> + if (argc =3D=3D 2 && !strcmp(argv[1], "list-commits-offset"))
>> + return bitmap_list_commits_offset();
>=20
> All of the scaffolding here looks good.
>=20
> This new mode reads a little awkwardly to me (but may not to others, =
in
> which case I am happy to back away from the following suggestion). Can
> we either call this 'list-commits-with-offset' or =
'list-commit-offsets'?
> I have a vague preference towards the former since the new mode has a
> string prefix matching the existing mode.
>=20
>> + test_expect_success 'load corrupt bitmap' '
>> + rm -fr repo &&
>> + git init repo &&
>> + test_when_finished "rm -fr repo" &&
>> + (
>> + cd repo &&
>> + git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>> +
>> + test_commit base &&
>> +
>> + git repack -adb &&
>> + bitmap=3D"$(ls .git/objects/pack/pack-*.bitmap)" &&
>> + chmod +w $bitmap &&
>> +
>> + read oid commit_off xor_off flag_off ewah_off <<-EOF &&
>> + $(test-tool bitmap list-commits-offset | head -n 1)
>=20
> We avoid putting 'git' or 'test-tool' on the left-hand side of a pipe,
> since we want to avoid squelching any errors / segfaults from our =
code.
>=20
> How about (assuming the rename above):
>=20
>    test-tool bitmap list-commit-offsets >offsets &&
>    xor_off=3D"$(head -n1 offsets | awk '{print $3}')" &&
>    ...
>=20
> ?
>=20
>> + printf '\161' |
>> + dd of=3D$bitmap count=3D1 bs=3D1 conv=3Dnotrunc seek=3D$xor_off &&
>> +
>> +
>> + git rev-list --count HEAD > expect &&
>> + git rev-list --use-bitmap-index --count HEAD > actual &&
>=20
> Using --count can mask failures in the bitmap code since it only =
guards
> you against getting the wrong number of objects, but doesn't guard you
> against getting the right amount of objects in a permuted order. I =
think
> we'd want just 'git rev-list --objects' here, but note that you have =
to
> use '--no-object-names' on the non-bitmap side, since rev-list does =
not
> print out paths when using bitmaps[^1].
>=20
> How about:
>=20
>    git rev-list --objects --no-object-names HEAD >expect.raw &&
>    git rev-list --objects --use-bitmap-index --no-object-names HEAD \
>> actual.raw &&
>=20
>    sort expect.raw >expect &&
>    sort actual.raw >actual &&
>=20
>    test_cmp expect actual
>=20
> (Note that you also have to sort the output here since rev-list does =
not
> output objects in a meaningful order when using bitmaps.)
>=20
> Thanks,
> Taylor
>=20
> [^1]: Not that it matters here since we don't expect to load the =
bitmap
>  anyway, but it's worth doing regardless.
>=20

Good advice, Thanks
Lidong=
