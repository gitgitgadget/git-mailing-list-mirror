Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11071C433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbiCINSW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbiCINSU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:18:20 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E2B8177D34
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:17:22 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id q189so2562572oia.9
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 05:17:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=diN4bijGfg54HdysDHroyIA7eQu+iZdkkS9aWSIdmXQ=;
        b=aIvYxw728QoV4j8DPWBpav+UVWionMIIxC6uS3krT5SZtqPCJxJJTSSJfovXBGMWaV
         6jbBFqzalaQDxuZ3inVteanQO8FzODJrhgpLptCOCWwi542OoPBEpK/CC9LwFiM9q0xh
         gUq0WwwH89cNFcdDq51/qgvGT1PuSYL8/HYzkdSzMfjFOAvxICsbtTC4dwhJphsSPqPq
         7PNV+DwQUJj8W+wX3Watk/x2hMq1VXLd2iVqoUlzj86XBQjbaYJ3YLw6u9IfHV9bFvo2
         KPwWyvt9QHWNOFpEUHhLpjJVauS5dGRHp83QzFGHgQ7sZJHieyhSC1KsETl5ir1m5uux
         TXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=diN4bijGfg54HdysDHroyIA7eQu+iZdkkS9aWSIdmXQ=;
        b=RWaXgZmFIoA43zIfPi6h1uPG+GNaqRqc0NzEa70+jzlm7HaUdCQztzQnZoeZ2Agsvh
         /4wTY1y+B8Li1S0ZWn2dG+IloB4/NoBAunLobB8Nu4uAc9muzc5sNrWvccFDEonYxif4
         icwuCGC2++AECVdHbMQlnq9ug+So7OxnIUkUuYZcxkEJFhkhr8QPQw3y2O9yMWZBg3K9
         djDghU2eafNIOwYHcBj5JXPkPeD7pjeHP1Upr7IaQvvBRofoh2+FQvtBsai8WAldsZbD
         IGD6Wq3g/5Zwewz61Nc6is08EybO36p8UgUvgY4KB3IssvkE5Lxs7VNVa6sV449lUi7x
         rZCw==
X-Gm-Message-State: AOAM530aIjyYaCY0lN4vj30yMuFox/apvRt9LDr9DiILhgZiEW+fnaBY
        Y+TfKLlD1hqEpvXnvIw+JAj87iCYofCkGCffhtLGi6wkPdE=
X-Google-Smtp-Source: ABdhPJy7guRf+chCYmHmNde+1Stf1Na/8Rd4127EWKXuZpYKysVQPZuQHKoGsxbbiNQFzsT0ZjiqOeRed5AAaJzqUZ0=
X-Received: by 2002:a05:6808:f8a:b0:2da:1e9b:e85d with SMTP id
 o10-20020a0568080f8a00b002da1e9be85dmr4296192oiw.111.1646831841650; Wed, 09
 Mar 2022 05:17:21 -0800 (PST)
MIME-Version: 1.0
References: <20220309123447.852883-1-bagasdotme@gmail.com>
In-Reply-To: <20220309123447.852883-1-bagasdotme@gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Wed, 9 Mar 2022 21:17:09 +0800
Message-ID: <CAJyCBORGGbn6d5UYMdRnfrbn9OONcgMMxaCyJ4qUoQY3+s8-uQ@mail.gmail.com>
Subject: Re: [PATCH] repack: Sync list of options between synopsis and
 description in the documentation
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 9, 2022 at 9:01 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Options list in the synopsis and description section of git-repack(1)
> are out of sync. The latest addition was in commit 1d89d88d37
> (builtin/repack.c: support writing a MIDX while repacking, 2021-09-28),
> which only adds -m/--write-midx option.
>
> Add missing options to the synopsis. Additionaly, sort according to the
> order they appear in the description.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/git-repack.txt | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
> index ee30edc178..26e997bde1 100644
> --- a/Documentation/git-repack.txt
> +++ b/Documentation/git-repack.txt
> @@ -9,7 +9,13 @@ git-repack - Pack unpacked objects in a repository
>  SYNOPSIS
>  --------
>  [verse]
> -'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
> +'git repack' [-a] [-A] [-d] [-l] [-f] [-F] [-q | --quiet] [-n] [--window=<n>]
> +            [--depth=<n>] [--threads=<n>] [--window-memory=<n>]
> +            [--max-pack-size=<n>] [-b | --write-bitmap-index]
> +            [--pack-kept-objects] [--keep-pack=<pack-name>]
> +            [--unpack-unreachable=<when>] [-k | --keep-unreachable]
> +            [-i | --delta-islands] [-g | --geometric <factor>]
> +            [-m | --write-midx]

Could we possibly just shorten the synopsis to something like this?

"git repack [<options>]"

As Junio mentioned here [1], this could be a more "modern" style?
Since the OPTIONS chunk below gives a more detailed usage, I
think we can get rid of the redundancy in the SYNOPSIS. And it also
helps with the aesthetic and clarity.

[1]: https://lore.kernel.org/git/xmqq1r0awse5.fsf@gitster.g/
-- 
Thanks & Regards,
Shaoxuan
