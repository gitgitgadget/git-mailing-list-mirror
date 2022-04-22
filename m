Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A1CC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 02:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443353AbiDVCeN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 22:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443337AbiDVCeL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 22:34:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CC14B403
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:31:19 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g18so13571003ejc.10
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J2WovljBghDlexWbW2+j0IIFzbrhpzpPmHEPkQzw8po=;
        b=ln7LgjM5T0CCfppPuQ3KRp9F2OmSm+au97lH5Y0lS+GzPatAMqmDxfrz8cuP0madpE
         YLVp54xoNXrWg4mBSSUyDfyYDifuUVWxocHLsDITJTdgg4bZgzK22vlxV1xWQgdgGXFc
         YJJD4dpKTYWsKtW1c+M9ijOe0bSpSkqWCXOt6c1vkxuogMX092ywjxi3EQtGhKE7vAZP
         apcn+UImzDnTfoPZILtEFm5eowkW56p/w3fym/Tei4VuDmNXPumyarCoaO0rD1vSjwh4
         Cc/eAIssVif17ChzC91vEC6WGZHWmx5xwEZ7a+v6X2vKrpE3RQzDT/qhrnA8koAHpGea
         M5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J2WovljBghDlexWbW2+j0IIFzbrhpzpPmHEPkQzw8po=;
        b=IcSvfbuzX8QRwh+rvzC/k16OnFrc4H0iC6YIH4zvBN/EzZb5g3bdnP63CWiiWQctB+
         g0ZM5F69lcC3l9xSSDg8dJEHrISkYAZXMB7JnE/k82EiJWCocxuHwJO1PzQJD1lJFwek
         S8GDt0Gc+/xbrgDLM/2t1LfbtLVoLYrrMmXGKpZ4c15pyixHvGshUQ7Bs4xMxfYDhAcZ
         WwrCKHctYaeENiEd4CB2QSaEn73OGWp5OAuqWgJS/eZ6kTjdFkM5/KcmQK6zLrWjezmN
         aiQ0+M1BAPicKIf2qSrB/WqQeaELO/W32moapoSVvOa1E5JlM79CgggJHHYBmjie1Ljv
         e0Cw==
X-Gm-Message-State: AOAM533IU7TWYZpWvQtpztCmQKStBACYEIOZKrbpqmz0kMw3OMcg2Nz7
        6KP7S+RFz+m1puRXnr3QWzcFqChJr1/+O2/ZXIQ=
X-Google-Smtp-Source: ABdhPJxbMXlUOezTCLt2hrqynmhU6oQScqlAEpELTj4bbKMRpOO0k4PYpkXCFnjvCJwKdsztFXS7Je6ykKPVlLx8zL0=
X-Received: by 2002:a17:907:6d81:b0:6eb:f837:9077 with SMTP id
 sb1-20020a1709076d8100b006ebf8379077mr2146745ejc.328.1650594677952; Thu, 21
 Apr 2022 19:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1148.git.1646725188.gitgitgadget@gmail.com>
 <pull.1148.v2.git.1647054681.gitgitgadget@gmail.com> <2d2b81986a55f0692d5536dec88079c58853f205.1647054681.git.gitgitgadget@gmail.com>
 <xmqqa6dsp78q.fsf@gitster.g>
In-Reply-To: <xmqqa6dsp78q.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 21 Apr 2022 19:31:06 -0700
Message-ID: <CABPp-BH_GuWdW55FAF=keidVWv+Zy3OJG6pN-VpcpOdCZuKqGw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] git-sparse-checkout.txt: mark non-cone mode as deprecated
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 14, 2022 at 2:14 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > +the default mode, but we do not recommend using it.  It does not work
> > +with the `--sparse-index` option, and will likely be incompatible with
> > +other new features as they are added.
>
> If we explicitly say we have no intention to remove, while saying
> that "non-cone" mode is a second class citizen, the users would be
> confused.

I don't see why they'd be confused.  It seems common to me in software
development to state that a less preferred option will continue to be
supported with its existing feature set, while some other option is
both recommended and will gain new features.

> Does this mixed attitude only apply to non-cone mode, or
> is it true for any other fringe features that we do not care about
> in Git?
>
> This does not build confidence with the Git software suite.  If we
> are removing, then this attitude is OK, but if we are keeping it,
> then we should promise that we never add features only to "cone".

The sparse-index feature only works with "cone" mode and adding
support for non-cone mode would be infeasible.  So we've already
crossed that line.

I'd also like to make partial clones and sparse-checkouts work better
together (something you also suggested in the past), and improve
support for disconnected development.  In particular, having a partial
clone that starts with the history of files within the sparse-cone
instead of an empty set of blobs seems like a reasonable way to do
that.  However, having a partial clone that starts with the history of
files matching a non-cone mode set of paths seems intractable to me; I
don't see how that could reasonably be implemented server side and
would expect it to be rejected even if implemented.  So there's at
least one example in my mind where we would want to cross that line
again.

Although, if you really are saying these are the only two acceptable
options to you, then I'll start pushing to remove non-cone mode;
that'd be much preferable to removing the sparse-index feature and
hamstringing future development.

