Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0019C1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 00:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3Ann (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Aug 2019 20:43:43 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:33452 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbfH3Anm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Aug 2019 20:43:42 -0400
Received: by mail-qk1-f194.google.com with SMTP id w18so4752840qki.0
        for <git@vger.kernel.org>; Thu, 29 Aug 2019 17:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DQbx83Unm6ok8/rwSzIWwx/uiEd0YiGcRln6KwKp/4E=;
        b=1ufvp2fAPSqy76n6+TZSo98Ldb6gJyb+dEbQNnPRdMmx0uSETwL9SteyX7qXlmQt4b
         nRiiqLs6a2e8vx+7yjq4Pe8JhSTF8TeLtQbdvPHXmXTkX7VCF5Gwwz52DGS79M/CAun5
         FzIJZzTQY0qjMGYllYb3LF6lOJ7oHaUtLw/7V1q+h8MwNAnZsXVUIGdNpN+3SVC8FPQ9
         5DAa1dFpbqryG6NmwgjvBur4offZ0EBRB/J6ztiM01yvnwLs0mKVlf6A506sEw9A3827
         B6oBgIvCgMjQIM4SPpL3QIJtKHDpR8dp+asHWwt/WoOO3WhwoG0CQm/CO8Cue4/0Ok4k
         F6iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DQbx83Unm6ok8/rwSzIWwx/uiEd0YiGcRln6KwKp/4E=;
        b=Gq5vnLjUntqODD6BE96FWOVVByHbM67bAKXDeZRXhuFs1kOT0O67+NWDTjIh8dOnzt
         mrONALwum0b7qEQAMXHDTd0zYEwhrGtfe/LCrs1JFjnFCYFJD+wEvQA+w4pzKdk8Ex6g
         n+3XhOv+1kcHmStmE/qxPKi/yioc1A1l2FiJP6I8fDMr0ihMFnOWVOB9NWriJ6NqLkPo
         0UWAIBtlfYt812d27zB+u5g+c2vn/LJ7YXRR5memDyH1kW7MxV+GUGzF9zButxm0t2Cw
         U4tzxjbllAM3P1b+UooS3AFQ4cjjR4k2l9lXF+f17Dj8VWETpFsiDhZH3iaxXhCmAXm+
         GCOA==
X-Gm-Message-State: APjAAAVr7rX/AYUzxP5z0XblsDzs61rQtBeiOrXUuw/riNbiUweP5nm+
        ZuXmrUGkdH+Bmk72+2QDegW6mg==
X-Google-Smtp-Source: APXvYqzTtC81IYQ/fY3/xb7XoBCov2FFz+EK2wja4z+ArxtCX5WDww0sv+AmAA0676Kv2yG1z7Tdyw==
X-Received: by 2002:ae9:f30d:: with SMTP id p13mr5963844qkg.95.1567125821461;
        Thu, 29 Aug 2019 17:43:41 -0700 (PDT)
Received: from localhost ([2605:9480:205:fffe:ec30:b3cf:3d82:7185])
        by smtp.gmail.com with ESMTPSA id j6sm2356866qtl.85.2019.08.29.17.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 17:43:40 -0700 (PDT)
Date:   Thu, 29 Aug 2019 20:43:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] checkout: add simple check for 'git checkout -b'
Message-ID: <20190830004339.GA34082@syl.lan>
References: <pull.325.git.gitgitgadget@gmail.com>
 <dcf5c60c69d8275a557ffe3d3ae30911d2140162.1567098090.git.gitgitgadget@gmail.com>
 <7e406b35-9ff6-348f-bdee-7540381f000e@gmail.com>
 <206819d0-8066-e8e8-8967-8a1db05eea26@gmail.com>
 <20190829203037.vzxuaxpsghbdc6vl@yadavpratyush.com>
 <20190829214014.vijdotp4g65a5mk3@yadavpratyush.com>
 <CABPp-BF_uBTKT_5YmoMNoToiujuMdQia-OfxOPAJPrhT6jPbdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF_uBTKT_5YmoMNoToiujuMdQia-OfxOPAJPrhT6jPbdA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, Aug 29, 2019 at 05:19:44PM -0700, Elijah Newren wrote:
> On Thu, Aug 29, 2019 at 2:42 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> >
> > On 30/08/19 02:00AM, Pratyush Yadav wrote:
> > > On 29/08/19 04:07PM, Derrick Stolee wrote:
> > > > On 8/29/2019 2:54 PM, Phillip Wood wrote:
> > > > > Hi Stolee
> > > > >
> > > > > On 29/08/2019 18:01, Derrick Stolee via GitGitGadget wrote:
> > > > >> +
> > > > >> +    if (argc == 3 && !strcmp(argv[1], "-b")) {
> > > > >> +        /*
> > > > >> +         * User ran 'git checkout -b <branch>' and expects
> > > > >
> > > > > What if the user ran 'git checkout -b<branch>'? Then argc == 2.
> > > >
> > > > Good catch. I'm tempted to say "don't do that" to keep this
> > > > simple. They won't have incorrect results, just slower than
> > > > the "with space" option.
> > > >
> > > > However, if there is enough interest in correcting the "-b<branch>"
> > > > case, then I can make another attempt at this.
> > >
> > > You can probably do this with:
> > >
> > >   !strncmp(argv[1], "-b", 2)
> > >
> > > The difference is so little, might as well do it IMO.
> >
> > Actually, that is not correct. I took a quick look before writing this
> > and missed the fact that argc == 3 is the bigger problem.
> >
> > Thinking a little more about this, you can mix other options with
> > checkout -b, like --track. You can also specify <start_point>.
> >
> > Now I don't know enough about this optimization you are doing to know
> > whether we need to optimize when these options are given, but at least
> > for --track I don't see any reason not to.
> >
> > So maybe you are better off using something like getopt() (warning:
> > getopt modifies the input string so you probably want to duplicate it)
> > if you want to support all cases. Though for this simple case you can
> > probably get away by just directly scanning the argv list for "-b"
> > (using strncmp instead of strcmp to account for "-b<branch-name>)
>
> NO.  This would be unsafe to use if <start_point> is specified.  I
> think either -f or -m together with -b make no sense unless
> <start_point> is specified, but if they do make sense separately, I'm
> guessing this hack should not be used with those flags.  And
> additional flags may appear in the future that should not be used
> together with this hack.
>
> Personally, although I understand the desire to support any possible
> cases in general, *this is a performance hack*.  As such, it should be
> as simple and localized as possible.  I don't think supporting
> old-style stuck flags (-b$BRANCH) is worth complicating this.  I'm
> even leery of adding support for --track (do any users of huge repos
> use -b with --track?  Does anyone at all use --track anymore?  I'm not
> sure I've ever seen any user use that flag in the last 10 years other
> than myself.)  Besides, in the *worst* possible case, the command the
> user specifies works just fine...it just takes a little longer.  My
> opinion is that Stolee's patch is perfect as-is and should not be
> generalized at all.

I wholeheartedly agree with this, and pledge my $.02 towards it as well.
Now with a combined total of $.04, I think that this patch is ready for
queueing as-is.

> Just my $0.02,
> Elijah

Thanks,
Taylor
