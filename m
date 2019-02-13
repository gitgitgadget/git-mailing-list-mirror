Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61B46211B5
	for <e@80x24.org>; Wed, 13 Feb 2019 22:37:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392506AbfBMWhG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 17:37:06 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:43712 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727471AbfBMWhF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 17:37:05 -0500
Received: by mail-ua1-f66.google.com with SMTP id z11so1358125uaa.10
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 14:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1CiWfbLzK7PELX/lplA6gdIZ7N7LCybk3mYeEY+Nc5g=;
        b=lE85j0Pt4X7S/rntZzjrEPeNZpNkBUkGMzk1/dvnoXsg7ReuGSyZ20cxesoEvdNENf
         nrKtI+RiDrKElVNi3T6pji8yrv+M9kooljhrcdhQwkn9MyBjBcs2LjcG12rbFYmT+Ze4
         PkF77cTBeE3ELLg6Kqx0Wppjjvt9tiOedMTlTgl/UbuhGsSp7H0D2/79xnnt8wMzo0hH
         I0mWY1jZZ6kbytT/fBqG7Vgr8QglTJ5LDcpo06KQycBDkwudyZg2/eZMZzY9iHJU2Y7q
         C74Hp3dI171anIQYbhJJMZlLpi7NBLzaixtEZ2xqqL6Bp1x+W9Gk66zd8vxEJl9rTGVf
         wcmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1CiWfbLzK7PELX/lplA6gdIZ7N7LCybk3mYeEY+Nc5g=;
        b=sS+S7Q147hu22OuY0xVh2XyOLFUb08m4ZDYOzRJOvU5Xwk+vTOKr82B/6c4iYSTDi6
         +8zKCH0c0yDy+FYiI1R8qL5S2kBrVVzJwFnvo+nEdOf17UraODqXbpXgdaLS2yGMHf8J
         VdgWVMS80BpIusk5KgcvKxDxDG2WbhJBSXhS2h6dTWJ/3Y02tCcXY/tXSQae6TEAWSpl
         q+1SoB6nzZV+QHsnsNilzL/O6wdECjeFoOFAlT9sVCEra615lzKg3+4nCxL6BKTkG7rH
         3B63Z1SF2iRdSa/t5nglqTapgtIJGIbgLmCgxBGzJQWRJetWzhYHS+I2OA9qzqoVe4jd
         4bPw==
X-Gm-Message-State: AHQUAuYVk2O1IIj/keylk5vdu/mcVj/Jkvsui9fqxWniDmkQEb32WEoU
        wtH5qg6UfaRipcjLYyJuywVSG/F+NId3oDaeFyw=
X-Google-Smtp-Source: AHgI3IY25PfOBC2c4aEN4EK61t5A566Hn8vvtUQy9Kb0BA5vtjku2eLeKdWiCXPDutTx5RMajR9GorzevSJm11+uVzo=
X-Received: by 2002:ab0:7191:: with SMTP id l17mr332933uao.28.1550097424003;
 Wed, 13 Feb 2019 14:37:04 -0800 (PST)
MIME-Version: 1.0
References: <CAP8UFD2kt=Rv4pC67q0s+CKjgmBON_KkK09igfwe-0709Di2RQ@mail.gmail.com>
 <20190204215251.GB6085@hank.intra.tgummerer.com> <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com> <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com> <CAL21Bmkkpzp7fhAnjstTjeH+unDFk8-uhFAgKFfuczYzejf2RA@mail.gmail.com>
In-Reply-To: <CAL21Bmkkpzp7fhAnjstTjeH+unDFk8-uhFAgKFfuczYzejf2RA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 13 Feb 2019 14:36:51 -0800
Message-ID: <CABPp-BGNMN0QZWa4E4kBFOs8RcUQoMuMT2J_zKhwOTQPbaGU4g@mail.gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
To:     =?UTF-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Matthieu Moy <Matthieu.Moy@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 10, 2019 at 9:51 PM =D0=9E=D0=BB=D1=8F =D0=A2=D0=B5=D0=BB=D0=B5=
=D0=B6=D0=BD=D0=B0=D1=8F <olyatelezhnaya@gmail.com> wrote:
>
> > It would be nice to have a few more project ideas.
>
> I am not sure I have additional ideas for 3-month project for the intern,=
 but
>
> > https://git.github.io/SoC-2019-Ideas/ currently lists only 2 possible
> > projects:
> >
> > - Unify ref-filter formats with other --pretty formats (which is new)
>
> I am ready to act as a mentor in this task, I know that part of
> project good enough.
> I have additional related task: We have a function called
> oid_object_info, it allows to download meta-info of the file. It was
> used in cat-file, and inspired by that example, I improved ref-filter,
> so now ref-filter works faster with it. Moreover, I have found that
> oid_object_info allows to get the contents of the file. It was useful
> in ref-filter, and actually it could be also useful in cat-file, but
> we still download the file differently in cat-file, and it looks
> awkward. I need to make just one last move to finish my patch: it will
> close the task about migrating cat-file formatting logic to
> ref-filter. But cat-file still will not use general way to download
> the file. So, the task is to get rid of additional file-reading logic.
> I guess this task is much smaller than original one, but at least the
> student will have chance to finish it in 3 months.
> My patch is here: https://github.com/git/git/pull/568
> But I hope you will also see it this week in the mailing list.
> Proposed task is in TODO in the end of ref-filter file.
>
> By the way, we had a letter from Google, it is said that our tasks are
> sparsed. I am not sure I understand it correctly. Should I help the
> project somehow to solve our issues?

I'm a little hesitant to suggest this as I'm not sure how available I
could be for mentoring and don't view myself as a good mentor, but
another project idea which has lots of sub-pieces and thus could show
progress and be useful even if not everything is completed:

Consistency of sequencer commands:
* The suggestion to fix an interrupted rebase-i or cherry-pick due to
a commit that became empty via 'git reset HEAD' (in builtin/commit.c)
instead of 'git rebase --skip' or 'git cherry-pick --skip' ranges from
annoying to confusing.  (Especially since other interrupted am's and
rebases both point to am/rebase --skip.).  Note that 'git cherry-pick
--skip' is not yet implemented, so that would have to be added first.
* There are a handful of flags that am-based rebases support that are
not available to interactive/merge-based rebases; it'd be nice to
implement them for the interactive machinery.  (There are also
numerous flags that only the interactive machinery supports that are
unavailable to am-based rebases, but I don't care; I want to deprecate
am-based rebases.)
  * --ignore-whitespace (transliterate to -Xignore-space-change?)
  * --whitespace=3D...
  * --committer-date-is-author-date/--ignore-date
  * -C4

[There's also some empty handling (from "Behavioral Differences" in
Documentation/git-rebase.txt) that would be nice to address, though
that might be contentious and I might try to tackle that piece before
GSoC gets rolling...]

Bonus: Make a flag to allow rebase to rewrite commit messages that
refer to older commits that were also rebased.  (i.e. if rebasing
commits A and B, and commit B says "This reverts commit <sha-of-A>,
then rewritten B's commit message should say "This reverts commit
<sha-of-rewritten-A".)  Do this for both sha1sums and sha1sum
abbreviations in commit messages.
