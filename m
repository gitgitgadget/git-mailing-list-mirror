Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65172200B9
	for <e@80x24.org>; Mon,  7 May 2018 01:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751869AbeEGBf5 (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 May 2018 21:35:57 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40017 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbeEGBf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 May 2018 21:35:56 -0400
Received: by mail-wr0-f195.google.com with SMTP id v60-v6so26731112wrc.7
        for <git@vger.kernel.org>; Sun, 06 May 2018 18:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3qE96nzFjPq1edAMzlKQao1ZUHV0QH+WUNSxmuB9eEo=;
        b=Aqn/gy8n+yoXBxut83iAD/LJghaAfM7crznik4Ab4nvgTgTE8vdXCSHTiQCv5+DH6G
         CECFN0wOGJjT7vP5XHpQypEuILI2M6j6py3DPvZdTIcdS2tet99e0MJx3XCduTLy/6A3
         Dp/yBos5J0+jALKjfs/CrIfqEPQ5mu5+xz/hcyBvXYmtGDFbnHnIsuc77Yo9zLd0xF/8
         t07zY/4Z0i1L0eIxnfNKwzb4jUAIlMdeDqlD5PeFQskb9MV2UPYbm/ze116nR0/0nbdF
         iTgJWW8YIvpm0K9/WKFKNHu88WfqyylN0Jdv9DfYaJStUaXW8txv1ciO4bD3LNv3wUE2
         iSJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3qE96nzFjPq1edAMzlKQao1ZUHV0QH+WUNSxmuB9eEo=;
        b=lc8DReQHDqFRu0qmDXDG9pQT9MsL+8igrt0uO2Up0jA5YuzLsg3I4zTkibSco4W/hp
         tJVu9YXd2AUmzvik3daURPJtribdZQY/Rz72Pg0VDHeQ27PpAKj0KVX1GiA6bxvEJpXb
         WmvPfFtLKNMAGAcIDBws0qMTwUnkLZvk2ZkCqEQ3nel6WxzfG0RbUi8h8qmN98SzgKp2
         YV4xjv65NiE7qJDXfQvf8O7M/CNtez3jbsBIxySJifMwwsxh0tUVmL1+sjNELFmJ0V1D
         q6Hkt28WfyhJ1UoFtTCA5vgPoYoPtG0DahF1+B8iOgfJID41uRCy4AGKMQOCn0jU+qx3
         VInQ==
X-Gm-Message-State: ALQs6tDR87ExosSfCWYDZRNyLd+xyhpVDaI93XThWhGtMaxCgzP/Ze9x
        8wgdxTaZnLrBRr/AKwumEiE=
X-Google-Smtp-Source: AB8JxZrGvfFlJ6d2zrb5Saf624Cnoq8rD/Dmh64AVEqwERhB421TDm4lHM8X29pA5iZnHOAK+/dgQA==
X-Received: by 2002:adf:86fa:: with SMTP id 55-v6mr31130068wry.232.1525656954870;
        Sun, 06 May 2018 18:35:54 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l69sm8751414wmb.30.2018.05.06.18.35.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 May 2018 18:35:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 13/18] color: provide inverted colors, too
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
        <cover.1525448066.git.johannes.schindelin@gmx.de>
        <1ebbe359547689d32aa27564929d733a26bb8054.1525448066.git.johannes.schindelin@gmx.de>
        <20180505182922.GD17700@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1805060001230.77@tvgsbejvaqbjf.bet>
        <20180506063543.GA3418@sigill.intra.peff.net>
        <20180506064104.GB3418@sigill.intra.peff.net>
Date:   Mon, 07 May 2018 10:35:53 +0900
In-Reply-To: <20180506064104.GB3418@sigill.intra.peff.net> (Jeff King's
        message of "Sun, 6 May 2018 02:41:05 -0400")
Message-ID: <xmqqvac0qmbq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, May 06, 2018 at 02:35:44AM -0400, Jeff King wrote:
>
>> You'd have to introduce GIT_COLOR_REVERSE. I don't think we have a
>> constant for it yet, but it's \x[7m.
>
> Heh, of course you knew that already, as I just noticed your patch is
> using the reverse attribute internally (I had thought at first glance
> you were just specifying the background independently).

I somehow suspected as such, but I also thought so and reacted "what
about us whose terminal is black-on-white unlike most others?",
before looking up what 7 meant ;-)

> So really, I guess all I am arguing for is having GIT_COLOR_INV (or
> REVERSE) as a constant, and then teaching the code to combine it with
> the existing "new" color. It's perfectly OK to have:
>
>   \x1b[7m\x1b[36m
>
> instead of:
>
>   \x1b[7;36m
>
> It's two extra bytes, but I doubt anybody cares.

I do not think two extra bytes will be missed, but it was not
immediately obvious to me how much flexibility or simplicity weu are
gaining by combining values from multiple configuration variables.
With a "letters on a new line is painted with ${new}, in addition,
the leading plus is further annotated with ${tbdiffNew}" (similarly
to "old") scheme, the user can take advantage of the fact that there
is no ${reset} between ${new} and ${tbdiffNew} and set tbdiffNew and
tbdiffOld to a same value (that does not change the color but
changes some other aspect of the appearance, like "reverse" or
"underline").  Since only pre-designed combination can be used (your
example works only because you chose to allow combination by
annotating the leading "+" with ${new}${tbdiffNew}), we'd need to
(1) establish a convention to paint things with similar meanings in
the same color, modifyable by individual command (e.g. you could say
anything new is by default green with "color.new=green", and then
"color.frotz.new=blink" "color.status.new=" "color.diff.new=blue"
would make frotz, status and diff subcommands to show new things in
blinking green, normal green, and blue), and (2) push the codebase
to adopt such color combination as a preferred design pattern if we
want the resulting system to be useful.

I guess you are getting simpler configuration, which is a big plus,
but to make a truly useful combining convention, we'd need to
rethink and find a way to transition existing configurations to the
new world, which may not be feasible.

