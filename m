Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793475521;
	b=RK5ZQ5/aPURidMIQrw1a/U9aJvlcJsUgCzfTZ6Bu6enmnoa2hhHieDZjBipUy3jf6dc4
	 cts9Pp0zP2ke1HvNCulT+TBCGVK4SvKy7Nz42hw6WPtUUsONS2aWvD1JP9C9xRuRHCS4y
	 Q7jJHCywGka6JGlgJnULMHwjkuNwF9a7xh6smMswTKS9WCQF0VNvkkR7xneOMCXa98kb7
	 HYif00asTdO8/BBkMsHoXLIB/vyAX/HeBOydSzzW1RgENn57Mqmo3oLlm3LQ5ndN7zqrT
	 WuovAvyvzakm8P1RendXU4KZTCN6cJeFZKVkm0q0K0vExJHDYulMzhbdky0zQ6wQaUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1M3f1MbMzGl6QwRIsDGgTRqCyxac15gl5OhnhsfLdN4=;
	b=x8/Nre6Wl+P32ouhXmkfYeMBqID6ChRSRWoylFRamJnX7kB5C22xQrIy/IhIK1md0b6B
	 EYcZ25/1F7OB6ADufDaTmz5jfT5kQkcbkC7gtcOFFnZ7e3OJCgNeDBJdkxXPj4sh6XPbH
	 BFnstdukrc5XtxilrWEQvLAdwgwne8EeuLQNiDRIlot6b7t9t/uHgSBewvnrQC9hqHOLh
	 ChvUXkcx3OLDUYgvb/OIBquxuvK4n8yeovYiQj2gNbZB8RcrU1qU6FWZWUhwFmhmnGYGf
	 wm6QIrTap9prWERbcDc9ZXBP+qMhVO5X672ktT5mrZicMqkuwlFgcZ+yPmABVCfYV+A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vKwFCiPk;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61401606A325
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 19:38:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61401606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vKwFCiPk
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-53665358476so21000311cf.2
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 12:38:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793475520; cv=none;
        d=google.com; s=arc-20260327;
        b=JsR41JPOyE/Snwce0oRuYEq0ehoUeMMRxWUaWmKWPvk/UsMHtTf6HuGs52ZAJfTI3j
         ndopMsH6KUSYyML0N4/LtBJbKlLr2mzqFwBAmY3ERsJE1evemZbDEAP9DtiUs5REIbcl
         oxiDxS/gP1XBHWJlLVL8t8WZ34IaYHUG59+YKFujYGNO0Y/as0Fhp/n/JIxKNvN5DOgr
         f83MgmRJh6YRh7uTVuz7e21UVi2lTNiAfTJMgCWpBiYNO4f/RyAbnxbequNswvlIdnMH
         XHnAERFsL/TYRLRpqmMsX3NUSKGf/+nxdSR7dGBZaTQ62qNRp+d3z/FjpMqW5jQgzZp/
         qm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1M3f1MbMzGl6QwRIsDGgTRqCyxac15gl5OhnhsfLdN4=;
        fh=NPey4pd7C6q72XSv4MeM9BaJkt+vqdaTphu57VQgzVo=;
        b=QM6bTbnTJJARq0SOqTRJ0nmu7CEAXYbFqzedvschb3ASTrNEllN1934Gmm4QFsrap0
         6hLVT9akqNtB+dTn9Advmsl20MWO4toHEufy1k+3m43BwWiQlyK0wcN3BTC3qyrAosX8
         rJPVrbNkFjhfA86PkuWkk9ci+8skqeKLg9oDHtIw2ykW9r6TuX9VYwHbXQqKdzC2eBWR
         k6xA2EvPosZZSmbp6UhuJy9Ek7kr26MccZ0P24cc9Rszxqhku+vCwVPk2RYKcInnIuNc
         rUGmvbbmuIPabdpqylQdAE8Y6QY6AtxlMcmwtsPdtpN9RI0iqtzRJ2ufEu4xjZNYA0RH
         zdWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793475520; x=1794080320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1M3f1MbMzGl6QwRIsDGgTRqCyxac15gl5OhnhsfLdN4=;
        b=vKwFCiPk5xDdURlJxIc58Ml3q6AXqGHSF4wHj4p2FRDpQugBr3PeinBqqf6nJcgReE
         Y33ScA9GMsMoz56/N4VnVcVUmLeQUzePVRzIEXmEl0724hPBAvXIDdVaoqvtqKDm+RDl
         iNVbjFFFuA7trHrpI91N4nqdohMZ3PV3g7aAHRSNa+X6CHOv9pcqrpsbOaSu/IJ2vUaV
         okkW65seC9I+m5P6D7WIs3ActmFzZgDv5yaZex4NJ0Vf9Rp2cBHi0cY/9F7Tn/txYEre
         2voSZ9SpMbs77nIgq22du88PsIzEkN4DHeSr71ub+fQlkd9TnQ54TJvh8A6sA1LfesMT
         7NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475520; x=1794080320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1M3f1MbMzGl6QwRIsDGgTRqCyxac15gl5OhnhsfLdN4=;
        b=ARwD0i0eB4BQBT9jcvPM1+gQwVZGXcq9PsiY882ux2DJgOSMyNcRnaKulWdf3B+0Qa
         x6qx/Qi74zRaPMOhRYdhtGr6zXmfgcBBUOD/nKs3xDPBwm+xfN0b2pNE2VJu7lol3tD9
         7YtbXTvJTAcXVyPoz0oZ733kvebghkNvOPPrH+Zu1sNxFs2CSoUvISoaRKEAxQbr1Uck
         YgogwWRv/He0TU7Nh4W1cKXUMFh9p1F8U1FRmK8aXuGKMDpzUNIz+KZRdnWKjsQSO34R
         jgKbIgdWtYUh/gBOVqfNa/D/Fs+kDoT2WQpWSLaBwBhPnvV5FrTimGigK64uwBZOCsoH
         EwLg==
