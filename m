Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2531C20798
	for <e@80x24.org>; Fri, 11 Nov 2016 23:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965451AbcKKXQJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Nov 2016 18:16:09 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:33281 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964833AbcKKXQI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2016 18:16:08 -0500
Received: by mail-yw0-f194.google.com with SMTP id s68so2437185ywg.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2016 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TzwkqW4LplQw5Vm9Xyue0dwsZEWEyt0B2zeL+wcj2iY=;
        b=qLer1MUOeZNrf2LytBPab5YKD46bH7fTTCOeVNrdd+6UORfTPmpZBHXUrp/KWY0rhh
         HNaO0X1HW8eqcvGEY3BNx/sXh7ZfPvMbwakAAQAAChUqtiS27G4xhsCT8cTdZ4wtZ8R/
         Hn64tO2Y/foGBcGQJBKyTGEiEl5DPA3/KOMU9bA5xbHRRFJCaXdsvq89HesMKerOln23
         vr75Q+NUmUXbBcqgEJDiPhCDrSV19zk8SYMH0HzMY0AVZrbEiiLIo1vryV/fyY5UT2tp
         DIcc0OTfCDM9jEvuWZ+PTQujxk/mUEQPGnBSzSfbz7Pj9uZ6NWdxn6HYo91GKFZywLLh
         SEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TzwkqW4LplQw5Vm9Xyue0dwsZEWEyt0B2zeL+wcj2iY=;
        b=GwHklT0GiqjjtBV4epIESMkrLVr+Cqggx6Z4/Rkv0z3kFSrkdToWbQ2mbHhnLOqCGS
         xwHPlIgPBEyGDdKVAqhlfVtUgzAz7LK4TkgJPuYDYU40nZ5/4ATnhFwAXSjYR3jsAo5y
         vdAodghzX0T5SNFaVZJ6C0TZdYuPg5EW5MOMuhWlDE3/Jj++ixo8OSZ65sisJM9Vqfxr
         9kGvJxuXVr28J9R5YTHq+At7LPe/javD59Y2C/gyM5p8n8P/ZGU0+mlvJ8+rfJAVqxVw
         J3if8jDou7yke5qiEXcD/rqTpoF+0+F2xVxEeVkW76AAwzQG6jfBULRLLYQStTHxmFU7
         vqgA==
X-Gm-Message-State: ABUngvcLOo9Koqrd8sQkXJgJPo9Qwquh8RBeTPCIbkTPTfmEvFBAvB3fSVuzo3wxbr74seGpRrPy3Lc8nZMG6w==
X-Received: by 10.13.221.12 with SMTP id g12mr6217248ywe.257.1478906167442;
 Fri, 11 Nov 2016 15:16:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Fri, 11 Nov 2016 15:15:47 -0800 (PST)
In-Reply-To: <20161111201958.2175-1-dennis@kaarsemaker.net>
References: <20161111201958.2175-1-dennis@kaarsemaker.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Fri, 11 Nov 2016 15:15:47 -0800
Message-ID: <CA+P7+xr4xOhHJdL=1GbTrRXq_sdco7VYAq+arqw3Kc2gFvbO7w@mail.gmail.com>
Subject: Re: [RFC/PATCH 0/2] git diff <(command1) <(command2)
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 11, 2016 at 12:19 PM, Dennis Kaarsemaker
<dennis@kaarsemaker.net> wrote:
> Today on #git, a user asked why git diff <(command1) <(command2) gave only some
> gibberish about pipes as output. The answer is fairly simple: git diff gets as
> arguments /dev/fd/62 and /dev/fd/63, which are symlinks. So git simply
> readlink()s them and gets pipe:[123456] as destination of that link which it
> then outputs.
>
> Given that 'normal' diff provides arguably better output in this case (a diff
> of the output of the two commands), I wanted to look at what it would take for
> git to handle this. Surprisingly: not much. 1/2 adds support for
> --follow-symlinks to git diff --no-index (and only the --no-index variant) and
> 2/2 adds support for reading from pipes.
>

I think this is really useful. I have an alias so that "diff" is just
git diff --no-index. It's really useful, because I find the output of
git-diff to be much better. Not being able to diff from pipes or
symlinks is something I've run into before and it's annoying. So I
could really use this.

Thanks,
Jake

> No tests or documentation updates yet, and I'm not sure whether
> --follow-symlinks in other modes than --no-index should be supported, ignored
> (as it is now) or cause an error, but I'm leaning towards the third option.
>
> Dennis Kaarsemaker (2):
>   diff --no-index: add option to follow symlinks
>   diff --no-index: support reading from pipes
>
>  diff-no-index.c | 15 ++++++++++++---
>  diff.c          | 23 +++++++++++++++++++----
>  diff.h          |  2 +-
>  3 files changed, 32 insertions(+), 8 deletions(-)
>
> --
> 2.10.1-449-gab0f84c
>
