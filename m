Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49140DB54
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 05:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788498140; cv=pass; b=gLucBmbCUQBCuirbymKMpc46kxeMt/2NYKAsgj3TuXCVHzhVaY5EfNtdHrMfg1NGFiF6+U9E1SYnTUVZaUUwGghdKgpUVMS+rY7BvH2IM5NxQRB+qK6kd6r6buWuxMt2U3SJKIZtCZFwN/WmcCG7eMIcYQVFlvmbYjCErDdGir0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788498140; c=relaxed/simple;
	bh=ZwKGnpDNGa0SQ0T9+0bdLyi4Kb6KB0wlrF1DJBS+lZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sGsYEK/ruUJoG2Wi6fQLqX6nGmAHfTUQMY2S+80VZy5t3BR4ZSpS63YSP0ERVqeZsYFv8x4vxf/wNvzCuxMpXasAKTDtX+vfYuf0ZSjhvzmc7pWFb5MaE/6Bl1tyksd8qQrQVhcxZZvJ4AMxg3tz1oPR0uYDQwFayGo0AOejR3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TTS+ntB+; arc=pass smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TTS+ntB+"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6b1ab6d7239so477211eaf.1
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 22:02:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788498137; cv=none;
        d=google.com; s=arc-20260327;
        b=pOFqLYLysw2qXTkGL55hmdShaLr3QLHKrfvZIqKh5RL54/3FG+kr+1vS/dlFCf+4g/
         th/NrwU9/ENtjPE3R1tcsvrRAt/uTdnhReJK1iCtgDW84P1A5E4HIMlDSLaanjGMCTqc
         BogBor7b2HKKMQH0cwR6dA7kzkAxLGQzDNySKKeoz2D1jpbYHOJ1LP4PR6TdTr/xEkAX
         lt4At6sb9ulC/42eR3I6o7P8wj6+f+maZN/gAK5L47BCw1uqT24QKUaxAcEBZgOwTVyC
         4n6xnRIK2Lk9r5THJFNn2w1k2HmqVUGutckc9Rw3q2fSvxMOzlsNslYW6YFgPerYFpep
         3QBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G/Lr+HrSPvxpE5sQfFvzKVUptcPhjyJ2b7YudAF8QFA=;
        fh=vJKtsCq0FpAppi4R30iC+GYH+OTl5DrXM959X9d3CWQ=;
        b=RJadjbU+nVe/mrIlabVIKKbk4VtE/kvWMn8Pz0nMJe+fHQzzb627BAdVcpSpvm/x9o
         e2/v/lt2fBWnYjJ1Bo130LmjdDJpEXh2rRJ8bZRhEXaR4XG70YPervqp0QutRsQMwUUR
         D6soT9u9Ob0Dx0ol7nPUHTO02qTIX/fzuBhxfRyhNGl1bnMz4lptUNSXzlq0rVqhPY18
         qyg08xYwrz0otcHhn/gugEhTdKrhMo1AqB7jym5zrpz8ZmpyqB2DI6miS9LSiso6oXV0
         +j5U36JQZVzF2GHZ8dvSZax/RN7zv0En42AJbC+X4l1NYXAd7XGK3fl07qFJITrHeviW
         /u4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788498137; x=1789102937; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G/Lr+HrSPvxpE5sQfFvzKVUptcPhjyJ2b7YudAF8QFA=;
        b=TTS+ntB+5K2LlA6mLchbgPBRGSE7WRu1vD0ADDVmqH5X4B/ZthdnxymYiavHMHccKI
         8eUOyOJ5xscZRw2nrHYfnX4MbawCQ1JpvsbymXeMyskhLI/MeE7VKMILA+cuwcAAcjpI
         T1cVr0QL2L3WWWfRDJiiol2hGIhzTA/RPX/9C1Rd5iPFPb0h11bJfuaUsaUYYcrEEZ0j
         BuH8Ly9lipoV2N8ieDXnl4mnCrERQYoEdDRgYnlQ312+tbEeTp3p4efl6T/Z4w/Knjlu
         X8higPXrYftJTBfhSq2viNqOBWCHSEKTIXV0xtFiNFKr9+SxuQgW35YT5AwKUWV6EdJK
         jYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788498137; x=1789102937;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/Lr+HrSPvxpE5sQfFvzKVUptcPhjyJ2b7YudAF8QFA=;
        b=Kv5gZiRCP7DOc6ufhIgWcd5E9AbnP7qUIowz5WnGmWQmdyjejxgOFbZy8lU21LHePa
         tXjyvRBWz6lL2a94sbIf/kDMifg5rJjVmbjS/5jj8c0/gZnWpvERBQiosziJwg0R0oID
         x44EJGwgmwewp1sbO46WNqGLvzSyPB9eZwVp7rvA4cCMeuWRLSn4jwChLtbq/dPL/Upp
         6Y1CAyswZfmBevfAroloxKmBdieetYnLQIZpojz9j4cuRkWtadlnMKu3eka4QhzXEW4I
         toabYVddruVQhqys8MqHzDD3YptlfgfHIb5LcvqKkl2cWMOEEKvWIYp7rA6C5HWYDNc+
         fq1Q==
