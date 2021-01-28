Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEDDC4332B
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA1A64E09
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhA1Q0a (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 11:26:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:38421 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232557AbhA1Q0L (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 11:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611851071;
        bh=YBmSxSTTHNQWf1gxQuo/rqfdEctlDNfD9p5HTvolpOI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HbqY/1M8e896qSW3Tx4U9ZEEPotzvht0EZQST6705u0I3WatvCUWPjbG41XZb0imV
         pffM7jM0r7C/HTI+hDPL0y0X2E8sQthViegmWHJURn6tV4BhIJ7r4yfK19kUsDpRVl
         RAlW85sVD2DZ03EAv2M+K0u3+vu8ftxA2SMXmW0Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.213.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQvCv-1lJ8Ce36kp-00O2Gu; Thu, 28
 Jan 2021 17:24:31 +0100
Date:   Thu, 28 Jan 2021 17:24:31 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Vojt=C4=9Bch_Knyttl?= <vojtech@knyt.tl>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2] rebase -i: do leave commit message intact in fixup!
 chains
In-Reply-To: <xmqqwnwhzr54.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101281724130.54@tvgsbejvaqbjf.bet>
References: <pull.818.git.1608337339246.gitgitgadget@gmail.com> <pull.818.v2.git.1610123298764.gitgitgadget@gmail.com> <xmqqwnwhzr54.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-740283518-1611851072=:54"
X-Provags-ID: V03:K1:FyPW3T04EXgeDcpzvYUJxsL9/sOB92nqnnvkAMUNxveiyifJvq2
 BGtt9eGXrjhP8nH1UjRSu8s02jMIp9aGeKu+NO6WwbKjVfFXkmAx6g1jHyw9ufoAW2V012u
 zZP13yg2s5jRzT0EMhRO5rkvvJJUzh1NQeMTL9wbT1AS50MqoHBZI6Mc4k9lqBu2K3Olu2O
 8LyhmuKWfhNaCbRVnzkjA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pVwJHReqbSc=:ENRF1f+WoBYKLf12Yyv19i
 5oiz6HOmAWYxfIHeZTbm35XjVH8vSktGbPf9q6bhLlp9NXkxAKE1m4+7rRzAE1GD4k22BqkAB
 ACVmo8/URoQw7CSLixI/lgW6CotdU55PO/y25/T7QmuBV9ByA2NxrbaeTmVwpWjujxu7CvtnK
 GrRfIw0ruz7m+vwoGLO8a2Vua4uQ11TJn8xtjm0Rz0yzUL7rsgrVfqrBSXO5OD0SbQ3pSFdUN
 mbqvjt0EUotLCVKI4S6kksomYI8NMcKX7SJzuQ0LX2appt847IhpqeBTZBxtNK8o9kZU4Ufa1
 6oOZbaXh1hzN6PuBzrT1HFBUk7i/6/rRmV13olD2ti5vHU6CeC5chxafqVxI+v59x8Zu0afJe
 ilcqnEAOK/Q5VNjKGoV5I2TzPx/R26L1dTxrtliuenjVkXs7DU7oHNJVQDOje8rtzQXnXGdlp
 q8UYfPCUrD1/HZA8jtVt7ij6IZKW29HHSDVDylycnPzLjDUeCmt5uJwhO9VLONOeEJKWsVBxa
 IeOS3VDmC32uKHXSyUGA/dWQelWNDEx7mQfiirbLn3zLgFAkd4TCdhoY5vGDywRA4djajL6lg
 Gh8DtuqoO2+u5H8tc66Z+xGjrU4nNSrk5uuvp7wrHgSnwZncb24TmXsaebUV8ZhuGC+VMrY+g
 EN6O58EgqDwjd7OQw8BeFOncqcQoZ8yNBs9R4dvnbtgyQT6WFvhHJFCIi0dWtQrVOlvOrXhH/
 Uc8cJh+45y917j6uyOtZnyon1jhdef1xhjQMoPs8iNhj+JISrvyEAK/s+YB+TwCI8wg+lvr7Z
 S6ANHLs2AI34VcCoSpqzWZEx6kbJggWI/AEz1V4lJ+isqboTVXDASAMJWxm+axtkFs9jFrZsM
 2ym1paSzbZ38ScW2hEafNvR0WKhs+CKsLOBXVDK2A=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-740283518-1611851072=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 12 Jan 2021, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > We actually need to actively suppress that clean-up lest a configured
> > `commit.cleanup` may interfere with what we want to do: leave the comm=
it
> > message unchanged.
>
> Good thinking.
>
> > Reported-by: Vojt=C4=9Bch Knyttl <vojtech@knyt.tl>
> > Helped-by: Martin =C3=85gren <martin.agren@gmail.com>
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > ...
> > diff --git a/sequencer.c b/sequencer.c
> > index 8909a467700..092e7b811f0 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -943,6 +943,7 @@ N_("you have staged changes in your working tree\n=
"
> >  #define CLEANUP_MSG (1<<3)
> >  #define VERIFY_MSG  (1<<4)
> >  #define CREATE_ROOT_COMMIT (1<<5)
> > +#define VERBATIM_MSG (1<<6)
>
> It somewhat bothers me that these pretend to be orthogonal options
> that can be mixed and matched, but CLEANUP and VERBATIM do not make
> sense to be used at the same time.  As long as we have some safety
> to ensure that both bits are not used at the same time, i.e.e.g.
>
> 	if ((flags & (CLEANUP_MSG|VERBATIM_MSG)) =3D=3D (CLEANUP_MSG|VERBATIM_M=
SG))
> 		BUG("cleanup and verbatim asked at the same time");
>
> it would be OK, though.

I did something similar in spirit in the latest iteration.

Thanks,
Dscho

--8323328-740283518-1611851072=:54--
