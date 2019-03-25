Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67A6D20248
	for <e@80x24.org>; Mon, 25 Mar 2019 14:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbfCYO4I (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 10:56:08 -0400
Received: from mout.gmx.net ([212.227.17.20]:57371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726166AbfCYO4I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 10:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1553525759;
        bh=mOEoJ7uEZ4Xx0+KlPtmMilKX1qcjDcF5MwDtGD3JgYo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aCv+p3awY5qIPa6oFBvx6yB8V8EyNJniuDCkXSsrKIjfpTNPjot5dCpbIzjSo9Kou
         QEuXFEOAowV9a9yLkd9KSwxLMTGQFA3gL/Xmyc42sDcH1pANiIzFYyZLNUukB7QwjP
         7KkcLlL5dBFYZzycSBMNd6MjyvRiQNRV9TRMazQ4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.14]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MAUpK-1hFXTp2CGg-00BaM0; Mon, 25
 Mar 2019 15:55:59 +0100
Date:   Mon, 25 Mar 2019 15:55:43 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "C.J. Jameson" <cjcjameson@gmail.com>
cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] cherry-pick: set default `--mainline` parent to 1
In-Reply-To: <CALm+SV+mD0oKfQqZBDUixyB6ckHLchj83=0mh7wxuhC5G6kfgQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1903251544260.41@tvgsbejvaqbjf.bet>
References: <CALm+SVJR5BCHi_r7B279gKDukD4mYDQuv=K5guje73YDVmOxug@mail.gmail.com> <xmqq1s32w3vu.fsf@gitster-ct.c.googlers.com> <871s31vjo7.fsf@javad.com> <CABPp-BEe56GFM_2g7EyXmSrULFwRAvSPBomQ66jEQmCs=HhWpg@mail.gmail.com> <xmqqd0mlt1h1.fsf@gitster-ct.c.googlers.com>
 <xmqq4l7wuddk.fsf@gitster-ct.c.googlers.com> <87pnqklr8a.fsf@javad.com> <xmqqlg18srrp.fsf@gitster-ct.c.googlers.com> <878sx8lpqw.fsf@javad.com> <xmqqbm24sk68.fsf@gitster-ct.c.googlers.com> <87k1gsh1zs.fsf@javad.com> <xmqqy357r6im.fsf@gitster-ct.c.googlers.com>
 <8736nfc4t9.fsf@javad.com> <CALm+SV+mD0oKfQqZBDUixyB6ckHLchj83=0mh7wxuhC5G6kfgQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YY/O0TtHPKYXqOOs3d0ABrSbVBJ6ZYVzAZld6JWPyDzbdAJN0P9
 Pc8sxUhAMqnkTuZ1htEMGDRPhpIj9hnUWAePJ71iAwHJ2JjWmAc2YW4bFGK59517E5gil1f
 k+pGHmJY1aQuX8a6yEcPIvpSQeUBA0Y1RS+9TcUJSwg64OKkGl9k//QfTOEm2ocmKCiXAqo
 QSFwoD5OzDa/O7iPn4jHg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wDLQtJti+vw=:ksaNOvKClyaL/rxj9F3jiv
 H3RoBOj75ETA1xIRp/YzBBg0UFKJlBw4NefLXVvD4c3CNHbQWuEEuNoQmwpFHLagUf3/ZCion
 yWdYSi6tYZMfv8VwGIFeXRX+ctOlGkgWKajOqbHB9Rj0WenQF7zA0aoVb4APeWNKh6g8RKB3t
 hjmIQ+fFGsaWEEifp0dSZaDTmaZbuJAM/8DUj8Nfzc9YA95dEQffPm681yyP+lP00Hr5CPEPo
 uZlEOaV2PTE65/0SUWKinpDxUEoGoRdDRrgxHf25vnnzqKk+H478RIXUErGSj/ebmb6RpCDUb
 +8MuWQpiyyj4Duqb/65BiE0PTTMvUUNiHhmex+bClq1QekGzzlFUltsqQqAEhjVr733GlO4sl
 URoADJDssbSOnCt4U6Lwo9mAIzKqPha4x0Z0MnVi6UE4dBJwERTl52NKLQs+X+p7Z51GYg4uL
 mkLm8q1/aLt/q/bD9Hp6YUPXLWl5pRZSLWU0uFpX5XIlt8cBZwkssvFdGJED/4I0KQ9zGwCJZ
 KjCqJST+oGw0zqgiyqeH7lWq/+DxYmvXbzgdqkCQ8DratACD29p9tmZlLe0ouXbtcqa/Ie5HI
 Pi5IzTKh7OyllQRmFtQUk70mgewOeM42tHHMdYomAozGmXdjatFdVfcXvfjAqacy4eUTmUJBu
 KuVnAuMk9kBHWbOUWJ7SBR8N6h6Lid+/zVrKyZsT/U+oeIDxJvK1o0qGszvLM6Y6KYzTLYSMd
 1vixLw5fZxLdso+QuftHvcFe0wi9T7MU9w5x9LcW5/9y0mouMTWYUCY1JKA8BwY7NJnp0Wimb
 UVVpGKWnxZAqTVeO70PRl75Iz0AHjixq9nrcY0BKRFt1hsByV+A758BnBAz75gXqM3J945xxU
 2B0/ysIwU3hy8wo0lQpZqM0SrzQXNdR7THxBbButmMjLU8MTUI9bYexozQ3/08c/8NexSQad8
 pERMs4aEYQw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi C.J.

