Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB861F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeBWX0p (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:26:45 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:38512 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752497AbeBWX0n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:26:43 -0500
Received: by mail-vk0-f53.google.com with SMTP id x135so6513871vkd.5
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=auifK/sGAR3Geprp5yV7XxQCVM0qFio2WFFckzaBPTM=;
        b=pMMIOfO2qmtCpeK5b9H9XuAD2jzoAoLnSDx8qgYw3TlegpDkk37CiOtMqKF/ngWNNM
         ovsd6IOCa2TnXATnghRECoCZW5mjluBqYfVWrnjBYFdIseQ9mPuPWwSyEHvdzh0lFE3n
         BFrzBnll8h27OJTME1+vXg9aZjpoFzAPojrgncHohMeXfVWZhCOyd3AJD3YOcRWIoYsD
         Ug8pNAtMsuAeJMDypYthF5xvAXvq9UeOPy6IaF/wvXDtDUja1wwozwtECIZhdcPVv9LO
         hi1uXg2ZcnPxfuk871zSpOmmkoyOlqiNmZFA/eMHjk5i0ty5DIEfDiWjC58OgTR5+FGr
         h+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=auifK/sGAR3Geprp5yV7XxQCVM0qFio2WFFckzaBPTM=;
        b=ablYjqr7rfZ/RKkJUgYGK2ieC8nSsTEsDDzbkAUzE98Fp/N9jqcpu/Ua/dnQg3AOz/
         f1vnPzwvr7SVcywh7bNYHYO622LCDr2GjpTHeq3Ncd8iz+7DHawkIoMzZvf5CLA8XP7O
         p4C4mh/9w6sf27CQEUOg4aS7tBluK59JbcHkizR4Iqz/WJUbV7Qo+iw0qHsasDeUe9Zy
         w/wIQbtEKMR/PzEgc1ljAFNfZUkv/hxCKqNZWytztWKG+FUkZMjOFnLWJ8T6h6MLzVN1
         XyI9wUi11n0qdezaE508u0GpU0iDMiUHfqxW1dPFTkV7YWFuzQMYG7/ZHw6GwH0SLcCr
         aPDQ==
X-Gm-Message-State: APf1xPDAN87/5YqxmQa9bWtz2/172fX5IwZE61EwV9G7c2gfarzGMc8u
        PQgdFN7kcA2R0xXgyxbWhrU6h+TK0oyvLz21d7yf+Q==
X-Google-Smtp-Source: AG47ELvkoNGbSdBap2+Yewzglvi3iqmcP1NC02TCk4FOlmzpx1Zzw+A9KBV7+C1extTU1PExq6U7CltRE1RnqgvOQbQ=
X-Received: by 10.31.223.135 with SMTP id w129mr2715968vkg.48.1519428402627;
 Fri, 23 Feb 2018 15:26:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.59.233 with HTTP; Fri, 23 Feb 2018 15:26:42 -0800 (PST)
In-Reply-To: <20180209142131.GA18701@sigill.intra.peff.net>
References: <20180209024235.3431-1-szeder.dev@gmail.com> <20180209024235.3431-3-szeder.dev@gmail.com>
 <20180209142131.GA18701@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Sat, 24 Feb 2018 00:26:42 +0100
Message-ID: <CAM0VKjnKg=e7ETeKFAmnEsU0thd7nLynyG7iAwUMycdZ91EpCA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t: teach 'test_must_fail' to save the command's
 stderr to a file
To:     Jeff King <peff@peff.net>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 9, 2018 at 3:21 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Feb 09, 2018 at 03:42:34AM +0100, SZEDER G=C3=A1bor wrote:
>
>> To check that a git command fails and to inspect its error message we
>> usually execute a command like this throughout our test suite:
>>
>>   test_must_fail git command --option 2>output.err
>>
>> Note that this command doesn't limit the redirection to the git
>> command, but it redirects the standard error of the 'test_must_fail'
>> helper function as well.  This is wrong for several reasons:
>>
>>   - If that git command were to succeed or die for an unexpected
>>     reason e.g. signal, then 'test_must_fail's helpful error message
>>     would end up in the given file instead of on the terminal or in
>>     't/test-results/$T.out', when the test is run with '-v' or
>>     '--verbose-log', respectively.
>>
>>   - If the test is run with '-x', the trace of executed commands in
>>     'test_must_fail' will go to stderr as well (except for more recent
>>     Bash versions supporting $BASH_XTRACEFD), and then in turn will
>>     end up in the given file.
>
> I have to admit that I'm slightly negative on this approach

Well, now I'm not just slightly negative, see the patch series I will
send out in a minute :)

> just
> because:
>
>   1. It requires every caller to do something special, rather than just
>      using normal redirection. And the feature isn't as powerful as
>      redirection. E.g., some callers do:
>
>        test_must_fail foo >output 2>&1

Yeah, they do, but most of the time they shouldn't.

