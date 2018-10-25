Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A014C1F453
	for <e@80x24.org>; Thu, 25 Oct 2018 04:10:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeJYMke (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Oct 2018 08:40:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41231 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbeJYMkd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Oct 2018 08:40:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id q7-v6so7703775wrr.8
        for <git@vger.kernel.org>; Wed, 24 Oct 2018 21:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=c6wjdt33bXv5UvIwjqr33WXKEYFSPhIwqPIZaPWosjc=;
        b=hAh0u0SvXcRa8ICx4GEE/f6qBHhtBDBRbieqIBzQImZtQkcVtCtnouUat9IW2aljPN
         M5ubyfRgfJMq7Hz/Jer1Lr97JoKRZI1H7lRQSPPy3bPnhMUlgpH6VtLFj+yaSB3+GPB6
         S4y7WVYFS9HuLQw1ThumtmK+1zwN+MOzTcabubWFZX7gPUrjViItrgOCA78TM6CSJq8o
         +eC7Ges060FWYnWnLr/mjUJKyJkaO02onkrfnUE85/vVDtwzFrW1zmof3ni1cVFgmO8s
         YsOMyJ91blTiLMZDoEy8IKpiCfetEcWQQWjvy+C95MV+TixFZZf1ppsdK/gmhvwvb3Vz
         kvkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=c6wjdt33bXv5UvIwjqr33WXKEYFSPhIwqPIZaPWosjc=;
        b=kuQWMe4fIlVZ8dXLvhe1CQUN2cxUtIRvnVW5n36QSnqQ0tJavPMlF43piXUe7quIEc
         A2Is3cvgInrTZNZqGZ/7LMRmVHdaaXJv0vT7ROEB6eF7+Xvk6AZSqfNyZwJz2sUPPBIr
         TyBEajSCDF4jgIiTCGyxn1KuXh154mxsJSVjzjRLeBLIcqkqDWiremh4WEcLbUj4k10w
         JoFOG8oVGquH/aJiayXs+D7BJbKGRHWYVWP0tEJFlvfDWylHIyB0EL2RPOkYNyFLzs1H
         vqxO/m5w4nZIEeUDQGyd6WBfrFPdVzaYlbe6bFnendMfudH1Oo14l8l9B+Kq8e6db/SV
         mT6A==
X-Gm-Message-State: AGRZ1gLVCCu60u/th74Y8zVbDHXigxXX1mIRVYusprGlOuM0dFVKypj9
        ueMkchFYwyynVmDtJ6JAnNMHUe/DF0E=
X-Google-Smtp-Source: AJdET5cwZVZr/Jo89CNV8YNjzacDcZ/LLAp+NnkHD2OcW1yOPzWhwukh4GlXc2fZMRb+eVw5b3ieUg==
X-Received: by 2002:a5d:560c:: with SMTP id l12-v6mr2439831wrv.281.1540440577284;
        Wed, 24 Oct 2018 21:09:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q17-v6sm5973381wrw.19.2018.10.24.21.09.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 21:09:36 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Ben Peart <peartben@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: Recommended configurations (was Re: [PATCH v1 2/2] reset: add new reset.quietDefault config setting)
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181017164021.15204-3-peartben@gmail.com>
        <CAPig+cQ3ia78pLtnHSq8tM3B-XnFgWhwowJxwacYEEzXosJ16g@mail.gmail.com>
        <20181017182337.GD28326@sigill.intra.peff.net>
        <874lddc9fs.fsf@evledraar.gmail.com>
        <1ba81f12-7040-1ba5-2009-fa681caf9874@gmail.com>
        <87zhv4bfck.fsf@evledraar.gmail.com>
        <29db5fed-4556-277e-7aad-7ff3233550a9@gmail.com>
        <20181024235813.GA1399@sigill.intra.peff.net>
Date:   Thu, 25 Oct 2018 13:09:35 +0900
In-Reply-To: <20181024235813.GA1399@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 24 Oct 2018 19:58:14 -0400")
Message-ID: <xmqqd0rylla8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I do hope that some options will just be no-brainers to enable always,
> though (e.g., I think in the long run commit-graph should just default
> to "on"; it's cheap to keep up to date and helps proportionally to the
> repo size).

Same here.

We should strive to make any feature to optimize for repositories
with a particular trait not to hurt too much to repositories without
that trait, so that we can start such a feature as opt-in but later
can make it the default for everybody.  Sometimes it may not be
possible, but my gut feeling is that features aiming for optimizing
big repositories should fundamentally need only very small overhead
when enabled in a small repository.

So I view them not as a set of million "if your repository matches
this criterion, turn it on" knobs.  Rather, they are "we haven't
tested it fully, but you can opt into the experiment a new way to do
the same operation, which is designed to optimize for repositories
with this trait. Enabling it even when your repository does not have
that trait and reporting regression is also very welcome, as it is a
good indication that the new way has rough edges at its corners".

Thanks.
