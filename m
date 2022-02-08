Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C19C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 11:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356428AbiBHLcU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 06:32:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356384AbiBHKe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 05:34:59 -0500
X-Greylist: delayed 306 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 02:34:57 PST
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D601BC03FEC0
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1644316496;
        bh=yYZNDMTgMfF/DwevGm/c4sJNWCKrwJrLp9qpvPc+Mo8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kabr5cSbM+Ojr220YPW9KDxOswNkpfFxsA22ZXRuw61Mkcmin5h/lXUDXPc59/rUo
         cVoEoW9ef2OjuG9iVtYTJUH6aZuLaU5/GnkH09p63jQ/XCn5ifcZ3ciabf0j4qKZu9
         rDo943ST90ztxZvgDaWUncB5ybQOLcjZbqlRG3+Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.196.48] ([89.1.212.206]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1nbfGA1ptu-00LZ0i; Tue, 08
 Feb 2022 11:29:44 +0100
Date:   Tue, 8 Feb 2022 11:29:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] checkout/fetch/pull/pack-objects: allow `-h` outside
 a repository
In-Reply-To: <xmqqsfstett1.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2202081123430.347@tvgsbejvaqbjf.bet>
References: <pull.1139.git.1644277797.gitgitgadget@gmail.com> <25d1a2963f2934753de4fb6899429301637377c9.1644277797.git.gitgitgadget@gmail.com> <xmqqsfstett1.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:q5Be5j7JCa+vC8cT5eGthvu+tjuVGNB9dCXhgcz1f/g/8PVkKMu
 Vq2oFldXZXuP3J853qL1hCv21/grnRYevxKVvl/CXYEFxBXdXCjDB3x76YCL94eYefFkF3H
 v2tcZyBtkTIe8vgJhWEzcPuMaZ4qEetCmCOKQHAUWn86HEKftFmx50cEQy19hOpORS6NJmR
 G0J0tYRirx54GXBk8m0Jw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TYwTeZldYAk=:pWYBK6zS68dfOJVRJbVoPA
 nHEOh5GwqlbzLESWxj/1Ykp3GH6RB/3Xi665dkn3X1XoDzys8EOXX05ysD4rQD2mZ+1FMxkTi
 O5ZqirJPCCW0Kmosa/4Bp1vQr5ewgAWAOshgZ6xCElrPGpbARc86wULU8zRbrwSRYGaoYlNQo
 HJlOn6aW70mEkNMZumDwUkmYaI/eJC4MWZrtgPAXaLyFNOnkTFpOGh7Dokfwekhqkvp8lNhFW
 VVx8x5ixX8EYlsd9Ni/bxMkujMjwlnxnjfpkKEbPY3xAHWS4M8prwNFNv7j+D9mPYpRCDOp9i
 h8stkMi6VJ9jcLC8vQ+91YbXlmmHIQQUqvyeZJlIHjzvhatPrqjaoj/X6KxWhyJzSGBAxDi5E
 PAf1dk2oDlUA8GsRKsaXYa970yT+HjL/FFM3bmPYXcZbsKYC3JNl64Sj39GDpxXkYaR9TLaoB
 j9dGCGuIPN7TESzg3goIy8m8h/2d1Kq3cb4YcM4sIjmy+X4GJmsChfEs/6omiO4k9yvz49mWC
 N1X3Mf4VEpLYIXhCoa320FAwhqFiU+6KogwrwBV4LXvcgK0AIAEqmyAUNPLi/DnYv0cIkmead
 X8BvXaIfGNd9W9/vuUkvra1204zu52keM7W4hqZ1kO1l0+6uYBw3YowwtsLrRe5XMg5GNZJX3
 rl3CPv2sZ4VrMjAPt+ElBt+pJeh7diUorIncjSGx3HJRZSveSATSnkslnfXm9jixCe+t92rEM
 oTibn5qu9dnv79bzRgwyqa/h3Ru/3aO/6LQkgzBiP357FL8MNlgs8duC3v4/rN47yWGUug9Tm
 rBALsvc46eEmBhsOluyYcihjYYPrDLMC5a8nPMo4GPTa9bPgzkFSaeymIv1ZcFqTfVPtWmfev
 qDAUGMZieTxy3DsTSU+tZxrQU3Q1HclriX2C9q7cvkfhhC72sKNYuBg8wfGTZAYleUnpH/d+y
 rcAsrznbEdwois0hK8In1s+kG/UhQugDla+fdMKSdVgVv89JTvaeCXNI9GN8/4esSNXY66/RX
 Q0lo18lwmfvqi6wZUfO0JJgZnh/zZ74ZacLdJlBhCrhtRbBkjhYCrsQed6IpaiABNbLViLtUD
 Ed9KQkgStZXOFc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Feb 2022, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When we taught these commands about the sparse index, we did not accou=
nt
> > for the fact that the `cmd_*()` functions _can_ be called without a
> > gitdir, namely when `-h` is passed to show the usage.
> >
> > A plausible approach to address this is to move the
> > `prepare_repo_settings()` calls right after the `parse_options()` call=
s:
> > The latter will never return when it handles `-h`, and therefore it is
> > safe to assume that we have a `gitdir` at that point, as long as the
> > built-in is marked with the `RUN_SETUP` flag.
> >
> > However, it is unfortunately not that simple. In `cmd_pack_objects()`,
> > for example, the repo settings need to be fully populated so that the
> > command-line options `--sparse`/`--no-sparse` can override them, not t=
he
> > other way round.
> >
> > Therefore, we choose to imitate the strategy taken in `cmd_diff()`,
> > where we simply do not bother to prepare and initialize the repo
> > settings unless we have a `gitdir`.
> >
> > This fixes https://github.com/git-for-windows/git/issues/3688
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
>
> These "prepare" calls are always tricky.  This somehow reminds me of
> 44c7e62e (repo-settings: prepare_repo_settings only in git repos,
> 2021-12-06) and e5b17bda (git: ensure correct git directory setup
> with -h, 2021-12-06), which were part of the ld/sparse-diff-blame
> topic that was merged at 8d2c3732 during the last cycle.

