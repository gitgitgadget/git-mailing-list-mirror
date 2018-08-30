Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0BC51F404
	for <e@80x24.org>; Thu, 30 Aug 2018 02:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbeH3GKU (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 02:10:20 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:55271 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725844AbeH3GKU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 02:10:20 -0400
Received: by mail-wm0-f51.google.com with SMTP id c14-v6so324722wmb.4
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 19:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkifmVDTvrKoKRz++8tgfnn5y+76fZOAz6Z3sUWXFyA=;
        b=MRW9HvTqQiO/+mhgbR9xhjdaeI9ZCcVZ2Ss0GMXSuUwYizmNtNb6M9aKV6+PgkFcA0
         IYd2mxCUDy8j/P+lZqNicDOqiTMbfNY+kI8nhreSvT3LkvnsIBBGoxW6MaKJ6aeQxzVP
         LJYpI56tvWalNzUGIf70jG4nxm+QVoYI7RBg8WU00+0BHeB3SH4ObUvzwFTAdS5Cvj32
         iY0UZEadPmY+cPFTS80qCdlbtzF2SJTdDKn3GYZZE5WtEpUjY+/6kLFufMeOFcBIQ99Y
         1JE736Yz9JZ8/IuZNQTWejr3pD6Sk7+Dyu655hn7z0znXFxt/oNl1WgCtFYxjnkNoVeT
         QtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkifmVDTvrKoKRz++8tgfnn5y+76fZOAz6Z3sUWXFyA=;
        b=TswSXQrBgq2yOALhzrd7HT8q1a7Txklle6OpI4IHU9+NxC2PW+e0j9vgbWrh+e7ZUl
         BzmaCrVe3vKG58zUyjWV70OLUzPtI5iYcAGSsIUj3QHdCfONHc+IObCaKRq3SEPYMUXx
         7Wrk3XKV3SOKSVV7oRDCW3CbOwgyykl36RU2nq8AVbtUKPvVl7JG+ZFG/0mhvW3BwKWs
         IU5hE0ePLmgo4rA/DxQ07PezHMAezYAz7f1ia2c/GvDjYFrh9I26mxTkZmv7OJCCz2Mf
         QeD/JLlzBR134NzgfP3oacO0Ume28N1qdXRct/N9LSexvYNNQ8TmobLPnRM1sGL7b7v9
         sXTA==
X-Gm-Message-State: APzg51CeVdoVV8NE9zTRdiwOIYAFqqBEUCCNFUUVLJBNPb0GxViI4EMT
        UclmFKpNbLWgLw5L99XA8xg54OfotG9VL/GLfl4=
X-Google-Smtp-Source: ANB0VdYJlB5X9iHgVL+9VxSLxWwTRyLKNu0p97gx0sikU52KwtFp8OHVP7gVgaE8rI6qD5Z06sKfN7m6Z0ekJCLDnUU=
X-Received: by 2002:a1c:6486:: with SMTP id y128-v6mr345083wmb.12.1535595033225;
 Wed, 29 Aug 2018 19:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com>
 <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com>
In-Reply-To: <CAGZ79kZ1BVTLnNYSs+NjEO1T1-PySSdZzVU-0ZfivjT_pfvviQ@mail.gmail.com>
From:   Gabriel Holodak <gthepiper@gmail.com>
Date:   Wed, 29 Aug 2018 22:10:25 -0400
Message-ID: <CAE6=WB_t7zG3jtELiMfggqxjvD4jJyJ02pNPmV3fey=3nSejuA@mail.gmail.com>
Subject: Re: Possible bug: identical lines added/removed in git diff
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I did have some possibly interfering settings in my .gitconfig
previously. I removed everything, so all the commands I'll describe
were run with an empty config.

On Mon, Aug 27, 2018 at 1:47 PM Stefan Beller <sbeller@google.com> wrote:
> I suspected you might have a different diff algorithm configured,
> so I tested
>     git diff --no-index old new
>     git diff --patience --no-index old new
>     git diff --histogram --no-index old new
>
> all of which do not reproduce the issue.

I don't believe I had any settings to change the algorithm. Using any
of --minimal, --patience, or --histogram seems to fix the issue. It
still occurs with --diff-algorithm=default. I also tried
--no-indent-heuristic, which had no effect.

> Are there any encoding issues locally (Which platform
> are you on?) or in transit (Could you re-download the files
> from [1] and confirm it still produces this bug?)
>
> [1] https://public-inbox.org/git/CAE6=WB_4_PhjfQpubFcYkNKejfDr22s-y0nPQKw5Yd4GVaN4Yw@mail.gmail.com/

I should have mentioned before, this is on Arch Linux. I can reproduce
from the downloaded files. I can also reproduce on macOS 10.13.6, with
git 2.18.0.

> Could you cut down to a real minimal reproduction, i.e. just these 20
> lines or so?

I'm working on getting down to a minimal reproduction, a few lines at
a time. One thing that seems strange: as I've removed lines, there are
a bunch of lines that don't matter. Then I'll find some lines that, if
removed, completely fix the issue. But the ordering for these
apparently important lines doesn't matter. They just have to be
somewhere in the file to cause the duplicated diffs.

I'll upload again when I've figured out all the unimportant lines to remove.

> Do you have any smudge filters or configuration regarding
> line endings?

No filters, I did have core.autocrlf = input. But as I mentioned, I
can also reproduce with an empty config.

> Are the lines really different or the same ? (Can you inspect with a
> hex editor, maybe there are different kinds of invisible white spaces?)

Yep, the lines in question are identical.

Thanks for looking into this.
Gabriel
