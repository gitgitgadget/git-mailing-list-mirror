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
	by dcvr.yhbt.net (Postfix) with ESMTP id 293801F45F
	for <e@80x24.org>; Fri, 10 May 2019 21:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbfEJV6D (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 17:58:03 -0400
Received: from mail-ed1-f44.google.com ([209.85.208.44]:39598 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbfEJV6D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 17:58:03 -0400
Received: by mail-ed1-f44.google.com with SMTP id e24so7021018edq.6
        for <git@vger.kernel.org>; Fri, 10 May 2019 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OHEAhJ0GEGOYeQh4MvGVadS/MJVmpj18NCtWcrxrQkE=;
        b=Oc4o3jW8fwSQq9fEU41+IWKyLTyM0ncWyQw5dC/85sZIkyGHXnV7uIWvE3ILY6AoQ0
         akSMdZWzU8tZsVVIkdO3lfz6FJ93ZAYqOcbk8kvwL3AP30DXllStgumObXR6rl/td/N1
         KLmReCfnGMk6AIiXzlkPAm9+35UqkethrTFJGPqJQEt0nfneojULrx/iiy02Nm/kqA7n
         tNG6OYMeIcXA1+nTZk5YenKpBNNEZzd9l6jdmOLLn2uTkJnjScjV6Y4CK2dc/A6MEF7X
         8mTt3lL7DaGQa7XI2M6dLqnR0oIK/xlN/ukz1GznVvgXNDa/6Rndrmkk7UNY5xMHfnfL
         G3ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OHEAhJ0GEGOYeQh4MvGVadS/MJVmpj18NCtWcrxrQkE=;
        b=DXN7ChVi3fXpGNrtqfICmcBuvsyViC0o6rcglHRjflHOb75Yh9xpIYWy1DahvhvMNp
         cHilvxJIB4QkLFsYslL9MIUNi+X7r0O5sIbROh5mxeMPsPcHphfLoB2RhDH6E1jt9aTA
         /408V/+kS+0wTowZpOpK7sn9qwlQA9byd8vOlVsUWtVDZfQOarDg9TuulTppS8W3bObT
         c8EVLdChJdjRDSnFGJ5EsfiBKmF1z+xpxCyFtUPWL17dzRuLTwl69VgjGMGHrc0BPqUg
         yVVqstLnPSWIX/TdDgslgcobPOdrQYqWHzN/GdHPKzQzaxcEtSnyxvMERvBy5Jk1INWA
         DOTQ==
X-Gm-Message-State: APjAAAVen3x3temUcjYcrIMbZ4bh8rqniiPuMRUlf4aT5Qgp3vMIIej5
        1GoHADfUg1BGbF9HO8KmMCQ=
X-Google-Smtp-Source: APXvYqzNliUr0mp37v4fim8+5/bsh4YgCiyb2MK2QandvAo0/6RdrPgC3nLNtR4AmFnDgg+/TyeeqQ==
X-Received: by 2002:a50:b614:: with SMTP id b20mr13830630ede.66.1557525481219;
        Fri, 10 May 2019 14:58:01 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u47sm1752055edm.86.2019.05.10.14.57.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 May 2019 14:57:59 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Josh Steadmon <steadmon@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: I made a flame graph renderer for git's trace2 output
References: <87zhnuwdkp.fsf@evledraar.gmail.com> <20190510210324.GA30947@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190510210324.GA30947@sigill.intra.peff.net>
Date:   Fri, 10 May 2019 23:57:58 +0200
Message-ID: <87y33evuop.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 10 2019, Jeff King wrote:

> On Fri, May 10, 2019 at 05:09:58PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> As noted in TODOs in the script there's various stuff I'd like to do
>> better, and this also shows how we need a lot more trace regions to get
>> granular data.
>
> Hmm. My gut reaction was: doesn't "perf record -g make test" already
> give us that granular data? I know "perf" isn't available everywhere,
> but the idea of the FlameGraph repo is that it takes input from a lot of
> sources (though I don't know if it supports any Windows-specific formats
> yet, which is presumably a point of interesting to trace-2 authors).
>
> But having generated such a flamegraph, it's not all that helpful. It
> mainly tells us that we spend a lot of time on fork/exec. Which is no
> surprise, since the test suite is geared not towards heavy workloads,
> but lots of tiny functionality tests.
>
> TBH, I'm not sure that flame-graphing the test suite is going to be all
> that useful in the long run. It's going to be heavily weighted by the
> types of things the test suite does. Flamegraphs are good for
> understanding where your time is going for a particular workload, but
> the workload of the test suite is not that interesting.
>
> And once you do have a particular workload of interest that you can
> replay, then I think the granular "perf" results really can be helpful.
>
> I think the trace2 flamegraph would be most useful if you were
> collecting across a broad spectrum of workloads done by a user. You
> _can_ do that with perf or similar tools, but it can be a bit awkward.
> I do wonder how painful it would be to alias "git" to "perf record git"
> for a day or something.

Yeah I should have mentioned that I'm mainly linking to the test suite
rendering as a demo.

My actual use-case for this is to see what production nodes are spending
their time on, similar to what Microsoft is doing with their use of this
facility.

The test suite serves as a really good test-case for the output, and to
stress-test my aggregation script, since we're pretty much guaranteed to
run all our commands, and cover a lot of unusual cases.

It also shows that we've got a long way to go in improving the trace2
facility, i.e. adding region enter/leave for some of the things we spend
the most time on.
