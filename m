Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F87520248
	for <e@80x24.org>; Mon, 25 Feb 2019 21:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfBYVJa (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 16:09:30 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43457 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfBYVJa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 16:09:30 -0500
Received: by mail-qk1-f196.google.com with SMTP id f196so6257866qke.10
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 13:09:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2qt9isVerZ04+3gpBRdpMGOX+Oo33jEouKW0gBaJ48=;
        b=l84Q4nKzOjo9mE554IDg7TgZanvI5lKMrg/TYdGvFQ9Mtk6WRSpBXlZhMePK+By1+N
         G10kZ4EBlUPTSqrjyMUDX5knWjyEY9fqQ8md/cU7DpM3/KYgra70edj//MvDjDuR/Zwj
         8IfRheZpgycx4ct+7HB1+YY0E57ks0tRnFDqKyeaCqmgDuheTgX/4MKDd3JrIXtpql7W
         JTSvSHEC64dwQ+BGnSmrFyxa/Sac3gBjHHMIXS5vJIrE/IgBalXCVNfie7AqdVyAyNaD
         p4BmBLfKB8tn/nYT4pc67ssb71ygQfu5YJjaS0w0mv9GtXfWc5knBk5AcxIDV+SD6SL8
         Ma7w==
X-Gm-Message-State: AHQUAuYvz8aAyiiKt6il778Rc0kiRutJFD4a+ZZVN1SCQMMlenwH7Lo3
        /wSJ+vFYmbhmlZgUNldLKko0OUaO2+WdWD9pC9c=
X-Google-Smtp-Source: AHgI3IZZ/ItryC7ulDvv2E5ItLWaouCWciRgh5RijLeFgpEHltkKiamzMiLAqrzuidbZv4MShyELdT/EwOXUeUTIYos=
X-Received: by 2002:a37:7d86:: with SMTP id y128mr2020312qkc.36.1551128969318;
 Mon, 25 Feb 2019 13:09:29 -0800 (PST)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <CAP8UFD1U+4ww8rC=TSjjH+Rt77P9w4YWA9s5yspVZ7GgPpx0pw@mail.gmail.com>
 <CAL7ArXqrV7qb29i6JvQdeUtLNX9A7WC0-deKMx-_6pQUpaqSJA@mail.gmail.com> <CAP8UFD1wK+goi1rKGjABcs01VwYw2kEma95n08H1EWVT4vh6ng@mail.gmail.com>
In-Reply-To: <CAP8UFD1wK+goi1rKGjABcs01VwYw2kEma95n08H1EWVT4vh6ng@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Feb 2019 16:09:18 -0500
Message-ID: <CAPig+cSZZaCT0G3hysmjn_tNvZmYGp=5cXpZHkdphbWXnONSVQ@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        git <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 25, 2019 at 3:22 PM Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Feb 25, 2019 at 12:36 PM Rohit Ashiwal
> <rohit.ashiwal265@gmail.com> wrote:
> > I don't think I quite understood this. Were you asking for replacing
> > all `test -X` calls with `test_path_is_*` calls in only one tXXXX-*.sh
> > file or `test -d` calls with `test_path_is_dir` in all tXXXX-*.sh? As
> > of now, I've changed almost all `test -d` in all relevant tXXXX-*.sh
> > files.
>
> So yes I am asking for replacing all `test -X` calls with
> `test_path_is_*` calls in only one tXXXX-*.sh file.

Not stated outright, but an important reason for limiting the scope of
this change (and, indeed, the scope of any patch series) is to ease
the burden on people who review your submission. Large patch series
tend to tax reviewers heavily, even (and often) when repetitive and
simple, like replacing `test -d` with `test_path_is_dir()`. The
shorter and more concise a patch series is, the more likely that it
will receive quality reviews.

Another reason for keeping the scope of changes limited is to ease the
burden of the project maintainer. Patch series which touch a lot of
areas tend to conflict with in-flight topics from other people, and
the project maintainer has to juggle and resolve these problems.
Concise patch series, on the other hand, are less likely to conflict
with changes elsewhere.
