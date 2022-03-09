Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FADEC433EF
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235565AbiCIV5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 16:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbiCIV5u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 16:57:50 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A3411D7B0
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 13:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646863002;
        bh=ImvWDUtfWuSOZoqJaNT99Ro+RjcqXfjzQ+hYQ6ypgj8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UYk4pjrLVeTyncILwC1iLxdusVAHtWR4I+AZ9y4hSw/tkIG6EfZnmAUV/DwTKT1Ld
         D2x2mS2OvontaCklgl8D1RuXtX8sO1zlrStLqDrTnJz9ND38Q6fSPi+ipLifvHbey0
         ArfuZUciRSit8/Q8bJF1rmMUigAF9eObMrTT7JXY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1nQQOu0gp8-002rFz; Wed, 09
 Mar 2022 22:56:42 +0100
Date:   Wed, 9 Mar 2022 22:56:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] name-rev: test showing failure with non-monotonic commit
 dates
In-Reply-To: <xmqqr18515jr.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203092256070.357@tvgsbejvaqbjf.bet>
References: <20220214210136.1532574-1-jacob.e.keller@intel.com> <xmqqr18515jr.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:8GWueUffUDf+zJ4mnrmQ/tY5EPOXvPAmlxYCelApIxt97fMm8F7
 s1LZxJ6Isaen/HxCHksY3ALrHOw5ozkCW3Rlv2CfYVQnY0SuE5U9T1+zo/Q6/GkEWyXaufp
 12OAUlZNTqkVow8KtwClphScC4C/qftGRl+OSEYizGWTB+ws4YmttVSn4E9Z06KpZ/u7mKy
 OqSBtwdHxkdqBgSXMx+ow==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bfVORE89zsM=:irFRBAxjspPeAQThTbsD9x
 xtbi+xhQYaOfS4GSaZZ6KAKrOEywqCoVVHejn13eQisNxcNBt7EPDGqd8anjo3K9E0+dfUhjY
 5mnPV4Qpi5zw0/AMDdblZFl/ZiJOLhYrwZGobeomzmYaTwHcAW3KtZixyK/bhlrI37Xc7UbJE
 CUnuDBlm7zZMEiNRpcOXMMrMOCWQAGfhZEN6Zp+gCwWYAI+qNVQmqtxWdMUF6HWriP6IHTy1q
 S869G6fpyCc8YWwJgDgKZAu+niV/kGzOqLJkFc9r43hG72v6pJ0089GjJcly/dLU7MmvuUBr3
 +vaMtgtcOJBZTXjwICU2T91DWrbbuFFBtfzgK6qrvxXHt2sGa2jBVA6WEtP8yGK2a9pdnAa3c
 aXXhx3ejh7gFPo5bh1QRAGRrkQYH4KGpmVr0f72wlSL5as5eZZ2JEZuLdYmFFkgDSumSfNUYC
 4y4VN0qjU/vZO6SNJkgp507+T8hjPedgkTjS4J1zbcPTNhXe7fjPwgFTbfG4thU084YtxdtrW
 HwX3G05OYbBbQi4YR/EWLO9cyPXrgQE2roQvYZDk/MZox38nEdO6uV2qB3Q379Ng+gIHM+N2J
 ttaH//X9frsEGqHF4DU3ECEvcsgjklT0AEq3iztwITcPNpY9pbV73xZOzK9TgSn3v9U9azmlO
 HM6jX6VPoVAqO9rbXyMbymhZ2ZgkViOhpwaybBhxBNcbfvVioF7uuOYjaa1+KCsWsMW05N+3O
 QzPVhidoYHDLVmufSz7XmTLAoCN/SuSmrkk4tMv/6Khi5thL0zYPWpZ5+kFiJ43NYOJU2sfja
 WEAaJ9H226rpW5AxT1bcKydyt0N96pjeOyCzqwlTlSaRXN2HrpuqJ4xl1Lv4u3+w80UUKi5sw
 Lb8aoJoaCzYYrec56W2A2twRA4KABzeLjLRXUwa4GThhg3NwvRKRwhpU9GDWFFjnonqjHUgNr
 roZQlAdCCki6aZ2zc0iWMu92uxzTFB+ec5MlBPGrnx3BKMV5HFv5DXUjMTVyt1clNK+SbBum0
 lZsY/8+QfOVka9BMRxopMkmdOdpF2KlMktBIQbY1jb19zu66cRGcEu6DDcWEUtZye8Awwu1JU
 FeeccBeOc8FqJM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 14 Feb 2022, Junio C Hamano wrote:

> Jacob Keller <jacob.e.keller@intel.com> writes:
>
> > From: Jacob Keller <jacob.keller@gmail.com>
> >
> > If a commit in a sequence of linear history has a non-monotonically
> > increasing commit timestamp, git name-rev will not properly name the
> > commit.
> >
> > However, if you use --annotate-stdin then the commit does actually get
> > picked up and named properly.
>
> IIRC, this is to be expected.
>
> When preparing to answer --annotate-stdin request, the command has
> to dig down to the root of the history, which would be too expensive
> in some repositories and wants to stop traversal early when it knows
> particular commits it needs to describe.
>
> Dscho?  I think this is pretty much a fundamental part of the
> initial version added by bd321bcc (Add git-name-rev, 2005-10-26) and
> kept that way to this day, I think.

Yes, it was.

Looks like Stolee had great suggestions while I did not find time to catch
up with the mailing list.

Ciao,
Dscho
