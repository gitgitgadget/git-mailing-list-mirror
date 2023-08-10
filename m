Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C899AC001B0
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 23:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjHJXPY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 19:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjHJXPX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 19:15:23 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5FB2694
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 16:15:23 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585fb08172bso18350337b3.2
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 16:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691709322; x=1692314122;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I+0xDUENOnQXatyomiK8dts8juzAoj0QqJ4INrzzCWQ=;
        b=3VT4VRSENBUYI7svdAEJ/3uTsJzzwkZZhYf8+V4gqIeTgRevKva8GwB5QlhbTUbAsf
         6rgcuBdgyjco2DSY0CJ3EmuNRHOTpsW4efPtlTzU/bXhREjnzeML7/WFLFzelLz4HfR7
         8zGj2LoiSNkjOgAvJ3XIVle8SBmJd7J6Y5jVBzIC0iKq6tTtLJ92W8q8YvIu4DUDgHqs
         BFwVy55xWkuNa7rzWM+EgT6VDMZsaXDRijQ2/Q5pVDGy2LclBsIFOW6FQJTEd5LSz/gB
         IyBl8j3vB/KrJoLVdMiNoZFGI9H2x0fUNE1Qe9GT6Usii/DGr0z5KpZMDnqm+AfYDocK
         t4Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691709322; x=1692314122;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+0xDUENOnQXatyomiK8dts8juzAoj0QqJ4INrzzCWQ=;
        b=fPNkqIdZMFejd3lWquzZmO23Dv58RS1LvcpfBjUs8KcX1nP9nEtwWnglV0W+YTRqne
         J7M4iZfGib3iN4MRZ0+/V6ZfFgGz2MpykpDj67hfgT+D8jwPTGJeHWg4HKm6s56yMmRa
         hlXD6XBwEhR7GQf4G/pQtldMUuF5S4mXoJld5F5MSSGrKDlaU6H8fr9eFeRXvmTiKmOi
         U+NGHB9GB//ClCXexsrraE+TjQtADzvTrY7jDjopmjXcY1jDjkbG7pn7OqPm7X20HMmX
         ET8sPHuplt2wZsgl9hBIfDxNLBDrFnDkA6oDGoFC74PpjyEwdlLRMVB8/H+LvSo5kyiP
         TQbQ==
X-Gm-Message-State: AOJu0Yx29s8apQsR1jGpVcog8IFfNCsQwAKpjZQmE8qknGgv+eFtvFuD
        Rn7xXyCJzyzriq6aWVbIjNcjN6+PKrk=
X-Google-Smtp-Source: AGHT+IEEA5rpOqBubJZj3ccpRrAwC5VuSLFgzIqOjLskwhQ7Tno9kpGM+W0t5WS/dx0BaSXCmk6az/6M0UE=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a25:d803:0:b0:d07:9d79:881c with SMTP id
 p3-20020a25d803000000b00d079d79881cmr1940ybg.11.1691709322373; Thu, 10 Aug
 2023 16:15:22 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:15:20 -0700
In-Reply-To: <1fd1f22d-e0db-04f3-7235-899b10909c7a@gmail.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
 <0bce4d4b0d5650edf477cbbcc9f4e467b7981426.1691211879.git.gitgitgadget@gmail.com>
 <kl6l8rama6yj.fsf@chooglen-macbookpro.roam.corp.google.com> <1fd1f22d-e0db-04f3-7235-899b10909c7a@gmail.com>
Message-ID: <owlyy1iifq0n.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 1/5] trailer: separate public from internal portion of trailer_iterator
From:   Linus Arver <linusa@google.com>
To:     phillip.wood@dunelm.org.uk, Glen Choo <chooglen@google.com>,
        Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> We have something similar in unpack_trees.h see 576de3d9560 
> (unpack_trees: start splitting internal fields from public API, 
> 2023-02-27). That adds an "internal" member to "sturct unpack_trees" of 
> type "struct unpack_trees_internal which seems to be a easier naming scheme.

Ack, I will use "internal" as the member name in the next reroll.

>>> +#define private __private_to_trailer_c__do_not_use
> [...]
> That #define is pretty ugly

Haha, indeed. But I think that's the point though (i.e., the degree of
ugliness matches the strength of our codebase's posture to discourage
its use by external users).

I will drop the #define in the next reroll though, so, I guess it's a
moot point anyway.

> Another common scheme is to have an opaque pointer to the private struct 
>   in the public struct (aka pimpl idiom). The merge machinery uses this 
> - see merge-recursive.h. (I'm working on something similar for the 
> sequencer so we can change the internals without having to re-compile 
> everything that includes "sequencer.h")

Very interesting! I look forward to seeing your work. :)

>> - Prefixing private members with "__" (khash.h and other header-only
>>    libraries use this at least, not sure if we have this in the 'main
>>    tree'). I think this works pretty well most of the time.
>
> It is common but I think the C standard reserves names beginning with "__"

Indeed (see [1]).

[1] https://devblogs.microsoft.com/oldnewthing/20230109-00/?p=107685
