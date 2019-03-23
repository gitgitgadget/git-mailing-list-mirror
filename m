Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C23220248
	for <e@80x24.org>; Sat, 23 Mar 2019 22:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfCWWSI (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Mar 2019 18:18:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35967 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbfCWWSH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Mar 2019 18:18:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id e4so4520337edi.3
        for <git@vger.kernel.org>; Sat, 23 Mar 2019 15:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y+Oil8ywo6fn9lWn7H5m6++J5PBv3soVAek82CKp84s=;
        b=pE5BtiK0ydJDTowFtCROSP/A/R/0dv0Z3kBZYn3EVnZ165joPIwGByVpzHU5dL61hi
         +O+Z4EBl6X8RkspJ5T0DeW2HANupMu0oA8VgxXZZkxfo/09gVJbcozQkAsu0dzVXRlRW
         5Ief0tVzNr6pH9d5y083v/xv1r/Ba/C7/0KVb/u0uCvADQDBgi/tQwZA6Y+fkjNRtcnM
         eTK78niwNXpDd4HV7gNCSvOkD2l75AktbZ114o5Fh4DRdS10BcGPoylUqZf0QRL4AObo
         NIcfCPUok2aPc+DaUgi0SheY68olE8zDUO/+Q4JcsFRS+sf/RuWuJ85wabwUp1ns7hPC
         3FYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y+Oil8ywo6fn9lWn7H5m6++J5PBv3soVAek82CKp84s=;
        b=GOdtUgCA1hIG8pcKfajCOri1SoEYZYZr0wyub/TfmB+CmilBHcvDorljiAV6I86Ai9
         9g2oIjzAOuDeXw+IA6IKBoD84l/+wPooXzSUqcsS44sPwCjYrqjMUakYIkqK9vNLVKX/
         3uV6IKDHC7fNUQnCQbOgH5Ht33p3+3GW6VOJfZFqXwRJRsIGsNnku0aOsCgc7haAwITY
         SSgs6YKJUAxFm4JFOPqOLO36N+3nVhjwNXyglKhagiq2YBG0VziapA1h3I94JjJHVCxH
         icdvNdf84GcgwyR3OC9W8w6TSid5uRE/DDP5lK9KAAy5YUqNnoRwv6t/tfE4AjuQNkqB
         fIZg==
X-Gm-Message-State: APjAAAUiPap+1jBdYH16Y9ExMK0hMbF7KEoHoCkjfy4aMmg9+Cv7Q7Kf
        5QwxSzu40wHdVMQHElY8rXEMO61Wp1z2SXCt6h9FuBGg
X-Google-Smtp-Source: APXvYqzC/7p/djp/+wHanQFTQYoamE31n6iKCA+PBIFngRTIgLNrTPk3C4s2g+uifvoT7Ev8w21V60ahVcY2FAdw3VE=
X-Received: by 2002:aa7:c250:: with SMTP id y16mr7489546edo.238.1553379485678;
 Sat, 23 Mar 2019 15:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAL7ArXqkVfrnQWYFDYdwMGkZjHCwzyQX4pbKCo=KCzy-zJiRBw@mail.gmail.com>
 <20190322151157.9550-1-rohit.ashiwal265@gmail.com>
In-Reply-To: <20190322151157.9550-1-rohit.ashiwal265@gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 23 Mar 2019 23:17:54 +0100
Message-ID: <CAP8UFD22PMjQBsAf1GYphmtmt8x+sO=q=c_4bHDsS8L31Y_3AA@mail.gmail.com>
Subject: Re: [GSoC][RFC] Proposal: Improve consistency of sequencer commands
To:     Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     git <git@vger.kernel.org>, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Ramkumar Ramachandra <artagnon@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Rohit,

On Fri, Mar 22, 2019 at 4:12 PM Rohit Ashiwal
<rohit.ashiwal265@gmail.com> wrote:
>
> Hey People
>
> I am Rohit Ashiwal and here my first draft of the proposal for the projec=
t
> titled: `Improve consistency of sequencer commands' this summer. I need y=
our
> feedback and more than that I need help to improve the timeline of this
> proposal since it looks very weak. Basically, it lacks the "how" componen=
t
> as I don't know much about the codebase in detail.
>
> Thanks
> Rohit
>
> PS: Point one is missing in the timeline from the ideas page[0], can some=
one
>     explain what exactly it wants?

You mean this point from the idea page:

"The suggestion to fix an interrupted rebase-i or cherry-pick due to a
commit that became empty via git reset HEAD (in builtin/commit.c)
instead of git rebase --skip or git cherry-pick --skip ranges from
annoying to confusing. (Especially since other interrupted am=E2=80=99s and
rebases both point to am/rebase =E2=80=93skip.). Note that git cherry-pick
--skip is not yet implemented, so that would have to be added first."

or something else?

By the way it is not very clear if the proposal uses markdown or
another related format and if it is also possible (and perhaps even
better visually) to see it somewhere else (maybe on GitHub). If that's
indeed possible, please provide a link. It is a good thing though to
still also send it attached to an email, so that it can be easily
reviewed and commented on by people who prefer email discussions.

> List of Contributions at Git:
> -----------------------------
> Status: Merge in next revision

Maybe "Merged into the 'next' branch"

> git/git:
> [Micro](3): Use helper functions in test script.

Please give more information than that, for example you could point to
the commit in the next branch on GitHub and perhaps to the what's
cooking email from Junio where it can be seen that the patch has been
merged into next and what's its current status.

> Status: Merged
> git-for-windows/git:
> [#2077](4): [FIX] git-archive error, gzip -cn : command not found.
>
> Status: Merged
> git-for-windows/build-extra:
> [#235](5): installer: Fix version of installer and installed file.

For Git for Windows contributions I think a link to the pull request
is enough. It could be nice to know though if the commits are part of
a released version.

> The Project: `Improve consistency of sequencer commands'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>
> Overview
> --------
> git-sequencer was introduced by Stephan Beyer <s-beyer@gmx.net> as his
> GSoC 2008 project[6]. It executed a sequence of git instructions to  <HEA=
D>
> or <branch> and the sequence was given by a <file> or through stdin. The
> git-sequencer wants to become the common backend for git-am, git-rebase
> and other git commands. The project was continued by Ramkumar <artagnon@g=
mail.com>
> in 2011[7], converting it to a builtin and extending its domain to git-ch=
erry-pick.

Yeah, you can say that it was another GSoC project and maybe give his
full name (Ramkumar Ramachandra).

There have been more related work to extend usage of the sequencer
after these GSoC projects, at least from Dscho and maybe from Alban
Gruin and Elijah too. I would be nice if you could document that a
bit.

> As of now, there are still some inconsistencies among these commands, e.g=
.,
> there is no `--skip` flag in `git-cherry-pick` while one exists for `git-=
rebase`.
> This project aims to remove inconsistencies in how the command line optio=
ns are
> handled.


> Points to work on:
> ------------------
>     - Add `git cherry-pick --skip`
>     - Implement flags that am-based rebases support, but not interactive
>           or merge based, in interactive/merge based rebases

Maybe the flags could be listed.

>     - [Bonus] Deprecate am-based rebases
>     - [Bonus] Make a flag to allow rebase to rewrite commit messages that
>           refer to older commits that were also rebased

This part of your proposal ("Points to work on") looks weak to me.

Please try to add more details about what you plan to do, how you
would describe the new flags in the documentation, which *.c *.h and
test files might be changed, etc.

> Proposed Timeline
> -----------------
>     + Community Bonding (May 6th - May 26th):
>         - Introduction to community
>         - Get familiar with the workflow
>         - Study and understand the workflow and implementation of the pro=
ject in detail
>
>     + Phase 1  (May 27th - June 23rd):
>         - Start with implementing `git cherry-pick --skip`
>         - Write new tests for the just introduced flag(s)
>         - Analyse the requirements and differences of am-based and other =
rebases flags
>
>     + Phase 2  (June 24th - July 21st):
>         - Introduce flags of am-based rebases to other kinds.
>         - Add tests for the same.
>
>     + Phase 3  (July 22th - August 19th):
>         - Act on [Bonus] features
>         - Documentation
>         - Clean up tasks
>
>
> Relevant Work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Dscho and I had a talk on how a non-am backend should implement `git reba=
se
> --whitespace=3Dfix`, which he warned may become a large project (as it tu=
rns
> out it is a sub-task in one of the proposed ideas[0]), we were trying to
> integrate this on git-for-windows first.
> Keeping warning in mind, I discussed this project with Rafael and he sugg=
ested
> (with a little bit uncertainty in mind) that I should work on implementin=
g
> a git-diff flag that generates a patch that when applied, will remove whi=
tespace
> errors which I am currently working on.

You mean Rafael Ascens=C3=A3o? Please CC him if he is involved in this.

Thanks,
Christian.
