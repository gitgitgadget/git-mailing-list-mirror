Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1BAC2D0DB
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 15:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DF5D206D3
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 15:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJSHtGhp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgAaP7b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 10:59:31 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52379 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbgAaP7b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 10:59:31 -0500
Received: by mail-wm1-f66.google.com with SMTP id p9so8460210wmc.2
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 07:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U/z1jWJv/ET3B5TCVIe0iTz7pYTrgGsW3DEqXdIA8YU=;
        b=VJSHtGhp0pw3K2DwEA2foCNGXAz9U0PEMaFWoAn2rlYyhC+tktUu8A27fO2dDI2be5
         EtMj/kL6OVKN+4d23Ly1WMiRIu9ms9siPMrMKIb6eG8HDu/3yawGfVUUHgoWKbWQN3QJ
         MQ0Mo6PDPsp0Gjke9k9mWpFg7doyWHYynkaDSktUY6E4KMkn0G7rHDyn88UZ+m7kmrKN
         FjK8hgpeVF2gbdjd1fcQbCcnuUm7qLlm39PCHvrOo45UVsRKxrCz2mwpWN3vmu8tdK6J
         1m1esUBq9Gl6+xemMHMtbinI8iYUqKyuyVLrc6ooZ4Rn9M9/QFnLhG62rQWDYE4VSyDX
         ZNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U/z1jWJv/ET3B5TCVIe0iTz7pYTrgGsW3DEqXdIA8YU=;
        b=gQZCfCwu0SzI2NZ0MQPRB0ju/KNMu/imWVGbm7yh5GUzww4uA/Xg8GkwwTRYJIGjcA
         Mi6FUh/G41vFFIddAKmH8wT2qZ4t8CbaS7G4LAP1lKPfBrDeeGiolHKzlmE7TvUhDLGN
         CTws5ebmPTsL7l75H02hIWuwx2A/2oe0OwKBMS6xNSSTq9GjfFRFkdda1Isa4HnuFIXM
         2MrHz4zJYqxno4KyF6tHEBxsrFdK4kR8/BCchtPI85NX0S2mBvKJTVkdvoIfY8+E0mtk
         ix8jcVbFeaZGQWkSkf8rlhQD1YZcju0bXaNE/XU9260uFeqfFY4NHxXRSUtnX/UX6Qzr
         xuEg==
X-Gm-Message-State: APjAAAV6YZaTD18tJ1dM577L6ZufL9tcW5p7p3hc2bJNjYn+lJLZ5e0G
        Qj5HXMJ+790DoUUtBDvpzBvp7x2i30CzPlg9Hio=
X-Google-Smtp-Source: APXvYqxK02oLIUEL7aH3WRIV35fW7qYwZr2XX99WqVm+7ea+KoIE7103eERN/ugqXDDvLThgOy1sMWPb3yTnuhMDvMQ=
X-Received: by 2002:a7b:cb97:: with SMTP id m23mr12211895wmi.37.1580486367437;
 Fri, 31 Jan 2020 07:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20200111123533.1613844-1-marcandre.lureau@redhat.com>
 <CAPig+cQXkiFOz5HczPEgXuSOH_3KsCwXwVwe0qvQzLDtFgnAXw@mail.gmail.com>
 <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev> <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev> <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
 <20200131155228.GF10482@szeder.dev>
In-Reply-To: <20200131155228.GF10482@szeder.dev>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date:   Fri, 31 Jan 2020 16:59:15 +0100
Message-ID: <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Fri, Jan 31, 2020 at 4:52 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Jan 30, 2020 at 10:37:38PM +0100, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Fri, Jan 24, 2020 at 11:41 PM SZEDER G=C3=A1bor <szeder.dev@gmail.co=
m> wrote:
> > >
> > > On Sun, Jan 12, 2020 at 08:59:04PM -0500, Eric Sunshine wrote:
> > > > On Sun, Jan 12, 2020 at 7:14 AM SZEDER G=C3=A1bor <szeder.dev@gmail=
.com> wrote:
> > > > > On Sat, Jan 11, 2020 at 08:27:11PM -0500, Eric Sunshine wrote:
> > > > > > Taking a deeper look at the code, I'm wondering it would make m=
ore
> > > > > > sense to call wt_status_get_state(), which handles 'rebase' and
> > > > > > 'bisect'. Is there a reason that you limited this check to only
> > > > > > 'rebase'?
> > > > >
> > > > > What branch name does wt_status_get_state() return while bisectin=
g?
> > > > > The branch where I started from?  Because that's what 'git status=
'
> > > > > shows:
> > > > > But am I really on that branch?  Does it really makes sense to ed=
it
> > > > > the description of 'mybranch' by default while bisecting through =
an
> > > > > old revision range?  I do not think so.
> > > >
> > > > It's not clear what downside you are pointing out; i.e. why would i=
t
> > > > be a bad thing to be able to set the branch description even while
> > > > bisecting -- especially since `git status` affirms that it knows th=
e
> > > > branch?
> > >
> > > No, during a bisect operation 'git status' knows the branch where I
> > > _was_ when I started bisecting, and where a 'git bisect reset' will
> > > eventually bring me back when I'm finished, and that has no relation
> > > whatsoever to the revision range that I'm bisecting.
> > >
> > > Consider this case:
> > >
> > >   $ git checkout --orphan unrelated-history
> > >   Switched to a new branch 'unrelated-history'
> > >   $ git commit -m "test"
> > >   [unrelated-history (root-commit) 639b9d1047] test
> > >   <...>
> > >   $ git bisect start v2.25.0 v2.24.0
> > >   Bisecting: 361 revisions left to test after this (roughly 9 steps)
> > >   [7034cd094bda4edbcdff7fad1a28fcaaf9b9a040] Sync with Git 2.24.1
> > >   $ git status
> > >   HEAD detached at 7034cd094b
> > >   You are currently bisecting, started from branch 'unrelated-history=
'.
> > >     (use "git bisect reset" to get back to the original branch)
> > >
> > >   nothing to commit, working tree clean
> > >
> > > I can't possible be on branch 'unrelated-history' during that
> > > bisection.
> > >
> > >
> > > OTOH, while during a rebase we are technically on a detached HEAD as
> > > well, that rebase operation is all about constructing the new history
> > > of the rebased branch, and once finished that branch will be updated
> > > to point to the tip of the new history, thus it will include all the
> > > commits created while on the detached HEAD.  Therefore, it makes sens=
e
> > > conceptually to treat it as if we were on the rebased branch.  That's
> > > why it makes sense to display the name of the rebased branch in the
> > > Bash prompt, and that's why I think it makes sense to default to edit
> > > the description of the rebased branch without explicitly naming it.
> > >
> > > With bisect that just doesn't make sense.
> >
> > If the range you are bisecting belongs or lead to the current branch,
> > that still makes sense. And it's probably most of the time. So, I am
> > not sure your objection is valid enough here.
>
> I'm not sure what you mean with "belongs or lead to" a branch.
>
> Do you mean that the range is reachable from the branch that just so
> happened to be checked out when the bisection was started?  Well, I
> have over 30 branches from where v2.25.0 is reachable, and all of them
> are obviously bad candidates for editing their descriptions by default
> while bisecting a totally unrelated issue.
>


If we take that simple example:

* (my-branch)
*
* bisect bad
*
* (HEAD)
* bisect good
*

It makes a lot of sense to me to edit my-branch description by
default, even if the range good-bad happen to exist in other branches.

--=20
Marc-Andr=C3=A9 Lureau
