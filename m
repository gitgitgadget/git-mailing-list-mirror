Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA7AC433DB
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 04:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D04C64D5D
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 04:51:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbhBMEvB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 23:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhBMEu7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 23:50:59 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2AA2C061574
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 20:50:19 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id k10so1252589otl.2
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 20:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5ZjSwnxr3+FwqFwvv6y40lu486dMuJTazwowTImCJU=;
        b=WIT3MAMNR3e+fAZdvGxneqL1RI3UiB3tymS1Z+g/kdvVKwVobE/MM8iUTKD2W7QrG6
         wAJV2xC1fV3d+13u0W+B0sjpXuBGCEDQYDi9vJG74xoQ9PX2V9gpOQIzJ+w1WnsiV2g1
         96FQn2D5aaJI9MVy5fKRiMC+yB7BG3xeD8gPWuOsefWl4d9KayFX7vYNagyOxLXuOwHE
         f1d1kCrH8783PaICabC0g/UyOvd50+GTVN88uJ3M6yrcptk33BoUlh1miZqLwCIj+LgH
         UfLrHR28pGDLLPwQgVcKd3U1MqTukb1ktWQq/jqr7LJONGFaEeTUT/03pRUlg5EPejRo
         QF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5ZjSwnxr3+FwqFwvv6y40lu486dMuJTazwowTImCJU=;
        b=iDuz0nlgzlmCDok/WJyDPA8BqXoH2fKnMcHGLwKcD+IrcnUORTgAY33Ru4qndiDxYk
         saCWk0Nz9NbQKU45Jt5JHmw8xb6ehlfi7I6E3HnKVapT8yKy+grzStrJ1fUy+5ttPQa4
         92WF82NDXZ+phdV5a8IvrYmamyXLVT/C4GdTaD51AoM/gkd4p4EM+2erwEOEdC5f3Mv+
         5wub3LFGTNp6g9tKbNGZZwolywZxbVu2MAZg91TvkY+05exJJsKq3FJc7TC4gVAskHEk
         VkA9xFG/0bg4gg6+oCbv4pV96MoORtBvs/feQplsacCeS+zWyjHKXURQ18j4qKz1XAe5
         uZNg==
X-Gm-Message-State: AOAM530VZlbdMtBJJCqAyt4rlLh/Fpj5tJ5YK0P2Yxh0I+aV/iACj12v
        DL/h01GnOabbRks/nWvYMZ+LNXgpIXnPAcmTyRY=
X-Google-Smtp-Source: ABdhPJyBl6z2Nvijpdow366GeCWQwj9Sh7remFapAnvTey4eCWv45s7gX3EUSBDjUNb+2G/ruv21/MIfUs47NiZz6+Q=
X-Received: by 2002:a05:6830:1e3b:: with SMTP id t27mr4480631otr.316.1613191818861;
 Fri, 12 Feb 2021 20:50:18 -0800 (PST)
MIME-Version: 1.0
References: <pull.843.v2.git.1612870326.gitgitgadget@gmail.com>
 <pull.843.v3.git.1612970140.gitgitgadget@gmail.com> <3e6af929d135ef2dc239e2f47f92a7e2e91cbd17.1612970140.git.gitgitgadget@gmail.com>
 <xmqq4kigvkct.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq4kigvkct.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 12 Feb 2021 20:50:07 -0800
Message-ID: <CABPp-BHyYOAw939vU20oA_tOSFRVm=EaLKuw+4M1oP1GDDV5cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] t4001: add a test comparing basename similarity
 and content similarity
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 12, 2021 at 5:15 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Elijah Newren <newren@gmail.com>
> >
> > Add a simple test where a removed file is similar to two different added
> > files; one of them has the same basename, and the other has a slightly
> > higher content similarity.  Without break detection, filename similarity
> > of 100% trumps content similarity for pairing up related files.  For
> > any filename similarity less than 100%, the opposite is true -- content
> > similarity is all that matters.  Add a testcase that documents this.
>
> I am not sure why it is the "opposite".  When contents are similar
> to the same degree of 100%, we tiebreak with the filename.  We never
> favor a pair between the same filename over a pair between different
> filenames with better content similarity.

This is not true.  If src/main.c is 99% similar to src/foo.c, and is
0% similar to the src/main.c in the new commit, we match the old
src/main.c to the new src/main.c despite being far more similar
src/foo.c.  Unless break detection is turned on, we do not allow
content similarity to trump (full) filename equality.

> And when contents are similar to the same degree of less than 100%,
> we do not favor a pair between the same filename over a pair between
> different filenames, as long as they are similar to the same degree.

This is also not true; we tiebreak with filenames for inexact renames
just like we do for exact renames (note that basename_same() is called
both from find_identical_files() and from the nested loop where
inexact rename detection is done).

> So, I do not think "opposite" is helping readers to understand what
> is going on.
>
> > +test_expect_success 'basename similarity vs best similarity' '
> > +     mkdir subdir &&
> > +     test_write_lines line1 line2 line3 line4 line5 \
> > +                      line6 line7 line8 line9 line10 >subdir/file.txt &&
> > +     git add subdir/file.txt &&
> > +     git commit -m "base txt" &&
> > +
> > +     git rm subdir/file.txt &&
> > +     test_write_lines line1 line2 line3 line4 line5 \
> > +                       line6 line7 line8 >file.txt &&
> > +     test_write_lines line1 line2 line3 line4 line5 \
> > +                       line6 line7 line8 line9 >file.md &&
> > +     git add file.txt file.md &&
> > +     git commit -a -m "rename" &&
> > +     git diff-tree -r -M --name-status HEAD^ HEAD >actual &&
> > +     # subdir/file.txt is 89% similar to file.md, 78% similar to file.txt,
> > +     # but since same basenames are checked first...
>
> I am not sure what the second line of this comment wants to imply
> with the ellipses here.  Care to finish the sentence?
>
> Or was the second line planned to be added when we start applying
> the "check only the same filename first and see if we find a
> better-than-reasonable match" heuristics but somehow survived
> "rebase -i" and ended up here?

Oops, indeed; that is precisely what happened.  Will fix.

> > +     cat >expected <<-\EOF &&
> > +     R088    subdir/file.txt file.md
> > +     A       file.txt
> > +     EOF
> > +     test_cmp expected actual
>
> Thanks.
