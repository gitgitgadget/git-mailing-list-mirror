Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688BCC433DB
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34A6364F4D
	for <git@archiver.kernel.org>; Fri, 19 Mar 2021 14:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCSOU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Mar 2021 10:20:58 -0400
Received: from mout.gmx.net ([212.227.15.18]:56081 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230050AbhCSOUd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Mar 2021 10:20:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616163629;
        bh=6RyNg+Wm96b8pWD7Ok8zKpRGJ2k6E3Igw5ZlVvd8CIA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ilZqJFdkWttBko3K2/WMAYrT9DKnYj2hJVdl2Cc6OnOs/bp8M42V9FK3DfD2Gr5X0
         B3DVP9MVPx4wvMHJ3D+7gcyKAjtxw0XoeUfRoppnGdJ+TFe86RE+gS9dtrv5n9VmMs
         WC88vay8YAdt9TPxW70Szh478YhSMLsTCYjNSaho=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.24.97] ([213.196.212.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hvR-1lnHLe1kDH-011mp2; Fri, 19
 Mar 2021 15:20:29 +0100
Date:   Fri, 19 Mar 2021 15:20:25 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
In-Reply-To: <87zgzbgp1i.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103191515430.57@tvgsbejvaqbjf.bet>
References: <pull.31.v5.git.gitgitgadget@gmail.com> <pull.31.v6.git.gitgitgadget@gmail.com> <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com> <87zgzbgp1i.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-464419750-1616163626=:57"
X-Provags-ID: V03:K1:3FjPC4gNuX9LHvl9iP9EGrAStz73E5TWjsOrW1g1U0Auc7Jbb7C
 8+iFqEnBjOM84jqnSTqvP8QHrJS06QDhr166ZXTotK81H7JV3U1n71mpuEKsCPyLjgY2hLN
 D+l4OXkBt0ZiDBGGvyUvxFxAgCYJoHtgTiEFCoIHr2HCvOKnnwbA2Z8cUdlCH/k/L0hbeKO
 SxwbEEA9YwdvkxDkz0VXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PjjsmoPiYNo=:1+nrLy0PY+CTbjSflwTQ0j
 aq+T2LaLTyNxHvptXZWzge9YYc6Rc8MOJbrC3t+e8Gmu1gO5b/Q3u7+8HHhUWxmyFn+HY4hQl
 7f7+JZDs5RWG6mxF8tipRZIKWu32gotAGMCpuAzbqXcdR1WbNxQI3ZokyvDlBL9mQ+RNwGKXp
 S9zd/QxTOpNhxek1bSMzoc3vEj7uDJGhTq2kDbiazIcwt/gFUbfrew1cAgN+NBvkRD3BHfGEv
 WRuVykOvwn8zaedbLYGZpKt4V6QaJl7GVHojuJDApe/Fepnz+5lLZtaX6qL6q8nCKn8t+CNwL
 pnR48BvhajPuaRoDU8EdkEZnVIefnEHKbkeofa/xeJgZRWgGsWhCxpAYpH1Vw42y9HxpGUN1J
 LkLe07m60zYSj1VjwSknOSxUxZZRRAGCaPaW+/LzvcsRwts+ugG+Y4k2S+fFYu0Wyeh8MXJae
 zrG5JXjxM0nZ6rZT54/QSc4LtGHOWPaaH5J1+e10z5UQmxBeneoFkgtR35OdgnrzUcXwFaW4A
 hpE3LCZjk3mHcqSXUruPDkE6ApwIQSDzD1Wg5zk03pjLpptgGZrEmiOuUXSYf0fmMLzdWJwiX
 F5M4jMNS54M9Ga3+Z64R34l4+22rcEBd/MvOOkSx64tl7vyUXDB3a0BhQ+JnEfR1XFlcpNUQz
 eAOSHwg5FVdZTdYJlya8aLwDhmpdj3MykkzylbHImDnef7lERghhvLpAMHjHYpLL7oBJtfV4y
 KaGGqXlccWQ++7LnxtEiMxyOuRLdcadeqJCgFu59tGlWMqR2qp9yX5N7q4VTYfBGDlDS5sWXT
 Lx2eZLURdhTZZKyrcEgAkPXf3OIyrAi3Ja49i5VwvxeXbSNfd5oVwYz6ESVRzj1r+hfkt36eQ
 9fzTU2uRwWenaJnEJCbj4sZ3EoeoX3RHyuZ4OkcKCKv1t/1Vu75/W547er47pU0nxph2Yy7jg
 noKF9Y75398LWAq/lRGqxJy4DAOMOF4ef2qvm3uy/rfihAJqFge4n1jWvbbT/pjEN06I5B4fg
 jxUsC02fA6/0vTkIe9AqqvlNI7bo0WpnyTkCC990HaZFYt2atzcycF+D+4DRcJyDqdNeL3hsj
 KmSwqGNb2DVSg2LFC1yc462Fev9nqAumPQa74Ze/m/MfwLNPBGCSRP/0MDgvkn1cNiAnu+rCZ
 4Mci/J5rGCENsCKB1RhMxmS6gBnIrjaED55miixVWg8EPs5kX3empKEg/zN9rJNNjtdPUT4tg
 YEnCbqwbmUYejDF9M
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-464419750-1616163626=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

thanks for digging out this old thread, I really could have done never
thinking about it again!

On Wed, 10 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Tue, Jan 29 2019, Johannes Schindelin via GitGitGadget wrote:
>
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > It seems that every once in a while in the Git for Windows SDK, there
> > are some transient file locking issues preventing the test clean up to
> > delete the trash directory. Let's be gentle and try again five seconds
> > later, and only error out if it still fails the second time.
> >
> > This change helps Windows, and does not hurt any other platform
> > (normally, it is highly unlikely that said deletion fails, and if it
> > does, normally it will fail again even 5 seconds later).
> >
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >  t/test-lib.sh | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index f31a1c8f79..9c0ca5effb 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -1104,7 +1104,11 @@ test_done () {
> >  			error "Tests passed but trash directory already removed before tes=
t cleanup; aborting"
> >
> >  			cd "$TRASH_DIRECTORY/.." &&
> > -			rm -fr "$TRASH_DIRECTORY" ||
> > +			rm -fr "$TRASH_DIRECTORY" || {
> > +				# try again in a bit
> > +				sleep 5;
> > +				rm -fr "$TRASH_DIRECTORY"
> > +			} ||
> >  			error "Tests passed but test cleanup failed; aborting"
> >  		fi
> >  		test_at_end_hook_
>
> I saw this sleep while reading some test-lib.sh code, doesn't this break
> df4c0d1a79 (test-lib: abort when can't remove trash directory,
> 2017-04-20) for non-Windows platforms?

It does not really break it, it just delays the inevitable failure.

> Your CL for v3 suggests this was only encountered in Azure VMs:
> https://lore.kernel.org/git/pull.31.v3.git.gitgitgadget@gmail.com/

If by "CL" you refer to the cover letter, then I might have made it sound
as if it was only encountered in the Azure Pipelines agents. I vaguely
seem to remember seeing something like this quite often on my personal
machine, too, though. Most likely Microsoft Defender going a little wild.

> Aside from this obscure issue, wouldn't it make more sense to have some
> optional "I'm under CI" flag to skip the teardown one test at a time as
> we're probably about to shut off the transitory VM soon?

No, I'm not under CI, and I did encounter these issues. And they abruptly
stopped with the patch you apparently still want to discuss ;-)

> I skip some tests, but the test suite creates ~950MB of trash for
> me. Maybe cheaper for some to just keep that around and have it all
> removed at the end.

I don't understand this statement. Or was there a question in it that
you'd like me to answer?

Ciao,
Johannes

--8323328-464419750-1616163626=:57--
