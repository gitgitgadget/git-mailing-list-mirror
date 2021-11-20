Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CDBC433FE
	for <git@archiver.kernel.org>; Sat, 20 Nov 2021 22:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhKTWXc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Nov 2021 17:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbhKTWXc (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Nov 2021 17:23:32 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DD3C061574
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:20:28 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id r11so58661684edd.9
        for <git@vger.kernel.org>; Sat, 20 Nov 2021 14:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Li7tqr/dMuKyGZ1U/hoFKtuS3c/PdbLKbwDkC18cflg=;
        b=dxW+RzLfs3Nukf+JlaAP10Gzo6D5ayhDo/sS+sSFyh3VqGVDLOd/wzLWHypzWBjHFn
         tJWXjojR+jxkdqzBoxFNIDFyiAoQFMJZXCCsgzcefwig6JVJUGLrgJ6PGrbUWDjqEm8w
         ZUh9Yf+r1Eoy6r5IccrbB8r0la2UZ4S+VPlo9nFgjn8dj4rFIs+ZPWPptbWADjuZHzQW
         x7rYgBLYsnYTm60GHoQQnmZ3+y9kusTCQJVrSaOS/de3TxFTODvdV4HJTSB6ub/37+U9
         qpnKHmeOcgqyLxsj0XbNvoGtJiUvQDZEmCo2+7bl7oyhF7dof58hvJre1lSUUiu9yQem
         9Ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Li7tqr/dMuKyGZ1U/hoFKtuS3c/PdbLKbwDkC18cflg=;
        b=14RIxuJSKVqiY97O4UMVQ8A6SNbYPH2Lipgfy/7EcPaPQ7AO6TPWv1NvJo8kq1knVA
         w4k9Rudv0GynWZmGlsulBCcfWpxuREFt1hgKp/Hl5Pkcijl586L1PdEaUXlnnySqh/mQ
         SmqK81GQtj4h2gOydTVI8qA12AXKKeahbgwXGkKRdYP+wWrN164jRGgKrLO+z4QxabjS
         QQSVWlW6FeWz2mnCLlO6MEBbfIaCwFWjkMqnMGfF9/ugGeA0UkpsjTc4t4ZvLwoJv8GU
         PhzhJbzVPhWZf0Q8Fn+E2XtH/5tyYnINJCDKZ79N3MBhXygRLuzYhVo4HeLRryR9aJXC
         MXLA==
X-Gm-Message-State: AOAM533PiPknl9rS0LHEi2H3VZZcmaONgpts2rIxwVr/g5v5KK+Bhsr5
        IsVTgn8CxmRJpHjtmY/tHQbyR3fT1U1aMIvaE5Y=
X-Google-Smtp-Source: ABdhPJySBpiSMqlEEDTsES611XsV5UZBswKz4iME89V0vIOptalJmWNrBqct2Mwg3t8n3X5kVflihXfEVpn/92GpwVw=
X-Received: by 2002:a17:906:a08c:: with SMTP id q12mr23542593ejy.443.1637446826755;
 Sat, 20 Nov 2021 14:20:26 -0800 (PST)
MIME-Version: 1.0
References: <xmqqa6hznvz1.fsf@gitster.g>
In-Reply-To: <xmqqa6hznvz1.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 20 Nov 2021 14:20:15 -0800
Message-ID: <CABPp-BEM4OoAG+WvAyaWyF21a6FOUy=wb=1mt8OVFb_eGEmCLw@mail.gmail.com>
Subject: vd/sparse-reset (Was: Re: What's cooking in git.git (Nov 2021, #05;
 Fri, 19))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, Nov 19, 2021 at 11:53 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> * vd/sparse-reset (2021-10-27) 8 commits
>  - unpack-trees: improve performance of next_cache_entry
>  - reset: make --mixed sparse-aware
>  - reset: make sparse-aware (except --mixed)
>  - reset: integrate with sparse index
>  - reset: expand test coverage for sparse checkouts
>  - sparse-index: update command for expand/collapse test
>  - reset: preserve skip-worktree bit in mixed reset
>  - reset: rename is_missing to !is_in_reset_tree
>  (this branch is used by ds/fetch-pull-with-sparse-index and ld/sparse-diff-blame.)
>
>  Various operating modes of "git reset" have been made to work
>  better with the sparse index.
>
>  Will merge to 'next'?

The series looks very good, and is quite close to ready and maybe
close enough...but I did spot a tiny commit message issue and had two
questions on patch 7.  (Sadly, I ineptly put one of those questions as
a response to v3[1], while the other question was correctly a response
to v5[2].)

Again, my apologies for the late review and not being around to look earlier.

[1] https://lore.kernel.org/git/CABPp-BEcWutcLJWJvO-DC5B59EO4focgCJG1OWYg080j8ti44Q@mail.gmail.com/
[2] https://lore.kernel.org/git/CABPp-BH9qXZObVkEyuLOzoOvw_uPfC_n9QSR=by2+-GVgAGgSw@mail.gmail.com/
