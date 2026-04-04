Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAD3C8E6
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 15:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775316240; cv=pass; b=gS3DiJ/sYb01ZQEy6qh3EIZ+3+M5tlL52oHMiWHZAFOE5QOPwlfuo40Z32T/ZewBqIiOxVTLnmbEAu4SprayrmnyEkY3/FE0RlTJXpzKLLFVc/dyW/WHT5gPAXpw2wGbH6UVBeER/8bbqPGLGNvo8u10QfrXVAUH53yu7VfdLLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775316240; c=relaxed/simple;
	bh=UDckx4bN3uL1b8tk8sVnuOFu3n+LtG5peqlRBTNzJwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUwh7BRpidH/TsXgcrxr5sKeytcaOlfHz+i0T6qWqJ8orP7xaXa5mlwOozM+5My5T5iuqWQHTIrqTGNCX10WepzIucpuaDaijHi3nAdXowe5gbnmqeNg5KXfv9As+I4vU1L3MZm9NvsuF74AgjsvhzOfJKF5jYwtgqs9yseIhtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uza9AYUY; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uza9AYUY"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79be0de8610so25515077b3.2
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 08:23:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775316238; cv=none;
        d=google.com; s=arc-20240605;
        b=DRvUwrKDSxS05mMglrOC3rs3VLw4Q6tYja9YfY3aSWyj+yq7yqy01B2cp7UR55PB1i
         z33VOY+k1oEGyEayc0Po4C3JcsLkiMMUpXFEpBtcBotMXalfiztN9PvqK5IwwbtL8I0r
         21AUPdvIFZxo0Fk98erc8fFe1VsQioQyzrpGUSmUgQvaUApW0FN21n0BmlrkuSMcsREe
         gkBzRq5KqlaROTzQ+NDTPlWofi5h7bTVUY6ZKBOKovvqQ8xESid7xq3IQEbBuAu8ZqlG
         4Y/KVKnJO8IzUvi4if8FUyzSn2UoL8nc6XcUdeBft/3dWuCsqfdotHquELNFHr+GEjkJ
         5ErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UjpLBBCLGW0bt1yGSa5W9iB38Q2w1psmTvvoAbXnUoQ=;
        fh=+zbdEbVLutUf+SfexfSkjqFutMS4FMUhiWVk3N7Cdx0=;
        b=OelZ1QBBVxGPXvUOhvRc8YqqWKZPVZNbmgHdCRr6gV+fTIAqP/lKKu9t2ow9w1N24x
         PofJ4d7QwyatbuGczFo+PkBDB+uHmpqm39jdPIkECorK6b5C2DDQEVWRTBo0EqCnXqOi
         SJTcs5C0/0NTeKYROfZWS2ybl8E2Pzax+225GAgcBFfOVRGHKcVOZdgKsAudtMbc7O17
         V9v9lYC5iY/0rrxo/x323l5bBBs0IUUrY7VqGAWte++XbDbuTJA70kZRQrWqvFZxQnh4
         F7NKZh286RHF9dtn2nxG1zCI+yVC63baOhE5R38/K5i/zglC5MGQkpvikOxPCSue+qln
         kK9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775316238; x=1775921038; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjpLBBCLGW0bt1yGSa5W9iB38Q2w1psmTvvoAbXnUoQ=;
        b=Uza9AYUYOtv4waoj6ev43AiCd9A9Ym6XZzIyuR4Fzrzwn5sA/KRPU8BiZ+wL4wnfg2
         M9wDPMPUrsftoEtMjbz+TkvvBdGLpFn0sWqtqJ55a5bo9TT/iQBWy5dBS/t97SIUR8vf
         7P1gJTWPg+ozpnI+gE+7fk8U00WSopjDogj8nhcTm+PfEwukr3bix3eMniGvXOrdUwIf
         Vd+zR2lGv6LXoh/fN5xJvW6uXLMVRilIaPsl0B6H40XKuMZSG9jFaG9VmKOPJjq34W+3
         /tQZ1qYCkQLu8P7XFS+NbAO3Dkul7CY+HWMw+EPWiIdH7uO0hWmNWCH3ROjndHe3p4GI
         waog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775316238; x=1775921038;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UjpLBBCLGW0bt1yGSa5W9iB38Q2w1psmTvvoAbXnUoQ=;
        b=lf/We240XrhRsmzdNczV782ZcfVrN/zunScrNf/4J/c398zV5ogVDpgsVMC+tdMcpx
         SUoGMmOkxfpxrQfjRZLb8pFDbaCNdq6pjR8EL5jElxgulqR79LG88KqrLlCrbcVmqUw8
         LV390UXXDgt8Vm3WccEcyUSl6lYx63PR+3v+0yBo1D9CitMM/dOEwhBYkKP3P4aZLN8m
         jXmJbQcuRt15ePR03Ur7jhzq78RGIlkLdGqhbXDAtpWDAQw6vrwW58omtR/6WZG/wURb
         PzlsgH649H3mLhOfFAIc0Kj/aMwQQrs9VSJ7KijDswH6E5Ial22iZP/00mUP7ISUqJAd
         Q8uw==