I've looked at uses of 'test_must_fail cmd... 2>&1', and also uses of
other test helper functions with stderr duplicated from stdout (and a
couple of cases of "plain" 'git cmd ... 2>&1' as well; that's where the
t6300-for-each-ref fix came from some days ago).

I think all but one of those cases would benefit from handling stdout
and stderr separately, and that one exception shouldn't use
'test_must_fail' for a platform command in the first place[1].

  - Many of these tests check error messages after they mingled stderr
    and stdout like this:

      test_must_fail git cmd >out 2>&1 &&
      (test_i18n)grep "relevant part of the error msg" out

    In these cases there is no need for 2>&1 as they don't care about
    stdout at all.  They could just grep the failed command's stderr,
    with the added benefit that they would ensure that the error message
    indeed goes to stderr.

  - A couple of these tests check the output more strictly:

      test_must_fail git cmd >actual 2>&1 &&
      echo "error message" >expect &&
      test_(i18n)cmp expect actual

    which also checks that nothing was printed on stdout, but does so
    implicitly.  Considering all the sloppy uses of 2>&1, it's hard to
    tell whether it was deliberate to check the empty stdout, or
    accidental, because the writer of the test used 'test_cmp' instead
    of 'grep' for its verbosity on failure, or simply mixed up the two.
    Therefore, I think it's better when it's written more explicitly:

      test_must_fail git cmd >out 2>err &&
      echo "exact error message" >expect &&
      test_cmp expect err &&
      test_must_be_empty out

    ... both when reading such a test and when looking at it's output on
    failure.

  - Then there are some cases that, for some reason, completely silence
    a git command with:

      test_must_fail git cmd >/dev/null 2>&1

    The output of a command could turn out to be useful when debugging a
    failing tests, so tests shouldn't do this, unless there is a very
    good reason (e.g. the command produces a lot of output).


  - Finally, a few tests check that something is surely missing from a
    git command's output, both from stdout and stderr:

      test_must_fail git cmd >out 2>&1 &&
      ! grep "should not be there" out

    Or that a command is completely silent:

      test_must_fail git cmd --quiet >out 2>&1 &&
      test_must_be_empty out

    Checking the emptiness of stdout and stderr separately would give
    more info on failure, as it would tell us right away where the
    unexpected output is coming from (though arguably the presence of
    words like "error" or "fatal" in the output of 'test_must_be_empty'
    would be a dead giveaway).
    BTW, we already have a couple of careful tests that do:

      git cmd >out 2>err &&
      test_must_be_empty out &&
      test_must_be_empty err

    (Which makes me think that extending 'test_must_be_empty' to check
    the emptiness of multiple files at once would be worth it: fewer
    lines, fewer characters to type, and it could report all non-empty
    files, not just the first.)

>      But:
>
>        test_must_fail stderr=3Doutput foo >output
>
>      is not quite right (stdout and stderr outputs may clobber each
>      other, because they have independent position pointers).

Relying on the combination of the unbuffered stderr and the
block-buffered stdout could be fragile to begin with, though in general
it doesn't really cause troubles if the data on stdout is less than the
buffer size or if there's no output on stderr after the stdout buffer is
flushed.  The stdout buffer size is pagesize on Linux (I don't know
offhand about others), which is large enough compared to the typical
amount of output git commands produce in our test scripts, so we could
get away with it.

>   2. The "-x" problems aren't specific to test_must_fail at all. They're
>      a general issue with shell functions.

Sure.  I tried to address 'test_must_fail' first, because, with about
90% of the cases, it is by far the worst offender among all test helper
functions with redirected stderr.  'test_expect_code' comes in second
far behind, and there are a mere handful of the combination of
'test_terminal' and 'perl'.

The 'test_expect_code 129 ... 2>&1' in t0012-help.sh's row of '$builtin
can handle -h' tests is particularly interesting, because it hides the
inconsistency that 76 commands send their help/usage text to stdout,
while 45 to stderr.

> I'm not entirely happy with saying "if you want to use -x, please use
> bash". But given that it actually solves the problems everywhere with no
> further effort, is it really that bad a solution?

Well, not that bad a workaround, but in my opinion the real solution is
to make '-x' tracing work reliably with /bin/sh.

Since we strive for POSIX shell compatibility in our test scripts, I
dutifully run the test suite with /bin/sh.  Switching shells for '-x' to
get more info about what went wrong (and then switching back) is a
hassle even when it happens to work, and rather annoying when it
doesn't.  I've lost count of the various ways of running tests with '-x'
and Bash that I naively thought would Just Work, but didn't because of
the subtleties of GIT-BUILD-OPTIONS and/or re-exec in case of
'--verbose-log'.  I find I still reached for various ad-hoc
debugging/tracing or 'test_pause' first, and kept '-x' only as last
resort.

If we start running tests with '-x' and Bash on Travis CI, then it won't
be able to (semi-)automatically catch non-POSIX constructs entering the
test scripts.  And I do want to run all tests with '-x', to get the most
information about rarely occurring transient errors.


[1] - 't/lib-git-p4.sh' contains the following command:

        test_must_fail kill $pid >/dev/null 2>&1
