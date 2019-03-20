Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE7F20248
	for <e@80x24.org>; Wed, 20 Mar 2019 09:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfCTJak (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 05:30:40 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43540 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfCTJak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 05:30:40 -0400
Received: by mail-io1-f67.google.com with SMTP id x3so1295199iol.10
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQM/POP3xJEGLnk5ZVzbpbsPOyl1KE43v82QlxKJ8Bo=;
        b=GCM+JlWyQf+LU6JASmjhJQPUvRngIcbEeuzWNfydNG+AU6x1o/Ck0ZvF1fKbr93FUQ
         VAO/SU0mapmaNnE9T3/y1Fcw22oOK8m1K+cHuOuu84RQlSa1fsLqF6DwsuOfZzi3dUU7
         oCCWaS+ekN/6WTsWgYxrdQhJQEG5XfWVt8Mxhna4sq2Ktau3CoL99YF2caMS9BvhhMWQ
         IyKRR//XLPjBBkJ3zkOOtmasNmZc00ntwJ93CLfs5y1hWqXnK0mpMhvrjXCmyIu4YVv5
         tAqoB9JCEq9wIyh5zmUWRpJ9R+aY/pq/sjUW3BTHDKKbBr/ZHdDCpo3jEoiMORxtuSfS
         yJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQM/POP3xJEGLnk5ZVzbpbsPOyl1KE43v82QlxKJ8Bo=;
        b=nhIF53XGmUr3CiWLzVV34+HjKJ+ynf0fKM9sTlBdOUnxYW2lYKodjlTbtLe54a/mpR
         xcAy5bfjOQfqPpTd/JziwEoq2GTYl3l3vu5zNNraON3IUxHJkq+LDLP2J3rbvyZWD07A
         t0J7Ad8LykKq1LMZhp0TYmhsl89SKTG7S28V5mfamnWXtTNi26EwD8Le4037NVh7eGE8
         ZeUC4m+M6d26EJ3yd2vinA6swCubuCpHtJFJGQElxHEZVOVFddJoYBz4PGYNmJp0qz+Y
         nTaVxOrS0jU6SOGFWluWHSxzg1Zx8NQX1XhInK/iN9br5jJ7Uo8pX3/jZikca8EspsCa
         OffA==
X-Gm-Message-State: APjAAAXqX3ShFctFBsdSeO/mD3IgFrGiXjPZ/grrW/yTW8/bZkEuthzG
        0IqsLjV6UiLuwmQtN/LB0AQTmp7yMWQW9ELuy4s=
X-Google-Smtp-Source: APXvYqwc+5qiDN1eRmWZ1KwbovhnxZxgkQdhsAAxdeQUQPOdQkOxHLDN4fCIJxd0tuTD9m8FU4R/EW7SjUNyEM3tLgc=
X-Received: by 2002:a5d:9446:: with SMTP id x6mr15002345ior.236.1553074239415;
 Wed, 20 Mar 2019 02:30:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190319190503.GA10066@dev-l> <20190319231826.GB32487@hank.intra.tgummerer.com>
 <20190320050449.GA6401@sigill.intra.peff.net>
In-Reply-To: <20190320050449.GA6401@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 20 Mar 2019 16:30:13 +0700
Message-ID: <CACsJy8BMdjR9cS4qDVaNXtW-U0cQt5e3au2y5PsW7eKQdd3xJA@mail.gmail.com>
Subject: Re: [REGRESSION ps/stash-in-c] git stash show -v
To:     Jeff King <peff@peff.net>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Matthew Kraai <mkraai@its.jnj.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 20, 2019 at 12:06 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 19, 2019 at 11:18:26PM +0000, Thomas Gummerer wrote:
>
> > From a quick search I couldn't find where 'git diff' actually parses
> > the '-v' argument, but I wonder if we should actually disallow it, in
> > case we want to use it for something else in the future?  It's not
> > documented anywhere in the docs either.
>
> It's a bit interesting, actually. git-diff uses setup_revisions() to
> parse its arguments, which picks up any diff options, as well as parsing
> the revs and pathspecs.
>
> ...
>
>   - we may want to teach the "diff" porcelain not to accept useless
>     revision options. I suspect it may be a bit tricky, just because of
>     the way the code takes advantage of setup_revisions.

This is actually in my TODO list. Once the parseopt conversion for
revision.c and diff.c is done, "git diff --help" would be _very_ long
because of this exact problem. But then once the conversion is over, I
think removing unused options is quite simple (by manipulating 'struct
option[]' array before calling parse_options).
--
Duy