X-Gm-Message-State: AOJu0YxqANktOmb3nmIJwOhC6EP3t4AJGkkFOIG5CEiSamOT2eBJm/0P
	oQEUVcmubv3PVSHX0zOjg6NFKJheW9PsURD3CGXnC99UNmm7ZhC+Dfm7T763NAUBuzlV0ABOSqf
	qOEOnpREiO/UhCbgqVrq4GTEOFFyxkSRihTk5odevcg==
X-Gm-Gg: AeBDieuguqGBBd/AlyKOrdGY1wHvUqcuG/cQba6v3rWul5Up6U/t0h1nN8lPYKuMgFS
	xudkBcE0NvgYTOC5MAj4dHCWvxCcO2xW2dJ9gr3E7kCcPGvWk21gUDOOFes9rmvbBpPwOxXKHkQ
	1MlwJsYZVOGvs65X6eXTVwIm3E7Za3RX//Z/2NXSNuJjOUp+tCHKd/lOVQ2ER9eHwR8yhIvbd+B
	lNlg5Vk0HB0dBgV0Fkbl+gLsscGGvE6fLzqFtrvR930/wHJfF6PWl2NtFts8KkWBaQaHYzp/HnH
	GFZ8BA5teN50N04nPCQqJaJcO8rrG6Wm+KnKljY4n4570H4GggeOp6VCd5Cglk8jOkGm2S/GG/x
	i+eO/v5myJC1yoPZWurW3tw==
X-Received: by 2002:a05:690c:289:b0:7a6:1df5:c99e with SMTP id
 00721157ae682-7a61df5cb47mr34667097b3.30.1775316238251; Sat, 04 Apr 2026
 08:23:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
In-Reply-To: <njuf62lav6akkmdyqutwk7pim5yutw5cuicjidwpe5eh6qnkqr@4ir6q4uhhvht>
From: Pablo <pabloosabaterr@gmail.com>
Date: Sat, 4 Apr 2026 17:23:46 +0200
X-Gm-Features: AQROBzB9fctiwMFgFO3Bm7NQdplsszbA_XoQgSwM9N6Dhz8G4N61GgJ3MwusqA0
Message-ID: <CAN5EUNR6x_HWQKrMMHcHj0hF+D_6QBiw782_QGA8E8SS7Q3pcg@mail.gmail.com>
Subject: Re: [RFC PATCH] switch: provide configurable detach
To: Thibaud CANALE <thican@thican.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El s=C3=A1b, 4 abr 2026 a las 16:36, Thibaud CANALE (<thican@thican.net>) e=
scribi=C3=B3:

Hi Thibaud,
>
> Its purpose is to provide for git-switch(1) same detach behavior on
> commit it than git-checkout(1) through configuration option
> `checkout.switchDetach`.

The commit needs some work, following Documentation/SubmittingPatches:
The subject looks fine but the body, you should write imperatively, somethi=
ng
like "Allow git-switch to..." instead of "Its purpose is to...".

>  same detach behavior on commit it than

This is confusing.

Also the body should explain WHY this change would be wanted.

>
> Signed-off-by: Thibaud CANALE <thican@thican.net>
> ---
>  Documentation/config/checkout.adoc |  4 ++++
>  builtin/checkout.c                 | 18 +++++++++++++++---
>  t/t2060-switch.sh                  | 27 +++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/config/checkout.adoc b/Documentation/config/ch=
eckout.adoc
> index e35d2129..3a6c1049 100644
> --- a/Documentation/config/checkout.adoc
> +++ b/Documentation/config/checkout.adoc
> @@ -22,6 +22,10 @@ commands or functionality in the future.
>         option in `git checkout` and `git switch`. See
>         linkgit:git-switch[1] and linkgit:git-checkout[1].
>
> +`checkout.switchDetach`::
> +       Provides for linkgit:git-switch[1] the same detach behavior on co=
mmit id
> +       than linkgit:git-checkout[1] without the explicit --detach option=
.
> +

I think it would be better to describe how it would be if set rather
than directly
the what it does. e.g.:
"If set, detaches HEAD when..."

