Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864D7C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6368961208
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 14:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbhFNPBH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 11:01:07 -0400
Received: from mail-oo1-f54.google.com ([209.85.161.54]:39731 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbhFNPBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 11:01:04 -0400
Received: by mail-oo1-f54.google.com with SMTP id 67-20020a4a01460000b0290245b81f6261so2715836oor.6
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 07:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j6nkr0MY3+QZmyFssxvBaK0qS7XJIv2JXe0mvM/MqmI=;
        b=VE401TFkmBjFKRamPB97rDXDNylksFdmZxORv3LprSLAV2D+E6+D01ZRgotf3swxNY
         zdDxESzwrWHZBW+iyadw/MK6b99KvuYZuONds3WV9a/j1qtFK0swkseFFepOEdbNse2V
         Hjfz1NNQiiqvEiBrnVNYw1e3nKcTJZhcl8geN981io7psDFUFvMqEDb4RYrUCB61pg8O
         KOoXF6r28AKuj5PHCrk/1xpEwvnwWj0Q7Pi6fDM+RahY/ua8WLbqCc3zI4RMD8JXglWA
         MBgyzMAX8iVh7U768Bd7UYoR25lyPNbUc9m5Go0UWDtbWo4qQwKBdCEmRXKtwMf+A8xy
         G80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j6nkr0MY3+QZmyFssxvBaK0qS7XJIv2JXe0mvM/MqmI=;
        b=kpIn7UH8oeTIhOzAfPNwnayrRr/ZdAbqMFOrbI422y+VjjS/CxOqfuT7zdxPGajRtH
         unL6pNK01XkYYknQrG0L4ebyC0EjazeFsgSQ9d1kzVozU+WcKdW1uSfM0qGua3GozSjl
         KEreEppkiMn5vDVhqH7xY3xwFvHTEjS5ws+URCgL+T88YHTBZU9NmAYZhXugd3cDGWV+
         t377sfk5vdFXtndw2sa3PDbp1Vmg2wieNT0On0sMgosEMxxMAGnomZGpWVQkShMnH3x1
         AQ9ZmQZ3xjVxvTxthTVQHc9WdCKphnz0z2uxmyuS23EDYw2bUin5YOSsUssMPfusR/1i
         +a8w==
X-Gm-Message-State: AOAM532Qhj5v2kz80iKr/Ra/D1eW27MterfWtfe1qSWbgmnFCNIR5rDU
        Mt+gsZXfvtjHhViXBeSftGU9daTSx0O//BGr/NQ=
X-Google-Smtp-Source: ABdhPJw1Zo6TePxcoloXPBnxVhplhAW/KhYBU9dwIpUZjuVKx7I7u3iDztYZYZ9H53gCCi68Wnphcx4YcRM3xUQJTRU=
X-Received: by 2002:a4a:b789:: with SMTP id a9mr13324699oop.45.1623682681831;
 Mon, 14 Jun 2021 07:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210613045949.255090-1-felipe.contreras@gmail.com> <20210613045949.255090-3-felipe.contreras@gmail.com>
In-Reply-To: <20210613045949.255090-3-felipe.contreras@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 14 Jun 2021 07:57:50 -0700
Message-ID: <CABPp-BGuqo9Mrp--ofUP-TnbyBQhuUYU6i3DWHBZr2oKyOu1JA@mail.gmail.com>
Subject: Re: [PATCH 2/3] pull: trivial cleanup
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Philip Oakley <philipoakley@iee.email>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 12, 2021 at 9:59 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> There's no need to store ran_ff. Now it's obvious from the conditionals.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  builtin/pull.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index a22293b7db..80e2f55cbc 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -1053,7 +1053,6 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>
>         if (opt_rebase) {
>                 int ret = 0;
> -               int ran_ff = 0;
>
>                 struct object_id newbase;
>                 struct object_id upstream;
> @@ -1068,11 +1067,10 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>                 if (can_ff) {
>                         /* we can fast-forward this without invoking rebase */
>                         opt_ff = "--ff-only";
> -                       ran_ff = 1;
>                         ret = run_merge();
> -               }
> -               if (!ran_ff)
> +               } else {
>                         ret = run_rebase(&newbase, &upstream);
> +               }
>
>                 if (!ret && (recurse_submodules == RECURSE_SUBMODULES_ON ||
>                              recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND))
> --
> 2.32.0

Makes sense.
