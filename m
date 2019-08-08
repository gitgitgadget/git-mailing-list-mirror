Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63C811F731
	for <e@80x24.org>; Thu,  8 Aug 2019 19:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390253AbfHHTss (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 15:48:48 -0400
Received: from mout.gmx.net ([212.227.15.18]:46443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731038AbfHHTss (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 15:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565293712;
        bh=qB0ipPDZH3vOEwRNB8RgbGWLluuoCGtnOKL+ITCZOfw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=k3Lw9bE4MAuntg1sJXRK3nix5iPnCOU95yIcTXr2HhPOeW9gqIpnpM+Lm4C9q/eNg
         GmPsel8iytC5qazhy3tbJR6fMKpJq3wGBhR71w2o9+zb2dTKIWpysj8BxD/huy0DzJ
         TW3Z0YJnJ8yNhOrO+jKhRWWqDJeUuCX2lCxTCne8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOzOw-1hfDLw2Z3c-00PLOO; Thu, 08
 Aug 2019 21:48:32 +0200
Date:   Thu, 8 Aug 2019 21:48:31 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] config: stop checking whether the_repository is
 NULL
In-Reply-To: <20190806124954.GA13649@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1908082147190.46@tvgsbejvaqbjf.bet>
References: <20190806122601.GA21475@sigill.intra.peff.net> <20190806122758.GC13513@sigill.intra.peff.net> <20190806124954.GA13649@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ItK8r3xwTSAx0ZV6nROjAE/GpXyTBNaVJZvHAzZwh4wE9VEQH/h
 mdZ01RLocdgUdtqaZElYk1lqvfT5vcMIm5B4gwjrM5Pgm65+IWf6Y+UlHfg4LYIAq791y0c
 OVR3sSXCPfJ25Vp2GowqwbjvFq4xGp/gl829DA9Ptm7NQ3VamzBOBLwEIwDxldD5jhJ17zf
 X2uXxJND4O0X0wsTiKUEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4NddPWNwYWY=:Yby79c3oySxGdlMNUIFSUo
 M4wMOYg3fGNAbO7DZAONTniM3f2AWN+mcxbP337udc69POrwwvO0DYBYJ4lX+GDg66F4aCipw
 Z/7QZIK63r98E+ts42kKxvBuaOlywoe5tihPpsK7HDo76mRURi+y+Yci4DwEGDXLWWuKcNKVl
 g1qztxE7eb/yszilxhHE/Ac+Wtp4iyUcjaT/49kk3GsI5c71hbhRT4gmXj7B0R9pBwa/jCvi8
 1d10S5vRh+DTj2UUJpAPvyjuXsaW3vG611qIB7cMD7f41cC9RNbwj4NybMjSth5oCF6BujY/2
 MKPw3arKtQNW1Nt/tN6tGv7WPsAN+S30Ss5V33Vw7SXWGbncxwz8wLNtNtcO1erYNiH5PzuPd
 17E9Q83RZ6kfZgE8aLc9syrben27KQMpQYvX+AktAU1L1b0T4+gJeUef0fxwGw5WQqagV9GuG
 Wktsr8MMOhvNrFX8fiAtz4FXxgu+1zgJbtIxf6ZROPgBzdG71O2mvWTCzCA8nSojCZo0/c9KM
 RQb6YOkFZlQpqJQKVLSc++SOmhZ+RCPJMFukJckHgonvR9S2o2EYC7UI0rk5pR5DJWKhFQ4sG
 fLvE8PlMIQz0t1Y3JxBgtKFQ8VcLaT88QPs/mJzJZlZo5ns4x4Qj46FdNpGZYVHb5/BRF2rgW
 LbaX7k/u/fcugx9uoTXskpRKBbcRkV6S9fq17Ln/dHY815cpnU774g+YhgmanSq7knF4O3Qkq
 0/inmMG9fe9PJr4n41iOHaEvH4q08Bvcbf4Q1IwAirzGRrmsiSnetNHTCA2LtLG+/nrn21QHQ
 Lba9X4Fdzzs34zOSakmZPsGF2mMl38+Jo59dBndINH7Hwa0wD3qELfcKRqx096fjfqrLOXzL8
 ezKiXblI6AgMDC2DGpleIZcyyyqjcvweuyyMVCaYPihvPuXTYBotM9nLyopk7TI6S0EW57sbK
 fpBURmZuC3/RSp2cHo9TUNgFbHkCBghhvnCgtJZffwo9FJdN5NC/Ky5+NwD7gzeSLwdF3kE4w
 WoOdgTqG2pC64Oxn4bcWwnsMXTunKtEHiUk2LeCuUeiLMuSmJPC+/P8IoFmgErJgZIlQ83i1q
 AlJwP+1pJqLygWCDK+vunx+PhN6V/GYj7YVk96GXrITdL3HMWgdTZpBtcocFt+adlt0Vwkcid
 TmB3U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

ACK on the three patches, and I think your outline is valid (post
v2.23.0, possibly an Outreachy project?).

Thanks,
Dscho

P.S.: Sorry for top-posting, but I felt that I did not even respond to
anything you said, concretely, so...

On Tue, 6 Aug 2019, Jeff King wrote:

> On Tue, Aug 06, 2019 at 08:27:58AM -0400, Jeff King wrote:
>
> > diff --git a/config.c b/config.c
> > index 3900e4947b..cc637363bb 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -275,7 +275,7 @@ static int include_by_branch(const char *cond, siz=
e_t cond_len)
> >  	int flags;
> >  	int ret;
> >  	struct strbuf pattern =3D STRBUF_INIT;
> > -	const char *refname =3D !the_repository || !the_repository->gitdir ?
> > +	const char *refname =3D !the_repository->gitdir ?
> >  		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);
>
> I stopped here, even though I argued earlier that this probably ought to
> be have_git_dir() to match the rest of the config code. What I found
> when I started poking at it is that there are a few odd cases still in
> the startup code, and that IMHO the final form we want to end up with
> actually matches what's written here (but I'm not quite ready to sink
> the time into taking us there just yet). Read on for the gory details.
>
> The most immediate issue I saw was that the_repository->gitdir doesn't
> actually tell you whether or not we have a repository! I.e., that entry
> may be non-NULL even though startup_info->have_repository is 0.
>
> So these two tests fail:
>
> diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
> index d20b4d150d..7ec91c4c1c 100755
> --- a/t/t1305-config-include.sh
> +++ b/t/t1305-config-include.sh
> @@ -348,6 +348,18 @@ test_expect_success 'conditional include, onbranch,=
 implicit /** for /' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'onbranch include not fooled by fake GIT_DIR' '
> +	mkdir not-a-git-dir &&
> +	echo "ref: refs/heads/master" >not-a-git-dir/HEAD &&
> +	git config --file=3Dinner the.value inner &&
> +	git config --file=3Douter the.value outer &&
> +	git config --file=3Douter includeIf.onbranch:master.path inner &&
> +	GIT_DIR=3Dnot-a-git-dir \
> +		git config --file=3Douter --includes the.value >actual &&
> +	echo outer >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'include cycles are detected' '
>  	git init --bare cycle &&
>  	git -C cycle config include.path cycle &&
> diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
> index 3a0de0ddaa..91af2c2f89 100755
> --- a/t/t1309-early-config.sh
> +++ b/t/t1309-early-config.sh
> @@ -99,4 +99,12 @@ test_expect_success 'onbranch config outside of git r=
epo' '
>  	nongit git help
>  '
>
> +test_expect_success 'early config is not fooled by bogus GIT_DIR' '
> +	mkdir not-a-git-dir &&
> +	git config --file=3Dnot-a-git-dir/config \
> +		alias.should-not-run \
> +		"!echo should-not-run" &&
> +	test_must_fail env GIT_DIR=3D"not-a-git-dir" git should-not-run
> +'
> +
>  test_done
>
> As you can see from that case, it's a curiosity that we still set the
> internal gitdir variable from $GIT_DIR, even if we found that it's not a
> valid repo.
>
> The onbranch case is fooled by our direct check of gitdir, but likewise
> have_git_dir() allows either have_repository or a non-NULL gitdir (as I
> mentioned earlier, I think this is vestigial at this point).
>
> So doing this fixes the onbranch case:
>
> diff --git a/config.c b/config.c
> index cc637363bb..134637f3ad 100644
> --- a/config.c
> +++ b/config.c
> @@ -275,7 +275,7 @@ static int include_by_branch(const char *cond, size_=
t cond_len)
>  	int flags;
>  	int ret;
>  	struct strbuf pattern =3D STRBUF_INIT;
> -	const char *refname =3D !the_repository->gitdir ?
> +	const char *refname =3D !have_git_dir() ?
>  		NULL : resolve_ref_unsafe("HEAD", 0, NULL, &flags);
>  	const char *shortname;
>
> diff --git a/environment.c b/environment.c
> index 89af47cb85..08bdf79d6b 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -203,8 +203,7 @@ int is_bare_repository(void)
>
>  int have_git_dir(void)
>  {
> -	return startup_info->have_repository
> -		|| the_repository->gitdir;
> +	return startup_info->have_repository;
>  }
>
>  const char *get_git_dir(void)
>
>
> but curiously it _doesn't_ fix the alias one, because after seeing that
> we have no configured git dir, we then fall back to discover_git_dir(),
> which happily reports back the same bogus $GIT_DIR.
>
> So I think there'd be some more cleanup required there. But the general
> direction is that in the near future we probably ought to be checking
> startup_info->have_repository and not the_repository->gitdir.
>
> But I think in the long-term, we probably ought to be getting rid of
> startup_info->have_repository itself. It's really just hiding a subtle
> dependency on whether the_repository is valid, and we're better off
> actually seeing all the spots that depend on the_repository (and
> eventually converting them to take a "struct repository" as
> appropriate).
>
> Where we want to end up is (I think):
>
>   - stop setting the_repository->gitdir when we know that there's no
>     repo (and possibly clear $GIT_DIR as well to avoid confusion). That
>     should make it a robust way to check whether a "struct repository"
>     is valid.
>
>     This is the step I've stalled on, because I'm a bit worried that
>     there's some subtle case that depends on it working this way.
>
>   - drop startup_info->have_repository entirely. At that point it would
>     be redundant with checking the_repository->gitdir.
>
>     If you do this without the first step, t4201 will notice and fail
>     (because it expects GIT_DIR=3Dnot-a-repo to notice that there is no
>     repo).
>
>   - optionally, drop have_git_dir() in favor of just checking
>     the_repository->gitdir. This loses a layer of abstraction, but I
>     think it makes it much more clear where we'd depending on
>     the_repository.
>
> And so in the end, the current state of include_by_branch() is what we
> want, and all the other call sites should change to match it. Whether it
> should be changed in the interim (until we fix the discrepancy between
> gitdir/have_repository), I don't feel strongly about. There are
> user-visible cases that I believe we get wrong today, but as you can see
> from the tests above, they're pretty ridiculous and unlikely in
> practice.
>
> -Peff
>
