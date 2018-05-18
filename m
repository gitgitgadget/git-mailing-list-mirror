Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 159491F51C
	for <e@80x24.org>; Fri, 18 May 2018 03:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751897AbeERDiW (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 23:38:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42329 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751698AbeERDiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 23:38:21 -0400
Received: by mail-pl0-f68.google.com with SMTP id u6-v6so3757710pls.9
        for <git@vger.kernel.org>; Thu, 17 May 2018 20:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mMcEJtqo0RrhFowKI4mTkoLWUeCjEidAczdzWiXNcw4=;
        b=akmGRJccO6CdKKHmk9EMY9DNyZY1U059pd9VA91Pj203omPbA0WEiS+kw/LrveHDOa
         mB7vNdKBZOci/2AL8Prp9jtrMWkKh1678Pr7zh++Cd7yOZYeLP7JFAOS1wvnNLgBDscC
         SbtQw9Vk/C6exK63LuXOrPXf2W0ooIPbYcxJIVqh3ea6//347d+6nkklu8cPc0FbfzVw
         Hy8slNh/N2WA5mdwjwRE+TOZHLqEJvQaXv4Vc/wUm8KgkDalueZ/U8VHfD4ESj51svmp
         cBYc/KV9xNIrQFNXbrqZVhONGu7NbUrOW7Xawcs3us4ytxKYHhaLvp5ckyTdMMy8TkIg
         iPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mMcEJtqo0RrhFowKI4mTkoLWUeCjEidAczdzWiXNcw4=;
        b=BsNtNNTV/mZB+H6QVol3Ph7V/XWXuzjTr8DMTNDJce/Svm1R8F3O2vq5PW4vZ1u7/f
         pFRapPV10Et8krLtRJlkjpxQh2J7tcEJbjxo93Lu8EZDVSfS7B/SiZ8R4TxsXJWYn4S9
         ntCLcoJTgs9cTij+/m5r2fMuUx6sFWDmFD/T/qetPHbFepJoTy8GKvaUzp1VT7dl+N4S
         dt1KxoaKjsWnn6qkeFIuqPmO83OKJCFeSpWkGpam5RySSo0yuAbRB0W5Lq8mIcr2Tpfb
         s64tHXbLVbBOdjGWqWCXHHGWVRw9L+mGRHM23QKBQ3kjaENKDt+q43vUQXaMN0n7yEaP
         Q6CA==
X-Gm-Message-State: ALKqPwdTkEuWl9QbNyyYUTAMLaQLph9fyO6a4VE4uokbBjIu4V/Z3Dhy
        JoTuU8M5yYAvvtlaFkymB4M7nSYcE0IjPw==
X-Google-Smtp-Source: AB8JxZpOkziE6KuL46f/gM4vzm5dJNegBJd0niKKDF5kOjUAxG2DXGPkpGwyJbOEwdgDlydFnNsEqQ==
X-Received: by 2002:a17:902:6b0c:: with SMTP id o12-v6mr7680133plk.159.1526614700723;
        Thu, 17 May 2018 20:38:20 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:8008:7828:c116:ec9])
        by smtp.gmail.com with ESMTPSA id j193-v6sm8973512pgc.44.2018.05.17.20.38.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 May 2018 20:38:18 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Thu, 17 May 2018 20:38:17 -0700
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to
 'git-grep(1)'
Message-ID: <20180518033817.GA61335@syl.local>
References: <cover.1525831201.git.me@ttaylorr.com>
 <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
 <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
 <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
 <20180509235251.GC68889@syl.local>
 <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
 <20180512032733.GA65308@syl.local>
 <xmqqbmdlfokf.fsf@gitster-ct.c.googlers.com>
 <20180512051902.GA70598@syl.local>
 <xmqq7eo9flvb.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7eo9flvb.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 12, 2018 at 03:07:04PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > I re-read your note and understand more clearly now what your suggestion
> > is. To ensure that we're in agreement, do you mean:
> >
> >   1. '--column -v' will _never_ give a column, but will never die(),
> >       either
>
> No, I don't.
>
> >   2. '--column --[and | or | not]' will never give a column, but will
> >       also never die(), either.
>
> No, I don't.
>
> If a file does not have substring "foo", then
>
> 	git grep -v -e foo file
> 	git grep --not -e foo file
>
> would hit all lines, just like
>
> 	git grep -e '.*' file
>
> does.
>
> I would expect that all of these
>
> 	git grep --column/-o -v -e foo file
> 	git grep --column/-o --not -e foo file
> 	git grep --column/-o -e '.*' file
>
> give the same output, which is what we would get if we consider the
> hit from "choose lines that lack 'foo'" on a line without 'foo' is
> caused by the entire contents on the line.  That is in line with
> "choose lines that has anything (including nothing)" aka ".*" would
> result in the entire line being reported via -o.  The byte offset of
> the first hit on such a line reported by --column is also 1, and
> that is a good and real answer to the question "git grep --column/-o"
> can give.

I agree with your message now and thank you for explaining what you
had written. I spoke with Peff off-list for a while to determine what I
think is essentially the answer to ``what are a set of semantics for
filling out a regmatch_t given an extended expression?''

It's helpful to recognize that the extended expressions are implemented
very much like a tree, so a reasonable semantics will lend itself well
to the way in which match_expr_eval() is implemented. Here's what we
came up with:

  * `git grep -e foo`. This is the case where the extended expression
    has a single atomic node in its tree. This falls into the "just call
    match_one_pattern()" case and has a simple answer: the starting
    offset and ending offset are that of whatever match_one_pattern
    gives.

  * `git grep --not -e foo`. This has the set of semantics that you
    describe above (the starting offset is 1), with the addition that
    the ending offset is the end of the line. This is similar to the
    fact that `--not foo` is very similar to `.$`.

  * `git grep --and -e foo -e bar`. This binary operation should recur
    on its sub-expressions and take the minimum of the starting offset
    and the maximum of the ending offset.

    For inputs of the form "foobar" and "foo bar", it will do the right
    thing (give the starting and ending offset for "foobar" and give no
    match, respectively).

  * `git grep --or -e foo -e bar`. This is the most complicated case, in
    my opinion. In going with the min/max idea in the and case above, I
    think that `--or` should also min/max its sub-expressions, but in
    fact we short-circuit evaluating the second sub-expression when we
    find a match for the first.

    So, in cases like matching `--or -e foo -e bar` with "foo baz bar",
    we'll do the right thing, since `foo` is the first sub-expression
    and happens to be the left-most match. In other words, we __adhere
    to our answer with the left-most match first__ semantics, but only
    because __the first sub-expression is the left-most match__.

    In the other case where we try and match the same expression against
    "bar baz foo", we'll return the starting offset of "foo", even
    though it isn't the left-most match, violating our semantics.

So, I propose we adopt the following: use the trivial answer for "foo",
the whole line for "--not", and min/max the starting/ending offsets for
binary operators, knowing that we will sometimes produce a weird answer
for --or.

I think that the semantics for --or are OK to go forward with, but would
be interested in the thoughts of others to figure out whether this is
sensible to everyone else.

Does this seem like an OK approach? Perhaps Peff can clarify some of
what's shared here, since we did speak elsewhere about it.

Thanks,
Taylor