X-Gm-Message-State: AFuF++mFLqKDTOZVXv3PjdajSobnjZMRIJT6c+e1rhi6u9DsOZx14Yab
	0NluXUBYzAC60TZLwEOumEq1OJYrfTaS4gSatl9g5TwltqocCuRmFdaNHm4CSn+3K5iC1mhBa+n
	lfPPPV7Zl5T+rKRVlVZ5QXwZ2DeOOhWw=
X-Gm-Gg: AYBFou3IeylDGO3V1Gkd9yKb0CPMo/dPJi+R8D3XJrVERRXgwKpAfFfT/7PzhusvizY
	naVLQo4tw/j0ZZIEqkTrUkOVczoXfUDuCiufvXafeBDQeRieddvvMWNO1Ff7C5ToJYGwiJh8IA5
	0NGzRX/ZXgTfXiErIfw9TPsUmk6wsTWVp6DHnh1oJr2VrN35qMfMfXZwFXYbmuAOvuHaJ7h1AXn
	lXWSbClaaoXpoJWKMOzsAOrzZmiOvB7gzJzpS7ciTDLD0Gi8FkkusTnw9i7h0qLiC/H9HXQ4jmH
	KfbucEnIFjVw6vamdASIOy7n3kCZTSPrMRSNrOgER287cLBcZ2xTAUUj15K1TI51NNjA/z1vIAP
	ngvcgBI//brhWudIUUB863Bso/v4yHTXFEjPp3QSAdgvzON3ecl1NQXMXVnMm+Q==
X-Received: by 2002:a05:6820:1c8d:b0:6ac:a45e:ff84 with SMTP id
 006d021491bc7-6b6fb3df2f2mr2762975eaf.13.1788498137434; Thu, 03 Sep 2026
 22:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
 <xmqqecfbk2eb.fsf@gitster.g> <81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
 <886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de> <27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
In-Reply-To: <27FF785F-F5D5-44EC-93C2-5BD67BD99147@ytausch.de>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 3 Sep 2026 22:02:06 -0700
X-Gm-Features: AcwNN1VTA9Jj3qrNuNuH7VpsKDGvgatthMl6nl9jCkntjSPQG9I_fgOC9NM_FIE
Message-ID: <CABPp-BF6hps9DibSV4ghbowkOD-NfEsHYFdLoKab0hCfEi9rgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dir: find common prefix among non-exclude pathspec items
To: Yannik Tausch <dev@ytausch.de>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:08=E2=80=AFAM Yannik Tausch <dev@ytausch.de> wrote=
:
>
> common_prefix_len() skips exclude pathspec items, but uses n =3D=3D 0 to
> identify the initial item and items[0] as the comparison source. When
> an exclude item comes first, the function returns zero even when all
> remaining items share a directory.
>
> Track the first non-exclude item explicitly. Return its match through
> an output parameter so that common_prefix() and fill_directory() use
> the correct string. Add a unit test with an unrelated exclude item
> before two non-exclude items that share a directory.

This to me looked more like what you are changing, and I had a hard
time figuring out why you were changing it.

Does the following alternative correctly capture your intent and change her=
e? :


dir: preserve pathspec prefix optimization with leading excludes

Directory walks use the common directory prefix of non-exclude
pathspec items to avoid scanning unrelated portions of the working
tree or index.  Exclude items only remove paths from that candidate
set, so they do not need to widen the traversal.

When an exclude item is the first pathspec item,
common_prefix_len() fails to establish a comparison base and returns
a zero-length prefix.  The result is correct, but git unnecessarily
traverses from a broader starting point even when all non-exclude
items share a directory.

Use the first non-exclude item as the comparison base and return its
string together with the prefix length, allowing callers to start
from the recovered directory prefix.  Exclude matching continues to
use full paths, so this restores the optimization without changing
which paths are selected.  Add a unit test covering an exclude item
before two non-exclude items with a common directory.


