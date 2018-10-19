Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38D181F453
	for <e@80x24.org>; Fri, 19 Oct 2018 13:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJSWFR (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 18:05:17 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:38463 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727651AbeJSWFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 18:05:16 -0400
Received: by mail-ed1-f45.google.com with SMTP id c1-v6so31550355ede.5
        for <git@vger.kernel.org>; Fri, 19 Oct 2018 06:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ccgEu2h5crHbUUWxyRSzJM/9xjymQ7FKzMfjVX81qJM=;
        b=e8y1kqySayxXA6uDnWuE53KqEg8uZvHpg5Bvq3gKoqGSOv1ff/lXxyl4ItgcIkLze3
         rS6jpev1SOJuI8XkHtUrmBmMXgb8ccZQGJFv3NW1eYyjPC2CSJFllO8Q7qORbqiaaWO9
         JYjW0B0HbehDNU4oHEWRg9QDl6vkFVZ19G2O0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ccgEu2h5crHbUUWxyRSzJM/9xjymQ7FKzMfjVX81qJM=;
        b=pGBI6b79y7RDIfgqQ5jfC0HqlwqdSgZ5gu4T43I6B+ONntpSHFNxh+lgsI+dGoyc7d
         XuDZwA0x9sJynb5f2w+leHj8bRtvTxi7U9Nk0vepqlMn47UU7ZRFEm/YezsylyhvQH5z
         k+n3cHY+iwS/nvFW2xiDOvxuOL+CPBlLiBVVvIIK+05dLjThg3JkrbQkzDs73e+E10Co
         MuINiLjrI8xXsFzOkfTVHAZu4P4PrBPh8n4eFGjOZvyYYV01lyD+3ocsMJN7ksG7/ESB
         5TpOmDa+pC+VpXGHYspFC3k7FymitV57kLevymlGCZV4DLFXJEeERrGkmno8nQGXBpGX
         B0/Q==
X-Gm-Message-State: ABuFfohW4hBjk1FF9IcS0fuNYFmJc0Vwy5YzOVEY4kBuNLdUV539dM/6
        Tjsh36P7rOA6tiabyFunLNoDqturOrPaE6fsmZ31xg==
X-Google-Smtp-Source: ACcGV62wW4tyChrJfUjFSIlGzgxjcoxN4FnNLmPBI9K6FE1DcTNKRqvFQTanbVkdWOmhymaP0kHOr91LQ4IvSHhR5+k=
X-Received: by 2002:a17:906:704f:: with SMTP id r15-v6mr31273864ejj.131.1539957539900;
 Fri, 19 Oct 2018 06:58:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAGY-PBgsG-T3JY=awszwGMpFx+jDx-a1FcV0s6vR067bSqgZaA@mail.gmail.com>
 <20181017205340.190036-1-jonathantanmy@google.com>
In-Reply-To: <20181017205340.190036-1-jonathantanmy@google.com>
From:   Arturas Moskvinas <arturas@uber.com>
Date:   Fri, 19 Oct 2018 16:58:49 +0300
Message-ID: <CAGY-PBiKaKwhjyHCDF5Crq6z-D17WMW5iqUjfSNiQqaHcZP0dw@mail.gmail.com>
Subject: Re: Git wire protocol v2 fails fetching shallow changes with `pack
 has XXX unresolved deltas` on large repos with lots of tags Inbox x
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Unfortunately I do not have for such step. On one of our internal
repositories it is failing but unreliably when fetching from remote.

--
Arturas Moskvinas

On Wed, Oct 17, 2018 at 11:53 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> > No changes are needed in mirrored repository. Crash happens both with
> > 2.18.0 and 2.19.1 git versions. Having repository locally is not
> > required but reduces test runtime, you can quite reliably reproduce
> > issue when fetching over net directly from chromium.orgbypassing
> > mirroring step.
>
> Do you have the reproduction steps for this? If I run
>
>   git -c protocol.version=2 fetch --tags \
>     https://chromium.googlesource.com/chromium/src \
>     +refs/heads/*:refs/remotes/origin/* --depth=1
>
> repeatedly in the same repository, it succeeds. (And I've checked with
> GIT_TRACE_PACKET that it uses protocol v2.)
