Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36009C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62D564F4D
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 22:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhBDV7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 16:59:53 -0500
Received: from mout.gmx.net ([212.227.15.15]:52035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhBDV7t (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 16:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612475892;
        bh=ImajlTWN9BygbGw7IKC/NeGsAPGrgnWOvF6DLZHiFzo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AJTJw/YtWcWhdoSHXYQKLfc0T48iIzCDpt4Y/XfRktRAmazVxfdpyRKVQjvuurilP
         iYHZvKwLUD+xzcjGNc2MrWhCrmt0jkrBTt7FAP8uzIu7pvHbra48BPxZJ+BW9Lyvhy
         4sKzHTB/d+Ba8K448Gp4kvz8mhUctP2olZayt5cM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1ledDf1E9n-00dXpQ; Thu, 04
 Feb 2021 22:58:12 +0100
Date:   Thu, 4 Feb 2021 22:58:21 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/3] range-diff(docs): explain how to specify commit
 ranges
In-Reply-To: <xmqq35yb7jhn.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102042257130.54@tvgsbejvaqbjf.bet>
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com> <pull.841.v4.git.1612431093.gitgitgadget@gmail.com> <295fdc1cd32cffcef145d9dd0ac76d29580fa6de.1612431093.git.gitgitgadget@gmail.com> <xmqq35yb7jhn.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bb9Gtb1VLyaqjR6HPj7CGMQrmfRjlyK5yhoxJV8k5Bj46l95Xzc
 ppwXZ4ZXCexUAdqshBM9MLbFl95IZ0DTA8y8TxmkhCS8ssi5iL90IrmfvY9X9zKI4w9Ofsl
 MhpfNjleG9JQ6PDmMxCR4JSTnr3ENFH5FoAi9qRK9lG/Zwmsm0AMxJRN8U7i+ZyjdpmlY3Z
 3XkZoGLDdXJTqhq8BrAAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:i32HbA7cyTc=:lWc2yKu2DkHn5Kl0XwUhma
 lKT78rvtgAwMy53//eQACHOtI/FhPiHuc1Go/SWIhI3ZG5ez+jd9HS8q/lrKX6Qh2sjEfaPap
 2syQdU0UOwFmbrXzmX9zqh0DheBzd8FTwT11ynYjsGJWRkl9kt0utLOePb/X8vYkgmsAbeoP7
 lD7Na8reg8/4UIpXKcGoz/IG1AhcNrDF+KctwljmaZXQIZrAKLxrp0VViaEW61950Z6c0na5t
 PUusZVkfRiRYsPfMAPOUaBu9JEqOACCsz+ssggd4JFRWSmf/YX84f98x83YImbGdWgIlSAhJD
 aS2Q0SxiYrew8sLsq/JqaTqlvi/UxkKmP1nfdFVeij1C/kgZEj5NZtOQptQunlOXV6GYxVn97
 9h0H6xBbRrsKJddKNoxKGbBbVR2YRCnunZFx78RJdsrKCHC7qwqMoLuB1LgemSVCv8UnropzP
 ZQ6qhhPyx4lXFJq2JYjsgh/G7q8eUlM6IezG0kc7bsD4ibF5/bBSynejgWB8UeJJGRqeVdvw2
 9FwKspXOsBwus7HXEkhlKoKHXVAo6r31hEKBHU6iNkrAdsQgXCulclKrwhcDmTjRud8Prn36S
 pboXw5athBZxnSLLpjVURh/6txnaJrYtDxp74kEgK6Hm9MROBijk20tB60dgXLEdT2G4glqcH
 +S4fEgu55xGGfLPjb8FMlL5EN32f+Src3TjVvAJiTDFqDUctfYHowSC0lw0ZLXr2335XKoSGG
 TXOcNdLiP+B0jiBHHKc3Mr9MOEflT4NkJDIAh79/C5NShL1NEluibX0gPXpwWyf1kQ+dj8eMu
 bdxhXYA8IH4PgjOjsniqKwDWr1rxVg/QOZckNsuk5BkLjHs/TtiN7wGmWQ3Q71EMFnWhNJCJJ
 RvdqMF/RsLSBGazkQoQeWuwtUg6ivS/aVGC12xC0E=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 4 Feb 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > There are three forms, depending whether the user specifies one, two o=
r
> > three non-option arguments. We've never actually explained how this
> > works in the manual, so let's explain it.
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  Documentation/git-range-diff.txt | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/git-range-diff.txt b/Documentation/git-rang=
e-diff.txt
> > index 9701c1e5fdd5..14bffb272a06 100644
> > --- a/Documentation/git-range-diff.txt
> > +++ b/Documentation/git-range-diff.txt
> > @@ -28,6 +28,18 @@ Finally, the list of matching commits is shown in t=
he order of the
> >  second commit range, with unmatched commits being inserted just after
> >  all of their ancestors have been shown.
> >
> > +There are three ways to specify the commit ranges:
> > +
> > +- `<range1> <range2>`: Either commit range can be of the form
> > +  `<base>..<rev>`, `<rev>^!` or `<rev>^-<n>`. See `SPECIFYING RANGES`
> > +  in linkgit:gitrevisions[7] for more details.
> > +
> > +- `<rev1>...<rev2>`. This resembles the symmetric ranges mentioned in
> > +  the `SPECIFYING RANGES` section of linkgit:gitrevisions[7], and is
> > +  equivalent to `<rev2>..<rev1> <rev1>..<rev2>`.
>
> As I said before, this _is_ a symmetric range that has commits
> reachable from rev1 but not from rev2 on the left hand side, and
> commits reachable from rev2 but not from rev1 on the right hand
> side, not just something else that resembles a symmetric range.

If we were talking about one commit range instead of two, I would agree
with you.

To put an end to this pointless discussion, I struck the sentence from the
documentation. It might even make it easier to read for users. So that's a
win.

Ciao,
Dscho

> > +- `<base> <rev1> <rev2>`: This is equivalent to `<base>..<rev1>
> > +  <base>..<rev2>`.
> >
> >  OPTIONS
> >  -------
>
