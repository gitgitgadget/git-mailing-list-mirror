Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8F61F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731512AbfDXPhP (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:37:15 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44975 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbfDXPhO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:37:14 -0400
Received: by mail-ed1-f66.google.com with SMTP id i13so16302367edf.11
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=08IW2WtQdjd/4e+/W1pkBwWi01vCsHKhpzCLwK7fuO8=;
        b=ITFKY1NtCBpKChkIL9cDfcvIGx6nTf2/jxP+2MplpW/TargMEGdDzCLUv64qeBtGzG
         NmVoDCkIx3uzsDClJBfJv3aaUOBrcW1K/yaZq+MFlUUyjyinhJuVOMCKQzTfRA/Fcp49
         z9LZcdisWw1de3zOtiQiZ3GWtHk+TTTbcuovytLPDFmkS5eTQO56Y97WLS0Qb0bijo94
         eOeI8MtpYnGLaRNBLNQaV3ZVjbbMJoIOl4ZsLVTr0HNnEFeyjDZfo1Lc0l6lUVWXbNIc
         glsLnA9aN9H2m/L/hMzltTsz5esmXshdqvxd9BQhLTdXmnAUR6un9WC4iOG0oYiFFnB3
         ODZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=08IW2WtQdjd/4e+/W1pkBwWi01vCsHKhpzCLwK7fuO8=;
        b=P5h+1RUdaLDAeyI74vYLL/6lXqxFi92Jcgz7TZK9cjk81IGQPqRn2lNQlLpF7QJ9VJ
         ZR3lxOUAG6kCFeB5RYzmJ1laU+Q2XwG6XxrS0iTyy0r/TJUS6p/j0UpvmBqsWBxd4pqw
         HPkojb1uwyHGILNy9BNJ7+sKwEKilIcv/i/voBoOH7kBTl1RtazNz0uGvQRnMBpIVxJa
         sxy1YKUnV0ygWoDspPP7TQRwTLOzaq8Z8mnirnwMSwO07QpMVUcBG5j829wYZGlBvbmt
         GVfX/ViqXwXv5sHCl5mrZW7/bUDe2KW5Q7+rMBWp7mBWRw96SOsEtTHSss28M0XwX+RR
         e+4Q==
X-Gm-Message-State: APjAAAVZx1iBAWUMFgawq+IGt5SPhV07y//EiyL1fpyQFjzoQ+AQcE+q
        dEjUK1AFcSdbeMv58pAcqu7u6NQKzBo=
X-Google-Smtp-Source: APXvYqzkBllZp0u+Du1w1A5pUoZ0a67HVXzIdAZSoAdjPfaxOTCEONHB840JLHQkPtd5zkFVGVV55g==
X-Received: by 2002:a17:906:6a03:: with SMTP id o3mr9143452ejr.6.1556120232935;
        Wed, 24 Apr 2019 08:37:12 -0700 (PDT)
Received: from evledraar ([5.57.21.49])
        by smtp.gmail.com with ESMTPSA id z55sm3449027edz.49.2019.04.24.08.37.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 08:37:11 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Jeff King <peff@peff.net>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH 2/2] diffcore-pickaxe: add --pickaxe-raw-diff for use with -G
References: <20190424102609.GA19697@vmlxhi-102.adit-jv.com> <20190424152215.16251-3-avarab@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190424152215.16251-3-avarab@gmail.com>
Date:   Wed, 24 Apr 2019 17:37:10 +0200
Message-ID: <87o94vs9cp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Apr 24 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Add the ability for the -G<regex> pickaxe to search only through added
> or removed lines in the diff, or even through an arbitrary amount of
> context lines when combined with -U<n>.
>
> This has been requested[1][2] a few times in the past, and isn't
> currently possible. Instead users need to do -G<regex> and then write
> their own post-parsing script to see if the <regex> matched added or
> removed lines, or both. There was no way to match the adjacent context
> lines other than running and grepping the equivalent of a "log -p -U<n>".
>
> 1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.co=
m/
> 2. https://public-inbox.org/git/20190424102609.GA19697@vmlxhi-102.adit-jv=
.com/

I see now once I actually read Eugeniu Rosca's E-Mail upthread instead
of just knee-jerk sending out patches that this doesn't actually solve
his particular problem fully.

I.e. if you want some AND/OR matching support this --pickaxe-raw-diff
won't give you that, but it *does* make it much easier to script up such
an option. Run it twice with -G"\+<regex>" and -G"-<regex>", "sort |
uniq -c" the commit list, and see which things occur once or twice.

Of course that doesn't give you more complex nested and/or cases, but if
git-log grew support for that like git-grep has the -G option could use
that, although at that point we'd probably want to spend effort on
making the underlying machinery smarter to avoid duplicate work.

Furthermore, and quoting Eugeniu upthread:

    In the context of [1], I would like to find all Linux commits which
    replaced:
    	'devm_request_threaded_irq(* IRQF_SHARED *)'
    by:
    	'devm_request_threaded_irq(* IRQF_ONESHOT *)'

Such AND/OR machinery would give you what you wanted *most* of the time,
but it would also find removed/added pairs that were "unrelated" as well
as "related". Solving *that* problem is more complex, but something the
diff machinery could in principle expose.

But the "-G<regex> --pickaxe-raw-diff" feature I have as-is is very
useful, I've had at least two people off-list ask me about a problem
that would be solved by it just in the last 1/2 year (unrelated to them
having seen the WIP patch I sent last October).

It's more general than Junio's suggested --pickaxe-ignore-{add,del}
options[1], but those could be implemented in terms of this underlying
code if anyone cared to have those as aliases. You'd just take the
-G<regex> and prefix the <regex> with "^\+" or "^-" as appropriate and
turn on the DIFF_PICKAXE_G_RAW_DIFF flag.

1. https://public-inbox.org/git/xmqqwoqrr8y2.fsf@gitster-ct.c.googlers.com/
