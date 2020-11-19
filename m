Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A76BC6369E
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 10:50:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 017DA246EF
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 10:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="G4ZiKb2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKSKtj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 05:49:39 -0500
Received: from mout.gmx.net ([212.227.15.15]:51073 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgKSKti (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 05:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1605782970;
        bh=pUEe6Y9rj4uw82JfxxfBUP6npAtHVeyQyNEQi7qJdiY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=G4ZiKb2iTgvIJb9JD2tiZ2W+Q961oLyUQNBdWconubozzdGnbrZADb0uiw1L2sExd
         iia2IvB/FkiO4BbYQLTVqXZa9gOe/FWKH8CRazhQWlIOilMFELu/N6eIQm4Ow7WgQo
         il//4vFpxDtNPFcZCfQNSMhbp8U+/bgDoHbFwoY4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([213.196.212.61]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSbxD-1kqvml0zpR-00SuwQ; Thu, 19
 Nov 2020 11:49:30 +0100
Date:   Thu, 19 Nov 2020 11:49:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] t1309: use a non-loaded branch name in the `onbranch`
 test cases
In-Reply-To: <874kllre8f.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011191147490.56@tvgsbejvaqbjf.bet>
References: <pull.791.git.1605709410465.gitgitgadget@gmail.com> <87a6vera3q.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.2011190107160.56@tvgsbejvaqbjf.bet> <874kllre8f.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1424220650-1605782972=:56"
X-Provags-ID: V03:K1:gKSVxZbuFTuyOI6L94YZDdggwbLErrAcuVt0KbGzpv9N3WRsk/1
 iwaY6X5pRvvC0WWzvtm2cz9OvZW9aigJyComP/c4rMONpd0eEF1Q/5ovnqWlcfQxlFl6KlC
 pWbNJK3Mn3wApiEm/Q/Op+v/UYqjmZ9sI0rNvIEbysTVtbKXghzfGdRO+bkFlJenjVmTUlu
 y0Hf1yq2/wjaSGiTSnUzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9bTQq1wKR4k=:m1yBbiSdpbG9ePiKB5lmff
 RJzEewnwoGZkL0vGFM8JCgBxbV+SKf6BzIdqjjHOYtrDunIIusXbA39pcNkYvrK4Dqt+tC1zk
 TUQym28wOoxC9fK4WtxfM08vxklqKjSf4on++5goLeSx7rKDajiqEMbzjvXCgUfnv3OPrOYOk
 EBPZrDHpQ9Ks7vFxrPJ4JgCoBhDvMjwDH3WI1ee6TEsAY19dMUbFKB5Ttlm2ns0AzvJD4fYa4
 53i8NYVetA5a53iKHCI3fHDoxIHamFWUUUGFXRboxUbJwBUZdtJdPdOtbyVyA4seyXtiFP4uF
 liUK1VHYG1UgD8D5HX3RmkohvqOtU8gBTqG69FOKmz77+l9XuXiVQgKzncn3Lqyai249kIHeQ
 KvJmbsaNUn+ESIlsholT4/okIaB2mKsqAWMAFG19zlfmZPII3aZlLnP0fkMN6g+0ksZZjnTcW
 f9TKi4FhvrpvWK50VZRbYZ9So9cn55qfugXneOsqGBxFfwJ4qaIB34+5eyX3k13XSRiHZXSlT
 qK+yGpJGnmAkZvzJSJET9D2oO93omxbFheO4M0q3QzBZvGkVV0/0OljbBqaAskTFWN8ZY8LPE
 iFiZEAJjDxjWH9EIAEQSkTVWLpzVeF8sT3ATflBnzBGDEqDgkJAQqm1UvZcTLy87ANKjsQm3b
 6Q305uAxoroNAssjH6sgHbZaPGMqPY4RVGK1XI1TqOib0kJ5lsF7FCz0w6yL2saNhj223LoI8
 eGf1UmiRXkjttORtEmH5zJ/CMvSa9V8pUm3aCR48AI2sDiImbVW8GGV1rF+41lcP7JzV1Kkri
 xUo+uqosrrrzYC5Zi3bG2ayfETVv0EhXqQyzLRt/+WyT+CErnrWeiHJLFWPRO0UNMXw66e4na
 tNmDB64mUNAylrwkKjGX2fY4l7G+NZqH1x37QB/wk=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1424220650-1605782972=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Thu, 19 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Nov 19 2020, Johannes Schindelin wrote:
>
> > On Wed, 18 Nov 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> On Wed, Nov 18 2020, Johannes Schindelin via GitGitGadget wrote:
> >>
> >> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >> >
> >> > Therefore, the actual branch name does not matter at all. We might
> >> > just as well avoid racially-charged names here.
> >>
> >> It seems to me the actual name matters a lot, and it must whatever
> >> the default branch name is.
> >
> > Nope. Not at all. Because what we're exercising is the code paths when
> > we _don't_ have a branch name to work with.
> >
> > In the non-Git case, this is trivial to see. There is not even a
> > repository! How can there be a branch?
> >
> > In the early config case, it is too early to access the refs. I meant
> > to reference (but forgot) the commit 85fe0e800ca (config: work around
> > bug with includeif:onbranch and early config, 2019-07-31) because that
> > commit's commit message describes the catch-22 that is the reason why
> > the early config cannot see the current branch name (if any).
> >
> > I should probably have thought of referencing 22932d9169f (config:
> > stop checking whether the_repository is NULL, 2019-08-06) for the
> > second test case, too.
> >
> > So again, these two test cases do _not_ exercise the code path where
> > another config file is included. To the contrary, they try to prevent
> > a regression where `onbranch` would segfault in one case, and BUG in
> > the other (in both cases because the now-fixed code used to try to
> > look at the current branch name _anyway_).
> >
> >> I.e. what the test is doing is producing intentionally broken config,
> >> and asserting that we don't read it at an early stage.
> >>
> >> Therefore if we regressed and started doing that the test wouldn't
> >> catch it, because the default branch name is "master", or "main"
> >> if/when that refs.c change lands, neither of which is "topic".
> >
> > No, if we regressed, the code would start to throw a BUG, or a
> > segfault, respectively.
> >
> > We never expect these two test cases to look at any branch name at
> > all.
>
> Thanks. I mis(understood|read) it.

I guess the commit message could use an update.

Ciao,
Dscho

--8323328-1424220650-1605782972=:56--
