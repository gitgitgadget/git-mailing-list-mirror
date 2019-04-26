Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480881F453
	for <e@80x24.org>; Fri, 26 Apr 2019 11:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfDZLk2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Apr 2019 07:40:28 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:46453 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfDZLk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Apr 2019 07:40:28 -0400
Received: by mail-vk1-f193.google.com with SMTP id x2so676570vkx.13
        for <git@vger.kernel.org>; Fri, 26 Apr 2019 04:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/TFmJXzV2ttiGwz8k3nM8LzuiwLL035u9WuBqqHUWmI=;
        b=a9KeHRznNzmqfE89pK2N8JqNn7GF7Mu02n8dezNrone+bByjm9geEKC/9cyungh0IO
         Fg4XQVsmszleD06awU62oNJEJ/dZHFn4PtlqhjeL7Cs5hQZZT4Wc+x/PjH092cza81X/
         1LPjvNNPzmOp8WcV8FohNIzv7cf545rnV3RWwvQyAFfEMa4blfFC1hprDXkzgLtKc/Xi
         pE34KjcFv4xblZR5j6FOOMSkA0pHIDM/F+GdA49g+7Bxfy+SPJpbiXOGwcIDGvGXMQWf
         VhuQqtIKSRgQtzxEqYNstlJ4jOYwnLENVhFk6qecLUbZTPF1XSH1SzfVKEOiKgoawxO1
         J5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/TFmJXzV2ttiGwz8k3nM8LzuiwLL035u9WuBqqHUWmI=;
        b=TjhNY+bSKtCKyu6Yq1MeestS4daKGZiDw8jchkQq1vEM1FF59jBktTG89sAy5jPi9U
         Fa1x/tnzQKj9iwf5kdhP7abRRDqw4WXo/4H2XmkSwxqnooGz4R1fOJS2gPrl29KLq8C8
         Xmx5DhW8IKSLm+75/T5UD592T31L/7im1pduVjIaDtqeE5uNTY++uYEzaUFjiRXodrWe
         GaPviCH3VYjkAhtLUJAk5PYz24XKdppwcAMYk6hD1/ytCKbz0GeyM3dHoKdx+vl7V6LL
         gt1zj+PRAGcYf8gbVmuVWujf2QDOuN6RMlSMlVN5jdhLWgAWhhCN5PukLJbUSqRcYtbW
         dw5Q==
X-Gm-Message-State: APjAAAUpAoK/lAv1JJhQiigM5VlhTOxDcSuws0WaQyP7NQazp7OfqVkD
        HyuH8XtLfhLqDLUTNb0RaH+72fj1BI6VCEr12ui5dg==
X-Google-Smtp-Source: APXvYqxaptrN9g7V+jHCBW8Oa7iQMDPghJaMfkYNn5ZYRK2qwHiqdEvYNap85SI3lKMgApZQH/F6oTtXhKpYFYIVgRM=
X-Received: by 2002:a1f:32d2:: with SMTP id y201mr334880vky.37.1556278827511;
 Fri, 26 Apr 2019 04:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190425155118.7918-1-newren@gmail.com> <20190425155118.7918-3-newren@gmail.com>
 <CAPig+cRaOAX+Yap+SiPjEoPRcH9z5qTHV6KPGGwN2LfPfxyA8Q@mail.gmail.com>
In-Reply-To: <CAPig+cRaOAX+Yap+SiPjEoPRcH9z5qTHV6KPGGwN2LfPfxyA8Q@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 26 Apr 2019 05:39:58 -0600
Message-ID: <CABPp-BHwyKJuRbYt65HXwLf-AxHRXOr1LMP0WbeSFc05sJVBVQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] fast-import: support 'encoding' commit header
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Thu, Apr 25, 2019 at 1:37 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>
> On Thu, Apr 25, 2019 at 11:51 AM Elijah Newren <newren@gmail.com> wrote:
> > Since git supports commit messages with an encoding other than utf-8,
> > allow fast-import to import such commits.  This may be useful for folks
> > who do not want to reencode commit messages from an external system, and
> > may also be useful to achieve reversible history rewrites (e.g. sha1sum
> > <-> sha256sum transitions or subtree work) with git repositories that
> > have used specialized encodings in their commit history.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > diff --git a/fast-import.c b/fast-import.c
> > @@ -2607,6 +2608,9 @@ static void parse_new_commit(const char *arg)
> >         if (!committer)
> >                 die("Expected committer but didn't get one");
> > +       if (skip_prefix(command_buf.buf, "encoding ", &encoding)) {
> > +               read_next_command();
> > +       }
>
> Style nit: unnecessary braces
>
> > @@ -2670,9 +2674,13 @@ static void parse_new_commit(const char *arg)
> >         strbuf_addf(&new_data,
> >                 "author %s\n"
> > -               "committer %s\n"
> > -               "\n",
> > +               "committer %s\n",
> >                 author ? author : committer, committer);
> > +       if (encoding)
> > +               strbuf_addf(&new_data,
> > +                       "encoding %s\n",
> > +                       encoding);
> > +       strbuf_addf(&new_data, "\n");
>
> Alternately:
>
>     strbuf_addch(&new_data, '\n');

Thanks for taking a look.  I'll fix both of these items you
highlighted and the test_config item you pointed out in 1/5 in the
next re-roll.

> > diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> > @@ -3299,4 +3299,24 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous thi
> > +test_expect_success 'X: handling encoding' '
> > +       test_tick &&
> > +       [...]
> > +       git cat-file -p encoding | grep $(printf "\360") &&
> > +       git log -1 --format=%B encoding | grep $(printf "\317\200")
>
> This script is already full of instances of Git commands upstream of
> pipes, so this usage is consistent (despite recent work to eliminate
> such situations). Okay.
