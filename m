Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036361F453
	for <e@80x24.org>; Mon, 21 Jan 2019 18:11:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfAUSLn (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 13:11:43 -0500
Received: from mout.gmx.net ([212.227.15.15]:43159 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726040AbfAUSLm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 13:11:42 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MfmWy-1gXR4d3kmK-00N82n; Mon, 21
 Jan 2019 19:11:36 +0100
Date:   Mon, 21 Jan 2019 19:11:20 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>
Subject: Re: [PATCH v4 4/8] am, rebase--merge: do not overlook --skip'ed
 commits with post-rewrite
In-Reply-To: <CABPp-BGOPQms5CRvQ_+iMs=8-tgvw=cyJaT1OCKNFHEG+GyAvA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1901211910560.41@tvgsbejvaqbjf.bet>
References: <20181122044841.20993-1-newren@gmail.com> <20181211161139.31686-1-newren@gmail.com> <20181211161139.31686-5-newren@gmail.com> <nycvar.QRO.7.76.6.1901211706250.41@tvgsbejvaqbjf.bet>
 <CABPp-BGOPQms5CRvQ_+iMs=8-tgvw=cyJaT1OCKNFHEG+GyAvA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:j9YKSZ2Ky8tirMV4bG3Jd8TxW5fTdRDYSOzYJucvl5sFeh6/YJB
 8nvvC5o5r6cErdlwtOUU39BXze1lMAySYY2+J4pOcoE7AKALe68AmL5qwBxT92g0s+2mBf1
 3NNXANeTWjf35qtrN8d2VBBymY2wsaJCX/LS0oIP0ZpcFHzf5Py2ckfT8h+h+Y7/77sPLGq
 2stNU7r64LJWtnOGJR6hQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ahsb4MG8/BU=:PMvegr1UiOUk1Yz8nCsLv/
 5ymdET5OFS+0tpKM7Bou8X5Bf9WZZTiB0i7IJt0qdDf5yxbKwQ1kuvIHTDTmtWdLBvTdRRBKZ
 jUqDpngRlSry/4CZAGUxKO21SXMy4QXf2ScHmt1JpNBMDGN+liPj6mJtlnGZpHqi797Hf9xr0
 etPZgBqzRDAZq5Xli+rKNWwna+nEuhEWqiA+2lkppp7RQG3rC+BqilmMtsysUXNe1UAoi55iS
 NvFmWr0dVCHKi2sCwtkG9cDWUkUjRtfmGVUs8/SFBw7nGVhQ6LawsLMj6TvUXHHx0m8SuoNCm
 3k2y0UwxnpBxmzwQS+gU650Rj6HOU1jfUGuYV94fexUdFtKnkDLGUOkBcbIZKK4aSjM5o0mVR
 l9zyaKSNwZY18bO/cqrwdeix7HR8Cs6SY6t68f72Wa9tT7nvBb36arKqp4dQabSaP0KzJWgAA
 3o4NQ2lFJKdmq1vGVZDO2PGfN/5YvFuyeDV/koNjcwASaWj6AGSukrYtVkKHK5I2hLCi3x/7G
 j1hhusHbFjJE0WAETDCNnIaZp3YzPFoV/Qko8Lt+d7vvlAD2NMlGJTlcTAg+FnelPV4PXOQcp
 Xg8M2N0+DtRtKjsLZWtJGqmAJ4DVqyESE/0am2KPtbjaT6d7dp3+BxZGdGTpcm1mpY5wuDjag
 Zb99C0OZCOE5nOJLFnFtXKMOoBk3FlXXQ8Ganun1uR0IwtC+vcAZoLg/YdmPLu3naWQRZnI62
 hIcMrkH1A7p1ynoLGfF/CzgRlzqHxqnTzHZNGlCVFdSzVi4PdKKW0HtgDq7i02H4UDkNcF3kP
 9YeHRcZQcN2ArbwiY/ShzH0gE1veVV3adIqDx2K0BPe8XrkbCeWLqHiM9oODVrZxFK+RKvbob
 ibMRb5md3shtIrPrOHvg7Hnnm8hRa8GbbR8LxggmfcxxQMSPawf6s6rr8SkZ1PoGV/oEBURyR
 BJ3WGuFdfXA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Mon, 21 Jan 2019, Elijah Newren wrote:

> On Mon, Jan 21, 2019 at 8:07 AM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 11 Dec 2018, Elijah Newren wrote:
> >
> > > The post-rewrite hook is supposed to be invoked for each rewritten
> > > commit.  The fact that a commit was selected and processed by the rebase
> > > operation (even though when we hit an error a user said it had no more
> > > useful changes), suggests we should write an entry for it.  In
> > > particular, let's treat it as an empty commit trivially squashed into
> > > its parent.
> > >
> > > This brings the rebase--am and rebase--merge backends in sync with the
> > > behavior of the interactive rebase backend.
> > >
> > > Signed-off-by: Elijah Newren <newren@gmail.com>
> >
> > This makes sense. I think, though, that we need to be more careful...
> >
> > > ---
> > >  builtin/am.c                 | 9 +++++++++
> > >  git-rebase--merge.sh         | 2 ++
> > >  t/t5407-post-rewrite-hook.sh | 3 +++
> > >  3 files changed, 14 insertions(+)
> > >
> > > diff --git a/builtin/am.c b/builtin/am.c
> > > index 8f27f3375b..af9d034838 100644
> > > --- a/builtin/am.c
> > > +++ b/builtin/am.c
> > > @@ -2000,6 +2000,15 @@ static void am_skip(struct am_state *state)
> > >       if (clean_index(&head, &head))
> > >               die(_("failed to clean index"));
> > >
> > > +     if (state->rebasing) {
> > > +             FILE *fp = xfopen(am_path(state, "rewritten"), "a");
> > > +
> > > +             assert(!is_null_oid(&state->orig_commit));
> > > +             fprintf(fp, "%s ", oid_to_hex(&state->orig_commit));
> >
> > ... here. What if `fp == NULL`? (Users do all kinds of interesting
> > things...)
> 
> This if-block is actually copy-pasted from the end of the do_commit()
> function, since the same logic was needed in both places.  The fact
> that a `fp == NULL` case never triggered for do_commit() suggests that
> the check has never been needed in the wild (or perhaps it just
> indicates a latent bug that no one has triggered yet).  However, it
> does suggest a code cleanup regardless.  I thought of it as such a
> small block that I didn't think to put it in a separate function, but
> perhaps I should so that someone spotting the possibility of a NULL fp
> could fix it for both callers in a single place.
> 
> Should I insert a preliminary change pulling this block out of
> do_commit into a separate function, and then modify this patch to just
> call this function?  Or perhaps given the length of time it has
> already been cooking (and Junio's rerere resolution of our two series
> that I don't want to mess up), just do it as a simple post-series
> fixup?

Speaking for myself: I am fine with either way.

Ciao,
Dscho
