Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793473760;
	b=D2jRHPeNp4hxOmJBp3XkDV8QuE3Qn/CoSwjrFNbYH1ZzLYn0LuIgIDMO4w5uVgwv57mU
	 V4Gaxo+2Kf8QmftcWdYsnWtF8hH4zvOcpgVmhvi+esQG+r1tEOHFZbkYVt83NiYeaXfy/
	 ilvLpG7POYrM1QRjVoVFNlLgGDgu6U3fFzjfjrgNaggtqAzXd6SYjSW6nv081KLhzyDwN
	 8L8A3k+/J0cPwK4hARhZJUY3gIPR9znQeidFeTzznbbZ4sEg6nDLACwSdRDUUwUrS4TYu
	 9HO3lZ8hRi3dob/fqRGi8gWSbSv/OwlB1uYhq2kZ3RVSplm1M90ZGdI19k0q73ARyRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793473760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=63FtY+OU5OlOXJzwqbDOeHJxvzvmm+Xxbjg9nyzItqM=;
	b=3taOXu00gaqV8jH45QWPnKrrCeA9/crHdSX6LpOanLKiihsUHOavj35pIJz4JTOjkeza
	 kfO41dgviW8FuLmbDfZUKvcMLVPv69q63BEtqkuUWMCQtXgELtLE5PyzMO+dHMXgQbfox
	 Sac9JrFF7m3liYP6fvHCVc8gU4RDBIA/2LpzFl5HEs1rum3z7Sa/GucbSg4b6RA7WAS3Y
	 6+dcRHDHIQ+9ZNndeWHkkQCY08nKM+v/te4lWBUVO52NIdC8RvX4rfgvTmBUW4nTETb9x
	 dxSokoHmKyB69gmNm97mmefaTYZYUEoSso4snbCQrXWkM497AMkNIkA7+5bgyeJBN5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y+inRLeb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A9606A31A
	for <git@vger.kernel.org>; Sat, 31 Oct 2026 19:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A68A9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y+inRLeb
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b125371596so22051567b3.0
        for <git@vger.kernel.org>; Sat, 31 Oct 2026 12:09:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793473758; cv=none;
        d=google.com; s=arc-20260327;
        b=Hikg10tvRpMTeMlCU+ZLyFRAGUW5+5RDP3V676id/vAhMNIt69zQUN6D1CuSgr7hPJ
         ewf710UFAAF/QLXGWIJ72rVt7Vjona3VxC3+XR5AxZ78j/TNvnRLHp1pt4TgXoMa8d9d
         N1QhgjHIppXleg1kJ60nNLpNTOS10QvgWXPqsOv1x6TFJzy75QkB6i1slRzkikwU5qdK
         ySD36f21VlApl2CYAGi1ue9uRWy7rUOp9OhzZhLPTv9tYNniFWhtFk0TARHzdhEc9Q/C
         Lzbig5Rr4R3ZKovkH2s6joKStvqCinLgahruT1aAQ6cs54iTJKlvMu3JxKdWD0P9Nqjg
         7s2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=63FtY+OU5OlOXJzwqbDOeHJxvzvmm+Xxbjg9nyzItqM=;
        fh=GV+q3+xoptdzTjdo/fAURyeoLF5hkow4oLuqL90b9Bg=;
        b=G9GbLsG/F7bWaMXL9OAkFufgrcNHux363jc2DFAn20/Ru7ky4c/Qzmf9HH9FdNYzRK
         K0pzWqAZdzrylrrxjm6fkthqeVN7N4bMeT46XXLlDkygII6kbtPMXnOqL6KjRlHe9y/Z
         FJNXqaby0gY2DHn0a1ZlUVsejsw45F1hvgJZ/4UheIYtSCEgCeN3CAFIMZyLhQjx3deV
         g8QXpY/fLg4Q325le0qwwvv1rqmOtY2vqeTE3QzS/VwSSvxbToRvswVBaTvWEqUUgHzY
         NpARtNuBxis6jE/+DPPRTo7D0iWurMY+jbldIhT5ItAI3+/SIFsj+v5PnE/7N0noALmO
         jWKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793473758; x=1794078558; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63FtY+OU5OlOXJzwqbDOeHJxvzvmm+Xxbjg9nyzItqM=;
        b=Y+inRLebSj/8YSwsyGyX3tpR6Wqi4xv+kOIFnXFfwbYt50+0cAgwQqM9h4XjljU4xg
         x/OoGQyLYrQrwfJzIqjVEOTC/BJrP1QMy9e2hUGIDQzHVKWggKvKjqrR99LTreQz1Ouw
         m0Mnk4+lSxdyTvWeZZPVnQU61qocxHYrY07bvUJMHQ71c2WwtOOU9oWJkSVan5tYLa38
         iH/jfm1psJIFBapMBjZaMZo2NP+340duLieSLN1Wp3Igl21diYNqWld6c38Q4wSVPdU2
         6/+yS8bwNq9rqbrpc8JpZujZ8Kphf/+AmPz7jDSwmajuWfhKHRN0jxvpYYTS92DI8AlR
         PQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793473758; x=1794078558;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63FtY+OU5OlOXJzwqbDOeHJxvzvmm+Xxbjg9nyzItqM=;
        b=Y4liATw1QsAJDGETUbZ6eoG36Wnfndixonj54vVllzraTEgov4K/d5yDpMdrEIZbGJ
         V0/5zh7RWNa70+cO057wDs7ZrQGMrP/8WiuCAdC4IcbWqCjClAxmPoKOhXSF7E9JamW6
         +j6IpdlOnAdx0z9/sXswFIdbcQBrTox9cdJfRt/Rddw5QOBjZ9q/27SU3Ud6e/ISYLQk
         XgCu62wjurksCwoRN50HrRI9MsvDLfl/SAiZv14fZ7uCqA9KmY9m5rMmSv2UMWFunMJo
         +iFnIo8hLnPco9Y8lf1vcanPJBNl/2Rw5+Wq4bgI7+yJcrAgVOgiifCD5fR2HujqvjSX
         nrkQ==
