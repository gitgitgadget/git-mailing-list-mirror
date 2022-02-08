Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDAAC46467
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiBHBsI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbiBHBnV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 20:43:21 -0500
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D168BC061355
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 17:43:20 -0800 (PST)
Received: by mail-oo1-xc36.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so5381297ooi.2
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 17:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zSy01yubTS2o8Q7vWu031K8rstskzVWtbAl+5y1hTgA=;
        b=LKSRxQ6vWQdLiqrOzNpsImW9cjJUqAecfR6qCFMYJI6a0qQOiwb/aXsQI8PcsIizUp
         g6MGoWu0F85zBcGbdm/mhClYxqEbWGiJ3q4JkOuzymwI/ivGmPp67FBfd1HljVB5Y3C1
         VG8J1eM7Msr9IekLFPoRamWm5lvScrBKuslKHpu/tBjnvdkzWjLloStRkmw4XQJEa7GL
         3nsROxumksx257naaAvTT8mOhSUacojOrrbydm993yqi7IuXOVLINyvZJ6B4/kRmkdWD
         YyYqFcgZjVmPowvQic8oJnTAm7Y6zu8o0678iVL2txVapN8gsx9GKEC17RN0H2KokooP
         pIEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zSy01yubTS2o8Q7vWu031K8rstskzVWtbAl+5y1hTgA=;
        b=xs+rLvMr5Wp26Htd5YU1bVh8a4o6K32iRP6k1HnEne8qeZPR5zw/EWrmUw4k06K776
         /Y1XpvEylG9wc0sWa8rvPQ7w5dDX3YrAywXpZ1ITrX/Zi1JiiqvEc8ctdC0qNA3WREL+
         4Wvgnknv3G0oywjEJrZhbiIX9e5MqnlXB2dUuvq6u/2mDbSzcAKN4v9om03LiFqCZPDE
         iIA7t3MniZunbQ5m4kz/5n9YwlUk4Mxd8LZXa6+xeQXxgPHkWhqSNgS/oqGSsY2vGJT0
         /CdshBQ2ZkgEB9Ll6C8UfItZQHTTkZUHsyyPfvXXAXROUQeDIPQlHWDbZYhf80HlUTFP
         IgRQ==
X-Gm-Message-State: AOAM531zu7sHNozatvRKELbmg1wUYDehBzG/JQDvMROKsK1bO7ktxjNL
        GQ+T1ZCLTYr0Lp//lHjiPQFuhMKNUSNahLM3e6vTmEYbLr7BGg==
X-Google-Smtp-Source: ABdhPJyt9df4T1qQEScYP8Yh0r3RHm/uzdsmhukVtBpoCqrqondhZgtksNp9PqTfSdiwrQKCXyVL18RdiJYykx4jft4=
X-Received: by 2002:a05:6870:d452:: with SMTP id j18mr607175oag.174.1644284600118;
 Mon, 07 Feb 2022 17:43:20 -0800 (PST)
MIME-Version: 1.0
References: <20220123060318.471414-1-shaoxuan.yuan02@gmail.com>
 <20220202064300.3601-1-shaoxuan.yuan02@gmail.com> <CAP8UFD2e6xEQa7045Mup8LAHBs=B9EwwvZcLMsp43OM-dsY9eQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2e6xEQa7045Mup8LAHBs=B9EwwvZcLMsp43OM-dsY9eQ@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Tue, 8 Feb 2022 09:43:08 +0800
Message-ID: <CAJyCBOQ2+KNpLZxEvZ010wYNKGa=k8p9UMUVpzj8K-oDitDdsg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] t/lib-read-tree-m-3way: modernize style
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Mon, Feb 7, 2022 at 7:42 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> On Fri, Feb 4, 2022 at 6:00 AM Shaoxuan Yuan <shaoxuan.yuan02@gmail.com> wrote:
> >
> > Many invocations of the test_expect_success command in this
> > file are written in old style where the command, an optional
> > prerequisite, and the test title are written on separate
> > lines, and the executable script string begins on its own
> > line, and these lines are pasted together with backslashes
> > as necessary.
>
> It's not very clear here if "these lines" means only the separate
> lines with the command, an optional prerequisite, and the test title,
> or if it also means the first (or maybe many) line(s) of the
> executable script string.

"these lines" here means every occurrence of the "the command, an optional
prerequisite, and the test title" and "the executable script string"
(four parts) put together.

> > An invocation of the test_expect_success command in modern
> > test scripts however writes the prerequisite and the title
> > on the same line as the test_expect_success command itself,
> > and ends the line with a single quote that begins the
> > executable script string.
>
> It could also be 'test_expect_failure' instead of 'test_expect_success'.

Agree, it should be put in a more general way, for example, "test functions
such as 'test_expect_success' and 'test_expect_failure' ", for accuracy.

> > Update the style for uniformity.
> >
> > Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
>
> >  for p in M? Z/M?
> >  do
> >      echo This is modified $p in the branch A. >$p
> > -    test_expect_success \
> > -       'change in branch A (modification)' \
> > -        "git update-index $p"
> > +    test_expect_success 'change in branch A (modification)' '
> > +        git update-index $p
> > +    '
>
> The above is not just about moving single quotes from one line to
> another, but it changes some double quotes to single quotes, which
> means that $p might not be interpreted in the same way. This is not
> just a style issue and it should be explained in the commit message
> why it's ok to make this change.

Yes, I learned the reason behind from Eric[1] and I also went through
t/test-lib.sh and t/test-lib-functions.sh to see it myself.
And the reason should be written in the commit message for a potential
explanation.

Overall, thanks for the review, and I will ship a v4 along with the
modifications.

[1]: https://lore.kernel.org/git/CAPig+cS5tOr2NRJmAC1BNQPKYyeLXy0iy36q35-y7rFkrWewJw@mail.gmail.com/

--
Thanks,
Shaoxuan
