Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14310C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9FB223B45
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbgLJPGe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:06:34 -0500
Received: from mout.gmx.net ([212.227.17.21]:40033 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732762AbgLJPGd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 10:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607612695;
        bh=etAAvz5DESZE7dfXQYbfJTV0SKshfbKz4sfwzoB3efQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fOxvAsXjqeJkdAgd9BzwVs8grv60YglyEBKD+XNWA50TQ5BDjnFJQQVUk0eam9u50
         4yUHrdaJOhIPh564lWLbtclMDHxsOSpc3Bd7jkI3+QcQEZ5xUIEbyqJAoiBvNESb5E
         rKYiH0sPCVVdca4hvCko3LznmbB3Dr6XjMj6MXN4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MIdif-1kt6X53otp-00EeP5; Thu, 10
 Dec 2020 16:04:55 +0100
Date:   Thu, 10 Dec 2020 05:46:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
In-Reply-To: <nycvar.QRO.7.76.6.2012100507450.25979@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2012100543020.25979@tvgsbejvaqbjf.bet>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet> <xmqqk0tq1xf3.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012100507450.25979@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wVEg8oUpDMAHRV7GjuKH7fkcguHnLFyqBtQS8xOFoXHaTYLsQkS
 2rGedf8FGm14HHXOmKQs+5yYdVWHsw+W2YvWQ41702m4Y72FBi9WVyGZnB3vTTg+cV0HRD+
 UBwgvELIOwWFg5uR4LUfnPlA4TotP4wNVty49Unc8anx0aiEX8oEUTReNDCfulk+BHFbvoe
 VnhnaFAX9tN1w88qfpFDA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W5mZvhV3a5A=:UYEzOdF7H2EDeh2rTPY7t3
 FVIbN5j42Whl2lLGOBQ9gaiLQOzoGZKO2TD35ruA6OSFsvATEwL1TNGZ4/ALTu5YVQvn7lNpf
 i7BEu9J1ylPLuclS56T06RkPMTtSKRM9dWqiHAXgJjEMERIcthZU6QVcKPXrKbMOX6aYMyB1l
 jjrlJafiZg1QCeX99skSME88c/4xiHYVvuegz9q67kpbmQwLCfqw8jAD/FouANPplmPNe7oAY
 Z5svl8gGUwCJbT6XdFLjYbvyc71wazwb1sIV4f1/+uEj4797HaT3/HO4QAD/keyEeWoZc1iCS
 Gz6t+4qQQ56bDg8vFdUKT3bZIwYmJY94RSouJ9Bpeg8AGH5Ye6qT5fxWJw9SN/FUTXwEkTaGQ
 SrQsymlG0d5/TSQL1mTYb1YwC9oL4Ybmku/0inFAIa+9iEH09FzRfinz/GhadM/PPRMpLXdze
 vcYlMLwmDxMbUQDjlTF/ltCfiIyH4KW2U8o4CJAm98IrG/cTtq+7J7e+EYTVkX9P1mTKC7sXK
 HglGSIgVSujZ8XvNzBnZVjn0Mei395if4voBhZaiPq7g04xsgzyi3nyqtmhJ+NTnEE9eNkAP2
 1Yh9a7UI77oVgGAa0/CU18R42m2R2Ac65GXlz89fKg4bNJMA0d/G/1G9nrF6DGgHbaj/MH3DR
 5TtijiGPwCkshOYIUZq72SAWthjdGoenr2ygZmMOux7QcRomoZQqm9aAdj8yt9Al76tMs/MxF
 eKdrSXePnysitN0q9fpn4HX5k4ivvhDw65zZ196X/+TrpHJbuXHq1JB/197yAwJcaIlcKdb78
 HcowXUop+015Wz3TKmXzXEg981K6GLLodt6khRR583UJ0Shui67bEloAEmYpIrHJ9anwmo3Ul
 Iu4hMUnQAxwjTTVe1eSoiaq04yNAdLFwWHyDvB+mg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 10 Dec 2020, Johannes Schindelin wrote:

> On Wed, 9 Dec 2020, Junio C Hamano wrote:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > On Tue, 8 Dec 2020, Junio C Hamano wrote:
> > >
> > >> * fc/pull-merge-rebase (2020-12-08) 19 commits
> > >>  - future: pull: enable ff-only mode by default
> > >>  - pull: advice of future changes
> > >>  - pull: add pull.mode=3Dff-only
> > >>  - pull: add pull.mode
> > >>  - pull: trivial memory fix
> > >>  - test: pull-options: revert unnecessary changes
> > >>  - test: merge-pull-config: trivial cleanup
> > >>  - pull: move configurations fetches
> > >>  - rebase: add REBASE_DEFAULT
> > >>  - pull: show warning with --ff
> > >>  - pull: introduce --merge option
> > >>  - pull: trivial whitespace style fix
> > >>  - pull: display default warning only when non-ff
> > >>  - pull: move default warning
> > >>  - pull: trivial cleanup
> > >>  - pull: cleanup autostash check
> > >>  - pull: refactor fast-forward check
> > >>  - pull: improve default warning
> > >>  - doc: pull: explain what is a fast-forward
> > >>
> > >>  When a user does not tell "git pull" to use rebase or merge, the
> > >>  command gives a loud message telling a user to choose between
> > >>  rebase or merge but creates a merge anyway, forcing users who woul=
d
> > >>  want to rebase to redo the operation.  Fix this by (1) tightening
> > >>  the condition to give the message---there is no reason to stop or
> > >>  force the user to choose between rebase or merge if the history
> > >>  fast-forwards, and (2) failing the operation when the history does
> > >>  not fast-forward, instead of making a merge, in such a case.
> > >
> > > Despite what the commit message of the tip commit says, it is not "t=
ime to
> > > flip the switch and make ff-only the default" because it breaks our =
very
> > > own test suite left and right. See for yourself:

BTW I suspect that the test failures point to shortcomings in the patch
series that should be addressed anyway. I saw at least one obvious
omission: when `git pull -s <strategy>` is used, I find it relatively
obvious that the user wanted that to imply `--merge`. Yet t4013 fails
thusly:

	+ git pull -s ours . side
	From .
	 * branch            side       -> FETCH_HEAD
	fatal: The pull was not fast-forward, please either merge or rebase.

It is test breakages like these which make me believe even more strongly
than before that it is really reasonable for contributors to make sure
that their patches pass the CI build before asking for reviews.

Ciao,
Dscho
