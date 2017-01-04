Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 995A820754
	for <e@80x24.org>; Wed,  4 Jan 2017 18:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031732AbdADSsD (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jan 2017 13:48:03 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34281 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965205AbdADSsB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2017 13:48:01 -0500
Received: by mail-qt0-f175.google.com with SMTP id d45so276679145qta.1
        for <git@vger.kernel.org>; Wed, 04 Jan 2017 10:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UQ5BV+jlk8rtmT+yLwSjtTPTOcmCZUU/zoxpw6PZJrE=;
        b=r1U2SQgNPr1bsLu1MBaL483yhZvA9bENvnmGMAVx2JLDRBBL1/jNOelcNlCgEE6olh
         j61kv8PNhdg0p+DZtQ89BsPDTXPOOHCDTuFyTGgguwXAdDJU1EmlFETidA+a6Rg+vSVY
         qrQ32FSB0XxNOHQl2pZ9XcMFM09AWC52OFoh1cM8yAZpQT9jPSHSEEqi/MR+YJ3Pc2ST
         ErWiqmOnfAwIgtop7kurPsDLPRb8Aunu3Zo1uxMfaofsFNmg25TPENIzxFLz0NoJVHOe
         31B/QgGpQVrauWZ9cnUStV+7y7hMukQqSs43Zof6wdL/tMbDR/NBjVgcDZl4A7gdXfb5
         clTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UQ5BV+jlk8rtmT+yLwSjtTPTOcmCZUU/zoxpw6PZJrE=;
        b=A7MiWeOch368zog48dB9W6m0pIJpA6/BcVM7GasF9vx05HsN0JSLf0cm43HsZOBE2b
         PvNVWAL++SNr9/cxzzhN4yOXpIXuMU6BVJcbNr62YwGEpW0hlj44voXTJNqRb51jO63w
         5KY0gLXVpzeBybO8YmXY3Rc7SKy8qMJh+/gs7y66XmTNGO9J4taDVPw94Aka1bjvR+PH
         oERYUj/IWCfLmXcnNUSmrd5doE6vfVcNjh48D91KII3bHpsXtLzo/tJ31p1A6JWjK/w5
         h7rkaOsMVjerkLGbjfQ6ziI2GwaujmBa5Shrg+jD+e+Ze8m+5QrsBFxDUthbKsAvUAvU
         Xc3A==
X-Gm-Message-State: AIkVDXJyRJr8M382FjBZM6NG9K5LKg12l+uZtB1AYVEEILfTqXcNNcFf/8xVQ1Lv7PTj2qjdLAkbbf+iaVRjpcBg
X-Received: by 10.200.58.65 with SMTP id w59mr60954703qte.54.1483555588358;
 Wed, 04 Jan 2017 10:46:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.146.7 with HTTP; Wed, 4 Jan 2017 10:46:27 -0800 (PST)
In-Reply-To: <20170104075506.sa5oa5bheykswkwn@sigill.intra.peff.net>
References: <20170104014835.22377-1-sbeller@google.com> <20170104014835.22377-3-sbeller@google.com>
 <20170104075506.sa5oa5bheykswkwn@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 4 Jan 2017 10:46:27 -0800
Message-ID: <CAGZ79kY3oVfn-xH4RQR9jMoKxoQUtF5HezY9HPUZGbx9KP-S5Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] pathspec: give better message for submodule related
 pathspec error
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 3, 2017 at 11:55 PM, Jeff King <peff@peff.net> wrote:
> But as this commit message needs to stand on its own, rather than as part of a
> larger discussion thread, it might be worth expanding "one of the cases"
> here. And talking about what's happening to the other cases.
>
> Like:
>
>   This assertion triggered for cases where there wasn't a programming
>   bug, but just bogus input. In particular, if the user asks for a
>   pathspec that is inside a submodule, we shouldn't assert() or
>   die("BUG"); we should tell the user their request is bogus.
>
>   We'll retain the assertion for non-submodule cases, though. We don't
>   know of any cases that would trigger this, but it _would_ be
>   indicative of a programming error, and we should catch it here.

makes sense.

>
> or something. Writing the first paragraph made me wonder if a better
> solution, though, would be to catch and complain about this case
> earlier. IOW, this _is_ a programming bug, because we're violating some
> assumption of the pathspec code. And whatever is putting that item into
> the pathspec list is what should be fixed.
>
> I haven't looked closely enough to have a real opinion on that, though.

Well I think you get different behavior with different flags enabled, i.e.
the test provided is a cornercase (as "git add ." in the submodule should
not yell at us IF PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE
were set, in my understanding of the code, so maybe the test rather adds
a ./file/with/characters inside the submodule directory)

I think a valid long term vision would be to have

    $ git -C submodule add file
    $ echo $?
    0

to behave the same as

    $ git add submodule/file
    advice/hint: adding file inside of a submodule
    $ echo $?
    0
    $ git -c submodule.iKnowWhatIDo add submodule/anotherfile
    $ echo $?
    0

Brandon, who is refactoring the pathspec stuff currently may have
an opinion if we could catch it earlier and still have beautiful code.

Thanks,
Stefan

> Given the discussion, this comment seems funny now. Who cares about
> "historically"? It should probably be something like:
>
>   /*
>    * This case can be triggered by the user pointing us to a pathspec
>    * inside a submodule, which is an input error. Detect that here
>    * and complain, but fallback in the non-submodule case to a BUG,
>    * as we have no idea what would trigger that.
>    */

Makes sense.

>
> -Peff
