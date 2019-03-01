Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFA1320248
	for <e@80x24.org>; Fri,  1 Mar 2019 02:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732400AbfCACxB (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 21:53:01 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36710 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbfCACxB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 21:53:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so10842933wmj.1
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 18:53:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=CZ84I1xyAakeN6ackFKrPEU1RMrWmAz6B6xdJP7V0yM=;
        b=HteYow7DtWTm50PpCSkoc8iVFwNqwW1CuL/wyms7sgIibfVTgCIDgDAXRl8bX7FCdB
         yrr0lXPKbrtQKzOhoXC1lmMqYfzfMSqUkBbM1na1tkJo6H4Wk5RqpYkRXx0IYq0876Yo
         OsBBkdoA2Vb2rzkNcn4mf1eIsPVE0h3mgQiT/snUlCMgiA57+GPPOpR93WxphyP+Lflv
         qvQun1Ix89ZMxlNzUtTPQScjUtLNYeIjCxW3iYKM02dW4ZvmfT2296gpLA68Z8dhf5qU
         MYhCu5q8Z2piMHXJJjvgTjTApp6ir7AU/P/tllv1gfP275ylFuTu5TkMgpW+KaDbbhPI
         OCpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=CZ84I1xyAakeN6ackFKrPEU1RMrWmAz6B6xdJP7V0yM=;
        b=BQB0acndNL8JL9wOjVRkAHIFkJWpZidWbQ1gKCAiERPk4S0+qK1LM04yAenIkEubdu
         N5aRwxPTMVIE2qEl7aCDOU2kSysadTvPKI3FDNgmqwG8stlCjbRSP1CZ9HD4dVsaw74I
         O+a/Yyskn1bSkBFU+6MmFcms8PXviRpEA1AnLboCNQbiOTRrsh7nTsgUhQH1sTqZlYHR
         teV8HbpWul7Y0HnkdECk7DoBygA/BmbsfNZYa/g6okGgrQclqOTI/vFOxCmm+QoQFolO
         bQjP8MdzKRW0Rg7e5oDe/lsBPMDXnicGTz7/04eF6CiEHwyPyvuNvfV5qJskhI7F3ozh
         FDyw==
X-Gm-Message-State: APjAAAUCLyUrhEiOBOPmpegVmIBf5IOwAxRfeMwErZ8cDd7+Iq1cbStE
        VFV3XxExUBA8koVI1TwvPNN90pnuEuo=
X-Google-Smtp-Source: AHgI3IYvmVg4/5W0kbCzxGcgDV0MRxwNdgF1DXrx7mXBJbf3y7I1edrKlV6Y1AyiDmyHz11zHHX4Zw==
X-Received: by 2002:a1c:740d:: with SMTP id p13mr1760529wmc.46.1551408779442;
        Thu, 28 Feb 2019 18:52:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e7sm24583792wrw.35.2019.02.28.18.52.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 18:52:58 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Rohit Ashiwal via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: Do test-path_is_{file,dir,exists} make sense anymore with -x?
References: <pull.152.git.gitgitgadget@gmail.com>
        <bf5eb045795579dd5d996e787e246996688cf4bf.1551188524.git.gitgitgadget@gmail.com>
        <CACsJy8DG6+mmA5NT67V46=n1-5H_eh3779eE28YN4kcjb0Cq0A@mail.gmail.com>
        <87sgwav8cp.fsf@evledraar.gmail.com>
Date:   Fri, 01 Mar 2019 11:52:58 +0900
Message-ID: <xmqqzhqf8fw5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> I swear I'm not just on a mission to ruin everyone's GSOC projects. This
> patch definitely looks good, and given that we have this / document it
> makes sense.
>
> However. I wonder in general if we've re-visited the utility of these
> wrappers and maybe other similar wrappers after -x was added.
>
> Back when this was added in 2caf20c52b ("test-lib: user-friendly
> alternatives to test [-d|-f|-e]", 2010-08-10) we didn't have -x.
> ...
> But 4 years after this was added in a136f6d8ff ("test-lib.sh: support -x
> option for shell-tracing", 2014-10-10) we got -x, and then with "-i -v -x":

I think two things need to be considered separately.

 - Do the path-is-file and friends make the test source easier to
   read and undrstand?  Special bonus if it helps us by making it
   harder to write a wrong test.

 - Do these helpers make the output from the test execution easier
   to diagnose or harder?

If your primary compalint is the latter (which I think it is, and I
share the same feeling to a certain degree), I think it is to throw
the baby with bathwater to get rid of path-is-* family.

And as to the former question, I think we even are getting special
bonus.  Often when people write tests to ensure a fix that left an
unwanted file behind would say "! test -f unwanted", but if we say
"path-is-missing unwanted" that would catch not just a regular file
but also catch other kinds of filesystem entities.

As to readablity, I do not think "test -f/-d" etc are unnecessary
hard to read, but using path-is-* does not make it harder to read,
so I'd say it would not give us much to revert to the bare "test -f"
and friends.

Unless you are after squeezing the last cycle spent executing a
shell builtin in the test scripts by using bare-bones "test -f",
that is.  But that is not among the two I said we need to consider
separately, so I won't go there.

Thanks.

[jch: I am still mostly offline til the next week, but I had a
chance to sit in front of my mailbox long enough, so...]
