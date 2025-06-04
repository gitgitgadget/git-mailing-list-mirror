Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E8E320F
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 02:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749005489; cv=none; b=YbKFITI9veTrpF5EHTzSz2d7TvuMS36I0JMH6CO2/J8DF+r0qXCQNrguXAnBuz4gEGCya2VBK29CfTdZDmyZrIf6Z+AIEkEr6nv2KTfqrPwW5q6Jp2u7Yk5X1Q6ZpfRPEHDhRyz9TNeRArkSFhBwcv2u7baQsUmpXr3xNCSsgU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749005489; c=relaxed/simple;
	bh=juM5zjY/ESDe+3jIUb9kS/i0j3jMx/OC6VVUaxmsrhs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aunt7tADb9rFW5CeDayKWUSUDPzMNEpJ0ghlqtOev+inUpl7/xIZ9ILgZR2LwL3y+Wul6zLTxhLwpkLStNmwyH9COQP+ZTchWHLIg7YG94Pr9vvcUwpCUH7yhEDvzn38lSjefzutVULp/FbyJfxI7u7MnDjSQTyW0QIbrPvcWO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: esmtpsz20t1749005442t89c23ba1
X-QQ-Originating-IP: gBpkTkmU4SG+TnGoZSyZ6E5+Y48dcjF4LwMAl7PvmMk=
Received: from smtpclient.apple ( [202.119.42.243])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Jun 2025 10:50:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 9679745794594983293
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v4] pack-bitmap: remove checks before bitmap_free
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <aD9ylkFDWqapFjey@nand.local>
Date: Wed, 4 Jun 2025 10:50:30 +0800
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <04F52607-480F-41EC-ACBB-B335B238365F@smail.nju.edu.cn>
References: <pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
 <pull.1977.v4.git.git.1748931650166.gitgitgadget@gmail.com>
 <aD9ylkFDWqapFjey@nand.local>
To: Taylor Blau <me@ttaylorr.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OFWsfmE1GYcuYNBE7J2busoygclzU2E93yC2tLq6G4b9DXKXB49vylV/
	GoUg5C+mVtu3RBKIO7nhUcaz3x0lG/JU12EEBAuD6BORPuN4snjohrtEiqgFDHphve8Z3Z1
	+lpWry34EgsDiI9LyISX4wWnKjybQ3TBvLqHitUVs5IBWjSNNPkPsQGBzQAjU65/VBYUFG0
	zoUMKQv5HVBLkGPDKn0KfpA0w+Nj8zSTKmO1W8sNJxZDw82JpJ+T5NtdIWLHL2jVG0zxC9A
	p3X7/3CEMfLMPfw8XKyBwvXTGP96ijpfu6xmTmo3guBXdppv/31YB+Jg8kurhi+mMOifraa
	MPAUmBYkTY315xHVg5hBCEKEz+fmXY999gk+tVDKqkDwZLmPo7tg8kIPE0NWY/d3x3WAXLe
	Duweh9GnR1PleOXKMcHgh/slFFtnjT5zqf+TntHruWEB6VBLjjCmyhbRi//B+FQ3Y1VoUoB
	Ev7E7osUCsa681tDnbPUXfeYb9wrELMS5HOtZKlheA28rsTzH02povXs3OoxOcKGq3lEWZN
	qI4YCfR3FB8yFy5hzmemNsXq7B0yamxze1aNfhztMBUfM2lYCCNTVj1zXKlltjay44sP0Bc
	QsLjeIt/e+XAnZnnvX+d/XSdL8USAobHUcT+D6KK7Jrq4pcwQ8d5QpLnWyed2bK5oEdg5ZJ
	M4I7JRGgn94TjXzJMTC08I4LtSNFqut0lL0ypPSblhdaQ0QDi4/XFfGXso4lupg/N7wO8TS
	dacgx3D7iiikJJxA7GOPwrvzZiCfDpObFgrQbkToFNxKSm52gYWEohF2L7Wr5oHJwb1GfLO
	XNG7JSC4TuvJE/983S5Slumr6SxWkb+q+ejyt5teXK3EcrH66kk1SeTxRdiT2TlCitDdlAM
	6Dl4FCHZLecT4ibZUTjKP2kRHnMn8mF0aXx3SoYLxmdWTOV2sZiUO973qOGxla7n1zDFLYy
	bweW+2dy+ZTzsgMBKDcIMfIU1YdFyEaUUmcvBFJgi6V6CngF3G7aGPoqovWrpqK4t5L5RqW
	E3M7HTahUfrfdovSsfRPSTbkbUfV0=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0



> 2025=E5=B9=B46=E6=9C=884=E6=97=A5 06:09=EF=BC=8CTaylor Blau =
<me@ttaylorr.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Tue, Jun 03, 2025 at 06:20:49AM +0000, Lidong Yan via GitGitGadget =
wrote:
>> From: Lidong Yan <502024330056@smail.nju.edu.cn>
>>=20
>> In pack-bitmap.c:find_boundary_objects(), the roots_bitmap is only =
freed
>> if cascade_pseudo_merges_1() fails. Since cascade_pseudo_merges_1() =
only
>> use roots_bitmap as a mutable reference but not takes roots_bitmap's
>> ownership. Once cascade_pseudo_merges_1 succeed(), roots_bitmap =
leaks.
>> And this leak currently lacks a dedicated test to detect it.
>>=20
>> To fix this leak, remove if cascade_pseudo_merges_1() succeed check =
and
>> always calling bitmap_free(roots_bitmap);
>=20
> This sentence might be more clear if it were written as:
>=20
>    To fix this leak, unconditionally free the roots_bitmap regardless
>    of whether or not cascade_pseudo_merges_1() succeeds.
>=20
>> To trigger this leak, we need a pseudo-merge whose size is equal to
>> or smaller than roots_bitmap (which corresponds to the set of "haves"
>> commits in prepare_bitmap_walk()). To do this, we can create two
>> commits: A and B. Add A to the pseudo-merge list and perform a =
traversal
>> over the range A..B. In this scenario, the "haves" set will be {A},
>> and cascade_pseudo_merges_1() will succeed, thereby exposing the leak
>> due to the missing roots_bitmap cleanup.
>=20
> I don't think this is quite right. Calling cascade_pseudo_merges_1()
> succeeds (and returns a non-zero value) when one or more pseudo-merges
> are satisfied. A pseudo-merge is satisfied here when its parents =
bitmap
> is a *subset* of the roots_bitmap, not when it has a smaller size.
>=20
> The precise definition of one bitmap being a subset of another can be
> found in ewah/bitmap.c::ewah_bitamp_is_subset(). But in general one
> bitmap is a subset of the other if the set of bit positions with value
> "1" from one is a subset of the same set from the other bitmap.
>=20
> I think that's what you meant by "smaller", but I think it's worth
> clarifying here.