>  `checkout.workers`::
>         The number of parallel workers to use when updating the working t=
ree.
>         The default is one, i.e. sequential execution. If set to a value =
less
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index e031e618..1da1062e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -53,6 +53,7 @@ struct checkout_opts {
>         int force;
>         int force_detach;
>         int implicit_detach;
> +       int switch_detach;  // For checkout.switchDetach configuration

// coments are not used in Git, if you need to add comments make them with
/* */.
Nit I don't think a comment here is necessary, it is very self
explanatory already.

>         int writeout_stage;
>         int overwrite_ignore;
>         int ignore_skipworktree;
> @@ -1005,7 +1006,10 @@ static void update_refs_for_switch(const struct ch=
eckout_opts *opts,
>         else
>                 strbuf_insertstr(&msg, 0, reflog_msg);
>
> -       if (!strcmp(new_branch_info->name, "HEAD") && !new_branch_info->p=
ath && !opts->force_detach) {
> +       if (!strcmp(new_branch_info->name, "HEAD") &&
> +           !new_branch_info->path &&
> +           !opts->force_detach &&
> +           !opts->switch_detach) {

seems that you're checking force_detach and switch_detach together
every time,they look very similar,
sure  you need them separated?

>                 /* Nothing to do. */
>         } else if (opts->force_detach || !new_branch_info->path) {      /=
* No longer on any branch. */
>                 refs_update_ref(get_main_ref_store(the_repository), msg.b=
uf,
> @@ -1014,7 +1018,9 @@ static void update_refs_for_switch(const struct che=
ckout_opts *opts,
>                                 REF_NO_DEREF, UPDATE_REFS_DIE_ON_ERR);
>                 if (!opts->quiet) {
>                         if (old_branch_info->path &&
> -                           advice_enabled(ADVICE_DETACHED_HEAD) && !opts=
->force_detach)
> +                           advice_enabled(ADVICE_DETACHED_HEAD) &&
> +                           !opts->force_detach &&
> +                           !opts->switch_detach)
>                                 detach_advice(new_branch_info->name);
>                         describe_detached_head(_("HEAD is now at"), new_b=
ranch_info->commit);
>                 }
> @@ -1541,8 +1547,11 @@ static void die_expecting_a_branch(const struct br=
anch_info *branch_info)
>                  */
>                 code =3D die_message(_("a branch is expected, got '%s'"),=
 branch_info->name);
>
> -       if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD))
> +       if (advice_enabled(ADVICE_SUGGEST_DETACHING_HEAD)) {
>                 advise(_("If you want to detach HEAD at the commit, try a=
gain with the --detach option."));
> +               advise(_("Also you can detach by default by setting the c=
onfig variable "
> +                        "checkout.switchDetach to true."));
> +       }

Nit "Also, you can..." or "You can also..."

>
>         exit(code);
>  }
> @@ -1660,6 +1669,7 @@ static int checkout_branch(struct checkout_opts *op=
ts,
>
>         if (!opts->implicit_detach &&
>             !opts->force_detach &&
> +           !opts->switch_detach &&

Again force_detach + switch_detach

>             !opts->new_branch &&
>             !opts->new_branch_force &&
>             new_branch_info->name &&
> @@ -2119,6 +2129,8 @@ int cmd_switch(int argc,
>         options =3D add_common_options(&opts, options);
>         options =3D add_common_switch_branch_options(&opts, options);
>
> +       repo_config_get_bool(the_repository, "checkout.switchDetach", &op=
ts.switch_detach);
> +
>         cb_option =3D 'c';
>
>         return checkout_main(argc, argv, prefix, &opts, options,
> diff --git a/t/t2060-switch.sh b/t/t2060-switch.sh
> index c91c4db9..3435ae98 100755
> --- a/t/t2060-switch.sh
> +++ b/t/t2060-switch.sh
> @@ -177,4 +177,31 @@ test_expect_success 'switch back when temporarily de=
tached and checked out elsew
>         git -C wt2 switch --ignore-other-worktrees shared
>  '
>
> +test_expect_success 'switch with configured detach behavior from configu=
ration ' '

Trailing space here at the end, also the title is kinda confusing with the
configured + configuration, what about:
"switch detaches on commit when switchDetach is set"

> +       test_when_finished "
> +               test_config checkout.switchDetach false;
> +               git switch main
> +       " &&
> +       test_config checkout.switchDetach true &&
> +       git switch main &&
> +       git symbolic-ref HEAD &&
> +       git switch main~ &&
> +       test_must_fail git symbolic-ref HEAD &&
> +       git switch - &&
> +       git symbolic-ref HEAD &&
> +       git switch - &&
> +       test_must_fail git symbolic-ref HEAD
> +'
> +
> +test_expect_success 'switch without configured detach behavior from conf=
iguration ' '

Trailing space.

> +       test_when_finished "
> +               test_config checkout.switchDetach false;

test_config already has test_when_finished
I would git config --unset.

> +               git switch main
> +       " &&
> +       test_config checkout.switchDetach false &&

This is already false.

> +       git switch main &&
> +       git symbolic-ref HEAD &&
> +       test_must_fail git switch main~
> +'
> +
>  test_done
>
> base-commit: 2855562ca6a9c6b0e7bc780b050c1e83c9fcfbd0
> --
> Thibaud CANALE
> thican [at] thican [dot] net
> https://thican.net/
> GPG: rsa4096 2013-10-14 485EF628CB85CDD4CB7CFF0D52F5127650733A18

Overall seems reasonable, it might be a design choice having to
explicitly use --detach, force_detach it's pretty clear about it but
I dunno.

For now:
I would rewrite the commit.
Make sure that you need a new flag, force_detach looks very similar.
Fix the style issue.

You might find Documentation/CodingGuidelines and
Documentation/SubmittingPatches very helpful.

Pablo
