Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21AE231C9C
	for <git@vger.kernel.org>; Mon, 13 Jan 2025 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736752337; cv=none; b=jy1t1wdCf51ffQNC54hkWhkYINnQ3ftcPqt4R12ZUVkuBJrim31GtH0LDzf+Yy+UDj+sSQmx1TTM333ZQyLMPMAealGUZ0wpPqoSuyg5Yx36BrdTKP4FbGXH7XTR3x8wItWXfsnAHjwaY8aW+ZJeEnikypRN3kWCg89jUy/GGUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736752337; c=relaxed/simple;
	bh=pEmCKzmRitZQuYcoe6C0TPWVGaDf2IW4g8IgHwtpHoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vh+vzrjPbMCie8nv3eVTeU59a0bzOPnwzfaTHzurBNo7uQKtABF0hxneq2oAgCqXLWzzDkVsJoEGrWqtzTVJr0cAVINSxvpGsM0dLZ+dQtv6BpAqznvMru/tEXgPXuUxHi/EuCRCmDri/NI93tuCxgEnXKDqaHJY1hQWajmLACM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KIxdewvT; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIxdewvT"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d122cf8dd1so6621411a12.2
        for <git@vger.kernel.org>; Sun, 12 Jan 2025 23:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736752333; x=1737357133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pTnjOYiUelrgtEG/DzDjrjKjWQd/b0zO1DXVd2NM6fM=;
        b=KIxdewvT7Qmc8bDmlX4mofQ5H2kMrwbOIoYDI5UyNiT0rLA7E6f4Wj3+YnuYLs3Pqi
         /Jxe21rEK/rmz8iBadzHx2iVASSkAM9x0pbuLNjIzQH0ji2nMyTmQTVmGUEJD9RNU/o3
         9WQKm11aR2y0x5XYC+bPWN6MmMuKzHiUeB4QBSR854cCD1/tt6p8ru3QMAwvtvRWPaPF
         IwHS5uk9paQAPW2u7nOPAKVyzWGMoYKKBXQli+TW2jKe63c2HYUUOgWbxVQWDH11TE0z
         +ojXzwfXa3FimjF8EEbPk7UC35EEVR9UsLFuQg0Hzk4OkHtFjww6BTEbPilhgdVS0ovx
         P/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736752333; x=1737357133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pTnjOYiUelrgtEG/DzDjrjKjWQd/b0zO1DXVd2NM6fM=;
        b=nzC5iAuBCSn8rY7VriIpnasU1hfbBXblPULPgYjmWJsNJHxUSxWjKWqO9R1XLhnYaA
         RCqLmRveCCH4F5iSbtJWe3K0RfFNHeSiIu45JDbk4Cpv0E4iDLHKsJmhhmQ2vimUXgir
         HsDOaoOig35g1OHo3To/FtiJims/+HmFXnYzYowMLj5hYv7lI1BO7zrgrFdwLTrvkmzz
         vbLoOburOubLlsQGR6C+XJxzNfarNOOtSTT3kqTOHkaQCI1w/gp9UckqEEFzl91+zN2e
         pKnJb2tkKclN4hR97xlMRx3gEQ0js93d1mOk6X/fVfwUKJ05IwpQNQuMX0yJw//phqsL
         cYxA==
X-Gm-Message-State: AOJu0Yx3lPoq9iNcbev7iJVnxrMIILl1WJKOkPKx5nXLTJRJO4nGp0wU
	KL0zFWGnRVpMrH13PzPOwFSJ6/Vxiu4n1CEXlQ6xjdO8KDoD6T2kttxZs55AJojDvD83VVH9cly
	baw9EC2BcDO0ct7j981lGVlx4VT5F/waLIpfTUw==
X-Gm-Gg: ASbGncuYJa9cqrdzoKi6c/i5ZqHnxr1/Iqq3CHIOIcxQtQeukNU/HODsOSE7y5tibNh
	xl5fmELiBsLtES6Bsk9zAzN+OF7VQxsLipd8VD+k=
X-Google-Smtp-Source: AGHT+IHyhVk6z0C98UTRfXblFq6uR0pu8L+/li+BiVhqI6qeK0fZlW748B5sTIHwoxjkcZttbJT/OAEyZEsT8M9v/RU=
X-Received: by 2002:a05:6402:4407:b0:5d3:d733:7ad4 with SMTP id
 4fb4d7f45d1cf-5d972dfe6abmr18793375a12.3.1736752333361; Sun, 12 Jan 2025
 23:12:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1843.git.1735041177817.gitgitgadget@gmail.com>
 <pull.1843.v2.git.1735611513.gitgitgadget@gmail.com> <14e94bf04e5ae3895eb61253be9c6d0a0fe56328.1735611513.git.gitgitgadget@gmail.com>
