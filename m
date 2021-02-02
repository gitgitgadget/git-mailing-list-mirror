Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF21C433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 23:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679D664E41
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 23:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236269AbhBBXJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 18:09:21 -0500
Received: from mout.gmx.net ([212.227.15.19]:42243 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236266AbhBBXJO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 18:09:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612307247;
        bh=stGshHcGrPknRThQKBRHdVUu4cVhHtcAX/IR8NgYm/U=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SxgY9CJ56yCfo23krRJijkSqLffMWvWyZ0/wTybd2CF8QHL9FzN2g3aRp+SZi0OZf
         xadjYm8AW7D/EGOwB8wDqHqyYyWhmMaabp0u9pVGC4yMJuAxykEL+GdCcyTwe4hHfA
         WIXz1v2xPRuq62h8Q32NkCiB+SAvNAyodJ97d65s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFKGZ-1l90ZK0aRV-00FnXx; Wed, 03
 Feb 2021 00:07:27 +0100
Date:   Wed, 3 Feb 2021 00:07:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff Hostetler <git@jeffhostetler.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Chris Torek <chris.torek@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 00/14] Simple IPC Mechanism
In-Reply-To: <1be67634-4188-9ef3-306c-72b78ea856b5@jeffhostetler.com>
Message-ID: <nycvar.QRO.7.76.6.2102030003300.54@tvgsbejvaqbjf.bet>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com> <pull.766.v2.git.1612208747.gitgitgadget@gmail.com> <xmqq5z3bjuqs.fsf@gitster.c.googlers.com> <1be67634-4188-9ef3-306c-72b78ea856b5@jeffhostetler.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:O1zXTlPu6UiF5rWEVr8gtNsd4fLITejARJBWze3xx6QIetC2eg7
 3DHLEGsY18naIMZZWsxnLwjOds+0uk8LTeZPR+1YYJjwQRUtC80at8uzQmBA3He5InMxXD9
 HWtlTwGEMYoqfppI5yJ1sbDs16x8AlQNAa6rFh6svBH2JN1QlQmPiULj1CTGmCC8ntttR/T
 SIg5z3urPVTrMNYixVFIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Cuv6mBGyqDc=:Wmco/EU6gKB1Aws15EQeWb
 or1EDXrs9eV2sWqZwVkXHOYz8e2TnjGOuEACw2ILvc3Auipft5H5QkpIdFP8cGLdpA7fU01hk
 cvt0qCTPLknMvLnbYKzOnPIKlhR7k0IIyAXNFr4GPTM59/H1dxkMQ+25WcNd2uI5GDhFxVCY5
 3sM9VXUBw1rXeBpnsY/vgrfuNnUjvsyuIrN4x6+J3KmyrVl2ZpWqxrg0wvjGRLw96qe5h41yL
 9JCRMpKhPjJmQwR0l/XowgutrG/zL5qxOaGmmByH/IsFwrPzpoqS1bChLWeVI9vnn6iNWD5uW
 74Rj/P5QWfe4Ty+Sd7L0IchOyDAgqR2zN/IWZwWLGM11/gvl9RqWxOHMxOJXXeD6nE54rj08+
 Of9aeQ++ZxxwNaN1cHbboYwUw6bpu1uBEgKm+y8BPT/IbzmOTV1OHl1ZDb2j2qgKir07eS1XD
 FcowGlwcLtcfKT+rQUxMI3s0b4B1+aw8+Vn3tMRqYJdooSKLmvBGQn7ZwKtkSx6hGF7WpGpTa
 Tv/U8yrjHss1Z0lY29fan9jsDvYOGcdE2dq8yZ9dJxP3J6co9eJaAMC4PVigyfew93TIUdsaV
 rT03y8ZJ9YW3SzvXgqz9NActXWC9BsJhlA0YnTFmulsEPaYhkDQznpUOLIpKoARK+r05cV0Su
 ig/NiZV9AMYQyLehe7xiQfgKdEAB+SNKoBxhG2PqD84VahLhXsZ3QaiMK/rKXsx+S6uUwVzed
 /c1n+qHC4q8hzfBkiJOzwNqa1AGIFHqI+RMcGNiDv6Lk6n7uIXk24yE72dMXHboLpF+PHYFhS
 0XaXqSY53/V50/ZZ1AZuXTVo9IBEne6VpPQ2its+1tsrl2KhvtY2Lq+76sWjoz2z/3BV16Dkq
 YIlWN7l/0zCs40luKHQujcgMbYa+ubV19opaYdpXA=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio & Jeff,

On Mon, 1 Feb 2021, Jeff Hostetler wrote:

> On 2/1/21 5:20 PM, Junio C Hamano wrote:
> > "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> > > Here is version 2 of my "Simple IPC" series and addresses the follow=
ing
> > > review comments:
> > > ...
> > > Junio C Hamano (1):
> > >    ci/install-depends: attempt to fix "brew cask" stuff
> >
> > Huh?
> >
>
> Sorry.  I had to prepend that one to the patch series to get the
> CI builds to run.  I've been working rebased against "v2.30.0" and
> GitGitGadget references "master".

The idea being that we want to be able to merge this branch as-is into Git
for Windows (and also into microsoft/git), and therefore do not want to
base it on a later commit that is not reachable from git-for-windows/git's
`main` branch.

Maybe it is time to merge `jc/macos-install-dependencies-fix` down to
`maint`? Then we could base Simple IPC/FSMonitor on `maint` instead, and
would still have the benefit we want.

Ciao,
Dscho
