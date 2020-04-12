Return-Path: <SRS0=e9fP=54=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF673C2BA2B
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 17:56:16 +0000 (UTC)
X-Greylist: delayed 68 seconds by postgrey-1.34 at mail.kernel.org; Sun, 12 Apr 2020 17:56:16 UTC
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iS/oC2CX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671FF20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=git-owner@vger.kernel.org
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671FF20692
	for <git@archiver.kernel.org>; Sun, 12 Apr 2020 17:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgDLRzG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Apr 2020 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbgDLRzG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Apr 2020 13:55:06 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Apr 2020 13:55:05 EDT
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF430C0A3BF0
        for <git@vger.kernel.org>; Sun, 12 Apr 2020 10:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1586713657;
        bh=ckLKZWP+33x7M1WB8sIgL17Z1/ZrpGsfEwQi+NvjjLM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iS/oC2CXSAbYd/kZxS3BCUGWwuDAMhm2SM3DxdPhqLRF2zrzhYDpTkDcTDy5rOULm
         HRtKNbHm/ePL+RmXbWyyhSfJyvQ4M1uqj3oixEXlKrkpbyZWOfiwod11rJ8QMgXf89
         6jjr2OtdpROj8efNwUgJwu46XqqSA704eZzLB+Ho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.213.12]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N8XPt-1jAIjw0ofx-014WP5; Sun, 12 Apr 2020 19:47:37 +0200
Date:   Sun, 12 Apr 2020 19:47:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Git Mailing List <git@vger.kernel.org>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/6] Revert "Revert "Merge branch
 'ra/rebase-i-more-options'""
In-Reply-To: <xmqqlfn7rnj2.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2004121944590.46@tvgsbejvaqbjf.bet>
References: <20200407141125.30872-1-phillip.wood123@gmail.com> <20200407141125.30872-2-phillip.wood123@gmail.com> <CABPp-BEnmpET=6rEdDXJWnPjzV33a2x6rKB6FQ-o8y+8ssK4jw@mail.gmail.com> <xmqqv9mbroqw.fsf@gitster.c.googlers.com>
 <xmqqlfn7rnj2.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PkyarZVbEWNejm7/qU9NVeq64ihfyE0Zd8kFFDSlBzL/J7miBUl
 jFe5CZjDBpwq9YuXg7CIkj7AkicYtQvM/HT3bNHbgrVwT7ei4+4S+RBGvuq3ubJKRIJ2/Mu
 KCU3fyKlG6QOTDep0HPdZCcOyItvHyuJpK17UJ/gDczoQFPIe6xI8bkAXWIHjTAbYYFDuPo
 FBi0gCU/I6kxcv/xz3OrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GwrLHxX8mjc=:XLBtxtWYs5utvwKSU5Unk8
 1rrXUu3UmYqJCgmxtnhMX5zWOzFaAPKdng51+Yt8BW9sCbtEklYgTQa4MLNfk4KLJuEKRTwfG
 Qk3ZjZhIWn0n97B7cm6aX8twjvE4YF0Hr6CFQFRhkZ0eROtQ0dqT2cl/BqM1J6x53U4EQVy5H
 1CiKcQwX7t0KUrU9UY9WrOv84Wn0CbOWW2RVm6z+H+cN/NZSabNntBGtrBl2i8PoiwcB/pQrP
 EIV8fRPhDDnriXPsS23FWpVc83qADDEOV7vE0Cx0t7jYLZHxhTiW9rKA0S9ng1MuwkEnsFgT8
 L0NYkvr0EWNoTNJh9HvrIzXv43cChj9r/QSdMTm/3mXoWTxd+RiwrnfciR55xiMj/hSHHIMdT
 rE2lRYS9tusapklp3OFjC/lcUK61QhoeT6D1L7+7yhVamcL1aw1FOXY5sqdPPQ+rfAh8WXN3B
 kZLO1kUGTgIaiSjRawyRpNQW6ayvDoJDCt2UrpBLscyISVIR8IpmP7ZLxxHrmA1seBwDWNDQu
 pwK85a08x/E3Q7X9lYvoXUTeCMqLwLjohjivr9cO4Gx+tVo+lSL03oTIXRENr6VKzjMAw2BEf
 lmR+lr1UvSbvlUSfPetRlRr90BHJWZpID2gPlZ4Y8abn01HDYf/drROl8dg4IDHPvkJApIMAK
 fkBf5r/KSCwHU45MG9VMxJmCXLRSqVcxyCwTO3O1q8J7cGN7fMk6V4KsQTGdAOF1SEP0HMlSF
 fbXqrtniC+oXeRCVQ1KEwW4SsuWsHGmkQVntdLdMfkkGIRq4G1Cu1n7L9RuSVEbzBH5Sxbl47
 xnEpXjmUnE//uz8L+Ccsn+HEjCvbeQzV6MtDXmdCy3DKj2zhxaRRZoAMPUR4CK15VPiQF69l5
 HvwPWdfoHqnBEMTNLqNnDeDGHMabJ7CnW009vMMU29sLw82tOjUws16REUle75NfklFlsj3Ge
 dTpt1fCICvoTqcgebRE20eGet64wBqCr3vR8fC1zCswCdT4oc2c9hNEPEGDwuY6IiRgRWV+Wq
 ysLyhzq+dngjSy/u3EpHwLftJM3yjkwEJErki+idxM925ecR1RkhsbfZZilMf+pb1F3rfBFg8
 jXcfbtxmLQK3FVvMVwFxBI7q6fuoMeg6OooZw0G6pBNfsJCvBOYsTwo7Ogcl5PhVtBP92y2Zm
 XKmuRalEKlKsZj1KmGPUqV3Doto5tFPjbLQlzGk5ge5/BLwB1R/UAlc+h1mfzFpm5FU9gLB2g
 sAyEdCma2JOlIhzJ6
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip, Elijah & Junio,

