Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB7EEBB
	for <git@vger.kernel.org>; Sat, 11 Apr 2026 18:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775931959; cv=none; b=t9fQ8NEO21mQwgGs2Vzq8yCj2ppgee+BdGJc2nkVYfwzsaLB5J0ntyb1ouRI2FoxxpKGs6+JDBshctbdUcMYjO63sfX1v9aVoHT6Gha/C7OysV6Hwj6f0NczWTQTpEXWj95ehTuUh0znVdHSOdNcDgCZMxpNjk6d5PYGaz35P3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775931959; c=relaxed/simple;
	bh=FfYWplnxb1Ewan6k+SgEYlvV9/ekdZYEcrAtGGdbYSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MYhzfkgJuce3+U7IxYCfh9wy21ZItWI0sipUVI+2DjYQmaUq7JDekGIeN5eIeeeGluFFy11iTdq06FSgaDOwEVbxFAKJkqUEd7bTMyBkkLPyGvqPs9dtD/0BmwE7WbIYKm6rVTFBwW2nhW6Ty6JLIxhiiY8FcxzemFJ5Mk9nQUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=vvvFnYhV; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=2F9dnfBz; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="vvvFnYhV";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="2F9dnfBz"
DKIM-Signature: a=rsa-sha256; b=vvvFnYhVQzWXBrGCKwQNZQEYftcHrZUfomPpQSq3R9igog22KFhMmto/kHIihVbrdOLPs2QS57Ndn5DUDEWByundoI2Xxt6WkmE+ctTaT4tbdSah/IW+hwp1jFYh36yNRvuVIQCqXc+vLkP6SYoMnnvzSKJvtW+aZrY8u/vYIGmxpcyk6UpUSxxZIvWEDczfBhHvLBflyGlk2cc7j492kzxmTU2L+7pP/foM6+pIal/G45aKdUS6ULyxijRN3bizd/X9uwWKmDtKhFD/7joVYZse8j/nol7OGrJYLJ/BCtbdT/R4h4sP7MgrUQyA13b3va4QPLinIFnYdAFOkMFuQg==; s=purelymail3; d=malon.dev; v=1; bh=FfYWplnxb1Ewan6k+SgEYlvV9/ekdZYEcrAtGGdbYSw=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=2F9dnfBzcxIQNFeNxFWaI++Q90fpfUJZ1+fuY8XX4MosUZ7WjU3QyZTBLqlumXYZqOrOmkPlwLiSU5Pp/YakEoRrdp9qhZwdLIlsWa1G2shr42kJtzJshnplDEiu1beD1wnSB8A8mKTM2/Z8Qh0mkBXWIPS31kweZrNvsmUyq1M52C1Qu+KwEYIjiJmrrKefjRbU8f5bCXvc8szsNBLNttFXBUGi77WPp7Pr54U0P2KTKXDHJCLX1/lYqpeUwYJs8mnbWChsa1golZancPQpHKvu7DiNVqyZsCMScSWwDHJTgeqwMoCF7q5bNyH5hMBdrZurWMsDNUS2oSCUK9foLA==; s=purelymail3; d=purelymail.com; v=1; bh=FfYWplnxb1Ewan6k+SgEYlvV9/ekdZYEcrAtGGdbYSw=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 388746152;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 11 Apr 2026 18:25:55 +0000 (UTC)
Message-ID: <641a7a4c-f836-4811-bbeb-ef534716c3a9@malon.dev>
Date: Sun, 12 Apr 2026 02:25:50 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v5 3/6] repack-promisor: preserve content of promisor
 files after repack
To: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>, git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
 Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
 Eric Sunshine <sunshine@sunshineco.com>, Elijah Newren <newren@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <b483be7558f0efc1a6780b5cff13f4ccc3afd069.1775861047.git.lorenzo.pegorari2002@gmail.com>
Content-Language: en-US
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <b483be7558f0efc1a6780b5cff13f4ccc3afd069.1775861047.git.lorenzo.pegorari2002@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

On 4/11/26 06:55, LorenzoPegorari wrote:

> @@ -171,19 +172,15 @@ static void finish_repacking_promisor_objects(struc=
t repository *repo,
>  =20
>   =09=09/*
>   =09=09 * pack-objects creates the .pack and .idx files, but not the
> -=09=09 * .promisor file. Create the .promisor file, which is empty.
> -=09=09 *
> -=09=09 * NEEDSWORK: fetch-pack sometimes generates non-empty
> -=09=09 * .promisor files containing the ref names and associated
> -=09=09 * hashes at the point of generation of the corresponding
> -=09=09 * packfile, but this would not preserve their contents. Maybe
> -=09=09 * concatenate the contents of all .promisor files instead of
> -=09=09 * just creating a new empty file.
> +=09=09 * .promisor file. Create the .promisor file.
>   =09=09 */
>   =09=09promisor_name =3D mkpathdup("%s-%s.promisor", packtmp,
>   =09=09=09=09=09  line.buf);
>   =09=09write_promisor_file(promisor_name, NULL, 0);
>  =20
> +=09=09/* Now let's fill the content of the newly created .promisor file =
*/
> +=09=09copy_promisor_content(repo, line.buf, packtmp, not_repacked_basena=
mes);

Here, the file opened by copy_promisor_content() is an empty file. Is=20
this line necessary? ;)

...hold on. I recall you mentioning in one of the versions that you had=20
downgraded this helper from a generic function to a static one. Since it=20
now only serves this particular business logic, I think the=20
implementation should be tweaked slightly as well.

> +=09/* Open the .promisor dest file, and fill dest_content with its conte=
nt */
> +=09dest_promisor_name =3D mkpathdup("%s-%s.promisor", packtmp, dest_hex)=
;
> +=09dest =3D xfopen(dest_promisor_name, "r+");
> +=09while (strbuf_getline(&line, dest) !=3D EOF)
> +=09=09strset_add(&dest_content, line.buf);

If file contains a large number of unique lines, dest_to_write, which is=20
a strbuf, may keep realloc memory until the loop ends, at which point=20
all the memory is released. I wonder if this might be wasting some heap.

If it were me, I might write it like this:

=09struct strset seen_lines =3D STRSET_INIT;
=09dest =3D xfopen(dest_promisor_name, "w");
=09while (strbuf_getline(&line, source) !=3D EOF) {
     =09=09if (strset_add(&seen_lines, line.buf)) {
         =09=09fprintf(dest, "%s\n", line.buf);
     =09=09}=09
=09}

It also prevents file pointer misalignment.

(I think we still need to discuss what should ultimately become of this=20
helper; at the moment, it seems a bit disjointed, doesn=E2=80=99t it?)

Thank you, Yuchen



