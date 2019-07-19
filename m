Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 706001F461
	for <e@80x24.org>; Fri, 19 Jul 2019 13:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbfGSNYI (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 09:24:08 -0400
Received: from mout.gmx.net ([212.227.17.22]:48949 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727717AbfGSNYI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 09:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563542626;
        bh=GRRwb3vYfcPvlCawi6l/cEb/8JIbpCUQ7VKJDsbUMg0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kB07LdaIiLh2Kvt9o4rL6jc68uAXwusNRpg/ENUZ9MZt5L7lnTCUhnJUhKe8McdxR
         cxvXpQxByUgzKET+tzasuS3F6BVTWycnTG1DZ+1rL0eilF9UJ1k1COlm7KDpmGA2UU
         OqFSso2LAoEy5sirKQEGLDI/DpjuvcpuMrmmNuyg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2V0B-1iZs8z2w8d-013uM7; Fri, 19
 Jul 2019 15:23:46 +0200
Date:   Fri, 19 Jul 2019 15:23:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Palmer Dabbelt <palmer@sifive.com>, git@vger.kernel.org,
        peff@peff.net, e@80x24.org, chriscool@tuxfamily.org,
        jonathantanmy@google.com, tboegi@web.de, bwilliams.eng@gmail.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH] fetch: add "--parallel", which fetches all remotes in
 parallel
In-Reply-To: <xmqq5znzz17j.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1907191507420.47@tvgsbejvaqbjf.bet>
References: <20190717015903.4384-1-palmer@sifive.com> <xmqq5znzz17j.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:9fMlQxGYjD9mGjCEieklfq8Va3gczAJTW6JZRtT5vcvmm1l2tDt
 mnGjVqfFVeau8+3q9BbCfp9is97wk7bJQt0ecjXo3cer2qSI6UijormFxQqDbHKoxzCGzzL
 MMQBR3u1kihG9voE7I7qT3SftBRuELCijmB9Slc3WZExms2sBE63OG7MqHJ6cVSUoV++xQi
 NOHrPRKWM5T0uNRjM018A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VEYrxmYzirU=:cEu2ygo4L/sKUFDe4j1Uc2
 bJ1c24BQsTpQVJAxgy1YlT84nGp9hJmz35Ggl8NP3pkU2PQoyb75jtGmZZgfCAVDvZzow2o2m
 NhCrf6KiXGPqAXPrim4cDRl5YiRfe5yG7/likFHN0Bvra060qmOSGdtK3NxIiuvs0Ni96qd8e
 GRvMo98xfcDeu8Gweo1TA93rF9V6rgYLU6AiMsPmZrp+8TxCr6IxX2w16FZZRmmgTng2qy1Fm
 z2C170Sh1svJXOTywUWNLFhdq6suQaw0ieMx9y+XD+7jaZKkl/yXPWX804lrwsYAmv9kT7Az4
 onUDO3Drwj6CvpUeyL0IhCSfhdWMhDCmr3N9Vm0f9hKFsOyZlddsGNCgNX561qtT4h1zLVyea
 M7pzgh2uJOw21IzbienHe7uZ8gA0OlPpAoQfLrvjFzakjXO4j4HALy8B/tsg2dhQQv7uh1/Er
 rSl24i9As6v4i8yvBKplKa6JWathEKKPrYekKpoBy4Ia3+TjC3+tDGHIWiT/jkxixD1lI5TdK
 wfcKXrWxBUkiF3pTgM/+xe74E/V8y0/UaaTMjAzALOXOYrwQy9bk7bi2P3DgmQmd4H7H8Bfle
 TtV35Y990obbYk05pqPTZ40524BpejytJjo/Wo7qAMYec7S+fJdeR6w7GdbipIWp/3EMiVNDu
 h42Tdzb0OD1uVRhmq9PVHGu4MBIeOg9L7HqgH+KU/+sk/t+EJUhP1Yk3fEW6CEALAU60eqw6M
 u0KfwIwTNuchpshVhEjoSBDO9hVo4jsVH3iRsK0Wq0EVJsOt3WbRkWMO+qRso2zGNLhxhHF50
 sxJUa7aJ9z3G48gZxFbE+iFrOqfhUKWuBKfY1+kTwEPPODWpcT6/Y3s3Tb5a8Nn2MNSdGu/EW
 2QtYOHvFrt5Jn251H5GOm2FmwT3oYmrAzjGGyt9wQiB9uHXADY/wr2sD63yUrM8VU8zg76VoB
 UkqrBcc7fHfPY54azEf9rlbRHhy1RaKVoWixRsfq8V7uTKXS8eTcpdxhg668mru3FsQDkbD/M
 QT7DgrPgsOs5g4TcxitAY1K8lkCxZ9IfMDvM86IKLmpal+uYjdPJvbMk/uQ0jybtfa0ChLUDo
 O8WIxUMaP9i71MJDXlf9sOe3zazjCqiseg2
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 18 Jul 2019, Junio C Hamano wrote:

> Palmer Dabbelt <palmer@sifive.com> writes:
>
> > * As I was writing the documentation I found "fetch --jobs".  It seems
> >   like I should use that instead of adding a new argrument, but I wasn=
't
> >   sure.
>
> Why not?  What makes you feel it is a bad idea to follow that
> pattern?
>
> Ah, --jobs that is taken already is right now too tied to fetches
> that happen in submodules, which arguably was a design mistake.
>
>     -j::
>     --jobs=3D<n>::
>             Number of parallel children to be used for fetching
>             submodules.  Each will fetch from different submodules,
>             such that fetching many submodules will be faster. By
>             default submodules will be fetched one at a time.
>
> The simplest endgame would be to replace "submodule" with
> "repository" in the above description, perhaps like
>
> 	Number of parallel jobs to be used for fetching from
> 	multiple repositories (both fetching with "--multiple" from
> 	multiple repositories, and also fetching updated contents
> 	for submodules).  By default, fetching from multiple
> 	repositories and submodules is done one at a time.
>
> and nobody would have complained if the system were like so from the
> beginning.  Existing users, however, may want extra flexibility, and
> would complain loudly if we did the above, in which case, we may
> have to
>
>  - introduce --fetch-jobs=3D<n> for what you are adding;
>
>  - introduce --submodule-fetch-jobs=3D<n> as a synonym for existing
>    --jobs=3D<n> and deprecate the current use of --jobs=3D<n>;
>
>  - eventually repurpose --jobs=3D<n> as a short-hand to give both
>    --fetch-jobs and --submoduje-fetch-jobs at the same time.

Given that the relevant code looks like this:

        if (remote) {
                if (filter_options.choice || repository_format_partial_clo=
ne)
                        fetch_one_setup_partial(remote);
                result =3D fetch_one(remote, argc, argv, prune_tags_ok);
        } else {
                if (filter_options.choice)
                        die(_("--filter can only be used with the remote "
                              "configured in extensions.partialclone"));
                /* TODO should this also die if we have a previous partial=
-clone? */
                result =3D fetch_multiple(&list);
        }

        if (!result && (recurse_submodules !=3D RECURSE_SUBMODULES_OFF)) {
                struct argv_array options =3D ARGV_ARRAY_INIT;

                add_options_to_argv(&options);
                result =3D fetch_populated_submodules(the_repository,
                                                    &options,
                                                    submodule_prefix,
                                                    recurse_submodules,
                                                    recurse_submodules_def=
ault,
                                                    verbosity < 0,
                                                    max_children);
                argv_array_clear(&options);
        }

i.e. the `fetch_multiple()` call is _strictly_ before the call to
`fetch_populated_submodules()`, I would contend that this level of
separation does not serve anybody but a fan of the complicators' gloves.

You would also find yourself in quite a pickle if you wanted to explain
to a user why those `--fetch-jobs` and `--submodule-fetch-jobs` are
separate options _and_ why they repeat the command name in the option
name. And if it is hard to explain, there is usually a better design
choice in the first place.

In other words, I would be much more in favor of `--jobs` _also_
extending to the `fetch_multiple()` call, not just the
`fetch_populated_submodules()` call.

> > @@ -1456,12 +1459,15 @@ static void add_options_to_argv(struct argv_ar=
ray *argv)
> >
> >  }
> >
> > -static int fetch_multiple(struct string_list *list)
> > +static int fetch_multiple(struct string_list *list, int i)
> >  {
> > -	int i, result =3D 0;
>
> 'i' is perfectly a good name for a local variable that is used for
> loop control purposes, but makes a horrible name for a parameter.
>
> Existing 'list' is not any better either---we know it is a list by
> its type already, the name should say what the list is about, what
> it represents.  But having a horribly named parameter already is not
> a good reason to make the code even worse.
>
> And as you said, recursion makes the code structure harder to follow
> here.  Keeping an array of --jobs=3D<n> cmd structures, looping to
> fill them by starting, doing wait() to reap any of the started ones
> that first exits to refill the slot just opened, etc. would be easier
> to see if done in a loop, I think.

I have to admit that I'd _much_ rather see the strategy of
`fetch_populated_submodules()` emulated, where it uses the
`run_processes_parallel_tr2()` function to perform the actual fetches.

That buys us a lot of advantages:

- the recursion problems mentioned in the original mail will _not_ be
  any issue,
- the progress won't be garbled,
- we can automatically restrict the maximal number of parallel fetches.

It should be super easy to get started with this, simply by moving the
`list` and the `i` variables into a `struct` that is then passed to
`run_processes_parallel_tr2()`, then implementing the three callbacks.

Those callbacks can take inspiration from `submodule.c`'s
`get_next_submodule()`, `fetch_start_failure()`, and `fetch_finish()`
functions, but rest assured that the `fetch_multiple()` ones will look
_a lot_ simpler.

Ciao,
Dscho

P.S.: It would probably also make sense to extend this contribution by a
second patch that teaches `git remote update` a `--jobs` option.