On Tue, 7 Apr 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Elijah Newren <newren@gmail.com> writes:
> >
> >> On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.co=
m> wrote:
> >>>
> >>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>>
> >>> This reverts commit 4d924528d8bfe947abfc54ee9bd3892ab509c8cd.
> >>>
> >>> This is being reverted to enable some fixups for
> >>> ra/rebase-i-more-options to be built on this commit.
> >>
> >> This makes sense to me, but it will be only the second 'Revert
> >> "Revert..."' commit in all of git.git and I'm curious if Junio will b=
e
> >> unhappy with it.
> >
> > Nah, there isn't much to become unhappy about.
> >
> > I however suspect that the alternative would certainly be much nicer
> > and easier to understand, which is to rebuild the 7-patch series
> > c58ae96fc4..d82dfa7f5b but bugs already fixed, instead of doing this
> > patch to take us back to a known buggy state and then fix the result
> > with 5 more patches.  Is that what you meant?
>
> After looking at the conflict resolution while merging the result of
> applying these patches on top of the older codebase, I would have to
> say that the approach """I've opted to add some cleanup commits on
> top of Rohit's work rather than reworking his patches.""" may not
> have been particularly a brilliant idea, not because the conflicts
> arising from an older codebase are unpleasant to resolve (they seem
> to be reasonably contained), but because it resurrects other
> unwanted cruft we have cleaned up since then, and worse yet, it does
> so without triggering conflicts.  For example, we'll end up seeing
> mentions of "'am' backend", which have all been updated to "'apply'
> backend", in the documentation, and patches [2-6/6] do not fix them.
>
> [5/6] is an example of one more "unwanted" thing the reversion
> resurrects that needed to be fixed, I guess?
>
> The result of applying all these patches and merging it to 'master'
> and/or 'pu' may be more or less right, as far as the new features
> added to the "rebase -i" by the series are concerned but there may
> be many small "unwanted cruft" we may be resurrecting with [1/6],
> so...

I agree that it would make for a much nicer read if the entire patch
series was simply rebased on top of v2.26.0, with drops instead of
reverts. I suspect that 4/6 will not even become a fixup, but that the
resulting patch is really more of an `Initial-patch-by: Rohit` material
with Phillip as the author on record.

As to the changes, I had a brief look over them, and I have nothing to add
to Elijah's review except to stress how excited I am about the increased
test coverage. From my perspective, this makes the patch series 10x
better.

Thanks,
Dscho
