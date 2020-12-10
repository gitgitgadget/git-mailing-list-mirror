Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF85C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D152310D
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgLJPAX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:00:23 -0500
Received: from mout.gmx.net ([212.227.17.20]:58053 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729076AbgLJPAN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 10:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607612313;
        bh=XqeiPAnP9tXxKMedquZtY00f9YsrrlJ9pAYB2jtCQ4s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=leqibk4grKGsS1tZnVcK+d/PEF0eIqK74Vb4TObR0egdCsCtNPI1JijLSHji1axhp
         1QJB3R9O5lItEkspj28izxGkdZZ7ThjyyEMCOyOh4RqaucFtMc6UajcOrFDmBK3L/3
         34lGujxAxKJrRL5e50hapD8p3nq7PrOKWWflBMTc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.212.111]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGQnF-1kvIpB3JKn-00GqFR; Thu, 10
 Dec 2020 15:58:32 +0100
Date:   Thu, 10 Dec 2020 05:40:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
In-Reply-To: <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2012100507450.25979@tvgsbejvaqbjf.bet>
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet> <xmqqk0tq1xf3.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:NGhXxOld8HP6q8joVQT4Sju18K8QsFhtHvuBVZ8v9hrdcLawZTy
 yLvYiGKLtw+0VBbwXxg1ua14VYuvGPa8xdtJJOh702hcHLmC+s9Q71k8L4meL9Ti+2me1qN
 vCVf4F2G7v2DPHEGU5nqv7tk5uSHVuuOazVY81a91w/C2Bh5BbG4Vy62w/k5yIGM0Jb7HvV
 32iMEtyHnJNbyhgL1dKCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:v+v+q6dfWus=:Ff/3XnLlDSg5OtLB8MYYtB
 CZFfrGLHDT7fUdg74bOa3GGiENKeUsxlzW76uL+uVU66RzbC2PMcbYd6l9CqYK+j0XG9Gwynx
 csgb1LBdLsdaBIVicnxSD+P9ShuN4qytuCFdzlF9d6kEdUwHyp8GucUZROfSWSBWS9Yva6rn3
 9a/OrN30Z9/+bt9hwXWKyUvoGsJVSHoqLvS3tgQKJV2LfCv1Ky/c9qFxwnvd6kWnQgcPESDtv
 WMsN5W/zNZsnEGKpRR5lZWODZec8SOZBMM1uvBHvugh3jw0Z5yJoqBD3B/yR2odgo0cR4FI1b
 3V3XfIp1VuezYpCoxp6FjLMHUTB+6ZoD8aiow9h6d2fiaimAx6HAuhYsMSePBh1xQngroWkbL
 3RsKRIzJ7qWxw9w+/CGCHmWsZ7Blabf3zS9/17ZlKk5gQ/bXYDfm8wV+pGVAbGHSwX4OPTnWx
 JzQmjmtJT9nz8r2uWIPlgKeNdAkqQ/zen4TXLEb0Cb3VvbAldKNJCqXaH1OX7IdkENDbNWpm6
 tePIa4t+K3b93XHJ7oH9G4mqRAobTI+3RppANFdEbGa79numN41b16jT1nvXkT9QPTCRz8+kM
 z3Tu/SuRTSoQQSWNnTZqQ/B1rfEEoIJ2lE1FLZTw6q9Rohz8Cm0uYABO+cbnzpnLZPr+ScGVX
 YlLUGJ5yG/Q8tGBS5v+G5dOl6IB6tvrTysQ46TC0H27d1mGCqwhhZQXR+2txnnzA3LM3YQDI/
 wMmX0GxABkaJ04UzTlbzuulfV1UTg5vGzlam7pJz93f0fDgsuWJWTGrPlAHDJULGKjlmJyIxo
 ViJZ84YWUBmIhxCo6DGZKX1wE4paJ7FuPj0ID5jCtuZrNCIA/cunuDFKORMIp7NeNNKqDfRkX
 mCcVYXlpLxb1+YjBil5H96szV5305Rq9b+3E5YhLU=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 9 Dec 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Tue, 8 Dec 2020, Junio C Hamano wrote:
> >
> >> * fc/pull-merge-rebase (2020-12-08) 19 commits
> >>  - future: pull: enable ff-only mode by default
> >>  - pull: advice of future changes
> >>  - pull: add pull.mode=3Dff-only
> >>  - pull: add pull.mode
> >>  - pull: trivial memory fix
> >>  - test: pull-options: revert unnecessary changes
> >>  - test: merge-pull-config: trivial cleanup
> >>  - pull: move configurations fetches
> >>  - rebase: add REBASE_DEFAULT
> >>  - pull: show warning with --ff
> >>  - pull: introduce --merge option
> >>  - pull: trivial whitespace style fix
> >>  - pull: display default warning only when non-ff
> >>  - pull: move default warning
> >>  - pull: trivial cleanup
> >>  - pull: cleanup autostash check
> >>  - pull: refactor fast-forward check
> >>  - pull: improve default warning
> >>  - doc: pull: explain what is a fast-forward
> >>
> >>  When a user does not tell "git pull" to use rebase or merge, the
> >>  command gives a loud message telling a user to choose between
> >>  rebase or merge but creates a merge anyway, forcing users who would
> >>  want to rebase to redo the operation.  Fix this by (1) tightening
> >>  the condition to give the message---there is no reason to stop or
> >>  force the user to choose between rebase or merge if the history
> >>  fast-forwards, and (2) failing the operation when the history does
> >>  not fast-forward, instead of making a merge, in such a case.
> >
> > Despite what the commit message of the tip commit says, it is not "tim=
e to
> > flip the switch and make ff-only the default" because it breaks our ve=
ry
> > own test suite left and right. See for yourself:
>
> With respect to what is in 'seen' that are not marked as "Will merge
> to...", I am merely a messenger, and you are shooting one ;-).

