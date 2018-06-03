Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 274E41F403
	for <e@80x24.org>; Sun,  3 Jun 2018 07:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750983AbeFCH6E (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Jun 2018 03:58:04 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:47081 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeFCH6C (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Jun 2018 03:58:02 -0400
Received: by mail-yb0-f194.google.com with SMTP id p22-v6so10096074yba.13
        for <git@vger.kernel.org>; Sun, 03 Jun 2018 00:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=c3cbHom1Qwg+zLauzNlMkD/bHgCEcEY2PgYsLMN+mzA=;
        b=tlwHm6Z9n9oNCRrJvzCeRUmNwp4+NE4RQ3SaIYAIBCo/cwJdr5G+IeV7fmzX7OVxws
         rPQA3dhFdsSuRqUxe7UGuIYrep7ogbK1hJjiwWclsFGTEZHjAhr4pOlr2ZsZ9igGfIYx
         vnTn8e3y+TKp5NTgJf5s6B+nlGRuqtVA8a7HZBDlIvC5JPGeUY+tdNAPSo8nBfcu/Cng
         L9kORbw3Jol3mbPtG+61R7ipQFtetMmmYayrWoMEnAMjQDiJniQZD+wmB6YyOCVTXf49
         D5r/bnK5ZjkLCUdPIoMDTQT46Lz9xC5X0CH9ykLFdvND0EZkwxbpQT85t46Uy4OScls/
         IfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=c3cbHom1Qwg+zLauzNlMkD/bHgCEcEY2PgYsLMN+mzA=;
        b=DZuCahmOJ6nm4NLoqlT/9ue854joeGqR9qJSTM53bbXC3BnHkM5ixRzORS3d7J5Y1E
         S5Sgg6MNxru29GA6lW6fn14A7dyKo+vEnWkM/YMXprnPcDuyjZJ12yz5CmX+jNOLDamN
         FQeNx8VXUIcMxw8MV0Ht47vXhnHhja68DVG3kIfaHuyVhZuAlnWd1dElBN2Q+jYD6wAn
         O6Tp/klmPR1bhrL0GJaPQfQV0tbZWJo7T0NvhKsG9mHGdQOa5MJHCIjPY1f+wkfa4kU7
         WWWy8EjfbJWyOfl4X4ccpno4ciKRT+c+wHsT8KJesiCdNsTAGazX8Cv7WykGQbRv8SYt
         HxMQ==
X-Gm-Message-State: ALKqPwc6L4Ucd1eQB8IzlNIMKXJaWLfbv74Gb5yl2aX+Aa6lgn6+iokC
        1Q0KI0obHzXyzQFJhstHPfLt9cwxzF/SoJmg1YE=
X-Google-Smtp-Source: ADUXVKKhDFz9EDCqH0I+LjGHA4co0tz1xtBZf3GY52vlscBc3PaTx54cNhLAmPrwYXUuTq5+oghMyspr3sJdiRdnOfA=
X-Received: by 2002:a5b:a8b:: with SMTP id h11-v6mr7647561ybq.287.1528012682153;
 Sun, 03 Jun 2018 00:58:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5b:784:0:0:0:0:0 with HTTP; Sun, 3 Jun 2018 00:58:01 -0700 (PDT)
In-Reply-To: <20180602115042.18167-9-avarab@gmail.com>
References: <20180601211015.11919-1-avarab@gmail.com> <20180602115042.18167-1-avarab@gmail.com>
 <20180602115042.18167-9-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 3 Jun 2018 03:58:01 -0400
X-Google-Sender-Auth: GR0X7sXlkwTcv2w6YcLE8d-Sk_Y
Message-ID: <CAPig+cQRm+KM+JLxR0ch2_ydMFg2xg9FFAA-=VkfqgtSkV6q0w@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] checkout & worktree: introduce checkout.defaultRemote
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 2, 2018 at 7:50 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Introduce a checkout.defaultRemote setting which can be used to
> designate a remote to prefer (via checkout.defaultRemote=3Dorigin) when
> running e.g. "git checkout master" to mean origin/master, even though
> there's other remotes that have the "master" branch.
> [...]
> Also adjust the advice.checkoutAmbiguousRemoteBranchName message to
> mention this new config setting to the user, the full output on my
> git.git is now (the last paragraph is new):
>
>     $ ./git --exec-path=3D$PWD checkout master
>     error: pathspec 'master' did not match any file(s) known to git.
>     hint: The argument 'master' matched more than one remote tracking bra=
nch.

In v6, the "The argument" prefix has been dropped from the hint, so
this commit message needs a tweak to match.

>     hint: We found 26 remotes with a reference that matched. So we fell b=
ack
>     hint: on trying to resolve the argument as a path, but failed there t=
oo!
> [...]
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
> diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
> @@ -87,7 +87,23 @@ test_expect_success 'checkout of branch from multiple =
remotes fails with advice'
> -       test_i18ngrep ! "^hint: " stderr
> +       test_i18ngrep ! "^hint: " stderr &&
> +       # Make sure the likes of checkout -p don not print this hint

s/don/do/

> +       git checkout -p foo 2>stderr &&
> +       test_i18ngrep ! "^hint: " stderr &&
> +       status_uno_is_clean
> +'
