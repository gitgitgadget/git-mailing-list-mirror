Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE147C4332F
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 09:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbiKHJQs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 04:16:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233732AbiKHJQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 04:16:45 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F6162FFE8
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 01:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1667898977; bh=TIeqHHEVQlVP0zV/ZvrAUWj1N8JqFufqdvoq2xx8kKA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JoCeeul5JnBXdxi9qqOvpd8gO1uI1SD4VbSdRix8J+UatELcDIidBvBkHEoxHl+vC
         v4l8jBOP55X7x/B0l6RcFnszVgc2SMCzTZZsud51A22yVNrvd8iuiUY240N+xmcP56
         nbqOAHYvEM08l92bbKaSUeh1IRRazpabUikMC/YmHVUn5Fpf1DS4gh/1cPZtQCOGkq
         ZtR+IS4Ka4vjKCH6exRvuwvjh8BqC06h+3FJYzkFh5jc4iIUt/DrygRmEsqVR+9bJS
         HSiEQfpIPlYTpGfcm25GYVGfr3Sx5N63AYSQ3iyYZoNQV4K9hKD7jGPi1VcOaARwaj
         rDkaSNLkUCYpg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.27.219.74] ([213.196.213.188]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1obce609bj-00JdK5; Tue, 08
 Nov 2022 10:16:17 +0100
Date:   Tue, 8 Nov 2022 10:16:15 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Jeff King <peff@peff.net>
cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid unnecessary builds
In-Reply-To: <Y2SFGmQnx7CXtTEI@coredump.intra.peff.net>
Message-ID: <oo9ssp5n-6ors-n309-2r2n-3q43rq7pn89q@tzk.qr>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com> <221104.86bkpnzdqi.gmgdl@evledraar.gmail.com> <Y2R3vJf1A2KOZwA7@nand.local> <Y2SFGmQnx7CXtTEI@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1072297263-1667898977=:208"
X-Provags-ID: V03:K1:1y3UOUJEz8t1p930mMi4wVqtjimezyI73GuMslN+uaoofIp0Oig
 9goeE8UmqhwHPWXsrrByPPhltQTs4Lr51ocDRh403w4kpbHKbFBMfvJxLNwoYxfurzBCJv4
 qPSUixyISsFjQepKzwHXlgGORJl+Oeh+V5fAV8xPFK7rGzjGDkkfbZQ9Go4otsqZXyKnTcH
 zdsfVgXAm0hbHbk+dbNkA==
UI-OutboundReport: notjunk:1;M01:P0:/z2pWTQ42Qs=;nEkegFzgnMrVFO2ZwCu+NylvbHY
 rNP4/KLrk160ElAxFJM0PmLOGEUsflaixLJXSufGrJts7Xz/hE3b6tgWcqThA6Sjs+BLBBGKq
 2mH4XC8ELW6KU7xLKjdqyA1DbYSJRKLK2vNHFB3VIiy8HbrnZR5wyvulSza4saLs7623sedNW
 HbMljDNdC8pCxXCuHGYNyJn/rLwh7qqmkTe3a0EszZW/eG2XcQvNhH10Lja7omdp6aXIuQ/X6
 y9tyHHwZkrqkudJGBncD+LnakNyAT528r20yr6XPP7aTQcfbqcou/G3WJ+irEZMDrMXBSpqv3
 uot5/f3ev2JdRVB9JW/suPc/cg/nWOGucaD52mibsjKv0gme06Cf7UThf5PhGu0bbdtdTKmWp
 iZJknMDWj1iO/TtVGR+qdoHiMzuilfhNHMcHT5ipj1T2BT95FjWc7A6VbXC0MK+i1iMUasueG
 bnmB3ea4X2H7JXGpXBaCpsKJTwIchuJ2KGJAfW86zxCWhrB1HZEy4qqvGIxAqKr3F8SADPkKE
 gRPL3zVlgcPMaC8wVMoEkeQjTJ+sRKrcdnzURTqCpyiXQW198IeKroDQlB6xjizE8N7ur9Rq4
 bWe1WBOIaSr5niT+KY1FiAEIxkkERzdjsluHgwdxkuWL+NyCd8OiIq6hjFF0kmuVb48vuPm3n
 opIA04C5AZGEWOAnlnjRGHXwxCFTeV1npi52VBPgXzHVBgkuywkn9BQ7GezEPaO56tR59/VjQ
 s/bG9PkqsiO7uY2V4+zcKawtEXe1EJcFqLdjPt1YoITA5l0JImPTj9BMqc5L3ulhDkSpd2G2m
 Gw8Q3yvtzYN0ixLT/5X/hQuZoSnrCxjGHynoc2LWn7AItAdyGRz2q8DQkqfGg118LOCbKlQTX
 fYyljDpV084Qf7V5CQ/aU+txHK+2A2jbVljIlbgHU0wGKdRgbAQIJ0/v+FsMRqbhnZtW9P2Uw
 mtQvI0ePQRnqPe/Ek80ZrByMxB4=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1072297263-1667898977=:208
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Peff,

On Thu, 3 Nov 2022, Jeff King wrote:

> On Thu, Nov 03, 2022 at 10:23:56PM -0400, Taylor Blau wrote:
>
> > But I think you make a compelling point (which doesn't match my own
> > workflow, but I can see the utility of nonetheless).
> >
> > I was thinking that we could rely on something similar to the ci-confi=
g
> > ref stuff from back in e76eec35540 (ci: allow per-branch config for
> > GitHub Actions, 2020-05-07), but it looks like it'll be a little
> > trickier than that, maybe impossible.
> >
> > We need to know about the state of the ci-config branch before we set
> > the concurrency bits. So I think you *could* do something like:
>
> As an aside, I wish there was a way to interpret per-repo environment
> variables in the actual action config.

There kind of is. "Kind of" because it is not _really_ a per-repo variable
(those do not exist on GitHub), but there are topics you can set. These
are relatively free-form labels you can attach to _your_ fork, and these
labels show up below the "About" section and the link to the home page (if
any) on the right side of your respository. AFAICT these topics are not
inherited automatically when forking a repository, which is precisely what
we want. See
https://docs.github.com/en/repositories/managing-your-repositorys-settings=
-and-features/customizing-your-repository/classifying-your-repository-with=
-topics
for more details on that.

A GitHub workflow can be made conditional on the presence of such a topic.
I use this, for example, for an opt-in build of the InnoSetup installer:
https://github.com/jrsoftware/issrc/blob/is-6_2_1/.github/workflows/build.=
yml#L11-L12
The build is opt-in because it requires a non-free build environment,
configured via two repository secrets containing a URL pointing to a
`.zip` file and a password to extract said `.zip`. As you say, I cannot
make the build opt-in based on the presence of secrets, but I can use the
presence a repository topic as the knob to enable the workflow.

> The current ci-config stuff works, but it's pretty horrible because (if
> I understand correctly) it spins up a VM just to evaluate a glob and say
> "nope, no CI needed on this branch". So:
>
>   1. It's wasteful of resources, compared to a system where the Actions
>      parser can evaluate a variable.

