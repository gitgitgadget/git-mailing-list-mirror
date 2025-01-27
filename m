Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5302155756
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737995835; cv=none; b=nmZjQyK+bLBggVO2nBj+2SU7Xty30rnZ90FbrktrFnB+0EyEqPKbliFZ0FrJHiA4cZD7v5WwI9kwTx86DYZXOCQF3G/CFtOdZQhSL3QzxmK5sIY870V32fJlqHbeZTjMtIb5PJmUCS0k7HzFCuuDqVcSErJ+FFkbh3xxtEkGV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737995835; c=relaxed/simple;
	bh=QRsK8BpAeYXjlINOx9q30O0vmICgXd8CpEyGe+rTQqU=;
	h=MIME-version:Content-type:Date:Message-id:From:Subject:Cc:To:
	 References:In-reply-to; b=k1+qKy+8iZnoIzfTLXVx8tO9EyuNEvocVNek+2lnSaaGtLNpUa6Er82Rt7RUFHylcTqob9GTVHT2y8OmBoMw2DB9xRHZ2MYH3VvRTPuNaHRocFrZEek99MQqweISRDZpF3U9QtVVPYQaKeTcsKxaQrbWd6iu/2z+PPvrmAFF7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=pMSnzHj5; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="pMSnzHj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=0yhCnDh7Rp7VC1ZrMjrglNLj2nGUr8i1meQX8J26b6w=;
 b=pMSnzHj5UoivwcutLcJukfQiVudlC0aSKRDoe0fTFdBuHm8j+uHTgXU0GK527nG6j0xXsFmFblF0
   0UpNxs43JaFftybMLkj8eVqy33nC+llJwoH3BY6OaiVNjeDJzgUDzXItNr+oabavUAyjqiGMbil7
   mEsl20l77UHFoQC4Cr5FtI1epe0azunTWpBWNoqoeAozcLgJxSzUd3Sa9OtwrRErzm/wSkdzhflu
   0QHfV9gHaY13VhCL+KJxyUy22mLrn/bZpl2ICQqBHzwTaLOGK7zgF2HBgnZxo/C28GBtA4E6eh8v
   lsK9LTVprD1kZlufYwlkzaiFjnE3K+1gGMvO6A==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SQR00NYGA5VJS70@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Mon, 27 Jan 2025 16:37:07 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Mon, 27 Jan 2025 17:36:17 +0100
Message-id: <D7D031QT4HEX.14TRNKRC6FC7S@ferdinandy.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: Git 2.48. Changed behavior of the git fetch
Cc: <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
 "Jonathan Tan" <jonathantanmy@google.com>
To: "Danila Manturov" <danila.manturov@jetbrains.com>
References:
 <CAM6buW5KSDGHD7txroqVa0TN_Ou_eV-LocMy06cPy0ZGDQmY9A@mail.gmail.com>
 <D6ZXVILR1D36.3W0QVQCVE1P2J@ferdinandy.com>
 <CAM6buW6NbdZ6wLGP6LWePiA7n0At=jxxqtBEUv0fTY6mOdTmyw@mail.gmail.com>
 <D705W1554XJ9.30SRYLNGNOX4@ferdinandy.com>
 <CAM6buW77CeuKfr3b4SUbYyFaU1OTvRsYBjPBE05YMzJo36bGdw@mail.gmail.com>
 <D706LPHBPUL4.3LN27T1UG1FI2@ferdinandy.com>
 <CAM6buW4UiCs9pFeH0cxxdhLHCSNO9wLVz9_p4Y0u8LaGWy--ng@mail.gmail.com>
 <D712LKI48ZUD.2UK8FX0YZBEYM@ferdinandy.com>
 <CAM6buW4e4c_3BgPo_GU64Fvi7XGcP7tuxdaap1LypyFCOZvZEw@mail.gmail.com>
 <D7CEDCJ0KKYL.YS0EWVFCN72X@ferdinandy.com>
