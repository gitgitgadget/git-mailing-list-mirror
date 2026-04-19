Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C4F22B584
	for <git@vger.kernel.org>; Sun, 19 Apr 2026 12:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776600399; cv=none; b=Qg/1LRz60aPDkmFHUhfzGQ3vcoCJlLdc9x6tj0o7QHZJQxxoz2zXqAVosMu99Y8i2dojGbx9fuGcQ4NBuloqtjptxI7PM/YdptmB0Ciq63jcABQJ/H0Xdmdpo20eaLHgP3jDQFpZtkBrX1HqzZXnV7V27I3tVLrUIGge/DtKXMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776600399; c=relaxed/simple;
	bh=W+SjR/n63LEP/sHSSILoAq4uCkp6wNWKA/G4k/oqhxQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=QeDl+6zt8r0lDKAMqJ3/LfTFD7oCSeAe9JQ0lTfmkIU/lq/lpPGgQWAGkFN8mHVybD6oabZyI/g3grVtNWDJ/vB/ByIErGu+yxvzkoihovixHd5UifQ2ok6hhNGd2OkJWRt/BLtXuhrGC6E6/zOuvNfrrQI+IUjP7ItGkX/mIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYGsQHHy; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYGsQHHy"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ab5fd969aso20701907b3.0
        for <git@vger.kernel.org>; Sun, 19 Apr 2026 05:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776600397; x=1777205197; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezuTUKXz4gg8qeOW9KBKr9fJmJuViILjmTtMs6dHkbY=;
        b=JYGsQHHyAFMLWhjyu8wh/6bKcekQnohRI+Ilq0twc4a1p+LqTgRZiPt+Dpw3MzwcFW
         yQhigGqAm8F5Y89dR5D12dnPCegkrKFW7cTVQ1RjNDVsgm1LOkL7pypi//zZC1RmLUYE
         guUShg2C58e//MTt0szQtfgwFDIBy3rirwyuj7BteZRRQXez5DiS+w8p5GzJRjYPX9k5
         m+HkfEW8+8AenSpTG3Hahp05mToWRVPPJTDwbcgZXhDQhU/JJqFlBfdf0K6J+v2nIBJb
         /6DSqEhvb40DFmdVtwOdQ4pLmE+GlWcNKnx2nn6SbxX2ioRMFqfgb8jDMHZtyFGddJfX
         D+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776600397; x=1777205197;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ezuTUKXz4gg8qeOW9KBKr9fJmJuViILjmTtMs6dHkbY=;
        b=LgT16Je3qqdRp+c5oW1+1xt/Mop8u6x7djiF8DnJygVWvbdhVKtGOgUIH38QS96859
         wC8XOopEIaFQe0hw+37G4yNQKiDsfwNEHuTZ5uacjjWXA9Hv615ycOWue4c9yBRPr6Y6
         i/+gVdYjQDPTQEWUiOq+ERAnJbSdpold4R0t1FhLEPaV882k8TTPO8+7UOvOqaBOKYs8
         bBF9amFCnWwvsSQ+LjsJXFgyHNIoJfcacfjHgTrwOw4eRnrbaPbOHAhT5NIBVmYuz67x
         ILd4CxHKLLdwCpO5M9Mlhyb9CBEpmWU2nqUue6piGSxjRcCEqmZT0dw6eReCgeBHftFk
         5hKg==
X-Gm-Message-State: AOJu0YwFb70yCtUvSnBJaTIsApcgFBitTqwlULVWgsHENtjhpoHfLPFs
	wzUiuiS3Kmr5ljChne+h3FIHXVD6m24qkUXhIO2Tc2QIYEccxvxQK3bupuIgKXKv
X-Gm-Gg: AeBDieulhFJPYCf6GgjukkgQn3zqYsjwjez1u2Te1+BxJ94PQKTh3TWGhmBN972Umcm
	H1M7x9sn8en5Chmr/DYqr6+q0+fS9jEs+M9jld2r9KvGIjVhXuRCiD7s5iDUq91Xf5L7mNT/oCh
	Ees0UOgtABfOSU2Ay1dUUvluM5vvLNgixnAE79T8bwbcZWA96BA+AtpjB1rr8Pnl9rey7izg0y9
	flCUeRrIFac/hyITVzTxJoYP2nx42DHAZq9XStuXsj2jQAXtHPKMBJreWjqML1bOkv6yKG1aFTL
	Gxo1ljQTrD8hAyiKI0sPfuShsBtzvCMbCB25dWHRox/CtQWaM9gDFmdqcDBCunDIlF2XhenkY/L
	maWeXO0BSHX4BqhkOQVRm52cgBh4IGC/yiQ3ysq8HMjjWp4dDh7+bdPVUMxRQ20gB4+cl2hJm+S
	a2GPpaZHA7cOFsAyoPSwc7RXQPa8KsGwNw5hmRGNp9QlnjJtJHtxX+e4K6sFIKf7irChnQKKFmh
	WuLL1mNabCQedn5pXne2gcg9TPN/HCp1ykR1e4ry41rFJcz/9BkWRgW
