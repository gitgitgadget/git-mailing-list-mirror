Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE6A01F4C0
	for <e@80x24.org>; Sun, 13 Oct 2019 00:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbfJMAki (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 20:40:38 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38276 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbfJMAki (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 20:40:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id 107so4068710uau.5
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 17:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6iaLXDSsQgDRcCtwcJOQmQG75gwNVXlBNjlckh7YduM=;
        b=fsyA2P5/hkPL8sh5kt67HYRcBSzCXVoAQ/F4QZgB4Mcp5Q0+eg5qhjQfwUjk7IEP7g
         jBvkGLzl061ePjv612bttgHFRCvzKWtQZAFlyES9aL9PsAk6O72rkJEXWunJDeu+kJ0e
         ZdsfIGjBFVYcLP9KL7gipD8FRsF5+d1CYAIN09uebLnH0IEcZCrwtAcHVrys4MLT2q2j
         5rutvj1544wbE/clUQDo/uWh3UodktB+t49WMU8T43QUU6xhNEaNZ1JJmpfdsTWK3W4l
         8YpjkfTt3wAGMHzkCEWKLOZgXeRf8wO7i56ZlqN92JBNFmGnvz32SoobtH98lQrqzppD
         LcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6iaLXDSsQgDRcCtwcJOQmQG75gwNVXlBNjlckh7YduM=;
        b=BXzA0GvcparDunxP4oKMCmEM/mlEaR0Dt9KEL4Vgb/LqTXVncg0N2cgO3O3m+nb3aa
         jIZ4l957gWTKhxZAaVL3VgFrvyyTSfLLk0ZDTwj3rv36RLwOg7JKp5zXPZy9y+gS412G
         8yZy1vXUA6kl6OxEkUT0bUhSWnso3iUPHrns2Vvv4oIfKeWTc4pWMo4mKD+VYEWBB4QA
         Y8SE1a8zuIohYql3rgulMx0fXoicjAF2OU/UPdgcD/2+Y1bhjBrOoO3ldNjwRpT5DRQW
         hqdVKls4xjVGAo/Zn5domcyxmMHkiqLQZvZ5a2D4uHObeWBOpscbHfeNeEkkriKlKR3s
         yoHw==
X-Gm-Message-State: APjAAAX1mdnQqKfvtT6XBndZ4vuR5JpM6Z+Kl5pKENrqfLVAXGoHv8BA
        yAc5laSXQCA17xiq9KbUjg6i11llivwCurGlCkk=
X-Google-Smtp-Source: APXvYqxX8KjJzzti2vLD6bIHgZ2iw4QeF4k+um/W5brAbw9SaAxmnwPNVQ1Wect9QDO60NcDkCe4S4W8uqdblgWd12I=
X-Received: by 2002:ab0:6791:: with SMTP id v17mr12311562uar.81.1570927236711;
 Sat, 12 Oct 2019 17:40:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.390.git.gitgitgadget@gmail.com> <37aee862e14b1352eb08485f15ea06bab33679df.1570826543.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910122152210.3272@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Oct 2019 17:40:25 -0700
Message-ID: <CABPp-BFNCLJnt4NgFKVxURBGD1Z00gastc5q4ZPjcHmwS=kuFw@mail.gmail.com>
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

Hi Dscho,

Thanks for the reviews!

On Sat, Oct 12, 2019 at 1:37 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> On Fri, 11 Oct 2019, Elijah Newren via GitGitGadget wrote:
>
[...]
> > @@ -1980,6 +1990,25 @@ static void get_renamed_dir_portion(const char *old_path, const char *new_path,
> >           *end_of_old == *end_of_new)
> >               return; /* We haven't modified *old_dir or *new_dir yet. */
> >
> > +     /*
> > +      * If end_of_new got back to the beginning of its string, and
> > +      * end_of_old got back to the beginning of some subdirectory, then
> > +      * we have a rename/merge of a subdirectory into the root, which
> > +      * needs slightly special handling.
> > +      *
> > +      * Note: There is no need to consider the opposite case, with a
> > +      * rename/merge of the root directory into some subdirectory.
> > +      * Our rule elsewhere that a directory which still exists is not
> > +      * considered to have been renamed means the root directory can
> > +      * never be renamed (because the root directory always exists).
> > +      */
> > +     if (end_of_new == new_path &&
> > +         end_of_old != old_path && end_of_old[-1] == '/') {
> > +             *old_dir = xstrndup(old_path, end_of_old-1 - old_path);
> > +             *new_dir = xstrndup(new_path, end_of_new - new_path);
>
> However, here we write something convoluted that essentially amounts to
> `xstrdup("")`. I would rather have that simple call than the convoluted
> one that would puzzle me every time I have to look at this part of the
> code.

Makes sense; I can switch it over.

>
> While at it, would you mind either surrounding the `-` and the `1` by
> spaces, or even write `--end_of_old - old_path`?

Sounds good to me; I'll make the change.


> > diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> > index c966147d5d..b920bb0850 100755
> > --- a/t/t6043-merge-rename-directories.sh
> > +++ b/t/t6043-merge-rename-directories.sh
> > @@ -4051,6 +4051,62 @@ test_expect_success '12c-check: Moving one directory hierarchy into another w/ c
> >       )
> >  '
> >
> > +# Testcase 12d, Rename/merge of subdirectory into the root
> > +#   Commit O: a/b/{foo.c}
> > +#   Commit A: foo.c
> > +#   Commit B: a/b/{foo.c,bar.c}
> > +#   Expected: a/b/{foo.c,bar.c}

Note the nice explanation of the testcase setup at the beginning of
every test within this file...

> > +
> > +test_expect_success '12d-setup: Rename (merge) of subdirectory into the root' '
> > +     test_create_repo 12d &&
> > +     (
> > +             cd 12d &&
> > +
> > +             mkdir -p a/b/subdir &&
> > +             test_commit a/b/subdir/foo.c &&
>
> Why `.c`? That's a little distracting.

I can toss it.

> > +
> > +             git branch O &&
>
> Might be simpler just to use `master` subsequently and not "waste" a new
> ref on that.

I could do so, but then this makes the testcase description comment
earlier harder to read comparing "master", "A", and "B".  Having the
same length simplifies it a bit, and the triple of O, A, and B are
also used quite a bit in merge-recursive.c (e.g. in process_entry()
and merge_threeway() and other places).

Also, behaving differently for this test than the other 50+ tests in
the testfile would break the comment at the beginning of t6043 which
explains how *every* test in the file is of a certain form, using O,
A, and B.

>
> > +             git branch A &&
>
> Might make more sense to create it below, via the `-b` option of `git
> checkout`.
>
> Or, for extra brownie points, via the `-c` option of `git switch`.
>
> > +             git branch B &&
>
> Likewise, this might want to be created below, via replacing `git
> checkout B` with `git switch -c B master`.

I'm not sure I see why it'd be beneficial to switch this, though in
isolation I also don't see any drawbacks with your suggestion either.
It looks entirely reasonable, so I'd probably just do it if it weren't
for the fact that there are four dozen or so other tests in the same
file that already do it this way.  I'd rather keep the file internally
consistent, and there's a bit too much inertia for me to want to
switch all the tests over...unless you can provide a reason to
strongly prefer one style over the other?

> > +
> > +             git checkout A &&
> > +             mkdir subdir &&
> > +             git mv a/b/subdir/foo.c.t subdir/foo.c.t &&
> > +             test_tick &&
> > +             git commit -m "A" &&
> > +
> > +             git checkout B &&
> > +             test_commit a/b/bar.c
> > +     )
> > +'
> > +
> > +test_expect_success '12d-check: Rename (merge) of subdirectory into the root' '
>
> For the record: I am still a huge anti-fan of splitting `setup` test
> cases from the test cases that do actual things, _unless_ it is _one_,
> and _only one_, big, honking `setup` test case that is the very first
> one in the test script.
>
> Splitting things into two inevitably leads to unnecessary churn when
> investigating test failures.
>
> And that's really what test cases need to be optimized for: when they
> report breakages. They need to help as much as they can to investigate
> why things break. Nobody cares when test cases succeed. The ~150k test
> cases that pass on every CI build: nobody is interested. When a test
> case reports failure, that's when people pay attention. At least some,
> including me.
>
> The most common case for me (and every other lazy person who relies on
> CI/PR builds) is when a build breaks, and then I usually get to the
> trace of the actually failing test case very quickly. The previous test
> case's trace, not so easy. Clicks involved. Now I lose context. Not
> good.
>
> A less common case for me is when I run test scripts locally, with `-i
> -v -x`. Still, I need to scroll back to get context. And then, really, I
> already lost context.

I guess we have some strongly differing opinions here.  The one thing
I do agree with you on is test cases need to be optimized for when
they report breakages, but that is precisely what led me to splitting
setup and testing.  Way too many tests in the testsuite intersperse
several setup and test cases together making it really hard to
disentangle, understand what is going on, or even reverse engineer
what is relevant.  The absolute worst tests are the ones which just
keep making additional changes to some existing repo to provide extra
setup, causing all sorts of problems for skipping and resuming and
understanding (to say nothing of test prerequisites that aren't always
met).  But the ones with one big honking `setup` test case that is the
very first one in the test script can often be pretty bad too when
you've found a bug in testcase 82 and want to have a simple way to
reproduce.  It's awesome when someone can just run ./testcase.sh --ver
--imm -x --run=86,87 and reproduce the problem.  It feels sadly rare
to be able to do that in much of git.git's testsuite.  Not accreting
ever more changes into a repo to setup subsequent problems, using
entirely separate repos for different cases where testing makes any
changes, making it clear what is setup, making it clear what's the
command being tested, and making it clear what all the commands are
that are testing that the original test command produced the expected
behavior all go a long way to making things way easier to investigate.

Now, I will re-use a setup case for multiple tests and even did so in
t6043, but only when the setup really is identical (e.g. not only are
the tests expecting an identical setup, but the commands being tested
are read-only or any changes they make are unconditionally reverted as
the last step of the testcase).  Naturally, when I re-use a setup
block multiple times, I really don't want to copy the setup into each
of those tests either.

It would be really nice, though, if there were some way for me to
specify that a given "testcase" was just setup (so that they don't
even get a number in the prove output and don't count as a "test"
except maybe when they fail), and if there were some way to specify
which testcases depend on which setup blocks (so that if I want to run
just a given test, the setup test gets automatically included).


Your example of CI/PR builds makes sense to me, and I really would
like to make that nicer and improve other workflows too, especially if
it can be done without breaking my ability to investigate test
failures.  If someone can think of a clever way to do that (e.g. some
way of implementing my "It would be really nice" in the last
paragraph, and in a way that could also benefit CI/PR builds), I'd be
happy to go through and help switch things over.

> > +     (
> > +             cd 12d &&
> > +
> > +             git checkout A^0 &&
> > +
> > +             git -c merge.directoryRenames=true merge -s recursive B^0 &&
> > +
> > +             git ls-files -s >out &&
> > +             test_line_count = 2 out &&
>
> Isn't this a bit overzealous?
>
> > +
> > +             git rev-parse >actual \
> > +                     HEAD:subdir/foo.c.t   HEAD:bar.c.t &&
> > +             git rev-parse >expect \
> > +                     O:a/b/subdir/foo.c.t  B:a/b/bar.c.t &&
> > +             test_cmp expect actual &&
>
> Likewise?
>
> > +
> > +             git hash-object bar.c.t >actual &&
> > +             git rev-parse B:a/b/bar.c.t >expect &&
> > +             test_cmp expect actual &&
>
> Likewise?
>
> > +
> > +             test_must_fail git rev-parse HEAD:a/b/subdir/foo.c.t &&
> > +             test_must_fail git rev-parse HEAD:a/b/bar.c.t &&
> > +             test_path_is_missing a/
>
> Makes sense, but the part that I am missing is
>
>                 test_path_is_file bar.c.t
>
> I.e. the _most_ important outcome of this test is: the rename was
> detected, and the added file was correctly placed into the target
> directory of the rename.

That's a useful thing to add to the test, I'll add it.  (It's kind of
included in the 'git hash-object bar.c.t' half a dozen or so lines
above, but this line helps document the expectation a bit better.)

I'd be very reticent to include only this test_path_is_file check, as
it makes no guarantee that it has the right contents or that we didn't
also keep around another copy in a/b/bar.c.t, etc.  I understand my
checks above look overzealous, but merge-recursive has been a bit of a
pain to understand and deal with at times, and I've been bitten one
too many times with tests (of merge-recursive and elsewhere in
git.git) that passed but still did the wrong thing because they only
tested one way in which the test problem failed in the past rather
than specifying what correct behavior is.  And my "overzealousness" in
the merge-recursive tests really have caught and prevented bugs would
have been missed otherwise.


Oh, and I think there's another place in the code that needs to be
tweaked to make sure we handle renaming subdirectories into the root
directory that I missed (and just wasn't tested by this testcase), so
I'll check into it and if so fix the code and add another testcase,
and include the fixups I agreed to above and send out a v2.  Probably
won't get to it until the middle of next week, though.


Thanks again for the review and food for thought.  The CI/PR builds
sound particularly interesting; I'd really like to make those better
for you if it can be done in a way that doesn't break command line
builds with clear documentation of setup and expectations while
supporting test skipping and post-facto investigation (even without
--immediate or re-running), etc.  Hmm...
