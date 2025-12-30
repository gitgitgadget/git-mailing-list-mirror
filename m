Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4405F2820DB
	for <git@vger.kernel.org>; Tue, 30 Dec 2025 22:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767135098; cv=none; b=pu7JuRWRoGLi7uEvi80mZvsYeDwO2CH7R8BhDfVCXLUyRJ3ASGy3l5kv1XhbNUTMClzsNOYMq25rwfBoZeP3HpspCLJAZI9O6Kpr+5aR/VofVOwSefA4UqKaN32IC+i0tjJULntNJ689zOoOMTp8u4dkRx/I0eaFIlEx9Z/3qoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767135098; c=relaxed/simple;
	bh=0ClAFRYfkNmxFQFN5rePij1Mhm1Y3In4gXNSaMXFkG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UF/jOpUWXdZpGq2k1Utp8dhUuh5BftY0F/1ML1SUewa1jlstaL20x2prDeLlGfnxcUANM27q39ZgG3bbLg7AVM/F+PnO7bGMJbis2fAf/esgXQcewLAe3vsI0p1+eFPfqYaHgwaGPlCeSZUryVHgXl0dsuTjh4+sHMYbAM7//PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvQK2Rjb; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cvQK2Rjb"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6575e760f06so2695630eaf.0
        for <git@vger.kernel.org>; Tue, 30 Dec 2025 14:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767135096; x=1767739896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uPY5E2xThstOvU82OrgszncSPpV9vFMhWfRjboP+e0=;
        b=cvQK2Rjbp2ezIxm6idNre4b1lqO9iBG7F4jj4e4ZwdnmGLwF7iVHZKgGwRKiv+r/Fs
         10ehrwAOaGgBZYgrtkNGkQqZHatirxwhn5hjO0sZCJ+cSAhxUqzrfO+KWJWgPw3tEe0M
         DfxlNO4GeSzf5fr6/pRyG4oyuPvH91KcGTTYKVRqs5hRsstePXmbQUQcgvoSbaUFeBpa
         XuxJR1wPHWBQ1jFiBj37CX+aLgb9C9lG7CuN794udUogsYwo04OZ3mVsoU3asrGthtNX
         ln3ccimk059sbWlc2WFhXogQkVkJqJUGnbo15msIt9KQOcWzWF7fhLZj1vklwtNesvFr
         osRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767135096; x=1767739896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0uPY5E2xThstOvU82OrgszncSPpV9vFMhWfRjboP+e0=;
        b=Lv2V/T8TYOaGZuLBEuTMDk6nsCA/FJHooIFS3KDxsQibwrR7KFxrOUv9TmfTPrcWhO
         2NU1QZZrlF0l8abm/hq+y+VsWgFyXaiJ689gk3vRZ3h25ocejbj/wx+UOlu2vnEkDWBi
         IFnB4S9xlquGrhgteN+U+CWdcEnj8BkYayVaoksob7s4DKj9BS7+n3D+Xs9RuvJ1k1o2
         DfHrlqVGFitYC3PCGFvJKFfaDSGK34ZQcKgfo59cDNiE43BzK+212cyUYukjAG+/zw54
         sa0sGaz6FLo9gVrYJ7vHLN5FGf+wZ76bCF00nH7efKmXih5VzrJ/A+/e5VKq3Kxvbw+z
         TN6w==
X-Gm-Message-State: AOJu0YzBrG5vRqVkf0QAPBuzNVALNndjDePSfmm2eEODCpPDqwLLQ5Bl
	Rhv3pTNzxHvibP5vrkexP0K7myYv47rzz/BqqxaAIt8nRS2PK8iTNhe802Ffl7EXdvt3Hk7Q1vO
	njy9UrQBg/wr9Tzbzs6Cd28XX6OQgne11Gw==
X-Gm-Gg: AY/fxX7AMpFXzgOM0MkvQ548euavBcP4uxvi6hdgXjWqrKlb993BVr9QR6Chagm4Slz
	xV3mcX1GqX2+4Rjs+XIfLs6b1q39MBhXqZ/LUeiTUg18oU042kce3c0vdcAIUEBS01kSbfpE03c
	G6LtMT8vkSRip2tk3U/Nqxj4GcdkGkB7S2nZ1Wb8zCgBFMl276rfp+jt0OQNA2J4R/Q9bq1pqP8
	HL6iYGAt1PA9NaqG6+3RiB6FCDXbEaDeTy9TPr/glWh9UjakKeBM9GFNguC9QWZU8txy8/F9/5X
	JPskp4lR2SIlqMjd+PKuKWWbmL0p
