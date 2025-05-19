Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6C1FA178
	for <git@vger.kernel.org>; Mon, 19 May 2025 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747641538; cv=none; b=AG2KrNDOSnzOgxCbPDUStfmBG9nACPcJ/A2Ece6V6JQHxi/gt4h490M6QT3uDKqkvwBr2N6oZRZ7vu9dpDncVx6YzcUgSnaUjG02UAkDaXw8dZS+D9Bs6DDNmwLN8EwXqEUuhf0fzJmEHr8BGsYVRDBUwHgkS7D5xE1x3R8bJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747641538; c=relaxed/simple;
	bh=TWDQY8m5odIMMJYaVDH12DFeV88lsnoqSXkc+b47pj0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=JSyEk/KiQbl5BnOBjXYTOynuNuZB6rQdfcXhmd2b1Fof7kJ5S8LY4lYMacosMUNiVcLkvSS8k+Of6UxMAO4Lrqx+QJEypIAmBAG+UZ6T2FyK04tWLLda8bOkk4Lu62Xpkti3fTcozRNB6UxYWxfYSOBfrVXFDKvUIF/g+AJWuvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz9t1747641506t08e0d5a9
X-QQ-Originating-IP: 0R6b+Lg7d6gX/+RlX0sLYVk0eCXm/nJJWGU7VQ83HwA=
Received: from smtpclient.apple ( [36.152.24.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 15:58:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10053264432567152335
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH] pack-bitmap: add loading corrupt bitmap_index test
From: lidongyan <502024330056@smail.nju.edu.cn>
In-Reply-To: <20250519073949.GD102701@coredump.intra.peff.net>
Date: Mon, 19 May 2025 15:58:14 +0800
Cc: Patrick Steinhardt <ps@pks.im>,
 Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4D908BBD-A930-49C4-B69D-E150ECE8597C@smail.nju.edu.cn>
References: <pull.1967.git.git.1747491983066.gitgitgadget@gmail.com>
 <aCrJcK6ml4r4S-mF@pks.im>
 <80BCF957-002B-4532-8E3D-8CAB45AC0349@smail.nju.edu.cn>
 <20250519073949.GD102701@coredump.intra.peff.net>
To: Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: N79g/BZ3s2bF1wB5IHwOeBCBmwI5XXPoEW+bEECrCyoL2omNZiOmnnVz
	1vLD395a/g1uGdf+492cKYwNkx4rGdugLZ5ohZg/TeypipSCaldv4uMiQm9k0eTaRdlAxC0
	ZDN8Jf4ex3hB7dJNBgImYjFd5XzNSWStM7yV3X2OPAxLIRuc8Knzf08fw90tBM/8Alb/2x+
	iUoE4EReL+gaUQZ31tfSQl6P7+edfp2S9QATPth41q0EWysLtJBGPhNt6bZdIjZAhQUfPMK
	HXyvDDS7SdPi+lxsUWbndutuJdT2qK/Y9nheQesQqWaXzBinfrQ1OBEhE4we3vfvqa2Kmp3
	RzHdnOe083lqKPml2W1JRMdLNpj3LQmgewUQ04efx5epRcTC61HT7f94dd2CDn3Ds441n0h
	aKIlDLV72wwwHekxCtJMlwwgAz0mlQmDVGKFCN1siICuSsXn3YULJVBebvwJhx6yyP8Z8NQ
	BSdU7ljjS7COQ3RQO/u0kX/hHDOUgkeUL6QPCUWZm1ca1ZrQXvZ/xPSwkxnB93gSd8gUaol
	ad4wVMGQ38IaLHvWyslcdk/SVCWJMAlMKRjLBVkJQ022SQU32s6SD2CsE3r+RO+d9GmtzFO
	cATyC6u0CuF0g7f7Ic2w3TuZ7q5Z3xe9eo1mGb/MsvY6KYH/AaoQrjVzfb5r43BvdSOcY8/
	4mAiFAkyPc6q43yr0ZjnrngLmF/sMTSOK1YDq8TEVoFMjaBAo+zlR2Yix7jwXHvJRcdvYjX
	zQJlCojXwr4We7f775nvjf/uSaWBV5Zsi48LvDEs4o5QKs+PCOPFZu5Gb8XHt6EFLugP+TL
	XYTInD/mZJo2dB+HV25t+QsTwVA77aRkN6uw02TV7yNJzQfxGd6VCuQstCpWvPuUJ5n8Ah4
	ViDeM5TjKrny1/Ss/kZwHNa5+TNJrtRssgKT0iDKxaGtkMBXRK5Ss/tOWO41bEtvdhmvAlj
	xrzhPrKFTFpqSJCwA6o1s926IRG3234LDtbY0l1PvelhWXP3JGkNOPwjxo65Q+WHXH5y9KC
	lsLiVIU/ZzGSwhzEe8
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

2025=E5=B9=B45=E6=9C=8819=E6=97=A5 15:39=EF=BC=8CJeff King =
<peff@peff.net> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> On Mon, May 19, 2025 at 02:44:22PM +0800, lidongyan wrote:
>=20
>> 2025=E5=B9=B45=E6=9C=8819=E6=97=A5 14:02=EF=BC=8CPatrick Steinhardt =
<ps@pks.im> =E5=86=99=E9=81=93=EF=BC=9A
>>> Okay. We _can_ do that now, but the patch doesn't explain why we
>>> _should_.
>>=20
>> The main purpose of this patch is to provide a test case to check =
whether
>> a memory leak occurs when loading a corrupt index file as requested =
here
>> =
https://lore.kernel.org/git/20250514180325.GB2196784@coredump.intra.peff.n=
et.
>> A potential memory leak is mentioned in this patch here =
https://lore.kernel.org/git/pull.1962.git.git.1747052530271.gitgitgadget@g=
mail.com/.
>=20
> I think we'd need to mark it with the !SANITIZE_LEAK prereq until the
> leaks are actually fixed. Or simpler, just apply this on top of the =
leak
> fixes once they are ready. That ordering needs to be communicated to =
the
> maintainer, and the simplest way to do that is probably to just post a
> 3-patch series: your initial leak fix, a polished version of the one
> from Taylor, and then the test on top.
>=20
>>> My proposal would be to either move the logic into "test-bitmap.c", =
or
>>> to even better to write a unit test in "t/unit-tests/". After all, =
we
>>> expect that the code should fail gracefully, so a unit test might be =
a
>>> good fit after all.
>>=20
>> I found that the header size of an index file depends only on the =
type of hash algorithm.
>> To trigger the condition for the memory leak, I need to corrupt a few =
bytes right after the
>> index file header size. It's more convenient to implement this =
functionality in pack-bitmap.c.
>> However, I think I can place the test itself under t/unit-tests/.
>=20
> I don't think you can do a prereq for a unit-test file (though I might
> be wrong, as I have not really paid attention to that area).
>=20
> If the corruption offsets are easy-ish to compute statically (and it
> sounds like they mostly just depend on the hash algorithm size), then
> I'd actually prefer to just do it with "dd". That avoids extra C code,
> and simulates a real on-disk corruption more exactly (using real
> commands).
>=20
> Something like:
>=20
> diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
> index 042f62f16e..16bd607654 100755
> --- a/t/t5310-pack-bitmaps.sh
> +++ b/t/t5310-pack-bitmaps.sh
> @@ -498,7 +498,17 @@ test_bitmap_cases () {
> git commit -am "add hello_world.txt" &&
>=20
> git repack -adb &&
> - test-tool bitmap load-corrupt
> + bitmap=3D$(ls .git/objects/pack/pack-*.bitmap) &&
> + chmod +w "$bitmap" &&
> +
> + # this matches the xor offset
> + offset=3D$((120 + $(test_oid rawsz))) &&
> + printf "\241" |
> + dd of=3D$bitmap count=3D1 bs=3D1 conv=3Dnotrunc seek=3D$offset &&
> +
> + git rev-list --count HEAD >expect &&
> + git rev-list --use-bitmap-index --count HEAD >actual &&
> + test_cmp expect actual
> )
> '
> }
>=20
> -Peff
>=20

Got it, using dd is indeed simpler and better. Thanks a lot!

