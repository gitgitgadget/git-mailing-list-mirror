Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F20951F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966014AbeF0Sr6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:47:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39441 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965931AbeF0Srz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:47:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id b8-v6so3035155wro.6
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HtLQuPvbr/nhlNWr6414m+0tvsmLbXLwLi3M1HTcy1E=;
        b=P28egqC8/OJGsI2pWXPLCp5W0vasr46TtVVa3ZHeNKvZuDyRtZ2pHX9oXgXeOmnW6r
         lZq6Wd2R7DWhuNXhfDodDtaWH3twlBPBuvejGhsIojGFyT/rIM2Kz13MsiGUob4eBsx9
         UhuC9CAqV5rVBNsYMfXygy9hVEOajFJ3uACV6tPg2A2PLpFDtcdXAQ82Y18fTynwlY7m
         up8hfCX/ZMxDBYE1hGRnkwiVrV2iOyB5eb+hcAxCBRZQRBUTqONF4p0ss/Ul4+5rnExg
         emh31eQJH/kIOveQTEXfFrisivcG/mkmzQAW3a/eSSsTP97UMCj97/ZM3E/8aAtmFBhR
         6d8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HtLQuPvbr/nhlNWr6414m+0tvsmLbXLwLi3M1HTcy1E=;
        b=Ddqj623cNp757BgQVIbF78BFqZfqt+bG634zdyzyOms7dFMmkFert8SOVRJBGaDAeD
         WPALxwyF9QqygYiUPRnZeBEKYiAt3ndC0VAMOu6UbL9Z2ra/jJpTv70nyzgfd3VSHzW3
         NOEnqenA/QLInnclScXdJ9Q2XALCFzi0OWTg/598huTw/hEJrT79MEKhe+ffyIEWrEtw
         TfEH32vPI6jFlSUraVTFEPgCV6hFclEeJfk5V1trKc7xvsffKSRX5UYvuvgVTMyzBD8j
         dDBaQWYTIqf+YZ5gflulTlyhGqsfbImMchdNsfEivkGHGfzLQ6HYPUxAmCaLNYN0HSv0
         geFw==
X-Gm-Message-State: APt69E1Q85AUrx0CS9D0llvbZLqny/60P/BLGWXdoFeZTIqwbGMhlKpk
        8YXpwQCi9r/SiBoBk/uB8YM=
X-Google-Smtp-Source: AAOMgpcONM3HfT5kP0sJS7LKJdme1P3LDIeiRV8Tn3x8eWy05tAVbsrVutajfPhpuj6EwmKJLla1XA==
X-Received: by 2002:adf:b8ad:: with SMTP id i42-v6mr5534106wrf.163.1530125273866;
        Wed, 27 Jun 2018 11:47:53 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m10-v6sm3591178wrj.35.2018.06.27.11.47.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 11:47:53 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        git@vger.kernel.org, joel@teichroeb.net
Subject: Re: [PATCH v6 0/4] stash: add new tests and introduce a new helper function
References: <20180405022810.15796-1-joel@teichroeb.net>
        <cover.1529943789.git.ungureanupaulsebastian@gmail.com>
        <nycvar.QRO.7.76.6.1806262357400.21419@tvgsbejvaqbjf.bet>
Date:   Wed, 27 Jun 2018 11:47:52 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1806262357400.21419@tvgsbejvaqbjf.bet>
        (Johannes Schindelin's message of "Tue, 26 Jun 2018 23:59:43 +0200
        (DST)")
Message-ID: <xmqqbmbwf4mf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Mon, 25 Jun 2018, Paul-Sebastian Ungureanu wrote:
>
>> This first series of patches does bring some changes and improvements to
>> the test suite. One of the patches also introduces a new function
>> `get_oidf()` which will be hepful for the incoming patches related to
>> `git stash`.
>
> For reviewers: it is *my* fault that this patch submission is a bit funny
> with two 1/4 and one 1/6 patches... *I* suggested to not send a 14-strong
> patch series but split it into three, and then I failed to explain the
> correct invocation to do that from the command-line.
>
> My sincere apologies,
> Dscho

Heh, what is more useful than apology is to tell us which order
these three (apparent) series build on top of each other ;-)

The answer, IIUC, is that 

 * oidf+tests come first, then
 * apply/drop/branch/pop (as these rely on oidf) on top, and finally
 * list (as it wants to add to stash--helper that is a new file in the middle)

When there is clear dependency like that, I agree that it would help
readers to emphasize that these cannot be applied in an arbitrary
order.  It is especially true as the second part of the above _will_
apply more-or-less cleanly without the first one, and then fail to
compile due to lack of oidf.

Thanks.