X-Forwarded-Encrypted: i=1; AKwUvByvPVv1z+XhB054p/YA6sXm20qF84IAGbUPR7NGLgN6r/lEUBDnC1LSWZ0fxdXnZWrt2Vw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKwkAOMbLPaehG0HGb1O7nYU6ZdNUci+lltzLQfELhbgaJnO71Y
	dQNTwAKXLiurudkUx1eheWJCXHTQ0FhqhtUleXdFiNPCUEQt+mWRwPE2phcvjnqasjOmDDsBRVZ
	NgRarRDXprYvJAXBn4kc4IuW4UV+tvW8=
X-Gm-Gg: AYBFou2nWIJsDKd5SDikJueIvzxFeXveDD+v7YL7ZjHjWdRioq6zG4HLSY3bqRpNekY
	bNVWBFV1cr2qUUrFV8mqypsV3ZE0rlySnmGNJPnVpw7elmO7mGlNJwYNAYtxKkdPZ7h3dvHYJuq
	YR9uOU/E7azLyLXDFtZ+vDSm4IL6YziFlAj1HHOX43cHk5HEB/Jbp5Ij7zormtd/BweDdORUXK1
	67FqR4v75Pa5he2McgpxuUmZjXkA2C1EAMevl/dQidf2LtbqYdzBBP05K+Y9M/S+DnREZwJKI0W
	ezOlKIWgqvGk/Kn6lMqnTNlBrTHSCWpplmoyeFRJ5PijZXiEwii3WiWvnp9Z4TbEk0AjZ0unFIe
	QAREh7+T3kD4uxiHz6fHWijRUTQIcsQ0DkN2zJE2pKNdM3wMyuDn6FkyQRBOKjV/bGRhD2jjPxp
	9adRCg1LK/635g/R6WnqZiPra65LE67abrJQHFtP1BvLCRGD/jR1Eeb9un
X-Received: by 2002:a05:622a:394:b0:535:70b4:3f7c with SMTP id
 d75a77b69052e-542b7ff035emr91650341cf.66.1793475520182; Sat, 31 Oct 2026
 12:38:40 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com>
 <pull.2288.v2.git.1793473062113.gitgitgadget@gmail.com> <CAFpMFfAeMtJ=qTt757aEvMfFyw1nEkB8d07b4wgaTJuQ2tnKiQ@mail.gmail.com>
