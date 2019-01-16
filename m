Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C9E41F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 21:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbfAPVOA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 16:14:00 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:44155 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727920AbfAPVN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 16:13:58 -0500
Received: by mail-vs1-f68.google.com with SMTP id u11so4842308vsp.11
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 13:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CLjUoR++C48PX6EXGtO5HoXTvvlIRj16ge0sl2i59JE=;
        b=kBu8GuGsQYKQJY1lm0KxviKyKWtFy8bnK4k55KzEuj9VURlE8zBk/CkEGX8MdJzdpu
         htZR+hDVJC74/ewN5NOqGKOURlvKRtBxNr7Vt89AaP30wXFHM38PtZPcg7Bu8O40yry3
         STjQbW+z7k9F6yxg90QpZ/rdCueKJInt4+0rdzVwB2QzKxMF5ic+sWhm40+eWmAMilgp
         AyckS6RjzRXouyuF3GrKb3ROXk1f1SZlrxo+ixHjqI+xUIGxnlmpo30VnCkgT3k3l8/i
         DXNVM5rbCEIFUEtjtmM7+Q1AFYyMFBEFLxejSLQIIMnG16TXw3SY6X3MtdOYE5xq3m62
         BS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CLjUoR++C48PX6EXGtO5HoXTvvlIRj16ge0sl2i59JE=;
        b=m0wdzdVw5lzIVjGdsbnkhKryCASD+BGqHQiKArZkpXUDcVk5IdC5zCfSPL8580Z2jz
         LrnwrFTJ+cA6eCjV9kZ82Oow4z/pVqi+FA6WxLVsO3T4KGxaHl78QscFFHS069CkBLsy
         jK6fmB1oHUKXRemWfzV1RiWj8qU6AsvGOYeuh7M6PNHkSNjQLOBfTJ/xqrQBA+ggIWoy
         oINdsopOUNqU9QUH1OjjA9ybpMuhyltgTEBxVNCgdNyEee/UFy4+B0/LHLa8BwVMmXr2
         dF+LohbSHjiDdwdsZE3iZ18L1pyjq/IAUnjyNW18RXMMrpONBdOrzsJ+BkoJbP2K/pM5
         Qwgg==
X-Gm-Message-State: AJcUukfRKoKXWchlw7o1PEenhRmp0MyIGwDmiELDw3wh/91RgNMqy35M
        giCEAnHOdLWvRpn0Bsw/xSrJpjoIRqyz4ZT9/vt76A==
X-Google-Smtp-Source: ALg8bN54cTNfDHcMZyxAt00zGXqhXaPG0PiknEbJw8oRAs1xGUqiGV7NOfRf9CGj7Zcd0vkBYR3lw5VWyKIJOl9q5mI=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr4654386vsa.117.1547673236211;
 Wed, 16 Jan 2019 13:13:56 -0800 (PST)
MIME-Version: 1.0
References: <pull.109.git.gitgitgadget@gmail.com> <598de6652cdb19b9772f322f17600c3845f208cc.1547645839.git.gitgitgadget@gmail.com>
 <CABPp-BHOkVKVpZy2RKj-ofoajGT0rgrb2TpQsXprk1_yZwtVfA@mail.gmail.com> <nycvar.QRO.7.76.6.1901162108140.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1901162108140.41@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 16 Jan 2019 13:13:44 -0800
Message-ID: <CABPp-BGedyPLu+_=+CQhEonyyw74aMSF58tjLc2FjCLs8vyEmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] t6042: work around speed optimization on Windows
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Wed, Jan 16, 2019 at 12:31 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> On Wed, 16 Jan 2019, Elijah Newren wrote:
>
> > On Wed, Jan 16, 2019 at 5:37 AM Johannes Schindelin via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > >
> > > When Git determines whether a file has changed, it looks at the mtime,
> > > at the file size, and to detect changes even if the mtime is the same
> > > (on Windows, the mtime granularity is 100ns, read: if two files are
> > > written within the same 100ns time slot, they have the same mtime) and
> > > even if the file size is the same, Git also looks at the inode/device
> > > numbers.
> > >
> > > This design obviously comes from a Linux background, where `lstat()`
> > > calls were designed to be cheap.
> > >
> > > On Windows, there is no `lstat()`. It has to be emulated. And while
> > > obtaining the mtime and the file size is not all that expensive (you
> > > can get both with a single `GetFileAttributesW()` call), obtaining the
> > > equivalent of the inode and device numbers is very expensive (it
> > > requires a call to `GetFileInformationByHandle()`, which in turn
> > > requires a file handle, which is *a lot* more expensive than one might
> > > imagine).
> > >
> > > As it is very uncommon for developers to modify files within 100ns
> > > time slots, Git for Windows chooses not to fill inode/device numbers
> > > properly, but simply sets them to 0.
> > >
> > > However, in t6042 the files file_v1 and file_v2 are typically written
> > > within the same 100ns time slot, and they do not differ in file size.
> > > So the minor modification is not picked up.
> > >
> > > Let's work around this issue by avoiding the `git mv` calls in the
> > > 'mod6-setup: chains of rename/rename(1to2) and rename/rename(2to1)'
> > > test case. The target files are overwritten anyway, so it is not like
> > > we really rename those files. This fixes the issue because `git add`
> > > will now add the files as new files (as opposed to existing, just
> > > renamed files).
> >
> > I actually read this before the cover letter (just responded in opposite
> > order), and the last paragraph alarmed me at first, because it made it
> > sound like it was dispensing with the need for rename detection and thus
> > breaking the intent of the testcase.
>
> Right, the cover letter has the benefit of being written last (so I have
> thought about the issue the longest before casting my thoughts into
> words while writing it, longer than when I come up with the commit
> message, which is typically even before I test things thoroughly).
>
> > Granted, looking at the code it becomes clear you're not changing the
> > intent of the testcase at all, just transforming the setup steps
> > slightly.  In your cover letter, you made this clear by stating that you
> > were replacing
> >     git mv <old> <new> && mv <file> <new> && git add <new>`
> > by
> >     git rm <old> && mv <file> <new> && git add <new>`
> > Perhaps something like that could be added here or other wording to
> > clarify that it's just an innocuous transformation of the setup steps?
>
> Sure. I added this paragraph:
>
>         Functionally, we do not change anything because we replace two
>         `git mv <old> <new>` calls (where `<new>` is completely
>         overwritten and `git add`ed later anyway) by `git rm <old>` calls
>         (removing other files, too, that are also completely overwritten
>         and `git add`ed later).
>
> This should explain the intention nicely, would you agree?

