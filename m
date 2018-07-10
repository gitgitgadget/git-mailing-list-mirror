Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05B11F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934447AbeGJQJG (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:09:06 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46003 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934062AbeGJQJG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:09:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id c4-v6so2534968wrs.12
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0v4F+SwX+wRILkHqc25x96qEpG253KzgOv536SW6jQM=;
        b=dwOd5KehHGp+P6+hJr2/jrqy1SA8fCV8wX9US4jhT1aCM9V6aHSuOMRf/wymTV35K5
         iTjzj93bV9minhJgoOgjpQ2gy6OAQKEm9B6pvopQ09wIyipmrANj34qf6vXtMHtbU5TC
         a27E52ZEA6gA9HxIb8bsX6ZtI6Jvr1k9FvadRbZT8zdIApxp4tf/dyCQ4dsW0vsLlGBo
         yMWmZVhl+aOVEZv6iE56Tv5Dkdt4CeVKR9rUjsuJuhilT/d4f+U3mB1vZ2sciiBM9pVs
         78/0TU4Q5yPoO8Epd4FpqKCWPswuSLdSCNRiZLzH36IvL8p1uo0mNwKj6l4srvnNi3jh
         N+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0v4F+SwX+wRILkHqc25x96qEpG253KzgOv536SW6jQM=;
        b=kHBLzx5+DnJB/tVjYtl4UEogPgkMtEwrMS/D9UnDHarwdFwY7/dxAu1AmAVSUhioIL
         8ICT2TSyZ2AC2Suotiyan3LBLC7iaUGwXTwitQTiezO34CziRQT+1xw83tOvg8j+n/Kf
         c9v31R0QoboCOwHqhpNOg4ujmQOVqkfSK0Ii3qplsVLgSn9wO6euqgcfTXMGm61PKOk4
         4Lymk/hGJrdlYFE4YDNDy3d8U/908545S5X4zywCeFGGEso046QGJ3ZGtSOHZ6BmwBE+
         ufZvAqiEOnEia94O9ESmbf07jc4AJC6tptVQFh6QBq44039kmnRyIYe7U0GUhO1pAWkB
         Rraw==
X-Gm-Message-State: APt69E2rOtGDpMe79bIEEpPAm4a4Eeo6r+NUDKHlB9mSu2UYQqiUM6Bn
        VI3mkfKZhZk8N6FNlu7HZF0=
X-Google-Smtp-Source: AAOMgpeYlcvQMUR2OG9u1U1bBx+ziteM27yEZOJjLFLJjpfVAPG8MmrGK2WN/9fgqr4/7RUr+KfO7w==
X-Received: by 2002:adf:fa45:: with SMTP id y5-v6mr20012268wrr.138.1531238944576;
        Tue, 10 Jul 2018 09:09:04 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id t1-v6sm21530060wmt.40.2018.07.10.09.09.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:09:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Jacques <dnj@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Paul Smith <paul@mad-scientist.net>,
        git@vger.kernel.org
Subject: Re: Git 2.18: RUNTIME_PREFIX... is it working?
References: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
        <nycvar.QRO.7.76.6.1807041312150.75@tvgsbejvaqbjf.bet>
        <986185d30a0f09b4e2a9832d324a265cd3da7354.camel@mad-scientist.net>
        <nycvar.QRO.7.76.6.1807061059260.75@tvgsbejvaqbjf.bet>
        <CAD1RUU-4a_jV_JjozjXOR4bi+_7rFW_AjmHbbrw6NHJ77=oGkw@mail.gmail.com>
        <bf0d4f33701ec694917f2e710c3fb097085c8d69.camel@mad-scientist.net>
        <nycvar.QRO.7.76.6.1807082346140.75@tvgsbejvaqbjf.bet>
        <20180709195822.GA9000@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1807092225120.75@tvgsbejvaqbjf.bet>
        <20180710022141.GC10248@sigill.intra.peff.net>
        <nycvar.QRO.7.76.6.1807101339370.75@tvgsbejvaqbjf.bet>
        <CAD1RUU8pT-3GKN4qRjysi+re+AKF4eB+VEDr+GzMW_4=E4uftQ@mail.gmail.com>
Date:   Tue, 10 Jul 2018 09:09:03 -0700
In-Reply-To: <CAD1RUU8pT-3GKN4qRjysi+re+AKF4eB+VEDr+GzMW_4=E4uftQ@mail.gmail.com>
        (Daniel Jacques's message of "Tue, 10 Jul 2018 10:03:00 -0400")
Message-ID: <xmqqefgb9iow.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Jacques <dnj@google.com> writes:

> All things considered, I think executable path self-location is markedly more
> fragile than using static paths, both with increased dependencies and added
> inconsistent behavior and limitations, and should not be the default
> on any platform.
>
> Both Johannes' original RUNTIME_PREFIX implementation for Windows and the
> Linux/etc. expansions that I did were written to serve constrained special case
> deployments. In that capacity, they can be really useful, as the fragility is
> managed by their respective environments.

Wow, an original author of a non-trivial feature who does not push
his own creation to be used everywhere and instead cautions against
blindly using it?  

That sort of restraint is a rare trait to be commended.  Thanks for
injeting a doze of sanity.

