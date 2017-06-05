Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EFA71F7D2
	for <e@80x24.org>; Mon,  5 Jun 2017 18:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbdFESPl (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Jun 2017 14:15:41 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:38484 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbdFESPk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2017 14:15:40 -0400
Received: by mail-it0-f44.google.com with SMTP id r63so85688735itc.1
        for <git@vger.kernel.org>; Mon, 05 Jun 2017 11:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VX0drVm8yM2aOyznAMhOsrxZb+hlHqdHPV4H376jrnc=;
        b=qtEQ+RmzhjGr33XpGQSNmKboPzfB1d0ZujW0fjDgmNRlnmc5vLUhRztILNJLJg+JSt
         dyvK+HZXSKphED4DpNErYAI0rl5gL9A3HqRqdm1/EHeIfotFV94eA7EJERImnU4L+7bU
         mgiwq7hBdu6UCe5DbVzx84zHG9mxbd8c/l7KXoIKYnOqrKRzdVjwga/5ilXXq8rRRXzv
         aROlOQTcKbCrLNdG04orwJcsaKPOiDMPD6eieStAlUlr+cjWZutHrlItKVZon1ohHo3t
         +y9Md4M/xCrEdUDPqwlIqnKH9f2YAo0wCxKqIkKSyVV2G1cwPsgI33ZNPhUkuB+2Lu8m
         PpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VX0drVm8yM2aOyznAMhOsrxZb+hlHqdHPV4H376jrnc=;
        b=jELCoRHAqNbvE/gQWeuPGbvERQIqFcDDrSlpoX4qfPUouIMzXQVCgqkEmUC38gUwEP
         prC2F+fPB5pYHlyre+lXfZ1VUjvaBDfmFA/FK2Azf9I48Za2+u+YHHHk4o/Pvb0Wme1q
         F4znh1zZpoFx1z/Mp7pS4DmrlA7PILwMpRrykNsBI+ihNNC5W3UoJLZDGyRg4GvIuGHv
         7y5PquYodtNXjo5AvLwjY/HeDbhGz5Ft9GHIWYaHMsm/aIvVxYHVOjki+ALBN9JjkI/R
         bPQeRdXMMrAzgKWEt+0c2ycJg0va4FPUTHCg9lL206ZYnATRUSgjLIpUNLcS7771FlAK
         TalA==
X-Gm-Message-State: AODbwcAyXjRKNwqJkvBAJQwlowKf2kEiMzl8CetaCyTr7oU+i+G+nhLC
        feHskBgY5GAU+ZjQq2Q++7hgPq5hLg==
X-Received: by 10.36.233.198 with SMTP id f189mr12602197ith.94.1496686539165;
 Mon, 05 Jun 2017 11:15:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Mon, 5 Jun 2017 11:15:18 -0700 (PDT)
In-Reply-To: <1D06FFF7-C36D-4072-8B37-4C9DC45E4442@gmail.com>
References: <20170603221335.3038-1-avarab@gmail.com> <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
 <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com> <1D06FFF7-C36D-4072-8B37-4C9DC45E4442@gmail.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 5 Jun 2017 20:15:18 +0200
Message-ID: <CACBZZX5FP_jxXaT+NW8g2JqH89iYajHPjHhxCj=_vWnkxZ=rYQ@mail.gmail.com>
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 5, 2017 at 3:17 PM, Lars Schneider <larsxschneider@gmail.com> w=
rote:
>
>> On 04 Jun 2017, at 09:29, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab=
@gmail.com> wrote:
>>
>> On Sun, Jun 4, 2017 at 2:31 AM, Junio C Hamano <gitster@pobox.com> wrote=
:
>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> Speeding up the test suite by simply cataloging and skipping tests
>>>> that take longer than N seconds is a hassle to maintain, and entirely
>>>> skips some tests which would be nice to at least partially run,
>>>> e.g. instead of entirely skipping t3404-rebase-interactive.sh we can
>>>> run it for N seconds and get at least some "git rebase -i" test
>>>> coverage in a fast test run.
>>>
>>> I'd be more supportive to the former approach in the longer run for
>>> two reasons.
>>>
>>> Is it even safe to stop a test in the middle?  Won't we leave
>>> leftover server processes, for example?
>>>
>>>    I see start_httpd at least sets up "trap" to call stop_httpd
>>>    when the shell exits, so HTTP testing via lib-httpd.sh may be
>>>    safe.  I do not know about other network-y tests, though.
>>
>> When this flag is in effect and you run into the timeout the code is
>> semantically equivalent to not running subsequent test_expect_*
>> blocks, things like the trap in lib-httpd.sh will still run, so will
>> test_when_finished.
>>
>> Unless we have some test killing a daemon in a test_expect_success
>> block later in the test this'll work as intended.
>>
>>> Granted, when a test fails, we already have the same problem, but
>>> then we'd go in and investigate, and the first thing we notice would
>>> be that the old leftover server instance is holding onto the port to
>>> prevent the attempt to re-run the test from running, which then we'd
>>> kill.  But with this option, the user is not even made aware of
>>> tests being killed in the middle.
>>>
>>>> While running with a timeout of 10 seconds cuts the runtime in half,
>>>> over 92% of the tests are still run. The test coverage is higher than
>>>> that number indicates, just taking into account the many similar tests
>>>> t0027-auto-crlf.sh runs brings it up to 95%.
>>>
>>> I certainly understand that but in the longer term, I'd prefer the
>>> approach to call out an overly large test.  That will hopefully
>>> motivate us to split it (or speed up the thing) to help folks on
>>> many-core machines.
>>
>> The reason I didn't document this in t/README was because I thought it
>> made sense to have this as a mostly hidden feature that end users
>> wouldn't be tempted to fiddle with, but would be useful to someone
>> doing git development.
>>
>> Realistically I'm going to submit this patch, I'm not going to take
>> the much bigger project of refactoring the entire test suite so that
>> no test runs under N second, and of course any such refactoring can
>> only aim for a fixed instead of dynamic N.
>>
>> The point of this change is that I can replace running e.g. "prove
>> t[0-9]*{grep,log}*.sh" with just running the full test suite every
>> time, since 30s is noticeably slow during regular hacking but once
>> it's down to 15s it's perceptively fast enough.
>>
>> Reading between the lines in your reply, I think you're afraid that
>> regular users just testing git out will start using this, as opposed
>> to power user developers who understand the trade-offs. I think that's
>> mostly mitigated by not documenting it in t/README, but I could amend
>> the patch to add some scary commend to test-lib.sh as well.
>
> Maybe I am wrong here, but I would be very surprised if a "regular user"
> who does not dive into the Git source code would run the tests at all.
>
> Plus, wouldn't it make sense to mark tests that run longer than 10sec
> on average hardware with "GIT_TEST_LONG"? Wouldn't that solve your
> problem in a nice way?
>
> We could use TravisCI as baseline for "average hardware":
> https://travis-ci.org/git/git/jobs/239451918

There would be no point in marking the tests that take over 10s on
average hardware, and it's busywork to maintain those markers.

Also, as the numbers quoted in my patch show 10s is an arbitrary sweet
spot on that particular box, maybe it's 20s on some other hardware, or
5s if someone produces a 84 core box.

This patch is only something someone who has exceptional hardware
would care about. These long running tests in question don't have much
impact on the total CPU time spent on the test suite, the problem,
such as it is, is that they're not split up into more files, and thus
in a sufficiently beefy machine the entirety of the rest of the
parallel test suite can be over by the time these stragglers finish.

That's never going to be a problem on a less beefy machine with
--state=3Dslow,save, since the 30s test is going to be long over by the
time the rest of the tests run.

Cutting down on these long tail tests allows me to e.g. replace this:

    git rebase -i --exec '(make -j56 all && cd t && prove -j56 <some
limited glob>)'

With a glob that runs the entire test suite, with the rebase only
taking marginally longer in most cases while getting much better test
coverage than I'd otherwise bother with.
