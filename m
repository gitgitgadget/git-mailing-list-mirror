Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31446C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 09:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiAVJcB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 04:32:01 -0500
Received: from mout.gmx.net ([212.227.17.21]:53043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229660AbiAVJcA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 04:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1642843918;
        bh=fasZiJ3QyBGzB6zPdTVlh8BurwiEMUyD+Bz2fnP9lfk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NS0ZpV3eTSD//z2B2PnZqexOokuYLmNCMSPPjtMdXfq80cZpYO07T3PFDjC2B8OxJ
         rdWWzbDAzdOpaXCWR1f3L48n5ZHT4I+4AeVCqnGD86VIUQiXvcp4SN3rdcM3NHL3Bd
         DdVjv7FWJeMN1peCRdEhHAQmZ+Jq7wgX6b9jdLfY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpUYu-1mWPQY1qjE-00psnT; Sat, 22
 Jan 2022 10:31:58 +0100
Date:   Sat, 22 Jan 2022 10:31:57 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 0/3] [Non-critical]: sparse index vs split index fixes
In-Reply-To: <CABPp-BFXMMH2_qqWPGaWX76mqEs2Z1GFNzbyeu2rLgaFPt7JyQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2201221031250.2121@tvgsbejvaqbjf.bet>
References: <pull.1119.git.1642613379.gitgitgadget@gmail.com> <CABPp-BFXMMH2_qqWPGaWX76mqEs2Z1GFNzbyeu2rLgaFPt7JyQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hovIvljgL5j06cZbhIf+ejao8qq/7YL/nvKErm2Dy/OcHvL6VXe
 gj7zE5bqLEA3eGCfEuuxgPkiihHb1T18frYezbliCehy3fa16mPjKErLirFJlTJBZf28p1h
 bN6A+L/9dZRwfA5uYc5kvoQV51noGXi+hwRlN9kaTJJ6fzo64V5FC/kxe7+WbZQNtB4+5Bk
 snc9+oSNcPxFfd0hi/V+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TD/BoMPlRIE=:RdkTwjEikavJcC0mbL9au2
 HBC6b3qFJ3nFPFVtLpK9bgIzbDC0KH5aAh1mCsi/zZpL6gxol7b8L5QpfCmiDgSF2tZ3mV9Dy
 sj1Q5yj8V24Aq1qMi4Rqhg32hdsaqZTLlU30aS21/CsiGUurPfoWOtKsyBDVCEJogYgDraMDw
 F0IQeW8/BDD+wLUSbgsEkW7b3CLS118HYzYrC7GfQZWT8qGfc1AHtHsRU4gnDS8Qa/IexqmYg
 9wFJHPcoSd97NaqtdbWGnZEo9SMIPMEPAXWkU0PfHVG1fW0CiuaU9gpLLarmsmfFXQ6MAJd6X
 HvzSvPuep0d3BcSxAz/O4BRf/MPfmIAFXmazAlgU9qSFPsGjz6U19J/40b2/y/mmbmPJ5QZPS
 sYsWOTMcxUum39ErnsK5WIbQwJ/jNh26Ukea+lt4Vn8KT0Tc+jPN+wo8SMOeWKTgDqtTco2tG
 mJDgbZQ8apUj0VizlGgOv/mwbW7iJN5qfRZJYO4VPe9A875WMtCEbR/onLHc1L3oWZRcCz1oh
 We3PFbx9CTkKXU5/PWVN+zitnJTeSmVGERfvyAYiaG+InOG07+enwikWz9ERy427Un8CR6sBN
 OvzItb/QhrjEHzE8KYzDA6FQ7xCeMMifaSu15s05lcG5sDhyTCqaOlvsqY0spsAyOpQSmO7jK
 186F0od2qfbOjT7AHutPNjnUUpZZ6oYXzSWHvkRL08JMwks5eOP4n3UVcjoZarYVWfMJUXCLz
 4AeCy9inEWDDpjCofgCOoNZ3HTDq6X24jd8KoH6naFi8ywZkGQLDf3np51pIjRtzckwgMoU4i
 tWpO4DM+hzL9YxzpVCPft/DGerBAJj8VdwSi1E/g1pDEyRMe6KIxvDgwHzXy1qsPyYWhfJv+D
 uk5EH5ATtI5kOK/oAY01xtAIQwGmrbJeUv1lB5L4DnSCtzy9lkumdClnutfmpR/xO82hzgUiU
 epM/P+Untxoso5wxVNLdarMj7R3Jp14yVIlUEsFNGqHQji/0eN0DTagKT6hNgZSoW2Ndbv/lq
 BaXwqPldMSUF5fi1ucJqFc4JaLguJWkSRbmgWD6DdkIYd9D4IL2lHJ9qwgHHLp1OaQC7TpxYu
 ikjfPLnIvjgBfY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 21 Jan 2022, Elijah Newren wrote:

> On Fri, Jan 21, 2022 at 11:53 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> >
> > We noticed split/sparse index-related issues while rebasing Microsoft'=
s fork
> > of Git. These fixes are necessary for that fork's test suite to pass, =
but
> > they might not be super critical to get into upstream v2.35.0 (especia=
lly
> > this close to -rc2). However, the team felt that the decision should b=
e left
> > to the Git maintainer whether to take these patches into v2.35.0 or no=
t.
>
> Thanks for digging into these and putting in some guardrails to
> prevent similar issues.  I hit similar things with some of my changes
> and had to fight t1091 to get it to pass in CI under
> GIT_TEST_SPLIT_INDEX=3D1.  I don't recall seeing the specific error you
> mention in patch 1, but maybe I just overlooked it.  I ended up
> finding little workarounds such as disabling sparse-checkouts at the
> end of various tests before new ones I was adding, and being extra
> careful to not leave the sparse-index selected.  I probably should
> have dug further, but didn't.  Thanks for digging in.

Seeing how much time it took to properly diagnose and fix these issues, I
do not fault you ;-)

> I've read over the patch series; it looks good to me:
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thank you!
Dscho
