Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 498671F453
	for <e@80x24.org>; Tue, 12 Feb 2019 13:30:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfBLNah (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 08:30:37 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37912 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729532AbfBLNag (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 08:30:36 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so2693248wrw.5
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 05:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6WM+s9AUkg2j9hBS+LoVEkkPH2wiiWu3Vc+3KYKZMU0=;
        b=DjLmA/By2I1o4xl8r8CuO6IwIAwStH13JPLMiqbW4lZgGeLFgF00lVuReeGbinsdQu
         /tIsA6BLFODb4DG6ScU4SEFcm0yeDYOb9WJv/9/jBsCIu4UvdkQeyUgYLOBvEcbWZ7EF
         MgAF3LY7g9DLdqIVUH4el6nVLeNGHHUSAMcnIoSj3tmHyHE98JjkaZD7eBCJCxrq2YQM
         gFjogTpYxh8+yP4KRo9c/F5M6AKTKBu6drRTq3bW3JEXP20xkKp6cttqy5WFaioQbohj
         mp5goKfR60Rq6IwV/sbucIFnC9bBRgi+/FoBcyudQspTA+X6KHWOZbuuTeBJFoHsj/zK
         zntg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6WM+s9AUkg2j9hBS+LoVEkkPH2wiiWu3Vc+3KYKZMU0=;
        b=fjhhxWlvVcZ/rhLwyzwymEVvKa3cE+lpS42HGfSMqKeYMZfIUAErfxiRVWR1+8I2hR
         jFIfVJ20KO9HV/WWgzbdsvlVhGkToJd1Dnt8KA6qj5XT5a1JcxbQ5WdY98I369psSQmB
         cUAOVtUroIl3jOh5CJjMqheOFUo4lEAebmykTLS7tbnx0t7//Bqb/AIFS81jMJ230wO0
         yx71a8TG7IRqwuWq0XHCrgd9qrPYN18UIuB3PdYeJGTWnaEfW6kV4uR41U9AcEv5+wUg
         g70ma5juOBqKJkvy0/GNcDt75M/C+akQU3Q03FkGpgCU35Y2qJwP0lflt+pBoVG58/O0
         py2A==
X-Gm-Message-State: AHQUAubGQH1KzWejpgROpwM6UdXUW4oeltHbHZ5Ayja2EV+Rj4LjSGWz
        JzZiWsFpws6r8NZtncPeKIc=
X-Google-Smtp-Source: AHgI3IbqJwWQMZ2xtfPlBAaR13ZN5eLJG3DwVI8QNH9IWU5zVAHf5o+LzXvAlRDdGXJR26zcTeIxsA==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr2949679wrx.85.1549978235029;
        Tue, 12 Feb 2019 05:30:35 -0800 (PST)
Received: from szeder.dev (x4dbd7e49.dyn.telefonica.de. [77.189.126.73])
        by smtp.gmail.com with ESMTPSA id c18sm19678751wre.32.2019.02.12.05.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 05:30:34 -0800 (PST)
Date:   Tue, 12 Feb 2019 14:30:32 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Git v2.21.0-rc0 broken on *BSD, maybe others
Message-ID: <20190212133032.GG1622@szeder.dev>
References: <xmqqh8dgqcqn.fsf@gitster-ct.c.googlers.com>
 <87sgwtjjbk.fsf@evledraar.gmail.com>
 <20190212124323.GA11677@ash>
 <CACsJy8D-FVGXHbqKf8BAVWEFchbF5LAN6x8UM5g7v_HLO29CLQ@mail.gmail.com>
 <87pnrxjghb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pnrxjghb.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 12, 2019 at 02:14:56PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Feb 12 2019, Duy Nguyen wrote:
> 
> > On Tue, Feb 12, 2019 at 7:43 PM Duy Nguyen <pclouds@gmail.com> wrote:
> >> The test failures on NetBSD and Solaris/Sparc, not sure if we can do
> >> anything without test logs or access to these systems.
> >
> > Actually if you could tweak your ci script a bit to run tests with -v,
> > that would help.
> 
> I vaguely remember doing that and running into some issue where it
> truncated the output, so e.g. I wouldn't see compile warnings on AIX
> because of the firehose of subsequent test output.
> 
> But yeah, having this in some smart way would be great. I'd be most keen
> to just work towards offloading this to some smarter test runner as
> noted to Johannes upthread.
> 
> I.e. a good test_for(SHA1, params) function would run the tests with
> "prove", and e.g. spot that tests so-and-so failed, and then run those
> specific ones with -v -x.

Just follow suit of what we have been doing on Travis CI since the
very beginning: run tests with '--verbose-log' to begin with, and then
dump the logfiles of any failed tests, i.e. where the content of
'test-results/t1234-foo.exit' is not '0'.

Re-running a failed test is not a good idea, as it won't help if the
test managed to fail because of a rare flakiness.


> That's how I was going to fix the log overflow problem, but I'd much
> rather not continue hacking on this gitlab-gccfarm-specific thing, and
> instead work towards something more general.
