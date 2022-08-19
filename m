Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B44C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 11:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348583AbiHSLmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 07:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348580AbiHSLms (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 07:42:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36668FF23F
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 04:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660909361;
        bh=wtJJ7S9Rw93uzX3YggOl/eFMuyQB74MDt/ScBMmtsKk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=huN4TXlqYHm6hz3VwWag4JtSvL42M4oz2hpCOhZuu4PVHj3X3SVRhTa6aoIKji+yU
         mfkc3DI5c/jNVl7imZTXBoVXEHeY+z3WeEDfvmaKpMPB5YyZWyNHER82YqS2Wdl3FO
         vNyOaWdR1okn9ycpDvWyLV5MCjYSekWqGDffVGJE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1nQqGQ25Fr-00yUF5; Fri, 19
 Aug 2022 13:42:41 +0200
Date:   Fri, 19 Aug 2022 13:42:47 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Rub=C3=A9n_Justo_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: allow "-" as a short-hand for "previous
 branch"
In-Reply-To: <986564d9-4d49-b1ef-e2e0-65d6f67f9e79@gmail.com>
Message-ID: <7s9s8p38-r22n-opnn-9219-0p49onrro70s@tzk.qr>
References: <pull.1315.git.1659910949556.gitgitgadget@gmail.com> <xmqq4jymvllq.fsf@gitster.g> <9693b83f-551e-e579-b267-af1d633dc381@gmail.com> <9so90892-25nr-0s4o-q98n-2qo76r3s89p3@tzk.qr> <986564d9-4d49-b1ef-e2e0-65d6f67f9e79@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-255755273-1660909370=:241"
X-Provags-ID: V03:K1:zgaE/XDJcWUw8b85ZhisXEgrQPpZ8T6mGxMvs+SVJCriEAluguv
 VH9HoRahNkZantsnmwC3J9vnS8GAiVATNnmn640b7TPSfx9KMCGMQY+Mf7VWasqfjhQNdhj
 cMSaeIQZAc4HEpR67rDnN+560FRgXzmgTBCIN5HsTxuVwQ9K5+hylc6bOXeeKM56cJRPtcc
 rEC9FY1ciPsb1GdXKiC4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XnOahWyTMaw=:1GQQsj4QrsT6KLbQHPrBFA
 SQBcFsJVp2+cNU3IicavLanSAmMwP1+gQFfoQTwrSQkYk78Egf5zaTfUSoSkVzpWU3WngtrjC
 2Xh9WPQoazSxkN8bAtMYtDw0XY4xebQqaNCTJPqrQxMphs5B+hL1m9n+OoM+G9D0m6rsr4EKQ
 PaimWw+ErCA5x569ri9wo3jQEvU9D5tGBBuGEooredPi4Ctu7EJmy6EXu596TwR/THiMCAtuN
 qfAjPTkfG70YOMVil+gPZ+W9fSWfKGadTcz+NGmZqMwmomW3+Fp8RlszFY623WyQOd3QMN+Ub
 938m2JCzibo9r6eC/MOoTvX86hEoUy7ujhgM99s+NFqudbLoIgSHVDbED4Ozhj0iIl0C5GQ4Z
 xdSJqEXIviP7DoX/ztCaId8gFXC8t81nFTMscl5uSg2gysxu+1AvCMXXFEfle06CLuQMflx/Y
 x18R7iN/RGt2J+y6hYgngwC0nOVQdVVwuq6KFxllbHcSbmvd8qVRYRGXa8g8roW8j9KVu5cRY
 ZI2OEdFJIZs/I95iK4cHWfjTJ8BtTmN+WvRyqyqjOlvweoMW3yco3EjjPM5OPT6C8sveY9l4W
 N7QpGs4OcalMDnMQJk5uc/1WDjL42rP4cUf9VHnK/3U3V/qmQF58VwuD7G+NZdnl35VZQ+SQv
 iEkUb034ANa6O5MBkhpNt7VrPEWbEM4ZhNixTpuxFj6Q26orZ/IL/aCjvMbbtTjJsmqTdY1TQ
 /k4oI1K1/iRJCe4KjL3BBD3GjXCcGeX9ipCLBr6hAVNIahq/RPkjOt+ugDU0ooY0qedyeS7Z9
 8LI/1Gk5lgK9+lwl6n7YXQXzAcxoj1xweMTidL6yUpcYfrEi3bsvDqz74AjPET6BldDTC6d4S
 4UDYwhWtqOv6KbCiThs2/F59j4e742eRdoRykECmXWeEE7G6S1Xv0H+oEt0jS1td8fqQuQPRJ
 8a5PWJ/BpzC3AGKl1XA7fg5j0G/ultGwVf3Y3GPk7mbSDnaXgJ41C1jSsd2y/SHEz/oJLxto7
 IaJ6Cg/SeQuJ76/+rol6IGNWGMv2Cq9PbEV7hRfsdaJvfnnDZfoPdabTHPOJxu3iejtD5LUak
 rqiTp6EcvmVv18PdKblj7FwOT10tXtpUNLOlqyUWd5mPIPuM8kQ4VyJLg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-255755273-1660909370=:241
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Rub=C3=A9n,

On Tue, 16 Aug 2022, Rub=C3=A9n Justo wrote:

> On 8/16/22 11:31 AM, Johannes Schindelin wrote:
>
> > > $ git merge - old-branch
> > > merge: - - not something we can merge
> >
> > This is confusing me: how is the patch supporting `git branch -d -`
> > aligned with the presented `git merge` invocations?
>
> "merge" supports multiple objects to be specified, but "-" only is accep=
ted if
> just one argument is specified, as Junio did it in:
>
> commit 4e8115fff135a09f75020083f51722e7e35eb6e9
> Author: Junio C Hamano <gitster@pobox.com>
> Date:   Thu Apr 7 15:57:57 2011 -0700
>
>     merge: allow "-" as a short-hand for "previous branch"
>
>     Just like "git checkout -" is a short-hand for "git checkout @{-1}" =
to
>     conveniently switch back to the previous branch, "git merge -" is a
>     short-hand for "git merge @{-1}" to conveniently merge the previous
> branch.
>
>     It will allow me to say:
>
>         $ git checkout -b au/topic
>         $ git am -s ./+au-topic.mbox
>         $ git checkout pu
>         $ git merge -
>
>     which is an extremely typical and repetitive operation during my git=
 day.
>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> diff --git a/builtin/merge.c b/builtin/merge.c
> index d54e7ddbb1..0bdd19a137 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -1062,9 +1062,12 @@ int cmd_merge(int argc, const char **argv, const =
char
> *prefix)
>         if (!allow_fast_forward && fast_forward_only)
>                 die(_("You cannot combine --no-ff with --ff-only."));
>
> -       if (!argc && !abort_current_merge && default_to_upstream)
> -               argc =3D setup_with_upstream(&argv);
> -
> +       if (!abort_current_merge) {
> +               if (!argc && default_to_upstream)
> +                       argc =3D setup_with_upstream(&argv);
> +               else if (argc =3D=3D 1 && !strcmp(argv[0], "-"))
> +                       argv[0] =3D "@{-1}";
> +       }
>         if (!argc)
>                 usage_with_options(builtin_merge_usage,
>                         builtin_merge_options);

Ah, the vagaries of being a maintainer and everybody following your lead,
even if you have a bad day and are grumpy, or as in this case just want to
get a quick fix in that supports your workflow better, and then move on.

If you read the commit message carefully, you will note that there is no
justification for restricting it to the `argc =3D=3D 1` case.

I assume that the implicit rationale is that it was just simpler to do it
this way.

The alternative would have been to modify `collect_parents()`, or even
`get_merge_parent()` (which has many more callers), and at some stage the
investigation would have been as involved as it will be in this here
thread.

However, it is one thing to integrate such a patch as a one-off, or do it
two times, or three.

It is another thing to do this again and again and again and seeing that
we're not getting anywhere and only piling hack upon hack.

It is this latter stage that we have arrived at.

> So I aligned "branch -d" (or "delete-branch") with that.
>
> The other two commands that already support "-", also works the same way=
:
>
> $ git checkout -B - default
> fatal: '-' is not a valid branch name
>
> $ git rebase default -
> fatal: no such branch/commit '-'
>
> To summarize, my goal is to allow:
>
> $ git checkout work_to_review
> $ git checkout -
> $ git merge - # or git rebase -
> $ git branch -d -
>
> Makes sense to me...

There are different qualities at play with these commands, though. `git
checkout` cannot support more than a single revision argument. With `git
merge`, technically we do support more than a single revision argument
(via octopus merges), but support for it is limited (for example, we do
not even support recursive octopus merges). You might say that it is
discouraged to call `git merge` with more than one revision argument.

With `git branch -d` or with `git branch --list`, we are in a different
league. Those commands are commonly called with more than just a single
branch name.

And then there are the other commands that would benefit from support for
`-` and that accept many more than one revision argument, too, such as
`log`, `rev-parse`, `merge-base`, etc.

Sure, we can accept one more one-off hack to support a single `-` argument
to refer to the previous branch. The sum of those hacks, however, becomes
a burden.

Ciao,
Dscho

--8323328-255755273-1660909370=:241--
