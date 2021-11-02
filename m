Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD212C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6B8560EE9
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 00:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbhKBBBZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 21:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhKBBBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 21:01:25 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325E0C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 17:58:51 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id b125so8006894vkb.9
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 17:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uukVM7otUzKFp2fZzJtgbsWvp+YWzbxXeF4PpC5piX0=;
        b=qVZDb0U+cvKwOtkO0XzOF5/RJiLaEf7/m79QQchNcZT7Ah+6JZ8QyyH8nVIp441/dC
         VanomMutK70OyuFr8ZVVhlIUhyiD0RSWxw6zyxvOzG6pMNpy765DGHjVPYk2Gw6hKeVc
         mWhhCM5sL+AD+/K8Jnie3tk3lA2Q7MN+JKEcO3WMNQxhXfTIIPMlWlJiPcg2mp7UO7Wb
         pKPwAM8l0cQ+DJ6ILP3RsHozQUWte6VZBvqus8pCtoKI5DQ5uLPtfBIzyQ3mKyt68U/f
         Qx7O6C1lmbuwMTrGumKwQv78QjNPofERFkcdC9o8cQk5kT2j2lKXX1RCLOMScb16TbNY
         MTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uukVM7otUzKFp2fZzJtgbsWvp+YWzbxXeF4PpC5piX0=;
        b=RObB5GQTyuAiQKfE+SoMKZ648T6PAVk+Q0nY8x2uENWtsKok4S2mxSSBy+IiU45ro9
         LOQSdRsleuYGV53SyyLaviHV6UMef1vpS/3bRwQKTqCRa2Fmdc+M0f5SyUkV0tbvRUqG
         dUtyP2r/3PgEbVxn+dmnORKAf+UEWNdeYBnhrYtcg1Rsg8VMo7vbYNLrt2H3DIfuPdO8
         pbjXzse7bZoY/OPjQINnpmmZUNQcrJ0D7hROBJJeFAWS61OegZOali67ujf0MRrnT1P4
         SgXg1YW55hkF+jfxIhxbJuhWkV7cJ/Ao6jfcEZiOXopYbdx6xiviefdCgXHeTO4C+mrE
         GHpQ==
X-Gm-Message-State: AOAM530OtVVY/s83eAsKWCp+cDlzjLhl/9YO+uzZVL4ZvrxLz7IS0c5l
        Wua9FRboYGn0woo5/Q/OvQrPTmRuTTeHHa9hgkY=
X-Google-Smtp-Source: ABdhPJwY7WUiOYbVPz4ynIuHywyseFx95b40/yuXCrLSvhBNcAfvSuNG/zvoOg1WSie4pK13CWNzaflvExoPPOHU6QU=
X-Received: by 2002:a05:6122:50a:: with SMTP id x10mr7155254vko.23.1635814730305;
 Mon, 01 Nov 2021 17:58:50 -0700 (PDT)
MIME-Version: 1.0
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
 <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com> <patch-v5-7.8-4795d4835b0-20211101T190630Z-avarab@gmail.com>
In-Reply-To: <patch-v5-7.8-4795d4835b0-20211101T190630Z-avarab@gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 1 Nov 2021 17:58:39 -0700
Message-ID: <CAPUEspg1wFhQviN652E0riDOuicxF_gS=hguk4+Dd7BLoci90g@mail.gmail.com>
Subject: Re: [PATCH v5 7/8] various *.c: use isatty(1|2), not isatty(STDIN_FILENO|STDERR_FILENO)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 1, 2021 at 12:10 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> We have over 50 uses of "isatty(1)" and "isatty(2)" in the codebase,
> only these two used the stdlib.h macros to refer to them.
>
> Let's change these for consistency, and because a subsequent commit's
> commit message outlines a recipe to change all of these for ad-hoc
> testing, not needing to match these with that ad-hoc regex will make
> things easier to explain.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  builtin/bisect--helper.c | 2 +-
>  builtin/bundle.c         | 2 +-
>  compat/mingw.c           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 28a2e6a5750..1727cb051fb 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -830,7 +830,7 @@ static int bisect_autostart(struct bisect_terms *term=
s)
>         fprintf_ln(stderr, _("You need to start by \"git bisect "
>                           "start\"\n"));
>
> -       if (!isatty(STDIN_FILENO))
> +       if (!isatty(1))

STDIN_FILENO -> 0

Carlo
