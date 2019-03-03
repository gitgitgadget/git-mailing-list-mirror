Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91FD920248
	for <e@80x24.org>; Sun,  3 Mar 2019 07:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfCCHS7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 02:18:59 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:33417 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCHS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 02:18:59 -0500
Received: by mail-ed1-f52.google.com with SMTP id c55so1681483edb.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 23:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hac+17Pl7SfOE0YRJYZ5IOjQcGckXBYQ1FZ0KL19SEA=;
        b=Kv7Oky7qEcJyQwWkrMBd/hAjv83096GBdVwYGLYcAPUpGN07h3PvGqPEjRpP0r1Qdx
         xqFuK/D2R6cvIuyQXPMVBiy7HPGi0myJpTlPgT2ztQgXqdVjdI4GB6z2mMYzuWu8fMlL
         XkfVt6cjp7RpU82ezjaboE6VenpCVpoTpZJJ/M2asy6yILWwkOzKfrtwHD+W9wMME0DI
         DrGjhvAWTs395XkVzk8eK3VPcSXtoIS60C0YHfwTl/zy+VLz+utrliMTk6PIIRXneXRb
         9HlJmpGCSIPXWvtD66KfWBsCF1D/UBPqhXSPX4KBhZ/Ysa1G/SXeEpSe/RZY9H4zmsrD
         KoNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hac+17Pl7SfOE0YRJYZ5IOjQcGckXBYQ1FZ0KL19SEA=;
        b=jLiw/9CSzqsPh8p582fVd0+YXWN7gWKWmkbQD/ekZo7ZW+yjT+lyfGKDUmWRIZCyYx
         9oP62LVPZ5WDX6t1VxELWzc+53SwsKCgssZzFefJXDzFAif8TOKJUocLAiXCxziLuPa0
         yjn8ArDHRmynX89DunMmdKCrmRghNR8DqcMdCmb/UhtuzAcl02MOWeqiyyZvclD8zwfy
         NzrBUvtUFtJAHcfP/LJsYE2MEMp6OmEyX+7QmN+amHiITX7I3hePFmrDgnW/yqdyLKBT
         jL0RVsBOyZsXKdZqxirAAVkq4h0zY1CUSUn7kpLA/0JrwkzW2GDC54UZgCW/+8Kwb9Nu
         LumQ==
X-Gm-Message-State: APjAAAWvBFK+ee9Mm8Mjjk+DA3NnhE4NacFACOBaPywKLYwb5UAcyYk7
        aw6Nww+EB0JOl32nFCFoYx2CWlihhk+hSGjePSk=
X-Google-Smtp-Source: APXvYqxBaWssNu7S9q84sFIT7lLgAdBvUdN6rT9nhqjr9/S9ebjv+yExgdlyIkQcJ1Efo1MR9ls3peMWrJlz/zDxVVk=
X-Received: by 2002:a50:b6db:: with SMTP id f27mr10188784ede.188.1551597536745;
 Sat, 02 Mar 2019 23:18:56 -0800 (PST)
MIME-Version: 1.0
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com> <20190302150900.GU6085@hank.intra.tgummerer.com>
In-Reply-To: <20190302150900.GU6085@hank.intra.tgummerer.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 3 Mar 2019 08:18:45 +0100
Message-ID: <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
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

On Sat, Mar 2, 2019 at 4:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
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

Yeah, I think that the main issue, now that Duy found something that
could be a GSoC project, is that the potential mentors are not
familiar with the pack access code. It means that Matheus would
probably not get a lot of help from his mentors when he would work on
adding parallelism.

That may not be too big a problem though if Matheus is ok to ask many
technical questions on the mailing list. It seems to me that he could
succeed.

> I'm a bit wary of a too large proposal here, as we've historically
> overestimated what kind of project is achievable over a summer (I've
> been there myself, as my GSoC project was also more than I was able to
> do in a summer :)).  I'd rather have a project whose goal is rather
> small and can be expanded later, than having something that could
> potentially take more than 3 months, where the student (or their
> mentors) have to finish it after GSoC.

Yeah, I agree with your suggestion about a project that declares
removing the global variables as the main goal, and adding parallelism
as a potential bonus.

One thing I am still worried about is if we are sure that adding
parallelism is likely to get us a significant performance improvement
or not. If the performance of this code is bounded by disk or memory
access, then adding parallelism might not bring any benefit. (It could
perhaps decrease performance if memory locality gets worse.) So I'd
like some confirmation either by running some tests or by experienced
Git developers that it is likely to be a win.