Indeed. It might look like the job only takes a few seconds (at least that
was the argument that got the `ci-config` patch accepted), but that misses
the queue time, which turns this more into several dozens of seconds, and
the recorded total duration is much longer than that. In
https://github.com/gitgitgadget/git/actions/runs/3412982102 for example,
the `ci-config` job only took 6 seconds, according to the page, but the
total duration of the build was 6 minutes and 56 seconds.

>   2. It makes the Actions results page for a repo ugly, because skipped
>      branches clutter the output with "yes, I passed CI" even though all
>      they passed was a trivial job to say "don't bother running more
>      CI".
>
>   3. The problem you mention: it happens too late to affect the overall
>      Actions flow, and instead individual jobs have to take it into
>      account.

And

    4. The way `ci-config` is configured is sufficiently "magic" that it
       only benefits very, very few users, at the price of adding to
       everybody's build time. To see what I mean, look at
       https://github.com/gitgitgadget/git/actions/runs/3416084640/jobs/56=
85867765#step:1:1
       and at
       https://github.com/gitgitgadget/git/actions/runs/3416084640/jobs/56=
85879914#step:1:1
       turning on the timestamps (i.e. click on the sprocket wheel on the
       upper right side of the log and select "Show timestamps"). You will
       see that the `ci-config` job started at 3:22:05 UTC and the next
       job, `win-build`, started only at 4:16:03 UTC.

    5. There is official support for the desired behavior that comes
       without any magic branch with special content that users somehow
       need to learn about: If you push a branch with commit messages that
       contain `[skip ci]`, the build will be skipped, and no time is
       wasted on running any job. For full details, see
       https://github.blog/changelog/2021-02-08-github-actions-skip-pull-r=
equest-and-push-workflows-with-skip-ci/

Having said that, the `ci-config` job is used for something I find much
more useful than that magic `ci-config` branch handling: to skip builds
when there are already successful builds of the same commit or at least
tree. Sadly, that logic fails sometimes because of an unresilient REST API
call: in case of network errors, we fall back to not skipping the build
_even if_ there has been a previously-successful build of that tree.

If it was up to me, I'd simply rip out the `ci-config` branch (`ci/config`
file) handling and tell users to mark up branches that need to be skipped
with `[skip ci]`. That has a further advantage of being actually portable
across a wider range of CI systems (for example, CircleCI supports it,
too: https://circleci.com/docs/skip-build/).

But then, it would not save us a whole lot because the `ci-config` job
_still_ does something useful (i.e. checking for previously successful
builds of the same tree), so that time is still spent. But how knows,
maybe there will be out-of-the-box support for that at some stage. =F0=9F=
=A4=B7

Ciao,
Dscho

--8323328-1072297263-1667898977=:208--
