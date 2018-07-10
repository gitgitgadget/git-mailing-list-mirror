Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C4A1F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 15:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeGJPxi (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 11:53:38 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:36110 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933692AbeGJPxh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 11:53:37 -0400
Received: by mail-yb0-f195.google.com with SMTP id s1-v6so8798042ybk.3
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 08:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I3qgvXf9QxZekXAHdapRz/6hOs4hZzVip8sB6zK5Bco=;
        b=NFOV9q0lOZQJDUC5wVZR9Yz/J46YKD9yFoliwAQ8nl/Y5IXmRaUJ5M6cDvFwixAnE8
         KrgoaZUnAkk8RUY4jMGS3yRg65EcUwKuXDWna7nOyLlM76dTkmkFIYX9VJqwtEOgggdb
         Bo9VkTvmHk3SKl3pROf252qsS+lgr49G70AeJxpAO5rM9XElPSwRLUr62cuOflAk50AT
         HpKqAKzBkWNHiiEEdjrY4vZyEuMNlRuc8pMcE4zzqSDoYZbi2vfKt32waJkBfoSbnJTd
         k6w7WrO9ZKHPK0WQduyYuPhMKLCOw8zjYK53pkxQ5eVvuvwmY3k3TsaUVfLVYsKrkHFg
         +AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I3qgvXf9QxZekXAHdapRz/6hOs4hZzVip8sB6zK5Bco=;
        b=bq1yj8Mgy7Panv9Ai6WS6ktTaopcNEIBV4rG28v6IgM/HZO8x52OiH+uc/LuA2z2fJ
         8iL0zk+uSfgJ1K5XBgY3SooUH+VTXo9iCLqh9BFUAo55jdFSVt0fl7ULo30Ri0+UHUIZ
         yWRadqGLv2aFohByVxK1W+ZuLK9q1sYXs7pIxT21QOMpqtStC0McmA+tkCR13FSPPBLF
         r863jpwGFL3SBX+IuOZkPAwp8TtKaVvrX262QEK5k8U8m1EiS1P+euoLfD2otF3FPNh8
         yI0Roz2KDw+wj0g6h8kLLIa58/a0uL4WD/7xSu28/0lz5Ou/AMO5aklCjB5/6NmOV3DE
         6WQA==
X-Gm-Message-State: APt69E0t2/+a9j2TeqzN7YCrEfJ1U8E9ZH6RkwMI4K7DDvBF+TLcM2Fu
        MNkYPIYTnyEwdfXEpLtw82jmmGC2T+L9w0Vcy2HL2UtR5j0=
X-Google-Smtp-Source: AAOMgpcj5yxKrL59mQWcxUeABQvuAyRWXCWrk4Z3HCs/xdLRFJabc7WCqLkNErmh8OGuM9hryLv1qapTlwqIdAwEbbE=
X-Received: by 2002:a25:a263:: with SMTP id b90-v6mr13728873ybi.247.1531238016681;
 Tue, 10 Jul 2018 08:53:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180707204404.7208-1-newren@gmail.com> <20180707204404.7208-2-newren@gmail.com>
 <CAGZ79kZ0xyHMT8SngGCUSAEf31NXdPvzkvdaPb8Khm27xRjgTg@mail.gmail.com> <CABPp-BFjZZZ9uGXYe0gAA_VvcFmTsnurAknVrr-CytP2hT6wLg@mail.gmail.com>
In-Reply-To: <CABPp-BFjZZZ9uGXYe0gAA_VvcFmTsnurAknVrr-CytP2hT6wLg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 10 Jul 2018 08:53:25 -0700
Message-ID: <CAGZ79kYK4uwUeDECoabrXJesVzgFBKNejV3reJOXhMyYxUjXyw@mail.gmail.com>
Subject: Re: [PATCH 1/3] t7405: add a file/submodule conflict
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 10, 2018 at 8:28 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Jul 9, 2018 at 2:11 PM, Stefan Beller <sbeller@google.com> wrote:
> > On Sat, Jul 7, 2018 at 1:44 PM Elijah Newren <newren@gmail.com> wrote:
> >>
> >> In the case of a file/submodule conflict, although both cannot exist at
> >> the same path, we expect both to be present somewhere for the user to be
> >> able to resolve the conflict with.  Add a testcase for this.
> >>
> >> Signed-off-by: Elijah Newren <newren@gmail.com>
> >> ---
> >>  t/t7405-submodule-merge.sh | 56 ++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 56 insertions(+)
> >>
> >> diff --git a/t/t7405-submodule-merge.sh b/t/t7405-submodule-merge.sh
> >> index 7bfb2f498..95fd05d83 100755
> >> --- a/t/t7405-submodule-merge.sh
> >> +++ b/t/t7405-submodule-merge.sh
> >> @@ -279,4 +279,60 @@ test_expect_success 'recursive merge with submodule' '
> >>          grep "$(cat expect3)" actual > /dev/null)
> >>  '
> >>
> >> +# File/submodule conflict
> >> +#   Commit O: <empty>
> >> +#   Commit A: path (submodule)
> >> +#   Commit B: path
> >> +#   Expected: path/ is submodule and file contents for B's path are somewhere
> >> +
> >> +test_expect_success 'setup file/submodule conflict' '
> >> +       test_create_repo file-submodule &&
> >> +       (
> >> +               cd file-submodule &&
> >> +
> >> +               git commit --allow-empty -m O &&
> >> +
> >> +               git branch A &&
> >> +               git branch B &&
> >> +
> >> +               git checkout B &&
> >> +               echo contents >path &&
>
> This should have been 'content' rather than 'contents', given my grep below...
>
> >> +               git add path &&
> >> +               git commit -m B &&
> >> +
> >> +               git checkout A &&
> >> +               test_create_repo path &&
> >> +               (
> >> +                       cd path &&
> >> +
> >> +                       echo hello >world &&
> >
> >     test_commit -C path &&
> >
> > or do we need a dirty submodule specifically?
> > If so what is important, the untracked file or
> > would changes in the index be sufficient?
>
> Do you mean
>     test_commit -C path hello
> because test_commit needs at least one positional argument (which will
> serve as contents, message, filename, and tag)?  Anyway, yeah, doing
> this would remove the whole innermost subshell -- the cd, the echo,
> the git add, and the git commit.
>
> >
> >> +                       git add world &&
> >
> > when observing this one in verbose mode , you may be
> > asked to use 'git submodule add' instead
> > https://github.com/git/git/blob/master/builtin/add.c#L323
>
> Um, at this point, I'm adding a regular file -- not a submodule.  Also,
> this git add will disappear if I use test_commit.  Perhaps you meant
> one of the other 'git add's?
>
> >
> >> +                       git commit -m "submodule"
> >
> > Not sure if we'd need the shell it is only test_commit,
> > the [submodule] add and commit, so maybe we can get away with
> > 3 times -C ?
>
> This also disappears with test_commit.

Sorry, I got ahead of my thinking as normally in submodule tests a
shell+commit (in the superproject) is the rough pattern of its setup.

I was wondering if you want to test *repo* vs file or *submodule* vs file
conflict and if we want to treat them differently?
(A submodule really belongs to the project, so we could expect users
to have moved a tree into a submodule or vice versa. But if a repo
appears, we might have a hard time caring as we (or I at the moment)
really have no clue what the setup is intended for.
(With these comments, I think I meant to annotate the part

+               git add path &&
+               git commit -m A

to use "git submodule add ./path")


> >> +               test_must_fail git merge B^0 >out 2>err &&
>
> I probably shouldn't have redirected stdout and stderr here; makes it
> harder for you to see what's happening, especially since I don't test
> either in any way.
>


> >> +               grep -q content * 2>/dev/null
> >
> > Ah that is why we needed the specific echo above.
>
> Yeah, if there was a handy
> test_string_exists_in_some_file_in_current_directory I could have used
> that, but seems like an oddly specific special test function, so I
> just added an echo so someone watching the test output under --verbose
> could see how far the test got.
>
> > Sorry for being dense here, I am not quite following the last part of the test,
> > as it is unclear what ought to fail in this test.
>
> Hmm, I obviously wasn't nearly as clear as I thought I was.  Thinking
> it over, two things may have thrown you off:
>
> 1) I had a typo ('content' vs. 'contents')

I understood that part, or rather I did not spot the typo.

> 2) I didn't just check what was currently failing but other things
> that should be true for this test.
>
> For item 2, I've had multiple cases in the past where I created a
> minimal test, only to find that if I had more carefully checked the
> expected results that it would have prevented a future bug.  Also, it
> was harder in the future to figure out, because I no longer remembered
> the context for the test setup.  So, in this test I check the contents
> of the index, make sure that the submodule is still present, and then
> I finally check for the thing that currently fails:
>
> commit B added a file called 'path'; its contents should appear
> somewhere in the directory for the user to use when trying to resolve
> the failed merge.  It cannot appear at 'path' (there's a submodule in
> the way from commit A), but it should be present somewhere, and in
> particular I'd expect it in the same directory.  So, I simply grep all
> files in the current directory for the string (and ignore errors about
> 'grep: path is a directory').
>
> Does that help?  If so, I'll submit a reroll with the changes and a
> few extra comments.

That does help; yes, I thought
* we want to check for the file content of the file to be somewhere
  (maybe path.file?)
* equally we'd want to have the submodule somewhere; you seem
  to expect it at path (we could have moved it to path.sub or path.git,
  but that involves extra work as we have to update the .gitmodules
  file to have the correct path <->name mapping)
* good call with the index, I skimmed over the ls-files calls not thinking
  what they'd check.

So for now only the "file content is missing" part is failing the test,
whereas the rest is successful.

Thanks for the explanation!
Stefan
