Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D16B20248
	for <e@80x24.org>; Sun,  3 Mar 2019 10:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfCCKEA (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 05:04:00 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33788 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfCCKD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 05:03:59 -0500
Received: by mail-io1-f65.google.com with SMTP id e186so1742174ioa.0
        for <git@vger.kernel.org>; Sun, 03 Mar 2019 02:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9LpUm4y3pzmGwUHzSg+/LwInalzmblgUY6qMmUJ1Gp0=;
        b=nS6hABphGH3Hh/fcTngdDCVSo0y26ORYupyQWcNdfVh5qpHecJxG8hGg/sryRKSu9X
         pqpi7K8OJQvLvbLRmqdHcvzqNJ2P68oXRAMHAzZOOSyN3n7jnqtCWN1FoAQD2q38XffX
         H+ggcEqlYh2hOnkw1JxmCsRnCJT+7jEBW1hpxOpORn5vx5wHln0vAHKRvbqtWuaZJPgF
         gC5YZFRCE5pkmecqUGKG53fUlSf+MLNX65KY0nHVCQgRNNV8UGfeuoQG2p5JNGFUGzmt
         kBz/6ChKLBC7tQcZabYmlO1Cucd68EKxp1jN3/hMpMUgOknNPytNjvBPlr3tR5OaJ1WE
         KiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9LpUm4y3pzmGwUHzSg+/LwInalzmblgUY6qMmUJ1Gp0=;
        b=PwtZ5aTjzVVTFMA5iIoKzfwWIERnCXGVXtOdroNjUOBT8yz1PhsZ85Wb8MAmoHvZWW
         vqCWimkV3LwkuBcQT+bghVjnGqq0cE2kAY0LqYadenlXnhpuv08akaAMTPQi+Ztu9OXo
         pQFQdM/AvRDbr81BY+HKTc/+nD/+q76ydBeFdKt8inxT3W10I7f1MbhTFxiksU1jxDYL
         G0QhKtzft30Qr5b8JFP/6xI0S4Gu6550GywFY3CCTWGQrQVxqj0rZO8o6gL0xpudsQOj
         oi+mTH5oYAgUvXx9gtfda4tDy/8FDXimB3JC9tvJlgdYN0tzp3GYBY/5kZcMG+MENivx
         qy0A==
X-Gm-Message-State: APjAAAUhu++lXVfOZ6YhBGvEX8kQ9XHLKB+SY18QOl9k17FM0JjL/+uf
        biscqulZZXAFxzMPn7YBQB021wHRU3VQb4sWSl0=
X-Google-Smtp-Source: APXvYqzK+S1gHDrVcW8QcB4lHg4r5XjetHSq3wmFKRI8dijPCgojlxWiNq1T6CqZMHjH8tp6h2sKAKtNpdhJW85oBYQ=
X-Received: by 2002:a6b:6b18:: with SMTP id g24mr6185172ioc.282.1551607438929;
 Sun, 03 Mar 2019 02:03:58 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com> <20190302150900.GU6085@hank.intra.tgummerer.com>
In-Reply-To: <20190302150900.GU6085@hank.intra.tgummerer.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 3 Mar 2019 17:03:31 +0700
Message-ID: <CACsJy8COJg4jGRKFwyi5Fc374To8Z3g3wHx+SD7zQTL5m-TbCg@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 2, 2019 at 10:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
>
> On 03/01, Duy Nguyen wrote:
> > On Fri, Mar 1, 2019 at 5:20 AM Christian Couder
> > <christian.couder@gmail.com> wrote:
> > >
> > > Hi Matheus,
> > >
> > > On Thu, Feb 28, 2019 at 10:46 PM Matheus Tavares Bernardino
> > > <matheus.bernardino@usp.br> wrote:
> > > >
> > > > I've been in the mailing list for a couple weeks now, mainly working
> > > > on my gsoc micro-project[1] and in other patches that derived from it.
> > > > I also have been contributing to the Linux Kernel for half an year,
> > > > but am now mainly just supporting other students here at USP.
> > > >
> > > > I have read the ideas page for the GSoC 2019 and many of them interest
> > > > me. Also, looking around git-dev materials on the web, I got to the
> > > > GSoC 2012 ideas page. And this one got my attention:
> > > > https://github.com/peff/git/wiki/SoC-2012-Ideas#improving-parallelism-in-various-commands
> > > >
> > > > I'm interested in parallel computing and that has been my research
> > > > topic for about an year now. So I would like to ask what's the status
> > > > of this GSoC idea. I've read git-grep and saw that it is already
> > > > parallel, but I was wondering if there is any other section in git in
> > > > which it was already considered to bring parallelism, seeking to
> > > > achieve greater performance. And also, if this could, perhaps, be a
> > > > GSoC project.
> > >
> > > I vaguely remember that we thought at one point that all the low
> > > hanging fruits had already been taken in this area but I might be
> > > wrong.
> >
> > We still have to remove some global variables, which is quite easy to
> > do, before one could actually add mutexes and stuff to allow multiple
> > pack access. I don't know though if the removing global variables is
> > that exciting for GSoC, or if both tasks could fit in one GSoC. The
> > adding parallel access is not that hard, I think, once you know
> > packfile.c and sha1-file.c relatively well. It's mostly dealing with
> > caches and all the sliding access windows safely.
>
> I'm not very familiar with what's required here, but reading the above
> makes me think it's likely too much for a GSoC project.  I think I'd
> be happy with a project that declares removing the global variables as
> the main goal, and adding parallelism as a potential bonus.
>
> I'm a bit wary of a too large proposal here, as we've historically
> overestimated what kind of project is achievable over a summer (I've
> been there myself, as my GSoC project was also more than I was able to
> do in a summer :)).  I'd rather have a project whose goal is rather
> small and can be expanded later, than having something that could
> potentially take more than 3 months, where the student (or their
> mentors) have to finish it after GSoC.

This is why I'm not involved in GSoC. I often mis-estimate the size of
work (and yes I would still like your tree-based index format in,
can't remember why it never made it).

So yeah if you find removing global variables (which essentially
identifies shared states, a prerequisite for any parallel work)
reasonable for GSoC, I'd say go for it.

Be also aware that this kind of refactoring work could result in lots
of patches and it takes time to get them merged, if your GSoC goal is
to get merged.
-- 
Duy