X-Google-Smtp-Source: AGHT+IGsM8+ekG/2/0x3bCE8av8kGC0ZYgNn17eHrj83rA7+hn2LJPrdEPErx7vGk5YmkycH5GFU9qVn3abNZL5kg4c=
X-Received: by 2002:a05:6820:6fd7:b0:659:9a49:8e66 with SMTP id
 006d021491bc7-65d0eaceb57mr13791138eaf.54.1767135096113; Tue, 30 Dec 2025
 14:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CV_replay_die_descr.13f@msgid.xyz> <V2_CV_replay_die_descr.17b@msgid.xyz>
 <V2_~axonto_after_ref_test.17d@msgid.xyz>
In-Reply-To: <V2_~axonto_after_ref_test.17d@msgid.xyz>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 30 Dec 2025 14:51:25 -0800
X-Gm-Features: AQt7F2pTp_NRfZVVKiBPcmQ31hWQXcw_9eTucbbSGPe0tSJOPx-45I4d86wM9E4
Message-ID: <CABPp-BE13K1QB42YLv3mLzB9+jUgkMtHNmbs_XWoTsbv2zSYog@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] replay: find *onto only after testing for ref name
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>, christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 7:03=E2=80=AFAM <kristofferhaugsbakk@fastmail.com> =
wrote:
>
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> We are about to make `peel_committish` die when it cannot find
> a commit-ish instead of returning `NULL`. But that would make e.g.
> `git replay --advance=3Drefs/non-existent` die with a less descriptive
> error message; the highest-level error message is that the name does
> not exist as a ref, not that we cannot find a commit-ish based on
> the name.
>
> Let=E2=80=99s try to find the ref and only after that try to peel to
> as a commit-ish.
>
> Also add a regression test to protect this error-order from future
> modifications.

"error-order" looked like a typo and took a while for me to parse.
Maybe drop the hyphen or replace with "order of errors"?


>
> Suggested-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v2: [new]
>
>     Fallout of v1. Needs to be moved so that the new error message does n=
ot
>     =E2=80=9Cshadow=E2=80=9D this one.
>
>     See: https://lore.kernel.org/git/xmqqpl85pb7k.fsf@gitster.g/
>
>  builtin/replay.c         | 2 +-
>  t/t3650-replay-basics.sh | 7 +++++++
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 54849f65c87..35813140e99 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -184,18 +184,18 @@ static void populate_for_onto_or_advance_mode(struc=
t repository *repo,
>                 char *fullname =3D NULL;
>
>                 if (!*advance_name)
>                         BUG("expected either onto_name or *advance_name i=
n this function");
>
> -               *onto =3D peel_committish(repo, *advance_name);
>                 if (repo_dwim_ref(repo, *advance_name, strlen(*advance_na=
me),
>                              &oid, &fullname, 0) =3D=3D 1) {
>                         free(*advance_name);
>                         *advance_name =3D fullname;
>                 } else {
>                         die(_("argument to --advance must be a reference"=
));
>                 }
> +               *onto =3D peel_committish(repo, *advance_name);
>                 if (rinfo.positive_refexprs > 1)
>                         die(_("cannot advance target with multiple source=
s because ordering would be ill-defined"));
>         }
>         strset_clear(&rinfo.negative_refs);
>         strset_clear(&rinfo.positive_refs);
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 58b37599357..7dea62f064f 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -49,10 +49,17 @@ test_expect_success 'setup' '
>
>  test_expect_success 'setup bare' '
>         git clone --bare . bare
>  '
>
> +test_expect_success 'argument to --advance must be a reference' '
> +       echo "fatal: argument to --advance must be a reference" >expect &=
&
> +       oid=3D$(git rev-parse main) &&
> +       test_must_fail git replay --advance=3D$oid topic1..topic2 2>actua=
l &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'using replay to rebase two branches, one on top of =
other' '
>         git replay --onto main topic1..topic2 >result &&
>
>         test_line_count =3D 1 result &&
>
> --
> 2.52.0.10.g08704017180

Looks good otherwise.