In-Reply-To: <14e94bf04e5ae3895eb61253be9c6d0a0fe56328.1735611513.git.gitgitgadget@gmail.com>
From: ZheNing Hu <adlternative@gmail.com>
Date: Mon, 13 Jan 2025 15:12:01 +0800
X-Gm-Features: AbW1kvY0eOLinryI5QkM6KGCWvQvE8B6TQkg3TH2uZsWpU1kjfo5ybIN2v-q5hU
Message-ID: <CAOLTT8Qj=mA6j55HOShobQSkCn-VCbPoMChE_y1xBo=O4dyFxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gc: add `--expire-to` option
To: Git List <git@vger.kernel.org>
Cc: gitster@pobox.com, me@ttaylorr.com, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch has been sitting for weeks with no review. Does anyone want
to help take a look?

ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com> =E4=BA=8E2024=E5=B9=B4=
12=E6=9C=8831=E6=97=A5=E5=91=A8=E4=BA=8C 10:18=E5=86=99=E9=81=93=EF=BC=9A
>
> From: ZheNing Hu <adlternative@gmail.com>
>
> This commit extends the functionality of `git gc`
> by adding a new option, `--expire-to=3D<dir>`. Previously,
> this feature was implemented in `git repack` (see 91badeb),
> allowing users to specify a directory where unreachable and
> expired cruft packs are stored during garbage collection.
> However, users had to run `git repack --cruft --expire-to=3D<dir>`
> followed by `git prune` to achieve similar results within `git gc`.
>
> By introducing `--expire-to=3D<dir>` directly into `git gc`,
> we simplify the process for users who wish to manage their
> repository's cleanup more efficiently. This change involves
> passing the `--expire-to=3D<dir>` parameter through to `git repack`,
> making it easier for users to set up a backup location for cruft
> packs that will be pruned.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  Documentation/git-gc.txt | 6 ++++++
>  builtin/gc.c             | 6 +++++-
>  t/t6500-gc.sh            | 6 ++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 370e22faaeb..b4c0cf02972 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -69,6 +69,12 @@ be performed as well.
>         the `--max-cruft-size` option of linkgit:git-repack[1] for
>         more.
>
> +--expire-to=3D<dir>::
> +       When packing unreachable objects into a cruft pack, write a cruft
> +       pack containing pruned objects (if any) to the directory `<dir>`.
> +       See the `--expire-to` option of linkgit:git-repack[1] for
> +       more.
> +
>  --prune=3D<date>::
>         Prune loose objects older than date (default is 2 weeks ago,
>         overridable by the config variable `gc.pruneExpire`).
> diff --git a/builtin/gc.c b/builtin/gc.c
> index d52735354c9..77904694c9f 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -136,6 +136,7 @@ struct gc_config {
>         char *prune_worktrees_expire;
>         char *repack_filter;
>         char *repack_filter_to;
> +       char *repack_expire_to;
>         unsigned long big_pack_threshold;
>         unsigned long max_delta_cache_size;
>  };
> @@ -441,6 +442,8 @@ static void add_repack_all_option(struct gc_config *c=
fg,
>                 if (cfg->max_cruft_size)
>                         strvec_pushf(&repack, "--max-cruft-size=3D%lu",
>                                      cfg->max_cruft_size);
> +               if (cfg->repack_expire_to)
> +                       strvec_pushf(&repack, "--expire-to=3D%s", cfg->re=
pack_expire_to);
>         } else {
>                 strvec_push(&repack, "-A");
>                 if (cfg->prune_expire)
> @@ -675,7 +678,6 @@ struct repository *repo UNUSED)
>         const char *prune_expire_sentinel =3D "sentinel";
>         const char *prune_expire_arg =3D prune_expire_sentinel;
>         int ret;
> -
>         struct option builtin_gc_options[] =3D {
>                 OPT__QUIET(&quiet, N_("suppress progress reporting")),
>                 { OPTION_STRING, 0, "prune", &prune_expire_arg, N_("date"=
),
> @@ -694,6 +696,8 @@ struct repository *repo UNUSED)
>                            PARSE_OPT_NOCOMPLETE),
>                 OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
>                          N_("repack all other packs except the largest pa=
ck")),
> +               OPT_STRING(0, "expire-to", &cfg.repack_expire_to, N_("dir=
"),
> +                          N_("pack prefix to store a pack containing pru=
ned objects")),
>                 OPT_END()
>         };
>
> diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
> index ee074b99b70..d4b0653a9b7 100755
> --- a/t/t6500-gc.sh
> +++ b/t/t6500-gc.sh
> @@ -339,6 +339,12 @@ test_expect_success 'gc.maxCruftSize sets appropriat=
e repack options' '
>         test_subcommand $cruft_max_size_opts --max-cruft-size=3D3145728 <=
trace2.txt
>  '
>
> +test_expect_success '--expire-to sets appropriate repack options' '
> +       mkdir expired &&
> +       GIT_TRACE2_EVENT=3D$(pwd)/trace2.txt git -C cruft--max-size gc --=
cruft --expire-to=3D./expired/pack &&
> +       test_subcommand $cruft_max_size_opts --expire-to=3D./expired/pack=
 <trace2.txt
> +'
> +
>  run_and_wait_for_gc () {
>         # We read stdout from gc for the side effect of waiting until the
>         # background gc process exits, closing its fd 9.  Furthermore, th=
e
> --
> gitgitgadget
>
