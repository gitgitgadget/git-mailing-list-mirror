Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C1C10F27
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 11:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25E8E24655
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 11:42:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="aZ/mQewv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCJLm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:42:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:46215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgCJLm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 07:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1583840539;
        bh=Sb1JDA9HAtEkZFqKTeY0yerRjYfqRabX+/DH6UEZ4W0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=aZ/mQewvSMuN06bKGoWNvjG1C5DoywkheMHoJBO9nxm90Xn1dMVuMZWBmUIzSrTNa
         g65pfFZIOTrpgDq4xIPGYnDzjlZjm3BUO2LTSh4oIShDykqfIuPQtZUzDWrb/gIrG9
         Y3gpXgjPnP3/z+AAzYMtylaDx7D2IyjtLoHIDIcg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from MININT-QA14EDB.fritz.box ([89.1.212.209]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M26r3-1jDY153LS5-002UKj; Tue, 10 Mar 2020 12:42:18 +0100
Date:   Tue, 10 Mar 2020 12:42:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: [PATCH v9 2/5] bugreport: add tool to generate debugging info
In-Reply-To: <xmqq36ah1fao.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2003101239000.46@tvgsbejvaqbjf.bet>
References: <20200302230400.107428-1-emilyshaffer@google.com> <20200302230400.107428-3-emilyshaffer@google.com> <nycvar.QRO.7.76.6.2003042232340.46@tvgsbejvaqbjf.bet> <5aae34d7-ed76-0e71-d0c4-959deeb1b2ca@jeffhostetler.com> <xmqqr1y52w5y.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.2003082319260.46@tvgsbejvaqbjf.bet> <xmqqr1y11sn7.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.2003092013090.46@tvgsbejvaqbjf.bet> <xmqq36ah1fao.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VDx+y+Ezx8vq+C0ahpa9Zb1UX52/xfz/G5ppP4pScUhrW9A7Mz2
 0gWX8LsIaLwAvdGigFVzD3Ecd8bMVa8gtRnjC4e65dLZjrd46saESkv6CgUOQbm9z9K4B8B
 slmEt/v+7e/5Ea63pGxBLqTq/g+8hIg8Huv7UhuPAhCCH7IIEUNsrt4dAfTXuFki8TYOssn
 TkQI1pAV+G6nhlpMFvgVQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UpS7Vg8U1iY=:coBBRT6YIVLP5iFOzKapm3
 lXkdJTRQ6GqLIMB3qhrEg5QFHaStAfY/gYcQqTVxrA31E0wdp53GtZt7RFA60QrimOPMnZNDG
 OjoZUwadDfDfGVXGPQmCWynLJ0te5TKsTQewP4YsEq/M+CxOhgpNVX0xwctayPZespUPP6YyZ
 2Zih6s8oZbOXefsl7a4Ki8pnQCMI60NzpboTYV0oX/AXesLf+OBCH8m0oVg5OBwsYb318BlMq
 SoT64JQqg6o0wvQwN+NWTlKX9gqxVpfrLrdpGtQgBSP9jIXlwhjpvf3iY6PnueTP5DSVK2i8z
 l/3zaab0s4dBBCIusq5EieYivYZ/Dr4Nh9npZZrFL2HsNtXP/wgwiwxT1kGUfgx/xd8gGTQlg
 mYmpd0JcW671ZhsaFTXMKBp5oT/0qib+qsaSGhEO1MOem0W8oeBwxYqmeceFnA+tOnF6y/kKz
 Mi+IG7pP+NpBrIs8XR1MH4XwnIiO1/vF8JDv699YLJlgn6lP/jpoCxI+FZhGYb3gYRNG5HJYj
 z/nmIhD4PErBIDtWPeRZCamqXgz/qpZHTfLHlWo1SqVXvEvqcosS/ZfCYksB7tr3YXdH/MRWN
 2Rh2Ida7W7ehQWz7D9o8aLLpYV8LDn3MbTLJpaigdByhlwGi5PJjUzorNDQmCD6jrD9HdfuX4
 m51Lg0kqmJ9sBAItNcljuKKHmJ98ZE+iBbkTLVRa7TZLCrai6SFanjWMNQO/S991ydNHrE32k
 8mgNZFFpcMRM1Xb4oVLer3jo7n+sFhymXgH+0s18V4Vkf2rPyKUOx2Pen7o0zuoUOFCvptVCd
 Xqu3CFc2ZATs4dcAiLl3qhIVw/s4qBmGg1dLxGPaZTKzUDmRYxYEFDyWLhhoqe3dCKOgqATmy
 HMClurkz3R2iL8xSB3ferquu1CjU8DCjl6pM8tW68B8SZYMcxfT8nnOVCMCwJRoR8uUds+My/
 CNPWtYDL4e0PrPqdySa3eE0i1js2aXzhGC2j108UEALqorZaPiSq1uZBoFinW6+5JJu9ooMS8
 utNI0x+ZeMrAkiU051+YqGY/fK6eJatW0weDOgLKNFaaZZIB1Ved61ovwW/QMeQu65fu7qmWB
 4Wnu5zEYNoid77edSr+sl5K+auR3AFQAvHSTMoluyJ2nw5Ss+DRk2qJrunXRZg0yQBmATDVgG
 O6v2c7US0WqAITyHDKmG+vDzbDPHLbOn4cG6LEzDyfgTMu353aINiibOulbGJzEC+G4hhrZF6
 RnZpZL7CIv21u18Ky
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 9 Mar 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On the other hand, if we make `git-bugreport` a built-in, I cannot see=
 any
> > downsides.
> >
> > For me, therefore, having it as a built-in is a clear win. What am I
> > missing?
>
> The right sense of relative importance between efficiently running
> the rest of Git by not bloting the main binary and making sure not
> to ship Git that does not run unless "git bugreport" runs (which
> makes sure that "bugreport" runs) is what you are missing, I
> suspect.

By that reasoning, `git bugreport` should not be included in core Git.

> Another thing is that you are giving "git bugreport" too much weight
> and too little credit to inexperienced users, by assuming that we
> will never hear from them when "bugreport" is incapable to run for
> them.  They will report, with or without "git bugreport", and the
> more important thing you seem to be missing is that after the
> initial contact it would become an interactive process---there is
> no reason to prioritize to ensure that the initial contact has
> everything that is needed to diagnose any issue without further
> interaction.  "With my build, even 'bugreport' dumps core." is
> perfectly good place to start.
>
> Besides, wouldn't the ones on platforms, on which "git bugreport"
> may have trouble running, i.e. the ones on minority and exotic
> platforms, tend to be self sufficient and capable (both diagnosing
> the issue for themselves, and reaching out to us as appropriate)
> ones in practice (e.g. I have NonStop folks in mind)?

Yes, I can agree that inexperienced users will not give up and keep
up the conversation until they see their problems fixed.

I can also agree that inexperienced users will report bugs even if it is
not made super easy for them to do so.

I can agree to that _iff_ I ignore my entire experience maintaining Git
for Windows, that is.

Sarcasm aside, I think that you underestimate the importance of a good bug
reporting tool like `git bugreport`, and I suspect that Emily does not.

Ciao,
Dscho