X-Gm-Message-State: APuU4Z+1ZAcvccxm0LWngBhDsbVa0nAJil8to2QmzS9EH2DMl2WjU/B5
	2oK5IJcBUlyjN4JQrI7t+ujqWCVzrddwLnCuenxAQgU9rZBuc9Sngs7RPsMJQX2VLxJIc6dEdVc
	kcqF3bxvaKP5gYX7NFeB3Ie81t6x/3oo=
X-Gm-Gg: AYBFou0Z6D3tD8cGty1UQM9s/TaM3PNkBOiq0olaXxggt2Iv+KH/ds+oBd7z/yk23vX
	bUyN4RKe3tEjF2ZlFvDJIks1YrWV4V5SBO726DeSYAV9PAmS3MOrTJQAoQE4WW22/Ri82EYViBl
	OAu8VxGapKnF1zYGqg2fe3wexsFfFielhEopuGFXbHk0MjfZ23ED27hKEMjgqr9/7PGf9POuFkB
	DVjWN2Sf/l6dqXjpjNCzafeWWMmPIZMOfWgoRZGIej3wYvwDzDlMa7g7Od3ffdBdsAXtE9HrSQ5
	1FC1DL7qTpMpRI/JbuCpLj/mEyITmcyi1gTCrGIJhzVlAV+xFIToIbymzlydAv4zlNGat32sJle
	RAV8lsIyBJMnrSwwAL7LvzQGmFjidU68L5pq+hXXTr4GNbcek25Il2XakUOrse52er4K4dafK1X
	WNkHX5s6K/Hh2mwaq2JtDIYo4V3CnPyXIzX+5SypCMLX8Im8funaXfIOhkaxyN3/pn/5eptcsBA
	uQlBAvFsQldQ5TA2I/P6VMKc1cEPyi5rj1fztZvvWLoAZy5Qdmw1EIa9pWFjw==
