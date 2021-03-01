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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07441C433DB
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B48F960235
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 22:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244784AbhCAWHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 17:07:37 -0500
Received: from mout.gmx.net ([212.227.17.21]:34759 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236638AbhCAWEu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Mar 2021 17:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1614636191;
        bh=PNAmTJdAK/74ygJM48gWdZKnG8GVSBIP6OlNR5nv1AQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LXxOi9IXk166b3w9gARLmMM88Bsh0bs/+KEWN38nWwRTvxE9pi5Z0sRBKq5g6UjU4
         Y7UIIfGt0KdRgHD5C3xAO8Cmve4Cu7dzpofs4208w2Jh3SVQQSzRhyJmiw5m+N6Snh
         KLrguhpHMbQKVGRi0dOGE1L/WUm/fGcZhA7xHNmA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.162.2] ([89.1.214.35]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MV67y-1lOzaz0kmE-00S8Oi; Mon, 01
 Mar 2021 23:03:11 +0100
Date:   Mon, 1 Mar 2021 23:03:08 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] t/perf worktree improvements
In-Reply-To: <d6edd2e2-a1ae-bdef-7e6e-7c1984903a49@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103012302490.57@tvgsbejvaqbjf.bet>
References: <YCwnPVFsYDa0SNmG@coredump.intra.peff.net> <YDiesofYW18Mzd9Q@coredump.intra.peff.net> <d6edd2e2-a1ae-bdef-7e6e-7c1984903a49@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cJct/MPQ5JGm0xF7nLyRUVjlOYnFqEuR/eI2yxYd4l7l7Bls5zA
 T537nyd9UupXLw2AxyPOeTchMxv3XG8sICADckpcBAt6GvaA6G/m3WL1sWG9LWWNWhLH37S
 z9RHImUY4hNiMMCphukO4g/w1XNIFsbr43SWCAh4UEIsH6KGq4caPR6MDn8k9YXTEpDiStb
 AxN+/wbTEEjalBRbxdetQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ga/xaZ5NkuY=:34t9gb0NVDE2z6FUpVcisb
 IRf136NnNdelBmfq7SBtPo1cvKmMo/U2NCHeoWOkDX4OypylesuQCrck8BgsTWn+m4f5H8gox
 ZYw3qaWh/nTA3QT+aQkbnUA3F+gH9/gLJYopOUYp0LWfxK30hTkge4ZOckwOz1PiA8a3sviqW
 jcm/0g7AXtWyjOp4qne4aU1HNSG+vYPlVMkNqUZJetL/JC7e/y9afCe9zw/0v4jUnyERA7xVQ
 F3Ggs7MhzBzyEFyMFmERWNw7V92edEO2K43GteUqBWro4oKjSyiKkNTaPkrijwb2XfEcnR0M6
 9NBf6FV3JCrGclKMFDrIxJVbOHP9sdhhMaAJL1dk/xmbkXxkOcTSGHwoMCUSkZ8Ah4lmM5nrq
 3RC1g4Abg5LQ3QLt9yyNNSjpbQ+S6IP7L+sfucFDoR8bDqHGOmKZKckkPWV7YGeY7UTFBrfYf
 JaayX3eeWNv45wBzWZlIiwDE21lkUgIuVQs1S0NqkvYDZ0rz8S2e1AGbxF1eil824nV/X52zP
 +KLG9eHzUusl+caWldEXppCeTjQLTWfivgSampvaVzotb6Y4HKqO1hofYy5loxEIm9mTYlHaw
 107s0LAuyS6LlwdevEvTGrY6bejvE0dsIIan5RvhcqJhxZmNFzR3FAV6qD7jHs8yDn11PeiVk
 yxV6dyKFxizvygWrqxyAtgLRewhl7o9jtH1u3k/zP6Un9DeS2AtjdaqNjjiEYL6y8cEOeOaaZ
 qu8WTfWd4kduAC1biuRLL+tWUsZZ29dHSwHC5UaciqxjpKPsKY2nu/CZJ6fT/GGPXyQyOGEBk
 5cdTk3xr+XLXrxa1DGrpfLUMe/MYg62fmIwLYZw9JAaqiwFxk9uFNQcMFp/RJIwLQlLn5eBE9
 wYVf+eFnNxTLdSzaeIp/cLGmpsXmIJIHSf5z8tsiM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Fri, 26 Feb 2021, Derrick Stolee wrote:

> On 2/26/2021 2:09 AM, Jeff King wrote:
> > I don't think v1 of this patch got picked up at all, so here it is
> > again. There was a question of whether we could do the much simpler
> > solution discussed in:
> >
> >   https://lore.kernel.org/git/22378ce3-6845-1cd9-996a-8bdc3a8b65d7@gma=
il.com/
> >
> > But I think it would be confusing. So patch 1 is unchanged here from v=
1.
> >
> > Johannes suggested we could add some extra protections to avoid
> > accidentally modifying the original repo. Patch 2 does that.
>
> Thanks. LGTM.

TMT (To me, too)

Thanks,
Dscho