Yes, I want to say subset here, I will rewrite this part of comment.

>=20
>> diff --git a/pack-bitmap.c b/pack-bitmap.c
>> index ac6d62b980c..8727f316de9 100644
>> --- a/pack-bitmap.c
>> +++ b/pack-bitmap.c
>> @@ -1363,8 +1363,8 @@ static struct bitmap =
*find_boundary_objects(struct bitmap_index *bitmap_git,
>> bitmap_set(roots_bitmap, pos);
>> }
>>=20
>> - if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
>> - bitmap_free(roots_bitmap);
>> + cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
>> + bitmap_free(roots_bitmap);
>=20
> Makes sense.
>=20
>> diff --git a/t/t5333-pseudo-merge-bitmaps.sh =
b/t/t5333-pseudo-merge-bitmaps.sh
>> index 56674db562f..e665001a410 100755
>> --- a/t/t5333-pseudo-merge-bitmaps.sh
>> +++ b/t/t5333-pseudo-merge-bitmaps.sh
>> @@ -445,4 +445,24 @@ test_expect_success 'pseudo-merge closure' '
>> )
>> '
>>=20
>> +test_expect_success 'use pseudo-merge in boundary traversal' '
>> + git init pseudo-merge-boundary-traversal &&
>> + (
>> + cd pseudo-merge-boundary-traversal &&
>> +
>> + git config bitmapPseudoMerge.test.pattern refs/ &&
>> + git config bitmapPseudoMerge.test.threshold now &&
>=20
> Setting the unstable threshold here should be unnecessary, since the
> unstable portion of the group only includes matching commits beyond =
the
> threshold that *don't* already have a bitmap. Since "A" is the only
> commit at the time you write the bitmap below, it will always be
> selected, and thus never appear in the unstable portion of a
> pseudo-merge group.
>=20
>> + git config bitmapPseudoMerge.test.stableThreshold now &&
>=20
> This one is technically unnecessary, but only because test_commit =
starts
> at the $test_tick value, which is very far in the past (beyond the
> default value of 1.month.ago).

May be this is the time for me to re-read pseudo-merge documents.

>=20
>> + test_commit A &&
>> + git repack -adb &&
>> + test_commit B &&
>> +
>> + echo '1' >expect &&
>=20
> Please do not use single-quotes in a test script. It happens to work =
in
> this instance, but it is easy to break.

Got it.

>=20
>> + GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=3D1 \
>> + git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
>=20
> This test needs to use the boundary-based bitmap traversal routines, =
but
> I'm unclear on why you're using the GIT_TEST_-environment variable to
> enable them.

I don=E2=80=99t have a special reason to choose GIT_TEST rather than =
`git config`.
I just find in both way this test works so I use GIT_TEST. I will switch =
to `git config`.

> =20
> Is there a reason that we can't rely on the usual repository
> configuration here? I would have expected something like this (which
> should apply cleanly on top of your patch):
>=20
> --- 8< ---
> diff --git a/t/t5333-pseudo-merge-bitmaps.sh =
b/t/t5333-pseudo-merge-bitmaps.sh
> index e665001a41..491ef404ea 100755
> --- a/t/t5333-pseudo-merge-bitmaps.sh
> +++ b/t/t5333-pseudo-merge-bitmaps.sh
> @@ -453,14 +453,14 @@ test_expect_success 'use pseudo-merge in =
boundary traversal' '
> git config bitmapPseudoMerge.test.pattern refs/ &&
> git config bitmapPseudoMerge.test.threshold now &&
> git config bitmapPseudoMerge.test.stableThreshold now &&
> + git config pack.useBitmapBoundaryTraversal true &&
>=20
> test_commit A &&
> git repack -adb &&
> test_commit B &&
>=20
> - echo '1' >expect &&
> - GIT_TEST_PACK_USE_BITMAP_BOUNDARY_TRAVERSAL=3D1 \
> - git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
> + echo 1 >expect &&
> + git rev-list --count --use-bitmap-index HEAD~1..HEAD >actual &&
> test_cmp expect actual
> )
> '
> --- >8 ---
>=20
>> + test_cmp expect actual
>=20
> Hmm. I suppose, although it feels a little clunky to me to write
> something like "echo 1 >expect". I would imagine that you'd do =
something
> like:
>=20
>    test 1 -eq $(git rev-list --count --use-bitmap-index HEAD~1..HEAD)
>=20
> instead. Or if you wanted to split them off into separate lines, you
> could do:
>=20
>    nr=3D$(git rev-list --count --use-bitmap-index HEAD~1..HEAD) &&
>    test 1 -eq "$nr"
>=20

I like the latter one, I will use it in the next series.

Thanks,
Lidong

