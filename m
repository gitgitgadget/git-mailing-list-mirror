Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77CA61F4C0
	for <e@80x24.org>; Tue, 22 Oct 2019 19:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbfJVTP4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Oct 2019 15:15:56 -0400
Received: from mail-oi1-f176.google.com ([209.85.167.176]:35568 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfJVTP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Oct 2019 15:15:56 -0400
Received: by mail-oi1-f176.google.com with SMTP id x3so15219784oig.2
        for <git@vger.kernel.org>; Tue, 22 Oct 2019 12:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OGJRH8A3qmcFaU51hhHjQDUYLrA264s/UKlCRxvv5QY=;
        b=jHK1VsD86yp2dYOnAdYVE6uiHo+y+axmVMpSe18sTeMNszUJ1otJSoMiwy7oYq8Par
         OpfRW99Smp0giGgaljXbJKcT0kHTXGI11Eni08dNtaZWqbeMnk4oft1MRMV/mFCSPQRN
         vRZEwPSOEOuR3A8DGdIu7FzieDSePiOg+cnAT9zvSZwN/2LeLECXzOsHwOcq6jPXN2b5
         cqmk8n8/xPtdBVqyFahNoRJnG8G/arWS9WDt+TMA7wZA3Exg2TPMbvNQWIn4gYdIqxF9
         9X82tgnl35wLHVpCItqydIMKU/LSZ2rVo/QnjWRks10qlKu2vCRyv7/tBtO+BNv8yIyp
         o8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OGJRH8A3qmcFaU51hhHjQDUYLrA264s/UKlCRxvv5QY=;
        b=MA/PUJxfSBhsuMD6jddc+vvCwQYxsrThwhHh4d9yACdAeZdnSw3y62EsMVuwi69qZz
         pJLN1DN0AcQ5X1J/Ra9SMYDKHCjST3FBtTyF55L7dZg6B7Z9iCChpO4G13lcOPgEMsKL
         OBgtDEGFYXcOf25D1U7hn27umVHnvduCoaeAnj4ed3vaIPC/ClLkyXmPTryWzF9Pkxlu
         LYYWRmDh21AE1+CQl7BFFDqfSlPeBiHulGH5kWU8xvK5X1ghNQqaXA+hFBt6Hmf60HMD
         2F44wX36QgsQsRa4BnSHJ2NZTI79f/eyeQp5VfWp/qGUiRDZqralIzmHX0kZs6M6rFxL
         87cw==
X-Gm-Message-State: APjAAAXjNdpXUWOJXGxlEPc79nbPt3v6by9uf4QuZufYMbygPKCY6Hlk
        foTf7j4P+iinrWk78XULVLM85JmjW8crPBfiwU4=
X-Google-Smtp-Source: APXvYqx3E/ULw9z/HblfO/NLdjZuuL/6QJa0XDAd5V6UwBjuERhfXrlhtz4/meNgS97QqxqJ5nmMJbP+kWoJ6PbJBGU=
X-Received: by 2002:aca:dd02:: with SMTP id u2mr4393679oig.39.1571771753170;
 Tue, 22 Oct 2019 12:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet> <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910141211130.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 22 Oct 2019 12:15:41 -0700
Message-ID: <CABPp-BFYWhyLqUktEnk6A7v6135k4TQHO20Wiy32mRQekt-3cg@mail.gmail.com>
Subject: Re: [PATCH 2/2] merge-recursive: fix merging a subdirectory into the
 root directory
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the long delay before getting back to this; the other stuff
I was working on took longer than expected.

On Mon, Oct 14, 2019 at 3:42 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Sat, 12 Oct 2019, Elijah Newren wrote:
> > On Sat, Oct 12, 2019 at 1:37 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > For the record: I am still a huge anti-fan of splitting `setup` test
> > > cases from the test cases that do actual things, _unless_ it is
> > > _one_, and _only one_, big, honking `setup` test case that is the
> > > very first one in the test script.
[...]
> > The one thing I do agree with you on is test cases need to be
> > optimized for when they report breakages, but that is precisely what
> > led me to splitting setup and testing.
>
> To me, it is so not helpful _not_ to see the output of a `setup` that
> succeeded, and only the output of the actual test that actually failed.
>
> It removes context.
>
> I need to understand the scenario where the breakage happens, and the
> only way I can understand is when I understand the context.
>
> So the context needs to be as close as possible.

I've updated the patch series with a change that I hope helps while
still allowing the setup "steps" to be visibly differentiated from the
testing steps.

> > Way too many tests in the testsuite intersperse several setup and test
> > cases together making it really hard to disentangle, understand what
> > is going on, or even reverse engineer what is relevant.  The absolute
> > worst tests are the ones which just keep making additional changes to
> > some existing repo to provide extra setup, causing all sorts of
> > problems for skipping and resuming and understanding (to say nothing
> > of test prerequisites that aren't always met).
>
> I agree with this sentiment, and have to point out that this is yet
> another fallout of the way our test suite is implemented. If you look
> e.g. at JUnit, there are no "setup test cases". There are specific setup
> steps that you can define, there is even a teardown step you can define,
> and those individual test cases? They can run in parallel, or
> randomized, and they run in their own sandbox, to make sure that they
> don't rely on side effects of unrelated test cases.
>
> We don't do that. We don't enforce the absence of side effects, and
> therefore we have a megaton of them.
>
> But note how this actually speaks _against_ separating the setup from
> the test? Because then you _explicitly_ want those test cases to rely on
> one another. Which flies in the _face_ of trying to disentangling them.

I agree that it is desirable to avoid side effects in the tests, but
I'd like to point out that I'm not at all sure that your conclusion
here is the only logical one to draw here in comparing to JUnit.  As
you point out, JUnit has clearly delineated setup steps for a test (as
well as teardown steps), providing a place to keep them separate.  Our
testsuite lacks that, so how do folks try to get it?  One logical way
would be just inlining the setup steps in the test outside a
test_expect_* block (which has been done in the past), but that has
even worse problems.  Another way, even if suboptimal, is placing
those steps in their own test_expect_* block.  You say just throw the
setup and test together, but that breaks the separation.

I think it's a case of the testsuite not providing the right
abstractions and enough capability, leaving us to argue over which
aspects of a more featureful test harness are most important to
emulate.  You clearly picked one, while I was focusing on another.
Anyway, all that said, I think I have a nice compromise that I'll send
out with V2.

[...]
> > > Makes sense, but the part that I am missing is
> > >
> > >                 test_path_is_file bar.c.t
> > >
> > > I.e. the _most_ important outcome of this test is: the rename was
> > > detected, and the added file was correctly placed into the target
> > > directory of the rename.
> >
> > That's a useful thing to add to the test, I'll add it.  (It's kind of
> > included in the 'git hash-object bar.c.t' half a dozen or so lines
> > above, but this line helps document the expectation a bit better.)
> >
> > I'd be very reticent to include only this test_path_is_file check, as
> > it makes no guarantee that it has the right contents or that we didn't
> > also keep around another copy in a/b/bar.c.t, etc.
>
> I agree that it has to strike a balance. There are multiple aspects you
> need to consider:
>
> - It needs to be easy to understand what the test case tries to ensure.
>
> - While it is important to verify that Git works correctly, you do not
>   want to make the test suite so slow as to be useless. I vividly
>   remember how Duy mentioned that he does not have the time to run the
>   test suite before contributing. That's how bad things are _already_.

On this issue I'm having a harder time finding common ground.  Perhaps
there's something clever to be done, but I'm not seeing it.  I can at
least try to explain my perspective...

I understand you probably meant these two items as a non-exhaustive
list of things that need to be balanced, but you did omit what I feel
is the most important thing in the balance:

- The combination of tests should provide adequate confidence of
coverage that someone can refactor the code as necessary.

The tests in t6036, t6042, t6043, and t6046 are more defensive than
normal (defining "correct" behavior more finely-grained than usual),
but that came about precisely because it was so easy to make
refactoring mistakes that broke things in unexpected ways.  There have
been a handful of times already when I have gone in to refactor or fix
a reported bug, thought I had the right solution, and then only one or
maybe two tests failed and it was one of these tests and in particular
the "overzealous" portions of these tests that caught the bug (sorry I
don't still have details, I just remember being surprised and happy
about the extra defensiveness on multiple occasions).  Without this
extra defensiveness, there would have been extra bugs introduced that
I'm sure would have made it into real git releases.  So, there would
need to be a large pile of evidence and problems before I'd be willing
to take these out.

All that said...

I do very much agree with you that the overall testsuite needs to be
relatively speedy too, and that is an important counterbalance in
general.  But testsuite performance is somewhat of a red-herring in
this context: when running all testcases with 'merge' in their name
which I have contributed anything at all to (apparently 17 t[0-9]*.sh
files meet both these criteria), and running them in serial (no -j8 or
anything of the sort), they all combined complete in less than 40% of
the time that t9001-send-email.sh alone takes on my box.  It'd reduce
to barely over a quarter of the time that the send-email test takes if
it weren't for t3425-rebase-topology-merges.sh (which is the slowest
test with 'merge' in its name that I've touched, despite the fact that
it has none of this extra defensiveness you are complaining about and
labelling as unrelated).  Yes, t6043 is pretty long code-wise, and
still has over five dozen tests after ditching the separate "setup"
tests -- but all of those tests still run in 3.6s on my box.  I think
that a few extra calls to ls-files, rev-parse, hash-object and
test_path_is_missing are the wrong place to look if you're worried
about testsuite performance.

Finally, you also brought up "easy to understand" the test case.  You
are absolutely right that the extra calls to ls-files, rev-parse,
hash-object, test_path_is_missing do slow down an external reader and
almost certainly doesn't fit in your "within five seconds" goal you
mentioned below.  That's unfortunate.  But optimizing this at the
expense of preventing actual bugs that would have hit git.git releases
is a bad tradeoff and one I'm not willing to make.  If you want me to
restrict the extra defensiveness to just the merge-recursive tests,
I'm happy to do so.  I do agree that it's unusual, and probably should
be, but I think merge-recursive merits the special handling.


Hope that helps; thanks for all the feedback.

Elijah
