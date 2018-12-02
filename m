Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74FB0211B3
	for <e@80x24.org>; Sun,  2 Dec 2018 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725562AbeLBRJ7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 12:09:59 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:44898 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbeLBRJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 12:09:58 -0500
Received: by mail-io1-f42.google.com with SMTP id r200so8478215iod.11
        for <git@vger.kernel.org>; Sun, 02 Dec 2018 09:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mJvlZSVZM+U44GZ5eHgRwZF4qkQ0JJcW3riU+tjQxyk=;
        b=CrndA5k+iW2OGIOuAr0Kqaztah+MlcjndfoWIYnRSSK+rkfNkGsyckLF/48MjOJcTV
         uWAWSkLo0BRaO+xuUysZU0Ui7Zazh9AL1OQiITjY4GwFiFVypJcpqvZLbDqa4cH8C0j1
         u4xaU2sik4QeNxUrsB0jIBd9YicR9lT4IzyF5c9rzW6SuZ7HHo1PYFypZqdVlBGdZNfm
         YOW8QxelFn7TPaDetloEvX6t9piBt+suHi0j1Isj6wjocNinku8Bjc0SZsr76AI4mUNQ
         lXOLToWa2zDZ9jZRl1c/COVxPT32IDjhqPP8OyeazqQOc95RI7UK/5IQqKqIT/KmrL2i
         NxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mJvlZSVZM+U44GZ5eHgRwZF4qkQ0JJcW3riU+tjQxyk=;
        b=cYJfYUYbqtuW69CWxRXlPkiDCP45CEV7P6+Q5qcq8z8Z/KhIsFdZeM6AHMmjZhXCQ6
         z2nXSv8oj/oK9MHRQqU5x1idBSanCBU8su98ew3f38bCT72hbBxbPZJTzCK/6gvHOTtb
         O9TarYSFzt5GglJp/Ya7mkzkZujJVV8gQR0VG5fbBhzlkDtF9bBnZsWAjK6WvKD3C8bB
         6WmQIfpz5PlzndvjQ5h4HIfDckEaOGYBsqqH0MguVnF78TW8fopjpt+M8RgH95t5wKR2
         xPo7WJ5/WTumXPI/m71QKJU504K7GhiTXlnciLHkjaVp3yXrinQAkjRRfVIICj+NDm8I
         UzFQ==
X-Gm-Message-State: AA+aEWYt3cVJ1wLtGcK0ObZlPkn18HbCiZgW8GvthqRJmudYOUw7djUm
        YtbzUbo2GU+tDNzc4pm2yUkrb9CEyg9lqRSk8lc=
X-Google-Smtp-Source: AFSGD/VQCuAnrxYkPzrAMHf418q65RLb1i2/UN6DIzI3kZHXFL9NgRNG6RHzT5a3PhMPvKzQIlq84NP0W1AO5purjLI=
X-Received: by 2002:a6b:6f15:: with SMTP id k21mr1326484ioc.236.1543770594550;
 Sun, 02 Dec 2018 09:09:54 -0800 (PST)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1812021124350.5509@localhost.localdomain>
 <20181202165617.GG30222@szeder.dev> <alpine.LFD.2.21.1812021201550.6459@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.21.1812021201550.6459@localhost.localdomain>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 2 Dec 2018 18:09:28 +0100
Message-ID: <CACsJy8AkMfZ02b9p2sQi2p=Bw4MDckLYy_cBFVeN2_UY-Z3kCg@mail.gmail.com>
Subject: Re: "git add -p" versus "git add -i", followed by "p"
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Dec 2, 2018 at 6:05 PM Robert P. J. Day <rpjday@crashcourse.ca> wrote:
> >   Patch update>> 2
> >              staged     unstaged path
> >   * 1:    unchanged        +1/-0 README.md
> >   * 2:    unchanged        +1/-0 contrib/README
> >     3:    unchanged        +1/-0 t/README
> >   Patch update>>
> >
> > Here I hit enter.  Did you?
>
>   perhaps i'm just not seeing it, but from "man git-add", it doesn't
> seem obvious that you would first select the files to work with, then
> hit a simple CR to get into actual patch mode.

I think it's the same procedure as the "update" step, which describes
this in more detail. I agree that the "patch" section does not make
this obvious.
-- 
Duy
