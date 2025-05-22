Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48B28D8FF
	for <git@vger.kernel.org>; Thu, 22 May 2025 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747926405; cv=none; b=m8yKH32HH1/V/g6JEre9Yq93a7tT7lEdvGvBc9ElpcCwuK80ML1rkhALGP7vIA2Cx5zlTMyA5glmKw5EIvnYZHshv4lHyLekIixM7FIHAIC3ViuKaVQnygGBI3QRD65dp/fx4Ru6zDwDiB4LiGsBmDDRp2lSNKi+d8I/3W132EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747926405; c=relaxed/simple;
	bh=yuyE88C3l0AR5PWdjIuWCyr6i+K8IyYKLYUz1HbOyXo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=TvETJxP/245u0HSGRJt1acNXsj2RE+jK8eVIrLoIEGIikYtDCY/aFAT5A6KHc26hoTvSSoUPiFBC9S3Lo4ZKC/LKv/uCUrdNYptavQbKbAkETca68QF4nBawbUKZfjFvrCL62wJjIGpJV3eoRL6Bj61Ze3cKUZFrtdMqBOOcDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpsz4t1747926369ta246f6c8
X-QQ-Originating-IP: jcNEsxEQEEyr6wGZ4RGQrgHd2EjXF7foQxMRfu13COw=
Received: from smtpclient.apple ( [202.119.43.147])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 May 2025 23:06:07 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4525773156704214595
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH v2 3/3] pack-bitmap: add loading corrupt bitmap_index test
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aC5rCRJd3GaTNgL5@nand.local>
Date: Thu, 22 May 2025 23:05:56 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <013153DA-8314-429B-8408-9A79A3304013@smail.nju.edu.cn>
References: <pull.1962.git.git.1747052530271.gitgitgadget@gmail.com>
 <pull.1962.v2.git.git.1747732991.gitgitgadget@gmail.com>
 <5be22d563af714ebb902506f12b4468a5348896c.1747732991.git.gitgitgadget@gmail.com>
 <aC5rCRJd3GaTNgL5@nand.local>
To: Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MwQdfXoP8nuzPsqBn2JB5YPEobAAM9x8toi1ifDW+ivURLsFCo4KovyC
	BzzXnhCpXbb/p2SLktjBHrc+eRrMLR88z75wCFEz+/CoUi8rXaQrho3oOPR14go79vcg3f3
	bqTQld4Eg6Dtz6ybhSHbUibDg49mgkG6EWcSHw4NIZNz0CxafP4zFBIl5OgNtH2Y2I671g4
	C4IA6UA+izwfYkVwwez1c7gfX4+lh4VJbA3mWtPEhHTHD150/AAvQMLnPWzTpfd+Qi5rF9+
	sGTDa6J1gy5BP1JZGbYOYrPXt0/ZPq93E0G00CNbdW0tr2YxlD9doZA2GpZfm/BmBhH7VqP
	PIrLmEFg8wyxsxJSRzwpsFMksfhvDVZSe3cqkzJAEM2XmSTNuNlgyJX9EFQQ7GD+4JKkwIr
	ZdzI5PCKlgsX3akK33rxwFlTaSbYMcYwp4s3tsb3fZTw1WQ1IrKH0VAqMWDQPFjMINx2GcD
	CQczLjX6JssIDlcp1S5afTHpi9JyCvLY1AwDJ44zpn6Ci3PQxHIjsY7awLWL6vB7UamW+be
	ygrtoJ10WvMdeIBA32XgQNyaE1YxXwRjiWofLNvbD/GdmogAEECg5iCVJaRODhqugI2EWRi
	58Z8+f18tigJ3sDU6KHJx79guIm1OfVodxg/h5fGUPErltHZcx0sEkz+/jZRZtH59pvaX+1
	pvkk0fVL+Cvckk5AT//AGlB7hO+GtHA7KW9Zg8T2DetmTiOkdnAj6AyR6aoBKgLh1kXnZzi
	Gi/+gGgEZAoEjSf6Vu5aXjjuWX0JtLZo+G8tSPXbIGYuxrqWzBgZEkqz2OsY6/o1/vJl8EJ
	w3oL2aqA7P7mbVrAdsAz/Xz1dBgKWs7ZnKzAno9zOrWdc7Zcc7pYee9KV02Y4kFNr9zCHWK
	FC/Yukcen0sqNCHt+az6gCaBr1bDkN5xY1VUcQDh3i4ek1ZB1eeBImMmroKKgJ+kwYx7Y7U
	NQJw45+zTBkkL5HEk8dy5jS8uYD1Di/x2/SmE62KkPdXwvB107MUXJX4Jr1FVFepA9hVMbV
	kBRfBf0w==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8822=E6=97=A5 08:08=EF=BC=8CTaylor Blau =
