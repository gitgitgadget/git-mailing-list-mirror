Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2362F1F42D
	for <e@80x24.org>; Mon, 14 May 2018 08:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbeENINH (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 04:13:07 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:55479 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752534AbeENINC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 04:13:02 -0400
Received: by mail-wm0-f68.google.com with SMTP id a8-v6so11782317wmg.5
        for <git@vger.kernel.org>; Mon, 14 May 2018 01:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NH7qMYfLeWeszXlPt0fFR/ABP9yrZSKSRoMqBJ9pv6w=;
        b=N8eHMvoZXyhmnUbUupxzo/ZG2i4u8d350IhfRn2Q1TOk2FQ6DvyS/r8lG7FnPggQQO
         9q4BdApFQIXvnasEjSojVutIGTGRU3pjjG5wEJae3jsqGHSGaRQkXX7xwMzj+cDOV8f4
         zBs49z0iIVkhjFPYnV1AWv1PHLu5OwtGJIC93JBfs3Szp333ZoR40zsrlZbmemB/dea9
         eMF0lVJAC1wA+Z9MW8AgDu8g5VesH7n5yydh5shmFWFrfxVSY3GogAx628v7ootdIo/Q
         9ce6kVw5kmHbTxSCK79ybUH3iBr7o29NlKMNEDXBBqJKopthQawOEGw6YxPXTPGYX2Fw
         VhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NH7qMYfLeWeszXlPt0fFR/ABP9yrZSKSRoMqBJ9pv6w=;
        b=btoAgDx47rmLxO9uJi18zOQ3rSn2pRyFn1qrBx7XDMG4wqYNsmyIxfGY4PnRMtGNCy
         qYzWKnu2vlf4EOby+HBl11zdIEkj5R4bet4vOu5zdU32jz1I4J2GEkPGjmQF3Je+AGBB
         SJxtg4UY+A6SKKmUkeaDwGojw8TjUJlF6vJ8gCb6N4f7F0KjE+Hb+j3WF2Xiy9H3LrSG
         xSoyDTA5/v0ktCv3dZtuoE5j3ZQQdT6dWXNghfxzh3dbP5X4NNViQg9DAWI9l1xCNYrN
         aVp7rmRSFntSHs66Zhu+caRGKHSyBnp/oPDKb9a3j+tHpMRF79qeBof4wt8nc5PVTVNY
         vNtw==
X-Gm-Message-State: ALKqPwdMUP3Y81tibZ8qocU6kR7Y3lOXrvslTEh/9+7RLr5c7uGseZpf
        7wzQo3UrfrYlduYE/AYzwQc=
X-Google-Smtp-Source: AB8JxZr2Ou/g4FDAGw5VSKrO3tW5xW8OhrMgFI52ZQop+j5wEpuBw9o4thGFxOb8RYJCj5xfYk5o7w==
X-Received: by 2002:a1c:be0f:: with SMTP id o15-v6mr4682952wmf.104.1526285580978;
        Mon, 14 May 2018 01:13:00 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y81-v6sm8313570wmd.31.2018.05.14.01.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 01:12:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v1 0/8] Introducing odb remote
References: <20180513103232.17514-1-chriscool@tuxfamily.org>
Date:   Mon, 14 May 2018 17:12:58 +0900
In-Reply-To: <20180513103232.17514-1-chriscool@tuxfamily.org> (Christian
        Couder's message of "Sun, 13 May 2018 12:32:24 +0200")
Message-ID: <xmqqr2mebqph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> This is a follow up from the patch series called "Promisor remotes and
> external ODB support" that I sent earlier this year.
>
> Following discussions of these patch series, where Junio said "a
> minimum s/ext/remote/ would clarify what it is", I decided to rename
> "external odb" to "odb remote".

In "external odb", "odb" is a noun, decorated by adjective
"external".  I would expect the same would apply to "remote" and
"odb".

> I am still open to another name, but I
> think that "odb remote" works well with "odb helper" that was already
> used in the series and is as good or perhaps better than "remote odb",
> as a "remote odb" I think would be easier to confuse with a regular
> "remote".

As long as our use of "remote" as a noun is understood as omitting
(an obvious) "repository" from a noun phrase "remote repository", I
do not think there is any confusion.


"odb remote" sounds like the phrase is about a noun "remote" (we do
use "remote" as a noun when talking about fetching and pushing, as a
short hand for "remote repository") that uses "odb" as an adjective
somehow (e.g. "this is one of those remotes defined but not for the
usual fetching and pushing, but for accessing its odb", or something
ilke that), which somehow does not sit well on my tongue nor in ears.
Perhaps that is because I am not well versed in languages whose natural
word order in a noun phrase is noun followed by adjective, but I dunno.

> Another obvious difference with the previous series is that this
> series is only about integrating with the promisor/narrow clone work
> and showing that it makes it possible to use more than one promisor
> remote.

Sounds like a sensible "incremental" approach.

Will read the patches and commet on them in another sitting.
Thanks.
