Return-Path: <SRS0=+7zH=5U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAC5C2BA15
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 20:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCB24206F7
	for <git@archiver.kernel.org>; Sat,  4 Apr 2020 20:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="IScxDrWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgDDUdw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Apr 2020 16:33:52 -0400
Received: from mout.gmx.net ([212.227.17.22]:47247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbgDDUdv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Apr 2020 16:33:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586032425;
        bh=EOk9MryeMYGGT+mnKOyTKsk/9LWgvcUNaok0ZB+ew58=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=IScxDrWlCPcRc+zozoIerUgWEMvzWXj5Br/xiFU2yJyjC8IK8IP25yM20ybJ/SPsZ
         axnfVNg3iwqanY3IHKGMfkAHBUeub+Iudyx2GwkVlSHm0/tKbXHL/G+hxW4H+mWQvG
         z+A5ljriGw9rx146D875Eps9va0r7K6hot/Y+Vo4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([213.196.212.7]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M4axq-1jMTNe3zD4-001mPu; Sat, 04 Apr 2020 22:33:45 +0200
Date:   Sat, 4 Apr 2020 22:33:44 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     phillip.wood@dunelm.org.uk
cc:     Alban Gruin <alban.gruin@gmail.com>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: Comparing rebase --am with --interactive via p3400
In-Reply-To: <a92f1028-d33b-bd7e-a4d5-f4884faedeed@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2004042232140.46@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1901312310280.41@tvgsbejvaqbjf.bet> <a00e1689-ec7c-4039-a2e9-f72d452ae4ff@gmail.com> <nycvar.QRO.7.76.6.2001312216410.46@tvgsbejvaqbjf.bet> <b380123e-dbcd-7e92-67ab-e6cbf0cec061@gmail.com>
 <a92f1028-d33b-bd7e-a4d5-f4884faedeed@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-658749157-1586032425=:46"
X-Provags-ID: V03:K1:o/VQlDsKfTqeBaDAS0yZqEK9fHYQc8d2zcEj8MSftjhRs3UW6dj
 hIK/9SPDejDaEhII7FIRLj1fYEycg/RUX18KTJOXWiW8cybA9Ie0jelaFEG0+foInwosBGK
 h6xa4REIkd6Kb11SeC+qpk1cCpiFzcoklwEobhXPoPDT0eJVOYHNFdajDPbtNkyy4IVRRf8
 8cXM05yLArQWuYztRzWUA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VJ3WryOcoPw=:FufNOm4PtZS1LiyZ21doiF
 Y3JiZtr+qq0XU5vI7OmpL9juQ/NGjGR8oJzC8AE2ZD7UCq5mx2Bse/CUW9MjOeaIBzPuWsjcM
 3Rb/Trz+Yt5jn9XLVow7hT19Mje3qr7hfAqmgic9l7dlY0irHoZM83mbpe3HK47S+0ouaHyNu
 +Z1phn6k4bQfLQve0veDZ8Mkw/11dYVTkwul7r7bnqCF/TnG229TUaTzxnPE9v6/rMU5fksWr
 CwA+kYkF5Hqn5rwMbKRXyXhPxck9ELm02i6Bq8WGu2wHx89DVvuk1HvAex85Ug9tSOZnfcfYf
 c+smRVwRU7weh9x6mgwuyQOb2Xl7KLnTERdmA63k1a2TRkTrGLI9TEVLrG2S6w0QACYQN58yr
 y+9GwNnGizDH+e0uVq/4MozCjjAGiFp4hgliZ0NcBhtKh1ocb63iY9IXpy5d3nIaeOm9W54Cj
 /YDsT3bvm6t+iwJZfuZNsn+3pw9qCfbzKj0agU+x3K+GfiLWcqQtalF0UBAQPzAYEqNTElV3h
 bb/wvLO8vE6it+bDoU5F7RNQMeXF4ls2I4HzuhwNhmzVUfFpKQlncKpmzgV1jK32jEmpu+DWK
 pk6hxH4yxFN3w434lU7PzAUOJxTs2xM6k3WBaeVGLkObV4n5SpjqlbgDdWyz4LVN1qCgKpLZy
 yzqg0bmty5YyCXn+aKOcwLdYlZDXUr4DetGAp1RNiPO+dg2FrPoFdrqtOeLn4SntFeEaK28lY
 Wm7/hzNcluZ4Z1zAmlWrv0AcRoev1SjQQHoP3VFdECzFE94/cpa3LQVJ32IvtAjTHGI9qdMNb
 FInC3bMPjtzGca35Vb9uUE6RWuFCLWLm7T+c38komi+/Wpgk5FN+lX09H6xqxwMiKrDWsdECX
 0jJzmDfzzyazN4B7ahbwhJTxiGoAMrU3bc4IW0+/vBd8dtaIi68hyr+cIYUdfsdjwEHg/3iiI
 upBt2l/OXHM0jjW5jWb2oVXD7FX8V7vzto8U3XYrIxkaPlMbVb8i/B7D+s5zWYmG52EbHydz8
 HRrmwy7y+2foy7WYBKMG4adtlCyr2qSRpaw8NrW7mVLIgWKQqcfZWeXGKIQa7oyVtGtjwyde6
 zW5/cvjmmD82q3VEnBR0YuWPX0sYj2aOuX+Q32Bh++5L1SxVoLBC2GYz+IIgfiutONPO8ue0M
 bu+oE1ofPG3qEs9mX3l/N/BqitxMHlGU+w95pY+PbIK0Mjx92/3fXap9HUDe1brO8gnZQNdbA
 WBmB+EXTo5M3jvbps
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-658749157-1586032425=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Wed, 1 Apr 2020, Phillip Wood wrote:

> On 01/04/2020 12:33, Alban Gruin wrote:
> > Hi Johannes,
> >
> > Sorry for the late answer, I was really busy for the last months.
> >
> > Le 31/01/2020 =C3=A0 22:23, Johannes Schindelin a =C3=A9crit=C2=A0:
> > > Hi Alban,
> > >   -%<-
> > >
> > > Indeed. I offered these insights in #git-devel (slightly edited):
> > >
> > > This `discard_index()` is in an awfully central location. I am rathe=
r
> > > certain that it would cause problems to just remove it.
> > >
> > > Looking at `do_merge()`: it explicitly discards and re-reads the ind=
ex if
> > > we had to spawn a `git merge` process (which we do if a strategy oth=
er
> > > than `recursive` was specified, or if it is an octopus merge). But I=
 am
> > > wary of other code paths that might not be as careful.
> > >
> > > I see that `do_exec()` is similarly careful.
> > >
> >
> > I have to admit that the index is not my area of expertise in git, so
> > sorry if my question is stupid: isn't there a less heavy way to find
> > unstaged or uncommitted changes than discarding and then reloading the
> > index?
> >
> > > One thing I cannot fail to notice: we do not re-read a changed index
> > > after running the `prepare-commit-msg` hook, or for that matter, any=
 other
> > > hook. That could even be an old regression from the conversion of th=
e
> > > interactive rebase to using the sequencer rather than a shell script=
.
> > >
> > > Further, `reset_merge()` seems to spawn `git reset --merge` without
> > > bothering to re-read the possibly modified index. Its callees are
> > > `rollback_single_pick()`, `skip_single_pick()` and `sequencer_rollba=
ck()`,
> > > none of which seem to be careful, either, about checking whether the=
 index
> > > was modified in the meantime.
> > >
> > > Technically, the in-memory index should also be discarded
> > > in `apply_autostash()`, but so far, we do not have any callers of th=
at
> > > function, I don't think, that wants to do anything but release resou=
rces
> > > and exit.
> > >
> > > The `run_git_checkout()` function discards, as intended. I
> > > am not quite sure whether it needs to, though, unless the `.git/inde=
x`
> > > file _was_ modified (it _is_ possible, after all, to run `git rebase=
 -i
> > > HEAD`, and I do have a use case for that where one of my scripts gen=
erates
> > > a todo script, sort of a `git cherry-pick --rebase-merges`, because
> > > `cherry-pick` does not support that mode).
>
> I'm not sure it is worth optimizing the case where .git/index is not cha=
nged
> as we only do this once per rebase. In any case I hope that one day we'l=
l stop
> forking git checkout and use the code from builtin/rebase.c to do it
>
> > > The `continue_single_pick()` function spawns a `git
> > > commit` which could potentially modify the index through a hook, but=
 the
> > > first call site does not care and the second one guards against that
> > > (erroring out...).
> > >
> > > My biggest concern is with the `run_git_commit()` function: it does =
not
> > > re-read a potentially-modified index (think of hooks).
>
> I agree that we should be re-reading the index after forking `git commit=
` and
> also `git merge`. Most of the time we commit without forking so that sho=
uld
> not impact the performance too much
>
> > Thank you for your analysis.
> >
> > >
> > > We will need to be very careful with this `discard_index()`, I think=
, and
> > > in my opinion there is a great opportunity here for cleaning up a li=
ttle:
> > > rather than discarding and re-reading the in-memory index without se=
eing
> > > whether the on-disk index has changed at all appears a bit wasteful =
to me.
> > >
> > > This could be refactored into a function that only discards and re-r=
eads
> > > the index if the mtime of `.git/index` changed. That function could =
then
> > > also be taught to detect when the in-memory index has unwritten chan=
ges:
> > > that would constitute a bug.
> > >
> >
> > Hmm, checking if the mtime of the index to see if it changed isn't rac=
y?
> >   Sub-second changes should happen, and to quote a comment in
> > is_racy_stat(), "nanosecond timestamped files can also be racy" -- eve=
n
> > if it should not really happen in the case of rebase=E2=80=A6
>
> I don't think relying on the index stat data is a good idea, git default=
s to
> one second mtime resolution unless it is built with -DUSE_NSEC and we do=
 way
> more than one commit a second. We tried to rely on stat data to determin=
e when
> to re-read the todo list after an exec and it is broken (both in the des=
ign
> because it assumes ns mtime resolution and the implementation because we=
 don't
> update the cached mtime after we rewrite the todo list). There are not t=
hat
> many places where we need to re-read the index so I think we should just=
 have
> explicit re-reads where we need them. Hopefully over time we'll stop for=
king
> other processes and the problem will go away.

Well. Even the 1-second granularity should buy us some performance if we
assume that `same mtime` =3D=3D `racy`. That should still catch the majori=
ty
of the cases where the index was simply not changed, at least in the
`do_exec()` case.

Ciao,
Dscho

>
> Best Wishes
>
> Phillip
>
> > > Ciao,
> > > Dscho
> > >
> >
> > Alban
> >
>

--8323328-658749157-1586032425=:46--
