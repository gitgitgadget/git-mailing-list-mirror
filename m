Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 381181F404
	for <e@80x24.org>; Mon, 17 Sep 2018 21:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbeIRDQh (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 23:16:37 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41044 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbeIRDQh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 23:16:37 -0400
Received: by mail-ot1-f67.google.com with SMTP id e18-v6so12910156oti.8
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 14:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxzc1FL36yDEF/akV00jfV+8xPVrlXWdKqCgaOLOkXc=;
        b=HVpJ0gYyz0NTxDT+sAPHZarLp2eLwNIF5zc8gLZL8r16W62/Xha4VJQ6j6bxuyNYkL
         zq4CqXfNpnMUmqwdOxi6asYY59UOXxueDd87EZX33op+zr1qhfgDMWSH0yZWgaJYoArL
         EzZoUjf9RpExWLzDzQExW83eUmKOpoQZ6BMGk8KrK3JkW0JZNEJUJ4M8RtXjRQZCoJ3Q
         Qh8daRRgeXyt0x9U3wSOSBniBXiY6DzQEIhil9vylwh73EIZfPr5Y0rBM5sVnL0qm5Dd
         mteqj9VIsMNOHO2ZaSrIHLRJr8kTHEvMDq3yKj6K8pJfv6SEwQvaNyl9R6fOBaZ27AYo
         17mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxzc1FL36yDEF/akV00jfV+8xPVrlXWdKqCgaOLOkXc=;
        b=N/K7CyyO0EgiojQWLpO+pcPV2SeBIbPM7NJ7H6a/LNslPaqTLExQLxOCMTnZPKoeZe
         Ii8c8sLVgckW7DWlBns+yLsOAXUR1S5B4JAXPztdzijiRVIo2y6uMYbgutUuIMB9WaIZ
         XXOn9DJaUL1EATUILnp0iGf4Kbkdo7Nl94W7OfV7H9+comXrw3dC3FXJgBIaDZTFT/Nb
         0vgx+KWGc0y7VGuA38Vnd+4+/uj2fV3QE3GymniK2UK2kRKfbDF+eA7AxpAyuejOneQL
         IE9gl9VrBaPXO1NzFq669Y24YfrmTLL2eHCU71WavVdt5d/5XOySsjccMvAJX/O79wys
         J0Iw==
X-Gm-Message-State: APzg51AkNPsyFxBYDKSgI5Bv7lu5wUyfcZqqAopFenX+mnidjDNxp+Em
        ndSVPJECnEk4SsuT2HsQVRWLrkpdIEVWJyHFDUKhCWUoXw==
X-Google-Smtp-Source: ANB0Vdb0tyguWuuyjWywOAxNjrl8XMolJvGE41m8Fzf+DY4kWEzFx9Pay/FLgy2kKAlCOjtMf+CmJmXBE83rcWxtQB4=
X-Received: by 2002:a9d:56d4:: with SMTP id b20-v6mr13158067otj.179.1537220844363;
 Mon, 17 Sep 2018 14:47:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536969438.git.matvore@google.com> <a4c833da81d83ea0e605c936d90ea9c7f5667d93.1536969438.git.matvore@google.com>
 <20180917163137.GB89942@aiede.svl.corp.google.com>
In-Reply-To: <20180917163137.GB89942@aiede.svl.corp.google.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Mon, 17 Sep 2018 14:47:12 -0700
Message-ID: <CAMfpvhKTk0VJicAKO_ASxKMU99GXEAbZ7e5K35g8D3uM9tqv2g@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] t/*: fix pipe placement and remove \'s
To:     jrnieder@gmail.com
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>, bmwill@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 17, 2018 at 9:31 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Matthew DeVore wrote:
>
> > Subject: t/*: fix pipe placement and remove \'s
> >
> > Where ever there was code in the tests like this:
> >
> >       foo \
> >               | bar
>
> Language nits:
> - s/Where ever/Wherever/
> - Git's commit messages use the present tense to describe the existing
>   previous state of the codebase, as though reporting a bug.
>
> Maybe something like
>
>         tests: standardize pipe placement
>
>         Instead of using a line-continuation and pipe on the second
>         line, take advantage of the shell's implicit line continuation
>         after a pipe character.  So for example, instead of
>
>                 some long line \
>                         | next line
>
>         use
>
>                 some long line |
>                 next line
>
> At this point, it would be useful to say something about rationale ---
> for example,
>
>         This better matches the coding style documented in
>         Documentation/CodingGuidelines and used in shell scripts
>         elsewhere in Git.
>
Done.

> Except: is this documented in Documentation/CodingGuidelines?  Or,
> better, is there a linter that we can run in the test-lint target of
> t/Makefile to ensure we keep sticking to this style?
It's not documented there, so I've created a new commit at the start
of this patchset which addresses that. I also added a commit which
adds a lint test, but it uses a questionable heuristic in order to
avoid false positives (it's hard to distinguish graphs generated with
git log --oneline since they often have "\ [newline] [tab or spaces]
|"  ). Let me know if you think it looks promising. I'd be happy to
just drop it.

>
> [...]
> > --- a/t/lib-gpg.sh
> > +++ b/t/lib-gpg.sh
> > @@ -57,8 +57,8 @@ then
> >               echo | gpgsm --homedir "${GNUPGHOME}" 2>/dev/null \
> >                       --passphrase-fd 0 --pinentry-mode loopback \
> >                       --import "$TEST_DIRECTORY"/lib-gpg/gpgsm_cert.p12 &&
> > -             gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K \
> > -                     | grep fingerprint: | cut -d" " -f4 | tr -d '\n' > \
> > +             gpgsm --homedir "${GNUPGHOME}" 2>/dev/null -K |
> > +             grep fingerprint: | cut -d" " -f4 | tr -d '\n' > \
> >                       ${GNUPGHOME}/trustlist.txt &&
>
> I think this would be more readable with one item from the pipeline
> per line:
>
>                 gpgsm --homedir ... |
>                 grep ... |
>                 cut ... |
>                 tr ... >... &&
>
Done.

> [...]
> > --- a/t/t1006-cat-file.sh
> > +++ b/t/t1006-cat-file.sh
> > @@ -218,8 +218,8 @@ test_expect_success "--batch-check for a non-existent hash" '
> >      test "0000000000000000000000000000000000000042 missing
> >  0000000000000000000000000000000000000084 missing" = \
> >      "$( ( echo 0000000000000000000000000000000000000042;
> > -         echo_without_newline 0000000000000000000000000000000000000084; ) \
> > -       | git cat-file --batch-check)"
> > +         echo_without_newline 0000000000000000000000000000000000000084; ) |
> > +       git cat-file --batch-check)"
>
> This test is problematic in a lot of ways.  Most importantly, it ignores
> the exist status from git cat-file.
>
[...]
> but unless there's a linter that we're helping support, it's probably
> better to skip this file and use a dedicated patch to modernize its
> style more generally.

Yes, the cat-file.sh test is kind of funky, and I like the style of
your suggestions much better, but in this case I think that perfect is
the enemy of good. Fixing everything wrong with these lines would
necessitate fixing the surrounding couple of tests that also swallow
up the exit code of git cat-file. This may in turn necessitate other
fixes for consistency that may even spread to other files... I am
basing my argument here on what's in Documentation/CodingGuidelines,
which indicates that minor stylistic nits that result in code churn
are not recommended, and that we must be consistent with the
surrounding code. The surrounding code here looks for the most part
like:

 test "asdf" = $(echo "asdf" | git foo-bar)

Which I think is satisfactory in its own context. You asked me to fix
other test files later on, which I did, since they didn't seem to have
such a contrarian style, so the fixes were very localized, and I was
already editing many lines in those files already.

>
> [...]
> > --- a/t/t5317-pack-objects-filter-objects.sh
> > +++ b/t/t5317-pack-objects-filter-objects.sh
> > @@ -20,17 +20,20 @@ test_expect_success 'setup r1' '
> >  '
> >
> >  test_expect_success 'verify blob count in normal packfile' '
> > -     git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
> > -             | awk -f print_2.awk \
> > -             | sort >expected &&
> > +     git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
> > +     awk -f print_2.awk |
> > +     sort >expected &&
>
> This loses the exit status from git, so we should make it write to a
> temporary file instead (as a separate patch).
Fixed.

>
> [...]
> > -     git -C r1 verify-pack -v ../all.pack \
> > -             | grep blob \
> > -             | awk -f print_1.awk \
> > -             | sort >observed &&
> > +
> > +     git -C r1 verify-pack -v ../all.pack |
>
> Likewise (and likewise for the rest in this file).
Fixed this file's exit code issues in a separate patch.

>
> [...]
> > --- a/t/t5500-fetch-pack.sh
> > +++ b/t/t5500-fetch-pack.sh
> > @@ -50,8 +50,9 @@ pull_to_client () {
> >                       case "$heads" in *B*)
> >                           git update-ref refs/heads/B "$BTIP";;
> >                       esac &&
> > -                     git symbolic-ref HEAD refs/heads/$(echo $heads \
> > -                             | sed -e "s/^\(.\).*$/\1/") &&
> > +
> > +                     git symbolic-ref HEAD refs/heads/$(echo $heads |
> > +                     sed -e "s/^\(.\).*$/\1/") &&
>
> It would be better to use a temporary variable.  If we're just
> changing line wrapping, then this would be
>
>                         git symbolic-ref HAD refs/heads/$(
>                                 echo $heads |
>                                 sed ...
>                         ) &&
>
Fixed using your suggestion (only fixed the line wrapping)

> [...]
> > --- a/t/t5616-partial-clone.sh
> > +++ b/t/t5616-partial-clone.sh
> > @@ -34,10 +34,12 @@ test_expect_success 'setup bare clone for server' '
> >  # confirm partial clone was registered in the local config.
> >  test_expect_success 'do partial clone 1' '
> >       git clone --no-checkout --filter=blob:none "file://$(pwd)/srv.bare" pc1 &&
> > -     git -C pc1 rev-list HEAD --quiet --objects --missing=print \
> > -             | awk -f print_1.awk \
> > -             | sed "s/?//" \
> > -             | sort >observed.oids &&
> > +
> > +     git -C pc1 rev-list HEAD --quiet --objects --missing=print |
>
> Also needs to write to a temporary to avoid losing the exist status
> (and likewise for the rest of this file).
Done in a separate patch, although I didn't do this for pipes inside
of $( ) and for a trivial "git rev-parse HEAD".

>
> [...]
> > --- a/t/t6112-rev-list-filters-objects.sh
> > +++ b/t/t6112-rev-list-filters-objects.sh
> > @@ -20,24 +20,28 @@ test_expect_success 'setup r1' '
> >  '
> >
> >  test_expect_success 'verify blob:none omits all 5 blobs' '
> > -     git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 \
> > -             | awk -f print_2.awk \
> > -             | sort >expected &&
> > -     git -C r1 rev-list HEAD --quiet --objects --filter-print-omitted --filter=blob:none \
> > -             | awk -f print_1.awk \
> > -             | sed "s/~//" \
> > -             | sort >observed &&
> > +     git -C r1 ls-files -s file.1 file.2 file.3 file.4 file.5 |
> > +     awk -f print_2.awk |
> > +     sort >expected &&
>
> Likewise.
Fixed this file.
>
> [...]
> > --- a/t/t9101-git-svn-props.sh
> > +++ b/t/t9101-git-svn-props.sh
> > @@ -193,8 +193,8 @@ test_expect_success 'test propget' "
> >       git svn propget svn:ignore . | cmp - prop.expect &&
> >       cd deeply &&
> >       git svn propget svn:ignore . | cmp - ../prop.expect &&
> > -     git svn propget svn:entry:committed-rev nested/directory/.keep \
> > -       | cmp - ../prop2.expect &&
> > +     git svn propget svn:entry:committed-rev nested/directory/.keep |
> > +     cmp - ../prop2.expect &&
>
> Likewise.
Fixed this section, including the one earlier in this file. This
section is not a trivial change, so I put it in a different commit.

>
> Thanks and hope that helps,
> Jonathan
I will send an updated patchset shortly.