X-Received: by 2002:a05:690c:4188:b0:79f:4e02:50bc with SMTP id 00721157ae682-7b9ed00bc47mr77829197b3.40.1776600397075;
        Sun, 19 Apr 2026 05:06:37 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:d8a0:86da:c917:43b3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b1f6fsm30050857b3.36.2026.04.19.05.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 05:06:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Date: Sun, 19 Apr 2026 08:06:24 -0400
Message-Id: <C60EE993-97DA-45F7-89DE-2F97ABB0F685@gmail.com>
References: <20260418164736.2367523-2-mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>,
 =?utf-8?Q?Jean-No=C3=ABl_Avila?= <jn.avila@free.fr>,
 Jeff King <peff@peff.net>, Mirko Faina <mroik@delayed.space>
In-Reply-To: <20260418164736.2367523-2-mroik@delayed.space>
To: Mirko Faina <mroik@delayed.space>
X-Mailer: iPhone Mail (23D8133)


> Le 18 avr. 2026 =C3=A0 12:57, Mirko Faina <mroik@delayed.space> a =C3=A9cr=
it :
>=20
> =EF=BB=BFIn a revision walk `--reverse` can only be applied after any comm=
it
> limiting option. This makes getting a limited amount of commits from the
> tail impossible. E.g.
>=20
>    git log --reverse --max-count=3D3
>=20
> Some would expect this to give back the first 3 commits of the project.
> Instead it returns the last 3 but in reversed order.
>=20
> Teach `get_revision()` to accpet an argument `(after|before)` from the
> CLI, and apply the reversal before or after the commit limiting options
> based on this argument. If no argument is provided default to the
> current behaviour, applying `--reverse` after the commit limiting
> options.
>=20
> Signed-off-by: Mirko Faina <mroik@delayed.space>
> ---
> Documentation/rev-list-options.adoc |  6 ++--
> revision.c                          | 42 ++++++++++++++++++++++---
> revision.h                          |  7 ++++-
> t/t4202-log.sh                      | 49 +++++++++++++++++++++++++++++
> 4 files changed, 97 insertions(+), 7 deletions(-)
>=20
> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-=
options.adoc
> index 2d195a1474..eed1813a92 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -914,10 +914,12 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 1=
 (or 8 7 4 2 6 5
> avoid showing the commits from two parallel development track mixed
> together.
>=20
> -`--reverse`::
> +`--reverse[=3D(after|before)]`::
>    Output the commits chosen to be shown (see 'Commit Limiting'
>    section above) in reverse order. Cannot be combined with
> -    `--walk-reflogs`.
> +    `--walk-reflogs`. `when` can either be `after` or `before`, if

=E2=80=9CWhen=E2=80=9D is not mentioned prior to here, so it=E2=80=99s expla=
nation leaves the reader wondering what it refers to.

> +    omitted it defaults to `after`. If `before` is chosen,
> +    `--reverse` will be applied before any commit limiting options.
> endif::git-shortlog[]
>=20
> ifndef::git-shortlog[]
> diff --git a/revision.c b/revision.c
> index 599b3a66c3..8338ea7448 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2685,8 +2685,26 @@ static int handle_revision_opt(struct rev_info *rev=
s, int argc, const char **arg
>        else
>            git_log_output_encoding =3D xstrdup("");
>        return argcount;
> -    } else if (!strcmp(arg, "--reverse")) {
> -        revs->reverse ^=3D 1;

The original handles multiple reverse options inverting each other=E2=80=A6

> +    } else if (starts_with(arg, "--reverse")) {
> +        if (!skip_prefix(arg, "--reverse=3D", &optarg)) {
> +            if (argc < 2) {
> +                revs->reverse =3D 1;
> +                return 1;
> +            } else {
> +                optarg =3D argv[1];
> +            }
> +        }
> +
> +        if (!strcmp(optarg, "after")) {
> +            revs->reverse =3D 1;
> +        } else if (!strcmp(optarg, "before")) {
> +            revs->reverse =3D 2;
> +        } else {
> +            revs->reverse =3D 1;
> +            return 1;
> +        }
> +
> +        return optarg =3D=3D argv[1] ? 2 : 1;

=E2=80=A6which I don=E2=80=99t see here.

I=E2=80=99m not familiar with this parsing code though so I can=E2=80=99t ad=
d much about the test other than to say it is a bit hard to follow :/

>    } else if (!strcmp(arg, "--children")) {
>        revs->children.name =3D "children";
>        revs->limited =3D 1;
> @@ -4525,19 +4543,35 @@ struct commit *get_revision(struct rev_info *revs)=

> {
>    struct commit *c;
>    struct commit_list *reversed;
> +    int max_count =3D revs->max_count;
> +
> +    if (revs->reverse && !revs->reverse_output_stage) {
> +        if (revs->reverse =3D=3D 3) {
> +            BUG("allowed values for reverse are 0, 1 and 2");
> +            revs->reverse =3D 1;
> +        }

Is this possible? I guess I can see from the expanded bit width that it=E2=80=
=99s a valid input, and there=E2=80=99s no protection stopping other callers=
 accidentally adding this.

I haven=E2=80=99t looked, but it would be nice if we could use an enum inste=
ad. Unfortunately that would probably take up more space in the struct, and I=
 suppose the bit-packing is done intentionally for performance.=20

> +
> +        if (revs->reverse =3D=3D 2)
> +            revs->max_count =3D -1;
>=20
> -    if (revs->reverse) {
>        reversed =3D NULL;
>        while ((c =3D get_revision_internal(revs)))
>            commit_list_insert(c, &reversed);
>        commit_list_free(revs->commits);
>        revs->commits =3D reversed;
> -        revs->reverse =3D 0;
>        revs->reverse_output_stage =3D 1;
> +
> +        if (revs->reverse =3D=3D 2)
> +            revs->max_count =3D max_count;
>    }

It looks we temporarily disable reversing and then re-enable it here, which m=
akes some sense to me as a way to do =E2=80=9Cafter=E2=80=9D mode.=20

>=20
>    if (revs->reverse_output_stage) {
> +        if (revs->reverse =3D=3D 2 && revs->max_count =3D=3D 0)
> +            return NULL;
> +
>        c =3D pop_commit(&revs->commits);
> +        if (revs->reverse =3D=3D 2)
> +            revs->max_count--;

Hm. Why do we decrement here? Again, not an area I=E2=80=99m familiar with, b=
ut a bit surprising.=20

>        if (revs->track_linear)
>            revs->linear =3D !!(c && c->object.flags & TRACK_LINEAR);
>        return c;
> diff --git a/revision.h b/revision.h
> index 584f1338b5..5b23343f17 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -196,7 +196,12 @@ struct rev_info {
>            rewrite_parents:1,
>            print_parents:1,
>            show_decorations:1,
> -            reverse:1,
> +            /*
> +             * 0 no reverse
> +             * 1 after
> +             * 2 before
> +             */
> +            reverse:2,
>            reverse_output_stage:1,
>            cherry_pick:1,
>            cherry_mark:1,
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 05cee9e41b..21e9a61994 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -1882,6 +1882,55 @@ test_expect_success 'log --graph with --name-status=
' '
>    test_cmp_graph --name-status tangle..reach
> '
>=20
> +cat >expect <<-\EOF
> +c3f451c Merge tag 'reach'
> +046b221 to remove
> +EOF
> +
> +test_expect_success 'log --reverse --oneline --max-count=3D2' '
> +    test_when_finished git reset --hard HEAD~1 &&
> +    touch to_remove &&
> +    git add to_remove &&
> +    git commit -m "to remove" &&
> +    git log --reverse --oneline --max-count=3D2 >actual &&
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse after --oneline --max-count=3D2' '
> +    test_when_finished git reset --hard HEAD~1 &&
> +    touch to_remove &&
> +    git add to_remove &&
> +    git commit -m "to remove" &&
> +    git log --reverse after --oneline --max-count=3D2 >actual &&
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse=3Dafter --oneline --max-count=3D2' '
> +    test_when_finished git reset --hard HEAD~1 &&
> +    touch to_remove &&
> +    git add to_remove &&
> +    git commit -m "to remove" &&
> +    git log --reverse=3Dafter --oneline --max-count=3D2 >actual &&
> +    test_cmp expect actual
> +'
> +
> +cat >expect <<-\EOF
> +3a2fdcb initial
> +f7dab8e second
> +EOF
> +
> +test_expect_success 'log --reverse before --oneline --max-count=3D2' '
> +    test_when_finished rm actual &&
> +    git log --reverse before --oneline --max-count=3D2 >actual &&
> +    test_cmp expect actual
> +'
> +
> +test_expect_success 'log --reverse=3Dbefore --oneline --max-count=3D2' '
> +    test_when_finished rm actual &&
> +    git log --reverse=3Dbefore --oneline --max-count=3D2 >actual &&
> +    test_cmp expect actual
> +'
> +
> cat >expect <<-\EOF
> * reach
> |
>=20
> base-commit: e8955061076952cc5eab0300424fc48b601fe12d
> --
> 2.54.0.rc2.9.ge895506107
>=20
>=20
