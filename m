Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E14431F404
	for <e@80x24.org>; Fri, 23 Feb 2018 19:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754858AbeBWToS (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 14:44:18 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55279 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934377AbeBWSsX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 13:48:23 -0500
Received: by mail-wm0-f68.google.com with SMTP id z81so6412607wmb.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 10:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fqZXrvhh3xV2Dy+oRohKda9UwksyF9lSN3IUyisXRMY=;
        b=KiQChWDZkG4ukO/bHLCWA1q26Lz9pvi3clQzuBjntXCPolY3IPL8SqZBiG5pwXx7Z9
         2g/GwvZWoe8vfzN4iQsKYEBiqlumgw5W/6a4rGfrlMIZ+eF0iGeGNVeryfD/uw2FEeM8
         9wQUTjYErV07/hXo+wxzhY5OHYCJwyBi325op/3WVh+u6+wstL+MIxJv4RTrKeGZqufK
         1Fi9byT+G84pGzLJA9KWaBHtW4FecsMWUO+kUJ9i/GcfsHdv+/bevFpelGMx9YTvSxKi
         9tfTRgvOllNwSBjFMQBt2Gy6m+Jfaq1e7Ivlrn4/Qx0Gbc1j38wI0O0Ys7zHzZwsB1Hn
         NY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fqZXrvhh3xV2Dy+oRohKda9UwksyF9lSN3IUyisXRMY=;
        b=qPBhmvOBQJfigSmpT/A7oQ+3cbncHIMLBPLVz10j2o8YRLlRTOKNBcZLNXLi/WCxbi
         MxGqomJAr2rbdBvnFq9iUm8jbjggP0we4c1/nAq8FkXirmS1dTvybx59eIZntggj7esu
         iJ2YPTAzlURFHMkxKwn6+7jsE4R+Kta4HhtR+jPzqrmb8SeObUje72OtUEuoSyZtPNxs
         LTycrRrzEjk+acp3Pq7wvOgVXJ8zYyfZjSLAP5nCN/h1IdQTGXm7yEhoPvispVBRSzoF
         aaJSsJChZCnxAr2m/WmW/n82hsjxlyfJ4iTQEs3XJO29TvK0r5LkvfSE2EY4NLRXoKqH
         Vt/A==
X-Gm-Message-State: APf1xPBBLIY1T5c5L6fR4eNUO5bQ+Sv/OZBNGZOYm10uJK4TpCqHubhM
        D/M2kjZUEIpFVdeiqtwqvi3Ss/78d544soo25sE=
X-Google-Smtp-Source: AH8x226wEJoky2+VOWPPbBi81tbkRX9qZqiA3dDmxtFnosFc6qaLIuxfwSnj7QXr55M2W8WjaFK4BRtSRugd5+k6dTc=
X-Received: by 10.28.55.9 with SMTP id e9mr2460172wma.20.1519411702497; Fri,
 23 Feb 2018 10:48:22 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.201.11 with HTTP; Fri, 23 Feb 2018 10:48:21 -0800 (PST)
In-Reply-To: <CAHd499A+TT4zWPvW84B8XpmCdvoJCnSOZxY98MKZUO3h7cwo0g@mail.gmail.com>
References: <20180123001648.24260-1-isaachier@gmail.com> <675fa58d-bff3-d7e4-5fac-ecf1401932f4@jeffhostetler.com>
 <CAG6xkCbe+pLwTCButZGdPucHoRCq-a8mWfifd6z2bzGZNseE9A@mail.gmail.com>
 <ee5185b1-7820-b2ac-1bde-da1c761fa594@jeffhostetler.com> <CAG6xkCa_nKtzhJJq=v7gazWe+8FnN3mz1vDftzZw2WUFqJ1bzw@mail.gmail.com>
 <CAHd499A+TT4zWPvW84B8XpmCdvoJCnSOZxY98MKZUO3h7cwo0g@mail.gmail.com>
From:   Isaac Hier <isaachier@gmail.com>
Date:   Fri, 23 Feb 2018 13:48:21 -0500
Message-ID: <CAG6xkCahiTedAiB9m8yjMN=QD_KLqc_bKwT9nGt=y2Jd3SsSBw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] Implement CMake build
To:     Robert Dailey <rcdailey.lists@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yes I think I mentioned earlier that I have it hosted at
https://github.com/isaachier/git. I have been busy with a few things
so have not continued much since I started this conversation, but it
covers a large part of the Makefile if not all the significant
portions.

On Tue, Feb 20, 2018 at 11:28 AM, Robert Dailey
<rcdailey.lists@gmail.com> wrote:
> On Thu, Jan 25, 2018 at 6:21 PM, Isaac Hier <isaachier@gmail.com> wrote:
>> Hi Jeff,
>>
>> I have been looking at the build generator, which looks promising, but
>> I have one concern. Assuming I can generate a CMakeLists.txt that
>> appropriately updates the library sources, etc. how do you suggest I
>> handle new portability macros? For example, assume someone adds a
>> macro HAVE_X to indicate the availability of some platform-specific
>> function x. In the current Makefile, a comment would be added to the
>> top indicating when HAVE_X or NO_X should be set, and that option
>> would toggle the HAVE_X C macro. But CMake can test for the
>> availability of x, which is one of the main motives for adding a CMake
>> build. The current build generator uses the output of make, so all it
>> would know is whether or not HAVE_X is defined on the platform that
>> ran the Makefile, but not the entire list of platform that git
>> supports.
>>
>> Bottom line: should I add the portability tests as they are now,
>> without accounting for future portability macros? One good alternative
>> might be to suggest the authors of new portability macros include a
>> small sample C program to test it. That would allow me to easily patch
>> the CMake tests whenever that came up. In a best case scenario, a
>> practice could be established to write the test in a specific
>> directory with a certain name so that I could automatically update the
>> CMake tests from the build generator.
>
> Isaac,
>
> I'm very happy that you have started support for CMake. I have a lot
> of experience with it. I'd love to help contribute. Do you have a fork
> on github where this code is? I'd have to figure out how to apply a
> patch from email, I haven't done it before. I think the goal should be
> to replace the existing build system (this can be a transition that
> happens slowly). I've been in situations where multiple build systems
> are supported in parallel, worst case because of split personal
> preferences on a project. That is more counterproductive than asking
> the team to just compromise and take the initial hit on learning
> curve. Ultimately that's up to the Git community, but that would be my
> recommendation. But I think making CMake as complete as possible will
> help build that confidence and trust. I can completely understand the
> complexities and concerns they have.
