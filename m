Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D75D51F406
	for <e@80x24.org>; Sat, 12 May 2018 06:07:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750749AbeELGHJ (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 May 2018 02:07:09 -0400
Received: from mail-wr0-f182.google.com ([209.85.128.182]:35254 "EHLO
        mail-wr0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750722AbeELGHI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 May 2018 02:07:08 -0400
Received: by mail-wr0-f182.google.com with SMTP id i14-v6so7212571wre.2
        for <git@vger.kernel.org>; Fri, 11 May 2018 23:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dTigh6+Xw4Gu7rzoDfxb4sKDRvdf72aB9sWhkCrph7I=;
        b=sCuSuyO3fgxVHo37JZK1ownYRgGrrMbPNbZoxk+n7LGTzyHlmCOwOLhtLCZMd+cDn2
         N3qtWuMQXwRVCfCy35ICAVlEGtzFfDpEH6v+hnnLJrZSeypqRE/fX/r6aHCASMOCuWu9
         kzki5+njR9olXDgjUH6P4OiiNTQgnDyYKM0joea0ZcHD/gJeKDIvujDR41i/zdYD9hvy
         q+H0s448wCWUx5daHc8iBXlBvRQB1sFoBWDt1YhkA/TrvcrIRBInaTjr4FiLrxMXzYRL
         ylg9kE+FaQbwJ3Ra1JMeSe9SMZcz0Nb4oSAZtmZ9u4j2kQ/RZnrd6O9jvCYvy+6mzTAw
         7bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dTigh6+Xw4Gu7rzoDfxb4sKDRvdf72aB9sWhkCrph7I=;
        b=LORVzPuv4jskb3WufZlN+BEB0B8ihBWIGbLPmkLo23AKRtrU7A1+SF3o8grxIgaN3N
         W8tG+btBFZ/24d3RY9YaPE2ci3L1Phrh/MyOaKbNg5Tk8J/TNZR0nH7pqHmMkjPGFlTT
         KrL7B4bltQS2hsQF/XiTA5XNcxMYfaPxxF6qnIjKGLZBZy1V3fLjoanRj5V7tnzKD639
         Lwyh9ErYkhjqNuphh6f4iS1o/Bil/WpVcxo1gkV5/oyo7rn5i3OySdEJ+VEGlIpSprJv
         ZAkrUZwi3vnVaLRPEqKKlDJUVvs43kT6YaWICAEjIDov/9AbsQwru+LXzxm4D2OWXijY
         AHmQ==
X-Gm-Message-State: ALKqPwf9V4FwxW7U18vEbAdRavw50RxBclm5Yicdj3zZ+HSk2e5Yh7V3
        uH8vvwfpdtE5vKEuO+0OxTE=
X-Google-Smtp-Source: AB8JxZol6ehEMcmvyVhyLYcrKVqUs3mFP1rC14lsAg1NP+bNkMK5hpGnBkD8CVBapQopGvNnlw8kKw==
X-Received: by 2002:adf:c613:: with SMTP id n19-v6mr1121435wrg.177.1526105227107;
        Fri, 11 May 2018 23:07:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b72-v6sm4118159wmf.11.2018.05.11.23.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 May 2018 23:07:05 -0700 (PDT)
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
References: <20180421034530.GB24606@syl.local>
        <cover.1525831201.git.me@ttaylorr.com>
        <9222f0ee470884a984c1174cf218dece43f77f87.1525831201.git.me@ttaylorr.com>
        <882bdfe8-6caa-dd9c-7752-ee4884f135f9@talktalk.net>
        <CAN0heSpXCajyDKwOrXuQHWRODsVnFewUWTMitOoRQueFV4eSiw@mail.gmail.com>
        <20180509235251.GC68889@syl.local>
        <xmqqefikl6jx.fsf@gitster-ct.c.googlers.com>
        <20180512032733.GA65308@syl.local>
        <xmqqbmdlfokf.fsf@gitster-ct.c.googlers.com>
        <20180512051902.GA70598@syl.local>
Date:   Sat, 12 May 2018 15:07:04 +0900
In-Reply-To: <20180512051902.GA70598@syl.local> (Taylor Blau's message of
        "Fri, 11 May 2018 22:19:02 -0700")
Message-ID: <xmqq7eo9flvb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I re-read your note and understand more clearly now what your suggestion
> is. To ensure that we're in agreement, do you mean:
>
>   1. '--column -v' will _never_ give a column, but will never die(),
>       either

No, I don't.

>   2. '--column --[and | or | not]' will never give a column, but will
>       also never die(), either.

No, I don't.

If a file does not have substring "foo", then

	git grep -v -e foo file
	git grep --not -e foo file

would hit all lines, just like

	git grep -e '.*' file

does.

I would expect that all of these

	git grep --column/-o -v -e foo file
	git grep --column/-o --not -e foo file
	git grep --column/-o -e '.*' file

give the same output, which is what we would get if we consider the
hit from "choose lines that lack 'foo'" on a line without 'foo' is
caused by the entire contents on the line.  That is in line with
"choose lines that has anything (including nothing)" aka ".*" would
result in the entire line being reported via -o.  The byte offset of
the first hit on such a line reported by --column is also 1, and
that is a good and real answer to the question "git grep --column/-o"
can give.  

In an earlier message, you sounded like you do not think "we did not
have 'foo' on that line, and that is why we are emitting because we
are operating under -v" lack a definite answer for --column, but I
think you are wrong.  "On the entire line, we didn't find 'foo'
anywhere" is good enough reason for me to make the answer "the
entire line contributed to this hit" a definite one.

Exactly the same applies for "git grep --not -e foo".

When "git grep -e bar [--or] --not -e foo" shows a line because the
line has 'bar' on it, we have --column that points at 'b' of the
first 'bar' on the line.  When it shows a line because the line has
neither 'bar' or 'foo', then "--not -e foo" part would give a
definite "the entire line contributed to this decision that it does
not have 'foo'".


