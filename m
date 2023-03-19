Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6264C6FD1F
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 05:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjCSFxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 01:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjCSFx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 01:53:29 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775471A4A9
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 22:53:27 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id q16so385658lfe.10
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 22:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679205206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2wOyAkd6G6HM5OGVS12AHlO73fAA3ACf2gpDKvC63U=;
        b=JoJ2G0SRfnCoJDOCmY4jJP88lSQ20tjrNzJjmvsxFBRcdbWfaQBknct0a8CDwyr9+G
         tkmCLBy3ptaPky0QvtwcNSNTUw/3uKLUCvuqpwKVZCRGRi3+tRXulfGfJj57e12q8n5G
         P+uYagavuWDzkKeH7mrT3rCt9AXirV9RgzahTvHo0jFAMvy6D2bilwwi6FZKTqPebSYg
         8ykpzbq9mxuOTX4FL6yaqbCtTB8DOemStulfiBAlhnbpiCl7A+R9rPUI1e6Oq31gWpkk
         UyOlyYnki8T02UCC7ZJy0+BtnKjOvC0//Hdz+Ly2LAId+VdLsDmsmWNR16W3wdIQx6Yw
         FG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679205206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i2wOyAkd6G6HM5OGVS12AHlO73fAA3ACf2gpDKvC63U=;
        b=zhTIhHWadJZVMOXWYSRGqcriUVr7l7cf+LuAJKuei2b58iWsb29R8pD1tA2OObt0t7
         f6MngIpAV2fBnfpXRwReaIvio4d5lwJYff0vdcOolSfK+NpRge+TpRMNgUE3WkUG8Nm7
         gyAqTmOAyAEnForGHvLsXCQzt4zoYt8sMasohrv1PJRzkeWILpjSwDDB9paRWfGW9ZBc
         /BXIUTlX1Jh+nSs26GSnh3nLY2w6iALalvtKwaiHCpIfDgpFU6sgpgD+aVNcxeFsZdSU
         CZlm0H5y/aymQWgMJ9E3m630KWAho3LEXMwfL9BCCwX0E7U+DSM3x/ZbP+N8OTD0/mF2
         xihA==
X-Gm-Message-State: AO0yUKXlJx63Qm11B+Iaavfp3Fg4I0Te2Kj44laBDsaoQwC5SHOGjqYL
        FGoWST6ub0PqN3D+v2bHDOXdhR47OMvbOpQ8GAxfGaMPt2I=
X-Google-Smtp-Source: AK7set85+c73f6dsgizoFoxdQUob9/ZM3OI20/0513nduMzVlAeYIIXqTHoyCmZihXisiP7pc1ZVqkR8nCZ4wa1Lz6o=
X-Received: by 2002:a05:6512:3d22:b0:4e8:4409:bb76 with SMTP id
 d34-20020a0565123d2200b004e84409bb76mr4374343lfv.2.1679205205590; Sat, 18 Mar
 2023 22:53:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com> <patch-01.17-c167bde3c0c-20230317T152724Z-avarab@gmail.com>
In-Reply-To: <patch-01.17-c167bde3c0c-20230317T152724Z-avarab@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 18 Mar 2023 22:53:13 -0700
Message-ID: <CABPp-BG=wEGu-mdT_Uj1hADa8KgxXufO6webz7FO1hfADb1v9g@mail.gmail.com>
Subject: Re: [PATCH 01/17] cocci: remove dead rule from "the_repository.pending.cocci"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 17, 2023 at 9:41=E2=80=AFAM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarma=
son
<avarab@gmail.com> wrote:
>
> The "parse_commit_gently" macro went away in [1], so we don't need to
> carry his for its migration.

s/his/this/ ?

> 1. ea3f7e598c8 (revision: use repository from rev_info when parsing
>    commits, 2020-06-23)

Thanks for the explanation and link.


> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  contrib/coccinelle/the_repository.pending.cocci | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/co=
ccinelle/the_repository.pending.cocci
> index 747d382ff5f..23b97536da5 100644
> --- a/contrib/coccinelle/the_repository.pending.cocci
> +++ b/contrib/coccinelle/the_repository.pending.cocci
> @@ -34,14 +34,6 @@ expression G;
>  + repo_parse_commit_internal(the_repository,
>    E, F, G)
>
> -@@
> -expression E;
> -expression F;
> -@@
> -- parse_commit_gently(
> -+ repo_parse_commit_gently(the_repository,
> -  E, F)
> -
>  @@
>  expression E;
>  @@
> --
> 2.40.0.rc1.1034.g5867a1b10c5
