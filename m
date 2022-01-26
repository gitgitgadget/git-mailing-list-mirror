Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0F4C5DF62
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 00:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235427AbiAZAvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jan 2022 19:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiAZAvh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jan 2022 19:51:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5985EC06161C
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:51:37 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id p12so66404163edq.9
        for <git@vger.kernel.org>; Tue, 25 Jan 2022 16:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BAE5Eg5wvfYRwZbAYtvKAKk8AQiTKaRlO5WK4r4IHXA=;
        b=lx6yWfJ6S4IqVZHwTfcjN5imwUXd85GYSQTLEoj1OpxndWcnb++zOsLYqjy6+eWGVr
         XKyIlzBN7HNaY35UdePTUOE6qrp4v/cimYss2mVipPCIAVbNeVxguSXarJz3RI6Qs2bE
         LJgo8beHSAA49m27z3qzzoIOVR9T68/LMKgGs6iU0pqkiO+vv2u0Sc3FrXjYv4UmbSyL
         +vGMzpO5r/iVYV/reB6s7/XzENuHhN8NaazLx5eUKnqSBBIHSGCdS4CKzErXfJpbqY+G
         YTFdAQERfsa1RZcPVHGz4k9IOcuCqj0zRuaYoMjya2UEcR6hHm0x+/dd1u6Rr2M1dnpn
         InAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BAE5Eg5wvfYRwZbAYtvKAKk8AQiTKaRlO5WK4r4IHXA=;
        b=wasobojFVY2Zx8ngp7dBMD0O/ZhWrXrOMzmgHrTSrz7Rw2hYheGihi6LRehxAZbC46
         Yvk6qS5lMelv8Aj/QqddQ0exqnCmwfSsnt0QuqffZRK3fq/hY6XTaSjIMXYgMWH2TS/k
         xFJvpx8CRc31KLoJ6ZrUzbmOHVU9i3cIVZjZcx0Cf0lKlLHTEOq/l/6LIDovtBxXCRuz
         LJu0sEnRQlTe5rLvGSDAG+/0wMuvYxym1CYJhP8WvPpB0vQAIA8hzS39KIRU5vTZHQxW
         8OyqsD59wGiZWj0uKmisPwD0Ag/SqbYSmxKiHB6Qv1ERU33IOXmAh4WTJAdELj+Cxmsz
         lPMw==
X-Gm-Message-State: AOAM5320KJD/kNHI7b/v7hewDmGiWzt5M4ARK5JA0bSXj7ZiCHN33r4N
        koxhiNORyACVXg3771VKcOXGsA0JLj07aAXQFB0=
X-Google-Smtp-Source: ABdhPJw6O0aQ0viJUWqyDDJ4ja6a4KxuaKOSCn7O+es+aPt87kyH+O6+ww9u/8EPKDXd+X3Uyps0yK5iI/3o2qESYYo=
X-Received: by 2002:a05:6402:1d4a:: with SMTP id dz10mr22700943edb.206.1643158295940;
 Tue, 25 Jan 2022 16:51:35 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
 <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com> <f8efb7446c33f14631b088ac043aca8a403a3250.1638340854.git.gitgitgadget@gmail.com>
 <kl6lilu71rzl.fsf@chooglen-macbookpro.roam.corp.google.com>
 <CABPp-BFdD=f82QvQfokD346YT6aCQ=WwZ09S-a=BPXXj5_LZkg@mail.gmail.com>
 <CAPig+cT3Zqa2BLsZ3ZVPCj4-bW5eb35sWXV-mYLqA-dvzC8XJg@mail.gmail.com> <CAPig+cRCzUinKr0iQkDMK0Af4=47xKZJKphcuTRxt4BaxrYwfA@mail.gmail.com>
In-Reply-To: <CAPig+cRCzUinKr0iQkDMK0Af4=47xKZJKphcuTRxt4BaxrYwfA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 25 Jan 2022 16:51:24 -0800
Message-ID: <CABPp-BG2__OLFkOcJnH-V8SC3hrRRrB1zv+KEOiNfoQYB9Ehpw@mail.gmail.com>
Subject: Re: [Bug] Rebase from worktree subdir is broken (was Re: [PATCH v5
 07/11] rebase: do not attempt to remove startup_info->original_cwd)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Glen Choo <chooglen@google.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 25, 2022 at 4:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Tue, Jan 25, 2022 at 7:32 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > On Tue, Jan 25, 2022 at 6:59 PM Elijah Newren <newren@gmail.com> wrote:
> > > On Tue, Jan 25, 2022 at 12:27 PM Glen Choo <chooglen@google.com> wrote:
> > > > +test_expect_success 'rebase when inside worktree subdirectory' '
> > > > +       git init main-wt &&
> > > > +       (
> > > > +               cd main-wt &&
> > > > +               git commit --allow-empty -m "initial" &&
> > > > +               # create commit with foo/bar/baz
> > > > +               mkdir -p foo/bar &&
> > > > +               touch foo/bar/baz &&
> > > > +               git add foo/bar/baz &&
> > > > +               git commit -m "add foo/bar/baz" &&
> > > > +               # create commit with a/b/c
> > > > +               mkdir -p a/b &&
> > > > +               touch a/b/c &&
> > > > +               git add a/b/c &&
> > > > +               git commit -m "add a/b/c" &&
> >
> > This is entirely minor, but all the inner subshells in this test are
> > superfluous. [...]
>
> One other minor comment: If the file's timestamp has no significance
> to the test, then our style is to create the file with `>` rather than
> `touch`, so:
>
>     ... &&
>     >foo/bar/baz &&
>     ...
>     >a/b/c &&
>     ...

Ah, good point.  And while at it, we can replace the touch/add/commit
sequence with a simple test_commit call.
