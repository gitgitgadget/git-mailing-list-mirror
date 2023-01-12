Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8451C46467
	for <git@archiver.kernel.org>; Thu, 12 Jan 2023 01:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236387AbjALByZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Jan 2023 20:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbjALByR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2023 20:54:17 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D53C43A02
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 17:54:15 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y25so26281441lfa.9
        for <git@vger.kernel.org>; Wed, 11 Jan 2023 17:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bs9nVl3pGLF7Kz4M/CrONlrkskuZKi+JU6Lsuv/ZOFM=;
        b=oxzOPF2Cl/HPM0CeENxhMj7/ZSfW6HuCixhmFcUHbVvAGZEbM6qrQzQopGGqG35yPN
         KxwK1YsEmOsD7kuaU/j1bzchkfJnnWmKHVs4zmmUzzyhsm093vrrXYsaiSUUi0xBHK2J
         FCLOHG2Zi8Eo/cN9XaB7rzLGt+sZZ94B40FhVEjPg3Mr5iuzPbTudX+FY7HVbHU7LUSy
         0TjbM9WPYzzhsDcDNw6sJQm34i7hxl6r7nmI9AdC/6zQIO8rew7McYE25F90RCLpq1AV
         7ZKAqSNW5v837P8pckU4P4wtrTnjhexTdLzqFH8Hp+lCKiUM04/fKgR3+HtlF/mpCtyd
         SCDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bs9nVl3pGLF7Kz4M/CrONlrkskuZKi+JU6Lsuv/ZOFM=;
        b=rXG/L39Jyhe+Tf57XPr3yf8KVjVqpn++YPGZD2W3pLnM7EWHy5YnDYjCsEo/bgBh+S
         G9atInKf/g8onBEV0y/ZwxgCbOV2mFOlzqLST3GB/uV3KmuPsGua0Rq4SBnjtvrE5XKW
         2cAScE8RZM9wPU9LL7Yh8hQON2vx+m+a1agLHK5rtKA70Z7Qe4dUCv7wEdhmFODjjRyo
         F2a9RhhBzRGHV0t4De5pB452AYxWjb2zV29wxKALlEfZ17CQFZIsSQCZdNnZ3yhkIzBf
         VuQVVBRcyDko8C+26yW2wZZD9RF6TjOIZhTSaSSKOhCUYu0PMToAAOinzrtq7JXWEo75
         LHXA==
X-Gm-Message-State: AFqh2kryO/lq+IWlEUAdfxpFuEKpHWBvEudzeh9TJBVV7AJmfAIpHu+2
        YODt3JINKdnI70vR9UU/+yBA0sQ+ySLfVQPCRF5/1f8/uA4=
X-Google-Smtp-Source: AMrXdXsZ7x8iZat/FHGPURs8D74v+sa+SXy7cJw2kp/XsVrlLnWl4TQW8WT+x1OMWtexCxkVvgAV1PTu9mnzrZnDj3Q=
X-Received: by 2002:a05:6512:368c:b0:4cb:d46:94b7 with SMTP id
 d12-20020a056512368c00b004cb0d4694b7mr2364996lfs.405.1673488453568; Wed, 11
 Jan 2023 17:54:13 -0800 (PST)
MIME-Version: 1.0
References: <20230111233242.16870-1-rybak.a.v@gmail.com>
In-Reply-To: <20230111233242.16870-1-rybak.a.v@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 11 Jan 2023 17:54:01 -0800
Message-ID: <CABPp-BFxK7SGs3wsOfozSw_Uvr-ynr+x8ciPV2Rmfx6Nr4si6g@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] fixes for commented out code in tests (was "Re:
 [PATCH] *: fix typos which duplicate a word")
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Tim Schumacher <timschumi@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Robin Rosenberg <robin.rosenberg@dewire.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2023 at 4:05 PM Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
> [ I apologize for some people getting this twice -- I messed up when
>   invoking `git send-email` ]
>
> On 2023-01-06T19:25, Eric Sunshine wrote:
> > Not related to your patch at all, but I notice in this test that the
> > call to test_when_finished() is commented out:
> >
> >     # test_when_finished "stop_daemon_delete_repo test_insensitive" &&
> >
> > which makes me wonder if it was commented out while the test was being
> > debugged but then forgotten, and that the script is now potentially
> > leaking a running daemon if something in the test fails after the
> > daemon was started, or if the daemon does not shut down on its own as
> > it's supposed to do. [cc:+Jeff Hostetler]
>
> Here's a patch series that fixes some of the commented out test code.

Patch 2 is obviously correct.  Patches 1 & 3 make sense to me, but it
would be nice to have someone familiar with fsmonitor look at #3.

As to your notes about other related testcases...

> I skipped changing the following:
[...]
> 2. In t6426-merge-skip-unneeded-updates.sh, second part of the test '2c: Modify
>    b & add c VS rename b->c' is commented out with an explicit "# FIXME:
>    rename/add conflicts are horribly broken right now;" above the commented out
>    part.
>    [ cc Elijah Newren, author of c04ba51739 (t6046: testcases checking whether
>    updates can be skipped in a merge, 2018-04-19) ]
[...]

You missed the cc...but I looked up this email since you did cc me for
patch 2/3.

Yeah, the commented out code was never tested, because the only thing
I could have tested at the time was incorrect results.  So I just took
a guess at what the improved testing would look like and apparently
made 3 small errors in doing so.  I have fixed it locally and can
submit a patch.