> Signed-off-by: Yannik Tausch <dev@ytausch.de>
> ---
>  dir.c                | 37 +++++++++++++++++++++----------------
>  t/unit-tests/u-dir.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/dir.c b/dir.c
> index 7072715389..d896e7be4b 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -212,9 +212,10 @@ static int fnmatch_icase_mem(const char *pattern, in=
t patternlen,
>         return match_status;
>  }
>
> -static size_t common_prefix_len(const struct pathspec *pathspec)
> +static size_t common_prefix_len(const struct pathspec *pathspec,
> +                               const char **matched_prefix)
>  {
> -       int n;
> +       int n, first =3D -1;
>         size_t max =3D 0;
>
>         /*
> @@ -237,43 +238,47 @@ static size_t common_prefix_len(const struct pathsp=
ec *pathspec)
>                 size_t i =3D 0, len =3D 0, item_len;
>                 if (pathspec->items[n].magic & PATHSPEC_EXCLUDE)
>                         continue;
> +               if (first < 0)
> +                       first =3D n;
>                 if (pathspec->items[n].magic & PATHSPEC_ICASE)
>                         item_len =3D pathspec->items[n].prefix;
>                 else
>                         item_len =3D pathspec->items[n].nowildcard_len;
> -               while (i < item_len && (n =3D=3D 0 || i < max)) {
> +               while (i < item_len && (n =3D=3D first || i < max)) {
>                         char c =3D pathspec->items[n].match[i];
> -                       if (c !=3D pathspec->items[0].match[i])
> +                       if (c !=3D pathspec->items[first].match[i])
>                                 break;
>                         if (c =3D=3D '/')
>                                 len =3D i + 1;
>                         i++;
>                 }
> -               if (n =3D=3D 0 || len < max) {
> +               if (n =3D=3D first || len < max) {
>                         max =3D len;
>                         if (!max)
>                                 break;
>                 }
>         }
> +       *matched_prefix =3D first < 0 ? NULL : pathspec->items[first].mat=
ch;
>         return max;
>  }
>
>  /*
> - * Returns a copy of the longest leading path common among all
> - * pathspecs.
> + * Returns a copy of the longest leading path common among all pathspec
> + * items that are not excluded.
>   */
>  char *common_prefix(const struct pathspec *pathspec)
>  {
> -       unsigned long len =3D common_prefix_len(pathspec);
> +       const char *matched_prefix;
> +       size_t len =3D common_prefix_len(pathspec, &matched_prefix);
>
> -       return len ? xmemdupz(pathspec->items[0].match, len) : NULL;
> +       return len ? xmemdupz(matched_prefix, len) : NULL;
>  }
>
>  int fill_directory(struct dir_struct *dir,
>                    struct index_state *istate,
>                    const struct pathspec *pathspec)
>  {
> -       const char *prefix;
> +       const char *matched_prefix;
>         size_t prefix_len;
>
>         unsigned exclusive_flags =3D DIR_SHOW_IGNORED | DIR_SHOW_IGNORED_=
TOO;
> @@ -284,11 +289,11 @@ int fill_directory(struct dir_struct *dir,
>          * Calculate common prefix for the pathspec, and
>          * use that to optimize the directory walk
>          */
> -       prefix_len =3D common_prefix_len(pathspec);
> -       prefix =3D prefix_len ? pathspec->items[0].match : "";
> +       prefix_len =3D common_prefix_len(pathspec, &matched_prefix);
>
>         /* Read the directory and prune it */
> -       read_directory(dir, istate, prefix, prefix_len, pathspec);
> +       read_directory(dir, istate, prefix_len ? matched_prefix : "",
> +                      prefix_len, pathspec);
>
>         return prefix_len;
>  }
> @@ -394,7 +399,7 @@ static int match_pathspec_item(struct index_state *is=
tate,
>
>         /*
>          * The normal call pattern is:
> -        * 1. prefix =3D common_prefix_len(ps);
> +        * 1. prefix =3D common_prefix_len(ps, &matched_prefix);
>          * 2. prune something, or fill_directory
>          * 3. match_pathspec()
>          *
> @@ -414,8 +419,8 @@ static int match_pathspec_item(struct index_state *is=
tate,
>          * Normally the caller (common_prefix_len() in fact) does
>          * _exact_ matching on name[-prefix+1..-1] and we do not need
>          * to check that part. Be defensive and check it anyway, in
> -        * case common_prefix_len is changed, or a new caller is
> -        * introduced that does not use common_prefix_len.
> +        * case common_prefix_len() is changed, or a new caller is
> +        * introduced that does not use common_prefix_len().
>          *
>          * If the penalty turns out too high when prefix is really
>          * long, maybe change it to
> diff --git a/t/unit-tests/u-dir.c b/t/unit-tests/u-dir.c
> index 2d0adaa39e..a3442c3d3c 100644
> --- a/t/unit-tests/u-dir.c
> +++ b/t/unit-tests/u-dir.c
> @@ -45,3 +45,31 @@ void test_dir__within_depth(void)
>
>
>  }
> +
> +void test_dir__common_prefix_skips_excluded_pathspec_items(void)
> +{
> +       struct pathspec_item items[] =3D {
> +               {
> +                       .match =3D "unrelated/path",
> +                       .magic =3D PATHSPEC_EXCLUDE,
> +                       .nowildcard_len =3D 14,
> +               },
> +               {
> +                       .match =3D "foo/bar",
> +                       .nowildcard_len =3D 7,
> +               },
> +               {
> +                       .match =3D "foo/baz",
> +                       .nowildcard_len =3D 7,
> +               },
> +       };
> +       struct pathspec pathspec =3D {
> +               .nr =3D ARRAY_SIZE(items),
> +               .magic =3D PATHSPEC_EXCLUDE,
> +               .items =3D items,
> +       };
> +       char *prefix =3D common_prefix(&pathspec);
> +
> +       cl_assert_equal_s(prefix, "foo/");
> +       free(prefix);
> +}
> --
> 2.55.0

If my wording above is correct, I think the code looks like it
correctly implements that idea.
