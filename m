Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6311F42D
	for <e@80x24.org>; Thu, 31 May 2018 21:49:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750739AbeEaVtI (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 17:49:08 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:42734 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeEaVtH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 17:49:07 -0400
Received: by mail-yb0-f194.google.com with SMTP id d123-v6so8093009ybh.9
        for <git@vger.kernel.org>; Thu, 31 May 2018 14:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8BPIGUyifnPzCYbREHKpXdVlDlsFkKhYuWhopR8Xk2Q=;
        b=V77jD+BPkX2SC5s2GKDJTqEU8WaFBGCeZNrA3YU/nmFd6TYhKR2lBtT0bCiHfAvdaU
         tlqEpn/5/xolZyF8hf3xtxN4+t2nrBhAQc+uYqip//PEtTsohsKLhigOBPALhjiDm4fF
         8zxYwUPIaCNrvoGqnRuBe+MPgQNehqKx4Ud52SnJ/wV7sJUZVvqFdFmeTOtovH/UgKDM
         7GO7NLXAiYbkCq36ghF+NE7o2altuOtnImRRmdVN9M9SeQsUkovQhUCQC6BhYvUSXOeF
         xX1T0W19qJ18O18CxaIo+0esD05PTz4E1BXkoALK0NdjN9GQKlZ1doXhKXmuGT4yDknK
         leQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8BPIGUyifnPzCYbREHKpXdVlDlsFkKhYuWhopR8Xk2Q=;
        b=bQ5uXRkolPm9qT2BM3LK/iZ+usLKvXRub7W+iJV4rRQ1CG6tYVUq+dAm23dKeypnnx
         z3C5LRxodtO3Eq2oUCIearMDcMlOl6xiTUToPr+xQCPKsZeDEJYGjJ8DE49+4R0MbQGZ
         3YutzoqAQFmVvVvDI2OkV57wN/3cByBpPNEtNEKLjEMjowEQSj4I4Lb5WtstvV0AsyqK
         Filfl8ZRYKh48bk0wbdyZ4X2TSGA3QKL1Ni0hA0XxvUjwpyUKf6DUGV2tL16PE3ExXTr
         4tdeHy0i0CMBtWaXpjXsoUQX5uE9CFZek8BJ6p2pdaHO4buNnlUXYpd0cCXhBHW9CtoY
         kXCA==
X-Gm-Message-State: APt69E2jOit32drSHgu0wwT/f0IZxFkVdWm1oe4Ajg5py4BVYOSaor6Z
        XSB1XE05jYP/xdmyeQEojIH2kuuPg9GDReesh0gjHegDfYM=
X-Google-Smtp-Source: ADUXVKJZEOBzMcNpEl+mn6fH4e3fwcDyRHcTwhxtm1zEMFkBFJneKOW4RaZrz84L5O9xGtOyWImQ3jIKHxHkQdpgF8E=
X-Received: by 2002:a25:6853:: with SMTP id d80-v6mr1779218ybc.515.1527803346604;
 Thu, 31 May 2018 14:49:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Thu, 31 May 2018 14:49:06 -0700 (PDT)
In-Reply-To: <20180531195252.29173-10-avarab@gmail.com>
References: <87a7sg9sjz.fsf@evledraar.gmail.com> <20180531195252.29173-1-avarab@gmail.com>
 <20180531195252.29173-10-avarab@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 31 May 2018 14:49:06 -0700
Message-ID: <CAGZ79kZKaZq+bqFTwe+Y3FU-1DHPjzNrvMNU=DM10EyOXxZJVw@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] checkout & worktree: introduce checkout.defaultRemote
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi =C3=86var,

Sorry for chiming in late. I have a couple of thoughts:

>     (
>         cd /tmp &&
>         rm -rf tbdiff &&
>         git clone git@github.com:trast/tbdiff.git &&
>         cd tbdiff &&
>         git branch -m topic &&
>         git checkout master
>     )
>
> That will output:
>
>     Branch 'master' set up to track remote branch 'master' from 'origin'.
>     Switched to a new branch 'master'

