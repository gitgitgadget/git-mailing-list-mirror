Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70D731F404
	for <e@80x24.org>; Fri,  6 Apr 2018 22:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752565AbeDFWgS (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 18:36:18 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:37167 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751730AbeDFWgR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 18:36:17 -0400
Received: by mail-vk0-f44.google.com with SMTP id r19so1594696vkf.4
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+yH1MRio2Gao0/QMaJSB8ZDtD9AAMxIVXssAR6G7k4A=;
        b=bftUWbcHYM+leUCh9KLou0Vty2IG0hXwY5cEnoXvDyNuZ6kIc0N1uhfau7jWmtqBS/
         /pho3nqAok5+E/2+PLJQKO8pROXtJrVZ5votBlFgziA4iiCQOZWQmBE3IRMbIiIk1yIK
         jqCcIth80PFE6rnIygVIOAGV7M4wJaZnxsWvbfvGFYP2G/8zt8wKum2pvZeCoVMb2fhP
         MoI8RxKB/FC1BMsi4xZUx0SccevCRbr4Rv81vkSFiaQvy/Kslh0WN38rR6pGFTzJq7Gb
         9Ixa8SZFDhA12LATYCw2ju19OdZsyN8z/p6B4a/beXWZvm5BnVSCksn7h2TPq4qCVKCp
         9iDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+yH1MRio2Gao0/QMaJSB8ZDtD9AAMxIVXssAR6G7k4A=;
        b=XOi8YewqbDRZygsk8iovL/6TK8T1Qtl5b/2tqMQQvJ07RM93AZTCpIav2kDtveVIDz
         kBhSlcnzyK7u+XBLDriHOs6grOh8S9E4yQ2JsYOKt1ruZ+HuzhHLJGH2VOy7FvCMKQ47
         /ifnHJYS4bOIf1EC7FJ0TNa1sR/C5dqMTYhjJXQwjJ5negwNqsEpmunaTD5ef3a3cBSU
         17Ok5VI41dVg34sZXy3sjW0Jgsi2UfhGevnZp+cP+WsPyQwGo/3JkXm1vvv4R2feXhNX
         QGBCB/jjOMl2B2eyJJS41y3B/gwVEgVOiRenhpq0kzhTbsuPhTzexSW3D/I0UkHn89V9
         B+cQ==
X-Gm-Message-State: ALQs6tB4hro69RDfE+geVuUVmOZrj53V0geXXiaRslyQ5z+W50DZEhII
        J4EUG/RPxPZJHq+EVWYKoU/DvYXTzOZSQ5Jiozo=
X-Google-Smtp-Source: AIpwx4+2UldEUthNIUmQJAXxIp3dsmy/IjoGfaIbRyUIla2DDh10xCkfYg1DOKflGn380IuQS1tJRu9Balai2TJx49U=
X-Received: by 10.31.192.146 with SMTP id q140mr17528744vkf.7.1523054176403;
 Fri, 06 Apr 2018 15:36:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.40.42 with HTTP; Fri, 6 Apr 2018 15:36:15 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1804061233330.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <20180405174935.598-1-newren@gmail.com> <nycvar.QRO.7.76.6.1804052144310.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CABPp-BHhdxuV9a_4OfgaRu89Kx2039OLeS1vW-KdzpLxb-ZF3g@mail.gmail.com> <nycvar.QRO.7.76.6.1804061233330.55@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Apr 2018 15:36:15 -0700
Message-ID: <CABPp-BE0ERL0ueX_sqUwDvt_cQ8QYkzWruvSWZiFGNawR3vCeg@mail.gmail.com>
Subject: Re: [PATCH] Make running git under other debugger-like programs easy
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, Apr 6, 2018 at 3:38 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Thu, 5 Apr 2018, Elijah Newren wrote:
>> On Thu, Apr 5, 2018 at 12:57 PM, Johannes Schindelin
>> <Johannes.Schindelin@gmx.de> wrote:

<snip>

>> That all looks great to me.  But at this point, it seems like it's a
>> full rewrite and your patch to submit (which I'd be happy to endorse
>> in lieu of my own)...
>
> :-)
>
>> or do you want me to submit with you as author and me as committer?
>
> That would be my preference. I have not even tested what I wrote above...

Sure, will do.

>> Also, a side question: if we go this route, do we want to rename
>> GIT_TEST_GDB to reflect its expanded usage?
>
> Sure. Probably GIT_TEST_DEBUGGER? Or GIT_TEST_DBG? Or GIT_TEST_DEBUG?
>
>> > Then your magic "GIT_WRAPPER" invocation would become a bit more explicit:
>> >
>> >     debug --debugger=nemiver git $ARGS
>> >     debug -d "valgrind --tool=memcheck --track-origins=yes" git $ARGS
>>
>> No, for most (60-80%?) of my invocations, I wouldn't be able to use
>> the debug function; only a minority of my uses are from within the
>> testsuite.  The rest are from the command line (I have
>> git/bin-wrappers/ in my $PATH),
>
> Oy vey. bin-wrappers in your PATH? That's even worse than what I did in
> the first two years of developing Git: I always ran `git` in-place.
> However, I was bitten by a couple of bugs introduced while developing that
> made it hard to recover (if I don't have a functional Git, I cannot use it
> to go back to a working version, can I?). How do *you* deal with these
> things?

I also have an older system git in /usr/bin; if things go sideways, I
just explicitly use '/usr/bin/git' instead of 'git'.

>> > (In any case, "GIT_WRAPPER" is probably a name in want of being renamed.)
>>
>> Well, with your suggestion, it'd just be whatever that environment
>> variable is named.  I'm perfectly happy with something other than
>> GIT_WRAPPER (or GIT_TEST_GDB).  I'm not so good at coming up with such
>> myself, but maybe something like GIT_DEBUGGER or GIT_DEBUG_WITH?
>
> I like both. Pick whatever you like, as long as it starts with `GIT_` and
> is descriptive enough. Even `GIT_LAUNCH_THROUGH` would work, but
> `GIT_DEBUGGER` seems to be the shortest that still makes sense.

Cool, GIT_DEBUGGER sounds good to me, I'll just proceed with it.
