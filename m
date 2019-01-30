Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A97C71F453
	for <e@80x24.org>; Wed, 30 Jan 2019 13:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbfA3NId (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 08:08:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40216 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbfA3NId (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jan 2019 08:08:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so25993227wrt.7
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 05:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=4gGrYkMOAGJWxwOv2mo/uXBieMZ/WzpCV5ZxgxvomvM=;
        b=DZ59zRyYWSrat5Un/CfkSjyS/qMAfMruZbotaBQXHJKTdj22wsKaU5GMGE7C/y6g8D
         9c+tDB3TLaV+ieru1o5SiVCJjzzndOZWh8aJzekTtLBJS3t7wri9YXgFndNj54XpV6Yg
         d98n9i6BmQlNtWbWOTyl+3tePNhwxQ/8Rx5Aif4Kd9pVHvWQOUXviMKnoLLFJ9pM9k+r
         0xOgHY296SzK66KQ3MdjNp9VRQ6bG+hc6kFB1n875lmVdq4E5V6FnEnjIyTzgkpd6gFn
         x5mAzgFSUfdGYOFAYPKTx6V7rlGqO4UVGEcdlIt4DAJwfLD7kJTlVqxhCXVPdYXSTTOp
         nxDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=4gGrYkMOAGJWxwOv2mo/uXBieMZ/WzpCV5ZxgxvomvM=;
        b=VVJsZcHT8anAUbHJGLeBxjHpzv+ue4TG95uO9oHokf7SpFef2JYtd1zojyH6HCZ1Ro
         li9z+PooASnihqm0hwimWhADMixOQK+k8L7vjrdeUytbDaSu70Ctferm1L9SjJPbfGWC
         z14hpfNa2vDeepCWNlxBWtMpauYtMIPdpysTSFWJCeg3k4eQ54NmQX+xHRb5dAL5ENHQ
         BnW7NsqJtgGOvnE7mQka4TnjV5AYAHjQyEMCXCygn7nTZW60zOoZuvoGyUfI1mRVegj4
         GDQHLEcMnTJ6v73tMIg8qTkbEba5i65tkEW549nUX6z0Klho6HeQM4AhrAfLLUI9Dj2I
         2TvA==
X-Gm-Message-State: AJcUukc/UhjkmzwhC9453iwDQz5EMs6sBA0NcDGQIpv04oIPzqnB5EEG
        eHB94nfDpjInA3pI22SbjDg=
X-Google-Smtp-Source: ALg8bN5RcP5onGEe3OzdH5632cFNUgZlYZ7kXS6mY8Em0XB09cYcHLSN7hY6/GbrgbUINKYJAGE1Kg==
X-Received: by 2002:a5d:6105:: with SMTP id v5mr29359653wrt.63.1548853710522;
        Wed, 30 Jan 2019 05:08:30 -0800 (PST)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id t4sm708853wrm.6.2019.01.30.05.08.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 05:08:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
References: <pull.114.git.gitgitgadget@gmail.com> <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com> <20190129160030.GA7083@sigill.intra.peff.net> <87zhrj2n2l.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1901301317120.41@tvgsbejvaqbjf.bet>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <nycvar.QRO.7.76.6.1901301317120.41@tvgsbejvaqbjf.bet>
Date:   Wed, 30 Jan 2019 14:08:28 +0100
Message-ID: <87y3722sz7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 30 2019, Johannes Schindelin wrote:

> Hi =C3=86var,
>
> On Tue, 29 Jan 2019, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> On Tue, Jan 29 2019, Jeff King wrote:
>>
>> > On Tue, Jan 29, 2019 at 06:56:08AM -0800, Derrick Stolee via
>> > GitGitGadget wrote:
>> >
>> >> From: Derrick Stolee <dstolee@microsoft.com>
>> >>
>> >> When running the test suite for code coverage using
>> >> 'make coverage-test', a single test failure stops the
>> >> test suite from completing. This leads to significant
>> >> undercounting of covered blocks.
>> >>
>> >> Add two new targets to the Makefile:
>> >>
>> >> * 'prove' runs the test suite using 'prove'.
>> >>
>> >> * 'coverage-prove' compiles the source using the
>> >>   coverage flags, then runs the test suite using
>> >>   'prove'.
>> >>
>> >> These targets are modeled after the 'test' and
>> >> 'coverage-test' targets.
>> >
>> > I think these are reasonable to have (and I personally much prefer
>> > "prove" to the raw "make test" output anyway).
>>
>> I wonder if anyone would mind if we removed the non-prove path.
>>
>> When I added it in 5099b99d25 ("test-lib: Adjust output to be valid TAP
>> format", 2010-06-24) there were still some commonly shipped OS's that
>> had a crappy old "prove", but now almost a decade later that's not a
>> practical problem, and it's installed by default with perl, and we
>> already depend on perl for the tests.
>
> It's not only about crappy old `prove`, it is also about requiring Perl
> (and remember, Perl is not really native in Git for Windows' case;

We require perl now for testing, NO_PERL is just for the installed
version of git. If you change the various test-lib.sh and
test-lib-functions.sh that unconditionally uses "perl" or "$PERL_PATH"
hundreds/thousands (didn't take an exact count, just watched fail scroll
by) tests fail.

So my assumption is that anyone running the tests now has perl anyway,
and thus a further hard dependency on it won't hurt anything.

> I still have a hunch that we could save on time *dramatically* by
> simply running through regular `make` rather than through `prove`).

My hunch is that on the OS's where this would matter (e.g. Windows) the
overhead is mainly spawning the processes, and it doesn't matter if it's
make or perl doing the spawning, but I have nothing to back that up...

> I did start to implement a parallel test runner for use with BusyBox-based
> MinGit, but dropped the ball on that front before I could satisfy myself
> that this is robust enough. Once it *is* robust enough, we could even
> replace the entire `prove` support with a native, test-tool driven test
> framework.

Let's be clear about what "prove support" means.

When I added support for "prove" I was really adding support for TAP
which is a standardized test output protocol: https://testanything.org/

It just so happens that "prove" is the most ubiquitous implementation,
but there's plenty of others: https://testanything.org/consumers.html

So hard-depending on "prove" in no way ties us to that particular tool
forever. We'd just do away with ferrying information via a side-channel
(*.counts files) that we also get from its output.

>> I don't feel strongly about it, but it would allow us to prune some
>> login in the test library / Makefile.
>>
>> Maybe something for a show of hands at the contributor summit?
>
> Sure, let's put it up for discussion.

*Nod*
