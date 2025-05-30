Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD26254652
	for <git@vger.kernel.org>; Fri, 30 May 2025 03:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748577286; cv=none; b=BeIJqL1jXciAMUNK2xwJXuC1WLqdA4pBrut3EnBZ15FJ6uG1Onn9D55GBauzWoKa5xxqDWzbGwIpzmGFDoSrySzvmWokl4iZFXSG0rSnmbBzIEtx63ZEwd4aFoYP+GKvJ1Qeu141aWpcTwDPWerQLGU6XXvpPQUWgg51UfCvn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748577286; c=relaxed/simple;
	bh=+oV24ly3ObB7RlNKCyYBiKHIJOEocDdvYL1HnXL+6kI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cZfXTbMU8D6JGwJkdCLUGmkogBjBx8yC4EuEEYC0DZsfQyu1meaDdlq9rtaow3+YNfcqbinNXCk+EeDMlrtlpz8H7kDRAK/a5Wby2/sdm7ldo+TToICdwGuPQG9Hhmwy8CLiEtEI7zTorEdI6fOsvyILFTb0NlPUPH4JQ0cXxI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz19t1748577247teb3fa892
X-QQ-Originating-IP: xilFxcNi3ls/NH1OqBrewdIOZJ/Tzf+/I2qjm3RiLlA=
Received: from smtpclient.apple ( [36.152.24.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 30 May 2025 11:54:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3561031691818814969
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
In-Reply-To: <xmqqbjrbmndn.fsf@gitster.g>
Date: Fri, 30 May 2025 11:53:55 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Jeff King <peff@peff.net>,
 Taylor Blau <me@ttaylorr.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <B77763AE-316A-405A-B11F-C08CB44A734B@smail.nju.edu.cn>
References: <pull.1962.v3.git.git.1748138764.gitgitgadget@gmail.com>
 <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
 <7876d9a9014ea6a0657f440f7fa1efd496a4a15a.1748140983.git.gitgitgadget@gmail.com>
 <xmqqbjrbmndn.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OLsBWtCIHsg6DZGTzFlLB/eAnMdvQcwKAZ4AjHQgd7HZiaACiFWV9ytO
	o8rOvo0nn5EQIcP+LiuxJ2gWdSrEk18NeZrQSzNKMsn3u6PTn/12i1lextZDSlNpU37ib7T
	aZBd/6ZTs3CU/3FCVjTNtCGc/8Gjr3UW6uDZwHefbfOystkjFtT75EeH3/5ptsHbgCzCIY+
	riNIKiU5LRHBt2x5BTEznEuciWalxf1qUda5N18HPnLFN2w/bozIxN/+UrCAz1YqA2FiH99
	4+yoxy9/ZZ791MAEecdN2sdOK9jPLQ/AZ2NM5UkiXnF3zDScjtvQ7RsvXbd242f+Nx8cS2q
	uwfOUenY24ZrXPVDo27mAg1Tnv1ZbWBMOCuTUrGsnCIka0Bj6/eZ3gjpGd325P/nuwS7g4i
	sOg0IpPtAy3AP5Xl7k1iJEwb5kUpYvco1oOO/4wtj5QeaVXcdyH36I7pkNJVA3qbOmDOu1n
	pVeY3wbsG6DqitjFcZ9NPRrO0j4bQHoKMPQQnixg3Nbk+aJQaWWOslYQl2vkFlyH3x1gfQO
	8m/AQvOIH783Ne5UD/JAtX3SHvFI8+XBWXi9Jh+LWrxMUXbYz7xxXCwh+paExoj1qctrXF/
	oVKP36wYIZM5rlPv1BJcRmjQev+Mo8z644sRmKf1eHmlPWLV4g/UceeqQfCs/n6swLAmfAq
	L4pjGChm0QDAfC64sKvqveP0I5PdN94oAheyF4IQtEQ3RmC9mvQZkjptk3YxQDLXfE3PFfW
	mJglA4X7feHqSvFhmsjgVQGd1MUwzDxgZ+MWqxqAgsIB4x2LSpruVwfb2a4UvEPPFPCBFM0
	915e8HMbB8lf96k1Uf1iJh/U626LL6c0UicRDI5X59NOSU5/RHJtYTcsXD3Z2yfZJi1B1Hf
	ojp/Q+T3D79LKnq2YIUxvYSD2yPwUclJfPSusdpLhpdXDIazdC0Sy8WI9Jft9Tl8bRXs1mm
	FVJdqBwgHc6uwFc1ZKEZAmWTM9FNhFB+FAEDv4cXC4Gm+lv3e7yaXrDCcYNi9HHjrcBUCcg
	YRJVh1ffG2d9lyNsNVmYDO0H6uBZg=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B45=E6=9C=8829=E6=97=A5 23:45=EF=BC=8CJunio C Hamano =
<gitster@pobox.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> This patch add test_bitmap_list_commits_offset() in patch-bitmap.c,
>=20
> "pack-bitmap.c"?
>=20
>> a new test helper command `test-tool bitmap list-commits-offset`,
>> and a `load corrupt bitmap` test case in t5310.
>>=20
>> The `load corrupt bitmap` test case intentionally corrupt the
>> "xor_offset" field of the first entry. And the newly added helper
>> can help to find position of "xor_offset" in bitmap file.
>=20
> [the structure of a log message]
>=20
> The usual way to compose a log message of this project is to
>=20
> - Give an observation on how the current system works in the
>   present tense (so no need to say "Currently X is Y", or
>   "Previously X was Y" to describe the state before your change;
>   just "X is Y" is enough), and discuss what you perceive as a
>   problem in it.
>=20
> - Propose a solution (optional---often, problem description
>   trivially leads to an obvious solution in reader's minds).
>=20
> - Give commands to somebody editing the codebase to "make it so".
>=20
> in this order.
>=20
> The proposed log message lacks the motivation and only talks about
> what the patch does.  We add a test-only code in a file, intermixed
> with production code.  Let's explain why it is the best arrangement.

I see. I am trying to validate these patch series and test further patch =
won=E2=80=99t leak
memory under the condition that bitmap is corrupted, Anyway I will pay =
attention
to motivation in my following log messages.

>=20
>> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
>> ---
>> pack-bitmap.c           | 73 =
+++++++++++++++++++++++++++++++++++++----
>> pack-bitmap.h           |  1 +
>> t/helper/test-bitmap.c  |  8 +++++
>> t/t5310-pack-bitmaps.sh | 27 +++++++++++++++
>> 4 files changed, 103 insertions(+), 6 deletions(-)
>=20
> After the second round of the series, no review comments seem to
> have been sent to the list.  Is everybody happy with the latest
> iteration?
>=20
> Thanks.
>=20
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
>> commit_idx_pos =3D read_be32(index->map, &index->map_pos);
>> xor_offset =3D read_u8(index->map, &index->map_pos);
>> flags =3D read_u8(index->map, &index->map_pos);
>> @@ -402,8 +415,9 @@ static int load_bitmap_entries_v1(struct =
bitmap_index *index)
>> if (!bitmap)
>> return -1;
>>=20
>> - recent_bitmaps[i % MAX_XOR_OFFSET] =3D store_bitmap(
>> - index, bitmap, &oid, xor_bitmap, flags);
>> + recent_bitmaps[i % MAX_XOR_OFFSET] =3D
>> + store_bitmap(index, bitmap, &oid, xor_bitmap, flags,
>> +     entry_map_pos);
>> }
>>=20
>> return 0;
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
>> bitmap_git->map_pos +=3D sizeof(uint32_t) + sizeof(uint8_t);
>> xor_flags =3D read_u8(bitmap_git->map, &bitmap_git->map_pos);
>> bitmap =3D read_bitmap_1(bitmap_git);
>> @@ -935,7 +951,8 @@ static struct stored_bitmap =
*lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>> if (!bitmap)
>> goto corrupt;
>>=20
>> - xor_bitmap =3D store_bitmap(bitmap_git, bitmap, &xor_item->oid, =
xor_bitmap, xor_flags);
>> + xor_bitmap =3D store_bitmap(bitmap_git, bitmap, &xor_item->oid,
>> +  xor_bitmap, xor_flags, entry_map_pos);
>> xor_items_nr--;
>> }
>>=20
>> @@ -969,6 +986,7 @@ static struct stored_bitmap =
*lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>> * Instead, we can skip ahead and immediately read the flags and
>> * ewah bitmap.
>> */
>> + entry_map_pos =3D bitmap_git->map_pos;
>> bitmap_git->map_pos +=3D sizeof(uint32_t) + sizeof(uint8_t);
>> flags =3D read_u8(bitmap_git->map, &bitmap_git->map_pos);
>> bitmap =3D read_bitmap_1(bitmap_git);
>> @@ -976,7 +994,8 @@ static struct stored_bitmap =
*lazy_bitmap_for_commit(struct bitmap_index *bitmap_
>> if (!bitmap)
>> goto corrupt;
>>=20
>> - return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags);
>> + return store_bitmap(bitmap_git, bitmap, oid, xor_bitmap, flags,
>> +    entry_map_pos);
>>=20
>> corrupt:
>> free(xor_items);
>> @@ -2856,6 +2875,48 @@ int test_bitmap_commits(struct repository *r)
>> return 0;
>> }
>>=20
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
>> + /*
>> + * As this function is only used to print bitmap selected
>> + * commits, we don't have to read the commit table.
>> + */
>> + if (bitmap_git->table_lookup) {
>> + if (load_bitmap_entries_v1(bitmap_git) < 0)
>> + die(_("failed to load bitmap indexes"));
>> + }
>> +
>> + kh_foreach (bitmap_git->bitmaps, oid, tagged, {
>> + commit_idx_pos_map_pos =3D tagged->map_pos;
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
>> + })
>> + ;
>> +
>> + free_bitmap_index(bitmap_git);
>> +
>> + return 0;
>> +}
>> +
>> int test_bitmap_hashes(struct repository *r)
>> {
>> struct bitmap_index *bitmap_git =3D prepare_bitmap_git(r);
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
>> if (argc =3D=3D 2 && !strcmp(argv[1], "dump-hashes"))
>> return bitmap_dump_hashes();
>> if (argc =3D=3D 2 && !strcmp(argv[1], "dump-pseudo-merges"))
>> @@ -46,6 +53,7 @@ int cmd__bitmap(int argc, const char **argv)
>> return bitmap_dump_pseudo_merge_objects(atoi(argv[2]));
>>=20
>> usage("\ttest-tool bitmap list-commits\n"
>> +      "\ttest-tool bitmap list-commits-offset\n"
>>      "\ttest-tool bitmap dump-hashes\n"
>>      "\ttest-tool bitmap dump-pseudo-merges\n"
>>      "\ttest-tool bitmap dump-pseudo-merge-commits <n>\n"
>> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
>> index a62b463eaf09..ef4c5fbaae83 100755
>> --- a/t/t5310-pack-bitmaps.sh
>> +++ b/t/t5310-pack-bitmaps.sh
>> @@ -486,6 +486,33 @@ test_bitmap_cases () {
>> grep "ignoring extra bitmap" trace2.txt
>> )
>> '
>> +
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
>> + EOF
>> + printf '\161' |
>> + dd of=3D$bitmap count=3D1 bs=3D1 conv=3Dnotrunc seek=3D$xor_off &&
>> +
>> +
>> + git rev-list --count HEAD > expect &&
>> + git rev-list --use-bitmap-index --count HEAD > actual &&
>> + test_cmp expect actual
>> + )
>> + '
>> }
>>=20
>> test_bitmap_cases
>=20

