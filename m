Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0176106
	for <git@vger.kernel.org>; Sun, 29 Oct 2023 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxVVpsYO"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E8D9
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:24:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-509109104e2so1039218e87.3
        for <git@vger.kernel.org>; Sat, 28 Oct 2023 23:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698560691; x=1699165491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqQKpVvk7FcoxEsoh6WplxfD1uIaQ5qQuhEpT2Ik8f8=;
        b=HxVVpsYOxs3KTkryEPlpkb6bKPUj6D7BPZiiipi81yLmr6zRFlFViTw4PcodrxF/BC
         Hc5mrnqk8DERjce2qhjaYeWh/LFXXdHuOnl4I8loJKLz7sO9DzwNsBJc9faZO5JZv51w
         457Gp24H3j05PDElwo/Xgp/FbDcK2ZupEhJ5XCijvW8Yvxf3E8yjALN9x1Ecg6zb/zlw
         XokOJ3rum3mJOpeXc30vD8FFwEwnHVCYgvSB66Q0HaMpXN7P8A5KD0SFF9tCiLpDm8kH
         9y8SLw0SqGxFyixns8cqzxg4dd5GrcRmjfhaU3MyhBw7Iy4fjlmbFpw5P2DRc7fY/s9Q
         iW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698560691; x=1699165491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqQKpVvk7FcoxEsoh6WplxfD1uIaQ5qQuhEpT2Ik8f8=;
        b=HYvQTSN2TjmESfhuTxItRheovwHPZeahtSqV6YEya+1CfgtNwMrRGd7eQxVT622OZQ
         oAi31kspYWTXPWwOr1ZlmeidGEEaMt/yiutypOtkVOOvPpgN7H5ZUVdGbFKQC3rRMqTh
         26/Hgcjz1HnkQDBq+fAxbLZQv3JFertsL/ZVFkGhrQbReTLPdRVXmEWOk7psgV4zK9nc
         22k5TOcJMwbj2ORhilP/kuRGA5vEGAAa8SWXeJ6O554U4ZhW6lipnTTJPsocu0PoQpHZ
         1Wac7GaMB8wD0ENSIXDJWie6TArHg75QZoWtlD3jZw3nXDP6YIBN0Vy5XK8Q1n6iEe0g
         Tiog==
X-Gm-Message-State: AOJu0YwdzbVWbdgn205vONeJvjYnT1PxZiB2r9+z2itLqGB5gAoflr+0
	gPAORW7NWQVTLFHLwIDuDq7ZG0bcJITXPpJPsOU=
X-Google-Smtp-Source: AGHT+IEJYzPCYshSgKIFYH+rPPX2Q+cypNKmDkA1ULbrzordZTxVTm2A8gpV1i0mDwg1bgo/8BSJju3LD+IrYCl6pUw=
X-Received: by 2002:a05:6512:3b29:b0:503:3707:66ed with SMTP id
 f41-20020a0565123b2900b00503370766edmr6463302lfv.34.1698560691066; Sat, 28
 Oct 2023 23:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <10e09b2d-15d7-4af1-b24c-217f9e2f457a@web.de>
In-Reply-To: <10e09b2d-15d7-4af1-b24c-217f9e2f457a@web.de>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 28 Oct 2023 23:24:37 -0700
Message-ID: <CABPp-BGF8URaTqqZ-CSbghjTwJtPNGv6zEws38r8qS650y=FSw@mail.gmail.com>
Subject: Re: [PATCH] am, rebase: fix arghelp syntax of --empty
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>, =?UTF-8?B?5b6Q5rKb5paHIChBbGVlbik=?= <aleen42@vip.qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 28, 2023 at 4:58=E2=80=AFAM Ren=C3=A9 Scharfe <l.s.r@web.de> wr=
ote:
>
> Use parentheses and pipes to present alternatives in the argument help
> for the --empty options of git am and git rebase, like in the rest of
> the documentation.
>
> While at it remove a stray use of the enum empty_action value
> STOP_ON_EMPTY_COMMIT to indicate that no short option is present.
> While it has a value of 0 and thus there is no user-visible change,
> that enum is not meant to hold short option characters.  Hard-code 0,
> like we do for other options without a short option.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  Documentation/git-rebase.txt | 4 ++--
>  builtin/am.c                 | 2 +-
>  builtin/rebase.c             | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index e7b39ad244..b4526ca246 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -289,7 +289,7 @@ See also INCOMPATIBLE OPTIONS below.
>  +
>  See also INCOMPATIBLE OPTIONS below.
>
> ---empty=3D{drop,keep,ask}::
> +--empty=3D(drop|keep|ask)::
>         How to handle commits that are not empty to start and are not
>         clean cherry-picks of any upstream commit, but which become
>         empty after rebasing (because they contain a subset of already
> @@ -695,7 +695,7 @@ be dropped automatically with `--no-keep-empty`).
>  Similar to the apply backend, by default the merge backend drops
>  commits that become empty unless `-i`/`--interactive` is specified (in
>  which case it stops and asks the user what to do).  The merge backend
> -also has an `--empty=3D{drop,keep,ask}` option for changing the behavior
> +also has an `--empty=3D(drop|keep|ask)` option for changing the behavior
>  of handling commits that become empty.
>
>  Directory rename detection
> diff --git a/builtin/am.c b/builtin/am.c
> index 6655059a57..9bb73d1671 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2420,7 +2420,7 @@ int cmd_am(int argc, const char **argv, const char =
*prefix)
>                 { OPTION_STRING, 'S', "gpg-sign", &state.sign_commit, N_(=
"key-id"),
>                   N_("GPG-sign commits"),
>                   PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
> -               OPT_CALLBACK_F(STOP_ON_EMPTY_COMMIT, "empty", &state.empt=
y_type, "{stop,drop,keep}",
> +               OPT_CALLBACK_F(0, "empty", &state.empty_type, "(stop|drop=
|keep)",
>                   N_("how to handle empty patches"),
>                   PARSE_OPT_NONEG, am_option_parse_empty),
>                 OPT_HIDDEN_BOOL(0, "rebasing", &state.rebasing,
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index f990811614..ad7baedd4a 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1147,7 +1147,7 @@ int cmd_rebase(int argc, const char **argv, const c=
har *prefix)
>                                  "instead of ignoring them"),
>                               1, PARSE_OPT_HIDDEN),
>                 OPT_RERERE_AUTOUPDATE(&options.allow_rerere_autoupdate),
> -               OPT_CALLBACK_F(0, "empty", &options, "{drop,keep,ask}",
> +               OPT_CALLBACK_F(0, "empty", &options, "(drop|keep|ask)",
>                                N_("how to handle commits that become empt=
y"),
>                                PARSE_OPT_NONEG, parse_opt_empty),
>                 OPT_CALLBACK_F('k', "keep-empty", &options, NULL,
> --
> 2.42.0

Looks good to me; thanks.