X-Received: by 2002:a05:690c:81:b0:8b1:368b:3935 with SMTP id
 00721157ae682-8b2b66cc36amr41247457b3.10.1793473758548; Sat, 31 Oct 2026
 12:09:18 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2288.git.1793435149942.gitgitgadget@gmail.com> <pull.2288.v2.git.1793473062113.gitgitgadget@gmail.com>
In-Reply-To: <pull.2288.v2.git.1793473062113.gitgitgadget@gmail.com>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Sat, 31 Oct 2026 20:09:07 +0100
X-Gm-Features: AclHuK93ToRjRsKa10Irz1TAqVLamQcrapEvPxCxQtwdDSeDlPKUz9fZf4adUFI
Message-ID: <CAFpMFfAeMtJ=qTt757aEvMfFyw1nEkB8d07b4wgaTJuQ2tnKiQ@mail.gmail.com>
Subject: Re: [PATCH v2] Submodule: use the submodule repository to abbreviate commits
To: Srujith A Poojary via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Srujith A Poojary <poojarysrujith@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Srujith,

On Sat, Oct 31, 2026 at 7:57 PM Srujith A Poojary via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> + struct repository *repo =3D sub ? sub : o->repo;

Thanks, v2 looks good to me.

> Submodule: use the submodule repository to abbreviate commits

One small nit: "git log --no-merges submodule.c" shows the area is
always written in lowercase ("submodule:"), so "submodule: use the
submodule repository to abbreviate commits" would match.

Thanks,
Okhuomon