<me@ttaylorr.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, May 20, 2025 at 09:23:10AM +0000, Lidong Yan via GitGitGadget =
wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> This patch add "load corrupt bitmap" test case in =
t5310-pack-bitmaps.sh.
>>=20
>> This test case intentionally corrupt the "xor_offset" field of the =
first
>> entry. To find position of first entry in *.bitmap, we need to skip 4
>> ewah_bitmaps before entries. And I add a function =
`skip_ewah_bitmap()`
>> to do this.
>=20
> I'm going to avoid commenting on the message itself, since I think we
> may be able to drop this patch entirely, see below.
>=20
>> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
>> ---
>> t/t5310-pack-bitmaps.sh | 50 =
+++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 50 insertions(+)
>>=20
>> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
>> index a62b463eaf09..537a507957bb 100755
>> --- a/t/t5310-pack-bitmaps.sh
>> +++ b/t/t5310-pack-bitmaps.sh
>> @@ -26,6 +26,18 @@ has_any () {
>> grep -Ff "$1" "$2"
>> }
>>=20
>> +skip_ewah_bitmap() {
>> + local bitmap=3D"$1" &&
>> + local offset=3D"$2" &&
>> + local size=3D &&
>> +
>> + offset=3D$(($offset + 4)) &&
>> + size=3D0x$(od -An -v -t x1 -j $offset -N 4 $bitmap | tr -d ' \n') =
&&
>> + size=3D$(($size * 8)) &&
>> + offset=3D$(($offset + 4 + $size + 4)) &&
>> + echo $offset
>> +}
>> +
>> # Since name-hash values are stored in the .bitmap files, add a test
>> # that checks that the name-hash calculations are stable across =
versions.
>> # Not exhaustive, but these hashing algorithms would be hard to =
change
>> @@ -486,6 +498,44 @@ test_bitmap_cases () {
>> grep "ignoring extra bitmap" trace2.txt
>> )
>> '
>> +
>> + # A `.bitmap` file has the following structure:
>> + # | Header | Commits | Trees | Blobs | Tags | Entries... |
>> + #
>> + # - The header is 32 bytes long when using SHA-1.
>> + # - Commits, Trees, Blobs, and Tags are all stored as EWAH bitmaps.
>> + #
>> + # This test intentionally corrupts the `xor_offset` field of the =
first entry
>> + # to verify robustness against malformed bitmap data.
>> + test_expect_success 'load corrupt bitmap' '
>=20
> I am not totally following what this case is supposed to be testing.
> Let me think aloud for a moment...
>=20
>> + rm -fr repo &&
>> + git init repo &&
>> + test_when_finished "rm -fr repo" &&
>> + (
>> + cd repo &&
>> + git config pack.writeBitmapLookupTable '"$writeLookupTable"' &&
>=20
> First we set up a temporary repository, change into it, and enable
> bitmap lookup tables. Makes sense.
>=20
>> + test_commit base &&
>> +
>> + git repack -adb &&
>> + bitmap=3D"$(ls .git/objects/pack/pack-*.bitmap)" &&
>> + chmod +w "$bitmap" &&
>=20
> Then we make a commit, and write a bitmap containing the objects from
> the commit we just made. Good.
>=20
>> + hdr_sz=3D$((12 + $(test_oid rawsz))) &&
>> + offset=3D$(skip_ewah_bitmap $bitmap $hdr_sz) &&
>> + offset=3D$(skip_ewah_bitmap $bitmap $offset) &&
>> + offset=3D$(skip_ewah_bitmap $bitmap $offset) &&
>> + offset=3D$(skip_ewah_bitmap $bitmap $offset) &&
>=20
> Then we read past the header and four type bitmaps. Makes sense.
>=20
>> + offset=3D$((offset + 4)) &&
>=20
> Now we land at the bitmap for the commit we just wrote.
>=20
> (As an aside unrelated to this part of the test, this =
skip_ewah_bitmap()
> function seems awfully fragile. I wonder if it would make more sense =
to
> implement this as a test helper that can dump the offsets of EWAH
> bitmaps in a *.bitmap file by object ID rather than trying to parse =
the
> file ourselves?
>=20

I am actually replaying the pack-bitmap.c:prepare_bitmap() here. Also I =
have had
write a test helper version once. And since I want to use =
prepare_bitmap()
I have to put the code in pack-bitmap.c. It looks like this

diff --git a/pack-bitmap.c b/pack-bitmap.c
index b9f1d866046..9642a06b3fe 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3022,6 +3022,71 @@ cleanup:
return ret;
}

+typedef void(corrupt_fn)(struct bitmap_index *);
+
+static int bitmap_corrupt_then_load(struct repository *r, corrupt_fn =
*do_corrupt)
+{
+ struct bitmap_index *bitmap_git;
+ unsigned char *map;
+
+ if (!(bitmap_git =3D prepare_bitmap_git(r)))
+     die(_("failed to prepare bitmap indexes"));
+ /*
+  * If the table lookup extension is not used,
+  * prepare_bitmap_git has already called load_bitmap_entries_v1(),
+  * making it impossible to corrupt the bitmap.
+  */
+ if (!bitmap_git->table_lookup)
+     return 0;
+
+ /*
+  * bitmap_git->map is read-only;
+  * to corrupt it, we need a writable memory block.
+  */
+ map =3D bitmap_git->map;
+ bitmap_git->map =3D xmalloc(bitmap_git->map_size);
+ if (!bitmap_git->map)
+     return 0;
+ memcpy(bitmap_git->map, map, bitmap_git->map_size);
+
+ do_corrupt(bitmap_git);
+ if (!load_bitmap_entries_v1(bitmap_git))
+     die(_("load corrupt bitmap successfully"));
+
+ free(bitmap_git->map);
+ bitmap_git->map =3D map;
+ free_bitmap_index(bitmap_git);
+
+ return 0;
+}
+
+static void do_corrupt_commit_pos(struct bitmap_index *bitmap_git)
+{
+ uint32_t *commit_pos_ptr;
+
+ commit_pos_ptr =3D (uint32_t *)(bitmap_git->map + =
bitmap_git->map_pos);
+ *commit_pos_ptr =3D (uint32_t)-1;
+}
+
+static void do_corrupt_xor_offset(struct bitmap_index *bitmap_git)
+{
+ uint8_t *xor_offset_ptr;
+
+ xor_offset_ptr =3D (uint8_t *)(bitmap_git->map + bitmap_git->map_pos +
+      sizeof(uint32_t));
+ *xor_offset_ptr =3D MAX_XOR_OFFSET + 1;
+}
+
+int test_bitmap_load_corrupt(struct repository *r)
+{
+ int res =3D 0;
+ if ((res =3D bitmap_corrupt_then_load(r, do_corrupt_commit_pos)))
+     return res;
+ if ((res =3D bitmap_corrupt_then_load(r, do_corrupt_xor_offset)))
+     return res;
+ return res;
+}
+
int rebuild_bitmap(const uint32_t *reposition,
   struct ewah_bitmap *source,
   struct bitmap *dest)

> We don't currently store an offset for each stored_bitmap that we
> maintain, but doing so would be pretty straightforward (add it as a
> field to the structure, and store the value of bitmap_git->map_pos =
from
> immediately before reading the actual bitmap).)
>=20
>> + printf '\161' |
>> + dd of=3D$bitmap count=3D1 bs=3D1 conv=3Dnotrunc seek=3D$offset &&
>=20
> OK. Now we break the XOR offset field of this bitmap by writing =
garbage
> into it.
>=20
>> + git rev-list --count HEAD > expect &&
>> + git rev-list --use-bitmap-index --count HEAD > actual &&
>> + test_cmp expect actual
>=20
> ...and then we make sure that we still get the correct result.
>=20
> Hmmph. I don't think this is quite testing what we want, since this =
test
> passes with or without your first patch. And that makes sense, we have
> tests elsewhere in this script that verify we can still fall back to
> classic traversal when the bitmap index can't be read. (For some
> examples, see: "truncated bitmap fails gracefully (ewah)" and =
"truncated
> bitmap fails gracefully (cache)".)

I want to *test* for a memory leak here, not whether git can load a =
corrupt bitmap.
Since git ci linux-leak test runs each test script with =
ASAN_OPTIONS=3Ddetect_leaks=3D1, I=E2=80=99m=20
including this test case specifically to check whether it triggers a =
crash when=20
`SANITIZE_LEAK` is enabled. And I do find if without the first patch, =
leak sanitizer
running this test script would output error message.

> I think what we're really testing here is the absence of a memory =
leak,
> which we are as of 1fc7ddf35b (test-lib: unconditionally enable leak
> checking, 2024-11-20). I wonder whether or not we need this test at =
all?
>=20
> Thanks,
> Taylor

I am not truly following what are you talking here. But If you think =
it=E2=80=99s unnecessary to
check for potential leaks in load_bitmap() or load_bitmap_entries_v1(). =
Or this test
script shouldn=E2=80=99t be put in this way. I=E2=80=99m happy to drop =
the final patch.

Thanks
Lidong Yan=
