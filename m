Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DC5C433F5
	for <git@archiver.kernel.org>; Sat, 14 May 2022 18:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbiENSQW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 May 2022 14:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbiENSQT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 May 2022 14:16:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7A3112A
        for <git@vger.kernel.org>; Sat, 14 May 2022 11:16:17 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so10609217pji.3
        for <git@vger.kernel.org>; Sat, 14 May 2022 11:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h3lYKNLefRFExjV7hPQKgzb0auTloZkZu7k1esGdRgo=;
        b=ldvsmb4AhzZCftsTX3jAmoaplY9LfzgCeMbqRrobQh0k4NAQVk7VWTqCy78+JiaD9C
         UZQil4TxNI7D4ie3SkFsUsEf1+regPYMmZfFUloGXYZyEfvJ1DgPeXEPT2SCk4lKt2Yb
         NwWcn1yEkLT4mHXlMYcp3EzurqjVrNUsstU8rGBGcZuWq+knrM2V/3/G2CRe+QKVubJj
         JnsYEAEwswfLItFIjvzF+AeSvkCATn5kRRbcaghJDIDanC9vMUDOOEFQWdrFRZxvX8gM
         uUj4Vcr4YOUXUGdgWDj6PC8FaHOr/MKocpL/ScA0UciKpRT/EgQP15k9U8V/7K6rE7Ce
         r2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h3lYKNLefRFExjV7hPQKgzb0auTloZkZu7k1esGdRgo=;
        b=BU9O5olF/ePr9PEXGDGQQGJDePSL2KBYfjpa3s71BAVmC1NyEZowfNbz511PqBDvv1
         o9L+3dYZbOBKcF8cPlyMrrSpe2PpUFdTwT71kcqRF6wxPSMqTSLDwS78htm0df4HblEP
         0gUXoXn8Sk9CbRNFTqYy9gtlxPEgt6tBWIqw3NBrKDVEIlBb2G6xJ2qky+LujgZhDSfC
         76ZQ4kkte1FodQscyzp5GIGo7Q3g69RlwhLkKfWgizwRZB9/ixgrZdt3L6poL8eKDfNJ
         ntfqtE/Uze3mpQ5m9U+FwHw3XB70YYj3H0fH9nYejJzxl83ZSeeDxvx3c9qZnlJ9W2sH
         dg1A==
X-Gm-Message-State: AOAM532674oe91Xv7MSHEnEMJVAKliaVxoao4QaBjj+ubAW565v4RAqO
        nGOZL5p288d4VEvh0BiwiogoohYTVeGXyuSDcUI=
X-Google-Smtp-Source: ABdhPJxIydJMDU1zlVc16haFH6SO7O66PlSP4Fsu+SgHFCIaRoqxz0hzHbRNFM1K241AtnadbqeQ417PTZz/4bSMMrk=
X-Received: by 2002:a17:902:e94e:b0:158:91e6:501 with SMTP id
 b14-20020a170902e94e00b0015891e60501mr10252994pll.29.1652552177411; Sat, 14
 May 2022 11:16:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com>
In-Reply-To: <pull.1264.git.git.1652361610103.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 14 May 2022 20:16:05 +0200
Message-ID: <CAN0heSoCiNnrknyfE7RrsLKcGcGqDYo9k9ubzcEo1r+CxO1hVQ@mail.gmail.com>
Subject: Re: [PATCH] grep: add --max-count command line option
To:     "Carlos L. via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Carlos_L=C3=B3pez?= <00xc@protonmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlos,

Welcome to the mailing list. :-)

On Thu, 12 May 2022 at 21:13, Carlos L. via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: =?UTF-8?q?Carlos=20L=C3=B3pez?= <00xc@protonmail.com>
>
> This patch adds a command line option analogous to that of GNU
> grep(1)'s -m / --max-count, which users might already be used to.
> This makes it possible to limit the amount of matches shown in the
> output while keeping the functionality of other options such as -C
> (show code context) or -p (show containing function), which would be
> difficult to do with a shell pipeline (e.g. head(1)).

Makes sense to me.

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 3d393fbac1b..02b36046475 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -23,6 +23,7 @@ SYNOPSIS
>            [--break] [--heading] [-p | --show-function]
>            [-A <post-context>] [-B <pre-context>] [-C <context>]
>            [-W | --function-context]
> +          [-m | --max-count <num>]

I think this should be

    [(-m | --max-count) <num>]

since the short form "-m" also wants to take "<num>".

> +-m <num>::
> +--max-count <num>::
> +       Limit the amount of matches per file. When using the -v or
> +       --invert-match option, the search stops after the specified
> +       number of non-matches. Setting this option to 0 has no effect.

Please use `backticks` with `-v` and `--invert-match` so that they are
set in monospace.

Regarding the special value 0, it's a bit unclear what "has no effect"
means. In particular, it can have an effect in the sense that when it
is used like

  git grep -m 1 -m 0 foo

it undoes the `-m 1`.

But also, that's not how my grep(1) behaves: with `-m 0`, it limits the
number of matches to zero. I don't know how useful that is (can that
zero-case be optimized by exiting with 1 before even trying to find the
needle!?), or if maybe different variants of grep handle this
differently?  If all grep implementations handle 0 by actually only
emitting zero hits, I think it would be wise for us to handle 0 the same
way.

As for overriding an earlier `-m <foo>`, which could be useful, it seems
to me like `--no-max-count` would make sense.

All in all, I would suggest the following documentation:

    -m <num>::
    --max-count <num>::
           Limit the amount of matches per file. When using the `-v` or
           `--invert-match` option, the search stops after the specified
           number of non-matches. Use `--no-max-count` to countermand an
           earlier `--max-count` option on the command line.

... and of course the matching implementation. :-) Maybe you could
achieve that by using -1 to signal that there's no max-count in play?
How does that sound to you?

Even if we want to handle the zero just like you do, I think this patch
needs a few tests. We should make sure to test the 0-case (whatever we
end up wanting it to behave like), and probably the "suppress an earlier
-m by giving --no-max-count" case. It also seems wise to set up some
test scenario where there are several files involved so that we can see
that we don't just print the first m matches *globally*, but that the
counter is really handled *per file*.

I think this `-m` flag would be a nice addition. I know that I've been
missing something like it a few times. As you wrote in your commit
message, `| head -3` can work for some use-cases, but definitely not for
others. This `-m` is a lot more granular than `-l` which can be seen as
a crude `-m 1`. Thanks for posting this patch! I hope you find my
comments useful.

Martin
