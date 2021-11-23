Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E3BC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 03:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbhKWDOX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 22:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhKWDOV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 22:14:21 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B680C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 19:11:14 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id x6so73601781edr.5
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 19:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PqNKGXFsR24uVFZilKU9nDHDyZCT59VFu9Owg8FTaLs=;
        b=ZQCaP2czsfwJxVw2kLyCj3dzL4F0TlrJwP6jNzErB8Rweh5L0BLxYN+Mds/IdMvsXj
         LaNEzEKaQpgp86EWPRZMaWG4HDGuFVO/4jpvFXeTlb6l98yVMWEuIhgZ0MupeUEpPjsY
         Mm+O3mdJsL93szBs1HVMUqKAHLxKGc76eSxpSn57eiSoKfNmoeSsk2ZJ4zpFdQEOZMHa
         eORpIqbmBDJlLdbxKVJH5jDRLq1avtSdcWmCxCQlFalct93xYAtREbLAcUYrpCUXVA+l
         nFhZZ0fbfMtRLyHME170o40OADt6lEXDQF5uwuwxHi0EZWgv64x5liBQokwtcULokU1f
         KydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PqNKGXFsR24uVFZilKU9nDHDyZCT59VFu9Owg8FTaLs=;
        b=V8/YwdZlJct8SLaEUwCc4YClcC3rF2foEzWnbfAvE/R9/2W0gZmm69ZcTwWXIm+aCF
         s4PzK8ZRpesDStT55HGWby8L689VfeyVAxukqYHuhG4DkC5+IfKCB5IqoBWhoIEUzcz4
         laRn+wUJ4/BbhC3zKFdygeMQPmD8BqGtizLcmbPRUaeME7AjcUJDgPT2z/Svlkw2OhAv
         EtkCkQTbVizUKntpa1p4w9Z7zndtxCriJ8Z/OK0dmfdrn7Jyo6reyvQNiVArgZurMSqN
         x99aLPRrmIzIkrpc+1i3mkWJbX7RZ1fj9PXzO6EzKFPQp4vUqv8+TGtdvR4HVC1bqDlX
         GWgQ==
X-Gm-Message-State: AOAM531iVeqI9z7x/b+0zI38we7eVhuySh/zVE2OB7jcY0yHdVf3YX3x
        jbzHB7KJo3Hj8aHA1zT6bLu3jH2O2trE8CWH+3R50vM0DGw=
X-Google-Smtp-Source: ABdhPJw8DTEidLRzvKqXDHz5p+KqdLsI9sIBNuAG8hWkfh1wt3SwwY3Safu44bsqJTMr65BwMqHziNwR1CGbKPBKBaM=
X-Received: by 2002:a50:d543:: with SMTP id f3mr3675706edj.56.1637637072752;
 Mon, 22 Nov 2021 19:11:12 -0800 (PST)
MIME-Version: 1.0
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
 <0b71996a3b462d4147fb792b20057544b9ef1710.1637455620.git.gitgitgadget@gmail.com>
 <211121.867dd11jbl.gmgdl@evledraar.gmail.com> <CABPp-BEp3OL7F2J_LzqtC-x-8pBUPO8ZR1fTx_6XbqZeOH1kRw@mail.gmail.com>
 <211123.86czmrwqqo.gmgdl@evledraar.gmail.com>
