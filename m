Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 931BE20248
	for <e@80x24.org>; Fri, 29 Mar 2019 19:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbfC2TcD (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 15:32:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39585 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbfC2TcC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 15:32:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id j9so3936242wrn.6
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=okWob6Yha+Pch0F+VqyYegT4LqaK8qkjbvLnJRYzPEU=;
        b=e4Ev3mzB1O4lLTm+5V8hHbcRdnl3IdUouFqJ+Fr2ldOxrLdkZNu9OhuMRTNMlpZN0m
         1UFzzvkS0dbg5ki/rmasG2Pn+E7QOIPcm7mTR0I/mGyry103mi7YGptx9VWE/X754LX3
         1T/3Wu+XqonOAOR1WHmRZFgPL51W9O75BBG4MJ9NHImwyrgMI+fhnRhxNq+9UJ/sYfUo
         5Qo3KQpYL55H7yC55vRWR+/j9aDrp2YXbbif7IHmFOsGpkqPm0zgD6+zSyE4JlxS6tD2
         DOatdBM5nS45Uz/qu0MS/v6mR3jxAPz3i9txxnQaEZbLvyf5m3885uyODGfGrFmyXvnk
         aVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=okWob6Yha+Pch0F+VqyYegT4LqaK8qkjbvLnJRYzPEU=;
        b=ksZgPil9svV3Faa31jBvMCE3g7Jg/iSlsGPb9oE9aToOf4ej2n9dCbXqjW83ESd1jm
         FSlBJI+JWIJpbD1+2sR4HzK0BV/cPMOj/qfjnjIw9L6H11NbH450bL+36HMRE1VeccSr
         m2jQbLIXiAx+h4RJjVyn19+TEq5xnWiXOnRh1UndMHkXAXLMp+nZ2Y9obh/ylf7QFoRp
         LI9udK05YE6Bg7pkVcJEsY4Io/gQXMCo4dGfwKQJkUB56YK+/WPEcoZlZEYSWOZUzB4t
         2PNHBPg+Tf6fxB+DAqDjVqm9Xq9WZiab/O6JtV/a7MTI0ak5SjLgwSrS+jDC22E7xDSt
         +iIA==
X-Gm-Message-State: APjAAAWo4bhLQq925ioYqfs7hk6DrG/vDUOZ8ssL0gfp5s2TmANjy/le
        uPS1eFOcZHduS8loIDZ0lwA=
X-Google-Smtp-Source: APXvYqxXB4ELTvyV6FuOXXiLtcDBlOCx9j8gUA1tObKfTRngdJU4Kf2iZRRvBWPDb+ANtISKb5mQNg==
X-Received: by 2002:adf:e610:: with SMTP id p16mr32018167wrm.64.1553887920631;
        Fri, 29 Mar 2019 12:32:00 -0700 (PDT)
Received: from localhost ([31.127.45.89])
        by smtp.gmail.com with ESMTPSA id b204sm4440373wmh.29.2019.03.29.12.31.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Mar 2019 12:31:59 -0700 (PDT)
Date:   Fri, 29 Mar 2019 19:31:58 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Kernel USP <kernel-usp@googlegroups.com>,
        Alex Riesen <raa.lkml@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PATCH v4 1/7] clone: test for our behavior on odd
 objects/* content
Message-ID: <20190329193158.GN32487@hank.intra.tgummerer.com>
References: <20190226122829.19178-1-avarab@gmail.com>
 <20190322232237.13293-1-matheus.bernardino@usp.br>
 <20190322232237.13293-2-matheus.bernardino@usp.br>
 <20190328214950.GJ32487@hank.intra.tgummerer.com>
 <CAHd-oW70VNgYmX9=5x0CwoSD2a0ik2AoJyd7T3xiO4O030c5yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHd-oW70VNgYmX9=5x0CwoSD2a0ik2AoJyd7T3xiO4O030c5yQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/29, Matheus Tavares Bernardino wrote:
> On Thu, Mar 28, 2019 at 6:49 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > When sending someone elses patch in a slightly modified version, it
> > may also be useful to add which parts you changed, as it was done in
> > e8dfcace31 ("poll: use GetTickCount64() to avoid wrap-around issues",
> > 2018-10-31) for example.
> 
> Thanks, I didn't know about that! I searched the log and didn't see
> many of this on patches with 'Helped-by' tags, is there a particular
> case to use it or not?

Helped-by tags are usually used when you want to give someone credit
for help you got on a patch that you originally authored.  It's up to
you at which point of involvement you actually want to add the tag, I
tend to add them whenever someones input significantly
changes/improves the patch.  I think adding it here might be okay,
it's just less common when sending a patch that someone else authored
originally.

> > Iirc, the test that is added in this patch does not work on some
> > platforms, notably MacOS.  That would mean that we would break
> > bisectability at this patch on some platforms if we were to introduce
> > it here.  Therefore I think it would be better to squash this patch
> > into the next one which fixes these inconsistencies.
> > Note that I can't test this at the moment, so this concern is only
> > based on previous discussions that I remember.  If that's already
> > addressed somehow, all the better!
> 
> Yes, it is already addressed :) The section of these tests that used
> to break on some platforms is now moved to the next patch which also
> fixes the platform inconsistencies. Now both patches (this and the
> next) work on macOS, NetBSD and GNU/Linux.

Great!

>                                             Also every test and job is
> passing at travis-ci, except by the job named "Documentation"[1]. But,
> it's weird since these patches don't even touch Documentation/... And
> master is failing the same job at my fork as well [2]... Any thoughts
> on that?

Yeah, this error seems to have nothing to do with your patch series.
Since the last run of travis on master [*1*] at least the asciidoc
package doesn't seem to have changed, so from a first look I don't
quite understand what's going on there.  In any case, I don't think
you need to worry about that for now, as it hasn't been triggered by
your changes (I won't discourage you from looking at why it is failing
and to try and fix that, but I think your time is probably better
spent looking at this patch series and the proposal for GSoC for
now).

*1*: https://travis-ci.org/git/git/builds/508784487

> [1] https://travis-ci.org/MatheusBernardino/git/builds/512713775
> [2] https://travis-ci.org/MatheusBernardino/git/builds/513028692
