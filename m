Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5505C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 22:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347677AbiBBWN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 17:13:27 -0500
Received: from mail-qt1-f177.google.com ([209.85.160.177]:39898 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbiBBWN0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 17:13:26 -0500
Received: by mail-qt1-f177.google.com with SMTP id e16so566831qtq.6
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 14:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ayMlPT/hZbbKMdEm7cpjYZlAjIOfD+JgBhTTh1niwhs=;
        b=TshHp2EhW6ZJDjrdsgm4UqzVUTy7eWAp0/Om7Zzy23lqg7S6oU2IKJQyd4NlrcL07B
         kBcR4+IkNQbonbBAEvirgVyaz4rtkw7VPnuVR4ENbS11bY+2EX4g2LL6ozQBYOC/iYvZ
         N/OS3hPkqYreHh7AgQ3OwP8KzfpAwPUVGi34ewMWK5o+CCUCmpw4Sx+q7gfuEBR1R1VO
         789aHzG83tntwYj0gGwt3CeryuaMp5y2Lv6xSEA/I8P855TTzqNfI2MUxs9YjAjsXaF7
         djWKQwVx/2af8oUj5Zqc9jOv/L/CrZbLS1UgndwJUYk3tdatCdSeQu4UnLIlGsbhe0CI
         zYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ayMlPT/hZbbKMdEm7cpjYZlAjIOfD+JgBhTTh1niwhs=;
        b=XiA2ELIpSRBNQwU/vwBBvmKH9E0j+aEDIQvzOhUpQUShEg89ozn8LEtj1vUvCRmOWd
         l0ZGV+GSF9zDY5p2aCmavyonkjGmEe8Bo8pyY0td4j8VjAKV31ju2fpTyhed9otrLbr8
         Ln6h6UxDMyeXv6+ahuvgmQdXPihDUacpBukgjdSB1wSblwCmk/wL9w1VMivmtDTgoZrT
         NYhSqyvsQoIogtsoWfA9V/GiNegEM1dnTMD8cfIbRsFvNqjgaQsKJugyU2ifYOmIet0r
         D71h+nIb1bjoEyCTuFBsCOrijtyQjTo2EPRs7ikuJdOqwDH/CJqufGHO3igNG8/CEj9U
         0BJA==
X-Gm-Message-State: AOAM531cecVgMUO5v11EVXSnrzifTBKl/USIVWzW1t5f94Kq1rpyZxRT
        UAajpyUc54z6cuZoKBsCWfBl52wMTAYHzB1J35m12Cqhfg4Zjg==
X-Google-Smtp-Source: ABdhPJwbp88G3w23gDzt9Xa8YEnOZz1LoWOXPYYJvUZmlG6N5jjC3/ryCyCfLtp0XgtGrMI33n6MKfDm4sTe4cd8YMU=
X-Received: by 2002:ac8:7e8c:: with SMTP id w12mr24828463qtj.342.1643839945783;
 Wed, 02 Feb 2022 14:12:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxUZpR8MBj+9mSb1Cr3PBCsAx=6zLo9mKpeD_ehqDP4nvQ@mail.gmail.com>
 <31e822be-b7c1-acb2-20d5-6db2200c3383@gmail.com>
In-Reply-To: <31e822be-b7c1-acb2-20d5-6db2200c3383@gmail.com>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Thu, 3 Feb 2022 00:11:48 +0200
Message-ID: <CAHMHMxWGqPT50Xsj4kcigoKJy7h0dM3J4UHBeGPMrUA9cs=C-w@mail.gmail.com>
Subject: Re: New `--reapply-cherry-picks` warning
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git <git@vger.kernel.org>, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2 Feb 2022 at 21:03, Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> ...
>
> > I am currently using the `[pull] rebase =3D true` option; and basically
> > that warning is also coming every time I am pulling.
>
> OK, that would mean either:
>
> 1- each time you are pulling, the upstream branch *did* get some of your
> local commits somehow, so the warning is justified
>
> or
>
> 2- the upstream branch *did not* get some of your local commits, so the w=
arning
> is shown but shouldn't be, and that's a bug.
>
> Which one is it?

No idea =F0=9F=98=85 I do a metric ton of pulls. "For fun", I also do
--set-upstream=3Dmaster on branches I am working on; pulling master (and
all of the branches) puts me at the latest point in time.
It could very well have been the former, since "at some point", I did
lose some changes.

However, it was "do" time; the debugging (and digging) came a little later.

> > I noticed that there is no way to "set" the `--reapply-cherry-picks`
> > in the gitconfig options.
>
> Yes, that would be a nice option to have indeed.

Fingers crossed? :-D

> > I prefer the rebase backend for the `git pull`; however, I see no way
> > of doing "what I want", with the exception of:
> > git fetch --all ; git rebase --reapply-cherry-picks
> >
> > Which is two steps, technically.
>
> Careful, as this is not the exact equivalent of 'git pull --rebase', as
> the documentation for that option states [1]:
>
>     If there is a remote-tracking branch corresponding
>     to the upstream branch and the upstream branch was rebased
>     since last fetched, the rebase uses that information to
>     avoid rebasing non-local changes.
>
> (see also paragraphs 2-3 of [2], [3] [4] and [5]).

So ... the workaround is not a workaround :-(

> > Also with every rebase I am doing, I'd have to remember that.
> > And it is probably not possible (by design) to do `alias.rebase =3D
> > rebase --reapply-cherry-picks` - which I understand.
> > (however, allowing aliases like `alias.x =3D x --cmd-opts` does not
> > sound "so bad" with me)
>
> Yes, that's considered "by design" that you can't alias an existing
> command using the exact command name. That is to make sure that scripts
> have consistent behaviour across users (other config options can still
> affect behaviour, but anyway that's the justification I've read before
> on the list). What I can suggest is using 're =3D rebase --reapply-cherry=
-picks'
> and then retrain your finger ;)

True. OOOOR somehow things that affect such behaviors are also given
an option counterpart?

I am not talking about `fetch.all =3D true`; however, if an option
warrants a warning, I'd say it deserves an option?
> ....
> >
> > With regards,
> > Ntentos Stavros
> >
> >
>
> Cheers,
> Philippe.
>
> [1] https://git-scm.com/docs/git-pull#Documentation/git-pull.txt--r
> [2] https://git-scm.com/docs/git-rebase#_description
> [3] https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---fo=
rk-point
> [4] https://git-scm.com/docs/git-merge-base#Documentation/git-merge-base.=
txt---fork-point
> [5] https://git-scm.com/docs/git-merge-base#_discussion_on_fork_point_mod=
e

With regards,
Ntentos Stavros