In-Reply-To: <211123.86czmrwqqo.gmgdl@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 22 Nov 2021 19:11:01 -0800
Message-ID: <CABPp-BH-MtGLAk3vkFCXr8sB3KmMEp98J1wpjO=v6MbXH4tPHg@mail.gmail.com>
Subject: Re: [PATCH 1/8] t2501: add various tests for removing the current
 working directory
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 6:27 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Mon, Nov 22 2021, Elijah Newren wrote:
>
> > On Sun, Nov 21, 2021 at 9:59 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> > <avarab@gmail.com> wrote:
> >>
> >> On Sun, Nov 21 2021, Elijah Newren via GitGitGadget wrote:
> >>
> >> > From: Elijah Newren <newren@gmail.com>
> >>
> >> > +test_expect_failure 'checkout fails if cwd needs to be removed' '
> >> > +     git checkout foo/bar/baz &&
> >> > +     test_when_finished "git clean -fdx" &&
> >> > +
> >> > +     mkdir dirORfile &&
> >> > +     (
> >> > +             cd dirORfile &&
> >> > +
> >> > +             test_must_fail git checkout fd_conflict 2>../error &&
> >> > +             grep "Refusing to remove the current working directory=
" ../error
> >> > +     ) &&
> >> > +
> >> > +     test_path_is_dir dirORfile
> >>
> >>
> >> I'd find this & the rest of this series much easier to understand if w=
e
> >> started out by positively asserting the current behavior here, and
> >> didn't test_cmp/grep for erro r messages that don't exist anymore.
> >
> > Yeah, this is my fault for my bad commit message.  I stated I was
> > adding tests checking for the problems of interest, making it sound
> > like I was testing existing behavior, but I should have stated I was
> > adding tests with the behavior we'd prefer to have (i.e. basically a
> > test-driven-development) setup.
> >
> > Also, there really wouldn't need to be so many tests for describing
> > the existing behavior.  It's basically just `git
> > $OPERATION_THAT_REMOVES_CWD_AS_SIDE_EFFECT` followed by nearly any
> > other git command will cause the second and later commands to fail
> > with:
> >
> > ```
> > shell-init: error retrieving current directory: getcwd: cannot access
> > parent directories: No such file or directory
> > fatal: Unable to read current working directory: No such file or direct=
ory
> > ```
> >
> > However, we do need a lot of tests for corrected behavior, because
> > there are so many different codepaths we can follow which will lead to
> > deletion of the current working directory.
>
> Currently if I do e.g.:
>
>     git checkout master
>     git clean -dxf
>     cd perl
>     git checkout v0.99
>     cd ../
>     git clean -dxfn
>
> Nothing breaks and I don't end up with an empty perl/ to remove. With
> these patches we'd either die on the "checkout" (I think) keep the
> "perl" and have an empty perl/ to report in the "git clean -dxfn" at the
> end (I'm not sure which, I forgot and haven't re-read this series just
> now).

You'd have an empty perl/ left after the checkout, which would be
cleaned up by your final git clean command.

> I think changing it anyway might be justifiable, but changing the
> behavior of things like that tickles my spidey sense a bit. I.e. I can
> see people having written scripts like that which would break (it's
> often easier to cd around after globbing than staying at the top-level,
> then jump back).

I disagree this would break any user scripts.  If people expect a 'git
checkout' or 'git rebase' to always work, their script is _already_
broken.  The presence of any untracked files within the directory
already results in a hard error -- we refuse to remove non-empty
directories (unless all files are tracked and unmodified).  This rule
deserves a clarification: treat the current working directory as
non-empty since the parent process is likely still parked there..

Further, our own commands are broken/misbehaving due to us not
erroring out; see e.g.
https://lore.kernel.org/git/xmqqv93n7q1v.fsf@gitster.g/ and its
grandparent.  User scripts likely have lurking problems too.

> So I wonder (especially with Glen's comment in
> <20211123003958.3978-1-chooglen@google.com>) if this is being done at
> the right API level.

Glen's comment was interesting, but provided no specifics about how
the changes I made could cause any possible harm in his case.
Further, the fact that others are adding extra places doing cleanup
sound like additional codepaths that should be protected for the exact
same reasons.  I think we absolutely want my changes affecting his new
codepaths.

> E.g. maybe it would be better for some commands to
> ease into this with an advise() or warning() and not a die() or error(),
> or have the die() be in the likes of "git switch" but not "reset
> --hard".

The commands that don't need to remove the current working directory
but just were as a convenience, no longer do and continue on just
fine.  Commands that need to remove the current working directory in
order to place a file there will error out, just as they would have
when trying to remove a directory with untracked files.  I see no need
to ease into anything here.

> Or maybe not, just food for thought...

You may also be interested in reading more of the other thread I
linked to from my cover letter; all these cases were discussed in good
detail over there.  For example, look at
https://lore.kernel.org/git/CABPp-BFmU+RaAjq4_0-PSfRgH1Jc63nN0fMuDWk2+iDbdz=
7CCA@mail.gmail.com/.
Peff's previous suggestion was to just make the commands error out if
they'd normally remove the current working directory and require the
user to run from a different directory instead.  My version lightened
that requirement so it only errors out if the current working
directory needed to be removed in order to place something else there
(and if nothing else was needed to be placed there, then just leaving
the directory around).
