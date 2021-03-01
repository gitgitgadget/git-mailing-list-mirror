Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B403DC433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9B9601FF
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240306AbhCAWO3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 17:14:29 -0500
Received: from mout.gmx.net ([212.227.17.22]:40751 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239883AbhCAWMQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614636625;
        bh=GWWALM/qddlw6cKJ9fScsb9m07RkrwOAB53rpI0dvDs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=QQ/vmkEPPsKVDNjlph33EEQNaoISX+W1L+CEGcRkQkknHoGLcRue5yINTY9JAt3TP
         CYWEG5fLGChhEpawW9qocrkHMzka99p4zaQsy+ajaPgzkNrJDmCtBFVsAPzIEVVcZv
         B4NsPvI5tP4bExUbtHH14myNW4l/lyzZrX3kaQXY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.162.2] ([89.1.214.35]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1m79uw3QIQ-00shlD; Mon, 01
 Mar 2021 23:10:24 +0100
Date:   Mon, 1 Mar 2021 23:10:23 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: warn about incompatibilities only when
 trying to write
In-Reply-To: <8735xgkvuo.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103012304580.57@tvgsbejvaqbjf.bet>
References: <pull.888.git.1614351036334.gitgitgadget@gmail.com> <87r1l27rae.fsf@evledraar.gmail.com> <xmqqy2faqwr0.fsf@gitster.g> <8735xgkvuo.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-5155215-1614636624=:57"
X-Provags-ID: V03:K1:HVI7QGs/VK61PQNNTVf+Qnc+C5XEtIrE0xtIu1quP4xNgV6WfYp
 IWC8yEkqukls0fog8OrEZL1M22Zes7TJ92jCPHBXs2Bqda/SQwQPF/59nA4Hib/0xoYGQLJ
 0R1A5vv5CLhJq2+Byev1IU5OuHQYqRmvlP0AzdZfUOPfveYGJR71dZNqa2Wl4hQFtme7MGW
 AIp/qPXQhPbTmtaGIIMLA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F1Q2WB/uFkc=:8pcYhqatN/w18Ug8Z8t0s5
 WecIYCQTP+HI3RkLKuBB05kmJ6swtEkhjrY9pZGEkb74KDdbNKfY5cTTWbmha1jQgH28lCm8u
 +umBbk0YdiZLJUeyQ7kSG88hMR5LLs54Bowc9SIuU++VILFyq4oNf6PxTKcPJk2FA5SyXpn4E
 0qE3KF9XtW9tmRwwlNHlYzIgmF2vIB0+CGG4rlqhqX++mn2B/cMID8Wht+VAZomjgCq7kTsy1
 JE150Y0vmwMI453ZYUADblpLukoPKfL8oFmbPiOUaLyLaIEj0wu1kE718Q2kqE5RThpwAzXBe
 kZfjhbGMIazU4ybMZYNqm/yFtJrF4bKM2U7dW+yyOywlAXqcq8FL2TC2FU8EjBsdRPgHUofTk
 5vVW3L4wVqEPYMsvXPmYZkIx5pjD8iGbVh8ve0dWtbXuqu6tD9GWleTZBaZWyRuxCi1MYUtvg
 9HQqPvSyVCrRzoQf4wHeAXCPQXfaMUmnNaXpwh6auEQK7BlUOzwtP8KqOPr7fQsmDYth28+dx
 ZpZ7S2N/CBLQOvB6/f7MkYyX0ZB51fYY/qgMez+18BgGIqQ4gTyzFR50VMYRCMNipmkp50PCh
 n+4yqq/9c3CfLmbd/Gk/hFWJzhn/w7RE+groLBF4ZiGkLke9hegNSoro/F2e2vZFBlRUOmWJc
 UsmnSSpQsQYxGkXKBxEDCFYJ1sCuXhOQ8DqexwWw2m1JRaPk52CM2T5L2ujo9N6hrT0RfN6Jd
 xKhHQHz6we42J3Gr8e9okyBnQQXAhyTgtFmcPYok36jIImlbH7VyKQtFz0byDKrdo+0Gqddpr
 HB5SCYCEF5tbwX2ZlGJRbkk9gMh2vwzb4kPeZaswJyvsPcC7tw2YpR+LlX+WubKckcXvAoBWA
 vZ4IMAw6QLPCfcb+aOVaLyVmOB5EWhudrFjICP6Zs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-5155215-1614636624=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, 28 Feb 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Feb 26 2021, Junio C Hamano wrote:
>
> > I am tempted to say that we should revert c85eec7f (commit-graph:
> > when incompatible with graphs, indicate why, 2021-02-11) for the
> > upcoming release.  That would give us enough time to come up with
> > and cook the solution in 'next' in the meantime.
>
> That's probably sensible.

I agree. This close to v2.31.0, I do not want to rush things.

> Also, I noticed that we went through this whole saga in the past, see
> 25575015ca (repack: silence warnings when auto-enabled bitmaps cannot be
> built, 2019-07-31), including breaking background gc.

Sounds like it.

Thank you for your valuable feedback!

Ciao,
Dscho

--8323328-5155215-1614636624=:57--
