Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B877C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B89613A7
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 09:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235721AbhHXJu2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 05:50:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:59709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235658AbhHXJu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 05:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629798568;
        bh=kHfhbrfvBCutZOlNu6nRUF6l/ZmFAUmUHe/Divel4gI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=P+FIOZWdd1Nu6EnLDscYkDJAHyUm5l5KL4v5zbUT4K8DK5hctmiB/MRNiyIEsqH9K
         65N6ST9e/JS0iouzpONYYzNf2hsbbnxVCwPtppSfu47v/I/5LaD7pcCM0Ga38pM2ea
         uBpskcHYKZow8ssqCx4LXmQNc0DWdtNZrlIT9HAQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.215] ([89.1.214.7]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTAFh-1mTAqG3pBH-00UckB; Tue, 24
 Aug 2021 11:49:28 +0200
Date:   Tue, 24 Aug 2021 11:49:25 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng_Danh?= 
        <congdanhqx@gmail.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] make: add INSTALL_STRIP variable
In-Reply-To: <6e0ef7f2-3dd0-09e4-5a1d-7e59b979d624@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2108241148560.55@tvgsbejvaqbjf.bet>
References: <20210820105052.30631-1-bagasdotme@gmail.com> <YR+Tp2AGeeKyRKoC@danh.dev> <xmqqwnogt20q.fsf@gitster.g> <YSBhPdK8jYIQUNhP@danh.dev> <xmqq5yvwrw8s.fsf@gitster.g> <6e0ef7f2-3dd0-09e4-5a1d-7e59b979d624@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:TCQrzMkavnsRI1V1QQN2ucm86kLKpr2mfYJtSN39p/QN91GAm6j
 73pQndan35s3F/LDH8VNTR77KtwmxuSlesxfstP20N95yVJ5b1bc6C7P9TKxwsDJwttFqPg
 AFEVgAWr41C4EPBhXZxS4OvlKMmb53x1iK2b/OCzCdAx9iD6as3Quva+KXTP33pCvAM3P00
 hcPxEtHtBCrSSkzIu559A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eq1JMNKL4/A=:iq28EEFVKJe4+5uO7oOqtT
 1v74D9It0gLpM1yjltUN98qnE2W/u0QXyokqtvBeAE+Uk4FtL32AkWXBTa8n4+oYxzeE9cIao
 SRiBUXFBHr9UoaLGcA/pDYhh6T46rfDE6mWjoJ5QHirde/RMhmDzowRO+/sIWCSAAeGoNxmq1
 iOlz6A3zLZVzssOU4fXEw4bkuamNCavpkjGmgxqcP+pN/7xSnxlpDEubXzth3DePmpAKNEkjH
 yvfNOfzUlwkSEkAcHNs2yo4euxYuC1QBS6tulqeBmljq9qZ+4X1UNZ2XuBaFLbw4Fd2/R9qi8
 8z+FHP7ifbqx+YOrYTeVhV1VWWsWjjAlOMH7hgcgmaFzWHqo4X8wLgp8WzZ3fLHeEmwHRoLt+
 rmynAAr4oyFrCe6qmAvJpHzm+981e4Wt+zKsQTaOkhYuRF4x3kFu3BXxQV1cBKfviMafIp6Md
 6B68ZFFdoeMaLRW8JbQ/YpmUguURLBgYPUmlR39VU8ax/xs4VJoBwa7/mUhuKEZEf6NR15fxk
 QdAHbl/iTSbAbL05E7tDH+if6yYoPbujfALVnoULxqcJV51M8wCcp3Cqn/dZdnd/0ytGZxwje
 3NxQp0U0EQBOPm+Mr27AH9cgMU7qXkxRI6I1NK6XLSfu5LKacSiIdXUsO8aMkY9qfpxwbvH0y
 Ji9ZbdWjW/jaP3RqntRIDgvntUFL+aSbzzEDFlMP9gw58DgasKmRt+DbnNOAsKYLEmY9KjcN6
 WF0aB3Rl+eoaazMDoRi61ey9NH8GhUybM5uYIMB4ZCAYe974YUOICUERWjjc07eps+jeR09Rc
 afbbhyhjv0KJDUzaBBq4ZKrIf1uhn5HqtnkDUDJZewPsuvXI2YBYXDtnVtsvNG9xf75YZoxbE
 JEDCGEoNlS2yCXP2ElqQFm7HU3HKUdgirbCddiStqm+0oNS8Tw4U/60GbxDlxZnR648n5zKXB
 dBmVoUlIxiwpioJvKOUrC3Mw5Z9/DW8UQg0pY9RMww19dMCGmm+wX/ojK1apmhUBGBnZkMFhV
 p6EvalMWtD+Led2L0MW3RWNyiZDp+/H+L5/VfXsgh1jHZlhjZeWkdJMK8ApQbJNyngKTHdis6
 II6w6lXVT9ZvvZJdxm66kCr2XbSh9TBtSADYHUY2i/2pD9YkU/nXcubmg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Bagas,

On Tue, 24 Aug 2021, Bagas Sanjaya wrote:

> On 23/08/21 22.55, Junio C Hamano wrote:
> > Perhaps.  One bad thing with the current "strip" arrangement is that
> > it is done in the built directory, and because "make install" would
> > blindly install whatever in the built directory, if you truly care
> > that you install unstripped binaries, you need to see if they are
> > stripped and rebuild them as needed, because "make strip" may or may
> > not have been done.  From that point of view, getting rid of the
> > current "make strip" and introducing either "make strip-installed"
> > ("we've installed things earlier---go strip them") or "make
> > install-stripped" ("we've built (or if we haven't please build them
> > first), now install them and strip them in the installed directory")
> > may make more sense.  And for that, any idea that came up in this
> > discussion that relies on the current "strip" target would not help.
>
> But often the installed directory (install prefix) is owned by root,
> so one has to `sudo make install-strip`, right?

The default for `make install` goes to `$HOME`. I would wager a bet that
that's the common case, too. It does not require `sudo`.

Ciao,
Dscho