In-Reply-To: <CAFpMFfAeMtJ=qTt757aEvMfFyw1nEkB8d07b4wgaTJuQ2tnKiQ@mail.gmail.com>
From: Srujith Poojary <poojarysrujith@gmail.com>
Date: Sun, 1 Nov 2026 01:07:50 +0530
X-Gm-Features: AclHuK81T98sUifIF05hc60o5Md7nDJPrv7_SvVUOWJrFwtomqoV7aqYSqPg1_E
Message-ID: <CABh_KWgi2EVHBdL94J2wByrdjTqggXGa9sj9xoaNTS6ppU3qqg@mail.gmail.com>
Subject: Re: [PATCH v2] Submodule: use the submodule repository to abbreviate commits
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 12:39=E2=80=AFAM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> Hi Srujith,
>
> On Sat, Oct 31, 2026 at 7:57 PM Srujith A Poojary via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > + struct repository *repo =3D sub ? sub : o->repo;
>
> Thanks, v2 looks good to me.
>
> > Submodule: use the submodule repository to abbreviate commits
>
> One small nit: "git log --no-merges submodule.c" shows the area is
> always written in lowercase ("submodule:"), so "submodule: use the
> submodule repository to abbreviate commits" would match.
>
> Thanks,
> Okhuomon
>
> On Sat, Oct 31, 2026 at 7:57=E2=80=AFPM Srujith A Poojary via GitGitGadge=
t
> <gitgitgadget@gmail.com> wrote:
> >
> > From: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> > The commit IDs shown in a submodule diff header belong to the
> > submodule's object database. However, strbuf_add_unique_abbrev()
> > uses the_repository, so it checks the superproject's object
> > database when abbreviating those IDs.
> >
> > Use the submodule repository when it is available, and fall back
> > to the repository from the diff options when it is not.
> >
> > Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> > ---
> >     [Outreachy PATCH] t4041: use submodule repository for commit
> >     abbreviations
> >
> > Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%=
2Fpoojarysrujith%2Fmicroproject-git-libification-v2
> > Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/poo=
jarysrujith/microproject-git-libification-v2
> > Pull-Request: https://github.com/gitgitgadget/git/pull/2288
> >
> > Range-diff vs v1:
> >
> >  1:  7b2af1b46a ! 1:  3133cd3017 [Outreachy PATCH] t4041: use submodule=
 repository for commit abbreviations
