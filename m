Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8877C433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 09:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F37E20708
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 09:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="RGrjfXSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgGIJU2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Jul 2020 05:20:28 -0400
Received: from mout.gmx.net ([212.227.17.22]:58943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726247AbgGIJU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Jul 2020 05:20:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1594286423;
        bh=NazHz1BwM/EnU9Jryp+mKgVkGCs6d2mq4JLnNxsn6Ks=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=RGrjfXSz644Se3YJV4dhlj+MRx42HYeQQ2L8ah5yTK+o8tcdQ63SvXTFlFYefubjR
         z8LRFrJdBk02SvtNYLNqgr57DOpRZH3Of8ZUqm0mwDa70uOT+HC26kN8VCsapvX7p3
         nUFfSh8iu0+SgnDvHn70gGU5EIZayMa++nCl4DMM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.26.78] ([89.1.215.3]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7b6b-1jzGY61vob-007zUW; Thu, 09
 Jul 2020 11:20:23 +0200
Date:   Thu, 9 Jul 2020 11:20:23 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Miriam Rubio <mirucam@gmail.com>
Subject: Re: mr/bisect-in-c-2, was Re: What's cooking in git.git (Jul 2020,
 #01; Mon, 6)
In-Reply-To: <xmqqy2ntzjoi.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2007091119020.50@tvgsbejvaqbjf.bet>
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com> <nycvar.QRO.7.76.6.2007081630180.50@tvgsbejvaqbjf.bet> <xmqq36622eru.fsf@gitster.c.googlers.com> <xmqqy2ntzjoi.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UhOAvo13CjrUcnHdAumcUMor0c1ctSyyscr/Q9PvTZcPm2AuIhM
 zC1IECSomCevJGslgOrifrUMp5zgUm9fGnOXswbIEWFn1u5SoqMbz0XawCo8UOhaiq69nhg
 XO9+WRSUybEAmJhAcxpibpqsCAusFQfVcHpRv0RczA3gSqfvsCmkYmS9hfgqQa4DiT57FWK
 0/3Z6CWy9lB8yUo2u/EkA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aOIf1r6Nabo=:P20hAwQ6U74Lui67zGCemv
 uSxeu7NDvco0ulLUrZXc/LrVe5bLfh6cDoYg6Uzq5/YespRufA5tiCejIoGBP/Uul+SJ0nvMU
 /3PhMzm+qZh3OkeeZ0fR21lLj1GdCgIYQRObNJkZ5DJWK3zdfKCr4pbfD0dQswwl+zx97NmEy
 ulDu9dQt1d4I6kINf5D0ELUr8ZK+b0k0E6ZJq1XZCxx0pQ9EeLiWwmXvM23WuGupTodxpjOdc
 9XdTyH1ZZnv5vQWSWIBGYCjg18ecHCwWZXiJ7GzI7xZcDN7Ik4kZNUJsTCYjaErxLXqMRGGme
 vGOuuclsASOYpxeWPjibxoIFryAyn6hdBHMkgwtv3dNNLKDepIRvnMp7NfnV9Lxnr6tt9ew5h
 meH5XtAJe76k/GkRG1od06905EN42MPJPGr8hs8MHcz0VJ78etoq/aplPvAYz9V7z7WVgPg0e
 x1zsq9DiXv3JVF+2wPblUfquoQadHZ3aJdlCF4WXaqMA4PHyIXLG3Ci/HeFBTkxzBQuYN/jRj
 Dj1SSUMCXGdT0OQHS70Wy3abYr1Q3yyn3gRjkE2VSffnx1TqU+GW5/6XZnd9qcOngcF/QSHg4
 rsXzGpKWedexMLSRFx6fJRy/QADdzfPgrA6gjXJRqRFHWbC6MfcUABZHjeixT0JqqfNO/xHV0
 M1SBPx5RE4DOr3rRow7YADuhpU+foiiF9LcoOTi/DQtX8DwjaNgYDUkmI7A4cVMTzAX2OTa3J
 87usoHCTJ/Py3JQBz4SGg6jrqnSP2YsHO/idFH2MTgzR+QyZ3PCLPJAqrFMWVMTCp0FeDxTIK
 DTr/cHb5aE22fJrdnzVc7usa5PTmJLuDQ3+9cUxgHW3A5VXenzqJNUmsKNZuK7+bdXNw7vLag
 xzSUEX3nU6lxOYkbEAXGH56lsW3dXcQ1D+FQs+OUbAAt+FIZmH2r6tc0GwzF8XyJef9nzl4NU
 7vxcfEaCa4nFRFJjjvYZ66XTgNlTq5v7rNw6PHn9aUECbYdkTYJT5S2p+W7m7o/cdeOzatdzv
 kZHLBr2ivrsRo54sVc4k+TeB+Ij3s1sdyr7UGjmUqEVMvLuvb5GCblZ/0kQGkQy6DUkVPyP4v
 DdX/Joaw2WuKkBHulR9QvAer5pM0pDO+ET1JDLWJbGGDHVMNihfbrMqPdG9pixJeyc+4pqQP/
 g2Qsy2eKI2MeznLfLn62kSRzC9eRxIoBMU/AKOCi3m6Le0S9/06ZqCQfS6n47WhfIcXcbf56a
 9s5A3qoIQZ6ZAPtQaJiNe41EfSSua54iwecjV+w==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Jul 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> >>>  Rewrite of the remainder of "git bisect" script in C continues.
> >>>
> >>>  Expecting a response to reviews.
> >>>  cf. <nycvar.QRO.7.76.6.2005230007260.56@tvgsbejvaqbjf.bet>
> >>
> >> Maybe you could change this to
> >>
> >>    Needs more reviews.
> >>    cf. <20200701133504.18360-1-mirucam@gmail.com>
> >>
> >> ?
> >
> > Thanks, absolutely.
>
> Actually, the state was before that.  It would have been "Reroll exists"
> with the same reference.
>
> In any case, the latest one broke build of 'seen' and I had to
> exclude it from the day's integration.  Now it should be listed
> as "Needs more work" or something.

I missed that it broke... sorry, these days I don't get to watch the CI
builds as diligently as I used to.

I'll Miriam so she sees this.

Ciao,
Dscho
