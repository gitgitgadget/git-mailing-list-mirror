Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B804CC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6771564DE9
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbhA1QVJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:21:09 -0500
Received: from mout.gmx.net ([212.227.15.15]:60175 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232331AbhA1QUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:20:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611850760;
        bh=0ZpqCNxCMZib1WI4vdR2t8AoWmAz3OW336LVSsDY/AM=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DEatk0dUDACuWfkahXJLdxiJZHieewUJTjUDr31BOm2sPK1qaJrZ+mDttYjRThP/w
         5HP3Xg4dwy2FOY8sUhr/ROmZdwhqFfWIL5TYzqw4CaUMOn/C7jbi+dXC84C/7pv4IV
         TdNbALrsYWs+e7HFaIO4b/itaJOJrPXYDx5Msi/c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.213.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N63Ra-1m2LK34BGC-016PKe; Thu, 28
 Jan 2021 17:19:20 +0100
Date:   Thu, 28 Jan 2021 17:19:19 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Vojt=C4=9Bch_Knyttl?= <vojtech@knyt.tl>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v2] rebase -i: do leave commit message intact in fixup!
 chains
In-Reply-To: <20210112204939.1095-1-martin.agren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2101281714240.54@tvgsbejvaqbjf.bet>
References: <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com> <20210112204939.1095-1-martin.agren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-936565757-1611850761=:54"
X-Provags-ID: V03:K1:JuyQlrmWCyeT9MrIIaunzmFExXoAJ7mSuZctsqNYw62GYIq4v28
 g3UG11TjUqW6AgNyPhJvOcFvoORw8qbnWCP/g0MUArfyzojbce4hKgo5GbRdMECzgLl+fir
 m1U4XgTwDHgbMh64q/RCt/qCgdQhobn424Ft2gzs8V3ZCRBeDf81EsBvyZk+2Vs+QJct/JG
 BUDAArvyESKXAaooZ2W8w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eHXZ3nQCdbs=:69PzmlPbY0hOUYcqTPzdNj
 1G7tK6n8EmurXnzhbtjws8tkWotJZiJZVSroEkAbNVe/SqbDUMiQ8HyHOYpTH9fP09SsiFkBK
 XfDxg0/LENli9N/V8DwcQPwRIZPSGhl4VOUAoTWZLyKrLD63luk418yNzCzcTKvCFqbpyq3HK
 MEd4XgbAUGNpO/F+59kFMiBnGLb0Fre7tF8Jb4vxCGJDG7I2RCmxvSMIswE6HqdrjiYN0Yuor
 +eK7sL4kilVWi1Le00faJrc7ZNEJikVCoSVfsS/SRu1TYQgC3nPYyEtAjH3P6cMOZ8r2HiPoe
 Vi99QM/Vnfs9em9H9nYbBh9wYifWXiJgXJNOCZykM5KEsyyNqTYZHxDj5g/vQkBEmGaA5l3Lw
 zsJLXOMAtIO4+sXIKd5HNa7yFOBNPa/bNX39Fvywx8BNFmShDK6CZP4BzCk7viYsAi7aUxi05
 yHJrbCTwkQEsC0nhcgOmxvAua7BykcT2AH+qlPl0I59clFJhUDg4OITZOE6gxXrbLc+H6jX9a
 zc2TexInF5ySjaEiZanZL+uun2sqHzxgG7+PSq1uByaCmi6Fz0EB4jB0LaSGPFJ2eRHAT9Mfa
 R1gnyvsT5ou78Vx2F6mjAMKos/8tSHlI61jJTLj2eq+Gu6jT5pSJ+c59JIkP8XqyA+JOLB7Mc
 oVQRdzqjDQYdGCnlAPTLAc9zyhSV6CSA/+BPBI7JEDcTliQQLuaO1mBHxwfGBuJUph/uqmfvK
 3TdZMc+1ykcKacAGNlkovHgZLYhOktem+rlckVCIZ6MrLAqiu2BdJA1Roj9U0t0xmzw5rGTpH
 Wxg9wUIVkrWCB1LPt+hcaVI3FXL0MrbTwiaeuRklLj3x19EHnSoh4xz1LEzZnR1cv9kX8rvhm
 kNHSNeF8dmYCNIXOVLXJ+GpuJBRXJaIWhzXVNAaQo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-936565757-1611850761=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Tue, 12 Jan 2021, Martin =C3=85gren wrote:

> Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> >
> > We actually need to actively suppress that clean-up lest a configured
> > `commit.cleanup` may interfere with what we want to do: leave the comm=
it
> > message unchanged.
>
> > =C2=A0 =C2=A0 Changes since v1:>
> > =C2=A0 =C2=A0 =C2=A0* The fix now works even if commit.cleanup =3D com=
mit
>
> Indeed. FWIW, this patch looks good to me.
>
> There is the lone remaining user of `CLEANUP_MSG` where we're handling
> the skipping of the final fixup in a chain and which is part of a larger
> block of code to handle various cases like that around `git rebase
> --skip`. I wrote some tests on top of your patch to see what happens and
> try to understand what's going on. The tests are below.
>
> I can't say I grok all that's going on in the implementation. By the
> time we're finalizing the commit message, it seems to me that we've lost
> track of which of the lines that look like comments are indeed comment
> lines added by us and which actually originate in the commit messages
> we're trying to rebase and which just happen to begin with a comment
> character.

Indeed, we lost that information. For what it's worth, that's totally in
line with how `--amend` works:

	git commit --allow-empty -m '#hash'
	git commit --allow-empty --amend

This will interpret the `#hash` line as a comment.

And since that's the case with `git commit`, I would contend that this is
a different issue than the one I am trying to address in this patch
series, and therefore should not be handled here (not even adding the
`test_expect_failure` cases you generously provided).

Ciao,
Dscho

--8323328-936565757-1611850761=:54--