In-reply-to: <D7CEDCJ0KKYL.YS0EWVFCN72X@ferdinandy.com>
Reporting-Meta:
 AAH4gv0+gOAkKmKgW3Bm/CEyrdFz4afZcyiuQ2B5fijYjnfX3uPi7Ujsb6GIMJ4w
 KCzS/M6Y6LW+v01+S9h5J4Hc5AB7tvNFfKWbrGs0i5wySbRe6TfPO3YKoUcrSWOx
 H1bbq0YJH+5wkhuHosWTiTwhWVmuvREUBSrDqYhcgqgsxUpUrSpdYVE4F57E6tyA
 OGGGpAWJ8rJdADKJEYnmgpSDX8gLVf+76oouPJyj6tQak+SpmVwHaqYi42bFC5DT
 GpYWY9ATlS046Ihqrb2PrPhZiNTxAMZHI1BO0VhwKjQFFxQcXN7DMxiQR+zbZUAe
 OYUs0D6Vk+AbK+z3KzOp5jg3f7moQMJf7WXyy8Ciy69G8ET0b1dnSPlkGumZ/55F
 ZM9S+EjYuOb0cg4rTIFmUxTV0vmDLeOAlQPp/D/5bwEowND3qs2YUZBbf4OsHRLa
 9jfBPs5g9aQGkhlOfr8TzO8l04rscgEF/bPq5ChSzzXqCc9pQc7ulck5


On Mon Jan 27, 2025 at 00:35, Bence Ferdinandy <bence@ferdinandy.com> wrote=
:
>
> On Tue Jan 21, 2025 at 18:26, Danila Manturov <danila.manturov@jetbrains.=
com> wrote:
>> Hello. I have done some experiments. For some reason, it works
>> correctly with JSch. With native ssh/https it doesn't work
>>
>> On Mon, Jan 13, 2025 at 5:03=E2=80=AFPM Bence Ferdinandy <bence@ferdinan=
dy.com> wrote:
>>>
>>>
>>> On Mon Jan 13, 2025 at 15:14, Danila Manturov <danila.manturov@jetbrain=
s.com> wrote:
>>> > According to our CI, the first commit where the bug occurs is
>>> > 5f212684abb66c9604e745a2296af8c4bb99961c
>>>
>>> That makes sense, what is more interesting is why the fix Junio wrote l=
ater
>>> doesn't work in this case ... I didn't have time to dig yet.
>>>
>>>
>
> I looked up the original thread leading to 6c915c3f85 (fetch: do not ask =
for
> HEAD unnecessarily, 2024-12-06) by Junio, which fixed a similar issue (se=
e
> https://lore.kernel.org/git/444kgiknevb3kwtypjjc2glryaav27t5fafgyzqq5257w=
7o4pf@4fngcyfmvfcp/T/#u).
>
> Originally Josh there suggested just changing the order of adding tags la=
ter to
> the prefixes should solve the issue. I don't think we ever actually figur=
ed out
> why the order of the prefixes should matter, and Junio's patch solved tha=
t
> particular problem by just not asking for HEAD in that case, but it seems=
 that
> the current problem can also be solved by swapping the order of tags and =
HEAD.

I had a little bit of time to investigate.

This is the place of interest in builtin/fetch.h:1771-1781=20

	if (tags =3D=3D TAGS_SET || tags =3D=3D TAGS_DEFAULT) {
		must_list_refs =3D 1;
		if (transport_ls_refs_options.ref_prefixes.nr)
			strvec_push(&transport_ls_refs_options.ref_prefixes,
				    "refs/tags/");
	}

	if (uses_remote_tracking(transport, rs)) {
		must_list_refs =3D 1;
		strvec_push(&transport_ls_refs_options.ref_prefixes, "HEAD");
	}


If `transport_ls_refs_options.ref_prefixes` is empty we fetch tags. If
`transport_ls_refs_options.ref_prefixes` is not empty, we fetch what is in =
this
`ref_prefixes`. The current code checks if we have anything in ref_prefixes
before adding tags to ref_prefixes and only adds tags if `ref_prefixes` is =
not
empty. So currently, since we always add HEAD to `ref_prefixes` it is never
empty later down the line, but for this case, it is empty when we get to
checking the TAG conditions. This is why switching the order works, because
then `ref_prefixes` is not empty and tags are explicitly appended.

This checking for non-empty `ref_prefixes` seems to have been added here by=
 Jonathan:

e70a3030e7 (fetch: do not list refs if fetching only hashes, 2018-09-27)

What is not quite clear to me, is that it looks like that the original
intention was to pretty much always fetch tags, yet it was not achieved by
always pushing `refs/tags` into ref_prefixes. Deleting the check for
`ref_prefixes` being empty [1] breaks quite a lot of things, but reversing =
the
order [2] does not. That feels a bit strange tbh since it feels like the tw=
o
should bring about the same state ...

Hopefully someone more knowledgeable knows why things are as they are, but =
it
seems that reversing the order really is a band-aid here.

1: https://github.com/ferdinandyb/git/commit/6074a9b8c88451e589eade4034282d=
d9b6c86345
2: https://github.com/ferdinandyb/git/commit/31e3f0a6b829d6c7953bf89d015b98=
e7edabe6b5

Best,
Bence