> > +INTERNALS -- NON-CONE PROBLEMS
> > +------------------------------
> > +
> > +The `$GIT_DIR/info/sparse-checkout` file populated by the `set` and
> > +`add` subcommands is defined to be a bunch of patterns (one per line)
> > +using the same syntax as `.gitignore` files.  In cone mode, these
> > +patterns are restricted to matching directories (and users only ever
> > +need supply or see directory names), while in non-cone mode any
> > +gitignore-style pattern is permitted.  Using the full gitignore-style
> > +patterns in non-cone mode has a number of shortcomings:
> > +
> > +  * Fundamentally, it makes various worktree-updating processes (pull,
> > +    merge, rebase, switch, reset, checkout, etc.) require O(N*M) pattern
> > +    matches, where N is the number of patterns and M is the number of
> > +    paths in the index.  This scales poorly.
> > +
> > +  * Avoiding the scaling issue has to be done via limiting the number
> > +    of patterns via specifying leading directory name or glob.
>
> These are valid.
>
> > +  * Passing globs on the command line is error-prone as users may
> > +    forget to quote the glob, causing the shell to expand it into all
> > +    matching files and pass them all individually along to
> > +    sparse-checkout set/add.  This both exacerbates the scaling
> > +    problem, and hardcodes the list of selected files to those which
> > +    were present at the time the initial set/add subcommand was run
> > +    (and thus ignoring other files matching the same glob which come
> > +    into the working tree after switching branches or pulling down
> > +    updates).
>
> That's end-user mistakes that is common to other things like
> pathspecs, i.e. "git grep -- \*.c" vs "git grep -- *.c".  It hardly
> deserves to spend more than 5 lines shouting.

Fair point.

I do think there's still a small qualitative difference, though, in
regards to timing and the ability of the user to discover their
mistake.  With sparse-checkout, the mistake gets recorded and affects
later commands.  In particular, it's possible that at the time the
command is run, the shell completion of the glob catches all currently
existing relevant files, so the user doesn't notice the mistake.  Once
the user switches branches or rebases or merges or whatever, then the
past expansion of the glob finally bites the user.  In contrast, if
the grep/log/status command is wrong, it's noticeable from the
immediate output the user gets and they can simply re-run with the
corrected command.

> > +  * It uses "ignore"/"exclude" syntax for selecting what to "include",
> > +    which periodically causes confusion.
>
> Well, .gitignore uses the syntax to select the paths to include or
> exclude from a set, and then the set specifies what is left out of
> the index.  I am not sure if that is the source of confusion.

Perhaps I should reword this point:

  * .gitignore files use the gitignore pattern syntax to specify
patterns that are *excluded* (unless the pattern is negated) from the
index.
  * non-cone mode sparse-checkout uses the same syntax to specify
patterns with the opposite meaning -- they are *included* in the tree
(unless the pattern is negated).

If there were two copies of the pattern specification, or if the
documentation carefully pointed out matching/non-matching instead of
exclude/include everywhere, then this perhaps wouldn't be a problem.
However, the documentation for these patterns is almost completely
.gitignore-specific and written talking about exclusion (with
inclusion exceptions).

> > +  * It introduces inconsistencies in the Git command line, since other
> > +    commands use pathspecs, but sparse-checkout (in non-cone mode) uses
> > +    gitignore patterns.
>
> But "cone" mode does not take pathspec, does it?  ":(icase)/A/B/C"
> for example?  I do not see this as a credible argument against it.

My objection is that it's weird having two different forms of "special
path pattern matching" in the git command line.  Every git subcommand
that has such a thing uses pathspecs, except for non-cone mode
sparse-checkout.

I don't see why any subcommand necessarily needs to have "special path
pattern matching", I'm just saying that *if* some subcommand does have
such a thing, it'd be nice to use the same kind of special path
pattern matching that all other git commands do.

> > +  * It has edge cases where the "right" behavior is unclear.  Two examples:
> > +
> > +    First, two users are in a subdirectory, and the first runs
> > +       git sparse-checkout set '/toplevel-dir/*.c'
> > +    while the second runs
> > +       git sparse-checkout set relative-dir
>
> Are we aware which mode of sparse-checkout they are in?  Do we give
> a mechanism for users to ask "we have 'non-cone' sparse checkout in
> the sparse-checkout file.  we want to use the more efficient and
> recommended 'cone' mode.  Please convert it", or even if there is
> not an automated conversion mechansim, can the user manually do so
> (which I suspect is not fundamentally possible---the cone mode is
> inherently less expressive)?
>
> If not, then we should expect these two users to _know_ (or at least
> check before they run "set" subcommand) which mode is in use.
>
> So, with that expectation,
>
> > +    Should those arguments be transliterated into
> > +       current/subdirectory/toplevel-dir/*.c
> > +    and
> > +       current/subdirectory/relative-dir
>
> If we are using non-cone mode, then both would be recorded as-is.

Recording '/toplevel-dir/*.c' and 'relative-dir' as-is sounds great to
me, but doesn't it run contrary to what you previously pushed for
tab-completion?  Previously, you said that in non-cone mode, tab
completion should complete on files and directories (with no "relative
to the toplevel directory" qualification that I could see), which does
not seem to work well with what you've specified here.