> >      @@ Metadata
> >       Author: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> >        ## Commit message ##
> >      -    [Outreachy PATCH] t4041: use submodule repository for commit =
abbreviations
> >      +    Submodule: use the submodule repository to abbreviate commits
> >
> >      -    Use the submodule repository when abbreviating commit IDs in
> >      -    submodule diff headers, so uniqueness is checked against the
> >      -    correct object database.
> >      +    The commit IDs shown in a submodule diff header belong to the
> >      +    submodule's object database. However, strbuf_add_unique_abbre=
v()
> >      +    uses the_repository, so it checks the superproject's object
> >      +    database when abbreviating those IDs.
> >      +
> >      +    Use the submodule repository when it is available, and fall b=
ack
> >      +    to the repository from the diff options when it is not.
> >
> >           Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> >
> >        ## submodule.c ##
> >       @@ submodule.c: static void show_submodule_header(struct diff_opt=
ions *o,
> >      +          struct commit **left, struct commit **right,
> >      +          struct commit_list **merge_bases)
> >      + {
> >      ++ struct repository *repo =3D sub ? sub : o->repo;
> >      +  const char *message =3D NULL;
> >      +  struct strbuf sb =3D STRBUF_INIT;
> >      +  int fast_forward =3D 0, fast_backward =3D 0;
> >      +@@ submodule.c: static void show_submodule_header(struct diff_opt=
ions *o,
> >
> >        output_header:
> >         strbuf_addf(&sb, "Submodule %s ", path);
> >       - strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> >      -+ if (sub)
> >      -+         strbuf_repo_add_unique_abbrev(&sb, sub, one, DEFAULT_AB=
BREV);
> >      -+ else
> >      -+         strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> >      ++ strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
> >         strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "..=
.");
> >       - strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
> >      -+ if (sub)
> >      -+         strbuf_repo_add_unique_abbrev(&sb, sub, two, DEFAULT_AB=
BREV);
> >      -+ else
> >      -+         strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
> >      ++ strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
> >         if (message)
> >                 strbuf_addf(&sb, " %s\n", message);
> >         else
> >
> >
> >  submodule.c                      |  5 +++--
> >  t/t4041-diff-submodule-option.sh | 18 ++++++++++++++++++
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> >
> > diff --git a/submodule.c b/submodule.c
> > index 6fcb606f7e..1302c11ddf 100644
> > --- a/submodule.c
> > +++ b/submodule.c
> > @@ -543,6 +543,7 @@ static void show_submodule_header(struct diff_optio=
ns *o,
> >                 struct commit **left, struct commit **right,
> >                 struct commit_list **merge_bases)
> >  {
> > +       struct repository *repo =3D sub ? sub : o->repo;
> >         const char *message =3D NULL;
> >         struct strbuf sb =3D STRBUF_INIT;
> >         int fast_forward =3D 0, fast_backward =3D 0;
> > @@ -599,9 +600,9 @@ static void show_submodule_header(struct diff_optio=
ns *o,
> >
> >  output_header:
> >         strbuf_addf(&sb, "Submodule %s ", path);
> > -       strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> > +       strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
> >         strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "..=
.");
> > -       strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
> > +       strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
> >         if (message)
> >                 strbuf_addf(&sb, " %s\n", message);
> >         else
> > diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-=
option.sh
> > index 4dd4954260..e80472af32 100755
> > --- a/t/t4041-diff-submodule-option.sh
> > +++ b/t/t4041-diff-submodule-option.sh
> > @@ -14,6 +14,24 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> >
> >  . ./test-lib.sh
> >
> > +test_expect_success SHA1 'submodule commit abbreviation uses submodule=
 object database' '
> > +       test_when_finished "rm -rf collision-super" &&
> > +       git init -q collision-super &&
> > +       git init -q collision-super/sm1 &&
> > +       printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n\nb1rwzyc3\n" >collision-=
super/sm1/a0blgqsjc &&
> > +       git -C collision-super/sm1 add a0blgqsjc &&
> > +       tree=3D$(git -C collision-super/sm1 write-tree) &&
> > +       commit1=3D$(GIT_AUTHOR_DATE=3D"1112911993 -0700" GIT_COMMITTER_=
DATE=3D"1112911993 -0700" git -C collision-super/sm1 commit-tree "$tree" -m=
 a2onsxbvj) &&
> > +       commit2=3D$(printf "child\n" | GIT_AUTHOR_DATE=3D"1112912053 -0=
700" GIT_COMMITTER_DATE=3D"1112912053 -0700" git -C collision-super/sm1 com=
mit-tree "$tree" -p "$commit1") &&
> > +       git -C collision-super/sm1 checkout -q "$commit2" &&
> > +       git -C collision-super update-index --add --cacheinfo 160000,"$=
commit1",sm1 &&
> > +       git -C collision-super commit -q -m "Add submodule" &&
> > +       git -C collision-super diff --submodule=3Dlog >actual &&
> > +       printf "Submodule sm1 0000000000e..%s:\n  > child\n" \
> > +               "$(git -C collision-super/sm1 rev-parse --short "$commi=
t2")" >expected &&
> > +       test_cmp expected actual
> > +'
> > +
> >  # Test non-UTF-8 encoding in case iconv is available.
> >  if test_have_prereq ICONV
> >  then
> >
> > base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
> > --
> > gitgitgadget

Hi Okhuomon,

Thanks for pointing that out. I've corrected the subject to use
lowercase `submodule` and submitted v3.

Regards,
Srujith
> >
