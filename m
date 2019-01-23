Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB9FC1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 23:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfAWXjJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 18:39:09 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34883 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbfAWXjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 18:39:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id t200so1171620wmt.0
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 15:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:references:message-id:user-agent
         :mime-version;
        bh=2PcyFk6goKX08btBVxoDUYrg9D6yGswoTOQCMMPSyaI=;
        b=tFqd+Nw4uIXUJDMFCxFu8k+9Y++6tAWqaOsdJk6IDZfvFEMo4qbRoaFBOyp7NaTMrE
         g2rILQjSDFYsSmqD0SE/F/7ctpddNCZ/I7s7sA5QPZex5girbdxuyZZ+ScGevwei+UdP
         kwGOVJ/1rnSB70RBqTcDStVNNdI4gsySa3PG0WabVUb1KO08JqyOLOZnz7fqNnpktFaG
         KLCuBO4ANAZbRwGFUeNL+SZKwIOi53IWVs9jPa3S1drFv8SXDST+Ziy92bngYMyhbqJl
         EHxBhTI3zh80tWSrCT8vCxAsS1iJ4aEgPmKhCC2zVUm/mFbMEYoP5jDOUS6bTG8fAnnt
         Nw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:references
         :message-id:user-agent:mime-version;
        bh=2PcyFk6goKX08btBVxoDUYrg9D6yGswoTOQCMMPSyaI=;
        b=aAVJ88e/6zcp3d3Pm/wnu7K4L0JXpq7lPWYmZvxsouvNQUz7oi1xOEY8PfUGWxLZXL
         BxpT82mw5NtrEwqjscxLXX6Dq8tGF7PN5zeybyOR5RgpmsLmW+WsGnXOm0Q1FcvBxvbz
         +HDlPTxiATWMEx1mw7Rw1rcfDleKSuTgkkv0chZnXsXT6BI57t1lk+JZBugBlRGwksBl
         c0AYONC7JqnVH9vzrFz08hOBfSGJS/4hbZLvoABHIfve9RRT6g+A0FQ51pXQPtVn9YXg
         0HcyiRdNpy5rxIYkRgC69YDr6nD2hgL9I9GhWyhRSK5li37Bb021XajoF4b6eLnIBuWd
         QQgQ==
X-Gm-Message-State: AJcUukdh8yjcxZaWOjeGQsgl7wWk2pyl4b3giQr8m/TfsaPUbRhe04hk
        z907LC0IbHR0Gsz8IU/xR/Q=
X-Google-Smtp-Source: ALg8bN4OUXjzPiaO4XjVrbCMn0XHMpSS1VQJbsXmjINVZke5xkVQN4+//4P8qT7pWFH0GxM5UPjItA==
X-Received: by 2002:a1c:2e0c:: with SMTP id u12mr123978wmu.81.1548286747279;
        Wed, 23 Jan 2019 15:39:07 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f191sm14743240wmg.12.2019.01.23.15.39.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 15:39:06 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 02/21] ci: rename the library of common functions
Date:   Wed, 23 Jan 2019 14:01:55 -0800
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
        <b086f366606d97097007578ba2ad1523827a4dd7.1548254412.git.gitgitgadget@gmail.com>
Message-ID: <xmqq5zuf6j1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The name is hard-coded to reflect that we use Travis CI for continuous
> testing.
>
> In the next commits, we will extend this to be able use Azure DevOps,
> too.
>
> So let's adjust the name to make it more generic.

Yup.  If we do not like lib-travis, it is possible to call it
lib-ci, but because these are all in ci/ directory already, there is
no reason to be extra redundant.

Makes sense.
