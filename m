Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A341F51C
	for <e@80x24.org>; Fri, 18 May 2018 21:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbeERVu1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 17:50:27 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40132 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbeERVuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 17:50:25 -0400
Received: by mail-pl0-f65.google.com with SMTP id t12-v6so5298955plo.7
        for <git@vger.kernel.org>; Fri, 18 May 2018 14:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gNSO2Cabt6GowLDk5idTE/4HvzIJwWcf4//XRwDXDeU=;
        b=w7B8sEZAKGKzJXb2GZDXfbcVjjIEJVOJwJ22YYdXLssVLW4hocr7/LlW/PZUepBzjP
         +wm2Iw0QpWZrXPbrPT300SxRxOsGgLDKJxiFxMw05LNWcblyYQau6sZ4sR3uQ8DvsNSk
         qe30+On1b+0c9ZO5PNbZdt4C9jo3YLmA1gQvjEyLuAjYPp9kdGGrJXdEEfe7w2UThHuP
         lHCtmj3awMY2TTwOxAJnxWR82pWxJIsjBAXgnhYO/hiMxbR6J3zACikDUOH5HsELOg9m
         hIFcbnWZqCj83rNDGkxu0LeISth78YvPDcfivjcmKJDwDSvmHuD32zabogkaPQmz90mB
         YBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gNSO2Cabt6GowLDk5idTE/4HvzIJwWcf4//XRwDXDeU=;
        b=nc2DYq1aZb56VrrVUMCCVraus+xgMQEIJSH5VjxHIkYeZky6VH97oC99JQWIZzM5Ht
         tHARr9TBxp4FTYzsnlmg6RCStQaAQx+X/Q65EQM0+FnJCUSAHrK8Xxl2kmqH9qjJI3Nf
         rNc4U3qBSuY19bRRD4OG1EO7I12cpxgqe6WN9pcHIiflmHywxO6vlnGoqyFhtGMTn821
         ebgPJlDLobVBXcU/sgGLRhQPWPqIuQlv12kEBH8Fhqft7v1J8vThtBP8+bHHARLg8Rnm
         jImUzz1GDG/mrq5kaRpZmqNVb9UZNp6PNF57yFXsuksEYvT7T6tpRqsWTG5SbCaeE8oW
         9xOw==
X-Gm-Message-State: ALKqPwebaLWp+a3oKWW6OA362OhUXBKy5VWzJRWnGQ1vaHnaM+NkpYQy
        EFxIg9hEjMdkdq4M+5b7iZ6s9w==
X-Google-Smtp-Source: AB8JxZoTClH1M/fMZNiXLuPZCVXDw+iR1siPvrBSCkVP26oJIlcRv1DtFlizKYWCrelTsJ+gp17xjg==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2-v6mr10985682plb.295.1526680224844;
        Fri, 18 May 2018 14:50:24 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:75fb:b3b2:8793:31ee])
        by smtp.gmail.com with ESMTPSA id o88-v6sm20096773pfa.29.2018.05.18.14.50.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 May 2018 14:50:23 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Fri, 18 May 2018 14:50:21 -0700
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
Message-ID: <20180518215021.GA36543@syl.local>
References: <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
 <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
 <20180509235251.GC68889@syl.local>
 <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
 <20180512032733.GA65308@syl.local>
 <xmqqbmdlfokf.fsf@gitster-ct.c.googlers.com>
 <20180512051902.GA70598@syl.local>
 <xmqq7eo9flvb.fsf@gitster-ct.c.googlers.com>
 <20180518033817.GA61335@syl.local>
 <xmqqh8n54gwv.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh8n54gwv.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your thoughtful response. I answered in detail below, but I
think that we're in agreement about the semantics, with a few
corrections on my part. I'd like to push forward with this series,
including the proposed changes below, but feel that sending it as v7
would be asking too much of a reviewer. Would it be OK if I sent this a
new series entirely and we abandon this thread?

On Fri, May 18, 2018 at 03:27:44PM +0900, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >   * `git grep --and -e foo -e bar`. This binary operation should recur
> >     on its sub-expressions and take the minimum of the starting offset
> >     and the maximum of the ending offset.
>
> We use infix notation, so the above is "git grep -e foo --and -e
> bar" actually ;-).

Thanks for catching that :-).

> But you raise an interesting point.  A line with "hello foo bar baz"
> on it would match, so does a line with "goodbye bar baz foo", as
> both of them hits pattern "foo" *and* pattern "bar".  It is not
> quite clear what it means to "show the first hit on the line".  One
> interpretation would be to take the minimum span that makes both
> sides of "--and" happy (your "minimum of start, maximum of end").

It's funny you should mention: this was nearly the exact phrase I used
when speaking with Peff.

> Another might be to pick "foo" in the first and "bar" in the second
> line, as that is the "first hit" on the line, which is consistent
> with how "git grep -e foo" would say about "a foo b foo c foo" (I
> expect that the leftmost "foo" would be the first hit).  So there
> may be multiple, equally plausible answer to the question.

This is the largest fact in my mind pertaining to this discussion: there
are probably many different interpretations of semantics for this, all
equally valid in their own way. I am partial to the minimum substring
interpretation (which follows naturally from the minimum-start,
maximum-end idea), accepting the shortcoming that `--or` sometimes
doesn't ``do the right thing.''

> >     For inputs of the form "foobar" and "foo bar", it will do the right
> >     thing (give the starting and ending offset for "foobar" and give no
> >     match, respectively).
>
> I think I agree with "foobar", but I do not understand why there is
> no match for "foo bar".

Ah, I think this is my mistake -- when I wrote this note last night. The
case of `-e foo --and -e bar` should clearly match both `foo bar` _and_
`foobar`.

> >   * `git grep --or -e foo -e bar`. This is the most complicated case, in
> >     my opinion. In going with the min/max idea in the and case above, I
> >     think that `--or` should also min/max its sub-expressions, but in
> >     fact we short-circuit evaluating the second sub-expression when we
> >     find a match for the first.
>
> I am not sure I follow.  "git grep -e foo --or -e bar" is just a
> longhand for "git grep -e foo -e bar".  Shouldn't it highlight
> whichever between foo and bar that appears leftmost on the line?

I don't believe that the two are treated the same, but I think that this
is another case where I was incorrect in my judgement of the
implementation last night. In fact, the only time when we _don't_ recur
on both sub-expressions of `--or` is when 'collect_hits' is zero. That's
fine, I believe.

> >     So, in cases like matching `--or -e foo -e bar` with "foo baz bar",
> >     we'll do the right thing, since `foo` is the first sub-expression
> >     and happens to be the left-most match. In other words, we __adhere
> >     to our answer with the left-most match first__ semantics, but only
> >     because __the first sub-expression is the left-most match__.
> >
> >     In the other case where we try and match the same expression against
> >     "bar baz foo", we'll return the starting offset of "foo", even
> >     though it isn't the left-most match, violating our semantics.
>
> I am not sure why you think your min-starting/max-ending would lead
> to such a conclusion.  'foo baz bar' would be covered in its
> entirety, 'bar baz foo' would also, as starting of hits with pattern
> 'foo' and pattern 'bar' would be 'b' in 'bar' on that three-word
> line, and ending of hits with these two patterns would be the last
> 'o' in 'foo' on the line.

Right, I think with the understanding in my last stanza of this response
("I don't believe that ...") this issue is resolved, and the
min-starting/max-ending _will_ do the right thing.

> I'd expect that a line 'foo baz bar' matched against "-e foo --or -e
> bar" would say "among three words on me, 'f' in foo is the first
> location of the match", though.

I would, too.

Thanks,
Taylor