On Sat, Oct 31, 2026 at 7:57=E2=80=AFPM Srujith A Poojary via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Srujith A Poojary <poojarysrujith@gmail.com>
>
> The commit IDs shown in a submodule diff header belong to the
> submodule's object database. However, strbuf_add_unique_abbrev()
> uses the_repository, so it checks the superproject's object
> database when abbreviating those IDs.
>
> Use the submodule repository when it is available, and fall back
> to the repository from the diff options when it is not.
>
> Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
> ---
>     [Outreachy PATCH] t4041: use submodule repository for commit
>     abbreviations
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2288%2F=
poojarysrujith%2Fmicroproject-git-libification-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2288/pooja=
rysrujith/microproject-git-libification-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/2288
>
> Range-diff vs v1:
>
>  1:  7b2af1b46a ! 1:  3133cd3017 [Outreachy PATCH] t4041: use submodule r=
epository for commit abbreviations
>      @@ Metadata
>       Author: Srujith A Poojary <poojarysrujith@gmail.com>
>
>        ## Commit message ##
>      -    [Outreachy PATCH] t4041: use submodule repository for commit ab=
breviations
>      +    Submodule: use the submodule repository to abbreviate commits
>
>      -    Use the submodule repository when abbreviating commit IDs in
>      -    submodule diff headers, so uniqueness is checked against the
>      -    correct object database.
>      +    The commit IDs shown in a submodule diff header belong to the
>      +    submodule's object database. However, strbuf_add_unique_abbrev(=
)
>      +    uses the_repository, so it checks the superproject's object
>      +    database when abbreviating those IDs.
>      +
>      +    Use the submodule repository when it is available, and fall bac=
k
>      +    to the repository from the diff options when it is not.
>
>           Signed-off-by: Srujith A Poojary <poojarysrujith@gmail.com>
>
>        ## submodule.c ##
>       @@ submodule.c: static void show_submodule_header(struct diff_optio=
ns *o,
>      +          struct commit **left, struct commit **right,
>      +          struct commit_list **merge_bases)
>      + {
>      ++ struct repository *repo =3D sub ? sub : o->repo;
>      +  const char *message =3D NULL;
>      +  struct strbuf sb =3D STRBUF_INIT;
>      +  int fast_forward =3D 0, fast_backward =3D 0;
>      +@@ submodule.c: static void show_submodule_header(struct diff_optio=
ns *o,
>
>        output_header:
>         strbuf_addf(&sb, "Submodule %s ", path);
>       - strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
>      -+ if (sub)
>      -+         strbuf_repo_add_unique_abbrev(&sb, sub, one, DEFAULT_ABBR=
EV);
>      -+ else
>      -+         strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
>      ++ strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
>         strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "..."=
);
>       - strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
>      -+ if (sub)
>      -+         strbuf_repo_add_unique_abbrev(&sb, sub, two, DEFAULT_ABBR=
EV);
>      -+ else
>      -+         strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
>      ++ strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
>         if (message)
>                 strbuf_addf(&sb, " %s\n", message);
>         else
>
>
>  submodule.c                      |  5 +++--
>  t/t4041-diff-submodule-option.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index 6fcb606f7e..1302c11ddf 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -543,6 +543,7 @@ static void show_submodule_header(struct diff_options=
 *o,
>                 struct commit **left, struct commit **right,
>                 struct commit_list **merge_bases)
>  {
> +       struct repository *repo =3D sub ? sub : o->repo;
>         const char *message =3D NULL;
>         struct strbuf sb =3D STRBUF_INIT;
>         int fast_forward =3D 0, fast_backward =3D 0;
> @@ -599,9 +600,9 @@ static void show_submodule_header(struct diff_options=
 *o,
>
>  output_header:
>         strbuf_addf(&sb, "Submodule %s ", path);
> -       strbuf_add_unique_abbrev(&sb, one, DEFAULT_ABBREV);
> +       strbuf_repo_add_unique_abbrev(&sb, repo, one, DEFAULT_ABBREV);
>         strbuf_addstr(&sb, (fast_backward || fast_forward) ? ".." : "..."=
);
> -       strbuf_add_unique_abbrev(&sb, two, DEFAULT_ABBREV);
> +       strbuf_repo_add_unique_abbrev(&sb, repo, two, DEFAULT_ABBREV);
>         if (message)
>                 strbuf_addf(&sb, " %s\n", message);
>         else
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-op=
tion.sh
> index 4dd4954260..e80472af32 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -14,6 +14,24 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  . ./test-lib.sh
>
> +test_expect_success SHA1 'submodule commit abbreviation uses submodule o=
bject database' '
> +       test_when_finished "rm -rf collision-super" &&
> +       git init -q collision-super &&
> +       git init -q collision-super/sm1 &&
> +       printf "0\n1\n2\n3\n4\n5\n6\n7\n8\n9\n\nb1rwzyc3\n" >collision-su=
per/sm1/a0blgqsjc &&
> +       git -C collision-super/sm1 add a0blgqsjc &&
> +       tree=3D$(git -C collision-super/sm1 write-tree) &&
> +       commit1=3D$(GIT_AUTHOR_DATE=3D"1112911993 -0700" GIT_COMMITTER_DA=
TE=3D"1112911993 -0700" git -C collision-super/sm1 commit-tree "$tree" -m a=
2onsxbvj) &&
> +       commit2=3D$(printf "child\n" | GIT_AUTHOR_DATE=3D"1112912053 -070=
0" GIT_COMMITTER_DATE=3D"1112912053 -0700" git -C collision-super/sm1 commi=
t-tree "$tree" -p "$commit1") &&
> +       git -C collision-super/sm1 checkout -q "$commit2" &&
> +       git -C collision-super update-index --add --cacheinfo 160000,"$co=
mmit1",sm1 &&
> +       git -C collision-super commit -q -m "Add submodule" &&
> +       git -C collision-super diff --submodule=3Dlog >actual &&
> +       printf "Submodule sm1 0000000000e..%s:\n  > child\n" \
> +               "$(git -C collision-super/sm1 rev-parse --short "$commit2=
")" >expected &&
> +       test_cmp expected actual
> +'
> +
>  # Test non-UTF-8 encoding in case iconv is available.
>  if test_have_prereq ICONV
>  then
>
> base-commit: 50fe5cc63f9cd6e89b87a2c9ccf96a444f4cfdb7
> --
> gitgitgadget
>
