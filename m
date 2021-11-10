Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 410A0C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 08:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEC261052
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 08:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhKJIOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 03:14:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhKJIOL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 03:14:11 -0500
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9E7C061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 00:11:24 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id b3so3152554uam.1
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 00:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VPZF4nLJyUfKzEXvVzrPQ/oM1CpI8Q0VUUq9GSPUiMg=;
        b=BIvgFFq83FEkf05ss8Z0Kk/zQd1PF/8sjqY/d2BN/0FwHHqrP9G26+Yoc04zOl1Vic
         spuDLi+2j0Pf1QGowieIYwCkKMz4g3EAgR4AEvFhk0EZ96r0l8p7aI6mX3ybrUFsDdlk
         b5fIy6bCOMZQRf6mb5O7C2st3MFxsKdg223arjMgUPXMah3dHFoblRS33EDwCTjijISI
         yI7vEiJfMgE00up9FUlmGRvvkC2elamLRNVa4KH/M6T3+DCBWDA8kaABeqBxMLtKVqBi
         jErIfWUYSi+m7F9yldknITMAQdPPT+hMp78vcUfyAZAbpt87BUFnXbM+7BTV2AOriTZ6
         Iqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VPZF4nLJyUfKzEXvVzrPQ/oM1CpI8Q0VUUq9GSPUiMg=;
        b=VDyufNDyyHHlgcpIzcq34+tXo4nNwpsE0PWWgLaj2Q5ydeHUDQDbT8M9NSrTyvMbKu
         u9go65d/JVvV7iTrTi+MByrFWQK+t0PAaq8xWlTWAjOiRJ4aEm1ONCgFcUV4XZR+5e+Q
         2XK3nkvsD2/KRpzde7rKDeJu3lsobnoKc4epGbkYqxjNdSOS1FhsJ0HCi36OPpNEK/I4
         YPR5IRR5DmG3d1PPCv+cxNCs4PGewTiwi/jGUY3XLvmG2HF+TK6zuNUvRZ2V6GYxKoBb
         Af+9GenCWTdEy5a9+jlZ3n9+2REqbBWKqfEX+p4OQinHDpP5Q4vaymyI0OTzV5DRvqCw
         y4lA==
X-Gm-Message-State: AOAM532UWv6i22V7qHe/mAEkPSzihibG6oYlrFnLc2erbMh3eqI3BzIh
        ZNNZqz5xwIs3rBtgFsXZAFNKTtjtTB4S9gNQjUk=
X-Google-Smtp-Source: ABdhPJz9UMk4l0Q4+72F8AHFXJiYTPojvBkfKXTEGaiHdj6xz+A3JCcX6etnu5RxKrARkXXhQ84ROOckxB8a5VgQAGw=
X-Received: by 2002:a05:6102:3f50:: with SMTP id l16mr22808071vsv.57.1636531883475;
 Wed, 10 Nov 2021 00:11:23 -0800 (PST)
MIME-Version: 1.0
References: <xmqq4k8kzuz2.fsf@gitster.g> <YYtbdkLsCSFFE5io@coredump.intra.peff.net>
 <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
In-Reply-To: <YYtgD8VT/0vuIHRX@coredump.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Wed, 10 Nov 2021 00:11:12 -0800
Message-ID: <CAPUEspg+NDJFAVcFs2hhcSTORb0Q-Gjcv0M+5tzqXJuBTvbT+Q@mail.gmail.com>
Subject: Re: [ANNOUNCE] Git v2.34.0-rc2
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Fabian Stelzer <fs@gigacodes.de>, git@vger.kernel.org,
        git-packagers@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 9, 2021 at 10:02 PM Jeff King <peff@peff.net> wrote:

>   - we're not really testing the desired behavior, just looking for a
>     known-problem. The segfault may get fixed but we'd still have other
>     bugs.

This openssh bug was fixed in 8.8 per the release notes; indeed the
fix[1] (which was misapplied but fixed next commit) looks familiar and
it is just a straight up crasher, hence unlikely to cause other
issues.

Agree with you though that with both git and openssh getting changes
released for this feature there is a probability that there might be
misbehaving combinations that are not appropriately tested, but your
patch is a good step in the right direction.

Carlo

[1] https://cvsweb.openbsd.org/cgi-bin/cvsweb/src/usr.bin/ssh/ssh-keygen.c.diff?r1=1.435&r2=1.436&f=h
