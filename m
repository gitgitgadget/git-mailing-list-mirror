Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9A57F20248
	for <e@80x24.org>; Wed,  6 Mar 2019 23:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfCFXR2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Mar 2019 18:17:28 -0500
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36073 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbfCFXR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Mar 2019 18:17:27 -0500
Received: by mail-wm1-f52.google.com with SMTP id j125so7527576wmj.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2019 15:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GIOkdMwSjbb1JMOXHSFlVhNDRLDB8pKEZcuLCyLrO1Q=;
        b=DoYyMS8u9bB+gEr4Si7KPdaZ4Yp9Bjt+qdYv1FtMd2U8DQWgbcSTT5yfOLea7tpn0n
         v7ZwH+qDAsqTgGMbAu4QdSMTiVIoNLHQzLjjFcRIqptQNwA9z511n+PNM/2gxR1S5qyP
         8YauzkZXkN1wFcwugZgBV2Yu/NFam6tDETksBsCi7hKMtqQi2iYSNdL5cC2VL/fNodjk
         rKuM7+52UWmdXt2kv2ECbLvFsBQeTsoVsZv+8pM+ATCHdt/A9hrPWYjEC3C0zOh+XXBA
         c+siFjOKqsPdCNKwcEElnG5QKc+wW3tEdNAYxDoi2dWCpKgXIwrDj9IcbmQYrfxmBHlQ
         N8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIOkdMwSjbb1JMOXHSFlVhNDRLDB8pKEZcuLCyLrO1Q=;
        b=NUxzLIs2po9FYhTBJEnVRkzJVaw+cizsSoNqRup0a+oS9XsOGd+FQiCaN1SWzk3aRl
         dzw9OYxXGPXJVmcYLFYNen1zfUuCTeTGCmtVQTQcNmosQ0mOvacrshV+4RxD6KBDuFe8
         xLlpsbjgPUdefum9TX2MP/lo2qyaVFu/8A7gVJIFdkP/8DEAiDFyRfeGpAZUNEDIYdz1
         QogHJcs91r6PJ5vHK00UMMtdjSKEqtbIOLUMlpI3yP4CqMBrXqhF3CJWoPs6aWb1kI1R
         8CcgkaRWnBqZ/HF2wlgTQOaetxMWWxoLQWYwRtZGLgK+F6U2bgcLOq2spf/Nw/8XympK
         gXow==
X-Gm-Message-State: APjAAAWKi3vJvZwKWo/EU6TDVS9/j7QCBYA2fstcVPIjVtoVbty9zR/j
        FvU+Tf1f55/YO825UBW0wzQ=
X-Google-Smtp-Source: APXvYqzDutqU5ygxIID5kzbcm4CoxjNGNC3RXMXKlQ4zzdj8IFbOGWAUT0ZWQslBl6Wqv9QBK5mPnw==
X-Received: by 2002:a7b:c14a:: with SMTP id z10mr3058434wmi.99.1551914245882;
        Wed, 06 Mar 2019 15:17:25 -0800 (PST)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id q135sm5461896wme.43.2019.03.06.15.17.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 15:17:24 -0800 (PST)
Date:   Wed, 6 Mar 2019 23:17:22 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Elijah Newren <newren@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: Questions on GSoC 2019 Ideas
Message-ID: <20190306231722.GA6085@hank.intra.tgummerer.com>
References: <CAHd-oW7onvn4ugEjXzAX_OSVEfCboH3-FnGR00dU8iaoc+b8=Q@mail.gmail.com>
 <CAP8UFD0jF5k31tBhj=bQMGOJKN8-F-Rx7RXF1SHZ22LEgSo9_Q@mail.gmail.com>
 <CACsJy8AL7DMbV7hhNeb1beucxQnZBHfgv4xo9dK5T+WCK7Q6yw@mail.gmail.com>
 <20190302150900.GU6085@hank.intra.tgummerer.com>
 <CAP8UFD31YKt7fm+shWdBxsL4fCSO4dU=97YwFsZ9gZBpEWmRPQ@mail.gmail.com>
 <CAHd-oW6rVptPnHn-aoeMTkp0p-TmoQ7fniftpQm9rw+tjukZ_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW6rVptPnHn-aoeMTkp0p-TmoQ7fniftpQm9rw+tjukZ_w@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/05, Matheus Tavares Bernardino wrote:
> First of all, I must apologize for not replying during these last
> days. I'm traveling and I rarely get a connection here. But I'll be
> back March 11th.
> 
> On Sun, Mar 3, 2019 at 4:18 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Sat, Mar 2, 2019 at 4:09 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > >
> > > I'm a bit wary of a too large proposal here, as we've historically
> > > overestimated what kind of project is achievable over a summer (I've
> > > been there myself, as my GSoC project was also more than I was able to
> > > do in a summer :)).  I'd rather have a project whose goal is rather
> > > small and can be expanded later, than having something that could
> > > potentially take more than 3 months, where the student (or their
> > > mentors) have to finish it after GSoC.
> >
> 
> I totally understand the concern.
> 
> > Yeah, I agree with your suggestion about a project that declares
> > removing the global variables as the main goal, and adding parallelism
> > as a potential bonus.
> >
> 
> Talking about a delimited scope for GSoC and a potential bonus after,
> a potential idea comes to my mind: I'm still trying to define the
> subject for my undergraduate thesis (which must be in HPC and/or
> parallelism on CPU/GPU). And the idea of bringing more parallelism to
> git seems to be too big for a GSoC project. So, perhaps, if we manage
> to identify wether parallelism would indeed bring a good performance
> gain to git, I could propose that to my advisor professor as my
> undergraduate thesis and I could work on that during this whole year.
> It is still an idea to be matured, but do you think it would be
> feasible?

I think this idea is generally fine, but your project proposal should
only be about the parts that are going to be included in your GSoC
project.  Of course we love to see GSoC students that are still
actively participating in the project after GSoC.  However that should
not be part of the sponsored program.  Mentors may also be less
available outside of the program, as mentoring can take quite some
time commitment.

Another slight concern here is that the mentors may be less familiar
with this project than others (I for one am not very familiar, and
Christian mentioned similar concerns), so it may be harder to give you
good advice.

All that said, if you are still excited about this project, think
about how to address these concerns in your proposal.  And feel free
to discuss the proposal on the mailing list as well, before actually
submitting it.
