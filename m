Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B6291F454
	for <e@80x24.org>; Fri,  8 Nov 2019 14:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKHOKI (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 09:10:08 -0500
Received: from mout.gmx.net ([212.227.17.20]:36003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726373AbfKHOKI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 09:10:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573222197;
        bh=MVOZvgf+E3BK45xk1DVmc/hDhnjvs5ujBWJOqqikNgA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Un8YDyCkUHGSeX5OLUbjuNdQKA5PZttYbvqyfyANlm602ouAOMf85hp03GQYn4W6h
         w+0m72EuXVXr9aqjIqD3jXGGmmoKAc2BpzIRoLtBswnhHjVn6F0DORRdecrsP0MbY2
         Uw77u1acFI3TcHp40TFqQ2Fp1IRrScM5tUE1JK70=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYLQ-1i0btd0V4a-00g3CJ; Fri, 08
 Nov 2019 15:09:57 +0100
Date:   Fri, 8 Nov 2019 15:09:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 3/3] commit: give correct advice for empty commit during
 a rebase
In-Reply-To: <xmqqwocblywf.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1911081508560.46@tvgsbejvaqbjf.bet>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com> <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com> <9d550cd9-08a2-eee5-7d7f-63678285accc@gmail.com> <nycvar.QRO.7.76.6.1910251341550.46@tvgsbejvaqbjf.bet>
 <df0e77e9-b764-690e-c814-5d90fb141def@gmail.com> <xmqqwocblywf.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aVTwgUjcrZyaevAuljSLkoKdWlMXmk0c5wkd0Az6M0x78oXtWWX
 gbE3qBnWxaI5kyKaXfq48BmQArLzZgVSmCFR0Uwv02fCAFmkgxrxbQ0BMyu37InIeZvFyji
 Ow6ZEvtcM3XV+RR1ZxheuECUtrOgi8oXDIJEULAcUCmN8CTEjh5fc6azzPJbES+9wFI2DbK
 Gv3faZwcYAIiOXhC8cPIw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T0VRta4MEP0=:41AaSCmBpKbCs91QGIqr0F
 hqqk2CsVVQQNnqHboaXRHYjmH/+4nE8l31qWUuO52A141usDNDFF824WmDL0Bey6aX/aPG7b8
 dblpEZeKZnFywwefZykac5BvrZZB12uwsndILLJHNhVaTN3QeMv9RgHSaReV1SnP1GS8pwB6o
 qN20uB0ezGRlt+T2cDqJSrgkTckP+qykRruN5GAQfvi/D9esa25iYQNzk/WFARvKYHnanehyU
 OSTlycKpawPJmCJ9jiVth8RAWjJE5enSRHLqmxEr6R9ElLYIKmcEY5JNtIu9/6h+mwI18aXa9
 jadB2pYFPgT8jr+w20RINvnsdIiGaKUyYAD6NpJ8Ep+PG4dikglYYn16HqEGd+RZ84FM6lI4l
 6e7OjHXhW9KTlpdWCh6wAW4CLMjilArXqJCvacOYEOw/yIyGK/zXqNwaqGKZzwazuF6Z7RHwY
 3cUdWa+RrjIxVb8sQQEx78qEY9xuQYPWz0ktlaP9HRfrkMjsQ7ENEN32tF81BSAdOMlNXK6KH
 v3wbJdo6d+YqCNVF8kz/vBAZHmNjDrcZ3RhtRLAJcwXc4523Z6yB9XlN4fvlVeCAi8zaTgU2Y
 2Ws4l79wDN/fsU4q5jmnX45jfbGrdxuQ5haAzd2uWHP2D3unB0VJFdlKM8eqxkWOW36Cj9dzy
 razM1ltvNBv3CS+czL8dXj3xCGq2MHY8KNh2pluteUnGdS4mlViQbb+LBJ3+/kspM3xT9+4mT
 fkn82lKyf3WnO5PjDVJfmmm5cj/gjdJMQ2lsgUkWBXeJD+yb2HuxmApkTAIkfQYAUb/XIcnUT
 eJHW6tcgxKIOhh/aise58/zuFnxs9aVll/Hfc04gk2ZFGdOFsQG4qzcXbEWDgE9RVyz/eO56O
 Ry3ldDR5n7DQWOWtrETQm/hVzqlOYyYgJ64SOC2Ml2qfZty1hiaXG1jdrITv17fRywcl/W3Eq
 5P8sniEhPUTcIeCIyKO9fajKjOFBTeEEItO0j4eJdrSMiUpXOmodANVehOoWPSrVqkkSkFUZV
 CDFwR1trgMFmlReH1j7MNYYiZ7ajfsYnwhhT8jVKVCdgvmeoB+Y/LE8xnZRMV+BaFf9Qo7OKh
 zotLheuy5CedzWNSCDJtBpMYkzGWMx+lEmxv0cGEHBcKW8JJbfn1fThaOkveumj9PyLmHn0Pa
 wECSWgt6wYVhND6nb1VcZCCI36adYcWJBnByHh9k0boLz6Kx76hk3KZmyvmyJWvup2SY3/N3v
 TiamsY/a0Lf/yKX2uQ3802X5iWOIYs4wXp24seWfB8itc9w62crgrpXlnRgY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 8 Nov 2019, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> >>> I don't this patch can distinguish between an empty cherry-pick
> >>> performed by the user while a rebase is in progress and an empty pic=
k
> >>> performed by rebase as both create CHERRY_PICK_HEAD while
> >>> .git/rebase-merge exists. It seems to assume that CHERRY_PICK_HEAD w=
as
> >>> created by rebase and prints advise based on that which may or may n=
ot
> >>> be the correct. I think we could distinguish the two by checking if
> >>> CHERRY_PICK_HEAD matches .git/rebase-merge/stopped-sha or REBASE_HEA=
D.
> >>
> >> I guess we could, but then, I would rather worry about that in the ne=
xt
> >> cycle. In this cycle, I would rather fix the common case, which is th=
at
> >> a `git rebase -i` fails and tells me to `git cherry-pick --skip` inst=
ead
> >> of `git rebase --skip`.
> >>
> >> And even if I performed a `git cherry-pick` during a `git rebase` and
> >> the result would be an empty commit, I'd rather be told to `git rebas=
e
> >> --skip` to continue...
> >>
> >> But if you feel strongly that this should be fixed differently, I'll
> >> gladly leave it to you ;-)
> >
> > I'm happy to wait until the next cycle once we've decided what to do
> > about CHERRY_PICK_HEAD during rebases.
>
> So, is that agreed between the two?
>
> Should I eject js/advise-rebase-skip topic out of my tree and wait
> for the decision wrt CHERRY_PICK_HEAD?

Phillip, if you have some time to spend on that, I'd be very grateful, I
am a bit under the weather and in dear need for an offline weekend.

Thanks,
Dscho
