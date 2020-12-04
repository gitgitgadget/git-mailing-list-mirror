Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F8CC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 03:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ABCB22510
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 03:29:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgLDD3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 22:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgLDD3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 22:29:16 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16B9C061A4F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 19:28:29 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id q13so5780022lfr.10
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 19:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53WC59Uas79QvVTWNXdILQmEi6o3IudfMiJENyavJsM=;
        b=YSd8O9M34V6AQyk4lD7hcEV0+mIoXVU1YBK491i5bjOQ78AzTXv+LjNZ2TpnjjpeZU
         a/TtYUZyZMbM/foq1a28h5bRdpCJ5ZrxVwsbX+DHLJHVqeaBuI7zWWK75xsXpSFdL8pD
         +20CVZCbyznAe1CfmZUKbf5Buw3eOxgfmtTiNFgKoM+lxN/bzioptJAuwnqJT6YvwTXi
         YUmNAZgBRYMD0ETBDCxtloiL/2yW/jhGBDUd2Wz+FMqIqtyzWdB6TkfKQbiAMsjlYd4j
         Wsw0wWb7MLpH26wLHSHLrs2isbI19c+YYsXvidI/22pbr27i8zkvV+/8c8fcUe9sxMxL
         uf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53WC59Uas79QvVTWNXdILQmEi6o3IudfMiJENyavJsM=;
        b=WeSpEkiI0spSDftBmGTN9isv1wAQxB5c44klEQ3Rs/anR4VzrP6sWDbuto+v9r3Izv
         0WGS5NDOIC3N7rpL5petItm+Mgvmu2zS6WBV0a2EOVmvVoM3bqWwACfIMKHDM+BPwNhJ
         HIu7ZXoCFr/WTGSCWYRfTpZHLaZG8dx+RvVRmcdYkHG3RC/0gucvjOK2zp8mPFLi0koU
         UNShb8RbavCBbqt04y5sd+YFf8SJOFeFUF3/EyTO/PIUkF3FE/Bku7x00PAUuL0KLQOL
         cJsveMXt2bDC3Sfyfpe7umwe4aCFV4ZGsam9ZAA74gE785gkeadr8Dv4lsRXxh8c4jfG
         ssew==
X-Gm-Message-State: AOAM532MKZYUB8cSltb/wvQeAVcTDeSRl77Kx1IY3tdAVvjyqEGm1TZz
        Y6Fsfae57ItYpcr+rPr0dssAMKLg78U9GWEmkb3ilNxr
X-Google-Smtp-Source: ABdhPJzcHDovidhw2ezF41S0oMRrMC0UZ3lmHaSEFM2JsdCJC5jpaLluzrIBP0jCQwsGfHYuXzDjp6MxsQqZmbcGRqE=
X-Received: by 2002:a19:348:: with SMTP id 69mr2512006lfd.152.1607052508359;
 Thu, 03 Dec 2020 19:28:28 -0800 (PST)
MIME-Version: 1.0
References: <I55UpoMB_QMpFuqJEp1cHW7oN8AJy-b5iveBe2kZLslum_LOctwR5IdXUJhzZETg7bZDtm4beN38Nz6kvpJKDf0luxBMFxfpoFCYWkwaae4=@protonmail.com>
 <X8mjLHvNCYimATw7@google.com>
In-Reply-To: <X8mjLHvNCYimATw7@google.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Fri, 4 Dec 2020 13:28:17 +1000
Message-ID: <CAN05THQGqV4hP218hb3QXjJhQbbBCDRHgf=PAty=Ydd78a679A@mail.gmail.com>
Subject: Re: [Wireshark-dev] [Outreachy] Internship blog 2020
To:     Developer support list for Wireshark <wireshark-dev@wireshark.org>
Cc:     Joey Salazar <jgsal@protonmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 12:47 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi Joey,
>
> Joey Salazar wrote:
>
> > Very happy to be joining for this winter's internship! A short blog
> > entry on the beginning of this journey here: https://jsal.home.blog/
> >
> > A new entry every 2 weeks, check it out!
> >
> > Thank you Outreachy, Git, and Wireshark for the opportunity, happy
> > to be working together!
>
> Welcome!  I'm looking forward to working together (starting with an
> initial wireshark patch to get the lay of the land, then fleshing out
> the plan for the project, then executing on it in earnest).
>
> A question for wireshark developers: are there preferences for what a
> high quality dissector looks like?  [1] talks about portability and
> robustness but doesn't address other aspects of convention such as how
> long functions should be (like [2] does).  Is there a rule of thumb
> like "when in doubt, do things the way <such-and-such dissector>
> does?"

Only speaking for myself. This one is tricky.
Most dissectors I think follows [1] and [2] pretty closely, with the
exception that I don;t think
there is any concern about lengths of a function. For a lot of
protocols you may end up with
switch statements with hundreds of cases and then that is just how it
is. Or similar.

Now, this is not uniform across all dissectors. Wireshark has grown
organically over more than two decades
and styles and preferences, which at the end of the day are dictated
by the developers, change.

So do not be surprised to find some dissectors that are very different
in style. In some cases it might
just be that the dissector is very old and also for an obscure
protocol that almost no one cares about.
Sometimes it is that simple.

I would see [1] and [2] as good guidelines but not absolute law. Then
also when in doubt look at how are things done
in popular protocols where there are many developers involved and
where the dissector is well maintained.
For example  packet-smb2.c  is pretty modern and has a fair amount of
crunch to keep up with the evolving standard.

Modern and popular(i.e. people care about them) dissectors also are
much more likely to contain useful examples of more advanced features
such as
* ExpertInfo,
* Preferences,
* Reassembly,
* lots of Generated items (things that are not part of the packet
itself but still useful to show when wireshark deducts it),
* state tracking such as keeping track on Request and Response
matching and response times.
etc etc etc.

This makes the dissectors more daunting to look at since there are so
many different concepts there ontop of just "show what the bits and
bytes mean" but at the same time they show these extra things that we
usually have in a good/popular/mature dissector.


But at the end of the day, for every protocol, what makes a good
dissector is what an experienced engineer would need to do his/her
job.
I think that means that it takes a lot of subject-matter-expert
knowledge to know what is useful and what is not and here you probably
have as good or probably better input on what the dissection features should be.

Hypothetical example: say if wireshark had a feature where it would
reassemble objects and store them under their hash somewhere
and it allowed you to right-click on a sha1 in the dissection pane and
then "export object as file". Would that be useful?
You would know if it would be useful for git developers and engineers.
I have no idea.

ronnie

>
> Excited,
> Jonathan
>
> [1] https://gitlab.com/wireshark/wireshark/-/raw/master/doc/README.developer
> [2] https://www.kernel.org/doc/html/v5.9/process/coding-style.html
> ___________________________________________________________________________
> Sent via:    Wireshark-dev mailing list <wireshark-dev@wireshark.org>
> Archives:    https://www.wireshark.org/lists/wireshark-dev
> Unsubscribe: https://www.wireshark.org/mailman/options/wireshark-dev
>              mailto:wireshark-dev-request@wireshark.org?subject=unsubscribe
