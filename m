Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC22C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86A5920786
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 12:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TTqqdSDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHRMaV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:30:21 -0400
Received: from mout.gmx.net ([212.227.15.19]:47777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgHRMaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 08:30:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597753815;
        bh=dU5sn+D6CGZn9g50eZFXYsHC1sZqR2qxtyVJFYpix+E=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=TTqqdSDImvljSXQPLWtu4kt7qW2tMT1IG7Lq4p7tUq388cy++Rsnf63JH5Mzb4RTQ
         x98a3J59CnwQnMwCW1TB5IQf9wg6aATMgz5duj+EnqmDrnR6JzCJ9V3+5wLKu6KYWP
         1BXGie9lamigEKWX6vS/GCyltwRAwsFZkXj1NwM8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.213.201]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1poA-1k5npf1XAW-002GVT; Tue, 18
 Aug 2020 14:30:15 +0200
Date:   Tue, 18 Aug 2020 08:39:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 0/2] add p in C tweaks
In-Reply-To: <pull.702.git.1597670589.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2008180838430.56@tvgsbejvaqbjf.bet>
References: <pull.702.git.1597670589.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uuLXLypX6Hp9R+lACppd5fw9ma8AOeKnJPNfiFlvV7zBCw1qOgr
 o4cW5qOz/nrfqmtuqdvIf38xrvoU2G4ePwNiQWp86eWgN045tXFgXXvQEkNFwhNIF6yierr
 Rr73tNT/gcXT634KaMg5F89idCCWwLlpnOmRBp/i8G9fq79f/2DveQp22j39N20XCAmywcJ
 wn+Odhj0ga7nS2fZPwX2g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rQNQERjqjm8=:ujCYv4t+PKvBSZeOLbmkwW
 m/f7RJ20HEgNrp8S9s0pNOFoCEiCNhk4lGSJjgfpyX79p80GdZSgTyTjM4UTtsGqaTePOoWkO
 D5s98FdS9EoIp6642ChUs9QNmUJfVb9ngsA0nTBj46t5GSLBOxV6bTCf0ABGn8BH0NEPThgSm
 lBwRPidIHmIULd93ioKlnIzRdyKovRxBJr83Tj1p5gDsoMiLbGAqlbVZIot8Six2CuroKArrc
 DwbCKPkgT5U20Cn+25Q1l0bqF6sJY1WpWJN3NDXzKnB6gD+9sMPuknNvSyb8F+3BP/o0m5bFc
 B1IiHMhh2VDZ/BfS1txAmKBBcqXUvTzU2VkP7ximUYJmB0ZO7MZ0N8pdcA5VMwGcFgkujjJp2
 sIWB2Muae78ve04jn5ZDhkZuwS2YqsN9GrhcBFnA4tJJc4g/Ea0dbi7i/D7TmeJDrDE/djNT4
 hhkU79kny3j5p1lyp8sRC+j8j86k6V2Aav82AMxTSbn4/zeDfaVW9b3X9BYhWONDziNoc6zZ5
 oLjhZ9+foqFpBb5aF6tqtr9ttJzeCyFQiOay7c5h36twSDdzFQ+dIiKUKmDEX+RF3Nreog/+w
 IYlrYFtDoztXOD/jZvR44PFrkLlq1hE1BGCYSMhheDq3NmT4omizHonvPHRg9X16OZy7YJtXh
 rDsKsWO+95osH9Q+EuSM5GCwtqGY/Htpbpysr6BakPxkeQOQqGmsNXkwITuL2CUpyp5rL51/X
 fPJQFXRS3YIHxuMLMCJAXm8FWZQSnvABKM0LF7bghzYP26WA5UxTV3ZCMv/PGj652PhpE25ND
 uwcN6x1U5KoY1au9S86W5AoELkRibUNkYT04KqfoMnnVtY64UThYMP9jGPtGGgBxXJ6A0lSpJ
 xrzgorUmY+a8I3Zf+qegzubaUUh5vQaAaqwYZTKgDdui34EGgoDQ+3btalfMRxx9zBYt9JMrU
 V6X1A3wpr8NgarvrKiQCUEeE9oWklK9lTqQJDJDPJ/Km3BNSC4HbPI/+ceHoLmqNMayYYOimP
 Fv8KH6279B+eoknhN533JqwzCxup/A4N9FCbXJcnPcSZnKV2joe+9ylXvDOEtSs4ABwajwe3C
 351OFLaH6FV6SAA5DmcZkrGqkyTlaHELF9tvQ0fg3PfaEHFEj574bjKTuU+g98nl+SdvviCNp
 Sl2HVhu7fVWM9ylG7h6iuaDohi3ABBJqTLwY+sztBSUkUMktucxQy9hVb5XSkcJKvNX3dsMpz
 ifjU52qxMJSkArqTw6M3n9+e6lGFfvKcwwA7r7w==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Mon, 17 Aug 2020, Phillip Wood via GitGitGadget wrote:

> A code cleanup and small bug fix for the C version of add -p
>
> dscho has pointed out that the bug fix in the second patch gets lost in =
the
> other changes and suggested adding the last member of the enum (which fi=
xes
> the bug with handling 'e') as a separate patch. I'm unsure as it feels o=
dd
> to split up the introduction of the flags - I'd be interested to hear wh=
at
> others think.

Yep, apart from this issue I am fine with the patches as-are.

Thanks,
Dscho

>
> Phillip Wood (2):
>   add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
>   add -p: fix checking of user input
>
>  add-patch.c | 67 +++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 42 insertions(+), 25 deletions(-)
>
>
> base-commit: 47ae905ffb98cc4d4fd90083da6bc8dab55d9ecc
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-702%2F=
phillipwood%2Fwip%2Fadd-p-fixes-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-702/phill=
ipwood/wip/add-p-fixes-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/702
> --
> gitgitgadget
>
