Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B10232AABF
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 18:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847619; cv=pass; b=qRqoLlqp1/kSOh4/dWrcS/2oXuBNF2ViXd2bl/N0Oxm7iDe8A5EhVlQkVIj0W6273Dbqxz0p8JujsZFfyiyy8JFbsJ4YvEMO6RjNEoSchxuF2DFXC/YLKWX89yYzN3fBdvexyADy1ym06WEcRI9esNVDJfYKFoj+eNnpx9WA3rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847619; c=relaxed/simple;
	bh=mjF8iInJ4I3Zru9mn+bIk5othluwpan8j0O6s83BSiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5S+WEkv0k/Fvsw1OPTlAeHOWL4iLjwark2SelydJ6PsJ4+bSNBMh4Ynq7sYrRVReZH5QGYW2+pUz1veIXcALdY+/gj/ZUYa2mUBWRVE+yqw6QNcdDqyLULvZOmvWai1DXNNj/l47UsQ3sGsfVzwYA1SU2xqndR8f5j4u1jaRAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiYiu3Zi; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiYiu3Zi"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-64937edbc9eso479962d50.2
        for <git@vger.kernel.org>; Mon, 19 Jan 2026 10:33:37 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768847617; cv=none;
        d=google.com; s=arc-20240605;
        b=FkYBfjLFoeTxD1+hA5+gywD34ZdkYT6N/9Rmd2mIZ2osY4IBZw7k55tp2653JiNAMP
         BQyqHcJjCPyz+gIRrnEt5gltyY8WHULPr0EYnw6dXTI5B1KcRAsgblxfBWxv1KXeRk3c
         mWtzotUwn8DaIzyRxsOJ//r6CIWeVHf60Q5rvSoegIBxw+8Q/31qYxCVRhi3I9fystAG
         3HcjOLb1hS+U1AHFVJizx+Kji449LbBexi+9kTrgOL3YR8ivt17alcoe7hlhERohE8rF
         kFPZjkWMW8BOB1piQnCyhw2a3bY/AQHTzCB7q5akragme/O8Mn+XdrYihynwYwE2oHpJ
         PNfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xI16uQMBo5LkP8ZGUZi/iampyI0eFDikADKEuSAPU/g=;
        fh=0WVhaTdTglPnSupcY5Y7iwvWZ2LJCSkcED2p+ow+auc=;
        b=UPlovHsuIs1w9tpHCm/MaDIDJledEurxfCJZHmISJnomi+Pt+7EYqF59BctIBSrBF/
         x8TenCRHcjPDNhxsJC3Z40B4BNtvDtuHxDoImTIrC+elgRSZ2sRUWsurW8Xv43UwKtn5
         6bR/N5G2U6lSBSm4BVmiLvH2w8JFNZEs6TFWB7ZbFsOfrQbBBXCCO977CX4b0Hbxc0aC
         zbaXqhQba5CQpguvKnfnVCpLdyhTLAIwLFHkEt0j984RT6Td2f4rRcIEKt9sHxG58pz9
         Bxr645lCYvPfjM5jm9CId/fAujhR90xDtePPfLd+ALcbEHG3/J1VPOEfOw0jxBDZDhf+
         Gcgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768847617; x=1769452417; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xI16uQMBo5LkP8ZGUZi/iampyI0eFDikADKEuSAPU/g=;
        b=LiYiu3ZifC+CAsE/wNtIdlYI1gy0Uxi+bcdWSJmL+/0p6JjK4/54TNMmGrtPXwCuXM
         kgtg6WEmQgDuMWoG2txG3Dy6pmmN0t2YVsxZQqxqFOsK72AsNIkWmOhPdN6pcNC8oRlV
         I3ArRtR20ymwT+gWHeTXi15WlJpDwKnoJB+bgUvDorsYWM/pgG9kVUPFdzEpaP9Dg5v+
         59Xz7mIuLcZiIN0FvYVv5Q+VkFETozpvs8ytGZeAYTwQ/2i/w+Zxd6LbUyaDNPRDJUp0
         V/k0OPEHtf6RUIvayBFCnzu6QDqP0ASIDmOYyPSo36pJWeBpttGEMOK92R96rEFfdpn3
         gfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768847617; x=1769452417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xI16uQMBo5LkP8ZGUZi/iampyI0eFDikADKEuSAPU/g=;
        b=fLCVYSUMXUjSHFUJOwfCWY6o6aQ6yslYrLTFGKT2jqdnSJ5QHetX1sgld+ZqtKewVG
         jttTSWJ2AFricf16FGl1GKIVrMH+8pzZhpcnvuGHFluqrhv89Zn4tZNF9vNCwt773GF6
         +zk+DKirhOLfCmkMLVe8RFx6L/LhoqfxRJdSmh/+VZv1Xgm13YWF4fS4W7mLnGGGVjjY
         ydEWr+l+m0DBoaeJALpZsKcHTAgj2X9d5l9I/NLvU1iXTvjQmeu7nzItjv5Ua+bktcrR
         +gOwBu9DRJONzkjJA8qRRxiwobzGJWODUF755k7V9oc+mlVT9i1pS8TiIVMSipXX9kMW
         E8ow==
