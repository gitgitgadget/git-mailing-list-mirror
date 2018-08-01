Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EBAF1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 19:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732305AbeHAU6l (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 16:58:41 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36151 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbeHAU6k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 16:58:40 -0400
Received: by mail-wm0-f48.google.com with SMTP id w24-v6so194483wmc.1
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 12:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6GJuRE8dDCeEqFajWDWbNTBIsZVs16G/0ifISybLRVg=;
        b=Tg93TKbkXI96+zAdIoyHymVzEn4gz7uj4g60TwNY5xt0msyOFXX4q7LWWRxzpcaf9I
         znYeVfSDfPvqZ5Vcl+jPa1i5FVykfO3FycK05CCQmFsXrvteev3BHu3uhZWcPPNfoQyU
         m0YpRHuglbcONzW3Ae0/ZQkiUmeSbzC0CbY5vDpVL8USwCFkYtiXCR261tFHjm+jgxJv
         GcW9TWQqXdpOxwvCJfMI0CZ4Ghk4w5jsaPbiuQhzY16LeuLAojHHiurB14IGFWVjPsly
         n4Lxphg3gVD8uAinTSbNGM//8r4xv6aif65aHx0bbOvXo+166SyFVLQPXpgl/cMBGL9K
         fZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6GJuRE8dDCeEqFajWDWbNTBIsZVs16G/0ifISybLRVg=;
        b=B0l8AJwLeGYx/Uae9lDzvygY2zXcHbmMrB2n9f8A08mUeL4f/GTzL/qT+RfTguCw4j
         80Bz1P0uUBhNmoW/ycHEQHQ2Ju3rZYo1zhorOvVlkACEnEQ+XK0198rXDFpClDv+EQSE
         J54fsEhhHx+jal7fgAe/3/kt3x0kjoYnPQmqGssmcFfP8HOzLxI2Wzae8f5pmWkscit+
         v0qT6Msl12yi012uKi/GtvmahTV2NhFLshaYD52R0IASs4J7UCrEtFwh8n2WdQ9tTdN8
         JbVGWRkoYqP7guSVYnYy/wjZopRuZkzVqdY0zTBzGaj6Mcx+OirXk9nhX1kPQMVBSrht
         GQiA==
X-Gm-Message-State: AOUpUlHhU+VUds/udr9PrPhD5IFRND/97ieM778wCKxtNoVBO797NhA4
        aQidik4keftYEO8iVd5x488=
X-Google-Smtp-Source: AAOMgpePxutfvZysOPuI2wVXGp7Q521ZoKtWXwKOYC89nhGm7TkfCp/y2NxWuVh7Q6J3Ob0FMcTXYw==
X-Received: by 2002:a1c:9616:: with SMTP id y22-v6mr100709wmd.72.1533150686331;
        Wed, 01 Aug 2018 12:11:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a5-v6sm299711wmf.3.2018.08.01.12.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 12:11:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: range-diff, was Re: What's cooking in git.git (Jul 2018, #03; Wed, 25)
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <87fu0469d1.fsf@evledraar.gmail.com>
        <xmqqd0v8oaf5.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1807301510370.10478@tvgsbejvaqbjf.bet>
        <xmqqwotcivco.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1808011800570.71@tvgsbejvaqbjf.bet>
Date:   Wed, 01 Aug 2018 12:11:25 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808011800570.71@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Wed, 1 Aug 2018 18:01:46 +0200 (DST)")
Message-ID: <xmqqd0v17vhe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> If any other issue arises, I do not mind taking an update, either,
>> but I think at this point the topic is reaching the point of
>> diminishing returns and should switch to incremental.
>
> Thomas had a couple of good suggestions, still, and I am considering to
> try to find time to simply disable the whitespace warnings altogether in
> range-diff.

OK, then I'll wait and refrain from merging this and other topics
that build on top for now.