Yes, and I did indeed imitate the way Lessley changed `cmd_diff()`. It
turned out to be much smarter than the first approach I tried (and that I
described as a "plausible approach" in the commit message).

> > diff --git a/builtin/checkout.c b/builtin/checkout.c
> > index cc804ba8e1e..1c13d7fedb3 100644
> > --- a/builtin/checkout.c
> > +++ b/builtin/checkout.c
> > @@ -1602,9 +1602,10 @@ static int checkout_main(int argc, const char *=
*argv, const char *prefix,
> >  	opts->show_progress =3D -1;
> >
> >  	git_config(git_checkout_config, opts);
> > -
> > -	prepare_repo_settings(the_repository);
> > -	the_repository->settings.command_requires_full_index =3D 0;
> > +	if (the_repository->gitdir) {
> > +		prepare_repo_settings(the_repository);
> > +		the_repository->settings.command_requires_full_index =3D 0;
> > +	}
>
> Looks quite straight-forward and sensible.  Of course, the checkout
> command will go berserk and do nonsense if it is allowed to proceed
> much further from here without .gitdir, but we know that
>
>  (1) the only case where .gitdir is NULL at this point is when
>      running "-h" from outside a repository (we would have done a
>      full RUN_SETUP without demoting it to RUN_SETUP_GENTLY if we
>      weren't doing "-h"), and that
>
>  (2) this is soon followed by parse_options() where it notices "-h"
>      and stops.
>
> so skipping "prepare" outside a repository is totally safe.

Indeed.

Plus, do not forget how the second patch in this series ensures that there
are no other calls that would get the hiccups when `gitdir` is `NULL`.

> > diff --git a/builtin/fetch.c b/builtin/fetch.c
> > index 5f06b21f8e9..e0a05de10ee 100644
> > --- a/builtin/fetch.c
> > +++ b/builtin/fetch.c
> > @@ -2014,11 +2014,14 @@ int cmd_fetch(int argc, const char **argv, con=
st char *prefix)
> >  	}
> >
> >  	git_config(git_fetch_config, NULL);
> > -	prepare_repo_settings(the_repository);
> > -	the_repository->settings.command_requires_full_index =3D 0;
> > +	if (the_repository->gitdir) {
> > +		prepare_repo_settings(the_repository);
> > +		the_repository->settings.command_requires_full_index =3D 0;
> > +	}
>
> Ditto.
>
> >  	argc =3D parse_options(argc, argv, prefix,
> >  			     builtin_fetch_options, builtin_fetch_usage, 0);
> > +
> >  	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
>
> Unrelated blank line?

Whoops, yes. I did mention that I first tried to move the call, right?
That's a left-over from not _completely_ cleaning up after that failed
attempt.

>
> >  		int *sfjc =3D submodule_fetch_jobs_config =3D=3D -1
> >  			    ? &submodule_fetch_jobs_config : NULL;
> > diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> > index ba2006f2212..87cb7b45c37 100644
> > --- a/builtin/pack-objects.c
> > +++ b/builtin/pack-objects.c
> > @@ -3976,9 +3976,11 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
> >  	read_replace_refs =3D 0;
> >
> >  	sparse =3D git_env_bool("GIT_TEST_PACK_SPARSE", -1);
> > -	prepare_repo_settings(the_repository);
> > -	if (sparse < 0)
> > -		sparse =3D the_repository->settings.pack_use_sparse;
> > +	if (the_repository->gitdir) {
> > +		prepare_repo_settings(the_repository);
> > +		if (sparse < 0)
> > +			sparse =3D the_repository->settings.pack_use_sparse;
> > +	}
> >
> >  	reset_pack_idx_option(&pack_idx_opts);
> >  	git_config(git_pack_config, NULL);
>
> This has a bit more sequence of calls until it reaches parse_options(),
> but their side effect, when run outside a repository, are all benign
> in-core effects, so this is safe, too.

And once again, I would like to point out that the regression test is
crucial to keep this benign.

I'll send out v2 shortly.

Ciao,
Dscho

>
> > diff --git a/builtin/pull.c b/builtin/pull.c
> > index 100cbf9fb85..d15007d93f3 100644
> > --- a/builtin/pull.c
> > +++ b/builtin/pull.c
> > @@ -994,8 +994,10 @@ int cmd_pull(int argc, const char **argv, const c=
har *prefix)
> >  		set_reflog_message(argc, argv);
> >
> >  	git_config(git_pull_config, NULL);
> > -	prepare_repo_settings(the_repository);
> > -	the_repository->settings.command_requires_full_index =3D 0;
> > +	if (the_repository->gitdir) {
> > +		prepare_repo_settings(the_repository);
> > +		the_repository->settings.command_requires_full_index =3D 0;
> > +	}
> >
> >  	argc =3D parse_options(argc, argv, prefix, pull_options, pull_usage,=
 0);
>
