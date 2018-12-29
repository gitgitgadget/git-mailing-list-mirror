Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99C271F932
	for <e@80x24.org>; Sat, 29 Dec 2018 21:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728487AbeL2Vgw (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Dec 2018 16:36:52 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:36771 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbeL2Vgw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Dec 2018 16:36:52 -0500
Received: by mail-vs1-f42.google.com with SMTP id v205so14845084vsc.3
        for <git@vger.kernel.org>; Sat, 29 Dec 2018 13:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H3jH+r4WLP/YISwatbL75iX9xsw5k6GkxyeocA6XNvE=;
        b=jx0C9qRdBbNLqRJBGrQG3pcMwS9gtih0Ky/lZpRYwJu2PS2WevCt6LZOOPGDhYFpLl
         lM6dLI2AXW8o8BAkx1CCzsV/P/MwOcsjEUi9FtXMTsZPHtdv3KE7VEaCgqpPDOeU++nk
         f+Qxtn//cOGjBX/NdVV0aOepExymvKMS6gupDkJ4sYiXKJumZKUBY2rR7N9W9Mx7Q7U6
         sCPGDWDTIc658KIWRNWGbK99LoaTMGIaTh3Rk6DthZuofeK95QmX0Guagclt/NnTcZTY
         D9+6LtOAer4MqAwUC2VaLrukXSwNGkDmt8q4JyER850pPQmQFdhmqzS84UG53c/Vxj8K
         8a2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H3jH+r4WLP/YISwatbL75iX9xsw5k6GkxyeocA6XNvE=;
        b=n1O1Hh7PnZ8xWilH4uUSbrdGKBIkFNqO64SEXvI5M4O6ioGlv6QUmizRI3R/oFSKYZ
         QNQFphnC+xMo3JsAQLeR6WiG5zj82Lig533XjQ2gZIZNYOqD/0NFYx/fAbI8BpUgHcjs
         iyU+DTC+zK506g5ERGsFEnzVK3KL16dg6xSTsjExfOy9Nkn+hRUIlq29SLe7Pb4LaRbw
         N8gX8M5EDeiC2+7Vx7PLB/KgOGi+4eP/Z6mI0SVqaYOjuTcf9GCddRLuHutnu+tcoqbo
         z8iXqZVmUxAXdGAT97eLC6EwpXlEhlHekg9yCAj4rzivSgEK+BNlj8KRL2pP9QtP9W+M
         zPLA==
X-Gm-Message-State: AA+aEWbY9YSWhDPeqY+It4kNd22IdkkcLY4+1i/6+kxjKTE2B6Jv7nCW
        bbfFwQPPfEYI3VtjIsAVRxi7nao8E8tLbhcz5hzGnI6A
X-Google-Smtp-Source: AFSGD/UMQ5HPq7dhAl/3Y2xWC1lPyoTQQ5hCjH+E1Z0DumfVg3y1XYPJCmMyPIB56Vo5OTuZS8j2s4Y1BiAcvHgTXtw=
X-Received: by 2002:a67:8d08:: with SMTP id p8mr13046553vsd.147.1546119410594;
 Sat, 29 Dec 2018 13:36:50 -0800 (PST)
MIME-Version: 1.0
References: <20181224212425.16596-1-orgads@gmail.com> <20181224212425.16596-2-orgads@gmail.com>
 <xmqqmuopl1qz.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmuopl1qz.fsf@gitster-ct.c.googlers.com>
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Sat, 29 Dec 2018 23:36:38 +0200
Message-ID: <CAGHpTBKskY8AN0_nT5k=Syi8wnpf0EquUKMOAt2NkDq+bc=SGQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] t5403: Refactor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 29, 2018 at 12:34 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> orgads@gmail.com writes:
>
> > Subject: Re: [PATCH 1/2] t5403: Refactor
>
> Hmph.  "Refactor" alone leaves readers wondering "refactor what?",
> "refactor for what?" and "refactor how?".  Given that the overfall
> goal this change seeks seems to be to simplify it by losing about 20
> lines, how about justifying it like so?
>
>         Subject: t5403: simplify by using a single repository
>
>         There is no strong reason to use separate clones to run
>         these tests; just use a single test repository prepared
>         with more modern test_commit shell helper function.
>
>         While at it, replace three "awk '{print $N}'" on the same
>         file with shell built-in "read" into three variables.

Done

[snip]
> > +     mv .git/hooks-disabled .git/hooks &&
>
> I am not sure why you want to do this---it sends a wrong signal to
> readers saying that you want to use whatever hook that are in the
> moved-away .git/hooks-disabled/ directory.  I am guessing that the
> only reason why you do this is because there must be .git/hooks
> directory in order for write_script below to work, so a more
> readable approach would be to "mkdir .git/hooks" instead, no?