On Fri, 22 Mar 2019, C.J. Jameson wrote:

> Confirming Sergey's summary: at this point, I think my only residual
> opinion is that requiring `-m 1` or `--mainline 1` is a little cryptic
> for someone who's just cherry-picking a single commit, which happens
> to be a merge commit.

Two points:

- You do not happen to cherry-pick a merge commit. If you do that, and do
  not realize that it is a merge commit, then you have no idea what you
  actually wanted to pick (the changes relative to the first parent? or th=
e
  to the second parent?). The fact that Git does not let you do that gives
  you the opportunity to pause, think, and then be sure what you actually
  want.

  So Git does the right thing there.

- If it is a little cryptic that `-m 1` (or `-m 2` or `-m 3` or...) is
  needed, then this needs to be made less cryptic. A fantastic idea would
  be to teach Git to mention this hint in the exact circumstance when it
  matters most: when the user just tried to cherry-pick a merge commit.

  I actually do not know whether Git does the right thing there. If it
  does not, that would be a good direction to focus your efforts on.

> `--no-forbid-merges` would be the thorough way of accommodating it, but
> it's even more verbose and you'd still need to discover it...

But it would definitely make sure that we do not pretend that merge
commits are anything like non-merge commits.

As I pointed out elsewhere in this thread: non-merge commits' purpose in
life is to introduce something new, in a relatively small, neat package.
If it does not fit into one small, neat package, you need to split it
among multiple non-merge commits.

A *merge commit*'s purpose in life is not to introduce something new, but
to reconcile diverging changes. I.e. it is more of a moderator, a mediator
between battling non-merge commits. Often, the only real changes a merge
commit introduces are changes that are necessary to make the two diverging
branches work well together.

It can be hard in practice to appreciate the difference, but it is very
real.

For example, when you `git cherry-pick -m 1 <merge>`, you will typically
end up with a *ton* more merge conflicts than when you cherry-pick a
non-merge commit.

And when you cherry-pick a merge commit, it is much more like performing a
squash merge than performing a cherry-pick, and resolving the merge
conflicts looks a lot more like bringing peace to a shouting match, much
like when you resolve merge conflicts during a *merge* (as opposed to
resolving merge conflicts during a cherry-pick, which feels a lot more
like helping a patch move into a new city it does not yet quite know).

(This is at least what my experience is, from working with 70+ branches
in Windows that I maintain on top of core Git.)

Ciao,
Dscho

> I'd be fine abandon this -- thanks again!
>
> C.J.
>
> On Fri, Mar 22, 2019 at 8:22 AM Sergey Organov <sorganov@gmail.com> wrot=
e:
> >
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> > > Sergey Organov <sorganov@gmail.com> writes:
> > >
> > >>> With it reverted, "[alias] cp =3D cherry-pick -m1" can be used to =
train
> > >>> the user to blindly pick a range that has a merge without thinking=
,
> > >>> which is what I meant by "ship has already sailed".
> > >>
> > >> Did you mean "With it *not* reverted" here?
> > >
> > > Thanks for a correction.  Yes, if we do not revert it, then that
> > > would allow people to follow a bad workflow we do not want to
> > > recommend (and I think that is what Elijah does not want to do), and
> > > that is why I said the ship has already sailed.
> >
> > I still don't think it makes sense to revert the patch (that fixed a
> > real-life issue) on the sole ground that, as a side-effect, it has
> > provided an opportunity that could potentially be abused, specifically
> > by defining a random alias, and then shooting oneself in the foot with
> > it. And even then no irreversible damage actually happens.
> >
> > Moreover, if somebody actually wants to "follow a bad workflow", he
> > still needs to ask for it explicitly, either by providing '-m 1', or b=
y
> > defining and using an alias, so let him do it please, maybe he even do=
es
> > know what he is doing, after all.
> >
> > >
> > >> Those who don't like such alias are still free not to define or use=
 it.
> > >
> > > That's not the point.  Those who do want to be careful can learn to
> > > use a new option --forbid-stupid-things, but why should they?
> >
> > Sure thing, who said they should? Fortunately, that's exactly the
> > current state, no need to invent and specify any --forbid-stupid-thing=
s
> > option, and even if we pretend the option is already there and is
> > active by default, still no need to revert anything.
> >
> > > They should be forbidden from doing stupid things by default, which =
is
> > > the point of this exchange.
> >
> > I already agreed before to assume this, and it seems that we now all
> > agree this safety should be preserved, as there are those who actually
> > care. However, as merges are already forbidden right now with all the
> > current defaults, I fail to see how it could justify reverting of
> > already applied patch.
> >
> > To me, the actual question here is: what's the option that overrides
> > that default? The current answer is: "-m 1", that admittedly is not ve=
ry
> > nice, but has not been introduced by any of the recent patches, so is
> > not solvable by reverting any of them.
> >
> > To summarize, as it looks to me, it's mostly the current way of allowi=
ng
> > merges, that cryptically reads as "-m 1", that makes the OP unhappy.
> > This was already the case before the "allow '-m 1' for non-merge
> > commits" patch, so reverting it won't solve the problem in any suitabl=
e
> > way.
> >
> > Due to all the above, may we please finally let alone the already
> > applied patch and focus on finding (or denying) actual solution to the
> > original issue of this thread?
> >
> > If so, I'm still on the ground of providing new, say,
> > "--no-forbid-merges" option, if anything. I'm with Duy Nguyen that the
> > way suggested by RFC, making value optional for yet another short
> > option, is to be avoided at all costs.
> >
> > -- Sergey
>
