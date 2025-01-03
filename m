Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C1913BAE3
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735880257; cv=none; b=X1/nPPy49vnmp4Pu2rYc5m3ZT167UjWoilwujzOHgurAH6upZzGpqKM9LwYDhwbA+ykR7smZemw7k34Cn3W66GdYo5larzlFF8J31vYSgAhSeUXkRjrV271tWOYovAIkTYlk10DTpKDQ7/dtOTbHgSE7r3Zfvi9iJjqVFDZc4Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735880257; c=relaxed/simple;
	bh=r+DVFA6lav0n/dr7XBuJjd3GGz8kr3y8qpzXrkKCswY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2FwAnekOdVtn2wtzgKPrZDjX0gfTgs7s5zEKUjG25CDxDo3nEa7CbqwbSXcBrdo4iyJieJBa7gbY8dMGHn2gx0CmVimKBXdxdKQ7bxObXDZhZpcowiaJa6qRs+y0dYx5M+ovGtfmeme4VrEWWU+J7kbOL5KuaCGF0EMNcYc+mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUxrVKzL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUxrVKzL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso1742914a12.1
        for <git@vger.kernel.org>; Thu, 02 Jan 2025 20:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735880253; x=1736485053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktGXcpDwxRqMj5a7eWj9mrjql/dZeo4NtD1wleHBwMM=;
        b=FUxrVKzL/uU4KtmFuF2BwLf5btahi8iSVocdeZnUfkRZvZSiNHL/OrywNZNSUjV0u9
         ndAA9oqDqkwyOUo03OZNZPQzHOeUuJj1Fglxyv8JBVMeO0gxGfIa+8MPvF2gC8ZRRWIF
         E+d3/Drv9BS+8cEbqX2ZT8mMmuxrCgd4UN6kapfBIYBnQhiWcwK1cdxInQEBy+WkslX2
         kGNQus6MJwOs+5XCsXuPtqIfCW+arE3X8ly0ZkN31rEpqFm1mUa4Ik5d7cfc3SgJnU4/
         tyBCbhLkrWcs9/oUGNwGYrQHlvJi8lP3gqXvLWMbBgQS8nv8nS6eEtymm2PL9DvQzvV3
         mvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735880253; x=1736485053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ktGXcpDwxRqMj5a7eWj9mrjql/dZeo4NtD1wleHBwMM=;
        b=BE6NrDRseATiN/C2kwkAioTTEQPAsWuOHM0Zwl9lCQJbhSP0+xmV3cYbzowC5jdlBM
         z09Z3gPWt/jkCtl0GFWBDIt3Sc1lR2MBh6yO31iZk+7+B1xuOeWmb+kuzVSXB/BlCdbE
         9yMS8PNU5eLToTEWoJc2Rg4Py2a3SvnNKTsFfqqD7HrifY4tDabcvIioag70Q1lO2iOz
         Yly/euwpvMipOUTb/LMFRSy3v4DxwnvlrVmUgHsshLyNK4SDlOFhj7OSZ3p9pcISC3Nw
         LcsR0EZ7UdivIF9pPbb/QNaxqXVpBOLRcfcw8w2h3qssctTfP3xRFLtCiWWovwNjI2rl
         rNxw==
X-Gm-Message-State: AOJu0YyWx5ZaxiDnqfi+OzuRPgkGPuLqKvHX5C/NuXFU87Er0Sbj+1Hv
	3NOTQYX8Ugwhup0MZ1nkm6XB4dbhOJx2YxDIdGqOKE8RMthOLtfiy9mt7B7ET/R/eCTWNq26p4I
	3Nqk4J8dMrzaaoWocEtl/jEPYAZY=
X-Gm-Gg: ASbGncv8UivksqnuVOr52ChBCbuLh+jthjWpBEkhKCBIRJFY7dPVNCPuNfHwGtghDa5
	PMn35z0OFoTYa7BXoSmajeQ5Bh9zVfcS7npUQMg==
X-Google-Smtp-Source: AGHT+IF1ZJd3NQcPODmw1KtBjEGXVzKip4SjNuiAjVAppo7Qy7BQHcws4F/onbTY4joloeMZRtlgo9g2oUQksfFioIo=
X-Received: by 2002:a17:906:730f:b0:aa6:80ed:e9a3 with SMTP id
 a640c23a62f3a-aac2d47a722mr4739849766b.35.1735880253126; Thu, 02 Jan 2025
 20:57:33 -0800 (PST)
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
Date: Fri, 3 Jan 2025 12:57:21 +0800
Message-ID: <CAOLTT8TKC5cKPudWjfBtaXLRHV+ca6cX2hkbpS7L66P9Vkgt7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gc: add `--expire-to` option
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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

Hi, Jeff King, could you come and help take a look at this patch?
I would be very grateful if you have time!

ZheNing Hu
