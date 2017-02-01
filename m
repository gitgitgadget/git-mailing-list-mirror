Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 620491F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 20:07:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751364AbdBAUHJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 15:07:09 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34909 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750896AbdBAUHI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 15:07:08 -0500
Received: by mail-pf0-f195.google.com with SMTP id f144so32536760pfa.2
        for <git@vger.kernel.org>; Wed, 01 Feb 2017 12:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zqKkeNNj8uzpYnhR4gSrfZVquE52jJxUR+ygAkInMGM=;
        b=AANdpzyUbIHD7rCWFvFEDcxl9Tmnw1VW4uzg2N+1EpZ9oqC9SdKrMN5jswNiC7QpYx
         xsOt7f+Xd+znB+pYh/0wnzW1KH4Tix4myuBekw2neti9hYMXtE2Kd9DxWsia2fwaltOX
         ys/nLPbhEZ6iBbVY0tnXpTIWFnRmj2fUqb7iNlsp9NI4snJ08ltJVW7tgg0HSLwl3pb2
         LXLg4H5Xzg+FAG/B66mgR7zCKaMloZ2469+iCm+ke3iT7njnYM3wwD6OPmUhyqmiWY3L
         CJnoIK1g/fOtwuxGjMlLK79K3RGGSJv1KIKR4PM/MwUATSx67IttyGXjSznVVsbbl6Gf
         tsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zqKkeNNj8uzpYnhR4gSrfZVquE52jJxUR+ygAkInMGM=;
        b=spcOnoqbsXUctvsb8AffoB/CpXj8BH/+y6bKPySEirNuNODYLcqlnCJHc8LBHPF9/u
         UkLUO1qInh3fG9CjO9Hx9xpRoIm/WMfF+D4i1dyGy6sEnvbsEkgquaE9MmWA+jSVg/wL
         aRhum0NEcFTqlzfJgoqJ1HOxCEWH2IWqLgMKataesJpJLuG+OKjhmRMsK8JVV9TdW046
         06uK4ksDpluvtMtU5fT7ud3QYvjHapqZuI3IOVuKIqB4NFWdW6C1usOJJhCVE2ZWfg/f
         lJ3Z7wFt7BcyaRAEyNGz0ochn5GZny0DeJIE2bbZEBYCiOMBEamweUU/q6dp40HQnwKc
         hw/w==
X-Gm-Message-State: AIkVDXIVCOui9pfdiOwe5JVA+i+hthlHlgabQW0M40bjhcuKOqzAUdJKpFyiiINxCQ7Y7A==
X-Received: by 10.99.56.94 with SMTP id h30mr5919379pgn.23.1485979627763;
        Wed, 01 Feb 2017 12:07:07 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:25a6:b4bd:905a:8303])
        by smtp.gmail.com with ESMTPSA id m20sm52203871pgd.17.2017.02.01.12.07.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 01 Feb 2017 12:07:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/4] Handle PuTTY (plink/tortoiseplink) even in GIT_SSH_COMMAND
References: <cover.1485442231.git.johannes.schindelin@gmx.de>
        <cover.1485950225.git.johannes.schindelin@gmx.de>
Date:   Wed, 01 Feb 2017 12:07:06 -0800
In-Reply-To: <cover.1485950225.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Wed, 1 Feb 2017 12:57:41 +0100 (CET)")
Message-ID: <xmqqr33hoetx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is quite preposterous to call this an "iteration" of the patch
> series, because the code is so different now. I say this because I want
> to caution that this code has not been tested as thoroughly, by far, as
> the first iteration.
>
> The primary purpose of code review is correctness, everything else is
> either a consequence of it, or a means to make reviewing easier.

You are utterly wrong here.

The primary purpose of code review is to spot and correct the
problems the submitter has missed.  The problems can span from
stupid bugs that affect correctness to maintainability, to design
mistakes, to clarity of explanation for both end users and future
developers.

Among them, correctness problems are, as long as the problem to be
solved is specified clearly enough, the easiest to spot by the
submitter before the patch is sent out.  The submitter is focused on
solving one problem, and if the updated code does not even work as
the submitter advertises it would, that can be caught by the
submitter before the patch is even sent out.  

Of course, humans are not perfect, and catching correctness problems
is important, but that is not the only (let alone primary) thing.

When a submitter has been focusing on solving one problem, it is
easy to lose the larger picture and to end up adding something that
may be "correct" (in the sense of "works as advertised by the
submitter") but does not fit well with the rest of the system, or
covers some use cases but misses other important and related use
cases.  If the "does not fit well" surfaces to the end user level,
that would become a design problem.  If it affects the future
developers, that would become a maintainability problem.

Compared to the correctness issue, these are much harder to spot by
the submitter alone, who focused so intensely to get his code
"correct".  The review process is of greater value to spot these
issues.

I've already read and commented on the series; as I said, I think
the rewrite in 3/4 makes the resulting code much easier to read, and
with the fix-up I just sent out, I think the end result is correct,
works as advertised, the way it is advertised is clear to end users,
and is maintainable.  

But I do share your uneasiness about the "new-ness" of the code.
