Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A93200B9
	for <e@80x24.org>; Thu,  3 May 2018 21:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeECVNA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 17:13:00 -0400
Received: from mail-yb0-f171.google.com ([209.85.213.171]:42114 "EHLO
        mail-yb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeECVM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 17:12:57 -0400
Received: by mail-yb0-f171.google.com with SMTP id 140-v6so7005807ybc.9
        for <git@vger.kernel.org>; Thu, 03 May 2018 14:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tnQwBXUlWf/z04Yv82IX0HkepIXlQI82tNLYhKrNS9U=;
        b=Ogt+Ko3HM+oO6iS85IrpvGpnrtgL2RbWqyPpaCMKwYybKP3evalxDnfDjsU5nGe7+v
         MC8GkL5b1g8Ufy5OFINOAqqYU0/kZnbYIqWRo0r/aWyayf1bnmqCWckRJAS3VI4TUKf9
         EtcgzD9dgOzB7790m0Y1z35IN8GAzcPKIPaHJ1gd6TlI7O8pXGRHJEMEzlKunneq7uY8
         G1yU9HS65fJ37b6mW7Yn73Tpz/XDJzHHjQ8xAijcSmbrBvEz2fM4E3xnwhbGRTtU6pLL
         L4sMKwbTLHjIHiR3xqIq80ZIOKukDsjNVDS3Jq2OVJWUaQTfpz27Dj7ATqoRj369eTLD
         4kEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tnQwBXUlWf/z04Yv82IX0HkepIXlQI82tNLYhKrNS9U=;
        b=II1j5KydwB2c1yTTapgh4qZttgCNFvtiw6dZOjodxCIgxExVtqQfXvWb97A7jFwveH
         rA96eZLddb0hPDjjCQnSrv/0j1dVBfmprwnCYTu2xUQ7EcqZJJlEUNsUIMtDmNLg/2nW
         bzGIUH8ti6Jprid0R4fYTngk+SaUjPuKf0l+8Ao7vXAYR0RSpMP13LdPqRhOq0Q6dn7X
         K+qE6dQpoIe2ZVcmDcWfvuJrVspYU0keBjZKXttAry8zNaG7h6MhMwUnCbEGsHQ1q+xx
         F3qfQOx7t/POk/VRI9cmfaFLvv2V4cElG2mJCr4RH8x8DsQDO3el0RWrpm9xusp5Nhfr
         z4Qg==
X-Gm-Message-State: ALQs6tC+FoJ7BYB/M35acxm7wl+NjT+AaWUk9q8jSHixCCAHNAsrmODz
        Kz7Yz+wkkVvBqKvq5w9Kxn15//AUwjVDpOERQTLckg==
X-Google-Smtp-Source: AB8JxZoqMbi7EpdHjGpSaLQUkmauTGD4w9EKKe3KDFcjehmeB+UOBpTR3psjGHEKMxgJQxgCmDV/THcRmwvhvkK3hs8=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr15624545ybn.167.1525381976311;
 Thu, 03 May 2018 14:12:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Thu, 3 May 2018 14:12:55 -0700 (PDT)
In-Reply-To: <nycvar.QRO.7.76.6.1805032227520.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de>
 <CAGZ79kZAidPafdfu1NGwwpVo1Vy=vKOV+EREE2=-ct_sbo7Gkg@mail.gmail.com> <nycvar.QRO.7.76.6.1805032227520.77@tvgsbejvaqbjf.bet>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 3 May 2018 14:12:55 -0700
Message-ID: <CAGZ79ka7RJq=tNnBsLs6wwL7Cf3hSJODM2iLW5tet-csAM20eg@mail.gmail.com>
Subject: Re: [PATCH 02/18] Add a new builtin: branch-diff
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 3, 2018 at 1:42 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

>> Speaking of colors, for origin/sb/blame-color Junio hinted at re-using
>> cyan for "uninteresting" parts to deliver a consistent color scheme for
>> Git. Eventually he dreams of having 2 layers of indirection IIUC, with
>>     "uninteresting" -> cyan
>>     "repeated lines in blame" -> uninteresting
>>
>> Maybe we can fit the coloring of this tool in this scheme, too?
>
> Sure. So you mean I should use cyan for... what part of the colored
> output? ;-)
>

It is just a FYI heads up, not an actionable bikeshed painting plan. ;)

>> Do we need to dynamic of a floating point, or would a rather small range
>> suffice here? (Also see rename detection settings, that take percents as
>> integers)
>
> I guess you are right, and we do not need floats. It was just very, very
> convenient to do that instead of using integers because
>
> - I already had the Jonker-Volgenant implementation "lying around" from my
>   previous life as an image processing expert, using doubles (but it was
>   in Java, not in C, so I quickly converted it for branch-diff).
>
> - I was actually not paying attention whether divisions are a thing in the
>   algorithm. From a cursory glance, it would appear that we are never
>   dividing in hungarian.c, so theoretically integers should be fine.
>
> - using doubles neatly side-steps the overflow problem. If I use integers
>   instead, I always will have to worry what to do if, say, adding
>   `INT_MAX` to `INT_MAX`.
>
> I am particularly worried about that last thing: it could easily lead to
> incorrect results if we blindly, say, pretend that `INT_MAX + INT_MAX ==
> INT_MAX` for the purpose of avoiding overflows.
>
> If, however, I misunderstood and you are only concerned about using
> *double-precision* floating point numbers, and would suggest using `float`
> typed variables instead, that would be totally cool with me.

So by being worried about INT_MAX occurring, you are implying that
we have to worry about a large range of values, so maybe floating points
are the best choice here.

Looking through that algorithm the costs seem to be integers only
measuring number of lines, so I would not be too worried about running
into INT_MAX problems except for the costs that are assigned INT_MAX
explicitly.

I was more asking, if floating point is the right tool for the job.

Stefan
