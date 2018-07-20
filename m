Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1266A1F597
	for <e@80x24.org>; Fri, 20 Jul 2018 17:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387909AbeGTSAW (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 14:00:22 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:37393 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387855AbeGTSAV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 14:00:21 -0400
Received: by mail-yw0-f181.google.com with SMTP id w76-v6so4599522ywg.4
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Td1/lY7X8Xn65c+e9slFRc9/qHQF4XxhBGdKv/NsbzY=;
        b=LPJ8mCfW+EewAGkxvsbmlXp89QYNtAO4KrfYCV3T/MFr52zOLvMiGEVwCuRV/ALIN3
         F9PYpOrej910WDkvaJr81L99HUS3OIUKkvvGAhSn8XGFVGA7YXEgQyO/HE9bEnni+qv1
         hr+i2eg4shFkterbO6vQEM9cZ1cS2ACaxKxMp0nnjwORvbA3n5XhC5z0uOl44hFNuRB1
         fyw9PV7TqJbZ/xFVPr/Su1do2g7VWBVzrQmIujt26PMO/WfjbE8+JDQKCcj7vLnWV9GL
         CdgIXIj7GSi5q6uE/LElEHKfbaZiRRC2QXkeIiSDqDJlUTL2cFOtnnV3Zf0OiPnMPiL+
         KPaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Td1/lY7X8Xn65c+e9slFRc9/qHQF4XxhBGdKv/NsbzY=;
        b=CMbSZQPdLepsssznlnAL6N5yCYACL9Pi5zUN6wloqnY9SQHSxlLPgI/PgTdXMGeSZy
         hvGulDfiSpwyL38cA4jgJFFs6D9a2p5w7RE0CC66E53Tm1B7R/2cFv9LXjmYGu5wgrVm
         7bUZthi9qwVXdB5iM3YcaWUuHD4JhvB0NZ8f8O+okTC/p0Wmf0AXXwlqyXQKJhdJ+fmJ
         G259dTRtwiyGVxDd8gvAmKQ/hjcqHHp44rxsn4VFRcK3EfAul14jOOM9YUdyh0RpWxe1
         lszHJJr0HEnEjSUgHvrIOtF1AueySX9Drmx8pZtIxNYRWfdJ5QX41ldMeBxes/qBhvrW
         U8nw==
X-Gm-Message-State: AOUpUlELYcMtQzHk7VpDayU7XYPTvSculyPZM1tg5clVDkJ82bNbH6US
        WoTS0d31ZMMJnVMoLRo3+oXOPIKZRtxP/JBOK+TbLw==
X-Google-Smtp-Source: AAOMgpdUmGY/7SIi6FaYWwEFYZxO0KcNPyT15QTQ9dlh3J4Ju5oydlAigM6zU3+/gwxeVDQyxNV+XxwFPDyK+vob7gE=
X-Received: by 2002:a0d:d342:: with SMTP id v63-v6mr1438120ywd.500.1532106669224;
 Fri, 20 Jul 2018 10:11:09 -0700 (PDT)
MIME-Version: 1.0
References: <pull.10.git.gitgitgadget@gmail.com> <20180720163227.105950-1-dstolee@microsoft.com>
In-Reply-To: <20180720163227.105950-1-dstolee@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jul 2018 10:10:58 -0700
Message-ID: <CAGZ79kY28vcs5TN9GtKd439vaTt38Qtwv8Lw0zanDaR1OmsTLg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Consolidate reachability logic
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Derrick,

> V2 Update: The biggest material change in this version is that we drop the
> method declarations from commit.h, which requires adding a lot of references
> to commit-reach.h across the codebase. This change is in a commit on its own.
> In addition, we have the following smaller changes:

Is there a remote available to get this series from?

> * Use 'unsigned int' for the flag variables.
>
> * Properly align the here-doc test input data.
>
> * Use single rev-parse commands in test output, and pipe the OIDs through 'sort'
>
> * Check output of parse_commit()
>
> * Update flag documentation in object.h
>
> * Add tests for commit_contains() including both algorithms.
>
> * Reduce size of "mixed-mode" commit-graph to ensure we start commit walks
>   'above' the graph and then walk into the commits with generation numbers.

A range diff would be nice (though I can just look at all patches again
even if it takes longer).

I notice this is not sent via the GGG, but via git send-email?

Thanks,
Stefan
