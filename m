Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B138320248
	for <e@80x24.org>; Sat,  2 Mar 2019 15:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfCBPJE (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 10:09:04 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42601 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfCBPJE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 10:09:04 -0500
Received: by mail-wr1-f66.google.com with SMTP id r5so879548wrg.9
        for <git@vger.kernel.org>; Sat, 02 Mar 2019 07:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SFDIlgjoIZItrcsVtn0ozzGMpOM6f4TYbkd9ntZm1VY=;
        b=uOWVqEQVoCdQiSu7596z+47KpUPU5LvQYy1QApmM9MM4w2Pvt4JJTSROLetMJTc97U
         raqLf22mHRyWE96rKJc9h7FmaV91h5a8u4YqPjM1FNsbQaLDeVQr/UCD/rRiQCyIxYG9
         TbG6tAMRHTE8ZVg8HLhw0kRft8REIquP4Ajkm46wBFrzSKVBnI6efJybqDRisUV1LIu2
         Pl5G6+8axzcpMsstc2VGCKp+uTCE6/nK5OAjXiO1UygTQ0FqUb0B2C3i1A6V8+BfjLE4
         wHRpaOm6djjarVp8ErHQkri43r3okmMMQU2PxAP6+QKkApnUbkXfo/mPjcYc+4y82CD4
         kUhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SFDIlgjoIZItrcsVtn0ozzGMpOM6f4TYbkd9ntZm1VY=;
        b=Bd85s1kY/lOs1BRYdQR32h5t7jSEw4Ij5eTySM7qFPn5Ydy6aMYhJJLC+2HvyV9KjO
         DC6LOogLS9JGTUXTvVDT15JvjCO1MKf1COVUqCEUsr9ok2PU6NNNPPzOc9Rf50iUExv1
         sqZJBp+9PKH1RAs6PEp5HlPEEv7D4lkP1WNnWjOfdtInAmluBL6OK+kcNZK45gQMURbc
         CMWiCtpcpSS+vuufsWfugdBmDA68uz+OKQAK6G7sczs44JggW4/YrvBAyd+kqtgsbH6j
         qr4NjWoEO1NdxQD4hDehnDnUFbSw93kva/RTfrd5XpMs9Tu4Ky4eaSVrexIwgguWXT7/
         Bseg==
X-Gm-Message-State: APjAAAWZSQwNn9LIerLKWDd5CXb61l2mNwS8FpYzyxcJf/Hpli+um21k
        Ddqv5KtCu37Ls+aJQc5Hv+UtxdD9S/0=
X-Google-Smtp-Source: APXvYqxdwBsFNtdJQikjJVQO2aRCqc2ru5leUqMqxw5+UbuHFZgFb8rxI18/KLhqPrwTMN5+cT599w==
X-Received: by 2002:adf:81a1:: with SMTP id 30mr7666217wra.285.1551539342242;
        Sat, 02 Mar 2019 07:09:02 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id r70sm1858655wme.46.2019.03.02.07.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 Mar 2019 07:09:01 -0800 (PST)
Date:   Sat, 2 Mar 2019 15:09:00 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        git <git@vger.kernel.org>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
Message-ID: <20190302150900.GU6085@hank.intra.tgummerer.com>
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/01, Duy Nguyen wrote:
> On Fri, Mar 1, 2019 at 5:20 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > Hi Matheus,
> >
> > On Thu, Feb 28, 2019 at 10:46 PM Matheus Tavares Bernardino
> > <matheus.bernardino@usp.br> wrote:
> > >
> > > I've been in the mailing list for a couple weeks now, mainly working
> > > on my gsoc micro-project[1] and in other patches that derived from it.
> > > I also have been contributing to the Linux Kernel for half an year,
> > > but am now mainly just supporting other students here at USP.
> > >
> > > I have read the ideas page for the GSoC 2019 and many of them interest
> > > me. Also, looking around git-dev materials on the web, I got to the
> > > GSoC 2012 ideas page. And this one got my attention:
> > > https://github.com/peff/git/wiki/SoC-2012-Ideas#improving-parallelism-in-various-commands
> > >
> > > I'm interested in parallel computing and that has been my research
> > > topic for about an year now. So I would like to ask what's the status
> > > of this GSoC idea. I've read git-grep and saw that it is already
> > > parallel, but I was wondering if there is any other section in git in
> > > which it was already considered to bring parallelism, seeking to
> > > achieve greater performance. And also, if this could, perhaps, be a
> > > GSoC project.
> >
> > I vaguely remember that we thought at one point that all the low
> > hanging fruits had already been taken in this area but I might be
> > wrong.
> 
> We still have to remove some global variables, which is quite easy to
> do, before one could actually add mutexes and stuff to allow multiple
> pack access. I don't know though if the removing global variables is
> that exciting for GSoC, or if both tasks could fit in one GSoC. The
> adding parallel access is not that hard, I think, once you know
> packfile.c and sha1-file.c relatively well. It's mostly dealing with
> caches and all the sliding access windows safely.

I'm not very familiar with what's required here, but reading the above
makes me think it's likely too much for a GSoC project.  I think I'd
be happy with a project that declares removing the global variables as
the main goal, and adding parallelism as a potential bonus.

I'm a bit wary of a too large proposal here, as we've historically
overestimated what kind of project is achievable over a summer (I've
been there myself, as my GSoC project was also more than I was able to
do in a summer :)).  I'd rather have a project whose goal is rather
small and can be expanded later, than having something that could
potentially take more than 3 months, where the student (or their
mentors) have to finish it after GSoC.

> -- 
> Duy