X-Forwarded-Encrypted: i=1; AJvYcCWx4Ib+ZYli259GeShp85/Qvm5nVUtNsD8XQuOK424D/aWdjR4l9YYpaMDUuLyODjOaWkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyC5peJd8B0ZNOAQW/QmoLyq3xQlJ3fj/+i57DmmVykgzTNGh/u
	3OyhnT1UqAEx4s/hG2gCO6bDE9CsMb6t0Z4R4BfpjQy/NY09mQBimL5H1e/OC0ZuTHaX6KGE9nV
	Eo3ZjZ4i3ziI9tGFHw+F6qwy49xgI9IM=
X-Gm-Gg: AZuq6aKUWIPrQKPsjD6Tw2LCVnapUJh6nvzp6Ee/4kGC891yZy5ku68aApjE462M3E9
	cpQQIRWcPniCWbk4GsCgMFTKBo7IymGxrLQXSdvCZUKmfwnm/si/zloEU1eY4kqeldNWrFqcDgR
	M938/b/Nu5BR1j6+bfx8iB7g/uSNBxKrpWH9Qgnh6bZcO0GXCykDLMV+ojt2TnOGcUzSLm/0waK
	AJLcxhRjKYqSUKs5VzRSE2rDEKg1RUeYLX9YB4GxKaFXSUByyAZqXtv0wp02N3MHCjm8lU=
X-Received: by 2002:a05:690e:1914:b0:646:5019:f3f2 with SMTP id
 956f58d0204a3-649176c6dd8mr8953574d50.19.1768847616866; Mon, 19 Jan 2026
 10:33:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260114192803.4852-1-amishhhaaaa@gmail.com> <20260119123339.48435-1-amishhhaaaa@gmail.com>
 <36b50d7d-b9f4-4ff3-b00e-9c98ad690749@gmail.com>
In-Reply-To: <36b50d7d-b9f4-4ff3-b00e-9c98ad690749@gmail.com>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Tue, 20 Jan 2026 00:03:25 +0530
X-Gm-Features: AZwV_QheEq75O6PDgwvumPJTd7Xw3POBY1Nu1TiRyOgk7HUh1luVOnrdScGeHwA
Message-ID: <CALE2CrSRromrzu5ZJxtm_LQ0gke102dVusYCFb3jY8hNSRBQ=w@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] sparse-checkout: optimize string_list construction
To: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Cc: amisha <amishhhaaaa@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Amisha, Derrick,

Thanks for the detailed discussion here. Reading through the thread helped
clarify the intended behavior around deduplication and testing.

While investigating "git sparse-checkout list" in cone mode independently,
I noticed a related but slightly different case than repeated identical
patterns: semantically equivalent but syntactically different paths, for
example:

  folder1
  folder1/
  ./folder1

These collapse to a single canonical entry in the output of
"sparse-checkout list", even though they are distinct strings on input.

The tests in v5 cover duplicate identical patterns well, but they do not
appear to cover this normalization aspect. It may be worth adding a test
that exercises "list" behavior with such normalized-path variants, possibly
by modifying the sparse-checkout file directly so that "add" does not
perform deduplication first, as Derrick mentioned.

For context, I sent a small test-only patch exploring this behavior here:
https://lore.kernel.org/git/edbde063-2c39-4812-9970-247b67f678c7@gmail.com/=
T/#m68a4fd645e10cd8e82ac5e4080c48b12f8f6348a

Happy to help draft or review an additional test if that would be useful.

Thanks,
Pushkar

