Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AE4C2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 11:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 653DF222C4
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 11:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Qk7gWmPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbgBNL7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 06:59:15 -0500
Received: from mout.gmx.net ([212.227.17.20]:38295 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727805AbgBNL7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 06:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581681548;
        bh=jS/AhRF2v5WlxTScbYRE3uZUtdXz3hZb9GOL0iR6GSw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Qk7gWmPSyEdBsf1FwB/VhKUK6NF8wzkKu16WPqAk4gbj7mJfG0jm6ervwtUcT0Enh
         6++iMx7qClRir1BPPn8Lji9dDJ4YJ9A8AgLF0J2SyO5UpV3idJuE2m4u6BPz9i6zQz
         J9yF0GYpWzp44UsquscilL9fusI+llrQiVTPvnW4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB ([89.204.155.13]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3UZG-1j21OQ0Wtm-000YmY; Fri, 14
 Feb 2020 12:59:08 +0100
Date:   Fri, 14 Feb 2020 12:59:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Hariom Verma via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 2/3] t5509: initialized `pushee` as bare repository
In-Reply-To: <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2002141252050.46@tvgsbejvaqbjf.bet>
References: <pull.535.git.1581620351.gitgitgadget@gmail.com>        <d156d04ca87f9fcffb1c08a08576dddcdc64c055.1581620351.git.gitgitgadget@gmail.com> <xmqqsgjeqm6w.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DWHX5TD/a9zagJfW/stU7qR+AubG62g20wfyoStPUwA9YUfz4iA
 IfoEa30ming0fKirKaHWpRDcqgD8wHRUBluuPQva4eWI3DhnH1Zp8MRyIDTIk7UrdbtP6St
 hlhH6D6xo2bO6SYp1PmJ93d89uvdqObejffLPRmg3B5A8wcvKE9IJJYTkifZofIOA7nyuC0
 BXdwphI+1KuqW4OAg2tcA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3M9Ld3Xe5iI=:xee8fBDIsyNMI4Yao+YoAW
 XhizZLpWYY+PMzsfC3Qo0zffmqz3XtbzDe33KLe8ZejmP59mTeMn+aTJIqak16oulX2eHt52H
 bZw097UscsysGjguPMnPEdLUha7hx/AXIMs+k8XjG+PJGWEou2LQbqpT75PL7X9PCY5duWfUK
 ekLrYVn01KVuP2d+Tb15z/XoNq5bYI57uFhl1YQZodueo7b5DrnxUm9xIXs0J4DraskiSye5w
 cfU5k5f+/FZA6aBqNQ3UML14OtEj3kWVuC0jvJcMOd3+UL/itFoKNxxNbL/HrKxYWC9x/4/jY
 Nu3hM4XUSy9W+WnsEMAYyc44L1NVLEbFtcr3utQV+kaEcrN90PeBVRoCcfSbVmqsKWsnT5/xj
 qu1kGYAiTKfUKem1bNrQMduzGAm+D1QshqnkUlPgiDJNu5ji8gjhtFt+CY498a+ptjIMYR6vt
 U2MOX4n1Kf4QHYFDeZvALr94zAr7uOXmUgwOCgYmOZ5oWMBUwrSwzALX6S1gnI254+4rvQxG2
 Pk2aeqx6aERNcC76/01i9ZBk6HjONT15nLElA81S4Q8dhcne9Uj/65Mh0rKJ5iuSEdVNY0aOD
 6feyth4r2DU8nnelNDn12/sLL+jcPSQDy6GSUfSqZbTf7PsykXIXkSft1lgdlVEWQ6reSkP0L
 qprBWNnl8gplKgSvNsIGG/Iq+AfgvhR+kWWzOzFqaonZRz9NyhpNhmqo07XP0/PDePwtzFfLT
 kh8tw7L0Krwi7AlgEZ5Ovu7j3TMlhp+XT44EoVW+jP0/0zLClhChtp0AO4+g02uGvIp9/QtC+
 RxvjB3Ff/7bV6vzGUXR//KXafeKuLWGfaNwmpWUqDqq5tC6nY+MorcrzYflYKu2ZjOITtEk0w
 0EN+MTmSByeaxksKglheLj3REoxOaQVGjTbCp+yDlPfwbqBaedtFDAPbsY/Lb6wZc29ZygMAL
 f79+wI7Q+wT6slJdXrpSEPqrIA9K2Li1FYqGnixfNUmI0Q0Kyndi9cEEo7xKOpPSyL0ChsYej
 L+UUP1EQYktssW8A51A8o8WOFzv4zXBtRzPr2CnP1mK6WcNraEausWDU/og81u11uwsLlhRe3
 Ha2K0wt1pU0tglVwOw4hl/a70bRqkASvb6HSm/WdJ0xflstVjeufYXajyhvZi9f3vCOrLbR48
 zLUpRvLjxTOFekmWB8ZYg9WTZfYG/M/37vFeZJdM578sIBI7sf3bp80LqQ2lXPLiDFV0FMK08
 kI5W0jltee+O87TAU
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Thu, 13 Feb 2020, Junio C Hamano wrote:

> "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Hariom Verma <hariom18599@gmail.com>
> >
> > `receive.denyCurrentBranch` currently has a bug where it allows pushin=
g
> > into the current branch of a non-bare repository as long as it does no=
t
> > have any commits.
>
> Can patch 3/3 be split into two,

I actually don't think so. The `refs_resolve_unsafe()` function simply
requires a tip commit, so it is the wrong function to call in this
context. And the fix for it is to use a more appropriate function, which
3/3 already does (although for an unrelated reason).

In other words, a fix for one bug would be a fix for the other, and
(probably) vice versa.

> so that the fix would protect an already populated branch that is
> checked out anywhere (not in the primary worktree--which is the bug you
> are fixing) from getting updated but still allow an unborn branch to be
> updated, and then have patch 4/3 that forbids an update to even an
> unborn branch "checked out" in any working tree?  This update to the
> test can then become part of patch 4/3.

I agree that this merits a regression test.

Thanks,
Dscho

>
> Thanks.
>
