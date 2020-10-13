Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAB4C433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCF2B24802
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 14:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="E0JP9c5c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgJMOTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:19:54 -0400
Received: from mout.gmx.net ([212.227.15.18]:43309 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726822AbgJMOTx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 10:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602598781;
        bh=mp2Q7Ctoa9v453P2R5PNmbb18OmMse6bqsBpLM+J4xU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=E0JP9c5cPH3c6Y0FBrU5zSadFiuz5nahNZZ6Bu2wbkfC31/1wetSfSXKtwoF11I4+
         tiQnhfVIEkiuqO+YHKJwEvQ+9DfGYqHu4D4gb5REVORaHUkQSPWAHCShsklTMoWEkT
         GyzKJ03I+r9VPv6hU7NWB16a4VkDYxJR/TcDe8AY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.212.188]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmlT2-1k1DKN1GtS-00jpu7; Tue, 13
 Oct 2020 16:19:41 +0200
Date:   Tue, 13 Oct 2020 14:12:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Patrick Steinhardt <ps@pks.im>
cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 05/13] reftable: utility functions
In-Reply-To: <20201012170527.GA21606@xps>
Message-ID: <nycvar.QRO.7.76.6.2010131405380.50@tvgsbejvaqbjf.bet>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com> <pull.847.v2.git.git.1601568663.gitgitgadget@gmail.com> <4190da597e65bce072fa3c37c9410a56def4b489.1601568663.git.gitgitgadget@gmail.com> <20201002041214.GE3252492@google.com>
 <CAFQ2z_NL1UrmonMH3qLKrEkjsPjm9qTbtoeY0OHQZzkVW2t3-w@mail.gmail.com> <20201012152505.GB3740546@google.com> <20201012170527.GA21606@xps>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wwRRY7mdK1K/3ILEMcidddE82aComlxA8p7MJP7ll7w1nlAeONT
 +lhUX1axR77a/y9C3r7opK68LENlbQcB+SNk1TSWkCdZQ0lYwxohWbzT1j9cKCMJU13wR1F
 TyUZn4Zd5X9um8Gko7pfkZGJmPFgTBqkUlVPFxjmyui00rNd3BULc1RVgZLdxe8854V9qAL
 zbc+t4qNYoENRxURDirQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:m/zzJUiE4Fs=:1WQ3zvxy8mp43CaU/SHmtR
 Ll9AOjXnWCpEcqIS9ObFKCGD6QMY564ht0Zwers7QSybYK+0XgsRZBFXva+YHJ2Cod3Ozz16m
 7ZfxzMoReQR7YsyBBD4/BoG0ge+24knpJkr/K/3XL1FZTL6Ahug44fOxDIR/ZW/kOtBBLwggb
 wUSMbVf0PMt6X5g3/dPgG89wB33GUhtS9BV38ErkVXkuXs2tGnGJIbY76Rlx7/T3rPzjMm0It
 DCuIw66F9cdKkTmLMddarVbRbQuEJw/BkX8dzawpxQtdtqgOE8nhRn5dMGsquZT+fQi6Sav5X
 YkEpcU5a6FAqDG7jekQQMIAR0x5QyDnmVmLWvEe/OcvP20AAJ+EQoojRwNTZZFRC7dSF445X/
 avT+XG9nTRKFegpn7AnbOcx5Y6BD71Z1GwY4qLiK48yfpuXmflS2zJdlyxtaABg8MW73qIGiC
 yVhG5GOEwJmwpnbfWcadHIDoc4GnrFKl5Q9TS2LvTei2JltHtf3DMnUn/Ah32ZYg80abgNMQc
 wIrW6Y69Oj7Q2ENXHFcRkBcMR0Rf7hUyOysarm8eJIm9paSy1trSaE7MPuELTBx5uLjByRPhr
 8GDSq5xkIiSEuRjm0AbqufvbWZXqG0TfnQN2vwq/WKRyU8QGnzOLdIfh6ddV86OOLZBTYTcFo
 /V9u2EmMFaBVfWWtbZZghG+ozZDWwKIt+rsgCsUJZGE1jYs2djdXfSmsfMw3IAdp4mN3K0jFJ
 i//8hTgqaCy6wPYoYNjHALhRGKwTgeY3Om6y5dlVa0/RQWlLBHnTwuV+ChQ498p7zfapi2292
 PDjU8VuUxwooK3tBUfsTUlHjufreZrPT18KavNKKMtWJPa1ayzRAachEwQd392ne4ophb8fAS
 MJPel+NP+Y+XyCUrqQ4/KLUoqydTHDkoXDXHiqiiE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Patrick,

On Mon, 12 Oct 2020, Patrick Steinhardt wrote:

> On Mon, Oct 12, 2020 at 08:25:05AM -0700, Jonathan Nieder wrote:
> > (+cc: Patrick Steinhardt from libgit2)
> > Hi,
> >
> > Han-Wen Nienhuys wrote[1]:
> > > On Fri, Oct 2, 2020 at 6:12 AM Jonathan Nieder <jrnieder@gmail.com> =
wrote:
> > >> Han-Wen Nienhuys wrote:
> >
> > >>> +     reftable_free(a);
> > >>> +}
> > >>
> > >> Are there other callers that need custom free?
> > >
> > > The libgit2 folks requested the ability to set memory allocation
> > > routines, hence reftable_free().
> >
> > Thanks.  Patrick or Han-Wen, can you say a little more about this use
> > case?  That would help with making sure we are making an API that
> > meets its needs.
> >
> > For example, is a custom allocator something that would be set
> > globally or something attached to a handle?  If the former, would code
> > that uses xmalloc and free and gets #define-d away when used in
> > libgit2 work?  If the latter, what does the handle look like?
>
> We have global pluggable allocators in libgit2 which can be set up
> before calling `git_libgit2_init()`. The user of libgit2 can fill a
> `git_allocator` structure with a set of funtcion pointers, most
> importantly with implementations of `free` and `malloc`. Those then get
> used across all of libgit2 for all subsequent allocations.

I did not find out how those are used in the `deps/` part of libgit2's
source code. For example, I see a couple of instances where `malloc()` is
used in `ntlmclient` and in `pcre`.

The thing I was looking for would have been something like

	#define malloc(size) git__malloc(size)
	...

This would also have been what I imagined to be the best strategy to
integrate the reftable code once it is properly embedded in libgit.a (and
of course using libgit.a's API as much as it can).

Somewhat related: I was wondering whether it would make sense for git.git
to rename `strbuf` to `git_buf`? Would that make it easier to exchange
code between the two projects? Or would it just be unnecessary churn?

Ciao,
Dscho
