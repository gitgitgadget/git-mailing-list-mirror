Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDF491F463
	for <e@80x24.org>; Fri, 13 Sep 2019 13:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390245AbfIMNly (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 09:41:54 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:60189 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389415AbfIMNly (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Sep 2019 09:41:54 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 7F5684F3;
        Fri, 13 Sep 2019 09:41:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 13 Sep 2019 09:41:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jramsay.com.au;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mesmtp;
         bh=5oVa+yBx0l2XVYBe9Ra5fGhm+IEGyKDmgS+kpfyNx9U=; b=l7sW1WnMBrof
        cOxjsO4U0GPhJLd3YQBqTeo7pKLgsZuxx3g5heOT9Z0UXm+mIVE0UaGkqSMPO/ok
        uKGBT/RzSxDD2jnAhQVjev8dAx/C5NcY5iNUcqDSDCSRngjST8MtOYTZHZSs4fJU
        ApDStx0fvcqMvfPGiBsJqGokXBGDoY8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=5oVa+yBx0l2XVYBe9Ra5fGhm+IEGyKDmgS+kpfyNx
        9U=; b=ZUL03AR78n7LERywxHN2XvD+jChUAIXbFjZVIWVkBqEmX0lwIEtPRF6lH
        PpDQYZk7OHu7jOfPlIDHI4FNwKTifBTzbWo/VY/dEGfpaNYtxZXX/luePLfhasdc
        TYuZFFDQ+I7K6+kPqe118zybrStY8FuYRlxFqcMiesOFatHGSkLOzbunVD7wSHfl
        RGvgDB9GpGGUBnMC5Cyxw2wyMPiFFCniwh8JiguV50kSAKlfXt35GX32ltBjxint
        KlpiKKQlppL5LpRiZSF6ZJrZ1q2GbITO1l9yk8/BSd4vscggmggqihnzvQYYk+Xm
        LQXnSngeoiaiKqizAf64N/IMFbBxw==
X-ME-Sender: <xms:oJx7XSSQ_dMCeKt4hIsQfWTkmgGn17sk9jMi07B21GClEs6jrHHNwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtdejgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefhvffufffokfgjfhggtgfg
    sehtqhhmtdertddtnecuhfhrohhmpedflfgrmhgvshcutfgrmhhsrgihfdcuoehjrghmvg
    hssehjrhgrmhhsrgihrdgtohhmrdgruheqnecuffhomhgrihhnpehgohhoghhlvgdrtgho
    mhenucfkphepjeegrdeigedrheehrdduvdeinecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjrghmvghssehjrhgrmhhsrgihrdgtohhmrdgruhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:oJx7Xbv-0PkejhoYTqIgTu6BlQZ5w8xufXgEwBbhr6fbfM8uDu97QA>
    <xmx:oJx7XYW3-WmZUkqMxFx58vjv5Bk88ZL5j7xLoQ3xn1oJTkno5hGxag>
    <xmx:oJx7XXmyrHB-4rR-fU_oDNU308StWk3SZQtdDtsXXx1Jx8oTmYV2VQ>
    <xmx:oZx7XeqtHGC_UJsnpM0irCH4CC2KzBy5rY9Xqbw8nLXngHjGJmri_w>
Received: from [10.1.1.5] (cpe-74-64-55-126.nyc.res.rr.com [74.64.55.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D62480064;
        Fri, 13 Sep 2019 09:41:52 -0400 (EDT)
From:   "James Ramsay" <james@jramsay.com.au>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: Virtual Git Contributor Summit
Date:   Fri, 13 Sep 2019 09:41:50 -0400
X-Mailer: MailMate (1.12.5r5635)
Message-ID: <BF65DE67-42F0-4BFD-A2EF-E12DA48B8B4F@jramsay.com.au>
In-Reply-To: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1907031429420.44@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3 Jul 2019, at 9:01, Johannes Schindelin wrote:

> Team,
>
> I kept talking about this idea of a purely online Git Contributor =

> Summit,
> and it is finally time for action.

Thank you for organizing!

Yesterday, Christian and I took notes in the doc below which might be =

useful for others.

https://docs.google.com/document/d/1Yp6tz_JgUYjoofTDogtosLsdykwiAyYu9yM42=
yTuFA4/edit

Any additions or edits would be most welcome!

Best,
James
