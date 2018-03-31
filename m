Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDEB11F404
	for <e@80x24.org>; Sat, 31 Mar 2018 18:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753169AbeCaShL (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Mar 2018 14:37:11 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:46313 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753118AbeCaShK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Mar 2018 14:37:10 -0400
Received: by mail-ot0-f173.google.com with SMTP id v64-v6so12262058otb.13
        for <git@vger.kernel.org>; Sat, 31 Mar 2018 11:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HDcG4OccxyXuM6uze0FGt6bFOwLWQaBcWUdcW/bU7Jk=;
        b=R2FY6NpaqUlu5qkHZLvxJFidC7f5GBncMRhNOiVX9Q5qkOHm6mK2TSXc8TCCXtY03/
         0F9mH40StqhRpUDKr/VE+OP3WUUyYuz/eOHYs8ikjSf3U4We5vITAoyem6S53P3owofz
         RgKNMWTlyQRKaV73nIFD1Ey+VqvyEzlfP9wEeQFr9dOY/WbBwoy8u7epya3VVdpuMqnl
         RZjU8HjeUP5zOPH4t6ufsqgjlSOQ7Jkg8UCC875LOzxxi46H9ZHZoVBEmSuF65ntaIs9
         EabeEhujJKysWA6C7dokKdMyucq0qi7KJ39e+d1riPP0m9oYxwb8NuGqOZ+yXZiGjcOj
         y/oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HDcG4OccxyXuM6uze0FGt6bFOwLWQaBcWUdcW/bU7Jk=;
        b=Q59OnYjEkfUdOxsonXiZegLx3DgpXuMUjXGxwp/LCZBQyMRieAMx3pGgdFxCsG+KnX
         QsT1HiFk8DC5VmPn80FFWDdKyUcpmufxSX7K/w5lJnUQvbe/7AcEcnihHwokIRfuj/qa
         EXqybf61lxg0M1vWi46CdR4/y8He65oX8ru5w13fNW+2Cy3dd0nxlHUbdywIZ82K1gJY
         t2c07YQEQdHA0aG+Z96hetSTSrIMCEZd/FWBlYWtrtkEc0YtDykbdEB5gwiVMR6o5T71
         GOmsn9VwN99Z3bo292qA+3kB3drWWrltyXrEQsrrLWTT2L8SepTaVzI5DnCzDj1LW602
         k0nQ==
X-Gm-Message-State: ALQs6tDFErjoiijjCZgXPihgu+tYMH5i/huXNYQ5o9euLAvowZFYa6v2
        J/+INgwHZfZTCBIxRqsiusT4guBspaPLPbLzB+Y=
X-Google-Smtp-Source: AIpwx4/m2ocpNtKT7JV3hCNprBlYzSKDSnZlqnRK2e1Vuma8KDjbX2ya85Uf7moGS7E1X+g67dHhcopiGFV7LjZtGoc=
X-Received: by 2002:a9d:154c:: with SMTP id z12-v6mr2221106otz.65.1522521430055;
 Sat, 31 Mar 2018 11:37:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Sat, 31 Mar 2018 11:36:39 -0700 (PDT)
In-Reply-To: <20180331164009.2264-1-avarab@gmail.com>
References: <20180329150322.10722-1-pclouds@gmail.com> <20180331164009.2264-1-avarab@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 31 Mar 2018 20:36:39 +0200
Message-ID: <CACsJy8CyB0igY365NMkswSgAi9_rf+XBOMQyJ7XW6iQxQiCEyQ@mail.gmail.com>
Subject: Re: [PATCH 4/3] Makefile: untangle DEVELOPER and -Werror
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        ric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 31, 2018 at 6:40 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Change the DEVELOPER flag, and the newly added EAGER_DEVELOPER flag
> which (approximately) enables -Wextra so that any combination of them
> and -Werror can be set.
>
> I've long wanted to use DEVELOPER=3D1 in my production builds, but on
> some old systems I still get warnings, and thus the build would
> fail. However if the build/tests fail for some other reason, it would
> still be useful to scroll up and see what the relevant code is warning
> about.
>
> This change allows for that. Now setting DEVELOPER will set -Werror as
> before, but if DEVELOPER_NONFATAL is set you'll get the same warnings,
> but without -Werror.
>
> I've renamed the newly added EAGER_DEVELOPER flag to
> DEVELOPER_EXTRA. The reason is that it approximately turns on -Wextra,
> and it'll be more consistent to add e.g. DEVELOPER_PEDANTIC later than
> inventing some new name of our own (VERY_EAGER_DEVELOPER?).

Before we go with zillions of *DEVELOPER* maybe we can have something
like DEVOPTS where you can give multiple keywords to a single variable
to influence config.mak.dev. This is similar to COMPILER_FEATURES we
already have in there, but now it's driven by the dev instead of the
compiler. So you can have keywords like "gentle" (no -Werror) "extra"
(-Wextra with no suppression) and something else.
--=20
Duy
