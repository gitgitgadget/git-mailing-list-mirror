Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1126D200B9
	for <e@80x24.org>; Fri, 18 May 2018 06:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752296AbeERG1v (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 02:27:51 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51300 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752289AbeERG1r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 02:27:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id j4-v6so12294264wme.1
        for <git@vger.kernel.org>; Thu, 17 May 2018 23:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5WpIGrJVuQjuQ1jYGEL56owePA78w0GJZY/feVpHeXY=;
        b=VTgi3Jbl/4GSx3/BbB0gmdKx6Cqn/+CuHGz1YIiiRFklFA3AuAQDcgKO2ed13cEcjG
         DYvpqxWDrGfSRWRjX2KstgLTHPuYc8TmWBMCbScPcxgon+OtMWvKBZrstOvTGiVYQdmg
         gQTLdmThtxLZZ326lDL+0F/4QHQXo+WTWvuiPQN081x5OqL/JkKpe/qBNNeVcW1RqPvD
         lTyoCryGH+umuPZM9UYcBgVlhDbYRfa0GkJNjqEGkd9w4xfFcdCltRg/L4cHvStwhDh0
         3CKeMoVcNFtwepri5ieux/UkXnVPYJD+g9hkKHix/cD2eaNz2R0UpibpsqX9R/dSkA59
         krjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5WpIGrJVuQjuQ1jYGEL56owePA78w0GJZY/feVpHeXY=;
        b=gs4JrxQNg5/1/7h5cnHvKmcy5Om1i6lLZas3Giv8l1rEs+E72Lia/2pcNE07X50Ajb
         PCAgeTr8JAHXr0Ikb4mOiMr24sEEw4KmYgVh5s6pSIcH914YwDd/cmM+POglPjElrAWt
         skYak3BPHHckYWel0xQ3JIoBobQ3XP06U8/Y2hnuw1ubfZUP9yHfKI9+R9Hp+tsoVzte
         sqFVLwiCNy7WuFxhMz04Kwh1yeuH0hOcfsfvwL2zRmyLV8eaUPAqvg4WaWs3ZSYGahbY
         dvIHwAVmYwrpIwlVlyXm4tdUXR0NjTT0tqQO0hIFOGVWLp+kGNJtNStb6RYtaWVCdHVU
         Tcxg==
X-Gm-Message-State: ALKqPwdnly4uRbqeytzOG4YQqev/SCNyZbIZVn3cAlloFDgZlYaf/CT0
        jJQm8N7C+DbDEH562tk/sN0=
X-Google-Smtp-Source: AB8JxZqOxfxwkJBbndrnAQxecwBdxPZ6aIPw1fIyu7Dc7Km8McEoR/HmAsebgF8eED24itb5uNcuEQ==
X-Received: by 2002:a1c:a55:: with SMTP id 82-v6mr3950049wmk.59.1526624865638;
        Thu, 17 May 2018 23:27:45 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l69-v6sm11776603wmb.30.2018.05.17.23.27.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 23:27:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?Tmd1eeG7hW4g?= =?utf-8?B?VGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 5/7] builtin/grep.c: add '--column' option to 'git-grep(1)'
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
        <20180518033817.GA61335@syl.local>
Date:   Fri, 18 May 2018 15:27:44 +0900
In-Reply-To: <20180518033817.GA61335@syl.local> (Taylor Blau's message of
        "Thu, 17 May 2018 20:38:17 -0700")
Message-ID: <xmqqh8n54gwv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>   * `git grep --and -e foo -e bar`. This binary operation should recur
>     on its sub-expressions and take the minimum of the starting offset
>     and the maximum of the ending offset.

We use infix notation, so the above is "git grep -e foo --and -e
bar" actually ;-).

But you raise an interesting point.  A line with "hello foo bar baz"
on it would match, so does a line with "goodbye bar baz foo", as
both of them hits pattern "foo" *and* pattern "bar".  It is not
quite clear what it means to "show the first hit on the line".  One
interpretation would be to take the minimum span that makes both
sides of "--and" happy (your "minimum of start, maximum of end").
Another might be to pick "foo" in the first and "bar" in the second
line, as that is the "first hit" on the line, which is consistent
with how "git grep -e foo" would say about "a foo b foo c foo" (I
expect that the leftmost "foo" would be the first hit).  So there
may be multiple, equally plausible answer to the question.

>     For inputs of the form "foobar" and "foo bar", it will do the right
>     thing (give the starting and ending offset for "foobar" and give no
>     match, respectively).

I think I agree with "foobar", but I do not understand why there is
no match for "foo bar".

>   * `git grep --or -e foo -e bar`. This is the most complicated case, in
>     my opinion. In going with the min/max idea in the and case above, I
>     think that `--or` should also min/max its sub-expressions, but in
>     fact we short-circuit evaluating the second sub-expression when we
>     find a match for the first.

I am not sure I follow.  "git grep -e foo --or -e bar" is just a
longhand for "git grep -e foo -e bar".  Shouldn't it highlight
whichever between foo and bar that appears leftmost on the line?

>     So, in cases like matching `--or -e foo -e bar` with "foo baz bar",
>     we'll do the right thing, since `foo` is the first sub-expression
>     and happens to be the left-most match. In other words, we __adhere
>     to our answer with the left-most match first__ semantics, but only
>     because __the first sub-expression is the left-most match__.
>
>     In the other case where we try and match the same expression against
>     "bar baz foo", we'll return the starting offset of "foo", even
>     though it isn't the left-most match, violating our semantics.

I am not sure why you think your min-starting/max-ending would lead
to such a conclusion.  'foo baz bar' would be covered in its
entirety, 'bar baz foo' would also, as starting of hits with pattern
'foo' and pattern 'bar' would be 'b' in 'bar' on that three-word
line, and ending of hits with these two patterns would be the last
'o' in 'foo' on the line.  

I'd expect that a line 'foo baz bar' matched against "-e foo --or -e
bar" would say "among three words on me, 'f' in foo is the first
location of the match", though.
