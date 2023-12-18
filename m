Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A06E57C
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XXXGYagf"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 521521D83C3;
	Mon, 18 Dec 2023 11:16:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5/S2z1Fd5pCX
	wfcjmSeBQmvhyQMcln93b7wR9wmEPb8=; b=XXXGYagf7oc8ak5wSPbHbQ5FuGLR
	Rnpi97KTGMrsgR5UwUa1AVFW27wvN33IB4vSBViPzjeD6OcQ69lYzpY4vmMQl8LI
	8Dt4EKNmWq+1d8Sl5wlDCwOq9JM+OmD7WWDls/U1x67JvSXvx0ZmV3L5P7E+CmAf
	NjgT58fS99nwIx4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 47DA81D83C2;
	Mon, 18 Dec 2023 11:16:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 384E11D83C0;
	Mon, 18 Dec 2023 11:16:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>, Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] doc: format.notes specify a ref under refs/notes/
 hierarchy
In-Reply-To: <ZX_9nRYKVq0jT0Lp@tanuki> (Patrick Steinhardt's message of "Mon,
	18 Dec 2023 09:06:53 +0100")
References: <20231215203245.3622299-1-gitster@pobox.com>
	<20231215203245.3622299-2-gitster@pobox.com>
	<0c93d426-17c3-434c-bbd0-866c31c23f9d@ramsayjones.plus.com>
	<xmqq1qbnktnl.fsf@gitster.g> <xmqqttojjegr.fsf@gitster.g>
	<xmqqjzpfje33.fsf_-_@gitster.g> <ZX_9nRYKVq0jT0Lp@tanuki>
Date: Mon, 18 Dec 2023 08:16:00 -0800
Message-ID: <xmqq1qbjij0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BCEC533C-9DC0-11EE-A747-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Dec 15, 2023 at 02:28:00PM -0800, Junio C Hamano wrote:
>> There is no 'ref/notes/' hierarchy.  '[format] notes =3D foo' uses not=
es
>> that are found in 'refs/notes/foo'.
>>=20
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  * According to my eyeballing "git grep refs/ Documentation" result,
>>    this was the only remaining mention of "ref/" in Documentation/
>>    hierarchy that misspells "refs/".
>
> This made me look for additional instances where we were referring to
> "ref/". Turns out it's only a very limited set, see the below diff.

Yup, I did the same grep, but I tend to avoid churning what we
published long ago (and kept in Documentation/RelNotes/), my patches
only covered documents that are still relevant.

> the translation changes with a big grain of salt though,

Hopefully pinging Jiang would be sufficient to ask help from the
French, Chinese, and Taiwaneese translation teams.

> diff --git a/po/fr.po b/po/fr.po
> index ee2e610ef1..744550b056 100644
> --- a/po/fr.po
> +++ b/po/fr.po
> @@ -19773,7 +19773,7 @@ msgid ""
>  "Neither worked, so we gave up. You must fully qualify the ref."
>  msgstr ""
>  "La destination que vous avez fournie n'est pas un nom de r=C3=A9f=C3=A9=
rence compl=C3=A8te\n"
> -"(c'est-=C3=A0-dire commen=C3=A7ant par \"ref/\"). Essai d'approximati=
on par=C2=A0:\n"
> +"(c'est-=C3=A0-dire commen=C3=A7ant par \"refs/\"). Essai d'approximat=
ion par=C2=A0:\n"
>  "\n"
>  "- Recherche d'une r=C3=A9f=C3=A9rence qui correspond =C3=A0 '%s' sur =
le serveur distant.\n"
>  "- V=C3=A9rification si la <source> en cours de pouss=C3=A9e ('%s')\n"
> diff --git a/po/zh_CN.po b/po/zh_CN.po
> index 86402725b2..eb47e8f9b7 100644
> --- a/po/zh_CN.po
> +++ b/po/zh_CN.po
> @@ -13224,8 +13224,8 @@ msgid ""
>  msgid_plural ""
>  "Note: Some branches outside the refs/remotes/ hierarchy were not remo=
ved;\n"
>  "to delete them, use:"
> -msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=82=E7=BA=A7=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=B8=AA=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=EF=BC=8C=
=E4=BD=BF=E7=94=A8=EF=BC=9A"
> -msgstr[1] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=82=E7=BA=A7=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=BA=9B=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=E4=BB=AC=
=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
> +msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=82=E7=BA=A7=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=B8=AA=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=EF=BC=8C=
=E4=BD=BF=E7=94=A8=EF=BC=9A"
> +msgstr[1] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=82=E7=BA=A7=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E4=BA=9B=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=A0=E9=99=A4=E5=AE=83=E4=BB=AC=
=EF=BC=8C=E4=BD=BF=E7=94=A8=EF=BC=9A"
> =20
>  #: builtin/remote.c
>  #, c-format
> diff --git a/po/zh_TW.po b/po/zh_TW.po
> index f777a0596f..b2a79cdd93 100644
> --- a/po/zh_TW.po
> +++ b/po/zh_TW.po
> @@ -13109,7 +13109,7 @@ msgid ""
>  msgid_plural ""
>  "Note: Some branches outside the refs/remotes/ hierarchy were not remo=
ved;\n"
>  "to delete them, use:"
> -msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Aref/remotes =E5=B1=A4=E7=B4=9A=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E5=80=8B=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=AA=E9=99=A4=E5=AE=83=EF=BC=8C=
=E4=BD=BF=E7=94=A8=EF=BC=9A"
> +msgstr[0] "=E6=B3=A8=E6=84=8F=EF=BC=9Arefs/remotes =E5=B1=A4=E7=B4=9A=E4=
=B9=8B=E5=A4=96=E7=9A=84=E4=B8=80=E5=80=8B=E5=88=86=E6=94=AF=E6=9C=AA=E8=A2=
=AB=E7=A7=BB=E9=99=A4=E3=80=82=E8=A6=81=E5=88=AA=E9=99=A4=E5=AE=83=EF=BC=8C=
=E4=BD=BF=E7=94=A8=EF=BC=9A"
> =20
>  #: builtin/remote.c
>  #, c-format

> Also, the test is
> interesting because it would fail even if we didn't pass an invalid ato=
m
> to git-for-each-ref(1).

It is interesting but not surprising.  It is not an error to use ref
patterns that do not match any ref.  It is a mere pattern to filtering
what are in refs/ for the ones to be output.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 54e2281259..e68f7bec8e 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -841,7 +841,7 @@ test_expect_success 'err on bad describe atom arg' =
'
>  		EOF
>  		test_must_fail git for-each-ref \
>  			--format=3D"%(describe:tags,qux=3D1,abbrev=3D14)" \
> -			ref/heads/master 2>actual &&
> +			refs/heads/master 2>actual &&
>  		test_cmp expect actual
>  	)
>  '

The "for-each-ref" family's "--format" string is first parsed and
sanity-checked before it is applied.  The bogus ref pattern may not
yield any ref to apply the format string, but we do not optimize out
the parsing and checking, even though we could, as it would be
optimizing for a wrong case.  So regardless of the ref pattern at
the end of the command line does not make a difference to the
outcome of this test.
