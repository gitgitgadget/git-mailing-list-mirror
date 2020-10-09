Return-Path: <SRS0=ku3G=DQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F13C433DF
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9060622261
	for <git@archiver.kernel.org>; Fri,  9 Oct 2020 15:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PVfLW5bn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389345AbgJIPi0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Oct 2020 11:38:26 -0400
Received: from mout.gmx.net ([212.227.15.18]:34397 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389286AbgJIPi0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Oct 2020 11:38:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602257898;
        bh=Ss8Z+KHOJazfy1FWcU8/UpsxUwfLNnzaM5QAA/uO40Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PVfLW5bne8xg9jhYy4ElXivZgrcPqug1LbAynXki+Ms6OiXeZPOfjzXfvEMOe7+++
         ho408Xg9QYnsdq4hxkHzxliQv7Z9wwAWbLdRYYsWIABCljISDqzL4XSnwrr9Tegygd
         NACgCdrUa3cie3brto+zyx1DOfAUhmIh8S5c2hB4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([213.196.213.92]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6qv-1k7r3x1CEl-00pb2g; Fri, 09
 Oct 2020 17:38:18 +0200
Date:   Fri, 9 Oct 2020 15:20:35 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Chris Webster <chris@webstech.net>
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "Chris. Webster via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: github action - add check for whitespace errors
In-Reply-To: <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2010091519460.50@tvgsbejvaqbjf.bet>
References: <pull.709.git.1600759684548.gitgitgadget@gmail.com> <20200922170745.GA541915@coredump.intra.peff.net> <xmqq1ritlmrk.fsf@gitster.c.googlers.com> <CAGT1KpU4Kjv2PEAA7-bNbGp2DFvfsKqABuUK68128xkLjdcEhA@mail.gmail.com>
 <CAGT1KpXz4nFBu2xkVSaoW4DgXc_5oB69MQRQW=365gfgd_R-mQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:+MD4TxmR8wpxpsMMHIQFJcqKrdnOGDIo5zw1JvMs006mOn+4qPB
 Q9aOKqx4VBaGUSibqB7QRIMpwerM0BRaXXgJvLqpJ2RV+e98QUaaYqvPPqGInAmAa6vOjr7
 og5GUWwfkDS7Djk0aRNF1+jKB8vBgZk2uR9QnWye8IXGvyUWDPrqJSvnrJpU13DeYbncWkJ
 IIUaMfdUWKshgfPEspB5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nle9I5Gqz3I=:9xMY1gkRilK7q6zJbfgrQH
 Z6hej8NPMF2bbzPJP2LffQh7IO9YdDJ+CXrrj47gCyJIBNJFq8Hp9/7qOBJ6knr4e7XFNfqTl
 cPkvrrJpJbcjyWrPS8DngnLPfHpzJmsNDwTItrgBFJajLdDpprXf9j454R8GFc1e1yFc/+Jn3
 mfmBwvkh/29tDLx6kjXeykB4SCwuLmTN/b5YP/G9mYCW4tyoSCyVtOpaE03IBbp2JVyYFuXs6
 Q1H7nuMAenOd4cMQ2CUTJapSxEYvV2BxlNVQmmzJ/RI6czEDhlr1w0Q42atIU9K3wWDDaqen5
 YCsi9y4DdA9vix3084ZEiEgoTt9hgZidXPG29VgS8ZwNd/g8KJ9FJT0YdAAFAXaJlzLI4qVBR
 I7bC1mEryo4+NozYiCOQuyvFMjaRQB1bFjpHIm9sPitebbd3eA3NLCqJM8cDkIo+XTQijSmk4
 pLLMBxObSpWXX6pi+N/NE81+LhHUN/qQLX9rAyliQDYmkbDOr9Uc4iOgktZfyo3OxRjRdCi+R
 aY78M68Vdtl8VRWs74DC65cOUPugiA0/naRb5BLyNg5cwqQPALptn3EiDcVyA/0oCbEqMRyKX
 DSz6nBOECZ1qd8/wu53Bk2Q3MEiZLo6GOdGLS/s8swmn6lfPG94aoW7QliYlfPpRMm33Lmvb0
 SVdMVxigOKhaSi52tW3GE9ZAXY4RULczASGmnMVryn78q1gBpdzU/AhRmf/VyMVLJRwZvCxAV
 5dPyIJKfYzRZUHXqIJilOC2cyEsozLpXxbbKJctLXt45N5IGEQp+w/irWkXZ+cHUBiFppexMq
 adrh5mHQ0U/SWqaI4HwBadSuXSbYDN3hfNLfoSDGnsqKUWtnhrsnCEih9JZGc6kYnnqrroLWf
 dGj+gk5AKTAvzhxz3tWEwj0QN187qAw39/Uvr1FR/AtRS8OlXRipTOEVsYm/RFpGwX0Hyc2I9
 JVyb/8qd9f4LUq5XL5onfSwaCcScjY1ZRU41+LCpdHbSEceJMZWA4JjWpXtPjJzWrnXTPgvJj
 rIDgXs/kYJJUIWbR8vESmZyB+hgPb7J2EU9vwwYSZGILNe8smj8uNrmfYHHqVrcINOO+D+VsF
 e0qWm6hTSIpi6PaXiQbf5BOCKROTAoF+gTp4+Dj2nCjV3suzFl5iPg7QGmRFNvC3RrLpvIyLq
 LmpDCJ2KVg1znM0wxAajCBkH6A79a1N8f4i/p2Fe916YdvWCIInvel1jNQphzgn6VaSqXCr5T
 5HJcYTeN0/85D4dtPppay3LQChUqG4jVbV4BS5A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Thu, 8 Oct 2020, Chris Webster wrote:

> Is this waiting for some action on my part?  I thought the question of
> running on push vs pull had been resolved (in favour of pull).

FWIW I agree that the current shape is the best we can do for now (and of
course, full disclosure: I was the one suggesting to restrict this to Pull
Requests because we know exactly the commit range to check in that case).

Thanks,
Dscho