On Mon, Jan 19, 2026 at 10:39=E2=80=AFPM Derrick Stolee <stolee@gmail.com> =
wrote:
>
> On 1/19/2026 7:33 AM, amisha wrote:
> > From: Amisha Chhajed <amishhhaaaa@gmail.com>
> >
> > Improve O(n^2) complexity to O(n log n) while building a sorted
> > 'string_list' by constructing it unsorted then sorting it
> > followed by removing duplicates.
> >
> > Signed-off-by: Amisha Chhajed <amishhhaaaa@gmail.com>
> > ---
> >  builtin/sparse-checkout.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> > index 15d51e60a8..7dfb276bf0 100644
> > --- a/builtin/sparse-checkout.c
> > +++ b/builtin/sparse-checkout.c
> > @@ -91,10 +91,11 @@ static int sparse_checkout_list(int argc, const cha=
r **argv, const char *prefix,
> >
> >               hashmap_for_each_entry(&pl.recursive_hashmap, &iter, pe, =
ent) {
> >                       /* pe->pattern starts with "/", skip it */
> > -                     string_list_insert(&sl, pe->pattern + 1);
> > +                     string_list_append(&sl, pe->pattern + 1);
> >               }
> >
> >               string_list_sort(&sl);
> > +             string_list_remove_duplicates(&sl, 0);
>
> Shouldn't this line be added in the other uses of string_list_append()?
>
> >
> >               for (i =3D 0; i < sl.nr; i++) {
> >                       quote_c_style(sl.items[i].string, NULL, stdout, 0=
);
> > @@ -289,7 +290,7 @@ static void write_cone_to_file(FILE *fp, struct pat=
tern_list *pl)
> >               if (!hashmap_contains_parent(&pl->recursive_hashmap,
> >                                            pe->pattern,
> >                                            &parent_pattern))
> > -                     string_list_insert(&sl, pe->pattern);
> > +                     string_list_append(&sl, pe->pattern);
> >       }
> >
> >       string_list_sort(&sl);
> Actually, there is a string_list_remove_duplicates() just
> outside of the context of this diff.
>
> > @@ -311,7 +312,7 @@ static void write_cone_to_file(FILE *fp, struct pat=
tern_list *pl)
> >               if (!hashmap_contains_parent(&pl->recursive_hashmap,
> >                                            pe->pattern,
> >                                            &parent_pattern))
> > -                     string_list_insert(&sl, pe->pattern);
> > +                     string_list_append(&sl, pe->pattern);
> >       }
> >
> >       strbuf_release(&parent_pattern);
>
> Same here.
>
> This diff looks good, but I do believe it would be good to include your
> duplicate test here instead of in a second patch.
>
> Also, the way your second patch appeared as a trailer of your first patch=
,
> so it didn't appear properly as a thread in my email client. Here it is
> for review:
>
> > From b20a99f0773bab063a31eea6fead730e18200ca7 Mon Sep 17 00:00:00 2001
> > From: Amisha Chhajed <amishhhaaaa@gmail.com>
> > Date: Mon, 19 Jan 2026 00:20:47 +0530
> > Subject: [PATCH v5 2/2] t1091: Add tests for deduplication of cone-mode=
 sparse
> >  patterns
>
> nit: this title is a little long and has incorrect capitalization. Take
> note for later, since I expect this diff to be squashed into the previous
> patch.
>
> > +test_expect_success 'sparse-checkout deduplicates repeated cone patter=
ns' '
> > +    rm -f repo/.git/info/sparse-checkout &&
> > +    git -C repo sparse-checkout init --cone &&
> > +    git -C repo sparse-checkout add --stdin <<-\EOF &&
> > +     /foo/
> > +     /bar/
> > +     /foo/
> > +     EOF
>
> This slashes are redundant for cone-mode patterns. I recommend a more
> interesting case, such as
>
>         foo/bar/baz
>         a/b/c
>         foo/bar/baz
>         a/b
>
> This should remove the duplicates foo/bar/baz during the run, but also it
> should notice that a/b/c is contained within the recursive set defined by
> a/b.
>
> The resulting sparse-checkout file should have lines such as
>
>         /*
>         !/*/
>         /a/
>         !/a/*/
>         /a/b
>         /foo
>         !/foo/*/
>         /foo/bar
>         !/foo/bar/*/
>         /foo/bar/baz
>
> The order might be different, but this is what I recall from how nested
> directories work in cone mode.
>
> > +    cat >expect <<-\EOF &&
> > +     /*
> > +     !/*/
> > +     /bar/
> > +     /foo/
> > +     EOF
> > +    test_cmp expect repo/.git/info/sparse-checkout
> > +'
>
> > +test_expect_success 'sparse-checkout list deduplicates repeated cone p=
atterns' '
> > +    rm -f repo/.git/info/sparse-checkout &&
> > +    git -C repo sparse-checkout init --cone &&
> > +    git -C repo sparse-checkout add --stdin <<-\EOF &&
> > +     /foo/
> > +     /bar/
> > +     /foo/
> > +     EOF
> > +    git -C repo sparse-checkout list >actual &&
> > +    cat >expect <<-\EOF &&
> > +     bar
> > +     foo
> > +     EOF
> > +    test_cmp expect actual
> > +'
>
> This does lead to an interesting case where the 'list' command was only
> interacting with the sparse-checkout file, which wouldn't have duplicates
> if it was modified by the user in cone mode.
>
> Keep in mind that you're not actually testing the 'list' command, because
> the 'add' command already deduplicated. You'll need to modify the
> sparse-checkout file itself to get an interesting test of the 'list'
> command.
>
> When not in cone mode, we should not be removing duplicates because the
> order of the patterns matters and we should not be reordering them. I'm
> not sure if that's relevant but it's something to keep in mind while you'=
re
> testing, since the command will revert to non-cone mode if the
> sparse-checkout file doesn't match the cone mode pattern expectations.
>
> Thanks,
> -Stolee
>