Yep, thanks.  :-)

> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > ---
> > >  t/t6042-merge-rename-corner-cases.sh | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
> > > index 7cc34e7579..09dfa8bd92 100755
> > > --- a/t/t6042-merge-rename-corner-cases.sh
> > > +++ b/t/t6042-merge-rename-corner-cases.sh
> > > @@ -1175,7 +1175,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
> > >
> > >                 # Handle the left side
> > >                 git checkout L &&
> > > -               git mv one three &&
> > > +               git rm one two &&
> >
> > Here you not only remove the file being renamed ('one') but also a
> > file being modified ('two'); you didn't mention the latter in your
> > commit message.
>
> True. But it *is* replaced and `git add`ed later, too.
>
> > Since both are added back later it'll still work either way on linux,
> > but was it suffering from the same problem on Windows?
>
> Yes. All 6 versions of the file are written in quick succession. So yes,
> *any* of these 6 versions that are intended to replace another of said 6
> versions will suffer from the exact same problem.

This was more just to note that the commit message didn't match the
actual change, because the commit message implied it was just doing
this for "renamed" files.  At most it was a minor nit, though I used
it to double check whether I was understanding the issue.  Thanks for
verifying.

> > It too was a case of both the filesize before and after remaining the
> > same despite contents changing, so it certainly seem possible.
>
> Yep.
>
> > >                 mv -f file_v2 three &&
> > >                 mv -f file_v5 two &&
> > >                 git add two three &&
> > > @@ -1183,7 +1183,7 @@ test_expect_success 'setup nested conflicts from rename/rename(2to1)' '
> > >
> > >                 # Handle the right side
> > >                 git checkout R &&
> > > -               git mv two three &&
> > > +               git rm one two &&
> >
> > Also here you remove both a renamed and a modified file -- though in
> > this case I think the file sizes change for both (each increases by
> > one character) so this hunk of the patch probably isn't needed.
>
> It did not make sense for me to use two *different* ways to perform
> essentially the same operation. I know I would scratch my head until it
> hurts if I read intentionally different command cadences, to figure out
> why they are different. Only to find out that they are not intended to be
> different? I don't think so.
>
> > It doesn't hurt though, and could be considered future-proofing against
> > possible changes to the setup files, and may also just be nice to make
> > the two blocks of setup look more consistent
>
> Indeed. I would *hate* to lose time over reading those test cases in 6
> months, just because they use different paradigms (even if they want to do
> the same thing).
>
> And I have to spend *way* too much time reading test scripts. So I am very
> adamant about making my own life easier here.

Oh, I like the consistency better to.  Sorry if I came across
differently, it was more a stream of thought as I looked over the
patch, which I recorded to just note that I had in fact read and
checked it and it all looks good.

> Point in case: it took me quite a good while to understand the code that I
> fixed in this patch, because the underlying intention was not immediately
> accessible to me. The test failure happens in the *next* test case, after
> all. That was a head scratcher, too: the problem was in a test case that
> *passed*, not in the one that failed.

Hmm...I had adopted this style based on my own struggles to understand
regression tests.  I had gotten pretty frustrated finding a failure in
test #87, and finding out that its setup was spread throughout two
dozen of the preceding 86 tests, with another three dozen changes to
the repository in the preceding 86 tests that happen to be irrelevant.
I like the setup for a test being separately contained.  Secondarily,
though, there were a number of tests where I found it hard to see what
they were meaning to test because of a huge mixture of setup and
testing in the same test.  Putting the setup in one test and then the
actual thing of interest being tested in a subsequent test made that a
whole lot clearer.

...or so I thought.  I'm sorry that it to have made it worse for you.
I was trying to make things clearer.

> It all comes back to what I have been harping on for at least a year: our
> test suite is not really optimized for figuring out how to fix test
> failures. There is nothing immediately actionable when anything fails. A
> developer has to spend considerable time to find out what is going wrong
> if a test failure happens (is it flakey? Is it a bug in the *test*? Is it
> a *true regression*?)
>
> Of course, this is not a new problem. And I *do* see that some
> contributors are as interested as I am in a more useful test suite, one
> where a failed test *really* indicates a regression, one where the output
> of a failed test has enough evidence to start fixing the bug right away
> (rather than spending time on understanding the intention of what was
> tested first). For example, when `wc -l` invocations were replaced by
> `test_line_count`, not only did we address portability problems (where BSD
> `wc` would indent the output), we also changed the code to indicate quite
> clearly *what* was tested. We do not yet output the contents of the file
> when `test_i18ngrep` fails, but that would also be a step in the right
> direction.
>
> Here's hoping that our test suite improves in that respect: to make it
> easier and quicker to fix regressions.

Yep, agreed.


Anyway, with the wording change to the commit message you mentioned
above, feel free to add

Reviewed-by: Elijah Newren <newren@gmail.com>
