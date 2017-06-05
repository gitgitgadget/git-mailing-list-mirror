Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 653241F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 13:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdFENTH (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 09:19:07 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:35578 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751433AbdFENRo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 09:17:44 -0400
Received: by mail-wr0-f179.google.com with SMTP id q97so38074689wrb.2
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 06:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PabxP9BruOt270EK+506I6cJQhNDSzLSIkcGo5CT1gQ=;
        b=qTzNGRPP3qZ4WgMbj0l203G/SNW+VPR7xTw6nXlPUMOiQU9uv0CVy4Eninr6Rb5gtl
         veozB4ThhyrZCUKJEp5IhcfvIr3c5NJi3HRrCywRRkN/2Jha9l55VKTtPznGnwchoJBp
         bCkYgNdAH+e8dKKahPYDdZ8B4VTB1JrfkHGfy/akEjiKepzO9M28F9uSsfKpo1hTtDE6
         p7nf+DwfzGoQ6vEbFZl74z1YuBHHLSw5y71XM/5f14O/FHVZf1Bv1VwtkpL0GfOtUval
         mP64ewN2L2Q7tDaVBs0m34nxns03kTqZSVJYgxzvNt1/WRdfufhtDhcNarqVuO1RviAz
         ojyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=PabxP9BruOt270EK+506I6cJQhNDSzLSIkcGo5CT1gQ=;
        b=lUDDVnC88NISPgB69CyRvv7+fUvzt58u39BGGQtk33A4NG6SeqBrhU2UAVRNBt6ux2
         3eKTw34PC5/mqW2CNqzTCHsZwP8bfiUED/crmiKam1nbrigvVq+z9QyTfUJaLL8NBu7b
         3QEIQFkQtbnN78NiXOpRBS0ZuSm3LxJQ3TGeergFO92E+hrxc8D+V6pFuoK+zesffnBu
         WA1hXjT5DOnmdYDMvf33aacJjZjp/lQvGuIzoBWZgj1jZAk+bd6qnIo8pv1mTvcrMNvs
         /yRsvS3BArf4O67lM2WepI/pXBJxrZsOGpd4aKmNfUeEGhxVHciy91vdz/5zxWzcC88f
         dnNg==
X-Gm-Message-State: AODbwcBlITUF3npBElhrAOXSniLSuWdhB9qUHZLbX1Nzk6sU90LGcJkm
        6PCSzujQSPccaA==
X-Received: by 10.223.139.81 with SMTP id v17mr15522474wra.70.1496668648490;
        Mon, 05 Jun 2017 06:17:28 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB44EB.dip0.t-ipconnect.de. [93.219.68.235])
        by smtp.gmail.com with ESMTPSA id k53sm37849206wrc.10.2017.06.05.06.17.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Jun 2017 06:17:27 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
Date:   Mon, 5 Jun 2017 15:17:25 +0200
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1D06FFF7-C36D-4072-8B37-4C9DC45E4442@gmail.com>
References: <20170603221335.3038-1-avarab@gmail.com> <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com> <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
To:     =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 04 Jun 2017, at 09:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
> On Sun, Jun 4, 2017 at 2:31 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>=20
>>> Speeding up the test suite by simply cataloging and skipping tests
>>> that take longer than N seconds is a hassle to maintain, and =
entirely
>>> skips some tests which would be nice to at least partially run,
>>> e.g. instead of entirely skipping t3404-rebase-interactive.sh we can
>>> run it for N seconds and get at least some "git rebase -i" test
>>> coverage in a fast test run.
>>=20
>> I'd be more supportive to the former approach in the longer run for
>> two reasons.
>>=20
>> Is it even safe to stop a test in the middle?  Won't we leave
>> leftover server processes, for example?
>>=20
>>    I see start_httpd at least sets up "trap" to call stop_httpd
>>    when the shell exits, so HTTP testing via lib-httpd.sh may be
>>    safe.  I do not know about other network-y tests, though.
>=20
> When this flag is in effect and you run into the timeout the code is
> semantically equivalent to not running subsequent test_expect_*
> blocks, things like the trap in lib-httpd.sh will still run, so will
> test_when_finished.
>=20
> Unless we have some test killing a daemon in a test_expect_success
> block later in the test this'll work as intended.
>=20
>> Granted, when a test fails, we already have the same problem, but
>> then we'd go in and investigate, and the first thing we notice would
>> be that the old leftover server instance is holding onto the port to
>> prevent the attempt to re-run the test from running, which then we'd
>> kill.  But with this option, the user is not even made aware of
>> tests being killed in the middle.
>>=20
>>> While running with a timeout of 10 seconds cuts the runtime in half,
>>> over 92% of the tests are still run. The test coverage is higher =
than
>>> that number indicates, just taking into account the many similar =
tests
>>> t0027-auto-crlf.sh runs brings it up to 95%.
>>=20
>> I certainly understand that but in the longer term, I'd prefer the
>> approach to call out an overly large test.  That will hopefully
>> motivate us to split it (or speed up the thing) to help folks on
>> many-core machines.
>=20
> The reason I didn't document this in t/README was because I thought it
> made sense to have this as a mostly hidden feature that end users
> wouldn't be tempted to fiddle with, but would be useful to someone
> doing git development.
>=20
> Realistically I'm going to submit this patch, I'm not going to take
> the much bigger project of refactoring the entire test suite so that
> no test runs under N second, and of course any such refactoring can
> only aim for a fixed instead of dynamic N.
>=20
> The point of this change is that I can replace running e.g. "prove
> t[0-9]*{grep,log}*.sh" with just running the full test suite every
> time, since 30s is noticeably slow during regular hacking but once
> it's down to 15s it's perceptively fast enough.
>=20
> Reading between the lines in your reply, I think you're afraid that
> regular users just testing git out will start using this, as opposed
> to power user developers who understand the trade-offs. I think that's
> mostly mitigated by not documenting it in t/README, but I could amend
> the patch to add some scary commend to test-lib.sh as well.

Maybe I am wrong here, but I would be very surprised if a "regular user"
who does not dive into the Git source code would run the tests at all.

Plus, wouldn't it make sense to mark tests that run longer than 10sec=20
on average hardware with "GIT_TEST_LONG"? Wouldn't that solve your
problem in a nice way?

We could use TravisCI as baseline for "average hardware":
https://travis-ci.org/git/git/jobs/239451918

- Lars


