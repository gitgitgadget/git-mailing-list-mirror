Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 856A31F404
	for <e@80x24.org>; Sat, 20 Jan 2018 00:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755132AbeATAsf (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jan 2018 19:48:35 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:45151 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeATAsd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jan 2018 19:48:33 -0500
Received: by mail-qt0-f194.google.com with SMTP id x27so8152454qtm.12
        for <git@vger.kernel.org>; Fri, 19 Jan 2018 16:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Ks6Nsbai4zzn3JjmT58sX7hk7IuGo9MsZXkB85Rcz18=;
        b=ftdaBTOCbQCaKLs4Q7ViRJgHurPEUrUSFZaQ+D+zJRImgZCzCsVhJRJ9T8nNU3MFy+
         NWQyzUcc7oRI1fdrTSlDrHfHFxUAXYjhiAtpD1SvlP8/Z+pdsR+kryy+GBhkW1CESSVA
         CCXwltrwXB/CYegVP0YA24bOR+iFcMbicYGUom5lekTwZV1cIosRqEc3OFoZ8gIqV6WW
         xN0aH9vhLLa+PQwVpWk3tts6thI0vOya1ggZgDnBuzL30RLz45UoSdd2qFLdosK0eJt3
         YpNYhyRp7aaG4LjAhABZpta2VY9r//1F2YzcQG9nsZOAoGlTjsLLO7JTa7ugDu03v87T
         io2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Ks6Nsbai4zzn3JjmT58sX7hk7IuGo9MsZXkB85Rcz18=;
        b=iJzQpfT2HA8Rzol2cqeoSgXaZbYf5vyLSMY50WGso+mVY2C7UMXJiqh4tdF00TXxwR
         9kFKkZreZHgHLxbIfGfaJJedcPgI2Y47XH8ugPKaw3SZD4KkQcA/rLloi0BXVszMCc7m
         x4oW5j5dQYAwcS3beKiHeabFrOoQb9rSiFyt28GCKYHvXzN3bQ2dMtjTfMo+tgqeV+6v
         Is6oCHiMEmVQmdcDDG2VkbuZw3EYRZQlpw9WZH4uon2vgvPVKcQ38xGakzW8xgTKJTOl
         gPpIVNSs5xv4RpoOSOavhX+jgi0iUQJDWfaEdCV/u0w0nGYDPJfPXTKUizxOLRQh+c8t
         4wdQ==
X-Gm-Message-State: AKwxytcSXdnO1TZSPqbP+Rz9hBlvqbr6QULiXi3z5bPsIEylkyODrvND
        FQLPyalFt3IETr3LGmRSdZbxhqUoEdKWXDsZKgA=
X-Google-Smtp-Source: AH8x224Wx10iX3NcxGDKZ8EdwzvViND2XJZKsW0zBwT1QwUWRRL9xg21QfrIxJ1UcYAMD+95xgmGE0Arl/4XH4Z+PRU=
X-Received: by 10.200.9.42 with SMTP id t39mr476601qth.74.1516409312828; Fri,
 19 Jan 2018 16:48:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.175.239 with HTTP; Fri, 19 Jan 2018 16:48:32 -0800 (PST)
In-Reply-To: <20180119141940.5421-2-phillip.wood@talktalk.net>
References: <CAKdAkRSuNhEri+3eUbX8iVjr0JUyADSJBtgL==VjNwgKwe3Xqw@mail.gmail.com>
 <20180119141940.5421-1-phillip.wood@talktalk.net> <20180119141940.5421-2-phillip.wood@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 19 Jan 2018 19:48:32 -0500
X-Google-Sender-Auth: YIL_5TrHU4_0wiotNcz94juzQos
Message-ID: <CAPig+cS5BrZboaoKjCzi0TQJkR2VBnPUNJG4+WN5z8946Z4H0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] t7505: Add tests for cherry-pick and rebase -i/-p
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 9:19 AM, Phillip Wood <phillip.wood@talktalk.net> wrote:
> Check that cherry-pick and rebase call the 'prepare-commit-msg' hook
> correctly. [...]
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> @@ -4,6 +4,38 @@ test_description='prepare-commit-msg hook'
> +test_expect_success 'set up commits for rebasing' '
> +       test_commit root &&
> +       test_commit a a a &&
> +       test_commit b b b &&
> +       git checkout -b rebase-me root &&
> +       test_commit rebase-a a aa &&
> +       test_commit rebase-b b bb &&
> +       for i in $(seq 1 13)

For portability, use $(test_seq ...) rather than $(seq ...).

> +       do
> +               test_commit rebase-$i c $i
> +       done &&
> +       git checkout master &&
> +
> +       cat >rebase-todo <<-EOF
> +       pick $(git rev-parse rebase-a)
> +       pick $(git rev-parse rebase-b)
> +       fixup $(git rev-parse rebase-1)
> +       fixup $(git rev-parse rebase-2)
> +       pick $(git rev-parse rebase-3)
> +       fixup $(git rev-parse rebase-4)
> +       squash $(git rev-parse rebase-5)
> +       reword $(git rev-parse rebase-6)
> +       squash $(git rev-parse rebase-7)
> +       fixup $(git rev-parse rebase-8)
> +       fixup $(git rev-parse rebase-9)
> +       edit $(git rev-parse rebase-10)
> +       squash $(git rev-parse rebase-11)
> +       squash $(git rev-parse rebase-12)
> +       edit $(git rev-parse rebase-13)
> +       EOF
> +'