Agreed. Done.

> > +     write_script .git/hooks/post-checkout <<-\EOF &&
> > +     echo $@ >.git/post-checkout.args
>
> A dollar-at inside a shell script that is not in a pair of dq always
> makes readers wonder if the author forgot dq around it or omitted eq
> around it deliberately; avoid it.
>
> In this case, use "$@" (i.e. within dq) would be more friendly to
> readers.

Done.

[snip]
> > +     EOF
> > +     test_commit one &&
> > +     test_commit two &&
> > +     test_commit three three
>
> Makes readers wonder why the last one duplicates.  Is this because
> you somehow do not want to use three.t as the pathname in a later
> test?  "test_commit X" that creates test file X.t is a quite well
> established convention (see "git grep '\.t\>' t/"), by the way.

Done. I wasn't aware of that.

[snip]
> > +     test -e .git/post-checkout.args &&
>
> Use "test -f", as you do know you'd be creating a file ("-e"
> succeeds as long as it _exists_, and does not care if it is a file
> or directory or whatever).

Just removed these `test -e` lines. read fails anyway if the file doesn't exist.

> > +     read old new flag <.git/post-checkout.args &&
>
> This indeed is much nicer.

Credit goes to Johannes :)

> > +     test $old = $new && test $flag = 1 &&
> > +     rm -f .git/post-checkout.args
>
> The last one is not a test but a clean-up.  If any of the earlier
> step failed (e.g. $old and $new were different), the output file
> would be left behind, resulting in confusing the next test.
>
> Instead, do it like so:
>
>         test_expect_success 'title of the test' '
>                 test_when_finished "rm -f .git/post-checkout.args" &&
>                 git checkout master &&
>                 test -f .git/post-checkout.args &&
>                 read old new flag <.git/post-checkout.args &&
>                 test $old = $new &&
>                 test $flag = 1
>         '
>
> That is, use test_when_finished() before the step that creates the
> file that may be left behind to arrange that it will be cleaned at
> the end.
>
> This comment on clean-up applies to _all_ tests in this patch that
> has "rm -f .git/post-checkout.args" at the end.

Done

> >  test_expect_success 'post-checkout runs as expected ' '
> > -     GIT_DIR=clone1/.git git checkout master &&
> > -     test -e clone1/.git/post-checkout.args
> > +     git checkout master &&
> > +     test -e .git/post-checkout.args &&
> > +     rm -f .git/post-checkout.args
> >  '
>
> Now that the script got so simplified, this one looks even more
> redundant, given that the previous one already checked the same
> "checkout 'master' when already at the tip of 'master'" situation.
>
> Do we still need this one, in other words?

I agree. Removed.

> >  test_expect_success 'post-checkout args are correct with git checkout -b ' '
> > -     GIT_DIR=clone1/.git git checkout -b new1 &&
> > -     old=$(awk "{print \$1}" clone1/.git/post-checkout.args) &&
> > -     new=$(awk "{print \$2}" clone1/.git/post-checkout.args) &&
> > -     flag=$(awk "{print \$3}" clone1/.git/post-checkout.args) &&
> > -     test $old = $new && test $flag = 1
> > +     git checkout -b new1 &&
> > +     read old new flag <.git/post-checkout.args &&
> > +     test $old = $new && test $flag = 1 &&
> > +     rm -f .git/post-checkout.args
> >  '
>
> This one forgets "did the hook run and create the file" before
> "read", unlike the previous tests.  It is not strictly necessary as
> "read" will fail if the file is not there, but it'd be better to be
> consistent.

Made consistent by removing file existence test, and left only read.

> >  if test "$(git config --bool core.filemode)" = true; then
>
> This is a tangent but this conditional came from an ancient d42ec126
> ("disable post-checkout test on Cygwin", 2009-03-17) that says
>
>     disable post-checkout test on Cygwin
>
>     It is broken because of the tricks we have to play with
>     lstat to get the bearable perfomance out of the call.
>     Sadly, it disables access to Cygwin's executable attribute,
>     which Windows filesystems do not have at all.
>
> I wonder if this is still relevant these days (Cc'ed Ramsay for
> input).  Windows port should be running enabled hooks (and X_OK is
> made pretty much no-op in compat/mingw.c IIUC), so the above
> conditional is overly broad anyway, even if Cygwin still has issues
> with the executable bit.

Reverted.

Thanks,
- Orgad
