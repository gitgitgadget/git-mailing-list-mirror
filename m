Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BEFC433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 17:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C679A6139F
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 17:18:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233805AbhJDRUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 13:20:37 -0400
Received: from mail-vs1-f53.google.com ([209.85.217.53]:44655 "EHLO
        mail-vs1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbhJDRUg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 13:20:36 -0400
Received: by mail-vs1-f53.google.com with SMTP id 66so4194466vsd.11
        for <git@vger.kernel.org>; Mon, 04 Oct 2021 10:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZYm5omWyhCXGEjdt17LhhCTwrN25aq+L379QBXzc/4=;
        b=f1mUU08YNA5lDrOsYzhyZ+7Q5ljGnYkeQLVNlt5MGrpnHzUzW2jFSAZ6132tFds5RQ
         27GSphsgWf0pBqrnBhUmSQ3Z0tqvAaLo/DKgxe4cUkYBna7rtuK6RJ5fP+M68+Ri6pwH
         ctJ6N2I6FmvRnmlpBBClf0HxQNCtu4IL4ODw4ksTsyyPdEy7fCTkGG9/FBH439whW0hV
         /uQuT/FxonGWJFd3vi05SavKsegQNaTqXzjmSTMVoKv/5dwmsz8CSNxYOe9mLVS9Vpm4
         PPD2o85/o6bzLO26vH2uLohXGHE7lFuQPypIvZOFoGPZ9IQf/UQtr9cCduGVD6LnXAG5
         lAzQ==
X-Gm-Message-State: AOAM5300w+Py13dJQ27pudWAdTT0H+0gPKi5nodbiJPp/RX4la1tQUAG
        smDWLoP0vOYu9bdKdNXzJNiNWACaeB8Oc4xssI1N0j1Bqb0=
X-Google-Smtp-Source: ABdhPJy4awybRWutKK5xLaSyYeuF3grAMjY4SryrYRf02eKcgMkyt0cP8ibwc9+mV2XtNvRTDQ3rsPriXp7xs+PAC4Q=
X-Received: by 2002:a67:cb0a:: with SMTP id b10mr14174110vsl.9.1633367927012;
 Mon, 04 Oct 2021 10:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAMuHMdXuTqUu6-b0y6VSFbEz7HKdH6U+__n7B8JRnO_ZWNeeLQ@mail.gmail.com>
 <87r1d0svy4.fsf@igel.home>
In-Reply-To: <87r1d0svy4.fsf@igel.home>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Oct 2021 19:18:35 +0200
Message-ID: <CAMuHMdUk5=sqFvy51nxv5g3UFPhQnZ-6dBOS=xVDWdTxuLKuRQ@mail.gmail.com>
Subject: Re: git send-email splits name with comma
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Andreas,

On Mon, Oct 4, 2021 at 4:31 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> On Okt 04 2021, Geert Uytterhoeven wrote:
> > If the name of an email address contains a comma, it will be split
> > incorrectly into multiple addresses.
>
> If you want to include a comma in the display-name part of an address,
> you need to use the quoted-string form of the phrase.

Adding more quoting like:

    git send-email --to "\"foo bar, geert\" <geert@linux-m68k.org>"

indeed works.  But I feel git send-email could do better, given it already
receives the full email address in a single argv[] entry.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
