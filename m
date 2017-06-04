Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 194EC1F7D2
	for <e@80x24.org>; Sun,  4 Jun 2017 07:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751147AbdFDH3p (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Jun 2017 03:29:45 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36430 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751027AbdFDH3o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Jun 2017 03:29:44 -0400
Received: by mail-it0-f45.google.com with SMTP id m47so38566526iti.1
        for <git@vger.kernel.org>; Sun, 04 Jun 2017 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FbPJM7OKMdufsOqwf+95bBLkENttNZa0fOh03XKjlgo=;
        b=fvXQm2GKGwnQ4rLhg0PidDWlr9l8XZhXkypQ32qWNIuq9kphvU+2Y3zkJDqKQ2ZqIi
         k9ZY+Tr8AwJFDejcey9VvVQQ/vUJXgFA23aUFJIU+KvHU2VHT3sIoPj6TkHJGOKpp4ti
         dJBx3ZZ8pIdnUhMzT6BOThkACP31fA5sAkt10IbqesKJtn6yiOtzCuAoWjeYSivShudk
         jq5qKg9qKxLMAa0Mr6FEQWpAVFuOrpo1o0U6P2TjS3eG5Ty4+EYMWefuO6JH3Bha46K3
         6tphz03M14Ra3oebm89ZHN1lxobzU7rdQid0dxGsYyMdEn8yMLweiG8e+w50cm8gwyGG
         FgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FbPJM7OKMdufsOqwf+95bBLkENttNZa0fOh03XKjlgo=;
        b=iiwNB9Un4iWp6fD8Q/SsrteGEVNspod52IWvdClTd2ciP0/uPYL8YbmzhyPfICcu6K
         mqwJbAzRncUM3YevlrBlRZdHAJeaskunr1A4G0ZQIFCen9BAOsTrA/0arsqUFv1x3DoE
         ojwfCzBCY8CnMx82oeDwr+BEFC2IBgb7eAvCAN6uQAj3ZF0A5h7QDspP3z2HvQCfyKZ7
         etvi+858vt2olwb1wRci9H0XfFfPPDgluU0CRZJ5W1n66kc6lX+Ndds7Q6j/Sp+AyhyT
         OMiK+pN8FFT5AS9qtlnMf3qWcT7Wdoe6s2ww/altc4BOqSOoH5R1gyZermCJqPWNwyyp
         Tyog==
X-Gm-Message-State: AODbwcDy5ab0IH3WhfVurIuRMEXlBa1GOwXu+d+d+ajfc657CBpb0ej9
        /BJ0QCw0Ahr2TlIV2X1yKuwYdxPmWksP5ck=
X-Received: by 10.36.91.212 with SMTP id g203mr6282089itb.94.1496561382977;
 Sun, 04 Jun 2017 00:29:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.3.231 with HTTP; Sun, 4 Jun 2017 00:29:22 -0700 (PDT)
In-Reply-To: <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
References: <20170603221335.3038-1-avarab@gmail.com> <xmqqa85owq3b.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 4 Jun 2017 09:29:22 +0200
Message-ID: <CACBZZX5_AYOXZMrgVZuERzOdzntw0ec36bKS5mcKT510cC3Y2g@mail.gmail.com>
Subject: Re: [PATCH] test-lib: add ability to cap the runtime of tests
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 4, 2017 at 2:31 AM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Speeding up the test suite by simply cataloging and skipping tests
>> that take longer than N seconds is a hassle to maintain, and entirely
>> skips some tests which would be nice to at least partially run,
>> e.g. instead of entirely skipping t3404-rebase-interactive.sh we can
>> run it for N seconds and get at least some "git rebase -i" test
>> coverage in a fast test run.
>
> I'd be more supportive to the former approach in the longer run for
> two reasons.
>
> Is it even safe to stop a test in the middle?  Won't we leave
> leftover server processes, for example?
>
>     I see start_httpd at least sets up "trap" to call stop_httpd
>     when the shell exits, so HTTP testing via lib-httpd.sh may be
>     safe.  I do not know about other network-y tests, though.

When this flag is in effect and you run into the timeout the code is
semantically equivalent to not running subsequent test_expect_*
blocks, things like the trap in lib-httpd.sh will still run, so will
test_when_finished.

Unless we have some test killing a daemon in a test_expect_success
block later in the test this'll work as intended.

> Granted, when a test fails, we already have the same problem, but
> then we'd go in and investigate, and the first thing we notice would
> be that the old leftover server instance is holding onto the port to
> prevent the attempt to re-run the test from running, which then we'd
> kill.  But with this option, the user is not even made aware of
> tests being killed in the middle.
>
>> While running with a timeout of 10 seconds cuts the runtime in half,
>> over 92% of the tests are still run. The test coverage is higher than
>> that number indicates, just taking into account the many similar tests
>> t0027-auto-crlf.sh runs brings it up to 95%.
>
> I certainly understand that but in the longer term, I'd prefer the
> approach to call out an overly large test.  That will hopefully
> motivate us to split it (or speed up the thing) to help folks on
> many-core machines.

The reason I didn't document this in t/README was because I thought it
made sense to have this as a mostly hidden feature that end users
wouldn't be tempted to fiddle with, but would be useful to someone
doing git development.

Realistically I'm going to submit this patch, I'm not going to take
the much bigger project of refactoring the entire test suite so that
no test runs under N second, and of course any such refactoring can
only aim for a fixed instead of dynamic N.

The point of this change is that I can replace running e.g. "prove
t[0-9]*{grep,log}*.sh" with just running the full test suite every
time, since 30s is noticeably slow during regular hacking but once
it's down to 15s it's perceptively fast enough.

Reading between the lines in your reply, I think you're afraid that
regular users just testing git out will start using this, as opposed
to power user developers who understand the trade-offs. I think that's
mostly mitigated by not documenting it in t/README, but I could amend
the patch to add some scary commend to test-lib.sh as well.

> I am afraid that the proposed change will disincentivize that by
> sweeping the problematic ones under the rug.  Perhaps you can
> collect what tests are terminated in the middle because they run for
> too long and show the list of them at the end, or something?

This change incentivizes  me to be regularly running a larger % of the
full test suite.

Collecting the skipped ones is easy enough to do with a grep + for
loop, so I don't think it's worth making the implementation more
complex to occasionally answer the question of how many tests were
skipped due to running into the timeout:

$ rm .prove; for t in 20 10 5 1; do printf "%s\t" $t && (time
GIT_TEST_TIMEOUT=3D$t prove -j$(parallel --number-of-cores)
--state=3Dslow,save -v t[0-9]*.sh) 2>&1 | grep -c "Exceeded
GIT_TEST_TIMEOUT"; done
rm: cannot remove =E2=80=98.prove=E2=80=99: No such file or directory
20      4
10      36
5       80
1       509

Of course that gives you "how many tests had skipped tests", now how
many test_expect_* blocks were skipped. An earlier WIP version of this
did the former, but e.g. running the rest of t0027-auto-crlf.sh took
many seconds just do spew out hundreds/thousands of lines in a shell
loop emitting "skip" lines, so I went with the to_skip=3Dall
implementation.

> Also, I thought that it was a no-no to say "to_skil=3Dall" with
> skipped-reason in the middle of a test when the test is run under
> prove?

TAP has two main modes of operation, you can either declare that
you're going to run N tests in advance and then you must run N, this
makes prove report progress on your tests as they run.

Or you can just run in a mode where you stream out however many tests
you're going to run as you go along, and then print "1..NUM_TESTS" at
the end.

We use the latter, so we can abort the entire test suite at any time
with test_done, that's what this change does.

> Oh, by the way, is "date +%s" even portable?  I thought not.

The lib-git-p4.sh lib says not, and shells out to python's time() is a
workaround, I could replace this with perl -e 'print time', but
thought it wasn't worth bothering with for an obscure optional feature
like this.

Since 6a9d16a0a8 ("filter-branch: add passed/remaining seconds on
progress", 2015-09-07) git-filter-branch relies on `date +%s`.

I suspect Solaris users are just setting a GNU/updated toolpath in
their $PATH, and worrying about this isn't worth bothering with,
especially for this sort of thing.