I thought master is already there after the clone operation and
you'd merely switch back to the local branch that was created at
clone time?

    $ git clone git@github.com:trast/tbdiff.git && cd tbdiff
    $ git branch
    * master
    $ cat .git/config
...
[branch "master"]
    remote =3D origin
    merge =3D refs/heads/master

But the observation is right, we get that message. When do we
do the setup for the master branch specifically?

>
> But as soon as a new remote is added (e.g. just to inspect something
> from someone else) the DWIMery goes away:
>
>     (
>         cd /tmp &&
>         rm -rf tbdiff &&
>         git clone git@github.com:trast/tbdiff.git &&
>         cd tbdiff &&
>         git branch -m topic &&
>         git remote add avar git@github.com:avar/tbdiff.git &&
>         git fetch avar &&
>         git checkout master
>     )
>
> Will output (without the advice output added earlier in this series):
>
>     error: pathspec 'master' did not match any file(s) known to git.
>
> The new checkout.defaultRemote config allows me to say that whenever
> that ambiguity comes up I'd like to prefer "origin", and it'll still
> work as though the only remote I had was "origin".
>
> Also adjust the advice.checkoutAmbiguousRemoteBranchName message to
> mention this new config setting to the user, the full output on my
> git.git is now (the last paragraph is new):
>
>     $ ./git --exec-path=3D$PWD checkout master
>     error: pathspec 'master' did not match any file(s) known to git.
>     hint: The argument 'master' matched more than one remote tracking bra=
nch.
>     hint: We found 26 remotes with a reference that matched. So we fell b=
ack
>     hint: on trying to resolve the argument as a path, but failed there t=
oo!
>     hint:
>     hint: Perhaps you meant fully qualify the branch name? E.g. origin/<n=
ame>

s/meant fully/meant to fully/
s/? E.g./?\nFor example/

>     hint: instead of <name>?

In builtin/submodule--helper.c there is get_default_remote() which also
hardcodes "origin". I think that is a safe thing to do.

>     hint:
>     hint: If you'd like to always have checkouts of 'master' prefer one r=
emote,
>     hint: e.g. the 'origin' remote, consider setting checkout.defaultRemo=
te=3Dorigin
>     hint: in your config. See the 'git-config' manual page for details.

his new setting elevates one remote over all others, which may
be enough for most setups and not confusing, too.
Consider the following:

    git clone https://kernel.googlesource.com/pub/scm/git/git && cd git
    git remote add gitster https://github.com/gitster/git
    git remote add interesting-patches https://github.com/avar/git
    git remote add my-github https://github.com/stefanbeller/git

    git checkout master

This probably means I want to have origin/master (from kernel.org)

    git checkout ab/checkout-implicit-remote

This probably wants to have it from gitster/ (as it is not found on kernel.=
org);
I am not sure if it would want to look at interesting-patches/ that mirrors
github, but probably if it were not to be found at gitster.

So maybe we rather want a setup to give a defined priority for
the search order:

  git config dwim.remoteSearchOrder origin gitster avar

Stepping back a bit, there is already an order in the config file
for the remotes, and that order is used for example for 'fetch --all'.

I wonder if we want to take that order? (Or are the days of hand
editing the config over and this is too arcane? We would need a
config command to re order remotes). Then we could just have a
boolean switch to use the config order on ambiguity.
Although you might want to have a different order for fetching
and looking for the right checkout.

> I considered splitting this into checkout.defaultRemote and
> worktree.defaultRemote, but it's probably less confusing to break our
> own rules that anything shared between config should live in core.*
> than have two config settings, and I couldn't come up with a short
> name under core.* that made sense (core.defaultRemoteForCheckout?).

  core.dwimRemote ? It's a bit cryptic, though.

> See also 70c9ac2f19 ("DWIM "git checkout frotz" to "git checkout -b
> frotz origin/frotz"", 2009-10-18) which introduced this DWIM feature
> to begin with, and 4e85333197 ("worktree: make add <path> <branch>
> dwim", 2017-11-26) which added it to git-worktree.

Stefan