Yes, I guess my complaint was not actually directed to _you_.

> I know of these breakages, becuase I've seen them before pushing the
> integration results out.  The first-parent history near the tip of
> 'seen' looks like so:
>
>     4a386f47a7 Merge branch 'fc/pull-merge-rebase' into seen
>     e0b9615ea3 Merge branch 'es/config-hooks' into seen
>     addabb0fb7 ### start breaking 5411,5520,4013,5524,6402,5604,...
>     0ffeed16ab Merge branch 'sj/untracked-files-in-submodule-dir...
>
> Notice the ### separator?  Everything above the line breaks 'seen'.
> (Emily cc'ed---even though her config-hooks is not on topic of your
> message, it is above the separator as the result of merging it to
> 'seen' breaks 5411).

I had not actually noticed that separator because I had worked off of the
topic branch itself, and it does not pass the test suite.

> The reason why I am experimenting with this is because I suspect
> that those who are involved in the topics above the separator would
> want them in 'seen', as it would be easier to work with, when the
> breakage may be coming from interactions with other topics, to
> pinpoint what interaction may be at fault.
>
> But if you and others who are not involved in these topics above the
> separator want to see 'seen' in a buildable/testable state by
> excluding them, I am fine with that, too.  It is a hassle for me to
> maintain the two parts of 'seen' the way I pushed out last night.  I
> have to identify which merge of the topics into 'seen' breaks
> builds/tests, shuffle the order of topics, minimizing the number of
> topics above the breakage point, and tentatively rewind 'seen' to
> below the breakage point when building and installing for my own
> use, etc.  It would become unnecessary if I can just discard new
> topics after seeing builds/tests break in 'seen'.

It is up to you what you integrate into `seen`. From a purely procedural
point of view, if it was up to me, I would liberally drop any patch series
that does not pass our CI build. In my mind, patches must be correct
enough to pass that check before they are ready for review.

Please note that I am making a big difference between patches that work on
their own (but break the test suite when being merged into `seen`) and
patches that break the test suite "without any outside help".

I am happy to assist in fixing problems with the first category (those
that only break when merged with other topics). It's what I do already in
Git for Windows' `shears/*` branches where Git for Windows' `main` branch
is continuously rebased onto the four integration branches of git.git. The
idea is to catch conflicts between topics that are in-flight.

At the same time, I would rather like to avoid having to fix the CI build
for topics that are already broken without even being integrated into
`seen`. I did that in the past so that I could benefit from seeing
conflicts between Git for Windows' topics and upcoming changes in Git, but
I plan on leaving things in a broken state when I see broken topics (i.e.
the second category I mentioned above).

> > Given that not even our very own test suite is well-suited to this cha=
nge,
> > I rather doubt that this is a safe thing to do.
> >
> > In the _least_, the patch series should put in the effort to show just=
 how
> > much work it is to adjust the test suite to let it pass again. This wo=
uld
> > also give an indication how much work we impose on our users by that
> > ff-only change in behavior.
>
> I do not doubt the need to make sure that the test suite covers the
> new use case as well as the need to adjust the existing tests.
>
> Having said that, I have a strong suspicion that the "turn the
> current warn-but-go-ahead-to-merge into error-out-and-stop for those
> who haven't chosen between rebase and merge when we see a non-ff
> situation" this topic aims for *can* be made without causing as much
> harm to existing users' workflows as these test failures imply.  The
> reason why I say so is because the existing behaviour of loudly
> warning is so annoying, even with the current behaviour of making a
> merge after showing the warning, existing users would have made and
> recorded the choice in pull.rebase long time ago already.  Those who
> want to rebase by default would have had more incentive to avoid
> the "warn but still go ahead to merge" doing a wrong thing to them,
> but those who want to merge by default would also have set it, if
> only to squelch the annoying loud warning.
>
> A spot check: do you have pull.rebase set to anything in your
> config?

I do, as a matter of fact.

As do Git for Windows users as of version v2.27.1 or so, because Git for
Windows' installer now asks specifically about the desired behavior and
configures it explicitly.

> So, if this "default change" is done in such a way so that it won't
> make any difference to those who have pull.rebase set to either yes
> or no, I suspect that the fallout would not be as bad as what these
> test failures imply.

That assumes that all setups call `git pull` interactively.

In my case, I have tons of automation (how would I be able to maintain Git
for Windows otherwise?) and I recently stumbled over a `pull.rebase`
advice in one of those pipelines.

Since the advice was non-fatal, I did not fix it (and would not have seen
the advice at all, if it hadn't been for an unrelated problem I had to
track down).

> On the other hand, if the implementation in the topic forces
> everybody (including those who have made the choice by setting
> pull.rebase) to set another variable before allowing to work with a
> non-ff pull, it would break everybody and is a disaster.

Well, here's my vote for keeping the current behavior to continue to merge
and show that advice about pull.rebase. I find it the least annoying
option of all that are available to us.

Ciao,
Dscho
