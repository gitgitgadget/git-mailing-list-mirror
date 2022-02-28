Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6F0C433F5
	for <git@archiver.kernel.org>; Mon, 28 Feb 2022 12:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiB1MDW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 07:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiB1MDV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 07:03:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45C563F4
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 04:02:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id u2so2947480ple.10
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 04:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coup.net.nz; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9NQcHfgqpQ/GCqWGGIItxmUIepKnBvVG/uRL+Eae/hw=;
        b=aHWr03DIGYwNUCAC74ofFmNNU30E47FO0+AjP8MgwXxsP8knoyvMU499AY6dgqWxG5
         MH1qvRuFqTT9Ds0hTigenXeN00Qn3rBldhA5G2Ih7bDbLjxC99qgcYjS800CeGPBvh+k
         vF6b15T0WPbFzmLMF8BB9aMfpr+77R2Kifa/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9NQcHfgqpQ/GCqWGGIItxmUIepKnBvVG/uRL+Eae/hw=;
        b=diYGsLQuiEHYWvz9b7p6EZM0gFB/I+lwzS9FsFTWRSuXGjEZVdubAAMwNJUN+QgVu7
         tWAyQdLn1DbTY4eCd/qWtgBuHiunUy08vtLdEd+PY71iRLViotKUvUbGDXbmnHDqK1P9
         FPUwh89LMyEr9p5JIHBnuVoX/rBnHyZ7D/skRMFbMpkHGBUExFtaESqSo2mPrjOKj3Z0
         IHu+EA1rWltkHHXJtn9uFJUSqD60xNaexdwP+U8+V1qbmbVbRs14xVCUw/nnJWHYOpve
         VyoBeHAZtJoHHYDBjcn+OaScMNKRNeWB7IpUIiYY02avC85La24bZTvBE97c9tv9RWdK
         JpsA==
X-Gm-Message-State: AOAM530ME2rlIPvNwLsTxvdnBZX7NZxOmpFzJG2OPNdybh71ibJT8M5a
        WTUHrIHaJOjcCwzoYvtvOQFyhI5cUCYS4bKH6SlZXg==
X-Google-Smtp-Source: ABdhPJxTEgfXo5oClv5z/MY6s3C6sDJIZt1NhfQ40gqDIGDLKNfQmDNss6AJWUznAHnU+icIDQiCeEFBsjFj0DYtT04=
X-Received: by 2002:a17:902:dac3:b0:14f:e959:c272 with SMTP id
 q3-20020a170902dac300b0014fe959c272mr20619624plx.76.1646049762149; Mon, 28
 Feb 2022 04:02:42 -0800 (PST)
MIME-Version: 1.0
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
 <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com> <cfa6dca8ef4a64b6233e3b7b6021571447fc5ba9.1645719218.git.gitgitgadget@gmail.com>
 <xmqqsfs7fn6v.fsf@gitster.g>
In-Reply-To: <xmqqsfs7fn6v.fsf@gitster.g>
From:   Robert Coup <robert@coup.net.nz>
Date:   Mon, 28 Feb 2022 12:02:31 +0000
Message-ID: <CACf-nVeh9p1ba+tPSFQvqDBq3SaNtnhCQMibd__EED0w0Btozg@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] maintenance: add ability to pass config options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Coup via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 25 Feb 2022 at 06:57, Junio C Hamano <gitster@pobox.com> wrote:
>
> Style.  SP on both sides of '<'.

Thanks

> It is unclear if it is generally a good idea to pass hardcoded set
> of configuration variables to begin with, but provided if it makes
> sense [*], the implementation seems OK.

My RFC didn't do any repacking, and you (rightly) raised it at
https://lore.kernel.org/git/xmqqk0eecpl9.fsf@gitster.g/

>> To note:
>>
>>  1. This will produce duplicated objects between the existing and newly
>>     fetched packs, but gc will clean them up.
>
> ... it is not smart enough to stell them to exclude what we _ought_
> to have by telling them what the _old_ filter spec was.  That's OK
> for a starting point, I guess.  Hopefully, at the end of this
> operation, we should garbage collect the duplicated objects by
> default (with an option to turn it off)?

This was my best stab at (I think) safely doing it =E2=80=94 it respects us=
ers
who have disabled auto-gc/repacking/maintenance, and doesn't add yet
another config variable. But we could also:

1. do nothing =E2=80=94 the user's object DB will contain duplicate objects
until some repacking happens. This could be up to twice the size it
"should" be.
2. print a message to suggest running `git gc` / `git maintenance`

I'm keen on some input from Derrick or someone deeply familiar with
the maintenance/GC bits (particularly wrt incremental repacking)
whether what I'm doing would cause issues for people with complex
setups I haven't thought of.

>         Side note.  And this is a big *IF*, as we can see in all
>         other helper functions in run-commands.h, nobody has such a
>         privision.  If supporting such a "feature" makes sense, we
>         probably would need to do so with a common interface that
>         can be used across run_command() API, not with an ad-hoc
>         interface that is only usable with run_auto_maintenance(),
>         which may look somewhat similar to how we have a common way
>         to pass set of environment variables.

=C3=86var pointed out GIT_CONFIG_PARAMETERS has an API to wrap it's use, so
I can adapt the implementation to use that.

Thanks

Rob :)
